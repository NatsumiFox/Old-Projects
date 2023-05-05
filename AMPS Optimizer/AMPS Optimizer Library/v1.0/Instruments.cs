using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace OptimizerLibrary.v1_0 {
	internal struct VoiceOperator {
		internal byte? Detune, Multiple, RateScale;
		internal byte? AttackRate, SustainRate, DecayRate;
		internal byte? SustainLevel, ReleaseRate, TotalLevel;
		internal byte SSGEG;
		internal bool AmpMod;
	}

	internal class Voice {
		public byte? Algorithm, FeedBack;
		public VoiceOperator[] Operators;

		internal Voice() {
			Algorithm = null;
			Operators = new VoiceOperator[] {
				new VoiceOperator(),
				new VoiceOperator(),
				new VoiceOperator(),
				new VoiceOperator(),
			};
		}

		internal bool Command(StreamWriter console, string command, string[] arguments) {
			// try to convert arguments to uint
			if (!Util.ArgListToUint(arguments, 0, out uint[] args)) {
				return OptimizeAMPS.Error(console, "Unable to convert the arguments to numbers: -" + command + " " + string.Join(' ', arguments));
			}

			switch (command) {
				case "spalgorithm":
					if (args.Length != 1) {
						return OptimizeAMPS.Error(console, "Expected to get 1 argument for command: -" + command + " " + string.Join(' ', arguments));
					}

					Algorithm = (byte) args[0];
					return true;

				case "spfeedback":
					if (args.Length != 1) {
						return OptimizeAMPS.Error(console, "Expected to get 1 argument for command: -" + command + " " + string.Join(' ', arguments));
					}

					FeedBack = (byte) args[0];
					return true;

				case "spdetune": return UpdateOperatorValue(console, command, arguments, args, (int o, byte val) => Operators[o].Detune = val);
				case "spmultiple": return UpdateOperatorValue(console, command, arguments, args, (int o, byte val) => Operators[o].Multiple = val);
				case "spratescale": return UpdateOperatorValue(console, command, arguments, args, (int o, byte val) => Operators[o].RateScale = val);
				case "spattackrt": return UpdateOperatorValue(console, command, arguments, args, (int o, byte val) => Operators[o].AttackRate = val);
				case "spampmod": return UpdateOperatorValue(console, command, arguments, args, (int o, byte val) => Operators[o].AmpMod = val != 0);
				case "spsustainrt": return UpdateOperatorValue(console, command, arguments, args, (int o, byte val) => Operators[o].SustainRate = val);
				case "spdecayrt": return UpdateOperatorValue(console, command, arguments, args, (int o, byte val) => Operators[o].DecayRate = val);
				case "spsustainlv": return UpdateOperatorValue(console, command, arguments, args, (int o, byte val) => Operators[o].SustainLevel = val);
				case "spreleasert": return UpdateOperatorValue(console, command, arguments, args, (int o, byte val) => Operators[o].ReleaseRate = val);
				case "spssgeg": return UpdateOperatorValue(console, command, arguments, args, (int o, byte val) => Operators[o].SSGEG = val);

				case "sptotallv":
				case "sptotallv2":
					return UpdateOperatorValue(console, command, arguments, args, (int o, byte val) => Operators[o].TotalLevel = val);
			}

			return OptimizeAMPS.Error(console, "Wtf unable to process " + command);
		}

		// helper function for updating all operator values
		internal bool UpdateOperatorValue(StreamWriter console, string command, string[] arguments, uint[] args, Func<int, byte, object> func) {
			if (args.Length != 4) {
				return OptimizeAMPS.Error(console, "Expected to get 4 arguments for command: -" + command + " " + string.Join(' ', arguments));
			}

			// run each operator
			for (int i = 0; i <= 3; i++) {
				func(i, (byte) args[i]);
			}

			return true;
		}

		// verify the voice is in a valid state
		internal bool Verify(StreamWriter console, string name) {
			// just check for nulls
			if (Algorithm == null || FeedBack == null) {
				return OptimizeAMPS.Error(console, "Voice '" + name + "' did not update feedback or algorithm!");
			}

			for (int i = 1; i <= 4; i++) {
				// check each operator
				var op = Operators[i - 1];

				if (op.TotalLevel == null) return OptimizeAMPS.Error(console, "Voice '" + name + "' did not update total level!");
				if (op.ReleaseRate == null) return OptimizeAMPS.Error(console, "Voice '" + name + "' did not update release rate!");
				if (op.SustainLevel == null) return OptimizeAMPS.Error(console, "Voice '" + name + "' did not update sustain level!");
				if (op.DecayRate == null) return OptimizeAMPS.Error(console, "Voice '" + name + "' did not update decay rate!");
				if (op.SustainRate == null) return OptimizeAMPS.Error(console, "Voice '" + name + "' did not update sustain rate!");
				if (op.AttackRate == null) return OptimizeAMPS.Error(console, "Voice '" + name + "' did not update attack rate!");
				if (op.RateScale == null) return OptimizeAMPS.Error(console, "Voice '" + name + "' did not update rate scale!");
				if (op.Multiple == null) return OptimizeAMPS.Error(console, "Voice '" + name + "' did not update multiple!");
				if (op.Detune == null) return OptimizeAMPS.Error(console, "Voice '" + name + "' did not update detune!");
			}

			return true;
		}

		// emit the voice
		internal void Emit(StreamWriter outs, string name) {
			outs.WriteLine("\t; Voice " + name);
			OptimizeAMPS.EmitMacroRaw(outs, "spAlgorithm", new string[] { Util.ToHex((byte) Algorithm, 2) });
			OptimizeAMPS.EmitMacroRaw(outs, "spFeedback", new string[] { Util.ToHex((byte) FeedBack, 2) });

			OptimizeAMPS.EmitMacroRaw(outs, "spDetune", GetOpArgs((int o) => Operators[o].Detune));
			OptimizeAMPS.EmitMacroRaw(outs, "spMultiple", GetOpArgs((int o) => Operators[o].Multiple));
			OptimizeAMPS.EmitMacroRaw(outs, "spRateScale", GetOpArgs((int o) => Operators[o].RateScale));
			OptimizeAMPS.EmitMacroRaw(outs, "spAttackRt", GetOpArgs((int o) => Operators[o].AttackRate));
			OptimizeAMPS.EmitMacroRaw(outs, "spAmpMod", GetOpArgs((int o) => Operators[o].AmpMod ? 1 : 0));
			OptimizeAMPS.EmitMacroRaw(outs, "spSustainRt", GetOpArgs((int o) => Operators[o].SustainRate));
			OptimizeAMPS.EmitMacroRaw(outs, "spDecayRt", GetOpArgs((int o) => Operators[o].DecayRate));
			OptimizeAMPS.EmitMacroRaw(outs, "spSustainLv", GetOpArgs((int o) => Operators[o].SustainLevel));
			OptimizeAMPS.EmitMacroRaw(outs, "spReleaseRt", GetOpArgs((int o) => Operators[o].ReleaseRate));
			OptimizeAMPS.EmitMacroRaw(outs, "spSSGEG", GetOpArgs((int o) => Operators[o].SSGEG));
			OptimizeAMPS.EmitMacroRaw(outs, "spTotalLv", GetOpArgs((int o) => Operators[o].TotalLevel));
		}

		// function to get the 4 operator values as arguments to macros
		private string[] GetOpArgs(Func<int, int?> func) {
			string[] ret = new string[4];

			// loop for all ops
			for(int i = 0;i < 4;i ++) {
				ret[i] = Util.ToHex((byte) func(i), 2);
			}

			return ret;
		}
	}
}
