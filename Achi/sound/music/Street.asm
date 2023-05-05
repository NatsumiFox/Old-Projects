Street_Header:
	sHeaderInit
	sHeaderTempo	$03, $0C
	sHeaderCh	$05, $03
	sHeaderDAC	Street_DAC1
	sHeaderDAC	Street_DAC2
	sHeaderFM	Street_FM1, $F4, $17
	sHeaderFM	Street_FM2, $F4, $14
	sHeaderFM	Street_FM3, $F4, $0F
	sHeaderFM	Street_FM4, $F4, $15
	sHeaderFM	Street_FM5, $F4, $1E
	sHeaderPSG	Street_PSG1, $C4, $03, $00, VolEnv_0B
	sHeaderPSG	Street_PSG2, $C4, $03, $00, VolEnv_0B
	sHeaderPSG	Street_PSG3, $00, $01, $00, VolEnv_09

	; Patch $00
	; $3D
	; $01, $62, $03, $21,	$30, $1F, $13, $26
	; $08, $08, $08, $03,	$05, $00, $03, $00
	; $1F, $1B, $1B, $1B,	$1C, $83, $83, $83
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
	spTotalLv	$1C, $03, $03, $03

	; Patch $01
	; $03
	; $09, $00, $00, $00,	$1F, $1F, $1F, $1F
	; $10, $02, $0D, $0D,	$04, $00, $00, $00
	; $CF, $FF, $FF, $FF,	$25, $19, $19, $80
	spAlgorithm	$03
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$09, $00, $00, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$10, $0D, $02, $0D
	spSustainRt	$04, $00, $00, $00
	spSustainLv	$0C, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$25, $19, $19, $00

	; Patch $02
	; $3D
	; $01, $62, $02, $21,	$30, $1F, $13, $26
	; $08, $08, $08, $03,	$05, $00, $03, $00
	; $0F, $1B, $1B, $1B,	$1E, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $06, $02
	spMultiple	$01, $02, $02, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$10, $13, $1F, $06
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$08, $08, $08, $03
	spSustainRt	$05, $03, $00, $00
	spSustainLv	$00, $01, $01, $01
	spReleaseRt	$0F, $0B, $0B, $0B
	spTotalLv	$1E, $00, $00, $00

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
	; $59
	; $04, $11, $34, $71,	$1F, $1F, $1F, $1F
	; $0E, $0E, $0E, $0B,	$11, $0C, $0E, $00
	; $3F, $3F, $3F, $7F,	$1F, $11, $1A, $80
	spAlgorithm	$01
	spFeedback	$03
	spDetune	$00, $03, $01, $07
	spMultiple	$04, $04, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0E, $0E, $0E, $0B
	spSustainRt	$11, $0E, $0C, $00
	spSustainLv	$03, $03, $03, $07
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1F, $1A, $11, $00

	; Patch $06
	; $2C
	; $01, $01, $20, $00,	$1D, $1D, $1D, $1D
	; $06, $02, $06, $02,	$10, $03, $00, $03
	; $4F, $5F, $AF, $8F,	$16, $85, $10, $85
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
	spTotalLv	$16, $10, $05, $05

	; Patch $07
	; $24
	; $02, $02, $02, $41,	$11, $1B, $11, $1B
	; $07, $09, $10, $04,	$0B, $19, $18, $1D
	; $2F, $4F, $4F, $4F,	$17, $82, $17, $82
	spAlgorithm	$04
	spFeedback	$04
	spDetune	$00, $00, $00, $04
	spMultiple	$02, $02, $02, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$11, $11, $1B, $1B
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$07, $10, $09, $04
	spSustainRt	$0B, $18, $19, $1D
	spSustainLv	$02, $04, $04, $04
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$17, $17, $02, $02

	; Patch $08
	; $0C
	; $04, $01, $34, $71,	$1F, $1D, $1F, $1D
	; $0D, $09, $0D, $09,	$10, $13, $00, $13
	; $47, $57, $A7, $87,	$1A, $81, $1A, $82
	spAlgorithm	$04
	spFeedback	$01
	spDetune	$00, $03, $00, $07
	spMultiple	$04, $04, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1D, $1D
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0D, $0D, $09, $09
	spSustainRt	$10, $00, $13, $13
	spSustainLv	$04, $0A, $05, $08
	spReleaseRt	$07, $07, $07, $07
	spTotalLv	$1A, $1A, $01, $02

	; Patch $09
	; $0C
	; $04, $01, $34, $71,	$1F, $1D, $1F, $1D
	; $13, $07, $13, $07,	$10, $13, $00, $13
	; $47, $57, $A7, $87,	$1D, $81, $1D, $82
	spAlgorithm	$04
	spFeedback	$01
	spDetune	$00, $03, $00, $07
	spMultiple	$04, $04, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1D, $1D
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$13, $13, $07, $07
	spSustainRt	$10, $00, $13, $13
	spSustainLv	$04, $0A, $05, $08
	spReleaseRt	$07, $07, $07, $07
	spTotalLv	$1D, $1D, $01, $02

