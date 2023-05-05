namespace SMPS_maker {
	public class Channel : Node {
		public Channels ch { get; }
		public bool IsDAC { get; set; }
		public byte vol { get; set; }
		public byte pitch { get; set; }
		public byte volenv { get; set; }
		public byte modenv { get; set; }

		public Channel(Channels ch, string name) : base() {
			this.ch = ch;
			Name = name;
		}

		public Channel(Channels ch, byte vol, byte pitch) : base() {
			this.ch = ch;
			this.vol = vol;
			this.pitch = pitch;
		}

		public Channel(Channels ch, byte vol, byte pitch, byte volenv, byte modenv) : base() {
			this.ch = ch;
			this.vol = vol;
			this.pitch = pitch;
			this.volenv = volenv;
			this.modenv = modenv;
		}

		public override string GetName() {
			return Name;
		}

		public override bool SetName(string n) {
			Name = n;
			return true;
		}
	}
}