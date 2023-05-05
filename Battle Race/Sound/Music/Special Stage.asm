SpecialStage_Header:
	sHeaderInit	; Z80 offset is $E223
	sHeaderPatch	SpecialStage_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $25
	sHeaderDAC	SpecialStage_DAC
	sHeaderFM	SpecialStage_FM1, $00, $17
	sHeaderFM	SpecialStage_FM2, $00, $0F
	sHeaderFM	SpecialStage_FM3, $00, $17
	sHeaderFM	SpecialStage_FM4, $00, $17
	sHeaderFM	SpecialStage_FM5, $00, $1F
	sHeaderPSG	SpecialStage_PSG1, $0C, $05, $00, VolEnv_0C
	sHeaderPSG	SpecialStage_PSG2, $0C, $05, $00, VolEnv_0C
	sHeaderPSG	SpecialStage_PSG3, $00, $04, $00, VolEnv_02

SpecialStage_FM1:
	sPatFM		$01
	dc.b nE5, $06, nRst, $0C, nE4, $06, nB3, nRst
	dc.b nE4, nRst, nFs4, nRst, nAb4, nRst, nB4, nRst
	dc.b nD5, nRst, nE5, nE5, nRst, nE5, nE5, nRst
	dc.b nE5, nE5, nRst, nD5, nRst, nD5, nD5, $0C
	dc.b nE5, nRst, $60

SpecialStage_Jump8:
	sPatFM		$03
	ssModZ80	$14, $01, $06, $06
	sCall		SpecialStage_Call2
	sCall		SpecialStage_Call3
	sCall		SpecialStage_Call4
	dc.b nE6
	saVolFM		$06
	sPatFM		$04
	dc.b nA6, $66, nA5, $06, nA6, nA5, nA6, $0C
	sCall		SpecialStage_Call5
	dc.b nEb4
	saVolFM		$FA
	sJump		SpecialStage_Jump8
	; Unused
	dc.b $F2

SpecialStage_Call2:
SpecialStage_Loop17:
	dc.b nA5, $0C, nE5, $06, nA5, nRst, nB5, nRst
	dc.b nC6, $02, sHold, nCs6, sHold, nD6, $08, nCs6
	dc.b $06, nB5, nRst, nA5, $0C, nB5, nA5, $0C
	dc.b nE5, $06, nA5, nRst, nB5, nRst, nC6, $02
	dc.b sHold, nCs6, sHold, nD6, $08, nCs6, $06, nB5
	dc.b nRst, nA5, $18
	sLoop		$00, $02, SpecialStage_Loop17
	dc.b nFs5, $12, nAb5, nA5, $0C, nBb5, $03, sHold
	dc.b nB5, $09, nA5, $06, nAb5, nRst, nFs5, $12
	dc.b nE5, $12, nB5, nA5, $24, nE5, $18, nFs5
	dc.b $12, nAb5, nA5, $0C, nAb5, $12, nA5, nB5
	dc.b $0C, nCs6, $18, nB5, nCs6, nE6
	sRet

SpecialStage_Call3:
	dc.b nFs6, $12, nFs6, nE6, $0C, nFs6, $12, nFs6
	dc.b nE6, $06, nFs6, nA6, $12, nAb6, nE6, $0C
	dc.b nCs6, $24, nD6, $06, nE6, nFs6, $12, nFs6
	dc.b nE6, $0C, nFs6, $12, nFs6, nE6, $06, nFs6
	dc.b nA6, $12, nAb6, nCs7, $3C, nFs6, $12, nFs6
	dc.b nE6, $0C, nFs6, $12, nFs6, nE6, $06, nFs6
	dc.b nA6, $12, nAb6, nE6, $0C, nCs6, $24, nD6
	dc.b $06, nE6, nFs6, $12, nFs6, nE6, $0C, nFs6
	dc.b $12, nFs6, nE6, $06, nFs6, nA6, $12, nAb6
	dc.b nCs7, $24, nAb6, $18, nFs6, $24, $06, nAb6
	dc.b nA6, $12, nAb6, nE6, $0C, nA6, $60
	sRet

