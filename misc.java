package web.nat.sumi;

import javafx.util.Pair;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.awt.image.Raster;
import java.io.*;
import java.nio.file.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Random;

/*	String o = "";
	for(String s : new File("A:\\alarm\\").list()){
		o += "\n"+ new File(s).getName().replace(".mp3", "");
	}

	try (Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream("H:\\VS15\\antiafk_music.txt"), "UTF-8"))) {
		out.write(o.substring(1));
	}*/
/*public class ass {
	public static void main(String[] asd) throws IOException {
		for(File f : new File("G:\\Disassemblies\\shi\\font\\").listFiles()){
			byte[] d = Files.readAllBytes(f.toPath());
			byte[] o = new byte[2+((d.length - 2)*(2*((d[1]+1))))];
			o[0] = (byte)(((d[0]+1)*4)-1);
			o[1] = (byte)(((d[1]+1)*4)-1);
			int ox = 2, mul = o[0]+1, w = d[0];
			for(int x = 2;x < d.length;x++){
				ox = put((d[x] & 0xf0) >> 4, o, ox, mul);
				ox = put(d[x] & 0xf, o, ox, mul);
				if(w-- == 0){
					w = d[0];
					ox += (4*mul) - (o[0]+1);
				}
			}

			String fn = f.getName();
			Files.write(new File(f.getAbsolutePath().split(fn)[0] +'_'+ fn).toPath(), o);
		}
	}

	private static int put(int dat, byte[] o, int ox, int mul) {
		o[ox+mul] = (byte)(dat | dat << 4);
		o[ox+(mul*2)] = (byte)(dat | dat << 4);
		o[ox+(mul*3)] = (byte)(dat | dat << 4);
		o[ox] = (byte)(dat | dat << 4);
		ox++;
		o[ox+mul] = (byte)(dat | dat << 4);
		o[ox+(mul*2)] = (byte)(dat | dat << 4);
		o[ox+(mul*3)] = (byte)(dat | dat << 4);
		o[ox] = (byte)(dat | dat << 4);
		return ++ox;
	}
}*/
/*public class ass {
	public static void main(String[] asd) throws IOException {
		Path p = new File("G:\\Disassemblies\\s41\\sk\\Levels\\EMZ\\Collision\\1.bin").toPath();
		byte[] i = Files.readAllBytes(p);
		int of = 0x600;
		byte[] o = new byte[of];
		for(int x = 0;x < o.length;){
			o[x++] = i[x];
			if(x + of < i.length)
			o[x++] = i[x - 1 + of];
			else x++;
		}
		Files.write(p, o);
	}
}*/
/*public class ass {
	public static void main(String[] asd) throws IOException {
		byte[] i = Files.readAllBytes(new File("G:\\Disassemblies\\s41\\dat\\bg.map.unc").toPath());
		byte[] o = new byte[i.length];
		for(int x = 0;x < o.length;x += 2){
			putsh(o, x, subtile(getsh(i, x), 0x1ff));
		}
		Files.write(new File("G:\\Disassemblies\\s41\\dat\\bg.map.unc_").toPath(), o);
	}

		private static void putsh(byte[] o, int x, short s) {
			o[x] = (byte)(s >> 8);
			o[x + 1] = (byte)s;
		}

		private static short subtile(short s, int sub) {
			return (short)(0x6000|(s & 0xF800)|((s & 0x7FF) - sub));
		}

		private static short getsh(byte[] o, int x) {
			return (short)((o[x] << 8) | (o[x + 1] & 0xFF));
		}
	}*/
/*public class ass {
	public static void main(String[] asd) throws IOException {
		byte[] i = Files.readAllBytes(new File("G:\\Disassemblies\\s41\\dat\\bg.tiles.unc").toPath());
		byte[] o = new byte[i.length];
		for(int x = 0;x < o.length;x ++){
			o[x] = tra((i[x] >> 4) & 0xF, i[x] & 0xF);
		}
		Files.write(new File("G:\\Disassemblies\\s41\\dat\\bg.tiles.unc").toPath(), o);
	}

		private static byte tra(int a, int b) {
			if(a == 0xb) a = 0;
			if(b == 0xb) b = 0;
			return (byte)(((a << 4) & 0xF0) | (b & 0xF));
		}
	}
/*public class ass {
	public static void main(String[] asd) throws IOException {
		List<String> i = Files.readAllLines(new File("G:\\Disassemblies\\s41\\UPMEM\\u.asm").toPath());
		for(String s : i){
			System.out.println("\tshared "+ (s.substring(3, s.indexOf(':'))));
		}
	}
}*/
	/*public class ass {
		public static void main(String[] asd) throws IOException {
			double scale = 1000, step = 500D / 19D;
			System.out.println(scale + " " + step);
			scale -= step;

			for (int i = 1; i < 20; i++) {
				System.out.print("$" + Long.toHexString(47 - (int) Math.floor((scale / 1000D) * 48)).toUpperCase() + Long.toHexString((int) Math.floor((scale / 1000D) * 0x10000)).toUpperCase() + ", ");

				int delta = (int) ((scale / 1000D) * 0x10000), blank = 47 - ((int) Math.floor((scale / 1000D) * 48));
				int r = 0, x = 0, z = 0, d = 0;
				for(int p = 96;p >= 0;p--){
					d += delta;
					if(d < 0x10000){
						r ++;
						p--;
						r ++;
						p--;
					}
					d &= 0xFFFF;
					r ++;
					x++;
				}
				z = x +(blank*2);
				scale -= step;
			}
		}
	}*/
/*	public class ass {
		public static void main(String[] asd) throws IOException {
			System.out.print("s1/sonic1.asm ");
			l("G:\\Disassemblies\\s41\\s1\\");
			System.out.println();
		}

		private static void l(String s) {
			for(File f : new File(s).listFiles()) {
				if(f.isFile()) {
					int x = f.getName().lastIndexOf('.');
					if (x > 0) {
						String ex = f.getName().substring(x + 1);
						if (ex.equals("asm") || ex.equals("bin"))
							if(f.getName().contains(" ")) System.out.print("'"+ f.getAbsolutePath().replace("G:\\Disassemblies\\s41\\", "") + "' ");
							else System.out.print(f.getAbsolutePath().replace("G:\\Disassemblies\\s41\\", "") + ' ');
					}
				} else {
					l(f.getAbsolutePath());
				}
			}
		}
	}*/
/*	public class ass {
		public static String in = "G:\\hacks\\not mine\\igot\\artnem\\";
		public static void main(String[] asd) throws IOException {
			long sizenem = 0, sizekos = 0, sizeunc = 0;
			assert false;
			for(File f : new File(in).listFiles((dir, name)->name.endsWith(".bin"))){
				call("nemcmp -x", f.getAbsolutePath(), f.getAbsolutePath().replace(".bin", ".unc"));
				call("saxcmp", f.getAbsolutePath().replace(".bin", ".unc"), f.getAbsolutePath().replace(".bin", ".sax"));

				sizenem += f.length();
				sizekos += new File(f.getAbsolutePath().replace(".bin", ".sax")).length();
				sizeunc += new File(f.getAbsolutePath().replace(".bin", ".unc")).length();
			}

			System.out.println(sizenem +" "+ sizekos +" "+ sizeunc);
		}

		private static void call(String s, String fin, String fout) {
			try {
				Process p = Runtime.getRuntime().exec("G:\\hacks\\current\\s41\\bin\\FW_KENSC\\"+ s +" \""+ fin +"\" \""+ fout +"\"");
				p.waitFor();
			} catch (InterruptedException | IOException e) {
				e.printStackTrace();
			}
		}
	}*/
