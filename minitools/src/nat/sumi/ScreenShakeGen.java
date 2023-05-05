package nat.sumi;

import java.io.File;
import java.util.Random;

public class ScreenShakeGen {
	static final File out = new File("G:\\s1mt\\misc\\ScreenShake.asm");
	static final int max = 3, min = 1, len = 0x40;
	static final Random r = new Random(System.currentTimeMillis());

	public static void main(String[] args) {
		int balance = 0;
		Main.write(out, "", false);

		for(int i = 0;i < len -1;i ++){
			int next = 0;

			if(balance >= 0){
				next = -Math.abs(r.nextInt() % (max - min)) - min;

			} else if (balance < 0){
				next = Math.abs(r.nextInt() % (max - min)) + min;
			}

			balance += next;
			Main.write(out, "\n\tdc.w $"+ getStr((short)next), true);
		}

		Main.write(out, "\n\tdc.w $"+ getStr((short)(-balance)), true);
	}

	private static String getStr(short num) {
		return String.format("%04X", num);
	}
}
