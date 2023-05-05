AIZ1_Header:
	sHeaderInit	; Z80 offset is $8000
	sHeaderPatchUniv
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $1F
	sHeaderDAC	AIZ1_DAC
	sHeaderFM	AIZ1_FM1, $18, $0F
	sHeaderFM	AIZ1_FM2, $0C, $16
	sHeaderFM	AIZ1_FM3, $0C, $16
	sHeaderFM	AIZ1_FM4, $0C, $16
	sHeaderFM	AIZ1_FM5, $0C, $16
	sHeaderPSG	AIZ1_PSG1, $F4, $04, $00, VolEnv_0C
	sHeaderPSG	AIZ1_PSG2, $F4, $04, $00, VolEnv_0C
	sHeaderPSG	AIZ1_PSG3, $00, $04, $00, VolEnv_0C

AIZ1_DAC:
AIZ1_Loop10:
AIZ1_Jump9:
	sCall		AIZ1_Call11
	sLoop		$00, $03, AIZ1_Loop10
	dc.b dKick, $0C, dHighMetalHit, $06, dLowTom, dKick, $0C, dMidTom
	dc.b $06, dLowMetalHit, dKick, $0C, dHighMetalHit, $06, dLowTom, dKick
	dc.b $0C, dSnare

AIZ1_Loop11:
	sCall		AIZ1_Call11
	sLoop		$00, $03, AIZ1_Loop11
	dc.b dSnare, dSnare, dSnare, dSnare, dKick, dHighTom, dMidTom, dLowTom
	dc.b dKick, dHigherMetalHit, $09, dHigherMetalHit, $02, dHigherMetalHit, $01, dHigherMetalHit
	dc.b $06, dHigherMetalHit, dHigherMetalHit, $12

AIZ1_Loop12:
	sCall		AIZ1_Call11
	sLoop		$00, $07, AIZ1_Loop12
	dc.b dKick, $18, dKick, $17, dSnare, $01, dSnare, $06
	dc.b dSnare, $0C, dSnare, dSnare, $06, dSnare, $0C
	sCall		AIZ1_Call11
	dc.b dKick, $0C, dHighMetalHit, $06, dLowTom, dKick, $0C, dMidTom
	dc.b $06, dLowMetalHit, dKick, $0C, dHighMetalHit, $06, dLowTom, dKick
	dc.b $0C, dSnare
	sCall		AIZ1_Call11
	dc.b dKick, $0C, dHighMetalHit, $06, dLowTom, dKick, $0C, dMidTom
	dc.b $06, dLowMetalHit, dKick, dHigherMetalHit, dHighMetalHit, dLowTom, dKick, $0C
	dc.b dSnare, $06, dSnare
	sCall		AIZ1_Call11
	dc.b dKick, $0C, dHighMetalHit, $06, dLowTom, dKick, $0C, dMidTom
	dc.b $06, dLowMetalHit, dKick, $0C, dHighMetalHit, $06, dLowTom, dKick
	dc.b $0C, dSnare
	sCall		AIZ1_Call11
	dc.b dKick, $0C, dHighMetalHit, $06, dLowTom, dKick, $0C, dMidTom
	dc.b $06, dLowMetalHit, dSnare, dSnare, dSnare, $0C, dSnare, $06
	dc.b dSnare, dSnare, $0C, dKick

AIZ1_Loop13:
	sCall		AIZ1_Call12
	sLoop		$00, $03, AIZ1_Loop13
	dc.b dHighMetalHit, $06, dLowTom, dKick, $0C, dMidTom, $06, dLowMetalHit
	dc.b dKick, dSnare, dHighMetalHit, dSnare, dSnare, $0C, dSnare, $06
	dc.b dMetalHit, dKick, $0C

AIZ1_Loop14:
	sCall		AIZ1_Call12
	sLoop		$00, $03, AIZ1_Loop14
	dc.b dHighMetalHit, $06, dLowTom, dKick, $0C, dMidTom, $06, dLowMetalHit
	dc.b dKick, $0C, dHighMetalHit, $06, dLowTom, dSnare, $0C, dSnare
	dc.b $06, dMetalHit, dKick, $0C

AIZ1_Loop15:
	sCall		AIZ1_Call12
	sLoop		$00, $02, AIZ1_Loop15
	dc.b dHighMetalHit, $06, dLowTom, dKick, $0C, dMidTom, $06, dLowMetalHit
	dc.b dKick, $0C, dHighMetalHit, $06, dLowTom, dSnare, $0C, dHighTom
	dc.b $06, dMetalHit, $03, dMidMetalHit, $02, dMidMetalHit, $01, dHigherMetalHit
	dc.b $06, dHigherMetalHit, $0C, dHigherMetalHit, dLowTom, $06, dSnare, $06
	dc.b dKick, $0C, dKick, dKick, $03, dKick, dSnare, $06
	dc.b nRst, $12
	sJump		AIZ1_Jump9

AIZ1_Call11:
	dc.b dKick, $0C, dHighMetalHit, $06, dLowTom, dKick, $0C, dMidTom
	dc.b $06, dLowMetalHit, dKick, $0C, dHighMetalHit, $06, dLowTom, dKick
	dc.b $0C, dHighTom, $06, dMetalHit
	sRet

AIZ1_Call12:
	dc.b dHighMetalHit, $06, dLowTom, dKick, $0C, dMidTom, $06, dLowMetalHit
	dc.b dKick, $0C, dHighMetalHit, $06, dLowTom, dSnare, $0C, dHighTom
	dc.b $06, dMetalHit, dKick, $0C
	sRet

