// =============================================================================
// -----------------------------------------------------------------------------
// Program
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <windows.h>

int Offsets [] = {
			0x45B5E5, 0x200000,
			0x45B74D, 0x200000,
			0x45B843, 0x200000,
			0x476000, 0x200000,
			0x476007, 0x200000, // ??? 63FFFF
			0x47611A, 0x200000,
			0x476121, 0x200000, // ??? 63FFFF
			0x476215, 0x200000,
			0x47640E, 0x200000,
			0x476415, 0x200000, // ??? 63FFFF
			0x4764EF, 0x200000,







			0x44387E, 0x400000,
			0x443B68, 0x400000,
			0x443B91, 0x400000,	// DMA Source - This is a 3FFFFF AND value, not required for the ROM, but because RAM DMA requires AND'ing, this is needed for the same subroutine
			0x455FFD, 0x400000,
			0x45721D, 0x400000,
			0x45B428, 0x400000,
			0x45B461, 0x400000,
			0x45B63D, 0x400000,
			0x45B64E, 0x400000,
			0x45B66A, 0x400000,
			0x45B7B6, 0x400000,
			0x45B7C7, 0x400000,
			0x45B7E3, 0x400000,
			0x45B8C5, 0x400000,
			0x45B8D6, 0x400000,
			0x45B8FE, 0x400000,
			0x45BB94, 0x400000,
			0x45BBA0, 0x400000,
			0x45BEF0, 0x400000,
			0x45C0F7, 0x400000,
			0x45C132, 0x400000, // ???
			0x45C14A, 0x400000,
			0x45C151, 0x400000,
			0x45C16D, 0x400000, // ???
			0x46EA8B, 0x400000,
			0x46EC33, 0x400000,
			0x46ECDD, 0x400000,
			0x46EF3F, 0x400000,
			0x46F114, 0x400000,
			0x46F30C, 0x400000,
			0x46F570, 0x400000,
			0x46F7A4, 0x400000,
			0x472020, 0x400000, // ??? 400007
			0x472028, 0x400000, // ???
			0x472052, 0x400000,
			0x47265B, 0x400000,
			0x475FD0, 0x400000,
			0x475FD7, 0x400000, // ??? 41FFFF
			0x475FE0, 0x400000,
			0x475FE8, 0x400000, // ??? 420000
			0x475FF0, 0x400000, // ??? 43FFFF
			0x475FF8, 0x400000, // ???
			0x476010, 0x400000, // ???
			0x4760EA, 0x400000,
			0x4760F1, 0x400000, // ??? 41FFFF
			0x4760FA, 0x400000,
			0x476102, 0x400000, // ??? 420000
			0x476109, 0x400000, // ??? 43FFFF
			0x476112, 0x400000, // ???
			0x47612A, 0x400000, // ???
			0x4763F6, 0x400000, // ??? 420000
			0x4763FD, 0x400000, // ??? 43FFFF
			0x476406, 0x400000, // ???
			0x47641E, 0x400000, // ???
			0x47B71D, 0x400000,
			0x47B772, 0x400000,
			0x47B960, 0x400000,
			0x47BC96, 0x400000,
			0x47D471, 0x400000,
			0x47D4FE, 0x400000,
			0x47D517, 0x400000,
			0x47D5A4, 0x400000,
			0x47D5F5, 0x400000,
			0x47D644, 0x400000,
			0x47D693, 0x400000,
			0x47D6BF, 0x400000,
			0x4C398D, 0x400000,

		// These are extra AND 3FFFFF's which wrap along with the 68k ROM address
		// These "might" be for 32x/Mega CD though, so allow them with caution!!!

		//	0x4CA662, 0x400000,
		//	0x4CABE5, 0x400000,
		//	0x4CB0A5, 0x400000,
		//	0x4CB4E5, 0x400000,
		//	0x4CC58B, 0x400000,

		// I believe these relative offset accesses are related to the program's address
		// and not the 68k ROM's virtual address (just coincidence I guess, but the
		// addresses are here anyway, just in-case

		//	0x4D255D, 0x400000,	// These below are relative offsets...  Not sure if should be tampered
		//	0x4D2566, 0x400000,
		//	0x4D256C, 0x400000,
		//	0x4D2579, 0x400000,
		//	0x4D2583, 0x400000,
		//	0x4D258E, 0x400000,


		//	0x4DAFD0 ??? Few 400000's here, but I am not sure if they are ROM access based....

			0x00000000 };

// =============================================================================
// -----------------------------------------------------------------------------
// Subroutine to alter the offsets in the ROM using a list
// -----------------------------------------------------------------------------

void AlterOffsets (char *Memory)

