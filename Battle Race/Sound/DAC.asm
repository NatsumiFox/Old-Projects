; ===========================================================================
; ---------------------------------------------------------------------------
; Improved DAC table generator for easy DAC manipulation by Natsumi
; ---------------------------------------------------------------------------

; Special BINCLUDE wrapper function
DACBINCLUDE macro file,{INTLABEL}
__LABEL__ label *
	BINCLUDE file
__LABEL___Len  := little_endian(*-__LABEL__-1)
__LABEL___Ptr  := k68z80Pointer(__LABEL__-soundBankStart)
__LABEL___Bank := soundBankStart
    endm

; Setup macro for DAC samples.
DAC_Setup macro rate,dacptr
	dc.b	rate-1
	dc.w	dacptr_Len
	dc.w	dacptr_Ptr
    endm

; ---------------------------------------------------------------------------
; macros by Natsumi
; ---------------------------------------------------------------------------

; simpler packed method for including DAC ID's to generate pointers
dachd		macro NAME
	if "NAME"<>""
		offsetBankTableEntry.w DAC_NAME_Setup_ATTRIBUTE
		shift
		dachd.ATTRIBUTE	ALLARGS		; APPARENTLY, THIS IS HOW THIS IS SYUPPOSED TO WKR IN ASS
						; REPT NÒ WORK BECAUSE SHITTY ASSSSSEMBLER
	endif
    endm

; simpler packed method for including DAC ID's to generate bank ID's
dacbk		macro NAME
	if "NAME"<>""
		db zmake68kBank(DAC_NAME_Data)
		shift
		dacbk	ALLARGS			; APPARENTLY, THIS IS HOW THIS IS SYUPPOSED TO WKR IN ASS
						; REPT NÒ WORK BECAUSE SHITTY ASSSSSEMBLER
	endif
    endm

; duplicatable bank initiation macro

startBankDAC		macro bank, {INTLABEL}
	align	$8000
__LABEL__ label *
soundBankStart := __LABEL__
soundBankName := "__LABEL__"

	; standard set of S&K DAC
	dachd.bank	    81, 82, 83, 84, 85, 86, 87
	dachd.bank	88, 89, 8A, 8B, 8C, 8D, 8E, 8F
	dachd.bank	90, 91, 92, 93, 94, 95, 96, 97
	dachd.bank	98, 99, 9A, 9B, 9C, 9D, 9E, 9F
	dachd.bank	A0, A1, A2, A3, A4, A5, A6, A7
	dachd.bank	A8, A9, AA, AB, AC, AD, AE, AF
	dachd.bank	B0, B1, B2, B3, B4, B5, B6, B7
	dachd.bank	B8_B9, B8_B9, BA, BB, BC, BD, BE, BF
	dachd.bank	C0, C1, C2, C3, C4

	; extra S3 DAC
	dachd.bank	3B2, 3B3;, 3B3

	; custom DAC
	dachd.bank	Clap, ClapKick, Scratch

