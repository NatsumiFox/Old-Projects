Credits_Header:
	sHeaderInit	; Z80 offset is $C104
	sHeaderPatch	Credits_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $0F
	sHeaderDAC	Credits_DAC
	sHeaderFM	Credits_FM1, $00, $00
	sHeaderFM	Credits_FM2, $00, $00
	sHeaderFM	Credits_FM3, $00, $00
	sHeaderFM	Credits_FM4, $00, $00
	sHeaderFM	Credits_FM5, $00, $00
	sHeaderPSG	Credits_PSG1, $00, $00, $00, VolEnv_1B
	sHeaderPSG	Credits_PSG2, $00, $00, $00, VolEnv_1B
	sHeaderPSG	Credits_PSG3, $00, $00, $00, VolEnv_1B

Credits_FM1:
	ssTransposeS3K	$4C
	ssVol		$0B
	dc.b nRst, $30
	sPatFM		$20
	dc.b nD2, $10, $07, nRst, $06, nRst, $05, nD2
	dc.b $07, nRst, $06, nRst, $05, nD3, $06, nD2
	dc.b nRst, $07, nD3, $06, nRst, nC2, $0C, sHold
	dc.b $0C, $0C, nRst, $06, nC3, nRst, $0C, $18
	dc.b $18, nD2, $11, $07, nRst, $06, nRst, $05
	dc.b nD2, $07, nRst, $06, nRst, $05, nD3, $06
	dc.b nD2, nRst, $07, nD3, $06, nRst, nC2, $0C
	dc.b sHold, $06, nRst, nC3, nRst, nC2, nC3, nC2
	dc.b nRst, nC2, nRst, nG1, nRst, nB1, nRst, nBb1
	dc.b $0C, sHold, $0D, nBb1, $0C, nBb2, nBb1, nBb1
	dc.b nBb2, nBb1, nAb1, sHold, nAb1, nAb1, nAb2, nAb1
	dc.b nAb1, nAb2, nAb1, nC2, sHold, nC2, nC2, nC3
	dc.b nC2, nC3, nC2, nC3, nC2, sHold, $30, nRst
	dc.b $30
	ssTransposeS3K	$40
	ssVol		$0E
	sPatFM		$00
	ssModZ80	$0D, $01, $02, $06
	sPan		spCenter, $00
	dc.b nRst, $60, nRst, nRst
	sPatFM		$00
	dc.b nB5, $04, nBb5, nG5, nA5, nFs5, nAb5, nF5
	dc.b nG5, nE5, nFs5, nEb5, nF5, nD5, nE5, nCs5
	dc.b nEb5, nC5, nD5, nB4, nCs5, nBb4, nC5, nA4
	dc.b nB4

Credits_Loop43:
	sPatFM		$02
	dc.b nB4, $01, nC5, $3B, nD5, $06, nRst, nF5
	dc.b nRst, nG5, nRst, nE5, $01, nF5, $06, nRst
	dc.b $05, nCs5, $06, nRst, nC5, nBb4, nRst, nG4
	dc.b $36, nRst, $0C, nBb4, $18, nC5, $06, nBb4
	dc.b $05, nC5, $01, nCs5, $06, nRst, nC5, nRst
	dc.b nEb5, nD5, nRst, nBb4, nRst, $60
	sLoop		$00, $02, Credits_Loop43
	dc.b nRst, $0C, nBb4, $18, nC5, $06, nBb4, nCs5
	dc.b nRst, nC5, nRst, nBb4, nC5, nRst, nBb4, nRst
	dc.b $60, nRst, $0C, nBb4, $18, nC5, $06, nBb4
	dc.b $05, nCs5, $01, nD5, nEb5, $06, nRst, $05
	dc.b nD5, $06, nRst, nC5, nD5, nRst, nBb4, nRst
	dc.b $60
	sPatFM		$07
	ssTransposeS3K	$4C
	ssVol		$0A
	dc.b nF1, $04, nRst, $02, nF1, $04, nRst, $02
	dc.b nF1, $04, nRst, $02, nF1, $06, nF1, $02
	dc.b nRst, $46, nG1, $04, nRst, $02, nG1, $04
	dc.b nRst, $02, nG1, $04, nRst, $02, nG1, $04
	dc.b nRst, $02, nG1, $04, nRst, $14, nC2, $10
	dc.b nRst, $08, nG1, $0E, nRst, $0A, nA1, $04
	dc.b nRst, $08, nG1, $02, nRst, $04, nA1, $08
	dc.b nRst, $0A, nC2, $04, nRst, $08, nB1, $02
	dc.b nRst, $04, nC2, $08, nRst, $0A, nD2, $04
	dc.b nRst, $08, nC2, $02, nRst, $04, nD2, $08
	dc.b nRst, $0A, nE2, $04, nRst, $08, nD2, $02
	dc.b nRst, $04, nE2, $08, nRst, $0A, nG2, $16
	dc.b nRst, $02, nG1, $16, nRst, $02, nA1, $02
	dc.b nRst, $0A, nA1, $04, nRst, $02, nA1, $08
	dc.b nRst, $0A, nC2, $04, nRst, $08, nC2, $06
	dc.b nC2, $04, nRst, $0E, nD2, $04, nRst, $02
	dc.b nC2, $06, nA1, $02, nRst, $0A, nG1, $06
	dc.b nRst, $0C, nG1, $06, nRst, $0C, nA1, $24
	dc.b nRst, $18, nA1, $04, nRst, $08, nA1, $04
	dc.b nRst, $02, nA1, $06, nRst, $0C, nC2, $06
	dc.b nRst, $06, nC2, $04, nRst, $02, nC2, $04
	dc.b nRst, $0E, nD2, $02, nRst, $04, nC2, $06
	dc.b nA1, $04, nRst, $08, nG1, $06, nRst, $0C
	dc.b nG1, $06, nRst, $0C, nA1, $36, nRst, $06
	dc.b nRst, $30
	sPan		spCenter, $00
	ssTransposeS3K	$40
	ssVol		$08
	ssModZ80	$0D, $01, $02, $06
	sCall		Credits_Call3
	sCall		Credits_Call3
	sCall		Credits_Call4
	dc.b nRst, $10
	sCall		Credits_Call4
	dc.b nRst, $10
	ssTransposeS3K	$40
	ssVol		$0C
	sPatFM		$18
	sCall		Credits_Call5
	dc.b nRst, $18
	sPatFM		$03
	ssVol		$10
	sPatFM		$1A
	sCall		Credits_Call6
	dc.b nRst, $10, nRst, $60
	sPan		spCenter, $00
	ssTransposeS3K	$28
	ssVol		$0E
	sPatFM		$0F
	saDetune	$FE
	dc.b nG2, $07, nRst, $04, nG2, $08, nRst, $04
	dc.b $24, nG3, nG2, nG2, $0C, nRst, nC3, $14
	dc.b nB2, $10, nG2, $08, nRst, $04, nG2, $08
	dc.b nRst, $04, $24, nG3, nG2, nG2, $0C, nRst
	dc.b $30

Credits_Loop44:
	dc.b nC3, $60, nC4, $24, nC3, nC4, $18, nBb2
	dc.b $06, nRst, $06, nBb2, $54, nBb3, $24, nBb2
	dc.b nBb3, $18, nA2, $06, nRst, $06, nA2, $48
	dc.b nG3, $06, nAb3, nA3, $24, nA2, nA3, $18
	dc.b nAb2, $06, nRst, $06, nAb2, $54, nAb3, $24
	dc.b nAb2, nBb3, $18
	sLoop		$00, $02, Credits_Loop44
	dc.b nC3, $60, sHold, $60, sHold, $61
	ssVol		$13
	ssTransposeS3K	$41
	sPatFM		$1E
	sPan		spCenter, $00
	saDetune	$FE
	ssModZ80	$14, $01, $06, $06
	dc.b nA4, $06, nCs5, nB4, nD5
	saVolFM		$FF
	dc.b nCs5, nE5, nD5, nFs5
	saVolFM		$FF
	dc.b nE5, nAb5, nFs5, nA5
	saVolFM		$FF
	dc.b nAb5, nB5, nA5, nCs6
	sPatFM		$1C
	dc.b nA4, $18, nFs4, $0C, nE4, nA4, nFs4, nD4
	dc.b nE4, sHold, nE4, $24, nD5, $18
	sNoteTimeOut	$06
	dc.b $0C, $0C, $0C
	sNoteTimeOut	$00
	dc.b nCs5, $18, nA4, $0C, nE4, nFs4, $04, nRst
	dc.b $08, nA4, $18, nB4, $0C, sHold, nB4, $30
	dc.b nRst, nA4, $18, nFs4, $0C, nE4, nA4, nFs4
	dc.b nD4, nE4, sHold, nE4, $24, nD5, $18
	sNoteTimeOut	$06
	dc.b $0C, $0C, $0C
	sNoteTimeOut	$00
	saVolFM		$FD
	dc.b nD5, nCs5, $18, nA4, nB4, nRst, $0C, nE5
	dc.b nD5, $18, nA4, nB4
	saVolFM		$FE
	dc.b nCs5, $0C
	sStop

Credits_Call4:
	sPatFM		$0B
	dc.b nE4, $48, nE4, $06, nA4, nRst, nE4, $42
	dc.b nD4, $06, nRst, nC4, nRst, nB3, nRst, nC4
	dc.b $12, nA3, $06, nRst, $48, nRst, $50
	sRet

Credits_Call6:
Credits_Loop19:
	dc.b nAb3, $06, nBb3, nC4, nEb4
	sLoop		$00, $04, Credits_Loop19

Credits_Loop20:
	dc.b nBb3, $06, nC4, nD4, nF4
	sLoop		$00, $04, Credits_Loop20
	dc.b nRst, $60, nRst, $06, nBb4, $12, nA4, $06
	dc.b nRst, nG4, nRst, nBb4, nRst, nG4, nA4, nRst
	dc.b nBb4, $12

Credits_Loop21:
	dc.b nAb3, $06, nBb3, nC4, nEb4
	sLoop		$00, $04, Credits_Loop21

Credits_Loop22:
	dc.b nBb3, $06, nC4, nD4, nF4
	sLoop		$00, $04, Credits_Loop22
	dc.b nRst, $60, nRst, $06, nBb4, $12, nA4, $06
	dc.b nRst, nG4, nRst, nBb4, nG4, nRst, nC5, nRst
	dc.b $08
	sRet

Credits_Call5:
	dc.b nRst, $0C, nD4, nD4, nC4, nC4, nB3, nB3
	dc.b nA3, nAb3, $18, nA3, $08, nRst, $04, nB3
	dc.b $08, nRst, $34, nRst, $0C, nAb4, $08, nRst
	dc.b $04, nA4, $08, nRst, $04, nB4, $08, nRst
	dc.b $04, nC5, $08, nRst, $04, nB4, $08, nRst
	dc.b $04, nA4, $08, nRst, $04, nB4, $08, nRst
	dc.b $04, nD5, $08, nRst, $04, nC5, $08, nRst
	dc.b $04, nB4, $08, nRst, $04, nA4, $08, nRst
	dc.b $04, nAb4, $08, nRst, $04, nF4, $08, nRst
	dc.b $04, nE4, $08, nRst, $04, nD4, $08, nRst
	dc.b $04, nE5, $08, nRst, $10, nD5, $08, nRst
	dc.b $40, nC5, $08, nRst, $10, nB4, $08, nRst
	dc.b $40, nE5, $08, nRst, $10, nD5, $08, nRst
	dc.b $40, nAb5, $08, nRst, $10, nF5, $08, nRst
	dc.b $10, nB5, $08, nRst, $04, nD6, $08, nRst
	dc.b $04
	sRet

