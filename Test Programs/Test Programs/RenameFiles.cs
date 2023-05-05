using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Test_Programs {
	class RenameFiles {
		static void Main(string[] args) {
			foreach(string file in Directory.GetFiles(@"G:\disassemblies\s1git2021\sound\sfx")) {
				string[] x = file.Replace("/", "\\").Split('\\');
				string[] y = x[x.Length - 1].Split('-');
				x[x.Length - 1] = (y.Length > 1 ? y[1] : y[0]).Replace(".bin", ".dat").Trim();

				File.Move(file, string.Join("\\", x));
				Console.WriteLine(file.Replace("/", "\\").Split('\\').Last() + " -> " + x[x.Length - 1]);
			}

			Console.ReadLine();
		}
	}
}