SpecialStage_Call4:
	dc.b nFs6, $24, $06, $06, $12, nE6, nD6, $0C
	dc.b nE6, $60, nD6, $24, $06, $06, $12, nCs6
	dc.b nB5, $0C, nCs6, $48, nB5, $18, nA5, $24
	dc.b $06, $06, $12, nB5, nCs6, $0C
SpecialStage_Loop18:
	dc.b nA5, $30, $12, nB5, nCs6, $0C
	sLoop		$00, $02, SpecialStage_Loop18
	dc.b nCs6, $18, nB5, nCs6
	sRet

SpecialStage_Call5:
	dc.b nG6, $06, nE6, nD6, $0C, nD6, $02, nE6
	dc.b $04, nD6, $0C, nE6, nD6, nD5, $06, nB4
	dc.b nA4, nG4, nE4, nD4, nE4, nG4, nE4, nG4
	dc.b nA4, nB4, nA4, nB4, nD5, nD5, $03, nE5
	dc.b $09, nD5, $0C, nB4, $06, nA4, nB4, nD5
	dc.b nE5, nD5, nE5, nFs5, nG5, nA5, nB5, nCs6
	dc.b nD6, nCs6, nB5, nG6, nFs6, nE6, nFs6, nE6
	dc.b nD6, nFs6, nE6, nD6, nCs6, $04, nD6, nCs6
	dc.b nB5, $06, nA5, nFs5, nE5, nD5, nCs5, $04
	dc.b nD5, $06, nCs5, $08, nB4, $06, nA4, nG4
	dc.b $0C, nA4, $06, nG4, $0C, nFs4, nE4, nFs4
	dc.b $06, nD4, nE4, nFs4, nG4, nA4, nB4, nG4
	dc.b nA4, nCs5, nD5, nE5, nFs5, nG5, nFs5, nG5
	dc.b $03, nA5, $09, nG5, $06, nE5, $0C, nD5
	dc.b $06, nRst, nE5, nRst, nD5, nA4, nG4, sHold
	dc.b $0C, nFs4, $03, nF4, nE4
	sRet

SpecialStage_FM2:
	sPatFM		$00
	dc.b nRst, $12, nA2, $06, nE2, nRst, nA2, nRst
	dc.b nB2, nRst, nCs3, nRst, nE2, nRst, nFs2, nRst
	dc.b nA2, nA2, nE3, nA3, nA3, nRst, nA3, nA3
	dc.b nRst, nG3, nRst, nG3, nG2, nD3, nG3, $0C
	dc.b nRst, $60

SpecialStage_Loop27:
SpecialStage_Jump7:
	dc.b nA2, $12, nE3, nA2, $0C, nG2, $12, nD3
	dc.b nG2, $0C
	sLoop		$00, $04, SpecialStage_Loop27

SpecialStage_Loop28:
	dc.b nFs2, $12, nCs3, nFs2, $0C, nB2, $12, nFs2
	dc.b nB2, $0C, nE2, $12, nB2, nE2, $0C, nA2
	dc.b $12, nE3, nA2, $0C
	sLoop		$00, $02, SpecialStage_Loop28

SpecialStage_Loop29:
	dc.b nD2, $12, nA2, nD3, $0C, nD2, $12, nA2
	dc.b nD2, $0C, nA2, $12, nA2, $06, nRst, $0C
	dc.b nE2, nA2, $18, nE2
	sLoop		$00, $04, SpecialStage_Loop29
	dc.b nD2, $12, nA2, nD2, $0C, nE2, $12, nAb2
	dc.b nB2, $0C, nA2, $06, nA2, nE3, nA3, nA3
	dc.b nRst, nA3, nA3, nRst, nG3, nRst, nG3, nG2
	dc.b nD3, nG3, $0C

