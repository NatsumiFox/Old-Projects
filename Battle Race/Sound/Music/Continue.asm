Continue_Header:
	sHeaderInit	; Z80 offset is $DFA6
	sHeaderPatchUniv
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $58
	sHeaderDAC	Continue_DAC
	sHeaderFM	Continue_FM1, $18, $12
	sHeaderFM	Continue_FM2, $18, $10
	sHeaderFM	Continue_FM3, $0C, $14
	sHeaderFM	Continue_FM4, $0C, $0E
	sHeaderFM	Continue_FM5, $0C, $0E
	sHeaderPSG	Continue_PSG1, $F4, $04, $00, VolEnv_0C
	sHeaderPSG	Continue_PSG2, $F4, $04, $00, VolEnv_0C
	sHeaderPSG	Continue_PSG3, $00, $03, $00, VolEnv_0C

Continue_DAC:
	dc.b dKick, $04, nRst, dKick, dSnare, nRst, dSnare, nRst
	dc.b $08, dSnare, $02, dSnare, dSnare, $04, dSnare, dSnare
Continue_Jump8:
	dc.b dKick, nRst, dKick, dSnare, nRst, $08, dKick, $04
	dc.b nRst, dKick, dSnare, nRst, dKick, nRst, $08, dKick
	dc.b $04, dSnare, nRst, $08, dKick, $04, nRst, dKick
	dc.b dSnare, nRst, $08, dKick, $04, nRst, dKick, dSnare
	dc.b nRst, $08, dKick, $04, nRst, dKick, dSnare, nRst
	dc.b dKick, nRst, $08, dKick, $04, dSnare, nRst, $08
	dc.b dKick, $04, nRst, dKick, dSnare, nRst, $08, dKick
	dc.b $04, nRst, dKick, dSnare, nRst, $08, dKick, $04
	dc.b nRst, dKick, dSnare, nRst, dKick, nRst, $08, dKick
	dc.b $04, dSnare, nRst, $08, dKick, $04, nRst, dKick
	dc.b dSnare, nRst, $08, dKick, $04, nRst, dKick, dSnare
	dc.b nRst, $08, dKick, $04, nRst, dKick, dSnare, nRst
	dc.b $08, dKick, $04, nRst, dKick, dSnare, nRst, dSnare
	dc.b nRst, $08, dSnare, $02, dSnare, dSnare, $04, dSnare
	dc.b dSnare
	sJump		Continue_Jump8

Continue_FM1:
	sPatFM		$03
	saDetune	$FE
	ssModZ80	$0F, $01, $06, $06
	saDetune	$01
	sPan		spRight, $00
	sCall		Continue_Call1

Continue_Call1:
	dc.b nRst, $08, nEb4, $04, nE4, $08, nC4, $04
	dc.b nD4, $08, nC4, $04, nA3, $08, nC4, $04
Continue_Jump6:
	dc.b nRst, $14, nBb3, $02, nC4, $0E, nA3, $04
	dc.b nRst, $08, nG3, $0C, nA3, $08, nEb3, $02
	dc.b nE3, nG3, $08, nA3, $04, nRst, $20, nBb3
	dc.b $02, nC4, $0E, nA3, $04, nRst, $08, nEb3
	dc.b $0C, nD3, $08, nC3, $04, nRst, $24, nA2
	dc.b $0C, nC3, nD3, $08, nEb3, $0C, nD3, $04
	dc.b nEb3, $08, nD3, $04, nEb3, $08, nD3, $04
	dc.b nC3, $08, nRst, $0C, nEb4, $04, nE4, $08
	dc.b nC4, $04, nD4, $08, nC4, $04, nRst, $08
	dc.b nEb4, $04, nRst, $08, nEb4, $04, nE4, $08
	dc.b nC4, $04, nD4, $08, nC4, $04, nA3, $08
	dc.b nC4, $04
	sJump		Continue_Jump6

Continue_FM2:
	sPatFM		$14
	saDetune	$00
	ssModZ80	$02, $01, $01, $02
	dc.b nF1, $0B, nRst, $01, nFs1, $07, nRst, $01
	dc.b nG1, $03, nRst, $09, nG0, $03, nRst, $01
	dc.b nG0, $0B, nRst, $01

