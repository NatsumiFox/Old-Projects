using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;
using System.IO;
using System.Diagnostics;

namespace LevelGenerator {
	static class Program {
		private static void e(string v) {
			Console.WriteLine(v);
			Console.ReadKey(true);
			Environment.Exit(-1);
		}

		static void Main(string[] args) {
		//	try {
				// parse image
				Bitmap tile = new Bitmap("gen\\tile.png");
				if(tile.Width != tile.Height)
					e("tile.png: Width and Height are not same!");
				if((tile.Width & 15) != 0)
					e("tile.png: Width must be divisible by 16!");

				int TILEW = tile.Width / 8;
				int[] colors = new int[16];
				byte[] tildat = new byte[(TILEW * 4) * (TILEW * 8)];
				colors[0] = 0x002345678;	// transparent

				for(int y = 0;y < TILEW * 8;y++) {
					for(int x = 0;x < TILEW * 8;x += 2) {
						int c1 = g(colors, tile.GetPixel(x, y).ToArgb()), c2 = g(colors, tile.GetPixel(x + 1, y).ToArgb());

						if((c1 | c2) == -1) {
							e("tile.png: Ran out of possible colors!");
						}

						tildat[((((y / 8) * TILEW) + (x / 8)) * 32) + ((y & 7) * 4) + ((x & 6) / 2)] = (byte)(c2 | (c1 << 4));
					}
				}

				tile.Dispose();
				tile = null;

				Chunks chunks = new Chunks();
				Blocks blocks = new Blocks();
				Tiles tiles = new Tiles();

				for(int i = 0;i < 0x100;i++) {
					if(!File.Exists("gen\\" + string.Format("{0:x2}", i).ToUpper() + ".png"))
						break;

					Bitmap q = new Bitmap("gen\\" + string.Format("{0:x2}", i).ToUpper() + ".png");
					if(q.Width != q.Height || q.Width != TILEW * 8)
						e(string.Format("{0:x2}", i).ToUpper() + ".png: Incorrect size!");

					byte[] chk = new byte[(TILEW * 4) * (TILEW * 8)];
					// process visible shits
					for(int y = 0;y < TILEW * 8;y++) {
						for(int x = 0;x < TILEW * 8;x += 2) {
							int pos = ((((y / 8) * TILEW) + (x / 8)) * 32) + ((y & 7) * 4) + ((x & 6) / 2);
							chk[pos] = (byte)(tildat[pos] & (((w(q.GetPixel(x, y)) > 382) ? 0xF0 : 0) | ((w(q.GetPixel(x + 1, y)) > 382) ? 0xF : 0)));
						}
					}

					q.Dispose();
					q = null;

					// process into tiles & blocks
					byte[] blo = new byte[TILEW * TILEW * 8];
					for(int y = 0, b = 0;y < TILEW;y += 2) {
						for(int x = 0;x < TILEW;x += 2, b += 8) {
							for(int r = 0;r < 4;r++) {

								byte[] tl = Array(chk, (((y + ((r & 2) /2)) * TILEW) + x + (r & 1)) * 32, 32);
								ushort z = tiles.tl(tl, 0x4000);
								blo[(y * 32) + (x * 4) + (r * 2)] = (byte)(z >> 8);
								blo[(y * 32) + (x * 4) + (r * 2) + 1] = (byte)z;
							}
						}
					}

					// process into blocks & chunks
					byte[] chu = new byte[TILEW * TILEW * 2];
					for(int c = 0;c < chu.Length;c += 2) {
						byte[] b = Array(blo, c * 4, 8);
						ushort z = blocks.bl(b, 0xF000);
						chu[c] = (byte)(z >> 8);
						chu[c + 1] = (byte)z;
					}

					// add chunk
					chunks.ch(chu);
				}

				// write out some files already
				File.WriteAllBytes("tiles.unc", tiles.g());
				File.WriteAllBytes("blocks.unc", blocks.g());
				File.WriteAllBytes("chunks.unc", chunks.g());
				comp("tiles", "kosm", "koscmp.exe", "-m ");
				comp("blocks", "kos", "koscmp.exe", "");
				comp("chunks", "kos", "koscmp.exe", "");

			Coll coll = new Coll();
			byte[] cls = new byte[(blocks.max - 1) * 2];
			for(int i = 0;i < blocks.max - 1;i++) {
				byte[] colln = new byte[16];
				byte[] bl = blocks.g(i);

				for(int x = 0;x < 16;x++) {
					int mask = (x & 1) == 0 ? 0xF0 : 0xF;
					byte[] tlt = tiles.g(rw(bl, (x & 8) / 4)), tlb = tiles.g(rw(bl, ((x & 8) / 4) + 4));

					if((tlt[((x & 7) / 2)] & mask) == 0) {
						// if topmost pixel was clear, we can assume that the intended collision path is normal
						int y = 0;
						for(;y < 15;y++) {
							if(y < 8) {
								if((tlt[(y * 4) + ((x & 7) / 2)] & mask) != 0) {
									goto _x1k;
								}
							} else if((tlb[((y - 8) * 4) + ((x & 7) / 2)] & mask) != 0) {
								goto _x1k;
							}
						}

						y = 0x10;
					_x1k:
						colln[x] = (byte)(0x10 - y);

					} else if((tlb[(7 * 4) + ((x & 7) / 2)] & mask) == 0) {
						// if bottom-most pixel was clear, we can assume that the intended collision path is inverted
						int y = 15;
						for(;y >= 0;y--) {
							if(y < 8) {
								if((tlt[(y * 4) + ((x & 7) / 2)] & mask) != 0) {
									goto _x2k;
								}
							} else if((tlb[((y - 8) * 4) + ((x & 7) / 2)] & mask) != 0) {
								goto _x2k;
							}
						}

						y = 0xF;
					_x2k:
						colln[x] = (byte)(0xFF - y);

					} else {
						// assume this is a full collision plane
						colln[x] = 0x10;
					}
				}

				byte[] collr = new byte[16];
				for(int y = 0;y < 16;y++) {
					byte[] tll = tiles.g(rw(bl, (y & 8) / 2)), tlr = tiles.g(rw(bl, ((y & 8) / 2) + 2));

					if((tll[((y & 7) * 4)] & 0xF0) == 0) {
						// if topmost pixel was clear, we can assume that the intended collision path is normal
						int x = 0;
						for(;x < 15;x++) {
							int mask = (x & 1) == 0 ? 0xF0 : 0xF;
							if(x < 8) {
								if((tll[((y & 7) * 4) + (x / 2)] & mask) != 0) {
									goto _x1k;
								}
							} else if((tlr[((y & 7) * 4) + ((x - 8) / 2)] & mask) != 0) {
								goto _x1k;
							}
						}

						x = 0x10;
					_x1k:
						collr[y] = (byte)(0x10 - x);

					} else if((tlr[((y & 7) * 4) + 3] & 0xF) == 0) {
						// if bottom-most pixel was clear, we can assume that the intended collision path is inverted
						int x = 15;
						for(;x >= 0;x--) {
							int mask = (x & 1) == 0 ? 0xF0 : 0xF;
							if(x < 8) {
								if((tll[((y & 7) * 4) + (x / 2)] & mask) != 0) {
									goto _x2k;
								}
							} else if((tlr[((y & 7) * 4) + ((x - 8) / 2)] & mask) != 0) {
								goto _x2k;
							}
						}

						x = 0xF;
					_x2k:
						collr[y] = (byte)(0xFF - x);

					} else {
						// assume this is a full collision plane
						collr[y] = 0x10;
					}
				}

				// get angle
				byte angle = 0xff;
				if(colln[0] != colln[15]) {
					Point p1, p2 = new Point(0, 0);

					if(i == 0xA1) {
						int a = 0;
					}

					// create first point
					bool full = false;
					for(int x = 0;x < 15;x++) {
						if(colln[x] == 0x10) {
							full = true;

						} else if(colln[x] != 0 && colln[x] != 0xF0) {
						//	if(full) x--;
							p1 = new Point(x, (sbyte)colln[x]);
							goto f1;
						}
					}
					
					p1 = p2;
					goto noang;

					f1:
					full = false;
					// create second point
					for(int x = 15;x >= 0;x--) {
						if(colln[x] == 0x10) {
							full = true;

						} else if(colln[x] != 0 && colln[x] != 0xF0) {
						//	if(full) x++;
							p2 = new Point(x, (sbyte)colln[x]);
							goto f2;
						}
					}

					f2:
					noang:
					if(p1 == p2) {
						if(collr[0] < 0x80) {
							angle = 0xC0;

						} else {
							angle = 0x40;
						}

					} else {
						// negate points when p2 is higher than p1...
						if(p1.Y < p2.Y) {
							Point p = p1;
							p1 = p2;
							p2 = p;
						}

						// negative to positive
						if(p1.Y < 0) {
							p1.Y = -p1.Y;
						}

						if(p2.Y < 0) {
							p2.Y = -p2.Y;
						}
						
						// calc angle and type
						double x = Math.Atan2(p1.X - p2.X, p1.Y - p2.Y) * (0x80 / Math.PI);
						angle = (byte)-((byte)(x - 0x40) & 0xFC);
						int t = ((p1.X - p2.X) > 0 ? 1 : 0) | ((p1.Y - p2.Y) < 0 ? 2 : 0);

						// note that 3 and 1 are swapped!
						switch(t) {
							case 0:		// +x +y
								angle = (byte)(-(angle - 0x80));
								break;

							case 1: // -x +y
								angle = (byte)(-angle);
								break;

							case 2: // -x -y
								break;

							case 3: // +x -y
								angle = (byte)(angle - 0x80);
								break;
						}
					}

				} else {
					if(colln[0] > 0x80) angle = 0x80;
				}

				cls[i * 2] = coll.cl(colln, collr, angle);
				cls[(i * 2) + 1] = cls[i * 2];
			}

			File.WriteAllBytes("col1.unc", cls);
			File.WriteAllBytes("_angle.unc", coll.a());
			File.WriteAllBytes("_colln.unc", coll.cn());
			File.WriteAllBytes("_collr.unc", coll.cr());

			/*	} catch(Exception ex) {
					e(ex.ToString());
				}*/
		}

