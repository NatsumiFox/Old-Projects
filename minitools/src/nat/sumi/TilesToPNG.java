package nat.sumi;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

public class TilesToPNG {
	private static File tiles = new File("G:\\hacks\\current\\S3K Battle Race\\Levels\\MHZ/Animated Tiles/0.bin");
	private static File pal = new File("G:\\hacks\\current\\S3K Battle Race\\Levels\\MHZ\\Palettes\\1.bin");
	private static int paloff = 16*2;
	private static int tiloff = 0;
	private static int tilend = -1;
	private static File out = new File("G:\\tools\\art\\getart\\Bitmap.png");
	private static int[] colortbl = new int[]{ 0, 36, 72, 108, 144, 180, 216, 252 };

	public static void main(String[] args) throws IOException {
		byte[] tl = Files.readAllBytes(tiles.toPath());
		byte[] pl = Files.readAllBytes(pal.toPath());
		int[] cvt = new int[16];
		if(tilend < 0) tilend = tl.length / 32;

		// generate color conversion table
		for(int i = paloff * 2, x = 0; x < 16 && i < pl.length;x++, i += 2){
			cvt[x] = colortbl[(pl[i] & 0xE) >> 1];              // B
			cvt[x] |= colortbl[(pl[i + 1] & 0xE) >> 1] << 16;   // R
			cvt[x] |= colortbl[(pl[i + 1] & 0xE0) >> 5] << 8;   // G
		}

		BufferedImage o = new BufferedImage(8 * (tilend - tiloff), 8, BufferedImage.TYPE_INT_BGR);

		// render graphics
		for(int t = tiloff;t < tilend;t ++){
			int[] tlbf = new int[64];

			for(int x = 0;x < 4;x ++){
				for(int y = 0;y < 8;y ++){
					tlbf[(y * 8) + (x * 2)] = cvt[(tl[(t * 32) + (y * 4) + x] & 0xF0) >> 4];
					tlbf[(y * 8) + (x * 2) + 1] = cvt[tl[(t * 32) + (y * 4) + x] & 0xF];
				}
			}

			o.setRGB((t - tiloff) * 8, 0, 8, 8, tlbf, 0, 8);
		}

		ImageIO.write(o, "png", out);
	}
}
