SmilingBomb_Header:
	sHeaderInit
	sHeaderTempo	$01, $25
	sHeaderCh	$05, $03
	sHeaderDAC	SmilingBomb_DAC1
	sHeaderDAC	SmilingBomb_DAC2
	sHeaderFM	SmilingBomb_FM1, $00, $0E
	sHeaderFM	SmilingBomb_FM2, $0C, $04
	sHeaderFM	SmilingBomb_FM3, $00, $0C
	sHeaderFM	SmilingBomb_FM4, $00, $0E
	sHeaderFM	SmilingBomb_FM5, $00, $0A
	sHeaderPSG	SmilingBomb_PSG1, $DC, $03, $00, VolEnv_19
	sHeaderPSG	SmilingBomb_PSG2, $DC, $02, $00, VolEnv_04
	sHeaderPSG	SmilingBomb_PSG3, $00, $01, $00, VolEnv_02

	; Patch $00
	; $35
	; $10, $51, $00, $11,	$5F, $5F, $5F, $5F
	; $10, $1F, $1F, $1F,	$0B, $00, $00, $00
	; $26, $07, $07, $07,	$0E, $80, $98, $80
	spAlgorithm	$05
	spFeedback	$06
	spDetune	$01, $00, $05, $01
	spMultiple	$00, $00, $01, $01
	spRateScale	$01, $01, $01, $01
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$10, $1F, $1F, $1F
	spSustainRt	$0B, $00, $00, $00
	spSustainLv	$02, $00, $00, $00
	spReleaseRt	$06, $07, $07, $07
	spTotalLv	$0E, $18, $00, $00

	; Patch $01
	; $3B
	; $71, $71, $31, $71,	$12, $14, $12, $14
	; $10, $00, $0F, $0E,	$09, $00, $00, $01
	; $55, $0A, $05, $2A,	$10, $0E, $10, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$07, $03, $07, $07
	spMultiple	$01, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$12, $12, $14, $14
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$10, $0F, $00, $0E
	spSustainRt	$09, $00, $00, $01
	spSustainLv	$05, $00, $00, $02
	spReleaseRt	$05, $05, $0A, $0A
	spTotalLv	$10, $10, $0E, $00

	; Patch $02
	; $3B
	; $08, $70, $30, $01,	$DF, $1F, $1F, $DF
	; $1C, $13, $1A, $08,	$06, $00, $13, $01
	; $5A, $3A, $1A, $3C,	$09, $0D, $00, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$00, $03, $07, $00
	spMultiple	$08, $00, $00, $01
	spRateScale	$03, $00, $00, $03
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$1C, $1A, $13, $08
	spSustainRt	$06, $13, $00, $01
	spSustainLv	$05, $01, $03, $03
	spReleaseRt	$0A, $0A, $0A, $0C
	spTotalLv	$09, $00, $0D, $00

	; Patch $03
	; $3B
	; $08, $73, $30, $01,	$DF, $1F, $1F, $DF
	; $1C, $13, $1A, $08,	$06, $10, $02, $01
	; $5A, $38, $18, $29,	$0F, $11, $1C, $85
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$00, $03, $07, $00
	spMultiple	$08, $00, $03, $01
	spRateScale	$03, $00, $00, $03
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$1C, $1A, $13, $08
	spSustainRt	$06, $02, $10, $01
	spSustainLv	$05, $01, $03, $02
	spReleaseRt	$0A, $08, $08, $09
	spTotalLv	$0F, $1C, $11, $05

	; Patch $04
	; $04
	; $31, $72, $71, $31,	$1F, $4F, $1F, $4F
	; $1C, $03, $1F, $05,	$00, $00, $00, $00
	; $05, $0B, $05, $1B,	$10, $86, $10, $86
	spAlgorithm	$04
	spFeedback	$00
	spDetune	$03, $07, $07, $03
	spMultiple	$01, $01, $02, $01
	spRateScale	$00, $00, $01, $01
	spAttackRt	$1F, $1F, $0F, $0F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$1C, $1F, $03, $05
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$00, $00, $00, $01
	spReleaseRt	$05, $05, $0B, $0B
	spTotalLv	$10, $10, $06, $06

	; Patch $05
	; $3B
	; $00, $70, $31, $02,	$DF, $11, $17, $DF
	; $18, $13, $1A, $10,	$13, $10, $10, $11
	; $5A, $3C, $1C, $AF,	$19, $1F, $20, $81
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$00, $03, $07, $00
	spMultiple	$00, $01, $00, $02
	spRateScale	$03, $00, $00, $03
	spAttackRt	$1F, $17, $11, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$18, $1A, $13, $10
	spSustainRt	$13, $10, $10, $11
	spSustainLv	$05, $01, $03, $0A
	spReleaseRt	$0A, $0C, $0C, $0F
	spTotalLv	$19, $20, $1F, $01

	; Patch $06
	; $3B
	; $0A, $6A, $33, $0C,	$DF, $1F, $1F, $DF
	; $1F, $13, $1A, $0A,	$0D, $02, $00, $10
	; $2A, $2C, $0C, $5F,	$0B, $1C, $05, $82
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$00, $03, $06, $00
	spMultiple	$0A, $03, $0A, $0C
	spRateScale	$03, $00, $00, $03
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$1F, $1A, $13, $0A
	spSustainRt	$0D, $00, $02, $10
	spSustainLv	$02, $00, $02, $05
	spReleaseRt	$0A, $0C, $0C, $0F
	spTotalLv	$0B, $05, $1C, $02

	; Patch $07
	; $3D
	; $06, $63, $34, $11,	$1F, $1F, $1F, $1F
	; $0A, $12, $12, $12,	$1E, $1E, $1E, $1E
	; $3F, $FF, $AF, $FF,	$0E, $82, $82, $82
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $03, $06, $01
	spMultiple	$06, $04, $03, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0A, $12, $12, $12
	spSustainRt	$1E, $1E, $1E, $1E
	spSustainLv	$03, $0A, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0E, $02, $02, $02

	; Patch $08
	; $3C
	; $7C, $7C, $3C, $3C,	$DF, $1F, $1F, $DF
	; $1F, $10, $1A, $09,	$07, $11, $00, $10
	; $1A, $4F, $1C, $5F,	$0E, $82, $00, $82
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$07, $03, $07, $03
	spMultiple	$0C, $0C, $0C, $0C
	spRateScale	$03, $00, $00, $03
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$1F, $1A, $10, $09
	spSustainRt	$07, $00, $11, $10
	spSustainLv	$01, $01, $04, $05
	spReleaseRt	$0A, $0C, $0F, $0F
	spTotalLv	$0E, $00, $02, $02

	; Patch $09
	; $3A
	; $41, $32, $73, $35,	$1F, $1F, $1B, $1F
	; $1F, $10, $0F, $0E,	$03, $00, $00, $08
	; $15, $0A, $35, $1F,	$2A, $10, $14, $90
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$04, $07, $03, $03
	spMultiple	$01, $03, $02, $05
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1B, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$1F, $0F, $10, $0E
	spSustainRt	$03, $00, $00, $08
	spSustainLv	$01, $03, $00, $01
	spReleaseRt	$05, $05, $0A, $0F
	spTotalLv	$2A, $14, $10, $10

	; Patch $0A
	; $3B
	; $71, $71, $31, $71,	$12, $14, $12, $14
	; $10, $00, $0F, $0E,	$09, $00, $00, $01
	; $55, $0A, $05, $2A,	$10, $0E, $10, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$07, $03, $07, $07
	spMultiple	$01, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$12, $12, $14, $14
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$10, $0F, $00, $0E
	spSustainRt	$09, $00, $00, $01
	spSustainLv	$05, $00, $00, $02
	spReleaseRt	$05, $05, $0A, $0A
	spTotalLv	$10, $10, $0E, $00