		private static short rw(byte[] d, int o) {
			return (short)((d[o] << 8) | d[o + 1]);
		}

		private static void comp(string name, string ext, string prg, string args) {
			Process p = new Process();
			p.StartInfo.FileName = @"G:\hacks\archive\s41\bin\FW_KENSC\"+ prg;
			p.StartInfo.Arguments = args + name + ".unc " + name + '.' + ext;

			p.Start();
			p.WaitForExit();
		}

		private static int w(Color c) {
			return c.R + c.B + c.G;
		}

		private static int g(int[] c, int v) {
			for(int i = 0;i < c.Length;i++) {
				if(c[i] == 0) {
					c[i] = v;
					return i;

				} else if(c[i] == v) {
					return i;
				}
			}

			return -1;
		}

		// function to create a subarray
		public static T[] Array<T>(this T[] data, int index, int length) {
			if(index + length > data.Length)
				return new T[0];

			T[] result = new T[length];
			System.Array.Copy(data, index, result, 0, length);
			return result;
		}
	}

	internal class Coll {
		byte[][] colln;
		byte[][] collr;
		byte[] angle;
		private ushort max;

		public Coll() {
			angle = new byte[0x100];
			colln = new byte[0x100][];
			collr = new byte[0x100][];
			max = 0;
		}

