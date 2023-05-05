using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;

namespace SonicRetro.SonLVL.API.S3K {
	public class SSZ {
		public List<SSZdat> list;
		public byte[] chunk;
		public static int color = 0x60F76262;

		public SSZ() {
			chunk = new byte[0];
			list = new List<SSZdat>();
		}

		public SSZ(byte[] head, byte[] chunk) {
			this.chunk = chunk;
			list = new List<SSZdat>();

			for (int i = 0;i < head.Length;i += 0xA) {
				list.Add(new SSZdat(Dir.Word(head, i), Dir.Word(head, i + 2), Dir.Word(head, i + 4), Dir.Word(head, i + 6), Dir.Word(head, i + 8)));
			}
		}

		public byte[] SaveHeader() {
			byte[] r = new byte[0xA * list.Count];
			int off = 0;

			foreach (SSZdat d in list) {
				Dir.Pword(r, off, d.flags);
				Dir.Pword(r, off + 2, Round32(d.xpos + 8) - 8);
				Dir.Pword(r, off + 4, Round64(d.ypos));
				Dir.Pword(r, off + 6, Round32(d.width));
				Dir.Pword(r, off + 8, d.surface);
				off += 0xA;
			}

			return r;
		}

		public byte[] SaveChunk() {
			return chunk;
		}

		public void InitBits() {
			foreach (SSZdat s in list) s.drawBits(this);
		}

		public static int Round64(int i) {
			return 64 * (int)Math.Round(i / 64D);
		}

		public static int Round32(int i) {
			return 32 * (int)Math.Round(i / 32D);
		}

		public static Rectangle Round(Rectangle r) {
			r.X = 32 * (int)Math.Round(r.X / 32D);
			r.Y = 64 * (int)Math.Round(r.Y / 64D);
			r.Width = 32 * (int)Math.Round(r.Width / 32D);
			return r;
		}
	}

	public class SSZdat {
		public int flags, xpos, ypos, width, surface;
		public int _x { get { return SSZ.Round32(xpos + 8) + 0x20 - SSZ.Round32(width); } }
		public int _y { get { return SSZ.Round64(ypos) + 0x180 - 0xA0; } }
		public int _w { get { return SSZ.Round32(width) * 2; } }
		public BitmapBits BmpBits;
		public System.Windows.Forms.ListViewItem Item { get; set; }

		public SSZdat(int f, int x, int y, int w, int s) {
			flags = f;
			xpos = x;
			ypos = y;
			width = w;
			surface = s;
		}

		public Rectangle ToRect() {
			return new Rectangle(_x, _y, _w, 0x80);
		}

		public Point Middle() {
			Rectangle r = ToRect();
			return new Point(r.X + (r.Width / 2), r.Y + (r.Height / 2));
		}

		public void drawBits(SSZ ssz) {
			BmpBits = new BitmapBits(_w, 0x80);
			int w = SSZ.Round32(width);

			for (int x = 0;x < w;x++) {
				int pos = ((flags & 1) == 0 ? x : ~x + w) + surface;
				if (pos < ssz.chunk.Length) {
					int h = 0x80 - ssz.chunk[pos];

					for (int y = 0;y < 8;y++) {
						BmpBits.Bits[(x * 2) + ((y + h) * w * 2)] = 1;
						BmpBits.Bits[(x * 2) + 1 + ((y + h) * w * 2)] = 1;
					}
				}
			}
		}
	}
}
