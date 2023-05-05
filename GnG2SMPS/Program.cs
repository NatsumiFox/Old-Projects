using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

/*
	Tool to convert Ghouls 'n' Ghosts music to S3K SMPS format
*/

namespace GnG2SMPS {
	class Program {
		private static int id = new Random().Next() % 100;
		// input data
		private static byte[] dat;
		// data offset
		private static int boff = 4;
		// offset of next lable
		private static ushort nxtlabl;
		private static string nxtlablname;
		private static int nextlablnum;
		// output string
		private static string o = "";
		// offsets for FM routines
		private static ushort[] ch;
		// global instrument equivalent table
		private static byte[] vcus;
		// jump counter
		private static List<Lable> jump = new List<Lable>();
		private static List<Code> lines = new List<Code>();

		// table of possible base durations
		private static byte[] durtbl = { 0, 0, 3, 6, 0x0C, 0x18, 0x30, 0x60 };
		private static byte[] durtblt = { 0, 0, 2, 4, 8, 0x10, 0x20, 0x40 };
		private static byte[] durtbld = { 0, 0, 0, 9, 0x12, 0x24, 0x48, 0x90 };

		static void Main(string[] args) {
			// if no arguments are given, exit
			if(args.Length < 1) return;
			// pick up the data of the input file
			dat = File.ReadAllBytes(args[0]);

			addLine("gng" + id + "_Header:", 0xFFFF);
			addCode("smpsHeaderStartSong", 0xFFFF);
			addCode("smpsHeaderVoice\tgng" + id + "_Voices", 0xFFFF);

			vcus = new byte[0x50];
			for(int i = 0;i < 0x50;i++) {
				vcus[i] = 0xFF;
			}

			// decipher the header
			ushort voices = readOff(0);
			byte chnum = dat[2];
			ch = new ushort[6];
			byte[] transp = new byte[6];
			byte[] mul = new byte[6];
			byte tmul = dat[5];
			byte ctransp = 0;
			float ddur = 0f;

			addCode("smpsHeaderChan\t" + hb(chnum) +", "+ hb(0), 0xFFFF);
			addCode("smpsHeaderTempo\t" + hb(1) + ", " + hb(dat[3]), 0xFFFF);
			addCode("smpsHeaderDAC\tgng" + id + "_DAC", 0xFFFF);

			// get list of all channels used
			for (int i = chnum;i >= 1;i--) {
				int y = (dat[boff + 1] & 4) == 0 ? (dat[boff + 1] & 3) + 1 : (dat[boff + 1] & 3) + 4;
				ch[y - 1] = readOff(boff + 3);
				transp[y - 1] = dat[boff + 5];
				mul[y - 1] = dat[boff + 2];
				addCode("smpsHeaderFM\tgng" + id + "_FM" + y +", "+ hb(dat[boff + 5]) + ", " + hb(dat[boff + 8]), (ushort)boff);
				boff += 9;
			}

			// add DAC channel (silly SMPS)
			addLine("gng"+ id +"_DAC:", 0xFFFF);
			addCode("smpsStop", 0xFFFF);
			boff--;
			findClosestLable();
			boff++;

			byte curtempo = 0;
			byte note = 0, dur = 0xFF, trip = 0, norel = 0;
			byte lasttype = 0;	// 00 = none, 01 = note only, 10 = dur only, 11 = both, bit2 if duration >$7F
			bool dotted = false;
			// main loop
			while(boff < voices) {
				if (boff >= nxtlabl) {
					addLine("gng" + id + "_FM" + nextlablnum + ':', 0xFFFF);
					ctransp = transp[nextlablnum - 1];
					tmul = mul[nextlablnum - 1];
					findClosestLable();

					dotted = false;
					trip = 0;
					norel = 0;
					note = 0;
					dur = 0xFF;
					ddur = 0f;
				}

				if (dat[boff] >= 0x40) {
					string c = "dc.b ", e = "";
					// new note
					byte d = durtbl[(dat[boff] & 0xE0) >> 5];

					if (dotted) {
						dotted = false;
						d = durtbld[(dat[boff] & 0xE0) >> 5];

					} else if (trip > 0) {
						trip--;
						d = durtblt[(dat[boff] & 0xE0) >> 5];
					}

					if(lasttype == 0) lasttype = 3;	// <- notattack
					ddur += (int)(d * (tmul / 2f)) & 0xFF; // cap of $FF! Duration stored as byte
					if(norel > 0) {
						norel--;
						e = ", smpsNoAttack";
						lasttype &= 4;
					}

					if(ddur == 0) ddur = 1;
					
					byte not = (byte) ((dat[boff] & 0x1F) + 0x80);
					ushort dux = (ushort) ddur, du = dux;
					ddur -= dux;
					while (dux >= 0x80) dux -= 0x7F;

					if (dur == dux && (lasttype & 4) == 0) {
						// note only
						note = not;
						addCode(c + hb(note) + e, (ushort) boff);
						if(lasttype != 0) lasttype = 1; // <- notattack

					} else if (note == not && (lasttype & 3) != 1) {
						// duration only (only if last was not note)
						int x = 0;
						while (du >= 0x80) {
							c += hb(0x7F) +", smpsNoAttack, ";
							du -= 0x7F;
							x++;

							if(x >= 6) {
								x = 0;
								addCode(c.Substring(0, c.Length - 2), (ushort)boff);
								c = "dc.b ";
							}
						}

						dur = (byte) du;
						addCode(c + hb(dur) + e, (ushort) boff);
						if(lasttype != 0) lasttype = 2; // <- notattack
						if(x != 0) lasttype |= 4;

					} else {
						// note and duration
						note = not;
						c += hb(not) + ", ";
						
						int x = 0;
						while (du >= 0x80) {
							c += hb(0x7F) + ", smpsNoAttack, ";
							du -= 0x7F;
							x++;

							if (x >= 6) {
								x = 0;
								addCode(c.Substring(0, c.Length - 2), (ushort) boff);
								c = "dc.b ";
							}
						}

						dur = (byte)du;
						addCode(c + hb(dur) + e, (ushort) boff);

						if(lasttype != 0) lasttype = 3; // <- notattack
						if(x != 0) lasttype |= 4;
					}

					boff++;

				} else if(dat[boff] >= 0x30){
					// tripled note
					trip = (byte)(dat[boff++] & 0xF);
				//	chdelay++;
				//	lpdelay++;

				} else if (dat[boff] >= 0x20){
					// no release for next notes
					norel = (byte) (dat[boff++] & 0xF);
				//	chdelay++;
				//	lpdelay++;

				} else {
					// command
					switch (dat[boff++] & 0x0F) {
						case 0:
							// tick multiplier
							tmul = dat[boff++];
							addCode("; tick mult\t" + hb(tmul), (ushort) (boff - 2));
						//	boff++;
							break;

						case 1:
							// nop
							boff++;
							break;

						case 2:
							// change tempo
							curtempo += dat[boff++];
							addCode("smpsSetTempoMod\t" + hb(curtempo), (ushort) (boff - 2));
							break;

						case 3:
							// loop index 0
							loop(0);
							break;

						case 4:
							// loop index 1
							loop(1);
							break;

						case 5:
							// loop index 2
							loop(2);
							break;

						case 6:
							// dotted note (1.5x duration)
							dotted = true;
							break;

						case 7:
							// set transpose
							byte t = ctransp;
							ctransp = dat[boff++];
							addCode("smpsAlterPitch\t"+ hb((byte)(ctransp - t)), (ushort) (boff - 2));
							break;

						case 8:
							// pitch slide
							boff++;
							break;

						case 9:
							// disable pitch slide
							break;

						case 10:
							// set pan
							switch (dat[boff++]) {
								case 0:
									addCode("smpsPan\tpanNone, "+ hb(0), (ushort) (boff - 2));
									break;

								case 1:
									addCode("smpsPan\tpanRight, " + hb(0), (ushort) (boff - 2));
									break;

								case 2:
									addCode("smpsPan\tpanLeft, " + hb(0), (ushort) (boff - 2));
									break;

								case 3:
									addCode("smpsPan\tpanCentre, " + hb(0), (ushort) (boff - 2));
									break;
							}
							break;

						case 11:
							// set LFO speed
							boff++;
							break;

						case 12:
							// set instrument
							addCode("smpsSetvoice\t" + hb(findins(dat[boff++])), (ushort)(boff - 2));
							break;

						case 13:
							// set volume
							addCode("smpsSetVol\t" + hb((-dat[boff++]) & 0x7F), (ushort) (boff - 2));
							break;

						case 14:
							// set LFO amplitude vibrato
							boff++;
							break;

						case 15:
							// stop track
							addCode("smpsStop", (ushort) (boff - 1));
							break;
					}
				}
			}

			// build output file
			nextoutlable(0);
			for (int i = 0;i < lines.Count;i++) {
				dolable2(lines.ElementAt(i).off);
				o += lines.ElementAt(i).data +"\r\n";
			}

			o += "gng" + id + "_Voices:\r\n";
			for (int i = 0;i < 0x50;i++) {
				int w = -1;
				for (int q = 0;q < 0x50;q++) {
					if(i == vcus[q]) {
						w =	q;
					}
				}

				if(w == -1) break;
				int e = voices + (25 * w) - 1;
				o += "\t; Voice "+ hb(w) + "\r\n\tdc.b ";
				for(int q = 1;q < 25;q++) {
					o += hb(dat[e + q]) + ", ";
				}

				o += hb(dat[e + 24]) + "\r\n";
			}
			// flush
			File.WriteAllText(args[0] + ".asm", o);
		}

