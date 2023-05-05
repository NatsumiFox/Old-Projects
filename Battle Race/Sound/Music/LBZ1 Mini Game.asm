; ===========================================================================
; ---------------------------------------------------------------------------
; Launch Base Zone 1 - Mini-Game theme
; ---------------------------------------------------------------------------

LBZ1MG_Header:
		sHeaderInit
		sHeaderPatch	LBZ1MG_Patches
		sHeaderCh	$06, $03
		sHeaderTempo	$01, $30
		sHeaderDAC	LBZ1MG_DAC
		sHeaderFM	LBZ1MG_FM1, $00, $09
		sHeaderFM	LBZ1MG_FM2, $00, $1C
		sHeaderFM	LBZ1MG_FM3, $00, $20
		sHeaderFM	LBZ1MG_FM4, $00, $1C
		sHeaderFM	LBZ1MG_FM5, $00, $20
		sHeaderPSG	LBZ1MG_PSG1, $F4, $02, $00, VolEnv_00
		sHeaderPSG	LBZ1MG_PSG2, $F4, $04, $00, VolEnv_00
		sHeaderPSG	LBZ1MG_PSG3, $00, $01, $00, VolEnv_00

; ===========================================================================
; ---------------------------------------------------------------------------
; DAC
; ---------------------------------------------------------------------------

LBZ1MG_DAC:
		dc.b	$A4,$18
		sLoop	$00,$0C,LBZ1MG_DAC
		dc.b	$81,$06,$06,$06,$06,$0C,$06,$0C,$06,$0C,$06,$06,$06,$06

	; --- Starting verse before the LBZ "go" ---

LBZ1MG_DAC_MainLoop:
		sCall	LBZ1MG_DAC_Common
		dc.b	$12,$06
		sCall	LBZ1MG_DAC_Common
		dc.b	$12,$06
		sCall	LBZ1MG_DAC_Common
		dc.b	$12,$06
		sCall	LBZ1MG_DAC_Common
		dc.b	$06,$06,$06,$06

	; --- The LBZ "go" verse ---

		sCall	LBZ1MG_DAC_Common2
		sCall	LBZ1MG_DAC_Common2
		sCall	LBZ1MG_DAC_Common2
		sCall	LBZ1MG_DAC_Common2
		sCall	LBZ1MG_DAC_Common2
		sCall	LBZ1MG_DAC_Common2
		sCall	LBZ1MG_DAC_Common2
		dc.b	nRst, $36, dQuietGlassCrash, $12, dMetalCrashHit, $0B, dMetalCrashHit, $0D

		; Chorus here...
		sCall	LBZ1MG_DAC_Normal

	; --- Verse again ---

LBZ1MG_DAC_CommonLoop1:
		sCall	LBZ1MG_DAC_Common
		dc.b	$12,$06
		sCall	LBZ1MG_DAC_Common
		dc.b	$12,$06
		sCall	LBZ1MG_DAC_Common
		dc.b	$12,$06
		sCall	LBZ1MG_DAC_Common
		dc.b	$06,$06,$06,$06
		sLoop	$00,$02,LBZ1MG_DAC_CommonLoop1

	; --- Guitar verse section ---

		dc.b	$80,$60,$80,$60

LBZ1MG_DAC_VerseLoop:
		dc.b	dModLooseKick,$0C,dModLooseKick,$80,$42, dModLooseKick, $06
		dc.b	dModLooseKick,$0C,dModLooseKick,$80,$48
		sLoop	$00,$03,LBZ1MG_DAC_VerseLoop

LBZ1MG_DAC_VerseLoop2:
		dc.b dModLooseKick, $06, dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum, nRst, dModLooseKick
		dc.b dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum, dPowerTom, dPowerTom, $18
		sLoop $00,$03,LBZ1MG_DAC_VerseLoop2
		dc.b dModLooseKick, $06, nRst, dHiWoodBlock, nRst, dLowWoodBlock, dLowWoodBlock, dLowWoodBlock
		dc.b dHiWoodBlock, nRst, nRst, $2A-$18
		dc.b	$A2,$0C,$B6

		; Chorus again
		sCall	LBZ1MG_DAC_Normal

