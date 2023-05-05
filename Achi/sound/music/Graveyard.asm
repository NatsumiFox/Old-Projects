Graveyard_Header:
	sHeaderInit
	sHeaderTempo	$82, $40
	sHeaderCh	$05, $03
	sHeaderDAC	Graveyard_DAC1
	sHeaderDAC	Graveyard_DAC2
	sHeaderFM	Graveyard_FM1, $F4, $12
	sHeaderFM	Graveyard_FM2, $F4, $15
	sHeaderFM	Graveyard_FM3, $F4, $0A
	sHeaderFM	Graveyard_FM4, $F4, $15
	sHeaderFM	Graveyard_FM5, $F4, $18
	sHeaderPSG	Graveyard_PSG1, $D0, $02, $00, VolEnv_00
	sHeaderPSG	Graveyard_PSG2, $D0, $05, $00, VolEnv_00
	sHeaderPSG	Graveyard_PSG3, $00, $01, $00, VolEnv_00

	; Patch $00
	; $3D
	; $01, $62, $03, $21,	$30, $1F, $13, $26
	; $08, $08, $08, $03,	$05, $00, $03, $00
	; $1F, $1B, $1B, $1B,	$1C, $82, $82, $82
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $06, $02
	spMultiple	$01, $03, $02, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$10, $13, $1F, $06
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$08, $08, $08, $03
	spSustainRt	$05, $03, $00, $00
	spSustainLv	$01, $01, $01, $01
	spReleaseRt	$0F, $0B, $0B, $0B
	spTotalLv	$1C, $02, $02, $02

	; Patch $01
	; $35
	; $01, $31, $70, $00,	$1F, $1F, $1F, $1F
	; $09, $0B, $0B, $0B,	$12, $12, $12, $12
	; $80, $9F, $9F, $9F,	$17, $8E, $8E, $8E
	spAlgorithm	$05
	spFeedback	$06
	spDetune	$00, $07, $03, $00
	spMultiple	$01, $00, $01, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$09, $0B, $0B, $0B
	spSustainRt	$12, $12, $12, $12
	spSustainLv	$08, $09, $09, $09
	spReleaseRt	$00, $0F, $0F, $0F
	spTotalLv	$17, $0E, $0E, $0E

	; Patch $02
	; $3D
	; $01, $62, $03, $21,	$30, $1F, $13, $26
	; $08, $0B, $0B, $0B,	$05, $0D, $0D, $0D
	; $0F, $1B, $1B, $1B,	$1A, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $06, $02
	spMultiple	$01, $03, $02, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$10, $13, $1F, $06
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$08, $0B, $0B, $0B
	spSustainRt	$05, $0D, $0D, $0D
	spSustainLv	$00, $01, $01, $01
	spReleaseRt	$0F, $0B, $0B, $0B
	spTotalLv	$1A, $00, $00, $00

	; Patch $03
	; $38
	; $04, $12, $30, $71,	$1F, $1F, $1F, $1F
	; $0B, $0B, $0A, $0A,	$00, $00, $00, $00
	; $4F, $4F, $AF, $AB,	$14, $1B, $18, $80
	spAlgorithm	$00
	spFeedback	$07
	spDetune	$00, $03, $01, $07
	spMultiple	$04, $00, $02, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0B, $0A, $0B, $0A
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$04, $0A, $04, $0A
	spReleaseRt	$0F, $0F, $0F, $0B
	spTotalLv	$14, $18, $1B, $00

	; Patch $04
	; $3C
	; $01, $62, $01, $22,	$17, $1F, $1F, $1F
	; $07, $08, $07, $08,	$05, $00, $03, $00
	; $0F, $1B, $1B, $1B,	$11, $80, $09, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$00, $00, $06, $02
	spMultiple	$01, $01, $02, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$17, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$07, $07, $08, $08
	spSustainRt	$05, $03, $00, $00
	spSustainLv	$00, $01, $01, $01
	spReleaseRt	$0F, $0B, $0B, $0B
	spTotalLv	$11, $09, $00, $00

	; Patch $05
	; $0C
	; $02, $01, $38, $71,	$1F, $1D, $1F, $1D
	; $13, $0D, $11, $07,	$10, $15, $00, $15
	; $47, $57, $A7, $87,	$19, $81, $1B, $82
	spAlgorithm	$04
	spFeedback	$01
	spDetune	$00, $03, $00, $07
	spMultiple	$02, $08, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1D, $1D
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$13, $11, $0D, $07
	spSustainRt	$10, $00, $15, $15
	spSustainLv	$04, $0A, $05, $08
	spReleaseRt	$07, $07, $07, $07
	spTotalLv	$19, $1B, $01, $02

	; Patch $06
	; $2C
	; $01, $01, $20, $00,	$1D, $1D, $1D, $1D
	; $06, $02, $06, $02,	$10, $03, $00, $03
	; $4F, $5F, $AF, $8F,	$16, $84, $10, $84
	spAlgorithm	$04
	spFeedback	$05
	spDetune	$00, $02, $00, $00
	spMultiple	$01, $00, $01, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1D, $1D, $1D, $1D
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$06, $06, $02, $02
	spSustainRt	$10, $00, $03, $03
	spSustainLv	$04, $0A, $05, $08
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$16, $10, $04, $04

	; Patch $07
	; $34
	; $02, $01, $02, $41,	$1B, $1B, $1B, $1B
	; $08, $09, $15, $04,	$0B, $19, $18, $1D
	; $2F, $4F, $4F, $4F,	$10, $87, $2B, $87
	spAlgorithm	$04
	spFeedback	$06
	spDetune	$00, $00, $00, $04
	spMultiple	$02, $02, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1B, $1B, $1B, $1B
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$08, $15, $09, $04
	spSustainRt	$0B, $18, $19, $1D
	spSustainLv	$02, $04, $04, $04
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$10, $2B, $07, $07

	; Patch $08
	; $0C
	; $0A, $01, $38, $72,	$1F, $1D, $1F, $1D
	; $0C, $07, $08, $07,	$10, $13, $00, $13
	; $47, $57, $A7, $87,	$1F, $81, $22, $82
	spAlgorithm	$04
	spFeedback	$01
	spDetune	$00, $03, $00, $07
	spMultiple	$0A, $08, $01, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1D, $1D
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0C, $08, $07, $07
	spSustainRt	$10, $00, $13, $13
	spSustainLv	$04, $0A, $05, $08
	spReleaseRt	$07, $07, $07, $07
	spTotalLv	$1F, $22, $01, $02

	; Patch $09
	; $24
	; $01, $01, $02, $41,	$1E, $1E, $1E, $1E
	; $0B, $08, $18, $09,	$0B, $19, $18, $1D
	; $2F, $4F, $4F, $4F,	$04, $80, $10, $80
	spAlgorithm	$04
	spFeedback	$04
	spDetune	$00, $00, $00, $04
	spMultiple	$01, $02, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1E, $1E, $1E, $1E
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0B, $18, $08, $09
	spSustainRt	$0B, $18, $19, $1D
	spSustainLv	$02, $04, $04, $04
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$04, $10, $00, $00

