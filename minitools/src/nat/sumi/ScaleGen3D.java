package nat.sumi;

import java.io.*;
import java.nio.file.Files;
import java.util.ArrayList;

/**
 * Created by NAT on 17.09.15.
 */
public class ScaleGen3D {
	static final File out = new File("G:\\RESEARCH\\Toy Story 3D\\graphics\\codes.asm");
	static final File outs = new File("G:\\RESEARCH\\Toy Story 3D\\graphics\\scales.asm");
	static final float HEIGHT = 11*8;
	static double zd, zs;
	static int zp;

	public static void main(String[] args) throws IOException {
		ArrayList<Integer> ints = new ArrayList<>();

		{
			double f = 1;
			double delta = 0;
			for (int i = 0; i < 128; i++) {
				delta += f;
				for (int x = (int) delta; x > 0; x--) {
					ints.add(128 - i);
					delta--;
				}
				f += ((int)f / (45.3 + ((128 - i) / 2.56)));
			}
		}

		{
			String q = "DeltaArray:\n";
			int z = 0;
			for (int i = 256 - 1; i >= 0; i--) {
				int x = (int) (((float) ints.get(255 - i) / HEIGHT) * 0x10000) - 1;
				if (x > 0xFFFF) x = 0xFFFF;
				if ((z & 7) == 0) q += "\tdc.w $" + String.format("%04X", x);
				else if ((z & 7) == 7) q += ", $" + String.format("%04X", x) + "; " + (256 - i) +'\n';
				else q += ", $" + String.format("%04X", x);
				z++;
			}

			z = 0;
			q += "\nDeltaArray2:\n";
			for (int i = 256 - 1; i >= 0; i--) {
				int x = (int) (((float) ints.get(255 - i) / HEIGHT) * 0x10000) - 0x10000;
				if (x < 1) x = 0;
				if ((z & 7) == 0) q += "\tdc.w $" + String.format("%04X", x);
				else if ((z & 7) == 7) q += ", $" + String.format("%04X", x) + "; " + (256 - i) +'\n';
				else q += ", $" + String.format("%04X", x);
				z++;
			}

			Files.write(outs.toPath(), q.getBytes());
		}

		long size = 128*4;
		long high = 0, low = 0xFFFF;
		try(FileWriter fw = new FileWriter(out.getAbsolutePath(), false);
		    BufferedWriter bw = new BufferedWriter(fw);
		    PrintWriter s = new PrintWriter(bw)) {
			s.write("\tdc.l Draw_0\n");
			s.write("DrawArray:\n");

				int z = 0;
				for (int i = 1; i <= 128; i++) {
					if ((z & 3) == 0) s.write("\tdc.l Draw_" + i + ", ");
					else if ((z & 3) == 3) s.write("Draw_" + i + "\n");
					else s.write("Draw_" + i + ", ");
					z++;
				}

			// do special Draw_0
			{
				long cycles = 0;
				int a4 = -1;
				s.write("\nDraw_0:\n");
				for (int i = 0; i < HEIGHT; i++) {
					s.write("\tmove.b\td7," + (a4 < 0 ? "(a4)+" : a4 + "(a4)") + "\n");
					cycles += a4 < 0 ? 8 : 12;
					a4 += 4;
					size += a4 < 0 ? 2 : 4;
				}

				cycles += 16;
				size += 2;
				s.write("\trts\t; cycles for this loop " + cycles + "\n");
			}

			for (int i = 1; i <= 128; i++) {
				ArrayList<PixelInfo> zi = new ArrayList<>();
				{
					zd = 0;
					zs = i / HEIGHT;
					zp = i - (int)HEIGHT;
					int za = zp;
				//	if(zp > 0) zp = 0;

					for (int y = 1; y <= HEIGHT; y++) {
						if (zp < 0) zp++;
						else {
							zd += zs;
							if(zd >= 2.0){
								zi.add(new PixelInfo(zp, y));
								zd -= 2;

							} else if(zd >= 1.0){
								zi.add(new PixelInfo(zp++, y));
								zd--;

							} else {
								while(zd < 1.0 && zp < 128-1){
									zp++;
									zd += zs;
								}

								zi.add(new PixelInfo(zp++, y));
								zd--;
							}
						}
					}

					if (zp < HEIGHT || zp > 128) {
						System.out.println(i + " " + zp + " " + za + " " + zs);
					}
				}

				// writeout
				s.write("\nDraw_" + i + ":\n");

				int a4 = -1;
				int y = zi.get(0).outy, len = 1, zif = 0, ofi = 1;
				long cycles = 0;
				while (y - len > 0) {
					s.write("\tmove.b\td7," + (a4 < 0 ? "(a4)+" : a4 + "(a4)") + "\n");
					cycles += a4 < 0 ? 8 : 12;
					len++;
					a4 += 4;
					size += a4 < 0 ? 2 : 4;
				}

				while (true) {
					PixelInfo pi = zi.get(zif++);
					int ilen = pi.iny - ofi;

					boolean index = false;
					if (ilen > 0) {
						int off1 = zif >= zi.size() ? 0xFFF : zi.get(zif).iny - ofi,
								off11 = zif >= zi.size() ? 1 : zi.get(zif).iny - pi.iny,
								off2 = zif + 1 >= zi.size() ? 1 : zi.get(zif + 1).iny - zi.get(zif).iny,
								off3 = zif + 2 >= zi.size() ? 1 : zi.get(zif + 2).iny - zi.get(zif + 1).iny,
								off4 = zif + 3 >= zi.size() ? 1 : zi.get(zif + 3).iny - zi.get(zif + 2).iny;
						index = (off1 + off2 >= 4 && ofi != 1) &&
								(ilen <= 8 ? (off11 + off2 + off3 > 4 || zif + 1 >= zi.size()) : (off11 + off2 + off3 + off4 > 5 || zif + 3 >= zi.size()));

						if (ilen <= 8 && !index) {
							ofi = pi.iny;
							s.write("\taddq.w\t#" + ilen + ",a3\n");
							cycles += 8;
							size += 2;

						} else if (!index) {
							ofi = pi.iny;
							s.write("\tadd.w\t#" + ilen + ",a3\n");
							cycles += 12;
							size += 4;
						}
					}

					if (index) {
						s.write("\tmove.b\t" + ilen + "(a3)," + (a4 < 0 ? "(a4)+" : a4 + "(a4)") + "\n");
						cycles += a4 < 0 ? 16 : 20;
						size += a4 < 0 ? 4 : 6;

					} else {
						if (zif < zi.size() && zi.get(zif).iny > ofi) {
							s.write("\tmove.b\t(a3)+," + (a4 < 0 ? "(a4)+" : a4 + "(a4)") + "\n");
							ofi++;
							cycles += a4 < 0 ? 12 : 16;
							size += a4 < 0 ? 2 : 4;

						} else {
							s.write("\tmove.b\t(a3)," + (a4 < 0 ? "(a4)+" : a4 + "(a4)") + "\n");
							cycles += a4 < 0 ? 12 : 16;
							size += a4 < 0 ? 2 : 4;
						}
					}

					if (zif >= zi.size()) break;
					y = zi.get(zif).outy;
					a4 += 4;
				}

				cycles += 16;
				size += 2;
				s.write("\trts\t; cycles for this loop " + cycles + "\n");
				if (y > HEIGHT) System.out.println(i);

				if (cycles > high) high = cycles;
				if (cycles < low) low = cycles;
			}

			s.write("\n; size is $" + String.format("%04X", size) + "\n");
		}

		System.out.println("Highest cycles: "+ high +". Lowest cycles: "+ low +". Size: $"+ String.format("%04X", size));
	}

	private static class PixelInfo {
		int outy, iny;

		PixelInfo(int iy, int oy){
			outy = oy;
			iny = iy;
		}
	}
}
