using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using OpenTK.Graphics;
using OpenTK.Graphics.OpenGL;
using static MainMenuCardMaker.GLlib;

namespace MainMenuCardMaker.Controls {
	public partial class ImportPaletteControl : BaseGlControl {
		public ImportPaletteControl() {
			InitializeComponent();
			SetStyle(ControlStyles.StandardDoubleClick, false);
			translate = true;
		}

		private Point MousePos = new Point(-1, -1);

		private int MouseHoverSrc = -1, MouseHoverDest = -1;

		protected override void OnMouseMove(MouseEventArgs e) {
			base.OnMouseMove(e);
			MousePos = e.Location;
			MouseHoverSrc = MouseHoverDest = -1;

			if (update && Converter.Import != null) {
				// if we are currently editing palette update the colors first
				if (EditDrag != -1) {
					ColorMD c = Converter.GetPaletteByOffset(SelectedPalette);
					if (!c.nowrite) c.Color = (short)((c.Color & ColorAndArray[EditDrag]) | (FindClosestStep(e.X) * 2 << ColorShitArray[EditDrag]));
					UpdatePalette();
					return;
				}

				if (SrcDrag == -1) {
					// if we are not dragging, then we can choose what we are highlighting
					switch (GetMouseTarget(e.Location, out int id)) {
						case 0:
							MouseHoverDest = id;
							break;

						case 1:
							MouseHoverSrc = id;
							break;
					}
				}

				Invalidate();
			}
		}

		protected override void OnMouseLeave(EventArgs e) {
			base.OnMouseLeave(e);
			MousePos = new Point(-1, -1);
			if (Converter.Import != null) Invalidate();
		}

		private int SelectedSrc = -1, SelectedSrcColor = 0;
		private int[] SelectedSrcColorArray = {
			0xFFFFFF, 0x000000, 0x0000FF, 0x00FF00, 0xFF0000
		};

		protected override void OnMouseClick(MouseEventArgs e) {
			base.OnMouseDown(e);

			if (update && Converter.Import != null) {
				switch (e.Button) {
					case MouseButtons.Left: {
							switch (GetMouseTarget(e.Location, out int id)) {
								case 0:
									if (id != -1 && Converter.GetPaletteByOffset(id) != null) SelectedPalette = id;
									break;

								case 2:
									break;

								case 1: {
										if (id == -1) {
											// selection did not change, do not bother updating again
											if (SelectedSrc == -1) break;
											SelectedSrc = -1;

										} else {
											// if selection doesn't change, display other color
											if (id == SelectedSrc) SelectedSrcColor++;
											else SelectedSrcColor = 0;

											SelectedSrc = id;
										}

										// TODO: Correctly process this stuff. Right now just do the lazy way out
										int[] pal = Converter.Import.CopyPalette();

										UpdatePalette(SelectedSrc >= 0 ? new int[] { SelectedSrc, SelectedSrcColorArray[SelectedSrcColor % SelectedSrcColorArray.Length] } : new int[0]);
									}
									break;
							}

						}
						break;
				}
			}
		}

		private int SrcDrag = -1, EditDrag = -1;
		private int SelectedPalette = 0;

		protected override void OnMouseDown(MouseEventArgs e) {
			base.OnMouseDown(e);

			if (update && Converter.Import != null) {
				switch (e.Button) {
					case MouseButtons.Left: {
							switch (GetMouseTarget(e.Location, out int id)) {
								case 0:
									break;

								case 2:
									EditDrag = id;
									break;

								case 1: {
										SrcDrag = id;
									}
									break;
							}

						}
						break;
				}
			}
		}