LBZ1MG_DAC_LoopCommon2:
	dc.b dModLooseKick, $06, nRst, dHiHitDrum, dModLooseKick, dLowHitDrum, dLowHitDrum, dModLooseKick
	dc.b dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum, dPowerTom, dPowerTom, nRst, dLowHitDrum
	dc.b nRst, dModLooseKick, $0C, dHiWoodBlock, $06, dModLooseKick, dLowWoodBlock, dLowWoodBlock
	dc.b dModLooseKick, dHiWoodBlock, nRst, dHiWoodBlock, dLowWoodBlock, dLowWoodBlock, dLowWoodBlock, dLowWoodBlock
	dc.b dLowWoodBlock, dLowWoodBlock
	sLoop		$00, $02,LBZ1MG_DAC_LoopCommon2
	dc.b dModLooseKick, $06, dHiHitDrum, nRst, dModLooseKick, dSnareGo, nRst, dModLooseKick
	dc.b dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum, dPowerTom, dSnareGo, nRst, dLowWoodBlock
	dc.b dLowWoodBlock, dModLooseKick, nRst, dHiWoodBlock, dModLooseKick, dSnareGo, nRst, dModLooseKick
	dc.b dHiWoodBlock, nRst, dHiWoodBlock, dLowWoodBlock, dSnareGo, dSnareGo, nRst, dLowWoodBlock
	dc.b dLowWoodBlock, dModLooseKick, $06, dHiHitDrum, nRst, dModLooseKick, dSnareGo, nRst
	dc.b dModLooseKick, dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum, dPowerTom, dSnareGo, nRst
	dc.b dLowWoodBlock, dLowWoodBlock, dModLooseKick, nRst, dHiWoodBlock, dModLooseKick, dSnareGo, nRst
	dc.b dModLooseKick, dHiWoodBlock, nRst, dSnareGo, nRst, dSnareGo, dSnareGo, nRst
	dc.b dSnareGo, nRst
		sJump	LBZ1MG_DAC_MainLoop

	; --- Common DAC loop ---

		; Normal....

LBZ1MG_DAC_Common:
		dc.b	$A4,$18,$81,$12,$06,$A4,$81,$12
		sRet

		; With "GO"s...

LBZ1MG_DAC_Common2:
		dc.b	$A4,$0C,dGo,$0C,$81,$0C,dGo,$06,$81,$06,$A4,$81,dGo,$0C,$81,$0C,dGo,$06,$81,$06
		sRet

	; --- The normal DAC chorus from LBZ ---

LBZ1MG_DAC_Normal:
		dc.b dModLooseKick, $0C, dModLooseKick, dSnareGo
		dc.b $12, dModLooseKick, $1E, dMetalCrashHit, $18
		dc.b dModLooseKick, $18, dSnareGo, $0C, dScratch, dPowerTom, $12, dSnareGo
		dc.b $06, dSnareGo, $0C, dScratch

LBZ1MG_DAC_NormalLoop:
		dc.b dModLooseKick, $0C, dModLooseKick, dSnareGo, $12, dModLooseKick, $1E, dSnareGo
		dc.b $24
		dc.b dModLooseKick, $0C, dSnareGo, $12, dModLooseKick, $06, dPowerTom, $12
		dc.b dSnareGo, $06, dSnareGo, $18
		sLoop $00, $02, LBZ1MG_DAC_NormalLoop
		dc.b dModLooseKick, $0C, dModLooseKick, dSnareGo, $12, dModLooseKick, $1E, dSnareGo
		dc.b $18, nRst, $36, dQuietGlassCrash, $12, dMetalCrashHit, $0B, dMetalCrashHit, $0D
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 1
; ---------------------------------------------------------------------------

LBZ1MG_FM1:
		sPatFM	$03

LBZ1MG_FM1_Echo:
		dc.b	$9E,$12
		saVolFM	$04
		sLoop	$00,$0A,LBZ1MG_FM1_Echo
		saVolFM	$D8
		dc.b	$9C,$0C
		sLoop	$01,$02,LBZ1MG_FM1_Echo

	; --- Main Verse ---

LBZ1MG_FM1_VerseLoop1:
		dc.b	$9E,$0C,$AA,$06,$9E,$06,$06,$0C,$A3,$A3,$A3,$06,$A2,$0C,$A3,$06,$A2
		sLoop	$00,$0B,LBZ1MG_FM1_VerseLoop1

		; Transition from verse to chorus
		dc.b	$9E,$0C,$AA,$06,$9E,$06,$06,$0C,$A3,$A3
		saTranspose $0C
		dc.b	$9B,$06,$A0,$0C,$9B

	; --- Chorus ---

LBZ1MG_FM1_ChorusLoop:
		sCall	LBZ1MG_FM1_Chorus
		dc.b	$9B,$0C,$A0,$06,$9B
		sCall	LBZ1MG_FM1_Chorus
		dc.b	$9B,$18
		sLoop	$01,$02,LBZ1MG_FM1_ChorusLoop

	; --- Verse again ---

		saTranspose $F4

