package nat.sumi;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.OpenOption;
import java.util.ArrayList;

/**
 * Created by a on 16.08.29.
 */
public class pngtovarfnt {
	static final File in = new File("G:\\RESEARCH\\variable font\\font.png");
	static final String out = "G:\\RESEARCH\\variable font\\font\\";
	private static final c32bto9b[] colorcvt = new c32bto9b[]{
			new c32bto9b(new Color(255, 0, 255)),
			new c32bto9b(new Color(255, 255, 255)),
	};
	private static int nameindex = 0;
	private static final String[] names = {
			"exclam", "mquote", "number", "dollar", "percent", "amper", "squote", "lparen",
			"rparen", "asterisk", "plus", "comma", "hyphen", "dot", "slash",
			"n0", "n1", "n2", "n3", "n4", "n5", "n6", "n7", "n8", "n9",
			"colon", "semicolon", "lchev", "equals", "rchev", "question", "at",
			"uca", "ucb", "ucc", "ucd", "uce", "ucf", "ucg", "uch", "uci", "ucj", "uck",
			"ucl", "ucm", "ucn", "uco", "ucp", "ucq", "ucr", "ucs", "uct", "ucu", "ucv", "ucw", "ucx", "ucy", "ucz",
			"lbrack", "bslash", "rbrack", "circum", "uscore", "apost",
			"lca", "lcb", "lcc", "lcd", "lce", "lcf", "lcg", "lch", "lci", "lcj", "lck",
			"lcl", "lcm", "lcn", "lco", "lcp", "lcq", "lcr", "lcs", "lct", "lcu", "lcv", "lcw", "lcx", "lcy", "lcz",
			"lbrace", "obelisk", "rbrace", "tilde", "_"
	};
	// controls the approximate height of the letters
	// NOTE: this must be the maximum height, as well as vertical height between letter rows!
	private static final int approxletterheight = 8;

	public static void main(String[] args) throws IOException {
		BufferedImage img = ImageIO.read(in);
		System.out.println(in.getAbsolutePath() +": w"+ img.getWidth() +"px, h"+ img.getHeight() +"px "+
		"alpha? "+ img.getColorModel().hasAlpha());

		// define global variables
		int x = 0, y = 0;

		while(true){
		// define borders of the letter
			int cx = x;
			// we want to check if there are any pixels on horizontal and vertical strips.
			boolean haspixels = true, isfirst = true;
			while((haspixels || isfirst) && cx < img.getWidth()) {
				haspixels = false;
				for (int _y = y; _y < y+approxletterheight; _y++) {
					if (!colorcvt[0].f.equals(new Color(img.getRGB(cx, _y)))) {
						haspixels = true;
					}
				}

				if(isfirst && !haspixels){
					x++;
					cx = x;

				} else {
					isfirst = false;
				}

				if(haspixels) cx++;
			}

			cx--;

			haspixels = false;
			int cy = y+approxletterheight-1;
			while(!haspixels && cy > y) {
				haspixels = false;
				for (int _x = x;_x < cx; _x++) {
					if (!colorcvt[0].f.equals(new Color(img.getRGB(_x, cy)))) {
						haspixels = true;
					}
				}

				if(!haspixels) cy--;
			}

			cy++;

			System.out.println("found letter '"+ names[nameindex] +"' has dimensions "+ x +", "+ y +", "+ cx +", "+ cy);
			int w = cx - x + 1, h = cy - y;
			if((w & 1) != 0){
				w++;
				cx++;
			}
			// width must be multiples of 2.
			byte[] bout = new byte[2 + ((w / 2) * h)];

			bout[0] = (byte)((w / 2) - 1);
			bout[1] = (byte)(h - 1);

			int x_ = x, y_ = y;
			for(int o = 2;o < bout.length;o++){
				if(y_ >= cy){
					throw new IllegalStateException("cursor y was higher than letter y boundary, but we still were in write loop!");
				}

				if(x_ + 1 >= img.getWidth()){
					put(find(img.getRGB(x_, y_)), 0, o, bout);

				} else {
					put(find(img.getRGB(x_, y_)), find(img.getRGB(x_ + 1, y_)), o, bout);
				}
				x_ += 2;
				if(x_ >= cx){
					y_ ++;
					x_ = x;
				}
			}

			System.out.println("writing "+ bout.length +" bytes to file "+ out + names[nameindex] +".dat");
			Files.write(new File(out + names[nameindex++] +".dat").toPath(), bout);

			// go to next letter
			x = cx+1;
			if(x >= img.getWidth()){
				x = 0;
				y += approxletterheight;

				if(y >= img.getHeight()) break;
			}
		}
	}

	private static void put(int hi, int low, int off, byte[] bout) {
		bout[off] = (byte)((low & 0xF) | ((hi & 0xF) << 4));
	}

	private static int find(int rgb) {
		for(int q = 0;q < colorcvt.length;q ++){
			if(colorcvt[q].f.equals(new Color(rgb))){
				return q;
			}
		}

		throw new IllegalStateException("RGB color #"+ Integer.toHexString(rgb) +" does not match any 'colorcvt' entry");
	}

	public static class c32bto9b {
		final Color f;
		c32bto9b(Color f){
			this.f = f;
		}
	}
}
