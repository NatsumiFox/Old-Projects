using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;

namespace OptimizerLibrary.v1_0 {
	internal class OptimizerInfo {
		public string LastNote = null;
		public uint? LastDelay = null;
		public int Level = 0;

		public byte Volume = 0x80, Detune = 0, Transpose = 0, Gate = 0;
		public short Tempo = 0, TempoShoes = 0, Portamento = -0x8000;
		public string Voice = null, VolEnv = null, ModEnv = null, Pan = null, Noise = null, PortaTarget = null;
		public bool Modulating = false, IsKeyOff = false, LastWasNote = false;

		public OptimizerInfo() {
			Reset();
		}

		public void Reset() {
			LastNote = null;
			LastDelay = null;
			Voice = VolEnv = ModEnv = Pan = Noise = PortaTarget = null;
			LastWasNote = Modulating = IsKeyOff = false;
			Volume = 0x80; Detune = Transpose = Gate = 0;
			Tempo = TempoShoes = Portamento = 0;
		}
	}

	internal class Routine {
		public List<Item> Items;
		public bool Emitted = false;

		public Routine() {
			Items = new List<Item>();
		}

		internal bool Add(CommandBase command) {
			Items.Add(command);
			return true;
		}

		internal void Emit(StreamWriter outs, OptimizerInfo info) {
			foreach(Item i in Items) {
				i.Emit(outs, info);
			}
		}

		internal void End(StreamWriter console, string next) {
			if(Items.Count == 0) {
				return;
			}

			// check last item
			if(Items.Last().IsEndToken) {
				return;
			}

			// add a jump command
			Items.Add(new CommandJump("sJump", next));
		}
	}

	internal class Channel {
		public string Label;
		public ChannelType Type;

		public Channel(string label, ChannelType type) {
			Label = label;
			Type = type;
		}

		// emit channel header
		internal void Emit(StreamWriter outs) {
			string mac;
			string[] args;

			switch(Type) {
				case ChannelType.DAC1: case ChannelType.DAC2:
					mac = "sHeaderDAC";
					args = new string[] { Label };
					break;

				case ChannelType.FM1: case ChannelType.FM2: case ChannelType.FM3:
				case ChannelType.FM4: case ChannelType.FM5: case ChannelType.FM6:
					mac = "sHeaderFM";
					args = new string[] { Label, "$00", "$00" };
					break;

				case ChannelType.PSG1: case ChannelType.PSG2: case ChannelType.PSG3: case ChannelType.PSG4:
					mac = "sHeaderPSG";
					args = new string[] { Label, "$00", "$00", "$00", "$00" };
					break;

				default: return;
			}

			OptimizeAMPS.EmitMacroRaw(outs, mac, args);
		}
	}

	internal enum ChannelType {
		DAC1, DAC2,
		FM1, FM2, FM3, FM4, FM5, FM6,
		PSG1, PSG2, PSG3, PSG4,
	}

	internal class OptimizeAMPS {
		internal static bool Error(StreamWriter console, string data) {
			if(data.Length > 0) {
				console.WriteLine(data);
			}

			console.WriteLine("Conversion was terminated.");
			return false;
		}

		public OptimizeAMPS() {
			// initialize null routine for the header
			Routines = new Dictionary<string, Routine>();
			CurrentRoutine = new Routine();		// note - dummy routine, will not contain any data (hopefully)

			Flags = new Dictionary<string, string>();
			Channels = new Dictionary<string, Channel>();
			Voices = new Dictionary<string, Voice>();
		}

		private Dictionary<string, long> RoutineCounts = new Dictionary<string, long>();

		// helper function to count up routine names from 1 to infinity, avoiding duplicates
		private string MakeRoutine(string name, Routine rx) {
			// first routine special
			if(!RoutineCounts.ContainsKey(name)) {
				RoutineCounts[name] = 1;
				Routines.Add(name + "0001", rx);
				return name + "0001";
			}

			// normal mode
			Routines.Add(name + (++RoutineCounts[name]).ToString().PadLeft(4, '0'), rx);
			return name + RoutineCounts[name].ToString().PadLeft(4, '0');
		}

		#region Parsing

		private bool _done = false, _headerdone = false;

		// handle loading a single line of text
		public bool Load(string line, StreamWriter console) {
			// empty line detection
			line = line.Trim();

			if(line.Length == 0) {
				return true;
			}

			if(_done) {
				return Error(console, "Unexpected data after EOF");
			}

			// interpret the next command
			switch(line[0]) {
				default:
					return Error(console, "Invalid command " + line[0]);

				case ';': {
					break;
				}

				case '?': {
					return ParseSpecial(line[1..], console);
				}

				case ':': {
					// check for end token
					if(line.Length < 2) {
						return Error(console, "Label name has 0 characters!");
					}

					if(line[1] == '-') {
						_done = true;
						break;
					}

					return AddRoutine(line[1..], console);
				}

				case '+': {
					if (!_headerdone) {
						return Error(console, "Header needs to be finished before attempting to process other data.");
					}

					return ParseNote(line[1..], console);
				}

				case '-': {
					if (!_headerdone) {
						return Error(console, "Header needs to be finished before attempting to process other data.");
					}

					return ParseCommand(line[1..], console);
				}
			}

			return true;
		}

		private Dictionary<string, Channel> Channels;

		private Dictionary<string, Routine> Routines;
		private Routine CurrentRoutine;

		private Dictionary<string, Voice> Voices;
		private Voice CurrentVoice;
		private string CurrentVoiceName;

		private Dictionary<string, string> Flags;

		// process notes
		private bool ParseNote(string args, StreamWriter console) {
			foreach(string nt in args.Trim().Split(' ')) {
				string[] ntd = nt.Split(':');

				// add a new note instance
				CurrentRoutine.Add(new Note(ntd[0], ntd[1]));
			}

			return true;
		}

