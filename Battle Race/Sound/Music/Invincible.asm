Invincible_Header:
	sHeaderInit	; Z80 offset is $E574
	sHeaderPatch	Invincible_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $70
	sHeaderDAC	Invincible_DAC
	sHeaderFM	Invincible_FM1, $00, $15
	sHeaderFM	Invincible_FM2, $00, $0A
	sHeaderFM	Invincible_FM3, $00, $1F
	sHeaderFM	Invincible_FM4, $00, $13
	sHeaderFM	Invincible_FM5, $00, $13
	sHeaderPSG	Invincible_PSG1, $00, $05, $00, VolEnv_00
	sHeaderPSG	Invincible_PSG2, $00, $05, $00, VolEnv_00
	sHeaderPSG	Invincible_PSG3, $E8, $01, $00, VolEnv_00

Invincible_FM1:
	ssModZ80	$14, $01, $06, $06
	saDetune	$FE
	sPan		spCenter, $00

Invincible_Jump6:
	sPatFM		$00
	dc.b nRst, $18

Invincible_Jump1:
	dc.b nA4, $0C, nFs4, $06, nE4, nA4, nFs4, nD4
	dc.b nE4, sHold, nE4, $12, nD5, $0C
	sNoteTimeOut	$05
	dc.b $06, $06, $06
	sNoteTimeOut	$00
	dc.b nCs5, $0C, nA4, $06, nE4, nFs4, $02, nRst
	dc.b $04, nA4, $0C, nB4, $06, sHold, nB4, $24
	dc.b nRst, $0C
	sJump		Invincible_Jump1
	; Unused
	dc.b $F2

Invincible_FM2:
	dc.b nRst, $18
	sPatFM		$01

Invincible_Jump7:
	dc.b nA1, $03, nA1, nRst, nA1, nRst, nA1, nA1
	dc.b sHold, nA1, nFs1, $06, nFs1, sHold, nFs1, nE1
	dc.b nE1, $03, nE1, nRst, nE1, nRst, nE1, nD1
	dc.b sHold, nD1, nRst, nD1, nRst, nD2, sHold, nD2
	dc.b nD1, nD1, nD1, nA1, nA1, nRst, nA1, nRst
	dc.b nA1, nA1, sHold, nA1, nFs1, $06, nFs1, sHold
	dc.b nFs1, nG1, nG1, $03, nG1, nRst, nG1, nRst
	dc.b nG1, nE1, sHold, nE1, nRst, nE1, nRst, nE2
	dc.b sHold, nE2, nE1, nE1, nE1
	sJump		Invincible_Jump7
	; Unused
	dc.b $F2

Invincible_FM3:
	dc.b nRst, $0B
	saDetune	$02
	ssModZ80	$14, $01, $05, $06
	sPan		spLeft, $00
	sJump		Invincible_Jump6
	; Unused
	dc.b $F2

Invincible_FM4:
	sPan		spRight, $00
	sPatFM		$02
	dc.b nRst, $18

Invincible_Jump5:
	sNoteTimeOut	$05
	dc.b nRst, $0C, nA5, $12, nA5, nRst, $0C, nB5
	dc.b $12
	sNoteTimeOut	$00
	dc.b nA5
	sNoteTimeOut	$05
	dc.b nRst, $0C, nA5, $12, nA5, nG5, $06
	sNoteTimeOut	$00
	dc.b nG5, $0C, nE5, $18, nRst, $06
	sJump		Invincible_Jump5
	; Unused
	dc.b $F2

Invincible_FM5:
	sPan		spLeft, $00
	sPatFM		$02
	dc.b nRst, $18

Invincible_Jump4:
	sNoteTimeOut	$05
	dc.b nRst, $0C, nE5, $12, nE5, nRst, $0C, nE5
	dc.b $12
	sNoteTimeOut	$00
	dc.b nD5
	sNoteTimeOut	$05
	dc.b nRst, $0C, nE5, $12, nE5, nD5, $06
	sNoteTimeOut	$00
	dc.b nD5, $0C, nB4, $18, nRst, $06
	sJump		Invincible_Jump4
	; Unused
	dc.b $F2

