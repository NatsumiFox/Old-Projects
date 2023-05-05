package nat.sumi;

public class SegaLogoScaler {
	public static void main(String[] args) {
		double scale = 1000, step = 500D / 19D;
		System.out.println(scale + " " + step);
		scale -= step;

		for (int i = 1; i < 20; i++) {
			System.out.print("$" + Long.toHexString(47 - (int) Math.floor((scale / 1000D) * 48)).toUpperCase() + Long.toHexString((int) Math.floor((scale / 1000D) * 0x10000)).toUpperCase() + ", ");

			int delta = (int) ((scale / 1000D) * 0x10000), blank = 47 - ((int) Math.floor((scale / 1000D) * 48));
			int r = 0, x = 0, z = 0, d = 0;
			for (int p = 96; p >= 0; p--) {
				d += delta;
				if (d < 0x10000) {
					r++;
					p--;
					r++;
					p--;
				}
				d &= 0xFFFF;
				r++;
				x++;
			}
			z = x + (blank * 2);
			scale -= step;
		}
	}
}
