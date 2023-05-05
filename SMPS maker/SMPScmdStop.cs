using System;

namespace SMPS_maker {
	internal class SMPScmdStop : Command {
		public SMPScmdStop() : base("smpsStop", Actions.EndTrack, Channels.chAll) {

		}

		internal override string args() {
			return "";
		}
	}
}