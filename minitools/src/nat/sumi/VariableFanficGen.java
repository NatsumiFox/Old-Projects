package nat.sumi;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Arrays;

/**
 * Created by NAT on 5.10.2016.
 */
public class VariableFanficGen {
	 private static byte[] cpcvt = {
			0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1, 0, 0, 0, 0, 0, // 0x00-0x0F
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 0x10-0x1F
			4, 4, 6, 0, 0, 0, 8, 2, 0, 0, 0, 0, 4, 8, 2, 0, // 0x20-0x2F
			8, 6, 8, 8, 8, 8, 8, 8, 8, 8, 2, 4, 0, 6, 0, 8, // 0x30-0x3F
			8, 8, 8, 8, 8, 8, 8, 8, 8, 6, 8, 8, 8, 8, 8, 8, // 0x40-0x4F
			8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, // 0x50-0x5F
			0, 8, 8, 8, 8, 8, 8, 8, 8, 6, 8, 8, 8, 8, 8, 8, // 0x60-0x6F
			8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, // 0x70-0x7F
	};

	public static String in = "G:\\hacks\\current\\s41\\dat\\font\\cave.txt";
	public static String out = "G:\\hacks\\current\\s41\\dat\\font\\cave.dat";
	public static byte spcw = 2;

	public static void main(String[] args) throws IOException {
		byte[] dat = Files.readAllBytes(new File(in).toPath());
		String o = "";

		int xl = 320, lw = 0, xd = 0, st = 0;
		while(xd < dat.length-1){
			byte chc = dat[(xd)++], chw = ch(chc);

			if(chw == 0){
				throw new IOException("Illegal character at input '"+ (char)chc +"' ("+ chc +") at "+ (xd - 1));

			} else if(chw == -1){
				o = putstr(dat, st, xd - 1, o);
				lw = xd;
				st = xd;
				xl = 320;

			} else {
				if(chc == ' '){
					lw = xd;
				}

				if((xl -= chw + spcw) < 0 && dat[xd] != ' '){
					o = putstr(dat, st, lw-1, o);
					xl = 320;
					st = lw;

					for(int z = lw; z <= xd;z ++){
						xl -= ch(dat[z]) + spcw;
					}
				}
			}
		}

		o = putstr(dat, st, dat.length, o);
		System.out.println(o.replace("\0", "\n"));
		Files.write(new File(out).toPath(), (o +"ÿ").getBytes("Cp1252"));
	}

	private static String putstr(byte[] dat, int from, int to, String o) {
		if(to - from < 0){
			return o + '\0';

		} else {
			return o + new String(Arrays.copyOfRange(dat, from, to)) + '\0';
		}
	}

	private static byte ch(byte b) {
		return b < 0 ? 0 : cpcvt[b];
	}
}
