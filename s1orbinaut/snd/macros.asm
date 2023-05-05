; ===========================================================================
; general purpose macro to turn a variable into string, for example
; to add after lable name.
numToStr	macro	var, nibbles
numc	= \var			; create temporary variable
outStr	equs ""			; this is our final output variables
	rept	\nibbles	; repeat for each required nibble
num	=	numc&$F		; get the nibble number
str	substr	num+1, num+1, "0123456789ABCDEF"; now transform it to string
outStr	equs "\str\\outStr"	; add it to out string
numc	= numc>>4		; finally shift the nibble out
	endr
    endm
; ===========================================================================
; tells the Z80 to stop, and waits for it to finish stopping (acquire bus)
stopZ80 macro
		move.w	#$100,Z80_bus_request	; stop the Z80
.loop\@		btst	#0,Z80_bus_request
		bne.s	.loop\@			; loop until it says it's stopped
    endm

; tells the Z80 to start again
startZ80 macro
		move.w	#0,Z80_bus_request	; start the Z80
    endm

; ===========================================================================
tribyte macro val
	rept narg
		dc.b (val>>16)&$FF,(val>>8)&$FF,val&$FF
	shift
	endr
    endm

; ===========================================================================
; this function allows creating files outside of the main assembly
; used mainly to create variable files for z80 drivers.
StartFile	macro name, file, org
	PUSHS
s_\name		SECTION	file(\file), org(\org)
    endm

; this ends a created file and returns assembly on main file
EndFile		macro
	POPS
    endm
; ===========================================================================
; this created DAC banks file, for S3 and S&K
DoDacFile	macro
	StartFile	DACbanks, "snd/Driver/DACbanks.bin", 0

Z80_DBankID:
	DACMakeBankID 81, 82, 83
	dcb.b $45-(*-Z80_DBankID), $AA
	EndFile
    endm

; ===========================================================================
; used to set a name for a snd driver, as to separate DAC sample listings.
; it helps to separate S3's and S&K's samples with the same name
StartDriver	macro name
Z80DriverName	equs \name
    endm
; ===========================================================================
; alignments possible to use with the macros
Z80BankAlign_None =	0
Z80BankAlign_Start =	1
Z80BankAlign_End =	2
Z80BankAlign_Both =	3

; declares start of a bank, and sets some variables
Z80Bank_Start	macro	alignbits, name
	if (\alignbits&Z80BankAlign_Start)<>0
		align $8000
	endif

z80BankAddr =	(offset(*)&$FF8000)
z80BankName 	equs \name
z80BankAlign =	alignbits
    endm

; macro to do everything needed for end of bank.
; also warns if the bank overflows
Z80Bank_End	macro
	if offset(*)>z80BankAddr+$8000
		inform 1,"Z80 bank %s is too large! Its size is $%h, $%h bytes larger than max.", "\z80BankName", offset(*)-z80BankAddr, (offset(*)-z80BankAddr)-$8000
	else
		inform 0,"Z80 bank %s has $%h free bytes.", "\z80BankName", $8000-(offset(*)-z80BankAddr)
	endif

	if (z80BankAlign&Z80BankAlign_End)<>0
		align $8000
	endif
    endm

; ===========================================================================
; this special macro is used to generate music bank 00 and 02, as it uses custom padding
; which needs to be accounted for by using the length of each file
; and padding until only so much free space is in the bank
Z80Bank_StartBank	macro bankid, lable, filename
	; get total size of all the files
	Z80Bank_Mus00_GetSize \_

	; pad to the start of the first music file; calculated above
	dcb.b (($8000-(offset(*)&$7FFF))-Z80Bank_Mus00_Sz),$FF
	Z80Bank_Start Z80BankAlign_End,"Mus0\bankid"

	; include the files
	rept narg/2
\lable		incbin \filename
		shift
		shift
	endr

	; end the bank.
	Z80Bank_End
    endm

; macro for getting the total size of all files to include in bank Mus01
Z80Bank_Mus00_GetSize	macro bankid, lable, filename
Z80Bank_Mus00_Sz = 	0

	rept narg/2
Z80Bank_Mus00_Sz =	Z80Bank_Mus00_Sz+filesize(\filename)
		shift
		shift
	endr
    endm

