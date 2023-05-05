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
#include "Track.h"



FILE	*ROM_handle;
unsigned int	SongSelection;
void	CloseROM(FILE *filename);
void	GetSongInfo(FILE *filename);





void TrackEditor()
{
	printf("\n    Function call -> TrackEditor\n\n");
	printf("---------------Sonic QX---------------\n"
		   "-------------TRACK EDITOR-------------\n\n");

	printf("Enter a song value (1-30):  ");
	scanf("%d", &SongSelection);

	if(SongSelection > 30 || SongSelection < 1)	// 21-30 have problems.
	{
		printf("ERROR: Invalid selection\n");
		CloseROM(ROM_handle);
		exit(0);
	}
	GetSongInfo(ROM_handle);
}