Graveyard_FM1:
	ssMod68k	$08, $03, $08, $03
	sPan		spCenter, $00

Graveyard_Jump4:
	sVoice		$07
	dc.b nRst, $06, nA5, $03, nG5, nA5, $06, nC6
	dc.b nD6, $0C, nEb6, $0C, nE6, $06, nE6, $03
	dc.b $03, nD6, $06, nC6, nA5, $0C, nG5, $06
	dc.b nA5, nC6, $24, nG5, $0C, nA5, $30, nRst
	dc.b $06, nA5, $03, nG5, nA5, $06, nC6, nD6
	dc.b $0C, nEb6, nE6, $06, $03, $03, nD6, $06
	dc.b nC6, nA5, $0C, nG5, $06, nC6, nA5, $30
	dc.b nRst, nRst, $06, nD6, $03, nC6, nD6, $06
	dc.b nF6, nG6, $0C, nAb6, nA6, $06, $03, $03
	dc.b nG6, $06, nF6, nD6, $0C, nF6, $06, nC6
	dc.b nD6, $30, nRst, nRst, $06, nA5, $03, nG5
	dc.b nA5, $06, nC6, nD6, $0C, nEb6, nE6, $06
	dc.b $03, $03, nD6, $06, nC6, nA5, $0C, nG5
	dc.b $06, nC6, nA5, $30, nRst
	sVoice		$09
	saVol		$08
	dc.b nA5, $06, nA6, $03, $03, $06, nAb6, nG6
	dc.b nG6, nFs6, nFs6, nF6, nF6, nF6, nF6, nE6
	dc.b $18, nA5, $06, nA6, $03, $03, $06, $06
	dc.b nC7, nC7, nA6, nC7, nD7, nD7, nEb7, nEb7
	dc.b nE7, $18
	saVol		$F8
	sJump		Graveyard_Jump4