Credits_Call3:
	sPatFM		$13
	dc.b nRst, $0C, nB4, $04, nRst, $08, nC5, $04
	dc.b nRst, $08, nB4, $24, nE5, $04, nRst, $14
	dc.b nEb5, $02, nE5, $16, nC5, $04, nRst, $08
	dc.b nA4, $18, nE4, $60, nRst, $24
	sPatFM		$14
	dc.b nRst, $36, nD5, $06, nE5, nG5, nB4, nC5
	dc.b nA4, $0C
	sRet
	; Unused
	dc.b $B4, $0C, $B3, $02, $B1, $AF, $AD, $AC
	dc.b $AA, $B1, $0A, $80, $02, $B4, $04, $80
	dc.b $02, $B5, $B6, $80, $08, $B3, $10, $80
	dc.b $02, $B1, $04, $80, $08, $AF, $04, $80
	dc.b $08, $AB, $02, $AC, $14, $80, $02, $AB
	dc.b $AC, $08, $80, $02, $AA, $04, $80, $02
	dc.b $AB, $AC, $28, $B1, $04, $80, $02, $B3
	dc.b $04, $80, $02, $B4, $0C, $B3, $02, $B1
	dc.b $AF, $AD, $AC, $AA, $B1, $0A, $80, $02
	dc.b $B4, $04, $80, $02, $B5, $B6, $80, $08
	dc.b $B3, $10, $80, $02, $B1, $04, $80, $08
	dc.b $B0, $04, $80, $08, $B1, $10, $80, $02
	dc.b $B1, $04, $80, $02, $B3, $0A, $80, $02
	dc.b $B1, $04, $80, $02, $B3, $04, $80, $08
	dc.b $B4, $10, $80, $02, $B6, $0A, $80, $02
	dc.b $B1, $04, $80, $02, $B3, $04, $80, $02
	dc.b $B4, $0C, $B3, $02, $B1, $AF, $AD, $AC
	dc.b $AA, $B1, $0A, $80, $02, $B4, $04, $80
	dc.b $02, $B5, $B6, $80, $08, $B3, $10, $80
	dc.b $02, $B1, $04, $80, $08, $AF, $04, $80
	dc.b $08, $AB, $02, $AC, $14, $80, $02, $AB
	dc.b $AC, $08, $80, $02, $AA, $04, $80, $02
	dc.b $AB, $AC, $28, $B1, $04, $80, $02, $B3
	dc.b $04, $80, $02, $B4, $10, $80, $02, $B4
	dc.b $04, $80, $08, $B3, $04, $80, $02, $B4
	dc.b $10, $80, $02, $B4, $04, $80, $02, $B6
	dc.b $0A, $80, $02, $B4, $04, $80, $08, $B9
	dc.b $04, $80, $0E, $BD, $04, $80, $08, $BD
	dc.b $04, $80, $08, $BD, $04, $80, $02, $BD
	dc.b $0A, $80, $02, $BC, $04, $F9

Credits_FM2:
	sPatFM		$1F
	ssVol		$18
	dc.b nRst, $30
	sCall		Credits_Call7
	dc.b nRst, $3C
	ssTransposeS3K	$40
	ssVol		$10
	sPatFM		$01
	ssModZ80	$0D, $01, $02, $06
	sPan		spCenter, $00

Credits_Loop38:
	dc.b nG2, $06, nA2, nD3, nF3, nRst, nE3, nRst
	dc.b nD3, nRst, nC3, nRst, nC3, nD3, nD3, $01
	dc.b nRst, $05, nE3, $0C, nC3, $06, nBb2, nRst
	dc.b nBb2, nBb2, $02, nRst, $04, nBb2, $02, nRst
	dc.b $04, nC3, $06, nBb2, nRst, nBb2, nRst, nBb2
	dc.b $02, nRst, $04, nC3, $0C, nBb2
	sLoop		$00, $06, Credits_Loop38
	dc.b nFs2, $06, nFs3, nFs2, nRst, nFs2, nRst, nFs2
	dc.b nRst, nAb2, nRst, nAb2, nRst, nAb2, nRst, nAb2
	dc.b nAb2, nRst, nBb2, $12, nBb2, $06, nRst, $12
	dc.b nBb2, $06, nAb2, nA2, nBb2, nRst, $18, nFs2
	dc.b $06, nFs3, nFs2, nRst, nFs2, nRst, nFs2, nRst
	dc.b nAb2, nRst, nAb2, nRst, nAb2, nRst, nAb2, nAb2
	dc.b nRst, nBb2, $12, nBb2, $06, nRst, $12, nBb2
	dc.b $06, nAb2, nA2, nBb2, nRst, $0C
	sPatFM		$08
	sPan		spLeft, $00
	ssTransposeS3K	$4C
	ssVol		$02
	dc.b nE4, $06, nF4, $06, nG4, $24, nC4, $36
	dc.b nRst, $06, nG4, $18, nA4, $04, nRst, $08
	dc.b nG4, $38, nRst, $10, nA4, $0C, nG4, $06
	dc.b nRst, $06, nA4, $04, nRst, $08, nC5, $10
	dc.b nRst, $02, nB4, $04, nRst, $0C, nA4, $06
	dc.b nRst, $08, nB4, $10, nRst, $02, nC5, $04
	dc.b nRst, $0E, nD5, $04, nRst, $08, nC5, $16
	dc.b nRst, $02, nB4, $16, nRst, $02, nE5, $0C
	dc.b nA4, $06, nE5, $04, nRst, $0E, nA4, $22
	dc.b nRst, $02, nC5, $14, nRst, $04, nB4, $06
	dc.b nRst, $06, nB4, $04, nRst, $02, nD5, $06
	dc.b nRst, $06, nB4, $04, nRst, $02, nC5, $32
	dc.b nRst, $0A, nE5, $0C, nA4, $04, nRst, $02
	dc.b nE5, $06, nRst, $0C, nA4, $22, nRst, $02
	dc.b nC5, $14, nRst, $04, nB4, $06, nRst, $06
	dc.b nB4, $04, nRst, $02, nD5, $06, nRst, $06
	dc.b nB4, $04, nRst, $02, nC5, $26, nRst, $16
	dc.b nRst, $30
	sPan		spCenter, $00
	ssTransposeS3K	$40
	ssVol		$0A
	ssModZ80	$0D, $01, $02, $06

Credits_Loop39:
	sPatFM		$15
	dc.b nA1, $06, nA1, nA2, $0C, nA1, $06, nA1
	dc.b nA1, $03, nRst, nA1, nRst, nAb1, $0C, nAb2
	dc.b $04, nRst, $08, nAb1, $0C, nAb1, $06, nAb1
	dc.b nG1, nG1, nG2, $0C, nG1, $06, nG1, nG1
	dc.b $03, nRst, nG1, nRst, nAb1, $0C, nAb2, $04
	dc.b nRst, $08, nAb1, $0C, nAb1, $06, nAb1, nA1
	dc.b $0C, nA1, nA1, nG2, $06, nA2, nA1, $0C
	dc.b nA1, nA1, nG2, $06, nA2, nG2, nA2, $03
	dc.b nRst, nA1, $0C, nA1, nG2, $06, nA2, $03
	dc.b nRst, nA1, $0C, nA1, nG2, $06, nA2, $03
	dc.b nRst, nA1, $0C
	sLoop		$00, $04, Credits_Loop39
	ssTransposeS3K	$40
	ssVol		$0B

Credits_Loop40:
	dc.b nE1, $0C, nRst, $24, nE1, $0C, nE1, $0A
	dc.b nRst, $1A
	sLoop		$00, $08, Credits_Loop40
	ssVol		$0D
	sPatFM		$1B

Credits_Loop41:
	dc.b nAb1, $0C, nAb1, nAb1, $03, nRst, nAb2, nRst
	dc.b nAb1, nRst, nAb2, nRst, nAb1, $0C, nAb1, nAb1
	dc.b $03, nRst, nAb2, nRst, nAb1, nRst, nAb2, nRst
	dc.b nBb1, $0C, nBb1, nBb1, $03, nRst, nBb2, nRst
	dc.b nBb1, nRst, nBb2, nRst, nBb1, $0C, nBb1, nBb1
	dc.b $03, nRst, nBb2, nRst, nBb1, nRst, nBb2, nRst
	dc.b nC2, $06, nC2, $03, nRst, nBb2, $06, nC3
	dc.b $03, nRst, nF2, $06, nG2, $03, nRst, nC2
	dc.b nRst, nBb1, nRst, nC2, $06, nBb1, nC2, $03
	dc.b nRst, nC2, $06, nRst, nC2, nRst, nC2, nC2
	dc.b $0C, nC2, nRst, $48
	sLoop		$00, $02, Credits_Loop41
	dc.b nRst, $60
	sPan		spCenter, $00
	ssTransposeS3K	$40
	ssVol		$18
	dc.b nRst, $60, nRst, nRst, nRst

Credits_Loop42:
	sPatFM		$10
	dc.b nC4, $60, sHold, $60, nBb3, sHold, $60, nA3
	dc.b sHold, $60, nAb3, sHold, $60
	sLoop		$00, $02, Credits_Loop42
	dc.b nC4, $60, sHold, $60, sHold, $60
	ssVol		$05
	ssTransposeS3K	$4D
	sPan		spCenter, $00
	sPatFM		$1D
	dc.b nE1, $06, nE1, nRst, nE1, nRst, nE1, nE1
	dc.b sHold, nE1, nRst, nRst, nE1, sHold, nE1, nE1
	dc.b nE1, nE1, nE1, nA1, $06, nA1, nRst, nA1
	dc.b nRst, nA1, nA1, sHold, nA1, nFs1, $0C, nFs1
	dc.b sHold, nFs1, nE1, nE1, $06, nE1, nRst, nE1
	dc.b nRst, nE1, nD1, sHold, nD1, nRst, nD1, nRst
	dc.b nD2, sHold, nD2, nD1, nD1, nD1, nA1, nA1
	dc.b nRst, nA1, nRst, nA1, nA1, sHold, nA1, nFs1
	dc.b $0C, nFs1, sHold, nFs1, nG1, nG1, $06, nG1
	dc.b nRst, nG1, nRst, nG1, nE1, sHold, nE1, nRst
	dc.b nE1, nRst, nE2, sHold, nE2, nE1, nE1, nE1
	dc.b nA1, $06, nA1, nRst, nA1, nRst, nA1, nA1
	dc.b sHold, nA1, nFs1, $0C, nFs1, sHold, nFs1, nE1
	dc.b nE1, $06, nE1, nRst, nE1, nRst, nE1, nD1
	dc.b sHold, nD1, nRst, nD1, nRst, nD2, sHold, nD2
	dc.b nD1, nD1, nD1, nA1, nA1, nRst, nA1, nRst
	dc.b nA1, nA1, sHold, nA1, nFs1, $0C, nFs1, sHold
	dc.b nFs1, nG1, nG1, $06, nG1, nRst, nG1, nRst
	dc.b nG1, nE1, sHold, nE1, nRst, nE1, nRst, nE2
	dc.b sHold, nE2, nE1
	saVolFM		$FD
	dc.b nA1, $60
	sStop

