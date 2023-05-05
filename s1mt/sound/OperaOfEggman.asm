; =============================================================================================
; Project Name:		OperaOfEggman
; Created:		4th May 2015
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

OperaOfEggman_Header:
;	Voice Pointer	location
	smpsHeaderVoice	OperaOfEggman_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$02,	$0F

;	DAC Pointer	location
	smpsHeaderDAC	OperaOfEggman_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	OperaOfEggman_FM1,	smpsPitch00,	$0E
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	OperaOfEggman_FM2,	smpsPitch00,	$0E
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	OperaOfEggman_FM3,	smpsPitch00,	$11
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	OperaOfEggman_FM4,	smpsPitch00,	$0E
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	OperaOfEggman_FM5,	smpsPitch00,	$0F
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	OperaOfEggman_PSG1,	smpsPitch00,	$02,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	OperaOfEggman_PSG2,	smpsPitch00,	$03,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	OperaOfEggman_PSG3,	smpsPitch00,	$04,	$00

; DAC Data
OperaOfEggman_DAC:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dKick,	$0C,	dKick,	$0C,	dKick,	$0C,	dKick,	$0C
	dc.b		dKick,	$0C,	dKick,	$0C,	dKick,	$0C,	dKick,	$0C
	dc.b		dKick,	$0C,	dKick,	$0C,	dKick,	$0C,	dKick,	$0C
	dc.b		dKick,	$0C,	dKick,	$0C,	dKick,	$0C,	dSnare,	$03
	dc.b		dSnare,	$03,	dSnare,	$03,	dSnare,	$03
OperaOfEggman_Jump01:
	dc.b		dKick,	$0C,	dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C
	dc.b		dKick,	$0C,	dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C
	dc.b		dKick,	$0C,	dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C
	dc.b		dKick,	$0C,	dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C
	dc.b		dKick,	$0C,	dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C
	dc.b		dKick,	$0C,	dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C
	dc.b		dKick,	$0C,	dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C
	dc.b		dKick,	$0C,	dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C
	dc.b		dKick,	$0C,	dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C
	dc.b		dKick,	$0C,	dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C
	dc.b		dKick,	$0C,	dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C
	dc.b		dKick,	$0C,	dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C
	dc.b		dKick,	$0C,	dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C
	dc.b		dKick,	$0C,	dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C
	dc.b		dKick,	$0C,	dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C
	dc.b		dKick,	$0C,	dSnare,	$0C,	dKick,	$0C,	dSnare,	$03
	dc.b		dSnare,	$03,	dSnare,	$03,	dSnare,	$03,	dKick,	$0C
	dc.b		dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C,	dKick,	$0C
	dc.b		dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C,	dKick,	$0C
	dc.b		dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C,	dKick,	$0C
	dc.b		dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C,	dKick,	$0C
	dc.b		dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C,	dKick,	$0C
	dc.b		dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C,	dKick,	$0C
	dc.b		dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C,	dKick,	$0C
	dc.b		dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C,	dKick,	$0C
	dc.b		dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C,	dKick,	$0C
	dc.b		dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C,	dKick,	$0C
	dc.b		dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C,	dKick,	$0C
	dc.b		dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C,	dKick,	$0C
	dc.b		dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C,	dKick,	$0C
	dc.b		dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C,	dKick,	$0C
	dc.b		dSnare,	$0C,	dKick,	$0C,	dSnare,	$0C,	dKick,	$0C
	dc.b		dSnare,	$0C,	dKick,	$0C,	dSnare,	$03,	dSnare,	$03
	dc.b		dSnare,	$03,	dSnare,	$03
;	Jump To	 	location
	smpsJump	OperaOfEggman_Jump01

; FM1 Data
OperaOfEggman_FM1:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Notes	value
	smpsAlterNote	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nG2,	$03,	nE2,	$03,	nE2,	$03,	nE2,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nG2,	$03,	nE2,	$03,	nE2,	$03,	nE2,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nG2,	$03,	nE2,	$03,	nE2,	$03,	nE2,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nG2,	$03,	nE2,	$03,	nE2,	$03,	nE2,	$03
