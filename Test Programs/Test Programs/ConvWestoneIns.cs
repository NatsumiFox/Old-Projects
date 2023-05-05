using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Test_Programs {
	class ConvWestoneIns {
		static string ins ="G:\\disassemblies\\WonderBoyinMonsterWorld\\doc\\ins.bin";
		static string rat = "G:\\disassemblies\\WonderBoyinMonsterWorld\\doc\\rat.bin";
		static int num = 0x2;

		static void Main(string[] args) {
			var idat = File.ReadAllBytes(ins);
			var rdat = File.ReadAllBytes(rat);
			var pos = num * 0x13;

			Console.WriteLine("Algorithm: " + (idat[pos] & 7).ToString());
			Console.WriteLine("Feedback: " + (idat[pos] >> 3).ToString());
			Console.WriteLine("OP mask: " + (idat[pos + 1]).ToString("X"));
			Console.WriteLine("Pan mask: " + (idat[pos + 2]).ToString("X"));

			Console.WriteLine("TL: " + idat[pos + 3].ToString() + " " + idat[pos + 6].ToString() + " " + idat[pos + 9].ToString() + " " + idat[pos + 12].ToString());
			Console.WriteLine("Detune: " + (idat[pos + 4] >> 4).ToString() +" "+ (idat[pos + 7] >> 4).ToString() + " " + (idat[pos + 10] >> 4).ToString() + " " + (idat[pos + 13] >> 4).ToString());
			Console.WriteLine("Multiple: " + (idat[pos + 4] & 0xF).ToString() + " " + (idat[pos + 7] & 0xF).ToString() + " " + (idat[pos + 10] & 0xF).ToString() + " " + (idat[pos + 13] & 0xF).ToString());

			var op1 = idat[pos + 5] * 4;
			var op2 = idat[pos + 8] * 4;
			var op3 = idat[pos + 11] * 4;
			var op4 = idat[pos + 14] * 4;

			Console.WriteLine("Rate Scale: " + (rdat[op1] >> 6).ToString() + " " + (rdat[op2] >> 6).ToString() + " " + (rdat[op3] >> 6).ToString() + " " + (rdat[op4] >> 6).ToString());
			Console.WriteLine("Attack Rate: " + (rdat[op1] & 0x1F).ToString() + " " + (rdat[op2] & 0x1F).ToString() + " " + (rdat[op3] & 0x1F).ToString() + " " + (rdat[op4] & 0x1F).ToString());
			Console.WriteLine("Amp Mod: " + (rdat[op1 + 1] >> 7).ToString() + " " + (rdat[op2 + 1] >> 7).ToString() + " " + (rdat[op3 + 1] >> 7).ToString() + " " + (rdat[op4 + 1] >> 7).ToString());
			Console.WriteLine("Decay 1 Rate: " + (rdat[op1 + 1] & 0x1F).ToString() + " " + (rdat[op2 + 1] & 0x1F).ToString() + " " + (rdat[op3 + 1] & 0x1F).ToString() + " " + (rdat[op4 + 1] & 0x1F).ToString());
			Console.WriteLine("Decay 2 Rate: " + (rdat[op1 + 2] & 0x1F).ToString() + " " + (rdat[op2 + 2] & 0x1F).ToString() + " " + (rdat[op3 + 2] & 0x1F).ToString() + " " + (rdat[op4 + 2] & 0x1F).ToString());
			Console.WriteLine("Decay 1 Level: " + (rdat[op1 + 3] >> 4).ToString() + " " + (rdat[op2 + 3] >> 4).ToString() + " " + (rdat[op3 + 3] >> 4).ToString() + " " + (rdat[op4 + 3] >> 4).ToString());
			Console.WriteLine("Release Rate: " + (rdat[op1 + 3] & 0xF).ToString() + " " + (rdat[op2 + 3] & 0xF).ToString() + " " + (rdat[op3 + 3] & 0xF).ToString() + " " + (rdat[op4 + 3] & 0xF).ToString());

			Console.WriteLine("Mod offset: " + (idat[pos + 15] | (idat[pos + 16] << 8)).ToString("X"));
			Console.WriteLine("Mod ID: " + idat[pos + 17].ToString("X"));
			Console.WriteLine("LFO ID: " + idat[pos + 18].ToString("X"));
			Console.ReadKey();
		}
	}
}


/**
	static final String folder = "G:\\tools\\disasm\\musicpla\\";
	static Path ins = new File("G:\\disassemblies\\WonderBoyinMonsterWorld\\doc\\ins.bin").toPath();
	static Path rat = new File("G:\\disassemblies\\WonderBoyinMonsterWorld\\doc\\rat.bin").toPath();
	static int num = 0x29;

	public static void main(String[] asd) throws Exception {
		byte[] dins = Files.readAllBytes(ins);
		byte[] drat = Files.readAllBytes(rat);
		byte[] out = new byte[25];

		int pos = num * 0x13;
		out[0] = dins[pos++];

		System.out.println("Ops enable "+ Integer.toHexString(dins[pos++] & 0xFF).toUpperCase());
		System.out.println("pan mask "+ Integer.toHexString(dins[pos++] & 0xFF).toUpperCase());

		for(int i = 0;i < 4;i ++){
			out[21 + i] = dins[pos++];
			out[1 + i] = dins[pos++];

			int ros = dins[pos++] * 4;
			out[5 + i] = drat[ros++];
			out[9 + i] = drat[ros++];
			out[13 + i] = drat[ros++];
			out[17 + i] = drat[ros++];
		}

		int modoff = ((dins[pos++] & 0xFF) << 8) | (dins[pos++] & 0xFF);
		System.out.println("mod offset "+ Integer.toHexString(modoff).toUpperCase());

		Files.write(new File(folder + "music\\temp").toPath(), out);

		Process p = Runtime.getRuntime().exec("cmd /c cd \""+ folder +"bin\" && smps2asm.exe temp MegaPCM.Voice" +" .");
		p.waitFor();

		byte[] res = Files.readAllBytes(new File(folder + "music\\temp.asm").toPath());
		Files.delete(new File(folder + "music\\temp.asm").toPath());
		System.out.println(new String(res));
 **/