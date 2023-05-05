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
#include <time.h>
#include "Drum.h"
#include "Platform.h"





static void WAVDump();
static void GetDrumInfo();

char			DrumSelection;
char			WAV_name[81];
unsigned char	Bits[6000];			// 4 bits read from drum sample in ROM.
FILE			*WAV_handle;

struct	DAC
{
	unsigned int	Pointer;
	unsigned int	Length;
}Kick, Snare, Clap, Scratch, Timpani, Tom;





int		Input1;
signed int		AddHB[16] = {0, 0x40, 0x80, 0, 0, 0, 0, 0, 0, -0x40, -0x80, 0, 0, 0, 0, 0};
signed int		AddLB[16] = {0, 0, 0, 1, 2, 4, 8, 16, 0, 0, 0, -1, -2, -4, -8, -16};
unsigned int	WAVData[5] = {0x10, 0x010001, 0x5622, 0xAC44, 0x100002};
FILE	*ROM_handle;

void	CloseROM(FILE *filename);





void DrumEditor()
{
	printf("\n    Function call -> DrumEditor\n\n");
	printf("---------------Sonic QX---------------\n"
		   "--------------DRUM EDITOR-------------\n\n");

	printf("Enter a drum value (1-6):  ");
	DrumSelection = 5/*scanf("%d", &DrumSelection)*/;		// PROFILING!!!

	if(DrumSelection > 6 || DrumSelection < 1)
	{
		printf("ERROR: Invalid selection\n");
		CloseROM(ROM_handle);
		exit(0);
	}

	// In the future, a selection between import and export will
	// be offered in this space. For now, we will assume that
	// the user simply wants to export a drum sample to a WAV
	// file.

	//GetDrumInfo();
	fseek(ROM_handle, S2B_DRUM_POINTERS, SEEK_SET);
	fread(&Kick.Pointer, sizeof(char), 2, ROM_handle);
	fread(&Kick.Length, sizeof(char), 2, ROM_handle);
	fread(&Snare.Pointer, sizeof(char), 2, ROM_handle);
	fread(&Snare.Length, sizeof(char), 1, ROM_handle);
	fseek(ROM_handle, 1, SEEK_CUR);
	fread(&Input1, sizeof(char), 1, ROM_handle);
	Snare.Length += Input1 << 8;
	fread(&Clap.Pointer, sizeof(char), 2, ROM_handle);
	fread(&Clap.Length, sizeof(char), 2, ROM_handle);
	fread(&Scratch.Pointer, sizeof(char), 2, ROM_handle);
	fread(&Scratch.Length, sizeof(char), 1, ROM_handle);
	fseek(ROM_handle, 1, SEEK_CUR);
	fread(&Input1, sizeof(char), 1, ROM_handle);
	Scratch.Length += Input1 << 8;
	fread(&Timpani.Pointer, sizeof(char), 2, ROM_handle);
	fread(&Timpani.Length, sizeof(char), 2, ROM_handle);
	fread(&Tom.Pointer, sizeof(char), 2, ROM_handle);
	fread(&Tom.Length, sizeof(char), 1, ROM_handle);
	fseek(ROM_handle, 1, SEEK_CUR);
	fread(&Input1, sizeof(char), 1, ROM_handle);
	Tom.Length += Input1 << 8;

	Kick.Pointer += S2B_DRUM_BANK;
	Snare.Pointer += S2B_DRUM_BANK;
	Clap.Pointer += S2B_DRUM_BANK;
	Scratch.Pointer += S2B_DRUM_BANK;
	Timpani.Pointer += S2B_DRUM_BANK;
	Tom.Pointer += S2B_DRUM_BANK;
	//
	WAVDump();
}





