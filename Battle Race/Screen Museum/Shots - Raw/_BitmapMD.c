// =============================================================================
// -----------------------------------------------------------------------------
// Bitmap MD (converts bitmap images to MD tiles/planes)
// -----------------------------------------------------------------------------
// Arguement mode - First argument must be "-".
//
// The following modes can be set at any time:
//
// -W  = Width (Acceptable: -W320 -W256 -W256C)						Default 320
// -H  = Height (Acceptable: -H240 -H224 -H224C)					Default 224
// -S  = Sprite (Acceptable: -SY (yes) -SN (no))					Default Yes
// -P  = Plane (Acceptable: -P1 (1 Plane) -P2 (2 Planes)				Default 2 Planes
// -SH = Sprite Highlight (Acceptable: -SHY (yes) -SHN (no))				Default Yes
// -ST = Snap to tiles (Acceptable: -STY (yes) -STN (no))				Default No (Yes is ignored if Scale Type is custom; i.e. -SC#x#))
// -SC = Scale Type (Acceptable: -SCSTRETCH -SCFIT -SCFILL -SC#x#)			Default Fit
//       For -SC#x#, this is "CUSTOM", where the first # is the width
//	 and the second # is the height add.  For example -SC44x-10 will
//	 scale +44 width and -10 height.
// -I  = Interpolation (Acceptable: -IY (yes) -IN (no))					Default Yes
// -D  = Dithering (Acceptable: -DNONE (None) -DFLOYD (Floyd-Steinberg)			Default None
//				-DJJN (Jarvis, Judice & Ninke), -DORDER (Ordered))
// -F  = Force colour priority (Acceptable: -FN (None), -FP (Plane), -FS (Sprite))	Default None
// -B  = Best Settings (Acceptable; -BY (yes) -BN (no))					Default No
//
// Example:
//
// BitmapMD.exe - -W256 Image1.bmp Image2.bmp -W320 -SHN Image3.bmp -SN Image4.bmp
//
// Here, Image1.bmp and Image2.bmp will be converted with default settings, then
// the width is changed to 256, Image3.bmp is processed with width 256, then the
// Sprites have been disabled, Image4.bmp is processed with width 256 and using
// no sprites.
// -----------------------------------------------------------------------------

#include "_Resources/Header.h"
#include <stdio.h>
#include <direct.h>
#include <windows.h>
#include <Commctrl.h>
#include "_Resources/bitmap.h"

#if MUSEUM==TRUE
	#include "..\Shots - States\_Shared.c"
#endif

#define DEBUG FALSE
#define rangeof(ENTRY) (0x01<<(0x08*sizeof(ENTRY)))

// -----------------------------------------------------------------------------
// Initialisers
// -----------------------------------------------------------------------------

bool NEWSETTINGS = TRUE;

bool QUITPROGRAM = FALSE;

#define GM_WINDOW 0x00
#define GM_DRAG 0x01
#define GM_CONSOLE 0x02
int GUIMODE;

#define ST_STRETCH BH_STRETCH
#define ST_FIT BH_FIT
#define ST_FILL BH_FILL
#define ST_CUSTOM (ST_FILL+1)
int SCALETYPE = ST_FIT;

#define PT_PLANE1 0x01
#define PT_PLANE2 0x02
int PLANETYPE = PT_PLANE2;

#define WT_320 0x00
#define WT_256 0x01
#define WT_256C 0x02
int WIDTHTYPE = WT_320;

#define HT_240 0x00
#define HT_224 0x01
#define HT_224C 0x02
int HEIGHTTYPE = HT_224;

#define CA_PLANES FALSE
#define CA_SPRITES TRUE

bool SPRITES = TRUE;
bool SPRITESH = TRUE;
bool FORCESHADOW = FALSE;
bool COMMONART = CA_PLANES;
bool INTERPOLATION = TRUE;
bool SCALEMD = TRUE;			// scaling preview to Mega Drive VDP method (alah 256 width scales to 320)
bool MAINTAINASPECT = FALSE;
bool SNAPTILE = FALSE;
bool BESTSETTINGS = FALSE;

#define MAXSCALERANGE 64
int ScaleX = 0;
int ScaleY = 0;
int MainX = 0;
int MainY = 0;

IMG Image, Preview;

	// --- Jarvis, Judice & Ninke Dithering List ---

	//	_1       # 7 5
	//	48   3 5 7 5 3
	//	     1 3 5 3 1

static int DithList_JJN [] = {		48,  7, +1,  0,
					48,  5, +2,  0,
					48,  3, -2, +1,
					48,  5, -1, +1,
					48,  7,  0, +1,
					48,  5, +1, +1,
					48,  3, +2, +1,
					48,  1, -2, +2,
					48,  3, -1, +2,
					48,  5,  0, +2,
					48,  3, +1, +2,
					48,  1, +2, +2,
					0 };

	// --- Floyd-Steinberg Dithering List ---

	//	_1     # 7
	//	16   3 5 1

static int DithList_Floyd [] = {	16,  7, +1,  0,
					16,  3, -1, +1,
					16,  5,  0, +1,
					16,  1, +1, +1,
					0 };

	// --- Ordered dithering ---

static int DithList_Order [] = {	-1, 8, 8,	// Width/Height of order table

					 0, 48, 12, 60,  3, 51, 15, 63,
					32, 16, 44, 28, 35, 19, 47, 31,
					 8, 56,  4, 52, 11, 59,  7, 55,
					40, 24, 36, 20, 43, 27, 39, 23,
					 2, 50, 14, 62,  1, 49, 13, 61,
					34, 18, 46, 30, 33, 17, 45, 29,
					10, 58,  6, 54,  9, 57,  5, 53,
					42, 26, 38, 22, 41, 25, 37, 21 };

int *DITHERTYPE = NULL;
bool POSTDITHER = FALSE;


#define DEF_OFL_SIZE 0x8000
char OpenFileList [DEF_OFL_SIZE];

FILE *File;
char *FileName, *ExtName, *Folder, *FileDump;
char Directory [0x1000];
int DirectLoc;

OPENFILENAME ofn;

	// --- Acceptable characters for modes ---