{
	int Value;
	int OffLoc = 0;
	while (Offsets [OffLoc] != 0)
	{
		int Loc = Offsets [OffLoc++];
		Value = Memory [Loc+0x00] & 0xFF;
		Value |= (Memory [Loc+0x01] & 0xFF) << 0x08;
		Value |= (Memory [Loc+0x02] & 0xFF) << 0x10;
		Value |= (Memory [Loc+0x03] & 0xFF) << 0x18;
		Value += Offsets [OffLoc++];
		Memory [Loc+0x00] = Value >> 0x00;
		Memory [Loc+0x01] = Value >> 0x08;
		Memory [Loc+0x02] = Value >> 0x10;
		Memory [Loc+0x03] = Value >> 0x18;
	}
}

// =============================================================================
// -----------------------------------------------------------------------------
// Subroutine to change string offsets
// -----------------------------------------------------------------------------

void ChangeStrings (char *Memory)

{
	// Editing "About" text...

	int MemoryLoc = 0x5B6BE5;
	int InputLoc = 0x5B6C52;
	MemoryLoc += snprintf (&Memory [MemoryLoc], InputLoc - MemoryLoc, "Special version for emulating 8MB Mega Drive ROMS\naltered by MarkeyJester 2018");
	while (InputLoc < 0x5B6E4C)
	{
		Memory [MemoryLoc++] = Memory [InputLoc++];
	}

	// Editing "Fusion 3.64 "

	Memory [0x45C3EA] = MemoryLoc;
	Memory [0x45C3EB] = MemoryLoc >> 0x08;
	Memory [0x45C3EC] = MemoryLoc >> 0x10;
	Memory [0x45C3ED] = MemoryLoc >> 0x18;

	MemoryLoc += snprintf (&Memory [MemoryLoc], InputLoc - MemoryLoc, "Fusion8 3.64 ");
}

// =============================================================================
// -----------------------------------------------------------------------------
// Subroutine alter the colours of an icon
// -----------------------------------------------------------------------------

void EditIcon (char *Memory, int MemoryLoc, int MemoryEnd)

{
	while (MemoryLoc < MemoryEnd)
	{
		int Red = Memory [MemoryLoc+0] & 0xFF;
		int Green = Memory [MemoryLoc+1] & 0xFF;
		int Blue = Memory [MemoryLoc+2] & 0xFF;

		Blue += 0x80;
		if (Blue > 0xFF)
		{
			Blue = 0xFF;
		}

		Red -= 0x20;
		if (Red < 0x00)
		{
			Red = 0x00;
		}

		Memory [MemoryLoc+0] = Red;
		Memory [MemoryLoc+1] = Green;
		Memory [MemoryLoc+2] = Blue;

		MemoryLoc += 4;
	}
}

// -----------------------------------------------------------------------------
// Subroutine to edit the icons
// -----------------------------------------------------------------------------

void ReplaceIcon (char *Memory)

{
	EditIcon (Memory, 0x698408, 0x6984F0);
	EditIcon (Memory, 0x698970, 0x698D6C);
	EditIcon (Memory, 0x699218, 0x69960C);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Writing the actual extension string itself
// -----------------------------------------------------------------------------

void WriteExt (const char *String, char *Memory, int Offset)

{
	char Byte = *String++;
	while (Byte != 0x00)
	{
		Memory [Offset++] = Byte;
		Byte = *String++;
	}
}

// -----------------------------------------------------------------------------
// Subroutine to replace the .bin extension for .MDX
// -----------------------------------------------------------------------------

void EditEXT (char *Memory)

{
	WriteExt (".mdx", Memory, 0x4E74F4);
	WriteExt (".mdx", Memory, 0x4E7359+1);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Main Routine
// -----------------------------------------------------------------------------

int main (int ArgNumber, char **ArgList, char **EnvList)

{
	FILE *File = fopen ("Fusion.exe", "rb");
	if (File == NULL)
	{
		printf ("Could not open \"Fusion.exe\"\n");
		fflush (stdin); getchar ( ); return (0x00);
	}
	fseek (File, 0x00, SEEK_END);
	int MemoryLoc = 0x400000;
	int MemorySize = MemoryLoc + ftell (File);
	char *Memory = (char*) malloc (MemorySize);
	if (Memory == NULL)
	{
		fclose (File);
		printf ("Could not allocate memory for \"Fusion.exe\"\n");
		fflush (stdin); getchar ( ); return (0x00);
	}
	rewind (File);
	while (MemoryLoc < MemorySize)
	{
		Memory [MemoryLoc++] = fgetc (File);
	}
	fclose (File);

	AlterOffsets (Memory);
	ChangeStrings (Memory);
	ReplaceIcon (Memory);
	EditEXT (Memory);

	File = fopen ("Fusion8.exe", "wb");
	if (File == NULL)
	{
		free (Memory); Memory = NULL;
		printf ("Could not create \"Fusion8.exe\"\n");
		fflush (stdin); getchar ( ); return (0x00);
	}
	MemoryLoc = 0x400000;
	while (MemoryLoc < MemorySize)
	{
		fputc (Memory [MemoryLoc++], File);
	}
	fclose (File);
	free (Memory); Memory = NULL;
}

// =============================================================================