		// add a new routine to the file
		private bool AddRoutine(string label, StreamWriter console) {
			if(Routines.ContainsKey(label)) {
				// routine does not exist yet
				return Error(console, "Label "+ label +" already exists!");
			}

			// insert a jump command
			CurrentRoutine.End(console, label);

			// set as current routine
			CurrentRoutine = Routines[label] = new Routine();
			return true;
		}

		// parse special commands
		private bool ParseSpecial(string data, StreamWriter console) {
			// check command type
			string[] parts = data.Split(' ');

			if(parts.Length < 1 || parts[0].Trim().Length == 0) {
				return Error(console, "Unable to process command: ?"+ data);
			}

			// interpret command
			switch(parts[0]) {
				default:
					return Error(console, "Uknown command: ?" + data);

				case "header": {
					if (parts.Length < 1) {
						return Error(console, "Unable to process command: ?" + data);
					}

					// interpret command
					switch (parts[1]) {
						default:
							return Error(console, "Uknown command: ?" + data);

						case "end": {
							_headerdone = true;
							break;
						}

						case "start": {
							var flags = Util.SettingsParse(parts, 2, console);

							if(flags == null) {
								return Error(console, "");
							}

							if(!flags.ContainsKey("version")) {
								return Error(console, "flag 'version' was not present in the command: ?"+ data);
							}

							if (flags["version"] != "1.0") {
								return Error(console, "Unsupported version '"+ flags["version"] + "': ?" + data);
							}

							Flags["version"] = flags["version"];
							break;
						}

						case "features": {
							var flags = Util.SettingsParse(parts, 2, console);

							if (flags == null) {
								return Error(console, "");
							}

							// convert feature flags into actual flags
							foreach (string key in flags.Keys) {
								Flags[key.ToUpperInvariant()] = flags[key.ToUpperInvariant()];
							}
							break;
						}

						case "flags": {
							var flags = Util.SettingsParse(parts, 2, console);

							if (flags == null) {
								return Error(console, "");
							}

							// check that flags exist
							if (!flags.ContainsKey("label"))	return Error(console, "Expected flag 'label' to be defined, but it wasnt: ?" + data);
							if (!flags.ContainsKey("opt"))		return Error(console, "Expected flag 'opt' to be defined, but it wasnt: ?" + data);
							if (!flags.ContainsKey("type"))		return Error(console, "Expected flag 'type' to be defined, but it wasnt: ?" + data);
							if (!flags.ContainsKey("tempo"))	return Error(console, "Expected flag 'tempo' to be defined, but it wasnt: ?" + data);

							// convert feature flags into actual flags
							foreach (string key in flags.Keys) {
								Flags[key.ToLowerInvariant()] = flags[key];
							}
							break;
						}

						case "channel": {
							if (parts.Length != 4) {
								return Error(console, "Unable to process command: ?" + data);
							}

							// find channel type
							if (!Enum.TryParse(parts[2], true, out ChannelType type)) {
								return Error(console, "Channel type was not recognized: " + parts[2]);
							}

							// check for channel type already existing
							if(Channels.ContainsKey(type.ToString())) {
								return Error(console, "Channel type '"+ parts[2] + "' was already defined: ?" + data);
							}

							// save new channel
							Channels[type.ToString()] = new Channel(parts[3], type);
							break;
						}
					}

					break;
				}

				case "alias": {
					if (parts.Length < 2) {
						return Error(console, "Unable to process command: ?" + data);
					}

					// generate alias name
					string aname = "alias_"+ parts[2].ToLowerInvariant();

					if (Flags.ContainsKey(aname)) {
						return Error(console, "Alias "+ parts[2] +" already exists! ?"+ data);
					}

					// add alias
					Flags[aname] = parts[1];
					break;
				}

				case "fmvoice": {
					if(!_headerdone) {
						return Error(console, "Header needs to be finished before attempting to process other data.");
					}

					if (parts.Length < 1) {
						return Error(console, "Unable to process command: ?" + data);
					}

					// interpret command
					switch (parts[1]) {
						default:
							return Error(console, "Uknown command: ?" + data);

						case "end": {
							if(!CurrentVoice.Verify(console, CurrentVoiceName)) {
								return false;
							}

							CurrentVoice = null;
							break;
						}

						case "start": {
							if (CurrentVoice != null) {
								return Error(console, "The previous voice was not ended yet.");
							}

							if (parts.Length != 3) {
								return Error(console, "Unable to process command: ?" + data);
							}

							// check for channel type already existing
							if (Voices.ContainsKey(parts[2])) {
								return Error(console, "Voice '" + parts[2] + "' was already defined: ?" + data);
							}

							// save new channel
							CurrentVoice = Voices[CurrentVoiceName = parts[2]] = new Voice();
							break;
						}
					}
					break;
				}
			}

			return true;
		}

