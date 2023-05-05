using System;
using System.Collections.Generic;
using static MDASM.Program;

namespace MDASM {
	public class M68k {
		#region Init instructions
		public static List<AssemblyTokenMacroInternal> Instructions = new List<AssemblyTokenMacroInternal>() {
			// zero operand instructions
			new AssemblyTokenMacroInternal("nop", Nop, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("rts", Rts, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("rte", Rte, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("rtr", Rtr, EquateFlags.Locked | EquateFlags.AlignBefore),

			// single-operand instructions
			new AssemblyTokenMacroInternal("tst", Tst, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("tas", Tas, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("clr", Clr, EquateFlags.Locked | EquateFlags.AlignBefore),

			new AssemblyTokenMacroInternal("not", Not, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("neg", Neg, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("negx", Negx, EquateFlags.Locked | EquateFlags.AlignBefore),

			new AssemblyTokenMacroInternal("pea", Pea, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("ext", Ext, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("sex", Ext, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("swap", Swap, EquateFlags.Locked | EquateFlags.AlignBefore),

			// two operand instructions
			new AssemblyTokenMacroInternal("move", Move, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("movea", Movea, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("movem", Movem, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("moveq", Moveq, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("movep", Movep, EquateFlags.Locked | EquateFlags.AlignBefore),

			new AssemblyTokenMacroInternal("add", Add, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("addi", Addi, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("adda", Adda, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("addq", Addq, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("addx", Addx, EquateFlags.Locked | EquateFlags.AlignBefore),

			new AssemblyTokenMacroInternal("sub", Sub, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("subi", Subi, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("suba", Suba, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("subq", Subq, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("subx", Subx, EquateFlags.Locked | EquateFlags.AlignBefore),

			new AssemblyTokenMacroInternal("cmp", Cmp, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("cmpi", Cmpi, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("cmpa", Cmpa, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("cmpm", Cmpm, EquateFlags.Locked | EquateFlags.AlignBefore),

			new AssemblyTokenMacroInternal("and", And, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("andi", Andi, EquateFlags.Locked | EquateFlags.AlignBefore),

			new AssemblyTokenMacroInternal("or", Or, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("ori", Ori, EquateFlags.Locked | EquateFlags.AlignBefore),

			new AssemblyTokenMacroInternal("eor", Eor, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("eori", Eori, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("xor", Eor, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("xori", Eori, EquateFlags.Locked | EquateFlags.AlignBefore),

			new AssemblyTokenMacroInternal("bchg", Bchg, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("bclr", Bclr, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("btst", Btst, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("bset", Bset, EquateFlags.Locked | EquateFlags.AlignBefore),

			new AssemblyTokenMacroInternal("divs", Divs, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("divu", Divu, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("muls", Muls, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("mulu", Mulu, EquateFlags.Locked | EquateFlags.AlignBefore),

			new AssemblyTokenMacroInternal("asl", Asl, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("asr", Asr, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("lsl", Lsl, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("lsr", Lsr, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("rol", Rol, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("ror", Ror, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("roxl", Roxl, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("roxr", Roxr, EquateFlags.Locked | EquateFlags.AlignBefore),

			new AssemblyTokenMacroInternal("exg", Exg, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("lea", Lea, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("jmp", Jmp, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("jsr", Jsr, EquateFlags.Locked | EquateFlags.AlignBefore),

			// bcd instructions
			new AssemblyTokenMacroInternal("abcd", Abcd, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("sbcd", Sbcd, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("Nbcd", Nbcd, EquateFlags.Locked | EquateFlags.AlignBefore),

			// cc instructions
			new AssemblyTokenMacroInternal("st", St, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("sf", Sf, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("shi", Shi, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("sls", Sls, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("scc", Scc, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("shs", Scc, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("scs", Scs, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("slo", Scs, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("sne", Sne, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("seq", Seq, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("svc", Svc, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("svs", Svs, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("spl", Spl, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("smi", Smi, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("sge", Sge, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("slt", Slt, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("sgt", Sgt, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("sle", Sle, EquateFlags.Locked | EquateFlags.AlignBefore),

			new AssemblyTokenMacroInternal("bra", Bra, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("bsr", Bsr, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("bhi", Bhi, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("bls", Bls, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("bcc", Bcc, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("bhs", Bcc, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("bcs", Bcs, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("blo", Bcs, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("bne", Bne, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("beq", Beq, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("bvc", Bvc, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("bvs", Bvs, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("bpl", Bpl, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("bmi", Bmi, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("bge", Bge, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("blt", Blt, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("bgt", Bgt, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("ble", Ble, EquateFlags.Locked | EquateFlags.AlignBefore),

			new AssemblyTokenMacroInternal("dbt", Dbt, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("dbf", Dbf, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("dbhi", Dbhi, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("dbls", Dbls, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("dbcc", Dbcc, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("dbhs", Dbcc, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("dbcs", Dbcs, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("dblo", Dbcs, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("dbne", Dbne, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("dbeq", Dbeq, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("dbvc", Dbvc, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("dbvs", Dbvs, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("dbpl", Dbpl, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("dbmi", Dbmi, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("dbge", Dbge, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("dblt", Dblt, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("dbgt", Dbgt, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("dble", Dble, EquateFlags.Locked | EquateFlags.AlignBefore),

			// special instructions
			new AssemblyTokenMacroInternal("illegal", Illegal, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("reset", Reset, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("trapv", Trapv, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("trap", Trap, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("stop", Stop, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("link", Link, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("unlk", Unlink, EquateFlags.Locked | EquateFlags.AlignBefore),
			new AssemblyTokenMacroInternal("chk", Chk, EquateFlags.Locked | EquateFlags.AlignBefore),
		};

		public static void CreateInstructions() {
			foreach(AssemblyTokenMacroInternal m in Instructions) {
				CreateEquateInternal(m);
			}
		}
		#endregion

		#region Common Functionality
		private static int ProcSize(string size, int validsizes = 7, int emptysize = 2, bool validshort = false) {
			switch (size) {
				case "": if ((validsizes & emptysize) != 0) return emptysize; break;
				case "s": if (validshort && (validsizes & 1) != 0) return 1; break;
				case "b": if ((validsizes & 1) != 0) return 1; break;
				case "w": if ((validsizes & 2) != 0) return 2; break;
				case "l": if ((validsizes & 4) != 0) return 4; break;
			}

			FormatError("Invalid macro size parameter ." + size + "! Expected "+ ValidInstructionSizes[validsizes] + "!");
			return -1;
		}

		private static string[] ValidInstructionSizes = {
			"", ".b", ".w", ".b or .w",
			".l", ".b or .l", ".w or .l",
			".b, .w or .l"
		};

		private static OperandModeM68K[] ProcArgs(List<string> arguments, int argc, out TokenState state) => ProcArgs(arguments.ToArray(), argc, out state);

		private static OperandModeM68K[] ProcArgs(string[] arguments, int argc, out TokenState state) {
			state = TokenState.Static;
			if (argc != arguments.Length)
				FormatError("Incorrect number of arguments: Expected "+ argc +" but got "+ arguments.Length + "!");

			OperandModeM68K[] ops = new OperandModeM68K[arguments.Length];

			for(int i = 0;i < arguments.Length;i++) {
				char x = arguments[i][arguments[i].Length - 1];
				bool postincrement = x == '+', predecrement = arguments[i][0] == '-';

				if (arguments[i].Length == (postincrement | predecrement ? 3 : 2)) {
					// could be a register
					string c = arguments[i];

					if (postincrement) c = c.Substring(0, c.Length - 1);
					else if(predecrement) c = c.Substring(1);

					switch (c.ToLowerInvariant()) {
						case "sp":
							ops[i] = new OperandModeM68K(OperandEnumM68K.An, new object[] { 7 }, i, state);
							break;

						case "a0": case "a1": case "a2": case "a3": case "a4": case "a5": case "a6": case "a7":
							ops[i] = new OperandModeM68K(OperandEnumM68K.An, new object[] { arguments[i][1] & 0xF }, i, state);
							break;

						case "d0": case "d1": case "d2": case "d3": case "d4": case "d5": case "d6": case "d7":
							ops[i] = new OperandModeM68K(OperandEnumM68K.Dn, new object[] { arguments[i][1] & 0xF }, i, state);
							break;

						case "sr":
							ops[i] = new OperandModeM68K(OperandEnumM68K.Sr, new object[0], i, state);
							break;

						default:
							goto fail;
					}

					if (postincrement || predecrement) goto invalidformat;
					continue;

					fail:;

				} else if (arguments[i].Length == 3) {
					switch (arguments[i].ToLowerInvariant()) {
						case "ccr":
							ops[i] = new OperandModeM68K(OperandEnumM68K.Ccr, new object[0], i, state);
							continue;

						case "usp":
							ops[i] = new OperandModeM68K(OperandEnumM68K.Usp, new object[0], i, state);
							continue;

						case "ssp":
							ops[i] = new OperandModeM68K(OperandEnumM68K.Ssp, new object[0], i, state);
							continue;
					}
				}

				if (arguments[i][0] == '#') {
					// this is data
					AssemblyToken solved = Context.CalculateEquationTokens(arguments[i], 1);
					solved = Context.SolveTokens(solved, out TokenState sta);
					AssemblyTokenValue sv = solved as AssemblyTokenValue;

					if (sta > state) state = sta;
					if (sv is null) goto cantconvert;

					ops[i] = new OperandModeM68K(OperandEnumM68K.Data, new object[] { sv.Value }, i, state);
					continue;
				}

				if(arguments[i].Length >= 3) {

					if (x == ')' || x == '+') {
						// this could be many address modes, we need to be sure it is not just an address
						char sizetype = 'w';
						int startindex = predecrement ? 1 : 0, depth = 0, phase = 0, partn = 0, offset = -1, szoff = -1;
						byte[] part = new byte[] { 0xff, 0xff };
						bool nextissize = false;

						// check each char to determine what we are working with
						for (int y = startindex;y < arguments[i].Length - (postincrement ? 1 : 0);y++) {
							char c = (char)(arguments[i][y] | 0x20);
							bool cphase = false;

							if (nextissize) {
								nextissize = false;
								if (c != 'l' && c != 'w')
									FormatError("Expected .w or .l for argument " + (i + 1) + ", but got ." + c + "!");

								sizetype = (char)(c | 0x20);
								startindex = szoff = y + 1;
							}

							if (c == '(') {
								depth++;
								if (startindex < y) cphase = true;
								else startindex = y + 1;

							} else if (c == ')') {
								if (--depth == 0)
									cphase = true;

							} else if (c == ',') {
								if (depth == 1)
									cphase = true;

							} else if (c == '.') {
								if (depth == 1)
									nextissize = cphase = true;

							} else if (c == 'p') {
								if (phase == 0 && startindex == y) {
									phase--;

								} else if (phase == 11 && startindex + 1 == y)
									phase = 0x37;

							} else if (c == 'c') {
								if (phase == -1 && startindex + 1 == y)
									phase--;

							} else if (c == 's') {
								if (phase == 0 && startindex == y)
									phase = 11;

							} else if (c == 'd') {
								if (phase == 0 && startindex == y)
									phase = 15;

							} else if (c == 'a') {
								if (phase == 0 && startindex == y)
									phase = 10;

							} else if (c >= '0' && c <= '9') {
								if ((phase == 10 || phase == 15) && startindex + 1 == y)
									phase = (c & 0xF) | (phase == 15 ? 0x40 : 0x30);
							}

							if (cphase) {
								if (phase == -2 && startindex + 2 == y) {
									// this is pc, check if this is the first part checked
									if (partn != 0) goto invalidformat;
									part[partn++] = 0x7f;

								} else if (phase >= 0x30 && startindex + 2 == y) {
									if (partn >= 2) goto invalidformat;
									part[partn++] = (byte)(phase & 0x1F);

								} else if (y - startindex > 0) {
									offset = y;

								} else if(szoff != y) goto invalidformat;

								phase = 0;
								startindex = y + 1;
							}
						}

						// this is definitely valid.
						if (partn != 0) {
							dynamic val = 0;

							// check if any value offset was provided
							if(offset >= 0) {
								if (postincrement) goto invalidformat;

								AssemblyToken solved = Context.CalculateEquationTokens(arguments[i], 0, arguments[i].Length - offset);
								solved = Context.SolveTokens(solved, out TokenState sta);
								AssemblyTokenValue sv = solved as AssemblyTokenValue;

								if (sta > state) state = sta;
								if (sv is null) goto cantconvert;
								val = sv.Value;
							}
							
							// figure out which form to use
							if (partn == 1) {
								if (offset > 0) {
									if (part[0] == 0x7f)
										ops[i] = new OperandModeM68K(OperandEnumM68K.PCI16, new object[] { val }, i, state);

									else if (part[0] >= 0x10 && part[0] <= 0x17)
										ops[i] = new OperandModeM68K(OperandEnumM68K.AnI16, new object[] { val, part[0] }, i, state);

									else goto invalidformat;

								} else {
									// this is only An by itself, may or may not have post-increment or pre-decrement
									if(part[0] < 0x10 || part[0] > 0x17) {
										if(part[0] >= 0 && part[0] <= 7)
											FormatError("Argument " + (i + 1) + " is not in valid format: Data register indirect mode is does not exist in MC68000!");

										else goto invalidformat;
									}

									ops[i] = new OperandModeM68K(predecrement ? OperandEnumM68K.AnIPd : postincrement ? OperandEnumM68K.AnIPi : OperandEnumM68K.AnI, new object[] { part[0] }, i, state);
								}

							} else {
								if (part[0] == 0x7f)
									ops[i] = new OperandModeM68K(OperandEnumM68K.PCI8Xn, new object[] { val, part[1], sizetype }, i, state);

								else if (part[0] >= 0x10 && part[0] <= 0x17)
									ops[i] = new OperandModeM68K(OperandEnumM68K.AnI8Xn, new object[] { val, part[0], part[1], sizetype }, i, state);

								else goto invalidformat;
							}

							continue;
						}
					}
				}

				{
					int off = 0;
					char size = 'l';

					// check if size for XXXX.w or XXXXXXXX.l is defined.
					if (arguments[i].Length > 2 && arguments[i][arguments[i].Length - 2] == '.') {
						off = 2;
						char c = (char)(arguments[i][arguments[i].Length - 1] | 0x20);

						if (c != 'w' && c != 'l')
							FormatError("Expected .w or .l for argument " + (i + 1) + ", but got ." + c + "!");

						size = c;
					}
					
					AssemblyToken solved = Context.CalculateEquationTokens(arguments[i], 0, off);
					solved = Context.SolveTokens(solved, out TokenState sta);
					AssemblyTokenValue sv = solved as AssemblyTokenValue;

					if (sta > state) state = sta;
					if (sv is null) goto cantconvert;

					ops[i] = new OperandModeM68K(size == 'w' ? OperandEnumM68K.A16 : OperandEnumM68K.A32, new object[] { sv.Value }, i, state);
					continue;
				}
				
				invalidformat: FormatError("Argument " + (i + 1) + " is not in valid format: " + arguments[i] + "!");
				cantconvert:   FormatError("Argument " + (i + 1) + " could not be converted to a value: " + arguments[i] + "!");
			}

			return ops;
		}

		private static void CheckArgs(OperandModeM68K[] arguments, ushort[] modes, List<string> argstr) => CheckArgs(arguments, modes, argstr.ToArray());

		private static void CheckArgs(OperandModeM68K[] arguments, ushort[] modes, string[] argstr) {
			for(int i = 0;i < arguments.Length;i++) {
				int bit = arguments[i].AddressMode;
				if(bit == 7) bit += arguments[i].AddressReg;

				if((modes[i] & (1 << bit)) == 0)
					FormatError("Addressing mode is invalid for argument "+ (i + 1) +": "+ argstr[i] +"!");
			}
		}

		private static int CheckQuick(byte[] imm) {
			int data = GetImmValue(imm);

			if (data >= 1 && data <= 8)
				return data;

			if (data <= -1 && data >= -8)
				return -data;

			return 0;
		}

		public static int GetImmValue(byte[] imm) {
			int data = 0;

			for (int i = 0;i < imm.Length;i++)
				data |= imm[i] << (((imm.Length - 1) - i) * 8);

			return data;
		}

		private static int ProcSpecialModes(OperandModeM68K[] arguments) {
			int returnval = 0;

			for (int i = 0;i < arguments.Length;i++) {
				ushort type = 0xFF;

				switch (arguments[i].Mode) {
					case OperandEnumM68K.Sr: type = 0x01; break;
					case OperandEnumM68K.Ccr: type = 0x10; break;
					case OperandEnumM68K.Usp: type = 0x100; break;
					case OperandEnumM68K.Ssp: type = 0x1000; break;
				}

				if(type != 0xFF)
					returnval |= type * (i + 1);
			}

			return returnval;
		}

		private static byte[] InstructionSizes1 = { 0, 0, 1, 1, 2 };

		private static byte[] InstructionSizeswl = { 1, 1, 0, 0, 1 };
		#endregion

		#region Indirect
		public static Tuple<TokenState, AssemblyToken> Indirect(AssemblyTokenMacroRef Ref) {
			string Size = Ref.Size, Ins = null;

			// find out which instruction to execute
			int index = Size.IndexOf(".");
			if (index > 0) {
				Ins = Size.Substring(0, index);
				Ref.Size = Size.Substring(index + 1);

			} else {
				Ins = Size;
				Ref.Size = "";
			}

			Tuple<TokenState, AssemblyToken> Ret = null;

			// check if instruction exists, and execute it
			for(int i = 0;i < Instructions.Count;i ++)
				if (Ins.Equals(Instructions[i].Name, StringComparison.InvariantCultureIgnoreCase)) {
					Ret = Instructions[i].Code(Ref);
					break;
				}

			// if we didn't get a return value, instruction does not exist
			if (Ret == null)
				FormatError("Unknown MC68000 instruction " + Ins + "!");

			// restore proper size and return
			Ref.Size = Size;
			return Ret;
		}
		#endregion

		#region Rotate & Shift Opcodes
		public static Tuple<TokenState, AssemblyToken> Asl(AssemblyTokenMacroRef Ref) => _shift(Ref, 0, false);
		public static Tuple<TokenState, AssemblyToken> Asr(AssemblyTokenMacroRef Ref) => _shift(Ref, 0, true);
		public static Tuple<TokenState, AssemblyToken> Lsl(AssemblyTokenMacroRef Ref) => _shift(Ref, 1, false);
		public static Tuple<TokenState, AssemblyToken> Lsr(AssemblyTokenMacroRef Ref) => _shift(Ref, 1, true);
		public static Tuple<TokenState, AssemblyToken> Rol(AssemblyTokenMacroRef Ref) => _shift(Ref, 3, false);
		public static Tuple<TokenState, AssemblyToken> Ror(AssemblyTokenMacroRef Ref) => _shift(Ref, 3, true);
		public static Tuple<TokenState, AssemblyToken> Roxl(AssemblyTokenMacroRef Ref) => _shift(Ref, 2, false);
		public static Tuple<TokenState, AssemblyToken> Roxr(AssemblyTokenMacroRef Ref) => _shift(Ref, 2, true);

		private static Tuple<TokenState, AssemblyToken> _shift(AssemblyTokenMacroRef Ref, int ins, bool right) {
			OperandModeM68K[] args;
			int dr = right ? 0 : 1;

			if (Ref.Arguments.Count > 1) {
				// x dx,dy or x #,dy
				int size = ProcSize(Ref.Size);
				args = ProcArgs(Ref.Arguments, 2, out TokenState sta);
				CheckArgs(args, new ushort[] { 0x801, 1 }, Ref.Arguments);

				int reg = 0, ir = args[0].Mode == OperandEnumM68K.Dn ? 0x20 : 0;

				if (ir == 0) {
					int can = CheckQuick(InternalMacros.GetDataBytes(size, args[0].Parts[0], true, size));
					if (can <= 0 || can > 8)
						FormatError("Value is out of range!");

					reg = can == 8 ? 0 : can;

					// if this is ror.b/rol.b #8,dx, its useless
					if (Options.OptInefficient && sta < TokenState.Indeterminate && can == 8 && ins == 3 && size == 1)
						return new Tuple<TokenState, AssemblyToken>(sta, new AssemblyTokenData(new byte[0]));

				} else reg = args[0].AddressReg;

				return new Tuple<TokenState, AssemblyToken>(sta, new AssemblyTokenData(new byte[] { (byte)(0xE0 | (reg << 1) | dr), (byte)((ins << 3) | (InstructionSizes1[size] << 6) | ir | args[1].AddressReg) }));
			}

			// x ea
			ProcSize(Ref.Size, 2, 2);
			args = ProcArgs(Ref.Arguments, 1, out TokenState state);
			CheckArgs(args, new ushort[] { 0x1FC }, Ref.Arguments);

			List<byte> bytes = new List<byte>() { (byte)(0xE0 | (ins << 1) | dr), (byte)(0xC0 | (args[0].AddressMode << 3) | args[0].AddressReg) };
			bytes.AddRange(args[0].ExtraData(2, bytes.Count));
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}
		#endregion

		#region Mul & Div Opcodes
		public static Tuple<TokenState, AssemblyToken> Divs(AssemblyTokenMacroRef Ref) => _muldiv(Ref, false, true);
		public static Tuple<TokenState, AssemblyToken> Divu(AssemblyTokenMacroRef Ref) => _muldiv(Ref, false, false);
		public static Tuple<TokenState, AssemblyToken> Muls(AssemblyTokenMacroRef Ref) => _muldiv(Ref, true, true);
		public static Tuple<TokenState, AssemblyToken> Mulu(AssemblyTokenMacroRef Ref) => _muldiv(Ref, true, false);

		private static Tuple<TokenState, AssemblyToken> _muldiv(AssemblyTokenMacroRef Ref, bool ismul, bool signed) {
			ProcSize(Ref.Size, 2, 2);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 2, out TokenState state);
			CheckArgs(args, new ushort[] { 0xFFD, 1 }, Ref.Arguments);

			// check if we can optimize this away, or to a neg...
			if (Options.OptInefficient && state < TokenState.Indeterminate && args[0].Mode == OperandEnumM68K.Data) {
				int val = GetImmValue(args[0].ExtraData(2, 2));

				if (val == 1)
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[0]));

				if (signed && val == -1)
					return _notneg(Ref, new string[] { Ref.Arguments[1] }, true, false);
			}

			List<byte> bytes = new List<byte>() { (byte)((ismul ? 0xC0 : 0x80) | (signed ? 1 : 0) | (args[1].AddressReg << 1)), (byte)(0xC0 | (args[0].AddressMode << 3) | args[0].AddressReg) };
			bytes.AddRange(args[0].ExtraData(2, bytes.Count));
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}
		#endregion

		#region Not & Neg Opcodes
		public static Tuple<TokenState, AssemblyToken> Not(AssemblyTokenMacroRef Ref) => _notneg(Ref, Ref.Arguments.ToArray(), false, false);
		public static Tuple<TokenState, AssemblyToken> Neg(AssemblyTokenMacroRef Ref) => _notneg(Ref, Ref.Arguments.ToArray(), true, false);
		public static Tuple<TokenState, AssemblyToken> Negx(AssemblyTokenMacroRef Ref) => _notneg(Ref, Ref.Arguments.ToArray(), true, true);

		private static Tuple<TokenState, AssemblyToken> _notneg(AssemblyTokenMacroRef Ref, string[] Arguments, bool isneg, bool isnegx) {
			int size = ProcSize(Ref.Size);
			OperandModeM68K[] args = ProcArgs(Arguments, 1, out TokenState state);
			CheckArgs(args, new ushort[] { 0x1FD }, Arguments);

			List<byte> bytes = new List<byte>() { (byte)(isneg ? isnegx ? 0x40 : 0x44 : 0x46), (byte)((InstructionSizes1[size] << 6) | (args[0].AddressMode << 3) | args[0].AddressReg) };
			bytes.AddRange(args[0].ExtraData(size, bytes.Count));
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}
		#endregion

		#region Lea & Pea Opcodes
		public static Tuple<TokenState, AssemblyToken> Pea(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size, 4, 4);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 1, out TokenState state);
			CheckArgs(args, new ushort[] { 0x7E4 }, Ref.Arguments);

			List<byte> bytes = new List<byte>() { 0x48, (byte)((args[0].AddressMode << 6) | args[0].AddressReg) };
			bytes.AddRange(args[0].ExtraData(4, bytes.Count));
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}

		public static Tuple<TokenState, AssemblyToken> Lea(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size, 4, 4);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 2, out TokenState state);
			CheckArgs(args, new ushort[] { 0x7E4, 2 }, Ref.Arguments);

			List<byte> bytes = new List<byte>() { (byte)(0x41 | (args[1].AddressReg << 1)), (byte)(0xC0 | (args[0].AddressMode << 3) | args[0].AddressReg) };
			bytes.AddRange(args[0].ExtraData(4, bytes.Count));
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}
		#endregion

		#region Add & Sub & Cmp Opcodes
		public static Tuple<TokenState, AssemblyToken> Add(AssemblyTokenMacroRef Ref) => _addsubcmp('\0', Ref, 0);
		public static Tuple<TokenState, AssemblyToken> Addi(AssemblyTokenMacroRef Ref) => _addsubcmp('i', Ref, 0);
		public static Tuple<TokenState, AssemblyToken> Adda(AssemblyTokenMacroRef Ref) => _addsubcmp('a', Ref, 0);
		public static Tuple<TokenState, AssemblyToken> Addq(AssemblyTokenMacroRef Ref) => _addsubcmp('q', Ref, 0);
		public static Tuple<TokenState, AssemblyToken> Sub(AssemblyTokenMacroRef Ref) => _addsubcmp('\0', Ref, 1);
		public static Tuple<TokenState, AssemblyToken> Subi(AssemblyTokenMacroRef Ref) => _addsubcmp('i', Ref, 1);
		public static Tuple<TokenState, AssemblyToken> Suba(AssemblyTokenMacroRef Ref) => _addsubcmp('a', Ref, 1);
		public static Tuple<TokenState, AssemblyToken> Subq(AssemblyTokenMacroRef Ref) => _addsubcmp('q', Ref, 1);
		public static Tuple<TokenState, AssemblyToken> Cmp(AssemblyTokenMacroRef Ref) => _addsubcmp('\0', Ref, -1);
		public static Tuple<TokenState, AssemblyToken> Cmpi(AssemblyTokenMacroRef Ref) => _addsubcmp('i', Ref, -1);
		public static Tuple<TokenState, AssemblyToken> Cmpa(AssemblyTokenMacroRef Ref) => _addsubcmp('a', Ref, -1);

		private static Tuple<TokenState, AssemblyToken> _addsubcmp(char Mode, AssemblyTokenMacroRef Ref, int ins) {
			int size = ProcSize(Ref.Size);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 2, out TokenState state);
			List<byte> bytes = new List<byte>();

			// check if we can optimize this to addq/subq
			byte[] imm = null;
			if (args[0].Mode == OperandEnumM68K.Data) {
				imm = InternalMacros.GetDataBytes(size, args[0].Parts[0], true, size);

				if (ins >= 0 && (Mode == 'q' || Options.OptAddqSubq)) {
					// addq/subq
					int can = CheckQuick(imm);
					if (ins > 0) can = -can;

					if (can > 0) {
						CheckArgs(args, new ushort[] { 0x800, 0x1FF }, Ref.Arguments);
						return _addqsubq(can, size, args[1], state, true);

					} else if (can < 0) {
						CheckArgs(args, new ushort[] { 0x800, 0x1FF }, Ref.Arguments);
						return _addqsubq(-can, size, args[1], state, false);
					}

					if (Mode == 'q')
						FormatError("Value is out of range!");
				}

				if((Mode == 'i' || args[1].Mode != OperandEnumM68K.Dn) && Mode != 'a') {
					// addi/subi/cmpi
					CheckArgs(args, new ushort[] { 0x800, 0x1FD }, Ref.Arguments);

					// check if we can optimize this to tst or nothing
					if (Options.OptInefficient && state < TokenState.Indeterminate && GetImmValue(imm) == 0) {
						if (ins < 0) return _clrtst(Ref, new string[] { Ref.Arguments[1] }, false);
						return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[0]));
					}

					bytes.Add((byte)(ins == 0 ? 6 : ins > 0 ? 4 : 0xC));
					bytes.Add((byte)((InstructionSizes1[size] << 6) | (args[1].AddressMode << 3) | args[1].AddressReg));

					if (imm.Length == 1) bytes.Add(0);		// lol
					bytes.AddRange(imm);
					bytes.AddRange(args[1].ExtraData(size, bytes.Count));
					goto ret;
				}

			} else if(Mode == 'q')
				FormatError("The " + (ins == 0 ? "add" : "sub") + "q instruction is valid only when argument 1 is immediate!");

			if (args[1].Mode == OperandEnumM68K.An) {
				// adda/suba/cmpa
				if(Mode == 'i')
					FormatError("The " + (ins == 0 ? "add" : ins > 0 ? "sub" : "cmp") + "i instruction is valid only when argument 1 is immediate!");
				
				CheckArgs(args, new ushort[] { 0xFFF, 2 }, Ref.Arguments);

				// check if we can optimize from .l to .w
				if(Options.OptAddrImm && args[0].Mode == OperandEnumM68K.Data && size == 4) {
					int val = GetImmValue(args[0].ExtraData(size, bytes.Count));

					if (val < 0x8000 && val >= -0x8000)
						size = 2;
				}

				bytes.Add((byte)((ins == 0 ? 0xD0 : ins > 0 ? 0x90 : 0xB0) | (args[1].AddressReg << 1) | InstructionSizeswl[size]));
				bytes.Add((byte)(0xC0 | (args[0].AddressMode << 3) | args[0].AddressReg));
				bytes.AddRange(args[0].ExtraData(size, bytes.Count));

			} else {
				CheckArgs(args, new ushort[] { 0xFFF, 0x1FD }, Ref.Arguments);
				int op = (args[1].Mode == OperandEnumM68K.Dn ? 0 : (args[0].Mode == OperandEnumM68K.Dn ? 1 : 2));

				if(op == 2)
					FormatError("At least one argument must be data register direct for "+ (ins == 0 ? "add" : ins > 0 ? "sub" : "cmp") + " instruction!");

				bytes.Add((byte)((ins == 0 ? 0xD0 : ins > 0 ? 0x90 : 0xB0) | (args[op ^ 1].AddressReg << 1) | op));
				bytes.Add((byte)((InstructionSizes1[size] << 6) | (args[op].AddressMode << 3) | args[op].AddressReg));
				bytes.AddRange(args[op].ExtraData(size, bytes.Count));

				// check if we can optimize this to tst or nothing
				if (Options.OptInefficient && args[0].Mode == OperandEnumM68K.Data && GetImmValue(args[0].ExtraData(size, bytes.Count)) == 0) {
					if (ins < 0) return _clrtst(Ref, new string[] { Ref.Arguments[1] }, false);
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[0]));
				}
			}
			
			ret: return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}

		private static Tuple<TokenState, AssemblyToken> _addqsubq(int value, int size, OperandModeM68K dest, TokenState state, bool isadd) {
			List<byte> bytes = new List<byte>() { (byte)((isadd ? 0x50 : 0x51) | (value == 8 ? 0 : value << 1)), (byte)((InstructionSizes1[size] << 6) | (dest.AddressMode << 3) | dest.AddressReg) };
			bytes.AddRange(dest.ExtraData(size, bytes.Count));
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}

		public static Tuple<TokenState, AssemblyToken> Addx(AssemblyTokenMacroRef Ref) => _addxsubx(Ref, true);
		public static Tuple<TokenState, AssemblyToken> Subx(AssemblyTokenMacroRef Ref) => _addxsubx(Ref, false);

		public static Tuple<TokenState, AssemblyToken> _addxsubx(AssemblyTokenMacroRef Ref, bool isadd) {
			int size = ProcSize(Ref.Size);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 2, out TokenState state);
			CheckArgs(args, new ushort[] { 0x11, 0x11 }, Ref.Arguments);

			if (args[0].Mode != args[1].Mode)
				FormatError("Both of the arguments for "+ (isadd ? "add" : "sub") +"x instruction must be the same!");

			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] {
				(byte)((isadd ? 0xD1 : 0x91) | (args[1].AddressReg << 1)),
				(byte)((InstructionSizes1[size] << 6) | args[0].AddressReg | (args[0].Mode == OperandEnumM68K.Dn ? 0 : 0x8))
			}));
		}

		public static Tuple<TokenState, AssemblyToken> Cmpm(AssemblyTokenMacroRef Ref) {
			int size = ProcSize(Ref.Size);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 2, out TokenState state);
			CheckArgs(args, new ushort[] { 0x8, 0x8 }, Ref.Arguments);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { (byte)(0xB1 | (args[1].AddressReg << 1)), (byte)(0x8 | (InstructionSizes1[size] << 6) | args[0].AddressReg) }));
		}
		#endregion

		#region And & Or & Eor Opcodes
		public static Tuple<TokenState, AssemblyToken> And(AssemblyTokenMacroRef Ref) => _andeor('\0', Ref, true, false);
		public static Tuple<TokenState, AssemblyToken> Andi(AssemblyTokenMacroRef Ref) => _andeor('i', Ref, true, false);
		public static Tuple<TokenState, AssemblyToken> Or(AssemblyTokenMacroRef Ref) => _andeor('\0', Ref, false, false);
		public static Tuple<TokenState, AssemblyToken> Ori(AssemblyTokenMacroRef Ref) => _andeor('i', Ref, false, false);
		public static Tuple<TokenState, AssemblyToken> Eor(AssemblyTokenMacroRef Ref) => _andeor('\0', Ref, false, true);
		public static Tuple<TokenState, AssemblyToken> Eori(AssemblyTokenMacroRef Ref) => _andeor('i', Ref, false, true);

		private static Tuple<TokenState, AssemblyToken> _andeor(char Mode, AssemblyTokenMacroRef Ref, bool isand, bool iseor) {
			int size = ProcSize(Ref.Size);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 2, out TokenState state);
			List<byte> bytes = new List<byte>();

			if (args[0].Mode == OperandEnumM68K.Data && (Mode == 'i' || args[1].Mode != OperandEnumM68K.Dn || iseor)) {
				// check if we can optimize this away
				byte[] imm = args[0].ExtraData(size, bytes.Count);
				int val = GetImmValue(imm);

				if (state < TokenState.Indeterminate && Options.OptInefficient) {
					// optimize and and eor instructions if source is #0
					if((!isand || iseor) && val == 0)
						return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[0]));

					// optimize and if source is #FF, #FFFF or #FFFFFFFF
					else if((size == 1 && val == 0xFF) || (size == 2 && val == 0xFFFF) || (size == 4 && val == -1)) {
						if(isand)
							return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[0]));

						if (iseor) return _notneg(Ref, new string[] { Ref.Arguments[1] }, false, false);
					}
				}

				// andi
				int spcmode = ProcSpecialModes(args);
				switch (spcmode) {
					case 0:
						// normal andi/ori/eori instruction
						CheckArgs(args, new ushort[] { 0x800, 0x1FD }, Ref.Arguments);

						bytes.Add((byte)(isand ? 2 : iseor ? 0xA : 0));
						bytes.Add((byte)((InstructionSizes1[size] << 6) | (args[1].AddressMode << 3) | args[1].AddressReg));
						bytes.AddRange(imm);
						bytes.AddRange(args[1].ExtraData(size, bytes.Count));
						break;

					case 0x2: // andi/ori/eori #, sr
						ProcSize(Ref.Size, 2);
						CheckArgs(args, new ushort[] { 0x800, 0xFFFF }, Ref.Arguments);
						bytes.AddRange(new byte[] { (byte)(isand ? 2 : iseor ? 0xA : 0), 0x7C });
						bytes.AddRange(imm);
						break;

					case 0x20: // andi/ori/eori #, ccr
						ProcSize(Ref.Size, 3, 1);
						CheckArgs(args, new ushort[] { 0x800, 0xFFFF }, Ref.Arguments);
						bytes.AddRange(new byte[] { (byte)(isand ? 2 : iseor ? 0xA : 0), 0x3C });
						bytes.AddRange(imm);
						break;
				}

			} else {
				// and
				CheckArgs(args, new ushort[] { 0xFFD, 0x1FD }, Ref.Arguments);
				int op = (args[1].Mode == OperandEnumM68K.Dn ? 0 : (args[0].Mode == OperandEnumM68K.Dn ? 1 : 2));

				if (iseor) {
					if ((op == 0 & args[0].Mode != OperandEnumM68K.Dn) || op == 2)
						FormatError("Argument 1 must be data register direct for eor instruction!");

					op = 1;

				} else if (op == 2)
					FormatError("At least one argument must be data register direct for " + (isand ? "and" : "or") + " instruction!");

				if (Options.OptInefficient && state < TokenState.Indeterminate && args[0].Mode == OperandEnumM68K.Data) {
					// check if we can optimize this away
					int val = GetImmValue(args[0].ExtraData(size, bytes.Count));

					// optimize and and eor instructions if source is #0
					if ((!isand || iseor) && val == 0)
						return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[0]));

					// optimize and if source is #FF, #FFFF or #FFFFFFFF
					else if ((size == 1 && val == 0xFF) || (size == 2 && val == 0xFFFF) || (size == 4 && val == -1)) {
						if (isand)
							return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[0]));

						if (iseor) return _notneg(Ref, new string[] { Ref.Arguments[1] }, false, false);
					}
				}

				bytes.Add((byte)((isand ? 0xC0 : iseor ? 0xB0 : 0x80) | (args[op ^ 1].AddressReg << 1) | op));
				bytes.Add((byte)((InstructionSizes1[size] << 6) | (args[op].AddressMode << 3) | args[op].AddressReg));
				bytes.AddRange(args[op].ExtraData(size, bytes.Count));
			}
			
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}
		#endregion

		#region Tst & Tas & Clr Opcodes
		public static Tuple<TokenState, AssemblyToken> Clr(AssemblyTokenMacroRef Ref) => _clrtst(Ref, Ref.Arguments.ToArray(), true);
		public static Tuple<TokenState, AssemblyToken> Tst(AssemblyTokenMacroRef Ref) => _clrtst(Ref, Ref.Arguments.ToArray(), false);

		public static Tuple<TokenState, AssemblyToken> _clrtst(AssemblyTokenMacroRef Ref, string[] Arguments, bool isclr) {
			int size = ProcSize(Ref.Size);
			OperandModeM68K[] args = ProcArgs(Arguments, 1, out TokenState state);
			CheckArgs(args, new ushort[] { 0x1FD }, Arguments);

			List<byte> bytes = new List<byte>() { (byte)(isclr ? 0x42 : 0x4A), (byte)((InstructionSizes1[size] << 6) | (args[0].AddressMode << 3) | args[0].AddressReg) };
			bytes.AddRange(args[0].ExtraData(size, bytes.Count));
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}

		public static Tuple<TokenState, AssemblyToken> Tas(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size, 1, 1);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 1, out TokenState state);
			CheckArgs(args, new ushort[] { 0x1FD }, Ref.Arguments);

			List<byte> bytes = new List<byte>() { 0x4A, (byte)(0xC0 | (args[0].AddressMode << 3) | args[0].AddressReg) };
			bytes.AddRange(args[0].ExtraData(1, bytes.Count));
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}
		#endregion

		#region Move Opcodes
		public static Tuple<TokenState, AssemblyToken> Moveq(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size, 5, 4);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 2, out TokenState state);
			CheckArgs(args, new ushort[] { 0x800, 1 }, Ref.Arguments);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { (byte)(0x70 | args[1].Parts[0] << 1), InternalMacros.GetDataBytes(1, args[0].Parts[0], true)[0] }));
		}

		public static Tuple<TokenState, AssemblyToken> Movep(AssemblyTokenMacroRef Ref) {
			int size = ProcSize(Ref.Size, 6);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 2, out TokenState state);
			CheckArgs(args, new ushort[] { 0x25, 0x25 }, Ref.Arguments);

			if(args[0].Mode != OperandEnumM68K.Dn && args[1].Mode != OperandEnumM68K.Dn)
				FormatError("One of the arguments must be a data register, and other address register indirect!");

			int dn = args[0].Mode == OperandEnumM68K.Dn ? 0 : 1;

			List<byte> bytes = new List<byte>() { (byte)(1 | (args[dn].AddressReg << 1)), (byte)((0x8 | InstructionSizeswl[size] << 6) | ((dn ^ 1) << 7) | args[dn ^ 1].AddressReg) };
			bytes.AddRange(args[dn ^ 1].Mode == OperandEnumM68K.AnI ? new byte[2] : args[dn ^ 1].ExtraData(size, bytes.Count));
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}

		public static Tuple<TokenState, AssemblyToken> Move(AssemblyTokenMacroRef Ref) => _move('\0', Ref);
		public static Tuple<TokenState, AssemblyToken> Movea(AssemblyTokenMacroRef Ref) => _move('a', Ref);
		private static byte[] InstructionSizesMove = { 1, 1, 3, 3, 2 };

		private static Tuple<TokenState, AssemblyToken> _move(char Mode, AssemblyTokenMacroRef Ref) {
			int size = ProcSize(Ref.Size);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 2, out TokenState state);
			List<byte> bytes = new List<byte>();

			if(Mode == 'a' && args[1].Mode != OperandEnumM68K.An)
				FormatError("Expected argument 2 for movea to be address register direct, but it was " + Ref.Arguments[1] +"!");

			int spcmode = ProcSpecialModes(args);
			switch (spcmode) {
				case 0:
					// normal move instruction, or movea with the above exception
					CheckArgs(args, new ushort[] { 0xFFF, 0x1FF }, Ref.Arguments);

					if (state < TokenState.Indeterminate && args[0].Mode == OperandEnumM68K.Data) {
						int val = GetImmValue(args[0].ExtraData(size, bytes.Count));

						// check if we can optimize this to moveq
						if (size == 4 && Options.OptMoveq && args[1].Mode == OperandEnumM68K.Dn) {

							if (val < 0x80 && val >= -0x80)
								return Moveq(Ref);

						} else if (args[1].Mode == OperandEnumM68K.An) {
							// check if we can optimize the data size
							if(size == 4 && Options.OptAddrImm && val < 0x8000 && val >= -0x8000)
								size = 2;

							// check if we can optimize this to clr
						} else if (Options.OptClear && val == 0)
							return _clrtst(Ref, new string[] { Ref.Arguments[1] }, true);
					}

					bytes.Add((byte)((InstructionSizesMove[size] << 4) | (args[1].AddressReg << 1) | (args[1].AddressMode >> 2)));
					bytes.Add((byte)((args[1].AddressMode << 6) | (args[0].AddressMode << 3) | args[0].AddressReg));
					bytes.AddRange(args[0].ExtraData(size, bytes.Count));
					bytes.AddRange(args[1].ExtraData(size, bytes.Count));
					break;

				case 0x1: // move sr, <dst>
					ProcSize(Ref.Size, 2);
					CheckArgs(args, new ushort[] { 0xFFFF, 0x1FD }, Ref.Arguments);
					bytes.AddRange(new byte[] { 0x40, (byte)(0xC0 | (args[1].AddressMode << 3) | args[1].AddressReg) });
					bytes.AddRange(args[1].ExtraData(2, bytes.Count));
					break;

				case 0x2: // move <src>, sr
					ProcSize(Ref.Size, 2);
					CheckArgs(args, new ushort[] { 0xFFD, 0xFFFF }, Ref.Arguments);
					bytes.AddRange(new byte[] { 0x46, (byte)(0xC0 | (args[0].AddressMode << 3) | args[0].AddressReg) });
					bytes.AddRange(args[0].ExtraData(2, bytes.Count));
					break;

				case 0x20: // move <src>, ccr
					ProcSize(Ref.Size, 3);
					CheckArgs(args, new ushort[] { 0xFFD, 0xFFFF }, Ref.Arguments);
					bytes.AddRange(new byte[] { 0x44, (byte)(0xC0 | (args[0].AddressMode << 3) | args[0].AddressReg) });
					bytes.AddRange(args[0].ExtraData(2, bytes.Count));
					break;

				case 0x100: case 0x200: // move usp, an		// move an, usp
					ProcSize(Ref.Size, 4);
					CheckArgs(args, spcmode == 0x100 ? new ushort[] { 0xFFFF, 2 } : new ushort[] { 2, 0xFFFF }, Ref.Arguments);
					bytes.AddRange(new byte[] { 0x4E, (byte)(0x60 | (spcmode == 0x100 ? 0x8 | args[1].AddressReg : args[0].AddressReg)) });
					break;

				default:
					FormatError("Invalid source and destination addressing mode: " + Ref.Arguments[0] +", " + Ref.Arguments[1] +"!");
					break;
			}

			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}
		#endregion

		#region Movem Opcode
		public static Tuple<TokenState, AssemblyToken> Movem(AssemblyTokenMacroRef Ref) {
			if (Ref.Arguments.Count != 2)
				FormatError("Incorrect number of arguments: Expected 2 but got " + Ref.Arguments.Count + "!");

			int size = ProcSize(Ref.Size, 6);
			ushort[] bits = MovemBits(Ref.Arguments);
			int[] bitc = CountBits(bits);

			// check bits mode
			int ch = bitc[0] >= bitc[1] ? 0 : 1;
			
			if(bitc[ch] == 0)
				FormatError("The movem instruction expects either argument to be a register list!");

			if (bitc[0] > 0 && bitc[1] > 0)
				FormatError("The movem instruction expects only a single argument to be a register list!");

			// seems valid, process the other arguemnt
			string[] _a = new string[] { Ref.Arguments[ch ^ 1] };
			OperandModeM68K[] args = ProcArgs(_a, 1, out TokenState state);
			CheckArgs(args, new ushort[] { (ushort)(ch == 0 ? 0x1F4 : 0x7EC) }, _a);

			List<byte> bytes = new List<byte>() { (byte)(0x48 | (ch << 2)), (byte)(0x80 | (InstructionSizeswl[size] << 6) | (args[0].AddressMode << 3) | args[0].AddressReg) };
			bytes.AddRange(InternalMacros.GetDataBytes(2, args[0].Mode == OperandEnumM68K.AnIPd ? ReverseBits(bits[ch]) : bits[ch], true, 2));
			bytes.AddRange(args[0].ExtraData(size, bytes.Count));
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}

		private static ushort[] MovemBits(List<string> Arguments) {
			ushort[] bits = new ushort[Arguments.Count];

			for(int i = 0;i < Arguments.Count;i++) {
				int phase = 0, reg1 = -1, reg2 = -1;

				for(int y = 0;y < Arguments[i].Length;y++) {
					bool error = false, proc = false;
					char c = (char)(Arguments[i][y] | 0x20);

					if(c == 'd') {
						if (phase == 0) {
							reg1 = 0;
							phase++;

						} else if(phase == 3) {
							reg2 = 0;
							phase++;

						} else error = true;

					} else if (c == 'a') {
						if (phase == 0) {
							reg1 = 8;
							phase++;

						} else if (phase == 3) {
							reg2 = 8;
							phase++;

						} else error = true;

					} else if (c == '-') {
						if (phase != 2)
							error = true;

						phase++;

					} else if (c == '/') {
						if(phase == 2)
							proc = true;

						else if (phase != 0)
							error = true;

					} else if (c >= '0' && c <= '9') {
						if (phase == 1) {
							reg1 |= c & 7;
							phase++;

						} else if (phase == 4) {
							reg2 |= c & 7;
							proc = true;

						} else error = true;
					} else error = true;

					if (proc) {
						if (phase == 2) {
							// x/
							if ((bits[i] & 1 << reg1) != 0)
								FormatError("Register " + ((reg1 & 8) == 0 ? 'd' : 'a') + (reg1 & 7) + " was set twice!");

							bits[i] |= (ushort)(1 << reg1);

						} else if (phase == 4) {
							// x-y
							for (int x = reg1;x <= reg2;x++) {
								if ((bits[i] & 1 << x) != 0)
									FormatError("Register "+ ((x & 8) == 0 ? 'd' : 'a') + (x & 7) +" was set twice!");

								bits[i] |= (ushort)(1 << x);
							}

						} else error = true;
						phase = 0;
						reg2 = reg1 = -1;
					}

					// if error happened
					if (error) {
						bits[i] = 0;
						phase = 0;
						break;
					}
				}

				if(phase == 2) {
					// x/
					if ((bits[i] & 1 << reg1) != 0)
						FormatError("Register " + ((reg1 & 8) == 0 ? 'd' : 'a') + (reg1 & 7) + " was set twice!");

					bits[i] |= (ushort)(1 << reg1);

				} else if(phase != 0) bits[i] = 0;
			}

			return bits;
		}

		private static int[] CountBits(ushort[] bits) {
			int[] bc = new int[bits.Length];

			for (int i = 0;i < bits.Length;i++)
				for (int b = 1;b <= 0x8000;b <<= 1)
					if ((bits[i] & b) != 0)
						bc[i]++;

			return bc;
		}

		private static ushort ReverseBits(ushort v) {
			ushort r = 0;
			for (int i = 0;i < 16;i++)
				r |= (ushort)(((v & (1 << i)) >> i) << (15 - i));
			return r;
		}
		#endregion

		#region BCD Opcodes
		public static Tuple<TokenState, AssemblyToken> Abcd(AssemblyTokenMacroRef Ref) => _asbcd(Ref, true);
		public static Tuple<TokenState, AssemblyToken> Sbcd(AssemblyTokenMacroRef Ref) => _asbcd(Ref, false);

		private static Tuple<TokenState, AssemblyToken> _asbcd(AssemblyTokenMacroRef Ref, bool isadd) {
			ProcSize(Ref.Size, 1, 1);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 2, out TokenState state);
			CheckArgs(args, new ushort[] { 0x11, 0x11 }, Ref.Arguments);

			if (args[0].Mode != args[1].Mode)
				FormatError("Both of the arguments for " + (isadd ? "a" : "s") + "bcd instruction must be the same!");

			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { (byte)((isadd ? 0xC1 : 0x81) | (args[1].AddressReg << 1)), (byte)(args[0].AddressReg | (args[0].Mode == OperandEnumM68K.Dn ? 0 : 0x8)) }));
		}

		private static Tuple<TokenState, AssemblyToken> Nbcd(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size, 1, 1);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 1, out TokenState state);
			CheckArgs(args, new ushort[] { 0x1FD }, Ref.Arguments);

			List<byte> bytes = new List<byte>() { 0x48, (byte)(args[0].AddressReg | (args[0].AddressMode << 3)) };
			bytes.AddRange(args[0].ExtraData(1, bytes.Count));
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}
		#endregion

		#region Bit instructions
		public static Tuple<TokenState, AssemblyToken> Btst(AssemblyTokenMacroRef Ref) => _bit(Ref, 0);
		public static Tuple<TokenState, AssemblyToken> Bchg(AssemblyTokenMacroRef Ref) => _bit(Ref, 1);
		public static Tuple<TokenState, AssemblyToken> Bclr(AssemblyTokenMacroRef Ref) => _bit(Ref, 2);
		public static Tuple<TokenState, AssemblyToken> Bset(AssemblyTokenMacroRef Ref) => _bit(Ref, 3);
		private static string[] bxxx = { "btst", "bchg", "bclr", "bset", };

		private static Tuple<TokenState, AssemblyToken> _bit(AssemblyTokenMacroRef Ref, int ins) {
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 2, out TokenState state);
			CheckArgs(args, new ushort[] { 0x801, (ushort)(ins == 0 ? 0xFFD : 0x1FD) }, Ref.Arguments);
			List<byte> bytes = new List<byte>();

			if (args[0].Mode == OperandEnumM68K.Dn) {
				ProcSize(Ref.Size, 4, 4);

				// bxxx dx, <dst>
				bytes.Add((byte)(0x1 | (args[0].AddressReg << 1)));
				bytes.Add((byte)((ins << 6) | (args[1].AddressMode << 3) | args[1].AddressReg));
				bytes.AddRange(args[1].ExtraData(1, bytes.Count));

			} else if (args[0].Mode == OperandEnumM68K.Data) {
				// yeah, btst is a stupid instruction...
				if(args[1].Mode == OperandEnumM68K.Data)
					FormatError("The " + bxxx[ins] + " instruction is not valid when both arguments are immediate!");

				ProcSize(Ref.Size, 1, 1);

				// bxxx #, <dst>
				bytes.Add(8);
				bytes.Add((byte)((ins << 6) | (args[1].AddressMode << 3) | args[1].AddressReg));
				bytes.AddRange(args[0].ExtraData(2, bytes.Count));
				bytes.AddRange(args[1].ExtraData(2, bytes.Count));
			}

			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}
		#endregion

		#region Jmp & Jsr Opcodes
		public static Tuple<TokenState, AssemblyToken> Jmp(AssemblyTokenMacroRef Ref) => _jmpjsr(Ref, true);
		public static Tuple<TokenState, AssemblyToken> Jsr(AssemblyTokenMacroRef Ref) => _jmpjsr(Ref, false);

		public static Tuple<TokenState, AssemblyToken> _jmpjsr(AssemblyTokenMacroRef Ref, bool isjmp) {
			ProcSize(Ref.Size, 4, 4);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 1, out TokenState state);
			CheckArgs(args, new ushort[] { 0x7E4 }, Ref.Arguments);

			// check if we can optimize to bra.s or bsr.s
			if (state < TokenState.Indeterminate && Options.OptBranch && args[0].Mode >= OperandEnumM68K.A16 && args[0].Mode != OperandEnumM68K.PCI8Xn) {
				int data = GetImmValue(InternalMacros.GetDataBytes(4, args[0].Parts[0] - ((long)Address + 2), true));

				// if data is between 7F and -80, change branch size to byte
				if (data != 0 && (Ref.LastBytes == 2 || data != 2) && (data < 0x82 && data >= -0x80)) {
					args[0].Mode = OperandEnumM68K.PCI16;
					return _bcc(Ref, args, 1, isjmp ? 0 : 1, state);
				}
			}

			List<byte> bytes = new List<byte>() { 0x4E, (byte)((isjmp ? 0xC0 : 0x80) | (args[0].AddressMode << 3) | args[0].AddressReg) };
			bytes.AddRange(args[0].ExtraData(4, bytes.Count));
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}
		#endregion

		#region Scc Opcodes
		public static Tuple<TokenState, AssemblyToken> St(AssemblyTokenMacroRef Ref) =>  _scc(Ref, 0);
		public static Tuple<TokenState, AssemblyToken> Sf(AssemblyTokenMacroRef Ref) =>  _scc(Ref, 1);
		public static Tuple<TokenState, AssemblyToken> Shi(AssemblyTokenMacroRef Ref) => _scc(Ref, 2);
		public static Tuple<TokenState, AssemblyToken> Sls(AssemblyTokenMacroRef Ref) => _scc(Ref, 3);
		public static Tuple<TokenState, AssemblyToken> Scc(AssemblyTokenMacroRef Ref) => _scc(Ref, 4);
		public static Tuple<TokenState, AssemblyToken> Scs(AssemblyTokenMacroRef Ref) => _scc(Ref, 5);
		public static Tuple<TokenState, AssemblyToken> Sne(AssemblyTokenMacroRef Ref) => _scc(Ref, 6);
		public static Tuple<TokenState, AssemblyToken> Seq(AssemblyTokenMacroRef Ref) => _scc(Ref, 7);
		public static Tuple<TokenState, AssemblyToken> Svc(AssemblyTokenMacroRef Ref) => _scc(Ref, 8);
		public static Tuple<TokenState, AssemblyToken> Svs(AssemblyTokenMacroRef Ref) => _scc(Ref, 9);
		public static Tuple<TokenState, AssemblyToken> Spl(AssemblyTokenMacroRef Ref) => _scc(Ref, 10);
		public static Tuple<TokenState, AssemblyToken> Smi(AssemblyTokenMacroRef Ref) => _scc(Ref, 11);
		public static Tuple<TokenState, AssemblyToken> Sge(AssemblyTokenMacroRef Ref) => _scc(Ref, 12);
		public static Tuple<TokenState, AssemblyToken> Slt(AssemblyTokenMacroRef Ref) => _scc(Ref, 13);
		public static Tuple<TokenState, AssemblyToken> Sgt(AssemblyTokenMacroRef Ref) => _scc(Ref, 14);
		public static Tuple<TokenState, AssemblyToken> Sle(AssemblyTokenMacroRef Ref) => _scc(Ref, 15);

		private static Tuple<TokenState, AssemblyToken> _scc(AssemblyTokenMacroRef Ref, int cc) {
			ProcSize(Ref.Size, 1, 1);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 1, out TokenState state);
			CheckArgs(args, new ushort[] { 0x1FD }, Ref.Arguments);

			List<byte> bytes = new List<byte> { (byte)(0x50 | cc), (byte)(0xC0 | (args[0].AddressMode << 3) | args[0].AddressReg) };
			bytes.AddRange(args[0].ExtraData(1, bytes.Count));
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}
		#endregion

		#region Dbcc Opcodes
		public static Tuple<TokenState, AssemblyToken> Dbt(AssemblyTokenMacroRef Ref) => _dbcc(Ref, 0);
		public static Tuple<TokenState, AssemblyToken> Dbf(AssemblyTokenMacroRef Ref) => _dbcc(Ref, 1);
		public static Tuple<TokenState, AssemblyToken> Dbhi(AssemblyTokenMacroRef Ref) => _dbcc(Ref, 2);
		public static Tuple<TokenState, AssemblyToken> Dbls(AssemblyTokenMacroRef Ref) => _dbcc(Ref, 3);
		public static Tuple<TokenState, AssemblyToken> Dbcc(AssemblyTokenMacroRef Ref) => _dbcc(Ref, 4);
		public static Tuple<TokenState, AssemblyToken> Dbcs(AssemblyTokenMacroRef Ref) => _dbcc(Ref, 5);
		public static Tuple<TokenState, AssemblyToken> Dbne(AssemblyTokenMacroRef Ref) => _dbcc(Ref, 6);
		public static Tuple<TokenState, AssemblyToken> Dbeq(AssemblyTokenMacroRef Ref) => _dbcc(Ref, 7);
		public static Tuple<TokenState, AssemblyToken> Dbvc(AssemblyTokenMacroRef Ref) => _dbcc(Ref, 8);
		public static Tuple<TokenState, AssemblyToken> Dbvs(AssemblyTokenMacroRef Ref) => _dbcc(Ref, 9);
		public static Tuple<TokenState, AssemblyToken> Dbpl(AssemblyTokenMacroRef Ref) => _dbcc(Ref, 10);
		public static Tuple<TokenState, AssemblyToken> Dbmi(AssemblyTokenMacroRef Ref) => _dbcc(Ref, 11);
		public static Tuple<TokenState, AssemblyToken> Dbge(AssemblyTokenMacroRef Ref) => _dbcc(Ref, 12);
		public static Tuple<TokenState, AssemblyToken> Dblt(AssemblyTokenMacroRef Ref) => _dbcc(Ref, 13);
		public static Tuple<TokenState, AssemblyToken> Dbgt(AssemblyTokenMacroRef Ref) => _dbcc(Ref, 14);
		public static Tuple<TokenState, AssemblyToken> Dble(AssemblyTokenMacroRef Ref) => _dbcc(Ref, 15);

		private static Tuple<TokenState, AssemblyToken> _dbcc(AssemblyTokenMacroRef Ref, int cc) {
			// dbcc is kind of a special case; We need to use a hack to tell the code this is actually pc-relative... This way we don't have to bother doing it for ourselves...
			if(Ref.Arguments.Count != 2)
				FormatError("Incorrect number of arguments: Expected 2 but got " + Ref.Arguments.Count + "!");

			ProcSize(Ref.Size, 2, 2);
			OperandModeM68K[] args = ProcArgs(new string[] { Ref.Arguments[0], Ref.Arguments[1] +"(PC)" }, 2, out TokenState state);
			CheckArgs(args, new ushort[] { 1, 0x200 }, Ref.Arguments);

			List<byte> bytes = new List<byte> { (byte)(0x50 | cc), (byte)(0xC8 | args[0].AddressReg) };
			bytes.AddRange(args[1].ExtraData(2, bytes.Count));
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}
		#endregion

		#region Bcc Opcodes
		public static Tuple<TokenState, AssemblyToken> Bra(AssemblyTokenMacroRef Ref) => _bcc(Ref, 0);
		public static Tuple<TokenState, AssemblyToken> Bsr(AssemblyTokenMacroRef Ref) => _bcc(Ref, 1);
		public static Tuple<TokenState, AssemblyToken> Bhi(AssemblyTokenMacroRef Ref) => _bcc(Ref, 2);
		public static Tuple<TokenState, AssemblyToken> Bls(AssemblyTokenMacroRef Ref) => _bcc(Ref, 3);
		public static Tuple<TokenState, AssemblyToken> Bcc(AssemblyTokenMacroRef Ref) => _bcc(Ref, 4);
		public static Tuple<TokenState, AssemblyToken> Bcs(AssemblyTokenMacroRef Ref) => _bcc(Ref, 5);
		public static Tuple<TokenState, AssemblyToken> Bne(AssemblyTokenMacroRef Ref) => _bcc(Ref, 6);
		public static Tuple<TokenState, AssemblyToken> Beq(AssemblyTokenMacroRef Ref) => _bcc(Ref, 7);
		public static Tuple<TokenState, AssemblyToken> Bvc(AssemblyTokenMacroRef Ref) => _bcc(Ref, 8);
		public static Tuple<TokenState, AssemblyToken> Bvs(AssemblyTokenMacroRef Ref) => _bcc(Ref, 9);
		public static Tuple<TokenState, AssemblyToken> Bpl(AssemblyTokenMacroRef Ref) => _bcc(Ref, 10);
		public static Tuple<TokenState, AssemblyToken> Bmi(AssemblyTokenMacroRef Ref) => _bcc(Ref, 11);
		public static Tuple<TokenState, AssemblyToken> Bge(AssemblyTokenMacroRef Ref) => _bcc(Ref, 12);
		public static Tuple<TokenState, AssemblyToken> Blt(AssemblyTokenMacroRef Ref) => _bcc(Ref, 13);
		public static Tuple<TokenState, AssemblyToken> Bgt(AssemblyTokenMacroRef Ref) => _bcc(Ref, 14);
		public static Tuple<TokenState, AssemblyToken> Ble(AssemblyTokenMacroRef Ref) => _bcc(Ref, 15);

		private static Tuple<TokenState, AssemblyToken> _bcc(AssemblyTokenMacroRef Ref, int cc) {
			// dbcc is kind of a special case; We need to use a hack to tell the code this is actually pc-relative... This way we don't have to bother doing it for ourselves...
			if (Ref.Arguments.Count != 1)
				FormatError("Incorrect number of arguments: Expected 1 but got " + Ref.Arguments.Count + "!");

			OperandModeM68K[] args = ProcArgs(new string[] { Ref.Arguments[0] + "(PC)" }, 1, out TokenState state);
			return _bcc(Ref, args, ProcSize(Ref.Size, 3, 2, true), cc, state);
		}

		private static Tuple<TokenState, AssemblyToken> _bcc(AssemblyTokenMacroRef Ref, OperandModeM68K[] args, int size, int cc, TokenState state) {
			CheckArgs(args, new ushort[] { 0x200 }, Ref.Arguments);
			List<byte> bytes = new List<byte> { (byte)(0x60 | cc) };

			// check if we can optimize this to bcc.s
			if(state < TokenState.Indeterminate && size == 2 && (Options.OptBranch || Ref.Size.Length == 0)) {
				int data = GetImmValue(InternalMacros.GetDataBytes(2, args[0].Parts[0] - ((long)Address + 2), true));

				// if data is between 7F and -80, change branch size to byte
				if (data != 0 && (Ref.LastBytes <= 2 || data != 2) && (data < 0x82 || data >= 0xFF80))
					size = 1;
			}
		
			if(size == 1) {
				// bcc.b
				byte data = InternalMacros.GetDataBytes(1, args[0].Parts[0] - ((long)Address + 2), true, 1)[0];
				bytes.Add(data);

				if(data == 0) {
					if(Pass > 1)
						FormatError("Invalid branch distance of 0 bytes!");

					state = TokenState.Indeterminate;
				}

			} else {
				// bcc.w
				bytes.Add(0);
				bytes.AddRange(args[0].ExtraData(2, bytes.Count));
			}

			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}
		#endregion

		#region Misc
		public static Tuple<TokenState, AssemblyToken> Illegal(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0x4A, 0xFC }));
		public static Tuple<TokenState, AssemblyToken> Reset(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0x4E, 0x70 }));
		public static Tuple<TokenState, AssemblyToken> Trapv(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0x4E, 0x76 }));
		public static Tuple<TokenState, AssemblyToken> Nop(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0x4E, 0x71 }));
		public static Tuple<TokenState, AssemblyToken> Rte(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0x4E, 0x73 }));
		public static Tuple<TokenState, AssemblyToken> Rts(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0x4E, 0x75 }));
		public static Tuple<TokenState, AssemblyToken> Rtr(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0x4E, 0x77 }));

		// isn't even gay
		public static Tuple<TokenState, AssemblyToken> Trap(AssemblyTokenMacroRef Ref) {
			int size = ProcSize(Ref.Size, 1, 1);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 1, out TokenState state);
			CheckArgs(args, new ushort[] { 0x800 }, Ref.Arguments);

			// check if trap is valid ;)
			size = GetImmValue(InternalMacros.GetDataBytes(size, args[0].Parts[0], true, size));
			if(size < 0 || size > 0xF)
				FormatError("The trap instruction expects immediate value to be between 0 and 15!");

			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0x4E, (byte)(0x40 | size) }));
		}

		public static Tuple<TokenState, AssemblyToken> Chk(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size, 2, 2);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 2, out TokenState state);
			CheckArgs(args, new ushort[] { 0xFFD, 1 }, Ref.Arguments);

			List<byte> bytes = new List<byte> { (byte)(0x41 | (args[1].AddressMode << 3)), (byte)(0xC0 | (args[0].AddressMode << 3) | args[0].AddressReg) };
			bytes.AddRange(args[0].ExtraData(2, bytes.Count));
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}

		public static Tuple<TokenState, AssemblyToken> Exg(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size, 4, 4);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 2, out TokenState state);
			CheckArgs(args, new ushort[] { 3, 3 }, Ref.Arguments);

			byte opmode = 0;

			if (args[0].Mode == args[1].Mode) {
				if(args[0].Mode == OperandEnumM68K.Dn) {
					// exg dx,dy
					opmode = 0x40;	// 8 << 3;

				} else {
					// exg ax,ay
					opmode = 0x48;  // 9 << 3;
				}
			} else {
				// check if ay comes first, and if so, reverse the arguments
				if (args[0].Mode == OperandEnumM68K.An)
					args = new OperandModeM68K[] { args[1], args[0] };

				// exg dx,ay
				opmode = 0x88;  // 0x11 << 3;
			}

			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { (byte)(0xC1 | (args[0].AddressReg << 1)), (byte)(opmode | args[1].AddressReg) }));
		}

		public static Tuple<TokenState, AssemblyToken> Ext(AssemblyTokenMacroRef Ref) {
			int size = ProcSize(Ref.Size, 6, 2);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 1, out TokenState state);
			CheckArgs(args, new ushort[] { 1 }, Ref.Arguments);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0x48, (byte)((InstructionSizesExt[size] << 6) | args[0].AddressReg) }));
		}

		private static byte[] InstructionSizesExt = { 1, 1, 2, 2, 3 };

		public static Tuple<TokenState, AssemblyToken> Swap(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size, 2, 2);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 1, out TokenState state);
			CheckArgs(args, new ushort[] { 1 }, Ref.Arguments);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0x48, (byte)(0x40 | args[0].AddressReg) }));
		}

		public static Tuple<TokenState, AssemblyToken> Stop(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size, 2, 2);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 1, out TokenState state);
			CheckArgs(args, new ushort[] { 0x800 }, Ref.Arguments);

			List<byte> bytes = new List<byte> { 0x4E, 0x72 };
			bytes.AddRange(args[0].ExtraData(2, bytes.Count));
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}

		public static Tuple<TokenState, AssemblyToken> Link(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size, 2, 2);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 2, out TokenState state);
			CheckArgs(args, new ushort[] { 2, 0x800 }, Ref.Arguments);

			List<byte> bytes = new List<byte> { 0x4E, (byte)(0x50 | args[0].AddressReg) };
			bytes.AddRange(args[1].ExtraData(2, bytes.Count));
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}

		public static Tuple<TokenState, AssemblyToken> Unlink(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size, 2, 2);
			OperandModeM68K[] args = ProcArgs(Ref.Arguments, 1, out TokenState state);
			CheckArgs(args, new ushort[] { 2 }, Ref.Arguments);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0x4E, (byte)(0x58 | args[0].AddressReg) }));
		}
		#endregion
	}

	#region Operand Modes
	public struct OperandModeM68K {
		public dynamic[] Parts;
		public OperandEnumM68K Mode;
		private int Num;

		public OperandModeM68K(OperandEnumM68K Mode, dynamic[] Parts, int argn, TokenState state) {
			this.Mode = Mode;
			this.Parts = Parts;
			Num = argn;

			// examine if we can do some assembler optimizations already
			if (state < TokenState.Indeterminate) {
				if (Mode == OperandEnumM68K.A32) {
					int data = M68k.GetImmValue(InternalMacros.GetDataBytes(4, Parts[0], true, 4));

					// check if the value is in range of .w
					if (Options.OptShortAddr && (data <= 0x7FFF && data >= -0x8000)) {
						this.Mode = OperandEnumM68K.A16;

					} else if (argn == 0 && Options.OptPCRelative) {
						data = M68k.GetImmValue(InternalMacros.GetDataBytes(4, Parts[0] - ((long)Address + 2), true, 4));

						// check if this can be pc relative
						if (data <= 0x7FFF && data >= -0x8000)
							this.Mode = OperandEnumM68K.PCI16;
					}

				} else if (Mode == OperandEnumM68K.AnI16 && Options.OptZeroOffset) {
					int data = M68k.GetImmValue(InternalMacros.GetDataBytes(2, Parts[0], true, 2));

					if (data == 0) {
						this.Mode = OperandEnumM68K.AnI;
						this.Parts = new dynamic[] { Parts[1] };
					}
				}
			}
		}

		public int AddressMode => (int)Mode & 7;
		public int AddressReg { get {
				if (Mode >= OperandEnumM68K.Sr)
					return (((int)Mode >> 3) & 7) + 5;

				if (AddressMode == 7)
					return ((int)Mode >> 3) & 7;

				if (Mode < OperandEnumM68K.AnI16)
					return (int)(Parts[0] & 0x7);

				return (int)(Parts[1] & 0x7);
		} }

		public byte[] ExtraData(int size, int offset) {
			// special check for byte accesses for word only registers
			if(size == 1 && Mode == OperandEnumM68K.An)
				FormatError("Byte access to address registers is invalid!");

			if (Mode < OperandEnumM68K.AnI16)
				return new byte[0];

			if (Mode == OperandEnumM68K.AnI16)
				return InternalMacros.GetDataBytes(2, Parts[0], true, 2);

			if (Mode == OperandEnumM68K.A16)
				return InternalMacros.GetDataBytes(2, Parts[0], true, 2);

			if(Mode == OperandEnumM68K.PCI16)
				return InternalMacros.GetDataBytes(2, Parts[0] - ((long)Address + offset), true, 2);

			if (Mode == OperandEnumM68K.A32)
				return InternalMacros.GetDataBytes(4, Parts[0], true, 4);

			if(Mode == OperandEnumM68K.Data)
				return InternalMacros.GetDataBytes(size, Parts[0], true, 2);

			if (Mode == OperandEnumM68K.AnI8Xn)
				return new byte[] { (byte)((Parts[2] & 0xF) << 4 | ((byte)Parts[3] == 'l' ? 0x8 : 0) | ((byte)Parts[2] >= 0x10 ? 0x80 : 0)), InternalMacros.GetDataBytes(1, Parts[0], true)[0] };

			if (Mode == OperandEnumM68K.PCI8Xn)
				return new byte[] { (byte)((Parts[1] & 0xF) << 4 | ((byte)Parts[2] == 'l' ? 0x8 : 0) | ((byte)Parts[1] >= 0x10 ? 0x80 : 0)), InternalMacros.GetDataBytes(1, Parts[0] - ((long)Address + offset), true)[0] };

			throw new NotImplementedException();
		}
	}

	public enum OperandEnumM68K {
		Dn = 0,			// dN
		An = 1,			// An
		AnI = 2,		// (An)
		AnIPi = 3,		// (An)+
		AnIPd = 4,		// -(An)
		AnI16 = 5,		// XXXX(An)
		AnI8Xn = 6,		// XX(An,Xn.y)
		A16 = 7,		// (XXXX).w
		A32 = 0xF,		// (XXXXXXXX).l
		Data = 0x27,	// #xxxx
		PCI16 = 0x17,	// XXXX(PC)
		PCI8Xn = 0x1F,	// XX(PC,Xn.y)

		// special
		Sr = 0x87,
		Ccr = 0x8F,
		Usp = 0x97,
		Ssp = 0x9F,
	}
	#endregion
}