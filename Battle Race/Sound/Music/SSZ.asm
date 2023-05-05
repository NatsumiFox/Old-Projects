SSZ_Header:
	sHeaderInit	; Z80 offset is $BE80
	sHeaderPatch	SSZ_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $04
	sHeaderDAC	SSZ_DAC
	sHeaderFM	SSZ_FM1, $E8, $0D
	sHeaderFM	SSZ_FM5, $00, $15
	sHeaderFM	SSZ_FM3, $00, $17	; also usually not as audible
	sHeaderFM	SSZ_FM4, $00, $1C	; sometimes not as audible
	sHeaderFM	SSZ_FM2, $00, $17	; easily least audible channel. WTF?
	sHeaderPSG	SSZ_PSG1, $F4, $05, $00, VolEnv_00
	sHeaderPSG	SSZ_PSG2, $F4, $05, $00, VolEnv_00
	sHeaderPSG	SSZ_PSG3, $00, $02, $00, VolEnv_00

SSZ_FM1:
	sPatFM		$00
	saDetune	$FE

SSZ_Jump6:
	sCall		SSZ_FM1_Intro
	dc.b nRst, $30

SSZ_Loop17:
	sCall		SSZ_FM1_0
	sLoop		$00, $02, SSZ_Loop17
	dc.b nG2, $48, nG3, $0C, nG3, $48, nG2, $24
	dc.b nAb2, $48, nAb3, $0C, nAb3, $48, nAb2, $0C
	dc.b nAb3, $18, nG2, $48, nG3, $0C, nG3, $48
	dc.b nG2, $24, nAb2, $3C, nAb3, $24, nBb2, $3C
	dc.b nBb3, $24, nC3, $60, nC4, $24, nC3, nC4
	dc.b $18, nBb2, $06, nRst, $06, nBb2, $54, nBb3
	dc.b $24, nBb2, nBb3, $18, nA2, $06, nRst, $06
	dc.b nA2, $48, nG3, $06, nAb3, nA3, $24, nA2
	dc.b nA3, $18, nAb2, $06, nRst, $06, nAb2, $54
	dc.b nBb3, $24, nBb2, nBb3, $18, nRst, $01
	sJump		SSZ_Jump6

SSZ_FM1_Intro:
	dc.b nG2, $07, nRst, $04, nG2, $08, nRst, $04
	dc.b $24, nG3, nG2, nG2, $0C, nRst, nC3, $14
	dc.b nB2, $10, nG2, $08, nRst, $04, nG2, $08
	dc.b nRst, $04, $24, nG3, nG2, nG2, $0C
	sRet

SSZ_FM1_0:
	dc.b nC3, $60, nC4, $24, nC3, nC4, $18, nBb2
	dc.b $06, nRst, $06, nBb2, $54, nBb3, $24, nBb2
	dc.b nBb3, $18

SSZ_FM1_1:
	dc.b nA2, $06, nRst, $06, nA2, $48
	dc.b nG3, $06, nAb3, nA3, $24, nA2, nA3, $18
	dc.b nAb2, $06, nRst, $06, nAb2, $54, nAb3, $24
	dc.b nAb2, nBb3, $18
	sRet

SSZ_FM5PSG2_Delay:
	dc.b nRst, $60, nRst, nRst
	sRet

SSZ_FM2_0:
	sPatFM		$03

SSZ_Loop16:
	dc.b nC4, $60, sHold, $60, nBb3, sHold, $60, nA3
	dc.b sHold, $60, nAb3, sHold, $60
	sLoop		$00, $02, SSZ_Loop16
	sRet

SSZ_FM2:
SSZ_Jump5:
	sCall		SSZ_FM5PSG2_Delay
	dc.b nRst

	sCall		SSZ_FM2_0
	dc.b nG3, sHold, $60, nAb3, sHold, $60, nG3, sHold
	dc.b $60, nAb3, nBb3, nC4, sHold, $60, nBb3, sHold
	dc.b $60, nA3, sHold, $60, nAb3, nBb3
	sJump		SSZ_Jump5

SSZ_FM3_Intro:
	sPatFM		$01
	dc.b nRst, $60, nRst, nF5, $12, nE5, nC5, $0C
	dc.b nC6, $12, nB5, nG5, $0C, nF5, $12
	sRet

