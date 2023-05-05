Title_Header:
	sHeaderInit	; Z80 offset is $F88E
	sHeaderPatch	Title_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $00
	sHeaderDAC	Title_DAC
	sHeaderFM	Title_FM1, $00, $15
	sHeaderFM	Title_FM2, $0C, $1C
	sHeaderFM	Title_FM3, $00, $10
	sHeaderFM	Title_FM4, $00, $05
	sHeaderFM	Title_FM5, $00, $05
	sHeaderPSG	Title_PSG1, $E8, $05, $00, VolEnv_0A
	sHeaderPSG	Title_PSG2, $F4, $02, $00, VolEnv_0A
	sHeaderPSG	Title_PSG3, $E8, $05, $00, VolEnv_0A

Title_FM1:
	sPatFM		$04
	saDetune	$F6
	dc.b nRst, $6C
	ssModZ80	$2A, $01, $29, $00
	dc.b nE4, $3C, sHold
	ssModZ80	$01, $00, $00, $00
	dc.b nE4, $18
	sPatFM		$00
	saDetune	$00
	ssModZ80	$14, $01, $04, $07

Title_Jump1:
	dc.b nA4, $18, nFs4, $0C, nE4, nA4, nFs4, nD4
	dc.b nE4, $30, nD5, $18
	sNoteTimeOut	$06
	dc.b $0C, $0C, $0C
	sNoteTimeOut	$00
	dc.b nCs5, $18, nA4, $0C, nE4, nFs4, $04, nRst
	dc.b $08, nA4, $18, nB4, $0C, sHold, nB4, $30
	dc.b nRst, nA4, $18, nFs4, $0C, nE4, nA4, nFs4
	dc.b nD4, nE4, $30, nD5, $18, nCs5, $0C, nB4
	dc.b nA4, $0C
	sNoteTimeOut	$17
	saVolFM		$FE
	dc.b nCs5, $18
	sNoteTimeOut	$06
	dc.b nA4, $0C, $0C, nG4
	sNoteTimeOut	$00
	dc.b nG4, $18, nA4, $09
	sStop
	; Unused
	dc.b $F2

Title_FM2:
	sPatFM		$01
	ssModZ80	$15, $01, $06, $06
	dc.b nE1, $06, nE1, nRst, nE1, nRst, nE1, nE1
	dc.b sHold, nE1, nRst, nRst, nE1, sHold, nE1, nE1
	dc.b nE1, nE1, sHold, nE1, nE1, $06, nE1, nRst
	dc.b nE1, nRst, nE1, nE1, sHold, nE1, nRst, nRst
	dc.b nE1, sHold, nE1, nE1, nE1, nE1, nE1, nA1
	dc.b $06, nA1, nRst, nA1, nRst, nA1, nA1, sHold
	dc.b nA1, nFs1, $0C, nFs1, sHold, nFs1, nE1, nE1
	dc.b $06, nE1, nRst, nE1, nRst, nE1, nD1, sHold
	dc.b nD1, nRst, nD1, nRst, nD2, sHold, nD2, nD1
	dc.b nD1, nD1, nA1, nA1, nRst, nA1, nRst, nA1
	dc.b nA1, sHold, nA1, nFs1, $0C, nFs1, sHold, nFs1
	dc.b nG1, nG1, $06, nG1, nRst, nG1, nRst, nG1
	dc.b nE1, sHold, nE1, nRst, nE1, nRst, nE2, sHold
	dc.b nE2, nE1, nE1, nE1, nA1, nA1, nRst, nA1
	dc.b nRst, nA1, nA1, sHold, nA1, nFs1, $0C, nFs1
	dc.b sHold, nFs1, nE1, nE1, $06, nE1, nRst, nE1
	dc.b nRst, nE1, nD1, sHold, nD1, nRst, nD1, nRst
	dc.b nD2, sHold, nD2, nD1, nD1, nD1, nRst, $54
	dc.b nA0, $78
	sStop

Title_FM3:
	sPatFM		$04
	sPan		spCenter, $00
	dc.b nRst, $60
	ssModZ80	$2A, $01, $29, $00
	dc.b nE4, $3C, sHold
	ssModZ80	$01, $00, $00, $00
	dc.b nE4, $24
	sPatFM		$02
	sPan		spLeft, $00
	ssModZ80	$00, $00, $00, $00