SmilingBomb_FM1:
	sPan		spCentre
	sPatFM		$00
	dc.b nRst, $18, nAb2, $12, nBb2, $06, nRst, $0C
	dc.b nC3, $18, nEb3, $0C, nAb2, $18, nG2, $12
	dc.b nD2, $06, nRst, $0C, nG2, $18, $06, nRst
	dc.b nD2, $18, nC3, $12, nG2, $06, nRst, $0C
	dc.b nC3, $18, $06, nRst, nG2, $0C, nBb2, nC3
	dc.b $12, nG2, $06, nRst, $0C, nC3, $18, nC3
	dc.b $06, nRst, nBb2, $0C, nA2, nAb2, $12, nBb2
	dc.b $06, nRst, $0C, nC3, $18, nEb3, $0C, nAb2
	dc.b $18, nRst, $0C, nBb3, $0C, sHold, nC4, $06
	dc.b sHold, nBb3, nF3, $0C
	ssMod68k	$14, $01, $FE, $FF
	dc.b nBb2, $30
	sModOff
	dc.b nC3, $12, nG2, $06, nRst, $0C, nC3, $18
	dc.b nC3, $06, nEb3, nF3, nG3, nBb3, nC4
	saVolFM		$09
	saTranspose	$F4
	dc.b nEb4, $06, nRst, $0C, nFs4, $06, nRst, $0C
	dc.b nCs4, $06, nRst, $0C, nE4, $06, nRst, $0C
	dc.b nB3, $06, nRst, $0C, nD4, $06
	sStop

