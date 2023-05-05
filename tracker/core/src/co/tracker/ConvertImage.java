package co.tracker;

import co.tracker.core.CTracker;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Files;
import java.util.ArrayList;

public class ConvertImage {
	public static void main (String[] arg) throws IOException, InterruptedException {
		ArrayList<String> out1 = new ArrayList<>(), out2 = new ArrayList<>();
		out1.add("ua_list:");

		for(int i = 0;i < CTracker.RCTMSAMOUNT;i ++){
			System.out.println("copied png "+ i +". Success? "+
					copy("H:\\Java\\tracker\\core\\assets\\screenshot" + CTracker.getHex(2, i) + ".png", "G:\\getart\\Bitmap.png"));
			clearTransparency("G:\\getart\\Bitmap.png");

			ProcessBuilder builder = new ProcessBuilder("G:\\getart\\GetArt.NET.exe");
			Process p = builder.start();
			builder.redirectOutput(ProcessBuilder.Redirect.INHERIT);
			builder.redirectError(ProcessBuilder.Redirect.INHERIT);

			while(p.isAlive()){
				p.waitFor();
			}
			System.out.println("getart "+ i +" ret "+ p.exitValue());
			p.destroy();

			System.out.println("copied art/map "+ i +". Success? "+
					move("G:\\getart\\Art.bin", "G:\\Disassemblies\\s1orbinaut\\ua\\Art"+ CTracker.getHex(2, i) +".bin") +", "+
					move("G:\\getart\\Map.bin", "G:\\Disassemblies\\s1orbinaut\\ua\\Map" + CTracker.getHex(2, i) + ".bin"));
			mirror("G:\\Disassemblies\\s1orbinaut\\ua\\Map" + CTracker.getHex(2, i) + ".bin", 256 / 16);

			builder = new ProcessBuilder("H:\\_ducks\\disassembly\\misc\\kensc\\compcmp.exe",
					"G:\\Disassemblies\\s1orbinaut\\ua\\Art"+ CTracker.getHex(2, i) +".bin",
					"G:\\Disassemblies\\s1orbinaut\\ua\\Art"+ CTracker.getHex(2, i) +".comp");
			p = builder.start();

			while(p.isAlive()){
				p.waitFor();
			}
			System.out.println("koscmp "+ i +" ret "+ p.exitValue());
			p.destroy();

			builder = new ProcessBuilder("H:\\_ducks\\disassembly\\misc\\kensc\\enicmp.exe",
					"G:\\Disassemblies\\s1orbinaut\\ua\\Map"+ CTracker.getHex(2, i) +".bin",
					"G:\\Disassemblies\\s1orbinaut\\ua\\Map"+ CTracker.getHex(2, i) +".eni");
			p = builder.start();

			while(p.isAlive()){
				p.waitFor();
			}
			System.out.println("enicmp "+ i +" ret "+ p.exitValue());
			p.destroy();

			out1.add("\tdc.l ua_art"+ CTracker.getHex(2, i) + ", ua_map" + CTracker.getHex(2, i));
			out1.add("\tVDPsize "+ size("G:\\Disassemblies\\s1orbinaut\\ua\\Art" + CTracker.getHex(2, i) + ".bin"));

			out2.add("ua_art" + CTracker.getHex(2, i) + ":\tincbin \"ua/Art" + CTracker.getHex(2, i) + ".comp\"");
			out2.add("\t\teven");
			out2.add("ua_map" + CTracker.getHex(2, i) + ":\tincbin \"ua/Map" + CTracker.getHex(2, i) + ".eni\"");
			out2.add("\t\teven\n");
		}

		String out = "";
		for(String s : out1){
			out += s +"\n";
		}

		out += "\n";
		for(String s : out2){
			out += s +"\n";
		}

		write(new File("G:/Disassemblies/s1orbinaut/ua/dat.asm"), out.getBytes());
	}

	private static void mirror(String file, int tiles) {
		byte[] in = read(file);
		byte[] out = new byte[in.length * 2];

		for(int i = 0, x = 0; i < (224 / 8) * (tiles * 2);i += tiles * 2){
			for(int o = 0; o < (tiles * 2);o ++, x ++){
				out[x] = in[i + o];
			}

			for(int o = (tiles * 2) - 2; o >= 0;o -= 2, x += 2){
				out[x] = (byte) (in[i + o] ^ 0x8);
				out[x + 1] = in[i + o + 1];
			}
		}

		write(new File(file), out);
	}

	private static void setShort(byte[] d, int i, int o) {
		d[o] = (byte) ((i & 0xFF) >> 8);
		d[o + 1] = (byte) (i & 0xFF);
	}

	private static short readShort(byte[] d, int i) {
		return (short) ((d[i] << 8) & 0xFF00 | (d[i + 1] & 0xFF));
	}

	private static void write(File file, byte[] out) {
		try {
			file.delete();
			Files.write(file.toPath(), out);

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private static long size(String s) {
		return new File(s).length();
	}

	private static byte[] read(String file) {
		try {
			return Files.readAllBytes(new File(file).toPath());

		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}


	private static boolean move(String from, String to) {
		try {
			new File(to).delete();
			Files.move(new File(from).toPath(), new File(to).toPath());
			return true;

		} catch (IOException e) {
			e.printStackTrace();
		}

		return false;
	}

	private static boolean copy(String from, String to) {
		try {
			new File(to).delete();
			Files.copy(new File(from).toPath(), new File(to).toPath());
			return true;

		} catch (IOException e) {
			e.printStackTrace();
		}

		return false;
	}

	private static void clearTransparency(String s) {
		try {
			BufferedImage img = ImageIO.read(new File(s));
			BufferedImage copy = new BufferedImage(img.getWidth(), img.getHeight(), BufferedImage.TYPE_INT_RGB);

			Graphics2D g2d = copy.createGraphics();
			g2d.setColor(Color.BLACK); // Or what ever fill color you want...
			g2d.fillRect(0, 0, copy.getWidth(), copy.getHeight());
			g2d.drawImage(img, 0, 0, null);
			g2d.dispose();

			ImageIO.write(copy, "png", new File(s));

		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