Credits_Call7:
	ssModZ80	$0C, $02, $01, $0E
	dc.b nA4, $30, sHold, $0C, nB4, nRst, nG4, sHold
	dc.b $30, sHold, $0C
	ssModZ80	$14, $01, $FE, $01
	dc.b nE4, $30
	ssModZ80	$0C, $02, $01, $0E
	dc.b nRst, $0C, nA4, $18, nA4, $0C, nB4, nRst
	dc.b nG4, nRst, nE4, nE4, nRst, nE4, nEb4, nRst
	dc.b nD4, nRst
	ssModZ80	$01, $01, $05, $00
	dc.b nC5, $0C, sHold
	ssModZ80	$00, $00, $00, $00
	dc.b nC5, $18
	ssModZ80	$0C, $02, $01, $0E
	dc.b nBb4, $0C, nA4, nRst, nAb4, sHold, nAb4, $18
	dc.b nEb4, nEb4, $0C, nF4, nAb4, nG4, sHold, nG4
	dc.b $54
	ssModZ80	$01, $01, $0A, $00
	dc.b nBb4, $0C, sHold
	ssModZ80	$00, $00, $00, $00
	dc.b nBb4, $24
	ssModZ80	$0C, $02, $01, $0E
	sRet
	; Unused
	dc.b $9E, $0C, $A3, $0C, $AA, $0C, $A9, $05
	dc.b $80, $0D, $A5, $05, $80, $0D, $A3, $3B
	dc.b $80, $3D, $9E, $0C, $A3, $0C, $AA, $0C
	dc.b $A9, $05, $80, $0D, $A5, $05, $80, $0D
	dc.b $A7, $3B, $80, $3D, $F7, $00, $02, $23
	dc.b $C9, $F9, $99, $06, $80, $99, $0C, $97
	dc.b $12, $96, $06, $80, $2A, $96, $06, $92
	dc.b $80, $92, $0C, $93, $12, $94, $06, $80
	dc.b $18, $9B, $0C, $A0, $06, $9B, $F9, $99
	dc.b $80, $99, $0C, $97, $12, $96, $06, $80
	dc.b $2A, $96, $06, $92, $80, $92, $0C, $93
	dc.b $12, $94, $06, $80, $18, $9B, $F9

Credits_FM3:
	ssModZ80	$0C, $01, $01, $0F
	sPatFM		$1F
	saDetune	$FE
	ssVol		$24
	dc.b nRst, $30, nRst, $09
	sCall		Credits_Call7
	dc.b nRst, $33
	sPan		spLeft, $00
	ssTransposeS3K	$40
	ssVol		$0B
	sPatFM		$03
	ssModZ80	$0D, $01, $02, $06
	sPan		spLeft, $00

Credits_Loop34:
	dc.b nRst, $0C, nG4, $06, nG4, nG4, nG4, nRst
	dc.b $0C, nG4, $06, nG4, nG4, nG4, nRst, $0C
	dc.b nG4, $06, nG4, nRst, $60
	sLoop		$00, $02, Credits_Loop34

Credits_Loop35:
	dc.b nRst, $0C, nE4, $06, nE4, nE4, nE4, nRst
	dc.b $0C, nE4, $06, nE4, nE4, nE4, nRst, $0C
	dc.b nE4, $06, nE4, nRst, $60, nRst, $0C, nFs4
	dc.b $06, nFs4, nFs4, nFs4, nRst, $0C, nF4, $06
	dc.b nF4, nF4, nF4, nRst, $0C, nF4, $06, nF4
	dc.b nRst, $60
	sLoop		$00, $02, Credits_Loop35
	sPatFM		$04
	dc.b nRst, $06, nFs5, $12, nFs5, $06, nRst, nFs5
	dc.b nRst, nAb5, nG5, nAb5, nC6, nRst, $18
	sPatFM		$05
	dc.b nRst, $06, nF4, $12, nF4, $06, nRst, $12
	dc.b nF4, $06, nEb4, nE4, nF4, nRst
	sPatFM		$06
	dc.b nBb4, $0C, nC5, $06
	sPatFM		$04
	dc.b nRst, nFs5, $12, nFs5, $06, nRst, nFs5, nRst
	dc.b nAb5, nG5, nAb5, nC6, nRst, $18
	sPatFM		$05
	dc.b nRst, $06, nF4, $12, nF4, $06, nRst, $12
	dc.b nF4, $06, nEb4, nE4, nF4, nRst, nRst
	sPatFM		$08
	sPan		spRight, $00
	ssTransposeS3K	$4C
	ssVol		$04
	dc.b nRst, $02, nE4, $06, nF4, $06, nG4, $24
	dc.b nC4, $36, nRst, $06, nG4, $18, nA4, $04
	dc.b nRst, $08, nG4, $38, nRst, $10, nA4, $0C
	dc.b nG4, $06, nRst, $06, nA4, $04, nRst, $08
	dc.b nC5, $10, nRst, $02, nB4, $04, nRst, $0C
	dc.b nA4, $06, nRst, $08, nB4, $10, nRst, $02
	dc.b nC5, $04, nRst, $0E, nD5, $04, nRst, $08
	dc.b nC5, $16, nRst, $02, nB4, $16, nRst, $02
	dc.b nE5, $0C, nA4, $06, nE5, $04, nRst, $0E
	dc.b nA4, $22, nRst, $02, nC5, $14, nRst, $04
	dc.b nB4, $06, nRst, $06, nB4, $04, nRst, $02
	dc.b nD5, $06, nRst, $06, nB4, $04, nRst, $02
	dc.b nC5, $32, nRst, $0A, nE5, $0C, nA4, $04
	dc.b nRst, $02, nE5, $06, nRst, $0C, nA4, $22
	dc.b nRst, $02, nC5, $14, nRst, $04, nB4, $06
	dc.b nRst, $06, nB4, $04, nRst, $02, nD5, $06
	dc.b nRst, $06, nB4, $04, nRst, $02, nC5, $26
	dc.b nRst, $14, $30
	sPan		spLeft, $00
	ssTransposeS3K	$40
	ssVol		$0C
	ssModZ80	$0D, $01, $02, $06

Credits_Loop36:
	sPatFM		$16
	dc.b nA4, $10, nRst, $08, nG4, $10, nRst, $08
	dc.b nE4, $0F, nRst, $03, nC4, $0F, nRst, $03
	dc.b nA3, $06, nRst, nRst, nC4, $12, nD4, $06
	dc.b nRst, nE4, nRst, nD4, $12, nC4, $06, nRst
	dc.b $18
	sPatFM		$17
	dc.b nE4, $30, nF4, nFs4, nF4
	sLoop		$00, $04, Credits_Loop36
	sPan		spLeft, $00
	ssTransposeS3K	$40
	ssVol		$0D
	sPatFM		$19
	dc.b nRst, $0C, nD6, $08, nRst, $04, nAb6, $0A
	dc.b nRst, $0E, nAb6, $0C, nF6, $0A, nRst, $0E
	dc.b nD6, $08, nRst, $04, nRst, $0C, nB5, $08
	dc.b nRst, $10, nAb5, $08, nRst, $28, nB5, $06
	dc.b nC6, nB5, $08, nRst, $1C, nAb5, $08, nRst
	dc.b $1C, nF5, $08, nRst, $10, nRst, $0C, nE5
	dc.b $08, nRst, $1C, nE5, $08, nRst, $28, nRst
	dc.b $0C, nE5, nF5, nAb5, $08, nRst, $04, nAb5
	dc.b nA5, nAb5, $10, nF5, $0C, nE5, $08, nRst
	dc.b $04, nRst, $0C, nE5, nD5, nC5, nB4, $04
	dc.b nC5, nB4, $10, nAb4, $0C, nE4, nRst, nE5
	dc.b nF5, nAb5, $08, nRst, $04, nAb5, nA5, nAb5
	dc.b $10, nF5, $0C, nE5, $08, nRst, $04, nA5
	dc.b nB5, nA5, $10, nAb5, $0C, nA5, nB5, nD6
	dc.b nRst, $18, nRst, $60, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, $60
	sPan		spCenter, $00
	ssTransposeS3K	$40
	ssVol		$18
	sPatFM		$12
	dc.b nRst, $60, nRst, nF5, $12, nE5, nC5, $0C
	dc.b nC6, $12, nB5, nG5, $0C, nF5, $12, nE5
	saVolFM		$FF
	dc.b nC5, $0C, nRst
	saVolFM		$01
	dc.b nB4, nRst, $18
	sPatFM		$11

Credits_Loop37:
	dc.b nC3, $06, nC2, nC3, nC2, nD3, nC2, nE3
	dc.b nC2, nF3, nC2, nE3, nC2, nD3, nC2, nE3
	dc.b nC2
	sLoop		$00, $12, Credits_Loop37
	dc.b nC3, $06, nC2, nC3, nC2, nD3, nC2, nE3
	dc.b nC2, nF3, nC2, nE3, nC2, nD3, nC2, nE3
	dc.b nC2, nRst, $01
	ssVol		$1D
	ssTransposeS3K	$41
	sPan		spCenter, $00
	sPatFM		$1E
	saDetune	$02
	ssModZ80	$15, $01, $06, $06
	dc.b nRst, $03, nB4, $06, nE5, nCs5, nFs5
	saVolFM		$FF
	dc.b nD5, nAb5, nE5, nA5
	saVolFM		$FF
	dc.b nFs5, nB5, nAb5, nCs6
	saVolFM		$FF
	dc.b nA5, nD6, nB5, nE6, $03
	sPatFM		$1C
	dc.b nRst, $07, nA4, $18, nFs4, $0C, nE4, nA4
	dc.b nFs4, nD4, nE4, sHold, nE4, $24, nD5, $18
	sNoteTimeOut	$06
	dc.b $0C, $0C, $0C
	sNoteTimeOut	$00
	dc.b nCs5, $18, nA4, $0C, nE4, nFs4, $04, nRst
	dc.b $08, nA4, $18, nB4, $0C, sHold, nB4, $30
	dc.b nRst, nA4, $18, nFs4, $0C, nE4, nA4, nFs4
	dc.b nD4, nE4, sHold, nE4, $24, nD5, $18
	sNoteTimeOut	$06
	dc.b $0C, $0C, $0C
	sNoteTimeOut	$00
	saVolFM		$FD
	dc.b nD5, nCs5, $18, nA4, nB4, nRst, $0C, nE5
	dc.b nD5, $18, nA4, nB4, $05, nRst, $05
	saVolFM		$FE
	dc.b nA4, $0C
	sStop

Credits_FM4:
	sPan		spRight, $00
	saDetune	$FD
	dc.b nRst, $30
	sCall		Credits_Call2
	dc.b nRst, $30
	sPan		spRight, $00
	ssTransposeS3K	$40
	ssVol		$0B
	sPatFM		$03
	ssModZ80	$0D, $01, $02, $06
	sPan		spRight, $00

Credits_Loop25:
	dc.b nRst, $0C, nE4, $06, nE4, nE4, nE4, nRst
	dc.b $0C, nE4, $06, nE4, nE4, nE4, nRst, $0C
	dc.b nE4, $06, nE4, nRst, $60
	sLoop		$00, $02, Credits_Loop25

