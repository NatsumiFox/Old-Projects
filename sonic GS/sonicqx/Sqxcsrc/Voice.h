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

#define		YMX_HEADER		"YM2612"
#define		YMX_VERSION		0

void VoiceEditor();
static void VoiceRequest();
void GetVoiceInfo(FILE *handle);
static void SelectVoiceElement();
static float ProcessRegister(char process, float reg);

static void BankRequest();
static void YMXOptions();
static void	CreateYMX();
static void OpenYMX();
static void ImportYMX();
static void ExportYMX();
static void LoadYMX();
static void LoadSYX();
static void LoadYM2612();
static void LoadGS();
char	YMX_name[81];
char	SYX_name[81];
char	YM2612_name[81];
char	GS_name[81];
char	TempName[11];

signed char		YMX_ZeroVoices;
unsigned char	VoiceData[36];	// 25 for voice, 10 for name, and 1 for ending the name string.
unsigned char	BankVoice;	// We use the 'unsigned' specifier because zero is ignored. (1-128)

char	ALG;
char	FB;

struct YM2612
{
	unsigned char	DET;
	unsigned char	CRS;
	unsigned char	RS;
	unsigned char	AME;
	unsigned char	AR;
	unsigned char	D1R;
	unsigned char	D1L;
	unsigned char	D2R;
	unsigned char	RR;
	unsigned char	OUT;
}OP4, OP2, OP3, OP1;
