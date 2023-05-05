using System;
using System.Windows.Forms;
using OpenTK;
using OpenTK.Graphics.OpenGL;
using System.ComponentModel;
using System.Drawing;

namespace StateExplorer {
	[ToolboxItem(true)]
	public class GameView : GLControl {
		private bool update = false;
		private float zoom = 1.0f, xpos = 0, ypos = 0;
		private Point? MousePos = null;

		protected override void OnLoad(EventArgs e) {
			base.OnLoad(e);
			update = true;      // safe to update shit or something idk
			OnResize(EventArgs.Empty);  // force run once more
		}

		protected override void OnMouseWheel(MouseEventArgs e) {
			base.OnMouseWheel(e);
			float delta = e.Delta * (0.001f * zoom);

			// get real pixel offset of cursor
			Point p = PointToClient(Cursor.Position);
			p.X = (int)((p.X - (ClientRectangle.Width / 2) + xpos) / zoom);
			p.Y = (int)((p.Y - (ClientRectangle.Height / 2) + ypos) / zoom);

			if (Math.Abs(p.X) > 256) p.X = 256 * (p.X > 0 ? 1 : -1);
			if (Math.Abs(p.Y) > 256) p.Y = 256 * (p.Y > 0 ? 1 : -1);

			zoom += delta;
			if (zoom < 0.01f) {
				delta -= zoom - 0.01f;
				zoom = 0.01f;

			} else if (zoom > 16f) {
				delta -= zoom - 16f;
				zoom = 16f;
			}

			xpos += p.X * (delta);
			ypos += p.Y * (delta);

			OnResize(EventArgs.Empty);  // force run once more
			Invalidate();
		}

		protected override void OnMouseDown(MouseEventArgs e) {
			base.OnMouseDown(e);

			if (e.Button == MouseButtons.Left)
				MousePos = new Point(e.X, e.Y);
		}

		protected override void OnMouseUp(MouseEventArgs e) {
			base.OnMouseUp(e);

			if (e.Button == MouseButtons.Left)
				MousePos = null;
		}

		protected override void OnMouseMove(MouseEventArgs e) {
			base.OnMouseMove(e);

			if (MousePos != null) {
				FixPos(MousePos.Value.X - e.X, MousePos.Value.Y - e.Y);
				MousePos = new Point(e.X, e.Y);

				OnResize(EventArgs.Empty);  // force run once more
				Invalidate();
			}
		}

		protected override void OnKeyUp(System.Windows.Forms.KeyEventArgs e) {
			base.OnKeyUp(e);

			switch (e.KeyCode) {
				case Keys.D1:
					if (--itemid < -1) itemid = -1;
					else Invalidate();
					break;

				case Keys.D2:
					++itemid;
					Invalidate();
					break;
			}
		}

		private void FixPos(int x, int y) {
			xpos += x;
			ypos += y;

			Point p = GetBounds();
			if (Math.Abs(xpos) > p.X) xpos = p.X * (xpos > 0 ? 1 : -1);
			if (Math.Abs(ypos) > p.Y) ypos = p.Y * (ypos > 0 ? 1 : -1);
		}

		private Point GetBounds() {
			Point p = new Point();
			double quad = (256 * zoom);

			if (ClientRectangle.Width / 2 > quad)
				p.X = 0;

			else p.X = (int)(quad - ClientRectangle.Width / 2);

			if (ClientRectangle.Height / 2 > quad)
				p.Y = 0;

			else p.Y = (int)(quad - ClientRectangle.Height / 2);

			return p;
		}

		protected override void OnResize(EventArgs e) {
			base.OnResize(e);

			if (update) {
				FixPos(0, 0);
				GL.MatrixMode(MatrixMode.Projection);
				GL.LoadIdentity();

				GL.Viewport((int)((ClientRectangle.Width - (512 * zoom)) / 2 - xpos), (int)((ClientRectangle.Height - (512 * zoom)) / 2 + ypos), (int)(512 * zoom), (int)(512 * zoom));
				GL.MatrixMode(MatrixMode.Modelview);
				GL.LoadIdentity();

				GL.Ortho(0, 512, 512, 0, 1, -1);
			}
		}