Continue_Jump7:
	dc.b nC1, $0B, nRst, $01, nE1, $0B, nRst, $01
	dc.b nF1, $0B, nRst, $01, nFs1, $07, nRst, $01
	dc.b nG1, $03, nRst, $09, nG1, $03, nRst, $01
	dc.b nC1, $0B, nRst, $01, nE1, $0B, nRst, $01
	dc.b nC1, $0B, nRst, $01, nA0, $0B, nRst, $01
	dc.b nC1, $0B, nRst, $01, nD1, $0B, nRst, $01
	dc.b nEb1, $07, nRst, $01, nE1, $03, nRst, $09
	dc.b nE1, $03, nRst, $01, nA0, $0B, nRst, $01
	dc.b nC1, $0B, nRst, $01, nA0, $0B, nRst, $01
	dc.b nF0, $0B, nRst, $01, nA0, $0B, nRst, $01
	dc.b nC1, $0B, nRst, $01, nD1, $07, nRst, $01
	dc.b nEb1, $03, nRst, $09, nEb1, $03, nRst, $01
	dc.b nC1, $0B, nRst, $01, nA0, $0B, nRst, $01
	dc.b nF0, $0B, nRst, $01, nD1, $07, nRst, $01
	dc.b nD1, $03, nRst, $01, nD1, $0B, nRst, $01
	dc.b nE1, $07, nRst, $01, nE1, $03, nRst, $01
	dc.b nE1, $0B, nRst, $01, nF1, $0B, nRst, $01
	dc.b nFs1, $07, nRst, $01, nG1, $03, nRst, $09
	dc.b nG0, $03, nRst, $01, nG0, $0B, nRst, $01
	sJump		Continue_Jump7

Continue_FM3:
	sPatFM		$08
	saDetune	$01
	ssModZ80	$0F, $01, $06, $06
	saDetune	$FF
	sPan		spLeft, $00
	dc.b nRst, $01
	sCall		Continue_Call1
	sStop

Continue_FM4:
	sPatFM		$06
	saDetune	$01
	ssModZ80	$0A, $01, $03, $06
	dc.b nRst, $2C, nG3, $03, nRst, $01

Continue_Jump5:
	dc.b nRst, $08, nG3, $0A, nF3, $01, nE3, nD3
	dc.b nC3, nBb2, nA2, nG2, nF2, nE2, nD2, nRst
	dc.b $38, nG3, $08, nE3, $03, nRst, $09, nE3
	dc.b $0A, nD3, $01, nC3, nBb2, nA2, nG2, nF2
	dc.b nE2, nD2, nC2, nBb1, nRst, $38, nE3, $08
	dc.b nC3, $03, nRst, $09, nC3, $0A, nBb2, $01
	dc.b nA2, nG2, nF2, nE2, nD2, nC2, nBb1, nA1
	dc.b nG1, nRst, $38, nA3, $0C, nF3, $18, nG3
	dc.b nA3, $0C, nA3, $08, nB3, $04, nRst, $14
	dc.b nG3, $04
	sJump		Continue_Jump5

Continue_FM5:
	sPatFM		$06
	saDetune	$FF
	ssModZ80	$0A, $01, $03, $06
	dc.b nRst, $2C, nC4, $03, nRst, $01

Continue_Jump4:
	dc.b nRst, $08, nC4, $0A, nBb3, $01, nA3, nG3
	dc.b nF3, nE3, nD3, nC3, nBb2, nA2, nG2, nRst
	dc.b $38, nC4, $08, nA3, $03, nRst, $09, nA3
	dc.b $0A, nG3, $01, nF3, nE3, nD3, nC3, nBb2
	dc.b nA2, nG2, nF2, nE2, nRst, $38, nA3, $08
	dc.b nF3, $03, nRst, $09, nF3, $0A, nEb3, $01
	dc.b nD3, nC3, nBb2, nA2, nG2, nF2, nEb2, nD2
	dc.b nC2, nRst, $38, nC4, $0C, nA3, $18, nB3
	dc.b nC4, $0C, nC4, $08, nD4, $04, nRst, $14
	dc.b nC4, $04
	sJump		Continue_Jump4

Continue_PSG1:
	sVolEnvPSG	VolEnv_04
	dc.b nRst, $30

