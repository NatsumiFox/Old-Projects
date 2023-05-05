Gay_Header:
	sHeaderInit						; Z80 offset is $CEC7
	sHeaderTempo	$01, $40
	sHeaderCh	$05, $03
	sHeaderDAC	Gay_DAC1
	sHeaderDAC	Gay_DAC2
	sHeaderFM	Gay_FM1, $0C, $09
	sHeaderFM	Gay_FM2, $0C, $19
	sHeaderFM	Gay_FM3, $0C, $19
	sHeaderFM	Gay_FM4, $00, $0C
	sHeaderFM	Gay_FM5, $00, $0C
	sHeaderPSG	Gay_PSG1, $F4-$0C, $03, $00, VolEnv_00
	sHeaderPSG	Gay_PSG2, $E8-$0C, $03, $00, VolEnv_00
	sHeaderPSG	Gay_PSG3, $00, $00, $00, VolEnv_00

	; Patch $00
	; $08
	; $0A, $70, $30, $00,	$1F, $1F, $5F, $5F
	; $12, $0E, $0A, $0A,	$00, $04, $04, $03
	; $2F, $2F, $2F, $2F,	$24, $2D, $13, $80
	spAlgorithm	$00
	spFeedback	$01
	spDetune	$00, $03, $07, $00
	spMultiple	$0A, $00, $00, $00
	spRateScale	$00, $01, $00, $01
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$12, $0A, $0E, $0A
	spSustainRt	$00, $04, $04, $03
	spSustainLv	$02, $02, $02, $02
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$24, $13, $2D, $00

	; Patch $01
	; $3D
	; $12, $21, $51, $12,	$12, $14, $14, $0F
	; $0A, $05, $05, $05,	$00, $00, $00, $00
	; $2B, $2B, $2B, $1B,	$19, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$01, $05, $02, $01
	spMultiple	$02, $01, $01, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$12, $14, $14, $0F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0A, $05, $05, $05
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$02, $02, $02, $01
	spReleaseRt	$0B, $0B, $0B, $0B
	spTotalLv	$19, $00, $00, $00

	; Patch $02
	; $3A
	; $01, $07, $01, $01,	$8E, $8E, $8D, $53
	; $0E, $0E, $0E, $03,	$00, $00, $00, $07
	; $1F, $FF, $1F, $0F,	$18, $28, $27, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $01, $07, $01
	spRateScale	$02, $02, $02, $01
	spAttackRt	$0E, $0D, $0E, $13
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0E, $0E, $0E, $03
	spSustainRt	$00, $00, $00, $07
	spSustainLv	$01, $01, $0F, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$18, $27, $28, $00

	; Patch $03
	; $15
	; $71, $72, $01, $31,	$0F, $14, $14, $14
	; $00, $05, $02, $02,	$00, $00, $00, $00
	; $0F, $1F, $1F, $1F,	$2D, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$02
	spDetune	$07, $00, $07, $03
	spMultiple	$01, $01, $02, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$0F, $14, $14, $14
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $02, $05, $02
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$00, $01, $01, $01
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$2D, $00, $00, $00

Gay_FM1:
	sVoice		$00
	sPan		spCenter, $00
	ssMod68K	$07, $01, $03, $05
	dc.b nEb2, $06, nRst, nEb2, nEb2, nFs2, nRst, nFs2
	dc.b nRst, nG2, $18, nC3, nG1, $06, nRst, nG2
	dc.b nG2, nG2, nRst, nG1, nG1, nG1, nRst, nG2
	dc.b nG2, nG2, nAb2, nG2, nG2

Gay_Loop1:
	sCall		Gay_Call1
	sCall		Gay_Call2
	sLoop		$00, $02, Gay_Loop1
	dc.b nBb1, nRst, nF1, nRst, nBb1, $18, nRst, $0C
	dc.b nF1, nAb1, nRst, nEb2, nRst, nG2, nD2, nB1
	dc.b nG1
	sCall		Gay_Call1
	dc.b nAb1, $18, nRst, $0C, nEb1, $06, nEb1, nEb2
	dc.b $0C, nAb1, nBb1, nB1
	sCall		Gay_Call1
	sCall		Gay_Call2
	dc.b nBb1, nRst, nF1, nRst, nBb1, $18, nRst, $0C
	dc.b nF1, nAb1, nRst, nEb2, nRst, nG2, nEb2, nB1
	dc.b nFs1
	sJump		Gay_Loop1

Gay_Call1:
	dc.b nC2, $0C, nRst, nG1, nRst, nC2, $18, nRst
	dc.b $0C, nG1
	sRet

