package nat.sumi;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.DecimalFormat;
import java.util.ArrayList;

public class FlameWingScalerCodeGenerator {
	final static float[] scales = new float[]{ 1.0f, 1.05f, 1.1f, 1.175f, 1.25f, 1.35f, 1.45f, 1.6f, 1.75f, 1.9f,
											   2.1f, 2.3f, 2.5f, 2.75f, 3f, 3.25f, 3.5f, 4f, 4.5f, 5f, 6f, 7f, 8f, 9f };

	final static File out = new File("G:\\testsonic1\\#sega\\scaletable.asm");
	static String name = "Scaler";
	static ArrayList<CodePart> code;
	private static boolean flushing = false;
	private static float scaleFactor;
	private static int writtenPixels;
	private static int readPixels;
	private static float pixelPerRead;
	static Token curToken;
	static String readStore;
	static boolean readLow = false;

	public static void main(String[] args) throws IOException {
		code = new ArrayList<>();
		genScalers();
		Files.write(out.toPath(), processCode());
	}


	/**	; ===========================================================================
	; Notes for all macros:
	;       x       Coordinate on output (scaled) line; in the [0-159] range
	;       y       Coorrinate on input (unscaled) line; in the [0-255] range
	;       a0      Input buffer
	;       a1      Output buffer
	;       a2      High nibble to low nibble LUT
	;       a3      Low nibble to high nibble LUT
	;       a4      High nibble to both nibbles LUT
	;       a5      Low nibble to both nibbles LUT
	; ===========================================================================
	; Scale factors are multiplied by 1000. Fo a scale factor of 1000 corresponds to
			; the original image, a scale factor of 500 is half-size, a scale factor of 2000
	; is 2x the size of the original, and so on.
	; ===========================================================================
	; Output range:
	;       wx      Width of output (scaled) image
	;       cx      Origin ("center") of output (scaled) image
	; The following values are for drawing half-lines.*/
	static int winW = 320;
	static int winCen = 160;

/**	; For drawing a full line centered on the middle of the screen:
	;wx := 320
	;cx := 160
	; ===========================================================================
	; Input range:
	;       wy      Width of input (unscaled) image
	;       cy      Origin ("center") of input (unscaled) image
	; The following values are for drawing half-lines. */
	static int imgW = 200;
	static int imgCen = 100;

/**	; For scaling a 160-pixel wide image, centered in the middle
	;wy := 160
	;cy := 80
	; =========================================================================== */
	static int inputIsTiles = 0;
/** ; ===========================================================================
	; Registers used are:
	;       d0      Last byte read from input; assumes high 24 bits are all 0
	;       d1      Intermediate 2-pixel buffer
	;       d2      Scratch register
	;       d3      Scratch register
	;       a0      Input image
	;       a1      Output image
	;       a2      High nibble to low nibble LUT
	;       a3      Low nibble to high nibble LUT
	;       a4      High nibble to both nibbles LUT
	;       a5      Low nibble to both nibbles LUT
	; --------------------------------------------------------------------------- */
	static void scaleLine(float scl) {
		scaleFactor = scl;
		code(new Instruction("moveq", "#0", "d0", ""));

		float siw = imgW * scl, sic = imgCen * scl;
		int offs = (int) ((winW - siw) - (winCen - sic));

		bressenhamLine(offs, winW - offs);
		code(new Instruction("rts", "", "", ""));
	}

