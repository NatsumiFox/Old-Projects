package nat.sumi;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class ArtSlicer {
	static final File in = new File("G:\\hacks\\current\\s41\\dat\\gf.s3k.art.unc");
	static final File out = new File("G:\\hacks\\current\\s41\\dat\\gf.s3k.art.slice.unc");
	static final int width = 96/8;
	static final int height = 96/8;

	public static void main(String[] args) throws IOException {
		byte[] d = Main.readBytes(in);
		DataOutputStream fout = new DataOutputStream(new FileOutputStream(out));

		for(int tr = 0;tr < (width*32*height);tr += (width*32)){
			for(int pr = 0;pr < (4*8);pr += 4){
				for(int tl = 0;tl < (width*32);tl += 32){
					fout.writeInt(readInt(d, tr + pr + tl));
				}
			}
		}
	}

	private static int readInt(byte[] d, int i) {
		return d[i] << 24 | (d[i + 1] & 0xFF) << 16 | (d[i + 2] & 0xFF) << 8 | (d[i + 3] & 0xFF);
	}
}
