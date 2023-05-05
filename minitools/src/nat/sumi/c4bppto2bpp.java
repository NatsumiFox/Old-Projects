package nat.sumi;

import java.io.*;

public class c4bppto2bpp {
	static final File in = new File("G:\\getart\\Art.bin");
	static final File out = new File("G:\\testsonic1\\#sega\\art.bin");

	public static void main(String[] args) throws IOException {
		DataInputStream fin = new DataInputStream(new FileInputStream(in));
		DataOutputStream fout = new DataOutputStream(new FileOutputStream(out));

		while(fin.available() > 0){
			fout.write(conv(fin.readShort()));
		}
	}

	private static int conv(short i) {
		return  ((i & 0x3) |
				((i & 0x30) >> 2) |
				((i & 0x300) >> 4) |
				((i & 0x3000) >> 6));
	}
}