	static void bressenhamLine(int xStart, int xEnd) {
		writtenPixels = 0;
		readPixels = 0;
		pixelPerRead = 0;

		/* generate code to clear the beginning area
		 * or get right offset for input */
		if(xStart >= 0){
			while(writtenPixels < xStart) {
				write0(xStart - writtenPixels, "d0");
			}

		} else {
			readPixels = -xStart;
			int offset = ((readPixels / 8) * 32);

			while(offset > 0x7FFF){
				code(new Instruction("lea", 0x7FFF +"(a0)", "a0", ""));
				offset -= 0x7FFF;
			}

			code(new Instruction("lea", offset +"(a0)", "a0", ""));

			if((readPixels & 1) == 1){
				read("d0");
				readStore = "d0";
				readLow = false;
				readPixels --;
			}
		}

		/* generate code to copy necessary pixels over */
		while(writtenPixels < xEnd && writtenPixels < winW) {
			int w1 = (int)(pixelPerRead += scaleFactor), w2 = (int)((pixelPerRead -= w1) + scaleFactor);
			curToken = grabToken(readStore != null, readLow);

			if(plotPixel(w1, w2)){
				pixelPerRead -= w2 - scaleFactor;
			}
		}

		if(writtenPixels < winW) {
			code(new Instruction("moveq", "#0", "d0", ""));
			while (writtenPixels < winW) {
				write0(winW - writtenPixels, "d0");
			}
		}

		if(writtenPixels != winW){
			System.err.println("writtenPixels != winW, " + writtenPixels + " != " + winW);

		}if(readPixels != imgW){
			System.err.println("readPixels != imgW, " + readPixels + " != " + imgW);
		}
	}

	private static Token grabToken(boolean stored, boolean low) {
		return Token.values()[(stored ? (low ? 8 : 4) : 0) + (readPixels & 1) + ((writtenPixels & 1) * 2)];
	}

	private static boolean plotPixel(int w1, int w2) {
		boolean ret = false;
		System.out.println(curToken +" "+ w1 +" "+ w2 +" "+ writtenPixels +" "+ readPixels +" "+ pixelPerRead);
		switch (curToken){
			case CLL:   // write low, read low
				ret = writell(w1, w2, null, true);
				break;

			case LLL:
				ret = writell(w1, w2, readStore, true);
				break;

			case HLL:
				ret = writell(w1, w2, readStore, false);
				break;

			case CHL:   // write high, read low
				ret = writehl(w1, w2, null, true);
				break;

			case LHL:
				ret = writehl(w1, w2, readStore, true);
				break;

			case HHL:
				ret = writehl(w1, w2, readStore, false);
				break;

			case CLH:case HLH:case LLH:   // write low, read high
			case CHH:case HHH:case LHH:   // write high, read high
				err("read required when read is high! Can not read! State "+ curToken);
				break;
		}

		nextTile();
		return ret;
	}

	private static boolean writehl(int w1, int w2, String source, boolean isLow) {
		readStore = null;
		if(source == null){
			readStore = source = "d0";
			readLow = false;
			read(source);
		}

		if(w1 == 0) return false;
		if(w1 == 1) {
			if(isLow) {
				code(new Instruction("move.b", "(a3,"+ source +".w)", "d1", ""));

			} else {
				code(new Instruction("move.b", source, "d1", ""));
				code(new Instruction("and.b", "#$F0", "d1", ""));
			}

			code(new Instruction("or.b", "d1", "(a1)+", ""));
			writtenPixels ++;

		} else {
			code(new Instruction("move.b", "(a"+ (isLow ? 5 : 4) +","+ source +".w)", "d1", ""));
			if(isLow) {
				code(new Instruction("move.b", "(a3," + source + ".w)", "d2", ""));

			} else {
				code(new Instruction("move.b", "d1", "d2", ""));
				code(new Instruction("and.b", "#$F0", "d2", ""));
			}

			code(new Instruction("or.b", "d2", "(a1)+", ""));
			writtenPixels ++;
			w1 --;

			while(w1 > 0) {
				if (w1 == 1) {
					code(new Instruction("and.b", "#$F", "d1", ""));
					code(new Instruction("move.b", "d1", "(a1)", ""));
					writtenPixels ++;
					w1 --;

				} else {
					code(new Instruction("move.b", "d1", "(a1)+", ""));
					writtenPixels ++;
					w1 -= 2;
				}
				nextTile();
			}
		}

		return false;
	}
	
