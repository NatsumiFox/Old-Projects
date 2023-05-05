; ===========================================================================
; ---------------------------------------------------------------------------
; Sky Sanctuary Zone - Mini-Game theme
; ---------------------------------------------------------------------------

SSZMG_Header:
		sHeaderInit
		sHeaderPatch	SSZ_Patches
		sHeaderCh	$06, $03
		sHeaderTempo	$01, $10	; $04
		sHeaderDAC	SSZMG_DAC
		sHeaderFM	SSZMG_FM1, $00, $00
		sHeaderFM	SSZMG_FM2, $00, $00
		sHeaderFM	SSZMG_FM3, $00, $00
		sHeaderFM	SSZMG_FM4, $00, $00
		sHeaderFM	SSZMG_FM5, $00, $00
		sHeaderPSG	SSZMG_PSG1, $F4, $05, $00, VolEnv_00
		sHeaderPSG	SSZMG_PSG2, $F4, $05, $00, VolEnv_00
		sHeaderPSG	SSZMG_PSG3, $00, $02, $00, VolEnv_00

; ===========================================================================
; ---------------------------------------------------------------------------
; DAC
; ---------------------------------------------------------------------------

SSZMG_DAC:

	; --- SSZ Intro ---

		dc.b	$80,$60,$80,$60
		dc.b	$80,$60,$80,$30

	; --- Clouds Intro ---

		dc.b dSnare, $0C, $0C, $06, $06, $06, $06

	; --- Clouds Verse ---

SSZMG_DAC_CloudsVerse:
		sCall		SSZ_DAC_MainBeat1
		dc.b dSnare, $06, $06, $06, dKick
		sCall		SSZ_DAC_MainBeat1
		dc.b dSnare, $06, $06, $06, dKick
		sCall		SSZ_DAC_MainBeat1
		dc.b dSnare, $06, $06, $06, dKick
		sCall		SSZ_DAC_MainBeat1
		dc.b dHighTom, $06, dMidTom, dLowTom, dFloorTom

	; --- SSZ Verse ---


SSZ_Loop18aaaa:
		sCall	SSZ_DAC_0
		sLoop	$00, $05, SSZ_Loop18aaaa
		sPan	spCenter, $00
		sJump	SSZMG_DAC





	; --- Cloud subroutines ---


SSZ_DAC_MainBeat1:
		sCall		.beat
		dc.b dSnare, $18
		sCall		.beat
		dc.b dSnare, $06, dKick, $12
		sCall		.beat
		dc.b dSnare, $18

.beat		dc.b dKick, $18, dSnare, $12
		dc.b dKick, $06, $0C, $0C
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 1
; ---------------------------------------------------------------------------

SSZMG_FM1:

	; --- SSZ Intro ---

		sPatFM	$00
		saTranspose $E8
		ssVol $0D
		saDetune $FE
		dc.b nG2, $08, nRst, $04, nG2, $08, nRst, $04
		dc.b $24, nG3, nG2, nG2, $0C, nRst, nC3, $14
		dc.b nB2, $10, nG2, $08, nRst, $04, nG2, $08
		dc.b nRst, $04, $24, nG3, nG2, nG2, $0C

	; --- Clouds Intro ---

		sPatFM	$04	; FM_CLStatPiano
		saTranspose $18
		ssVol $12-4
		saDetune $00

SSZMG_FM1_CloudVerse:
		dc.b nCs4, $06, nD4, nEb4, nE4, nF4, nFs4, nG4, nAb4

	; --- Clouds Verse ---

;SSZMG_FM1_CloudVerse:
		dc.b nA4, $60, nG4, $48, nFs4, $18, nE4, $30
		dc.b nCs4, $18, nE4, nD4, $30, nB3
		dc.b nA4, $60, nG4, $30, nFs4, $18, nG4, nFs4, $48
		dc.b nD4, $18, nE4, $30
		sLoop	$00,$02,SSZMG_FM1_CloudVerse
		dc.b	sHold, $30

	; --- SSZ Verse ---



		ssModZ80	$24, $01, $04, $08
		sPatFM		$01

		ssVol $15-$03
		sCall		SSZ_FM5_0
		dc.b	nC6, $07, nRst, $05, nC6, $54, sHold, $60, sHold, $60, sHold, $60
		sJump	SSZMG_FM1

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 2
; ---------------------------------------------------------------------------

SSZMG_FM2:

	; --- SSZ Intro ---

		ssVol $15
		sCall SSZ_FM5_Intro
		dc.b nC5, $12, nB4
		saVolFM	$FF
		dc.b nG4, $0C, nRst
		saVolFM	$01
		dc.b nG4, nRst, $18

	; --- Clouds Verse ---

		saTranspose -$18
		ssVol $0C
		sPatFM $06	; FM_CLSlapBass

