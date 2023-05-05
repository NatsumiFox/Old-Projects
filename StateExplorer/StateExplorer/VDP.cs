using OpenTK.Graphics.OpenGL;
using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;

namespace StateExplorer {
	public class VDP {
		public static ushort[] CRAM;
		public static ushort[] VSRAM;
		public static byte[] VRAM;
		public static byte[] REG;
		
		public static int[] ColorLevels = new int[] { 0, 52, 87, 116, 144, 172, 206, 255, };
		public static int Palette, PaletteHiLite, Backdrop;
		public static PaletteTexture[] TileTex;
		public static bool ready = false;
		public static int backdrop;

		public static void Create(Stream s) {
			ready = false;
			s.Seek(0xFA, SeekOrigin.Begin);

			REG = new byte[0x18];
			VRAM = new byte[0x10000];
			CRAM = new ushort[0x40];
			VSRAM = new ushort[0x28];

			// read REG
			for (int i = 0;i < REG.Length;i++)
				REG[i] = (byte)s.ReadByte();

			// read CRAM (that's right, the bytes are in the wrong order... Sigh...)
			for (int i = 0;i < CRAM.Length;i++)
				CRAM[i] = (ushort)(s.ReadByte() | (s.ReadByte() << 8));

			// read VSRAM
			for (int i = 0;i < VSRAM.Length;i++)
				VSRAM[i] = (ushort)((s.ReadByte() << 8) | s.ReadByte());

			s.Seek(0x12478, SeekOrigin.Begin);

			// read VRAM
			for (int i = 0;i < VRAM.Length;i++) {
				VRAM[i] = (byte)s.ReadByte();
			}

			if (s.Position < 0x22478)
				throw new Exception("The file was not the correct length!");
			
			// create palette texture
			int[] data = new int[64];

			for (int i = 0;i < 64;i++)
				data[i] = GetCRAM(i);

			Palette = CreateTexture(16, 4, data);

			// create highlighted palette texture

			for (int i = 0;i < 64;i++) 
				data[i] = (data[i] & -16777216) | Math.Min(0xFF, 0x40 + (data[i] & 0xFF)) | Math.Min(0xFF00, 0x4000 + (data[i] & 0xFF00)) | Math.Min(0xFF0000, 0x400000 + (data[i] & 0xFF0000));

			PaletteHiLite = CreateTexture(16, 4, data);
			TileTex = new PaletteTexture[VRAM.Length / 32];

			// create backdrop texture
			data = new int[] { (REG[7] & 7) | (REG[7] & 0x30) << 4  };
			Backdrop = CreateTexture(1, 1, data);

			for (int i = 0;i < TileTex.Length;i++) {
				TileTex[i] = CreateTileTexture(i * 32);
			}

			ready = true;
		}

		public static ushort Word(int i) {
			return (ushort)(VRAM[i + 1] | (VRAM[i] << 8));
		}

		private static int GetCRAM(int i) {
			return (ColorLevels[(CRAM[i] >> 9) & 7]) << 16 | (ColorLevels[(CRAM[i] >> 5) & 7]) << 8 | (ColorLevels[(CRAM[i] / 2) & 7]) | ((i & 15) == 0 ? 0 : -16777216);
		}
		
		private static int CreateTexture(int w, int h, int[] data) {
			int id = GL.GenTexture();
			GL.BindTexture(TextureTarget.Texture2D, id);

			// Apply bitmap data to texture
			GL.TexImage2D(TextureTarget.Texture2D, 0, PixelInternalFormat.Rgba, w, h, 0, OpenTK.Graphics.OpenGL.PixelFormat.Rgba, PixelType.UnsignedByte, data);

			GL.TexParameter(TextureTarget.Texture2D, TextureParameterName.TextureWrapS, (int)TextureWrapMode.Clamp);// Wrap S
			GL.TexParameter(TextureTarget.Texture2D, TextureParameterName.TextureWrapT, (int)TextureWrapMode.Clamp);// Wrap T
			GL.TexParameter(TextureTarget.Texture2D, TextureParameterName.TextureMinFilter, (int)TextureMinFilter.Nearest);// Min filter
			GL.TexParameter(TextureTarget.Texture2D, TextureParameterName.TextureMagFilter, (int)TextureMagFilter.Nearest);// Mag filter

			return id;
		}

		private static PaletteTexture CreateTileTexture(int pvr) {
			PaletteTexture pt = new PaletteTexture() {
				id = new int[4],
			};

			// create base texture
			int[] data = new int[64];

			for (int i = 0;i < 32;i++) {
				data[i * 2] = (VRAM[pvr + i] & 0xF0) >> 4 * 16;
				data[(i * 2) + 1] = (VRAM[pvr + i] & 0xF) * 16;
			}

			// Apply bitmap data to texture

			for (int i = 0;i < 4;i++) {
				pt.id[i] = GL.GenTexture();
				GL.BindTexture(TextureTarget.Texture2D, pt.id[i]);
				GL.TexImage2D(TextureTarget.Texture2D, 0, PixelInternalFormat.Rgba, 8, 8, 0, OpenTK.Graphics.OpenGL.PixelFormat.Rgba, PixelType.UnsignedByte, data);

				GL.TexParameter(TextureTarget.Texture2D, TextureParameterName.TextureWrapS, (int)TextureWrapMode.Clamp);// Wrap S
				GL.TexParameter(TextureTarget.Texture2D, TextureParameterName.TextureWrapT, (int)TextureWrapMode.Clamp);// Wrap T
				GL.TexParameter(TextureTarget.Texture2D, TextureParameterName.TextureMinFilter, (int)TextureMinFilter.Nearest);// Min filter
				GL.TexParameter(TextureTarget.Texture2D, TextureParameterName.TextureMagFilter, (int)TextureMagFilter.Nearest);// Mag filter

				for (int x = 0;x < 64;x++)
					data[x] += 0x4000;
			}
			
			return pt;
		}
	}

	public struct PaletteTexture {
		public int[] id;
	}
}