AIZ1_FM1:
AIZ1_Jump8:
	sPatFM		$15
	saDetune	$00
	ssModZ80	$03, $01, $02, $05
	dc.b nC1, $0B, nRst, $01
	sPatFM		$14
	saDetune	$00
	ssModZ80	$03, $01, $02, $05
	dc.b nRst, nC2, $04, nRst, $07, nBb1, $0B, nRst
	dc.b $01, nA1, $05, nRst, $01, nBb1, $05, nRst
	dc.b $07, nA1, $05, nRst, $01, nBb1, $05, nRst
	dc.b $07, nBb1, $05, nRst, $07, nC2, $0B, nRst
	dc.b $01
	sPatFM		$15
	saDetune	$00
	ssModZ80	$03, $01, $02, $05
	dc.b nC1, $0B, nRst, $01
	sPatFM		$14
	saDetune	$00
	ssModZ80	$03, $01, $02, $05
	dc.b nBb1, nC2, $04, nRst, $07, nBb1, $0B, nRst
	dc.b $01, nA1, $05, nRst, $01, nBb1, $05, nRst
	dc.b $07
	sPatFM		$15
	saDetune	$00
	ssModZ80	$03, $01, $02, $05
	dc.b nBb0, $05, nRst, $07, nBb0, $05, nRst, $07
	dc.b nBb0, $05, nRst, $01, nB0, $0B, nRst, $01
	dc.b nC1, $0B, nRst, $01
	sPatFM		$14
	saDetune	$00
	ssModZ80	$03, $01, $02, $05
	dc.b nB1, nC2, $04, nRst, $07, nBb1, $0B, nRst
	dc.b $01, nA1, $05, nRst, $01, nBb1, $05, nRst
	dc.b $07, nA1, $05, nRst, $01, nBb1, $05, nRst
	dc.b $07, nBb1, $05, nRst, $08, nC2, $0A, nRst
	dc.b $01
	sPatFM		$15
	saDetune	$00
	ssModZ80	$03, $01, $02, $05
	dc.b nC1, $0B, nRst, $01
	sPatFM		$14
	saDetune	$00
	ssModZ80	$03, $01, $02, $05
	dc.b nC2, $05, nRst, $07, nBb1, $0B, nRst, $01
	dc.b nA1, $05, nRst, $01, nBb1, $05, nRst, $07
	sPatFM		$15
	saDetune	$00
	ssModZ80	$03, $01, $02, $05
	dc.b nBb0, $05, nRst, $07, nBb0, $05, nRst, $07
	dc.b nBb0, $05, nRst, $01, nB0, $0B, nRst, $01
	sPatFM		$15
	saDetune	$00
	ssModZ80	$03, $01, $02, $05
	dc.b nC1, $0B, nRst, $01
	sPatFM		$14
	saDetune	$00
	ssModZ80	$03, $01, $02, $05
	dc.b nRst, nC2, $04, nRst, $07, nBb1, $0B, nRst
	dc.b $01, nA1, $05, nRst, $01, nBb1, $05, nRst
	dc.b $07, nA1, $05, nRst, $01, nBb1, $05, nRst
	dc.b $07, nBb1, $05, nRst, $07, nC2, $0B, nRst
	dc.b $01
	sPatFM		$15
	saDetune	$00
	ssModZ80	$03, $01, $02, $05
	dc.b nC1, $0B, nRst, $01
	sPatFM		$14
	saDetune	$00
	ssModZ80	$03, $01, $02, $05
	dc.b nBb1, nC2, $04, nRst, $07, nBb1, $0B, nRst
	dc.b $01, nA1, $05, nRst, $01, nBb1, $05, nRst
	dc.b $07
	sPatFM		$15
	saDetune	$00
	ssModZ80	$03, $01, $02, $05
	dc.b nBb0, $05, nRst, $07, nBb0, $05, nRst, $07
	dc.b nBb0, $05, nRst, $01, nB0, $0B, nRst, $01
	dc.b nC1, $0B, nRst, $01
	sPatFM		$14
	saDetune	$00
	ssModZ80	$03, $01, $02, $05
	dc.b nB1, nC2, $04, nRst, $07, nBb1, $0B, nRst
	dc.b $01, nA1, $05, nRst, $01, nBb1, $05, nRst
	dc.b $07, nA1, $05, nRst, $01, nBb1, $05, nRst
	dc.b $07, nBb1, $05, nRst, $08, nC2, $0A, nRst
	dc.b $01
	sPatFM		$15
	saDetune	$00
	ssModZ80	$03, $01, $02, $05
	dc.b nG0, $05, nRst, $01, nG0, $05, nRst, $01
	dc.b nG0, $05, nRst, $01, nG0, $05, nRst, $1F
	dc.b nF0, $05, nRst, $01, nA0, $0B, nRst, $01
	dc.b nBb0, $0B, nRst, $01, nB0, $0B, nRst, $01
	dc.b nC1, $16, nRst, $02, nC1, $10, nRst, $02
	dc.b nC1, $10, nRst, $02, nG0, $0A, nRst, $02
	dc.b nC1, $0A, nRst, $02, nG0, $0A, nRst, $02
	dc.b nF0, $16, nRst, $02, nF0, $10, nRst, $02
	dc.b nF0, $0A, nRst, $02, nF0, $04, nRst, $02
	dc.b nA0, $0A, nRst, $02, nBb0, $0A, nRst, $02
	dc.b nB0, $0A, nRst, $02, nC1, $16, nRst, $02
	dc.b nC1, $10, nRst, $02, nC1, $10, nRst, $02
	dc.b nG0, $0A, nRst, $02, nC1, $0A, nRst, $02
	dc.b nG0, $0A, nRst, $02, nF0, $16, nRst, $02
	dc.b nF0, $10, nRst, $02, nF0, $0A, nRst, $02
	dc.b nF0, $04, nRst, $02, nA0, $0A, nRst, $02
	dc.b nBb0, $0A, nRst, $02, nB0, $0A, nRst, $02
	dc.b nC1, $16, nRst, $02, nC1, $10, nRst, $02
	dc.b nC1, $10, nRst, $02, nG0, $0A, nRst, $02
	dc.b nC1, $0A, nRst, $02, nG0, $0A, nRst, $02
	dc.b nF0, $16, nRst, $02, nF0, $10, nRst, $02
	dc.b nF0, $0A, nRst, $02, nF0, $04, nRst, $02
	dc.b nA0, $0A, nRst, $02, nBb0, $0A, nRst, $02
	dc.b nB0, $0A, nRst, $02, nC1, $16, nRst, $02
	dc.b nC1, $10, nRst, $02, nC1, $10, nRst, $02
	dc.b nG0, $0A, nRst, $02, nC1, $0A, nRst, $02
	dc.b nG0, $0A, nRst, $02, nF0, $16, nRst, $02
	dc.b nF0, $10, nRst, $02, nF0, $0A, nRst, $02
	dc.b nF0, $04, nRst, $02, nA0, $0A, nRst, $02
	dc.b nBb0, $0A, nRst, $02, nB0, $0A, nRst, $02
	dc.b nC1, $16, nRst, $02, nC1, $10, nRst, $02
	dc.b nC1, $10, nRst, $02, nG0, $0A, nRst, $02
	dc.b nC1, $0A, nRst, $02, nG0, $0A, nRst, $02
	dc.b nF0, $16, nRst, $02, nF0, $10, nRst, $02
	dc.b nF0, $0A, nRst, $02, nF0, $04, nRst, $02
	dc.b nA0, $0A, nRst, $02, nBb0, $0A, nRst, $02
	dc.b nB0, $0A, nRst, $02, nC1, $16, nRst, $02
	dc.b nC1, $10, nRst, $02, nC1, $10, nRst, $02
	dc.b nG0, $0A, nRst, $02, nC1, $0A, nRst, $02
	dc.b nG0, $0A, nRst, $02, nF0, $16, nRst, $02
	dc.b nF0, $10, nRst, $02, nF0, $0A, nRst, $02
	dc.b nF0, $04, nRst, $02, nA0, $0A, nRst, $02
	dc.b nBb0, $0A, nRst, $02, nB0, $0A, nRst, $02
	dc.b nC1, $16, nRst, $02, nC1, $10, nRst, $02
	dc.b nC1, $10, nRst, $02, nG0, $0A, nRst, $02
	dc.b nC1, $0A, nRst, $02, nG0, $0A, nRst, $02
	dc.b nF0, $16, nRst, $02, nF0, $10, nRst, $02
	dc.b nF0, $0A, nRst, $02, nF0, $04, nRst, $02
	dc.b nA0, $0A, nRst, $02, nBb0, $0A, nRst, $02
	dc.b nB0, $0A, nRst, $02, nC1, $16, nRst, $02
	dc.b nC1, $10, nRst, $02, nC1, $10, nRst, $02
	dc.b nG0, $0A, nRst, $02, nC1, $0A, nRst, $02
	dc.b nG0, $0A, nRst, $02, nF0, $16, nRst, $02
	dc.b nF0, $10, nRst, $02, nF0, $0A, nRst, $02
	dc.b nF0, $04, nRst, $02, nC1, $04, nRst, $02
	dc.b nF1, $04, nRst, $02, nF1, $04, nRst, $02
	dc.b nC1, $04, nRst, $02, nF0, $0A, nRst, $02
	dc.b nE0, $16, nRst, $02, nE0, $10, nRst, $02
	dc.b nA0, $10, nRst, $02, nA0, $0A, nRst, $02
	dc.b nE1, $0A, nRst, $02, nA0, $0A, nRst, $02
	dc.b nD1, $16, nRst, $02, nD1, $10, nRst, $02
	dc.b nG0, $0A, nRst, $02, nG0, $04, nRst, $02
	dc.b nG1, $0A, nRst, $02, nG1, $0A, nRst, $02
	dc.b nF1, $0A, nRst, $02, nE1, $16, nRst, $02
	dc.b nE1, $10, nRst, $02, nA0, $10, nRst, $02
	dc.b nA0, $0A, nRst, $02, nE1, $0A, nRst, $02
	dc.b nA0, $0A, nRst, $02, nD1, $16, nRst, $02
	dc.b nD1, $10, nRst, $02, nG0, $0A, nRst, $02
	dc.b nG0, $04, nRst, $02, nG1, $0A, nRst, $02
	dc.b nG1, $0A, nRst, $02, nF1, $0A, nRst, $02
	dc.b nE1, $16, nRst, $02, nE1, $10, nRst, $02
	dc.b nA0, $10, nRst, $02, nA0, $0A, nRst, $02
	dc.b nE1, $0A, nRst, $02, nA0, $0A, nRst, $02
	dc.b nD1, $16, nRst, $02, nD1, $10, nRst, $02
	dc.b nG0, $0A, nRst, $02, nG0, $04, nRst, $02
	dc.b nG1, $0A, nRst, $02, nG1, $0A, nRst, $02
	dc.b nF1, $0A, nRst, $02, nE1, $16, nRst, $02
	dc.b nE1, $10, nRst, $02, nA0, $10, nRst, $02
	dc.b nA0, $0A, nRst, $02, nE1, $0A, nRst, $02
	dc.b nA0, $0A, nRst, $02, nD1, $16, nRst, $02
	dc.b nD1, $10, nRst, $02, nG0, $0A, nRst, $02
	dc.b nG0, $04, nRst, $02, nG1, $0A, nRst, $02
	dc.b nFs1, $0A, nRst, $02, nFs1, $0A, nRst, $02
	dc.b nF1, $16, nRst, $02, nF1, $10, nRst, $02
	dc.b nC1, $10, nRst, $02, nC1, $0A, nRst, $02
	dc.b nF1, $0A, nRst, $02, nF1, $0A, nRst, $02
	dc.b nD1, $16, nRst, $02, nD1, $10, nRst, $02
	dc.b nA0, $10, nRst, $02, nA0, $0A, nRst, $02
	dc.b nD1, $0A, nRst, $02, nD1, $0A, nRst, $02
	dc.b nBb0, $16, nRst, $02, nBb0, $10, nRst, $02
	dc.b nF0, $10, nRst, $02, nF0, $0A, nRst, $02
	dc.b nBb0, $0A, nRst, $02, nBb0, $0A, nRst, $02
	dc.b nG0, $16, nRst, $02, nG0, $10, nRst, $02
	dc.b nB0, $10, nRst, $02, nB0, $0A, nRst, $02
	dc.b nC1, $0A, nRst, $02, nD1, $0A, nRst, $02
	sJump		AIZ1_Jump8

