package eu.nat.sumi;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Arrays;
import java.util.List;

public class Main {
	public static void main(String[] a) throws IOException {
		Path in = new File("../s2/s2built.bin").toPath(), out = new File("../s2/0.bin").toPath();
		byte[] dat = Files.readAllBytes(in);
		Files.write(out, Arrays.copyOfRange(dat, 0x80000, 0x17FFEC));

		List<String> i = Files.readAllLines(new File("../s2/s2.h").toPath(), StandardCharsets.ISO_8859_1);
		i.remove(0);
		i.remove(i.size() - 1);

		String o = "";
		for(String s : i){
			o += s.replace("#define ", "").replace("#defi\u000B¨ ", "").replace("#\u0000\u00005Fne ", "").replace(" ", " equ ") + "+$280000-$080000\n";
		}

		File f = new File("s2.inc");
		System.out.println("Writing inc file to "+ f.getAbsolutePath());
		Files.write(f.toPath(), o.getBytes());
	}
}