Street_FM1:
	sPan		spCentre
	ssMod68k	$05, $01, $02, $02
	sPatFM		$00
	dc.b nF6, $06, $06, $04, nE6, $02, nF6, $04
	dc.b nG6, $06, nRst, $08
	sPatFM		$07
	dc.b nG7, $06, nRst, $06
	sPatFM		$07
	dc.b nE6, $0C, nF6, $0A, nG6, $06, nRst, $0E
	dc.b nG6, $04, nF6, $02, nE6, $06, $06, nF6
	dc.b $0A, nG6, $06, nRst, $0C, nF6, $02, nG6
	dc.b $04, nA6, $02, nBb6, $06, nA6, nG6, nF6
	dc.b $04, nG6, $08, nF6, $06, nE6, nF6, $04
	dc.b nD6, $02, sHold, $24, nE6, $06, nD6, nE6
	dc.b $0C, nF6, $0A, nG6, $06, nRst, $0E, nG6
	dc.b $04, nF6, $02, nE6, $06, $06, nF6, $0A
	dc.b nG6, $06, nRst, $0C, nF6, $02, nG6, $04
	dc.b nA6, $02, nBb6, $06, nA6, nG6, nF6, $04
	dc.b nG6, $08, nF6, $06, nE6, nF6, $04, nD6
	dc.b $02, sHold, $24, nE6, $06, nD6, nC6, $0C
	dc.b nA6, $0A, nG6, $08, nF6, $06, nE6, nD6
	dc.b nC6, $04, nB5, $02, nC6, $04, nB5, $02
	dc.b nC6, $04, nA6, $06, nG6, nG6, $02, nF6
	dc.b $06, nE6, nD6, nC6, $04, nB5, $02, nC6
	dc.b $04, nB5, $02, nC6, $04, nD6, $02, nE6
	dc.b $04, nF6, $08, nE6, $06, nF6, nG6, nD6
	dc.b $30
	sPatFM		$07
	dc.b nE6, $0C, nF6, $0A, nG6, $06, nRst, $0E
	dc.b nG6, $04, nF6, $02, nE6, $06, $06, nF6
	dc.b $0A, nG6, $06, nRst, $0C, nF6, $02, nG6
	dc.b $04, nA6, $02, nBb6, $06, nA6, nG6, nF6
	dc.b $04, nG6, $08, nF6, $06, nE6, nF6, $04
	dc.b nD6, $02, sHold, $24
	sPatFM		$00
	dc.b nE6, $06, nD6, nC6, $0C, nA6, $0A, nG6
	dc.b $08, nF6, $06, nE6, nD6, nC6, $04, nB5
	dc.b $02, nC6, $04, nB5, $02, nC6, $04, nA6
	dc.b $06, nG6, nG6, $02, nF6, $06, nE6, nD6
	dc.b nC6, $04, nB5, $02, nC6, $04, nB5, $02
	dc.b nC6, $04, nD6, $02, nE6, $04, nF6, $08
	dc.b nE6, $06, nF6, nG6, nD6, $30
	sPatFM		$07
	dc.b nG6, $0C, nD7, $0A, nC7, $08, nB6, $06
	dc.b nA6, nG6, nF6, $04, nE6, $02, nF6, $04
	dc.b nE6, $02, nF6, $04, nD6, $06, nG6, $08
	dc.b nA6, $06, nB6, nG6
	sPatFM		$00
	dc.b nG6, $04, nFs6, $02, nG6, $04, nFs6, $02
	dc.b nG6, $04, nB6, $06, nC7, nC7, $02, nB6
	dc.b $06, nC7, nD7
	sPatFM		$07
	dc.b nE7, $04, nEb7, $02, nD7, $04, nCs7, $02
	dc.b nC7, $04, nB6, $02, nBb6, $04, nA6, $02
	dc.b nAb6, $04, nG6, $02, nFs6, $04, nF6, $02
	dc.b nE6, $04, nEb6, $02, nD6, $06, $04, nCs6
	dc.b $02, nC6, $04, nB5, $02, nBb5, $04, nA5
	dc.b $02, nAb5, $04, nG5, $0E, nG7, $0C
	sJump		Street_FM1

