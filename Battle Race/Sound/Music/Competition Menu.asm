CompetitionMenu_Header:
	sHeaderInit	; Z80 offset is $F5E4
	sHeaderPatch	CompetitionMenu_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $4A
	sHeaderDAC	CompetitionMenu_DAC
	sHeaderFM	CompetitionMenu_FM1, $00, $03
	sHeaderFM	CompetitionMenu_FM2, $F4, $00
	sHeaderFM	CompetitionMenu_FM3, $00, $05
	sHeaderFM	CompetitionMenu_FM4, $00, $05
	sHeaderFM	CompetitionMenu_FM5, $00, $05
	sHeaderPSG	CompetitionMenu_PSG1, $E8, $00, $00, VolEnv_0F
	sHeaderPSG	CompetitionMenu_PSG2, $E8, $01, $00, VolEnv_0F
	sHeaderPSG	CompetitionMenu_PSG3, $2E, $00, $00, VolEnv_0D

CompetitionMenu_FM1:
	sPatFM		$00

CompetitionMenu_Loop5:
CompetitionMenu_Jump7:
	dc.b nE3, $06, nRst, $1E, nE3, $06, nD3, $12
	dc.b nB2, $06, nRst, nA2, nRst, nRst, nRst
	sLoop		$00, $08, CompetitionMenu_Loop5
	dc.b nE3, $06, nRst, $36, nB2, $06, nD3, $12
	dc.b nE3, $06, nRst, nFs3, $06, nRst, $2A, nCs3
	dc.b $06, nCs3, nE3, nFs3, nRst, $18, nB2, $06
	dc.b nRst, $36, nFs2, $06, nA2, $12, nB2, $06
	dc.b nRst, nB2, $06, nRst, $24, nD2, $06, nD3
	dc.b nRst, nCs3, nRst, nB2, nRst, nA2, nRst, nE2
	dc.b $06, nRst, $36, nB1, $06, nD2, nB1, nE2
	dc.b nB1, nRst, nFs2, $06, nRst, $2A, nCs2, $06
	dc.b nCs2, nE2, nFs2, $1E, nB2, $06, nRst, $36
	dc.b nFs2, $06, nA2, $12, nB2, $06, nRst, nB2
	dc.b $06, nRst, $12, nRst, $0C, nB2, nA2, nRst
	dc.b nRst, nRst

CompetitionMenu_Loop6:
	dc.b nE3, $06, nRst, $1E, nE3, $06, nD3, $12
	dc.b nB2, $06, nRst, nA2, nRst, nRst, nRst
	sLoop		$00, $08, CompetitionMenu_Loop6
	sJump		CompetitionMenu_Jump7
	; Unused
	dc.b $F2

CompetitionMenu_FM2:
CompetitionMenu_Jump6:
	sCall		CompetitionMenu_Call9
	sPatFM		$06
	dc.b nG0, $60, nRst
	sPatFM		$07
	dc.b nE5, $0D
	saVolFM		$08
	dc.b nE5, $0B, nRst, $48
	saVolFM		$F8
	dc.b nE5, $0D
	saVolFM		$08
	dc.b nE5, $0B, nRst, $48
	saVolFM		$F8
	sPatFM		$06
	dc.b nG0, $60, nRst
	sPatFM		$07
	dc.b nE5, $0D
	saVolFM		$08
	dc.b nE5, $0B, nRst, $48
	saVolFM		$F8
	dc.b nE5, $0D
	saVolFM		$08
	dc.b nE5, $0B, nRst, $48
	saVolFM		$F8
	sCall		CompetitionMenu_Call9
	sJump		CompetitionMenu_Jump6
	; Unused
	dc.b $F2

CompetitionMenu_Call9:
	sPatFM		$06
	dc.b nC4, $60, nRst
	sPatFM		$07
	dc.b nE5, $0D
	saVolFM		$08
	dc.b nE5, $0B, nRst, $48
	saVolFM		$F8
	dc.b nRst, $60
	sPatFM		$06
	dc.b nRst, $06, nC4, $5A, nRst, $60
	sPatFM		$07
	dc.b nE5, $0D
	saVolFM		$08
	dc.b nE5, $0B, nRst, $48
	saVolFM		$F8
	dc.b nRst, $60
	sRet

