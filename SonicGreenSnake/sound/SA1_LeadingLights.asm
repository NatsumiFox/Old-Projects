; =============================================================================================
; Project Name:		SA1_Leading_Lights
; Created:		17th January 2014
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

SA1_Leading_Lights_Header:
;	Voice Pointer	location
	smpsHeaderVoice	SA1_Leading_Lights_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$02,	$09

;	DAC Pointer	location
	smpsHeaderDAC	SA1_Leading_Lights_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	SA1_Leading_Lights_FM1,	smpsPitch00,	$0C
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	SA1_Leading_Lights_FM2,	smpsPitch01hi,	$03
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	SA1_Leading_Lights_FM3,	smpsPitch00,	$14
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	SA1_Leading_Lights_FM4,	smpsPitch00,	$10
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	SA1_Leading_Lights_FM5,	smpsPitch00,	$10
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	SA1_Leading_Lights_PSG1,	smpsPitch03lo,	$08,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	SA1_Leading_Lights_PSG2,	smpsPitch03lo,	$08,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	SA1_Leading_Lights_PSG3,	smpsPitch00+$0B,	$03,	$00

; FM1 Data
SA1_Leading_Lights_FM1:
	dc.b		nRst,	$7F,	$7F,	$7A
SA1_Leading_Lights_Jump01:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nE4,	$04,	nRst,	nC5,	nRst,	nA4,	nRst,	$1C
	dc.b		nD5,	$04,	nRst,	nE5,	nRst,	$14,	nD5,	$04
	dc.b		nRst,	$0C,	nC5,	$04,	nRst,	nD5,	nRst,	nB4
	dc.b		nRst,	$1C,	nA4,	$04,	nRst,	nB4,	nG4,	nRst
	dc.b		nFs4,	nRst,	$18,	nE4,	$04,	nRst,	nC5,	nRst
	dc.b		nA4,	nRst,	$1C,	nD5,	$04,	nRst,	nE5,	nRst
	dc.b		$14,	nA4,	$01,	nAb4,	$0E,	nRst,	$01,	nF5
	dc.b		$04,	nRst,	nE5,	nRst,	$7F,	$35,	nE4,	$04
	dc.b		nRst,	nC5,	nRst,	nA4,	nRst,	$1C,	nD5,	$04
	dc.b		nRst,	nE5,	nRst,	$14,	nD5,	$04,	nRst,	$0C
	dc.b		nC5,	$04,	nRst,	nD5,	nRst,	nB4,	nRst,	$1C
	dc.b		nA4,	$04,	nRst,	nB4,	nG4,	nRst,	nFs4,	nRst
	dc.b		$18,	nE4,	$04,	nRst,	nC5,	nRst,	nA4,	nRst
	dc.b		$1C,	nD5,	$04,	nRst,	nE5,	nRst,	$14,	nA4
	dc.b		$01,	nAb4,	$0E,	nRst,	$01,	nE4,	$04,	nRst
	dc.b		nB4,	nRst,	nAb4,	nRst,	$1C,	nE5,	$08,	nD5
	dc.b		$02,	nCs5,	nC5,	$04,	nRst,	nB4,	nRst,	nE4
	dc.b		nRst,	$18
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nFs4,	$30,	nG4,	$18,	nA4,	nD5,	$48,	nRst
	dc.b		$10,	nE4,	$08,	nF4,	$20,	nA4,	$08,	nC5
	dc.b		nC5,	$18,	nB4,	nA4,	$10,	nE5,	nA4,	nG4
	dc.b		$30,	nA4,	$10,	nE5,	nA4,	nC5,	$18,	nD5
	dc.b		nE5,	$32,	nRst,	$1E,	$10,	nF4,	$20,	nA4
	dc.b		$08,	nD5,	nC5,	$18,	nB4,	nA4,	$10,	nE5
	dc.b		nA4,	nG4,	$30,	nA4,	$10,	nE5,	nA4,	nC5
	dc.b		$18,	nD5,	nE5,	$4C,	nRst,	$7F,	$4D
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nE4,	$04,	nRst,	nC5,	nRst,	nA4,	nRst,	$1C
	dc.b		nD5,	$04,	nRst,	nE5,	nRst,	$14,	nD5,	$04
	dc.b		nRst,	$0C,	nC5,	$04,	nRst,	nD5,	nRst,	nB4
	dc.b		nRst,	$1C,	nA4,	$04,	nRst,	nB4,	nG4,	nRst
	dc.b		nFs4,	nRst,	$18,	nE4,	$04,	nRst,	nC5,	nRst
	dc.b		nA4,	nRst,	$1C,	nD5,	$04,	nRst,	nE5,	nRst
	dc.b		$14,	nA4,	$01,	nAb4,	$0E,	nRst,	$01,	nF5
	dc.b		$04,	nRst,	nE5,	nRst,	$7F,	$35,	nE4,	$04
	dc.b		nRst,	nC5,	nRst,	nA4,	nRst,	$1C,	nD5,	$04
	dc.b		nRst,	nE5,	nRst,	$14,	nD5,	$04,	nRst,	$0C
	dc.b		nC5,	$04,	nRst,	nD5,	nRst,	nB4,	nRst,	$1C
	dc.b		nA4,	$04,	nRst,	nB4,	nG4,	nRst,	nFs4,	nRst
	dc.b		$18,	nE4,	$04,	nRst,	nC5,	nRst,	nA4,	nRst
	dc.b		$1C,	nD5,	$04,	nRst,	nE5,	nRst,	$14,	nA4
	dc.b		$01,	nAb4,	$0E,	nRst,	$01,	nE4,	$04,	nRst
	dc.b		nB4,	nRst,	nAb4,	nRst,	$1C,	nE5,	$08,	nD5
	dc.b		$02,	nCs5,	nC5,	$04,	nRst,	nB4,	nRst,	nE4
	dc.b		nRst,	$18
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nFs4,	$30,	nG4,	$18,	nA4,	nD5,	$48,	nRst
	dc.b		$10,	nE4,	$08,	nF4,	$20,	nA4,	$08,	nC5
	dc.b		nC5,	$18,	nB4,	nA4,	$10,	nE5,	nA4,	nG4
	dc.b		$30,	nA4,	$10,	nE5,	nA4,	nC5,	$18,	nD5
	dc.b		nE5,	$32,	nRst,	$1E,	$10,	nF4,	$20,	nA4
	dc.b		$08,	nD5,	nC5,	$18,	nB4,	nA4,	$10,	nE5
	dc.b		nA4,	nG4,	$30,	nA4,	$10,	nE5,	nA4,	nC5
	dc.b		$18,	nD5,	nE5,	$32,	nRst,	$1A,	nRst,	$7F
	dc.b		$7F,	$7F,	$0F
;	Jump To	 	location
	smpsJump	SA1_Leading_Lights_Jump01