SmilingBomb_FM2:
	sPan		spCentre
	sPatFM		$02
	dc.b nRst, $18, nEb4, $0C
	sPatFM		$05
	dc.b nEb3, $06
	sPatFM		$02
	dc.b nEb4, $06
	sPatFM		$05
	dc.b nEb3, $06, nRst
	sPatFM		$02
	dc.b nEb4, $0C
	sPatFM		$05
	dc.b nEb3, $06
	sPatFM		$02
	dc.b nC4, $06, nRst
	sPatFM		$05
	dc.b nEb3, $06
	sPatFM		$02
	dc.b nBb3, $0C
	sPatFM		$05
	dc.b nEb3, $06, nRst
	sPatFM		$02
	dc.b nEb4, $0C
	sPatFM		$05
	dc.b nEb3, $06
	sPatFM		$02
	dc.b nEb4, $06
	sPatFM		$05
	dc.b nEb3, $06, nRst
	sPatFM		$02
	dc.b nEb4, $0C, nRst, $0C
	sPatFM		$05
	dc.b nEb3, $06, $06
	sPatFM		$02
	dc.b nEb4, $0C
	sPatFM		$05
	dc.b nEb3, $06, $06
	sPatFM		$02
	dc.b nEb4, $0C
	sPatFM		$05
	dc.b nEb3, $06
	sPatFM		$02
	dc.b nEb4, $06, nRst, $06
	sPatFM		$05
	dc.b nEb3
	sPatFM		$02
	dc.b nEb4, $0C
	sPatFM		$05
	dc.b nEb3, $06
	sPatFM		$02
	dc.b nBb3, $06, nRst, $06
	sPatFM		$05
	dc.b nEb3
	sPatFM		$02
	dc.b nBb3, $0C
	sPatFM		$05
	dc.b nEb3, $06, $06
	sPatFM		$02
	dc.b nF4, $02, sHold, nFs4, $01, sHold, nG4, $09
	sPatFM		$05
	dc.b nEb3, $06
	sPatFM		$02
	dc.b nEb4, $06, nRst
	sPatFM		$05
	dc.b nEb3
	sPatFM		$02
	dc.b nC4, $0C
	sPatFM		$05
	dc.b nEb3, $06
	sPatFM		$02
	dc.b nBb3, nRst, $06
	sPatFM		$05
	dc.b nEb3
	sPatFM		$02
	ssMod68k	$08, $02, $E8, $FF
	dc.b nC4, $18
	sModOff
	dc.b nEb4, $0C
	sPatFM		$05
	dc.b nEb3, $06
	sPatFM		$02
	dc.b nEb4, $06, nRst, $06
	sPatFM		$05
	dc.b nEb3
	sPatFM		$02
	dc.b nEb4, $0C
	sPatFM		$05
	dc.b nEb3, $06
	sPatFM		$02
	dc.b nD4, $06, nRst, $06
	sPatFM		$05
	dc.b nEb3
	sPatFM		$02
	dc.b nEb4, $0C
	sPatFM		$05
	dc.b nEb3, $06, nRst
	sPatFM		$03
	saVolFM		$FF
	dc.b nA4, $06, sHold, nBb4, nBb4, nBb4, nRst, $0C
	saVolFM		$01
	sPatFM		$02
	dc.b nEb4, $0C
	sPatFM		$05
	dc.b nEb3, $06
	sPatFM		$02
	dc.b nG4, $12, nAb4, $0C, nBb4, $0C, nD4, $06
	dc.b sHold, nEb4, $0C, nEb4, $06, nRst, $06
	sPatFM		$05
	dc.b nEb3
	sPatFM		$02
	dc.b nF4, $0C
	sPatFM		$05
	dc.b nEb3, $06
	sPatFM		$02
	dc.b nEb4, nRst, $0C, nC4, nRst, $06
	sPatFM		$05
	dc.b nEb3
	sPatFM		$0A
	saTranspose	$F4
	dc.b nCs4, $06, nRst, $08
	saVolFM		$23
	dc.b nCs4, $04
	saVolFM		$DD
	dc.b nE4, $06, nRst, $08
	saVolFM		$23
	dc.b nE4, $04
	saVolFM		$DD
	dc.b nB3, $06, nRst, $08
	saVolFM		$23
	dc.b nB3, $04
	saVolFM		$DD
	dc.b nD4, $06, nRst, $08
	saVolFM		$23
	dc.b nD4, $04
	saVolFM		$DD
	dc.b nA3, $06, nRst, $08
	saVolFM		$23
	dc.b nA3, $04
	saVolFM		$DD
	dc.b nC4, $06, nRst, $08
	saVolFM		$23
	dc.b nC4, $06
	sStop

