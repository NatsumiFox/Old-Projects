; ===========================================================================
; ---------------------------------------------------------------------------
; Carnival Night Zone 1 Mini Game
; ---------------------------------------------------------------------------

CNZ1MG_Header:
	sHeaderInit
	sHeaderPatch	CNZ1MG_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $44
	sHeaderDAC	CNZ1MG_DAC
	sHeaderFM	CNZ1MG_FM1, $00, $0B
	sHeaderFM	CNZ1MG_FM2, $00, $06
	sHeaderFM	CNZ1MG_FM3, $00, $07
	sHeaderFM	CNZ1MG_FM4, $00, $05
	sHeaderFM	CNZ1MG_FM5, $0C, $13
	sHeaderPSG	CNZ1MG_PSG1, $F4, $04, $00, VolEnv_00
	sHeaderPSG	CNZ1MG_PSG2, $F4, $04, $00, VolEnv_00
	sHeaderPSG	CNZ1MG_PSG3, $23, $01, $00, VolEnv_00

; ===========================================================================
; ---------------------------------------------------------------------------
; Various subroutines
; ---------------------------------------------------------------------------

	; --- Carnival intros ---

CNZ1MG_FM1_Intro:
	dc.b nE5, $05, nRst, $07, nEb5, $05, nRst, $07
	dc.b nD5, nEb5, $05, nD5, $07, nCs5, $05, nC5
	dc.b nRst, $07, nB4, $05, nRst, $07, nBb4, $0C
	dc.b nA4, $05, nRst, $07
	sRet

CNZ1MG_FM5_Intro:
	dc.b nC5, $06, nRst, nB4
	dc.b nRst, nBb4, $07, nB4, $05, nBb4, $07, nA4
	dc.b $05, nAb4, $05, nRst, $07, nG4, $05, nRst
	dc.b $07, nFs4, $0C, nF4, $05, nRst, $07
	sRet

	; --- Background flutes (Going down) ---

CNZ1MG_FluteDown_L:
	dc.b nRst, $0C, nG4, $18, nFs4, nF4, nE4, $0C
	sRet

CNZ1MG_FluteDown_R:
	dc.b nC4, $0C, nE4, nFs3, nEb4, nBb3, nD4, nE3, nCs4
	sRet

	; --- Background flutes (Normal) ---

CNZ1MG_Flute_L:
	dc.b nRst, $0C, nG4, $18, nG4, nG4, nG4, $0C
	sRet

CNZ1MG_Flute_R:
	dc.b nC4, $0C, nE4, nG3, nE4, nC4, nE4, nG3, nE4
	sRet

	; --- Background flutes (Normal) ---

CNZ1MG_FluteEnd_L:
	dc.b nRst, $0C, nG4, $18, nG4, nCs4, $0C, nEb4, nE4, $0C
	sRet

CNZ1MG_FluteEnd_R:
	dc.b nC4, $0C, nE4, nG3, nE4, nC4, nG3, nA3, nB3
	sRet

	; --- JAM! --- CNZ 1 and 2 use this
CNZ1MG_Jam:
	sPatFM		$05
	dc.b nC5, $18
	sNoteTimeOut	$06
	dc.b nFs4, $08, nB4, nE5, nEb5, nA4, nD5, nCs5
	dc.b $18
	sNoteTimeOut	$00
	dc.b nC5, $18, nRst, $48
	sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 1
; ---------------------------------------------------------------------------

CNZ1MG_FM1:
	ssModZ80	$02, $01, $05, $04
	sPatFM		$03
	sCall		CNZ1MG_FM1_Intro

	sSync		$08
	sCall		CNZ1MG_FM1_Start
	dc.b nCs5, $07, nC5, $04
	sSync		$07
	saTranspose	$F4
	sCall		CNZ1MG_Jam
	saTranspose	$0C
	dc.b nRst, $60, nRst
	sJump		CNZ1MG_FM1

