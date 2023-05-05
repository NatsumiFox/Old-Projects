using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Test_Programs {
	class MDDC_mapper {
		[STAThread]
		static void Mainz(string[] args) {
			byte[] file = File.ReadAllBytes(@"G:\hacks\misc\MDDC Screen\#MDDC\Ani.dat");
			int offset = 0, frame = 0;
			string output = "";

			// init plane
			ushort[] plane = new ushort[40 * 28];
			bool[] diff = new bool[40 * 28];

			// figure out the differences with the planes
			while (offset < file.Length) {
				// update plane details
				for (int i = 0;i < plane.Length;i++) {
					ushort p = (ushort)((file[offset++] << 8) | file[offset++]);

					diff[i] = p != plane[i];
					plane[i] = p;
				}

				// work out the differences
				List<Tuple<int, int>> lst = new List<Tuple<int, int>>();
				int ds = -1;

				for (int i = 0;i < plane.Length;i++) {
					if (ds < 0) {
						if (diff[i]) {
							ds = i;
						}
					} else if (!diff[i]) {
						lst.Add(new Tuple<int, int>(ds, i));
						ds = -1;
					}
				}

				// combine any nearby shit
				ds = -1000;
				for (int i = 0;i < lst.Count;i++) {
					if (ds + 3 >= lst[i].Item1) {
						// combine
						lst[i - 1] = new Tuple<int, int>(lst[i - 1].Item1, lst[i].Item2);
						lst.RemoveAt(i--);

					} else {
						ds = lst[i].Item2;
					}
				}

				output += ("\n\t\t; FRAME " + ++frame);

				// write it out
				for (int i = 0;i < lst.Count;i++) {
					int len = lst[i].Item2 - lst[i].Item1;
					int pos = (lst[i].Item1 * 2) + 2;
					output += ("\n\t\tdc.w $" + (0x4000 | ((pos / 80 * 0x80) + (pos % 80))).ToString("X4") + ", " + (len - 1));

					// write all longs
					for(int x = lst[i].Item1;x < lst[i].Item1 + len;x ++) {
						if(plane[x] == 0) output += ", $0000";
						else output += ", $" + (plane[x] + 0x2A7).ToString("X4");
					}
				}

				output += ("\n\t\tdc.w -1\n");
			}

			output += ("\n\t\t; END \n\t\tdc.w -1");
			Clipboard.SetText(output);
		}

		[STAThread]
		static void Main(string[] args) {
			byte[] file = File.ReadAllBytes(@"G:\tools\art\getart\Map.bin");
			string output = "";
			int offset = 0x4000 + (10 * 2) + (22 * 0x80);

			for (int i = 0;i < 0x16;i += 2) {
				output += "\n\n\t\t; DISCORD " + (i / 2 + 1);
				output += "\n\t\tdc.w (2-1)|$0000";
				output += CheckPrint(offset + (0x14 - i), (file[0x14 - i] << 8) | file[0x15 - i]);
				output += CheckPrint(offset + (0x16 + i), (file[0x16 + i] << 8) | file[0x17 + i]);
				output += CheckPrint(offset + 0x80 + (0x14 - i), (file[0x2C + 0x14 - i] << 8) | file[0x2C + 0x15 - i]);
				output += CheckPrint(offset + 0x80 + (0x16 + i), (file[0x2C + 0x16 + i] << 8) | file[0x2C + 0x17 + i]);
				output += CheckPrint(offset + 0x100 + (0x14 - i), (file[0x58 + 0x14 - i] << 8) | file[0x58 + 0x15 - i]);
				output += CheckPrint(offset + 0x100 + (0x16 + i), (file[0x58 + 0x16 + i] << 8) | file[0x58 + 0x17 + i]);
				output += CheckPrint(offset + 0x180 + (0x14 - i), (file[0x84 + 0x14 - i] << 8) | file[0x84 + 0x15 - i]);
				output += CheckPrint(offset + 0x180 + (0x16 + i), (file[0x84 + 0x16 + i] << 8) | file[0x84 + 0x17 + i]);
				output += "\n\t\tdc.w -2";
			}

			Clipboard.SetText(output);
		}

		static string CheckPrint(int pos, int data) {
			return "\n\t\tdc.w $" + pos.ToString("X4") + ", 0, $" + (data + 0x3B5).ToString("X4");
		}

		static void Maxin(string[] args) {
			byte[] file = File.ReadAllBytes(@"G:\tools\art\getart\Background Art.unc");

			foreach(var x in swapTab) {
				if(x[0] >= 0) {
					byte[] tile = new byte[32];

					Array.Copy(file, x[0] * 32, tile, 0, 32);
					Array.Copy(file, x[1] * 32, file, x[0] * 32, 32);
					Array.Copy(tile, 0, file, x[1] * 32, 32);
				}
			}

			File.WriteAllBytes(@"G:\hacks\misc\MDDC Screen\#MDDC\Background Art.unc", file);

			file = File.ReadAllBytes(@"G:\tools\art\getart\Background Map.unc");

			ushort offs = 0;
			foreach (var x in swapTab) {
				if (x[0] >= 0) {
					for(int i = 0;i < file.Length; i += 2) {
						ushort v = (ushort)((file[i] << 8) | file[i + 1]);

						if((v & 0x7FF) == x[0]) {
							v &= 0xF800;
							v |= (ushort)x[1];
						//	v ^= offs;

							file[i] = (byte)(v >> 8);
							file[i + 1] = (byte)v;

						} else if((v & 0x7FF) == x[1]) {
							v &= 0xF800;
							v |= (ushort)x[0];
							v ^= offs;

							file[i] = (byte)(v >> 8);
							file[i + 1] = (byte)v;
						}
					}

				} else offs = 0x800;
			}

			File.WriteAllBytes(@"G:\hacks\misc\MDDC Screen\#MDDC\Background Map.unc", file);
		}

		public static int[][] swapTab = {
			// 1st lightning
			new int[]{ 0, 0x55 }, new int[]{ 1, 0x56 }, new int[]{ 2, 0x57 }, new int[]{ 3, 0x58 }, new int[]{ 4, 0x59 }, new int[]{ 5, 0x5A }, new int[]{ 6, 0x5B },
			new int[]{ 7, 0x72 }, new int[]{ 8, 0x73 }, new int[]{ 9, 0x74 },
			new int[]{ 10, 0x87 }, new int[]{ 11, 0x88 }, new int[]{ 12, 0x89 }, new int[]{ 13, 0x8A }, new int[]{ 14, 0x8B },
			new int[]{ 15, 0x9D }, new int[]{ 16, 0x9E }, new int[]{ 17, 0x9F }, new int[]{ 18, 0xA0 }, new int[]{ 19, 0xA1 }, new int[]{ 20, 0xA2 },
			new int[]{ 21, 0xB8 }, new int[]{ 22, 0xB9 }, new int[]{ 23, 0xBA }, new int[]{ 24, 0xBB },
			new int[]{ 25, 0xD0 }, new int[]{ 26, 0xD1 }, new int[]{ 27, 0xD2 },
			new int[]{ 28, 0xE5 }, new int[]{ 29, 0xE6 }, new int[]{ 30, 0xE7 }, new int[]{ 31, 0xE8 },
			new int[]{ 32, 0xFB }, new int[]{ 33, 0xFC }, new int[]{ 34, 0xFD }, new int[]{ 35, 0xFE },
			new int[]{ 36, 0x113 },new int[]{ 37, 0x114 },new int[]{ 38, 0x115 },new int[]{ 39, 0x116 },new int[]{ 40, 0x117 },

			// 2nd lightning
			new int[]{ -1, -1 },
			new int[]{ 41, 0x6B }, new int[]{ 42, 0x6A }, new int[]{ 43, 0x69 }, new int[]{ 44, 0x68 }, new int[]{ 45, 0x67 }, new int[]{ 46, 0x66 }, new int[]{ 47, 0x65 },
			new int[]{ 48, 0x7E }, new int[]{ 49, 0x7F }, new int[]{ 50, 0x80 },
			new int[]{ 51, 0x98 }, new int[]{ 52, 0x97 }, new int[]{ 53, 0x96 }, new int[]{ 54, 0x95 }, new int[]{ 55, 0x94 },
			new int[]{ 56, 0xB1 }, new int[]{ 57, 0xB0 }, new int[]{ 58, 0xAF }, new int[]{ 59, 0xAE }, new int[]{ 60, 0xAD }, new int[]{ 61, 0xAC },
			new int[]{ 62, 0xC8 }, new int[]{ 63, 0xC7 }, new int[]{ 64, 0xC6 }, new int[]{ 65, 0xC5 },
			new int[]{ 66, 0xDF }, new int[]{ 67, 0xDE }, new int[]{ 68, 0xDD },
			new int[]{ 69, 0xF5 }, new int[]{ 70, 0xF4 }, new int[]{ 71, 0xF3 }, new int[]{ 72, 0xF2 },
			new int[]{ 73, 0x10C },new int[]{ 74, 0x10B },new int[]{ 75, 0x10A },new int[]{ 76, 0x109 },
			new int[]{ 77, 0x125 },new int[]{ 78, 0x124 },new int[]{ 79, 0x123 },new int[]{ 80, 0x122 },new int[]{ 81, 0x121 },
		};
		
		static void Maixn(string[] args) {
			short[] tabl = new short[224];
			int file = 0;

			for(int i = 0;i < 8; i++)
				tabl[i] = (short)(0xD0 - i);

			for (int i = 140;i < 224;i++)
				tabl[i] = (short)(0xD0 - i);

			for (int x = 32;x > 0;--x) {
				int lines = 132 * x / 33;
				lines += lines % 1;
				int lclr = 66 - (lines / 2);

				for(int i = 66;i > 0;--i) {
					if(i > lclr) {
						// null
						tabl[66 + 8 - i] = (short)(-0x10 - (66 - i));
						tabl[66 + 7 + i] = (short)(-0x10 + (65 + i));

					} else {
						tabl[66 + 8 - i] = (short)(-8 - ((132f / (132 - lines)) * i - i));
						tabl[66 + 7 + i] = (short)(-8 + ((132f / (132 - lines)) * i - i));
					}
				}

				Print(file++, tabl);
			}

			for (int i = 0;i < 224;i++)
				tabl[i] = (short)(0xE0 - i);

			Print(file++, tabl);
		}

		static void Print(int id, short[] x) {
			byte[] file = new byte[x.Length * 2];

			for (int i = 0;i < x.Length;i++) {
				file[i * 2] = (byte)(x[i] >> 8);
				file[i * 2 + 1] = (byte)x[i];
			}

			File.WriteAllBytes(@"G:\hacks\misc\MDDC Screen\#MDDC\Scale\" + id + ".unc", file);
			Process p = Process.Start(@"G:\RESEARCH\Z80 ASM\Sonic 1\FW_KENSC\enicmp.exe", "\"G:\\hacks\\misc\\MDDC Screen\\#MDDC\\Scale\\" + id + ".unc\" \"G:\\hacks\\misc\\MDDC Screen\\#MDDC\\Scale\\"+ id +".eni\"");
			p.WaitForExit();
		}
	}
}
