// =============================================================================
// -----------------------------------------------------------------------------
// Transformation Matri Generator
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <direct.h>
#include <windows.h>
#include "_bitmap.h"
#include "_Settings.h"

const char FileMask [] = { "Mask.bmp" };		// Mask to use for roundel tiles
const char Folder [] = { "Matrix" };

u_int MOVE = 0x12E80000;	// "move.b  $XXXX(a0),(a1)+"
u_short RTS = 0x4E75;		// "rts"

char Text [0x1000];

//#define COUNTSTRIPS 0x05	// 3 strips per each rendering...



// -----------------------------------------------------------------------------
// Sine-wave table
// -----------------------------------------------------------------------------

int SineWave [] = {	0x00000000,0x00000648,0x00000C8F,0x000012D5,0x00001917,0x00001F56,0x00002590,0x00002BC4,
			0x000031F1,0x00003817,0x00003E33,0x00004447,0x00004A50,0x0000504D,0x0000563E,0x00005C22,
			0x000061F7,0x000067BD,0x00006D74,0x00007319,0x000078AD,0x00007E2E,0x0000839C,0x000088F5,
			0x00008E39,0x00009368,0x0000987F,0x00009D7F,0x0000A267,0x0000A736,0x0000ABEB,0x0000B085,
			0x0000B504,0x0000B968,0x0000BDAE,0x0000C1D8,0x0000C5E4,0x0000C9D1,0x0000CD9F,0x0000D14D,
			0x0000D4DB,0x0000D848,0x0000DB94,0x0000DEBE,0x0000E1C5,0x0000E4AA,0x0000E76B,0x0000EA09,
			0x0000EC83,0x0000EED8,0x0000F109,0x0000F314,0x0000F4FA,0x0000F6BA,0x0000F853,0x0000F9C7,
			0x0000FB14,0x0000FC3B,0x0000FD3A,0x0000FE13,0x0000FEC4,0x0000FF4E,0x0000FFB1,0x0000FFEC,
			0x00010000,0x0000FFEC,0x0000FFB1,0x0000FF4E,0x0000FEC4,0x0000FE13,0x0000FD3A,0x0000FC3B,
			0x0000FB14,0x0000F9C7,0x0000F853,0x0000F6BA,0x0000F4FA,0x0000F314,0x0000F109,0x0000EED8,
			0x0000EC83,0x0000EA09,0x0000E76B,0x0000E4AA,0x0000E1C5,0x0000DEBE,0x0000DB94,0x0000D848,
			0x0000D4DB,0x0000D14D,0x0000CD9F,0x0000C9D1,0x0000C5E4,0x0000C1D8,0x0000BDAE,0x0000B968,
			0x0000B504,0x0000B085,0x0000ABEB,0x0000A736,0x0000A267,0x00009D7F,0x0000987F,0x00009368,
			0x00008E39,0x000088F5,0x0000839C,0x00007E2E,0x000078AD,0x00007319,0x00006D74,0x000067BD,
			0x000061F7,0x00005C22,0x0000563E,0x0000504D,0x00004A50,0x00004447,0x00003E33,0x00003817,
			0x000031F1,0x00002BC4,0x00002590,0x00001F56,0x00001917,0x000012D5,0x00000C8F,0x00000648,
			0x00000000,0xFFFFF9B8,0xFFFFF371,0xFFFFED2B,0xFFFFE6E9,0xFFFFE0AA,0xFFFFDA70,0xFFFFD43C,
			0xFFFFCE0F,0xFFFFC7E9,0xFFFFC1CD,0xFFFFBBB9,0xFFFFB5B0,0xFFFFAFB3,0xFFFFA9C2,0xFFFFA3DE,
			0xFFFF9E09,0xFFFF9843,0xFFFF928C,0xFFFF8CE7,0xFFFF8753,0xFFFF81D2,0xFFFF7C64,0xFFFF770B,
			0xFFFF71C7,0xFFFF6C98,0xFFFF6781,0xFFFF6281,0xFFFF5D99,0xFFFF58CA,0xFFFF5415,0xFFFF4F7B,
			0xFFFF4AFC,0xFFFF4698,0xFFFF4252,0xFFFF3E28,0xFFFF3A1C,0xFFFF362F,0xFFFF3261,0xFFFF2EB3,
			0xFFFF2B25,0xFFFF27B8,0xFFFF246C,0xFFFF2142,0xFFFF1E3B,0xFFFF1B56,0xFFFF1895,0xFFFF15F7,
			0xFFFF137D,0xFFFF1128,0xFFFF0EF7,0xFFFF0CEC,0xFFFF0B06,0xFFFF0946,0xFFFF07AD,0xFFFF0639,
			0xFFFF04EC,0xFFFF03C5,0xFFFF02C6,0xFFFF01ED,0xFFFF013C,0xFFFF00B2,0xFFFF004F,0xFFFF0014,
			0xFFFF0000,0xFFFF0014,0xFFFF004F,0xFFFF00B2,0xFFFF013C,0xFFFF01ED,0xFFFF02C6,0xFFFF03C5,
			0xFFFF04EC,0xFFFF0639,0xFFFF07AD,0xFFFF0946,0xFFFF0B06,0xFFFF0CEC,0xFFFF0EF7,0xFFFF1128,
			0xFFFF137D,0xFFFF15F7,0xFFFF1895,0xFFFF1B56,0xFFFF1E3B,0xFFFF2142,0xFFFF246C,0xFFFF27B8,
			0xFFFF2B25,0xFFFF2EB3,0xFFFF3261,0xFFFF362F,0xFFFF3A1C,0xFFFF3E28,0xFFFF4252,0xFFFF4698,
			0xFFFF4AFC,0xFFFF4F7B,0xFFFF5415,0xFFFF58CA,0xFFFF5D99,0xFFFF6281,0xFFFF6781,0xFFFF6C98,
			0xFFFF71C7,0xFFFF770B,0xFFFF7C64,0xFFFF81D2,0xFFFF8753,0xFFFF8CE7,0xFFFF928C,0xFFFF9843,
			0xFFFF9E09,0xFFFFA3DE,0xFFFFA9C2,0xFFFFAFB3,0xFFFFB5B0,0xFFFFBBB9,0xFFFFC1CD,0xFFFFC7E9,
			0xFFFFCE0F,0xFFFFD43C,0xFFFFDA70,0xFFFFE0AA,0xFFFFE6E9,0xFFFFED2B,0xFFFFF371,0xFFFFF9B8 };

