// =============================================================================
// -----------------------------------------------------------------------------
// Program
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <windows.h>

#define FLIP FALSE // Set to TRUE to flip the sphers horizontally from centre of screen

int main (int ArgNumber, char **ArgList, char **EnvList)

{
	if (ArgNumber > 0x01)
	{
		char Text [0x1000];
		FILE *File = fopen (ArgList [0x01], "rb");
		FILE *Out = fopen ("List.txt", "w");
		snprintf (Text, 0x1000, "; ===========================================================================\n"
					"; ---------------------------------------------------------------------------\n"
					"; Sphere sprite position ripped data\n"
					"; ---------------------------------------------------------------------------\n"); fputs (Text, Out);
		int Count;
		for (Count = 0; Count < 0x20; Count++)
		{
			fseek (File, 0x2478+(Count*0x400), SEEK_SET);
			short Sprites = fgetc (File) << 0x08;
			Sprites |= fgetc (File) & 0xFF;
			snprintf (Text, 0x1000, "\nList%0.2X:		dc.w	$%0.4X\n", Count, Sprites & 0xFFFF); fputs (Text, Out);
			u_short Entry [0x04];
			while (Sprites-- >= 0)
			{
				Entry [0x00] = fgetc (File) << 0x08;
				Entry [0x00] |= fgetc (File) & 0xFF;
				Entry [0x01] = fgetc (File) << 0x08;
				Entry [0x01] |= fgetc (File) & 0xFF;
				Entry [0x02] = fgetc (File) << 0x08;
				Entry [0x02] |= fgetc (File) & 0xFF;
				Entry [0x03] = fgetc (File) << 0x08;
				Entry [0x03] |= fgetc (File) & 0xFF;

			// dc.w	$0D00,$0D00,$0D00,$0D00,$0900,$0900,$0900,$0900
			// dc.w	$0400,$0400,$0400,$0400,$0000,$0000,$0000,$0000

				if (FLIP == TRUE)
				{
					int ListX [] = { 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
							 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08 };
					Entry [0x03] -= 0x80 + (320 / 2);
					Entry [0x03] = -Entry [0x03];
					Entry [0x03] += (0x80 + (320 / 2)) - ListX [Entry [0x02]];
				}

				snprintf (Text, 0x1000, "		dc.w	$%0.4X,$%0.4X,$%0.4X,$%0.4X\n", Entry [0x00], Entry [0x01], Entry [0x02], Entry [0x03]); fputs (Text, Out);
			}
		}
		fclose (File); fclose (Out);
	}
	else
	{
		printf ("Drag a savestate onto this program, containing sphere sprite position data\n");
		fflush (stdin); getchar ( );
	}
	return (0x00);
}

// =============================================================================
