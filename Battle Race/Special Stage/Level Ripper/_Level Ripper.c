// =============================================================================
// -----------------------------------------------------------------------------
// Program
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <windows.h>

int main (int ArgNumber, char **ArgList, char **EnvList)

{
	printf ("Level Ripper (Blue Spheres Challenge) - by MarkeyJester\n");
	if (ArgNumber <= 0x01)
	{
		printf ("\n -> Drag and drop a savestate file onto this program\n"
			"    To rip a blue spheres stage from it.\n");
		printf ("\nPress enter key to exit...\n");
		fflush (stdin); getchar ( ); return (0x00);
	}
	char TEXT [0x1000]; int TLOC;
	int Count;
	FILE *Out = fopen ("_Output.asm", "w");
	int ArgCount;
	for (ArgCount = 0x01; ArgCount < ArgNumber; ArgCount++)
	{
		printf ("\n -> %s\n", ArgList [ArgCount]);
		FILE * File = fopen (ArgList [ArgCount], "rb");
		if (File == NULL)
		{
			printf ("    Error, could not open the file\n");
			continue;
		}
		TLOC = 0;
		TLOC += snprintf (&TEXT [TLOC], 0x1000, "Map%0.2X:	", ArgCount-1);

		fseek (File, 0x2478+0xE422, SEEK_SET);
		u_short PosX = fgetc (File) << 0x08;
		PosX |= fgetc (File) & 0xFF;
		u_short PosY = fgetc (File) << 0x08;
		PosY |= fgetc (File) & 0xFF;
		u_char Angle = fgetc (File) & 0xFF;

		PosX >>= 0x08;
		PosY >>= 0x08;
		Angle >>= 0x05;
		Angle &= 0b00000110;

	int ColSet = (PosX + PosY) & 0x01;

		// Stage floor colours...

		u_short Colour1, Colour2;
		fseek (File, 0x182, SEEK_SET);
		Colour1 = fgetc (File) & 0xFF;
		Colour1 |= fgetc (File) << 0x08;
		for (Count = 0x10; Count > 0; Count--)
		{
			Colour2 = fgetc (File) & 0xFF;
			Colour2 |= fgetc (File) << 0x08;
			if (Colour1 != Colour2)
			{
				break;
			}
		}
		if (ColSet != 0)
		{
			u_short Swap = Colour1;
			Colour1 = Colour2;
			Colour2 = Swap;
		}

		TLOC += snprintf (&TEXT [TLOC], 0x1000, "dc.w	$%0.4X,$%0.4X		; Stage floor colours\n", Colour1, Colour2);
		fputs (TEXT, Out);

		// BG colours...

		fseek (File, 0x162, SEEK_SET);
		Count = 3;
		TLOC = 0;
		TLOC += snprintf (&TEXT [TLOC], 0x1000, "	dc.w	");
		while (Count-- > 0)
		{
			u_short Colour = fgetc (File) & 0xFF;
			Colour |= fgetc (File) << 0x08;
			TLOC += snprintf (&TEXT [TLOC], 0x1000, "$%0.4X", Colour);
			if (Count != 0)
			{
				TEXT [TLOC++] = ',';
			}
		}
		TLOC += snprintf (&TEXT [TLOC], 0x1000, "	; Stage BG colours\n");
		fputs (TEXT, Out);

		// Positions and angle...

		char NumString [] = " 21";
		for (Count = 2; Count > 0; Count--)
		{
			snprintf (TEXT, 0x1000, "	dc.b	$%0.2X,$%0.2X,$%0.2X		; Player %c's starting X, Y and Angle\n", PosX & 0x1F, PosY & 0x1F, Angle, NumString [Count]);
			fputs (TEXT, Out);
		}
		snprintf (TEXT, 0x1000, "\n");
		fputs (TEXT, Out);

		// Now the actual layout...

		fseek (File, 0x2478+0xFFFC, SEEK_SET);
		u_int Init = (fgetc (File) & 0xFF) << 0x18;
		Init |= (fgetc (File) & 0xFF) << 0x10;
		Init |= (fgetc (File) & 0xFF) << 0x08;
		Init |= fgetc (File) & 0xFF;

		fseek (File, 0x2478+0xF100, SEEK_SET);
		if (Init == 0x696E6974) // init = Sonic 3 | SM&K = Sonic & Knuckles/Blue Spheres/S3&K
		{
			fseek (File, 0x2478+0x8000, SEEK_SET);
		}

		u_char Spheres [] = { "_XBTRY" };

//
//	_	=	$80	; Blank Space
//	X	=	$45	; Red Sphere
//	T	=	$81	; Star Sphere
//	B	=	$02	; Blue Sphere
//	O	=	$03	; Orange Sphere
//	R	=	$84	; Rings (REMOVE THE 80 WHEN READY)
//	Y	=	Yellow (no sphere provided...)
//

		int CountX, CountY;
		for (CountY = 0x1F; CountY >= 0; CountY--)
		{
			TLOC = snprintf (TEXT, 0x1000, "	dc.b	");
			for (CountX = 0x1F; CountX >= 0; CountX--)
			{
				TLOC += snprintf (&TEXT [TLOC], 0x1000, "%c", Spheres [fgetc (File) & 0xFF]);
				if (CountX != 0)
				{
					TEXT [TLOC++] = ',';
				}
			}
			snprintf (&TEXT [TLOC], 0x1000, "\n");
			fputs (TEXT, Out);
		}
		snprintf (TEXT, 0x1000, "\n");
		fputs (TEXT, Out);
		fclose (File);
	}
	fclose (Out);
	printf ("\nPress enter key to exit...\n");
	fflush (stdin); getchar ( ); return (0x00);
	return (0x00);
}

// =============================================================================
