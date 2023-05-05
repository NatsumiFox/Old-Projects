using System;
using System.IO;
using OptimizerLibrary;

namespace OptimizerApp {
	class Program {
		static void Main(string[] args) {
			// find the console streeam
			var console = Console.OpenStandardOutput();

			// generate streams for the input file and output file
			using (FileStream input = new FileStream(args[0], FileMode.Open)) {
				using (FileStream output = new FileStream(args[1], FileMode.Create)) {

					// create a temporary stream for storing results
					using (MemoryStream asm = new MemoryStream(4096)) {

						// convert the file into special format, then convert to asm
						Console.WriteLine("Processing the input file...");
						if(!Optimizer.ConvertAsmFile(input, asm, console, true)) {
							Console.ReadKey();
							return;
						}

						asm.Position = 0;

						Console.WriteLine("Converting the data...");
						if(!Optimizer.OptimizeToAsm(asm, output, console)) {
							Console.ReadKey();
							return;
						}
					}
				}
			}

			// done
			Console.WriteLine("Conversion successful!");
			Console.ReadKey();
		}
	}
}
