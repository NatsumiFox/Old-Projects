//#define BENCHMARK		// 35ms 43ms 53ms 55ms 75ms 116ms 119ms 172ms 183ms 599ms 612ms 517ms 260ms 286ms 530ms 667ms 541ms 557ms 549ms 568ms 560ms
//#define PASSTIMER
#define TEST_SONIC1
//#define DUAL_PCM
//#define TEST_MATH
//#define TEST_M68K

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;

namespace MDASM {
	class Program : AssemblyTokenContainer {
		#region Init
		public static Program Context;

		public static void Main(string[] args) {
			Console.Title = "MDASM";
			// this lines makes sure Decimal points are always . instead of , for some regions!!!
			CultureInfo.DefaultThreadCurrentCulture = CultureInfo.InvariantCulture;

			try {
#if BENCHMARK
				long[] res = new long[25];

				for(int i = 0;i < res.Length;i++) {
					Pass = -1;
					FileAddress = 0;
					Labels = new List<AssemblyTokenLabel>();
					Equates = new List<AssemblyTokenEquate>[0x10000];
					Context = new Program();
					res[i] = Context.Run(args);
				}

				long avg = 0;

				for(int i = 1;i < res.Length;i++) {
					avg += res[i];
					Console.WriteLine("Run "+ i +": " + res[i] + " ms!");
				}

				Console.WriteLine("AVG: " + (avg / (res.Length - 1)) + " ms!");
				Console.WriteLine("Total: " + avg + " ms!");
#else
				Context = new Program();
				Context.Run(args);
#endif
				Console.ReadKey();
			} catch (Exception ex) {
				if(IsFile())
					Error("Unhandled exception in "+ GetFilename() +":"+ GetLine() + " - " + ex);
				else Error("Unhandled exception: " + ex);
			}
		}
		#endregion

		#region Errors
		public static void FormatError(string text) {
			FormatError(GetFilename(), GetLine(), text);
		}

		public static void FormatError(string file, uint line, string text) {
			Error((CurrentFileName??file) + ":" + (CurrentFileName == null ? line : CurrentLine) + "\n-- " + text.Replace("\n", "\n-- "));
		}

		public static string CurrentFileName;
		public static uint CurrentLine;

		public static void Error(string text) {
			Console.WriteLine(text);

			if (!(Context is null)) {
				if (ListingsFile != null) {
					text = "; " + text.Replace("\n", "\n; ");
					byte[] te = ASCIIEncoding.Default.GetBytes(text);
					ListingsFile.Write(te, 0, te.Length);
				}

				Context.CleanUp();
			}

			Console.ReadKey();
			Environment.Exit(0);
		}
		#endregion

		#region Equates
		public static List<AssemblyTokenEquate>[] Equates = new List<AssemblyTokenEquate>[0x10000];