Continue_Jump3:
	dc.b nRst, $08, nC4, $02, nRst, nC5, nRst, $06
	dc.b nC4, $02, nRst, nC5, nRst, $0A, nC4, $02
	dc.b nRst, $06, nC5, $02, nRst, $16, nC4, $02
	dc.b nRst, nC5, nRst, $12, nC5, $02, nRst, $0A
	dc.b nA3, $02, nRst, nA4, nRst, $06, nA3, $02
	dc.b nRst, nA4, nRst, $0A, nA3, $02, nRst, $06
	dc.b nA4, $02, nRst, $0A, nEb4, $02, nRst, nE4
	dc.b nRst, $06, nG4, $02, nRst, nA4, nRst, $06
	dc.b nE4, $02, nRst, $0A, nE4, $02, nRst, $0A
	dc.b nF3, $02, nRst, nF4, nRst, $06, nF3, $02
	dc.b nRst, nF4, nRst, $0A, nF3, $02, nRst, $06
	dc.b nF4, $02, nRst, $16, nF3, $02, nRst, nF4
	dc.b nRst, $12, nF4, $02, nRst, $0E, nF4, $02
	dc.b nRst, $06, nE4, $02, nRst, $1A, nF4, $02
	dc.b nRst, $0A, nFs4, $02, nRst, $06, nG4, $02
	dc.b nRst, $1A
	sJump		Continue_Jump3

Continue_PSG2:
	sVolEnvPSG	VolEnv_04
	dc.b nRst, $30

Continue_Jump2:
	dc.b nRst, $08, nE3, $02, nRst, nE4, nRst, $06
	dc.b nE3, $02, nRst, nE4, nRst, $0A, nE3, $02
	dc.b nRst, $06, nE4, $02, nRst, $16, nE3, $02
	dc.b nRst, nE4, nRst, $12, nE4, $02, nRst, $0A
	dc.b nC3, $02, nRst, nC4, nRst, $06, nC3, $02
	dc.b nRst, nC4, nRst, $0A, nC3, $02, nRst, $06
	dc.b nC4, $02, nRst, $0A, nC3, $02, nRst, nC4
	dc.b nRst, $06, nC3, $02, nRst, nC4, nRst, $0A
	dc.b nC3, $02, nRst, $06, nC4, $02, nRst, $0A
	dc.b nA2, $02, nRst, nA3, nRst, $06, nA2, $02
	dc.b nRst, nA3, nRst, $0A, nA2, $02, nRst, $06
	dc.b nA3, $02, nRst, $16, nA2, $02, nRst, nA3
	dc.b nRst, $12, nA3, $02, nRst, $0E, nA3, $02
	dc.b nRst, $06, nG3, $02, nRst, $1A, nA3, $02
	dc.b nRst, $0A, nBb3, $02, nRst, $06, nB3, $02
	dc.b nRst, $1A
	sJump		Continue_Jump2

Continue_PSG3:
	sNoisePSG	$E7

Continue_Jump1:
	sVolEnvPSG	VolEnv_04
	dc.b nB6, $10
	sVolEnvPSG	VolEnv_01
	dc.b nB6, $08
	sVolEnvPSG	VolEnv_04
	dc.b nB6, $10
	sVolEnvPSG	VolEnv_01
	dc.b nB6, $08
	sVolEnvPSG	VolEnv_04
	dc.b nB6, $10
	sVolEnvPSG	VolEnv_01
	dc.b nB6, $08
	sVolEnvPSG	VolEnv_04
	dc.b nB6, $10
	sVolEnvPSG	VolEnv_01
	dc.b nB6, $08
	sVolEnvPSG	VolEnv_04
	dc.b nB6, $10
	sVolEnvPSG	VolEnv_01
	dc.b nB6, $08
	sVolEnvPSG	VolEnv_04
	dc.b nB6, $10
	sVolEnvPSG	VolEnv_01
	dc.b nB6, $08
	sVolEnvPSG	VolEnv_04
	dc.b nB6, $10
	sVolEnvPSG	VolEnv_01
	dc.b nB6, $08
	sVolEnvPSG	VolEnv_04
	dc.b nB6, $18
	sJump		Continue_Jump1