SpecialStage_Loop30:
	dc.b nD2, $12, nA2, $06, nRst, $0C, nD3, $3C
	dc.b nA2, $12, nA2, $06, nRst, $0C, nA2, $3C
	sLoop		$00, $02, SpecialStage_Loop30
	dc.b nFs2, $12, nA2, $06, nRst, $0C, nCs3, $3C
	dc.b nF2, $12, nA2, $06, nRst, $0C, nCs3, $3C
	dc.b nE2, $12, nA2, $06, nRst, $0C, nCs3, $3C
	dc.b nA2, $18, nAb2, nFs2, nE2

SpecialStage_Loop31:
	dc.b nA2, $12, nE3, nA2, $0C, nG2, $12, nD3
	dc.b nG2, $0C
	sLoop		$00, $07, SpecialStage_Loop31
	dc.b nA2, $12, nE3, nA2, $0C, nG2, $06, $0C
	dc.b nG3, $12, nA3, $0C
	sJump		SpecialStage_Jump7
	; Unused
	dc.b $F2

SpecialStage_FM3:
	sPatFM		$01
	sPan		spRight, $00
	dc.b nA4, $06, nRst, $0C, nA3, $06, nE3, nRst
	dc.b nA3, nRst, nB3, nRst, nCs4, nRst, nE4, nRst
	dc.b nG4, nRst, nA4, nA4, nRst, nA4, nA4, nRst
	dc.b nA4, nA4, nRst, nG4, nRst, nG4, nG4, $0C
	dc.b nA4, nRst, $60

SpecialStage_Jump6:
	sPatFM		$02

SpecialStage_Loop23:
	dc.b nCs4, $0C, nA3, $06, nE3, nRst, nA3, nRst
	dc.b nB3, $0C, nG3, $06, nG3, nG3, $0C, nD3
	dc.b $06, nB3, nB3
	sLoop		$00, $04, SpecialStage_Loop23

SpecialStage_Loop24:
	dc.b nA3, $0C, nFs3, $06, nA3, nRst, nFs3, nRst
	dc.b nB3, $0C, nD3, $06, nD3, nFs3, $0C, nD3
	dc.b $06, nFs3, nB3, nE3, $0C, nB2, $06, nB2
	dc.b nRst, nE3, nRst, nA3, $0C, nE3, $06, nE3
	dc.b nA3, $0C, nA2, $06, nE3, nCs3
	sLoop		$00, $02, SpecialStage_Loop24

SpecialStage_Loop25:
	dc.b nA3, $12, $06, nRst, $18
	sLoop		$00, $02, SpecialStage_Loop25
	dc.b nCs4, $12, $06, nRst, $0C, nA3, $3C
	sLoop		$01, $04, SpecialStage_Loop25
	dc.b nA3, $30, nB3, $12, nB3, nB3, $0C
	sPatFM		$01
	dc.b nA4, $06, nA4, nRst, nA4, nA4, nRst, nA4
	dc.b nA4, nRst, nG4, nRst, nG4, nG4, $0C, nA4
	sPatFM		$02
	dc.b nA3, $60, nA3, nA3, nA3, nFs3, nF3, nE3
	dc.b nA3, $18, nAb3, nFs3, nE3

SpecialStage_Loop26:
	dc.b nCs4, $0C, nA3, $06, nE3, nRst, nA3, nRst
	dc.b nB3, $0C, nG3, $06, nG3, nG3, $0C, nD3
	dc.b $06, nB3, nB3
	sLoop		$00, $07, SpecialStage_Loop26
	sPatFM		$01
	saVolFM		$08
	dc.b nE4, $12
	saVolFM		$FC
	dc.b nA4
	saVolFM		$FC
	dc.b nA4
	saVolFM		$FB
	dc.b nG4, $0C, $12, nA4, $0C
	saVolFM		$05
	sJump		SpecialStage_Jump6
	; Unused
	dc.b $F2

