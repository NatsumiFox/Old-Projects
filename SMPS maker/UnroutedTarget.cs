namespace SMPS_maker {
	internal class UnroutedTarget : Target {
		public UnroutedTarget(string e) : base(null) {
			Name = e;
		}

		public override Element GetTarget() {
			if(a != null) return a;
			a = MainWindow.smps.FindTarget(Name);
			return a;
		}
	}
}