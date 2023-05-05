package com.GS.m68k;

import javax.swing.*;
import javax.swing.filechooser.FileNameExtensionFilter;
import java.io.*;

public class Main {

    public static String           ConfigPath = "";
    public static byte[]           InFilebyte;
    public static FileOutputStream InFile;
    public static FileOutputStream OutFile;
    public static Replaces[]       replace;

    public static void main(String[] args) {
        long st = System.nanoTime();

        if(args.length >= 1){
            ConfigPath = args[0];
        } else {
            new Thread(new OpenConfig()).start();

            while(ConfigPath.equals("")){
                try {
                    Thread.sleep(10);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }

            if(ConfigPath.equals("!") || !new File(ConfigPath).exists()){
                System.exit(-1);
            }
        }

        try {
            LoadConfig();
            ConvertArray();
            WriteEquates();
            InFile.write(InFilebyte);
            System.out.println("Took "+ ((System.nanoTime() - st) / 1000000) +" ms to execute.");

        } catch (FileNotFoundException e) {
            System.out.println("Failed to execute. Stack dump:\n");
            e.printStackTrace();
        } catch (IOException e) {
            System.out.println("Failed to execute. Stack dump:\n");
            e.printStackTrace();
        }
    }

    private static void WriteEquates() throws IOException {
        byte[] middle = new byte[]{ ':', ' ', '=', ' ' };
        for(int i = 0;i < replace.length - 1;i ++){
            OutFile.write(replace[i].with.getBytes());
            OutFile.write(middle);
            OutFile.write(replace[i].equ.getBytes());
            OutFile.write('\n');
        }
    }

    private static void ConvertArray() {
        for(int i = 0;i < InFilebyte.length;i ++){
            for(int a = 0;a < replace.length - 1;a ++){
                boolean m = true;
                for(int c = 0;c < replace[a].what.length();c ++){
                    if(i + c >= InFilebyte.length){
                        m = false;
                        break;
                    }
                    if(replace[a].what.charAt(c) != InFilebyte[i + c]){
                        m = false;
                        break;
                    }
                }

                if(m){
                    InFilebyte = ReplaceThis(InFilebyte, i, replace[a]);
                }
            }
        }
    }

    private static byte[] ReplaceThis(byte[] in, int off, Replaces rep) {
        byte[] out = new byte[in.length + (rep.with.length() - rep.what.length())];

        System.arraycopy(in, 0, out, 0, off);
        System.arraycopy(rep.with.getBytes(), 0, out, off, rep.with.getBytes().length);
        System.arraycopy(in, off + rep.what.getBytes().length, out, rep.with.getBytes().length + off, out.length - off - rep.with.getBytes().length);

        byte[] asd = new byte[rep.with.getBytes().length + 4];
        System.arraycopy(out, off - 2, asd, 0, asd.length);
        return out;
    }

    private static void LoadConfig() throws IOException {
        long offset = 0;
        byte[] ConfBytes = new byte[(int) new File(ConfigPath).length()];
        new FileInputStream(ConfigPath).read(ConfBytes);

        NextByteArrayReturn a = new NextByteArrayReturn(NextByteArray(ConfBytes, offset, new byte[]{ ' ', '\r' }, new int[]{ 1, 2 }));
        InFilebyte = new byte[(int) new File(new String(a.getByteA())).length()];
        new FileInputStream(new String(a.getByteA())).read(InFilebyte);
        InFile = new FileOutputStream(new String(a.getByteA()), false);
        new FileOutputStream(new String(a.getByteA()) +".backup", false).write(InFilebyte);
        offset = a.getOff();

        a = new NextByteArrayReturn(NextByteArray(ConfBytes, offset, new byte[]{ ' ', '\r' }, new int[]{ 1, 2 }));
        OutFile = new FileOutputStream(new String(a.getByteA()), false);
        offset = a.getOff();

        a = new NextByteArrayReturn(NextByteArray(ConfBytes, offset, (byte)'\r', 2));
        offset = a.getOff();

        GetReplaces(offset, ConfBytes);
    }

    private static void GetReplaces(long offset, byte[] in) {
        Replaces[] r = new Replaces[999999];
        NextByteArrayReturn a;

        int i = 0;
        for(;offset < in.length;i ++){
            r[i] = new Replaces();

            a = new NextByteArrayReturn(NextByteArray(in, offset, (byte)' ', 1));
            r[i].what = new String(a.getByteA());
            offset = a.getOff();

            a = new NextByteArrayReturn(NextByteArray(in, offset, (byte)' ', 1));
            r[i].equ = new String(a.getByteA());
            offset = a.getOff();

            a = new NextByteArrayReturn(NextByteArray(in, offset, (byte)'\r', 2));
            r[i].with = new String(a.getByteA());
            offset = a.getOff();
        }

        replace = new Replaces[i + 1];
        System.arraycopy(r, 0, replace, 0, i);
    }

    private static NextByteArrayReturn NextByteArray(byte[] in, long offset, byte find, int skip) {
        return NextByteArray(in, offset, new byte[]{ find }, new int[]{ skip });
    }

    private static NextByteArrayReturn NextByteArray(byte[] in, long offset, byte[] find, int[] skip) {
        NextByteArrayReturn out = new NextByteArrayReturn();

        int i = (int) offset, y = 0;
        exit:
        for(;i < in.length;i ++){
            for (y = 0;y < find.length;y ++) {
                if (in[i] == find[y]) {
                    break exit;
                }
            }
        }
        out.setOff(i);

        byte[] b = new byte[(int) (out.getOff() - offset)];
        System.arraycopy(in, (int) offset, b, 0, (int) (out.getOff() - offset));
        out.setByteA(b);

        if(y < skip.length) {
            out.setOff(i + skip[y]);
        } else {
            out.setOff(i);
        }
        return out;
    }

    private static class OpenConfig implements Runnable {

        public JFileChooser fc;

        @Override
        public void run(){
            fc = new JFileChooser("C:/");
            fc.setFileFilter(new FileNameExtensionFilter("CreateEquates Config Files", "CCF", "ccf"));
            int returnVal = fc.showDialog(null, "Open");

            if (returnVal == JFileChooser.APPROVE_OPTION) {
                Main.ConfigPath = fc.getSelectedFile().toString().replace("\\", "/") +"/";

            } else if(returnVal == JFileChooser.CANCEL_OPTION){
                System.out.println("Usage: java -jar CreateEquates.jar [configuration full path]");
                Main.ConfigPath = "!";
            }
        }
    }
}
