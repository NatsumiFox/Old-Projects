// ==========================================================================
// --------------------------------------------------------------------------
// Checksum Fixer
// --------------------------------------------------------------------------

#include <stdio.h>
#include <windows.h>

int main (int ArgNumber, char **ArgList, char **EnvList)

{
	if (ArgNumber <= 0x01)
	{
		printf ("Checksum Fixer - by MarkeyJester\n\n -> Arguments are: CheckFix.exe Input.bin\n\n    This tool will correctly generate the right checksum value and ROM size value\n\nPress enter key to exit...\n");
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
				fread (Memory, MemorySize, 0x01, File);

				u_int Sizes [] = {	0x02000, 0x4A, 0x1FF0, 0,
							0X04000, 0X4B, 0x3FF0, 0,
							0x08000, 0x4C, 0x7FF0, 0,
							0x0C000, 0x4D, 0x7FF0, 0,
							0x10000, 0X4E, 0X7FF0, 0,
							0x20000, 0x4F, 0x7FF0, 0,
							0x40000, 0x40, 0x7FF0, 0,
							-1	};

				u_int Entry = 0;
				while (Sizes [Entry] != -1)
				{
					if (Sizes [Entry] >= MemorySize)
					{
						break;
					}
					Entry += 4;
				}
				if (Sizes [Entry] == -1)
				{
					fclose (File);
					free (Memory);
					printf ("CheckFix: Error, the ROM size appears to be too large\n");
					return (0x00);
				}
				int HeaderLoc = Sizes [Entry + 2];

				Memory [HeaderLoc + 0x0F] = Sizes [Entry + 1];

				int MemoryLoc;
				u_short CheckValue = 0, CheckWord;

				for (MemoryLoc = 0; MemoryLoc < MemorySize; MemoryLoc += 0x02)
				{
					if (MemoryLoc != HeaderLoc + 0x0A)
					{
						CheckWord = Memory [MemoryLoc] & 0xFF;
						CheckWord |= Memory [MemoryLoc + 1] << 0x08;
						CheckValue += CheckWord;
					}
				}
				Memory [HeaderLoc + 0x0A] = CheckValue;
				Memory [HeaderLoc + 0x0B] = CheckValue >> 0x08;

				rewind (File);
				fwrite (Memory, MemorySize, 0x01, File);
				fclose (File);
				free (Memory);
			}
		}
	}
	return (0x00);
}

// ==========================================================================
