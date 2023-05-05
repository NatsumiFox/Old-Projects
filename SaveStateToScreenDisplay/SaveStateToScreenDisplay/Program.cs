//#define hud_off

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace SaveStateToScreenDisplay {
	class Program {
		const int M68K_RAM = 0x2478;
		const int VDPREG = 0xFA;
		const int VRAM = 0x12478;
		const int CRAM = 0x112;
		const int VSRAM = 0x192;
		const int WIDTH = 320;
		const int HEIGHT = 224;
		static RegsVDP vdpregs;
		static VRAM vram;
		static CRAM cram;
		static ARAM vsram;
		static Tiles tiles;
		static Plane planea, planeb, planew;
		static Sprite sprites;

		static void Main(string[] args) {
			if(args.Length != 1 || !File.Exists(args[0])) {
				Console.WriteLine("SaveStateToScreenDisplay in\nin - The input GSX file.");
				Console.ReadKey();
				return;
			}

			try {
				byte[] a = File.ReadAllBytes(args[0]);

				vdpregs = new RegsVDP(a.Skip(VDPREG).Take(0x18).ToArray());
				vram = new VRAM(a.Skip(VRAM).Take(0x10000).ToArray());
				cram = new CRAM(a.Skip(CRAM).Take(0x80).ToArray());
				vsram= new ARAM(a.Skip(VSRAM).Take(0x50).ToArray());
				tiles = new Tiles();
				planea = new Plane(vram, vsram, vdpregs.planea, vdpregs.hscrolltype, vdpregs.vscrolltype, vdpregs.hscroll, vdpregs.planeszh, vdpregs.planeszv, 0);
				planeb = new Plane(vram, vsram, vdpregs.planeb, vdpregs.hscrolltype, vdpregs.vscrolltype, vdpregs.hscroll, vdpregs.planeszh, vdpregs.planeszv, 2);
				sprites = new Sprite(vram, vdpregs.sprites);
			//	planew = new Plane(vram, vsram, vdpregs.planew, vdpregs.planewhpos, vdpregs.planewhrght, vdpregs.planewvpos, vdpregs.planewvdown, vdpregs.planeszh, vdpregs.planeszv, 0);

			} catch(Exception e) {
				Console.WriteLine(e);
				Console.ReadKey();
				return;
			}

			planea.Optimize(WIDTH, HEIGHT, tiles);
			planeb.Optimize(WIDTH, HEIGHT, tiles);
			//	planew.Optimize(WIDTH, HEIGHT, tiles);
			sprites.Optimize(WIDTH, HEIGHT, tiles);

			// collect data on the tiles used and create a conversion list
			List<ushort> tileconv = new List<ushort>();
			tileconv.Add(0);

			for(ushort i = 1;i < 0x800;i ++) {
				if(tiles.IsUsed(i)) {
					tileconv.Add(i);
				}
			}

			// build the output file
			try {
				using(FileStream fs2 = new FileStream(args[0] +".dat", FileMode.Create, FileAccess.Write)) {
					using(BinaryWriter r = new BinaryWriter(fs2)) {
						// VDP regs
						r.Write(vdpregs.ToArray());

						// CRAM
						for(ushort i = 0;i < 0x80;i += 2) {
							r.Write(word(cram.w(i)));
						}

						// sprites
						r.Write(sprites.ToArray(tileconv));

						// vscroll
						if(vdpregs.vscrolltype) {
							for(ushort i = 0;i < 0x50;i += 2) {
								r.Write(word(vsram.w(i)));
							}

						} else {
							r.Write(word(vsram.w(0)));
							r.Write(word(vsram.w(2)));
						}

						// hscroll
						switch(vdpregs.hscrolltype) {
							case 0: {
									r.Write(word(vram.w(vdpregs.hscroll)));
									r.Write(word(vram.w((ushort)(vdpregs.hscroll + 2))));
								}
								break;

							case 2: {
									for(int i = 0;i < 112;i += 2) {
										r.Write(word(vram.w((ushort)(vdpregs.hscroll + i))));
									}
								}
								break;

							case 3: {
									for(int i = 0;i < 896;i += 2) {
										r.Write(word(vram.w((ushort)(vdpregs.hscroll + i))));
									}
								}
								break;
						}

						// planea
						for(int y = 0;y < planesizes[vdpregs.planeszv];y++) {
							for(int x = 0;x < planesizes[vdpregs.planeszh];x++) {
								ushort t = (ushort)(planea.plane[y][x] & 0x7FF), m = (ushort)(planea.plane[y][x] & 0xF800);

								for(int i = 0;i < tileconv.Count;i++) {
									if(tileconv[i] == t) {
										r.Write(word((ushort)(i | m)));
										break;
									}
								}
							}
						}

						// planeb
						for(int y = 0;y < planesizes[vdpregs.planeszv];y++) {
							for(int x = 0;x < planesizes[vdpregs.planeszh];x++) {
								ushort t = (ushort)(planeb.plane[y][x] & 0x7FF), m = (ushort)(planeb.plane[y][x] & 0xF800);

								for(int i = 0;i < tileconv.Count;i++) {
									if(tileconv[i] == t) {
										r.Write(word((ushort)(i | m)));
										break;
									}
								}
							}
						}

						// planew
					/*	for(int y = 0;y < planesizes[vdpregs.planeszv];y++) {
							for(int x = 0;x < planesizes[vdpregs.planeszh];x++) {
								ushort t = (ushort)(planew.plane[y][x] & 0x7FF), m = (ushort)(planew.plane[y][x] & 0xF800);

								for(int i = 0;i < tileconv.Count;i++) {
									if(tileconv[i] == t) {
										r.Write(word((ushort)(i | m)));
										break;
									}
								}
							}
						}*/

						r.Write(word((ushort)(tileconv.Count - 1)));

						// tiles
						foreach(ushort tile in tileconv) {
							r.Write(vram.tt(tile));
						}
					}
				}
			} catch(Exception e) {
				Console.WriteLine(e);
				Console.ReadKey();
				return;
			}
		}

		private static byte[] word(ushort v) {
			return new byte[]{ (byte)(v >> 8), (byte)v };
		}

		public static ushort word(byte[] a, int o) {
			return (ushort)((a[o] << 8) | a[o + 1]);
		}

		public static int[] planesizes = { 32, 64, 0, 128 };
	}

	internal class Sprite {
		public List<Piece> list;

		public Sprite(VRAM vram, ushort sprites) {
			list = new List<Piece>();

			int next = 0;
			for(int i = 0;i < 80;i++) {
				byte[] s = vram.ta((ushort)(sprites + (next * 8)), 8);
				list.Add(new Piece(s));

				// sprite table end detection
				if(s[3] == 0 || s[3] >= 80) break;
				next = s[3];
			}
		}

		internal void Optimize(int windoww, int windowh, Tiles tiles) {
			int left = 160 - (windoww / 2), right = 160 + (windoww / 2);
			int top = 112 - (windowh / 2), bottom = 112 + (windowh / 2);

			foreach(Piece p in list.ToArray()) {
				if(p.x - 0x80 < right && p.x - 0x80 + ((p.hsz + 1) * 8) > left &&
					p.y - 0x80 < bottom && p.y - 0x80 + ((p.vsz + 1) * 8) > top) {

#if(hud_off)		// hud checks
					if((p.tile & 0x7FF) >= 0x6CA && (p.tile & 0x7FF) < 0x780) {
						list.Remove(p);

					} else {
#endif
						ushort tile = (ushort)(p.tile & 0x7FF);
						for(int i = (p.hsz + 1) * (p.vsz + 1);i >= 0;i--) {
							tiles.Use((ushort)(tile + i));
						}
#if(hud_off)
					}
#endif

				} else {
					list.Remove(p);
				}
			}
		}

		internal byte[] ToArray(List<ushort> tileconv) {
			if(list.Count == 0) return new byte[8];
			byte[] o = new byte[list.Count * 8];

			byte link = 0;
			int x = 0;
			foreach(Piece p in list) {
				byte[] b = p.ToArray(++link, tileconv);

				for(int i = 0;i < 8;i++,x++) {
					o[x] = b[i];
				}
			}

			o[o.Length - 5] = 0;
			return o;
		}

		public class Piece {
			public ushort x, y, tile;
			public byte hsz, vsz;

			public Piece(byte[] s) {
				x = Program.word(s, 6);
				y = Program.word(s, 0);
				tile = Program.word(s, 4);
				hsz = (byte)(s[2] >> 2);
				vsz = (byte)(s[2] & 3);
			}

			internal byte[] ToArray(byte link, List<ushort> tileconv) {
				ushort t = (ushort)(tile & 0x7FF), m = (ushort)(tile & 0xF800);
				byte[] o = new byte[8];

				for(ushort i = 0;i < tileconv.Count;i++) {
					if(tileconv[i] == t) {
						t = i;
						break;
					}
				}

				o[4] = (byte)((m | t) >> 8);
				o[5] = (byte)t;
				o[0] = (byte)(y >> 8);
				o[1] = (byte)y;
				o[6] = (byte)(x >> 8);
				o[7] = (byte)x;
				o[2] = (byte)((hsz << 2) | vsz);
				o[3] = link;

				return o;
			}
		}
	}

	internal class Plane {
		public ushort[][] plane;
		public ushort[] hscrl;
		public ushort[] vscrl;

		public void Optimize(int windoww, int windowh, Tiles tiles) {
			int left = 160 - (windoww / 2), right = 160 + (windoww / 2);
			int top = 112 - (windowh / 2), bottom = 112 + (windowh / 2);
			ushort planew = (ushort)plane[0].Length, planeh = (ushort)plane.Length;
			bool[][] used = new bool[plane.Length][];

			for(int i = 0;i < planeh;i++) {
				used[i] = new bool[plane[i].Length];
			}

			for(int x = left;x < right;x += 1) {
				for(int y = top;y < bottom;y++) {
					ushort ydisp = (ushort)(((ushort)(y + vscrl[x / 16]) / 8) % planeh);
					ushort xdisp = (ushort)(((ushort)(x - hscrl[y]) / 8) % planew);
					used[ydisp][xdisp] = true;
				}
			}

			for(int y = 0;y < plane.Length;y++) {
				for(int x = 0;x < plane[y].Length;x ++) {
					if(!used[y][x]) {
						plane[y][x] = 0;

					} else {
						tiles.Use((ushort)(plane[y][x] & 0x7FF));
					}
				}
			}
		}

		public Plane(VRAM vram, ARAM vsram, ushort planeaddr, byte hscrlt, bool vscrlt, ushort hscrladdr, byte planeszh, byte planeszv, ushort scrloff) {
			plane = new ushort[Program.planesizes[planeszv]][];

			for(int i = 0;i < plane.Length;i++) {
				plane[i] = new ushort[Program.planesizes[planeszh]];
				
				for(int y = 0;y < plane[i].Length;y++) {
					plane[i][y] = vram.w((ushort)(planeaddr + y + y + (i * 2 * Program.planesizes[planeszh])));
				}
			}

			switch(hscrlt) {
				case 0: {
						hscrl = new ushort[224];
						ushort fill = vram.w((ushort)(hscrladdr + scrloff));

						for(int i = 0;i < 224;i++) {
							hscrl[i] = fill;
						}
					}
					break;

				case 2: {
						hscrl = new ushort[224];
						for(int a = 0;a < 28;a++) {
							ushort fill = vram.w((ushort)(hscrladdr + scrloff + (a * 4)));

							for(int i = 0;i < 8;i++) {
								hscrl[i + a] = fill;
							}
						}
					}
					break;

				case 3: {
						hscrl = new ushort[224];
						for(int i = 0;i < 224;i++) {
							hscrl[i] = vram.w((ushort)(hscrladdr + scrloff + (i * 4)));
						}
					}
					break;
			}

			vscrl = new ushort[20];
			if(vscrlt) {
				for(int i = 0;i < 20;i++) {
					vscrl[i] = vsram.w((ushort)(scrloff + (i * 4)));
				}

			} else {
				ushort fill = vsram.w(scrloff);
				for(int i = 0;i < 20;i++) {
					vscrl[i] = fill;
				}
			}
		}

		public Plane(VRAM vram, ARAM vsram, ushort planeaddr, byte planewhpos, bool planewhrght, byte planewvpos, bool planewvdown, byte planeszh, byte planeszv, int v) {
			hscrl = new ushort[224];
			vscrl = new ushort[20];
			plane = new ushort[Program.planesizes[planeszv]][];

			for(int i = 0;i < plane.Length;i++) {
				plane[i] = new ushort[Program.planesizes[planeszh]];
				
				if(!planewvdown) {
					if(planewvpos * 2 >= i) goto showline;
					else goto checkshow;

				} else {
					if(28 - (planewvpos * 2) <= i) goto showline;
					else goto checkshow;
				}

			showline:
				for(int y = 0;y < plane[i].Length;y++) {
					plane[i][y] = vram.w((ushort)(planeaddr + y + y + (i * 2 * Program.planesizes[planeszh])));
				}
				goto cont;

			checkshow:
				for(int y = 0;y < plane[i].Length;y++) {
					if(!planewhrght) {
						if(planewhpos * 2 < i) goto _noshow;

					} else {
						if(40 - (planewhpos * 2) > i) goto _noshow;
					}

					plane[i][y] = vram.w((ushort)(planeaddr + y + y + (i * 2 * Program.planesizes[planeszh])));
					goto _cont;

				_noshow:
					plane[i][y] = 0;

				_cont:;
				}

			cont:;
			}
		}
	}

	internal class Tiles {
		private bool[] used;

		public Tiles() {
			used = new bool[0x800];
		}

		public bool IsUsed(ushort id) {
			if(id >= 0x800) return false;
			return used[id];
		}

		public bool Use(ushort id) {
			if(id >= 0x800) return false;
			return used[id] = true;
		}
	}

	internal class ARAM {
		private byte[] ram;

		public ARAM(byte[] v) {
			ram = v;
		}

		public ushort w(ushort off) {
			if(off >= ram.Length) return 0;
			return Program.word(ram, off);
		}
	}

	internal class CRAM {
		private ushort[] ram;

		public CRAM(byte[] v) {
			ram = new ushort[v.Length / 2];

			for(int i = 0;i < v.Length;i += 2) {
				ushort color = (ushort)((v[i + 1] << 8) | v[i]);
				byte blue = (byte)((color & 0x7) * 2);
				byte green = (byte)(((color >> 3) & 0x7) * 2);
				byte red = (byte)(((color >> 6) & 0x7) * 2);
				ram[i / 2] = (ushort)(red | (green << 4) | (blue << 8));
			}
		}

		public ushort w(ushort off) {
			if(off / 2 >= ram.Length) return 0;
			return ram[off / 2];
		}
	}

	internal class VRAM {
		private byte[] vram;

		public VRAM(byte[] v) {
			vram = v;
		}

		public byte[] tt(ushort id) {
			return ta((ushort)(id * 0x20), 0x20);
		}

		public byte[] tt(ushort id, ushort num) {
			return ta((ushort)(id * 0x20), (ushort)(num * 0x20));
		}

		public byte[] ta(ushort addr, ushort num) {
			if(addr + num > 0x10000)
				return null;

			return vram.Skip(addr).Take(num).ToArray();
		}

		public ushort w(ushort off) {
			return Program.word(vram, off);
		}

		public byte b(ushort off) {
			return vram[off];
		}
	}

	internal class RegsVDP {
		public ushort planea, planeb, planew, sprites, hscroll;
		public byte bgcol, hscrolltype, planeszh, planeszv, planewhpos, planewvpos, mode4;
		public bool vscrolltype, planewhrght, planewvdown;

		public RegsVDP(byte[] d) {
			planea = (ushort)((d[2] & 0x38) * 0x400);
			planew = (ushort)((d[3] & 0x3E) * 0x400);
			planeb = (ushort)((d[4] & 0x7) * 0x2000);
			sprites= (ushort)((d[5] & 0x7F) * 0x200);
			hscroll= (ushort)((d[0xD] & 0x3F) * 0x400);

			bgcol = (byte)(d[7] & 0x3F);
			vscrolltype = (d[0xB] & 4) != 0;
			hscrolltype = (byte)(d[0xB] & 3);
			planeszh = (byte)(d[0x10] & 3);
			planeszv = (byte)((d[0x10] >> 4) & 3);
			planewhrght = (d[0x11] & 0x80) != 0;
			planewhpos = (byte)(d[0x11] & 0x1F);
			planewvdown = (d[0x12] & 0x80) != 0;
			planewvpos = (byte)(d[0x12] & 0x1F);
			mode4 = d[0xC];
		}

		internal byte[] ToArray() {
			byte[] o = new byte[6];
			
			o[0] = bgcol;
			o[1] = (byte)(planeszh | (planeszv << 4));
			o[2] = (byte)(hscrolltype |(vscrolltype ? 4 : 0));
			o[3] = (byte)(planewhpos | (planewhrght ? 0x80 : 0));
			o[4] = (byte)(planewvpos | (planewvdown ? 0x80 : 0));
			o[4] = (byte)(planewvpos | (planewvdown ? 0x80 : 0));
			o[5] = mode4;

			return o;
		}
	}
}
