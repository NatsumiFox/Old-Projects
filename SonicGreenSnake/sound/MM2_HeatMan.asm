; =============================================================================================
; Project Name:		MM2_Heat_Man
; Created:		17th January 2014
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

MM2_Heat_Man_Header:
;	Voice Pointer	location
	smpsHeaderVoice	MM2_Heat_Man_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$02,	$05

;	DAC Pointer	location
	smpsHeaderDAC	MM2_Heat_Man_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	MM2_Heat_Man_FM1,	smpsPitch01lo,	$10
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	MM2_Heat_Man_FM2,	smpsPitch01hi,	$10
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	MM2_Heat_Man_FM3,	smpsPitch01lo,	$18
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	MM2_Heat_Man_FM4,	smpsPitch00,	$10
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	MM2_Heat_Man_FM5,	smpsPitch01hi,	$10
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	MM2_Heat_Man_PSG1,	smpsPitch03lo,	$06,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	MM2_Heat_Man_PSG2,	smpsPitch03lo,	$00,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	MM2_Heat_Man_PSG3,	smpsPitch00+$0B,	$03,	$00

; FM1 Data
MM2_Heat_Man_FM1:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nD3,	$03,	$03,	nD4,	$03,	nRst,	nC4,	nCs4
	dc.b		nRst,	nD4,	nRst,	nA3,	nRst,	nAb3,	nRst,	nG3
	dc.b		nFs3,	nF3,	nC3,	nC3,	nC4,	nRst,	nBb3,	nB3
	dc.b		nRst,	nC4,	nRst,	nG3,	nRst,	nFs3,	nRst,	nF3
	dc.b		nE3,	nEb3,	nD3,	nD3,	nD4,	nRst,	nC4,	nCs4
	dc.b		nRst,	nD4,	nRst,	nA3,	nRst,	nAb3,	nRst,	nG3
	dc.b		nFs3,	nF3,	nC3,	nC3,	nC4,	nRst,	nBb3,	nB3
	dc.b		nRst,	nC4,	nRst,	nG3,	nRst,	nFs3,	nRst,	nF3
	dc.b		nE3,	nEb3,	nD3,	nD3,	nD4,	nRst,	nC4,	nCs4
	dc.b		nRst,	nD4,	nRst,	nA3,	nRst,	nAb3,	nRst,	nG3
	dc.b		nFs3,	nF3,	nC3,	nC3,	nC4,	nRst,	nBb3,	nB3
	dc.b		nRst,	nC4,	nRst,	nG3,	nRst,	nFs3,	nRst,	nF3
	dc.b		nE3,	nEb3,	nD3,	nD3,	nD4,	nRst,	nC4,	nCs4
	dc.b		nRst,	nD4,	nRst,	nA3,	nRst,	nAb3,	nRst,	nG3
	dc.b		nFs3,	nF3,	nC4,	nC4,	nRst,	nA3,	nD4,	nD4
	dc.b		nRst,	nA3,	nA3,	nC4,	nA3,	nD4,	nRst,	$6F
	dc.b		nD4,	$03,	nF4,	nA4,	nD5,	nRst,	nA4,	nRst
	dc.b		nG4,	nA4,	nRst,	nG4,	nRst,	nD4,	nE4,	nF4
	dc.b		nD5,	nRst,	nD5,	nE5,	nF5,	nA5,	nRst,	nF5
	dc.b		nRst,	nA4,	nC5,	nD5,	nF5,	nE5,	nD5,	nC5
	dc.b		nRst,	$63,	nD4,	$03,	nF4,	nA4,	nD5,	nRst
	dc.b		nA4,	nRst,	nG4,	nA4,	nRst,	nG4,	nRst,	nD4
	dc.b		nE4,	nF4,	nE5,	nE5,	nRst,	nD5,	nF5,	nF5
	dc.b		nRst,	nD5,	nD5,	nE5,	nD5,	nF5,	nRst,	$0C
	dc.b		nD3,	$03,	$03,	nD4,	$03,	nRst,	nC4,	nCs4
	dc.b		nRst,	nD4,	nRst,	nA3,	nRst,	nAb3,	nRst,	nG3
	dc.b		nFs3,	nF3,	nC3,	nC3,	nC4,	nRst,	nBb3,	nB3
	dc.b		nRst,	nC4,	nRst,	nG3,	nRst,	nFs3,	nRst,	nF3
	dc.b		nE3,	nEb3,	nD3,	nD3,	nD4,	nRst,	nC4,	nCs4
	dc.b		nRst,	nD4,	nRst,	nA3,	nRst,	nAb3,	nRst,	nG3
	dc.b		nFs3,	nF3,	nC3,	nC3,	nC4,	nRst,	nBb3,	nB3
	dc.b		nRst,	nC4,	nRst,	nG3,	nRst,	nFs3,	nRst,	nF3
	dc.b		nE3,	nEb3,	nD3,	nD3,	nD4,	nRst,	nC4,	nCs4
	dc.b		nRst,	nD4,	nRst,	nA3,	nRst,	nAb3,	nRst,	nG3
	dc.b		nFs3,	nF3,	nC3,	nC3,	nC4,	nRst,	nBb3,	nB3
	dc.b		nRst,	nC4,	nRst,	nG3,	nRst,	nFs3,	nRst,	nF3
	dc.b		nE3,	nEb3,	nD3,	nD3,	nD4,	nRst,	nC4,	nCs4
	dc.b		nRst,	nD4,	nRst,	nA3,	nRst,	nAb3,	nRst,	nG3
	dc.b		nFs3,	nF3,	nC4,	nC4,	nRst,	nA3,	nD4,	nD4
	dc.b		nRst,	nA3,	nA3,	nC4,	nA3,	nD4,	nRst,	$6F
	dc.b		nD4,	$03,	nF4,	nA4,	nD5,	nRst,	nA4,	nRst
	dc.b		nG4,	nA4,	nRst,	nG4,	nRst,	nD4,	nE4,	nF4
	dc.b		nD5,	nRst,	nD5,	nE5,	nF5,	nA5,	nRst,	nF5
	dc.b		nRst,	nA4,	nC5,	nD5,	nF5,	nE5,	nD5,	nC5
	dc.b		nRst,	$63,	nD4,	$03,	nF4,	nA4,	nD5,	nRst
	dc.b		nA4,	nRst,	nG4,	nA4,	nRst,	nG4,	nRst,	nD4
	dc.b		nE4,	nF4,	nE5,	nE5,	nRst,	nD5,	nF5,	nF5
	dc.b		nRst,	nD5,	nD5,	nE5,	nD5,	nF5,	nRst,	$7F
	dc.b		$7F,	$7F,	$72,	nD4,	$03,	nF4,	nA4,	nD5
	dc.b		nRst,	nA4,	nRst,	nG4,	nA4,	nRst,	nG4,	nRst
	dc.b		nD4,	nE4,	nF4,	nD5,	nRst,	nD5,	nE5,	nF5
	dc.b		nA5,	nRst,	nF5,	nRst,	nA4,	nC5,	nD5,	nF5
	dc.b		nE5,	nD5,	nC5,	nRst,	$63,	nD4,	$03,	nF4
	dc.b		nA4,	nD5,	nRst,	nA4,	nRst,	nG4,	nA4,	nRst
	dc.b		nG4,	nRst,	nD4,	nE4,	nF4,	nE5,	nE5,	nRst
	dc.b		nD5,	nF5,	nF5,	nRst,	nD5,	nD5,	nE5,	nD5
	dc.b		nF5,	nRst,	$0C