DAC_81_Setup_bank:	DAC_Setup $04,DAC_81_Data
DAC_82_Setup_bank:	DAC_Setup $0E,DAC_82_83_84_85_Data
DAC_83_Setup_bank:	DAC_Setup $14,DAC_82_83_84_85_Data
DAC_84_Setup_bank:	DAC_Setup $1A,DAC_82_83_84_85_Data
DAC_85_Setup_bank:	DAC_Setup $20,DAC_82_83_84_85_Data
DAC_86_Setup_bank:	DAC_Setup $04,DAC_86_Data
DAC_87_Setup_bank:	DAC_Setup $04,DAC_87_Data
DAC_88_Setup_bank:	DAC_Setup $06,DAC_88_Data
DAC_89_Setup_bank:	DAC_Setup $0A,DAC_89_Data
DAC_8A_Setup_bank:	DAC_Setup $14,DAC_8A_8B_Data
DAC_8B_Setup_bank:	DAC_Setup $1B,DAC_8A_8B_Data
DAC_8C_Setup_bank:	DAC_Setup $08,DAC_8C_Data
DAC_8D_Setup_bank:	DAC_Setup $0B,DAC_8D_8E_Data
DAC_8E_Setup_bank:	DAC_Setup $11,DAC_8D_8E_Data
DAC_8F_Setup_bank:	DAC_Setup $08,DAC_8F_Data
DAC_90_Setup_bank:	DAC_Setup $03,DAC_90_91_92_93_Data
DAC_91_Setup_bank:	DAC_Setup $07,DAC_90_91_92_93_Data
DAC_92_Setup_bank:	DAC_Setup $0A,DAC_90_91_92_93_Data
DAC_93_Setup_bank:	DAC_Setup $0E,DAC_90_91_92_93_Data
DAC_94_Setup_bank:	DAC_Setup $06,DAC_94_95_96_97_Data
DAC_95_Setup_bank:	DAC_Setup $0A,DAC_94_95_96_97_Data
DAC_96_Setup_bank:	DAC_Setup $0D,DAC_94_95_96_97_Data
DAC_97_Setup_bank:	DAC_Setup $12,DAC_94_95_96_97_Data
DAC_98_Setup_bank:	DAC_Setup $0B,DAC_98_99_9A_Data
DAC_99_Setup_bank:	DAC_Setup $13,DAC_98_99_9A_Data
DAC_9A_Setup_bank:	DAC_Setup $16,DAC_98_99_9A_Data
DAC_9B_Setup_bank:	DAC_Setup $0C,DAC_9B_Data
DAC_A2_Setup_bank:	DAC_Setup $0A,DAC_A2_Data
DAC_A3_Setup_bank:	DAC_Setup $18,DAC_A3_Data
DAC_A4_Setup_bank:	DAC_Setup $18,DAC_A4_Data
DAC_A5_Setup_bank:	DAC_Setup $0C,DAC_A5_Data
DAC_A6_Setup_bank:	DAC_Setup $09,DAC_A6_Data
DAC_A7_Setup_bank:	DAC_Setup $18,DAC_A7_Data
DAC_A8_Setup_bank:	DAC_Setup $18,DAC_A8_Data
DAC_A9_Setup_bank:	DAC_Setup $0C,DAC_A9_Data
DAC_AA_Setup_bank:	DAC_Setup $0A,DAC_AA_Data
DAC_AB_Setup_bank:	DAC_Setup $0D,DAC_AB_Data
DAC_AC_Setup_bank:	DAC_Setup $06,DAC_AC_Data
DAC_AD_Setup_bank:	DAC_Setup $10,DAC_AD_AE_Data
DAC_AE_Setup_bank:	DAC_Setup $18,DAC_AD_AE_Data
DAC_AF_Setup_bank:	DAC_Setup $09,DAC_AF_B0_Data
DAC_B0_Setup_bank:	DAC_Setup $12,DAC_AF_B0_Data
DAC_B1_Setup_bank:	DAC_Setup $18,DAC_B1_Data
DAC_B2_Setup_bank:	DAC_Setup $16,DAC_B2_B3_Data
DAC_B3_Setup_bank:	DAC_Setup $20,DAC_B2_B3_Data
DAC_B4_Setup_bank:	DAC_Setup $0C,DAC_B4_C1_C2_C3_C4_Data
DAC_B5_Setup_bank:	DAC_Setup $0C,DAC_B5_Data
DAC_B6_Setup_bank:	DAC_Setup $0C,DAC_B6_Data
DAC_B7_Setup_bank:	DAC_Setup $18,DAC_B7_Data
DAC_B8_B9_Setup_bank:	DAC_Setup $0C,DAC_B8_B9_Data
DAC_BA_Setup_bank:	DAC_Setup $18,DAC_BA_Data
DAC_BB_Setup_bank:	DAC_Setup $18,DAC_BB_Data
DAC_BC_Setup_bank:	DAC_Setup $18,DAC_BC_Data
DAC_BD_Setup_bank:	DAC_Setup $0C,DAC_BD_Data
DAC_BE_Setup_bank:	DAC_Setup $0C,DAC_BE_Data
DAC_BF_Setup_bank:	DAC_Setup $1C,DAC_BF_Data
DAC_C0_Setup_bank:	DAC_Setup $0B,DAC_C0_Data
DAC_C1_Setup_bank:	DAC_Setup $0F,DAC_B4_C1_C2_C3_C4_Data
DAC_C2_Setup_bank:	DAC_Setup $11,DAC_B4_C1_C2_C3_C4_Data
DAC_C3_Setup_bank:	DAC_Setup $12,DAC_B4_C1_C2_C3_C4_Data
DAC_C4_Setup_bank:	DAC_Setup $0B,DAC_B4_C1_C2_C3_C4_Data
DAC_9C_Setup_bank:	DAC_Setup $0A,DAC_9C_Data
DAC_9D_Setup_bank:	DAC_Setup $18,DAC_9D_Data
DAC_9E_Setup_bank:	DAC_Setup $18,DAC_9E_Data
DAC_9F_Setup_bank:	DAC_Setup $0C,DAC_9F_Data
DAC_A0_Setup_bank:	DAC_Setup $0C,DAC_A0_Data
DAC_A1_Setup_bank:	DAC_Setup $0A,DAC_A1_Data
DAC_3B2_Setup_bank:	DAC_Setup $16,DAC3_B2_B3_Data
DAC_3B3_Setup_bank:	DAC_Setup $20,DAC3_B2_B3_Data
DAC_Clap_Setup_bank:	DAC_Setup $18,DAC_Clap_Data
DAC_ClapKick_Setup_bank:DAC_Setup $18,DAC_ClapKick_Data
DAC_Scratch_Setup_Bank:	DAC_Setup $09,DAC_Scratch_Data
    endm

bank1
; ===========================================================================
; DAC Banks
; ===========================================================================
; DAC Bank 1
; ---------------------------------------------------------------------------
DacBank1:			startBankDAC 1
	if MOMPASS=1
		message "DAC1 has $\{DacBank1-bank1} bytes free before."
	endif