	private static boolean writell(int w1, int w2, String source, boolean isLow) {
		if(w1 == 1 && w2 >= 1 && source == null && isLow){
			if(w2 == 1) {
				read("(a1)+");
				writtenPixels += 2;

			} else if(w2 == 2) {
				read("d0");
				code(new Instruction("move.b", "d0", "(a1)+", ""));
				code(new Instruction("move.b", "(a2,d0.w)", "(a1)", ""));
				writtenPixels += 3;

			} else {
				err("writell w2 error: w2 = "+ w2);
			}

			return true;
		}

		readStore = null;
		if(source == null){
			readStore = source = "d0";
			readLow = false;
			read(source);
		}

		boolean copied = false;
		while(w1 > 0){
			if(w1 == 1){
				if(!copied){
					if(isLow) {
						code(new Instruction("move.b", source, "d1", ""));
						code(new Instruction("and.b", "#$F", "d1", ""));
						code(new Instruction("move.b", "d1", "(a1)", ""));
						writtenPixels ++;
						w1--;

					} else {
						code(new Instruction("move.b", "(a2,"+ source +".w)", "d1", ""));
						code(new Instruction("move.b", "d1", "(a1)", ""));
						writtenPixels ++;
						w1 --;
					}
					copied = true;

				} else {
					code(new Instruction("and.b", "#$F", "d1", ""));
					code(new Instruction("move.b", "d1", "(a1)", ""));
					writtenPixels ++;
					w1--;
				}

			} else {
				if(w1 >= 3 && !copied){
					code(new Instruction("move.b", "(a"+ (isLow ? 5 : 4) +","+ source +".w)", "d1", ""));
					copied = true;
					code(new Instruction("move.b", "d1", "(a1)+", ""));
					writtenPixels += 2;
					w1 -= 2;

				} else {
					code(new Instruction("move.b", "d1", "(a1)+", ""));
					writtenPixels += 2;
					w1 -= 2;
				}
			}
			nextTile();
		}

		return false;
	}

	private static void read(String dest) {
		code(new Instruction("move.b", "(a0)+", dest, ""));
		readPixels += 2;
	}


	private static void write0(int pixels, String source) {
		int write = getWritePixels(pixels);

		switch (write){
			case 1:
				if((writtenPixels & 1) == 0){
					code(new Instruction("move.b", source, "(a1)", ""));

				} else {
					code(new Instruction("and.b", "#$F", "(a1)+", ""));
				}
				break;

			case 2:
				code(new Instruction("move.b", source, "(a1)+", ""));
				break;

			case 4:
				code(new Instruction("move.w", source, "(a1)+", ""));
				break;

			case 8:
				code(new Instruction("move.l", source, "(a1)+", ""));
				break;

			default:
				err("Can not resolve write amount for next instruction: "+ write);
				return;
		}

		writtenPixels += write;
		nextTile();
	}

	private static int getWritePixels(int pixels) {
		if((writtenPixels & 1) == 1) return 1;
		int canWrite = 8 - (writtenPixels & 7);

		if(pixels > canWrite){
			return pixelsPerIns(canWrite);

		} else {
			return pixelsPerIns(pixels);
		}
	}

	private static int pixelsPerIns(int max) {
		switch (max){
			case 1:
				return 1;

			case 2:case 3:
				return 2;

			case 4:case 5:case 6:case 7:
				return 4;

			case 8:
				return 8;

			default:
				err("Can not resolve pixel amount for next instruction: "+ max);
				return 0;
		}
	}

	private static void nextTile() {
		if((writtenPixels & 7) == 0 && !code.get(code.size() - 1).getCode().startsWith("lea")){
			code(new Instruction("lea", "28(a1)", "a1", ""));
		}
	}

	/**	; ===========================================================================
	; Generates a table of scaler pointers followed by the routines themselves.
	; Each entry in the table has 4 bytes, and scales a line, as configured by wx,
	; cx, wy, cy, above. */
	static void genScalers() {
		code(new Comment("==========================================================================="));
		code(new Comment("Hyper fast upscaling code generator!"));
		code(new Comment("Probably the fastest (and largest!!!) tile upscaling code to date!"));
		code(new Comment("Had to be done because \"Blast processing\"! And \"Genesis does what Nintendon't!\""));
		code(new Comment(""));
		code(new Comment("Generating functions programmed by FlameWing"));
		code(new Comment("Ported to Java and optimized by Natsumi"));
		code(new Comment("==========================================================================="));
		code(new Comment("But! Before we get into the business, here are few lookup tables we need."));
		code(new Comment("==========================================================================="));
		generateLUTs();

		code(new Comment("==========================================================================="));
		code(new Comment("Scaler table; each longword is a direct pointer to scaling code"));
		code(new Comment("with preset scaling factor (which can be seen in the comment)"));
		code(new Comment("==========================================================================="));
		code(new Lable("Scalers_Table"));

		/* generates longword pointers for each array */
		for (float i : scales) {
			code(new Instruction("dc.l", getName(i), "", "scale " + (i * 100) + "%"));
		}

		code(new Comment("==========================================================================="));
		code(new Comment("Here are the actual functions:"));
		code(new Comment("==========================================================================="));

		/* generates code to scale a line with */
		for(float i : scales){
			System.err.println(i);
			code(new Lable(getName(i)));
			scaleLine(i);
			code(new Comment("==========================================================================="));
		}
	}

