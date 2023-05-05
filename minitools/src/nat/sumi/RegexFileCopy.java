package nat.sumi;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexFileCopy {
	static final String indir = "G:\\Disassemblies\\S&K git\\Levels\\";
	static final String outdir = "G:\\Disassemblies\\S3Kdisassembly\\levels\\";
	static final Pattern inregex = Pattern.compile("([A-Z]*)\\\\Palettes\\\\([A-Za-z0-9\\s]*)\\.bin");
	static final String outregex = "$1\\Pal$2.bin";

	public static void main(String[] args) {
		chkFiles(new File(indir).listFiles());
	}

	private static void chkFiles(File[] files) {
		for(File f : files){
			if(f.isDirectory() && !f.isHidden()){
				chkFiles(f.listFiles());

			} else if(f.isFile() && !f.isHidden()){
				Matcher m = inregex.matcher(f.getAbsolutePath().replace(indir, ""));

				if(m.matches()){
					String fl = outdir + outregex.replace("$1", getLevel(m.group(1))).replace("$2", files.length == 1 ? "" : " " + m.group(2));

					try {
						if(new File(fl).exists()) {
							Files.delete(new File(fl).toPath());
						}

						Files.copy(f.toPath(), new File(fl).toPath());
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}

	private static String getLevel(String lvl) {
		switch (lvl){
			case "ALZ":
				return "2P - AL";

			case "BPZ":
				return "2P - BP";

			case "CGZ":
				return "2P - CG";

			case "DPZ":
				return "2P - DP";

			case "EMZ":
				return "2P - EM";

			default:
				return lvl;
		}
	}
}