SpecialStage_FM4:
	sPatFM		$01
	sPan		spLeft, $00
	dc.b nA5, $06, nRst, $0C, nA4, $06, nE4, nRst
	dc.b nA4, nRst, nB4, nRst, nCs5, nRst, nE5, nRst
	dc.b nG5, nRst, nA5, nA5, nRst, nA5, nA5, nRst
	dc.b nA5, nA5, nRst, nG5, nRst, nG5, nG5, $0C
	dc.b nA5, nRst, $60

SpecialStage_Jump5:
	sPatFM		$02

SpecialStage_Loop19:
	dc.b nE4, $0C, nA4, $06, nCs4, nRst, nE4, nRst
	dc.b nD4, $12, nB3, $06, nD4, $0C, nG3, $06
	dc.b nG4, nD4
	sLoop		$00, $04, SpecialStage_Loop19

SpecialStage_Loop20:
	dc.b nCs4, $0C, nFs4, $06, nCs4, nRst, nCs4, nRst
	dc.b nD4, $0C, nFs3, $06, nB3, nD4, $0C, nFs3
	dc.b $06, nB3, nD4, nB3, $0C, nE3, $06, nAb3
	dc.b nRst, nB3, nRst, nCs4, $0C, nA3, $06, nB3
	dc.b nCs4, $0C, nE3, $06, nA3, nCs4
	sLoop		$00, $02, SpecialStage_Loop20

SpecialStage_Loop21:
	dc.b nFs4, $12, nFs4, $06, nRst, $18
	sLoop		$00, $02, SpecialStage_Loop21
	dc.b nA4, $12, nA4, $06, nRst, $0C, nE4, $3C
	sLoop		$01, $04, SpecialStage_Loop21
	dc.b nFs4, $30, nAb4, $12, nAb4, nAb4, $0C
	sPatFM		$01
	dc.b nA5, $06, nA5, nRst, nA5, nA5, nRst, nA5
	dc.b nA5, nRst, nG5, nRst, nG5, nG5, $0C, nA5
	sPatFM		$02
	dc.b nFs4, $60, nE4, nD4, nCs4, nCs4, nCs4, nCs4
	dc.b nCs4, $18, nB3, nA3, nAb3

SpecialStage_Loop22:
	dc.b nE4, $0C, nA4, $06, nCs4, nRst, nE4, nRst
	dc.b nD4, $12, nB3, $06, nD4, $0C, nG3, $06
	dc.b nG4, nD4
	sLoop		$00, $07, SpecialStage_Loop22
	sPatFM		$01
	saVolFM		$08
	dc.b nA4, $12
	saVolFM		$FC
	dc.b nCs5
	saVolFM		$FC
	dc.b nE5
	saVolFM		$FB
	dc.b nG5, $0C, $12, nA5, $0C
	saVolFM		$05
	sJump		SpecialStage_Jump5
	; Unused
	dc.b $F2

SpecialStage_FM5:
	sPatFM		$02
	dc.b nA5, $06, nRst, $0C, nA4, $06, nE4, nRst
	dc.b nA4, nRst, nB4, nRst, nCs5, nRst, nE5, nRst
	dc.b nG5, nRst, nA5, nA5, nRst, nA5, nA5, nRst
	dc.b nA5, nA5, nRst, nG5, nRst, nG5, nG5, $0C
	dc.b nA5, nRst, $60
	saDetune	$F8

SpecialStage_Jump4:
	sPatFM		$03
	ssModZ80	$14, $01, $06, $06
	dc.b nRst, $12
	sCall		SpecialStage_Call2
	sCall		SpecialStage_Call3
	sCall		SpecialStage_Call4
	dc.b nE6, $06
	sPatFM		$04
	saVolFM		$FB
	dc.b nE6, $66, nRst, $06, nE6, nRst, nE6, $0C
	saVolFM		$0A
	dc.b nRst, $03
	sCall		SpecialStage_Call5
	saVolFM		$FB
	sJump		SpecialStage_Jump4
	; Unused
	dc.b $F2