;	Jump To	 	location
	smpsJump	MM2_Heat_Man_FM1

; FM2 Data
MM2_Heat_Man_FM2:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nD1,	$03,	$03,	nD2,	$03,	nRst,	nC2,	nCs2
	dc.b		nRst,	nD2,	nRst,	nA1,	nRst,	nAb1,	nRst,	nG1
	dc.b		nFs1,	nF1,	nC1,	nC1,	nC2,	nRst,	nBb1,	nB1
	dc.b		nRst,	nC2,	nRst,	nG1,	nRst,	nFs1,	nRst,	nF1
	dc.b		nE1,	nEb1,	nD1,	nD1,	nD2,	nRst,	nC2,	nCs2
	dc.b		nRst,	nD2,	nRst,	nA1,	nRst,	nAb1,	nRst,	nG1
	dc.b		nFs1,	nF1,	nC1,	nC1,	nC2,	nRst,	nBb1,	nB1
	dc.b		nRst,	nC2,	nRst,	nG1,	nRst,	nFs1,	nRst,	nF1
	dc.b		nE1,	nEb1,	nD1,	nD1,	nD2,	nRst,	nC2,	nCs2
	dc.b		nRst,	nD2,	nRst,	nA1,	nRst,	nAb1,	nRst,	nG1
	dc.b		nFs1,	nF1,	nC1,	nC1,	nC2,	nRst,	nBb1,	nB1
	dc.b		nRst,	nC2,	nRst,	nG1,	nRst,	nFs1,	nRst,	nF1
	dc.b		nE1,	nEb1,	nD1,	nD1,	nD2,	nRst,	nC2,	nCs2
	dc.b		nRst,	nD2,	nRst,	nA1,	nRst,	nAb1,	nRst,	nG1
	dc.b		nFs1,	nF1,	nC2,	nC2,	nRst,	nA1,	nD2,	nD2
	dc.b		nRst,	nA1,	nA1,	nC2,	nA1,	nD2,	nRst,	$0C
	dc.b		nD1,	$06,	nD2,	nD1,	$03,	$03,	nD2,	$06
	dc.b		nD1,	nD2,	nD1,	$03,	nE1,	nD1,	nC1,	$09
	dc.b		nC2,	$06,	nC1,	nC2,	$03,	nC1,	nC1,	$06
	dc.b		nCs1,	nD1,	$03,	nA0,	nRst,	nD1,	nRst,	nD1
	dc.b		nG1,	nA1,	nD1,	nRst,	nD2,	nRst,	nD2,	nC2
	dc.b		nA1,	nG1,	$06,	nD1,	$03,	nG1,	nA1,	nBb1
	dc.b		nRst,	nBb1,	nRst,	nF2,	nBb1,	$06,	nC2,	nG1
	dc.b		$03,	nE1,	nC1,	nD2,	nA1,	nF1,	nD1,	nF1
	dc.b		$06,	nF2,	nF1,	$03,	$03,	nF2,	$06,	nF1
	dc.b		nF2,	nF1,	$03,	nE1,	nD1,	nE1,	$09,	nE2
	dc.b		$06,	nE1,	nE2,	$03,	nE1,	nE1,	$06,	nF1
	dc.b		nE1,	$03,	nC1,	nRst,	nD1,	nRst,	nD1,	nG1
	dc.b		nA1,	nD2,	nG1,	nA1,	nD2,	nG1,	$06,	nF1
	dc.b		nE1,	nC1,	nC2,	$03,	$03,	nRst,	$03,	nA1
	dc.b		nD2,	nD2,	nRst,	nA1,	nA1,	nC2,	nA1,	nD2
	dc.b		nRst,	$0C,	nD1,	$03,	$03,	nD2,	$03,	nRst
	dc.b		nC2,	nCs2,	nRst,	nD2,	nRst,	nA1,	nRst,	nAb1
	dc.b		nRst,	nG1,	nFs1,	nF1,	nC1,	nC1,	nC2,	nRst
	dc.b		nBb1,	nB1,	nRst,	nC2,	nRst,	nG1,	nRst,	nFs1
	dc.b		nRst,	nF1,	nE1,	nEb1,	nD1,	nD1,	nD2,	nRst
	dc.b		nC2,	nCs2,	nRst,	nD2,	nRst,	nA1,	nRst,	nAb1
	dc.b		nRst,	nG1,	nFs1,	nF1,	nC1,	nC1,	nC2,	nRst
	dc.b		nBb1,	nB1,	nRst,	nC2,	nRst,	nG1,	nRst,	nFs1
	dc.b		nRst,	nF1,	nE1,	nEb1,	nD1,	nD1,	nD2,	nRst
	dc.b		nC2,	nCs2,	nRst,	nD2,	nRst,	nA1,	nRst,	nAb1
	dc.b		nRst,	nG1,	nFs1,	nF1,	nC1,	nC1,	nC2,	nRst
	dc.b		nBb1,	nB1,	nRst,	nC2,	nRst,	nG1,	nRst,	nFs1
	dc.b		nRst,	nF1,	nE1,	nEb1,	nD1,	nD1,	nD2,	nRst
	dc.b		nC2,	nCs2,	nRst,	nD2,	nRst,	nA1,	nRst,	nAb1
	dc.b		nRst,	nG1,	nFs1,	nF1,	nC2,	nC2,	nRst,	nA1
	dc.b		nD2,	nD2,	nRst,	nA1,	nA1,	nC2,	nA1,	nD2
	dc.b		nRst,	$0C,	nD1,	$06,	nD2,	nD1,	$03,	$03
	dc.b		nD2,	$06,	nD1,	nD2,	nD1,	$03,	nE1,	nD1
	dc.b		nC1,	$09,	nC2,	$06,	nC1,	nC2,	$03,	nC1
	dc.b		nC1,	$06,	nCs1,	nD1,	$03,	nA0,	nRst,	nD1
	dc.b		nRst,	nD1,	nG1,	nA1,	nD1,	nRst,	nD2,	nRst
	dc.b		nD2,	nC2,	nA1,	nG1,	$06,	nD1,	$03,	nG1
	dc.b		nA1,	nBb1,	nRst,	nBb1,	nRst,	nF2,	nBb1,	$06
	dc.b		nC2,	nG1,	$03,	nE1,	nC1,	nD2,	nA1,	nF1
	dc.b		nD1,	nF1,	$06,	nF2,	nF1,	$03,	$03,	nF2
	dc.b		$06,	nF1,	nF2,	nF1,	$03,	nE1,	nD1,	nE1
	dc.b		$09,	nE2,	$06,	nE1,	nE2,	$03,	nE1,	nE1
	dc.b		$06,	nF1,	nE1,	$03,	nC1,	nRst,	nD1,	nRst
	dc.b		nD1,	nG1,	nA1,	nD2,	nG1,	nA1,	nD2,	nG1
	dc.b		$06,	nF1,	nE1,	nC1,	nC2,	$03,	$03,	nRst
	dc.b		$03,	nA1,	nD2,	nD2,	nRst,	nA1,	nA1,	nC2
	dc.b		nA1,	nD2,	nRst,	$0C,	nD1,	$03,	$03,	nD2
	dc.b		$03,	nRst,	nC2,	nCs2,	nRst,	nD2,	nRst,	nA1
	dc.b		nRst,	nAb1,	nRst,	nG1,	nFs1,	nF1,	nC1,	nC1
	dc.b		nC2,	nRst,	nBb1,	nB1,	nRst,	nC2,	nRst,	nG1
	dc.b		nRst,	nFs1,	nRst,	nF1,	nE1,	nEb1,	nD1,	nD1
	dc.b		nD2,	nRst,	nC2,	nCs2,	nRst,	nD2,	nRst,	nA1
	dc.b		nRst,	nAb1,	nRst,	nG1,	nFs1,	nF1,	nC1,	nC1
	dc.b		nC2,	nRst,	nBb1,	nB1,	nRst,	nC2,	nRst,	nG1
	dc.b		nRst,	nFs1,	nRst,	nF1,	nE1,	nEb1,	nD1,	nD1
	dc.b		nD2,	nRst,	nC2,	nCs2,	nRst,	nD2,	nRst,	nA1
	dc.b		nRst,	nAb1,	nRst,	nG1,	nFs1,	nF1,	nC1,	nC1
	dc.b		nC2,	nRst,	nBb1,	nB1,	nRst,	nC2,	nRst,	nG1
	dc.b		nRst,	nFs1,	nRst,	nF1,	nE1,	nEb1,	nD1,	nD1
	dc.b		nD2,	nRst,	nC2,	nCs2,	nRst,	nD2,	nRst,	nA1
	dc.b		nRst,	nAb1,	nRst,	nG1,	nFs1,	nF1,	nC2,	nC2
	dc.b		nRst,	nA1,	nD2,	nD2,	nRst,	nA1,	nA1,	nC2
	dc.b		nA1,	nD2,	nRst,	$0C,	nD1,	$06,	nD2,	nD1
	dc.b		$03,	$03,	nD2,	$06,	nD1,	nD2,	nD1,	$03
	dc.b		nE1,	nD1,	nC1,	$09,	nC2,	$06,	nC1,	nC2
	dc.b		$03,	nC1,	nC1,	$06,	nCs1,	nD1,	$03,	nA0
	dc.b		nRst,	nD1,	nRst,	nD1,	nG1,	nA1,	nD1,	nRst
	dc.b		nD2,	nRst,	nD2,	nC2,	nA1,	nG1,	$06,	nD1
	dc.b		$03,	nG1,	nA1,	nBb1,	nRst,	nBb1,	nRst,	nF2
	dc.b		nBb1,	$06,	nC2,	nG1,	$03,	nE1,	nC1,	nD2
	dc.b		nA1,	nF1,	nD1,	nF1,	$06,	nF2,	nF1,	$03
	dc.b		$03,	nF2,	$06,	nF1,	nF2,	nF1,	$03,	nE1
	dc.b		nD1,	nE1,	$09,	nE2,	$06,	nE1,	nE2,	$03
	dc.b		nE1,	nE1,	$06,	nF1,	nE1,	$03,	nC1,	nRst
	dc.b		nD1,	nRst,	nD1,	nG1,	nA1,	nD2,	nG1,	nA1
	dc.b		nD2,	nG1,	$06,	nF1,	nE1,	nC1,	nC2,	$03
	dc.b		$03,	nRst,	$03,	nA1,	nD2,	nD2,	nRst,	nA1
	dc.b		nA1,	nC2,	nA1,	nD2,	nRst,	$0C