CNZ1MG_FM1_Start:
	dc.b nRst, $48
	sPatFM		$00
	ssModZ80	$0B, $01, $0C, $04
	dc.b nC5, $13, nB4, $05
;	sPatFM		$00

CNZ1MG_FM1_Loop:
	ssModZ80	$02, $01, $02, $04
	dc.b nD5, $06, nRst, nC5, nRst, nB4, nRst, nC5
	dc.b nRst, nG4, nRst, nA4, $05, nRst, $07, nC5
	dc.b $0C, nB4, nF4, nRst
	ssModZ80	$11, $01, $15, $05
	dc.b nF4, $30, nRst, $18

	ssModZ80	$02, $01, $02, $04
	dc.b nD5, $06, nRst, nC5, nRst, nB4, nRst, nC5
	dc.b nRst, nG4, nRst, nA4, $05, nRst, $07, nC5
	dc.b $0C, nB4, nBb4, nRst
	ssModZ80	$11, $01, $15, $05
	dc.b nBb4, $30, nRst, $18
	sLoop		$00,$02,CNZ1MG_FM1_Loop

	ssModZ80	$02, $01, $02, $04
	dc.b nD5, $06, nRst, nD5, nRst, nD5, nRst, nC5, nRst, nC5, nBb4, nRst
	ssModZ80	$11, $01, $15, $05
	dc.b nBb4, $30, nRst, $60, nRst, $2B

	ssModZ80	$0B, $01, $0C, $04
	dc.b nC5, $13, nB4, $05

	ssModZ80	$02, $01, $02, $04
	dc.b nD5, $06, nRst, nC5, nRst, nB4, nRst, nC5
	dc.b nRst, nG4, nRst, nA4, $05, nRst, $07, nC5
	dc.b $0C, nB4, nF4, nRst
	ssModZ80	$11, $01, $15, $05
	dc.b nF4, $30, nRst, $18

	sPatFM		$03
CNZ1MG_FM1_Loop2:
	ssModZ80	$02, $01, $05, $04
	dc.b nE5, $05, nRst, $07, nEb5, $05, nRst, $07
	dc.b nD5, nEb5, $05, nD5, $07, nCs5, $05

	ssModZ80	$01, $01, -$04, $FF
	dc.b nC5, $20, nRst, $10
	sLoop		$00,$02,CNZ1MG_FM1_Loop2
	dc.b nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst, nRst

	sPatFM		$04
	ssModZ80	$02, $01, -$06, $04
	dc.b nG5, $05, nRst, $07, nFs5, $05, nRst, $07
	dc.b nF5, nFs5, $05, nF5, $07
	dc.b nE5, $05, nEb5, nRst, $07
	dc.b nD5, $05, nRst, $07
	dc.b nCs5, nD5, $05, nCs5, $07, nC5, $05, nB4, nRst, $07
	dc.b nBb4, $05, nRst, $07
	dc.b nBb4, nB4, $05, nC5, $07
	dc.b nCs5, $05

	ssModZ80	$01, $01, $02, $11
	dc.b nD5, $24, nRst, $05
	ssModZ80	$02, $01, -$06, $04

	dc.b nD5, $07, nG5, $05, nRst, $07
	dc.b nFs5, $05, nRst, $07
	dc.b nF5, nFs5, $05, nF5, $07, nE5, $05, nEb5, nRst, $07
	dc.b nD5, $05, nRst, $07
	dc.b nCs5, nD5, $05, nCs5, $07, nC5, $05, nB4, nRst, $07
	dc.b nBb4, $05, nRst, $07
	dc.b nA4, nBb4, $05, nA4, $07, nAb4, $05

	ssModZ80	$01, $01, $02, $11
	dc.b nG4, $24, nRst, $05
	ssModZ80	$02, $01, -$06, $04

	dc.b nD5, $07, nG5, nRst, $05
	dc.b nFs5, $07, nRst, $05
	dc.b nF5, $07, nFs5, $05, nF5, $07, nE5, $05, nEb5, $07, nRst
	dc.b $05, nD5, $07, nRst, $05
	dc.b nCs5, $07, nD5, $05
	sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 5
