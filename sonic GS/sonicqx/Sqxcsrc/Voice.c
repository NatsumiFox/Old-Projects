///////////////////////////////////////////////////
// Sonic QX Beta C Source Code                   //
// Copyright(c) 2003-2004, Damian Grove          //
// ! ! ! D O   N O T   D I S T R I B U T E ! ! ! //
///////////////////////////////////////////////////

//----------------------------------------------------------------------------
//This is the source code for the C version of Sonic QX. At the moment, no
//Windows GUI elements have been tagged to the source to give it that Windows
//user-friendly feel. All functions were designed and written entirely myself.
//If you obtained this source without my permission, you should IMMEDIATELY
//delete this code and all the files associated with the Sonic QX source. If
//not, LEGAL ACTION MAY BE TAKEN. Make sure you keep that in mind before you
//attempt to rob me of my code.
//
//  -- Damian Grove
//----------------------------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include "Channel.h"
#include "Voice.h"
#include "Ym2612.h"



int				YM2612clock;
int				rate;

int				Input1;
int				Input2;
int				Input3;

FILE	*Bank_handle;
FILE	*ROM_handle;
unsigned int	SongSelection;
unsigned int	VoicePointer;
unsigned char	TotalVoices;
unsigned char	VoiceSelection;
void	CloseROM(FILE *filename);
void	GetSongInfo(FILE *filename);
struct	Channel
{
	int				Offset;
	signed char		MiddleC;
	unsigned char	Volume;
} DAC, FM1, FM2, FM3, FM4, FM5, FM6, PSG1, PSG2, PSG3;
// PWM1, PWM2, PWM3, PWM4, and CDA may be added in the future.





void VoiceEditor()
{
	printf("\n    Function call -> VoiceEditor\n\n");
	printf("---------------Sonic QX---------------\n"
		   "-------------VOICE EDITOR-------------\n\n");

	printf("Enter a song value (1-30):  ");
	scanf("%d", &SongSelection);

	if(SongSelection > 30 || SongSelection < 1)	// 21-30 have problems.
	{
		printf("ERROR: Invalid selection\n");
		CloseROM(ROM_handle);
		exit(0);
	}
	GetSongInfo(ROM_handle);
	VoiceRequest();
	GetVoiceInfo(ROM_handle);
	BankRequest();
	SelectVoiceElement();

	/*
	// Just testing some stuff...
	YM2612Init(1, YM2612clock, rate, NULL, NULL);
	YM2612Write(1, 0x90, 0x00);
	YM2612Write(1, 0x94, 0x00);
	YM2612Write(1, 0x98, 0x00);
	YM2612Write(1, 0x9C, 0x00);
	YM2612Write(1, 0xB0, 8);
	YM2612Write(1, 0x30, 9);
	YM2612Write(1, 0x34, 0x30);
	YM2612Write(1, 0x38, 0x70);
	YM2612Write(1, 0x3C, 0);
	YM2612Write(1, 0x50, 0x1F);
	YM2612Write(1, 0x54, 0x5F);
	YM2612Write(1, 0x58, 0x1F);
	YM2612Write(1, 0x5C, 0x5F);
	YM2612Write(1, 0x60, 0x12);
	YM2612Write(1, 0x64, 0x0A);
	YM2612Write(1, 0x68, 0x0E);
	YM2612Write(1, 0x6C, 0x0A);
	YM2612Write(1, 0x70, 0);
	YM2612Write(1, 0x74, 4);
	YM2612Write(1, 0x78, 4);
	YM2612Write(1, 0x7C, 3);
	YM2612Write(1, 0x80, 0x2F);
	YM2612Write(1, 0x84, 0x2F);
	YM2612Write(1, 0x88, 0x2F);
	YM2612Write(1, 0x8C, 0x2F);
	YM2612Write(1, 0x40, 0x25);
	YM2612Write(1, 0x44, 0x13);
	YM2612Write(1, 0x48, 0x30);
	YM2612Write(1, 0x4C, 0x80);
	YM2612Write(1, 0xB4, 0xC0);
	YM2612Write(1, 0x28, 0x00);
	YM2612Write(1, 0xA4, 0x22);
	YM2612Write(1, 0xA0, 0x69);
	YM2612Write(1, 0x4C, 0x80);
	YM2612Write(1, 0x28, 0xF0);
	Input1 = getchar();
	Input1 = getchar();
	YM2612Write(1, 0x28, 0x00);
	//YM2612Shutdown();
	*/
}