SSZ_FM3_0:
	dc.b nC3, $06, nG1, nC3, nG1, nD3, nG1, nE3
	dc.b nG1, nF3, nG1, nE3, nG1, nD3, nG1, nE3
	dc.b nG1
	sLoop		$00, $02, SSZ_FM3_0

SSZ_Loop14:
	dc.b nC3, $06, nAb1, nC3, nAb1, nD3, nAb1, nE3
	dc.b nAb1, nF3, nAb1, nE3, nAb1, nD3, nAb1, nE3
	dc.b nAb1
	sLoop		$00, $02, SSZ_Loop14
	sRet

SSZ_FM3:
SSZ_Jump4:
	sCall		SSZ_FM3_Intro
	dc.b nE5
	saVolFM		$FF
	dc.b nC5, $0C, nRst
	saVolFM		$01
	dc.b nB4, nRst, $18
	sPatFM		$02

SSZ_Loop12:
	sCall		SSZ_Call2
	sLoop		$01, $02, SSZ_Loop12

SSZ_Loop13:
	sCall		SSZ_FM3_0

SSZ_Loop15:
	dc.b nC3, $06, nG1, nC3, nG1, nD3, nG1, nE3
	dc.b nG1, nF3, nG1, nE3, nG1, nD3, nG1, nE3
	dc.b nG1
	sLoop		$00, $02, SSZ_Loop15
	dc.b nC3, $06, nAb1, nC3, nAb1, nD3, nAb1, nE3
	dc.b nAb1, nF3, nAb1, nE3, nAb1, nD3, nAb1, nE3
	dc.b nAb1, nC3, $06, nBb1, nC3, nBb1, nD3, nBb1
	dc.b nE3, nBb1, nF3, nBb1, nE3, nBb1, nD3, nBb1
	dc.b nE3, nBb1
	sCall		SSZ_Call2
	sJump		SSZ_Jump4

SSZ_Call2:
SSZ_Loop8:
	sPatFM		$02
	dc.b nC3, $06, nC2, nC3, nC2, nD3, nC2, nE3
	dc.b nC2, nF3, nC2, nE3, nC2, nD3, nC2, nE3
	dc.b nC2
	sLoop		$00, $02, SSZ_Loop8

SSZ_Loop9:
	sPatFM		$02
	dc.b nC3, $06, nBb1, nC3, nBb1, nD3, nBb1, nE3
	dc.b nBb1, nF3, nBb1, nE3, nBb1, nD3, nBb1, nE3
	dc.b nBb1
	sLoop		$00, $02, SSZ_Loop9

SSZ_Loop10:
	sPatFM		$02
	dc.b nC3, $06, nA1, nC3, nA1, nD3, nA1, nE3
	dc.b nA1, nF3, nA1, nE3, nA1, nD3, nA1, nE3
	dc.b nA1
	sLoop		$00, $02, SSZ_Loop10

SSZ_Loop11:
	sPatFM		$02
	dc.b nC3, $06, nAb1, nC3, nAb1, nD3, nAb1, nE3
	dc.b nAb1, nF3, nAb1, nE3, nAb1, nD3, nAb1, nE3
	dc.b nAb1
	sLoop		$00, $02, SSZ_Loop11
	sRet

SSZ_FM5_Intro:
	ssModZ80	$24, $01, $04, $08
	sPatFM		$01

SSZ_Loop5:
	dc.b nC5, $12, nB4, nG4, $0C, nG5, $12, nF5
	dc.b nE5, $0C
	sLoop		$00, $03, SSZ_Loop5
	sRet

SSZ_FM5_0:
	dc.b nC6, $07, nRst, $05, nC6, $48, nC5, $06
	dc.b nE5, nF5, $24, nE5, $18, nC5, $24
	sLoop		$00, $02, SSZ_FM5_0

	dc.b nRst, $0C, nRst, nA4, nRst, nRst, nC5, nRst
	dc.b nRst, nF4, nRst, nRst, nA4, $24, nA4, $18
	dc.b nRst, $24, nAb4, $0C, nC5, nBb4, nAb4, nEb5
	dc.b $18, nC5, $0C, nD5, nEb5, $18, nD5, $0C
	dc.b nC5, $18