SpecialStage_PSG1:
	dc.b nRst, $12, nA2, $06, nE2, nRst, nA2, nRst
	dc.b nB2, nRst, nCs3, nRst, nE3, nRst, nG3, nRst
	dc.b nA3, nA3, nRst, nA3, nA3, nRst, nA3, nA3
	dc.b nRst, nG3, nRst, nG3, nG3, $0C, nA3, nRst
	dc.b $60
SpecialStage_Loop13:
SpecialStage_Jump3:
	dc.b nE2, $0C, nA2, $06, nCs2, nRst, nE2, nRst
	dc.b nD2, $12, nB1, $06, nD2, $0C, nG1, $06
	dc.b nG2, nD2
	sLoop		$00, $04, SpecialStage_Loop13

SpecialStage_Loop14:
	dc.b nCs2, $0C, nFs2, $06, nCs2, nRst, nCs2, nRst
	dc.b nD2, $0C, nFs1, $06, nB1, nD2, $0C, nFs1
	dc.b $06, nB1, nD2, nB1, $0C, nE1, $06, nAb1
	dc.b nRst, nB1, nRst, nCs2, $0C, nA1, $06, nB1
	dc.b nCs2, $0C, nE1, $06, nA1, nCs2
	sLoop		$00, $02, SpecialStage_Loop14
	sVolEnvPSG	VolEnv_09

SpecialStage_Loop15:
	dc.b nFs2, $60, nE2, nFs2, nA2
	sLoop		$00, $02, SpecialStage_Loop15
	dc.b nFs2, $30, nAb2, $12, nAb2, nAb2, $0C
	sVolEnvPSG	VolEnv_0C
	dc.b nA3, $06, nA3, nRst, nA3, nA3, nRst, nA3
	dc.b nA3, nRst, nG3, nRst, nG3, nG3, $0C, nA3
	sVolEnvPSG	VolEnv_09
	sCall		SpecialStage_Call1
	dc.b nG1, nAb1, nA1, nBb1, nB1, nC2
	saVolPSG	$02
	sVolEnvPSG	VolEnv_0C

SpecialStage_Loop16:
	dc.b nE2, $0C, nA2, $06, nCs2, nRst, nE2, nRst
	dc.b nD2, $12, nB1, $06, nD2, $0C, nG1, $06
	dc.b nG2, nD2
	sLoop		$00, $07, SpecialStage_Loop16
	dc.b nE2, $0C, nA2, $06, nCs2, nRst, nE2, nRst
	dc.b nD2, $0C, nG2, $0C, $12, nA2, $0C
	sJump		SpecialStage_Jump3
	; Unused
	dc.b $F2

SpecialStage_PSG2:
	dc.b nRst, $12, nA1, $06, nE1, nRst, nA1, nRst
	dc.b nB1, nRst, nCs2, nRst, nE2, nRst, nG2, nRst
	dc.b nE2, nE2, nRst, nE2, nE2, nRst, nE2, nE2
	dc.b nRst, nD2, nRst, nD2, nD2, $0C, nE2, nRst
	dc.b $60
SpecialStage_Loop9:
SpecialStage_Jump2:
	dc.b nCs2, $0C, nA1, $06, nE1, nRst, nA1, nRst
	dc.b nB1, $0C, nG1, $06, nG1, nG1, $0C, nD1
	dc.b $06, nB1, nB1
	sLoop		$00, $04, SpecialStage_Loop9

SpecialStage_Loop10:
	dc.b nA1, $0C, nFs1, $06, nA1, nRst, nFs1, nRst
	dc.b nB1, $0C, nD1, $06, nD1, nFs1, $0C, nD1
	dc.b $06, nFs1, nB1, nE1, $0C, nB0, $06, nB0
	dc.b nRst, nE1, nRst, nA1, $0C, nE1, $06, nE1
	dc.b nA1, $0C, nA0, $06, nE1, nCs1
	sLoop		$00, $02, SpecialStage_Loop10
	sVolEnvPSG	VolEnv_09

