// ==========================================================================
// --------------------------------------------------------------------------
// Checksum Fixer
// --------------------------------------------------------------------------

#include <stdio.h>
#include <windows.h>

// ==========================================================================
// --------------------------------------------------------------------------
// Subroutine to get an intager from an ASCII string
// --------------------------------------------------------------------------

int GetIntASCII (char *String)

{
	int StringLoc = 0x00;
	int Value = 0x00;
	char Char = '0';
	do
	{
		if (Char >= 'a' && Char <= 'f')
		{
			Char -= 'a' - 'A';
		}
		if (Char > '9')
		{
			Char -= 'A' - ('9' + 0x01);
		}
		Char -= '0';
		Value = (Value << 0x04) | (Char & 0x0F);
		Char = String [StringLoc++];
	}
	while (Char != 0x00);
	return (Value);
}

// ==========================================================================
// --------------------------------------------------------------------------
// Main Routine
// --------------------------------------------------------------------------

int main (int ArgNumber, char **ArgList, char **EnvList)

{
	if (ArgNumber <= 0x03)
	{
		printf ("Checksum Fixer (Long-word) - by MarkeyJester\n\n -> Arguments are: CheckFix.exe Input.bin Offset Counter\n\n    This tool will use the header information of the ROM to correctly\n    generate the right checksum value\n\nPress enter key to exit...\n");
		getchar ( );
	}
	else
	{
		FILE *File;
		if ((File = fopen (ArgList [0x01], "r+b")) == NULL)
		{
			printf ("CheckFix: Error, could not open %s\n", ArgList [0x01]);
		}
		else
		{
			fseek (File, 0x00, SEEK_END);
			int MemorySize = ftell (File);
			rewind (File);
			char *Memory = (char*) malloc (MemorySize);
			if (Memory == NULL)
			{
				fclose (File);
				printf ("CheckFix: Error, not enough memory\n");
			}
			else
			{
				fread (Memory, 0x01, MemorySize, File);

				int MemoryLoc, CheckSize, CheckValue, CheckLong;

				int Offset = GetIntASCII (ArgList [0x02]);
				int Counter = GetIntASCII (ArgList [0x03]);

				CheckSize = (Memory [0x0001A4] & 0xFF) << 0x18;
				CheckSize |= (Memory [0x0001A5] & 0xFF) << 0x10;
				CheckSize |= (Memory [0x0001A6] & 0xFF) << 0x08;
				CheckSize |= Memory [0x0001A7] & 0xFF;
				for (MemoryLoc = CheckSize, CheckValue = 0x00; MemoryLoc > 0x00; )
				{
					if ((MemoryLoc - 0x04) != Offset && (MemoryLoc - 0x04) != Counter)
					{
						CheckLong = (Memory [--MemoryLoc] & 0xFF);
						CheckLong |= (Memory [--MemoryLoc] & 0xFF) << 0x08;
						CheckLong |= (Memory [--MemoryLoc] & 0xFF) << 0x10;
						CheckLong |= (Memory [--MemoryLoc] & 0xFF) << 0x18;
						CheckValue += CheckLong;
					}
					else
					{
						MemoryLoc -= 0x04;
					}
				}

				Memory [Offset++] = CheckValue >> 0x18;
				Memory [Offset++] = CheckValue >> 0x10;
				Memory [Offset++] = CheckValue >> 0x08;
				Memory [Offset++] = CheckValue;

				CheckValue = -CheckValue;

				Memory [Counter++] = CheckValue >> 0x18;
				Memory [Counter++] = CheckValue >> 0x10;
				Memory [Counter++] = CheckValue >> 0x08;
				Memory [Counter++] = CheckValue;

				rewind (File);
				fwrite (Memory, 0x01, MemorySize, File);
				fclose (File);
				free (Memory);
			}
		}
	}
	return (0x00);
}

// ==========================================================================
