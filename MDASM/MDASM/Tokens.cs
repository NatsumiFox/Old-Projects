using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace MDASM {
	#region Assembly Token Containers
	public class AssemblyTokenContainer : AssemblyToken {
		public List<AssemblyToken> Tokens;
		public uint BaseAddress = 0;

		public AssemblyTokenContainer() {
			Tokens = new List<AssemblyToken>();
		}

		public override AssemblyToken Solve(out TokenState state) {
			state = TokenState.Static;
			List<byte> Data = new List<byte>();

			for(int i = 0;i < Tokens.Count;i++) {
				Program.CurrentFileName = Tokens[i].file;
				Program.CurrentLine = Tokens[i].line;
				uint adr = Program.FileAddress;
				int align = 0;

				// hack to skip labels
				int co = i;
				while (Tokens[co] is AssemblyTokenUpdateLabel && Tokens.Count > co + 1)
					co++;

				AssemblyTokenMacroRef m = Tokens[co] as AssemblyTokenMacroRef;
				EquateFlags flags = m is null ? Tokens[co].Flags : m.GetFlags();

				// implement alignment logic
				if ((flags & EquateFlags.AlignBefore) != 0) {
					byte[] ald = InternalMacros.GetAlignment((flags & EquateFlags.AlignAlways) != 0);
					align = ald.Length;
					Program.FileAddress += (uint)align;

					if (ald.Length != 0) {
						Data.AddRange(ald);
						if (state < TokenState.Dynamic) state = TokenState.Dynamic;
					}
				} else align = 0;

				resolve: AssemblyToken a = Tokens[i].Solve(out TokenState sta);

				if (sta >= TokenState.Dynamic) {
				//	if (sta == TokenState.Indeterminate)
				//		Console.WriteLine(Program.Address.ToString("X6") +" "+ Program.FileAddress.ToString("X6") + " " + Program.Object.ToString("X6") +" "+ Program.CurrentFileName +":"+ Program.CurrentLine);
					if (sta > state) state = sta;

					if (a is AssemblyTokenContainer) {  // oh dear jesus
						Replace(i, a);
						goto resolve;
					}

				} else if (a is null) Remove(i);
				else {
					a.Flags = flags;
					Replace(i, a);
				}

				Program.FileAddress = adr + (uint)align;
				int offset = 0;

				// check various things
				if (a is AssemblyTokenData d) {
					// check if we need to insert bytes to match file address
					if (Data.Count + BaseAddress < Program.FileAddress)
						Data.AddRange(InternalMacros.GetAlignBytes(Program.FileAddress - (Data.Count + BaseAddress)));

					else if (Data.Count + BaseAddress > Program.FileAddress)
						Data.RemoveRange((int)Program.FileAddress, (int)((Data.Count + BaseAddress) - Program.FileAddress));

					// add data into the file and update address
					Data.AddRange(d.Value);
					Program.FileAddress += d.Value.Length;

					if (!Program.IgnoreLabelRebase) {
						if (Program.Pass > 1 && Tokens[i].LastBytes != d.Value.Length + align)
							offset = (d.Value.Length + align) - Tokens[i].LastBytes;

						Tokens[i].LastBytes = d.Value.Length + align;
					}
				} else if (a is AssemblyTokenAddress ax)
					Program.FileAddress = ax.Address;

				// check if we need to add a fake offset for future label parsing... A bit dirty but should avoid issues where program is resized but labels have yet to evaluate
				if (offset != 0) {
					bool found = false;

					for (int z = 0;z < Program.Labels.Count;z++)
						if (Program.Labels[z].Value >= Program.Address) {
							Program.Labels[z].Value += offset;
							found = true;
						}

					// force another pass to fix any mistakes!
					if (found) state = TokenState.Indeterminate;
					//	Console.WriteLine("ExtraPass at " + Program.Address.ToString("X6"));
				}

				// check return value
				if (Program.Return) {
					Program.Return = false;

					if(!(Program.ReturnValue is null)) {
						AssemblyTokenValue t = Program.ReturnValue;
						Program.ReturnValue = null;
						return t;
					}

					break;
				}
			}

			return new AssemblyTokenData(Data.ToArray());
		}

		public void Add(AssemblyToken token) {
			token.Parent = this;
			Tokens.Add(token);
		}

		public void Remove(AssemblyToken token) {
			Tokens.Remove(token);
		}

		public void Remove(int index) {
			Tokens.RemoveAt(index);
		}

		public void Insert(int index, AssemblyToken token) {
			token.Parent = this;
			Tokens.Insert(index, token);
		}

		public void Replace(AssemblyToken who, AssemblyToken what) {
			what.Parent = this;
			int index = Tokens.IndexOf(who);
			if (index >= 0) Replace(index, what);
		}

		public void Replace(int index, AssemblyToken token) {
			Tokens[index] = token;
		}

		public AssemblyToken this[int offset] {
			get { return Tokens[offset]; }
			set { Tokens[offset] = value; }
		}
	}
	#endregion

	#region Assembly Token Misc
	public class AssemblyTokenDataFile : AssemblyToken {
		public string File;
		public long Size;

		public AssemblyTokenDataFile(string File) {
			this.File = File;
			Size = new FileInfo(File).Length;
		}

		public override AssemblyToken Solve(out TokenState state) {
			state = TokenState.Static;
			return this;
		}
	}

	public class AssemblyTokenAddress : AssemblyToken {
		public uint Address;

		public AssemblyTokenAddress(uint addr) {
			Address = addr;
		}

		public override AssemblyToken Solve(out TokenState state) {
			state = TokenState.Static;
			return this;
		}
	}
	#endregion

	#region Assembly Token Value
	public class AssemblyTokenValue : AssemblyToken {
		public dynamic Value;

		public AssemblyTokenValue(dynamic Value) {
			this.Value = Value;
		}

		public override AssemblyToken Solve(out TokenState state) {
			state = TokenState.Static;
			return this;
		}

		public static implicit operator AssemblyTokenValue(bool b) {
			return new AssemblyTokenValue(b ? 1 : 0);
		}

		public static explicit operator bool(AssemblyTokenValue b) {
			return b.Value is bool ? (bool)b.Value : b.Value.Equals(0.0);
		}

		public static implicit operator AssemblyTokenValue(int b) {
			return new AssemblyTokenValue(b);
		}

		public static explicit operator int(AssemblyTokenValue b) {
			return (int)b.Value;
		}

		public static implicit operator AssemblyTokenValue(uint b) {
			return new AssemblyTokenValue(b);
		}

		public static explicit operator uint(AssemblyTokenValue b) {
			return (uint)b.Value;
		}

		public virtual string ShowString() {
			bool str = IsString();
			return (str ? "\"" : "") + Value.ToString() + (str ? "\"" : "");
		}

		public bool IsString() => Value is string;
		public bool IsArray() => !(Value is null) && (Value as object).GetType().IsArray;

		// convert value into a string
		public override string ToString() {
			if(IsArray()) 
				return "["+ _tostring(Value) +"]";

			return Value == null ? "null" : Value.ToString();
		}

		// convert an array inside of the value into a string
		private string _tostring(dynamic val) {
			string output = "";
			
			for(int i = 0, len = val.Length;i < len;i++) {
				if (i != 0) output += ", ";

				if (val[i] is null)
					output += "null";

				else if ((val[i] as object).GetType().IsArray)
					output += "[" + _tostring(val[i]) + "]";

				else if (val[i] is string)
					output += "\"" + val[i] + "\"";

				else output += val[i];
			}

			return output;
		}
	}
	#endregion

	#region Assembly Token Calculation
	public abstract class AssemblyTokenCalculation : AssemblyTokenValue {
		public AssemblyTokenValue Left { get; set; }
		public AssemblyTokenValue Right { get; set; }

		public AssemblyTokenCalculation() : base(0) {
		}

		public AssemblyTokenCalculation(AssemblyTokenValue Left, AssemblyTokenValue Right) : base(0) {
			this.Left = Left;
			this.Right = Right;
		}

		public override AssemblyToken Solve(out TokenState state) {
			throw new NotImplementedException();
		}

		public abstract int GetPrecendece();
		public abstract bool IsUnary();

		public bool IsEmpty() {
			return Left is null && Right is null;
		}

		public bool IsFull() {
			if (Left is null) return false;
			if (Right is null) return IsUnary();
			return true;
		}

		public override string ShowString() => (Left?.ShowString() ?? "null") + (Right?.ShowString() ?? "null");
	}
	#endregion

	#region Assembly Token Equates
	public class AssemblyTokenEquateRef : AssemblyTokenValue {
		public string Name;

		public AssemblyTokenEquateRef(string Name) : base(0) {
			this.Name = Name;
		}

		public override AssemblyToken Solve(out TokenState state) {
			AssemblyTokenEquate e = Program.FindEquate(Name);

			// if an not be parsed this pass, return 0. This may later change to something else
			state = TokenState.Indeterminate;
			if (e is null) {
				if (Program.Pass > 1)
					Program.FormatError("Equate "+ Name +" does not exist!");
				return this;
			}

			// can be parsed, attempt it
			state = TokenState.Dynamic;
			return e.Solve(out state);
		}

		public override string ShowString() => Name;
	}

	public class AssemblyTokenEquate : AssemblyTokenValue {
		public AssemblyTokenMacroRef Owner;
		public TokenState State;
		public string Name { get; private set; }

		public AssemblyTokenEquate(string Name, Object Value, EquateFlags Flags = EquateFlags.None) : base(Value) {
			this.Name = Name;
			this.Flags = Flags;
		}

		public override AssemblyToken Solve(out TokenState state) {
			state = State;
			return this;
		}
		
		public override string ShowString() => Name;
	}

	internal class AssemblyTokenEquateCode : AssemblyTokenEquate {
		private Func<dynamic> Code;

		public AssemblyTokenEquateCode(string Name, Func<dynamic> Code, EquateFlags Flags) : base(Name, null, Flags) {
			this.Code = Code;
		}

		public override AssemblyToken Solve(out TokenState state) {
			state = TokenState.Dynamic;
			Value = Code();
			return this;
		}
	}

	public class AssemblyTokenLabel : AssemblyTokenEquate {
		public bool Updated = false, ForwardRef = false;

		public AssemblyTokenLabel(string Name) : base(Name, 0) { }

		public override AssemblyToken Solve(out TokenState state) {
			state = Updated ? TokenState.Dynamic : TokenState.Indeterminate;

			// if label was not updated yet, but we asked for it, it means it is forward referenced.
			if (!Updated) ForwardRef = true;
			return this;
		}
	}

	public class AssemblyTokenUpdateLabel : AssemblyTokenValue {
		private AssemblyTokenLabel Label;

		public AssemblyTokenUpdateLabel(AssemblyTokenLabel Label) : base(Program.Address) {
			this.Label = Label;
		}

		public override AssemblyToken Solve(out TokenState state) {
			state = TokenState.Dynamic;
			Label.Updated = true;

			if (Label.Value != Program.Address) {
				Label.Value = Value = Program.Address;

				// if label was forward referenced, we need to change token state to indeterminate when its value is changed!
				if (Label.ForwardRef) state = TokenState.Indeterminate;
			}
			return Label;
		}
	}
	#endregion

	#region Assembly Token Macros
	public class AssemblyTokenMacroRef : AssemblyTokenEquateRef {
		public List<string> Arguments;
		public string Size, Label;

		public AssemblyTokenMacroRef(string Name) : base(Name) {
			Arguments = new List<string>();
		}

		public override AssemblyToken Solve(out TokenState state) {
			return Expand(Label, out state);
		}

		public AssemblyToken Expand(string Label, out TokenState state) {
			state = TokenState.Dynamic;
			if (Size == null) Size = "";

			// if an not be parsed this pass, return 0. This may later change to something else
			AssemblyTokenMacro e = FetchMacro();

			if (e is null) {
				if (Program.EnableListings) {
					byte[] text = ASCIIEncoding.Default.GetBytes("\t\t??? " + Name + (Size != null ? "."+ Size : "") + "\n");
					Program.ListingsFile.Write(text, 0, text.Length);
				}

			//	if (Program.Pass > 1)
			//		Program.FormatError("Macro " + Name + " does not exist!");
				return this;
			}
			
			if ((e.Flags & EquateFlags.EatLabel) != 0 && Label == null)
				Fail("Macro "+ Name +" expected a label, but no label was given!");

			// can be parsed, attempt it
			return e.Expand(this, out state);
		}

		public EquateFlags GetFlags() {
			AssemblyTokenEquate e = FetchMacro();
			if (e is null) return EquateFlags.None;
			EquateFlags f = e.Flags;

			if((f & EquateFlags.AlignSpecial) != 0 && Size != "b")
				f |= EquateFlags.AlignBefore;

			return f;
		}

		private int LastPass = -1;
		private AssemblyTokenMacro Macro = null;

		private AssemblyTokenMacro FetchMacro() {
			// refetch the macro if this is different pass. Macro may be redefined between passes!
			if(LastPass != Program.Pass) {
				AssemblyTokenEquate e = Program.FindEquate(Name);
				Macro = e as AssemblyTokenMacro;
				LastPass = Program.Pass;

				if (!(e is null) && Macro is null)
					Fail("Referenced Equate is not a valid Macro!");
			}

			return Macro;
		}

		public override string ShowString() => Name;
	}

	public abstract class AssemblyTokenMacro : AssemblyTokenEquate {
		public AssemblyTokenMacro(string Name, EquateFlags Flags) : base(Name, null, Flags) { }

		public abstract AssemblyToken Expand(AssemblyTokenMacroRef Ref, out TokenState state);
	}

	public class AssemblyTokenMacroInternal : AssemblyTokenMacro {
		public Func<AssemblyTokenMacroRef, Tuple<TokenState, AssemblyToken>> Code { get; private set; }

		public AssemblyTokenMacroInternal(string Name, Func<AssemblyTokenMacroRef, Tuple<TokenState, AssemblyToken>> Code, EquateFlags Flags) : base(Name, Flags) {
			this.Code = Code;
		}

		public override AssemblyToken Solve(out TokenState state) {
			state = TokenState.Dynamic;
			return this;
		}

		public override AssemblyToken Expand(AssemblyTokenMacroRef Ref, out TokenState state) {
			var r = Code(Ref);
			state = r.Item1;
			return r.Item2;
		}
	}

	public class AssemblyTokenMacroSource : AssemblyTokenMacro {
		public AssemblyTokenMacroSource(string Name, EquateFlags Flags) : base(Name, Flags) {
			Container = new AssemblyTokenContainer();
		}

		public string[] Arguments;
		public AssemblyTokenContainer Container;

		public override AssemblyToken Solve(out TokenState state) {
			state = TokenState.Dynamic;
			return this;
		}

		public override AssemblyToken Expand(AssemblyTokenMacroRef Ref, out TokenState state) {
			state = TokenState.Dynamic;
			Program.IgnoreLabelRebase = true;

			// generate fake variables for macro
			ushort[] hashes = new ushort[Arguments.Length + 2];
			AssemblyTokenEquate[] equs = new AssemblyTokenEquate[Arguments.Length + 2];

			int i = 0;
			for(;i < hashes.Length - 2;i++) {
				dynamic val = null;

				if (Ref.Arguments.Count >= i) {
					AssemblyToken solved = Program.Context.CalculateEquationTokens(Ref.Arguments[i]);
					solved = Program.Context.SolveTokens(solved, out TokenState sta);
					AssemblyTokenValue sv = solved as AssemblyTokenValue;

					if (sv is null)
						Program.FormatError("Argument " + Arguments[i] + " could not be converted to a value!");

					val = sv.Value;
					if (sta > state) state = sta;
				}

				hashes[i] = Program.ComputeHash(Arguments[i], true);
				equs[i] = new AssemblyTokenEquate(Arguments[i], val);
				equs[i].State = TokenState.Dynamic;

				if (Program.Equates[hashes[i]] == null)
					Program.Equates[hashes[i]] = new List<AssemblyTokenEquate>();

				// add the equate into the token list
				Program.Equates[hashes[i]].Insert(0, equs[i]);
			}

			// add the size parameter into the mix
			hashes[i] = Program.ComputeHash("size", true);
			equs[i] = new AssemblyTokenEquate("size", Ref.Size);

			if (Program.Equates[hashes[i]] == null)
				Program.Equates[hashes[i]] = new List<AssemblyTokenEquate>();

			Program.Equates[hashes[i]].Insert(0, equs[i++]);

			// add the args parameter into the mix
			hashes[i] = Program.ComputeHash("args", true);
			equs[i] = new AssemblyTokenEquate("args", Ref.Arguments.ToArray());

			if (Program.Equates[hashes[i]] == null)
				Program.Equates[hashes[i]] = new List<AssemblyTokenEquate>();

			Program.Equates[hashes[i]].Insert(0, equs[i]);

			byte[] Data = new byte[0];
			Container.BaseAddress = Program.FileAddress;
			AssemblyToken ret = Container.Solve(out TokenState st);
			if (st > state) state = st;

			if (ret is AssemblyTokenData d)
				Data = d.Value;

			// destroy fake variables

			for(i = 0;i < hashes.Length;i++)
				Program.Equates[hashes[i]].Remove(equs[i]);

			Program.IgnoreLabelRebase = false;
			if(Data.Length == 0)
				return ret;
			return new AssemblyTokenData(Data.ToArray());
		}
	}
	#endregion

	#region Assembly Token Macros Custom
	public class AssemblyTokenMacroIf : AssemblyTokenMacro {
		public AssemblyTokenMacroIf(string Name, EquateFlags Flags, bool iselseif, bool iselse) : base(Name, Flags) {
			isElse = iselse; IsElseIf = iselseif;
		}

		public override AssemblyToken Solve(out TokenState state) {
			TokenState st = TokenState.Dynamic;
			state = st;

			AssemblyToken ret = null;
			dynamic[] results = null;

			if (isElse)
				results = InternalMacros.ConvertArguments("else", Arguments, new string[0], new Type[0][], out state);
			else results = InternalMacros.ConvertArguments(IsElseIf ? "elseif" : "if", Arguments, new string[] { "condition" }, new Type[][] { new Type[] { typeof(double) } }, out state);

			if (isElse || results[0] != 0) {
				// if true, evaluate inner tokens
				Container.BaseAddress = Program.FileAddress;
				ret = Container.Solve(out st);

			} else if (!(Else is null)) {
				// if false, evaluate other else case
				ret = Else.Solve(out st);
			}

			if (st > state) state = st;
			return ret;
		}

		public AssemblyToken Else;
		public AssemblyTokenContainer Container;
		private bool isElse = false, IsElseIf = false;
		private List<string> Arguments;

		public override AssemblyToken Expand(AssemblyTokenMacroRef Ref, out TokenState state) {
			state = TokenState.Indeterminate;

			// make a copy of this class
			AssemblyTokenMacroIf mc = new AssemblyTokenMacroIf(Name, Flags, IsElseIf, isElse) {
				Container = new AssemblyTokenContainer(),
				Arguments = Ref.Arguments,
			};

			// if this is elseif, we need to add some special behavior
			if (IsElseIf) {
				List<AssemblyToken> list = Program.TokenList.Peek();
				if (list.Count != 0 && list.Last() is AssemblyTokenMacroIf i) {
					// this is a valid if or elseif, we can proceed.
					AssemblyTokenMacroIf e = i;

					while (!(e is null) && !(e.Else is null))
						e = e.Else as AssemblyTokenMacroIf;

					if (!(e is null)) {
						e.Else = mc;
						if (!i.isElse) goto success;
					}
				}

				Program.FormatError("No matching if statement was defined before else" + (isElse ? "" : "if") + "!");

			} else
				Program.TokenList.Peek().Add(mc);

			success: Program.TokenList.Push(mc.Container.Tokens);
			return null;
		}
	}

	public class AssemblyTokenMacroRept : AssemblyTokenMacro {
		public AssemblyTokenMacroRept(string Name, EquateFlags Flags) : base(Name, Flags) { }

		public override AssemblyToken Solve(out TokenState state) {
			state = TokenState.Dynamic;
			Program.IgnoreLabelRebase = true;

			dynamic[] results = null;
			results = InternalMacros.ConvertArguments("rept", Arguments, new string[] { "count" }, new Type[][] { new Type[] { typeof(double) } }, out state);

			Container.BaseAddress = Program.FileAddress;
			List<byte> Data = new List<byte>();
			AssemblyToken ret = null;

			for (long i = (long)results[0];i > 0;i--) {
				ret = Container.Solve(out TokenState st);
				if (st > state) state = st;

				if (ret is AssemblyTokenData d) {
					Container.BaseAddress += d.Value.Length;
					Data.AddRange(d.Value);
				}
			}
			
			Program.IgnoreLabelRebase = false;
			return new AssemblyTokenData(Data.ToArray());
		}

		private List<string> Arguments;
		public AssemblyTokenContainer Container;

		public override AssemblyToken Expand(AssemblyTokenMacroRef Ref, out TokenState state) {
			state = TokenState.Indeterminate;

			// make a copy of this class
			AssemblyTokenMacroRept mc = new AssemblyTokenMacroRept(Name, Flags) {
				Container = new AssemblyTokenContainer(),
				Arguments = Ref.Arguments,
			};

			Program.TokenList.Peek().Add(mc);
			Program.TokenList.Push(mc.Container.Tokens);
			return null;
		}
	}
	#endregion

	#region Assembly Token Data
	public class AssemblyTokenData : AssemblyTokenValue {
		private int LastPass;
		public uint Address { get; private set; }

		public AssemblyTokenData(byte[] Data) : base(Data) { }

		public override AssemblyToken Solve(out TokenState state) {
			state = TokenState.Static;

			if (Program.Pass > LastPass) {
				Address = Program.Address;
				LastPass = Program.Pass;
			}
			return this;
		}
		public override string ToString() {
			string o = "[";
			
			for(int i = 0;i < Value.Length;i++) {
				if (i != 0) o += ", ";
				o += "$"+ Value[i].ToString("X2");
			}

			return o + "]";
		}
	}
	#endregion

	#region Assembly Token Basic Operators
	public class AssemblyTokenAdd : AssemblyTokenCalculation {
		public override AssemblyToken Solve(out TokenState state) {
			AssemblyToken t = Left.Solve(out TokenState stat1) + Right.Solve(out TokenState stat2);
			state = (TokenState)Math.Max((int)stat1, (int)stat2);
			return t;
		}

		public override int GetPrecendece() => 18;
		public override bool IsUnary() => false;
		public override string ShowString() => (Left?.ShowString() ?? "null") + "+"+ (Right?.ShowString() ?? "null");
	}

	public class AssemblyTokenSubstract : AssemblyTokenCalculation {
		public override AssemblyToken Solve(out TokenState state) {
			AssemblyToken t = Left.Solve(out TokenState stat1) - Right.Solve(out TokenState stat2);
			state = (TokenState)Math.Max((int)stat1, (int)stat2);
			return t;
		}

		public override int GetPrecendece() => 18;
		public override bool IsUnary() => false;
		public override string ShowString() => (Left?.ShowString() ?? "null") + "-" + (Right?.ShowString() ?? "null");
	}

	public class AssemblyTokenMultiply : AssemblyTokenCalculation {
		public override AssemblyToken Solve(out TokenState state) {
			AssemblyToken t = Left.Solve(out TokenState stat1) * Right.Solve(out TokenState stat2);
			state = (TokenState)Math.Max((int)stat1, (int)stat2);
			return t;
		}

		public override int GetPrecendece() => 19;
		public override bool IsUnary() => false;
		public override string ShowString() => (Left?.ShowString() ?? "null") + "*" + (Right?.ShowString() ?? "null");
	}

	public class AssemblyTokenDivide : AssemblyTokenCalculation {
		public override AssemblyToken Solve(out TokenState state) {
			AssemblyToken t = Left.Solve(out TokenState stat1) / Right.Solve(out TokenState stat2);
			state = (TokenState)Math.Max((int)stat1, (int)stat2);
			return t;
		}

		public override int GetPrecendece() => 19;
		public override bool IsUnary() => false;
		public override string ShowString() => (Left?.ShowString() ?? "null") + "/" + (Right?.ShowString() ?? "null");
	}

	public class AssemblyTokenModulo : AssemblyTokenCalculation {
		public override AssemblyToken Solve(out TokenState state) {
			AssemblyToken t = Left.Solve(out TokenState stat1) % Right.Solve(out TokenState stat2);
			state = (TokenState)Math.Max((int)stat1, (int)stat2);
			return t;
		}

		public override int GetPrecendece() => 19;
		public override bool IsUnary() => false;
		public override string ShowString() => (Left?.ShowString() ?? "null") + "%" + (Right?.ShowString() ?? "null");
	}
	#endregion

	#region Assembly Token Binary Operators
	public class AssemblyTokenOr : AssemblyTokenCalculation {
		public override AssemblyToken Solve(out TokenState state) {
			AssemblyToken t = Left.Solve(out TokenState stat1) | Right.Solve(out TokenState stat2);
			state = (TokenState)Math.Max((int)stat1, (int)stat2);
			return t;
		}

		public override int GetPrecendece() => 7;
		public override bool IsUnary() => false;
		public override string ShowString() => (Left?.ShowString() ?? "null") + "|" + (Right?.ShowString() ?? "null");
	}

	public class AssemblyTokenXor : AssemblyTokenCalculation {
		public override AssemblyToken Solve(out TokenState state) {
			AssemblyToken t = Left.Solve(out TokenState stat1) ^ Right.Solve(out TokenState stat2);
			state = (TokenState)Math.Max((int)stat1, (int)stat2);
			return t;
		}

		public override int GetPrecendece() => 8;
		public override bool IsUnary() => false;
		public override string ShowString() => (Left?.ShowString() ?? "null") + "^" + (Right?.ShowString() ?? "null");
	}

	public class AssemblyTokenAnd : AssemblyTokenCalculation {
		public override AssemblyToken Solve(out TokenState state) {
			AssemblyToken t = Left.Solve(out TokenState stat1) & Right.Solve(out TokenState stat2);
			state = (TokenState)Math.Max((int)stat1, (int)stat2);
			return t;
		}

		public override int GetPrecendece() => 9;
		public override bool IsUnary() => false;
		public override string ShowString() => (Left?.ShowString() ?? "null") + "&" + (Right?.ShowString() ?? "null");
	}
	#endregion

	#region Assembly Token Equality Operators
	public class AssemblyTokenEquals : AssemblyTokenCalculation {
		public override AssemblyToken Solve(out TokenState state) {
			AssemblyToken t = Left.Solve(out TokenState stat1) == Right.Solve(out TokenState stat2);
			state = (TokenState)Math.Max((int)stat1, (int)stat2);
			return t;
		}

		public override int GetPrecendece() => 10;
		public override bool IsUnary() => false;
		public override string ShowString() => (Left?.ShowString() ?? "null") + "==" + (Right?.ShowString() ?? "null");
	}

	public class AssemblyTokenNotEquals : AssemblyTokenCalculation {
		public override AssemblyToken Solve(out TokenState state) {
			AssemblyToken t = Left.Solve(out TokenState stat1) != Right.Solve(out TokenState stat2);
			state = (TokenState)Math.Max((int)stat1, (int)stat2);
			return t;
		}

		public override int GetPrecendece() => 10;
		public override bool IsUnary() => false;
		public override string ShowString() => (Left?.ShowString() ?? "null") + "!=" + (Right?.ShowString() ?? "null");
	}

	public class AssemblyTokenMoreThan : AssemblyTokenCalculation {
		public override AssemblyToken Solve(out TokenState state) {
			AssemblyToken t = Left.Solve(out TokenState stat1) > Right.Solve(out TokenState stat2);
			state = (TokenState)Math.Max((int)stat1, (int)stat2);
			return t;
		}

		public override int GetPrecendece() => 11;
		public override bool IsUnary() => false;
		public override string ShowString() => (Left?.ShowString() ?? "null") + ">" + (Right?.ShowString() ?? "null");
	}

	public class AssemblyTokenMoreThanOrEquals : AssemblyTokenCalculation {
		public override AssemblyToken Solve(out TokenState state) {
			AssemblyToken t = Left.Solve(out TokenState stat1) >= Right.Solve(out TokenState stat2);
			state = (TokenState)Math.Max((int)stat1, (int)stat2);
			return t;
		}

		public override int GetPrecendece() => 11;
		public override bool IsUnary() => false;
		public override string ShowString() => (Left?.ShowString() ?? "null") + ">=" + (Right?.ShowString() ?? "null");
	}

	public class AssemblyTokenLessThan : AssemblyTokenCalculation {
		public override AssemblyToken Solve(out TokenState state) {
			AssemblyToken t = Left.Solve(out TokenState stat1) < Right.Solve(out TokenState stat2);
			state = (TokenState)Math.Max((int)stat1, (int)stat2);
			return t;
		}

		public override int GetPrecendece() => 12;
		public override bool IsUnary() => false;
		public override string ShowString() => (Left?.ShowString() ?? "null") + "<" + (Right?.ShowString() ?? "null");
	}

	public class AssemblyTokenLessThanOrEquals : AssemblyTokenCalculation {
		public override AssemblyToken Solve(out TokenState state) {
			AssemblyToken t = Left.Solve(out TokenState stat1) <= Right.Solve(out TokenState stat2);
			state = (TokenState)Math.Max((int)stat1, (int)stat2);
			return t;
		}

		public override int GetPrecendece() => 12;
		public override bool IsUnary() => false;
		public override string ShowString() => (Left?.ShowString() ?? "null") + "<=" + (Right?.ShowString() ?? "null");
	}
	#endregion

	#region Assembly Token Shift Operators
	public class AssemblyTokenShiftRight : AssemblyTokenCalculation {
		public override AssemblyToken Solve(out TokenState state) {
			AssemblyToken r = Right.Solve(out TokenState stat2);
			AssemblyTokenValue rr = r as AssemblyTokenValue;

			if (rr is null) Fail("Right side of >> operator is not a value!");
			int v = 0;

			if (rr.Value is string) {
				if(!Int32.TryParse(rr.Value as string, out v))
					Fail("Right side of >> operator can not be converted to a number: "+ rr.Value);

			} else v = (int)rr.Value;

			AssemblyToken t = Left.Solve(out TokenState stat1) >> v;
			state = (TokenState)Math.Max((int)stat1, (int)stat2);
			return t;
		}

		public override int GetPrecendece() => 15;
		public override bool IsUnary() => false;
		public override string ShowString() => (Left?.ShowString() ?? "null") + ">>" + (Right?.ShowString() ?? "null");
	}

	public class AssemblyTokenShiftLeft : AssemblyTokenCalculation {
		public override AssemblyToken Solve(out TokenState state) {
			AssemblyToken r = Right.Solve(out TokenState stat2);
			AssemblyTokenValue rr = r as AssemblyTokenValue;

			if (rr is null) Fail("Right side of >> operator is not a value!");
			int v = 0;

			if (rr.Value is string) {
				if (!Int32.TryParse(rr.Value as string, out v))
					Fail("Right side of >> operator can not be converted to a number: " + rr.Value);

			} else v = (int)rr.Value;

			AssemblyToken t = Left.Solve(out TokenState stat1) << v;
			state = (TokenState)Math.Max((int)stat1, (int)stat2);
			return t;
		}

		public override int GetPrecendece() => 15;
		public override bool IsUnary() => false;
		public override string ShowString() => (Left?.ShowString() ?? "null") + "<<" + (Right?.ShowString() ?? "null");
	}
	#endregion

	#region Assembly Token Unary Operators
	public class AssemblyTokenNegate : AssemblyTokenCalculation {
		public override AssemblyToken Solve(out TokenState state) {
			return -Left.Solve(out state);
		}

		public override int GetPrecendece() => 20;
		public override bool IsUnary() => true;
		public override string ShowString() => "-"+ (Left?.ShowString() ?? "null");
	}

	public class AssemblyTokenNot : AssemblyTokenCalculation {
		public override AssemblyToken Solve(out TokenState state) {
			return ~Left.Solve(out state);
		}

		public override int GetPrecendece() => 20;
		public override bool IsUnary() => true;
		public override string ShowString() => "~" + (Left?.ShowString() ?? "null");
	}

	public class AssemblyTokenLogicalNot : AssemblyTokenCalculation {
		public override AssemblyToken Solve(out TokenState state) {
			return !Left.Solve(out state);
		}

		public override int GetPrecendece() => 1;
		public override bool IsUnary() => true;
		public override string ShowString() => "!" + (Left?.ShowString() ?? "null");
	}
	#endregion

	#region Assembly Token Array Operator
	public class AssemblyTokenArrayAccess : AssemblyTokenCalculation {
		public override AssemblyToken Solve(out TokenState state) {
			int index = 0;

			AssemblyToken r = Right.Solve(out TokenState stat2);
			AssemblyTokenValue rv = r as AssemblyTokenValue;

			if(rv is null) {
				Fail("Indexor of [] operator is not a value!");

			} else if (rv.Value is string) {
				if (!Int32.TryParse(rv.Value as string, out index))
					Fail("Indexor in [] operator can not be converted to a number: " + rv.Value);

			} else index = (int)Right.Value;

			AssemblyToken l = Left.Solve(out TokenState stat1);
			AssemblyTokenValue lv = l as AssemblyTokenValue;

			if (lv is null) Fail("Left side of [] operator is not a value!");
			state = (TokenState)Math.Max((int)stat1, (int)stat2);

			// check if the object is an array object
			if (lv.Value is string || lv.IsArray()) {
				if(index < 0 || index >= lv.Value.Length)
					Fail("Index was out of bound with [] operator: array = "+ lv.Value.Length + ", index = " + index);

				return new AssemblyTokenValue(lv.Value[index]);
			}

			Fail("Failed to use [] operator on value: " + lv.Value);
			return null;
		}

		public override int GetPrecendece() => 100;
		public override bool IsUnary() => false;
		public override string ShowString() => (Left?.ShowString() ?? "null") +"[" + (Right?.ShowString() ?? "null") + "]";
	}
	#endregion

	#region AssemblyToken
	public abstract class AssemblyToken {
		public EquateFlags Flags;
		public AssemblyToken Parent;
		public abstract AssemblyToken Solve(out TokenState state);

		public string file;
		public uint line;
		public int LastBytes = 0;

		public void Fail(string text) {
			Program.FormatError(file ?? "", line, text);
		}

		public AssemblyToken() {
			if (!(Program.Context is null)) {
				file = Program.GetFilename();
				line = Program.GetLine();
			}
		}

		#region Operator Code
		public static AssemblyToken operator +(AssemblyToken left, AssemblyToken right) {
			if (left is AssemblyTokenValue lv && right is AssemblyTokenValue rv) {
				if (lv.IsArray() || rv.IsArray())
					left.Fail((lv.IsArray() ? "Left" : "Right") + " side of + operator can not be converted to a value: " + (lv.IsArray() ? lv : rv).ToString());

				return new AssemblyTokenValue(lv.Value + rv.Value);
			}
			
			throw new NotImplementedException();
		}

		public static AssemblyToken operator -(AssemblyToken left, AssemblyToken right) {
			if (left is AssemblyTokenValue lv && right is AssemblyTokenValue rv) {
				if (lv.IsArray() || rv.IsArray())
					left.Fail((lv.IsArray() ? "Left" : "Right") + " side of - operator can not be converted to a value: " + (lv.IsArray() ? lv : rv).ToString());

				// if we do for example, 0.92 - "0", the result is ".92". Or, if we do "ASSHATS" - "HATS", result is "ASS"
				if (lv.IsString() || rv.IsString())
					return new AssemblyTokenValue(lv.ToString().Replace(rv.ToString(), ""));

				return new AssemblyTokenValue(lv.Value - rv.Value);
			}

			throw new NotImplementedException();
		}

		public static AssemblyToken operator *(AssemblyToken left, AssemblyToken right) {
			if (left is AssemblyTokenValue lv && right is AssemblyTokenValue rv) {
				if (lv.IsArray() || rv.IsArray())
					left.Fail((lv.IsArray() ? "Left" : "Right") + " side of * operator can not be converted to a value: " + (lv.IsArray() ? lv : rv).ToString());

				// if we do for example, 3.0 * "abc", the result its "abcabcabc"
				if (lv.IsString() || rv.IsString()) {
					int v = 0;
					bool isleft = lv.IsString();

					// check if both are strings
					if (isleft && rv.IsString()) {
						if (!Int32.TryParse(rv.Value as string, out v))
							right.Fail("Right side of * operator can not be converted to a number: " + rv.ToString());

					} else v = isleft ? (int)rv.Value : (int)lv.Value;

					if(v < 0) right.Fail("Can not multiply a string less than 0 times: " + (isleft ? rv : lv).ToString());
					return new AssemblyTokenValue(string.Concat(Enumerable.Repeat((isleft ? lv : rv).Value, v)));
				}

				return new AssemblyTokenValue(lv.Value * rv.Value);
			}

			throw new NotImplementedException();
		}

		public static AssemblyToken operator /(AssemblyToken left, AssemblyToken right) {
			if (left is AssemblyTokenValue lv && right is AssemblyTokenValue rv) {
				if (lv.IsArray() || rv.IsArray())
					left.Fail((lv.IsArray() ? "Left" : "Right") + " side of / operator can not be converted to a value: " + (lv.IsArray() ? lv : rv).ToString());

				dynamic lx = 0, rx = 0;

				if (lv.IsString()) {
					if (!Double.TryParse(lv.Value as string, out double lxx))
						left.Fail("Left side of / operator can not be converted to a number: " + lv.ToString());

					lx = lxx;
				} else lx = lv.Value;

				if (rv.IsString()) {
					if (!Double.TryParse(rv.Value as string, out double rxx))
						right.Fail("Right side of / operator can not be converted to a number: " + rv.ToString());

					rx = rxx;
				} else rx = rv.Value;

				return new AssemblyTokenValue(lx / rx);
			}

			throw new NotImplementedException();
		}

		public static AssemblyToken operator %(AssemblyToken left, AssemblyToken right) {
			if (left is AssemblyTokenValue lv && right is AssemblyTokenValue rv) {
				if (lv.IsArray() || rv.IsArray())
					left.Fail((lv.IsArray() ? "Left" : "Right") + " side of % operator can not be converted to a value: " + (lv.IsArray() ? lv : rv).ToString());

				double lx = 0, rx = 0;

				if (lv.IsString()) {
					if (!Double.TryParse(lv.Value as string, out lx))
						left.Fail("Left side of % operator can not be converted to a number: " + lv.ToString());

				} else lx = lv.Value;

				if (rv.IsString()) {
					if (!Double.TryParse(rv.Value as string, out rx))
						right.Fail("Right side of % operator can not be converted to a number: " + rv.ToString());

				} else rx = rv.Value;

				return new AssemblyTokenValue(lx % rx);
			}

			throw new NotImplementedException();
		}

		private static int _ArrayCompare(AssemblyTokenValue lv, AssemblyTokenValue rv) {
			if (lv.IsArray() != rv.IsArray())	// always 0
				return 0;

			if (lv.Value.Length != rv.Value.Length)
				return lv.Value.Length - rv.Value.Length;

			return (lv.Value as IStructuralComparable).CompareTo(rv.Value, StructuralComparisons.StructuralComparer);
		}

		public static AssemblyToken operator <(AssemblyToken left, AssemblyToken right) {
			if (left is AssemblyTokenValue lv && right is AssemblyTokenValue rv) {
				if(lv.IsArray() || rv.IsArray())
					return new AssemblyTokenValue(_ArrayCompare(lv, rv) < 0 ? 1 : 0);

				if (lv.Value is string || rv.Value is string)
					return new AssemblyTokenValue(lv.ToString().CompareTo(rv.ToString()) < 0 ? 1 : 0);

				return new AssemblyTokenValue(lv.Value < rv.Value ? 1 : 0);
			}

			throw new NotImplementedException();
		}

		public static AssemblyToken operator >(AssemblyToken left, AssemblyToken right) {
			if (left is AssemblyTokenValue lv && right is AssemblyTokenValue rv) {
				if (lv.IsArray() || rv.IsArray())
					return new AssemblyTokenValue(_ArrayCompare(lv, rv) > 0 ? 1 : 0);

				if (lv.Value is string || rv.Value is string)
					return new AssemblyTokenValue(lv.ToString().CompareTo(rv.ToString()) > 0 ? 1 : 0);

				return new AssemblyTokenValue(lv.Value > rv.Value ? 1 : 0);
			}

			throw new NotImplementedException();
		}

		public static AssemblyToken operator <=(AssemblyToken left, AssemblyToken right) {
			if (left is AssemblyTokenValue lv && right is AssemblyTokenValue rv) {
				if (lv.IsArray() || rv.IsArray())
					return new AssemblyTokenValue(_ArrayCompare(lv, rv) <= 0 ? 1 : 0);

				if (lv.IsString() || rv.IsString())
					return new AssemblyTokenValue(lv.ToString().CompareTo(rv.ToString()) <= 0 ? 1 : 0);

				return new AssemblyTokenValue(lv.Value <= rv.Value ? 1 : 0);
			}

			throw new NotImplementedException();
		}

		public static AssemblyToken operator >=(AssemblyToken left, AssemblyToken right) {
			if (left is AssemblyTokenValue lv && right is AssemblyTokenValue rv) {
				if (lv.IsArray() || rv.IsArray())
					return new AssemblyTokenValue(_ArrayCompare(lv, rv) >= 0 ? 1 : 0);

				if (lv.IsString() || rv.IsString())
					return new AssemblyTokenValue(lv.ToString().CompareTo(rv.ToString()) >= 0 ? 1 : 0);

				return new AssemblyTokenValue(lv.Value >= rv.Value ? 1 : 0);
			}

			throw new NotImplementedException();
		}

		private static bool _ArrayEquals(AssemblyTokenValue lv, AssemblyTokenValue rv) {
			if (lv.IsArray() != rv.IsArray() || lv.Value.Length != rv.Value.Length)
				return false;

			return (lv.Value as IStructuralComparable).CompareTo(rv.Value, StructuralComparisons.StructuralComparer) == 0;
		}

		public static AssemblyToken operator ==(AssemblyToken left, AssemblyToken right) {
			if (left is AssemblyTokenValue lv && right is AssemblyTokenValue rv) {
				if (lv.IsArray() || rv.IsArray())
					return new AssemblyTokenValue(_ArrayEquals(lv, rv) ? 1 : 0);

				if (lv.IsString() || rv.IsString())
					return new AssemblyTokenValue(lv.ToString() == rv.ToString() ? 1 : 0);

				return new AssemblyTokenValue(lv.Value == rv.Value ? 1 : 0);
			}

			throw new NotImplementedException();
		}

		public static AssemblyToken operator !=(AssemblyToken left, AssemblyToken right) {
			if (left is AssemblyTokenValue lv && right is AssemblyTokenValue rv) {
				if (lv.IsArray() || rv.IsArray())
					return new AssemblyTokenValue(!_ArrayEquals(lv, rv) ? 1 : 0);

				return new AssemblyTokenValue(lv.Value != rv.Value ? 1 : 0);
			}

			throw new NotImplementedException();
		}

		public static AssemblyToken operator ^(AssemblyToken left, AssemblyToken right) {
			if (left is AssemblyTokenValue lv && right is AssemblyTokenValue rv) {
				if (lv.IsArray() || rv.IsArray())
					left.Fail((lv.IsArray() ? "Left" : "Right") + " side of ^ operator can not be converted to a value: " + (lv.IsArray() ? lv : rv).ToString());

				long lx = 0, rx = 0;

				if (lv.IsString()) {
					if (!Int64.TryParse(lv.Value as string, out lx))
						left.Fail("Left side of ^ operator can not be converted to a number: " + lv.ToString());

				} else lx = (long)lv.Value;

				if (rv.IsString()) {
					if (!Int64.TryParse(rv.Value as string, out rx))
						right.Fail("Right side of ^ operator can not be converted to a number: " + rv.ToString());

				} else rx = (long)rv.Value;

				return new AssemblyTokenValue(lx ^ rx);
			}

			throw new NotImplementedException();
		}

		public static AssemblyToken operator &(AssemblyToken left, AssemblyToken right) {
			if (left is AssemblyTokenValue lv && right is AssemblyTokenValue rv) {
				if (lv.IsArray() || rv.IsArray())
					left.Fail((lv.IsArray() ? "Left" : "Right") + " side of & operator can not be converted to a value: " + (lv.IsArray() ? lv : rv).ToString());

				long lx = 0, rx = 0;

				if (lv.IsString()) {
					if (!Int64.TryParse(lv.Value as string, out lx))
						left.Fail("Left side of & operator can not be converted to a number: " + lv.ToString());

				} else lx = (long)lv.Value;

				if (rv.IsString()) {
					if (!Int64.TryParse(rv.Value as string, out rx))
						right.Fail("Right side of & operator can not be converted to a number: " + rv.ToString());

				} else rx = (long)rv.Value;

				return new AssemblyTokenValue(lx & rx);
			}

			throw new NotImplementedException();
		}

		public static AssemblyToken operator |(AssemblyToken left, AssemblyToken right) {
			if (left is AssemblyTokenValue lv && right is AssemblyTokenValue rv) {
				if (lv.IsArray() || rv.IsArray())
					left.Fail((lv.IsArray() ? "Left" : "Right") + " side of | operator can not be converted to a value: " + (lv.IsArray() ? lv : rv).ToString());

				long lx = 0, rx = 0;

				if (lv.IsString()) {
					if (!Int64.TryParse(lv.Value as string, out lx))
						left.Fail("Left side of | operator can not be converted to a number: " + lv.ToString());

				} else lx = (long)lv.Value;

				if (rv.IsString()) {
					if (!Int64.TryParse(rv.Value as string, out rx))
						right.Fail("Right side of | operator can not be converted to a number: " + rv.ToString());

				} else rx = (long)rv.Value;

				return new AssemblyTokenValue(lx | rx);
			}

			throw new NotImplementedException();
		}

		public static AssemblyToken operator !(AssemblyToken left) {
			if (left is AssemblyTokenValue lv) {
				if (lv.IsArray())
					left.Fail("Left side of ! operator can not be converted to a value: " + lv.ToString());

				long lx = 0;

				if (lv.IsString()) {
					if (!Int64.TryParse(lv.Value as string, out lx))
						left.Fail("Left side of ! operator can not be converted to a number: " + lv.ToString());

				} else lx = (long)lv.Value;

				return new AssemblyTokenValue(lx == 0 ? 1 : 0);
			}

			throw new NotImplementedException();
		}

		public static AssemblyToken operator ~(AssemblyToken left) {
			if (left is AssemblyTokenValue lv) {
				if (lv.IsArray())
					left.Fail("Left side of ~ operator can not be converted to a value: " + lv.ToString());

				long lx = 0;

				if (lv.IsString()) {
					if (!Int64.TryParse(lv.Value as string, out lx))
						left.Fail("Left side of ~ operator can not be converted to a number: " + lv.ToString());

				} else lx = (long)lv.Value;

				return new AssemblyTokenValue(~lx);
			}

			throw new NotImplementedException();
		}

		public static AssemblyToken operator -(AssemblyToken left) {
			if (left is AssemblyTokenValue lv) {
				if (lv.IsArray())
					left.Fail("Left side of - operator can not be converted to a value: " + lv.ToString());

				// if we do for example, -"abc" >> 1, the result is "cba"
				if (lv.IsString()) {
					char[] tx = (lv.Value as string).ToCharArray();
					Array.Reverse(tx);
					return new AssemblyTokenValue(new string(tx));
				}

				return new AssemblyTokenValue(-lv.Value);
			} 

			throw new NotImplementedException();
		}

		public static AssemblyToken operator <<(AssemblyToken left, int right) {
			if (left is AssemblyTokenValue lv) {
				if (lv.IsArray())
					left.Fail("Left side of << operator can not be converted to a value: " + lv.ToString());

				// if we do for example, "test" << 2, the result is "stte"
				if (lv.IsString()) {
					right %= (lv.Value as string).Length;
					if (right == 0) return lv;

					return new AssemblyTokenValue((lv.Value as string).Substring(right, (lv.Value as string).Length - right) + (lv.Value as string).Substring(0, right));
				}

				return new AssemblyTokenValue((long)lv.Value << right);
			}

			throw new NotImplementedException();
		}

		public static AssemblyToken operator >>(AssemblyToken left, int right) {
			if (left is AssemblyTokenValue lv) {
				if (lv.IsArray())
					left.Fail("Left side of >> operator can not be converted to a value: " + lv.ToString());

				// if we do for example, "test" >> 1, the result is "ttes"
				if (lv.IsString()) {
					right %= (lv.Value as string).Length;
					if (right == 0) return lv;
					right = (lv.Value as string).Length - right;

					return new AssemblyTokenValue((lv.Value as string).Substring(right, (lv.Value as string).Length - right) + (lv.Value as string).Substring(0, right));
				}

				return new AssemblyTokenValue((long)lv.Value >> right);
			}
			
			throw new NotImplementedException();
		}
		#endregion

		public override bool Equals(object obj) {
			return base.Equals(obj);
		}

		public override int GetHashCode() {
			return base.GetHashCode();
		}
	}
	#endregion
}
