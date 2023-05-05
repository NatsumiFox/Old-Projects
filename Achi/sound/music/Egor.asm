Area_A_Header:
	sHeaderInit						; Z80 offset is $0000
	sHeaderTempo	$01, $40
	sHeaderCh	$05, $03
	sHeaderDAC	Area_A_DAC
	sHeaderDAC	Area_A_DAC2
	sHeaderFM	Area_A_FM1, $00, $0C	; Lead
	sHeaderFM	Area_A_FM3, $00, $0C	; Pads
	sHeaderFM	Area_A_FM2, $00, $0E	; FM bass
	sHeaderFM	Area_A_FM5, $00, $0E	; Pads
	sHeaderFM	Area_A_FM4, $00, $0E	; Pads
	sHeaderPSG	Area_A_PSG1, $00, $03, $00, VolEnv_00	; Square (Lead Support)
	sHeaderPSG	Area_A_PSG2, $00, $05, $00, VolEnv_00	; Square (Lead Support) Echo
	sHeaderPSG	Area_A_PSG3, $00, $01, $00, VolEnv_02	; Square (Lead Support) Echo

	; Patch $00
	; $3C
	; $01, $02, $0F, $04,	$8D, $52, $9F, $1F
	; $09, $00, $00, $0D,	$00, $00, $00, $00
	; $23, $08, $02, $F7,	$15, $82, $1D, $84
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $0F, $02, $04
	spRateScale	$02, $02, $01, $00
	spAttackRt	$0D, $1F, $12, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$09, $00, $00, $0D
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$02, $00, $00, $0F
	spReleaseRt	$03, $02, $08, $07
	spTotalLv	$15, $1D, $02, $04

	; Patch $01
	; $3A
	; $51, $0C, $33, $01,	$53, $53, $52, $52
	; $04, $09, $04, $0A,	$00, $01, $03, $04
	; $17, $17, $17, $57,	$25, $2F, $25, $8C
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$05, $03, $00, $00
	spMultiple	$01, $03, $0C, $01
	spRateScale	$01, $01, $01, $01
	spAttackRt	$13, $12, $13, $12
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$04, $04, $09, $0A
	spSustainRt	$00, $03, $01, $04
	spSustainLv	$01, $01, $01, $05
	spReleaseRt	$07, $07, $07, $07
	spTotalLv	$25, $25, $2F, $0C

	; Patch $02
	; $38
	; $58, $54, $31, $31,	$1A, $1A, $14, $13
	; $00, $00, $00, $00,	$00, $00, $00, $00
	; $0F, $0F, $0F, $0F,	$1C, $26, $20, $89
	spAlgorithm	$00
	spFeedback	$07
	spDetune	$05, $03, $05, $03
	spMultiple	$08, $01, $04, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1A, $14, $1A, $13
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1C, $20, $26, $09

	; Patch $03
	; $38
	; $32, $00, $00, $03,	$1F, $1F, $1F, $1F
	; $06, $09, $07, $03,	$00, $00, $00, $00
	; $17, $15, $16, $16,	$11, $1B, $18, $80
	spAlgorithm	$00
	spFeedback	$07
	spDetune	$03, $00, $00, $00
	spMultiple	$02, $00, $00, $03
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$06, $07, $09, $03
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$01, $01, $01, $01
	spReleaseRt	$07, $06, $05, $06
	spTotalLv	$11, $18, $1B, $00

	; Patch $04
	; $3D
	; $01, $63, $60, $01,	$5F, $1F, $1F, $51
	; $07, $06, $06, $06,	$04, $04, $05, $03
	; $0F, $0F, $0F, $0F,	$15, $98, $8C, $8C
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $06, $06, $00
	spMultiple	$01, $00, $03, $01
	spRateScale	$01, $00, $00, $01
	spAttackRt	$1F, $1F, $1F, $11
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$07, $06, $06, $06
	spSustainRt	$04, $05, $04, $03
	spSustainLv	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$15, $0C, $18, $0C

	; Patch $05
	; $3D
	; $00, $01, $01, $01,	$10, $50, $50, $50
	; $07, $08, $08, $08,	$01, $00, $00, $00
	; $24, $18, $18, $18,	$1C, $88, $88, $88
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $01, $01, $01
	spRateScale	$00, $01, $01, $01
	spAttackRt	$10, $10, $10, $10
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$07, $08, $08, $08
	spSustainRt	$01, $00, $00, $00
	spSustainLv	$02, $01, $01, $01
	spReleaseRt	$04, $08, $08, $08
	spTotalLv	$1C, $08, $08, $08

	; Patch $06
	; $3D
	; $01, $02, $02, $02,	$1F, $1D, $9F, $1D
	; $08, $05, $02, $05,	$00, $08, $08, $08
	; $1F, $1F, $1F, $1F,	$1A, $94, $A9, $82
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $02, $02, $02
	spRateScale	$00, $02, $00, $00
	spAttackRt	$1F, $1F, $1D, $1D
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$08, $02, $05, $05
	spSustainRt	$00, $08, $08, $08
	spSustainLv	$01, $01, $01, $01
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1A, $29, $14, $02

