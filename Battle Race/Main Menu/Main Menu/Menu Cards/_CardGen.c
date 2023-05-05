// =============================================================================
// -----------------------------------------------------------------------------
// Main Menu Card bitmap to tile converter
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <dirent.h>
#include <direct.h>
#include <windows.h>
#include "_bitmap.h"

const char FolderTrans [] = { "Transition Cards" };	// Folder containing the transition cards
const char FolderCards [] = { "Design Cards" };		// Folder containing the design cards
char FolderOutput [0x400] = { "Card Data" };		// Output folder to dump files

const char ExtPalette [] = { ".pal.bmp" };
const char ExtBitmap [] = { ".bmp" };
const char ExtBinary [] = { ".bin" };
const char ExtPalMD [] = { ".pal" };
int FolderSize;

// =============================================================================
// -----------------------------------------------------------------------------
// Loading directory file strings into a char list
// -----------------------------------------------------------------------------

#define ERR_DIRECTACCESS -1
#define ERR_DIRECTEMPTY -2

int LoadDirectory (char Directory[][0x400], const char *Folder)

{
	Directory [0] [0] = 0x00; // set end marker
	DIR *Direct = opendir (Folder);
	if (Direct == NULL)
	{
		return (ERR_DIRECTACCESS);
	}
	struct dirent *DirEntry;
	int DirectSize = 0;
	while ((DirEntry = readdir (Direct)) != NULL)
	{
	//	if (DirEntry->d_type == DT_REG)		// d_type is apparently not standard (if it ever was to begin with)...
		if (DirEntry->d_name [0] != '.')
		{
			DirectSize++;
		}
	}
	if (DirectSize == 0)
	{
		return (ERR_DIRECTEMPTY);
	}
	if ((Direct = opendir (Folder)) == NULL)	// reopen to reset the list
	{
		return (ERR_DIRECTACCESS);
	}
	int FolderSize = -1;
	while (Folder [++FolderSize] != 0x00) { }

	int DirectLoc = 0;
	while ((DirEntry = readdir (Direct)) != NULL && DirectLoc < DirectSize)
	{
	//	if (DirEntry->d_type == DT_REG)		// d_type being a dick...
		if (DirEntry->d_name [0] != '.')
		{
			strcpy (Directory [DirectLoc], Folder);
			Directory [DirectLoc] [FolderSize] = '\\';
			strcpy (&Directory [DirectLoc++] [FolderSize + 1], DirEntry->d_name);
		}
	}
	Directory [DirectLoc] [0] = 0x00; // set end marker
//	DirectSize = DirectLoc;
	return (0);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Flipping a pixel image upside-down (because lol windows...)
// -----------------------------------------------------------------------------

void FlipPixels (char *Pixels, int SizeX, int SizeY)

{
	int PosYA = -1, PosYB = SizeY;
	char Pixel;
	while (++PosYA < --PosYB)
	{
		int PosX = -1;
		while (++PosX < SizeX)
		{
			Pixel = Pixels [PosX + (PosYA * SizeX)];
			Pixels [PosX + (PosYA * SizeX)] = Pixels [PosX + (PosYB * SizeX)];
			Pixels [PosX + (PosYB * SizeX)] = Pixel;
		}
	}
}

// =============================================================================
// -----------------------------------------------------------------------------
// Converting bitmap pixels to tile pixels
// -----------------------------------------------------------------------------

void ConvertToTiles (char *Pixels, int SizeX, int SizeY)

{
	FlipPixels (Pixels, SizeX, SizeY); // Flip it upside down first because of windows bitmap format...

	char Tiles [SizeX * SizeY];
	int TilesSize = 0;

	// Need a pattern system so the tiles can be saved in sprite shape order of some kind...

	// Tile order in terms of sprites

	int Position, PosX, PosY, SpriteX, SpriteY, TileX, TileY, PixX, PixY;

	for (SpriteX = 0; SpriteX < SizeX; SpriteX += (4 * 8))
	{
		for (SpriteY = 0; SpriteY < SizeY; SpriteY += (4 * 8))
		{
			for (TileX = 0; TileX < (4 * 8); TileX += 8)
			{
				for (TileY = 0; TileY < (4 * 8); TileY += 8)
				{
					for (PixY = 0; PixY < 8; PixY++)
					{
						for (PixX = 0; PixX < 8; PixX++)
						{
							PosX = SpriteX + TileX + PixX;
							PosY = SpriteY + TileY + PixY;
							if (PosX >= SizeX || PosY >= SizeY)
							{
								continue;
							}
							Position = PosX + (PosY * SizeX);
							Tiles [TilesSize++] = Pixels [Position];
						}
					}
				}
			}
		}
	}

	int TilesLoc = -1;
	while (++TilesLoc < TilesSize)
	{
		Pixels [TilesLoc] = Tiles [TilesLoc];
	}
}

// =============================================================================
// -----------------------------------------------------------------------------
// Entry point
// -----------------------------------------------------------------------------

int main (int ArgNumber, char **ArgList, char **EnvList)

{

	// --- Obtaining directories from a folder ---

	printf ("Card Generator - by MarkeyJester\n\n");

	int DirectLoc, DirectSize;
	char DirectTrans [0x100] [0x400];
	char DirectCards [0x100] [0x400];

	switch (LoadDirectory (DirectTrans, FolderTrans))
	{
		case ERR_DIRECTACCESS: printf ("    Error, could not access directory \"%s\"\n\nPress enter key to exit...\n", FolderTrans); fflush (stdin); getchar ( ); return (0x00);
		case ERR_DIRECTEMPTY: printf ("    Error, the directory \"%s\" is empty\n\nPress enter key to exit...\n", FolderTrans); fflush (stdin); getchar ( ); return (0x00);
	}
	switch (LoadDirectory (DirectCards, FolderCards))
	{
		case ERR_DIRECTACCESS: printf ("    Error, could not access directory \"%s\"\n\nPress enter key to exit...\n", FolderCards); fflush (stdin); getchar ( ); return (0x00);
		case ERR_DIRECTEMPTY: printf ("    Error, the directory \"%s\" is empty\n\nPress enter key to exit...\n", FolderCards); fflush (stdin); getchar ( ); return (0x00);
	}

/*	printf ("Cards\n");
	DirectLoc = -1;
	while (DirectCards [++DirectLoc] [0] != 0)
	{
		printf (" -> %s\n", DirectCards [DirectLoc]);
	}
	printf ("Now transition\n");
	DirectLoc = -1;
	while (DirectTrans [++DirectLoc] [0] != 0)
	{
		printf (" -> %s\n", DirectTrans [DirectLoc]);
	}	*/

	mkdir (FolderOutput);	// Making directory
	int FolderLoc = -1;
	while (FolderOutput [++FolderLoc] != 0x00) { }
	FolderOutput [FolderLoc++] = '\\';

// -----------------------------------------------------------------------------
// Transition cards...
// -----------------------------------------------------------------------------

	for (DirectSize = 0; DirectTrans [DirectSize] [0] != 0; DirectSize++) { }
	DirectLoc = 0;
	IMG Palette, Bitmap;
	Palette.Data = NULL;
	Bitmap.Data = NULL;
	printf (" -> %s\n", DirectTrans [DirectLoc]);
	switch (ImageLoad (&Palette, DirectTrans [DirectLoc]))
	{
		case 1: printf ("    Error, could not load \"%s\"\n\nPress enter key to exit...\n", DirectTrans [DirectLoc]); fflush (stdin); getchar ( ); return (0x00);
		case 2: printf ("    Error, could not allocate memory for \"%s\"\n\nPress enter key to exit...\n", DirectTrans [DirectLoc]); fflush (stdin); getchar ( ); return (0x00);
		case 3: printf ("    Error, fread copy size is wrong for \"%s\"\n\nPress enter key to exit...\n", DirectTrans [DirectLoc]); fflush (stdin); getchar ( ); return (0x00);
		case 4: printf ("    Error, \"%s\" has a bitmap format unsupported\n\nPress enter key to exit...\n", DirectTrans [DirectLoc]); fflush (stdin); getchar ( ); return (0x00);
		case 5: printf ("    Error, \"%s\" does not have a valid bitmap header\n\nPress enter key to exit...\n", DirectTrans [DirectLoc]); fflush (stdin); getchar ( ); return (0x00);
	}
	int PalLoc = 1;
	int PalSize = 1;
	while (PalLoc < Palette.SizeX)
	{
		if (	Palette.Data [PalLoc].Red   != Palette.Data [PalSize - 1].Red	||
			Palette.Data [PalLoc].Green != Palette.Data [PalSize - 1].Green	||
			Palette.Data [PalLoc].Blue  != Palette.Data [PalSize - 1].Blue	)
		{
			Palette.Data [PalSize].Red   = Palette.Data [PalLoc].Red;
			Palette.Data [PalSize].Green = Palette.Data [PalLoc].Green;
			Palette.Data [PalSize].Blue  = Palette.Data [PalLoc].Blue;
			PalSize++;
		}
		PalLoc++;
	}
	if (PalSize > 0x10)
	{
		free (Palette.Data); Palette.Data = NULL;
		printf ("    Error, the palette has more than 0x10 colours, cannot convert\n\nPress enter key to exit...\n");
		fflush (stdin); getchar ( ); return (0x00);
	}
	Palette.Size = PalSize;
	Palette.SizeX = PalSize;
	Palette.SizeY = 1;


	switch (ImageLoad (&Bitmap, DirectTrans [DirectLoc + 1]))
	{
		case 1: printf ("    Error, could not load \"%s\"\n\nPress enter key to exit...\n", DirectTrans [DirectLoc + 1]); fflush (stdin); getchar ( ); return (0x00);
		case 2: printf ("    Error, could not allocate memory for \"%s\"\n\nPress enter key to exit...\n", DirectTrans [DirectLoc + 1]); fflush (stdin); getchar ( ); return (0x00);
		case 3: printf ("    Error, fread copy size is wrong for \"%s\"\n\nPress enter key to exit...\n", DirectTrans [DirectLoc + 1]); fflush (stdin); getchar ( ); return (0x00);
		case 4: printf ("    Error, \"%s\" has a bitmap format unsupported\n\nPress enter key to exit...\n", DirectTrans [DirectLoc + 1]); fflush (stdin); getchar ( ); return (0x00);
		case 5: printf ("    Error, \"%s\" does not have a valid bitmap header\n\nPress enter key to exit...\n", DirectTrans [DirectLoc + 1]); fflush (stdin); getchar ( ); return (0x00);
	}
	int PosX, PosY;
	int SizeX = Bitmap.SizeX;
	int SizeY = Bitmap.SizeY;
	free (Bitmap.Data); Bitmap.Data;
	if ((SizeX % 8) != 0 || (SizeY % 8) != 0)
	{
		free (Palette.Data); Palette.Data = NULL;
		printf (" -> %s\n", DirectTrans [DirectLoc + 1]);
		printf ("    Error, the cards must be a multiple of 8x8\n\nPress enter key to exit...\n");
		fflush (stdin); getchar ( ); return (0x00);
	}
	char MaskData [DirectSize - 1] [PalSize] [SizeX * SizeY] = { 0 };
	// I hope the { 0 } will clear the entire array and not just one element array...

	// MaskData has [Every bitmap] [three colours] [size of image]

	while (++DirectLoc < DirectSize)
	{
		printf (" -> %s\n", DirectTrans [DirectLoc]);
		switch (ImageLoad (&Bitmap, DirectTrans [DirectLoc]))
		{
			case 1: printf ("    Error, could not load \"%s\"\n\nPress enter key to exit...\n", DirectTrans [DirectLoc]); fflush (stdin); getchar ( ); return (0x00);
			case 2: printf ("    Error, could not allocate memory for \"%s\"\n\nPress enter key to exit...\n", DirectTrans [DirectLoc]); fflush (stdin); getchar ( ); return (0x00);
			case 3: printf ("    Error, fread copy size is wrong for \"%s\"\n\nPress enter key to exit...\n", DirectTrans [DirectLoc]); fflush (stdin); getchar ( ); return (0x00);
			case 4: printf ("    Error, \"%s\" has a bitmap format unsupported\n\nPress enter key to exit...\n", DirectTrans [DirectLoc]); fflush (stdin); getchar ( ); return (0x00);
			case 5: printf ("    Error, \"%s\" does not have a valid bitmap header\n\nPress enter key to exit...\n", DirectTrans [DirectLoc]); fflush (stdin); getchar ( ); return (0x00);
		}
		if (Bitmap.SizeX != SizeX || Bitmap.SizeY != SizeY)
		{
			free (Bitmap.Data); Bitmap.Data;
			free (Palette.Data); Palette.Data = NULL;
			printf ("    Error, the bitmap is not the same width and height as the others\n\nPress enter key to exit...\n");
			fflush (stdin); getchar ( ); return (0x00);
		}
		for (PosY = SizeY - 1; PosY >= 0; PosY--)
		{
			for (PosX = 0; PosX < SizeX; PosX++)
			{
				int Position = PosX + (PosY * SizeX);
				for (PalLoc = 0; PalLoc < PalSize; PalLoc++)
				{
					if (	Palette.Data [PalLoc].Red   == Bitmap.Data [Position].Red	&&
						Palette.Data [PalLoc].Green == Bitmap.Data [Position].Green	&&
						Palette.Data [PalLoc].Blue  == Bitmap.Data [Position].Blue	)
					{
						break;
					}
				}
				if (PalLoc == PalSize)
				{
					free (Bitmap.Data); Bitmap.Data;
					free (Palette.Data); Palette.Data = NULL;
					printf ("    Error, the card has a colour that is not in the palette at %d x %d\n\nPress enter key to exit...\n", PosX, (SizeY - PosY) - 1);
					fflush (stdin); getchar ( ); return (0x00);
				}
				MaskData [DirectLoc - 1] [PalLoc] [Position] = 0x0F;	// Set pixel mask on correct colour element image
			}
		}

		for (PalLoc = 0; PalLoc < PalSize; PalLoc++)
		{
			ConvertToTiles (MaskData [DirectLoc - 1] [PalLoc], SizeX, SizeY);

			snprintf (&FolderOutput [FolderLoc], 0x400, "Trans %0.2X (FULL) - %X.bin", DirectLoc, PalLoc);
			FILE *File = fopen (FolderOutput, "wb");
			if (File == NULL)
			{
				free (Bitmap.Data); Bitmap.Data;
				free (Palette.Data); Palette.Data = NULL;
				printf ("\n -> Error, could not create transition card file\n\nPress enter key to exit...\n");
				fflush (stdin); getchar ( ); return (0x00);
			}
			int Position;
			char Pixels;
			char *PixelData = MaskData [DirectLoc - 1] [PalLoc];
			for (Position = 0; Position < (SizeX * SizeY); Position++)
			{
				Pixels = (Pixels << 4) | (PixelData [Position] & 0x0F);
				if ((Position & 1) != 0)
				{
					fputc (Pixels, File);
				}
			}
			fclose (File);
		}

		free (Bitmap.Data); Bitmap.Data;
	}
	strcpy (&FolderOutput [FolderLoc], "Transition.pal");
	FILE *File = fopen (FolderOutput, "wb");
	if (File == NULL)
	{
		free (Palette.Data); Palette.Data = NULL;
		printf ("\n -> Error, could not create transition palette file\n\nPress enter key to exit...\n");
		fflush (stdin); getchar ( ); return (0x00);
	}
	for (PalLoc = 0; PalLoc < PalSize; PalLoc++)
	{
		fputc ((Palette.Data [PalLoc].Blue >> 0x04) & 0x0E, File);
		fputc ((Palette.Data [PalLoc].Green & 0xE0) | ((Palette.Data [PalLoc].Red >> 0x04) & 0x0E), File);
	}
	fclose (File);
	free (Palette.Data); Palette.Data = NULL;


// -----------------------------------------------------------------------------
// Optimised Transition cards...
// -----------------------------------------------------------------------------

	// This is no longer needed since the animation is way too slow to be practicable enough...


/*	File = fopen ("File01.bin", "wb");
	int POS;
	for (POS = 0; POS < SizeX * SizeY; POS += 2)
	{
		fputc ((MaskData [0] [0] [POS] << 4) | MaskData [0] [0] [POS + 1], File);
	}
	fclose (File);
	File = fopen ("File02.bin", "wb");
	for (POS = 0; POS < SizeX * SizeY; POS += 2)
	{
		fputc ((MaskData [1] [0] [POS] << 4) | MaskData [1] [0] [POS + 1], File);
	}
	fclose (File);



	File = fopen ("Test.asm", "w");
	char Text [0x1000];

 for (PalLoc = 0; PalLoc < PalSize; PalLoc++)
 {
	int LinePos, MaskPos, StartPos;
	bool CurrentMatch = TRUE;
	for (MaskPos = 0; MaskPos < (SizeX * SizeY); MaskPos += 8)
	{
		bool Match = TRUE;
		for (LinePos = 0; LinePos < 8; LinePos++)
		{
			if (MaskData [0] [PalLoc] [MaskPos+LinePos] != MaskData [1] [PalLoc] [MaskPos+LinePos])
			{
				Match = FALSE;
			}
		}
		if (Match == TRUE)
		{
			if (CurrentMatch == FALSE)
			{
				CurrentMatch = TRUE;
				// Save change

				int DataSize = MaskPos - StartPos;
				DataSize /= 8;

				snprintf (Text, 0x1000, "\n		dc.b	%%%X%X000000|((-$%0.2X)&%%00111111),$%0.2X\n", (PalLoc >> 1) & 1, PalLoc & 1, (DataSize & 0x07) * 0x06, (DataSize / 8));
		if ((DataSize & 0x07) == 0)
		{
				snprintf (Text, 0x1000, "\n		dc.b	%%%X%X000000|((-$%0.2X)&%%00111111),$%0.2X\n", (PalLoc >> 1) & 1, PalLoc & 1, 0x08 * 0x06, (DataSize / 8)-1);
		}
				fputs (Text, File);
				snprintf (Text, 0x1000, "		dc.w	$%0.4X\n", (StartPos / 2));
				fputs (Text, File);
				while (StartPos < MaskPos)
				{
					fputs ("		dc.l	$", File);
					for (LinePos = 0; LinePos < 8; LinePos++)
					{
						char Byte = MaskData [1] [PalLoc] [StartPos+LinePos] + '0';
						if (Byte > '9')
						{
							Byte += 'A' - ('9' + 1);
						}
						fputc (Byte, File);
					}
					fputs ("\n", File);
					StartPos += 8;
				}
				fputs ("\n", File);

			}
		}
		else
		{
			if (CurrentMatch == TRUE)
			{
				CurrentMatch = FALSE;
				// Record change
				StartPos = MaskPos;
			}
		}
	}
 }

	fputs ("		dc.b	$00\n		even", File);
	fclose (File);	*/

// -----------------------------------------------------------------------------
// Design cards...
// -----------------------------------------------------------------------------

	// --- Working out bitmaps and palettes ---

	for (DirectSize = 0; DirectCards [DirectSize] [0] != 0; DirectSize++) { }

	char Bitmaps [DirectSize] [0x400];
	char Palettes [DirectSize] [0x400] = { 0 };
	int CharLoc, CharSize;
	int ListLoc, ListSize = 0;
	for (DirectLoc = 0; DirectLoc < DirectSize; DirectLoc++)
	{
		for (CharSize = 0; DirectCards [DirectLoc] [CharSize] != 0; CharSize++) { }
		for (CharLoc = 0; CharLoc < CharSize; CharLoc++)
		{
			if ((strcmp (&DirectCards [DirectLoc] [CharLoc], ExtBitmap)) == 0)
			{
				break;
			}
			if (DirectCards [DirectLoc] [CharLoc] == '.')
			{
				CharLoc = CharSize;
				break;
			}
		}
		if (CharLoc != CharSize)
		{
			// Found...
			strcpy (Bitmaps [ListSize], DirectCards [DirectLoc]);
			DirectCards [DirectLoc] [CharLoc] = 0x00;
			int DirectPos;
			for (DirectPos = 0; DirectPos < DirectSize; DirectPos++)
			{
				if (DirectPos != DirectLoc)
				{
					if (DirectCards [DirectPos] [CharLoc] == '.')
					{
						DirectCards [DirectPos] [CharLoc] = 0x00;
						if ((strcmp (DirectCards [DirectPos], DirectCards [DirectLoc])) == 0)
						{
							DirectCards [DirectPos] [CharLoc] = '.';
							if ((strcmp (&DirectCards [DirectPos] [CharLoc], ExtPalette)) == 0)
							{
								strcpy (Palettes [ListSize], DirectCards [DirectPos]);
								DirectCards [DirectPos] [0] = 0x00;
								break;
							}
						}
						else
						{
							DirectCards [DirectPos] [CharLoc] = '.';
						}
					}
				}
			}
			DirectCards [DirectLoc] [0] = 0x00;
			ListSize++;
		}
	}

	// --- Now loading images and converting to tiles ---

	for (ListLoc = 0; ListLoc < ListSize; ListLoc++)
	{
		printf (" -> %s\n", Bitmaps [ListLoc]);
		switch (ImageLoad (&Bitmap, Bitmaps [ListLoc]))
		{
			case 1: printf ("    Error, could not load file\n\nPress enter key to exit...\n"); return (0x00);
			case 2: printf ("    Error, could not allocate memory\n\nPress enter key to exit...\n"); return (0x00);
			case 3: printf ("    Error, fread copy size is wrong\n\nPress enter key to exit...\n"); return (0x00);
			case 4: printf ("    Error, file has a bitmap format unsupported\n\nPress enter key to exit...\n"); return (0x00);
			case 5: printf ("    Error, file does not have a valid bitmap header\n\nPress enter key to exit...\n"); return (0x00);
		}
		if (Bitmap.SizeX != SizeX || Bitmap.SizeY != SizeY)
		{
			free (Bitmap.Data); Bitmap.Data;
			free (Palette.Data); Palette.Data = NULL;
			printf ("    Error, the bitmap is not the same width and height as the others\n\nPress enter key to exit...\n");
			fflush (stdin); getchar ( ); return (0x00);
		}
		if ((Bitmap.SizeX & 7) != 0 && (Bitmap.SizeY & 7) != 0)
		{
			free (Bitmap.Data); Bitmap.Data;
			free (Palette.Data); Palette.Data = NULL;
			printf ("    Error, the image MUST be a multiple of 8 x 8 pixels\n\nPress enter key to exit...\n");
			fflush (stdin); getchar ( ); return (0x00);
		}
		if (Palettes [ListLoc] [0] == 0)
		{
			free (Bitmap.Data); Bitmap.Data;
			printf ("    Error, this bitmap image does not have a palette file\n\nPress enter key to exit...\n");
			fflush (stdin); getchar ( ); return (0x00);
		}
		else
		{
			printf ("    %s\n", Palettes [ListLoc]);
			bool Fail = FALSE;
			switch (ImageLoad (&Palette, Palettes [ListLoc]))
			{
				case 1: printf ("    Error, could not load file\n\nPress enter key to exit...\n"); Fail = TRUE; break;
				case 2: printf ("    Error, could not allocate memory\n\nPress enter key to exit...\n"); Fail = TRUE; break;
				case 3: printf ("    Error, fread copy size is wrong\n\nPress enter key to exit...\n"); Fail = TRUE; break;
				case 4: printf ("    Error, file has a bitmap format unsupported\n\nPress enter key to exit...\n"); Fail = TRUE; break;
				case 5: printf ("    Error, file does not have a valid bitmap header\n\nPress enter key to exit...\n"); Fail = TRUE; break;
			}
			if (Fail == TRUE)
			{
				free (Bitmap.Data); Bitmap.Data;
				return (0x00);
			}
			PalLoc = 1;
			PalSize = 1;
			while (PalLoc < Palette.SizeX)
			{
				if (	Palette.Data [PalLoc].Red   != Palette.Data [PalSize - 1].Red	||
					Palette.Data [PalLoc].Green != Palette.Data [PalSize - 1].Green	||
					Palette.Data [PalLoc].Blue  != Palette.Data [PalSize - 1].Blue	)
				{
					Palette.Data [PalSize].Red   = Palette.Data [PalLoc].Red;
					Palette.Data [PalSize].Green = Palette.Data [PalLoc].Green;
					Palette.Data [PalSize].Blue  = Palette.Data [PalLoc].Blue;
					PalSize++;
				}
				PalLoc++;
			}
			if (PalSize > 0x10)
			{
				free (Bitmap.Data); Bitmap.Data = NULL;
				free (Palette.Data); Palette.Data = NULL;
				printf ("    Error, the palette has more than 0x10 colours, cannot convert\n\nPress enter key to exit...\n");
				fflush (stdin); getchar ( ); return (0x00);
			}
			Palette.Size = PalSize;
			Palette.SizeX = PalSize;
			Palette.SizeY = 1;
		}
		int PaletteLoc;

		// --- Converting to Mega Drive pixels ---

		char PixelData [SizeX * SizeY] = { 0 };
		for (PosY = SizeY - 1; PosY >= 0; PosY--)
		{
			for (PosX = 0; PosX < SizeX; PosX++)
			{
				int Position = PosX + (PosY * SizeX);
				for (PalLoc = 0; PalLoc < PalSize; PalLoc++)
				{
					if (	Palette.Data [PalLoc].Red   == Bitmap.Data [Position].Red	&&
						Palette.Data [PalLoc].Green == Bitmap.Data [Position].Green	&&
						Palette.Data [PalLoc].Blue  == Bitmap.Data [Position].Blue	)
					{
						break;
					}
				}
				if (PalLoc == PalSize)
				{
					free (Bitmap.Data); Bitmap.Data;
					free (Palette.Data); Palette.Data = NULL;
					printf ("    Error, the card has a colour that is not in the palette at %d x %d\n\nPress enter key to exit...\n", PosX, (SizeY - PosY) - 1);
					fflush (stdin); getchar ( ); return (0x00);
				}
				PixelData [Position] = PalLoc;
			}
		}

		ConvertToTiles (PixelData, SizeX, SizeY);

		// --- Getting directory ---

		int CharLoc = -1;
		int NameLoc = 0;
		int ExtLoc = 0;
		while (Bitmaps [ListLoc] [++CharLoc] != 0x00)
		{
			if (Bitmaps [ListLoc] [CharLoc] == '\\' || Bitmaps [ListLoc] [CharLoc] == '/')
			{
				NameLoc = CharLoc + 1;
			}
			else if (Bitmaps [ListLoc] [CharLoc] == '.')
			{
				ExtLoc = CharLoc;
			}
		}
		if (ExtLoc == 0) { ExtLoc = CharLoc; }

		// --- Tile art ---

		strcpy (&Bitmaps [ListLoc] [ExtLoc], ExtBinary);
		strcpy (&FolderOutput [FolderLoc], &Bitmaps [ListLoc] [NameLoc]);
		File = fopen (FolderOutput, "wb");
		if (File == NULL)
		{
			free (Bitmap.Data); Bitmap.Data;
			free (Palette.Data); Palette.Data = NULL;
			printf ("\n -> Error, could not create tile card file\n\nPress enter key to exit...\n");
			fflush (stdin); getchar ( ); return (0x00);
		}
		int Position;
		char Pixels;
		for (Position = 0; Position < (SizeX * SizeY); Position++)
		{
			Pixels = (Pixels << 4) | (PixelData [Position] & 0x0F);
			if ((Position & 1) != 0)
			{
				fputc (Pixels, File);
			}
		}
		fclose (File);

		// --- Palette ---

		strcpy (&Bitmaps [ListLoc] [ExtLoc], ExtPalMD);
		strcpy (&FolderOutput [FolderLoc], &Bitmaps [ListLoc] [NameLoc]);
		FILE *File = fopen (FolderOutput, "wb");
		if (File == NULL)
		{
			free (Palette.Data); Palette.Data = NULL;
			printf ("\n -> Error, could not create palette file\n\nPress enter key to exit...\n");
			fflush (stdin); getchar ( ); return (0x00);
		}
		for (PalLoc = 0; PalLoc < PalSize; PalLoc++)
		{
			fputc ((Palette.Data [PalLoc].Blue >> 0x04) & 0x0E, File);
			fputc ((Palette.Data [PalLoc].Green & 0xE0) | ((Palette.Data [PalLoc].Red >> 0x04) & 0x0E), File);
		}
		fclose (File);

		free (Bitmap.Data); Bitmap.Data;
		free (Palette.Data); Palette.Data = NULL;
	}

// -----------------------------------------------------------------------------
// Finish
// -----------------------------------------------------------------------------

	printf ("\nPress enter key to exit...\n");
	fflush (stdin);
	getchar ( );
	return (0x00);
}

// =============================================================================