OperaOfEggman_Jump02:
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB1,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB1,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB1,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB1,	$03,	nRst,	$03
	dc.b		nA2,	$03,	nRst,	$03,	nE3,	$03,	nRst,	$03
	dc.b		nA2,	$03,	nRst,	$03,	nE3,	$03,	nRst,	$03
	dc.b		nA2,	$03,	nRst,	$03,	nE3,	$03,	nRst,	$03
	dc.b		nA2,	$03,	nRst,	$03,	nE2,	$03,	nRst,	$03
	dc.b		nA2,	$03,	nRst,	$03,	nE3,	$03,	nRst,	$03
	dc.b		nA2,	$03,	nRst,	$03,	nE3,	$03,	nRst,	$03
	dc.b		nA2,	$03,	nRst,	$03,	nE3,	$03,	nRst,	$03
	dc.b		nA2,	$03,	nRst,	$03,	nE2,	$03,	nRst,	$03
	dc.b		nA2,	$03,	nRst,	$03,	nE3,	$03,	nRst,	$03
	dc.b		nA2,	$03,	nRst,	$03,	nE3,	$03,	nRst,	$03
	dc.b		nA2,	$03,	nRst,	$03,	nE3,	$03,	nRst,	$03
	dc.b		nA2,	$03,	nRst,	$03,	nE2,	$03,	nRst,	$03
	dc.b		nA2,	$03,	nRst,	$03,	nE3,	$03,	nRst,	$03
	dc.b		nA2,	$03,	nRst,	$03,	nE3,	$03,	nRst,	$03
	dc.b		nA2,	$03,	nRst,	$03,	nE3,	$03,	nRst,	$03
	dc.b		nA2,	$03,	nRst,	$03,	nE2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB1,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB1,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB1,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB2,	$03,	nRst,	$03
	dc.b		nE2,	$03,	nRst,	$03,	nB1,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nF2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nF2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nF2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nA1,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nF2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nF2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nF2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nA1,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nF2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nF2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nF2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nA1,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nF2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nF2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nF2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nA1,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nCs2,	$03,	nRst,	$03,	nCs2,	$03,	nRst,	$03
	dc.b		nCs2,	$03,	nRst,	$03,	nCs2,	$03,	nRst,	$03
	dc.b		nCs2,	$03,	nRst,	$03,	nCs2,	$03,	nRst,	$03
	dc.b		nCs2,	$03,	nRst,	$03,	nCs2,	$03,	nRst,	$03
	dc.b		nCs2,	$03,	nRst,	$03,	nCs2,	$03,	nRst,	$03
	dc.b		nCs2,	$03,	nRst,	$03,	nCs2,	$03,	nRst,	$03
	dc.b		nCs2,	$03,	nRst,	$03,	nCs2,	$03,	nRst,	$03
	dc.b		nCs2,	$03,	nRst,	$03,	nCs2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nCs2,	$03,	nRst,	$03,	nCs2,	$03,	nRst,	$03
	dc.b		nCs2,	$03,	nRst,	$03,	nCs2,	$03,	nRst,	$03
	dc.b		nCs2,	$03,	nRst,	$03,	nCs2,	$03,	nRst,	$03
	dc.b		nCs2,	$03,	nRst,	$03,	nCs2,	$03,	nRst,	$03
	dc.b		nCs2,	$03,	nRst,	$03,	nCs2,	$03,	nRst,	$03
	dc.b		nCs2,	$03,	nRst,	$03,	nCs2,	$03,	nRst,	$03
	dc.b		nCs2,	$03,	nRst,	$03,	nCs2,	$03,	nRst,	$03
	dc.b		nCs2,	$03,	nRst,	$03,	nCs2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
	dc.b		nD2,	$03,	nRst,	$03,	nD2,	$03,	nRst,	$03
;	Jump To	 	location
	smpsJump	OperaOfEggman_Jump02

; FM2 Data
OperaOfEggman_FM2:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Notes	value
	smpsAlterNote	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nRst,	$7F,	$41
OperaOfEggman_Jump03:
	dc.b		nE4,	$24,	nB3,	$24,	nG3,	$24,	nB3,	$24
	dc.b		nG3,	$30,	nE5,	$24,	nB4,	$24,	nG4,	$24
	dc.b		nB4,	$24,	nE4,	$30,	nE4,	$24,	nB3,	$24
	dc.b		nG3,	$24,	nB3,	$24,	nG3,	$30,	nF4,	$24
	dc.b		nD4,	$24,	nA3,	$24,	nF3,	$24,	nD3,	$30
	dc.b		nD4,	$60,	nCs4,	$60,	nD4,	$60,	nCs4,	$60
	dc.b		nRst,	$7F,	$7F,	$7F,	$03