AIZ1_FM2:
AIZ1_Jump7:
	sPatFM		$18
	saDetune	$FB
	ssModZ80	$0F, $01, $06, $05
	sPan		spRight, $00
	sCall		AIZ1_Call1
	sCall		AIZ1_Call2
	sPatFM		$17
	saDetune	$05
	ssModZ80	$0F, $01, $03, $05
	sPan		spRight, $00
	sCall		AIZ1_Call3
	sPatFM		$11
	saDetune	$FB
	ssModZ80	$0F, $01, $06, $06
	sPan		spRight, $00
	dc.b nD3, nF3, nD4, nC4, $1E
	sPatFM		$18
	saDetune	$FB
	ssModZ80	$0F, $01, $06, $05
	sPan		spRight, $00
	sCall		AIZ1_Call4
	sPatFM		$11
	saDetune	$FB
	ssModZ80	$0F, $01, $06, $06
	sPan		spRight, $00
	dc.b nA3, $06, nA3, nA3, nA3, nRst, $24
	saVolFM		$FA
	saVolFM		$FB
	sPatFM		$06
	saDetune	$FB
	ssModZ80	$0F, $01, $06, $05
	sPan		spCenter, $00
	sCall		AIZ1_Call5
	sPatFM		$06
	saDetune	$FB
	ssModZ80	$0F, $01, $06, $05
	sPan		spCenter, $00
	sCall		AIZ1_Call6
	dc.b nBb1, $01, sHold, nAb2, $01, sHold, nBb2, $39
	dc.b nRst, $3D
	sPatFM		$06
	saDetune	$FB
	ssModZ80	$0F, $01, $06, $05
	sPan		spCenter, $00
	sCall		AIZ1_Call7
	sPatFM		$06
	saDetune	$FB
	ssModZ80	$0F, $01, $06, $05
	sPan		spCenter, $00
	sCall		AIZ1_Call8
	dc.b nRst, $03
	saVolFM		$05
	saVolFM		$F8
	sPatFM		$0F
	saDetune	$03
	ssModZ80	$0F, $01, $06, $05
	sPan		spRight, $00
	sCall		AIZ1_Call9
	dc.b nRst, $1F
	saVolFM		$08
	sPatFM		$06
	saDetune	$03
	ssModZ80	$0F, $01, $06, $05
	sPan		spCenter, $00
	sCall		AIZ1_Call10
	dc.b nRst, $07
	saVolFM		$FE
	sPatFM		$0F
	saDetune	$03
	ssModZ80	$0F, $01, $06, $05
	sPan		spRight, $00
	dc.b nG3, $0B, nRst, $01, nD4, $0B, nRst, $01
	dc.b nG4, $0B, nRst, $01
	sPatFM		$0F
	saDetune	$03
	ssModZ80	$0F, $01, $06, $05
	sPan		spRight, $00
	dc.b nF4, $05, nRst, $0D, nE4, $05, nRst, $0D
	dc.b nC4, $05, nRst, $07, nA3, $30, nD4, $05
	dc.b nRst, $0D, nC4, $05, nRst, $0D, nB3, $05
	dc.b nRst, $0D
	saVolFM		$02
	sPatFM		$06
	saDetune	$03
	ssModZ80	$0F, $01, $06, $05
	sPan		spCenter, $00
	dc.b nG2, $30, nE2, $2F, nRst, $01, nA2, $0F
	dc.b nRst, $01, nG2, $0F, nRst, $01, nF2, $0F
	dc.b nRst, $01, nE2, $0F, nRst, $01, nF2, $0F
	dc.b nRst, $01, nA2, $0F, nRst, $07
	saVolFM		$FE
	sPatFM		$0F
	saDetune	$03
	ssModZ80	$0F, $01, $06, $05
	sPan		spRight, $00
	dc.b nG3, $0B, nRst, $01, nD4, $0B, nRst, $01
	dc.b nG4, $0B, nRst, $01, nF4, $05, nRst, $0D
	dc.b nE4, $05, nRst, $0D, nC4, $05, nRst, $07
	dc.b nA3, $30, nD4, $05, nRst, $0D, nC4, $05
	dc.b nRst, $0D, nB3, $05, nRst, $07
	sPatFM		$06
	saDetune	$FE
	ssModZ80	$0C, $01, $06, $05
	sPan		spLeft, $00
	dc.b nA3, $1D, nRst, $07, nA3, $02, nRst, $04
	dc.b nB3, $02, nRst, $04, nC4, $12, nB3, $12
	dc.b nA3, $0B, nRst, $01, nC4, $1D, nRst, $07
	dc.b nC4, $02, nRst, $04, nD4, $02, nRst, $04
	dc.b nE4, $12, nD4, $12, nC4, $0B, nRst, $01
	dc.b nD4, $30, nA3, $30, nC4, $18, nB3, nC4
	dc.b nD4
	saVolFM		$02
	sJump		AIZ1_Jump7
	; Unused
	dc.b $F2

AIZ1_FM3:
AIZ1_Jump6:
	sPatFM		$18
	saDetune	$05
	ssModZ80	$0F, $01, $06, $05
	sPan		spLeft, $00
	sCall		AIZ1_Call1
	sPatFM		$18
	saDetune	$05
	ssModZ80	$0F, $01, $06, $05
	sPan		spLeft, $00
	sCall		AIZ1_Call2
	sPatFM		$17
	saDetune	$FB
	ssModZ80	$0F, $01, $03, $05
	sPan		spLeft, $00
	sCall		AIZ1_Call3
	sPatFM		$06
	saDetune	$FE
	ssModZ80	$0C, $01, $06, $05
	sPan		spLeft, $00
	dc.b nF3, $06, nBb3, nF4, nE4, $1E
	sPatFM		$18
	saDetune	$05
	ssModZ80	$0F, $01, $06, $05
	sPan		spLeft, $00
	sCall		AIZ1_Call4
	dc.b nC5, $06, nC5, nC5, nC5, nRst, $24
	saVolFM		$FA
	sPatFM		$06
	saDetune	$03
	ssModZ80	$0F, $01, $06, $05
	sPan		spCenter, $00
	saVolFM		$00
	dc.b nRst, $03
	sCall		AIZ1_Call5
	sCall		AIZ1_Call6
	dc.b nD3, $3B, nRst, $3D
	sCall		AIZ1_Call7
	sCall		AIZ1_Call8
	saVolFM		$00
	sPatFM		$0F
	saDetune	$FB
	ssModZ80	$0F, $01, $06, $06
	sPan		spRight, $00
	sCall		AIZ1_Call9
	dc.b nRst, $19
	sPatFM		$06
	saDetune	$03
	ssModZ80	$0F, $01, $06, $05
	sPan		spCenter, $00
	sCall		AIZ1_Call10
	dc.b nRst, $01
	sPatFM		$06
	saDetune	$03
	ssModZ80	$0F, $01, $06, $05
	sPan		spCenter, $00
	dc.b nG2, $5F, nRst, $07, nA3, $2F, nRst, $01
	dc.b nD4, $05, nRst, $0D, nC4, $05, nRst, $0D
	dc.b nB3, $05, nRst, $01, nG2, $2F, nRst, $01
	dc.b nE2, $2F, nRst, $01
	sPatFM		$06
	saDetune	$03
	ssModZ80	$0F, $01, $06, $05
	sPan		spCenter, $00
	dc.b nA2, $0F, nRst, $01, nG2, $0F, nRst, $01
	dc.b nF2, $0F, nRst, $01, nE2, $0F, nRst, $01
	dc.b nF2, $0F, nRst, $01, nA2, $0F, nRst, $01
	dc.b nG2, $5F, nRst, $01, nA3, $2F, nRst, $01
	dc.b nD4, $05, nRst, $0D, nC4, $05, nRst, $0D
	dc.b nB3, $05, nRst, $07
	sPatFM		$0F
	saDetune	$FB
	ssModZ80	$0F, $01, $06, $06
	sPan		spRight, $00
	dc.b nRst, $60, nF3, $1D, nRst, $07, nF3, $02
	dc.b nRst, $04, nG3, $02, nRst, $04, nA3, $11
	dc.b nRst, $01, nG3, $11, nRst, $01, nF3, $0B
	dc.b nRst, $01
	sPatFM		$11
	saDetune	$FB
	ssModZ80	$0F, $01, $06, $06
	sPan		spRight, $00
	dc.b nA3, $2F, nRst, $01, nF3, $2F, nRst, $01
	dc.b nA3, $17, nRst, $01, nG3, $17, nRst, $01
	dc.b nA3, $17, nRst, $01, nB3, $17, nRst, $01
	sJump		AIZ1_Jump6

AIZ1_Call1:
	dc.b nG3, $04, nE3
	saVolFM		$06
	dc.b nG3, nE3
	saVolFM		$02
	dc.b nG3, nE3, nG3, nE3
	saVolFM		$02
	dc.b nG3, nE3, nG3, nE3
	saVolFM		$02
	dc.b nG3, nE3
	saVolFM		$FA
	dc.b nG3, nE3
	saVolFM		$FE
	dc.b nG3, nE3
	saVolFM		$FC
	dc.b nA3, nF3
	saVolFM		$06
	dc.b nA3, nF3
	saVolFM		$02
	dc.b nA3, nF3
	saVolFM		$F8
	sRet

AIZ1_Call2:
	dc.b nBb3, $04, nG3
	saVolFM		$04
	dc.b nBb3, nG3
	saVolFM		$02
	dc.b nBb3, nG3
	saVolFM		$02
	dc.b nBb3, nG3
	saVolFM		$02
	dc.b nBb3, nG3, nBb3, nG3
	saVolFM		$FE
	dc.b nBb3, nG3
	saVolFM		$FE
	dc.b nBb3
	saVolFM		$FE
	dc.b nG3
	saVolFM		$FE
	dc.b nBb3, nG3
	saVolFM		$FE
	dc.b nA3, nF3
	saVolFM		$04
	dc.b nA3, nF3
	saVolFM		$02
	dc.b nA3, nF3
	saVolFM		$FE
	dc.b nA3
	saVolFM		$FE
	dc.b nBb3
	saVolFM		$02
	dc.b nA3
	saVolFM		$FE
	dc.b nG3, nE3
	saVolFM		$02
	dc.b nG3, nE3
	saVolFM		$02
	dc.b nG3, nE3
	saVolFM		$02
	dc.b nG3, nE3
	saVolFM		$02
	dc.b nG3, nE3
	saVolFM		$FE
	dc.b nG3, nE3
	saVolFM		$FE
	dc.b nG3, nE3
	saVolFM		$FE
	dc.b nG3, nE3
	saVolFM		$FE
	dc.b nG3, nE3, nG3, nE3
	saVolFM		$FE
	dc.b nG3
	sRet

AIZ1_Call3:
	dc.b nC4, $06, nC4, nC5, nC4, nBb4, nC4, nBb4
	dc.b nC5
	sRet

AIZ1_Call4:
	dc.b nG3, $04, nE3
	saVolFM		$06
	dc.b nG3, nE3
	saVolFM		$02
	dc.b nG3, nE3, nG3, nE3
	saVolFM		$02
	dc.b nG3, nE3, nG3, nE3
	saVolFM		$02
	dc.b nG3, nE3
	saVolFM		$FA
	dc.b nG3, nE3
	saVolFM		$FE
	dc.b nG3, nE3
	saVolFM		$FC
	dc.b nA3, nF3
	saVolFM		$06
	dc.b nA3, nF3
	saVolFM		$02
	dc.b nA3, nF3
	saVolFM		$F8
	dc.b nBb3, nG3
	saVolFM		$04
	dc.b nBb3, nG3
	saVolFM		$02
	dc.b nBb3, nG3
	saVolFM		$02
	dc.b nBb3, nG3
	saVolFM		$02
	dc.b nBb3, nG3, nBb3, nG3
	saVolFM		$FE
	dc.b nBb3, nG3
	saVolFM		$FE
	dc.b nBb3
	saVolFM		$FE
	dc.b nG3
	saVolFM		$FE
	dc.b nBb3, nG3
	saVolFM		$FE
	dc.b nA3, nF3
	saVolFM		$04
	dc.b nA3, nF3
	saVolFM		$02
	dc.b nA3, nF3
	saVolFM		$FE
	dc.b nA3
	saVolFM		$FE
	dc.b nBb3
	saVolFM		$02
	dc.b nA3
	saVolFM		$FE
	dc.b nG3, nE3
	saVolFM		$02
	dc.b nG3, nE3
	saVolFM		$02
	dc.b nG3, nE3
	saVolFM		$02
	dc.b nG3, nE3
	saVolFM		$02
	dc.b nG3, nE3
	saVolFM		$FE
	dc.b nG3, nE3
	saVolFM		$FE
	dc.b nG3, nE3
	saVolFM		$FE
	dc.b nG3, nE3
	saVolFM		$FE
	dc.b nG3, nE3, nG3, nE3
	saVolFM		$FE
	dc.b nG3
	sRet

