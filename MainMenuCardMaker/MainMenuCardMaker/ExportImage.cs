//#define OPTIMIZE_SHAPE_RENDER

using System;
using System.Collections.Generic;
using OpenTK;
using OpenTK.Graphics.OpenGL;
using System.Linq;
using System.Threading;
using System.Diagnostics;

namespace MainMenuCardMaker {
	public class ExportImage : IDisposable {
		public Tile[] Tiles;
		public TileRef[] Plane;
		public bool[] HiPlane;
		public int Palette, MaxTile;

		public ExportImage() {
			Tiles = new Tile[0x800];
			Plane = new TileRef[64 * 64];
			HiPlane = new bool[64 * 64];
			int[] palette = new int[256];
			MaxTile = 0;

			int off = 0;
			if(Converter.palette != null)
			for (int xo = 0;xo < Converter.palette.Length;xo++)
				for (int yo = 0;yo < Converter.palette[xo].Length;yo++, off++)

					if (Converter.palette[xo][yo] == null) {
						palette[off + 64] = palette[off] = 0;

					} else {
						palette[off] = Converter.palette[xo][yo].IntColor;
						palette[off + 64] = Converter.palette[xo][yo].IntColorDark;
					}

			off += 64;

			for (;off < palette.Length;off++)
				palette[off] = 0;

			palette[129] = 0xFF0000 | -16777216;
			palette[145] = 0x00FF00 | -16777216;

			Form1.Context.convertControl1.Invoke(() => {
				Form1.Context.convertControl1.SetUpdate(false);
				Form1.Context.convertControl1.MakeCurrent();
				Palette = GLlib.LoadTexture(palette, 16, 16);

				Form1.Context.convertControl1.SetUpdate(true);
			});
		}

		public void Dispose() {
			if (Palette != 0) GL.DeleteTexture(Palette);
			for (int i = 0;i < MaxTile;i++)
				Tiles[i].Dispose();
		}

		private byte[][] TempConv;
		private int[] TempConvLine;

		public void Convert(ImportImage import) {
			bool update = true;
			TempConv = new byte[64 * 64][];
			TempConvLine = new int[64 * 64];

			// using this fancy af thread we actually optimize this to be slightly faster
			new Thread(() => {
				// first, convert the priority tiles into data
				foreach (int t in import.PriorityTiles) {
					byte[] data = ConvertTile(t % 64 * 8, t / 64 * 8, import, out int line);
					Tiles[MaxTile++] = new Tile(data);
					TempConv[t] = data;
					TempConvLine[t] = line;
				}

				// now, just convert every single tile in the plane into byte[32] with accompanying line
				for (int y = 0;y < 64;y++) 
					for (int x = 0;x < 64;x++) 
						if (TempConv[x + (y * 64)] == null) 
							TempConv[x + (y * 64)] = ConvertTile(x * 8, y * 8, import, out TempConvLine[x + (y * 64)]);
				
				// and finally, keep updating the display once done
				while (update) {
					Thread.Sleep(100);
					Form1.Context.convertControl1.Invoke(() => {
						Form1.Context.convertControl1.Invalidate();
					});
				}

				// update the text field with proper info
				Form1.Context.Invoke(() => {
					Form1.Context.tileNumber.Text = "Total tiles: " + MaxTile.ToString("X");
				});
			}).Start();

			// then, convert the rest and construct a plane
			for (int y = 0;y < 64;y++) {
				for (int x = 0;x < 64;x++) {
					// wait for the right tile to appear
					while (TempConv[x + (y * 64)] == null) Thread.Sleep(1);
					byte[] data = TempConv[x + (y * 64)];
					int line = TempConvLine[x + (y * 64)];

					// now, search for appropriate tiles
					bool found = false;

					for(int i = 0;i < MaxTile;i++) {
						int eq = Tiles[i].Check(data);

						if(eq >= 0) {
							found = true;
							Plane[(y * 64) + x] = new TileRef(Tiles[i], (ushort)(eq | (line << 13) | (HiPlane[(y * 64) + x] ? 0x8000 : 0)));
							Tiles[i].used++;
							break;
						}
					}

					if (!found) {
						Tile t = new Tile(data);
						Tiles[MaxTile++] = t;
						Plane[(y * 64) + x] = new TileRef(t, (ushort)((line << 13) | (HiPlane[(y * 64) + x] ? 0x8000 : 0)));
					}
				}
			}

			update = false;
			TempConv = null;
			TempConvLine = null;
		}

