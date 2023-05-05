// =============================================================================
// -----------------------------------------------------------------------------
// Program
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <windows.h>
#include <bitmap.h>

char PaletteName [] = { "_MaskPal.bmp" };

int main (int ArgNumber, char **ArgList, char **EnvList)

{
	if (ArgNumber <= 0x01)
	{
		printf ("Please drag and drop the mask art .bmp files onto this program\n");
		fflush (stdin); getchar ( );
		return (0x00);
	}

	// --- Loading the palette ---

	IMG PalImage;
	switch (ImageLoad (&PalImage, PaletteName))
	{
		case 1: printf ("Error, could not open \"%s\"\n", PaletteName); fflush (stdin); getchar ( ); return (0x00);
		case 2: printf ("Error, could not allocate memory"); fflush (stdin); getchar ( ); return (0x00);
		case 3: printf ("Error, fread amount incorrect"); fflush (stdin); getchar ( ); return (0x00);
		case 4: printf ("Error, the bitmap format in this file is not supported"); fflush (stdin); getchar ( ); return (0x00);
		case 5: printf ("Error, image is not a valid Bitmap file"); fflush (stdin); getchar ( ); return (0x00);
	}
	PIX_BGRA Palette [0x10];
	int PaletteSize = 0;
	int PaletteLoc;
	PIX_BGRA LastColour = PalImage.Data [0];
	Palette [PaletteSize++] = LastColour;
	int Count = 0;
	do
	{
		if (	PalImage.Data [Count].Blue  != LastColour.Blue  ||
			PalImage.Data [Count].Green != LastColour.Green ||
			PalImage.Data [Count].Red   != LastColour.Red   ||
			PalImage.Data [Count].Alpha != LastColour.Alpha )
		{
			LastColour = PalImage.Data [Count];
			Palette [PaletteSize++] = LastColour;
		}
	}
	while (++Count < PalImage.SizeX && PaletteSize < 0x10);
	free (PalImage.Data); PalImage.Data = NULL;

	// --- Loading mask images and converting them ---

	char FileName [0x1000];
	int ArgCount = 0x00;
	bool Error = FALSE;
	while (++ArgCount < ArgNumber)
	{
		strcpy (FileName, ArgList [ArgCount]);
		IMG Mask;
		switch (ImageLoad (&Mask, FileName))
		{
			case 1: printf ("Error, could not open \"%s\"\n", FileName); fflush (stdin); getchar ( ); Error = TRUE; break;
			case 2: printf ("Error, could not allocate memory"); fflush (stdin); getchar ( ); Error = TRUE; break;
			case 3: printf ("Error, fread amount incorrect"); fflush (stdin); getchar ( ); Error = TRUE; break;
			case 4: printf ("Error, the bitmap format in this file is not supported"); fflush (stdin); getchar ( ); Error = TRUE; break;
			case 5: printf ("Error, image is not a valid Bitmap file"); fflush (stdin); getchar ( ); Error = TRUE; break;
		}
		if (Error == TRUE)
		{
			break;
		}
		if (Mask.SizeY != 16)
		{
			printf ("Error, \"%s\"\n\nBitmap must have a height of 16 ($10) pixels in height\n", FileName);
			fflush (stdin); getchar ( );
			break;
		}
	/*	if ((Mask.SizeX & (8-1)) != 0)
		{
			printf ("Error, \"%s\"\n\nBitmap must have a width in multiples of 8 pixels\n", FileName);
			fflush (stdin); getchar ( );
			break;
		}	*/

		char Tiles [0x100*0x20]; // Don't think we'll need all 100 tile, but just in case...
		int TilesSize = 0;
		int TilesLoc;

		int CountC, CountX, CountY;
		for (CountY = Mask.SizeY - 1; CountY >= 0; CountY--)
		{
			for (CountX = 0; CountX < Mask.SizeX; CountX++)
			{
				int PixPos = CountX + (CountY * Mask.SizeX);
				LastColour = Mask.Data [PixPos];
				for (PaletteLoc = 0; PaletteLoc < PaletteSize; PaletteLoc++)
				{
					if (	Palette [PaletteLoc].Blue  == LastColour.Blue  &&
						Palette [PaletteLoc].Green == LastColour.Green &&
						Palette [PaletteLoc].Red   == LastColour.Red   &&
						Palette [PaletteLoc].Alpha == LastColour.Alpha )
					{
						break;
					}
				}
				if (PaletteLoc == PaletteSize)
				{
					printf ("Error, \"%s\"\n\nPixel at %d x %d does not use a colour in the palette\n", FileName, (CountX | CountC), (Mask.SizeY - CountY) - 1);
					fflush (stdin);
					getchar ( );
					Error = TRUE;
					break;
				}
				Tiles [TilesSize++] = PaletteLoc;
			}
			if (Error == TRUE) { break; }
			for (CountX = (8 - (Mask.SizeX & 7)) & 7; CountX > 0; CountX--)
			{
				Tiles [TilesSize++] = 0; // Pad to the next 8 pixel position
			}
			for (CountX = 0; CountX < 8; CountX++)
			{
				Tiles [TilesSize++] = 0; // creating blank tile on end
			}
		}

		if (Error == TRUE) { break; }

		Mask.SizeX += (8 - (Mask.SizeX & 7)) & 7;
		int ColumnCount = (Mask.SizeX / 8) + 1;
		free (Mask.Data); Mask.Data = NULL;

		// --- Making filename ---

		char Byte;
		int ByteLoc = 0;
		int ExtLoc = 0;
		do
		{
			Byte = FileName [ByteLoc++];
			if (Byte == '.')
			{
				ExtLoc = ByteLoc - 1;
			}
		}
		while (Byte != 0x00);
		if (ExtLoc == 0)
		{
			ExtLoc = ByteLoc;
		}
		strcpy (&FileName [ExtLoc], ".bin");


		FILE *File = fopen (FileName, "wb");
		if (File == NULL)
		{
			printf ("Error, could not create \"%s\"\n", FileName);
			fflush (stdin);
			getchar ( );
			break;
		}
		fputc (ColumnCount >> 0x08, File);
		fputc (ColumnCount >> 0x00, File);

		int CountD;
		for (CountD = 0; CountD < 8; CountD++)
		{

			// Writing tiles...

			for (CountC = 0; CountC < (ColumnCount * 8); CountC += 8)
			{
				for (CountY = 0; CountY < Mask.SizeY; CountY++)
				{
					for (CountX = 0; CountX < 8; CountX += 2)
					{
						TilesLoc = (CountX | CountC) + (CountY * (ColumnCount * 8));
						Byte = Tiles [TilesLoc++] << 0x04;
						Byte |= Tiles [TilesLoc++] & 0x0F;
						fputc (Byte, File);
					}
				}
			}

			// Rotating art around...

			for (CountY = 0; CountY < Mask.SizeY; CountY++)
			{
				for (CountX = (ColumnCount * 8) - 1; CountX > 0; CountX--)
				{
					TilesLoc = CountX + (CountY * (ColumnCount * 8));
					Tiles [TilesLoc] = Tiles [TilesLoc - 1];
				}
				TilesLoc = CountX + (CountY * (ColumnCount * 8));
				Tiles [TilesLoc] = 0;
			}
		}


		fclose (File);
	}
}

// =============================================================================