Gay_Call2:
	dc.b nAb1, nRst, nEb2, nRst, nC2, nEb1, nF1, nEb1
	sRet

Gay_FM2:
	sVoice		$03
	sPan		spLeft, $00
	saVolFM		$FB
	ssMod68K	$07, $01, $03, $05
	dc.b nEb3, $03, nRst, nEb3, nRst, nEb3, nRst, nEb3
	dc.b nRst, nEb3, nRst, $09, nEb3, $03, nRst, $09
	dc.b nEb3, $12, nRst, $06, nG3, $12, nRst, $06
	dc.b nG3, $12, nC4, $03, nRst, nB3, $12, nAb3
	dc.b $03, nRst, nG3, nRst, $09, nB3, $03, nRst
	dc.b $09
	ssMod68K	$0C, $01, $09, $07
	dc.b nD4, $18
	ssMod68K	$07, $01, $03, $05
	sVoice		$01
	sPan		spCenter, $00
	saVolFM		$05

Gay_Loop2:
	sCall		Gay_Call3
	sLoop		$00, $02, Gay_Loop2
	ssMod68K	$18, $01, $07, $05
	dc.b nEb4, $2A, nRst, $06, nD4, $12, nRst, $06
	dc.b nEb4, $12, nRst, $06, nC4, $30, nBb3, $18
	dc.b nB3
	ssMod68K	$07, $01, $03, $05
	sJump		Gay_Loop2

Gay_Call3:
	dc.b nC4, $1E, nRst, $06, nG3, nRst, nC4, $12
	dc.b nRst, $06, nE4, $12, nRst, $06, nEb4, nRst
	ssMod68K	$18, $01, $09, $07
	dc.b nD4, $4E, nRst, $06
	ssMod68K	$07, $01, $03, $05
	sRet

Gay_FM3:
	sVoice		$03
	sPan		spRight, $00
	saVolFM		$FB
	ssMod68K	$07, $01, $03, $05
	dc.b nFs3, $03, nRst, nFs3, nRst, nFs3, nRst, nFs3
	dc.b nRst, nFs3, nRst, $09, nAb3, $03, nRst, $09
	dc.b nG3, $12, nRst, $06, nC4, $12, nRst, $06
	dc.b nB3, $12, nAb3, $03, nRst, nD4, $12, nC4
	dc.b $03, nRst, nB3, nRst, $09, nD4, $03, nRst
	dc.b $09
	ssMod68K	$0C, $01, $09, $07
	dc.b nG4, $18
	ssMod68K	$07, $01, $03, $05
	sVoice		$01
	sPan		spCenter, $00
	saVolFM		$05

Gay_Loop3:
	sCall		Gay_Call4
	sLoop		$00, $02, Gay_Loop3
	ssMod68K	$18, $01, $07, $05
	dc.b nBb3, $2A, nRst, $06, nBb3, $12, nRst, $06
	dc.b nBb3, $12, nRst, $06, nAb3, $30, nF3, $18
	dc.b nF3
	ssMod68K	$07, $01, $03, $05
	sJump		Gay_Loop3

Gay_Call4:
	dc.b nG3, $1E, nRst, $06, nE3, nRst, nG3, $12
	dc.b nRst, $06, nC4, $12, nRst, $06, nC4, nRst
	ssMod68K	$18, $01, $09, $07
	dc.b nAb3, $4E
	ssMod68K	$07, $01, $03, $05
	dc.b nRst, $06
	sRet

Gay_FM4:
	sVoice		$02
	sPan		spLeft, $00
	ssMod68K	$07, $01, $05, $07
	sNoteTimeOut	$04
	dc.b nFs4, $0C, nFs4, $06, nFs4, nFs4, $0C, nFs4
	dc.b nG4, nC5
	sNoteTimeOut	$00
	dc.b nEb5, $12, nRst, $06, nB4, $10, nRst, $02
	dc.b nAb4, $06, nG4, $10, nRst, $02, nF4, $06
	dc.b nEb4, nD4, nC4, nB3, nAb3, $0C, nG3
	sNoteTimeOut	$04

Gay_Loop4:
	sCall		Gay_Call5
	sLoop		$00, $02, Gay_Loop4
	sCall		Gay_Call6
	dc.b nRst, nG4, $04, nRst, $14, nG4, $04, nRst
	dc.b $14, nC5, $06, nC5, nC5, $0C, nC5, nRst
	dc.b nEb4, $06, nEb4, nEb4, $0C, nEb4, $04, nRst
	dc.b $14, nAb4, $06, nAb4, nAb4, $0C, nAb4
	sCall		Gay_Call5
	sCall		Gay_Call6
	sJump		Gay_Loop4