AIZ1_Call5:
	dc.b nF1, $01, sHold, nEb2, $01, sHold, nF2, $0A
	dc.b nBb1, $01, sHold, nAb2, $01, sHold, nBb2, $0A
	dc.b nF2, $01, sHold, nEb3, $01, sHold, nF3, $0A
	dc.b nE2, $01, sHold, nD3, $01, sHold, nE3, $03
	dc.b nRst, $0D, nC2, $01, sHold, nBb2, $01, sHold
	dc.b nC3, $03, nRst, $0D, nBb1, $01, sHold, nAb2
	dc.b $01, sHold, nBb2, $39, nRst, $3D
	sRet

AIZ1_Call6:
	dc.b nF1, $01, sHold, nEb2, $01, sHold, nF2, $0A
	dc.b nBb1, $01, sHold, nAb2, $01, sHold, nBb2, $0A
	dc.b nF2, $01, sHold, nEb3, $01, sHold, nF3, $0A
	dc.b nE2, $01, sHold, nD3, $01, sHold, nE3, $03
	dc.b nRst, $0D, nC2, $01, sHold, nBb2, $01, sHold
	dc.b nC3, $03, nRst, $0D
	sRet

AIZ1_Call7:
	dc.b nF1, $01, sHold, nEb2, $01, sHold, nF2, $0A
	dc.b nBb1, $01, sHold, nAb2, $01, sHold, nBb2, $0A
	dc.b nF2, $01, sHold, nEb3, $01, sHold, nF3, $0A
	dc.b nE2, $01, sHold, nD3, $01, sHold, nE3, $03
	dc.b nRst, $0D, nC2, $01, sHold, nBb2, $01, sHold
	dc.b nC3, $03, nRst, $0D, nBb1, $01, sHold, nAb2
	dc.b $01, sHold, nBb2, $39, nRst, $3D
	sRet

AIZ1_Call8:
	dc.b nF1, $01, sHold, nEb2, $01, sHold, nF2, $0A
	dc.b nBb1, $01, sHold, nAb2, $01, sHold, nBb2, $0A
	dc.b nF2, $01, sHold, nEb3, $01, sHold, nF3, $0A
	dc.b nE2, $01, sHold, nD3, $01, sHold, nE3, $03
	dc.b nRst, $0D, nC2, $01, sHold, nBb2, $01, sHold
	dc.b nC3, $03, nRst, $0D, nD2, $01, sHold, nC3
	dc.b $01, sHold, nD3, $39, nRst, $49
	saVolFM		$06
	dc.b nRst, $09
	sRet

AIZ1_Call9:
	dc.b nE4, $05, nRst, $01, nF4, $05, nRst, $01
	dc.b nG4, $05, nRst, $0D, nC4, $05, nRst, $0D
	dc.b nBb4, $11, nRst, $07, nBb4, $05, nRst, $07
	dc.b nBb4, $05, nRst, $07, nG4, $05, nRst, $07
	dc.b nA4, $05, nRst, $0D, nF4, $05, nRst, $0D
	dc.b nC4, $29, nRst, $07, nE4, $05, nRst, $01
	dc.b nF4, $05, nRst, $01, nG4, $05, nRst, $0D
	dc.b nC4, $05, nRst, $0D, nBb4, $11, nRst, $07
	dc.b nBb4, $05, nRst, $07, nBb4, $05, nRst, $07
	dc.b nC5, $05, nRst, $07, nA4, $2F, nRst, $25
	dc.b nE4, $05, nRst, $01, nF4, $05, nRst, $01
	dc.b nG4, $05, nRst, $0D, nC4, $05, nRst, $0D
	dc.b nBb4, $0B, nRst, $07, nBb4, $02, nRst, $04
	dc.b nBb4, $02, nRst, $0A, nBb4, $05, nRst, $07
	dc.b nG4, $05, nRst, $07, nA4, $05, nRst, $0D
	dc.b nF4, $05, nRst, $0D, nC4, $23, nRst, $0D
	dc.b nE4, $05, nRst, $01, nF4, $05, nRst, $01
	dc.b nG4, $05, nRst, $0D, nC4, $05, nRst, $0D
	dc.b nBb4, $11, nRst, $07, nBb4, $05, nRst, $07
	dc.b nBb4, $05, nRst, $07, nC5, $05, nRst, $07
	dc.b nA4, $11, nRst, $01, nBb4, $11, nRst, $01
	dc.b nC5, $23
	sRet

AIZ1_Call10:
	dc.b nG1, $01, sHold, nF2, $01, sHold, nG2, $2D
	dc.b nRst, $01, nE1, $01, sHold, nD2, $01, sHold
	dc.b nE2, $2D, nRst, $01, nA1, $01, sHold, nG2
	dc.b $01, sHold, nA2, $0D, nRst, $01, nG1, $01
	dc.b sHold, nF2, $01, sHold, nG2, $0D, nRst, $01
	dc.b nF1, $01, sHold, nEb2, $01, sHold, nF2, $0D
	dc.b nRst, $01, nE1, $01, sHold, nD2, $01, sHold
	dc.b nE2, $0D, nRst, $01, nF1, $01, sHold, nEb2
	dc.b $01, sHold, nF2, $0D, nRst, $01, nA1, $01
	dc.b sHold, nG2, $01, sHold, nA2, $0D
	sRet
	; Unused
	dc.b $F2

AIZ1_FM4:
AIZ1_Jump5:
	sPatFM		$16
	saDetune	$FB
	ssModZ80	$03, $01, $02, $05
	sPan		spRight, $00
	dc.b nG3, $05, nRst, $0D, nG3, $05, nRst, $19
	dc.b nG3, $05, nRst, $0D, nG3, $05, nRst, $19
	dc.b nF3, $05, nRst, $0D, nF3, $05, nRst, $07
	sPatFM		$06
	saDetune	$FE
	ssModZ80	$0C, $01, $06, $05
	sPan		spLeft, $00
	dc.b nD3, $04, nRst, $02, nE3, $04, nRst, $02
	dc.b nF3, $04, nRst, $08
	sPatFM		$16
	saDetune	$FB
	ssModZ80	$03, $01, $02, $05
	sPan		spRight, $00
	dc.b nF3, $05, nRst, $07, nF3, $05, nRst, $07
	dc.b nF3, $05, nRst, $01, nFs3, $05, nRst, $07
	dc.b nG3, $05, nRst, $0D, nG3, $05, nRst, $19
	dc.b nG3, $05, nRst, $0D, nG3, $05, nRst, $19
	dc.b nF3, $05, nRst, $0D, nF3, $05, nRst, $19
	sPatFM		$06
	saDetune	$FE
	ssModZ80	$0C, $01, $06, $05
	sPan		spLeft, $00
	dc.b nF3, $04, nRst, $02, nBb3, $04, nRst, $02
	dc.b nF4, $04, nRst, $02, nE4, $1D, nRst, $01
	sPatFM		$16
	saDetune	$FB
	ssModZ80	$03, $01, $02, $05
	sPan		spRight, $00
	dc.b nG3, $05, nRst, $0D, nG3, $05, nRst, $19
	dc.b nG3, $05, nRst, $0D, nG3, $05, nRst, $19
	dc.b nF3, $05, nRst, $0D, nF3, $05, nRst, $07
	sPatFM		$06
	saDetune	$FE
	ssModZ80	$0C, $01, $06, $05
	sPan		spLeft, $00
	dc.b nD3, $04, nRst, $02, nE3, $04, nRst, $02
	dc.b nF3, $04, nRst, $08
	sPatFM		$16
	saDetune	$FB
	ssModZ80	$03, $01, $02, $05
	sPan		spRight, $00
	dc.b nF3, $05, nRst, $07, nF3, $05, nRst, $07
	dc.b nF3, $05, nRst, $01, nFs3, $05, nRst, $07
	dc.b nG3, $05, nRst, $0D, nG3, $05, nRst, $19
	dc.b nG3, $05, nRst, $0D, nG3, $05, nRst, $19
	sPatFM		$06
	saDetune	$FE
	ssModZ80	$0C, $01, $06, $05
	sPan		spLeft, $00
	dc.b nC4, $05, nRst, $01, nC4, $05, nRst, $01
	dc.b nC4, $05, nRst, $01, nC4, $05, nRst, $55
	sPatFM		$17
	saDetune	$FB
	ssModZ80	$0F, $01, $03, $05
	sPan		spLeft, $00
	dc.b nD3, $02, nRst, $0A, nE3, $02, nRst, $16
	dc.b nD3, $11, nRst, $01, nE3, $02, nRst, $28
	dc.b nA4, $05, nRst, $01, nBb4, $05, nRst, $07
	dc.b nBb4, $02, nRst, $04, nBb4, $02, nRst, $04
	dc.b nBb4, $02, nRst, $04, nBb4, $02, nRst, $0A
	dc.b nA4, $23, nRst, $0D, nD3, $02, nRst, $0A
	dc.b nE3, $02, nRst, $16, nD3, $11, nRst, $01
	dc.b nE3, $02, nRst, $28, nA4, $05, nRst, $01
	dc.b nBb4, $05, nRst, $07, nBb4, $02, nRst, $04
	dc.b nBb4, $02, nRst, $04, nBb4, $02, nRst, $04
	dc.b nBb4, $02, nRst, $0A, nC5, $05, nRst, $01
	dc.b nBb4, $1D, nRst, $0D, nD3, $02, nRst, $0A
	dc.b nE3, $02, nRst, $16, nD3, $11, nRst, $01
	dc.b nE3, $02, nRst, $28, nA4, $05, nRst, $01
	dc.b nBb4, $05, nRst, $07, nBb4, $02, nRst, $04
	dc.b nBb4, $02, nRst, $04, nBb4, $02, nRst, $04
	dc.b nBb4, $02, nRst, $0A, nA4, $23, nRst, $0D
	dc.b nD3, $02, nRst, $0A, nE3, $02, nRst, $16
	dc.b nD3, $11, nRst, $01, nE3, $02, nRst, $28
	dc.b nA4, $05, nRst, $01, nBb4, $05, nRst, $07
	dc.b nBb4, $02, nRst, $04, nBb4, $02, nRst, $04
	dc.b nBb4, $02, nRst, $04, nBb4, $02, nRst, $0A
	dc.b nC5, $05, nRst, $01, nBb4, $1D, nRst, $0D
	sPatFM		$16
	saDetune	$FB
	ssModZ80	$03, $01, $02, $05
	sPan		spRight, $00
	dc.b nE3, $0B, nRst, $01, nE3, $0B, nRst, $0D
	dc.b nD3, $05, nRst, $0D, nE3, $05, nRst, $19
	dc.b nC2, $05, nRst, $01, nG2, $05, nRst, $01
	dc.b nC3, $05, nRst, $01, nBb2, $05, nRst, $07
	dc.b nBb2, $05, nRst, $07, nA2, $05, nRst, $07
	dc.b nA2, $05, nRst, $07, nF2, $05, nRst, $01
	dc.b nC2, $05, nRst, $1F, nE3, $0B, nRst, $01
	dc.b nE3, $0B, nRst, $0D, nD3, $05, nRst, $0D
	dc.b nE3, $05, nRst, $19, nC2, $05, nRst, $01
	dc.b nG2, $05, nRst, $01, nC3, $05, nRst, $01
	dc.b nBb2, $05, nRst, $07, nBb2, $05, nRst, $07
	dc.b nA2, $05, nRst, $07, nA2, $05, nRst, $07
	dc.b nBb2, $05, nRst, $01, nC3, $05, nRst, $1F
	dc.b nE3, $0B, nRst, $01, nE3, $0B, nRst, $0D
	dc.b nD3, $05, nRst, $0D, nE3, $05, nRst, $19
	dc.b nC2, $05, nRst, $01, nG2, $05, nRst, $01
	dc.b nC3, $05, nRst, $01, nBb2, $05, nRst, $07
	dc.b nBb2, $05, nRst, $07, nA2, $05, nRst, $07
	dc.b nA2, $05, nRst, $07, nF2, $05, nRst, $01
	dc.b nC2, $05, nRst, $1F, nE3, $0B, nRst, $01
	dc.b nE3, $0B, nRst, $0D, nD3, $05, nRst, $0D
	dc.b nE3, $05, nRst, $19, nC2, $05, nRst, $01
	dc.b nG2, $05, nRst, $01, nC3, $05, nRst, $01
	dc.b nBb2, $05, nRst, $07, nBb2, $05, nRst, $07
	dc.b nA2, $05, nRst, $07
	sPatFM		$06
	saDetune	$FE
	ssModZ80	$0C, $01, $06, $05
	sPan		spLeft, $00
	dc.b nA3, $02, nRst, $04, nBb3, $02, nRst, $04
	dc.b nC4, $02, nRst, $04, nEb4, $02, nRst, $04
	dc.b nD4, $02, nRst, $04, nBb3, $02, nRst, $04
	dc.b nC4, $02, nRst, $10
	sPatFM		$18
	saDetune	$05
	ssModZ80	$0F, $01, $06, $05
	sPan		spLeft, $00
	dc.b nG3, $0B, nRst, $01, nC4, $0B, nRst, $01
	dc.b nG4, $0B, nRst, $01, nF4, $05, nRst, $0D
	dc.b nE4, $05, nRst, $0D, nC4, $05, nRst, $07
	dc.b nA3, $03, nRst, $01

