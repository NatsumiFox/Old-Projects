package nat.sumi;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

/**
 * Created by NAT on 17.10.28.
 */
public class TileColorReplace {
	private static File in = new File("G:\\tools\\art\\getart\\Art.bin");
	private static File out = new File("G:\\RESEARCH\\Markey 2\\Art Fox.unc");
	public static void main(String[] args) throws IOException {
		byte[] d = Files.readAllBytes(in.toPath());

		for(int i = 0;i < d.length;i++) {
			d[i] = (byte)((pal(d[i] >> 4) << 4) | pal(d[i] & 0xF));
		}

		Files.write(out.toPath(), d);
	}

	private static int pal(int i) {
		switch(i){
			case 0:
				return 0xF;
			default:
				return i;
		}
	}
}
