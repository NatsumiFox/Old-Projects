MinibossS3_Header:
	sHeaderInit	; Z80 offset is $F1A0
	sHeaderPatch	MinibossS3_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $44
	sHeaderDAC	MinibossS3_DAC
	sHeaderFM	MinibossS3_FM1, $C2, $03
	sHeaderFM	MinibossS3_FM2, $0C, $0B
	sHeaderFM	MinibossS3_FM3, $0C, $10
	sHeaderFM	MinibossS3_FM4, $00, $14
	sHeaderFM	MinibossS3_FM5, $00, $14
	sHeaderPSG	MinibossS3_PSG1, $00, $00, $00, VolEnv_00
	sHeaderPSG	MinibossS3_PSG2, $03, $01, $00, VolEnv_00
	sHeaderPSG	MinibossS3_PSG3, $00, $00, $00, VolEnv_00

MinibossS3_FM1:
MinibossS3_Jump8:
	sPatFM		$04
	dc.b nC1, $18, nRst, $48
	sCall		MinibossS3_Call7
	sCall		MinibossS3_Call8
	sCall		MinibossS3_Call7
	sCall		MinibossS3_Call9
	sCall		MinibossS3_Call7
	sCall		MinibossS3_Call8
	sCall		MinibossS3_Call7
	sCall		MinibossS3_Call10
	sCall		MinibossS3_Call11
	sCall		MinibossS3_Call12
	sCall		MinibossS3_Call11
	sCall		MinibossS3_Call13
	sCall		MinibossS3_Call11
	sCall		MinibossS3_Call12
	sCall		MinibossS3_Call14
	sCall		MinibossS3_Call13

MinibossS3_Loop7:
	sCall		MinibossS3_Call11
	sCall		MinibossS3_Call12
	sCall		MinibossS3_Call11
	sCall		MinibossS3_Call13
	sLoop		$00, $02, MinibossS3_Loop7
	sPatFM		$04
	dc.b nC1, $12, nC1, nC1, nC1, nC1, nC1, $06
	dc.b nRst, $0C, nC1, $12, nC1, nC1, nC1, nC1
	dc.b $0C, nRst, $60
	sJump		MinibossS3_Jump8

MinibossS3_Call7:
	sPatFM		$04
	dc.b nC1, $0C, nRst, $07, nC1, $05, nRst, $0C
	dc.b nC1, nRst, nC1, nRst, $18
	sRet

MinibossS3_Call8:
	sPatFM		$04
	dc.b nC1, $0C, nRst, $07, nC1, $05, nRst, $0C
	dc.b nC1, nRst, $07, nC1, $05, nC1, $0C, nRst
	dc.b $18
	sRet

MinibossS3_Call9:
	sPatFM		$04
	dc.b nC1, $0C, nRst, $18, nRst, $0C, nRst, nRst
	dc.b nRst, nRst
	sRet

MinibossS3_Call10:
	sPatFM		$04
	dc.b nC1, $18, nRst, nC1, $03, nC1, nC1, nC1
	dc.b nC1, nC1, nC1, nC1, nC1, $18
	sRet

MinibossS3_Call11:
	sPatFM		$04
	dc.b nC1, $0C, nRst, $07, nC1, $05
	sPatFM		$05
	dc.b nE3, $0C
	sPatFM		$04
	dc.b nC1, nRst, nC1
	sPatFM		$05
	dc.b nE3, $18
	sRet

MinibossS3_Call12:
	sPatFM		$04
	dc.b nC1, $0C, nRst, $07, nC1, $05
	sPatFM		$05
	dc.b nE3, $0C
	sPatFM		$04
	dc.b nC1, nRst, $07, nC1, $05, nC1, $0C
	sPatFM		$05
	dc.b nE3, $13, nE3, $05
	sRet

MinibossS3_Call13:
	sPatFM		$04
	dc.b nC1, $0C, nRst
	sPatFM		$05
	dc.b nE3
	sPatFM		$04
	dc.b nC1, nC1, nC1
	sPatFM		$05
	dc.b nE3
	sPatFM		$04
	dc.b nC1, $07
	sPatFM		$05
	dc.b nE3, $05
	sRet

