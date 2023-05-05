ActClear_Header:
	sHeaderInit
	sHeaderTempo	$01, $30
	sHeaderCh	$05, $03
	sHeaderDAC	ActClear_DAC1
	sHeaderDAC	ActClear_DAC2
	sHeaderFM	ActClear_FM1, $F4, $12
	sHeaderFM	ActClear_FM2, $DC, $07
	sHeaderFM	ActClear_FM3, $F4, $12
	sHeaderFM	ActClear_FM4, $F4, $12
	sHeaderFM	ActClear_FM5, $F4, $12
	sHeaderPSG	ActClear_PSG1, $E8, $05, $00, VolEnv_00
	sHeaderPSG	ActClear_PSG2, $E8, $07, $00, VolEnv_00
	sHeaderPSG	ActClear_PSG3, $01, $08, $00, VolEnv_00

	; Patch $00
	; $39
	; $01, $01, $71, $31,	$9F, $9F, $9F, $9F
	; $11, $12, $0D, $06,	$08, $15, $0B, $08
	; $67, $97, $37, $28,	$1C, $25, $18, $80
	spAlgorithm	$01
	spFeedback	$07
	spDetune	$00, $07, $00, $03
	spMultiple	$01, $01, $01, $01
	spRateScale	$02, $02, $02, $02
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$11, $0D, $12, $06
	spSustainRt	$08, $0B, $15, $08
	spSustainLv	$06, $03, $09, $02
	spReleaseRt	$07, $07, $07, $08
	spTotalLv	$1C, $18, $25, $00

	; Patch $01
	; $34
	; $51, $73, $52, $50,	$1F, $1F, $1F, $1F
	; $0F, $0C, $09, $08,	$04, $04, $02, $02
	; $08, $0A, $0A, $0B,	$12, $87, $33, $80
	spAlgorithm	$04
	spFeedback	$06
	spDetune	$05, $05, $07, $05
	spMultiple	$01, $02, $03, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0F, $09, $0C, $08
	spSustainRt	$04, $02, $04, $02
	spSustainLv	$00, $00, $00, $00
	spReleaseRt	$08, $0A, $0A, $0B
	spTotalLv	$12, $33, $07, $00

	; Patch $02
	; $00
	; $0F, $03, $09, $0F,	$DF, $DF, $DF, $CF
	; $1F, $1E, $0F, $0F,	$01, $08, $0E, $10
	; $0F, $0F, $0F, $02,	$03, $00, $00, $86
	spAlgorithm	$00
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$0F, $09, $03, $0F
	spRateScale	$03, $03, $03, $03
	spAttackRt	$1F, $1F, $1F, $0F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$1F, $0F, $1E, $0F
	spSustainRt	$01, $0E, $08, $10
	spSustainLv	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $02
	spTotalLv	$03, $00, $00, $06

	; Patch $03
	; $00
	; $08, $02, $01, $00,	$D9, $DF, $1F, $1F
	; $12, $11, $14, $0F,	$0A, $00, $0A, $0D
	; $FF, $FF, $FF, $FF,	$0F, $07, $20, $86
	spAlgorithm	$00
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$08, $01, $02, $00
	spRateScale	$03, $00, $03, $00
	spAttackRt	$19, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$12, $14, $11, $0F
	spSustainRt	$0A, $0A, $00, $0D
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0F, $20, $07, $06

	; Patch $04
	; $2E
	; $46, $55, $71, $34,	$9F, $9F, $9F, $9F
	; $0C, $0A, $08, $05,	$0D, $0C, $0A, $0C
	; $07, $07, $07, $08,	$1E, $86, $86, $86
	spAlgorithm	$06
	spFeedback	$05
	spDetune	$04, $07, $05, $03
	spMultiple	$06, $01, $05, $04
	spRateScale	$02, $02, $02, $02
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0C, $08, $0A, $05
	spSustainRt	$0D, $0A, $0C, $0C
	spSustainLv	$00, $00, $00, $00
	spReleaseRt	$07, $07, $07, $08
	spTotalLv	$1E, $06, $06, $06

ActClear_FM1:
	sPan		spCentre
	ssMod68k	$0A, $01, $10, $04
	sPatFM		$01
	sCall		ActClear_Call1
	dc.b nRst, $30
	ssMod68k	$00, $00, $00, $00
	sPatFM		$04

ActClear_Jump1:
	sCall		ActClear_Call2
	sJump		ActClear_Jump1

