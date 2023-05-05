using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;

namespace OptimizerLibrary.v1_0 {
	internal class ConvertSMPS2ASM {
		enum ConvertState {
			Header, Voice, Body,
		}

		enum ChannelType {
			FM, DAC, PSG,
		}

		class ChannelData {
			public ChannelType type;
			public int id;
			public string label;

			public ChannelData(ChannelType type, int id, string label) {
				this.type = type;
				this.id = id;
				this.label = label;
			}

			public string FullName() {
				return type.ToString() + id;
			}
		}

		public ConvertSMPS2ASM(bool unoptimize) {
			this.unoptimize = unoptimize;
			state = ConvertState.Header;
			channels = new List<ChannelData>();
		}

		// whether to unoptimize the file during conversion process
		private bool unoptimize;
		private ConvertState state;
		private List<ChannelData> channels;
		private string Label = "TestSCZ2";

		private bool Error(StreamWriter console, string data) {
			console.WriteLine(data);
			console.WriteLine("Conversion was terminated.");
			return false;
		}

		private Regex macroRegex = new Regex("[\\t\\s]+([a-z0-9\\.]+)[\\t\\s]*([a-z0-9,\\s\\t\\$\\-+_]*)", RegexOptions.Compiled | RegexOptions.IgnoreCase);
		private Regex argsRegex =  new Regex("[\\t\\s]*([a-z0-9\\s\\t\\$\\-+_]+),", RegexOptions.Compiled | RegexOptions.IgnoreCase);
		private Regex labelRegex = new Regex("([a-z0-9_]+):?", RegexOptions.Compiled | RegexOptions.IgnoreCase);
		private Regex delayRegex = new Regex("^(\\$?[0-9a-f]+)$", RegexOptions.Compiled | RegexOptions.IgnoreCase);

		// handle processing line by line
		public bool Process(string line, StreamWriter output, StreamWriter console) {
			// ignore blank lines or comment only lines
			if(line.Trim().Length == 0 || line.Trim().StartsWith(';')) {
				return true;
			}

			// handle labels
			if (!line.StartsWith('\t') && !line.StartsWith(' ')) {
				// load label data
				var lab = labelRegex.Match(line);
				 
				if(!lab.Success) {
					return Error(console, "Failed to parse label:" + line.Trim());
				}

				// add label
				DumpNote(output, 0);
				_delay = -1;
				_note = null;
				_hold = false;
				output.WriteLine(":"+ lab.Groups[1].Value.Trim());
				return true;
			}

			// load command data
			var match = macroRegex.Match(line);

			if (!match.Success) {
				return Error(console, "Failed to parse line: " + line.Trim());
			}

			// get the arguments capture
			string vals = match.Groups.Count <= 2 ? "" : match.Groups[2].Value;
			int comment = vals.IndexOf(";");

			// remove comment
			if (comment >= 0) {
				vals = vals[..comment];
			}

			MatchCollection args = vals.Trim().Length == 0 ? null : argsRegex.Matches(vals + ",");

			// handle specific states
			switch (state) {
				case ConvertState.Header: {
					// try to understand which command this is
					switch (match.Groups[1].Value.Trim().ToLowerInvariant()) {
						case "sheaderinit": break;
						case "sheaderch": break;

						case "sheadertempo": {
							// try to parse argument 1 as uint
							if(args == null || args.Count < 1) {
								return Error(console, "Expected an argument to sHeaderTempo, but none was detected.");
							}

							if(!Util.ArgToUint(args[0].Groups[1].Value, out _tempo)) {
								return Error(console, "Expected the argument to sHeaderTempo to be a number, but it could not be parsed.");
							}
							break;
						}

						case "sheaderdac":
							// check for argument 1
							if (args == null || args.Count < 1) {
								return Error(console, "Expected arguments for sHeaderDAC, but none was detected.");
							}

							channels.Add(new ChannelData(ChannelType.DAC, ++_dacch, args[0].Groups[1].Value));
							break;

						case "sheaderfm":
							// check for argument 1
							if (args == null || args.Count < 1) {
								return Error(console, "Expected arguments for sHeaderFM, but none was detected.");
							}

							channels.Add(new ChannelData(ChannelType.FM, ++_fmch, args[0].Groups[1].Value));
							break;


						case "sheaderpsg":
							// check for argument 1
							if (args == null || args.Count < 1) {
								return Error(console, "Expected arguments for sHeaderPSG, but none was detected.");
							}

							channels.Add(new ChannelData(ChannelType.PSG, ++_psgch, args[0].Groups[1].Value));
							break;

						default:			// assume not in header anymore
							state = ConvertState.Voice;
							output.WriteLine("?header start version=1.0");
							output.WriteLine("?header features FEATURE_MODULATION FEATURE_PORTAMENTO FEATURE_MODENV FEATURE_DACFMVOLENV FEATURE_FM6 FEATURE_PSG4 FEATURE_FM3SM FEATURE_STACK_DEPTH=3");
							output.WriteLine("?header flags label="+ Label +" unoptimize=1 opt=5 type=0 fixvoices=1 tempo="+ _tempo);

							// dump channels
							foreach(ChannelData cd in channels) {
								output.WriteLine("?header channel "+ cd.FullName() +" "+ cd.label);
							}

							output.WriteLine("?header end");
							output.WriteLine("?alias signore ssMuteVolPSG");
							output.WriteLine("?alias ssvol ssVolPSGDMF");

							// finally, re-run the algorithm
							return Process(line, output, console);
					}
					break;
				}

				case ConvertState.Voice: {
					// try to understand which command this is
					switch (match.Groups[1].Value.Trim().ToLowerInvariant()) {
						case "spfeedback": case "spdetune": case "spmultiple": case "spratescale": case "spattackrt": case "spampmod": 
						case "spsustainrt": case "spdecayrt": case "spsustainlv": case "spreleasert": case "spssgeg": {
							if (!_invoice) {
								return Error(console, "Not currently in a voice, while trying to send a voice command.");
							}

							WriteMacro(output, match.Groups[1].Value.Trim(), args);
							break;
						}

						case "spalgorithm": {
							if(_invoice) {
								return Error(console, "Previous voice was not finished yet.");
							}

							_invoice = true;
							output.WriteLine("?fmvoice start " + Util.ToHex(_vnum++, 2));
							WriteMacro(output, match.Groups[1].Value.Trim(), args);
							break;
						}

						case "sptotallv": case "sptotallv2": {
							if (!_invoice) {
								return Error(console, "Not currently in a voice, while trying to send a voice command.");
							}

							WriteMacro(output, match.Groups[1].Value.Trim(), args);
							output.WriteLine("?fmvoice end");
							_invoice = false;
							break;
						}

						default:		// assume not in voices anymore
							state = ConvertState.Body;
							// finally, re-run the algorithm
							return Process(line, output, console);
					}

					break;
				}

				case ConvertState.Body: {
					// try to understand which command this is
					switch (match.Groups[1].Value.Trim().ToLowerInvariant()) {
						case "dc.b": {
							// check if args exist
							if (args == null || args.Count == 0) {
								return Error(console, "Invalid missing parameter in dc.b!");
							}

							// special note handling
							foreach (Match m in args) {
								if(!AppendNote(console, output, m.Groups[1].Value)) {
									return false;
								}
							}
							break;
						}

						default: {
							// dump note and write macro
							DumpNote(output, 0);
							WriteMacro(output, match.Groups[1].Value.Trim(), args);
							break;
						}
					}

					break;
				}
			}

			return true;
		}