; FM2 Data
SA1_Leading_Lights_FM2:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nA1,	$08,	nC2,	$04,	nRst,	$0C,	nE1,	$04
	dc.b		$04,	nRst,	$04,	nG1,	nRst,	nE1,	nA1,	$08
	dc.b		nC2,	$04,	nRst,	$0C,	nE2,	$04,	nD2,	nRst
	dc.b		nC2,	nRst,	nE1,	nA1,	$08,	nC2,	$04,	nRst
	dc.b		$0C,	nE1,	$04,	$04,	nRst,	$04,	nG1,	nRst
	dc.b		nE1,	nA1,	$08,	nC2,	$04,	nRst,	$0C,	nE2
	dc.b		$04,	nD2,	nRst,	nC2,	nRst,	nE1,	nA1,	$08
	dc.b		nC2,	$04,	nRst,	$0C,	nE1,	$04,	$04,	nRst
	dc.b		$04,	nG1,	nRst,	nE1,	nA1,	$08,	nC2,	$04
	dc.b		nRst,	$0C,	nE2,	$04,	nD2,	nRst,	nC2,	nRst
	dc.b		nE1,	nA1,	$08,	nC2,	$04,	nRst,	$0C,	nE1
	dc.b		$04,	$04,	nRst,	$04,	nG1,	nRst,	nE1,	nA1
	dc.b		$08,	nC2,	$04,	nRst,	$0C,	nE2,	$04,	nD2
	dc.b		nRst,	nC2,	nRst,	nE1,	nA1,	$08,	nC2,	$04
	dc.b		nRst,	$0C,	nE1,	$04,	$04,	nRst,	$04,	nG1
	dc.b		nRst,	nE1,	nA1,	$08,	nC2,	$04,	nRst,	$0C
	dc.b		nE2,	$04,	nD2,	nRst,	nC2,	nRst,	nE1,	nAb1
	dc.b		$08,	nB1,	$04,	nRst,	$0C,	nE1,	$04,	$04
	dc.b		nRst,	$04,	nAb1,	nRst,	nE1,	nAb1,	$08,	nB1
	dc.b		$04,	nRst,	$0C,	nE2,	$04,	nD2,	nRst,	nC2
	dc.b		nRst,	nE1,	nA1,	$08,	nC2,	$04,	nRst,	$0C
	dc.b		nE1,	$04,	$04,	nRst,	$04,	nG1,	nRst,	nE1
	dc.b		nA1,	$08,	nC2,	$04,	nRst,	$0C,	nE2,	$04
	dc.b		nD2,	nRst,	nC2,	nRst,	nE1,	nAb1,	$08,	nB1
	dc.b		$04,	nRst,	$0C,	nE1,	$04,	$04,	nRst,	$04
	dc.b		nAb1,	nRst,	nE1,	nAb1,	$08,	nB1,	$04,	nRst
	dc.b		$0C,	nE2,	$04,	nD2,	nRst,	nC2,	nRst,	nE1
	dc.b		nA1,	$08,	nC2,	$04,	nRst,	$0C,	nE1,	$04
	dc.b		$04,	nRst,	$04,	nG1,	nRst,	nE1,	nA1,	$08
	dc.b		nC2,	$04,	nRst,	$0C,	nE2,	$04,	nD2,	nRst
	dc.b		nC2,	nRst,	nE1,	nA1,	$08,	nC2,	$04,	nRst
	dc.b		$0C,	nE1,	$04,	$04,	nRst,	$04,	nG1,	nRst
	dc.b		nE1,	nA1,	$08,	nC2,	$04,	nRst,	$0C,	nE2
	dc.b		$04,	nD2,	nRst,	nC2,	nRst,	nE1,	nAb1,	$08
	dc.b		nB1,	$04,	nRst,	$0C,	nE1,	$04,	$04,	nRst
	dc.b		$04,	nAb1,	nRst,	nE1,	nAb1,	$08,	nB1,	$04
	dc.b		nRst,	$0C,	nE2,	$04,	nD2,	nRst,	nC2,	nRst
	dc.b		nE1,	nA1,	$08,	nC2,	$04,	nRst,	$0C,	nE1
	dc.b		$04,	$04,	nRst,	$04,	nG1,	nRst,	nE1,	nA1
	dc.b		$08,	nC2,	$04,	nRst,	$0C,	nE2,	$04,	nD2
	dc.b		nRst,	nC2,	nRst,	nE1,	nAb1,	$08,	nB1,	$04
	dc.b		nRst,	$0C,	nE1,	$04,	$04,	nRst,	$04,	nAb1
	dc.b		nRst,	nE1,	nAb1,	$08,	nB1,	$04,	nRst,	$0C
	dc.b		nE2,	$04,	nD2,	nRst,	nC2,	nRst,	nE1,	nA1
	dc.b		$08,	nC2,	$04,	nRst,	$0C,	nE1,	$04,	$04
	dc.b		nRst,	$04,	nG1,	nRst,	nE1,	nA1,	$08,	nC2
	dc.b		$04,	nRst,	$0C,	nE2,	$04,	nD2,	nRst,	nC2
	dc.b		nRst,	nE1,	nA1,	$08,	nC2,	$04,	nRst,	$0C
	dc.b		nE1,	$04,	$04,	nRst,	$04,	nG1,	nRst,	nE1
	dc.b		nA1,	$08,	nC2,	$04,	nRst,	$0C,	nE2,	$04
	dc.b		nD2,	nRst,	nC2,	nRst,	nE1,	nF1,	$30,	nG1
	dc.b		nF1,	nE1,	nF1,	nG1,	nF1,	nE1,	nF1,	$08
	dc.b		nC2,	$04,	nRst,	nF2,	nC2,	nRst,	nF1,	$08
	dc.b		nC2,	$04,	nRst,	nF1,	nG1,	$08,	nD2,	$04
	dc.b		nRst,	nG2,	nD2,	nRst,	nG1,	$08,	nD2,	$04
	dc.b		nRst,	nG1,	nF1,	$08,	nC2,	$04,	nRst,	nF2
	dc.b		nC2,	nRst,	nF1,	$08,	nC2,	$04,	nRst,	nF1
	dc.b		nG1,	$08,	nD2,	$04,	nRst,	nG2,	nD2,	nRst
	dc.b		nG1,	$08,	nD2,	$04,	nRst,	nG1,	nF1,	$08
	dc.b		nC2,	$04,	nRst,	nF2,	nC2,	nRst,	nF1,	$08
	dc.b		nC2,	$04,	nRst,	nF1,	nG1,	$08,	nD2,	$04
	dc.b		nRst,	nG2,	nD2,	nRst,	nG1,	$08,	nD2,	$04
	dc.b		nRst,	nG1,	nF1,	$08,	nC2,	$04,	nRst,	nF2
	dc.b		nC2,	nRst,	nF1,	$08,	nC2,	$04,	nRst,	nF1
	dc.b		nG1,	$08,	nD2,	$04,	nRst,	nG2,	nD2,	nRst
	dc.b		nG1,	$08,	nD2,	$04,	nRst,	nG1,	nA1,	$08
	dc.b		nC2,	$04,	nRst,	$0C,	nE1,	$04,	$04,	nRst
	dc.b		$04,	nG1,	nRst,	nE1,	nA1,	$08,	nC2,	$04
	dc.b		nRst,	$0C,	nE2,	$04,	nD2,	nRst,	nC2,	nRst
	dc.b		nE1,	nA1,	$08,	nC2,	$04,	nRst,	$0C,	nE1
	dc.b		$04,	$04,	nRst,	$04,	nG1,	nRst,	nE1,	nA1
	dc.b		$08,	nC2,	$04,	nRst,	$0C,	nE2,	$04,	nD2
	dc.b		nRst,	nC2,	nRst,	nE1,	nA1,	$08,	nC2,	$04
	dc.b		nRst,	$0C,	nE1,	$04,	$04,	nRst,	$04,	nG1
	dc.b		nRst,	nE1,	nA1,	$08,	nC2,	$04,	nRst,	$0C
	dc.b		nE2,	$04,	nD2,	nRst,	nC2,	nRst,	nE1,	nAb1
	dc.b		$08,	nB1,	$04,	nRst,	$0C,	nE1,	$04,	$04
	dc.b		nRst,	$04,	nAb1,	nRst,	nE1,	nAb1,	$08,	nB1
	dc.b		$04,	nRst,	$0C,	nE2,	$04,	nD2,	nRst,	nC2
	dc.b		nRst,	nE1,	nA1,	$08,	nC2,	$04,	nRst,	$0C
	dc.b		nE1,	$04,	$04,	nRst,	$04,	nG1,	nRst,	nE1
	dc.b		nA1,	$08,	nC2,	$04,	nRst,	$0C,	nE2,	$04
	dc.b		nD2,	nRst,	nC2,	nRst,	nE1,	nAb1,	$08,	nB1
	dc.b		$04,	nRst,	$0C,	nE1,	$04,	$04,	nRst,	$04
	dc.b		nAb1,	nRst,	nE1,	nAb1,	$08,	nB1,	$04,	nRst
	dc.b		$0C,	nE2,	$04,	nD2,	nRst,	nC2,	nRst,	nE1
	dc.b		nA1,	$08,	nC2,	$04,	nRst,	$0C,	nE1,	$04
	dc.b		$04,	nRst,	$04,	nG1,	nRst,	nE1,	nA1,	$08
	dc.b		nC2,	$04,	nRst,	$0C,	nE2,	$04,	nD2,	nRst
	dc.b		nC2,	nRst,	nE1,	nA1,	$08,	nC2,	$04,	nRst
	dc.b		$0C,	nE1,	$04,	$04,	nRst,	$04,	nG1,	nRst
	dc.b		nE1,	nA1,	$08,	nC2,	$04,	nRst,	$0C,	nE2
	dc.b		$04,	nD2,	nRst,	nC2,	nRst,	nE1,	nAb1,	$08
	dc.b		nB1,	$04,	nRst,	$0C,	nE1,	$04,	$04,	nRst
	dc.b		$04,	nAb1,	nRst,	nE1,	nAb1,	$08,	nB1,	$04
	dc.b		nRst,	$0C,	nE2,	$04,	nD2,	nRst,	nC2,	nRst
	dc.b		nE1,	nA1,	$08,	nC2,	$04,	nRst,	$0C,	nE1
	dc.b		$04,	$04,	nRst,	$04,	nG1,	nRst,	nE1,	nA1
	dc.b		$08,	nC2,	$04,	nRst,	$0C,	nE2,	$04,	nD2
	dc.b		nRst,	nC2,	nRst,	nE1,	nAb1,	$08,	nB1,	$04
	dc.b		nRst,	$0C,	nE1,	$04,	$04,	nRst,	$04,	nAb1
	dc.b		nRst,	nE1,	nAb1,	$08,	nB1,	$04,	nRst,	$0C
	dc.b		nE2,	$04,	nD2,	nRst,	nC2,	nRst,	nE1,	nA1
	dc.b		$08,	nC2,	$04,	nRst,	$0C,	nE1,	$04,	$04
	dc.b		nRst,	$04,	nG1,	nRst,	nE1,	nA1,	$08,	nC2
	dc.b		$04,	nRst,	$0C,	nE2,	$04,	nD2,	nRst,	nC2
	dc.b		nRst,	nE1,	nA1,	$08,	nC2,	$04,	nRst,	$0C
	dc.b		nE1,	$04,	$04,	nRst,	$04,	nG1,	nRst,	nE1
	dc.b		nA1,	$08,	nC2,	$04,	nRst,	$0C,	nE2,	$04
	dc.b		nD2,	nRst,	nC2,	nRst,	nE1,	nF1,	$30,	nG1
	dc.b		nF1,	nE1,	nF1,	nG1,	nF1,	nE1,	nF1,	$08
	dc.b		nC2,	$04,	nRst,	nF2,	nC2,	nRst,	nF1,	$08
	dc.b		nC2,	$04,	nRst,	nF1,	nG1,	$08,	nD2,	$04
	dc.b		nRst,	nG2,	nD2,	nRst,	nG1,	$08,	nD2,	$04
	dc.b		nRst,	nG1,	nF1,	$08,	nC2,	$04,	nRst,	nF2
	dc.b		nC2,	nRst,	nF1,	$08,	nC2,	$04,	nRst,	nF1
	dc.b		nG1,	$08,	nD2,	$04,	nRst,	nG2,	nD2,	nRst
	dc.b		nG1,	$08,	nD2,	$04,	nRst,	nG1,	nF1,	$08
	dc.b		nC2,	$04,	nRst,	nF2,	nC2,	nRst,	nF1,	$08
	dc.b		nC2,	$04,	nRst,	nF1,	nG1,	$08,	nD2,	$04
	dc.b		nRst,	nG2,	nD2,	nRst,	nG1,	$08,	nD2,	$04
	dc.b		nRst,	nG1,	nF1,	$08,	nC2,	$04,	nRst,	nF2
	dc.b		nC2,	nRst,	nF1,	$08,	nC2,	$04,	nRst,	nF1
	dc.b		nG1,	$08,	nD2,	$04,	nRst,	nG2,	nD2,	nRst
	dc.b		nG1,	$08,	nD2,	$04,	nRst,	nG1