Gay_Call5:
	dc.b nRst, nG4, $04, nRst, $14, nG4, $04, nRst
	dc.b $14, nC5, $06, nC5, nC5, $0C, nC5, nRst
	dc.b nEb4, $04, nRst, $14, nEb4, $04, nRst, $14
	dc.b nEb4, $06, nEb4, nEb4, $0C, nEb4
	sRet

Gay_Call6:
	dc.b nRst, nF4, $04, nRst, $14, nF4, $04, nRst
	dc.b $14, nF4, $06, nF4, nF4, $0C, nF4, nRst
	dc.b nEb4, $04, nRst, $14, nEb4, $04, nRst, $14
	dc.b nD4, $06, nD4, nF4, $0C, nF4
	sRet

Gay_FM5:
	sVoice		$02
	sPan		spRight, $00
	ssMod68K	$07, $01, $06, $08
	sNoteTimeOut	$04
	dc.b nC5, $0C, nC5, $06, nC5, nC5, $0C, nC5
	dc.b nEb5, nG5
	sNoteTimeOut	$00
	dc.b nG5, $12, nRst, $06, nG5, $10, nRst, $02
	dc.b nF5, $06, nEb5, $10, nRst, $02, nD5, $06
	dc.b nC5, nB4, nAb4, nG4, nF4, $0C, nEb4
	sNoteTimeOut	$04

Gay_Loop5:
	sCall		Gay_Call7
	sLoop		$00, $02, Gay_Loop5
	sCall		Gay_Call8
	dc.b nRst, nC5, $04, nRst, $14, nC5, $04, nRst
	dc.b $14, nE5, $06, nE5, nE5, $0C, nE5, nRst
	dc.b nAb4, $06, nAb4, nAb4, $0C, nAb4, nRst, nEb5
	dc.b $06, nEb5, nEb5, $0C, nEb5
	sCall		Gay_Call7
	sCall		Gay_Call8
	sJump		Gay_Loop5

Gay_Call7:
	dc.b nRst, nC5, $04, nRst, $14, nC5, $04, nRst
	dc.b $14, nE5, $06, nE5, nE5, $0C, nE5, nRst
	dc.b nAb4, $04, nRst, $14, nAb4, $04, nRst, $14
	dc.b nAb4, $06, nAb4, nAb4, $0C, nAb4
	sRet

Gay_Call8:
	dc.b nRst, nBb4, $04, nRst, $14, nBb4, $04, nRst
	dc.b $14, nBb4, $06, nBb4, nBb4, $0C, nBb4, nRst
	dc.b nAb4, $04, nRst, $14, nAb4, $04, nRst, $14
	dc.b nG4, $06, nG4, nBb4, $0C, nB4
	sRet

Gay_PSG1:
	sVolEnvPSG	VolEnv_14
	saVol	$FF
	dc.b nRst, $12, nFs3, $04, nRst, $02, nEb3, $04
	dc.b nRst, $08, nFs3, $04, nRst, $08, nG3, $04
	dc.b nRst, $08, nC4, $04, nRst, $08, nC4, $12
	dc.b nRst, $06
	saVol	$03
	dc.b nG3, $04, nAb3, nG3, nAb3, nG3, nAb3
	saVol	$FF
	dc.b nG3, nAb3, nG3, nAb3, nG3, nAb3
	saVol	$FF
	dc.b nG3, nAb3, nG3, nAb3, nG3, nAb3
	saVol	$FF
	dc.b nG3, nAb3, nG3
	saVol	$FF
	dc.b nAb3, nG3, nAb3
	saVol	$02