/*public class ass {
	public static void main(String[] asd) throws IOException, InterruptedException {
		System.setProperty("user.dir", "G:\\tools\\disasm\\musicpla");
		int off = 0x8000|0x5E30;
		//	String[] fucks = {"Credits"};
		//	int[] cocks = {0xC104};
		//	int i = 0;

		for (int i = 0x33;i <= 0xdb;i ++) {
		/* 	Files.copy(new File("G:\\hacks\\current\\Battle Race\\Sound\\SFX\\" + Integer.toHexString(i).toUpperCase() + ".bin").toPath(),
				    new File("G:\\tools\\disasm\\musicpla\\music\\temp").toPath(), StandardCopyOption.REPLACE_EXISTING);
			ProcessBuilder pb = new ProcessBuilder("cmd", "/c", "cd", "G:\\tools\\disasm\\musicpla\\bin", "&&", "start", "/WAIT", "smps2asm.exe",
					"temp", "sonic3k.sfx", ".", "0x" + Integer.toHexString(off));
			pb.redirectError();
			pb.redirectOutput();
			Process p = pb.start();
			p.waitFor();
			off += new File("G:\\tools\\disasm\\musicpla\\music\\temp").length();
			Files.copy(new File("G:\\tools\\disasm\\musicpla\\music\\temp.asm").toPath(),
					new File("G:\\tools\\music\\AMPS Sonic 2 April Fools\\AMPS\\sfx\\" + Integer.toHexString(i).toUpperCase() + ".s2a").toPath(), StandardCopyOption.REPLACE_EXISTING);*/
			/*System.out.println("$"+ Integer.toHexString(i).toUpperCase() +" - ");
		}
	}
}*/

/*public class ass {
	public static void main(String[] asd) throws IOException, InterruptedException {
		Path o = new File("A:\\#SSRG.txt").toPath();
		Files.write(o, "".getBytes());
		for(String a : Files.readAllLines(new File("C:\\Users\\NAT\\AppData\\Roaming\\HexChat\\logs\\BadnikNET\\#SSRG.log").toPath())){
			if(!a.startsWith("**** ENDING LOGGING AT") && a.length() >= 16){
				a = a.substring(16);

				if(a.startsWith("*")){
					if (!a.contains("has quit (") &&
							!a.contains("Now talking on") &&
							!a.contains("Topic for #SSRG") &&
							!a.contains(") has joined") &&
							!a.contains("sets mode") &&
							!(a.contains(" gives ") && a.contains(" status to ")) &&
							!a.contains("has left") &&
							!a.contains(" sets ban on") &&
							!a.contains(" has kicked ") &&
							!a.contains(" has changed the topic to")){
						Files.write(o, (a + '\n').getBytes(), StandardOpenOption.APPEND);
					}
				} else if(a.startsWith("<")){
					Files.write(o, (a + '\n').getBytes(), StandardOpenOption.APPEND);
				}
			}
		}
	}
}*/


/*public class ass {
	public static void main(String[] asd) throws IOException, InterruptedException {
		String derp = ", , , , , , , , , , , , , , , \r\n";
		int dpos = 0;
		double fr = 1;
		ArrayList<Byte> dat = new ArrayList<>();

		for(int speed = 0xC;speed >= 0;speed--, fr *= 1.1D + ((0xC - speed) * 0.0275D)){
			int f = (int)fr;

			while(f > 0x10){
				dat.add((byte)((speed<<4)|0xF));
				f -= 0x10;
			}

			dat.add((byte)((speed<<4)|(f - 1)));
		}

		System.out.println(fr);
		System.out.println();
		System.out.print("\tdc.b ");
		for(Byte b : dat){
			System.out.print("$"+ Integer.toHexString(b & 0xFF).toUpperCase() + (derp.substring(dpos, dpos + 2)));
			dpos += 2;

			if(dpos == 0x20){
				dpos = 0;
				System.out.print("\tdc.b ");
			}
		}

		System.out.print("\n\n\tdc.b ");
		dpos = 0;
		for(int x = dat.size() - 1;x >= 0;x --){
			System.out.print("$"+ Integer.toHexString(dat.get(x) & 0xFF).toUpperCase() + (derp.substring(dpos, dpos + 2)));
			dpos += 2;

			if(dpos == 0x20){
				dpos = 0;
				System.out.print("\tdc.b ");
			}
		}
	}
}*/



/*public class ass {
	public static File out = new File("G:\\hacks\\current\\S3K Battle Race\\Title Screen\\TSW Arrow Data.bin");

	public static void main(String[] asd) throws IOException, InterruptedException {
		byte[] o = new byte[0x24*0x20*2];
		derp(o, (byte)0x80, 0);
		derp(o, (byte)0, 0x24*0x20);
		Files.write(out.toPath(), o);
	}

	public static void derp(byte[] o, byte add, int off){
		for(int ln = 0;ln < 0x24;ln++){
			int hz = (0x20 / 2);
			int ctr = -(hz - ln);

			for(int x = 0;x < 0x20;x ++){
				if(x > hz) ctr --;
				else ctr++;

				if(ctr <= 0){
					o[(ln * 0x20) + x + off] = add;

				} else if(ctr >= 0x14){
					o[(ln * 0x20) + x + off] = (byte)(0x14+add);

				} else {
					o[(ln * 0x20) + x + off] = (byte)(ctr+add);
				}
			}
		}
	}
}*/


/*public class ass {
	public static File out = new File("G:\\hacks\\current\\S3K Battle Race\\Title Screen\\TSW Arrow Data.bin");

	public static void main(String[] asd) throws IOException, InterruptedException {
		int a = 0x32, b = 0;
		for(int i = 0;i < 0x100;i ++){
			a = calc(a);
			b += ((a & 0x80) == 0 ? a : a | 0xFF00);
			System.out.println(String.format("%03X", i + 1) +" = "+ String.format("%04X", b & 0xFFFF));
		}
	}

	private static int calc(int i) {
		boolean[] x = { true, true, false, true, true, false, true, false, true, false };
		int a = i, c = i;

		for(int z = 0;z < x.length;z ++){
			if(x[z]){
				c <<= 1;
			} else {
				a += c;
			}

			a &= 0xFF;
			c &= 0xFF;
		}

		return (a + 0x7F) & 0xFF;
	}
}*/

/*public class ass {
	public static File in = new File("G:\\RESEARCH\\Z80 ASM\\GEMS.ASM");
	public static File out = new File("G:\\RESEARCH\\Z80 ASM\\GEMS\\Z80.ASM");

	public static void main(String[] asd) throws IOException, InterruptedException {
		List<String> data = Files.readAllLines(in.toPath());
		Files.write(out.toPath(), "".getBytes());

		for(String s : data){
			int i = s.indexOf(";");
			if(i > 0){
				if(s.length() - i > 1) {
					Files.write(out.toPath(), (s.substring(i + 2) + '\n').getBytes(), StandardOpenOption.APPEND);

				} else {
					Files.write(out.toPath(), ("\n").getBytes(), StandardOpenOption.APPEND);
				}

			} else if(s.length() > 0) {
				Files.write(out.toPath(), (s + '\n').getBytes(), StandardOpenOption.APPEND);
			}
		}
	}
}*/

