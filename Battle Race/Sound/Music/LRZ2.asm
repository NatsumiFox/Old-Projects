LRZ2_Header:
	sHeaderInit	; Z80 offset is $ACF3
	sHeaderPatchUniv	
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $33
	sHeaderDAC	LRZ2_DAC
	sHeaderFM	LRZ2_FM1, $0C, $15
	sHeaderFM	LRZ2_FM2, $00, $11
	sHeaderFM	LRZ2_FM3, $0C, $18
	sHeaderFM	LRZ2_FM4, $0C, $15
	sHeaderFM	LRZ2_FM5, $0C, $1A
	sHeaderPSG	LRZ2_PSG1, $F4, $04, $00, VolEnv_0C
	sHeaderPSG	LRZ2_PSG2, $F4, $03, $00, VolEnv_0C
	sHeaderPSG	LRZ2_PSG3, $00, $02, $00, VolEnv_0C
	; Unused
	dc.b $F2, $F2

LRZ2_DAC:
	dc.b nRst, $18, nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $06
	sPan		spCenter, $00
	dc.b dLowTom, $06
	sPan		spLeft, $00
	dc.b dFloorTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $18, nRst, $18, nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $06
	sPan		spCenter, $00
	dc.b dLowTom, $06
	sPan		spLeft, $00
	dc.b dFloorTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $18, nRst, $18, nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $06
	sPan		spCenter, $00
	dc.b dLowTom, $06
	sPan		spLeft, $00
	dc.b dFloorTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $18

LRZ2_Jump9:
	dc.b dKick, $18, nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $18, nRst, $0C, dKick, $0C, dKick, $18
	dc.b nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $18, nRst, $0C, dKick, $0C, dKick, $18
	dc.b nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $06
	sPan		spCenter, $00
	dc.b dLowTom, $06
	sPan		spLeft, $00
	dc.b dFloorTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $0C, dSnare, $0C, dKick, $18, nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $18, nRst, $0C, dKick, $0C, dKick, $12
	dc.b dKick, $06, nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $18, nRst, $18, dKick, $12, dKick, $06
	dc.b nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $18, nRst, $0C, dSnare, $0C, dKick, $12
	dc.b dKick, $06, nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $06
	sPan		spCenter, $00
	dc.b dLowTom, $06
	sPan		spLeft, $00
	dc.b dFloorTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $18, dKick, $12, dKick, $06, nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $18, nRst, $0C, dSnare, $0C, dKick, $12
	dc.b dKick, $06, nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $18, nRst, $18, dKick, $12, dKick, $06
	dc.b nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $18, nRst, $0C, dSnare, $0C, dKick, $12
	dc.b dKick, $06, nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $06
	sPan		spCenter, $00
	dc.b dLowTom, $06
	sPan		spLeft, $00
	dc.b dFloorTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $18, dKick, $12, dKick, $06, nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $18, nRst, $0C, dSnare, $0C, dKick, $12
	dc.b dKick, $06, dSnare, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $06, dKick, $12, nRst, $0C, dSnare, $0C
	dc.b dKick, $12, dKick, $06, nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $06
	sPan		spCenter, $00
	dc.b dLowTom, $0C
	sPan		spLeft, $00
	dc.b dFloorTom, $06
	sPan		spCenter, $00
	dc.b nRst, $0C, dSnare, $0C, dKick, $12, dKick, $06
	dc.b nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $06, dKick, $0C, dKick, $06, nRst, $0C
	dc.b dSnare, $0C, dKick, $12, dKick, $06, nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $06
	sPan		spCenter, $00
	dc.b dLowTom, $06
	sPan		spLeft, $00
	dc.b dFloorTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $0C, dSnare, $0C, dKick, $12, dKick, $06
	dc.b dSnare, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $06, dKick, $12, nRst, $0C, dSnare, $0C
	dc.b dKick, $12, dKick, $06, nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $06
	sPan		spCenter, $00
	dc.b dLowTom, $06
	sPan		spLeft, $00
	dc.b dFloorTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $0C, dSnare, $0C, dKick, $12, dKick, $06
	dc.b nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $06, dKick, $0C, dKick, $06, nRst, $0C
	dc.b dSnare, $0C, dKick, $12, dKick, $06, nRst, $0C
	sPan		spRight, $00
	dc.b dHighTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $06
	sPan		spCenter, $00
	dc.b dLowTom, $06
	sPan		spLeft, $00
	dc.b dFloorTom, $0C
	sPan		spCenter, $00
	dc.b nRst, $0C, dSnare, $06, nRst, $06
	sJump		LRZ2_Jump9
	; Unused
	dc.b $F2

