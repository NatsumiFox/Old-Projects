// ==========================================================================
// --------------------------------------------------------------------------
// Bitmap header
// --------------------------------------------------------------------------

#include <stdio.h>
#include <windows.h>

// --------------------------------------------------------------------------
// Defines
// --------------------------------------------------------------------------

#define rangeof(ENTRY) (0x01<<(0x08*sizeof(ENTRY)))

#define BH_STRETCH 0x00
#define BH_FIT 0x01
#define BH_FILL 0x02

// --------------------------------------------------------------------------
// Macro routines
// --------------------------------------------------------------------------

int SECRETCOUNT;

#define GetValue(VALUE,TYPE,MEM,MEMLOC) VALUE = *(TYPE*) &MEM [MEMLOC]; MEMLOC += sizeof (TYPE);
#define PutValue(VALUE,TYPE,MEM,MEMLOC) *(TYPE*) &MEM [MEMLOC] = VALUE; MEMLOC += sizeof (TYPE);

#define GetValueBig(VALUE,TYPE,MEM,MEMLOC)\
{\
	SECRETCOUNT = sizeof (TYPE);\
	while (--SECRETCOUNT >= 0)\
	{\
		VALUE = (VALUE << 0x08) | (MEM [MEMLOC++] & 0xFF);\
	}\
}

#define PutValueBig(VALUE,TYPE,MEM,MEMLOC)\
{\
	SECRETCOUNT = sizeof (TYPE);\
	while (--SECRETCOUNT >= 0)\
	{\
		MEM [MEMLOC++] = VALUE >> (SECRETCOUNT * 8);\
	}\
}

// --------------------------------------------------------------------------
// Structures
// --------------------------------------------------------------------------

struct PIX_BGRA

{
	u_char Blue;
	u_char Green;
	u_char Red;
	u_char Alpha;
};

struct IMG

{
	PIX_BGRA *Data = NULL;
	int Size;
	int SizeX;
	int SizeY;
};

// --------------------------------------------------------------------------
// Universal constants
// --------------------------------------------------------------------------

const PIX_BGRA PalList1 [] = {	{ 0x00, 0x00, 0x00, 0xFF },
				{ 0xFF, 0xFF, 0xFF, 0xFF }	};

const PIX_BGRA PalList4 [] = {	{ 0x00, 0x00, 0x00, 0xFF },  { 0x00, 0x00, 0x80, 0xFF },  { 0x00, 0x80, 0x00, 0xFF },  { 0x00, 0x80, 0x80, 0xFF },
				{ 0x80, 0x00, 0x00, 0xFF },  { 0x80, 0x00, 0x80, 0xFF },  { 0x80, 0x80, 0x00, 0xFF },  { 0x80, 0x80, 0x80, 0xFF },
				{ 0xC0, 0xC0, 0xC0, 0xFF },  { 0x00, 0x00, 0xFF, 0xFF },  { 0x00, 0xFF, 0x00, 0xFF },  { 0x00, 0xFF, 0xFF, 0xFF },
				{ 0xFF, 0x00, 0x00, 0xFF },  { 0xFF, 0x00, 0xFF, 0xFF },  { 0xFF, 0xFF, 0x00, 0xFF },  { 0xFF, 0xFF, 0xFF, 0xFF }	};

