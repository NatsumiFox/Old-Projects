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

void ChannelSetup();
void GetChannelInfo(FILE *handle);
static void EditChannel();
static void EditFM();
static void EditFM1();
static void EditFM2();
static void EditFM3();
static void EditFM4();
static void EditFM5();
static void EditFM6();
static void EditPSG();
static void EditPSG1();
static void EditPSG2();
static void EditPSG3();
static void EditTempo();
static int SelectEditType();