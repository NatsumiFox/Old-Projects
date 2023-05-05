// =============================================================================
// -----------------------------------------------------------------------------
// Program
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <windows.h>
#include <direct.h>
#include "BitmapV5.0.h"

static char *VDPREG = NULL;
static char *VRAM = NULL;
static char *CRAM = NULL;
static char *VSRam = NULL;

static int PlaneSizes [] = { 0x100, 0x200, 0x200, 0x400 };

static int *PlaneA, *PlaneB, *Sprite;

static int PlaneWidth, PlaneHeight;
static int PlaneSize, PlaneLoc;
static int SpriteWidth = 0x200, SpriteHeight = 0x200;
static int SpriteSize = SpriteWidth * SpriteHeight, SpriteLoc;

static int Backdrop;
static int Imagebpp = 24;

// =============================================================================
// -----------------------------------------------------------------------------
// Subroutine to draw a plane of tiles as a bitmap
// -----------------------------------------------------------------------------

void DrawPlane (int *Bitmap, int PlaneLoc, bool Priority)

{
	int CountX, CountY, TileX, TileY, PixX, PixY, Colour;
	char Pixel;

	for (CountY = 0x00; CountY < PlaneHeight / 0x08; CountY++)
	{
		for (CountX = 0x00; CountX < PlaneWidth / 0x08; CountX++)
		{
			short MapTile = (VRAM [PlaneLoc++] << 0x08) | (VRAM [PlaneLoc++] & 0xFF);
			if ((MapTile >> 0x0F) & 0x01 != (Priority & 0x01))
			{
				continue;
			}
			int TileLoc = (MapTile & 0x7FF) * 0x20;
			int Palette = (MapTile & 0x6000) >> 0x08;
			switch ((MapTile & 0x1800))
			{
				case 0x0000:	// Normal
				{
					for (PixY = 0x00, TileY = 0x00; PixY < 0x08; PixY++, TileY++)
					{
						for (PixX = 0x00, TileX = 0x00; PixX < 0x08; PixX++, TileX++)
						{
							if ((TileX & 0x01) == 0x00)
							{
								Pixel = (VRAM [TileLoc + ((TileX >> 0x01) + (TileY * 0x04))] >> 0x03) & 0x1E;
							}
							else
							{
								Pixel = (VRAM [TileLoc + ((TileX >> 0x01) + (TileY * 0x04))] & 0x0F) << 0x01;
							}
							if (Pixel != 0x00)
							{
								Colour = (CRAM [Palette + Pixel] & 0x0E) << (0x04 + 0x10);
								Colour |= (CRAM [Palette + Pixel] & 0xE0) << (0x08 + 0x00);
								Colour |= (CRAM [Palette + Pixel + 0x01] & 0x0E) << (0x04 + 0x00);
								Bitmap [((CountX * 0x08) + PixX) + (((CountY * 0x08) + PixY) * PlaneWidth)] = Colour;
							}
						}
					}
				}
				break;
				case 0x0800:	// Mirror
				{
					for (PixY = 0x00, TileY = 0x00; PixY < 0x08; PixY++, TileY++)
					{
						for (PixX = 0x00, TileX = 0x07; PixX < 0x08; PixX++, TileX--)
						{
							if ((TileX & 0x01) == 0x00)
							{
								Pixel = (VRAM [TileLoc + ((TileX >> 0x01) + (TileY * 0x04))] >> 0x03) & 0x1E;
							}
							else
							{
								Pixel = (VRAM [TileLoc + ((TileX >> 0x01) + (TileY * 0x04))] & 0x0F) << 0x01;
							}
							if (Pixel != 0x00)
							{
								Colour = (CRAM [Palette + Pixel] & 0x0E) << (0x04 + 0x10);
								Colour |= (CRAM [Palette + Pixel] & 0xE0) << (0x08 + 0x00);
								Colour |= (CRAM [Palette + Pixel + 0x01] & 0x0E) << (0x04 + 0x00);
								Bitmap [((CountX * 0x08) + PixX) + (((CountY * 0x08) + PixY) * PlaneWidth)] = Colour;
							}
						}
					}
				}
				break;
				case 0x1000:	// Flip
				{
					for (PixY = 0x00, TileY = 0x07; PixY < 0x08; PixY++, TileY--)
					{
						for (PixX = 0x00, TileX = 0x00; PixX < 0x08; PixX++, TileX++)
						{
							if ((TileX & 0x01) == 0x00)
							{
								Pixel = (VRAM [TileLoc + ((TileX >> 0x01) + (TileY * 0x04))] >> 0x03) & 0x1E;
							}
							else
							{
								Pixel = (VRAM [TileLoc + ((TileX >> 0x01) + (TileY * 0x04))] & 0x0F) << 0x01;
							}
							if (Pixel != 0x00)
							{
								Colour = (CRAM [Palette + Pixel] & 0x0E) << (0x04 + 0x10);
								Colour |= (CRAM [Palette + Pixel] & 0xE0) << (0x08 + 0x00);
								Colour |= (CRAM [Palette + Pixel + 0x01] & 0x0E) << (0x04 + 0x00);
								Bitmap [((CountX * 0x08) + PixX) + (((CountY * 0x08) + PixY) * PlaneWidth)] = Colour;
							}
						}
					}
				}
				break;
				case 0x1800:	// Mirror + Flip
				{
					for (PixY = 0x00, TileY = 0x07; PixY < 0x08; PixY++, TileY--)
					{
						for (PixX = 0x00, TileX = 0x07; PixX < 0x08; PixX++, TileX--)
						{
							if ((TileX & 0x01) == 0x00)
							{
								Pixel = (VRAM [TileLoc + ((TileX >> 0x01) + (TileY * 0x04))] >> 0x03) & 0x1E;
							}
							else
							{
								Pixel = (VRAM [TileLoc + ((TileX >> 0x01) + (TileY * 0x04))] & 0x0F) << 0x01;
							}
							if (Pixel != 0x00)
							{
								Colour = (CRAM [Palette + Pixel] & 0x0E) << (0x04 + 0x10);
								Colour |= (CRAM [Palette + Pixel] & 0xE0) << (0x08 + 0x00);
								Colour |= (CRAM [Palette + Pixel + 0x01] & 0x0E) << (0x04 + 0x00);
								Bitmap [((CountX * 0x08) + PixX) + (((CountY * 0x08) + PixY) * PlaneWidth)] = Colour;
							}
						}
					}
				}
				break;
			}
		}
	}
}