Invincible_PSG1:
	dc.b nRst, $18
	sVolEnvPSG	VolEnv_0A

Invincible_Jump3:
	dc.b nE4, $06, nB3, nE4, nB3, nE4, nB3, nE4
	dc.b nB3, nD4, nB3, nE4, nB3, nE4, nB3, nE4
	dc.b nB3, nE4, $06, nB3, nE4, nB3, nE4, nB3
	dc.b nE4, nB3, nD4, nB3, nD4, nB3, nD5, nB4
	dc.b nD5, nB4, nE4, $06, nB3, nE4, nB3, nE4
	dc.b nB3, nE4, nB3, nD4, nB3, nE4, nB3, nE4
	dc.b nB3, nE4, nB3, nE4, $06, nB3, nE4, nB3
	dc.b nE4, nB3, nE4, nB3, nE3, nG3, nFs3, nA3
	dc.b nAb3, nB3, nB3, nD4
	sJump		Invincible_Jump3
	; Unused
	dc.b $F2

Invincible_PSG2:
	dc.b nRst, $18
	sVolEnvPSG	VolEnv_0A
	dc.b nRst, $03

Invincible_Jump2:
	dc.b nCs4, $06, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, $06, nA3, nCs4, nA3, nCs4, nA3
	dc.b nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs5, nA4
	dc.b nCs5, nA4, nCs4, $06, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, nA3, nCs4, $06, nA3, nCs4, nA3
	dc.b nCs4, nA3, nCs4, nA3, nFs3, nA3, nG3, nB3
	dc.b nA3, nCs4, nCs4, nE4
	sJump		Invincible_Jump2
	; Unused
	dc.b $F2

Invincible_PSG3:
	sVolEnvPSG	VolEnv_0A
	ssModZ80	$14, $01, $02, $06
	dc.b nRst, $18
	sJump		Invincible_Jump1
	; Unused
	dc.b $F2

Invincible_DAC:
	dc.b dSnare, $06, dSnare, dSnare, $03, dSnare, dSnare, dSnare
Invincible_Jump8:
	dc.b dCrashCymbal, $0C, dSnare, dKick, $06, dKick, dSnare, nRst
	dc.b dKick, $0C, dSnare, $09, $03, dKick, $06, dKick
	dc.b dSnare, nRst, dKick, $0C, dSnare, dKick, $06, dKick
	dc.b dSnare, nRst, dKick, $0C, dSnare, $09, $03, dKick
	dc.b $06, dKick, dSnare, $03, nRst, dSnare, dSnare
	sJump		Invincible_Jump8
	; Unused
	dc.b $F2

Invincible_Patches:
	; Patch $00
	; $3D
	; $61, $02, $12, $52,	$1F, $18, $18, $1B
	; $04, $02, $01, $02,	$00, $00, $00, $00
	; $5F, $4F, $3F, $4F,	$17, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$06, $01, $00, $05
	spMultiple	$01, $02, $02, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $18, $18, $1B
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$04, $01, $02, $02
	spSustainLv	$05, $03, $04, $04
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$17, $00, $00, $00

	; Patch $01
	; $2D
	; $01, $51, $31, $21,	$1F, $1F, $1F, $1F
	; $0B, $09, $00, $0B,	$00, $00, $00, $00
	; $FF, $FF, $FF, $FF,	$0C, $90, $90, $90
	spAlgorithm	$05
	spFeedback	$05
	spDetune	$00, $03, $05, $02
	spMultiple	$01, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$0B, $00, $09, $0B
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0C, $10, $10, $10

	; Patch $02
	; $3D
	; $00, $01, $01, $01,	$94, $19, $19, $19
	; $0F, $0D, $0D, $0D,	$07, $04, $04, $04
	; $25, $1A, $1A, $1A,	$10, $84, $84, $84
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $01, $01, $01
	spRateScale	$02, $00, $00, $00
	spAttackRt	$14, $19, $19, $19
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$07, $04, $04, $04
	spSustainRt	$0F, $0D, $0D, $0D
	spSustainLv	$02, $01, $01, $01
	spReleaseRt	$05, $0A, $0A, $0A
	spTotalLv	$10, $04, $04, $04
