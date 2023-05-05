package nat.sumi;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Random;

/**
 * Created by a on 16.09.12.
 */
public class mapbintoasm {
	static final File in = new File("G:\\hacks\\current\\s41\\dat\\ssrg\\LogoMaps.unc");
	static final File out = new File("G:\\hacks\\current\\s41\\dat\\ssrg\\LogoMaps.asm");
	public static void main(String[] args) throws IOException {
		byte[] dat = Files.readAllBytes(in.toPath());
		long map_ = new Random().nextLong();
		String o = "map_"+ Long.toHexString(map_) +":\n";
		short off = 0, first = 0x7FFF, y = 0;

		do {
			short n = s(dat, off);
			if(n < first){
				first = n;
			}

			o += "\tdc.w byte_"+ n + Long.toHexString(map_)+"-map_"+ Long.toHexString(map_) +"\t; $"+ Integer.toHexString(y) +"\n";
			y++;
		} while(first > (off += 2));

		while(off < dat.length){
			short n = s(dat, off);
			o += "byte_"+ off + Long.toHexString(map_) +":\n\tdc.w "+ n +"\n";
			off += 2;

			for(int z = 0;z < n;z ++){
					o += "\tdc.b $"+ Integer.toHexString(dat[off++] & 0xFF).toUpperCase() +", $"+
							Integer.toHexString(dat[off++] & 0xFF).toUpperCase() +", $"+
							Integer.toHexString(dat[off++] & 0xFF).toUpperCase() +", $"+
							Integer.toHexString(dat[off++] & 0xFF).toUpperCase() +", $";
				short x = s(dat, off);
				o +=    Integer.toHexString((x << 8) & 0xFF).toUpperCase() +", $"+
						Integer.toHexString(x & 0xFF).toUpperCase() +"\n";
				off += 2;
			}
		}

		Files.write(out.toPath(), o.getBytes());
	}

	private static short sex(byte b) {
		if(b<0){
			return (short)(0xFF00|(b & 0xFF));
		}

		return b;
	}

	private static short s(byte[] dat, short off) {
		return (short)((dat[off] << 8) | (dat[off + 1] & 0xFF));
	}
}
