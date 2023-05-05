using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace DisasmProcess {
	class Program {
		public static readonly Regex JSRPC = new Regex("^[A-Za-z0-9_]+$", RegexOptions.Compiled);
		public static readonly Regex DirComment = new Regex("(↓|↑)[a-zA-Z]$", RegexOptions.Compiled);

		static void Main(string[] args) {
			if(args.Length < 3) {
				Console.WriteLine("DisasmProcess inputlst inputsplit outputasm");
				Console.ReadKey();
				return;
			}

			// convert inputsplit
			List<Incbin> Files = new List<Incbin>();
			uint start = 0;
			string file = null;

			foreach (string line in File.ReadAllLines(args[1])) {
				if (line.Length == 0 || line.StartsWith("*") || line.StartsWith("#"))
					continue;

				// process the normal line
				string[] ln = line.Split(' ');
				if(file != null) Files.Add(new Incbin(start, uint.Parse(ln[0], NumberStyles.HexNumber), file));

				file = null;
				start = uint.Parse(ln[0], NumberStyles.HexNumber);
				if (ln.Length >= 2) file = string.Join(" ", ln.Skip(1).ToArray());
			}

			Files = Files.OrderBy(o => o.Start).ToList();

			// delete file if exists
			if (File.Exists(args[2])) File.Delete(args[2]);

			using (FileStream fs = File.OpenWrite(args[2])) {
				using (var xout = new StreamWriter(fs, Encoding.ASCII)) {
					StreamWriter w = xout;

					// few variables
					string label = "";
					bool jpc = false, com = false, incbin = false, even = false, labrule = false, labignore = false;
					LineProcessor cl = null, cx = null;

					// process input file line by line
					foreach (string line in File.ReadAllLines(args[0])) {
						redo:
						if(com) {
							// special case: trying to get a comment
							cx = new LineProcessor(line);

							if (cx.IsNull()) continue;

							if (cx.OnlyComment() && (!cx.LineComment || (cx.Comment.StartsWith("; !<") && cx.Comment.IndexOf(">") > 0)))
								cl.Comment = cx.Comment;

							else {
								// write the previous line out!
								string l = cl.GetLine(label, jpc, labrule);
								labrule = labignore;

								if (l.Length > 0) {
									w.WriteLine(l);

									// check to write an even
									if (even) {
										even = false;
										w.WriteLine("\t\teven");
									}
								}
								
								// pretend this line was normal
								com = false;
								cl = cx;
								goto redo;
							}

						} else {
							cl = new LineProcessor(line);

							// handle special cases
							if (cl.IsNull()) {
								continue;

							} else if (cl.OnlyComment()) {
								w.WriteLine(cl.Comment);

								if (cl.Comment == "; segment \"ROM\"") {
									w.WriteLine();
									w.WriteLine("ROM\t\tsection org(0)");
									w.WriteLine("\t\tinclude \"macros.asm\"");
									w.WriteLine("; ---------------------------------------------------------------------------");

								} else if (cl.Comment == "; segment \"RAM\"") {
									w.WriteLine("RAM\t\tsection bss, org($FFFF0000), size($10000)");
									labrule = labignore = true;

								} else if (even) {
									// write an even
									even = false;
									w.WriteLine("\t\teven");
								}

								continue;
							}

							// handle label
							if (cl.Label != null) label = cl.Label;
						}
						
						if (incbin) {
							// check for the end of file
							if (Files[0].End <= cl.Location) {
								incbin = false;
								Files.RemoveAt(0);
								goto redo;
							}

							// make sure this isn't just comment stuff
							if (!com) {
								cl.Part = null;
								cl.Instruction = null;
							}

						} else {
							// check segment for incbin data
							if (Files.Count > 0 && Files[0].Start <= cl.Location) {
								incbin = true;
								com = false;

								// convert to incbin
								labrule = true;
								cl.Instruction = "incbin \""+ Files[0].File +"\"";
								cl.Part = null;
								cl.Comment = null;
								even = true;
							}
						}

						// process comment commands
						if (cl.Comment != null) {
							while (cl.Comment.StartsWith("; !<")) {
								int left = cl.Comment.IndexOf(">");

								if (left > 0) {
									// this is a comment command
									string content = cl.Comment.Substring(4, left - 4);
									cl.Comment = "; " + cl.Comment.Substring(left + 1);
									string[] cmd = content.Split(' ');

									// process it
									switch (cmd[0].ToLowerInvariant()) {
										case "pcstick":
											jpc ^= true;
											break;

										case "ram": {
												if (cl.Part == null) break;
												string[] parts = cl.Part.Split(',');

												// convert arguments
												for (int x = 1;x < cmd.Length;x++) {
													int arg = int.Parse(cmd[x]);

													// figure out what is asked
													if (parts[arg].StartsWith("(") && (parts[arg].EndsWith(").l") || parts[arg].EndsWith(").w"))) {
														parts[arg] = "(" + parts[arg].Substring(0, parts[arg].Length - 2) + "&$FFFFFF)." + parts[arg][parts[arg].Length - 1];

													} else if (parts[arg].StartsWith("#")) {
														parts[arg] = "#(" + parts[arg].Substring(1, parts[arg].Length - 1) + ")&$FFFFFF";

													} else {
														if (parts[arg].StartsWith(" "))
															parts[arg] = " (" + parts[arg].Substring(1) + ")&$FFFFFF";
														else parts[arg] = "(" + parts[arg] + ")&$FFFFFF";
													}
												}

												cl.Part = string.Join(",", parts);
											}
											break;

										case "24": {
												if (cl.Part == null) break;
												string[] parts = cl.Part.Split(',');

												// convert arguments
												for (int x = 1;x < (cmd.Length & -2);x += 2) {
													int arg = int.Parse(cmd[x]);

													// normalize stuff
													bool space = parts[arg].StartsWith(" ");
													if (space) parts[arg] = parts[arg].Substring(1);

													// get the upper byte
													string upper = "$00";
													if (parts[arg].Length > 6)
														upper = parts[arg].Substring(0, parts[arg].Length - 6);

													// fix dis
													parts[arg] = (space ? " " : "") + "(" + upper + "<<24)|" + cmd[x + 1];
												}

												cl.Part = string.Join(",", parts);
											}
											break;

										case "rep": {
												if (cl.Part == null) break;
												string[] parts = cl.Part.Split(',');

												// convert arguments
												for (int x = 1;x < (cmd.Length & -2);x += 2) {
													int arg = int.Parse(cmd[x]);

													// normalize stuff
													bool space = parts[arg].StartsWith(" ");
													if (space) parts[arg] = parts[arg].Substring(1);

													// mod dis
													parts[arg] = (space ? " " : "") + cmd[x + 1];
												}

												cl.Part = string.Join(",", parts);
											}
											break;

										case "ins":
											cl.Instruction = string.Join(" ", cmd.Skip(1));
											if (cl.Instruction.Length == 0) cl.Instruction = null;
											break;

										case "part":
											cl.Part = string.Join(" ", cmd.Skip(1));
											if (cl.Part.Length == 0) cl.Part = null;
											break;

										case "label":
											cl.Label = string.Join(" ", cmd.Skip(1));
											if (cl.Label.Length == 0) cl.Label = null;
											break;

										case "even":
											even = true;
											break;

										case "eveno":
											even = false;
											break;

										case "out": {
												// get filename
												string fx = string.Join(" ", cmd.Skip(1));
												if(fx.Length == 0) {
													// just close and flush
													if(w != xout) {
														w.Flush();
														w.Close();
														w = xout;
													}

													break;
												}

												// delete file
												if (File.Exists(fx)) File.Delete(fx);
												mkdir(fx);

												// flush and close file if not the same
												if (w != xout) {
													w.Flush();
													w.Close();
												}

												// write include
												labrule = true;
												xout.WriteLine("\t\tinclude \""+ fx +"\"");

												if (even) {
													even = false;
													xout.WriteLine("\t\teven");
												}

												// store current output
												w = new StreamWriter(File.OpenWrite(fx), Encoding.ASCII);
											}
											break;

										case "print": {
												// store comment and clear it
												string cm = cl.Comment;
												cl.Comment = null;

												// write the line out!
												string ll = cl.GetLine(label, jpc, labrule);
												labrule = labignore;
												w.WriteLine(ll);

												// check to write an even
												if (even) {
													even = false;
													w.WriteLine("\t\teven");
												}
												com = false;

												// get comment back
												cl.Comment = cm;
												cl.Instruction = null;
												cl.Part = null;
												cl.Label = null;
											}
											break;

										default:
											Console.WriteLine("unknown command " + cmd[0]);
											break;
									}
								}
							}

							// delete comments without text
							if (incbin || cl.Comment.Trim().Length < 2) cl.Comment = null;

							// write the line out!
							string l = cl.GetLine(label, jpc, labrule);
							labrule = labignore;

							if (l.Length > 0) {
								w.WriteLine(l);

								// check to write an even
								if(even) {
									even = false;
									w.WriteLine("\t\teven");
								}
							}
							com = false;

						} else com = true;
					}

					// make sure extra file is closed
					if (w != xout) {
						w.Flush();
						w.Close();
					}
				}
			}
			
		}

		// make the parent dir
		private static void mkdir(string str) {
			if (str.Contains("/")) {
				string[] sa = str.Split('/');
				str = string.Join("/", sa.Take(sa.Length - 1));

			} else if (str.Contains("\\")) {
				string[] sa = str.Split('\\');
				str = string.Join("\\", sa.Take(sa.Length - 1));
			}

			// create derp
			Directory.CreateDirectory(str);
		}
	}

	struct Incbin {
		public readonly uint Start, End;
		public readonly string File;

		public Incbin(uint start, uint end, string file) {
			Start = start;
			End = end;
			File = file;
		}
	}

	class LineProcessor {
		public string Comment, Label, Instruction, Part, Segment;
		public uint Location;
		public bool Nothing, LineComment;

		public LineProcessor(string line) {
			Comment = null;
			Instruction = null;
			Part = null;
			Label = null;
			Nothing = true;
			LineComment = false;

			// deal with empty lines
			if (line.Length <= 13) return;
			Nothing = false;

			// read segment information
			Segment = line.Substring(0, 3);
			Location = uint.Parse(line.Substring(4, 8), NumberStyles.HexNumber);
			int i = 13;

			// check if there is a comment
			int cmt = line.IndexOf(';');

			if (cmt >= 0) {
				Comment = line.Substring(cmt);

				// special comment filter
				if (Comment.StartsWith("; CODE XREF:") || Comment.StartsWith("; DATA XREF:") || Comment.StartsWith("; RAM:") || 
					Comment.StartsWith("; ROM:") || Comment.EndsWith(" ...") ||
					Comment.StartsWith(";   ADDITIONAL PARENT FUNCTION") || Comment.StartsWith("; END OF FUNCTION CHUNK") || Comment.StartsWith("; START OF FUNCTION CHUNK") || Comment.StartsWith("; FUNCTION CHUNK AT") || Comment.StartsWith("; End of function") ||
					Program.DirComment.IsMatch(Comment) ||
					(Comment.Length == 5 && Comment.StartsWith("; '") && Comment.EndsWith("'"))) {
					Comment = null;

					
				} else if(Comment == "; =============== S U B R O U T I N E =======================================") {
					// fuck
					Comment = "; ---------------------------------------------------------------------------";
				}
			}

			if (Comment != null && cmt < 16) {
				// line only has a comment
				LineComment = true;
				return;
			}

			// check for label
			if (!line.StartsWith(" ") && !line.StartsWith("\t")) {
				while (i < (cmt >= 0 ? cmt : line.Length) && line[i] != ':' && line[i] != ' ' && line[i] != '\t') i++;

				if (i > 13) {
					// create the label
					Label = line.Substring(13, ++i - 13);
				}
			}

			// check for any content in-between stuffs
			while (i < (cmt >= 0 ? cmt : line.Length) && (line[i] == ' ' || line[i] == '\t')) ++i;

			// check instruction
			int st = i;
			while (i < (cmt >= 0 ? cmt : line.Length) && line[i] != ' ' && line[i] != '\t') ++i;

			if (st == i) goto skip;
			Instruction = line.Substring(st, i - st);

			// check the instruction arguments
			while (i < (cmt >= 0 ? cmt : line.Length) && (line[i] == ' ' || line[i] == '\t')) ++i;
			st = i;
			int ed = i;

			// find the end position of the arguments 
			while (i < (cmt >= 0 ? cmt : line.Length)) {
				if (line[i] != ' ' && line[i] != '\t') ed = i + 1;
				++i;
			}

			Part = line.Substring(st, ed - st);

			skip:
			if (Instruction != null && Part != null && Instruction.ToLowerInvariant() == "move" && Part.ToLowerInvariant().Contains("usp")) {
				Instruction = "move.l";     // manual fix for asm68k
			}
		}

		public string GetLine(string label, bool jpc, bool incrule) {
			// finally, put the line together
			string l = Label ?? "";
			if (Instruction != null) {
				// tab to 16
				l = tab(16, l) + Instruction;
			}

			if (Part != null) {
				if (Instruction[0] == 'd') {
					// special treatment because fuck ida
					if (Instruction[1] == 'c') {
						l += " " + Part.Replace("-*", "-" + label.Replace(":", ""));
						goto nopart;

					} else if (Instruction[1] == 's' && Instruction[2] == '.' && Instruction[3] == 'b') {
						if (Part == "2") {
							Part = "1";
							Instruction = Instruction.Replace('b', 'w');

						} else if (Part == "4") {
							Part = "1";
							Instruction = Instruction.Replace('b', 'l');
						}

						// fix entire line
						l = tab(16, Label ?? "") + Instruction + " " + Part.Replace("-*", "-" + label.Replace(":", ""));
						goto nopart;
					}
				}
				
				// check for pc relative fix
				if (jpc && (Instruction.ToLowerInvariant() == "jsr" || Instruction.ToLowerInvariant() == "jmp")) {
					if (Program.JSRPC.IsMatch(Part)) Part += "(pc)";
				}

				// tab to 24
				l = tab(24, l) + Part;
				nopart:;
			}

			if (Comment != null) {
				// print comment at 64
				l = tab(64, l) + Comment;
			}

			return (!incrule && Label != null ? "\n" : "") + l.TrimEnd();
		}

		public bool OnlyComment() {
			return Label == null && Instruction == null && Part == null;
		}

		public bool IsNull() {
			return OnlyComment() && Comment == null;
		}

		// create a string with some number of tabs
		public static string tab(int pos, string str) {
			int real = 0;

			// calculate the real length of the string (as if tabs were spaces)
			for (int i = 0;i < str.Length;i++) {
				if (str[i] != '\t') real++;
				else {
					real += 8 - (real & 7);
				}
			}

			// add enough tabs
			if (real > pos) return str;
			return str + new string('\t', (pos / 8) - (real / 8));
		}
	}
}