LRZ2_FM1:
	sPan		spRight, $00
	sPatFM		$04
	saDetune	$05
	ssModZ80	$0A, $01, $06, $06

LRZ2_Jump6:
	dc.b nA4, $18, sHold, $18, sHold, $18, nF4, $18
	dc.b sHold, $18, sHold, $18, nG4, $18, sHold, $18
	dc.b sHold, $18, nE4, $18, sHold, $18, sHold, $18
LRZ2_Jump7:
	dc.b nA4, $18, sHold, $18, sHold, $18, sHold, $18
	dc.b sHold, $18, sHold, $18, sHold, $18, sHold, $18
	dc.b nRst, $18, nRst, $18, nRst, $18, nRst, $18
	dc.b nRst, $18, nRst, $18, nRst, $18, nA4, $18
	dc.b nG4, $18, sHold, $18, sHold, $0C, nC5, $0C
	dc.b sHold, $0C, nB4, $0C, nG4, $18, sHold, $18
	dc.b nRst, $18, nRst, $18, nG4, $18, sHold, $18
	dc.b sHold, $0C, nC5, $0C, sHold, $0C, nB4, $0C
	dc.b nG4, $18, sHold, $18, sHold, $18, nRst, $18
	dc.b nG4, $18, sHold, $18, sHold, $0C, nB4, $0C
	dc.b sHold, $0C, nC5, $0C, nD5, $18, sHold, $18
	dc.b sHold, $18, sHold, $18, nG4, $18, sHold, $18
	dc.b sHold, $0C, nC5, $0C, sHold, $0C, nB4, $0C
	dc.b nG4, $18, sHold, $18, nRst, $18, nRst, $18
	dc.b nRst, $18, nRst, $18, nRst, $18, nRst, $18
	dc.b nRst, $18, nRst, $18, nRst, $18, nRst, $18
	dc.b nE5, $18, sHold, $0C, nA4, $0C, sHold, $18
	dc.b nC5, $18, nB4, $18, sHold, $18, sHold, $18
	dc.b sHold, $0C, nG4, $0C, nA4, $18, sHold, $18
	dc.b sHold, $0C, nRst, $0C, nRst, $18, nRst, $18
	dc.b nRst, $18, nRst, $18, nRst, $18, nE5, $18
	dc.b sHold, $0C, nA4, $0C, sHold, $18, nC5, $18
	dc.b nB4, $18, sHold, $18, sHold, $18, sHold, $18
	sJump		LRZ2_Jump7
	; Unused
	dc.b $F2

LRZ2_FM2:
	sPatFM		$03
	saDetune	$00
	ssModZ80	$03, $01, $02, $05
	dc.b nF2, $48, nCs2, nEb2, nC2