Area_A_DAC:
	sPan		spCenter, $00

Area_A_Jump3:
	dc.b dCrash, $7F, nRst, nRst, $42, dCrash, $7F, nRst
	dc.b $71, dKickSVA

Area_A_Loop52:
	dc.b $0A
	sLoop		$00, $08, Area_A_Loop52
	dc.b dCrash, $14

Area_A_Loop53:
	dc.b dSnareSVA, dKickSVA
	sLoop		$00, $07, Area_A_Loop53
	dc.b dSnareSVA, dCrash

Area_A_Loop54:
	dc.b dSnareSVA, dKickSVA
	sLoop		$00, $05, Area_A_Loop54
	dc.b dSnareSVA, dCrash, $50, dCrash, $14

Area_A_Loop55:
	dc.b dSnareSVA, dKickSVA
	sLoop		$00, $07, Area_A_Loop55
	dc.b dSnareSVA, dCrash

Area_A_Loop56:
	dc.b dSnareSVA, dKickSVA
	sLoop		$00, $06, Area_A_Loop56
	dc.b dSnareSVA, $28, $14

Area_A_Loop58:
	dc.b dCrash

Area_A_Loop57:
	dc.b dSnareSVA, dKickSVA
	sLoop		$00, $07, Area_A_Loop57
	dc.b dSnareSVA
	sLoop		$01, $02, Area_A_Loop58
	dc.b dCrash, dSnareSVA, dKickSVA, dSnareSVA, dKickSVA, dSnareSVA, dKickSVA, dSnareSVA
	sJump		Area_A_Jump3

Area_A_DAC2:
	sPan		spCenter, $00

Area_A2_Jump1:
	dc.b dCrash, $7F, nRst, nRst, $42

Area_A2_Loop4:
	ssVol		$1C
	dc.b dLowSnare

Area_A2_Loop1:
	dc.b $05
	saVol		-1
	sLoop		$00, $38, Area_A2_Loop1
	ssVol		$00

Area_A2_Loop2:
	dc.b $03, $02
	sLoop		$00, $08, Area_A2_Loop2

Area_A2_Loop3:
	dc.b dHatCl, $05, $05, dHatOp, $0A, dSnareSVA, $05, dHatCl
	dc.b dHatOp, $0A
	sLoop		$00, $08, Area_A2_Loop3
	sLoop		$01, $03, Area_A2_Loop4

Area_A2_Loop5:
	dc.b dKickSVA, $05, dHatCl, dHatOp, $0A, dSnareSVA, $05, dHatCl
	dc.b dHatOp, $0A
	sLoop		$00, $04, Area_A2_Loop5
	ssVol		$1C
	dc.b dLowSnare

Area_A2_Loop6:
	dc.b $05
	saVol		-1
	sLoop		$00, $38, Area_A2_Loop6
	ssVol		$00

Area_A2_Loop7:
	dc.b $03, $02
	sLoop		$00, $08, Area_A2_Loop7
	sJump		Area_A2_Jump1

Area_A_FM1:
	ssMod68k	$10, $01, $05, $04

Area_A_Loop3:
	sPan		spCenter, $00
	sPatFM		$00
	dc.b nC5

Area_A_Loop1:
	dc.b $05, nRst, nC5, nF5, nRst, nC5
	sLoop		$00, $02, Area_A_Loop1
	dc.b nB4, nRst, nD5, nD5, nE5, nRst, nE5, nC5
	dc.b nRst, nE5, nB4, nRst, nE5, nD5, nRst, nE5
	dc.b nC5, nE5, nB4, nRst

Area_A_Loop2:
	dc.b nC5, nRst, nC5, nF5, nRst, nC5
	sLoop		$00, $02, Area_A_Loop2
	dc.b nB4, nRst, nD5, nD5, nE5, nRst, nE5, nC5
	dc.b nRst, nE5, nB4, nRst, nE5, nD5, nRst, nE5
	dc.b nB4, nC5, nE5, nRst
	sLoop		$01, $03, Area_A_Loop3

Area_A_Loop4:
	dc.b nC5, nRst, nC5, nF5, nRst, nC5
	sLoop		$00, $02, Area_A_Loop4
	dc.b nB4, nRst, nD5, nD5, nE5, nRst, nE5, nC5
	dc.b nRst, nE5, nB4, nRst, nE5, nD5, nRst, nE5
	dc.b nC5, nE5, nB4, nRst