Credits_Loop26:
	dc.b nRst, $0C, nC4, $06, nC4, nC4, nC4, nRst
	dc.b $0C, nC4, $06, nC4, nC4, nC4, nRst, $0C
	dc.b nC4, $06, nC4, nRst, $60, nRst, $0C, nCs4
	dc.b $06, nCs4, nCs4, nCs4, nRst, $0C, nD4, $06
	dc.b nD4, nD4, nD4, nRst, $0C, nD4, $06, nD4
	dc.b nRst, $60
	sLoop		$00, $02, Credits_Loop26
	sPatFM		$04
	dc.b nRst, $06, nFs4, $12, nFs4, $06, nRst, nFs4
	dc.b nRst, nAb4, nG4, nAb4, nC5, nRst, $18
	sPatFM		$05
	dc.b nRst, $06, nD4, $12, nD4, $06, nRst, $12
	dc.b nD4, $06, nC4, nCs4, nD4, nRst
	sPatFM		$06
	dc.b nFs4, $0C, nAb4, $06
	sPatFM		$04
	dc.b nRst, nFs4, $12, nFs4, $06, nRst, nFs4, nRst
	dc.b nAb4, nG4, nAb4, nC5, nRst, $18
	sPatFM		$05
	dc.b nRst, $06, nD4, $12, nD4, $06, nRst, $12
	dc.b nD4, $06, nC4, nCs4, nD4, nRst, nRst, nRst
	dc.b nRst
	ssTransposeS3K	$4C
	ssVol		$14
	sPan		spCenter, $00
	sPatFM		$09
	dc.b nF3, $04, nRst, $02, nF3, $04, nRst, $02
	dc.b nF3, $04, nRst, $02, nF3, $04, nRst, $1A
	dc.b nA3, $02, nB3, $02, nC4, $0E, nC4, $12
	dc.b nE4, $06, nRst, $06, nG3, $04, nRst, $02
	dc.b nG3, $04, nRst, $02, nG3, $04, nRst, $02
	dc.b nG3, $04, nRst, $1C, nG3, $14, nRst, $02
	dc.b nD4, $10, nRst, $14, nA3, $0C, nG3, $06
	dc.b nRst, $06, nA3, $04, nRst, $08, nC4, $10
	dc.b nRst, $02, nB3, $04, nRst, $0C, nA3, $06
	dc.b nRst, $08, nB3, $10, nRst, $02, nC4, $04
	dc.b nRst, $0E, nD4, $04, nRst, $08, nE4, $16
	dc.b nRst, $02, nB3, $16, nRst, $02
	sPatFM		$0A
	dc.b nE3, $0C, nA2, $04, nRst, $02, nE3, $04
	dc.b nRst, $0E, nA2, $24, nC3, $16, nRst, $02
	dc.b nB2, $06, nRst, $06, nB2, $04, nRst, $02
	dc.b nD3, $06, nRst, $0C, nC3, $36, nRst, $06
	dc.b nE3, $0C, nA2, $04, nRst, $02, nE3, $04
	dc.b nRst, $0E, nA2, $24, nC3, $16, nRst, $02
	dc.b nB2, $06, nRst, $06, nB2, $04, nRst, $02
	dc.b nD3, $06, nRst, $06, nB2, $04, nRst, $02
	dc.b nC3, $3C, sHold, $24, nRst, $0C
	sPan		spRight, $00
	ssTransposeS3K	$40
	ssVol		$0C
	ssModZ80	$0D, $01, $02, $06

Credits_Loop27:
	sPatFM		$16
	dc.b nE4, $10, nRst, $08, nE4, $10, nRst, $08
	dc.b nC4, $0F, nRst, $03, nA3, $0F, nRst, $03
	dc.b nE3, $06, nRst, nRst, nA3, $12, nB3, $06
	dc.b nRst, nC4, nRst, nB3, $12, nA3, $06, nRst
	dc.b $18
	sPatFM		$17
	dc.b nC4, $30, nC4, nC4, nC4
	sLoop		$00, $04, Credits_Loop27
	sPan		spRight, $00
	ssTransposeS3K	$40
	ssVol		$0D
	dc.b nRst, $60, nRst, nRst, nRst
	sPatFM		$18
	dc.b nC5, $08, nRst, $10, nB4, $08, nRst, $40
	dc.b nA4, $08, nRst, $10, nAb4, $08, nRst, $40
	dc.b nC5, $08, nRst, $10, nB4, $08, nRst, $40
	dc.b nF5, $08, nRst, $10, nD5, $08, nRst, $10
	dc.b nAb5, $08, nRst, $04, nB5, $08, nRst, $10
	dc.b nB5, $08, nRst, $04
	ssVol		$10
	sPatFM		$1A

Credits_Loop28:
	dc.b nAb2, $06, nBb2, nC3, nEb3
	sLoop		$00, $04, Credits_Loop28

Credits_Loop29:
	dc.b nBb2, $06, nC3, nD3, nF3
	sLoop		$00, $04, Credits_Loop29
	dc.b nRst, $60, nRst, $06, nG4, $12, nF4, $06
	dc.b nRst, nE4, nRst, nG4, nRst, nE4, nF4, $05
	dc.b nRst, $07, nG4, $12

Credits_Loop30:
	dc.b nAb2, $06, nBb2, nC3, nEb3
	sLoop		$00, $04, Credits_Loop30

Credits_Loop31:
	dc.b nBb2, $06, nC3, nD3, nF3
	sLoop		$00, $04, Credits_Loop31
	dc.b nRst, $60, nRst, $06, nG4, $12, nF4, $06
	dc.b nRst, nE4, nRst, nG4, nE4, nRst, nA4, nRst
	dc.b nG4, nRst, nRst, nRst, $60
	saDetune	$00
	sPan		spCenter, $00
	ssTransposeS3K	$40
	ssVol		$16
	ssModZ80	$24, $01, $04, $08
	sPatFM		$12

Credits_Loop32:
	dc.b nC5, $12, nB4, nG4, $0C, nG5, $12, nF5
	dc.b nE5, $0C
	sLoop		$00, $03, Credits_Loop32
	dc.b nC5, $12, nB4
	saVolFM		$FF
	dc.b nG4, $0C, nRst
	saVolFM		$01
	dc.b nG4, nRst, $18
	saVolFM		$FD

Credits_Loop33:
	dc.b nC6, $07, nRst, $05, nC6, $48, nC5, $06
	dc.b nE5, nF5, $24, nE5, $18, nC5, $24
	sLoop		$00, $02, Credits_Loop33
	dc.b nRst, $0C, nRst, nA4, nRst, nRst, nC5, nRst
	dc.b nRst, nF4, nRst, nRst, nA4, $24, nA4, $18
	dc.b nRst, $24, nAb4, $0C, nC5, nBb4, nAb4, nEb5
	dc.b $18, nC5, $0C, nD5, nEb5, $18, nD5, $0C
	dc.b nC5, $18
	sLoop		$01, $02, Credits_Loop33
	dc.b nC6, $60, sHold, $60, sHold, $60
	ssVol		$13
	ssTransposeS3K	$4D
	sPatFM		$22
	sPan		spRight, $00
	ssModZ80	$01, $01, $0C, $00
	dc.b nG2, $60
	sPatFM		$23
	ssModZ80	$00, $00, $00, $00
	dc.b nA3, nB3, $24, nA3, $30, sHold, $0C, nA3
	dc.b $60, nG3, $0C, $18, nB3, $30, sHold, $0C
	dc.b nA3, $60, nB3, $24, nA3, $30, sHold, $0C
	sPatFM		$24
	dc.b nA4, $24, nA4, $30, nRst, $0C
	saVolFM		$FF
	dc.b nB4, $24, nB4, $30
	saVolFM		$FF
	dc.b nCs5, $0C
	sStop

Credits_Call2:
	sPatFM		$1F
	ssModZ80	$0C, $02, $01, $10
	ssTransposeS3K	$40
	ssVol		$18
	dc.b nD4, $30, sHold, $0C, nD4, nRst, nC4, sHold
	dc.b $30, sHold, $0C
	ssModZ80	$1C, $01, $FE, $01
	dc.b nG3, $30
	ssModZ80	$0C, $02, $01, $10
	dc.b nRst, $0C, nD4, $18, nD4, $0C, nD4, nRst
	dc.b nC4, nRst, nG4, nC4, nRst, nC4, nB3, nRst
	dc.b nBb3, nRst, nF4, $24, nD4, $0C, nCs4, nRst
	dc.b nC4, sHold, $30, nC4, $0C, nEb4, nF4, nE4
	dc.b sHold, nE4, $54, nG4, $3C
	sRet
	; Unused
	dc.b $80, $0C, $A7, $02, $80, $0A, $A9, $02
	dc.b $80, $16, $A7, $11, $80, $01, $A9, $02
	dc.b $80, $28, $BA, $05, $80, $01, $BB, $05
	dc.b $80, $07, $BB, $02, $80, $04, $BB, $02
	dc.b $80, $04, $BB, $02, $80, $04, $BB, $02
	dc.b $80, $0A, $BA, $23, $80, $01, $80, $0C
	dc.b $A7, $02, $80, $0A, $A9, $02, $80, $16
	dc.b $A7, $11, $80, $01, $A9, $02, $80, $28
	dc.b $BA, $05, $80, $01, $BB, $05, $80, $07
	dc.b $BB, $02, $80, $04, $BB, $02, $80, $04
	dc.b $BB, $02, $80, $04, $BB, $02, $80, $0A
	dc.b $BD, $05, $80, $01, $BB, $1D, $80, $01
	dc.b $F7, $00, $02, $6D, $CF, $F9, $F2

