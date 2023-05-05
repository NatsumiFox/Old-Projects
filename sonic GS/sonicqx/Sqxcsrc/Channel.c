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



int		Input1;
int		Input2;
char	TotalFM;
char	TotalPSG;
char	Tempo;
FILE	*ROM_handle;
unsigned int	S2SongBank;
unsigned int	SongSelection;
unsigned int	SongPointer;
void	CloseROM(FILE *filename);
void	GetSongInfo(FILE *filename);
struct	Channel
{
	int				Offset;
	signed char		MiddleC;
	unsigned char	Volume;
} DAC, FM1, FM2, FM3, FM4, FM5, FM6, PSG1, PSG2, PSG3;
// PWM1, PWM2, PWM3, PWM4, and CDA may be added in the future.





void ChannelSetup()
{
	printf("\n    Function call -> ChannelMain\n\n");
	printf("---------------Sonic QX---------------\n"
		   "-------------CHANNEL SETUP------------\n\n");

	printf("Enter a song value (1-30):  ");
	scanf("%d", &SongSelection);

	if(SongSelection > 30 || SongSelection < 1)	// 21-30 have problems.
	{
		printf("ERROR: Invalid selection\n");
		CloseROM(ROM_handle);
		exit(0);
	}
	GetSongInfo(ROM_handle);
	GetChannelInfo(ROM_handle);	// This includes song tempo.

EditAnotherChannel:
	EditChannel();
	printf("Edit another channel? (Y/N):  ");
	Input1 = getchar();
	Input1 = getchar();
	if(Input1 >= 'a')
		Input1 -= 32;

	if(Input1 == 'Y')
		goto EditAnotherChannel;
	else if(Input1 != 'N')
	{
		printf("ERROR: Invalid input\n");
		CloseROM(ROM_handle);
		exit(0);
	}
}





static void EditChannel()
{
	printf("\n    Function call -> EditChannel\n\n");
	printf("Type the element you with to edit (F, P, T):  ");
	Input1 = getchar();
	Input1 = getchar();
	if(Input1 >= 'a')
		Input1 -= 32;

	if(Input1 == 'F')
		EditFM();
	else if(Input1 == 'P')
		EditPSG();
	else if(Input1 == 'T')
		EditTempo();
	else
	{
		printf("ERROR: Invalid element\n");
		CloseROM(ROM_handle);
		exit(0);
	}
}





static int SelectEditType()
{
	printf("\n    Function call -> SelectEditType\n\n");
	printf("Data (M, V):  ");
	Input2 = getchar();
	Input2 = getchar();
	if(Input2 >= 'a')
		Input2 -= 32;

	if(Input2 == 'M')
		Input2 = 0;
	else if(Input2 == 'V')
		Input2 = 1;
	else
	{
		printf("ERROR: Invalid data\n");
		CloseROM(ROM_handle);
		exit(0);
	}

	return(Input2);
}





static void EditFM()
{
	printf("\n    Function call -> EditFM\n\n");
	printf("Channel:  ");
	Input1 = getchar();
	Input1 = getchar();
	if((Input1 - 48) > (TotalFM - 1) || (Input1 - 48) < 1)
	{
		printf("ERROR: Invalid channel\n");
		CloseROM(ROM_handle);
		exit(0);
	}
	
	SelectEditType();	// Return 0 for MiddleC, 1 for Volume -- Input2.

	switch(Input1)
	{
		case '1':
		{
			EditFM1();
			break;
		}
		case '2':
		{
			EditFM2();
			break;
		}
		case '3':
		{
			EditFM3();
			break;
		}
		case '4':
		{
			EditFM4();
			break;
		}
		case '5':
		{
			EditFM5();
			break;
		}
		case '6':
			EditFM6();
	}
}





static void EditPSG()
{
	printf("\n    Function call -> EditPSG\n\n");
	printf("Channel:  ");
	Input1 = getchar();
	Input1 = getchar();
	if((Input1 - 48) > TotalPSG || (Input1 - 48) < 1)
	{
		printf("ERROR: Invalid channel\n");
		CloseROM(ROM_handle);
		exit(0);
	}
	
	SelectEditType();	// Return 0 for MiddleC, 1 for Volume -- Input2.

	switch(Input1)
	{
		case '1':
		{
			EditPSG1();
			break;
		}
		case '2':
		{
			EditPSG2();
			break;
		}
		case '3':
			EditPSG3();
	}
}





