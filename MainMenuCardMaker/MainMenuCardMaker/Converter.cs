using System;
using System.Diagnostics;
using System.Text;
using System.Threading.Tasks;

namespace MainMenuCardMaker {
	public static class Converter {
		// current Mega Drive palette selected
		public static ColorMD[][] palette;
		// number of palette entries per line
		public static int lineHeight = 16;

		public static void Reset() {
			palette = new ColorMD[][] { new ColorMD[16], new ColorMD[16] };

			// initialize palette view
			palette[0][0] = new ColorMD(0) { nowrite = true, transparent = true };
			palette[1][0] = new ColorMD(0) { nowrite = true, transparent = true };

			for (int i = 1;i < palette[0].Length;i++)
				palette[0][i] = new ColorMD(0);

			for (int i = 12;i < palette[1].Length;i++)
				palette[1][i] = new ColorMD(0);
		}

		//	public static readonly int[] ColorLevels = new int[] { 0, 52, 87, 116, 144, 172, 206, 255, };
		public static readonly int[][] ColorLevels = {
			new int[] { 0, 36, 72, 108, 144, 180, 216, 252, },
			new int[] { 0, 29, 52, 70, 87, 101, 116, 130, },
		};
			

		public static int MDtoInt(short col, int index) {
			return (ColorLevels[index][(col >> 1) & 7]) << 16 | (ColorLevels[index][(col >> 5) & 7]) << 8 | (ColorLevels[index][(col >> 9) & 7]);
		}

		public static short InttoMD(int col) {
			int r = GetNearestColor((col >> 16) & 0xFF) * 2;
			int g = GetNearestColor((col >> 8) & 0xFF) * 2;
			int b = GetNearestColor(col & 0xFF) * 2;
			return (short)(r | (g << 4) | (b << 8));
		}

		private static int GetNearestColor(int c) {
			for (int i = 0;i < ColorLevels.Length;i++)
				if (ColorLevels[0][i] >= c) {
					if (i == 0) return i;

					c -= ColorLevels[0][i - 1];
					return i - ((ColorLevels[0][i] - ColorLevels[0][i - 1]) / 2 > c ? 1 : 0);
				}

			return ColorLevels.Length - 1;
		}

		public static ImportImage Import = null;

		public static void LoadImage(string pA, string pB) {
			// create new import instance and initialize the image
			if (Import != null) Import.Dispose();
			Import = new ImportImage();
			Import.LoadImage(ImportImage.LoadImagePixels(pA, pB, 512 * 512), 512, 512);

			if (Form1.DEBUG) {
				for (int i = 0;i < debug_po.Length;i++) {
					Import.MapTable[i] = GetPaletteByOffset(debug_po[i]);
					if(!Import.MapTable[i].nowrite) Import.MapTable[i].IntColor = Import.ColorTable[i];
				}

				for (int i = 0;i < debug_clr.Length;i++)
					GetPaletteByOffset(debug_clr[i]).Color = 0x00A;

				Import.ChangePalette();
			}
		}

		private static readonly byte[] debug_clr = {
			13, 14, 15, 31, 30, 29, 28,
		};

		private static readonly byte[] debug_po = {
			1, 0, 3, 4, 9, 2, 12, 11, 7, 6, 8, 10, 2, 5,
		};

		// function that finds an entry ID based on ColorMD reference
		public static int GetPaletteEntryOffset(ColorMD c) {
			for (int xo = 0, off = 0;xo < palette.Length;xo++) 
				for (int yo = 0;yo < palette[xo].Length;yo++, off++) 
					if (palette[xo][yo] == c) return off;

			return -1;
		}

		// function that gets a ColorMD from the palette based on its sequential ID
		public static ColorMD GetPaletteByOffset(int id) {
			for (int xo = 0;xo < palette.Length;xo++) {
				id -= palette[xo].Length;
				if (id < 0) return palette[xo][id + palette[xo].Length];
			}

			return null;
		}

		public static ExportImage Export = null;

		public static void GenTiles() {
			if (Import == null) return;
			if (Export != null) Export.Dispose();

			Stopwatch sw = new Stopwatch();
			sw.Start();
			Export = new ExportImage();
			Export.Convert(Import);
			sw.Stop();

			Form1.Context.Invoke(() => {
				Form1.Context.loadTime.Text = "Convert Time: " + sw.ElapsedMilliseconds + "ms (" + sw.ElapsedTicks + " ticks)";
			});
		}
	}

	public class ColorMD {
		private short _color;
		private int _intcolor, _intcolordark;
		public bool nowrite = false, transparent = false;

		// set the MD color variant and make sure int color matches
		public short Color { get { return _color; }
			set {
				_intcolor = Converter.MDtoInt(_color = value, 0) | (transparent ? 0 : -16777216);
				_intcolordark = ToDarkCol(_intcolor);
			} }

		// set the int color variant and make sure MD color matches
		public int IntColor { get { return _intcolor; }
			set {
				_color = Converter.InttoMD(_intcolor = value | (transparent ? 0 : -16777216));
				_intcolordark = ToDarkCol(_intcolor);
			} }

		// set the int color variant and make sure MD color matches
		public int IntColorDark { get { return _intcolordark; } private set { } }

		public ColorMD(short col) {
			Color = col;
		}

		public ColorMD(int col) {
			IntColor = col;
		}

		private int ToDarkCol(int col) {
			return (col & -16777216) | ((col & 0xFF0000) / 2 & 0xFF0000) | ((col & 0xFF00) / 2 & 0xFF00) | ((col & 0xFF) / 2 & 0xFF);
		}
	}
}