Gay_Jump1:
	dc.b nC4, $04, nRst, $2C, nC4, $04, nRst, $2C
	dc.b nAb3, $04, nRst, $14, nAb3, $04, nRst, $14
	dc.b nAb3, $04, nRst, $08, nEb3, $04, nRst, $08
	dc.b nC3, $04, nRst, $08, nEb3, $04, nRst, $08
	dc.b nC4, $04, nRst, $2C, nC4, $04, nRst, $2C
	dc.b nAb3, $04, nRst, $14, nEb3, $18, nC3, nEb2
	dc.b nBb2, $04, nRst, $2C, nBb2, $04, nRst, $2C
	dc.b nAb2, $04, nRst, $14, nAb2, $04, nRst, $14
	dc.b nG2, $0C, nF2, nFs2, nG2
	saVol	$FF
	dc.b nC4, $02, nD4, nE4, $14, nC4, $18, nG3
	dc.b nE3, nAb2, $06, nRst, $0C, nAb2, $06, nC3
	dc.b nRst, nEb3, nRst, nAb3, nRst, nAb3, nRst, nAb3
	dc.b nRst, nEb3, nRst
	saVol	$01
	dc.b nE3, $04, nRst, $2C, nE3, $04, nRst, $2C
	dc.b nAb3, $04, nRst, $14, nAb3, $04, nRst, $14
	dc.b nAb3, $04, nRst, $08, nEb3, $04, nRst, $08
	dc.b nC3, $04, nRst, $08, nEb3, $04, nRst, $08
	dc.b nBb3, $04, nRst, $2C, nBb3, $04, nRst, $2C
	dc.b nAb3, $04, nRst, $14, nEb3, $18, nB2, nFs2
	sJump		Gay_Jump1

Gay_PSG2:
	sVolEnvPSG	VolEnv_17
	saTranspose	$0C
	saVol	$FF
	dc.b nRst, $12, nEb3, $04, nRst, $02, nAb3, $04
	dc.b nRst, $08, nEb3, $04, nRst, $08, nEb3, $04
	dc.b nRst, $08, nG3, $04, nRst, $08, nG3, $12
	dc.b nRst, $06
	saVol	$03
	dc.b nG3, $04, nAb3, nG3, nAb3, nG3, nAb3
	saVol	$FF
	dc.b nG3, nAb3, nG3, nAb3, nG3, nAb3
	saVol	$FF
	dc.b nG3, nAb3, nG3, nAb3, nG3, nAb3
	saVol	$FF
	dc.b nG3, nAb3, nG3
	saVol	$FF
	dc.b nAb3, nG3, nAb3
	saVol	$02
	saTranspose	$F4

Gay_Jump2:
	sNoteTimeOut	$04
	dc.b nC3, $18, nE3, nC3, nE3, nC4
	sNoteTimeOut	$00
	saVol	$FF
	dc.b nAb4, $18, nEb4, nC4
	saVol	$01
	sNoteTimeOut	$04
	dc.b nC3, $18, nE3, nC3, nE3
	sNoteTimeOut	$00
	saVol	$FF
	dc.b nAb4, $18, nEb4, $04, nRst, $10, nEb4, $04
	dc.b $0C, nC4, nAb3, nEb3
	saVol	$01
	sNoteTimeOut	$04
	dc.b nD4, $18, nF4, nD4, nF4, nC4
	sNoteTimeOut	$00
	saVol	$FF
	dc.b nAb4, $18, nD4, nEb4
	saVol	$01
	sNoteTimeOut	$04
	dc.b nC3, $18, nE3, nC3, nE3
	saVol	$FF
	sNoteTimeOut	$00
	dc.b nC4, $30, nRst, $0C, nAb4, $04, nRst, $02
	dc.b nAb4, $04, nRst, $02, nAb4, $04, nRst, $08
	dc.b nAb4, $04, nRst, $08
	saVol	$01
	sNoteTimeOut	$04
	dc.b nC3, $18, nE3, nC3, nE3, nC4
	sNoteTimeOut	$00
	saVol	$FF
	dc.b nAb4, $18, nEb4, nC4
	saVol	$01
	sNoteTimeOut	$04
	dc.b nD4, $18, nF4, nD4, nF4
	sNoteTimeOut	$00
	saVol	$FF
	dc.b nAb4, $18, nEb4, $06, nRst, $0C, nEb4, $04
	dc.b nRst, $02, nD4, $0C, nB3, $06, nRst, nB3
	dc.b $0C, nFs3, $06, nRst
	saVol	$01
	sJump		Gay_Jump2

Gay_PSG3:
	sNoisePSG	$E7
	sVolEnvPSG	VolEnv_16
	dc.b nA5, $30
	sVolEnvPSG	VolEnv_16
	dc.b nA5
	sVolEnvPSG	VolEnv_16
	dc.b $18, $48

