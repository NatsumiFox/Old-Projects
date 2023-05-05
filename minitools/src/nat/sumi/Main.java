package nat.sumi;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.StandardOpenOption;

public class Main {
	private static String name;
	private static File dir;
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
		System.out.println("Tell me the name of this project");
		name = br.readLine();

		System.out.println("Tell me the input directory");
		dir = new File(br.readLine());
		out = new File(dir.getParent() +"/"+ dir.getName() +".___data");
	}

	private static void func() {
		File[] dat = dir.listFiles();
		if(dat == null) return;

		write(out, "\t\tdc.w "+ ((dat.length & 1) == 0 ? dat.length : dat.length + 1) +"-1\n"+ name +":\n", true);

		int ctr = 0;

		for(File f : dat){
			if(f.isFile()) {
				int in = f.getName().lastIndexOf(".");
				ctr += 2;       // increment counter
				String nm = f.getName().replace(" ", "_").substring(0, in);
				if (nm.length() > 10) {
					nm = nm.substring(0, 10);
				}

				write(out, "\t\tdc.w ." + nm + "-" + name + "-" + ctr + "\n", true);
			}
		}

		write(out, "\n\n", true);

		for(File f : dat){
			if(f.isFile()) {
				int in = f.getName().lastIndexOf(".");
				String ext = f.getName().substring(in + 1).toUpperCase();
				String full = f.getName().substring(0, in);
				String nm = f.getName().replace(" ", "_").substring(0, in);
				if (nm.length() > 10) {
					nm = nm.substring(0, 10);
				}

				write(out, "." + nm + ":\tdc.b " + (ext + " " + full).length() + "-1" + (((ext + " " + full).length() & 1) == 0 ? ", 0" : "") + "\n" +
						"\t\tDOS_String '" + ext + " " + full + "'\n\n", true);
			}
		}
	}

	public static boolean write(File f, String data, boolean append) {
		File parent = f.getParentFile();
		if(parent != null) parent.mkdirs();

		try(PrintWriter out = new PrintWriter(new FileWriter(f, append))) {
			out.print(data);
			out.close();
			return true;

		} catch (IOException e) {
			e.printStackTrace();
		}

		return false;
	}

	public static boolean write(File f, byte[] data, boolean append) {
		File parent = f.getParentFile();
		if(parent != null) parent.mkdirs();

		try {
			Files.write(f.toPath(), data, append ? StandardOpenOption.APPEND : StandardOpenOption.TRUNCATE_EXISTING);
			return true;

		} catch (IOException e) {
			e.printStackTrace();
		}

		return false;
	}

	public static byte[] readBytes(File f) {
		try {
			return Files.readAllBytes(f.toPath());
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}
}
