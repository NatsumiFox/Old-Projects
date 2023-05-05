namespace SMPS_maker {
	public class Target {
		internal Element a;
		public string Name { get; set; }

		public Target(Element e) {
			a = e;
			Name = "";
		}

		public virtual Element GetTarget() {
			return a;
		}
	}
}