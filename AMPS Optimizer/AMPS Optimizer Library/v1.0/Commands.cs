using System;
using System.IO;
using System.Text;

namespace OptimizerLibrary.v1_0 {
	abstract class Item {
		internal bool IsEndToken, IsControlFlow;
		internal string Name;

		public Item(string name) {
			Name = name;
			IsEndToken = false;
			IsControlFlow = false;
		}

		internal abstract void Emit(StreamWriter outs, OptimizerInfo info);
		internal abstract Item Clone();
		internal abstract bool IsNop(OptimizerInfo info);
		internal abstract void Update(OptimizerInfo info);
		internal abstract bool IsSame(Item i);
	}

	enum CommandType {
		Call, Jump, Return, Loop, Stop,
		Voice, Pan, VolEnv, FreqEnv, SetLFO,
		Tempo, TempoShoes, Gate, YM,
		FM3Special, Backup, Noise, KeyOff,
		VolAdd, VolSet, TransposeAdd, TransposeSet, DetuneAdd, DetuneSet,
		PortamentoSetSpeed, PortamentoSetNote, PortamentoSetFreq,
		ModSet, ModOn, ModOff,
	}

	enum ModeEnum {
		None,
		Set, Add,
		On, Off,

		RoutineTarget, VoiceTarget, SampleTarget, VolumeEnvelopeTarget, FrequencyEnvelopeTarget, EquateTarget,
	}

	enum TargetEnum {
		Routine, Voice,
		VolumeEnvelope, FrequencyEnvelope, 
		Equate, Note,
	}

	abstract class CommandBase : Item {
		public readonly string CanonicalName = "Invalid";
		internal ModeEnum Mode = ModeEnum.None;

		public CommandBase(string name) : base(name) {

		}

		internal static CommandBase Load(StreamWriter console, string name, string[] arguments) {
			throw new NotImplementedException("Command base class has no load method! Please override.");
		}

		internal static CommandBase ProcessCommand(StreamWriter console, CommandType type, string name, string[] arguments) {
			switch(type) {
				case CommandType.Call:				return CommandCall.Load(console, name, arguments);
				case CommandType.Jump:				return CommandJump.Load(console, name, arguments);
				case CommandType.Loop:				return CommandLoop.Load(console, name, arguments);
				case CommandType.Return:			return CommandRet.Load(console, name, arguments);
				case CommandType.Stop:				return CommandStop.Load(console, name, arguments);
				case CommandType.FM3Special:		return CommandSpecFM3.Load(console, name, arguments);

				case CommandType.KeyOff:			return CommandKeyOff.Load(console, name, arguments);
				case CommandType.Backup:			return CommandBackup.Load(console, name, arguments);

				case CommandType.VolAdd:			return CommandVolAdd.Load(console, name, arguments);
				case CommandType.VolSet:			return CommandVolSet.Load(console, name, arguments);
				case CommandType.TransposeAdd:		return CommandTransposeAdd.Load(console, name, arguments);
				case CommandType.TransposeSet:		return CommandTransposeSet.Load(console, name, arguments);
				case CommandType.DetuneAdd:			return CommandDetuneAdd.Load(console, name, arguments);
				case CommandType.DetuneSet:			return CommandDetuneSet.Load(console, name, arguments);

				case CommandType.Tempo:				return CommandTempoSet.Load(console, name, arguments);
				case CommandType.TempoShoes:		return CommandTempoShoesSet.Load(console, name, arguments);
				case CommandType.Gate:				return CommandGate.Load(console, name, arguments);
				case CommandType.Noise:				return CommandNoiseSet.Load(console, name, arguments);
				case CommandType.Pan:				return CommandPan.Load(console, name, arguments);

				case CommandType.SetLFO:			return CommandLFO.Load(console, name, arguments);
				case CommandType.YM:				return CommandYM.Load(console, name, arguments);

				case CommandType.Voice:				return CommandVoice.Load(console, name, arguments);
				case CommandType.VolEnv:			return CommandVolEnv.Load(console, name, arguments);
				case CommandType.FreqEnv:			return CommandFreqEnv.Load(console, name, arguments);

				case CommandType.PortamentoSetSpeed:return CommandPortamentoSpeed.Load(console, name, arguments);
				case CommandType.PortamentoSetNote:	return CommandPortamentoNote.Load(console, name, arguments);
				case CommandType.PortamentoSetFreq: return CommandPortamentoFreq.Load(console, name, arguments);
					
				case CommandType.ModSet:			return CommandModSet.Load(console, name, arguments);
				case CommandType.ModOn:				return CommandModOn.Load(console, name, arguments);
				case CommandType.ModOff:			return CommandModOff.Load(console, name, arguments);
			}

			console.WriteLine("Was unable to process command type " + type + ". This is a bug or a missing feature.");
			return null;
		}
	}

