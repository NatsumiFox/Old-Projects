using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace RoutineAnal {
	class Program {
		public static Dictionary<string, long> routines = new Dictionary<string, long>();
		public static List<string> labs = new List<string>();
		public static Regex jmpsr = new Regex(@"^([a-z0-9_:]*)\s*(jsr|jmp|bra\.w|bsr\.w)\s*\(?([a-z0-9_]+)\)?", RegexOptions.Compiled | RegexOptions.IgnoreCase);
		public static Regex lea = new Regex(@"^([a-z0-9_:]*)\s*lea\s*\(?([a-z0-9_]+)\)?", RegexOptions.Compiled | RegexOptions.IgnoreCase);
		public static Regex inc = new Regex("^([a-zA-Z0-9_:]*)\\s*include\\s*\"([a-z0-9\\\\/_\\.\\s-]+)\"", RegexOptions.Compiled | RegexOptions.IgnoreCase);
		public static Regex jmpsrnw = new Regex(@"^([a-z0-9_:]*)\s*(jsr|jmp)\s*\(?([a-z0-9_]+)\)?(?!(\.w))(?!(\(pc,))(?![a-z0-9_+-]+)", RegexOptions.Compiled | RegexOptions.IgnoreCase);
		public static Regex leanw = new Regex(@"^([a-z0-9_:]*)\s*lea\s*\(?([a-z0-9_]+)\)?(?!(\.w))(?!(\(pc,)),", RegexOptions.Compiled | RegexOptions.IgnoreCase);
		public static Regex lab = new Regex("^([a-zA-Z0-9_]*):", RegexOptions.Compiled | RegexOptions.IgnoreCase);

		static void Main(string[] args) {
			//	Anal(args[0]);
			//	Print();

			/*	Lables(args[1]);
				List(args[0]);*/
			//Console.ReadKey();
			// 0.980192

			for(double d = 0;d <= 1;d += 0.01) {
				d = Math.Round(d, 3);
				Console.Write(d + " ");
	//			Console.Write(Math.Round(Math.Log(1 - d), 5) + " ");
	//			Console.Write(Math.Round(1 / Math.Log(2), 5) + " ");
	//			Console.Write(Math.Round(Math.Log(1 - d) / (1 / Math.Log(2)), 5) + " ");
	//			Console.Write(Math.Round(-((Math.Log(1 - d) / (1 / Math.Log(2))) / Math.E), 5) + " ");
				Console.Write((Math.Exp(d) - 1) / (Math.E - 1));
				Console.Write("\n");
			}

			Console.ReadKey();
		}

		private static void Print() {
			foreach (var r in routines.OrderBy(a => a.Value)) {
				if (r.Value >= 5 && r.Value <= 8) {
					Console.WriteLine(r.Value + " - " + r.Key);
				}
			}
		}

		private static void Anal(string file) {
			Console.WriteLine("Anal file "+ file);
			foreach (string line in File.ReadAllLines(file)) {
				var m = jmpsr.Matches(line);

				if (m.Count > 0 && m[0].Groups.Count >= 3) {
					string s = m[0].Groups[3].Value;
					if (!routines.ContainsKey(s)) routines[s] = 0;
					routines[s]++;

				} else {
					m = inc.Matches(line);
					if (m.Count > 0 && m[0].Groups.Count >= 3) Anal(m[0].Groups[2].Value);
				}
			}
		}

		private static void Lables(string file) {
			Console.WriteLine("Lables file " + file);
			foreach (string line in File.ReadAllLines(file)) {
				var m = lab.Matches(line);

				if (m.Count > 0 && m[0].Groups.Count > 0)
					labs.Add(m[0].Groups[1].Value);
			}
		}

		private static bool List(string file) {
			bool list = false;
			int l = 0;
			foreach (string line in File.ReadAllLines(file)) {
				l++;
				var m = jmpsrnw.Matches(line);

				if (m.Count > 0 && m[0].Groups.Count >= 3) {
					string s = m[0].Groups[3].Value;
					if (labs.Contains(s)) {
						if (!list) {
							list = true;
							Console.WriteLine("List file " + file);
						}
						Console.WriteLine(l + " " + s);
					}

				} else {
					m = leanw.Matches(line);

					if (m.Count > 0 && m[0].Groups.Count >= 2) {
						string s = m[0].Groups[2].Value;
						if (labs.Contains(s)) {
							if (!list) {
								list = true;
								Console.WriteLine("List file " + file);
							}
							Console.WriteLine(l + " " + s);
						}

					} else {
						m = inc.Matches(line);
						if (m.Count > 0 && m[0].Groups.Count >= 3) {
							if (List(m[0].Groups[2].Value)) list = false;
						}
					}
				}
			}

			return list;
		}

		private static void Diff(string file) {
			int l = 0;
			List<string> last = new List<string>();
			foreach (string line in File.ReadAllLines(file)) {
				l++;
				var m = jmpsr.Matches(line);

				if (m.Count > 0 && m[0].Groups.Count >= 4) {
					string s = m[0].Groups[4].Value;

					if (line.StartsWith("-")) last.Add(s);
					else {
					//	Console.WriteLine("--- " + s + " !! " + string.Join(" - ", last.ToArray()));
						if (last[0] != s) Console.WriteLine(l + " " + s + " - " + last[0]);
						last.RemoveAt(0);
					}

				} else {
					m = lea.Matches(line);

					if (m.Count > 0 && m[0].Groups.Count >= 3) {
						string s = m[0].Groups[3].Value;

						if (line.StartsWith("-")) last.Add(s);
						else if (last[0] != s) {
							Console.WriteLine(l + " " + s + " - " + last[0]);
							last.RemoveAt(0);
						}

					} else if(!line.StartsWith("-") && !line.StartsWith("+")) last = new List<string>();
				}
			}
		}
	}
}