Area_A_Loop5:
	dc.b nC5, nRst, nC5, nF5, nRst, nC5
	sLoop		$00, $02, Area_A_Loop5
	dc.b nB4, nRst, nD5, nD5, nE5, nRst, nE5, nC5
	dc.b nRst, nE5, nB4, nRst, nE5, nD5, nRst, nE5
	sPatFM		$05
	dc.b nA5, nB5, nC6, nG6, nF6, $1E, nE6, $14
	dc.b nB5, $1E, nC6, nD6, nA5, $05, nB5, nC6
	dc.b nG6, nF6, $1E, nE6, $14, nG6, $0A, nB6
	dc.b $14, $0F, nC7, nA6, $1E, nA5, $05, nB5
	dc.b nC6, nG6, nF6, $1E, nE6, $14, nB5, $1E
	dc.b nC6, nD6, nA5, $05, nB5, nC6, nG6, nF6
	dc.b $0A, nE6, $05, nF6, nG6, $0A, nF6, $05
	dc.b nG6, nA6, $0A, nG6, $05, nA6, nB6, $0A
	dc.b nA6, $05, nB6, nC7, $3C
	sPatFM		$06
	dc.b nB4, $05, nC5, nD5, nE5, nF5, $1E, nBb4
	dc.b $14, nF5, $1E, nA5, nF5, $14, nG5, nFs5
	dc.b $05, nF5, nE5, $46, nEb5, $05, nD5, nC5
	dc.b $14, nD5, nE5, nG5, nC6, $0F, nAb5, nBb5
	dc.b $0A, nG5, $0F, nAb5, nF5, $0A, nG5, $0F
	dc.b nEb5, nCs5, $0A, nEb5, $0F, nC5, nBb4, $0A
	dc.b nC5, $14, nD5, nE5, nF5, nD5, nE5, nF5
	dc.b nG5, nA5, $3C, nG5, $05, nA5, nB5, $0A
	dc.b nC6, $1E, nD6, $32
	sJump		Area_A_Loop3

Area_A_FM2:
	sPan		spCenter, $00
	dc.b nRst, $7F, $7F, $42
	sPatFM		$03
	dc.b $7F, $71, nC6, $01, nB5, $02, nBb5, $01
	dc.b nA5, nAb5, nG5, $02, nFs5, $01, nF5, nE5
	dc.b nEb5, $02, nD5, $01, nCs5, nC5, nB4, $02
	dc.b nBb4, $01, nA4, nAb4, nG4, $02, nFs4, $01
	dc.b nF4, nE4, nEb4, $02, nD4, $01, nCs4, nC4
	dc.b nB3, $02, nBb3, $01, nA3, nAb3, nG3, $02
	dc.b nFs3, $01, nF3, nE3, nEb3, $02, nD3, $01
	dc.b nCs3, nC3, nB2, $02, nBb2, $01, nA2, nAb2
	dc.b nG2, $02, nFs2, $01, nF2, nE2, nEb2, $02
	dc.b nD2, $01, nCs2, nC2, nRst, $13
	sPatFM		$04
	dc.b nF2, $05, $05
	sPan		spRight, $00
	saVolFM		$FC

Area_A_Loop6:
	dc.b nF3, nF3
	sPan		spLeft, $00
	dc.b nF2, nF2
	sPan		spRight, $00
	sLoop		$00, $02, Area_A_Loop6
	dc.b nF3, nF3
	sPan		spLeft, $00
	dc.b nG2, nG2
	sPan		spRight, $00
	dc.b nG3, nG3

Area_A_Loop7:
	sPan		spLeft, $00
	dc.b nA2, nA2
	sPan		spRight, $00
	dc.b nA3, nA3
	sLoop		$00, $03, Area_A_Loop7
	sPan		spLeft, $00
	dc.b nE2, nE2
	sPan		spRight, $00
	dc.b nE3, nE3

Area_A_Loop8:
	sPan		spLeft, $00
	dc.b nF2, nF2
	sPan		spRight, $00
	dc.b nF3, nF3
	sLoop		$00, $03, Area_A_Loop8
	sPan		spLeft, $00
	dc.b nG2, nG2
	sPan		spRight, $00
	dc.b nG3, nG3

Area_A_Loop9:
	sPan		spLeft, $00
	dc.b nB2, nB2
	sPan		spRight, $00
	dc.b nB3, nB3
	sLoop		$00, $02, Area_A_Loop9

Area_A_Loop10:
	sPan		spLeft, $00
	dc.b nC3, nC3
	sPan		spRight, $00
	dc.b nC4, nC4
	sLoop		$00, $02, Area_A_Loop10