static char W_ModesChars [] = {		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00,  'A',  'B',  'C',  'D',  'E',  'F',  'G',  'H',  'I',  'J',  'K',  'L',  'M',  'N',  'O',
					 'P',  'Q',  'R',  'S',  'T',  'U',  'V',  'W',  'X',  'Y',  'Z', 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00,  'A',  'B',  'C',  'D',  'E',  'F',  'G',  'H',  'I',  'J',  'K',  'L',  'M',  'N',  'O',
					 'P',  'Q',  'R',  'S',  'T',  'U',  'V',  'W',  'X',  'Y',  'Z', 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

	// --- Acceptable characters for numbers ---

static char W_NumberChars [] = {	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					 '0',  '1',  '2',  '3',  '4',  '5',  '6',  '7',  '8',  '9', 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

char TEXT [0x1000];

#define VR_EMPTY 0x00
#define VR_TAKEN 0x01
#define VR_RESERVED 0x02

#define VRAMSIZE 0x20000

char VRFL [VRAMSIZE];
char VRAM [VRAMSIZE];

int LineAdvance; // 0x40 for 256 width or 0x80 for 320 width (plane width basically)

// -----------------------------------------------------------------------------
// These levels were supplied by Tiido, who measured them with a scope to collect the voltage:
//
// Normal:   0 ---  52 ---  87 --- 116 --- 144 --- 172 --- 206 --- 255
// Shadow:   0  29  52  70  87 101 116 130 --- --- --- --- --- --- ---
// HiLite: --- --- --- --- --- --- --- 130 144 158 172 187 206 228 255
// -----------------------------------------------------------------------------

#define MIDCOLOUR 130
short SwapTiidoSH [] = {   0,  29,  52,  70,  87, 101, 116, 130, 144, 158, 172, 187, 206, 228, 255, -1 };
short FlagTiidoSH [] = {   0,  -1,   0,  -1,   0,  -1,   0,0x80,   0,  +1,   0,  +1,   0,  +1,   0 };
u_char SwapListSH [rangeof (u_char)];
short FlagListSH [rangeof (u_char)];

short SwapTiidoNO [] = {   0,  52,  87, 116, 144, 172, 206, 255, -1 };
short FlagTiidoNO [] = {   0,   0,   0,   0,   0,   0,   0,   0 };
u_char SwapListNO [rangeof (u_char)];
short FlagListNO [rangeof (u_char)];

short SwapSHADOW [] = {    0,  29,  52,  70,  87, 101, 116, 130, -1 };
short SwapHILITE [] = {  130, 144, 158, 172, 187, 206, 228, 255, -1 };
short SwapCRAM [] = {    0x0, 0x2, 0x4, 0x6, 0x8, 0xA, 0xC, 0xE };

// -----------------------------------------------------------------------------
// Structures
// -----------------------------------------------------------------------------

struct PALLIST

{
	PIX_BGRA Colour;
	int Count;
};

// =============================================================================
// -----------------------------------------------------------------------------
// Generating the table of colour slots based on Tiido's entries
// -----------------------------------------------------------------------------

void GenerateTable (short *SwapIn, short *FlagIn, u_char *SwapOut, short *FlagOut)

{
	int Count, Pos, Dist;
	for (Count = 0; Count < 0x100; Count++)
	{
		for (Pos = 0; SwapIn [Pos] >= 0; Pos++)
		{
			if (SwapIn [Pos] >= Count)
			{
				break;
			}
		}
		if (SwapIn [Pos] < 0)
		{
			Pos--;
		}
		if (Pos != 0)
		{
			Dist = SwapIn [Pos] - Count;
			if ((Count - SwapIn [Pos - 1]) < Dist)
			{
				Pos--;
			}
		}
		SwapOut [Count] = SwapIn [Pos];
		FlagOut [Count] = FlagIn [Pos];
	}
}

// =============================================================================
// -----------------------------------------------------------------------------
// Converting a colour to its shadow/highlight version
// -----------------------------------------------------------------------------
// GetShadow (Colour, SwapTiidoNO, SwapSHADOW);
// GetShadow (Colour, SwapTiidoNO, SwapHILITE);
// -----------------------------------------------------------------------------

PIX_BGRA GetShadow (PIX_BGRA Colour, short *Source, short *Table)

{
	int Count;
	for (Count = 0; Count < 8; Count++)
	{
		if (Source [Count] == Colour.Blue)
		{
			Colour.Blue = Table [Count];
			break;
		}
	}
	if (Count == 8)
	{
		printf ("ERROR; colour is out of bounds...\n");
		fflush (stdin); getchar ( );
	}
	for (Count = 0; Count < 8; Count++)
	{
		if (Source [Count] == Colour.Green)
		{
			Colour.Green = Table [Count];
			break;
		}
	}
	if (Count == 8)
	{
		printf ("ERROR; colour is out of bounds...\n");
		fflush (stdin); getchar ( );
	}
	for (Count = 0; Count < 8; Count++)
	{
		if (Source [Count] == Colour.Red)
		{
			Colour.Red = Table [Count];
			break;
		}
	}
	if (Count == 8)
	{
		printf ("ERROR; colour is out of bounds...\n");
		fflush (stdin); getchar ( );
	}
	return (Colour);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Loading correct colour
// -----------------------------------------------------------------------------
// The "Degrade" flag will load the normal colour that you need to get the
// shadow/highlight colour that it would display.
// Disabling this flag will give you the resulting shadow/highlight colour itself
// -----------------------------------------------------------------------------

PIX_BGRA GetColour (PIX_BGRA Colour, bool SH, bool Degrade, int &Return)

{
	PIX_BGRA Output = { 0, 0, 0, 0 };
	if (SH == TRUE)
	{
		if (		(FlagListSH [Colour.Red  ] <= 0 || FlagListSH [Colour.Red  ] == 0x80) && SwapListSH [Colour.Red  ] <= MIDCOLOUR &&
				(FlagListSH [Colour.Green] <= 0 || FlagListSH [Colour.Green] == 0x80) && SwapListSH [Colour.Green] <= MIDCOLOUR &&
				(FlagListSH [Colour.Blue ] <= 0 || FlagListSH [Colour.Blue ] == 0x80) && SwapListSH [Colour.Blue ] <= MIDCOLOUR )
		{
			if (	FlagListSH [Colour.Red  ] < 0 || FlagListSH [Colour.Red  ] == 0x80 ||
				FlagListSH [Colour.Green] < 0 || FlagListSH [Colour.Green] == 0x80 ||
				FlagListSH [Colour.Blue ] < 0 || FlagListSH [Colour.Blue ] == 0x80 )
			{
				// Shadow Colour

				Output.Red   = SwapListSH [Colour.Red];
				Output.Green = SwapListSH [Colour.Green];
				Output.Blue  = SwapListSH [Colour.Blue];
				if (Degrade == TRUE)
				{
					Output = GetShadow (Output, SwapSHADOW, SwapTiidoNO);
				}
				Return = -1;
				return (Output);
			}
		}
		else if (	(FlagListSH [Colour.Red  ] >= 0 || FlagListSH [Colour.Red  ] == 0x80) && SwapListSH [Colour.Red  ] >= MIDCOLOUR &&
				(FlagListSH [Colour.Green] >= 0 || FlagListSH [Colour.Green] == 0x80) && SwapListSH [Colour.Green] >= MIDCOLOUR &&
				(FlagListSH [Colour.Blue ] >= 0 || FlagListSH [Colour.Blue ] == 0x80) && SwapListSH [Colour.Blue ] >= MIDCOLOUR )
		{
			if (	FlagListSH [Colour.Red  ] > 0 || FlagListSH [Colour.Red  ] == 0x80 ||
				FlagListSH [Colour.Green] > 0 || FlagListSH [Colour.Green] == 0x80 ||
				FlagListSH [Colour.Blue ] > 0 || FlagListSH [Colour.Blue ] == 0x80 )
			{
				// Highlight Colour
				Output.Red   = SwapListSH [Colour.Red];
				Output.Green = SwapListSH [Colour.Green];
				Output.Blue  = SwapListSH [Colour.Blue];
				if (Degrade == TRUE)
				{
					Output = GetShadow (Output, SwapHILITE, SwapTiidoNO);
				}
				Return = +1;
				return (Output);
			}
		}
	}
	Output.Red   = SwapListNO [Colour.Red];
	Output.Green = SwapListNO [Colour.Green];
	Output.Blue  = SwapListNO [Colour.Blue];
	Return = 0;
	return (Output);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Setting an area of VRAM with a specific value
// -----------------------------------------------------------------------------

void SetVRAM (int Offset, int Size, char Value)

{
	if (Size == 0)
	{
		Size = VRAMSIZE;
	}
	while (Size-- > 0)
	{
		VRFL [Offset] = Value;
		VRAM [Offset++] = 0x00;
	}
}

// =============================================================================
// -----------------------------------------------------------------------------
// Creating a tile of a given palette line
// -----------------------------------------------------------------------------

void LoadTile (char *Tile, int PalLine, IMG Image, int PosX, int PosY, bool SH)

{
	u_char Byte;
	int PixelX, PixelY;
	for (PixelY = 0; PixelY < 8; PixelY++)
	{
		for (PixelX = 0; PixelX < 8; PixelX++)
		{
			int ImageLoc = (PosX + PixelX) + ((PosY + PixelY) * Image.SizeX);
			if (((Image.Data [ImageLoc].Alpha & 0x30) >> 0x04) == PalLine)
			{
				Byte = Image.Data [ImageLoc].Alpha & 0x0F;
				if (SH == TRUE)		// Are we meant to check for the SH/L colour slots?
				{
					if (Byte >= 0x0E)
					{
						Byte = 0x00;	// Ignore pixels for colour slots E and F...
					}
				}
			}
			else if (SH == TRUE)
			{
				Byte = Image.Data [ImageLoc].Alpha & 0xC0;
				// New looking for shadow/highlight colours
				if (Byte == 0x80)
				{
					Byte = 0x0F;	// Shadow
				}
				else if (Byte == 0x40)
				{
					Byte = 0x0E;	// Hightlight
				}
				else
				{
					Byte = 0x00;
				}
			}
			else
			{
				Byte = 0x00;
			}
			if ((PixelX & 1) == 0)
			{
				Tile [0x00 + ((PixelX / 2) + (PixelY * 4))] = Byte << 4;
				Tile [0x20 + ((3 - (PixelX / 2)) + (PixelY * 4))] = Byte & 0x0F;
				Tile [0x40 + ((PixelX / 2) + ((7 - PixelY) * 4))] = Byte << 4;
				Tile [0x60 + ((3 - (PixelX / 2)) + ((7 - PixelY) * 4))] = Byte & 0x0F;
			}
			else
			{
				Tile [0x00 + ((PixelX / 2) + (PixelY * 4))] |= Byte & 0x0F;
				Tile [0x20 + ((3 - (PixelX / 2)) + (PixelY * 4))] |= Byte << 4;
				Tile [0x40 + ((PixelX / 2) + ((7 - PixelY) * 4))] |= Byte & 0x0F;
				Tile [0x60 + ((3 - (PixelX / 2)) + ((7 - PixelY) * 4))] |= Byte << 4;
			}
		}
	}
}

// =============================================================================
// -----------------------------------------------------------------------------
// Comparing a tile with one in VRAM, counting the number of matches
// -----------------------------------------------------------------------------

bool CompareTile (char *Tile, int Pos, int Size, int &Match)

{
	int Count;
	Match = 0;
	for (Count = 0; Count < Size; Count++, Pos++)
	{
		if (VRFL [Pos] == VR_EMPTY)
		{
			continue;
		}
		if (VRFL [Pos] == VR_RESERVED)
		{
			return (FALSE);
		}
		if (VRAM [Pos] != Tile [Count])
		{
			return (FALSE);
		}
		Match++;
	}
	return (TRUE);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Finding tiles if they already exist
// -----------------------------------------------------------------------------

int FindTile (char *Tile, int Size, int &Overflow)

{
	int Pos, Match;
	int BestPos, BestTile, BestMatch = -1, BestFlip;
	for (Pos = 0; (Pos + Size) < VRAMSIZE; Pos += 0x20)
	{
		if (CompareTile (&Tile [(Size * 0)], Pos, Size, Match) == TRUE)
		{
			if (Match > BestMatch)
			{
				BestMatch = Match;
				BestPos = Pos;
				BestTile = (Size * 0);
				BestFlip = 0;
				if (BestMatch == Size)
				{
					break;
				}
			}
		}
		if (CompareTile (&Tile [(Size * 1)], Pos, Size, Match) == TRUE)
		{
			if (Match > BestMatch)
			{
				BestMatch = Match;
				BestPos = Pos;
				BestTile = (Size * 1);
				BestFlip = 1;
				if (BestMatch == Size)
				{
					break;
				}
			}
		}
		if (CompareTile (&Tile [(Size * 2)], Pos, Size, Match) == TRUE)
		{
			if (Match > BestMatch)
			{
				BestMatch = Match;
				BestPos = Pos;
				BestTile = (Size * 2);
				BestFlip = 2;
				if (BestMatch == Size)
				{
					break;
				}
			}
		}
		if (CompareTile (&Tile [(Size * 3)], Pos, Size, Match) == TRUE)
		{
			if (Match > BestMatch)
			{
				BestMatch = Match;
				BestPos = Pos;
				BestTile = (Size * 3);
				BestFlip = 3;
				if (BestMatch == Size)
				{
					break;
				}
			}
		}
	}
	if (BestMatch < 0)
	{
		return (BestMatch); // error, could not find any place to put this tile
	}
	if ((BestPos + Size) > Overflow)
	{
		Overflow = (BestPos + Size);
	}
	return (((BestPos / 0x20) & 0xFFFF) | ((BestTile & 0x0FFF) << 0x10) | (BestFlip << 0x1C));
}

// =============================================================================
// -----------------------------------------------------------------------------
// Generating tiles for a plane of a specific palette (and generate mappings)
// -----------------------------------------------------------------------------

bool ReadSprites (IMG Image, int Sprites, int &Overflow, char *ShadowTiles, bool ShadowOn)

{
	int PalLine = 3; // It has to be 3 in order to use the shadow/highlight colour slots
	int LinkID = 0;
	char Tile [0x20 * 4];
	char Art [(0x20 * (4 * 4)) * 4] = { 0 };
	int Count, CountX, CountY, SpriteX, SpriteY;
	for (CountY = 0; CountY < Image.SizeY && LinkID != 0x50; CountY += 0x20)
	{
		for (CountX = 0; CountX < Image.SizeX && LinkID != 0x50; CountX += 0x20)
		{
			int SPX = 4;
			int SPY = 4;
			if ((Image.SizeY - CountY) < 0x20)
			{
				SPY = 2; // This is 240 mode (which is larger by half a sprite)
			}
			char ArtMark [SPX * SPY] = { 0 };
			for (SpriteX = 0; SpriteX < 0x20; SpriteX += 8)
			{
				for (SpriteY = 0; SpriteY < (SPY << 0X03); SpriteY += 8)
				{
					bool Blank = TRUE;
					if (ShadowTiles [((CountX + SpriteX) / 8) + (((CountY + SpriteY) / 8) * (Image.SizeX / 8))] != 0x40)
					{
						LoadTile (Tile, PalLine, Image, CountX + SpriteX, CountY + SpriteY, ShadowOn);
						for (Count = 0; Count < 0x20; Count++)
						{
							if (Tile [Count] != 0)
							{
								Blank = FALSE;
							}
							Art [Count+((SpriteY * SPY) + (SpriteX * 0x10)) + ((0x20 * (SPX * SPY)) * 0)] = Tile [Count+0x00];
							Art [Count+((SpriteY * SPY) + ((0x18 - SpriteX) * 0x10)) + ((0x20 * (SPX * SPY)) * 1)] = Tile [Count+0x20];
							Art [Count+(((0x18 - SpriteY) * SPY) + (SpriteX * 0x10)) + ((0x20 * (SPX * SPY)) * 2)] = Tile [Count+0x40];
							Art [Count+(((0x18 - SpriteY) * SPY) + ((0x18 - SpriteX) * 0x10)) + ((0x20 * (SPX * SPY)) * 3)] = Tile [Count+0x60];
						}
					}
					else
					{
						for (Count = 0; Count < 0x20; Count++)
						{
							Art [Count+((SpriteY * SPY) + (SpriteX * 0x10)) + ((0x20 * (SPX * SPY)) * 0)] = 0;
							Art [Count+((SpriteY * SPY) + ((0x18 - SpriteX) * 0x10)) + ((0x20 * (SPX * SPY)) * 1)] = 0;
							Art [Count+(((0x18 - SpriteY) * SPY) + (SpriteX * 0x10)) + ((0x20 * (SPX * SPY)) * 2)] = 0;
							Art [Count+(((0x18 - SpriteY) * SPY) + ((0x18 - SpriteX) * 0x10)) + ((0x20 * (SPX * SPY)) * 3)] = 0;
						}
					}
					if (Blank == FALSE)
					{
						ArtMark [(SpriteY / 8) + ((SpriteX / 8) * SPY)] = 0xFF;
					}
				}
			}

			// Art should now have a 4x4 sprite tile, with flip/mirror varients

			// Consolidating to smaller sprite (if possible)

			int PosX, PosY;
			int StartX = SPX, EndX = -1;
			int StartY = SPY, EndY = -1;
			for (PosX = 0; PosX < SPX; PosX++)
			{
				for (PosY = 0; PosY < SPY; PosY++)
				{
					if (ArtMark [PosY + (PosX * SPY)] != 0)
					{
						if (PosX < StartX) { StartX = PosX; }
						if (PosY < StartY) { StartY = PosY; }
						if (PosX > EndX) { EndX = PosX; }
						if (PosY > EndY) { EndY = PosY; }
					}
				}
			}
			char Sprite [(0x20 * (SPX * SPY)) * 4];
			int SpriteLoc = 0;
			if (EndX >= 0 && EndY >= 0)
			{
				// A sprite exists...
				for (PosX = StartX; PosX <= EndX; PosX++)
				{
					for (PosY = StartY; PosY <= EndY; PosY++)
					{
						for (Count = 0; Count < 0x20; Count++)
						{
							Sprite [Count + SpriteLoc] = Art [(PosX * 0x80) + (PosY * 0x20) + Count + ((0x20 * (SPX * SPY)) * 0)];
						}
						SpriteLoc += 0x20;
					}
				}
				for (PosX = EndX; PosX >= StartX; PosX--)
				{
					for (PosY = StartY; PosY <= EndY; PosY++)
					{
						for (Count = 0; Count < 0x20; Count++)
						{
							Sprite [Count + SpriteLoc] = Art [((3 - PosX) * 0x80) + (PosY * 0x20) + Count + ((0x20 * (SPX * SPY)) * 1)];
						}
						SpriteLoc += 0x20;
					}
				}
				for (PosX = StartX; PosX <= EndX; PosX++)
				{
					for (PosY = EndY; PosY >= StartY; PosY--)
					{
						for (Count = 0; Count < 0x20; Count++)
						{
							Sprite [Count + SpriteLoc] = Art [(PosX * 0x80) + ((3 - PosY) * 0x20) + Count + ((0x20 * (SPX * SPY)) * 2)];
						}
						SpriteLoc += 0x20;
					}
				}
				for (PosX = EndX; PosX >= StartX; PosX--)
				{
					for (PosY = EndY; PosY >= StartY; PosY--)
					{
						for (Count = 0; Count < 0x20; Count++)
						{
							Sprite [Count + SpriteLoc] = Art [((3 - PosX) * 0x80) + ((3 - PosY) * 0x20) + Count + ((0x20 * (SPX * SPY)) * 3)];
						}
						SpriteLoc += 0x20;
					}
				}

				int Pos = FindTile (Sprite, (0x20 * ((EndX + 1) - StartX) * ((EndY + 1) - StartY)), Overflow);
				if (Pos < 0)
				{
					return (FALSE);
				}
				int Flip = (Pos >> 0x11) & 0x1800;
				int TileLoc = (Pos >> 0x10) & 0x0FFF;
				Pos &= 0xFFFF;
				Pos *= 0x20;
				for (Count = 0; Count < (0x20 * ((EndX + 1) - StartX) * ((EndY + 1) - StartY)); Count++)
				{
					VRFL [Pos + Count] = VR_TAKEN;
					VRAM [Pos + Count] = Sprite [TileLoc + Count];
				}

				int YPos = CountY + 0x0080 + (StartY * 8);
				int Shape = ((EndX - StartX) << 2) | (EndY - StartY);
				if (LinkID != 0)
				{
					VRAM [Sprites - 0x05] = LinkID;
				}
				LinkID++;
				int VDP = 0x8000 | (PalLine << 0x0D) | ((Pos / 0x20) | Flip);
				int XPos = CountX + 0x0080 + (StartX * 8);

				VRAM [Sprites] = YPos >> 0x08;	VRFL [Sprites++] = VR_TAKEN;
				VRAM [Sprites] = YPos;		VRFL [Sprites++] = VR_TAKEN;
				VRAM [Sprites] = Shape;		VRFL [Sprites++] = VR_TAKEN;
				VRAM [Sprites] = 0x00;		VRFL [Sprites++] = VR_TAKEN;
				VRAM [Sprites] = VDP >> 0x08;	VRFL [Sprites++] = VR_TAKEN;
				VRAM [Sprites] = VDP;		VRFL [Sprites++] = VR_TAKEN;
				VRAM [Sprites] = XPos >> 0x08;	VRFL [Sprites++] = VR_TAKEN;
				VRAM [Sprites] = XPos;		VRFL [Sprites++] = VR_TAKEN;
			}
		}
	}
	if (LinkID == 0x00)
	{
		LinkID++;
		VRFL [Sprites++] = VR_TAKEN;	// Only the Y position and link ID's need reserving really, the rest can be altered without displaying the sprite
		VRFL [Sprites++] = VR_TAKEN;
		VRFL [Sprites++] = VR_EMPTY;
		VRFL [Sprites++] = VR_TAKEN;
		VRFL [Sprites++] = VR_EMPTY;
		VRFL [Sprites++] = VR_EMPTY;
		VRFL [Sprites++] = VR_EMPTY;
		VRFL [Sprites++] = VR_EMPTY;
	}
	while (LinkID != 0x50)	// The last sprite in the list already has 00 in it as I delay the write anyway.
	{
		LinkID++;
		VRFL [Sprites++] = VR_EMPTY;
		VRFL [Sprites++] = VR_EMPTY;
		VRFL [Sprites++] = VR_EMPTY;
		VRFL [Sprites++] = VR_EMPTY;
		VRFL [Sprites++] = VR_EMPTY;
		VRFL [Sprites++] = VR_EMPTY;
		VRFL [Sprites++] = VR_EMPTY;
		VRFL [Sprites++] = VR_EMPTY;
	}
	return (TRUE);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Generating tiles for a plane of a specific palette (and generate mappings)
// -----------------------------------------------------------------------------

bool ReadPlane (IMG Image, int Plane, int PalLine, int &Overflow, char *ShadowTiles)

{
	char Tile [0x20 * 4];
	int Count, CountX, CountY;
	for (CountY = 0; CountY < Image.SizeY; CountY += 8)
	{
		for (CountX = 0; CountX < Image.SizeX; CountX += 8)
		{
			LoadTile (Tile, PalLine, Image, CountX, CountY, FALSE);

			int Pos = FindTile (Tile, 0x20, Overflow);
			if (Pos < 0)
			{
				return (FALSE);
			}
			int Flip = (Pos >> 0x11) & 0x1800;
			int TileLoc = (Pos >> 0x10) & 0x0FFF;
			Pos &= 0xFFFF;
			Pos *= 0x20;
			for (Count = 0; Count < 0x20; Count++)
			{
				VRFL [Pos + Count] = VR_TAKEN;
				VRAM [Pos + Count] = Tile [TileLoc + Count];
			}
			int ShadowPlane = 0x0000;
			if (ShadowTiles [(CountX / 8) + ((CountY / 8) * (Image.SizeX / 8))] != 0x40)
			{
				ShadowPlane = 0x8000;
			}
			VRAM [Plane + ((CountX / 8) * 2) + ((CountY / 8) * LineAdvance) + 0] = (ShadowPlane | (PalLine << 0x0D) | ((Pos / 0x20) | Flip)) >> 0x08;
			VRAM [Plane + ((CountX / 8) * 2) + ((CountY / 8) * LineAdvance) + 1] = (ShadowPlane | (PalLine << 0x0D) | ((Pos / 0x20) | Flip)) & 0xFF;
			VRFL [Plane + ((CountX / 8) * 2) + ((CountY / 8) * LineAdvance) + 0] = VR_TAKEN;
			VRFL [Plane + ((CountX / 8) * 2) + ((CountY / 8) * LineAdvance) + 1] = VR_TAKEN;
		}
	}
	return (TRUE);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Subroutine to convert a hexadecimal value to a hex represented decimal value
// -----------------------------------------------------------------------------

int HexDec (unsigned int Hexadecimal)

{
	int Decimal = 0x00000000, DecimalDigit, DecimalPlaceLoc = 0x00000000;
	int DecimalPlace [] = {	10000000,
							1000000,
							100000,
							10000,
							1000,
							100,
							10,
							1,
							0x00 };
	DecimalDigit = DecimalPlace [DecimalPlaceLoc++];
	while (Hexadecimal > 99999999)
	{
		Hexadecimal = 99999999;
	}
	while (DecimalDigit != 0x00)
	{
		Decimal <<= 0x04;
		Hexadecimal -= DecimalDigit;
		while (Hexadecimal < 0x80000000)
		{
			Decimal++;
			Hexadecimal -= DecimalDigit;
		}
		Hexadecimal += DecimalDigit;
		DecimalDigit = DecimalPlace [DecimalPlaceLoc++];
	}
	return (Decimal);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Subroutine to convert a hex represented decimal value to a hexadecimal value
// -----------------------------------------------------------------------------

int DecHex (unsigned int Decimal)

{
	int Hexadecimal = 0x00000000, DecimalDigit, HexadecimalPlaceLoc = 0x00000000;
	int HexadecimalPlace [] = {	1,
								10,
								100,
								1000,
								10000,
								100000,
								1000000,
								10000000,
								0x00 };
	while (Decimal > 0x99999999)
	{
		Decimal = 0x99999999;
	}
	while (HexadecimalPlace [HexadecimalPlaceLoc] != 0x00)
	{
		DecimalDigit = Decimal & 0x0F;
		Decimal >>= 0x04;
		while (DecimalDigit != 0x00)
		{
			Hexadecimal += HexadecimalPlace [HexadecimalPlaceLoc];
			DecimalDigit--;
		}
		HexadecimalPlaceLoc++;
	}
	return (Hexadecimal);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Displaying an error message correctly
// -----------------------------------------------------------------------------

void DisplayError (const char *Message,  ...)

{
	char TEXT [0x1000];
	va_list ArgList;
	va_start (ArgList, Message);
	vsnprintf (TEXT, 0x1000, Message, ArgList);
	va_end (ArgList);

	if (GUIMODE == GM_CONSOLE)
	{
		printf ("Bitmap MD - Error; %s\n", TEXT);
	}
	else if (GUIMODE == GM_DRAG)
	{
		printf ("    Error; %s\n", TEXT);
	}
	else
	{
		MessageBox (NULL, TEXT, "Error", MB_OK | MB_ICONEXCLAMATION);
	}
}


// =============================================================================
// -----------------------------------------------------------------------------
// Subroutine to perform printf but only if the GUIMODE is not in Console mode
// -----------------------------------------------------------------------------

void printn (const char *Message,  ...)

{
	if (GUIMODE != GM_CONSOLE)
	{
		char TEXT [0x1000];
		va_list ArgList;
		va_start (ArgList, Message);
		vprintf (Message, ArgList);
		va_end (ArgList);
	}
}

// =============================================================================
// -----------------------------------------------------------------------------
// Subroutine to pass an error to a neighbour pixel (error is the distance the current pixel had lost)
// -----------------------------------------------------------------------------

int SortColour (u_char Colour, u_char DistColour, int Calc, int Max)

{
	short DistCol = DistColour << 0x08;	// convert to signed...
	DistCol >>= 0x08;			// convert to signed...
	int ColAmount = ((Calc * DistCol) / Max) + (Colour & 0xFF);
	if (ColAmount < 0)
	{
		return (0x00);
	}
	else if (ColAmount > 0xFF)
	{
		return (0xFF);
	}
	else
	{
		return (ColAmount);
	}
}

void SortNeighbour (IMG *Image, IMG *Original, int PosX, int PosY, int ActualSizeX, int ActualSizeY, int NextX, int NextY, int Calc, int Max, PIX_BGRA DistColour, bool ShadowOn)

{
	int StartX = (Image->SizeX - ActualSizeX) >> 1;
	int SizeX = (Image->SizeX - StartX) - ((Image->SizeX - ActualSizeX) & 1);
	int StartY = (Image->SizeY - ActualSizeY) >> 1;
	int SizeY = (Image->SizeY - StartY) - ((Image->SizeY - ActualSizeY) & 1);
	NextX += PosX;
	NextY += PosY;
	if (NextX >= StartX && NextX < SizeX && NextY >= StartY && NextY < SizeY)
	{
		int Pos = NextX + (NextY * Image->SizeX);
		Original->Data [Pos].Blue  = SortColour (Original->Data [Pos].Blue , DistColour.Blue , Calc, Max);
		Original->Data [Pos].Green = SortColour (Original->Data [Pos].Green, DistColour.Green, Calc, Max);
		Original->Data [Pos].Red   = SortColour (Original->Data [Pos].Red  , DistColour.Red  , Calc, Max);
	}
}

// =============================================================================
// -----------------------------------------------------------------------------
// Applying order threshold onto a colour
// -----------------------------------------------------------------------------

void OrderPixel (u_char &OutColour, u_char InDist, int Threshold, int Maxhold)

{
	short DistCol = InDist << 0x08;		// convert to signed...
	DistCol >>= 0x08;			// convert to signed...
	OutColour += (DistCol * Threshold) / Maxhold;
}

// =============================================================================
// -----------------------------------------------------------------------------
// Converting an Image
// -----------------------------------------------------------------------------

#define ERR_ALLOC 0x01
#define ERR_FILE 0x02
#define ERR_VRAM 0x03
#define ERR_UNKNOWN 0x04
#define ERR_VRAM2 0x05

int ConvertImage (IMG *Picture, int Width, int Height, bool WidthCounter, bool HeightCounter, int PlaneCount, bool SpritesOn, bool ShadowOn, bool CommonArt, int &Overflow, bool GetOnlyPreview)

{
	if (GetOnlyPreview == FALSE)
	{
		char SC [] = { " C" };
		char SP [] [3+1] = { { "No " }, { "Yes" } };
		char SM [] [7+1] = { { "Stretch" }, { "Fit    " }, { "Fill   " }, { "Custom " } };
		char DI [] [5+1] = { { "None " }, { "Floyd" }, { "Order" } };
		printn ("    %3d%c x %3d%c | Planes %d | Sprites %s | S/H %s | Interpolate %s | %s\n    Forced shadow colours %s | Sprite priority colours %s\n", Width, SC [WidthCounter&1], Height, SC [HeightCounter&1], PlaneCount, SP [SpritesOn&1], SP [ShadowOn&1], SP [INTERPOLATION&1], SM [SCALETYPE], SP [FORCESHADOW&1], SP [CommonArt&1]);
	}
	if (SpritesOn == FALSE)
	{
		ShadowOn = FALSE;
	}

	char Byte;
	PIX_BGRA PadColour = { 0, 0, 0, 0 };
	int Count, CountX, CountY, PixelX, PixelY;
	IMG Original, Image; Original.Data = NULL; Image.Data = NULL;
	free (Preview.Data); Preview.Data = NULL;

	if ((Original.Data = (PIX_BGRA*) malloc (Picture->Size * sizeof (PIX_BGRA))) == NULL)
	{
		DisplayError ("could not allocate a copy of the image");
		return (ERR_ALLOC);
	}
	int ActualSizeX, ActualSizeY;
	Original.Size = Picture->Size;
	Original.SizeX = Picture->SizeX;
	Original.SizeY = Picture->SizeY;
	for (Count = 0; Count < Picture->Size; Count++)
	{
		Original.Data [Count] = Picture->Data [Count];
	}

	// --- Resizing ---

	int SnapSize = 0;
	if (SNAPTILE == TRUE && SCALETYPE != ST_CUSTOM)
	{
		SnapSize = 8 * 2;
	}

	int ScaleMode = SCALETYPE;
	if (SCALETYPE == ST_CUSTOM)
	{
		ScaleMode = ST_FIT;

		int ScaleXDist = ScaleX;
		int ScaleYDist = ScaleY;

		if (MAINTAINASPECT == TRUE)
		{
			ScaleYDist += (Original.SizeY * (ScaleX - MainX)) / Original.SizeX;
			ScaleXDist += (Original.SizeX * (ScaleY - MainY)) / Original.SizeY;
		}

		int WidthDist = (Original.SizeX * ScaleXDist) / Width;
		int HeightDist = (Original.SizeY * ScaleYDist) / Height;

		ResizeImage (&Original, Original.SizeX + (WidthDist*2), Original.SizeY + (HeightDist*2), PadColour, ST_STRETCH, INTERPOLATION, ActualSizeX, ActualSizeY, SnapSize, SnapSize);
		TruncateImage (&Original, WidthDist, HeightDist, Original.SizeX-WidthDist, Original.SizeY-HeightDist, PadColour);
	}

	if (WidthCounter == TRUE || HeightCounter == TRUE)
	{

		// These are for countering the X and Y stretching the VDP
		// does when in H32 mode, or in NTSC mode with V28.

		if (HeightCounter != TRUE)
		{
			ResizeImage (&Original, 320, Height, PadColour, ScaleMode, INTERPOLATION, ActualSizeX, ActualSizeY, SnapSize, SnapSize);
		}
		else if (WidthCounter != TRUE)
		{
			ResizeImage (&Original, Width, 240, PadColour, ScaleMode, INTERPOLATION, ActualSizeX, ActualSizeY, SnapSize, SnapSize);
		}
		else
		{
			ResizeImage (&Original, 320, 240, PadColour, ScaleMode, INTERPOLATION, ActualSizeX, ActualSizeY, SnapSize, SnapSize);
		}
		ResizeImage (&Original, Width, Height, PadColour, BH_STRETCH, INTERPOLATION, ActualSizeX, ActualSizeY, 0, 0);
	}
	else
	{
		// No countering at all, just do it normally...

		ResizeImage (&Original, Width, Height, PadColour, ScaleMode, INTERPOLATION, ActualSizeX, ActualSizeY, SnapSize, SnapSize);
	}

	// --- (Making memory areas for image/preview) ---

	Image.Size = Original.Size;
	Image.SizeX = Original.SizeX;
	Image.SizeY = Original.SizeY;
	if ((Image.Data = (PIX_BGRA*) malloc (Image.Size * sizeof (PIX_BGRA))) == NULL)
	{
		free (Original.Data); Original.Data = NULL;
		DisplayError ("cannot allocate memory for the image");
		return (ERR_ALLOC);
	}
	Preview.Size = Original.Size;
	Preview.SizeX = Original.SizeX;
	Preview.SizeY = Original.SizeY;
	if ((Preview.Data = (PIX_BGRA*) malloc (Preview.Size * sizeof (PIX_BGRA))) == NULL)
	{
		free (Preview.Data); Preview.Data = NULL;
		free (Image.Data); Image.Data = NULL;
		free (Original.Data); Original.Data = NULL;
		DisplayError ("cannot allocate memory for the preview");
		return (ERR_ALLOC);
	}

	// --- Getting Palette ---

	// Getting all the available colours in "non-shadow" mode
	// first, that way we can collect all the necessary colours
	// and apply shadow if needed (Note the degrade flag is set on GetColour)

	bool FAIL = FALSE;
	int ReturnShadow;

	if (DITHERTYPE == NULL)
	{
		for (Count = 0; Count < Original.Size; Count++)
		{
			Image.Data [Count] = GetColour (Original.Data [Count], ShadowOn, FALSE, ReturnShadow);
			Image.Data [Count].Alpha = ReturnShadow;
		}
	}
	else
	{
		PIX_BGRA DistColour;
		for (Count = 0; Count < Original.Size; Count++)
		{
			// WARNING, DEGRADE IS TURNED OFF FOR DITHERING UNTIL AFTERWARDS.

			// In order to get the quantisation error (difference), we need to know what the REAL colour
			// is, and NOT the degraded version that shadow/highlight will convert from.
			// (Basically we need to return the resulting colour, not the colour that will create it when shadowed).

			// Degrading is done AFTER the difference and quantisation is handled.

			Image.Data [Count] = GetColour (Original.Data [Count], ShadowOn, FALSE, ReturnShadow);
			Image.Data [Count].Alpha = ReturnShadow;
			DistColour.Blue  = Original.Data [Count].Blue  - Image.Data [Count].Blue;
			DistColour.Green = Original.Data [Count].Green - Image.Data [Count].Green;
			DistColour.Red   = Original.Data [Count].Red   - Image.Data [Count].Red;
			int PosX = Count % Image.SizeX;
			int PosY = Count / Image.SizeX;
			int *DitherList = DITHERTYPE;
			if (*DitherList < 0)
			{
				int ModX = DitherList [0x01];
				int ModY = DitherList [0x02];
				int Max = ModX * ModY;
				int Threshold = DitherList [0x03 + (PosX % ModX) + ((PosY % ModY) * ModX)];
				OrderPixel (Original.Data [Count].Blue , DistColour.Blue , Threshold, Max);
				OrderPixel (Original.Data [Count].Green, DistColour.Green, Threshold, Max);
				OrderPixel (Original.Data [Count].Red  , DistColour.Red  , Threshold, Max);
				Image.Data [Count] = GetColour (Original.Data [Count], ShadowOn, FALSE, ReturnShadow);
				Image.Data [Count].Alpha = ReturnShadow;
			}
			else
			{
				while (*DitherList != 0)
				{
					SortNeighbour (&Image, &Original, PosX, PosY, ActualSizeX, ActualSizeY, DitherList [0x02], DitherList [0x03], DitherList [0x01], DitherList [0x00], DistColour, ShadowOn);
					DitherList = &DitherList [0x04];
				}
			}
		}
	}

	int PalListPos, PalListLoc = 0, PalListSize = 0x40;
	PALLIST *PalList = (PALLIST*) malloc (PalListSize * sizeof (PALLIST));
	if (PalList == NULL)
	{
		free (Preview.Data); Preview.Data = NULL;
		free (Image.Data); Image.Data = NULL;
		free (Original.Data); Original.Data = NULL;
		DisplayError ("cannot allocate memory for palette count");
		return (ERR_ALLOC);
	}
	PalList [PalListLoc].Colour.Blue  = 0x00; // Ensure first colour is always black (transparent backdrop)
	PalList [PalListLoc].Colour.Green = 0x00;
	PalList [PalListLoc].Colour.Red   = 0x00;
	PalList [PalListLoc++].Count = 0;
	for (Count = 0; Count < Image.Size; Count++)
	{
		PIX_BGRA DegradeCol = GetColour (Image.Data [Count], ShadowOn, ShadowOn, ReturnShadow);
		DegradeCol.Alpha = ReturnShadow;
		for (PalListPos = 0; PalListPos < PalListLoc; PalListPos++)
		{
			if (	DegradeCol.Blue  == PalList [PalListPos].Colour.Blue  &&
				DegradeCol.Green == PalList [PalListPos].Colour.Green &&
				DegradeCol.Red   == PalList [PalListPos].Colour.Red   )
				{
				PalList [PalListPos].Count++;
				PalList [PalListPos].Colour.Alpha |= DegradeCol.Alpha;
				while (PalListPos > 1) // Not counting 0, since we want to keep this as black always...
				{
					if (PalList [PalListPos - 1].Count >= PalList [PalListPos].Count)
					{
						break;
					}
					PIX_BGRA TempCol;
					int TempCount = PalList [PalListPos - 1].Count;
					TempCol.Blue  = PalList [PalListPos - 1].Colour.Blue;
					TempCol.Green = PalList [PalListPos - 1].Colour.Green;
					TempCol.Red   = PalList [PalListPos - 1].Colour.Red;
					TempCol.Alpha = PalList [PalListPos - 1].Colour.Alpha;
					PalList [PalListPos - 1].Count        = PalList [PalListPos].Count;
					PalList [PalListPos - 1].Colour.Blue  = PalList [PalListPos].Colour.Blue;
					PalList [PalListPos - 1].Colour.Green = PalList [PalListPos].Colour.Green;
					PalList [PalListPos - 1].Colour.Red   = PalList [PalListPos].Colour.Red;
					PalList [PalListPos - 1].Colour.Alpha = PalList [PalListPos].Colour.Alpha;
					PalList [PalListPos].Count = TempCount;
					PalList [PalListPos].Colour.Blue  = TempCol.Blue;
					PalList [PalListPos].Colour.Green = TempCol.Green;
					PalList [PalListPos].Colour.Red   = TempCol.Red;
					PalList [PalListPos--].Colour.Alpha = TempCol.Alpha;
				}
				break;
			}
		}
		if (PalListPos == PalListLoc)
		{
			if (PalListLoc == PalListSize)
			{
				PalListSize <<= 1;
				PALLIST *NewList = (PALLIST*) realloc (PalList, PalListSize * sizeof (PALLIST));
				if (NewList == NULL)
				{
					FAIL = TRUE;
					free (PalList); PalList = NULL;
					free (Preview.Data); Preview.Data = NULL;
					free (Image.Data); Image.Data = NULL;
					free (Original.Data); Original.Data = NULL;
					DisplayError ("cannot reallocate memory for palette count");
					break;
				}
				PalList = NewList;
				NewList = NULL;
			}
			PalList [PalListLoc].Colour.Blue  = DegradeCol.Blue;
			PalList [PalListLoc].Colour.Green = DegradeCol.Green;
			PalList [PalListLoc].Colour.Red   = DegradeCol.Red;
			PalList [PalListLoc].Colour.Alpha = DegradeCol.Alpha;
			PalList [PalListLoc++].Count = 0;
		}
	}
	if (FAIL == TRUE)
	{
		return (ERR_UNKNOWN);
	}
	PalListSize = PalListLoc;

	int PalListMax = 0x01+0x0F+0x0F+0x0F;
	if (PalListMax > PalListSize)
	{
		PalListMax = PalListSize;
	}

	if (FORCESHADOW == TRUE)
	{
		int ShadowColours = 0;
		for (PalListLoc = 1; PalListLoc < PalListMax; PalListLoc++)
		{
			if (PalList [PalListLoc].Colour.Alpha != 0x00)
			{
				ShadowColours++;
			}
		}
		PIX_BGRA ShadowPal [ShadowColours];
		PIX_BGRA NormalPal [0x0F+0x0F+0x0F - ShadowColours];
		int ShadSize, NormSize, ShadLoc, NormLoc;
		for (ShadSize = 0, NormSize = 0, PalListLoc = 1; PalListLoc < PalListMax; PalListLoc++)
		{
			if (PalList [PalListLoc].Colour.Alpha == 0x00)
			{
				NormalPal [NormSize].Blue  = PalList [PalListLoc].Colour.Blue;
				NormalPal [NormSize].Green = PalList [PalListLoc].Colour.Green;
				NormalPal [NormSize].Red   = PalList [PalListLoc].Colour.Red;
				NormalPal [NormSize].Alpha = PalList [PalListLoc].Colour.Alpha;
				NormSize++;
			}
			else
			{
				ShadowPal [ShadSize].Blue  = PalList [PalListLoc].Colour.Blue;
				ShadowPal [ShadSize].Green = PalList [PalListLoc].Colour.Green;
				ShadowPal [ShadSize].Red   = PalList [PalListLoc].Colour.Red;
				ShadowPal [ShadSize].Alpha = PalList [PalListLoc].Colour.Alpha;
				ShadSize++;
			}
		}
		for (PalListLoc = 1, ShadLoc = 0; ShadLoc < ShadSize; ShadLoc++, PalListLoc++)
		{
			PalList [PalListLoc].Colour.Blue  = ShadowPal [ShadLoc].Blue;
			PalList [PalListLoc].Colour.Green = ShadowPal [ShadLoc].Green;
			PalList [PalListLoc].Colour.Red   = ShadowPal [ShadLoc].Red;
			PalList [PalListLoc].Colour.Alpha = ShadowPal [ShadLoc].Alpha;
		}
		for (NormLoc = 0; NormLoc < NormSize; NormLoc++, PalListLoc++)
		{
			PalList [PalListLoc].Colour.Blue  = NormalPal [NormLoc].Blue;
			PalList [PalListLoc].Colour.Green = NormalPal [NormLoc].Green;
			PalList [PalListLoc].Colour.Red   = NormalPal [NormLoc].Red;
			PalList [PalListLoc].Colour.Alpha = NormalPal [NormLoc].Alpha;
		}
	}
	else if (CommonArt == CA_SPRITES)
	{
		// If sprites should display the most common art, the best way is to
		// ensure the most common colours are on the sprites' palette line
		// instead.

		// This may sacrifice quality in favour of memory


	PalListMax = 0x01+0x0F+0x0F+0x0F;
	if (PalListMax > PalListSize)
	{
		PalListMax = PalListSize;
	}

		int SpritePalLoc = 0, SpritePalSize = 0x0D;
		if (ShadowOn == FALSE)
		{
			SpritePalSize += 0x02; // Include the end two sprites colours (since shadow/highlight is off)
		}
	if ((PalListMax - 0x01+0x0F+0x0F) < SpritePalSize)
	{
		SpritePalSize = PalListMax - 0x01+0x0F+0x0F;
		if (SpritePalSize < 0)
		{
			SpritePalSize = 0;
		}
	}
	if (PalListMax > 0x01+0x0F+0x0F)
	{
		PalListMax = 0x01+0x0F+0x0F;
	}
		PIX_BGRA SpritePal [SpritePalSize];

		for (PalListLoc = 1; PalListLoc < 0x01+SpritePalSize; PalListLoc++, SpritePalLoc++)
		{
			SpritePal [SpritePalLoc].Blue  = PalList [PalListLoc].Colour.Blue;
			SpritePal [SpritePalLoc].Green = PalList [PalListLoc].Colour.Green;
			SpritePal [SpritePalLoc].Red   = PalList [PalListLoc].Colour.Red;
		}
		for (PalListLoc = 1; PalListLoc < PalListMax; PalListLoc++)
		{
			PalList [PalListLoc].Colour.Blue  = PalList [PalListLoc + SpritePalSize].Colour.Blue;
			PalList [PalListLoc].Colour.Green = PalList [PalListLoc + SpritePalSize].Colour.Green;
			PalList [PalListLoc].Colour.Red   = PalList [PalListLoc + SpritePalSize].Colour.Red;
		}
		for (SpritePalLoc = 0; SpritePalLoc < SpritePalSize; SpritePalLoc++, PalListLoc++)
		{
			PalList [PalListLoc].Colour.Blue  = SpritePal [SpritePalLoc].Blue;
			PalList [PalListLoc].Colour.Green = SpritePal [SpritePalLoc].Green;
			PalList [PalListLoc].Colour.Red   = SpritePal [SpritePalLoc].Red;
		}
	}

#if DEBUG==TRUE
	File = fopen ("Palette Count.bin", "wb");
	for (PalListLoc = 0; PalListLoc < PalListSize; PalListLoc++)
	{
		fputc (PalList [PalListLoc].Colour.Alpha, File);
		fputc (PalList [PalListLoc].Colour.Blue , File);
		fputc (PalList [PalListLoc].Colour.Green, File);
		fputc (PalList [PalListLoc].Colour.Red  , File);
		fputc (PalList [PalListLoc].Count >> 0x18, File);
		fputc (PalList [PalListLoc].Count >> 0x10, File);
		fputc (PalList [PalListLoc].Count >> 0x08, File);
		fputc (PalList [PalListLoc].Count >> 0x00, File);
		fputc (0x00, File);
		fputc (0x00, File);
		fputc (0x00, File);
		fputc (0x00, File);
		fputc (0x00, File);
		fputc (0x00, File);
		fputc (0x00, File);
		fputc (0x00, File);
	}
	fclose (File);
#endif

	// --- Reducing colours to fit in palette ---

	int CountSize = 0x01+0x0F+0x0F+0x0D;
	int CountShort = 0x01+0X0F+0x0F;
	if (ShadowOn == FALSE)
	{
		CountSize += 0x02; // Include the end two sprites colours (since shadow/highlight is off)
	}
	if (SpritesOn == FALSE)
	{
		CountSize = 0x01+0x0F+0x0F; // DO NOT INCLUDE SPRITE PALETTE LINE
	}
	if (PlaneCount == 1)
	{
		CountSize -= 0x0F; // Minus a palette line (only one plane)
		CountShort -= 0x0F;
	}


	if (CountSize > PalListSize)
	{
		CountSize = PalListSize;
	}
	if (CountShort > PalListSize)
	{
		CountShort = PalListSize;
	}

	bool DitherOdd = FALSE;

	int ShadowTileSize = (Image.SizeX / 8) * (Image.SizeY / 8);
	char ShadowTiles [ShadowTileSize] = { 0 };

	PIX_BGRA PalCol, DestCol;
	for (Count = 0; Count < Original.Size; Count++)
	{
		int BestType = 0;
		int BestLoc = 0;
		int BestDist = 0x7FFFFF;

		DestCol = GetColour (Image.Data [Count], ShadowOn, FALSE, ReturnShadow);
		DestCol.Alpha = ReturnShadow;

		// Check against normal (NOTICE...  Includes sprite palette line...)

		for (PalListLoc = 0; PalListLoc < CountSize; PalListLoc++)
		{
			int Blue  = PalList [PalListLoc].Colour.Blue  - DestCol.Blue;
			int Green = PalList [PalListLoc].Colour.Green - DestCol.Green;
			int Red   = PalList [PalListLoc].Colour.Red   - DestCol.Red;
			if (Blue  < 0) { Blue  = -Blue;  }
			if (Green < 0) { Green = -Green; }
			if (Red   < 0) { Red   = -Red;   }
			Blue += Green + Red;
			if (Blue < BestDist)
			{
				BestDist = Blue;
				BestLoc = PalListLoc;
			}
		}
		if (ShadowOn == TRUE)
		{
			// Check against shadow
			for (PalListLoc = 0; PalListLoc < CountShort; PalListLoc++)
			{
				PalCol = GetShadow (PalList [PalListLoc].Colour, SwapTiidoNO, SwapSHADOW);
				int Blue  = PalCol.Blue  - DestCol.Blue;
				int Green = PalCol.Green - DestCol.Green;
				int Red   = PalCol.Red   - DestCol.Red;
				if (Blue  < 0) { Blue  = -Blue;  }
				if (Green < 0) { Green = -Green; }
				if (Red   < 0) { Red   = -Red;   }
				Blue += Green + Red;
				if (Blue < BestDist)
				{
					BestType = -1;
					BestDist = Blue;
					BestLoc = PalListLoc;
				}
			}
			// Check against highlight (NOTICE...  TRANSPARENT IS NOT INCLUDED, CANNOT HIGHLIGHT)
			for (PalListLoc = 1; PalListLoc < CountShort; PalListLoc++)
			{
				PalCol = GetShadow (PalList [PalListLoc].Colour, SwapTiidoNO, SwapHILITE);
				int Blue  = PalCol.Blue  - DestCol.Blue;
				int Green = PalCol.Green - DestCol.Green;
				int Red   = PalCol.Red   - DestCol.Red;
				if (Blue  < 0) { Blue  = -Blue;  }
				if (Green < 0) { Green = -Green; }
				if (Red   < 0) { Red   = -Red;   }
				Blue += Green + Red;
				if (Blue < BestDist)
				{
					BestType = +1;
					BestDist = Blue;
					BestLoc = PalListLoc;
				}
			}
		}

		PIX_BGRA DistColour;
		if (DITHERTYPE == NULL || POSTDITHER == FALSE)
		{
			Image.Data [Count].Blue  = PalList [BestLoc].Colour.Blue;
			Image.Data [Count].Green = PalList [BestLoc].Colour.Green;
			Image.Data [Count].Red   = PalList [BestLoc].Colour.Red;
		}
		else
		{
			if (BestType == 0)
			{
				// For Normal

				DestCol = PalList [BestLoc].Colour;
			}
			else if (BestType == -1)
			{
				// For Shadow

				DestCol = GetShadow (PalList [BestLoc].Colour, SwapTiidoNO, SwapSHADOW);
			}
			else // Must be +1
			{
				// For Highlight

				DestCol = GetShadow (PalList [BestLoc].Colour, SwapTiidoNO, SwapHILITE);
			}

			DistColour.Blue  = Image.Data [Count].Blue  - DestCol.Blue;
			DistColour.Green = Image.Data [Count].Green - DestCol.Green;
			DistColour.Red   = Image.Data [Count].Red   - DestCol.Red;
			int PosX = Count % Image.SizeX;
			int PosY = Count / Image.SizeX;


			int *DitherList = DITHERTYPE;
			if (*DitherList < 0)
			{
				if (DitherOdd == FALSE)
				{
					int ModX = DitherList [0x01];
					int ModY = DitherList [0x02];
					int Max = ModX * ModY;
					int Threshold = DitherList [0x03 + (PosX % ModX) + ((PosY % ModY) * ModX)];
					OrderPixel (Image.Data [Count].Blue , DistColour.Blue , Threshold, Max);
					OrderPixel (Image.Data [Count].Green, DistColour.Green, Threshold, Max);
					OrderPixel (Image.Data [Count].Red  , DistColour.Red  , Threshold, Max);
					DitherOdd = TRUE;
					Count--;
					continue;
				}
				Image.Data [Count].Blue  = PalList [BestLoc].Colour.Blue;
				Image.Data [Count].Green = PalList [BestLoc].Colour.Green;
				Image.Data [Count].Red   = PalList [BestLoc].Colour.Red;
				DitherOdd = FALSE;
			}
			else
			{
				Image.Data [Count].Blue  = PalList [BestLoc].Colour.Blue;
				Image.Data [Count].Green = PalList [BestLoc].Colour.Green;
				Image.Data [Count].Red   = PalList [BestLoc].Colour.Red;
				while (*DitherList != 0)
				{
					SortNeighbour (&Image, &Image, PosX, PosY, ActualSizeX, ActualSizeY, DitherList [0x02], DitherList [0x03], DitherList [0x01], DitherList [0x00], DistColour, ShadowOn);
					DitherList = &DitherList [0x04];
				}
			}
		}

			// The Alpha will now hold the colour/palette and if it's shadowed/highlighted.
			// SHPP CCCC
			// S = Shadowed
			// H = Highlighted
			// P = Palette line
			// C = Colour
			// Conversion tables below will convert the best palette loc into the correct palette/colour ID
			// and the type into the correct shadow/highlight flag:




		if (PlaneCount == 1)
		{
			char Split [] = { 0x80, 0x00, 0x40 };
			char PalAdj [] = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
						 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F };
			Image.Data [Count].Alpha = Split [BestType + 1] | PalAdj [BestLoc];
		}
		else
		{
			char Split [] = { 0x80, 0x00, 0x40 };
			char PalAdj [] = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
						 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
						 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F };
			Image.Data [Count].Alpha = Split [BestType + 1] | PalAdj [BestLoc];
		}

		// Keeping track of which tiles have shadow
		if (BestType == -1 || (Image.Data [Count].Alpha & 0x7F) == 0)
		{
			int PosX = Count % Image.SizeX;
			int PosY = Count / Image.SizeX;
			ShadowTiles [(PosX / 8) + ((PosY / 8) * (Image.SizeX / 8))]++; // Increase shadow count;
		}

		// Doing the same for the preview image (but allowing shadow/highlight correct
		// colours to display)

		Preview.Data [Count].Blue = Image.Data [Count].Blue;
		Preview.Data [Count].Green = Image.Data [Count].Green;
		Preview.Data [Count].Red   = Image.Data [Count].Red;
		Preview.Data [Count].Alpha = BestType;
		if (BestType == -1)
		{
			PalCol = GetShadow (Image.Data [Count], SwapTiidoNO, SwapSHADOW);
			Preview.Data [Count].Blue  = PalCol.Blue;
			Preview.Data [Count].Green = PalCol.Green;
			Preview.Data [Count].Red   = PalCol.Red;
		}
		else if (BestType == +1)
		{
			PalCol = GetShadow (Image.Data [Count], SwapTiidoNO, SwapHILITE);
			Preview.Data [Count].Blue  = PalCol.Blue;
			Preview.Data [Count].Green = PalCol.Green;
			Preview.Data [Count].Red   = PalCol.Red;
		}
	}
#if DEBUG==TRUE
	File = fopen ("ShadowTiles.bin", "wb");
	for (Count = 0; Count < ShadowTileSize; Count++)
	{
		fputc (ShadowTiles [Count], File);
	}
	fclose (File);
#endif


	if (SCALEMD == TRUE)
	{
		int ActX, ActY;
		if (Width != 320 && (Height == 224 && HeightCounter == TRUE))
		{
			// Rescale Width to 320 size & Height to NTSC size
			ResizeImage (&Preview, 320, 240, PadColour, BH_STRETCH, TRUE, ActX, ActY, 0, 0);
		}
		else if (Width != 320) // Just width
		{
			// Rescale Width to 320 size
			ResizeImage (&Preview, 320, Preview.SizeY, PadColour, BH_STRETCH, TRUE, ActX, ActY, 0, 0);
		}
		else if (Height == 224 && HeightCounter == TRUE)
		{
			// Rescale Height to NTSC size
			ResizeImage (&Preview, 320, 240, PadColour, BH_STRETCH, TRUE, ActX, ActY, 0, 0);
		}
	}
	if (GetOnlyPreview == TRUE)
	{
		free (PalList); PalList = NULL;
		free (Image.Data); Image.Data = NULL;
		free (Original.Data); Original.Data = NULL;
		return (0x00);
	}

	strcpy (FileDump, "Preview.bmp");
	SaveBMP (&Preview, Directory, 24);
#if MUSEUM==FALSE
	free (Preview.Data); Preview.Data = NULL;
#endif

	// --- Creating proper palette system ---

	PalListMax = 0x10;
	if (PalListMax > PalListSize)
	{
		PalListMax = PalListSize;
	}

	int PalLoc;
	PIX_BGRA Palette [0x40] = { 0 };
	for (PalLoc = 0, PalListLoc = 0; PalListLoc < PalListMax; PalListLoc++, PalLoc++)
	{
		Palette [PalLoc].Blue  = PalList [PalListLoc].Colour.Blue;
		Palette [PalLoc].Green = PalList [PalListLoc].Colour.Green;
		Palette [PalLoc].Red   = PalList [PalListLoc].Colour.Red;
	}
	Palette [PalLoc].Blue  = 0x00;
	Palette [PalLoc].Green = 0x00;
	Palette [PalLoc].Red   = 0x00;
	PalListMax = 0x10+0x0F;
	if (PalListMax > PalListSize)
	{
		PalListMax = PalListSize;
	}
	if (PlaneCount == 2)
	{
		for (PalLoc++; PalListLoc < PalListMax; PalListLoc++, PalLoc++)
		{
			Palette [PalLoc].Blue  = PalList [PalListLoc].Colour.Blue;
			Palette [PalLoc].Green = PalList [PalListLoc].Colour.Green;
			Palette [PalLoc].Red   = PalList [PalListLoc].Colour.Red;
		}
	}

	PalLoc = 0x31;

#if DEBUG==TRUE
	File = fopen ("Palette.bin", "wb");
	for (PalLoc = 0; PalLoc < 0x40; PalLoc++)
	{
		fputc (Palette [PalLoc].Alpha, File);
		fputc (Palette [PalLoc].Blue , File);
		fputc (Palette [PalLoc].Green, File);
		fputc (Palette [PalLoc].Red  , File);
	}
	fclose (File);
#endif

	CountSize = 0x10+0x0F+0x0D;
	if (ShadowOn == FALSE)
	{
		CountSize += 0x02;
	}
	if (SpritesOn == FALSE)
	{
		CountSize = 0x10+0x0F;
	}
	if (PlaneCount == 0x01)
	{
		CountSize -= 0x0F;
	}

	if (CountSize > PalListSize)
	{
		CountSize = PalListSize;
	}

	for ( ; PalListLoc < CountSize /* 0x10+0x0F+0x0D */; PalListLoc++, PalLoc++)
	{
		Palette [PalLoc].Blue  = PalList [PalListLoc].Colour.Blue;
		Palette [PalLoc].Green = PalList [PalListLoc].Colour.Green;
		Palette [PalLoc].Red   = PalList [PalListLoc].Colour.Red;
	}
	free (PalList); PalList = NULL;

#if DEBUG==TRUE
	File = fopen ("Palette.bin", "wb");
	for (PalLoc = 0; PalLoc < 0x40; PalLoc++)
	{
		fputc (Palette [PalLoc].Alpha, File);
		fputc (Palette [PalLoc].Blue , File);
		fputc (Palette [PalLoc].Green, File);
		fputc (Palette [PalLoc].Red  , File);
	}
	fclose (File);
#endif

#if MUSEUM==FALSE
	strcpy (FileDump, "CRAM.bin");
	if ((File = fopen (Directory, "wb")) == NULL)
	{
		free (Image.Data); Image.Data = NULL;
		free (Original.Data); Original.Data = NULL;
		DisplayError ("cannot create palette file");
		return (ERR_FILE);
	}
	for (PalLoc = 0x00; PalLoc < 0x40; PalLoc++)
	{
		PalCol = GetShadow (Palette [PalLoc], SwapTiidoNO, SwapCRAM);
		fputc (PalCol.Blue, File);
		fputc ((PalCol.Green << 0x04) | PalCol.Red, File);
	}
	fclose (File);
#endif

	// --- Getting Art ---

	FlipImage (&Image); // Flip upside down due to Microsofts' obsession with bitmaps being rendered bottom to top...
	for (CountY = 0; CountY < ((Image.SizeY / 8) / 2); CountY++)
	{
		for (CountX = 0; CountX < (Image.SizeX / 8); CountX++)
		{
			int PosA = CountX + (CountY * (Image.SizeX / 8));
			int PosB = CountX + (((Image.SizeY / 8) - (CountY + 1)) * (Image.SizeX / 8));
			char Store = ShadowTiles [PosA];
			ShadowTiles [PosA] = ShadowTiles [PosB];
			ShadowTiles [PosB] = Store;
		}
	}

	LineAdvance = 0x80;
	if (Width == 256)
	{
		LineAdvance = 0x40;
	}

	int VR_HSCROLL = 0x0000;
	int VR_PLANE_A = 0xC000;
	int VR_PLANE_B = 0xE000;
	int VR_SPRITES = 0xF000;
	if (SpritesOn == FALSE)
	{
		VR_SPRITES = VR_HSCROLL;
	}
	if (PlaneCount == 0x01)
	{
		VR_PLANE_A = VR_PLANE_B;
	}

	SetVRAM (0x0000, 0x0000, VR_EMPTY);	// unmark all of VRAM
	SetVRAM (VR_HSCROLL, 0x0004, VR_TAKEN);	// mark H-scroll space as taken
	if (SpritesOn == TRUE)
	{
		SetVRAM (VR_SPRITES, 0x0280, VR_RESERVED);	// mark sprite table as reserved
	}
	if (Width == 256)
	{
		SetVRAM (VR_PLANE_A, ((Width / 8) * (Height / 8)) * 2, VR_RESERVED);
		if (PlaneCount == 0x02)
		{
			SetVRAM (VR_PLANE_B, ((Width / 8) * (Height / 8)) * 2, VR_RESERVED);
		}
	}
	else
	{
		for (Count = 0; Count < (Height / 8); Count++)
		{
			SetVRAM (VR_PLANE_A+(Count*0x80), (Width / 8) * 2, VR_RESERVED);
			if (PlaneCount == 0x02)
			{
				SetVRAM (VR_PLANE_B+(Count*0x80), (Width / 8) * 2, VR_RESERVED);
			}
		}
	}
	Overflow = 0;
	if (SpritesOn == TRUE)
	{
		printn ("    Rendering Sprites\n");
		if (ReadSprites (Image, VR_SPRITES, Overflow, ShadowTiles, ShadowOn) == FALSE)
		{
			return (ERR_VRAM);
		}
	}
	printn ("    Rendering Plane A\n");
	if (ReadPlane (Image, VR_PLANE_A, 0, Overflow, ShadowTiles) == FALSE)
	{
		return (ERR_VRAM);
	}
	if (PlaneCount == 0x02)
	{
		printn ("    Rendering Plane B\n");
		if (ReadPlane (Image, VR_PLANE_B, 1, Overflow, ShadowTiles) == FALSE)
		{
			return (ERR_VRAM);
		}
	}
	if (Overflow > 0x10000)
	{
		return (ERR_VRAM2);
	}
	free (Image.Data); Image.Data = NULL;
	free (Original.Data); Original.Data = NULL;

	u_char VDPREG [0x18];
	VDPREG [0x00] = 0b00000100;			// 00LH 01CD - Leftover SMS bar (0N|1Y) | H-Interrupt (0N|1Y) | H,V Counter (0N|1Y) | Disable video signal (0N|1Y)
	VDPREG [0x01] = 0b01010100;			// SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
	if (Height == 320)
	{
		VDPREG [0x01] = 0b01011100;		// SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
	}
	VDPREG [0x02] = ((VR_PLANE_A)>>0x0A)&0xFF;	// 00FE DCBA - Scroll Plane A Map Table VRam address
	VDPREG [0x03] = ((VR_PLANE_A)>>0x0A)&0xFF;	// 00FE DCB0 / 00FE DC00 (20 H-resol) - Window Plane A Map Table VRam address
	VDPREG [0x04] = ((VR_PLANE_B)>>0x0D)&0xFF;	// 0000 0FED - Scroll Plane B Map Table VRam address
	VDPREG [0x05] = ((VR_SPRITES)>>0x09)&0xFF;	// 0FED CBA9 / 0FED CBA0 (20 H-resol) - Sprite Plane Map Table VRam address
	VDPREG [0x06] = 0b00000000;			// 0000 0000 - Unknown/Unused Register
	VDPREG [0x07] = 0x00;				// 00PP CCCC - Backdrop Colour: Palette Line | Colour ID
	VDPREG [0x08] = 0b00000000;			// 0000 0000 - Unknown/Unused Register
	VDPREG [0x09] = 0b00000000;			// 0000 0000 - Unknown/Unused Register
	VDPREG [0x0A] = 0xDF;				// 7654 3210 - H-Interrupt Register
	VDPREG [0x0B] = 0b00000000;			// 0000 EVHH - External Interrupt (0N|1Y) | V-Scroll (0-Full|1-2Celled) | H-Scroll: (00-Full|10-Celled|11-Sliced)
	VDPREG [0x0C] = 0b00000000;			// APHE SNNB - H-resol (0N|1Y) | Pixel int (0N|1Y) | H-sync (0N|1Y) | Extern-pix (0N|1Y) | S/H (0N|1Y) | Interlace (00N|01Y|11-Split) | H-resol (0-20|1-28)
	if (ShadowOn == TRUE)
	{
		VDPREG [0x0C] = 0b00001000;		// APHE SNNB - H-resol (0N|1Y) | Pixel int (0N|1Y) | H-sync (0N|1Y) | Extern-pix (0N|1Y) | S/H (0N|1Y) | Interlace (00N|01Y|11-Split) | H-resol (0-20|1-28)
	}
	if (Width == 320)
	{
		VDPREG [0x0C] |= 0b10000001;		// APHE SNNB - H-resol (0N|1Y) | Pixel int (0N|1Y) | H-sync (0N|1Y) | Extern-pix (0N|1Y) | S/H (0N|1Y) | Interlace (00N|01Y|11-Split) | H-resol (0-20|1-28)
	}
	VDPREG [0x0D] = ((VR_HSCROLL)>>0x0A)&0xFF;	// 00FE DCBA - Horizontal Scroll Table VRam address
	VDPREG [0x0E] = 0b00000000;			// 0000 0000 - Unknown/Unused Register
	VDPREG [0x0F] = 0x02;				// 7654 3210 - Auto Increament
	VDPREG [0x10] = 0b00000000;			// 00VV 00HH - Plane Y Size (00-20|01-40|11-80) | Plane X size (00-20|01-40|11-80)

	if (Width == 320)
	{
		VDPREG [0x10] = 0b00000001;		// 00VV 00HH - Plane Y Size (00-20|01-40|11-80) | Plane X size (00-20|01-40|11-80)
	}
	VDPREG [0x11] = 0x00;				// 7654 3210 - Window Horizontal Position
	VDPREG [0x12] = 0x00;				// 7654 3210 - Window Vertical Position
	VDPREG [0x13] = 0x00;				// DMA registers (leave blank)
	VDPREG [0x14] = 0x00;				// ''
	VDPREG [0x15] = 0x00;				// ''
	VDPREG [0x16] = 0x00;				// ''
	VDPREG [0x17] = 0x00;				// ''

#if MUSEUM==FALSE
	strcpy (FileDump, "VRAM.bin");
	if ((File = fopen (Directory, "wb")) == NULL)
	{
		DisplayError ("cannot create VRAM file");
		return (ERR_FILE);
	}
	for (Count = 0; Count < 0x10000; Count++)
	{
		fputc (VRAM [Count], File);
	}
	fclose (File);
	strcpy (FileDump, "VDP.bin");
	if ((File = fopen (Directory, "wb")) == NULL)
	{
		DisplayError ("cannot create VDP register file");
		return (ERR_FILE);
	}
	for (Count = 0x00; Count < 0x12; Count++)
	{
		fputc (VDPREG [Count], File);
	}
	fclose (File);
#else
	VDPREG [0x01] = 0b01110100;			// SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
	if ((File = fopen ("..\\Shots - States\\_Icon Palette.bin", "rb")) == NULL)
	{
		DisplayError ("cannot open icon palette, try running \"StateShot.exe\" first");
		return (ERR_FILE);
	}
	IMG PalIcon;
	PalIcon.Data = (PIX_BGRA*) malloc (0x10 * 2 * sizeof (PIX_BGRA));
	if (PalIcon.Data == NULL)
	{
		fclose (File);
		DisplayError ("cannot allocate memory for icon palette");
		return (ERR_ALLOC);
	}
	PalIcon.SizeX = 0x10;
	PalIcon.SizeY = 0x02;
	for (Count = 0; Count < 0x10*2; Count++)
	{
		PalIcon.Data [Count].Blue = fgetc (File) << 4;
		PalIcon.Data [Count].Green = fgetc (File);
		PalIcon.Data [Count].Red = PalIcon.Data [Count].Green << 4;
		PalIcon.Data [Count].Green &= 0xE0;
	}
	fclose (File);

		ResizeImage (&Preview, 6 * 8, 4 * 8, PadColour, BH_STRETCH, TRUE, ActualSizeX, ActualSizeY, 0, 0);

#if ICONBOARDER==TRUE
	for (CountX = 0; CountX < Preview.SizeX; CountX++)
	{
		Preview.Data [CountX].Red  = 0;
		Preview.Data [CountX].Green = 0;
		Preview.Data [CountX].Blue  = 0;
		Preview.Data [CountX + ((Preview.SizeY - 1) * Preview.SizeX)].Red  = 0;
		Preview.Data [CountX + ((Preview.SizeY - 1) * Preview.SizeX)].Green = 0;
		Preview.Data [CountX + ((Preview.SizeY - 1) * Preview.SizeX)].Blue  = 0;
	}
	for (CountY = 1; CountY < Preview.SizeY - 1; CountY++)
	{
		Preview.Data [CountY * Preview.SizeX].Red  = 0;
		Preview.Data [CountY * Preview.SizeX].Green = 0;
		Preview.Data [CountY * Preview.SizeX].Blue  = 0;
		Preview.Data [(CountY * Preview.SizeX) + (Preview.SizeX - 1)].Red  = 0;
		Preview.Data [(CountY * Preview.SizeX) + (Preview.SizeX - 1)].Green = 0;
		Preview.Data [(CountY * Preview.SizeX) + (Preview.SizeX - 1)].Blue  = 0;
	}
#endif

		int PreviewLoc;
		for (PreviewLoc = 0; PreviewLoc < Preview.Size; PreviewLoc++)
		{
			short BestFused, BestLoc = 0;
			for (CountY = 0; CountY < PalIcon.SizeY; CountY++)
			{
				for (CountX = 1; CountX < PalIcon.SizeX; CountX++)
				{
					PalLoc = CountX + (CountY * PalIcon.SizeX);
					short Red = Preview.Data [PreviewLoc].Red - PalIcon.Data [PalLoc].Red;
					if (Red < 0)
					{
						Red = -Red;
					}
					short Green = Preview.Data [PreviewLoc].Green - PalIcon.Data [PalLoc].Green;
					if (Green < 0)
					{
						Green = -Green;
					}
					short Blue = Preview.Data [PreviewLoc].Blue - PalIcon.Data [PalLoc].Blue;
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
			Preview.Data [PreviewLoc].Red   = PalIcon.Data [BestLoc].Red;
			Preview.Data [PreviewLoc].Green = PalIcon.Data [BestLoc].Green;
			Preview.Data [PreviewLoc].Blue  = PalIcon.Data [BestLoc].Blue;
			Preview.Data [PreviewLoc].Alpha = BestLoc;
		}

		strcpy (FileDump, "Icon.bmp");
		SaveBMP (&Preview, Directory, 24);

		char *IconTiles = (char*) malloc ((((Preview.SizeX >> 3) * (Preview.SizeY >> 3)) * 0x20) * PalIcon.SizeY);
		if (IconTiles == NULL)
		{
			free (PalIcon.Data); PalIcon.Data = NULL;
			free (Preview.Data); Preview.Data = NULL;
			DisplayError ("cannot allocate memory for icon tiles");
			return (ERR_ALLOC);
		}
		int Line;
		int PixelCount = 0;
		int IconLoc, IconSize = 0;
		for (Line = 0; Line < PalIcon.SizeY; Line++)
		{
			for (CountX = 0; CountX < Preview.SizeX; CountX += 8)
			{
				for (CountY = Preview.SizeY - 1; CountY >= 0; CountY--)
				{
					int TileX;
					for (TileX = 0; TileX < 8; TileX++)
					{
						PreviewLoc = CountX + TileX + (CountY * Preview.SizeX);
						int Pixel = Preview.Data [PreviewLoc].Alpha;
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
		free (Preview.Data); Preview.Data = NULL;

		strcpy (FileDump, "Icon.twiz");
		if (PackData (IconTiles, IconSize, Directory) != 0)
		{
			free (IconTiles); IconTiles = NULL;
			DisplayError ("cannot create icon twizzler file");
			return (ERR_FILE);
		}

		free (IconTiles); IconTiles = NULL;



	strcpy (FileDump, "VRAMA.twiz");
	if (PackData (&VRAM [0x0000], 0x8000, Directory) != 0)
	{
		DisplayError ("cannot create VRAMA Twizzler file");
		return (ERR_FILE);
	}
	strcpy (FileDump, "VRAMB.twiz");
	if (PackData (&VRAM [0x8000], 0x8000, Directory) != 0)
	{
		DisplayError ("cannot create VRAMB Twizzler file");
		return (ERR_FILE);
	}

	char IRAM [0x80+0x50+0x18];
	for (Count = 0; Count < 0x80; Count += 0x02)
	{
		PalCol = GetShadow (Palette [Count / 2], SwapTiidoNO, SwapCRAM);
		IRAM [Count] = PalCol.Blue;
		IRAM [Count + 1] = (PalCol.Green << 0x04) | PalCol.Red;
	}
	for (Count = 0; Count < 0x50; Count++)
	{
		IRAM [Count+0x80] = 0x00;
	}
	for (Count = 0; Count < 0x18; Count++)
	{
		IRAM [Count+0x80+0x50] = VDPREG [Count];
	}
	strcpy (FileDump, "IRAM.twiz");
	if (PackData (&IRAM [0x0000], 0x80+0x50+0x18, Directory) != 0)
	{
		DisplayError ("cannot create IRAM Twizzler file");
		return (ERR_FILE);
	}
#endif
	return (0x00);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Rendering a rectangle normally
// -----------------------------------------------------------------------------

int GeneratePreview ( )

{
	int WidthList [] = { 320, 256, 256 };
	int HeightList [] = { 240, 224, 224 };
	bool SizeCounter [] = { FALSE, FALSE, TRUE }; // Whether or not the resizing should be countered
	int Overflow;
	return (ConvertImage (&Image, WidthList [WIDTHTYPE], HeightList [HEIGHTTYPE], SizeCounter [WIDTHTYPE], SizeCounter [HEIGHTTYPE], PLANETYPE, SPRITES, SPRITESH, COMMONART, Overflow, TRUE));
}

// =============================================================================
// -----------------------------------------------------------------------------
// Getting a number from an ASCII string
// -----------------------------------------------------------------------------

int GetNumber (char *String, int &StringLoc)

{
	int Value = 0;
	char Byte;
	StringLoc--;
	do
	{
		Byte = String [++StringLoc];
	}
	while (Byte == ' ');
	bool Neg = FALSE;
	if (Byte == '-')
	{
		Neg = TRUE;
	}
	if (Byte == '-' || Byte == '+')
	{
		Byte = String [++StringLoc];
	}
	if (Byte != 0x00)
	{
		Byte = W_NumberChars [Byte];
		while (Byte != ' ' && Byte != 0x00)
		{
			Value = (Value << 0x04) | (Byte - '0');
			Byte = W_NumberChars [String [++StringLoc]];
		}
	}
	Value = DecHex (Value);
	if (Neg == TRUE)
	{
		Value = -Value;
	}
	return (Value);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Enabling/Disabling settings in mass (for "Use best settings" checkbox)
// -----------------------------------------------------------------------------

void EnableSettings (HWND hwnd, bool SET)

{
	EnableWindow (GetDlgItem (hwnd, IDC_DS_PLANE1), SET);
	EnableWindow (GetDlgItem (hwnd, IDC_DS_PLANE2), SET);
	EnableWindow (GetDlgItem (hwnd, IDC_DS_WIDTH320), SET);
	EnableWindow (GetDlgItem (hwnd, IDC_DS_WIDTH256), SET);
	EnableWindow (GetDlgItem (hwnd, IDC_DS_WIDTH256C), SET);
	EnableWindow (GetDlgItem (hwnd, IDC_DS_HEIGHT240), SET);
	EnableWindow (GetDlgItem (hwnd, IDC_DS_HEIGHT224), SET);
	EnableWindow (GetDlgItem (hwnd, IDC_DS_HEIGHT224C), SET);
	EnableWindow (GetDlgItem (hwnd, IDC_DS_SPRITES), SET);
	if (SPRITES == TRUE)
	{
		EnableWindow (GetDlgItem (hwnd, IDC_DS_SPRITESH), SET);
	}
}

// =============================================================================
// -----------------------------------------------------------------------------
// Rendering a rectangle normally
// -----------------------------------------------------------------------------

void RectangleNormal (HDC hdc, RECT rect, COLORREF penCol, COLORREF brushCol)

{
	SelectObject(hdc, GetStockObject(DC_PEN));
	SetDCPenColor (hdc, penCol);
	SelectObject(hdc, GetStockObject(DC_BRUSH));
	SetDCBrushColor (hdc, brushCol);
	Rectangle (hdc, rect.left, rect.top, rect.right, rect.bottom);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Thread to generate a preview if necessary
// -----------------------------------------------------------------------------
bool DoGenerate = FALSE;
bool DoRefresh = FALSE;

DWORD WINAPI Thread_Generate (LPVOID lpParam)

{
	if (GeneratePreview ( ) != 0)
	{
		free (Preview.Data); Preview.Data == NULL;
	}

	int ActualSizeX, ActualSizeY;
	PIX_BGRA PadColour = { 0, 0, 0, 0 };
	FlipImage (&Preview);

	TruncateImage (&Preview, (Preview.SizeX - 320) / 2, (Preview.SizeY - 240) / 2, Preview.SizeX + ((320 - Preview.SizeX) / 2), Preview.SizeY + ((240 - Preview.SizeY) / 2), PadColour);
	ResizeImage (&Preview, Preview.SizeX * 2, Preview.SizeY * 2, PadColour, BH_FIT, FALSE, ActualSizeX, ActualSizeY, 0, 0);
	DoRefresh = TRUE;
	DoGenerate = FALSE;
	return (0x00);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Dialog box procedure
// -----------------------------------------------------------------------------

HBITMAP hbmCur = NULL;
HBITMAP hbmPrevStretch = NULL, hbmPrevFit = NULL, hbmPrevFill = NULL, hbmPrevCust = NULL, hbmPrevGenerate = NULL, hbmPrevError = NULL;
RECT PrevRect = { 220, 69, 0, 0 };
RECT MainRect = { 410, 16, 0, 0 };
HANDLE ThreadGenerate = NULL;
bool DoRegen = FALSE;

BOOL CALLBACK DialogSettings (HWND hwnd, UINT Message, WPARAM wParam, LPARAM lParam)

{
	PAINTSTRUCT ps;
	HDC hdc;
	RECT rect;
	HFONT hFont;
	HWND hwnd_ScaleList;

	if (DoRefresh == TRUE)
	{
		InvalidateRect (hwnd, &MainRect, TRUE);
		DoRefresh = FALSE;
	}
	if (DoRegen == TRUE)
	{
		if (DoGenerate == FALSE)
		{
			if (BESTSETTINGS == TRUE)
			{
				InvalidateRect (hwnd, &MainRect, TRUE);
				free (Preview.Data); Preview.Data = NULL;
			}
			else
			{
				if (Preview.Data == NULL)
				{
					InvalidateRect (hwnd, &MainRect, TRUE);
				}
				DoGenerate = TRUE;
				ThreadGenerate = CreateThread (NULL, 0x0000, Thread_Generate, NULL, 0, 0x00);
				if (Thread_Generate == NULL)
				{
					MessageBox (hwnd, "Could not create preview generating thread", "Error", MB_OK | MB_ICONEXCLAMATION);
				}
			}
			DoRegen = FALSE;
		}
	}


	switch (Message)
	{
		case WM_INITDIALOG:
		{
			NEWSETTINGS = TRUE;	// Just disabling the remember flag (instead of setting the checkbox)
						// The only reason why the dialogbox WOULD reload after being told not to, is if
						// the image failed to convert and new settings need to be applied, it is possible
						// the user will only want the settings different for that one image only, if
						// this flag is still on, they might not notice it's still on...

			hFont = CreateFont (16, 0, 0, 0, FW_NORMAL, FALSE, FALSE, FALSE, ANSI_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH, "Courier New");

			// --- The drop down list ---

			rect.left = 220;
			rect.top = 38;
			rect.right = 149;
			rect.bottom = 300;
			hwnd_ScaleList = CreateWindowEx (0, "COMBOBOX", NULL, CBS_DROPDOWNLIST | CBS_HASSTRINGS | WS_TABSTOP | WS_CHILD | WS_OVERLAPPED | WS_VISIBLE, rect.left, rect.top, rect.right, rect.bottom, hwnd, NULL, NULL, NULL);
			SendMessage (hwnd_ScaleList, WM_SETFONT, WPARAM(hFont), TRUE);
			SendMessage (hwnd_ScaleList, CB_ADDSTRING, 0, (LPARAM) "Stretch");
			SendMessage (hwnd_ScaleList, CB_ADDSTRING, 0, (LPARAM) "Fit");
			SendMessage (hwnd_ScaleList, CB_ADDSTRING, 0, (LPARAM) "Fill");
			SendMessage (hwnd_ScaleList, CB_ADDSTRING, 0, (LPARAM) "Custom");
			SendMessage (hwnd_ScaleList, CB_SETCURSEL, SCALETYPE, 0); // set combo box to correct entry

			// --- The scale preview image ---

			BITMAP bm;

			hbmPrevStretch = LoadBitmap (GetModuleHandle (NULL), MAKEINTRESOURCE (PREV_STRETCH));
			if (hbmPrevStretch == NULL)
			{
				MessageBox (hwnd, "Could not load preview icons", "Error", MB_OK | MB_ICONEXCLAMATION);
			}
			hbmPrevFit = LoadBitmap (GetModuleHandle (NULL), MAKEINTRESOURCE (PREV_FIT));
			if (hbmPrevFit == NULL)
			{
				MessageBox (hwnd, "Could not load preview icons", "Error", MB_OK | MB_ICONEXCLAMATION);
			}
			hbmPrevFill = LoadBitmap (GetModuleHandle (NULL), MAKEINTRESOURCE (PREV_FILL));
			if (hbmPrevFill == NULL)
			{
				MessageBox (hwnd, "Could not load preview icons", "Error", MB_OK | MB_ICONEXCLAMATION);
			}
			hbmPrevCust = LoadBitmap (GetModuleHandle (NULL), MAKEINTRESOURCE (PREV_CUST));
			if (hbmPrevCust == NULL)
			{
				MessageBox (hwnd, "Could not load preview icons", "Error", MB_OK | MB_ICONEXCLAMATION);
			}

			GetObject (hbmPrevStretch, sizeof (BITMAP), &bm);
			PrevRect.right = bm.bmWidth + PrevRect.left;
			PrevRect.bottom = bm.bmHeight + PrevRect.top;

			hbmPrevError = LoadBitmap (GetModuleHandle (NULL), MAKEINTRESOURCE (PREV_ERROR));
			if (hbmPrevError == NULL)
			{
				MessageBox (hwnd, "Could not load preview image", "Error", MB_OK | MB_ICONEXCLAMATION);
			}
			hbmPrevGenerate = LoadBitmap (GetModuleHandle (NULL), MAKEINTRESOURCE (PREV_GENERATE));
			if (hbmPrevGenerate == NULL)
			{
				MessageBox (hwnd, "Could not load preview image", "Error", MB_OK | MB_ICONEXCLAMATION);
			}

			GetObject (hbmPrevGenerate, sizeof (BITMAP), &bm);
			MainRect.right = bm.bmWidth + MainRect.left;
			MainRect.bottom = bm.bmHeight + MainRect.top;

			// --- Setting various checkboxes/radio buttons ---

			switch (PLANETYPE)
			{
				case PT_PLANE1:
				{
					CheckDlgButton (hwnd, IDC_DS_PLANE1, BST_CHECKED);
				}
				break;
				case PT_PLANE2:
				{
					CheckDlgButton (hwnd, IDC_DS_PLANE2, BST_CHECKED);
				}
				break;
			}
			switch (WIDTHTYPE)
			{
				case WT_320:
				{
					CheckDlgButton (hwnd, IDC_DS_WIDTH320, BST_CHECKED);
				}
				break;
				case WT_256:
				{
					CheckDlgButton (hwnd, IDC_DS_WIDTH256, BST_CHECKED);
				}
				break;
				case WT_256C:
				{
					CheckDlgButton (hwnd, IDC_DS_WIDTH256C, BST_CHECKED);
				}
				break;
			}
			switch (HEIGHTTYPE)
			{
				case HT_240:
				{
					CheckDlgButton (hwnd, IDC_DS_HEIGHT240, BST_CHECKED);
				}
				break;
				case HT_224:
				{
					CheckDlgButton (hwnd, IDC_DS_HEIGHT224, BST_CHECKED);
				}
				break;
				case HT_224C:
				{
					CheckDlgButton (hwnd, IDC_DS_HEIGHT224C, BST_CHECKED);
				}
				break;
			}
			if (SPRITES == FALSE)
			{
				EnableWindow (GetDlgItem (hwnd, IDC_DS_SPRITESH), FALSE);
			}
			else
			{
				CheckDlgButton (hwnd, IDC_DS_SPRITES, BST_CHECKED);
				if (SPRITESH == TRUE)
				{
					CheckDlgButton (hwnd, IDC_DS_SPRITESH, BST_CHECKED);
				}
			}
			if (MAINTAINASPECT == TRUE)
			{
				CheckDlgButton (hwnd, IDC_DS_ASPECT, BST_CHECKED);
			}
			if (SNAPTILE == TRUE)
			{
				CheckDlgButton (hwnd, IDC_DS_SNAPTILE, BST_CHECKED);
			}
			if (FORCESHADOW == TRUE)
			{
				EnableWindow (GetDlgItem (hwnd, IDC_DS_SPC), FALSE);
				CheckDlgButton (hwnd, IDC_DS_FORCESHADOW, BST_CHECKED);
			}
			if (COMMONART == CA_SPRITES)
			{
				CheckDlgButton (hwnd, IDC_DS_SPC, BST_CHECKED);
			}
			if (INTERPOLATION == TRUE)
			{
				CheckDlgButton (hwnd, IDC_DS_INTERPOLATE, BST_CHECKED);
			}
			if (SCALEMD == TRUE)
			{
				CheckDlgButton (hwnd, IDC_DS_SCALEMD, BST_CHECKED);
			}
			if (BESTSETTINGS == TRUE)
			{
				CheckDlgButton (hwnd, IDC_DS_BEST, BST_CHECKED);
				EnableSettings (hwnd, FALSE);
			}
			if (POSTDITHER == TRUE)
			{
				CheckDlgButton (hwnd, IDC_DS_DITHERPOST, BST_CHECKED);
			}
			if (DITHERTYPE == NULL)
			{
				EnableWindow (GetDlgItem (hwnd, IDC_DS_DITHERPOST), FALSE);
				CheckDlgButton (hwnd, IDC_DS_DITHERNONE, BST_CHECKED);
				CheckDlgButton (hwnd, IDC_DS_DITHERJJN, BST_UNCHECKED);
				CheckDlgButton (hwnd, IDC_DS_DITHERFLOYD, BST_UNCHECKED);
				CheckDlgButton (hwnd, IDC_DS_DITHERORDER, BST_UNCHECKED);
			}
			else if (DITHERTYPE == DithList_JJN)
			{
				CheckDlgButton (hwnd, IDC_DS_DITHERNONE, BST_UNCHECKED);
				CheckDlgButton (hwnd, IDC_DS_DITHERJJN, BST_CHECKED);
				CheckDlgButton (hwnd, IDC_DS_DITHERFLOYD, BST_UNCHECKED);
				CheckDlgButton (hwnd, IDC_DS_DITHERORDER, BST_UNCHECKED);
			}
			else if (DITHERTYPE == DithList_Floyd)
			{
				CheckDlgButton (hwnd, IDC_DS_DITHERNONE, BST_UNCHECKED);
				CheckDlgButton (hwnd, IDC_DS_DITHERJJN, BST_UNCHECKED);
				CheckDlgButton (hwnd, IDC_DS_DITHERFLOYD, BST_CHECKED);
				CheckDlgButton (hwnd, IDC_DS_DITHERORDER, BST_UNCHECKED);
			}
			else if (DITHERTYPE == DithList_Order)
			{
				CheckDlgButton (hwnd, IDC_DS_DITHERNONE, BST_UNCHECKED);
				CheckDlgButton (hwnd, IDC_DS_DITHERJJN, BST_UNCHECKED);
				CheckDlgButton (hwnd, IDC_DS_DITHERFLOYD, BST_UNCHECKED);
				CheckDlgButton (hwnd, IDC_DS_DITHERORDER, BST_CHECKED);
			}

			SendDlgItemMessage (hwnd, IDC_DS_SCALEX, TBM_SETRANGE, TRUE, MAKELONG (0, MAXSCALERANGE*2));
		//	SendDlgItemMessage (hwnd, IDC_DS_SCALEX, TBM_SETPAGESIZE, 0,  MAXSCALERANGE);
			SendDlgItemMessage (hwnd, IDC_DS_SCALEX, TBM_SETTICFREQ, 8, 0);
			SendDlgItemMessage (hwnd, IDC_DS_SCALEX, TBM_SETPOS, TRUE, ScaleX+MAXSCALERANGE);

			SendDlgItemMessage (hwnd, IDC_DS_SCALEY, TBM_SETRANGE, TRUE, MAKELONG (0, MAXSCALERANGE*2));
		//	SendDlgItemMessage (hwnd, IDC_DS_SCALEY, TBM_SETPAGESIZE, 0,  MAXSCALERANGE);
			SendDlgItemMessage (hwnd, IDC_DS_SCALEY, TBM_SETTICFREQ, 8, 0);
			SendDlgItemMessage (hwnd, IDC_DS_SCALEY, TBM_SETPOS, TRUE, ScaleY+MAXSCALERANGE);

			snprintf (TEXT, 0x1000, "%+3d", ScaleX);
			SetDlgItemText (hwnd, IDC_DS_WIDNUM, TEXT);
			snprintf (TEXT, 0x1000, "%+3d", ScaleY);
			SetDlgItemText (hwnd, IDC_DS_HEINUM, TEXT);

			int ShowType = SW_HIDE;
			bool EnableType = FALSE;
			bool DisableType = TRUE;
			if (SCALETYPE == ST_CUSTOM)
			{
				ShowType = SW_SHOW;
				EnableType = TRUE;
				DisableType = FALSE;
			}
			EnableWindow (GetDlgItem (hwnd, IDC_DS_SCALEX), EnableType);
			EnableWindow (GetDlgItem (hwnd, IDC_DS_SCALEY), EnableType);
			EnableWindow (GetDlgItem (hwnd, IDC_DS_ASPECT), EnableType);
			EnableWindow (GetDlgItem (hwnd, IDC_DS_SNAPTILE), DisableType);
			ShowWindow (GetDlgItem (hwnd, IDC_DS_SCALEX), ShowType);
			ShowWindow (GetDlgItem (hwnd, IDC_DS_SCALEY), ShowType);
			ShowWindow (GetDlgItem (hwnd, IDC_DS_WIDLOW), ShowType);
			ShowWindow (GetDlgItem (hwnd, IDC_DS_WIDNUM), ShowType);
			ShowWindow (GetDlgItem (hwnd, IDC_DS_WIDHIG), ShowType);
			ShowWindow (GetDlgItem (hwnd, IDC_DS_HEILOW), ShowType);
			ShowWindow (GetDlgItem (hwnd, IDC_DS_HEINUM), ShowType);
			ShowWindow (GetDlgItem (hwnd, IDC_DS_HEIHIG), ShowType);

			DoRegen = TRUE;
		}
		break;
		case WM_HSCROLL:
		{
			if (lParam != 0)
			{
				if (lParam == (LPARAM) GetDlgItem (hwnd, IDC_DS_SCALEX))
				{
					ScaleX = SendDlgItemMessage (hwnd, IDC_DS_SCALEX, TBM_GETPOS, 0, 0) - MAXSCALERANGE;
					snprintf (TEXT, 0x1000, "%+3d", ScaleX);
					SetDlgItemText (hwnd, IDC_DS_WIDNUM, TEXT);
					if (LOWORD(wParam) != TB_THUMBPOSITION && LOWORD(wParam) != TB_THUMBTRACK)
					{
						DoRegen = TRUE;
					}
				}
			}
		}
		break;
		case WM_VSCROLL:
		{
			if (lParam != 0)
			{
				if (lParam == (LPARAM) GetDlgItem (hwnd, IDC_DS_SCALEY))
				{
					ScaleY = SendDlgItemMessage (hwnd, IDC_DS_SCALEY, TBM_GETPOS, 0, 0) - MAXSCALERANGE;
					snprintf (TEXT, 0x1000, "%+3d", ScaleY);
					SetDlgItemText (hwnd, IDC_DS_HEINUM, TEXT);
					if (LOWORD(wParam) != TB_THUMBPOSITION && LOWORD(wParam) != TB_THUMBTRACK)
					{
						DoRegen = TRUE;
					}
				}
			}
		}
		break;
		case WM_COMMAND:
		{
			if (HIWORD(wParam) == CBN_SELCHANGE)
			{
				SCALETYPE = SendMessage((HWND) lParam, (UINT) CB_GETCURSEL, (WPARAM) 0, (LPARAM) 0);
				int ShowType = SW_HIDE;
				bool EnableType = FALSE;
				bool DisableType = TRUE;
				if (SCALETYPE == ST_CUSTOM)
				{
					ShowType = SW_SHOW;
					EnableType = TRUE;
					DisableType = FALSE;
				}
				EnableWindow (GetDlgItem (hwnd, IDC_DS_SCALEX), EnableType);
				EnableWindow (GetDlgItem (hwnd, IDC_DS_SCALEY), EnableType);
				EnableWindow (GetDlgItem (hwnd, IDC_DS_ASPECT), EnableType);
				EnableWindow (GetDlgItem (hwnd, IDC_DS_SNAPTILE), DisableType);
				ShowWindow (GetDlgItem (hwnd, IDC_DS_SCALEX), ShowType);
				ShowWindow (GetDlgItem (hwnd, IDC_DS_SCALEY), ShowType);
				ShowWindow (GetDlgItem (hwnd, IDC_DS_WIDLOW), ShowType);
				ShowWindow (GetDlgItem (hwnd, IDC_DS_WIDNUM), ShowType);
				ShowWindow (GetDlgItem (hwnd, IDC_DS_WIDHIG), ShowType);
				ShowWindow (GetDlgItem (hwnd, IDC_DS_HEILOW), ShowType);
				ShowWindow (GetDlgItem (hwnd, IDC_DS_HEINUM), ShowType);
				ShowWindow (GetDlgItem (hwnd, IDC_DS_HEIHIG), ShowType);
				InvalidateRect (hwnd, &PrevRect, TRUE);
				DoRegen = TRUE;
			}
			if (LOWORD (wParam) == IDC_DS_BEST)
			{
				bool SET = TRUE;
				BESTSETTINGS = FALSE;
				if (IsDlgButtonChecked (hwnd, IDC_DS_BEST) == BST_CHECKED)
				{
					SET = FALSE;
					BESTSETTINGS = TRUE;
				}
				EnableSettings (hwnd, SET);
				DoRegen = TRUE;
			}
			if (LOWORD (wParam) == IDC_DS_INTERPOLATE)
			{
				INTERPOLATION = FALSE;
				if (IsDlgButtonChecked (hwnd, IDC_DS_INTERPOLATE) == BST_CHECKED)
				{
					INTERPOLATION = TRUE;
				}
				DoRegen = TRUE;
			}
			if (LOWORD (wParam) == IDC_DS_SCALEMD)
			{
				SCALEMD = FALSE;
				if (IsDlgButtonChecked (hwnd, IDC_DS_SCALEMD) == BST_CHECKED)
				{
					SCALEMD = TRUE;
				}
				DoRegen = TRUE;
			}
			if (LOWORD (wParam) == IDC_DS_FORCESHADOW)
			{
				FORCESHADOW = FALSE;
				if (IsDlgButtonChecked (hwnd, IDC_DS_FORCESHADOW) == BST_CHECKED)
				{
					FORCESHADOW = TRUE;
				}
				EnableWindow (GetDlgItem (hwnd, IDC_DS_SPC), (FORCESHADOW & 1) ^ 1);
				DoRegen = TRUE;
			}
			if (LOWORD (wParam) == IDC_DS_ASPECT)
			{
				MAINTAINASPECT = FALSE;
				if (IsDlgButtonChecked (hwnd, IDC_DS_ASPECT) == BST_CHECKED)
				{
					MainX = ScaleX;
					MainY = ScaleY;
					MAINTAINASPECT = TRUE;
				}
				else
				{
					DoRegen = TRUE; // Only regenerate if it's being turned off (might as well...)
				}
			}
			if (LOWORD (wParam) == IDC_DS_SNAPTILE)
			{
				SNAPTILE = FALSE;
				if (IsDlgButtonChecked (hwnd, IDC_DS_SNAPTILE) == BST_CHECKED)
				{
					SNAPTILE = TRUE;
				}
				DoRegen = TRUE;
			}
			if (LOWORD (wParam) == IDC_DS_SPC)
			{
				COMMONART = CA_PLANES;
				if (IsDlgButtonChecked (hwnd, IDC_DS_SPC) == BST_CHECKED)
				{
					COMMONART = CA_SPRITES;
				}
				DoRegen = TRUE;
			}
			if (	LOWORD (wParam) == IDC_DS_PLANE1 ||
				LOWORD (wParam) == IDC_DS_PLANE2 )
			{
				switch (LOWORD (wParam))
				{
					case IDC_DS_PLANE1:
					{
						PLANETYPE = PT_PLANE1;
						CheckDlgButton (hwnd, IDC_DS_PLANE1, BST_CHECKED);
						CheckDlgButton (hwnd, IDC_DS_PLANE2, BST_UNCHECKED);
					}
					break;
					case IDC_DS_PLANE2:
					{
						PLANETYPE = PT_PLANE2;
						CheckDlgButton (hwnd, IDC_DS_PLANE1, BST_UNCHECKED);
						CheckDlgButton (hwnd, IDC_DS_PLANE2, BST_CHECKED);
					}
					break;
				}
				DoRegen = TRUE;
			}
			if (	LOWORD (wParam) == IDC_DS_WIDTH320 ||
				LOWORD (wParam) == IDC_DS_WIDTH256 ||
				LOWORD (wParam) == IDC_DS_WIDTH256C )
			{
				switch (LOWORD (wParam))
				{
					case IDC_DS_WIDTH320:
					{
						WIDTHTYPE = WT_320;
						CheckDlgButton (hwnd, IDC_DS_WIDTH320, BST_CHECKED);
						CheckDlgButton (hwnd, IDC_DS_WIDTH256, BST_UNCHECKED);
						CheckDlgButton (hwnd, IDC_DS_WIDTH256C, BST_UNCHECKED);
					}
					break;
					case IDC_DS_WIDTH256:
					{
						WIDTHTYPE = WT_256;
						CheckDlgButton (hwnd, IDC_DS_WIDTH320, BST_UNCHECKED);
						CheckDlgButton (hwnd, IDC_DS_WIDTH256, BST_CHECKED);
						CheckDlgButton (hwnd, IDC_DS_WIDTH256C, BST_UNCHECKED);
					}
					break;
					case IDC_DS_WIDTH256C:
					{
						WIDTHTYPE = WT_256C;
						CheckDlgButton (hwnd, IDC_DS_WIDTH320, BST_UNCHECKED);
						CheckDlgButton (hwnd, IDC_DS_WIDTH256, BST_UNCHECKED);
						CheckDlgButton (hwnd, IDC_DS_WIDTH256C, BST_CHECKED);
					}
					break;
				}
				DoRegen = TRUE;
			}
			if (	LOWORD (wParam) == IDC_DS_HEIGHT240 ||
				LOWORD (wParam) == IDC_DS_HEIGHT224 ||
				LOWORD (wParam) == IDC_DS_HEIGHT224C )
			{
				switch (LOWORD (wParam))
				{
					case IDC_DS_HEIGHT240:
					{
						HEIGHTTYPE = HT_240;
						CheckDlgButton (hwnd, IDC_DS_HEIGHT240, BST_CHECKED);
						CheckDlgButton (hwnd, IDC_DS_HEIGHT224, BST_UNCHECKED);
						CheckDlgButton (hwnd, IDC_DS_HEIGHT224C, BST_UNCHECKED);
					}
					break;
					case IDC_DS_HEIGHT224:
					{
						HEIGHTTYPE = HT_224;
						CheckDlgButton (hwnd, IDC_DS_HEIGHT240, BST_UNCHECKED);
						CheckDlgButton (hwnd, IDC_DS_HEIGHT224, BST_CHECKED);
						CheckDlgButton (hwnd, IDC_DS_HEIGHT224C, BST_UNCHECKED);
					}
					break;
					case IDC_DS_HEIGHT224C:
					{
						HEIGHTTYPE = HT_224C;
						CheckDlgButton (hwnd, IDC_DS_HEIGHT240, BST_UNCHECKED);
						CheckDlgButton (hwnd, IDC_DS_HEIGHT224, BST_UNCHECKED);
						CheckDlgButton (hwnd, IDC_DS_HEIGHT224C, BST_CHECKED);
					}
					break;
				}
				DoRegen = TRUE;
			}

			if (LOWORD (wParam) == IDC_DS_DITHERPOST)
			{
				POSTDITHER = FALSE;
				if (IsDlgButtonChecked (hwnd, IDC_DS_DITHERPOST) == BST_CHECKED)
				{
					POSTDITHER = TRUE;
				}
				DoRegen = TRUE;
			}
			if (	LOWORD (wParam) == IDC_DS_DITHERNONE ||
				LOWORD (wParam) == IDC_DS_DITHERJJN ||
				LOWORD (wParam) == IDC_DS_DITHERFLOYD ||
				LOWORD (wParam) == IDC_DS_DITHERORDER )
			{
				switch (LOWORD (wParam))
				{
					case IDC_DS_DITHERNONE:
					{
						DITHERTYPE = NULL;
						EnableWindow (GetDlgItem (hwnd, IDC_DS_DITHERPOST), FALSE);
						CheckDlgButton (hwnd, IDC_DS_DITHERNONE, BST_CHECKED);
						CheckDlgButton (hwnd, IDC_DS_DITHERJJN, BST_UNCHECKED);
						CheckDlgButton (hwnd, IDC_DS_DITHERFLOYD, BST_UNCHECKED);
						CheckDlgButton (hwnd, IDC_DS_DITHERORDER, BST_UNCHECKED);
					}
					break;
					case IDC_DS_DITHERJJN:
					{
						DITHERTYPE = DithList_JJN;
						EnableWindow (GetDlgItem (hwnd, IDC_DS_DITHERPOST), TRUE);
						CheckDlgButton (hwnd, IDC_DS_DITHERNONE, BST_UNCHECKED);
						CheckDlgButton (hwnd, IDC_DS_DITHERJJN, BST_CHECKED);
						CheckDlgButton (hwnd, IDC_DS_DITHERFLOYD, BST_UNCHECKED);
						CheckDlgButton (hwnd, IDC_DS_DITHERORDER, BST_UNCHECKED);
					}
					break;
					case IDC_DS_DITHERFLOYD:
					{
						DITHERTYPE = DithList_Floyd;
						EnableWindow (GetDlgItem (hwnd, IDC_DS_DITHERPOST), TRUE);
						CheckDlgButton (hwnd, IDC_DS_DITHERNONE, BST_UNCHECKED);
						CheckDlgButton (hwnd, IDC_DS_DITHERJJN, BST_UNCHECKED);
						CheckDlgButton (hwnd, IDC_DS_DITHERFLOYD, BST_CHECKED);
						CheckDlgButton (hwnd, IDC_DS_DITHERORDER, BST_UNCHECKED);
					}
					break;
					case IDC_DS_DITHERORDER:
					{
						DITHERTYPE = DithList_Order;
						EnableWindow (GetDlgItem (hwnd, IDC_DS_DITHERPOST), TRUE);
						CheckDlgButton (hwnd, IDC_DS_DITHERNONE, BST_UNCHECKED);
						CheckDlgButton (hwnd, IDC_DS_DITHERJJN, BST_UNCHECKED);
						CheckDlgButton (hwnd, IDC_DS_DITHERFLOYD, BST_UNCHECKED);
						CheckDlgButton (hwnd, IDC_DS_DITHERORDER, BST_CHECKED);
					}
					break;
				}
				DoRegen = TRUE;
			}
			else if (LOWORD (wParam) == IDC_DS_SPRITES)
			{
				SPRITES = FALSE;
				if (IsDlgButtonChecked (hwnd, IDC_DS_SPRITES) == BST_CHECKED)
				{
					SPRITES = TRUE;
				}
				EnableWindow (GetDlgItem (hwnd, IDC_DS_SPRITESH), SPRITES);
				DoRegen = TRUE;
			}
			else if (LOWORD (wParam) == IDC_DS_SPRITESH)
			{
				SPRITESH = FALSE;
				if (IsDlgButtonChecked (hwnd, IDC_DS_SPRITESH) == BST_CHECKED)
				{
					SPRITESH = TRUE;
				}
				DoRegen = TRUE;
			}
			else if (LOWORD (wParam) == IDC_DS_APPLY)
			{
				NEWSETTINGS = TRUE;
				if (IsDlgButtonChecked (hwnd, IDC_DS_APPLY) == BST_CHECKED)
				{
					NEWSETTINGS = FALSE;
				}
			}
			else if (LOWORD (wParam) == IDC_DS_OK)
			{
				EndDialog (hwnd, 0);
			}
			else if (LOWORD (wParam) == IDC_DS_EXIT)
			{
				QUITPROGRAM = TRUE;
				EndDialog (hwnd, 0);
			}
		}
		break;
		case WM_PAINT:
		{
			hdc = BeginPaint (hwnd, &ps);

			switch (SCALETYPE)
			{
				case ST_STRETCH: { hbmCur = hbmPrevStretch; } break;
				case ST_FIT:	 { hbmCur = hbmPrevFit; } break;
				case ST_FILL:	 { hbmCur = hbmPrevFill; } break;
				case ST_CUSTOM:  { hbmCur = hbmPrevCust; } break;
			}

			HDC hdc_Preview = CreateCompatibleDC (hdc);
			HBITMAP hbmOld = (HBITMAP) SelectObject (hdc_Preview, hbmCur);

			rect.left = PrevRect.left - 1;
			rect.right = PrevRect.right + 1;
			rect.top = PrevRect.top - 1;
			rect.bottom = PrevRect.bottom + 1;
			RectangleNormal (hdc, rect, RGB (0, 0, 0), RGB (255, 255, 255));

			BitBlt (hdc, PrevRect.left, PrevRect.top, PrevRect.right, PrevRect.bottom, hdc_Preview, 0, 0, SRCCOPY);

			SelectObject (hdc_Preview, hbmOld);
			DeleteDC (hdc_Preview);

			if (Preview.Data == NULL && DoGenerate == FALSE)
			{
				hbmCur = hbmPrevError;
			}
			else if (DoGenerate == TRUE)
			{
				hbmCur = hbmPrevGenerate;
			}
			else
			{
				hbmCur = CreateBitmap (Preview.SizeX, Preview.SizeY, 0x01, 32, Preview.Data);
			/*	HBITMAP memBM = CreateCompatibleBitmap (hdc_Preview, Preview.SizeX, Preview.SizeY);
				SelectObject (hdc_Preview, memBM);
				SetDIBits (hdc_Preview, memBM, 0, 320, ?, ?, 
				*/
			}
			hdc_Preview = CreateCompatibleDC (hdc);
			hbmOld = (HBITMAP) SelectObject (hdc_Preview, hbmCur);

			rect.left = MainRect.left - 1;
			rect.right = MainRect.right + 1;
			rect.top = MainRect.top - 1;
			rect.bottom = MainRect.bottom + 1;
			RectangleNormal (hdc, rect, RGB (0, 0, 0), RGB (0, 0, 0));

			BitBlt (hdc, MainRect.left, MainRect.top, MainRect.right, MainRect.bottom, hdc_Preview, 0, 0, SRCCOPY);

			SelectObject (hdc_Preview, hbmOld);
			DeleteDC (hdc_Preview);

			if (Preview.Data != NULL && DoGenerate == FALSE)
			{
				DeleteObject (hbmCur);
			}

			EndPaint (hwnd, &ps);
		}
		break;
		case WM_DESTROY:
		{
			if (ThreadGenerate != NULL)
			{
				WaitForSingleObject (ThreadGenerate, INFINITE);
				CloseHandle (ThreadGenerate);
				ThreadGenerate = NULL;
			}
			DoRegen = FALSE;
			DeleteObject (hbmPrevStretch);
			DeleteObject (hbmPrevFit);
			DeleteObject (hbmPrevFill);
			DeleteObject (hbmPrevCust);
			DeleteObject (hbmPrevError);
			DeleteObject (hbmPrevGenerate);
			free (Preview.Data); Preview.Data = NULL;
		}
		break;
		default:
		{
			return FALSE;
		}
	}
	return TRUE;
}

// =============================================================================
// -----------------------------------------------------------------------------
// Processing a filename
// -----------------------------------------------------------------------------

void ProcessFile ( )

{
	printn ("\n -> %s\n", FileName);

	int RetVal = ImageLoad (&Image, Directory);
	if (RetVal != 0)
	{
		if (RetVal == 0x06)
		{
			DisplayError ("bitmap is compression, open with paint and save again");
			return; // SORTOUT
		}
		DisplayError ("the file cannot be opened or is not an acceptable bitmap format");
		return; // SORTOUT
	}
	Folder = FileName;
	FileDump = ExtName;
	*FileDump++ = '\\';
	*FileDump = 0x00;
	mkdir (Directory);

	int BestCount = 0;
	bool ReloadDialog = FALSE;
	for ( ; ; )
	{
		GenerateTable (SwapTiidoSH, FlagTiidoSH, SwapListSH, FlagListSH);
		GenerateTable (SwapTiidoNO, FlagTiidoNO, SwapListNO, FlagListNO);
		bool Retry = FALSE;
		if (GUIMODE != GM_CONSOLE && (NEWSETTINGS == TRUE || ReloadDialog == TRUE) && BestCount == 0)
		{
			DialogBox (NULL, MAKEINTRESOURCE (IDC_DIASETTINGS), NULL, (DLGPROC) DialogSettings);
			if (QUITPROGRAM == TRUE)
			{
				break;
			}
		}

		int WidthList [] = { 320, 256, 256 };
		int HeightList [] = { 240, 224, 224 };
		bool SizeCounter [] = { FALSE, FALSE, TRUE }; // Whether or not the resizing should be countered
		int Overflow;
		if (BESTSETTINGS == FALSE)
		{
			switch (ConvertImage (&Image, WidthList [WIDTHTYPE], HeightList [HEIGHTTYPE], SizeCounter [WIDTHTYPE], SizeCounter [HEIGHTTYPE], PLANETYPE, SPRITES, SPRITESH, COMMONART, Overflow, FALSE))
			{
				case ERR_ALLOC:
				{
					// yeah... not much I can do...
				}
				break;
				case ERR_FILE:
				{
					// again... not much I can do...
				}
				break;
				case ERR_VRAM2:
				case ERR_VRAM:
				{
					if (GUIMODE == GM_CONSOLE)
					{
						DisplayError ("ran out of VRAM space (0x%X Used out of 0x10000)", Overflow);
					}
				/*	else if (GUIMODE == GM_DRAG)
					{
						printf ("    Error; ran out of VRAM space (0x%X Used out of 0x10000)\n    retry with different settings? (Y/N)  ", Overflow);;
						fflush (stdin);
						if (W_ModesChars [getchar ( )] == 'Y')
						{
							Retry = TRUE;
							ReloadDialog = TRUE;
						}
					}	*/
					else
					{
						snprintf (TEXT, 0x1000, "Ran out of VRAM space (0x%X Used out of 0x10000), retry with different settings?", Overflow);
						int RetVal = MessageBox (NULL, TEXT, "Error", MB_YESNOCANCEL | MB_ICONEXCLAMATION);
						if (RetVal == IDYES)
						{
							Retry = TRUE;
							ReloadDialog = TRUE;
						}
						else if (RetVal == IDCANCEL)
						{
							QUITPROGRAM = TRUE;
						}
					}
				}
				break;
				case ERR_UNKNOWN:
				{
					DisplayError ("UNKNOWN ERROR - ERR_UNKNOWN");
				}
				break;
			}
			if (Retry == FALSE)
			{
				break;
			}
		}
		else
		{
						//	PLANETYPE,	WIDTHTYPE,	HEIGHTTYPE,	SPRITES,	SPRITESH
			int BestList [] [5] = {	{	PT_PLANE2,	WT_320,		HT_224,		TRUE,		TRUE	},
						{	PT_PLANE2,	WT_256,		HT_224,		TRUE,		TRUE	},
						{	PT_PLANE2,	WT_256C,	HT_224,		TRUE,		TRUE	},
						{	PT_PLANE1,	WT_320,		HT_224,		TRUE,		TRUE	},
						{	PT_PLANE1,	WT_256,		HT_224,		TRUE,		TRUE	},
						{	PT_PLANE1,	WT_256C,	HT_224,		TRUE,		TRUE	},
						{	PT_PLANE2,	WT_320,		HT_224,		FALSE,		FALSE	},
						{	PT_PLANE2,	WT_256,		HT_224,		FALSE,		FALSE	},
						{	PT_PLANE2,	WT_256C,	HT_224,		FALSE,		FALSE	},
						{	PT_PLANE1,	WT_320,		HT_224,		TRUE,		FALSE	},
						{	PT_PLANE1,	WT_256,		HT_224,		TRUE,		FALSE	},
						{	PT_PLANE1,	WT_256C,	HT_224,		TRUE,		FALSE	},
						{	PT_PLANE1,	WT_320,		HT_224,		FALSE,		FALSE	}, // This one should be VRAM size compatible (enough tiles for a single plane)
						{	PT_PLANE1,	WT_256,		HT_224,		FALSE,		FALSE	}, // ...but just in-case
						{	PT_PLANE1,	WT_256C,	HT_224,		FALSE,		FALSE	},
						{	0,		0,		0,		0,		0	} };

			PLANETYPE =	BestList [BestCount] [0];
			WIDTHTYPE =	BestList [BestCount] [1];
			HEIGHTTYPE =	BestList [BestCount] [2];
			SPRITES =	BestList [BestCount] [3];
			SPRITESH =	BestList [BestCount] [4];
		//	INTERPOLATION =	BestList [BestCount] [5];
		//	SCALETYPE =	BestList [BestCount] [6];

			switch (ConvertImage (&Image, WidthList [WIDTHTYPE], HeightList [HEIGHTTYPE], SizeCounter [WIDTHTYPE], SizeCounter [HEIGHTTYPE], PLANETYPE, SPRITES, SPRITESH, COMMONART, Overflow, FALSE))
			{
				case ERR_ALLOC:
				{
					// yeah... not much I can do...
				}
				break;
				case ERR_FILE:
				{
					// again... not much I can do...
				}
				break;
				case ERR_VRAM2:
				case ERR_VRAM:
				{
					printn ("    Out of VRAM space (0x%X Used out of 0x10000)", Overflow);
					if (BestList [BestCount + 1] [0] != 0)
					{
						printn (", trying next method");
						Retry = TRUE;
					}
					printn ("\n\n");
				}
				break;
				case ERR_UNKNOWN:
				{
					DisplayError ("UNKNOWN ERROR - ERR_UNKNOWN");
				}
				break;
			}
			BestCount++;
			if (BestList [BestCount] [0] == 0)
			{
				// End of list

				if (GUIMODE == GM_CONSOLE)
				{
					DisplayError ("the image cannot be converted (all methods tried)");
					BestCount = 0;
				}
				else if (GUIMODE == GM_DRAG)
				{
					printf ("    Error; the image cannot be converted (all methods tried)\n    Try a different scaling method maybe, or perhaps turn interpolation off\n    Retry with different settings? (Y/N)  ");
					fflush (stdin);
					if (W_ModesChars [getchar ( )] == 'Y')
					{
						Retry = TRUE;
						ReloadDialog = TRUE;
						BestCount = 0;
					}
				}
				else
				{
					if (MessageBox (NULL, "The image cannot be converted (all methods tried).\nTry a different scaling method maybe, or perhaps turn interpolation off\n\nRetry with different settings?", "Error", MB_YESNO | MB_ICONEXCLAMATION) == IDYES)
					{
						Retry = TRUE;
						ReloadDialog = TRUE;
						BestCount = 0;
					}
				}
			}
			if (Retry == FALSE)
			{
				break;
			}
		}
	}
	free (Image.Data); Image.Data = NULL;
	free (Preview.Data); Preview.Data = NULL;
}

// =============================================================================
// -----------------------------------------------------------------------------
// Main entry point
// -----------------------------------------------------------------------------

int main (int ArgNumber, char **ArgList, char **EnvList)

{

	Image.Data = NULL;
	Preview.Data = NULL;

	GUIMODE = GM_CONSOLE;
	if (ArgNumber <= 0x01)
	{
		GUIMODE = GM_WINDOW;
		printn ("Bitmap MD - by MarkeyJester\n");
		ZeroMemory (&ofn, sizeof (ofn));
		ofn.lStructSize		= sizeof (OPENFILENAME);								// size of structure
		ofn.hwndOwner		= NULL;											// window handler
		ofn.lpstrFile		= OpenFileList;										// filename buffer pointer
		ofn.lpstrTitle		= "Select bitmap files to convert";							// title of window
		ofn.lpstrFilter		= "Bitmap Files (*.bmp)\0*.bmp\0All Files (*.*)\0*.*\0";				// types
		ofn.lpstrDefExt		= "bmp";										// default type
		ofn.nMaxFile		= DEF_OFL_SIZE;									// size of filename buffer
		ofn.Flags		= OFN_NODEREFERENCELINKS | OFN_NOCHANGEDIR | OFN_EXPLORER | OFN_OVERWRITEPROMPT | OFN_FILEMUSTEXIST | OFN_HIDEREADONLY | OFN_ALLOWMULTISELECT;
		*OpenFileList = 0x00;
		GetOpenFileName (&ofn);
		if (*OpenFileList != 0x00)
		{
			bool FoundDir = TRUE;
			char Byte;
			int OpenFileLoc = 0;
			for (DirectLoc = 0; OpenFileList [DirectLoc] != 0x00; DirectLoc++)
			{
				Byte = OpenFileList [DirectLoc];
				Directory [DirectLoc] = Byte;
				if (Byte == '\\' || Byte == '/')
				{
					FileName = &Directory [DirectLoc + 1];
					OpenFileLoc = DirectLoc + 1;
				}
				if (Byte == '.')
				{
					ExtName = &Directory [DirectLoc];
					FoundDir = FALSE;
				}
			}
			if (FoundDir == TRUE)
			{
				Directory [DirectLoc++] = '\\';
				FileName = &Directory [DirectLoc];
				OpenFileLoc = DirectLoc;
			}
			while (OpenFileList [OpenFileLoc] != 0x00)
			{
				OpenFileLoc += snprintf (FileName, 0x1000, "%s", &OpenFileList [OpenFileLoc]) + 1;
				int FileNameLoc = -1;
				do
				{
					Byte = FileName [++FileNameLoc];
				}
				while (Byte != '.' && Byte != 0x00);
				ExtName = &FileName [FileNameLoc];
				ProcessFile ( );
				if (QUITPROGRAM == TRUE)
				{
					break;
				}
			}
			if (QUITPROGRAM == FALSE)
			{
				MessageBox (NULL, "Conversion complete, click OK to close:", "Bitmap MD", MB_OK);
			}
		}
		return (0x00);
	}
	int ArgCount = 0x02;
	if (strcmp (ArgList [1], "-") != 0)
	{
		ArgCount = 0x01;
		GUIMODE = GM_DRAG;
		printn ("Bitmap MD - by MarkeyJester\n");
	}
	for ( ; ArgCount < ArgNumber; ArgCount++)
	{
		strcpy (Directory, ArgList [ArgCount]);
		DirectLoc = 0;
		if (Directory [DirectLoc] == '-')
		{
			DirectLoc++;
			int PrevLoc = DirectLoc + 1;
			switch (W_ModesChars [Directory [DirectLoc++]])
			{
				case 'W':
				{
					// Width
					int Value = GetNumber (Directory, DirectLoc);
					switch (Value)
					{
						case 320:
						{
							WIDTHTYPE = WT_320;
						}
						break;
						case 256:
						{
							WIDTHTYPE = WT_256;
							if (W_ModesChars [Directory [DirectLoc]] == 'C')
							{
								WIDTHTYPE = WT_256C;
							}
						}
						break;
						default:
						{
							DisplayError ("Invalid width \"%s\" - Try \"320\", \"256\" or \"256C\"", &Directory [PrevLoc]);
						}
					}
				}
				break;
				case 'H':
				{
					// Height
					int Value = GetNumber (Directory, DirectLoc);
					switch (Value)
					{
						case 240:
						{
							HEIGHTTYPE = HT_240;
						}
						break;
						case 224:
						{
							HEIGHTTYPE = HT_224;
							if (W_ModesChars [Directory [DirectLoc]] == 'C')
							{
								HEIGHTTYPE = HT_224C;
							}
						}
						break;
						default:
						{
							DisplayError ("Invalid height \"%s\" - Try \"240\", \"224\" or \"224C\"", &Directory [PrevLoc]);
						}
					}
				}
				break;
				case 'S':
				{
					// Sprite
					switch (W_ModesChars [Directory [DirectLoc]])
					{
						case 'H':
						{
							// Sprite Shadow/Highlight
							switch (W_ModesChars [Directory [++DirectLoc]])
							{
								case 'Y':
								{
									SPRITES = TRUE;
									SPRITESH = TRUE;
								}
								break;
								case 'N':
								{
									SPRITESH = FALSE;
								}
								break;
								default:
								{
									DisplayError ("Invalid sprite highlight \"%s\" - Try \"Y\" for Yes or \"N\" for No", &Directory [DirectLoc]);
								}
							}
						}
						break;
						case 'C':
						{
							// Scale
							DirectLoc++;
							if (strcmp (&Directory [DirectLoc], "STRETCH") == 0)
							{
								SCALETYPE = ST_STRETCH;
							}
							else if (strcmp (&Directory [DirectLoc], "FIT") == 0)
							{
								SCALETYPE = ST_FIT;
							}
							else if (strcmp (&Directory [DirectLoc], "FILL") == 0)
							{
								SCALETYPE = ST_FILL;
							}
							else if (Directory [DirectLoc] >= '0' && Directory [DirectLoc] <= '9')
							{
								SCALETYPE = ST_CUSTOM;
								ScaleX = GetNumber (Directory, DirectLoc);
								if (W_ModesChars [Directory [DirectLoc]] == 'X')
								{
									ScaleY = GetNumber (Directory, DirectLoc);
								}
							}
							else
							{
								DisplayError ("Invalid scale type \"%s\" - Try \"STRETCH\", \"FIT\", \"FILL\"", &Directory [DirectLoc]);
							}
						}
						break;
						case 'T':
						{
							DirectLoc++;
							switch (W_ModesChars [Directory [DirectLoc]])
							{
								case 'Y':
								{
									SNAPTILE = TRUE;
								}
								break;
								case 'N':
								{
									SNAPTILE = FALSE;
								}
								break;
								default:
								{
									DisplayError ("Invalid snap tile mode \"%s\" - Try \"Y\" for Yes or \"N\" for No", &Directory [DirectLoc]);
								}
							}
						}
						break;
						case 'Y':
						{
							SPRITES = TRUE;
						}
						break;
						case 'N':
						{
							SPRITES = FALSE;
						}
						break;
						default:
						{
							DisplayError ("Invalid sprite setting \"%s\" - Try \"Y\" for Yes or \"N\" for No", &Directory [DirectLoc]);
						}
					}
				}
				break;
				case 'P':
				{
					// Plane
					switch (W_ModesChars [Directory [DirectLoc]])
					{
						case '1':
						{
							PLANETYPE = PT_PLANE1;
						}
						break;
						case '2':
						{
							PLANETYPE = PT_PLANE2;
						}
						break;
						default:
						{
							DisplayError ("Invalid plane \"%s\" - Try \"1\" or \"2\"", &Directory [PrevLoc]);
						}
					}
				}
				break;
				case 'I':
				{
					// Interpolation
					switch (W_ModesChars [Directory [DirectLoc]])
					{
						case 'Y':
						{
							INTERPOLATION = TRUE;
						}
						break;
						case 'N':
						{
							INTERPOLATION = FALSE;
						}
						break;
						default:
						{
							DisplayError ("Invalid interpolation \"%s\" - Try \"Y\" for Yes or \"N\" for No", &Directory [DirectLoc]);
						}
					}
				}
				break;
				case 'D':
				{
					if ((strcmp ("NONE", &Directory [DirectLoc])) == 0)
					{
						DITHERTYPE = NULL;
					}
					else if ((strcmp ("FLOYD", &Directory [DirectLoc])) == 0)
					{
						DITHERTYPE = DithList_Floyd;
					}
					else if ((strcmp ("JJN", &Directory [DirectLoc])) == 0)
					{
						DITHERTYPE = DithList_JJN;
					}
					else if ((strcmp ("ORDER", &Directory [DirectLoc])) == 0)
					{
						DITHERTYPE = DithList_Order;
					}
					else
					{
						DisplayError ("Invalid dithering \"%s\" - Try \"NONE\", \"FLOYD\" or \"JNN\"", &Directory [DirectLoc]);
					}
				}
				break;
				case 'F':
				{
					switch (W_ModesChars [Directory [DirectLoc]])
					{
						case 'N':
						{
							COMMONART = CA_PLANES;
							FORCESHADOW = FALSE;
						}
						break;
						case 'P':
						{
							COMMONART = CA_PLANES;
							FORCESHADOW = TRUE;
						}
						break;
						case 'S':
						{
							COMMONART = CA_SPRITES;
							FORCESHADOW = FALSE;
						}
						break;
						default:
						{
							DisplayError ("Invalid force \"%s\" - Try \"N\" None, \"P\" Plane or \"S\" Sprites", &Directory [DirectLoc]);
						}
					}
				}
				break;
				case 'B':
				{
					// Best Settings
					switch (W_ModesChars [Directory [DirectLoc]])
					{
						case 'Y':
						{
							BESTSETTINGS = TRUE;
						}
						break;
						case 'N':
						{
							BESTSETTINGS = FALSE;
						}
						break;
						default:
						{
							DisplayError ("Invalid best settings \"%s\" - Try \"Y\" for Yes or \"N\" for No", &Directory [DirectLoc]);
						}
					}
				}
				break;
				default:
				{
					DisplayError ("%c is not a valid mode", Directory [DirectLoc - 1]);
				}
			}
			continue;
		}
		char Byte;
		bool FoundExt = FALSE;
		FileName = &Directory [DirectLoc];
		for ( ; Directory [DirectLoc] != 0x00; DirectLoc++)
		{
			Byte = Directory [DirectLoc];
			if (Byte == '\\' || Byte == '/')
			{
				FileName = &Directory [DirectLoc + 1];
			}
			if (Byte == '.')
			{
				ExtName = &Directory [DirectLoc];
				FoundExt = TRUE;
			}
		}
		if (FoundExt == FALSE)
		{
			DisplayError ("cannot create folder since the file doesn't have an extension name");
			continue;
		}
		ProcessFile ( );
		if (QUITPROGRAM == TRUE)
		{
			break;
		}
	}
	if (GUIMODE != GM_CONSOLE && QUITPROGRAM == FALSE)
	{
		printn ("\nPress enter key to exit...\n");
		fflush (stdin); getchar ( );
	}
	return (0x00);
}

// =============================================================================
