AIZ1_Loop4:
	saVolFM		$02
	dc.b nA3, $03, nRst, $01, nA3, $03, nRst, $01
	sLoop		$00, $04, AIZ1_Loop4
	saVolFM		$F8
	dc.b nC4, $05, nRst, $07, nB3, $05, nRst, $0D
	dc.b nC4, $05, nRst, $0D, nD4, $05, nRst, $07
	dc.b nE4, $03, nRst, $01

AIZ1_Loop5:
	saVolFM		$02
	dc.b nE4, $03, nRst, $01, nE4, $03, nRst, $01
	sLoop		$00, $05, AIZ1_Loop5
	saVolFM		$02
	dc.b nE4, $03, nRst, $01
	saVolFM		$F4
	dc.b nA3, $03, nRst, $01

AIZ1_Loop6:
	saVolFM		$02
	dc.b nA3, $03, nRst, $01, nA3, $03, nRst, $01
	sLoop		$00, $04, AIZ1_Loop6
	saVolFM		$F8
	dc.b nA3, $03, nRst, $09, nF4, $05, nRst, $0D
	dc.b nE4, $05, nRst, $0D, nD4, $05, nRst, $07
	dc.b nB3, $05, nRst, $0D, nA3, $05, nRst, $0D
	dc.b nG3, $05, nRst, $13, nG3, $0B, nRst, $01
	dc.b nC4, $0B, nRst, $01, nG4, $0B, nRst, $01
	dc.b nF4, $05, nRst, $0D, nE4, $05, nRst, $0D
	dc.b nC4, $05, nRst, $07, nA3, $03, nRst, $01

AIZ1_Loop7:
	saVolFM		$02
	dc.b nA3, $03, nRst, $01, nA3, $03, nRst, $01
	sLoop		$00, $04, AIZ1_Loop7
	saVolFM		$F8
	dc.b nC4, $05, nRst, $07, nB3, $05, nRst, $0D
	dc.b nC4, $05, nRst, $0D, nD4, $05, nRst, $07
	dc.b nG4, $03, nRst, $01

AIZ1_Loop8:
	saVolFM		$02
	dc.b nG4, $03, nRst, $01, nG4, $03, nRst, $01
	sLoop		$00, $05, AIZ1_Loop8
	saVolFM		$02
	dc.b nG4, $03, nRst, $01
	saVolFM		$F4
	dc.b nE4, $03, nRst, $01
	saVolFM		$02
	dc.b nE4, $03, nRst, $01, nE4, $03, nRst, $01

AIZ1_Loop9:
	saVolFM		$02
	dc.b nE4, $03, nRst, $01, nE4, $03, nRst, $01
	sLoop		$00, $03, AIZ1_Loop9
	saVolFM		$F8
	dc.b nA3, $03, nRst, $09, nF4, $05, nRst, $0D
	dc.b nE4, $05, nRst, $0D, nD4, $05, nRst, $07
	dc.b nB3, $05, nRst, $0D, nA3, $05, nRst, $0D
	dc.b nG3, $05, nRst, $07
	saVolFM		$F8
	sPatFM		$17
	saDetune	$FB
	ssModZ80	$0F, $01, $03, $05
	sPan		spLeft, $00
	dc.b nE4, $0B, nRst, $07, nE4, $03, nRst, $0F
	sPatFM		$16
	saDetune	$FB
	ssModZ80	$03, $01, $02, $05
	sPan		spRight, $00
	dc.b nF3, $05, nRst, $01, nG3, $05, nRst, $01
	dc.b nA3, $05, nRst, $0D, nB3, $05, nRst, $0D
	dc.b nC4, $05, nRst, $07
	sPatFM		$17
	saDetune	$FB
	ssModZ80	$0F, $01, $03, $05
	sPan		spLeft, $00
	dc.b nE4, $0B, nRst, $07, nE4, $03, nRst, $0F
	sPatFM		$16
	saDetune	$FB
	ssModZ80	$03, $01, $02, $05
	sPan		spRight, $00
	dc.b nF3, $05, nRst, $01, nG3, $05, nRst, $01
	dc.b nA3, $05, nRst, $0D, nB3, $05, nRst, $0D
	dc.b nC4, $05, nRst, $07, nF2, $05, nRst, $01
	dc.b nA2, $05, nRst, $01, nD3, $05, nRst, $01
	dc.b nF3, $05, nRst, $01, nD3, $05, nRst, $01
	dc.b nF3, $05, nRst, $01, nA3, $05, nRst, $01
	dc.b nD4, $05, nRst, $01, nA3, $05, nRst, $01
	dc.b nD4, $05, nRst, $01, nF4, $05, nRst, $01
	dc.b nA4, $05, nRst, $01, nF4, $05, nRst, $01
	dc.b nA4, $05, nRst, $01, nD5, $05, nRst, $01
	dc.b nF5, $05, nRst, $01
	sPatFM		$11
	saDetune	$FB
	ssModZ80	$0F, $01, $06, $06
	sPan		spRight, $00
	dc.b nC4, $17, nRst, $01, nB3, $17, nRst, $01
	dc.b nC4, $17, nRst, $01, nD4, $17, nRst, $01
	saVolFM		$08
	sJump		AIZ1_Jump5
	; Unused
	dc.b $F2

