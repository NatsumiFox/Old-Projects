using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GEMS2SMPS {
	class SMPS {
		public class Logger {
			internal static Logger __logger;

			public Logger() {
				FM1 = new Channel("FM1");
				FM2 = new Channel("FM2");
				FM3 = new Channel("FM3");
				FM4 = new Channel("FM4");
				FM5 = new Channel("FM5");
				DAC1 = new Channel("DAC1", new Event[] { new CommEvent(Comms.sStop) });
				DAC2 = new Channel("DAC2", new Event[] { new CommEvent(Comms.sStop) });

				chlist = new Channel[] { FM1, FM2, FM3, FM4, FM5, DAC1, DAC2 };
				pats = new List<Patch>();
				__logger = this;
			}

			internal static Channel GetCh(byte ch) {
				return __logger.chlist[ch];
			}

			// This method clips the timer of any overridden channel,
			// by substracting the leftover timer of overridden channel
			internal void Clip(byte ch, ushort by) {
				return;
				List<StackObj> ass = GetCh(ch).stack.First.Value;

				for(int i = ass.Count - 1;i >= 0;i--) {
					Note n = (ass.ElementAt(i) as Note);
					if(n != null) {
						if(n.freq != 0xFFFF) {
							n.delay += by;

							if(n.delay == 0) {
								ass.Remove(n);
							}
						}
						return;
					}
				}
			}

			internal Channel FM1, FM2, FM3, FM4, FM5, DAC1, DAC2, PSG1, PSG2, PSG3;
			private List<Patch> pats;

			internal class Channel : StackObj {
				internal LinkedList<List<StackObj>> stack;
				internal string loopp;

				internal Channel(string name) : base() {
					stack = new LinkedList<List<StackObj>>();
					stack.AddFirst(list);
					InsertLable("__GEMS_" + name, 0);
				}

				private void InsertLable(string l, uint a) {
					stack.First.Value.Add(new Lable(l, a));
				}

				internal Channel(string name, Event[] e) : this(name) {
					list.AddRange(e);
				}

				public bool AddStack(List<StackObj> l) {
					stack.AddFirst(l);
					return true;
				}

				public bool RmvStack() {
					stack.RemoveFirst();
					return true;
				}
			}

			public class StackObj {
				public List<StackObj> list;
				public StackObj parent;
				internal uint addr;
				internal int vint;

				public StackObj() {
					list = new List<StackObj>();
					vint = Program.vint;
				}

				public bool AddStack(List<StackObj> l) {
					return parent.AddStack(l);
				}

				public bool RmvStack() {
					return parent.RmvStack();
				}
			}

			internal class Event : StackObj {
				public Event() : base() { }
			}

			private class Comment : Event {
				public string data;

				public Comment(string v) : base() {
					data = "; "+ v;
				}
			}

			internal class Lable : Event {
				internal string name;

				public Lable(string l, uint a) : base() {
					name = l;
					addr = a;
				}
			}

			internal class CommEvent : Event {
				internal Comms comm;
				internal byte[] args;
				internal string ptr;

				public CommEvent(Comms c, params byte[] arg) : this(c) {
					args = arg;
				}

				internal CommEvent(Comms c) {
					comm = c;
					args = new byte[0];

					if(c == Comms.sRet) RmvStack();
				}

				public CommEvent(Comms c, string p, params byte[] arg) : this(c, arg) {
					ptr = p;
				}

				public bool hasJump() {
					return ptr != null;
				}
			}

			internal class CommStackEvent : Event {
				private Comms comm;

				internal CommStackEvent(Comms c, StackObj p) : base() {
					comm = c;
					parent = p;

					if(c == Comms.sRet) RmvStack();
				}
			}

			internal class Note : Event {
				internal ushort freq;
				internal ushort delay;

				public Note(ushort f, ushort d) : base() {
					freq = f;
					delay = d;
				}
			}

			internal enum Comms {
				sPan = 0xE0, saDetune, ssTranspose, saTranspose, sNoteTimeOut,
				ssTickMulCh, ssTickMul, saTempo, ssTempo, sVoice, sModOn, sModOff,
				saVol, ssVol, ssLFO, ssMod, ssFreq, ssModFreq, sNoisePSG,
				sCont, sStop, sJump, sLoop, sCall, sRet, sComm, sCond,
				sCondOff, sPlayMus, sCmdYM, sMeta,
			}

			internal void NoteOnFM(GEMS.CCB c, ushort freq, byte vol, byte ch) {
				byte pat = GetPatch(c);
				Channel chp = GetCh(ch);

				Note n = new Note(freq, (ushort)-c.DUR) { addr = c.ADDR };
				n.list.Add(new CommEvent(Comms.sVoice, pat) { addr = c.ADDR });
				n.list.Add(new CommEvent(Comms.ssVol, vol) { addr = c.ADDR });

				Patch xxx = pats.ElementAt(pat);
				if(xxx.haslfo()) {
					n.list.Add(new CommEvent(Comms.ssLFO, xxx.lfodata, xxx.lfo) { addr = c.ADDR });

				} else {
					n.list.Add(new CommEvent(Comms.sPan, xxx.lfo) { addr = c.ADDR });
				}

				if(chp.loopp != null) GetCh(ch).stack.First.Value.Add(new Lable(chp.loopp, 0));
				chp.loopp = null;
				GetCh(ch).stack.First.Value.Add(n);
			}

			private byte GetNoteFM(ushort freq) {
				int diff = 0xFFFF;
				byte note = 0x80;
				for(byte i = 0;i < FreqFM.Length;i++) {
					int x = Math.Abs(FreqFM[i] - freq);
					if (x < diff) {
						diff = x;
						note = (byte)(i + 0x81);
					}
				}

				// no note is close match; return
				return note;
			}

			public int[] FreqFM = new int[] {
				0x0284,0x02AB,0x02D3,0x02FE,0x032D,0x035C,0x038F,0x03C5,0x03FF,0x043C,0x047C,0x0A5E,
				0x0A84,0x0AAB,0x0AD3,0x0AFE,0x0B2D,0x0B5C,0x0B8F,0x0BC5,0x0BFF,0x0C3C,0x0C7C,0x125E,
				0x1284,0x12AB,0x12D3,0x12FE,0x132D,0x135C,0x138F,0x13C5,0x13FF,0x143C,0x147C,0x1A5E,
				0x1A84,0x1AAB,0x1AD3,0x1AFE,0x1B2D,0x1B5C,0x1B8F,0x1BC5,0x1BFF,0x1C3C,0x1C7C,0x225E,
				0x2284,0x22AB,0x22D3,0x22FE,0x232D,0x235C,0x238F,0x23C5,0x23FF,0x243C,0x247C,0x2A5E,
				0x2A84,0x2AAB,0x2AD3,0x2AFE,0x2B2D,0x2B5C,0x2B8F,0x2BC5,0x2BFF,0x2C3C,0x2C7C,0x325E,
				0x3284,0x32AB,0x32D3,0x32FE,0x332D,0x335C,0x338F,0x33C5,0x33FF,0x343C,0x347C,0x3A5E,
				0x3A84,0x3AAB,0x3AD3,0x3AFE,0x3B2D,0x3B5C,0x3B8F,0x3BC5,0x3BFF,0x3C3C,0x3C7C,
			};

			private byte GetPatch(GEMS.CCB c) {
				byte id = 0;
				foreach(Patch p in pats) {
					if(c.PNUM == p.PNUM) {
						return id;
					}

					id++;
				}

				byte[] pat = new byte[25];
				pat[0] = c.PAT[3];

				int po = 1;
				foreach(int off in patcvttbl) {
					pat[po++] = c.PAT[off];
					pat[po++] = c.PAT[off + 6];
					pat[po++] = c.PAT[off + 12];
					pat[po++] = c.PAT[off + 18];
				}

				pat[po++] = (byte)(/*127 - */c.PAT[6]);
				pat[po++] = (byte)(/*127 - */c.PAT[0xC]);
				pat[po++] = (byte)(/*127 - */c.PAT[0x12]);
				pat[po++] = (byte)(/*127 - */c.PAT[0x18]);
				
				pats.Add(new Patch(c.PNUM, c.PAT[1], c.PAT[4], pat));
				return id;
			}

			private readonly int[] patcvttbl = new int[] {
				5, 7, 8, 9, 10,
			};

			private class Patch {
				internal byte PNUM, lfo, lfodata;
				internal byte[] patch;

				public Patch(byte p, byte ld, byte l, byte[] pat) {
					PNUM = p;
					lfodata = ld;
					lfo = l;
					patch = pat;
				}

				public bool haslfo() {
					return (lfodata & 0x08) == 0;
				}
			}

			internal void Tempo(byte tempo) {
				// todo: convert
				FM1.stack.First.Value.Add(new CommEvent(Comms.ssTempo, (byte)(0x100 - (0x100 * 24) * tempo / 3600)));
			}

			// if eloop set, final loop is found and no more loops are considered
			private bool sloop, eloop;
			internal void StartLoop(GEMS.CCB c, int loop) {
				if(!sloop) {
					for(int i = 0;i < chlist.Length;i++) {
						chlist[i].loopp = "__GEMS_"+ chname[i] +"_MainLoop";
					}
				}

				sloop = true;
			}

			private Channel[] chlist;
			private string[] chname = new string[] {
				"FM1","FM2","FM3","FM4","FM5","DAC1","DAC2",
			};

			internal void EndLoop(GEMS.CCB c, int loop) {
				if(!eloop) {
					for(int i = 0;i < chlist.Length;i++) {
						if(chlist[i].loopp == null)
							chlist[i].stack.First.Value.Add(new CommEvent(Comms.sJump, "__GEMS_" + chname[i] + "_MainLoop"));
					}
				}

				eloop = true;
			}

			internal void JumpEach(string v) {
				for(int i = 0;i < chlist.Length;i++) {
					if(chlist[i].loopp == null)
						chlist[i].stack.First.Value.Add(new CommEvent(Comms.sJump, "__GEMS_" + chname[i] + v));
				}
			}

			internal void AddComment(string v) {
				for (int i = 0;i < chlist.Length;i++) {
					chlist[i].stack.First.Value.Add(new Comment(v));
				}
			}

			// final method that converts music to smps
			internal void ToSMPS(string derp) {
				Console.WriteLine(">'" + derp + "'");
				FileStream toilet = new FileStream(derp, FileMode.Create);
				byte[] shit = Encoding.ASCII.GetBytes("__GEMS_Header:\n" +
					"\tsHeaderInit\n" +
					"\tsHeaderTempo\t$81, $00\n" +
					"\tsHeaderCh\t$05, $00\n" +
					"\tsHeaderDAC\t__GEMS_DAC1\n" +
					"\tsHeaderDAC\t__GEMS_DAC2\n" +
					"\tsHeaderDAC\t__GEMS_FM1, $00, $00\n" +
					"\tsHeaderDAC\t__GEMS_FM2, $00, $00\n" +
					"\tsHeaderDAC\t__GEMS_FM3, $00, $00\n" +
					"\tsHeaderDAC\t__GEMS_FM4, $00, $00\n" +
					"\tsHeaderDAC\t__GEMS_FM5, $00, $00\n");
				toilet.Write(shit, 0, shit.Length);

				int pid = 0;
				foreach(Patch p in pats) {
					shit = Encoding.ASCII.GetBytes("\n\t; Patch " + hex(pid, 2) + '\n' +
						"\t; " + hex(p.patch[0], 2) + '\n' +
						"\t; " + hex(p.patch[1], 2) + ", " + hex(p.patch[2], 2) + ", " + hex(p.patch[3], 2) + ", " + hex(p.patch[4], 2) + ",\t" + hex(p.patch[5], 2) + ", " + hex(p.patch[6], 2) + ", " + hex(p.patch[7], 2) + ", " + hex(p.patch[8], 2) + '\n' +
						"\t; " + hex(p.patch[9], 2) + ", " + hex(p.patch[10], 2) + ", " + hex(p.patch[11], 2) + ", " + hex(p.patch[12], 2) + ",\t" + hex(p.patch[13], 2) + ", " + hex(p.patch[14], 2) + ", " + hex(p.patch[15], 2) + ", " + hex(p.patch[16], 2) + '\n' +
						"\t; " + hex(p.patch[17], 2) + ", " + hex(p.patch[18], 2) + ", " + hex(p.patch[19], 2) + ", " + hex(p.patch[20], 2) + ",\t" + hex(p.patch[21], 2) + ", " + hex(p.patch[22], 2) + ", " + hex(p.patch[23], 2) + ", " + hex(p.patch[24], 2) + '\n' +

						// basically carbon copy of SMPS2ASM except in ugly ass C# code which hopefully is faster than SMPS2ASM
						"\tspAlgorithm\t" + hex(p.patch[0] & 0x07, 2) + '\n' +
						"\tspFeedback\t" + hex((p.patch[0] & 0x38) >> 3, 2) + '\n' +
						"\tspDetune\t" + hex((p.patch[1] & 0xF0) >> 4, 2) + ", " + hex((p.patch[3] & 0xF0) >> 4, 2) + ", " + hex((p.patch[2] & 0xF0) >> 4, 2) + ", " + hex((p.patch[4] & 0xF0) >> 4, 2) + '\n' +
						"\tspMultiple\t" + hex(p.patch[1] & 0x0F, 2) + ", " + hex(p.patch[3] & 0x0F, 2) + ", " + hex(p.patch[2] & 0x0F, 2) + ", " + hex(p.patch[4] & 0x0F, 2) + '\n' +
						"\tspRateScale\t" + hex((p.patch[5] & 0xC0) >> 6, 2) + ", " + hex((p.patch[7] & 0xC0) >> 6, 2) + ", " + hex((p.patch[6] & 0xC0) >> 6, 2) + ", " + hex((p.patch[8] & 0xC0) >> 6, 2) + '\n' +
						"\tspAttackRt\t" + hex(p.patch[5] & 0x1F, 2) + ", " + hex(p.patch[7] & 0x1F, 2) + ", " + hex(p.patch[6] & 0x1F, 2) + ", " + hex(p.patch[8] & 0x1F, 2) + '\n' +
						"\tspAmpMod\t" + hex((p.patch[9] & 0x80) >> 7, 2) + ", " + hex((p.patch[11] & 0x80) >> 7, 2) + ", " + hex((p.patch[10] & 0x80) >> 7, 2) + ", " + hex((p.patch[12] & 0x80) >> 7, 2) + '\n' +
						"\tspDecayRt\t" + hex(p.patch[9] & 0x1F, 2) + ", " + hex(p.patch[11] & 0x1F, 2) + ", " + hex(p.patch[10] & 0x1F, 2) + ", " + hex(p.patch[12] & 0x1F, 2) + '\n' +
						"\tspSustainRt\t" + hex(p.patch[13], 2) + ", " + hex(p.patch[15], 2) + ", " + hex(p.patch[14], 2) + ", " + hex(p.patch[16], 2) + '\n' +
						"\tspSustainLv\t" + hex((p.patch[17] & 0xF0) >> 4, 2) + ", " + hex((p.patch[19] & 0xF0) >> 4, 2) + ", " + hex((p.patch[18] & 0xF0) >> 4, 2) + ", " + hex((p.patch[20] & 0xF0) >> 4, 2) + '\n' +
						"\tspTotalLv\t" + hex(p.patch[21] & 0x7F, 2) + ", " + hex(p.patch[23] & 0x7F, 2) + ", " + hex(p.patch[22] & 0x7F, 2) + ", " + hex(p.patch[24] & 0x7F, 2) + '\n');
					toilet.Write(shit, 0, shit.Length);
					pid++;
				}

				shit = Encoding.ASCII.GetBytes("\n__GEMS_DAC2:\n\tsStop\n\n");

				for(int i = 0;i < chlist.Length;i++) {
					GEMS.Patch.PatchType pt = GEMS.Patch.PatchType.FM;
					if(i == 6) pt = GEMS.Patch.PatchType.DIG;
					else if(i == 10) pt = GEMS.Patch.PatchType.NOISE;
					else if(i > 6) pt = GEMS.Patch.PatchType.PSG;

					len = 0;
					done = false;
					nam = chname[i];
					toSMPS(chlist[i].list, toilet, new Status(), pt, null);
					Console.WriteLine(nam + " " + len + " " + las);
				}

				toilet.Flush();
			}

			string nam = null;
			int len = 0, las = 0, c = 0;
			bool done = false;
			private void toSMPS(List<StackObj> list, FileStream toilet, Status piss, GEMS.Patch.PatchType pt, Event last) {
				foreach(Event e in list) {
					if(len == 2304) {
						int a = 0;
					}

					if (last as Note != null) {
						done = true;
						Note l = last as Note;
						if (e.vint - l.vint > 0)
							if (l.delay + l.vint > e.vint) {
								DoNote(l, toilet, piss, pt, e.vint - l.vint);

							} else if (l.delay + l.vint < e.vint) {
								DoNote(l, toilet, piss, pt, l.delay);
								DoNote(new Note(0xFFFF, 0), toilet, piss, pt, e.vint - (l.delay + l.vint));

							} else {
								DoNote(l, toilet, piss, pt, l.delay);
							}
					} else if (!done && 0 < e.vint) {
						DoNote(new Note(0xFFFF, 0), toilet, piss, pt, e.vint);
						done = true;
					}

					las = e.vint;
					if ((e as CommEvent) != null) {
						CmdSMPS(e as CommEvent, toilet, piss, pt);

					} else if ((e as CommStackEvent) != null) {
						CmdSMPS(e as CommEvent, toilet, piss, pt);
						CommStackEvent a = e as CommStackEvent;
						toSMPS(e.list, toilet, piss, pt, last);

					} else if ((e as Lable) != null) {
						byte[] shit = Encoding.ASCII.GetBytes('\n' + (e as Lable).name + ":\n");
						toilet.Write(shit, 0, shit.Length);

					} else if ((e as Comment) != null) {
						byte[] d = Encoding.ASCII.GetBytes((e as Comment).data + "\n");
						toilet.Write(d, 0, d.Length);
					}

					last = e;
				}
				
		//		Console.WriteLine(nam + " " + len + " " + las);
				if (c++ > 50) {
					c = 0;
				}
			}

			private void DoNote(Note s, FileStream toilet, Status piss, GEMS.Patch.PatchType pt, int del) {
				toSMPS(s.list, toilet, piss, pt, null);
				len += del;

				byte not = (s.freq == 0xFFFF) ? (byte)0x80 : GetNoteFM(s.freq);

				bool note = not == piss.note || not == 0, delay = false;
				if (del < 0x80) {
					delay = del == piss.dur;
				}

				string o = not == 0 ? "\tssFreq\t" + hex(s.freq, 4) + "\n\tdc.b nRst, " : "\tdc.b ";

				if (!note) {
					piss.note = not;
					o += NoteName[not & 0x7F] + ", ";
				}

				if (!delay || note) {
					int ddd = del;

					while (ddd > 0x7F) {
						o += "$7F, sHold, ";
						ddd -= 0x7F;
					}

					piss.dur = (byte)ddd;

					if (ddd == 0 && o.Contains("sHold")) {
						o = o.Substring(0, o.Length - ("sHold, ").Length);

					} else {
						o += hex(ddd, 2) + ", ";
					}
				}
				
				// remove ', '
				o = o.Substring(0, o.Length - 2);
				o += '\n';
				byte[] ob = Encoding.ASCII.GetBytes(o);
				toilet.Write(ob, 0, ob.Length);
			}

			internal string[] NoteName = new string[] {
				"nRst",
				"nC0","nCs0","nD0","nEb0","nE0","nF0","nFs0","nG0","nAb0","nA0","nBb0","nB0",
				"nC1","nCs1","nD1","nEb1","nE1","nF1","nFs1","nG1","nAb1","nA1","nBb1","nB1",
				"nC2","nCs2","nD2","nEb2","nE2","nF2","nFs2","nG2","nAb2","nA2","nBb2","nB2",
				"nC3","nCs3","nD3","nEb3","nE3","nF3","nFs3","nG3","nAb3","nA3","nBb3","nB3",
				"nC4","nCs4","nD4","nEb4","nE4","nF4","nFs4","nG4","nAb4","nA4","nBb4","nB4",
				"nC5","nCs5","nD5","nEb5","nE5","nF5","nFs5","nG5","nAb5","nA5","nBb5","nB5",
				"nC6","nCs6","nD6","nEb6","nE6","nF6","nFs6","nG6","nAb6","nA6","nBb6","nB6",
				"nC7","nCs7","nD7","nEb7","nE7","nF7","nFs7","nG7","nAb7","nA7","nBb7"
			};

			private void CmdSMPS(CommEvent e, FileStream toilet, Status piss, GEMS.Patch.PatchType pt) {
				string shit = "";

				switch(e.comm) {
					case Comms.ssTempo:
						if(piss.tempo != e.args[0]) {
							piss.tempo = e.args[0];
							shit = "\tssTempo\t" + hex(piss.tempo, 2) +"\n";
						}
						break;

					case Comms.sVoice:
						if(piss.voice != e.args[0]) {
							piss.voice = e.args[0];
							shit = "\tsVoice\t" + hex(piss.voice, 2) + "\n";
						}
						break;

					case Comms.ssVol:
						if(piss.vol != e.args[0]) {
							piss.vol = e.args[0];
							shit = "\tssVol\t" + hex(piss.vol, 2) + "\n";
						}
						break;

					case Comms.sPan:
						if(piss.pan != e.args[0]) {
							piss.pan = e.args[0];
							shit = "\tsPan\t" + hex(piss.pan, 2) + "\n";
						}
						break;

					case Comms.ssLFO:
						if(piss.pan != e.args[0] || piss.lfo != e.args[1]) {
							piss.pan = e.args[0];
							piss.lfo = e.args[1];
							shit = "\tssLFO\t" + hex(piss.pan, 2) +", "+ hex(piss.lfo, 2) + "\n";
						}
						break;

					case Comms.sJump:
						shit = "\tsJump\t" + e.ptr + "\n";
						break;

					case Comms.sStop:
						shit = "\tsStop\n";
						break;
				}

				if(shit.Length > 0) {
					byte[] fart = Encoding.ASCII.GetBytes(shit);
					toilet.Write(fart, 0, fart.Length);
				}
			}

			private string hex(int i, int num) {
				return '$'+ i.ToString("X" + num);
			}

			internal class Status {
				internal byte vol, note, dur, tempo, voice, pan, lfo;

				public Status() {
					vol = 0xFF;
					note = 0xFF;
					dur = 0xFF;
					tempo = 0xFF;
					voice = 0xFF;
					pan = 0x00;
					lfo = 0xFF;
				}
			}
		}
	}
}