; ---------------------------------------------------------------------------

CNZ1MG_FM5:
	sPatFM		$03
	sCall		CNZ1MG_FM5_Intro

	sPan		spRight, $00
	saDetune	$FC
	saTranspose	$F4
	dc.b nRst, $0C
	sCall		CNZ1MG_FM1_Start
	dc.b nCs5, $03

	saDetune	$04
	saTranspose	$0C
	sCall		CNZ1MG_Jam
	sModOff
	sPan		spCentre, $00
	dc.b nRst, $5E, nRst
	sJump		CNZ1MG_FM5

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 2
; ---------------------------------------------------------------------------

CNZ1MG_FM2:
	ssModZ80	$02, $01, $05, $04
	sPatFM		$03
	sPan		spRight, $00
	saDetune	$FC
	saVolFM		$10
	dc.b		nRst,$0C
	sCall		CNZ1MG_FM1_Intro
	saVolFM		$F0
	saDetune	$04
	sPan		spCentre, $00
	dc.b		nRst,$54
	sPatFM		$01

CNZ1MG_FM2_Loop1:
	sCall		CNZ1MG_FM2_Call2
	sLoop		$00,$04,CNZ1MG_FM2_Loop1
	dc.b nRst, $6E, nRst, nRst, nRst, nRst, nRst

CNZ1MG_FM2_Loop2:
	sCall		CNZ1MG_FM2_Call2
	sLoop		$00, $03, CNZ1MG_FM2_Loop2

	sCall		CNZ1MG_FM2_Call1
	dc.b		nBb1;, $0C
	saVolFM		$10
	dc.b		nBb1;, $0C
	saVolFM		$F0
	dc.b		nBb1-5, nBb1;, $0C
	saVolFM		$10
	dc.b		nBb1;, $0C
	saVolFM		$F0
	dc.b nG1, nA1, nB1
	saTranspose	$07

CNZ1MG_FM2_Loop3:
	sCall		CNZ1MG_FM2_Call1
	sLoop		$00, $05, CNZ1MG_FM2_Loop3
	saTranspose	-$07
	sCall		CNZ1MG_Jam

	dc.b nRst, $60, nRst
	sJump		CNZ1MG_FM2

CNZ1MG_FM2_Call1:
	dc.b		nC2, $0C
	saVolFM		$10
	dc.b		nC2;, $0C
	saVolFM		$F0
	dc.b		nC2-5, nC2;, $0C
	saVolFM		$10
	dc.b		nC2;, $0C
	saVolFM		$F0
	dc.b		nC2-5, $18
	saVolFM		$10
	dc.b		nC2-5, $0C
	saVolFM		$F0
	sRet

CNZ1MG_FM2_Call2:
	sCall		CNZ1MG_FM2_Call1
	dc.b		nBb1;, $0C
	saVolFM		$10
	dc.b		nBb1;, $0C
	saVolFM		$F0
	dc.b		nBb1-5, nBb1;, $0C
	saVolFM		$10
	dc.b		nBb1;, $0C
	saVolFM		$F0
	dc.b		nBb1-5, $18
	saVolFM		$10
	dc.b		nBb1-5, $0C
	saVolFM		$F0
	sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 3
; ---------------------------------------------------------------------------

CNZ1MG_FM3:
	sPan		spLeft, $00
	sNoteTimeOut	$06
	sPatFM		$02
	sCall		CNZ1MG_FluteDown_L
	saVolFM		$18

CNZ1MG_FM3_Loop:
	dc.b nG4,$0C
	saVolFM		$FC
	sLoop		$00,$06,CNZ1MG_FM3_Loop
	sNoteTimeOut	$00
	ssModZ80	$01, $01, $04, $FF
	dc.b nG4,$18
	sModOff
	sNoteTimeOut	$06