Credits_FM5:
	saDetune	$03
	sPan		spLeft, $00
	dc.b nRst, $30
	sCall		Credits_Call2
	dc.b nRst, $30, nRst, $0E
	ssTransposeS3K	$40
	ssVol		$14
	sPatFM		$00
	ssModZ80	$0D, $01, $02, $06
	sPan		spCenter, $00
	dc.b nRst, $60, nRst, nRst
	sPatFM		$00
	dc.b nB5, $04, nBb5, nG5, nA5, nFs5, nAb5, nF5
	dc.b nG5, nE5, nFs5, nEb5, nF5, nD5, nE5, nCs5
	dc.b nEb5, nC5, nD5, nB4, nCs5, nBb4, nC5, nA4
	dc.b nB4
	sPatFM		$02
	dc.b nB4, $01, nC5, $3B, nD5, $06, nRst, nF5
	dc.b nRst, nG5, nRst, nE5, $01, nF5, $06, nRst
	dc.b $05, nCs5, $06, nRst, nC5, nBb4, nRst, nG4
	dc.b $36, nRst, $0C, nBb4, $18, nC5, $06, nBb4
	dc.b $05, nC5, $01, nCs5, $06, nRst, nC5, nRst
	dc.b nEb5, nD5, nRst, nBb4, nRst, $60, nB4, $01
	dc.b nC5, $3B, nD5, $06, nRst, nF5, nRst, nG5
	dc.b nRst, nE5, $01, nF5, $06, nRst, $05, nCs5
	dc.b $06, nRst, nC5, nBb4, nRst, nG4, $36, nRst
	dc.b $0C, nBb4, $18, nC5, $06, nBb4, $05, nC5
	dc.b $01, nCs5, $06, nRst, nC5, nRst, nEb5, nD5
	dc.b nRst, nBb4, nRst, $60, nRst, $0C, nBb4, $18
	dc.b nC5, $06, nBb4, nCs5, nRst, nC5, nRst, nBb4
	dc.b nC5, nRst, nBb4, nRst, $60, nRst, $0C, nBb4
	dc.b $18, nC5, $06, nBb4, $05, nCs5, $01, nD5
	dc.b nEb5, $06, nRst, $05, nD5, $06, nRst, nC5
	dc.b nD5, nRst, nBb4, nRst, $52
	ssTransposeS3K	$4C
	ssVol		$14
	sPatFM		$09
	dc.b nC4, $04, nRst, $02, nC4, $04, nRst, $02
	dc.b nC4, $04, nRst, $02, nC4, $04, nRst, $1A
	dc.b nF4, $02, nG4, $02, nA4, $0E, nA4, $12
	dc.b nC5, $06, nB4, $02, nA4, $02, nG4, $02
	dc.b nD4, $04, nRst, $02, nD4, $04, nRst, $02
	dc.b nD4, $04, nRst, $02, nD4, $04, nRst, $1A
	dc.b nEb4, $02, nE4, $14, nRst, $02, nB4, $10
	dc.b nB4, $02, nA4, $02, nG4, $02, nF4, $02
	dc.b nRst, $0C, nC4, $0C, nC4, $06, nRst, $06
	dc.b nC4, $04, nRst, $08, nE4, $10, nRst, $02
	dc.b nE4, $04, nRst, $0C, nE4, $06, nRst, $08
	dc.b nF4, $10, nRst, $02, nF4, $04, nRst, $0E
	dc.b nF4, $04, nRst, $08, nG4, $16, nRst, $02
	dc.b nD4, $16, nRst, $02
	sPatFM		$0A
	dc.b nC4, $0C, nF3, $04, nRst, $02, nC4, $04
	dc.b nRst, $0E, nF3, $24, nA3, $16, nRst, $02
	dc.b nG3, $06, nRst, $06, nG3, $04, nRst, $02
	dc.b nB3, $06, nRst, $0C, nA3, $36, nRst, $06
	dc.b nC4, $0C, nF3, $04, nRst, $02, nC4, $04
	dc.b nRst, $0E, nF3, $24, nA3, $16, nRst, $02
	dc.b nG3, $06, nRst, $06, nG3, $04, nRst, $02
	dc.b nB3, $06, nRst, $06, nG3, $04, nRst, $02
	dc.b nA3, $3C, sHold, $24, nRst, $0C
	sPan		spCenter, $00
	ssTransposeS3K	$40
	ssVol		$11
	ssModZ80	$0D, $01, $02, $06
	dc.b nRst, $10
	sCall		Credits_Call3
	sCall		Credits_Call3
	sCall		Credits_Call4
	dc.b nRst, $10
	sCall		Credits_Call4
	ssTransposeS3K	$40
	ssVol		$15
	dc.b nRst, $10
	sPatFM		$18
	sCall		Credits_Call5
	dc.b nRst, $08
	ssVol		$17
	sPatFM		$1A
	dc.b nRst, $10
	sCall		Credits_Call6
	dc.b nRst, $60
	sPan		spCenter, $00
	ssTransposeS3K	$40
	ssVol		$20
	ssModZ80	$24, $01, $04, $08
	saDetune	$02
	sPatFM		$12
	dc.b nRst, $0E

Credits_Loop23:
	dc.b nC5, $12, nB4, nG4, $0C, nG5, $12, nF5
	dc.b nE5, $0C
	sLoop		$00, $03, Credits_Loop23
	dc.b nC5, $12, nB4
	saVolFM		$FF
	dc.b nG4, $0C, nRst
	saVolFM		$01
	dc.b nG4, nRst, $18
	saVolFM		$FD

Credits_Loop24:
	dc.b nC6, $07, nRst, $05, nC6, $48, nC5, $06
	dc.b nE5, nF5, $24, nE5, $18, nC5, $24
	sLoop		$00, $02, Credits_Loop24
	dc.b nRst, $0C, nRst, nA4, nRst, nRst, nC5, nRst
	dc.b nRst, nF4, nRst, nRst, nA4, $24, nA4, $18
	dc.b nRst, $24, nAb4, $0C, nC5, nBb4, nAb4, nEb5
	dc.b $18, nC5, $0C, nD5, nEb5, $18, nD5, $0C
	dc.b nC5, $18
	sLoop		$01, $02, Credits_Loop24
	dc.b nC6, $60, sHold, nC6, $52, sHold, $60
	ssVol		$13
	ssTransposeS3K	$4D
	sPatFM		$22
	sPan		spLeft, $00
	ssModZ80	$01, $01, $0C, $00
	dc.b nG2, $60
	sPatFM		$23
	ssModZ80	$00, $00, $00, $00
	dc.b nE3, nE3, $24, nD3, $30, sHold, $0C, nE3
	dc.b $60, nD3, $0C, $18, nE3, $30, sHold, $0C
	dc.b nE3, $60, nE3, $24, nD3, $30, sHold, $0C
	sPatFM		$24
	dc.b nE4, $24, nD4, $30, nRst, $0C
	saVolFM		$FF
	dc.b nG4, $24, nE4, $30
	saVolFM		$FF
	dc.b nE4, $0C
	sStop

Credits_PSG1:
	ssTransposeS3K	$40
	ssVol		$31
	dc.b nRst, $30
	sVolEnvPSG	VolEnv_0A

Credits_Loop11:
	dc.b nA5, $0C, nD5
	sLoop		$00, $04, Credits_Loop11

Credits_Loop12:
	dc.b nB5, nE5
	sLoop		$00, $04, Credits_Loop12
	sLoop		$01, $02, Credits_Loop11

Credits_Loop13:
	dc.b nBb5, nF5
	sLoop		$00, $04, Credits_Loop13

Credits_Loop14:
	dc.b nAb5, nC5
	sLoop		$00, $04, Credits_Loop14

Credits_Loop15:
	dc.b nC6, nE5
	sLoop		$00, $04, Credits_Loop15
	dc.b nC6, nE5, nC6, nE5, nRst, $30, nRst, $60
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst
	ssTransposeS3K	$34
	ssVol		$21
	dc.b nRst, $01
	sVolEnvPSG	VolEnv_04
	saDetune	$FF
	sCall		Credits_Call1
	dc.b nA3, nA3, nA3, nA3, $12, nC4, $06, nC4
	dc.b nC4, nC4, $12, nD4, $06, nD4, nC4, $0C
	dc.b nB3, nB3, $06, nB3, $0C, nB3, $06, nC4
	dc.b $18, nC4, $06, nC4, nC4, nC4, nB3, $0C
	dc.b nA3, $06, nA3, nA3, nA3, nA3, $0C, nC4
	dc.b $06, nC4, nC4, nC4, $12, nD4, $06, nC4
	dc.b nB3, $0C, nG3, $12, nG3, nA3, $3B, sHold
	dc.b $24, nRst, $0C, nRst, $60, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, $60
	ssTransposeS3K	$34
	ssVol		$29
	sVolEnvPSG	VolEnv_04

Credits_Loop16:
	dc.b nG4, $06, nF4, nC4, nF4
	sLoop		$00, $0E, Credits_Loop16
	dc.b nRst, $0C, nB3, nRst, $18

Credits_Loop17:
	dc.b nC5, $06, nC4, nC5, nC4, nC5, nC4, nC5
	dc.b nC4, nC6, nC4, nC6, nC4, nC5, nC4, nC5
	dc.b nC4
	sLoop		$00, $12, Credits_Loop17
	ssVol		$69
	ssTransposeS3K	$41
	sVolEnvPSG	VolEnv_0C
	dc.b nA1, $06, nCs2, nB1, nD2
	saVolPSG	$FF
	dc.b nCs2, nE2, nD2, nFs2
	saVolPSG	$FF
	dc.b nE2, nAb2, nFs2, nA2
	saVolPSG	$FF
	dc.b nAb2, nB2, nA2, nCs3
	saVolPSG	$FF
	dc.b nA2, $06, nCs3, nB2, nD3
	saVolPSG	$FF
	dc.b nCs3, nE3, nD3, nFs3
	saVolPSG	$FF
	dc.b nE3, nAb3, nFs3, nA3
	saVolPSG	$FF
	dc.b nAb3, nB3, nA3, nCs4
	saVolPSG	$FD
	sVolEnvPSG	VolEnv_0A
	dc.b nE4, $0C, nB3, nE4, nB3, nE4, nB3, nE4
	dc.b nB3, nD4, nB3, nE4, nB3, nE4, nB3, nE4
	dc.b nB3, nE4, $0C, nB3, nE4, nB3, nE4, nB3
	dc.b nE4, nB3, nD4, nB3, nD4, nB3, nD5, nB4
	dc.b nD5, nB4, nE4, $0C, nB3, nE4, nB3, nE4
	dc.b nB3, nE4, nB3, nD4, nB3, nD4, nB3, nD4
	dc.b nB3, nD4, nB3, nE4, $0C, nB3, nE4, nB3
	dc.b nD4, nB3, nD4, nB3, nD4, nA3, nD4, nA3
	dc.b nE4, nB3, nE4
	saVolPSG	$01

Credits_Loop18:
	dc.b nA4
	saVolPSG	$01
	dc.b nG5
	saVolPSG	$01
	sLoop		$00, $05, Credits_Loop18
	sStop

Credits_Call1:
	dc.b nF3, $0C, nF3, nF3, nC3, $06, nF3, $0C
	dc.b nF3, nC3, $06, nF3, $0C, nC3, nG3, nG3
	dc.b nG3, nD3, $06, nG3, $0C, nG3, nD3, $06
	dc.b nG3, $0C, nD3, nD3, $06, nF3, nA3, nG3
	dc.b nF3, nE3, nG3, nB3, nD4, nC4, nB3, nA3
	dc.b nA3, nC4, nE4, nD4, nC4, nB3, nB3, nD4
	dc.b nF4, nE4, nD4, nC4, nG4, nF4, nE4, nD4
	dc.b nE4, nD4, nC4, nG3
	sRet
	; Unused
	dc.b $F2

Credits_PSG2:
	ssTransposeS3K	$40
	ssVol		$31
	sVolEnvPSG	VolEnv_0A
	dc.b nRst, $30, nRst, $06

Credits_Loop5:
	dc.b nFs5, $0C, nFs5
	sLoop		$00, $04, Credits_Loop5

Credits_Loop6:
	dc.b nG5, nC5
	sLoop		$00, $04, Credits_Loop6
	sLoop		$01, $02, Credits_Loop5

Credits_Loop7:
	dc.b nA5, nD5
	sLoop		$00, $04, Credits_Loop7

Credits_Loop8:
	dc.b nEb5, nEb5
	sLoop		$00, $04, Credits_Loop8

