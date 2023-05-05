using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SonLVLConvertObjDefsToKosm {
	class Program {
		static string root;

		static void Main(string[] args) {
			ProcessFiles(root = args[0]);
			Console.ReadKey();
		}

		private static void ProcessFiles(string dir) {
			foreach(string file in Directory.GetFiles(dir)) {
				if (file.EndsWith(".cs")) {
					ProcessCS(file);

				} else if (file.EndsWith(".xml")) {
					ProcessXML(file);
				}
			}

			foreach(string directory in Directory.GetDirectories(dir)) {
				ProcessFiles(directory);
			}
		}

		private static void ProcessXML(string file) {
			Console.WriteLine("XML " + file);
			string[] data = File.ReadAllLines(file);

			for(int i = 0;i < data.Length;i++) {
				string x = data[i].Trim();

				if(x.StartsWith("<ArtFile filename=")) {
					// this line has an art file
					int six = data[i].IndexOf("\""), eix = data[i].IndexOf("\"", six + 1);
					string fl = data[i].Substring(six + 1, eix - six - 1);
					string kosm = fl.Replace(".bin", ".kosm");

					if(kosm != fl && File.Exists(root + "\\" + kosm)) {
						// this is a kosm conversion, do eet
						data[i] = data[i].Substring(0, six + 1) + kosm + "\" compression=\"KosinskiM" + data[i].Substring(eix);
					}
				}
			}

			File.WriteAllLines(file, data);
		}

		private static void ProcessCS(string file) {
			Console.WriteLine("CS  " + file);
			string[] data = File.ReadAllLines(file);

			for (int i = 0;i < data.Length;i++) {
				if (!data[i].Contains("pathswapper-art.bin")) {
					data[i] = data[i].Replace("CompressionType.Nemesis", "CompressionType.KosinskiM");

					if (data[i].Contains("\"")) {
						int six = 0, eix = 0;

						do {
							six = data[i].IndexOf("\"", eix + 1);
							if (six < 0) break;
							eix = data[i].IndexOf("\"", six + 1);
							if (eix < 0) break;

							string fl = data[i].Substring(six + 1, eix - six - 1);
							string kosm = fl.Replace(".bin", ".kosm");

							if (kosm != fl && File.Exists(root + "\\" + kosm)) {
								// this is a kosm conversion, do eet
								data[i] = data[i].Substring(0, six + 1) + kosm + data[i].Substring(eix);
							}
						} while (true);
					}
				}
			}

			File.WriteAllLines(file, data);
		}
	}
}