MinibossS3_Call14:
	sPatFM		$04
	dc.b nC1, $0C, nRst, $07, nC1, $05
	sPatFM		$05
	dc.b nE3, $0C
	sPatFM		$04
	dc.b nC1, nRst, $07, nRst, $05, nC1, $0C
	sPatFM		$05
	dc.b nE3, $13, nE3, $05
	sRet

MinibossS3_FM2:
MinibossS3_Jump7:
	sPatFM		$00
	dc.b nBb2, $04, nRst, $03, $05, nRst, $07, nBb2
	dc.b $05, nF2, $04, nRst, $03, $05, nRst, $07
	dc.b nF2, $05, nBb1, $07, nRst, $29
	sCall		MinibossS3_Call5
	sCall		MinibossS3_Call6
	sCall		MinibossS3_Call5
	dc.b nEb2, $04, nRst, $03, nBb1, $05, nFs2, $0C
	dc.b nBb1, nCs2
	sCall		MinibossS3_Call5
	sCall		MinibossS3_Call6
	dc.b nEb2, $04, nRst, $03, nEb2, $05, nD2, $0C
	dc.b nCs2, nC2, nB1, nBb1, nB1, nD2
	sCall		MinibossS3_Call5
	sCall		MinibossS3_Call6
	sCall		MinibossS3_Call5
	dc.b nEb2, $04, nRst, $03, nBb1, $05, nFs2, $0C
	dc.b nBb1, nCs2
	sCall		MinibossS3_Call5
	sCall		MinibossS3_Call6
	dc.b nEb2, $04, nRst, $03, nEb2, $05, nD2, $0C
	dc.b nCs2, nC2, nRst, $24, nE2, $0C
	ssModZ80	$18, $01, $FE, $FF
	dc.b nEb2, $30, nRst, $30
	sModOff
	dc.b nRst, $60, nRst, nEb2, $04, nRst, $03, nEb2
	dc.b $05, nD2, $0C, nCs2, nC2, nB1, nC2, nRst
	dc.b nD2
	sCall		MinibossS3_Call5
	sCall		MinibossS3_Call6
	sCall		MinibossS3_Call5
	dc.b nEb2, $04, nRst, $03, nBb1, $05, nFs2, $0C
	dc.b nBb1, nCs2
	sCall		MinibossS3_Call5
	sCall		MinibossS3_Call6
	dc.b nEb2, $04, nRst, $03, nEb2, $05, nD2, $0C
	dc.b nCs2, nC2, nB1, nBb1, nB1, nD2, nRst, $60
	dc.b nRst, nRst, nRst
	sCall		MinibossS3_Call5
	sCall		MinibossS3_Call6
	sCall		MinibossS3_Call5
	dc.b nEb2, $04, nRst, $03, nBb1, $05, nFs2, $0C
	dc.b nBb1, nCs2
	sCall		MinibossS3_Call5
	sCall		MinibossS3_Call6
	dc.b nEb2, $04, nRst, $03, nEb2, $05, nD2, $0C
	dc.b nCs2, nC2, nB1, nBb1, nB1, nD2, nEb2, $24
	dc.b nD2, nCs2, nC2, nB1, nBb1, $6C
	sJump		MinibossS3_Jump7
	; Unused
	dc.b $F2

MinibossS3_Call5:
	dc.b nEb2, $04, nRst, $03, nEb2, $05, nD2, $0C
	dc.b nCs2, nD2
	sRet

MinibossS3_Call6:
	dc.b nEb2, $05, nRst, $07, nRst, nEb2, $05, nRst
	dc.b $15, nD2, $03
	sRet

