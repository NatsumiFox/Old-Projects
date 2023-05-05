package nat.sumi;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class TotinoArt {
	static final File in = new File("<input file>");
	static final File out = new File("<output file>");
	static final Color transp = new Color(254, 24, 220);

	public static void main(String[] args) throws IOException {
		BufferedImage img = ImageIO.read(in);
		int w = img.getWidth(), h = img.getHeight();
		byte[] dat = new byte[w * h / 2];
		System.out.println("Width & Height: $"+ String.format("%02X", (w / 2) - 1) + String.format("%02X", h - 1));

		int off = -1;
		boolean q = false;
		for(int y = 0;y < h;y++){
			for(int x = 0;x < w;x++){
				q ^= true;
				Color c = new Color(img.getRGB(x, y));
				byte col = 0;
				if(!c.equals(transp)){
					col = (byte) ((1 + (c.getRed() / 32)));
				}

				if(q){
					dat[++off] = (byte)(col << 4);

				} else {
					dat[off] |= col;
				}
			}
		}
	}