; ===========================================================================
; macro to create multiple pointers with macro below
Z80PtrROMBank	macro addr
	rept narg
		Z80PtrROM_ \addr
		shift
	endr
    endm

; creates a single Z80 pointer (relative to bank) to a lable of choice
Z80PtrROM_	macro addr, lable
	if narg>1
\lable
	endif

	dc.w	(((((addr-z80BankAddr)&$7FFF)+$8000)<<8)&$FF00)+((((addr-z80BankAddr)&$7FFF)+$8000)>>8)
    endm

; creates Z80 bank ID from ROM address
MakeBankID	macro addr
	rept narg
		dc.b ((addr&$7F8000)/$8000)
		shift
	endr
    endm

; creates Z80 bank ID from ROM address
MakeBankIDvar	macro addr, lable
\lable equ	((addr&$7F8000)/$8000)
    endm

; macro to create bank ID from DAC numbers (to simplify expressions)
DACMakeBankID	macro num
	rept narg
		MakeBankID (DAC_\num\_Inc+offs)
		shift
	endr
    endm

; macro to create bank ID from DAC numbers (to simplify expressions)
MusMakeBankID	macro lable
.a =	1
	rept narg
Mus_\lable =	.a
		MakeBankID (Music_\lable+offs)
		shift
.a =		.a+1
	endr
    endm

; ===========================================================================
; simple macro to create little endian word values
littleEndian_	macro value, lable
\lable equ 	(((value)<<8)&$FF00)|(((value)>>8)&$FF)
    endm

; simple macro to put a Z80 pointer (relative to bank) to a lable of choice
Z80PtrDo_	macro addr, lable
\lable =	(((((addr-z80BankAddr)&$7FFF)+$8000)<<8)&$FF00)+((((addr-z80BankAddr)&$7FFF)+$8000)>>8)
    endm

; ===========================================================================
; special macro for including a DAC. This not only includes the file,
; but also creates the length and pointer information for later use in DAC_Setup
incDAC		macro name, ext
DAC_\name\_Inc =	offset(*)
	incbin 'snd/DAC/\name\.\ext'
		littleEndian_ offset(*)-DAC_\name\_Inc, DAC_\name\_Len
		Z80PtrDo_ DAC_\name\_Inc, DAC_\name\_Ptr
    endm

; ===========================================================================
; macro used to set up a DAC definition (pitch, length, pointer)
DAC_Setup macro rate, dacptr
	dc.b	\rate
	dc.w	DAC_\dacptr\_Len
	dc.w	DAC_\dacptr\_Ptr
    endm

; ===========================================================================
; this macro lists the universal DAC list definitions for each bank
; used to simplify the disassembly view.
DACBank_Defs	macro	id
	Z80Bank_Start Z80BankAlign_Both,"DAC0\id"
	Z80PtrROMBank	DAC_81_Setup\id, DAC_82_Setup\id, DAC_83_Setup\id
	Z80PtrROMBank	DAC_81_Setup\id, DAC_81_Setup\id, DAC_81_Setup\id
	Z80PtrROMBank	DAC_81_Setup\id, DAC_88_Setup\id, DAC_89_Setup\id
	Z80PtrROMBank	DAC_8A_Setup\id, DAC_8B_Setup\id

; ===========================================================================

DAC_81_Setup\id:	DAC_Setup $08-6,81
DAC_82_Setup\id:	DAC_Setup $08-6,82
DAC_83_Setup\id:	DAC_Setup $1B-8,83
DAC_88_Setup\id:	DAC_Setup $12-8,83
DAC_89_Setup\id:	DAC_Setup $15-8,83
DAC_8A_Setup\id:	DAC_Setup $1B-8,83
DAC_8B_Setup\id:	DAC_Setup $1D-8,83
    endm
; ===========================================================================
; this macro includes Sega PCM and all snd effects into the sfx bank
; used both by S3 and S&K drivers and is identical.
Z80Bank_SFX	macro	bankName
	Z80Bank_Start Z80BankAlign_End, \bankName
SEGA_PCM:	incbin 'snd/DAC/SEGA PCM.bin'
		even

