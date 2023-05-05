package nat.sumi;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

public class CardsRuleConv {
	static final File f = new File("G:\\hacks\\current\\cards\\Games\\BlackMaria.");

	public static void main(String[] args) throws IOException {
		byte[] in = Files.readAllBytes(new File(f +"txt").toPath());
		byte[] outt = new byte[in.length *2];

		int x = 0, w = 40;
		for(int i = 0;i < in.length;i ++){
			byte y = getch(in[i]);
			outt[x++] = y;

			if(y == 0 && getNextWord(in, i + 1) >= w){
				outt[x-1] = -1;
				outt[x++] = 0x40;
				outt[x++] = 0x40;
				w = 40;

			} else if (y == -1){
				w = 40;

			} else {
				w--;
			}
		}

		byte[] out = new byte[x+1];
		System.arraycopy(outt, 0, out, 0, x);
		Files.write(new File(f +"dat").toPath(), out);
	}

	private static int getNextWord(byte[] in, int i) {
		int s = 0;
		while(getch(in[i]) > 0){
			s++;
			i++;
		}

		return s;
	}

	public static byte getch(byte b) {
		if (b >= '0' && b <= '9') {
			return (byte) (b - ('0' - 0x10));

		} else if (b >= 'a' && b <= 'z') {
			return (byte) (b - ('a' - 0x21));

		} else if (b >= 'A' && b <= 'Z') {
			return (byte) (b - ('A' - 0x21));

		} else if (b == '\n'){
			return -1;

		} else if (b == ' '){
			return 0;
		}

		return (byte)(b - '!' + 1);
	}
}
