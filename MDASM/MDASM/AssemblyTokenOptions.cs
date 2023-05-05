using System;
using System.Collections.Generic;

namespace MDASM {
	public class AssemblyTokenOptions : AssemblyTokenEquate {
		public AssemblyTokenOptions(string Name) : base(Name, 0, EquateFlags.Locked) {
			Value = CalculateValue();
		}

		public override AssemblyToken Solve(out TokenState state) {
			state = TokenState.Dynamic;
			Value = CalculateValue();
			return this;
		}

		private dynamic CalculateValue() {
			return new dynamic[] {
				// assembly options
				AlignByte,
				PackBits(AutomaticEvens),

				// cpu options
				Processor.ToString(),
				Alignment,
				PackBits(UndocZ80),

				// optimizations
				PackBits(OptZeroOffset, OptAddqSubq, OptMoveq, OptClear, OptAddrImm, OptInefficient, OptBranch, OptShortAddr, OptPCRelative),
			};
		}

		private int PackBits(params bool[] bits) {
			int ret = 0;

			for (int i = 0;i < bits.Length;i++)
				if (bits[i])
					ret |= 1 << i;

			return ret;
		}

		public List<OptionsFlags> OptionsFlags = new List<OptionsFlags>() {
			// assembly options
			new OptionsFlags(new string[]{ "AUTOMATICEVENS", "AE" }, typeof(double), (value, opts) => opts.AutomaticEvens = value != 0),
			new OptionsFlags(new string[]{ "ALIGNBYTE", "AB" }, typeof(double), (value, opts) => opts.AlignByte = (byte)value),

			// cpu flags
			new OptionsFlags(new string[]{ "Z80UNDOC", "ZUI" }, typeof(double), (value, opts) => opts.UndocZ80 = value != 0),

			// optimizations
			new OptionsFlags(new string[]{ "O_ZEROOFFSET", "OZO" }, typeof(double), (value, opts) => opts.OptZeroOffset = value != 0),
			new OptionsFlags(new string[]{ "O_ADDQSUBQ", "OAS" }, typeof(double), (value, opts) => opts.OptAddqSubq = value != 0),
			new OptionsFlags(new string[]{ "O_ADDRIMM", "OAI" }, typeof(double), (value, opts) => opts.OptShortAddr = value != 0),
			new OptionsFlags(new string[]{ "O_SBRANCH", "OSB" }, typeof(double), (value, opts) => opts.OptBranch = value != 0),
			new OptionsFlags(new string[]{ "O_PCADDR", "OPA" }, typeof(double), (value, opts) => opts.OptPCRelative = value != 0),
			new OptionsFlags(new string[]{ "O_SADDR", "OSA" }, typeof(double), (value, opts) => opts.OptShortAddr = value != 0),
			new OptionsFlags(new string[]{ "O_INEFF", "OIE" }, typeof(double), (value, opts) => opts.OptInefficient = value != 0),
			new OptionsFlags(new string[]{ "O_MOVEQ", "OMQ" }, typeof(double), (value, opts) => opts.OptMoveq = value != 0),
			new OptionsFlags(new string[]{ "O_MVCLR", "OMC" }, typeof(double), (value, opts) => opts.OptClear = value != 0),
		};

