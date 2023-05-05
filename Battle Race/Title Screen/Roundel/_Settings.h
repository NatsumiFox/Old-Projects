
	// --- Loading settings from the text document ---

const char FileSettings [] = { "Settings.txt" };
int PADSIZE = 0;
int COUNTSTRIPS = 0;
int HEIGHT = 0;
int SCANSKIP = 0;
int EDGEREMOVE = 0;

void LoadSettings ( )

{
	FILE *File = fopen (FileSettings, "r");
	if (File != NULL)
	{
		fseek (File, 0x00, SEEK_END);
		int Size = ftell (File);
		rewind (File);
		char SETTINGS [Size + 1];
		int Loc = 0, LineCount = 1;
		while (ftell (File) != Size)
		{
			char Byte = fgetc (File);
			if (Byte == 0x0A)
			{
				LineCount++;
				SETTINGS [Loc++] = 0x00;
			}
			else if (Byte != 0x0D)
			{
				SETTINGS [Loc++] = Byte;
			}
		}
		SETTINGS [Loc++] = 0x00;
		Size = Loc;
		Loc = 0;
		while (LineCount-- > 0)
		{
			int StartLoc = Loc;
			while (SETTINGS [++Loc] != '=')
			{
				if (Loc == Size)
				{
					LineCount = 0;
					break;
				}
			}
			SETTINGS [Loc++] = 0x00;
			int Number = 0;
			while (SETTINGS [Loc] != 0)
			{
				u_char Byte = SETTINGS [Loc++];
				if (Byte > '9')
				{
					Byte -= 'A' - ('9' + 1);
				}
				Byte -= '0';
				Number = (Number << 4) | Byte & 0x0F;
			}
			Loc++;
			if ((strcmp (&SETTINGS [StartLoc], "PADSIZE")) == 0)
			{
				PADSIZE = Number;
			}
			else if ((strcmp (&SETTINGS [StartLoc], "COUNTSTRIPS")) == 0)
			{
				COUNTSTRIPS = Number;
			}
			else if ((strcmp (&SETTINGS [StartLoc], "HEIGHT")) == 0)
			{
				HEIGHT = Number;
			}
			else if ((strcmp (&SETTINGS [StartLoc], "SCANSKIP")) == 0)
			{
				SCANSKIP = Number;
			}
			else if ((strcmp (&SETTINGS [StartLoc], "EDGEREMOVE")) == 0)
			{
				EDGEREMOVE = Number;
			}
		}
		fclose (File);
	}
}