SpecialStage_Loop11:
	dc.b nD2, $60, nCs2, nD2, nE2
	sLoop		$00, $02, SpecialStage_Loop11
	dc.b nD2, $30, nE2, $12, nE2, nE2, $0C
	sVolEnvPSG	VolEnv_0C
	dc.b nE2, $06, nE2, nRst, nE2, nE2, nRst, nE2
	dc.b nE2, nRst, nD2, nRst, nD2, nD2, $0C, nE2
	sVolEnvPSG	VolEnv_09
	saDetune	$FE
	saVolPSG	$02
	dc.b nRst, $12
	sCall		SpecialStage_Call1
	sVolEnvPSG	VolEnv_0C

SpecialStage_Loop12:
	dc.b nCs2, $0C, nA1, $06, nE1, nRst, nA1, nRst
	dc.b nB1, $0C, nG1, $06, nG1, nG1, $0C, nD1
	dc.b $06, nB1, nB1
	sLoop		$00, $07, SpecialStage_Loop12
	dc.b nCs2, $0C, nA1, $06, nE1, nRst, nA1, nRst
	dc.b nB1, $0C, nD2, $0C, $12, nCs2, $0C
	sJump		SpecialStage_Jump2
	; Unused
	dc.b $F2

SpecialStage_Call1:
	dc.b nD2, $24, $06, $06, $12, nCs2, nB1, $0C
	dc.b nCs2, $60, nA1, $24, $06, $06, $12, $12
	dc.b nE1, $0C, nA1, $48, nAb1, $18, nFs1, $24
	dc.b $06, $06, $12, nAb1, nA1, $0C, nF1, $30
	dc.b $12, nAb1, nA1, $0C, nE1, $30, $12, nAb1
	dc.b nA1, $0C, nA1, $18, nAb1
	saVolPSG	$FE
	dc.b nA0, $03, nBb0, nB0, nC1, nCs1, nD1, nEb1
	dc.b nE1, nF1, nFs1
	sRet

SpecialStage_PSG3:
	sNoisePSG	$E7
	sVolEnvPSG	VolEnv_02
	dc.b nB6, $06, nB6
	sVolEnvPSG	VolEnv_01
	dc.b nB6, $0C

SpecialStage_Loop1:
	sVolEnvPSG	VolEnv_02
	dc.b nB6, $06
	sVolEnvPSG	VolEnv_01
	dc.b nB6
	sVolEnvPSG	VolEnv_02
	dc.b nB6
	sVolEnvPSG	VolEnv_01
	dc.b nB6
	sLoop		$00, $03, SpecialStage_Loop1

SpecialStage_Loop2:
	sVolEnvPSG	VolEnv_02
	dc.b nB6, nB6
	saVolPSG	$FC
	dc.b nB6
	saVolPSG	$04
	dc.b nB6
	sLoop		$00, $07, SpecialStage_Loop2
	dc.b nB6, nB6, nB6
	sVolEnvPSG	VolEnv_01
	dc.b nB6

SpecialStage_Loop3:
SpecialStage_Jump1:
	sVolEnvPSG	VolEnv_02
	dc.b nB6, nB6
	saVolPSG	$FC
	dc.b nB6
	saVolPSG	$04
	dc.b nB6
	sLoop		$00, $03, SpecialStage_Loop3
	dc.b nB6, nB6, nB6
	sVolEnvPSG	VolEnv_01
	dc.b nB6
	sLoop		$01, $04, SpecialStage_Loop3

SpecialStage_Loop4:
	sVolEnvPSG	VolEnv_02
	dc.b nB6, nB6
	saVolPSG	$FC
	dc.b nB6
	saVolPSG	$04
	dc.b nB6
	sLoop		$00, $0F, SpecialStage_Loop4
	dc.b nB6, nB6, nB6
	sVolEnvPSG	VolEnv_01
	dc.b nB6