Street_FM2:
	sPan		spRight, $00
	sPatFM		$06
	dc.b nBb5, $06, nBb5, $06, nBb5, $04, nA5, $02
	dc.b nBb5, $04, nG5, $04, nRst, $16
	sPatFM		$07
	dc.b nRst, $30, nRst, $28, nA4, $02, nBb4, $04
	dc.b nC5, $02, nD5, $06, nC5, nBb4, nA4, $04
	dc.b nG4, $08, nF4, $06, nE4, nF4, $04, nG4
	dc.b $02, sHold, $18, nB4, $18, nRst, $30, $28
	dc.b nA5, $02, nBb5, $04, nC6, $02, nD6, $06
	dc.b nC6, nBb5, nA5, $04, nBb5, $08, nA5, $06
	dc.b nG5, nA5, $04, nBb5, $02, sHold, $18, nF5
	dc.b $0C, nC6, $06, nBb5
	sPatFM		$06
	dc.b nA5, $16, nG5, $1A, nF5, $16, nE5, $1A
	dc.b nF5, $16, nD5, $1A, nBb5, $06, $06, $06
	dc.b nAb5, $04, nG5, $1A
	sPatFM		$07
	dc.b nRst, $30, $28, nA5, $02, nBb5, $04, nC6
	dc.b $02, nD6, $06, nC6, nBb5, nA5, $04, nBb5
	dc.b $08, nA5, $06, nG5, nA5, $04, nBb5, $02
	dc.b sHold, $18, nF5, $0C, nC6, $06, nBb5
	sPatFM		$06
	dc.b nA5, $16, nG5, $1A, nF5, $16, nE5, $1A
	dc.b nF5, $16, nD5, $1A, nG5, $30, nB5, $16
	dc.b nC6, $1A, $16, nB5, $1A, $16, nA5, $1A
	dc.b nG6, $04, nG6, $04, nRst, $0A, nG7, $04
	dc.b nG7, $04, nRst, $16, nG6, $04, nG6, $04
	dc.b nRst, $0A, nG7, $04, nG7, $04, nRst, $0A
	dc.b nB6, $04, nRst, $08
	sJump		Street_FM2