		private static void nextoutlable(int v) {
			nxtlabl = 0xFFFF;
			foreach (Lable l in jump) {
				if (l.off < nxtlabl && l.off > v) {
					nxtlabl = l.off;
					nxtlablname = l.name;
				}
			}
		}

		private static void dolable2(int v) {
			if (nxtlabl != 0xFFFF && v != 0xFFFF && v >= nxtlabl) {
				o += nxtlablname + ":\r\n";
				nextoutlable(v);
			}
		}

		private static void findClosestLable() {
			nxtlabl = 0xFFFF;
			for (int i = 0;i < 6;i++) {
				if (ch[i] < nxtlabl && ch[i] > boff) {
					nxtlabl = ch[i];
					nextlablnum = (i + 1);
				}
			}
		}

		private static void loop(int v) {
			string t = findjump((ushort)(boff + 1));
			if (dat[boff] == 0) {
				addCode("smpsJump\t" + t, (ushort)(boff -1));
				boff++;

			} else {
				addCode("smpsLoop\t"+ hb(v) +", " + hb(dat[boff++] + 1) + ", " + t, (ushort) (boff - 1));
			}

			boff += 2;
			findClosestLable();
		}

		private static string findjump(ushort v) {
			ushort f = readOff(v);
			foreach (Lable l in jump) {
				if(l.off == f) {
					return l.name;
				}
			}

			for(int i = 0;i < 6;i++) {
				if(ch[i] == v) {
					return "gng" + id + "_FM" + (i + 1);
				}
			}

			string r = "gng" + id + "_" + jump.Count;
			jump.Add(new Lable { off = f, name = r });
			return r;
		}