const PIX_BGRA PalList8 [] = {	{ 0x00, 0x00, 0x00, 0xFF },  { 0x00, 0x00, 0x80, 0xFF },  { 0x00, 0x80, 0x00, 0xFF },  { 0x00, 0x80, 0x80, 0xFF },
				{ 0x80, 0x00, 0x00, 0xFF },  { 0x80, 0x00, 0x80, 0xFF },  { 0x80, 0x80, 0x00, 0xFF },  { 0xC0, 0xC0, 0xC0, 0xFF },
				{ 0xC0, 0xDC, 0xC0, 0xFF },  { 0xF0, 0xCA, 0xA6, 0xFF },  { 0x00, 0x20, 0x40, 0xFF },  { 0x00, 0x20, 0x60, 0xFF },
				{ 0x00, 0x20, 0x80, 0xFF },  { 0x00, 0x20, 0xA0, 0xFF },  { 0x00, 0x20, 0xC0, 0xFF },  { 0x00, 0x20, 0xE0, 0xFF },
				{ 0x00, 0x40, 0x00, 0xFF },  { 0x00, 0x40, 0x20, 0xFF },  { 0x00, 0x40, 0x40, 0xFF },  { 0x00, 0x40, 0x60, 0xFF },
				{ 0x00, 0x40, 0x80, 0xFF },  { 0x00, 0x40, 0xA0, 0xFF },  { 0x00, 0x40, 0xC0, 0xFF },  { 0x00, 0x40, 0xE0, 0xFF },
				{ 0x00, 0x60, 0x00, 0xFF },  { 0x00, 0x60, 0x20, 0xFF },  { 0x00, 0x60, 0x40, 0xFF },  { 0x00, 0x60, 0x60, 0xFF },
				{ 0x00, 0x60, 0x80, 0xFF },  { 0x00, 0x60, 0xA0, 0xFF },  { 0x00, 0x60, 0xC0, 0xFF },  { 0x00, 0x60, 0xE0, 0xFF },
				{ 0x00, 0x80, 0x00, 0xFF },  { 0x00, 0x80, 0x20, 0xFF },  { 0x00, 0x80, 0x40, 0xFF },  { 0x00, 0x80, 0x60, 0xFF },
				{ 0x00, 0x80, 0x80, 0xFF },  { 0x00, 0x80, 0xA0, 0xFF },  { 0x00, 0x80, 0xC0, 0xFF },  { 0x00, 0x80, 0xE0, 0xFF },
				{ 0x00, 0xA0, 0x00, 0xFF },  { 0x00, 0xA0, 0x20, 0xFF },  { 0x00, 0xA0, 0x40, 0xFF },  { 0x00, 0xA0, 0x60, 0xFF },
				{ 0x00, 0xA0, 0x80, 0xFF },  { 0x00, 0xA0, 0xA0, 0xFF },  { 0x00, 0xA0, 0xC0, 0xFF },  { 0x00, 0xA0, 0xE0, 0xFF },
				{ 0x00, 0xC0, 0x00, 0xFF },  { 0x00, 0xC0, 0x20, 0xFF },  { 0x00, 0xC0, 0x40, 0xFF },  { 0x00, 0xC0, 0x60, 0xFF },
				{ 0x00, 0xC0, 0x80, 0xFF },  { 0x00, 0xC0, 0xA0, 0xFF },  { 0x00, 0xC0, 0xC0, 0xFF },  { 0x00, 0xC0, 0xE0, 0xFF },
				{ 0x00, 0xE0, 0x00, 0xFF },  { 0x00, 0xE0, 0x20, 0xFF },  { 0x00, 0xE0, 0x40, 0xFF },  { 0x00, 0xE0, 0x60, 0xFF },
				{ 0x00, 0xE0, 0x80, 0xFF },  { 0x00, 0xE0, 0xA0, 0xFF },  { 0x00, 0xE0, 0xC0, 0xFF },  { 0x00, 0xE0, 0xE0, 0xFF },
				{ 0x40, 0x00, 0x00, 0xFF },  { 0x40, 0x00, 0x20, 0xFF },  { 0x40, 0x00, 0x40, 0xFF },  { 0x40, 0x00, 0x60, 0xFF },
				{ 0x40, 0x00, 0x80, 0xFF },  { 0x40, 0x00, 0xA0, 0xFF },  { 0x40, 0x00, 0xC0, 0xFF },  { 0x40, 0x00, 0xE0, 0xFF },
				{ 0x40, 0x20, 0x00, 0xFF },  { 0x40, 0x20, 0x20, 0xFF },  { 0x40, 0x20, 0x40, 0xFF },  { 0x40, 0x20, 0x60, 0xFF },
				{ 0x40, 0x20, 0x80, 0xFF },  { 0x40, 0x20, 0xA0, 0xFF },  { 0x40, 0x20, 0xC0, 0xFF },  { 0x40, 0x20, 0xE0, 0xFF },
				{ 0x40, 0x40, 0x00, 0xFF },  { 0x40, 0x40, 0x20, 0xFF },  { 0x40, 0x40, 0x40, 0xFF },  { 0x40, 0x40, 0x60, 0xFF },
				{ 0x40, 0x40, 0x80, 0xFF },  { 0x40, 0x40, 0xA0, 0xFF },  { 0x40, 0x40, 0xC0, 0xFF },  { 0x40, 0x40, 0xE0, 0xFF },
				{ 0x40, 0x60, 0x00, 0xFF },  { 0x40, 0x60, 0x20, 0xFF },  { 0x40, 0x60, 0x40, 0xFF },  { 0x40, 0x60, 0x60, 0xFF },
				{ 0x40, 0x60, 0x80, 0xFF },  { 0x40, 0x60, 0xA0, 0xFF },  { 0x40, 0x60, 0xC0, 0xFF },  { 0x40, 0x60, 0xE0, 0xFF },
				{ 0x40, 0x80, 0x00, 0xFF },  { 0x40, 0x80, 0x20, 0xFF },  { 0x40, 0x80, 0x40, 0xFF },  { 0x40, 0x80, 0x60, 0xFF },
				{ 0x40, 0x80, 0x80, 0xFF },  { 0x40, 0x80, 0xA0, 0xFF },  { 0x40, 0x80, 0xC0, 0xFF },  { 0x40, 0x80, 0xE0, 0xFF },
				{ 0x40, 0xA0, 0x00, 0xFF },  { 0x40, 0xA0, 0x20, 0xFF },  { 0x40, 0xA0, 0x40, 0xFF },  { 0x40, 0xA0, 0x60, 0xFF },
				{ 0x40, 0xA0, 0x80, 0xFF },  { 0x40, 0xA0, 0xA0, 0xFF },  { 0x40, 0xA0, 0xC0, 0xFF },  { 0x40, 0xA0, 0xE0, 0xFF },
				{ 0x40, 0xC0, 0x00, 0xFF },  { 0x40, 0xC0, 0x20, 0xFF },  { 0x40, 0xC0, 0x40, 0xFF },  { 0x40, 0xC0, 0x60, 0xFF },
				{ 0x40, 0xC0, 0x80, 0xFF },  { 0x40, 0xC0, 0xA0, 0xFF },  { 0x40, 0xC0, 0xC0, 0xFF },  { 0x40, 0xC0, 0xE0, 0xFF },
				{ 0x40, 0xE0, 0x00, 0xFF },  { 0x40, 0xE0, 0x20, 0xFF },  { 0x40, 0xE0, 0x40, 0xFF },  { 0x40, 0xE0, 0x60, 0xFF },
				{ 0x40, 0xE0, 0x80, 0xFF },  { 0x40, 0xE0, 0xA0, 0xFF },  { 0x40, 0xE0, 0xC0, 0xFF },  { 0x40, 0xE0, 0xE0, 0xFF },
				{ 0x80, 0x00, 0x00, 0xFF },  { 0x80, 0x00, 0x20, 0xFF },  { 0x80, 0x00, 0x40, 0xFF },  { 0x80, 0x00, 0x60, 0xFF },
				{ 0x80, 0x00, 0x80, 0xFF },  { 0x80, 0x00, 0xA0, 0xFF },  { 0x80, 0x00, 0xC0, 0xFF },  { 0x80, 0x00, 0xE0, 0xFF },
				{ 0x80, 0x20, 0x00, 0xFF },  { 0x80, 0x20, 0x20, 0xFF },  { 0x80, 0x20, 0x40, 0xFF },  { 0x80, 0x20, 0x60, 0xFF },
				{ 0x80, 0x20, 0x80, 0xFF },  { 0x80, 0x20, 0xA0, 0xFF },  { 0x80, 0x20, 0xC0, 0xFF },  { 0x80, 0x20, 0xE0, 0xFF },
				{ 0x80, 0x40, 0x00, 0xFF },  { 0x80, 0x40, 0x20, 0xFF },  { 0x80, 0x40, 0x40, 0xFF },  { 0x80, 0x40, 0x60, 0xFF },
				{ 0x80, 0x40, 0x80, 0xFF },  { 0x80, 0x40, 0xA0, 0xFF },  { 0x80, 0x40, 0xC0, 0xFF },  { 0x80, 0x40, 0xE0, 0xFF },
				{ 0x80, 0x60, 0x00, 0xFF },  { 0x80, 0x60, 0x20, 0xFF },  { 0x80, 0x60, 0x40, 0xFF },  { 0x80, 0x60, 0x60, 0xFF },
				{ 0x80, 0x60, 0x80, 0xFF },  { 0x80, 0x60, 0xA0, 0xFF },  { 0x80, 0x60, 0xC0, 0xFF },  { 0x80, 0x60, 0xE0, 0xFF },
				{ 0x80, 0x80, 0x00, 0xFF },  { 0x80, 0x80, 0x20, 0xFF },  { 0x80, 0x80, 0x40, 0xFF },  { 0x80, 0x80, 0x60, 0xFF },
				{ 0x80, 0x80, 0x80, 0xFF },  { 0x80, 0x80, 0xA0, 0xFF },  { 0x80, 0x80, 0xC0, 0xFF },  { 0x80, 0x80, 0xE0, 0xFF },
				{ 0x80, 0xA0, 0x00, 0xFF },  { 0x80, 0xA0, 0x20, 0xFF },  { 0x80, 0xA0, 0x40, 0xFF },  { 0x80, 0xA0, 0x60, 0xFF },
				{ 0x80, 0xA0, 0x80, 0xFF },  { 0x80, 0xA0, 0xA0, 0xFF },  { 0x80, 0xA0, 0xC0, 0xFF },  { 0x80, 0xA0, 0xE0, 0xFF },
				{ 0x80, 0xC0, 0x00, 0xFF },  { 0x80, 0xC0, 0x20, 0xFF },  { 0x80, 0xC0, 0x40, 0xFF },  { 0x80, 0xC0, 0x60, 0xFF },
				{ 0x80, 0xC0, 0x80, 0xFF },  { 0x80, 0xC0, 0xA0, 0xFF },  { 0x80, 0xC0, 0xC0, 0xFF },  { 0x80, 0xC0, 0xE0, 0xFF },
				{ 0x80, 0xE0, 0x00, 0xFF },  { 0x80, 0xE0, 0x20, 0xFF },  { 0x80, 0xE0, 0x40, 0xFF },  { 0x80, 0xE0, 0x60, 0xFF },
				{ 0x80, 0xE0, 0x80, 0xFF },  { 0x80, 0xE0, 0xA0, 0xFF },  { 0x80, 0xE0, 0xC0, 0xFF },  { 0x80, 0xE0, 0xE0, 0xFF },
				{ 0xC0, 0x00, 0x00, 0xFF },  { 0xC0, 0x00, 0x20, 0xFF },  { 0xC0, 0x00, 0x40, 0xFF },  { 0xC0, 0x00, 0x60, 0xFF },
				{ 0xC0, 0x00, 0x80, 0xFF },  { 0xC0, 0x00, 0xA0, 0xFF },  { 0xC0, 0x00, 0xC0, 0xFF },  { 0xC0, 0x00, 0xE0, 0xFF },
				{ 0xC0, 0x20, 0x00, 0xFF },  { 0xC0, 0x20, 0x20, 0xFF },  { 0xC0, 0x20, 0x40, 0xFF },  { 0xC0, 0x20, 0x60, 0xFF },
				{ 0xC0, 0x20, 0x80, 0xFF },  { 0xC0, 0x20, 0xA0, 0xFF },  { 0xC0, 0x20, 0xC0, 0xFF },  { 0xC0, 0x20, 0xE0, 0xFF },
				{ 0xC0, 0x40, 0x00, 0xFF },  { 0xC0, 0x40, 0x20, 0xFF },  { 0xC0, 0x40, 0x40, 0xFF },  { 0xC0, 0x40, 0x60, 0xFF },
				{ 0xC0, 0x40, 0x80, 0xFF },  { 0xC0, 0x40, 0xA0, 0xFF },  { 0xC0, 0x40, 0xC0, 0xFF },  { 0xC0, 0x40, 0xE0, 0xFF },
				{ 0xC0, 0x60, 0x00, 0xFF },  { 0xC0, 0x60, 0x20, 0xFF },  { 0xC0, 0x60, 0x40, 0xFF },  { 0xC0, 0x60, 0x60, 0xFF },
				{ 0xC0, 0x60, 0x80, 0xFF },  { 0xC0, 0x60, 0xA0, 0xFF },  { 0xC0, 0x60, 0xC0, 0xFF },  { 0xC0, 0x60, 0xE0, 0xFF },
				{ 0xC0, 0x80, 0x00, 0xFF },  { 0xC0, 0x80, 0x20, 0xFF },  { 0xC0, 0x80, 0x40, 0xFF },  { 0xC0, 0x80, 0x60, 0xFF },
				{ 0xC0, 0x80, 0x80, 0xFF },  { 0xC0, 0x80, 0xA0, 0xFF },  { 0xC0, 0x80, 0xC0, 0xFF },  { 0xC0, 0x80, 0xE0, 0xFF },
				{ 0xC0, 0xA0, 0x00, 0xFF },  { 0xC0, 0xA0, 0x20, 0xFF },  { 0xC0, 0xA0, 0x40, 0xFF },  { 0xC0, 0xA0, 0x60, 0xFF },
				{ 0xC0, 0xA0, 0x80, 0xFF },  { 0xC0, 0xA0, 0xA0, 0xFF },  { 0xC0, 0xA0, 0xC0, 0xFF },  { 0xC0, 0xA0, 0xE0, 0xFF },
				{ 0xC0, 0xC0, 0x00, 0xFF },  { 0xC0, 0xC0, 0x20, 0xFF },  { 0xC0, 0xC0, 0x40, 0xFF },  { 0xC0, 0xC0, 0x60, 0xFF },
				{ 0xC0, 0xC0, 0x80, 0xFF },  { 0xC0, 0xC0, 0xA0, 0xFF },  { 0xF0, 0xFB, 0xFF, 0xFF },  { 0xA4, 0xA0, 0xA0, 0xFF },
				{ 0x80, 0x80, 0x80, 0xFF },  { 0x00, 0x00, 0xFF, 0xFF },  { 0x00, 0xFF, 0x00, 0xFF },  { 0x00, 0xFF, 0xFF, 0xFF },
				{ 0xFF, 0x00, 0x00, 0xFF },  { 0xFF, 0x00, 0xFF, 0xFF },  { 0xFF, 0xFF, 0x00, 0xFF },  { 0xFF, 0xFF, 0xFF, 0xFF }	};

