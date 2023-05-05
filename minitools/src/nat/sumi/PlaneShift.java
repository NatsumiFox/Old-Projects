package nat.sumi;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

/**
 * Created by NAT on 17.02.09.
 */
public class PlaneShift {
	private static File in = new File("G:\\hacks\\not mine\\Hellfire Saga\\Objects\\GMZ1Lava\\Object data\\Plane Map.unc");
	private static File out = new File("G:\\hacks\\not mine\\Hellfire Saga\\Objects\\GMZ1Lava\\Object data\\Plane Map.unc");
	private static short OFF = (short)0x168;
	public static void main(String[] args) throws IOException {
		byte[] i = Files.readAllBytes(in.toPath());

		for(int a = 0;a < i.length;a += 2){
			short t = (short) (((i[a] << 8) | (i[a + 1] & 0xFF)) + OFF);
			i[a] = (byte)(t >> 8);
			i[a + 1] = (byte) t;
		}

		Files.write(out.toPath(), i);
	}
}
