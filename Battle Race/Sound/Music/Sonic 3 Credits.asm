Sonic3Credits_Header:
	sHeaderInit	; Z80 offset is $E587
	sHeaderPatch	Sonic3Credits_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $0C
	sHeaderDAC	Sonic3Credits_DAC
	sHeaderFM	Sonic3Credits_FM1, $00, $06
	sHeaderFM	Sonic3Credits_FM2, $00, $0A
	sHeaderFM	Sonic3Credits_FM3, $00, $17
	sHeaderFM	Sonic3Credits_FM4, $0C, $18
	sHeaderFM	Sonic3Credits_FM5, $0C, $1B
	sHeaderPSG	Sonic3Credits_PSG1, $DC, $03, $00, VolEnv_1B
	sHeaderPSG	Sonic3Credits_PSG2, $E8, $03, $00, VolEnv_1B
	sHeaderPSG	Sonic3Credits_PSG3, $0A, $03, $00, VolEnv_1B

Sonic3Credits_FM1:
	sPatFM		$00

Sonic3Credits_Loop8:
	sCall		Sonic3Credits_Call12
	sLoop		$00, $04, Sonic3Credits_Loop8
	sCall		Sonic3Credits_Call13

Sonic3Credits_Jump7:
	dc.b nRst, $60, nRst
Sonic3Credits_Loop9:
	sPatFM		$00
	sCall		Sonic3Credits_Call12
	sLoop		$00, $04, Sonic3Credits_Loop9
	sCall		Sonic3Credits_Call13
	sJump		Sonic3Credits_Jump7
	; Unused
	dc.b $E6, $09, $A1, $60, $A1, $E6, $F7, $EF
	dc.b $00, $F8, $E6, $E5, $F6, $E0, $E5

Sonic3Credits_Call12:
	dc.b nEb2, $06, nRst, $24, nEb2, $06, nEb2, nRst
	dc.b $2A, nCs2, $06, nRst, $18, nCs2, $06, nRst
	dc.b $18, nCs2, $06, nRst, $1E, nFs2, $06, nRst
	dc.b $24, nFs2, $06, nFs2, nRst, $2A, nAb2, $06
	dc.b nRst, $18, nAb2, $06, nRst, $18, nAb2, $06
	dc.b nRst, $1E
	sRet

Sonic3Credits_Call13:
	ssModZ80	$18, $02, $0A, $02
	sPatFM		$02
	saVolFM		$0A
	dc.b nAb2, $60, nFs2, nF2, nFs2, nAb2, $5A, nFs2
	dc.b $06, sHold, $60, nF2, $60, nE2, $5A, nA2
	dc.b $06, sHold, $60, nD2, $60, nG2
	saVolFM		$F6
	sRet

Sonic3Credits_FM2:
	sPatFM		$01
	sNoteTimeOut	$03

Sonic3Credits_Jump6:
	sPan		spLeft, $00

Sonic3Credits_Loop7:
	sCall		Sonic3Credits_Call8
	sLoop		$00, $02, Sonic3Credits_Loop7
	sCall		Sonic3Credits_Call9
	sCall		Sonic3Credits_Call10
	sCall		Sonic3Credits_Call9
	sCall		Sonic3Credits_Call9
	sCall		Sonic3Credits_Call10
	dc.b nE2, nEb4, nAb3, nE3, nEb4, nAb3, nE3, nEb4
	dc.b nE3, nEb4, nAb3, nE3, nEb4, nE3, nAb3, nA2
	dc.b nCs4, nAb3, nA2, nCs4, nA2, nCs4, nAb3, nA2
	dc.b nCs4, nA2, nAb3, nA2, nCs4, nAb3, nA2, nCs4
	dc.b nD2, nCs4, nFs3, nD2, nCs4, nD2, nFs3, nD2
	dc.b nCs4, nFs3, nD2, nCs4, nD2, nCs4, nFs3, nG2
	dc.b nB3, nFs3, nG2, nB3, nFs3, nG2, nB3, nFs3
	dc.b nG2, nB3, nFs3, nG2, nB3, nG2, nFs3, nB3
	sPan		spCenter, $00
	saVolFM		$04
	sCall		Sonic3Credits_Call11
	dc.b nEb4
	saVolFM		$FF
	sJump		Sonic3Credits_Jump6
	; Unused
	dc.b $F8, $FD, $E6, $F6, $9D, $E6

Sonic3Credits_Call11:
	dc.b nBb2, $06, nEb4, nAb3, nBb2, nEb4, nAb3, nBb2
	dc.b nEb4
	saVolFM		$FF
	dc.b nBb2, nEb4, nAb3, nBb2, nEb4, nBb2, nBb3, nBb2
	saVolFM		$FF
	dc.b nEb4, nAb3, nBb2, nEb4, nBb2, nEb4, nAb3, nBb2
	saVolFM		$FF
	dc.b nEb4, nBb2, nAb3, nBb2, nEb4, nBb2, nAb3
	sRet

