using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using static MDASM.Program;

namespace MDASM {
	[Flags]
	public enum EquateFlags {
		None = 0,
		Locked = 0x0001,
		EatLabel = 0x0002,
		DontList = 0x0004,
		EvalueateImmediately = 0x0008,
		AlignBefore = 0x0010,
		AlignAlways = 0x0020,
		AlignSpecial = 0x0040,
	}

	public enum TokenState {
		Static, Dynamic, Indeterminate
	}

	public class InternalMacros {
		#region Common Functions
		public static byte[] GetAlignment(bool overrd) {
			if (!overrd && !Options.AutomaticEvens)
				return new byte[0];
			
			return GetAlignBytes(Address % Options.Alignment);
		}

		public static byte[] GetAlignBytes(long length) {
			byte[] data = new byte[length];

			if (Options.AlignByte != 0)
				for (int i = 0;i < length;i++)
					data[i] = Options.AlignByte;

			return data;
		}
		#endregion

		#region Arguments
		public static dynamic[] ConvertArguments(string name, List<string> arguments, string[] names, Type[][] types, out TokenState state, int min = -1) {
			state = TokenState.Static;
			if (min < 0 ? arguments.Count != types.Length : arguments.Count < min)
				FormatError("Incorrect number of arguments ("+ arguments.Count + "): Call with " + ConvertArgStr(name, names, types) + 
					(min < types.Length && min >= 0 ? " (last required argument is "+ names[min] +")" : ""));

			dynamic[] o = new dynamic[arguments.Count];

			for(int i = 0;i < o.Length;i++) {
				AssemblyToken solved = Context.CalculateEquationTokens(arguments[i]);
				solved = Context.SolveTokens(solved, out TokenState stat);
				AssemblyTokenValue sv = solved as AssemblyTokenValue;

				if (stat > state) state = stat;
				
				if (sv is null)
					FormatError("Argument "+ names[i] +" could not be converted to a value! Call with " + ConvertArgStr(name, names, types) +
						(min < types.Length && min >= 0 ? " (last required argument is " + names[min] + ")" : ""));

				dynamic value = sv.Value;

				// special case; Any type is good
				if (types[i].Length == 0) goto valid;

				for (int y = 0;y < types[i].Length;y++)
					if (types[i][y] == sv.Value.GetType())
						goto valid;

				// we found no direct match, attempt casting

				for (int y = 0;y < types[i].Length;y++) {
					if (typeof(double) == types[i][y]) {
						try {
							value = (double)sv.Value;
							goto valid;
						} catch (Exception) { }

					} else if(typeof(long) == types[i][y]) {
						try {
							value = (long)sv.Value;
							goto valid;
						} catch (Exception) { }

					} else if(typeof(string) == types[i][y]) {
						// try direct string conversion
						try {
							value = (string)sv.Value;
							goto valid;
						} catch (Exception) { }

						// try to convert to a double and then to a string...
						try {
							value = ""+ (double)sv.Value;
							goto valid;
						} catch (Exception) { }

					} else if (typeof(dynamic[]) == types[i][y]) {
						try {
							if(sv.Value is string) {
								value = (sv.Value as string).ToCharArray();

							} else value = (dynamic[])sv.Value;
							goto valid;
						} catch (Exception) { }
					}
				}

				FormatError("Incorrect value type for argument "+ names[i] + ": Expected "+ 
					(types[i].Length == 0 ? "anything" : GetTypesStr(types[i])) +", but got "+ sv.Value.GetType().Name.ToLowerInvariant() + "!");
				valid: o[i] = value;
			}

			return o;
		}

		public static string ConvertArgStr(string name, string[] names, Type[][] types) {
			string o = "'" + name + "(";

			for(int i = 0;i < types.Length;i++) {
				if (i != 0) o += ", ";
				o += names[i] + (types[i].Length == 0 ? "" : "::" + GetTypesStr(types[i]));
			}

			return o + ")'";
		}

		private static string GetTypesStr(Type[] types) {
			if (types.Length == 1)
				return types[0].Name.ToLowerInvariant();

			else {
				string o = "";

				for (int y = 0;y < types.Length;y++) {
					if (y != 0) o += "/";
					o += types[y].Name.ToLowerInvariant();
				}

				return o;
			}
		}
		#endregion

