using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using OpenTK;
using OpenTK.Graphics.OpenGL;
using static MainMenuCardMaker.GLlib;

namespace MainMenuCardMaker.Controls {
	public partial class ConvertControl : BaseGlControl {
		public ConvertControl() {
			InitializeComponent();
		}

		protected override void OnControlRemoved(ControlEventArgs e) {
			base.OnControlRemoved(e);
			if (Pixel != 0) GL.DeleteTexture(Pixel);
		}

		private int Pixel = 0;

		protected override void OnLoad(EventArgs e) {
			base.OnLoad(e);

			if (!DesignMode)
				lock (busy) {
					MakeCurrent();
					CreateShaderProgram(Properties.Resources.PixelVertexShader, Properties.Resources.PixelFragmentShader2, out ShaderProg, out VertexAddr, out FragmentAddr);
					PaletteLoc = GL.GetUniformLocation(ShaderProg, "palette");
					TextureLoc = GL.GetUniformLocation(ShaderProg, "texture");
					PalLineLoc = GL.GetUniformLocation(ShaderProg, "line");
					
					Pixel = LoadTexture(new byte[] {
						1,
					}, 1, 1, PixelInternalFormat.R8, PixelFormat.Red);
				}
		}

		private int ShaderProg = 0, VertexAddr = 0, FragmentAddr = 0;
		private int PaletteLoc = 0, TextureLoc = 0, PalLineLoc = 0;

		private Point MousePos = new Point(-1, -1);

		protected override void OnMouseMove(MouseEventArgs e) {
			base.OnMouseMove(e);
			MousePos = e.Location;
			MousePos.X = (int)((MousePos.X - (ClientRectangle.Width / 2) + XPosition) / ZoomLevel) + (ActualWidth / 2);
			MousePos.Y = (int)((MousePos.Y - (ClientRectangle.Height / 2) + YPosition) / ZoomLevel) + (ActualHeight / 2);

			if (MousePos.X < 0 || MousePos.X >= ActualWidth || MousePos.Y < 0 || MousePos.Y >= ActualWidth) {
				MousePos.X = -1;
				MousePos.Y = -1;

			} else if(PlaneSelecting)
				PlaneSelectDst = new Point(MousePos.X & 0xFFF8, MousePos.Y & 0xFFF8);

			if (Converter.Export != null)
				Invalidate();
		}

		protected override void OnMouseLeave(EventArgs e) {
			base.OnMouseLeave(e);
			MousePos = new Point(-1, -1);
			if (Converter.Export != null) Invalidate();
		}
		
		private TileRef SelectedTile = null;

		protected override void OnMouseClick(MouseEventArgs e) {
			base.OnMouseDown(e);

			if (e.Button == MouseButtons.Right && Converter.Export != null && !PlaneEdit)
				if (MousePos.X >= 0 && MousePos.Y >= 0) {
					SelectedTile = Converter.Export.Plane[(MousePos.X / 8) + ((MousePos.Y / 8) * 64)];

					Form1.Context.Invoke(() => {
						Form1.Context.tileNumber.Text = "Word: " + SelectedTile.GetWord().ToString("X4") +" - Used: "+ SelectedTile.tile.used;
					});

				} else {
					SelectedTile = null;
					Form1.Context.Invoke(() => {
						Form1.Context.tileNumber.Text = "Total tiles: " + Converter.Export.MaxTile.ToString("X");
					});
				}
		}

		private Point PlaneSelectSrc = new Point(-1, -1);
		private Point PlaneSelectDst = new Point(-1, -1);
		private bool PlaneSelecting = false;

		protected override void OnMouseDown(MouseEventArgs e) {
			base.OnMouseDown(e);

			if (e.Button == MouseButtons.Right && Converter.Export != null && PlaneEdit) {
				if (MousePos.X >= 0 && MousePos.Y >= 0) {
					PlaneSelectDst = PlaneSelectSrc = new Point(MousePos.X & 0xFFF8, MousePos.Y & 0xFFF8);
					PlaneSelecting = true;

				} else PlaneSelectDst = PlaneSelectSrc = new Point(-1, -1);
			}
		}

		protected override void OnMouseUp(MouseEventArgs e) {
			base.OnMouseUp(e);

			if (e.Button == MouseButtons.Right && Converter.Export != null && PlaneEdit && PlaneSelectSrc.X >= 0 && PlaneSelectSrc.Y >= 0)
				PlaneSelecting = false;
		}

		private bool PlaneEdit = false;