CompetitionMenu_FM3:
	sPan		spLeft, $00
	saDetune	$01

CompetitionMenu_Jump5:
	sCall		CompetitionMenu_Call8
	sPatFM		$02
	dc.b nG3, $60, nA3, $24, nE3, $3C, nA3, $60
	dc.b nA3, nG3, $60, nA3, $24, nE3, $3C, nA3
	dc.b $60, nA3, $48, nCs4, $18
	sCall		CompetitionMenu_Call8
	sJump		CompetitionMenu_Jump5
	; Unused
	dc.b $F2

CompetitionMenu_Call8:
	sPatFM		$03
	dc.b nRst, $24, nA3, $3C, sHold, $3C
	sPatFM		$01
	sNoteTimeOut	$06
	dc.b nG5, $06, nG5
	saVolFM		$10
	dc.b nG5, nRst
	saVolFM		$F0
	dc.b nA5, nRst
	sNoteTimeOut	$00
	sPatFM		$03
	dc.b nA3, $60, sHold, $54
	sPatFM		$05
	ssModZ80	$01, $01, $03, $06
	dc.b nE5, $12
	sModOff
	sPatFM		$03
	dc.b nRst, $1E, nA3, $3C, sHold, $3C
	sPatFM		$01
	sNoteTimeOut	$06
	dc.b nG5, $06, nG5
	saVolFM		$10
	dc.b nG5, nRst
	saVolFM		$F0
	dc.b nA5, nRst
	sNoteTimeOut	$00
	sPatFM		$03
	dc.b nA3, $60, sHold, $60
	sRet

CompetitionMenu_FM4:
	sPan		spRight, $00

CompetitionMenu_Jump4:
	sCall		CompetitionMenu_Call7
	sPatFM		$02
	dc.b nB3, $60, nE4, nD4, nD4, nB3, $60, nE4
	dc.b nCs4, nD4, $48, nE4, $18
	sCall		CompetitionMenu_Call7
	sJump		CompetitionMenu_Jump4
	; Unused
	dc.b $F2

CompetitionMenu_Call7:
	sPatFM		$03
	dc.b nRst, $24, nB3, $3C, sHold, $3C
	sPatFM		$01
	sNoteTimeOut	$06
	dc.b nG4, $06, nG4
	saVolFM		$10
	dc.b nG4, nRst
	saVolFM		$F0
	dc.b nA4, nRst
	sNoteTimeOut	$00
	sPatFM		$03
	dc.b nB3, $60, sHold, $54
	sPatFM		$05
	ssModZ80	$01, $01, $03, $06
	dc.b nG5, $12
	sModOff
	sPatFM		$03
	dc.b nRst, $1E, nB3, $3C, sHold, $3C
	sPatFM		$01
	sNoteTimeOut	$06
	dc.b nG4, $06, nG4
	saVolFM		$10
	dc.b nG4, nRst
	saVolFM		$F0
	dc.b nA4, nRst
	sNoteTimeOut	$00
	sPatFM		$03
	dc.b nB3, $60, sHold, $60
	sRet

CompetitionMenu_FM5:
CompetitionMenu_Jump3:
	sCall		CompetitionMenu_Call6
	sPatFM		$02
	dc.b nD4, $3C, nG4, $12, nA4, nA4, $60, nA4
	dc.b nA4, nD4, $3C, nG4, $12, nA4, nA4, $60
	dc.b nE4, nA4, $48, nCs5, $18
	sCall		CompetitionMenu_Call6
	sJump		CompetitionMenu_Jump3
	; Unused
	dc.b $F2

CompetitionMenu_Call6:
CompetitionMenu_Loop4:
	sPatFM		$03
	dc.b nRst, $24, nD4, $3C, sHold, $60, nE4, sHold
	dc.b nE4
	sLoop		$00, $02, CompetitionMenu_Loop4
	sRet