static void WAVDump()		// SQX spends about 95% of it's time here -- OPTIMIZE!!!*9999999E
{
	unsigned char	LB = 0;				// Lower 8 bits of WAV converted sample.
	int				ReturnFlag = 0;
	int				BitFlag = 0;
	int				DrumLength;
	int				HB = 0;				// Upper 8 bits of WAV converted sample.
	clock_t			start, end/*, cv*/;

	printf("\n    Function call -> WAVDump\n\n");
	printf("Type the name of the WAV file you want to save to:  ");
	scanf("%s", WAV_name);

	WAV_handle = fopen("C:\\SEGA\\ROMS\\SQX\\SOURCE\\DEBUG\\TEST.WAV"/*WAV_name*/, "wb");	// Create a new WAV file.

	switch(DrumSelection)	// Set the beginning read position in the ROM.
	{
		case 1:
		{
			fseek(ROM_handle, Kick.Pointer, SEEK_SET);
			DrumLength = Kick.Length;
			break;
		}
		case 2:
		{
			fseek(ROM_handle, Snare.Pointer, SEEK_SET);
			DrumLength = Snare.Length;
			break;
		}
		case 3:
		{
			fseek(ROM_handle, Clap.Pointer, SEEK_SET);
			DrumLength = Clap.Length;
			break;
		}
		case 4:
		{
			fseek(ROM_handle, Scratch.Pointer, SEEK_SET);
			DrumLength = Scratch.Length;
			break;
		}
		case 5:
		{
			fseek(ROM_handle, Timpani.Pointer, SEEK_SET);
			DrumLength = Timpani.Length;
			break;
		}
		case 6:
		{
			fseek(ROM_handle, Tom.Pointer, SEEK_SET);
			DrumLength = Tom.Length;
			break;
		}
	}

	printf("\nLocation -> 0x%p\n", ftell(ROM_handle));
	printf("Length -> %d bytes\n", DrumLength);

	start = clock();	// Lets time how long it takes to dump our WAV file.

	// WAV dumps are slow, so we must figure out a way to optimize some of
	// the code below to make our WAV dumps much faster. Averages for drum
	// #5 are as follows:
	//
	// Pentium - 96MHz			AVG: 2.1s
	// Pentium II - 400MHz		AVG: 0.7s
	//
	// This these results are not good for what I expect. I would like to at
	// least try to cut them in half if possible. So far, optimization tests
	// have failed to show any usefulness. The hunt continues in trying to
	// figure out a way to make this code faster.

	fseek(WAV_handle, 0x2A, SEEK_SET);	// Set the beginning read position in the WAV file.

	DrumLength = DrumLength << 1;

	#ifdef INTEL
		__asm
		{
			mov		edi, offset Bits			;
			//*
			// 00402223 //
			cmp		dword ptr [ebp-8], ebx		;
			push	1							;
			mov		dword ptr [Input1], ebx		;
			pop		esi							;
			jle		/*DrumEditor + 394h*/FinishDrumLoop			;
		StartDrumLoop:
			push	dword ptr [ROM_handle]		;
			mov		eax, [Input1]				;
			push	esi							;
			lea		eax, Bits [eax]				;
			push	esi							;
			push	eax							;
			call	fread						;
			add		esp, 10h					;
			/*/
			 
			mov		ecx, 0;
			mov		edx, DrumLength;
			mov		esi, 1;
			cmp		edx, ecx;
			jae		FinishDrumLoop;
		StartDrumLoop:
			push	dword ptr [ROM_handle];
			mov		eax, [Input1];
			push	esi;
			lea		eax, Bits [eax];
			push	esi;
			push	eax;
			call	fread;
			add		esp, 10h;//*/

			mov		ax, es:[edi]				;
			shl		ax, 4						;
			shr		al, 4						;
			mov		es:[edi], ah				;
			mov		es:[edi+1], al				;
			add		edi, 2						;

			cmp		eax, dword ptr [ebp-8]		;
			mov		[Input1], eax				;
			jl		/*DrumEditor + 34Eh*/StartDrumLoop			;

			//add		ecx, 2;
			//jmp		StartDrumLoop;
		FinishDrumLoop:
		}
	#else
		for(Input1 = 0; Input1 < DrumLength; Input1 += 2)
		{
			fread(&Bits[Input1], sizeof(char), 1, ROM_handle);
			Bits[Input1 + 1] = Bits[Input1] & 15;			// 00001111
			Bits[Input1] = (Bits[Input1] & 240) >> 4;		// 11110000
		}
	#endif


	for(Input1 = 0; Input1 < DrumLength; ++Input1)
	{
		LB += AddLB[Bits[Input1]];
		HB += AddHB[Bits[Input1]];

		if(AddHB[Bits[Input1]] != 0)
		{
			fseek(WAV_handle, -2, SEEK_CUR);	// When modifying HB, we are actually supposed
												// to modify the byte 'prior' to the position
												// indicator. I have no clue why.
			++ReturnFlag;
		}

		//start = clock();
		if(LB > 0x1F && LB < 0xE0)
		{
			if(AddLB[Bits[Input1]] < 0)
			{
				LB = 192 - LB - 224;
				++BitFlag;
			}
			else if(AddLB[Bits[Input1]] > 0)
				LB += 192;
			else			// This should NEVER occur (useful debugging report).
			{
				printf("ERROR: AddLB[Bits[%d]] == 0\n", Input1);
				fclose(WAV_handle);
				CloseROM(ROM_handle);
				exit(0);
			}
		}
		

		if(HB < 0)
		{
			HB += 256;
			--LB;
		}
		else if(HB > 0xFF)
		{
			HB -= 256;
			++LB;
		}
		//end = clock();
		//cv = cv + ((float)(end - start));


		fwrite(&HB, sizeof(char), 1, WAV_handle);

		if(ReturnFlag == 0)
		{
			fwrite(&LB, sizeof(char), 1, WAV_handle);
		}
		else
		{
			fseek(WAV_handle, 1, SEEK_CUR);
			fwrite(&HB, sizeof(char), 1, WAV_handle);
			fwrite(&LB, sizeof(char), 1, WAV_handle);
			--ReturnFlag;
		}

		if(BitFlag == 1)
		{
			LB += AddLB[Bits[Input1]];	// Say we had E2 and subtracted 4. We should have 02 now.
										// However, that enables the BitFlag, telling it to simply
										// subtract 4 'again' and give us FE. I don't know the
										// logic behind this, but that's how the samples are
										// correctly decoded.
			fwrite(&HB, sizeof(char), 1, WAV_handle);
			fwrite(&LB, sizeof(char), 1, WAV_handle);
			--BitFlag;
		}
	}

	// Now that our second loop is finished, we need to write the header to the WAV file.
	DrumLength = (DrumLength << 1) + 0x2C;
	fseek(WAV_handle, 0, SEEK_SET);
	fwrite(&WAV_HEADER1, sizeof(int), 1, WAV_handle);
	fwrite(&DrumLength, sizeof(int), 1, WAV_handle);
	fwrite(&WAV_HEADER2, sizeof(char), 8, WAV_handle);
	fwrite(&WAVData, sizeof(int), 5, WAV_handle);
	fwrite(&WAV_HEADER3, sizeof(char), 4, WAV_handle);
	DrumLength -= 0x2E;
	fwrite(&DrumLength, sizeof(int), 1, WAV_handle);

	// We're done! Now we close the WAV file and display a nifty message.
	end = clock();
	fclose(WAV_handle);
	printf("\nWAV dump was successful!\n");
	printf("Dump time -> %.2f seconds\n", (float)(end - start) / (float)CLOCKS_PER_SEC);
	//printf("CV - > %.2f seconds\n", (float)(cv) / (float)CLOCKS_PER_SEC);
}