;	Jump To	 	location
	smpsJump	MM2_Heat_Man_FM2

; FM3 Data
MM2_Heat_Man_FM3:
	dc.b		nRst,	$04
MM2_Heat_Man_Jump01:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nD3,	$03,	$03,	nD4,	$03,	nRst,	nC4,	nCs4
	dc.b		nRst,	nD4,	nRst,	nA3,	nRst,	nAb3,	nRst,	nG3
	dc.b		nFs3,	nF3,	nC3,	nC3,	nC4,	nRst,	nBb3,	nB3
	dc.b		nRst,	nC4,	nRst,	nG3,	nRst,	nFs3,	nRst,	nF3
	dc.b		nE3,	nEb3,	nD3,	nD3,	nD4,	nRst,	nC4,	nCs4
	dc.b		nRst,	nD4,	nRst,	nA3,	nRst,	nAb3,	nRst,	nG3
	dc.b		nFs3,	nF3,	nC3,	nC3,	nC4,	nRst,	nBb3,	nB3
	dc.b		nRst,	nC4,	nRst,	nG3,	nRst,	nFs3,	nRst,	nF3
	dc.b		nE3,	nEb3,	nD3,	nD3,	nD4,	nRst,	nC4,	nCs4
	dc.b		nRst,	nD4,	nRst,	nA3,	nRst,	nAb3,	nRst,	nG3
	dc.b		nFs3,	nF3,	nC3,	nC3,	nC4,	nRst,	nBb3,	nB3
	dc.b		nRst,	nC4,	nRst,	nG3,	nRst,	nFs3,	nRst,	nF3
	dc.b		nE3,	nEb3,	nD3,	nD3,	nD4,	nRst,	nC4,	nCs4
	dc.b		nRst,	nD4,	nRst,	nA3,	nRst,	nAb3,	nRst,	nG3
	dc.b		nFs3,	nF3,	nC4,	nC4,	nRst,	nA3,	nD4,	nD4
	dc.b		nRst,	nA3,	nA3,	nC4,	nA3,	nD4,	nRst,	$6F
	dc.b		nD4,	$03,	nF4,	nA4,	nD5,	nRst,	nA4,	nRst
	dc.b		nG4,	nA4,	nRst,	nG4,	nRst,	nD4,	nE4,	nF4
	dc.b		nD5,	nRst,	nD5,	nE5,	nF5,	nA5,	nRst,	nF5
	dc.b		nRst,	nA4,	nC5,	nD5,	nF5,	nE5,	nD5,	nC5
	dc.b		nRst,	$63,	nD4,	$03,	nF4,	nA4,	nD5,	nRst
	dc.b		nA4,	nRst,	nG4,	nA4,	nRst,	nG4,	nRst,	nD4
	dc.b		nE4,	nF4,	nE5,	nE5,	nRst,	nD5,	nF5,	nF5
	dc.b		nRst,	nD5,	nD5,	nE5,	nD5,	nF5,	nRst,	$0C
	dc.b		nD3,	$03,	$03,	nD4,	$03,	nRst,	nC4,	nCs4
	dc.b		nRst,	nD4,	nRst,	nA3,	nRst,	nAb3,	nRst,	nG3
	dc.b		nFs3,	nF3,	nC3,	nC3,	nC4,	nRst,	nBb3,	nB3
	dc.b		nRst,	nC4,	nRst,	nG3,	nRst,	nFs3,	nRst,	nF3
	dc.b		nE3,	nEb3,	nD3,	nD3,	nD4,	nRst,	nC4,	nCs4
	dc.b		nRst,	nD4,	nRst,	nA3,	nRst,	nAb3,	nRst,	nG3
	dc.b		nFs3,	nF3,	nC3,	nC3,	nC4,	nRst,	nBb3,	nB3
	dc.b		nRst,	nC4,	nRst,	nG3,	nRst,	nFs3,	nRst,	nF3
	dc.b		nE3,	nEb3,	nD3,	nD3,	nD4,	nRst,	nC4,	nCs4
	dc.b		nRst,	nD4,	nRst,	nA3,	nRst,	nAb3,	nRst,	nG3
	dc.b		nFs3,	nF3,	nC3,	nC3,	nC4,	nRst,	nBb3,	nB3
	dc.b		nRst,	nC4,	nRst,	nG3,	nRst,	nFs3,	nRst,	nF3
	dc.b		nE3,	nEb3,	nD3,	nD3,	nD4,	nRst,	nC4,	nCs4
	dc.b		nRst,	nD4,	nRst,	nA3,	nRst,	nAb3,	nRst,	nG3
	dc.b		nFs3,	nF3,	nC4,	nC4,	nRst,	nA3,	nD4,	nD4
	dc.b		nRst,	nA3,	nA3,	nC4,	nA3,	nD4,	nRst,	$6F
	dc.b		nD4,	$03,	nF4,	nA4,	nD5,	nRst,	nA4,	nRst
	dc.b		nG4,	nA4,	nRst,	nG4,	nRst,	nD4,	nE4,	nF4
	dc.b		nD5,	nRst,	nD5,	nE5,	nF5,	nA5,	nRst,	nF5
	dc.b		nRst,	nA4,	nC5,	nD5,	nF5,	nE5,	nD5,	nC5
	dc.b		nRst,	$63,	nD4,	$03,	nF4,	nA4,	nD5,	nRst
	dc.b		nA4,	nRst,	nG4,	nA4,	nRst,	nG4,	nRst,	nD4
	dc.b		nE4,	nF4,	nE5,	nE5,	nRst,	nD5,	nF5,	nF5
	dc.b		nRst,	nD5,	nD5,	nE5,	nD5,	nF5,	nRst,	$7F
	dc.b		$7F,	$7F,	$72,	nD4,	$03,	nF4,	nA4,	nD5
	dc.b		nRst,	nA4,	nRst,	nG4,	nA4,	nRst,	nG4,	nRst
	dc.b		nD4,	nE4,	nF4,	nD5,	nRst,	nD5,	nE5,	nF5
	dc.b		nA5,	nRst,	nF5,	nRst,	nA4,	nC5,	nD5,	nF5
	dc.b		nE5,	nD5,	nC5,	nRst,	$63,	nD4,	$03,	nF4
	dc.b		nA4,	nD5,	nRst,	nA4,	nRst,	nG4,	nA4,	nRst
	dc.b		nG4,	nRst,	nD4,	nE4,	nF4,	nE5,	nE5,	nRst
	dc.b		nD5,	nF5,	nF5,	nRst,	nD5,	nD5,	nE5,	nD5
	dc.b		nF5,	nRst,	$0C