	/** converts integer into a String denoting the name of the scaler lable */
	private static String getName(float i) {
		return name +"_"+ (int)(i * 1000);
	}

	/** Method to autogenerate lookup tables for our functions */
	private static void generateLUTs() {
		VertScales();
		HighNibble2Low_LUT();
		LowNibble2High_LUT();
		HighNibble2Both_LUT();
		LowNibble2Both_LUT();
	}

	private static void VertScales() {
		code(new Lable("Scalers_VertTable"));

		for (float scale : scales) {
			code(new Instruction("dc.w", (int)round(scale * 32) +"", "", ""));
		}

		code(new Comment("==========================================================================="));
	}

	/** Generates a 256-byte lookup table that can be used to convert $00XY to $000X. */
	private static void HighNibble2Low_LUT() {
		code(new Lable("HighNibble2Low_LUT"));

		for(int i = 0;i < 256;){
			String out = "";
			for(int o = 0;o < 16;o ++, i ++){
				int x = (i >> 4) & 0x0F;

				if(o == 15){
					out = out.concat("$"+ getHex(2, x));

				} else {
					out = out.concat("$"+ getHex(2, x) +", ");
				}
			}

			code(new Instruction("dc.b", out, "", "$"+ getHex(2, i - 15) +"-$"+ getHex(2, i)));
		}

		code(new Comment("==========================================================================="));
	}

	/** Generates a 256-byte lookup table that can be used to convert $00XY to $00Y0. */
	private static void LowNibble2High_LUT() {
		code(new Lable("LowNibble2High_LUT"));

		for(int i = 0;i < 256;){
			String out = "";
			for(int o = 0;o < 16;o ++, i ++){
				int x = (i << 4) & 0xF0;

				if(o == 15){
					out = out.concat("$"+ getHex(2, x));

				} else {
					out = out.concat("$"+ getHex(2, x) +", ");
				}
			}

			code(new Instruction("dc.b", out, "", "$"+ getHex(2, i - 15) +"-$"+ getHex(2, i)));
		}

		code(new Comment("==========================================================================="));
	}

	/** Generates a 256-byte lookup table that can be used to convert $00XY to $00Y0. */
	private static void HighNibble2Both_LUT() {
		code(new Lable("HighNibble2Both_LUT"));

		for(int i = 0;i < 256;){
			String out = "";
			for(int o = 0;o < 16;o ++, i ++){
				int x = ((i >> 4) & 0x0F) | (i & 0xF0);

				if(o == 15){
					out = out.concat("$"+ getHex(2, x));

				} else {
					out = out.concat("$"+ getHex(2, x) +", ");
				}
			}

			code(new Instruction("dc.b", out, "", "$"+ getHex(2, i - 15) +"-$"+ getHex(2, i)));
		}

		code(new Comment("==========================================================================="));
	}

	/** Generates a 256-byte lookup table that can be used to convert $00XY to $00Y0. */
	private static void LowNibble2Both_LUT() {
		code(new Lable("LowNibble2Both_LUT"));

		for(int i = 0;i < 256;){
			String out = "";
			for(int o = 0;o < 16;o ++, i ++){
				int x = ((i << 4) & 0xF0) | (i & 0x0F);

				if(o == 15){
					out = out.concat("$"+ getHex(2, x));

				} else {
					out = out.concat("$"+ getHex(2, x) +", ");
				}
			}

			code(new Instruction("dc.b", out, "", "$"+ getHex(2, i - 15) +"-$"+ getHex(2, i)));
		}

		code(new Comment("==========================================================================="));
	}

