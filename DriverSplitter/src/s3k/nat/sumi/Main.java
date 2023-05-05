package s3k.nat.sumi;

import java.io.*;

public class Main {
	static File in, out1, out2;
	static int off;

    public static void main(String[] args){
	    try {
		    main0(args);
	    } catch (IOException e) {
		    e.printStackTrace();
		    System.out.println("Could not split! Error report:\n"+ e.getLocalizedMessage());
	    }
    }

	private static void main0(String[] args) throws IOException {
		if(args.length != 4){
			help();
		}

		in =   new File(args[0]);
		out1 = new File(args[2]);
		out2 = new File(args[3]);

		if(args[1].startsWith("0x")){
			off = Integer.parseUnsignedInt(args[1].substring(2), 16);

		} else {
			off = Integer.parseUnsignedInt(args[1]);
		}

		FileInputStream fis = new FileInputStream(in);
		FileOutputStream fout1 = new FileOutputStream(out1);
		FileOutputStream fout2 = new FileOutputStream(out2);

		byte[] bo1 = new byte[off];
		fis.read(bo1);
		fout1.write(bo1);
		fout1.close();

		byte[] bo2 = new byte[(int) (in.length() - off)];
		fis.read(bo2);
		fout2.write(bo2);
		fout2.close();
	}

	private static void help() {
		System.out.println("DriverSplitter usage:\n" +
				"java -jar DriverSplitter.jar <input file> <offset> <output file 1> <output file 2>");
		System.exit(0);
	}
}