LBZ1MG_FM1_VerseLoop2:
		dc.b	$9E,$0C,$AA,$06,$9E,$06,$06,$0C,$A3,$A3,$A3,$06,$A2,$0C,$A3,$06,$A2
		sLoop	$00,$06,LBZ1MG_FM1_VerseLoop2
		dc.b	$9E,$0C,$AA,$06,$9E,$06,$06,$0C,$A3,$A3,$A2,$06,$A3,$0C,$A2,$06,$A3
		dc.b	$A5,$0C,$A5,$06,$A5,$06,$06,$0C,$A4,$A4,$A4,$06,$A4,$0C,$A4,$06,$A4


	; --- guitar verse section ---

		dc.b	$80,$60,$80,$60
		dc.b	$80,$60,$80,$60

		sPatFM	$09
		saTranspose $0C
		saVolFM	$04

		sCall	LBZ1MG_FM1_IntroBit
		saTranspose $FF
		sCall	LBZ1MG_FM1_IntroBit
		saTranspose $FF
		sCall	LBZ1MG_FM1_IntroBit
		saTranspose $FE
		sCall	LBZ1MG_FM1_IntroBit
		saTranspose $04

		sCall	LBZ1MG_FM1_IntroBit
		saTranspose $FF
		sCall	LBZ1MG_FM1_IntroBit
		saTranspose $FF
		sCall	LBZ1MG_FM1_IntroBit
		saTranspose $02

		dc.b	$80,$42
		saVolFM	$FC
		sPatFM	$03


		dc.b	$9B,$06,$A0,$0C,$9B

	; --- Chorus 2 ---

LBZ1MG_FM1_Chorus2:
		sCall	LBZ1MG_FM1_Chorus
		dc.b	$9B,$0C,$A0,$06,$9B
		sCall	LBZ1MG_FM1_Chorus
		dc.b	$9B,$18
		sLoop	$01,$02,LBZ1MG_FM1_Chorus2

		saTranspose $F4

		dc.b	$80,$60,$80,$60,$80,$60,$80,$60
		sJump	LBZ1MG_FM1_Echo









	; --- LBZ intro bit, but altered a little ---

LBZ1MG_FM1_IntroBit:
		dc.b nG1, $12, nD2, nA2-2, $1E, nG1, $06, nD2
		dc.b $0C, nA2-2
		sRet

	; --- Main Chorus Repetetive section ---

LBZ1MG_FM1_Chorus:
		dc.b	$99,$06
		saVolFM	$10
		dc.b	$06
		saVolFM	$F0
		dc.b	$99,$0C,$97,$12,$96,$06

LBZ1MG_FM1_ChorusLoop1:
		saVolFM	$10
		dc.b	$06
		sLoop	$00,$07,LBZ1MG_FM1_ChorusLoop1
		saVolFM	$90
		dc.b	$96,$06,$92
		saVolFM	$10
		dc.b	$06
		saVolFM	$F0
		dc.b	$92,$0C,$93,$12,$94,$06

LBZ1MG_FM1_ChorusLoop2:
		saVolFM	$10
		dc.b	$06
		sLoop	$00,$04,LBZ1MG_FM1_ChorusLoop2
		saVolFM	$C0
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 2
; ---------------------------------------------------------------------------

LBZ1MG_FM2:
		sPatFM	$04
		dc.b	$80,$60,$80,$60
		dc.b	$9E,$60,sHold,$60,sHold,$60,sHold,$60,sHold,$60,sHold,$60

	; --- Guitar section ---

		sPatFM	$0B
		saVolFM	$F0

LBZ1MG_FM2_Verse:
		sCall	LBZ1MG_FM2_Guitar
		dc.b	$80,$18
		sLoop	$00,$04,LBZ1MG_FM2_Verse

	; --- Guitar chorus ---

LBZ1MG_FM2_Chorus:
		sCall	LBZ1MG_FM2_Guitar
		sPatFM	$04
		sCall	LBZ1MG_FM2_Phase1
		sPatFM	$0B
		sCall	LBZ1MG_FM2_Guitar
		sPatFM	$04
		sCall	LBZ1MG_FM2_Phase2
		sPatFM	$0B
		sCall	LBZ1MG_FM2_Guitar
		sPatFM	$04
		sCall	LBZ1MG_FM2_Phase1
		sPatFM	$0B
		sCall	LBZ1MG_FM2_Guitar

		sPatFM	$0D
		sCall	LBZ1MG_FM2_Horn_End

	; --- Horn Verse ---

		sCall	LBZ1MG_FM2_Horn
		sCall	LBZ1MG_FM2_Horn1
		sCall	LBZ1MG_FM2_Horn_End

		sCall	LBZ1MG_FM2_Horn
		sCall	LBZ1MG_FM2_Horn2
		sCall	LBZ1MG_FM2_Horn_End

		sCall	LBZ1MG_FM2_Horn
		sCall	LBZ1MG_FM2_Horn1
		sCall	LBZ1MG_FM2_Horn_End

		sCall	LBZ1MG_FM2_Horn
		sCall	LBZ1MG_FM2_Horn3

	; --- Guitar verse ---

		sPatFM	$0E
		saVolFM	$08
		sNoteTimeOut $05

