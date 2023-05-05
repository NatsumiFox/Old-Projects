package nat.sumi;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by NAT on 19.10.07.
 */
public class FadeGen {
	public static float start = 0x50, end = 0x80, len = 20;

	public static void main(String[] args){
		float delta = start, offset = (end - start + 1) / len;
		ArrayList<Integer> fm = new ArrayList<>();
		ArrayList<Integer> psg = new ArrayList<>();

		for(int i = 0;i < len;i ++){
			fm.add(fmvolume(delta));
			psg.add(psgvolume(delta));
			delta += offset;
		}

		// calculate DAC deltas
		ArrayList<Integer> dac = new ArrayList<>();

		for(int i = 0;i < len;i += 4){
			int total = 0, success = 0;

			for(int x = 0;x < 4;x ++){
				if(x + i < len){
					success++;
					total += fm.get(x + i);
				}
			}

			// got total
			for(int x = 0;x < success;x ++)
				dac.add(total / success);
		}

		// format strings
		int line = 0;

		for(int i = 0;i < len;i ++) {
			if(line == 0)
				System.out.print("\tdc.b ");

			// write bytes
			System.out.print("$"+ hexbyte(fm.get(i) > 0x7F ? 0x7F : fm.get(i)) +", ");
			System.out.print("$"+ hexbyte(dac.get(i) > 0x7F ? 0x7F : dac.get(i)) +", ");
			System.out.print("$"+ hexbyte(psg.get(i) > 0x7F ? 0x7F : psg.get(i)) + (line == 3 || i == len - 1 ? "" : ",  "));

			if(++line == 4){
				line = 0;
				System.out.print("\n");
			}
		}

		System.out.print("\n");
	}

	private static int psgvolume(float v) {
		System.out.println(v +": "+ ((Math.E - Math.exp((0x80 - v) / 0x80)) / (Math.E - 1) * 0x80));
		return (int)((Math.E - Math.exp((0x80 - v) / 0x80)) / (Math.E - 1) * 0x80);
	}

	private static int fmvolume(float v) {
		return (int)((Math.exp(v / 0x80) - 1) / (Math.E - 1) * 0x80);
	}

	public static String hexbyte(int value){
		return String.format("%2s", Integer.toHexString(value & 0xFF)).replace(' ', '0').toUpperCase();
	}
}