		// output note into the file
		private void DumpNote(StreamWriter output, int cur) {
			if(_note != null || _delay != -1 || _hold) {
				switch (_last) {
					case 2:		// delay
						if (_hold) {
							_hold = false;
							output.WriteLine("+ sHold:" + (_delay < 0 ? "" : _delay + ""));

						} else output.WriteLine("+ " + _note + ":" + (_delay < 0 ? "" : _delay + ""));
						break;

					case 1: // note
						if (cur == 2) break;
						output.WriteLine("+ " + _note + ":" + (_delay < 0 ? "" : _delay + ""));
						break;

					case 0:		// command
						break;
				}
			}

			// update state
			_last = cur;
		}

		private string _note = null;
		private int _delay = -1, _last = 0;			// 0 = command, 1 = note, 2 = delay. hold is not accounted for
		private bool _hold = false;

		// handle note input
		private bool AppendNote(StreamWriter console, StreamWriter output, string data) {
			// check for duration
			var match = delayRegex.Match(data);
			
			if(match.Success) {
				if (!Util.ArgToInt(data, out int _de)) {
					return Error(console, "Expected the argument to dc.b to be a number, but it could not be parsed: "+ data);
				}

				if(_de <= 0x7F) {
					// its a delay
					if(_hold && _note != null && _last == 2) {
						_delay += _de;
						_hold = false;

					} else {
						DumpNote(output, 2);
						_delay = _de;
					}

					return true;

				} else if(_de == 0x80) {
					// transform to nRst
					data = "nRst";
				}
			}

			// check for hold
			if(_note != null && data.ToLowerInvariant() == "shold") {
				_hold ^= true;
				return true;
			}

			// its a note
			DumpNote(output, 1);

			// update note
			_note = data;
			return true;
		}

		// write macro with its params to
		private void WriteMacro(StreamWriter output, string name, MatchCollection args) {
			output.Write("-" + name);

			// check if args exist
			if (args != null && args.Count > 0) {
				foreach(Match m in args) {
					output.Write(" " + m.Groups[1].Value);
				}
			}

			// end the line
			output.WriteLine();
		}

		private bool _invoice = false;
		private uint _tempo;
		private int _dacch = 0, _fmch = 0, _psgch = 0, _vnum = 0;

		// emit the entire rest of the file
		public bool Emit(StreamWriter output, StreamWriter console) {

			// finish
			output.WriteLine(":-");
			return true;
		}
	}
}