		// parse a SMPS2ASM command
		private bool ParseCommand(string data, StreamWriter console) {
			// check command type
			string[] parts = data.Split(' ');

			if (parts.Length < 1 || parts[0].Trim().Length == 0) {
				return Error(console, "Unable to process command: -" + data);
			}

			// interpret command
			string cmd = parts[0].Trim();
			switch (GetCommandName(cmd).ToLowerInvariant()) {
				// FM voices
				case "spalgorithm": case "spfeedback": case "spdetune": case "spmultiple": case "spratescale": case "spattackrt": case "spampmod": 
				case "spsustainrt": case "spdecayrt": case "spsustainlv": case "spreleasert": case "spssgeg": case "sptotallv": case "sptotallv2": {
					return CurrentVoice.Command(console, cmd.ToLowerInvariant(), parts[1..]);
				}

				// control flow instructions
				case "scall":		return AddCommand(CommandBase.ProcessCommand(console, CommandType.Call, cmd, parts[1..]));
				case "sjump":		return AddCommand(CommandBase.ProcessCommand(console, CommandType.Jump, cmd, parts[1..]));
				case "sloop":		return AddCommand(CommandBase.ProcessCommand(console, CommandType.Loop, cmd, parts[1..]));
				case "sret":		return AddCommand(CommandBase.ProcessCommand(console, CommandType.Return, cmd, parts[1..]));
				case "sstop":		return AddCommand(CommandBase.ProcessCommand(console, CommandType.Stop, cmd, parts[1..]));

				// set/add pairs
				case "savol":		return AddCommand(CommandBase.ProcessCommand(console, CommandType.VolAdd, cmd, parts[1..]));
				case "ssvol":		return AddCommand(CommandBase.ProcessCommand(console, CommandType.VolSet, cmd, parts[1..]));
				case "sadetune":	return AddCommand(CommandBase.ProcessCommand(console, CommandType.DetuneAdd, cmd, parts[1..]));
				case "ssdetune":	return AddCommand(CommandBase.ProcessCommand(console, CommandType.DetuneSet, cmd, parts[1..]));
				case "satranspose":	return AddCommand(CommandBase.ProcessCommand(console, CommandType.TransposeAdd, cmd, parts[1..]));
				case "sstranspose":	return AddCommand(CommandBase.ProcessCommand(console, CommandType.TransposeSet, cmd, parts[1..]));

				// modulation
				case "smodamps":	return AddCommand(CommandBase.ProcessCommand(console, CommandType.ModSet, cmd, parts[1..]));
				case "smodon":		return AddCommand(CommandBase.ProcessCommand(console, CommandType.ModOn, cmd, parts[1..]));
				case "smodoff":		return AddCommand(CommandBase.ProcessCommand(console, CommandType.ModOff, cmd, parts[1..]));

				// portamento
				case "ssportamento":return AddCommand(CommandBase.ProcessCommand(console, CommandType.PortamentoSetSpeed, cmd, parts[1..]));
				case "ssportatgt": return AddCommand(CommandBase.ProcessCommand(console, CommandType.PortamentoSetFreq, cmd, parts[1..]));
				case "ssportatgtnote":return AddCommand(CommandBase.ProcessCommand(console, CommandType.PortamentoSetNote, cmd, parts[1..]));

				// YM only
				case "span":		return AddCommand(CommandBase.ProcessCommand(console, CommandType.Pan, cmd, parts[1..]));
				case "sslfo":		return AddCommand(CommandBase.ProcessCommand(console, CommandType.SetLFO, cmd, parts[1..]));
				case "skeyoff":		return AddCommand(CommandBase.ProcessCommand(console, CommandType.KeyOff, cmd, parts[1..]));
				case "sspecfm3":	return AddCommand(CommandBase.ProcessCommand(console, CommandType.FM3Special, cmd, parts[1..]));

				// misc commands
				case "svolenv":		return AddCommand(CommandBase.ProcessCommand(console, CommandType.VolEnv, cmd, parts[1..]));
				case "smodenv":		return AddCommand(CommandBase.ProcessCommand(console, CommandType.FreqEnv, cmd, parts[1..]));
				case "svoice":		return AddCommand(CommandBase.ProcessCommand(console, CommandType.Voice, cmd, parts[1..]));
				case "snoisepsg":	return AddCommand(CommandBase.ProcessCommand(console, CommandType.Noise, cmd, parts[1..]));
				case "sstempo":		return AddCommand(CommandBase.ProcessCommand(console, CommandType.Tempo, cmd, parts[1..]));
				case "sstemposhoes":return AddCommand(CommandBase.ProcessCommand(console, CommandType.TempoShoes, cmd, parts[1..]));
				case "sgate":		return AddCommand(CommandBase.ProcessCommand(console, CommandType.Gate, cmd, parts[1..]));
				case "sym":			return AddCommand(CommandBase.ProcessCommand(console, CommandType.YM, cmd, parts[1..]));
				case "backup":		return AddCommand(CommandBase.ProcessCommand(console, CommandType.Backup, cmd, parts[1..]));
				case "signore":		return true;

				default:
					return Error(console, "Unrecognized command: -" + data);
			}
		}

		// get command name while checking for alias
		private string GetCommandName(string cmd) {
			string aname = "alias_" + cmd.ToLowerInvariant();

			if(Flags.ContainsKey(aname)) {
				return Flags[aname];
			}

			return cmd;
		}

		// add command to the routine
		private bool AddCommand(CommandBase command) {
			if(command == null) {
				return false;
			}

			return CurrentRoutine.Add(command);
		}

		#endregion

		#region Unoptimize

		private string CurrLabel;

		internal bool UnOptimize(StreamWriter console) {
			// check if unoptimize is enabled
			if(!Flags.ContainsKey("unoptimize") || Flags["unoptimize"] != "1") {
				return true;
			}

			console.WriteLine("Unoptimize step...");

			// copy the old routines and generate new ones
			Dictionary<string, Routine> OldRoutines = Routines;
			Routines = new Dictionary<string, Routine>();

			foreach(KeyValuePair<string, Channel> ch in Channels) {
				if(!UnoptimizeChannnel(console, ch.Value, ref OldRoutines)) {
					return false;
				}
			}

			return true;
		}

		// helper function to generate a new routine for a channel
		private bool UnoptimizeChannnel(StreamWriter console, Channel channel, ref Dictionary<string, Routine> oldRoutines) {
			string newroutine = CurrLabel = Flags["label"] + "_" + channel.Type;
			Routine rt = new Routine();

			string baseroutine = channel.Label;
			channel.Label = newroutine;
			Routines.Add(newroutine, rt);

			// unoptimize the routine
			return UnoptimizeRoutine(console, baseroutine, newroutine, rt, true, ref oldRoutines);
		}

