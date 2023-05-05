using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Test_Programs {
	class Program {
		static void Maxin(string[] args) {
			/*	Stopwatch sw = new Stopwatch();
				sw.Start();

				using (FileStream stream = new FileStream(args[0], FileMode.Open)) {

					// here is some stream 'stream' which contains any number of bytes, where we search for various strings inside of it
					FindStrings(stream, new string[] { "Sprite_ChkRespawn", "(pc,d0.w)", "neg.w", "swap", "Sprite_OnScreen_Test", "eor" });
				}

				sw.Stop();

				Console.WriteLine("--Finished in: " + sw.ElapsedMilliseconds + "ms - " + sw.ElapsedTicks + " ticks!");
				Console.ReadKey();*/

			long max = 0;

			foreach (string f in Directory.GetFiles(@"G:\tools\music\AMPS Sonic 3\Levels", "*.*", SearchOption.AllDirectories)) {
				if(f.Contains("Object Pos")) {
					long l = new FileInfo(f).Length / 8 - 1;

					if (l > max)
						max = l;
				}
			}

			Console.WriteLine(max + " rings");
			Console.ReadKey();
		}

		private static void FindStrings(Stream stream, string[] str) {
			int[] pos = new int[str.Length];
			byte[] buf = new byte[1024];
			int len = 0;

			while (true) {
				// read data from stream into buffer, and exit if length is 0
				if ((len = stream.Read(buf, 0, buf.Length)) == 0)
					break;

				// check str array for every character, making sure they are up-to-date
				for (int x = 0;x < str.Length;x++) {
					for (int i = 0;i < len;i++) {
						if (str[x][pos[x]] == buf[i]) {

							// there is a match, increment position and check if we finished the string
							if (++pos[x] == str[x].Length) {
								// why yes, this string is now finished, print out the information
								//	Console.WriteLine("Match at " + (i + stream.Position - buf.Length) + ": " + str[x]);

								// reset position
								pos[x] = 0;
							}

							// no match, reset position to 0
						} else pos[x] = 0;
					}
				}
			}
		}
	}
}