		protected override void OnMouseUp(MouseEventArgs e) {
			base.OnMouseDown(e);

			if (update && Converter.Import != null) {
				switch (e.Button) {
					case MouseButtons.Left: {
							switch (GetMouseTarget(e.Location, out int id)) {
								case 0:
									// check if we dragged a source color into a destination palette entry
									if (SrcDrag != -1 && id != -1) {
										ColorMD m = Converter.GetPaletteByOffset(id);
										if (m == null) break;

										// definitely dragged into a palette entry. Link color
										Converter.Import.MapTable[SrcDrag] = m;
										if (!m.nowrite) m.IntColor = Converter.Import.ColorTable[SrcDrag];
										UpdatePalette();
									}
									break;

								case 2:
									break;

								case 1: {

									}
									break;
							}

						}
						break;
				}

				SrcDrag = -1;

				// if we were editing palette, make sure we update palette correctly
				if (EditDrag != -1) {
					EditDrag = -1;
					UpdatePalette();
				}
			}
		}

		private void UpdatePalette(params int[] block) {
			this.Invoke(() => {
				Form1.Context.importImagesControl1.SetUpdate(false);
				Form1.Context.importImagesControl1.MakeCurrent();
				Converter.Import.ChangePalette(block);
				Form1.Context.importImagesControl1.SetUpdate(true);
				Form1.Context.importImagesControl1.Invalidate();
			});
		}

		private int GetMouseTarget(Point location, out int id) {
			// figure out what part we clicked
			if (location.Y < ActualHeight / 2) {
				id = 0;
				// we selected the destination palette thing, maybe
				for (int xo = 0;xo < Converter.palette.Length;xo++) {
					for (int yo = 0;yo < Converter.palette[xo].Length;yo++) {

						if (GetPalSelBounds(xo, yo, true).Contains(location)) {
							id += yo;
							return 0;
						}
					}

					id += Converter.palette[xo].Length;
				}

				id = -1;
				return 0;

			} else if (location.Y >= (ActualHeight / 2) + 50) {
				// selected source palette
				for (int i = 0;i < Converter.Import.ColorTable.Length;i++) {
					if (GetPalSrcBounds(i).Contains(location)) {
						id = i;
						return 1;
					}
				}

				id = -1;
				return 1;

			} else {
				// maybe selected palette editor
				for (int i = 0;i < 3;i++) {
					if (GetEditBounds(i).Contains(location)) {
						id = i;
						return 2;
					}
				}

				id = -1;
				return 2;
			}
		}

		private Color BorderColor => Color.FromArgb(255, 0, 0);
		private Color BorderHoverColor => Color.FromArgb(128, 255, 128);
		private Color BorderHighlightColor => Color.FromArgb(255, 255, 255);
		private Color[] PaletteTrackColor => new Color[] { Color.FromArgb(128, 128, 255), Color.FromArgb(128, 255, 128), Color.FromArgb(255, 128, 128), };
		private Color PaletteNobColor => Color.FromArgb(144, 144, 144);
		private Color PaletteNobDisabledColor => Color.FromArgb(192, 0, 0);