// =============================================================================
// -----------------------------------------------------------------------------
// Main entry routine
// -----------------------------------------------------------------------------

int main (int ArgNumber, char **ArgList, char **EnvList)

{
	printf ("Bitmap State - by MarkeyJester\n\n");
	if (ArgNumber <= 0x01)
	{
		printf (" -> Drag and drop \"gsx\" savestates onto this application\n");
		printf ("\nPress enter key to exit...\n");
		fflush (stdin);
		getchar ( );
		return (0x00);
	}
	int ArgCount;
	for (ArgCount = 0x01; ArgCount < ArgNumber; ArgCount++)
	{
		printf (" -> %s\n", ArgList [ArgCount]);

			// --- Load file ---

		FILE *File = fopen (ArgList [ArgCount], "rb");
		if (File == NULL)
		{
			printf ("    Error; could not open the file\n");
			continue;
		}
		fseek (File, 0x00, SEEK_END);
		int StateSize = ftell (File);
		char *State = (char*) malloc (StateSize);
		if (State == NULL)
		{
			fclose (File);
			printf ("    Error; could not allocate memory for file\n");
		}
		rewind (File);
		int StateLoc = 0x00;
		while (StateLoc < StateSize)
		{
			State [StateLoc++] = fgetc (File);
		}
		fclose (File);

			// --- Create folder ---

		char Char, Direct [0x1000]; int DirectLoc = -0x01;
		strcpy (Direct, ArgList [ArgCount]);
		char *FileName = NULL;
		do
		{
			Char = Direct [++DirectLoc];
			if (Char == '.')
			{
				FileName = Direct + DirectLoc;
			}
		}
		while (Char != 0x00);
		if (FileName == NULL)
		{
			FileName = Direct + DirectLoc;
		}
		*FileName++ = '\\';
		*FileName = 0x00;
		mkdir (Direct);

			// --- Setup ---

		VDPREG = State + 0xFA;
		VRAM = State + 0x12478;
		CRAM = State + 0x112;
		VSRam = State + 0x192;

		int PlaneAAdd = VDPREG [0x02] << 0x0A;
		int WindowAdd = VDPREG [0x03] << 0x0A;
		int PlaneBAdd = VDPREG [0x04] << 0x0D;
		int SpriteAdd = VDPREG [0x05] << 0x09;
		int ScrollAdd = VDPREG [0x0D] << 0x0A;

		Backdrop = (CRAM [(VDPREG [0x07] * 2)] & 0x0E) << (0x04 + 0x10);
		Backdrop |= (CRAM [(VDPREG [0x07] * 2)] & 0xE0) << (0x08 + 0x00);
		Backdrop |= (CRAM [(VDPREG [0x07] * 2) + 0x01] & 0x0E) << (0x04 + 0x00);

	Backdrop = 0x00E000E0;

		PlaneWidth = PlaneSizes [VDPREG [0x10] & 0x03];
		PlaneHeight = PlaneSizes [(VDPREG [0x10] >> 0x04) & 0x03];
		PlaneSize = PlaneWidth * PlaneHeight;

		PlaneA = (int*) malloc (PlaneSize * sizeof (int));
		char *PlaneA_Char = (char*) PlaneA;
		for (PlaneLoc = 0x00; PlaneLoc < PlaneSize; PlaneLoc++) { PlaneA [PlaneLoc] = Backdrop; }
		PlaneB = (int*) malloc (PlaneSize * sizeof (int));
		char *PlaneB_Char = (char*) PlaneB;
		for (PlaneLoc = 0x00; PlaneLoc < PlaneSize; PlaneLoc++) { PlaneB [PlaneLoc] = Backdrop; }

		Sprite = (int*) malloc (SpriteSize * sizeof (int));
		char *Sprite_Char = (char*) Sprite;
		for (SpriteLoc = 0x00; SpriteLoc < SpriteSize; SpriteLoc++) { Sprite [SpriteLoc] = Backdrop; }

			// --- Render ---

		

		DrawPlane (PlaneB, PlaneBAdd, FALSE);
		DrawPlane (PlaneB, PlaneBAdd, TRUE);

		DrawPlane (PlaneA, PlaneAAdd, FALSE);
		DrawPlane (PlaneA, PlaneAAdd, TRUE);

		

	/*	DrawPlane (PlaneA, PlaneBAdd, FALSE);
		DrawPlane (PlaneA, PlaneAAdd, FALSE);
		DrawPlane (PlaneA, PlaneBAdd, TRUE);
		DrawPlane (PlaneA, PlaneAAdd, TRUE);	*/

	//	DrawSprites (Sprite, SpriteAdd, FALSE, FALSE, FALSE);

			// --- Save ---

		strcpy (FileName, "Plane A.bmp");
		FlipImage (PlaneA_Char, PlaneWidth, PlaneHeight);
		switch (ImageSave (Direct, PlaneA_Char, (PlaneWidth * PlaneHeight) * 0x04, PlaneWidth, PlaneHeight, Imagebpp))
		{
			case 0x01: printf ("    Error: the file could not be opened\n"); continue;
			case 0x03: printf ("    Error: the bpp format \"%d\" isn't currently supported\n", Imagebpp); continue;
		}

		strcpy (FileName, "Plane B.bmp");
		FlipImage (PlaneB_Char, PlaneWidth, PlaneHeight);
		switch (ImageSave (Direct, PlaneB_Char, (PlaneWidth * PlaneHeight) * 0x04, PlaneWidth, PlaneHeight, Imagebpp))
		{
			case 0x01: printf ("    Error: the file could not be opened\n"); continue;
			case 0x03: printf ("    Error: the bpp format \"%d\" isn't currently supported\n", Imagebpp); continue;
		}

	//	strcpy (FileName, "Sprites.bmp");
	//	FlipImage (Sprite_Char, SpriteWidth, SpriteHeight);
	//	switch (ImageSave (Direct, Sprite_Char, (SpriteWidth * SpriteHeight) * 0x04, SpriteWidth, SpriteHeight, Imagebpp))
	//	{
	//		case 0x01: printf ("    Error: the file could not be opened\n"); continue;
	//		case 0x03: printf ("    Error: the bpp format \"%d\" isn't currently supported\n", Imagebpp); continue;
	//	}

			// --- Finish ---

		free (PlaneA); PlaneA = NULL;
		free (PlaneB); PlaneB = NULL;
		free (Sprite); Sprite = NULL;
		free (State); State = NULL;
	}
	printf ("\nPress enter key to exit...\n");
	fflush (stdin);
	getchar ( );
	return (0x00);
}

// =============================================================================
