package nat.sumi;

import javax.sound.sampled.AudioFileFormat;
import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import java.io.*;
import java.util.ArrayList;
import java.util.Random;

public class PCMoptimizer {
	private static boolean DEBUG = false;

	public static void main(String[] args) throws IOException {
		boolean signed = false, bigendian = false;
		int seten = 0, samplesize = -1, chans = -1;
		float samplerate = -0.1f;
		long outsz = 4096;
		File in = null, out = null;
		String name = null;

		ArrayList[] saved;

		for(String a : args){
			if(a.length() > 3 && a.startsWith("-") && a.charAt(2) == '=') {
				String arg = a.substring(3);

				switch (a.toLowerCase().charAt(1)){
					case 'b':
						samplesize = Integer.parseInt(arg);
						seten |= 0x4;
						break;

					case 'c':
						chans = Integer.parseInt(arg);
						seten |= 0x8;
						break;

					case 'r':
						samplerate = Float.parseFloat(arg);
						break;

					case 'x':
						outsz = Long.parseUnsignedLong(arg);
						break;

					case 'i':
						in = new File(arg);

						if(!in.exists() || !in.isFile() || in.isHidden() || !in.canRead() || in.length() <= 0){
							in = null;
							System.out.println("Could not read input file '"+ arg +"'!");
						} else {
							seten |= 0x10;
						}
						break;

					case 'o':
						out = new File(arg);

						if(out.isHidden() || out.isFile()){
							out = null;
							System.out.println("Could not read output directory '"+ arg +"'!");
						} else {
							seten |= 0x20;
						}
						break;

					case 'n':
						name = arg;
						seten |= 0x40;
						break;

					default:
						System.out.println("WARNING: could not recognize setting '"+ a +"'");
				}
			} else {
				switch (a.toLowerCase().charAt(1)){
					case 'h': case '?':
						printUsage();

					case 'l':
						printTypes();

					case 'u':
						signed = false;
						seten |= 0x1;
						break;

					case 's':
						signed = true;
						seten |= 0x1;
						break;

					case 'q':
						bigendian = false;
						seten |= 0x2;
						break;

					case 'w':
						bigendian = true;
						seten |= 0x2;
						break;

					case 'd':
						DEBUG = true;
						break;

					default:
						System.out.println("WARNING: could not recognize setting '"+ a +"'");
				}
			}
		}

		if(seten < 0x7F){
			System.out.println("All settings were not set! Printing setting information and quitting!\n" +
					"Signed: "+ signed +", Big-Endian: "+ bigendian +", SampleBits: "+ samplesize +", Channels: "+ chans +", SampleRate: "+ samplerate +
					", MinSampleSize: "+ outsz +", ProjectName: "+ name +", InputFile: "+ in +", OutputFile: "+ out +", SettingsDebug: 0x"+ Integer.toHexString(seten) +"\n");
			printUsage();
		}

		out.mkdirs();
		AudioFormat a = new AudioFormat(samplerate, samplesize, chans, signed, bigendian);
		if (DEBUG) System.out.println("AudioFormat: " + a.toString());

		long lenFrames = in.length() / a.getFrameSize();
		InputStream inputStream = new BufferedInputStream(new FileInputStream(in));
		AudioInputStream ais = new AudioInputStream(inputStream, a, lenFrames);
		byte[] data = new byte[ais.available()];
		ais.read(data);

		Random r = new Random();
		for(int i = 0;i < data.length;){
			byte[] chk = new byte[Math.abs(r.nextInt() % 100) + 400];
			if(i + chk.length > data.length){
				chk = new byte[data.length - i];
			}

			System.arraycopy(data, i, chk, 0, chk.length);
			int times = findTimes(data, chk);
			System.out.println("-data from "+ i +" to "+ (i + chk.length) +" ("+ chk.length +" bytes) found "+ findTimes(data, chk) +" times");

			// if enough times, seek around
			if(times >= 3){
				int start = i, end = chk.length + i;

				// seek start point
				for(;start >= 0;start -= 100){
					byte[] d = new byte[end - start];
					System.arraycopy(data, start, d, 0, d.length);

					if(times > findTimes(data, d)){
						start += 10;
						break;
					}
				}

				// seek for specific byte
				for(;start >= 0;start -= 1){
					byte[] d = new byte[end - start];
					System.arraycopy(data, start, d, 0, d.length);

					if(times > findTimes(data, d)){
						start += 1;
						break;
					}
				}

				if(start < 0){
					start = 0;
				}

				// seek end point
				for(;end < data.length;end += 100){
					byte[] d = new byte[end - start];
					System.arraycopy(data, start, d, 0, d.length);

					if(times > findTimes(data, d)){
						end -= 10;
						break;
					}
				}

				// seek for specific byte
				for(;end < data.length;end += 1){
					byte[] d = new byte[end - start];
					System.arraycopy(data, start, d, 0, d.length);

					if(times > findTimes(data, d)){
						end -= 1;
						break;
					}
				}

				byte[] d = new byte[end - start];
				System.arraycopy(data, start, d, 0, d.length);

				System.out.println("data from "+ start +" to "+ end +" ("+ (end - start) +" bytes) found "+ findTimes(data, d) +" times");
				i += (end - start);

			} else {
				i += chk.length / 4;
			}
		}







		/*saved = new ArrayList[100];

		long min = outsz, max = outsz * 2;
		for(int z = 0; z < 100;z ++) {
			long seed = System.currentTimeMillis();
			Random r = new Random(seed);
			if (DEBUG) System.out.println("Selecting seed "+ seed +" for iteration "+ z);

			saved[z] = new ArrayList<Samples>();

			for (int i = 0, n = 0;i < in.length();n++) {
				long sz = r.nextLong() % (max - min) + max;

				if (i + sz > in.length()) {
					saved[z].add(cutSample(data, i, in.length() - i, n));

				} else {
					saved[z].add(cutSample(data, i, sz, n));
				}

				i += sz;
			}

			for (int i = saved.length - 1;i >= 0;i--) {
				removeDoubleSamples(saved[z], i, saved.length - 1);
			}
		}

		ArrayList<Samples> sav = saved[0];
		long size = Long.MAX_VALUE;
		for(ArrayList<Samples> s : saved){
			long siz = 0;

			for(Samples x : s){
				siz += x.getData().length;
			}

			if(size > siz || (size == siz && sav.size() > s.size())){
				System.out.println("replacing earlier save ("+ size +") with newer ("+ siz +")");
				size = siz;
				sav = s;

			} else if(DEBUG){
				System.out.println("not replacing earlier save ("+ size +") with newer ("+ siz +")");
			}
		}

		int i = 0;
		for(Samples s : sav){
			if(s.getSave()) {
				if (DEBUG) System.out.print("saving " + i);
				File o = getFile(out, name, i++);
				o.createNewFile();

				BufferedOutputStream bf = new BufferedOutputStream(new FileOutputStream(o));
				bf.write(s.getData());
				bf.flush();
				if (DEBUG) System.out.println(" ...done!");
			}
		}*/
	}

