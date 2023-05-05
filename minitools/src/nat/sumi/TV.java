package nat.sumi;

import java.io.File;
import java.util.Random;

public class TV {
	static final int words = 276, addx = 0x20;
	static short last = 0;
	static Random r = new Random(System.currentTimeMillis());
	static int looptim = 8;

	public static void main(String[] args) {
		doSingle1(0x8, 0x3, 0x2, new File("G:\\s1mt\\#Natsumi\\HScroll1.asm"));
		doSingle1(0xA, 0x4, 0x2, new File("G:\\s1mt\\#Natsumi\\HScroll2.asm"));
		doSingle1(0x10,0x4, 0x2, new File("G:\\s1mt\\#Natsumi\\HScroll3.asm"));
		doSingle1(0x18,0x6, 0x2, new File("G:\\s1mt\\#Natsumi\\HScroll4.asm"));
		doSingle1(0x20,0x8, 0x2, new File("G:\\s1mt\\#Natsumi\\HScroll5.asm"));

		doSingle2(0xA, 0x3, 0x2, new File("G:\\s1mt\\#Natsumi\\HScroll6.asm"));
		doSingle2(0x10,0x4, 0x2, new File("G:\\s1mt\\#Natsumi\\HScroll7.asm"));
		doSingle2(0x18,0x8, 0x3, new File("G:\\s1mt\\#Natsumi\\HScroll8.asm"));
		looptim = 8*6;
		doSingle2(0x28,0xA, 0x4, new File("G:\\s1mt\\#Natsumi\\HScroll9.asm"));
	}

	private static void doSingle1(int max, int maxdiffh, int maxdiffn, File f) {
		Main.write(f, "", false);
		short[] lastA;
		short[] lastA2 = new short[words];

		for(int t = 0;t < looptim;t ++) {
			lastA = new short[words];
			for (int i = 0;i < words;i++) {
				switch (r.nextInt() % 16) {
					case 0:
						last = (short) (lastA2[i] + (r.nextInt() % maxdiffh));
						break;

					case 1:case 2:case 3:case 4:case 5:case 6:
						last = (short) (lastA2[i] + (r.nextInt() % maxdiffn));
						break;

					default:
						last = (short) (lastA2[i] + (r.nextInt() % 2));
						break;
				}

				if (last >= max) {
					last = (short) (max - maxdiffn);

				} else if (last <= -max) {
					last = (short) (-max + maxdiffn);
				}

				lastA[i] = last;
				Main.write(f, "\t\t dc.w " + getStr((short) (last + addx)) + "\n", true);
			}

			lastA2 = lastA;
			Main.write(f, "; ===========================================================================\n", true);
		}

		System.out.println(f.getAbsolutePath() +" done!");
	}

	private static void doSingle2(int max, int maxdiffh, int maxdiffn, File f) {
		Main.write(f, "", false);
		short[] lastA;

		for(int t = 0;t < looptim;t ++) {
			lastA = new short[words];
			for (int i = 0;i < words;i++) {
				switch (r.nextInt() % 8) {
					case 0:
						last = (short) (last + (r.nextInt() % maxdiffh));
						break;

					case 1:case 2:case 3:case 4:
						last = (short) (last + (r.nextInt() % maxdiffn));
						break;

					default:
						last = (short) (last + (r.nextInt() % 2));
						break;
				}

				if (last >= max) {
					last = (short) (max - maxdiffn);

				} else if (last <= -max) {
					last = (short) (-max + maxdiffn);
				}

				lastA[i] = last;
				Main.write(f, "\t\t dc.w " + getStr((short) (last + addx)) + "\n", true);
			}

			Main.write(f, "; ===========================================================================\n", true);
		}

		System.out.println(f.getAbsolutePath() +" done!");
	}

	private static String getStr(short last) {
		if(last < 0){
			return "-$"+ Integer.toHexString(-last).toUpperCase();

		} else if (last >= 0){
			return "$"+ Integer.toHexString(last).toUpperCase();
		}

		return last +"";
	}
}