Sonic3Credits_Call9:
	dc.b nAb2, $06, nBb3, nAb3, nAb3, nC4, nAb3, nAb3
	dc.b nCs4, nAb3, nAb3, nEb4, nAb3, nAb3, nAb2, nCs4
	dc.b nAb3
	sRet

Sonic3Credits_Call10:
	dc.b nFs2, nBb3, nAb3, nFs3, nC4, nAb3, nFs3, nCs4
	dc.b nAb3, nFs3, nEb4, nFs3, nAb3, nFs3, nCs4, nAb3
	dc.b nF2, nBb3, nAb3, nF3, nC4, nAb3, nF3, nCs4
	dc.b nAb3, nF3, nEb4, nF3, nAb3, nF3, nCs4, nAb3
	sRet

Sonic3Credits_Call8:
	dc.b nEb2, $06, nBb3, nG3, nEb3, nEb4, nG3, nEb3
	dc.b nBb3, nG3, nEb3, nEb4, nEb3, nG3, nEb3, nBb3
	dc.b nG3, nCs2, nEb4, nCs3, nEb4, nF3, nCs3, nCs4
	dc.b nCs3, nF3, nCs3, nAb3, nCs3, nF3, nCs3, nAb3
	dc.b nF3, nFs2, nAb3, nCs3, nAb3, nFs3, nCs3, nBb3
	dc.b nCs3, nFs3, nCs3, nCs4, nCs3, nFs3, nCs3, nBb3
	dc.b nFs3, nAb2, nC4, nEb3, nC4, nAb3, nEb3, nCs4
	dc.b nEb3, nAb3, nEb3, nEb4, nEb3, nAb3, nEb3, nCs4
	dc.b nAb3, nEb2, nBb3, nG3, nEb3, nEb4, nG3, nBb2
	dc.b nBb3, nG3, nEb3, nEb4, nBb2, nG3, nEb3, nBb3
	dc.b nG3, nCs2, nEb4, nF3, nCs3, nCs4, nF3, nAb2
	dc.b nAb3, nF3, nCs3, nCs4, nAb2, nF3, nCs3, nAb3
	dc.b nF3, nAb1, nAb3, nFs3, nFs2, nBb3, nFs3, nBb1
	dc.b nCs4, nFs3, nCs3, nBb3, nFs3, nFs3, nFs3, nAb3
	dc.b nFs3, nAb1, nBb3, nAb3, nAb2, nC4, nAb3, nC3
	dc.b nCs4, nAb3, nEb3, nEb4, nEb3, nAb3, nEb3, nCs4
	dc.b nAb3
	sRet

Sonic3Credits_FM3:
Sonic3Credits_Jump3:
	sPatFM		$02
	ssModZ80	$48, $01, $06, $02
	sCall		Sonic3Credits_Call2
	dc.b nBb3, $24, nEb4, nBb4, $18, nAb4, $60, sHold
	dc.b $60, sHold, $60
	sCall		Sonic3Credits_Call2
	dc.b $60, nF4, nFs4, $30, nAb4, nAb4, $60
	sCall		Sonic3Credits_Call3

Sonic3Credits_Jump4:
	dc.b nRst, $60, nRst
	sCall		Sonic3Credits_Call4
	sCall		Sonic3Credits_Call5
	sCall		Sonic3Credits_Call2
	dc.b nBb3, $24, nEb4, nBb4, $18, nAb4, $60, sHold
	dc.b $60, sHold, $60
	sCall		Sonic3Credits_Call3
	sJump		Sonic3Credits_Jump4
	; Unused
	dc.b $C0, $60, $E7, $60, $F8, $D8, $E7, $F8
	dc.b $F7, $E7, $F6, $C2, $E7

Sonic3Credits_Call2:
	dc.b nRst, $30, nEb4, $60, nCs4, nEb4, $30, nC4
	dc.b $24, nCs4, nEb4, $18
	sRet

Sonic3Credits_Call4:
	dc.b nEb4, $24, nF4, nG4, $18, nBb4, $24, nAb4
	dc.b nF4, $18, nFs4, $24, nBb4, $24, nCs5, $18
	dc.b nC5, $24, nAb4, nEb4, $3C, nG4, $24, nBb4
	dc.b $18, nAb4, $24, nF4, nCs4, $18
	sRet

Sonic3Credits_Call5:
	dc.b nBb4, $24, nCs5, nFs5, $18, nEb5, $24, nC5
	dc.b nAb4, $18
	sRet