Credits_Loop9:
	dc.b nG5, nG5
	sLoop		$00, $04, Credits_Loop9
	dc.b nG5, nG5, nG5, nC5, nRst, $2A, nRst, $60
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst
	ssTransposeS3K	$34
	ssVol		$21
	sVolEnvPSG	VolEnv_04
	saDetune	$00
	sCall		Credits_Call1
	dc.b nC4, $0C, nC4, $06, nC5, $0C, nC4, $06
	dc.b nE4, nE5, $0C, nE4, $06, nE4, nE5, nD5
	dc.b nD5, nC5, $0C, nB3, nB3, $06, nB4, $0C
	dc.b nB3, $06, nE4, nE5, $0C, nE4, $06, nE4
	dc.b nE4, $1E, nC4, $0C, nC4, $06, nC5, $0C
	dc.b nC4, $06, nE4, nE5, $0C, nE4, $06, nE4
	dc.b nE5, nD5, nC5, nA4, $0C, nB3, nB3, $06
	dc.b nB4, $0C, nB3, $06, nE4, nE5, $0C, nE4
	dc.b $06, nE4, nE4, $1E, sHold, $24, nRst, $0C
	dc.b nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, $60, nRst, $60, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, $60, nRst
	ssVol		$69
	ssTransposeS3K	$41
	sVolEnvPSG	VolEnv_0C
	dc.b nRst, $03, nB1, $06, nE2, nCs2, nFs2
	saVolPSG	$FF
	dc.b nD2, nAb2, nE2, nA2
	saVolPSG	$FF
	dc.b nFs2, nB2, nAb2, nCs3
	saVolPSG	$FF
	dc.b nA2, nD3, nB2, nE3
	saVolPSG	$FF
	dc.b nB2, $06, nE3, nCs3, nFs3
	saVolPSG	$FF
	dc.b nD3, nAb3, nE3, nA3
	saVolPSG	$FF
	dc.b nFs3, nB3, nAb3, nCs4
	saVolPSG	$FF
	dc.b nA3, nD4, nB3, nE4, $03
	saVolPSG	$FD
	sVolEnvPSG	VolEnv_0A
	dc.b nRst, $06, nCs4, $0C, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, nA3, nCs4, $0C, nA3, nCs4, nA3
	dc.b nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3
	dc.b nCs5, nA4, nCs5, nA4, nCs4, $0C, nA3, nCs4
	dc.b nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, nA3, nCs4, nA3, nCs4, $0C, nA3
	dc.b nCs4, nA3, nCs4, nA3, nCs4, nA3, nB3, nG3
	dc.b nB3, nG3, nCs4, nA3, nCs4
	saVolPSG	$01

Credits_Loop10:
	dc.b nE5
	saVolPSG	$01
	dc.b nA5
	saVolPSG	$01
	sLoop		$00, $05, Credits_Loop10
	sStop

Credits_PSG3:
	sNoisePSG	$E7
	ssVol		$19
	dc.b nRst, $30

Credits_Loop1:
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $0C, $0C
	sVolEnvPSG	VolEnv_04
	dc.b $0C
	sVolEnvPSG	VolEnv_01
	dc.b $06
	sVolEnvPSG	VolEnv_04
	dc.b $06
	sVolEnvPSG	VolEnv_01
	dc.b $0C, $0C
	sVolEnvPSG	VolEnv_04
	dc.b $18
	sLoop		$00, $02, Credits_Loop1
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $0C, $0C
	sVolEnvPSG	VolEnv_04
	dc.b $0C
	sVolEnvPSG	VolEnv_01
	dc.b $06
	sVolEnvPSG	VolEnv_04
	dc.b $06
	sVolEnvPSG	VolEnv_01
	dc.b $0C, $0C
	sVolEnvPSG	VolEnv_04
	dc.b $0C
	sVolEnvPSG	VolEnv_01
	dc.b $0C, nBb6, $0C, $0C
	sVolEnvPSG	VolEnv_04
	dc.b $0C
	sVolEnvPSG	VolEnv_01
	dc.b $06
	sVolEnvPSG	VolEnv_04
	dc.b $06
	sVolEnvPSG	VolEnv_01
	dc.b $0C, $0C, $0C, $0C

Credits_Loop2:
	sVolEnvPSG	VolEnv_01
	dc.b $0C, $0C, $0C, $0C, $0C, $0C, $0C
	sVolEnvPSG	VolEnv_04
	dc.b $0C
	sLoop		$00, $03, Credits_Loop2
	dc.b nRst, $60, nRst, $60, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst
	ssTransposeS3K	$34
	ssVol		$09
	dc.b nRst, $3C
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $06, nBb6, $12
	sVolEnvPSG	VolEnv_08
	dc.b nBb6, $48
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $06, nBb6, $12
	sVolEnvPSG	VolEnv_08
	dc.b nBb6, $60, $60, $48
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $06, nBb6, $12
	sVolEnvPSG	VolEnv_08
	dc.b nBb6, $5A
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $06
	sVolEnvPSG	VolEnv_08
	dc.b nBb6, $5A
	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $06, nRst, $6C, nRst, $30, nRst, $60
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b $60
	ssTransposeS3K	$40
	ssVol		$18

Credits_Loop3:
	sVolEnvPSG	VolEnv_01
	dc.b nB6, $06, nB6
	sVolEnvPSG	VolEnv_04
	dc.b nB6, $0C
	sLoop		$00, $50, Credits_Loop3

Credits_Loop4:
	sVolEnvPSG	VolEnv_04
	dc.b nB6, $0C
	sVolEnvPSG	VolEnv_01
	dc.b nB6, $06, nB6
	sLoop		$00, $08, Credits_Loop4
	sStop
	; Unused
	dc.b $F5, $01, $D3, $06, $06, $F5, $08, $0C
	dc.b $F5, $01, $D3, $06, $06, $F5, $08, $0C
	dc.b $F5, $01, $D3, $06, $06, $06, $06, $F5
	dc.b $01, $D3, $06, $06, $F5, $08, $0C, $F9
	dc.b $F5, $01, $D3, $06, $06, $06, $06, $F7
	dc.b $02, $03, $4A, $D6, $F9

Credits_DAC:
	sFade		$00
	dc.b nRst, $02, dElectricHighTom, $04, $04, $04, dElectricMidTom, $05
	dc.b dElectricMidTom, $06, dElectricLowTom, nRst, nRst, nRst, $05, dCrashCymbal
	dc.b $12, dKick, dKick, $18, $06, $06, dSnare, $0C
	dc.b dCrashCymbal, nRst, dKick, nRst, $06, dKick, nRst, $0C
	dc.b dKick, $18, dSnare, dCrashCymbal, $12, dKick, dKick, $18
	dc.b $06, $06, dSnare, $0C, dCrashCymbal, nRst, dKick, nRst
	dc.b $06, dKick, nRst, $0C, dSnare, $06, dSnare, dSnare
	dc.b nRst, dSnare, nRst, dSnare, dSnare, dKick, $18, dSnare
	dc.b dKick, $0C, dKick, dSnare, dKick, nRst, dKick, dSnare
	dc.b nRst, dKick, dKick, dSnare, dKick, nRst, dKick, dSnare
	dc.b nRst, dKick, dKick, dSnare, dKick, dSnare, $06, dSnare
	dc.b nRst, dSnare, nRst, dSnare, dSnare, nRst, dSnare, $0C
	dc.b dElectricHighTom, $06, dElectricMidTom, dElectricLowTom, nRst, nRst, nRst
	ssTempo		$1F
	dc.b dKick, $18, dKick, dKick, dKick, $0C, dSnare, $06
	dc.b dKick, dSnare, dKick, $0C, dKick, $12, dSnare, $06
	dc.b dKick, $0C, dKick, dKick, $06, dSnare, $0C, dKick
	dc.b dKick, $18, dKick, dKick, dKick, $0C, dSnare, $06
	dc.b dKick, dSnare, dKick, $0C, dKick, $12, dSnare, $06
	dc.b dKick, dSnare, $0C, dSnare, dSnare, $06, dSnare, dSnare
	dc.b $0C

Credits_Loop45:
	dc.b dKick, $0C, dSnare, dSnare, dKick, dKick, dKick, dSnare
	dc.b $18, dSnare, $06, dKick, $0C, dKick, $12, dSnare
	dc.b $06, dKick, $0C, dKick, dKick, $06, dSnare, $0C
	dc.b dKick
	sLoop		$00, $03, Credits_Loop45
	dc.b dKick, $0C, dSnare, dSnare, dKick, dKick, dKick, dSnare
	dc.b $18, dSnare, $06, dKick, $0C, dKick, $12, dSnare
	dc.b $06, dKick, $0C, dKick, dKick, $06, dSnare, dSnare
	dc.b dSnare, dSnare, dKick, $0C, dSnare, dKick, dSnare, dKick
	dc.b dSnare, dSnare, dSnare, dKick, $06, dSnare, $12, dSnare
	dc.b $18, dSnare, $06, dKick, dKick, dSnare, $0C, dSnare
	dc.b dSnare, $06, dKick, $0C, dSnare, dKick, dSnare, dKick
	dc.b dSnare, dSnare, dSnare, dKick, $06, dSnare, $12, dSnare
	dc.b $18, dElectricHighTom, $02, dElectricMidTom, $04, dElectricLowTom, $06, dSnare
	dc.b dSnare, dSnare, nRst, nRst, nRst

Credits_Loop46:
	dc.b dKick, $06, dKick, dKick, dKick, dSnare, $24, dElectricFloorTom
	dc.b $06, dElectricFloorTom, dSnare, $06, dKick, $06, dMidpitchSnare, $0C
	sLoop		$01, $02, Credits_Loop46
	dc.b dKick, $0C, $06, $06, dSnare, $0C, dKick, $0C
	dc.b $06, dKick, $12, dSnare, $0C, dKick, $06, $12
	dc.b $0C, dSnare, $06, dKick, $12, $12, dSnare, $06
	dc.b $06, $06, $0C, dKick, $0C, $06, $06, dSnare
	dc.b $0C, dKick, $06, $12, dElectricFloorTom, $06, dElectricFloorTom, dSnare
	dc.b dKick, dMidpitchSnare, $0C, dKick, $0C, $06, dSnare, dKick
	dc.b dKick, dSnare, $18, dKick, $06, dKick, dSnare, dElectricFloorTom
	dc.b dMidpitchSnare, $0C, dKick, $0C, $06, $06, dSnare, $0C
	dc.b dKick, $06, $12, dElectricFloorTom, $06, dElectricFloorTom, dSnare, dKick
	dc.b dMidpitchSnare, $0C, dMidTom, $06, dLowTom, $03, $03, dFloorTom
	dc.b $06, dMidTom, dLowTom, $03, $03, dFloorTom, $06, dCrashCymbal
	dc.b $0C, nRst, $30, nRst, $06
	ssTempo		$08
	dc.b dKick, dKick, nRst, dSnare, nRst, dSnare, dSnare

Credits_Loop47:
	dc.b dKick, $18, dSnare, $06, dKick, dKick, dKick, dKick
	dc.b $0C, dKick, dSnare, $18, dKick, dSnare, $06, dKick
	dc.b dKick, dKick, dKick, $0C, dKick, dSnare, $18, dKick
	dc.b dSnare, $06, dKick, dKick, dKick, dKick, $0C, dKick
	dc.b dSnare, $18, dSnare, $06, dSnare, dKick, $0C, dKick
	dc.b dSnare, $06, dSnare, dKick, $0C, dKick, dSnare, $06
	dc.b dSnare, dSnare, $0C
	sLoop		$00, $03, Credits_Loop47
	dc.b dKick, $18, dSnare, $06, dKick, dKick, dKick, dKick
	dc.b $0C, dKick, dSnare, $18, dKick, dSnare, $06, dKick
	dc.b dKick, dKick, dKick, $0C, dKick, dSnare, $18, dKick
	dc.b dSnare, $06, dKick, dKick, dKick, dKick, $0C, dKick
	dc.b dSnare, $18, dSnare, $06, dSnare, dElectricHighTom, $0C, dElectricLowTom
	dc.b dSnare, $06, dSnare, dElectricHighTom, $0C, dElectricLowTom, dSnare, $02
	dc.b $04, $06, $06, $06
	ssTempo		$10