;	Jump To	 	location
	smpsJump	OperaOfEggman_Jump03

; FM3 Data
OperaOfEggman_FM3:
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Notes	value
	smpsAlterNote	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nRst,	$7F,	$41
OperaOfEggman_Jump04:
	dc.b		nE3,	$18,	nG3,	$18,	nB3,	$18,	nE3,	$18
	dc.b		nE3,	$18,	nG3,	$18,	nE3,	$18,	nB2,	$18
	dc.b		nA3,	$18,	nC4,	$18,	nE4,	$18,	nA3,	$18
	dc.b		nA3,	$18,	nC4,	$18,	nA3,	$18,	nE3,	$18
	dc.b		nE3,	$18,	nG3,	$18,	nB3,	$18,	nE3,	$18
	dc.b		nE3,	$18,	nG3,	$18,	nE3,	$18,	nB2,	$18
	dc.b		nF3,	$18,	nA3,	$18,	nD4,	$18,	nF3,	$18
	dc.b		nF3,	$18,	nA3,	$18,	nF3,	$18,	nD3,	$18
	dc.b		nRst,	$7F,	$7F,	$7F,	$03,	nD2,	$18,	nEb2
	dc.b		$18,	nE2,	$18,	nEb2,	$18,	nD2,	$18,	nEb2
	dc.b		$18,	nE2,	$18,	nEb2,	$18,	nD2,	$18,	nEb2
	dc.b		$18,	nE2,	$18,	nEb2,	$18,	nD2,	$18,	nEb2
	dc.b		$18,	nE2,	$18,	nEb2,	$18
;	Jump To	 	location
	smpsJump	OperaOfEggman_Jump04

; FM4 Data
OperaOfEggman_FM4:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Notes	value
	smpsAlterNote	$00
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nE2,	$06,	nB2,	$06,	nE2,	$06,	nB2,	$06
	dc.b		nE2,	$06,	nB2,	$06,	nG2,	$06,	nG2,	$06
	dc.b		nE2,	$06,	nB2,	$06,	nE2,	$06,	nB2,	$06
	dc.b		nE2,	$06,	nB2,	$06,	nG2,	$06,	nG2,	$06
	dc.b		nE2,	$06,	nB2,	$06,	nE2,	$06,	nB2,	$06
	dc.b		nE2,	$06,	nB2,	$06,	nG2,	$06,	nG2,	$06
	dc.b		nE2,	$06,	nB2,	$06,	nE2,	$06,	nB2,	$06
	dc.b		nE2,	$06,	nB2,	$06,	nG2,	$06,	nG2,	$06