LBZ1MG_FM2_GuitarVerse:
		sCall	LBZ1MG_FM2_GuitarV1
		sCall	LBZ1MG_FM2_GuitarV2
		sCall	LBZ1MG_FM2_GuitarV1
		sCall	LBZ1MG_FM2_GuitarV2
	;	sLoop	$00,$05,LBZ1MG_FM2_GuitarVerse
	;	sCall	LBZ1MG_FM2_GuitarV1



	saTranspose $02
		sCall	LBZ1MG_FM2_GuitarV1
	saTranspose $FF
		sCall	LBZ1MG_FM2_GuitarV2
	saTranspose $FF
		sCall	LBZ1MG_FM2_GuitarV1
	saTranspose $FE
		sCall	LBZ1MG_FM2_GuitarV2
	saTranspose $04
		sCall	LBZ1MG_FM2_GuitarV1
	saTranspose $FF
		sCall	LBZ1MG_FM2_GuitarV2
	saTranspose $FF
		sCall	LBZ1MG_FM2_GuitarV1
	;saTranspose $01


		dc.b	$80,$60
		sNoteTimeOut $00
		saVolFM	$F8

	; --- Second chorus ---

		dc.b	$80,$60,$80,$60
		dc.b	$80,$60,$80,$48
		sPatFM	$04
		sCall	LBZ1MG_FM2_Phase2
		sPatFM	$0B
		sCall	LBZ1MG_FM2_Guitar
		sPatFM	$04
		sCall	LBZ1MG_FM2_Phase1
		sPatFM	$0B
		sCall	LBZ1MG_FM2_Guitar
		sPatFM	$04
		sCall	LBZ1MG_FM2_Phase2

	; --- Horn verse ---

	saVolFM		$06
	ssModZ80	$01, $01, $01, $06
	sPatFM		$0A
	dc.b nF4, $48, nE4, $18, nD4, $5A, nRst, $06
	dc.b nF4, $48, nG4, $18, nD4, $5A, nRst, $06
	saVolFM		$FA
		saVolFM	$10

		sJump	LBZ1MG_FM2



















	; --- Guitar subroutines

LBZ1MG_FM2_GuitarV1:
		dc.b	$B6,$06,$B6
		saVolFM	$02
		dc.b	$C0
		saVolFM	$FE
		dc.b	$B6,$B6
		saVolFM	$02
		dc.b	$C0
		saVolFM	$FE
		dc.b	$B6,$B6
		saVolFM	$02
		dc.b	$C0,$C0,$C0,$C2
		saVolFM	$FE
		dc.b	$B6
		saVolFM	$02
		dc.b	$C2
		saVolFM	$FE
		dc.b	$B6
		saVolFM	$02
		dc.b	$C0
		saVolFM	$FE
		sRet

LBZ1MG_FM2_GuitarV2:
		dc.b	$B6,$B6
		saVolFM	$02
		dc.b	$C0
		saVolFM	$FE
		dc.b	$B6,$B6
		saVolFM	$02
		dc.b	$C0
		saVolFM	$FE
		dc.b	$B6
		saVolFM	$02
		dc.b	$C5
		saVolFM	$FE
		dc.b	$B6,$B6
		saVolFM	$02
		dc.b	$C5
		saVolFM	$FE
		dc.b	$B6
		saVolFM	$02
		dc.b	$C5,$C7
		saVolFM	$FE
		dc.b	$B6
		saVolFM	$02
		dc.b	$C0
		saVolFM	$FE
		sRet

	; --- SOR's horn absolute end ---

LBZ1MG_FM2_Horn_End:
		dc.b	$BD,$06,$C0,$C2,$C0
		sRet

	; --- SOR's horn section ---

LBZ1MG_FM2_Horn:
		dc.b	$C2,$0C
		saVolFM	$0E

LBZ1MG_FM2_Horn_Loop:
		dc.b	$E7,$0C
		saVolFM	$FE
		sLoop	$00,$07,LBZ1MG_FM2_Horn_Loop
		sRet

	; --- horn ending section 1 ---

LBZ1MG_FM2_Horn1:
		dc.b	$C5,$08,$80,$04
		saVolFM	$04
		dc.b	$08,$80,$04
		saVolFM	$04
		dc.b	$08,$80,$04
		saVolFM	$F8
		dc.b	$C7,$08,$80,$04
		saVolFM	$04
		dc.b	$08,$80,$04
		saVolFM	$04
		dc.b	$08,$80,$04
		saVolFM	$F8
		sRet

	; --- horn ending section 2 ---