;	Jump To	 	location
	smpsJump	SA1_Leading_Lights_FM2

; FM3 Data
SA1_Leading_Lights_FM3:
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nRst,	$7F,	$7F,	$7E
SA1_Leading_Lights_Jump02:
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nE4,	$04,	nRst,	nC5,	nRst,	nA4,	nRst,	$1C
	dc.b		nD5,	$04,	nRst,	nE5,	nRst,	$14,	nD5,	$04
	dc.b		nRst,	$0C,	nC5,	$04,	nRst,	nD5,	nRst,	nB4
	dc.b		nRst,	$1B,	nA4,	$04,	nRst,	nB4,	nG4,	nRst
	dc.b		nFs4,	nRst,	$18,	nE4,	$04,	nRst,	nC5,	nRst
	dc.b		nA4,	nRst,	$1C,	nD5,	$04,	nRst,	nE5,	nRst
	dc.b		$14,	nA4,	$01,	nAb4,	$0E,	nRst,	$01,	nF5
	dc.b		$04,	nRst,	nE5,	nRst,	$7F,	$36,	nE4,	$04
	dc.b		nRst,	nC5,	nRst,	nA4,	nRst,	$1C,	nD5,	$04
	dc.b		nRst,	nE5,	nRst,	$14,	nD5,	$04,	nRst,	$0C
	dc.b		nC5,	$04,	nRst,	nD5,	nRst,	nB4,	nRst,	$1C
	dc.b		nA4,	$04,	nRst,	nB4,	nG4,	nRst,	nFs4,	nRst
	dc.b		$18,	nE4,	$04,	nRst,	nC5,	nRst,	nA4,	nRst
	dc.b		$1C,	nD5,	$04,	nRst,	nE5,	nRst,	$14,	nA4
	dc.b		$01,	nAb4,	$0E,	nRst,	$01,	nE4,	$04,	nRst
	dc.b		nB4,	nRst,	nAb4,	nRst,	$1C,	nE5,	$08,	nD5
	dc.b		$02,	nCs5,	nC5,	$04,	nRst,	nB4,	nRst,	nE4
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$19,	nE4,	$04,	nRst,	nC5,	nRst
	dc.b		nA4,	nRst,	$1C,	nD5,	$04,	nRst,	nE5,	nRst
	dc.b		$14,	nD5,	$04,	nRst,	$0C,	nC5,	$04,	nRst
	dc.b		nD5,	nRst,	nB4,	nRst,	$1C,	nA4,	$04,	nRst
	dc.b		nB4,	nG4,	nRst,	nFs4,	nRst,	$18,	nE4,	$04
	dc.b		nRst,	nC5,	nRst,	nA4,	nRst,	$1C,	nD5,	$04
	dc.b		nRst,	nE5,	nRst,	$14,	nA4,	$01,	nAb4,	$0E
	dc.b		nRst,	$01,	nF5,	$04,	nRst,	nE5,	nRst,	$7F
	dc.b		$35,	nE4,	$04,	nRst,	nC5,	nRst,	nA4,	nRst
	dc.b		$1C,	nD5,	$04,	nRst,	nE5,	nRst,	$14,	nD5
	dc.b		$04,	nRst,	$0C,	nC5,	$04,	nRst,	nD5,	nRst
	dc.b		nB4,	nRst,	$1C,	nA4,	$04,	nRst,	nB4,	nG4
	dc.b		nRst,	nFs4,	nRst,	$18,	nE4,	$04,	nRst,	nC5
	dc.b		nRst,	nA4,	nRst,	$1C,	nD5,	$04,	nRst,	nE5
	dc.b		nRst,	$14,	nA4,	$01,	nAb4,	$0E,	nRst,	$01
	dc.b		nE4,	$04,	nRst,	nB4,	nRst,	nAb4,	nRst,	$1C
	dc.b		nE5,	$08,	nD5,	$02,	nCs5,	nC5,	$04,	nRst
	dc.b		nB4,	nRst,	nE4,	nRst,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$62
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nB4,	$18,	nC5,	$32,	nRst,	$1A,	nRst,	$7F
	dc.b		$7F,	$7F,	$13