OperaOfEggman_Jump05:
	dc.b		nE2,	$03,	nE2,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB1,	$03,	nB1,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB1,	$03,	nB1,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB1,	$03,	nB1,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB1,	$03,	nB1,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB1,	$03,	nB1,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB1,	$03,	nB1,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB1,	$03,	nB1,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB1,	$03,	nB1,	$03
	dc.b		nA2,	$03,	nA2,	$03,	nE3,	$03,	nE3,	$03
	dc.b		nA2,	$03,	nA2,	$03,	nE3,	$03,	nE3,	$03
	dc.b		nA2,	$03,	nA2,	$03,	nE2,	$03,	nE2,	$03
	dc.b		nA2,	$03,	nA2,	$03,	nE2,	$03,	nE2,	$03
	dc.b		nA2,	$03,	nA2,	$03,	nE3,	$03,	nE3,	$03
	dc.b		nA2,	$03,	nA2,	$03,	nE3,	$03,	nE3,	$03
	dc.b		nA2,	$03,	nA2,	$03,	nE2,	$03,	nE2,	$03
	dc.b		nA2,	$03,	nA2,	$03,	nE2,	$03,	nE2,	$03
	dc.b		nA2,	$03,	nA2,	$03,	nE3,	$03,	nE3,	$03
	dc.b		nA2,	$03,	nA2,	$03,	nE3,	$03,	nE3,	$03
	dc.b		nA2,	$03,	nA2,	$03,	nE2,	$03,	nE2,	$03
	dc.b		nA2,	$03,	nA2,	$03,	nE2,	$03,	nE2,	$03
	dc.b		nA2,	$03,	nA2,	$03,	nE3,	$03,	nE3,	$03
	dc.b		nA2,	$03,	nA2,	$03,	nE3,	$03,	nE3,	$03
	dc.b		nA2,	$03,	nA2,	$03,	nE2,	$03,	nE2,	$03
	dc.b		nA2,	$03,	nA2,	$03,	nE2,	$03,	nE2,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB1,	$03,	nB1,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB1,	$03,	nB1,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB1,	$03,	nB1,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB1,	$03,	nB1,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB1,	$03,	nB1,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB1,	$03,	nB1,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB2,	$03,	nB2,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB1,	$03,	nB1,	$03
	dc.b		nE2,	$03,	nE2,	$03,	nB1,	$03,	nB1,	$03
	dc.b		nF2,	$03,	nF2,	$03,	nA2,	$03,	nA2,	$03
	dc.b		nF2,	$03,	nF2,	$03,	nA2,	$03,	nA2,	$03
	dc.b		nF2,	$03,	nF2,	$03,	nA1,	$03,	nA1,	$03
	dc.b		nF2,	$03,	nF2,	$03,	nA1,	$03,	nA1,	$03
	dc.b		nF2,	$03,	nF2,	$03,	nA2,	$03,	nA2,	$03
	dc.b		nF2,	$03,	nF2,	$03,	nA2,	$03,	nA2,	$03
	dc.b		nF2,	$03,	nF2,	$03,	nA1,	$03,	nA1,	$03
	dc.b		nF2,	$03,	nF2,	$03,	nA1,	$03,	nA1,	$03
	dc.b		nF2,	$03,	nF2,	$03,	nA2,	$03,	nA2,	$03
	dc.b		nF2,	$03,	nF2,	$03,	nA2,	$03,	nA2,	$03
	dc.b		nF2,	$03,	nF2,	$03,	nA1,	$03,	nA1,	$03
	dc.b		nF2,	$03,	nF2,	$03,	nA1,	$03,	nA1,	$03
	dc.b		nF2,	$03,	nF2,	$03,	nA2,	$03,	nA2,	$03
	dc.b		nF2,	$03,	nF2,	$03,	nA2,	$03,	nA2,	$03
	dc.b		nF2,	$03,	nF2,	$03,	nA1,	$03,	nA1,	$03
	dc.b		nF2,	$03,	nF2,	$03,	nA1,	$03,	nA1,	$03
	dc.b		nRst,	$7F,	$7F,	$7F,	$03,	nD2,	$18,	nEb2
	dc.b		$18,	nE2,	$18,	nEb2,	$18,	nD2,	$18,	nEb2
	dc.b		$18,	nE2,	$18,	nEb2,	$18,	nD2,	$0C,	nEb2
	dc.b		$0C,	nE2,	$0C,	nEb2,	$0C,	nE2,	$0C,	nEb2
	dc.b		$0C,	nE2,	$0C,	nF2,	$0C,	nFs2,	$0C,	nF2
	dc.b		$0C,	nFs2,	$0C,	nF2,	$0C,	nFs2,	$0C,	nF2
	dc.b		$0C,	nE2,	$0C,	nEb2,	$0C
;	Jump To	 	location
	smpsJump	OperaOfEggman_Jump05

; FM5 Data
OperaOfEggman_FM5:
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Notes	value
	smpsAlterNote	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nRst,	$7F,	$41
OperaOfEggman_Jump06:
	dc.b		nE1,	$7F,	smpsNoAttack,	$41,	nA1,	$7F,	smpsNoAttack,	$41
	dc.b		nE1,	$7F,	smpsNoAttack,	$41,	nF1,	$7F,	smpsNoAttack,	$44
	dc.b		nRst,	$7F,	$7F,	$7F,	nD1,	$60,	nD1,	$03
	dc.b		nRst,	$5D,	nD1,	$03,	nRst,	$5D,	nD1,	$03
	dc.b		nRst,	$5D
;	Jump To	 	location
	smpsJump	OperaOfEggman_Jump06

