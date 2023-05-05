using System;
using System.Diagnostics;
using System.IO;
using System.Threading;

namespace Unc2Kos {
	class Program {
		static void Main(string[] args) {
			Thread[] t = new Thread[args.Length];
			int errors = 0;

			for (int i = 0;i < args.Length;i++) {
				int ix = i;
				t[i] = new Thread(() => {

					string file = args[ix];
					if (File.Exists(file)) {
						string noe = file.Substring(0, file.LastIndexOf('.') + 1);

						Process p = new Process() {
							StartInfo = new ProcessStartInfo(@"G:\hacks\current\Yundong overworld\bin\comp\koscmp.exe", "\"" + file + "\" \"" + noe + "kos\"") {
								CreateNoWindow = true,
								UseShellExecute = true,
							}
						};

						p.Start();
						p.WaitForExit();
						goto noerr;
					}

					errors++;
					noerr:;
				});

				t[i].Start();
			}

			for (int i = 0;i < t.Length;i++)
				t[i].Join();

			if (errors > 0) {
				Console.WriteLine("There were " + errors + " files that were unable to be converted. Sorry not sorry");
				Console.ReadKey();
			}
		}
	}
}
