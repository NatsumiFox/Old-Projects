package nat.sumi;

import java.io.*;

public class PalFadeCreator {
	final static int times = 3, fade = 2;
	static final File in = new File("G:\\Disassemblies\\s1orbinaut\\ua\\pal.bin");
	static final File out = new File("G:\\Disassemblies\\s1orbinaut\\ua\\pal.bin");

	public static void main(String[] args) throws IOException {
		byte[] d = Main.readBytes(in);
		DataOutputStream fout = new DataOutputStream(new FileOutputStream(out));

		for(int i = 0;i < d.length;i += 2){
			short c = readShort(d, i);
			int r = c & 0xF, g = c & 0xF0, b = c & 0xF00;

			for(int s = 0;s < times;s ++) {
				fout.writeShort(getFade(r, g, b, s * fade));
			}
		}
	}

	private static int getFade(int r, int g, int b, int fade) {
		if(b >= (fade * 0x100)){
			b -= (fade * 0x100);
		} else {
			b = 0;
		}

		if(g >= (fade * 0x10)){
			g -= (fade * 0x10);
		} else {
			g = 0;
		}

		if(r >= fade){
			r -= fade;
		} else {
			r = 0;
		}

		return b | g | r;
	}

	private static short readShort(byte[] d, int i) {
		return (short) ((d[i] << 8) & 0xFF00 | (d[i + 1] & 0xFF));
	}
}
