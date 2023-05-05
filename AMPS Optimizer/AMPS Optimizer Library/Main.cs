using System;
using System.IO;
using OptimizerLibrary.v1_0;

namespace OptimizerLibrary {
	public class Optimizer {
		// function to convert SMPS2ASM file into special format, and optionally unoptimize the file
		public static bool ConvertAsmFile(Stream input, Stream output, Stream console, bool unoptimize) {

			// generate writer and reader streams for all passed streams
			using (StreamWriter con = new StreamWriter(console, System.Text.Encoding.ASCII, leaveOpen: true)) {
				using (StreamWriter outs = new StreamWriter(output, System.Text.Encoding.ASCII, leaveOpen: true)) {
					using (StreamReader ins = new StreamReader(input, System.Text.Encoding.ASCII, leaveOpen: true)) {

						// generate a new processor
						var processor = new ConvertSMPS2ASM(unoptimize);
						string line;

						// read line by line until no more lines are there
						while((line = ins.ReadLine()) != null) {
							// handle line
							if(!processor.Process(line, outs, con)) {
								return false;
							}
						}

						// emit rest of the data
						if (!processor.Emit(outs, con)) {
							return false;
						}

						outs.Flush();
						con.Flush();
					}
				}
			}

			return true;
		}

		// function to optimize the special format file back to SMPS2ASM format
		public static bool OptimizeToAsm(Stream input, Stream output, Stream console) {
		/*	input.CopyTo(output);
			return true;*/

			// generate writer and reader streams for all passed streams
			using (StreamWriter con = new StreamWriter(console, System.Text.Encoding.ASCII, leaveOpen: true)) {
				using (StreamWriter outs = new StreamWriter(output, System.Text.Encoding.ASCII, leaveOpen: true)) {
					using (StreamReader ins = new StreamReader(input, System.Text.Encoding.ASCII, leaveOpen: true)) {

						// generate a new processor
						var processor = new OptimizeAMPS();

						string line;

						// read line by line until no more lines are there
						while ((line = ins.ReadLine()) != null) {
							// handle line
							if (!processor.Load(line, con)) {
								return false;
							}
						}

						// unoptimize the current data
						if (!processor.UnOptimize(con)) {
							return false;
						}

						// optimize each level
						if (!processor.Optimize(con)) {
							return false;
						}

						// emit the final file
						if (!processor.Emit(outs, con)) {
							return false;
						}

						outs.Flush();
						con.Flush();
					}
				}
			}

			return true;
		}
	}
}