		public static Tuple<TokenState, AssemblyToken> Macro(AssemblyTokenMacroRef Ref) {
			if (Ref.Arguments.Count <= 0)
				Program.FormatError("Incorrect number of arguments (" + Ref.Arguments.Count + "): Call with " +
					InternalMacros.ConvertArgStr(Ref.Name, new string[] { "flag", "value" }, new Type[][] { new Type[] { typeof(string) }, new Type[0] }) + " (last required argument is flag)");

			if(!(Ref.Arguments[0] is string))
				Program.FormatError("Argument text could not be converted to a value! (" + Ref.Arguments.Count + "): Call with " +
					InternalMacros.ConvertArgStr(Ref.Name, new string[] { "flag", "value" }, new Type[][] { new Type[] { typeof(string) }, new Type[0] }) + " (last required argument is flag)");

			TokenState state = TokenState.Dynamic;
			string cmp = (Ref.Arguments[0] as string).ToUpperInvariant();
			dynamic val = null;

			if (cmp.StartsWith("+")) {
				cmp = cmp.Substring(1);
				val = 1;

			} else if (cmp.StartsWith("-")) {
				cmp = cmp.Substring(1);
				val = 0;
			}

			foreach (OptionsFlags of in Program.Options.OptionsFlags) {
				// check if string matches any
				for(int i = 0;i < of.Names.Length;i ++)
					if(of.Names[i] == cmp) {

						// found valid, check if we can execute it
						if(val == null)
							val = InternalMacros.ConvertArguments("option", new List<string>() { Ref.Arguments[1] }, new string[] { "value" }, new Type[][] { new Type[] { of.Type } }, out state)[0];

						// all ready to go, doeet
						of.Code(val, Program.Options);
						return new Tuple<TokenState, AssemblyToken>(state, null);
					}
			}

			Program.FormatError("Option " + cmp + " does not exist!");
			return new Tuple<TokenState, AssemblyToken>(state, null);
		}

		public void SetCPU(Processor cpu) {
			ClearInstructions(Processor);
			Processor = cpu;

			switch (cpu) {
				case Processor.NOCPU:
					Alignment = 1;
					BigEndian = true;
					break;

				case Processor.MC68000:
					Alignment = 2;
					BigEndian = true;
					M68k.CreateInstructions();
					break;

				case Processor.Z80:
					Alignment = 1;
					BigEndian = false;
					Z80.CreateInstructions();
					break;

				case Processor.SH2:
					Alignment = 1;
					BigEndian = true;
					break;
			}
		}

		private void ClearInstructions(Processor cpu) {
			switch (cpu) {
				case Processor.MC68000:
					foreach (AssemblyTokenMacroInternal m in M68k.Instructions)
						Program.DelEquate(m);
					break;

				case Processor.Z80:
					foreach (AssemblyTokenMacroInternal m in Z80.Instructions)
						Program.DelEquate(m);
					break;

				case Processor.SH2:
					break;
			}
		}

		// assembly options
		public byte AlignByte = 0xFF;				// what byte to use for alignments
		public int Alignment = 2;					// to how many bytes word or longword operations should be aligned. Internal.
		public bool AutomaticEvens = true;			// if even should bee inserted for cpu's that require address alignment
		public bool BigEndian = true;				// if system is big endian

		// cpu-related things
		public Processor Processor = Processor.NOCPU;// current processor equate. May be needed somewhere.
		public bool UndocZ80 = false;				// if enabled, undocumented instructions for Z80 are enabled

		// optimization options. Things higher in the list should always take precedence
		public bool OptZeroOffset = true;			// 0(a0) -> (a0)
		public bool OptAddqSubq = true;				// add.b #8,d0 -> addq.b #8,d0
		public bool OptMoveq = true;				// move.l #0,d0 -> moveq #0,d0
		public bool OptClear = false;				// move.w #0,(a0) -> clr.w (a0)		-> Author's note: This is dangerous for VDP operations, therefore disabled by default	
		public bool OptAddrImm = true;				// move.l #123,a0 -> move.w #123,a0, adda.l #-123,a0 -> adda.w #-123,a0
		public bool OptInefficient = true;			// cmp.w #0,(a0) -> tst.w (a0) & add.w #0,d0 -> <nothing> && and.w #$FFFF,d0 -> <nothing> <- basically everything here that is not mentioned elsewhere
		public bool OptBranch = true;				// bra.w pc+8 -> bra.s pc+8			-> Author's note: This is dangerous for jump tables, therefore disabled by default
		public bool OptShortAddr = true;			// $1234.l -> $1234.w
		public bool OptPCRelative = true;			// pc+$100.l -> $100(pc)
	}

	public enum Processor {
		NOCPU = -1,
		Z80 = 0,
		SH2 = 0x10,
		MC68000 = 0x1000,
	}

	public struct OptionsFlags {
		public Action<dynamic, AssemblyTokenOptions> Code;
		public string[] Names;
		public Type Type;

		public OptionsFlags(string[] Names, Type Type, Action<dynamic, AssemblyTokenOptions> Code) {
			this.Names = Names;
			this.Type = Type;
			this.Code = Code;
		}
	}
}