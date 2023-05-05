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
#include <string.h>
//#include <windows.h>
#include "Channel.h"
#include "Drum.h"
#include "Track.h"
#include "Voice.h"
#include "Ym2612.h"	// Needs some reprogramming to optimize it for SQX purposes.

// A statement with "!@#$%" means that certain values will activate the
// "Hacker()" function which attempts to crash the computer. Please be
// careful about modifying those statements!!

#define		USAGE	"Usage:  SQX.EXE <filename.bin> <editor>  (/? for help)"
#define		LEGAL	"WARNING:\nThis is a private release. If you obtained this illegally (meaning that you\ndidn't get the author's permission), please delete it IMMEDIATELY. You may be\nfined if you don't."

enum{PRIVATE, PUBLIC};

char			ROM_name[81];
char			MK[15];
char			Name1[17];
char			Name2[17];
char			Name3[17];
char			Editor[2];
extern char		TotalFM;
extern char		TotalPSG;
extern char		Tempo;
static char		Release = PRIVATE;//!@#$%//
extern unsigned char	TotalVoices;
int				SMDTest;
extern unsigned int		S2SongBank = 0xF8000;//!@#$%//
extern unsigned int		SongSelection;
extern unsigned int		SongPointer;
extern unsigned int		VoicePointer;
extern int		Input1;
extern int		Input2;
extern int		Input3;
static int		Build = 16;//!@#$%//
static float	Version = 0.39f;//!@#$%//

extern FILE		*ROM_handle;
extern void		OpenROM(char *filename);
extern void		CloseROM(FILE *filename);
extern void		SaveROM(FILE *filename);
extern void		GetSongInfo(FILE *filename);
extern void		Hacked();
extern struct	Channel
{
	int				Offset;
	signed char		MiddleC;
	unsigned char	Volume;
} DAC, FM1, FM2, FM3, FM4, FM5, FM6, PSG1, PSG2, PSG3;
// PWM1, PWM2, PWM3, PWM4, and CDA may be added in the future.

/* These aren't needed yet.
enum
{
	SONG00,
	CNZ2,
	EHZ,
	MZ,
	CNZ,
	MCZ,
	MCZ2,
	ARZ,
	DEZ,
	SpecialStage,
	Menu,
	Sweet,
	FinalBoss,
	CPZ,
	Boss,
	SCZ,
	OOZ,
	WFZ,
	EHZ2,
	Stats,
	SuperSonic,
	HTZ,
	ExtraLife,
	Title,
	StageClear,
	GameOver,
	Invincibility,
	Emerald,
	HPZ,
	UnderWater,
	Remix
};
*/





main(int argc, char *argv[])
{
	if(Version != 0.39f)
		Hacked();
	if(Build != 16)
		Hacked();

	printf("===============================================================================\n"
		   "Sonic QX v%.2f beta (Build %d)\n", Version, Build);
	switch(Release)
	{
		case PRIVATE:
		{
			printf("Private Release -- DO NOT DISTRIBUTE!!!\n");
			break;
		}
		case PUBLIC:
		{
			printf("Public Release\n");
			break;
		}
		default:
		{
			printf("!Unknown Version!\n");
			Hacked();	// Bad things will happen if you screw with my program the wrong way.
		}
	}
	printf("===============================================================================\n\n");

	if(Release == PRIVATE)
		printf("%s\n\n", LEGAL);
	
	if(argc < 2)
	{
		printf("%s\n\n", USAGE);
		printf("Type the name of the ROM you wish to open:  ");
		gets(ROM_name);
	}
	else
	{
		strcpy(ROM_name, argv[1]);	// If arguments are used, use the second one for the filename.
	}

	if(S2SongBank != 0xF8000)
		Hacked();

	if(argc > 2)
		strcpy(Editor, argv[2]);

	OpenROM(ROM_name);

	if(argc > 2)
	{
		if((Editor[0] == 'C' || Editor[0] == 'c') &&
			(Editor[1] == 'H' || Editor[1] == 'h'))
		{
			Input1 = '1';
			goto SeekEditor;
		}
		if((Editor[0] == 'V' || Editor[0] == 'v') &&
			(Editor[1] == 'E' || Editor[1] == 'e'))
		{
			Input1 = '2';
			goto SeekEditor;
		}
		if((Editor[0] == 'D' || Editor[0] == 'd') &&
			(Editor[1] == 'R' || Editor[1] == 'r'))
		{
			Input1 = '3';
			goto SeekEditor;
		}
		if((Editor[0] == 'T' || Editor[0] == 't') &&
			(Editor[1] == 'R' || Editor[1] == 'r'))
		{
			Input1 = '4';
			goto SeekEditor;
		}
	}

	printf("\n\nSelect an editor to use:\n"
		   "    1) Channel Setup\n"
		   "    2) *Voice Editor\n"
		   "    3) Drum Editor\n"
		   "    4) *Track Editor\n\n"
		   "-> ");
	Input1 = '3'/*getchar()*/;		// PROFILING!!!
	
	SeekEditor:
	switch(Input1)
	{
		case '1':
		{
			ChannelSetup();
			break;
		}
		case '2':
		{
			VoiceEditor();
			break;
		}
		case '3':
		{
			DrumEditor();
			break;
		}
		case '4':
		{
			TrackEditor();
			break;
		}
		default:
		{
			printf("ERROR: Invalid selection\n %X", Input1);
			CloseROM(ROM_handle);
			exit(0);
		}
	}

	SaveROM(ROM_handle);
	CloseROM(ROM_handle);

	return 0;
}