		internal byte[] cn() {
			return c(colln);
		}
		internal byte[] cr() {
			return c(collr);
		}

		internal byte[] a() {
			return angle;
		}

		private byte[] c(byte[][] c) {
			byte[] o = new byte[0x100 * 16];
			for(int i = 0;i < max;i++) {
				for(int a = 0;a < 16;a++) {
					o[(i * 16) + a] = c[i][a];
				}
			}

			return o;
		}


		internal byte cl(byte[] cn, byte[] cr, byte a) {
			for(int i = 0;i < max;i++) {
				bool match = true;

				for(int z = 0;z < 16;z++) {
					if(colln[i][z] != cn[z] || collr[i][z] != cr[z]) {
						match = false;
						break;
					}
				}

				if(match && angle[i] == a) {
					return (byte)i;
				}
			}
			
			colln[max] = cn;
			collr[max] = cr;
			angle[max] = a;
			return (byte)max++;
		}
	}

	internal class Tiles {
		byte[][] data;
		private ushort max;

		public Tiles() {
			data = new byte[0x800][];
			max = 0;
		}

		internal byte[] g(int v) {
			switch(v & 0x1800) {
				case 0:
					return data[v & 0x3FF];

				case 0x800:
					return fliph(data[v & 0x3FF]);

				case 0x1000:
					return flipv(data[v & 0x3FF]);

				case 0x1800:
					return flipv(fliph(data[v & 0x3FF]));
			}

			return data[v & 0x3FF];
		}

		public byte[] g() {
			byte[] o = new byte[max * 32];

			for(int i = 0;i < max;i++) {
				for(int a = 0;a < 32;a++) {
					o[(i * 32) + a] = data[i][a];
				}
			}

			return o;
		}

		public ushort tl(byte[] tile, ushort line) {
			for(ushort i = 0;i < max;i++) {
				ushort tl = 0xFFFF;

				if(cktl(data[i], tile)) {
					tl = (ushort)(i | line);

				} else if(cktl(data[i], fliph(tile))) {
					tl = (ushort)(i | 0x800 | line);     // h-flip

				} else if(cktl(data[i], flipv(tile))) {
					tl = (ushort)(i | 0x1000 | line);     // v-flip

				} else if(cktl(data[i], flipv(fliph(tile)))) {
					tl = (ushort)(i | 0x1800 | line);     // hv-flip
				}

				if(tl != 0xFFFF) {
					return tl;
				}
			}

			data[max++] = tile;
			return (ushort)((max - 1) | line);
		}

