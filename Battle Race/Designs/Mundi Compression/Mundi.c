// =============================================================================
// -----------------------------------------------------------------------------
// Mundi Compressor/Decompressor
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <windows.h>
#include "Mundi.h"
#include "Compression Code/Mundi.h"
#include "SplitFileName.h"

const char ExtComp [] = { ".mun" };
const char ExtDec [] = { ".unc" };

int SplitSize = 0;
bool Cancelled = FALSE;
bool SizeDone = FALSE;
char String [0x1000];

// =============================================================================
// -----------------------------------------------------------------------------
// Dialog box procedure
// -----------------------------------------------------------------------------

BOOL CALLBACK SplitProc (HWND hwnd, UINT Message, WPARAM wParam, LPARAM lParam)

{
	switch (Message)
	{
		case WM_INITDIALOG:
		{
			snprintf (String, 0x1000, "%X", SplitSize);
			SetDlgItemText (hwnd, IDC_SPLITSIZE, String);
		}
		break;
		case WM_COMMAND:
		{
			switch (LOWORD (wParam))
			{
				case IDC_OK:
				{
					int Size = GetWindowTextLength (GetDlgItem (hwnd, IDC_SPLITSIZE));
					GetDlgItemText (hwnd, IDC_SPLITSIZE, String, Size + 1);
					SplitSize = 0;
					u_char Byte;
					int Loc = -1;
					while (++Loc < Size)
					{
						Byte = String [Loc];
						if (	Byte >= '0' && Byte <= '9' ||
							Byte >= 'A' && Byte <= 'F' ||
							Byte >= 'a' && Byte <= 'f')
						{
							if (Byte > 'F')
							{
								Byte -= 'a' - 'A';
							}
							if (Byte > '9')
							{
								Byte -= 'A' - ('9' + 1);
							}
							Byte -= '0';
							SplitSize = (SplitSize << 4) | Byte;
						}
					}
					EndDialog (hwnd, 0);
					break;
				}
				break;
				case IDC_CANCEL:
				{
					Cancelled = TRUE;
					EndDialog (hwnd, 0);
				}
				break;
			}
		}
		break;
		default:
		{
			return FALSE;
		}
	}
	return TRUE;
}

// =============================================================================
// -----------------------------------------------------------------------------
// Main/Start Routine
// -----------------------------------------------------------------------------

int main (int ArgNumber, char **ArgList, char **EnvList)

