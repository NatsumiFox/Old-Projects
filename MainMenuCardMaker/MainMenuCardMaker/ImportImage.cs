using System;
using OpenTK;
using OpenTK.Graphics.OpenGL;
using System.Collections.Generic;
using System.Linq;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Drawing.Imaging;
using System.IO;
using System.Collections;

namespace MainMenuCardMaker {
	public class ImportImage : IDisposable {
		// size of the imported image
		public int Width, Height;

		// the indexed image data array
		public byte[] ImageData;

		// the table of colours for the imagedata
		public int[] ColorTable;

		// the table of palette entries to use for rendering as opposed to color table (eg, map image colors into palette colors)
		public ColorMD[] MapTable;

		// the OpenGL texture associated with the image of this object
		public int Texture = 0;

		// the OpenGL textures associated with the palette of this object
		public int Palette = 0;

		// info about what areas need to have their tiles appear first
		public List<int> PriorityTiles;

		public void Dispose() {
			if(Texture != 0) GL.DeleteTexture(Texture);
			if (Palette != 0) GL.DeleteTexture(Palette);
		}

		// routine for converting the image into
		public void LoadImage(int[] image, int width, int height) {
			Width = width;
			Height = height;

			PriorityTiles = new List<int>();

			// this is a list of the used colors. first byte is color, second is count
			List<int[]> used = new List<int[]>();

			int lastval = -1, lstidx = -1;

			for(int i = 0;i < image.Length;i++) {
				int val = image[i] & 0xFCFCFC;

				// check if the last value is same (speed up haxx!)
				if(val == lastval) {
					used[lstidx][1] ++;
					continue;
				}

				// check if we can already find this color in the array
				bool found = false;
				for(int x = 0;x < used.Count;x ++)
					if(used[x][0] == val) {
						// found color, increase the usage count
						used[x][1]++;
						found = true;
						lstidx = x;
						break;
					}

				if (!found) {
					// did not find, create a new one
					lstidx = used.Count;
					used.Add(new int[] { val, 1 });
				}
				
				lastval = val;
			}

			// order it so that the first color is the most used
			used = used.OrderByDescending((x) => x[1]).ToList();

			// generate tables to be used
			ColorTable = new int[used.Count];
			MapTable = new ColorMD[ColorTable.Length];
			ImageData = new byte[image.Length];

			// generate color table
			for (int i = 0;i < ColorTable.Length;i++)
				ColorTable[i] = used[i][0];

			// generate image data
			for (int i = 0;i < ImageData.Length;i++)
				for (byte x = 0;x < ColorTable.Length;x++)
					if (ColorTable[x] == (image[i] & 0xFCFCFC))
						ImageData[i] = x;

			// generate OpenGL texture for imagedata
			Texture = GLlib.LoadTexture(ImageData, 512, 512, PixelInternalFormat.R8, OpenTK.Graphics.OpenGL.PixelFormat.Red);

			// generate palette texture
			Palette = GLlib.LoadTexture(PadArray(256, ResolvePalette()), 256, 1);

			if (Form1.DEBUG) {
				PriorityTiles = new List<int>() {
					184, 248, 312, 376,
					185, 249, 313, 377,
					186, 250, 314, 378,
					187, 251, 315, 379,
					188, 252, 316, 380,
					189, 253, 317, 381,
					190, 254, 318, 382,
					191, 255, 319, 383,

					1538, 1539, 1540, 1541,
					1602, 1603, 1604, 1605,
					1666, 1667, 1668, 1669,
					1986, 1987, 1988, 1989,
					1850, 1851, 1852, 1853,
				};
			}
		}

		public void ChangePalette(params int[] MaskArray) {
			int[] pal = ResolvePalette();

			// do color replacement
			for(int i = 0;i < MaskArray.Length; i += 2) 
				pal[MaskArray[i]] = MaskArray[i + 1];

			GL.BindTexture(TextureTarget.Texture2D, Palette);
			GL.TexSubImage2D(TextureTarget.Texture2D, 0, 0, 0, 256, 1, OpenTK.Graphics.OpenGL.PixelFormat.Bgra, PixelType.UnsignedByte, PadArray(256, pal));
		}

		private int[] PadArray(int len, int[] arr) {
			if (arr.Length == len) return arr;

			int[] ret = new int[len];
			Array.Copy(arr, ret, arr.Length);
			return ret;
		}

		public int[] CopyPalette() {
			int[] pal = new int[ColorTable.Length];
			Array.Copy(ColorTable, pal, ColorTable.Length);
			return pal;
		}

		public int[] ResolvePalette() {
			int[] ret = CopyPalette();

			for (int i = 0;i < ret.Length;i++)
				if (MapTable[i] != null)
					ret[i] = MapTable[i].IntColor;

			return ret;
		}

		// method to load 2 external images into 1 pixel array
		public static int[] LoadImagePixels(string pA, string pB, int size) {
			int[] image = new int[size];
			LoadPixels(pA, ref image, 0);
			LoadPixels(pB, ref image, image.Length / 2);

			return image;
		}

		// method to load an external image into pixels into an array
		private static void LoadPixels(string file, ref int[] px, int offset) {
			if (!File.Exists(file)) return;

			using (Bitmap bmp = new Bitmap(file)) {
				if (bmp.Width != 512 || bmp.Height != 256) return;

				// create bdata source from the image
				BitmapData bData = bmp.LockBits(new Rectangle(0, 0, bmp.Width, bmp.Height), ImageLockMode.ReadOnly, System.Drawing.Imaging.PixelFormat.Format24bppRgb);

				// copy the image data into the rgb byte array
				byte[] rgb = new byte[bData.Stride * bmp.Height];
				Marshal.Copy(bData.Scan0, rgb, 0, rgb.Length);

				// load the RGB values into the array at specified offset
				for (int column = 0;column < bData.Height;column++)
					for (int row = 0;row < bData.Width;row++)
						px[offset++] = (rgb[(column * bData.Stride) + (row * 3) + 2] << 16 | rgb[(column * bData.Stride) + (row * 3) + 1] << 8 | rgb[(column * bData.Stride) + (row * 3)]);

				bmp.UnlockBits(bData);
			}
		}
	}
}