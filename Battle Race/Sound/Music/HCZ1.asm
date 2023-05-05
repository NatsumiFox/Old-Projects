HCZ1_Header:
	sHeaderInit	; Z80 offset is $B0BC
	sHeaderPatchUniv
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $53
	sHeaderDAC	HCZ1_DAC
	sHeaderFM	HCZ1_FM1, $0C, $14
	sHeaderFM	HCZ1_FM2, $18, $0C
	sHeaderFM	HCZ1_FM3, $0C, $14
	sHeaderFM	HCZ1_FM4, $0C, $0F
	sHeaderFM	HCZ1_FM5, $0C, $0F
	sHeaderPSG	HCZ1_PSG1, $F4, $04, $00, VolEnv_0C
	sHeaderPSG	HCZ1_PSG2, $E8, $04, $00, VolEnv_0C
	sHeaderPSG	HCZ1_PSG3, $00, $03, $00, VolEnv_0C

HCZ1_DAC:
HCZ1_Loop5:
HCZ1_Jump8:
	dc.b dKick, $14, $04, dSnare, $20, dKick, $10, dSnare
	dc.b $14, dKick, $18, $04, dSnare, $20, dKick, $10
	dc.b dSnare, $18
	sLoop		$00, $03, HCZ1_Loop5
	dc.b dKick, $14, $04, dSnare, $20, dKick, $10, dSnare
	dc.b $14, dKick, $18, $04, dSnare, $20, dKick, $10
	dc.b dSnare, $0C, dSnare
	sCall		HCZ1_Call4
	dc.b dKick, dSnare, $14, dSnare, $0C, dKick, dKick, $04
	dc.b dSnare, $18
	sCall		HCZ1_Call4
	dc.b dKick, $18, dSnare, $14, dSnare, $10
	sPan		spLeft, $00
	dc.b dHighTom, $04
	sPan		spCenter, $00
	dc.b dMidTom
	sPan		spRight, $00
	dc.b dLowTom, $0C
	sPan		spCenter, $00
	dc.b dSnare, $04, dSnare, $08, dSnare, $04
	sCall		HCZ1_Call4
	dc.b dKick, dSnare, $14, dSnare, $0C, dKick, dKick, $04
	dc.b dSnare, $18
	sCall		HCZ1_Call4
	dc.b dSnare, $0C, dSnare, dSnare, dSnare, $08, dSnare, $34

HCZ1_Loop6:
	dc.b dKick, $14, dKick, $04, dSnare, $08, dKick, $18
	dc.b dKick, $10, dSnare, $18
	sLoop		$00, $06, HCZ1_Loop6
	dc.b dKick, $14, dKick, $04, dSnare, $08, dKick, $18
	dc.b dKick, $10, dSnare, $20, dSnare, $0C, dSnare, dSnare
	dc.b $04, dSnare, $0C, dSnare, $18, dSnare, $0C, dSnare
	sJump		HCZ1_Jump8
	; Unused
	dc.b $F2

HCZ1_Call4:
	dc.b dKick, $18, dSnare, $14, dKick, $0C, dKick, $04
	dc.b dKick, $0C, dSnare, $18
	sRet

HCZ1_FM1:
	sPan		spRight, $00

HCZ1_Jump7:
	sPatFM		$1C
	saDetune	$FF
	ssModZ80	$0A, $01, $04, $06
	sCall		HCZ1_Call1
	sPatFM		$21
	saDetune	$01
	ssModZ80	$0A, $01, $06, $06
	sCall		HCZ1_Call2
	sPatFM		$03
	saDetune	$FE
	ssModZ80	$0F, $01, $06, $06
	sCall		HCZ1_Call3
	sJump		HCZ1_Jump7

HCZ1_Call1:
	dc.b nC5, $08, nG4, $04, nF4, $02
	saVolFM		$02
	dc.b nEb4
	saVolFM		$02
	dc.b nD4
	saVolFM		$02
	dc.b nC4
	saVolFM		$02
	dc.b nBb3
	saVolFM		$02
	dc.b nA3
	saVolFM		$02
	dc.b nG3
	saVolFM		$02
	dc.b nF3
	saVolFM		$02
	dc.b nRst, $04
	saVolFM		$F0
	dc.b nBb3, nA3, $08, nG3, $04, nF3, $02, nFs3
	dc.b $06, nF3, $04, nEb3, $08, nC3, $04, nBb3
	dc.b $0C, nBb3, $08, nA3, $10, nG3, $02
	saVolFM		$02
	dc.b nFs3
	saVolFM		$02
	dc.b nF3
	saVolFM		$02
	dc.b nEb3
	saVolFM		$02
	dc.b nD3
	saVolFM		$02
	dc.b nC3
	saVolFM		$02
	dc.b nBb2
	saVolFM		$02
	dc.b nA2
	saVolFM		$02
	dc.b nG2
	saVolFM		$02
	dc.b nRst, $36
	saVolFM		$EE
	dc.b nBb3, $08, nB3, $04, nC4, $08, nG3, $04
	dc.b nF3, $02
	saVolFM		$02
	dc.b nEb3
	saVolFM		$02
	dc.b nD3
	saVolFM		$02
	dc.b nC3
	saVolFM		$02
	dc.b nBb2
	saVolFM		$02
	dc.b nA2
	saVolFM		$02
	dc.b nG2
	saVolFM		$02
	dc.b nF2
	saVolFM		$02
	dc.b nRst, $04
	saVolFM		$F0
	dc.b nF3, $02, nFs3, nF3, $08, nEb3, $04, nF3
	dc.b $08, nEb3, $04, nC3, $08, nBb2, $04, nG3
	dc.b $0C, nG3, $08, nEb3, $1C, nRst, $48, nC5
	dc.b $08, nG4, $04, nF4, $02
	saVolFM		$02
	dc.b nEb4
	saVolFM		$02
	dc.b nD4
	saVolFM		$02
	dc.b nC4
	saVolFM		$02
	dc.b nBb3
	saVolFM		$02
	dc.b nA3
	saVolFM		$02
	dc.b nG3
	saVolFM		$02
	dc.b nF3
	saVolFM		$02
	dc.b nRst, $04
	saVolFM		$F0
	dc.b nBb3, nA3, $08, nG3, $04, nF3, $02, nFs3
	dc.b $06, nF3, $04, nEb3, $08, nC3, $04, nBb3
	dc.b $0C, nBb3, $08, nA3, $10, nG3, $02
	saVolFM		$02
	dc.b nFs3
	saVolFM		$02
	dc.b nF3
	saVolFM		$02
	dc.b nEb3
	saVolFM		$02
	dc.b nD3
	saVolFM		$02
	dc.b nC3
	saVolFM		$02
	dc.b nBb2
	saVolFM		$02
	dc.b nA2
	saVolFM		$02
	dc.b nG2
	saVolFM		$02
	dc.b nRst, $36
	saVolFM		$EE
	dc.b nBb3, $08, nB3, $04, nC4, $08, nG3, $04
	dc.b nF3, $02
	saVolFM		$02
	dc.b nEb3
	saVolFM		$02
	dc.b nD3
	saVolFM		$02
	dc.b nC3
	saVolFM		$02
	dc.b nBb2
	saVolFM		$02
	dc.b nA2
	saVolFM		$02
	dc.b nG2
	saVolFM		$02
	dc.b nF2
	saVolFM		$02
	dc.b nRst, $04
	saVolFM		$F0
	dc.b nF3, $02, nFs3, nF3, $08, nEb3, $04, nF3
	dc.b $08, nEb3, $04, nC3, $08, nBb2, $04, nG3
	dc.b $0C, nG3, $08, nEb3, $1C, nRst, $54
	sRet