;	Jump To	 	location
	smpsJump	SA1_Leading_Lights_Jump02

; FM4 Data
SA1_Leading_Lights_FM4:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nB3,	$04,	nE4,	nC4,	nG4,	nC4,	nFs4,	nB3
	dc.b		nE4,	nB3,	nG4,	nC4,	nFs4,	nB3,	nE4,	nC4
	dc.b		nG4,	nC4,	nFs4,	nB3,	nE4,	nB3,	nG4,	nC4
	dc.b		nFs4,	nD4,	nG4,	nE4,	nA4,	nE4,	nAb4,	nD4
	dc.b		nG4,	nD4,	nA4,	nE4,	nAb4,	nD4,	nG4,	nE4
	dc.b		nA4,	nE4,	nAb4,	nD4,	nG4,	nD4,	nA4,	nE4
	dc.b		nAb4,	nB3,	nE4,	nC4,	nG4,	nC4,	nFs4,	nB3
	dc.b		nE4,	nB3,	nG4,	nC4,	nFs4,	nB3,	nE4,	nC4
	dc.b		nG4,	nC4,	nFs4,	nB3,	nE4,	nB3,	nG4,	nC4
	dc.b		nFs4,	nD4,	nG4,	nE4,	nA4,	nE4,	nAb4,	nD4
	dc.b		nG4,	nD4,	nA4,	nE4,	nAb4,	nD4,	nG4,	nE4
	dc.b		nA4,	nE4,	nAb4,	nD4,	nG4,	nD4,	nA4,	nE4
	dc.b		nAb4,	nRst,	$30,	nC5,	$04,	nRst,	$2C,	nD4
	dc.b		$04,	nRst,	$2C,	nFs4,	$04,	nRst,	$5C,	nE4
	dc.b		$04,	nRst,	$2C,	nB4,	$04,	nRst,	$2C,	nB4
	dc.b		$04,	nRst,	$7F,	$3D,	nE4,	$04,	nRst,	$2C
	dc.b		nG4,	$04,	nRst,	$2C,	nFs4,	$04,	nRst,	$5C
	dc.b		nE4,	$04,	nRst,	$2C,	nD4,	$04,	nRst,	$2C
	dc.b		nB4,	$04,	nRst,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$29,	nD4,	$04,	nRst,	$2C,	nC5,	$04,	nRst
	dc.b		$0C,	nA4,	$04,	nRst,	$1C,	nD4,	$04,	nRst
	dc.b		$0C,	nG4,	$04,	nRst,	$1C,	nC5,	$04,	nRst
	dc.b		$0C,	nA4,	$04,	nRst,	$1C,	nD4,	$04,	nRst
	dc.b		$0C,	nG4,	$04,	nRst,	$1C,	nG4,	$04,	nRst
	dc.b		$0C,	nC5,	$04,	nRst,	$1C,	nAb4,	$04,	nRst
	dc.b		$0C,	nAb4,	$04,	nRst,	$14,	nB3,	$04,	nE4
	dc.b		nC4,	nG4,	nC4,	nFs4,	nB3,	nE4,	nB3,	nG4
	dc.b		nC4,	nFs4,	nB3,	nE4,	nC4,	nG4,	nC4,	nFs4
	dc.b		nB3,	nE4,	nB3,	nG4,	nC4,	nFs4,	nD4,	nG4
	dc.b		nE4,	nA4,	nE4,	nAb4,	nD4,	nG4,	nD4,	nA4
	dc.b		nE4,	nAb4,	nD4,	nG4,	nE4,	nA4,	nE4,	nAb4
	dc.b		nD4,	nG4,	nD4,	nA4,	nE4,	nAb4,	nRst,	$30
	dc.b		nE4,	$04,	nRst,	$2C,	nG4,	$04,	nRst,	$2C
	dc.b		nFs4,	$04,	nRst,	$5C,	nC5,	$04,	nRst,	$2C
	dc.b		nD4,	$04,	nRst,	$2C,	nB4,	$04,	nRst,	$7F
	dc.b		$3D,	nC5,	$04,	nRst,	$2C,	nD4,	$04,	nRst
	dc.b		$2C,	nFs4,	$04,	nRst,	$5C,	nC5,	$04,	nRst
	dc.b		$2C,	nB4,	$04,	nRst,	$2C,	nB4,	$04,	nRst
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$29,	nG4,	$04
	dc.b		nRst,	$2C,	nC5,	$04,	nRst,	$0C,	nC5,	$04
	dc.b		nRst,	$1C,	nG4,	$04,	nRst,	$0C,	nB4,	$04
	dc.b		nRst,	$1C,	nA4,	$04,	nRst,	$0C,	nA4,	$04
	dc.b		nRst,	$1C,	nG4,	$04,	nRst,	$0C,	nG4,	$04
	dc.b		nRst,	$1C,	nC5,	$04,	nRst,	$0C,	nC5,	$04
	dc.b		nRst,	$1C,	nAb4,	$04,	nRst,	$0C,	nAb4,	$04
	dc.b		nRst,	$14
;	Jump To	 	location
	smpsJump	SA1_Leading_Lights_FM4