; PSG1 Data
OperaOfEggman_PSG1:
;	Alter Notes	value
	smpsAlterNote	$00
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nRst,	$7F,	$41
OperaOfEggman_Jump07:
	dc.b		nE1,	$18,	nG1,	$18,	nB1,	$18,	nE1,	$18
	dc.b		nE1,	$18,	nG1,	$18,	nE1,	$18,	nB0,	$18
	dc.b		nA1,	$18,	nC2,	$18,	nE2,	$18,	nA1,	$18
	dc.b		nA1,	$18,	nC2,	$18,	nA1,	$18,	nE1,	$18
	dc.b		nE1,	$18,	nG1,	$18,	nB1,	$18,	nE1,	$18
	dc.b		nE1,	$18,	nG1,	$18,	nE1,	$18,	nB0,	$18
	dc.b		nF1,	$18,	nA1,	$18,	nD2,	$18,	nF1,	$18
	dc.b		nF1,	$18,	nA1,	$18,	nF1,	$18,	nD1,	$18
	dc.b		nD3,	$0C,	nC3,	$0C,	nBb2,	$0C,	nA2,	$0C
	dc.b		nD3,	$0C,	nC3,	$0C,	nBb2,	$0C,	nA2,	$0C
	dc.b		nD3,	$0C,	nC3,	$0C,	nBb2,	$0C,	nA2,	$0C
	dc.b		nD3,	$0C,	nC3,	$0C,	nBb2,	$0C,	nA2,	$0C
	dc.b		nD3,	$0C,	nC3,	$0C,	nBb2,	$0C,	nA2,	$0C
	dc.b		nD3,	$0C,	nC3,	$0C,	nBb2,	$0C,	nA2,	$0C
	dc.b		nD3,	$0C,	nC3,	$0C,	nBb2,	$0C,	nA2,	$0C
	dc.b		nD3,	$0C,	nC3,	$0C,	nBb2,	$0C,	nA2,	$0C
	dc.b		nA2,	$0C,	nBb2,	$0C,	nA2,	$0C,	nA2,	$0C
	dc.b		nA2,	$0C,	nBb2,	$0C,	nC3,	$0C,	nBb2,	$0C
	dc.b		nA2,	$0C,	nBb2,	$0C,	nA2,	$0C,	nA2,	$0C
	dc.b		nA2,	$0C,	nBb2,	$0C,	nA2,	$0C,	nD2,	$0C
	dc.b		nA2,	$0C,	nBb2,	$0C,	nA2,	$0C,	nA2,	$0C
	dc.b		nA2,	$0C,	nBb2,	$0C,	nC3,	$0C,	nBb2,	$0C
	dc.b		nA2,	$0C,	nBb2,	$0C,	nA2,	$0C,	nA2,	$0C
	dc.b		nA2,	$0C,	nBb2,	$0C,	nA2,	$0C,	nD2,	$0C
;	Jump To	 	location
	smpsJump	OperaOfEggman_Jump07

; PSG2 Data
OperaOfEggman_PSG2:
;	Alter Notes	value
	smpsAlterNote	$00
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nE0,	$30,	nG0,	$30,	nA0,	$30,	nE1,	$30
OperaOfEggman_Jump08:
	dc.b		nE0,	$30,	nG0,	$18,	nE0,	$18,	nE0,	$30
	dc.b		nG0,	$18,	nE0,	$18,	nA0,	$18,	nE1,	$18
	dc.b		nA0,	$18,	nE1,	$18,	nA0,	$18,	nE1,	$18
	dc.b		nA0,	$18,	nE1,	$18,	nE0,	$30,	nG0,	$18
	dc.b		nE0,	$18,	nE0,	$30,	nG0,	$18,	nE0,	$18
	dc.b		nF0,	$30,	nA0,	$18,	nF0,	$18,	nF0,	$30
	dc.b		nA0,	$18,	nF0,	$18,	nD0,	$60,	nCs0,	$60
	dc.b		nD0,	$60,	nCs0,	$60,	nD0,	$60,	nD0,	$60
	dc.b		nD0,	$60,	nD0,	$60
;	Jump To	 	location
	smpsJump	OperaOfEggman_Jump08

; PSG3 Data
OperaOfEggman_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nA5,	$03,	nA5,	$09,	nA5,	$03,	nA5,	$09
	dc.b		nA5,	$03,	nA5,	$09,	nA5,	$03,	nA5,	$09
	dc.b		nA5,	$03,	nA5,	$09,	nA5,	$03,	nA5,	$09
	dc.b		nA5,	$03,	nA5,	$09,	nA5,	$03,	nA5,	$09
	dc.b		nA5,	$03,	nA5,	$09,	nA5,	$03,	nA5,	$09
	dc.b		nA5,	$03,	nA5,	$09,	nA5,	$03,	nA5,	$09
	dc.b		nA5,	$03,	nA5,	$09,	nA5,	$03,	nA5,	$09
	dc.b		nA5,	$03,	nA5,	$09,	nA5,	$03,	nA5,	$03