Title_Loop1:
	dc.b nA2, $06, nA2
	saVolFM		$FD
	dc.b nA2, nA2
	saVolFM		$FD
	dc.b nA2, nA2
	saVolFM		$FD
	dc.b nA2, nFs2
	saVolFM		$FD
	dc.b nFs2, nFs2
	saVolFM		$03
	dc.b nFs2, nFs2
	saVolFM		$03
	dc.b nFs2, nFs2
	saVolFM		$03
	dc.b nE2, nE2
	saVolFM		$03
	dc.b nE2, nE2
	saVolFM		$03
	dc.b nE3, nE2
	saVolFM		$03
	dc.b nB2, nE2
	saVolFM		$03
	dc.b nD2, nD2
	saVolFM		$03
	dc.b nD2, nD2
	saVolFM		$FD
	dc.b nD3, nD2
	saVolFM		$FD
	dc.b nA2, nD2
	saVolFM		$FD
	dc.b nD3, nD2
	saVolFM		$FD
	sLoop		$00, $02, Title_Loop1
	dc.b nA2, $06, nA2
	saVolFM		$FD
	dc.b nA2, nA2
	saVolFM		$FD
	dc.b nA2, nA2
	saVolFM		$FD
	dc.b nA2, nFs2
	saVolFM		$FD
	dc.b nFs2, nFs2
	saVolFM		$03
	dc.b nFs2, nFs2
	saVolFM		$03
	dc.b nFs2, nFs2
	saVolFM		$03
	dc.b nE2, nE2
	saVolFM		$03
	dc.b nE2, nE2
	saVolFM		$03
	dc.b nE3, nE2
	saVolFM		$03
	dc.b nE3, nE2
	saVolFM		$03
	dc.b nD2, nD2
	saVolFM		$03
	dc.b nD2, nD2
	saVolFM		$FD
	dc.b nD3, nD2
	saVolFM		$FD
	dc.b nA2, nD2
	saVolFM		$FD
	dc.b nD3, nD2
	saVolFM		$FD
	sStop

Title_FM4:
	sPatFM		$05
	saDetune	$FC
	sPan		spRight, $00
	ssModZ80	$01, $01, $06, $00
	dc.b nG3, $60, sHold, nG3
	sPatFM		$03
	ssModZ80	$14, $01, $04, $06
	dc.b nRst, $18, nA3, $0C, nRst, $18, nFs3, $09
	dc.b nRst, $0F, nE3, $24, nRst, $48, nRst, $18
	dc.b nA3, $0C, nRst, $18, nA3, $09, nRst, $1B
	dc.b nB3, $06, nRst, nB3, $18, nB3, $30, nRst
	dc.b $0C, nA3, $0C, nRst, $09, nRst, $03, nRst
	dc.b $0C, nRst, nRst, nFs3, $09, nRst, $0F, nE3
	dc.b $3C, nRst, $30
	sNoteTimeOut	$17
	dc.b nCs4, $18
	sNoteTimeOut	$06
	dc.b nA3, $0C, $0C, nG3
	sNoteTimeOut	$00
	dc.b nG3, $18, nA3, $09
	sStop

Title_FM5:
	sPan		spLeft, $00
	sPatFM		$05
	ssModZ80	$01, $01, $06, $00
	dc.b nG3, $60, sHold, nG3
	sPatFM		$03
	saDetune	$04
	ssModZ80	$14, $01, $04, $06
	dc.b nRst, $18, nA3, $0C, nRst, $18, nFs3, $09
	dc.b nRst, $0F, nE3, $24, nRst, $48, nRst, $18
	dc.b nA3, $0C, nRst, $18, nFs3, $09, nRst, $1B
	dc.b nG3, $06, nRst, nG3, $18, nE3, $30, nRst
	dc.b $0C, nA3, $0C, nRst, $09, nRst, $03, nRst
	dc.b $0C, nRst, nRst, nFs3, $09, nRst, $0F, nE3
	dc.b $3C, nRst, $30
	sNoteTimeOut	$17
	dc.b nCs4, $18
	sNoteTimeOut	$06
	dc.b nA3, $0C, $0C, nG3
	sNoteTimeOut	$00
	dc.b nG3, $18, nA3, $09
	sStop