Gay_Jump3:
	sVolEnvPSG	VolEnv_16
	dc.b nA5, $30
	sVolEnvPSG	VolEnv_15
	dc.b nA5
	sVolEnvPSG	VolEnv_15
	dc.b nA5
	sVolEnvPSG	VolEnv_15
	dc.b nA5
	sVolEnvPSG	VolEnv_16
	dc.b nA5
	sVolEnvPSG	VolEnv_15
	dc.b nA5
	sVolEnvPSG	VolEnv_15
	dc.b nA5
	sVolEnvPSG	VolEnv_15
	dc.b nA5
	sVolEnvPSG	VolEnv_16
	dc.b nA5
	sVolEnvPSG	VolEnv_16
	dc.b nA5
	sVolEnvPSG	VolEnv_16
	dc.b nA5
	sVolEnvPSG	VolEnv_16
	dc.b nA5
	sVolEnvPSG	VolEnv_16
	dc.b nA5
	sVolEnvPSG	VolEnv_15
	dc.b nA5
	sVolEnvPSG	VolEnv_16
	dc.b nA5
	sVolEnvPSG	VolEnv_16
	dc.b nA5
	sVolEnvPSG	VolEnv_16
	dc.b nA5
	sVolEnvPSG	VolEnv_15
	dc.b nA5
	sVolEnvPSG	VolEnv_15
	dc.b nA5
	sVolEnvPSG	VolEnv_15
	dc.b nA5
	sVolEnvPSG	VolEnv_16
	dc.b nA5
	sVolEnvPSG	VolEnv_16
	dc.b nA5
	sVolEnvPSG	VolEnv_16
	dc.b nA5
	sVolEnvPSG	VolEnv_16
	dc.b nA5
	sJump		Gay_Jump3

ccpd	macro note
	rept narg
		if \note>=nRst
			sComm	$07, \note
		endif

		dc.b \note
	shift
	endr
    endm

Gay_DAC1:
	ccpd dKick, $0C, dSnare, $03, dSnare, dSnare, dSnare, dSnare
	ccpd $18, dKick, $0C, dSnare, $03, dSnare, dSnare, dSnare
	ccpd dSnare, $18, dKick, $0C, dSnare, $04, dSnare, dSnare
	ccpd dSnare, $06, dSnare, dSnare, dSnare, dSnare, dSnare, dSnare
	ccpd dSnare, dSnare, $0C, $06, dSnare

Gay_Loop6:
	ccpd dKick, $0C, dSnare, dKick, dSnare, dKick, dSnare, dSnare
	ccpd dSnare, dKick, dSnare, dDrumHi3D, dDrumLow3D, dDrumHi3D, dDrumLow3D, dDrumHi3D
	ccpd dDrumLow3D
	sLoop		$00, $02, Gay_Loop6
	ccpd dKick, $0C, dSnare, dKick, dSnare, dKick, dSnare, dSnare
	ccpd dSnare, dKick, dSnare, dDrumHi3D, dDrumLow3D, dDrumHi3D, dDrumLow3D, dDrumHi3D
	ccpd dSnare, $04, dSnare, dSnare, dKick, $0C, dSnare, dKick
	ccpd dSnare, dKick, dSnare, dSnare, dSnare, dKick, dSnare, dSnare
	ccpd $0F, $03, dSnare, dSnare, dKick, $0C, dSnare, dSnare
	ccpd $0F, $03, dSnare, dSnare, dKick, $0C, dSnare, dKick
	ccpd dSnare, dKick, dSnare, dSnare, dSnare, dKick, dSnare, dDrumHi3D
	ccpd dDrumLow3D, dDrumHi3D, dDrumLow3D, dDrumHi3D, dSnare, $04, dSnare, dSnare
	ccpd dKick, $0C, dSnare, dKick, dSnare, dKick, dSnare, dSnare
	ccpd dSnare, dKick, dSnare, dDrumHi3D, dDrumLow3D, dDrumHi3D, $18, dSnare
	ccpd $0C, $06, dSnare
	sJump		Gay_Loop6

Gay_DAC2:
	dc.b nRst, $7F, $41

Gay_Loop7:
	dc.b nRst, $78
	dc.b dDrumHi3D, $0C, dDrumLow3D, dDrumHi3D, dDrumLow3D, dDrumHi3D, dDrumLow3D
	sLoop		$00, $02, Gay_Loop7
	dc.b nRst, $78
	dc.b dDrumHi3D, $0C, dDrumLow3D, dDrumHi3D, dDrumLow3D, dDrumHi3D
	dc.b nRst, $7F, $7F, $46
	dc.b dDrumHi3D, $0C, dDrumLow3D, dDrumHi3D, dDrumLow3D, dDrumHi3D
	dc.b nRst, $7F, $05
	dc.b dDrumHi3D, $0C, dDrumLow3D, dDrumHi3D, $18
	dc.b nRst, $18
	sJump		Gay_Loop7