static void YMXOptions()
{
YMXMenu:
	printf("\n    Function call -> VoiceOptions\n\n");
	printf("    1) Open existing bank\n"
		   "    2) Create new bank\n"
		   "    3) Import voice into bank\n"
		   "    4) Export voice from bank\n"
		   "    5) EXIT THIS MENU\n"
		   "-> ");
	scanf("%d", &Input1);

	switch(Input1)
	{
		case 1:
			OpenYMX();
			break;
		case 2:
			CreateYMX();
			break;
		case 3:
			ImportYMX();
			break;
		case 4:
			ExportYMX();
			break;
		case 5:
			goto YMXMenu;	// FIX ME!
			break;
		default:
			printf("ERROR: Invalid input\n");
			fclose(ROM_handle);
			fclose(Bank_handle);
			exit(0);
	}
	goto YMXMenu;
}





static void VoiceRequest()
{
	printf("\n    Function call -> VoiceRequest\n\n");
	printf("Enter a voice number:  ");
	scanf("%d", &VoiceSelection);

	if(VoiceSelection > 128 || VoiceSelection < 1)
	{
		printf("ERROR:  Invalid voice number\n");
		CloseROM(ROM_handle);
		exit(0);
	}
}





static void BankRequest()
{
	printf("\n    Function call -> BankRequest\n\n");
	printf("Would you like to apply a voice? (Y/N):  ");
	//scanf("%d", &Input1);
	Input1 = getchar();
	Input1 = getchar();

	if(Input1 >= 'a')
		Input1 -= 32;

	if(Input1 == 'Y')
		Input2 = 1;
	else if(Input1 == 'N')
		Input2 = 0;		// May be useful if we deside to add a condition for this.
	else
	{
		printf("ERROR: Invalid input\n");
		CloseROM(ROM_handle);
		exit(0);
	}

	if(Input2 == 1)
	{
		printf("Select a bank type:\n"
			   "    1) YMX\n"
			   "    2) TX81Z (or compatible) SysEx\n"
			   "    3) YM2612 register dump\n"
			   "    4) Genecyst savestate\n"
			   "->  ");
		//scanf("%d", &Input1);
		Input1 = getchar();
		Input1 = getchar();
		
		switch(Input1)
		{
			case '1':
				YMXOptions();
				break;
			case '2':
				LoadSYX();
				break;
			case '3':
				LoadYM2612();
				break;
			case '4':
				LoadGS();
				break;
			default:
				printf("ERROR: Invalid input\n");
				CloseROM(ROM_handle);
				exit(0);
		}
	}
}





static void OpenYMX()
{
	printf("\n    Function call -> LoadYMX\n\n");
	printf("Type the name of the YMX bank you want to use:  ");
	scanf("%s", &YMX_name);
	Bank_handle = fopen(YMX_name, "r+b");
}