	/* convert int into a String with (amount) padding */
	private static String getHex(int amount, int value) {
		return String.format("%0"+ amount +"X", value);
	}

	/* round floating point to 3 decimal places */
	static double round(double d) {
		DecimalFormat df = new DecimalFormat("#,###");
		return Double.valueOf(df.format(d));
	}

	/* this is done to have easy method to add code */
	private static void code(CodePart c) {
		code.add(c);
	}

	/* this is done to replace macro "fatal" */
	private static void err(String s) {
		System.err.println("\n"+ s);
		System.err.println("\nPrinting internal variables!\n"+
				"input_is_tiles = "+ inputIsTiles +"\n"+
				"winwX =          "+ winW +"\n"+
				"winwCen =        "+ winCen +"\n"+
				"imgW =           "+ imgW +"\n"+
				"imgCen =         "+ imgCen +"\n"+
				"scaleFactor =    "+ scaleFactor +"\n"+
				"writtenPixels =  "+ writtenPixels +"\n"+
				"readPixels =     "+ readPixels +"\n"+
				"\nFlushing the file. Warning: its not usable!");

		if(flushing){
			System.err.println("Could not flush! =(");

		} else {
			try {
				Files.write(out.toPath(), processCode());
				flushing = true;

			} catch (IOException e) {
				System.err.println("Could not flush! =(");
			}
		}

		System.exit(1);
	}

	private static byte[] processCode() {
		String out = "";

		for(CodePart c : code){
			String add = "";

			if(c instanceof Instruction){
				add = "\t"+ c.getCode() +"\t; "+ c.getComment() +"\n";

			} else if(c instanceof Comment){
				add = "; "+ c.getCode() +"\n";

			} else if(c instanceof Lable){
				add = c.getCode() +":\n";

			} else {
				err("Ran into class '"+ c.getClass() +"' when not expected. Terminating!");
			}

			out = out.concat(add);
		}

		return out.getBytes();
	}

	static class CodePart {
		public String getCode(){
			return "";
		}

		public String getComment(){
			return "";
		}
	}

	static class Comment extends CodePart {
		private final String comment;

		public Comment(String cm){
			comment = cm;
		}

		public String getCode(){
			return comment;
		}

	}

	static class Lable extends CodePart {
		private final String lable;

		public Lable(String lb){
			lable = lb;
		}

		public String getCode(){
			return lable;
		}
	}

	static class Instruction extends CodePart {
		private final String[] instr;
		private final String commment;

		public Instruction(String ins, String md1, String md2, String cm){
			instr = new String[]{ ins, md1, md2, };
			commment = cm;
		}

		public String getCode(){
			if(instr[2].equals("")) {
				return instr[0] +"\t"+ instr[1];

			} else {
				return instr[0] +"\t"+ instr[1] +","+ instr[2];
			}
		}

		public String getComment(){
			if (commment.equals("")){
				return getCodeComment();

			} else {
				return commment +"\t; "+ getCodeComment();
			}
		}

