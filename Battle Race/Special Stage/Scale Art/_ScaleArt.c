// =============================================================================
// -----------------------------------------------------------------------------
// Program
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <windows.h>
#include "_bitmap.h"

int main (int ArgNumber, char **ArgList, char **EnvList)

{
	IMG Pal; Pal.Data = NULL;
	IMG Image; Image.Data = NULL;

	if (ImageLoad (&Pal, (char*) "Temp.pal.bmp") != 0x00)
	{
		printf ("Error loading Temp.pal.bmp\n");
		fflush (stdin); getchar ( ); return (0x00);
	}
	PIX_BGRA ColourA, ColourB;
	int PalLoc = 1, PalSize = 0;
	ColourA = Pal.Data [PalSize++];
	while (PalSize < Pal.SizeX)
	{
		ColourB = Pal.Data [PalLoc++];
		if (	ColourB.Red   != ColourA.Red   ||
			ColourB.Green != ColourA.Green ||
			ColourB.Blue  != ColourA.Blue  )
		{
			ColourA = ColourB;
			Pal.Data [PalSize++] = ColourB;
		}
	}
	Pal.Size = PalSize;

	const char Names [] [0x0B] = {	{ "Temp 1.bmp" }, { "Temp 1.bin" },
					{ "Temp 2.bmp" }, { "Temp 2.bin" },
					{ "Temp 3.bmp" }, { "Temp 3.bin" },
					{ "Temp 4.bmp" }, { "Temp 4.bin" },
					{ "Temp 5.bmp" }, { "Temp 5.bin" },
					{ "          " }
				};

	int NamesLoc = 0;
	while (Names [NamesLoc] [0] != ' ')
	{

	if (ImageLoad (&Image, (char*) Names [NamesLoc]) != 0x00)
	{
		printf ("Error loading %s\n", Names [NamesLoc]);
		fflush (stdin); getchar ( ); return (0x00);
	}
	FlipImage (&Image);
	NamesLoc++;

	FILE *File = fopen (Names [NamesLoc++], "wb");

	int ImageLoc;
	u_char Byte = 0x00;
	bool Found = FALSE;
	for (ImageLoc = 0; ImageLoc < Image.Size; ImageLoc++)
	{
		ColourA = Image.Data [ImageLoc];
		for (PalLoc = 0; PalLoc < Pal.Size; PalLoc++)
		{
			if (	Pal.Data [PalLoc].Red   == ColourA.Red   &&
				Pal.Data [PalLoc].Green == ColourA.Green &&
				Pal.Data [PalLoc].Blue  == ColourA.Blue  )
			{
				break;
			}
		}
		if (PalLoc == Pal.Size)
		{
			printf ("Error, a colour doesn't match...\n");
			fflush (stdin); getchar ( ); return (0x00);
		}
		Byte = (Byte << 4) | (PalLoc & 0x0F);
		if (Found == TRUE)
		{
			fputc (Byte, File);
		}
		Found = TRUE;
	}
	Byte <<= 4;
	fputc (Byte, File);

	fclose (File);

	}

	free (Pal.Data); Pal.Data;
	free (Image.Data); Image.Data;
	return (0x00);
}

// =============================================================================