; FM5 Data
SA1_Leading_Lights_FM5:
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nRst,	$7F,	$15
SA1_Leading_Lights_Jump03:
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nA4,	$04,	nC4,	nAb4,	nRst,	$7F,	$09,	nD4
	dc.b		$04,	nRst,	$7F,	$05,	nE4,	$04,	nRst,	$2C
	dc.b		nG4,	$04,	nRst,	$2C,	nEb4,	$04,	nRst,	$5C
	dc.b		nC5,	$04,	nRst,	$2C,	nD4,	$04,	nRst,	$2C
	dc.b		nD4,	$04,	nRst,	$7F,	$3D,	nC5,	$04,	nRst
	dc.b		$2C,	nD4,	$04,	nRst,	$2C,	nEb4,	$04,	nRst
	dc.b		$5C,	nC5,	$04,	nRst,	$2C,	nB4,	$04,	nRst
	dc.b		$2C,	nD4,	$04,	nRst,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$29,	nG4,	$04,	nRst,	$2C,	nA4,	$04
	dc.b		nRst,	$0C,	nC5,	$04,	nRst,	$1C,	nG4,	$04
	dc.b		nRst,	$0C,	nD4,	$04,	nRst,	$1C,	nA4,	$04
	dc.b		nRst,	$0C,	nC5,	$04,	nRst,	$1C,	nG4,	$04
	dc.b		nRst,	$0C,	nD4,	$04,	nRst,	$1C,	nC5,	$04
	dc.b		nRst,	$0C,	nG4,	$04,	nRst,	$1C,	nE4,	$04
	dc.b		nRst,	$0C,	nE4,	$04,	nRst,	$7F,	$7F,	$06
	dc.b		nC5,	$04,	nRst,	$2C,	nD4,	$04,	nRst,	$2C
	dc.b		nEb4,	$04,	nRst,	$5C,	nE4,	$04,	nRst,	$2C
	dc.b		nB4,	$04,	nRst,	$2C,	nD4,	$04,	nRst,	$7F
	dc.b		$3D,	nE4,	$04,	nRst,	$2C,	nG4,	$04,	nRst
	dc.b		$2C,	nEb4,	$04,	nRst,	$5C,	nE4,	$04,	nRst
	dc.b		$2C,	nD4,	$04,	nRst,	$2C,	nD4,	$04,	nRst
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$29,	nB4,	$04
	dc.b		nRst,	$2C,	nA4,	$04,	nRst,	$0C,	nA4,	$04
	dc.b		nRst,	$1C,	nB4,	$04,	nRst,	$0C,	nG4,	$04
	dc.b		nRst,	$1C,	nC5,	$04,	nRst,	$0C,	nC5,	$04
	dc.b		nRst,	$1C,	nB4,	$04,	nRst,	$0C,	nB4,	$04
	dc.b		nRst,	$1C,	nG4,	$04,	nRst,	$0C,	nG4,	$04
	dc.b		nRst,	$1C,	nC5,	$04,	nRst,	$0C,	nC5,	$04
	dc.b		nRst,	$7F,	$29
;	Jump To	 	location
	smpsJump	SA1_Leading_Lights_Jump03

; PSG1 Data
SA1_Leading_Lights_PSG1:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nE4,	$60,	nCs4,	nE4,	nA4,	nRst,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$66,	nE4,	$32,	nRst
	dc.b		$2E,	nG3,	$30,	nA3,	nRst,	$7F,	$7F,	$7F
	dc.b		$03,	nF4,	$30,	nD4,	$18,	nE4,	nF4,	$30
	dc.b		nG4,	$18,	nB4,	nF4,	$30,	nG4,	$18,	nB4
	dc.b		nG4,	$30,	nAb4,	nE4,	$32,	nRst,	$2E,	nA4
	dc.b		$32,	nRst,	$2E,	nRst,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$66,	nE4,	$32,	nRst,	$2E,	nE4
	dc.b		$32,	nRst,	$2E,	nRst,	$7F,	$7F,	$7F,	$03
	dc.b		nA4,	$30,	nC5,	$18,	nE5,	nA4,	$30,	nB4
	dc.b		$18,	nD5,	nF5,	$30,	nG5,	nC5,	$32,	nRst
	dc.b		$2E
;	Jump To	 	location
	smpsJump	SA1_Leading_Lights_PSG1

; PSG2 Data
SA1_Leading_Lights_PSG2:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nC4,	$60,	nF4,	nAb4,	nF4,	nEb5,	$04,	nD5
	dc.b		nEb5,	nD5,	nEb5,	nD5,	nEb5,	nD5,	nEb5,	nD5
	dc.b		nEb5,	nD5,	nRst,	$7F,	$11,	nEb5,	$04,	nD5
	dc.b		nEb5,	nD5,	nEb5,	nD5,	nEb5,	nD5,	nEb5,	nD5
	dc.b		nEb5,	nD5,	nRst,	$7F,	$11,	nB4,	$2E,	nRst
	dc.b		$02,	nG5,	$30,	nEb5,	$04,	nD5,	nEb5,	nD5
	dc.b		nEb5,	nD5,	nEb5,	nD5,	nEb5,	nD5,	nEb5,	nD5
	dc.b		nRst,	$7F,	$11,	nEb5,	$04,	nD5,	nEb5,	nD5
	dc.b		nEb5,	nD5,	nEb5,	nD5,	nEb5,	nD5,	nEb5,	nD5
	dc.b		nRst,	$7F,	$11,	nD5,	$30,	nC5,	nE4,	$32
	dc.b		nRst,	$2E,	nD4,	$30,	nE4,	nF4,	nE4,	nF4
	dc.b		nG4,	nA4,	nAb4,	nA4,	nC5,	$18,	nE5,	nA4
	dc.b		$30,	nB4,	$18,	nD5,	nF5,	$30,	nG5,	nC5
	dc.b		$32,	nRst,	$2E,	nAb4,	$32,	nRst,	$2E,	nF4
	dc.b		$32,	nRst,	$2E,	nEb5,	$04,	nD5,	nEb5,	nD5
	dc.b		nEb5,	nD5,	nEb5,	nD5,	nEb5,	nD5,	nEb5,	nD5
	dc.b		nRst,	$7F,	$11,	nEb5,	$04,	nD5,	nEb5,	nD5
	dc.b		nEb5,	nD5,	nEb5,	nD5,	nEb5,	nD5,	nEb5,	nD5
	dc.b		nRst,	$7F,	$11,	nB4,	$2E,	nRst,	$02,	nG5
	dc.b		$30,	nEb5,	$04,	nD5,	nEb5,	nD5,	nEb5,	nD5
	dc.b		nEb5,	nD5,	nEb5,	nD5,	nEb5,	nD5,	nRst,	$7F
	dc.b		$11,	nEb5,	$04,	nD5,	nEb5,	nD5,	nEb5,	nD5
	dc.b		nEb5,	nD5,	nEb5,	nD5,	nEb5,	nD5,	nRst,	$7F
	dc.b		$11,	nD5,	$30,	nC5,	nG4,	nA4,	nD4,	nE4
	dc.b		nF4,	nE4,	nF4,	nG4,	nA4,	nAb4,	nF4,	nD4
	dc.b		$18,	nE4,	nF4,	$30,	nG4,	$18,	nB4,	nF4
	dc.b		$30,	nG4,	$18,	nB4,	nG4,	$30,	nAb4
;	Jump To	 	location
	smpsJump	SA1_Leading_Lights_PSG2