	/**
	 * Commands that have a single byte target
	 */

	abstract class CommandByteArgument : CommandBase {
		internal readonly byte Arg;

		public CommandByteArgument(string name, byte arg) : base(name) {
			Arg = arg;
		}

		internal override void Emit(StreamWriter outs, OptimizerInfo info) {
			OptimizeAMPS.EmitMacroRaw(outs, Name, new string[] { Util.ToHex(Arg, 2) });
			info.LastWasNote = false;
		}

		internal override bool IsSame(Item i) {
			return i.GetType().Equals(GetType()) && (i as CommandByteArgument).Arg == Arg;
		}
	}

	/**
	 * Commands that use a "add" or "set" action with the byte argument
	 */

	class CommandVolAdd : CommandByteArgument {
		public new readonly string CanonicalName = "saVol";

		public CommandVolAdd(string name, byte arg) : base(name, arg) {
			Mode = ModeEnum.Add;
		}

		internal override Item Clone() => new CommandVolAdd(Name, Arg);

		internal static new CommandVolAdd Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.Byte, });
			return res == null ? null : new CommandVolAdd(name, (byte) res[0]);
		}

		internal override bool IsNop(OptimizerInfo info) {
			return Arg == 0;
		}

		internal override void Update(OptimizerInfo info) {
			info.Volume += Arg;
		}
	}

	class CommandVolSet : CommandByteArgument {
		public new readonly string CanonicalName = "ssVol";

		public CommandVolSet(string name, byte arg) : base(name, arg) {
			Mode = ModeEnum.Set;
		}

		internal override Item Clone() => new CommandVolSet(Name, Arg);

		internal static new CommandVolSet Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.Byte, });
			return res == null ? null : new CommandVolSet(name, (byte) res[0]);
		}

		internal override bool IsNop(OptimizerInfo info) {
			return info.Volume == Arg;
		}

		internal override void Update(OptimizerInfo info) {
			info.Volume = Arg;
		}
	}

	class CommandTransposeAdd : CommandByteArgument {
		public new readonly string CanonicalName = "saTranspose";

		public CommandTransposeAdd(string name, byte arg) : base(name, arg) {
			Mode = ModeEnum.Add;
		}

		internal override Item Clone() => new CommandTransposeAdd(Name, Arg);

		internal static new CommandTransposeAdd Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.Byte, });
			return res == null ? null : new CommandTransposeAdd(name, (byte) res[0]);
		}

		internal override bool IsNop(OptimizerInfo info) {
			return Arg == 0;
		}

		internal override void Update(OptimizerInfo info) {
			info.Transpose += Arg;
		}
	}

	class CommandTransposeSet : CommandByteArgument {
		public new readonly string CanonicalName = "ssTranspose";

		public CommandTransposeSet(string name, byte arg) : base(name, arg) {
			Mode = ModeEnum.Set;
		}

		internal override Item Clone() => new CommandTransposeSet(Name, Arg);

		internal static new CommandTransposeSet Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.Byte, });
			return res == null ? null : new CommandTransposeSet(name, (byte) res[0]);
		}

		internal override bool IsNop(OptimizerInfo info) {
			return info.Transpose == Arg;
		}

		internal override void Update(OptimizerInfo info) {
			info.Transpose = Arg;
		}
	}

	class CommandDetuneAdd : CommandByteArgument {
		public new readonly string CanonicalName = "saDetune";

		public CommandDetuneAdd(string name, byte arg) : base(name, arg) {
			Mode = ModeEnum.Add;
		}

		internal override Item Clone() => new CommandDetuneAdd(Name, Arg);

		internal static new CommandDetuneAdd Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.Byte, });
			return res == null ? null : new CommandDetuneAdd(name, (byte) res[0]);
		}

		internal override bool IsNop(OptimizerInfo info) {
			return Arg == 0;
		}

		internal override void Update(OptimizerInfo info) {
			info.Detune += Arg;
		}
	}

	class CommandDetuneSet : CommandByteArgument {
		public new readonly string CanonicalName = "ssDetune";

		public CommandDetuneSet(string name, byte arg) : base(name, arg) {
			Mode = ModeEnum.Set;
		}

		internal override Item Clone() => new CommandDetuneSet(Name, Arg);

		internal static new CommandDetuneSet Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.Byte, });
			return res == null ? null : new CommandDetuneSet(name, (byte) res[0]);
		}

		internal override bool IsNop(OptimizerInfo info) {
			return info.Detune == Arg;
		}

		internal override void Update(OptimizerInfo info) {
			info.Detune = Arg;
		}
	}

	class CommandGate : CommandByteArgument {
		public new readonly string CanonicalName = "sGate";

		public CommandGate(string name, byte arg) : base(name, arg) {
			Mode = ModeEnum.Set;
		}

		internal override Item Clone() => new CommandGate(Name, Arg);

		internal static new CommandGate Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.Byte, });
			return res == null ? null : new CommandGate(name, (byte) res[0]);
		}

		internal override bool IsNop(OptimizerInfo info) {
			return info.Gate == Arg;
		}

		internal override void Update(OptimizerInfo info) {
			info.Gate = Arg;
		}
	}

	/**
	 * Commands that have a single word target
	 */

	abstract class CommandWordArgument : CommandBase {
		internal readonly short Arg;

		public CommandWordArgument(string name, short arg) : base(name) {
			Arg = arg;
		}

		internal override void Emit(StreamWriter outs, OptimizerInfo info) {
			OptimizeAMPS.EmitMacroRaw(outs, Name, new string[] { Util.ToHex(Arg, 4) });
			info.LastWasNote = false;
		}

		internal override bool IsSame(Item i) {
			return i.GetType().Equals(GetType()) && (i as CommandWordArgument).Arg == Arg;
		}
	}

	class CommandTempoSet : CommandWordArgument {
		public new readonly string CanonicalName = "ssTempo";

		public CommandTempoSet(string name, short arg) : base(name, arg) {
			Mode = ModeEnum.Set;
		}

		internal override Item Clone() => new CommandTempoSet(Name, Arg);

		internal static new CommandTempoSet Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.Sword, });
			return res == null ? null : new CommandTempoSet(name, (short) res[0]);
		}

		internal override bool IsNop(OptimizerInfo info) {
			return info.Tempo == Arg;
		}

		internal override void Update(OptimizerInfo info) {
			info.Tempo = Arg;
		}
	}

	class CommandTempoShoesSet : CommandWordArgument {
		public new readonly string CanonicalName = "ssTempoShoes";

		public CommandTempoShoesSet(string name, short arg) : base(name, arg) {
			Mode = ModeEnum.Set;
		}

		internal override Item Clone() => new CommandTempoShoesSet(Name, Arg);

		internal static new CommandTempoShoesSet Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.Sword, });
			return res == null ? null : new CommandTempoShoesSet(name, (short) res[0]);
		}

		internal override bool IsNop(OptimizerInfo info) {
			return info.TempoShoes == Arg;
		}

		internal override void Update(OptimizerInfo info) {
			info.TempoShoes = Arg;
		}
	}

	class CommandPortamentoSpeed : CommandWordArgument {
		public new readonly string CanonicalName = "ssPortamento";

		public CommandPortamentoSpeed(string name, short arg) : base(name, arg) {
			Mode = ModeEnum.Set;
		}

		internal override Item Clone() => new CommandPortamentoSpeed(Name, Arg);

		internal static new CommandPortamentoSpeed Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.Sword, });
			return res == null ? null : new CommandPortamentoSpeed(name, (short) res[0]);
		}

		internal override bool IsNop(OptimizerInfo info) {
			return false;
		}

		internal override void Update(OptimizerInfo info) {
			info.Portamento = Arg;
		}
	}

	class CommandPortamentoFreq : CommandWordArgument {
		public new readonly string CanonicalName = "ssPortaTgt";

		public CommandPortamentoFreq(string name, short arg) : base(name, arg) {
			Mode = ModeEnum.Set;
		}

		internal override Item Clone() => new CommandPortamentoFreq(Name, Arg);

		internal static new CommandPortamentoFreq Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.Sword, });
			return res == null ? null : new CommandPortamentoFreq(name, (short) res[0]);
		}

		internal override bool IsNop(OptimizerInfo info) {
			return false;
		}

		internal override void Update(OptimizerInfo info) {
			info.PortaTarget = ";" + Arg;
		}
	}

	/**
	 * Commands that have multiple parameters
	 */

	class CommandLFO : CommandBase {
		public new readonly string CanonicalName = "ssLFO";
		public bool[] EnableOps;
		public byte LFO, Pan;

		public CommandLFO(string name, byte reg, byte pan) : base(name) {
			Mode = ModeEnum.Set;
			EnableOps = new bool[] { (reg & 0x80) != 0, (reg & 0x40) != 0, (reg & 0x20) != 0, (reg & 0x10) != 0, };
			LFO = (byte)(reg & 0xF);
			Pan = pan;
		}

		public CommandLFO(string name, bool[] enableOps, byte lfo, byte pan) : base(name) {
			Mode = ModeEnum.Set;
			EnableOps = enableOps;
			LFO = lfo;
			Pan = pan;
		}

		internal override Item Clone() =>new CommandLFO(Name, EnableOps, LFO, Pan);

		internal static new CommandLFO Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.Byte, ArgType.Byte, });
			return res == null ? null : new CommandLFO(name, (byte) res[0], (byte) res[0]);
		}

		internal override void Emit(StreamWriter outs, OptimizerInfo info) {
			int ops = (EnableOps[0] ? 0x80 : 0) | (EnableOps[1] ? 0x40 : 0) | (EnableOps[2] ? 0x20 : 0) | (EnableOps[3] ? 0x10 : 0);
			OptimizeAMPS.EmitMacroRaw(outs, Name, new string[] { Util.ToHex(LFO | (ops), 2), Util.ToHex(Pan, 2) });
			info.LastWasNote = false;
		}

		internal override bool IsSame(Item i) {
			if(!i.GetType().Equals(GetType())) {
				return false;
			}

			CommandLFO c = i as CommandLFO;
			return c.LFO == LFO && c.Pan == Pan && c.EnableOps[0] == EnableOps[0] && c.EnableOps[1] == EnableOps[1] && c.EnableOps[2] == EnableOps[2] && c.EnableOps[3] == EnableOps[3];
		}

		internal override bool IsNop(OptimizerInfo info) {
			return false;
		}

		internal override void Update(OptimizerInfo info) {

		}
	}

	class CommandYM : CommandBase {
		public new readonly string CanonicalName = "sYM";
		public byte Register, Value;

		public CommandYM(string name, byte reg, byte value) : base(name) {
			Mode = ModeEnum.Set;
			Register = reg;
			Value = value;
		}

		internal override Item Clone() => new CommandYM(Name, Register, Value);

		internal static new CommandYM Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.Byte, ArgType.Byte, });
			return res == null ? null : new CommandYM(name, (byte) res[0], (byte) res[1]);
		}

		internal override void Emit(StreamWriter outs, OptimizerInfo info) {
			OptimizeAMPS.EmitMacroRaw(outs, Name, new string[] { Util.ToHex(Register, 2), Util.ToHex(Value, 2) });
			info.LastWasNote = false;
		}

		internal override bool IsNop(OptimizerInfo info) => false;

		internal override void Update(OptimizerInfo info) {
			// TEMP: TODO: FIX
			info.Voice = null;
		}

		internal override bool IsSame(Item i) {
			if (!i.GetType().Equals(GetType())) {
				return false;
			}

			CommandYM c = i as CommandYM;
			return c.Register == Register && c.Value == Value;
		}
	}

	class CommandModSet : CommandBase {
		public new readonly string CanonicalName = "sModAMPS";
		public byte Wait, Speed, Step, Count;

		public CommandModSet(string name, byte wait, byte speed, byte step, byte count) : base(name) {
			Mode = ModeEnum.Set;
			Wait = wait;
			Speed = speed;
			Step = step;
			Count = count;
		}

		internal override Item Clone() => new CommandModSet(Name, Wait, Speed, Step, Count);

		internal static new CommandModSet Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.Byte, ArgType.Byte, ArgType.Byte, ArgType.Byte, });
			return res == null ? null : new CommandModSet(name, (byte) res[0], (byte) res[1], (byte) res[2], (byte) res[3]);
		}

		internal override void Emit(StreamWriter outs, OptimizerInfo info) {
			OptimizeAMPS.EmitMacroRaw(outs, Name, new string[] { Util.ToHex(Wait, 2), Util.ToHex(Speed, 2), Util.ToHex(Step, 2), Util.ToHex(Count, 2) });
			info.LastWasNote = false;
		}

		internal override bool IsNop(OptimizerInfo info) {
			return false;
		}

		internal override void Update(OptimizerInfo info) {
			info.Modulating = true;
		}

		internal override bool IsSame(Item i) {
			if (!i.GetType().Equals(GetType())) {
				return false;
			}

			CommandModSet c = i as CommandModSet;
			return c.Wait == Wait && c.Speed == Speed && c.Step == Step && c.Count == Count;
		}
	}

	/**
	 * Commands that have a routine target as one of the arguments
	 */

	abstract class CommandStringTarget : CommandBase {
		internal string Target;
		internal TargetEnum Type;

		public CommandStringTarget(string name, string target, TargetEnum type) : base(name) {
			Target = target;
			Type = type;
		}

		internal override void Emit(StreamWriter outs, OptimizerInfo info) {
			OptimizeAMPS.EmitMacroRaw(outs, Name, new string[] { Target });
			info.LastWasNote = false;
		}

		internal override bool IsSame(Item i) {
			return i.GetType().Equals(GetType()) && (i as CommandStringTarget).Target == Target;
		}
	}

	class CommandCall : CommandStringTarget {
		public new readonly string CanonicalName = "sCall";

		public CommandCall(string name, string target) : base(name, target, TargetEnum.Routine) {
			IsControlFlow = true;
		}

		internal override bool IsNop(OptimizerInfo info) => false;
		internal override Item Clone() => new CommandCall(Name, Target);

		internal static new CommandCall Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.String, });
			return new CommandCall(name, (string) res[0]);
		}

		internal override void Update(OptimizerInfo info) {
			info.Reset();
		}
	}

	class CommandJump : CommandStringTarget {
		public new readonly string CanonicalName = "sJump";

		public CommandJump(string name, string target) : base(name, target, TargetEnum.Routine) {
			IsEndToken = true;
			IsControlFlow = true;
		}

		internal override bool IsNop(OptimizerInfo info) => false;
		internal override Item Clone() => new CommandJump(Name, Target);

		internal static new CommandJump Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.String, });
			return new CommandJump(name, (string) res[0]);
		}

		internal override void Update(OptimizerInfo info) {
			info.Reset();
		}
	}

	class CommandLoop : CommandStringTarget {
		internal new readonly string CanonicalName = "sLoop";
		internal byte Index, Loops, Current;

		internal CommandLoop(string name, string target, byte index, byte loops) : base(name, target, TargetEnum.Routine) {
			Loops = loops;
			Index = index;
			IsControlFlow = true;
			Current = 0;
		}

		internal override bool IsNop(OptimizerInfo info) => false;
		internal override Item Clone() => new CommandLoop(Name, Target, Index, Loops);

		internal static new CommandLoop Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.Byte, ArgType.Byte, ArgType.String, });
			return res == null ? null : new CommandLoop(name, (string) res[2], (byte) res[0], (byte) res[1]);
		}

		internal override void Emit(StreamWriter outs, OptimizerInfo info) {
			OptimizeAMPS.EmitMacroRaw(outs, Name, new string[] { Util.ToHex(Index, 2), Util.ToHex(Loops, 2), Target });
			info.LastWasNote = false;
		}

		internal override void Update(OptimizerInfo info) {

		}
	}

	class CommandSpecFM3 : CommandStringTarget {
		public new readonly string CanonicalName = "sSpecFM3";
		internal string Target2, Target3;

		public CommandSpecFM3(string name, string target1, string target2, string target3) : base(name, target1, TargetEnum.Routine) {
			Target2 = target2;
			Target3 = target3;
			IsControlFlow = true;
		}

		internal override bool IsNop(OptimizerInfo info) => false;
		internal override Item Clone() => new CommandSpecFM3(Name, Target, Target2, Target3);

		internal static new CommandSpecFM3 Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.String, ArgType.String, ArgType.String, });
			return new CommandSpecFM3(name, (string) res[0], (string) res[1], (string) res[2]);
		}

		internal override void Emit(StreamWriter outs, OptimizerInfo info) {
			OptimizeAMPS.EmitMacroRaw(outs, Name, new string[] { Target, Target2, Target3, });
			info.LastWasNote = false;
		}

		internal override void Update(OptimizerInfo info) {

		}

		internal override bool IsSame(Item i) {
			if (!i.GetType().Equals(GetType())) {
				return false;
			}

			CommandSpecFM3 c = i as CommandSpecFM3;
			return c.Target == Target && c.Target2 == Target2 && c.Target3 == Target3;
		}
	}

	class CommandVoice : CommandStringTarget {
		public new readonly string CanonicalName = "sVoice";

		public CommandVoice(string name, string arg) : base(name, arg, TargetEnum.Voice) {

		}

		internal override Item Clone() => new CommandVoice(Name, Target);

		internal static new CommandVoice Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.String, });
			return res == null ? null : new CommandVoice(name, (string) res[0]);
		}

		internal override bool IsNop(OptimizerInfo info) {
			return info.Voice == Target;
		}

		internal override void Update(OptimizerInfo info) {
			info.Voice = Target;
		}
	}

	class CommandVolEnv : CommandStringTarget {
		public new readonly string CanonicalName = "sVolEnv";

		public CommandVolEnv(string name, string arg) : base(name, arg, TargetEnum.VolumeEnvelope) {

		}

		internal override Item Clone() => new CommandVolEnv(Name, Target);

		internal static new CommandVolEnv Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.String, });
			return res == null ? null : new CommandVolEnv(name, (string) res[0]);
		}

		internal override bool IsNop(OptimizerInfo info) {
			return info.VolEnv == Target;
		}

		internal override void Update(OptimizerInfo info) {
			info.VolEnv = Target;
		}
	}

	class CommandFreqEnv : CommandStringTarget {
		public new readonly string CanonicalName = "sModEnv";

		public CommandFreqEnv(string name, string arg) : base(name, arg, TargetEnum.FrequencyEnvelope) {

		}

		internal override Item Clone() => new CommandFreqEnv(Name, Target);

		internal static new CommandFreqEnv Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.String, });
			return res == null ? null : new CommandFreqEnv(name, (string) res[0]);
		}

		internal override bool IsNop(OptimizerInfo info) {
			return info.ModEnv == Target;
		}

		internal override void Update(OptimizerInfo info) {
			info.ModEnv = Target;
		}
	}

	class CommandPan : CommandStringTarget {
		public new readonly string CanonicalName = "sPan";

		public CommandPan(string name, string arg) : base(name, arg, TargetEnum.Equate) {

		}

		internal override Item Clone() => new CommandPan(Name, Target);

		internal static new CommandPan Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.String, ArgType.Byte | ArgType.Optional, ArgType.Byte | ArgType.Optional, });
			return res == null ? null : new CommandPan(name, (string) res[0]);
		}

		internal override bool IsNop(OptimizerInfo info) {
			return info.Pan == Target;
		}

		internal override void Update(OptimizerInfo info) {
			info.Pan = Target;
		}
	}

	class CommandPortamentoNote : CommandStringTarget {
		public new readonly string CanonicalName = "ssPortaTgtNote";

		public CommandPortamentoNote(string name, string arg) : base(name, arg, TargetEnum.Note) {

		}

		internal override Item Clone() => new CommandPortamentoNote(Name, Target);

		internal static new CommandPortamentoNote Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.String, });
			return res == null ? null : new CommandPortamentoNote(name, (string) res[0]);
		}

		internal override bool IsNop(OptimizerInfo info) {
			return false;
		}

		internal override void Update(OptimizerInfo info) {
			info.PortaTarget = ":" + Target;
		}
	}

	class CommandNoiseSet : CommandStringTarget {
		public new readonly string CanonicalName = "sNoisePSG";

		public CommandNoiseSet(string name, string arg) : base(name, arg, TargetEnum.Equate) {
			Mode = ModeEnum.Set;
		}

		internal override Item Clone() => new CommandNoiseSet(Name, Target);

		internal static new CommandNoiseSet Load(StreamWriter console, string name, string[] arguments) {
			var res = Util.LoadArguments(console, arguments, "+" + name + " ", new ArgType[] { ArgType.String, });
			return res == null ? null : new CommandNoiseSet(name, (string) res[0]);
		}

		internal override bool IsNop(OptimizerInfo info) {
			return info.Noise == Target;
		}

		internal override void Update(OptimizerInfo info) {
			info.Noise = Target;
		}
	}

	/**
	 * Commands that use a "on" or "off" action with no arguments
	 */

	abstract class CommandNoArgument : CommandBase {
		public CommandNoArgument(string name) : base(name) {

		}

		internal override void Emit(StreamWriter outs, OptimizerInfo info) {
			OptimizeAMPS.EmitMacroRaw(outs, Name, new string[0]);
			info.LastWasNote = false;
		}

		internal override bool IsSame(Item i) {
			return i.GetType().Equals(GetType());
		}
	}

	class CommandModOff : CommandNoArgument {
		public new readonly string CanonicalName = "sModOff";

		public CommandModOff(string name) : base(name) {
			Mode = ModeEnum.Off;
		}

		internal override Item Clone() => new CommandModOff(Name);

		internal static new CommandModOff Load(StreamWriter console, string name, string[] arguments) {
			return new CommandModOff(name);
		}

		internal override bool IsNop(OptimizerInfo info) {
			return false;
		}

		internal override void Update(OptimizerInfo info) {
			info.Modulating = false;
		}
	}

	class CommandModOn : CommandNoArgument {
		public new readonly string CanonicalName = "sModOn";

		public CommandModOn(string name) : base(name) {
			Mode = ModeEnum.On;
		}

		internal override Item Clone() => new CommandModOn(Name);

		internal static new CommandModOn Load(StreamWriter console, string name, string[] arguments) {
			return new CommandModOn(name);
		}

		internal override bool IsNop(OptimizerInfo info) {
			return info.Modulating;
		}

		internal override void Update(OptimizerInfo info) {
			info.Modulating = true;
		}
	}

	/**
	 * Commands that have 0 arguments
	 */

	class CommandRet : CommandNoArgument {
		public new readonly string CanonicalName = "sRet";

		public CommandRet(string name) : base(name) {
			IsEndToken = true;
			IsControlFlow = true;
		}

		internal override bool IsNop(OptimizerInfo info) => false;
		internal override Item Clone() => new CommandRet(Name);

		internal static new CommandRet Load(StreamWriter console, string name, string[] arguments) {
			return new CommandRet(name);
		}

		internal override void Update(OptimizerInfo info) {

		}

		// NOTE: Never match sRet with sRet! Danger! Danger!
		internal override bool IsSame(Item i) {
			return false;
		}
	}

	class CommandStop : CommandNoArgument {
		public new readonly string CanonicalName = "sStop";

		public CommandStop(string name) : base(name) {
			IsEndToken = true;
			IsControlFlow = true;
		}

		internal override bool IsNop(OptimizerInfo info) => false;
		internal override Item Clone() => new CommandStop(Name);

		internal static new CommandStop Load(StreamWriter console, string name, string[] arguments) {
			return new CommandStop(name);
		}

		internal override void Update(OptimizerInfo info) {

		}
	}

	class CommandKeyOff : CommandNoArgument {
		public new readonly string CanonicalName = "sKeyOff";

		public CommandKeyOff(string name) : base(name) {

		}

		internal override Item Clone() => new CommandKeyOff(Name);

		internal static new CommandKeyOff Load(StreamWriter console, string name, string[] arguments) {
			return new CommandKeyOff(name);
		}

		internal override bool IsNop(OptimizerInfo info) {
			return info.IsKeyOff;
		}

		internal override void Update(OptimizerInfo info) {
			info.IsKeyOff = true;
		}
	}

	class CommandBackup : CommandNoArgument {
		public new readonly string CanonicalName = "sBackup";

		public CommandBackup(string name) : base(name) {
			IsControlFlow = true;
		}

		internal override bool IsNop(OptimizerInfo info) => false;
		internal override Item Clone() => new CommandBackup(Name);

		internal static new CommandBackup Load(StreamWriter console, string name, string[] arguments) {
			return new CommandBackup(name);
		}

		internal override void Update(OptimizerInfo info) {

		}
	}
}