CompetitionMenu_PSG1:
	dc.b nRst, $01
	saDetune	$FF

CompetitionMenu_PSG2:
	sVolEnvPSG	VolEnv_1F

CompetitionMenu_Jump2:
	sCall		CompetitionMenu_Call5
	sCall		CompetitionMenu_Call5
	dc.b nRst, $60, nRst, nRst, nRst, $18, nD5, nE5
	dc.b $03, nFs5, $15, nD5, $18, nG4, $03, nA4
	dc.b $2D, nRst, $30, nRst, $18, nA4, $12, nG4
	dc.b $06, nFs4, $18, nA4, nE4, $24, nRst, $3C
	dc.b nRst, $60
	sCall		CompetitionMenu_Call5

CompetitionMenu_Loop3:
	dc.b nRst, $18, nD5, $0C, nB4, $06, nRst, nG4
	dc.b $0C, nB4, $06, nRst, nD5, $0C, nB4, $06
	dc.b nRst
	sLoop		$00, $02, CompetitionMenu_Loop3
	dc.b nRst, $18, nE5, $0C, nB4, $06, nRst, nG4
	dc.b $0C, nB4, $06, nRst, nE5, $0C, nB4, $06
	dc.b nRst, nRst, $60
	sJump		CompetitionMenu_Jump2
	; Unused
	dc.b $F2

CompetitionMenu_Call5:
CompetitionMenu_Loop1:
	dc.b nRst, $18, nD5, $0C, nB4, $06, nRst, nG4
	dc.b $0C, nB4, $06, nRst, nD5, $0C, nB4, $06
	dc.b nRst
	sLoop		$00, $02, CompetitionMenu_Loop1

CompetitionMenu_Loop2:
	dc.b nRst, $18, nE5, $0C, nB4, $06, nRst, nG4
	dc.b $0C, nB4, $06, nRst, nE5, $0C, nB4, $06
	dc.b nRst
	sLoop		$00, $02, CompetitionMenu_Loop2
	sRet

CompetitionMenu_PSG3:
	sNoisePSG	$E7
	sVolEnvPSG	VolEnv_1E

CompetitionMenu_Jump1:
	sCall		CompetitionMenu_Call1
	sCall		CompetitionMenu_Call2
	sCall		CompetitionMenu_Call3
	sCall		CompetitionMenu_Call2
	sCall		CompetitionMenu_Call4
	sCall		CompetitionMenu_Call4
	sCall		CompetitionMenu_Call1
	sCall		CompetitionMenu_Call2
	sCall		CompetitionMenu_Call1
	sCall		CompetitionMenu_Call1
	sCall		CompetitionMenu_Call1
	sCall		CompetitionMenu_Call1
	sCall		CompetitionMenu_Call4
	sCall		CompetitionMenu_Call3
	sCall		CompetitionMenu_Call3
	sCall		CompetitionMenu_Call2
	sCall		CompetitionMenu_Call1
	sCall		CompetitionMenu_Call4
	sCall		CompetitionMenu_Call1
	sCall		CompetitionMenu_Call1
	sCall		CompetitionMenu_Call4
	sCall		CompetitionMenu_Call3
	sCall		CompetitionMenu_Call1
	sCall		CompetitionMenu_Call4
	sJump		CompetitionMenu_Jump1
	; Unused
	dc.b $F2

CompetitionMenu_Call1:
	sVolEnvPSG	VolEnv_1E
	saVolPSG	$02
	dc.b nC3, $0C
	saVolPSG	$FE
	dc.b nC3, nC3
	saVolPSG	$02
	dc.b nC3
	saVolPSG	$FE
	dc.b nC3
	saVolPSG	$02
	dc.b nC3, nC3
	saVolPSG	$FE
	sVolEnvPSG	$27
	dc.b nC3, $06, nRst
	sRet

CompetitionMenu_Call2:
	sVolEnvPSG	VolEnv_1E
	saVolPSG	$02
	dc.b nC3, $0C
	saVolPSG	$FE
	dc.b nC3, nC3
	saVolPSG	$02
	dc.b nC3
	saVolPSG	$FE
	dc.b nC3
	saVolPSG	$02
	dc.b nC3, nC3
	saVolPSG	$FE
	dc.b nC3, $06, nC3
	sRet