HCZ1_Call2:
	dc.b nCs4, $08, nEb4, $04, nRst, $08, nEb4, $04
	dc.b nBb4, $08, nBb4, $04, nRst, $30, nF4, $0C
	dc.b nF4, $08, nFs4, $04, nF4, $0C, nF4, $08
	dc.b nEb4, $02, nRst, $0A, nAb3, $04, nB3, $02
	dc.b nC4, $06, nEb4, $04, nFs4, nRst, nFs4, nF4
	dc.b $02, nEb4, nCs4, nC4, nBb3, nAb3, nFs3, nF3
	dc.b nRst, $08, nEb4, nF4, $04, nRst, $08, nF4
	dc.b $04, nC5, $08, nC5, $04, nRst, $30, nG4
	dc.b $0C, nG4, $08, nAb4, $04, nG4, $0C, nG4
	dc.b $08, nF4, $04, nRst, $3C, nCs4, $08, nEb4
	dc.b $04, nRst, $08, nEb4, $04, nBb4, $08, nBb4
	dc.b $04, nRst, $30, nF4, $0C, nF4, $08, nFs4
	dc.b $04, nF4, $0C, nF4, $08, nEb4, $02, nRst
	dc.b $0A, nAb3, $04, nB3, $02, nC4, $06, nEb4
	dc.b $04, nFs4, nRst, nFs4, nF4, $02, nEb4, nCs4
	dc.b nC4, nBb3, nAb3, nFs3, nF3, nRst, $08, nEb4
	dc.b nF4, $04, nRst, $08, nF4, $04, nC5, $08
	dc.b nC5, $04, nRst, $24, nD4, $04, nF4, nG4
	dc.b nAb4, $08, nRst, $04, nAb4, $08, nRst, $04
	dc.b nAb4, $08, nRst, $04, nAb4, $08, nG4, $04
	dc.b nRst, $24
	sRet

HCZ1_Call3:
	dc.b nC4, $08, nD4, $04, nEb4, $24, nD4, $08
	dc.b nC4, $02, nRst, $0A, nD4, $10, nC4, $04
	dc.b nRst, $08, nBb3, $04, nRst, $08, nG3, $18
	dc.b nBb3, $14, nC4, $1C, nRst, $0C, nC4, $08
	dc.b nD4, $04, nEb4, $24, nD4, $08, nC4, $04
	dc.b nRst, $08, nD4, $10, nC4, $04, nRst, $08
	dc.b nBb3, $04, nRst, $08, nD4, $14, nD4, $04
	dc.b nD4, $18, nEb4, nF4, $0C, nC4, $08, nD4
	dc.b $04, nEb4, $24, nD4, $08, nC4, $04, nRst
	dc.b $08, nD4, $10, nC4, $04, nRst, $08, nBb3
	dc.b $04, nRst, $08, nG3, $18, nBb3, $14, nC4
	dc.b $1C, nRst, $0C, nC4, $08, nD4, $04, nEb4
	dc.b $14, nEb4, $04, nRst, $08, nD4, $04, nEb4
	dc.b $14, nEb4, $04, nF4, $0C, nEb4, $04, nRst
	dc.b $08, nC4, $04, nEb4, nAb4, nRst, $08, nC5
	dc.b $04, nRst, $08, nC5, $04, nRst, $08, nC5
	dc.b $04, nC5, $0C, nB4, $04, nRst, $2C
	sRet
	; Unused
	dc.b $F2