CNZ1MG_FM3_Loop2:
	sCall	CNZ1MG_Flute_L
	saTranspose	$FE
	sCall	CNZ1MG_Flute_L
	saTranspose	$02
	sCall	CNZ1MG_Flute_L
	saTranspose	$FE
	sCall	CNZ1MG_FluteEnd_L
	saTranspose	$02
	sLoop		$00,$02,CNZ1MG_FM3_Loop2

	saVolFM		$18
.vlup	dc.b nG4, $0C
	saVolFM		-$02
	sLoop		$00,$0E,.vlup
	saVolFM		$04

	dc.b nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, $6C
	sCall	CNZ1MG_Flute_L
	saTranspose	$FE
	sCall	CNZ1MG_Flute_L
	saTranspose	$02
	sCall	CNZ1MG_Flute_L
	saTranspose	$FE
	sCall	CNZ1MG_FluteEnd_L
	saTranspose	$02

	sPatFM		$03
	sNoteTimeOut	$00
	ssModZ80	$01, $01, $06, $04
CNZ1MG_FM3_Loop3:
	dc.b nRst, $0C, nD4, nRst, $07, nD4, $05, nRst
	dc.b $0C, nD4, $05, nRst, $07, nRst, $24, nRst
	dc.b $0C, nG3, $0C, nRst, $07, nG3, $05, nRst
	dc.b $0C, nG3, $05, nRst, $2B
	sLoop		$00, $02, CNZ1MG_FM3_Loop3
	dc.b nRst, $0C, nD4, nRst, $07, nD4, $05, nRst
	dc.b $0C, nD4, $05, nRst, $07, nRst, $24

	sCall		CNZ1MG_Jam
	sNoteTimeOut	$06
	sPatFM		$02

	sCall	CNZ1MG_Flute_L
	saVolFM		$10
.vlup	dc.b nG4, $0C
	saVolFM		-$02
	sLoop		$00,$08,.vlup
	sJump		CNZ1MG_FM3

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 4
; ---------------------------------------------------------------------------

CNZ1MG_FM4:
	sPan		spRight, $00
	sNoteTimeOut	$06
	sPatFM		$02
	sCall		CNZ1MG_FluteDown_R
	saVolFM		$18

CNZ1MG_FM4_Loop:
	dc.b	nE4,$0C
	saVolFM		$FC
	sLoop		$00,$06,CNZ1MG_FM4_Loop
	sNoteTimeOut	$00
	ssModZ80	$01, $01, $04, $FF
	dc.b	nE4,$18
	sModOff
	sNoteTimeOut	$06

CNZ1MG_FM4_Loop2:
	sCall	CNZ1MG_Flute_R
	saTranspose	$FE
	sCall	CNZ1MG_Flute_R
	saTranspose	$02
	sCall	CNZ1MG_Flute_R
	saTranspose	$FE
	sCall	CNZ1MG_FluteEnd_R
	saTranspose	$02
	sLoop		$00,$02,CNZ1MG_FM4_Loop2

	saVolFM		$18
.vlup	dc.b nE4, $0C
	saVolFM		-$02
	sLoop		$00,$0E,.vlup
	saVolFM		$04

	dc.b nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, $6C
	sCall	CNZ1MG_Flute_R
	saTranspose	$FE
	sCall	CNZ1MG_Flute_R
	saTranspose	$02
	sCall	CNZ1MG_Flute_R
	saTranspose	$FE
	sCall	CNZ1MG_FluteEnd_R
	saTranspose	$02

	sPatFM		$03
	sNoteTimeOut	$00
	ssModZ80	$01, $01, $06, $04