		// helper function to follow a routine and handle its data
		private bool UnoptimizeRoutine(StreamWriter console, string process, string newname, Routine routine, bool isChannel, ref Dictionary<string, Routine> oldRoutines) {
			// check if the routine exists
			if(!oldRoutines.ContainsKey(process)) {
				console.WriteLine("Failed to find routine " + process + "! Can not unoptimize!");
				return false;
			}

			List<KeyValuePair<string,string>> delays = new List<KeyValuePair<string, string>>();
			Routine proc = oldRoutines[process];

			// start recording entries
			foreach(Item i in proc.Items) {
				if(!i.IsControlFlow) {
					// normal items are just added
					routine.Items.Add(i.Clone());
					continue;
				}

				switch(i) {
					case CommandCall c: {
						// call the routine
						if(!UnoptimizeRoutine(console, c.Target, c.Target, routine, false, ref oldRoutines)) {
							return false;
						}
						break;
					}

					case CommandJump c:
						if(c.Target == process) {
							// points to itself
							routine.Items.Add(new CommandJump("sJump", newname));
							goto end;

						} else if(isChannel) {
							// is the parent channel
							Routine rx = new Routine();
							string newrt = MakeRoutine(CurrLabel + "_", rx);
							routine.Items.Add(new CommandJump("sJump", newrt));

							if (!UnoptimizeRoutine(console, c.Target, newrt, rx, isChannel, ref oldRoutines)) {
								return false;
							}

							goto end;

						} else {
							// is a child channel
							if (!UnoptimizeRoutine(console, c.Target, c.Target, routine, false, ref oldRoutines)) {
								return false;
							}

							goto end;
						}

					case CommandLoop c:
						bool ret = true;

						if(c.Current == 0) {
							// special case
							c.Current = (byte)(c.Loops - 1);
							ret = false;

						} else if(--c.Current == 0) {
							// loop end
							return true;
						}

						// upoptimize loop once
						if (!UnoptimizeRoutine(console, c.Target, c.Target, routine, false, ref oldRoutines)) {
							return false;
						}

						if (ret) return true;
						break;

					case CommandRet _:
						goto end;

					case CommandStop _:
						routine.Items.Add(i.Clone());
						goto end;

					case CommandSpecFM3 c: {
						string rtbase = Flags["label"] + "_FM3O";

						delays.Add(new KeyValuePair<string, string>(c.Target, rtbase + "2"));
						delays.Add(new KeyValuePair<string, string>(c.Target2, rtbase + "3"));
						delays.Add(new KeyValuePair<string, string>(c.Target3, rtbase + "4"));

						routine.Items.Add(new CommandSpecFM3("sSpecFM3", rtbase + "2", rtbase + "3", rtbase + "4"));
						break;
					}

					default:
						console.WriteLine("Failed to process item "+ i.Name +"! This is a program bug.");
						return false;
				}
			}

			end:
			string oldlab = CurrLabel;

			// delayed routines
			foreach (KeyValuePair<string, string> r in delays) {
				Routine rx = new Routine();
				Routines.Add(CurrLabel = r.Value, rx);

				if (!UnoptimizeRoutine(console, r.Key, CurrLabel, rx, true, ref oldRoutines)) {
					return false;
				}
			}

			CurrLabel = oldlab;
			return true;
		}

		#endregion

		#region Optimize File

		private int[] levels = new int[] { 1, 5, 3, 2, 1, 3, 2, 1 };
	//	private int[] levels = new int[] { 3 };

		internal bool Optimize(StreamWriter console) {
			// check optimization level
			if (!Util.ArgToInt(Flags["opt"], out int opt)) {
				return Error(console, "Unable to parse flag opt=" + Flags["opt"] + ". Can not determine optimization level.");
			}

			foreach(int level in levels) {
				if(!Optimize(console, level, opt)) {
					return false;
				}
			}

			return true;
		}

		internal bool Optimize(StreamWriter console, int level, int opt) {
			// check if level is enabled
			if(opt < level) {
				return true;
			}

			// execute level
			foreach(OptimizeCall d in OptimizationData[level - 1]) {
				if(!d.Call(this, console)) {
					return false;
				}
			}

			return true;
		}

		// optimization level data
		private readonly OptimizeCall[][] OptimizationData = new OptimizeCall[][]{
			new OptimizeCall[] {
				// level 1
				new OptimizeCall("Optimizing away useless macros...", (OptimizeAMPS o, StreamWriter console) => o.OptimizeNops(console)),
				new OptimizeCall("Optimizing away useless rests and holds...", (OptimizeAMPS o, StreamWriter console) => o.OptimizeHoldRest(console)),
				new OptimizeCall("Useless routine removal...", (OptimizeAMPS o, StreamWriter console) => o.OptimizeUselessRoutine(console)),
			},
			new OptimizeCall[] {
				// level 2
				new OptimizeCall("Limit max stack size...", (OptimizeAMPS o, StreamWriter console) => o.FixStack(console)),
			},
			new OptimizeCall[] {
				// level 3
				new OptimizeCall("Finding calls:", (OptimizeAMPS o, StreamWriter console) => o.OptimizeRepeat(console)),
				new OptimizeCall("Tail call optimization...", (OptimizeAMPS o, StreamWriter console) => o.OptimizeTailCall(console)),
				new OptimizeCall("Useless jump removal...", (OptimizeAMPS o, StreamWriter console) => o.OptimizeUselessJump(console)),
			},
			new OptimizeCall[] {
				// level 4
			},
			new OptimizeCall[] {
				// level 5
			//	new OptimizeCall("Finding loops:", (OptimizeAMPS o, StreamWriter console) => o.OptimizeLoop(console)),
				new OptimizeCall("Finding large notes:", (OptimizeAMPS o, StreamWriter console) => o.OptimizeNoteLoops(console)),
			},
		};

