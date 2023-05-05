namespace SMPS_maker {
	public class SMPScmdJump : Command {
		private Target target;

		public SMPScmdJump(Target target) : base("smpsJump", Actions.TargetRoutineAndEnd, Channels.chAll) {
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