MinibossS3_FM3:
MinibossS3_Jump6:
	sPatFM		$02
	ssModZ80	$01, $01, $01, $08
	dc.b nBb4, $07, nBb4, $05, nRst, $07, nBb4, $05
	dc.b nBb4, $07, nBb4, $05, nRst, $07, nBb4, $05
	dc.b nBb4, nRst, $2B, nRst, $1F, nBb3, $05, nC4
	dc.b nRst, $07, nCs4, $05, nRst, $07, nC4, nCs4
	dc.b $05, nC4, $07, nAb3, $05, nFs3, nRst, $07
	dc.b nRst, $60, nRst, $0C
	ssModZ80	$05, $01, $13, $0E
	dc.b nCs4
	sModOff
	saVolFM		$0A
	dc.b nCs4, $06, nRst
	saVolFM		$F6
	ssModZ80	$05, $01, $13, $0E
	dc.b nAb3, $0C
	sModOff
	saVolFM		$0A
	dc.b nAb3, $06, nRst
	saVolFM		$F6
	ssModZ80	$05, $01, $13, $0E
	dc.b nFs3, $0C
	sModOff
	saVolFM		$0A
	dc.b nFs3, $06, nRst
	saVolFM		$F6
	ssModZ80	$05, $01, $13, $0E
	dc.b nAb3, $0C
	ssModZ80	$01, $01, $01, $06
	dc.b nRst, $07, nFs3, $05, nRst, $0C, nEb3, $13
	sModOff
	dc.b nEb3, $05, nFs3, $07, nAb3, $05, nRst, $24
	dc.b nRst, $1F, nBb3, $05, nC4, nRst, $07, nCs4
	dc.b $05, nRst, $07, nC4, nCs4, $05, nC4, $07
	dc.b nRst, $05, nRst, $07, nBb3, $05, nC4, $07
	dc.b nCs4, $05, nC4, nRst, $0E, nBb3, $05, nC4
	dc.b $07, nCs4, $05, nC4, $07, nBb3, $05, nFs3
	dc.b $0C, nRst, $18, nRst, $30, nEb3, $04, nD3
	dc.b nEb3, nF3, nEb3, nF3, nFs3, nF3, nFs3, nAb3
	dc.b nFs3, nAb3, nBb3, nFs3, nCs4, nC4, nAb3, nB3
	dc.b nBb3, nFs3, nA3, nAb3, nFs3, nEb3, nRst, $18
	ssModZ80	$01, $01, $F1, $71
	dc.b nAb2
	ssModZ80	$01, $01, $01, $05
	saTranspose	$F4
	dc.b nRst, $0C, nEb4, $05, nRst, $07, nEb4, $05
	dc.b nRst, $07, nEb4, $05, nRst, $07, nEb4, $05
	dc.b nRst, $07, nEb4, $05, nRst, $07, nEb4, nFs4
	dc.b $05, nRst, $18, nEb4, $05, nRst, $07, nEb4
	dc.b $05, nRst, $07, nEb4, $05, nRst, $07, nEb4
	dc.b $05, nRst, $07, nEb4, $05, nRst, $07, nEb4
	dc.b nFs4, $05, nRst, $18, nEb4, $05, nRst, $07
	dc.b nEb4, $05, nRst, $07, nEb4, $05, nRst, $07
	dc.b nEb4, nFs4, $05, nAb4, $07, nFs4, $05, nEb4
	dc.b $07, nFs4, $05, nAb4, $07, nFs4, $05, nEb4
	dc.b $05, nRst, $07, nEb4, $05, nRst, $07, nEb4
	dc.b $05, nRst, $07, nEb4, $05, nRst, $07, nEb4
	dc.b nFs4, $05, nRst, $1F, nEb4, $04, nRst, $01
	sCall		MinibossS3_Call2

MinibossS3_Loop6:
	dc.b nRst, $5B, nEb4, $03, nRst, $02
	sCall		MinibossS3_Call2
	sLoop		$00, $03, MinibossS3_Loop6
	sCall		MinibossS3_Call3
	dc.b nRst, $60, nRst, $2B, nEb4, $05, nFs4, nRst
	dc.b $07, nFs4, $05, nRst, $07, nFs4, nAb4, $05
	dc.b nBb4, $07, nAb4, $05, nRst, $60
	sCall		MinibossS3_Call3
	sCall		MinibossS3_Call4
	saTranspose	$0C
	sJump		MinibossS3_Jump6

