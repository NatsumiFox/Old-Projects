LevelOutro_Header:
	sHeaderInit	; Z80 offset is $E3C0
	sHeaderPatchUniv
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $25
	sHeaderDAC	LevelOutro_DAC
	sHeaderFM	LevelOutro_FM1, $0C, $12
	sHeaderFM	LevelOutro_FM2, $0C, $16
	sHeaderFM	LevelOutro_FM3, $0C, $16
	sHeaderFM	LevelOutro_FM4, $0C, $16
	sHeaderFM	LevelOutro_FM5, $0C, $1A
	sHeaderPSG	LevelOutro_PSG1, $00, $03, $00, VolEnv_0C
	sHeaderPSG	LevelOutro_PSG2, $00, $03, $00, VolEnv_0C
	sHeaderPSG	LevelOutro_PSG3, $00, $05, $00, VolEnv_0C

LevelOutro_DAC:
	dc.b dSnare, $06, dKick, dKick, dSnare, dKick, dKick, dSnare
	dc.b dKick, dSnare, dKick, dKick, dSnare, dKick, dKick, dSnare
	dc.b dKick, $01, nRst, dKick, dKick, nRst, dKick, dHighTom
	dc.b $06, dMidTom, dLowTom, dHighTom, dMidTom, dLowTom, dHighTom, dMidTom
	dc.b dLowTom, dSnare
	sStop

LevelOutro_FM1:
	sPatFM		$15
	dc.b nG0, $05, nRst, $01, nG1, $05, nRst, $01
	dc.b nG0, $05, nRst, $01, nD1, $05, nRst, $07
	dc.b nG1, $05, nRst, $01, nG0, $05, nRst, $07
	dc.b nA0, $05, nRst, $01, nA1, $05, nRst, $01
	dc.b nA0, $05, nRst, $01, nE1, $05, nRst, $07
	dc.b nA1, $05, nRst, $01, nA0, $05, nRst, $07
	dc.b nD1, $05, nRst, $01, nD2, $05, nRst, $01
	dc.b nD1, $05, nRst, $01, nE1, $05, nRst, $01
	dc.b nE2, $05, nRst, $01, nE1, $05, nRst, $01
	dc.b nG1, $05, nRst, $01, nG2, $05, nRst, $01
	dc.b nG1, $05, nRst, $01, nA1, $5F, nRst, $01
	sStop

LevelOutro_FM2:
	saDetune	$03
	sPatFM		$08

LevelOutro_Jump2:
	dc.b nD3, $06, nD3, nD3, nD3, $07, nRst, $05
	dc.b nD3, $07, nRst, $05, nE3, $05, nRst, $07
	dc.b nE3, $05, nRst, $07, nE3, $07, nRst, $05
	dc.b nE3, $11, nRst, $01, nG3, $05, nRst, $0D
	dc.b nA3, $05, nRst, $0D, nC4, $11, nRst, $01
	dc.b nD4, $5F, nRst, $01
	sStop

LevelOutro_FM3:
	saDetune	$FF
	sPatFM		$01
	dc.b nC3, $06, nC3, nC3, nB2, nRst, nB2, nRst
	dc.b nD3, nRst, $06, nD3, $06, nRst, $06, nCs3
	dc.b $06, nRst, nCs3, $11, nRst, $01, nE3, $05
	dc.b nRst, $0D, nFs3, $05, nRst, $0D, nA3, $11
	dc.b nRst, $01, nB3, $5F, nRst, $01
	sStop

LevelOutro_FM4:
	saDetune	$01
	sPatFM		$01

LevelOutro_Jump1:
	dc.b nG2, $06, nG2, nG2, nG2, nRst, nG2, nRst
	dc.b nA2, nRst, nA2, $03, nRst, $09, nA2, $05
	dc.b nRst, $07, nA2, $11, nRst, $01, nC3, $05
	dc.b nRst, $0D, nD3, $05, nRst, $0D, nF3, $11
	dc.b nRst, $01, nG3, $5F, nRst, $01
	sStop

LevelOutro_FM5:
	saDetune	$FD
	sVolEnvPSG	VolEnv_03
	dc.b nRst, $01
	sPatFM		$01
	sJump		LevelOutro_Jump2

LevelOutro_PSG1:
	saDetune	$01
	sVolEnvPSG	VolEnv_03
	sJump		LevelOutro_Jump2

LevelOutro_PSG2:
	saDetune	$FF
	sPatFM		$01
	sVolEnvPSG	VolEnv_03
	sJump		LevelOutro_Jump1

LevelOutro_PSG3:
	sVolEnvPSG	VolEnv_02
	sNoisePSG	$E7
	dc.b nB6, $06, nB6, nB6, nB6, $05, nRst, $07
	dc.b nB6, $05, nRst, $07, nB6, $03, nRst, $09
	dc.b nB6, $03, nRst, $09, nB6, $05, nRst, $07
	dc.b nB6, $11, nRst, $01, nB6, $05, nRst, $0D
	dc.b nB6, $05, nRst, $0D, nB6, $11, nRst, $01
	dc.b nB6, $5F, nRst, $01
	sStop