// =============================================================================
// -----------------------------------------------------------------------------
// Structures
// -----------------------------------------------------------------------------

struct POSDAT

{
	int X;
	int Y;
};

struct HIGHDAT

{
	int X;
	int Start;
	int Finish;
	int Blank;		// Y size of blank mask areas (so far...)
};

// =============================================================================
// -----------------------------------------------------------------------------
// Subroutine to generate a transformation matrix sinewave table
// -----------------------------------------------------------------------------

void CreateMatrix (POSDAT *Position, int Width, int Height, int Angle, bool Absolute)

{
	int CountX, CountY;
	int PosX_A, PosY_A, SineX_A, SineY_A;
	int PosX_B, PosY_B, SineX_B, SineY_B;

	SineX_A = SineWave [(Angle + 0x00) & 0xFF];
	SineY_A = SineWave [(Angle + 0x40) & 0xFF];
	SineX_B = SineWave [(Angle + 0x40) & 0xFF];
	SineY_B = SineWave [(Angle + 0x80) & 0xFF];

  SineX_B *= 0x02;	// Multiply by 2 (because of double pixel system)
  SineY_B *= 0x02;

	int PosLoc = 0x00;
	if (Absolute == TRUE)
	{
		PosX_A = 0;
		PosY_A = 0;
	}
	else
	{
		PosX_A = SineX_A * -(Width / 2);
		PosY_A = SineY_A * -(Height / 2);
	}
	for (CountY = 0x00; CountY < Height; CountY++)
	{
		PosX_B = PosX_A;
		PosY_B = PosY_A;
		if (Absolute == FALSE)
		{
			PosX_B -= SineX_B * (Width / 2);
			PosY_B -= SineY_B * (Height / 2);
		}
		PosX_A += SineX_A; //0x00000000;
		PosY_A += SineY_A; //0x00000100;
		for (CountX = 0x00; CountX < Width; CountX++)
		{
			Position [PosLoc].X = PosX_B >> 0x08;
			Position [PosLoc].Y = PosY_B >> 0x08;
			PosX_B += SineX_B; //0x00000100;
			PosY_B += SineY_B; //0x00000000;
			PosLoc++;
		}
	}
}

// =============================================================================
// -----------------------------------------------------------------------------
// Main Routine
// -----------------------------------------------------------------------------

int main (int ArgNumber, char **ArgList, char **EnvList)