		protected override void Draw() {
			if (Converter.Import != null) {
				// prepare to check if we want to highlight a destination palette entry
				int dsthi = -1;
				if(MouseHoverSrc != -1 && Converter.Import.MapTable != null)
					dsthi = Converter.GetPaletteEntryOffset(Converter.Import.MapTable[MouseHoverSrc]);

				// prepare to check if we want to highlight a source palette entry
				int[] srchi = new int[0];
				int srco = 0;

				if(MouseHoverDest != -1) {
					List<int> entries = new List<int>();

					for (int i = 0;i < Converter.Import.MapTable.Length;i++) {
						ColorMD c = Converter.Import.MapTable[i];

						if(c != null && Converter.GetPaletteEntryOffset(c) == MouseHoverDest)
							entries.Add(i);
					}

					srchi = entries.ToArray();
				}

				// render the destination palette
				for (int xo = 0, off = 0;xo < Converter.palette.Length;xo++) {
					for (int yo = 0;yo < Converter.palette[xo].Length;yo++, off++) {
						// get bounds, and do check for mouse and null palette entry
						Rectangle bnds = GetPalSelBounds(xo, yo, true);
						bool ms = bnds.Contains(MousePos), isnull = Converter.palette[xo][yo] == null;

						// draw the palette entry if needed
						if (!isnull) DrawRectangleFilled(Color.FromArgb(Converter.palette[xo][yo].IntColor), bnds, -2);
						if (ms || !isnull) DrawRectangle(ms ? BorderHighlightColor : dsthi == off ? BorderHoverColor : BorderColor, bnds, -2);
					}
				}

				// render the source palette
				for (int i = 0;i < Converter.Import.ColorTable.Length;i++) {
					bool hover = false;

					if(srchi.Length > srco) 
						if(hover = srchi[srco] == i)
							srco++;

					Rectangle bnds = GetPalSrcBounds(i);
					DrawRectangleFilled(Color.FromArgb(Converter.Import.ColorTable[i]), bnds, -2);
					DrawRectangle(bnds.Contains(MousePos) ? BorderHighlightColor : hover ? BorderHoverColor : BorderColor, bnds, -2);
				}

				// render palette editor
				ColorMD selc = Converter.GetPaletteByOffset(SelectedPalette);
				DrawRectangleFilled(Color.FromArgb(selc.IntColor), 0, ActualHeight / 2, PaletteEditorSize, PaletteEditorSize, -2);
				DrawRectangle(BorderColor, 0, ActualHeight / 2, PaletteEditorSize, PaletteEditorSize, -2);

				// draw the tracks and selectors
				for (int i = 0;i < 3;i++) {
					DrawRectangleFilled(PaletteTrackColor[i], GetEditBounds(i), -4);
					DrawRectangleFilled(selc.nowrite ? PaletteNobDisabledColor : PaletteNobColor, 
						GetEditStepPos(((selc.Color >> ColorShitArray[i]) & 0xE) / 2), ActualHeight / 2 + (i * PaletteEditorSize / 3), PaletteEditorSize / 3, PaletteEditorSize / 3, -1);
				}
			}
		}

		private int[] ColorShitArray = { 8, 4, 0, };
		private int[] ColorAndArray = { 0xEE, 0xE0E, 0xEE0, };
		private int PaletteEditorSize = 50;

		private Rectangle GetEditBounds(int id) {
			return new Rectangle(PaletteEditorSize, ActualHeight / 2 + (id * PaletteEditorSize / 3), ActualWidth - PaletteEditorSize, PaletteEditorSize / 3);
		}

		private int GetEditStepPos(int step) {
			return (int)(((ActualWidth - PaletteEditorSize - (PaletteEditorSize / 3) - 6) / 7.0) * step) + PaletteEditorSize + 3;
		}

		private int FindClosestStep(int x) {
			int laststep = -1;

			for (int i = 0;i < 8;i++) {
				int sp = GetEditStepPos(i);
				if (sp > x) {
					if (laststep == -1) return i;

					x -= laststep;
					return i - ((sp - laststep) / 2 > x ? 1 : 0);
				}

				laststep = sp;
			}

			return 7;
		}

		private Rectangle GetPalSelBounds(int xo, int yo, bool offstart) {
			return new Rectangle(
				xo * (ActualWidth / Converter.palette.Length),
				(offstart ? (ActualHeight / (Converter.lineHeight * 2) * (Converter.lineHeight - Converter.palette[xo].Length)) : 0) + yo * (ActualHeight / (Converter.lineHeight * 2)), 
				ActualWidth / Converter.palette.Length, 
				(ActualHeight / (Converter.lineHeight * 2)));
		}

		private int PalSrcSize = 40;

		private Rectangle GetPalSrcBounds(int id) {
			int vsize = (ActualHeight / 2) - PaletteEditorSize;
			int vitems = Math.Max(vsize / PalSrcSize, 1);
			int starty = ActualHeight - (vitems * PalSrcSize);

			return new Rectangle(PalSrcSize * (id / vitems), starty + (PalSrcSize * (id % vitems)), PalSrcSize, PalSrcSize);
		}
	}
}