CNZ1MG_FM3_Loop4:
	dc.b nRst, $0C, nF3, nG2, $07, nF3, $05, nRst
	dc.b $07, nG2, $05, nF3, nRst, $13, nF3, $07
	dc.b nG3, $05, nF3, $07, nC3, $05, nC2, $05
	dc.b nRst, $13, nC3, $05, nRst, $07, nRst, nC3
	dc.b $05, nRst, $13, nG2, $05, nBb2, $07, nC3
	dc.b $05, nBb2, $07, nG2, $05
	sLoop		$00, $02, CNZ1MG_FM3_Loop4
	dc.b nRst, $0C, nF3, nG2, $07, nF3, $05, nRst
	dc.b $07, nG2, $05, nF3, nRst, $13, nF3, $07
	dc.b nG3, $05, nF3, $07, nC3, $05

	sCall		CNZ1MG_Jam
	sNoteTimeOut	$06
	sPatFM		$02

	sCall	CNZ1MG_Flute_R
	saVolFM		$10
.vlup	dc.b nE4, $0C
	saVolFM		-$02
	sLoop		$00,$08,.vlup
	sJump		CNZ1MG_FM4

; ===========================================================================
; ---------------------------------------------------------------------------
; DAC
; ---------------------------------------------------------------------------

CNZ1MG_DAC:
	dc.b	nRst, $48

CNZ1MG_DAC_Loop:
	dc.b    dScratch, $0C, $0C
	dc.b	dGlassCrashKick, $48
	dc.b	dMetalCrashHit,	$18

CNZ1MG_DAC_Loop1:
	dc.b	dKick, $0C, dModLooseKick, $06, dModLooseKick, $06
	dc.b	dSnare, $0C, dClick, $0C
	dc.b	dQuickGlassCrash, $0C, dModLooseKick, $0C
	dc.b	dSnare, $0C, dModLooseKick, $0C

	dc.b	dKick, $0C, dModLooseKick, $06, dModLooseKick, $06
	dc.b	dSnare, $0C, dClick, $0C
	dc.b	dKick, $0C, dClick, $0C
	dc.b	dQuickGlassCrash, $0C, dQuickGlassCrash, $0C
	sLoop	$00,$04,CNZ1MG_DAC_Loop1

	dc.b	dKick, $0C, dModLooseKick, $06, dModLooseKick, $06
	dc.b	dSnare, $0C, dClick, $0C
	dc.b	dQuickGlassCrash, $0C, dModLooseKick, $0C
	dc.b	dSnare, $0C, dModLooseKick, $0C
	dc.b	dKick, $0C, dModLooseKick, $06, dModLooseKick, $06
	dc.b	dSnare, $0C, dClick, $0C
	dc.b	dKick, $0C, dClick, $0C
	dc.b	dGlassCrashSnare, $0C

;	dc.b	dModLooseKick, $06, dLowHitDrum, $03, dModLooseKick, $03
;	dc.b	dSnare, $06, dHiHitDrum
;	dc.b	dModLooseKick, $06, dClick, $03, dModLooseKick, $03
;	dc.b	dSnare, $06, dHiHitDrum
;	sLoop		$00,$02,CNZ1MG_DAC_Loop1

;	dc.b	dMetalCrashHit
;	dc.b	dScratch

	dc.b nRst, $48, dQuietGlassCrash, $18

CNZ1MG_DAC_Loop2:
	dc.b dPowerKick, $0C, dClick, dQuickGlassCrash, $24, dPowerKick, $0C
	dc.b dQuickGlassCrash, dQuickGlassCrash
	sLoop		$00,$0C,CNZ1MG_DAC_Loop2

CNZ1MG_DAC_Loop3:
	dc.b dModLooseKick, $0C, dScratch, dQuickGlassCrash, $24, dModLooseKick, $0C
	dc.b dQuickGlassCrash, dQuickGlassCrash
	sLoop		$00,$04,CNZ1MG_DAC_Loop3

	dc.b dModLooseKick, $0C, dScratch, dQuickGlassCrash, $24, dModLooseKick, $0C
	dc.b dQuickGlassCrash, $08, dComeOn, $10
	dc.b dGlassCrashSnare, $60, dGlassCrash

	dc.b dModLooseKick, $0C, dClick, dQuickGlassCrash, $24, dModLooseKick, $0C
	dc.b dQuickGlassCrash, dQuickGlassCrash