OperaOfEggman_Jump09:
	dc.b		smpsNoAttack,	$06,	nA5,	$0C,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$03,	nA5,	$09,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$03,	nA5,	$09
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$0C,	nA5,	$03
	dc.b		nA5,	$09,	nA5,	$0C,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$03,	nA5,	$09,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$03,	nA5,	$09,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$03,	nA5,	$09
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$0C,	nA5,	$03
	dc.b		nA5,	$09,	nA5,	$0C,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$03,	nA5,	$09,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$03,	nA5,	$09,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$03,	nA5,	$09
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$0C,	nA5,	$03
	dc.b		nA5,	$09,	nA5,	$0C,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$03,	nA5,	$09,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$03,	nA5,	$09,	nA5,	$0C
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$03,	nA5,	$09
	dc.b		nA5,	$0C,	nA5,	$0C,	nA5,	$0C,	nA5,	$03
	dc.b		nA5,	$09,	nA5,	$0C,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$03,	nA5,	$09,	nA5,	$0C,	nA5,	$0C
	dc.b		nA5,	$06
;	Jump To	 	location
	smpsJump	OperaOfEggman_Jump09

OperaOfEggman_Voices:
;	Voice 00
;	$08,$0A,$70,$30,$00,$1F,$1F,$5F,$5F,$12,$0E,$0A,$0A,$00,$04,$04,$03,$2F,$2F,$2F,$2F,$22,$2E,$13,$04
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$01
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$03,	$07,	$00
	smpsVcCoarseFreq	$00,	$00,	$00,	$0A
	smpsVcRateScale		$01,	$01,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$0A,	$0E,	$12
	smpsVcDecayRate2	$03,	$04,	$04,	$00
	smpsVcDecayLevel	$02,	$02,	$02,	$02
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$04,	$13,	$2E,	$22

;	Voice 01
;	$2B,$31,$32,$35,$31,$1F,$59,$9E,$5E,$06,$80,$80,$85,$01,$17,$12,$0A,$AA,$AF,$F9,$FC,$0E,$12,$46,$05
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$03,	$03
	smpsVcCoarseFreq	$01,	$05,	$02,	$01
	smpsVcRateScale		$01,	$02,	$01,	$00
	smpsVcAttackRate	$1E,	$1E,	$19,	$1F
	smpsVcAmpMod		$04,	$04,	$04,	$00
	smpsVcDecayRate1	$05,	$00,	$00,	$06
	smpsVcDecayRate2	$0A,	$12,	$17,	$01
	smpsVcDecayLevel	$0F,	$0F,	$0A,	$0A
	smpsVcReleaseRate	$0C,	$09,	$0F,	$0A
	smpsVcTotalLevel	$05,	$46,	$12,	$0E

;	Voice 02
;	$3D,$01,$01,$01,$01,$8E,$52,$14,$4C,$08,$08,$0E,$03,$00,$00,$00,$00,$1F,$1F,$1F,$1F,$1B,$05,$05,$05
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$01,	$00,	$01,	$02
	smpsVcAttackRate	$0C,	$14,	$12,	$0E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$03,	$0E,	$08,	$08
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$05,	$05,	$05,	$1B

;	Voice 03
;	$33,$52,$60,$1B,$31,$9A,$1F,$9C,$9F,$08,$1F,$09,$19,$00,$00,$00,$02,$05,$16,$07,$08,$23,$04,$19,$05
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$01,	$06,	$05
	smpsVcCoarseFreq	$01,	$0B,	$00,	$02
	smpsVcRateScale		$02,	$02,	$00,	$02
	smpsVcAttackRate	$1F,	$1C,	$1F,	$1A
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$19,	$09,	$1F,	$08
	smpsVcDecayRate2	$02,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$00,	$01,	$00
	smpsVcReleaseRate	$08,	$07,	$06,	$05
	smpsVcTotalLevel	$05,	$19,	$04,	$23
	even
