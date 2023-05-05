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
using System.IO;

namespace MainMenuCardMaker.Controls {
	public partial class ImportImagesControl : BaseGlControl {
		public ImportImagesControl() {
			InitializeComponent();
			SetStyle(ControlStyles.StandardDoubleClick, false);
		}

		protected override void OnLoad(EventArgs e) {
			base.OnLoad(e);

			if (!DesignMode)
				lock (busy) {
					MakeCurrent();
					CreateShaderProgram(Properties.Resources.PixelVertexShader, Properties.Resources.PixelFragmentShader, out ShaderProg, out VertexAddr, out FragmentAddr);
					PaletteLoc = GL.GetUniformLocation(ShaderProg, "palette");
					TextureLoc = GL.GetUniformLocation(ShaderProg, "texture");
				}
		}

		protected override void OnControlRemoved(ControlEventArgs e) {
			base.OnControlRemoved(e);
			if(ShaderProg != 0 && !DesignMode) GL.DeleteProgram(ShaderProg);
		}

		private int ShaderProg = 0, VertexAddr = 0, FragmentAddr = 0;
		private int PaletteLoc = 0, TextureLoc = 0;

		private Point MousePos = new Point(-1, -1);

		protected override void OnMouseMove(MouseEventArgs e) {
			base.OnMouseMove(e);
			MousePos = e.Location;
			MousePos.X = (int)((MousePos.X - (ClientRectangle.Width / 2) + XPosition) / ZoomLevel) + (ActualWidth / 2);
			MousePos.Y = (int)((MousePos.Y - (ClientRectangle.Height / 2) + YPosition) / ZoomLevel) + (ActualHeight / 2);
			HighLight = new Point(-1, -1);

			if (MousePos.X < 0 || MousePos.X >= ActualWidth || MousePos.Y < 0 || MousePos.Y >= ActualWidth) {
				MousePos.X = -1;
				MousePos.Y = -1;

			} else if(MousePos.X >= 512) {
				int indx = (MousePos.Y / 16) + ((MousePos.X - 512) / 16 * (512 / 16));
				if (Converter.Import.PriorityTiles.Count > indx)
					HighLight = new Point((Converter.Import.PriorityTiles[indx] % 64) * 8, Converter.Import.PriorityTiles[indx] / 64 * 8);
			}

			if (Converter.Import != null)
				Invalidate();
		}

		protected override void OnMouseClick(MouseEventArgs e) {
			base.OnMouseClick(e);

			if (Converter.Import != null && MousePos.X >= 0) {
				if (MousePos.X < 512) {
					int ix = (MousePos.X / 8) + (MousePos.Y / 8 * 64);

					if (Converter.Import.PriorityTiles.Contains(ix)) {
						if (e.Button == MouseButtons.Right)
							Converter.Import.PriorityTiles.Remove(ix);

					} else if (e.Button == MouseButtons.Right) Converter.Import.PriorityTiles.Add(ix);
					else if (e.Button == MouseButtons.Middle) Converter.Import.PriorityTiles.Insert(0, ix);

				} else if (e.Button == MouseButtons.Right) {
					int indx = (MousePos.Y / 16) + ((MousePos.X - 512) / 16 * 32);

					if (Converter.Import.PriorityTiles.Count > indx)
						Converter.Import.PriorityTiles.RemoveAt(indx);
				}

				Invalidate();
			}
		}

		public Point HighLight = new Point(-1, -1);

		protected override void Draw() {
			if (Converter.Import != null && Converter.Import.Texture != 0) {
				GL.Enable(EnableCap.Texture2D);
				GL.UseProgram(ShaderProg);
				// Set palette texture as active and bind it
				GL.Uniform1(PaletteLoc, 1);
				GL.ActiveTexture(TextureUnit.Texture1);
				GL.BindTexture(TextureTarget.Texture2D, Converter.Import.Palette);

				// Set texture as active and bind it
				GL.Uniform1(TextureLoc, 0);
				GL.ActiveTexture(TextureUnit.Texture0);
				GL.Color3(1f, 1f, 1f);

				// render image
				DrawTexture(Converter.Import.Texture, 0, 0, 512, 512);

				// render highlighted tiles
				int idx = 0;

				for(int x = 512;x < 576;x += 16)
					for(int y = 0;y < 512;y += 16) {
						if (Converter.Import.PriorityTiles.Count <= idx) break;

						int xc = Converter.Import.PriorityTiles[idx] % 64, yc = Converter.Import.PriorityTiles[idx++] / 64;
						float xcf = 1f / 64f * xc, ycf = 1f / 64f * yc;

						// draw a priority tile
						GL.BindTexture(TextureTarget.Texture2D, Converter.Import.Texture);
						GL.Begin(PrimitiveType.Quads);
						GL.TexCoord2(xcf, ycf); GL.Vertex2(x, y);
						GL.TexCoord2(xcf, ycf + (1f / 64f)); GL.Vertex2(x, y + 16);
						GL.TexCoord2(xcf + (1f / 64f), ycf + (1f / 64f)); GL.Vertex2(x + 16, y + 16);
						GL.TexCoord2(xcf + (1f / 64f), ycf); GL.Vertex2(x + 16, y);
						GL.End();
						GL.BindTexture(TextureTarget.Texture2D, 0);
					}

				GL.Disable(EnableCap.Texture2D);
				GL.UseProgram(0);

				// draw a separating line
				DrawLine(Color.Red, 512, 0, 512, 512);

				// if highlighting something, draw it
				if (HighLight.X >= 0) DrawRectangle(Color.Green, HighLight.X, HighLight.Y, 8, 8);

				// draw cursor onscreen
				if (MousePos.X >= 0 && MousePos.X < 512) DrawRectangle(Color.Red, MousePos.X & 0xFFF8, MousePos.Y & 0xFFF8, 8, 8);
				else if (MousePos.X >= 512) DrawRectangle(Color.Red, MousePos.X & 0xFFF0, MousePos.Y & 0xFFF0, 16, 16, 0);
			} 
		}
	}
}