LRZ2_Jump8:
	sPatFM		$0B
	saDetune	$00
	ssModZ80	$0F, $01, $06, $06
	saVolFM		$08
	dc.b nG2, $06, nA2, nC3, nA2, nD3, nA2, nE3
	dc.b nA2, nG3, nD3, nA3, nC4, nG3, nD3, nE3
	dc.b nG3, nG2, nA2, nC3, nA2, nD3, nA2, nE3
	dc.b nA2, nG3, nD3, nA3, nE3, nG3, nE3, nD3
	dc.b nE3, nG2, nA2, nC3, nA2, nD3, nA2, nE3
	dc.b nA2, nG3, nD3, nA3, nC4, nG3, nD3, nE3
	dc.b nG3, nG2, nA2, nC3, nA2, nD3, nA2, nE3
	dc.b nA2, nG3, nD3, nA3, nE3
	sPatFM		$03
	saDetune	$00
	ssModZ80	$03, $01, $02, $05
	saVolFM		$F8
	dc.b nE2, $18, nA2, $0A, nRst, $02, nA2, nRst
	dc.b $04, nA2, $48, nRst, $06, nA2, $0A, nRst
	dc.b $02, nA2, nRst, $04, nA3, $48, nRst, $06
	dc.b nA2, $0A, nRst, $02, nA2, nRst, $04, nA2
	dc.b $48, nRst, $06, nA2, $0A, nRst, $02, nA2
	dc.b nRst, $04, nA3, $48, nRst, $06, nF2, $0A
	dc.b nRst, $02, nF2, nRst, $04, nF2, $48, nRst
	dc.b $06, nF2, $0A, nRst, $02, nF2, nRst, $04
	dc.b nF3, $48, nRst, $06, nF2, $0A, nRst, $02
	dc.b nF2, nRst, $04, nF2, $48, nRst, $06, nF2
	dc.b $0A, nRst, $02, nF2, nRst, $04, nF3, $30
	sPatFM		$14
	saDetune	$00
	ssModZ80	$02, $01, $01, $02
	saVolFM		$FC
	dc.b nF3, $0C, nC3, nG2, $06, nA2, $0A, nRst
	dc.b $02, nA2, nRst, $04, nA2, $30, nG2, $0C
	dc.b nG2, $02, nRst, $04, nAb2, $0C, nA2, $0A
	dc.b nRst, $02, nA2, nRst, $04, nA3, $3A, nRst
	dc.b $02, nG3, nRst, $04, nE3, $0C, nA2, $0A
	dc.b nRst, $02, nA2, nRst, $04, nA2, $2E, nRst
	dc.b $02, nG2, $0C, nG2, $02, nRst, $04, nAb2
	dc.b $0C, nA2, $0A, nRst, $02, nA2, nRst, $04
	dc.b nA3, $3A, nRst, $02, nG3, nRst, $04, nE3
	dc.b $0C, nA2, $0A, nRst, $02, nA2, nRst, $04
	dc.b nA2, $2E, nRst, $02, nG2, $0C, nG2, $02
	dc.b nRst, $04, nAb2, $0C, nA2, $0A, nRst, $02
	dc.b nA2, nRst, $04, nA3, $2E, nRst, $02, nA3
	dc.b $0C, nE3, $0C, nG2, $06, nA2, $0A, nRst
	dc.b $02, nA2, nRst, $04, nA2, $2E, nRst, $02
	dc.b nG2, $0C, nG2, $02, nRst, $04, nAb2, $0C
	dc.b nA2, $0A, nRst, $02, nA2, nRst, $04, nA3
	dc.b $3A, nRst, $02, nG3, nRst, $04, nE3, $0C
	saVolFM		$04
	sJump		LRZ2_Jump8
	; Unused
	dc.b $F2

LRZ2_FM3:
	dc.b nRst, $07
	sPan		spLeft, $00
	sPatFM		$1F
	saDetune	$01
	ssModZ80	$0F, $01, $06, $06
	sJump		LRZ2_Jump6
	; Unused
	dc.b $F2

LRZ2_FM4:
	saDetune	$01
	sPatFM		$0B
	saDetune	$00
	ssModZ80	$0F, $01, $06, $06
	dc.b nF4, $06, nG4, $06, nF4, $06, nG4, $06
	dc.b nF4, $06, nG4, $06, nF4, $06, nG4, $06
	dc.b nF4, $06, nG4, $06, nF4, $06, nG4, $06
	dc.b nCs4, $06, nEb4, $06, nCs4, $06, nEb4, $06
	dc.b nCs4, $06, nEb4, $06, nCs4, $06, nEb4, $06
	dc.b nCs4, $06, nEb4, $06, nCs4, $06, nEb4, $06
	dc.b nEb4, $06, nF4, $06, nEb4, $06, nF4, $06
	dc.b nEb4, $06, nF4, $06, nEb4, $06, nF4, $06
	dc.b nEb4, $06, nF4, $06, nEb4, $06, nF4, $06
	dc.b nC4, $06, nD4, $06, nC4, $06, nD4, $06
	dc.b nC4, $06, nD4, $06, nC4, $06, nD4, $06
	dc.b nC4, $06, nD4, $06, nC4, $06, nD4, $06