/*public class ass {
	public static File in = new File("G:\\hacks\\current\\S3K Battle Race\\Dump.It.txt");

	public static void main(String[] asd) throws IOException, InterruptedException {
		String last = "";
		for(String s : Files.readAllLines(in.toPath())){
			if(last.compareTo(s) > 0){
				System.out.println("'"+ last +"' > '"+ s +"'");
			}

			last = s;
		}
	}
}*/

/*public class ass {
	public static String in = "G:\\hacks\\misc\\S1 BetterDriver\\sound\\";
	public static File out = new File("G:\\tools\\disasm\\musicpla\\music\\pbank.bin");
	public static byte[] data = new byte[0];
	public static int psize = 0x19;

	public static void main(String[] asd) throws IOException {
		for(int i = 0xA0;i <= 0xD0;i ++){
			prc("sound" + String.format("%02X", i) +".bin");
		}

	/*	for(int i = 0x81;i <= 0x93;i ++){
			prc("music" + String.format("%02X", i) +".bin");
		}*/
/*
		Files.write(out.toPath(), data);
	}

	private static void prc(String fn) throws IOException {
		byte[] d = Files.readAllBytes(new File(in + fn).toPath());

		int z = 0;
		for(int a = rw(d, 0);a + psize <= d.length;a += psize, z++){
			byte[] p = new byte[psize];

			System.arraycopy(d, a, p, 0, psize);

			int pid = 0;
			boolean f = false;
			for(int x = 0;x < data.length;x += psize, pid++){
				boolean s = true;
				for(int i = 0;i < psize;i ++){
					if(p[i] != data[x + i]){
						s = false;
						break;
					}
				}

				if(s){
					f = true;
					break;
				}
			}

			if(!f){
				byte[] g = data;
				data = new byte[g.length + psize];
				System.arraycopy(g, 0, data, 0, g.length);
				System.arraycopy(p, 0, data, g.length, psize);
			}

			System.out.println(fn +": "+ String.format("%02X", z) +" -> "+ String.format("%02X", pid));
		}
	}

	private static int rw(byte[] d, int i) {
		return (d[i + 1] & 0xFF)|((d[i] << 8) & 0xFF00);
	}
}*/

/*public class ass {
	public static void main(String[] asd) throws IOException {
		boolean[] b = new boolean[0xA400];
		for (String s : Files.readAllLines(new File("D:\\Downloads\\Dump (1).txt").toPath())) {
			String[] z = s.replace(" ", "").split("-");
			int st = Integer.parseInt(z[0], 16), en = Integer.parseInt(z[1], 16);

			for(int i = st;i < en;i ++){
				if(!b[i])b[i] = true;
				else System.out.println("0x"+ Integer.toHexString(i).toUpperCase());
			}
		}

		int c = 0;
		for(int i = 0;i < 0xA400;i ++){
			if(!b[i]) c++;
		}
		System.out.println("no 0x"+ Integer.toHexString(c).toUpperCase());
	}
}*/

/*public class ass {
	static final File in = new File("G:\\RESEARCH\\Toy Story 3D\\graphics\\wall1.wrong.unc");
	static final File out = new File("G:\\RESEARCH\\Toy Story 3D\\graphics\\wall1.unc");

	public static void main(String[] asd) throws IOException {
		byte[] d = Files.readAllBytes(in.toPath());
		byte[] o = new byte[88*128];

		int x = 0, y = 0;
		for(int p = 0;p < o.length;p++){
			o[p] = d[(x&3) + ((y&7)*4) + ((x/4)*32) + ((y/8)*32*32)];

			if(++y >= 11*8){
				y = 0;
				x++;
			}
		}

		Files.write(out.toPath(), o);
	}
}*/

/*public class ass {
	public static void main(String[] asd) throws IOException {
		double f = 1;
		float delta = 0;
		int total = 0;

		for (int i = 0; i < 128; i++) {
			delta += f;
			int n = (int)delta;
			delta -= n;
			total += n;
			f += ((int)f / (45.3 + ((128 - i) / 2.56)));
			System.out.println(n +" "+ f);
		}

		System.out.println("tt "+ total +" "+ f);
	}
}*/
/*public class ass {
	public static void main(String[] asd) throws IOException, InterruptedException {
		String base = "G:\\hacks\\current\\Sonic music hack\\artnem\\";
		for(String s : new String[]{
				"Title Screen Foreground", "Title Screen Sonic", "Title Screen TM", "Shield",
				"Invincibility Stars", "GHZ Flower Stalk", "GHZ Swinging Platform", "GHZ Bridge",
				"GHZ Giant Ball", "GHZ Spiked Log", "GHZ Purple Rock", "GHZ Breakable Wall",
				"GHZ Edge Wall", "Spikes", "HUD", "HUD - Life Counter Icon",
				"Enemy Crabmeat", "Enemy Buzz Bomber", "Enemy Chopper", "Enemy Motobug",
				"Enemy Newtron", "Enemy Bomb", "Title Cards", "Rings",
				"Monitors", "Explosion", "Points", "Game Over",
				"Spring Horizontal", "Spring Vertical", "Giant Ring Flash", "Hidden Bonuses",
				"Signpost", "Lamppost", "Animal Rabbit", "Animal Chicken",
				"Animal Blackbird", "Animal Seal", "Animal Pig", "Animal Flicky",
				"Animal Squirrel", "Boss - Main", "Boss - Weapons", "Prison Capsule",
				"Boss - Exhaust Flame", "8x8 - GHZ1","8x8 - GHZ2",
		}){
			cvt("nemcmp", "-x", base + s, ".bin", ".unc");
			cvt("koscmp", "-m", base + s, ".unc", ".kosM");
		}
	}

	private static void cvt(String cmp, String mode, String file, String exti, String exto) throws InterruptedException, IOException {
		Process p = Runtime.getRuntime().exec("G:\\hacks\\archive\\s41\\bin\\FW_KENSC\\"+ cmp +".exe "+ mode +" \""+ file + exti +"\" \""+ file + exto +"\"");
		p.waitFor();
	}
}*/
/*public class ass {
	public static void main(String[] asd) throws IOException, InterruptedException {d
		for(File s : new File("G:\\hacks\\current\\Sonic music hack\\_maps\\").listFiles()){
			if(s.isFile()){
				String a = new String(Files.readAllBytes(s.toPath()));
				String crud = "";

				for(String l : a.split("\n")){
					if(l.matches("^[A-Za-z0-9_:@]+[\t ]*dc\\.b [$]?[A-F0-9]+.*")){
						crud += l.replace("dc.b", "dc.w") + "\n";

					} else if(l.matches("^[\t ]*dc\\.b [$]?[A-F0-9]+,[\t $]*[A-F0-9]+,[\t $]*[A-F0-9]+,[\t $]*[A-F0-9]+,[\t $]*[A-F0-9]+.*")){
						int i = l.lastIndexOf('$');
						int i2 = l.indexOf(';');
						if(i2 < 0) i2 = l.length();

						if(l.lastIndexOf(',', i2) < i && l.charAt(i + 1) >= '8' && (l.length() > i + 2)){
							crud += l.substring(0, i) +"$FF, "+ l.substring(i) + "\n";

						} else {
							if(l.lastIndexOf(',') > i){
								i = l.lastIndexOf(',');
								if(i2 < i && i2 > 0) i = l.lastIndexOf(',', l.indexOf(';'));
								if(l.charAt(i + 1) == ' ') i++;
								if(l.charAt(i + 1) == '\t') i++;
							} else i--;
							crud += l.substring(0, i) +" $00,"+ l.substring(i) + "\n";
						}

					} else crud += l + "\n";
				}

				Files.write(s.toPath(), crud.getBytes(), StandardOpenOption.TRUNCATE_EXISTING);
			}
		}
	}
}*/
/*public class ass {
	public static void main(String[] asd) throws IOException, InterruptedException {
		for(int i = 0;i < 0x100;i ++){
			byte v = (byte)(i / 14.0);
			if(v > 0xF) v = 0xf;

			if((i & 0xF) == 0) System.out.print("\tdc.b $"+ String.format("%02X", v));
			if((i & 0xF) == 0xF) System.out.println(", $"+ String.format("%02X", v));
			else System.out.print(", $"+ String.format("%02X", v));
		}
	}
}*/
/*public class ass {
	static final File in = new File("G:\\hacks\\current\\Sonic music hack\\artunc\\achi end.unc");
	static final File out = new File("G:\\hacks\\current\\Sonic music hack\\artunc\\achi end.unc");

	public static void main(String[] asd) throws IOException {
		byte[] d = Files.readAllBytes(in.toPath());
		byte[] o = new byte[d.length];

		for(int p = 0;p < o.length / 2;p+=32*2){
			System.arraycopy(d, p, o, p*2, 32);
			System.arraycopy(d, p+(d.length/2), o, p*2+32, 32);
			System.arraycopy(d, p+32, o, (p*2)+(32*2), 32);
			System.arraycopy(d, p+(d.length/2)+32, o, (p*2)+(32*3), 32);
		}

		Files.write(out.toPath(), o);
	}
}*/

