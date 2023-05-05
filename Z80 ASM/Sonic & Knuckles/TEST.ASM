	org 0
	opt m+	; print better macro info
align	macro al
	cnop 0,\al
    endm
STACK =		$000000

;	if 0=1
    		dc.l STACK, EntryPoint, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l HBlank, ErrorTrap, VBlank, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
Console:	dc.b "SEGA     Natsumi"
ErrorTrap:	bra.s	ErrorTrap
		dc.b "    2017/05/03"
		dc.b "Z80 > ASM68K ASSEMBLY TEST PROGRAM              "
		dc.b "Z80 > ASM68K ASSEMBLY TEST PROGRAM              "
		dc.b "NATSUMI       "
		dc.w 0
		dc.b 'J       '
		dc.b "        "
		dc.l 0
		dc.l EndOfRom-1
		dc.l $FF0000
		dc.l $FFFFFF
		dc.b 'RO  '
		dc.l $200000
		dc.l $3FFFFF
		dc.b '                                                    '
		dc.b 'JUE             '

EntryPoint:
		bsr.s	@getdrv
	;	moveq	#-1,d0
	;	dbf	d0,*

		move.w	#$100,($A11100).l
@stupp		btst	#0,($A11100).l
		bne.s	@stupp
		move.b	#1,$A00000+$1C0A
		move.w	#0,($A11100).l
		stop	#$2700

@getdrv		move.w	#$100,($A11100).l
		bsr.s	@resetZ80

@waitZ80stop	btst	#0,($A11100).l
		bne.s	@waitZ80stop
		lea	drv(pc),a0
		move.w	#drvsz-1,d0
		lea	($A00000).l,a1

@loaddriver	move.b	(a0)+,(a1)+
		dbf	d0,@loaddriver

		move.w	#$2000-drvsz-1,d0
		moveq	#0,d1

@clrram		move.b	d1,(a1)+
		dbf	d0,@clrram

		bsr.s	@resetZ80
		move.w	#0,($A11100).l
		rts

@resetZ80	move.w	#0,($A11200).l
		movem.l	d0-a2,-(sp)
		movem.l	(sp)+,d0-a2
		move.w	#$100,($A11200).l
		rts

HBlank:
VBlank:
		rte

	include "LANG.ASM"
	include "smps2asm.ASM"

drv:
zbank:
	z80prog 0
	include "SMPS.ASM"
drvsz:
	z80prog

; ===========================================================================
; macro to create multiple pointers with macro below
Z80PtrROMBank	macro addr
	rept narg
		dw ((\addr-z80BankAddr)&$7FFF)+$8000
		shift
	endr
    endm

; ===========================================================================
; declares start of a bank, and sets some variables
Z80Bank_Start	macro	name
	align $8000
z80BankAddr =	(*&$FF8000)
z80BankName 	equs \name
	obj $8000
    endm

; macro to do everything needed for end of bank.
; also warns if the bank overflows
Z80Bank_End	macro
	objend
	if *>z80BankAddr+$8000
		inform 1,"Z80 bank %s is too large! Its size is $%h, $%h bytes larger than max.", "\z80BankName", *-z80BankAddr, (*-z80BankAddr)-$8000
	else
		inform 0,"Z80 bank %s has $%h free bytes.", "\z80BankName", $8000-(*-z80BankAddr)
	endif
    endm


; ===========================================================================
; special macro for including a DAC. This not only includes the file,
; but also creates the length and pointer information for later use in DAC_Setup
incDAC		macro name, ext
DAC_\name\_Inc =	(*&$7FFF)+z80BankAddr
	incbin 'DAC/\name\.\ext'
DAC_\name\_Ptr = DAC_\name\_Inc&$7FFF|$8000
DAC_\name\_Len = *-DAC_\name\_Ptr
    endm

; ===========================================================================
; macro used to set up a DAC definition (pitch, length, pointer)
DAC_Setup macro rate, dacptr
	dc.b	\rate
	dw DAC_\dacptr\_Len, DAC_\dacptr\_Ptr
    endm

