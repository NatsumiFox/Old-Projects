using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace DisassemblyVariableEquator {
	class Program {
		public static Regex inc = new Regex("^([a-zA-Z0-9_:]*)\\s*include\\s*\"([a-z0-9\\\\/_\\.\\s-]+)\"", RegexOptions.Compiled | RegexOptions.IgnoreCase);
		public static Regex addr = new Regex("\\(?\\$(FFFF|FF)([0-9A-F]{4})(?!([0-9A-F]+))\\)?(\\.w|\\.l)?", RegexOptions.Compiled | RegexOptions.IgnoreCase);
		public static string[] LableArray;

		static void Main(string[] args) {
			Console.Title = "Variable Equator";
			if(!CheckArgs(args, out string error)) {
				Fail(error);
				return;
			}

			Stopwatch sw = new Stopwatch();
			Console.WriteLine("Init");
			sw.Start();

			// build the info we need to transform each line
			LableArray = new string[0x10000];
			int line = 0, longest = 0;
			string lable = null;

			foreach(string l in File.ReadLines(args[2])) {
				line++;

				if (l.Contains(' ')) {
					// ok found a valid line, now we need to update the array
					string[] ls = l.Split(' ');

					if (ls.Length == 0) continue;

					if (ls.Length < 3)
						Fail("Invalid data at line " + line + " of the mapper file!");

					if (!ushort.TryParse(ls[0], NumberStyles.HexNumber, NumberFormatInfo.InvariantInfo, out ushort position))
						Fail("Failed to convert number '" + ls[0] + "' in line " + line + " of the mapper file!");

					if (!ushort.TryParse(ls[1], NumberStyles.HexNumber, NumberFormatInfo.InvariantInfo, out ushort length))
						Fail("Failed to convert number '" + ls[1] + "' in line " + line + " of the mapper file!");

					if (ls[2] != null && ls[2].Contains("$"))
						ls[2] = ls[2].Replace("$", position.ToString("X4").ToUpperInvariant());

					for (int i = position, ex = 0;i < position + length;i++, ex++) {
						if (LableArray[i] != null && (lable == null || !LableArray[i].StartsWith(lable)))
							Fail("Lable at " + i.ToString("X4") + " already exists! Failed at line " + line + " of the mapper file! Label "+ LableArray[i]);

						// finally could save this one here
						LableArray[i] = ls[2].Trim() + (ex == 0 ? "" : "+$"+ ex.ToString("X"));
					}

					if(!LableArray[position].Contains("+"))
						lable = LableArray[position];

					if (LableArray[position].Length + 1 > longest)
						longest = LableArray[position].Length;
				}
			}

			Console.WriteLine("map processed");
			longest = (longest + 8) / 8 * 8;

			// here, we are going to create a file with assembler-specific syntax that acts as the include file
			string fout = "";
			lable = null;
			int offs = 0;

			for (int i = 0;i < LableArray.Length;i++) {
				if (LableArray[i] == null || !LableArray[i].Contains("+")) {
					if (lable == null && LableArray[i] == null) continue;

					if (lable != null && LableArray[i] == lable)
						Fail("Lable array contains multiple sequential entries with same name! Found at address " + i.ToString("X4") + "!");

					// new entry was found, now the last one in
					int len = i - offs;
					if(i != 0)	fout += Tabs(lable, longest) + (AssemblerType == Assembler.AS ? "ds.b " : AssemblerType == Assembler.ASM68K ? "rs.b " : " error ") +"$"+ len.ToString("X") + "\n";
					lable = LableArray[i];
					offs = i;

				} else if (LableArray[i] != null && !LableArray[i].StartsWith(lable))
					Fail("Program bug! There seems to be a missing lable somewhere, failed to process it properly at address " + i.ToString("X4") + "!");
			}

			fout += Tabs(lable, longest) + (AssemblerType == Assembler.AS ? "ds.b " : AssemblerType == Assembler.ASM68K ? "rs.b " : " error ") + "$" + (LableArray.Length - offs).ToString("X") + "\n";
			File.WriteAllText(args[3], fout);

		//	Console.WriteLine(fout);
			Console.WriteLine("LUT created");
			
			Convert(args[1]);
			sw.Stop();
			Console.WriteLine("Done in "+ sw.ElapsedMilliseconds +" ms!");
			Console.ReadKey();
		}

		private static string Tabs(string text, int longest) {
			text = text ?? "";
			text += new string('\t', (longest - text.Length - 1) / 8 + 1);
			return text;
		}

		private static void Convert(string file) {
			string[] lines = File.ReadAllLines(file);
			bool update = false;
		//	Console.WriteLine(file);

			for (int i = 0;i < lines.Length;i++) {
				// Check if this line is an include
				var m = inc.Matches(lines[i]);
				if (m.Count > 0 && m[0].Groups.Count >= 3) {
					if(m[0].Groups[2].Value.EndsWith(".asm"))
						Convert(m[0].Groups[2].Value);

				} else {
					// check if there are any instances of addresses
					m = addr.Matches(lines[i]);

					foreach(Match c in m) {
						if (c.Groups.Count >= 3) {
							// get the right offset
							if(!ushort.TryParse(c.Groups[2].Value, NumberStyles.HexNumber, NumberFormatInfo.InvariantInfo, out ushort position))
								Fail("Failed to parse RAM address: '" + c.Groups[2].Value + "' in " + file + "::" + (i + 1) + "!");

							bool endp = c.Groups.Count >= 5 && c.Groups[4].Value != "";
							string lb = LableArray[position];
							lines[i] = lines[i].Replace(c.Groups[0].Value, (endp ? "(" : "") + (lb == null ? "$FFFF"+ position.ToString("X4") : lb) + (endp ? ")" + c.Groups[4].Value : ""));
							update = true;

						} else Fail("Failed to capture proper amount of groups: '" + c.Groups[0].Value + "' in " + file + "::" + (i + 1) +"!");
					}

				//	if(m.Count > 0) Console.WriteLine(lines[i]);
				}
			}

			if(update) File.WriteAllLines(file, lines);
		}

		private static void Fail(string error) {
			Console.WriteLine(error);
			Console.ReadKey();
			Environment.Exit(0);
		}

		private static Assembler AssemblerType;

		private static bool CheckArgs(string[] args, out string error) {
			if(args.Length < 4) {
				error = "Missing arguments! Arguments: <assembler name> <initial assembly file> <mapper file> <mapper output file>";
				return false;
			}

			if (!File.Exists(args[1])) {
				error = "File '" + args[1] + "' does not exist!";
				return false;
			}

			if (!File.Exists(args[2])) {
				error = "File '" + args[2] + "' does not exist!";
				return false;
			}

			error = null;
			if (Enum.TryParse(args[0].ToUpperInvariant(), out AssemblerType))
				return true;

			error = "Assembler type " + args[0] + " does not exist! Valid types are: " + string.Join(", ", Enum.GetNames(Assembler.AS.GetType()));
			return false;
		}
	}


	public enum Assembler {
		ASM68K, AS
	}
}