;	Jump To	 	location
	smpsJump	MM2_Heat_Man_Jump01

; FM4 Data
MM2_Heat_Man_FM4:
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$44
MM2_Heat_Man_Jump02:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$0B
	dc.b		nA5,	$03,	nF5,	nC5,	nA4,	nA5,	nF5,	nC5
	dc.b		nA4,	nA5,	nF5,	nC5,	nA4,	nA5,	nF5,	nC5
	dc.b		nG5,	$06,	nE5,	$03,	nC5,	nG4,	nG5,	nE5
	dc.b		nC5,	nG4,	nG5,	nC5,	nA5,	nC5,	nG5,	nE5
	dc.b		nRst,	nD5,	nRst,	nG4,	nA4,	nD5,	nF5,	nRst
	dc.b		nD5,	nRst,	nE5,	nF5,	nRst,	nE5,	nRst,	nA4
	dc.b		nC5,	nD5,	nG4,	nG4,	nRst,	nF4,	nA4,	nA4
	dc.b		nRst,	nF4,	nF4,	nG4,	nF4,	nA4,	nRst,	$7F
	dc.b		$7F,	$7F,	$7F,	$50,	nA5,	$03,	nF5,	nC5
	dc.b		nA4,	nA5,	nF5,	nC5,	nA4,	nA5,	nF5,	nC5
	dc.b		nA4,	nA5,	nF5,	nC5,	nG5,	$06,	nE5,	$03
	dc.b		nC5,	nG4,	nG5,	nE5,	nC5,	nG4,	nG5,	nC5
	dc.b		nA5,	nC5,	nG5,	nE5,	nRst,	nD5,	nRst,	nG4
	dc.b		nA4,	nD5,	nF5,	nRst,	nD5,	nRst,	nE5,	nF5
	dc.b		nRst,	nE5,	nRst,	nA4,	nC5,	nD5,	nG4,	nG4
	dc.b		nRst,	nF4,	nA4,	nA4,	nRst,	nF4,	nF4,	nG4
	dc.b		nF4,	nA4,	nRst,	$7F,	$7F,	$7F,	$7F,	$50
	dc.b		nA5,	$03,	nF5,	nC5,	nA4,	nA5,	nF5,	nC5
	dc.b		nA4,	nA5,	nF5,	nC5,	nA4,	nA5,	nF5,	nC5
	dc.b		nG5,	$06,	nE5,	$03,	nC5,	nG4,	nG5,	nE5
	dc.b		nC5,	nG4,	nG5,	nC5,	nA5,	nC5,	nG5,	nE5
	dc.b		nRst,	nD5,	nRst,	nG4,	nA4,	nD5,	nF5,	nRst
	dc.b		nD5,	nRst,	nE5,	nF5,	nRst,	nE5,	nRst,	nA4
	dc.b		nC5,	nD5,	nG4,	nG4,	nRst,	nF4,	nA4,	nA4
	dc.b		nRst,	nF4,	nF4,	nG4,	nF4,	nA4,	nRst,	$7F
	dc.b		$7F,	$7F,	$7F,	$50
;	Jump To	 	location
	smpsJump	MM2_Heat_Man_Jump02