		public String getCodeComment() {
			int bytes = 0, cycles = 0;
			String ins = instr[0].contains(".") ? instr[0].split("\\.")[0] : instr[0];
			String size = instr[0].contains(".") ? instr[0].split("\\.")[1] : null;

			switch (ins){
				case "move":
					int[] cyclesBW = new int[]{
					/*			Dn		An		(An)	(An)+	-(An)	d(An)	d(An,ix) xxx.W	xxx.L */
					/*Dn*/		 4,		 4,		 8,		 8,		 8,		12,		14,		 12,	16,
					/*An*/		 4,		 4,		 8,		 8,		 8,		12,		14,      12,    16,
					/*(An)*/	 8,		 8,		12,		12,		12,		16,		18,		 16,	20,
					/*(An)+*/	 8,		 8,		12,		12,		12,		16,		18,		 16,	20,
					/*-(An)*/	10,		10,		14,		14,		14,		18,		20,		 18,	22,
					/*d(An)*/	12,		12,		16,		16,		16,		20,		22,		 20,	24,
					/*d(An,ix)*/14,		14,		18,		18,		18,		22,		24,		 22,	26,
					/*xxx.W*/	12,		12,		16,		16,		16,		20,		22,		 20,	24,
					/*xxx.L*/	16,		16,		20,		20,		20,		24,		26,		 24,	28,
					/*d(PC)*/	12,		12,		16,		16,		16,		20,		22,		 20,	24,
					/*d(PC,ix)*/14,		14,		18,		18,		18,		22,		24,		 22,	26,
					/*#xxx*/	 8,		 8,		12,		12,		12,		16,		18,		 16,	20, };

					int[] cyclesL = new int[]{
					/*			Dn		An		(An)	(An)+	-(An)	d(An)	d(An,ix) xxx.W	xxx.L */
					/*Dn*/		 4,		 4,		12,		12,		12,		16,		18,		 16,	20,
					/*An*/		 4,		 4,		12,		12,		12,		16,		18,		 16,	20,
					/*(An)*/	12,		12,		20,		20,		20,		24,		26,		 24,	28,
					/*(An)+*/	12,		12,		20,		20,		20,		24,		26,		 24,	28,
					/*-(An)*/	14,		14,		22,		22,		22,		26,		28,		 26,	30,
					/*d(An)*/	16,		16,		24,		24,		24,		28,		30,		 28,	32,
					/*d(An,ix)*/14,		14,		18,		18,		18,		22,		24,		 22,	26,
					/*xxx.W*/	16,		16,		24,		24,		24,		28,		30,		 28,	32,
					/*xxx.L*/	18,		18,		26,		26,		26,		30,		32,		 30,	34,
					/*d(PC)*/	16,		16,		24,		24,		24,		28,		30,		 28,	32,
					/*d(PC,ix)*/18,		18,		26,		26,		26,		30,		32,		 30,	34,
					/*#xxx*/	12,		12,		20,		20,		20,		24,		26,		 24,	28, };

					int[] bytesB = new int[]{
					/*			Dn		An		(An)	(An)+	-(An)	d(An)	d(An,ix) xxx.W	xxx.L */
					/*Dn*/		 2,		-1,		 2,		 2,		 2,		 4,		 4,		  4,	 6,
					/*An*/		-1,		-1,		-1,		-1,		-1,		-1,		-1,		 -1,	-1,
					/*(An)*/	 2,		-1,		 2,		 2,		 2,		 4,		 4,		  4,	 6,
					/*(An)+*/	 2,		-1,		 2,		 2,		 2,		 4,		 4,		  4,	 6,
					/*-(An)*/	 2,		-1,		 2,		 2,		 2,		 4,		 4,		  4,	 6,
					/*d(An)*/	 4,		-1,		 4,		 4,		 4,		 6,		 6,		  6,	 8,
					/*d(An,ix)*/ 4,		-1,		 4,		 4,		 4,		 6,		 6,		  6,	 8,
					/*xxx.W*/	 4,		-1,		 4,		 4,		 4,		 6,		 6,		  6,	 8,
					/*xxx.L*/	 6,		-1,		 6,		 6,		 6,		 8,		 8,		  8,	10,
					/*d(PC)*/	 4,		-1,		 4,		 4,		 4,		 6,		 6,		  6,	 8,
					/*d(PC,ix)*/ 4,		-1,		 4,		 4,		 4,		 6,		 6,		  6,	 8,
					/*#xxx*/	 4,		-1,		 4,		 4,		 4,		 6,		 6,		  6,	 8, };

					int[] bytesW = new int[]{
					/*			Dn		An		(An)	(An)+	-(An)	d(An)	d(An,ix) xxx.W	xxx.L */
					/*Dn*/		 2,		 2,		 2,		 2,		 2,		 4,		 4,		  4,	 6,
					/*An*/		 2,		 2,		 2,		 2,		 2,		 4,		 4,		  4,	 6,
					/*(An)*/	 2,		 2,		 2,		 2,		 2,		 4,		 4,		  4,	 6,
					/*(An)+*/	 2,		 2,		 2,		 2,		 2,		 4,		 4,		  4,	 6,
					/*-(An)*/	 2,		 2,		 2,		 2,		 2,		 4,		 4,		  4,	 6,
					/*d(An)*/	 4,		 4,		 4,		 4,		 4,		 6,		 6,		  6,	 8,
					/*d(An,ix)*/ 4,		 4,		 4,		 4,		 4,		 6,		 6,		  6,	 8,
					/*xxx.W*/	 4,		 4,		 4,		 4,		 4,		 6,		 6,		  6,	 8,
					/*xxx.L*/	 6,		 6,		 6,		 6,		 6,		 8,		 8,		  8,	10,
					/*d(PC)*/	 4,		 4,		 4,		 4,		 4,		 6,		 6,		  6,	 8,
					/*d(PC,ix)*/ 4,		 4,		 4,		 4,		 4,		 6,		 6,		  6,	 8,
					/*#xxx*/	 4,		 4,		 4,		 4,		 4,		 6,		 6,		  6,	 8, };

					int[] bytesL = new int[]{
					/*			Dn		An		(An)	(An)+	-(An)	d(An)	d(An,ix) xxx.W	xxx.L */
					/*Dn*/		 2,		 2,		 2,		 2,		 2,		 4,		 4,		  4,	 6,
					/*An*/		 2,		 2,		 2,		 2,		 2,		 4,		 4,		  4,	 6,
					/*(An)*/	 2,		 2,		 2,		 2,		 2,		 4,		 4,		  4,	 6,
					/*(An)+*/	 2,		 2,		 2,		 2,		 2,		 4,		 4,		  4,	 6,
					/*-(An)*/	 2,		 2,		 2,		 2,		 2,		 4,		 4,		  4,	 6,
					/*d(An)*/	 4,		 4,		 4,		 4,		 4,		 6,		 6,		  6,	 8,
					/*d(An,ix)*/ 4,		 4,		 4,		 4,		 4,		 6,		 6,		  6,	 8,
					/*xxx.W*/	 4,		 4,		 4,		 4,		 4,		 6,		 6,		  6,	 8,
					/*xxx.L*/	 6,		 6,		 6,		 6,		 6,		 8,		 8,		  8,	10,
					/*d(PC)*/	 4,		 4,		 4,		 4,		 4,		 6,		 6,		  6,	 8,
					/*d(PC,ix)*/ 4,		 4,		 4,		 4,		 4,		 6,		 6,		  6,	 8,
					/*#xxx*/	 6,		 6,		 6,		 6,		 6,		 8,		 8,		  8,	10, };

					if(size == null) err("Encountered dc but no size! size == null");
					int o = (getOff(instr[2].toLowerCase()) * 9) + getOff2(instr[1].toLowerCase());

					assert size != null;
					switch (size){
						case "b":
							cycles = cyclesBW[o];
							bytes =  bytesB[o];
							break;

						case "w":
							cycles = cyclesBW[o];
							bytes =  bytesW[o];
							break;

						case "l":
							cycles = cyclesL[o];
							bytes =  bytesL[o];
							break;

						default:
							err("Encountered dc but illegal size! size == "+ size);
					}
					break;

				case "or":case "and":
					String p1 = preprocessInstr(instr[1].toLowerCase()), p2 = preprocessInstr(instr[2].toLowerCase());

					assert size != null;
					switch (p1 +","+ p2){
						case "(an,dn.w),dn":case "(an,dn),dn":
							bytes = 4;
							cycles = size.equals("l") ? 20 : 14;
							break;

						case "dn,dn":
							bytes = 2;
							cycles = size.equals("l") ? 6 : 4;
							break;

						case "(an)+,dn":
							bytes = 2;
							cycles = size.equals("l") ? 10 : 8;
							break;

						case "#,(an)+":
							bytes = size.equals("l") ? 6 : 4;
							cycles = size.equals("l") ? 24 : 12;
							break;

						case "#,dn":
							bytes = size.equals("l") ? 6 : 4;
							cycles = size.equals("l") ? 16 : 8;
							break;

						case "dn,(an)+":
							bytes = size.equals("l") ? 4 : 2;
							cycles = size.equals("l") ? 16 : 12;
							break;

						default:
							err("Encountered unexpected mode '"+ instr[1] +","+ instr[2] +"' which was translated to '"+ p1 +","+ p2 +"'");
					}
					break;

				case "moveq":
					bytes = 2;
					cycles = 4;
					break;

				case "lea": // lea x(an)an
					bytes = 4;
					cycles = 8;
					break;

				case "dc":
					if(size == null) err("Encountered dc but no size! size == null");
					int mul = 0, times = 1;

					assert size != null;
					switch (size){
						case "b":
							mul = 1;
							break;

						case "w":
							mul = 2;
							break;

						case "l":
							mul = 4;
							break;

						default:
							err("Encountered dc but illegal size! size == "+ size);
					}

					for(int i = 0;i < instr[1].length();i ++){
						if(instr[1].charAt(i) == ',') times ++;
					}

					bytes = mul * times;
					break;

				case "rts":
					bytes = 2;
					cycles = 16;
					break;
			}

			return bytes +" bytes, "+ cycles +" cycles";
		}

