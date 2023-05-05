package nat.sumi;


import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;

public class BMPtoBitmap {
	static final File in = new File("G:\\RESEARCH\\bitmapmode\\bitmap.bmp");
	static final File out = new File("G:\\RESEARCH\\bitmapmode\\bitmap.bin");

	public static void main(String[] args) {
		try {
			BufferedImage bfi = ImageIO.read(in);
			DataOutputStream fout = new DataOutputStream(new FileOutputStream(out));

			// process the image
			for(int y = 0;y < bfi.getHeight();y ++){
				for(int x = 0;x < bfi.getWidth();x ++){
					fout.writeShort(RBGtoMD(bfi.getRGB(x, y)));
				}
			}

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private static short RBGtoMD(int rgb) {
		int r = (rgb & 0xFF0000) >> 16, g = (rgb & 0xFF00) >> 8, b = rgb & 0xFF;
		r = translateMD(r);		g = translateMD(g);		b = translateMD(b);
		return (short) ((b << 8) | (g << 4) | r);
	}

	private static int translateMD(int c) {
		return (int) (c / 18.2142857142857f) & 0xE;
	}
}
