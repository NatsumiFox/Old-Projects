using System;
using System.Collections.Generic;
using static MDASM.Program;

namespace MDASM {
	public class Z80 {
		#region Init instructions
		public static List<AssemblyTokenMacroInternal> Instructions = new List<AssemblyTokenMacroInternal>() {
			// zero operand opcodes that are 1 byte long
			new AssemblyTokenMacroInternal("ei", Ei, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("di", Di, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("nop", Nop, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("exx", Exx, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("rla", Rla, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("rra", Rra, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("daa", Daa, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("cpl", Cpl, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("scf", Scf, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("ccf", Ccf, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("halt", Halt, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("rlca", Rlca, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("rrca", Rrca, EquateFlags.Locked),

			// zero operand opcodes with prefix ED
			new AssemblyTokenMacroInternal("neg", Neg, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("retn", Retn, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("reti", Reti, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("rrd", Rrd, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("rld", Rld, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("ldi", Ldi, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("cpi", Cpi, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("ini", Ini, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("outi", Outi, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("ldd", Ldd, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("cpd", Cpd, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("ind", Ind, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("outd", Outd, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("ldir", Ldir, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("cpir", Cpir, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("inir", Inir, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("otir", Otir, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("ldid", Lddr, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("cpdr", Cpdr, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("indr", Indr, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("otdr", Otdr, EquateFlags.Locked),

			// single operand opcodes
			new AssemblyTokenMacroInternal("im", Im, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("ex", Ex, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("or", Or, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("cp", Cp, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("add", Add, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("sub", Sub, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("and", And, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("xor", Xor, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("rst", Rst, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("inc", Inc, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("dec", Dec, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("pop", Pop, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("push", Push, EquateFlags.Locked),

			// two operand opcodes
			new AssemblyTokenMacroInternal("ld", Ld, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("in", In, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("out", Out, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("sbc", Sbc, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("adc", Adc, EquateFlags.Locked),
			
			// opcodes with prefix CB
			new AssemblyTokenMacroInternal("rl", Rl, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("rr", Rr, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("rlc", Rlc, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("rrc", Rrc, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("sla", Sla, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("sra", Sra, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("sll", Sll, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("srl", Srl, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("bit", Bit, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("res", Res, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("set", Set, EquateFlags.Locked),

			// conditional opcodes
			new AssemblyTokenMacroInternal("ret", Ret, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("retz", Retz, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("retc", Retc, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("retp", Retp, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("retm", Retm, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("retv", Retv, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("retnz", Retnz, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("retnc", Retnc, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("retnv", Retnv, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("retpo", Retpo, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("retpe", Retpe, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("jp", Jp, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("jpz", Jpz, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("jpc", Jpc, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("jpp", Jpp, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("jpm", Jpm, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("jpv", Jpv, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("jpnz", Jpnz, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("jpnc", Jpnc, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("jpnv", Jpnv, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("jppo", Jppo, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("jppe", Jppe, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("call", Call, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("callz", Callz, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("callc", Callc, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("callp", Callp, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("callm", Callm, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("callv", Callv, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("callnz", Callnz, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("callnc", Callnc, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("callnv", Callnv, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("callpo", Callpo, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("djnz", Djnz, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("jr", Jr, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("jrz", Jrz, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("jrc", Jrc, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("jrnz", Jrnz, EquateFlags.Locked),
			new AssemblyTokenMacroInternal("jrnc", Jrnc, EquateFlags.Locked),
		};

		public static void CreateInstructions() {
			foreach (AssemblyTokenMacroInternal m in Instructions) {
				CreateEquateInternal(m);
			}
		}
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
			for (int i = 0;i < Instructions.Count;i++)
				if (Ins.Equals(Instructions[i].Name, StringComparison.InvariantCultureIgnoreCase)) {
					Ret = Instructions[i].Code(Ref);
					break;
				}

			// if we didn't get a return value, instruction does not exist
			if (Ret == null)
				FormatError("Unknown Z80 instruction " + Ins + "!");

			// restore proper size and return
			Ref.Size = Size;
			return Ret;
		}
		#endregion

		#region Common Functionality
		private static void ProcSize(string size) {
			if(size != "")
				FormatError("Invalid macro size parameter ." + size + "! Z80 instructions do not have a size parameter!");
		}

		private static void Undocumented(string text) {
			FormatError(text + " only available if undocumented instructions are enabled!");
		}

		private static OperandModeZ80[] ProcArgs(List<string> arguments, int argc, out TokenState state) => ProcArgs(arguments.ToArray(), argc, out state);

		private static OperandModeZ80[] ProcArgs(string[] arguments, int argc, out TokenState state) {
			state = TokenState.Static;
			if (argc != arguments.Length)
				FormatError("Incorrect number of arguments: Expected " + argc + " but got " + arguments.Length + "!");

			OperandModeZ80[] ops = new OperandModeZ80[arguments.Length];

			for (int i = 0;i < arguments.Length;i++) {
				switch (arguments[i].Length) {
					case 1:
						switch (arguments[i].ToLowerInvariant()) {
							case "a": ops[i] = new OperandModeZ80(OperandEnumZ80.A, new object[0], state); continue;
							case "b": ops[i] = new OperandModeZ80(OperandEnumZ80.B, new object[0], state); continue;
							case "c": ops[i] = new OperandModeZ80(OperandEnumZ80.C, new object[0], state); continue;
							case "d": ops[i] = new OperandModeZ80(OperandEnumZ80.D, new object[0], state); continue;
							case "e": ops[i] = new OperandModeZ80(OperandEnumZ80.E, new object[0], state); continue;
							case "h": ops[i] = new OperandModeZ80(OperandEnumZ80.H, new object[0], state); continue;
							case "l": ops[i] = new OperandModeZ80(OperandEnumZ80.L, new object[0], state); continue;
							case "i": ops[i] = new OperandModeZ80(OperandEnumZ80.I, new object[0], state); continue;
							case "r": ops[i] = new OperandModeZ80(OperandEnumZ80.R, new object[0], state); continue;
						}
						break;

					case 2:
						switch (arguments[i].ToLowerInvariant()) {
							case "af": ops[i] = new OperandModeZ80(OperandEnumZ80.AF, new object[0], state); continue;
							case "bc": ops[i] = new OperandModeZ80(OperandEnumZ80.BC, new object[0], state); continue;
							case "de": ops[i] = new OperandModeZ80(OperandEnumZ80.DE, new object[0], state); continue;
							case "hl": ops[i] = new OperandModeZ80(OperandEnumZ80.HL, new object[0], state); continue;
							case "sp": ops[i] = new OperandModeZ80(OperandEnumZ80.SP, new object[0], state); continue;
							case "ix": ops[i] = new OperandModeZ80(OperandEnumZ80.IX, new object[0], state); continue;
							case "iy": ops[i] = new OperandModeZ80(OperandEnumZ80.IY, new object[0], state); continue;
						}
						break;

					case 3:
						switch (arguments[i].ToLowerInvariant()) {
							case "(c)": ops[i] = new OperandModeZ80(OperandEnumZ80.Ci, new object[0], state); continue;
							case "ixh": ops[i] = new OperandModeZ80(OperandEnumZ80.IXH, new object[0], state); continue;
							case "ixl": ops[i] = new OperandModeZ80(OperandEnumZ80.IXL, new object[0], state); continue;
							case "iyh": ops[i] = new OperandModeZ80(OperandEnumZ80.IYH, new object[0], state); continue;
							case "iyl": ops[i] = new OperandModeZ80(OperandEnumZ80.IYL, new object[0], state); continue;
							case "af'": case "af2": ops[i] = new OperandModeZ80(OperandEnumZ80.AF2, new object[0], state); continue;
						}
						break;

					case 4:
						switch (arguments[i].ToLowerInvariant()) {
							case "(bc)": ops[i] = new OperandModeZ80(OperandEnumZ80.BCi, new object[0], state); continue;
							case "(de)": ops[i] = new OperandModeZ80(OperandEnumZ80.DEi, new object[0], state); continue;
							case "(hl)": ops[i] = new OperandModeZ80(OperandEnumZ80.HLi, new object[0], state); continue;
							case "(sp)": ops[i] = new OperandModeZ80(OperandEnumZ80.SPi, new object[0], state); continue;
							case "(af)": ops[i] = new OperandModeZ80(OperandEnumZ80.AFi, new object[0], state); continue;
							case "(ix)": ops[i] = new OperandModeZ80(OperandEnumZ80.IXi, new object[0], state); continue;
							case "(iy)": ops[i] = new OperandModeZ80(OperandEnumZ80.IYi, new object[0], state); continue;
						}
						break;
				}

				bool indirect = false;
				// check if this is a direct address or not
				if(arguments[i][0] == '(' && arguments[i][arguments[i].Length - 1] == ')') {
					// is indirect, check if it is ix+ or iy+

					if(arguments[i].Length > 5 && arguments[i][1] == 'i') {
						// it might be!
						bool isx = (arguments[i][2] & 0xDF) == 'X';

						if((isx || (arguments[i][2] & 0xDF) == 'Y') && (arguments[i][3] == '+' || arguments[i][3] == '-')) {
							// definitely is!

							AssemblyToken solved2 = Context.CalculateEquationTokens(arguments[i], 3, 1);
							solved2 = Context.SolveTokens(solved2, out TokenState stat);
							AssemblyTokenValue sv2 = solved2 as AssemblyTokenValue;

							if (stat > state) state = stat;
							if (sv2 is null) goto cantconvert;

							ops[i] = new OperandModeZ80(isx ? OperandEnumZ80.IXp : OperandEnumZ80.IYp, new object[] { sv2.Value }, state);
							continue;
						}
					}

					indirect = true;
				}
				
				AssemblyToken solved = Context.CalculateEquationTokens(arguments[i], indirect ? 1 : 0, indirect ? 1 : 0);
				solved = Context.SolveTokens(solved, out TokenState sta);
				AssemblyTokenValue sv = solved as AssemblyTokenValue;

				if (sta > state) state = sta;
				if (sv is null) goto cantconvert;

				ops[i] = new OperandModeZ80(indirect ? OperandEnumZ80.Addr : OperandEnumZ80.Imm, new object[] { sv.Value }, state);
				continue;

				cantconvert: FormatError("Argument " + (i + 1) + " could not be converted to a value: " + arguments[i] + "!");
			}

			return ops;
		}

		private static Tuple<TokenState, AssemblyToken> InvalidRegs(List<string> arguments, string ins) {
			FormatError("Invalid register combination for instruction " + ins + ": " + string.Join(", ", arguments));
			return null;
		}
		#endregion

		#region Single Operand Opcodes
		public static Tuple<TokenState, AssemblyToken> Im(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size);
			OperandModeZ80[] args = ProcArgs(Ref.Arguments, 1, out TokenState state);

			if (args[0].Mode == OperandEnumZ80.Addr || args[0].Mode == OperandEnumZ80.Imm) {
				try {
					switch ((int)args[0].Parts[0]) {
						case -1:return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xED, 0x4E }));
						case 0: return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xED, 0x46 }));
						case 1: return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xED, 0x56 }));
						case 2: return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xED, 0x5E }));
					}

					FormatError("Invalid value for im instruction: " + args[0].Parts[0]);

				} catch (Exception) {
					FormatError("Value could not be converted for RST target: " + args[0].Parts[0]);
				}
			}

			return InvalidRegs(Ref.Arguments, "im");
		}

		public static Tuple<TokenState, AssemblyToken> Rst(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size);
			OperandModeZ80[] args = ProcArgs(Ref.Arguments, 1, out TokenState state);

			if(args[0].Mode == OperandEnumZ80.Addr || args[0].Mode == OperandEnumZ80.Imm) {
				try {
					int v = args[0].Parts[0] & 0xFFFF;
					if (v < 0 || v > 0x38)
						FormatError("Value out of range for RST target: " + args[0].Parts[0]);

					if((v & 7) != 0)
						FormatError("Value for RST target must be divisible by 8, but it was: " + args[0].Parts[0]);

					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { (byte)(0xC7 | v) }));

				} catch(Exception) {
					FormatError("Value could not be converted for RST target: " + args[0].Parts[0]);
				}
			}

			return InvalidRegs(Ref.Arguments, "rst");
		}

		public static Tuple<TokenState, AssemblyToken> Pop(AssemblyTokenMacroRef Ref) => _pushpop(Ref, 1);
		public static Tuple<TokenState, AssemblyToken> Push(AssemblyTokenMacroRef Ref) => _pushpop(Ref, 5);

		private static Tuple<TokenState, AssemblyToken> _pushpop(AssemblyTokenMacroRef Ref, int ins) {
			ProcSize(Ref.Size);
			OperandModeZ80[] args = ProcArgs(Ref.Arguments, 1, out TokenState state);

			if(args[0].Mode == OperandEnumZ80.AF)
				// push/pop af
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { (byte)(0xF0 | ins) }));

			else if (args[0].Mode >= OperandEnumZ80.BC && args[0].Mode <= OperandEnumZ80.HL)
				// push/pop bc/de/hl
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { (byte)(0xC0 | ins | (args[0].Mode - OperandEnumZ80.BC)) }));

			else if (args[0].Mode == OperandEnumZ80.IX || args[0].Mode == OperandEnumZ80.IY)
				// push/pop ix/iy
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[0].Prefix, (byte)(0xE0 | ins) }));

			return InvalidRegs(Ref.Arguments, ins == 1 ? "pop" : "push");
		}

		public static Tuple<TokenState, AssemblyToken> Inc(AssemblyTokenMacroRef Ref) => _incdec(Ref, 4, 3);
		public static Tuple<TokenState, AssemblyToken> Dec(AssemblyTokenMacroRef Ref) => _incdec(Ref, 5, 0xB);

		private static Tuple<TokenState, AssemblyToken> _incdec(AssemblyTokenMacroRef Ref, int b1, int b2) {
			ProcSize(Ref.Size);
			OperandModeZ80[] args = ProcArgs(Ref.Arguments, 1, out TokenState state);

			if (args[0].Mode <= OperandEnumZ80.A)
				// inc/dec b/c/d/e/(hl)/a
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { (byte)(b1 | ((int)args[0].Mode << 3)) }));

			else if (args[0].Mode >= OperandEnumZ80.BC && args[0].Mode <= OperandEnumZ80.SP)
				// inc/dec bc/de/hl/sp
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { (byte)(b2 | (args[0].Mode - OperandEnumZ80.BC)) }));

			else if (args[0].Mode == OperandEnumZ80.IX || args[0].Mode == OperandEnumZ80.IY)
				// inc/dec ix/iy
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[0].Prefix, (byte)(b2 | 0x20) }));

			else if (args[0].Mode == OperandEnumZ80.IXp || args[0].Mode == OperandEnumZ80.IYp)
				// inc/dec ix/iy
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[0].Prefix, (byte)(b1 | 0x30), args[0].GetData(1)[0] }));

			else if (args[0].Mode >= OperandEnumZ80.IXH && args[0].Mode <= OperandEnumZ80.IYL)
				// inc/dec ixh/ixl/iyh/iyl
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[0].Prefix, (byte)(b1 | 0x20 | ((int)args[0].Mode & 0x8)) }));

			return InvalidRegs(Ref.Arguments, b1 == 4 ? "inc" : "dec");
		}
		#endregion

		#region Two Operand Opcodes
		private static Tuple<TokenState, AssemblyToken> Ex(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size);
			OperandModeZ80[] args = ProcArgs(Ref.Arguments, 2, out TokenState state);

			if ((args[0].Mode == OperandEnumZ80.AF || args[0].Mode == OperandEnumZ80.AF2) && (args[1].Mode == OperandEnumZ80.AF || args[1].Mode == OperandEnumZ80.AF2))
				// ex af,af'
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 8 }));
				
			else if (args[0].Mode != args[1].Mode && (args[1].Mode == OperandEnumZ80.DE || args[1].Mode == OperandEnumZ80.HL) && (args[0].Mode == OperandEnumZ80.DE || args[0].Mode == OperandEnumZ80.HL))
				// ex de,hl
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xEB }));

			else if (args[0].Mode != args[1].Mode && (args[1].Mode == OperandEnumZ80.SPi || args[1].Mode == OperandEnumZ80.HL) && (args[0].Mode == OperandEnumZ80.SPi || args[0].Mode == OperandEnumZ80.HL))
				// ex (sp),hl
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xE3 }));

			else if((args[0].Mode == OperandEnumZ80.SPi || args[1].Mode == OperandEnumZ80.SPi) && (args[0].Mode == OperandEnumZ80.IX || args[0].Mode == OperandEnumZ80.IY || args[1].Mode == OperandEnumZ80.IX || args[1].Mode == OperandEnumZ80.IY))
				// ex (sp),ix/iy
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[0].Mode == OperandEnumZ80.SPi ? args[1].Prefix : args[0].Prefix, 0xE3 }));

			return InvalidRegs(Ref.Arguments, "ex");
		}

		public static Tuple<TokenState, AssemblyToken> Sbc(AssemblyTokenMacroRef Ref) => _sbcadc(Ref, 0x98, 0x42, "sbc");
		public static Tuple<TokenState, AssemblyToken> Adc(AssemblyTokenMacroRef Ref) => _sbcadc(Ref, 0x88, 0x4A, "adc");

		private static Tuple<TokenState, AssemblyToken> _sbcadc(AssemblyTokenMacroRef Ref, byte basis, byte extd, string ins) {
			ProcSize(Ref.Size);
			OperandModeZ80[] args = ProcArgs(Ref.Arguments, Ref.Arguments.Count == 1 ? 1 : 2, out TokenState state);
			bool? mode = null;

			if(args.Length == 2) {
				if (args[0].Mode == OperandEnumZ80.A)
					mode = true;

				else if (args[0].Mode == OperandEnumZ80.HL)
					mode = false;

				else goto fail;
				args = new OperandModeZ80[] { args[1] };
			}

			if(mode != true && args[0].Mode >= OperandEnumZ80.BC && args[0].Mode <= OperandEnumZ80.SP)
				// sbc/adc bc/de/hl/sp
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xED, (byte)(extd | (args[0].Mode - OperandEnumZ80.BC)) }));

			if (mode != false) {
				if (args[0].Mode <= OperandEnumZ80.A)
					// sbc/adc b/c/d/e/(hl)/a
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { (byte)(basis | (int)args[0].Mode) }));

				else if (args[0].Mode == OperandEnumZ80.Addr || args[0].Mode == OperandEnumZ80.Imm)
					// sbc/adc *
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { (byte)(basis + 0x46), args[0].GetData(1)[0] }));

				else if (args[0].Mode >= OperandEnumZ80.IXH && args[0].Mode <= OperandEnumZ80.IYL)
					// sbc/adc ixh/ixl/iyh/iyl
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[0].Prefix, (byte)(basis | 4 | (((int)args[0].Mode & 8) >> 8)) }));

				else if (args[0].Mode == OperandEnumZ80.IXp || args[0].Mode == OperandEnumZ80.IYp)
					// sbc/adc (ix/iy+*)
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[0].Prefix, (byte)(basis | 6), args[0].GetData(1)[0] }));
			}

			fail: return InvalidRegs(Ref.Arguments, ins);
		}

		public static Tuple<TokenState, AssemblyToken> Sub(AssemblyTokenMacroRef Ref) => _soi9(Ref, 0x90, 0xD6, "sub");
		public static Tuple<TokenState, AssemblyToken> And(AssemblyTokenMacroRef Ref) => _soi9(Ref, 0xA0, 0xE6, "and");
		public static Tuple<TokenState, AssemblyToken> Xor(AssemblyTokenMacroRef Ref) => _soi9(Ref, 0xA8, 0xEE, "xor");
		public static Tuple<TokenState, AssemblyToken> Or(AssemblyTokenMacroRef Ref) => _soi9(Ref, 0xB0, 0xF0, "or");
		public static Tuple<TokenState, AssemblyToken> Cp(AssemblyTokenMacroRef Ref) => _soi9(Ref, 0xB8, 0xFE, "cp");

		private static Tuple<TokenState, AssemblyToken> _soi9(AssemblyTokenMacroRef Ref, byte basis, byte data, string ins) {
			ProcSize(Ref.Size);
			OperandModeZ80[] args = ProcArgs(Ref.Arguments, 1, out TokenState state);

			if (args[0].Mode <= OperandEnumZ80.A)
				// sub/and/xor/or/cp b/c/d/e/(hl)/a
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { (byte)(basis | (int)args[0].Mode) }));

			else if (args[0].Mode == OperandEnumZ80.Addr || args[0].Mode == OperandEnumZ80.Imm)
				// sub/and/xor/or/cp *
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { data, args[0].GetData(1)[0] }));

			else if (args[0].Mode >= OperandEnumZ80.IXH && args[0].Mode <= OperandEnumZ80.IYL)
				// sub/and/xor/or/cp ixh/ixl/iyh/iyl
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[0].Prefix, (byte)(data | 4 | (((int)args[0].Mode & 8) >> 8)) }));

			else if (args[0].Mode == OperandEnumZ80.IXp || args[0].Mode == OperandEnumZ80.IYp)
				// sub/and/xor/or/cp (ix/iy+*)
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[0].Prefix, (byte)(data | 6), args[0].GetData(1)[0] }));

			return InvalidRegs(Ref.Arguments, ins);
		}

		private static Tuple<TokenState, AssemblyToken> Add(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size);
			OperandModeZ80[] args = ProcArgs(Ref.Arguments, Ref.Arguments.Count == 1 ? 1 : 2, out TokenState state);
		
			// if we get only 1 argument, assume the first one should be a. If not however, this should always results in an error!
			if (args.Length == 1) args = new OperandModeZ80[] { new OperandModeZ80(OperandEnumZ80.A, null, state), args[0] };

			if (args[0].Mode == OperandEnumZ80.A) {
				if (args[1].Mode <= OperandEnumZ80.A)
					// add a,b/c/d/e/(hl)/a
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { (byte)(0x80 | (int)args[1].Mode) }));

				else if (args[1].Mode == OperandEnumZ80.Addr || args[1].Mode == OperandEnumZ80.Imm)
					// add a,*
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xC6, args[1].GetData(1)[0] }));

				else if (args[1].Mode >= OperandEnumZ80.IXH && args[1].Mode <= OperandEnumZ80.IYL)
					// add a,ixh/ixl/iyh/iyl
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[1].Prefix, (byte)(0x84 | (((int)args[1].Mode & 8) >> 8)) }));

				else if (args[1].Mode == OperandEnumZ80.IXp || args[1].Mode == OperandEnumZ80.IYp)
					// add a,(ix/iy+*)
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[1].Prefix, 0x86, args[1].GetData(1)[0] }));

			} else if (args[0].Mode == args[1].Mode) {
				if (args[0].Mode == OperandEnumZ80.HL)
					// add hl,hl
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0x29 }));

				else if (args[0].Mode == OperandEnumZ80.IX || args[0].Mode == OperandEnumZ80.IY)
					// add ix/iy,ix/iy
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[0].Prefix, 0x39 }));

			} else if (args[1].Mode == OperandEnumZ80.BC || args[1].Mode == OperandEnumZ80.DE || args[1].Mode == OperandEnumZ80.SP) {
				if (args[0].Mode == OperandEnumZ80.HL)
					// add hl,bc/de/sp
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { (byte)(9 | (args[1].Mode - OperandEnumZ80.BC)) }));

				else if (args[0].Mode == OperandEnumZ80.IX || args[0].Mode == OperandEnumZ80.IY)
					// add ix/iy,bc/de/sp
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[0].Prefix, (byte)(9 | (args[1].Mode - OperandEnumZ80.BC)) }));
			}

