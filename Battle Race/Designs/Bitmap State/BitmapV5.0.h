// =============================================================================
// -----------------------------------------------------------------------------
// Bitmap Header File
// -----------------------------------------------------------------------------
//
//	Header file for loading and saving image data to and from bitmap ".bmp" files
//	of any bpp format.
//
//	2013/01/27 20:03
//
//		Support for:	32-bit
//						24-bit
//						256 colour (8-bit with palette)
//						16 colour (4-bit with palette)
//						Monochrome (1-bit with palette)
//
//	2013/11/17 01:02
//
//		Function calling has changed slightly, now chars don't require & on the
//		call itself.
//
//	2014/02/22 15:11
//
//		Issue with reading 32-bit data.  The alpha channel is no longer blanked.
//
//	2014/03/08 02:19
//
//		Sorted out malloc error returning.  Have also provided a list of errors.
//
//		Error ID list:	00	Successful
//						01	The file requested could not be opened
//						02	The file is not a valid bitmap (Does not have right header)
//						03	The bpp format requested is not available
//						04	Memory could not be allocated
//						05	Crop/Resize coordinates result in no image (e.g. left crop over right crop)
//
//	2014/03/08 07:59
//
//		New crop function to resize the image by cutting or adding parts from/to
//		the image.
//
//	2014/03/08 09:08
//
//		New resize function to stretch/squash the image on X and Y.
//
//	2015/06/04 13:14
//
//		New flip function to flip an image vertically (bitmaps are usually upside down)
//		Given the crop function a pad colour parameter, so if padded out, the pad colout can be controlled
//
// =============================================================================
// -----------------------------------------------------------------------------
// Header Files
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <windows.h>

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
// Subroutine to reallocate a Memory space (For char)
// -----------------------------------------------------------------------------

int AllocChar (char *&MemoryOld, int &MemorySize, int NewSize)