Graveyard_FM2:
Graveyard_Jump7:
	sVoice		$05
	sPan		spRight, $00
	dc.b nE5, $06, nE5, nRst, nD5, nE5, nRst, nG5
	dc.b nG5, nE5, nE5, nRst, nD5, nE5, nRst, nEb6
	dc.b nEb6, nE5, nE5, nRst, nD5, nE5, nRst, nG5
	dc.b nG5, nE5, nE5, nRst, nD5, nE5, nRst, nEb6
	dc.b nEb6, nE5, nE5, nRst, nD5, nE5, nRst, nG5
	dc.b nG5, nE5, nE5, nRst, nD5, nE5, nRst, nEb6
	dc.b nEb6, nE5, nE5, nRst, nD5, nE5, nRst, nG5
	dc.b nG5, nE5, nE5, nRst, nD5, nE5, nRst, nEb6
	dc.b nEb6, nA5, nA5, nRst, nG5, nA5, nRst, nC6
	dc.b nC6, nA5, nA5, nRst, nG5, nA5, nRst, nAb6
	dc.b nAb6, nA5, nA5, nRst, nG5, nA5, nRst, nC6
	dc.b nC6, nA5, nA5, nRst, nG5, nA5, nRst, nAb6
	dc.b nAb6, nE5, nE5, nRst, nD5, nE5, nRst, nG5
	dc.b nG5, nE5, nE5, nRst, nD5, nE5, nRst, nEb6
	dc.b nEb6, nE5, nE5, nRst, nD5, nE5, nRst, nG5
	dc.b nG5, nE5, nE5, nRst, nD5, nE5, nRst, nEb6
	dc.b nEb6
	saTranspose	$F4
	dc.b nA5, $06, nA6, $03, $03, $06, nAb6, nG6
	dc.b nG6, nFs6, nFs6, nF6, nF6, nF6, nF6, nE6
	dc.b $18, nA5, $06, nA6, $03, $03, $06, $06
	dc.b nC7, nC7, nA6, nC7, nD7, nD7, nEb7, nEb7
	dc.b nE7, $18
	saTranspose	$0C
	sJump		Graveyard_Jump7