CompetitionMenu_Call3:
	sVolEnvPSG	VolEnv_1E
	saVolPSG	$02
	dc.b nC3, $0C
	saVolPSG	$FE
	dc.b nC3, nC3
	saVolPSG	$02
	dc.b nC3
	saVolPSG	$FE
	dc.b nC3
	saVolPSG	$02
	dc.b nC3, nC3
	saVolPSG	$FE
	dc.b nC3, $06
	sVolEnvPSG	$27
	dc.b nC3
	sRet

CompetitionMenu_Call4:
	sVolEnvPSG	VolEnv_1E
	saVolPSG	$02
	dc.b nC3, $0C
	saVolPSG	$FE
	dc.b nC3, nC3
	saVolPSG	$02
	dc.b nC3
	saVolPSG	$FE
	dc.b nC3
	saVolPSG	$02
	dc.b nC3, nC3
	saVolPSG	$FE
	sVolEnvPSG	$27
	dc.b nC3
	sRet

CompetitionMenu_DAC:
CompetitionMenu_Loop7:
CompetitionMenu_Jump8:
	dc.b dKick, $06, nRst, nRst, nRst, dSnare, nRst, nRst
	dc.b dKick, dKick, nRst, dKick, nRst, dSnare, nRst, nRst
	dc.b nRst
	sLoop		$00, $03, CompetitionMenu_Loop7
	dc.b dKick, nRst, nRst, nRst, dSnare, nRst, nRst, dKick
	dc.b dKick, nRst, dKick, nRst, dSnare, nRst, dSnare, dSnare

CompetitionMenu_Loop8:
	dc.b dKick, $06, nRst, nRst, nRst, dSnare, nRst, nRst
	dc.b dKick, dKick, nRst, dKick, nRst, dSnare, nRst, nRst
	dc.b nRst
	sLoop		$00, $03, CompetitionMenu_Loop8
	dc.b dKick, nRst, dSnare, nRst, dSnare, nRst, nRst, dKick
	dc.b dKick, nRst, dSnare, dSnare, dSnare, nRst, dSnare, dSnare

CompetitionMenu_Loop9:
	dc.b dKick, nRst, nRst, nRst, dSnare, nRst, nRst, dKick
	dc.b dKick, nRst, dKick, nRst, dSnare, nRst, dKick, nRst
	sLoop		$00, $03, CompetitionMenu_Loop9
	dc.b dKick, nRst, nRst, nRst, dSnare, nRst, nRst, dKick
	dc.b dKick, nRst, dKick, nRst, dSnare, nRst, dSnare, dSnare
	sLoop		$01, $02, CompetitionMenu_Loop9

CompetitionMenu_Loop10:
	dc.b dKick, $06, nRst, nRst, nRst, dSnare, nRst, nRst
	dc.b dKick, dKick, nRst, dKick, nRst, dSnare, nRst, nRst
	dc.b nRst
	sLoop		$00, $03, CompetitionMenu_Loop10
	dc.b dKick, nRst, nRst, nRst, dSnare, nRst, nRst, dKick
	dc.b dKick, nRst, dKick, nRst, dSnare, nRst, dSnare, dSnare
	sLoop		$01, $02, CompetitionMenu_Loop10
	sJump		CompetitionMenu_Jump8
	; Unused
	dc.b $F2