{

	// --- Settings ---

	LoadSettings ( );
	mkdir 	(Folder);

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
		printf ("Error, the mask MUST be a multiple of 8 x 8 pixels\n"); free (Mask.Data); Mask.Data = NULL; fflush (stdin); getchar ( ); return (0x00);
	}
	PIX_BGRA PadColour = { 0x00, 0x00, 0x00, 0x00 };
	switch (TruncateImage (&Mask, -PADSIZE, -PADSIZE, Mask.SizeX + PADSIZE, Mask.SizeY + PADSIZE, PadColour))
	{
		case 2: printf ("    Error, could not allocate memory for truncating \"%s\"\n\nPress enter key to exit...\n", FileMask); free (Mask.Data); Mask.Data = NULL; fflush (stdin); getchar ( ); return (0x00);
		case 3: printf ("    Error, resize coordinates result in null image for truncating \"%s\"\n\nPress enter key to exit...\n", FileMask); free (Mask.Data); Mask.Data = NULL; fflush (stdin); getchar ( ); return (0x00);
	}
	POSDAT *Position = (POSDAT*) malloc (Mask.Size * sizeof (POSDAT));
	if (Position == NULL)
	{
		free (Mask.Data); Mask.Data = NULL;
		printf ("Error, could not allocate memory for position data\n");
		fflush (stdin); getchar ( ); return (0x00);
	}

	int VStreamSize = Mask.SizeY * 4;
	POSDAT *VStream = (POSDAT*) malloc (VStreamSize * sizeof (POSDAT));
	if (VStream == NULL)
	{
		free (Position); Position = NULL;
		free (Mask.Data); Mask.Data = NULL;
		printf ("Error, could not allocate memory for V-Stream data\n");
		fflush (stdin); getchar ( ); return (0x00);
	}

	int PosLoc, CountX, CountY;

	int Width = Mask.SizeX;
	int Height = Mask.SizeY;

	// --- Working out heights from mask file ---

	int HeightLoc, HeightSize = 0x100;
	HIGHDAT *HeightList = (HIGHDAT*) malloc (HeightSize * sizeof (HIGHDAT));
	if (HeightList == NULL)
	{
		free (VStream); VStream = NULL;
		free (Position); Position = NULL;
		free (Mask.Data); Mask.Data = NULL;
		printf ("Error, could not allocate memory for height list\n");
		fflush (stdin); getchar ( ); return (0x00);
	}
	bool BlackMask = TRUE;
	int MaskCount = 0x00;
	for (CountX = 0x00; CountX < Width - (PADSIZE * 2); CountX += 8)
	{
		for (CountY = 0x00; CountY < Height; CountY++)
		{
			if (Mask.Data [(CountY * Width) + (CountX + PADSIZE)].Blue == 0x00)
			{
				if (BlackMask == FALSE)
				{
					BlackMask = TRUE;
					HeightList [HeightLoc].Finish = CountY;
					HeightList [HeightLoc].Blank = MaskCount;
					if (++HeightLoc == HeightSize)
					{
						HeightSize <<= 2;
						HIGHDAT *NewList = (HIGHDAT*) realloc (HeightList, HeightSize * sizeof (HIGHDAT));
						if (NewList == NULL)
						{
							free (HeightList); HeightList = NULL;
							free (VStream); VStream = NULL;
							free (Position); Position = NULL;
							free (Mask.Data); Mask.Data = NULL;
							printf ("Error, could not reallocate memory for height list\n");
							fflush (stdin); getchar ( ); return (0x00);
						}
						HeightList = NewList;
					}
				}
				MaskCount++;
			}
			else
			{
				if (BlackMask == TRUE)
				{
					BlackMask = FALSE;
					HeightList [HeightLoc].X = CountX + PADSIZE;
					HeightList [HeightLoc].Start = CountY;
				}
			}
		}
		if (BlackMask == FALSE)
		{
			BlackMask = TRUE;
			HeightList [HeightLoc].Finish = CountY;
			HeightList [HeightLoc].Blank = MaskCount;
			if (++HeightLoc == HeightSize)
			{
				HeightSize <<= 2;
				HIGHDAT *NewList = (HIGHDAT*) realloc (HeightList, HeightSize * sizeof (HIGHDAT));
				if (NewList == NULL)
				{
					free (HeightList); HeightList = NULL;
					free (VStream); VStream = NULL;
					free (Position); Position = NULL;
					free (Mask.Data); Mask.Data = NULL;
					printf ("Error, could not reallocate memory for height list\n");
					fflush (stdin); getchar ( ); return (0x00);
				}
				HeightList = NewList;
			}
		}
		else
		{
			HeightList [HeightLoc - 1].Blank = MaskCount;
		}
		MaskCount = 0;
	}
	if (BlackMask == FALSE)
	{
		HeightList [HeightLoc++].Finish = CountY;
	}
	HeightSize = HeightLoc;