; PSG3 Data
SA1_Leading_Lights_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
SA1_Leading_Lights_Jump04:
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$02,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04,	nRst,	$0C,	nAb6,	$04,	nRst,	$14
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$02,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04,	nRst,	$14,	nAb6,	$04,	nRst,	nAb6
	dc.b		nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$02,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04,	nRst,	$0C,	nAb6,	$04,	nRst,	$14
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$02,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04,	nRst,	$14,	nAb6,	$04,	nRst,	nAb6
	dc.b		nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$02,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04,	nRst,	$0C,	nAb6,	$04,	nRst,	nAb6
	dc.b		nRst,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$02,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04,	nRst,	$14,	nAb6,	$04,	nRst,	nAb6
	dc.b		nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$02,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04,	nRst,	$0C,	nAb6,	$04,	nRst,	nAb6
	dc.b		nRst,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$02,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04,	nRst,	$14
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	$1A,	nAb6,	$02,	nRst,	nAb6
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	$06,	nAb6,	$02
	dc.b		nRst,	$1A
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$02,	nRst,	$06,	nAb6,	$02,	nRst,	$06,	nAb6
	dc.b		$02,	nRst,	$1A,	nAb6,	$02,	nRst,	nAb6,	nRst
	dc.b		$06,	nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst
	dc.b		$0E,	nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	$06,	nAb6,	$02,	nRst
	dc.b		$06,	nAb6,	$02,	nRst,	$1A,	nAb6,	$02,	nRst
	dc.b		nAb6,	nRst,	$06,	nAb6,	$02,	nRst,	$06,	nAb6
	dc.b		$02,	nRst,	$1A
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$02,	nRst,	$06,	nAb6,	$02,	nRst,	$06,	nAb6
	dc.b		$02,	nRst,	$1A,	nAb6,	$02,	nRst,	nAb6,	nRst
	dc.b		$06,	nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst
	dc.b		$0E,	nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$02,	nRst,	$16,	nAb6,	$02,	nRst,	$12,	nAb6
	dc.b		$02,	nRst,	nAb6,	nRst,	$1E,	nAb6,	$02,	nRst
	dc.b		$06,	nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst
	dc.b		$06,	nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst
	dc.b		$1A,	nAb6,	$02,	nRst,	nAb6,	nRst,	$06,	nAb6
	dc.b		$02,	nRst,	$06,	nAb6,	$02,	nRst,	$1A,	nAb6
	dc.b		$02,	nRst,	nAb6,	nRst,	$06,	nAb6,	$02,	nRst
	dc.b		$06,	nAb6,	$02,	nRst,	$1A,	nAb6,	$02,	nRst
	dc.b		nAb6,	nRst,	$06,	nAb6,	$02,	nRst,	$06,	nAb6
	dc.b		$02,	nRst,	$0E,	nAb6,	$02,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$02,	nRst,	$02,	nAb6,	nRst,	$06,	nAb6,	$02
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	$1A,	nAb6,	$02
	dc.b		nRst,	nAb6,	nRst,	$06,	nAb6,	$02,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	$1A,	nAb6,	$02,	nRst,	nAb6
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	$06,	nAb6,	$02
	dc.b		nRst,	$1A,	nAb6,	$02,	nRst,	nAb6,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	$0E
	dc.b		nAb6,	$02,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$02,	nRst,	$02,	nAb6,	nRst,	$06,	nAb6,	$02
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	$1A,	nAb6,	$02
	dc.b		nRst,	nAb6,	nRst,	$06,	nAb6,	$02,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	$1A,	nAb6,	$02,	nRst,	nAb6
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	$06,	nAb6,	$02
	dc.b		nRst,	$1A,	nAb6,	$02,	nRst,	nAb6,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	$0E
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	nAb6
	dc.b		nRst,	$7F,	$7F,	$64,	nAb6,	$02,	nRst,	$0E
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	$06,	nAb6,	$02,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	$1A,	nAb6,	$02,	nRst,	nAb6
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	$06,	nAb6,	$02
	dc.b		nRst,	$1A,	nAb6,	$02,	nRst,	nAb6,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	$1A
	dc.b		nAb6,	$02,	nRst,	nAb6,	nRst,	$06,	nAb6,	$02
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	$0E,	nAb6,	$02
	dc.b		nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$02,	nRst,	$02,	nAb6,	nRst,	$06,	nAb6,	$02
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	$12,	nAb6,	$02
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	nAb6,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	$1A
	dc.b		nAb6,	$02,	nRst,	nAb6,	nRst,	$06,	nAb6,	$02
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	$12,	nAb6,	$02
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	nAb6,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	$0E
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04,	nRst,	$0C,	nAb6,	$04,	nRst,	nAb6
	dc.b		nRst,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$02,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04,	nRst,	$14,	nAb6,	$04,	nRst,	nAb6
	dc.b		nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$02,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04,	nRst,	$0C,	nAb6,	$04,	nRst,	nAb6
	dc.b		nRst,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$02,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04,	nRst,	$14
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	$1A,	nAb6,	$02,	nRst,	nAb6
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	$06,	nAb6,	$02
	dc.b		nRst,	$1A
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$02,	nRst,	$06,	nAb6,	$02,	nRst,	$06,	nAb6
	dc.b		$02,	nRst,	$1A,	nAb6,	$02,	nRst,	nAb6,	nRst
	dc.b		$06,	nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst
	dc.b		$0E,	nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	$06,	nAb6,	$02,	nRst
	dc.b		$06,	nAb6,	$02,	nRst,	$1A,	nAb6,	$02,	nRst
	dc.b		nAb6,	nRst,	$06,	nAb6,	$02,	nRst,	$06,	nAb6
	dc.b		$02,	nRst,	$1A
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$02,	nRst,	$06,	nAb6,	$02,	nRst,	$06,	nAb6
	dc.b		$02,	nRst,	$1A,	nAb6,	$02,	nRst,	nAb6,	nRst
	dc.b		$06,	nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst
	dc.b		$0E,	nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$02,	nRst,	$16,	nAb6,	$02,	nRst,	$12,	nAb6
	dc.b		$02,	nRst,	nAb6,	nRst,	$1E,	nAb6,	$02,	nRst
	dc.b		$06,	nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst
	dc.b		$06,	nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst
	dc.b		$1A,	nAb6,	$02,	nRst,	nAb6,	nRst,	$06,	nAb6
	dc.b		$02,	nRst,	$06,	nAb6,	$02,	nRst,	$1A,	nAb6
	dc.b		$02,	nRst,	nAb6,	nRst,	$06,	nAb6,	$02,	nRst
	dc.b		$06,	nAb6,	$02,	nRst,	$1A,	nAb6,	$02,	nRst
	dc.b		nAb6,	nRst,	$06,	nAb6,	$02,	nRst,	$06,	nAb6
	dc.b		$02,	nRst,	$0E,	nAb6,	$02,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$02,	nRst,	$02,	nAb6,	nRst,	$06,	nAb6,	$02
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	$1A,	nAb6,	$02
	dc.b		nRst,	nAb6,	nRst,	$06,	nAb6,	$02,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	$1A,	nAb6,	$02,	nRst,	nAb6
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	$06,	nAb6,	$02
	dc.b		nRst,	$1A,	nAb6,	$02,	nRst,	nAb6,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	$0E
	dc.b		nAb6,	$02,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$02,	nRst,	$02,	nAb6,	nRst,	$06,	nAb6,	$02
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	$1A,	nAb6,	$02
	dc.b		nRst,	nAb6,	nRst,	$06,	nAb6,	$02,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	$1A,	nAb6,	$02,	nRst,	nAb6
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	$06,	nAb6,	$02
	dc.b		nRst,	$1A,	nAb6,	$02,	nRst,	nAb6,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	$0E
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	nAb6
	dc.b		nRst,	$7F,	$7F,	$64,	nAb6,	$02,	nRst,	$0E
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	$06,	nAb6,	$02,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	$1A,	nAb6,	$02,	nRst,	nAb6
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	$06,	nAb6,	$02
	dc.b		nRst,	$1A,	nAb6,	$02,	nRst,	nAb6,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	$1A
	dc.b		nAb6,	$02,	nRst,	nAb6,	nRst,	$06,	nAb6,	$02
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	$0E,	nAb6,	$02
	dc.b		nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$02,	nRst,	$02,	nAb6,	nRst,	$06,	nAb6,	$02
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	$12,	nAb6,	$02
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	nAb6,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	$1A
	dc.b		nAb6,	$02,	nRst,	nAb6,	nRst,	$06,	nAb6,	$02
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	$12,	nAb6,	$02
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	nAb6,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	$0E
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	nAb6
	dc.b		nRst
