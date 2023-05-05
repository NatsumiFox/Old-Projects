using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Test_Programs {
	class SampleInterleave {
		static void Main(string[] args) {
			var pcm1 = File.ReadAllBytes(@"G:\tools\music\Fractal\Pack\Fractal\Samples\.cache\BGKBJyiuQIVG04MA4Qc-lw.pcm");
			var pcm2 = File.ReadAllBytes(@"G:\tools\music\Fractal\Pack\Fractal\Samples\.cache\yEHQ1pLEUcednn2BR-c7tw.pcm");
			var buf = new byte[Math.Min(pcm1.Length, pcm2.Length) * 2];

			for(int i = 0;i < buf.Length / 2;i ++) {
				buf[(i * 2)] = pcm1[i];
				buf[(i * 2) + 1] = pcm2[i];
			}

			File.WriteAllBytes(@"G:\test.pcm", buf);
		}
	}
}