{
	int ArgCount;
	char Direct [0x1000];

	char Byte;
	int CommandTextLoc = -1;
	do
	{
		Byte = CommandText [++CommandTextLoc];
	}
	while (Byte != 0x00);
	strcpy ((char*) &CommandText [CommandTextLoc], SplitFile);

//	snprintf (Direct, 0x1000, "%d", ArgNumber);
//	MessageBox (NULL, Direct, "Derp", MB_OK);

	for (ArgCount = 0x01; ArgCount < ArgNumber; ArgCount++)
	{

	// --- Filename ---

		if (ArgList [ArgCount] == NULL)
		{
			continue;
		}
		if (ArgList [ArgCount] [0] == 0)
		{
			continue;
		}
		if (ArgList [ArgCount] [0] == '*')
		{
			SizeDone = TRUE;
			SplitSize = 0;
			u_char Byte;
			int Loc = -1;
			while (ArgList [ArgCount] [++Loc] != 0x00)
			{
				Byte = ArgList [ArgCount] [Loc];
				if (	Byte >= '0' && Byte <= '9' ||
					Byte >= 'A' && Byte <= 'F' ||
					Byte >= 'a' && Byte <= 'f')
				{
					if (Byte > 'F')
					{
						Byte -= 'a' - 'A';
					}
					if (Byte > '9')
					{
						Byte -= 'A' - ('9' + 1);
					}
					Byte -= '0';
					SplitSize = (SplitSize << 4) | Byte;
				}
			}
			continue;
		}

		strcpy (Direct, ArgList [ArgCount]);
		char *DirectPos = &Direct [-1], *ExtName = NULL;
		while (*++DirectPos != 0x00)
		{
			if (*DirectPos == '.')
			{
				ExtName = DirectPos;
			}
		}
		if (ExtName == NULL)
		{
			ExtName = DirectPos;
		}

	// --- Loading file ---

		FILE *File = fopen (Direct, "rb");
		if (File == NULL)
		{
			MessageBox (NULL, "Could not open the file", Direct, MB_OK | MB_ICONEXCLAMATION);
			continue;
		}
		fseek (File, 0x00, SEEK_END);
		int MemorySize = ftell (File);
		char *Memory = (char*) malloc (MemorySize);
		if (Memory == NULL)
		{
			fclose (File);
			MessageBox (NULL, "Could not allocate memory for file", Direct, MB_OK | MB_ICONEXCLAMATION);
			continue;
		}
		rewind (File);
		if ((fread (Memory, 0x01, MemorySize, File)) != MemorySize)
		{
			free (Memory); Memory = NULL;
			fclose (File);
			MessageBox (NULL, "Fread size incorrect", Direct, MB_OK | MB_ICONEXCLAMATION);
			continue;
		}
		fclose (File);

	// --- Compression/decompression ---

		if ((strcmp (ExtName, ExtComp)) != 0)
		{
			if (SizeDone == FALSE)
			{
				bool FileOpen = TRUE;
				FILE *File = fopen ((char*) &CommandText [1], "r+b");
				if (File == NULL)
				{
					if ((File = fopen ((char*) &CommandText [1], "w+b")) != NULL)
					{
						fputc (0x00, File);
						fputc (0x00, File);
						fputc (0x00, File);
						fputc (0x00, File);
						SplitSize = 0;
					}
					else
					{
						FileOpen = FALSE;
					}
				}
				else
				{
					SplitSize = fgetc (File) << 0x18;
					SplitSize |= (fgetc (File) & 0xFF) << 0x10;
					SplitSize |= (fgetc (File) & 0xFF) << 0x08;
					SplitSize |= (fgetc (File) & 0xFF) << 0x00;
				}
				DialogBox (NULL, MAKEINTRESOURCE (IDD_SPLIT), NULL, (DLGPROC) SplitProc);
				if (Cancelled == TRUE)
				{
					if (FileOpen == TRUE)
					{
						fclose (File);
					}
					free (Memory); Memory = NULL;
					return (0x00);
				}
				if (FileOpen == TRUE)
				{
					rewind (File);
					fputc (SplitSize >> 0x18, File);
					fputc (SplitSize >> 0x10, File);
					fputc (SplitSize >> 0x08, File);
					fputc (SplitSize >> 0x00, File);
					fclose (File);
				}
				SizeDone = TRUE;
			}
			switch (MunComp (Memory, MemorySize, SplitSize))
			{
				case MUNERR_SIZE:	MessageBox (NULL, "The file is either 0, or too large", Direct, MB_OK | MB_ICONEXCLAMATION); continue;
				case MUNERR_ALLOC:	MessageBox (NULL, "Could not allocate memory", Direct, MB_OK | MB_ICONEXCLAMATION); continue;
			}
			strcpy (ExtName, ExtComp);
		}
		else
		{
			switch (MunDec (Memory, MemorySize))
			{
				case MUNERR_SIZE:	MessageBox (NULL, "The file is either 0, or too large", Direct, MB_OK | MB_ICONEXCLAMATION); continue;
				case MUNERR_ALLOC:	MessageBox (NULL, "Could not allocate memory", Direct, MB_OK | MB_ICONEXCLAMATION); continue;
			}
			strcpy (ExtName, ExtDec);
		}

	// --- Saving file ---

		if ((File = fopen (Direct, "wb")) == NULL)
		{
			free (Memory); Memory = NULL;
			MessageBox (NULL, "Could not create output file", Direct, MB_OK | MB_ICONEXCLAMATION);
			continue;
		}
		int ReturnSize = fwrite (Memory, 0x01, MemorySize, File);
		fclose (File);
		free (Memory); Memory = NULL;
		if (ReturnSize != MemorySize)
		{
			MessageBox (NULL, "Fwrite size incorrect", Direct, MB_OK | MB_ICONEXCLAMATION);
		}
	}
	return (0x00);
}

// =============================================================================
