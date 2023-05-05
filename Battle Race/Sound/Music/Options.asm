; ===========================================================================
; ---------------------------------------------------------------------------
; Options Theme
; ---------------------------------------------------------------------------

OPTIONS_Header:
		sHeaderInit
		sHeaderPatch	OPTIONS_Patches
		sHeaderCh	$06, $03
		sHeaderTempo	$01, $10
		sHeaderDAC	OPTIONS_DAC
		sHeaderFM	OPTIONS_FM1, $00, $0C
		sHeaderFM	OPTIONS_FM2, $00, $14
		sHeaderFM	OPTIONS_FM3, $00, $14
		sHeaderFM	OPTIONS_FM4, $00, $10
		sHeaderFM	OPTIONS_FM5, $00, $10
		sHeaderPSG	OPTIONS_PSG1, $0C, $05, $00, VolEnv_00
		sHeaderPSG	OPTIONS_PSG2, $0C, $05, $00, VolEnv_00
		sHeaderPSG	OPTIONS_PSG3, $00, $04, $00, VolEnv_00

; ===========================================================================
; ---------------------------------------------------------------------------
; DAC
; ---------------------------------------------------------------------------

OPTIONS_DAC:
		dc.b	$80,$08

		dc.b	$9B,$08,$10,$08

OPTDAC_Loop:
		dc.b	$9B,$08,$08,$08,$08
		sCall	OPTDAC_Main
		dc.b	$9B,$18,$86,$08
		sCall	OPTDAC_Main
		dc.b	$90,$08,$91,$92,$93
		sCall	OPTDAC_Main
		dc.b	$9B,$18,$86,$08
		sCall	OPTDAC_Main
		sJump	OPTDAC_Loop

OPTDAC_Main:
		dc.b	$88,$20,$9B,$86,$08,$10,$08,$9B,$20
		dc.b	$86,$20,$9B,$18,$86,$08,$08,$10,$08,$9B,$18,$86,$08
		dc.b	$86,$20,$9B,$86,$08,$10,$08,$9B,$20
		dc.b	$86,$20,$9B,$18,$86,$08,$08,$10,$08
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 1
; ---------------------------------------------------------------------------

OPTIONS_FM1:
		dc.b	$80,$28

		sPatFM	$00
		dc.b	$A9,$06
		dc.b	$80,$02
		dc.b	$A8,$06
		dc.b	$80,$02
		dc.b	$A9,$06
		dc.b	$80,$02
		dc.b	$B0,$06
		dc.b	$80,$02

OPTFM1_Loop:
		sCall	OPTFM1_BassLoop
		sCall	OPTFM1_BassLoop
		sCall	OPTFM1_BassLoop
		sCall	OPTFM1_BassLoop
		saTranspose $01
		sCall	OPTFM1_BassLoop
		sCall	OPTFM1_BassLoop
		saTranspose $FF
		sJump	OPTFM1_Loop

OPTFM1_BassLoop:
		sCall	OPTFM1_BassStart
		dc.b	$A4,$06
		dc.b	$80,$02
		dc.b	$A6,$06
		dc.b	$80,$02
		dc.b	$A2,$10
		dc.b	$80,$40
		dc.b	$A9,$06
		dc.b	$80,$02
		dc.b	$A8,$06
		dc.b	$80,$02
		dc.b	$A9,$06
		dc.b	$80,$02
		dc.b	$B0,$06
		dc.b	$80,$02

		sCall	OPTFM1_BassStart
		dc.b	$9F,$04
		dc.b	$80
		dc.b	$A8,$10
		dc.b	$80,$08
		dc.b	$A7,$04
		dc.b	$80
		dc.b	$A7,$08
		dc.b	$80,$08
		dc.b	$9F,$04
		dc.b	$80
		dc.b	$A6
		dc.b	$80
		dc.b	$A6,$10
		dc.b	$80,$10
		dc.b	$A6,$06
		dc.b	$80,$02
		dc.b	$A9,$06
		dc.b	$80,$02
		dc.b	$B0,$06
		dc.b	$80,$02
		sRet

OPTFM1_BassStart:
		dc.b	$AF,$10,$9F,$9F,$04
		dc.b	$80
		dc.b	$AB
		dc.b	$80
		dc.b	$A9,$10
		dc.b	$80,$08
		dc.b	$9F,$10
		dc.b	$80,$08
		dc.b	$9F,$10
		dc.b	$80,$08
		dc.b	$9F,$04
		dc.b	$80
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 2
; ---------------------------------------------------------------------------

OPTIONS_FM2:
		dc.b	$80,$48