/*public class ass {
	static final File in = new File("G:\\hacks\\current\\Sonic music hack\\artunc\\font.png");
	static final File out = new File("G:\\hacks\\current\\Sonic music hack\\artunc\\font1.unc");
	static final File out2 = new File("G:\\hacks\\current\\Sonic music hack\\artunc\\font2.unc");

	public static void main(String[] asd) throws IOException {
		BufferedImage r = ImageIO.read(in);
		int w = r.getWidth(), h = r.getHeight();
		if ((w & 7) != 0) {
			System.out.println("Image width must be divisible by 8");
			return;
		}
		if ((h & 7) != 0) {
			System.out.println("Image height must be divisible by 8");
			return;
		}

		byte[] o = new byte[(w / 8) * (h / 2)];
		for (int y = 0; y != 16; y += 8) {
			int p = 0;
			for (int ty = 0; ty < h; ty += 16)
				for (int tx = 0; tx < w; tx += 8)
					for (int py = 0; py < 8; py++) {
						byte n = 0;
						for (int px = 0; px < 8; px++) {
							n <<= 1;
							if (r.getRGB(tx + px, y + ty + py) != 0xFFFFFFFF)
								n++;
						}

						o[p++] = n;
					}
			if(y== 0) Files.write(out.toPath(), o);
			else Files.write(out2.toPath(), o);
		}
	}
}*/
/*public class ass {
	static final File in = new File("G:\\hacks\\current\\Sonic music hack\\_inc\\credits.txt");
	static final File outu = new File("G:\\hacks\\current\\Sonic music hack\\_inc\\credits.dat");
	static final File outk = new File("G:\\hacks\\current\\Sonic music hack\\_inc\\credits.kos");

	public static void main(String[] asd) throws IOException, InterruptedException {
		byte[] d = Files.readAllBytes(in.toPath());
		ArrayList<Byte> o = new ArrayList<>();

		int WIDTH = 38;
		int of = 0, lns = 0;
		boolean space = false;

		for(int i = 0;i < d.length;i ++){
			if(d[i] == 0xA){
				for (int a = of; a < WIDTH; a++)
					o.add((byte) 0x5F);

				of = 0;
				lns++;
				space = false;

			} else if(d[i] != 0xD){
				if (!space) {
					if (d[i] == 0x20) {
						space = true;
						o.add((byte) 0x5F);

					} else o.add((byte) (d[i] - 0x21));

					if (++of >= WIDTH){
						of = 0;
						lns++;
					}
				} else {
					if (d[i] == 0x20) {
						o.add((byte) 0x5F);

					} else {
						boolean f = false;
						for (int a = i; a < d.length && (a - i) + of < WIDTH; a++)
							if (d[a] == 0x20 || d[a] == 0x0D) {
								f = true;
								break;
							}

						if (f) o.add((byte) (d[i] - 0x21));
						else {
							for (int a = of; a < WIDTH; a++)
								o.add((byte) 0x5F);

							of = 0;
							lns++;
							space = false;
							o.add((byte) (d[i] - 0x21));
						}
					}

					if (++of >= WIDTH) {
						of = 0;
						lns++;
						space = false;
					}
				}
			}
		}

		byte[] oo = new byte[o.size()];
		for(int i = 0;i < oo.length;i ++)
			oo[i] = o.get(i);

		System.out.println(Integer.toHexString(lns*8));
		Files.write(outu.toPath(), oo);
		Process p = Runtime.getRuntime().exec("G:\\hacks\\archive\\s41\\bin\\FW_KENSC\\koscmp.exe \""+ outu.getAbsolutePath() +"\" \""+ outk.getAbsolutePath() +"\"");
		p.waitFor();
	}
}*/
/*public class ass {
	static final String in = "G:\\hacks\\current\\Yundong overworld\\screens\\Overworld\\dat\\sect\\";

	public static void main(String[] asd) throws IOException, InterruptedException {
		for(int i = 0;i < 64;i++) {
			Process p = Runtime.getRuntime().exec("G:\\hacks\\archive\\s41\\bin\\FW_KENSC\\koscmp.exe -x \"" + in + i +".kos" + "\" \"" + in + i +".unc" + "\"");
			p.waitFor();

			byte[] a = Files.readAllBytes(new File(in + i +".unc").toPath());
			byte[] b = Files.readAllBytes(new File(in + i +".dat").toPath());
			Files.delete(new File(in + i +".unc").toPath());

			if(a.length != b.length) System.out.println(i +" len diff "+ a.length +" vs "+ b.length);

			for(int x = 0;x < Math.min(a.length, b.length);x ++){
				if(a[x] != b[x]) System.out.println(i +" dat diff "+ a[x] +" vs "+ b[x]);
				if((x &1) == 0){
					if(a[x] > 0x11) System.out.println(i +" wtf oops "+ a[x] +" at "+ x);
				}
			}
		}
	}
}*/
/*public class ass {
	static final String[] notes = { "C", "Cs", "D", "Eb", "E", "F", "Fs", "G", "Ab", "A", "Bb", "B" };
	static final int[] frtbl = { 0x284, 0x2AB, 0x2D3, 0x2FE, 0x32D, 0x35C, 0x38F, 0x3C5, 0x3FF, 0x43C, 0x47C, 0x4C0 };

	static final int[] fratbl = {
			0x00, 0x02, 0x04, 0x07, 0x09, 0x0C, 0x0E, 0x11, 0x13, 0x15, 0x18, 0x1A, 0x1D, 0x1F, 0x22, 0x24,
			0x00, 0x02, 0x05, 0x07, 0x0A, 0x0C, 0x0F, 0x11, 0x14, 0x16, 0x19, 0x1B, 0x1E, 0x20, 0x23, 0x25,
			0x00, 0x02, 0x05, 0x08, 0x0A, 0x0D, 0x10, 0x12, 0x15, 0x18, 0x1A, 0x1D, 0x20, 0x22, 0x25, 0x28,
			0x00, 0x02, 0x05, 0x08, 0x0B, 0x0E, 0x11, 0x14, 0x17, 0x1A, 0x1D, 0x20, 0x23, 0x26, 0x29, 0x2C,
			0x00, 0x02, 0x05, 0x08, 0x0B, 0x0E, 0x11, 0x14, 0x17, 0x1A, 0x1D, 0x20, 0x23, 0x26, 0x29, 0x2C,
			0x00, 0x03, 0x06, 0x09, 0x0C, 0x0F, 0x13, 0x16, 0x19, 0x1C, 0x1F, 0x23, 0x26, 0x29, 0x2C, 0x2F,
			0x00, 0x03, 0x06, 0x0A, 0x0D, 0x10, 0x14, 0x17, 0x1B, 0x1E, 0x21, 0x25, 0x28, 0x2B, 0x2F, 0x32,
			0x00, 0x03, 0x07, 0x0A, 0x0E, 0x12, 0x15, 0x19, 0x1D, 0x20, 0x24, 0x27, 0x2B, 0x2F, 0x32, 0x36,
			0x00, 0x03, 0x07, 0x0B, 0x0F, 0x13, 0x16, 0x1A, 0x1E, 0x22, 0x26, 0x29, 0x2D, 0x31, 0x35, 0x39,
			0x00, 0x04, 0x08, 0x0C, 0x10, 0x14, 0x18, 0x1C, 0x20, 0x24, 0x28, 0x2C, 0x30, 0x34, 0x38, 0x3C,
			0x00, 0x04, 0x08, 0x0C, 0x11, 0x15, 0x19, 0x1D, 0x22, 0x26, 0x2A, 0x2E, 0x33, 0x37, 0x3B, 0x3F,
			0x00, 0x04, 0x09, 0x0D, 0x12, 0x16, 0x1B, 0x1F, 0x24, 0x28, 0x2D, 0x31, 0x36, 0x3A, 0x3F, 0x43,
	};

	static String rd(java.io.InputStream is) {
		java.util.Scanner s = new java.util.Scanner(is).useDelimiter("\\n");
		return s.hasNext() ? s.next() : "";
	}

	public static void main(String[] asd) throws IOException, InterruptedException {
		System.out.println("input note");
		String s = rd(System.in).toLowerCase();

		if(s.startsWith("n"))
			s = s.substring(1);

		int note = -1;
		for (int i = 0; i < notes.length; i++)
			if (s.startsWith(notes[i].toLowerCase())) {
				note = i;
				s = s.replace(notes[i].toLowerCase(), "");
			}

		if (note < 0) {
			System.out.println("Note wrong whoops");
			return;
		}

		int oct = Integer.parseInt(s) * 0x800;
		while(true) {
			System.out.println("input value");
			int val = Integer.parseInt(rd(System.in), 16);

			int xoff = (note + (val >> 4));
			int freq = frtbl[xoff % 0xC];
			int frac = fratbl[((note << 4) + val) % 0xC0];
			int roct = oct + (xoff > 0xC ? 0x800 : 0);

			System.out.println("$"+ Integer.toHexString(frac + freq + roct) +" n"+ notes[xoff % 0xC] + (roct / 0x800) +" "+ Integer.toHexString(frac));
		}
	}
}*/
/*public class ass {
	static final String s = "A better fucking joke >=(";

	public static void main(String[] asd) throws IOException, InterruptedException {
		int shit = new Random().nextInt() & 0xFF, z = shit;
		String o = "";

		for(int c = 0;c < s.length();c ++){
			while(shit != s.charAt(c)){
				int diff = s.charAt(c) - shit;

				if(diff > 0x10 || diff < 0){
					shit += 0x10;
					shit &= 0xFF;
					o += " ";

				} else if(diff > 0){
					shit ++;
					shit &= 0xFF;
					o += "\t";
				}
			}

			o += "\r";
		}

		byte[] x = o.getBytes();
		byte[] ou = new byte[x.length + 1];
		ou[0] = (byte)z;
		System.arraycopy(x, 0, ou, 1, x.length);
		Files.write(new File("G:\\tools\\disasm\\musicpla\\code\\x.bin").toPath(), ou);
	}
}*/
/*public class ass {

	public static void main(String[] asd) throws IOException, InterruptedException {
		byte[] b = Files.readAllBytes(new File("G:\\tools\\disasm\\musicpla\\code\\x.bin").toPath());

		byte a = b[0];
		for(int i = 1;i < b.length;i ++){
			if(b[i] == 0x20) a += 0x10;
			else if (b[i] == '\t') a++;
			else System.out.print((char)a);
		}
	}
}*/