		private int getOff2(String s) {
			String u = s;
			s = preprocessInstr(s.replace(" ", ""));
			if(s.startsWith("=")){
				return Integer.parseInt(s.substring(1));
			}

			switch (s){
				case "dn":
					return 0;

				case "an":
					return 1;

				case "(an)":
					return 2;

				case "(an)+":
					return 3;

				case "-(an)":
					return 4;

				case "x(an)":
					return 5;

				case "x(an,dn)":case "(an,dn)":case "x(an,dn.w)":case "(an,dn.w)":
					return 6;

				case "d(pc)":case "(pc)":
					return 9;

				case "d(pc,dn)":case "(pc,dn)":case "d(pc,dn.w)":case "(pc,dn.w)":
					return 10;

				case ".w":
					return 7;

				case ".l":
					return 8;

				case "#":
					return 11;
			}

			err("Could not resolve argument 1 '"+ u +"' which was translated to "+ s);
			return -1;
		}

		private int getOff(String s) {
			String u = s;
			s = preprocessInstr(s.replace(" ", ""));
			if(s.startsWith("=")){
				return Integer.parseInt(s.substring(1));
			}

			switch (s){
				case "dn":
					return 0;

				case "an":
					return 1;

				case "(an)":
					return 2;

				case "(an)+":
					return 3;

				case "-(an)":
					return 4;

				case "x(an)":
					return 5;

				case "x(an,dn)":case "(an,dn)":case "x(an,dn.w)":case "(an,dn.w)":
					return 6;

				case ".w":
					return 8;

				case ".l":
					return 9;

				case "#":
					return -1;
			}

			err("Could not resolve argument 1 '"+ u +"' which was translated to "+ s);
			return -1;
		}

