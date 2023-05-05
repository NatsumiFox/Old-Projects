using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using static SonicRetro.SonLVL.API.S3K.Dir;

namespace SonicRetro.SonLVL.API.S3K {
	public class Swap {
		public List<Swaps> subs;

		public Swap() {
			subs = new List<Swaps>();
		}

		public Swap(string path) {
			subs = new List<Swaps>();
			foreach (System.IO.FileInfo file in new DirectoryInfo(path.Substring(0, path.LastIndexOf("/") == -1 ? path.LastIndexOf("\\") : path.LastIndexOf("/"))).GetFiles("*s*.dat", SearchOption.TopDirectoryOnly)) {
				if (file.Name.StartsWith(path.Substring(path.LastIndexOf("/") == -1 ? path.LastIndexOf("\\") + 1 : path.LastIndexOf("/") + 1))) {
					byte[] data = File.ReadAllBytes(file.FullName);
					Swaps s = new Swaps();

					for (int i = 10;i < data.Length;i += 8) {
						s.items.Add(new SwapDat(Word(data, i), Word(data, i + 2), Word(data, i + 4), Word(data, i + 6), GetColor()));
					}

					subs.Add(s);
					s.refresh();
				}
			}
		}

		internal void Save(string path, CompressionType type) {
			int indx = 0;
			foreach (Swaps s in subs) {
				if (s.items.Count > 0) {
					byte[] data = new byte[10 + s.items.Count * 8];
					Pword(data, 0, s.left);
					Pword(data, 2, s.right);
					Pword(data, 4, s.up);
					Pword(data, 6, s.down);
					Pword(data, 8, s.items.Count - 1);
					int pos = 10;

					foreach (SwapDat d in s.items) {
						Pword(data, pos, d.left);
						Pword(data, pos + 2, d.right);
						Pword(data, pos + 4, d.up);
						Pword(data, pos + 6, d.down);
						pos += 8;
					}

					Compression.Compress(data, path + 's' + indx + ".dat", type);
				}
				indx++;
			}
		}
	}

	public class Swaps {
		public List<SwapDat> items;
		public int left, right, up, down;
		public int width { get { return right - left; } }
		public int height { get { return down - up; } }

		public Rectangle toRect() {
			return new Rectangle(left, up, width, height);
		}

		public Swaps() {
			items = new List<SwapDat>();
		}

		public Rectangle refresh() {
			left = 0xFFFF; right = 0; up = 0xFFFF; down = 0;

			foreach (SwapDat d in items) {
				if (d.left < left) left = d.left;
				if (d.up < up) up = d.up;
				if (d.right > right) right = d.right;
				if (d.down > down) down = d.down;
			}

			if (items.Count > 0) {
				left -= 0x40; right += 0x40; up -= 0x40; down += 0x40;
				if (left < 0) left = 0;
				if (up < 0) up = 0;
			}
			return toRect();
		}
	}

	public class SwapDat {
		public int left, right, up, down;
		public Color color;

		public int width { get { return right - left; } }
		public int height { get { return down - up; } }
		public System.Windows.Forms.ListViewItem Item { get; set; }
		public Color ItemColor { get; set; }

		public SwapDat(int xleft, int xright, int yup, int ydown, Color color) {
			left = xleft;
			right = xright;
			up = yup;
			down = ydown;
			this.color = color;
		}

		public Rectangle toRect() {
			return new Rectangle(left, up, width, height);
		}

		public Point Middle() {
			return new Point(left + (width / 2), up + (height / 2));
		}
	}
}