HCZ1_FM2:
HCZ1_Jump6:
	sPatFM		$00
	dc.b nC1, $12, nRst, $02, nC1, nRst, $0A, nBb0
	dc.b $02, nRst, nBb0, $08, nRst, $0C, nA0, $02
	dc.b nRst, nA0, $08, nRst, $04, nBb0, $0A, nRst
	dc.b $02, nBb0, $06, nRst, $02, nC1, nRst, $0A
	sPatFM		$14
	saDetune	$00
	ssModZ80	$02, $01, $01, $02
	saVolFM		$FC
	dc.b nC2, $02, nRst, $0A
	sPatFM		$00
	saVolFM		$04
	dc.b nC1, $02, nRst, $0A, nBb0, $02, nRst, nBb0
	dc.b $08, nRst, $0C, nA0, $02, nRst, nA0, $08
	dc.b nRst, $04, nBb0, $0A, nRst, $02, nBb0, $0A
	dc.b nRst, $02, nC1, $12, nRst, $02, nC1, nRst
	dc.b $0A, nBb0, $02, nRst, nBb0, $08, nRst, $0C
	dc.b nA0, $02, nRst, nA0, $08, nRst, $04, nBb0
	dc.b $0A, nRst, $02, nBb0, $06, nRst, $02, nC1
	dc.b nRst, $0A
	sPatFM		$14
	saDetune	$00
	ssModZ80	$02, $01, $01, $02
	saVolFM		$FC
	dc.b nBb1, $02
	sPatFM		$00
	saVolFM		$04
	dc.b nRst, $0A, nC1, $02, nRst, $0A, nBb0, $02
	dc.b nRst, nBb0, $08, nRst, $0C, nA0, $02, nRst
	dc.b nA0, $08, nRst, $04, nBb0, $0A, nRst, $02
	dc.b nBb0, $0A, nRst, $02, nC1, $12, nRst, $02
	dc.b nC1, nRst, $0A, nBb0, $02, nRst, nBb0, $08
	dc.b nRst, $0C, nA0, $02, nRst, nA0, $08, nRst
	dc.b $04, nBb0, $0A, nRst, $02, nBb0, $06, nRst
	dc.b $02, nC1, nRst, $0A
	sPatFM		$14
	saDetune	$00
	ssModZ80	$02, $01, $01, $02
	saVolFM		$FC
	dc.b nC2, $02, nRst, $0A
	sPatFM		$00
	saVolFM		$04
	dc.b nC1, $02, nRst, $0A, nBb0, $02, nRst, nBb0
	dc.b $08, nRst, $0C, nA0, $02, nRst, nA0, $08
	dc.b nRst, $04, nBb0, $0A, nRst, $02, nBb0, $0A
	dc.b nRst, $02, nC1, $12, nRst, $02, nC1, nRst
	dc.b $0A, nBb0, $02, nRst, nBb0, $08, nRst, $0C
	dc.b nA0, $02, nRst, nA0, $08, nRst, $04, nBb0
	dc.b $0A, nRst, $02, nBb0, $06, nRst, $02, nC1
	dc.b nRst, $0A
	sPatFM		$14
	saDetune	$00
	ssModZ80	$02, $01, $01, $02
	saVolFM		$FC
	dc.b nBb1, $02
	sPatFM		$00
	saVolFM		$04
	dc.b nRst, $0A, nC1, $02, nRst, $0A, nBb0, $02
	dc.b nRst, nBb0, $08, nRst, $0C, nA0, $02, nRst
	dc.b nA0, $08, nRst, $04, nBb0, $0A, nRst, $02
	dc.b nBb0, $0A, nRst, $02, nAb0, $06, nRst, nFs0
	dc.b $0A, nRst, $02, nF0, $0A, nRst, $02, nF0
	dc.b $06, nRst, $02, nFs0, nRst, $0A, nFs0, $02
	dc.b nRst, nF0, $0A, nRst, $02, nEb0, $0A, nRst
	dc.b $02, nF0, $0A, nRst, $02, nAb0, $06, nRst
	dc.b $02
	sPatFM		$14
	saDetune	$00
	ssModZ80	$02, $01, $01, $02
	saVolFM		$FC
	dc.b nAb1, nRst
	sPatFM		$00
	saVolFM		$04
	dc.b nEb1, $0A, nRst, $02, nF1, $0A, nRst, $02
	dc.b nFs1, $06, nRst, $02, nF1, nRst, $26, nAb0
	dc.b $0C, nBb0, $06, nRst, nAb0, $0A, nRst, $02
	dc.b nG0, $0A, nRst, $02, nG0, $06, nRst, $02
	dc.b nAb0, nRst, $0A, nAb0, $02, nRst, nG0, $0A
	dc.b nRst, $02, nF0, $0A, nRst, $02, nG0, $0A
	dc.b nRst, $02, nBb0, $06, nRst, $02
	sPatFM		$14
	saDetune	$00
	ssModZ80	$02, $01, $01, $02
	saVolFM		$FC
	dc.b nBb1, nRst
	sPatFM		$00
	saVolFM		$04
	dc.b nF1, $0A, nRst, $02, nG1, $0A, nRst, $02
	dc.b nAb1, $06, nRst, $02, nG1, nRst, $1A, nBb0
	dc.b $02, nRst, $06, nBb0, $0E, nRst, $02, nAb0
	dc.b $06, nRst, nFs0, $0A, nRst, $02, nF0, $0A
	dc.b nRst, $02, nF0, $06, nRst, $02, nFs0, nRst
	dc.b $0A, nFs0, $02, nRst, nF0, $0A, nRst, $02
	dc.b nEb0, $0A, nRst, $02, nF0, $0A, nRst, $02
	dc.b nAb0, $06, nRst, $02
	sPatFM		$14
	saDetune	$00
	ssModZ80	$02, $01, $01, $02
	saVolFM		$FC
	dc.b nAb1, nRst
	sPatFM		$00
	saVolFM		$04
	dc.b nEb1, $0A, nRst, $02, nF1, $0A, nRst, $02
	dc.b nFs1, $06, nRst, $02, nF1, nRst, $26, nAb0
	dc.b $0C, nBb0, $06, nRst, nAb0, $0A, nRst, $02
	dc.b nG0, $0A, nRst, $02, nG0, $06, nRst, $02
	dc.b nAb0, nRst, $0A, nAb0, $02, nRst, nG0, $0A
	dc.b nRst, $02, nF0, $0A, nRst, $02, nG0, $0A
	dc.b nRst, $02, nG0, $06, nRst, nG0, nRst, nG0
	dc.b nRst, nG0, nRst, $02, nG0, nRst, $26, nG0
	dc.b $04, nRst, nG0
	sPatFM		$14
	saDetune	$00
	ssModZ80	$02, $01, $01, $02
	saVolFM		$FF
	dc.b nF0, $12, nRst, $02, nF0, nRst, nEb0, $06
	dc.b nRst, $02, nF0, nRst, $16, nG0, $02, nRst
	dc.b nG1, $0A, nRst, $02, nG0, $16, nRst, $02
	dc.b nAb0, $12, nRst, $02, nAb0, nRst, nAb0, $06
	dc.b nRst, $02, nAb0, nRst, $16, nBb0, $02, nRst
	dc.b nBb0, $0A, nRst, $02, nBb0, $0A, nRst, $02
	dc.b nBb0, $04, nRst, nBb0, nF0, $12, nRst, $02
	dc.b nF0, nRst, nEb0, $06, nRst, $02, nF0, nRst
	dc.b $16, nG0, $02, nRst, nG1, $0A, nRst, $02
	dc.b nG0, $16, nRst, $02, nC1, $06, nRst, $02
	dc.b nC1, $0A, nRst, $02, nC1, nRst, nBb0, $06
	dc.b nRst, $02, nBb0, $0A, nRst, $02, nBb1, nRst
	dc.b $0A, nAb0, $02, nRst, nAb0, $06, nRst, nG0
	dc.b $0C, nG0, $04, nRst, nG0, nF0, $12, nRst
	dc.b $02, nF0, nRst, nEb0, $06, nRst, $02, nF0
	dc.b nRst, $16, nG0, $02, nRst, nG1, $0A, nRst
	dc.b $02, nG0, $16, nRst, $02, nAb0, $12, nRst
	dc.b $02, nAb0, nRst, nAb0, $06, nRst, $02, nAb0
	dc.b nRst, $16, nBb0, $02, nRst, nBb0, $0A, nRst
	dc.b $02, nBb0, $0A, nRst, $02, nBb0, $04, nRst
	dc.b nBb0, nAb0, $12, nRst, $02, nAb0, nRst, nAb0
	dc.b $06, nRst, $02, nAb0, nRst, $16, nF0, $02
	dc.b nRst, nF0, $0A, nRst, $02, nF0, $0A, nRst
	dc.b $02, nF0, $0A, nRst, nG0, $02, nRst, $0A
	dc.b nG0, $02, nRst, $0A, nG0, $02, nRst, nG0
	dc.b $0A, nRst, $02, nG0, nRst, $16
	sPatFM		$00
	saVolFM		$01
	dc.b nF0, $04, nRst, nFs0, $02, nRst, nG0, $06
	dc.b nRst, $02, nBb0, nRst
	sJump		HCZ1_Jump6
	; Unused
	dc.b $F2