		private bool cktl(byte[] t1, byte[] t2) {
			for(int i = 0;i < 32;i++) {
				if(t1[i] != t2[i])
					return false;
			}

			return true;
		}

		private byte[] fliph(byte[] t) {
			byte[] o = new byte[32];
			for(int i = 0;i < 32;i += 4) {
				wi(inv(ri(t, i)), o, i);
			}

			return o;
		}

		private byte[] flipv(byte[] t) {
			byte[] o = new byte[32];

			for(int io = 32 - 4, it = 0;it < 32;io -= 4, it += 4) {
				o[io] = t[it];
				o[io + 1] = t[it + 1];
				o[io + 2] = t[it + 2];
				o[io + 3] = t[it + 3];
			}

			return o;
		}

		private static uint ri(byte[] d, int i) {
			return (uint)(d[i] << 24 | (d[i + 1] & 0xFF) << 16 | (d[i + 2] & 0xFF) << 8 | (d[i + 3] & 0xFF));
		}

		private void wi(uint d, byte[] a, int o) {
			a[o] = (byte)(d >> 24);
			a[o + 1] = (byte)(d >> 16);
			a[o + 2] = (byte)(d >> 8);
			a[o + 3] = (byte)d;
		}

		private static uint inv(uint i) {
			return (((i << 28) & 0xF0000000) |
					((i << 20) & 0xF000000) |
					((i << 12) & 0xF00000) |
					((i << 4) & 0xF0000) |
					((i >> 4) & 0xF000) |
					((i >> 12) & 0xF00) |
					((i >> 20) & 0xF0) |
					((i >> 28) & 0xF));
		}
	}

	internal class Blocks {
		byte[][] data;
		public ushort max;

		public Blocks() {
			data = new byte[0x400][];
			max = 0;
		}

		internal byte[] g(int i) {
			return data[i];
		}

		internal byte[] g() {
			byte[] o = new byte[max * 8];

			for(int i = 0;i < max;i++) {
				for(int a = 0;a < 8;a++) {
					o[(i * 8) + a] = data[i][a];
				}
			}

			return o;
		}

		public ushort bl(byte[] block, ushort coll) {
			for(ushort i = 0;i < max;i++) {
				ushort tl = 0xFFFF;

				if(ckbl(data[i], block)) {
					tl = (ushort)(i | coll);

				} else if(ckbl(data[i], fliph(block))) {
					tl = (ushort)(i | 0x400 | coll);     // h-flip

				} else if(ckbl(data[i], flipv(block))) {
					tl = (ushort)(i | 0xC00 | coll);     // v-flip

				} else if(ckbl(data[i], flipv(fliph(block)))) {
					tl = (ushort)(i | 0x800 | coll);     // hv-flip
				}

				if(tl != 0xFFFF) {
					return tl;
				}
			}

			data[max++] = block;
			return (ushort)((max - 1) | coll);
		}

		private bool ckbl(byte[] t1, byte[] t2) {
			for(int i = 0;i < 8;i++) {
				if(t1[i] != t2[i])
					return false;
			}

			return true;
		}

		private byte[] fliph(byte[] b) {
			byte x = b[0], y = b[1];
			b[0] = b[2];
			b[1] = b[3];
			b[2] = x;
			b[3] = y;

			x = b[4]; y = b[5];
			b[4] = b[6];
			b[5] = b[7];
			b[6] = x;
			b[7] = y;
			return b;
		}

		private byte[] flipv(byte[] b) {
			byte x = b[0], y = b[1];
			b[0] = b[4];
			b[1] = b[5];
			b[4] = x;
			b[5] = y;

			x = b[2];
			y = b[3];
			b[2] = b[6];
			b[3] = b[7];
			b[6] = x;
			b[7] = y;
			return b;
		}
	}

	internal class Chunks {
		byte[][] data;
		private byte max;

		public Chunks() {
			data = new byte[0x100][];
			max = 0;
		}

		internal byte[] g() {
			byte[] o = new byte[max * 0x80];

			for(int i = 0;i < max;i++) {
				for(int a = 0;a < 0x80;a++) {
					o[(i * 0x80) + a] = data[i][a];
				}
			}

			return o;
		}

		public ushort ch(byte[] chunk) {
			for(ushort i = 0;i < max;i++) {
				for(int a = 0;a < 128;a++) {
					if(data[i][a] != chunk[a])
						goto welp;
				}

				return i;
				welp:;
			}

			data[max++] = chunk;
			return (ushort)(max - 1);
		}
	}
}