// ==========================================================================
// --------------------------------------------------------------------------
// Comparing a string of specific size
// --------------------------------------------------------------------------

bool CheckType (const char *Type, char *Memory)

{
	while (*Type != 0)
	{
		if (*Type++ != *Memory++)
		{
			return (FALSE);
		}
	}
	return (TRUE);
}

// ==========================================================================
// --------------------------------------------------------------------------
// Comparing a string of specific size
// --------------------------------------------------------------------------

void SetType (const char *Type, char *Memory, int &MemoryLoc)

{
	while (*Type != 0)
	{
		Memory [MemoryLoc++] = *Type++;
	}
}

// ==========================================================================
// --------------------------------------------------------------------------
// Loading a bitmap image
// --------------------------------------------------------------------------

int LoadBMP (IMG *Image, char *Memory, int MemorySize)

{
	int CountX, CountY;
	int MemoryLoc = 0;
	int DataLoc = 0;

	BITMAPFILEHEADER FileHeader;
	GetValue (FileHeader.bfType, u_short, Memory, MemoryLoc);
	GetValue (FileHeader.bfSize, u_int, Memory, MemoryLoc);
	GetValue (FileHeader.bfReserved1, u_short, Memory, MemoryLoc);
	GetValue (FileHeader.bfReserved2, u_short, Memory, MemoryLoc);
	GetValue (FileHeader.bfOffBits, u_int, Memory, MemoryLoc);

	BITMAPINFOHEADER InfoHeader;
	GetValue (InfoHeader.biSize, u_int, Memory, MemoryLoc);
	GetValue (InfoHeader.biWidth, u_int, Memory, MemoryLoc);
	GetValue (InfoHeader.biHeight, u_int, Memory, MemoryLoc);
	GetValue (InfoHeader.biPlanes, u_short, Memory, MemoryLoc);
	GetValue (InfoHeader.biBitCount, u_short, Memory, MemoryLoc);
	GetValue (InfoHeader.biCompression, u_int, Memory, MemoryLoc);
	GetValue (InfoHeader.biSizeImage, u_int, Memory, MemoryLoc);
	GetValue (InfoHeader.biXPelsPerMeter, u_int, Memory, MemoryLoc);
	GetValue (InfoHeader.biYPelsPerMeter, u_int, Memory, MemoryLoc);
	GetValue (InfoHeader.biClrUsed, u_int, Memory, MemoryLoc);
	GetValue (InfoHeader.biClrImportant, u_int, Memory, MemoryLoc);

	if (InfoHeader.biCompression != 0x00)
	{
		return (6); // cannot support compression
	}

	Image->SizeX = InfoHeader.biWidth;
	Image->SizeY = InfoHeader.biHeight;
	Image->Size = (Image->SizeX * Image->SizeY);
	Image->Data = (PIX_BGRA*) calloc (Image->Size * sizeof (PIX_BGRA), sizeof (PIX_BGRA));
	if (Image->Data == NULL)
	{
		return (2);
	}

	switch (InfoHeader.biBitCount)
	{

// -----------------------------------------------------------------------------
// 2 colour format (this is 1 bit with a palette of 2 colours)
// -----------------------------------------------------------------------------
// 16 colour format (this is 4 bit with a palette of 16 colours)
// -----------------------------------------------------------------------------
// 256 colour format (this is 8 bit with a palette of 256 colours)
// -----------------------------------------------------------------------------

		case 1:
		case 4:
		case 8:
		{
			int PalLoc, PalSize = 0;
			int PalCount = InfoHeader.biBitCount;
			while (PalCount-- > 0)
			{
				PalSize = (PalSize << 1) | 1;
			}
			PIX_BGRA Palette [PalSize];
			u_char BitField;
			char BitCount;
			for (PalLoc = 0; PalLoc <= PalSize; PalLoc++)
			{
				Palette [PalLoc].Blue = Memory [MemoryLoc++];
				Palette [PalLoc].Green = Memory [MemoryLoc++];
				Palette [PalLoc].Red = Memory [MemoryLoc++];


			// MS Paint doesn't handle alpha correctly, and forces all alphas in the palette
			// to 00 (which is transparent)...

			//	Palette [PalLoc].Alpha = Memory [MemoryLoc++];

				MemoryLoc++;
				Palette [PalLoc].Alpha = 0xFF;
			}

			MemoryLoc = FileHeader.bfOffBits;
			for (CountY = 0; CountY < Image->SizeY; CountY++)
			{
				BitCount = 0;
				for (CountX = 0; CountX < Image->SizeX; CountX++)
				{
					for (PalLoc = 0, PalCount = InfoHeader.biBitCount; PalCount > 0; PalCount--)
					{
						if (--BitCount <= 0)
						{
							BitField = Memory [MemoryLoc++];
							BitCount = 8;
						}
						PalLoc = (PalLoc << 1) | ((BitField >> 7) & 1);
						BitField <<= 1;
					}
					Image->Data [DataLoc].Blue = Palette [PalLoc].Blue;
					Image->Data [DataLoc].Green = Palette [PalLoc].Green;
					Image->Data [DataLoc].Red = Palette [PalLoc].Red;
					Image->Data [DataLoc++].Alpha = Palette [PalLoc].Alpha;
				}
				while (((MemoryLoc - FileHeader.bfOffBits) % 4) != 0)
				{
					MemoryLoc++;
				}
			}
		}
		break;

// -----------------------------------------------------------------------------
// 24 bit format
// -----------------------------------------------------------------------------

		case 24:
		{
			MemoryLoc = FileHeader.bfOffBits;
			for (CountY = 0; CountY < Image->SizeY; CountY++)
			{
				for (CountX = 0; CountX < Image->SizeX; CountX++)
				{
					Image->Data [DataLoc].Blue = Memory [MemoryLoc++];
					Image->Data [DataLoc].Green = Memory [MemoryLoc++];
					Image->Data [DataLoc].Red = Memory [MemoryLoc++];
					Image->Data [DataLoc++].Alpha = 0xFF;
				}
				while (((MemoryLoc - FileHeader.bfOffBits) % 4) != 0)
				{
					MemoryLoc++;
				}
			}
		}
		break;

// -----------------------------------------------------------------------------
// 32 bit format
// -----------------------------------------------------------------------------

		case 32:
		{
			MemoryLoc = FileHeader.bfOffBits;
			for (CountY = 0; CountY < Image->SizeY; CountY++)
			{
				for (CountX = 0; CountX < Image->SizeX; CountX++)
				{
					Image->Data [DataLoc].Blue = Memory [MemoryLoc++];
					Image->Data [DataLoc].Green = Memory [MemoryLoc++];
					Image->Data [DataLoc].Red = Memory [MemoryLoc++];
					Image->Data [DataLoc++].Alpha = Memory [MemoryLoc++];
				}
			}
		}
		break;

// -----------------------------------------------------------------------------
// Unsupported bit formats
// -----------------------------------------------------------------------------

		default:
		{
			free (Image->Data);
			return (4);
		}
	}
	return (0);
}