HCZ1_FM3:
	sPan		spLeft, $00
	dc.b nRst, $01

HCZ1_Jump5:
	sPatFM		$1C
	saDetune	$01
	ssModZ80	$0A, $01, $04, $06
	sCall		HCZ1_Call1
	sPatFM		$21
	saDetune	$FF
	ssModZ80	$0A, $01, $06, $06
	sCall		HCZ1_Call2
	sPatFM		$03
	saDetune	$02
	ssModZ80	$0F, $01, $06, $06
	sCall		HCZ1_Call3
	sJump		HCZ1_Jump5
	; Unused
	dc.b $F2

HCZ1_FM4:
HCZ1_Jump4:
	sPatFM		$06
	saDetune	$01
	ssModZ80	$0A, $01, $03, $06
	dc.b nRst, $20, nBb3, $02, nRst, nA3, $06, nRst
	dc.b $02, nG3, nRst, $0E, nEb3, $06, nRst, $02
	dc.b nC3, nC3, nBb4, $0A, nRst, $02, nEb4, $06
	dc.b nRst, $02, nC4, nRst, $0E, nBb3, $06, nRst
	dc.b $02, nA3, nRst, $0A, nG3, $02, nRst, nA3
	dc.b $06, nRst, $02, nG3, nRst, $0A
	sPatFM		$0A
	saDetune	$01
	ssModZ80	$0A, $01, $03, $06
	saTranspose	$F4
	dc.b nRst, $10, nBb5, $02, nRst, $06, nD5, $02
	dc.b nEb5, $0E
	sPatFM		$06
	saDetune	$01
	ssModZ80	$0A, $01, $03, $06
	saTranspose	$0C
	dc.b nRst, $20, nFs3, $02, nRst, nF3, $06, nRst
	dc.b $02, nEb3, nRst, $0E, nC3, $06, nRst, $02
	dc.b nBb2, nBb2, nEb4, $0A, nRst, $02, nBb3, $06
	dc.b nRst, $02, nF3, nRst, $0E, nA3, $06, nRst
	dc.b $02, nG3, nRst, $0A, nF3, $02, nRst, nG3
	dc.b $06, nRst, $02, nF3, nRst
	sPatFM		$0A
	saDetune	$01
	ssModZ80	$0A, $01, $03, $06
	saTranspose	$F4
	dc.b nG4, $16, nRst, $02, nF4, $18
	sPatFM		$06
	saDetune	$01
	ssModZ80	$0A, $01, $03, $06
	saTranspose	$0C
	dc.b nRst, $20, nBb3, $02, nRst, nA3, $06, nRst
	dc.b $02, nG3, nRst, $0E, nEb3, $06, nRst, $02
	dc.b nC3, nC3, nBb4, $0A, nRst, $02, nEb4, $06
	dc.b nRst, $02, nC4, nRst, $0E, nBb3, $06, nRst
	dc.b $02, nA3, nRst, $0A, nG3, $02, nRst, nA3
	dc.b $06, nRst, $02, nG3, nRst, $0A
	sPatFM		$0A
	saDetune	$01
	ssModZ80	$0A, $01, $03, $06
	saTranspose	$F4
	dc.b nRst, $10, nBb5, $02, nRst, $06, nD5, $02
	dc.b nEb5, $0E
	sPatFM		$06
	saDetune	$01
	ssModZ80	$0A, $01, $03, $06
	saTranspose	$0C
	dc.b nRst, $20, nFs3, $02, nRst, nF3, $06, nRst
	dc.b $02, nEb3, nRst, $0E, nC3, $06, nRst, $02
	dc.b nBb2, nBb2, nEb4, $0A, nRst, $02, nBb3, $06
	dc.b nRst, $02, nF3, nRst, $0E, nA3, $06, nRst
	dc.b $02, nG3, nRst, $0A, nF3, $02, nRst, nG3
	dc.b $06, nRst, $02, nF3, nRst
	sPatFM		$0A
	saDetune	$01
	ssModZ80	$0A, $01, $03, $06
	saTranspose	$F4
	dc.b nG4, $16, nRst, $02, nF4, $18
	sPatFM		$06
	saDetune	$01
	ssModZ80	$0A, $01, $03, $06
	saTranspose	$0C
	dc.b nEb4, $0C, nBb2, $08, nC3, $04, nRst, $08
	dc.b nC3, $04, nFs3, $08, nFs3, $04, nFs4, $18
	dc.b nEb4, nRst, $0C, nFs3, $06, nRst, $02, nF3
	dc.b nRst, $0A, nEb3, $02, nRst, nF3, $06, nRst
	dc.b $02, nEb3, nRst, $1A, nFs5, $08, nFs5, $04
	dc.b nRst, $0C, nD4, nC3, $08, nD3, $04, nRst
	dc.b $08, nD3, $04, nAb3, $08, nAb3, $04, nAb4
	dc.b $18, nF4, nRst, $0C, nAb3, $06, nRst, $02
	dc.b nG3, nRst, $0A, nF3, $02, nRst, nG3, $06
	dc.b nRst, $02, nF3, nRst, $1A, nAb5, $08, nCs5
	dc.b $02, nD5, $0E, nEb4, $0C, nBb2, $08, nC3
	dc.b $04, nRst, $08, nC3, $04, nFs3, $08, nFs3
	dc.b $04, nFs4, $18, nEb4, nRst, $0C, nFs3, $06
	dc.b nRst, $02, nF3, nRst, $0A, nEb3, $02, nRst
	dc.b nF3, $06, nRst, $02, nEb3, nRst, $1A, nFs5
	dc.b $08, nFs5, $04, nRst, $0C, nD4, nC3, $08
	dc.b nD3, $04, nRst, $08, nD3, $04, nAb3, $08
	dc.b nAb3, $04, nAb4, $18, nF4, nD4, $08, nRst
	dc.b $04, nD4, $08, nRst, $04, nD4, $08, nRst
	dc.b $04, nD4, $08, nD4, $04, nRst, $14, nC5
	dc.b $02, nD5, nG5, $18
	sPatFM		$0A
	saDetune	$01
	ssModZ80	$0A, $01, $03, $06
	dc.b nA4, $02, nBb4, $04, nRst, $02, nBb4, $0C
	dc.b nA4, $02, nBb4, nRst, $08
	sPatFM		$06
	saDetune	$01
	ssModZ80	$0A, $01, $03, $06
	dc.b nEb4, $02, nRst, nD4, $06, nRst, $02, nC4
	dc.b nRst, $0A, nF4, $10, nEb4, $04, nRst, $08
	dc.b nD4, $04, nRst, $08, nC4, $16, nRst, $02
	dc.b nEb4, $06, nRst, nD4, $02, nEb4, $04, nRst
	dc.b $02, nD4, $10, nRst, $0C, nF4, $08, nF4
	dc.b $04, nRst, $0C
	sPatFM		$0A
	saDetune	$01
	ssModZ80	$0A, $01, $03, $06
	dc.b nA4, $02, nBb4, $10, nRst, $02, nBb4, nRst
	dc.b $0A
	sPatFM		$06
	saDetune	$01
	ssModZ80	$0A, $01, $03, $06
	dc.b nEb4, $02, nRst, nD4, $06, nRst, $02, nC4
	dc.b nRst, $0A, nF4, $10, nEb4, $04, nRst, $08
	dc.b nD4, $04, nRst, $08, nC5, $18, nBb4, nAb4
	dc.b nG4
	sPatFM		$0A
	saDetune	$01
	ssModZ80	$0A, $01, $03, $06
	dc.b nA4, $02, nBb4, $04, nRst, $02, nBb4, $0C
	dc.b nA4, $02, nBb4, nRst, $08
	sPatFM		$06
	saDetune	$01
	ssModZ80	$0A, $01, $03, $06
	dc.b nEb4, $02, nRst, nD4, $06, nRst, $02, nC4
	dc.b nRst, $0A, nF4, $10, nEb4, $04, nRst, $08
	dc.b nD4, $04, nRst, $08, nC4, $16, nRst, $02
	dc.b nEb4, $06, nRst, nD4, $02, nEb4, $04, nRst
	dc.b $02, nD4, $10, nRst, $0C, nF4, $08, nF4
	dc.b $04, nRst, $14, nG4, $02, nRst, nF4, $06
	dc.b nRst, $02, nEb4, nRst, $0A, nD4, $02, nRst
	dc.b nEb4, $06, nRst, $02, nC4, nRst, $1A, nEb4
	dc.b $18, nRst, $08, nG4, $02, nRst, $0A, nG4
	dc.b $02, nRst, $0A, nG4, $02, nRst, nG4, $0A
	dc.b nRst, $02, nG4, nRst, $2E
	sJump		HCZ1_Jump4
	; Unused
	dc.b $F2

