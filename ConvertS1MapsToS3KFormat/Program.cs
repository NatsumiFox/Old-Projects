using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConvertS1MapsToS3KFormat {
	class Program {
		static void Main(string[] args) {
			if (args.Length < 2) { Console.WriteLine("Missing args"); Console.ReadKey(); return; }
			if (!Directory.Exists(args[0])) { Console.WriteLine("Does not exist"); Console.ReadKey(); return; }

			// find the list of files to convert
			string[] a = Directory.GetFiles(args[0], "*.asm");
			string[] b = new string[a.Length];
			string[] c = new string[a.Length];
			if (a.Length == 0) { Console.WriteLine("No input files"); Console.ReadKey(); return; }
			Directory.CreateDirectory(args[0] + @"\S1\");

			// move all them files
			Console.WriteLine("Move files...");
			for (int i = a.Length - 1;i >= 0;i--) {
				c[i] = a[i];
				a[i] = args[0] + @"\S1\" + Path.GetFileName(a[i]);
				b[i] = args[0] + @"\" + Path.GetFileNameWithoutExtension(a[i]) + ".bin";
				File.Move(c[i], a[i]);
				Console.WriteLine("File '"+ c[i] + "' moved to '"+ a[i] + "'");
			}

			k(a);
			Console.WriteLine("Files converted. Assemble files...");
			for (int i = a.Length - 1;i >= 0;i--) {
				try {
					Process p = new Process {
						StartInfo = new ProcessStartInfo {
							FileName = args[1] + @"\ASM68K.EXE",
							Arguments = "/o ae- /p /q " + a[i] + ", " + b[i],
							UseShellExecute = false,
							RedirectStandardOutput = true,
							CreateNoWindow = true
						}
					};
					p.Start();
					while (!p.HasExited) {
						while (!p.StandardOutput.EndOfStream) {
							// do something with line
							File.AppendAllText(b[i] + ".asm", p.StandardOutput.ReadLine() +"\r\n");
						}

						System.Threading.Thread.Sleep(10);
					}

					if (p != null && !p.WaitForExit(15000)) {
						Console.WriteLine("Failed to assemble file '" + a[i] + "'!");
					} else {
						Console.WriteLine("Assembly for file '" + a[i] + "' completed.");
					}

					p.Dispose();
					if (File.Exists(b[i] + ".asm")) {
						Console.WriteLine(File.ReadAllText(b[i] + ".asm"));
						File.Delete(b[i] + ".asm");
					}
				} catch(Exception ex) {
					Console.WriteLine("Failed to assemble file '" + a[i] + "'!\r\n"+ ex);
					Console.ReadKey();
				}
			}

			Console.WriteLine("Assembly done, reading & converting files...");
			for (int e = b.Length - 1;e >= 0;e --) {
				string s = ".map";
				try {
					Console.WriteLine("Convert '" + b[e] + "'...");
					byte[] d = File.ReadAllBytes(b[e]);
					List<short> o = new List<short>();
					int i = 0;

					while (o.Count == 0 || i < o.ElementAt(0)) {
						o.Add((short) ((d[i++] << 8) | (d[i++])));
					}
					{
						int m = 0;
						while (m < o.Count) {
							s += "\tdc.w";
							for (int n = 0;n < 3 && m < o.Count;n++, m++) {
								s += " ." + m + "-.map,";
							}

							s = s.Substring(0, s.Length - 1) + "\r\n";
						}
					}

					s += "\r\n";
					while (i < d.Length) {
						if (!o.Contains((short) i)) {
							Console.WriteLine("WARN! Could not find lable at " + i + " in file '" + b[e] + "'!");
							i++;

						} else {
							short t = d[i++];
							s += "." + o.IndexOf((short) (i - 1)) + "\tdc.w " + t + "\r\n";

							for (;t > 0;t--) {
								s += "\tdc.b " + toHexGen(d[i++], 2) + ", " + toHexGen(d[i++], 2) + ", " + toHexGen(d[i++], 2) + ", " + toHexGen(d[i++], 2) + ", ";
								short y = sex(d[i++]);
								s += toHexGen((y & 0xFF) >> 8, 2) + ", " + toHexGen(y & 0xFF, 2) + "\r\n";
							}
						}
					}
				} catch (Exception ex) {
					Console.WriteLine("Failed to convert file '" + b[e] + "'! This is what I got so far:\r\n" + s +"\r\n"+ ex);
					Console.ReadKey();
				}

				File.WriteAllText(c[e], s);
				File.Delete(b[e]);
				Console.WriteLine("Convert '" + b[e] + "' done!");
			}

			Console.WriteLine("All done!");
			Console.ReadKey();
		}

		private static short sex(byte v) {
			return (v & 0x80) == 0 ? v : (short) (0xFF00 | v);
		}

		private static bool k(string[] a) {
			Console.WriteLine("Files moved. Convert files...");
			foreach (string b in a) {
				byte[] d = File.ReadAllBytes(b);
				string x = File.ReadAllLines(b)[3];
				int q = x.LastIndexOf("-") + 1, w = x.IndexOf("\r") - 1;
				if (w == -2) w = x.Length;
				File.WriteAllText(b, x.Substring(q, w - q) + System.Text.Encoding.ASCII.GetString(d));
				Console.WriteLine("Conversion for file '" + b + "' completed.");
			}

			return true;
		}

		private static string toHexGen(long res, int zeroes) {
			return "$" + string.Format("{0:x" + zeroes + "}", (int) res).ToUpper();
		}
	}
}
