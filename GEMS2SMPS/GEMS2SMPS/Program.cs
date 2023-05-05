using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GEMS2SMPS {
	class Program {
		// set to false when the entire GEMS sequence is processed.
		private static bool run;

		// some things used by the emulator and logger
		public static int vint = -2, bytes = 0;

		// used to detect the first seq started, for loop detection (hacky!)
		public static byte firstseq = 0xFF;

		// various banks that can be easily referenced later on
		private static GEMS.Sbank sbnk;
		private static GEMS.Pbank pbnk;
		private static GEMS.Dbank dbnk;
		private static GEMS.Mbank mbnk;

		// this logger logs all GEMS activity into optimized format for SMPS conversion
		private static SMPS.Logger log;

		// various driver related nonsense
		private static GEMS.CCB[] ccb;
		private static GEMS.VTBL[] vtbl;
		private static byte[] MBOX = new byte[32];
		private static GEMS.Dbank.Dac SAMPLE;

		// handles command output
		private static Comms comm;

		static byte[] vtblch = new byte[] {
			0x80, 0x81, 0x82, 0x84, 0x85, 0x86, 0x80, 0x81, 0x82, 0x83,
		};
		static void Main(string[] args) {
			Stopwatch timer = new Stopwatch();
			timer.Start();

			if(args.Length != 5) {
				usage();
			}
			
			try {
				comm = new Comms(File.ReadAllBytes(args[0]));
			} catch(Exception e) {
				Console.WriteLine("Could not process command file;");
				Console.Write(e);
			}

			Console.WriteLine("Loaded commands...");

			try {
				sbnk = new GEMS.Sbank(File.ReadAllBytes(args[1]));
			} catch(Exception e) {
				Console.WriteLine("Could not process sbank;");
				oops(e);
			}

			Console.WriteLine("Loaded sbank...");

			try {
				pbnk = new GEMS.Pbank(File.ReadAllBytes(args[2]));
			} catch(Exception e) {
				Console.WriteLine("Could not process pbank;");
				oops(e);
			}

			Console.WriteLine("Loaded pbank...");

			try {
				dbnk = new GEMS.Dbank(File.ReadAllBytes(args[3]));
			} catch(Exception e) {
				Console.WriteLine("Could not process dbank;");
				oops(e);
			}

			Console.WriteLine("Loaded dbank...");

			try {
				mbnk = new GEMS.Mbank(File.ReadAllBytes(args[4]));
			} catch(Exception e) {
				Console.WriteLine("Could not process mbank;");
				oops(e);
			}

			Console.WriteLine("Loaded mbank...");

			// init driver
			try {
				ccb = new GEMS.CCB[16];

				for(int i = 0;i < 16;i++) {
					ccb[i] = new GEMS.CCB();
					ccb[i].LOOP = new GEMS.CCBLOOP[4];
					ccb[i].LOOP[0] = new GEMS.CCBLOOP();
					ccb[i].LOOP[1] = new GEMS.CCBLOOP();
					ccb[i].LOOP[2] = new GEMS.CCBLOOP();
					ccb[i].LOOP[3] = new GEMS.CCBLOOP();
				}

				vtbl = new GEMS.VTBL[10];

				for(int i = 0;i < 10;i++) {
					vtbl[i] = new GEMS.VTBL();
					vtbl[i].FLAGS = vtblch[i];
					vtbl[i].NOTE = 0x50;
				}

				SAMPLE = new GEMS.Dbank.Dac();
				log = new SMPS.Logger();
				run = true;

			} catch(Exception e) {
				Console.WriteLine("Failed to init the driver;");
				oops(e);
			}

			Console.WriteLine("init succeeded...");
			Console.WriteLine("Starting GEMS emulation...");

			// main GEMS loop
			try {
				while(run) {
					// v-int happened here, since we dont output audio we may as well skip the wait time
					// making emulation way faster with fancy CPU
					vint++;
					TICKCNT = 1;
					DOSPGENV();

					TBASEFLAGS = 1;
					if(SBPTACC >> 8 != 0) {
						SBPTACC -= 0x100;
						TBASEFLAGS |= 2;
					}

					DOENVELOPE();
					VTIMER();
					UPDSEQ();
					APPLYBEND();

					if(comm.TimerExpired()) {
						Comms.Command c = comm.Next();
						switch(c.c) {
							case Comms.Cmd.tempo:
								SETTEMPO(c.a[0]);
								break;

							case Comms.Cmd.startseq:
								STARTSEQ(c.a[0]);
								break;

							case Comms.Cmd.stopseq:
								STOPSEQ(c.a[0]);
								break;

							case Comms.Cmd.stopall:
								for(int i = 0;i < ccb.Length;i++) {
									ccb[i].FLAGS = 0;
									ccb[i].DUR = 0;
								}

								CLIPALL();
								break;

							case Comms.Cmd.store:
								MBOX[c.a[0]] = c.a[1];
								break;

							case Comms.Cmd.lockch:
								ccb[c.a[0]].FLAGS |= 0x20;
								break;

							case Comms.Cmd.unlockch:
								// silly C#, can not even figure out how to do ~0x20 without the unchecked statement...
								unchecked { ccb[c.a[0]].FLAGS &= (byte)~0x20; }
								break;

							case Comms.Cmd.masteratn:
								MASTERATN = c.a[0];
								break;

							// ignore because lol
							default:
								break;
						}
					}

					bool _run = false;
					foreach(GEMS.CCB c in ccb) {
						if((c.FLAGS & 1) != 0) {
							_run = true;
						}
					}

					if(!_run)
						break;
					if(vint - 1 == 60 * 60 * 10) {
						// if exactly at 10min, then warn about emulation taking too long!
						Console.WriteLine(
							"Warning! GEMS emulation ran for 10 minutes (" + (60 * 60 * 10) + " v-ints)!\n" +
							"Automatic loop detection probably failed or something broke sound emulation.\n" +
							"It is a good idea to stop the process from running because it may never exit\n" +
							"emulation cycle! It is safe to just close the process.\n" +
							"But if you believe this is normal for the song you are trying to convert,\n" +
							"You may let it run.");
					}
				}
			} catch(Exception e) {
				oops(e);
			}

			Console.WriteLine("GEMS emulation complete in "+ (int)(vint / 60 / 60) + "m " + (int)(vint / 60 % 60) + "s " + (int)(vint % 60) + "f with "+ bytes +"B sequence read...");

			// Process SMPS

			int indx = args[1].Replace("/", "\\").LastIndexOf("\\");
			string derp = args[1].Substring(0,indx);

			if(args[2].Contains(derp) && args[3].Contains(derp) && args[4].Contains(derp)) {
				// good, we found a nice substring to work with
				for(;indx < args[2].Length;indx++) {
					derp = args[2].Substring(0, indx);

					if(!args[2].Contains(derp) || !args[3].Contains(derp) || !args[4].Contains(derp)) {
						indx--;
						break;
					}
				}

				// this is the common string between all dem args
				derp = args[1].Substring(0, indx);

				//now lets figure out how to concat the actual name
				switch(derp.ElementAt(derp.Length - 1)) {
					case '/':
					case '\\':
						goto insertname;

					case '.':
						goto insertext;
				}

				// any other letter, probably part of name, check if contains dot and possibly extension
				int d = derp.LastIndexOf('.');

				// if none, insert name
				if(d == -1) goto checkspace;

				if(d > derp.Replace("/", "\\").LastIndexOf("\\")) {
					// remove the possible extension
					derp = args[1].Substring(0, d);

					// check if filename contains space, maybe we can align to it nicely
					d = derp.LastIndexOf(' ');
					goto insertext;
				}

				// check if filename contains space, maybe we can align to it nicely
				checkspace:
				d = derp.LastIndexOf(' ');
				if(derp.Length - d < 5) {
					derp = args[1].Substring(0, d + 1);
				}

			} else {
				// lol too lazy
			}

			insertname:
			derp += "GEMS.";
			insertext:
			derp += "ASM";

			log.ToSMPS(/*derp*/@"G:\hacks\current\Sonic music hack\sound\music\Dance.asm");

			// end

			Console.WriteLine("Conversion successfully completed in " + timer.ElapsedMilliseconds + "ms!");
			Console.ReadKey();
		}

		private static void STARTSEQ(byte seq) {
			if(seq < 0 || sbnk.list.Count <= seq) {
				Console.WriteLine("Ignoring invalid seq "+ seq +"!");
				return;
			}

			if(firstseq == 0xFF) {
				firstseq = seq;

			} else if(firstseq == seq) {
				run = false;

				log.JumpEach("");
			}

			log.AddComment("STARTSEQ "+ seq);
			uint[] chd = sbnk.list.ElementAt(seq);
			int c = 0;
			for(int i = 0;i < chd.Length;i++) {
				if(chd[i] > sbnk.data.Length) {
					Console.WriteLine("Ignoring invalid ptr ("+ chd[i].ToString("X6") + ") for ch " + i + " in seq "+ seq +"!");

				} else {
					for(;c < ccb.Length;c++) {
						if((ccb[c].FLAGS & 0x21) == 0) {
							ccb[c].FLAGS = 0x11;
							ccb[c].TIMER = 0xFFFF;
							ccb[c].SNUM = seq;
							ccb[c].ADDR = chd[i];
							ccb[c].VCHAN = (byte)c;
							ccb[c].LOOP[0].COUNT = ccb[c].LOOP[1].COUNT = ccb[c].LOOP[2].COUNT = ccb[c].LOOP[3].COUNT = 0;
							ccb[c].ENV = ccb[c].PRIO = ccb[c].ATN = 0;
							ccb[c].PBEB = ccb[c].PBPB = 0;
							break;
						}
					}
				}
			}
		}

		private static void STOPSEQ(byte seq) {
			for(int i = 0;i < ccb.Length;i ++) {
				if((ccb[i].FLAGS & 0x21) == 0) {
					if(seq == 255) goto stop;
					if(seq != ccb[i].SNUM) goto nostop;

					stop:
					ccb[i].FLAGS = 0;
					ccb[i].DUR = 0;

					nostop:;
				}
			}

			CLIPALL();
		}

		private static void PAUSESEQ(byte v) {
			// TODO: Write
		}

		private static void RESUMEALL() {
			// TODO: Write
		}

		private static void SETTEMPO(byte a) {
			SBPT = (ushort)((a * 218) >> 7);
			log.Tempo(a);
		}

		// Various GEMS variables
		private static byte TICKCNT;
		private static ushort SBPTACC;
		private static byte TBASEFLAGS;
		private static ushort SBPT;
		private static byte MASTERATN;
		private static byte NEEDBEND;
		private static byte SAMPFLAGS;

		private static void DOSPGENV() {
			// TODO: Write
		}

		private static void DOENVELOPE() {
			// TODO: Write
		}

		private static void VTIMER() {
			for(int i = 0;i < vtbl.Length;i++) {
				if((vtbl[i].FLAGS & 0x8) != 0 ? (TBASEFLAGS & 0x2) != 0 : (TBASEFLAGS & 0x1) != 0) {
					if((vtbl[i].FLAGS & 0x40) != 0) {
						if(vtbl[i].RT-- == 0) {
							unchecked { vtbl[i].FLAGS &= (byte)~0x40; }
						}

					} else if((vtbl[i].FLAGS & 0x10) != 0) {
						if(vtbl[i].TIMER++ == 0) {
							unchecked { vtbl[i].FLAGS &= (byte)~0x18; }

							if((vtbl[i].FLAGS & 0x2F) != 0x26) {
								vtbl[i].FLAGS |= 0xC0;

								if(i > 6) {
									//psg

								} else {
									//fm
									// key off
								}

							} else {
								//vtnoteoffdig
							}
						}
					}
				}
			}
		}

		private static void VTANDET(ref GEMS.VTBL v, ref GEMS.CCB c, byte note, byte ch) {
			v.FLAGS = ch;
			if(c.DUR != 0) {
				v.FLAGS |= 0x10;
			}

			if((c.FLAGS & 0x08) != 0) {
				v.FLAGS |= 0x08;
			}

			v.PRIO = c.PRIO;
			v.NOTE = note;
			v.CH = ch;
			v.TIMER = c.DUR;
			v.RT = 254;

			if((c.FLAGS & 0x40) != 0) TRIGENV(c.ENV);
		}

		private static void APPLYBEND() {
			// TODO: Write
		}

		private static void UPDSEQ() {
			for(int i = 0;i < ccb.Length;i ++) {
				if((ccb[i].FLAGS & 0x10) != 0) {
					if((ccb[i].FLAGS & 0x8) != 0 ? (TBASEFLAGS & 0x2) != 0 : (TBASEFLAGS & 0x1) != 0) {
						if(i == 5) {
							int a = 0;
						}

						SEQUENCER(ref ccb[i]);
					}
				}
			}
		}

		private static void SEQUENCER(ref GEMS.CCB c) {
			if(++c.TIMER != 0) return;
			c.TIMER--;

			seqcmdloop0:
			byte d = sbnk.Seq(ref c);
			switch(d & 0xC0) {
				case 0x80:  // seqdur
					ushort dur = (ushort)(d & 0x3F);

					while(((d = sbnk.Seq(ref c)) & 0xC0) == 0x80) {
						dur <<= 6;
						dur |= (ushort)(d & 0x3F);
					}

					c.ADDR--;   // fix addr
					bytes--;
					c.DUR = (ushort)(-dur);
					goto seqcmdloop0;

				case 0xC0:  // seqdel
					ushort del = (ushort)(d & 0x3F);

					while((d = sbnk.Seq(ref c)) >= 0xC0) {
						del <<= 6;
						del |= (ushort)(d & 0x3F);
					}

					c.ADDR--;   // fix addr
					bytes--;
					c.DEL = (ushort)(-del);
					goto seqcmdloop0;

				case 0x00:case 0x40:	// seqnote
					if(d < 96) {
						if((c.FLAGS & 2) == 0) {
							NOTEON(d, ref c);
						}

						goto seqdelay;
						
					} else {
					//	Console.WriteLine(">cmd "+ d +" at " + c.ADDR.ToString("X6") +" ch "+ Array.IndexOf(ccb, c));
						// seqcmd
						switch(d) {
							case 96://seqeos
								c.FLAGS = 0;
								c.DUR = 0;
								return;

							case 97://seqpchange
								byte pchg = sbnk.Seq(ref c);
								c.PNUM = pchg;
								FETCHPATCH(pchg, ref c);
								break;

							case 98://seqenv
								byte env = sbnk.Seq(ref c);
								c.ENV = env;
								if((c.FLAGS & 0x40) == 0) {
									TRIGENV(env);
								}
								break;

							case 99://seqdelay
								break;

							case 100://seqsloop
								int sloop = 0;
								for(;sloop < 4;sloop++) {
									if(c.LOOP[sloop].COUNT == 0) {
										break;
									}
								}

								c.LOOP[sloop].COUNT = sbnk.Seq(ref c);
								c.LOOP[sloop].ADDR = c.ADDR;

								// only log this loop if its infinite, put on all chs
								if(c.LOOP[sloop].COUNT == 127)	log.StartLoop(c, sloop);
								break;

							case 101://seqeloop
								int eloop = 3;
								for(;eloop >= 0;eloop--) {
									if(c.LOOP[eloop].COUNT != 0) {
										break;
									}
								}

								if(c.LOOP[eloop].COUNT == 127){
									run = false;
									log.EndLoop(c, eloop);

								} else if(c.LOOP[eloop].COUNT-- == 0) {
									goto seqcmdloop0;
								}

								c.ADDR = c.LOOP[eloop].ADDR;
								break;

							case 102://seqretrig
								if(sbnk.Seq(ref c) == 0) {
									unchecked { c.FLAGS &= (byte)~0x40; }
								} else {
									//seqrton
									c.FLAGS |= 0x40;
								}
								break;

							case 103://seqsus
								c.FLAGS |= 0x80;
								break;

							case 104://seqtempo
								SETTEMPO((byte)(sbnk.Seq(ref c) + 40));
								break;

							case 105://seqmute
								byte mute = sbnk.Seq(ref c);
								for(int i = 0;i < ccb.Length;i++) {
									if((ccb[i].FLAGS & 1) != 0 && ccb[i].SNUM == c.SNUM && c.VCHAN == (mute & 0xF)) {
										//seqmuteit
										if((mute & 0x10) == 0) {
											c.FLAGS |= 2;

										} else {
											//sequnmute
											unchecked { c.FLAGS &= (byte)~2; }
										}
									}
								}
								break;

							case 106://seqprio
								c.PRIO = sbnk.Seq(ref c);
								break;

							case 107://seqssong
								STARTSEQ(sbnk.Seq(ref c));
								break;

							case 108://seqpbend
								c.PBPB = (ushort)(sbnk.Seq(ref c) | (sbnk.Seq(ref c) << 8));
								c.PBRETRIG |= 1;
								NEEDBEND = 1;
								break;

							case 109://seqsfx
								c.FLAGS |= 0x8;
								break;

							case 110://seqsamprate
								ccbpatsafe(ref c);
								byte samprate = sbnk.Seq(ref c);

								if((GEMS.Patch.PatchType)c.PAT[0] == GEMS.Patch.PatchType.DIG) {
									c.PAT[1] = samprate;
								}
								break;
								
							case 111://seqgoto
								uint last = c.ADDR + 2;
								c.ADDR += seqsex23((ushort)(sbnk.Seq(ref c) | (sbnk.Seq(ref c) << 8)));

								Console.WriteLine(">jump from " + last.ToString("X6") + " to " + c.ADDR.ToString("X6"));
								// SUPER FANCY LOOP DETECTION
								if(c.ADDR < last && c.ADDR > c.chstart) run = false;
								goto seqcmdloop0;

							case 112://seqstore
								MBOX[sbnk.Seq(ref c)] = sbnk.Seq(ref c);
								break;

							case 113://seqif
								byte mbx = MBOX[sbnk.Seq(ref c)], ifc = sbnk.Seq(ref c), ifv = sbnk.Seq(ref c);

								switch(ifc) {
									case 1:
										if(ifv != mbx) goto seqifdoit;
										goto seqifpunt;

									case 2:
										if(ifv > mbx) goto seqifdoit;
										goto seqifpunt;

									case 3:
										if(ifv >= mbx) goto seqifdoit;
										goto seqifpunt;

									case 4:
										if(ifv < mbx) goto seqifdoit;
										goto seqifpunt;

									case 5:
										if(ifv <= mbx) goto seqifdoit;
										goto seqifpunt;

									case 6:
										if(ifv == mbx) goto seqifdoit;
										goto seqifpunt;

									default:
										Console.WriteLine("Ignoring invalid/unknown if condition " + ifc + "! Ch " + Array.IndexOf(ccb, c) + " seq " + c.SNUM + " sbank " + (c.ADDR - 3).ToString("X6"));
										break;
								}

								seqifdoit:
								c.ADDR++;
								bytes++;
								goto seqcmdloop0;

								seqifpunt:
								c.ADDR += seqsex13(sbnk.Seq(ref c));
								goto seqcmdloop0;

							case 114://seqseekrit
								d = sbnk.Seq(ref c);
								byte v = sbnk.Seq(ref c);
								switch(d) {
									case 0://seqstopseq
										STOPSEQ(v);
										break;

									case 1://seqpauseseq
										PAUSESEQ(v);
										break;

									case 2://seqresume
										RESUMEALL();
										break;

									case 3://seqpauselmusic
										v = MBOX[0];
										goto case 1;

									case 4://seqatten
										MASTERATN = v;
										break;

									case 5://seqchatten
										c.ATN = v;
										break;

									default:
										Console.WriteLine("Ignoring invalid/unknown seq cmd 114 "+ d +"! Ch "+ Array.IndexOf(ccb, c) +" seq "+ c.SNUM +" sbank "+ (c.ADDR - 3).ToString("X6"));
										break;
								}
								break;

							default:
								Console.WriteLine("Ignoring invalid/unknown seq cmd " + d + "! Ch " + Array.IndexOf(ccb, c) + " seq " + c.SNUM + " sbank " + (c.ADDR - 1).ToString("X6"));
								break;
						}
					}
					goto seqdelay;
			}

			seqdelay:
			if(c.DEL == 0) goto seqcmdloop0;
			c.TIMER = c.DEL;
		}

		private static void NOTEON(byte note, ref GEMS.CCB c) {
			byte atn = (byte)(MASTERATN + c.ATN);
			if(atn >= 0x80) {
				atn = 127;
			}

			ccbpatsafe(ref c);
			byte ch;
			switch((GEMS.Patch.PatchType)c.PAT[0]) {
				case GEMS.Patch.PatchType.FM:
					ch = ALLOC(GEMS.Patch.PatchType.FM, ref c);

					if(ch == 0xFF) {
						return; // unable to allocate; return.
					}

					if((vtbl[ch].FLAGS & 0x80) == 0) {
						// GEMS does a noteoff here
					}

					VTANDET(ref vtbl[ch], ref c, note, ch);
					// here we have some code to log this silly shit
					log.NoteOnFM(c, GETFREQ(ref c, note), atn, ch);
					break;

				case GEMS.Patch.PatchType.DIG:
					ch = ALLOC(GEMS.Patch.PatchType.DIG, ref c);

					if(ch >= vtbl.Length) {
						return;	// unable to allocate; return.
					}

					if((vtbl[ch].FLAGS & 0x80) == 0 && (vtbl[ch].FLAGS & 0x20) == 0) {
						// GEMS does a noteoff here
					}

					VTANDET(ref vtbl[ch], ref c, note, ch);
					vtbl[ch].FLAGS |= 0x20;

					if(note >= 48){
						note -= 48;

					} else {
						note += 48;
					}

					SAMPLE = new GEMS.Dbank.Dac(dbnk.list.ElementAt(note));
					if(SAMPLE.len > 0) {
						if(c.PAT[1] != 4) {
							SAMPLE.type &= 0xF0;
							SAMPLE.type |= c.PAT[1];
						}

						// TODO: Log

					} else {
						SAMPLE = new GEMS.Dbank.Dac();
					}
					break;

				case GEMS.Patch.PatchType.PSG:
					ch = ALLOC(GEMS.Patch.PatchType.PSG, ref c);

					if(ch == 0xFF) {
						return; // unable to allocate; return.
					}

					// ignore for now :(
					break;

				case GEMS.Patch.PatchType.NOISE:
					ch = ALLOC(GEMS.Patch.PatchType.NOISE, ref c);

					if(ch == 0xFF) {
						return; // unable to allocate; return.
					}

					// ignore for now :(
					break;


				default:
					Console.WriteLine("Ignoring invalid pat type " + c.PAT[0] + " during note-on! Ch " + Array.IndexOf(ccb, c) + " seq " + c.SNUM + " sbank " + c.ADDR.ToString("X6"));
					break;
			}
		}

		private static ushort GETFREQ(ref GEMS.CCB c, byte note) {
			// AKA GEMS FUCKING
			ushort hair = (ushort)(c.PBPB + c.PBEB);
			ushort[] ball;
			byte sperm = 0;
			note += (byte)(hair >> 8);

			if(note > 96) {
				if(hair > 0x800) {
					hair &= 0xFF;
					note = 0;

				} else {
					// gftoohi
					hair |= 0xFF00;
					note = 95;
				}
			}

			ccbpatsafe(ref c);
			if((GEMS.Patch.PatchType)c.PAT[0] == GEMS.Patch.PatchType.FM) {
				if(note >= 48) { note -= 48; sperm |= 4; }
				if(note >= 24) { note -= 24; sperm |= 2; }
				if(note >= 12) { note -= 12; sperm++; }
				ball = fmftbl;

			} else {
				//gflupsg
				if(note <= 33) {
					note = 0;
					hair &= 0xFF;

				} else {
					note -= 33;
				}

				ball = psgftbl;
			}

			ushort cock = (ushort)(((ball[note + 1] - ball[note]) * (hair >> 8)) + ball[note]);

			if((GEMS.Patch.PatchType)c.PAT[0] == GEMS.Patch.PatchType.FM) {
				cock |= (ushort)(sperm << 11);
			}

			return cock;
		}

		private static ushort[] fmftbl = new ushort[] {
			644,682,723,766,811,859,910,965,1022,1083,1147,1215,1288,
		};

		private static ushort[] psgftbl = new ushort[] {
			0x03F9, 0x03C0, 0x038A,			// A2 > B2
			0x0357, 0x0327, 0x02FA, 0x02CF,	// C3 > B3
			0x02A7, 0x0281, 0x025D, 0x023B,
			0x021B, 0x01FC, 0x01E0, 0x01C5,

			0x01AC, 0x0194, 0x017D, 0x0168,	// C4 > B4
			0x0153, 0x0140, 0x012E, 0x011D,
			0x010D, 0x00FE, 0x00F0, 0x00E2,

			0x00D6, 0x00CA, 0x00BE, 0x00B4,	// C5 > B5
			0x00AA, 0x00A0, 0x0097, 0x008F,
			0x0087, 0x007F, 0x0078, 0x0071,

			0x006B, 0x0065, 0x005F, 0x005A,	// C6 > B6
			0x0055, 0x0050, 0x004C, 0x0047,
			0x0043, 0x0040, 0x003C, 0x0039,

			0x0035, 0x0032, 0x002F, 0x002D,	// C7 > B7(not very accurate!)
			0x002A, 0x0028, 0x0026, 0x0023,
			0x0021, 0x0020, 0x001E, 0x001C,

			0x001C,							// extra value for interpolation of B7
		};

		private static byte ALLOC(GEMS.Patch.PatchType p, ref GEMS.CCB c) {
			byte prio = 0xFF, lastpr = 0xFF;
			byte freest = 0xFF, lastfr = 0xFF;
			byte i = allocofftbl[(int)p];

			for(;i < alloclsttbl[(int)p];i++) {
				if((vtbl[i].FLAGS & 0x20) == 0) {
					if((vtbl[i].FLAGS & 0x80) != 0) goto avfree;
					if(vtbl[i].PRIO < prio) {
						prio = vtbl[i].PRIO;
						lastpr = i;
						goto avloop;
					}

					avfree:
					if(c.VCHAN == vtbl[i].CH && (c.FLAGS & 0x80) == 0) {
						return i;
					}

					//avdiffch
					if(vtbl[i].RT < freest) {
						freest = vtbl[i].RT;
						lastfr = i;
					}
				}

				avloop:;
			}

			// aveot
			if(freest != 0xFF) {
			//	log.Clip(lastfr, vtbl[lastfr].TIMER);
				return lastfr;
			}

			if(c.PRIO >= prio) {
			//	log.Clip(lastpr, vtbl[lastpr].TIMER);
				return lastpr;
			}

			return 0xFF;
		}

		private static byte[] allocofftbl = new byte[] { 0, 5, 6, 9 };
		private static byte[] alloclsttbl = new byte[] { 5, 1, 3, 1 };

		private static void TRIGENV(byte e) {
			// TODO: Write
		}

		private static void FETCHPATCH(byte p, ref GEMS.CCB c) {
			// we do not need to xfer data to temp buffers, so just get pat buffer ptr
			if(p > pbnk.list.Count) {
				Console.WriteLine("WARN: Ignoring illegal patch number " + p + "!\n" +
					"Ch " + Array.IndexOf(ccb, c) + " seq " + c.SNUM + " sbank " + (c.ADDR - 1).ToString("X6"));
			} else {
				c.PAT = pbnk.list.ElementAt(p).data;
			}
		}

		private static void CLIPALL() {
			// TODO: Write
		}

		private static uint seqsex23(uint a) {
			ushort _2 = (ushort)(sbnk.data[a++] | (sbnk.data[a] << 8));
			return (_2 & 0x8000) == 0 ? _2 : 0xFFFF0000 | _2;
		}

		private static uint seqsex13(uint a) {
			return ((sbnk.data[a] & 0x80) == 0 ? 0 : 0xFFFFFF00) | sbnk.data[a];
		}

		private static void ccbpatsafe(ref GEMS.CCB c) {
			if(c.PAT == null) {
				Console.WriteLine("WARN: Patch data not yet populated when it was attempted to access!\n" +
					"Ch " + Array.IndexOf(ccb, c) + " seq " + c.SNUM + " sbank " + (c.ADDR - 1).ToString("X6"));

			} else if((GEMS.Patch.PatchType)c.PAT[0] > GEMS.Patch.PatchType.NOISE) {
				Console.WriteLine("WARN: Invalid patch type found! Likely never populated correctly.\n" +
					"Ch " + Array.IndexOf(ccb, c) + " seq " + c.SNUM + " sbank " + (c.ADDR - 1).ToString("X6"));

			} else return;

			c.PAT = new byte[1];
			c.PAT[0] = 0xFF;
		}

		private static void usage(string v) {
			Console.WriteLine(v);
			usage();
		}

		private static void usage() {
			Console.Write(
				"GEMS2SMPS <cmd> <sbank> <pbank> <dbank> <mbank>\n"+
				"<cmd> is a file that will be used for running commands to GEMS driver.\n"+
				"The format is <cmd with params> <num of wait frames>.\n"+
				"If latter is 0, the next command gets ran immediately.\n"+
				"You can extend the wait time with using invalid commands\nand putting another delay after.\n"+
				"You do not need to place a delay after the last command in the file.");
			Console.ReadKey();
			Environment.Exit(0);
		}

		private static void oops(Exception e) {
			Console.WriteLine(e);
			Console.ReadKey();
			Environment.Exit(0);
		}

		private class Comms {
			private List<Command> list;
			private int timer = 0;

			public Comms(byte[] d) {
				int p = 0;
				list = new List<Command>();

				while(p < d.Length) {
					Cmd c;
					if(d[p] <= 32) {
						c = (Cmd)d[p++];

					} else {
						c = Cmd.invalid;
						p++;
					}

					byte[] a = new byte[sizes[(int)c]];
					for(int i = 0;i < a.Length;i++) {
						a[i] = d[p++];
					}

					list.Add(new Command(c, a, p < d.Length ? d[p++] : (byte)0xff));
				}
			}

			public bool TimerExpired() {
				return list.Count != 0 && timer == 0;
			}

			public Command Next() {
				Command c = list.First();

				if(c == null) {
					timer = -1;
					return null;
				}
				timer = c.d;
				list.RemoveAt(0);
				return c;
			}

			private int[] sizes = new int[] {
				2, 2, 2, 1, 3, 1, 2, 2,
				0, 0, 0,	// INVALID
				12,0, 0, 2,
				0,			// INVALID
				1,
				0,			// INVALID
				1,
				0,			// INVALID
				2,
				0,			// INVALID
				0, 3, 2, 2, 1, 1, 4, 2, 1,
			};

			public enum Cmd {
				noteon, noteoff, pchange, pupdate, pbend,
				tempo, env, retrig, getptrs = 11, pause, resume,
				sussw, startseq = 16, stopseq = 18, setprio = 20, stopall = 22,
				mute, samprate = 26, store, lockch, unlockch,
				pbendvch, volume, masteratn, invalid = 10
			}

			public class Command {
				public byte[] a { get; private set; }
				public Cmd c { get; private set; }
				internal byte d;

				public Command(Cmd cmd, byte[] args, byte delay) {
					c = cmd;
					a = args;
					d = delay;
				}
			}
		}
	}
}