HCZ1_FM5:
HCZ1_Jump3:
	sPatFM		$06
	saDetune	$FF
	ssModZ80	$0A, $01, $03, $06
	dc.b nEb4, $08, nC4, $04, nRst, $14, nG3, $02
	dc.b nRst, nF3, $06, nRst, $02, nEb3, nRst, $0E
	dc.b nC3, $06, nRst, $02, nG2, nG2, nF4, $0A
	dc.b nRst, $02, nBb3, $06, nRst, $02, nA3, nRst
	dc.b $0A, nC3, $02, nRst, nG3, $06, nRst, $02
	dc.b nF3, nRst, $0A, nEb3, $02, nRst, nF3, $06
	dc.b nRst, $02, nEb3, nRst, $0A
	sPatFM		$0A
	saDetune	$FF
	ssModZ80	$0A, $01, $03, $06
	saTranspose	$F4
	dc.b nF4, $02, nRst, nFs4, $06, nRst, $02, nG4
	dc.b nRst, nF5, nRst, $06, nBb4, $10
	sPatFM		$06
	saDetune	$FF
	ssModZ80	$0A, $01, $03, $06
	saTranspose	$0C
	dc.b nEb4, $08, nC4, $04, nRst, $14, nEb3, $02
	dc.b nRst, nD3, $06, nRst, $02, nC3, nRst, $0E
	dc.b nA2, $06, nRst, $02, nG2, nG2, nBb3, $0A
	dc.b nRst, $02, nF3, $06, nRst, $02, nD3, nRst
	dc.b $0A, nC3, $02, nRst, nF3, $06, nRst, $02
	dc.b nEb3, nRst, $0A, nD3, $02, nRst, nEb3, $06
	dc.b nRst, $02, nD3, nRst
	sPatFM		$0A
	saDetune	$FF
	ssModZ80	$0A, $01, $03, $06
	saTranspose	$F4
	dc.b nEb4, $16, nRst, $02, nD4, $18
	sPatFM		$06
	saDetune	$FF
	ssModZ80	$0A, $01, $03, $06
	saTranspose	$0C
	dc.b nEb4, $08, nC4, $04, nRst, $14, nG3, $02
	dc.b nRst, nF3, $06, nRst, $02, nEb3, nRst, $0E
	dc.b nC3, $06, nRst, $02, nG2, nG2, nF4, $0A
	dc.b nRst, $02, nBb3, $06, nRst, $02, nA3, nRst
	dc.b $0A, nC3, $02, nRst, nG3, $06, nRst, $02
	dc.b nF3, nRst, $0A, nEb3, $02, nRst, nF3, $06
	dc.b nRst, $02, nEb3, nRst, $0A
	sPatFM		$0A
	saDetune	$FF
	ssModZ80	$0A, $01, $03, $06
	saTranspose	$F4
	dc.b nF4, $02, nRst, nFs4, $06, nRst, $02, nG4
	dc.b nRst, nF5, nRst, $06, nBb4, $10
	sPatFM		$06
	saDetune	$FF
	ssModZ80	$0A, $01, $03, $06
	saTranspose	$0C
	dc.b nEb4, $08, nC4, $04, nRst, $14, nEb3, $02
	dc.b nRst, nD3, $06, nRst, $02, nC3, nRst, $0E
	dc.b nA2, $06, nRst, $02, nG2, nG2, nBb3, $0A
	dc.b nRst, $02, nF3, $06, nRst, $02, nD3, nRst
	dc.b $0A, nC3, $02, nRst, nF3, $06, nRst, $02
	dc.b nEb3, nRst, $0A, nD3, $02, nRst, nEb3, $06
	dc.b nRst, $02, nD3, nRst
	sPatFM		$0A
	saDetune	$FF
	ssModZ80	$0A, $01, $03, $06
	saTranspose	$F4
	dc.b nEb4, $16, nRst, $02, nD4, $18
	sPatFM		$06
	saDetune	$FF
	ssModZ80	$0A, $01, $03, $06
	saTranspose	$0C
	dc.b nC4, $0C, nFs2, $08, nAb2, $04, nRst, $08
	dc.b nAb2, $04, nEb3, $08, nEb3, $04, nEb4, $18
	dc.b nC4, nRst, $08, nAb2, $02, nRst, nEb3, $06
	dc.b nRst, $02, nCs3, nRst, $0A, nC3, $02, nRst
	dc.b nCs3, $06, nRst, $02, nC3, nRst, $0E, nFs3
	dc.b $04, nAb3, nC4, nEb5, $08, nEb5, $04, nRst
	dc.b $0C, nBb3, nAb2, $08, nBb2, $04, nRst, $08
	dc.b nBb2, $04, nF3, $08, nF3, $04, nF4, $18
	dc.b nD4, nRst, $08, nBb2, $02, nRst, nF3, $06
	dc.b nRst, $02, nEb3, nRst, $0A, nD3, $02, nRst
	dc.b nEb3, $06, nRst, $02, nD3, nRst, $0E, nAb3
	dc.b $04, nBb3, nD4, nF5, $08, nG4, $02, nAb4
	dc.b $0E, nC4, $0C, nFs2, $08, nAb2, $04, nRst
	dc.b $08, nAb2, $04, nEb3, $08, nEb3, $04, nEb4
	dc.b $18, nC4, nRst, $08, nAb2, $02, nRst, nEb3
	dc.b $06, nRst, $02, nCs3, nRst, $0A, nC3, $02
	dc.b nRst, nCs3, $06, nRst, $02, nC3, nRst, $0E
	dc.b nFs3, $04, nAb3, nC4, nEb5, $08, nEb5, $04
	dc.b nRst, $0C, nBb3, nAb2, $08, nBb2, $04, nRst
	dc.b $08, nBb2, $04, nF3, $08, nF3, $04, nF4
	dc.b $18, nD4, nB3, $08, nRst, $04, nB3, $08
	dc.b nRst, $04, nB3, $08, nRst, $04, nB3, $08
	dc.b nB3, $04, nRst, $14, nB4, $02, nCs5, nBb4
	dc.b nB4, $16
	sPatFM		$0A
	saDetune	$FF
	ssModZ80	$0A, $01, $03, $06
	dc.b nG4, $06, nRst, $02, nG4, $0C, nG4, $04
	dc.b nRst, $08
	sPatFM		$06
	saDetune	$FF
	ssModZ80	$0A, $01, $03, $06
	dc.b nC4, $02, nRst, nBb3, $06, nRst, $02, nAb3
	dc.b nRst, $0A, nBb3, $10, nG3, $04, nRst, $08
	dc.b nF3, $04, nRst, $08, nBb3, $16, nRst, $02
	dc.b nC4, $06, nRst, nC4, nRst, $02, nF3, $10
	dc.b nC4, $04, nCs4, nD4, nBb3, $08, nBb3, $04
	dc.b nEb4, $02, nD4, nC4, nBb3, nAb3, nRst
	sPatFM		$0A
	saDetune	$FF
	ssModZ80	$0A, $01, $03, $06
	dc.b nG4, $12, nRst, $02, nG4, nRst, $0A
	sPatFM		$06
	saDetune	$FF
	ssModZ80	$0A, $01, $03, $06
	dc.b nC4, $02, nRst, nBb3, $06, nRst, $02, nAb3
	dc.b nRst, $0A, nBb3, $10, nG3, $04, nRst, $08
	dc.b nF3, $04, nRst, $08, nG4, $18, nF4, nEb4
	dc.b nD4
	sPatFM		$0A
	saDetune	$FF
	ssModZ80	$0A, $01, $03, $06
	dc.b nG4, $06, nRst, $02, nG4, $0C, nG4, $04
	dc.b nRst, $08
	sPatFM		$06
	saDetune	$FF
	ssModZ80	$0A, $01, $03, $06
	dc.b nC4, $02, nRst, nBb3, $06, nRst, $02, nAb3
	dc.b nRst, $0A, nBb3, $10, nG3, $04, nRst, $08
	dc.b nF3, $04, nRst, $08, nBb3, $16, nRst, $02
	dc.b nC4, $06, nRst, nC4, nRst, $02, nF3, $10
	dc.b nC4, $04, nCs4, nD4, nBb3, $08, nBb3, $04
	dc.b nEb4, $02, nD4, nC4, nBb3, nAb3, nRst, $0A
	dc.b nEb4, $02, nRst, nD4, $06, nRst, $02, nC4
	dc.b nRst, $0A, nBb3, $02, nRst, nC4, $06, nRst
	dc.b $02, nAb3, nRst, $0A, nEb3, $04, nAb3, $08
	dc.b nEb3, $04, nC4, $18, nRst, $08, nD4, $02
	dc.b nRst, $0A, nD4, $02, nRst, $0A, nD4, $02
	dc.b nRst, nD4, $0A, nRst, $02, nD4, nRst, $2E
	sJump		HCZ1_Jump3
	; Unused
	dc.b $F2

