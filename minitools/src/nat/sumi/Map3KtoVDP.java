package nat.sumi;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

/**
 * Created by NAT on 17.02.09.
 */
public class Map3KtoVDP {
	private static File in = new File("G:\\RESEARCH\\Otters\\ottslsprite_.unc");
	private static File out = new File("G:\\RESEARCH\\Otters\\ottslsprite.unc");
	private static short ART = 0x444, X = 0xC8, Y = 0xD6;
	public static void main(String[] args) throws IOException {
		byte[] i = Files.readAllBytes(in.toPath());
		byte[] o = new byte[i.length / 6 * 8];

		int link = 1;
		for(int a = 0, b = 0;a < i.length;a += 6, b += 8){
			short t = (short) (((i[a + 2] << 8) | (i[a + 3] & 0xFF)) + ART);
			short y = (short) (i[a] + Y);
			short x = (short) (((i[a + 4] << 8) | (i[a + 5] & 0xFF)) + X);

			o[b] = (byte)(y >> 8);
			o[b + 1] = (byte) y;
			o[b + 2] = i[a + 1];
			o[b + 3] = (byte)link++;
			o[b + 4] = (byte)(t >> 8);
			o[b + 5] = (byte) t;
			o[b + 6] = (byte)(x >> 8);
			o[b + 7] = (byte) x;
		}

		Files.write(out.toPath(), o);
	}
}