; FM5 Data
MM2_Heat_Man_FM5:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nD1,	$03,	$03,	nD2,	$03,	nRst,	nC2,	nCs2
	dc.b		nRst,	nD2,	nRst,	nA1,	nRst,	nAb1,	nRst,	nG1
	dc.b		nFs1,	nF1,	nC1,	nC1,	nC2,	nRst,	nBb1,	nB1
	dc.b		nRst,	nC2,	nRst,	nG1,	nRst,	nFs1,	nRst,	nF1
	dc.b		nE1,	nEb1,	nD1,	nD1,	nD2,	nRst,	nC2,	nCs2
	dc.b		nRst,	nD2,	nRst,	nA1,	nRst,	nAb1,	nRst,	nG1
	dc.b		nFs1,	nF1,	nC1,	nC1,	nC2,	nRst,	nBb1,	nB1
	dc.b		nRst,	nC2,	nRst,	nG1,	nRst,	nFs1,	nRst,	nF1
	dc.b		nE1,	nEb1,	nD1,	nD1,	nD2,	nRst,	nC2,	nCs2
	dc.b		nRst,	nD2,	nRst,	nA1,	nRst,	nAb1,	nRst,	nG1
	dc.b		nFs1,	nF1,	nC1,	nC1,	nC2,	nRst,	nBb1,	nB1
	dc.b		nRst,	nC2,	nRst,	nG1,	nRst,	nFs1,	nRst,	nF1
	dc.b		nE1,	nEb1,	nD1,	nD1,	nD2,	nRst,	nC2,	nCs2
	dc.b		nRst,	nD2,	nRst,	nA1,	nRst,	nAb1,	nRst,	nG1
	dc.b		nFs1,	nF1,	nC2,	nC2,	nRst,	nA1,	nD2,	nD2
	dc.b		nRst,	nA1,	nA1,	nC2,	nA1,	nD2,	nRst,	$0C
	dc.b		nD1,	$06,	nD2,	nD1,	$03,	$03,	nD2,	$06
	dc.b		nD1,	nD2,	nD1,	$03,	nE1,	nD1,	nC1,	$09
	dc.b		nC2,	$06,	nC1,	nC2,	$03,	nC1,	nC1,	$06
	dc.b		nCs1,	nD1,	$03,	nA0,	nRst,	nD1,	nRst,	nD1
	dc.b		nG1,	nA1,	nD1,	nRst,	nD2,	nRst,	nD2,	nC2
	dc.b		nA1,	nG1,	$06,	nD1,	$03,	nG1,	nA1,	nBb1
	dc.b		nRst,	nBb1,	nRst,	nF2,	nBb1,	$06,	nC2,	nG1
	dc.b		$03,	nE1,	nC1,	nD2,	nA1,	nF1,	nD1,	nF1
	dc.b		$06,	nF2,	nF1,	$03,	$03,	nF2,	$06,	nF1
	dc.b		nF2,	nF1,	$03,	nE1,	nD1,	nE1,	$09,	nE2
	dc.b		$06,	nE1,	nE2,	$03,	nE1,	nE1,	$06,	nF1
	dc.b		nE1,	$03,	nC1,	nRst,	nD1,	nRst,	nD1,	nG1
	dc.b		nA1,	nD2,	nG1,	nA1,	nD2,	nG1,	$06,	nF1
	dc.b		nE1,	nC1,	nC2,	$03,	$03,	nRst,	$03,	nA1
	dc.b		nD2,	nD2,	nRst,	nA1,	nA1,	nC2,	nA1,	nD2
	dc.b		nRst,	$0C,	nD1,	$03,	$03,	nD2,	$03,	nRst
	dc.b		nC2,	nCs2,	nRst,	nD2,	nRst,	nA1,	nRst,	nAb1
	dc.b		nRst,	nG1,	nFs1,	nF1,	nC1,	nC1,	nC2,	nRst
	dc.b		nBb1,	nB1,	nRst,	nC2,	nRst,	nG1,	nRst,	nFs1
	dc.b		nRst,	nF1,	nE1,	nEb1,	nD1,	nD1,	nD2,	nRst
	dc.b		nC2,	nCs2,	nRst,	nD2,	nRst,	nA1,	nRst,	nAb1
	dc.b		nRst,	nG1,	nFs1,	nF1,	nC1,	nC1,	nC2,	nRst
	dc.b		nBb1,	nB1,	nRst,	nC2,	nRst,	nG1,	nRst,	nFs1
	dc.b		nRst,	nF1,	nE1,	nEb1,	nD1,	nD1,	nD2,	nRst
	dc.b		nC2,	nCs2,	nRst,	nD2,	nRst,	nA1,	nRst,	nAb1
	dc.b		nRst,	nG1,	nFs1,	nF1,	nC1,	nC1,	nC2,	nRst
	dc.b		nBb1,	nB1,	nRst,	nC2,	nRst,	nG1,	nRst,	nFs1
	dc.b		nRst,	nF1,	nE1,	nEb1,	nD1,	nD1,	nD2,	nRst
	dc.b		nC2,	nCs2,	nRst,	nD2,	nRst,	nA1,	nRst,	nAb1
	dc.b		nRst,	nG1,	nFs1,	nF1,	nC2,	nC2,	nRst,	nA1
	dc.b		nD2,	nD2,	nRst,	nA1,	nA1,	nC2,	nA1,	nD2
	dc.b		nRst,	$0C,	nD1,	$06,	nD2,	nD1,	$03,	$03
	dc.b		nD2,	$06,	nD1,	nD2,	nD1,	$03,	nE1,	nD1
	dc.b		nC1,	$09,	nC2,	$06,	nC1,	nC2,	$03,	nC1
	dc.b		nC1,	$06,	nCs1,	nD1,	$03,	nA0,	nRst,	nD1
	dc.b		nRst,	nD1,	nG1,	nA1,	nD1,	nRst,	nD2,	nRst
	dc.b		nD2,	nC2,	nA1,	nG1,	$06,	nD1,	$03,	nG1
	dc.b		nA1,	nBb1,	nRst,	nBb1,	nRst,	nF2,	nBb1,	$06
	dc.b		nC2,	nG1,	$03,	nE1,	nC1,	nD2,	nA1,	nF1
	dc.b		nD1,	nF1,	$06,	nF2,	nF1,	$03,	$03,	nF2
	dc.b		$06,	nF1,	nF2,	nF1,	$03,	nE1,	nD1,	nE1
	dc.b		$09,	nE2,	$06,	nE1,	nE2,	$03,	nE1,	nE1
	dc.b		$06,	nF1,	nE1,	$03,	nC1,	nRst,	nD1,	nRst
	dc.b		nD1,	nG1,	nA1,	nD2,	nG1,	nA1,	nD2,	nG1
	dc.b		$06,	nF1,	nE1,	nC1,	nC2,	$03,	$03,	nRst
	dc.b		$03,	nA1,	nD2,	nD2,	nRst,	nA1,	nA1,	nC2
	dc.b		nA1,	nD2,	nRst,	$0C,	nD1,	$03,	$03,	nD2
	dc.b		$03,	nRst,	nC2,	nCs2,	nRst,	nD2,	nRst,	nA1
	dc.b		nRst,	nAb1,	nRst,	nG1,	nFs1,	nF1,	nC1,	nC1
	dc.b		nC2,	nRst,	nBb1,	nB1,	nRst,	nC2,	nRst,	nG1
	dc.b		nRst,	nFs1,	nRst,	nF1,	nE1,	nEb1,	nD1,	nD1
	dc.b		nD2,	nRst,	nC2,	nCs2,	nRst,	nD2,	nRst,	nA1
	dc.b		nRst,	nAb1,	nRst,	nG1,	nFs1,	nF1,	nC1,	nC1
	dc.b		nC2,	nRst,	nBb1,	nB1,	nRst,	nC2,	nRst,	nG1
	dc.b		nRst,	nFs1,	nRst,	nF1,	nE1,	nEb1,	nD1,	nD1
	dc.b		nD2,	nRst,	nC2,	nCs2,	nRst,	nD2,	nRst,	nA1
	dc.b		nRst,	nAb1,	nRst,	nG1,	nFs1,	nF1,	nC1,	nC1
	dc.b		nC2,	nRst,	nBb1,	nB1,	nRst,	nC2,	nRst,	nG1
	dc.b		nRst,	nFs1,	nRst,	nF1,	nE1,	nEb1,	nD1,	nD1
	dc.b		nD2,	nRst,	nC2,	nCs2,	nRst,	nD2,	nRst,	nA1
	dc.b		nRst,	nAb1,	nRst,	nG1,	nFs1,	nF1,	nC2,	nC2
	dc.b		nRst,	nA1,	nD2,	nD2,	nRst,	nA1,	nA1,	nC2
	dc.b		nA1,	nD2,	nRst,	$0C,	nD1,	$06,	nD2,	nD1
	dc.b		$03,	$03,	nD2,	$06,	nD1,	nD2,	nD1,	$03
	dc.b		nE1,	nD1,	nC1,	$09,	nC2,	$06,	nC1,	nC2
	dc.b		$03,	nC1,	nC1,	$06,	nCs1,	nD1,	$03,	nA0
	dc.b		nRst,	nD1,	nRst,	nD1,	nG1,	nA1,	nD1,	nRst
	dc.b		nD2,	nRst,	nD2,	nC2,	nA1,	nG1,	$06,	nD1
	dc.b		$03,	nG1,	nA1,	nBb1,	nRst,	nBb1,	nRst,	nF2
	dc.b		nBb1,	$06,	nC2,	nG1,	$03,	nE1,	nC1,	nD2
	dc.b		nA1,	nF1,	nD1,	nF1,	$06,	nF2,	nF1,	$03
	dc.b		$03,	nF2,	$06,	nF1,	nF2,	nF1,	$03,	nE1
	dc.b		nD1,	nE1,	$09,	nE2,	$06,	nE1,	nE2,	$03
	dc.b		nE1,	nE1,	$06,	nF1,	nE1,	$03,	nC1,	nRst
	dc.b		nD1,	nRst,	nD1,	nG1,	nA1,	nD2,	nG1,	nA1
	dc.b		nD2,	nG1,	$06,	nF1,	nE1,	nC1,	nC2,	$03
	dc.b		$03,	nRst,	$03,	nA1,	nD2,	nD2,	nRst,	nA1
	dc.b		nA1,	nC2,	nA1,	nD2,	nRst,	$0C
