package nat.sumi;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;

public class ImageToLines {
	private static File in = new File("G:\\RESEARCH\\Otters\\foxspr.png");
	private static String out = "G:\\RESEARCH\\Otters\\foxsl";
	public static int OFF = 0x35C;

	public static void main(String[] args) throws IOException {
		BufferedImage img = ImageIO.read(in);
		System.out.println(in.getAbsolutePath() +": w"+ img.getWidth() +"px, h"+ img.getHeight() +"px "+
				"alpha? "+ img.getColorModel().hasAlpha());

		Plane p = new Plane(img.getWidth(), img.getHeight());

		for(int x = 0;x < img.getWidth();x += 8){
			for(int y = 0;y < img.getHeight();y += 8){
				byte[] dat = new byte[32];

				for(int i = 0;i < 64;i ++){
					int _x = x + (i & 7);
					int _y = y + (i / 8);

					if(!Color.WHITE.equals(new Color(img.getRGB(_x, _y)))){
					//	int c = (_y & 7) + 8;
						int c = 1;
						dat[i / 2] |= (i & 1) != 0 ? (byte)c : (byte)(c << 4);
					}
				}

				p.tl(x / 8, y / 8, dat, /*(short)((y & 0x18) << 10)*/(short)0);
			}
		}

		Files.write(new File(out + "tiles.unc").toPath(), p.tls());
		Files.write(new File(out + "sprite.unc").toPath(), p.pl());
	}

	private static class Plane {
		public final int w, h;
		public short[][] plane;
		private int maxtile;
		public byte[][] tiles;

		Plane(int w, int h){
			this.w = w / 8;
			this.h = h / 8;

			tiles = new byte[0x800][];
			tiles[0] = new byte[32];        // null tile
			maxtile = 1;
			plane = new short[this.w][];

			for(int i = 0;i < plane.length;i ++){
				plane[i] = new short[this.h];
			}
		}

		public byte[] pl() {
			byte[] o = new byte[w * h * 2];

			for(int x = 0; x < w;x ++){
				for(int y = 0;y < h;y ++){
					short s = (short)(OFF + plane[x][y]);
					o[(x + (y * w)) * 2] = (byte)(s >> 8);
					o[((x + (y * w)) * 2) + 1] = (byte)s;
				}
			}

			return o;
		}

		public byte[] tls() {
			byte[] o = new byte[maxtile*32];

			for(int i = 0; i < maxtile;i ++){
				System.arraycopy(tiles[i], 0, o, (i * 32), 32);
			}

			return o;
		}

		public void tl(int x, int y, byte[] data, short line){
			for(short i = 0;i < maxtile;i ++){
				short tl = -1;

				if(cktl(tiles[i], data)) {
					tl = (short)(i | line);

				} else if(cktl(tiles[i], fliph(data))) {
					tl = (short)(i | 0x800 | line);     // h-flip

				} else if(cktl(tiles[i], flipv(data))) {
					tl = (short)(i | 0x1800 | line);     // v-flip

				} else if(cktl(tiles[i], flipv(fliph(data)))) {
					tl = (short)(i | 0x1000 | line);     // hv-flip
				}

				if(tl != -1) {
					plane[x][y] = tl;
					return;
				}
			}

			plane[x][y] = (short)(maxtile | line);
			tiles[maxtile++] = data;
		}

		private byte[] fliph(byte[] t) {
			for(int i = 0;i < 32;i += 4) {
				wi(inv(ri(t, i)), t, i);
			}

			return t;
		}

		private byte[] flipv(byte[] t) {
			byte[] o = new byte[32];

			for(int io = 32-4, it = 0;it < 32;io -= 4,it += 4) {
				o[io] = t[it];
				o[io + 1] = t[it + 1];
				o[io + 2] = t[it + 2];
				o[io + 3] = t[it + 3];
			}

			return o;
		}

		private void wi(int d, byte[] a, int o) {
			a[o] = (byte)(d >> 24);
			a[o + 1] = (byte)(d >> 16);
			a[o + 2] = (byte)(d >> 8);
			a[o + 3] = (byte)d;
		}

		private boolean cktl(byte[] t1, byte[] t2) {
			for(int i = 0;i < 32;i ++){
				if(t1[i] != t2[i]) return false;
			}

			return true;
		}

		private static int ri(byte[] d, int i) {
			return d[i] << 24 | (d[i + 1] & 0xFF) << 16 | (d[i + 2] & 0xFF) << 8 | (d[i + 3] & 0xFF);
		}

		private static int inv(int i) {
			return (((i << 28) & 0xF0000000) |
					((i << 20) & 0xF000000) |
					((i << 12) & 0xF00000) |
					((i << 4)  & 0xF0000) |
					((i >> 4)  & 0xF000) |
					((i >> 12) & 0xF00) |
					((i >> 20) & 0xF0) |
					((i >> 28) & 0xF));
		}
	}
}
