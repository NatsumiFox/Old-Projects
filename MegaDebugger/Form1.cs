using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MegaDebugger {
	public partial class Form1 : Form {
		MEDwriter med;

		public Form1() {
			InitializeComponent();
			FormClosed += new FormClosedEventHandler(Form1_FormClosed);
			MEDcmd.KeyUp += MEDcmdKeyUp;

			Resize += Form1_Resize;
			bgw.DoWork += new DoWorkEventHandler(initalize);
			bgw.ProgressChanged += new ProgressChangedEventHandler(updateRAMprg);
			bgw.RunWorkerAsync();

			med = new MEDwriter(this);
		}

		private void Form1_FormClosed(object sender, FormClosedEventArgs e) {
			Environment.Exit(0);
			med.StopPCM();
		}

		private void Form1_Resize(object sender, EventArgs e) {
			secom.Height = recom.Height = (this.Height / 2) - 26;
			secom.Location = new Point(secom.Location.X, secom.Height + 10);
		}

		private void initalize(object sender, DoWorkEventArgs e) {
			try {
				InitializeRAM();
				bgw.ProgressChanged -= new ProgressChangedEventHandler(updateRAMprg);
				bgw.ProgressChanged += new ProgressChangedEventHandler(updateROMprg);
				InitializeROM();
				bgw.ProgressChanged -= new ProgressChangedEventHandler(updateROMprg);
			} catch (Exception) { }
		}

		public void setText(TextBox ob, string text) {
			if (InvokeRequired)
				Invoke(new setText_(setText), ob, text);
			else {
				ob.Text = text;
			}
		}
		public delegate void setText_(TextBox ob, string text);

		public void SetMEDStatus(string v) {
			try {
				if (InvokeRequired)
					Invoke(new SetMEDStatus_(SetMEDStatus), v);
				else {
					MEDstatus.Text = v;
				}
			} catch (Exception) { }
		}
		public delegate void SetMEDStatus_(string v);

		public void Addrec(string v) {
			try {
				if (InvokeRequired)
					Invoke(new Addrec_(Addrec), v);
				else {
					recom.Text += v;
				}
			} catch (Exception) { }
		}
		public delegate void Addrec_(string v);

		public void Addsec(string v) {
			try {
				if (InvokeRequired)
					Invoke(new Addsec_(Addsec), v);
				else {
					secom.Text += v;
				}
			} catch (Exception) { }
		}
		public delegate void Addsec_(string v);

		internal void SetOutBytes(string v) {
			try {
				if (InvokeRequired)
					Invoke(new SetOutBytes_(SetOutBytes), v);
				else {
					outbt.Text = v;
				}
			} catch (Exception) { }
		}
		public delegate void SetOutBytes_(string v);

		private void updateROMprg(object sender, ProgressChangedEventArgs e) {
			if(e.UserState != null) {
				if(e.UserState.GetType() == typeof(int)) {
					romProgress.Maximum = (int) e.UserState;
				}
			}

			romProgress.Value = e.ProgressPercentage;
		}

		private void updateRAMprg(object sender, ProgressChangedEventArgs e) {
			if (e.UserState != null) {
				if (e.UserState.GetType() == typeof(int)) {
					ramProgress.Maximum = (int)e.UserState;
				}
			}

			ramProgress.Value = e.ProgressPercentage;
		}


		private void InitializeRAM() {
			bgw.ReportProgress(0, (int)0x10000);
			string o = "";
			for (int i = 0;i <= 0xFFFF;i += 0x10) {
				o += toHexString(i, 4) + " 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00\r\n";
				bgw.ReportProgress(i);
			}

			// this removes the last \r\n chars
			o = o.Substring(0, o.Length - 2);
			setText(rambox, o);
			bgw.ReportProgress(1, (int) 1);
		}

		private void InitializeROM() {
			setText(rombox, rombox.Text + toHexString(0, 6) + " 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00");
			bgw.ReportProgress(100, (int) 100);
		}

		private static string toHexString(int res, int zeroes) {
			return string.Format("{0:x" + zeroes + "}", res).ToUpper();
		}
	}
}