static void ExportYMX()
{
	// Display all the voice names.
	fseek(Bank_handle, 7, SEEK_SET);
	fread(&Input1, sizeof(char), 1, Bank_handle);
	for(Input2 = 0; Input2 <= Input1 && Input2 < 16; Input2++)
	// Not enough room to display 128 voices, so we limit it to 64.
	{
		// Voices 1-16
		fseek(Bank_handle, 33 + (Input2 * 35), SEEK_SET);
		fread(TempName, sizeof(char), 10, Bank_handle);
		TempName[10] = '\0';
		printf("%3d - %s    ", Input2 + 1, TempName);

		if(Input1 > 0x0F + Input2)
		{
			// Voices 17-32
			fseek(Bank_handle, 593 + (Input2 * 35), SEEK_SET);
			fread(TempName, sizeof(char), 10, Bank_handle);
			TempName[10] = '\0';
			printf("%3d - %s    ", Input2 + 17, TempName);
		}

		if(Input1 > 0x1F + Input2)
		{
			// Voices 33-48
			fseek(Bank_handle, 1153 + (Input2 * 35), SEEK_SET);
			fread(TempName, sizeof(char), 10, Bank_handle);
			TempName[10] = '\0';
			printf("%3d - %s    ", Input2 + 33, TempName);
		}

		if(Input1 > 0x2F + Input2)
		{
			// Voices 49-64
			fseek(Bank_handle, 1713 + (Input2 * 35), SEEK_SET);
			fread(TempName, sizeof(char), 10, Bank_handle);
			TempName[10] = '\0';
			printf("%3d - %s    ", Input2 + 49, TempName);
		}
		else
			printf("\n");

		if(Input1 < 0x30)	// With four columns, a return isn't required.
			printf("\n");
	}

	printf("Select a voice number:  ");
	scanf("%d", &BankVoice);
	
	// Copy YMX voice data into memory.
	fseek(Bank_handle, (8 + (--BankVoice * 35)), SEEK_SET);
	fread(VoiceData, sizeof(char), 35, Bank_handle);
	VoiceData[35] = '\0';
	printf("Voice name -> %s\n", &VoiceData[25]);

	// Write data to ROM.
	fseek(ROM_handle, VoicePointer + ((VoiceSelection - 1) * 25), SEEK_SET);
	fwrite(&VoiceData, sizeof(char), 25, ROM_handle);
	printf("Voice imported successfully!\n");
}

static void ImportYMX()
{
	fseek(Bank_handle, 7, SEEK_SET);

	printf("Type '1' to create a new voice, or '2' to replace an exisiting one: ");
	scanf("%d", &Input3);
	if(Input3 == 1)
	{
		printf("Give the imported voice a name:  ");
		scanf("%s", TempName);
		fread(&Input2, sizeof(char), 1, Bank_handle);
		Input2++;
		fseek(Bank_handle, -1, SEEK_CUR);
		fwrite(&Input2, sizeof(char), 1, Bank_handle);
		printf("Voice %d -> %s\n", Input2 + 1, TempName);

		fseek(Bank_handle, 33 + (Input2 * 35), SEEK_SET);
		fseek(ROM_handle, VoicePointer + ((VoiceSelection - 1) * 25), SEEK_SET);
		fread(VoiceData, sizeof(char), 25, ROM_handle);
		fwrite(&VoiceData, sizeof(char), 25, Bank_handle);
		fwrite(&TempName, sizeof(char), 10, Bank_handle);
		scanf("%d", &Input1);

		goto EndImportYMX;
	}
	else if(Input3 != 2)
	{
		printf("ERROR: Invalid input");
		fclose(Bank_handle);
		fclose(ROM_handle);
		exit(0);
	}

	// Display all the voice names.
	fread(&Input1, sizeof(char), 1, Bank_handle);
	for(Input2 = 0; Input2 <= Input1 && Input2 < 16; Input2++)
	// Not enough room to display 128 voices, so we limit it to 64.
	{
		// Voices 1-16
		fseek(Bank_handle, 33 + (Input2 * 35), SEEK_SET);
		fread(TempName, sizeof(char), 10, Bank_handle);
		TempName[10] = '\0';
		printf("%3d - %s    ", Input2 + 1, TempName);

		if(Input1 > 0x0F + Input2)
		{
			// Voices 17-32
			fseek(Bank_handle, 593 + (Input2 * 35), SEEK_SET);
			fread(TempName, sizeof(char), 10, Bank_handle);
			TempName[10] = '\0';
			printf("%3d - %s    ", Input2 + 17, TempName);
		}

		if(Input1 > 0x1F + Input2)
		{
			// Voices 33-48
			fseek(Bank_handle, 1153 + (Input2 * 35), SEEK_SET);
			fread(TempName, sizeof(char), 10, Bank_handle);
			TempName[10] = '\0';
			printf("%3d - %s    ", Input2 + 33, TempName);
		}

		if(Input1 > 0x2F + Input2)
		{
			// Voices 49-64
			fseek(Bank_handle, 1713 + (Input2 * 35), SEEK_SET);
			fread(TempName, sizeof(char), 10, Bank_handle);
			TempName[10] = '\0';
			printf("%3d - %s    ", Input2 + 49, TempName);
		}
		else
			printf("\n");

		if(Input1 < 0x30)	// With four columns, a return isn't required.
			printf("\n");
EndImportYMX:
		;
	}

}





