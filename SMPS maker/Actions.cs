using System;

namespace SMPS_maker {
	[Flags]
	public enum Actions : long {
		Target = 0x2,
		End = 0x1,
		Track = 0x1000,
		Routine = 0x2000,
		EndTrack = End|Track,
		EndRoutine = End|Routine,
		TargetRoutine = Target|Routine,
		TargetRoutineAndEnd = Target | End | Routine,
		Add = 0x1,
		Sub = 0x2,
		Set = 0x3,
		Volume = 0x10000,
		Note = 0x20000,
		Pan = 0x30000,
		Pitch = 0x40000,
		TickMult = 0x50000,
		Tempo = 0x60000,
		Voice = 0x70000,
		VolEnv = 0x80000,
		ModEnv = 0x90000,
	}
}