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

	IMG Bitmap;
	Bitmap.Data = NULL;
	char FileMask [] = { "Image.bmp" };
	switch (ImageLoad (&Bitmap, (char*) FileMask))
	{
		case 1: printf ("    Error, could not load \"%s\"\n\nPress enter key to exit...\n", FileMask); fflush (stdin); getchar ( ); return (0x00);
		case 2: printf ("    Error, could not allocate memory for \"%s\"\n\nPress enter key to exit...\n", FileMask); fflush (stdin); getchar ( ); return (0x00);
		case 3: printf ("    Error, fread copy size is wrong for \"%s\"\n\nPress enter key to exit...\n", FileMask); fflush (stdin); getchar ( ); return (0x00);
		case 4: printf ("    Error, \"%s\" has a bitmap format unsupported\n\nPress enter key to exit...\n", FileMask); fflush (stdin); getchar ( ); return (0x00);
		case 5: printf ("    Error, \"%s\" does not have a valid bitmap header\n\nPress enter key to exit...\n", FileMask); fflush (stdin); getchar ( ); return (0x00);
	}

	int CountX, CountY, Pos = 0;
	for (CountY = 0; CountY < Bitmap.SizeY; CountY++)
	{
		for (CountX = 0; CountX < Bitmap.SizeX; CountX++)
		{
			int Percentage = (CountX * 0X100) / Bitmap.SizeX;

			if (Bitmap.Data [Pos].Red < Percentage)
			{
				Bitmap.Data [Pos].Red = Percentage;
			}
			Bitmap.Data [Pos].Red -= Percentage;
			if (Bitmap.Data [Pos].Green < Percentage)
			{
				Bitmap.Data [Pos].Green = Percentage;
			}
			Bitmap.Data [Pos].Green -= Percentage;
			if (Bitmap.Data [Pos].Blue < Percentage)
			{
				Bitmap.Data [Pos].Blue = Percentage;
			}
			Bitmap.Data [Pos].Blue -= Percentage;
			Pos++;
		}
	}
	SaveBMP (&Bitmap, "Output.bmp", 24);

	free (Bitmap.Data); Bitmap.Data = NULL;

	printf ("\nPress enter key to exit...\n");
	fflush (stdin);
	getchar ( );
	return (0x00);
}

// =============================================================================
