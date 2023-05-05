using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Microsoft.WindowsAPICodePack.Dialogs;
using static MainMenuCardMaker.Properties.Settings;
using static MainMenuCardMaker.Extensions;
using Microsoft.WindowsAPICodePack.Shell;
using System.Threading;
using System.IO;
using System.Diagnostics;

namespace MainMenuCardMaker {
	public partial class Form1 : Form {
		public static Form1 Context;
		public static bool DEBUG = false;

		Thread ControlProgram = null;
		ReloadType LoadType = ReloadType.None;
		string folder = null;

		public Form1(string[] args) {
			DEBUG = args.Length > 0 && args[0] == "debug";
			DEBUG = true;
			InitializeComponent();
			Context = this;

			AppDomain.CurrentDomain.UnhandledException += UnhandledException;
			Application.ThreadException += ThreadException;
			FormClosing += CheckFormClosing;
		}

		private void ThreadException(object sender, ThreadExceptionEventArgs e) {
			MessageBox.Show(e.Exception.ToString(), "Thread Exception", MessageBoxButtons.OK);
		}

		private void UnhandledException(object sender, UnhandledExceptionEventArgs e) {
			MessageBox.Show(e.ExceptionObject.ToString(), "Unhandled Exception", MessageBoxButtons.OK);
		}

		protected override void OnClosing(CancelEventArgs e) {
			base.OnClosing(e);
			importImagesControl1.Dispose();
		}

		protected override void OnLoad(EventArgs e) {
			base.OnLoad(e);
			ControlProgram = new Thread(RunControlProgram) {
				IsBackground = true,
				Priority = ThreadPriority.Normal,
			};
			ControlProgram.Start();

			tabControl1.Selecting += TabChanged;

			if (DEBUG) {
				folder = @"G:\hacks\current\Battle Race\Main Menu\Backgrounds\SSZ\";
				LoadType = ReloadType.Image;
			}
		}

		#region Menu	
		protected void CheckFormClosing(object sender, FormClosingEventArgs e) {
		//	e.Cancel = e.CloseReason == CloseReason.WindowsShutDown || e.CloseReason == CloseReason.TaskManagerClosing || 
		//		MessageBox.Show("Do you want to close? Any unsaved progress will be lost.", "Are you sure?", MessageBoxButtons.YesNo) == DialogResult.No;
		}

		private void exitToolStripMenuItem_Click(object sender, EventArgs e) {
			Application.Exit();
		}

		private void openToolStripMenuItem_Click(object sender, EventArgs e) {
			using (CommonOpenFileDialog dialog = new CommonOpenFileDialog() {
					IsFolderPicker = true,
					EnsureFileExists = true,
				}) {

				if (dialog.ShowDialog() == CommonFileDialogResult.Ok) {
					LoadType = ReloadType.Image;
					folder = dialog.FileName;
					if (!folder.EndsWith("\\")) folder += "\\";
				}
			}
		}

		private void saveToolStripMenuItem_Click(object sender, EventArgs e) {
			if(Converter.Export != null) {
				File.WriteAllBytes(folder + "Tiles.bin", Converter.Export.DumpTiles());
				File.WriteAllBytes(folder + "PlaneA.bin", Converter.Export.DumpPlaneA());
				File.WriteAllBytes(folder + "PlaneB.bin", Converter.Export.DumpPlaneB());
			}
		}
		#endregion

		#region Control Program
		private void TabChanged(object sender, TabControlCancelEventArgs e) {
			if(e.Action == TabControlAction.Selecting)
			switch (e.TabPageIndex) {
					case 1:
						LoadType = ReloadType.GenTiles;
						break;
			}
		}

		private void RunControlProgram(object o) {
			start:
			// delay until a load is queued
			while (LoadType == ReloadType.None)
				Thread.Sleep(250);

			// get the reload type and process it
			ReloadType t = LoadType;
			LoadType = ReloadType.None;
			switch (t) {
				case ReloadType.Image: {
						importImagesControl1.Invoke(() => {
							tabControl1.SelectTab(0);
							importImagesControl1.SetUpdate(false);
							importImagesControl1.MakeCurrent();

							// this is the all-reload type
							Stopwatch sw = new Stopwatch();
							sw.Start();
							Converter.Reset();
							Converter.LoadImage(folder + "Plane A.bmp", folder + "Plane B.bmp");
							sw.Stop();
							loadedTime.Text = "Load Time: " + sw.ElapsedMilliseconds + "ms (" + sw.ElapsedTicks + " ticks)";

							importImagesControl1.SetUpdate(true);
							importImagesControl1.Refresh();
							importPaletteControl.Refresh();

						//	if(DEBUG) tabControl1.SelectTab(1);
						});
					}
					break;

				case ReloadType.GenTiles:
					Converter.GenTiles();
					break;
			}

			goto start;
		}

		#endregion
	}

	internal enum ReloadType {
		None = 0,
		Image, GenTiles,
	}

	internal static class Extensions {
		public static void Invoke(this Control Control, Action Action) {
			Control.Invoke(Action);
		}
	}
}