OPTFM2_Loop1:
		sCall	OPTFM2_Main
		sCall	OPTFM2_Main
		sCall	OPTFM2_Main
		sCall	OPTFM2_Main
		saTranspose $01
		sCall	OPTFM2_Main
		sCall	OPTFM2_Main
		saTranspose $FF
		sJump	OPTFM2_Loop1

OPTFM2_Main:
		sPatFM	$01
		sPan	$80,$00
		dc.b	$80,$10,$B5,$06
		saVolFM	$10
		dc.b	$0A
		saVolFM	$F0
		dc.b	$B5,$06
		saVolFM	$10
		dc.b	$0A
		saVolFM	$F0
		dc.b	$B4,$08,$B5,$06
		saVolFM	$10
		dc.b	$B4,$08,$B5,$06,$80,$2C
		saVolFM	$F0
		dc.b	$B2,$06
		saVolFM	$10
		dc.b	$0A
		saVolFM	$F0
		dc.b	$B2,$08

		sPatFM	$02
		saVolFM	$08
		dc.b	$B0,$06
		saVolFM	$10
		dc.b	$0A
		saVolFM	$F0
		dc.b	$B0,$06
		saVolFM	$10
		dc.b	$0A
		saVolFM	$F0
		dc.b	$B0,$08

		saVolFM	$F8
		sPatFM	$01
		dc.b	$B2,$06
		saVolFM	$18
		dc.b	$B0,$08
		saVolFM	$F8
		dc.b	$B2,$06
		dc.b	$80,$44
		saVolFM	$F0
		dc.b	$B5,$06
		saVolFM	$10
		dc.b	$0A
		saVolFM	$F0
		dc.b	$B5,$06
		saVolFM	$10
		dc.b	$0A
		saVolFM	$F0
		dc.b	$B4,$08,$B5,$06
		saVolFM	$10
		dc.b	$B4,$08,$B5,$06,$80,$2C
		saVolFM	$F0
		dc.b	$B2,$06
		saVolFM	$10
		dc.b	$0A
		saVolFM	$F0
		dc.b	$B2,$08

		sPatFM	$02
		saVolFM	$08

OPTFM2_Loop2:
		dc.b	$B0,$06
		saVolFM	$10
		dc.b	$0A
		saVolFM	$F0
		sLoop	$00,$03,OPTFM2_Loop2
		dc.b	$B0,$06
		saVolFM	$10
		dc.b	$02

		saVolFM	$E8
		sPan	$C0
		sPatFM	$05
		dc.b	$B5,$18
		dc.b	$B5,$10
		dc.b	$B7,$10

		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 3
; ---------------------------------------------------------------------------

OPTIONS_FM3:
		dc.b	$80,$48
		sPatFM	$02
		sPan	$40

OPTFM3_Loop1:
		sCall	OPTFM3_Main
		sCall	OPTFM3_Main
		sCall	OPTFM3_Main
		sCall	OPTFM3_Main
		saTranspose $01
		sCall	OPTFM3_Main
		sCall	OPTFM3_Main
		saTranspose $FF
		sJump	OPTFM3_Loop1

OPTFM3_Main:
		dc.b	$80,$10,$B5,$06
		saVolFM	$10
		dc.b	$0A
		saVolFM	$F0
		dc.b	$B5,$06
		saVolFM	$10
		dc.b	$0A
		saVolFM	$F0
		dc.b	$B4,$08,$B5,$06
		saVolFM	$10
		dc.b	$B4,$08,$B5,$06,$80,$0C

		saVolFM	$E8
		sPatFM	$04
		saDetune $F8
		dc.b	$B7,$20
		saDetune $08

		sPatFM	$02
		saVolFM	$08
		dc.b	$B2,$06
		saVolFM	$10
		dc.b	$0A
		saVolFM	$F0
		dc.b	$B2,$08,$B0,$06
		saVolFM	$10
		dc.b	$0A
		saVolFM	$F0
		dc.b	$B0,$06
		saVolFM	$10
		dc.b	$0A
		saVolFM	$F0
		dc.b	$B0,$08,$B2,$06
		saVolFM	$10
		dc.b	$B0,$08,$B2,$06,$80,$44
		saVolFM	$F0
		dc.b	$B5,$06
		saVolFM	$10
		dc.b	$0A
		saVolFM	$F0
		dc.b	$B5,$06
		saVolFM	$10
		dc.b	$0A
		saVolFM	$F0
		dc.b	$B4,$08,$B5,$06
		saVolFM	$10
		dc.b	$B4,$08,$B5,$06,$80,$2C
		saVolFM	$F0
		dc.b	$B2,$06
		saVolFM	$10
		dc.b	$0A
		saVolFM	$F0
		dc.b	$B2,$08


