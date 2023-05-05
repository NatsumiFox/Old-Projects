package nat.sumi;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

public class IMGto1BPP {
	static final File in = new File("G:\\hacks\\current\\Sonic music hack\\artunc\\font.png");
	static final File out = new File("G:\\hacks\\current\\Sonic music hack\\artunc\\font1.unc");

	public static void main(String[] asd) throws IOException {
		BufferedImage r = ImageIO.read(in);
		int w = r.getWidth(), h = r.getHeight();
		if ((w & 7) != 0) {
			System.out.println("Image width must be divisible by 8");
			return;
		}
		if ((h & 7) != 0) {
			System.out.println("Image height must be divisible by 8");
			return;
		}

		byte[] o = new byte[(w / 8) * (h / 2)];
		int p = 0;
		for (int ty = 0; ty < h; ty += 16)
			for (int tx = 0; tx < w; tx += 8)
				for (int py = 0; py < 8; py++) {
					byte n = 0;
					for (int px = 0; px < 8; px++) {
						n <<= 1;
						if (r.getRGB(tx + px, ty + py) != 0xFFFFFFFF)
							n++;
					}

					o[p++] = n;
				}
	}
}
