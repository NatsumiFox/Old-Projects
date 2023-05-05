// =============================================================================
// -----------------------------------------------------------------------------
// Sine Wave generator
// -----------------------------------------------------------------------------

#include <math.h>
#include <stdio.h>

main ( )

{
	int Volume	= 0x000001FF; // How high and low the sine wave has to get to befor going back (radius)
	int Pitch	= 0x00000000; // Distance of waves together (format is MMMMDDDD, where D is the decimal place)
	int Size	= 0x00000400; // number of entires of the sinewave
	int Data	= 0x02; // byte 01, word 02, long-word 04

// -----------------------------------------------------------------------------
// Loading the data to a buffer
// -----------------------------------------------------------------------------

	char SineWave [Size * Data];
	int Counter, SinePos, Value;
	for (Counter = 0x00, SinePos = 0x00; Counter < (Size * Data); Counter++, SinePos += (0x00010000 + Pitch))
	{
		Value = Volume * sin (((SinePos >> 0x10) & 0xFFFF) * 0x02 * 3.14159265358979323846 / Size);
		switch (Data)
		{
			case 0x01:
			{
				SineWave [Counter] = Value;
			}
			break;
			case 0x02:
			{
				SineWave [Counter++] = Value >> 0x08;
				SineWave [Counter] = Value;
			}
			break;
			case 0x04:
			{
				SineWave [Counter++] = Value >> 0x18;
				SineWave [Counter++] = Value >> 0x10;
				SineWave [Counter++] = Value >> 0x08;
				SineWave [Counter] = Value;
			}
			break;
		}
	}

// -----------------------------------------------------------------------------
// Dumping it to a file
// -----------------------------------------------------------------------------

	FILE *File;
	if ((File = fopen ("Sinewave.bin", "wb")) == NULL)
	{
		printf ("Could not open file\n");
	}
	else
	{
		for (Counter = 0x00; Counter < (Size * Data); Counter++)
		{
			fputc (SineWave [Counter], File);
		}
		fclose (File);
	}
	printf ("Press enter key to exit...\n");
	fflush (stdin);
	getc (stdin);
	return 0;
}

// =============================================================================