// ==========================================================================
// --------------------------------------------------------------------------
// Loading an image
// --------------------------------------------------------------------------

int ImageLoad (IMG *Image, char *FileName)

{

		// --- Loading the file ---

	FILE *File = fopen (FileName, "rb");
	if (File == NULL)
	{
		return (1);
	}
	fseek (File, 0x00, SEEK_END);
	int MemorySize = ftell (File);
	char *Memory = (char*) malloc (MemorySize);
	if (Memory == NULL)
	{
		fclose (File);
		return (2);
	}
	rewind (File);
	int LoadedSize = fread (Memory, sizeof (char), MemorySize, File);
	fclose (File);
	if (LoadedSize != MemorySize)
	{
		free (Memory);
		return (3);
	}
	int Error;

		// --- Reading header ---

	if ((CheckType ("BM", Memory)) == TRUE)
	{
		Error = LoadBMP (Image, Memory, MemorySize);
		free (Memory);
		return (Error);
	}
	else
	{
		free (Memory);
		return (5);
	}
}

// ==========================================================================
// --------------------------------------------------------------------------
// Finding the closest colour in a palette
// --------------------------------------------------------------------------

int FindCol (PIX_BGRA Colour, const PIX_BGRA *Palette, int PalSize)

{
	int Red, Green, Blue;
	int Total, Best = 0x7FFF;
	int PalLoc = -1;
	int BestColour = 0;
	while (++PalLoc < PalSize)
	{
		Red = Colour.Red - Palette [PalLoc].Red;
		Green = Colour.Green - Palette [PalLoc].Green;
		Blue = Colour.Blue - Palette [PalLoc].Blue;

		if (Red < 0) { Red = -Red; }
		if (Green < 0) { Green = -Green; }
		if (Blue < 0) { Blue = -Blue; }

		Total = Red + Green + Blue;
		if (Total < Best)
		{
			Best = Total;
			BestColour = PalLoc;
		}
	}
	return (BestColour);
}