static void LoadYMX() //// WE WON'T NEED THIS FOR LONG ////
{
	printf("\n    Function call -> LoadYMX\n\n");
	printf("Type the name of the YMX bank you want to use:  ");
	scanf("%s", &YMX_name);
	Bank_handle = fopen(YMX_name, "r+b");

	// Display all the voice names.
	fseek(Bank_handle, 7, SEEK_SET);
	fread(&Input1, sizeof(char), 1, Bank_handle);
	for(Input2 = 0; Input2 <= Input1 && Input2 < 16; Input2++)
	// Not enough room to display 128 voices, so we limit it to 64.
	{
		// Voices 1-16
		fseek(Bank_handle, 33 + (Input2 * 35), SEEK_SET);
		fread(TempName, sizeof(char), 10, Bank_handle);
		TempName[10] = '\0';
		printf("%3d - %s    ", Input2 + 1, TempName);

		if(Input1 > 0x0F + Input2)
		{
			// Voices 17-32
			fseek(Bank_handle, 593 + (Input2 * 35), SEEK_SET);
			fread(TempName, sizeof(char), 10, Bank_handle);
			TempName[10] = '\0';
			printf("%3d - %s    ", Input2 + 17, TempName);
		}

		if(Input1 > 0x1F + Input2)
		{
			// Voices 33-48
			fseek(Bank_handle, 1153 + (Input2 * 35), SEEK_SET);
			fread(TempName, sizeof(char), 10, Bank_handle);
			TempName[10] = '\0';
			printf("%3d - %s    ", Input2 + 33, TempName);
		}

		if(Input1 > 0x2F + Input2)
		{
			// Voices 49-64
			fseek(Bank_handle, 1713 + (Input2 * 35), SEEK_SET);
			fread(TempName, sizeof(char), 10, Bank_handle);
			TempName[10] = '\0';
			printf("%3d - %s    ", Input2 + 49, TempName);
		}
		else
			printf("\n");

		if(Input1 < 0x30)	// With four columns, a return isn't required.
			printf("\n");
	}

	printf("Select a voice number:  ");
	scanf("%d", &BankVoice);
	
	// Copy YMX voice data into memory.
	fseek(Bank_handle, (8 + (--BankVoice * 35)), SEEK_SET);
	fread(VoiceData, sizeof(char), 35, Bank_handle);
	VoiceData[35] = '\0';
	printf("Voice name -> %s\n", &VoiceData[25]);

	// Write data to ROM.
	fseek(ROM_handle, VoicePointer + ((VoiceSelection - 1) * 25), SEEK_SET);
	fwrite(&VoiceData, sizeof(char), 25, ROM_handle);
	printf("Voice imported successfully!\n");
}

static void CreateYMX()
{
	printf("\n    Function call -> CreateYMX\n\n");
	printf("Type the name of the YMX bank you want to create:  ");
	scanf("%s", &YMX_name);
	Bank_handle = fopen(YMX_name, "wb");

	YMX_ZeroVoices = -1;

	fseek(Bank_handle, 0, SEEK_SET);
	fwrite(&YMX_HEADER, sizeof(char), 6, Bank_handle);
	fwrite(YMX_VERSION, sizeof(char), 1, Bank_handle);
	fwrite(&YMX_ZeroVoices, sizeof(char), 1, Bank_handle);
}





static void LoadSYX()
{
	;
}