static void EditTempo()
{
	printf("\n    Function call -> EditTempo\n\n");
	printf("Enter a Tempo value (2-16):  ");
	scanf("%d", &Tempo);
	if(Tempo < 2 || Tempo > 16)
	{
		printf("ERROR: Invalid tempo\n");
		CloseROM(ROM_handle);
		exit(0);
	}
}





static void EditFM1()
{
	printf("\n    Function call -> EditFM1\n\n");
	if(Input2 == 0)	// MiddleC
	{
		printf("Enter a Middle C value for FM1:  ");
		scanf("%d", &FM1.MiddleC);
	}
	else if(Input2 == 1)	// Volume
	{
		printf("Enter a Volume value for FM1:  ");
		scanf("%d", &FM1.Volume);
	}
}

static void EditFM2()
{
	printf("\n    Function call -> EditFM2\n\n");
	if(Input2 == 0)	// MiddleC
	{
		printf("Enter a Middle C value for FM2:  ");
		scanf("%d", &FM2.MiddleC);
	}
	else if(Input2 == 1)	// Volume
	{
		printf("Enter a Volume value for FM2:  ");
		scanf("%d", &FM2.Volume);
	}
}

static void EditFM3()
{
	printf("\n    Function call -> EditFM3\n\n");
	if(Input2 == 0)	// MiddleC
	{
		printf("Enter a Middle C value for FM3:  ");
		scanf("%d", &FM3.MiddleC);
	}
	else if(Input2 == 1)	// Volume
	{
		printf("Enter a Volume value for FM3:  ");
		scanf("%d", &FM3.Volume);
	}
}

static void EditFM4()
{
	printf("\n    Function call -> EditFM4\n\n");
	if(Input2 == 0)	// MiddleC
	{
		printf("Enter a Middle C value for FM4:  ");
		scanf("%d", &FM4.MiddleC);
	}
	else if(Input2 == 1)	// Volume
	{
		printf("Enter a Volume value for FM4:  ");
		scanf("%d", &FM4.Volume);
	}
}

static void EditFM5()
{
	printf("\n    Function call -> EditFM5\n\n");
	if(Input2 == 0)	// MiddleC
	{
		printf("Enter a Middle C value for FM5:  ");
		scanf("%d", &FM5.MiddleC);
	}
	else if(Input2 == 1)	// Volume
	{
		printf("Enter a Volume value for FM5:  ");
		scanf("%d", &FM5.Volume);
	}
}

static void EditFM6()
{
	printf("\n    Function call -> EditFM6\n\n");
	if(Input2 == 0)	// MiddleC
	{
		printf("Enter a Middle C value for FM6:  ");
		scanf("%d", &FM6.MiddleC);
	}
	else if(Input2 == 1)	// Volume
	{
		printf("Enter a Volume value for FM6:  ");
		scanf("%d", &FM6.Volume);
	}
}

static void EditPSG1()
{
	printf("\n    Function call -> EditPSG1\n\n");
	if(Input2 == 0)	// MiddleC
	{
		printf("Enter a Middle C value for PSG1:  ");
		scanf("%d", &PSG1.MiddleC);
	}
	else if(Input2 == 1)	// Volume
	{
		printf("Enter a Volume value for PSG1:  ");
		scanf("%d", &PSG1.Volume);
	}
}

static void EditPSG2()
{
	printf("\n    Function call -> EditPSG2\n\n");
	if(Input2 == 0)	// MiddleC
	{
		printf("Enter a Middle C value for PSG2:  ");
		scanf("%d", &PSG2.MiddleC);
	}
	else if(Input2 == 1)	// Volume
	{
		printf("Enter a Volume value for PSG2:  ");
		scanf("%d", &PSG2.Volume);
	}
}

static void EditPSG3()
{
	printf("\n    Function call -> EditPSG3\n\n");
	if(Input2 == 0)	// MiddleC
	{
		printf("Enter a Middle C value for PSG3:  ");
		scanf("%d", &PSG3.MiddleC);
	}
	else if(Input2 == 1)	// Volume
	{
		printf("Enter a Volume value for PSG3:  ");
		scanf("%d", &PSG3.Volume);
	}
}

	
	
	
	