MinibossS3_Call4:
	sModEnv		ModEnv_07
	dc.b nEb4, $0C
	sModEnv		$08
	dc.b nD4, nEb4, nF4, nEb4, nF4
	sModEnv		ModEnv_07
	dc.b nFs4
	sModEnv		$08
	dc.b nF4, nFs4, $07, nRst, $05
	sModEnv		ModEnv_07
	dc.b nAb4, $0C
	sModEnv		$08
	dc.b nFs4, nAb4
	sModEnv		ModEnv_07
	dc.b nA4
	ssModZ80	$01, $01, $01, $08
	dc.b nAb4, nA4, nBb4, $0C, sHold, $60
	sRet

MinibossS3_Call2:
	dc.b nRst, $07, nFs4, $04, nRst, $08, nAb4, $05
	dc.b nRst, $13, nEb4, $05, nFs4, nRst, $07, nFs4
	dc.b $05, nRst, $07, nFs4, nAb4, $05, nRst, $0C
	sRet

MinibossS3_Call3:
	sModEnv		ModEnv_06
	dc.b nBb4, $0C
	sModOff
	dc.b nAb4, $07, nBb4, $05
	sModEnv		ModEnv_06
	dc.b nAb4, $0C
	sModOff
	dc.b nFs4, $07, nAb4, $05
	sModEnv		ModEnv_06
	dc.b nFs4, $0C
	sModOff
	dc.b nF4, $07, nFs4, $05
	sModEnv		ModEnv_06
	dc.b nF4, $0C
	sModOff
	dc.b nEb4, $05, nRst, $07
	sRet

MinibossS3_FM4:
MinibossS3_Jump5:
	sPatFM		$03
	saVolFM		$02
	dc.b nBb3, $07, nBb3, $05, nRst, $07, nBb3, $05
	dc.b nBb3, $07, nBb3, $05, nRst, $07, nBb3, $05
	dc.b nBb3, nRst, $2B
	saVolFM		$FE
	dc.b nBb3, $60, sHold, $30, nRst, $18, nB4, $18
	dc.b nBb3, $60, sHold, $30, nRst, $30, nBb3, $60
	dc.b sHold, $30, nRst, $18, nB4, $18, nBb3, $60
	dc.b nRst, $60, nBb3, $60, sHold, $30, nB3, $30
	dc.b nBb3, $60, sHold, $60, nFs3, $48, nRst, $18
	dc.b nF4, $60, nBb3, $60, nBb3, $60, nRst, $60
	dc.b nRst, nRst, nRst, nFs4, $60, nF4, $60, nEb4
	dc.b $60, nEb4, $60
	saTranspose	$F4
	saVolFM		$02
	sCall		MinibossS3_Call4
	saVolFM		$FE
	saTranspose	$0C
	sJump		MinibossS3_Jump5

MinibossS3_FM5:
	sPatFM		$03

MinibossS3_Jump4:
	ssModZ80	$01, $01, $01, $04
	saVolFM		$02
	dc.b nBb3, $07, nBb3, $05, nRst, $07, nBb3, $05
	dc.b nBb3, $07, nBb3, $05, nRst, $07, nBb3, $05
	dc.b nBb3, nRst, $2B
	saVolFM		$FE
	dc.b nF3, $60, sHold, $30, nRst, $18, nFs3, nF3
	dc.b $60, sHold, $48, nRst, $18, nF3, $60, sHold
	dc.b $48, nFs3, $18, nF3, $60, nRst, $60, nF3
	dc.b $60, sHold, $30, nFs3, $30, nF3, $60, sHold
	dc.b nF3, $60, nEb3, $48, nRst, $18, nC3, $60
	dc.b nB2, $60, nC3, $60, nRst, $60, nRst, nRst
	dc.b nRst, nEb4, $60, nC4, nB3, nC4
	saVolFM		$02
	sCall		MinibossS3_Call4
	saVolFM		$FE
	sJump		MinibossS3_Jump4