		// level 1 - optimize away useless routines
		private bool OptimizeUselessRoutine(StreamWriter console) {
			for (int sri = 0; sri < Routines.Count;) {
				var rt = Routines.ElementAt(sri);

				// check if this is a channel start point
				foreach (Channel c in Channels.Values) {
					if (c.Label == rt.Key) goto nope;
				}

				if (FindNumReferences(console, rt.Key, false, false) <= 1) {

					// can be optimized
					foreach (Routine dst in Routines.Values) {
						for (int d = 0;d < dst.Items.Count;d ++) {
							if (dst.Items[d] is CommandStringTarget t && t.Target.ToLowerInvariant() == rt.Key.ToLowerInvariant()) {
								dst.Items.RemoveAt(d);

								// copy routine data
								for (int s = 0;s < rt.Value.Items.Count;s ++) {
									dst.Items.Insert(d + s, rt.Value.Items[s].Clone());
								}

								goto remove;
							}
						}
					}

					remove:
					// remove the routine
					Routines.Remove(rt.Key);
					continue;
				}

				nope:
				sri++;
			}
			return true;
		}

		// level 1 - optimize away hold flags
		private bool OptimizeHoldRest(StreamWriter console) {
			foreach(Routine rt in Routines.Values) {
				Note last = null;

				// execte every item
				for(int i = 0;i < rt.Items.Count;) {
					if(rt.Items[i] is Note n) {
						if (last == null) {
							last = n;

						} else if(n.Name.ToLowerInvariant() == "shold" && n.Delay != null) {
							// merge shold notes
							last.Delay += n.Delay;
							rt.Items.RemoveAt(i);
							continue;

						} else if (n.Name.ToLowerInvariant() == "nrst" && last.Name.ToLowerInvariant() == "nrst") {
							// merge rest notes
							last.Delay += n.Delay;
							rt.Items.RemoveAt(i);
							continue;

						} else {
							last = n;
						}

					} else {
						last = null;
					}

					i++;
				}
			}
			return true;
		}

		// level 1 - optimize useless instructions
		private bool OptimizeNops(StreamWriter console) {
			OptimizerInfo info = new OptimizerInfo();

			foreach (Routine rt in Routines.Values) {
				info.Reset();
				// execte every item
				for (int i = 0; i < rt.Items.Count;) {
					// check if its a nop
					if (rt.Items[i].IsNop(info)) {
						rt.Items.RemoveAt(i);
						continue;
					}

					rt.Items[i].Update(info);
					i++;
				}
			}
			return true;
		}

		// level 3 - tail calls
		private bool OptimizeTailCall(StreamWriter console) {
			foreach(Routine r in Routines.Values) {
				if(r.Items.Count >= 2 && r.Items[^1].GetType() == typeof(CommandRet) && r.Items[^2].GetType() == typeof(CommandCall)) {
					// can be tail call optimized
					r.Items[^2] = new CommandJump("sJump", (r.Items[^2] as CommandCall).Target);
					r.Items.RemoveAt(r.Items.Count - 1);
				}
			}
			return true;
		}

		// level 3 - useless jumps
		private bool OptimizeUselessJump(StreamWriter console) {
			for (int sri = 0; sri < Routines.Count;) {
				var rt = Routines.ElementAt(sri);

				if (rt.Value.Items.Count == 1 && rt.Value.Items[0].GetType() == typeof(CommandJump)) {
					string tg = (rt.Value.Items[0] as CommandJump).Target;

					// can be optimized
					foreach(Routine dst in Routines.Values) {
						foreach(Item i in dst.Items) {
							if(i is CommandSpecFM3 f) {

								// special FM3 special test
								if(f.Target.ToLowerInvariant() == rt.Key.ToLowerInvariant()) {
									f.Target = tg;
								}

								if (f.Target2.ToLowerInvariant() == rt.Key.ToLowerInvariant()) {
									f.Target2 = tg;
								}

								if (f.Target3.ToLowerInvariant() == rt.Key.ToLowerInvariant()) {
									f.Target3 = tg;
								}
							} else if(i is CommandStringTarget s) {

								// other string targets
								if (s.Target.ToLowerInvariant() == rt.Key.ToLowerInvariant()) {
									s.Target = tg;
								}
							}
						}
					}

					// remove
					Routines.Remove(rt.Key);

					// check if any channel depends on that routine
					foreach(Channel ch in Channels.Values) {
						if (ch.Label.ToLowerInvariant() == rt.Key.ToLowerInvariant()) {
							ch.Label = tg;
						}
					}
					continue;
				}

				sri++;
			}
			return true;
		}

		// level 3 - detect loops
		private int LoopMinimumItems = 8;

		private bool OptimizeLoop(StreamWriter console) {
			for (int rn = 0; rn < Routines.Count;) {
				Routine r = Routines.ElementAt(rn).Value;

				// loop through each pattern length and position to find match
				for(int len = 1; len < r.Items.Count / 2 ; ++len) {
					for(int pos = 0;pos + len < r.Items.Count - len;pos ++) {

						// check if there is a match and find number of loops
						int loops = 0;

						for (; pos + (len * (loops + 2)) < r.Items.Count; loops++) {
							for (int rp = len - 1; rp >= 0; --rp) {
								if (!r.Items[pos + rp].IsSame(r.Items[pos + rp + (len * (loops + 1))])) {
									goto fail;
								}
							}
						}

						fail:	// check if we can optimize this
						if(len * loops > LoopMinimumItems) {
							// remove all the extra loops
							for(int num = len * loops; num > 0; --num) {
								r.Items.RemoveAt(pos);
							}

							// generate a new routine
							Routine rx = new Routine();
							string name = MakeRoutine(Flags["label"] + "_L", rx);

							// add all the items from the old routine to the new (after loop point)
							while(r.Items.Count > pos) {
								rx.Items.Insert(rx.Items.Count, r.Items[pos]);
								r.Items.RemoveAt(pos);
							}

							// insert a loop command to the end of the loop region
							rx.Items.Insert(len, new CommandLoop("sLoop", name, 0x00, (byte) (loops + 1)));
							
							// insert a jump command to the loop
							r.Items.Add(new CommandJump("sJump", name));
							goto routine;
						}
					}
				}

				rn++;
				routine:;
			}
			return true;
		}

