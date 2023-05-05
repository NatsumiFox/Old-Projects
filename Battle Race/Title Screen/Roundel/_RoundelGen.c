// =============================================================================
// -----------------------------------------------------------------------------
// Roundel art generator
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <dirent.h>
#include <windows.h>
#include "_bitmap.h"
#include "_Settings.h"

#define DOUBLEPIXEL TRUE


const char FileMask [] = { "Mask.bmp" };	// Mask to use for roundel tiles
const char Folder [] = { "Bitmaps" };		// Folder containing the roundel bitmap files and their palettes
const char ExtPalette [] = { ".pal.bmp" };
const char ExtBitmap [] = { ".bmp" };
const char ExtRoundel [] = { ".rou" };
const char ExtPalMD [] = { ".pal" };
int FolderSize;

int main (int ArgNumber, char **ArgList, char **EnvList)

{

	LoadSettings ( );

	// --- Obtaining directories from a folder ---

	printf ("Roundel Generator - by MarkeyJester\n\n");
	DIR *Direct = opendir (Folder);
	if (Direct == NULL)
	{
		printf ("    Error, could not access directory \"%s\"\n\n"
			"Press enter key to exit...\n", Folder);
		fflush (stdin);
		getchar ( );
		return (0x00);
	}
	FILE *File;
	struct dirent *DirEntry;
	int DirectSize = 0;
	while ((DirEntry = readdir (Direct)) != NULL)
	{
	//	if (DirEntry->d_type == DT_REG)
		if (DirEntry->d_name [0] != '.')
		{
			DirectSize++;
		}
	}
	if ((Direct = opendir (Folder)) == NULL)
	{
		printf ("    Error, could not access directory \"%s\"\n\n"
			"Press enter key to exit...\n", Folder);
		fflush (stdin);
		getchar ( );
		return (0x00);
	}
	if (DirectSize == 0)
	{
		printf ("    Directory \"%s\" is empty\n\n"
			"Press enter key to exit...\n", Folder);
		fflush (stdin);
		getchar ( );
		return (0x00);
	}

	for (FolderSize = 0; Folder [FolderSize] != 0x00; FolderSize++) { }

	char Directory [DirectSize] [0x400];
	int DirectLoc = 0;
	while ((DirEntry = readdir (Direct)) != NULL && DirectLoc < DirectSize)
	{
	//	if (DirEntry->d_type == DT_REG)
		if (DirEntry->d_name [0] != '.')
		{
			strcpy (Directory [DirectLoc], Folder);
			Directory [DirectLoc] [FolderSize] = '\\';
			strcpy (&Directory [DirectLoc++] [FolderSize + 1], DirEntry->d_name);
		}
	}
	DirectSize = DirectLoc;

	// --- Working out bitmaps and palettes ---

	char Bitmaps [DirectSize] [0x400];
	char Palettes [DirectSize] [0x400] = { 0 };
	int CharLoc, CharSize;
	int ListLoc, ListSize = 0;
	for (DirectLoc = 0; DirectLoc < DirectSize; DirectLoc++)
	{
		for (CharSize = 0; Directory [DirectLoc] [CharSize] != 0; CharSize++) { }
		for (CharLoc = 0; CharLoc < CharSize; CharLoc++)
		{
			if ((strcmp (&Directory [DirectLoc] [CharLoc], ExtBitmap)) == 0)
			{
				break;
			}
			if (Directory [DirectLoc] [CharLoc] == '.')
			{
				CharLoc = CharSize;
				break;
			}
		}
		if (CharLoc != CharSize)
		{
			// Found...
			strcpy (Bitmaps [ListSize], Directory [DirectLoc]);
			Directory [DirectLoc] [CharLoc] = 0x00;
			int DirectPos;
			for (DirectPos = 0; DirectPos < DirectSize; DirectPos++)
			{
				if (DirectPos != DirectLoc)
				{
					if (Directory [DirectPos] [CharLoc] == '.')
					{
						Directory [DirectPos] [CharLoc] = 0x00;
						if ((strcmp (Directory [DirectPos], Directory [DirectLoc])) == 0)
						{
							Directory [DirectPos] [CharLoc] = '.';
							if ((strcmp (&Directory [DirectPos] [CharLoc], ExtPalette)) == 0)
							{
								strcpy (Palettes [ListSize], Directory [DirectPos]);
								Directory [DirectPos] [0] = 0x00;
								break;
							}
						}
						else
						{
							Directory [DirectPos] [CharLoc] = '.';
						}
					}
				}
			}
			Directory [DirectLoc] [0] = 0x00;
			ListSize++;
		}
	}

	// --- Loading mask ---

	IMG Mask, Bitmap, Palette;
	Mask.Data = NULL;
	Bitmap.Data = NULL;
	Palette.Data = NULL;
	switch (ImageLoad (&Mask, (char*) FileMask))
	{
		case 1: printf ("    Error, could not load \"%s\"\n\nPress enter key to exit...\n", FileMask); fflush (stdin); getchar ( ); return (0x00);
		case 2: printf ("    Error, could not allocate memory for \"%s\"\n\nPress enter key to exit...\n", FileMask); fflush (stdin); getchar ( ); return (0x00);
		case 3: printf ("    Error, fread copy size is wrong for \"%s\"\n\nPress enter key to exit...\n", FileMask); fflush (stdin); getchar ( ); return (0x00);
		case 4: printf ("    Error, \"%s\" has a bitmap format unsupported\n\nPress enter key to exit...\n", FileMask); fflush (stdin); getchar ( ); return (0x00);
		case 5: printf ("    Error, \"%s\" does not have a valid bitmap header\n\nPress enter key to exit...\n", FileMask); fflush (stdin); getchar ( ); return (0x00);
	}
	if ((Mask.SizeX & 7) != 0 && (Mask.SizeY & 7) != 0)
	{
		printf ("    Error, the mask MUST be a multiple of 8 x 8 pixels\n"); free (Mask.Data); Mask.Data = NULL; fflush (stdin); getchar ( ); return (0x00);
	}
	PIX_BGRA PadColour = { 0x00, 0x00, 0x00, 0x00 };
	switch (TruncateImage (&Mask, -PADSIZE, -PADSIZE, Mask.SizeX + PADSIZE, Mask.SizeY + PADSIZE, PadColour))
	{
		case 2: printf ("    Error, could not allocate memory for truncating \"%s\"\n\nPress enter key to exit...\n", FileMask); free (Mask.Data); Mask.Data = NULL; fflush (stdin); getchar ( ); return (0x00);
		case 3: printf ("    Error, resize coordinates result in null image for truncating \"%s\"\n\nPress enter key to exit...\n", FileMask); free (Mask.Data); Mask.Data = NULL; fflush (stdin); getchar ( ); return (0x00);
	}

	char *Roundel = (char*) calloc (Mask.Size * 4, sizeof (char));
	//char *Roundel = (char*) malloc (Mask.Size);
	if (Roundel == NULL)
	{
		free (Mask.Data); Mask.Data = NULL;
		printf ("    Error, could not create roundel memory space\n\nPress enter key to exit...\n");
		fflush (stdin); getchar ( ); return (0x00);
	}
	int RoundelLoc, RoundelSize;

	// --- Now processing the data ---

	for (ListLoc = 0; ListLoc < ListSize; ListLoc++)
	{
		printf (" -> %s\n", Bitmaps [ListLoc]);
		switch (ImageLoad (&Bitmap, Bitmaps [ListLoc]))
		{
			case 1: printf ("    Error, could not load file\n\nPress enter key to exit...\n"); free (Mask.Data); Mask.Data = NULL; free (Roundel); Roundel = NULL; fflush (stdin); getchar ( ); return (0x00);
			case 2: printf ("    Error, could not allocate memory\n\nPress enter key to exit...\n"); free (Mask.Data); Mask.Data = NULL; free (Roundel); Roundel = NULL; fflush (stdin); getchar ( ); return (0x00);
			case 3: printf ("    Error, fread copy size is wrong\n\nPress enter key to exit...\n"); free (Mask.Data); Mask.Data = NULL; free (Roundel); Roundel = NULL; fflush (stdin); getchar ( ); return (0x00);
			case 4: printf ("    Error, file has a bitmap format unsupported\n\nPress enter key to exit...\n"); free (Mask.Data); Mask.Data = NULL; free (Roundel); Roundel = NULL; fflush (stdin); getchar ( ); return (0x00);
			case 5: printf ("    Error, file does not have a valid bitmap header\n\nPress enter key to exit...\n"); free (Mask.Data); Mask.Data = NULL; free (Roundel); Roundel = NULL; fflush (stdin); getchar ( ); return (0x00);
		}
		if ((Bitmap.SizeX & 7) != 0 && (Bitmap.SizeY & 7) != 0)
		{
			printf ("    Error, the image MUST be a multiple of 8 x 8 pixels\n\nPress enter key to exit...\n"); free (Mask.Data); Mask.Data = NULL; free (Roundel); Roundel = NULL; fflush (stdin); getchar ( ); return (0x00);
		}
		switch (TruncateImage (&Bitmap, -PADSIZE, -PADSIZE, Bitmap.SizeX + PADSIZE, Bitmap.SizeY + PADSIZE, Bitmap.Data [0]))
		{
			case 2: printf ("    Error, could not allocate memory for truncating \"%s\"\n\nPress enter key to exit...\n", FileMask); free (Mask.Data); Mask.Data = NULL; fflush (stdin); getchar ( ); return (0x00);
			case 3: printf ("    Error, resize coordinates result in null image for truncating \"%s\"\n\nPress enter key to exit...\n", FileMask); free (Mask.Data); Mask.Data = NULL; fflush (stdin); getchar ( ); return (0x00);
		}

		if (Palettes [ListLoc] [0] == 0)
		{
			printf ("    No palette - Will generate...\n");

			// Need to generate it here please~

		}
		else
		{
			printf ("    %s\n", Palettes [ListLoc]);
			switch (ImageLoad (&Palette, Palettes [ListLoc]))
			{
				case 1: printf ("    Error, could not load file\n\nPress enter key to exit...\n"); free (Mask.Data); Mask.Data = NULL; free (Roundel); Roundel = NULL; fflush (stdin); getchar ( ); return (0x00);
				case 2: printf ("    Error, could not allocate memory\n\nPress enter key to exit...\n"); free (Mask.Data); Mask.Data = NULL; free (Roundel); Roundel = NULL; fflush (stdin); getchar ( ); return (0x00);
				case 3: printf ("    Error, fread copy size is wrong\n\nPress enter key to exit...\n"); free (Mask.Data); Mask.Data = NULL; free (Roundel); Roundel = NULL; fflush (stdin); getchar ( ); return (0x00);
				case 4: printf ("    Error, file has a bitmap format unsupported\n\nPress enter key to exit...\n"); free (Mask.Data); Mask.Data = NULL; free (Roundel); Roundel = NULL; fflush (stdin); getchar ( ); return (0x00);
				case 5: printf ("    Error, file does not have a valid bitmap header\n\nPress enter key to exit...\n"); free (Mask.Data); Mask.Data = NULL; free (Roundel); Roundel = NULL; fflush (stdin); getchar ( ); return (0x00);
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
				free (Roundel); Roundel = NULL;
				free (Mask.Data); Mask.Data = NULL;
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

		// --- Creating roundel art ---

		RoundelSize = 0;
		int Angle = 0;
		for (Angle = 0; Angle < 4; Angle++)
		{
			int PosX, PosY, PosP;
#if DOUBLEPIXEL==FALSE
			for (PosX = 0; PosX < Mask.SizeX - EDGEREMOVE; PosX += 2)
#else
			for (PosX = 0; PosX < Mask.SizeX - EDGEREMOVE; PosX++)
#endif
			{
				for (PosY = Mask.SizeY - 1; PosY >= EDGEREMOVE; PosY--)
				{
#if DOUBLEPIXEL==FALSE
					for (PosP = 0; PosP < 2; PosP++)
#endif
					{
						int MaskPos = PosX + PosP + (PosY * Mask.SizeX);
						int BitmapPos = PosX + PosP + (PosY * Bitmap.SizeX);
				//		if (Mask.Data [MaskPos].Green == 0xFF) // if blue is FF, then red/blue MUST also be...\n);
						{
							for (PaletteLoc = 0; PaletteLoc < Palette.Size; PaletteLoc++)
							{
								if (	Palette.Data [PaletteLoc].Red   == Bitmap.Data [BitmapPos].Red   &&
									Palette.Data [PaletteLoc].Green == Bitmap.Data [BitmapPos].Green &&
									Palette.Data [PaletteLoc].Blue  == Bitmap.Data [BitmapPos].Blue  )
								{
									Roundel [RoundelSize++] = PaletteLoc;
									break;
								}
							}
							if (PaletteLoc == Palette.Size)
							{
								free (Roundel); Roundel = NULL;
								free (Mask.Data); Mask.Data = NULL;
								free (Bitmap.Data); Bitmap.Data = NULL;
								free (Palette.Data); Palette.Data = NULL;
								printf ("    Error, pixel at %d x %d does not match a colour in the palette\n\nPress enter key to exit...\n", PosX + 1, PosY + 1);
								fflush (stdin); getchar ( ); return (0x00);
							}
						}
					}
				}
			}


		// Rotating 90 degrees three times (can't be bothered
		// programming a counter-rotation in bitmap.h...)

			if (RotateImage (&Bitmap) == 1)
			{
				free (Roundel); Roundel = NULL;
				free (Mask.Data); Mask.Data = NULL;
				free (Bitmap.Data); Bitmap.Data = NULL;
				free (Palette.Data); Palette.Data = NULL;
				printf ("    Error, could not allocate memory for image rotation\n\nPress enter key to exit...\n", PosX + 1, PosY + 1);
				fflush (stdin); getchar ( ); return (0x00);
			}
			if (RotateImage (&Bitmap) == 1)
			{
				free (Roundel); Roundel = NULL;
				free (Mask.Data); Mask.Data = NULL;
				free (Bitmap.Data); Bitmap.Data = NULL;
				free (Palette.Data); Palette.Data = NULL;
				printf ("    Error, could not allocate memory for image rotation\n\nPress enter key to exit...\n", PosX + 1, PosY + 1);
				fflush (stdin); getchar ( ); return (0x00);
			}
			if (RotateImage (&Bitmap) == 1)
			{
				free (Roundel); Roundel = NULL;
				free (Mask.Data); Mask.Data = NULL;
				free (Bitmap.Data); Bitmap.Data = NULL;
				free (Palette.Data); Palette.Data = NULL;
				printf ("    Error, could not allocate memory for image rotation\n\nPress enter key to exit...\n", PosX + 1, PosY + 1);
				fflush (stdin); getchar ( ); return (0x00);
			}
		}

		// --- Dumping roundel ---

		for (CharLoc = 0; Bitmaps [ListLoc] [CharLoc] != '.'; CharLoc++) { }

		strcpy (&Bitmaps [ListLoc] [CharLoc], ExtRoundel);
		if ((File = fopen (Bitmaps [ListLoc], "wb")) == NULL)
		{
			free (Roundel); Roundel = NULL;
			free (Mask.Data); Mask.Data = NULL;
			free (Bitmap.Data); Bitmap.Data = NULL;
			free (Palette.Data); Palette.Data = NULL;
			printf ("    Error, could not create roundel file\n\nPress enter key to exit...\n");
			fflush (stdin); getchar ( ); return (0x00);
		}

//	int SingleSize = (Mask.SizeX - EDGEREMOVE) * (Mask.SizeY - EDGEREMOVE);
//	int MiddlePos = (Mask.SizeX / 2) * ((Mask.SizeY - EDGEREMOVE) / 2);

		int Entry, EntryCount;
		for (EntryCount = 0; EntryCount < 4; EntryCount++)
		{
//	int TotalSize = (((Mask.SizeX - (EDGEREMOVE * EntryCount)) * (EntryCount + 1)) * (Mask.SizeY - EDGEREMOVE)) / 2;

			int Entry = ((RoundelSize / 4) * EntryCount) + (RoundelSize / 8) + (4 * 4);
			fputc (Entry >> 0x18, File);
			fputc (Entry >> 0x10, File);
			fputc (Entry >> 0x08, File);
			fputc (Entry >> 0x00, File);
		}
#if DOUBLEPIXEL==FALSE
				// The - 0x300 cuts off 300 bytes from the end of the file
				// This was the amount of space we needed to ensure the
				// data would fit onto the ROM, luckily, this doesn't
				// cause any notice-able issues.
		for (RoundelLoc = 0; RoundelLoc < RoundelSize - 0x300; RoundelLoc += 2)
		{
			fputc ((Roundel [RoundelLoc] << 4) | Roundel [RoundelLoc + 1], File);
		}
#else
		for (RoundelLoc = 0; RoundelLoc < RoundelSize - 0x300; RoundelLoc++)
		{
			fputc ((Roundel [RoundelLoc] << 4) | Roundel [RoundelLoc + Mask.SizeY], File);
		}
#endif
		fclose (File);

		// --- Dumping palette ---

		strcpy (&Bitmaps [ListLoc] [CharLoc], ExtPalMD);
		if ((File = fopen (Bitmaps [ListLoc], "wb")) == NULL)
		{
			free (Roundel); Roundel = NULL;
			free (Mask.Data); Mask.Data = NULL;
			free (Bitmap.Data); Bitmap.Data = NULL;
			free (Palette.Data); Palette.Data = NULL;
			printf ("    Error, could not create palette file\n\nPress enter key to exit...\n");
			fflush (stdin); getchar ( ); return (0x00);
		}
		

		int Blue, Green, Red;
		int Fade = -0xE0;
		for (Fade = -(0xE0+0x20); Fade <= 0xE0; Fade += 0x20)
		{
			for (PaletteLoc = 0; PaletteLoc < Palette.Size; PaletteLoc++)
			{
				Blue = (Palette.Data [PaletteLoc].Blue & 0xE0) + Fade; if (Blue < 0) { Blue = 0; } else if (Blue > 0xE0) { Blue = 0xE0; }
				Green = (Palette.Data [PaletteLoc].Green & 0xE0) + Fade; if (Green < 0) { Green = 0; } else if (Green > 0xE0) { Green = 0xE0; }
				Red = (Palette.Data [PaletteLoc].Red & 0xE0) + Fade; if (Red < 0) { Red = 0; } else if (Red > 0xE0) { Red = 0xE0; }
				fputc ((Blue & 0xE0) >> 4, File);
				fputc ((Green & 0xE0) | ((Red & 0xE0) >> 4), File);


			//	fputc ((Palette.Data [PaletteLoc].Blue & 0xE0) >> 4, File);
			//	fputc ((Palette.Data [PaletteLoc].Green & 0xE0) | ((Palette.Data [PaletteLoc].Red & 0xE0) >> 4), File);
			}
		}
		fclose (File);

		free (Bitmap.Data); Bitmap.Data = NULL;
		free (Palette.Data); Palette.Data = NULL;
	}

	free (Roundel); Roundel = NULL;
	free (Mask.Data); Mask.Data = NULL;

	printf ("\nPress enter key to exit...\n");
	fflush (stdin);
	getchar ( );
	return (0x00);
}

// =============================================================================