LBZ1MG_FM2_Horn2:
		dc.b	$C5,$06,$C5,$C5,$C5,$C5,$0C
		dc.b	$C4,$06
		dc.b	$C7,$08,$80,$04
		saVolFM	$04
		dc.b	$08,$80,$04
		saVolFM	$04
		dc.b	$06
		saVolFM	$F8
		sRet

	; --- horn ending section 2 ---

LBZ1MG_FM2_Horn3:
		dc.b	$C5,$06,$C5,$C5,$C5,$C7,$0C
		dc.b	$C5,$06
		ssModZ80 $08,$01,$06,$04
		dc.b	$C9,$1E+$18
		sModOff
		sRet

	; --- LBZ's Guitar ---

LBZ1MG_FM2_Guitar:
		dc.b	nRst, $06, nEb4, $04, nRst, $0E, nEb4, $12, nEb4, $06, nRst, $18
		dc.b	nC4, $06, nBb3, nG3, nF3, nRst, $18
		dc.b	nEb4, $12, nEb4, $06, nRst, $18
		sRet

LBZ1MG_FM2_Phase1:
		ssModZ80 $01,$01,$10,$02
		dc.b	$C5,$18
		sModOff
		sRet

LBZ1MG_FM2_Phase2:
		ssModZ80 $01,$01,$08,$10
		dc.b	$C5,$18
		sModOff
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 3
; ---------------------------------------------------------------------------

LBZ1MG_FM3:
		sPatFM	$05
		dc.b	$80,$60,$80,$60,$80,$60
		ssModZ80 $01,$01,$F9,$C8
		dc.b	$C8,$60
		sModOff
		saVolFM	$F4

LBZ1MG_FM3_Loop1:
		sCall	LBZ1MG_FM3_HiHat
		sCall	LBZ1MG_FM3_HiHatSnare
		sLoop	$00,$16,LBZ1MG_FM3_Loop1
		dc.b	$80,$60

LBZ1MG_FM3_Loop2:
		sCall	LBZ1MG_FM3_HiHat
		sCall	LBZ1MG_FM3_HiHatSnare
		sLoop	$00,$0E,LBZ1MG_FM3_Loop2
		dc.b	$80,$60

LBZ1MG_FM3_Loop3:
		sCall	LBZ1MG_FM3_HiHat
		sCall	LBZ1MG_FM3_HiHatSnare
		sLoop	$00,$26,LBZ1MG_FM3_Loop3
		dc.b	$80,$60


LBZ1MG_FM3_Loop4:
		sCall	LBZ1MG_FM3_HiHat
		sCall	LBZ1MG_FM3_HiHatSnare
		sLoop	$00,$0E,LBZ1MG_FM3_Loop4
		dc.b	$80,$60

LBZ1MG_FM3_Loop5:
		sCall	LBZ1MG_FM3_HiHat
		sCall	LBZ1MG_FM3_HiHatSnare
		sLoop	$00,$10,LBZ1MG_FM3_Loop5
		sJump	LBZ1MG_FM3_Loop1

	; --- Hi-hat ---

LBZ1MG_FM3_HiHat:
		sPatFM	$00
		saDetune $03
		dc.b	$DB-$0C,$06,$06
		sPatFM	$01
		dc.b	$DB-$0C,$0B,$80,$01
		sRet

	; --- Hi-hat with a starting snare ---

LBZ1MG_FM3_HiHatSnare:
		sPatFM	$02
		saDetune $00
		dc.b	$B1,$06
		sPatFM	$00
		saDetune $03
		dc.b	$DB-$0C
		sPatFM	$01
		dc.b	$0B,$80,$01
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 4
; ---------------------------------------------------------------------------

LBZ1MG_FM4:
		sPatFM	$04
		saDetune $06
		dc.b	$80,$60,$80,$60

		dc.b	$9E,$60,sHold,$60,sHold,$60,sHold,$60,sHold,$60,sHold,$60

	; --- Guitar section ---

		saTranspose $0C
		saDetune $00
		saVolFM	$F0
		sPatFM	$0B

LBZ1MG_FM4_Verse:
		sCall	LBZ1MG_FM4_Guitar
		dc.b	$80,$18
		sLoop	$00,$04,LBZ1MG_FM4_Verse

	; --- Guitar chorus ---