		protected override void OnPaint(PaintEventArgs e) {
			base.OnPaint(e);

			if (update && VDP.ready) {
				GL.Clear(ClearBufferMask.ColorBufferBit | ClearBufferMask.DepthBufferBit);
				GL.BlendFunc(BlendingFactor.SrcAlpha, BlendingFactor.OneMinusSrcAlpha);

				SetupPaletteShader(VDP.Palette);

				// render backdrop
				GL.BindTexture(TextureTarget.Texture2D, VDP.Backdrop);
				GL.Begin(PrimitiveType.Quads);
				GL.TexCoord2(0f, 0f); GL.Vertex2(0, 0);
				GL.TexCoord2(0f, 1f); GL.Vertex2(0, 512);
				GL.TexCoord2(1f, 1f); GL.Vertex2(512, 512);
				GL.TexCoord2(1f, 0f); GL.Vertex2(512, 0);
				GL.End();

				// render all planes
				GL.Enable(EnableCap.Blend);
				DrawPlane(false, 1);
				DrawPlane(false, 0);
				DrawSprites(false);
				DrawPlane(true, 1);
				DrawPlane(true, 0);
				DrawSprites(true);
				
				DisableShaders();

				// render left side mask if needed
				if ((VDP.REG[0] & 0x20) != 0) {
					GL.Begin(PrimitiveType.Quads);
					GL.Color3(Color.FromArgb(VDP.backdrop));
					GL.Vertex2(0, 0);
					GL.Vertex2(0, 512);
					GL.Vertex2(8, 512);
					GL.Vertex2(8, 0);
					GL.End();
				}

				// TEMP CODE
				DrawHighlightedSprite(itemid);

				GL.Disable(EnableCap.Blend);
				SwapBuffers();
			}
		}

		private void DisableShaders() {
			GL.UseProgram(0);
			GL.Disable(EnableCap.Texture2D);
		}

		private int itemid = -1;

		private void SetupPaletteShader(int palette) {
			// enable usage of the palettized shader
			GL.Enable(EnableCap.Texture2D);
			GL.UseProgram(MainWindow.shaderProg);

			// Set palette texture as active and bind it
			int loc = GL.GetUniformLocation(MainWindow.shaderProg, "palette");
			GL.Uniform1(loc, 1);
			GL.ActiveTexture(TextureUnit.Texture1);
			GL.BindTexture(TextureTarget.Texture2D, palette);

			// Set texture as active and bind it
			loc = GL.GetUniformLocation(MainWindow.shaderProg, "texture");
			GL.Uniform1(loc, 0);
			GL.ActiveTexture(TextureUnit.Texture0);
			GL.Color3(1f, 1f, 1f);
		}

		private int[] PlaneSizesAnd = { 0xF8, 0x1F8, 0, 0x3F8 };

