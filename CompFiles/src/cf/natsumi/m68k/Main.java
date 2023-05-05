package cf.natsumi.m68k;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

public class Main {

    public static void main(String[] args) {
        System.out.println();
	    if(args.length != 2){
            System.out.println("Usage: Java -jar CompFiles [input file] [compare file]");
            return;
        }

        if(!new File(args[0]).exists()){
            System.out.println("File \""+ args[0] +"\" does not exist!");
            return;

        } else if(!new File(args[1]).exists()){
	        System.out.println("File \""+ args[1] +"\" does not exist!");
	        return;

        }

        BufferedInputStream in, cmp;

        try {
            in =  new BufferedInputStream(new FileInputStream(args[0]));
	        cmp = new BufferedInputStream(new FileInputStream(args[1]));

        } catch (IOException e) {
            System.out.println("Failed to read input file! Stack dump:\n");
            e.printStackTrace();
            return;
        }

        byte[] t = new byte[2], t2 = new byte[2];
        int e = 0, ins = 0;
        try {
            while(in.available() > 1 && cmp.available() > 1) {
	            in.read(t);
	            cmp.read(t2);
                if (compare(getWord(t), getWord(t2))) {
                    System.out.println("0x"+ Integer.toHexString(e).toUpperCase() +": 0x"+
		                    Integer.toHexString(getWord(t)).toUpperCase() +" 0x"+
		                    Integer.toHexString(getWord(t2)).toUpperCase());
	                ins ++;
                }
	            e += 2;
            }
        } catch (IOException e1) {
            e1.printStackTrace();
	        return;
        }

        System.out.println(ins == 0 ? "bit perfect!" : ins +" instances found!");
    }

    private static boolean compare(short data, short data2) {
        return data != data2;
    }

    private static short getWord(byte[] in) {
        return (short)  (in[1] & 0xFF | (in[0] & 0xFF) << 8);
    }
}
