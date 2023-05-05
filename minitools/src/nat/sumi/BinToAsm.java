package nat.sumi;

import java.io.File;

public class BinToAsm {
	private final static File in = new File("G:\\Disassemblies\\blank\\menutext.bin"), out = new File("G:\\Disassemblies\\blank\\menutext.asm");

	public static void main(String[] args) {
		Main.write(out, "", false);
		byte[] data = Main.readBytes(in);

		assert data != null;
		for(int o = 4;o < data.length;o += 4){
			Main.write(out, "\n\tdc.l $"+ getStr(getInt(data, o - 4)), true);

			for(int i = 0;i < 7;i ++, o += 4){
				Main.write(out, ", $"+ getStr(getInt(data, o)), true);
			}
		}
	}

	private static int getInt(byte[] data, int o) {
		return  ((data[o + 0] & 0xFF) << 24) |
				((data[o + 1] & 0xFF) << 16) |
				((data[o + 2] & 0xFF) << 8) |
				(data[o + 3] & 0xFF);
	}

	private static String getStr(int num) {
		return String.format("%08X", num);
	}
}