void OpenROM(char *filename)
{
	printf("\n    Function call -> OpenROM\n\n");

	// Check for "/?" argument.
	if(((filename[0] == '/') && (filename[1] == '?')) ||
		((Editor[0] == '/') && (Editor[1] == '?')))
	{
		printf("%s\n\n", USAGE);
		printf("Editor:    CH = Channel editor\n"
			   "           VE = Voice editor\n"
			   "           DR = Drum editor\n");
		exit(0);
	}

	// Check for valid filename input.
	if((ROM_handle = fopen("c:\\sega\\roms\\md8123.bin"/*filename*/, "r+b")) == NULL)	//PROFILING!!
	{
		printf("ERROR: File could not be opened\n");
		exit(0);
	}

	// Test for "EAMG" or "EAGN" in ROM header.
	fseek(ROM_handle, 0x280, SEEK_SET);
	fread(&SMDTest, sizeof(char), 4, ROM_handle);
	if(SMDTest == 0x474D4145 || SMDTest == 0x4E474145)
	{
		printf("ERROR: File is in SMD format -- must be converted to BIN\n");
		exit(0);
	}

	// Display ROM header information.
	printf("Handle -> 0x%p\n", ROM_handle);

	fseek(ROM_handle, 0x120, SEEK_SET);
	fread(Name1, sizeof(char), 16, ROM_handle);
	Name1[16] = '\0';

	fread(Name2, sizeof(char), 16, ROM_handle);
	Name2[16] = '\0';

	fread(Name3, sizeof(char), 16, ROM_handle);
	Name3[16] = '\0';

	printf("Game -> %s\n"
		   "        %s\n"
		   "        %s\n", Name1, Name2, Name3);

	fseek(ROM_handle, 48, SEEK_CUR);
	fread(MK, sizeof(char), 14, ROM_handle);
	MK[14] = '\0';
	printf("MK label -> %s\n", MK);
}





void CloseROM(FILE *handle)
{
	printf("\n    Function call -> CloseROM\n\n");
	fclose(handle);
}





