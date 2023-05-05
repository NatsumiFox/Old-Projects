using System;

namespace SMPS_maker {
	public class SMPScmdCall : Command {
		private Target target;

		public SMPScmdCall(Target target) : base("smpsCall", Actions.TargetRoutine, Channels.chAll) {
			this.target = target;
		}

		internal override string args() {
			return target.Name;
		}

		internal Target getTarget() {
			return target;
		}
	}
}