// ==========================================================================
// --------------------------------------------------------------------------
// Saving a bitmap image
// --------------------------------------------------------------------------

int SaveBMP (IMG *Image, const char *FileName, int BPP)

{
	int CountX, CountY;
	int MemoryLoc = 0;
	int DataLoc = 0;

	char *Memory = (char*) malloc (Image->Size * sizeof (PIX_BGRA));
	if (Memory == NULL)
	{
		return (2);
	}

//	SetType ("BM", Memory, MemoryLoc);
//	PutValue (0x00000000, u_int, Memory, MemoryLoc);

	const PIX_BGRA *Palette = NULL;
	int PalSize = 0;
	int PalLoc;
	int PalCount;
	u_char BitField;
	char BitCount;

	// NOTE: MS Paint would normally make alpha 00, instead of FF, in the palette...
	// ...since it doesn't handle transparency normally, I guess they just left it as 00.

	switch (BPP)
	{
		case 1:
		{
			Palette = PalList1;
			PalSize = sizeof (PalList1) / sizeof (PIX_BGRA);
		}
		break;
		case 4:
		{
			Palette = PalList4;
			PalSize = sizeof (PalList4) / sizeof (PIX_BGRA);
		}
		break;
		case 8:
		{
			Palette = PalList8;
			PalSize = sizeof (PalList8) / sizeof (PIX_BGRA);
		}
		break;
	}
	switch (BPP)
	{

// -----------------------------------------------------------------------------
// 2 colour format (this is 1 bit with a palette of 2 colours)
// -----------------------------------------------------------------------------
// 16 colour format (this is 4 bit with a palette of 16 colours)
// -----------------------------------------------------------------------------
// 256 colour format (this is 8 bit with a palette of 256 colours)
// -----------------------------------------------------------------------------

		case 1:
		case 4:
		case 8:
		{
			for (CountY = 0; CountY < Image->SizeY; CountY++)
			{
				BitField = 0;
				BitCount = 8;
				for (CountX = 0; CountX < Image->SizeX; CountX++)
				{
					PalLoc = FindCol (Image->Data [DataLoc++], Palette, PalSize);
					PalLoc <<= (8 - BPP);
					for (PalCount = BPP; PalCount > 0; PalCount--)
					{
						BitField = (BitField << 1) | ((PalLoc >> 7) & 1);
						PalLoc <<= 1;
						if (--BitCount == 0)
						{
							Memory [MemoryLoc++] = BitField;
							BitField = 0;
							BitCount = 8;
						}
					}
				}
				if (BitCount != 8)
				{
					BitField <<= BitCount;
					Memory [MemoryLoc++] = BitField;
				}
				while ((MemoryLoc % 4) != 0)
				{
					Memory [MemoryLoc++] = 0x00;
				}
			}
		}
		break;

// -----------------------------------------------------------------------------
// 24 bit format
// -----------------------------------------------------------------------------

		case 24:
		{
			for (CountY = 0; CountY < Image->SizeY; CountY++)
			{
				for (CountX = 0; CountX < Image->SizeX; CountX++)
				{
					Memory [MemoryLoc++] = Image->Data [DataLoc].Blue;
					Memory [MemoryLoc++] = Image->Data [DataLoc].Green;
					Memory [MemoryLoc++] = Image->Data [DataLoc++].Red;
				}
				while ((MemoryLoc % 4) != 0)
				{
					Memory [MemoryLoc++] = 0x00;
				}
			}
		}
		break;

// -----------------------------------------------------------------------------
// 32 bit format
// -----------------------------------------------------------------------------

		case 32:
		{
			for (CountY = 0; CountY < Image->SizeY; CountY++)
			{
				for (CountX = 0; CountX < Image->SizeX; CountX++)
				{
					Memory [MemoryLoc++] = Image->Data [DataLoc].Blue;
					Memory [MemoryLoc++] = Image->Data [DataLoc].Green;
					Memory [MemoryLoc++] = Image->Data [DataLoc].Red;
					Memory [MemoryLoc++] = Image->Data [DataLoc++].Alpha;
				}
			}
		}
		break;

// -----------------------------------------------------------------------------
// Unsupported bit formats
// -----------------------------------------------------------------------------

		default:
		{
			free (Memory);
			return (4);
		}
	}

	BITMAPFILEHEADER FileHeader;
	FileHeader.bfType = 0x4D42; // 'BM';
	FileHeader.bfSize = sizeof (BITMAPFILEHEADER) + sizeof (BITMAPINFOHEADER) + (PalSize * sizeof (PIX_BGRA)) + MemoryLoc;
	FileHeader.bfReserved1 = 0x0000;
	FileHeader.bfReserved2 = 0x0000;
	FileHeader.bfOffBits = sizeof (BITMAPFILEHEADER) + sizeof (BITMAPINFOHEADER) + (PalSize * sizeof (PIX_BGRA));

	BITMAPINFOHEADER InfoHeader;
	InfoHeader.biSize = sizeof (BITMAPINFOHEADER);
	InfoHeader.biWidth = Image->SizeX;
	InfoHeader.biHeight = Image->SizeY;
	InfoHeader.biPlanes = 0x0001;
	InfoHeader.biBitCount = BPP;
	InfoHeader.biCompression = 0x00000000;
	InfoHeader.biSizeImage = 0x00000000; // MemoryLoc;
	InfoHeader.biXPelsPerMeter = 0x00000000;
	InfoHeader.biYPelsPerMeter = 0x00000000;
	InfoHeader.biClrUsed = 0x00000000;
	InfoHeader.biClrImportant = 0x00000000;

	FILE *File = fopen (FileName, "wb");
	if (File == NULL)
	{
		free (Memory);
		return (1);
	}
	fwrite (&FileHeader, sizeof (BITMAPFILEHEADER), 1, File);
	fwrite (&InfoHeader, sizeof (BITMAPINFOHEADER), 1, File);
	fwrite (Palette, sizeof (PIX_BGRA), PalSize, File);
	fwrite (Memory, sizeof (char), MemoryLoc, File);
	fclose (File);
	free (Memory);
	return (0);
}