Sonic3Credits_Call3:
Sonic3Credits_Loop3:
	dc.b nC5, $24, nCs5, nC5, $18, sHold
	sLoop		$00, $03, Sonic3Credits_Loop3
	dc.b nC5, $24, nBb4, nAb4, $18

Sonic3Credits_Loop4:
	dc.b sHold, nC5, $24, nCs5, nC5, $18
	sLoop		$00, $02, Sonic3Credits_Loop4
	dc.b nEb5, $60, nAb5, sHold, $60, nFs5, sHold, $60
	sRet

Sonic3Credits_FM4:
	sPan		spRight, $00
	sPatFM		$02
	sCall		Sonic3Credits_Call6
	dc.b nG3, nF3, nFs3, nAb3, nG3, nAb3, nBb3, nC4
	sCall		Sonic3Credits_Call7

Sonic3Credits_Jump5:
	dc.b nRst, $02, nRst, $60, nRst
	saTranspose	$F4
	sCall		Sonic3Credits_Call4
	saTranspose	$0C
	dc.b nFs3, $24, nBb3, nCs4, $18, nC4, $24, nAb3
	dc.b nEb3, $18
	sCall		Sonic3Credits_Call6
	sCall		Sonic3Credits_Call7
	sJump		Sonic3Credits_Jump5
	; Unused
	dc.b $AF, $60, $B1, $FB, $F4, $F8, $D8, $E7
	dc.b $FB, $0C, $E6, $FD, $AB, $24, $AF, $B2
	dc.b $18, $B1, $24, $AD, $A8, $18, $E6, $03
	dc.b $F6, $5A, $E8

Sonic3Credits_Call6:
	dc.b nG3, $60, nF3, nFs3, nAb3, nEb3, nCs3, nFs3
	dc.b nC3
	sRet

Sonic3Credits_Call7:
Sonic3Credits_Loop5:
	dc.b nEb4, $24, nF4, nEb4, $18, sHold
	sLoop		$00, $03, Sonic3Credits_Loop5
	dc.b nEb4, $24, nCs4, $3C

Sonic3Credits_Loop6:
	dc.b nEb4, $24, nF4, nEb4, $18, sHold
	sLoop		$00, $02, Sonic3Credits_Loop6
	dc.b nAb4, $60, sHold, $60, nCs5, sHold, $60, nB4
	dc.b $60
	sRet

Sonic3Credits_FM5:
	sPan		spCenter, $00
	dc.b nRst, $04
	saDetune	$03
	sJump		Sonic3Credits_Jump3
	; Unused
	dc.b $F2

Sonic3Credits_PSG1:
Sonic3Credits_Jump2:
Sonic3Credits_Loop1:
	sCall		Sonic3Credits_Call1
	sLoop		$00, $02, Sonic3Credits_Loop1

Sonic3Credits_Loop2:
	dc.b nRst, $60
	sLoop		$00, $0D, Sonic3Credits_Loop2
	sJump		Sonic3Credits_Jump2
	; Unused
	dc.b $F8, $C2, $E8, $F6, $BC, $E8

Sonic3Credits_Call1:
	dc.b nEb4, $0C, nBb4, nEb4, $06, nEb4, nBb4, nEb4
	dc.b nRst, $24, nCs4, $0C, nAb4, $06, nCs4, nCs4
	dc.b $0C, nAb4, $06, nCs4, nCs4, nAb4, nRst, $30
	dc.b nFs4, $06, nFs4, nCs5, nFs4, nFs4, nFs4, nCs5
	dc.b nFs4, nRst, $24, nAb4, $06, nAb4, nEb5, $0C
	dc.b nAb4, $06, nAb4, nEb5, nAb4, nAb4, nAb5, nAb4
	dc.b nAb5, nAb4, nAb4, nEb5, nAb4, nAb4, nEb4, nBb4
	dc.b nEb4, $0C, nEb5, $06, nEb4, nEb5, nEb4, nEb4
	dc.b nBb4, nRst, $1E, nEb4, $0C, nAb4, $06, nCs4
	dc.b $0C, nCs5, $06, nCs4, nCs5, nCs4, nCs4, nAb4
	dc.b $0C, nCs4, $06, nCs4, nAb4, nCs4, nCs4, nCs4
	dc.b nFs4, nFs4, nCs5, nFs4, nFs4, nFs4, nCs5, nFs4
	dc.b nRst, $24, nAb4, $06, nAb4, nEb5, $12, nAb4
	dc.b $06, nAb5, nAb4, nAb4, nEb5, nAb4, nAb5, nAb4
	dc.b nRst, $1E
	sRet

Sonic3Credits_PSG2:
	dc.b nRst, $01
	sJump		Sonic3Credits_Jump2