AIZ1_FM5:
AIZ1_Jump4:
	sPatFM		$16
	saDetune	$05
	ssModZ80	$03, $01, $02, $05
	sPan		spLeft, $00
	dc.b nE3, $05, nRst, $0D, nE3, $05, nRst, $19
	dc.b nE3, $05, nRst, $0D, nE3, $05, nRst, $19
	dc.b nD3, $05, nRst, $0D, nD3, $05, nRst, $07
	sPatFM		$11
	saDetune	$FB
	ssModZ80	$0F, $01, $06, $06
	sPan		spRight, $00
	dc.b nBb2, $04, nRst, $02, nC3, $04, nRst, $02
	dc.b nD3, $04, nRst, $08
	sPatFM		$16
	saDetune	$05
	ssModZ80	$03, $01, $02, $05
	sPan		spLeft, $00
	dc.b nD3, $05, nRst, $07, nD3, $05, nRst, $07
	dc.b nD3, $05, nRst, $01, nEb3, $05, nRst, $07
	dc.b nE3, $05, nRst, $0D, nE3, $05, nRst, $19
	dc.b nE3, $05, nRst, $0D, nE3, $05, nRst, $19
	dc.b nD3, $05, nRst, $0D, nD3, $05, nRst, $19
	sPatFM		$06
	saDetune	$02
	ssModZ80	$0C, $01, $FA, $05
	sPan		spRight, $00
	dc.b nD3, $02, nRst, $04, nF3, $02, nRst, $04
	dc.b nD4, $02, nRst, $04, nC4, $18, nRst, $06
	sPatFM		$16
	saDetune	$05
	ssModZ80	$03, $01, $02, $05
	sPan		spLeft, $00
	dc.b nE3, $05, nRst, $0D, nE3, $05, nRst, $19
	dc.b nE3, $05, nRst, $0D, nE3, $05, nRst, $19
	dc.b nD3, $05, nRst, $0D, nD3, $05, nRst, $07
	sPatFM		$11
	saDetune	$FB
	ssModZ80	$0F, $01, $06, $06
	sPan		spRight, $00
	dc.b nBb2, $04, nRst, $02, nC3, $04, nRst, $02
	dc.b nD3, $04, nRst, $08
	sPatFM		$16
	saDetune	$05
	ssModZ80	$03, $01, $02, $05
	sPan		spLeft, $00
	dc.b nD3, $05, nRst, $07, nD3, $05, nRst, $07
	dc.b nD3, $05, nRst, $01, nEb3, $05, nRst, $07
	dc.b nE3, $05, nRst, $0D, nE3, $05, nRst, $19
	dc.b nE3, $05, nRst, $0D, nE3, $05, nRst, $19
	sPatFM		$11
	saDetune	$FB
	ssModZ80	$0F, $01, $06, $06
	sPan		spRight, $00
	dc.b nA3, $05, nRst, $01, nA3, $05, nRst, $01
	dc.b nA3, $05, nRst, $01, nA3, $05, nRst, $28
	saVolFM		$04
	sPatFM		$06
	saDetune	$03
	ssModZ80	$0F, $01, $06, $05
	sPan		spCenter, $00
	dc.b nF1, $01, sHold, nEb2, $01, sHold, nF2, $0A
	dc.b nBb1, $01, sHold, nAb2, $01, sHold, nBb2, $0A
	dc.b nF2, $01, sHold, nEb3, $01, sHold, nF3, $0A
	dc.b nE2, $01, sHold, nD3, $01, sHold, nE3, $03
	dc.b nRst, $0D, nC2, $01, sHold, nBb2, $01, sHold
	dc.b nC3, $03, nRst, $0D, nBb1, $01, sHold, nAb2
	dc.b $01, sHold, nBb2, $39, nRst, $3D, nF1, $01
	dc.b sHold, nEb2, $01, sHold, nF2, $0A, nBb1, $01
	dc.b sHold, nAb2, $01, sHold, nBb2, $0A, nF2, $01
	dc.b sHold, nEb3, $01, sHold, nF3, $0A, nE2, $01
	dc.b sHold, nD3, $01, sHold, nE3, $03, nRst, $0D
	dc.b nC2, $01, sHold, nBb2, $01, sHold, nC3, $03
	dc.b nRst, $0D, nD2, $01, sHold, nC3, $01, sHold
	dc.b nD3, $39, nRst, $3D, nF1, $01, sHold, nEb2
	dc.b $01, sHold, nF2, $0A, nBb1, $01, sHold, nAb2
	dc.b $01, sHold, nBb2, $0A, nF2, $01, sHold, nEb3
	dc.b $01, sHold, nF3, $0A, nE2, $01, sHold, nD3
	dc.b $01, sHold, nE3, $03, nRst, $0D, nC2, $01
	dc.b sHold, nBb2, $01, sHold, nC3, $03, nRst, $0D
	dc.b nBb2, $3B, nRst, $3D, nF2, $0C, nBb2, $0C
	dc.b nF3, $0C, nE3, $05, nRst, $0D, nC3, $05
	dc.b nRst, $0D, nD3, $3B, nRst, $5E
	saVolFM		$FC
	dc.b nRst, $0C
	sPatFM		$16
	saDetune	$05
	ssModZ80	$03, $01, $02, $05
	sPan		spLeft, $00
	dc.b nC3, $0B, nRst, $01, nC3, $0B, nRst, $0D
	dc.b nBb2, $05, nRst, $0D, nC3, $05, nRst, $19
	saVolFM		$08
	sPatFM		$10
	saDetune	$05
	ssModZ80	$0F, $01, $FA, $06
	sPan		spLeft, $00
	dc.b nC5, $0C, nA4, $06, nBb4, $0C, nG4, nC5
	dc.b nA4, $06, nBb4, $0C, nG4, $24
	saVolFM		$F8
	sPatFM		$16
	saDetune	$05
	ssModZ80	$03, $01, $02, $05
	sPan		spLeft, $00
	dc.b nC3, $0B, nRst, $01, nC3, $0B, nRst, $0D
	dc.b nBb2, $05, nRst, $0D, nC3, $05, nRst, $19
	saVolFM		$08
	sPatFM		$10
	saDetune	$05
	ssModZ80	$0F, $01, $FA, $06
	sPan		spLeft, $00
	dc.b nC5, $0C, nA4, $06, nBb4, $0C, nG4, nC5
	dc.b nA4, $06, nBb4, $0C, nG4, $24
	saVolFM		$F8
	sPatFM		$16
	saDetune	$05
	ssModZ80	$03, $01, $02, $05
	sPan		spLeft, $00
	dc.b nC3, $0B, nRst, $01, nC3, $0B, nRst, $0D
	dc.b nBb2, $05, nRst, $0D, nC3, $05, nRst, $19
	saVolFM		$08
	sPatFM		$10
	saDetune	$05
	ssModZ80	$0F, $01, $FA, $06
	sPan		spLeft, $00
	dc.b nC5, $0C, nA4, $06, nBb4, $0C, nG4, nC5
	dc.b nA4, $06, nBb4, $0C, nG4, $24
	saVolFM		$F8
	sPatFM		$16
	saDetune	$05
	ssModZ80	$03, $01, $02, $05
	sPan		spLeft, $00
	dc.b nC3, $0B, nRst, $01, nC3, $0B, nRst, $0D
	dc.b nBb2, $05, nRst, $0D, nC3, $05, nRst, $19
	saVolFM		$08
	sPatFM		$10
	saDetune	$05
	ssModZ80	$0F, $01, $FA, $06
	sPan		spLeft, $00
	dc.b nC5, $0C, nA4, $06, nBb4, $0C, nG4, nC5
	dc.b $05, nRst, $07
	saVolFM		$F8
	sPatFM		$11
	saDetune	$FB
	ssModZ80	$0F, $01, $06, $06
	sPan		spRight, $00
	dc.b nF3, $02, nRst, $04, nG3, $02, nRst, $04
	dc.b nA3, $02, nRst, $04, nC4, $02, nRst, $04
	dc.b nBb3, $02, nRst, $04, nG3, $02, nRst, $04
	dc.b nA3, $02, nRst, $04
	sPatFM		$10
	saDetune	$05
	ssModZ80	$0F, $01, $FA, $06
	sPan		spLeft, $00
	dc.b nRst, $0C, nG4, $0B, nRst, $01, nC5, $0B
	dc.b nRst, $01, nG5, $0B, nRst, $01, nF5, $11
	dc.b nRst, $01, nE5, $11, nRst, $01, nC5, $0B
	dc.b nRst, $01, nA4, $23, nRst, $01, nC5, $0B
	dc.b nRst, $01, nB4, $11, nRst, $01, nC5, $11
	dc.b nRst, $01, nD5, $0B, nRst, $01, nE5, $2F
	dc.b nRst, $01, nA4, $23, nRst, $01, nA4, $0B
	dc.b nRst, $01, nF5, $11, nRst, $01, nE5, $11
	dc.b nRst, $01, nD5, $0B, nRst, $01, nB4, $11
	dc.b nRst, $01, nA4, $11, nRst, $01, nG4, $17
	dc.b nRst, $01, nG4, $0B, nRst, $01, nC5, $0B
	dc.b nRst, $01, nG5, $0B, nRst, $01, nF5, $11
	dc.b nRst, $01, nE5, $11, nRst, $01, nC5, $0B
	dc.b nRst, $01, nA4, $23, nRst, $01, nC5, $0B
	dc.b nRst, $01, nB4, $11, nRst, $01, nC5, $11
	dc.b nRst, $01, nD5, $0B, nRst, $01, nG5, $2F
	dc.b nRst, $01, nE5, $23, nRst, $01, nA4, $0B
	dc.b nRst, $01, nF5, $11, nRst, $01, nE5, $11
	dc.b nRst, $01, nD5, $0B, nRst, $01, nB4, $11
	dc.b nRst, $01, nA4, $11, nRst, $01, nG4, $0B
	dc.b nRst, $01
	sPatFM		$17
	saDetune	$05
	ssModZ80	$0F, $01, $03, $05
	sPan		spRight, $00
	dc.b nC4, $0B, nRst, $07, nC4, $03, nRst, $0F
	sPatFM		$16
	saDetune	$05
	ssModZ80	$03, $01, $02, $05
	sPan		spLeft, $00
	dc.b nD3, $05, nRst, $01, nE3, $05, nRst, $01
	dc.b nF3, $05, nRst, $0D, nG3, $05, nRst, $0D
	dc.b nA3, $05, nRst, $07
	sPatFM		$17
	saDetune	$05
	ssModZ80	$0F, $01, $03, $05
	sPan		spRight, $00
	dc.b nC4, $0B, nRst, $07, nC4, $03, nRst, $0F
	sPatFM		$16
	saDetune	$05
	ssModZ80	$03, $01, $02, $05
	sPan		spLeft, $00
	dc.b nD3, $05, nRst, $01, nE3, $05, nRst, $01
	dc.b nF3, $05, nRst, $0D, nG3, $05, nRst, $0D
	dc.b nA3, $05, nRst, $07
	sPatFM		$10
	saDetune	$05
	ssModZ80	$0F, $01, $FA, $06
	sPan		spLeft, $00
	dc.b nD5, $24, nD5, $06, nE5, nF5, $12, nE5
	dc.b nD5, $0C, nG5, $60
	sJump		AIZ1_Jump4
	; Unused
	dc.b $F2

