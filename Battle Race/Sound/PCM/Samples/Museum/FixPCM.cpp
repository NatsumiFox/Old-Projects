// =============================================================================
// -----------------------------------------------------------------------------
// FixPCM
// -----------------------------------------------------------------------------

#include <stdio.h>

int main (int ArgCount, char **ArgList, char **EnvList)

{
	printf ("FixPCM - by MarkeyJester\n\n");
	if (ArgCount <= 0x01)
	{
		printf (" -> Drag and drop .wav samples onto this application\n");
	}
	else
	{
		int i0, i1, i2, i3, i4, i5, i6, i7;
		FILE *File;
		for (i7 = 0x01; i7 < ArgCount; i7++)
		{
			printf (" -> %s\n", ArgList [i7]);
			if ((File = fopen (ArgList [i7], "r+b")) == NULL)
			{
				printf (" -> Error, could not open file\n");
			}
			else
			{
				i0 = (fgetc (File) & 0xFF) << 0x18;
				i0 |= (fgetc (File) & 0xFF) << 0x10;
				i0 |= (fgetc (File) & 0xFF) << 0x08;
				i0 |= fgetc (File) & 0xFF;
				if (i0 != 0x52494646) // RIFF
				{
					printf (" -> Error, the file is not a valid .wav\n");
				}
				else
				{
					fseek (File, 0x00, SEEK_END);
					i6 = ftell (File) - 0x3A;
					fseek (File, 0x3A, SEEK_SET);
					i5 = 0x00;
					while (i6 > 0x00)
					{
						if ((fgetc (File) & 0xFF) == 0x00)
						{
							if (i6 == 0x01)
							{
								i5 = 0x01;
							}
							else
							{
								fseek (File, -0x01, SEEK_CUR);
								fputc (0x01, File);
								fseek (File, 0x00, SEEK_CUR);
							}
						}
						i6--;
					}
					if (i5 == 0x00)
					{
						fseek (File, 0x00, SEEK_END);
						fputc (0x00, File);
					}
				}
				fclose (File);
			}
		}
	}
	printf ("\nPress enter key to exit...\n");
	fflush (stdin);
	getc (stdin);
	return (0x00);
}