	private static int findTimes(byte[] data, byte[] chk) {
		int times = 0;
		for(int i = 0;i < data.length - chk.length + 1;i ++){
			byte[] a = new byte[chk.length];
			System.arraycopy(data, i, a, 0, chk.length);

			if(compare(a, chk)){
				times ++;
				i += a.length;
			}
		}

		return times;
	}

	private static void removeDoubleSamples(ArrayList<Samples> s, int num, int max) throws IOException {
		if(!s.get(num).getSave()){
			return;
		}

		if (DEBUG) System.out.println("Checking "+ num +".");

		for(int i = 0;i < num;i ++){
			if(s.get(i).getSave()){
				if(compare(s.get(num).getData(), s.get(i).getData())){
					s.get(num).setSave(false);
					if (DEBUG) System.out.println(num +" deleted! Found "+ i +".");
					return;
				}
			}
		}
	}

	private static boolean compare(byte[] a, byte[] b) {
		if(a.length != b.length){
			return false;
		}

		for(int i = 0;i < a.length;i ++){
			if(a[i] != b[i]){
				return false;
			}
		}

		return true;
	}

	private static Samples cutSample(byte[] data, int off, long len, long id) throws IOException {
		if (DEBUG) System.out.print("writing from: " + off +" to "+ (off + len) +" to "+ id);
		Samples s = new Samples(read(data, off, len));
		if (DEBUG) System.out.println(" ...write complete");
		return s;
	}

	private static byte[] read(byte[] data, int off, long len) {
		byte[] ret = new byte[(int) len];
		System.arraycopy(data, off, ret, 0, (int)len);
		return ret;
	}

	private static void printTypes() {
		for(AudioFileFormat.Type t : AudioSystem.getAudioFileTypes()){
			System.out.println(t.toString());
		}

		System.exit(0);
	}

	private static void printUsage() {
		System.out.println("Usage: java -jar PCMoptimizer.jar -<arg>=<value>\n" +
				"<args>: h = prints this message, l = prints all supported file types, u = sets unsigned file type, s = sets signed file type\n" +
				"b = sets sample size in bits, c = sets amount of channels, q = little endian file type, w = big endian file type\n" +
				"r = sets sample rate, i = sets input file, o = sets output directory, n = sets project name\n" +
				"x = sets minimum sample size in bytes. By default 4096. Some cases may produce smaller files");
		System.exit(0);
	}

	private static File getFile(File out, String name, int num) {
		return new File(out.getAbsolutePath() +"\\"+ String.format("%s_%04d", name, num) + ".pcm");
	}

	//
	private static class Samples {
		byte[] data;
		boolean save;

		public Samples(byte[] d){
			data = d;
			save = true;
		}

		public void setSave(boolean s){
			save = s;
		}

		public void setData(byte[] d){
			data = d;
		}

		public byte[] getData() {
			return data;
		}

		public boolean getSave() {
			return save;
		}
	}
}
