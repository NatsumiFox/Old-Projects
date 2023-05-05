package eu.nat.sumi;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Arrays;

public class Main {
	public static void main(String[] a) throws IOException {
		Path in = new File("../sk/skbuilt.bin").toPath(),
				out1 = new File("../sk/1.bin").toPath(),
				out2 = new File("../sk/2.bin").toPath();
		byte[] dat = Files.readAllBytes(in);
		Files.write(out1, Arrays.copyOfRange(dat, 0x80000, 0x177DF0));
		Files.write(out2, Arrays.copyOfRange(dat, 0x17DE30, 0x27FA1A));
	}
}