Graveyard_FM3:
Graveyard_Jump6:
	sVoice		$01
	dc.b nA3, $12, $06, $0C, nE3, $06, nG3, nA3
	dc.b $12, $06, $0C, nC4, $06, nD4, nA3, $12
	dc.b $06, $0C, nE3, $06, nG3, nA3, $12, $06
	dc.b $0C, nC4, $06, nD4, nA3, $12, $06, $0C
	dc.b nE3, $06, nG3, nA3, $12, $06, $0C, nC4
	dc.b $06, nD4, nA3, $12, $06, $0C, nE3, $06
	dc.b nG3, nA3, $12, $06, $0C, nC4, $06, nD4
	dc.b nD4, $12, $06, $0C, nA3, $06, nC4, nD4
	dc.b $12, $06, $0C, nF4, $06, nG4, nD4, $12
	dc.b $06, $0C, nA3, $06, nC4, nD4, $12, $06
	dc.b $0C, nF4, $06, nG4, nA3, $12, $06, $0C
	dc.b nE3, $06, nG3, nA3, $12, $06, $0C, nC4
	dc.b $06, nD4, nA3, $12, $06, $0C, nE3, $06
	dc.b nG3, nA3, $12, $06, $0C, nC4, $06, nD4
	dc.b nA3, $06, nRst, $2A, nRst, $18, nE4, $06
	dc.b nD4, nC4, nB3, nA3, $06, nRst, $2A, nRst
	dc.b $18, nE4, $06, nD4, nC4, nB3
	sJump		Graveyard_Jump6

Graveyard_FM4:
Graveyard_Jump5:
	sVoice		$05
	sPan		spLeft, $00
	dc.b nA5, $06, nA5, nRst, nG5, nA5, nRst, nC6
	dc.b nC6, nA5, nA5, nRst, nG5, nA5, nRst, nE6
	dc.b nE6, nA5, nA5, nRst, nG5, nA5, nRst, nC6
	dc.b nC6, nA5, nA5, nRst, nG5, nA5, nRst, nE6
	dc.b nE6, nA5, nA5, nRst, nG5, nA5, nRst, nC6
	dc.b nC6, nA5, nA5, nRst, nG5, nA5, nRst, nE6
	dc.b nE6, nA5, nA5, nRst, nG5, nA5, nRst, nC6
	dc.b nC6, nA5, nA5, nRst, nG5, nA5, nRst, nE6
	dc.b nE6, nD6, nD6, nRst, nC6, nD6, nRst, nF6
	dc.b nF6, nD6, nD6, nRst, nC6, nD6, nRst, nA6
	dc.b nA6, nD6, nD6, nRst, nC6, nD6, nRst, nF6
	dc.b nF6, nD6, nD6, nRst, nC6, nD6, nRst, nA6
	dc.b nA6, nA5, nA5, nRst, nG5, nA5, nRst, nC6
	dc.b nC6, nA5, nA5, nRst, nG5, nA5, nRst, nE6
	dc.b nE6, nA5, nA5, nRst, nG5, nA5, nRst, nC6
	dc.b nC6, nA5, nA5, nRst, nG5, nA5, nRst, nE6
	dc.b nE6
	saTranspose	$F4
	saTranspose	$FB
	dc.b nA5, $06, nA6, $03, $03, $06, nAb6, nG6
	dc.b nG6, nFs6, nFs6, nF6, nF6, nF6, nF6, nE6
	dc.b $18, nA5, $06, nA6, $03, $03, $06, $06
	dc.b nC7, nC7, nA6, nC7, nD7, nD7, nEb7, nEb7
	dc.b nE7, $18
	saTranspose	$05
	saTranspose	$0C
	sJump		Graveyard_Jump5

Graveyard_FM5:
	sVoice		$07
	saDetune	$0A
	dc.b nRst, $06
	sPan		spRight, $00
	sJump		Graveyard_Jump4

Graveyard_PSG1:
Graveyard_Jump3:
	ssMod68k	$01, $02, $08, $02
	dc.b nRst, $30, nRst, $30
	sCall		Graveyard_Call1
	sCall		Graveyard_Call1
	dc.b nRst, $30, nRst, $30
	sCall		Graveyard_Call1
	sCall		Graveyard_Call1
	dc.b nRst, $30, nRst, $30
	sCall		Graveyard_Call1
	sCall		Graveyard_Call1
	dc.b nRst, $30, nRst, $30
	sCall		Graveyard_Call1
	sCall		Graveyard_Call1
	dc.b nRst, $30, nRst, $30, nRst, $30, nRst, $30
	sJump		Graveyard_Jump3