CNZ1MG_DAC_Loop4:
	dc.b dKick, dClick
	sLoop		$00,$04,CNZ1MG_DAC_Loop4

	dc.b dBassHey, $48
	sJump		CNZ1MG_DAC_Loop

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG  1
; ---------------------------------------------------------------------------

CNZ1MG_PSG1:
	sNoteTimeOut	$06
	sVolEnvPSG	VolEnv_05
	sModEnv		ModEnv_02
	sCall	CNZ1MG_FluteDown_L
	saVolPSG	$06

CNZ1MG_PSG1_Loop:
	dc.b	nG4,$0C
	saVolPSG	$FF
	sLoop		$00,$06,CNZ1MG_PSG1_Loop
	sNoteTimeOut	$00
	ssModZ80	$01, $01, $FC, $FF
	dc.b	nG4,$18
	sModOff
	sNoteTimeOut	$06

CNZ1MG_PSG1_Loop2:
	sCall	CNZ1MG_Flute_L
	saTranspose	$FE
	sCall	CNZ1MG_Flute_L
	saTranspose	$02
	sCall	CNZ1MG_Flute_L
	saTranspose	$FE
	sCall	CNZ1MG_FluteEnd_L
	saTranspose	$02
	sLoop		$00,$02,CNZ1MG_PSG1_Loop2

	saVolPSG	$0C
.vlup	dc.b nG4, $0C
	saVolPSG	-$01
	sLoop		$00,$0E,.vlup
	saVolPSG	$02

	dc.b nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, $6C
	sCall	CNZ1MG_Flute_L
	saTranspose	$FE
	sCall	CNZ1MG_Flute_L
	saTranspose	$02
	sCall	CNZ1MG_Flute_L
	saTranspose	$FE
	sCall	CNZ1MG_FluteEnd_L
	saTranspose	$02

	sVolEnvPSG	VolEnv_04
	sNoteTimeOut	$00
CNZ1MG_PSG1_Loop3:
	dc.b nRst, $0C, nD4, nRst, $07, nD4, $05, nRst
	dc.b $0C, nD4, $05, nRst, $07, nRst, $24, nRst
	dc.b $0C, nG3, $0C, nRst, $07, nG3, $05, nRst
	dc.b $0C, nG3, $05, nRst, $2B
	sLoop		$00, $02, CNZ1MG_PSG1_Loop3
	dc.b nRst, $0C, nD4, nRst, $07, nD4, $05, nRst
	dc.b $0C, nD4, $05, nRst, $07

	dc.b nRst, $24, nRst, $60, nRst
	saVolPSG	$01
	sVolEnvPSG	VolEnv_05
	sNoteTimeOut	$06

	sCall	CNZ1MG_Flute_L
	saVolPSG	$08
.vlup	dc.b nG4, $0C
	saVolPSG	-$01
	sLoop		$00,$08,.vlup
	sJump		CNZ1MG_PSG1

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG  2
; ---------------------------------------------------------------------------

CNZ1MG_PSG2:
	sVolEnvPSG	VolEnv_12
	sModEnv		ModEnv_02
	sNoteTimeOut	$06
	sCall	CNZ1MG_FluteDown_R
	saVolPSG	$06

CNZ1MG_PSG2_Loop:
	dc.b	nE4,$0C
	saVolPSG	$FF
	sLoop	$00,$06,CNZ1MG_PSG2_Loop
	sNoteTimeOut	$00
	ssModZ80	$01, $01, $FC, $FF
	dc.b	nE4,$18
	sModOff
	sNoteTimeOut	$06