void SaveROM(FILE *handle)
{
	printf("\n    Function call -> SaveROM\n\n");
	printf("Save changes to file? (Y/N)  ");
	Input1 = getchar();
	Input1 = getchar();
	if(Input1 >= 'a')
		Input1 -= 32;

	if(Input1 == 'Y')
	{
		// Write tempo
		fseek(handle, SongPointer + 5, SEEK_SET);
		fwrite(&Tempo, sizeof(char), 1, handle);

		// Write FM data
		if(TotalFM > 1)
		{
			fseek(handle, 6, SEEK_CUR);
			fwrite(&FM1.MiddleC, sizeof(char), 1, handle);
			fwrite(&FM1.Volume, sizeof(char), 1, handle);
		}
		if(TotalFM > 2)
		{
			fseek(handle, 2, SEEK_CUR);
			fwrite(&FM2.MiddleC, sizeof(char), 1, handle);
			fwrite(&FM2.Volume, sizeof(char), 1, handle);
		}
		if(TotalFM > 3)
		{
			fseek(handle, 2, SEEK_CUR);
			fwrite(&FM3.MiddleC, sizeof(char), 1, handle);
			fwrite(&FM3.Volume, sizeof(char), 1, handle);
		}
		if(TotalFM > 4)
		{
			fseek(handle, 2, SEEK_CUR);
			fwrite(&FM4.MiddleC, sizeof(char), 1, handle);
			fwrite(&FM4.Volume, sizeof(char), 1, handle);
		}
		if(TotalFM > 5)
		{
			fseek(handle, 2, SEEK_CUR);
			fwrite(&FM5.MiddleC, sizeof(char), 1, handle);
			fwrite(&FM5.Volume, sizeof(char), 1, handle);
		}
		if(TotalFM > 6)
		{
			fseek(handle, 2, SEEK_CUR);
			fwrite(&FM6.MiddleC, sizeof(char), 1, handle);
			fwrite(&FM6.Volume, sizeof(char), 1, handle);
		}

		// Write PSG data
		if(TotalPSG > 0)
		{
			fseek(handle, 2, SEEK_CUR);
			fwrite(&PSG1.MiddleC, sizeof(char), 1, handle);
			fwrite(&PSG1.Volume, sizeof(char), 1, handle);
		}
		if(TotalPSG > 1)
		{
			fseek(handle, 4, SEEK_CUR);
			fwrite(&PSG2.MiddleC, sizeof(char), 1, handle);
			fwrite(&PSG2.Volume, sizeof(char), 1, handle);
		}
		if(TotalPSG > 2)
		{
			fseek(handle, 4, SEEK_CUR);
			fwrite(&PSG3.MiddleC, sizeof(char), 1, handle);
			fwrite(&PSG3.Volume, sizeof(char), 1, handle);
		}
	}
	else if(Input1 != 'N')
	{
		printf("ERROR: Invalid input\n");
		CloseROM(ROM_handle);
		exit(0);
	}
}





void GetSongInfo(FILE *handle)
{
	unsigned char	Dump;
	printf("\n    Function call -> GetSongInfo\n\n");

	printf("Song bank - > 0x%p\n", S2SongBank);

	fseek(handle, S2SongBank + (SongSelection << 1) - 2, SEEK_SET);
	fread(&SongPointer, sizeof(int), 1, handle);

	#ifndef INTEL
		SongPointer = ((SongPointer - 32768) & 65535) + S2SongBank;
	#else
		__asm		// x86 optimization -- 5% faster than the above.
		{
			mov		eax, SongPointer	;
			mov		ebx, S2SongBank		;
			sub		eax, 32768			;
			and		eax, 65535			;
			add		eax, ebx			;
			mov		SongPointer, eax	;
		}
	#endif

	printf("Song pointer -> 0x%p\n", SongPointer);

	fseek(handle, SongPointer, SEEK_SET);
	fread(&VoicePointer, sizeof(int), 1, handle);

	#ifndef INTEL
		VoicePointer = ((VoicePointer - 32768) & 65535) + S2SongBank;
	#else
		__asm		// x86 optimization -- 5% faster than the above.
		{
			mov		eax, VoicePointer	;
			//mov	ebx, S2SongBank		;Uncomment if problems occur.
			sub		eax, 32768			;
			and		eax, 65535			;
			add		eax, ebx			;
			mov		VoicePointer, eax	;
		}
	#endif

	printf("Voice pointer -> 0x%p\n\n", VoicePointer);

	Dump = 0;
	printf("Value test -> ");
	for(TotalVoices = 0; Dump < 128 && TotalVoices < 129; TotalVoices++)
	{
		fseek(handle, VoicePointer + ((TotalVoices * 25) + 1), SEEK_SET);
		fread(&Dump, sizeof(char), 1, handle);
		printf("0x%X, ", Dump);
	}
	--TotalVoices;
	printf("end\nNumber of voices -> %d\n", TotalVoices);
}





void Hacked()
{
	// If SQX is hacked, the program will purposely perform an error that
	// will most likely result in a "blue screen of death", freezing the
	// computer, or simply crash the program. Just in case that doesn't
	// work for some crazy reason, the program will still exit.
	
	__asm
	{
		int	10h;	// I can be evil too!
	}
	exit(0);
}