/*public class ass {
	public static void main(String[] asd) throws IOException, InterruptedException {
		byte[] b = Files.readAllBytes(new File("G:\\RESEARCH\\Markey 2\\Art Wrong Cake.unc").toPath());
		byte[] o = new byte[b.length];

		for(int s = 0;s < 4;s ++)
			for(int x = 0;x < 4;x ++)
				for(int y = 0;y < 4;y++) {
					int in = ((s & 1) * 4) + ((s & 2) * 16) + x + (y * 8), out = ((s & 1) * 16) + ((s & 2) * 16) + (x * 4) + y;
					System.out.println("IN: "+ in +" OUT: "+ out);
					System.arraycopy(b, in * 32, o, out * 32, 32);
				}

		Files.write(new File("G:\\RESEARCH\\Markey 2\\Art Cake.unc").toPath(), o);
	}
}*/
/*public class ass {
	static final String in = "G:\\hacks\\current\\Battle Race\\Levels\\OAZ\\Data\\Act 2\\Collision.bin";

	public static void main(String[] asd) throws IOException, InterruptedException {
		byte[] f = Files.readAllBytes(new File(in).toPath());
		if(f.length < 0xC00) return;

		byte[] out = new byte[0x600];

		for(int i = 1, o = 0;i < 0x600;i += 2){
			out[o++] = f[i];
			out[o++] = f[i + 0x600];
		}

		Files.write(new File(in +".il").toPath(), out);
	}

}*/