Credits_Loop48:
	dc.b dKick, $18, dSnare, $0C, dKick, dKick, dKick, dSnare
	dc.b $18
	sLoop		$00, $03, Credits_Loop48
	dc.b dKick, $18, dSnare, $0C, dKick, dKick, dKick, dSnare
	dc.b dSnare, $06, dSnare

Credits_Loop49:
	dc.b dKick, $18, dSnare, $0C, dKick, dKick, dKick, dSnare
	dc.b $18
	sLoop		$00, $03, Credits_Loop49
	dc.b dKick, $18, dSnare, $0C, dKick, dKick, dSnare, $06
	dc.b dSnare, dSnare, dSnare, dSnare, dSnare
	ssTempo		$08

Credits_Loop50:
	dc.b dKick, $18, dSnare, dKick, dSnare
	sLoop		$00, $07, Credits_Loop50
	dc.b dCrashCymbal, $30, dElectricFloorTom, $04, $04, $04, $06, $06
	dc.b dTightSnare, dTightSnare, dMidpitchSnare, $0C, dKick, $06, nRst, nRst
	dc.b nRst, dSnare, nRst, nRst, dSnare, nRst, dKick, dKick
	dc.b nRst, dSnare, dSnare, nRst, nRst
	ssTempo		$0C
	sPan		spCenter, $00
	dc.b dCrashCymbal, $60, nRst, nRst, nRst, $17, nRst, $0C
	dc.b dSnare, nRst, dSnare, nRst, dKick, $06, dKick

Credits_Loop51:
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
	sLoop		$00, $04, Credits_Loop51
	sPan		spCenter, $00
	dc.b dKick, $05, dKick, dKick, $0E, nRst, $0C, dMuffledSnare
	dc.b $05, dMuffledSnare, dMuffledSnare, $0E, dMuffledSnare, $0C, nRst, dKick
	dc.b $06, dKick, dKick, $0C, dKick, nRst, dMuffledSnare, $05
	dc.b dMuffledSnare, dMuffledSnare, $0E, dMuffledSnare, $0C, nRst, dKick, dKick
	dc.b $0C, dKick, nRst, dMuffledSnare, $05, dMuffledSnare, dMuffledSnare, $0E
	dc.b dKick, $06, dKick, dMuffledSnare, dMuffledSnare, dMuffledSnare, dMuffledSnare, nRst
	dc.b $01, dCrashCymbal, $30, nRst, $0C, dSnare, dSnare, dSnare
	dc.b $06, $06, dCrashCymbal, $18, dSnare, $0C, dKick, dKick
	dc.b $06, dKick, dKick, $0C, dSnare, $18, dKick, $18
	dc.b dSnare, $0C, dKick, dKick, $06, dKick, dKick, $0C
	dc.b dSnare, $18, dKick, $18, dSnare, $0C, dKick, dKick
	dc.b $06, dKick, dKick, $0C, dSnare, $18, dKick, $18
	dc.b dSnare, $0C, dKick, dKick, $06, dKick, dKick, $0C
	dc.b dSnare, $06, $06, nRst, nRst, dCrashCymbal, $18, dSnare
	dc.b $0C, dKick, dKick, $06, dKick, dKick, $0C, dSnare
	dc.b $18, dKick, $18, dSnare, $0C, dKick, dKick, $06
	dc.b dKick, dKick, $0C, dSnare, $06, $06, nRst, nRst
	dc.b dKick, $18, dSnare, dKick, $06, dKick, dKick, $0C
	dc.b dSnare, $18, dKick, $18, dSnare, $12, dKick, $06
	dc.b dKick, dKick, dKick, $0C, dSnare, dCrashCymbal, $60, nRst
	dc.b $60
	sFade		$01
	sStop

