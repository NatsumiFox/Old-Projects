using System;
using System.Collections.Generic;
using System.Linq;

namespace GEMS2SMPS {
	class GEMS {
		unsafe public struct CCB {
			public uint ADDR, chstart;
			public byte FLAGS, SNUM, VCHAN, PRIO, ENV, ATN, PNUM, y, PBRETRIG;
			public ushort DEL, DUR, TIMER, PBPB, PBEB;
			public CCBLOOP[] LOOP;
			public byte[] PAT;
		}

		unsafe public struct CCBLOOP {
			public uint ADDR;
			public byte COUNT;
		}

		internal class VTBL {
			public byte FLAGS, PRIO, NOTE, CH, RT;
			internal ushort TIMER;
		}

		private static void BankGeneric(byte[] d, Action<byte[], uint, int> code) {
			ushort boff = 0, last = 0xFFFF, id = 0;

			while(boff < last) {
				ushort x = (ushort)((d[boff++]) | (d[boff++] << 8));

				if(x < last && x >= boff) {
					last = x;
				}

				code(d, x, id++);
			}
		}

		internal static ushort w(byte[] d, uint boff) {
			return (ushort)((d[boff++]) | (d[boff++] << 8));
		}

		internal class Sbank {
			public List<uint[]> list { get; private set; }
			public byte[] data { get; private set; }

			private List<uint> seq;

			public Sbank(byte[] d) {
				list = new List<uint[]>();
				seq = new List<uint>();

				BankGeneric(d, GetSeq);
				seq.Sort();

				bool off3 = false;
				for(int i = 0;i < seq.Count - 1;i++) {
					int c = d[seq.ElementAt(i)];

					if(c > 1) {
						uint len = seq.ElementAt(i + 1) - seq.ElementAt(i) - 1;

						if(((double)len / c) == 2) {
							off3 = false;
							goto found;

						} else if(((double)len / c) == 3){
							off3 = true;
							goto found;
						}
					}
				}

				throw new Exception("failed to resolve a valid size for ch pointers! Can not continue!");

				found:
				for(int i = 0;i < seq.Count;i++) {
					List<uint> a = new List<uint>();
					uint boff = seq.ElementAt(i);
					byte ct = d[boff++];

					while(ct-->0) {
						if(off3) {
							a.Add((uint)((d[boff++]) | (d[boff++] << 8) | (d[boff++] << 16)));

						} else {
							a.Add(w(d, boff));
							boff += 2;
						}
					}

					list.Add(a.ToArray());
				}

				data = d;
				seq = null;
			}

			private void GetSeq(byte[] d, uint pos, int id) {
				seq.Add(pos);
			}

			public byte Seq(ref CCB c) {
				uint addr = c.ADDR++;
				Program.bytes++;

				if(addr >= data.Length) {
					throw new Exception("ccb failure! Requested byte at address " + addr.ToString("X6") + " does not exist! Can not recover.");
				}

				return data[addr];
			}
		}

		internal class Pbank {
			public List<Patch> list { get; private set; }

			public Pbank(byte[] d) {
				list = new List<Patch>();
				BankGeneric(d, GetPat);
			}

			public void GetPat(byte[] d, uint pos, int id) {
				Patch p = new Patch(d[pos++]);
				
				for(int i = 1;i < p.data.Count();i++) {
					p.data[i] = d[pos++];
				}

				list.Add(p);
			}
		}

		internal class Dbank {
			private byte[] data;
			public List<Dac> list { get; private set; }

			public Dbank(byte[] d) {
				list = new List<Dac>();
				uint boff = 0, last = 0xFFFF;

				while(boff < last) {
					boff++;	// SKIP TYPE
					uint x = (uint)((d[boff++]) | (d[boff++] << 8) | (d[boff++] << 16));

					if(x < last && x > boff) {
						last = x;
					}

					list.Add(new Dac(x, w(d, boff), w(d, boff + 2), w(d, boff + 4), w(d, boff + 6), d[boff - 4]));
					boff += 8;
				}

				data = d;
			}

			public class Dac {
				public ushort skip, len, loop, end;
				public byte type;
				public uint off;

				public Dac(uint o, ushort s, ushort le, ushort lo, ushort e, byte t) {
					type = t;
					off = o;
					skip = s;
					len = le;
					loop = lo;
					end = e;
				}

				public Dac(Dac d) {
					type = d.type;
					off = d.off;
					skip = d.skip;
					len = d.len;
					loop = d.loop;
					end = d.end;
				}

				public Dac() { }
			}
		}

		internal class Mbank {
			public List<Env> list { get; private set; }

			public Mbank(byte[] d) {
				list = new List<Env>();
				BankGeneric(d, GetEnv);
			}

			private void GetEnv(byte[] d, uint pos, int id) {
				Env e = new Env((ushort)((d[pos++]) | (d[pos++] << 8)));
				List<EnvDat> en = new List<EnvDat>();

				while(d[pos] != 0) {
					EnvDat env = new EnvDat(d[pos++], (ushort)((d[pos++]) | (d[pos++] << 8)));
				}

				e.list = en.ToArray();
				list.Add(e);
			}


			/* ENVELOPE FORMAT
				0-1 initial frequency 

				>0 timer
				>1-2 new delta

				if timer is 0, end
				 */
			public class Env {
				public EnvDat[] list { get; internal set; }
				public ushort bend { get; private set; }

				public Env(ushort v) {
					bend = v;
				}
			}

			public class EnvDat {
				private byte timer;
				private ushort delta;

				public EnvDat(byte t, ushort d) {
					timer = t;
					delta = d;
				}
			}
		}

		public class Patch {
			public byte[] data { get; private set; }
			public PatchType type { get; private set; }

			public Patch(byte t) {
				data = new byte[sizes[t] + 1];
				data[0] = t;
			}

			/* FM FORMAT:
				00 - type (FM = 00)
				01 - LFO data
				02 - CH3 mode bits? bit6 -> CH3 mode?
				03 - feedback+algorithm
				04 - PAN+AMS+FMS

				05 - op1 detune+multiply
				06 - op1 TL
				07 - op1 rate scale+attack rate
				08 - op1 am+decay rate 1
				09 - op1 sustan decay rate (decay rate 2)
				0A - op1 sustain level+release rate

				0B - op3 detune+multiply
				0C - op3 TL
				0D - op3 rate scale+attack rate
				0E - op3 am+decay rate 1
				0F - op3 sustan decay rate (decay rate 2)
				10 - op3 sustain level+release rate

				11 - op2 detune+multiply
				12 - op2 TL
				13 - op2 rate scale+attack rate
				14 - op2 am+decay rate 1
				15 - op2 sustan decay rate (decay rate 2)
				16 - op2 sustain level+release rate

				17 - op4 detune+multiply
				18 - op4 TL
				19 - op4 rate scale+attack rate
				1A - op4 am+decay rate 1
				1B - op4 sustan decay rate (decay rate 2)
				1C - op4 sustain level+release rate

				1D-24 - CH3 frequency
				25 - FM operator key on mask
			*/

			/* DIG FORMAT:
				00 - type (DIG = 01)
				01 - sample rate
			*/

			/* PSG+NOISE FORMAT:
				00 - type (PSG = 02, NOISE = 03)
				01 - noise mode/frequency lsb
				02 - attack rate
				03 - sustain level
				04 - attack level
				05 - decay rate
				06 - release rate
			*/

			private int[] sizes = new int[]{
				38, 2,
				6,  6,
			};

			public enum PatchType {
				FM, DIG,
				PSG, NOISE
			}
		}
	}
}