		private void DrawPlane(bool hi, int plane) {
			// prepare variables used for calculations
			int planeloc = plane == 0 ? (VDP.REG[2] & 0x7C) * 0x400 : plane == 1 ? (VDP.REG[4] & 0xF) * 0x2000 : (VDP.REG[3] & 0x7E) * 0x400;

			// get plane size and values
			int xa = PlaneSizesAnd[VDP.REG[0x10] & 3], ya = PlaneSizesAnd[(VDP.REG[0x10] >> 4) & 3];

			if((VDP.REG[0x10] & 0x33) == 0x33)
				ya = xa = 0;

			if((VDP.REG[0xB] & 3) == 0) {
				// run this routine when the screen is scrolled by a single value

				int py = VDP.VSRAM[plane & 1];
				int px = GetScroll(0, (plane & 1) << 1);

				for (int y = 0;y < 512;y += 8)
					for (int x = 0;x < 512;x += 8) {
						ushort t = VDP.Word(planeloc + ((x & xa) / 4) + ((y & ya) * 16));

						if ((t & 0x8000) != 0 == hi) {
							// calculate the scroll position

							// render the tile
							RenderTile(t & 0x7FF, (t & 0x6000) / 0x2000, (t & 0x800) != 0, (t & 0x1000) != 0, px + x, y - py);
						}
					}

			} else {
				// run this routine when the screen is scrolled by multiple values
				int[] hscrldata = new int[8];

				for (int y = 0;y < 224 + 8;y += 8) {
					// calculate the scroll position
					int py = VDP.VSRAM[plane & 1];
					bool full = true;

					// check if we can render this as a full tile
					for (int i = 0;i < 8;i++) {
						hscrldata[i] = GetScroll(y + i - (py & 7), (plane & 1) << 1);

						if ((hscrldata[i] & xa) != (hscrldata[0] & xa))
							full = false;
					}

					for (int x = -8;x < 320;x += 8) {
						if (full) {
							// render the full tile at once
							ushort t = VDP.Word(planeloc + (((x - hscrldata[0]) & xa) / 4) + (((y + py) & ya) * 16));

							if ((t & 0x8000) != 0 == hi)
								RenderTile(t & 0x7FF, (t & 0x6000) / 0x2000, (t & 0x800) != 0, (t & 0x1000) != 0, x + (hscrldata[0] & 7), y - (py & 7));

						} else {
							// render as 8-pixel strips
							for (int i = 0;i < 8;i++) {
								ushort t = VDP.Word(planeloc + (((x - hscrldata[i]) & xa) / 4) + (((y + py) & ya) * 16));

								if ((t & 0x8000) != 0 == hi)
									RenderRow(t & 0x7FF, (t & 0x6000) / 0x2000, (t & 0x800) != 0, (t & 0x1000) != 0, x + (hscrldata[i] & 7), y - (py & 7), i);

							}
						}
					}
				}
			}
		}

		private int GetScroll(int y, int off) {
			int scrloc = ((VDP.REG[0xD] & 0x7F) * 0x400) + off;
			int pos = 0;

			// make sure y-position is restricted correcvtly
			if (y < 0) y = 0;
			else if (y >= 223) y = 0;

			// get the proper position to check from
			switch (VDP.REG[0xB] & 3) {
				case 2:
					pos = (y & 0x1F8) << 2;
					break;

				case 3:
					pos = y << 2;
					break;

				default:
					pos = 0;
					break;
			}
			
			return VDP.Word(scrloc + pos);
		}

		private void DrawSprites(bool hi) {
			int sprloc = (VDP.REG[5] & 0x7F) * 0x200, spr = sprloc;

			while (spr < sprloc + 0x280) {
				if ((VDP.VRAM[spr + 4] & 0x80) != 0 == hi) {

					// render sprite
					RenderSprite(VDP.Word(spr) & 0x1FF, VDP.Word(spr + 6) & 0x1FF, VDP.Word(spr + 4), VDP.VRAM[spr + 2]);
				}

				// go to next sprite
				spr = (VDP.VRAM[spr + 3] * 8) + sprloc;
				if (spr <= sprloc) break;
			}
		}

		private void DrawHighlightedSprite(int num) {
			if (num < 0) return;

			int sprloc = (VDP.REG[5] & 0x7F) * 0x200, spr = sprloc;

			while (spr < sprloc + 0x280) {
				if (num-- == 0) {

					// render sprite but highlighted
					SetupPaletteShader(VDP.PaletteHiLite);
					RenderSprite(VDP.Word(spr) & 0x1FF, VDP.Word(spr + 6) & 0x1FF, VDP.Word(spr + 4), VDP.VRAM[spr + 2]);
					DisableShaders();
					return;
				}

				// go to next sprite
				spr = (VDP.VRAM[spr + 3] * 8) + sprloc;
				if (spr <= sprloc) break;
			}
		}