;	Jump To	 	location
	smpsJump	MM2_Heat_Man_FM5

; PSG1 Data
MM2_Heat_Man_PSG1:
	dc.b		nRst,	$7F,	$7F,	$58
MM2_Heat_Man_Jump03:
;	Set PSG Voice	#
	smpsPSGvoice	$03
	dc.b		nC5,	$03,	$03,	nRst,	$03,	nA4,	nD5,	nD5
	dc.b		nRst,	nA4,	nA4,	nC5,	nA4,	nD5,	nRst,	$0E
	dc.b		nA5,	$0C,	$0C,	$06,	$06,	$03,	nG5,	$03
	dc.b		nF5,	nG5,	$0F,	$09,	$03,	$03,	nRst,	$03
	dc.b		nA5,	nRst,	nG5,	nE5,	nRst,	nF5,	nRst,	$60
	dc.b		nA5,	$0C,	$0C,	$06,	$06,	$03,	nG5,	$03
	dc.b		nF5,	nG5,	$0F,	$09,	$03,	$03,	nRst,	$03
	dc.b		nA5,	nRst,	nG5,	nE5,	nRst,	nF5,	nRst,	$7F
	dc.b		$7F,	$7F,	$31,	nC5,	$03,	$03,	nRst,	$03
	dc.b		nA4,	nD5,	nD5,	nRst,	nA4,	nA4,	nC5,	nA4
	dc.b		nD5,	nRst,	$0E,	nA5,	$0C,	$0C,	$06,	$06
	dc.b		$03,	nG5,	$03,	nF5,	nG5,	$0F,	$09,	$03
	dc.b		$03,	nRst,	$03,	nA5,	nRst,	nG5,	nE5,	nRst
	dc.b		nF5,	nRst,	$60,	nA5,	$0C,	$0C,	$06,	$06
	dc.b		$03,	nG5,	$03,	nF5,	nG5,	$0F,	$09,	$03
	dc.b		$03,	nRst,	$03,	nA5,	nRst,	nG5,	nE5,	nRst
	dc.b		nF5,	nRst,	$7F,	$7F,	$7F,	$63,	nA5,	$0C
	dc.b		$0C,	$06,	$06,	$03,	nG5,	$03,	nF5,	nG5
	dc.b		$0F,	$09,	$03,	$03,	nRst,	$03,	nA5,	nRst
	dc.b		nG5,	nE5,	nRst,	nF5,	nRst,	$60,	nA5,	$0C
	dc.b		$0C,	$06,	$06,	$03,	nG5,	$03,	nF5,	nG5
	dc.b		$0F,	$09,	$03,	$03,	nRst,	$03,	nA5,	nRst
	dc.b		nG5,	nE5,	nRst,	nF5,	nRst,	$7F,	$7F,	$7F
	dc.b		$31
;	Jump To	 	location
	smpsJump	MM2_Heat_Man_Jump03

; PSG2 Data
MM2_Heat_Man_PSG2:
	dc.b		nRst,	$7F,	$7F,	$52