AIZ1_PSG1:
AIZ1_Jump3:
	dc.b nG3, $05, nRst, $0D, nG3, $05, nRst, $19
	dc.b nG3, $05, nRst, $0D, nG3, $05, nRst, $19
	dc.b nF3, $05, nRst, $0D, nF3, $05, nRst, $07
	dc.b nD3, $02, nRst, $04, nE3, $02, nRst, $04
	dc.b nF3, $02, nRst, $0A, nF3, $05, nRst, $07
	dc.b nF3, $05, nRst, $07, nF3, $05, nRst, $01
	dc.b nFs3, $05, nRst, $07, nG3, $05, nRst, $0D
	dc.b nG3, $05, nRst, $19, nG3, $05, nRst, $0D
	dc.b nG3, $05, nRst, $19, nC4, $03, nRst, nC4
	dc.b nRst, nC5, nRst, nC4, nRst, nBb4, nRst, nC4
	dc.b nRst, nBb4, nRst, nC5, nRst, nF4, $02, nRst
	dc.b $04, nBb4, $02, nRst, $04, nF5, $02, nRst
	dc.b $04, nE5, $1D, nRst, $01, nG3, $05, nRst
	dc.b $0D, nG3, $05, nRst, $19, nG3, $05, nRst
	dc.b $0D, nG3, $05, nRst, $19, nF3, $05, nRst
	dc.b $0D, nF3, $05, nRst, $07, nD3, $02, nRst
	dc.b $04, nE3, $02, nRst, $04, nF3, $02, nRst
	dc.b $0A, nF3, $05, nRst, $07, nF3, $05, nRst
	dc.b $07, nF3, $05, nRst, $01, nFs3, $05, nRst
	dc.b $07, nG3, $05, nRst, $0D, nG3, $05, nRst
	dc.b $19, nG3, $05, nRst, $0D, nG3, $05, nRst
	dc.b $19, nC6, $05, nRst, $01, nC6, $05, nRst
	dc.b $01, nC6, $05, nRst, $01, nC6, $05, nRst
	dc.b $55, nD3, $02, nRst, $0A, nE3, $02, nRst
	dc.b $16, nD3, $11, nRst, $01, nE3, $02, nRst
	dc.b $28, nA4, $05, nRst, $01, nBb4, $05, nRst
	dc.b $07, nBb4, $02, nRst, $04, nBb4, $02, nRst
	dc.b $04, nBb4, $02, nRst, $04, nBb4, $02, nRst
	dc.b $0A, nA4, $23, nRst, $0D, nD3, $02, nRst
	dc.b $0A, nE3, $02, nRst, $16, nD3, $11, nRst
	dc.b $01, nE3, $02, nRst, $28, nA4, $05, nRst
	dc.b $01, nBb4, $05, nRst, $07, nBb4, $02, nRst
	dc.b $04, nBb4, $02, nRst, $04, nBb4, $02, nRst
	dc.b $04, nBb4, $02, nRst, $0A, nC5, $05, nRst
	dc.b $01, nBb4, $1D, nRst, $0D, nD3, $02, nRst
	dc.b $0A, nE3, $02, nRst, $16, nD3, $11, nRst
	dc.b $01, nE3, $02, nRst, $28, nA4, $05, nRst
	dc.b $01, nBb4, $05, nRst, $07, nBb4, $02, nRst
	dc.b $04, nBb4, $02, nRst, $04, nBb4, $02, nRst
	dc.b $04, nBb4, $02, nRst, $0A, nA4, $23, nRst
	dc.b $0D, nD3, $02, nRst, $0A, nE3, $02, nRst
	dc.b $16, nD3, $11, nRst, $01, nE3, $02, nRst
	dc.b $28, nA4, $05, nRst, $01, nBb4, $05, nRst
	dc.b $07, nBb4, $02, nRst, $04, nBb4, $02, nRst
	dc.b $04, nBb4, $02, nRst, $04, nBb4, $02, nRst
	dc.b $0A, nC5, $05, nRst, $01, nBb4, $1D, nRst
	dc.b $0D, nC3, $0B, nRst, $01, nC3, $0B, nRst
	dc.b $0D, nBb2, $05, nRst, $0D, nC3, $05, nRst
	dc.b $19, nC5, $0C, nA4, $06, nBb4, $0C, nG4
	dc.b nC5, nA4, $06, nBb4, $0C, nG4, $24, nC3
	dc.b $0B, nRst, $01, nC3, $0B, nRst, $0D, nBb2
	dc.b $05, nRst, $0D, nC3, $05, nRst, $19, nC5
	dc.b $0C, nA4, $06, nBb4, $0C, nG4, nC5, nA4
	dc.b $06, nBb4, $0C, nG4, $24, nC3, $0B, nRst
	dc.b $01, nC3, $0B, nRst, $0D, nBb2, $05, nRst
	dc.b $0D, nC3, $05, nRst, $19, nC5, $0C, nA4
	dc.b $06, nBb4, $0C, nG4, nC5, nA4, $06, nBb4
	dc.b $0C, nG4, $24, nC3, $0B, nRst, $01, nC3
	dc.b $0B, nRst, $0D, nBb2, $05, nRst, $0D, nC3
	dc.b $05, nRst, $19, nC5, $0C, nA4, $06, nBb4
	dc.b $0C, nG4, nC5, nF3, $02, nRst, $04, nG3
	dc.b $02, nRst, $04, nA3, $02, nRst, $04, nC4
	dc.b $02, nRst, $04, nBb3, $02, nRst, $04, nG3
	dc.b $02, nRst, $04, nA3, $02, nRst, $04, nD5
	dc.b $03, nRst, nB4, nRst, nG4, nRst, nE4, nRst
	dc.b nD4, nRst, nB3, nRst, nG3, nRst, nE3, nRst
	dc.b nC5, nRst, nB4, nRst, nG4, nRst, nE4, nRst
	dc.b nC4, nRst, nB3, nRst, nG3, nRst, nE3, nRst
	dc.b nC5, nRst, nA4, nRst, nF4, nRst, nD4, nRst
	dc.b nC4, nRst, nA3, nRst, nF3, nRst, nD3, nRst
	dc.b nB4, nRst, nA4, nRst, nF4, nRst, nD4, nRst
	dc.b nB3, nRst, nA3, nRst, nF3, nRst, nD3, nRst
	dc.b $0F, nG3, $0B, nRst, $01, nD4, $0B, nRst
	dc.b $01, nG4, $0B, nRst, $01, nF4, $05, nRst
	dc.b $0D, nE4, $05, nRst, $0D, nC4, $05, nRst
	dc.b $07, nA3, $2F, nRst, $01, nD4, $05, nRst
	dc.b $0D, nC4, $05, nRst, $0D, nB3, $05, nRst
	dc.b $07, nD5, $03, nRst, nB4, nRst, nG4, nRst
	dc.b nE4, nRst, nD4, nRst, nB3, nRst, nG3, nRst
	dc.b nE3, nRst, nC5, nRst, nB4, nRst, nG4, nRst
	dc.b nE4, nRst, nC4, nRst, nB3, nRst, nG3, nRst
	dc.b nE3, nRst, nC5, nRst, nA4, nRst, nF4, nRst
	dc.b nD4, nRst, nC4, nRst, nA3, nRst, nF3, nRst
	dc.b nD3, nRst, nB4, nRst, nA4, nRst, nF4, nRst
	dc.b nD4, nRst, nB3, nRst, nA3, nRst, nF3, nRst
	dc.b nD3, nRst, nG4, $2F, nRst, $01, nE4, $23
	dc.b nRst, $01, nA3, $0B, nRst, $01, nF4, $11
	dc.b nRst, $01, nE4, $11, nRst, $01, nD4, $0B
	dc.b nRst, $01, nB3, $11, nRst, $01, nA3, $11
	dc.b nRst, $01, nG3, $0B, nRst, $01, nE4, $0B
	dc.b nRst, $07, nE4, $03, nRst, $0F, nA3, $02
	dc.b nRst, $04, nB3, $02, nRst, $04, nC4, $11
	dc.b nRst, $01, nB3, $11, nRst, $01, nA3, $0B
	dc.b nRst, $01, nE4, $0B, nRst, $07, nE4, $03
	dc.b nRst, $0F, nF3, $02, nRst, $04, nG3, $02
	dc.b nRst, $04, nA3, $11, nRst, $01, nG3, $11
	dc.b nRst, $01, nF3, $0B, nRst, $01, nF2, $05
	dc.b nRst, $01, nA2, $05, nRst, $01, nD3, $05
	dc.b nRst, $01, nF3, $05, nRst, $01, nD3, $05
	dc.b nRst, $01, nF3, $05, nRst, $01, nA3, $05
	dc.b nRst, $01, nD4, $05, nRst, $01, nA3, $05
	dc.b nRst, $01, nD4, $05, nRst, $01, nF4, $05
	dc.b nRst, $01, nA4, $05, nRst, $01, nF4, $05
	dc.b nRst, $01, nA4, $05, nRst, $01, nD5, $05
	dc.b nRst, $01, nF5, $05, nRst, $01, nC4, $17
	dc.b nRst, $01, nB3, $17, nRst, $01, nC4, $17
	dc.b nRst, $01, nD4, $17, nRst, $01
	sJump		AIZ1_Jump3
	; Unused
	dc.b $F2