MinibossS3_PSG2:
MinibossS3_Jump2:
	sVolEnvPSG	VolEnv_1D
	ssModZ80	$01, $01, $05, $96
	dc.b nRst, $60, nG2, $10, nRst, $50, nRst, $60
	dc.b nRst, nRst, nG2, $10, nRst, $50, nRst, $60
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nG2, $10
	dc.b nRst, $50, nRst, $60, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nG2, $10, nRst, $50, nRst, $60
	dc.b nRst, nRst, nRst, nRst, nRst
	sJump		MinibossS3_Jump2

MinibossS3_PSG1:
MinibossS3_Jump3:
	sVolEnvPSG	VolEnv_22
	ssModZ80	$01, $01, $01, $08
	dc.b nBb4, $07, nBb4, $05, nRst, $07, nBb4, $05
	dc.b nBb4, $07, nBb4, $05, nRst, $07, nBb4, $05
	dc.b nBb4, nRst, $2B, nRst, $1F, nBb3, $05, nC4
	dc.b nRst, $07, nCs4, $05, nRst, $07, nC4, nCs4
	dc.b $05, nC4, $07, nAb3, $05, nFs3, nRst, $07
	dc.b nRst, $60, nRst, $0C
	ssModZ80	$05, $01, $13, $0E
	dc.b nCs4
	sModOff
	saVolPSG	$0A
	dc.b nCs4, $06, nRst
	saVolPSG	$F6
	ssModZ80	$05, $01, $13, $0E
	dc.b nAb3, $0C
	sModOff
	saVolPSG	$0A
	dc.b nAb3, $06, nRst
	saVolPSG	$F6
	ssModZ80	$05, $01, $13, $0E
	dc.b nFs3, $0C
	sModOff
	saVolPSG	$0A
	dc.b nFs3, $06, nRst
	saVolPSG	$F6
	ssModZ80	$05, $01, $13, $0E
	dc.b nAb3, $0C
	sModEnv		ModEnv_04
	dc.b nRst, $07, nFs3, $05, nRst, $0C, nEb3, $13
	sModOff
	dc.b nEb3, $05, nFs3, $07, nAb3, $05, nRst, $24
	dc.b nRst, $1F, nBb3, $05, nC4, nRst, $07, nCs4
	dc.b $05, nRst, $07, nC4, nCs4, $05, nC4, $07
	dc.b nRst, $05, nRst, $07, nBb3, $05, nC4, $07
	dc.b nCs4, $05, nC4, nRst, $0E, nBb3, $05, nC4
	dc.b $07, nCs4, $05, nC4, $07, nBb3, $05, nFs3
	dc.b $0C, nRst, $18, nRst, $30, nEb3, $04, nD3
	dc.b nEb3, nF3, nEb3, nF3, nFs3, nF3, nFs3, nAb3
	dc.b nFs3, nAb3, nBb3, nFs3, nCs4, nC4, nAb3, nB3
	dc.b nBb3, nFs3, nA3, nAb3, nFs3, nEb3, nRst, $18
	ssModZ80	$01, $01, $F1, $71
	dc.b nAb2
	sModEnv		ModEnv_04
	saTranspose	$F4
	dc.b nRst, $0C, nEb4, $05, nRst, $07, nEb4, $05
	dc.b nRst, $07, nEb4, $05, nRst, $07, nEb4, $05
	dc.b nRst, $07, nEb4, $05, nRst, $07, nEb4, nFs4
	dc.b $05, nRst, $18, nEb4, $05, nRst, $07, nEb4
	dc.b $05, nRst, $07, nEb4, $05, nRst, $07, nEb4
	dc.b $05, nRst, $07, nEb4, $05, nRst, $07, nEb4
	dc.b nFs4, $05, nRst, $18, nEb4, $05, nRst, $07
	dc.b nEb4, $05, nRst, $07, nEb4, $05, nRst, $07
	dc.b nEb4, nFs4, $05, nAb4, $07, nFs4, $05, nEb4
	dc.b $07, nFs4, $05, nAb4, $07, nFs4, $05, nEb4
	dc.b $05, nRst, $07, nEb4, $05, nRst, $07, nEb4
	dc.b $05, nRst, $07, nEb4, $05, nRst, $07, nEb4
	dc.b nFs4, $05, nRst, $1F, nEb4, $04, nRst, $01
	sCall		MinibossS3_Call2