SmilingBomb_FM3:
	sPan		spCentre
	sPatFM		$06
	ssMod68k	$00, $01, $B0, $FF
	dc.b nBb3, $0C, $06, $06
	sModOff
	sPatFM		$09
	saVolFM		$04
	dc.b nAb2, $48, sHold, $06
	saVolFM		$FC
	sPatFM		$01
	dc.b nC5, nEb5, nRst, nF5, $18, nEb5, $06, nRst
	dc.b nF5, $18, nEb5, $06, nRst, nF5, $06, nG5
	dc.b $12
	sPatFM		$09
	saVolFM		$04
	dc.b nG2, $30, sHold, $0C
	sPatFM		$01
	saVolFM		$FC
	dc.b nC5, $06, nRst, nEb5, nF5, $0C, nG5, $06
	sPatFM		$09
	saVolFM		$04
	dc.b nC3, $30, sHold, $0C
	sPatFM		$01
	saVolFM		$FC
	dc.b nC5, $06, nRst, $0C, nC5, $12, nRst, $01
	sPatFM		$04
	saVolFM		$11
	saDetune	$04
	dc.b nEb6, $0C
	saVolFM		$05
	saDetune	$02
	dc.b nC6, $04, sHold, nCs6, sHold, nD6, nEb6, $0C
	dc.b nRst, $17
	saDetune	$00
	saVolFM		$EA
	sPatFM		$01
	dc.b nG5, $0C, nEb5, $06, nRst, $12
	sPatFM		$09
	saVolFM		$FC
	dc.b nAb2, $30, sHold, $0C
	sPatFM		$01
	saVolFM		$04
	dc.b nG4, $06, nRst, nAb4, nBb4, nRst, $0C, nC5
	dc.b $30, sHold, $0C, nEb4, $04, nD4, nEb4, nF4
	dc.b nFs4, nG4, nBb4, nC5, nD5
	sPatFM		$0A
	saVolFM		$FD
	dc.b nEb5, $06, nRst, $0C, nFs5, $06, nRst, $0C
	dc.b nCs5, $06, nRst, $0C, nE5, $06, nRst, $0C
	dc.b nB4, $06, nRst, $0C, nD5, $06
	sStop

SmilingBomb_FM4:
	sPan		spCentre
	saTranspose	$F4
	dc.b nRst, $18
	sPatFM		$07
	sPan		spLeft, $00
	dc.b nG5, $0C, $06, $06, $18
	sPatFM		$08
	sPan		spRight, $00
	dc.b nC6, $06, $0C, $06