LRZ2_Jump5:
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nC4, $06
	dc.b nG3, $06, nD3, $06, nE3, $06, nG3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nE3, $06
	dc.b nG3, $06, nE3, $06, nD3, $06, nE3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nC4, $06
	dc.b nG3, $06, nD3, $06, nE3, $06, nG3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nE3, $06
	dc.b nG3, $06, nE3, $06, nD3, $06, nE3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nC4, $06
	dc.b nG3, $06, nD3, $06, nE3, $06, nG3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nE3, $06
	dc.b nG3, $06, nE3, $06, nD3, $06, nE3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nC4, $06
	dc.b nG3, $06, nD3, $06, nE3, $06, nG3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nE3, $06
	dc.b nG3, $06, nE3, $06, nD3, $06, nE3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nC4, $06
	dc.b nG3, $06, nD3, $06, nE3, $06, nG3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nE3, $06
	dc.b nG3, $06, nE3, $06, nD3, $06, nE3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nC4, $06
	dc.b nG3, $06, nD3, $06, nE3, $06, nG3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nE3, $06
	dc.b nG3, $06, nE3, $06, nD3, $06, nE3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nC4, $06
	dc.b nG3, $06, nD3, $06, nE3, $06, nG3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nE3, $06
	dc.b nG3, $06, nE3, $06, nD3, $06, nE3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nC4, $06
	dc.b nG3, $06, nD3, $06, nE3, $06, nG3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nE3, $06
	dc.b nG3, $06, nE3, $06, nD3, $06, nE3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nC4, $06
	dc.b nG3, $06, nD3, $06, nE3, $06, nG3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nE3, $06
	dc.b nG3, $06, nE3, $06, nD3, $06, nE3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nC4, $06
	dc.b nG3, $06, nD3, $06, nE3, $06, nG3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nE3, $06
	dc.b nG3, $06, nE3, $06, nD3, $06, nE3, $06
	sJump		LRZ2_Jump5
	; Unused
	dc.b $F2

LRZ2_FM5:
	sPan		spRight, $00
	saDetune	$FF
	sPatFM		$08
	saDetune	$FF
	ssModZ80	$0F, $01, $06, $06
	dc.b nC3, $06, nF3, $06, nA3, $06, nC4, $06
	dc.b nF4, $06, nA4, $06, nC5, $06, nA4, $06
	dc.b nF4, $06, nC4, $06, nA3, $06, nF3, $06
	dc.b nAb2, $06, nCs3, $06, nF3, $06, nAb3, $06
	dc.b nCs4, $06, nF4, $06, nAb4, $06, nF4, $06
	dc.b nCs4, $06, nAb3, $06, nF3, $06, nCs3, $06
	dc.b nBb2, $06, nEb3, $06, nG3, $06, nBb3, $06
	dc.b nEb4, $06, nG4, $06, nBb4, $06, nG4, $06
	dc.b nEb4, $06, nBb3, $06, nG3, $06, nEb3, $06
	dc.b nG2, $06, nC3, $06, nE3, $06, nG3, $06
	dc.b nC4, $06, nE4, $06, nG4, $06, nE4, $06
	dc.b nC4, $06, nG3, $06, nE3, $06, nC3, $06

LRZ2_Jump4:
	sPatFM		$0B
	saDetune	$00
	ssModZ80	$0F, $01, $06, $06
	dc.b nA4, $06, nA5, $06, nRst, $06, nA4, $06
	dc.b nRst, $06, nA4, $06, nA5, $06, nA4, $06
	dc.b nRst, $06, nE5, $06, nA4, $06, nD5, $06
	dc.b nA4, $06, nG4, $06, nE5, $06, nG5, $06
	dc.b nA4, $06, nA5, $06, nRst, $06, nA4, $06
	dc.b nRst, $06, nA4, $06, nA5, $06, nA4, $06
	dc.b nRst, $06, nE5, $06, nA4, $06, nD5, $06
	dc.b nA4, $06, nG4, $06, nE5, $06, nG5, $06
	sPatFM		$08
	saDetune	$FF
	ssModZ80	$0F, $01, $06, $06
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b nF4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b nF4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b nF4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b nF4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b nF4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b nA4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b nA4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b nA4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b nA4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b nG4, $04, nRst, $08, nE4, $04, nRst, $08
	sJump		LRZ2_Jump4
	; Unused
	dc.b $F2

LRZ2_PSG1:
	sVolEnvPSG	VolEnv_0A
	dc.b nC3, $06, nF3, $06, nA3, $06, nC4, $06
	dc.b nF4, $06, nA4, $06, nC5, $06, nA4, $06
	dc.b nF4, $06, nC4, $06, nA3, $06, nF3, $06
	dc.b nAb2, $06, nCs3, $06, nF3, $06, nAb3, $06
	dc.b nCs4, $06, nF4, $06, nAb4, $06, nF4, $06
	dc.b nCs4, $06, nAb3, $06, nF3, $06, nCs3, $06
	dc.b nBb2, $06, nEb3, $06, nG3, $06, nBb3, $06
	dc.b nEb4, $06, nG4, $06, nBb4, $06, nG4, $06
	dc.b nEb4, $06, nBb3, $06, nG3, $06, nEb3, $06
	dc.b nG2, $06, nC3, $06, nE3, $06, nG3, $06
	dc.b nC4, $06, nE4, $06, nG4, $06, nE4, $06
	dc.b nC4, $06, nG3, $06, nE3, $06, nC3, $06