Area_A_Loop11:
	sPan		spLeft, $00
	dc.b nF2, nF2
	sPan		spRight, $00
	dc.b nF3, nF3
	sLoop		$00, $03, Area_A_Loop11
	sPan		spLeft, $00
	dc.b nG2, nG2
	sPan		spRight, $00
	dc.b nG3, nG3

Area_A_Loop12:
	sPan		spLeft, $00
	dc.b nA2, nA2
	sPan		spRight, $00
	dc.b nA3, nA3
	sLoop		$00, $03, Area_A_Loop12
	sPan		spLeft, $00
	dc.b nE2, nE2
	sPan		spRight, $00
	dc.b nE3, nE3

Area_A_Loop13:
	sPan		spLeft, $00
	dc.b nF2, nF2
	sPan		spRight, $00
	dc.b nF3, nF3
	sLoop		$00, $03, Area_A_Loop13
	sPan		spLeft, $00
	dc.b nG2, nG2
	sPan		spRight, $00
	dc.b nG3, nG3

Area_A_Loop14:
	sPan		spLeft, $00
	dc.b nB2, nB2
	sPan		spRight, $00
	dc.b nB3, nB3
	sLoop		$00, $02, Area_A_Loop14

Area_A_Loop15:
	sPan		spLeft, $00
	dc.b nC3, nC3
	sPan		spRight, $00
	dc.b nC4, nC4
	sLoop		$00, $02, Area_A_Loop15

Area_A_Loop16:
	sPan		spLeft, $00
	dc.b nF2, nF2
	sPan		spRight, $00
	dc.b nF3, nF3
	sLoop		$00, $03, Area_A_Loop16
	sPan		spLeft, $00
	dc.b nG2, nG2
	sPan		spRight, $00
	dc.b nG3, nG3

Area_A_Loop17:
	sPan		spLeft, $00
	dc.b nA2, nA2
	sPan		spRight, $00
	dc.b nA3, nA3
	sLoop		$00, $03, Area_A_Loop17
	sPan		spLeft, $00
	dc.b nE2, nE2
	sPan		spRight, $00
	dc.b nE3, nE3

Area_A_Loop18:
	sPan		spLeft, $00
	dc.b nF2, nF2
	sPan		spRight, $00
	dc.b nF3, nF3
	sLoop		$00, $03, Area_A_Loop18
	sPan		spLeft, $00
	dc.b nG2, nG2
	sPan		spRight, $00
	dc.b nG3, nG3

Area_A_Loop19:
	sPan		spLeft, $00
	dc.b nB2, nB2
	sPan		spRight, $00
	dc.b nB3, nB3
	sLoop		$00, $02, Area_A_Loop19

Area_A_Loop20:
	sPan		spLeft, $00
	dc.b nC3, nC3
	sPan		spRight, $00
	dc.b nC4, nC4
	sLoop		$00, $02, Area_A_Loop20

Area_A_Loop21:
	sPan		spLeft, $00
	dc.b nF2, nF2
	sPan		spRight, $00
	dc.b nF3, nF3
	sLoop		$00, $03, Area_A_Loop21
	sPan		spLeft, $00
	dc.b nG2, nG2
	sPan		spRight, $00
	dc.b nG3, nG3

Area_A_Loop22:
	sPan		spLeft, $00
	dc.b nA2, nA2
	sPan		spRight, $00
	dc.b nA3, nA3
	sLoop		$00, $03, Area_A_Loop22
	sPan		spLeft, $00
	dc.b nE2, nE2
	sPan		spRight, $00
	dc.b nE3, nE3

Area_A_Loop23:
	sPan		spLeft, $00
	dc.b nF2, nF2
	sPan		spRight, $00
	dc.b nF3, nF3
	sLoop		$00, $03, Area_A_Loop23
	sPan		spLeft, $00
	dc.b nG2, nG2
	sPan		spRight, $00
	dc.b nG3, nG3

Area_A_Loop24:
	sPan		spLeft, $00
	dc.b nB2, nB2
	sPan		spRight, $00
	dc.b nB3, nB3
	sLoop		$00, $02, Area_A_Loop24

Area_A_Loop25:
	sPan		spLeft, $00
	dc.b nC3, nC3
	sPan		spRight, $00
	dc.b nC4, nC4
	sLoop		$00, $02, Area_A_Loop25

Area_A_Loop26:
	sPan		spLeft, $00
	dc.b nBb2, nBb2
	sPan		spRight, $00
	dc.b nBb3, nBb3
	sLoop		$00, $08, Area_A_Loop26

Area_A_Loop27:
	sPan		spLeft, $00
	dc.b nA2, nA2
	sPan		spRight, $00
	dc.b nA3, nA3
	sLoop		$00, $08, Area_A_Loop27

Area_A_Loop28:
	sPan		spLeft, $00
	dc.b nAb2, nAb2
	sPan		spRight, $00
	dc.b nAb3, nAb3
	sLoop		$00, $08, Area_A_Loop28