;	Jump To	 	location
	smpsJump	SA1_Leading_Lights_Jump04

; DAC Data
SA1_Leading_Lights_DAC:
	dc.b		nRst,	$7F,	$7F,	$52
SA1_Leading_Lights_Jump05:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dKick,	$04,	nRst,	dKick,	nRst,	dSnare,	nRst,	dKick
	dc.b		dSnare,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dKick
	dc.b		nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dSnare,	nRst
	dc.b		dKick,	dKick,	nRst,	dKick,	nRst,	dSnare,	nRst,	dKick
	dc.b		dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dKick
	dc.b		nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dSnare,	nRst
	dc.b		dKick,	dKick,	nRst,	dKick,	nRst,	dSnare,	nRst,	dKick
	dc.b		dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dKick
	dc.b		nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dSnare,	nRst
	dc.b		dKick,	dKick,	nRst,	dKick,	nRst,	dSnare,	nRst,	dKick
	dc.b		dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dKick
	dc.b		nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dSnare,	nRst
	dc.b		dKick,	dKick,	nRst,	dKick,	nRst,	dSnare,	nRst,	dKick
	dc.b		dKick,	nRst,	dSnare,	nRst,	dKick,	nRst,	$48,	dKick
	dc.b		$04,	dSnare,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst
	dc.b		dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dSnare
	dc.b		nRst,	dKick,	dKick,	nRst,	dKick,	nRst,	dSnare,	nRst
	dc.b		dKick,	dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst
	dc.b		dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dSnare
	dc.b		nRst,	dKick,	dKick,	nRst,	dKick,	nRst,	dSnare,	nRst
	dc.b		dKick,	dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst
	dc.b		dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dSnare
	dc.b		nRst,	dKick,	dKick,	nRst,	dKick,	nRst,	dSnare,	nRst
	dc.b		dKick,	dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst
	dc.b		dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dSnare
	dc.b		nRst,	dKick,	dKick,	$03,	nRst,	$05,	dKick,	$04
	dc.b		nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dSnare,	nRst
	dc.b		dKick,	dKick,	nRst,	dKick,	nRst,	dSnare,	nRst,	dKick
	dc.b		dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dKick
	dc.b		nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dSnare,	nRst
	dc.b		dKick,	dKick,	nRst,	dKick,	nRst,	dSnare,	nRst,	dKick
	dc.b		dSnare,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dKick
	dc.b		nRst,	dSnare,	dSnare,	dKick,	dSnare,	dSnare,	nRst,	$08
	dc.b		dKick,	$04,	nRst,	$08,	dKick2,	$04,	nRst,	dKick2
	dc.b		nRst,	$08,	dKick2,	$04,	nRst,	$08,	dKick2,	$04
	dc.b		nRst,	$0C,	dKick2,	$04,	nRst,	dKick2,	nRst,	$08
	dc.b		dKick2,	$04,	nRst,	$08,	dKick2,	$04,	nRst,	$0C
	dc.b		dKick2,	$04,	nRst,	dKick2,	nRst,	$08,	dKick2,	$04
	dc.b		nRst,	$08,	dKick2,	$04,	nRst,	$0C,	dKick2,	$04
	dc.b		nRst,	dKick2,	nRst,	$08,	dKick2,	$04,	nRst,	$08
	dc.b		dKick2,	$04,	nRst,	$0C,	dKick2,	$04,	$01,	nRst
	dc.b		$07,	dKick2,	$04,	nRst,	$08,	dKick2,	$04,	dKick2
	dc.b		nRst,	$10,	dKick2,	$04,	nRst,	dKick2,	nRst,	$08
	dc.b		dKick2,	$04,	nRst,	$08,	dKick2,	$04,	nRst,	$0C
	dc.b		dKick2,	$04,	$01,	nRst,	$07,	dKick2,	$04,	nRst
	dc.b		$08,	dKick2,	$04,	dKick2,	nRst,	$10,	dKick2,	$04
	dc.b		nRst,	dKick,	nRst,	dSnare,	dKick,	nRst,	dKick,	dSnare
	dc.b		dKick,	dKick,	nRst,	dKick,	nRst,	dSnare,	nRst,	dKick
	dc.b		dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dKick
	dc.b		nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dSnare,	nRst
	dc.b		dKick,	dKick,	nRst,	dKick,	nRst,	dSnare,	nRst,	dKick
	dc.b		dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dKick
	dc.b		nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dSnare,	nRst
	dc.b		dKick,	dKick,	nRst,	dKick,	nRst,	dSnare,	nRst,	dKick
	dc.b		dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dKick
	dc.b		nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dSnare,	nRst
	dc.b		dKick,	dKick,	nRst,	dKick,	nRst,	dSnare,	nRst,	dKick
	dc.b		dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dKick
	dc.b		nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dSnare,	nRst
	dc.b		dKick,	nRst,	$7F,	$11,	dKick,	$04,	nRst,	dKick
	dc.b		nRst,	dSnare,	nRst,	dKick,	dSnare,	nRst,	dSnare,	nRst
	dc.b		dKick,	dKick,	nRst,	dKick,	nRst,	dSnare,	nRst,	dKick
	dc.b		dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dKick
	dc.b		nRst,	dSnare,	nRst,	dKick,	dKick,	$08,	dSnare,	$04
	dc.b		nRst,	dKick,	dKick,	$08,	$04,	nRst,	$04,	dSnare
	dc.b		nRst,	dKick,	dKick,	$08,	dSnare,	$04,	nRst,	dKick
	dc.b		dKick,	$08,	$04,	nRst,	$04,	dSnare,	nRst,	dKick
	dc.b		dKick,	$08,	dSnare,	$04,	nRst,	dKick,	dKick,	nRst
	dc.b		dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dSnare
	dc.b		nRst,	dKick,	dKick,	nRst,	dKick,	nRst,	dSnare,	nRst
	dc.b		dKick,	dKick,	$08,	dSnare,	$04,	nRst,	dKick,	dKick
	dc.b		nRst,	dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	$08
	dc.b		dSnare,	$04,	nRst,	dKick,	dKick,	$08,	$04,	nRst
	dc.b		$04,	dSnare,	nRst,	dKick,	dKick,	$08,	dSnare,	$04
	dc.b		nRst,	dKick,	nRst,	$48,	dKick,	$04,	dSnare,	nRst
	dc.b		dSnare,	nRst,	dKick,	dKick,	$08,	$04,	nRst,	$04
	dc.b		dSnare,	nRst,	dKick,	dKick,	nRst,	dSnare,	nRst,	dKick
	dc.b		dKick,	nRst,	dKick,	nRst,	dSnare,	nRst,	dKick,	dKick
	dc.b		$08,	dSnare,	$04,	nRst,	dKick,	dKick,	nRst,	dKick
	dc.b		nRst,	dSnare,	nRst,	dKick,	dKick,	$08,	dSnare,	$04
	dc.b		nRst,	dKick,	dKick,	nRst,	dKick,	nRst,	dSnare,	nRst
	dc.b		dKick,	dKick,	$08,	dSnare,	$04,	nRst,	dKick,	dKick
	dc.b		nRst,	dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst
	dc.b		dSnare,	nRst,	dKick,	dKick,	nRst,	dKick,	nRst,	dSnare
	dc.b		nRst,	dKick,	dKick,	$08,	dSnare,	$04,	nRst,	dKick
	dc.b		dKick,	nRst,	dKick,	nRst,	dSnare,	nRst,	dKick,	dKick
	dc.b		$08,	dSnare,	$04,	nRst,	dKick,	dKick,	$08,	$04
	dc.b		nRst,	$04,	dSnare,	nRst,	dKick,	dKick,	nRst,	dSnare
	dc.b		nRst,	dKick,	dKick,	nRst,	dKick,	nRst,	dSnare,	nRst
	dc.b		dKick,	dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst
	dc.b		dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	$08,	dSnare
	dc.b		$04,	nRst,	dKick,	dKick,	nRst,	dKick,	nRst,	dSnare
	dc.b		nRst,	dKick,	dSnare,	nRst,	dSnare,	nRst,	dKick,	dKick
	dc.b		nRst,	dKick,	nRst,	dSnare,	dSnare,	dKick,	dSnare,	dSnare
	dc.b		nRst,	$08,	dKick,	$04,	nRst,	$08,	dKick2,	$04
	dc.b		nRst,	dKick2,	nRst,	$08,	dKick2,	$04,	nRst,	$08
	dc.b		dKick2,	$04,	nRst,	$0C,	dKick2,	$04,	nRst,	dKick2
	dc.b		nRst,	$08,	dKick2,	$04,	nRst,	$08,	dKick2,	$04
	dc.b		nRst,	$0C,	dKick2,	$04,	nRst,	dKick2,	nRst,	$08
	dc.b		dKick2,	$04,	nRst,	$08,	dKick2,	$04,	nRst,	$0C
	dc.b		dKick2,	$04,	nRst,	dKick2,	nRst,	$08,	dKick2,	$04
	dc.b		nRst,	$08,	dKick2,	$04,	nRst,	$0C,	dKick2,	$04
	dc.b		$08,	dKick2,	$04,	nRst,	$08,	dKick2,	$04,	dKick2
	dc.b		nRst,	$10,	dKick2,	$04,	nRst,	dKick2,	nRst,	$08
	dc.b		dKick2,	$04,	nRst,	$08,	dKick2,	$04,	nRst,	$0C
	dc.b		dKick2,	$04,	$08,	dKick2,	$04,	nRst,	$08,	dKick2
	dc.b		$04,	dKick2,	nRst,	$10,	dKick2,	$04,	nRst,	dKick
	dc.b		nRst,	dSnare,	dKick,	nRst,	dKick,	dSnare,	dKick,	dKick
	dc.b		nRst,	dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	nRst
	dc.b		dSnare,	nRst,	dKick,	dKick,	$08,	$04,	nRst,	$04
	dc.b		dSnare,	nRst,	dKick,	dKick,	$08,	dSnare,	$04,	nRst
	dc.b		dKick,	dKick,	$08,	$04,	nRst,	$04,	dSnare,	nRst
	dc.b		dKick,	dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	$08
	dc.b		$04,	nRst,	$04,	dSnare,	nRst,	dKick,	dKick,	$08
	dc.b		dSnare,	$04,	nRst,	dKick,	dKick,	nRst,	dKick,	nRst
	dc.b		dSnare,	nRst,	dKick,	dKick,	$08,	dSnare,	$04,	nRst
	dc.b		dKick,	dKick,	$08,	$04,	nRst,	$04,	dSnare,	nRst
	dc.b		dKick,	dKick,	$08,	dSnare,	$04,	nRst,	dKick,	dKick
	dc.b		$08,	$04,	nRst,	$04,	dSnare,	nRst,	dKick,	dKick
	dc.b		$08,	dSnare,	$04,	nRst,	dKick,	dKick,	nRst,	dKick
	dc.b		nRst,	dSnare,	nRst,	dKick,	dKick,	nRst,	dSnare,	nRst
	dc.b		dKick,	$7F,	nRst,	$7F,	$56