			return InvalidRegs(Ref.Arguments, "add");
		}

		#endregion

		#region Ld Opcode
		public static Tuple<TokenState, AssemblyToken> Ld(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size);
			OperandModeZ80[] args = ProcArgs(Ref.Arguments, 2, out TokenState state);

			if (args[0].Mode == OperandEnumZ80.Addr) {
				List<byte> bytes = new List<byte>();

				if (args[1].Mode == OperandEnumZ80.A)
					// ld (**), a
					bytes.Add(0x32);

				else if (args[1].Mode == OperandEnumZ80.HL)
					// ld (**), hl
					bytes.Add(0x22);

				else if (args[1].Mode >= OperandEnumZ80.BC && args[1].Mode <= OperandEnumZ80.SP)
					// ld (**), bc/de/hl/sp
					bytes.AddRange(new byte[] { 0xED, (byte)(0x43 | (args[1].Mode - OperandEnumZ80.BC)) });

				else if (args[1].Mode == OperandEnumZ80.IX || args[1].Mode == OperandEnumZ80.IY)
					// ld (**), ix/iy
					bytes.AddRange(new byte[] { args[1].Prefix, 0x22 });

				if (bytes.Count > 0) {
					bytes.AddRange(args[0].GetData(2));
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
				}

			} else if (args[1].Mode == OperandEnumZ80.Addr) {
				List<byte> bytes = new List<byte>();

				if (args[0].Mode == OperandEnumZ80.A)
					// ld a, (**)
					bytes.Add(0x3A);

				else if (args[0].Mode == OperandEnumZ80.HL)
					// ld hl, (**)
					bytes.Add(0x2A);

				else if (args[0].Mode >= OperandEnumZ80.BC && args[0].Mode <= OperandEnumZ80.SP)
					// ld bc/de/hl/sp, (**)
					bytes.AddRange(new byte[] { 0xED, (byte)(0x4B | (args[0].Mode - OperandEnumZ80.BC)) });

				else if (args[0].Mode == OperandEnumZ80.IX || args[0].Mode == OperandEnumZ80.IY)
					// ld ix/iy, (**)
					bytes.AddRange(new byte[] { args[0].Prefix, 0x2A });

				if (bytes.Count > 0) {
					bytes.AddRange(args[1].GetData(2));
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
				}

			} else if (args[1].Mode == OperandEnumZ80.Imm) {
				List<byte> bytes = new List<byte>();

				if (args[0].Mode <= OperandEnumZ80.A)
					// ld b/c/d/e/h/l/(hl)/a, *
					bytes.Add((byte)(6 | ((int)args[0].Mode * 8)));

				else if (args[0].Mode >= OperandEnumZ80.BC && args[0].Mode <= OperandEnumZ80.SP)
					// ld bc/de/hl/sp, **
					bytes.Add((byte)(1 | (args[0].Mode - OperandEnumZ80.BC)));

				else if (args[0].Mode >= OperandEnumZ80.BC && args[0].Mode <= OperandEnumZ80.SP)
					// ld bc/de/hl/sp, **
					bytes.AddRange(new byte[] { 0xED, (byte)(0x4B | (args[0].Mode - OperandEnumZ80.BC)) });

				else if (args[0].Mode == OperandEnumZ80.IX || args[0].Mode == OperandEnumZ80.IY)
					// ld ix/iy, **
					bytes.AddRange(new byte[] { args[0].Prefix, 0x21 });

				else if (args[0].Mode == OperandEnumZ80.IXp || args[0].Mode == OperandEnumZ80.IYp) {
					// ld (ix/iy+*), **
					bytes.AddRange(new byte[] { args[0].Prefix, 0x36 });
					bytes.AddRange(args[0].GetData(1));

				} else if (args[0].Mode >= OperandEnumZ80.IXH && args[0].Mode <= OperandEnumZ80.IYL)
					// ld ixh/ixl/iyh/iyl, **
					bytes.AddRange(new byte[] { args[0].Prefix, (byte)(0x26 | ((int)args[0].Mode & 8)) });

				if(bytes.Count > 0) {
					bytes.AddRange(args[1].GetData(args[0].BytesCount));
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
				}

			} else if (args[0].Mode <= OperandEnumZ80.A && args[1].Mode <= OperandEnumZ80.A) {
				// ld b/c/d/e/h/l/(hl)/a, b/c/d/e/h/l/(hl)/a
				if (args[0].Mode != OperandEnumZ80.HLi || args[1].Mode != OperandEnumZ80.HLi)
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { (byte)(0x40 | ((int)args[0].Mode * 8) | (int)args[1].Mode) }));

			} else if (args[0].Mode <= OperandEnumZ80.A && (args[1].Mode == OperandEnumZ80.IXp || args[1].Mode == OperandEnumZ80.IYp)) {
				// ld b/c/d/e/h/l/a, (ix/iy+*)
				if (args[0].Mode != OperandEnumZ80.HLi) {
					List<byte> bytes = new List<byte>();
					bytes.AddRange(new byte[] { args[1].Prefix, (byte)(0x46 | ((int)args[0].Mode * 8)) });
					bytes.AddRange(args[1].GetData(1));
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
				}

			} else if (args[1].Mode <= OperandEnumZ80.A && (args[0].Mode == OperandEnumZ80.IXp || args[0].Mode == OperandEnumZ80.IYp)) {
				// ld (ix/iy+*),b/c/d/e/h/l/a
				if (args[1].Mode != OperandEnumZ80.HLi) {
					List<byte> bytes = new List<byte>();
					bytes.AddRange(new byte[] { args[0].Prefix, (byte)(0x70 | (int)args[1].Mode) });
					bytes.AddRange(args[0].GetData(1));
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
				}

			} else if (args[0].Mode == OperandEnumZ80.A && args[1].Mode == OperandEnumZ80.BCi) {
				// ld a, (bc)
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xA }));

			} else if (args[0].Mode == OperandEnumZ80.A && args[1].Mode == OperandEnumZ80.DEi) {
				// ld a, (de)
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0x1A }));

			} else if (args[1].Mode == OperandEnumZ80.A && args[0].Mode == OperandEnumZ80.BCi) {
				// ld (bc), a
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0x2 }));

			} else if (args[1].Mode == OperandEnumZ80.A && args[0].Mode == OperandEnumZ80.DEi) {
				// ld (de), a
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0x12 }));

			} else if (args[0].Mode == OperandEnumZ80.SP) {
				if (args[1].Mode == OperandEnumZ80.HL)
					// ld sp, hl
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xF9 }));

				else if (args[1].Mode == OperandEnumZ80.IX || args[1].Mode == OperandEnumZ80.IY)
					// ld ix/iy, hl
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[1].Prefix, 0xF9 }));

			} else if (args[0].Mode == OperandEnumZ80.A && (args[1].Mode == OperandEnumZ80.R || args[1].Mode == OperandEnumZ80.I)) {
				// ld a, i/r
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xED, (byte)(0x50 | ((int)args[1].Mode & 0xF)) }));

			} else if (args[1].Mode == OperandEnumZ80.A && (args[0].Mode == OperandEnumZ80.R || args[0].Mode == OperandEnumZ80.I)) {
				// ld i/r, a
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xED, (byte)(0x40 | ((int)args[0].Mode & 0xF)) }));

			} else if (args[0].Mode >= OperandEnumZ80.IXH && args[0].Mode <= OperandEnumZ80.IYL && args[1].Mode >= OperandEnumZ80.IXH && args[1].Mode <= OperandEnumZ80.IYL) {
				// ld ixh/ixl/iyh/iyl, ixh/ixl/iyh/iyl
				if((args[0].Mode & OperandEnumZ80.IY) == (args[1].Mode & OperandEnumZ80.IY))
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[0].Prefix, (byte)(0x64 | ((int)args[0].Mode & 0x8) | (((int)args[1].Mode & 0x8) >> 3)) }));

			} else if (args[0].Mode >= OperandEnumZ80.IXH && args[0].Mode <= OperandEnumZ80.IYL && (args[1].Mode <= OperandEnumZ80.E || args[1].Mode == OperandEnumZ80.A)) {
				// ld ixh/ixl/iyh/iyl, b/c/d/e/a
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[0].Prefix, (byte)(0x60 | (int)args[1].Mode | ((int)args[0].Mode & 0x8)) }));

			} else if (args[1].Mode >= OperandEnumZ80.IXH && args[1].Mode <= OperandEnumZ80.IYL && (args[0].Mode <= OperandEnumZ80.E || args[0].Mode == OperandEnumZ80.A)) {
				// ld b/c/d/e/a, ixh/ixl/iyh/iyl
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[1].Prefix, (byte)(0x44 | ((int)args[0].Mode * 8) | (((int)args[1].Mode & 0x8) >> 3)) }));
			}

			return InvalidRegs(Ref.Arguments, "ld");
		}
		#endregion

		#region In & Out Opcodes
		public static Tuple<TokenState, AssemblyToken> In(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size);
			OperandModeZ80[] args = ProcArgs(Ref.Arguments, Ref.Arguments.Count == 1 ? 1 : 2, out TokenState state);

			if(Ref.Arguments.Count == 1) {
				Undocumented("The in instruction with only 1 argument is");
				if (args[0].Mode == OperandEnumZ80.Ci)
					// in (c)
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xED, 0x70 }));

			} else if (args[1].Mode == OperandEnumZ80.Addr) {
				if (args[0].Mode == OperandEnumZ80.A)
					// in a,(*)
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xDB, args[1].GetData(1)[0] }));

			} else if (args[1].Mode == OperandEnumZ80.Ci) {
				if (args[0].Mode <= OperandEnumZ80.A && args[0].Mode != OperandEnumZ80.HLi)
					// in b/c/d/e/h/l/a,(c)
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xED, (byte)(0x40 | ((int)args[0].Mode << 3)) }));

			}

			return InvalidRegs(Ref.Arguments, "in");
		}

		public static Tuple<TokenState, AssemblyToken> Out(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size);
			OperandModeZ80[] args = ProcArgs(Ref.Arguments, 2, out TokenState state);

			if (args[0].Mode == OperandEnumZ80.Addr) {
				if (args[1].Mode == OperandEnumZ80.A)
					// out (*), a
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xD3, args[0].GetData(1)[0] }));

			} else if (args[0].Mode == OperandEnumZ80.Ci) {
				if (args[1].Mode <= OperandEnumZ80.A && args[1].Mode != OperandEnumZ80.HLi)
					// out (c),b/c/d/e/h/l/a
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xED, (byte)(0x41 | ((int)args[0].Mode << 3)) }));

				else if(args[1].Mode == OperandEnumZ80.Addr || args[1].Mode == OperandEnumZ80.Imm)
					if(args[1].Parts[0] == 0) {
						// out (c),0
						Undocumented("The out (c),0 instruction is");
						return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xED, 0x71 }));
					}
			}

			return InvalidRegs(Ref.Arguments, "out");
		}
		#endregion

		#region Jp & Call Opcodes
		public static Tuple<TokenState, AssemblyToken> Jp(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size);

			if(Ref.Arguments.Count == 2)
				return _jpcall(Ref, Ref.Arguments[1], _GetCode("jp", Ref.Arguments[0], 2));

			if (Ref.Arguments.Count != 1)
				FormatError("Incorrect number of arguments: Expected 1 or 2 but got " + Ref.Arguments.Count + "!");

			OperandModeZ80[] args = ProcArgs(Ref.Arguments, 1, out TokenState state);

			if(args[0].Mode == OperandEnumZ80.HLi) {
				// jp (hl)
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xE9 }));

			} else if(args[0].Mode == OperandEnumZ80.IXi || args[0].Mode == OperandEnumZ80.IYi) {
				// jp (ix/iy)
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[0].Prefix, 0xE9 }));

			} else if(args[0].Mode == OperandEnumZ80.Imm || args[0].Mode == OperandEnumZ80.Addr) {
				// jp **
				return _jpcall(Ref, Ref.Arguments[0], 0xC3);
			}

			return InvalidRegs(Ref.Arguments, "jp");
		}

		public static Tuple<TokenState, AssemblyToken> Jpnz(AssemblyTokenMacroRef Ref) => _jp(Ref, "nz");
		public static Tuple<TokenState, AssemblyToken> Jpz(AssemblyTokenMacroRef Ref) => _jp(Ref, "z");
		public static Tuple<TokenState, AssemblyToken> Jpnc(AssemblyTokenMacroRef Ref) => _jp(Ref, "nc");
		public static Tuple<TokenState, AssemblyToken> Jpc(AssemblyTokenMacroRef Ref) => _jp(Ref, "c");
		public static Tuple<TokenState, AssemblyToken> Jppo(AssemblyTokenMacroRef Ref) => _jp(Ref, "po");
		public static Tuple<TokenState, AssemblyToken> Jppe(AssemblyTokenMacroRef Ref) => _jp(Ref, "pe");
		public static Tuple<TokenState, AssemblyToken> Jpnv(AssemblyTokenMacroRef Ref) => _jp(Ref, "nv");
		public static Tuple<TokenState, AssemblyToken> Jpv(AssemblyTokenMacroRef Ref) => _jp(Ref, "v");
		public static Tuple<TokenState, AssemblyToken> Jpp(AssemblyTokenMacroRef Ref) => _jp(Ref, "p");
		public static Tuple<TokenState, AssemblyToken> Jpm(AssemblyTokenMacroRef Ref) => _jp(Ref, "m");

		private static Tuple<TokenState, AssemblyToken> _jp(AssemblyTokenMacroRef Ref, string code) {
			ProcSize(Ref.Size);
			
			if(Ref.Arguments.Count != 1)
				FormatError("Incorrect number of arguments: Expected 1 but got " + Ref.Arguments.Count + "!");

			return _jpcall(Ref, Ref.Arguments[0], _GetCode("jp", code, 2));
		}

		private static Tuple<TokenState, AssemblyToken> _jpcall(AssemblyTokenMacroRef Ref, string dest, byte code) {
			OperandModeZ80[] args = ProcArgs(new string[] { dest }, 1, out TokenState state);
			List<byte> bytes = new List<byte>() { code };
			bytes.AddRange(args[0].GetData(2));
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(bytes.ToArray()));
		}

		private static byte _GetCode(string ins, string code, int off) {
			byte cd = 0;

			switch (code.ToLowerInvariant()) {
				case "nz": cd = 0xC0; break;
				case "z": cd = 0xC8; break;
				case "nc": cd = 0xD0; break;
				case "c": cd = 0xD8; break;
				case "nv": cd = 0xE0; break;
				case "v": cd = 0xE8; break;
				case "po": cd = 0xE0; break;
				case "pe": cd = 0xE8; break;
				case "p": cd = 0xF0; break;
				case "m": cd = 0xF8; break;

				default:
					FormatError("Invalid condition for the " + ins + " instruction: " + code);
					break;
			}

			return (byte)(cd + off);
		}

		public static Tuple<TokenState, AssemblyToken> Callnz(AssemblyTokenMacroRef Ref) => _call(Ref, "nz");
		public static Tuple<TokenState, AssemblyToken> Callz(AssemblyTokenMacroRef Ref) => _call(Ref, "z");
		public static Tuple<TokenState, AssemblyToken> Callnc(AssemblyTokenMacroRef Ref) => _call(Ref, "nc");
		public static Tuple<TokenState, AssemblyToken> Callc(AssemblyTokenMacroRef Ref) => _call(Ref, "c");
		public static Tuple<TokenState, AssemblyToken> Callpo(AssemblyTokenMacroRef Ref) => _call(Ref, "po");
		public static Tuple<TokenState, AssemblyToken> Callpe(AssemblyTokenMacroRef Ref) => _call(Ref, "pe");
		public static Tuple<TokenState, AssemblyToken> Callnv(AssemblyTokenMacroRef Ref) => _call(Ref, "nv");
		public static Tuple<TokenState, AssemblyToken> Callv(AssemblyTokenMacroRef Ref) => _call(Ref, "v");
		public static Tuple<TokenState, AssemblyToken> Callp(AssemblyTokenMacroRef Ref) => _call(Ref, "p");
		public static Tuple<TokenState, AssemblyToken> Callm(AssemblyTokenMacroRef Ref) => _call(Ref, "m");

		private static Tuple<TokenState, AssemblyToken> _call(AssemblyTokenMacroRef Ref, string code) {
			ProcSize(Ref.Size);

			if (Ref.Arguments.Count != 1)
				FormatError("Incorrect number of arguments: Expected 1 but got " + Ref.Arguments.Count + "!");

			return _jpcall(Ref, Ref.Arguments[0], _GetCode("call", code, 4));
		}

		public static Tuple<TokenState, AssemblyToken> Call(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size);

			if (Ref.Arguments.Count == 2)
				return _jpcall(Ref, Ref.Arguments[1], _GetCode("jp", Ref.Arguments[0], 2));

			if (Ref.Arguments.Count != 1)
				FormatError("Incorrect number of arguments: Expected 1 or 2 but got " + Ref.Arguments.Count + "!");

			return _jpcall(Ref, Ref.Arguments[0], 0xCD);
		}
		#endregion

		#region Conditional Opcodes
		public static Tuple<TokenState, AssemblyToken> Ret(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size);

			if (Ref.Arguments.Count == 1)
				return _ret2(Ref, _GetCode("ret", Ref.Arguments[0], 0));

			if (Ref.Arguments.Count != 0)
				FormatError("Incorrect number of arguments: Expected 0 or 1 but got " + Ref.Arguments.Count + "!");

			return _ret2(Ref, 0xC9);
		}

		public static Tuple<TokenState, AssemblyToken> Retnz(AssemblyTokenMacroRef Ref) => _ret(Ref, "nz");
		public static Tuple<TokenState, AssemblyToken> Retz(AssemblyTokenMacroRef Ref) => _ret(Ref, "z");
		public static Tuple<TokenState, AssemblyToken> Retnc(AssemblyTokenMacroRef Ref) => _ret(Ref, "nc");
		public static Tuple<TokenState, AssemblyToken> Retc(AssemblyTokenMacroRef Ref) => _ret(Ref, "c");
		public static Tuple<TokenState, AssemblyToken> Retpo(AssemblyTokenMacroRef Ref) => _ret(Ref, "po");
		public static Tuple<TokenState, AssemblyToken> Retpe(AssemblyTokenMacroRef Ref) => _ret(Ref, "pe");
		public static Tuple<TokenState, AssemblyToken> Retnv(AssemblyTokenMacroRef Ref) => _ret(Ref, "nv");
		public static Tuple<TokenState, AssemblyToken> Retv(AssemblyTokenMacroRef Ref) => _ret(Ref, "v");
		public static Tuple<TokenState, AssemblyToken> Retp(AssemblyTokenMacroRef Ref) => _ret(Ref, "p");
		public static Tuple<TokenState, AssemblyToken> Retm(AssemblyTokenMacroRef Ref) => _ret(Ref, "m");

		private static Tuple<TokenState, AssemblyToken> _ret(AssemblyTokenMacroRef Ref, string code) {
			ProcSize(Ref.Size);

			if (Ref.Arguments.Count != 0)
				FormatError("Incorrect number of arguments: Expected 0 but got " + Ref.Arguments.Count + "!");

			return _ret2(Ref,_GetCode("ret", code, 0));
		}

		private static Tuple<TokenState, AssemblyToken> _ret2(AssemblyTokenMacroRef Ref, byte code) {
			return new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { code }));
		}

		public static Tuple<TokenState, AssemblyToken> Djnz(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size);

			if (Ref.Arguments.Count != 1)
				FormatError("Incorrect number of arguments: Expected 1 or 2 but got " + Ref.Arguments.Count + "!");

			return _jr3(Ref, Ref.Arguments[0], 0x10);

		}

		public static Tuple<TokenState, AssemblyToken> Jr(AssemblyTokenMacroRef Ref) {
			ProcSize(Ref.Size);

			if (Ref.Arguments.Count == 2)
				return _jr2(Ref, Ref.Arguments[1], Ref.Arguments[0]);

			if (Ref.Arguments.Count != 1)
				FormatError("Incorrect number of arguments: Expected 1 or 2 but got " + Ref.Arguments.Count + "!");

			return _jr3(Ref, Ref.Arguments[0], 0x18);
		}

		public static Tuple<TokenState, AssemblyToken> Jrnz(AssemblyTokenMacroRef Ref) => _jr(Ref, "nz");
		public static Tuple<TokenState, AssemblyToken> Jrz(AssemblyTokenMacroRef Ref) => _jr(Ref, "z");
		public static Tuple<TokenState, AssemblyToken> Jrnc(AssemblyTokenMacroRef Ref) => _jr(Ref, "nc");
		public static Tuple<TokenState, AssemblyToken> Jrc(AssemblyTokenMacroRef Ref) => _jr(Ref, "c");

		private static Tuple<TokenState, AssemblyToken> _jr(AssemblyTokenMacroRef Ref, string code) {
			ProcSize(Ref.Size);

			if (Ref.Arguments.Count != 1)
				FormatError("Incorrect number of arguments: Expected 1 but got " + Ref.Arguments.Count + "!");

			return _jr2(Ref, Ref.Arguments[0], code);
		}

		private static Tuple<TokenState, AssemblyToken> _jr2(AssemblyTokenMacroRef Ref, string dest, string code) {
			byte cd = 0;

			switch (code.ToLowerInvariant()) {
				case "nz": cd = 0x20; break;
				case "z": cd = 0x28; break;
				case "nc": cd = 0x30; break;
				case "c": cd = 0x38; break;

				default:
					FormatError("Invalid condition for the jp instruction: " + code);
					break;
			}

			return _jr3(Ref, dest, cd);
		}

		private static Tuple<TokenState, AssemblyToken> _jr3(AssemblyTokenMacroRef Ref, string dest, byte code) {
			OperandModeZ80[] args = ProcArgs(new string[] { dest }, 1, out TokenState state);
			return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { code, InternalMacros.GetDataBytes(1, (args[0].Parts[0] & 0xFFFF) - (((long)Address & 0xFFFF) + 2), false, 1)[0] }));
		}
		#endregion

		#region Bit CB Opcodes
		public static Tuple<TokenState, AssemblyToken> Rlc(AssemblyTokenMacroRef Ref) => _shift(Ref, 0, "rlc");
		public static Tuple<TokenState, AssemblyToken> Rrc(AssemblyTokenMacroRef Ref) => _shift(Ref, 0x8, "rrc");
		public static Tuple<TokenState, AssemblyToken> Rl(AssemblyTokenMacroRef Ref) => _shift(Ref, 0x10, "rl");
		public static Tuple<TokenState, AssemblyToken> Rr(AssemblyTokenMacroRef Ref) => _shift(Ref, 0x18, "rr");
		public static Tuple<TokenState, AssemblyToken> Sla(AssemblyTokenMacroRef Ref) => _shift(Ref, 0x20, "sla");
		public static Tuple<TokenState, AssemblyToken> Sra(AssemblyTokenMacroRef Ref) => _shift(Ref, 0x28, "sra");
		public static Tuple<TokenState, AssemblyToken> Sll(AssemblyTokenMacroRef Ref) => _shift(Ref, 0x30, "sll");
		public static Tuple<TokenState, AssemblyToken> Srl(AssemblyTokenMacroRef Ref) => _shift(Ref, 0x38, "srl");

		private static Tuple<TokenState, AssemblyToken> _shift(AssemblyTokenMacroRef Ref, byte basis, string ins) {
			ProcSize(Ref.Size);
			OperandModeZ80[] args = ProcArgs(Ref.Arguments, Ref.Arguments.Count == 2 ? 2 : 1, out TokenState state);

			if(args.Length == 1) {
				if (basis == 0x30)
					Undocumented("The " + ins + " instruction is");

				if (args[0].Mode <= OperandEnumZ80.A)
					// rlc/rrc/rl/rr/sla/sra/sll/srl b/c/d/e/(hl)/a
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xCB, (byte)(basis | (int)args[0].Mode) }));

				else if(args[0].Mode == OperandEnumZ80.IXp || args[0].Mode == OperandEnumZ80.IYp)
					// rlc/rrc/rl/rr/sla/sra/sll/srl (ix/iy+*)
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[0].Prefix, 0xCB, args[0].GetData(1)[0], (byte)(basis | 6) }));

			} else if(args[1].Mode <= OperandEnumZ80.A && args[1].Mode != OperandEnumZ80.HLi && (args[0].Mode == OperandEnumZ80.IXp || args[0].Mode == OperandEnumZ80.IYp)) {
				Undocumented("Using 2 arguments for the "+ ins +" instruction is");

				// rlc/rrc/rl/rr/sla/sra/sll/srl (ix/iy+*),b/c/d/e/a
				return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[0].Prefix, 0xCB, args[0].GetData(1)[0], (byte)(basis | (int)args[1].Mode) }));
			}

			return InvalidRegs(Ref.Arguments, ins);
		}

		public static Tuple<TokenState, AssemblyToken> Bit(AssemblyTokenMacroRef Ref) => _bit(Ref, 0x40, "bit");
		public static Tuple<TokenState, AssemblyToken> Res(AssemblyTokenMacroRef Ref) => _bit(Ref, 0x80, "res");
		public static Tuple<TokenState, AssemblyToken> Set(AssemblyTokenMacroRef Ref) => _bit(Ref, 0xC0, "set");

		private static Tuple<TokenState, AssemblyToken> _bit(AssemblyTokenMacroRef Ref, byte basis, string ins) {
			ProcSize(Ref.Size);
			OperandModeZ80[] args = ProcArgs(Ref.Arguments, Ref.Arguments.Count == 3 ? 3 : 2, out TokenState state);

			if((args[0].Mode == OperandEnumZ80.Imm || args[0].Mode == OperandEnumZ80.Addr)) {
				long val = args[0].Parts[0];

				if (val < 0 || val > 7)
					FormatError("Bit number for the " + ins + " instruction out of range: " + args[0].Parts[0]);

				val <<= 3;

				if (args.Length == 2) {
					if (args[1].Mode <= OperandEnumZ80.A)
						// bit/res/set #,b/c/d/e/(hl)/a
						return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { 0xCB, (byte)(basis | (int)val | (int)args[1].Mode) }));

					else if (args[0].Mode == OperandEnumZ80.IXp || args[0].Mode == OperandEnumZ80.IYp)
						// bit/res/set (ix/iy+*)
						return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[1].Prefix, 0xCB, args[1].GetData(1)[0], (byte)(basis | val | 6) }));

				} else if (basis != 0x40 && args[2].Mode <= OperandEnumZ80.A && args[2].Mode != OperandEnumZ80.HLi && (args[1].Mode == OperandEnumZ80.IXp || args[1].Mode == OperandEnumZ80.IYp)) {
					Undocumented("Using 3 arguments for the " + ins + " instruction is");

					// bit/res/set (ix/iy+*),b/c/d/e/a
					return new Tuple<TokenState, AssemblyToken>(state, new AssemblyTokenData(new byte[] { args[1].Prefix, 0xCB, args[1].GetData(1)[0], (byte)(basis | (int)val | (int)args[2].Mode) }));
				}
			}

			return InvalidRegs(Ref.Arguments, ins);
		}
		#endregion

		#region Zero Operand Opcodes
		public static Tuple<TokenState, AssemblyToken> Nop(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0 }));
		public static Tuple<TokenState, AssemblyToken> Rlca(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0x7 }));
		public static Tuple<TokenState, AssemblyToken> Rrca(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xF }));
		public static Tuple<TokenState, AssemblyToken> Rla(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0x17 }));
		public static Tuple<TokenState, AssemblyToken> Rra(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0x1F }));
		public static Tuple<TokenState, AssemblyToken> Daa(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0x27 }));
		public static Tuple<TokenState, AssemblyToken> Cpl(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0x2F }));
		public static Tuple<TokenState, AssemblyToken> Scf(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0x37 }));
		public static Tuple<TokenState, AssemblyToken> Ccf(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0x3F }));
		public static Tuple<TokenState, AssemblyToken> Halt(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0x76 }));
		public static Tuple<TokenState, AssemblyToken> Exx(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xD9 }));
		public static Tuple<TokenState, AssemblyToken> Ei(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xFB }));
		public static Tuple<TokenState, AssemblyToken> Di(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xF3 }));

		public static Tuple<TokenState, AssemblyToken> Neg(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0x44 }));
		public static Tuple<TokenState, AssemblyToken> Retn(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0x45 }));
		public static Tuple<TokenState, AssemblyToken> Reti(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0x4D }));
		public static Tuple<TokenState, AssemblyToken> Rrd(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0x67 }));
		public static Tuple<TokenState, AssemblyToken> Rld(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0x6F }));
		public static Tuple<TokenState, AssemblyToken> Ldi(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0xA0 }));
		public static Tuple<TokenState, AssemblyToken> Cpi(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0xA1 }));
		public static Tuple<TokenState, AssemblyToken> Ini(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0xA2 }));
		public static Tuple<TokenState, AssemblyToken> Outi(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0xA3 }));
		public static Tuple<TokenState, AssemblyToken> Ldd(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0xA8 }));
		public static Tuple<TokenState, AssemblyToken> Cpd(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0xA9 }));
		public static Tuple<TokenState, AssemblyToken> Ind(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0xAA }));
		public static Tuple<TokenState, AssemblyToken> Outd(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0xAB }));
		public static Tuple<TokenState, AssemblyToken> Ldir(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0xB0 }));
		public static Tuple<TokenState, AssemblyToken> Cpir(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0xB1 }));
		public static Tuple<TokenState, AssemblyToken> Inir(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0xB2 }));
		public static Tuple<TokenState, AssemblyToken> Otir(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0xB3 }));
		public static Tuple<TokenState, AssemblyToken> Lddr(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0xB8 }));
		public static Tuple<TokenState, AssemblyToken> Cpdr(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0xB9 }));
		public static Tuple<TokenState, AssemblyToken> Indr(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0xBA }));
		public static Tuple<TokenState, AssemblyToken> Otdr(AssemblyTokenMacroRef Ref) => new Tuple<TokenState, AssemblyToken>(TokenState.Static, new AssemblyTokenData(new byte[] { 0xED, 0xBB }));
		#endregion
	}

	#region Operand Modes
	public class OperandModeZ80 {
		public dynamic[] Parts;
		public OperandEnumZ80 Mode;

		public OperandModeZ80(OperandEnumZ80 Mode, dynamic[] Parts, TokenState state) {
			this.Mode = Mode;
			this.Parts = Parts;
			if(Options.UndocZ80 && Mode >= OperandEnumZ80.IXH && Mode <= OperandEnumZ80.IYL)
				FormatError("Register "+ Mode +" only available if undocumented instructions are enabled!");
		}

		public byte Prefix => (byte)(Mode < OperandEnumZ80.IXi ? 0 : Mode == OperandEnumZ80.IY || ((int)Mode & 1) != 0 ? 0xFD : 0xDD);
		public int BytesCount => Mode == OperandEnumZ80.AF || Mode == OperandEnumZ80.AF2 || Mode == OperandEnumZ80.IX || Mode == OperandEnumZ80.IY || (Mode >= OperandEnumZ80.BC && Mode <= OperandEnumZ80.SP) ? 2 : 1;

		public byte[] GetData(int bytes) {
			if(Mode == OperandEnumZ80.Addr)
				return InternalMacros.GetDataBytes(bytes, bytes == 2 ? Parts[0] & 0xFFFF : Parts[0], false, bytes);

			if (Mode == OperandEnumZ80.Imm)
				return InternalMacros.GetDataBytes(bytes, Parts[0], false, bytes);

			if (Mode == OperandEnumZ80.IXp || Mode == OperandEnumZ80.IYp)
				return InternalMacros.GetDataBytes(1, Parts[0], false, 1);

			return new byte[0];
		}
	}

	public enum OperandEnumZ80 {
		B = 0, C, D, E, H, L, HLi, A, Ci,
		BC = 0x10, DE = 0x20, HL = 0x30, SP = 0x40,
		Imm = 0x50, Addr, I = 0x57, R = 0x5F,
		AF = 0x60, AF2, AFi = 0x70,
		BCi = 0x80, DEi = 0x90, SPi = 0xA0,

		IXi = 0xB0, IYi,
		IXp = 0xC0, IYp,
		IX = 0xD0, IY = 0xF0,
		IXH = 0xE0, IYH, IXL = 0xE8, IYL,
	}
	#endregion
}