ActClear_Call1:
	saTranspose	$0C
	dc.b nD5, $06, nE5, nRst, nF5, nRst, nFs5, nRst
	dc.b nG5, nRst, nA5, nRst, nBb5, nRst, nB5, $0C
	dc.b sHold, $06, nE6, nE6, nRst, $12, nF6, $06
	dc.b nRst, nC7
	saTranspose	$F4
	sRet

ActClear_Call2:
	dc.b nC4, $03, nRst, $09, nFs5, $03, nRst, nG5
	dc.b nRst, $09, nG5, $03, nRst, nC4, nRst, nG5
	dc.b nRst, $09, nG5, $03, nRst, nC4, nRst, nG5
	dc.b nRst, $09, nG5, $03, nRst, $09, nG3, $03
	dc.b nRst, nC4, nRst, $09, nFs5, $03, nRst, nG5
	dc.b nRst, $09, nG5, $03, nRst, nC4, nRst, nG5
	dc.b nRst, $09, nG5, $03, nRst, nC4, nRst, nG5
	dc.b nRst, $09, nEb6, $06, nE6, nG5, nC4, $03
	dc.b nRst, $09, nFs5, $03, nRst, nG5, nRst, $09
	dc.b nG5, $03, nRst, nC4, nRst, nG5, nRst, $09
	dc.b nG5, $03, nRst, nC4, nRst, nG5, nRst, $09
	dc.b nG5, $03, nRst, $09, nG3, $03, nRst, nC4
	dc.b nRst, $09, nFs5, $03, nRst, nG5, nRst, $09
	dc.b nG5, $03, nRst, nC4, nRst, nG5, nRst, $09
	dc.b nEb6, $03, nRst, nE6, nRst, nFs5, nRst, nG5
	dc.b nRst, nEb5, nRst, nE5, nRst, nFs4, nRst
	sRet

ActClear_FM2:
	sPan		spCentre
	sPatFM		$00
	sCall		ActClear_Call3

ActClear_Jump2:
	sCall		ActClear_Call4
	sJump		ActClear_Jump2

ActClear_Call3:
	dc.b nD5, $06, nE5, nRst, nF5, nRst, nFs5, nRst
	dc.b nG5, nRst, nA5, nRst, nBb5, nRst, nB5, $0C
	dc.b sHold, $06, nC5, nC5, nRst, $12, nF5, $06
	dc.b nRst, nC5, nRst, $30
	sRet

ActClear_Call4:
	dc.b nC5, $0C, nRst, $06, nC5, $03, nRst, $09
	dc.b nC5, $03, nRst, $09, nC5, $03, nRst, $09
	dc.b nC5, $03, nRst, $09, nC5, $03, nRst, nC5
	dc.b $06, nG4, nA4, nG4, nC5, $0C, nRst, $06
	dc.b nC5, $03, nRst, $09, nC5, $03, nRst, $09
	dc.b nC5, $03, nRst, $09, nC5, $03, nRst, $09
	dc.b nD5, $06, nE5, nC5, nA4, nG4
	sRet

ActClear_FM3:
	sPan		spCentre
	ssMod68k	$0A, $01, $10, $04
	sPatFM		$01
	sCall		ActClear_Call5
	ssMod68k	$00, $00, $00, $00
	saVolFM		$F0
	sPatFM		$03
	saTranspose	$F7

ActClear_Jump3:
	sPan		spLeft, $00
	dc.b nA5, $06
	saVolFM		$0A
	dc.b $06
	saVolFM		$F6
	dc.b nEb6, nRst, $0C, nEb6, $06, nA5
	sPan		spRight, $00
	dc.b nCs5, nCs5
	sPan		spLeft, $00
	saVolFM		$0A
	dc.b nA5
	saVolFM		$F6
	dc.b nEb6, nRst, nEb6, nA5, nRst
	sPan		spRight, $00
	dc.b nCs5
	sJump		ActClear_Jump3

ActClear_Call5:
	dc.b nA5, $06, nC6, nRst, nC6, nRst, nC6, nRst
	dc.b nE6, nRst, nF6, nRst, nF6, nRst, nG6, $0C
	dc.b sHold, $06, nC7, nC7, nRst, $12, nC7, $06
	dc.b nRst, nG7, nRst, $30
	sRet

ActClear_FM4:
	sPan		spCentre
	ssMod68k	$0A, $01, $10, $04
	sPatFM		$01
	sCall		ActClear_Call6
	ssMod68k	$00, $00, $00, $00
	sPatFM		$04