static void LoadYM2612()
{
	;
}

static void LoadGS()
{
	;
}





void GetVoiceInfo(FILE *handle)
{
	printf("\n    Function call -> GetVoiceInfo\n\n");

	// Get ALG and FB
	fseek(handle, VoicePointer + ((VoiceSelection - 1) * 25), SEEK_SET);
	fread(&ALG, sizeof(char), 1, handle);
	FB = ALG;
	ALG = ALG & 7;
	FB = (FB & 56) >> 3;

	// Get CRS and DET
	fread(&OP4.CRS, sizeof(char), 1, handle);
	OP4.DET = OP4.CRS;
	OP4.CRS = OP4.CRS & 15;
	OP4.DET = (OP4.DET & 112) >> 4;
	fread(&OP2.CRS, sizeof(char), 1, handle);
	OP2.DET = OP2.CRS;
	OP2.CRS = OP2.CRS & 15;
	OP2.DET = (OP2.DET & 112) >> 4;
	fread(&OP3.CRS, sizeof(char), 1, handle);
	OP3.DET = OP3.CRS;
	OP3.CRS = OP3.CRS & 15;
	OP3.DET = (OP3.DET & 112) >> 4;
	fread(&OP1.CRS, sizeof(char), 1, handle);
	OP1.DET = OP1.CRS;
	OP1.CRS = OP1.CRS & 15;
	OP1.DET = (OP1.DET & 112) >> 4;

	// Get AR and RS
	fread(&OP4.AR, sizeof(char), 1, handle);
	OP4.RS = OP4.AR;
	OP4.AR = OP4.AR & 31;
	OP4.RS = (OP4.RS & 192) >> 6;
	fread(&OP2.AR, sizeof(char), 1, handle);
	OP2.RS = OP2.AR;
	OP2.AR = OP2.AR & 31;
	OP2.RS = (OP2.RS & 192) >> 6;
	fread(&OP3.AR, sizeof(char), 1, handle);
	OP3.RS = OP3.AR;
	OP3.AR = OP3.AR & 31;
	OP3.RS = (OP3.RS & 192) >> 6;
	fread(&OP1.AR, sizeof(char), 1, handle);
	OP1.RS = OP1.AR;
	OP1.AR = OP1.AR & 31;
	OP1.RS = (OP1.RS & 192) >> 6;

	// Get D1R and AME
	fread(&OP4.D1R, sizeof(char), 1, handle);
	OP4.AME = OP4.D1R;
	OP4.D1R = OP4.D1R & 31;
	OP4.AME = (OP4.AME & 128) >> 7;
	fread(&OP2.D1R, sizeof(char), 1, handle);
	OP2.AME = OP2.D1R;
	OP2.D1R = OP2.D1R & 31;
	OP2.AME = (OP2.AME & 128) >> 7;
	fread(&OP3.D1R, sizeof(char), 1, handle);
	OP3.AME = OP3.D1R;
	OP3.D1R = OP3.D1R & 31;
	OP3.AME = (OP3.AME & 128) >> 7;
	fread(&OP1.D1R, sizeof(char), 1, handle);
	OP1.AME = OP1.D1R;
	OP1.D1R = OP1.D1R & 31;
	OP1.AME = (OP1.AME & 128) >> 7;

	// Get D2R
	fread(&OP4.D2R, sizeof(char), 1, handle);
	fread(&OP2.D2R, sizeof(char), 1, handle);
	fread(&OP3.D2R, sizeof(char), 1, handle);
	fread(&OP1.D2R, sizeof(char), 1, handle);

	// Get RR and D1L
	fread(&OP4.RR, sizeof(char), 1, handle);
	OP4.D1L = OP4.RR;
	OP4.RR = OP4.RR & 15;
	OP4.D1L = (OP4.D1L & 240) >> 4;
	fread(&OP2.RR, sizeof(char), 1, handle);
	OP2.D1L = OP2.RR;
	OP2.RR = OP2.RR & 15;
	OP2.D1L = (OP2.D1L & 240) >> 4;
	fread(&OP3.RR, sizeof(char), 1, handle);
	OP3.D1L = OP3.RR;
	OP3.RR = OP3.RR & 15;
	OP3.D1L = (OP3.D1L & 240) >> 4;
	fread(&OP1.RR, sizeof(char), 1, handle);
	OP1.D1L = OP1.RR;
	OP1.RR = OP1.RR & 15;
	OP1.D1L = (OP1.D1L & 240) >> 4;

	// Get OUT
	fread(&OP4.OUT, sizeof(char), 1, handle);
	OP4.OUT = OP4.OUT & 127;
	fread(&OP2.OUT, sizeof(char), 1, handle);
	OP2.OUT = OP2.OUT & 127;
	fread(&OP3.OUT, sizeof(char), 1, handle);
	OP3.OUT = OP3.OUT & 127;
	fread(&OP1.OUT, sizeof(char), 1, handle);
	OP1.OUT = OP1.OUT & 127;

	// Display all of the information on the screen.
	printf("Algorithm -> %.0f\n"
		   "Feedback (OP4) -> %d\n\n"
		   "      OP1        OP2        OP3        OP4\n"
		   "DET   %2.0f         %2.0f         %2.0f         %2.0f\n"
		   "CRS   %2.1f        %2.1f        %2.1f        %2.1f\n"
		   "RS    %d          %d          %d          %d\n"
		   "AR    %2d         %2d         %2d         %2d\n"
		   "D1R   %2d         %2d         %2d         %2d\n"
		   "D1L   %2.0f         %2.0f         %2.0f         %2.0f\n"
		   "D2R   %2d         %2d         %2d         %2d\n"
		   "RR    %2d         %2d         %2d         %2d\n"
		   "AME   %d          %d          %d          %d\n"
		   "OUT   %3.2fdB   %3.2fdB   %3.2fdB   %3.2fdB\n",

		   ProcessRegister(0, ALG), FB,

		   ProcessRegister(1, OP1.DET), ProcessRegister(1, OP2.DET),
		   ProcessRegister(1, OP3.DET), ProcessRegister(1, OP4.DET),

		   ProcessRegister(2, OP1.CRS), ProcessRegister(2, OP2.CRS),
		   ProcessRegister(2, OP3.CRS), ProcessRegister(2, OP4.CRS),

		   OP1.RS, OP2.RS, OP3.RS, OP4.RS,

		   OP1.AR, OP2.AR, OP3.AR, OP4.AR,

		   OP1.D1R, OP2.D1R, OP3.D1R, OP4.D1R,

		   ProcessRegister(3, OP1.D1L), ProcessRegister(3, OP2.D1L),
		   ProcessRegister(3, OP3.D1L), ProcessRegister(3, OP4.D1L),

		   OP1.D2R, OP2.D2R, OP3.D2R, OP4.D2R,

		   OP1.RR, OP2.RR, OP3.RR, OP4.RR,

		   OP1.AME, OP2.AME, OP3.AME, OP4.AME,

		   ProcessRegister(4, OP1.OUT), ProcessRegister(4, OP2.OUT),
		   ProcessRegister(4, OP3.OUT), ProcessRegister(4, OP4.OUT));
}





static float ProcessRegister(register char process, register float reg)
{
	printf("\n    Function call -> ProcessRegister\n\n");
	switch(process)
	// 0 = ALG,  1 = DET,  2 = CRS,  3 = D1L,  4 = OUT
	{
		case 0:
			++reg;
			break;
		case 1:
			if(reg >= 4)
			{
				reg -= 4;
				break;
			}
			else
			{
				reg = reg - reg - reg;
				break;
			}
		case 2:
			if(reg == 0)
			{
				reg = 0.5f;
				break;
			}
			break;
		case 3:
			reg = 15 - reg;
			break;
		case 4:
			reg = -(reg * 0.75f);
			break;
		default:
			printf("ERROR: Improper use of ProcessRegister\n");
			reg = process;
	}
	return reg;
}





static void SelectVoiceElement()
{
	;
}