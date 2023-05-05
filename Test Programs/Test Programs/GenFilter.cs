using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Test_Programs {
	class GenFilter {
		static void Main(string[] args) {
			byte[] data = File.ReadAllBytes(@"G:\tools\music\Fractal\Fractal\DAC Filters\Linear - Copy.dat");
			byte[] buf = new byte[8];

			for(int p = 0;p < data.Length;p += 8) {
				for(int b = 0;b < 8;b++) {
					buf[b] = data[p + b];
				}

				for (int b = 0; b < 8; b++) {
					data[p + b] = buf[((b & 3) * 2) + ((b & 4) >> 2)];
				}
			}

			File.WriteAllBytes(@"G:\tools\music\Fractal\Fractal\DAC Filters\Linear.dat", data);
		}
	}
}
