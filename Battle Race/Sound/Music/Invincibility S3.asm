InvincibilityS3_Header:
	sHeaderInit	; Z80 offset is $F364
	sHeaderPatch	InvincibilityS3_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $2C
	sHeaderDAC	InvincibilityS3_DAC
	sHeaderFM	InvincibilityS3_FM1, $18, $12
	sHeaderFM	InvincibilityS3_FM2, $00, $09
	sHeaderFM	InvincibilityS3_FM3, $18, $1C
	sHeaderFM	InvincibilityS3_FM4, $00, $1C
	sHeaderFM	InvincibilityS3_FM5, $00, $1C
	sHeaderPSG	InvincibilityS3_PSG1, $F4, $06, $00, VolEnv_00
	sHeaderPSG	InvincibilityS3_PSG2, $F4, $06, $00, VolEnv_00
	sHeaderPSG	InvincibilityS3_PSG3, $3B, $02, $00, VolEnv_00

InvincibilityS3_FM1:
InvincibilityS3_Jump5:
	sPatFM		$00
	ssModZ80	$14, $01, $06, $06
	dc.b nB3, $04, nRst, nB3, $08, nC4, $04, nRst
	dc.b nC4, $08, nD4, $08, nRst, nD4, $04, nRst
	dc.b nBb3, $04, sHold, nB3, $08, nRst, $04, nB3
	dc.b $08, nC4, $04, nRst, nD4, $0C, nRst, $04
	dc.b nD4, nRst, nD4, $0C, nRst, $04, nF4, $0C
	dc.b nRst, $04, nF4, $0C, nRst, $04, nF4, $0C
	dc.b nRst, $04, nF4, $0C, nRst, $04
	saVolFM		$FE

InvincibilityS3_Loop16:
	dc.b nF4, $03, nRst, $05
	sLoop		$00, $08, InvincibilityS3_Loop16
	saVolFM		$02
	dc.b nB3, $04, nRst, nB3, $08, nC4, $04, nRst
	dc.b nC4, $08, nD4, $08, nRst, nD4, $04, nRst
	dc.b nBb3, $04, sHold, nB3, $08, nRst, $04, nB3
	dc.b $08, nC4, $04, nRst, nD4, $0C, nRst, $04
	dc.b nD4, nRst, nD4, $0C, nRst, $04, nF4, $0C
	dc.b nRst, $04, nF4, $0C, nRst, $04, nF4, $0C
	dc.b nRst, $04, nF4, $0C, nRst, $04
	saVolFM		$FE

InvincibilityS3_Loop17:
	dc.b nA4, $03, nRst, $05
	sLoop		$00, $08, InvincibilityS3_Loop17
	saVolFM		$02
	sJump		InvincibilityS3_Jump5
	; Unused
	dc.b $F2

InvincibilityS3_FM2:
InvincibilityS3_Jump4:
	sPatFM		$01
	dc.b nG2, $04, nRst, nG2, nRst, nG2, nRst, nG2
	dc.b nRst, nD2, $0C, nRst, $04, nD2, nRst, nG2
	dc.b $08, nRst, $08, nG2, $04, nRst, nG2, nRst
	dc.b nD2, $08, nRst, nD2, $04, nRst, nD2, $0C
	dc.b nRst, $04

InvincibilityS3_Loop13:
	dc.b nF2, $03, nRst, $05
	sLoop		$00, $10, InvincibilityS3_Loop13
	dc.b nG2, $04, nRst, nG2, nRst, nG2, nRst, nG2
	dc.b nRst, nD2, $0C, nRst, $04, nD2, nRst, nG2
	dc.b $08, nRst, $08, nG2, $04, nRst, nG2, nRst
	dc.b nD2, $08, nRst, nD2, $04, nRst, nD2, $0C
	dc.b nRst, $04

InvincibilityS3_Loop14:
	dc.b nF2, $03, nRst, $05
	sLoop		$00, $08, InvincibilityS3_Loop14

InvincibilityS3_Loop15:
	dc.b nA2, $03, nRst, $05
	sLoop		$00, $08, InvincibilityS3_Loop15
	sJump		InvincibilityS3_Jump4
	; Unused
	dc.b $F2

InvincibilityS3_FM3:
	sPatFM		$00
	ssModZ80	$15, $01, $06, $06
	dc.b nRst, $03
	saDetune	$03

InvincibilityS3_Jump3:
	dc.b nG3, $04, nRst, nG3, $08, nA3, $04, nRst
	dc.b nA3, $08, nB3, $08, nRst, nB3, $04, nRst
	dc.b nFs3, $04, sHold, nG3, $08, nRst, $04, nG3
	dc.b $08, nA3, $04, nRst, nB3, $0C, nRst, $04
	dc.b nB3, nRst, nB3, $0C, nRst, $04, nC4, $0C
	dc.b nRst, $04, nC4, $0C, nRst, $04, nC4, $0C
	dc.b nRst, $04, nC4, $0C, nRst, $04
	saVolFM		$FE

