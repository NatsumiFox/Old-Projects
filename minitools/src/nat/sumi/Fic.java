package nat.sumi;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;

public class Fic {
	private static File in;
	private static File out;

	public static void main(String[] args) {
		try {
			init();
			func();

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private static void init() throws IOException {
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

		System.out.println("Tell me the input file");
		in = new File(br.readLine());
		out = new File(in.getParent() +"/"+ in.getName() +".asm");
	}

	private static void func() {
		Main.write(out, "", false);

		for(String s : new String(Main.readBytes(in)).replace("\r", "").split("\n")){
			if(s.equals("")){
				Main.write(out, ",DOS_Text_NewLine", true);

			} else {
				String[] sp = s.split(" ");
				int indx = 0;

				while (indx < sp.length) {
					String add = "";
					int len = 0;

					while (true) {
						add += sp[indx] + ' ';
						len += sp[indx].length() + 1;
						indx++;

						if (indx >= sp.length || (len + sp[indx].length()) > 40) {
							break;
						}
					}

					Main.write(out, "\n"+ (add.length() > 1 ? "\t\tDOS_String '" + add.substring(0, add.length() - 1) +
							"'\n\t\t"+(add.length() != 41 ? "dc.b\tDOS_Text_NewLine" : "") : ""), true);
				}
			}
		}
	}
}
