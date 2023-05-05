GameComplete_Header:
	sHeaderInit	; Z80 offset is $FCDE
	sHeaderPatch	GameComplete_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $08
	sHeaderDAC	GameComplete_DAC
	sHeaderFM	GameComplete_FM1, $01, $12
	sHeaderFM	GameComplete_FM2, $0D, $04
	sHeaderFM	GameComplete_FM3, $01, $1C
	sHeaderFM	GameComplete_FM4, $0D, $12
	sHeaderFM	GameComplete_FM5, $0D, $12
	sHeaderPSG	GameComplete_PSG1, $01, $09, $00, VolEnv_00
	sHeaderPSG	GameComplete_PSG2, $01, $09, $00, VolEnv_00
	sHeaderPSG	GameComplete_PSG3, $E9, $01, $00, VolEnv_00

GameComplete_FM1:
	sPatFM		$05
	saDetune	$FE
	ssModZ80	$14, $01, $06, $06
	dc.b nA4, $06, nCs5, nB4, nD5
	saVolFM		$FF
	dc.b nCs5, nE5, nD5, nFs5
	saVolFM		$FF
	dc.b nE5, nAb5, nFs5, nA5
	saVolFM		$FF
	dc.b nAb5, nB5, nA5, nCs6
	sPatFM		$00
	dc.b nA4, $18, nFs4, $0C, nE4, nA4, nFs4, nD4
	dc.b nE4, sHold, nE4, $24, nD5, $18
	sNoteTimeOut	$06
	dc.b $0C, $0C, $0C
	sNoteTimeOut	$00
	saVolFM		$FD
	dc.b nD5, nCs5, $18, nA4, nB4, nRst, $0C, nE5
	dc.b nD5, $18, nA4, nB4
	saVolFM		$FE
	dc.b nCs5, $0C
	sStop

GameComplete_FM2:
	sPatFM		$01
	dc.b nE1, $06, nE1, nRst, nE1, nRst, nE1, nE1
	dc.b sHold, nE1, nRst, nRst, nE1, sHold, nE1, nE1
	dc.b nE1, nE1, nE1, nA1, $06, nA1, nRst, nA1
	dc.b nRst, nA1, nA1, sHold, nA1, nFs1, $0C, nFs1
	dc.b sHold, nFs1, nE1, nE1, $06, nE1, nRst, nE1
	dc.b nRst, nE1, nD1, sHold, nD1, nRst, nD1, nRst
	dc.b nD2, sHold, nD2, nD1, nD1, nD1, nA1, nA1
	dc.b nRst, nA1, nRst, nA1, nA1, sHold, nA1, nFs1
	dc.b $0C, nFs1, sHold, nFs1, nG1, nG1, $06, nG1
	dc.b nRst, nG1, nRst, nG1, nE1, sHold, nE1, nRst
	dc.b nE1, nRst, nE2, sHold, nE2, nE1
	saVolFM		$FD
	dc.b nA1, $60
	sStop

GameComplete_FM3:
	sPatFM		$05
	saDetune	$02
	ssModZ80	$15, $01, $06, $06
	dc.b nRst, $03, nB4, $06, nE5, nCs5, nFs5
	saVolFM		$FF
	dc.b nD5, nAb5, nE5, nA5
	saVolFM		$FF
	dc.b nFs5, nB5, nAb5, nCs6
	saVolFM		$FF
	dc.b nA5, nD6, nB5, nE6, $03
	sPatFM		$00
	dc.b nRst, $07, nA4, $18, nFs4, $0C, nE4, nA4
	dc.b nFs4, nD4, nE4, sHold, nE4, $24, nD5, $18
	sNoteTimeOut	$06
	dc.b $0C, $0C, $0C
	sNoteTimeOut	$00
	saVolFM		$FD
	dc.b nD5, nCs5, $18, nA4, nB4, nRst, $0C, nE5
	dc.b nD5, $18, nA4, nB4, $05, nRst, $05
	saVolFM		$FE
	dc.b nA4, $0C
	sStop

GameComplete_FM4:
	sPatFM		$04
	sPan		spRight, $00
	ssModZ80	$01, $01, $0C, $00
	dc.b nG2, $60
	sPatFM		$03
	ssModZ80	$00, $00, $00, $00
	dc.b nA3, nB3, $24, nA3, $30, sHold, $0C
	sPatFM		$02
	dc.b nA4, $24, nA4, $30, nRst, $0C
	saVolFM		$FF
	dc.b nB4, $24, nB4, $30
	saVolFM		$FF
	dc.b nCs5, $0C
	sStop

GameComplete_FM5:
	sPatFM		$04
	sPan		spLeft, $00
	ssModZ80	$01, $01, $0C, $00
	dc.b nG2, $60
	sPatFM		$03
	ssModZ80	$00, $00, $00, $00
	dc.b nE3, nE3, $24, nD3, $30, sHold, $0C
	sPatFM		$02
	dc.b nE4, $24, nD4, $30, nRst, $0C
	saVolFM		$FF
	dc.b nG4, $24, nE4, $30
	saVolFM		$FF
	dc.b nE4, $0C
	sStop