// ==========================================================================
// --------------------------------------------------------------------------
// Truncating an image
// --------------------------------------------------------------------------

int TruncateImage (IMG *Image, int NewPosX, int NewPosY, int NewSizeX, int NewSizeY, PIX_BGRA PadColour)

{
	if (NewPosX >= NewSizeX || NewPosY >= NewSizeY)
	{
	//	return (3);
		if (NewPosX >= NewSizeX)
		{
			NewPosX = NewSizeX;
			NewSizeX++;
		}
		if (NewPosY >= NewSizeY)
		{
			NewPosY = NewSizeY;
			NewSizeY++;
		}
	}
	IMG New;
	New.SizeX = NewSizeX - NewPosX;
	New.SizeY = NewSizeY - NewPosY;
	New.Size = New.SizeX * New.SizeY;
	if ((New.Data = (PIX_BGRA*) malloc (New.Size * sizeof (PIX_BGRA))) == NULL)
	{
		return (2);
	}
	int NewLoc;
	for (NewLoc = 0; NewLoc < New.Size; NewLoc++)
	{
		New.Data [NewLoc].Blue  = PadColour.Blue;
		New.Data [NewLoc].Green = PadColour.Green;
		New.Data [NewLoc].Red   = PadColour.Red;
		New.Data [NewLoc].Alpha = PadColour.Alpha;
	}

	int SourceX = 0, SourceY = 0, DestX = 0, DestY = 0;
	if (NewPosX < 0) { DestX = -NewPosX; } else { SourceX = NewPosX; }
	if (NewPosY < 0) { DestY = -NewPosY; } else { SourceY = NewPosY; }
	int SizeX = Image->SizeX - SourceX, SizeY = Image->SizeY - SourceY;
	if (SizeX > New.SizeX - DestX) { SizeX = New.SizeX - DestX; }
	if (SizeY > New.SizeY - DestY) { SizeY = New.SizeY - DestY; }

	int CountX, CountY, DestLoc, SourceLoc;
	for (CountX = 0; CountX < SizeX; CountX++)
	{
		for (CountY = 0; CountY < SizeY; CountY++)
		{
			SourceLoc = (SourceX + CountX) + ((CountY + SourceY) * Image->SizeX);
			DestLoc = (DestX + CountX) + ((CountY + DestY) * New.SizeX);
			New.Data [DestLoc].Blue  = Image->Data [SourceLoc].Blue;
			New.Data [DestLoc].Green = Image->Data [SourceLoc].Green;
			New.Data [DestLoc].Red   = Image->Data [SourceLoc].Red;
			New.Data [DestLoc].Alpha = Image->Data [SourceLoc].Alpha;
		}
	}
	free (Image->Data);
	Image->Data = New.Data;
	Image->Size = New.Size;
	Image->SizeX = New.SizeX;
	Image->SizeY = New.SizeY;
	return (0);
}

