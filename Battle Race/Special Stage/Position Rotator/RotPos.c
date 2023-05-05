// =============================================================================
// -----------------------------------------------------------------------------
// Program
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <windows.h>

int main (int ArgNumber, char **ArgList, char **EnvList)

{
	FILE *File = fopen ("PosData.txt", "r");
	if (File == NULL)
	{
		printf ("PosData.txt missing...\n"); fflush (stdin); getchar ( );
		return (0x00);
	}
	FILE *Out = fopen ("OutData.txt", "w");
	u_char Byte;
	char X, Y;
	u_char Text [0x1000];
	int Count;
	for (Count = 0; Count < 4; Count++)
	{
		fseek (File, 0x00, SEEK_SET);
		if (fgets ((char*) Text, 0x1000, File) == NULL)
		{
			break;
		}
		int Pos = 0;
		while (Text [Pos] != 0x00)
		{
			if (Text [Pos++] == '_')
			{
				switch (Count)
				{
					case 0x01: Text [Pos] = 'B'; break;
					case 0x02: Text [Pos] = 'C'; break;
					case 0x03: Text [Pos] = 'D'; break;
				}
				break;
			}
		}
		do
		{
			Pos = 0;
			while (Text [Pos] != 0x00)
			{
				if (Text [Pos++] == '$')
				{
					Byte = Text [Pos++] - '0'; if (Byte > 9) { Byte -= 'A' - ('9' + 1); }
					Y = Byte << 4;
					Byte = Text [Pos++] - '0'; if (Byte > 9) { Byte -= 'A' - ('9' + 1); }
					Y |= Byte & 0x0F;
					Byte = Text [Pos++] - '0'; if (Byte > 9) { Byte -= 'A' - ('9' + 1); }
					X = Byte << 4;
					Byte = Text [Pos++] - '0'; if (Byte > 9) { Byte -= 'A' - ('9' + 1); }
					X |= Byte & 0x0F;

					int Rot = Count;
					while (Rot-- > 0)
					{
						Byte = X;
						X = Y;
						Y = -Byte;
					}
					Byte = Text [Pos];
					snprintf ((char*) &Text [Pos-4], 0x1000, "%0.2X%0.2X", Y&0xFF, X&0xFF);
					Text [Pos] = Byte;
				}
			}
			fputs ((char*) Text, Out);
		}
		while (fgets ((char*) Text, 0x1000, File) != NULL);
		snprintf ((char*) Text, 0x1000, "\n\n");
		fputs ((char*) Text, Out);
	}
	fclose (File);
	fclose (Out);
	return (0x00);
}

// =============================================================================
