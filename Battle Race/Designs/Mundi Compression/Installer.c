// =============================================================================
// -----------------------------------------------------------------------------
// Mundi Installer
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <windows.h>
#include <direct.h>
#include "Mundi.inc"
#include "SplitFileName.h"

const char ProgName [] = { "Mundi Installer" };
HKEY KeyName = HKEY_CLASSES_ROOT;
char KeyPath [0x1000] = { "*\\shell\\Mundi" };
BYTE MenuText [] = { "Mundi" };

const BYTE CommandArgs [] = { "\"%1\"" };

char String [0x1000];

// =============================================================================
// -----------------------------------------------------------------------------
// Macros
// -----------------------------------------------------------------------------

#define ERRORMSG_T(ERROR,ERRORTYPE,MESSAGE,...)\
\
{\
	if (ERROR == ERRORTYPE)\
	{\
		snprintf (String, 0x1000, MESSAGE, ##__VA_ARGS__);\
		MessageBox (NULL, String, ProgName, MB_OK | MB_ICONEXCLAMATION);\
		return (0x00);\
	}\
}


#define ERRORMSG_F(ERROR,ERRORTYPE,MESSAGE,...)\
\
{\
	if (ERROR != ERRORTYPE)\
	{\
		snprintf (String, 0x1000, MESSAGE, ##__VA_ARGS__);\
		MessageBox (NULL, String, ProgName, MB_OK | MB_ICONEXCLAMATION);\
		return (0x00);\
	}\
}

// =============================================================================
// -----------------------------------------------------------------------------
// Main Routine
// -----------------------------------------------------------------------------

int main (int ArgNumber, char **ArgList, char **EnvList)

{
	HKEY RegistryKey = NULL;
	LONG Error;

	char Byte;
	int KeyPathLoc = -1;
	do
	{
		Byte = KeyPath [++KeyPathLoc];
	}
	while (Byte != 0x00);

	mkdir ((char*) &CommandText [1]);
	int CommandTextLoc = -1;
	do
	{
		Byte = CommandText [++CommandTextLoc];
	}
	while (Byte != 0x00);
	int FolderPos = CommandTextLoc;
//	CommandText [CommandTextLoc++] = '\\';
	strcpy ((char*) &CommandText [CommandTextLoc], IncName);
	do
	{
		Byte = CommandText [++CommandTextLoc];
	}
	while (Byte != 0x00);

	// --- Opening in read mode to check it exists first... ---

	Error = RegOpenKeyEx (KeyName, KeyPath, 0, KEY_READ, &RegistryKey);
	if (Error != ERROR_SUCCESS)
	{
		ERRORMSG_F (Error, ERROR_FILE_NOT_FOUND, "Could not access the registry key\nError code: %d", Error);

		// --- Creating program ---

		FILE *File = fopen ((char*) &CommandText [1], "wb"); // The [1] is to skip over the " symbol
		if (File == NULL)
		{
			MessageBox (NULL, "Could not install the program", "Error", MB_OK | MB_ICONEXCLAMATION);
			return (0x00);
		}
		if (fwrite (IncData, 0x01, IncSize, File) != IncSize)
		{
			MessageBox (NULL, "Could not install the program", "Error", MB_OK | MB_ICONEXCLAMATION);
			return (0x00);
		}
		fclose (File);
		CommandText [CommandTextLoc++] = '"';
		CommandText [CommandTextLoc++] = ' ';
		strcpy ((char*) &CommandText [CommandTextLoc], (char*) CommandArgs);

		// --- Creating the menu key ---

		Error = RegCreateKeyEx (KeyName, KeyPath, 0, NULL, 0, KEY_WRITE, NULL, &RegistryKey, NULL);
		ERRORMSG_F (Error, ERROR_SUCCESS, "Could not create the registry key\nError code: %d", Error);

		Error = RegCloseKey (RegistryKey);
		ERRORMSG_F (Error, ERROR_SUCCESS, "Could not close the registry key\nError code: %d", Error);
		
		Error = RegOpenKeyEx (KeyName, KeyPath, 0, KEY_WRITE, &RegistryKey);
		ERRORMSG_F (Error, ERROR_SUCCESS, "Could not open the registry key\nError code: %d", Error);

		Error = RegSetValueEx (RegistryKey, NULL, 0, REG_SZ, MenuText, sizeof (MenuText));
		ERRORMSG_F (Error, ERROR_SUCCESS, "Could not set the registry value\nError code: %d", Error);

		Error = RegCloseKey (RegistryKey);
		ERRORMSG_F (Error, ERROR_SUCCESS, "Could not close the registry key\nError code: %d", Error);

		// --- Now making the "command" folder ---

		strcpy ((char*) &KeyPath [KeyPathLoc], "\\command");

		RegistryKey = NULL;

		Error = RegCreateKeyEx (KeyName, KeyPath, 0, NULL, 0, KEY_WRITE, NULL, &RegistryKey, NULL);
		ERRORMSG_F (Error, ERROR_SUCCESS, "Could not create the registry key\nError code: %d", Error);

		Error = RegCloseKey (RegistryKey);
		ERRORMSG_F (Error, ERROR_SUCCESS, "Could not close the registry key\nError code: %d", Error);
		
		Error = RegOpenKeyEx (KeyName, KeyPath, 0, KEY_WRITE, &RegistryKey);
		ERRORMSG_F (Error, ERROR_SUCCESS, "Could not open the registry key\nError code: %d", Error);

		Error = RegSetValueEx (RegistryKey, NULL, 0, REG_SZ, CommandText, sizeof (CommandText));
		ERRORMSG_F (Error, ERROR_SUCCESS, "Could not set the registry value\nError code: %d", Error);

		Error = RegCloseKey (RegistryKey);
		ERRORMSG_F (Error, ERROR_SUCCESS, "Could not close the registry key\nError code: %d", Error);

		MessageBox (NULL, "Mundi installed successfully...", ProgName, MB_OK | MB_ICONINFORMATION);
	}
	else
	{
		Error = RegCloseKey (RegistryKey);
		ERRORMSG_F (Error, ERROR_SUCCESS, "Could not close the registry key\nError code: %d", Error);

		// --- Deleting Program ---

		remove ((char*) &CommandText [1]);

		CommandTextLoc = FolderPos;
		strcpy ((char*) &CommandText [CommandTextLoc], SplitFile);
		remove ((char*) &CommandText [1]);

		CommandText [FolderPos] = 0x00;
		rmdir ((char*) &CommandText [1]);

		// --- The command key must be deleted first ---
		// Looks like you cannot delete a key directory, if there are sub-directories
		// within in.  So delete any keys/subdirectories before deleteing the root...

		strcpy ((char*) &KeyPath [KeyPathLoc], "\\command");

		Error = RegDeleteKey (KeyName, KeyPath);
		ERRORMSG_F (Error, ERROR_SUCCESS, "Could not delete the registry key\nError code: %d", Error);

		// --- Now the menu key can be deleted ---

		KeyPath [KeyPathLoc] = 0;

		Error = RegDeleteKey (KeyName, KeyPath);
		ERRORMSG_F (Error, ERROR_SUCCESS, "Could not delete the registry key\nError code: %d", Error);

		MessageBox (NULL, "Mundi uninstalled successfully...", ProgName, MB_OK | MB_ICONINFORMATION);
	}
	return (0x00);
}

// =============================================================================