SSZMG_FM2_CloudsBass:
		sCall SSZ_FM_MainBass
		saTranspose -$02
		sCall SSZ_FM_MainBass
		saTranspose $02
		sCall SSZ_FM_MainBass
		saTranspose -$02
		sCall SSZ_FM_EndBass
		saTranspose $02
		sLoop	$00,$03,SSZMG_FM2_CloudsBass


		sCall SSZ_FM_MainBass
		saTranspose -$02
		sCall SSZ_FM_MainBass
		saTranspose $02
		sCall SSZ_FM_MainBass
		saTranspose -$02
		sCall 	SSZ_FM_EndBass1
		dc.b nCs5, $06, nRst, nCs5-1, nRst, nCs5, nCs5, nEb5, $0C
		saTranspose $02



		saTranspose $03

SSZMG_FM2_SSZBass:
		sCall	SSZ_FM_MainBass
		sCall	SSZ_FM_MainBass
		saTranspose -$02
		sCall	SSZ_FM_MainBass
		sCall	SSZ_FM_MainBass
		saTranspose -$01
		sCall	SSZ_FM_MainBass
		sCall 	SSZ_FM_MainBass
		saTranspose -$01
		sCall 	SSZ_FM_MainBass
		sCall 	SSZ_FM_EndBass1
		saTranspose $02
		sCall	SSZ_FM_EndBass2
		saTranspose $02
		sLoop $00, $02,SSZMG_FM2_SSZBass

	; --- Ending ---

		saTranspose -$03

		sPatFM	$00
		ssVol $0D
		saDetune $FE

SSZMG_FM1_Ending:
		dc.b nG2, $08, nRst, $04, nG2, $08, nRst, $04
		dc.b $24, nG3, nG2, nG2, $0C, nRst, nC3, $14
		dc.b nB2, $10
		sLoop	$00,$02,SSZMG_FM1_Ending
		saTranspose $18

		sJump	SSZMG_FM2







SSZ_FM_MainBass:
		dc.b nA4, $18, $06, nRst, $1E
		dc.b nA4, $0C, nG4, $06, nA4, nRst, $0C
		sRet

SSZ_FM_EndBass:
		sCall	SSZ_FM_EndBass1

SSZ_FM_EndBass2:
		dc.b nE5, $06, nRst, nEb5, nRst, nCs5, nCs5, nA4, $0C
		sRet

SSZ_FM_EndBass1:
		dc.b nA4, $18, $06, nRst, $0C
		dc.b nA4, $06
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 3
; ---------------------------------------------------------------------------

SSZMG_FM3:

	; --- SSZ Intro ---

		ssVol	$17
		sPatFM	$01
		dc.b nRst, $60, nRst, nF5, $12, nE5, nC5, $0C
		dc.b nC6, $12, nB5, nG5, $0C, nF5, $12
		dc.b nE5
		saVolFM		$FF
		dc.b nC5, $0C, nRst
		saVolFM		$01
		dc.b nB4, nRst, $18

	; --- Clouds Verse ---

		ssVol $18-4
		sPatFM $05	; FM_CLSynPiano

SSZMG_FM3_CloudsVerse:
		dc.b nA1, $60, $30, nB1, $30, nB1, $60, nA1, $60
		sLoop	$00,$03,SSZMG_FM3_CloudsVerse
		dc.b nA1, $60, $30, nB1, $30, nB1, $60, nA1, $30
		dc.b	nA1, $18, nA1+2

	; --- SSZ Verse ---

		saTranspose $03

SSZMG_FM3_SSZVerse:
		dc.b	nA1,$60,nA1,$60
		saTranspose -$02
		dc.b	nA1,$60,nA1,$60
		saTranspose -$01
		dc.b	nA1,$60,nA1,$60
		saTranspose -$01
		dc.b	nA1,$60,nA1,$60
		saTranspose $04
		sLoop	$00,$02,SSZMG_FM3_SSZVerse

		saTranspose -$03

		dc.b	$80,$60,$80,$60
		dc.b	$80,$60,$80,$60
		sJump	SSZMG_FM3
		sStop

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 4
; ---------------------------------------------------------------------------

SSZMG_FM4:

	; --- SSZ Intro ---

		ssVol	$17
		sCall	SSZ_FM4_Intro
		dc.b $80, $08
		sCall	SSZ_FM5_Intro
		dc.b nC5, $12, nB4
		saVolFM	$FF
		dc.b nG4, $0C,$80,$03

	; --- Clouds Intro ---

		ssModZ80 $01, $02, $03, $08
		ssVol $18-4
		sPatFM $04	; FM_CLStatPiano

SSZMG_FM4_CloudsVerse:
		dc.b nCs4, $06, nD4, nEb4, nE4, nF4, nFs4, nG4, nAb4

	; --- Clouds Verse ---

