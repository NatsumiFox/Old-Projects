using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _68kdasm {
	class Program {
		private static bool writeoffs, longexpr;
		private static long coff, stoff;
		private static FileStream sin = null;
		private static TextWriter sout = null;

		static void Main(string[] a) {
			bool offs = false, hilo = false, dbra = false, longexpr = false;
			long coff = -1;
			string fin = null, fout = null;
			FileStream sin = null;
			TextWriter sout = null;

			if(a.Length == 0) {
				help();
			}

			try {
				for (int i = 0;i < a.Length;i++) {
					if (a[i].StartsWith("-") && a[i].Length == 2) {
						switch (a[i].ElementAt(1)) {
							case 'p':case 'P':
								i++;
								coff = NumFromString(a[i]);
								break;

							case 'w':case 'W':
								offs = true;

								if(coff == -1) {
									coff = 0;
								}
								break;

							case 'i':case 'I':
								i++;
								fin = a[i];
								break;
								
							case 'o':case 'O':
								i++;
								fout = a[i];
								break;

							case 'x':case 'X':
								hilo = true;
								break;

							case 'l':case 'L':
								longexpr = true;
								break;

							case 'r':case 'R':
								dbra = true;
								break;

							default:
								l("Unrecognized switch: "+ a[i]);
								break;
						}
					} else {
						l("Unrecognized switch: " + a[i]);
					}
				}
			} catch(Exception ex) {
				e(ex);
				l("Could not parse file!");
				q();
			}

			if(fin == null) {
				q("No input file specified!");
			}

			if (!File.Exists(fin)) {
				q("Input file '" + fin + "' does not exist.");
			}

			try {
				sin = File.OpenRead(fin);

				if (sin == null || !sin.CanRead) {
					q("Input file '" + fin + "' can not be read.");
				}

			} catch (Exception ex) {
				e("Exception occurred when creating filestream for '" + fin + "'", ex);
				q();
			}

			try {
				if (fout != null) {
					sout = new StreamWriter(fout, false);

					if (sout == null) {
						q("Output file '" + fout + "' can not be written to.");
					}

				} else {
					// if no input file specified, change the otuput to console
					sout = Console.Out;

					if (sout == null) {
						q("Console can not be written to.");
					}
				}

			} catch (Exception ex) {
				e("Exception occurred when creating filestream for '" + fout + "'", ex);
				q();
			}

			dasm(sin, sout, coff, offs, hilo, dbra, longexpr);
			q("Disassembly complete!");
		}

		private static void help() {
			q("68kdasm usage:\n"+
				"68kdasm [-switches]\n"+
				"Switches:\n" +
				"-i file  Specify input file. 'file' is the relative or absolute path of the\n"+
				"         input file.\n" +
				"-o file  Specify output file. 'file' is the relative or absolute path of the\n"+
				"         output file.\n" +
				"-w       Write offsets to the output file and convert all relative offsets into\n"+
				"         absolute offsets.\n" +
				"-p offs  Specify the starting offset of the input file. 'offs' will contain the\n"+
				"         decimal or hexadecimal offset. Must be paired with '-w' flag.\n" +
				"-x       Changes condition codes 'cc' and 'cs' to 'hs' and 'lo' respectively.\n" +
				"-l       Changes moveq expression from '#$FF' to '#$FFFFFFFF'.\n" +
				"-r       Changes 'dbf' to 'dbra'.\n");
		}

		private static bool dasm(FileStream i, TextWriter o, long st, bool wo, bool hilo, bool dbra, bool longxpr) {
			coff = stoff = st;
			writeoffs = wo;
			sin = i;
			sout = o;
			longexpr = longxpr;

			if (hilo) {
				bccCon[4] = "bhs";
				bccCon[5] = "blo";
				dbccCon[4] = "dbhs";
				dbccCon[5] = "dblo";
				sccCon[4] = "shs";
				sccCon[5] = "slo";

			} else {
				bccCon[4] = "bcc";
				bccCon[5] = "bcs";
				dbccCon[4] = "dbcc";
				dbccCon[5] = "dbcs";
				sccCon[4] = "scc";
				sccCon[5] = "scs";
			}

			if (dbra) {
				dbccCon[1] = "dbra";
			} else {
				dbccCon[1] = "dbf";
			}

			try {
				while (sin.Position != sin.Length) {
					if (writeoffs) {
						sout.Write(toHexString(coff, 6) +':');
					}

					sout.Write('\t');
					short w = rw();
					inss(w, (w & 0xF000) >> 12, InsHighNibble);
				}

				sout.Flush();
				sin.Close();
				return true;

			} catch(Exception ex) {
				e("Can not disassemble file! Exception:", ex);

				sout.Flush();
				sout.Dispose();
				sin.Close();
				q();
				return false;
			}
		}

		private static void inss(short w, int v, Action<short>[] code) {
			try {
				code[v].Invoke(w);

			} catch (Exception ex) {
				try {
					e("Could not invoke method! " + GetMemberName(new { code }) +"["+ v +"].Invoke(" + w + ") failed!", ex);
				} catch (Exception ex2) {
					e("Could not invoke method! ?["+ v +"].Invoke(" + w + ") failed! ", ex);
					e("Could not find name of '" + code + "'! ", ex2);
				}

				q();
			}
		}

		private static object dtss(int v, Func<object[], object>[] code, object[] param) {
			try {
				return code[v].Invoke(param);

			} catch (Exception ex) {
				try {
					e("Could not invoke method! " + GetMemberName(new { code }) + "[" + v + "].Invoke(" + param + ") failed!", ex);
				} catch (Exception ex2) {
					e("Could not invoke method! ?[" + v + "].Invoke("+ param +") failed! ", ex);
					e("Could not find name of '" + code + "'! ", ex2);
				}
			}

			q();
			return null;
		}

		private static string GetMemberName<T>(T code) {
			return typeof(T).GetProperties()[0].Name;
		}

		public static string[] bccCon = {
			"bra", "bsr", "bhi", "bls", "bcc", "bcs", "bne", "beq", "bvc", "bvs", "bpl", "bmi", "bge", "blt", "bgt", "ble"
		};

		public static string[] dbccCon = {
			"dbt", "dbf", "dbhi", "dbls", "dbcc", "dbcs", "dbne", "dbeq", "dbvc", "dbvs", "dbpl", "dbmi", "dbge", "dblt", "dbgt", "dble"
		};

		public static string[] sccCon = {
			"st", "sf", "shi", "sls", "scc", "scs", "sne", "seq", "svc", "svs", "spl", "smi", "sge", "slt", "sgt", "sle"
		};

		public static Action<short>[] InsHighNibble = {
			(i) => { ix0xxx(i); },
			(i) => { imove(i); },
			(i) => { imove(i); },
			(i) => { imove(i); },
			(i) => { ix4xxx(i); },
			(i) => { ix5xxx(i); },
			(i) => { ibcc(i); },
			(i) => { imoveq(i); },
			(i) => { ix8xxx(i); },
			(i) => { isub(i); },
			(i) => { data(i); },	// LineA
			(i) => { ixBxxx(i); },
			(i) => { ixCxxx(i); },
			(i) => { iadd(i); },
			(i) => { ixExxx(i); },
			(i) => { data(i); },	// LineF
		};

		private static void data(short i) {
			sout.WriteLine("dc.w\t" + toHexGen(i, 2));
		}

		public static Func<object[], OpModeRet>[] addsubop = {
			(p) => { return new OpModeRet(false, 'b'); },
			(p) => { return new OpModeRet(false, 'w'); },
			(p) => { return new OpModeRet(false, 'l'); },
			(p) => { return new OpModeRet(true, '1'); },
			(p) => { return new OpModeRet(true, 'b'); },
			(p) => { return new OpModeRet(true, 'w'); },
			(p) => { return new OpModeRet(true, 'l'); },
			(p) => { return new OpModeRet(true, '2'); },
		};

		private static Func<object[], object>[] addressingmodes = {
			(p) => { return "d"+ p[1]; },
			(p) => {
				if (((char)p[0]) == 'b') {
					throw new IllegalOperatorException("addressing mode can not be address register direct when instruction size is byte");
				} else {
					return "a"+ p[1];
				}
			},
			(p) => { return "(a"+ p[1] +')'; },
			(p) => { return "(a"+ p[1] +")+"; },
			(p) => { return "-(a"+ p[1] +')'; },
			(p) => { return toHexGen(rw(), 4) +"(a"+ p[1] +')'; },
			(p) => {
				short x = rw();
				return toHexGen(x & 0xFF, 2) +"(a"+ p[1] +", d"+ ((x & 0x7000) >> 12) +'.'+ ((x & 0x0800) != 0 ? 'l' : 'w') +')';
			},
			(p) => { return (string)dtss((int)p[1], addressingmodes2, new object[] { p[0] }); },
		};

		private static Func<object[], object>[] addressingmodes2 = {
			(p) => {
				short x = rw();
				if((x & 0x8000) == 0) {
					return '('+ toHexGen(x, 4) +").w";

				} else {
					return '('+ toHexGen(sexwl((ushort)x), 8) +").w";
				}
			},
			(p) => { return '('+ toHexGen(rl(), 8) +").l"; },
			(p) => {
				short x = rw();
				int n = 4;
				int off = x + 2;
				if (writeoffs) {
					n = 6;
					off = OffsetFromDisplacement(x - 2);
				}

				return toHexGen(off, n) +"(PC)"; },
			(p) => {
				short x = rw();
				int n = 2;
				int off = (x & 0xFF) + 2;
				if (writeoffs) {
					n = 6;
					off = OffsetFromDisplacement((x & 0xFF) - 2);
				}

				return toHexGen(off, n) +"(PC, d"+ ((x & 0x7000) >> 12) +'.'+ ((x & 0x0800) != 0 ? 'l' : 'w') +')';
			},
			(p) => {
				char c = (char)p[0];
				int n = 2;
				if(c == 'w') {
					n = 4;
				} else if(c == 'l'){
					n = 8;
				}

				return '#'+ toHexGen(c == 'l' ? rl() : rw(), n);
			},
		};

		internal class OpModeRet {
			public OpModeRet(bool d, char s) {
				dsrc = d;
				size = s;
			}

			public bool dsrc;
			public char size;
		}

		private static char getInsSize1(int v) {
			switch (v) {
				case 0:
					return 'b';

				case 1:
					return 'w';

				case 2:
					return 'l';

				default:
					throw new IllegalInstructionSizeException("instruction size code "+ v +" is invalid!");
			}
		}

		private static char getInsSize2(int v) {
			switch (v) {
				case 1:
					return 'b';

				case 3:
					return 'w';

				case 2:
					return 'l';

				default:
					throw new IllegalInstructionSizeException("instruction size code " + v + " is invalid!");
			}
		}

		private static int OffsetFromDisplacement(int v) {
			if ((v & 0x80) == 0) {
				return ((byte) (v & 0xFF)) + (int) coff;

			} else {
				return (int) coff - ((byte) -(v & 0xFF));
			}
		}

		private static int OffsetFromDisplacement2(int v) {
			if ((v & 0x8000) == 0) {
				return ((short) (v & 0xFFFF)) + (int) coff - 2;

			} else {
				return (int) coff - ((short) -(v & 0xFFFF) + 2);
			}
		}

		private static void genericInsOpmode(string ins, short i, OpModeRet op, int register, int eaMode, int eaRegister) {
			string o = ins +'.'+ op.size +'\t';

			if (op.dsrc) {
				o += "d" + register +", ";
			}
			
			o += CheckOpValid(addressingmodes, ins, i, op.size, eaMode, eaRegister);
			if (!op.dsrc) {
				o += ", d" + register;
			}

			sout.WriteLine(o);
		}

		private static string CheckOpValid(Func<object[], object>[] f, string ins, short opc, char sz, int ea, int r) {
			object v = dtss(ea, f, new object[] { sz, r });
			if (v != null && v is string) {
				return (string) v;
			}

			throw new IllegalOperatorException("Operator poll returned null!\n" +
				"ins: " + ins
				+ "\nopcode: " + toHexString(opc, 4)
				+ "\nea: " + ea
				+ "\neareg: " + r
				+ "\nsize: " + sz);
		}

		private static void ix0xxx(short i) {
			if((i & 0x0038) == 8 && (i & 0x0100) != 0) {
				// MOVEP
				char size = ((i & 0x0040) == 0) ? 'w' : 'l';
				int dreg = (i & 0x0E00) >> 9, areg = i & 0x0007;
				string o = "movep." + size + '\t';

				if((i & 0x0080) == 0) {
					// d16(aN), dN
					o += toHexGen(rw(), 4) + "(a" + areg + "), d" + dreg;

				} else {
					// dN, d16(aN)
					o += "d"+ dreg +", "+ toHexGen(rw(), 4) + "(a" + areg + ')';
				}
				sout.WriteLine(o);

			} else if((i & 0x0100) == 0) {
				inss(i, (i & 0x0E00) >> 9, ix00xxdat);

			} else {
				// BXXX dN, <ea>
				string ins = bccc[(i & 0x00C0) >> 6];
				int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007, reg = (i & 0x0E00) >> 9;
				sout.WriteLine(ins +"\td"+ reg +", "+ CheckOpValid(addressingmodes, ins, i, eamode == 0 ? 'l' : 'b', eamode, eareg));
			}
		}

		private static void bxxx(short i) {
			// BXXX #, <ea>
			string ins = bccc[(i & 0x00C0) >> 6];
			int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007, reg = (i & 0x0E00) >> 9;
			sout.WriteLine(ins + "\t#" + rw() + ", " + CheckOpValid(addressingmodes, ins, i, eamode == 0 ? 'l' : 'b', eamode, eareg));
		}

		public static string[] bccc = {
			"btst",// %xxxxxxxx00xxxxxx
			"bchg",// %xxxxxxxx01xxxxxx
			"bclr",// %xxxxxxxx10xxxxxx
			"bset",// %xxxxxxxx11xxxxxx
		};

		public static Action<short>[] ix00xxdat = {
			(i) => { logici(i, "ori"); },	// %xxxx000xxxxxxxxx
			(i) => { logici(i, "andi"); },	// %xxxx001xxxxxxxxx
			(i) => { subaddi(i, "subi"); },	// %xxxx010xxxxxxxxx
			(i) => { subaddi(i, "addi"); },	// %xxxx011xxxxxxxxx
			(i) => { bxxx(i); },			// %xxxx100xxxxxxxxx
			(i) => { logici(i, "eori"); },	// %xxxx101xxxxxxxxx
			(i) => { subaddi(i, "cmpi"); },	// %xxxx110xxxxxxxxx
			(i) => { data(i); },			// %xxxx111xxxxxxxxx
		};

		private static void logici(short i, string ins) {
			int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
			char size = getInsSize1((i & 0x00C0) >> 6);
			string o = ins + '.' + size + "\t#";

			if (size == 'l') {
				o += toHexGen(rl(), 4);

			} else {
				o += toHexGen(rw(), size == 'b' ? 2 : 4);
			}

			o += ", ";
			if (eamode == 7 && eareg == 4) {
				o += size == 'b' ? "ccr" : "sr";

			} else {
				o += CheckOpValid(addressingmodes, ins, i, size, eamode, eareg);
			}

			sout.WriteLine(o);
		}

		private static void subaddi(short i, string ins) {
			int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
			char size = getInsSize1((i & 0x00C0) >> 6);
			string o = ins + '.' + size + "\t#";

			if (size == 'l') {
				o += toHexGen(rl(), 4);

			} else {
				o += toHexGen(rw(), size == 'b' ? 2 : 4);
			}

			o += ", "+ CheckOpValid(addressingmodes, ins, i, size, eamode, eareg);
			sout.WriteLine(o);
		}

		private static void ix4xxx(short i) {
			inss(i, (i & 0x0FC0) >> 6, ix4xxxdat);
		}

		public static Action<short>[] ix4xxxdat = {
			(i) => { negx(i, 'b'); },		// %xxxx000000xxxxxx
			(i) => { negx(i, 'w'); },		// %xxxx000001xxxxxx
			(i) => { negx(i, 'l'); },		// %xxxx000010xxxxxx
			(i) => { movefSR(i); },			// %xxxx000011xxxxxx
			(i) => { data(i); },			// %xxxx000100xxxxxx
			(i) => { data(i); },			// %xxxx000101xxxxxx
			(i) => { chk(i, 0); },			// %xxxx000110xxxxxx
			(i) => { lea(i, 0); },			// %xxxx000111xxxxxx
			(i) => { clr(i, 'b'); },		// %xxxx001000xxxxxx
			(i) => { clr(i, 'w'); },		// %xxxx001001xxxxxx
			(i) => { clr(i, 'l'); },		// %xxxx001010xxxxxx
			(i) => { data(i); },			// %xxxx001011xxxxxx
			(i) => { data(i); },			// %xxxx001100xxxxxx
			(i) => { data(i); },			// %xxxx001101xxxxxx
			(i) => { chk(i, 1); },			// %xxxx001110xxxxxx
			(i) => { lea(i, 1); },			// %xxxx001111xxxxxx
			(i) => { neg(i, 'b'); },		// %xxxx010000xxxxxx
			(i) => { neg(i, 'w'); },		// %xxxx010001xxxxxx
			(i) => { neg(i, 'l'); },		// %xxxx010010xxxxxx
			(i) => { movetCCR(i); },		// %xxxx010011xxxxxx
			(i) => { data(i); },			// %xxxx010100xxxxxx
			(i) => { data(i); },			// %xxxx010101xxxxxx
			(i) => { chk(i, 2); },			// %xxxx010110xxxxxx
			(i) => { lea(i, 2); },			// %xxxx010111xxxxxx
			(i) => { not(i, 'b'); },		// %xxxx011000xxxxxx
			(i) => { not(i, 'w'); },		// %xxxx011001xxxxxx
			(i) => { not(i, 'l'); },		// %xxxx011010xxxxxx
			(i) => { movetSR(i); },			// %xxxx011011xxxxxx
			(i) => { data(i); },			// %xxxx011100xxxxxx
			(i) => { data(i); },			// %xxxx011101xxxxxx
			(i) => { chk(i, 3); },			// %xxxx011110xxxxxx
			(i) => { lea(i, 3); },			// %xxxx011111xxxxxx
			(i) => { nbcd(i); },			// %xxxx100000xxxxxx
			(i) => { ix484x(i); },			// %xxxx100001xxxxxx
			(i) => { movemorext(i); },		// %xxxx100010xxxxxx
			(i) => { movemorext(i); },		// %xxxx100011xxxxxx
			(i) => { data(i); },			// %xxxx100100xxxxxx
			(i) => { data(i); },			// %xxxx100101xxxxxx
			(i) => { chk(i, 4); },			// %xxxx100110xxxxxx
			(i) => { lea(i, 4); },			// %xxxx100111xxxxxx
			(i) => { tst(i, 'b'); },		// %xxxx101000xxxxxx
			(i) => { tst(i, 'w'); },		// %xxxx101001xxxxxx
			(i) => { tst(i, 'l'); },		// %xxxx101010xxxxxx
			(i) => { ix4ACx(i); },			// %xxxx101011xxxxxx
			(i) => { data(i); },			// %xxxx101100xxxxxx
			(i) => { data(i); },			// %xxxx101101xxxxxx
			(i) => { chk(i, 5); },			// %xxxx101110xxxxxx
			(i) => { lea(i, 5); },			// %xxxx101111xxxxxx
			(i) => { data(i); },			// %xxxx110000xxxxxx
			(i) => { data(i); },			// %xxxx110001xxxxxx
			(i) => { movem(i, 'w', false); },// %xxxx110010xxxxxx
			(i) => { movem(i, 'l', false); },// %xxxx110011xxxxxx
			(i) => { data(i); },			// %xxxx110100xxxxxx
			(i) => { data(i); },			// %xxxx110101xxxxxx
			(i) => { chk(i, 6); },			// %xxxx110110xxxxxx
			(i) => { lea(i, 6); },			// %xxxx110111xxxxxx
			(i) => { data(i); },			// %xxxx111000xxxxxx
			(i) => { inss(i, (i & 0x0038) >> 3, ix4E4xdat); },// %xxxx111001xxxxxx
			(i) => { jxx(i, "jsr"); },		// %xxxx111010xxxxxx
			(i) => { jxx(i, "jmp"); },		// %xxxx111011xxxxxx
			(i) => { data(i); },			// %xxxx111100xxxxxx
			(i) => { data(i); },			// %xxxx111101xxxxxx
			(i) => { chk(i, 7); },			// %xxxx111110xxxxxx
			(i) => { lea(i, 7); },			// %xxxx111111xxxxxx
		};

		private static void ix484x(short i) {
			int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
			if(eamode == 0) {
				// SWAP
				sout.WriteLine("swap\td" + eareg);

			} else {
				// PEA
				sout.WriteLine("pea\t" + CheckOpValid(addressingmodes, "pea", i, 'w', eamode, eareg));
			}
		}

		private static void ix4ACx(short i) {
			if ((i & 0x003F) == 0x003C) {
				sout.WriteLine("illegal");
				return;
			}
			// TAS
			int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
			sout.WriteLine("tas\t" + CheckOpValid(addressingmodes, "tas", i, 'b', eamode, eareg));
		}

		public static Action<short>[] ix4E4xdat = {
			(i) => { trap(i); },	// %xxxxxxxxxx000xxx
			(i) => { trap(i); },	// %xxxxxxxxxx001xxx
			(i) => { link(i); },	// %xxxxxxxxxx010xxx
			(i) => { unlk(i); },	// %xxxxxxxxxx011xxx
			(i) => { movetUSP(i); },// %xxxxxxxxxx100xxx
			(i) => { movefUSP(i); },// %xxxxxxxxxx101xxx
			(i) => { ix4E7x(i); },	// %xxxxxxxxxx110xxx
			(i) => { data(i); },	// %xxxxxxxxxx111xxx
		};

		private static void ix4E7x(short i) {
			string o = ix4E7xdat[i & 0x0007];
			if(o == null) data(i);
			sout.WriteLine(o);
		}

		public static string[] ix4E7xdat = {
			"reset",// %xxxxxxxxxxxxx000
			"nop",	// %xxxxxxxxxxxxx001
			null,	// %xxxxxxxxxxxxx010
			"rte",	// %xxxxxxxxxxxxx011
			null,	// %xxxxxxxxxxxxx100
			"rts",	// %xxxxxxxxxxxxx101
			"trapv",// %xxxxxxxxxxxxx110
			"rtr",	// %xxxxxxxxxxxxx111
		};

		private static void link(short i) {
			int reg = i & 0x0007;
			sout.WriteLine("link\ta" + reg + ", #"+ toHexGen(rw(), 4));
		}

		private static void unlk(short i) {
			int reg = i & 0x0007;
			sout.WriteLine("unlk\ta" + reg);
		}

		private static void trap(short i) {
			sout.WriteLine("trap\t#"+ (i & 0x000F));
		}

		private static void movetUSP(short i) {
			int reg = i & 0x0007;
			sout.WriteLine("move.l\ta" + reg + ", usp");
		}

		private static void movetCCR(short i) {
			int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
			sout.WriteLine("move\t" + CheckOpValid(addressingmodes, "move to CCR", i, 'b', eamode, eareg) + ", ccr");
		}

		private static void movetSR(short i) {
			int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
			sout.WriteLine("move\t" + CheckOpValid(addressingmodes, "move to SR", i, 'b', eamode, eareg) + ", sr");
		}

		private static void movefUSP(short i) {
			int reg = i & 0x0007;
			sout.WriteLine("move.l\tusp, a" + reg);
		}

		private static void movefCCR(short i) {
			int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
			sout.WriteLine("move\tccr, " + CheckOpValid(addressingmodes, "move from CCR", i, 'b', eamode, eareg));
		}

		private static void movefSR(short i) {
			int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
			sout.WriteLine("move\tsr, " + CheckOpValid(addressingmodes, "move from SR", i, 'b', eamode, eareg));
		}

		private static void movemorext(short i) {
			int reg = i & 0x0007;
			if ((i & 0x0038) == 0) {
				// EXT
				char size = (i & 0x00C0) == 0x80 ? 'w' : 'l';
				sout.WriteLine("ext."+ size +"\td" + reg);
			} else {
				// MOVEM
				movem(i, (i & 0x0040) == 0 ? 'w' : 'l', true);
			}
		}

		private static void movem(short i, char size, bool tomem) {
			int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
			short m = rw();
			string o = "movem." + size + '\t';
			if(!tomem) o += CheckOpValid(addressingmodes, "movem", i, size, eamode, eareg) +", ";

			if(eamode == 4) {
				// -(aN)
				// bit order is negated
				string r = "";
				int start = -1;
				for (int z = 15;z >= 0;z--) {
					bool y = (m & (1 << z)) == 0;
					if (!y && start == -1) {
						start = z;

					} else if (y && start != -1) {
						r += "/" + movemregs(15 - start, 15 - z);
						start = -1;
					}
				}

				o += r.Substring(1);

			} else {
				string r = "";
				int start = -1;
				for(int z = 0;z < 16;z++) {
					bool y = (m & (1 << z)) == 0;
					if (!y && start == -1) {
						start = z;

					} else if(y && start != -1) {
						r += "/"+ movemregs(start, z);
						start = -1;
					}
				}

				o += r.Substring(1);
			}

			if(tomem) o += ", "+ CheckOpValid(addressingmodes, "movem", i, size, eamode, eareg);
			sout.WriteLine(o);
		}

		private static string movemregs(int start, int m) {
			if (m - start > 1) {
				return movemreg(start) +'-'+ movemreg(m - 1);

			} else {
				return movemreg(m - 1);
			}
		}

		private static string movemreg(int m) {
			return ((m & 8) == 0 ? "d" : "a") + (m & 7);
		}

		private static void chk(short i, int reg) {
			int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
			sout.WriteLine("chk\t" + CheckOpValid(addressingmodes, "chk", i, 'w', eamode, eareg) + ", d" + reg);
		}

		private static void nbcd(short i) {
			int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
			sout.WriteLine("nbcd\t" + CheckOpValid(addressingmodes, "nbcd", i, 'w', eamode, eareg));
		}

		private static void negx(short i, char size) {
			int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
			sout.WriteLine("negx." + size + '\t' + CheckOpValid(addressingmodes, "negx", i, size, eamode, eareg));
		}

		private static void not(short i, char size) {
			int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
			sout.WriteLine("not." + size + '\t' + CheckOpValid(addressingmodes, "not", i, size, eamode, eareg));
		}

		private static void neg(short i, char size) {
			int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
			sout.WriteLine("neg." + size + '\t' + CheckOpValid(addressingmodes, "neg", i, size, eamode, eareg));
		}

		private static void clr(short i, char size) {
			int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
			sout.WriteLine("clr." + size + '\t' + CheckOpValid(addressingmodes, "clr", i, size, eamode, eareg));
		}

		private static void tst(short i, char size) {
			int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
			sout.WriteLine("tst."+ size +'\t' + CheckOpValid(addressingmodes, "tst", i, size, eamode, eareg));
		}

		private static void jxx(short i, string ins) {
			int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
			sout.WriteLine(ins +'\t'+ CheckOpValid(addressingmodes, ins, i, 'w', eamode, eareg));
		}

		private static void lea(short i, int reg) {
			int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
			sout.WriteLine("lea\t" + CheckOpValid(addressingmodes, "lea", i, 'w', eamode, eareg) + ", a" + reg);
		}

		private static void ix5xxx(short i) {
			if ((i & 0x00C0) != 0x00C0) {
				int data = (i & 0x0E00) >> 9, eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
				char size = getInsSize1((i & 0x00C0) >> 6);
				string ins;
				if ((i & 0x0100) == 0) {
					ins = "addq";

				} else {
					ins = "subq";
				}

				if(data == 0) data = 8;
				sout.WriteLine(ins +'.'+ size +"\t#"+ data +", "+ CheckOpValid(addressingmodes, ins, i, size, eamode, eareg));

			} else {
				int cc = (i & 0x0F00) >> 8, eamode = (i & 0x0038) >> 3, reg = i & 0x0007;

				if(eamode == 1) {
					// dbcc
					int off = rw(), n;
					if (writeoffs) {
						off = OffsetFromDisplacement2(off);
						n = 6;

					} else {
						off -= 2;
						n = 4;
					}

					sout.WriteLine(dbccCon[cc] + "\td"+ reg +", "+ toHexGen(off, n));

				} else {
					// scc
					sout.WriteLine(sccCon[cc] +"\t"+ CheckOpValid(addressingmodes, sccCon[cc], i, ' ', eamode, reg));
				}
			}
		}

		private static void ix8xxx(short i) {
			int opmode = (i & 0x01C0) >> 6;
			if (opmode == 3) {
				// DIVU
				mul("divu", i);

			} else if (opmode == 4 && (i & 0x0030) == 0x0000) {
				// ABCD
				sabcd("sbcd", i);

			} else if (opmode == 7) {
				// DIVS
				mul("divs", i);

			} else {
				// OR
				iaddsub("or", i);
			}
		}

		private static void ixBxxx(short i) {
			int reg = (i & 0x0E00) >> 9, eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
			char size = getInsSize1((i & 0x00C0) >> 6);
			string ins;

			if ((i & 0x0100) == 0) {
				if (eamode == 1) {
					ins = "cmpa";
					
				} else {
					ins = "cmp";
				}

			} else {
				if (eamode == 1) {
					ins = "cmpm";
					return;	// TODO: OOPS
					
				} else {
					ins = "eor";
				}
			}

			sout.WriteLine(ins +'.'+ size +"\t"+ CheckOpValid(addressingmodes, ins, i, size, eamode, reg));
		}

		private static void ixCxxx(short i) {
			int opmode = (i & 0x01C0) >> 6;
			if (opmode == 3) {
				// MULU
				mul("muls", i);

			} else if (opmode == 4 && (i & 0x0030) == 0x0000) {
				// ABCD
				sabcd("abcd", i);

			} else if (opmode == 7) {
				// MULS
				mul("mulu", i);

			} else if (opmode == 5 || opmode == 6) {
				int reg1 = (i & 0x0E00) >> 9, reg2 = i & 0x0007;
				string o = "exg\t";
				// EXG
				switch ((i & 0x00F8) >> 3) {
					case 8:
						// dN <-> dN
						o += "d" + reg1 + ", d" + reg2;
						break;
					case 9:
						// aN <-> aN
						o += "a" + reg1 + ", a" + reg2;
						break;
					case 17:
						// dN <-> aN
						o += "d" + reg1 + ", a" + reg2;
						break;
					default:
						throw new IllegalOperatorException("Could not resolve opmode of value " + ((i & 0x00F8) >> 3) + '!');
				}
				sout.WriteLine(o);

			} else {
				// AND
				iaddsub("and", i);
			}
		}

		private static void sabcd(string ins, short i) {
			int reg2 = (i & 0x0E00) >> 9, reg1 = i & 0x0007;
			if((i & 0x0008) == 0) {
				sout.WriteLine(ins + "\td" + reg1 + ", d" + reg2);

			} else {
				sout.WriteLine(ins + "\t-(a" + reg1 + "), -(a" + reg2 +')');
			}
		}

		private static void mul(string ins, short i) {
			int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007, reg = (i & 0x0E00) >> 9;
			sout.WriteLine(ins + '\t'+ CheckOpValid(addressingmodes, ins, i, '\0', eamode, eareg) +", d"+ reg);
		}

		private static void ixExxx(short i) {
			if((i & 0x00C0) == 0x00C0) {
				// ea
				int eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
				string ins = shiftGetIns((i & 0x0600) >> 9, i);
				sout.WriteLine(ins + '\t' + CheckOpValid(addressingmodes, ins, i, 'w', eamode, eareg));

			} else {
				// cnt/reg
				int cntreg = (i & 0x0E00) >> 9, reg = i & 0x0007;
				char size = getInsSize1((i & 0x00C0) >> 6);
				string o = shiftGetIns((i & 0x0018) >> 3, i) + '.' + size + '\t';

				if((i & 0x0020) != 0) {
					o += 'd';

				} else {
					o += '#';
					if (cntreg == 0) {
						cntreg = 8;
					}
				}

				o += cntreg +", d"+ reg;
				sout.WriteLine(o);
			}
		}

		private static string shiftGetIns(int i, short x) {
			string ins;

			switch (i) {
				case 0:
					ins = "as";
					break;

				case 1:
					ins = "ls";
					break;

				case 2:
					ins = "rox";
					break;

				case 3:
					ins = "ro";
					break;

				default:
					throw new IllegalInstructionException("Could not find ls/as/ro/rox instructio with id "+ i);
			}

			return ins + ((x & 0x0100) == 0 ? "r" : "l");
		}

		private static void imove(short i) {
			char size = getInsSize2((i & 0x3000) >> 12);
			int destreg = (i & 0x0E00) >> 9, destmode = (i & 0x01C0) >> 6, srcmode = (i & 0x0038) >> 3, srcreg = i & 0x0007;
			string o, ins;

			// check for MOVEA
			if(destmode == 1) {
				ins = "movea";
				o = "movea." + size + '\t';

			} else {
				ins = "move";
				o = "move." + size + '\t';
			}

			o += CheckOpValid(addressingmodes, ins, i, size, srcmode, srcreg);
			o += ", ";
			o += CheckOpValid(addressingmodes, ins, i, size, destmode, destreg);
			sout.WriteLine(o);
		}

		private static void iadd(short i) {
			iaddsub("add", i);
		}

		private static void isub(short i) {
			iaddsub("sub", i);
		}

		private static void iaddsub(string ins, short i) {
			if((i & 0x0100) != 0 && (i & 0x0030) == 0) {
				// insX
				string o = ins + "x." + getInsSize1((i & 0x00C0) >> 6) +'\t';
				int rx = (i & 0x0E00) >> 9, ry = i & 0x0007;

				if((i & 0x0008) != 0) {
					sout.WriteLine(o + "-(a" + ry + "), -(a" + rx +')');

				} else {
					sout.WriteLine(o +"d"+ ry +", d"+ rx);
				}

			} else {
				char size;
				OpModeRet op = dtss((i & 0x01C0) >> 6, addsubop, null) as OpModeRet;
				if (op.size == '1') {
					size = 'w';

				} else if (op.size == '1') {
					size = 'l';

				} else {
					genericInsOpmode(ins, i, op, (i & 0x0E00) >> 9, (i & 0x0038) >> 3, i & 0x0007);
					return;
				}

				// adda/suba
				int areg = (i & 0x0E00) >> 9, eamode = (i & 0x0038) >> 3, eareg = i & 0x0007;
				sout.WriteLine(ins + "a." + size + '\t'+ CheckOpValid(addressingmodes, ins, i, size, eamode, eareg) +", a"+ areg);
			}
		}

		private static void imoveq(short i) {
			if((i & 0x0100) != 0) {
				data(1);
				return;
			}

			if (longexpr && (i & 0x80) != 0) {
				sout.WriteLine("moveq\t#" + toHexGen(sexbl((byte) (i & 0xFF)), 8) +", d"+ ((i & 0x0E00) >> 9));

			} else {
				sout.WriteLine("moveq\t#" + toHexGen(i & 0xFF, 2) + ", d" + ((i & 0x0E00) >> 9));
			}
		}

		private static void ibcc(short i) {
			long xoff = coff;
			char len = 's';

			if (writeoffs) {
				string off = toHexGen(OffsetFromDisplacement(i & 0x00FF), 6);

				if ((i & 0x00FF) == 0) {
					off = toHexGen(OffsetFromDisplacement2(rw()), 6);
					len = 'w';
				}

				sout.WriteLine(bccCon[(i & 0x0F00) >> 8] + '.' + len + "\t" + off);

			} else {
				int off = (i & 0x00FF) + 2;

				if ((i & 0x00FF) == 0) {
					off = rw() + 2;
					len = 'w';
				}

				sout.WriteLine(bccCon[(i & 0x0F00) >> 8] + '.' + len + "\t*+" + toHexGen(off, len == 'w' ? 4 : 2));
			}
		}

		private static uint sexbl(byte data) {
			return sexwl(sexbw(data));
		}

		private static uint sexwl(ushort v) {
			return 0xFFFF0000 | v;
		}

		private static ushort sexbw(byte v) {
			return (ushort) (0xFF00 | v);
		}

		private static int rl() {
			return (((ushort) rw() << 16) | ((ushort)rw()));
		}

		private static short rw() {
			return (short) ((rb() << 8) | rb());
		}

		private static byte rb() {
			coff ++;
			return (byte)sin.ReadByte();
		}

		private static string toHexString(long res, int zeroes) {
			return string.Format("{0:x" + zeroes + "}", res).ToUpper();
		}

		private static string toHexGen(long res, int zeroes) {
			return "$" + string.Format("{0:x" + zeroes + "}", (int) res).ToUpper();
		}

		private static long NumFromString(string v) {
			try {
				if (v.StartsWith("0x")) {
					return Int64.Parse(v.Substring(2), System.Globalization.NumberStyles.HexNumber);

				} else {
					return Int64.Parse(v);
				}
			} catch(Exception ex) {
				e(ex);
			}

			return -1;
		}

		private static void e(string v, Exception ex) {
			l(v);
			e(ex);
		}

		private static void e(Exception ex) {
			Console.WriteLine("Exception occurred:");
			Console.WriteLine(ex.ToString());
			Console.WriteLine("");
		}

		private static void l(string v) {
			Console.WriteLine(v);
		}

		private static void q(string v) {
			l(v);
			q();
		}

		private static void q() {
			Console.ReadKey();
			Environment.Exit(0);
		}
	}
}
