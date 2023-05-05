using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Test_Programs {
	class GenVibTables {
		static void Main(string[] args) {
			byte[] data = new byte[512];

			for(int i = 0;i < 256;i ++) {
				int v = (int) Math.Round(Math.Sin((i / 256f * 360) * (Math.PI / 180)) * 0x7FFF);
				data[i * 2] = (byte) (v >> 8);
				data[i * 2 + 1] = (byte) (v & 0xFF);
			}

			File.WriteAllBytes(@"G:\tools\music\Fractal\Fractal\Vibrato Tables\Sine.dat", data);
			Console.ReadKey();
		}
	}
}
