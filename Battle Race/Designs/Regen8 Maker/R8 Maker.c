// =============================================================================
// -----------------------------------------------------------------------------
// Program
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <windows.h>

int Offsets [] = {
			0x408BDC, 0x300000,
			0x408BF4, 0x300000,
			0x408C4A, 0x400000,

			0x40DEE9, 0x400000,
			0x40DEF8, 0x400000,

			0x40DFEC, 0x400000,
			0x40DFFB, 0x400000,

			0x40DAC8, 0x400000, // ??? Not sure, jb is used in the check here...
			0x40E1C7, 0x400000, // ??? There's a 7FFFFF set after...


		//	0x47FFD9, 0x400000, // only checks the bit of 400000 (so if 400000 - 7FFFFF).
		//	0x480189, 0x400000, // ''
		//	0x4808C4, 0x400000, // ''
		//	0x4809BD, 0x400000, // ''
		//	0x480DDc, 0x400000, // ''
		//	0x480F0B, 0x400000, // ''
		//	0x48118D, 0x400000, // ''
		//	0x481521, 0x400000, // ''
		//	0x481644, 0x400000, // ''
		//	0x481727, 0x400000, // ''
		//	0x48181F, 0x400000, // ''
		//	0x486711, 0x400000, // ''



		//	0x49C9C3, 0x400000, // ??? AND related jump
		//	0x49C9D1, 0x200000, // '' same but 600000 instead of 400000
		//	0x4A1827, 0x400000, // ''
		//	0x4A1835, 0x400000, // ''
		//	0x4A1857, 0x400000, // ''



		//	0x48567B, 0x400000, // ??? This is moved into a relative address of edx
		//	0x4856C1, 0x400000, // ''
		//	0x485DED, 0x400000, // ''
		//	0x485E39, 0x400000, // ''
		//	0x485EBA, 0x400000, // ''
		//	0x485F06, 0x400000, // ''
		//	0x485F87, 0x400000, // ''
		//	0x485FD3, 0x400000, // ''
		//	0x486054, 0x400000, // ''
		//	0x4860A0, 0x400000, // ''
		//	0x486121, 0x400000, // ''
		//	0x48616D, 0x400000, // ''
		//	0x4861EE, 0x400000, // ''
		//	0x48623A, 0x400000, // ''
		//	0x4862BB, 0x400000, // ''
		//	0x486307, 0x400000, // ''
		//	0x486388, 0x400000, // ''
		//	0x4863D4, 0x400000, // ''
		//	0x486455, 0x400000, // ''
		//	0x4864A1, 0x400000, // ''

		//	0x496628, 0x400000, // ??? Special test against relative address of ebx (with a jz/jnz following)
		//	0x49CB22, 0x400000, // ''
		//	0x529E1A, 0x400000, // ''

		//	0x49CC3F, 0x400000, // an OR setting of 400000

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
// Subroutine to alter pointers in the ROM
// -----------------------------------------------------------------------------

int Routines [] = {
			0x52EA10, 	// DMA offset routine table
			0x52EA30,	// ??? offset routine table (I think 68k but not sure).
			0x52F410,	// DMA offset routine table
			0x52F430,	// ??? offset routine table (I think 68k but not sure).

			0x52FC64,	// I believe this is the 68k version...
			0x52FE28,	// Another one for 68k...
			0x530084,	// ''

		//	0x530284,	// Not sure about this one, but there's definitely a check for more ROM space on the 4-8MB routines
		//	0x530404,	// ''

		//	0x530444,	// Not sure about this either...
		//	0x530540,


		//	0x530488,

			0x000000	};

void AlterPointers (char *Memory)

{
	int RoutLoc = 0;
	while (Routines [RoutLoc] != 0)
	{
		int MemoryLoc = Routines [RoutLoc++];
		Memory [MemoryLoc + 0x08] = Memory [MemoryLoc];
		Memory [MemoryLoc + 0x0C] = Memory [MemoryLoc++];
		Memory [MemoryLoc + 0x08] = Memory [MemoryLoc];
		Memory [MemoryLoc + 0x0C] = Memory [MemoryLoc++];
		Memory [MemoryLoc + 0x08] = Memory [MemoryLoc];
		Memory [MemoryLoc + 0x0C] = Memory [MemoryLoc++];
		Memory [MemoryLoc + 0x08] = Memory [MemoryLoc];
		Memory [MemoryLoc + 0x0C] = Memory [MemoryLoc++];
	}
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
	WriteExt (".mdx", Memory, 0x52F688);
	WriteExt (".MDX", Memory, 0x52F66C);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Main Routine
// -----------------------------------------------------------------------------

int main (int ArgNumber, char **ArgList, char **EnvList)

{
	FILE *File = fopen ("Regen.exe", "rb");
	if (File == NULL)
	{
		printf ("Could not open \"Regen.exe\"\n");
		fflush (stdin); getchar ( ); return (0x00);
	}
	fseek (File, 0x00, SEEK_END);
	int MemoryLoc = 0x401000-0x400;
	int MemorySize = MemoryLoc + ftell (File);
	char *Memory = (char*) malloc (MemorySize);
	if (Memory == NULL)
	{
		fclose (File);
		printf ("Could not allocate memory for \"Regen.exe\"\n");
		fflush (stdin); getchar ( ); return (0x00);
	}
	rewind (File);
	while (MemoryLoc < MemorySize)
	{
		Memory [MemoryLoc++] = fgetc (File);
	}
	fclose (File);

	AlterOffsets (Memory);
	AlterPointers (Memory);
	EditEXT (Memory);

	File = fopen ("Regen8.exe", "wb");
	if (File == NULL)
	{
		free (Memory); Memory = NULL;
		printf ("Could not create \"Regen8.exe\"\n");
		fflush (stdin); getchar ( ); return (0x00);
	}
	MemoryLoc = 0x401000-0x400;
	while (MemoryLoc < MemorySize)
	{
		fputc (Memory [MemoryLoc++], File);
	}
	fclose (File);
	free (Memory); Memory = NULL;
}

// =============================================================================