AIZ1_PSG2:
AIZ1_Jump2:
	dc.b nE3, $05, nRst, $0D, nE3, $05, nRst, $19
	dc.b nE3, $05, nRst, $0D, nE3, $05, nRst, $19
	dc.b nD3, $05, nRst, $0D, nD3, $05, nRst, $07
	dc.b nBb2, $02, nRst, $04, nC3, $02, nRst, $04
	dc.b nD3, $02, nRst, $0A, nD3, $05, nRst, $07
	dc.b nD3, $05, nRst, $07, nD3, $05, nRst, $01
	dc.b nEb3, $05, nRst, $07, nE3, $05, nRst, $0D
	dc.b nE3, $05, nRst, $19, nE3, $05, nRst, $0D
	dc.b nE3, $05, nRst, $19, nC4, $03, nRst, nC4
	dc.b nRst, nC5, nRst, nC4, nRst, nBb4, nRst, nC4
	dc.b nRst, nBb4, nRst, nC5, nRst, nF4, $02, nRst
	dc.b $04, nBb4, $02, nRst, $04, nF5, $02, nRst
	dc.b $04, nE5, $1D, nRst, $01, nE3, $05, nRst
	dc.b $0D, nE3, $05, nRst, $19, nE3, $05, nRst
	dc.b $0D, nE3, $05, nRst, $19, nD3, $05, nRst
	dc.b $0D, nD3, $05, nRst, $07, nBb2, $02, nRst
	dc.b $04, nC3, $02, nRst, $04, nD3, $02, nRst
	dc.b $0A, nD3, $05, nRst, $07, nD3, $05, nRst
	dc.b $07, nD3, $05, nRst, $01, nEb3, $05, nRst
	dc.b $07, nE3, $05, nRst, $0D, nE3, $05, nRst
	dc.b $19, nE3, $05, nRst, $0D, nE3, $05, nRst
	dc.b $19, nA4, $05, nRst, $01, nA4, $05, nRst
	dc.b $01, nA4, $05, nRst, $01, nA4, $05, nRst
	dc.b $55, nBb2, $02, nRst, $0A, nC3, $02, nRst
	dc.b $16, nBb2, $11, nRst, $01, nC3, $02, nRst
	dc.b $28, nFs4, $05, nRst, $01, nG4, $05, nRst
	dc.b $07, nG4, $02, nRst, $04, nG4, $02, nRst
	dc.b $04, nG4, $02, nRst, $04, nG4, $02, nRst
	dc.b $0A, nF4, $23, nRst, $0D, nBb2, $02, nRst
	dc.b $0A, nC3, $02, nRst, $16, nBb2, $11, nRst
	dc.b $01, nC3, $02, nRst, $28, nFs4, $05, nRst
	dc.b $01, nG4, $05, nRst, $07, nG4, $02, nRst
	dc.b $04, nG4, $02, nRst, $04, nG4, $02, nRst
	dc.b $04, nG4, $02, nRst, $0A, nA4, $05, nRst
	dc.b $01, nG4, $1D, nRst, $0D, nBb2, $02, nRst
	dc.b $0A, nC3, $02, nRst, $16, nBb2, $11, nRst
	dc.b $01, nC3, $02, nRst, $28, nFs4, $05, nRst
	dc.b $01, nG4, $05, nRst, $07, nG4, $02, nRst
	dc.b $04, nG4, $02, nRst, $04, nG4, $02, nRst
	dc.b $04, nG4, $02, nRst, $0A, nF4, $23, nRst
	dc.b $0D, nBb2, $02, nRst, $0A, nC3, $02, nRst
	dc.b $16, nBb2, $11, nRst, $01, nC3, $02, nRst
	dc.b $28, nFs4, $05, nRst, $01, nG4, $05, nRst
	dc.b $07, nG4, $02, nRst, $04, nG4, $02, nRst
	dc.b $04, nG4, $02, nRst, $04, nG4, $02, nRst
	dc.b $0A, nA4, $05, nRst, $01, nG4, $1D, nRst
	dc.b $0D, nC3, $0B, nRst, $01, nC3, $0B, nRst
	dc.b $0D, nBb2, $05, nRst, $0D, nC3, $05, nRst
	dc.b $19, nC5, $0C, nA4, $06, nBb4, $0C, nG4
	dc.b nC5, nA4, $06, nBb4, $0C, nG4, $24, nC3
	dc.b $0B, nRst, $01, nC3, $0B, nRst, $0D, nBb2
	dc.b $05, nRst, $0D, nC3, $05, nRst, $19, nC5
	dc.b $0C, nA4, $06, nBb4, $0C, nG4, nC5, nA4
	dc.b $06, nBb4, $0C, nG4, $24, nC3, $0B, nRst
	dc.b $01, nC3, $0B, nRst, $0D, nBb2, $05, nRst
	dc.b $0D, nC3, $05, nRst, $19, nC5, $0C, nA4
	dc.b $06, nBb4, $0C, nG4, nC5, nA4, $06, nBb4
	dc.b $0C, nG4, $24, nC3, $0B, nRst, $01, nC3
	dc.b $0B, nRst, $0D, nBb2, $05, nRst, $0D, nC3
	dc.b $05, nRst, $19, nC5, $0C, nA4, $06, nBb4
	dc.b $0C, nG4, nC5, nF3, $02, nRst, $04, nG3
	dc.b $02, nRst, $04, nA3, $02, nRst, $04, nC4
	dc.b $02, nRst, $04, nBb3, $02, nRst, $04, nG3
	dc.b $02, nRst, $04, nA3, $02, nRst, $04, nD5
	dc.b $03, nRst, nB4, nRst, nG4, nRst, nE4, nRst
	dc.b nD4, nRst, nB3, nRst, nG3, nRst, nE3, nRst
	dc.b nC5, nRst, nB4, nRst, nG4, nRst, nE4, nRst
	dc.b nC4, nRst, nB3, nRst, nG3, nRst, nE3, nRst
	dc.b nC5, nRst, nA4, nRst, nF4, nRst, nD4, nRst
	dc.b nC4, nRst, nA3, nRst, nF3, nRst, nD3, nRst
	dc.b nB4, nRst, nA4, nRst, nF4, nRst, nD4, nRst
	dc.b nB3, nRst, nA3, nRst, nF3, nRst, nD3, nRst
	dc.b $15
	saVolFM		$0A, $AC
	dc.b $0B, nRst, $01, nD4, $0B, nRst, $01, nG4
	dc.b $0B, nRst, $01, nF4, $05, nRst, $0D, nE4
	dc.b $05, nRst, $0D, nC4, $05, nRst, $07, nA3
	dc.b $2F, nRst, $01, nD4, $05, nRst, $0D, nC4
	dc.b $05, nRst, $0D, nB3, $05, nRst, $01
	saVolFM		$F6, $BF
	dc.b $03, nRst, nB4, nRst, nG4, nRst, nE4, nRst
	dc.b nD4, nRst, nB3, nRst, nG3, nRst, nE3, nRst
	dc.b nC5, nRst, nB4, nRst, nG4, nRst, nE4, nRst
	dc.b nC4, nRst, nB3, nRst, nG3, nRst, nE3, nRst
	dc.b nC5, nRst, nA4, nRst, nF4, nRst, nD4, nRst
	dc.b nC4, nRst, nA3, nRst, nF3, nRst, nD3, nRst
	dc.b nB4, nRst, nA4, nRst, nF4, nRst, nD4, nRst
	dc.b nB3, nRst, nA3, nRst, nF3, nRst, nD3, nRst
	dc.b $09, nG4, $2F, nRst, $01, nE4, $23, nRst
	dc.b $01, nA3, $0B, nRst, $01, nF4, $11, nRst
	dc.b $01, nE4, $11, nRst, $01, nD4, $0B, nRst
	dc.b $01, nB3, $11, nRst, $01, nA3, $11, nRst
	dc.b $01, nG3, $06, nC4, $0B, nRst, $07, nC4
	dc.b $03, nRst, $0F, nA3, $02, nRst, $04, nB3
	dc.b $02, nRst, $04, nC4, $11, nRst, $01, nB3
	dc.b $11, nRst, $01, nA3, $0B, nRst, $01, nC4
	dc.b $0B, nRst, $07, nC4, $03, nRst, $0F, nF3
	dc.b $02, nRst, $04, nG3, $02, nRst, $04, nA3
	dc.b $11, nRst, $01, nG3, $11, nRst, $01, nF3
	dc.b $0B, nRst, $01, nF2, $05, nRst, $01, nA2
	dc.b $05, nRst, $01, nD3, $05, nRst, $01, nF3
	dc.b $05, nRst, $01, nD3, $05, nRst, $01, nF3
	dc.b $05, nRst, $01, nA3, $05, nRst, $01, nD4
	dc.b $05, nRst, $01, nA3, $05, nRst, $01, nD4
	dc.b $05, nRst, $01, nF4, $05, nRst, $01, nA4
	dc.b $05, nRst, $01, nF4, $05, nRst, $01, nA4
	dc.b $05, nRst, $01, nD5, $05, nRst, $01, nF5
	dc.b $05, nRst, $01, nC4, $17, nRst, $01, nB3
	dc.b $17, nRst, $01, nC4, $17, nRst, $01, nD4
	dc.b $17, nRst, $01
	sJump		AIZ1_Jump2
	; Unused
	dc.b $F2

AIZ1_PSG3:
AIZ1_Jump1:
	sVolEnvPSG	VolEnv_02
	sNoisePSG	$E7
	dc.b nBb6, $06, nBb6
	sVolEnvPSG	VolEnv_04
	dc.b nBb6, $0C
	sVolEnvPSG	VolEnv_01

AIZ1_Loop1:
	dc.b nBb6, $06, nBb6
	sVolEnvPSG	VolEnv_04
	dc.b nBb6, $0C
	sVolEnvPSG	VolEnv_01
	sLoop		$01, $1A, AIZ1_Loop1
	dc.b nBb6, $06, nBb6, nA6, $6C

AIZ1_Loop2:
	dc.b nBb6, $06, nBb6
	sVolEnvPSG	VolEnv_04
	dc.b nBb6, $0C
	sVolEnvPSG	VolEnv_01
	sLoop		$01, $1B, AIZ1_Loop2
	dc.b nBb6, $06, nBb6, nA6, $6C

AIZ1_Loop3:
	dc.b nBb6, $06, nBb6
	sVolEnvPSG	VolEnv_04
	dc.b nBb6, $0C
	sVolEnvPSG	VolEnv_01
	sLoop		$01, $4C, AIZ1_Loop3
	dc.b nRst, $60
	sJump		AIZ1_Jump1