		private String preprocessInstr(String s) {
			boolean found = true;

			while (found){
				found = false;
				if (hasReg(s, "d")){
					int off = s.indexOf('d');
					s = s.replace("d"+ s.charAt(off + 1), "dn");
					found = true;

				} else if (hasReg(s, "a")){
					int off = s.indexOf('a');
					s = s.replace("a"+ s.charAt(off + 1), "an");
					found = true;

				} else if (s.contains("(an")){
					int off = s.indexOf('(');
					if(off != 0) {

						if (s.charAt(off - 1) >= '0' && s.charAt(off - 1) <= '9') {
							off--;
							int end = off;

							while (s.charAt(--off) >= '0' || s.charAt(off) <= '9');
							s = s.substring(0, off + 1) + "x" + s.substring(end);
							found = true;
						}
					}

				} else if (s.contains("(pc")){
					int off = s.indexOf('(');
					if(off != 0) {

						if (s.charAt(off - 1) >= '0' && s.charAt(off - 1) <= '9') {
							off--;
							int end = off;

							while (s.charAt(--off) >= '0' || s.charAt(off) <= '9');
							s = s.substring(0, off + 1) + "x" + s.substring(end);
							found = true;
						}
					}

				} else if (s.contains(".w")){
					return ".w";

				} else if (s.contains(".l")){
					return ".l";

				} else if (s.startsWith("#")){
					return "#";
				}
			}

			return s;
		}

		private boolean hasReg(String s, String d) {
			int off = s.indexOf(d);
			return off != -1 && s.charAt(off + 1) >= '0' && s.charAt(off + 1) <= '9';
		}
	}

	private enum Token {
		// Format: read Clear/high/low, write high/low, read high/low
		CLL, CLH, CHL, CHH,
		HLL, HLH, HHL, HHH,
		LLL, LLH, LHL, LHH,
	}
}