InvincibilityS3_Loop11:
	dc.b nC4, $03, nRst, $05
	sLoop		$00, $08, InvincibilityS3_Loop11
	saVolFM		$02
	dc.b nG3, $04, nRst, nG3, $08, nA3, $04, nRst
	dc.b nA3, $08, nB3, $08, nRst, nB3, $04, nRst
	dc.b nFs3, $04, sHold, nG3, $08, nRst, $04, nG3
	dc.b $08, nA3, $04, nRst, nB3, $0C, nRst, $04
	dc.b nB3, nRst, nB3, $0C, nRst, $04, nC4, $0C
	dc.b nRst, $04, nC4, $0C, nRst, $04, nC4, $0C
	dc.b nRst, $04, nC4, $0C, nRst, $04
	saVolFM		$FE

InvincibilityS3_Loop12:
	dc.b nA4, $03, nRst, $05
	sLoop		$00, $08, InvincibilityS3_Loop12
	saVolFM		$02
	sJump		InvincibilityS3_Jump3
	; Unused
	dc.b $F2

InvincibilityS3_FM4:
	sPatFM		$02
	sPan		spRight, $00

InvincibilityS3_Jump2:
InvincibilityS3_Loop6:
	dc.b nG5, $04, nD5
	sLoop		$00, $10, InvincibilityS3_Loop6

InvincibilityS3_Loop7:
	dc.b nA5, $04, nF5
	sLoop		$00, $10, InvincibilityS3_Loop7

InvincibilityS3_Loop8:
	dc.b nG5, $04, nD5
	sLoop		$00, $10, InvincibilityS3_Loop8

InvincibilityS3_Loop9:
	dc.b nA5, $04, nF5
	sLoop		$00, $08, InvincibilityS3_Loop9

InvincibilityS3_Loop10:
	dc.b nC6, $04, nF5
	sLoop		$00, $08, InvincibilityS3_Loop10
	sJump		InvincibilityS3_Jump2
	; Unused
	dc.b $F2

InvincibilityS3_FM5:
	sPatFM		$02
	sPan		spLeft, $00

InvincibilityS3_Jump1:
InvincibilityS3_Loop1:
	dc.b nB4, $04, nG4
	sLoop		$00, $10, InvincibilityS3_Loop1

InvincibilityS3_Loop2:
	dc.b nC5, $04, nA4
	sLoop		$00, $10, InvincibilityS3_Loop2

InvincibilityS3_Loop3:
	dc.b nB4, $04, nG4
	sLoop		$00, $10, InvincibilityS3_Loop3

InvincibilityS3_Loop4:
	dc.b nC5, $04, nA4
	sLoop		$00, $08, InvincibilityS3_Loop4

InvincibilityS3_Loop5:
	dc.b nF5, $04, nA4
	sLoop		$00, $08, InvincibilityS3_Loop5
	sJump		InvincibilityS3_Jump1
	; Unused
	dc.b $F2

InvincibilityS3_DAC:
InvincibilityS3_Jump6:
	dc.b dKick, $10, dKick, dKick, dKick
	sJump		InvincibilityS3_Jump6
	; Unused
	dc.b $F2

InvincibilityS3_PSG1:
	sVolEnvPSG	VolEnv_0A
	dc.b nRst, $02
	sJump		InvincibilityS3_Jump2
	; Unused
	dc.b $F2

InvincibilityS3_PSG2:
	sVolEnvPSG	VolEnv_0A
	dc.b nRst, $02
	sJump		InvincibilityS3_Jump1
	; Unused
	dc.b $F2

InvincibilityS3_PSG3:
	sStop

InvincibilityS3_Patches:
	; Patch $00
	; $3D
	; $01, $00, $04, $03,	$1F, $1F, $1F, $1F
	; $10, $06, $06, $06,	$01, $06, $06, $06
	; $35, $1A, $18, $1A,	$12, $82, $82, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $04, $00, $03
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$01, $06, $06, $06
	spSustainRt	$10, $06, $06, $06
	spSustainLv	$03, $01, $01, $01
	spReleaseRt	$05, $08, $0A, $0A
	spTotalLv	$12, $02, $02, $00

	; Patch $01
	; $3A
	; $01, $02, $01, $01,	$1F, $5F, $5F, $5F
	; $10, $11, $09, $09,	$07, $00, $00, $00
	; $CF, $FF, $FF, $FF,	$1C, $22, $18, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $01, $02, $01
	spRateScale	$00, $01, $01, $01
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$07, $00, $00, $00
	spSustainRt	$10, $09, $11, $09
	spSustainLv	$0C, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1C, $18, $22, $00

	; Patch $02
	; $3D
	; $01, $01, $01, $01,	$94, $19, $19, $19
	; $0F, $0D, $0D, $0D,	$07, $04, $04, $04
	; $25, $1A, $1A, $1A,	$15, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $01, $01, $01
	spRateScale	$02, $00, $00, $00
	spAttackRt	$14, $19, $19, $19
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$07, $04, $04, $04
	spSustainRt	$0F, $0D, $0D, $0D
	spSustainLv	$02, $01, $01, $01
	spReleaseRt	$05, $0A, $0A, $0A
	spTotalLv	$15, $00, $00, $00
