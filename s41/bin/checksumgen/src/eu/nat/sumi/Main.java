package eu.nat.sumi;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Arrays;
import java.util.List;

public class Main {
	public static void main(String[] a) throws IOException {
		Path in = new File(a[0]).toPath();
		byte[] dat = Files.readAllBytes(in);

		int ptr = Integer.parseInt(new String(Files.readAllBytes(new File("temp_checksums.dat").toPath())), 16);

		if(ptr > 0x080000){
			System.out.println("Error! Checksum data after first bank!");
			return;
		}

		for(int z = 1; z < (dat.length / 0x080000); z++){
			long ch = 0x32623274; // "2b2t"
			for(int o = 0;o < 0x080000;o += 8){
				ch -= sl(dat, (z * 0x080000) + o);
				ch += sl(dat, (z * 0x080000) + o + 4);
			}

			short res = (short)((((ch & 0xFFFF0000)>>16) & 0xFFFF) ^ (ch & 0xFFFF));
			System.out.println(Integer.toHexString(z * 0x080000) +": "+ Integer.toHexString(res & 0xFFFF));
			ps(dat, ptr, res);
			ptr += 2;
		}

		Files.write(in, dat);
	}

	private static String h(long dat) {
		return Long.toHexString(dat);
	}

	private static void ps(byte[] dat, int off, short num) {
		dat[off] =      (byte)(num >> 8);
		dat[off + 1] =  (byte)(num);
	}

	private static long sl(byte[] dat, int off) {
		return (long)(
				((dat[off] << 24) &     0xFF000000) |
				((dat[off + 1] << 16) & 0xFF0000) |
				((dat[off + 2] << 8) &  0xFF00) |
				(dat[off + 3] &         0xFF));
	}
}