/*public class ass {
	public static void main(String[] asd) throws IOException, InterruptedException {
		for(int i = 0x2800;i < 0x2900;i ++){
			System.out.print("|\\u"+ Integer.toHexString(i));
		}
		System.out.println();
	}

}*/
/*public class ass {
	static final String in = "G:\\tools\\art\\getart\\";
	static final String out = "G:\\hacks\\current\\Battle Race\\Title Screen\\Backgrounds\\MHZ1\\";
	static final int packsize = 0x400;

	public static void main(String[] asd) throws IOException, InterruptedException {
		byte[] art = convart(Files.readAllBytes(new File(in +"Art.bin").toPath()));
		Files.write(new File(out +"Art.bin").toPath(), art);

		byte[] pal = Files.readAllBytes(new File(in +"Palette.bin").toPath());
		byte[] realpal = new byte[0x14*2];

		for(int o = 0x8, i = 0;i < 0x20;i ++, o ++)
			realpal[o] = pal[i];
		for(int o = 0, i = 0x38;o < 8;i ++, o ++)
			realpal[o] = pal[i];

		Files.write(new File(out +"Palette.bin").toPath(), realpal);

		byte[] map = Files.readAllBytes(new File(in +"Map.bin").toPath());
		byte[] bg = new byte[0x1000], fg = new byte[0x1000];
		System.arraycopy(map, 0, bg, 0, 0x1000);
		System.arraycopy(map, 0x1000, fg, 0, 0x1000);

		// high plane, some of fg low plane
		int p = 0;
		for(int y = 0;y < 32;y++)
			for(int x = 0;x < 64;x ++, p += 2){
				swap(bg, p, x, y, true);
				swap(fg, p, x, y, false);
				if(planeB(x, y)) bg[p] |= 0x80;
				if(planeA(x, y)) fg[p] |= 0x80;
			}


		Files.write(new File(out +"Map_PlaneA.bin").toPath(), fg);
		Files.write(new File(out +"Map_PlaneB.bin").toPath(), bg);

		Process px = Runtime.getRuntime().exec("G:\\Java\\SoniPlane\\out\\artifacts\\build\\Mundi.exe *"+ h(packsize) +" \"" + out +"Map_PlaneA.bin\" \"" + out +"Map_PlaneB.bin\"");
		px.waitFor();

		System.out.println("Uncompressed: art "+ h(art.length / 32) +" tiles ("+ h(art.length) +" bytes), total data "+ (h(art.length + bg.length + fg.length + realpal.length)) +" bytes");
		if(art.length > 0x2aC0){
			System.out.println("Warning: Art file is too large. It is "+ h((art.length - 0x2ac0) / 32) +" tiles too big.");
		}

		long sa = new File(out +"Map_PlaneA.mun").length(), sb = new File(out +"Map_PlaneB.mun").length();
		System.out.println("Compressed: PlaneA "+ h(sa) +" Plane B "+ h(sb) +", total data "+ (h(art.length + sa + sb + realpal.length)) +" bytes");
	}

	private static String h(long i) {
		return Long.toHexString(i).toUpperCase();
	}

	private static byte[] convart(byte[] art) {
		byte[] aout = new byte[art.length];

		for(int i = 0;i < art.length / 32;i ++){
			System.arraycopy(art, swap(i) * 32, aout, i * 32, 32);
		}

		return aout;
	}

	private static void swap(byte[] arr, int p, int x, int y, boolean isa) {
		short val = (short)(((arr[p] & 0xFF) << 8) | (arr[p  + 1] & 0xFF));
		val ^= xor(val, x, y, isa);
		val = (short)swap(val);

		arr[p] = (byte)(val >> 8);
		arr[p + 1] = (byte)val;
	}

	private static short xor(short val, int x, int y, boolean isa) {
		for(int i = 0;i < xorlist.length; i++){
			if(xorlist[i] == (val & 0x7FF)) return 0;
		}

		return 0x2000;
	}

	private static int[] xorlist = new int[]{
		193, 200, 201, 197, 204, 196, 195, 203, 202, 229, 237, 219, 230,
	};

	private static int swap(int i) {
		int t = i & 0x7FF, y = i & 0xF800;
		for(int x = 0;x < swaplist.length;x += 2){
			if(swaplist[x] == t) return swaplist[x + 1] | y;
			if(swaplist[x + 1] == t) return swaplist[x] | y;
		}

		return i;
	}

	private static int[] swaplist = new int[]{
	};

	private static boolean planeA(int x, int y) {
		return false;
	}

	private static boolean planeB(int x, int y) {
		return false;
	}
}*/

/*public class ass {
	static final String in = "G:\\RESEARCH\\Friends\\pics\\";

	public static void main(String[] asd) throws IOException, InterruptedException {
		int i = 0;
		for(File s : new File(in).listFiles()){
			if(s.isDirectory() && ((s.getAbsolutePath() + " ").contains("\\3 "))){
				System.out.println(s.getAbsolutePath());
				Process p = Runtime.getRuntime().exec("G:\\RESEARCH\\Friends\\tool.exe -k -m=0x8000 \"" + s.getAbsolutePath() +"\\VRAM.bin" + "\" \"" + s.getAbsolutePath() +"\\VRAM.kosm" + "\"");
				p.waitFor();
			}
		}
	}
}*/
/*public class ass {
	static final String music = "G:\\disassemblies\\s3 93nov03\\s3.txt";

	public static void main(String[] asd) throws Exception {
		List<String> f = Files.readAllLines(new File(music).toPath());

		int x = 0x32;
		for(int i = 0;i < f.size();i ++){
			if(f.get(i).contains("sound/sfx/.smps")){
				f.set(i, f.get(i).replace("/.smps", "/"+ Integer.toHexString(x++).toUpperCase() +".smps"));
			}
		}

		Files.write(new File(music).toPath(), f);
	}
}*/

/*public class ass {
	static final String in = "G:\\disassemblies\\s3 93nov03\\";
	static final String music = "G:\\disassemblies\\s3 93nov03\\s3.txt";
	static final String folder = "G:\\tools\\disasm\\musicpla\\";

	public static void main(String[] asd) throws Exception {
		for(String line : Files.readAllLines(new File(music).toPath())) {
			if(!line.contains("/music/"))
				continue;

			String[] ln = line.split(" ");
			if (ln.length < 2)
				continue;
0
			int pos;
			try {
				pos = Integer.parseInt(ln[0], 16) & 0xFFFF | 0x8000;
			} catch (NumberFormatException ignored) {
				System.out.println("Failed to process line:");
				System.out.println("  " + line);
				continue;
			}

			String file = line.substring(ln[0].length()).trim();
			if(!Files.exists(new File(in + file).toPath())){
				System.out.println("File does not exist: "+ file);
				continue;
			}

			System.out.println("Processing "+ file);
			Files.copy(new File(in + file).toPath(), new File(folder + "music\\temp").toPath(), StandardCopyOption.REPLACE_EXISTING);

			Process p = Runtime.getRuntime().exec("cmd /c cd \""+ folder +"bin\" && smps2asm.exe temp Sonic3K"+ (file.contains("sfx") ? ".SFX" : "") +" "+
					new File(in + file).getName().replace(".smps", "").replace(" ", "") +" "+ pos);
			p.waitFor();

			System.out.println("saving to "+ file.replace("music", "musicasm").replace("sfx", "sfxasm").replace("smps", "asm"));
			Files.copy(new File(folder + "music\\temp.asm").toPath(), new File(in + file.replace("music", "musicasm").replace("sfx", "sfxasm").replace("smps", "asm")).toPath(), StandardCopyOption.REPLACE_EXISTING);
		}

		Files.delete(new File(folder + "music\\temp").toPath());
		Files.delete(new File(folder + "music\\temp.asm").toPath());
	}
}*/

/*public class ass {
	static String[] table = new String[]{
			"C", "Cs", "D", "Eb", "E", "F", "Fs", "G", "Ab", "A", "Bb", "B"
	};

	public static void main(String[] asd) throws Exception {
		for(int i = 0;i < 0xC0;i ++){
			System.out.println("=n"+ (i >= 0x60 ? "" : "c") + table[i % 0xC] + ((i % 0x60) / 0xC) +" 0x"+ Integer.toHexString(i).toUpperCase());
		}
	}
}*/

