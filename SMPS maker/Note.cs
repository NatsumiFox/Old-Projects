namespace SMPS_maker {
	internal class Note : Element {
		public int Delay { get; set; }
		public int Data { get; set; }
		public bool Attack { get; set; }

		public Note(int delay, int note, bool attack) {
			this.Delay = delay;
			this.Data = note;
			this.Attack = attack;
		}
	}
}