;	sPanAni		$02, $01, $02, $02, $02
	saVolFM		$02
	sPatFM		$01
	sPan		spCenter, $00
	dc.b nRst, $01, nRst, $06, nC5, nEb5, nRst, nF5
	dc.b $18, nEb5, $06, nRst, nF5, $18, nEb5, $06
	dc.b nRst, nF5, $06, nG5, $12
;	sPanAni
	saVolFM		$FE
	sPatFM		$07
	sPan		spLeft, $00
	dc.b nG5, $0C, $06, $06, $18
	sPatFM		$08
	sPan		spRight, $00
	dc.b nC6, $06, $06
	sPan		spCenter, $00
;	sPanAni		$02, $01, $02, $02, $02
	saVolFM		$02
	sPatFM		$01
	dc.b nC5, $06, nRst, nEb5, nF5, $0C, nG5, $06
;	sPanAni
	saVolFM		$FE
	sPatFM		$07
	sPan		spLeft, $00
	dc.b nG5, $0C, $06, $06, $18
	sPatFM		$08
	sPan		spRight, $00
	dc.b nC6, $06, $06
	sPan		spCenter, $00
;	sPanAni		$02, $01, $02, $02, $02
	saVolFM		$02
	sPatFM		$01
	saTranspose	$0C
	saDetune	$02
	dc.b nC5, $06, nRst, $0C, nC5, $06
	saTranspose	$F4
;	sPanAni
	saVolFM		$FE
	saDetune	$00
	saVolFM		$02
	sPatFM		$04
	dc.b nC7, $04, sHold, nCs7, sHold, nD7, nEb7, $0C
	saVolFM		$FE
	sPatFM		$07
	sPan		spLeft, $00
	dc.b nG5, $06, $06, $18
	sPatFM		$08
	sPan		spRight, $00
	dc.b nC6, $06, $06
	sPan		spCenter, $00
;	sPanAni		$02, $01, $02, $02, $02
	saVolFM		$02
	sPatFM		$01
	dc.b nG5, $0C, nEb5, $06, nRst, $12
;	sPanAni
	saVolFM		$FE
	sPatFM		$07
	sPan		spLeft, $00
	dc.b nG5, $0C, $06, $06, $18
	sPatFM		$08
	sPan		spRight, $00
	dc.b nC6, $06, $06
	sPan		spCenter, $00
;	sPanAni		$02, $01, $02, $02, $02
	saVolFM		$02
	sPatFM		$01
	dc.b nG4, $06, nRst, nAb4, nBb4, nRst, $0C, nC5
	dc.b $48, nRst, $0C, nEb4, $06, nE4
;	sPanAni
	saVolFM		$FE
	sPatFM		$0A
	saTranspose	$F4
	dc.b nAb4, $06, nRst, $08
	saVolFM		$19
	dc.b nAb4, $04
	saVolFM		$E7
	dc.b nB4, $06, nRst, $08
	saVolFM		$19
	dc.b nB4, $04
	saVolFM		$E7
	dc.b nFs4, $06, nRst, $08
	saVolFM		$19
	dc.b nFs4, $04
	saVolFM		$E7
	dc.b nA4, $06, nRst, $08
	saVolFM		$19
	dc.b nA4, $04
	saVolFM		$E7
	dc.b nE4, $06, nRst, $08
	saVolFM		$19
	dc.b nE4, $04
	saVolFM		$E7
	dc.b nG4, $06, nRst, $08
	saVolFM		$19
	dc.b nG4, $06
	sStop

SmilingBomb_FM5:
	sPan		spCentre
	saDetune	$04
	saVolFM		$04
	saTranspose	$0C
	dc.b nRst, $05
