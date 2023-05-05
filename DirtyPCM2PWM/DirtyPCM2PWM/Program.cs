using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DirtyPCM2PWM {
	class Program {
		static void Main(string[] args) {
			if(args.Length < 1) {
				Console.WriteLine("PCM2PWM.exe filein fileout");
				Console.ReadKey();
				return;
			}

			string fin = args[0], fout;

			if(!File.Exists(fin)) {
				Console.WriteLine("Input file does not exist.");
				Console.ReadKey();
				return;
			}

			if(args.Length >= 2) {
				fout = args[1];

			} else {
				fout = fin.Replace(".pcm", ".pwm").Replace(".bin", ".pwm").Replace(".raw", ".pwm").Replace(".dat", ".pwm").Replace(".pwm.pwm", ".pwm");

				if(fin == fout) {
					fout += ".pwm";
				}
			}

			using(var o = new BinaryWriter(File.Open(fout, FileMode.Create, FileAccess.Write))) {
				foreach(byte b in File.ReadAllBytes(fin)) {
					ushort x = (ushort)(((((b & 0xFF) ^ 0x80) ^ 0x400) & 0x7FF) - 0x200);
					o.Write((byte)(x >> 8));
					o.Write((byte)x);
				}

				o.Flush();
				o.Close();
				o.Dispose();
			}
		}
	}
}
