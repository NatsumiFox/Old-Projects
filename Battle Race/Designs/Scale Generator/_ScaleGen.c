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
	IMG Image; Image.Data = NULL;

	char TEXT [0x1000];
	snprintf (TEXT, 0x1000, "%s\\Mask.bmp", FolderName);
	if (ImageLoad (&Image, TEXT) != 0x00)
	{
		printf ("Error loading Mask.bmp\n");
		fflush (stdin); getchar ( ); return (0x00);
	}


	if ((Image.SizeX % SizeX) != 0 || (Image.SizeY % SizeY) != 0)
	{
		printf ("Error, size of the image is not correct\n");
		if ((Image.SizeX % SizeX) != 0)
		{
			printf ("Width %d not a multiple of %d\n", Image.SizeX, SizeX);
		}
		if ((Image.SizeY % SizeY) != 0)
		{
			printf ("Height %d not a multiple of %d\n", Image.SizeY, SizeY);
		}
		fflush (stdin); getchar ( ); return (0x00);
	}
	FlipImage (&Image);

	int FramesX = Image.SizeX / SizeX;
	int FramesY = Image.SizeY / SizeY;

	u_int Frame [((SizeX / 2) * SizeY) + 4] = { 0 };
	Frame [((SizeX / 2) * SizeY) + 0] = 0xFFFF;
	Frame [((SizeX / 2) * SizeY) + 1] = 0xFFFF;
	Frame [((SizeX / 2) * SizeY) + 2] = 0xFFFF;
	Frame [((SizeX / 2) * SizeY) + 3] = 0xFFFF;

	snprintf (TEXT, 0x1000, "%s\\Scale List.asm", FolderName);

	FILE *File = fopen (TEXT, "w");
	char Text [0x1000];
	int CountX, CountY, TileX, TileY, PixelX, PixelY;

	fputs ("; ===========================================================================\n", File);
	fputs ("; ---------------------------------------------------------------------------\n", File);
	fputs ("; Generated Scaling code\n", File);
	fputs ("; ---------------------------------------------------------------------------\n", File);
	fputs ("\n", File);
	fputs ("ScaleList:", File);
	for (CountY = 0; CountY < FramesY; CountY++)
	{
		for (CountX = 0; CountX < FramesX; CountX++)
		{
			if (CountX != 0 || CountY != 0)
			{
				fputc ('	', File);
			}
			snprintf (Text, 0x1000, "	dc.l	Scale%0.2X\n", (CountY * FramesX) + CountX); fputs (Text, File);
		}
	}
	for (CountY = 0; CountY < FramesY; CountY++)
	{
		for (CountX = 0; CountX < FramesX; CountX++)
		{
			int TileOrderLoc = 0;
			for (TileY = 0; TileY < (SizeY / 0x08); TileY++)
			{
				for (TileX = 0; TileX < (SizeX / 0x08); TileX++)
				{
					if (TileOrder [TileOrderLoc] == -0x01)
					{
						TileOrderLoc++;
						continue;
					}
					u_int FrameLoc = TileOrder [TileOrderLoc++] * 0x20;
					for (PixelY = 0; PixelY < 0x08; PixelY++)
					{
						for (PixelX = 0; PixelX < 0x08; PixelX += 0x02)
						{
							int ImagePos = PixelX + (TileX * 0x08) + (CountX * SizeX);
							ImagePos += (PixelY + (TileY * 0x08) + (CountY * SizeY)) * Image.SizeX;
							PIX_BGRA Colour = Image.Data [ImagePos];
							if (Colour.Red == 0xFF && Colour.Blue == 0xFF && Colour.Green == 0x00)
							{
								Frame [FrameLoc++] = 0x00;
							}
							else
							{
								Frame [FrameLoc++] = (Colour.Green + (Colour.Blue << 0x08) + (Colour.Red << 0x10));
							}
						}
					}
				}
			}

			snprintf (Text, 0x1000, "\n	; --- Generated Scale %0.2X ---\n\nScale%0.2X:\n", (CountY * FramesX) + CountX, (CountY * FramesX) + CountX); fputs (Text, File);
			int FramePos = 0;
			for (FramePos = 0; FramePos < ((SizeX / 2) * SizeY); FramePos++)
			{
				int Off = Frame [FramePos];
				if ((FramePos & 1) == 0) // movep method can only work on even addresses due to normal move from register afterwards...
				{
					if (Frame [FramePos + 1] == Off + 2)
					{
						if (Frame [FramePos + 2] == Off + 4 && Frame [FramePos + 3] == Off + 6)
						{
							// movep.l allowed
							snprintf (Text, 0x1000, "		movep.l	%d(a0),d1\n		move.l	d1,(a1)+\n", Off); fputs (Text, File);
							FramePos += 3;
						}
						else
						{
							// movep.w allowed
							snprintf (Text, 0x1000, "		movep.w	%d(a0),d1\n		move.w	d1,(a1)+\n", Off); fputs (Text, File);
							FramePos++;
						}
						continue;
					}
					if (Frame [FramePos] == 0x00)
					{
						if (Frame [FramePos + 1] == 0x00)
						{
							if (Frame [FramePos + 2] == 0x00 && Frame [FramePos + 3] == 0x00)
							{
								// move.l d0 allowed
								snprintf (Text, 0x1000, "		move.l	d0,(a1)+\n"); fputs (Text, File);
								FramePos += 3;
							}
							else
							{
								// move.w d0 allowed
								snprintf (Text, 0x1000, "		move.w	d0,(a1)+\n"); fputs (Text, File);
								FramePos++;
							}
							continue;
						}
					}
					// Special instance where you can movep.l then clear one of the bytes...
					int Match = 0;
					if (Frame [FramePos + 0] == Frame [FramePos + 1] - 2) { Match++; }
					if (Frame [FramePos + 0] == Frame [FramePos + 2] - 4) { Match++; }
					if (Frame [FramePos + 0] == Frame [FramePos + 3] - 6) { Match++; }
					if (Match == 2)
					{
						snprintf (Text, 0x1000, "		movep.l	%d(a0),d1\n", (Frame [FramePos + 0] - 0));
						if (Frame [FramePos + 0] != Frame [FramePos + 1] - 2 && Frame [FramePos + 1] - 2 == 0) { fputs (Text, File); snprintf (Text, 0x1000, "		and.l	d3,d1\n		move.l	d1,(a1)+\n"); fputs (Text, File); FramePos += 3; continue; }
						if (Frame [FramePos + 0] != Frame [FramePos + 2] - 4 && Frame [FramePos + 2] - 4 == 0) { fputs (Text, File); snprintf (Text, 0x1000, "		and.w	d4,d1\n		move.l	d1,(a1)+\n"); fputs (Text, File); FramePos += 3; continue; }
						if (Frame [FramePos + 0] != Frame [FramePos + 3] - 6 && Frame [FramePos + 3] - 6 == 0) { fputs (Text, File); snprintf (Text, 0x1000, "		sf.b	d1\n		move.l	d1,(a1)+\n"); fputs (Text, File); FramePos += 3; continue; }
					}
					Match = 0;
					if (Frame [FramePos + 1] == Frame [FramePos + 0] + 2) { Match++; }
					if (Frame [FramePos + 1] == Frame [FramePos + 2] - 2) { Match++; }
					if (Frame [FramePos + 1] == Frame [FramePos + 3] - 4) { Match++; }
					if (Match == 2)
					{
						snprintf (Text, 0x1000, "		movep.l	%d(a0),d1\n", (Frame [FramePos + 1] - 2));
						if (Frame [FramePos + 1] != Frame [FramePos + 0] + 2 && Frame [FramePos + 0] + 2 == 0) { fputs (Text, File); snprintf (Text, 0x1000, "		and.l	d2,d1\n		move.l	d1,(a1)+\n"); fputs (Text, File); FramePos += 3; continue; }
						if (Frame [FramePos + 1] != Frame [FramePos + 2] - 2 && Frame [FramePos + 2] - 2 == 0) { fputs (Text, File); snprintf (Text, 0x1000, "		and.w	d4,d1\n		move.l	d1,(a1)+\n"); fputs (Text, File); FramePos += 3; continue; }
						if (Frame [FramePos + 1] != Frame [FramePos + 3] - 4 && Frame [FramePos + 3] - 4 == 0) { fputs (Text, File); snprintf (Text, 0x1000, "		sf.b	d1\n		move.l	d1,(a1)+\n"); fputs (Text, File); FramePos += 3; continue; }
					}
					Match = 0;
					if (Frame [FramePos + 2] == Frame [FramePos + 0] + 4) { Match++; }
					if (Frame [FramePos + 2] == Frame [FramePos + 1] + 2) { Match++; }
					if (Frame [FramePos + 2] == Frame [FramePos + 3] - 2) { Match++; }
					if (Match == 2)
					{
						snprintf (Text, 0x1000, "		movep.l	%d(a0),d1\n", (Frame [FramePos + 2] - 4));
						if (Frame [FramePos + 2] != Frame [FramePos + 0] + 4 && Frame [FramePos + 0] + 4 == 0) { fputs (Text, File); snprintf (Text, 0x1000, "		and.l	d2,d1\n		move.l	d1,(a1)+\n"); fputs (Text, File); FramePos += 3; continue; }
						if (Frame [FramePos + 2] != Frame [FramePos + 1] + 2 && Frame [FramePos + 1] + 2 == 0) { fputs (Text, File); snprintf (Text, 0x1000, "		and.l	d3,d1\n		move.l	d1,(a1)+\n"); fputs (Text, File); FramePos += 3; continue; }
						if (Frame [FramePos + 2] != Frame [FramePos + 3] - 2 && Frame [FramePos + 3] - 2 == 0) { fputs (Text, File); snprintf (Text, 0x1000, "		sf.b	d1\n		move.l	d1,(a1)+\n"); fputs (Text, File); FramePos += 3; continue; }
					}
					Match = 0;
					if (Frame [FramePos + 3] == Frame [FramePos + 0] + 6) { Match++; }
					if (Frame [FramePos + 3] == Frame [FramePos + 1] + 4) { Match++; }
					if (Frame [FramePos + 3] == Frame [FramePos + 2] + 2) { Match++; }
					if (Match == 2)
					{
						snprintf (Text, 0x1000, "		movep.l	%d(a0),d1\n", (Frame [FramePos + 3] - 6));
						if (Frame [FramePos + 3] != Frame [FramePos + 0] + 6 && Frame [FramePos + 0] + 6 == 0) { fputs (Text, File); snprintf (Text, 0x1000, "		and.l	d2,d1\n		move.l	d1,(a1)+\n"); fputs (Text, File); FramePos += 3; continue; }
						if (Frame [FramePos + 3] != Frame [FramePos + 1] + 4 && Frame [FramePos + 1] + 4 == 0) { fputs (Text, File); snprintf (Text, 0x1000, "		and.l	d3,d1\n		move.l	d1,(a1)+\n"); fputs (Text, File); FramePos += 3; continue; }
						if (Frame [FramePos + 3] != Frame [FramePos + 2] + 2 && Frame [FramePos + 2] + 2 == 0) { fputs (Text, File); snprintf (Text, 0x1000, "		and.w	d4,d1\n		move.l	d1,(a1)+\n"); fputs (Text, File); FramePos += 3; continue; }
					}
				}
				if (Frame [FramePos] == 0x00)
				{
					// move.b d0 allowed
					snprintf (Text, 0x1000, "		move.b	d0,(a1)+\n"); fputs (Text, File);
				}
				else
				{
					// move.b $Off(a0),(a1)+ must be used
					snprintf (Text, 0x1000, "		move.b	$%-0.4X(a0),(a1)+\n", Off); fputs (Text, File);
				}
			}
			snprintf (Text, 0x1000, "		rts\n"); fputs (Text, File);
		}
	}
	fputs ("\n; ===========================================================================", File);
	fclose (File);
	free (Image.Data); Image.Data;
	return (0x00);
}

// =============================================================================
