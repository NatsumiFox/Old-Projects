using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMPSformatConv {
	class Program {
		static readonly string[] opStr = {
			"spDetune\t", "spMultiple\t", "spRateScale\t", "spAttackRt\t", "spAmpMod\t",
			"spSustainRt\t", "spDecayRt\t", "spSustainLv\t", "spReleaseRt\t", "spTotalLv\t",
		};

		static void Main(string[] args) {
			foreach(string s in args) {
				if (File.Exists(s)) {
					string f = File.ReadAllText(s);
					bool isSFX = f.Contains("smpsHeaderTempoSFX") || f.Contains("smpsHeaderChanSFX") || f.Contains("sHeaderPrio");

					f = f.Replace("smpsHeaderVoice     ", "sHeaderInit\t")
						.Replace("smpsHeaderTempo     ", "sHeaderTempo\t")
						.Replace("smpsHeaderChan      ", "sHeaderCh\t")
						.Replace("smpsHeaderDAC       ", "sHeaderDAC\t")
						.Replace("smpsHeaderFM        ", "sHeaderFM\t")
						.Replace("smpsHeaderPSG       ", "sHeaderPSG\t")
						.Replace("smpsHeaderTempoSFX  $01", "sHeaderPrio\t$80")
						.Replace("smpsHeaderChanSFX   ", "sHeaderCh\t")
						.Replace("smpsHeaderSFXChannel ", "sHeaderSFX\t$80, ")
						.Replace("cPSG1", "ctPSG1").Replace("cPSG2", "ctPSG2").Replace("cPSG3", "ctPSG3")
						.Replace("cFM3", "ctFM3").Replace("cFM4", "ctFM4").Replace("cFM5", "ctFM5")
						.Replace("dc.b\t", "dc.b ")
						.Replace("nMaxPSG", "nHiHat")

						/* commands */
						.Replace("smpsNoAttack", "sHold")
						.Replace("smpsStop", "sStop")
						.Replace("smpsContinuousLoop  ", "sCont\t\t")
						.Replace("smpsAlterVol        ", "saVol\t\t")
						.Replace("smpsAlterVol		", "saVol\t\t")
						.Replace("smpsFMAlterVol      ", "saVol\t\t")
						.Replace("smpsPSGAlterVol     ", "saVol_p\t\t")
						.Replace("smpsPan             ", "sPan\t\t")
						.Replace("panCenter", "spCenter")
						.Replace("panCentre", "spCentre")
						.Replace("panLeft", "spLeft")
						.Replace("panRight", "spRight")
						.Replace("panNone", "spNone")
						.Replace("smpsSetvoice        ", "sVoice\t\t")
						.Replace("smpsFMvoice         ", "sVoice\t\t")
						.Replace("smpsLoop            ", "sLoop\t\t")
						.Replace("smpsJump            ", "sJump\t\t")
						.Replace("smpsCall            ", "sCall\t\t")
						.Replace("smpsReturn", "sRet\t\t")
						.Replace("smpsAlterNote       ", "ssDetune\t")
						.Replace("smpsAlterNote		", "ssDetune\t")
						.Replace("smpsAlterNote	", "ssDetune\t")
						.Replace("smpsAlterPitch      ", "saTranspose\t")
						.Replace("smpsAlterPitch		", "saTranspose\t")
						.Replace("smpsModSet          ", "ssMod68k\t")
						.Replace("smpsModSet ", "ssMod68k\t")
						.Replace("smpsModSet\t", "ssMod68k\t")
						.Replace("smpsModOff", "sModOff\t\t")
						.Replace("smpsModOn", "sModOn\t\t")
						.Replace("smpsNop             ", ";sComm\t\t0,")
						.Replace("smpsSetTempoMod     ", "ssTempo\t\t")
						.Replace("smpsNoteFill        ", "sNoteTimeOut\t")
						.Replace("smpsPSGform         ", "sNoisePSG\t")
						.Replace("smpsPSGvoice        ", "sVolEnv\t\t")
						.Replace("fTone_", "v")
						.Replace("sTone_", "v")

						/* instruments */
						.Replace("\tsmpsVcUnusedBits    $00\r\n", "")
						.Replace("\tsmpsVcUnusedBits    $00\n", "")
						.Replace("smpsVcAlgorithm     ", "spAlgorithm\t")
						.Replace("smpsVcFeedback      ", "spFeedback\t")
						.Replace("smpsVcDetune        ", "spDetune\t")
						.Replace("smpsVcCoarseFreq    ", "spMultiple\t")
						.Replace("smpsVcRateScale     ", "spRateScale\t")
						.Replace("smpsVcAttackRate    ", "spAttackRt\t")
						.Replace("smpsVcAmpMod        ", "spAmpMod\t")
						.Replace("smpsVcDecayRate1    ", "spSustainRt\t")
						.Replace("smpsVcDecayRate2    ", "spDecayRt\t")
						.Replace("smpsVcDecayLevel    ", "spSustainLv\t")
						.Replace("smpsVcReleaseRate   ", "spReleaseRt\t")
						.Replace("smpsVcTotalLevel    ", "spSSGEG\t\t$00, $00, $00, $00\n\tspTotalLv\t");

					List<string> ls = new List<string>() {  };
					ls.AddRange(f.Replace("\r", "").Split('\n'));

					int itempo = -1, ich = -1;
					string daclabel = null;
				
					// fix operator order
					for(int i = 0;i < ls.Count;i++) {
						foreach(string cs in opStr) {
							int ix = ls[i].IndexOf(cs);
							if (ix > 0) {

								// this is an operator! do hax!
								ix += cs.Length;
								string[] ixs = ls[i].Substring(ix, ls[i].Length - ix).Split(',');

								for(int z = 0;z < ixs.Length;z++) {
									ixs[z] = ixs[z].Replace(",", "").Trim();
								}

								if (ixs.Length == 4) {

									// finish it!
									ls[i] = ls[i].Substring(0, ix) + ixs[3] + ", " + ixs[1] + ", " + ixs[2] + ", " + ixs[0];
								}

								break;
							}
						}

						int xx = ls[i].IndexOf("sHeaderInit");
						if (xx > 0) {
							ls[i] = ls[i].Substring(0, xx + "sHeaderInit".Length);

						} else if(ls[i].Contains("sHeaderCh")) {
							if (!isSFX) {
								ich = i;
								ls[i] = ls[i].Replace("$07", "$05").Replace("$06", "$05");
							}

						} else if (ls[i].Contains("sHeaderTempo")) {
							if (!isSFX) {
								itempo = i;

								int xy = ls[i].IndexOf(",");
								string v = TempoConv(ls[i].Substring(xy + 1, ls[i].Length - xy - 1).Trim());
								ls[i] = ls[i].Substring(0, xy + 1) + " " + v;
							}

						} else if (ls[i].Contains("sHeaderPSG")) {
							if (!isSFX) {
								int xy = ls[i].IndexOf(",");
								xy = ls[i].IndexOf(",", xy + 1);
								int xz = ls[i].IndexOf(",", xy + 1);

								string v = TranslatePSG(ls[i].Substring(xy + 1, xz - xy - 1).Trim());
								ls[i] = ls[i].Substring(0, xy + 1) + " " + v + ls[i].Substring(xz, ls[i].Length - xz);
							}

						} else if ((xx = ls[i].IndexOf("saVol_p")) > 0) {
							string v = TranslatePSG(ls[i].Substring(xx + "saVol_p".Length).Trim());
							ls[i] = "\tsaVol\t\t" + v;

						} else if ((xx = ls[i].IndexOf("sHeaderDAC")) > 0) {
							if (!isSFX) {
								daclabel = ls[i].Substring(xx + "sHeaderDAC".Length).Trim();
								ls[i] = "\tsHeaderDAC\t" + daclabel + "1\n\tsHeaderDAC\t" + daclabel + "2";
							}

						} else if(daclabel != null && ls[i].StartsWith(daclabel + ":")) {
							if (!isSFX) {
								ls[i] = ls[i].Replace(daclabel, daclabel + "2");
							}

						} else if (ls[i].Contains("smpsHeaderStartSong")) {
							ls.RemoveAt(i);
							--i;
						}
					}

					if (!isSFX) {
						// swap tempo and ch
						if (itempo > 0 && ich > 0 && itempo > ich) {
							string tempo = ls[itempo];
							ls.RemoveAt(itempo);
							ls.Insert(ich, tempo);
						}

						// add dac1 line in
						ls.Add(daclabel + "1:");
						ls.Add("\tsStop");
					}

					// copy file to save it
					if (File.Exists(s + ".old")) File.Delete(s + ".old");
					File.Copy(s, s + ".old");

					// save the new file
					File.WriteAllText(s, string.Join("\n", ls));
					Console.WriteLine("Done " + s);
				} else {
					Console.WriteLine("Fail " + s);
				}
			}

			Console.ReadKey();
		}

		public static string TempoConv(string v) {
			bool hex = v.StartsWith("$") || v.StartsWith("$");
			v = v.Replace("$", "").Replace("0x", "");

			if (!int.TryParse(v, hex ? NumberStyles.HexNumber : NumberStyles.Number, CultureInfo.InvariantCulture, out int n)) {
				Console.WriteLine("Fail to convert " + v);
				return v;
			}

			n &= 0xFF;
			if (n == 0) n = 0x80;
			n = ((((n - 1) << 8) + (n >> 1)) / n) & 0xFF;
			n = (0x100 - ((n == 0) ? 1 : n)) & 0xFF;
			return "$" + n.ToString("X2");
		}

		public static string TranslatePSG(string v) {
			switch (v) {
				case "-$10": return "-$80";
				case "$F0": return "-$80";
				case "$F1": return "-$78";
				case "$F2": return "-$70";
				case "$F3": return "-$68";
				case "$F4": return "-$60";
				case "$F5": return "-$58";
				case "$F6": return "-$50";
				case "$F7": return "-$48";
				case "$F8": return "-$40";
				case "$F9": return "-$38";
				case "$FA": return "-$30";
				case "$FB": return "-$28";
				case "$FC": return "-$20";
				case "$FD": return "-$18";
				case "$FE": return "-$10";
				case "$FF": return "-$08";
				case "$00": return v;
				case "$01": return "$08";
				case "$02": return "$10";
				case "$03": return "$18";
				case "$04": return "$20";
				case "$05": return "$28";
				case "$06": return "$30";
				case "$07": return "$38";
				case "$08": return "$40";
				case "$09": return "$48";
				case "$0A": return "$50";
				case "$0B": return "$58";
				case "$0C": return "$60";
				case "$0D": return "$68";
				case "$0E": return "$70";
				case "$0F": return "$78";
				case "$10": return "$80";
			}

			switch (v) {
				case "-$1": return "-$08";
				case "-$2": return "-$10";
				case "-$3": return "-$18";
				case "-$4": return "-$20";
				case "-$5": return "-$28";
				case "-$6": return "-$30";
				case "-$7": return "-$38";
				case "-$8": return "-$40";
				case "-$9": return "-$48";
				case "-$A": return "-$50";
				case "-$B": return "-$58";
				case "-$C": return "-$60";
				case "-$D": return "-$68";
				case "-$E": return "-$70";
				case "-$F": return "-$78";
				case "$0": return v;
				case "$1": return "$08";
				case "$2": return "$10";
				case "$3": return "$18";
				case "$4": return "$20";
				case "$5": return "$28";
				case "$6": return "$30";
				case "$7": return "$38";
				case "$8": return "$40";
				case "$9": return "$48";
				case "$A": return "$50";
				case "$B": return "$58";
				case "$C": return "$60";
				case "$D": return "$68";
				case "$E": return "$70";
				case "$F": return "$78";

				default:
					Console.WriteLine("Unknown value " + v);
					break;
			}

			return null;
		}
	}
}