;	sPanAni		$03, $01, $02, $02, $03
	sPatFM		$02
	dc.b nRst, $18, nEb4, $0C, nRst, $06, nEb4, $06
	dc.b nRst, $0C, nEb4, $0C, nRst, $06, nC4, $06
	dc.b nRst, $0C, nBb3, $0C, nRst, nEb4, $0C, nRst
	dc.b $06, nEb4, $06, nRst, $0C, nEb4, $0C, nRst
	dc.b $18, nEb4, $0C, nRst, nEb4, $0C, nRst, $06
	dc.b nEb4, $06, nRst, $0C, nEb4, nRst, $06, nBb3
	dc.b $06, nRst, $0C, nBb3, $0C, nRst, nF4, $02
	dc.b sHold, nFs4, $01, sHold, nG4, $09, nRst, $06
	dc.b nEb4, $06, nRst, $0C, nC4, $0C, nRst, $06
	dc.b nBb3, nRst, $0C
	ssMod68k	$08, $02, $E8, $FF
	dc.b nC4, $18
	sModOff
	dc.b nEb4, $0C, nRst, $06, nEb4, $06, nRst, $0C
	dc.b nEb4, $0C, nRst, $06, nD4, $06, nRst, $0C
	dc.b nEb4, $0C, nRst, $09
;	sPanAni
	sPatFM		$03
	saVolFM		$F6
	dc.b nE4, $06, sHold, nF4, nF4, nF4, nRst, $0F
	saVolFM		$0A
;	sPanAni		$03, $01, $02, $02, $03
	sPatFM		$02
	dc.b nEb4, $0C, nRst, $06, nG4, $12, nAb4, $0C
	dc.b nBb4, $0C, nD4, $06, sHold, nEb4, $0C, nEb4
	dc.b $06, nRst, $09
	saVolFM		$F6
;	sPanAni
	dc.b nBb4, $0C, nRst, $09
;	sPanAni		$03, $01, $02, $02, $03
	saVolFM		$0A
	dc.b nEb4, $06, nRst, $0C, nC4, nRst, $07
;	sPanAni
	sPatFM		$0A
	saTranspose	$F4
	dc.b nF4, $06, nRst, $08
	saVolFM		$1E
	dc.b nF4, $04
	saVolFM		$E2
	dc.b nAb4, $06, nRst, $08
	saVolFM		$1E
	dc.b nAb4, $04
	saVolFM		$E2
	dc.b nEb4, $06, nRst, $08
	saVolFM		$1E
	dc.b nEb4, $04
	saVolFM		$E2
	dc.b nFs4, $06, nRst, $08
	saVolFM		$1E
	dc.b nFs4, $04
	saVolFM		$E2
	dc.b nCs4, $06, nRst, $08
	saVolFM		$1E
	dc.b nCs4, $04
	saVolFM		$E2
;	sPlaySound	$7D
	dc.b nE4, $06, nRst, $08
	saVolFM		$1E
	dc.b nE4, $06
	sStop

SmilingBomb_PSG1:
	dc.b nRst, $18
	ssMod68k	$12, $01, $05, $04
	dc.b nC4, $60, nB3
	ssMod68k	$12, $01, $02, $04
	dc.b nG4
	ssMod68k	$12, $01, $05, $04
	dc.b nBb3
	ssMod68k	$12, $01, $02, $04
	dc.b nBb4, nC4, nBb3
	sStop