Sonic3Credits_PSG3:
	sNoisePSG	$E7
	dc.b nRst, $60, nRst, nRst, nRst
	sNoteTimeOut	$03

Sonic3Credits_Jump1:
	dc.b nRst, $0C, nCs6, $06, nCs6
	sJump		Sonic3Credits_Jump1

Sonic3Credits_DAC:
	dc.b nRst, $60, nRst, $48, dMetalCrashHit, $18, dKickHey, $60
	dc.b dKickHey, $2A, nRst, $12, dKickHey, dKickHey
Sonic3Credits_Loop10:
	dc.b dKickHey, $18, dOddSnareKick, dKickExtraBass, dOddSnareKick
	sLoop		$00, $03, Sonic3Credits_Loop10
	dc.b dKickHey, $18, dOddSnareKick, $12, nRst, $12, dKickHey, dKickHey
	sLoop		$01, $05, Sonic3Credits_Loop10

Sonic3Credits_Loop11:
	dc.b dKickHey, $18, dOddSnareKick, dKickExtraBass, dOddSnareKick
	sLoop		$00, $04, Sonic3Credits_Loop11
	dc.b dKickHey, $18, dOddSnareKick, $12, nRst, $12, dKickHey, dKickHey

Sonic3Credits_Loop12:
Sonic3Credits_Jump8:
	dc.b dKickHey, $18, dOddSnareKick, dKickExtraBass, dOddSnareKick
	sLoop		$00, $03, Sonic3Credits_Loop12
	dc.b dKickHey, $18, dOddSnareKick, $12, nRst, $12, dKickHey, dKickHey

Sonic3Credits_Loop13:
	dc.b dKickHey, $18, dOddSnareKick, dKickExtraBass, dOddSnareKick
	sLoop		$00, $03, Sonic3Credits_Loop13
	dc.b dKickHey, $18, dOddSnareKick, $12, nRst, $12, dKickHey, dKickHey
	sLoop		$01, $05, Sonic3Credits_Loop13

Sonic3Credits_Loop14:
	dc.b dKickHey, $18, dOddSnareKick, dKickExtraBass, dOddSnareKick
	sLoop		$00, $04, Sonic3Credits_Loop14
	dc.b dKickHey, $18, dOddSnareKick, $12, nRst, $12, dKickHey, dKickHey
	sJump		Sonic3Credits_Jump8
	; Unused
	dc.b $C0, $18, $A3, $A4, $A3, $F7, $00, $03
	dc.b $C0, $E9, $C0, $18, $A3, $12, $80, $12
	dc.b $C0, $C0, $F6, $C0, $E9

Sonic3Credits_Patches:
	; Patch $00
	; $12
	; $37, $31, $30, $30,	$9E, $DC, $1C, $9C
	; $0D, $06, $04, $01,	$08, $0A, $03, $05
	; $B6, $B6, $36, $26,	$2C, $33, $14, $80
	spAlgorithm	$02
	spFeedback	$02
	spDetune	$03, $03, $03, $03
	spMultiple	$07, $00, $01, $00
	spRateScale	$02, $00, $03, $02
	spAttackRt	$1E, $1C, $1C, $1C
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$08, $03, $0A, $05
	spSustainRt	$0D, $04, $06, $01
	spSustainLv	$0B, $03, $0B, $02
	spReleaseRt	$06, $06, $06, $06
	spTotalLv	$2C, $14, $33, $00

	; Patch $01
	; $1C
	; $3B, $01, $31, $31,	$1F, $1B, $1E, $1E
	; $0F, $07, $06, $07,	$00, $0A, $00, $00
	; $8A, $8A, $8A, $8A,	$26, $8C, $18, $80
	spAlgorithm	$04
	spFeedback	$03
	spDetune	$03, $03, $00, $03
	spMultiple	$0B, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1E, $1B, $1E
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $0A, $00
	spSustainRt	$0F, $06, $07, $07
	spSustainLv	$08, $08, $08, $08
	spReleaseRt	$0A, $0A, $0A, $0A
	spTotalLv	$26, $18, $0C, $00

	; Patch $02
	; $3A
	; $63, $60, $50, $32,	$4F, $4F, $4F, $48
	; $04, $04, $04, $05,	$03, $01, $01, $01
	; $18, $18, $15, $17,	$1E, $1F, $1D, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$06, $05, $06, $03
	spMultiple	$03, $00, $00, $02
	spRateScale	$01, $01, $01, $01
	spAttackRt	$0F, $0F, $0F, $08
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$03, $01, $01, $01
	spSustainRt	$04, $04, $04, $05
	spSustainLv	$01, $01, $01, $01
	spReleaseRt	$08, $05, $08, $07
	spTotalLv	$1E, $1D, $1F, $00
