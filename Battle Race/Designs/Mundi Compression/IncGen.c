// =============================================================================
// -----------------------------------------------------------------------------
// This program converts a binary file into a text file C char array.
// Used for putting "EnvSum.exe" into "Label Printer.exe".
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <windows.h>

// =============================================================================
// -----------------------------------------------------------------------------
// Main routine
// -----------------------------------------------------------------------------

int main (int ArgNumber, char **ArgList, char **EnvList)

{
	if (ArgNumber > 0x01)
	{
		char FileName [0x1000];
		strcpy (FileName, ArgList [0x01]);
		FILE *File = fopen (FileName, "rb");
		if (File == NULL)
		{
			return (0x00);
		}
		fseek (File, 0x00, SEEK_END);
		int Size = ftell (File);
		rewind (File);
		int FilenameLoc = -1;
		int ExtLoc = 0;
		int NameLoc = 0;
		while (FileName [++FilenameLoc] != 0x00)
		{
			if (FileName [FilenameLoc] == '\\' || FileName [FilenameLoc] == '/')
			{
				NameLoc = FilenameLoc + 1;
			}
			if (FileName [FilenameLoc] == '.')
			{
				ExtLoc = FilenameLoc;
			}
		}
		if (ExtLoc == 0)
		{
			ExtLoc = FilenameLoc;
		}
		char Name [0x1000];
		strcpy (Name, &FileName [NameLoc]);
		strcpy (&FileName [ExtLoc], ".inc");
		FILE *Out = fopen (FileName, "w");
		if (Out == NULL)
		{
			return (0x00);
		}
		char String [0x1000];
		snprintf (String, 0x1000, "const char IncName [] = { \"%s\" };\n", Name);
		fputs (String, Out);
		snprintf (String, 0x1000, "const u_int IncSize = 0x%0.8X;\n", Size);
		fputs (String, Out);
		fputs ("const char IncData [] = {\n", Out);
		int Pos = 0;
		while (Pos < Size)
		{
			snprintf (String, 0x1000, " 0x%0.2X,", fgetc (File) & 0xFF);
			fputs (String, Out);
			Pos++;
			if ((Pos & 0x0F) == 0)
			{
				fputs ("\n", Out);
			}
		}
		fputs (" 0 };\n", Out);
		fclose (Out);
		fclose (File);
	}
}

// =============================================================================