SmilingBomb_PSG2:
	dc.b nRst, $18
	sVolEnvPSG	VolEnv_04
	ssMod68k	$12, $01, $0B, $04
	dc.b nBb4, $06, $06, nC4, $06, nBb4, $06, nRst
	dc.b nBb4
	sVolEnvPSG	VolEnv_00
	saVolPSG	$03
	dc.b nEb3, $0C, sHold, $30
	sVolEnvPSG	VolEnv_04
	saVolPSG	$FD
	dc.b nF4, $06, $06, $06, $06, nRst, $0C, nF4
	sVolEnvPSG	VolEnv_00
	saVolPSG	$03
	dc.b nD3, $30
	sVolEnvPSG	VolEnv_04
	saVolPSG	$FD
	dc.b nBb4, $06, nC4, nBb4, nC4, nC3, nBb4, nC4
	dc.b nBb4
	sVolEnvPSG	VolEnv_00
	saVolPSG	$03
	dc.b nEb3, $30
	sVolEnvPSG	VolEnv_19
	saVolPSG	$FD
	dc.b nG3, $54
	saVolPSG	$00
	saDetune	$FF
	ssMod68k	$12, $01, $04, $04
	sVolEnvPSG	VolEnv_1A
	dc.b nC6, $04, nCs6, nD6
	ssMod68k	$12, $01, $0B, $04
	dc.b nEb6, $0C
	saVolPSG	$00
	sVolEnvPSG	VolEnv_04
	dc.b nG4, $06, nC4, nG4, nRst
	sVolEnvPSG	VolEnv_00
	saVolPSG	$03
	dc.b nG4, nEb3, sHold, $30
	sVolEnvPSG	VolEnv_04
	saVolPSG	$FD
	dc.b nEb4, $06, $06, nF3, nEb4, $06, nRst, $0C
	dc.b nEb4
	sVolEnvPSG	VolEnv_00
	saVolPSG	$03
	dc.b nF3, $30
	sVolEnvPSG	VolEnv_04
	saVolPSG	$FD
	dc.b nG4, $06, nG3, nG4, nG3, nG3, nG4, nG3
	dc.b nG4
	sVolEnvPSG	VolEnv_00
	saVolPSG	$03
	dc.b nG3, $30
	saVolPSG	$FD
	dc.b nRst, $30, $18
	sModOff
	sStop

SmilingBomb_PSG3:
	dc.b nRst, $18
	sNoisePSG	$E7

SmilingBomb_Loop1:
	sVolEnvPSG	VolEnv_01
	dc.b nA5, $0C
	sVolEnvPSG	VolEnv_02
	dc.b nA5, $06, $06, $18, $06, $0C, $06, nRst
	dc.b $18, nA5, $0C, $06, $06, nRst, $18, nA5
	dc.b $04, $04, $04
	sVolEnvPSG	VolEnv_01
	dc.b nA5, $0C
	sVolEnvPSG	VolEnv_02
	dc.b nA5, $0C, $06, $06
	sLoop		$00, $03, SmilingBomb_Loop1
	sVolEnvPSG	VolEnv_01
	dc.b nA5, $0C
	sVolEnvPSG	VolEnv_02
	dc.b nA5, $06, $06, $18, $06, $0C, nRst, $06
	dc.b nRst, $18
	sStop

d81 =	dKick
d82 =	dSnare
d8B =	dSnare
d8C =	dHiTom
d8D =	dTom
d8E =	dLowTom

SmilingBomb_DAC1:
	sPan		spCentre
	dc.b d82, $0C, d82, $06, d82

SmilingBomb_Loop2:
	dc.b d81, $0C, d8B, d82, $0C, d81, $18, d81
	dc.b $06, $06, d82, $0C, d81, $06, d8B
	sLoop		$00, $03, SmilingBomb_Loop2
	dc.b d81, $0C, d8B, d82, $0C, d81, $18, d81
	dc.b $06, $06, d82, $0C, $06, d8B

SmilingBomb_Loop3:
	dc.b d81, $0C, d8B, d82, $0C, d81, $18, d81
	dc.b $06, $06, d82, $0C, d81, $06, d8B
	sLoop		$00, $02, SmilingBomb_Loop3
	dc.b d81, $0C, d8B, d82, d81, nRst, $06, d82
	dc.b d81, nRst, d8C, $04, nRst, d82, d82, d8D
	dc.b d8E, d82, $06, d81, d8E, d8C, nRst, d81
	dc.b d8D, nRst, d81, d82, d8E, d81, d8C, d8E
	dc.b nRst, d8D
	sStop

SmilingBomb_DAC2:
	dc.b nRst, $04		; wait for 4 ticks
	sComm	$00, $00	; clear out the flag

.loop	sCond	$00, dcoNE, $00	; check if comm 0 != $00
	sJump	.gman		; if so, jump
	sCondOff		; reset cond

	dc.b nRst, $04		; wait for 4 ticks
	sJump	.loop

.gman	sFadePause
	dc.b nRst, $12
	dc.b dStarve, $7F, sHold, $7F, sHold, $7F, sHold, $1C
	sFadeUnpause
	sComm	$00, $00	; clear out the flag
	sJump	.loop