MM2_Heat_Man_Jump04:
;	Set PSG Voice	#
	smpsPSGvoice	$03
	dc.b		nC5,	$03,	$03,	nRst,	$03,	nA4,	nD5,	nD5
	dc.b		nRst,	nA4,	nA4,	nC5,	nA4,	nD5,	nRst,	$0C
	dc.b		nA5,	nA5,	nA5,	$06,	$06,	$03,	nG5,	$03
	dc.b		nF5,	nG5,	$0F,	$09,	$03,	$03,	nRst,	$03
	dc.b		nA5,	nRst,	nG5,	nE5,	nRst,	nF5,	nRst,	$60
	dc.b		nA5,	$0C,	$0C,	$06,	$06,	$03,	nG5,	$03
	dc.b		nF5,	nG5,	$0F,	$09,	$03,	$03,	nRst,	$03
	dc.b		nA5,	nRst,	nG5,	nE5,	nRst,	nF5,	nRst,	$7F
	dc.b		$7F,	$7F,	$33,	nC5,	$03,	$03,	nRst,	$03
	dc.b		nA4,	nD5,	nD5,	nRst,	nA4,	nA4,	nC5,	nA4
	dc.b		nD5,	nRst,	$0C,	nA5,	nA5,	nA5,	$06,	$06
	dc.b		$03,	nG5,	$03,	nF5,	nG5,	$0F,	$09,	$03
	dc.b		$03,	nRst,	$03,	nA5,	nRst,	nG5,	nE5,	nRst
	dc.b		nF5,	nRst,	$60,	nA5,	$0C,	$0C,	$06,	$06
	dc.b		$03,	nG5,	$03,	nF5,	nG5,	$0F,	$09,	$03
	dc.b		$03,	nRst,	$03,	nA5,	nRst,	nG5,	nE5,	nRst
	dc.b		nF5,	nRst,	$60,	nD4,	$03,	$03,	nD5,	$03
	dc.b		nRst,	nC5,	nCs5,	nRst,	nD5,	nRst,	nA4,	nRst
	dc.b		nAb4,	nRst,	nG4,	nFs4,	nF4,	nC4,	nC4,	nC5
	dc.b		nRst,	nBb4,	nB4,	nRst,	nC5,	nRst,	nG4,	nRst
	dc.b		nFs4,	nRst,	nF4,	nE4,	nEb4,	nD4,	nD4,	nD5
	dc.b		nRst,	nC5,	nCs5,	nRst,	nD5,	nRst,	nA4,	nRst
	dc.b		nAb4,	nRst,	nG4,	nFs4,	nF4,	nC4,	nC4,	nC5
	dc.b		nRst,	nBb4,	nB4,	nRst,	nC5,	nRst,	nG4,	nRst
	dc.b		nFs4,	nRst,	nF4,	nE4,	nEb4,	nD4,	nD4,	nD5
	dc.b		nRst,	nC5,	nCs5,	nRst,	nD5,	nRst,	nA4,	nRst
	dc.b		nAb4,	nRst,	nG4,	nFs4,	nF4,	nC4,	nC4,	nC5
	dc.b		nRst,	nBb4,	nB4,	nRst,	nC5,	nRst,	nG4,	nRst
	dc.b		nFs4,	nRst,	nF4,	nE4,	nEb4,	nD4,	nD4,	nD5
	dc.b		nRst,	nC5,	nCs5,	nRst,	nD5,	nRst,	nA4,	nRst
	dc.b		nAb4,	nRst,	nG4,	nFs4,	nF4,	nC5,	nC5,	nRst
	dc.b		nA4,	nD5,	nD5,	nRst,	nA4,	nA4,	nC5,	nA4
	dc.b		nD5,	nRst,	$0C,	nA5,	nA5,	nA5,	$06,	$06
	dc.b		$03,	nG5,	$03,	nF5,	nG5,	$0F,	$09,	$03
	dc.b		$03,	nRst,	$03,	nA5,	nRst,	nG5,	nE5,	nRst
	dc.b		nF5,	nRst,	$60,	nA5,	$0C,	$0C,	$06,	$06
	dc.b		$03,	nG5,	$03,	nF5,	nG5,	$0F,	$09,	$03
	dc.b		$03,	nRst,	$03,	nA5,	nRst,	nG5,	nE5,	nRst
	dc.b		nF5,	nRst,	$7F,	$7F,	$7F,	$33
;	Jump To	 	location
	smpsJump	MM2_Heat_Man_Jump04

; PSG3 Data
MM2_Heat_Man_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
	dc.b		nRst,	$7F,	$41
MM2_Heat_Man_Jump05:
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$03,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$03,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$7F,	$7F,	$7F,	$7F,	$53
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$03,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$03,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$7F,	$7F,	$7F,	$7F,	$53
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$03,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$03,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$7F,	$7F,	$7F,	$7F,	$53
;	Jump To	 	location
	smpsJump	MM2_Heat_Man_Jump05