LBZ1MG_FM4_Chorus:
		sCall	LBZ1MG_FM4_Guitar
		sPatFM	$04
		saDetune $FC
		sCall	LBZ1MG_FM2_Phase1
		saDetune $00
		sPatFM	$0B
		sCall	LBZ1MG_FM4_Guitar
		sPatFM	$04
		saDetune $FC
		sCall	LBZ1MG_FM2_Phase2
		saDetune $00
		sPatFM	$0B

		sCall	LBZ1MG_FM4_Guitar
		sPatFM	$04
		saDetune $FC
		sCall	LBZ1MG_FM2_Phase1
		saDetune $00
		sPatFM	$0B
		sCall	LBZ1MG_FM4_Guitar
		dc.b	$80,$18

	; -- Horn verse ---

		saTranspose $F4
		sPatFM	$0D

		sCall	LBZ1MG_FM4_Horn
		sCall	LBZ1MG_FM2_Horn1
		saTranspose $0C
		dc.b	$80,$18
		sCall	LBZ1MG_FM4_Horn
		sCall	LBZ1MG_FM2_Horn2
		saTranspose $0C
		dc.b	$80,$18
		sCall	LBZ1MG_FM4_Horn
		sCall	LBZ1MG_FM2_Horn1
		saTranspose $0C
		dc.b	$80,$18
		sCall	LBZ1MG_FM4_Horn
		sCall	LBZ1MG_FM2_Horn3
	;	dc.b	$80,$18		Horn3 already has the 18 delay in it
		saTranspose $0C

	; --- Guitar verse ---

		sPatFM	$0E
		saVolFM	$08
		sNoteTimeOut $05

		sPan	$80,$00

LBZ1MG_FM4_GuitarVerse:
		sCall	LBZ1MG_FM4_GuitarV1
		sCall	LBZ1MG_FM4_GuitarV2
		sCall	LBZ1MG_FM4_GuitarV1
		sCall	LBZ1MG_FM4_GuitarV2
	;	sLoop	$00,$05,LBZ1MG_FM4_GuitarVerse

	saTranspose $02
		sCall	LBZ1MG_FM4_GuitarV1
	saTranspose $FF
		sCall	LBZ1MG_FM4_GuitarV2
	saTranspose $FF
		sCall	LBZ1MG_FM4_GuitarV1
	saTranspose $FE
		sCall	LBZ1MG_FM4_GuitarV2
	saTranspose $04
		sCall	LBZ1MG_FM4_GuitarV1
	saTranspose $FF
		sCall	LBZ1MG_FM4_GuitarV2
	saTranspose $FF
		sCall	LBZ1MG_FM4_GuitarV1
;	saTranspose $01
		dc.b	$80,$60-$06
		sNoteTimeOut $00
		saVolFM	$F8
		sPan	$C0,$00
		saTranspose $0C

	; --- Second chorus ---

		dc.b	$80,$60,$80,$60
		dc.b	$80,$60,$80,$48

		sPatFM	$04
		saDetune $FC
		sCall	LBZ1MG_FM2_Phase2
		saDetune $00
		sPatFM	$0B

		sCall	LBZ1MG_FM4_Guitar
		sPatFM	$04
		saDetune $FC
		sCall	LBZ1MG_FM2_Phase1
		saDetune $00
		sPatFM	$0B
		sCall	LBZ1MG_FM4_Guitar
		sPatFM	$04
		saDetune $FC
		sCall	LBZ1MG_FM2_Phase2
		saDetune $00
		sPatFM	$0B

	; --- Horn verse ---

	
		saTranspose $F4

		saVolFM $06
		ssModZ80 $01, $01, $01, $06
		sPatFM $0A
		dc.b nRst, $05, nF4, $48, nE4, $18, nD4, $5A
		dc.b nRst, $06, nF4, $48, nG4, $18, nD4, $55
		dc.b nRst, $06
		saVolFM $FA


	;	saTranspose $0C
		saVolFM	$10
		sJump	LBZ1MG_FM4




	; --- Guitar subroutines ---

LBZ1MG_FM4_GuitarV1:
		dc.b	$80,$0C,$B9,$12,$12,$06,$06,$06,$BB,$B9,$BB,$0C,$B9,$0C
		sRet

LBZ1MG_FM4_GuitarV2:
		dc.b	$80,$06
		dc.b	$B9,$12,$0C
		sNoteTimeOut $00
		dc.b	$C0,$0C
		sNoteTimeOut $05
		dc.b	$06,$06,$06,$06,$C2,$0C,$B9,$06
		sRet

	; --- Horn subroutine  ---

LBZ1MG_FM4_Horn:
		saVolFM	$F8
		sPan	$40,$00
		ssModZ80 $11,$01,$B8,$FF

LBZ1MG_FM4_HornLoop:
		dc.b	$CE,$12
		saVolFM	$06
		sLoop	$00,$02,LBZ1MG_FM4_HornLoop
		saTranspose $F4
		sModOff
		sPan	$C0,$00
		dc.b	$C2,$0C
		saVolFM	$04

LBZ1MG_FM4_HornLoop2:
		dc.b	sHold,$0C
		saVolFM	$FE
		sLoop	$00,$04,LBZ1MG_FM4_HornLoop2
		sRet