LRZ2_Jump3:
	dc.b nA4, $06, nA5, $06, nRst, $06, nA4, $06
	dc.b nRst, $06, nA4, $06, nA5, $06, nA4, $06
	dc.b nRst, $06, nE5, $06, nA4, $06, nD5, $06
	dc.b nA4, $06, nG4, $06, nE5, $06, nG5, $06
	dc.b nA4, $06, nA5, $06, nRst, $06, nA4, $06
	dc.b nRst, $06, nA4, $06, nA5, $06, nA4, $06
	dc.b nRst, $06, nE5, $06, nA4, $06, nD5, $06
	dc.b nA4, $06, nG4, $06, nE5, $06, nG5, $06
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b nF4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b nF4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b nF4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b nF4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b nF4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b nA4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b nA4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b nA4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b nG4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nG4, $04, nRst, $02
	dc.b nA4, $04, nRst, $08, nE4, $04, nRst, $08
	dc.b nA4, $04, nRst, $08, nC5, $04, nRst, $02
	dc.b nA4, $04, nRst, $02, nRst, $06, nB4, $04
	dc.b nRst, $08, nG4, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b nG4, $04, nRst, $08, nE4, $04, nRst, $08
	sJump		LRZ2_Jump3
	; Unused
	dc.b $F2

LRZ2_PSG2:
	sVolEnvPSG	VolEnv_08
	dc.b nF4, $06, nG4, $06, nF4, $06, nG4, $06
	dc.b nF4, $06, nG4, $06, nF4, $06, nG4, $06
	dc.b nF4, $06, nG4, $06, nF4, $06, nG4, $06
	dc.b nCs4, $06, nEb4, $06, nCs4, $06, nEb4, $06
	dc.b nCs4, $06, nEb4, $06, nCs4, $06, nEb4, $06
	dc.b nCs4, $06, nEb4, $06, nCs4, $06, nEb4, $06
	dc.b nEb4, $06, nF4, $06, nEb4, $06, nF4, $06
	dc.b nEb4, $06, nF4, $06, nEb4, $06, nF4, $06
	dc.b nEb4, $06, nF4, $06, nEb4, $06, nF4, $06
	dc.b nC4, $06, nD4, $06, nC4, $06, nD4, $06
	dc.b nC4, $06, nD4, $06, nC4, $06, nD4, $06
	dc.b nC4, $06, nD4, $06, nC4, $06, nD4, $06