HCZ1_PSG1:
	sVolEnvPSG	VolEnv_0A

HCZ1_Jump2:
	dc.b nC5, $04, nRst, nG4, nRst, $0C, nC4, $04
	dc.b nRst, $08, nG4, $04, nRst, nC5, nRst, $08
	dc.b nC5, $04, nG4, nRst, $14, nBb4, $04, nRst
	dc.b nC5, nRst, $08, nC5, $04, nG4, nRst, $08
	dc.b nC4, $04, nRst, $08, nG4, $04, nRst, nC5
	dc.b nRst, $08, nF4, $02, nRst, nFs4, $06, nRst
	dc.b $02, nG4, nRst, nBb5, nRst, $06, nD5, $02
	dc.b nEb5, $0E, nC5, $04, nRst, nG4, nRst, $0C
	dc.b nC4, $04, nRst, $08, nG4, $04, nRst, nC5
	dc.b nRst, $08, nC5, $04, nG4, nRst, $14, nBb4
	dc.b $04, nRst, nC5, nRst, $08, nC5, $04, nG4
	dc.b nRst, $08, nC4, $04, nRst, $08, nG4, $04
	dc.b nRst, nC5, nFs4, $02, nG4, $14, nRst, $02
	dc.b nF4, $18, nC5, $04, nRst, nG4, nRst, $0C
	dc.b nC4, $04, nRst, $08, nG4, $04, nRst, nC5
	dc.b nRst, $08, nC5, $04, nG4, nRst, $14, nBb4
	dc.b $04, nRst, nC5, nRst, $08, nC5, $04, nG4
	dc.b nRst, $08, nC4, $04, nRst, $08, nG4, $04
	dc.b nRst, nC5, nRst, $08, nF4, $02, nRst, nFs4
	dc.b $06, nRst, $02, nG4, nRst, nBb5, nRst, $06
	dc.b nD5, $02, nEb5, $0E, nC5, $04, nRst, nG4
	dc.b nRst, $0C, nC4, $04, nRst, $08, nG4, $04
	dc.b nRst, nC5, nRst, $08, nC5, $04, nG4, nRst
	dc.b $14, nBb4, $04, nRst, nC5, nRst, $08, nC5
	dc.b $04, nG4, nRst, $08, nC4, $04, nRst, $08
	dc.b nG4, $04, nRst, nC5, nFs4, $02, nG4, $14
	dc.b nRst, $02, nF4, $18, nAb3, $02, nRst, $06
	dc.b nAb3, $02, nRst, nAb4, nRst, $06, nAb3, $02
	dc.b nRst, nAb3, nRst, $06, nAb3, $02, nRst, nFs4
	dc.b nRst, $06, nAb3, $02, nRst, $0A, nAb3, $02
	dc.b nRst, nFs4, nRst, $06, nAb3, $02, nRst, $0A
	dc.b nAb3, $02, nRst, nFs4, nRst, $06, nAb3, $02
	dc.b nRst, nAb3, nRst, $06, nAb3, $02, nRst, nAb4
	dc.b nRst, $0A, nAb3, $02, nRst, $0A, nFs4, $02
	dc.b nRst, $06, nAb3, $02, nRst, $32, nBb3, $02
	dc.b nRst, $06, nBb3, $02, nRst, nBb4, nRst, $06
	dc.b nBb3, $02, nRst, nBb3, nRst, $06, nBb3, $02
	dc.b nRst, nAb4, nRst, $06, nBb3, $02, nRst, $0A
	dc.b nBb3, $02, nRst, nAb4, nRst, $06, nBb3, $02
	dc.b nRst, $0A, nBb3, $02, nRst, nAb4, nRst, $06
	dc.b nBb3, $02, nRst, nBb3, nRst, $06, nBb3, $02
	dc.b nRst, nBb4, nRst, $0A, nBb3, $02, nRst, $0A
	dc.b nAb4, $02, nRst, $06, nBb3, $02, nRst, $0E
	dc.b nAb3, $02, nRst, nAb3, nRst, nAb3, nRst, nBb3
	dc.b $08, nAb4, $04, nBb3, $08, nBb4, $04, nAb3
	dc.b $02, nRst, $06, nAb3, $02, nRst, nAb4, nRst
	dc.b $06, nAb3, $02, nRst, nAb3, nRst, $06, nAb3
	dc.b $02, nRst, nFs4, nRst, $06, nAb3, $02, nRst
	dc.b $0A, nAb3, $02, nRst, nFs4, nRst, $06, nAb3
	dc.b $02, nRst, $0A, nAb3, $02, nRst, nFs4, nRst
	dc.b $06, nAb3, $02, nRst, nAb3, nRst, $06, nAb3
	dc.b $02, nRst, nAb4, nRst, $0A, nAb3, $02, nRst
	dc.b $0A, nFs4, $02, nRst, $06, nAb3, $02, nRst
	dc.b $32, nBb3, $02, nRst, $06, nBb3, $02, nRst
	dc.b nBb4, nRst, $06, nBb3, $02, nRst, nBb3, nRst
	dc.b $06, nBb3, $02, nRst, nAb4, nRst, $06, nBb3
	dc.b $02, nRst, $0A, nBb3, $02, nRst, nAb4, nRst
	dc.b $06, nBb3, $02, nRst, $0A, nBb3, $02, nRst
	dc.b nAb4, nRst, $06, nBb3, $02, nRst, nD4, nRst
	dc.b $0A, nD4, $02, nRst, $0A, nD4, $02, nRst
	dc.b $0A, nD4, $02, nRst, $06, nG4, $02, nRst
	dc.b $32, nBb4, $02, nRst, $06, nBb4, $02, nRst
	dc.b $0A, nBb4, $02, nRst, $0A, nEb4, $02, nRst
	dc.b nD4, $06, nRst, $02, nC4, nRst, $0A, nF4
	dc.b $10, nEb4, $04, nRst, $08, nD4, $04, nRst
	dc.b $08, nC4, $18, nEb4, $14, nD4, $34, nBb4
	dc.b $02, nRst, $06, nBb4, $02, nRst, $0A, nBb4
	dc.b $02, nRst, $0A, nEb4, $02, nRst, nD4, $06
	dc.b nRst, $02, nC4, nRst, $0A, nF4, $10, nEb4
	dc.b $04, nRst, $08, nD4, $04, nRst, $08, nC3
	dc.b $04, nRst, nG3, nC4, nRst, nG4, nBb2, nRst
	dc.b nF3, nBb3, nRst, nF4, nRst, $08, nEb3, $04
	dc.b nAb3, nRst, nEb4, nG2, nRst, nD3, nG3, nRst
	dc.b nD4, nBb4, $02, nRst, $06, nBb4, $02, nRst
	dc.b $0A, nBb4, $02, nRst, $0A, nEb4, $02, nRst
	dc.b nD4, $06, nRst, $02, nC4, nRst, $0A, nF4
	dc.b $10, nEb4, $04, nRst, $08, nD4, $04, nRst
	dc.b $08, nC4, $18, nEb4, $14, nD4, $34, nRst
	dc.b $08, nG4, $02, nRst, nF4, $06, nRst, $02
	dc.b nEb4, nRst, $0A, nD4, $02, nRst, nEb4, $06
	dc.b nRst, $02, nC4, nRst, $0A, nEb3, $04, nAb3
	dc.b $08, nEb3, $04, nEb4, $18, nRst, $08, nG4
	dc.b $02, nRst, $0A, nG4, $02, nRst, $0A, nG4
	dc.b $02, nRst, nG4, $0A, nRst, $02, nG4, nRst
	dc.b $2E
	sJump		HCZ1_Jump2
	; Unused
	dc.b $F2