		// level 3 - detect large notes
		private bool OptimizeNoteLoops(StreamWriter console) {
			for (int rn = 0; rn < Routines.Count;rn++) {
				Routine r = Routines.ElementAt(rn).Value;

				// check for extra long notes
				for(int i = 0;i < r.Items.Count;i ++) {
					if(r.Items[i] is Note n && n.Delay > 0x7F*4) {
						// note can be optimized
						int num = (int)(n.Delay - 1) / 0x7F;
						n.Delay -= (uint)(0x7F * num);

						// generate a new routine
						Routine rx = new Routine();
						string name = MakeRoutine(Flags["label"] + "_N", rx);

						// add all the items from the old routine to the note (after loop point)
						while (r.Items.Count > i + 1) {
							rx.Items.Insert(rx.Items.Count, r.Items[i + 1]);
							r.Items.RemoveAt(i + 1);
						}

						// add the new cool items to here
						rx.Items.Insert(0, new Note("sHold", 0x7F));
						rx.Items.Insert(1, new CommandLoop("sLoop", name, 0x01, (byte) num));

						// insert a jump command to the loop
						r.Items.Add(new CommandJump("sJump", name));
						continue;
					}
				}
			}

			return true;
		}

		// level 3 - optimize repeat data
		private bool OptimizeRepeat(StreamWriter console) {
			int[] Sizes = new int[] { 100, 40, 22, 15, 7, 4, };

			// run for every size
			for(int size = 0;size < Sizes.Length; size++) {
				console.Write(Sizes[size] + " items. ");
				console.Flush();

				for (int sri = 0;sri < Routines.Count; sri++) {
					// check that this routine is long enough
					if(Routines.ElementAt(sri).Value.Items.Count < Sizes[size]) {
						continue;
					}

					// find child routine to check
					for (int dsi = sri; dsi < Routines.Count; dsi++) {
						// check that this routine is long enough
						if (Routines.ElementAt(dsi).Value.Items.Count < Sizes[size]) {
							continue;
						}

						// attempt at pattern recognition
						bool? res = RepeatFindPattern(console, Routines.ElementAt(sri), Routines.ElementAt(dsi), Sizes[size]);
						if (res == null) return false;
						else if (res == true) dsi--;
					}
				}
			}

			return true;
		}

		// function to attempt at finding a repeating pattern in the src routine with destination routine
		private bool? RepeatFindPattern(StreamWriter console, KeyValuePair<string, Routine> src, KeyValuePair<string, Routine> dst, int items) {
			// special case: checking itself
			bool same = src.Key == dst.Key;

			for(int s = 0;s < src.Value.Items.Count - items;s ++) {
				for (int d = same ? s + items : 0; d < dst.Value.Items.Count - items; d++) {
					for(int pos = 0;!same || s + pos < d;pos ++) {
						// check end
						bool end = (pos + s >= src.Value.Items.Count) || (pos + d >= dst.Value.Items.Count);

						// check if there is a matching data in here
						if (end || !src.Value.Items[s + pos].IsSame(dst.Value.Items[d + pos])) {
							if(end) --pos;

							// need to check if enough of a match happened
							if(pos < items) {
								break;		// <- no
							}

							// match - generate a new routine and remove old items
							Routine rx = new Routine();
							string name = MakeRoutine(Flags["label"] + "_X", rx);

							// copy routine data from the dst routine
							for(int pp = 0;pp < pos; pp++) {
								rx.Items.Add(dst.Value.Items[d]);
								dst.Value.Items.RemoveAt(d);
							}

							dst.Value.Items.Insert(d, new CommandCall("sCall", name));
							rx.Items.Add(new CommandRet("sRet"));

							// remove the src routine data
							for (int pp = 0; pp < pos; pp++) {
								src.Value.Items.RemoveAt(s);
							}

							src.Value.Items.Insert(s, new CommandCall("sCall", name));
							return true;
						}
					}
				}
			}

			return false;
		}

		// level 2 - fixing stack depth
		private bool FixStack(StreamWriter console) {
			// check optimization level
			if (!Util.ArgToInt(Flags["FEATURE_STACK_DEPTH"], out int max)) {
				return Error(console, "Unable to parse feature FEATURE_STACK_DEPTH=" + Flags["FEATURE_STACK_DEPTH"] + ". Can not determine stack depth.");
			}

			for (int i = 0; i < Channels.Count;) {
				string lab = Channels.ElementAt(i).Value.Label;
				bool? res = FixChannelStack(console, lab, max, true, new Stack<string>(new string[] { lab }), new List<string>());

				if (res == false) return false;
				if (res == null) i++;
			}

			return true;
		}

		// fix stack depth for each channel
		private bool? FixChannelStack(StreamWriter console, string label, int max, bool isChannel, Stack<string> stack, List<string> chList) {
			// find the routine
			if (!Routines.ContainsKey(label)) {
				return Error(console, "Internal error: Unable to find label " + label + "!");
			}

			// process items in routine
			for(int i = 0;i < Routines[label].Items.Count;i ++) {
				Item x = Routines[label].Items[i];

				if (x is CommandCall c) {
					// handle calls
					stack.Push(c.Target);

					bool? res = FixChannelStack(console, c.Target, max, false, stack, chList);
					if (res != null) return res;
				
				} else if(x is CommandJump j) {
					// handle jumps

					// check for infinite loop
					if(isChannel && chList.Contains(j.Target.ToLowerInvariant())) {
						return null;
					}

					// check if the target should be added to channel list
					if (isChannel) chList.Add(j.Target.ToLowerInvariant());

					// jump to routine code
					return FixChannelStack(console, j.Target, max, isChannel, stack, chList);

				} else if (x is CommandSpecFM3 s) {
					// handle FM3 special mode
					bool? res = FixChannelStack(console, s.Target, max, true, new Stack<string>(new string[] { s.Target }), chList);
					if (res != null) return res;

					res = FixChannelStack(console, s.Target2, max, true, new Stack<string>(new string[] { s.Target2 }), chList);
					if (res != null) return res;

					res = FixChannelStack(console, s.Target3, max, true, new Stack<string>(new string[] { s.Target3 }), chList);
					if (res != null) return res;

				} else if(x is CommandRet || x is CommandStop) {
					// handle rets and stops
					if(stack.Count > max + 1) {
						// oi oi this bad
						return FixRoutineChain(console, max, stack.ToArray());
					}

					break;
				}
			}

			// finish
			stack.Pop();
			return null;
		}