		private static int findins(byte v) {
			if(vcus[v] == 0xFF) {
				byte r = 0;

				for (int i = 0;i < 0x50;i++) {
					if(vcus[i] != 0xFF && vcus[i] >= r) {
						r = (byte)(vcus[i] + 1);
					}
				}

				vcus[v] = r;
				return r;
			}

			return vcus[v];
		}

		// read a word from offset
		private static ushort readWord(int boff) {
			return (ushort) (dat[boff] | (dat[boff + 1] << 8));
		}

		// read an offset from offset
		private static ushort readOff(int boff) {
			return (ushort) (readWord(boff) & 0x7FFF);
		}

		private static void addCode(string v, ushort o) {
			lines.Add(new Code {off = o, data = "\t" + v });
		}

		private static void addLine(string v, ushort o) {
			lines.Add(new Code { off = o, data = v });
		}

		private static string hb(int n) {
			return "$" + toHexString(n, 2);
		}

		private static string hw(int n) {
			return "$" + toHexString(n, 4);
		}

		private static string toHexString(long res, int zeroes) {
			return string.Format("{0:x" + zeroes + "}", res).ToUpper();
		}
	}

	internal class Code {
		public ushort off { get; set; }
		public string data { get; set; }
	}

	public struct Lable {
		public ushort off { get; set; }
		public string name { get; set; }
	}
}