CompetitionMenu_Patches:
	; Patch $00
	; $00
	; $27, $33, $30, $21,	$DF, $DF, $9F, $9F
	; $07, $06, $09, $06,	$07, $06, $06, $08
	; $20, $10, $10, $0F,	$19, $37, $10, $84
	spAlgorithm	$00
	spFeedback	$00
	spDetune	$02, $03, $03, $02
	spMultiple	$07, $00, $03, $01
	spRateScale	$03, $02, $03, $02
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$07, $06, $06, $08
	spSustainRt	$07, $09, $06, $06
	spSustainLv	$02, $01, $01, $00
	spReleaseRt	$00, $00, $00, $0F
	spTotalLv	$19, $10, $37, $04

	; Patch $01
	; $05
	; $30, $52, $01, $31,	$51, $53, $52, $53
	; $05, $00, $00, $00,	$00, $00, $00, $00
	; $1F, $0F, $0F, $0F,	$0C, $90, $90, $90
	spAlgorithm	$05
	spFeedback	$00
	spDetune	$03, $00, $05, $03
	spMultiple	$00, $01, $02, $01
	spRateScale	$01, $01, $01, $01
	spAttackRt	$11, $12, $13, $13
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$05, $00, $00, $00
	spSustainLv	$01, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0C, $10, $10, $10

	; Patch $02
	; $2E
	; $05, $77, $58, $02,	$1F, $1F, $14, $14
	; $00, $00, $00, $00,	$08, $0B, $09, $06
	; $0F, $0F, $0F, $0F,	$18, $90, $90, $90
	spAlgorithm	$06
	spFeedback	$05
	spDetune	$00, $05, $07, $00
	spMultiple	$05, $08, $07, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $14, $1F, $14
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$08, $09, $0B, $06
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$18, $10, $10, $10

	; Patch $03
	; $2C
	; $71, $62, $31, $32,	$5F, $54, $5F, $5F
	; $00, $09, $00, $09,	$00, $03, $00, $03
	; $0F, $8F, $0F, $AF,	$16, $8B, $11, $8B
	spAlgorithm	$04
	spFeedback	$05
	spDetune	$07, $03, $06, $03
	spMultiple	$01, $01, $02, $02
	spRateScale	$01, $01, $01, $01
	spAttackRt	$1F, $1F, $14, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $03, $03
	spSustainRt	$00, $00, $09, $09
	spSustainLv	$00, $00, $08, $0A
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$16, $11, $0B, $0B

	; Patch $04
	; $03
	; $02, $02, $02, $02,	$1F, $1F, $1F, $1F
	; $08, $08, $00, $0E,	$00, $00, $00, $05
	; $3F, $3F, $0F, $7F,	$81, $20, $1D, $82
	spAlgorithm	$03
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$02, $02, $02, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $05
	spSustainRt	$08, $00, $08, $0E
	spSustainLv	$03, $00, $03, $07
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$01, $1D, $20, $02

	; Patch $05
	; $04
	; $22, $02, $21, $02,	$18, $0B, $19, $08
	; $00, $05, $04, $00,	$00, $00, $00, $00
	; $0F, $FF, $4F, $0F,	$20, $90, $20, $88
	spAlgorithm	$04
	spFeedback	$00
	spDetune	$02, $02, $00, $00
	spMultiple	$02, $01, $02, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$18, $19, $0B, $08
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$00, $04, $05, $00
	spSustainLv	$00, $04, $0F, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$20, $20, $10, $08

	; Patch $06
	; $00
	; $38, $1C, $1E, $1F,	$1F, $1F, $1F, $1F
	; $00, $00, $00, $0C,	$00, $00, $00, $0C
	; $0F, $0F, $0F, $1F,	$00, $3D, $00, $88
	spAlgorithm	$00
	spFeedback	$00
	spDetune	$03, $01, $01, $01
	spMultiple	$08, $0E, $0C, $0F
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $0C
	spSustainRt	$00, $00, $00, $0C
	spSustainLv	$00, $00, $00, $01
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$00, $00, $3D, $08

	; Patch $07
	; $00
	; $70, $30, $13, $01,	$1F, $1F, $0E, $1F
	; $00, $0B, $0E, $00,	$08, $01, $10, $12
	; $0F, $1F, $FF, $0F,	$15, $1E, $94, $00
	spAlgorithm	$00
	spFeedback	$00
	spDetune	$07, $01, $03, $00
	spMultiple	$00, $03, $00, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $0E, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$08, $10, $01, $12
	spSustainRt	$00, $0E, $0B, $00
	spSustainLv	$00, $0F, $01, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$15, $14, $1E, $00