OPTFM3_Loop2:
		dc.b	$B0,$06
		saVolFM	$10
		dc.b	$0A
		saVolFM	$F0
		sLoop	$00,$07,OPTFM3_Loop2
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 4
; ---------------------------------------------------------------------------

OPTIONS_FM4:
		dc.b	$80,$48

OPTFM4_Loop:
		sCall	OPTFM4_Main
		sCall	OPTFM4_Main
		sCall	OPTFM4_Main
		sCall	OPTFM4_Main
		saTranspose $01
		sCall	OPTFM4_Main
		sCall	OPTFM4_Main
		saTranspose $FF
		sJump	OPTFM4_Loop

OPTFM4_Main:
		sPatFM	$03
		sPan	$80
		dc.b	$B2,$10
		saVolFM	$18
		sPan	$C0
		dc.b	$08
		sPan	$40
		saVolFM	$E8
		dc.b	$B7,$10
		saVolFM	$18
		sPan	$C0
		dc.b	$10
		dc.b	$80,$08
		sPan	$80
		saVolFM	$E8
		dc.b	$B5,$08,$10

		sPan	$C0
		sPatFM	$04
		saVolFM	$FC
		dc.b	$B7,$38

		sPatFM	$03
		saVolFM	$1C
		sPan	$C0
		dc.b	$10
		dc.b	$80,$20
		sPan	$80
		saVolFM	$E8
		dc.b	$B4,$08
		dc.b	$10
		sPan	$40
		dc.b	$B5,$10
		sPan	$80
		dc.b	$B4,$10
		saVolFM	$18
		sPan	$C0
		dc.b	$B5,$08
		sPan	$80
		saVolFM	$E8
		dc.b	$B2,$10
		saVolFM	$18
		sPan	$C0
		dc.b	$08
		sPan	$40
		saVolFM	$E8
		dc.b	$B7,$10
		saVolFM	$18
		sPan	$C0
		dc.b	$10
		dc.b	$80,$08
		sPan	$80
		saVolFM	$E8
		dc.b	$B5,$08
		dc.b	$10
		saVolFM	$18
		sPan	$C0
		dc.b	$08
		sPan	$40
		saVolFM	$E8
		dc.b	$10
		saVolFM	$18
		sPan	$C0
		dc.b	$10
		sPan	$80
		saVolFM	$E8
		dc.b	$B5,$10
		saVolFM	$18
		sPan	$C0
		dc.b	$10
		dc.b	$80,$20
		sPan	$80
		saVolFM	$E8
		dc.b	$B4,$08

		sPatFM	$05
		saVolFM	$04
		dc.b	$AE,$18,$AE,$10,$B0,$10
		saVolFM	$FC
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 5
; ---------------------------------------------------------------------------

OPTIONS_FM5:
		dc.b	$80,$48

OPTFM5_Loop:
		sCall	OPTFM5_Main
		sCall	OPTFM5_Main
		sCall	OPTFM5_Main
		sCall	OPTFM5_Main
		saTranspose $01
		sCall	OPTFM5_Main
		sCall	OPTFM5_Main
		saTranspose $FF
		sJump	OPTFM5_Loop

OPTFM5_Main:
		sPatFM	$03
		sPan	$80
		dc.b	$AF,$10
		saVolFM	$18
		sPan	$C0
		dc.b	$08
		sPan	$40
		saVolFM	$E8
		dc.b	$AF,$10
		saVolFM	$18
		sPan	$C0
		dc.b	$10
		dc.b	$80,$08
		sPan	$80
		saVolFM	$E8
		dc.b	$B0,$08,$10

		sPan	$C0
		sPatFM	$04
		saVolFM	$FC
		dc.b	$B4,$38

		sPatFM	$03
		saVolFM	$1C
		sPan	$C0
		dc.b	$10
		dc.b	$80,$20
		sPan	$80
		saVolFM	$E8
		dc.b	$B0,$08,$10
		sPan	$40
		dc.b	$B0,$10
		sPan	$80
		dc.b	$AF,$10
		saVolFM	$18
		sPan	$C0
		dc.b	$B0,$08
		sPan	$80
		saVolFM	$E8
		dc.b	$AF,$10
		saVolFM	$18
		sPan	$C0
		dc.b	$08
		sPan	$40
		saVolFM	$E8
		dc.b	$AF,$10
		saVolFM	$18
		sPan	$C0
		dc.b	$10
		dc.b	$80,$08
		sPan	$80
		saVolFM	$E8
		dc.b	$B0,$08,$10
		saVolFM	$18
		sPan	$C0
		dc.b	$08
		sPan	$40
		saVolFM	$E8
		dc.b	$10
		saVolFM	$18
		sPan	$C0
		dc.b	$10
		sPan	$80
		saVolFM	$E8
		dc.b	$B2,$10
		saVolFM	$18
		sPan	$C0
		dc.b	$10
		dc.b	$80,$20
		sPan	$80
		saVolFM	$E8
		dc.b	$B0,$08

		sPan	$40
		sPatFM	$05
		saVolFM	$04
		dc.b	$B2,$18,$B2,$10,$B4,$10
		saVolFM	$FC
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG  1
; ---------------------------------------------------------------------------