snd_A0:	include 'snd/sfx/A0.asm'
snd_A1:	include 'snd/sfx/A1.asm'
snd_A2:	include 'snd/sfx/A2.asm'
snd_A3:	include 'snd/sfx/A3.asm'
snd_A4:	include 'snd/sfx/A4.asm'
snd_A5:	include 'snd/sfx/A5.asm'
snd_A6:	include 'snd/sfx/A6.asm'
snd_A7:	include 'snd/sfx/A7.asm'
snd_A8:	include 'snd/sfx/A8.asm'
snd_A9:	include 'snd/sfx/A9.asm'
snd_AA:	include 'snd/sfx/AA.asm'
snd_AB:	include 'snd/sfx/AB.asm'
snd_AC:	include 'snd/sfx/AC.asm'
snd_AD:	include 'snd/sfx/AD.asm'
snd_AE:	include 'snd/sfx/AE.asm'
snd_AF:	include 'snd/sfx/AF.asm'
snd_B0:	include 'snd/sfx/B0.asm'
snd_B1:	include 'snd/sfx/B1.asm'
snd_B2:	include 'snd/sfx/B2.asm'
snd_B3:	include 'snd/sfx/B3.asm'
snd_B4:	include 'snd/sfx/B4.asm'
snd_B5:	include 'snd/sfx/B5.asm'
snd_B6:	include 'snd/sfx/B6.asm'
snd_B7:	include 'snd/sfx/B7.asm'
snd_B8:	include 'snd/sfx/B8.asm'
snd_B9:	include 'snd/sfx/B9.asm'
snd_BA:	include 'snd/sfx/BA.asm'
snd_BB:	include 'snd/sfx/BB.asm'
snd_BC:	include 'snd/sfx/BC.asm'
snd_BD:	include 'snd/sfx/BD.asm'
snd_BE:	include 'snd/sfx/BE.asm'
snd_BF:	include 'snd/sfx/BF.asm'
snd_C0:	include 'snd/sfx/C0.asm'
snd_C1:	include 'snd/sfx/C1.asm'
snd_C2:	include 'snd/sfx/C2.asm'
snd_C3:	include 'snd/sfx/C3.asm'
snd_C4:	include 'snd/sfx/C4.asm'
snd_C5:	include 'snd/sfx/C5.asm'
snd_C6:	include 'snd/sfx/C6.asm'
snd_C7:	include 'snd/sfx/C7.asm'
snd_C8:	include 'snd/sfx/C8.asm'
snd_C9:	include 'snd/sfx/C9.asm'
snd_CA:	include 'snd/sfx/CA.asm'
snd_CB:	include 'snd/sfx/CB.asm'
snd_CC:	include 'snd/sfx/CC.asm'
snd_CD:	include 'snd/sfx/CD.asm'
snd_CE:	include 'snd/sfx/CE.asm'
snd_CF:	include 'snd/sfx/CF.asm'
snd_D0:	include 'snd/sfx/D0.asm'
	Z80Bank_End
    endm
; ===========================================================================
; this creates pointers for all SFX in S3 and S&K.
Z80createSFXptrs	macro
	Z80PtrROMBank	snd_B5, snd_CE
	Z80PtrROMBank	snd_A0, snd_A1, snd_A2
	Z80PtrROMBank	snd_A3, snd_A4, snd_A5
	Z80PtrROMBank	snd_A6, snd_A7, snd_A8
	Z80PtrROMBank	snd_A9, snd_AA, snd_AB
	Z80PtrROMBank	snd_AC, snd_AD, snd_AE
	Z80PtrROMBank	snd_AF
	Z80PtrROMBank	snd_B0, snd_B1, snd_B2
	Z80PtrROMBank	snd_B3, snd_B4, snd_B5
	Z80PtrROMBank	snd_B6, snd_B7, snd_B8
	Z80PtrROMBank	snd_B9, snd_BA, snd_BB
	Z80PtrROMBank	snd_BC, snd_BD, snd_BE
	Z80PtrROMBank	snd_BF
	Z80PtrROMBank	snd_C0, snd_C1, snd_C2
	Z80PtrROMBank	snd_C3, snd_C4, snd_C5
	Z80PtrROMBank	snd_C6, snd_C7, snd_C8
	Z80PtrROMBank	snd_C9, snd_CA, snd_CB
	Z80PtrROMBank	snd_CC, snd_CD, snd_CE
	Z80PtrROMBank	snd_CF, snd_D0
    endm
; ===========================================================================

	include "snd/smps2asm.asm"