Graveyard_Call1:
	dc.b nC6, $06, sHold
	saVol		$01
	dc.b nD6, $06, sHold
	saVol		$01
	dc.b nE6, $06, sHold
	saVol		$01
	dc.b nFs6, $06, sHold
	saVol		$01
	dc.b nA6, $09, sHold
	saVol		$01
	dc.b nRst, $03
	saVol		$FB
	dc.b nRst, $0C
	sRet

Graveyard_PSG2:
	dc.b nRst, $03
Graveyard_Jump2:
	ssMod68k	$01, $02, $08, $02
	saDetune	$04
	dc.b nRst, $30, nRst, $30
	sCall		Graveyard_Call1
	sCall		Graveyard_Call1
	dc.b nRst, $30, nRst, $30
	sCall		Graveyard_Call1
	sCall		Graveyard_Call1
	dc.b nRst, $30, nRst, $30
	sCall		Graveyard_Call1
	sCall		Graveyard_Call1
	dc.b nRst, $30, nRst, $30
	sCall		Graveyard_Call1
	sCall		Graveyard_Call1
	dc.b nRst, $30, nRst, $30, nRst, $30, nRst, $30
	sJump		Graveyard_Jump2

Graveyard_PSG3:
	sNoisePSG	$E7

Graveyard_Loop1:
Graveyard_Jump1:
	sVoice		VolEnv_0A
	dc.b nA5, $06, nA5, nA5, nA5, nA5, nA5, nA5
	dc.b $06
	sVoice		VolEnv_0B
	dc.b nA5, $06
	sLoop		$00, $10, Graveyard_Loop1
	sVoice		VolEnv_0A
	dc.b nA5, $0C, nRst, $24, nRst, $18, nA5, $03
	dc.b $03
	sVoice		VolEnv_0B
	dc.b nA5, $06
	sVoice		VolEnv_0A
	dc.b nA5, $06
	sVoice		VolEnv_0B
	dc.b nA5, $06, nA5, $0C, nRst, $24, nRst, $12
	sVoice		VolEnv_0A
	dc.b nA5, $06, $03, $03
	sVoice		VolEnv_0B
	dc.b nA5, $06
	sVoice		VolEnv_0A
	dc.b nA5, $06
	sVoice		VolEnv_0B
	dc.b nA5, $06
	sJump		Graveyard_Jump1

Graveyard_DAC1:
Graveyard_Jump8:
	dc.b dKick, $12, $06, $0C, dTom, dKick, $12, $06
	dc.b $0C, dLowKick, dKick, $12, $06, $06, dSnare, dTom
	dc.b dLowKick, dKick, $12, $06, $06, dSnare, dTom, $03
	dc.b $03, dLowKick, $06, dKick, $12, $06, $0C, dTom
	dc.b dKick, $12, $06, $0C, dLowKick, dKick, $12, $06
	dc.b $06, dSnare, dTom, dLowKick, dKick, $12, $06, $06
	dc.b dSnare, dTom, $03, $03, dLowKick, $06, dKick, $12
	dc.b $06, $0C, dTom, dKick, $12, $06, $0C, dLowKick
	dc.b dKick, $12, $06, $06, dSnare, dTom, dLowKick, dKick
	dc.b $12, $06, $06, dSnare, dTom, $03, $03, dLowKick
	dc.b $06, dKick, $12, $06, $0C, dTom, dKick, $12
	dc.b $06, $0C, dLowKick, dKick, $12, $06, $06, dSnare
	dc.b dTom, dLowKick, dKick, $12, $06, $06, dSnare, dTom
	dc.b $03, $03, dLowKick, $06, dKick, $30, $12, $06
	dc.b $06, dSnare, dTom, dLowKick, dKick, $30, $12, $06
	dc.b dSnare, dTom, dTom, $03, $03, dLowKick, $06
	sJump		Graveyard_Jump8

Graveyard_DAC2:
	sStop