void GetChannelInfo(FILE *handle)
{
	printf("\n    Function call -> GetChannelInfo\n\n");

	fseek(handle, SongPointer + 2, SEEK_SET);
	fread(&TotalFM, sizeof(char), 1, handle);
	if(TotalFM > 6)
		printf("FM Channels -> 6 (DAC disabled)\n");
	else if(TotalFM == 0)
		printf("FM Channels -> 0 (DAC disabled)\n");
	else
		printf("FM Channels -> %d (DAC enabled)\n", TotalFM - 1);

	fseek(handle, SongPointer + 3, SEEK_SET);
	fread(&TotalPSG, sizeof(char), 1, handle);
	printf("PSG Channels -> %d\n", TotalPSG);

	fseek(handle, SongPointer + 5, SEEK_SET);
	fread(&Tempo, sizeof(char), 1, handle);
	printf("Tempo -> %d\n", Tempo);

	if(TotalFM > 0 && TotalFM < 7)
	{
		fseek(handle, SongPointer + 6, SEEK_SET);
		fread(&DAC.Offset, sizeof(int), 1, handle);
		DAC.Offset = ((DAC.Offset - 32768)  & 65535) + S2SongBank;
		printf("DAC Offset -> 0x%p\n", DAC.Offset);
	}

	if(TotalFM > 1)
	{
		fseek(handle, SongPointer + 10, SEEK_SET);
		fread(&FM1.Offset, sizeof(int), 1, handle);
		FM1.Offset = ((FM1.Offset - 32768)  & 65535) + S2SongBank;
		printf("FM1 Offset -> 0x%p", FM1.Offset);

		fseek(handle, SongPointer + 12, SEEK_SET);
		fread(&FM1.MiddleC, sizeof(char), 1, handle);
		printf("      FM1 Middle C -> %4d", FM1.MiddleC);

		fseek(handle, SongPointer + 13, SEEK_SET);
		fread(&FM1.Volume, sizeof(char), 1, handle);
		FM1.Volume = FM1.Volume;
		printf("      FM1 Volume -> %4d\n", -FM1.Volume);

	}

	if(TotalFM > 2)
	{
		fseek(handle, SongPointer + 14, SEEK_SET);
		fread(&FM2.Offset, sizeof(int), 1, handle);
		FM2.Offset = ((FM2.Offset - 32768)  & 65535) + S2SongBank;
		printf("FM2 Offset -> 0x%p", FM2.Offset);

		fseek(handle, SongPointer + 16, SEEK_SET);
		fread(&FM2.MiddleC, sizeof(char), 1, handle);
		printf("      FM2 Middle C -> %4d", FM2.MiddleC);

		fseek(handle, SongPointer + 17, SEEK_SET);
		fread(&FM2.Volume, sizeof(char), 1, handle);
		FM2.Volume = FM2.Volume;
		printf("      FM2 Volume -> %4d\n", -FM2.Volume);
	}

	if(TotalFM > 3)
	{
		fseek(handle, SongPointer + 18, SEEK_SET);
		fread(&FM3.Offset, sizeof(int), 1, handle);
		FM3.Offset = ((FM3.Offset - 32768)  & 65535) + S2SongBank;
		printf("FM3 Offset -> 0x%p", FM3.Offset);

		fseek(handle, SongPointer + 20, SEEK_SET);
		fread(&FM3.MiddleC, sizeof(char), 1, handle);
		printf("      FM3 Middle C -> %4d", FM3.MiddleC);

		fseek(handle, SongPointer + 21, SEEK_SET);
		fread(&FM3.Volume, sizeof(char), 1, handle);
		FM3.Volume = FM3.Volume;
		printf("      FM3 Volume -> %4d\n", -FM3.Volume);
	}

	if(TotalFM > 4)
	{
		fseek(handle, SongPointer + 22, SEEK_SET);
		fread(&FM4.Offset, sizeof(int), 1, handle);
		FM4.Offset = ((FM4.Offset - 32768)  & 65535) + S2SongBank;
		printf("FM4 Offset -> 0x%p", FM4.Offset);

		fseek(handle, SongPointer + 24, SEEK_SET);
		fread(&FM4.MiddleC, sizeof(char), 1, handle);
		printf("      FM4 Middle C -> %4d", FM4.MiddleC);

		fseek(handle, SongPointer + 25, SEEK_SET);
		fread(&FM4.Volume, sizeof(char), 1, handle);
		FM4.Volume = FM4.Volume;
		printf("      FM4 Volume -> %4d\n", -FM4.Volume);
	}

	if(TotalFM > 5)
	{
		fseek(handle, SongPointer + 26, SEEK_SET);
		fread(&FM5.Offset, sizeof(int), 1, handle);
		FM5.Offset = ((FM5.Offset - 32768)  & 65535) + S2SongBank;
		printf("FM5 Offset -> 0x%p", FM5.Offset);

		fseek(handle, SongPointer + 28, SEEK_SET);
		fread(&FM5.MiddleC, sizeof(char), 1, handle);
		printf("      FM5 Middle C -> %4d", FM5.MiddleC);

		fseek(handle, SongPointer + 29, SEEK_SET);
		fread(&FM5.Volume, sizeof(char), 1, handle);
		FM5.Volume = FM5.Volume;
		printf("      FM5 Volume -> %4d\n", -FM5.Volume);
	}

	if(TotalFM > 6)
	{
		fseek(handle, SongPointer + 30, SEEK_SET);
		fread(&FM6.Offset, sizeof(int), 1, handle);
		FM6.Offset = ((FM6.Offset - 32768)  & 65535) + S2SongBank;
		printf("FM6 Offset -> 0x%p", FM6.Offset);

		fseek(handle, SongPointer + 32, SEEK_SET);
		fread(&FM6.MiddleC, sizeof(char), 1, handle);
		printf("      FM6 Middle C -> %4d", FM6.MiddleC);

		fseek(handle, SongPointer + 33, SEEK_SET);
		fread(&FM6.Volume, sizeof(char), 1, handle);
		FM6.Volume = FM6.Volume;
		printf("      FM6 Volume -> %4d\n", -FM6.Volume);
	}

	if(TotalPSG > 0)
	{
		fseek(handle, SongPointer + (TotalFM << 2) + 6, SEEK_SET);
		fread(&PSG1.Offset, sizeof(int), 1, handle);
		PSG1.Offset = ((PSG1.Offset - 32768)  & 65535) + S2SongBank;
		printf("PSG1 Offset -> 0x%p", PSG1.Offset);

		fseek(handle, SongPointer + (TotalFM << 2) + 8, SEEK_SET);
		fread(&PSG1.MiddleC, sizeof(char), 1, handle);
		printf("     PSG1 Middle C -> %4d", PSG1.MiddleC);

		fseek(handle, SongPointer + (TotalFM << 2) + 9, SEEK_SET);
		fread(&PSG1.Volume, sizeof(char), 1, handle);
		PSG1.Volume = PSG1.Volume;
		printf("     PSG1 Volume -> %4d\n", -PSG1.Volume);
	}

	if(TotalPSG > 1)
	{
		fseek(handle, SongPointer + (TotalFM << 2) + 12, SEEK_SET);
		fread(&PSG2.Offset, sizeof(int), 1, handle);
		PSG2.Offset = ((PSG2.Offset - 32768)  & 65535) + S2SongBank;
		printf("PSG2 Offset -> 0x%p", PSG2.Offset);

		fseek(handle, SongPointer + (TotalFM << 2) + 14, SEEK_SET);
		fread(&PSG2.MiddleC, sizeof(char), 1, handle);
		printf("     PSG2 Middle C -> %4d", PSG2.MiddleC);

		fseek(handle, SongPointer + (TotalFM << 2) + 15, SEEK_SET);
		fread(&PSG2.Volume, sizeof(char), 1, handle);
		PSG2.Volume = PSG2.Volume;
		printf("     PSG2 Volume -> %4d\n", -PSG2.Volume);
	}

	if(TotalPSG > 2)
	{
		fseek(handle, SongPointer + (TotalFM << 2) + 18, SEEK_SET);
		fread(&PSG3.Offset, sizeof(int), 1, handle);
		PSG3.Offset = ((PSG3.Offset - 32768) & 65535) + S2SongBank;
		printf("PSG3 Offset -> 0x%p", PSG3.Offset);

		fseek(handle, SongPointer + (TotalFM << 2) + 20, SEEK_SET);
		fread(&PSG3.MiddleC, sizeof(char), 1, handle);
		printf("     PSG3 Middle C -> %4d", PSG3.MiddleC);

		fseek(handle, SongPointer + (TotalFM << 2) + 21, SEEK_SET);
		fread(&PSG3.Volume, sizeof(char), 1, handle);
		PSG3.Volume = PSG3.Volume;
		printf("     PSG3 Volume -> %4d\n", -PSG3.Volume);
	}
}