MinibossS3_Loop5:
	dc.b nRst, $5B, nEb4, $03, nRst, $02
	sCall		MinibossS3_Call2
	sLoop		$00, $03, MinibossS3_Loop5
	sCall		MinibossS3_Call3
	dc.b nRst, $60, nRst, $2B, nEb4, $05, nFs4, nRst
	dc.b $07, nFs4, $05, nRst, $07, nFs4, nAb4, $05
	dc.b nBb4, $07, nAb4, $05, nRst, $60
	sCall		MinibossS3_Call3
	sCall		MinibossS3_Call4
	saTranspose	$0C
	sJump		MinibossS3_Jump3

MinibossS3_PSG3:
MinibossS3_Jump1:
	sNoisePSG	$E7
	dc.b nRst, $60
	sVolEnvPSG	VolEnv_26
	dc.b nBb6, $60
	sVolEnvPSG	VolEnv_02
	sCall		MinibossS3_Call1
	dc.b nRst, $60
	sCall		MinibossS3_Call1
	sVolEnvPSG	VolEnv_26
	dc.b nBb6, $60
	sVolEnvPSG	VolEnv_02
	sCall		MinibossS3_Call1
	dc.b nRst, $48, nBb6, $07, nRst, $0C, nBb6, $05
	dc.b nRst, $0C, nBb6, nRst, nBb6, nBb6, nBb6, nBb6
	dc.b nRst

MinibossS3_Loop1:
	sCall		MinibossS3_Call1
	sLoop		$00, $03, MinibossS3_Loop1
	dc.b nBb6, $0C, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6
	dc.b nRst

MinibossS3_Loop2:
	sCall		MinibossS3_Call1
	sLoop		$00, $03, MinibossS3_Loop2
	dc.b nBb6, $07
	saVolPSG	$04
	dc.b $05, $07
	saVolPSG	$FC
	dc.b $05
	saVolPSG	$04
	dc.b $07, $05
	saVolPSG	$FC
	dc.b $07
	saVolPSG	$04
	dc.b $05
	saVolPSG	$FC
	dc.b nBb6, $0C, nBb6, nBb6, nRst

MinibossS3_Loop3:
	sCall		MinibossS3_Call1
	sLoop		$00, $03, MinibossS3_Loop3
	dc.b nRst, $60

MinibossS3_Loop4:
	sCall		MinibossS3_Call1
	sLoop		$00, $03, MinibossS3_Loop4
	dc.b nBb6, $0C, nRst, $07, nBb6, $05, nRst, $0C
	dc.b nBb6, nBb6, nBb6, nBb6, nRst, nRst, $60, nRst
	dc.b nRst
	sJump		MinibossS3_Jump1
	; Unused
	dc.b $F2

MinibossS3_Call1:
	dc.b nBb6, $07
	saVolPSG	$04
	dc.b $05, $07
	saVolPSG	$FC
	dc.b $05
	saVolPSG	$04
	dc.b $07, $05
	saVolPSG	$FC
	dc.b $07
	saVolPSG	$04
	dc.b $05, $0C
	saVolPSG	$FC
	dc.b $24
	sRet

