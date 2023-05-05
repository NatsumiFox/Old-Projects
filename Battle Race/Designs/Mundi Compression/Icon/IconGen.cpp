// =============================================================================
// -----------------------------------------------------------------------------
// Icon Generator 2.0
// -----------------------------------------------------------------------------

#include "IconGen.h"
#include <windows.h>
#include <stdio.h>

// =============================================================================
// -----------------------------------------------------------------------------
// Subroutine to reallocate a Memory space (For char)
// -----------------------------------------------------------------------------

void AllocChar (char **MemoryPointer, int &MemorySize, int NewSize)

{
	char *Memory2 = MemoryPointer [0x00];
	char *Memory = (char*) malloc (NewSize + 0x01);
	if (Memory == NULL)
	{
		MessageBox (NULL, "Could not reallocate memory", "Error", MB_ICONEXCLAMATION | MB_OK);
	}
	else
	{
		if (NewSize > MemorySize)
		{
			memcpy (Memory, Memory2, MemorySize);
		}
		else
		{
			memcpy (Memory, Memory2, NewSize);
		}
	}
	free (Memory2);
	MemorySize = NewSize;
	Memory [MemorySize] = 0x00;
	MemoryPointer [0x00] = Memory;
}

// =============================================================================
// -----------------------------------------------------------------------------
// Subroutine to load an image from a bitmap
// -----------------------------------------------------------------------------

bool LoadImage (char *FileName, char **MemoryPointer, int &MemorySize, int &XSize, int &YSize)