		private byte[] ConvertTile(int x, int y, ImportImage import, out int actualline) {
			int[] line = { 0, 0, 0, 0 };

			for (int p = 0;p < 64;p++) {
				// load a single pixel from image, calculate palette line
				int index = import.ImageData[((y + (p / 8)) * 512) + x + (p % 8)];
				ColorMD color = import.MapTable[index];

				if (color == null) {
					// we need to calculate the closest color here if no mapping was created
					// TODO
					color = Converter.palette[0][0];
				}

				// increase line counter if color was found
				line[Converter.GetPaletteEntryOffset(color) / 16]++;
			}

			// check which line was most likely
			actualline = 0; int amount = 0;

			for (int i = 0;i < line.Length;i++)
				if (line[i] > amount)
					actualline = i;

			// now, start the conversion!
			byte[] data = new byte[32];
			
			for (int p = 0;p < 64;p++) {
				// load a single pixel from image, calculate palette line
				int index = import.ImageData[((y + (p / 8)) * 512) + x + (p % 8)];
				ColorMD color = import.MapTable[index];

				if (color == null) {
					// we need to calculate the closest color here if no mapping was created
					// TODO
					index = 0;

				} else {
					int eno = Converter.GetPaletteEntryOffset(color);

					if (eno / 0x10 != actualline) {
						// if the color was not found on this palette line, find the closest matching one!
						// TODO
						index = 0;

					} else index = eno % 0xF;
				}

				// save the colour into memory
				if ((p & 1) == 0) data[p / 2] |= (byte)(index << 4);
				else data[p / 2] |= (byte)(index & 0xF);
			}

			return data;
		}

		public byte[] DumpTiles() {
			byte[] data = new byte[32 * MaxTile];

			for (int i = 0;i < MaxTile;i++)
				Array.Copy(Tiles[i].data[0], 0, data, i * 32, 32);

			return data;
		}

		public byte[] DumpPlaneA() {
			return DumpPlane(0);
		}

		public byte[] DumpPlaneB() {
			return DumpPlane(64 * 32);
		}

		private byte[] DumpPlane(int offset) {
			byte[] data = new byte[64 * 32 * 2];

			for (int i = 0;i < 64 * 32;i++) {
				ushort s = Plane[i + offset].GetWord();
				data[i * 2] = (byte)(s >> 8);
				data[(i * 2) + 1] = (byte)s;
			}

			return data;
		}
	}

	public class Tile : IDisposable {
		public byte[][] data;
#if OPTIMIZE_SHAPE_RENDER
		public int texture;
#else
		public int[] texture;
#endif
		public int used;

		public Tile(byte[] data) {
			this.data = new byte[][] {
				data, HzFlip(data), VrFlip(data), HzFlip(VrFlip(data)),
			};

#if OPTIMIZE_SHAPE_RENDER
			texture = Generate(this.data[0]);
#else
			texture = new int[] {
				Generate(this.data[0]),
				Generate(this.data[1]),
				Generate(this.data[2]),
				Generate(this.data[3]),
			};
#endif
			used = 1;
		}