Street_FM3:
	sPan		spCentre
	sPatFM		$01
	dc.b nBb3, $06, nBb3, nBb3, nBb3, $04, nG3, $1A
	dc.b nC4, $0C, nG3, $0A, nC4, $04, nRst, $16
	dc.b nC4, $0C, nG3, $0A, nC4, $04, nRst, $16
	dc.b nG3, $06, $06, $0A, $06, $06, $02, $0C
	dc.b $06, $06, $0A, $06, $06, $02, $0C, nC4
	dc.b $0C, nG3, $0A, nC4, $04, nRst, $16, nC4
	dc.b $0C, nG3, $0A, nC4, $04, nRst, $16, nG3
	dc.b $06, $06, $0A, $06, $06, $02, $0C, nBb3
	dc.b $06, $06, $0A, $06, $06, $02, $0C, nA3
	dc.b $06, $06, $0A, nG3, $06, $06, $02, $06
	dc.b $06, nF4, nF4, nF4, $0A, nE4, $06, $06
	dc.b $02, $06, nE4, $06, nF4, nF4, nF4, $0A
	dc.b nD4, $06, $06, $02, $06, $06, nBb3, nBb3
	dc.b nBb3, nAb3, $04, nG3, $06, $06, $02, $0C
	dc.b nC4, $0C, nG3, $0A, nC4, $04, nRst, $16
	dc.b nC4, $0C, nG3, $0A, nC4, $04, nRst, $16
	dc.b nG3, $06, $06, $0A, $06, $06, $02, $06
	dc.b $06, nBb3, nBb3, nBb3, $0A, $06, $06, $02
	dc.b $06, $06, nA3, nA3, nA3, $0A, nG3, $06
	dc.b $06, $02, $06, $06, nF4, nF4, nF4, $0A
	dc.b nE4, $06, $06, $02, $06, nE4, $06, nF4
	dc.b nF4, nF4, $0A, nD4, $06, $06, $02, $06
	dc.b $06, nG3, nG3, nG3, $0A, $06, $06, $02
	dc.b $06, $06, nE4, nE4, nE4, $0A, nA3, $06
	dc.b $06, $02, $06, $06, nD4, nD4, nD4, $0A
	dc.b nG3, $06, $06, $02, $06, $06, nE4, nE4
	dc.b nE4, $0A, nA3, $06, $06, $02, $06, nA3
	dc.b $06, nG3, $04, $0E, nG4, $04, $12, $02
	dc.b nD4, $06, nG3, $04, $0E, nG4, $04, $0E
	dc.b $06, nD4
	sJump		Street_FM3

Street_FM4:
	sPan		spLeft, $00
	sPatFM		$07
	dc.b nD6, $06, nD6, $06, nD6, $04, nC6, $02
	dc.b nD6, $04, nB5, $04, nRst, $16
	sPatFM		$08
	dc.b nG5, $04, nC6, $02, nE6, $04, nG6, $02
	dc.b nC7, $04, nG6, $02, nE6, $04, nC6, $02
	dc.b nRst, $18, nG5, $04, nC6, $02, nE6, $04
	dc.b nG6, $02, nC7, $04, nG6, $02, nE6, $04
	dc.b nC6, $02, nRst, $18
	sPatFM		$05
	dc.b nRst, $06, nG6, nRst, nG6, nRst, nG6, nRst
	dc.b nG6, nRst, $06, nG6, nRst, nG6, nRst, nG6
	dc.b nRst, nG6
	sPatFM		$08
	dc.b nG5, $04, nC6, $02, nE6, $04, nG6, $02
	dc.b nC7, $04, nG6, $02, nE6, $04, nC6, $02
	dc.b nRst, $18, nG5, $04, nC6, $02, nE6, $04
	dc.b nG6, $02, nC7, $04, nG6, $02, nE6, $04
	dc.b nC6, $02, nRst, $18
	sPatFM		$05
	dc.b nRst, $06, nG6, nRst, nG6, nRst, nG6, nRst
	dc.b nG6, nRst, $06, nF6, nRst, nF6, nRst, nF6
	dc.b nRst, nF6, nRst, $06, nA6, nRst, nA6, nRst
	dc.b nG6, nRst, nG6, nRst, $06, nA6, nRst, nA6
	dc.b nRst, nG6, nRst, nG6, nRst, $06, nA6, nRst
	dc.b nA6, nRst, nA6, nRst, nA6
	sPatFM		$07
	dc.b nF6, $06, nF6, $06, nF6, $06, nF6, $04
	dc.b nG6, $14, nRst, $06
	sPatFM		$08
	dc.b nG5, $04, nC6, $02, nE6, $04, nG6, $02
	dc.b nC7, $04, nG6, $02, nE6, $04, nC6, $02
	dc.b nRst, $18, nG5, $04, nC6, $02, nE6, $04
	dc.b nG6, $02, nC7, $04, nG6, $02, nE6, $04
	dc.b nC6, $02, nRst, $18
	sPatFM		$05
	dc.b nRst, $06, nG6, nRst, nG6, nRst, nG6, nRst
	dc.b nG6, nRst, $06, nF6, nRst, nF6, nRst, nF6
	dc.b nRst, nF6, nRst, $06, nA6, nRst, nA6, nRst
	dc.b nG6, nRst, nG6, nRst, $06, nA6, nRst, nA6
	dc.b nRst, nG6, nRst, nG6, nRst, $06, nA6, nRst
	dc.b nA6, nRst, nA6, nRst, nA6, nRst, $06, nG6
	dc.b nRst, nG6, nRst, nG6, nRst, nG6, nRst, $06
	dc.b nG6, nRst, nG6, nRst, nA6, nRst, nA6, nRst
	dc.b $06, nA6, nRst, nA6, nRst, nG6, nRst, nG6
	dc.b nRst, nG6, nRst, nG6, nRst, nA6, nRst, nA6
	sPatFM		$08
	dc.b nG4, $04, nG5, $02, $04, nG4, $02, nG5
	dc.b $04, nG4, $02, nG6, $04, $02, nG4, $04
	dc.b nG5, $02, $04, nG4, $02, nG5, $04, nG4
	dc.b $02, nG5, $06, nG4, $04, nG5, $02, $04
	dc.b nG4, $02, nG5, $04, nG4, $02, nG6, $04
	dc.b $02, nG4, $04, nG5, $02, $04, nG4, $02
	dc.b nG5, $06, nRst, $06
	sJump		Street_FM4

