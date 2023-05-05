package nat.sumi;

import java.io.File;
import java.io.IOException;

/**
 * Created by NAT on 20.04.20.
 */
public class ReMapper {
	static final File in = new File("G:\\hacks\\not mine\\Hellfire Saga\\Levels\\GMZ\\Animated Tiles\\Bottom Layer.unc");
	static final File out = new File("G:\\hacks\\not mine\\Hellfire Saga\\Levels\\GMZ\\Animated Tiles\\Bottom Layer.unc");

	public static void main(String[] args) throws IOException {
		byte[] input = Main.readBytes(in);
		byte[] output = new byte[input.length];

		for(int i = 0;i < input.length / 32;i ++){
			System.arraycopy(input, i * 32, output, translate(i) * 32, 32);
		}

		Main.write(out, output, false);
	}

	public static int translate(int i) {
		int offset = i % 14;
		if(offset < 7) return i;

		if(offset == 13) return i - 6;
		return i + 1;
	}
}