Area_A_Loop29:
	sPan		spLeft, $00
	dc.b nG2, nG2
	sPan		spRight, $00
	dc.b nG3, nG3
	sLoop		$00, $10, Area_A_Loop29
	saVolFM		$04
	sJump		Area_A_FM2

Area_A_FM3:
	sPatFM		$02
	sPan		spCenter, $00
	ssMod68k	$10, $01, $05, $04

Area_A_Loop30:
	dc.b nA3, $3C, nB3, $14, nA3, $28, nG3, nA3
	dc.b $3C, nB3, $14, nE4, $28, $28
	sLoop		$00, $06, Area_A_Loop30
	dc.b nA3, $50, nG3, $28, nF3, nE3, $50, nA3
	dc.b $28, nE3, nEb3, $50, nG3, nC4, nB3, nC4
	dc.b nB3
	sJump		Area_A_Loop30

Area_A_FM4:
	sPatFM		$02
	sPan		spLeft, $00
	ssMod68k	$10, $01, $05, $04

Area_A_Loop31:
	dc.b nC4, $3C, nD4, $14, nC4, $28, nB3, nC4
	dc.b $3C, nD4, $14, nG4, $28, $28
	sLoop		$00, $06, Area_A_Loop31
	dc.b nBb3, $7F, sHold, $21, nG3, $7F, sHold, $21
	dc.b nAb4, $7F, sHold, $21, nF4, $50, nD4, nF4
	dc.b nD4
	sJump		Area_A_Loop31

Area_A_FM5:
	ssMod68k	$10, $01, $05, $04

Area_A_Loop32:
	sPatFM		$02
	sPan		spRight, $00
	dc.b nF4, $3C, nG4, $14, nE4, $50, nF4, $3C
	dc.b nG4, $14, nB4, $28, nC5
	sLoop		$00, $05, Area_A_Loop32
	dc.b nF4, $3C, nG4, $14, nE4, $50, nF4, $3C
	dc.b nG4, $14, nB4, $28, nC5, $1C, nRst, $02
	sPatFM		$06
	ssDetune	$FA
	saVolFM		$04
	dc.b nB4, $05, nC5, nD5, nE5, nF5, $1E, nBb4
	dc.b $14, nF5, $1E, nA5, nF5, $14, nG5, nFs5
	dc.b $05, nF5, nE5, $46, nEb5, $05, nD5, nC5
	dc.b $14, nD5, nE5
	ssDetune	$00
	sPan		spCenter, $00
	dc.b nRst, $0A
	saVolFM		$FC
	dc.b nAb5, $0F, nEb5, nF5, $0A, nEb5, $0F, nF5
	dc.b nCs5, $0A, nEb5, $0F, nC5, nBb4, $0A, nC5
	dc.b $0F, nAb4, nG4, $0A, nA4, $14, nB4, nC5
	dc.b nD5, nB4, nC5, nD5, nE5, nF5, $3C, nE5
	dc.b $05, nF5, nG5, $0A, nA5, $1E, nB5, $32
	sJump		Area_A_Loop32

Area_A_PSG1:
	ssMod68k	$11, $01, $02, $02
	dc.b nC2

Area_A_Loop33:
	dc.b $05, nRst, nC2, nF2, nRst, nC2
	sLoop		$00, $02, Area_A_Loop33
	dc.b nB1, nRst, nD2, nD2, nE2, nRst, nE2, nC2
	dc.b nRst, nE2, nB1, nRst, nE2, nD2, nRst, nE2
	dc.b nC2, nE2, nB1, nRst