OPTIONS_PSG1:
		saVolPSG $03
		saDetune $01

		dc.b	$80,$18

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG  2
; ---------------------------------------------------------------------------

OPTIONS_PSG2:
		dc.b	$80,$48

OPTPSG2_Loop1:
		dc.b	$80,$40
		sLoop	$00,($04*4)-1,OPTPSG2_Loop1
		dc.b	$80,$20
		sVolEnvPSG $0A
		sCall	OPTPSG2_VerseUp

		sCall	OPTPSG2_Verse
		sCall	OPTPSG2_VerseDown
		sCall	OPTPSG2_Verse
		sCall	OPTPSG2_VerseUp
		saTranspose $01
		sCall	OPTPSG2_Verse
		sCall	OPTPSG2_VerseUp
		sCall	OPTPSG2_Verse
		sCall	OPTPSG2_VerseDown
		saTranspose $FF
		sJump	OPTPSG2_Loop1

OPTPSG2_Verse:
		sVolEnvPSG $0D
		saVolPSG $02
		dc.b	$9F,$40,$9D,$9A,$9C
		dc.b	$9F,$9D,$A2,$A4,$20
		saVolPSG $FE
		sVolEnvPSG $0A
		sRet

OPTPSG2_VerseUp:
		dc.b	$98,$08,$9A,$9C,$9D
		sRet

OPTPSG2_VerseDown:
		dc.b	$A2,$08,$9F,$9D,$9A
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG  3
; ---------------------------------------------------------------------------

OPTIONS_PSG3:
		sNoisePSG $E7
		sVolEnvPSG $02
		dc.b	$80,$48

OPTPSG3_Loop:
		dc.b	nBb6,$08,$08
		sVolEnvPSG $05
		dc.b	$08
		sVolEnvPSG $02
		dc.b	$08
		sJump	OPTPSG3_Loop

; ===========================================================================
; ---------------------------------------------------------------------------
; Instruments
; ---------------------------------------------------------------------------

OPTIONS_Patches:

	; 00 - Bass

	dc.b	$38
	dc.b	$75,$13,$70,$11, $DF,$1F,$1F,$1F, $0E,$10,$00,$00
	dc.b	$00,$00,$00,$00, $F0,$F0,$F0,$FA, $1F,$20,$22,$81

	; 01 - Backing Guitar (Part 1)

	dc.b	$20
	dc.b	$3E,$3F,$31,$31, $FF,$FF,$BF,$BF, $07,$0F,$0E,$06
	dc.b	$07,$09,$01,$09, $20,$10,$20,$F7, $19,$27,$13,$88

	; 02 - Backing Guitar (Part 2)

	dc.b	$20
	dc.b	$38,$38,$31,$32, $FF,$FF,$BF,$BF, $07,$06,$0E,$06
	dc.b	$07,$06,$01,$09, $20,$10,$30,$F7, $1D,$37,$17,$82

	; 03 - Backing chord pad

	dc.b	$01
	dc.b	$73,$32,$71,$32, $9F,$9F,$9F,$9F, $11,$12,$0A,$0B
	dc.b	$08,$15,$08,$0D, $60,$90,$20,$39, $29,$25,$1C,$80

	; 04 - Bell Piano

	dc.b	$3C
	dc.b	$72,$42,$32,$32, $12,$12,$12,$12, $00,$18,$00,$18
	dc.b	$00,$0C,$00,$0B, $0F,$3F,$0F,$3F, $24,$80,$20,$80

	; 05 - Sharper Bell Piano

	dc.b	$04
	dc.b	$72,$42,$32,$32, $7F,$12,$12,$12, $0D,$18,$00,$18
	dc.b	$08,$0A,$00,$0A, $4F,$3F,$0F,$3F, $08,$80,$18,$80

; ===========================================================================