Credits_Patches:
	; Patch $00
	; $38
	; $4C, $33, $74, $41,	$1F, $1F, $1F, $1F
	; $11, $0F, $0D, $0D,	$00, $0F, $00, $00
	; $FF, $FF, $FF, $FF,	$21, $16, $26, $81
	spAlgorithm	$00
	spFeedback	$07
	spDetune	$04, $07, $03, $04
	spMultiple	$0C, $04, $03, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $0F, $00
	spSustainRt	$11, $0D, $0F, $0D
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$21, $26, $16, $01

	; Patch $01
	; $35
	; $40, $30, $50, $30,	$18, $1F, $1F, $1F
	; $0D, $0B, $09, $09,	$00, $00, $00, $00
	; $EF, $EF, $EF, $EF,	$14, $85, $85, $85
	spAlgorithm	$05
	spFeedback	$06
	spDetune	$04, $05, $03, $03
	spMultiple	$00, $00, $00, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$18, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$0D, $09, $0B, $09
	spSustainLv	$0E, $0E, $0E, $0E
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$14, $05, $05, $05

	; Patch $02
	; $3B
	; $71, $12, $13, $71,	$11, $10, $14, $1A
	; $0C, $09, $0A, $02,	$00, $06, $04, $07
	; $1F, $EF, $FF, $EF,	$1B, $24, $24, $81
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$07, $01, $01, $07
	spMultiple	$01, $03, $02, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$11, $14, $10, $1A
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $04, $06, $07
	spSustainRt	$0C, $0A, $09, $02
	spSustainLv	$01, $0F, $0E, $0E
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1B, $24, $24, $01

	; Patch $03
	; $34
	; $61, $03, $00, $61,	$1F, $1E, $51, $D0
	; $0C, $08, $01, $01,	$08, $00, $09, $00
	; $8F, $FF, $FF, $FF,	$11, $85, $19, $86
	spAlgorithm	$04
	spFeedback	$06
	spDetune	$06, $00, $00, $06
	spMultiple	$01, $00, $03, $01
	spRateScale	$00, $01, $00, $03
	spAttackRt	$1F, $11, $1E, $10
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$08, $09, $00, $00
	spSustainRt	$0C, $01, $08, $01
	spSustainLv	$08, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$11, $19, $05, $06

	; Patch $04
	; $1B
	; $63, $50, $21, $41,	$15, $0F, $16, $13
	; $10, $01, $06, $05,	$05, $01, $05, $01
	; $CF, $0F, $DF, $CF,	$21, $12, $2A, $81
	spAlgorithm	$03
	spFeedback	$03
	spDetune	$06, $02, $05, $04
	spMultiple	$03, $01, $00, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$15, $16, $0F, $13
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$05, $05, $01, $01
	spSustainRt	$10, $06, $01, $05
	spSustainLv	$0C, $0D, $00, $0C
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$21, $2A, $12, $01

	; Patch $05
	; $34
	; $31, $30, $71, $31,	$16, $1B, $13, $1F
	; $13, $06, $08, $08,	$08, $0B, $0C, $0D
	; $9F, $8F, $9F, $8F,	$0F, $8C, $12, $83
	spAlgorithm	$04
	spFeedback	$06
	spDetune	$03, $07, $03, $03
	spMultiple	$01, $01, $00, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$16, $13, $1B, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$08, $0C, $0B, $0D
	spSustainRt	$13, $08, $06, $08
	spSustainLv	$09, $09, $08, $08
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0F, $12, $0C, $03

	; Patch $06
	; $07
	; $14, $76, $72, $71,	$9F, $9F, $1F, $1F
	; $0C, $0C, $0C, $0C,	$0E, $0E, $03, $02
	; $0F, $0F, $DF, $DF,	$81, $81, $81, $81
	spAlgorithm	$07
	spFeedback	$00
	spDetune	$01, $07, $07, $07
	spMultiple	$04, $02, $06, $01
	spRateScale	$02, $00, $02, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0E, $03, $0E, $02
	spSustainRt	$0C, $0C, $0C, $0C
	spSustainLv	$00, $0D, $00, $0D
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$01, $01, $01, $01

	; Patch $07
	; $20
	; $36, $35, $30, $31,	$DF, $DF, $9F, $9F
	; $07, $06, $09, $06,	$07, $06, $06, $08
	; $20, $10, $10, $F8,	$19, $37, $13, $80
	spAlgorithm	$00
	spFeedback	$04
	spDetune	$03, $03, $03, $03
	spMultiple	$06, $00, $05, $01
	spRateScale	$03, $02, $03, $02
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$07, $06, $06, $08
	spSustainRt	$07, $09, $06, $06
	spSustainLv	$02, $01, $01, $0F
	spReleaseRt	$00, $00, $00, $08
	spTotalLv	$19, $13, $37, $00

	; Patch $08
	; $34
	; $33, $41, $7E, $74,	$5B, $9F, $5F, $1F
	; $04, $07, $07, $08,	$00, $00, $00, $00
	; $FF, $FF, $EF, $FF,	$23, $90, $29, $97
	spAlgorithm	$04
	spFeedback	$06
	spDetune	$03, $07, $04, $07
	spMultiple	$03, $0E, $01, $04
	spRateScale	$01, $01, $02, $00
	spAttackRt	$1B, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$04, $07, $07, $08
	spSustainLv	$0F, $0E, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$23, $29, $10, $17

	; Patch $09
	; $3A
	; $01, $07, $31, $71,	$8E, $8E, $8D, $53
	; $0E, $0E, $0E, $03,	$00, $00, $00, $07
	; $1F, $FF, $1F, $0F,	$18, $28, $27, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$00, $03, $00, $07
	spMultiple	$01, $01, $07, $01
	spRateScale	$02, $02, $02, $01
	spAttackRt	$0E, $0D, $0E, $13
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $07
	spSustainRt	$0E, $0E, $0E, $03
	spSustainLv	$01, $01, $0F, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$18, $27, $28, $00

	; Patch $0A
	; $38
	; $63, $31, $31, $31,	$10, $13, $1A, $1B
	; $0E, $00, $00, $00,	$00, $00, $00, $00
	; $3F, $0F, $0F, $0F,	$1A, $19, $1A, $80
	spAlgorithm	$00
	spFeedback	$07
	spDetune	$06, $03, $03, $03
	spMultiple	$03, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$10, $1A, $13, $1B
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$0E, $00, $00, $00
	spSustainLv	$03, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1A, $1A, $19, $00

	; Patch $0B
	; $02
	; $74, $51, $13, $31,	$93, $D3, $12, $13
	; $06, $01, $01, $03,	$0C, $13, $0C, $0B
	; $FF, $EF, $DF, $8F,	$33, $13, $19, $83
	spAlgorithm	$02
	spFeedback	$00
	spDetune	$07, $01, $05, $03
	spMultiple	$04, $03, $01, $01
	spRateScale	$02, $00, $03, $00
	spAttackRt	$13, $12, $13, $13
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0C, $0C, $13, $0B
	spSustainRt	$06, $01, $01, $03
	spSustainLv	$0F, $0D, $0E, $08
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$33, $19, $13, $03

	; Patch $0C
	; $35
	; $02, $04, $02, $01,	$10, $0A, $0C, $0E
	; $07, $04, $04, $04,	$01, $0A, $0A, $0A
	; $28, $1B, $1B, $1B,	$1D, $8E, $8D, $8E
	spAlgorithm	$05
	spFeedback	$06
	spDetune	$00, $00, $00, $00
	spMultiple	$02, $02, $04, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$10, $0C, $0A, $0E
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$01, $0A, $0A, $0A
	spSustainRt	$07, $04, $04, $04
	spSustainLv	$02, $01, $01, $01
	spReleaseRt	$08, $0B, $0B, $0B
	spTotalLv	$1D, $0D, $0E, $0E

	; Patch $0D
	; $3D
	; $00, $04, $07, $0A,	$1F, $1F, $1F, $1F
	; $1F, $1D, $1D, $1D,	$05, $06, $16, $00
	; $09, $1F, $1F, $1F,	$34, $8D, $87, $86
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $07, $04, $0A
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$05, $16, $06, $00
	spSustainRt	$1F, $1D, $1D, $1D
	spSustainLv	$00, $01, $01, $01
	spReleaseRt	$09, $0F, $0F, $0F
	spTotalLv	$34, $07, $0D, $06

	; Patch $0E
	; $32
	; $38, $46, $4F, $32,	$1F, $1F, $1F, $1F
	; $0E, $1C, $16, $02,	$00, $00, $00, $00
	; $60, $60, $40, $39,	$05, $04, $18, $80
	spAlgorithm	$02
	spFeedback	$06
	spDetune	$03, $04, $04, $03
	spMultiple	$08, $0F, $06, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$0E, $16, $1C, $02
	spSustainLv	$06, $04, $06, $03
	spReleaseRt	$00, $00, $00, $09
	spTotalLv	$05, $18, $04, $00

	; Patch $0F
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

	; Patch $10
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

	; Patch $11
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

	; Patch $12
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

	; Patch $13
	; $05
	; $2E, $17, $1F, $1F,	$1F, $1F, $1F, $1F
	; $00, $0B, $08, $08,	$00, $08, $08, $08
	; $00, $19, $19, $19,	$28, $8A, $89, $89
	spAlgorithm	$05
	spFeedback	$00
	spDetune	$02, $01, $01, $01
	spMultiple	$0E, $0F, $07, $0F
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $08, $08, $08
	spSustainRt	$00, $08, $0B, $08
	spSustainLv	$00, $01, $01, $01
	spReleaseRt	$00, $09, $09, $09
	spTotalLv	$28, $09, $0A, $09

	; Patch $14
	; $02
	; $71, $52, $41, $11,	$17, $16, $15, $17
	; $0A, $03, $05, $03,	$00, $00, $00, $00
	; $FF, $FF, $FF, $FF,	$07, $1F, $25, $87
	spAlgorithm	$02
	spFeedback	$00
	spDetune	$07, $04, $05, $01
	spMultiple	$01, $01, $02, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$17, $15, $16, $17
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$0A, $05, $03, $03
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$07, $25, $1F, $07

	; Patch $15
	; $03
	; $74, $18, $71, $11,	$DF, $5F, $1F, $1F
	; $0C, $0F, $01, $01,	$00, $00, $00, $00
	; $FF, $FF, $FF, $FF,	$0B, $1D, $10, $84
	spAlgorithm	$03
	spFeedback	$00
	spDetune	$07, $07, $01, $01
	spMultiple	$04, $01, $08, $01
	spRateScale	$03, $00, $01, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$0C, $01, $0F, $01
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0B, $10, $1D, $04

	; Patch $16
	; $3D
	; $41, $01, $21, $71,	$0D, $12, $52, $D2
	; $01, $01, $01, $01,	$08, $00, $09, $00
	; $89, $F8, $F9, $F8,	$1D, $87, $87, $87
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$04, $02, $00, $07
	spMultiple	$01, $01, $01, $01
	spRateScale	$00, $01, $00, $03
	spAttackRt	$0D, $12, $12, $12
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$08, $09, $00, $00
	spSustainRt	$01, $01, $01, $01
	spSustainLv	$08, $0F, $0F, $0F
	spReleaseRt	$09, $09, $08, $08
	spTotalLv	$1D, $07, $07, $07

	; Patch $17
	; $03
	; $61, $51, $23, $41,	$10, $10, $0F, $15
	; $1C, $01, $06, $05,	$05, $01, $05, $01
	; $C9, $0C, $D9, $C9,	$18, $17, $17, $83
	spAlgorithm	$03
	spFeedback	$00
	spDetune	$06, $02, $05, $04
	spMultiple	$01, $03, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$10, $0F, $10, $15
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$05, $05, $01, $01
	spSustainRt	$1C, $06, $01, $05
	spSustainLv	$0C, $0D, $00, $0C
	spReleaseRt	$09, $09, $0C, $09
	spTotalLv	$18, $17, $17, $03

	; Patch $18
	; $10
	; $57, $4B, $76, $41,	$19, $12, $5F, $1F
	; $02, $06, $05, $01,	$00, $0F, $00, $00
	; $18, $38, $58, $18,	$26, $1F, $1C, $87
	spAlgorithm	$00
	spFeedback	$02
	spDetune	$05, $07, $04, $04
	spMultiple	$07, $06, $0B, $01
	spRateScale	$00, $01, $00, $00
	spAttackRt	$19, $1F, $12, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $0F, $00
	spSustainRt	$02, $05, $06, $01
	spSustainLv	$01, $05, $03, $01
	spReleaseRt	$08, $08, $08, $08
	spTotalLv	$26, $1C, $1F, $07

	; Patch $19
	; $02
	; $74, $50, $13, $31,	$95, $D5, $15, $16
	; $06, $01, $01, $03,	$0C, $13, $0C, $0B
	; $FF, $EF, $DF, $8F,	$3D, $1D, $22, $81
	spAlgorithm	$02
	spFeedback	$00
	spDetune	$07, $01, $05, $03
	spMultiple	$04, $03, $00, $01
	spRateScale	$02, $00, $03, $00
	spAttackRt	$15, $15, $15, $16
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0C, $0C, $13, $0B
	spSustainRt	$06, $01, $01, $03
	spSustainLv	$0F, $0D, $0E, $08
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$3D, $22, $1D, $01

	; Patch $1A
	; $3D
	; $43, $05, $23, $71,	$11, $16, $55, $D5
	; $01, $01, $01, $01,	$08, $00, $09, $00
	; $89, $F8, $F9, $F8,	$1B, $88, $8A, $88
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$04, $02, $00, $07
	spMultiple	$03, $03, $05, $01
	spRateScale	$00, $01, $00, $03
	spAttackRt	$11, $15, $16, $15
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$08, $09, $00, $00
	spSustainRt	$01, $01, $01, $01
	spSustainLv	$08, $0F, $0F, $0F
	spReleaseRt	$09, $09, $08, $08
	spTotalLv	$1B, $0A, $08, $08

	; Patch $1B
	; $38
	; $75, $13, $71, $11,	$1F, $5F, $1F, $1F
	; $10, $0D, $03, $04,	$00, $00, $00, $00
	; $FF, $FF, $FF, $FF,	$1F, $16, $1D, $81
	spAlgorithm	$00
	spFeedback	$07
	spDetune	$07, $07, $01, $01
	spMultiple	$05, $01, $03, $01
	spRateScale	$00, $00, $01, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$10, $03, $0D, $04
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1F, $1D, $16, $01

	; Patch $1C
	; $3D
	; $01, $01, $11, $12,	$18, $1F, $1F, $1F
	; $10, $06, $06, $06,	$01, $00, $00, $00
	; $3F, $1F, $1F, $1F,	$10, $83, $83, $83
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $01, $00, $01
	spMultiple	$01, $01, $01, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$18, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$01, $00, $00, $00
	spSustainRt	$10, $06, $06, $06
	spSustainLv	$03, $01, $01, $01
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$10, $03, $03, $03

	; Patch $1D
	; $00
	; $23, $30, $30, $21,	$9F, $5F, $1F, $1F
	; $00, $0F, $01, $00,	$07, $00, $00, $0C
	; $0F, $4F, $FF, $0F,	$26, $30, $1D, $80
	spAlgorithm	$00
	spFeedback	$00
	spDetune	$02, $03, $03, $02
	spMultiple	$03, $00, $00, $01
	spRateScale	$02, $00, $01, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$07, $00, $00, $0C
	spSustainRt	$00, $01, $0F, $00
	spSustainLv	$00, $0F, $04, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$26, $1D, $30, $00

	; Patch $1E
	; $04
	; $12, $0A, $06, $7C,	$5F, $5F, $5F, $5F
	; $00, $08, $00, $00,	$00, $00, $00, $0A
	; $0F, $FF, $0F, $0F,	$11, $8C, $13, $8C
	spAlgorithm	$04
	spFeedback	$00
	spDetune	$01, $00, $00, $07
	spMultiple	$02, $06, $0A, $0C
	spRateScale	$01, $01, $01, $01
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $0A
	spSustainRt	$00, $00, $08, $00
	spSustainLv	$00, $00, $0F, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$11, $13, $0C, $0C

	; Patch $1F
	; $3D
	; $02, $02, $01, $02,	$1F, $1F, $1F, $1F
	; $06, $05, $04, $05,	$06, $05, $06, $06
	; $60, $87, $58, $78,	$1B, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$02, $01, $02, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$06, $06, $05, $06
	spSustainRt	$06, $04, $05, $05
	spSustainLv	$06, $05, $08, $07
	spReleaseRt	$00, $08, $07, $08
	spTotalLv	$1B, $00, $00, $00

	; Patch $20
	; $04
	; $70, $71, $00, $00,	$1F, $1F, $1F, $1F
	; $00, $0F, $01, $00,	$07, $00, $00, $0C
	; $4F, $4F, $FF, $0F,	$19, $80, $1A, $80
	spAlgorithm	$04
	spFeedback	$00
	spDetune	$07, $00, $07, $00
	spMultiple	$00, $00, $01, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$07, $00, $00, $0C
	spSustainRt	$00, $01, $0F, $00
	spSustainLv	$04, $0F, $04, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$19, $1A, $00, $00

	; Patch $21
	; $07
	; $02, $03, $04, $05,	$0F, $0F, $0F, $0F
	; $06, $06, $06, $06,	$00, $00, $00, $00
	; $FF, $FF, $FF, $FF,	$8C, $8C, $88, $80
	spAlgorithm	$07
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$02, $04, $03, $05
	spRateScale	$00, $00, $00, $00
	spAttackRt	$0F, $0F, $0F, $0F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$06, $06, $06, $06
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0C, $08, $0C, $00

	; Patch $22
	; $3D
	; $51, $21, $30, $10,	$1F, $1F, $1F, $1F
	; $0F, $00, $00, $00,	$00, $00, $00, $00
	; $1F, $4F, $4F, $4F,	$10, $8E, $8E, $8E
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$05, $03, $02, $01
	spMultiple	$01, $00, $01, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$0F, $00, $00, $00
	spSustainLv	$01, $04, $04, $04
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$10, $0E, $0E, $0E

	; Patch $23
	; $2C
	; $71, $62, $31, $32,	$5F, $54, $5F, $5F
	; $00, $09, $00, $09,	$00, $03, $00, $03
	; $0F, $8F, $0F, $AF,	$16, $80, $11, $80
	spAlgorithm	$04
	spFeedback	$05
	spDetune	$07, $03, $06, $03
	spMultiple	$01, $01, $02, $02
	spRateScale	$01, $01, $01, $01
	spAttackRt	$1F, $1F, $14, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $03, $03
	spSustainRt	$00, $00, $09, $09
	spSustainLv	$00, $00, $08, $0A
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$16, $11, $00, $00

	; Patch $24
	; $3C
	; $71, $31, $12, $11,	$17, $1F, $19, $2F
	; $04, $01, $07, $01,	$00, $00, $00, $00
	; $F7, $F8, $F7, $F8,	$1D, $80, $19, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$07, $01, $03, $01
	spMultiple	$01, $02, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$17, $19, $1F, $0F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$04, $07, $01, $01
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$07, $07, $08, $08
	spTotalLv	$1D, $19, $00, $00