HCZ1_PSG2:
	sVolEnvPSG	VolEnv_0A
	dc.b nRst, $01
	saDetune	$01
	sJump		HCZ1_Jump2
	; Unused
	dc.b $F6, $F9, $BF, $F2

HCZ1_PSG3:
	sVolEnvPSG	VolEnv_02
	sNoisePSG	$E7

HCZ1_Loop1:
HCZ1_Jump1:
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $08, nBb6, $04
	sVolEnvPSG	VolEnv_08
	dc.b nBb6, $08
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $04
	sLoop		$01, $24, HCZ1_Loop1

HCZ1_Loop2:
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $08, nBb6, $04, nBb6, $08, nBb6, $04
	dc.b nBb6, $08, nBb6, $04, nBb6, $08, nBb6, $04
	dc.b nBb6, $08, nBb6, $04, nBb6, $08, nBb6, $04
	dc.b nBb6, $08, nBb6, $04
	sVolEnvPSG	VolEnv_08
	dc.b nBb6, $08
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $04
	sLoop		$01, $02, HCZ1_Loop2
	dc.b nBb6, $08, nBb6, $04, nBb6, $08, nBb6, $04
	dc.b nBb6, $08, nBb6, $04, nBb6, $08, nBb6, $34

HCZ1_Loop3:
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $08, nBb6, $04, nBb6, $08, nBb6, $04
	dc.b nBb6, $08, nBb6, $04, nBb6, $08, nBb6, $04
	dc.b nBb6, $08, nBb6, $04, nBb6, $08, nBb6, $04
	dc.b nBb6, $08, nBb6, $04
	sVolEnvPSG	VolEnv_08
	dc.b nBb6, $08
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $04
	sLoop		$01, $02, HCZ1_Loop3
	dc.b nBb6, $08, nBb6, $04, nBb6, $08, nBb6, $04
	dc.b nBb6, $08, nBb6, $04, nBb6, $08, nBb6, $04
	dc.b nBb6, $08, nBb6, $04, nBb6, $08, nBb6, $04
	dc.b nBb6, $08, nBb6, $04
	sVolEnvPSG	VolEnv_08
	dc.b nBb6, $08
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $64

HCZ1_Loop4:
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $08, nBb6, $04
	sVolEnvPSG	VolEnv_08
	dc.b nBb6, $08
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $04, nBb6, $08, nBb6, $04
	sVolEnvPSG	VolEnv_08
	dc.b nBb6, $08
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $04
	sLoop		$01, $0E, HCZ1_Loop4
	dc.b nRst, $60
	sJump		HCZ1_Jump1
	; Unused
	dc.b $F2
