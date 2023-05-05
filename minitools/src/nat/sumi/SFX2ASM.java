package nat.sumi;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

/**
 * Created by NAT on 19.10.19.
 */
public class SFX2ASM {
	public static void main(String[] asd) throws IOException, InterruptedException {
		System.setProperty("user.dir", "G:\\tools\\disasm\\musicpla");
		int off = 0x8000|0xEF33;
	//	String[] fucks = {"Credits"};
	//	int[] cocks = {0xC104};
	//	int i = 0;

		for (int i = 0x20;i <= 0x70;i ++) {
			Files.copy(new File("G:\\disassemblies\\Xeno\\sound\\sound fx\\sound" + Integer.toHexString(i) + ".bin").toPath(), new File("G:\\tools\\disasm\\musicpla\\music\\temp").toPath(), StandardCopyOption.REPLACE_EXISTING);
			ProcessBuilder pb = new ProcessBuilder("cmd", "/c", "cd", "G:\\tools\\disasm\\musicpla\\bin", "&&", "start", "/WAIT", "smps2asm.exe", "temp", "sonic2.sfx", ".", "0x" + Integer.toHexString(off));
			pb.redirectError();
			pb.redirectOutput();
			Process p = pb.start();
			p.waitFor();
			off += new File("G:\\tools\\disasm\\musicpla\\music\\temp").length();
			Files.copy(new File("G:\\tools\\disasm\\musicpla\\music\\temp.asm").toPath(),
					new File("G:\\tools\\music\\AMPS - AS\\driver\\sfx\\" + Integer.toHexString(i).toUpperCase() + ".asm").toPath(), StandardCopyOption.REPLACE_EXISTING);
		}
	}
}
