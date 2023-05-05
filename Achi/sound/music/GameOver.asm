GameOver_Header:
	sHeaderInit
	sHeaderTempo	$02, $04
	sHeaderCh	$05, $03
	sHeaderDAC	GameOver_DAC1
	sHeaderDAC	GameOver_DAC2
	sHeaderFM	GameOver_FM1, $02, $03
	sHeaderFM	GameOver_FM2, $02, $10
	sHeaderFM	GameOver_FM3, $02, $10
	sHeaderFM	GameOver_FM4, $02, $15
	sHeaderFM	GameOver_FM5, $02, $1B
	sHeaderPSG	GameOver_PSG1, $EA, $04, $00, VolEnv_00
	sHeaderPSG	GameOver_PSG2, $EA, $05, $00, VolEnv_00
	sHeaderPSG	GameOver_PSG3, $00, $00, $00, VolEnv_02

	; Patch $00
	; $78
	; $73, $3A, $30, $71,	$18, $D5, $1F, $1F
	; $0C, $0E, $0E, $07,	$0F, $09, $04, $0C
	; $58, $5C, $1C, $1C,	$2F, $17, $1C, $07
	spAlgorithm	$00
	spFeedback	$07
	spDetune	$07, $03, $03, $07
	spMultiple	$03, $00, $0A, $01
	spRateScale	$00, $00, $03, $00
	spAttackRt	$18, $1F, $15, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0C, $0E, $0E, $07
	spSustainRt	$0F, $04, $09, $0C
	spSustainLv	$05, $01, $05, $01
	spReleaseRt	$08, $0C, $0C, $0C
	spTotalLv	$2F, $1C, $17, $07

	; Patch $01
	; $F4
	; $71, $31, $32, $74,	$17, $17, $1F, $14
	; $0C, $1C, $1C, $1C,	$0E, $00, $07, $00
	; $16, $16, $16, $16,	$0C, $00, $00, $00
	spAlgorithm	$04
	spFeedback	$06
	spDetune	$07, $03, $03, $07
	spMultiple	$01, $02, $01, $04
	spRateScale	$00, $00, $00, $00
	spAttackRt	$17, $1F, $17, $14
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0C, $1C, $1C, $1C
	spSustainRt	$0E, $07, $00, $00
	spSustainLv	$01, $01, $01, $01
	spReleaseRt	$06, $06, $06, $06
	spTotalLv	$0C, $00, $00, $00

	; Patch $02
	; $F4
	; $71, $31, $32, $72,	$17, $17, $1F, $14
	; $1C, $1C, $1C, $1C,	$0E, $00, $07, $00
	; $16, $16, $16, $16,	$01, $00, $0E, $00
	spAlgorithm	$04
	spFeedback	$06
	spDetune	$07, $03, $03, $07
	spMultiple	$01, $02, $01, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$17, $1F, $17, $14
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$1C, $1C, $1C, $1C
	spSustainRt	$0E, $07, $00, $00
	spSustainLv	$01, $01, $01, $01
	spReleaseRt	$06, $06, $06, $06
	spTotalLv	$01, $0E, $00, $00

	; Patch $03
	; $A5
	; $30, $63, $73, $63,	$1F, $1F, $1F, $1F
	; $09, $18, $18, $18,	$0F, $01, $01, $01
	; $A8, $08, $08, $08,	$01, $01, $01, $01
	spAlgorithm	$05
	spFeedback	$04
	spDetune	$03, $07, $06, $06
	spMultiple	$00, $03, $03, $03
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$09, $18, $18, $18
	spSustainRt	$0F, $01, $01, $01
	spSustainLv	$0A, $00, $00, $00
	spReleaseRt	$08, $08, $08, $08
	spTotalLv	$01, $01, $01, $01

	; Patch $04
	; $6C
	; $71, $33, $35, $7F,	$1F, $1F, $1F, $1F
	; $0C, $0A, $07, $07,	$0C, $0A, $07, $07
	; $1F, $1F, $1F, $1F,	$05, $00, $05, $00
	spAlgorithm	$04
	spFeedback	$05
	spDetune	$07, $03, $03, $07
	spMultiple	$01, $05, $03, $0F
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0C, $07, $0A, $07
	spSustainRt	$0C, $07, $0A, $07
	spSustainLv	$01, $01, $01, $01
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$05, $05, $00, $00

	; Patch $05
	; $7D
	; $32, $72, $72, $71,	$10, $1F, $1F, $1F
	; $0C, $18, $18, $18,	$0D, $00, $00, $00
	; $18, $18, $0A, $18,	$12, $01, $07, $03
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$03, $07, $07, $07
	spMultiple	$02, $02, $02, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$10, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0C, $18, $18, $18
	spSustainRt	$0D, $00, $00, $00
	spSustainLv	$01, $00, $01, $01
	spReleaseRt	$08, $0A, $08, $08
	spTotalLv	$12, $07, $01, $03

	; Patch $06
	; $79
	; $71, $30, $32, $71,	$50, $59, $52, $54
	; $0E, $08, $05, $05,	$0F, $04, $04, $04
	; $55, $55, $55, $A7,	$17, $1A, $18, $00
	spAlgorithm	$01
	spFeedback	$07
	spDetune	$07, $03, $03, $07
	spMultiple	$01, $02, $00, $01
	spRateScale	$01, $01, $01, $01
	spAttackRt	$10, $12, $19, $14
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0E, $05, $08, $05
	spSustainRt	$0F, $04, $04, $04
	spSustainLv	$05, $05, $05, $0A
	spReleaseRt	$05, $05, $05, $07
	spTotalLv	$17, $18, $1A, $00

	; Patch $07
	; $7D
	; $70, $31, $31, $71,	$4C, $1F, $50, $12
	; $0F, $02, $01, $02,	$01, $00, $00, $00
	; $27, $29, $29, $19,	$12, $0C, $0C, $0C
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$07, $03, $03, $07
	spMultiple	$00, $01, $01, $01
	spRateScale	$01, $01, $00, $00
	spAttackRt	$0C, $10, $1F, $12
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0F, $01, $02, $02
	spSustainRt	$01, $00, $00, $00
	spSustainLv	$02, $02, $02, $01
	spReleaseRt	$07, $09, $09, $09
	spTotalLv	$12, $0C, $0C, $0C

	; Patch $08
	; $6C
	; $31, $73, $75, $3F,	$1E, $1F, $1F, $1F
	; $09, $09, $09, $09,	$0C, $01, $0C, $01
	; $F7, $5F, $FF, $5F,	$08, $00, $0F, $02
	spAlgorithm	$04
	spFeedback	$05
	spDetune	$03, $07, $07, $03
	spMultiple	$01, $05, $03, $0F
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1E, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$09, $09, $09, $09
	spSustainRt	$0C, $0C, $01, $01
	spSustainLv	$0F, $0F, $05, $05
	spReleaseRt	$07, $0F, $0F, $0F
	spTotalLv	$08, $0F, $00, $02