DACBank_Defs	macro	id
	Z80Bank_Start	"DAC0\id"
	dw DAC_81_Setup\id, DAC_82_Setup\id, DAC_83_Setup\id, DAC_84_Setup\id
	dw DAC_85_Setup\id, DAC_86_Setup\id, DAC_87_Setup\id, DAC_88_Setup\id
	dw DAC_89_Setup\id, DAC_8A_Setup\id, DAC_8B_Setup\id, DAC_8C_Setup\id
	dw DAC_8D_Setup\id, DAC_8E_Setup\id, DAC_8F_Setup\id

	dw DAC_90_Setup\id, DAC_91_Setup\id, DAC_92_Setup\id, DAC_93_Setup\id
	dw DAC_94_Setup\id, DAC_95_Setup\id, DAC_96_Setup\id, DAC_97_Setup\id
	dw DAC_98_Setup\id, DAC_99_Setup\id, DAC_9A_Setup\id, DAC_9B_Setup\id
	dw DAC_9C_Setup\id, DAC_9D_Setup\id, DAC_9E_Setup\id, DAC_9F_Setup\id

	dw DAC_A0_Setup\id, DAC_A1_Setup\id, DAC_A2_Setup\id, DAC_A3_Setup\id
	dw DAC_A4_Setup\id, DAC_A5_Setup\id, DAC_A6_Setup\id, DAC_A7_Setup\id
	dw DAC_A8_Setup\id, DAC_A9_Setup\id, DAC_AA_Setup\id, DAC_AB_Setup\id
	dw DAC_AC_Setup\id, DAC_AD_Setup\id, DAC_AE_Setup\id, DAC_AF_Setup\id

	dw DAC_B0_Setup\id, DAC_B1_Setup\id, DAC_B2_Setup\id, DAC_B3_Setup\id
	dw DAC_B4_Setup\id, DAC_B5_Setup\id, DAC_B6_Setup\id, DAC_B7_Setup\id
	dw DAC_B8_B9_Setup\id, DAC_B8_B9_Setup\id, DAC_BA_Setup\id, DAC_BB_Setup\id
	dw DAC_BC_Setup\id, DAC_BD_Setup\id, DAC_BE_Setup\id, DAC_BF_Setup\id

	dw DAC_C0_Setup\id, DAC_C1_Setup\id, DAC_C2_Setup\id, DAC_C3_Setup\id
	dw DAC_C4_Setup\id
; ===========================================================================