MinibossS3_DAC:
MinibossS3_Jump9:
	dc.b nRst, $30, $0C, dCrashingNoiseWoo, dComeOn, nRst, dHipHopHitKick, nRst
	dc.b $54, nRst, $0C, dLowerEchoedClapHit3, dEchoedClapHit3, $08, dLowerEchoedClapHit3, $04
	dc.b $0C, $0C, $08, $04, dEchoedClapHit3, $0C, dBassHey, dHipHopHitKick
	dc.b nRst, $54, nRst, $0C, dLowerEchoedClapHit3, dEchoedClapHit3, $08, dLowerEchoedClapHit3
	dc.b $04, $0C, dHipHopHitKick, dHipHopHitPowerKick, dPowerKickHit, dLowPowerKickHit, dHipHopHitKick, nRst
	dc.b $48, dHipHopHitKick, $0C, nRst, $0C, dLowerEchoedClapHit3, dHipHopHitKick, $08
	dc.b dLowerEchoedClapHit3, $04, $0C, $0C, $08, dEchoedClapHit3, $04, dLowestPowerKickHit
	dc.b $0C, dBassHey, dHipHopHitKick, $48, dLowerEchoedClapHit3, $0C, $08, $04
	dc.b $08, dEchoedClapHit3, $04, dLowerEchoedClapHit3, $0C, $0C, $08, $04
	dc.b dHipHopHitKick, $0C, dHipHopHitPowerKick, nRst, dWoo, dHipHopHitKick, $0C, dLowerEchoedClapHit3
	dc.b dEchoedClapHit3, $08, dLowerEchoedClapHit3, $04, $0C, $0C, $08, $04
	dc.b dEchoedClapHit3, $18, nRst, $0C, dLowerEchoedClapHit3, dEchoedClapHit3, $08, dLowerEchoedClapHit3
	dc.b $04, $0C, $14, $04, dEchoedClapHit3, $0C, dBassHey, dHipHopHitKick
	dc.b $0C, dLowerEchoedClapHit3, dEchoedClapHit3, $08, dLowerEchoedClapHit3, $04, $0C, $0C
	dc.b $08, $04, dEchoedClapHit3, $18, dHipHopHitKick, $07, $05, dHipHopHitPowerKick
	dc.b $0C, dPowerKickHit, dLowPowerKickHit, dLowerPowerKickHit, dLowPowerKickHit, dComeOn, dHipHopHitPowerKick, dHipHopHitKick
	dc.b $0C, dLowerEchoedClapHit3, dEchoedClapHit3, $08, dLowerEchoedClapHit3, $04, $0C, $0C
	dc.b $08, $04, dEchoedClapHit3, $18, nRst, $0C, dLowerEchoedClapHit3, dWoo
	dc.b $08, nRst, $04, dLowerEchoedClapHit3, $0C, $14, $04, dEchoedClapHit3
	dc.b $0C, dBassHey, nRst, $0C, dLowerEchoedClapHit3, dEchoedClapHit3, $08, dLowerEchoedClapHit3
	dc.b $04, $0C, $0C, $08, $04, dEchoedClapHit3, $18, nRst
	dc.b $0C, dLowerEchoedClapHit3, dEchoedClapHit3, $08, $04, $0C, dHipHopHitKick, dHipHopHitKick
	dc.b dComeOn, dHipHopHitKick, dHipHopHitKick, $0C, dLowerEchoedClapHit3, dEchoedClapHit3, $08, dLowerEchoedClapHit3
	dc.b $04, $0C, $0C, $08, $04, dEchoedClapHit3, $18, nRst
	dc.b $0C, dLowerEchoedClapHit3, dEchoedClapHit3, $08, dLowerEchoedClapHit3, $04, dWoo, $0C
	dc.b dLowerEchoedClapHit3, $14, $04, dEchoedClapHit3, $0C, dBassHey, dHipHopHitKick, $0C
	dc.b dLowerEchoedClapHit3, dEchoedClapHit3, $08, $04, $0C, $0C, $08, $04
	dc.b dEchoedClapHit3, $18, nRst, $0C, nRst, dHipHopHitKick, nRst, dHipHopHitKick
	dc.b dHipHopHitKick, dComeOn, dHipHopHitKick, dHipHopHitKick, $0C, dLowerEchoedClapHit3, dEchoedClapHit3, $08
	dc.b dLowerEchoedClapHit3, $04, $0C, $0C, $08, $04, dEchoedClapHit3, $18
	dc.b nRst, $0C, dLowerEchoedClapHit3, dEchoedClapHit3, $08, dLowerEchoedClapHit3, $04, $0C
	dc.b $14, $04, dEchoedClapHit3, $0C, dBassHey, dHipHopHitKick, $0C, dLowerEchoedClapHit3
	dc.b dEchoedClapHit3, $08, dLowerEchoedClapHit3, $04, $0C, $0C, $08, $04
	dc.b dEchoedClapHit3, $18, nRst, $0C, nRst, dHipHopHitKick, nRst, dHipHopHitKick
	dc.b dHipHopHitKick, dComeOn, dHipHopHitKick, nRst, $60, nRst, nRst, $0C
	dc.b dLowerEchoedClapHit3, dEchoedClapHit3, $08, dLowerEchoedClapHit3, $04, $0C, $0C, $08
	dc.b $04, dEchoedClapHit3, $18
	sJump		MinibossS3_Jump9
	; Unused
	dc.b $F2