Street_FM5:
	sPan		spRight, $00
	dc.b nRst, $03
	saDetune	$08
	saVolFM		$0E
	sJump		Street_FM1

Street_PSG1:
	dc.b nBb5, $06, nBb5, $06, nBb5, $04, nA5, $02
	dc.b nBb5, $04, nG5, $04, nRst, $16

Street_Loop1:
	dc.b nC6, $0C, nD6, $0A, nE6, $08, nRst, $0A
	dc.b nG7, $02, nG6, $02, nRst, $04, nC6, $06
	dc.b nC6, $06, nD6, $0A, nE6, $06, nG7, $02
	dc.b nG6, $02, nRst, $10, nRst, $06, nD6, nRst
	dc.b nD6, nRst, nD6, nRst, nD6, nRst, $06, nD6
	dc.b nRst, nD6, nRst, nD6, nRst, nD6
	sLoop		$00, $02, Street_Loop1
	dc.b nRst, $06, nC6, nRst, nC6, nRst, nB5, nRst
	dc.b nB5, nRst, $06, nC6, nRst, nC6, nRst, nB5
	dc.b nRst, nB5, nRst, $06, nC6, nRst, nC6, nRst
	dc.b nD6, nRst, nD6, nD6, $06, nD6, $06, nD6
	dc.b $06, nD6, $04, nD6, $14, nRst, $06, nC6
	dc.b $0C, nD6, $0A, nE6, $08, nRst, $0A, nG7
	dc.b $02, nG6, $02, nRst, $04, nC6, $06, nC6
	dc.b $06, nD6, $0A, nE6, $06, nG7, $02, nG6
	dc.b $02, nRst, $10, nRst, $06, nD6, nRst, nD6
	dc.b nRst, nD6, nRst, nD6, nRst, $06, nD6, nRst
	dc.b nD6, nRst, nD6, nRst, nD6, nRst, $06, nC6
	dc.b nRst, nC6, nRst, nB5, nRst, nB5, nRst, nC6
	dc.b nRst, nC6, nRst, nB5, nRst, nB5, nRst, nC6
	dc.b nRst, nC6, nRst, nD6, nRst, nD6, nRst, $06
	dc.b nB5, nRst, nB5, nRst, nB5, nRst, nB5, nRst
	dc.b $06, nB5, nRst, nB5, nRst, nC6, nRst, nC6
	dc.b nRst, $06, nC6, nRst, nC6, nRst, nB5, nRst
	dc.b nB5, nRst, $06, nB5, nRst, nB5, nRst, nE6
	dc.b nRst, nE6, nFs6, $04, nFs6, $04, nRst, $0A
	dc.b nFs7, $04, nFs7, $04, nRst, $16, nFs6, $04
	dc.b nFs6, $04, nRst, $0A, nFs7, $04, nFs7, $04
	dc.b nRst, $0A, nD6, $04, nRst, $08
	sJump		Street_PSG1