LBZ1MG_FM4_Guitar:
		dc.b	nRst, $06, nBb3, $04, nRst, $0E, nBb3, $12, nBb3, $06, nRst, $18
		dc.b	nRst, $30
		dc.b	nBb3, $12, nBb3, $06, nRst, $18
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 5
; ---------------------------------------------------------------------------

LBZ1MG_FM5:
		sPatFM	$05
		saDetune $87
		dc.b	$80,$60,$80,$60,$80,$60
		ssModZ80 $01,$01,$F9,$C8
		dc.b	$C8,$60,sHold,$60
		sModOff

LBZ1MG_FM5_Loop:
		dc.b	$80,$60
		sLoop	$00,$0B,LBZ1MG_FM5_Loop

		saVolFM	$EC
		sPatFM	$04
		saTranspose $07
		dc.b	$80,$60
		dc.b	$80,$48
		sCall	LBZ1MG_FM2_Phase1
		dc.b	$80,$60
		dc.b	$80,$48
		sCall	LBZ1MG_FM2_Phase2
		dc.b	$80,$60
		dc.b	$80,$48
		sCall	LBZ1MG_FM2_Phase1

LBZ1MG_FM5_Idle:
		dc.b	$80,$60
		sLoop	$00,$16,LBZ1MG_FM5_Idle

		dc.b	$80,$60,$80,$60
		dc.b	$80,$60,$80,$48
		sCall	LBZ1MG_FM2_Phase2
		dc.b	$80,$60
		dc.b	$80,$48
		sCall	LBZ1MG_FM2_Phase1
		dc.b	$80,$60
		dc.b	$80,$48
		sCall	LBZ1MG_FM2_Phase2

		saTranspose $F9
		saVolFM	$14
		dc.b	$80,$60,$80,$60
		dc.b	$80,$60,$80,$60
		sJump	LBZ1MG_FM5

		sStop

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG 1
; ---------------------------------------------------------------------------

LBZ1MG_PSG2:
		dc.b	$80,$01
		sModEnv	ModEnv_01




LBZ1MG_PSG1:
		dc.b	$80,$60
		sLoop	$00,$0F,LBZ1MG_PSG1

		sCall	LBZ1MG_PSG1_Whistle

LBZ1MG_PSG1_Loop2:
		dc.b	$80,$60
		sLoop	$00,$08,LBZ1MG_PSG1_Loop2

LBZ1MG_HornVerse:
		saTranspose $E8
		sCall	LBZ1MG_PSG1_Horn
		dc.b	$80,$60
		sCall	LBZ1MG_PSG1_Horn
		saTranspose $18
		dc.b	$80,$06
		sCall	LBZ1MG_PSG1_WhistleShort
		dc.b	$80,$18

		saTranspose $E8
		sCall	LBZ1MG_PSG1_Horn
		dc.b	$80,$60
		sCall	LBZ1MG_PSG1_Horn
		saTranspose $18+3
		dc.b	$80,$06
		sCall	LBZ1MG_PSG1_WhistleShort
		dc.b	$80,$18+$06
		saTranspose $FD

LBZ1MG_PSG1_Loop3:
		dc.b	$80,$60
		sLoop	$00,$0B,LBZ1MG_PSG1_Loop3

		sCall	LBZ1MG_PSG1_Whistle
		dc.b	$80,$06

LBZ1MG_PSG1_Loop4:
		dc.b	$80,$60
		sLoop	$00,$0C,LBZ1MG_PSG1_Loop4
		sJump	LBZ1MG_PSG1

	; --- LBZ's whistle bit ---

LBZ1MG_PSG1_Whistle:
		sNoteTimeOut $05
		sVolEnvPSG VolEnv_11
		dc.b	nF5, $06, nRst, nG5, nRst, nD5, nRst, nF5
		dc.b	nF5, nRst, nF5, nG5, nRst, nD5, nRst, nF5
		sNoteTimeOut $00
		sRet


LBZ1MG_PSG1_WhistleShort:
		sNoteTimeOut $05
		sVolEnvPSG VolEnv_11
		dc.b	nF5, $06, nRst, nG5, nRst, nD5, nRst, nF5
		dc.b	nF5, nRst, nF5, nG5
		sNoteTimeOut $00
		sRet

	; --- SOR's horn bit ---

LBZ1MG_PSG1_Horn:
		dc.b	$80,$12
		sCall	LBZ1MG_FM2_Horn_End
		dc.b	$C2,$80,$30
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG 2
; ---------------------------------------------------------------------------

		sStop

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG 3
; ---------------------------------------------------------------------------

LBZ1MG_PSG3:
		sStop

; ===========================================================================
; ---------------------------------------------------------------------------
; Instruments/Patches
; ---------------------------------------------------------------------------