/*	FILE *File = fopen ("HeightList.bin", "wb");
	for (HeightLoc = 0x00; HeightLoc < HeightSize; HeightLoc++)
	{
		fputc (HeightList [HeightLoc].X >> 0x08, File);
		fputc (HeightList [HeightLoc].X >> 0x00, File);
		fputc (HeightList [HeightLoc].Start >> 0x08, File);
		fputc (HeightList [HeightLoc].Start >> 0x00, File);
		fputc (HeightList [HeightLoc].Finish >> 0x08, File);
		fputc (HeightList [HeightLoc].Finish >> 0x00, File);
		fputc (HeightList [HeightLoc].Blank >> 0x08, File);
		fputc (HeightList [HeightLoc].Blank >> 0x00, File);
	}
	fclose (File);	*/

	u_char Angle;
	int AngleCount;

	for (Angle = 0xE0, AngleCount = 0x00; AngleCount < 0x08; AngleCount++, Angle += 0x08)
	{

		// --- Creating transformation matrix table ---

		CreateMatrix (Position, Width, Height, Angle, FALSE);

	/*	File = fopen ("Dump.bin", "wb");
		for (PosLoc = 0; PosLoc < Mask.Size; PosLoc++)
		{
			fputc (Position [PosLoc].X >> 0x18, File);
			fputc (Position [PosLoc].X >> 0x10, File);
			fputc (Position [PosLoc].X >> 0x08, File);
			fputc (Position [PosLoc].X >> 0x00, File);
			fputc (Position [PosLoc].Y >> 0x18, File);
			fputc (Position [PosLoc].Y >> 0x10, File);
			fputc (Position [PosLoc].Y >> 0x08, File);
			fputc (Position [PosLoc].Y >> 0x00, File);
		}
		fclose (File);	*/

		// --- Obtaining a single vertical stream at tiles' width ---

		int VStreamLoc = 0;
		for (CountX = 0x00; CountX < 0x04; CountX++)
		{
			for (CountY = 0x00; CountY < Height; CountY++)
			{
			VStream [VStreamLoc].X = Position [((Width / 2) + CountX) + (CountY * Width)].X;
			VStream [VStreamLoc].Y = Position [((Width / 2) + CountX) + (CountY * Width)].Y;
			//VStream [VStreamLoc].X = Position [((Width / 2) + (CountX * 2)) + (CountY * Width)].X;
			//VStream [VStreamLoc].Y = Position [((Width / 2) + (CountX * 2)) + (CountY * Width)].Y;
				VStreamLoc++;
			}
		}

	/*	File = fopen ("List.bin", "wb");
		for (VStreamLoc = 0x00; VStreamLoc < VStreamSize; VStreamLoc++)
		{
			fputc (VStream [VStreamLoc].X >> 0x18, File);
			fputc (VStream [VStreamLoc].X >> 0x10, File);
			fputc (VStream [VStreamLoc].X >> 0x08, File);
			fputc (VStream [VStreamLoc].X >> 0x00, File);
			fputc (VStream [VStreamLoc].Y >> 0x18, File);
			fputc (VStream [VStreamLoc].Y >> 0x10, File);
			fputc (VStream [VStreamLoc].Y >> 0x08, File);
			fputc (VStream [VStreamLoc].Y >> 0x00, File);
		}
		fclose (File);	*/

		// --- converting V-stream to address ---

		for (VStreamLoc = 0x00; VStreamLoc < VStreamSize; VStreamLoc++)
		{
			VStream [VStreamLoc].X >>= 0x08;
			VStream [VStreamLoc].Y >>= 0x08;
			VStream [VStreamLoc].X = (VStream [VStreamLoc].X * Height);
			VStream [VStreamLoc].X += (VStream [VStreamLoc].Y % Height);
		}

		snprintf (Text, 0x1000, "%s\\VStream%0.2X.bin", Folder, Angle);
		FILE *File = fopen (Text, "wb");
		for (CountY = 0x00; CountY < Height; CountY++)
		{
			for (CountX = 0x00; CountX < 0x04; CountX++)
			{
				VStreamLoc = (CountX * Height) + CountY;
				fputc (MOVE >> 0x18, File);
				fputc (MOVE >> 0x10, File);
				fputc (VStream [VStreamLoc].X >> 0x08, File);
				fputc (VStream [VStreamLoc].X >> 0x00, File);
			}
		}
		fputc (RTS >> 0x08, File);
		fputc (RTS >> 0x00, File);
		fclose (File);

		// --- Calculating indexing positions based on heights ---

		int RetSize;
		snprintf (Text, 0x1000, "%s\\Render%0.2X.asm", Folder, Angle);
		File = fopen (Text, "w");

		int StripCount = 0;
		int RenderCount = 0;

		int Entries = HeightSize / COUNTSTRIPS;
		if ((HeightSize % COUNTSTRIPS) != 0)
		{
			Entries++;
		}
		RetSize = 0;

		RetSize += snprintf (&Text [RetSize], 0x1000 - RetSize,	"; ===========================================================================\n"
									"; ---------------------------------------------------------------------------\n"
									"; Roundel rendering matrix (for angle %0.2X)\n"
									"; ---------------------------------------------------------------------------\n\n",
									Angle);
		RetSize += snprintf (&Text [RetSize], 0x1000 - RetSize, "Render%0.2X:	dc.l	SwitchBuffer\n", Angle);
		for (RenderCount = 0; RenderCount < Entries; RenderCount++)
		{
			RetSize += snprintf (&Text [RetSize], 0x1000 - RetSize, "		dc.l	Angle%0.2X_%X\n", Angle, RenderCount);
		}
		RetSize += snprintf (&Text [RetSize], 0x1000 - RetSize, "		dc.l	FinishBuffer\n\n");
		fputs (Text, File);
		RenderCount = 0;

		snprintf (Text, 0x1000,	"	; --- Render %X ---\n\n"
					"Angle%0.2X_%X:\n", RenderCount, Angle, RenderCount);
		fputs (Text, File);

		for (HeightLoc = 0x00; HeightLoc < HeightSize; HeightLoc++)
		{
			RetSize = 0;
			if (StripCount++ == COUNTSTRIPS)
			{
				RenderCount++;
				RetSize += snprintf (&Text [RetSize], 0x1000 - RetSize,	"\n"
											"	; --- Render %X ---\n\n"
											"Angle%0.2X_%X:\n", RenderCount, Angle, RenderCount);
				StripCount = 1;
			}
			PosLoc = (HeightList [HeightLoc].X / 2) + (Width / 4);
			PosLoc += (8 / 2) / 4;
			PosLoc -= HeightList [HeightLoc].Start * Width;

		PosLoc += (Height / 2) * Width;		// Adjust to use from centre of sinewave

			CountX = Position [PosLoc].X >> 0x08;
			CountY = Position [PosLoc].Y >> 0x08;

		CountY -= (Height / 2);			// Adjust art back to use from centre

			int Address = CountX * Height;
			Address += CountY % Height;

			if (Address < 0)
			{
				if (Address < -0x8000)
				{
					Address = -0x8000;
				}
				RetSize += snprintf (&Text [RetSize], 0x1000 - RetSize, "		lea	-$%0.4X(a2),a0\n", (-Address) & 0xFFFF);
			}
			else
			{
				if (Address > 0x7FFF)
				{
					Address = 0x7FFF;
				}
				RetSize += snprintf (&Text [RetSize], 0x1000 - RetSize, "		lea	$%0.4X(a2),a0\n", Address & 0xFFFF);
			}
			if ((HeightLoc + 1) == HeightSize || StripCount == COUNTSTRIPS) // is this the last one?
			{
				RetSize += snprintf (&Text [RetSize], 0x1000 - RetSize, "		bra.w	");
			}
			else
			{
				RetSize += snprintf (&Text [RetSize], 0x1000 - RetSize, "		bsr.w	");
			}
			snprintf (&Text [RetSize], 0x1000 - RetSize, "(VStream%0.2X-($%0.2X*(%d*%d)))-%d\n", Angle, HeightList [HeightLoc].Finish - HeightList [HeightLoc].Start, sizeof (MOVE), sizeof (u_int), sizeof (RTS));
			fputs (Text, File);
		}
		RetSize = snprintf (Text, 0x1000, "\n	; --- Render V-stream code ---\n\n		binclude \"Title Screen\\Roundel\\%s\\VStream%0.2X.bin\"\nVStream%0.2X:\n", Folder, Angle, Angle);

		RetSize += snprintf (&Text [RetSize], 0x1000 - RetSize,	"\n; ===========================================================================");
		fputs (Text, File);

		fclose (File);
	}

	free (HeightList); HeightList = NULL;
	free (VStream); VStream = NULL;
	free (Position); Position = NULL;
	free (Mask.Data); Mask.Data = NULL;
}

// =============================================================================





















