using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace HintTableCreator {
	public partial class Form1 : Form {
		string folder = @"G:\hacks\current\ssrgboss\levels\fadein\";
		Image bg;
		List<bool[]> data;
		int off = 0, sty = -1;
		Color lnc = Color.Red;
		System.Timers.Timer t;
		bool animate = false;

		public Form1() {
			InitializeComponent();

			bg = Image.FromFile(folder + ".png");
			data = new List<bool[]>();

			t = new System.Timers.Timer();
			t.Interval = 1000 / 30;
			t.Elapsed += T_Elapsed;
			t.Start();


			DirectoryInfo di = new DirectoryInfo(folder);
			FileInfo[] Files = di.GetFiles("*.bin");
			foreach (FileInfo file in Files) {
				bool[] b = new bool[224];
				byte[] d = File.ReadAllBytes(file.FullName);
				bool start = true;
				if((d[0] & 0x80) != 0) {
					start = false;
				}
				d = d.Skip(2).ToArray();

				int z = 0;
				foreach(byte x in d) {
					for(int y = 0; y < x;y++) {
						b[z] = start;
						z++;
					}

					start = !start;
				}

				data.Add(b);
			}
		}

		private void T_Elapsed(object sender, System.Timers.ElapsedEventArgs e) {
			md.Invalidate();
			if (animate) addOff(1);
		}

		private void md_Paint(object sender, PaintEventArgs e) {
			using (Graphics g = md.CreateGraphics()) {
				g.DrawImage(bg, 0, 0, md.Width, md.Height);
				float y = (md.PointToClient(Cursor.Position).Y + 2) & 0xFFFFFFFE;

				if (data.Count != 0) {
					Pen p = new Pen(lnc, 2);
					for (int i = 0;i < 224;i++) {
						if (data.ElementAt(off)[i]) {
							g.DrawLine(p, 0, (i * 2) + 1, md.Width, (i * 2) + 1);
						}
					}

					p.Dispose();
				}

				if (y >= 0 && y < (md.Height - 1)) {
					Pen p = new Pen(Color.Green, 1);
					g.DrawLine(p, 0, y - 1, md.Width, y - 1);
					g.DrawLine(p, 0, y + 2, md.Width, y + 2);
					p.Dispose();

					if (data.Count != 0) {
						if ((Control.MouseButtons & MouseButtons.Left) != 0) {
							if (sty != -1 && (Control.ModifierKeys & Keys.Shift) != 0) {
								int max = Math.Max((int) (y / 2), sty) + 1;
								for (int i = Math.Min((int)(y/2), sty);i < max;i++) {
									data.ElementAt(off)[i] = true;
								}

							} else {
								data.ElementAt(off)[(int) (y / 2)] = true;
							}

							sty = -1;

						} else if ((Control.MouseButtons & MouseButtons.Right) != 0) {
							if (sty != -1 && (Control.ModifierKeys & Keys.Shift) != 0) {
								int max = Math.Max((int) (y / 2), sty);
								for (int i = Math.Min((int) (y / 2), sty);i < max;i++) {
									data.ElementAt(off)[i] = false;
								}

							} else {
								data.ElementAt(off)[(int) (y / 2)] = false;
							}

							sty = -1;

						} else if ((Control.ModifierKeys & Keys.Shift) != 0) {
							if (sty == -1) {
								sty = (int) (y / 2);
							}
						} else {
							sty = -1;
						}
					}
				}
			}
		}

		private void button1_Click(object sender, EventArgs e) {
			addOff(-1);
		}

		private void button2_Click(object sender, EventArgs e) {
			addOff(1);
		}

		private void addOff(int v) {
			if (data.Count == 0) {
				off = -1;

			} else {
				off += v;
				off %= data.Count;

				if(off < 0) off += data.Count;
			}

			mdntxt((off + 1) + "/" + data.Count);
		}

		private void button4_Click(object sender, EventArgs e) {
			if (data.Count != 0) {
				data.RemoveAt(off);
				addOff(0);
			}
		}

		private void button3_Click(object sender, EventArgs e) {
			if (data.Count == 0) {
				data.Add(new bool[224]);
				off = 0;

			} else {
				off++;
				data.Insert(off, new bool[224]);
			}
			mdn.Text = (off + 1) + "/" + data.Count;
		}

		private void button8_Click(object sender, EventArgs e) {
			if (data.Count != 0) {
				off++;
				data.Insert(off, new bool[224]);

				for(int i = 0;i < 224;i++) {
					data.ElementAt(off)[i] = data.ElementAt(off - 1)[i];
				}

				mdn.Text = (off + 1) + "/" + data.Count;
			}
		}

		private void clrb_Click(object sender, EventArgs e) {
			lnc = Color.Black;
		}

		private void clrr_Click(object sender, EventArgs e) {
			lnc = Color.Red;
		}

		private void button6_Click(object sender, EventArgs e) {
			if(data.Count == 0) return;
			DirectoryInfo di = new DirectoryInfo(folder);
			FileInfo[] Files = di.GetFiles("*.bin"); 
			foreach (FileInfo file in Files) {
				file.Delete();
			}

			byte[] d = convert(off);
			string o = "\r\n"+ string.Format("{0:x4}", ((d[0] << 8) | d[1])).ToUpper();
			d = d.Skip(2).ToArray();

			for (int i = 0;i < d.Length;i++) {
				o += "\r\n";
				for (int z = 0;z < 20 && i < d.Length;z ++, i++) {
					o += string.Format("{0:x2}", d[i]).ToUpper() + ' ';
				}
			}

			textBox2.Text = o.Substring(2);
		}

		private byte[] convert(int o) {
			List<byte> r = new List<byte>();
			bool lasttype = true;
			int count = 0;

			for(int i = 0;i < 224;i++) {
				if(data.ElementAt(o)[i] == lasttype) {
					count++;

				} else {
					r.Add((byte)count);
					count = 1;
					lasttype = data.ElementAt(o)[i];
				}
			}

			r.Add((byte) count);
			if (r[0] == 0) {
				r.RemoveAt(0);
				short x = (short) ((r.Count / 4) | 0x8000);
				r.Insert(0, (byte) (x >> 8));
				r.Insert(1, (byte)x);

			} else {
				short x = (short) (r.Count / 4);
				r.Insert(0, (byte) (x >> 8));
				r.Insert(1, (byte) x);
			}

			return r.ToArray();
		}

		private void button5_Click(object sender, EventArgs e) {
			if (animate) {
				animate = false;
				t.Stop();
				t.Interval = 1000 / 30;
				t.Start();
				button5.Text = "animate";
				return;
			}

			try {
				t.Stop();
				t.Interval = 1000 / float.Parse(textBox1.Text);
				t.Start();
				animate = true;
				textBox1.Text += "/"+ t.Interval;
				button5.Text = "stop";

			} catch (Exception) {
				textBox1.Text = "0";
			}
		}

		internal void mdntxt(string v) {
			try {
				if (InvokeRequired)
					Invoke(new mdntxt_(mdntxt), v);
				else {
					mdn.Text = v;
				}
			} catch (Exception) { }
		}
		public delegate void mdntxt_(string v);

		private void button7_Click(object sender, EventArgs e) {
			for(int i = 0; i < data.Count;i++) {
				string f = folder + i.ToString("D2").ToUpper() + ".bin";
				if(File.Exists(f)) File.Delete(f);
				File.WriteAllBytes(f, convert(i));
			}
		}

		protected override CreateParams CreateParams {
			get {
				CreateParams cp = base.CreateParams;
				cp.ExStyle |= 0x02000000;
				return cp;
			}
		}
	}
}