Title_PSG1:
	sVolEnvPSG	VolEnv_0A
	dc.b nRst, $60, nA3, $06, nCs4, nB3, nD4
	saVolPSG	$FF
	dc.b nCs4, nE4, nD4, nFs4
	saVolPSG	$FF
	dc.b nE4, nAb4, nFs4, nA4
	saVolPSG	$FF
	dc.b nAb4, nB4, nA4, nCs5
	saVolPSG	$03
	saTranspose	$0C
	ssModZ80	$00, $00, $00, $00
	dc.b nE4, $0C, nB3, nE4, nB3, nE4, nB3, nE4
	dc.b nB3, nD4, nB3, nE4, nB3, nE4, nB3, nE4
	dc.b nB3, nE4, $0C, nB3, nE4, nB3, nE4, nB3
	dc.b nE4, nB3, nD4, nB3, nD4, nB3, nD5, nB4
	dc.b nD5, nB4, nE4, $0C, nB3, nE4, nB3, nE4
	dc.b nB3, nE4, nB3, nD4, nB3, nE4, nB3, nE4
	dc.b nB3, nE4, nB3, nRst, $60, nG3, $0C
	saVolPSG	$01
	dc.b nA3, $18
	saVolPSG	$01
	dc.b nCs4, $24
	saVolPSG	$01
	dc.b nE3, $18
	saVolPSG	$01
	dc.b nG3, $0C
	saVolPSG	$01
	dc.b nA3, $18
	saVolPSG	$01
	dc.b nCs4, $24
	saVolPSG	$01
	dc.b nE3, $60
	sStop

Title_PSG2:
	ssModZ80	$01, $01, $FD, $00
	saDetune	$04
	dc.b nD1, $60, sHold, $60, nRst, $06
	ssModZ80	$00, $00, $00, $00
	saVolPSG	$03
	saDetune	$00
	dc.b nCs4, $0C, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, $0C, nA3, nCs4, nA3, nCs4, nA3
	dc.b nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs5, nA4
	dc.b nCs5, nA4, nCs4, $0C, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, nA3, nRst, $5A, nA2, $18
	saVolPSG	$01
	dc.b nE3, $24
	saVolPSG	$01
	dc.b nA3, $18
	saVolPSG	$01
	dc.b nD4, $0C
	saVolPSG	$01
	dc.b nA2, $18
	saVolPSG	$01
	dc.b nE3, $24
	saVolPSG	$01
	dc.b nA3, $18
	saVolPSG	$01
	dc.b nD4, $60
	sStop

Title_PSG3:
	saDetune	$02
	dc.b nRst, $60, nRst, $03, nB3, $06, nE4, nCs4
	dc.b nFs4
	saVolPSG	$FF
	dc.b nD4, nAb4, nE4, nA4
	saVolPSG	$FF
	dc.b nFs4, nB4, nAb4, nCs5
	saVolPSG	$FF
	dc.b nA4, nD5, nB4, nE5, $03
	ssModZ80	$15, $01, $03, $06
	saVolPSG	$FF
	sJump		Title_Jump1
	; Unused
	dc.b $F2

