// =============================================================================
// -----------------------------------------------------------------------------
// Image Smoother
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <dirent.h>
#include <windows.h>
#include "_bitmap.h"

int main (int ArgNumber, char **ArgList, char **EnvList)

{

	// --- Loading mask ---

	IMG BitmapA, BitmapB;
	BitmapA.Data = NULL; BitmapB.Data = NULL;
	char FileMaskA [] = { "A.bmp" };
	char FileMaskB [] = { "B.bmp" };
	switch (ImageLoad (&BitmapA, (char*) FileMaskA))
	{
		case 1: printf ("    Error, could not load \"%s\"\n\nPress enter key to exit...\n", FileMaskA); fflush (stdin); getchar ( ); return (0x00);
		case 2: printf ("    Error, could not allocate memory for \"%s\"\n\nPress enter key to exit...\n", FileMaskA); fflush (stdin); getchar ( ); return (0x00);
		case 3: printf ("    Error, fread copy size is wrong for \"%s\"\n\nPress enter key to exit...\n", FileMaskA); fflush (stdin); getchar ( ); return (0x00);
		case 4: printf ("    Error, \"%s\" has a bitmap format unsupported\n\nPress enter key to exit...\n", FileMaskA); fflush (stdin); getchar ( ); return (0x00);
		case 5: printf ("    Error, \"%s\" does not have a valid bitmap header\n\nPress enter key to exit...\n", FileMaskA); fflush (stdin); getchar ( ); return (0x00);
	}
	switch (ImageLoad (&BitmapB, (char*) FileMaskB))
	{
		case 1: printf ("    Error, could not load \"%s\"\n\nPress enter key to exit...\n", FileMaskB); fflush (stdin); getchar ( ); return (0x00);
		case 2: printf ("    Error, could not allocate memory for \"%s\"\n\nPress enter key to exit...\n", FileMaskB); fflush (stdin); getchar ( ); return (0x00);
		case 3: printf ("    Error, fread copy size is wrong for \"%s\"\n\nPress enter key to exit...\n", FileMaskB); fflush (stdin); getchar ( ); return (0x00);
		case 4: printf ("    Error, \"%s\" has a bitmap format unsupported\n\nPress enter key to exit...\n", FileMaskB); fflush (stdin); getchar ( ); return (0x00);
		case 5: printf ("    Error, \"%s\" does not have a valid bitmap header\n\nPress enter key to exit...\n", FileMaskB); fflush (stdin); getchar ( ); return (0x00);
	}

	int Count;
	for (Count = 0; Count < BitmapA.Size; Count++)
	{
		int AmountR = BitmapB.Data [Count].Red   - 128;
		int AmountG = BitmapB.Data [Count].Green - 160;
		int AmountB = BitmapB.Data [Count].Blue  - 160;

		int Value;


		if (AmountR < 0)
		{
			AmountR = -AmountR;
			if (BitmapA.Data [Count].Red   < AmountR) { BitmapA.Data [Count].Red   = AmountR; } BitmapA.Data [Count].Red   -= AmountR;
		}
		else
		{
			Value = BitmapA.Data [Count].Red   + AmountR; if (Value > 0xFF) { Value = 0xFF; } BitmapA.Data [Count].Red   = Value;
		}
		if (AmountG < 0)
		{
			AmountG = -AmountG;
			if (BitmapA.Data [Count].Green < AmountG) { BitmapA.Data [Count].Green = AmountG; } BitmapA.Data [Count].Green -= AmountG;
		}
		else
		{
			Value = BitmapA.Data [Count].Green + AmountG; if (Value > 0xFF) { Value = 0xFF; } BitmapA.Data [Count].Green = Value;
		}
		if (AmountB < 0)
		{
			AmountB = -AmountB;
			if (BitmapA.Data [Count].Blue  < AmountB) { BitmapA.Data [Count].Blue  = AmountB; } BitmapA.Data [Count].Blue  -= AmountB;
		}
		else
		{
			Value = BitmapA.Data [Count].Blue  + AmountB; if (Value > 0xFF) { Value = 0xFF; } BitmapA.Data [Count].Blue  = Value;
		}
	}


	SaveBMP (&BitmapA, "Output.bmp", 24);

	free (BitmapA.Data); BitmapA.Data = NULL;
	free (BitmapB.Data); BitmapB.Data = NULL;

	printf ("\nPress enter key to exit...\n");
	fflush (stdin);
	getchar ( );
	return (0x00);
}

// =============================================================================