Area_A_Loop34:
	dc.b nC2, nRst, nC2, nF2, nRst, nC2
	sLoop		$00, $02, Area_A_Loop34
	dc.b nB1, nRst, nD2, nD2, nE2, nRst, nE2, nC2
	dc.b nRst, nE2, nB1, nRst, nE2, nD2, nRst, nE2
	dc.b nB1, nC2, nE2, nRst
	sLoop		$01, $04, Area_A_PSG1
	dc.b nF2, $14
	ssDetune	$00
	dc.b sHold, $02
	ssDetune	$01
	dc.b sHold, $07
	ssDetune	$02
	dc.b sHold, $01
	ssDetune	$00
	dc.b nE2, $0B
	ssDetune	$01
	dc.b sHold, $01
	ssDetune	$02
	dc.b sHold, $02
	ssDetune	$03
	dc.b sHold, $01
	ssDetune	$04
	dc.b sHold, $01
	ssDetune	$FB
	dc.b sHold, nEb2
	ssDetune	$FC
	dc.b sHold, $01
	ssDetune	$FD
	dc.b sHold, $01
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$00
	dc.b nB1, $19
	ssDetune	$FF
	dc.b sHold, $04
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$00
	dc.b nC2, $14
	ssDetune	$FF
	dc.b sHold, $03
	ssDetune	$FE
	dc.b sHold, $03
	ssDetune	$FD
	dc.b sHold, $02
	ssDetune	$FC
	dc.b sHold, $02
	ssDetune	$00
	dc.b nD2, $1E, nA1, $05, nB1, nC2, nG2, nF2
	dc.b $16
	ssDetune	$01
	dc.b sHold, $07
	ssDetune	$02
	dc.b sHold, $01
	ssDetune	$00
	dc.b nE2, $0F
	ssDetune	$FF
	dc.b sHold, $02
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$FD
	dc.b sHold, $01
	ssDetune	$FC
	dc.b sHold, $01
	ssDetune	$00
	dc.b nG2, $0A, nB2, $14, $0E
	ssDetune	$FF
	dc.b sHold, $01
	ssDetune	$00
	dc.b nC3, $0B
	ssDetune	$01
	dc.b sHold, $02
	ssDetune	$02
	dc.b sHold, $02
	ssDetune	$00
	dc.b nA2, $1E, nA1, $05, nB1, nC2, nG2, nF2
	dc.b $16
	ssDetune	$01
	dc.b sHold, $07
	ssDetune	$02
	dc.b sHold, $01
	ssDetune	$00
	dc.b nE2, $0B
	ssDetune	$01
	dc.b sHold, $01
	ssDetune	$02
	dc.b sHold, $02
	ssDetune	$03
	dc.b sHold, $01
	ssDetune	$04
	dc.b sHold, $01
	ssDetune	$FB
	dc.b sHold, nEb2
	ssDetune	$FC
	dc.b sHold, $01
	ssDetune	$FD
	dc.b sHold, $01
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$00
	dc.b nB1, $19
	ssDetune	$FF
	dc.b sHold, $04
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$00
	dc.b nC2, $14
	ssDetune	$FF
	dc.b sHold, $03
	ssDetune	$FE
	dc.b sHold, $03
	ssDetune	$FD
	dc.b sHold, $02
	ssDetune	$FC
	dc.b sHold, $02
	ssDetune	$00
	dc.b nD2, $1E, nA1, $05, nB1, nC2, nG2, $03
	ssDetune	$01
	dc.b sHold, $01
	ssDetune	$02
	dc.b sHold, $01
	ssDetune	$00
	dc.b nF2, $08
	ssDetune	$01
	dc.b sHold, $02
	ssDetune	$00
	dc.b nE2, $03
	ssDetune	$FF
	dc.b sHold, $01
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$00
	dc.b nF2, $03
	ssDetune	$FF
	dc.b sHold, $01
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$00
	dc.b nG2, $08
	ssDetune	$01
	dc.b sHold, $01
	ssDetune	$02
	dc.b sHold, $01
	ssDetune	$00
	dc.b nF2, $03
	ssDetune	$FF
	dc.b sHold, $01
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$00
	dc.b nG2, $03
	ssDetune	$FF
	dc.b sHold, $01
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$00
	dc.b nA2, $08
	ssDetune	$01
	dc.b sHold, $01
	ssDetune	$02
	dc.b sHold, $01
	ssDetune	$00
	dc.b nG2, $03
	ssDetune	$FF
	dc.b sHold, $01
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$00
	dc.b nA2, $03
	ssDetune	$FF
	dc.b sHold, $01
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$00
	dc.b nB2, $08
	ssDetune	$01
	dc.b sHold, $01
	ssDetune	$02
	dc.b sHold, $01
	ssDetune	$00
	dc.b nA2, $03
	ssDetune	$FF
	dc.b sHold, $01
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$00
	dc.b nB2, $04
	ssDetune	$FF
	dc.b sHold, $01
	ssDetune	$00
	dc.b nC3, $50, $05

Area_A_Loop35:
	dc.b nRst, nF2, nBb2, nRst, nF2, nC3, nRst, nF2
	dc.b nA2, nRst, nF2, nBb2, nRst, $0F, nC3, $05
	sLoop		$00, $02, Area_A_Loop35
	dc.b nRst, nE2, nA2, nRst, nE2, nC3, nRst, nE2
	dc.b nG2, nRst, nE2, nA2, nRst, $0F, nC3, $05
	dc.b nRst, nE2, nA2, nRst, nE2, nC3, nRst, nE2
	dc.b nG2, nRst, nE2, nA2, nRst, $0F

Area_A_Loop36:
	dc.b nEb3, $05, nRst, nAb2, nC3, nRst, nAb2
	sLoop		$00, $02, Area_A_Loop36
	dc.b nEb3, nRst, nAb2, nRst
	sLoop		$01, $02, Area_A_Loop36

