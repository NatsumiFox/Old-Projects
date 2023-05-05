package s3k.nat.sumi;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class Main {
	public static void main(String[] args) throws IOException {
		FileInputStream fis = new FileInputStream(new File(args[0]));
		byte[] in = new byte[(int) (new File(args[0])).length()];
		fis.read(in);
		String out = "";

		for (int fos = 0; fos < in.length; ++fos) {
			if (in[fos] != 61) {
				out = out + (char) in[fos];
			} else {
				fos += 2;
				byte len = in[fos++];
				int value = 0;

				for (int x = 0; x < len; ++fos) {
					value <<= 8;
					value |= in[fos] & 255;
					++x;
				}

				out = out + "= 0" + Integer.toUnsignedString(value, 16) + "h\n";
				--fos;
			}
		}

		FileOutputStream var8 = new FileOutputStream(args[0]);
		var8.write(out.getBytes());
		var8.flush();
		var8.close();
		fis.close();
	}
}
