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

#define	S2B_DRUM_BANK		0xE0000		// We take away 0xD000 from the value to make calculations work.
#define	S2B_DRUM_POINTERS	0xECDA6
#define	WAV_HEADER1			"RIFF"
#define WAV_HEADER2			"WAVEfmt "
#define	WAV_HEADER3			"data"

void DrumEditor();