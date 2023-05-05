// =============================================================================
// -----------------------------------------------------------------------------
// Program
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <windows.h>
#include <direct.h>
#include "..\Shots - Raw\_Resources/bitmap.h"
#include "_Shared.c"

// =============================================================================
// -----------------------------------------------------------------------------
// Loading pixel ID from tile correctly
// -----------------------------------------------------------------------------

u_char GetPixel (char *VRAM, int Tile, char PATTERN, int X, int Y, int &MARKPOS)

{
	u_char Pixel;
	switch (PATTERN & 0b00011000)
	{
		case 0b00000000:
		{
			MARKPOS = Tile + ((X & 0x7) >> 1) + ((Y & 0x7) * 4);
			Pixel = VRAM [MARKPOS];
			if ((X & 1) == 0)
			{
				Pixel >>= 4;
			}
			else
			{
				Pixel &= 0x0F;
			}
		}
		break;
		case 0b00001000:
		{
			MARKPOS = Tile + (((X ^ 0x7) & 0x7) >> 1) + ((Y & 0x7) * 4);
			Pixel = VRAM [MARKPOS];
			if ((X & 1) != 0)
			{
				Pixel >>= 4;
			}
			else
			{
				Pixel &= 0x0F;
			}
		}
		break;
		case 0b00010000:
		{
			MARKPOS = Tile + ((X & 0x7) >> 1) + (((Y ^ 0x7) & 0x7) * 4);
			Pixel = VRAM [MARKPOS];
			if ((X & 1) == 0)
			{
				Pixel >>= 4;
			}
			else
			{
				Pixel &= 0x0F;
			}
		}
		break;
		case 0b00011000:
		{
			MARKPOS = Tile + (((X ^ 0x7) & 0x7) >> 1) + (((Y ^ 0x7) & 0x7) * 4);
			Pixel = VRAM [MARKPOS];
			if ((X & 1) != 0)
			{
				Pixel >>= 4;
			}
			else
			{
				Pixel &= 0x0F;
			}
		}
		break;
	}
	return (Pixel);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Rendering a plane
// -----------------------------------------------------------------------------

DrawPixels (char *VRAMMARKER, IMG *Screen, char *VDPREG, char *VRAM, char *Plane, char *CRAM, short *HSCROLL, short *VSCROLL, bool Priority, char *WindowArt, bool WindowRead)

{
	int CountX, CountY, PosX, PosY;
	for (CountY = 0, PosY = Screen->SizeY - 1; PosY >= 0; CountY++, PosY--)
	{
		CountX = 0;
		if ((VDPREG [0] & 0b00100000) != 0)
		{
			CountX = 8;
		}
		for (PosX = 0; PosX < Screen->SizeX; CountX++, PosX++)
		{
			int ScreenLoc = PosX + (PosY * Screen->SizeX);

			short ScanX = -HSCROLL [CountY];
			short ScanY = VSCROLL [((CountX - (ScanX & 0x0F)) >> 0x04) + 1];

			ScanX += CountX;
			ScanY += CountY;

			int PlanePos = ((ScanX >> 3) & ((((VDPREG [0x10] & 0b11)+1) << 0x05)-1)) * 2;
			PlanePos += (((ScanY >> 3) & ((((VDPREG [0x10] & 0b110000)+0b10000) << 0x01)-1)) * ((((VDPREG [0x10] & 0b11)+1) << 0x05) * 2));
			PlanePos &= 0x1FFF;

			int Tile = (Plane [PlanePos] & 0xFF) << 0x08;
			Tile |= Plane [PlanePos + 1] & 0xFF;

			Tile = (Tile *= 0x20) & 0xFFFF;
			if ((Plane [PlanePos] & 0b10000000) == 0)
			{
				if (Priority == TRUE)
				{
					continue;
				}
			}
			else
			{
				if (Priority == FALSE)
				{
					continue;
				}
			}

		VRAMMARKER [(Plane-VRAM) + PlanePos] = 0xFF;
		VRAMMARKER [(Plane-VRAM) + PlanePos + 1] = 0xFF;

		int MARKPOS;
			u_char Pixel = GetPixel (VRAM, Tile, Plane [PlanePos], ScanX, ScanY, MARKPOS);

			Pixel <<= 1;
			int Palette = Plane [PlanePos] & 0b01100000;

			if (Pixel == 0)	// Transparency...
			{
				continue;
			}
			if (WindowRead == TRUE)
			{
				if (WindowArt [ScreenLoc] != 0)
				{
					continue;
				}
			}
		VRAMMARKER [MARKPOS] = 0xFF;
			Screen->Data [ScreenLoc].Red   = (CRAM [Palette + Pixel + 0] & 0x0E) << 0x04;
			Screen->Data [ScreenLoc].Green = (CRAM [Palette + Pixel + 0] & 0xE0) << 0x00;
			Screen->Data [ScreenLoc].Blue  = (CRAM [Palette + Pixel + 1] & 0x0E) << 0x04;
		}
	}
}

// =============================================================================
// -----------------------------------------------------------------------------
// Rendering window
// -----------------------------------------------------------------------------

DrawWindow (char *VRAMMARKER, IMG *Screen, char *VDPREG, char *VRAM, char *Plane, char *CRAM, bool Priority, char *WindowArt)

{
	int WindowX = VDPREG [0x11] & 0b10011111;
	if ((WindowX & 0b10000000) == 0)
	{
		WindowX &= 0b00011111;
		WindowX *= 0x10;
	}
	else
	{
		WindowX &= 0b00011111;
		WindowX *= 0x10;
		WindowX += 0x10;
		WindowX = -WindowX;
	}
	int WindowY = VDPREG [0x12] & 0b10011111;
	if ((WindowY & 0b10000000) == 0)
	{
		WindowY &= 0b00011111;
		WindowY *= 0x08;
	}
	else
	{
		WindowY &= 0b00011111;
		WindowY ^= 0b00011111;
		WindowY *= 0x08;
		WindowY += 0x08;
		WindowY = -WindowY;
	}
	int WindYRange = 0x100;
	int WindXRange = 0x100; // Not sure about this, might need to be 0x200 always...
	if ((VDPREG [0x0C] & 0b10000001) == 0b10000001)
	{
		WindXRange = 0x200;
	}

	int CountX, CountY, PosX, PosY;
	for (CountY = 0, PosY = Screen->SizeY - 1; PosY >= 0; CountY++, PosY--)
	{
		CountX = 0;
		if ((VDPREG [0] & 0b00100000) != 0)
		{
			CountX = 8;
			if (WindowX >= 0)
			{
				WindowX -= 8;
			}
		}
		for (PosX = 0; PosX < Screen->SizeX; CountX++, PosX++)
		{
			if (WindowX >= 0)
			{
				if (CountX >= WindowX)
				{
					if (WindowY >= 0)
					{
						if (CountY >= WindowY)
						{
							continue;
						}
					}
					else
					{
						if (CountY < WindYRange + WindowY)
						{
							continue;
						}
					}
				}
			}
			else
			{
				if (CountX < WindXRange + WindowX)
				{
					if (WindowY >= 0)
					{
						if (CountY >= WindowY)
						{
							continue;
						}
					}
					else
					{
						if (CountY < WindYRange + WindowY)
						{
							continue;
						}
					}
				}
			}
			int ScreenLoc = PosX + (PosY * Screen->SizeX);

		WindowArt [ScreenLoc] = 0xFF;

			int PlanePos;
			if ((VDPREG [0x0C] & 0b10000001) == 0b10000001)
			{
				PlanePos = ((CountX >> 3) & 0x003F) * 2;
				PlanePos += (CountY & 0xF8) << 0x04;
			}
			else
			{
				PlanePos = ((CountX >> 3) & 0x001F) * 2;
				PlanePos += (CountY & 0xF8) << 0x02;
			}

			int Tile = (Plane [PlanePos] & 0xFF) << 0x08;
			Tile |= Plane [PlanePos + 1] & 0xFF;

			Tile = (Tile *= 0x20) & 0xFFFF;

			if ((Plane [PlanePos] & 0b10000000) == 0)
			{
				if (Priority == TRUE)
				{
					continue;
				}
			}
			else
			{
				if (Priority == FALSE)
				{
					continue;
				}
			}

		int MARKPOS;
			u_char Pixel = GetPixel (VRAM, Tile, Plane [PlanePos], CountX, CountY, MARKPOS);

		VRAMMARKER [(Plane-VRAM) + PlanePos] = 0xFF;
		VRAMMARKER [(Plane-VRAM) + PlanePos + 1] = 0xFF;


			Pixel <<= 1;
			int Palette = Plane [PlanePos] & 0b01100000;

			if (Pixel == 0)	// Transparency...
			{
				continue;
			}
		VRAMMARKER [MARKPOS] = 0xFF;
			Screen->Data [ScreenLoc].Red   = (CRAM [Palette + Pixel + 0] & 0x0E) << 0x04;
			Screen->Data [ScreenLoc].Green = (CRAM [Palette + Pixel + 0] & 0xE0) << 0x00;
			Screen->Data [ScreenLoc].Blue  = (CRAM [Palette + Pixel + 1] & 0x0E) << 0x04;
		}
	}
}

// =============================================================================
// -----------------------------------------------------------------------------
// Rendering sprites
// -----------------------------------------------------------------------------

DrawSprites (char *VRAMMARKER, IMG *Screen, char *VDPREG, char *VRAM, char *Sprite, char *CRAM, bool Priority, char *LowArt)

{

	// Need to render in reverse order, so...
	// ...generating a list of sprites in priority order of link ID

	int Entry, SpriteID = 0x00;
	char SpriteOrder [0x50];
	int SpriteSize = 0;
	do
	{
		SpriteOrder [SpriteSize++] = SpriteID;
		Entry = SpriteID << 0x03;
		SpriteID = Sprite [Entry + 0x03];

			int MARKCOUNT;
			for (MARKCOUNT = 0; MARKCOUNT < 8; MARKCOUNT++)
			{
				VRAMMARKER [(Sprite-VRAM) + Entry + MARKCOUNT] = 0xFF;
			}
	}
	while (SpriteID != 0x00 && SpriteID < 0x50);

	int CountX, CountY;
	do
	{
		SpriteID = SpriteOrder [--SpriteSize];
		Entry = SpriteID << 0x03;
		if ((Sprite [Entry + 4] & 0b10000000) == 0)
		{
			if (Priority == TRUE)
			{
				continue;
			}
		}
		else
		{
			if (Priority == FALSE)
			{
				continue;
			}
		}
		int PosX = Sprite [Entry + 6] << 0x08;
		PosX |= Sprite [Entry + 7] & 0xFF;
		int PosY = Sprite [Entry + 0] << 0x08;
		PosY |= Sprite [Entry + 1] & 0xFF;
		PosX &= 0x1FF;
		PosY &= 0x1FF;
		PosX -= 0x80;
		PosY -= 0x80;
		if ((VDPREG [0] & 0b00100000) != 0)
		{
			PosX -= 8;
		}
		int Tile = (Sprite [Entry + 4] & 0xFF) << 0x08;
		Tile |= Sprite [Entry + 5] & 0xFF;
		Tile = (Tile * 0x20) & 0xFFFF;
		int Palette = Sprite [Entry + 4] & 0b01100000;


		int TileX = 0;
		int AdvX = 8;
		if ((Sprite [Entry + 4] & 0b00001000) != 0)
		{
			TileX = (Sprite [Entry + 2] & 0b00001100) << 1;
			AdvX = -8;
		}

		CountX = (Sprite [Entry + 2] & 0b00001100) >> 2;
		do
		{
			int TileY = 0;
			int AdvY = 8;
			if ((Sprite [Entry + 4] & 0b00010000) != 0)
			{
				TileY = (Sprite [Entry + 2] & 0b00000011) << 3;
				AdvY = -8;
			}
			CountY = Sprite [Entry + 2] & 0b00000011;
			do
			{
				int RenderX, RenderY;
				for (RenderY = 0x00; RenderY < 8; RenderY++)
				{
					for (RenderX = 0x00; RenderX < 8; RenderX++)
					{
						int X = PosX + RenderX + TileX;
						int Y = PosY + RenderY + TileY;
						if (X >= 0 && X < Screen->SizeX && Y >= 0 && Y < Screen->SizeY)
						{

							int ScreenLoc = X + ((Screen->SizeY - (Y + 1)) * Screen->SizeX);
					int MARKPOS;
							u_char Pixel = GetPixel (VRAM, Tile, Sprite [Entry + 4], RenderX, RenderY, MARKPOS);
							Pixel <<= 1;
							if (Pixel == 0)	// Transparency...
							{
								continue;
							}
							if (Priority == FALSE)
							{
								LowArt [ScreenLoc] = SpriteID; // Save sprite's link ID for high plane later...
							}
							else
							{
								if (LowArt [ScreenLoc] < SpriteID)
								{
									continue; // DO NOT RENDER, there is a higher priority sprite with low plane on...
								}
							}
					VRAMMARKER [MARKPOS] = 0xFF;
							Screen->Data [ScreenLoc].Red   = (CRAM [Palette + Pixel + 0] & 0x0E) << 0x04;
							Screen->Data [ScreenLoc].Green = (CRAM [Palette + Pixel + 0] & 0xE0) << 0x00;
							Screen->Data [ScreenLoc].Blue  = (CRAM [Palette + Pixel + 1] & 0x0E) << 0x04;
						}
					}
				}
				Tile += 0x20;
				TileY += AdvY;
			}
			while (CountY-- > 0);
			TileX += AdvX;
		}
		while (CountX-- > 0);
	}
	while (SpriteSize != 0x00);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Entry point
// -----------------------------------------------------------------------------

int main (int ArgNumber, char **ArgList, char **EnvList)

{
	printf ("Stateshot - by MarkeyJester\n");
	if (ArgNumber <= 0x01)
	{
		printf ("\n -> Drag and drop one or more savestates to take a Museum snapshot\n"
			"\nPress enter key to exit...\n");
		fflush (stdin); getchar ( ); return (0x00);
	}


	char FILENAMEDERP [] = { "_Icon Palette.bmp" };
	IMG Palette;
	if (ImageLoad (&Palette, FILENAMEDERP) != 0)
	{
		printf ("    Error, could not load icon palette\n"
			"\nPress enter key to exit...\n");
		fflush (stdin); getchar ( ); return (0x00);
	}


	int CountX, CountY, PalLoc = 0;
	for (CountY = 0; CountY < Palette.SizeY; CountY += 8)
	{
		for (CountX = 0; CountX < Palette.SizeX; CountX += 8)
		{
			int SourceLoc = CountX + (CountY * Palette.SizeX);
			Palette.Data [PalLoc].Red   = Palette.Data [SourceLoc].Red;
			Palette.Data [PalLoc].Green = Palette.Data [SourceLoc].Green;
			Palette.Data [PalLoc].Blue  = Palette.Data [SourceLoc].Blue;
			PalLoc++;
		}
	}
	Palette.SizeX >>= 3;
	Palette.SizeY >>= 3;
	Palette.Size = Palette.SizeX * Palette.SizeY;

	FILE *File = fopen ("_Icon Palette.bin", "wb");
	if (File == NULL)
	{
		free (Palette.Data); Palette.Data = NULL;
		printf ("    Error, could not create icon palette file\n"
			"\nPress enter key to exit...\n");
		fflush (stdin); getchar ( ); return (0x00);
	}
	for (PalLoc = 0; PalLoc < Palette.Size; PalLoc++)
	{
		if ((PalLoc & 0x0F) == 0)
		{
			fputc (0x00, File);
			fputc (0x00, File);
		}
		else
		{
			fputc ((Palette.Data [PalLoc].Blue >> 0x04) & 0x0E, File);
			fputc ((Palette.Data [PalLoc].Green & 0xE0) | ((Palette.Data [PalLoc].Red & 0xE0) >> 4), File);
		}
	}
	fclose (File);

	char Directory [0x1000];
	char *FileName, *ExtName;
	int ArgCount = 0x00;
	while (++ArgCount < ArgNumber)
	{
		int DirectoryLoc = snprintf (Directory, 0x1000, "%s", ArgList [ArgCount]);
		ExtName = &Directory [DirectoryLoc];
		bool ExtFound = FALSE, FileFound = FALSE;
		while (--DirectoryLoc != 0x00)
		{
			if (Directory [DirectoryLoc] == '.' && ExtFound == FALSE)
			{
				ExtFound = TRUE;
				ExtName = &Directory [DirectoryLoc];
			}
			if ((Directory [DirectoryLoc] == '\\' || Directory [DirectoryLoc] == '/') && FileFound == FALSE)
			{
				FileFound = TRUE;
				FileName = &Directory [DirectoryLoc + 1];
			}
		}
		if (*ExtName == 0x00)
		{
			continue; // cannot make folder the same name as a file without an extension name
		}
		printf ("\n -> %s\n", FileName);

	// --- Loading file ---

		File = fopen (Directory, "rb");
		if (File == NULL)
		{
			free (Palette.Data); Palette.Data = NULL;
			printf ("    Error, could not open the file\n"
				"\nPress enter key to exit...\n");
			fflush (stdin); getchar ( ); return (0x00);
		}
		fseek (File, 0x00, SEEK_END);
		int StateSize = ftell (File);
		char *State = (char*) malloc (StateSize);
		if (State == NULL)
		{
			free (Palette.Data); Palette.Data = NULL;
			fclose (File);
			printf ("    Error, could not create memory for the file\n"
				"\nPress enter key to exit...\n");
			fflush (stdin); getchar ( ); return (0x00);
		}
		rewind (File);
		int ReadSize = fread (State, 0x01, StateSize, File);
		fclose (File);
		if (ReadSize != StateSize)
		{
			free (Palette.Data); Palette.Data = NULL;
			free (State); State = NULL;
			printf ("    Error, fread size incorrect (Copied %X out of %X\n"
				"\nPress enter key to exit...\n", ReadSize, StateSize);
			fflush (stdin); getchar ( ); return (0x00);
		}

	// --- Directory ---

		FileName = ExtName;
		*FileName++ = '\\';
		*FileName = 0x00;
		mkdir (Directory);

	// --- Splitting ---

		int Count, Pos;

		char *VDPREG = &State [0x000000FA];
		char *VRAM = &State [0x00012478];
		char *CRAM = &State [0x00000112];
		char *VSRAM = &State [0x00000192];

		int HScrollPos =      (VDPREG [0x0D] & 0b00111111) << 0x0A;
		char *PlaneA = &VRAM [(VDPREG [0x02] & 0b00111000) << 0x0A];
		char *Window = &VRAM [(VDPREG [0x03] & 0b00111110) << 0x0A];
		char *PlaneB = &VRAM [(VDPREG [0x04] & 0b00000111) << 0x0D];
		char *Sprite = &VRAM [(VDPREG [0x05] & 0b01111111) << 0x09];
		if ((VDPREG [0x0C] & 0b10000001) == 0b10000001)
		{
			Window = &VRAM [(VDPREG [0x03] & 0b00111100) << 0x0A];
			Sprite = &VRAM [(VDPREG [0x05] & 0b01111110) << 0x09];
		}

		// Loading H-scroll

		short HSCROLLA [240];
		short HSCROLLB [240];
		if ((VDPREG [0x0B] & 0b00000011) == 0b00)
		{
			for (Count = 0; Count < 240; Count++)
			{
				HSCROLLA [Count] = VRAM [HScrollPos + 0] << 0x08;
				HSCROLLA [Count] |= VRAM [HScrollPos + 1] & 0xFF;
				HSCROLLB [Count] = VRAM [HScrollPos + 2] << 0x08;
				HSCROLLB [Count] |= VRAM [HScrollPos + 3] & 0xFF;
			}
		}
		else if ((VDPREG [0x0B] & 0b00000011) == 0b10)
		{
			for (Count = 0; Count < 240; Count++)
			{
				HSCROLLA [Count] = VRAM [HScrollPos + 0 + ((Count & -8) * 4)] << 0x08;
				HSCROLLA [Count] |= VRAM [HScrollPos + 1 + ((Count & -8) * 4)] & 0xFF;
				HSCROLLB [Count] = VRAM [HScrollPos + 2 + ((Count & -8) * 4)] << 0x08;
				HSCROLLB [Count] |= VRAM [HScrollPos + 3 + ((Count & -8) * 4)] & 0xFF;
			}
		}
		else
		{
			int Pos = HScrollPos;
			for (Count = 0; Count < 240; Count++)
			{
				HSCROLLA [Count] = VRAM [Pos++] << 0x08;
				HSCROLLA [Count] |= VRAM [Pos++] & 0xFF;
				HSCROLLB [Count] = VRAM [Pos++] << 0x08;
				HSCROLLB [Count] |= VRAM [Pos++] & 0xFF;
			}
		}

		// Loading V-scroll


		short VSCROLLA [20 + 1];
		short VSCROLLB [20 + 1];
		if ((VDPREG [0x0B] & 0b00000100) == 0b000)
		{
			for (Count = 0; Count < 20 + 1; Count++)
			{
				VSCROLLA [Count] = VSRAM [0] << 0x08;
				VSCROLLA [Count] |= VSRAM [1] & 0xFF;
				VSCROLLB [Count] = VSRAM [2] << 0x08;
				VSCROLLB [Count] |= VSRAM [3] & 0xFF;
			}
		}
		else
		{
			for (Count = 0; Count < 20; Count++)
			{
				VSCROLLA [Count + 1] = VSRAM [(Count * 4) + 0] << 0x08;
				VSCROLLA [Count + 1] |= VSRAM [(Count * 4) + 1] & 0xFF;
				VSCROLLB [Count + 1] = VSRAM [(Count * 4) + 2] << 0x08;
				VSCROLLB [Count + 1] |= VSRAM [(Count * 4) + 3] & 0xFF;
			}
			VSCROLLA [0] = VSCROLLA [19 + 1] & VSCROLLB [19 + 1];
			VSCROLLB [0] = VSCROLLA [19 + 1] & VSCROLLB [19 + 1];
		}


		char VRAMMARKER [0x10000] = { 0x00 };


		IMG Screen;

		Screen.SizeX = 256;
		Screen.SizeY = 224;

		if ((VDPREG [0x00] & 0b00100000) != 0)
		{
			Screen.SizeX -= 8;
		}
		if ((VDPREG [0x0C] & 0b10000001) == 0b10000001)
		{
			Screen.SizeX += 320-256;
		}
		if ((VDPREG [0x01] & 0b00001000) != 0)
		{
			Screen.SizeY += 240-224;
		}
		Screen.Size = (Screen.SizeX * Screen.SizeY);
		if ((Screen.Data = (PIX_BGRA*) malloc (Screen.Size * sizeof (PIX_BGRA))) == NULL)
		{
			free (Palette.Data); Palette.Data = NULL;
			free (State); State = NULL;
			printf ("    Error, cannot allocate memory for screen preview\n"
				"\nPress enter key to exit...\n");
			fflush (stdin); getchar ( ); return (0x00);
		}

		PIX_BGRA Colour;
		Colour.Red   = CRAM [((VDPREG [0x07] & 0b00111111) << 1) + 0] << 0x04;
		Colour.Green = CRAM [((VDPREG [0x07] & 0b00111111) << 1) + 0] << 0x00;
		Colour.Blue  = CRAM [((VDPREG [0x07] & 0b00111111) << 1) + 1] << 0x04;
		for (Count = 0; Count < Screen.Size; Count++)
		{
			Screen.Data [Count].Red   = Colour.Red;
			Screen.Data [Count].Green = Colour.Green;
			Screen.Data [Count].Blue  = Colour.Blue;
		}

		// Since low plane sprites with a higher link ID
		// can display infront of high plane sprites with a lower
		// link ID, I need a way to render low plane sprites over
		// high plane sprites with lower ID, whilst allowing planes
		// to render if they are higher...

		// DrawSprites subroutine will use this...
		// If priority is FALSE, the routine will set the pixels in LowArt where the sprite art is rendered
		// If priority is TRUE, the routine will read the pixels in LowArt, and if set, will not draw the pixel

		char *LowArt = (char*) malloc (Screen.Size);
		if (LowArt == NULL)
		{
			free (Palette.Data); Palette.Data = NULL;
			free (Screen.Data); Screen.Data = NULL;
			free (State); State = NULL;
			printf ("    Error, cannot allocate memory for low priority sprite art storage\n"
				"\nPress enter key to exit...\n");
			fflush (stdin); getchar ( ); return (0x00);
		}
		for (Count = 0; Count < Screen.Size; Count++)
		{
			LowArt [Count] = 0x7F; // Set to lowest priority by default
		}

		// Plane A cannot display in places where the Window is
		// displaying, hence a need for a similar flag setting system
		// to the sprites

		char *WindowArt = (char*) malloc (Screen.Size);
		if (WindowArt == NULL)
		{
			free (Palette.Data); Palette.Data = NULL;
			free (LowArt); LowArt = NULL;
			free (Screen.Data); Screen.Data = NULL;
			free (State); State = NULL;
			printf ("    Error, cannot allocate memory for window mask storage\n"
				"\nPress enter key to exit...\n");
			fflush (stdin); getchar ( ); return (0x00);
		}
		for (Count = 0; Count < Screen.Size; Count++)
		{
			WindowArt [Count] = 0x00; // mark as not set
		}

		DrawPixels (VRAMMARKER, &Screen, VDPREG, VRAM, PlaneB, CRAM, HSCROLLB, VSCROLLB, FALSE, WindowArt, FALSE);
		DrawWindow (VRAMMARKER, &Screen, VDPREG, VRAM, Window, CRAM, FALSE, WindowArt);
		DrawPixels (VRAMMARKER, &Screen, VDPREG, VRAM, PlaneA, CRAM, HSCROLLA, VSCROLLA, FALSE, WindowArt, TRUE);
		DrawSprites (VRAMMARKER, &Screen, VDPREG, VRAM, Sprite, CRAM, FALSE, LowArt);
		DrawPixels (VRAMMARKER, &Screen, VDPREG, VRAM, PlaneB, CRAM, HSCROLLB, VSCROLLB, TRUE, WindowArt, FALSE);
		DrawWindow (VRAMMARKER, &Screen, VDPREG, VRAM, Window, CRAM, TRUE, WindowArt);
		DrawPixels (VRAMMARKER, &Screen, VDPREG, VRAM, PlaneA, CRAM, HSCROLLA, VSCROLLA, TRUE, WindowArt, TRUE);
		DrawSprites (VRAMMARKER, &Screen, VDPREG, VRAM, Sprite, CRAM, TRUE, LowArt);

		free (WindowArt); WindowArt = NULL;
		free (LowArt); LowArt = NULL;

		strcpy (FileName, "Preview.bmp");
		SaveBMP (&Screen, Directory, 24);

		int ScrollHeight = Screen.SizeY;
		int CountAdv = 1;
		if ((VDPREG [0x0B] & 0b00000011) == 0b00)
		{
			ScrollHeight = 1;
		}
		else if ((VDPREG [0x0B] & 0b00000011) == 0b10)
		{
			CountAdv = 8;
		}
		for (Count = 0; Count < ScrollHeight; Count += CountAdv)
		{
			VRAMMARKER [HScrollPos + (Count * 4) + 0] = 0xFF;
			VRAMMARKER [HScrollPos + (Count * 4) + 1] = 0xFF;
			VRAMMARKER [HScrollPos + (Count * 4) + 2] = 0xFF;
			VRAMMARKER [HScrollPos + (Count * 4) + 3] = 0xFF;
		}

	// --- Masking out unused graphics/data... ---

		for (Count = 0; Count < 0x10000; Count++)
		{
			VRAM [Count] &= VRAMMARKER [Count];
		}



	/*	File = fopen ("Marker.bin", "wb");
		for (Count = 0; Count < 0x10000; Count++)
		{
			fputc (VRAMMARKER [Count], File);
		}
		fclose (File);	*/

/*	;	move.w	#$8000|%00000100,(a6)			; 00LH 01CD - Leftover SMS bar (0N|1Y) | H-Interrupt (0N|1Y) | H,V Counter (0N|1Y) | Disable video signal (0N|1Y)
	;	move.w	#$8100|%00110100,(a6)			; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
	;	move.w	#$8200|((($C000)>>$0A)&$FF),(a6)	; 00FE DCBA - Scroll Plane A Map Table VRam address
	;	move.w	#$8300|((($F000)>>$0A)&$FF),(a6)	; 00FE DCB0 / 00FE DC00 (20 H-resol) - Window Plane A Map Table VRam address
	;	move.w	#$8400|((($E000)>>$0D)&$FF),(a6)	; 0000 0FED - Scroll Plane B Map Table VRam address
	;	move.w	#$8500|((($B800)>>$09)&$FF),(a6)	; 0FED CBA9 / 0FED CBA0 (20 H-resol) - Sprite Plane Map Table VRam address
	;	move.w	#$8600|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
	;	move.w	#$8700|$00,(a6)				; 00PP CCCC - Backdrop Colour: Palette Line | Colour ID
	;	move.w	#$8800|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
	;	move.w	#$8900|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
	;	move.w	#$8A00|$DF,(a6)				; 7654 3210 - H-Interrupt Register
	;	move.w	#$8B00|%00000000,(a6)			; 0000 EVHH - External Interrupt (0N|1Y) | V-Scroll (0-Full|1-2Celled) | H-Scroll: (00-Full|10-Celled|11-Sliced)
	;	move.w	#$8C00|%10000001,(a6)			; APHE SNNB - H-resol (0N|1Y) | Pixel int (0N|1Y) | H-sync (0N|1Y) | Extern-pix (0N|1Y) | S/H (0N|1Y) | Interlace (00N|01Y|11-Split) | H-resol (0-20|1-28)
	;	move.w	#$8D00|((($BC00)>>$0A)&$FF),(a6)	; 00FE DCBA - Horizontal Scroll Table VRam address
	;	move.w	#$8E00|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
	;	move.w	#$8F00|$02,(a6)				; 7654 3210 - Auto Increament
	;	move.w	#$9000|%00000011,(a6)			; 00VV 00HH - Plane Y Size (00-20|01-40|11-80) | Plane X size (00-20|01-40|11-80)
	;	move.w	#$9100|$00,(a6)				; 7654 3210 - Window Horizontal Position
	;	move.w	#$9200|$00,(a6)				; 7654 3210 - Window Vertical Position
	*/

		VDPREG [0x00] &= 0b11101100;	// Disabling H-blank, also handling video signal and H/V counter, incase the savestate gets ideas...
		VDPREG [0x01] |= 0b01110100;	// Some games like to disable the display and V-blank triggers, and the DMA bit
		VDPREG [0x0F] = 0x02;		// Forcing auto-increment to 2 (don't want any funny business thanks...)
		VDPREG [0x0A] = 0xDF;		// Forcing H-blank to not occur
		VDPREG [0x0B] &= 0b11110111;	// No external interrupt thank you.

	// --- Creating icon ---

		PIX_BGRA PadColour = { 0, 0, 0, 0 };
	//	TruncateImage (&Screen, 140, 104, 180, 120, PadColour);
	//	ResizeImage (&Screen, 6 * 8, 4 * 8);
		int ActualSizeX, ActualSizeY;
		ResizeImage (&Screen, 6 * 8, 4 * 8, PadColour, BH_STRETCH, TRUE, ActualSizeX, ActualSizeY, 0, 0);

#if ICONBOARDER==TRUE
	for (CountX = 0; CountX < Screen.SizeX; CountX++)
	{
		Screen.Data [CountX].Red  = 0;
		Screen.Data [CountX].Green = 0;
		Screen.Data [CountX].Blue  = 0;
		Screen.Data [CountX + ((Screen.SizeY - 1) * Screen.SizeX)].Red  = 0;
		Screen.Data [CountX + ((Screen.SizeY - 1) * Screen.SizeX)].Green = 0;
		Screen.Data [CountX + ((Screen.SizeY - 1) * Screen.SizeX)].Blue  = 0;
	}
	for (CountY = 1; CountY < Screen.SizeY - 1; CountY++)
	{
		Screen.Data [CountY * Screen.SizeX].Red  = 0;
		Screen.Data [CountY * Screen.SizeX].Green = 0;
		Screen.Data [CountY * Screen.SizeX].Blue  = 0;
		Screen.Data [(CountY * Screen.SizeX) + (Screen.SizeX - 1)].Red  = 0;
		Screen.Data [(CountY * Screen.SizeX) + (Screen.SizeX - 1)].Green = 0;
		Screen.Data [(CountY * Screen.SizeX) + (Screen.SizeX - 1)].Blue  = 0;
	}
#endif

		int ScreenLoc;
		for (ScreenLoc = 0; ScreenLoc < Screen.Size; ScreenLoc++)
		{
			short BestFused, BestLoc = 0;
			for (CountY = 0; CountY < Palette.SizeY; CountY++)
			{
				for (CountX = 1; CountX < Palette.SizeX; CountX++)
				{
					PalLoc = CountX + (CountY * Palette.SizeX);
					short Red = Screen.Data [ScreenLoc].Red - Palette.Data [PalLoc].Red;
					if (Red < 0)
					{
						Red = -Red;
					}
					short Green = Screen.Data [ScreenLoc].Green - Palette.Data [PalLoc].Green;
					if (Green < 0)
					{
						Green = -Green;
					}
					short Blue = Screen.Data [ScreenLoc].Blue - Palette.Data [PalLoc].Blue;
					if (Blue < 0)
					{
						Blue = -Blue;
					}
					if (BestLoc != 0)
					{
						int CurFused = Red + Green + Blue;
						if (CurFused > BestFused)
						{
							continue;
						}
					}
					BestFused = Red + Green + Blue;
					BestLoc = PalLoc;
				}
			}
			Screen.Data [ScreenLoc].Red   = Palette.Data [BestLoc].Red;
			Screen.Data [ScreenLoc].Green = Palette.Data [BestLoc].Green;
			Screen.Data [ScreenLoc].Blue  = Palette.Data [BestLoc].Blue;
			Screen.Data [ScreenLoc].Alpha = BestLoc;
		}

		strcpy (FileName, "Icon.bmp");
		SaveBMP (&Screen, Directory, 24);

		char *IconTiles = (char*) malloc ((((Screen.SizeX >> 3) * (Screen.SizeY >> 3)) * 0x20) * Palette.SizeY);
		if (IconTiles == NULL)
		{
			free (Palette.Data); Palette.Data = NULL;
			free (Screen.Data); Screen.Data = NULL;
			free (State); State = NULL;
			printf ("    Error, cannot allocate memory for icon tiles\n"
				"\nPress enter key to exit...\n");
			fflush (stdin); getchar ( ); return (0x00);
		}
		int Line;
		int PixelCount = 0;
		int IconLoc, IconSize = 0;
		for (Line = 0; Line < Palette.SizeY; Line++)
		{
			for (CountX = 0; CountX < Screen.SizeX; CountX += 8)
			{
				for (CountY = Screen.SizeY - 1; CountY >= 0; CountY--)
				{
					int TileX;
					for (TileX = 0; TileX < 8; TileX++)
					{
						ScreenLoc = CountX + TileX + (CountY * Screen.SizeX);
						int Pixel = Screen.Data [ScreenLoc].Alpha;
						if ((Pixel & 0xF0) != (Line << 0x04))
						{
							Pixel = 0;
						}
						if ((PixelCount++ & 1) == 0)
						{
							IconTiles [IconSize] = Pixel << 0x04;
						}
						else
						{
							IconTiles [IconSize++] |= Pixel & 0x0F;
						}
					}
				}
			}
		}
		free (Screen.Data); Screen.Data = NULL;

		strcpy (FileName, "Icon.twiz");
		if (PackData (IconTiles, IconSize, Directory) != 0)
		{
			free (IconTiles); IconTiles = NULL;
			free (State); State = NULL;
			continue;
		}

		free (IconTiles); IconTiles = NULL;

	// --- Packing data ---

		strcpy (FileName, "VRAMA.twiz");
		if (PackData (&VRAM [0x0000], 0x8000, Directory) != 0) { free (State); State = NULL; continue; }
		strcpy (FileName, "VRAMB.twiz");
		if (PackData (&VRAM [0x8000], 0x8000, Directory) != 0) { free (State); State = NULL; continue; }

		// Putting CRAM and VSRAM together as "Internal RAM", since compressing palette/V-scroll
		// is probably foolish anyway...  But we'll see
		// Also including VDP register data

		char IRAM [0x80+0x50+0x18];
		for (Count = 0; Count < 0x80; Count += 0x02)
		{
			IRAM [Count + 1] = CRAM [Count];
			IRAM [Count] = CRAM [Count + 1];
		}
		for (Count = 0; Count < 0x50; Count++)
		{
			IRAM [Count+0x80] = VSRAM [Count];
		}
		for (Count = 0; Count < 0x18; Count++)
		{
			IRAM [Count+0x80+0x50] = VDPREG [Count];
		}
		strcpy (FileName, "IRAM.twiz");
		if (PackData (&IRAM [0x0000], 0x80+0x50+0x18, Directory) != 0) { free (State); State = NULL; continue; }



		free (State); State = NULL;
	}
	free (Palette.Data); Palette.Data = NULL;
	printf ("\nPress enter key to exit...\n");
	fflush (stdin); getchar ( ); return (0x00);
}

// =============================================================================




















