using System;

namespace SMPS_maker {
	internal class SMPScmdReturn : Command {
		public SMPScmdReturn() : base("smpsReturn", Actions.EndRoutine, Channels.chAll) {

		}

		internal override string args() {
			return "";
		}
	}
}