GameOver_FM1:
	ssMod68k	$03, $01, $10, $03
	sPatFM		$00
	sPan		spCenter, $00
	saDetune	$01
	saVolFM		$FF
	dc.b nRst, $02, nAb2, $04, nRst, nAb2, nC3, nAb2
	dc.b nEb3, nBb2, $08, nBb3, nF3, nAb2, $04, nEb3
	dc.b nAb3, nBb2, nF3, nBb3, nC3, nRst, nC3, nRst
	dc.b nC3, nC3, nC3, nRst, nC3, nRst, nC3, nC3
	saVolFM		$FD
	dc.b nRst, $09, nC2, $06

GameOver_Loop1:
	saVolFM		$0C
	dc.b nRst, nC2
	sLoop		$00, $04, GameOver_Loop1
	dc.b nRst, $18
	sStop

GameOver_FM2:
	sPan		spCenter, $00
;	sPanAni		$02, $02, $03, $03, $04
	ssMod68k	$11, $01, $10, $03
	sPatFM		$08
	dc.b nRst, $02
	saVolFM		$FD
	dc.b nG5, $10, nF5, $04, nEb5, nD5, $08, nF4
	dc.b nBb4, nF4, $04, nBb4, nD5, nC5, nAb4, nF5
	saVolFM		$FD
	dc.b nG5, nRst, nG5, nRst, nG5, nG5, nG5, nRst
	dc.b nG5, nRst, nG5, nG5
	saVolFM		$FE
	dc.b nRst, $09, nC6, $06

GameOver_Loop2:
	saVolFM		$0E
	dc.b nRst, nC6
	sLoop		$00, $04, GameOver_Loop2
	dc.b nRst, $18
	sStop

GameOver_FM3:
	sPan		spCenter, $00
;	sPanAni		$01, $02, $01, $03, $02
	ssMod68k	$11, $01, $10, $03
	sPatFM		$04
	saDetune	$03
	dc.b nRst, $01, nRst, $04
	saVolFM		$03
	dc.b nC5, $10, nAb4, $04, nC5, nD5, $08, nBb4
	dc.b nF5, nC4, $04, nEb5, nAb5, nD5, nF5, nBb5
	sPatFM		$02
	dc.b nG5, nRst, nG5, nRst, nG5, nG5, nG5, nRst
	dc.b nG5, nRst, nG5, nG5, nRst, $09, nC6, $06

GameOver_Loop3:
	saVolFM		$0E
	dc.b nRst, nC5
	sLoop		$00, $04, GameOver_Loop3
	dc.b nRst, $18
	sStop