;	Jump To	 	location
	smpsJump	SA1_Leading_Lights_Jump05

SA1_Leading_Lights_Voices:
;	Voice 00
;	$26,$00,$00,$01,$02,$9F,$1F,$9F,$1F,$08,$01,$11,$14,$0E,$02,$0E,$0A,$D8,$48,$F8,$F8,$0D,$0E,$0E,$00
;				#
	smpsVcAlgorithm		$06
	smpsVcFeedback		$04
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$02,	$01,	$00,	$00
	smpsVcRateScale		$00,	$02,	$00,	$02
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$14,	$11,	$01,	$08
	smpsVcDecayRate2	$0A,	$0E,	$02,	$0E
	smpsVcDecayLevel	$0F,	$0F,	$04,	$0D
	smpsVcReleaseRate	$08,	$08,	$08,	$08
	smpsVcTotalLevel	$00,	$0E,	$0E,	$0D

;	Voice 01
;	$1C,$EF,$31,$31,$31,$9F,$DB,$9E,$5E,$0F,$07,$06,$06,$08,$0A,$0B,$00,$8A,$86,$F6,$F7,$28,$12,$2A,$00
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$03
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$03,	$0E
	smpsVcCoarseFreq	$01,	$01,	$01,	$0F
	smpsVcRateScale		$01,	$02,	$03,	$02
	smpsVcAttackRate	$1E,	$1E,	$1B,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$06,	$06,	$07,	$0F
	smpsVcDecayRate2	$00,	$0B,	$0A,	$08
	smpsVcDecayLevel	$0F,	$0F,	$08,	$08
	smpsVcReleaseRate	$07,	$06,	$06,	$0A
	smpsVcTotalLevel	$00,	$2A,	$12,	$28

;	Voice 02
;	$23,$03,$01,$02,$01,$12,$1A,$1A,$1E,$18,$1F,$1C,$11,$0C,$0B,$0C,$09,$69,$39,$37,$26,$1B,$13,$10,$00
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$04
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$02,	$01,	$03
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1E,	$1A,	$1A,	$12
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$11,	$1C,	$1F,	$18
	smpsVcDecayRate2	$09,	$0C,	$0B,	$0C
	smpsVcDecayLevel	$02,	$03,	$03,	$06
	smpsVcReleaseRate	$06,	$07,	$09,	$09
	smpsVcTotalLevel	$00,	$10,	$13,	$1B

;	Voice 03
;	$3A,$61,$08,$51,$02,$1F,$14,$16,$1F,$04,$0F,$1F,$1F,$00,$00,$00,$00,$1A,$5B,$0A,$0A,$1B,$2E,$23,$86
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$05,	$00,	$06
	smpsVcCoarseFreq	$02,	$01,	$08,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$16,	$14,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$1F,	$0F,	$04
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$00,	$05,	$01
	smpsVcReleaseRate	$0A,	$0A,	$0B,	$0A
	smpsVcTotalLevel	$86,	$23,	$2E,	$1B
	even