Title_DAC:
	dc.b dKick, $06, dKick, nRst, dKick, nRst, nRst, dKick
	dc.b nRst, nRst, nRst, dKick, nRst, dSnare, dSnare, nRst
	dc.b nRst, dKick, dKick, nRst, dKick, nRst, nRst, dSnare
	dc.b nRst, nRst, nRst, dKick, nRst, dSnare, dSnare, dSnare
	dc.b dSnare, dCrashCymbal, $06, nRst, nRst, dKick, dSnare, dKick
	dc.b dKick, nRst, dKick, nRst, dKick, nRst, dSnare, nRst
	dc.b dKick, nRst, dKick, dKick, nRst, dKick, dSnare, dKick
	dc.b dKick, nRst, nRst, dKick, nRst, dKick, dSnare, dKick
	dc.b dKick, nRst, dKick, $06, dKick, nRst, dKick, dSnare
	dc.b dKick, dKick, nRst, dKick, nRst, dKick, nRst, dSnare
	dc.b nRst, dKick, nRst, dKick, dKick, nRst, dKick, dSnare
	dc.b dKick, dKick, nRst, nRst, dKick, nRst, dKick, dSnare
	dc.b dKick, dKick, nRst, dKick, dKick, nRst, dKick, dSnare
	dc.b dKick, dKick, nRst, dKick, nRst, dKick, nRst, dSnare
	dc.b nRst, dKick, nRst, dKick, dKick, nRst, dKick, dSnare
	dc.b dKick, dKick, nRst, nRst, dKick, nRst, dKick, dSnare
	dc.b dKick, dKick, dKick, dKick, nRst, nRst, nRst, dSnare
	dc.b nRst, nRst, dSnare, dKick, $0C, dKick, dSnare, dCrashCymbal
	sStop

Title_Patches:
	; Patch $00
	; $3D
	; $61, $02, $12, $52,	$1F, $18, $18, $1B
	; $09, $02, $01, $02,	$06, $00, $00, $00
	; $5F, $4F, $3F, $4F,	$17, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$06, $01, $00, $05
	spMultiple	$01, $02, $02, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $18, $18, $1B
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$06, $00, $00, $00
	spSustainRt	$09, $01, $02, $02
	spSustainLv	$05, $03, $04, $04
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$17, $00, $00, $00

	; Patch $01
	; $2D
	; $01, $51, $31, $21,	$13, $1F, $19, $1F
	; $0B, $09, $00, $0B,	$00, $00, $00, $00
	; $FF, $FF, $FF, $FF,	$0C, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$05
	spDetune	$00, $03, $05, $02
	spMultiple	$01, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$13, $19, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$0B, $00, $09, $0B
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0C, $00, $00, $00

	; Patch $02
	; $0A
	; $51, $76, $01, $19,	$1C, $1B, $1C, $1F
	; $00, $08, $04, $11,	$00, $01, $00, $00
	; $1F, $FF, $FF, $7F,	$82, $10, $32, $0C
	spAlgorithm	$02
	spFeedback	$01
	spDetune	$05, $00, $07, $01
	spMultiple	$01, $01, $06, $09
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1C, $1C, $1B, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $01, $00
	spSustainRt	$00, $04, $08, $11
	spSustainLv	$01, $0F, $0F, $07
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$02, $32, $10, $0C

	; Patch $03
	; $2A
	; $32, $2A, $01, $02,	$12, $12, $11, $16
	; $0A, $0E, $0E, $08,	$00, $00, $00, $00
	; $FF, $FF, $1F, $CF,	$15, $15, $2C, $85
	spAlgorithm	$02
	spFeedback	$05
	spDetune	$03, $00, $02, $00
	spMultiple	$02, $01, $0A, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$12, $11, $12, $16
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$0A, $0E, $0E, $08
	spSustainLv	$0F, $01, $0F, $0C
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$15, $2C, $15, $05

	; Patch $04
	; $3D
	; $12, $58, $04, $15,	$0F, $1A, $1C, $1A
	; $00, $00, $0F, $05,	$00, $00, $00, $00
	; $0F, $0F, $1F, $FF,	$22, $86, $86, $86
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$01, $00, $05, $01
	spMultiple	$02, $04, $08, $05
	spRateScale	$00, $00, $00, $00
	spAttackRt	$0F, $1C, $1A, $1A
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$00, $0F, $00, $05
	spSustainLv	$00, $01, $00, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$22, $06, $06, $06

	; Patch $05
	; $3D
	; $51, $21, $30, $10,	$1F, $1F, $1F, $1F
	; $0F, $00, $00, $00,	$00, $00, $00, $00
	; $1F, $4F, $4F, $4F,	$10, $8E, $8E, $8E
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$05, $03, $02, $01
	spMultiple	$01, $00, $01, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$0F, $00, $00, $00
	spSustainLv	$01, $04, $04, $04
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$10, $0E, $0E, $0E
