using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;

namespace SonicRetro.SonLVL.API.S3K {
	public class Dir {
		public List<DirDat> list;
		private static DirDat basedat { get { return new DirDat(0x0000, 0x0000, 0xFFFF, 0xFFFF, 0xE0FF, 0, 0, Color.Transparent); } }
		private const int MAX_INDEX = 0x1F;
		private static int colindx = 0;
		private static Color[] cols = {
			Color.FromArgb(0x60A9699F),
			Color.FromArgb(0x60B69B69),
			Color.FromArgb(0x608CA336),
			Color.FromArgb(0x60123269),
			Color.FromArgb(0x6047033D),
			Color.FromArgb(0x609E6B0E),
			Color.FromArgb(0x609FAE65),
			Color.FromArgb(0x60687C9E),
			Color.FromArgb(0x6078268B),
			Color.FromArgb(0x60654304),
			Color.FromArgb(0x604D6104),
			Color.FromArgb(0x604B5C79),
			Color.FromArgb(0x60804A78),
			Color.FromArgb(0x60EFCF95),
			Color.FromArgb(0x607A970D),
			Color.FromArgb(0x602D4671),

			Color.FromArgb(0x60806BA3),
			Color.FromArgb(0x60B68469),
			Color.FromArgb(0x60AA9D39),
			Color.FromArgb(0x6009684C),
			Color.FromArgb(0x601F0945),
			Color.FromArgb(0x60EFB495),
			Color.FromArgb(0x6086AD69),
			Color.FromArgb(0x6025705A),
			Color.FromArgb(0x6033136C),
			Color.FromArgb(0x60652604),
			Color.FromArgb(0x60EFE495),
			Color.FromArgb(0x60467869),
			Color.FromArgb(0x60482E74),
			Color.FromArgb(0x609E400E),
			Color.FromArgb(0x60655A04),
			Color.FromArgb(0x60629E8C),
		};

		public Dir() {
			list = new List<DirDat>();
		}

		public Dir(byte[] box, byte[] pos) {
			list = new List<DirDat>();

			int b = 0, p = 0;
			for (int i = pos.Length / 4;i > 1;i--) {
				list.Add(new DirDat(Word(box, b), Word(box, b + 4), Word(box, b + 2), Word(box, b + 6), Word(box, b + 8), Word(pos, p), Word(pos, p + 2), GetColor()));
				b += 10;
				p += 4;
			}

			list.Reverse();
		}

		public List<DirDat> EmptyList() {
			List<DirDat> old = list;
			list = new List<DirDat>();
			return old;
		}

		internal byte[] SaveBox() {
			byte[] r = new byte[10 * (list.Count + 1)];
			int off = 0;

			foreach (DirDat d in list) {
				Pword(r, off, Round(d.xpos));
				Pword(r, off + 2, Round(d.xrad));
				Pword(r, off + 4, Round(d.ypos));
				Pword(r, off + 6, Round(d.yrad));
				Pword(r, off + 8, d.angle);
				off += 10;
			}

			Pword(r, off, basedat.xpos);
			Pword(r, off + 2, basedat.xrad);
			Pword(r, off + 4, basedat.ypos);
			Pword(r, off + 6, basedat.yrad);
			Pword(r, off + 8, basedat.angle);

			return r;
		}

		internal byte[] SavePos() {
			byte[] r = new byte[4 * (list.Count + 1)];
			int off = 0;

			foreach (DirDat d in list) {
				Pword(r, off, d.sxpos);
				Pword(r, off + 2, d.sypos);
				off += 4;
			}

			Pword(r, off, basedat.sxpos);
			Pword(r, off + 2, basedat.sypos);

			return r;
		}

		public static int Round(int i) {
			return 8 * (int)Math.Round(i / 8D);
		}

		public static Rectangle Round(Rectangle r) {
			r.X = 8 * (int)Math.Round(r.X / 8D);
			r.Y = 8 * (int)Math.Round(r.Y / 8D);
			r.Width = 8 * (int)Math.Round(r.Width / 8D);
			r.Height = 8 * (int)Math.Round(r.Height / 8D);
			return r;
		}

		public static Color GetColor() {
			colindx++;
			colindx &= MAX_INDEX;
			return cols[colindx];
		}

		public static int Word(byte[] dat, int d) {
			return (dat[d] << 8) | (dat[d + 1] & 0xFF);
		}

		public static void Pword(byte[] r, int off, int d) {
			r[off] = (byte)(d >> 8);
			r[off + 1] = (byte)d;
		}
	}

	public class DirDat {
		public int xpos, ypos, xrad, yrad, angle, sxpos, sypos;
		public Color color;

		public int Left { get { return xpos; } }
		public int Right { get { return xpos + xrad; } }
		public int Top { get { return ypos; } }
		public int Bot { get { return ypos + yrad; } }
		public System.Windows.Forms.ListViewItem Item { get; set; }
		public Color ItemColor { get; set; }

		public DirDat(int xpos, int ypos, int xrad, int yrad, int angle, int sxpos, int sypos, Color color) {
			if (angle >= 0xF000) angle &= 0xC0FF;

			this.xpos = xpos;
			this.ypos = ypos;
			this.xrad = xrad;
			this.yrad = yrad;
			this.angle = angle;
			this.sxpos = sxpos;
			this.sypos = sypos;
			this.color = color;
		}

		public Rectangle ToRect() {
			return new Rectangle(xpos, ypos, xrad, yrad);
		}

		public Rectangle ToRectSpawn() {
			return new Rectangle(sxpos - 9, sypos - 0x13, 9 * 2, 0x13 * 2);
		}

		public Point Middle() {
			return new Point(xpos + (xrad / 2), ypos + (yrad / 2));
		}
	}
}