CNZ1MG_PSG2_Loop2:
	sCall	CNZ1MG_Flute_R
	saTranspose	$FE
	sCall	CNZ1MG_Flute_R
	saTranspose	$02
	sCall	CNZ1MG_Flute_R
	saTranspose	$FE
	sCall	CNZ1MG_FluteEnd_R
	saTranspose	$02
	sLoop		$00,$02,CNZ1MG_PSG2_Loop2

	saVolPSG	$0C
.vlup	dc.b nE4, $0C
	saVolPSG	-$01
	sLoop		$00,$0E,.vlup
	saVolPSG	$02

	dc.b nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst, $6C
	sCall	CNZ1MG_Flute_R
	saTranspose	$FE
	sCall	CNZ1MG_Flute_R
	saTranspose	$02
	sCall	CNZ1MG_Flute_R
	saTranspose	$FE
	sCall	CNZ1MG_FluteEnd_R
	saTranspose	$02

	sVolEnvPSG	VolEnv_11
	sNoteTimeOut	$00
CNZ1MG_PSG2_Loop3:
	dc.b nRst, $0C, nF3, nG2, $07, nF3, $05, nRst
	dc.b $07, nG2, $05, nF3, nRst, $13, nF3, $07
	dc.b nG3, $05, nF3, $07, nC3, $05, nC2, $05
	dc.b nRst, $13, nC3, $05, nRst, $07, nRst, nC3
	dc.b $05, nRst, $13, nG2, $05, nBb2, $07, nC3
	dc.b $05, nBb2, $07, nG2, $05
	sLoop		$00, $02, CNZ1MG_PSG2_Loop3
	dc.b nRst, $0C, nF3, nG2, $07, nF3, $05, nRst
	dc.b $07, nG2, $05, nF3, nRst, $13, nF3, $07
	dc.b nG3, $05, nF3, $07, nC3, $05

	dc.b nRst, $60, nRst
	saVolPSG	$01
	sVolEnvPSG	VolEnv_12
	sNoteTimeOut	$06

	sCall	CNZ1MG_Flute_R
	saVolPSG	$08
.vlup	dc.b nE4, $0C
	saVolPSG	-$01
	sLoop		$00,$08,.vlup
	sJump		CNZ1MG_PSG2

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG  3
; ---------------------------------------------------------------------------

CNZ1MG_PSG3:
	sVolEnvPSG	VolEnv_02
	sNoisePSG	$E7

CNZ1MG_PSG3_Loop:
	sCall		CNZ1MG_PSG3_Call1
	sLoop		$00,$02,CNZ1MG_PSG3_Loop
	saVolPSG	$FF

CNZ1MG_PSG3_Loop2:
	sVolEnvPSG	VolEnv_02
	dc.b nC4, $06, $06
	sVolEnvPSG	VolEnv_04
	dc.b nC4, $0C
	sLoop		$00,$20,CNZ1MG_PSG3_Loop2

	dc.b nRst, $60, nRst, nRst, $54
	sVolEnvPSG	VolEnv_01
	saVolPSG	$02

CNZ1MG_PSG3_Loop3:
	sCall		CNZ1MG_PSG3_Call1
	sLoop		$00,$11,CNZ1MG_PSG3_Loop3

	dc.b nC4, $0C, nRst, $54, nRst, $60
	sVolEnvPSG	VolEnv_02
	sCall		CNZ1MG_PSG3_Call1
	sCall		CNZ1MG_PSG3_Call1
	sJump		CNZ1MG_PSG3

CNZ1MG_PSG3_Call1:
	dc.b nC4, $08, $04, $04, nRst, $08
	saVolPSG	$FF
	dc.b nC4, $04
	saVolPSG	$01
	dc.b nRst, $08, nC4, $08, $04, nC4, nRst, $14
	saVolPSG	$FF
	dc.b nC4, $04
	saVolPSG	$01
	dc.b nRst, $14
	sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; Instruments