/*static void GetDrumInfo()
{
	printf("\n    Function call -> GetDrumInfo\n\n");

	fseek(ROM_handle, S2B_DRUM_POINTERS, SEEK_SET);
	fread(&Kick.Pointer, sizeof(char), 2, ROM_handle);
	fread(&Kick.Length, sizeof(char), 2, ROM_handle);
	fread(&Snare.Pointer, sizeof(char), 2, ROM_handle);
	fread(&Snare.Length, sizeof(char), 1, ROM_handle);
	fseek(ROM_handle, 1, SEEK_CUR);
	fread(&Input1, sizeof(char), 1, ROM_handle);
	Snare.Length += Input1 << 8;
	fread(&Clap.Pointer, sizeof(char), 2, ROM_handle);
	fread(&Clap.Length, sizeof(char), 2, ROM_handle);
	fread(&Scratch.Pointer, sizeof(char), 2, ROM_handle);
	fread(&Scratch.Length, sizeof(char), 1, ROM_handle);
	fseek(ROM_handle, 1, SEEK_CUR);
	fread(&Input1, sizeof(char), 1, ROM_handle);
	Scratch.Length += Input1 << 8;
	fread(&Timpani.Pointer, sizeof(char), 2, ROM_handle);
	fread(&Timpani.Length, sizeof(char), 2, ROM_handle);
	fread(&Tom.Pointer, sizeof(char), 2, ROM_handle);
	fread(&Tom.Length, sizeof(char), 1, ROM_handle);
	fseek(ROM_handle, 1, SEEK_CUR);
	fread(&Input1, sizeof(char), 1, ROM_handle);
	Tom.Length += Input1 << 8;

	Kick.Pointer += S2B_DRUM_BANK;
	Snare.Pointer += S2B_DRUM_BANK;
	Clap.Pointer += S2B_DRUM_BANK;
	Scratch.Pointer += S2B_DRUM_BANK;
	Timpani.Pointer += S2B_DRUM_BANK;
	Tom.Pointer += S2B_DRUM_BANK;
}*/