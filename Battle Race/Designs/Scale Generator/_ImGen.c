// =============================================================================
// -----------------------------------------------------------------------------
// Program
// -----------------------------------------------------------------------------

#include "__settings.h"

#include <stdio.h>
#include <windows.h>
#include "_bitmap.h"

int main (int ArgNumber, char **ArgList, char **EnvList)

{
	IMG Image;
	Image.SizeX = SizeX;
	Image.SizeY = SizeY;
	Image.Size = Image.SizeX * Image.SizeY;
	Image.Data = (PIX_BGRA*) malloc (Image.Size * sizeof (PIX_BGRA));

	u_int Word;
	int ImageLoc;
	for (ImageLoc = 0; ImageLoc < Image.Size; ImageLoc++)
	{
		int TileOrderLoc = (Image.Size - ImageLoc) - 1;
		TileOrderLoc = ((TileOrderLoc % SizeX) / 8) + ((((SizeY / 8) - 1) - ((TileOrderLoc / SizeX) / 8)) * (SizeX / 8));
		if (TileOrder [TileOrderLoc] == -1)
		{
			Image.Data [ImageLoc].Blue  = 0xFF;
			Image.Data [ImageLoc].Green = 0x00;
			Image.Data [ImageLoc].Red   = 0xFF;
			Image.Data [ImageLoc].Alpha = 0xFF;
		}
		else
		{
			Image.Data [ImageLoc].Blue  = (Word >> 0x08) & 0xFF;
			Image.Data [ImageLoc].Red   = (Word >> 0x10) & 0xFF;
			Image.Data [ImageLoc].Green = Word++;
			Image.Data [ImageLoc].Alpha = 0xFF;
		}
	}
	FlipImage (&Image);
	char TEXT [0x1000];
	snprintf (TEXT, 0x1000, "%s\\Image.bmp", FolderName);
	SaveBMP (&Image, TEXT, 24);
	free (Image.Data);
	return (0x00);
}

// =============================================================================