ActClear_Jump4:
	sCall		ActClear_Call7
	sJump		ActClear_Jump4

ActClear_Call6:
	dc.b nF5, $06, nG5, nRst, nA5, nRst, nA5, nRst
	dc.b nC6, nRst, nC6, nRst, nD6, nRst, nD6, $0C
	dc.b sHold, $06, nG6, nG6, nRst, $12, nA6, $06
	dc.b nRst, nE7, nRst, $30
	sRet

ActClear_Call7:
	dc.b nRst, $0C, nEb5, $03, nRst, nE5, nRst, $09
	dc.b nE5, $03, nRst, $09, nE5, $03, nRst, $09
	dc.b nE5, $03, nRst, $09, nE5, $03, nRst, $09
	dc.b nE5, $03, nRst, $0F, nRst, $0C, nEb5, $03
	dc.b nRst, nE5, nRst, $09, nE5, $03, nRst, $09
	dc.b nE5, $03, nRst, $09, nE5, $03, nRst, $09
	dc.b nE5, $03, nRst, $1B, nRst, $0C, nEb5, $03
	dc.b nRst, nE5, nRst, $09, nE5, $03, nRst, $09
	dc.b nE5, $03, nRst, $09, nE5, $03, nRst, $09
	dc.b nE5, $03, nRst, $09, nE5, $03, nRst, $0F
	dc.b nRst, $0C, nEb5, $03, nRst, nE5, nRst, $09
	dc.b nE5, $03, nRst, $09, nE5, $03, nRst, $33
	sRet

ActClear_FM5:
	sPan		spCentre
	ssMod68k	$0A, $01, $10, $04
	dc.b nRst, $03
	saVolFM		$12
	sPan		spLeft, $00
	sPatFM		$01
	sCall		ActClear_Call1
	dc.b nRst, $2D
	sPan		spCenter, $00
	saVolFM		$EE
	ssMod68k	$00, $00, $00, $00

ActClear_Jump5:
	sPatFM		$02
	sCall		ActClear_Call8
	sJump		ActClear_Jump5

ActClear_Call8:
	dc.b nC3, $06, $06
	saVolFM		$F6
	dc.b $06, $06
	saVolFM		$0A
	dc.b $06, $06
	saVolFM		$F6
	dc.b $06, $06
	saVolFM		$0A
	dc.b $06, $06
	saVolFM		$F6
	dc.b $06, $06
	saVolFM		$0A
	dc.b $06, $06
	saVolFM		$F6
	dc.b $06, $06
	saVolFM		$0A
	sRet

ActClear_PSG1:
	sStop

ActClear_PSG2:
	sStop

ActClear_PSG3:
	sNoisePSG	$E7
	saVol	$FC
	sVoice	VolEnv_10
	dc.b nRst, $06, $06, $06, nFs5, nRst, nFs5, nRst
	dc.b nFs5, nRst, nFs5, nRst, nFs5, nRst, nFs5, $0C
	dc.b nRst, $06
	saVol	$04
	dc.b nRst, $60

ActClear_Jump6:
	sVoice	VolEnv_13
	dc.b nFs5, $06, $06
	saVol	$FD
	sVoice	VolEnv_10
	dc.b $06
	saVol	$03
	sVoice	VolEnv_02
	dc.b $06
	sJump		ActClear_Jump6

d81 =	dKick
d99 =	dHiTom
d9B =	dHiTom

ActClear_DAC1:
	sPan		spCentre
	sCall		ActClear_Call9

ActClear_Jump7:
	sCall		ActClear_Call10
	sCall		ActClear_Call11
	sJump		ActClear_Jump7

ActClear_Call9:
	dc.b d97, $06, $06, $06, d81, d97, d81, d97
	dc.b d81, d97, d81, d97, d81, d97, d81, d97
	dc.b d97, nRst, $0C, d9B, $03, $03, d99, $06
	dc.b d97, d97, d81, d97, d81, $06, d97, d9B
	dc.b d9B, d99, d99, d81, d97
	sRet

ActClear_Call10:
	dc.b d81, $06, nRst, $0C, d97, $06, d81, nRst
	dc.b d99, d81, d81, d97, nRst, d9B, d81, nRst
	dc.b d99, d81
	sRet

ActClear_Call11:
	dc.b d81, $06, nRst, $0C, d97, $06, d81, nRst
	dc.b d99, d81, d81, d9B, $03, $03, $06, d99
	dc.b d81, d97, d99, d81
	sRet

ActClear_DAC2:
	sStop