		private void RenderSprite(int y, int x, int t, byte s) {
			// prepare some variables
			bool xx = (t & 0x800) != 0, yy = (t & 0x1000) != 0;
			int id = (t & 0x6000) / 0x2000;
			t &= 0x7FF;

			int hs = (s & 0xC) / 4, vs = s & 3, vs2 = vs + 1;

			for (int ty = 0;ty < vs2;ty++)
				for (int tx = 0;tx < hs + 1;tx++)
					RenderTile((t + (yy ? vs - ty : ty) + ((xx ? hs - tx : tx) * vs2)) & 0x7FF, id, xx, yy, x + (tx * 8) - 0x80, y + (ty * 8) - 0x80);
		}

		private void RenderTile(int tile, int palette, bool xflip, bool yflip, int x, int y) {
			// calculate positions for each coordinate
			int x8 = (x + 8) & 0x1FF, y8 = (y + 8) & 0x1FF;
			x &= 0x1FF;
			y &= 0x1FF;

			int xx = xflip ? 1 : 0, yy = yflip ? 1 : 0;

			// render 1 tile at a time
			GL.BindTexture(TextureTarget.Texture2D, VDP.TileTex[tile].id[palette]);

			if (y > y8) {
				if (x > x8) {
					// special case, need to render 4 images

					// render the copy at xp yp
					GL.Begin(PrimitiveType.Quads);
					GL.TexCoord2(xx, yy); GL.Vertex2(x, y);
					GL.TexCoord2(xx, yy ^ 1); GL.Vertex2(x, y + 8);
					GL.TexCoord2(xx ^ 1, yy ^ 1); GL.Vertex2(x + 8, y + 8);
					GL.TexCoord2(xx ^ 1, yy); GL.Vertex2(x + 8, y);
					GL.End();

					// render the copy at xp8 yp
					GL.Begin(PrimitiveType.Quads);
					GL.TexCoord2(xx, yy); GL.Vertex2(x8 - 8, y);
					GL.TexCoord2(xx, yy ^ 1); GL.Vertex2(x8 - 8, y + 8);
					GL.TexCoord2(xx ^ 1, yy ^ 1); GL.Vertex2(x8, y + 8);
					GL.TexCoord2(xx ^ 1, yy); GL.Vertex2(x8, y);
					GL.End();

					// render the copy at xp yp8
					GL.Begin(PrimitiveType.Quads);
					GL.TexCoord2(xx, yy); GL.Vertex2(x, y8 - 8);
					GL.TexCoord2(xx, yy ^ 1); GL.Vertex2(x, y8);
					GL.TexCoord2(xx ^ 1, yy ^ 1); GL.Vertex2(x + 8, y8);
					GL.TexCoord2(xx ^ 1, yy); GL.Vertex2(x + 8, y8 - 8);
					GL.End();

					// render the copy at xp8 yp8
					GL.Begin(PrimitiveType.Quads);
					GL.TexCoord2(xx, yy); GL.Vertex2(x8 - 8, y8 - 8);
					GL.TexCoord2(xx, yy ^ 1); GL.Vertex2(x8 - 8, y8);
					GL.TexCoord2(xx ^ 1, yy ^ 1); GL.Vertex2(x8, y8);
					GL.TexCoord2(xx ^ 1, yy); GL.Vertex2(x8, y8 - 8);
					GL.End();

				} else {
					// special case, need to render 2 images

					// render the copy at yp
					GL.Begin(PrimitiveType.Quads);
					GL.TexCoord2(xx, yy); GL.Vertex2(x, y);
					GL.TexCoord2(xx, yy ^ 1); GL.Vertex2(x, y + 8);
					GL.TexCoord2(xx ^ 1, yy ^ 1); GL.Vertex2(x + 8, y + 8);
					GL.TexCoord2(xx ^ 1, yy); GL.Vertex2(x + 8, y);
					GL.End();

					// render the copy at yp8
					GL.Begin(PrimitiveType.Quads);
					GL.TexCoord2(xx, yy); GL.Vertex2(x, y8 - 8);
					GL.TexCoord2(xx, yy ^ 1); GL.Vertex2(x, y8);
					GL.TexCoord2(xx ^ 1, yy ^ 1); GL.Vertex2(x + 8, y8);
					GL.TexCoord2(xx ^ 1, yy); GL.Vertex2(x + 8, y8 - 8);
					GL.End();
				}

			} else if (x > x8) {
				// special case, need to render 2 images

				// render the copy at xp
				GL.Begin(PrimitiveType.Quads);
				GL.TexCoord2(xx, yy); GL.Vertex2(x, y);
				GL.TexCoord2(xx, yy ^ 1); GL.Vertex2(x, y8);
				GL.TexCoord2(xx ^ 1, yy ^ 1); GL.Vertex2(x + 8, y8);
				GL.TexCoord2(xx ^ 1, yy); GL.Vertex2(x + 8, y);
				GL.End();

				// render the copy at xp8
				GL.Begin(PrimitiveType.Quads);
				GL.TexCoord2(xx, yy); GL.Vertex2(x8 - 8, y);
				GL.TexCoord2(xx, yy ^ 1); GL.Vertex2(x8 - 8, y8);
				GL.TexCoord2(xx ^ 1, yy ^ 1); GL.Vertex2(x8, y8);
				GL.TexCoord2(xx ^ 1, yy); GL.Vertex2(x8, y);
				GL.End();

			} else {
				GL.Begin(PrimitiveType.Quads);
				GL.TexCoord2(xx, yy); GL.Vertex2(x, y);
				GL.TexCoord2(xx, yy ^ 1); GL.Vertex2(x, y8);
				GL.TexCoord2(xx ^ 1, yy ^ 1); GL.Vertex2(x8, y8);
				GL.TexCoord2(xx ^ 1, yy); GL.Vertex2(x8, y);
				GL.End();
			}
		}

