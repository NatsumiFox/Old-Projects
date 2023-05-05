package nat.sumi;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class UnMapper {
	static final File in = new File("G:\\tools\\art\\getart\\Art.bin");
	static final File map = new File("G:\\tools\\art\\getart\\Map.bin");
	static final File out = new File("G:\\RESEARCH\\68k decoder\\font.unc");

	public static void main(String[] args) throws IOException {
		main(out);
	}

	public static void main(File out) throws IOException {
		byte[] d = Main.readBytes(in);
		byte[] m = Main.readBytes(map);
		DataOutputStream fout = new DataOutputStream(new FileOutputStream(out));

		assert m != null;
		for(int i = 0;i < m.length;i += 2){
			int mp = readShort(m, i), md = mp & 0x1800;
			mp = (mp & 0x3FF) * 32;

			switch (md){
				case 0:
					doNorm(fout, d, mp);
					break;

				case 0x800:
					dohFlip(fout, d, mp);
					break;

				case 0x1000:
					dovFlip(fout, d, mp);
					break;

				case 0x1800:
					dohvFlip(fout, d, mp);
					break;
			}
		}
	}

	private static void doNorm(DataOutputStream fout, byte[] data, int off) throws IOException {
		byte[] mv = new byte[32];
		System.arraycopy(data, off, mv, 0, 32);
		fout.write(mv);
	}

	private static void dohFlip(DataOutputStream fout, byte[] data, int off) throws IOException {
		for(int i = 0;i < 32;i += 4){
			System.out.println("h "+ String.format("%08X", readInt(data, off + i)) +" "+ String.format("%08X", invertBits(readInt(data, off + i))));
			fout.writeInt(invertBits(readInt(data, off + i)));
		}
		System.out.println();
	}

	private static void dovFlip(DataOutputStream fout, byte[] data, int off) throws IOException {
		for(int i = 32-4;i >= 0;i -= 4){
			System.out.println("v "+ String.format("%08X", readInt(data, off + i)));
			fout.writeInt(readInt(data, off + i));
		}
		System.out.println();
	}

	private static void dohvFlip(DataOutputStream fout, byte[] data, int off) throws IOException {
		for(int i = 32-4;i >= 0;i -= 4){
			System.out.println("hv "+ String.format("%08X", readInt(data, off + i)) +" "+ String.format("%08X", invertBits(readInt(data, off + i))));
			fout.writeInt(invertBits(readInt(data, off + i)));
		}
		System.out.println();
	}

	private static short readShort(byte[] d, int i) {
		return (short) ((d[i] << 8) & 0xFF00 | (d[i + 1] & 0xFF));
	}

	private static int readInt(byte[] d, int i) {
		return d[i] << 24 | (d[i + 1] & 0xFF) << 16 | (d[i + 2] & 0xFF) << 8 | (d[i + 3] & 0xFF);
	}

	private static int invertBits(int i) {
		return (((i << 28) & 0xF0000000) |
				((i << 20) & 0xF000000) |
				((i << 12) & 0xF00000) |
				((i << 4)  & 0xF0000) |
				((i >> 4)  & 0xF000) |
				((i >> 12) & 0xF00) |
				((i >> 20) & 0xF0) |
				((i >> 28) & 0xF));
	}
}