		public static int Generate(byte[] data) {
			if (data.Length != 32) return -1;
			int tex = -1;

			Form1.Context.convertControl1.Invoke(() => {
				Form1.Context.convertControl1.SetUpdate(false);
				Form1.Context.convertControl1.MakeCurrent();
				byte[] txdata = new byte[data.Length * 2];

				for(int i = 0;i < data.Length;i++) {
					txdata[i * 2] = (byte)(data[i] >> 4);
					txdata[(i * 2) + 1] = (byte)(data[i] & 0xF);
				}

				tex = GLlib.LoadTexture(txdata, 8, 8, PixelInternalFormat.R8, PixelFormat.Red);
				Form1.Context.convertControl1.SetUpdate(true);
			});

			return tex;
		}

		public static byte[] HzFlip(byte[] data) {
			byte[] ret = new byte[32];

			for(int s = 0, d = 4;s < 32;d += 8)
				for(int i = 0;i < 4;i ++)
					ret[--d] = (byte)(data[s] << 4 | data[s++] >> 4);

			return ret;
		}

		public static byte[] VrFlip(byte[] data) {
			byte[] ret = new byte[32];

			for (int s = 0, d = 28;s < 32;d -= 8)
				for (int i = 0;i < 4;i++)
					ret[d++] = data[s++]; 

			return ret;
		}

		public void Dispose() {
#if OPTIMIZE_SHAPE_RENDER
			if (texture != 0)
				GL.DeleteTexture(texture);
#else
			if (texture != null)
				GL.DeleteTextures(texture.Length, texture);
#endif
		}

		public int Check(byte[] ck) {
			if (Check(ck, data[0])) return 0;
			if (Check(ck, data[1])) return 0x800;
			if (Check(ck, data[2])) return 0x1000;
			if (Check(ck, data[3])) return 0x1800;
			return -1;
		}

		public static bool Check(byte[] arr1, byte[] arr2) {
			//	if (arr1.Length != 32 && arr2.Length != 32) throw new ArgumentException("Argument 1 or 2 was not 32 bytes in size!");

			for (int i = 0;i < 32;i++)
				if (arr1[i] != arr2[i])
					return false;

			return true;
		}
	}

	public class TileRef {
		public ushort flags;
		public Tile tile;
		public bool IsHighPlane => (flags & 0x8000) != 0;

		public TileRef(Tile t, ushort f) {
			flags = f;
			tile = t;
		}

		public void Draw(int x, int y, int loc, bool doshadow) {
			int xf = Math.Min(flags & 0x800, 1);
			int yf = Math.Min(flags & 0x1000, 1);
			int line = ((flags & 0x6000) >> 13);

			// Set texture as active and bind it
#if OPTIMIZE_SHAPE_RENDER
			GL.BindTexture(TextureTarget.Texture2D, tile.texture);
#else
			GL.BindTexture(TextureTarget.Texture2D, tile.texture[(yf * 2) + xf]);
#endif
			GL.Uniform1(loc, 0f + line + (doshadow && (flags & 0x8000) == 0 ? 4 : 0));

			GL.Begin(PrimitiveType.Quads);
#if OPTIMIZE_SHAPE_RENDER
			GL.TexCoord2(0 ^ xf, 0 ^ yf); GL.Vertex2(x, y);
			GL.TexCoord2(0 ^ xf, 1 ^ yf); GL.Vertex2(x, y + 8);
			GL.TexCoord2(1 ^ xf, 1 ^ yf); GL.Vertex2(x + 8, y + 8);
			GL.TexCoord2(1 ^ xf, 0 ^ yf); GL.Vertex2(x + 8, y);
#else
			GL.TexCoord2(0, 0); GL.Vertex2(x, y);
			GL.TexCoord2(0, 1); GL.Vertex2(x, y + 8);
			GL.TexCoord2(1, 1); GL.Vertex2(x + 8, y + 8);
			GL.TexCoord2(1, 0); GL.Vertex2(x + 8, y);
#endif
			GL.End();
			GL.BindTexture(TextureTarget.Texture2D, 0);
		}

		public ushort GetWord() {
			int index = Array.IndexOf(Converter.Export.Tiles, tile);
			if (index < 0) return 0xFFFF;
			return (ushort)(flags | index);
		}
	}
}