GameOver_FM4:
	sPan		spCenter, $00
	sPatFM		$04
	saDetune	$03
	saTranspose	$F4
;	sPanAni		$01, $02, $01, $03, $02
	dc.b nRst, $02, nRst, $07

GameOver_Loop4:
	dc.b nC5, $04, nG5, nC6, nG6, nC6, nG5
	sLoop		$00, $03, GameOver_Loop4
	dc.b nC6, nRst, nC6, nRst, nC6, nC6, nC6, nRst
	dc.b nC6, nRst, nC6, nC6, nRst, $09, nC5, $02
	dc.b nE5, nG5

GameOver_Loop5:
	saVolFM		$08
	dc.b nC6, nRst, nRst, nC5, nE5, nG5
	sLoop		$00, $04, GameOver_Loop5
	dc.b nC6, nRst, $18
	sStop
	dc.b $F2	; Unused

GameOver_FM5:
	sPan		spCenter, $00
;	sPanAni		$03, $03, $01, $03, $04
	ssMod68k	$0E, $01, $10, $03
	saVolFM		$FD
	sPatFM		$03
	dc.b nD7, $02
	saDetune	$02
	dc.b nRst, $01, nEb5, $10, nD5, $04, nC5, nBb4
	dc.b $08, nD4, nF4, nC4, $04, nF4, nBb4, nAb4
	dc.b nEb4, nD5, nE5, nRst, nE5, nRst, nE5, nE5
	dc.b nE5, nRst, nE5, nRst, nE5, nE5
	saVolFM		$FE
	dc.b nRst, $09, nE5, $06

GameOver_Loop6:
	saVolFM		$0E
	dc.b nRst, nE5
	sLoop		$00, $04, GameOver_Loop6
	dc.b nRst, $18
	sStop

d81 =	dLowKick
d82 =	dKick
d83 =	dClap
d84 =	dSnare
d89 =	dHiTom
d8A =	dTom
d8B =	dLowTom

GameOver_DAC1:
;	sPan		spCenter, $00
;	sPan		spLeft, $00
;	sPlaySound	$E3
	dc.b nRst, $03
;	sPan		spCenter, $00
;	sPlaySound	$E3
	dc.b $02
;	sPan		spRight, $00
;	sPlaySound	$E3
	dc.b $03
	sPan		spCenter, $00
	dc.b d84, $02, d8A, d8B, d82, $04, d82, d82
	dc.b d89, d82
	sPan		spRight, $00
	dc.b d8A
	sPan		spCenter, $00
	dc.b d82
	sPan		spLeft, $00
	dc.b d8B
	sPan		spCenter, $00
	dc.b d82, d81, d83, d83, d89, $02, d89, d8A
	dc.b d8A, d8B, d8B, d81, $04, nRst, d82, nRst
	dc.b d82, d82, d82, nRst, d82, nRst, d82, d82
	dc.b d89, $02
	sPan		spRight, $00
	dc.b d8A
	sPan		spCenter, $00
	dc.b d8B, nRst, $03, d82, $06, nRst, $24

GameOver_DAC2:
	sStop

GameOver_PSG1:
	ssMod68k	$01, $01, $01, $01
	dc.b nRst, $02, nG5, $10, nF5, $04, nEb5, nD5
	dc.b $08, nF4, nBb4, nF4, $04, nBb4, nD5, nC5
	dc.b nAb4, nF5
	saVolPSG	$03
	dc.b nE5, nRst, nE5, nRst, nE5, nE5, nE5, nRst
	dc.b nE5, nRst, nE5, nE5, nRst, $09, nE4, $06
	dc.b nRst, $24
	sStop

GameOver_PSG2:
	ssMod68k	$01, $01, $01, $01
	dc.b nRst, $03, nRst, $05
	saDetune	$02
	dc.b nG5, $10, nF5, $04, nEb5, nD5, $08, nF4
	dc.b nBb4, nF4, $04, nBb4, nD5, nC5, nAb4, nF5
	saVolPSG	$07
	dc.b nE5, nRst, nE5, nRst, nE5, nE5, nE5, nRst
	dc.b nE5, nRst, nE5, nE5, nRst, $09, nE4, $06
	dc.b nRst, $24
	sStop

GameOver_PSG3:
	sNoisePSG	$E7
	dc.b nA5, $06, nA5, $02, nA5, nA5, nA5, $04
	dc.b nA5, nA5, nA5, nA5, nA5, nA5, nA5, nA5
	dc.b nA5, nA5, nA5, nA5, $02, nA5, nA5, nA5
	dc.b nA5, nA5, nA5, $0C, nA5, nA5, nA5, nA5
	dc.b $02, nA5, nA5, nRst, $09, nA5, $06

GameOver_Loop7:
	saVolPSG	$03
	dc.b nRst, nA5
	sLoop		$00, $07, GameOver_Loop7
	dc.b nRst, $18
	sStop
