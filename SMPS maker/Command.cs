using System;

namespace SMPS_maker {
	public abstract class Command : Element {
		public string cmd;
		public Channels comp { get; }
		public Actions action { get; }

		public Command(string command) {
			cmd = command;
		}

		public Command(string command, Actions action) : this(command) {
			this.action = action;
		}

		public Command(string command, Actions action, Channels compatability) : this(command, action) {
			this.comp = compatability;
		}

		public string print() {
			return "\t" + cmd + '\t' + args();
		}

		internal abstract string args();
	}
}