		protected override void OnKeyUp(KeyEventArgs e) {
			base.OnKeyUp(e);

			if(Converter.Export != null && SelectedTile != null)
				switch (e.KeyCode) {
					case Keys.F1:
						SelectedTile.flags = (ushort)((SelectedTile.flags & 0xE000) | (((SelectedTile.flags & 0x1800) + 0x800) & 0x1800));
						break;

					case Keys.F2:
						SelectedTile.flags = (ushort)((SelectedTile.flags & 0x9800) | (((SelectedTile.flags & 0x6000) + 0x2000) & 0x6000));
						break;

					case Keys.F3:
						SelectedTile.flags ^= 0x8000;
						break;

					case Keys.Space:
						PlaneEdit ^= true;
						PlaneSelecting = false;
						Invalidate();
						break;

					case Keys.Enter:
						// convert the plane to have proper plane switch
						if(!PlaneSelecting && PlaneEdit) {
							int leftx = Math.Min(PlaneSelectSrc.X, PlaneSelectDst.X) / 8;
							int righx = Math.Max(PlaneSelectSrc.X, PlaneSelectDst.X) / 8 + 1;
							int topy = Math.Min(PlaneSelectSrc.Y, PlaneSelectDst.Y) / 8;
							int boty = Math.Max(PlaneSelectSrc.Y, PlaneSelectDst.Y) / 8 + 1;

							int[] plane = new int[] { 0, 0 };

							// calculate which plane to use
							for(int y = topy;y < boty; y++)
								for(int x = leftx;x < righx;x++) {
									plane[(Converter.Export.Plane[(y * 64) + x].flags & 0x8000) >> 15]++;
								}

							// set to use this plane
							ushort or = (ushort)(plane[0] < plane[1] ? 0 : 0x8000);

							for (int y = topy;y < boty;y++)
								for (int x = leftx;x < righx;x++) {
									Converter.Export.Plane[(y * 64) + x].flags &= 0x7FFF;
									Converter.Export.Plane[(y * 64) + x].flags |= or;
									Converter.Export.HiPlane[(y * 64) + x] = or > 0;
								}
							Invalidate();
						}
						break;
				}
		}

		protected override void Draw() {
			if (Converter.Export != null && Converter.Export.Palette != 0) {
				GL.Enable(EnableCap.Texture2D);
				GL.UseProgram(ShaderProg);

				// Set palette texture as active and bind it
				GL.Uniform1(PaletteLoc, 1);
				GL.ActiveTexture(TextureUnit.Texture1);
				GL.BindTexture(TextureTarget.Texture2D, Converter.Export.Palette);


				// render image
				for (int y = 0;y < 64;y++)
					for (int x = 0;x < 64;x++) {
						TileRef r = Converter.Export.Plane[(y * 64) + x];

						if (r != null) {
							GL.Uniform1(TextureLoc, 0);
							GL.ActiveTexture(TextureUnit.Texture0);
							r.Draw(x * 8, y * 8, PalLineLoc, PlaneEdit);
						}
					}

				// if we selected a tile, highlight all the same tiles

				if (SelectedTile != null && !PlaneEdit) {
					for (int y = 0;y < 64;y++)
						for (int x = 0;x < 64;x++) {
							TileRef t = Converter.Export.Plane[x + (y * 64)];

							if (t != null && t.tile == SelectedTile.tile) 
								DrawRect(9f, x * 8, y * 8, 8, 8);
						}

				} else if (PlaneEdit && PlaneSelectSrc.X >= 0) {
					// if we are selecting a plane to change priority, show highlight
					int leftx = Math.Min(PlaneSelectSrc.X, PlaneSelectDst.X);
					int righx = Math.Max(PlaneSelectSrc.X, PlaneSelectDst.X);
					int topy = Math.Min(PlaneSelectSrc.Y, PlaneSelectDst.Y);
					int boty = Math.Max(PlaneSelectSrc.Y, PlaneSelectDst.Y);

					DrawRect(9f, leftx, topy, righx - leftx + 8, boty - topy + 8);
				}

				// if we are hovering on something, render a square
				if (MousePos.X >= 0 && MousePos.Y >= 0) 
					DrawRect(8f, MousePos.X & 0xFFF8, MousePos.Y & 0xFFF8, 8, 8, 1);
			}
		}

		private void DrawRect(float color, int x, int y, int w, int h, int outset = 0) {
			int left = x - outset, right = x + w + outset - 1;
			int top = y - outset, bot = y + h + outset - 1;

			DrawLine(color, left, top, right, top);
			DrawLine(color, left, bot, right, bot);
			DrawLine(color, left, top, left, bot);
			DrawLine(color, right, top, right, bot);
			GL.BindTexture(TextureTarget.Texture2D, 0);
		}

		private void DrawLine(float color, int xs, int ys, int xe, int ye) {
			GL.Uniform1(TextureLoc, 0);
			GL.ActiveTexture(TextureUnit.Texture0);
			GL.BindTexture(TextureTarget.Texture2D, Pixel);
			GL.Uniform1(PalLineLoc, color);

			GL.Begin(PrimitiveType.Quads);
			GL.TexCoord2(0, 0); GL.Vertex2(xs, ys);
			GL.TexCoord2(0, 1); GL.Vertex2(xs, ye + 1);
			GL.TexCoord2(1, 1); GL.Vertex2(xe + 1, ye + 1);
			GL.TexCoord2(1, 0); GL.Vertex2(xe + 1, ys);
			GL.End();
		}
	}
}