		// must remove some routines in the chain. find the smallest ones that are used least often
		private bool FixRoutineChain(StreamWriter console, int max, string[] list) {
			List<Tuple<string, int, int>> stats = new List<Tuple<string, int, int>>(list.Length);

			// collect info about the list entries (need to ignore first label)
			for(int i = 0;i < list.Length - 1; i++) {
				stats.Add(new Tuple<string, int, int>(list[i], Routines[list[i]].Items.Count - 1, FindNumReferences(console, list[i], true, true)));
			}

			// order them by the least amount
			stats = stats.OrderBy((data) => data.Item2 * data.Item3).ToList();

			// process all the routines we need to remove
			for (int i = 0;i < stats.Count - max;i ++) {
				if (!RemoveRoutine(console, stats[i].Item1)) {
					return false;
				}
			}

			return true;
		}

		// find the number of references to a routine
		private int FindNumReferences(StreamWriter console, string routine, bool allowloops, bool allowfm3) {
			int num = 0;

			foreach(Routine rx in Routines.Values) {
				foreach(Item i in rx.Items) {
					// check item type
					if (i is CommandSpecFM3 f) {
						if (!allowfm3) num += 100000;
						continue;

					} else if (i is CommandLoop l) {
						if (routine.ToLowerInvariant() == l.Target.ToLowerInvariant()) {
							if (!allowloops) num += 100000;
							else num += l.Loops;
						}

					} else if (i is CommandStringTarget c) {
						if (c.Type == TargetEnum.Routine && routine.ToLowerInvariant() == c.Target.ToLowerInvariant()) {
							num++;
						}
					}
				}
			}

			return num;
		}

		// helper function for removing a routine
		private bool RemoveRoutine(StreamWriter console, string routine) {
			console.Flush();
			Routine rr = Routines[routine];

			foreach (Routine rx in Routines.Values) {
				for (int i = 0;i < rx.Items.Count; i++) {

					if(rx.Items[i] is CommandStringTarget s && s.Type == TargetEnum.Routine && s.Target.ToLowerInvariant() == routine.ToLowerInvariant()) {
						// need to now copy routine here now
						bool iscall = s.GetType() == typeof(CommandCall);

						// remove current item
						rx.Items.RemoveAt(i);

						for(int z = 0;z < rr.Items.Count;z++) {
							if(!rr.Items[z].IsControlFlow) {
								// add new item
								rx.Items.Insert(i + z, rr.Items[z]);

								// special chcks for control flow statements
							} else if(rr.Items[z] is CommandRet) {
								// only add it when not using a call
								if(!iscall) rx.Items.Insert(i + z, rr.Items[z]);

							} else if (rr.Items[z] is CommandJump j) {
								// only add it when not using a call
								if (!iscall) rx.Items.Insert(i + z, j);
								else rx.Items.Insert(i + z, new CommandCall("sCall", j.Target));

							} else {
								// treat it normally
								rx.Items.Insert(i + z, rr.Items[z]);
							}
						}
					}
				}
			}

			// delete this routine data
			Routines.Remove(routine);
			return true;
		}

		#endregion

		#region Emit file

		// dump the SMPS2ASM file out
		internal bool Emit(StreamWriter outs, StreamWriter console) {
			OptimizerInfo info = new OptimizerInfo();

			// check optimization level
			if (!Util.ArgToInt(Flags["opt"], out info.Level)) {
				return Error(console, "Unable to parse flag opt=" + Flags["opt"] + ". Can not determine optimization level.");
			}

			// do header
			{
				console.WriteLine("Writing file to output...");
				outs.WriteLine("; AMPS Optimizer v1.0 - " + Flags["label"]);
				outs.WriteLine();
				outs.WriteLine(Flags["label"] + "_Header:");
				EmitMacroRaw(outs, "sHeaderInit", new string[0]);

				if(!Util.LoadArgument(Flags["tempo"], ArgType.Word, out object _tempo)) {
					return Error(console, "Unable emit header: tempo value '"+ Flags["tempo"] + "' could not be parsed");
				}

				EmitMacroRaw(outs, "sHeaderTempo", new string[] { Util.ToHex((ushort)_tempo, 4) });

				// count fm and psg channels
				var res = GetChannels(out int dacnum, out int fmnum, out int psgnum);
				EmitMacroRaw(outs, "sHeaderCh", new string[] { Util.ToHex(fmnum, 2), Util.ToHex(psgnum, 2) });

				foreach(Channel ch in res) {
					ch.Emit(outs);
				}
			}

			// do voices
			{
				outs.WriteLine();
				outs.WriteLine(Flags["label"] + "_Voices:");

				foreach(KeyValuePair<string, Voice> v in Voices) {
					v.Value.Emit(outs, v.Key);
					outs.WriteLine();
				}
			}

			// do body
			{
				List<string> Defer = new List<string>();

				foreach (KeyValuePair<string, Channel> ch in Channels) {
					// find the routine
					if (!Routines.ContainsKey(ch.Value.Label)) {
						return Error(console, "Internal error: Unable to find label " + ch.Value.Label + "!");
					}

					// start dumping routine
					if (!EmitRoutine(console, outs, info, ch.Value.Label, out List<string> df)) {
						return false;
					}

					Defer.AddRange(df);
				}

				List<string> DeferLast = new List<string>();

				// handle all deferred routines
				while(Defer.Count > 0) {
					List<string> nd = Defer;
					Defer = new List<string>();

					// filter out all the routines that have a jump at the end
					foreach(string routine in nd) {
						if (!Routines.ContainsKey(routine)) {
							return Error(console, "Internal error: Unable to find label " + routine + "!");
						}

						// check if emit now
						Routine r = Routines[routine];

						if(r.Emitted) {
							continue;
						}

						if (r.Items.Count > 0 && r.Items[^1].GetType() == typeof(CommandJump)) {
							Defer.Add(routine);

						} else {
							DeferLast.Add(routine);
						}
					}

					// handle all deferred routines
					nd = Defer;
					Defer = new List<string>();

					foreach (string routine in nd) {
						// find the routine
						if (!Routines.ContainsKey(routine)) {
							return Error(console, "Internal error: Unable to find label " + routine + "!");
						}

						// start dumping routine
						if (!EmitRoutine(console, outs, info, routine, out List<string> df)) {
							return false;
						}

						Defer.AddRange(df);
					}
				}

				// defer singletons
				for (int i = 0;i < DeferLast.Count;i ++) {
					// find the routine
					if (!Routines.ContainsKey(DeferLast[i])) {
						return Error(console, "Internal error: Unable to find label " + DeferLast[i] + "!");
					}

					// start dumping routine
					if (!EmitRoutine(console, outs, info, DeferLast[i], out List<string> df)) {
						return false;
					}

					DeferLast.AddRange(df);
				}
			}

			// hack
			outs.WriteLine();
			outs.WriteLine(".size := *-"+ Flags["label"] +"_Header");
			outs.WriteLine("\tmessage \"" + Flags["label"] + " is $\\{.size} bytes large!\"");

			return true;
		}