SpecialStage_Loop5:
	sVolEnvPSG	VolEnv_02
	dc.b nB6, $06, nB6
	sVolEnvPSG	VolEnv_01
	dc.b nB6, $0C
	sVolEnvPSG	VolEnv_02
	dc.b nB6, $06, nB6
	saVolPSG	$FC
	dc.b nB6
	saVolPSG	$04
	dc.b nB6
	sLoop		$00, $10, SpecialStage_Loop5

SpecialStage_Loop6:
	dc.b nB6, $06, nB6
	saVolPSG	$FC
	dc.b nB6
	saVolPSG	$04
	dc.b nB6
	sLoop		$00, $03, SpecialStage_Loop6
	dc.b nB6, $06, nB6, nB6
	sVolEnvPSG	VolEnv_01
	dc.b nB6
	sVolEnvPSG	VolEnv_02
	sLoop		$01, $02, SpecialStage_Loop6

SpecialStage_Loop7:
	dc.b nB6, $06, nB6
	saVolPSG	$FC
	dc.b nB6
	saVolPSG	$04
	dc.b nB6
	sLoop		$00, $20, SpecialStage_Loop7

SpecialStage_Loop8:
	sVolEnvPSG	VolEnv_02
	dc.b nB6, nB6
	saVolPSG	$FC
	dc.b nB6
	saVolPSG	$04
	dc.b nB6
	sLoop		$00, $03, SpecialStage_Loop8
	dc.b nB6, nB6, nB6
	sVolEnvPSG	VolEnv_01
	dc.b nB6
	sLoop		$01, $08, SpecialStage_Loop8
	sJump		SpecialStage_Jump1
	; Unused
	dc.b $F2

SpecialStage_DAC:
	dc.b dQuickLooseSnare, $06, dKick, $0C, dQuickLooseSnare, $06, dKick, $0C
	dc.b dKick, dKick, dKick, dQuickLooseSnare, dKick, dQuickLooseSnare, $06, dQuickLooseSnare
	dc.b $0C, dQuickLooseSnare, $06, dKick, $0C, dQuickLooseSnare, $06, dQuickLooseSnare
	dc.b $0C, dKick, dKick, $06, dQuickLooseSnare, $0C, dQuickLooseSnare, $06
	dc.b dQuickLooseSnare, dKick, $06, dElectricHighTom, $03, dElectricHighTom, dElectricHighTom, $06
	dc.b dElectricHighTom, dElectricMidTom, dElectricMidTom, dElectricMidTom, dElectricLowTom, dElectricLowTom, dElectricLowTom, dKick
	dc.b dKick, dQuickLooseSnare, dKick, $12
SpecialStage_Loop32:
SpecialStage_Jump9:
	dc.b dKick, $12, dKick, $06, dQuickLooseSnare, dKick, $0C, dKick
	dc.b dKick, $12, dQuickLooseSnare, $06, dKick, $12
	sLoop		$00, $03, SpecialStage_Loop32
	dc.b dKick, $12, dKick, $06, dQuickLooseSnare, dKick, $0C, dKick
	dc.b dKick, $12, dQuickLooseSnare, $0C, dQuickLooseSnare, $06, dQuickLooseSnare

SpecialStage_Loop33:
	dc.b dKick, $12, dKick, $06, dQuickLooseSnare, $0C, dKick, $06
	dc.b dQuickLooseSnare, $12, dKick, $0C, dQuickLooseSnare, dKick, $06, dKick
	sLoop		$00, $03, SpecialStage_Loop33
	dc.b dKick, $12, dKick, $06, dQuickLooseSnare, $0C, dKick, dQuickLooseSnare
	dc.b dKick, dQuickLooseSnare, dKick

SpecialStage_Loop34:
	dc.b dKick, $12, dKick, $06, dQuickLooseSnare, $0C, dKick
	sLoop		$00, $10, SpecialStage_Loop34
	dc.b dKick, $12, dKick, $06, dQuickLooseSnare, $0C, dKick, $12
	dc.b dKick, dQuickLooseSnare, $06, dKick, $12, dQuickLooseSnare, $06, dQuickLooseSnare
	dc.b $0C, dQuickLooseSnare, $06, dKick, $0C, dQuickLooseSnare, $06, dQuickLooseSnare
	dc.b $0C, dKick, dKick, $06, dQuickLooseSnare, $0C, dQuickLooseSnare, $06
	dc.b dQuickLooseSnare, $06