MinibossS3_Patches:
	; Patch $00
	; $02
	; $02, $00, $00, $01,	$1F, $1F, $1F, $1F
	; $00, $10, $08, $00,	$0E, $00, $00, $08
	; $0F, $FF, $FF, $0F,	$20, $1A, $10, $80
	spAlgorithm	$02
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$02, $00, $00, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0E, $00, $00, $08
	spSustainRt	$00, $08, $10, $00
	spSustainLv	$00, $0F, $0F, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$20, $10, $1A, $00

	; Patch $01
	; $05
	; $00, $00, $00, $00,	$1F, $1F, $1F, $1F
	; $12, $0C, $0C, $0C,	$12, $18, $1F, $1F
	; $1F, $1F, $1F, $1F,	$07, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $00, $00, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$12, $1F, $18, $1F
	spSustainRt	$12, $0C, $0C, $0C
	spSustainLv	$01, $01, $01, $01
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$07, $00, $00, $00

	; Patch $02
	; $15
	; $01, $05, $06, $06,	$9F, $DF, $DF, $DF
	; $0B, $00, $00, $09,	$08, $00, $00, $00
	; $40, $CF, $CF, $CF,	$09, $90, $90, $A0
	spAlgorithm	$05
	spFeedback	$02
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $06, $05, $06
	spRateScale	$02, $03, $03, $03
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$08, $00, $00, $00
	spSustainRt	$0B, $00, $00, $09
	spSustainLv	$04, $0C, $0C, $0C
	spReleaseRt	$00, $0F, $0F, $0F
	spTotalLv	$09, $10, $10, $20

	; Patch $03
	; $1C
	; $01, $01, $01, $01,	$9F, $DF, $9F, $5F
	; $0F, $12, $06, $06,	$00, $07, $0B, $07
	; $FF, $2F, $FF, $FF,	$18, $87, $11, $80
	spAlgorithm	$04
	spFeedback	$03
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $01, $01, $01
	spRateScale	$02, $02, $03, $01
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $0B, $07, $07
	spSustainRt	$0F, $06, $12, $06
	spSustainLv	$0F, $0F, $02, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$18, $11, $07, $00

	; Patch $04
	; $05
	; $00, $00, $00, $00,	$1F, $1F, $1F, $1F
	; $12, $0C, $0C, $0C,	$12, $18, $1F, $1F
	; $1F, $1F, $1F, $1F,	$07, $86, $86, $86
	spAlgorithm	$05
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $00, $00, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$12, $1F, $18, $1F
	spSustainRt	$12, $0C, $0C, $0C
	spSustainLv	$01, $01, $01, $01
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$07, $06, $06, $06

	; Patch $05
	; $3C
	; $00, $00, $F0, $F1,	$1F, $1F, $17, $1F
	; $1F, $1F, $14, $1F,	$09, $11, $3A, $1D
	; $02, $0F, $9F, $7F,	$03, $80, $02, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$00, $0F, $00, $0F
	spMultiple	$00, $00, $00, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $17, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$09, $3A, $11, $1D
	spSustainRt	$1F, $14, $1F, $1F
	spSustainLv	$00, $09, $00, $07
	spReleaseRt	$02, $0F, $0F, $0F
	spTotalLv	$03, $02, $00, $00