{
	char *Memory = (char*) malloc (NewSize + 0x01);
	if (Memory == NULL)
	{
		return (0x01);
	}
	else
	{
		if (NewSize > MemorySize)
		{
			memcpy (Memory, MemoryOld, MemorySize);
		}
		else
		{
			memcpy (Memory, MemoryOld, NewSize);
		}
	}
	free (MemoryOld);
	MemorySize = NewSize;
	MemoryOld = Memory;
	return (0x00);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Subroutine to load a bitmap image
// -----------------------------------------------------------------------------
// switch (ImageLoad (File, Image, ImageSize, ImageXSize, ImageYSize, Imagebpp))
// {
// 	case 0x01: printf ("    Error: the file could not be opened\n"); break;
// 	case 0x02: printf ("    Error: the file is not a valid bitmap file\n"); break;
// 	case 0x03: printf ("    Error: the bpp format \"%d\" isn't currently supported\n", Imagebpp); break;
// 	case 0x04: printf ("    Error: memory could not be allocated\n"); break;
// 	case 0x00: printf ("    Success\n"); break;
// }
// -----------------------------------------------------------------------------
				

int ImageLoad (char *File, char *&Memory, int &MemorySize, int &XSize, int &YSize, int &bpp)

{
	FILE *Bitmap;
	if ((Bitmap = fopen (File, "rb")) == NULL)
	{
		return (0x01);
	}
	int i0, i1, i2, i3, i4, i5, i6, i7;
	i0 = ((fgetc (Bitmap) << 0x08) & 0xFF00) | (fgetc (Bitmap) & 0xFF);
	if (i0 != 0x424D) // BM
	{
		fclose (Bitmap);
		return (0x02);
	}
	fseek (Bitmap, 0x0A, SEEK_SET);
	int Offset = (fgetc (Bitmap) & 0xFF) | ((fgetc (Bitmap) << 0x08) & 0xFF00) | ((fgetc (Bitmap) << 0x10) & 0xFF0000) | ((fgetc (Bitmap) << 0x18) & 0xFF000000);
	fseek (Bitmap, 0x12, SEEK_SET);
	XSize = (fgetc (Bitmap) & 0xFF) | ((fgetc (Bitmap) << 0x08) & 0xFF00) | ((fgetc (Bitmap) << 0x10) & 0xFF0000) | ((fgetc (Bitmap) << 0x18) & 0xFF000000);
	YSize = (fgetc (Bitmap) & 0xFF) | ((fgetc (Bitmap) << 0x08) & 0xFF00) | ((fgetc (Bitmap) << 0x10) & 0xFF0000) | ((fgetc (Bitmap) << 0x18) & 0xFF000000);
	fseek (Bitmap, 0x1C, SEEK_SET);
	bpp = fgetc (Bitmap) & 0xFF;
	if (AllocChar (Memory, MemorySize = 0x00, (XSize * 0x04) * YSize) != 0x00)
	{
		return (0x04);
	}
	else
	{
		char Palette [256 * 0x04];
		switch (bpp)
		{

// -----------------------------------------------------------------------------
// 2 colour format (this is 1 bit with a palette of 2 colours)
// -----------------------------------------------------------------------------

			case 1:
			{
				fseek (Bitmap, 0x36, SEEK_SET);
				for (i0 = 0x00, i1 = 0x00; i0 < 2; i0++)
				{
					Palette [i1++] = fgetc (Bitmap);
					Palette [i1++] = fgetc (Bitmap);
					Palette [i1++] = fgetc (Bitmap);
					Palette [i1++] = fgetc (Bitmap);
				}
				fseek (Bitmap, Offset, SEEK_SET);
				for (i0 = 0x00, i2 = 0x00, i6 = 0x00; i6 < YSize; i6++)
				{
					for (i3 = 0x00, i5 = 0x00; i5 < XSize; i5++)
					{
						if (i3 == 0x00)
						{
							i2 = fgetc (Bitmap) & 0xFF;
						}
						i1 = ((i2 >> 0x07) & 0x01) * 0x04;
						i2 += i2;
						i3 = (i3 + 0x01) & 0x07;
						Memory [i0++] = Palette [i1++];
						Memory [i0++] = Palette [i1++];
						Memory [i0++] = Palette [i1++];
						Memory [i0++] = Palette [i1++];
					}
					fseek (Bitmap, (0x04 - ((ftell (Bitmap) - Offset) & 0x03)) & 0x03, SEEK_CUR);
				}
			}
			break;

// -----------------------------------------------------------------------------
// 16 colour format (this is 4 bit with a palette of 16 colours)
// -----------------------------------------------------------------------------

			case 4:
			{
				fseek (Bitmap, 0x36, SEEK_SET);
				for (i0 = 0x00, i1 = 0x00; i0 < 16; i0++)
				{
					Palette [i1++] = fgetc (Bitmap);
					Palette [i1++] = fgetc (Bitmap);
					Palette [i1++] = fgetc (Bitmap);
					Palette [i1++] = fgetc (Bitmap);
				}
				fseek (Bitmap, Offset, SEEK_SET);
				for (i0 = 0x00, i6 = 0x00; i6 < YSize; i6++)
				{
					for (i2 = 0x00, i5 = 0x00; i5 < XSize; i5++)
					{
						if (i2 == 0x00)
						{
							i2 = fgetc (Bitmap) & 0xFF;
							i1 = ((i2 >> 0x04) & 0x0F) * 0x04;
							i2 |= 0xF0;
						}
						else
						{
							i1 = (i2 & 0x0F) * 0x04;
							i2 = 0x00;
						}
						Memory [i0++] = Palette [i1++];
						Memory [i0++] = Palette [i1++];
						Memory [i0++] = Palette [i1++];
						Memory [i0++] = Palette [i1++];
					}
					fseek (Bitmap, (0x04 - ((ftell (Bitmap) - Offset) & 0x03)) & 0x03, SEEK_CUR);
				}
			}
			break;

// -----------------------------------------------------------------------------
// 256 colour format (this is 8 bit with a palette of 256 colours)
// -----------------------------------------------------------------------------

			case 8:
			{
				fseek (Bitmap, 0x36, SEEK_SET);
				for (i0 = 0x00, i1 = 0x00; i0 < 256; i0++)
				{
					Palette [i1++] = fgetc (Bitmap);
					Palette [i1++] = fgetc (Bitmap);
					Palette [i1++] = fgetc (Bitmap);
					Palette [i1++] = fgetc (Bitmap);
				}
				fseek (Bitmap, Offset, SEEK_SET);
				for (i0 = 0x00, i6 = 0x00; i6 < YSize; i6++)
				{
					for (i5 = 0x00; i5 < XSize; i5++)
					{
						i1 = (fgetc (Bitmap) & 0xFF) * 0x04;
						Memory [i0++] = Palette [i1++];
						Memory [i0++] = Palette [i1++];
						Memory [i0++] = Palette [i1++];
						Memory [i0++] = Palette [i1++];
					}
					fseek (Bitmap, (0x04 - ((ftell (Bitmap) - Offset) & 0x03)) & 0x03, SEEK_CUR);
				}
			}
			break;

// -----------------------------------------------------------------------------
// 24 bit format
// -----------------------------------------------------------------------------

			case 24:
			{
				fseek (Bitmap, Offset, SEEK_SET);
				for (i0 = 0x00, i6 = 0x00; i6 < YSize; i6++)
				{
					for (i5 = 0x00; i5 < XSize; i5++)
					{
						Memory [i0++] = fgetc (Bitmap) & 0xFF;
						Memory [i0++] = fgetc (Bitmap) & 0xFF;
						Memory [i0++] = fgetc (Bitmap) & 0xFF;
						Memory [i0++] = 0x00;
					}
					fseek (Bitmap, (0x04 - ((ftell (Bitmap) - Offset) & 0x03)) & 0x03, SEEK_CUR);
				}
			}
			break;

// -----------------------------------------------------------------------------
// 32 bit format
// -----------------------------------------------------------------------------

			case 32:
			{
				fseek (Bitmap, Offset, SEEK_SET);
				for (i0 = 0x00, i6 = 0x00; i6 < YSize; i6++)
				{
					for (i5 = 0x00; i5 < XSize; i5++)
					{
						Memory [i0++] = fgetc (Bitmap) & 0xFF;
						Memory [i0++] = fgetc (Bitmap) & 0xFF;
						Memory [i0++] = fgetc (Bitmap) & 0xFF;
						Memory [i0++] = fgetc (Bitmap) & 0xFF;
					}
				}
			}
			break;

// -----------------------------------------------------------------------------
// Unsupported bit formats
// -----------------------------------------------------------------------------

			default:
				fclose (Bitmap);
				return (0x03);
			break;
		}
	}
	fclose (Bitmap);
	return (0x00);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Subroutine to save a bitmap image
// -----------------------------------------------------------------------------
// switch (ImageSave (FileName, Image, ImageSize, ImageXSize, ImageYSize, Imagebpp))
// {
// 	case 0x01: printf ("    Error: the file could not be opened\n"); break;
// 	case 0x03: printf ("    Error: the bpp format \"%d\" isn't currently supported\n", Imagebpp); break;
// 	case 0x00: printf ("    Success\n"); break;
// }
// -----------------------------------------------------------------------------

int ImageSave (char *File, char *&Memory, int MemorySize, int XSize, int YSize, int bpp)

{
	FILE *Bitmap;
	if ((Bitmap = fopen (File, "wb")) == NULL)
	{
		return (0x01);
	}
	int Offset, i0, i1, i2, i3, i4, i5, i6, i7, R1, G1, B1, R2, G2, B2, R3, G3, B3;
	fputs ("BM", Bitmap);
	fseek (Bitmap, 0x0E, SEEK_SET);
	fputc (0x28, Bitmap); fputc (0x00, Bitmap); fputc (0x00, Bitmap); fputc (0x00, Bitmap);
	fputc (XSize, Bitmap); fputc (XSize >> 0x08, Bitmap); fputc (XSize >> 0x10, Bitmap); fputc (XSize >> 0x18, Bitmap);
	fputc (YSize, Bitmap); fputc (YSize >> 0x08, Bitmap); fputc (YSize >> 0x10, Bitmap); fputc (YSize >> 0x18, Bitmap);
	fputc (0x01, Bitmap); fputc (0x00, Bitmap);
	fputc (bpp, Bitmap); fputc (0x00, Bitmap);
	fputc (0x00, Bitmap); fputc (0x00, Bitmap); fputc (0x00, Bitmap); fputc (0x00, Bitmap);
	fseek (Bitmap, 0x04, SEEK_CUR);
	fputc (0x00, Bitmap); fputc (0x00, Bitmap); fputc (0x00, Bitmap); fputc (0x00, Bitmap);
	fputc (0x00, Bitmap); fputc (0x00, Bitmap); fputc (0x00, Bitmap); fputc (0x00, Bitmap);
	fputc (0x00, Bitmap); fputc (0x00, Bitmap); fputc (0x00, Bitmap); fputc (0x00, Bitmap);
	fputc (0x00, Bitmap); fputc (0x00, Bitmap); fputc (0x00, Bitmap); fputc (0x00, Bitmap);
	switch (bpp)
	{

// -----------------------------------------------------------------------------
// 2 colour format (this is 1 bit with a palette of 2 colours)
// -----------------------------------------------------------------------------

		case 1:
		{
			char Palette [2 * 0x04] = {		0x00, 0x00, 0x00, 0x00,  0xFF, 0xFF, 0xFF, 0x00 };
			for (i0 = 0x00; i0 < (2 * 0x04); )
			{
				fputc (Palette [i0++], Bitmap);
				fputc (Palette [i0++], Bitmap);
				fputc (Palette [i0++], Bitmap);
				fputc (Palette [i0++], Bitmap);
			}
			Offset = ftell (Bitmap);
			fseek (Bitmap, 0x0A, SEEK_SET);
			fputc (Offset, Bitmap); fputc (Offset >> 0x08, Bitmap); fputc (Offset >> 0x10, Bitmap); fputc (Offset >> 0x18, Bitmap);
			fseek (Bitmap, Offset, SEEK_SET);
			int ColCur = 0x00, ColFlag = 0x00;
			for (i0 = 0x00, i6 = 0x00; i6 < YSize; i6++)
			{
				for (i5 = 0x00; i5 < XSize; i5++)
				{
					B1 = Memory [i0++] & 0xFF;
					G1 = Memory [i0++] & 0xFF;
					R1 = Memory [i0++] & 0xFF;
					i0++;
					for (i1 = 0x00, i4 = 0x00, i3 = 0x0400; i1 < (2 * 0x04); )
					{
						B2 = Palette [i1++] & 0xFF;
						G2 = Palette [i1++] & 0xFF;
						R2 = Palette [i1++] & 0xFF;
						i1++;
						B3 = B1 - B2; if (B3 < 0x00) { B3 = -B3; }
						G3 = G1 - G2; if (G3 < 0x00) { G3 = -G3; }
						R3 = R1 - R2; if (R3 < 0x00) { R3 = -R3; }
						i2 = B3 + G3 + R3;
						if (i2 < i3)
						{
							i3 = i2;
							i4 = (i1 - 0x04) / 0x04;
						}
					}
					if (ColFlag == 0x00)
					{
						ColCur = i4 & 0x01;
						ColFlag = (ColFlag + 0x01) & 0x07;
					}
					else
					{
						ColCur += ColCur;
						ColCur |= i4 & 0x01;
						ColFlag = (ColFlag + 0x01) & 0x07;
						if (ColFlag == 0x00)
						{
							fputc (ColCur, Bitmap);
						}
					}
				}
				if (ColFlag != 0x00)
				{
					ColCur <<= ((0x08 - ColFlag) & 0x07);
					fputc (ColCur, Bitmap);
					ColFlag = 0x00;
				}
				i1 = ftell (Bitmap) - Offset;
				for (i5 = 0x00; i5 < ((0x04 - (i1 & 0x03)) & 0x03); i5++)
				{
					fputc (0x00, Bitmap);
				}
			}
			i0 = ftell (Bitmap);
			fseek (Bitmap, 0x02, SEEK_SET);
			fputc (i0, Bitmap); fputc (i0 >> 0x08, Bitmap); fputc (i0 >> 0x10, Bitmap); fputc (i0 >> 0x18, Bitmap);
			fseek (Bitmap, 0x22, SEEK_SET);
			i0 -= Offset;
			fputc (i0, Bitmap); fputc (i0 >> 0x08, Bitmap); fputc (i0 >> 0x10, Bitmap); fputc (i0 >> 0x18, Bitmap);
		}
		break;

// -----------------------------------------------------------------------------
// 16 colour format (this is 4 bit with a palette of 16 colours)
// -----------------------------------------------------------------------------

		case 4:
		{
			char Palette [16 * 0x04] = {	0x00, 0x00, 0x00, 0x00,  0x00, 0x00, 0x80, 0x00,  0x00, 0x80, 0x00, 0x00,  0x00, 0x80, 0x80, 0x00,
											0x80, 0x00, 0x00, 0x00,  0x80, 0x00, 0x80, 0x00,  0x80, 0x80, 0x00, 0x00,  0x80, 0x80, 0x80, 0x00,
											0xC0, 0xC0, 0xC0, 0x00,  0x00, 0x00, 0xFF, 0x00,  0x00, 0xFF, 0x00, 0x00,  0x00, 0xFF, 0xFF, 0x00,
											0xFF, 0x00, 0x00, 0x00,  0xFF, 0x00, 0xFF, 0x00,  0xFF, 0xFF, 0x00, 0x00,  0xFF, 0xFF, 0xFF, 0x00 };

			for (i0 = 0x00; i0 < (16 * 0x04); )
			{
				fputc (Palette [i0++], Bitmap);
				fputc (Palette [i0++], Bitmap);
				fputc (Palette [i0++], Bitmap);
				fputc (Palette [i0++], Bitmap);
			}
			Offset = ftell (Bitmap);
			fseek (Bitmap, 0x0A, SEEK_SET);
			fputc (Offset, Bitmap); fputc (Offset >> 0x08, Bitmap); fputc (Offset >> 0x10, Bitmap); fputc (Offset >> 0x18, Bitmap);
			fseek (Bitmap, Offset, SEEK_SET);
			int ColCur = 0x00, ColFlag = 0x00;
			for (i0 = 0x00, i6 = 0x00; i6 < YSize; i6++)
			{
				for (i5 = 0x00; i5 < XSize; i5++)
				{
					B1 = Memory [i0++] & 0xFF;
					G1 = Memory [i0++] & 0xFF;
					R1 = Memory [i0++] & 0xFF;
					i0++;
					for (i1 = 0x00, i4 = 0x00, i3 = 0x0400; i1 < (16 * 0x04); )
					{
						B2 = Palette [i1++] & 0xFF;
						G2 = Palette [i1++] & 0xFF;
						R2 = Palette [i1++] & 0xFF;
						i1++;
						B3 = B1 - B2; if (B3 < 0x00) { B3 = -B3; }
						G3 = G1 - G2; if (G3 < 0x00) { G3 = -G3; }
						R3 = R1 - R2; if (R3 < 0x00) { R3 = -R3; }
						i2 = B3 + G3 + R3;
						if (i2 < i3)
						{
							i3 = i2;
							i4 = (i1 - 0x04) / 0x04;
						}
					}
					if (ColFlag == 0x00)
					{
						ColCur = (i4 << 0x04) & 0xF0;
						ColFlag++;
					}
					else
					{
						ColCur |= i4 & 0x0F;
						fputc (ColCur, Bitmap);
						ColFlag--;
					}
				}
				if (ColFlag != 0x00)
				{
					fputc (ColCur, Bitmap);
					ColFlag--;
				}
				i1 = ftell (Bitmap) - Offset;
				for (i5 = 0x00; i5 < ((0x04 - (i1 & 0x03)) & 0x03); i5++)
				{
					fputc (0x00, Bitmap);
				}
			}
			i0 = ftell (Bitmap);
			fseek (Bitmap, 0x02, SEEK_SET);
			fputc (i0, Bitmap); fputc (i0 >> 0x08, Bitmap); fputc (i0 >> 0x10, Bitmap); fputc (i0 >> 0x18, Bitmap);
			fseek (Bitmap, 0x22, SEEK_SET);
			i0 -= Offset;
			fputc (i0, Bitmap); fputc (i0 >> 0x08, Bitmap); fputc (i0 >> 0x10, Bitmap); fputc (i0 >> 0x18, Bitmap);
		}
		break;

// -----------------------------------------------------------------------------
// 256 colour format (this is 8 bit with a palette of 256 colours)
// -----------------------------------------------------------------------------

		case 8:
		{
			char Palette [256 * 0x04] = {	0x00, 0x00, 0x00, 0x00,  0x00, 0x00, 0x80, 0x00,  0x00, 0x80, 0x00, 0x00,  0x00, 0x80, 0x80, 0x00,
											0x80, 0x00, 0x00, 0x00,  0x80, 0x00, 0x80, 0x00,  0x80, 0x80, 0x00, 0x00,  0xC0, 0xC0, 0xC0, 0x00,
											0xC0, 0xDC, 0xC0, 0x00,  0xF0, 0xCA, 0xA6, 0x00,  0x00, 0x20, 0x40, 0x00,  0x00, 0x20, 0x60, 0x00,
											0x00, 0x20, 0x80, 0x00,  0x00, 0x20, 0xA0, 0x00,  0x00, 0x20, 0xC0, 0x00,  0x00, 0x20, 0xE0, 0x00,
											0x00, 0x40, 0x00, 0x00,  0x00, 0x40, 0x20, 0x00,  0x00, 0x40, 0x40, 0x00,  0x00, 0x40, 0x60, 0x00,
											0x00, 0x40, 0x80, 0x00,  0x00, 0x40, 0xA0, 0x00,  0x00, 0x40, 0xC0, 0x00,  0x00, 0x40, 0xE0, 0x00,
											0x00, 0x60, 0x00, 0x00,  0x00, 0x60, 0x20, 0x00,  0x00, 0x60, 0x40, 0x00,  0x00, 0x60, 0x60, 0x00,
											0x00, 0x60, 0x80, 0x00,  0x00, 0x60, 0xA0, 0x00,  0x00, 0x60, 0xC0, 0x00,  0x00, 0x60, 0xE0, 0x00,
											0x00, 0x80, 0x00, 0x00,  0x00, 0x80, 0x20, 0x00,  0x00, 0x80, 0x40, 0x00,  0x00, 0x80, 0x60, 0x00,
											0x00, 0x80, 0x80, 0x00,  0x00, 0x80, 0xA0, 0x00,  0x00, 0x80, 0xC0, 0x00,  0x00, 0x80, 0xE0, 0x00,
											0x00, 0xA0, 0x00, 0x00,  0x00, 0xA0, 0x20, 0x00,  0x00, 0xA0, 0x40, 0x00,  0x00, 0xA0, 0x60, 0x00,
											0x00, 0xA0, 0x80, 0x00,  0x00, 0xA0, 0xA0, 0x00,  0x00, 0xA0, 0xC0, 0x00,  0x00, 0xA0, 0xE0, 0x00,
											0x00, 0xC0, 0x00, 0x00,  0x00, 0xC0, 0x20, 0x00,  0x00, 0xC0, 0x40, 0x00,  0x00, 0xC0, 0x60, 0x00,
											0x00, 0xC0, 0x80, 0x00,  0x00, 0xC0, 0xA0, 0x00,  0x00, 0xC0, 0xC0, 0x00,  0x00, 0xC0, 0xE0, 0x00,
											0x00, 0xE0, 0x00, 0x00,  0x00, 0xE0, 0x20, 0x00,  0x00, 0xE0, 0x40, 0x00,  0x00, 0xE0, 0x60, 0x00,
											0x00, 0xE0, 0x80, 0x00,  0x00, 0xE0, 0xA0, 0x00,  0x00, 0xE0, 0xC0, 0x00,  0x00, 0xE0, 0xE0, 0x00,
											0x40, 0x00, 0x00, 0x00,  0x40, 0x00, 0x20, 0x00,  0x40, 0x00, 0x40, 0x00,  0x40, 0x00, 0x60, 0x00,
											0x40, 0x00, 0x80, 0x00,  0x40, 0x00, 0xA0, 0x00,  0x40, 0x00, 0xC0, 0x00,  0x40, 0x00, 0xE0, 0x00,
											0x40, 0x20, 0x00, 0x00,  0x40, 0x20, 0x20, 0x00,  0x40, 0x20, 0x40, 0x00,  0x40, 0x20, 0x60, 0x00,
											0x40, 0x20, 0x80, 0x00,  0x40, 0x20, 0xA0, 0x00,  0x40, 0x20, 0xC0, 0x00,  0x40, 0x20, 0xE0, 0x00,
											0x40, 0x40, 0x00, 0x00,  0x40, 0x40, 0x20, 0x00,  0x40, 0x40, 0x40, 0x00,  0x40, 0x40, 0x60, 0x00,
											0x40, 0x40, 0x80, 0x00,  0x40, 0x40, 0xA0, 0x00,  0x40, 0x40, 0xC0, 0x00,  0x40, 0x40, 0xE0, 0x00,
											0x40, 0x60, 0x00, 0x00,  0x40, 0x60, 0x20, 0x00,  0x40, 0x60, 0x40, 0x00,  0x40, 0x60, 0x60, 0x00,
											0x40, 0x60, 0x80, 0x00,  0x40, 0x60, 0xA0, 0x00,  0x40, 0x60, 0xC0, 0x00,  0x40, 0x60, 0xE0, 0x00,
											0x40, 0x80, 0x00, 0x00,  0x40, 0x80, 0x20, 0x00,  0x40, 0x80, 0x40, 0x00,  0x40, 0x80, 0x60, 0x00,
											0x40, 0x80, 0x80, 0x00,  0x40, 0x80, 0xA0, 0x00,  0x40, 0x80, 0xC0, 0x00,  0x40, 0x80, 0xE0, 0x00,
											0x40, 0xA0, 0x00, 0x00,  0x40, 0xA0, 0x20, 0x00,  0x40, 0xA0, 0x40, 0x00,  0x40, 0xA0, 0x60, 0x00,
											0x40, 0xA0, 0x80, 0x00,  0x40, 0xA0, 0xA0, 0x00,  0x40, 0xA0, 0xC0, 0x00,  0x40, 0xA0, 0xE0, 0x00,
											0x40, 0xC0, 0x00, 0x00,  0x40, 0xC0, 0x20, 0x00,  0x40, 0xC0, 0x40, 0x00,  0x40, 0xC0, 0x60, 0x00,
											0x40, 0xC0, 0x80, 0x00,  0x40, 0xC0, 0xA0, 0x00,  0x40, 0xC0, 0xC0, 0x00,  0x40, 0xC0, 0xE0, 0x00,
											0x40, 0xE0, 0x00, 0x00,  0x40, 0xE0, 0x20, 0x00,  0x40, 0xE0, 0x40, 0x00,  0x40, 0xE0, 0x60, 0x00,
											0x40, 0xE0, 0x80, 0x00,  0x40, 0xE0, 0xA0, 0x00,  0x40, 0xE0, 0xC0, 0x00,  0x40, 0xE0, 0xE0, 0x00,
											0x80, 0x00, 0x00, 0x00,  0x80, 0x00, 0x20, 0x00,  0x80, 0x00, 0x40, 0x00,  0x80, 0x00, 0x60, 0x00,
											0x80, 0x00, 0x80, 0x00,  0x80, 0x00, 0xA0, 0x00,  0x80, 0x00, 0xC0, 0x00,  0x80, 0x00, 0xE0, 0x00,
											0x80, 0x20, 0x00, 0x00,  0x80, 0x20, 0x20, 0x00,  0x80, 0x20, 0x40, 0x00,  0x80, 0x20, 0x60, 0x00,
											0x80, 0x20, 0x80, 0x00,  0x80, 0x20, 0xA0, 0x00,  0x80, 0x20, 0xC0, 0x00,  0x80, 0x20, 0xE0, 0x00,
											0x80, 0x40, 0x00, 0x00,  0x80, 0x40, 0x20, 0x00,  0x80, 0x40, 0x40, 0x00,  0x80, 0x40, 0x60, 0x00,
											0x80, 0x40, 0x80, 0x00,  0x80, 0x40, 0xA0, 0x00,  0x80, 0x40, 0xC0, 0x00,  0x80, 0x40, 0xE0, 0x00,
											0x80, 0x60, 0x00, 0x00,  0x80, 0x60, 0x20, 0x00,  0x80, 0x60, 0x40, 0x00,  0x80, 0x60, 0x60, 0x00,
											0x80, 0x60, 0x80, 0x00,  0x80, 0x60, 0xA0, 0x00,  0x80, 0x60, 0xC0, 0x00,  0x80, 0x60, 0xE0, 0x00,
											0x80, 0x80, 0x00, 0x00,  0x80, 0x80, 0x20, 0x00,  0x80, 0x80, 0x40, 0x00,  0x80, 0x80, 0x60, 0x00,
											0x80, 0x80, 0x80, 0x00,  0x80, 0x80, 0xA0, 0x00,  0x80, 0x80, 0xC0, 0x00,  0x80, 0x80, 0xE0, 0x00,
											0x80, 0xA0, 0x00, 0x00,  0x80, 0xA0, 0x20, 0x00,  0x80, 0xA0, 0x40, 0x00,  0x80, 0xA0, 0x60, 0x00,
											0x80, 0xA0, 0x80, 0x00,  0x80, 0xA0, 0xA0, 0x00,  0x80, 0xA0, 0xC0, 0x00,  0x80, 0xA0, 0xE0, 0x00,
											0x80, 0xC0, 0x00, 0x00,  0x80, 0xC0, 0x20, 0x00,  0x80, 0xC0, 0x40, 0x00,  0x80, 0xC0, 0x60, 0x00,
											0x80, 0xC0, 0x80, 0x00,  0x80, 0xC0, 0xA0, 0x00,  0x80, 0xC0, 0xC0, 0x00,  0x80, 0xC0, 0xE0, 0x00,
											0x80, 0xE0, 0x00, 0x00,  0x80, 0xE0, 0x20, 0x00,  0x80, 0xE0, 0x40, 0x00,  0x80, 0xE0, 0x60, 0x00,
											0x80, 0xE0, 0x80, 0x00,  0x80, 0xE0, 0xA0, 0x00,  0x80, 0xE0, 0xC0, 0x00,  0x80, 0xE0, 0xE0, 0x00,
											0xC0, 0x00, 0x00, 0x00,  0xC0, 0x00, 0x20, 0x00,  0xC0, 0x00, 0x40, 0x00,  0xC0, 0x00, 0x60, 0x00,
											0xC0, 0x00, 0x80, 0x00,  0xC0, 0x00, 0xA0, 0x00,  0xC0, 0x00, 0xC0, 0x00,  0xC0, 0x00, 0xE0, 0x00,
											0xC0, 0x20, 0x00, 0x00,  0xC0, 0x20, 0x20, 0x00,  0xC0, 0x20, 0x40, 0x00,  0xC0, 0x20, 0x60, 0x00,
											0xC0, 0x20, 0x80, 0x00,  0xC0, 0x20, 0xA0, 0x00,  0xC0, 0x20, 0xC0, 0x00,  0xC0, 0x20, 0xE0, 0x00,
											0xC0, 0x40, 0x00, 0x00,  0xC0, 0x40, 0x20, 0x00,  0xC0, 0x40, 0x40, 0x00,  0xC0, 0x40, 0x60, 0x00,
											0xC0, 0x40, 0x80, 0x00,  0xC0, 0x40, 0xA0, 0x00,  0xC0, 0x40, 0xC0, 0x00,  0xC0, 0x40, 0xE0, 0x00,
											0xC0, 0x60, 0x00, 0x00,  0xC0, 0x60, 0x20, 0x00,  0xC0, 0x60, 0x40, 0x00,  0xC0, 0x60, 0x60, 0x00,
											0xC0, 0x60, 0x80, 0x00,  0xC0, 0x60, 0xA0, 0x00,  0xC0, 0x60, 0xC0, 0x00,  0xC0, 0x60, 0xE0, 0x00,
											0xC0, 0x80, 0x00, 0x00,  0xC0, 0x80, 0x20, 0x00,  0xC0, 0x80, 0x40, 0x00,  0xC0, 0x80, 0x60, 0x00,
											0xC0, 0x80, 0x80, 0x00,  0xC0, 0x80, 0xA0, 0x00,  0xC0, 0x80, 0xC0, 0x00,  0xC0, 0x80, 0xE0, 0x00,
											0xC0, 0xA0, 0x00, 0x00,  0xC0, 0xA0, 0x20, 0x00,  0xC0, 0xA0, 0x40, 0x00,  0xC0, 0xA0, 0x60, 0x00,
											0xC0, 0xA0, 0x80, 0x00,  0xC0, 0xA0, 0xA0, 0x00,  0xC0, 0xA0, 0xC0, 0x00,  0xC0, 0xA0, 0xE0, 0x00,
											0xC0, 0xC0, 0x00, 0x00,  0xC0, 0xC0, 0x20, 0x00,  0xC0, 0xC0, 0x40, 0x00,  0xC0, 0xC0, 0x60, 0x00,
											0xC0, 0xC0, 0x80, 0x00,  0xC0, 0xC0, 0xA0, 0x00,  0xF0, 0xFB, 0xFF, 0x00,  0xA4, 0xA0, 0xA0, 0x00,
											0x80, 0x80, 0x80, 0x00,  0x00, 0x00, 0xFF, 0x00,  0x00, 0xFF, 0x00, 0x00,  0x00, 0xFF, 0xFF, 0x00,
											0xFF, 0x00, 0x00, 0x00,  0xFF, 0x00, 0xFF, 0x00,  0xFF, 0xFF, 0x00, 0x00,  0xFF, 0xFF, 0xFF, 0x00	};

			for (i0 = 0x00; i0 < (256 * 0x04); )
			{
				fputc (Palette [i0++], Bitmap);
				fputc (Palette [i0++], Bitmap);
				fputc (Palette [i0++], Bitmap);
				fputc (Palette [i0++], Bitmap);
			}
			Offset = ftell (Bitmap);
			fseek (Bitmap, 0x0A, SEEK_SET);
			fputc (Offset, Bitmap); fputc (Offset >> 0x08, Bitmap); fputc (Offset >> 0x10, Bitmap); fputc (Offset >> 0x18, Bitmap);
			fseek (Bitmap, Offset, SEEK_SET);
			for (i0 = 0x00, i6 = 0x00; i6 < YSize; i6++)
			{
				for (i5 = 0x00; i5 < XSize; i5++)
				{
					B1 = Memory [i0++] & 0xFF;
					G1 = Memory [i0++] & 0xFF;
					R1 = Memory [i0++] & 0xFF;
					i0++;
					for (i1 = 0x00, i4 = 0x00, i3 = 0x0400; i1 < (256 * 0x04); )
					{
						B2 = Palette [i1++] & 0xFF;
						G2 = Palette [i1++] & 0xFF;
						R2 = Palette [i1++] & 0xFF;
						i1++;
						B3 = B1 - B2; if (B3 < 0x00) { B3 = -B3; }
						G3 = G1 - G2; if (G3 < 0x00) { G3 = -G3; }
						R3 = R1 - R2; if (R3 < 0x00) { R3 = -R3; }
						i2 = B3 + G3 + R3;
						if (i2 < i3)
						{
							i3 = i2;
							i4 = (i1 - 0x04) / 0x04;
						}
					}
					fputc (i4, Bitmap);
				}
				i1 = ftell (Bitmap) - Offset;
				for (i5 = 0x00; i5 < ((0x04 - (i1 & 0x03)) & 0x03); i5++)
				{
					fputc (0x00, Bitmap);
				}
			}
			i0 = ftell (Bitmap);
			fseek (Bitmap, 0x02, SEEK_SET);
			fputc (i0, Bitmap); fputc (i0 >> 0x08, Bitmap); fputc (i0 >> 0x10, Bitmap); fputc (i0 >> 0x18, Bitmap);
			fseek (Bitmap, 0x22, SEEK_SET);
			i0 -= Offset;
			fputc (i0, Bitmap); fputc (i0 >> 0x08, Bitmap); fputc (i0 >> 0x10, Bitmap); fputc (i0 >> 0x18, Bitmap);
		}
		break;

// -----------------------------------------------------------------------------
// 24 bit format
// -----------------------------------------------------------------------------

		case 24:
		{
			Offset = ftell (Bitmap);
			fseek (Bitmap, 0x0A, SEEK_SET);
			fputc (Offset, Bitmap); fputc (Offset >> 0x08, Bitmap); fputc (Offset >> 0x10, Bitmap); fputc (Offset >> 0x18, Bitmap);
			fseek (Bitmap, Offset, SEEK_SET);
			for (i0 = 0x00, i6 = 0x00; i6 < YSize; i6++)
			{
				for (i5 = 0x00; i5 < XSize; i5++)
				{
					fputc (Memory [i0++], Bitmap);
					fputc (Memory [i0++], Bitmap);
					fputc (Memory [i0++], Bitmap);
					i0++;
				}
				i1 = ftell (Bitmap) - Offset;
				for (i5 = 0x00; i5 < ((0x04 - (i1 & 0x03)) & 0x03); i5++)
				{
					fputc (0x00, Bitmap);
				}
			}
			i0 = ftell (Bitmap);
			fseek (Bitmap, 0x02, SEEK_SET);
			fputc (i0, Bitmap); fputc (i0 >> 0x08, Bitmap); fputc (i0 >> 0x10, Bitmap); fputc (i0 >> 0x18, Bitmap);
			fseek (Bitmap, 0x22, SEEK_SET);
			i0 -= Offset;
			fputc (i0, Bitmap); fputc (i0 >> 0x08, Bitmap); fputc (i0 >> 0x10, Bitmap); fputc (i0 >> 0x18, Bitmap);
		}
		break;

// -----------------------------------------------------------------------------
// 32 bit format
// -----------------------------------------------------------------------------

		case 32:
		{
			Offset = ftell (Bitmap);
			fseek (Bitmap, 0x0A, SEEK_SET);
			fputc (Offset, Bitmap); fputc (Offset >> 0x08, Bitmap); fputc (Offset >> 0x10, Bitmap); fputc (Offset >> 0x18, Bitmap);
			fseek (Bitmap, Offset, SEEK_SET);
			for (i0 = 0x00, i6 = 0x00; i6 < YSize; i6++)
			{
				for (i5 = 0x00; i5 < XSize; i5++)
				{
					fputc (Memory [i0++], Bitmap);
					fputc (Memory [i0++], Bitmap);
					fputc (Memory [i0++], Bitmap);
					fputc (Memory [i0++], Bitmap);
				}
			}
			i0 = ftell (Bitmap);
			fseek (Bitmap, 0x02, SEEK_SET);
			fputc (i0, Bitmap); fputc (i0 >> 0x08, Bitmap); fputc (i0 >> 0x10, Bitmap); fputc (i0 >> 0x18, Bitmap);
			fseek (Bitmap, 0x22, SEEK_SET);
			i0 -= Offset;
			fputc (i0, Bitmap); fputc (i0 >> 0x08, Bitmap); fputc (i0 >> 0x10, Bitmap); fputc (i0 >> 0x18, Bitmap);
		}
		break;

// -----------------------------------------------------------------------------
// Unsupported bit formats
// -----------------------------------------------------------------------------

		default:
			fclose (Bitmap);
			return (0x03);
		break;
	}
	fclose (Bitmap);
	return (0x00);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Subroutine to crop an image
// -----------------------------------------------------------------------------
// switch (CropImage (Image, ImageSize, ImageXSize, ImageYSize, NewXPos, NewYPos, NewXRange, NewYRange, PadColour))
// {
//	case 0x04: printf ("    Error: memory could not be allocated\n"); break;
//	case 0x05: printf ("    Error: Crop/Resize coordinates result in no image\n"); break;
// 	case 0x00: printf ("    Success\n"); break;
// }
// -----------------------------------------------------------------------------

int CropImage (char *&Memory, int &MemorySize, int &XSize, int &YSize, int Left, int Up, int Right, int Down, int PadColour)

{
	int i0, i1, i2, i3, i4, i5, i6, i7;
	if (Left >= Right || Up >= Down)
	{
		return (0x05);
	}
	if ((i0 = Left) < 0x00)
	{
		i0 = -i0;
	}
	i0 += Right;
	if ((i1 = Up) < 0x00)
	{
		i1 = -i1;
	}
	i1 += Down;
	char *MemoryAlt = NULL; int MemoryAltSize, MemoryAltLoc;
	if ((AllocChar (MemoryAlt, MemoryAltSize = 0x00, (i0 * 0x04) * i1)) != 0x00)
	{
		return (0x04);
	}
	int LeftX = 0x00, CopyX = XSize, RightX = 0x00;
	int SkipLeft = 0x00, SkipRight = 0x00;
	int UpY = 0x00, CopyY = YSize, DownY = 0x00;
	int SkipUp = 0x00, SkipDown = 0x00;
	if (Left < 0x00)
	{
		LeftX = -Left;
	}
	else
	{
		CopyX -= Left;
		SkipLeft = Left;
	}
	if (Right > XSize)
	{
		RightX = Right - XSize;
	}
	else
	{
		CopyX -= XSize - Right;
		SkipRight = XSize - Right;
	}
	if (Up < 0x00)
	{
		UpY = -Up;
	}
	else
	{
		CopyY -= Up;
		SkipUp = Up;
	}
	if (Down > YSize)
	{
		DownY = Down - YSize;
	}
	else
	{
		CopyY -= YSize - Down;
		SkipDown = YSize - Down;
	}
	MemoryAltLoc = 0x00, i0 = 0x00;
	for (i7 = DownY; i7 != 0x00; i7--)
	{
		for (i6 = (LeftX + CopyX + RightX); i6 != 0x00; i6--)
		{
			MemoryAlt [MemoryAltLoc++] = PadColour >> 0x18;
			MemoryAlt [MemoryAltLoc++] = PadColour >> 0x10;
			MemoryAlt [MemoryAltLoc++] = PadColour >> 0x08;
			MemoryAlt [MemoryAltLoc++] = PadColour >> 0x00;
		}
	}
	i0 += SkipDown * (XSize * 0x04);
	for (i7 = CopyY; i7 != 0x00; i7--)
	{
		for (i6 = LeftX; i6 != 0x00; i6--)
		{
			MemoryAlt [MemoryAltLoc++] = PadColour >> 0x18;
			MemoryAlt [MemoryAltLoc++] = PadColour >> 0x10;
			MemoryAlt [MemoryAltLoc++] = PadColour >> 0x08;
			MemoryAlt [MemoryAltLoc++] = PadColour >> 0x00;
		}
		i0 += SkipLeft * 0x04;
		for (i6 = CopyX; i6 != 0x00; i6--)
		{
			MemoryAlt [MemoryAltLoc++] = Memory [i0++];
			MemoryAlt [MemoryAltLoc++] = Memory [i0++];
			MemoryAlt [MemoryAltLoc++] = Memory [i0++];
			MemoryAlt [MemoryAltLoc++] = Memory [i0++];
		}
		i0 += SkipRight * 0x04;
		for (i6 = RightX; i6 != 0x00; i6--)
		{
			MemoryAlt [MemoryAltLoc++] = PadColour >> 0x18;
			MemoryAlt [MemoryAltLoc++] = PadColour >> 0x10;
			MemoryAlt [MemoryAltLoc++] = PadColour >> 0x08;
			MemoryAlt [MemoryAltLoc++] = PadColour >> 0x00;
		}
	}
	i0 += SkipUp * (XSize * 0x04);
	for (i7 = UpY; i7 != 0x00; i7--)
	{
		for (i6 = (LeftX + CopyX + RightX); i6 != 0x00; i6--)
		{
			MemoryAlt [MemoryAltLoc++] = PadColour >> 0x18;
			MemoryAlt [MemoryAltLoc++] = PadColour >> 0x10;
			MemoryAlt [MemoryAltLoc++] = PadColour >> 0x08;
			MemoryAlt [MemoryAltLoc++] = PadColour >> 0x00;
		}
	}
	free (Memory);
	Memory = MemoryAlt;
	MemorySize = MemoryAltSize;
	XSize = LeftX + CopyX + RightX;
	YSize = UpY + CopyY + DownY;
	return (0x00);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Subroutine to resize an image by stretching or shrinking it
// -----------------------------------------------------------------------------
// switch (ResizeImage (Image, ImageSize, ImageXSize, ImageYSize, NewXSize, NewYSize))
// {
//	case 0x04: printf ("    Error: memory could not be allocated\n"); break;
//	case 0x05: printf ("    Error: Crop/Resize coordinates result in no image\n"); break;
// 	case 0x00: printf ("    Success\n"); break;
// }
// -----------------------------------------------------------------------------

int ResizeImage (char *&Memory, int &MemorySize, int &XSize, int &YSize, int NewXSize, int NewYSize)

{
	int i0, i1, i2, i3, i4, i5, i6, i7;
	i6 = (XSize + 0x01) << 0x08;
	if (NewXSize <= 0x00)
	{
		return (0x05);
	}
	i6 /= NewXSize;
	i7 = (YSize + 0x01) << 0x08;
	if (NewYSize <= 0x00)
	{
		return (0x05);
	}
	i7 /= NewYSize;
	char *MemoryAlt = NULL; int MemoryAltSize, MemoryAltLoc;
	if ((AllocChar (MemoryAlt, MemoryAltSize = 0x00, (NewXSize * 0x04) * NewYSize)) != 0x00)
	{
		return (0x04);
	}
	for (i4 = 0x00, MemoryAltLoc = 0x00, i3 = NewYSize; i3 != 0x00; i3--)
	{
		i5 = ((i4 & 0xFFFFFF00) * XSize);
		i4 += i7;
		for (i2 = NewXSize; i2 != 0x00; i2--)
		{
			MemoryAlt [MemoryAltLoc++] = Memory [((i5 >> 0x08) & 0xFFFFFF) * 0x04];
			MemoryAlt [MemoryAltLoc++] = Memory [(((i5 >> 0x08) & 0xFFFFFF) * 0x04) + 0x01];
			MemoryAlt [MemoryAltLoc++] = Memory [(((i5 >> 0x08) & 0xFFFFFF) * 0x04) + 0x02];
			MemoryAlt [MemoryAltLoc++] = Memory [(((i5 >> 0x08) & 0xFFFFFF) * 0x04) + 0x03];
			i5 += i6;
		}
	}
	free (Memory);
	Memory = MemoryAlt;
	MemorySize = MemoryAltSize;
	XSize = NewXSize;
	YSize = NewYSize;
	return (0x00);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Subroutine to resize an image by stretching or shrinking it
// -----------------------------------------------------------------------------
// switch (ResizeImage (Image, ImageXSize, ImageYSize))
// {
//	case 0x04: printf ("    Error: memory could not be allocated\n"); break;
//	case 0x05: printf ("    Error: Crop/Resize coordinates result in no image\n"); break;
// 	case 0x00: printf ("    Success\n"); break;
// }
// -----------------------------------------------------------------------------

int FlipImage (char *&Memory, int &XSize, int &YSize)

{
	int i0, i1, i2, i3, i4, i5, i6, i7;
	for (i0 = 0x00, i2 = YSize - 0x01; i0 < (YSize / 0x02); i0++, i2--)
	{
		for (i1 = 0x00; i1 < XSize; i1++)
		{
			i3 = (i0 * (XSize * 0x04)) + (i1 * 0x04);
			i4 = (i2 * (XSize * 0x04)) + (i1 * 0x04);
			i5 = Memory [i3];
			Memory [i3++] = Memory [i4];
			Memory [i4++] = i5;
			i5 = Memory [i3];
			Memory [i3++] = Memory [i4];
			Memory [i4++] = i5;
			i5 = Memory [i3];
			Memory [i3++] = Memory [i4];
			Memory [i4++] = i5;
			i5 = Memory [i3];
			Memory [i3++] = Memory [i4];
			Memory [i4++] = i5;
		}
	}
}

// =============================================================================