Street_PSG2:
	dc.b nD6, $06, nD6, $06, nD6, $04, nC6, $02
	dc.b nD6, $04, nB5, $04, nRst, $16, nE6, $0C
	dc.b nF6, $0A, nG6, $08, nRst, $12, nE6, $06
	dc.b nE6, $06, nF6, $0A, nG6, $04, nRst, $16
	dc.b nRst, $06, nG6, nRst, nG6, nRst, nG6, nRst
	dc.b nG6, nRst, $06, nG6, nRst, nG6, nRst, nG6
	dc.b nRst, nG6, nE6, $0C, nF6, $0A, nG6, $03
	dc.b nRst, $17, nE6, $06, nE6, $06, nF6, $0A
	dc.b nG6, $03, nRst, $17, nRst, $06, nG6, nRst
	dc.b nG6, nRst, nG6, nRst, nG6, nRst, $06, nF6
	dc.b nRst, nF6, nRst, nF6, nRst, nF6, nRst, $06
	dc.b nA6, nRst, nA6, nRst, nG6, nRst, nG6, nRst
	dc.b $06, nA6, nRst, nA6, nRst, nG6, nRst, nG6
	dc.b nRst, $06, nA6, nRst, nA6, nRst, nA6, nRst
	dc.b nA6, nF6, $06, nF6, $06, nF6, $06, nF6
	dc.b $04, nG6, $14, nRst, $06, nE6, $0C, nF6
	dc.b $0A, nG6, $03, nRst, $17, nE6, $06, nE6
	dc.b $06, nF6, $0A, nG6, $03, nRst, $17, nRst
	dc.b $06, nG6, nRst, nG6, nRst, nG6, nRst, nG6
	dc.b nRst, $06, nF6, nRst, nF6, nRst, nF6, nRst
	dc.b nF6, nRst, $06, nA6, nRst, nA6, nRst, nG6
	dc.b nRst, nG6, nRst, $06, nA6, nRst, nA6, nRst
	dc.b nG6, nRst, nG6, nRst, $06, nA6, nRst, nA6
	dc.b nRst, nA6, nRst, nA6, nRst, $06, nG6, nRst
	dc.b nG6, nRst, nG6, nRst, nG6, nRst, $06, nG6
	dc.b nRst, nG6, nRst, nA6, nRst, nA6, nRst, $06
	dc.b nA6, nRst, nA6, nRst, nG6, nRst, nG6, nRst
	dc.b nG6, nRst, nG6, nRst, nA6, nRst, nA6, nG6
	dc.b $04, nG6, $04, nRst, $0A, nG7, $04, nG7
	dc.b $04, nRst, $16, nG6, $04, nG6, $04, nRst
	dc.b $0A, nG7, $04, nG7, $04, nRst, $0A, nB6
	dc.b $04, nRst, $08
	sJump		Street_PSG2

Street_PSG3:
	sNoisePSG	$E7

Street_Jump1:
	dc.b nA5, $02, nRst, $02
	saVolPSG	$04
	dc.b nA5, $01, nRst, $01
	saVolPSG	$FC
	sJump		Street_Jump1

d81 =	dCrash
d82 =	dSnareSVA
d85 =	dLowSnare
d86 =	dHatOp
d87 =	dKickSVA