/*public class ass {
	static final String folder = "G:\\tools\\disasm\\musicpla\\";
	static Path ins = new File("G:\\disassemblies\\WonderBoyinMonsterWorld\\doc\\ins.bin").toPath();
	static Path rat = new File("G:\\disassemblies\\WonderBoyinMonsterWorld\\doc\\rat.bin").toPath();
	static int num = 0x29;

	public static void main(String[] asd) throws Exception {
		byte[] dins = Files.readAllBytes(ins);
		byte[] drat = Files.readAllBytes(rat);
		byte[] out = new byte[25];

		int pos = num * 0x13;
		out[0] = dins[pos++];

		System.out.println("Ops enable "+ Integer.toHexString(dins[pos++] & 0xFF).toUpperCase());
		System.out.println("pan mask "+ Integer.toHexString(dins[pos++] & 0xFF).toUpperCase());

		for(int i = 0;i < 4;i ++){
			out[21 + i] = dins[pos++];
			out[1 + i] = dins[pos++];

			int ros = dins[pos++] * 4;
			out[5 + i] = drat[ros++];
			out[9 + i] = drat[ros++];
			out[13 + i] = drat[ros++];
			out[17 + i] = drat[ros++];
		}

		int modoff = ((dins[pos++] & 0xFF) << 8) | (dins[pos++] & 0xFF);
		System.out.println("mod offset "+ Integer.toHexString(modoff).toUpperCase());

		Files.write(new File(folder + "music\\temp").toPath(), out);

		Process p = Runtime.getRuntime().exec("cmd /c cd \""+ folder +"bin\" && smps2asm.exe temp MegaPCM.Voice" +" .");
		p.waitFor();

		byte[] res = Files.readAllBytes(new File(folder + "music\\temp.asm").toPath());
		Files.delete(new File(folder + "music\\temp.asm").toPath());
		System.out.println(new String(res));
	}
}*/
/*public class ass {
	static final String folder = "G:\\disassemblies\\skdisasm-master\\s3.asm";
	static String[] replace = new String[]{
	};

	public static void main(String[] asd) throws Exception {
		int[] counts = new int[replace.length / 2];

//		for(File s : new File(folder).listFiles()) {
		File s = new File(folder);
			String file = new String(Files.readAllBytes(s.toPath()));

			for(int i = 0;i < replace.length;i += 2){
				file = file.replaceAll(replace[i], "d___"+ (i + 1));
			}

			for(int i = replace.length - 1;i >= 0;i -= 2){
			//	while(file.contains("d___"+ i)){
					file = file.replaceAll("d___"+ i, replace[i]);
			//		counts[i / 2]++;
			//	}
			}

			System.out.println("f> "+ s.getName());
			Files.write(s.toPath(), file.getBytes());
//		}

	//	for(int i = 0;i < replace.length;i += 2){
	//		System.out.println(Integer.toHexString(0x81 + (i / 2)).toUpperCase() +" "+ counts[i / 2] +" "+ replace[i] +" -> "+ replace[i + 1]);
	//	}
	}
}*/
/*public class ass {
	static final String folder = "G:\\tools\\music\\Sekrit-AMPS-AS\\AMPS\\code";

	public static void main(String[] asd) throws Exception {
		for(File s : new File(folder).listFiles()) {
			List<String> file = Files.readAllLines(s.toPath());
			boolean filen = false;

			int line = -1;
			for(String l : file){
				line++;
				boolean print = false;

				for(char c : l.toCharArray())
					if((c < 0x20 || c > 0x7E) && c != 9){
						print = true;
						System.out.print((int)c +" ");
					}

				if(print){
					if(!filen){
						filen = true;
						System.out.println("-- in file "+ s.getName());
					}

					System.out.println("line "+ line +": "+ l);
				}
			}
		}
	}
}*/
/*public class ass {
	static final String folder = "G:\\tools\\music\\Sekrit-AMPS-AS\\AMPS\\code";

	public static void main(String[] asd) throws Exception {
		for(File s : new File(folder).listFiles()) {
			List<String> file = Files.readAllLines(s.toPath());
			int dep = 0, line = -1;
			List<Integer> depln = new ArrayList<>();

			for(String l : file){
				line++;
				int p = 0;

				while(l.length() > p && (l.charAt(p) == ' ' || l.charAt(p) == '\t'))
					p++;

				if(l.length() > p + 2 && (l.charAt(p) & 0xDF) == 'I' && (l.charAt(p + 1) & 0xDF) == 'F'){
					// if
					dep++;
					depln.add(line);

				} else if(l.length() >= p + 5 && (l.charAt(p++) & 0xDF) == 'E' && (l.charAt(p++) & 0xDF) == 'N' &&
						(l.charAt(p++) & 0xDF) == 'D' &&(l.charAt(p++) & 0xDF) == 'I' && (l.charAt(p) & 0xDF) == 'F'){
					dep--;
					if(depln.size() > 0) depln.remove(depln.size() - 1);
				}
			}

			if(dep > 0){
				System.out.println(s.getName() +": Wrong amount of IF/ENDIF constructs! "+ dep +" too many. List of lines: ");
				for(Integer ln : depln){
					System.out.print(ln +", ");
				}

				System.out.println();
			} else if(dep < 0){
				System.out.println(s.getName() +": Wrong amount of IF/ENDIF constructs! "+ dep +" too few.");
			}
		}
	}
}*/
/*public class ass {
	static final String folder = "G:\\tools\\music\\Sekrit-AMPS-AS\\AMPS\\code";

	public static void main(String[] asd) throws Exception {
		for(File s : new File(folder).listFiles()) {
			Files.write(s.toPath(), new String(Files.readAllBytes(s.toPath())).replace("\r", "").getBytes());
		}
	}
}*/
/*public class ass {
	public static void main(String[] asd) throws Exception {
		int last = 0;
		int num = 0;

		for(int i = 0;i < 0xa;i ++) {
			System.out.print("\t\tdc.w ");
			for (int x = 0; x < 0x10; x++) {
				if(x != 0) System.out.print(", ");

				int r = 0;

				do {
					r = (int)((Math.random() * 1.7) + .3);
				} while(Math.abs(r - last) > 1 || (last == r && num >= 1));

				num = last == r ? num + 1 : 0;

				System.out.print(r);
				last = r;
			}
			System.out.println();
		}
	}
}
*/
/*public class ass {
	static final String in = "G:\\tools\\music\\AMPS Sonic 2 April Fools\\mpr-16011.ic1";
	static final String out = "G:\\tools\\music\\AMPS Sonic 2 April Fools\\mpr-16011.md";

	public static void main(String[] asd) throws Exception {
		byte[] d = Files.readAllBytes(new File(in).toPath());
		byte[] x = new byte[d.length];

		for(int i = 0;i < x.length;i += 2){
			x[i + 1] = d[i];
			x[i] = d[i + 1];
		}

		Files.write(new File(out).toPath(), x);
	}
}*/

/*public class ass {
	static final File in = new File("G:\\tools\\music\\AMPS Sonic 2 - 3k\\AMPS\\sfx list.asm");

	public static void main(String[] asd) throws Exception {
		List<String> d = Files.readAllLines(in.toPath());

		for(String s : d){
			String[] parts = s.split(";");
			parts = parts[0].split("-");

			if(parts.length == 2 && parts[1].trim().length() > 0){
				System.out.println("sfx_"+ parts[1].trim() +"\t\tds.b 1\t\t; "+ parts[0].trim());

			} else if(parts.length >= 1) {
				System.out.println("sfx_"+ parts[0].trim().replace("$", "") +"\t\t\t\tds.b 1\t\t; "+ parts[0].trim());
			}
		}
	}
}*/
public class ass {
	static final File in = new File("G:\\emu\\md\\Regen\\ram.dmp");
	static final byte LOADED = -0x80;
	static final byte FREE = 0x40;
	static final byte DISPLAY = 0x20;
	static final byte TAIL = 0x1;
	static final byte PREV = 0x2;
	static final byte DPREV = 0x4;
	static final byte ADDR = 0x8;
	static byte[] d;
	static final int playerobj = 0xAA1A;
	static final int objramend = 0xCD14;
	static final int objlen = 0x4A;
	static final int TailObj = 0xCF2A;
	static final int Tail = 0xCF2E;
	static final int Free = 0xCF30;
	static final int DisplayList = 0x9600;
	static final int DisplaySz = 0x8;