		#region Misc
		// this is an example body and used for any no-operation macros
		public static Tuple<TokenState, AssemblyToken> Noop(AssemblyTokenMacroRef Ref) {
			return new Tuple<TokenState, AssemblyToken>(TokenState.Static, null);
		}

		public static Tuple<TokenState, AssemblyToken> Even(AssemblyTokenMacroRef Ref) {
			return new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[0]));
		}

		public static Tuple<TokenState, AssemblyToken> GetRandomNumber(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("getrandomnumber", Ref.Arguments, new string[0], new Type[0][], out TokenState state);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue(4 + "\t// chosen by fair dice roll.\n\t// guaranteed to be random."));
		}

		public static Tuple<TokenState, AssemblyToken> Execute(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("exec", Ref.Arguments, new string[] { "command" }, new Type[][] { new Type[] { typeof(string) } }, out TokenState state);
			string file = results[0], args = "";

			int ix = results[0].IndexOf(" ");

			if(ix > 0) {
				args = file.Substring(ix + 1);
				file = file.Substring(0, ix);
			}
			
			Process p = Process.Start(file, args);
			return new Tuple<TokenState, AssemblyToken>(state, null);
		}
		#endregion

		#region Data
		public static Tuple<TokenState, AssemblyToken> Data(AssemblyTokenMacroRef Ref) {
			if (Ref.Arguments.Count == 0)
				FormatError("At least a single argument is required for the dc macro!");

			switch (Ref.Size) {
				case "b": return Datab(Ref);
				case "w": case "": return Dataw(Ref);
				case "l": return Datal(Ref);
			}

			FormatError("Unknown macro size parameter ."+ Ref.Size +" for dc! Expected .b, .w or .l!");
			return new Tuple<TokenState, AssemblyToken>(TokenState.Static, null);
		}

		public static Tuple<TokenState, AssemblyToken> Datab(AssemblyTokenMacroRef Ref) {
			if(Ref.Arguments.Count == 0)
				FormatError("At least a single argument is required for the db macro!");

			AssemblyToken a = new AssemblyTokenData(ConvertToData(Ref.Arguments.ToArray(), 1, out TokenState state));
			return new Tuple<TokenState, AssemblyToken>(state, a);
		}

		public static Tuple<TokenState, AssemblyToken> Dataw(AssemblyTokenMacroRef Ref) {
			if (Ref.Arguments.Count == 0)
				FormatError("At least a single argument is required for the dw macro!");

			AssemblyToken a = new AssemblyTokenData(ConvertToData(Ref.Arguments.ToArray(), 2, out TokenState state));
			return new Tuple<TokenState, AssemblyToken>(state, a);
		}

		public static Tuple<TokenState, AssemblyToken> Datal(AssemblyTokenMacroRef Ref) {
			if (Ref.Arguments.Count == 0)
				FormatError("At least a single argument is required for the dl macro!");

			AssemblyToken a = new AssemblyTokenData(ConvertToData(Ref.Arguments.ToArray(), 4, out TokenState state));
			return new Tuple<TokenState, AssemblyToken>(state, a);
		}

		private static byte[] ConvertToData(string[] args, int segmentsz, out TokenState state) {
			state = TokenState.Static;
			List<byte> bytes = new List<byte>();
			int len = 0;

			for (int i = 0;i < args.Length;i++) {
				AssemblyToken solved = Context.CalculateEquationTokens(args[i]);
				solved = Context.SolveTokens(solved, out TokenState stat);
				AssemblyTokenValue sv = solved as AssemblyTokenValue;

				if (stat > state) state = stat;

				if(sv is null)
					FormatError("Argument "+ (i + 1) +" could not be converted to a value!");

				if (sv.IsString()) {
					// special string code
					byte[] d = Context.StringToBytes(sv.Value as string);

					if (segmentsz != 1 && segmentsz < d.Length)
						FormatError("Expected "+ segmentsz +" bytes for argument " + (i + 1) + ", but got "+ d.Length + "!");

					bytes.AddRange(d);
					len += d.Length;

				} else if(sv.IsArray()) {
					// special array code
					if(!(sv.Value is byte[]))
						FormatError("Expected a byte array as argument " + (i + 1) + ", but got "+ sv.Value.GetType().Name.ToLowerInvariant() +"!");

					byte[] d = (byte[])sv.Value;
					if (segmentsz != 1 && segmentsz < d.Length)
						FormatError("Expected " + segmentsz + " bytes for argument " + (i + 1) + ", but got " + d.Length + "!");

					bytes.AddRange(d);
					len += d.Length;

				} else {
					byte[] d = GetDataBytes(segmentsz, sv.Value, Options.BigEndian, 0, true, true);
					bytes.AddRange(d);
					len += d.Length;
				}
			}

			return bytes.ToArray();
		}

		public static byte[] GetDataBytes(int size, dynamic value, bool bigendian, int minbytes = 0, bool unlimitedbyte = false, bool ignoreoor = false) {
			byte[] ret = new byte[Math.Max(size, minbytes)];
			if (Pass <= 1) ignoreoor = true;

			// convert a value into bytes
			switch (size) {
				case 1:
					if (value is ushort || value is uint || value is ulong || value is char) {
						if (!ignoreoor && value > 0xFF)
							FormatError("Value " + value.ToString("X") + " is out of range!");

					} else if (value is short || value is int || value is long) {
						if (!ignoreoor && value > 0xFF && (int)value < -0x80)
							FormatError("Value " + value.ToString("X") + " is out of range!");

					} else if(value is string) {
						if (unlimitedbyte) {
							ret = new byte[(value as string).Length];

							for (int i = 0;i < ret.Length;i++)
								ret[i] = (byte)value[i];

						} else {
							if((value as string).Length > 1)
								FormatError("String value " + value + " is too large!");

							if ((value as string).Length == 1)
								ret[ret.Length - 1] = (byte)value[0];
						}

						break;

					} else if (value.GetType().IsArray) {
						if (unlimitedbyte) {
							List<byte> bytes = new List<byte>();

							for (int i = 0;i < ret.Length;i++)
								bytes.AddRange(GetDataBytes(size, value[i], bigendian, minbytes, unlimitedbyte, ignoreoor));

							ret = bytes.ToArray();

						} else {
							if (value.Length > 1)
								FormatError("Array value " + value + " is too large!");

							if (value.Length == 1)
								ret[ret.Length - 1] = (byte)value[0];
						}

						break;
					}

					ret[ret.Length - 1] = (byte)value;
					break;

				case 2: {
						if (value is string) {
							if ((value as string).Length > 2)
								FormatError("String value " + value + " is too large!");

							for (int i = (value as string).Length - 1;i >= 0;i--)
								ret[i] = (byte)value[i];

						} else if (value.GetType().IsArray) {
							if (value.Length > 2)
								FormatError("Array value " + value + " is too large!");

							for (int i = value.Length - 1;i >= 0;i--)
								ret[i] = (byte)value[i];

						} else {
							short v = (short)value;

							if (value is uint || value is ulong) {
								if (!ignoreoor && value > 0xFFFF)
									FormatError("Value "+ value.ToString("X") + " is out of range!");

							} else if (value is int || value is long) {
								if (!ignoreoor && value > 0xFFFF && (int)value < -0x8000)
									FormatError("Value " + value.ToString("X") + " is out of range!");
							}

							int p = ret.Length - 2;
							if (bigendian) {
								ret[p++] = (byte)(v >> 8);
								ret[p++] = (byte)v;

							} else {
								ret[p++] = (byte)v;
								ret[p++] = (byte)(v >> 8);
							}
						}
					}
					break;

				case 4: {
						if (value is string) {
							if ((value as string).Length > 4)
								FormatError("String value "+ value +" is too large!");

							for (int i = (value as string).Length - 1;i >= 0;i--)
								ret[i] = (byte)value[i];

						} else if (value.GetType().IsArray) {
							if (value.Length > 2)
								FormatError("Array value " + value + " is too large!");

							for (int i = value.Length - 1;i >= 0;i--)
								ret[i] = (byte)value[i];

						} else {
							int v = (int)value;

							if (value is ulong) {
								if (!ignoreoor && value > 0xFFFFFFFF)
									FormatError("Value " + value.ToString("X") + " is out of range!");

							} else if (value is long) {
								if (!ignoreoor && value > 0xFFFFFFFF && value < -0x80000000)
									FormatError("Value " + value.ToString("X") + " is out of range!");
							}

							int p = ret.Length - 4;
							if (bigendian) {
								ret[p++] = (byte)(v >> 24);
								ret[p++] = (byte)(v >> 16);
								ret[p++] = (byte)(v >> 8);
								ret[p++] = (byte)v;

							} else {
								ret[p++] = (byte)v;
								ret[p++] = (byte)(v >> 8);
								ret[p++] = (byte)(v >> 16);
								ret[p++] = (byte)(v >> 24);
							}
						}
					}
					break;
			}

			return ret;
		}
		#endregion

		#region Console
		public static Tuple<TokenState, AssemblyToken> Print(AssemblyTokenMacroRef Ref) {
			string write = "";

			if(Ref.Arguments.Count > 0) {
				if(Ref.Arguments.Count != 1)
					FormatError("Incorrect number of arguments (" + Ref.Arguments.Count + "): Call with " + ConvertArgStr(Ref.Name, new string[] { "text" }, new Type[][] { new Type[0] }));

				AssemblyToken solved = Context.CalculateEquationTokens(Ref.Arguments[0]);
				solved = Context.SolveTokens(solved, out TokenState state);
				AssemblyTokenValue sv = solved as AssemblyTokenValue;

				if (sv is null)
					FormatError("Argument text could not be converted to a value! Call with " + ConvertArgStr(Ref.Name, new string[] { "text" }, new Type[][] { new Type[0] }));
			
				write = sv.ToString();
			}

			// print it onscreen
			Console.WriteLine(write);

			if (EnableListings) {
				byte[] text = ASCIIEncoding.Default.GetBytes("\t\tprint " + write + "\n");
				ListingsFile.Write(text, 0, text.Length);
			}

			return new Tuple<TokenState, AssemblyToken>(TokenState.Dynamic, null);
		}

		public static Tuple<TokenState, AssemblyToken> ArgsToString(AssemblyTokenMacroRef Ref) {
			string output = (Ref.Label != null ? Ref.Label +": " : "") + Ref.Arguments.Count + ": ";

			for(int i = 0;i < Ref.Arguments.Count;i++) {
				if (i != 0) output += ", ";

				AssemblyToken solved = Context.CalculateEquationTokens(Ref.Arguments[i]);
				solved = Context.SolveTokens(solved, out TokenState state);
				AssemblyTokenValue sv = solved as AssemblyTokenValue;

				if (sv is null)
					output += "";
				else output += "(" + sv.ToString() + ")::" + (sv.Value is null ? "object" : sv.Value.GetType().Name.ToLowerInvariant());
			}

			return new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenValue(output));
		}
		#endregion

		#region External Files
		public static Tuple<TokenState, AssemblyToken> Include(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("include", Ref.Arguments, new string[] { "file" }, new Type[][] { new Type[] { typeof(string) } }, out TokenState state);
			string file = results[0].ToString();

			if (file == null)
				FormatError("File name is not a valid string!");

			// it was valid, add listings and process the file
			if (EnableListings) {
				byte[] text = ASCIIEncoding.Default.GetBytes("\t\tinclude \"" + file + "\"\n");
				ListingsFile.Write(text, 0, text.Length);
			}

			try {
				using (AssemblyStream ass = new AssemblyStream(file, FileMode.Open)) {
					byte[] __rbuf = Context._rbuf;
					int __rlen = Context._rlen, __rind = Context._rind;
					Context._rlen = 0;
					Context._rbuf = new byte[1024];

					Stream butt = CurrentFile;
					CurrentFile = ass;
					Context.ParseFile();
					CurrentFile.Dispose();
					CurrentFile = butt;

					Context._rbuf = __rbuf;
					Context._rind = __rind;
					Context._rlen = __rlen;
				}

			} catch (FileNotFoundException) {
				FormatError("Requested file " + file + " does not exist!");
			} catch (UnauthorizedAccessException) {
				FormatError("Requested file " + file + " could not be opened!");
			} catch (Exception ex) {
				FormatError("Requested file " + file + " caused an exception: " + ex.Message);
			}

			return new Tuple<TokenState, AssemblyToken>(state, null);
		}

		public static Tuple<TokenState, AssemblyToken> Incbin(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("incbin", Ref.Arguments, new string[] { "file", "startindex", "length" }, 
				new Type[][] { new Type[] { typeof(string) }, new Type[] { typeof(double) }, new Type[] { typeof(double) }, }, out TokenState state, 1);
			string file = results[0].ToString();
			
			if (file == null)
				FormatError("File name is not a valid string!");

			// it was valid, add listings and process the file
			if (EnableListings) {
				byte[] text = ASCIIEncoding.Default.GetBytes("\t\tincbin \"" + file + "\"\n");
				ListingsFile.Write(text, 0, text.Length);
			}

			try {
				List<byte> bytes = new List<byte>();

				using(FileStream fs = new FileStream(file, FileMode.Open)) {
					// if we want to seek into the file, add the offset here
					if (results.Length > 1) {
						if(results[1] < 0)
							FormatError("The startindex argument must be a positive value!");

						fs.Seek((long)results[1], SeekOrigin.Begin);
					}

					int size = System.Int32.MaxValue, len = 0;
					byte[] buffer = new byte[1024];

					// if we want to limit the max number of bytes to read, process it here
					if(results.Length > 2) {
						if (results[2] < 0)
							FormatError("The length argument must be a positive value!");

						size = results[2];
					}

					// read file in chunks. We get the size of the last segment by substracting the length each go
					for(;size > 0;size -= len) {
						len = fs.Read(buffer, 0, Math.Min(buffer.Length, size));
						if (len <= 0) break;

						if(len != buffer.Length) {
							for (int i = 0;i < len;i++)
								bytes.Add(buffer[i]);

						} else bytes.AddRange(buffer);
					}
				}

				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));

			} catch (FileNotFoundException) {
				FormatError("Requested file " + file + " does not exist!");
			} catch (UnauthorizedAccessException) {
				FormatError("Requested file " + file + " could not be opened!");
			} catch (Exception ex) {
				FormatError("Requested file " + file + " caused an exception: " + ex.Message);
			}

			return new Tuple<TokenState, AssemblyToken>(state, null);
		}
		#endregion

		#region Control Flow
		public static Tuple<TokenState, AssemblyToken> Return(AssemblyTokenMacroRef Ref) {
			TokenState state = TokenState.Dynamic;

			if (Ref.Arguments.Count > 0) {
				var results = ConvertArguments("return", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[0] }, out TokenState stat);
				ReturnValue = new AssemblyTokenValue(results[0]);
				if (stat < state) state = stat;
			}

			Program.Return = true;
			return new Tuple<TokenState, AssemblyToken>(state, null);
		}
		#endregion

		#region Internals
		public static Tuple<TokenState, AssemblyToken> Macro(AssemblyTokenMacroRef Ref) {
			AssemblyTokenMacroSource ms = new AssemblyTokenMacroSource(Ref.Label, EquateFlags.None) {
				Arguments = Ref.Arguments.ToArray()
			};

			TokenList.Peek().Add(ms);
			TokenList.Push(ms.Container.Tokens);
			Program.CreateEquate(ms);
			return new Tuple<TokenState, AssemblyToken>(TokenState.Static, null);
		}

		public static Tuple<TokenState, AssemblyToken> Set(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("set", Ref.Arguments, new string[] { "value" }, new Type[][]{ new Type[0] }, out TokenState state);
			return _SetEqu(Ref, Ref.Label, results[0], EquateFlags.None, state);
		}

		public static Tuple<TokenState, AssemblyToken> Equ(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("equ", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[0] }, out TokenState state);
			return _SetEqu(Ref, Ref.Label, results[0], EquateFlags.Locked, state);
		}

		private static Tuple<TokenState, AssemblyToken> _SetEqu(AssemblyTokenMacroRef Ref, string label, dynamic val, EquateFlags flags, TokenState state) {
			// check if equate exists
			ushort hash = ComputeHash(label, false);
			AssemblyTokenEquate e = GetEquate(hash, label);

			if (e is null) {
				if (Equates[hash] == null)
					Equates[hash] = new List<AssemblyTokenEquate>();
				
				Equates[hash].Add(e = new AssemblyTokenEquate(label, val, flags));
				e.Owner = Ref;

			} else {
				if ((e.Flags & EquateFlags.Locked) != 0 && !e.Owner.Equals(Ref))
					FormatError("Can not modify equate " + label + " because its value is locked!");

				e.Value = val;
				if (flags == EquateFlags.Locked)
					e.Flags |= EquateFlags.Locked;
			}

			// prevent auto-optimization!
			if (state == TokenState.Static && flags == EquateFlags.None)
				state = TokenState.Dynamic;

			e.State = state;
			return new Tuple<TokenState, AssemblyToken>(state, e);
		}

		public static Tuple<TokenState, AssemblyToken> Align(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("align", Ref.Arguments, new string[] { "alignment" }, new Type[][] { new Type[] { typeof(double) } }, out TokenState state);

			long diff = Address % (long)results[0];
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(diff == 0 ? new byte[0] : GetAlignBytes((long)results[0] - (diff))));
		}

		public static Tuple<TokenState, AssemblyToken> Cpu(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("cpu", Ref.Arguments, new string[] { "identifier" }, new Type[][] { new Type[] { typeof(string), typeof(double) } }, out TokenState state);
			if (state < TokenState.Dynamic) state = TokenState.Dynamic;

			Processor cpu;
			string scpu = results[0];

			if(scpu != null) {
				if (!Enum.TryParse(scpu.ToUpperInvariant(), out cpu))
					FormatError("Unknown CPU type " + scpu +"!");

			} else {
				Processor? xcpu = results[0] as Processor?;

				if(xcpu == null)
					FormatError("Unknown CPU type " + results[0] + "!");

				cpu = (Processor)xcpu;
			}

			Options.SetCPU(cpu);
			return new Tuple<TokenState, AssemblyToken>(TokenState.Dynamic, null);
		}

		public static Tuple<TokenState, AssemblyToken> Eval(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("eval", Ref.Arguments, new string[] { "expression" }, new Type[][] { new Type[0] }, out TokenState state);

			AssemblyToken s = null;
			if (results[0] is string) 
				s = new AssemblyTokenEquateRef(results[0] as string);
			 
			else if (results[0].GetType().IsArray && results[0].GetType().BaseType == typeof(byte))
				s = new AssemblyTokenData(results[0]);

			else s = new AssemblyTokenValue(results[0]);

			s = s.Solve(out TokenState stat);
			if (stat > state) state = stat;
			return new Tuple<TokenState, AssemblyToken>(state, s);
		}

		public static Tuple<TokenState, AssemblyToken> CreateEquate(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("createequate", Ref.Arguments, new string[] { "name", "value" }, new Type[][] { new Type[] { typeof(string) }, new Type[0] }, out TokenState state);
			ushort hash = ComputeHash(results[0] as string);

			AssemblyTokenEquate e = GetEquate(hash, results[0] as string);
			if (e is null) {
				Program.CreateEquate(e = new AssemblyTokenEquate(results[0] as string, results[1]));

			} else if ((e.Flags & EquateFlags.Locked) == 0)
				e.Value = results[1];

			else FormatError("Can not modify equate " + results[0] + " because its value is locked!");

			return new Tuple<TokenState, AssemblyToken>(TokenState.Dynamic, e);
		}

		public static Tuple<TokenState, AssemblyToken> Obj(AssemblyTokenMacroRef Ref) {
			Program.Object = 0;

			if(Ref.Arguments.Count > 0) {
				var results = ConvertArguments("obj", Ref.Arguments, new string[] { "address" }, new Type[][] { new Type[] { typeof(long) } }, out TokenState state);

				if (results[0] < 0)
					FormatError("Object address must be positive!");

				Program.Object = (uint)results[0] - FileAddress;
			}

			return new Tuple<TokenState, AssemblyToken>(TokenState.Dynamic, null);
		}

		public static Tuple<TokenState, AssemblyToken> Org(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("org", Ref.Arguments, new string[] { "address" }, new Type[][] { new Type[] { typeof(long) } }, out TokenState state);
			long addr = results[0] - (int)Program.Object;

			if (addr < 0) FormatError("Can not set address before start of file! Attempted to seek to "+ (addr & 0xFFFFFFFF).ToString("X8") +"!");
			return new Tuple<TokenState, AssemblyToken>(TokenState.Dynamic, new AssemblyTokenAddress((uint)addr));
		}
		#endregion

		#region Casting
		public static Tuple<TokenState, AssemblyToken> Char(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("char", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[] { typeof(double) } }, out TokenState state);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue((char)results[0]));
		}

		public static Tuple<TokenState, AssemblyToken> Byte(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("byte", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[] { typeof(double) } }, out TokenState state);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue((byte) results[0]));
		}

		public static Tuple<TokenState, AssemblyToken> Sbyte(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("sbyte", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[] { typeof(double) } }, out TokenState state);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue((sbyte)results[0]));
		}

		public static Tuple<TokenState, AssemblyToken> Int16(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("int16", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[] { typeof(double) } }, out TokenState state);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue((short)results[0]));
		}

		public static Tuple<TokenState, AssemblyToken> Uint16(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("uint16", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[] { typeof(double) } }, out TokenState state);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue((ushort)results[0]));
		}

		public static Tuple<TokenState, AssemblyToken> Int32(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("int32", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[] { typeof(double) } }, out TokenState state);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue((int)results[0]));
		}

		public static Tuple<TokenState, AssemblyToken> Uint32(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("uint32", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[] { typeof(double) } }, out TokenState state);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue((uint)results[0]));
		}

		public static Tuple<TokenState, AssemblyToken> Int64(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("int64", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[] { typeof(double) } }, out TokenState state);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue((long)results[0]));
		}

		public static Tuple<TokenState, AssemblyToken> Uint64(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("uint64", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[] { typeof(double) } }, out TokenState state);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue((ulong)results[0]));
		}

		public static Tuple<TokenState, AssemblyToken> Float(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("float", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[] { typeof(double) } }, out TokenState state);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue((float)results[0]));
		}

		public static Tuple<TokenState, AssemblyToken> Double(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("double", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[] { typeof(double) } }, out TokenState state);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue((double)results[0]));
		}

		public static Tuple<TokenState, AssemblyToken> IsValue(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("isvalue", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[0] }, out TokenState state);
			bool chk = false;

			try {
				double d = (double)results[0];
				chk = true;
			} catch (Exception) { }

			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue(chk ? 1 : 0));
		}

		public static Tuple<TokenState, AssemblyToken> Hex(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("hex", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[] { typeof(long) } }, out TokenState state);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue(results[0].ToString("X")));
		}
		#endregion

		#region Arrays
		public static Tuple<TokenState, AssemblyToken> Array(AssemblyTokenMacroRef Ref) {
			dynamic[] o = new dynamic[Ref.Arguments.Count];
			TokenState state = TokenState.Static;

			for (int i = 0;i < o.Length;i++) {
				AssemblyToken solved = Context.CalculateEquationTokens(Ref.Arguments[i]);
				solved = Context.SolveTokens(solved, out TokenState sta);
				AssemblyTokenValue sv = solved as AssemblyTokenValue;
				o[i] = sv?.Value;

				if (sta > state) state = sta;
			}

			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue(o));
		}

		public static Tuple<TokenState, AssemblyToken> Length(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("length", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[] { typeof(dynamic[]) } }, out TokenState state);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue(results[0].Length));
		}

		public static Tuple<TokenState, AssemblyToken> IsArray(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("isarray", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[0] }, out TokenState state);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue(results[0].GetType().IsArray ? 1 : 0));
		}

		public static Tuple<TokenState, AssemblyToken> IndexOf(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("indexof", Ref.Arguments, new string[] { "array", "value" }, new Type[][] { new Type[] { typeof(dynamic[]), typeof(string) }, new Type[0] }, out TokenState state);

			if (results[0] is string && !(results[1] is char)) {
				// string.indexof()
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue((results[0] as string).IndexOf(results[1].ToString(), StringComparison.InvariantCultureIgnoreCase)));
			}

			// array.indexof
			int i = results[0].Length - 1;
			for (;0 <= i;i--) {
				// lets just abuse the code I've written for operators for AssemblyTokenValue's, that should give an equality depending on value rather than reference
				// yes its really ugly and probably slow, but hey, it works! Maybe
				if (((new AssemblyTokenValue(results[1]) == new AssemblyTokenValue(results[0][i])) as AssemblyTokenValue)?.Value == 1)
					break;
			}

			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue(i));
		}
		#endregion

		#region Strings
		public static Tuple<TokenState, AssemblyToken> String(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("string", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[] { typeof(string) } }, out TokenState state);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue((string)results[0]));
		}

		public static Tuple<TokenState, AssemblyToken> IsString(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("isstring", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[0] }, out TokenState state);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue(results[0] is string ? 1 : 0));
		}

		public static Tuple<TokenState, AssemblyToken> ToUpper(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("toupper", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[] { typeof(string) } }, out TokenState state);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue((results[0] as string).ToUpperInvariant()));
		}

		public static Tuple<TokenState, AssemblyToken> ToLower(AssemblyTokenMacroRef Ref) {
			var results = ConvertArguments("tolower", Ref.Arguments, new string[] { "value" }, new Type[][] { new Type[] { typeof(string) } }, out TokenState state);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenValue((results[0] as string).ToLowerInvariant()));
		}
		#endregion
	}
}