Street_DAC1:
	dc.b d82, $06, d82, $06, d81, $04, d85, $02
	dc.b d86, $04, d87, $06, nRst, $08, d82, $06
	dc.b nRst, $06, d81, $0C, d81, $0A, d81, $02
	dc.b nRst, $10, d85, $02, d86, $06, d81, $0C
	dc.b d81, $0A, d81, $06, d86, $02, d87, $02
	dc.b nRst, $08, d82, $02, d82, $04, d82, $02
	dc.b d81, $06, d81, $06, d82, $0A, d81, $06
	dc.b d81, $06, d81, $02, d82, $0C, d81, $06
	dc.b d81, $06, d82, $0A, d81, $06, d81, $06
	dc.b d81, $02, d82, $06, d85, $04, $02, d81
	dc.b $0C, d81, $0A, d81, $02, nRst, $10, d85
	dc.b $02, d86, $06, d81, $0C, d81, $0A, d81
	dc.b $06, d86, $02, d87, $02, nRst, $08, d82
	dc.b $02, d82, $04, d82, $02, d81, $06, d81
	dc.b $06, d82, $0A, d81, $06, d81, $06, d81
	dc.b $02, d82, $0C, d81, $06, d81, $06, d82
	dc.b $0A, d81, $06, d81, $06, d81, $02, d82
	dc.b $06, d82, d81, $06, d82, $06, d81, $06
	dc.b d82, $04, d81, $06, d81, $02, d82, $06
	dc.b d81, $06, d82, $06, d81, $06, d82, $06
	dc.b d81, $06, d82, $04, d81, $06, d81, $02
	dc.b d82, $06, d81, $06, d82, $06, d81, $06
	dc.b d82, $06, d81, $06, d82, $04, d81, $06
	dc.b d81, $02, d82, $06, d81, $06, d82, $06
	dc.b d81, $06, d82, $06, d81, $06, d82, $04
	dc.b d81, $06, d81, $02, d82, $06, d81, $04
	dc.b d82, $02, d82, $06, d81, $0C, d81, $0A
	dc.b d81, $02, nRst, $10, d85, $02, d86, $06
	dc.b d81, $0C, d81, $0A, d81, $06, d86, $02
	dc.b d87, $02, nRst, $08, d82, $02, d82, $04
	dc.b d82, $02, d81, $06, d81, $06, d82, $0A
	dc.b d81, $06, d81, $06, d81, $02, d82, $0C
	dc.b d81, $06, d81, $06, d82, $0A, d81, $06
	dc.b d81, $06, d81, $02, d86, $06, d86, d81
	dc.b $06, d82, $06, d81, $06, d82, $04, d81
	dc.b $06, d81, $02, d82, $06, d81, $06, d82
	dc.b $06, d81, $06, d82, $06, d81, $06, d82
	dc.b $04, d81, $06, d81, $02, d82, $06, d81
	dc.b $06, d82, $06, d81, $06, d82, $06, d81
	dc.b $06, d82, $04, d81, $06, d81, $02, d82
	dc.b $06, d81, $06, d82, $06, d81, $06, d82
	dc.b $06, d81, $06, d82, $04, d81, $06, d81
	dc.b $02, d82, $06, d81, $04, d82, $02, d82
	dc.b $04, d82, $02, d81, $06, d82, $06, d81
	dc.b $06, d82, $04, d81, $06, d81, $02, d82
	dc.b $06, d81, $06, d82, $06, d81, $06, d82
	dc.b $06, d81, $06, d82, $04, d81, $06, d81
	dc.b $02, d82, $06, d81, $06, d82, $06, d81
	dc.b $06, d82, $06, d81, $06, d82, $04, d81
	dc.b $06, d81, $02, d82, d82, d82, d85, $02
	dc.b d85, d86, d86, d86, d87, d81, $04, d81
	dc.b $02, nRst, $06, d86, $0A, d81, $06, d81
	dc.b $06, d81, $02, d86, $0C, d81, $04, d81
	dc.b $02, nRst, $06, d86, $0A, d81, $06, d81
	dc.b $06, d81, $02, d86, $06, d86
	sJump		Street_DAC1

Street_DAC2:
	sStop
