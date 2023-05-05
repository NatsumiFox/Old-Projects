using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CheckMaxTilesDPLC {
	class Program {
		static uint pos = 0;
		static byte[] file = null;

		static void Main(string[] args) {
			if(args.Length < 2) {
				Console.WriteLine("Needs at least 2 arguments");
				
			} else {
				if (!File.Exists(args[0]))
					Console.WriteLine("File does not exist");

				else {
					file = File.ReadAllBytes(args[0]);

					if(!UInt32.TryParse(args[1], NumberStyles.HexNumber, CultureInfo.InvariantCulture, out pos))
						Console.WriteLine("Can not parse offset");

					else {
						if (pos >= file.Length || pos < 0)
							Console.WriteLine("Offset out of range");

						else {
							if (!UInt32.TryParse(args[2], NumberStyles.HexNumber, CultureInfo.InvariantCulture, out uint posend))
								Console.WriteLine("Can not parse offset");

							else {
								if (posend >= file.Length || posend < pos)
									Console.WriteLine("Offset out of range");

								else {
									uint firstpos = pos;
									int tiles = 0;

									while (pos < posend) {
										short off = rw();
										int tls = 0;

										uint posback = pos;
										pos = (uint)(firstpos + off);

										for (int i = ruw();i > 0;i--)
											tls += (ruw() >> 12) + 1;

										Console.WriteLine(tls.ToString("X4") + " : " + off.ToString("X4") + " : " + pos.ToString("X6") + " : " + posback.ToString("X6"));

										if (tls > tiles) {
											Console.WriteLine("MAX: " + off.ToString("X4") + " : " + tls.ToString("X4") + " : " + posback.ToString("X6"));
											tiles = tls;
										}
										pos = posback;
									}

									Console.WriteLine(tiles.ToString("X"));
								}
							}
						}
					}
				}
			}

			Console.ReadKey();
		}

		private static short rw() {
			return (short)((rb() << 8) | rb());
		}

		private static ushort ruw() {
			return (ushort)((rb() << 8) | rb());
		}

		private static byte rb() {
			return file[pos++];
		}
	}
}