Area_A_Loop37:
	dc.b nC3, nRst, nF2, nA2, nRst, nF2
	sLoop		$00, $02, Area_A_Loop37
	dc.b nC3, nRst, nF2, nRst

Area_A_Loop38:
	dc.b nD3, nRst, nG2, nB2, nRst, nG2
	sLoop		$00, $02, Area_A_Loop38
	dc.b nD3, nRst, nG2, nRst
	sLoop		$01, $02, Area_A_Loop37
	sJump		Area_A_PSG1

Area_A_PSG2:
	ssMod68k	$10, $01, $02, $02
	dc.b nRst, $08
	ssDetune	$01

Area_A_Loop41:
	dc.b nC2

Area_A_Loop39:
	dc.b $05, nRst, nC2, nF2, nRst, nC2
	sLoop		$00, $02, Area_A_Loop39
	dc.b nB1, nRst, nD2, nD2, nE2, nRst, nE2, nC2
	dc.b nRst, nE2, nB1, nRst, nE2, nD2, nRst, nE2
	dc.b nC2, nE2, nB1, nRst

Area_A_Loop40:
	dc.b nC2, nRst, nC2, nF2, nRst, nC2
	sLoop		$00, $02, Area_A_Loop40
	dc.b nB1, nRst, nD2, nD2, nE2, nRst, nE2, nC2
	dc.b nRst, nE2, nB1, nRst, nE2, nD2, nRst, nE2
	dc.b nB1, nC2, nE2, nRst
	sLoop		$01, $04, Area_A_Loop41
	dc.b nF2, $16
	ssDetune	$01
	dc.b sHold, $06
	ssDetune	$02
	dc.b sHold, $02
	ssDetune	$00
	dc.b nE2, $0B
	ssDetune	$01
	dc.b sHold, $01
	ssDetune	$02
	dc.b sHold, $01
	ssDetune	$03
	dc.b sHold, $01
	ssDetune	$04
	dc.b sHold, $01
	ssDetune	$05
	dc.b sHold, $01
	ssDetune	$FC
	dc.b sHold, nEb2, sHold, $01
	ssDetune	$FD
	dc.b sHold, $01
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$00
	dc.b nB1, $19
	ssDetune	$FF
	dc.b sHold, $04
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$00
	dc.b nC2, $14
	ssDetune	$FF
	dc.b sHold, $03
	ssDetune	$FE
	dc.b sHold, $02
	ssDetune	$FD
	dc.b sHold, $03
	ssDetune	$FC
	dc.b sHold, $02
	ssDetune	$00
	dc.b nD2, $1D, nRst, $01, nA1, $04, nRst, $01
	dc.b nB1, $04, nRst, $01, nC2, $04, nRst, $01
	dc.b nG2, $04, nRst, $01, nF2, $16
	ssDetune	$01
	dc.b sHold, $06
	ssDetune	$02
	dc.b sHold, $02
	ssDetune	$00
	dc.b nE2, $0F
	ssDetune	$FF
	dc.b sHold, $01
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$FD
	dc.b sHold, $01
	ssDetune	$FC
	dc.b sHold, $02
	ssDetune	$00
	dc.b nG2, $09, nRst, $01, nB2, $13, nRst, $01
	dc.b nB2, $0D
	ssDetune	$FF
	dc.b sHold, $02
	ssDetune	$00
	dc.b nC3, $0A
	ssDetune	$01
	dc.b sHold, $02
	ssDetune	$02
	dc.b sHold, $03
	ssDetune	$00
	dc.b nA2, $1D, nRst, $01, nA1, $04, nRst, $01
	dc.b nB1, $04, nRst, $01, nC2, $04, nRst, $01
	dc.b nG2, $04, nRst, $01, nF2, $16
	ssDetune	$01
	dc.b sHold, $06
	ssDetune	$02
	dc.b sHold, $01, nRst
	ssDetune	$00
	dc.b nE2, $0B
	ssDetune	$01
	dc.b sHold, $01
	ssDetune	$02
	dc.b sHold, $01
	ssDetune	$03
	dc.b sHold, $01
	ssDetune	$04
	dc.b sHold, $01
	ssDetune	$05
	dc.b sHold, $01
	ssDetune	$FC
	dc.b sHold, nEb2, sHold, $01
	ssDetune	$FD
	dc.b sHold, $01
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$00
	dc.b nB1, $19
	ssDetune	$FF
	dc.b sHold, $04
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$00
	dc.b nC2, $14
	ssDetune	$FF
	dc.b sHold, $03
	ssDetune	$FE
	dc.b sHold, $02
	ssDetune	$FD
	dc.b sHold, $03
	ssDetune	$FC
	dc.b sHold, $02
	ssDetune	$00
	dc.b nD2, $1D, nRst, $01, nA1, $04, nRst, $01
	dc.b nB1, $04, nRst, $01, nC2, $04, nRst, $01
	dc.b nG2, $03
	ssDetune	$01
	dc.b sHold, $01
	ssDetune	$02
	dc.b sHold, $01
	ssDetune	$00
	dc.b nF2, $08
	ssDetune	$01
	dc.b sHold, $01
	ssDetune	$02
	dc.b sHold, $01
	ssDetune	$00
	dc.b nE2, $02
	ssDetune	$FF
	dc.b sHold, $02
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$00
	dc.b nF2, $03
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$FD
	dc.b sHold, $01
	ssDetune	$00
	dc.b nG2, $08
	ssDetune	$01
	dc.b sHold, $01
	ssDetune	$02
	dc.b sHold, $01
	ssDetune	$00
	dc.b nF2, $03
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$FD
	dc.b sHold, $01
	ssDetune	$00
	dc.b nG2, $02
	ssDetune	$FF
	dc.b sHold, $01
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$FD
	dc.b sHold, $01
	ssDetune	$00
	dc.b nA2, $07
	ssDetune	$01
	dc.b sHold, $01
	ssDetune	$02
	dc.b sHold, $02
	ssDetune	$00
	dc.b nG2, $02
	ssDetune	$FF
	dc.b sHold, $01
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$FD
	dc.b sHold, $01
	ssDetune	$00
	dc.b nA2, $03
	ssDetune	$FF
	dc.b sHold, $01
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$00
	dc.b nB2, $07
	ssDetune	$01
	dc.b sHold, $01
	ssDetune	$02
	dc.b sHold, $02
	ssDetune	$00
	dc.b nA2, $03
	ssDetune	$FF
	dc.b sHold, $01
	ssDetune	$FE
	dc.b sHold, $01
	ssDetune	$00
	dc.b nB2, $04
	ssDetune	$FF
	dc.b sHold, $01
	ssDetune	$00
	dc.b nC3, $4F, nRst, $01