		private void InitializeEquate() {
			CreateEquateInternal(Options);
			CreateEquateInternal(new AssemblyTokenEquate("true", 1, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenEquate("false", 0, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenEquate("null", null, EquateFlags.Locked));

			CreateEquateInternal(new AssemblyTokenEquateCode("pc", () => Address, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenEquateCode("offset", () => Object, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenEquateCode("position", () => FileAddress, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenEquateCode("pass", () => Pass, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenEquateCode("curcpu", () => (int)Options.Processor, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenEquateCode("cpuname", () => Options.Processor.ToString(), EquateFlags.Locked));

			CreateEquateInternal(new AssemblyTokenMacroInternal("End", InternalMacros.Noop, EquateFlags.Locked));

			CreateEquateInternal(new AssemblyTokenMacroInternal("Macro", InternalMacros.Macro, EquateFlags.Locked | EquateFlags.EatLabel | EquateFlags.EvalueateImmediately | EquateFlags.DontList));
			CreateEquateInternal(new AssemblyTokenMacroInternal("equ", InternalMacros.Equ, EquateFlags.Locked | EquateFlags.EatLabel));
		//	CreateEquateInternal(new AssemblyTokenMacroInternal("set", InternalMacros.Set, EquateFlags.Locked | EquateFlags.EatLabel));
			CreateEquateInternal(new AssemblyTokenMacroInternal("=", InternalMacros.Set, EquateFlags.Locked | EquateFlags.EatLabel));
			CreateEquateInternal(new AssemblyTokenMacroInternal("obj", InternalMacros.Obj, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("org", InternalMacros.Org, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("align", InternalMacros.Align, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("even", InternalMacros.Even, EquateFlags.Locked | EquateFlags.AlignBefore | EquateFlags.AlignAlways));
			CreateEquateInternal(new AssemblyTokenMacroInternal("option", AssemblyTokenOptions.Macro, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("cpu", InternalMacros.Cpu, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("eval", InternalMacros.Eval, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("CreateEquate", InternalMacros.CreateEquate, EquateFlags.Locked));

			CreateEquateInternal(new AssemblyTokenMacroIf("If", EquateFlags.Locked | EquateFlags.EvalueateImmediately | EquateFlags.DontList, false, false));
			CreateEquateInternal(new AssemblyTokenMacroIf("Elseif", EquateFlags.Locked | EquateFlags.EvalueateImmediately | EquateFlags.DontList, true, false));
			CreateEquateInternal(new AssemblyTokenMacroIf("Else", EquateFlags.Locked | EquateFlags.EvalueateImmediately | EquateFlags.DontList, true, true));
			CreateEquateInternal(new AssemblyTokenMacroRept("Rept", EquateFlags.Locked | EquateFlags.EvalueateImmediately | EquateFlags.DontList));
			CreateEquateInternal(new AssemblyTokenMacroInternal("Return", InternalMacros.Return, EquateFlags.Locked));

			CreateEquateInternal(new AssemblyTokenMacroInternal("Include", InternalMacros.Include, EquateFlags.Locked | EquateFlags.EvalueateImmediately | EquateFlags.DontList));
			CreateEquateInternal(new AssemblyTokenMacroInternal("Binclude", InternalMacros.Incbin, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("Incbin", InternalMacros.Incbin, EquateFlags.Locked | EquateFlags.AlignBefore));
			CreateEquateInternal(new AssemblyTokenMacroInternal("dc", InternalMacros.Data, EquateFlags.Locked | EquateFlags.AlignSpecial));
			CreateEquateInternal(new AssemblyTokenMacroInternal("db", InternalMacros.Datab, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("dw", InternalMacros.Dataw, EquateFlags.Locked | EquateFlags.AlignBefore));
			CreateEquateInternal(new AssemblyTokenMacroInternal("dl", InternalMacros.Datal, EquateFlags.Locked | EquateFlags.AlignBefore));

			CreateEquateInternal(new AssemblyTokenMacroInternal("Print", InternalMacros.Print, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("ArgsToString", InternalMacros.ArgsToString, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("Exec", InternalMacros.Execute, EquateFlags.Locked));

			CreateEquateInternal(new AssemblyTokenMacroInternal("mc68k", M68k.Indirect, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("z80", Z80.Indirect, EquateFlags.Locked));

			// cast functions
			CreateEquateInternal(new AssemblyTokenMacroInternal("byte", InternalMacros.Byte, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("sbyte", InternalMacros.Sbyte, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("int16", InternalMacros.Int16, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("uint16", InternalMacros.Uint16, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("int32", InternalMacros.Int32, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("uint32", InternalMacros.Uint32, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("int64", InternalMacros.Int64, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("uint64", InternalMacros.Uint64, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("float", InternalMacros.Float, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("char", InternalMacros.Char, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("double", InternalMacros.Double, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("isvalue", InternalMacros.IsValue, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("hex", InternalMacros.Hex, EquateFlags.Locked));

			// array functions
			CreateEquateInternal(new AssemblyTokenMacroInternal("array", InternalMacros.Array, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("isarray", InternalMacros.IsArray, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("length", InternalMacros.Length, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("indexof", InternalMacros.IndexOf, EquateFlags.Locked));

			// string functions
			CreateEquateInternal(new AssemblyTokenMacroInternal("string", InternalMacros.String, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("isstring", InternalMacros.IsString, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("ToLower", InternalMacros.ToLower, EquateFlags.Locked));
			CreateEquateInternal(new AssemblyTokenMacroInternal("ToUpper", InternalMacros.ToUpper, EquateFlags.Locked));

			CreateEquateInternal(new AssemblyTokenMacroInternal("GetRandomNumber", InternalMacros.GetRandomNumber, EquateFlags.Locked));
		}

		private static bool IsEquChar(char b) => (b >= 'a' && b <= 'z') || (b >= 'A' && b <= 'Z') || b == '_' || (b >= '0' && b <= '9');

		// compute hash and check if valid name
		public static ushort ComputeHash(string name, bool ckvalid = true) {
			ushort hash = 0;

			// special case, first character can not be a number and equate must be longer than 0 chars
			if (ckvalid && name.Length == 0 || (name[0] >= '0' && name[0] <= '9'))
				FormatError("Equate " + name + " is invalid!");

			for (int i = name.Length - 1;i >= 0;i--) {
				hash = (ushort)((hash << 2) | (hash >> 6) & 3);
				hash ^= (char)(name[i] & 0xDF);

				if (ckvalid && !IsEquChar(name[i]))
					FormatError("Equate " + name + " is invalid!");
			}

			return hash;
		}

		// if list contains equate name, return that equate
		public static AssemblyTokenEquate GetEquate(ushort hash, string name) {
			if (Equates[hash] != null) {
				foreach (AssemblyTokenEquate e in Equates[hash]) {
					if (name.Equals(e.Name, StringComparison.InvariantCultureIgnoreCase))
						return e;
				}
			}

			return null;
		}

		// find the equate being asked for, or return null
		public static AssemblyTokenEquate FindEquate(string name) {
			ushort hash = ComputeHash(name, false);
			return GetEquate(hash, name);
		}

		// this is used for some special functionality
		public static List<AssemblyTokenLabel> Labels = new List<AssemblyTokenLabel>();

		// attempt to create a new label
		public static AssemblyTokenLabel CreateLabel(string tokenlabel) {
			AssemblyTokenLabel lb = new AssemblyTokenLabel(tokenlabel);
			CreateEquate(lb);
			Labels.Add(lb);
			//	Console.Write("LABEL at "+ CurrentFile.Line +": "+ tokenlabel + "\n");

			if (EnableListings) {
				byte[] text = ASCIIEncoding.Default.GetBytes("\t" + tokenlabel + ":\n");
				ListingsFile.Write(text, 0, text.Length);
			}

			return lb;
		}

		// attempt to create a new equate
		public static void CreateEquateInternal(AssemblyTokenEquate eq) {
			CreateEquate(eq, false, false);
		}

		// attempt to create a new equate
		public static void CreateEquate(AssemblyTokenEquate eq, bool ckvalid = false, bool ckdup = true) {
			ushort hash = ComputeHash(eq.Name, ckvalid);
		
			if (Equates[hash] == null)
				Equates[hash] = new List<AssemblyTokenEquate>();

			if (ckdup && !(GetEquate(hash, eq.Name) is null))
				FormatError("Equate " + eq.Name + " already exists!");

			// add the equate into the token list
			Equates[hash].Add(eq);
		}

		// delete the specific equate
		public static bool DelEquate(AssemblyTokenEquate eq) {
			ushort hash = ComputeHash(eq.Name, false);
			return Equates[hash].Remove(eq);
		}
		#endregion

		#region Lifetime & Variables
		public static Stream CurrentFile;
		public static AssemblyStream OutputFile;
		public static Stream ListingsFile;
		public static Stack<List<AssemblyToken>> TokenList;
		public static AssemblyTokenOptions Options;
		public static int Pass = -1;
		public static uint Object = 0, FileAddress = 0;
		public static uint Address => FileAddress + Object;
		public static bool EnableListings = false, IgnoreLabelRebase = false;

		// macros flow
		public static bool Return = false;
		public static AssemblyTokenValue ReturnValue = null;

		private static bool IsFile() => CurrentFile is AssemblyStream;

		public static string GetFilename() {
			if (CurrentFile is AssemblyStream a)
				return a.FileName;
			return "<Expression>";
		}

		public static uint GetLine() {
			if (CurrentFile is AssemblyStream a)
				return a.Line;
			return 0;
		}

		private long Run(string[] args) {
#if TEST_SONIC1
			args = new string[] { "sonic1.asm", "testbuilt.bin" };
			Directory.SetCurrentDirectory(@"G:\disassemblies\s1hive\");
#endif

#if TEST_MATH
			args = new string[] { "math test.asm", ".dat", ".lst" };
#endif

#if TEST_M68K
			args = new string[] { "m68k test.asm", ".dat", ".lst" };
#endif

#if DUAL_PCM
			Directory.SetCurrentDirectory(@"G:\disassemblies\s1hive\z80\");
			args = new string[] { "DUALPCM.ASM", ".dat" };
#endif

			int ao = 0;
			Stopwatch time = new Stopwatch();
			time.Start();

			// initialize things enough for argument parsing to occur
			Tokens = new List<AssemblyToken>();
			TokenList = new Stack<List<AssemblyToken>>();
			TokenList.Push(Tokens);
			Options = new AssemblyTokenOptions("OptionsData");
			InitializeEquate();

			// TODO: Check flags here
			next:
			if(args.Length > ao && args[ao].Length > 1 && args[ao][0] == '-') {
				// this is likely an option, process is
				switch (args[ao++].Substring(1)) {
					case "e": case "expr": {
							if(args.Length <= ao)
								Usage("Expression flag requires an additional parameter as an expression, but no additional parameters were given!");

							// this is an expression separated by \> tokens (these will be converted to a new line)
							byte[] things = Encoding.UTF8.GetBytes(" " + args[ao++].Replace("\\>", "\n "));
							CurrentFile = new MemoryStream(things);
							ParseFile();
							CurrentFile.Dispose();
						}
						break;

					default:
						Usage("Flag " + args[0] + " is unknown!");
						break;
				}

				goto next;
			}

			// check if we have more entries
			if (args.Length - ao < 2)
				Usage("Missing arguments");

			// check input file and create the file stack
			if (!File.Exists(args[ao]))
				Usage("Input file '" + args[ao] + "' does not exist!");

#if PASSTIMER
			Stopwatch time2 = new Stopwatch();
#endif

			using (CurrentFile = new AssemblyStream(args[ao++], FileMode.Open)) {
				// create stream for output file
				try {
					OutputFile = new AssemblyStream(args[ao], FileMode.Create);
				} catch (Exception ex) {
					Usage("Failed to create output file '" + args[ao] + "'! Error: " + ex.Message);
				}

				// if listings file was defined, create that as well
				if (args.Length > ao + 1) {
					try {
						ListingsFile = new AssemblyStream(args[++ao], FileMode.Create);
						EnableListings = true;

					} catch (Exception ex) {
						Usage("Failed to create output file '" + args[ao] + "'! Error: " + ex.Message);
					}
				} else EnableListings = false;

				// print various info here
				{
					FileVersionInfo fv = FileVersionInfo.GetVersionInfo(Assembly.GetExecutingAssembly().Location);
					byte[] text = ASCIIEncoding.Default.GetBytes("MDASM/beta version " + fv.FileVersion + "\n\n");
					Console.OpenStandardOutput().Write(text, 0, text.Length);

					if (EnableListings) {
						ListingsFile.WriteByte((byte)';');
						ListingsFile.WriteByte((byte)' ');
						ListingsFile.Write(text, 0, text.Length);
					}
				}

#if PASSTIMER
				time2.Start();
#endif

				// run first pass: Parse the files into token trees
				StartPass();
				ParseFile();

#if PASSTIMER
				time2.Stop();
				Console.WriteLine("Pass took " + time2.ElapsedMilliseconds + " ms!");
#endif
			}

#if PASSTIMER
			time2.Restart();
#endif

			// second pass: Get baseline for conversion
			StartPass();
			AssemblyToken t = Solve(out TokenState state);
			AssemblyTokenData d = t as AssemblyTokenData;

#if PASSTIMER
			time2.Stop();
			Console.WriteLine("Pass took " + time2.ElapsedMilliseconds + " ms!");
#endif

			while (state == TokenState.Indeterminate) {
#if PASSTIMER
				time2.Restart();
#endif

				// further passes: loop until checksum is the same twice
				StartPass();
				if (Pass >= 10) {
#if TEST_SONIC1
					File.WriteAllBytes(args[ao] + ".error.bin", d.Value);
#endif
					PrintLabel("CheckForSamples");
					Error("Possible infinite passes detected! Aborting...");

				}

				t = Solve(out state);
				d = t as AssemblyTokenData;

#if PASSTIMER
				time2.Stop();
				Console.WriteLine("Pass took " + time2.ElapsedMilliseconds + " ms!");
#endif
			}

			// write the final result in output file
			if (d is null) Error("The assembly returned an invalid result!");
			OutputFile.Write(d.Value, 0, d.Value.Length);

			// finish assembly
			time.Stop();
			{
				byte[] text = ASCIIEncoding.Default.GetBytes("Assembly completed in " + (Math.Round(time.ElapsedMilliseconds / 1000.0, 1) +"").Replace(',', '.') + " seconds! (" + time.ElapsedMilliseconds + " ms)\n");
				Console.WriteLine();
				Console.OpenStandardOutput().Write(text, 0, text.Length);

				if (EnableListings) {
					ListingsFile.WriteByte((byte)'\n');
					ListingsFile.WriteByte((byte)';');
					ListingsFile.WriteByte((byte)' ');
					ListingsFile.Write(text, 0, text.Length);
				}
			}

			CleanUp();
#if !BENCHMARK && DUAL_PCM
			InternalMacros.Execute(new AssemblyTokenMacroRef(null) { Arguments = new List<string>() { "\"G:\\\\C#\\\\MDASM\\\\tests\\\\VBinDiff.exe dualpcm.dat .dat\"" } });
#endif
#if !BENCHMARK && TEST_SONIC1
		//	InternalMacros.Execute(new AssemblyTokenMacroRef(null) { Arguments = new List<string>() { "\"G:\\\\C#\\\\MDASM\\\\tests\\\\VBinDiff.exe s1built.bin testbuilt.bin\"" } });
			//InternalMacros.Execute(new AssemblyTokenMacroRef(null) { Arguments = new List<string>() { "\"G:\\\\C#\\\\MDASM\\\\tests\\\\VBinDiff.exe z80.dmp testbuilt.bin\"" } });
			InternalMacros.Execute(new AssemblyTokenMacroRef(null) { Arguments = new List<string>() { "\"G:\\\\C#\\\\MDASM\\\\tests\\\\VBinDiff.exe z80/megapcm.z80 testbuilt.bin\"" } });
#endif
			return time.ElapsedMilliseconds;
		}

		public void PrintLabel(string str) {
			AssemblyTokenEquate e = FindEquate(str);
			Console.Write(str +": ");

			if (e is null) Console.WriteLine("null");
			else Console.WriteLine(e.Value.ToString("X6"));
		}

		private void Usage(string error) {
			Error(error + "\n\n" +
				"Usage: MDASM.exe [flags] <inputfile> <outputfile> [listingsfile]\n" +
				"  <inputfile> :    Input source file to start assembly from.\n" +
				"  <outputfile> :   Output data file where assembly product will be put.\n" +
				"  [listingsfile] : Output text file containing various information gathered on\n" +
				"                   assembly-time\n" +
				"  [flags] :        Various program flags you can apply via the commandline.\n" +
				"                   Please view them below\n" +
				"\n" +
				" -e <expression> :  Evaluate various expressions before assembly begins.\n" +
				"                    These expressions are treated as if they originated from\n" +
				"                    the main assembly file.\n" +


				"");
		}

		// clean up after assembling
		private void CleanUp() {
			if(CurrentFile != null) {
				CurrentFile.Close();
			}

			if(OutputFile != null) {
				OutputFile.Flush();
				OutputFile.Close();
			}

			if (EnableListings) {
				ListingsFile.Flush();
				ListingsFile.Close();
			}
		}

		// initialize new pass, and inform the user
		private void StartPass() {
			FileAddress = Object = 0;

			if(++Pass == 0)
				Console.WriteLine("Parsing input files...");
			else Console.WriteLine("Pass "+ Pass);

			if (EnableListings) {
				byte[] text = ASCIIEncoding.Default.GetBytes("; " + new string('-', 78) + "\n; Pass " + Pass + "\n; " + new string('-', 78) + "\n\n");
				ListingsFile.Write(text, 0, text.Length);
			}
		}
		#endregion

		#region Parsing Files
		// temporary buffer to hold whatever
		public char[] buffer = new char[4096];
		public int buffera = 0;

		public byte[] _rbuf = new byte[4096];
		public int _rind = 0, _rlen = 0;

		private bool IsSpaceChar(char b) => b == ' ' || b == '\t' || b == '\n' || b == '\r' || b == ';' || b == '{' || b == '}';

		// parse every file we come accross as tokens into our tokentree
		public void ParseFile() {
			bool label = true, tokensrc = false, comment = false, escaped = false, readfullline = false, prevspc = false, exit = false;
			string tokenlabel = null;
			char strchar = '\0';

			CurrentToken curtoken = CurrentToken.None;
			AssemblyTokenMacroRef MacroRef = null;		// if not null, we are currently parsing a macro reference
			int macrodep = -1;

			while (!exit) {
				if (_rind >= _rlen) {
				//	Console.WriteLine(_rind + " " + _rlen);
					_rlen = CurrentFile.Read(_rbuf, 0, _rbuf.Length);
					exit = _rlen == 0;
					_rind = 0;
				}

				char b = exit ? '\n' : (char)_rbuf[_rind++];
				bool tokensrcen = false;

				// check if we need to abort deciphering current token
				bool spc = strchar == 0 && IsSpaceChar(b);
				if (strchar == 0 && !readfullline && (spc || b == '(' || b == ')' || b == '.' || (label && b == ':'))) {
					if (buffera > 0) {
						if (label) {
							// we are processing a label
							string s = new string(buffer, 0, buffera);
							buffera = 0;
							tokenlabel = s;

						} else if(curtoken == CurrentToken.None) {
							// asseume this is a macro
							MacroRef = new AssemblyTokenMacroRef(new string(buffer, 0, buffera));
							curtoken = CurrentToken.Macro;
							macrodep = -1;
							buffera = 0;
							readfullline = true;
						}
					}

					label = false;
					tokensrcen = !comment;
					tokensrc = strchar != 0;
				}

				// record the data for when we need it later
				if (tokensrc && (strchar != 0 || !spc) && buffera < buffer.Length)
					buffer[buffera++] = b;

				if (tokensrcen) tokensrc = true;

				int endtoken = 0;
				if (spc) {
					// check the specific byte we read, make sure stuff works out correctly
					if (b == ';') {
						endtoken = -3;
						readfullline = comment = true;
						tokensrc = false;

					} else if (b == '\n') {
						endtoken = -1;
						readfullline = comment = false;
						tokensrc = label = true;

					} else if (b == '}') {
						TokenList.Pop();
						if(TokenList.Count == 0)
							FormatError("An unexpected '}' occurred!");

					} else if (curtoken == CurrentToken.MacroSize) {
						endtoken = 2;
					}

				} else {
					// some logic for detecting strings (that should not be char optimized!!!) and proper escaping
					if (b == '"' || b == '\'') {
						if (!comment && !escaped) {
							if (strchar == b) strchar = '\0';
							else if (strchar == 0) strchar = (char)b;
						}

					} else if (strchar == 0) {
						if (b == '(') {
							// if this is a macro, we need to check if macro declaration should be braced or not
							if (curtoken == CurrentToken.Macro && buffera == 0 && !prevspc)
								curtoken = CurrentToken.MacroBraces;

							else if (curtoken == CurrentToken.MacroBraces || curtoken == CurrentToken.Macro)
								macrodep++;

						} else if (b == ')') {
							if (curtoken == CurrentToken.MacroBraces || curtoken == CurrentToken.Macro)
								if (macrodep-- < 0) {
									if (curtoken == CurrentToken.MacroBraces) {
										// macro was finished, execute it
										endtoken = -2;
										buffera--;
									}
								} else if (macrodep < -1)
									FormatError("Invalid ')' in macro declaration!");

						} else if (b == ',') {
							if (macrodep < 0 && (curtoken == CurrentToken.Macro || curtoken == CurrentToken.MacroBraces)) {
								endtoken = 1;
								buffera--;
							}

						} else if (b == '.') {
							if (curtoken == CurrentToken.Macro && buffera == 0 && MacroRef.Size == null) {
								buffera = 0;
								curtoken = CurrentToken.MacroSize;
							}
						}
					}

					escaped = strchar != 0 && b == '\\';
				}

				if (endtoken != 0) {
					EquateFlags flags = EquateFlags.None;

					if(curtoken == CurrentToken.MacroSize) {
						// save macro size argument
						curtoken = CurrentToken.Macro;
						MacroRef.Size = new string(buffer, 0, buffera);
						buffera = 0;

					} else if (curtoken == CurrentToken.MacroBraces && (endtoken < 0 && endtoken != -2)) {
						FormatError("Macro call to " + MacroRef.Name + " is incomplete!");

					} else if (curtoken == CurrentToken.Macro || curtoken == CurrentToken.MacroBraces) {
						// make sure we evaluate any expressions - Special case: If the first argument is 0 characters long, do not add it
						if(buffera != 0 || endtoken == 1 || MacroRef.Arguments.Count != 0)
							MacroRef.Arguments.Add(new string(buffer, 0, buffera));
						buffera = 0;

						// if total end token, also process the macro now
						if (endtoken < 0)
							flags = MacroRef.GetFlags();
					}
					
					// check if we need to declare the label separately
					if(endtoken < 0) {
						if(tokenlabel != null && (flags & EquateFlags.EatLabel) == 0) {
							// generate new label and create a helpder object to update its address
							AssemblyTokenLabel lb = CreateLabel(tokenlabel);
							TokenList.Peek().Add(new AssemblyTokenUpdateLabel(lb));
						}

						// add the macro *after* the label!
						if (curtoken == CurrentToken.Macro || curtoken == CurrentToken.MacroBraces) {
							MacroRef.Label = tokenlabel;
							
							// check if we need to evaluate it also
							if ((flags & EquateFlags.EvalueateImmediately) != 0) {
								AssemblyToken a = MacroRef.Solve(out TokenState dummy);

								if((flags & EquateFlags.DontList) == 0) TokenList.Peek().Add(MacroRef);
								else if (!(a is null)) TokenList.Peek().Add(a);

							} else if ((flags & EquateFlags.DontList) == 0) TokenList.Peek().Add(MacroRef);

							// reset to appropriate state
							curtoken = CurrentToken.None;
							MacroRef = null;
							readfullline = endtoken == -3;
						}

						tokenlabel = null;
					}

					buffera = 0;
				}

				if(b == '\n' && CurrentFile is AssemblyStream ass)
					ass.Line++;
				prevspc = spc;
			}
		}

		// check a string in the temporary buffer matches C# string
		private bool CheckStr(string str, int buffo = 0) {
			for (int i = buffo;i < str.Length;i++) {
				char c = buffer[i + 1];

				// we are not case-sensitive folk here
				if (c >= 'A' && c <= 'Z')
					c |= (char)0x20;

				if (c != str[i - buffo])
					return false;
			}

			return true;
		}

		private readonly static char[] IncludeChars = { ' ', '\t', ';', '\'', '"', '\n', '\r' };
		#endregion

		#region Expression Tokenize
		private bool IsOperator(char c) => c == '+' || c == '-' || c == '=' || c == '!' || c == '|' || c == '&' || c == '^' || c == '~' || c == '*' || c == '/' || c == '%' || c == '<' || c == '>';

		// calculate the tokens inside of buffer and return it to the code
		public AssemblyToken CalculateEquationTokens(string text, int startoff = 0, int endoff = 0) {
			if(startoff == 0)
				return CalculateEquationTokens(text.ToCharArray(), text.Length - endoff);
			return CalculateEquationTokens(text.Substring(startoff, text.Length - startoff - endoff).ToCharArray(), text.Length - startoff - endoff);
		}

		public AssemblyToken CalculateEquationTokens(char[] buffer = null, int bpos = -1) {
			buffer = buffer ?? this.buffer;
			if (bpos < 0) bpos = buffera;

			List<EquationToken> tokens = new List<EquationToken>();
			int maxdepth = 0;

			// first, parse the expression into distinct tokens. This makes sure that we calculate them in the right order
			{
				List<int> funcdep = new List<int>();
				List<int> arrdep = new List<int>();

				EquationType type = EquationType.None;
				int depth = 0, tokenstart = -1;
				bool escaped = false;
				char strchar = '\0';

				for (int i = 0;i < bpos;i++) {
					char c = buffer[i];

					if (!escaped && type != EquationType.None && strchar == 0) {
						// check if a token is being ended
						if ((c < 'a' || c > 'z') && (c < 'A' || c > 'Z') && (c < '0' || c > '9') && c != '_' && c != '.') {
							switch (type) {
								case EquationType.Equate:
									if(c == '(') {
										// this is a function instead, prepare to read function stuffs
										type = EquationType.Function;
										funcdep.Add(depth + 1);
										break;
									}
									goto case EquationType.BinaryInteger;

								case EquationType.Function:
									if (c == ')' && funcdep.Count > 0 && funcdep.Last() == depth) {
										funcdep.RemoveAt(funcdep.Count - 1);

									} else break;
									goto case EquationType.BinaryInteger;

								case EquationType.UnkInteger:
									if (i > 1 && (buffer[i - 1] == 'b' || buffer[i - 1] == 'B'))
										type = EquationType.BinaryInteger;

									else type = EquationType.HexDecInteger;
									goto case EquationType.BinaryInteger;

								case EquationType.HexDecInteger: case EquationType.BinaryInteger:
									tokens.Add(new EquationToken(type, tokenstart, i, depth));
									type = EquationType.None;
									break;
							}
						}
					}

					if (type != EquationType.Function && (c == '"' || c == '\'')) {
						// this is a string delimiter, check what it might be
						if (!escaped) {
							if (strchar == c) {
								tokens.Add(new EquationToken(type, tokenstart, i, depth));
								strchar = '\0';
								type = EquationType.None;

							} else if (strchar == 0) {
								strchar = c;
								tokenstart = i + 1;
								type = EquationType.String;
							}
						}

					} else if (strchar == 0) {
						if (type != EquationType.Function && IsOperator(c)) {
							if (tokens.Count > 0 && tokens.Last().Type == EquationType.Operator) {
								// last one was an operator, check if this is a combined operator
								switch (buffer[i - 1]) {
									case '<': case '>': {
											char x = buffer[i];

											if (x == '=' || x == buffer[i - 1]) {
												EquationToken e = tokens.Last();
												tokens[tokens.Count - 1] = new EquationToken(e.Type, e.Start, i, depth);
												goto success;
											}
										}
										break;

									case '!': case '=': {
											if ('=' == buffer[i]) {
												EquationToken e = tokens.Last();
												tokens[tokens.Count - 1] = new EquationToken(e.Type, e.Start, i, depth);
												goto success;
											}
										}
										break;
								}
							}

							tokens.Add(new EquationToken(EquationType.Operator, i, i, depth));
							success:;

						} else if (c == '(') {
							depth++;
							if (depth > maxdepth) maxdepth = depth;

						} else if (c == ')') {
							if (--depth < 0)
								FormatError("Invalid ) in expression!");

						} else if (type != EquationType.Function && c == '[') {
							arrdep.Add(depth);
							tokens.Add(new EquationToken(EquationType.OpenArray, i, i, depth++));

							if (depth > maxdepth) maxdepth = depth;

						} else if (type != EquationType.Function && c == ']') {
							if (depth == 0)
								FormatError("Invalid ] in expression!");

							if (arrdep.Count != 0 && arrdep.Last() == --depth) {
								arrdep.RemoveAt(arrdep.Count - 1);
								tokens.Add(new EquationToken(EquationType.CloseArray, i, i, depth));

							} else FormatError("Encountered ] without a maching [!");

						} else if (c == ',') {
							if (type != EquationType.Function || funcdep.Count == 0 || funcdep.Last() > depth)
								FormatError("Invalid , in expression!");

						} else if (type == EquationType.None) {
							if((c == '$' || (c >= '0' && c <= '9'))) {
								// first character is a number or $, this can only be a number now
								tokenstart = i;
								type = c == '$' ? EquationType.HexDecInteger : EquationType.UnkInteger;

							} else {
								tokenstart = i;
								type = EquationType.Equate;
							}

						}
					}

					escaped = strchar != 0 && c == '\\';
				}

				// complete last token
				switch (type) {
					case EquationType.UnkInteger:
						if (bpos > 1 && (buffer[bpos - 1] == 'b' || buffer[bpos - 1] == 'B'))
							type = EquationType.BinaryInteger;

						else type = EquationType.HexDecInteger;
						goto case EquationType.BinaryInteger;

					case EquationType.HexDecInteger: case EquationType.Equate: case EquationType.Function: case EquationType.BinaryInteger:
						tokens.Add(new EquationToken(type, tokenstart, bpos, depth));
						break;
				}

				if(depth != 0)
					FormatError("Unmatched parenthesis in expression!");
			}

			// the next step converts these tokens into objects, and sorts them by depth level
			List<Tuple<int, AssemblyTokenValue>> alltokens = new List<Tuple<int, AssemblyTokenValue>>(tokens.Count);

			{
				AssemblyTokenValue last = null;
				for (int i = 0;i < tokens.Count;i++) {
					EquationToken t = tokens[i];
					AssemblyTokenValue result = null;

					// figure out what token to generate
					switch (t.Type) {
						case EquationType.String: 
							result = new AssemblyTokenValue(StringEscape(buffer, t.Start, t.End));
							break;

						case EquationType.OpenArray:
							result = new AssemblyTokenArrayAccess();
							break;

						case EquationType.CloseArray:	// here for future reference if needed
							break;

						case EquationType.Function: {
								AssemblyTokenMacroRef mcf =  new AssemblyTokenMacroRef(null);
								result = mcf;

								// we need a lot of specialized code to process functions
								int phase = 0, xlast = t.Start, depth = 0;

								for(int x = xlast;x <= t.End;x++) {
									int err = (x == t.End + 1 ? 1 : 0) | (phase < 3 ? 2 : 0);
									if(err == 3)
										FormatError("Incomplete macro declaration!");
									if(err == 0) FormatError("Internal macro declaration error!");

									switch (phase) {
										case 0:
											if (buffer[x] == '.' || buffer[x] == '(') {
												mcf.Name = new string(buffer, xlast, x - xlast);
												phase = 1;
												xlast = x + 1;
												goto case 1;		// if we ended with ( instead of ., the Size will be set to "" and phase skipped.
											}
											break;

										case 1:
											if (buffer[x] == '(') {
												if (x - xlast < 0) mcf.Size = "";
												else mcf.Size = new string(buffer, xlast, x - xlast);

												phase = 2;
												xlast = x + 1;
											}
											break;

										case 2:
											if (buffer[x] == '(') {
												depth++;

											} else if(depth > 0) {
												if(buffer[x] == ')' && --depth < 0)
													FormatError("Invalid ) in expression!");

											} else if (buffer[x] == ',' || buffer[x] == ')') {
												bool clos = buffer[x] == ')';
												if (clos) phase = 3;

												// special case, do not create empty argument if it would be the only one
												if(!clos || x - xlast > 0 | mcf.Arguments.Count != 0)
													mcf.Arguments.Add(new string(buffer, xlast, x - xlast));

												xlast = x + 1;
											}
											break;
									}
								}
							}
							break;

						case EquationType.Equate:
							result = new AssemblyTokenEquateRef(new string(buffer, t.Start, t.End - t.Start));
							break;

						case EquationType.HexDecInteger: 
							// check if buffer contains .

							for(int x = t.Start;x < t.End;x ++)
								if(buffer[x] == '.')
									goto doubl;

							// else, parse as a long
							result = new AssemblyTokenValue(ParseLong(buffer, t.Start, t.End));
							break;

							doubl: result = new AssemblyTokenValue(ParseDouble(buffer, t.Start, t.End));
							break;

						case EquationType.BinaryInteger:
							result = new AssemblyTokenValue(ParseBinary(buffer, t.Start, t.End));
							break;

						case EquationType.Operator: {
								switch (buffer[t.Start]) {
									case '+':
										// check if the last one was an operator too
										if(!(last is AssemblyTokenCalculation) && !(last is null))
											result = new AssemblyTokenAdd();
										break;

									case '-':
										if (last is null || last is AssemblyTokenCalculation)
											result = new AssemblyTokenNegate();
										else result = new AssemblyTokenSubstract();
										break;

									case '*':
										result = new AssemblyTokenMultiply();
										break;

									case '/':
										result = new AssemblyTokenDivide();
										break;

									case '%':
										result = new AssemblyTokenModulo();
										break;

									case '|':
										result = new AssemblyTokenOr();
										break;

									case '&':
										result = new AssemblyTokenAnd();
										break;

									case '^':
										result = new AssemblyTokenXor();
										break;

									case '~':
										result = new AssemblyTokenNot();
										break;

									case '!':
										if(t.End - t.Start > 0) {
											if (t.End - t.Start > 1)
												FormatError("Invalid sequence encountered: " + new string(buffer, t.Start, t.End - t.Start + 1));

											if (buffer[t.End] != '=')
												FormatError("Invalid sequence encountered: "+ buffer[t.Start] + buffer[t.End]);

											result = new AssemblyTokenNotEquals();

										} else result = new AssemblyTokenLogicalNot();
										break;

									case '=':
										if (t.End - t.Start > 0 && buffer[t.End] == '=') {
											if (t.End - t.Start > 1)
												FormatError("Invalid sequence encountered: " + new string(buffer, t.Start, t.End - t.Start + 1));

											result = new AssemblyTokenEquals();

										} else FormatError("Invalid sequence encountered: " + buffer[t.Start] + buffer[t.End]);
										break;

									case '<':
										if (t.End - t.Start > 0) {
											if(t.End - t.Start > 1)
												FormatError("Invalid sequence encountered: " + new string(buffer, t.Start, t.End - t.Start + 1));

											if (buffer[t.End] == '=') {
												result = new AssemblyTokenLessThanOrEquals();
												break;
											}

											if (buffer[t.End] == '<') {
												result = new AssemblyTokenShiftLeft();
												break;
											}

											FormatError("Invalid sequence encountered: " + buffer[t.Start] + buffer[t.End]);
											
										} else result = new AssemblyTokenLessThan();
										break;

									case '>':
										if (t.End - t.Start > 0) {
											if (t.End - t.Start > 1)
												FormatError("Invalid sequence encountered: " + new string(buffer, t.Start, t.End - t.Start + 1));

											if (buffer[t.End] == '=') {
												result = new AssemblyTokenMoreThanOrEquals();
												break;
											}

											if (buffer[t.End] == '>') {
												result = new AssemblyTokenShiftRight();
												break;
											}

											FormatError("Invalid sequence encountered: " + buffer[t.Start] + buffer[t.End]);

										} else result = new AssemblyTokenMoreThan();
										break;
								}
							}
							break;
					}

					// finally add the result into the list
					if (!(result is null)) {
						alltokens.Add(new Tuple<int, AssemblyTokenValue>(t.Depth, result));
						last = result;
					}
				}

				tokens.Clear();
				tokens = null;
			}

			// finally, sow these fuckers together in the right order... Somehow! I don't fucking know as your mum about it
			{
				List<AssemblyTokenValue> CurTokens = new List<AssemblyTokenValue>();

				while(alltokens.Count > 1) {
					bool foundgroup = false;

					for (int i = 0;i < alltokens.Count;i++) {
						if (alltokens[i].Item1 == maxdepth) {
							foundgroup = true;
							CurTokens.Add(alltokens[i].Item2);

						} else if (foundgroup)
							break;
					}
					
					// not sure why this happens, whatever, fix it
					if (CurTokens.Count == 0) {
						maxdepth--;
						continue;
					}

					// then we need to decipher which token is more important than the other
					next:
					int priority = 0, priorityitem = 0;

					for (int i = 0;i < CurTokens.Count; i++) {
						if(CurTokens[i] is AssemblyTokenCalculation ca) {

							// if the item has higher priority, save it instead
							if(!ca.IsFull() && ca.GetPrecendece() > priority) {
								priorityitem = i;
								priority = ca.GetPrecendece();
							}
						}
					}

					// we maybe found a valid item, process it
					AssemblyTokenValue left = null, middle = null, right = null;
					
					if (priorityitem > 0) left = CurTokens[priorityitem - 1];
					middle = CurTokens[priorityitem];
					if(priorityitem < CurTokens.Count - 1) right = CurTokens[priorityitem + 1];

					// check to make sure the items are valid for this operation
					if(middle is AssemblyTokenCalculation cmiddle) {
						if (cmiddle.IsUnary()) {
							if (!(right is null)) {
								// we may do a successful calculation
								AssemblyTokenCalculation cv = cmiddle;

								// find the last nonfull unary operator
								loop:
								if (cv.IsFull()) {
									if (cv.Left is AssemblyTokenCalculation cc) {
										if (!cc.IsUnary())
											Error("Internal failure: Unary operator search resulted in an error: Right side of unary operator is not another unary operator.");

										// ok, this is valid
										cv = cc;
										goto loop;

										// wait its already full???
									} else Error("Internal failure: Unary operator search resulted in impossible condition: Unary operator is not full, but has a value?");
								}

								cv.Left = right;
								right.Parent = cv;
								RemoveTokenInArrays(right, ref CurTokens, ref alltokens);

								// if this is the last token, add it to the previous depth
							} else ReplaceTokenInArray(middle, middle, --maxdepth, ref CurTokens, ref alltokens);
							// Error("Internal failure: Calculation failed between " + (middle?.ToString() ?? "null") + " and " + (right?.ToString() ?? "null"));

						} else if (!(left is null)) {
							if(left is AssemblyTokenCalculation lc && !lc.IsFull())
								FormatError("Encountered illegal sequence: " +
									(left is null ? "" : left.ShowString().Replace("null", "")) + (middle is null ? "" : middle.ShowString().Replace("null", "")));

							// we may do a successful calculation
							if (!(right is null)) {
								cmiddle.Left = left;
								cmiddle.Right = right;
								left.Parent = cmiddle;
								right.Parent = cmiddle;

								RemoveTokenInArrays(left, ref CurTokens, ref alltokens);
								RemoveTokenInArrays(right, ref CurTokens, ref alltokens);

							} else {
								if(cmiddle.Left is null) {
									cmiddle.Left = left;
									left.Parent = cmiddle;

								} else {
									cmiddle.Right = left;
									left.Parent = cmiddle;
								}

								RemoveTokenInArrays(left, ref CurTokens, ref alltokens);

								if (!cmiddle.IsFull())
									FormatError("Encountered illegal sequence: " + cmiddle.ShowString().Replace("null", ""));
							}

						} else if (right is null && left is null) {
							// if this is the last token, add it to the previous depth
							ReplaceTokenInArray(middle, middle, maxdepth - 1, ref CurTokens, ref alltokens);

						} else if (!(right is null)) {
							// check if the right side of this equation is an unary operator
							if(cmiddle.Right is AssemblyTokenCalculation rc && rc.IsUnary()) {
								loop:
								if (rc.IsFull()) {
									if (rc.Left is AssemblyTokenCalculation cc) {
										if (!cc.IsUnary())
											Error("Internal failure: Unary operator search resulted in an error: Right side of unary operator is not another unary operator.");

										// ok, this is valid
										rc = cc;
										goto loop;

										// wait its already full???
									} else Error("Internal failure: Unary operator search resulted in impossible condition: Unary operator is not full, but has a value?");

								} else {
									rc.Left = right;
									right.Parent = rc;
									RemoveTokenInArrays(right, ref CurTokens, ref alltokens);
								}

							} else
								FormatError("Encountered illegal sequence: " + (left is null ? "" : left.ShowString().Replace("null", "")) + 
									(middle is null ? "" : middle.ShowString().Replace("null", "")) + (right is null ? "" : right.ShowString().Replace("null", "")));

						} else Error("Internal failure: Calculation failed between " + (left?.ToString() ?? "null") + ", " + (middle?.ToString() ?? "null") + " and " + (right?.ToString() ?? "null"));

					} else {
						if(left is null && right is null) {
							// if this is the last token, add it to the previous depth
							ReplaceTokenInArray(middle, middle, maxdepth - 1, ref CurTokens, ref alltokens);

						} else
							FormatError("Encountered illegal sequence: "+ 
								(left is null ? "" : left.ShowString() +" ") + (middle is null ? "" : middle.ShowString() + " ") + (right is null ? "" : right.ShowString()));
					}

					if (CurTokens.Count > 0) goto next;

					// check if more items are at same depth
					// TODO: We can optimize this a bit
					for (int i = 0;i < alltokens.Count;i++) {
						if (alltokens[i].Item1 == maxdepth) {
							goto more;
						}
					}

					maxdepth--;
					more:;
				}
			}

			return alltokens.Count > 0 ? alltokens[0].Item2 : null;
		}

		private bool RemoveTokenInArrays(AssemblyTokenValue remove, ref List<AssemblyTokenValue> curtokens, ref List<Tuple<int, AssemblyTokenValue>> alltokens) {
			curtokens.Remove(remove);

			for (int i = 0;i < alltokens.Count;i++)
				if (alltokens[i].Item2.Equals(remove)) {
					alltokens.RemoveAt(i);
					return true;
				}

			return false;
		}

		private bool ReplaceTokenInArray(AssemblyTokenValue who, AssemblyTokenValue with, int depth, ref List<AssemblyTokenValue> curtokens, ref List<Tuple<int, AssemblyTokenValue>> alltokens) {
			curtokens.Remove(who);

			for (int i = 0;i < alltokens.Count;i++)
				if (alltokens[i].Item2.Equals(who)) {
					alltokens[i] = new Tuple<int, AssemblyTokenValue>(depth, with);
					return true;
				}

			return false;
		}
		#endregion

		#region Converters
		// this routine properly converts buffer data into a string, escaping any escape characters along the way
		// TODO: Maybe can optimize by rewriting the code from scratch
		private string StringEscape(char[] buffer, int start, int end) {
			return Regex.Unescape(new string(buffer, start, end - start));
		}

		// parse buffer into a double
		private double ParseDouble(char[] buffer, int start, int end) {
			string s = new string(buffer, start, end - start);

			 if (Double.TryParse(s, NumberStyles.AllowLeadingSign | NumberStyles.AllowExponent | NumberStyles.AllowDecimalPoint, CultureInfo.InvariantCulture, out double value))
				return value;
					
			FormatError("Could not parse text as a number: "+ s);
			return Double.PositiveInfinity;
		}

		// parse buffer into a double
		private long ParseLong(char[] buffer, int start, int end) {
			string s = null;
			bool hex = false;

			if (buffer[start] == '$') {
				s = new string(buffer, start + 1, end - start - 1);
				hex = true;

			} else if (buffer[end - 1] == 'h' || buffer[end - 1] == 'H') {
				s = new string(buffer, start, end - start - 1);
				hex = true;

			} else if (buffer.Length > start + 1 && buffer[start + 1] == 'x') {
				s = new string(buffer, start + 2, end - start - 2);
				hex = true;

			} else s = new string(buffer, start, end - start);
			
			if (Int64.TryParse(s, hex ? NumberStyles.AllowHexSpecifier : NumberStyles.AllowLeadingSign, CultureInfo.InvariantCulture, out long value))
				return value;

			FormatError("Could not parse text as a number: " + s);
			return Int64.MinValue;
		}

		private long ParseBinary(char[] buffer, int start, int end) {
			string s;

			if (buffer[end - 1] == 'b' || buffer[end - 1] == 'B') {
				s = new string(buffer, start, end - start - 1);

			} else s = new string(buffer, start, end - start);

			try {
				return Convert.ToInt64(s, 2);

			} catch (Exception) {
				FormatError("Could not parse text as a binary number number: " + buffer[start - 1] + s);
			}

			return Int64.MinValue;
		}

		public byte[] StringToBytes(string text) {
			return Encoding.ASCII.GetBytes(text);
		}

		// solve and optimize the tokens supplied to the routine
		public AssemblyToken SolveTokens(AssemblyToken source, out TokenState state) {
			if (source is null) {
				state = TokenState.Static;
				return null;
			}

			return source.Solve(out state);
		}
		#endregion
	}

	#region Classes
	public struct EquationToken {
		public EquationType Type;
		public ushort Start, End, Depth;

		public EquationToken(EquationType type, int start, int end, int depth) {
			Type = type;
			Start = (ushort)start;
			End = (ushort)end;
			Depth = (ushort)depth;
		}
	}

	public enum EquationType {
		None, Operator, UnkInteger, HexDecInteger, BinaryInteger, String, Function, Argument, Equate, OpenArray, CloseArray
	}

	public struct DynamicMacros {
		public CurrentToken TargetToken;
		public bool RequiresLabel, ReadFullLine;
		public string Name;

		public DynamicMacros(string name, CurrentToken token) {
			TargetToken = token;
			ReadFullLine = RequiresLabel = false;
			Name = name;
		}

		public DynamicMacros(string name, CurrentToken token, bool reqlabel, bool fulline) {
			TargetToken = token;
			RequiresLabel = reqlabel;
			ReadFullLine = fulline;
			Name = name;
		}
	}

	public enum CurrentToken {
		None, Ignore, MacroSize, Macro, MacroBraces,
	}
#endregion
}