		private void RenderRow(int tile, int palette, bool xflip, bool yflip, int x, int y, int r) {
			// calculate positions for each coordinate
			int x8 = (x + 8) & 0x1FF;
			x &= 0x1FF;
			y &= 0x1FF;

			int xx = xflip ? 1 : 0, yy = yflip ? 1 : 0;

			// render 1 tile at a time
			GL.BindTexture(TextureTarget.Texture2D, VDP.TileTex[tile].id[palette]);

			if (x > x8) {
				// special case, need to render 2 images

				// render the copy at xp
				GL.Begin(PrimitiveType.Quads);
				GL.TexCoord2(xx, yy / 8.0 + (r / 8.0)); GL.Vertex2(x, y + r);
				GL.TexCoord2(xx, (yy ^ 1) / 8.0 + (r / 8.0)); GL.Vertex2(x, y + r + 1);
				GL.TexCoord2(xx ^ 1, (yy ^ 1) / 8.0 + (r / 8.0)); GL.Vertex2(x + 8, y + r + 1);
				GL.TexCoord2(xx ^ 1, yy / 8.0 + (r / 8.0)); GL.Vertex2(x + 8, y + r);
				GL.End();

				// render the copy at xp8
				GL.Begin(PrimitiveType.Quads);
				GL.TexCoord2(xx, yy / 8.0 + (r / 8.0)); GL.Vertex2(x8 - 8, y + r);
				GL.TexCoord2(xx, (yy ^ 1) / 8.0 + (r / 8.0)); GL.Vertex2(x8 - 8, y + r + 1);
				GL.TexCoord2(xx ^ 1, (yy ^ 1) / 8.0 + (r / 8.0)); GL.Vertex2(x8, y + r + 1);
				GL.TexCoord2(xx ^ 1, yy / 8.0 + (r / 8.0)); GL.Vertex2(x8, y + r);
				GL.End();

			} else {
				GL.Begin(PrimitiveType.Quads);
				GL.TexCoord2(xx, yy / 8.0 + (r / 8.0)); GL.Vertex2(x, y + r);
				GL.TexCoord2(xx, (yy ^ 1) / 8.0 + (r / 8.0)); GL.Vertex2(x, y + r + 1);
				GL.TexCoord2(xx ^ 1, (yy ^ 1) / 8.0 + (r / 8.0)); GL.Vertex2(x8, y + r + 1);
				GL.TexCoord2(xx ^ 1, yy / 8.0 + (r / 8.0)); GL.Vertex2(x8, y + r);
				GL.End();
			}
		}
	}
}