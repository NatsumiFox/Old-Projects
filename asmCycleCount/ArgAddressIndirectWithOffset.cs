﻿namespace asmCycleCount {
	internal class ArgAddressIndirectWithOffset : ArgumentPart {
		private string data;
		private int lnum;
		private char size;

		public ArgAddressIndirectWithOffset(int lnum, string data, char size) {
			this.size = size;
			this.lnum = lnum;
			this.data = data;
		}

		public override uint getByteCount() {
			return 2;
		}

		public override bool hasCycles() {
			return true;
		}

		public override uint getCycles() {
			switch (size) {
				case 'b':case '1':case 'w':case '2':case '\0':
					return 8;

				case 'l':case '4':
					return 12;

				default:
					Window.ShowParseError(lnum, "Could not recognize instruction size '" + size + "'!\nParsing will now terminate.", "Error!");
					return 0;
			}
		}

		public override uint getReadCycles() {
			switch (size) {
				case 'b':case '1':case 'w':case '2':case '\0':
					return 2;

				case 'l':case '4':
					return 3;

				default:
					Window.ShowParseError(lnum, "Could not recognize instruction size '" + size + "'!\nParsing will now terminate.", "Error!");
					return 0;
			}
		}

		public override uint getWriteCycles() {
			return 0;
		}

		public override string getLine() {
			return data;
		}
	}
}