DAC_81_Setup\id:	DAC_Setup $04,81
DAC_82_Setup\id:	DAC_Setup $0E,82_85
DAC_83_Setup\id:	DAC_Setup $14,82_85
DAC_84_Setup\id:	DAC_Setup $1A,82_85
DAC_85_Setup\id:	DAC_Setup $20,82_85
DAC_86_Setup\id:	DAC_Setup $04,86
DAC_87_Setup\id:	DAC_Setup $04,87
DAC_88_Setup\id:	DAC_Setup $06,88
DAC_89_Setup\id:	DAC_Setup $0A,89
DAC_8A_Setup\id:	DAC_Setup $14,8A_8B
DAC_8B_Setup\id:	DAC_Setup $1B,8A_8B
DAC_8C_Setup\id:	DAC_Setup $08,8C
DAC_8D_Setup\id:	DAC_Setup $0B,8D_8E
DAC_8E_Setup\id:	DAC_Setup $11,8D_8E
DAC_8F_Setup\id:	DAC_Setup $08,8F
DAC_90_Setup\id:	DAC_Setup $03,90_93
DAC_91_Setup\id:	DAC_Setup $07,90_93
DAC_92_Setup\id:	DAC_Setup $0A,90_93
DAC_93_Setup\id:	DAC_Setup $0E,90_93
DAC_94_Setup\id:	DAC_Setup $06,94_97
DAC_95_Setup\id:	DAC_Setup $0A,94_97
DAC_96_Setup\id:	DAC_Setup $0D,94_97
DAC_97_Setup\id:	DAC_Setup $12,94_97
DAC_98_Setup\id:	DAC_Setup $08,98_9A
DAC_99_Setup\id:	DAC_Setup $13,98_9A
DAC_9A_Setup\id:	DAC_Setup $16,98_9A
DAC_9B_Setup\id:	DAC_Setup $16,9B
DAC_A2_Setup\id:	DAC_Setup $0A,A2
DAC_A3_Setup\id:	DAC_Setup $18,A3
DAC_A4_Setup\id:	DAC_Setup $18,A4
DAC_A5_Setup\id:	DAC_Setup $0C,A5
DAC_A6_Setup\id:	DAC_Setup $09,A6
DAC_A7_Setup\id:	DAC_Setup $18,A7
DAC_A8_Setup\id:	DAC_Setup $18,A8
DAC_A9_Setup\id:	DAC_Setup $0C,A9
DAC_AA_Setup\id:	DAC_Setup $0A,AA
DAC_AB_Setup\id:	DAC_Setup $0D,AB
DAC_AC_Setup\id:	DAC_Setup $06,AC
DAC_AD_Setup\id:	DAC_Setup $10,AD_AE
DAC_AE_Setup\id:	DAC_Setup $18,AD_AE
DAC_AF_Setup\id:	DAC_Setup $09,AF_B0
DAC_B0_Setup\id:	DAC_Setup $12,AF_B0
DAC_B1_Setup\id:	DAC_Setup $18,B1
DAC_B2_Setup\id:	DAC_Setup $16,B2_B3_S3
DAC_B3_Setup\id:	DAC_Setup $20,B2_B3_S3
DAC_B4_Setup\id:	DAC_Setup $0C,B4C1_C4
DAC_B5_Setup\id:	DAC_Setup $0C,B5
DAC_B6_Setup\id:	DAC_Setup $0C,B6
DAC_B7_Setup\id:	DAC_Setup $18,B7
DAC_B8_B9_Setup\id:	DAC_Setup $0C,B8_B9
DAC_BA_Setup\id:	DAC_Setup $18,BA
DAC_BB_Setup\id:	DAC_Setup $18,BB
DAC_BC_Setup\id:	DAC_Setup $18,BC
DAC_BD_Setup\id:	DAC_Setup $0C,BD
DAC_BE_Setup\id:	DAC_Setup $0C,BE
DAC_BF_Setup\id:	DAC_Setup $1C,BF
DAC_C0_Setup\id:	DAC_Setup $0B,C0
DAC_C1_Setup\id:	DAC_Setup $0F,B4C1_C4
DAC_C2_Setup\id:	DAC_Setup $11,B4C1_C4
DAC_C3_Setup\id:	DAC_Setup $12,B4C1_C4
DAC_C4_Setup\id:	DAC_Setup $0B,B4C1_C4
DAC_9C_Setup\id:	DAC_Setup $0A,9C
DAC_9D_Setup\id:	DAC_Setup $18,9D
DAC_9E_Setup\id:	DAC_Setup $18,9E
DAC_9F_Setup\id:	DAC_Setup $0C,9F
DAC_A0_Setup\id:	DAC_Setup $0C,A0
DAC_A1_Setup\id:	DAC_Setup $0A,A1
    endm

	opt w-
	opt ae-

; ===========================================================================
	DACBank_Defs 0	; create ROM pointers and setup information about DACs
	incDAC 9B, bin
	incDAC 9C, bin
	incDAC 9D, bin
	incDAC 9E, bin
	incDAC 9F, bin
	incDAC A0, bin
	incDAC A1, bin
	incDAC A2, bin
	incDAC A3, bin
	incDAC A4, bin
	incDAC A5, bin
	incDAC A6, bin
	incDAC A7, bin
	incDAC A8, bin
	incDAC A9, bin
	incDAC AA, bin
	Z80Bank_End

; ===========================================================================
	DACBank_Defs 1	; create ROM pointers and setup information about DACs
	incDAC AB, bin
	incDAC AC, bin
	incDAC AD_AE, bin
	incDAC AF_B0, bin
	incDAC B0_Unused, bin
	incDAC B1, bin
	incDAC B2_B3_S3, bin
	incDAC B4C1_C4, bin
	incDAC B5, bin
	incDAC B6, bin
	incDAC B7, bin
	incDAC B8_B9, bin
	incDAC BA, bin
	incDAC BB, bin
	incDAC BC, bin
	incDAC BD, bin
	incDAC BE, bin
	incDAC BF, bin
	incDAC C0, bin
	Z80Bank_End
; ===========================================================================

	DACBank_Defs 2	; create ROM pointers and setup information about DACs
	incDAC 86, bin
	incDAC 81, bin
	incDAC 82_85, bin
	incDAC 94_97, bin
	incDAC 90_93, bin
	incDAC 88, bin
	incDAC 8A_8B, bin
	incDAC 8C, bin
	incDAC 8D_8E, bin
	incDAC 87, bin
	incDAC 8F, bin
	incDAC 89, bin
	incDAC 98_9A, bin
mus:	include "LBZ2.ASM"
mus2:	include "Menu.ASM"
	Z80Bank_End
musbnk:
; ===========================================================================

EndOfRom:
	END