{
	printf ("\n -> %s\n", FileName);
	FILE *Bitmap;
	if ((Bitmap = fopen (FileName, "rb")) == NULL)
	{
		printf ("    Error, could not open the file\n");
		return (0xFF);
	}
	int i0, i1, i2, i3, i4, i5, i6, i7;
	i0 = ((fgetc (Bitmap) << 0x08) & 0xFF00) | (fgetc (Bitmap) & 0xFF);
	if (i0 != 0x424D) // BM
	{
		printf ("    Error, the file is not a valid bitmap file\n");
		return (0xFF);
	}
	fseek (Bitmap, 0x1C, SEEK_SET);
	int bpp = fgetc (Bitmap) & 0xFF;
	if (bpp != 24 && bpp != 32)
	{
		printf ("    Error, the bitmap file is %d bpp, it must be 24 or 32 bpp\n", bpp);
		return (0xFF);
	}
	fseek (Bitmap, 0x12, SEEK_SET);
	XSize = (fgetc (Bitmap) & 0xFF) | ((fgetc (Bitmap) << 0x08) & 0xFF00) | ((fgetc (Bitmap) << 0x10) & 0xFF0000) | ((fgetc (Bitmap) << 0x18) & 0xFF000000);
	YSize = (fgetc (Bitmap) & 0xFF) | ((fgetc (Bitmap) << 0x08) & 0xFF00) | ((fgetc (Bitmap) << 0x10) & 0xFF0000) | ((fgetc (Bitmap) << 0x18) & 0xFF000000);
	printf ("    XSize = %0.8X\n    YSize = %0.8X\n", XSize, YSize);
	if (XSize > 0xFF || YSize > 0xFF)
	{
		printf ("    Error, the image must be smaller than %d in width and height\n", 0x0100);
		return (0xFF);
	}
	fseek (Bitmap, 0x36, SEEK_SET);
	char *Memory = MemoryPointer [0x00];
	AllocChar (&Memory, MemorySize, (XSize * 0x04) * YSize);
	MemoryPointer [0x00] = Memory;
	if (bpp == 24)
	{
		for (i0 = 0x00, i6 = 0x00; i6 < YSize; i6++)
		{
			for (i5 = 0x00; i5 < XSize; i5++)
			{
				Memory [i0++] = fgetc (Bitmap) & 0xFF;
				Memory [i0++] = fgetc (Bitmap) & 0xFF;
				Memory [i0++] = fgetc (Bitmap) & 0xFF;
				Memory [i0++] = 0x00;
			}
			fseek (Bitmap, (0x04 - ((XSize * 0x03) & 0x03)) & 0x03, SEEK_CUR);
		}
	}
	else if (bpp == 32)
	{
		for (i0 = 0x00, i6 = 0x00; i6 < YSize; i6++)
		{
			for (i5 = 0x00; i5 < XSize; i5++)
			{
				Memory [i0++] = fgetc (Bitmap) & 0xFF;
				Memory [i0++] = fgetc (Bitmap) & 0xFF;
				Memory [i0++] = fgetc (Bitmap) & 0xFF;
				Memory [i0++] = 0x00;
				fgetc (Bitmap); // quicker than fseek
			}
		}
	}
	else
	{
		printf ("    Error, bpp format %d unknown\n", bpp);
	}
	fclose (Bitmap);
	return (0x00);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Subroutine to load an image from a bitmap and turn it into alpha data
// -----------------------------------------------------------------------------

bool LoadAlpha (char *FileName, char **MemoryPointer, int &MemorySize, int &XSize, int &YSize)

{
	printf ("    %s\n", FileName);
	FILE *Bitmap;
	if ((Bitmap = fopen (FileName, "rb")) == NULL)
	{
		printf ("    Error, could not open the file\n");
		return (0xFF);
	}
	int i0, i1, i2, i3, i4, i5, i6, i7;
	i0 = ((fgetc (Bitmap) << 0x08) & 0xFF00) | (fgetc (Bitmap) & 0xFF);
	if (i0 != 0x424D) // BM
	{
		printf ("    Error, the file is not a valid bitmap file\n");
		return (0xFF);
	}
	fseek (Bitmap, 0x1C, SEEK_SET);
	int bpp = fgetc (Bitmap) & 0xFF;
	if (bpp != 24 && bpp != 32)
	{
		printf ("    Error, the bitmap file is %d bpp, it must be 24 or 32 bpp\n", bpp);
		return (0xFF);
	}
	fseek (Bitmap, 0x12, SEEK_SET);
	XSize = (fgetc (Bitmap) & 0xFF) | ((fgetc (Bitmap) << 0x08) & 0xFF00) | ((fgetc (Bitmap) << 0x10) & 0xFF0000) | ((fgetc (Bitmap) << 0x18) & 0xFF000000);
	YSize = (fgetc (Bitmap) & 0xFF) | ((fgetc (Bitmap) << 0x08) & 0xFF00) | ((fgetc (Bitmap) << 0x10) & 0xFF0000) | ((fgetc (Bitmap) << 0x18) & 0xFF000000);
	printf ("    XSize = %0.8X\n    YSize = %0.8X\n", XSize, YSize);
	if (XSize > 0xFF || YSize > 0xFF)
	{
		printf ("    Error, the image must be smaller than %d in width and height\n", 0x0100);
		return (0xFF);
	}
	fseek (Bitmap, 0x36, SEEK_SET);
	char *Memory = MemoryPointer [0x00];
	AllocChar (&Memory, MemorySize, XSize * YSize);
	MemoryPointer [0x00] = Memory;
	if (bpp == 24)
	{
		for (i0 = 0x00, i6 = 0x00; i6 < YSize; i6++)
		{
			for (i5 = 0x00; i5 < XSize; i5++)
			{
				i1 = fgetc (Bitmap) & 0xFF;
				i1 += fgetc (Bitmap) & 0xFF;
				i1 += fgetc (Bitmap) & 0xFF;
				i1 /= 0x03;
				Memory [i0++] = i1;
			}
			fseek (Bitmap, (0x04 - ((XSize * 0x03) & 0x03)) & 0x03, SEEK_CUR);
		}
	}
	else if (bpp == 32)
	{
		for (i0 = 0x00, i6 = 0x00; i6 < YSize; i6++)
		{
			for (i5 = 0x00; i5 < XSize; i5++)
			{
				i1 = fgetc (Bitmap) & 0xFF;
				i1 += fgetc (Bitmap) & 0xFF;
				i1 += fgetc (Bitmap) & 0xFF;
				i1 /= 0x03;
				Memory [i0++] = i1;
				fgetc (Bitmap); // quicker than fseek
			}
		}
	}
	else
	{
		printf ("    Error, bpp format %d unknown\n", bpp);
	}
	fclose (Bitmap);
	return (0x00);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Subroutine to dump buffer contents to a file
// -----------------------------------------------------------------------------

void DumpBuffer (char *Buffer, int Size, const char *Filename)

{
	FILE *File;
	if ((File = fopen (Filename, "wb")) != NULL)
	{
		int Counter = 0x00;
		while (Counter != Size)
		{
			fputc (Buffer [Counter++], File);
		}
		fclose (File);
	}
}

// =============================================================================
// -----------------------------------------------------------------------------
// Main Code
// -----------------------------------------------------------------------------

int main (int ArgCount, char **ArgList, char **EnvList)

{
	printf ("Icon Generator 2.0 - by MarkeyJester\n\n");
	if (ArgCount <= 0x01)
	{
		printf (" -> Drag and drop an image list onto this application\n");
	}
	else
	{
		printf (" -> Reading list\n");
		FILE *List;
		if ((List = fopen (ArgList [0x01], "rb")) == NULL)
		{
			printf ("    Error, could not open the list\n");
		}
		else
		{
			fseek (List, 0x00, SEEK_END);
			int ListSize = ftell (List);
			rewind (List);
			char Text [0x0400]; int TextLoc, ExtLoc;
			int i0, i1, i2, i3, i4, i5, i6, i7;
			char *IconInfo = NULL; int IconInfoSize = 0x00, IconInfoLoc = 0x00;
			char *IconData = NULL; int IconDataSize = 0x00, IconDataLoc = 0x00;
			char *Image = NULL; int ImageSize = 0x00, ImageLoc = 0x00, ImageXSize, ImageYSize;
			char *Alpha = NULL; int AlphaSize = 0x00, AlphaLoc = 0x00, AlphaXSize, AlphaYSize;
			AllocChar (&IconInfo, IconInfoSize, 0x06);
			IconInfo [IconInfoLoc++] = 0x00; IconInfo [IconInfoLoc++] = 0x00; IconInfo [IconInfoLoc++] = 0x01; IconInfo [IconInfoLoc++] = 0x00; // ???
			IconInfo [IconInfoLoc++] = 0x00; IconInfo [IconInfoLoc++] = 0x00; // number of icon items (0 at the moment)
			bool Finish = 0x00;
			while (Finish == 0x00)
			{
				for (TextLoc = 0x00, i0 = ' '; i0 <= ' ' && Finish == 0x00; )
				{
					if (ftell (List) < ListSize)
					{
						i0 = fgetc (List) & 0xFF;
					}
					else
					{
						i0 = 0x00;
						Finish = 0xFF;
					}
				}
				if (Finish == 0x00)
				{
					for (ExtLoc = 0x00; i0 > ' ' && Finish == 0x00; )
					{
						Text [TextLoc++] = i0;
						if (ftell (List) < ListSize)
						{
							i0 = fgetc (List) & 0xFF;
							if (i0 == '.')
							{
								ExtLoc = TextLoc;
							}
						}
						else
						{
							i0 = 0x00;
							Finish = 0xFF;
						}
					}
					Text [TextLoc++] = 0x00;
					if (LoadImage (Text, &Image, ImageSize, ImageXSize, ImageYSize) == 0x00)
					{
						while (TextLoc >= ExtLoc)
						{
							Text [TextLoc + 0x04] = Text [TextLoc--];
						}
						ExtLoc++;
						Text [ExtLoc++] = 'a';
						Text [ExtLoc++] = 'l';
						Text [ExtLoc++] = 'p';
						if (LoadAlpha (Text, &Alpha, AlphaSize, AlphaXSize, AlphaYSize) == 0x00)
						{
							if (ImageXSize != AlphaXSize || ImageYSize != AlphaYSize)
							{
								printf ("    Error, the alpha's width and height does not match the image's width and height\n");
							}
							else
							{
								AllocChar (&IconInfo, IconInfoSize, IconInfoSize + 0x10);
								IconInfo [0x04]++; // icon item count increase
								IconInfo [IconInfoLoc++] = ImageXSize; // X size
								IconInfo [IconInfoLoc++] = ImageYSize; // Y size
								IconInfo [IconInfoLoc++] = 0x00; IconInfo [IconInfoLoc++] = 0x00; IconInfo [IconInfoLoc++] = 0x01; IconInfo [IconInfoLoc++] = 0x00; // ???
								IconInfo [IconInfoLoc++] = 32; IconInfo [IconInfoLoc++] = 0x00; // bpp
								IconInfo [IconInfoLoc + 0x04] = IconDataLoc;			// location of icon
								IconInfo [IconInfoLoc + 0x05] = IconDataLoc >> 0x08;
								IconInfo [IconInfoLoc + 0x06] = IconDataLoc >> 0x10;
								IconInfo [IconInfoLoc + 0x07] = IconDataLoc >> 0x18;

								int StartOffset = IconDataLoc;

								AllocChar (&IconData, IconDataSize, IconDataSize + (ImageSize + 0x28));
								IconData [IconDataLoc++] = 0x28; IconData [IconDataLoc++] = 0x00; IconData [IconDataLoc++] = 0x00; IconData [IconDataLoc++] = 0x00; // header size
								i0 = ImageXSize;
								if (ImageYSize > ImageXSize)
								{
									i0 = ImageYSize;
								}
								IconData [IconDataLoc++] = i0; IconData [IconDataLoc++] = 0x00; IconData [IconDataLoc++] = 0x00; IconData [IconDataLoc++] = 0x00; // icon general size
								IconData [IconDataLoc++] = i0 * 0x02; IconData [IconDataLoc++] = 0x00; IconData [IconDataLoc++] = 0x00; IconData [IconDataLoc++] = 0x00; // icon general size x2
								IconData [IconDataLoc++] = 0x01; IconData [IconDataLoc++] = 0x00; // ???
								IconData [IconDataLoc++] = 32; IconData [IconDataLoc++] = 0x00; // bpp
								for (i0 = 0x00; i0 < 0x18; i0++)
								{
									IconData [IconDataLoc++] = 0x00; // unknown header information (seems to be blank)
								}
								ImageLoc = 0x00;
								AlphaLoc = 0x00;
								for (i7 = ImageXSize * ImageYSize; i7 != 0x00; i7--)
								{
									IconData [IconDataLoc++] = Image [ImageLoc++];
									IconData [IconDataLoc++] = Image [ImageLoc++];
									IconData [IconDataLoc++] = Image [ImageLoc++];
									ImageLoc++;
									IconData [IconDataLoc++] = Alpha [AlphaLoc++];
								}
								i0 = IconDataLoc - StartOffset;
								IconInfo [IconInfoLoc++] = i0;			// size of icon
								IconInfo [IconInfoLoc++] = i0 >> 0x08;
								IconInfo [IconInfoLoc++] = i0 >> 0x10;
								IconInfo [IconInfoLoc++] = i0 >> 0x18;
								IconInfoLoc += 0x04;
							}
						}
					}
				}
			}
			if (IconInfoSize > 0x06)
			{
				i0 = (IconInfoSize - 0x06) / 0x10;
				for (i1 = 0x12; i0 != 0x00; i0--, i1 += 0x10)
				{
					i2 = ((IconInfo [i1] & 0xFF) | ((IconInfo [i1 + 0x01] << 0x08) & 0xFF00) | ((IconInfo [i1 + 0x02] << 0x10) & 0xFF0000) | ((IconInfo [i1 + 0x03] << 0x18) & 0xFF000000)) + IconInfoSize;
					IconInfo [i1] = i2;
					IconInfo [i1 + 0x01] = i2 >> 0x08;
					IconInfo [i1 + 0x02] = i2 >> 0x10;
					IconInfo [i1 + 0x03] = i2 >> 0x18;
				}
				IconInfoLoc = IconInfoSize;
				AllocChar (&IconInfo, IconInfoSize, IconInfoSize + IconDataSize);
				for (IconDataLoc = 0x00; IconDataLoc < IconDataSize; IconInfoLoc++, IconDataLoc++)
				{
					IconInfo [IconInfoLoc] = IconData [IconDataLoc];
				}
				DumpBuffer (IconInfo, IconInfoSize, "Icon.ico");
			}
			free (IconInfo);
			free (IconData);
			free (Image);
			free (Alpha);
		}
	}
	printf ("\nPress enter key to exit...\n");
	fflush (stdin);
	getc (stdin);
	return 0x00;
}

// =============================================================================
