package nat.sumi;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

public class TFItoSMPS {
	static final String in = "G:\\tools\\disasm\\smps contest\\dat\\vgm2tif\\14_-_Village_Theme_2_2";

	public static void main(String[] args) throws IOException {
		byte[] tfi = Files.readAllBytes(new File(in +".tfi").toPath());
		byte[] smps = new byte[0x19];

		// smps: byte 0 = feedback + algorithm
		// tfi: byte 0 = algorithm
		// tfi; byte 1 = feedback
		smps[0] = (byte)((tfi[0] & 0x7) | ((tfi[1] & 0x7) << 3));

		// smps: byte 1-4 = detune + multiplier
		// tfi: byte 2,C,16,20 = multiplier
		// tfi: byte 3,D,17,21 = detune
		smps[1] = (byte)((tfi[2] & 0xF) | ((tfi[3] & 0x7) << 4));
		smps[2] = (byte)((tfi[0xC] & 0xF) | ((tfi[0xD] & 0x7) << 4));
		smps[3] = (byte)((tfi[0x16] & 0xF) | ((tfi[0x17] & 0x7) << 4));
		smps[4] = (byte)((tfi[0x20] & 0xF) | ((tfi[0x21] & 0x7) << 4));

		// smps: byte 5-8 = rate scaling + attack rate
		// tfi: byte 5,F,19,23 = rate scaling
		// tfi: byte 6,10,1A,24 = attack rate
		smps[5] = (byte)((tfi[5] & 0x1F) | ((tfi[6] & 0x3) << 6));
		smps[6] = (byte)((tfi[0xF] & 0x1F) | ((tfi[0x10] & 0x3) << 6));
		smps[7] = (byte)((tfi[0x19] & 0x1F) | ((tfi[0x1A] & 0x3) << 6));
		smps[8] = (byte)((tfi[0x23] & 0x1F) | ((tfi[0x24] & 0x3) << 6));

		// smps: byte 9-C = decay rate + LFO enabled
		// tfi: byte 7,11,1B,25 = decay rate
		smps[9] = (byte)(tfi[7] & 0x1F);
		smps[0xA] = (byte)(tfi[0x11] & 0x1F);
		smps[0xB] = (byte)(tfi[0x1B] & 0x1F);
		smps[0xC] = (byte)(tfi[0x25] & 0x1F);

		// smps: byte D-10 = sustain rate + LFO enabled
		// tfi: byte 8,12,1C,26 = sustain rate
		smps[0xD] = (byte)(tfi[7] & 0x1F);
		smps[0xE] = (byte)(tfi[0x12] & 0x1F);
		smps[0xF] = (byte)(tfi[0x1D] & 0x1F);
		smps[0x10] = (byte)(tfi[0x26] & 0x1F);

		// smps: byte 11-14 = sustain level + release rate
		// tfi: byte A,13,1D,27 = release rate
		// tfi: byte B,14,1E,28 = sustain level
		smps[0x11] = (byte)((tfi[0xA] & 0xF) | ((tfi[0xB] & 0xF) << 4));
		smps[0x12] = (byte)((tfi[0x13] & 0xF) | ((tfi[0x14] & 0xF) << 4));
		smps[0x13] = (byte)((tfi[0x1D] & 0xF) | ((tfi[0x1E] & 0xF) << 4));
		smps[0x14] = (byte)((tfi[0x27] & 0xF) | ((tfi[0x28] & 0xF) << 4));

		// smps: byte 15-18 = sustain rate + LFO enabled
		// tfi: byte 4,E,18,22 = sustain rate
		smps[0x15] = (byte)(tfi[4] & 0x7F);
		smps[0x16] = (byte)(tfi[0xE] & 0x7F);
		smps[0x17] = (byte)(tfi[0x18] & 0x7F);
		smps[0x18] = (byte)(tfi[0x22] & 0x7F);

		Files.write(new File(in +".smp.dat").toPath(), smps);
	}
}