LBZ1MG_Patches:

	; Use $32,$32,$33,$33 for original HAT frequency
	; Then step up the notes by an octave (by $0C) for
	; the original frequency/note, this one is identical
	; to SOR2, except, it won't display in the sound test
	; because the frequency is too high...

	; 00 - SOR2 HAT SHORT

	dc.b	$3C
	dc.b	$34,$34,$76,$76, $1F,$1F,$1F,$1F, $80,$91,$80,$91
	dc.b	$00,$12,$1F,$12, $3F,$2F,$2F,$4F, $00,$80,$00,$80

	; 01 - SOR2 HAT LONG

	dc.b	$3C
	dc.b	$34,$34,$76,$76, $1F,$1F,$1F,$1F, $80,$8B,$80,$8A
	dc.b	$00,$10,$1F,$0F, $3F,$2F,$2F,$4F, $00,$80,$00,$80

	; 02 - SOR2 SNARE

	dc.b	$3C
	dc.b	$3F,$30,$30,$30, $1F,$1F,$1F,$1F, $80,$8F,$98,$93
	dc.b	$00,$11,$00,$10, $08,$2C,$B8,$2C, $0E,$80,$13,$80

	; 03 - SOR1 BASS

	dc.b	$04
	dc.b	$00,$00,$01,$02, $9F,$1F,$9F,$1F, $8A,$8A,$91,$94
	dc.b	$0E,$0A,$0E,$0E, $F8,$48,$F8,$F8, $17,$80,$07,$80

	; 04 - SOR1 CINIMATIC?

	dc.b	$30
	dc.b	$60,$32,$30,$31, $05,$07,$11,$18, $85,$80,$80,$84
	dc.b	$02,$00,$00,$04, $3F,$2F,$2F,$2F, $12,$19,$1A,$80

	; 05 - SOR1 SCRATCHWIST

	dc.b	$04
	dc.b	$32,$32,$72,$72, $1F,$1F,$1F,$1F, $80,$88,$80,$88
	dc.b	$00,$04,$1F,$04, $3F,$2F,$2F,$4F, $00,$80,$00,$80

	; 06 - SOR2 BASS

	dc.b	$06
	dc.b	$00,$00,$01,$02, $9F,$1F,$9F,$1F, $8A,$8A,$91,$94
	dc.b	$0E,$0A,$0E,$0E, $F8,$48,$F8,$F8, $17,$80,$80,$80

	; 07 - SOR2 PIANO

	dc.b	$3A
	dc.b	$71,$0C,$33,$01, $54,$54,$53,$51, $84,$89,$84,$8A
	dc.b	$00,$01,$03,$05, $15,$15,$15,$25, $25,$2F,$25,$80

	; 08 - SOR2 RAVE STAT?

	dc.b	$2B
	dc.b	$31,$32,$35,$31, $1F,$59,$9E,$5E, $80,$80,$80,$8B
	dc.b	$01,$17,$12,$0A, $AA,$AF,$F9,$FC, $0B,$12,$50,$80

	; 09 - LBZ BASS

	dc.b	$03
	dc.b	$62,$40,$44,$31, $1F,$1F,$1F,$1C, $0B,$0A,$02,$01
	dc.b	$08,$0B,$04,$06, $1F,$1F,$1F,$1F, $2A,$1A,$2B,$80

	; 0A - LBZ HORN

	dc.b	$3D
	dc.b	$01,$02,$02,$02, $1F,$08,$8A,$0A, $08,$08,$08,$08
	dc.b	$00,$01,$00,$00, $0F,$1F,$1F,$1F, $1F,$88,$88,$87

	; 0B - LBZ GUITAR

	dc.b	$3A
	dc.b	$31,$7F,$61,$0A, $9C,$DB,$9C,$9A, $04,$08,$03,$09
	dc.b	$03,$01,$00,$00, $1F,$0F,$FF,$FF, $23,$25,$1B,$84

	; 0C - LBZ TRUMPET?

	dc.b	$3A
	dc.b	$01,$07,$31,$11, $8E,$8E,$8D,$53, $0E,$0E,$0E,$03
	dc.b	$00,$00,$00,$07, $1F,$FF,$1F,$0F, $18,$28,$17,$82

	; 0D - SOR1 HORN

	dc.b	$3A
	dc.b	$31,$37,$31,$31, $8D,$8D,$8E,$53, $8E,$8E,$8E,$83
	dc.b	$00,$00,$00,$00, $13,$FA,$13,$0A, $17,$28,$26,$80

	; 0E - SOR2 Guitar

	dc.b	$3A
	dc.b	$38,$4A,$40,$31, $1F,$DF,$1F,$9F, $8C,$8A,$8C,$8F
	dc.b	$04,$04,$04,$02, $16,$F6,$06,$36, $20,$41,$0D,$80

; ===========================================================================