		private bool EmitRoutine(StreamWriter console, StreamWriter outs, OptimizerInfo info, string routine, out List<string> defer) {
			defer = new List<string>();
			List<string> deferNow = new List<string>();
			info.Reset();

			// do not emit twice
			if (Routines[routine].Emitted) {
				return true;
			}

			Routines[routine].Emitted = true;
			outs.WriteLine();
			outs.WriteLine(routine + ":");

			// loop through all items
			foreach (Item i in Routines[routine].Items) {
				if(i is CommandJump j) {
					// special jump handling
					if(Routines.ContainsKey(j.Target) && !Routines[j.Target].Emitted) {
					//	outs.Write(";opt");
					//	j.Emit(outs, info);

						// emit immediately
						if (!EmitRoutine(console, outs, info, j.Target, out List<string> df)) {
							return false;
						}

						defer.AddRange(df);
						break;

					} else {
						// need to emit jump
						j.Emit(outs, info);
					}

				} else if(i is CommandSpecFM3 f) {
					// special fm3sm handling
					deferNow.Add(f.Target);
					deferNow.Add(f.Target2);
					deferNow.Add(f.Target3);
					f.Emit(outs, info);

				} else if(i is CommandCall c) {
					// handle call
					defer.Add(c.Target);
					c.Emit(outs, info);
					info.Reset();

				} else if (i is CommandLoop l) {
					// handle loop
					defer.Add(l.Target);
					l.Emit(outs, info);

				} else {
					// regular
					i.Emit(outs, info);
				}
			}

			// all immediate deferres
			foreach(string rr in deferNow) {
				if (!EmitRoutine(console, outs, info, rr, out List<string> df)) {
					return false;
				}

				defer.AddRange(df);
			}

			return true;
		}

		// get the list of channels
		private List<Channel> GetChannels(out int dacnum, out int fmnum, out int psgnum) {
			List<Channel> res = new List<Channel>();
			dacnum = fmnum = psgnum = 0;

			// hacky method to enumerate keys
			foreach(string key in Enum.GetNames(typeof(ChannelType))) {
				if(Channels.ContainsKey(key)) {
					// has channel, add it
					res.Add(Channels[key]);

					switch(key[0]) {
						case 'F': fmnum++; break;
						case 'D': dacnum++; break;
						case 'P': psgnum++; break;
					}
				}
			}

			return res;
		}

		// output a raw macro data into output file
		internal static void EmitMacroRaw(StreamWriter outs, string name, string[] args) {
			// emit the name
			string text = "\t" + name;

			if(args.Length > 0) {
				// add arguments to the mix
				text = AlignText(text, 24) + string.Join(", ", args);
			}

			// end the line
			outs.WriteLine(text);
		}

		// add alignment to the current text, so it aligns to a specific column
		internal static string AlignText(string text, int column) {
			// calculate real len
			int len = 0;

			for(int c = 0;c < text.Length;c ++) {
				if(text[c] != '\t') {
					len++;

				} else {
					// apply special tab rule
					len = (len & 0xFFF8) + 8;
				}
			}


			// calculate current column
			if (len >= column) return text +" ";
			return text + new string('\t', (column - len - 1) / 8 + 1);
		}

		#endregion
	}

	// helper class
	class OptimizeCall {
		private Func<OptimizeAMPS, StreamWriter, bool> Function;
		private string Text;

		public OptimizeCall(string text, Func<OptimizeAMPS, StreamWriter, bool> function) {
			Text = text;
			Function = function;
		}

		// call the function and report info
		public bool Call(OptimizeAMPS opt, StreamWriter console) {
			Stopwatch sw = new Stopwatch();
			console.Write(Text +" ");
			console.Flush();

			sw.Start();
			if (!Function(opt, console)) {
				return false;
			}

			sw.Stop();
			if(sw.ElapsedMilliseconds > 5000) {
				console.WriteLine("finished in " + (sw.ElapsedMilliseconds / 1000f) + "s");

			} else {
				console.WriteLine("finished in " + (Math.Round(sw.Elapsed.TotalMilliseconds * 100) / 100) + "ms");
			}

			return true;
		}
	}
}
