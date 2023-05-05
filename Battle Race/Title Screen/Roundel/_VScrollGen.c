// =============================================================================
// -----------------------------------------------------------------------------
// Transformation Matri Generator
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <direct.h>
#include <windows.h>
#include "_Settings.h"

const char Folder [] = { "VScroll" };

char Text [0x1000];

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
// Main Routine
// -----------------------------------------------------------------------------

int main (int ArgNumber, char **ArgList, char **EnvList)

{

	// --- Settings ---

	LoadSettings ( );
	mkdir 	(Folder);

	// --- ??? ---

	int VScroll [HEIGHT/SCANSKIP];

	int Angle, VScrollLoc, CountPos;
	for (Angle = 0; Angle <= 0x3F; Angle++) // Only need half the angles
	{


		int CountM = HEIGHT/SCANSKIP;
		int CountE = CountM;
		CountM = (CountM * SineWave [(Angle + 0x40) & 0xFF]) >> 0x10;
		CountE -= CountM;
		int CountS = CountE;
		CountE /= 2;


		int Advance = ((HEIGHT * SCANSKIP) << 0x10);
		Advance /= CountM * SCANSKIP;
		Advance -= 0x00010000 * SCANSKIP;

		VScrollLoc = 0;
		int ScalePos = 0;
		int BlankPos = 0;
		for (CountPos = 0; CountPos < CountE; CountPos++)
		{
			ScalePos += 0x00010000 * SCANSKIP;
			BlankPos += 0x00010000 * SCANSKIP;
			VScroll [VScrollLoc++] = BlankPos + 0x00080000;
		}

		for (CountPos = 0; CountPos < CountM; CountPos++)
		{
			ScalePos -= Advance;
			BlankPos += 0x00010000 * SCANSKIP;
			VScroll [VScrollLoc++] = ScalePos;
		}

		for (CountPos = 0; CountPos < CountE; CountPos++)
		{
		//	ScalePos += 0x00010000 * SCANSKIP;
			BlankPos += 0x00010000 * SCANSKIP;
			VScroll [VScrollLoc++] = BlankPos + 0x00080000;
		}



		snprintf (Text, 0x1000, "%s\\VScroll%0.2X.bin", Folder, Angle);
		FILE *File = fopen (Text, "wb");

		//int CountA = CountS;
		CountS *= SCANSKIP;		// convert back to E0
		CountS /= 8;			// 8 pixels per cell
		int CountR = CountS;
		CountS *= 6;			// multiply by size of the three instructions in the chain
		CountR &= -2;			// divide by 2 (since it's an edge which is half), then multiply by size of word for H-scroll table

	if (Angle <= 0x3A)	// Can't be bothered to work out the minor offputting issue with H-scroll at the bottom most cell
	{			// so this rig will have to do.  Don't have time to fuxk about...
		CountS -= 6;
		if (CountS < 0)
		{
			CountS = 0;
		}
	}

		int CountA = Advance;
		CountA >>= 0x08;
		CountA /= SCANSKIP;
		CountA += 0x0100;

		fputc (CountA >> 0x08, File);
		fputc (CountA >> 0x00, File);
		fputc (CountR >> 0x08, File);
		fputc (CountR >> 0x00, File);
		fputc (CountS >> 0x08, File);
		fputc (CountS >> 0x00, File);

		for (VScrollLoc = 0; VScrollLoc < HEIGHT/SCANSKIP; VScrollLoc++)
		{
			fputc (VScroll [VScrollLoc] >> 0x18, File);
			fputc (VScroll [VScrollLoc] >> 0x10, File);
			fputc (VScroll [VScrollLoc] >> 0x18, File);
			fputc (VScroll [VScrollLoc] >> 0x10, File);
		}
		fclose (File);
	}
}

// =============================================================================





