DAC_86_Data:			DACBINCLUDE "Sound/DAC/86.bin"
DAC_81_Data:			DACBINCLUDE "Sound/DAC/81.bin"
DAC_82_83_84_85_Data:		DACBINCLUDE "Sound/DAC/82-85.bin"
DAC_94_95_96_97_Data:		DACBINCLUDE "Sound/DAC/94-97.bin"
DAC_90_91_92_93_Data:		DACBINCLUDE "Sound/DAC/90-93.bin"
DAC_88_Data:			DACBINCLUDE "Sound/DAC/88.bin"
DAC_8A_8B_Data:			DACBINCLUDE "Sound/DAC/8A-8B.bin"
DAC_8C_Data:			DACBINCLUDE "Sound/DAC/8C.bin"
DAC_8D_8E_Data:			DACBINCLUDE "Sound/DAC/8D-8E.bin"
DAC_87_Data:			DACBINCLUDE "Sound/DAC/87.bin"
DAC_8F_Data:			DACBINCLUDE "Sound/DAC/8F.bin"
DAC_89_Data:			DACBINCLUDE "Sound/DAC/89.bin"
DAC_98_99_9A_Data:		DACBINCLUDE "Sound/DAC/98-9A.bin"
DAC_9B_Data:			DACBINCLUDE "Sound/DAC/9B.bin"
DAC_B2_B3_Data:			DACBINCLUDE "Sound/DAC/B2-B3.bin"
DAC3_B2_B3_Data:		DACBINCLUDE "Sound/DAC/B2-B3 S3.bin"
DAC_Clap_Data:			DACBINCLUDE "Sound/DAC/Dance Clap.bin"
DAC_ClapKick_Data:		DACBINCLUDE "Sound/DAC/Dance Clap & Kick.bin"
DAC_A8_Data:			DACBINCLUDE "Sound/DAC/A8.bin"
	finishBank

; ---------------------------------------------------------------------------
; Dac Bank 2
; ---------------------------------------------------------------------------
DacBank2:	startBankDAC 2

DAC_9C_Data:			DACBINCLUDE "Sound/DAC/9C.bin"
DAC_9D_Data:			DACBINCLUDE "Sound/DAC/9D.bin"
DAC_9E_Data:			DACBINCLUDE "Sound/DAC/9E.bin"
DAC_9F_Data:			DACBINCLUDE "Sound/DAC/9F.bin"
DAC_A0_Data:			DACBINCLUDE "Sound/DAC/A0.bin"
DAC_A1_Data:			DACBINCLUDE "Sound/DAC/A1.bin"
DAC_A2_Data:			DACBINCLUDE "Sound/DAC/A2.bin"
DAC_A3_Data:			DACBINCLUDE "Sound/DAC/A3.bin"
DAC_A4_Data:			DACBINCLUDE "Sound/DAC/A4.bin"
DAC_A5_Data:			DACBINCLUDE "Sound/DAC/A5.bin"
DAC_A6_Data:			DACBINCLUDE "Sound/DAC/A6.bin"
DAC_A7_Data:			DACBINCLUDE "Sound/DAC/A7.bin"
DAC_A9_Data:			DACBINCLUDE "Sound/DAC/A9.bin"
DAC_AA_Data:			DACBINCLUDE "Sound/DAC/AA.bin"
DAC_BC_Data:			DACBINCLUDE "Sound/DAC/BC.bin"
DAC_AF_B0_Data:			DACBINCLUDE "Sound/DAC/AF-B0.bin"
	finishBank

; ---------------------------------------------------------------------------
; Dac Bank 3
; ---------------------------------------------------------------------------
DacBank3:	startBankDAC 3

DAC_AB_Data:			DACBINCLUDE "Sound/DAC/AB.bin"
DAC_AC_Data:			DACBINCLUDE "Sound/DAC/AC.bin"
DAC_AD_AE_Data:			DACBINCLUDE "Sound/DAC/AD-AE.bin"
DAC_B1_Data:			DACBINCLUDE "Sound/DAC/B1.bin"
DAC_B4_C1_C2_C3_C4_Data:	DACBINCLUDE "Sound/DAC/B4C1-C4.bin"
DAC_B5_Data:			DACBINCLUDE "Sound/DAC/B5.bin"
DAC_B6_Data:			DACBINCLUDE "Sound/DAC/B6.bin"
DAC_B7_Data:			DACBINCLUDE "Sound/DAC/B7.bin"
DAC_B8_B9_Data:			DACBINCLUDE "Sound/DAC/B8-B9.bin"
DAC_BA_Data:			DACBINCLUDE "Sound/DAC/BA.bin"
DAC_BB_Data:			DACBINCLUDE "Sound/DAC/BB.bin"
DAC_BD_Data:			DACBINCLUDE "Sound/DAC/BD.bin"
DAC_BE_Data:			DACBINCLUDE "Sound/DAC/BE.bin"
DAC_BF_Data:			DACBINCLUDE "Sound/DAC/BF.bin"
DAC_C0_Data:			DACBINCLUDE "Sound/DAC/C0.bin"
DAC_Scratch_Data:		DACBINCLUDE "Sound/DAC/Scratches.bin"
	finishBank