SSZ_Loop7:
	dc.b nC6, $06, nRst, nC6, $48, nC5, $06, nE5
	dc.b nF5, $24, nE5, $18, nC5, $24
	sLoop		$00, $02, SSZ_Loop7
	dc.b nRst, $0C, nRst, nA4, nRst, nRst, nC5, nRst
	dc.b nRst, nF4, nRst, nRst, nA4, $24, nA4, $18
	dc.b nRst, $24, nAb4, $0C, nC5, nBb4, nAb4, nEb5
	dc.b $18, nC5, $0C, nD5, nEb5, $18, nD5, $0C
	dc.b nF5, $18
	sRet

SSZ_FM5:
SSZ_Jump3:
	sCall		SSZ_FM5_Intro
	dc.b nC5, $12, nB4
	saVolFM		$FF
	dc.b nG4, $0C, nRst
	saVolFM		$01
	dc.b nG4, nRst, $18

	saVolFM		$FD
	sCall		SSZ_FM5_0
	saVolFM		$FF
	dc.b nG5, $24, nEb6, nD6, $07, nRst, $05, $18
	dc.b nG5, $54, nAb5, $24, nEb6, nD6, $07, nRst
	dc.b $05, $18, nF6, $24, nEb6, $18, nD6, nG5
	dc.b $24, nEb6, nD6, $07, nRst, $05, $18, nG5
	dc.b $54, nAb5, $24, nC6, nEb6, $18, nG6, nF6
	dc.b $0C, nEb6, $18, nF6, $24, nC6, $54, nC5
	dc.b $06, nE5, nF5, $24, nE5, $18, nC5, $24
	saVolFM		$FF
	dc.b nC6, $54, nC6, $06, nE6, nF6, $24, nE6
	dc.b $18, nC6, $24
	saVolFM		$FF
	dc.b nG6, $0C, nC6, $07, nRst, $05, nRst, $24
	dc.b nC6, $0C, nG6, nC6, $07, nRst, $05, nRst
	dc.b $0C, nC6, nRst, nC6, nG6, nC6, nRst, nC6
	saVolFM		$FF
	dc.b nBb6, $24, nAb6, nG6, nF6, nEb6, $18, nF6
	saVolFM		$07
	sJump		SSZ_Jump3

SSZ_FM4:
	sCall		SSZ_FM4_Intro
	dc.b nRst, $0E
	sJump		SSZ_Jump3

SSZ_FM4_Intro:
	ssModZ80	$24, $01, $04, $07
	saDetune	$02
	sPatFM		$01
	sRet

SSZ_PSG1_Intro:
	sVolEnvPSG	VolEnv_04

SSZ_Loop1:
	dc.b nG4, $06, nF4, nC4, nF4
	sLoop		$00, $0E, SSZ_Loop1
	sRet

SSZ_PSG1:
SSZ_Jump2:
	sCall		SSZ_PSG1_Intro
	dc.b nRst, $0C, nB3, nRst, $18

SSZ_Loop3:
	sCall		SSZ_Call1
	sLoop		$00, $08, SSZ_Loop3
	saTranspose	$07
	sCall		SSZ_Call1
	saTranspose	$01
	sCall		SSZ_Call1
	saTranspose	$FF
	sCall		SSZ_Call1
	saTranspose	$F9
	sCall		SSZ_Call1

SSZ_Loop4:
	sCall		SSZ_Call1
	sLoop		$00, $04, SSZ_Loop4
	sJump		SSZ_Jump2

SSZ_Call1:
SSZ_Loop2:
	dc.b nC5, $06, nC4, nC5, nC4, nC5, nC4, nC5
	dc.b nC4, nC6, nC4, nC6, nC4, nC5, nC4, nC5
	dc.b nC4
	sLoop		$01, $02, SSZ_Loop2
	sRet

SSZ_PSG2:
	sStop

SSZ_PSG3:
SSZ_Jump1:
	sCall		SSZ_PSG3_0
	sJump		SSZ_Jump1

SSZ_PSG3_0:
	sNoisePSG	$E7
	sVolEnvPSG	VolEnv_01
	dc.b nB6, $06, nB6
	sVolEnvPSG	VolEnv_04
	dc.b nB6, $0C
	sRet

SSZ_DAC_Intro:
	sPan		spCenter, $00
	dc.b nRst, $60, nRst, nRst, nRst, $17, nRst, $0C
	dc.b dSnare, nRst, dSnare, nRst, dKick, $06, dKick
	sRet