LRZ2_Jump2:
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nC4, $06
	dc.b nG3, $06, nD3, $06, nE3, $06, nG3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nE3, $06
	dc.b nG3, $06, nE3, $06, nD3, $06, nE3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nC4, $06
	dc.b nG3, $06, nD3, $06, nE3, $06, nG3, $06
	dc.b nG2, $06, nA2, $06, nC3, $06, nA2, $06
	dc.b nD3, $06, nA2, $06, nE3, $06, nA2, $06
	dc.b nG3, $06, nD3, $06, nA3, $06, nE3, $06
	dc.b nG3, $06, nE3, $06, nD3, $06, nE3, $06
	dc.b nA3, $06, nRst, $06, nA3, $06, nA4, $06
	dc.b nRst, $18, nA3, $06, nA3, $06, nRst, $06
	dc.b nA3, $06, nRst, $18, nA3, $06, nRst, $06
	dc.b nA3, $06, nA4, $06, nRst, $18, nA3, $06
	dc.b nA3, $06, nRst, $06, nA3, $06, nRst, $18
	dc.b nA3, $06, nRst, $06, nA3, $06, nA4, $06
	dc.b nRst, $18, nA3, $06, nA3, $06, nRst, $06
	dc.b nA3, $06, nRst, $18, nA3, $06, nRst, $06
	dc.b nA3, $06, nA4, $06, nRst, $18, nA3, $06
	dc.b nA3, $06, nRst, $06, nA3, $06, nRst, $18
	dc.b nA3, $06, nRst, $06, nA3, $06, nA4, $06
	dc.b nRst, $18, nA3, $06, nA3, $06, nRst, $06
	dc.b nA3, $06, nRst, $18, nA3, $06, nRst, $06
	dc.b nA3, $06, nA4, $06, nRst, $18, nA3, $06
	dc.b nA3, $06, nRst, $06, nA3, $06, nRst, $18
	dc.b nA3, $06, nRst, $06, nA3, $06, nA4, $06
	dc.b nRst, $18, nA3, $06, nA3, $06, nRst, $06
	dc.b nA3, $06, nRst, $18, nA3, $06, nRst, $06
	dc.b nA3, $06, nA4, $06, nRst, $18, nA3, $06
	dc.b nA3, $06, nRst, $06, nA3, $06, nRst, $18
	dc.b nRst, $06, nA4, $04, nRst, $02, nA5, $04
	dc.b nRst, $02, nA5, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $02, nA5, $04, nRst, $02
	dc.b nA5, $04, nRst, $02, nRst, $18, nRst, $18
	dc.b nRst, $06, nA4, $04, nRst, $02, nA5, $04
	dc.b nRst, $02, nA5, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $02, nA5, $04, nRst, $02
	dc.b nA5, $04, nRst, $02, nRst, $18, nRst, $18
	dc.b nRst, $06, nA4, $04, nRst, $02, nA5, $04
	dc.b nRst, $02, nA5, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $02, nA5, $04, nRst, $02
	dc.b nA5, $04, nRst, $02, nRst, $18, nRst, $18
	dc.b nRst, $06, nA4, $04, nRst, $02, nA5, $04
	dc.b nRst, $02, nA5, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $02, nA5, $04, nRst, $02
	dc.b nA5, $04, nRst, $02, nRst, $18, nRst, $18
	dc.b nRst, $06, nA4, $04, nRst, $02, nA5, $04
	dc.b nRst, $02, nA5, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $02, nA5, $04, nRst, $02
	dc.b nA5, $04, nRst, $02, nRst, $18, nRst, $18
	dc.b nRst, $06, nA4, $04, nRst, $02, nA5, $04
	dc.b nRst, $02, nA5, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $02, nA5, $04, nRst, $02
	dc.b nA5, $04, nRst, $02, nRst, $18, nRst, $18
	dc.b nRst, $06, nA4, $04, nRst, $02, nA5, $04
	dc.b nRst, $02, nA5, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $02, nA5, $04, nRst, $02
	dc.b nA5, $04, nRst, $02, nRst, $18, nRst, $18
	dc.b nRst, $06, nA4, $04, nRst, $02, nA5, $04
	dc.b nRst, $02, nA5, $04, nRst, $02, nRst, $06
	dc.b nA4, $04, nRst, $02, nA5, $04, nRst, $02
	dc.b nA5, $04, nRst, $02, nRst, $18, nRst, $18
	sJump		LRZ2_Jump2
	; Unused
	dc.b $F2

LRZ2_PSG3:
	sVolEnvPSG	VolEnv_02
	sNoisePSG	$E7
	dc.b nRst, $54
	sVolEnvPSG	VolEnv_08
	dc.b nBb6, $60, nBb6, $60, nBb6, $0C

LRZ2_Jump1:
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $04, nBb6, $04, nBb6, $04
	sVolEnvPSG	VolEnv_08
	dc.b nBb6, $54
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $0C, nBb6, $0C, nBb6, $48, nBb6, $04
	dc.b nBb6, $04, nBb6, $04
	sVolEnvPSG	VolEnv_08
	dc.b nBb6, $48, nBb6, $60, $60, nBb6, $0C
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $0C, nBb6, $0C, nBb6, $3C
	sVolEnvPSG	VolEnv_08
	dc.b nBb6, $60, nBb6, $60, nBb6, $60, nBb6, $0C
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $0C, nBb6, $0C, nBb6, $3C
	sVolEnvPSG	VolEnv_08
	dc.b nBb6, $60, nBb6, $60, nBb6, $0C
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $04, nBb6, $04, nBb6, $04
	sVolEnvPSG	VolEnv_08
	dc.b nBb6, $0C, nBb6, $3C, nBb6, $0C
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $0C, nBb6, $0C, nBb6, $3C
	sVolEnvPSG	VolEnv_08
	dc.b nBb6, $60, nBb6, $18
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $06, nBb6, $42
	sVolEnvPSG	VolEnv_08
	dc.b nBb6, $24, nBb6, $3C, nBb6, $0C
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $0C, nBb6, $0C, nBb6, $3C
	sVolEnvPSG	VolEnv_08
	dc.b nBb6, $60, nBb6, $18
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $06, nBb6, $42
	sVolEnvPSG	VolEnv_08
	dc.b nBb6, $0C
	sJump		LRZ2_Jump1
	; Unused
	dc.b $F2
