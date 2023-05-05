package nat.sumi;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

public class Equator {
	static final File asm = new File("G:\\Disassemblies\\S3K\\main.asm");
	static final File equ = new File("G:\\Disassemblies\\S3K\\equ.asm");
	static final File ram = new File("G:\\Disassemblies\\S3K\\ram.txt");

	static ArrayList<Equate> equates = new ArrayList<>();

	public static void main(String[] args) throws IOException {
		getEquates();
		createEquateFile();
		putEquates();
	}

	private static void createEquateFile() {
		Main.write(equ, "\trsset $FFFF0000\n", false);

		String lable = "\t", comment = "";
		int value = 0xFFFF0000;
		for(int i = value;i != 0;i ++){
			Equate e = findEquate(i);

			if(e != null){
				int len = i - value;
				if(len == 2){
					Main.write(equ, indent(lable + ":", "rs.w 1", comment), true);

				} else if(len == 4){
					Main.write(equ, indent(lable + ":", "rs.l 1", comment), true);

				} else if(len != 0){
					Main.write(equ, indent(lable + ":", "rs.b "+ getNumHex(len), comment), true);
				}

				value = e.getValue();
				lable = e.getLable();
				comment = e.getComment();
			}
		}

		int len = 0x0 - value;
		if(len == 2){
			Main.write(equ, indent(lable + ":", "rs.w 1", comment), true);

		} else if(len == 4){
			Main.write(equ, indent(lable + ":", "rs.l 1", comment), true);

		} else if(len != 0){
			Main.write(equ, indent(lable + ":", "rs.b "+ getNumHex(len), comment), true);
		}
	}

	private static String getNumHex(int len) {
		if(len < 9){
			return len +"";
		}

		return "$"+ Integer.toHexString(len).toLowerCase();
	}

	private static String indent(String s1, String s2, String s3) {
		int post = s1.length();
		post += 7 - (post & 7);
		s1 += "\t";

		for(int i = 0;i < (38 / 8) - (post / 8);i ++){
			s1 += "\t";
		}

		if(s2.length() < 8){
			s2 += "\t";
		}

		return s1 + s2 +"\t; "+ s3 +"\n";
	}

	private static Equate findEquate(int ram) {
		for(Equate e : equates){
			if(e.getValue() == ram){
				return e;
			}
		}

		return null;
	}

	private static void getEquates() {
		for(String s : new String(Main.readBytes(ram)).replace("\r", "").split("\n")){
			if(s.contains(" ")){
				String[] a = s.split(" ");
				int v = Integer.parseUnsignedInt(a[1].toUpperCase().replace("$", ""), 16);
				if(v < 0xFFFF0000){
					v |= 0xFF000000;
				}

				equates.add(new Equate(v, a[0], a[1].toUpperCase()));
			}
		}
	}

	private static void putEquates() {
		String[] d = new String(Main.readBytes(asm)).replace("\r", "").split("\n");
		Main.write(asm, "", false);

		for(String s : d){
			int indx = 0, adds = 0;
			while(s.indexOf('$', indx) > 0){
				int start, off = 1 + (start = s.indexOf("$", indx)), times = 0;
				char t = s.charAt(off);

				while((t >= '0' && t <= '9') || (t >= 'A' && t <= 'F')){
					times ++;

					if(s.length() -1 < ++ off){
						break;
					}

					t = s.charAt(off);
				}

				adds = off;

				if(times == 6 || times == 8) {
					boolean and = false;
					int result = Integer.parseUnsignedInt(s.substring(start + 1, off), 16);
					if (result >= 0xFF0000 && result <= 0xFFFFFF) {
						result |= 0xFF000000;
						and = true;
					}

					if (result >= 0xFFFF0000 && result < 0) {
						Equate e = null;

						for (Equate chk : equates) {
							if (result == chk.getValue()) {
								e = chk;
								break;

							} else if (result > chk.getValue()) {
								if (e == null) {
									e = chk;

								} else if (chk.getValue() > e.getValue()) {
									e = chk;
								}
							}
						}

						if (e == null) {
							//	System.err.println("WARNING! Encountered null Eqauate for line: "+ s);

						} else {
							int diff = result - e.getValue();
							String flag;
							if(!and) {
								flag = e.getLable() + (diff == 0 ? "" : "+" + (diff <= 9 ? "" + diff : "$" + Integer.toHexString(diff).toUpperCase()));

							} else {
								if(diff == 0){
									flag = e.getLable() +"&$FFFFFF";

								} else {
									flag = "("+ e.getLable() + "+" + (diff <= 9 ? "" + diff : "$" + Integer.toHexString(diff).toUpperCase()) +")&$FFFFFF";
								}
							}

							if (s.charAt(start - 1) == '(') {
								start --;
							}

							if (s.length() > off && s.charAt(off) == ')') {
								off ++;
							}

							s = s.substring(0, start) + flag + s.substring(off);
							adds = start + flag.length();
						}
					}
				}

				indx = adds;
			}

			Main.write(asm, s +"\n", true);
		}
	}

	private static class Equate {
		private final int value;
		private final String lable, comment;

		public Equate(int v, String s, String c){
			value = v;
			lable = s;
			comment = c;
		}

		public int getValue(){
			return value;
		}

		public String getLable(){
			return lable;
		}

		public String getComment(){
			return comment;
		}
	}
}
