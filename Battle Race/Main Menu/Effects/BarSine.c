// =============================================================================
// -----------------------------------------------------------------------------
// Program
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <windows.h>

// -----------------------------------------------------------------------------
// Defines/macros
// -----------------------------------------------------------------------------

#define M_BarSize 0x20

#define M_Write(FileLoc,NewLine,Message,...)\
{\
	snprintf (TEXT, 0x1000, Message, ##__VA_ARGS__);\
	fputs (TEXT, FileLoc);\
	if (NewLine == TRUE) { fputc (0x0D, FileLoc); fputc (0x0A, FileLoc); }\
}

// -----------------------------------------------------------------------------
// Universal data
// -----------------------------------------------------------------------------

static char TEXT [0x1000];
static int Angle;
static int SineWave [] = {	0x00000000,0x00000648,0x00000C8F,0x000012D5,0x00001917,0x00001F56,0x00002590,0x00002BC4,
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

static int SineAlt [] = {	0x0000FFFF,0x0000FFEC,0x0000FFB1,0x0000FF4E,0x0000FEC4,0x0000FE13,0x0000FD3A,0x0000FC3B,
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
				0xFFFFCE0F,0xFFFFD43C,0xFFFFDA70,0xFFFFE0AA,0xFFFFE6E9,0xFFFFED2B,0xFFFFF371,0xFFFFF9B8,
				0x00000000,0x00000648,0x00000C8F,0x000012D5,0x00001917,0x00001F56,0x00002590,0x00002BC4,
				0x000031F1,0x00003817,0x00003E33,0x00004447,0x00004A50,0x0000504D,0x0000563E,0x00005C22,
				0x000061F7,0x000067BD,0x00006D74,0x00007319,0x000078AD,0x00007E2E,0x0000839C,0x000088F5,
				0x00008E39,0x00009368,0x0000987F,0x00009D7F,0x0000A267,0x0000A736,0x0000ABEB,0x0000B085,
				0x0000B504,0x0000B968,0x0000BDAE,0x0000C1D8,0x0000C5E4,0x0000C9D1,0x0000CD9F,0x0000D14D,
				0x0000D4DB,0x0000D848,0x0000DB94,0x0000DEBE,0x0000E1C5,0x0000E4AA,0x0000E76B,0x0000EA09,
				0x0000EC83,0x0000EED8,0x0000F109,0x0000F314,0x0000F4FA,0x0000F6BA,0x0000F853,0x0000F9C7,
				0x0000FB14,0x0000FC3B,0x0000FD3A,0x0000FE13,0x0000FEC4,0x0000FF4E,0x0000FFB1,0x0000FFEC, };

// -----------------------------------------------------------------------------
// Structures
// -----------------------------------------------------------------------------

struct S_Entry

{
	int Link;				// link to matching entry from before...
	int SSP;				// Sinewave Start Position
	int GSS;				// Graphics Start Scanline
	int SOS;				// Size Of Scanlines
	int Size;				// Size of table of values
	int Values [M_BarSize];			// the table of values
};

// -----------------------------------------------------------------------------
// Entry point
// -----------------------------------------------------------------------------

int main (int ArgNumber, char **ArgList, char **EnvList)

{
	char Byte = 0x00;
	int StringLoc = 0x00;
	char *ProgName = ArgList [0x00];
	do
	{
		Byte = ArgList [0x00] [StringLoc++];
		if (Byte == '\\' || Byte == '/')
		{
			ProgName = ArgList [0x00] + StringLoc;
		}
	}
	while (Byte != 0x00);
	FILE *File = fopen ("BarSine.asm", "wb");
	M_Write (File, TRUE, "; ===========================================================================");
	M_Write (File, TRUE, "; ---------------------------------------------------------------------------");
	M_Write (File, TRUE, "; Swap Effect Bar Data (Created by \"%s\", DO NOT EDIT)", ProgName);
	M_Write (File, TRUE, "; ---------------------------------------------------------------------------");
	M_Write (File, TRUE, "");
	S_Entry Entries [0x100] = { 0x00 };
	int EntriesLoc, EntriesSize = 0x00;
	for (Angle = 0x00; Angle < 0x100; Angle++)
	{
		int Pos = ((-((SineWave [(Angle+0x40) & 0x7F] >> 0x08) & 0xFFFF) + 0x100) * M_BarSize) / 0x100;
		int SSP = Pos / 2;
		int GSS = 0x0000;
		if (((Angle + 0x40) & 0x80) != 0x00)
		{
			GSS = M_BarSize-1;
		}
		int SOS = Pos * 0x04;
		int Size = M_BarSize - Pos;
		int Values [M_BarSize];
		int ValuesLoc = 0x00;
		int Line = 0x00000000;
		int Dest = 0x00000000;
		while (ValuesLoc < Size)
		{
			if (((Angle + 0x40) & 0x80) == 0x00)
			{
				Line &= 0xFFFF;
				Line += ((-SineAlt [Angle] + 0x10000) * M_BarSize) / Size;
				Values [ValuesLoc++] = (Line >> 0x10) & 0xFFFF;
			}
			else
			{
				Line &= 0xFFFF;
				Line += ((-SineAlt [(Angle - 0x80) & 0xFF] + 0x10000) * M_BarSize) / Size;
				Line += 0x10000;
				Values [ValuesLoc++] = (-Line >> 0x10) & 0xFFFF;
			}
		}

		for (EntriesLoc = 0x00; EntriesLoc < EntriesSize; EntriesLoc++)
		{
			if (	Entries [EntriesLoc].Link == 0x00)
			{
				if (	SSP == Entries [EntriesLoc].SSP &&
					GSS == Entries [EntriesLoc].GSS &&
					SOS == Entries [EntriesLoc].SOS &&
					Size == Entries [EntriesLoc].Size ||
					SOS == Entries [EntriesLoc].SOS &&
					SOS == (M_BarSize * 0x04))
				{
					for (ValuesLoc = 0x00; ValuesLoc < Size; ValuesLoc++)
					{
						if (Values [ValuesLoc] != Entries [EntriesLoc].Values [ValuesLoc])
						{
							break;
						}
					}
					if (ValuesLoc == Size)
					{
						// Match...
						Entries [EntriesSize++].Link = EntriesLoc | 0x80000000;
						break;
					}
				}
			}
		}
		if (EntriesLoc == EntriesSize)
		{
			Entries [EntriesLoc].SSP = SSP;
			Entries [EntriesLoc].GSS = GSS;
			Entries [EntriesLoc].SOS = SOS;
			Entries [EntriesLoc].Size = Size;
			for (ValuesLoc = 0x00; ValuesLoc < Size; ValuesLoc++)
			{
				Entries [EntriesLoc].Values [ValuesLoc] = Values [ValuesLoc];
			}
			EntriesSize++;
		}
	}
	for (Angle = 0x00; Angle < 0x100; )
	{
		M_Write (File, FALSE, "		dc.l	");
		int Count;
		for (Count = 0x04; Count-- > 0x00 && Angle < 0x100; Angle++)
		{
			if (Entries [Angle].Link == 0x00)
			{
				M_Write (File, FALSE, "BP_Angle%0.2X", Angle);
			}
			else
			{
				M_Write (File, FALSE, "BP_Angle%0.2X", Entries [Angle].Link & 0x7FFFFFFF);
			}
			if (Count > 0x00 && Angle < 0x100)
			{
				M_Write (File, FALSE, ", ");
			}
		}
		M_Write (File, TRUE, "");
	}
	M_Write (File, TRUE, "");
	M_Write (File, TRUE, "; ---------------------------------------------------------------------------");
	M_Write (File, TRUE, "; The actual data itself...");
	M_Write (File, TRUE, "; ---------------------------------------------------------------------------");
	M_Write (File, TRUE, "");
	int ValuesLoc;
	for (Angle = 0x00; Angle < 0x100; Angle++)
	{
		if (Entries [Angle].Link == 0x00)
		{
			M_Write (File, FALSE, "BP_Angle%0.2X:	", Angle);
			M_Write (File, TRUE, "dc.w	$%0.4X					; sinewave start position", Entries [Angle].SSP & 0xFFFF);
			M_Write (File, TRUE, "		dc.w	$%0.4X					; graphics start scanline", Entries [Angle].GSS & 0xFFFF);
			if (Entries [Angle].SOS == (M_BarSize * 0x04))
			{
				Entries [Angle].SOS -= 0x02;
			}
			if (Entries [Angle].SOS == 0x00)
			{
				if (Entries [Angle].GSS != 0x00)
				{
					Entries [Angle].SOS -= 0x02;
				}
			}
			M_Write (File, TRUE, "		dc.w	$%0.4X					; size of scanlines (x4)", Entries [Angle].SOS & 0xFFFF);
			for (ValuesLoc = 0x00; ValuesLoc < Entries [Angle].Size; )
			{
				int Count = 0x08;
				M_Write (File, FALSE, "		dc.l	");
				while (Count-- > 0x00 && ValuesLoc < Entries [Angle].Size)
				{
					int Line1 = Entries [Angle].Values [ValuesLoc++];
					int Line2 = Line1;
					if (Line2 > 0x7FFF)
					{
						Line1 = (Line1 - 1) & 0xFFFF;
					}
					M_Write (File, FALSE, "$%0.4X%0.4X", Line1, Line2);
					if (Count > 0x00 && ValuesLoc < Entries [Angle].Size)
					{
						fputc (',', File);
					}
				}
				M_Write (File, TRUE, "");
			}
			M_Write (File, TRUE, "");
		}
	}
	M_Write (File, TRUE, "; ===========================================================================");
	fclose (File);
	printf ("Press enter key to exit...\n");
	fflush (stdin);
	getchar ( );
}

// =============================================================================