SpecialStage_Loop35:
	dc.b dKick, $12, dKick, dKick, $24, dQuickLooseSnare, $18
	sLoop		$00, $07, SpecialStage_Loop35
	dc.b dKick, $12, dKick, $06, dQuickLooseSnare, $0C, dKick, $1E
	dc.b dKick, $06, dQuickLooseSnare, dQuickLooseSnare, dQuickLooseSnare, dQuickLooseSnare

SpecialStage_Loop36:
	dc.b dKick, $12, dKick, $06, dQuickLooseSnare, dKick, $0C, dKick
	dc.b dKick, $12, dQuickLooseSnare, $06, dKick, $12
	sLoop		$00, $07, SpecialStage_Loop36
	dc.b dKick, $06, dKick, dQuickLooseSnare, dKick, dKick, dQuickLooseSnare, $0C
	dc.b dQuickLooseSnare, $06, dKick, dElectricHighTom, $03, dElectricHighTom, dElectricHighTom, $06
	dc.b dElectricHighTom, dElectricMidTom, dElectricMidTom, dElectricLowTom, dElectricLowTom
	sJump		SpecialStage_Jump9
	; Unused
	dc.b $F2

SpecialStage_Patches:
	; Patch $00
	; $3C
	; $01, $00, $00, $00,	$1F, $1F, $15, $1F
	; $11, $0D, $12, $05,	$07, $04, $09, $02
	; $55, $3A, $25, $1A,	$1A, $80, $07, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $00, $00, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $15, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$07, $09, $04, $02
	spSustainRt	$11, $12, $0D, $05
	spSustainLv	$05, $02, $03, $01
	spReleaseRt	$05, $05, $0A, $0A
	spTotalLv	$1A, $07, $00, $00

	; Patch $01
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

	; Patch $02
	; $03
	; $00, $D7, $33, $02,	$5F, $9F, $5F, $1F
	; $13, $0F, $0A, $0A,	$10, $0F, $02, $09
	; $35, $15, $25, $1A,	$13, $16, $15, $80
	spAlgorithm	$03
	spFeedback	$00
	spDetune	$00, $03, $0D, $00
	spMultiple	$00, $03, $07, $02
	spRateScale	$01, $01, $02, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$10, $02, $0F, $09
	spSustainRt	$13, $0A, $0F, $0A
	spSustainLv	$03, $02, $01, $01
	spReleaseRt	$05, $05, $05, $0A
	spTotalLv	$13, $15, $16, $00

	; Patch $03
	; $34
	; $00, $02, $01, $01,	$1F, $1F, $1F, $1F
	; $10, $06, $06, $06,	$01, $06, $06, $06
	; $35, $1A, $15, $1A,	$10, $80, $18, $80
	spAlgorithm	$04
	spFeedback	$06
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $01, $02, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$01, $06, $06, $06
	spSustainRt	$10, $06, $06, $06
	spSustainLv	$03, $01, $01, $01
	spReleaseRt	$05, $05, $0A, $0A
	spTotalLv	$10, $18, $00, $00

	; Patch $04
	; $3E
	; $07, $01, $02, $01,	$1F, $1F, $1F, $1F
	; $0D, $06, $00, $00,	$08, $06, $00, $00
	; $15, $0A, $0A, $0A,	$1B, $80, $80, $80
	spAlgorithm	$06
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$07, $02, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$08, $00, $06, $00
	spSustainRt	$0D, $00, $06, $00
	spSustainLv	$01, $00, $00, $00
	spReleaseRt	$05, $0A, $0A, $0A
	spTotalLv	$1B, $00, $00, $00
