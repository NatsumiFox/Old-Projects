﻿namespace asmCycleCount {
	internal class Chk : GenericInstruction {
		public Chk(int lnum, uint tabs, ArgumentPart[] parts) : base(lnum, tabs, parts) {
			if (!checkArgNums()) {
				return;
			}

			if (ArgEnum.get(parts[1]).Type != typeof(ArgDataDirect)) {
				Window.ShowParseError(lnum, "Argument 2 must be a data register, but is '" + parts[1] + "' instead!\nParsing will now terminate.", "Error!");
			}
		}

		public override string getInsName() {
			return "chk";
		}

		public override char getInsSize() {
			return '\0';
		}

		public override uint getArgNum() {
			return 2;
		}

		public override uint getBytesCount() {
			return 2;
		}

		public override bool overridesCycles() {
			return false;
		}

		public override uint getCycleCount() {
			return 10;
		}

		public override uint getReadCycleCount() {
			return 1;
		}

		public override uint getWriteCycleCount() {
			return 0;
		}

		public override string getNote() {
			return "";
		}
	}
}