; DAC Data
MM2_Heat_Man_DAC:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$09
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$09
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$09
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$09
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$09
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$09
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$06
	dc.b		$97,	$03,	nRst,	dSnare,	$97,	dSnare,	nRst,	dSnare
	dc.b		dSnare,	nRst,	$97,	nRst,	$09,	dSnare,	$03,	nRst
	dc.b		$09,	$97,	$03,	nRst,	$97,	nRst,	dSnare,	nRst
	dc.b		$09,	$97,	$03,	nRst,	$09,	dSnare,	$03,	nRst
	dc.b		$09,	$97,	$03,	nRst,	$97,	nRst,	dSnare,	nRst
	dc.b		$09,	$97,	$03,	nRst,	$09,	dSnare,	$03,	nRst
	dc.b		$09,	$97,	$03,	nRst,	$97,	nRst,	dSnare,	nRst
	dc.b		$09,	$97,	$03,	nRst,	$06,	$97,	$03,	dSnare
	dc.b		nRst,	$06,	$97,	$03,	dSnare,	dKick,	dKick,	dSnare
	dc.b		nRst,	$0C,	dKick,	$03,	nRst,	$09,	dKick,	$03
	dc.b		nRst,	$09,	dKick,	$03,	nRst,	$09,	dKick,	$03
	dc.b		nRst,	$09,	dKick,	$03,	nRst,	$09,	dKick,	$03
	dc.b		nRst,	$09,	dKick,	$03,	nRst,	$09,	dKick,	$03
	dc.b		nRst,	$06,	dKick,	$03,	nRst,	$06,	dKick,	$03
	dc.b		nRst,	dKick,	nRst,	$09,	dKick,	$03,	nRst,	$06
	dc.b		dKick,	$03,	nRst,	$06,	dKick,	$03,	nRst,	dKick
	dc.b		nRst,	$09,	dKick,	$03,	nRst,	$06,	dKick,	$03
	dc.b		nRst,	dSnare,	dKick,	nRst,	dSnare,	nRst,	$09,	dKick
	dc.b		$03,	nRst,	$09,	dSnare,	$03,	nRst,	$09,	dKick
	dc.b		$03,	nRst,	dKick,	nRst,	dSnare,	nRst,	$06,	dKick
	dc.b		$03,	nRst,	$06,	dKick,	$03,	nRst,	dSnare,	nRst
	dc.b		$09,	dKick,	$03,	nRst,	dKick,	nRst,	dSnare,	dKick
	dc.b		nRst,	dKick,	nRst,	dKick,	dKick,	nRst,	dSnare,	nRst
	dc.b		dKick,	nRst,	dKick,	dKick,	nRst,	dSnare,	nRst,	dKick
	dc.b		dSnare,	nRst,	dSnare,	dKick,	nRst,	dKick,	dSnare,	dKick
	dc.b		nRst,	dKick,	dKick,	dKick,	dKick,	dSnare,	nRst,	$0C
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$09
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$09
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$09
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$09
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$09
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$09
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$06
	dc.b		$97,	$03,	nRst,	dSnare,	$97,	dSnare,	nRst,	dSnare
	dc.b		dSnare,	nRst,	$97,	nRst,	$09,	dSnare,	$03,	nRst
	dc.b		$09,	$97,	$03,	nRst,	$97,	nRst,	dSnare,	nRst
	dc.b		$09,	$97,	$03,	nRst,	$09,	dSnare,	$03,	nRst
	dc.b		$09,	$97,	$03,	nRst,	$97,	nRst,	dSnare,	nRst
	dc.b		$09,	$97,	$03,	nRst,	$09,	dSnare,	$03,	nRst
	dc.b		$09,	$97,	$03,	nRst,	$97,	nRst,	dSnare,	nRst
	dc.b		$09,	$97,	$03,	nRst,	$06,	$97,	$03,	dSnare
	dc.b		nRst,	$06,	$97,	$03,	dSnare,	dKick,	dKick,	dSnare
	dc.b		nRst,	$0C,	dKick,	$03,	nRst,	$09,	dKick,	$03
	dc.b		nRst,	$09,	dKick,	$03,	nRst,	$09,	dKick,	$03
	dc.b		nRst,	$09,	dKick,	$03,	nRst,	$09,	dKick,	$03
	dc.b		nRst,	$09,	dKick,	$03,	nRst,	$09,	dKick,	$03
	dc.b		nRst,	$06,	dKick,	$03,	nRst,	$06,	dKick,	$03
	dc.b		nRst,	dKick,	nRst,	$09,	dKick,	$03,	nRst,	$06
	dc.b		dKick,	$03,	nRst,	$06,	dKick,	$03,	nRst,	dKick
	dc.b		nRst,	$09,	dKick,	$03,	nRst,	$06,	dKick,	$03
	dc.b		nRst,	dSnare,	dKick,	nRst,	dSnare,	nRst,	$09,	dKick
	dc.b		$03,	nRst,	$09,	dSnare,	$03,	nRst,	$09,	dKick
	dc.b		$03,	nRst,	dKick,	nRst,	dSnare,	nRst,	$06,	dKick
	dc.b		$03,	nRst,	$06,	dKick,	$03,	nRst,	dSnare,	nRst
	dc.b		$09,	dKick,	$03,	nRst,	dKick,	nRst,	dSnare,	dKick
	dc.b		nRst,	dKick,	nRst,	dKick,	dKick,	nRst,	dSnare,	nRst
	dc.b		dKick,	nRst,	dKick,	dKick,	nRst,	dSnare,	nRst,	dKick
	dc.b		dSnare,	nRst,	dSnare,	dKick,	nRst,	dKick,	dSnare,	dKick
	dc.b		nRst,	dKick,	dKick,	dKick,	dKick,	dSnare,	nRst,	$0C
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$09
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$09
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$09
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$09
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$09
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$09
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$06
	dc.b		$97,	$03,	nRst,	dSnare,	$97,	dSnare,	nRst,	dSnare
	dc.b		dSnare,	nRst,	$97,	nRst,	$09,	dSnare,	$03,	nRst
	dc.b		$09,	$97,	$03,	nRst,	$97,	nRst,	dSnare,	nRst
	dc.b		$09,	$97,	$03,	nRst,	$09,	dSnare,	$03,	nRst
	dc.b		$09,	$97,	$03,	nRst,	$97,	nRst,	dSnare,	nRst
	dc.b		$09,	$97,	$03,	nRst,	$09,	dSnare,	$03,	nRst
	dc.b		$09,	$97,	$03,	nRst,	$97,	nRst,	dSnare,	nRst
	dc.b		$09,	$97,	$03,	nRst,	$06,	$97,	$03,	dSnare
	dc.b		nRst,	$06,	$97,	$03,	dSnare,	dKick,	dKick,	dSnare
	dc.b		nRst,	$0C,	dKick,	$03,	nRst,	$09,	dKick,	$03
	dc.b		nRst,	$09,	dKick,	$03,	nRst,	$09,	dKick,	$03
	dc.b		nRst,	$09,	dKick,	$03,	nRst,	$09,	dKick,	$03
	dc.b		nRst,	$09,	dKick,	$03,	nRst,	$09,	dKick,	$03
	dc.b		nRst,	$06,	dKick,	$03,	nRst,	$06,	dKick,	$03
	dc.b		nRst,	dKick,	nRst,	$09,	dKick,	$03,	nRst,	$06
	dc.b		dKick,	$03,	nRst,	$06,	dKick,	$03,	nRst,	dKick
	dc.b		nRst,	$09,	dKick,	$03,	nRst,	$06,	dKick,	$03
	dc.b		nRst,	dSnare,	dKick,	nRst,	dSnare,	nRst,	$09,	dKick
	dc.b		$03,	nRst,	$09,	dSnare,	$03,	nRst,	$09,	dKick
	dc.b		$03,	nRst,	dKick,	nRst,	dSnare,	nRst,	$06,	dKick
	dc.b		$03,	nRst,	$06,	dKick,	$03,	nRst,	dSnare,	nRst
	dc.b		$09,	dKick,	$03,	nRst,	dKick,	nRst,	dSnare,	dKick
	dc.b		nRst,	dKick,	nRst,	dKick,	dKick,	nRst,	dSnare,	nRst
	dc.b		dKick,	nRst,	dKick,	dKick,	nRst,	dSnare,	nRst,	dKick
	dc.b		dSnare,	nRst,	dSnare,	dKick,	nRst,	dKick,	dSnare,	dKick
	dc.b		nRst,	dKick,	dKick,	dKick,	dKick,	dSnare,	nRst,	$0C
;	Jump To	 	location
	smpsJump	MM2_Heat_Man_DAC

MM2_Heat_Man_Voices:
;	Voice 00
;	$38,$0A,$70,$30,$00,$1F,$1F,$5F,$5F,$12,$0E,$0A,$0A,$00,$04,$04,$03,$26,$26,$26,$26,$23,$2D,$12,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$03,	$07,	$00
	smpsVcCoarseFreq	$00,	$00,	$00,	$0A
	smpsVcRateScale		$01,	$01,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$0A,	$0E,	$12
	smpsVcDecayRate2	$03,	$04,	$04,	$00
	smpsVcDecayLevel	$02,	$02,	$02,	$02
	smpsVcReleaseRate	$06,	$06,	$06,	$06
	smpsVcTotalLevel	$80,	$12,	$2D,	$23

;	Voice 01
;	$3A,$70,$76,$30,$71,$1F,$95,$1F,$1F,$0E,$0F,$05,$10,$07,$06,$06,$1F,$28,$47,$17,$F7,$1D,$11,$28,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$07,	$07
	smpsVcCoarseFreq	$01,	$00,	$06,	$00
	smpsVcRateScale		$00,	$00,	$02,	$00
	smpsVcAttackRate	$1F,	$1F,	$15,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$10,	$05,	$0F,	$0E
	smpsVcDecayRate2	$1F,	$06,	$06,	$07
	smpsVcDecayLevel	$0F,	$01,	$04,	$02
	smpsVcReleaseRate	$07,	$07,	$07,	$08
	smpsVcTotalLevel	$80,	$28,	$11,	$1D

;	Voice 02
;	$34,$7B,$71,$38,$32,$1F,$1F,$1F,$1F,$0A,$03,$03,$03,$00,$00,$00,$00,$28,$28,$28,$28,$10,$92,$32,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$07,	$07
	smpsVcCoarseFreq	$02,	$08,	$01,	$0B
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$03,	$03,	$03,	$0A
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$02,	$02,	$02,	$02
	smpsVcReleaseRate	$08,	$08,	$08,	$08
	smpsVcTotalLevel	$80,	$32,	$92,	$10
	even