Area_A_Loop42:
	dc.b nC3, $05, nRst, nF2, nBb2, nRst, nF2, nC3
	dc.b nRst, nF2, nA2, nRst, nF2, nBb2, nRst, $0F
	sLoop		$00, $02, Area_A_Loop42

Area_A_Loop43:
	dc.b nC3, $05, nRst, nE2, nA2, nRst, nE2, nC3
	dc.b nRst, nE2, nG2, nRst, nE2, nA2, nRst, $0F
	sLoop		$00, $02, Area_A_Loop43

Area_A_Loop44:
	dc.b nEb3, $05, nRst, nAb2, nC3, nRst, nAb2
	sLoop		$00, $02, Area_A_Loop44
	dc.b nEb3, nRst, nAb2, nRst
	sLoop		$01, $02, Area_A_Loop44

Area_A_Loop45:
	dc.b nC3, nRst, nF2, nA2, nRst, nF2
	sLoop		$00, $02, Area_A_Loop45
	dc.b nC3, nRst, nF2, nRst

Area_A_Loop46:
	dc.b nD3, nRst, nG2, nB2, nRst, nG2
	sLoop		$00, $02, Area_A_Loop46
	dc.b nD3, nRst, nG2, nRst

Area_A_Loop47:
	dc.b nC3, nRst, nF2, nA2, nRst, nF2
	sLoop		$00, $02, Area_A_Loop47
	dc.b nC3, nRst, nF2, nRst

Area_A_Loop48:
	dc.b nD3, nRst, nG2, nB2, nRst, nG2
	sLoop		$00, $02, Area_A_Loop48
	dc.b nD3, nRst, nG2, $02
	sJump		Area_A_PSG2

Area_A_PSG3:
	sNoisePSG	$E7

Area_A_Jump2:
	dc.b nA5

Area_A_Loop49:
	dc.b $05
	saVolPSG	$06
	dc.b $05
	saVolPSG	$FD
	dc.b $05
	saVolPSG	$03
	dc.b $05
	saVolPSG	$FC
	dc.b $05
	saVolPSG	$04
	dc.b $05
	saVolPSG	$FD
	dc.b $05
	saVolPSG	$03
	dc.b $05
	saVolPSG	$FA
	sLoop		$00, $10, Area_A_Loop49

Area_A_Loop50:
	dc.b $05, $05
	sVolEnvPSG	$01
	dc.b $0A
	sVolEnvPSG	$02
	sLoop		$00, $1B, Area_A_Loop50
	dc.b $05, $05
	sVolEnvPSG	$01
	dc.b $5A

Area_A_Loop51:
	sVolEnvPSG	$02
	dc.b $05, $05
	sVolEnvPSG	$01
	dc.b $0A
	sLoop		$00, $48, Area_A_Loop51
	sVolEnvPSG	$02
	sJump		Area_A_Jump2