; ---------------------------------------------------------------------------

CNZ1MG_Patches:		; Made CNZ 1 and 2 use these, as they are identical
	; Patch $00
	; $3B
	; $01, $02, $04, $02,	$18, $1B, $19, $16
	; $1C, $19, $1D, $1F,	$0A, $02, $02, $03
	; $0F, $1F, $1F, $1E,	$26, $1B, $1B, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $04, $02, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$18, $19, $1B, $16
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0A, $02, $02, $03
	spSustainRt	$1C, $1D, $19, $1F
	spSustainLv	$00, $01, $01, $01
	spReleaseRt	$0F, $0F, $0F, $0E
	spTotalLv	$26, $1B, $1B, $00

	; Patch $01
	; $25
	; $31, $12, $0A, $22,	$1F, $1F, $1F, $1F
	; $0E, $0B, $10, $0E,	$10, $00, $00, $00
	; $E7, $3F, $3F, $3F,	$0B, $88, $88, $88
	spAlgorithm	$05
	spFeedback	$04
	spDetune	$03, $00, $01, $02
	spMultiple	$01, $0A, $02, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$10, $00, $00, $00
	spSustainRt	$0E, $10, $0B, $0E
	spSustainLv	$0E, $03, $03, $03
	spReleaseRt	$07, $0F, $0F, $0F
	spTotalLv	$0B, $08, $08, $08

	; Patch $02
	; $3B
	; $04, $32, $03, $01,	$14, $0E, $12, $4E
	; $00, $10, $12, $0C,	$00, $00, $00, $00
	; $0F, $5F, $9F, $2F,	$00, $3E, $26, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$00, $00, $03, $00
	spMultiple	$04, $03, $02, $01
	spRateScale	$00, $00, $00, $01
	spAttackRt	$14, $12, $0E, $0E
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$00, $12, $10, $0C
	spSustainLv	$00, $09, $05, $02
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$00, $26, $3E, $00

	; Patch $03
	; $3B
	; $0C, $02, $03, $02,	$59, $1C, $1E, $1F
	; $0C, $04, $08, $07,	$02, $03, $03, $04
	; $EF, $DF, $DF, $DF,	$30, $2A, $2A, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$0C, $03, $02, $02
	spRateScale	$01, $00, $00, $00
	spAttackRt	$19, $1E, $1C, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$02, $03, $03, $04
	spSustainRt	$0C, $08, $04, $07
	spSustainLv	$0E, $0D, $0D, $0D
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$30, $2A, $2A, $00

	; Patch $04
	; $3B
	; $72, $02, $32, $02,	$6C, $1B, $12, $12
	; $05, $07, $02, $10,	$03, $00, $00, $00
	; $EF, $FF, $2F, $1F,	$2A, $33, $30, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$07, $03, $00, $00
	spMultiple	$02, $02, $02, $02
	spRateScale	$01, $00, $00, $00
	spAttackRt	$0C, $12, $1B, $12
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$03, $00, $00, $00
	spSustainRt	$05, $02, $07, $10
	spSustainLv	$0E, $02, $0F, $01
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$2A, $30, $33, $00

	; Patch $05
	; $03
	; $02, $03, $10, $11,	$15, $10, $12, $18
	; $10, $0C, $1C, $0D,	$00, $1A, $00, $16
	; $3F, $5F, $6F, $5B,	$0F, $18, $1C, $84
	spAlgorithm	$03
	spFeedback	$00
	spDetune	$00, $01, $00, $01
	spMultiple	$02, $00, $03, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$15, $12, $10, $18
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $1A, $16
	spSustainRt	$10, $1C, $0C, $0D
	spSustainLv	$03, $06, $05, $05
	spReleaseRt	$0F, $0F, $0F, $0B
	spTotalLv	$0F, $1C, $18, $04

; ===========================================================================