GameComplete_PSG1:
	sVolEnvPSG	VolEnv_0C
	dc.b nA2, $06, nCs3, nB2, nD3
	saVolPSG	$FF
	dc.b nCs3, nE3, nD3, nFs3
	saVolPSG	$FF
	dc.b nE3, nAb3, nFs3, nA3
	saVolPSG	$FF
	dc.b nAb3, nB3, nA3, nCs4
	saVolPSG	$FD
	sVolEnvPSG	VolEnv_0A
	dc.b nE4, $0C, nB3, nE4, nB3, nE4, nB3, nE4
	dc.b nB3, nD4, nB3, nD4, nB3, nD4, nB3, nD4
	dc.b nB3, nE4, $0C, nB3, nE4, nB3, nD4, nB3
	dc.b nD4, nB3, nD4, nA3, nD4, nA3, nE4, nB3
	dc.b nE4
	saVolPSG	$01

GameComplete_Loop2:
	dc.b nA4
	saVolPSG	$01
	dc.b nG5
	saVolPSG	$01
	sLoop		$00, $05, GameComplete_Loop2
	sStop

GameComplete_PSG2:
	sVolEnvPSG	VolEnv_0C
	dc.b nRst, $03, nB2, $06, nE3, nCs3, nFs3
	saVolPSG	$FF
	dc.b nD3, nAb3, nE3, nA3
	saVolPSG	$FF
	dc.b nFs3, nB3, nAb3, nCs4
	saVolPSG	$FF
	dc.b nA3, nD4, nB3, nE4, $03
	saVolPSG	$FD
	sVolEnvPSG	VolEnv_0A
	dc.b nRst, $06, nCs4, $0C, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, nA3, nCs4, $0C, nA3, nCs4, nA3
	dc.b nCs4, nA3, nCs4, nA3, nB3, nG3, nB3, nG3
	dc.b nCs4, nA3, nCs4
	saVolPSG	$01

GameComplete_Loop1:
	dc.b nE5
	saVolPSG	$01
	dc.b nA5
	saVolPSG	$01
	sLoop		$00, $05, GameComplete_Loop1
	sStop

GameComplete_PSG3:
	sVolEnvPSG	VolEnv_0A
	ssModZ80	$14, $01, $03, $06
	dc.b nRst, $60, nA4, $18, nFs4, $0C, nE4, nA4
	dc.b nFs4, nD4, nE4, sHold, nE4, $24, nD5, $18
	sNoteTimeOut	$06
	dc.b $0C, $0C, $0C
	sNoteTimeOut	$00
	ssModZ80	$00, $00, $00, $00
	dc.b nA4, $24, nD4, $30, nRst, $0C, nG4, $24
	dc.b nE4, $30, nCs4, $0C
	sStop

GameComplete_DAC:
	sFade		$25
	; Unused
	dc.b $88, $30, $80, $0C, $81, $81, $81, $06
	dc.b $06, $88, $18, $81, $0C, $86, $86, $06
	dc.b $86, $86, $0C, $81, $18, $86, $18, $81
	dc.b $0C, $86, $86, $06, $86, $86, $0C, $81
	dc.b $06, $06, $80, $80, $86, $18, $81, $86
	dc.b $06, $86, $86, $0C, $81, $18, $86, $81
	dc.b $12, $86, $06, $86, $86, $86, $0C, $81
	dc.b $88, $60, $F2

GameComplete_Patches:
	; Patch $00
	; $3D
	; $01, $01, $11, $12,	$18, $1F, $1F, $1F
	; $10, $06, $06, $06,	$01, $00, $00, $00
	; $3F, $1F, $1F, $1F,	$10, $83, $83, $83
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $01, $00, $01
	spMultiple	$01, $01, $01, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$18, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$01, $00, $00, $00
	spSustainRt	$10, $06, $06, $06
	spSustainLv	$03, $01, $01, $01
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$10, $03, $03, $03

	; Patch $01
	; $00
	; $23, $30, $30, $21,	$9F, $5F, $1F, $1F
	; $00, $0F, $01, $00,	$07, $00, $00, $0C
	; $0F, $4F, $FF, $0F,	$26, $30, $1D, $80
	spAlgorithm	$00
	spFeedback	$00
	spDetune	$02, $03, $03, $02
	spMultiple	$03, $00, $00, $01
	spRateScale	$02, $00, $01, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$07, $00, $00, $0C
	spSustainRt	$00, $01, $0F, $00
	spSustainLv	$00, $0F, $04, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$26, $1D, $30, $00

	; Patch $02
	; $3C
	; $71, $31, $12, $11,	$17, $1F, $19, $2F
	; $04, $01, $07, $01,	$00, $00, $00, $00
	; $F7, $F8, $F7, $F8,	$1D, $80, $19, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$07, $01, $03, $01
	spMultiple	$01, $02, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$17, $19, $1F, $0F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$04, $07, $01, $01
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$07, $07, $08, $08
	spTotalLv	$1D, $19, $00, $00

	; Patch $03
	; $2C
	; $71, $62, $31, $32,	$5F, $54, $5F, $5F
	; $00, $09, $00, $09,	$00, $03, $00, $03
	; $0F, $8F, $0F, $AF,	$16, $80, $11, $80
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
	spTotalLv	$16, $11, $00, $00

	; Patch $04
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

	; Patch $05
	; $04
	; $12, $0A, $06, $7C,	$5F, $5F, $5F, $5F
	; $00, $08, $00, $00,	$00, $00, $00, $0A
	; $0F, $FF, $0F, $0F,	$11, $8C, $13, $8C
	spAlgorithm	$04
	spFeedback	$00
	spDetune	$01, $00, $00, $07
	spMultiple	$02, $06, $0A, $0C
	spRateScale	$01, $01, $01, $01
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $0A
	spSustainRt	$00, $00, $08, $00
	spSustainLv	$00, $00, $0F, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$11, $13, $0C, $0C
	; Unused
	dc.b $FF