SSZ_DAC_0:
	sPan		spCenter, $00
	dc.b dKick, $05, dKick, dKick, $0E, nRst, $0C, dMuffledSnare
	dc.b $05, dMuffledSnare, dMuffledSnare, $0E, dMuffledSnare, $0C, nRst, dKick
	dc.b $06, dKick, dKick, $0C, dKick, nRst, dMuffledSnare, $05
	dc.b dMuffledSnare, dMuffledSnare, $0E, dMuffledSnare, $0C, nRst, dKick, dKick
	dc.b $0C, dKick, nRst, dMuffledSnare, $05, dMuffledSnare, dMuffledSnare, $0E
	dc.b dMuffledSnare, $0C, nRst, dKick, $06, dKick, dKick, $0C
	dc.b dKick, nRst, dMuffledSnare, $05, dMuffledSnare, dMuffledSnare, $08
	sPan		spLeft, $00
	dc.b dElectricMidTom, $06, dElectricMidTom, dElectricMidTom
	sPan		spCenter, $00
	dc.b dElectricLowTom, dElectricLowTom
	sPan		spRight, $00
	dc.b dElectricFloorTom, nRst
	sRet

SSZ_DAC:
SSZ_Jump7:
	sCall		SSZ_DAC_Intro

SSZ_Loop18:
	sCall		SSZ_DAC_0
	sLoop		$00, $08, SSZ_Loop18
	dc.b nRst, $01
	sJump		SSZ_Jump7

SSZ_Patches:
	; Patch $00
	; $34
	; $02, $02, $02, $02,	$1F, $5F, $1F, $5F
	; $0E, $00, $12, $00,	$00, $08, $02, $08
	; $4F, $0F, $4F, $0F,	$12, $80, $12, $80
	spAlgorithm	$04
	spFeedback	$06
	spDetune	$00, $00, $00, $00
	spMultiple	$02, $02, $02, $02
	spRateScale	$00, $00, $01, $01
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $02, $08, $08
	spSustainRt	$0E, $12, $00, $00
	spSustainLv	$04, $04, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$12, $12, $00, $00

	; Patch $01
	; $3D
	; $01, $01, $01, $11,	$1C, $18, $18, $1B
	; $06, $05, $04, $05,	$06, $05, $06, $06
	; $60, $89, $59, $79,	$18, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $01
	spMultiple	$01, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1C, $18, $18, $1B
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$06, $06, $05, $06
	spSustainRt	$06, $04, $05, $05
	spSustainLv	$06, $05, $08, $07
	spReleaseRt	$00, $09, $09, $09
	spTotalLv	$18, $00, $00, $00

	; Patch $02
	; $3D
	; $02, $01, $01, $11,	$1C, $18, $18, $1B
	; $06, $05, $04, $05,	$06, $05, $06, $06
	; $6F, $8F, $5F, $7F,	$18, $88, $88, $88
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $01
	spMultiple	$02, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1C, $18, $18, $1B
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$06, $06, $05, $06
	spSustainRt	$06, $04, $05, $05
	spSustainLv	$06, $05, $08, $07
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$18, $08, $08, $08

	; Patch $03
	; $04
	; $02, $02, $03, $03,	$13, $10, $13, $10
	; $06, $0C, $06, $0C,	$00, $00, $00, $00
	; $4F, $2F, $4F, $2F,	$18, $90, $18, $90
	spAlgorithm	$04
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$02, $03, $02, $03
	spRateScale	$00, $00, $00, $00
	spAttackRt	$13, $13, $10, $10
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$06, $06, $0C, $0C
	spSustainLv	$04, $04, $02, $02
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$18, $18, $10, $10

	; Patch $04 - FM_CLStatPiano
	dc.b $3C
	dc.b $72,$72,$32,$31, $1F,$1F,$1F,$1F
	dc.b $04,$04,$04,$04, $06,$05,$06,$05
	dc.b $0F,$0F,$0F,$0F, $18,$80,$28,$80

	; Patch $05 - FM_CLSynPiano
	dc.b $04
	dc.b $76,$76,$36,$36, $1F,$12,$1F,$1F
	dc.b $00,$00,$00,$00, $08,$00,$08,$00
	dc.b $0F,$0F,$0F,$0F, $14,$84,$14,$84

	; Patch $06 - FM_CLSlapBass
	dc.b $38
	dc.b $36,$35,$30,$31, $DF,$DF,$9F,$9F
	dc.b $07,$06,$09,$06, $07,$06,$06,$08
	dc.b $20,$10,$10,$F8, $28,$38,$14,$80