// ==========================================================================
// --------------------------------------------------------------------------
// Resizing an image
// --------------------------------------------------------------------------

int PerformResize (IMG *Image, int NewSizeX, int NewSizeY, bool Alias)

{
	IMG New;
	New.SizeX = NewSizeX;
	New.SizeY = NewSizeY;
	New.Size = New.SizeX * New.SizeY;
	if ((New.Data = (PIX_BGRA*) malloc (New.Size * sizeof (PIX_BGRA))) == NULL)
	{
		return (2);
	}
	int PosX, PosY;
	int AdvX = (Image->SizeX << 0x10) / New.SizeX;
	int AdvY = (Image->SizeY << 0x10) / New.SizeY;

	int CountX, CountY;
	if (Alias == FALSE)
	{
		for (PosY = 0, CountY = 0; CountY < New.SizeY; CountY++, PosY += AdvY)
		{
			for (PosX = 0, CountX = 0; CountX < New.SizeX; CountX++, PosX += AdvX)
			{
				int ImageLoc = (PosX >> 0x10) + ((PosY >> 0x10) * Image->SizeX);
				int NewLoc = CountX + (CountY * New.SizeX);
				New.Data [NewLoc].Blue  = Image->Data [ImageLoc].Blue;
				New.Data [NewLoc].Green = Image->Data [ImageLoc].Green;
				New.Data [NewLoc].Red   = Image->Data [ImageLoc].Red;
				New.Data [NewLoc].Alpha = Image->Data [ImageLoc].Alpha;
			}
		}
	}
	else
	{
		for (PosY = 0, CountY = 0; CountY < New.SizeY; CountY++, PosY += AdvY)
		{
			for (PosX = 0, CountX = 0; CountX < New.SizeX; CountX++, PosX += AdvX)
			{
				int SprX, SprY, DiffX = (AdvX >> 0x10), DiffY = (AdvY >> 0x10);
				if (DiffX == 0) { DiffX++; } if (DiffY == 0) { DiffY++; }
				u_int BlueCount = 0, GreenCount = 0, RedCount = 0, AlphaCount = 0;
				for (SprY = 0; SprY < DiffY; SprY++)
				{
					for (SprX = 0; SprX < DiffX; SprX++)
					{
						int ImageLoc = ((PosX >> 0x10) + SprX) + (((PosY >> 0x10) + SprY) * Image->SizeX);
						BlueCount  += Image->Data [ImageLoc].Blue;
						GreenCount += Image->Data [ImageLoc].Green;
						RedCount   += Image->Data [ImageLoc].Red;
						AlphaCount += Image->Data [ImageLoc].Alpha;
					}
				}
				BlueCount  /= DiffY * DiffX;
				GreenCount /= DiffY * DiffX;
				RedCount   /= DiffY * DiffX;
				AlphaCount /= DiffY * DiffX;
				int NewLoc = CountX + (CountY * New.SizeX);
				New.Data [NewLoc].Blue  = BlueCount;
				New.Data [NewLoc].Green = GreenCount;
				New.Data [NewLoc].Red   = RedCount;
				New.Data [NewLoc].Alpha = AlphaCount;
			}
		}
	}
	free (Image->Data);
	Image->Data = New.Data;
	Image->Size = New.Size;
	Image->SizeX = New.SizeX;
	Image->SizeY = New.SizeY;
	return (0);
}

// ==========================================================================
// --------------------------------------------------------------------------
// Resizing an image with aspect ratio if needed
// --------------------------------------------------------------------------

int ResizeImage (IMG *Image, int NewSizeX, int NewSizeY, PIX_BGRA PadColour, int Aspect, bool Alias, int &ActualSizeX, int &ActualSizeY, int SnapX, int SnapY)

