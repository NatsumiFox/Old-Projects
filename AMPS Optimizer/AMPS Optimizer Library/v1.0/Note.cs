using System.Collections.Generic;
using System.IO;

namespace OptimizerLibrary.v1_0 {
	internal class Note : CommandBase {
		public new readonly string CanonicalName = "dc.b";
		public uint? Delay;

		public Note(string name, string delay) : base(name) {
			if(delay.Trim().Length == 0) {
				// no delay added
				Delay = null;

			} else {
				// parse delay as uint
				Util.ArgToUint(delay, out uint _delay);
				Delay = _delay;
			}
		}

		public Note(string name, uint? delay) : base(name) {
			Delay = delay;
		}

		internal override Item Clone() {
			return new Note(Name, Delay);
		}

		internal override void Emit(StreamWriter outs, OptimizerInfo info) {
			List<string> write = new List<string>();
			bool isRest = false, isHold = Name.ToLowerInvariant() == "shold";

			if (Name.Length > 0 && (isHold || info.LastWasNote || info.Level == 0 || Delay == null || Name.ToLowerInvariant() != info.LastNote)) {
				if(!isHold) info.LastNote = Name.ToLowerInvariant();
				write.Add(Name);
				isRest = info.LastNote == "nrst" && info.Level > 0;
				info.LastWasNote = true;
			}

			if (Delay != null && (isHold || info.Level == 0 || Name.Length == 0 || write.Count == 0 || info.LastDelay != Delay)) {
				// calculate actual delay, adding holds when needed
				uint _delay = (uint)Delay;

				while(_delay > 0x7F) {
					write.Add("$7F");
					if(!isRest) write.Add("sHold");
					_delay -= 0x7F;
				}

				write.Add(Util.ToHex(_delay, 2));
				info.LastDelay = _delay;
				info.LastWasNote = false;
			}

			OptimizeAMPS.EmitMacroRaw(outs, CanonicalName, write.ToArray());
		}

		internal override bool IsNop(OptimizerInfo info) => false;

		internal override void Update(OptimizerInfo info) {
			if (Name.Length > 0) info.LastNote = Name;
			if (Delay != null) info.LastDelay = Delay;
		}

		internal override bool IsSame(Item i) {
			if (!i.GetType().Equals(GetType())) {
				return false;
			}

			Note c = i as Note;
			return c.Name == Name && c.Delay == Delay;
		}
	}
}