; SSZMG_FM4_CloudsVerse:
		dc.b nA4, $60, nG4, $48, nFs4, $18, nE4, $30
		dc.b nCs4, $18, nE4, nD4, $30, nB3
		dc.b nA4, $60, nG4, $30, nFs4, $18, nG4, nFs4, $48
		dc.b nD4, $18, nE4, $30
		sLoop	$00,$02,SSZMG_FM4_CloudsVerse
		dc.b	sHold, $30

	; --- SSZ Verse ---

		dc.b	$80,$03

		ssModZ80	$24, $01, $04, $08
		sPatFM		$01
		ssVol $17-$03
		sCall		SSZ_FM5_0
		dc.b	nC6, $07, nRst, $05, nC6, $54, sHold, $60, sHold, $60, sHold, $60-$0E
		sJump	SSZMG_FM4

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 5
; ---------------------------------------------------------------------------

SSZMG_FM5:
		dc.b	$80,$60,$80,$60
		dc.b	$80,$60,$80,$60

	; --- Clouds Verse ---

		ssVol $18-4
		sPatFM $05	; FM_CLSynPiano

SSZMG_FM5_CloudsVerse:
		dc.b nFs1, $30, nG1, $30, $60, nFs1, $30, $30, nE1, $60
		sLoop	$00,$03,SSZMG_FM5_CloudsVerse
		dc.b nFs1, $30, nG1, $30, $60, nFs1, $30, $30, nE1, $30
		dc.b nFs1+0, $18, nFs1+2

	; --- SSZ Verse ---

		saTranspose $03

SSZMG_FM5_SSZVerse:
		dc.b	nFs1,$60,nFs1,$60
		saTranspose -$02
		dc.b	nFs1,$60,nFs1,$60
		saTranspose -$02
		dc.b	nFs1,$60,nFs1,$60
		saTranspose -$02
		dc.b	nFs1,$60,nFs1,$60
		saTranspose $06
		sLoop	$00,$02,SSZMG_FM5_SSZVerse

		saTranspose -$03

		dc.b	$80,$60,$80,$60
		dc.b	$80,$60,$80,$60
		sJump	SSZMG_FM5

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG 1
; ---------------------------------------------------------------------------

SSZMG_PSG1:

	; --- SSZ Intro ---

		sCall	SSZ_PSG1_Intro

	; --- Clouds Verse ---

SSZMG_PSG1_Section:

		saTranspose	$18
		ssModZ80	$01, $02, $02, $04
		sVolEnvPSG	$26
		sJump		SSZMG_PSG1_CloudsInit

SSZMG_PSG1_Clouds:
		dc.b	nCs1, $60, nB0, nCs1, nD1, $30

SSZMG_PSG1_CloudsInit:
		dc.b	nFs1, $18, nE1
		sLoop $00,$05,SSZMG_PSG1_Clouds

;SSZMG_PSG1_CloudsFade:
;		saVolPSG $01
;		dc.b	nCs1, $18
;		sLoop $00,$0C,SSZMG_PSG1_CloudsFade
		saTranspose -$18



	sVolEnvPSG	VolEnv_04
	sModOff
;	saVolPSG	$05

SSZ_Loop3aaa:
	sCall		SSZ_Call1
	sLoop		$00, $0A, SSZ_Loop3aaa
	sJump	SSZMG_PSG1

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG 2
; ---------------------------------------------------------------------------

SSZMG_PSG2:

	; --- Clouds Verse ---

		saVolPSG $03
		saDetune -$04
		dc.b	nRst, $0C
		saTranspose	$18

SSZMG_PSG2_Loop:
		dc.b	$80,$60,$80,$60
		dc.b	$80,$60,$80,$30

		ssModZ80	$01, $02, $02, $04
		sVolEnvPSG	$26
		sJump		SSZMG_PSG2_CloudsInit

SSZMG_PSG2_Clouds:
		dc.b	nCs1, $60, nB0, nCs1, nD1, $30

SSZMG_PSG2_CloudsInit:
		dc.b	nFs1, $18, nE1
		sLoop $00,$05,SSZMG_PSG2_Clouds


SSZMG_PSG2_Silence:
		dc.b	$80,$60
		sLoop	$00,$14,SSZMG_PSG2_Silence
		sJump	SSZMG_PSG2_Loop

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG 3
; ---------------------------------------------------------------------------

SSZMG_PSG3:

	; --- SSZ Intro ---

		sCall	SSZ_PSG3_0
		sLoop	$00,$10,SSZMG_PSG3

	; --- Clouds Verse ---

		sNoisePSG $E4
		saVolPSG -$02

SSZMG_PSG3_Clouds:
		sVolEnvPSG VolEnv_01
		dc.b nA6, $06, $06, $06, $06
		sVolEnvPSG VolEnv_04
		dc.b nA6, $06, nRst, nA6, nRst
		sLoop $00,$20,SSZMG_PSG3_Clouds


	; --- SSZ Verse ---

		saVolPSG $02

SSZMG_PSG3_SSZVerse:
		sCall	SSZ_PSG3_0
		sLoop	$00,$50,SSZMG_PSG3_SSZVerse
		sJump	SSZMG_PSG3

; ===========================================================================