{
	if (NewSizeX <= 0 || NewSizeY <= 0)
	{
	//	return (3);
		if (NewSizeX <= 0)
		{
			NewSizeX = 1;
		}
		if (NewSizeY <= 0)
		{
			NewSizeY = 1;
		}
	}
	int ResizeX = NewSizeX;
	int ResizeY = NewSizeY;
	ActualSizeX = ResizeX;	// Saving actual size of image itself
	ActualSizeY = ResizeY;	// ''
	if (Aspect == BH_FIT || Aspect == BH_FILL)
	{
		int PercentX = ((0x100 * 0x100) * NewSizeX) / Image->SizeX;
		int PercentY = ((0x100 * 0x100) * NewSizeY) / Image->SizeY;
		if (PercentX != PercentY)
		{
			if (Aspect == BH_FIT)
			{
				// Fitting
				if (PercentX < PercentY)
				{
					// Resize Y down to X percent
					ResizeY = (PercentX * Image->SizeY) / (0x100 * 0x100);
					ActualSizeY = ResizeY; // Actual image's Y size inside the fit image (because Y will have a boarder now)
				}
				else
				{
					// Resize X down to Y percent
					ResizeX = (PercentY * Image->SizeX) / (0x100 * 0x100);
					ActualSizeX = ResizeX; // Actual image's X size inside the fit image (because X will have a boarder now)
				}
			}
			else
			{
				// Filling
				if (PercentX > PercentY)
				{
					// Resize Y down to X percent
					ResizeY = (PercentX * Image->SizeY) / (0x100 * 0x100);
				}
				else
				{
					// Resize X down to Y percent
					ResizeX = (PercentY * Image->SizeX) / (0x100 * 0x100);
				}
			}
		}
	}
	if (SnapX != 0)
	{
		if ((ResizeX % SnapX) != 0)
		{
			if ((ResizeX % (SnapX / 2)) > (SnapX / 2))
			{
				ResizeX += SnapX - (ResizeX % SnapX);
			}
			else
			{
				ResizeX -= ResizeX % SnapX;
			}
		}
	}
	if (SnapY != 0)
	{
		if ((ResizeY % SnapY) != 0)
		{
			if ((ResizeY % (SnapY / 2)) > (SnapY / 2))
			{
				ResizeY += SnapY - (ResizeY % SnapY);
			}
			else
			{
				ResizeY -= ResizeY % SnapY;
			}
		}
	}

	int Ret = PerformResize (Image, ResizeX, ResizeY, Alias);
	if (Ret != 0 || Aspect == BH_STRETCH)
	{
		return (Ret);
	}

	if (Aspect == BH_FIT)
	{
		int NewPosX = NewSizeX - ResizeX;
		NewPosX /= 2;
		NewSizeX -= NewPosX;
		NewPosX = -NewPosX;

		int NewPosY = NewSizeY - ResizeY;
		NewPosY /= 2;
		NewSizeY -= NewPosY;
		NewPosY = -NewPosY;
		return (TruncateImage (Image, NewPosX, NewPosY, NewSizeX, NewSizeY, PadColour));
	}
	else
	{
		int NewPosX = NewSizeX - ResizeX;
		NewPosX /= 2;
		NewSizeX -= NewPosX;
		NewPosX = -NewPosX;

		int NewPosY = NewSizeY - ResizeY;
		NewPosY /= 2;
		NewSizeY -= NewPosY;
		NewPosY = -NewPosY;
		return (TruncateImage (Image, NewPosX, NewPosY, NewSizeX, NewSizeY, PadColour));
	}
}

// ==========================================================================
// --------------------------------------------------------------------------
// Rotating an image by 90 degrees
// --------------------------------------------------------------------------

int RotateImage (IMG *Image)

{
	IMG New;
	New.Data = (PIX_BGRA*) malloc (Image->Size * sizeof (PIX_BGRA));
	if (New.Data == NULL)
	{
		return (1);
	}

	int InX, InY, OutX, OutY;
	for (InY = 0, OutX = Image->SizeX - 1; InY < Image->SizeY; InY++, OutX--)
	{
		for (InX = 0, OutY = 0; InX < Image->SizeX; InX++, OutY++)
		{
			New.Data [OutX + (OutY * Image->SizeX)].Alpha = Image->Data [InX + (InY * Image->SizeX)].Alpha;
			New.Data [OutX + (OutY * Image->SizeX)].Blue  = Image->Data [InX + (InY * Image->SizeX)].Blue;
			New.Data [OutX + (OutY * Image->SizeX)].Green = Image->Data [InX + (InY * Image->SizeX)].Green;
			New.Data [OutX + (OutY * Image->SizeX)].Red   = Image->Data [InX + (InY * Image->SizeX)].Red;
		}
	}
	for (OutX = 0; OutX < Image->Size; OutX++)
	{
		Image->Data [OutX].Alpha = New.Data [OutX].Alpha;
		Image->Data [OutX].Blue  = New.Data [OutX].Blue;
		Image->Data [OutX].Green = New.Data [OutX].Green;
		Image->Data [OutX].Red   = New.Data [OutX].Red;
	}
	free (New.Data); New.Data = NULL;
}

// ==========================================================================
// --------------------------------------------------------------------------
// Resizing an image by stretching or shrinking it
// --------------------------------------------------------------------------

int FlipImage (IMG *Image)

{
	int CountX, CountY;
	PIX_BGRA Colour;
	for (CountY = 0; CountY < (Image->SizeY >> 1); CountY++)
	{
		int SourceLoc = CountY * Image->SizeX;
		int DestLoc   = ((Image->SizeY - 1) - CountY) * Image->SizeX;
		for (CountX = 0; CountX < Image->SizeX; CountX++)
		{
			Colour.Blue  = Image->Data [SourceLoc].Blue;
			Colour.Green = Image->Data [SourceLoc].Green;
			Colour.Red   = Image->Data [SourceLoc].Red;
			Colour.Alpha = Image->Data [SourceLoc].Alpha;

			Image->Data [SourceLoc].Blue  = Image->Data [DestLoc].Blue;
			Image->Data [SourceLoc].Green = Image->Data [DestLoc].Green;
			Image->Data [SourceLoc].Red   = Image->Data [DestLoc].Red;
			Image->Data [SourceLoc].Alpha = Image->Data [DestLoc].Alpha;

			Image->Data [DestLoc].Blue  = Colour.Blue;
			Image->Data [DestLoc].Green = Colour.Green;
			Image->Data [DestLoc].Red   = Colour.Red;
			Image->Data [DestLoc].Alpha = Colour.Alpha;

			SourceLoc++;
			DestLoc++;
		}		
	}
}

// =============================================================================