	public static void main(String[] asd) throws IOException, InterruptedException {
		d = Files.readAllBytes(in.toPath());
		byte[] obj = new byte[0x79];
		obj[0] = LOADED | PREV | ADDR;
		int id = 0;

		System.out.println("LIST LOADED");
		int addr = playerobj;
		System.out.println("xx "+ Integer.toHexString(addr) +" (p: "+ Integer.toHexString(sh(addr + 4)) +" n: "+ Integer.toHexString(sh(addr + 6)) +")");

		// find all loaded
		while(true){
			int ad2 = addr;
			addr = sh(addr + 6);
			System.out.println("-> "+ Integer.toHexString(addr) +" (i: "+ ((addr - playerobj) / objlen) +" p: "+ Integer.toHexString(sh(addr + 4)) +" n: "+ Integer.toHexString(sh(addr + 6)) +")");

			if(addr == TailObj){
				obj[id] |= TAIL;

				int t = sh(Tail);
				if(t != ad2){
					System.out.println("INCORRECT TAIL ("+ Integer.toHexString(t) +")");
				}
				break;
			}

			id = (addr - playerobj) / objlen;
			if(id < 0){
				System.out.println("UNDERFLOW: CHECK LOADED "+ Integer.toHexString(ad2) +" "+ Integer.toHexString(addr));
				break;

			} else if(id >= obj.length){
				System.out.println("OVERFLOW: CHECK LOADED "+ Integer.toHexString(ad2) +" "+ Integer.toHexString(addr));
				break;
			}

			if((obj[id] & LOADED) != 0){
				System.out.println("INFINITE LOOP: CHECK LOADED "+ Integer.toHexString(ad2) +" "+ Integer.toHexString(addr));
				break;
			}

			obj[id] |= LOADED;
			if(ad2 == sh(addr + 4)) obj[id] |= PREV;
		}

		addr = Free-4;

		// find all free
		System.out.println("LIST FREE");
		while(true){
			int ad2 = addr;
			addr = sh(addr + 4);
			System.out.println("-> "+ Integer.toHexString(addr) +" (i: "+ ((addr - playerobj) / objlen) +" p: "+ Integer.toHexString(sh(addr + 4)) +" n: "+ Integer.toHexString(sh(addr + 6)) +")");

			if(addr == 0){
				obj[id] |= TAIL;
				break;
			}

			id = (addr - playerobj) / objlen;
			if(id < 0){
				System.out.println("UNDERFLOW: CHECK FREE "+ Integer.toHexString(ad2) +" "+ Integer.toHexString(addr));
				break;

			} else if(id >= obj.length){
				System.out.println("OVERFLOW: CHECK FREE "+ Integer.toHexString(ad2) +" "+ Integer.toHexString(addr));
				break;
			}

			if((obj[id] & FREE) != 0){
				System.out.println("INFINITE LOOP: CHECK FREE "+ Integer.toHexString(ad2) +" "+ Integer.toHexString(addr));
				break;
			}

			if((obj[id] & LOADED) != 0){
				System.out.println("ALREADY LOADED: CHECK FREE "+ Integer.toHexString(ad2) +" "+ Integer.toHexString(addr));
				break;
			}

			obj[id] |= FREE;
		}

		// process display lists
		for(int i = 0;i < 8;i ++){
			addr = DisplayList + (i * DisplaySz) - 8;

			if(sh(DisplayList + 0x8 + (i * DisplaySz)) != 0 || sh(DisplayList + 0x6 + (i * DisplaySz)) != 0){
				System.out.println("DISPLAY LAYER "+ i +" AT "+ Integer.toHexString(addr) +" OK");

			} else System.out.println("DISPLAY LAYER "+ i +" AT "+ Integer.toHexString(addr) +" WRONG "+
					Integer.toHexString(DisplayList + 6 + (i * DisplaySz)) +" "+ Integer.toHexString(DisplayList + 8 + (i * DisplaySz)));

			while(true){
				int ad2 = addr;
				addr = sh(addr + 8);
				id = (addr - playerobj) / objlen;
				System.out.println("-> "+ Integer.toHexString(addr) +" (i: "+ id +" p: "+ Integer.toHexString(sh(addr + 0xA)) +" n: "+ Integer.toHexString(sh(addr + 8)) +")");

				if(addr == DisplayList - 4 + (i * DisplaySz)){
					int t = sh(DisplayList + 0x6 + (i * DisplaySz));
					if(t != ad2){
						System.out.println("INCORRECT TAIL ("+ Integer.toHexString(t) +")");
					}
					break;
				}

				if(id < 0){
					System.out.println("UNDERFLOW: CHECK LOADED "+ Integer.toHexString(ad2) +" "+ Integer.toHexString(addr));
					break;

				} else if(id >= obj.length){
					System.out.println("OVERFLOW: CHECK LOADED "+ Integer.toHexString(ad2) +" "+ Integer.toHexString(addr));
					break;
				}

				if((obj[id] & DISPLAY) != 0){
					System.out.println("INFINITE LOOP: CHECK LOADED "+ Integer.toHexString(ad2) +" "+ Integer.toHexString(addr));
					break;
				}

				obj[id] |= DISPLAY;
				if(ad2 == sh(addr + 0xA)) obj[id] |= DPREV;
			}
		}

		for(int p = playerobj;p < objramend;p += objlen)
			if(sh(p) != 0 || sh(p + 2) != 0)
				obj[(p - playerobj) / objlen] |= ADDR;

		for(int i = 0;i < obj.length;i ++){
			if((obj[i] & (FREE | LOADED)) == 0){
				System.out.println("OBJ "+ Integer.toHexString(playerobj + (i * objlen)) +": LOST");
			}

			if((obj[i] & LOADED) != 0 && (obj[i] & PREV) == 0){
				System.out.println("OBJ "+ Integer.toHexString(playerobj + (i * objlen)) +": INCORRECT PREV PTR");
			}

			if((obj[i] & LOADED) != 0 && (obj[i] & DISPLAY) != 0 && (obj[i] & DPREV) == 0){
				System.out.println("OBJ "+ Integer.toHexString(playerobj + (i * objlen)) +": INCORRECT DISPLAY PREV PTR");
			}
		}
	}

	private static int sh(int i) {
		return (((d[i] & 0xFF) << 8) | (d[i + 1] & 0xFF)) ;
	}
}
/*public class ass {
	static final String in = "G:\\RESEARCH\\68k decoder\\test.txt";
	static final String out = "G:\\RESEARCH\\68k decoder\\test.bin";

	public static void main(String[] asd) throws Exception {
		byte[] d = Files.readAllBytes(new File(in).toPath());

		FileOutputStream str = new FileOutputStream(out);

		for(int i = 0;i < 0x10000;i ++){
			byte[] buf = new byte[2 + ((d[i] - '0') * 2)];
			buf[0] = (byte)(i >> 8);
			buf[1] = (byte)i;

			str.write(buf);
		}

		str.close();
	}
}*/
/*public class ass {
	public static void main(String[] asd) throws Exception {
		for(File f : new File("G:\\tools\\music\\AMPS 3k\\AMPS\\sfx").listFiles()){
			List<String> file = Files.readAllLines(f.toPath());

			for(int i = 0;i < file.size();i ++)
				if(file.get(i).startsWith("\t; Generated by SMPS2ASM Scripter"))
					file.remove(i);

				Files.write(f.toPath(), file, StandardOpenOption.TRUNCATE_EXISTING);
		}
	}
}
*/
