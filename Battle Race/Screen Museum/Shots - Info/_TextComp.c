// =============================================================================
// -----------------------------------------------------------------------------
// Text Compressor
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <dirent.h>
#include <windows.h>
#include <string.h>
#include "Kosinski.h"

#define rangeof(ENTRY) (0x01<<(0x08*sizeof(ENTRY)))

// -----------------------------------------------------------------------------
// Initialisers
// -----------------------------------------------------------------------------

const char InExt [] = { ".txt" };
const char OutExt [] = { ".ect" }; // entropy compressed text

const char DirText [] = { "Text" };
const char DirChar [] = { "Characters.bmp" };
const char DirPal [] = { "Palette.bmp" };

char String [0x1000];
char *FileName, *ExtName;
FILE *File;

int Count, CountX, CountY;

// -----------------------------------------------------------------------------
// Structures
// -----------------------------------------------------------------------------

struct FILELIST

{
	char Name [0x200];
	char *Ext;
};

struct FILEDATA

{
	int Size;
	char *Data;
};

// =============================================================================
// -----------------------------------------------------------------------------
// Entry point
// -----------------------------------------------------------------------------

int main (int ArgNumber, char **ArgList, char **EnvList)

{
	printf ("Text Compressor - by MarkeyJester\n");

  // --- Getting file directories ---

	DIR *Dir_TextFolder = opendir (DirText);
	if (Dir_TextFolder == NULL)
	{
		printf ("\n -> Folder \"%s\" does not exist, please create it and place text documents\n    to compress, inside the folder\n", DirText);
		printf ("\nPress enter key to exit...\n"); fflush (stdin); getchar ( ); return (0x00);
	}
	struct dirent *Dir_Entry;
	int FileListLoc = 0;
	while ((Dir_Entry = readdir (Dir_TextFolder)) != NULL)
	{
		FileListLoc++;
	}
	FILELIST *FileList = (FILELIST*) malloc (FileListLoc * sizeof (FILELIST));
	if (FileList == NULL)
	{
		printf ("\n -> Error, could not allocate memory for file list\n");
		printf ("\nPress enter key to exit...\n"); fflush (stdin); getchar ( ); return (0x00);
	}
	int FileListSize = 0;
	if ((Dir_TextFolder = opendir (DirText)) == NULL)
	{
		printf ("\n -> Error, could not reopen directory \"%s\"\n", DirText);
		printf ("\nPress enter key to exit...\n"); fflush (stdin); getchar ( ); return (0x00);
	}
	while ((Dir_Entry = readdir (Dir_TextFolder)) != NULL)
	{
		strcpy (String, Dir_Entry->d_name);
		FileName = String;
		ExtName = NULL;
		if (*FileName++ == '.')
		{
			continue;
		}
		do
		{
			if (*FileName == '.')
			{
				ExtName = FileName;
			}
		}
		while (*FileName++ != 0x00);
		FileName = String;
		if (ExtName != NULL)
		{
			if (strcmp (ExtName, InExt) == 0)
			{
				snprintf (FileList [FileListSize].Name, 0x200, "%s\\%s", DirText, FileName);
				FileList [FileListSize].Ext = (ExtName - String) + FileList [FileListSize].Name + strlen (DirText) + 1; // The +1 is for the \ symbol in the filename)
				FileListSize++;
			}
		}
	}
	FILEDATA *TextList = (FILEDATA*) malloc (FileListSize * sizeof (FILEDATA));
	if (TextList == NULL)
	{
		free (FileList); FileList = NULL;
		printf ("\n -> Error, could not allocate memory for text list\n", DirText);
		printf ("\nPress enter key to exit...\n"); fflush (stdin); getchar ( ); return (0x00);
	}

  // --- Reading all files' data ---

	printf ("\n -> Reading files:\n\n");
	for (FileListLoc = 0; FileListLoc < FileListSize; FileListLoc++)
	{
		printf ("    \"%s\"\n", FileList [FileListLoc].Name);
		if ((File = fopen (FileList [FileListLoc].Name, "rb")) == NULL)
		{
			printf ("    Error, could not open file\n");
			continue;
		}
		fseek (File, 0x00, SEEK_END);
		int FileSize = ftell (File);
		if ((TextList [FileListLoc].Data = (char*) malloc (FileSize + 1)) == NULL)
		{
			while (--FileListLoc >= 0x00)
			{
				free (TextList [FileListLoc].Data); TextList [FileListLoc].Data = NULL;
			}
			free (TextList); TextList = NULL;
			free (FileList); FileList = NULL;
			fclose (File);
			printf ("\n -> Error, could not allocate memory for text list entry\n", DirText);
			printf ("\nPress enter key to exit...\n"); fflush (stdin); getchar ( ); return (0x00);
		}
		rewind (File);
		TextList [FileListLoc].Size = FileSize;
		for (FileSize = 0; FileSize < TextList [FileListLoc].Size; FileSize++)
		{
			TextList [FileListLoc].Data [FileSize] = fgetc (File);
		}
		TextList [FileListLoc].Data [TextList [FileListLoc].Size++] = 0x00;
		fclose (File);
	}

  // --- Compressing files ---

	printf ("\n -> Compressing files:\n\n");
	for (FileListLoc = 0; FileListLoc < FileListSize; FileListLoc++)
	{
		strcpy (FileList [FileListLoc].Ext, OutExt);
		printf ("    \"%s\"\n", FileList [FileListLoc].Name);

		int OutPos = 0;

		bool NoLineSpace = FALSE;
		for (Count = 0; Count < TextList [FileListLoc].Size; Count++)
		{
			u_char Byte = TextList [FileListLoc].Data [Count];
			if (Byte == 0x00)
			{
				continue;
			}
			int NewLineCount = 0;
			if (Byte == 0x0D || Byte == 0x0A)
			{
				while (Byte == 0x0D || Byte == 0x0A)
				{
					if (Byte == 0x0A)
					{
						NewLineCount++;
					}
					Count++;
					if (Count == TextList [FileListLoc].Size)
					{
						break;
					}
					Byte = TextList [FileListLoc].Data [Count];
				}
				Count--;
			}
			if (Byte == '¬')
			{
				TextList [FileListLoc].Data [OutPos++] = (Byte-0x20)+0x80;
				NoLineSpace = TRUE;
			}
			else if (NewLineCount == 0x01)
			{
				if (NoLineSpace == FALSE)
				{
					TextList [FileListLoc].Data [OutPos++] = (' '-0x20)+0x80;
				}
				NoLineSpace = FALSE;
			}
			else if (NewLineCount >= 0x02)
			{
				TextList [FileListLoc].Data [OutPos++] = (0x7F-0x20)+0x80;
				TextList [FileListLoc].Data [OutPos++] = (0x7F-0x20)+0x80;
			}
			else
			{
				TextList [FileListLoc].Data [OutPos++] = (Byte-0x20)+0x80;
			}
		}
		TextList [FileListLoc].Size = OutPos;
		if (OutPos >= 0x7FFF)
		{
			printf ("    Warning, the text has surpassed 0x8000 bytes, this may not work in\n    the museum, either alter the museum code/RAM, or reduce the text.\n");
		}
		int Return = KosComp (TextList [FileListLoc].Data, TextList [FileListLoc].Size);
		if (Return != 0x00)
		{
			while (--FileListSize >= 0x00)
			{
				free (TextList [FileListSize].Data); TextList [FileListSize].Data = NULL;
			}
			free (TextList); TextList = NULL;
			free (FileList); FileList = NULL;
			switch (Return)
			{
				case -1:
				{
					printf ("    Error KosComp, allocation error\n");
				}
				break;
				case -2:
				{
					printf ("    Error KosComp, data size is too large or too small...\n");
				}
				break;
			}
			printf ("\nPress enter key to exit...\n"); fflush (stdin); getchar ( ); return (0x00);
		}
		
		File = fopen (FileList [FileListLoc].Name, "wb");
		if (File == NULL)
		{
			while (--FileListSize >= 0x00)
			{
				free (TextList [FileListSize].Data); TextList [FileListSize].Data = NULL;
			}
			free (TextList); TextList = NULL;
			free (FileList); FileList = NULL;
			printf ("    Error, could not create the file\n");
			printf ("\nPress enter key to exit...\n"); fflush (stdin); getchar ( ); return (0x00);
		}
		for (Count = 0; Count < TextList [FileListLoc].Size; Count++)
		{
			fputc (TextList [FileListLoc].Data [Count], File);
		}
		fclose (File);
	}

  // --- Finishing ---

	while (--FileListSize >= 0x00)
	{
		free (TextList [FileListSize].Data); TextList [FileListSize].Data = NULL;
	}
	free (TextList); TextList = NULL;
	free (FileList); FileList = NULL;

	printf ("\nPress enter key to exit...\n"); fflush (stdin); getchar ( ); return (0x00);
}

// =============================================================================
