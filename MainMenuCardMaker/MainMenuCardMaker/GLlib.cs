using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OpenTK;
using OpenTK.Graphics.OpenGL;
using System.Drawing.Imaging;
using System.Drawing;
using OpenTK.Graphics;
using System.Runtime.InteropServices;
using System.IO;

namespace MainMenuCardMaker {
	public static class GLlib {
		public static void CreateShaderProgram(string vertex, string fragment, out int program, out int vaddress, out int faddress) {
			program = GL.CreateProgram();

			// create vertex shader and check for errors
			vaddress = LoadShader(vertex, ShaderType.VertexShader, program, out string error);
			if (error != null && error.Trim().Length > 0)
				throw new GraphicsException("Vertex shader compilation failed: " + error);

			// create fragment shader and check for errors
			faddress = LoadShader(fragment, ShaderType.FragmentShader, program, out error);
			if (error != null && error.Trim().Length > 0)
				throw new GraphicsException("Fragment shader compilation failed: " + error);

			// link the program
			GL.LinkProgram(program);
			GL.GetProgram(program, GetProgramParameterName.LinkStatus, out int linked);

			if(linked == 0) {
				GL.DeleteProgram(program);
				GL.DeleteShader(vaddress);
				GL.DeleteShader(faddress);

				throw new GraphicsException("Linking failed: " + GL.GetProgramInfoLog(linked));
			}

			GL.DetachShader(program, vaddress);
			GL.DetachShader(program, faddress);
		}

		public static int LoadShader(string code, ShaderType type, int program, out string error) {
			int address = GL.CreateShader(type);
			GL.ShaderSource(address, code);
			GL.CompileShader(address);
			GL.AttachShader(program, address);
			GL.GetShader(address, ShaderParameter.CompileStatus, out int status);

			if (status == 0) {
				error = GL.GetShaderInfoLog(address);
				GL.DeleteShader(address);
			} else error = null;
			return address;
		}

		public static int LoadTexture(string file, PixelInternalFormat intformat = PixelInternalFormat.Rgba, OpenTK.Graphics.OpenGL.PixelFormat pxformat = OpenTK.Graphics.OpenGL.PixelFormat.Bgra) {
			int img = -1;

			using (Bitmap bmp = new Bitmap(file)) {
				BitmapData bData = bmp.LockBits(new Rectangle(0, 0, bmp.Width, bmp.Height), ImageLockMode.ReadOnly, System.Drawing.Imaging.PixelFormat.Format32bppArgb);
				img = LoadTexture(bData.Scan0, bData.Width, bData.Height, intformat, pxformat);
				bmp.UnlockBits(bData);
			}

			return img;
		}

		public static int LoadTexture<T>(T data, int width, int height, PixelInternalFormat intformat = PixelInternalFormat.Rgba, OpenTK.Graphics.OpenGL.PixelFormat pxformat = OpenTK.Graphics.OpenGL.PixelFormat.Bgra) {
			int img = -1;

			// create an IntPtr for texture data
			using (AutoPinner ap = new AutoPinner(data)) {
				img = LoadTexture((IntPtr)ap, width, height, intformat, pxformat);
			}

			return img;
		}

		public static int LoadTexture(IntPtr data, int width, int height, PixelInternalFormat intformat = PixelInternalFormat.Rgba, OpenTK.Graphics.OpenGL.PixelFormat pxformat = OpenTK.Graphics.OpenGL.PixelFormat.Bgra) {
			int img = GL.GenTexture();
			if (img == 0) throw new Exception(GL.GetError().ToString());

			// Apply bitmap data to texture
			GL.BindTexture(TextureTarget.Texture2D, img);
			GL.TexImage2D(TextureTarget.Texture2D, 0, intformat, width, height, 0, pxformat, PixelType.UnsignedByte, data);

			GL.TexParameter(TextureTarget.Texture2D, TextureParameterName.TextureWrapS, (int)TextureWrapMode.Clamp);// Wrap S
			GL.TexParameter(TextureTarget.Texture2D, TextureParameterName.TextureWrapT, (int)TextureWrapMode.Clamp);// Wrap T
			GL.TexParameter(TextureTarget.Texture2D, TextureParameterName.TextureMinFilter, (int)TextureMinFilter.Nearest);// Min filter
			GL.TexParameter(TextureTarget.Texture2D, TextureParameterName.TextureMagFilter, (int)TextureMagFilter.Nearest);// Mag filter

			GL.BindTexture(TextureTarget.Texture2D, 0);
			return img;
		}

		public static void DrawTexture(int tex, int x, int y, int w, int h) {
			GL.BindTexture(TextureTarget.Texture2D, tex);
			GL.Begin(PrimitiveType.Quads);
			GL.TexCoord2(0f, 0f); GL.Vertex2(x, y);
			GL.TexCoord2(0f, 1f); GL.Vertex2(x, y + h);
			GL.TexCoord2(1f, 1f); GL.Vertex2(x + w, y + h);
			GL.TexCoord2(1f, 0f); GL.Vertex2(x + w, y);
			GL.End();
			GL.BindTexture(TextureTarget.Texture2D, 0);
		}

		public static void DrawRectangle(Color col, Rectangle bounds, int outset = 0) {
			DrawRectangle(col, bounds.X, bounds.Y, bounds.Width, bounds.Height, outset);
		}

		public static void DrawRectangle(Color col, int x, int y, int w, int h, int outset = 0) {
			GL.Begin(PrimitiveType.LineLoop);
			GL.Color3(col);
			GL.Vertex2(x - outset, y - outset);
			GL.Vertex2(x - outset, y + h + outset);
			GL.Vertex2(x + w + outset, y + h + outset);
			GL.Vertex2(x + w + outset, y - outset);
			GL.End();
		}

		public static void DrawRectangleFilled(Color col, Rectangle bounds, int padding = 0) {
			DrawRectangleFilled(col, bounds.X, bounds.Y, bounds.Width, bounds.Height, padding);
		}

		public static void DrawRectangleFilled(Color col, int x, int y, int w, int h, int padding = 0) {
			GL.Begin(PrimitiveType.Quads);
			GL.Color3(col);
			GL.Vertex2(x - padding, y - padding);
			GL.Vertex2(x - padding, y + h + padding);
			GL.Vertex2(x + w + padding, y + h + padding);
			GL.Vertex2(x + w + padding, y - padding);
			GL.End();
		}

		public static void DrawLine(Color col, int xs, int ys, int xe, int ye) {
			GL.Begin(PrimitiveType.Lines);
			GL.Color3(col);
			GL.Vertex2(xs, ys);
			GL.Vertex2(xe, ye);
			GL.End();
		}
	}

	public class AutoPinner : IDisposable {
		GCHandle _pinnedArray;

		public AutoPinner(Object obj) {
			_pinnedArray = GCHandle.Alloc(obj, GCHandleType.Pinned);
		}

		public static implicit operator IntPtr(AutoPinner ap) {
			return ap._pinnedArray.AddrOfPinnedObject();
		}

		public void Dispose() {
			_pinnedArray.Free();
		}
	}
}
