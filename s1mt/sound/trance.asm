; =============================================================================================
; Project Name:		trance
; Created:		19th November 2015
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

trance_Header:
;	Voice Pointer	location
	smpsHeaderVoice	trance_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$04,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$02,	$0F

;	DAC Pointer	location
	smpsHeaderDAC	trance_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	trance_FM1,	smpsPitch00,	$13
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	trance_FM2,	smpsPitch00,	$13
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	trance_FM3,	smpsPitch00,	$2F
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	trance_PSG1,	smpsPitch00,	$08,	$04
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	trance_PSG2,	smpsPitch00,	$04,	$04
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	trance_PSG3,	smpsPitch00,	$04,	$04

; FM1 Data
trance_FM1:
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nRst,	$06,	nC3,	$06,	nRst,	$06,	nC3,	$06
	dc.b		nRst,	$06,	nC3,	$06,	nRst,	$06,	nC3,	$06
	dc.b		nRst,	$06,	nA2,	$06,	nRst,	$06,	nA2,	$06
	dc.b		nRst,	$06,	nA2,	$06,	nRst,	$06,	nA2,	$06
	dc.b		nRst,	$06,	nE3,	$06,	nRst,	$06,	nE3,	$06
	dc.b		nRst,	$06,	nE3,	$06,	nRst,	$06,	nE3,	$06
	dc.b		nRst,	$06,	nG3,	$06,	nRst,	$06,	nG3,	$06
	dc.b		nRst,	$06,	nG3,	$06,	nRst,	$06,	nG3,	$06
	dc.b		nRst,	$06,	nC3,	$06,	nRst,	$06,	nC3,	$06
	dc.b		nRst,	$06,	nC3,	$06,	nRst,	$06,	nC3,	$06
	dc.b		nRst,	$06,	nA2,	$06,	nRst,	$06,	nA2,	$06
	dc.b		nRst,	$06,	nA2,	$06,	nRst,	$06,	nA2,	$06
	dc.b		nRst,	$06,	nE3,	$06,	nRst,	$06,	nE3,	$06
	dc.b		nRst,	$06,	nE3,	$06,	nRst,	$06,	nE3,	$06
	dc.b		nRst,	$06,	nE3,	$06,	nRst,	$06,	nE3,	$06
	dc.b		nRst,	$06,	nE3,	$06,	nRst,	$06,	nE3,	$06
	dc.b		nRst,	$06,	nC3,	$06,	nRst,	$06,	nC3,	$06
	dc.b		nRst,	$06,	nC3,	$06,	nRst,	$06,	nC3,	$06
	dc.b		nRst,	$06,	nA2,	$06,	nRst,	$06,	nA2,	$06
	dc.b		nRst,	$06,	nA2,	$06,	nRst,	$06,	nA2,	$06
	dc.b		nRst,	$06,	nE3,	$06,	nRst,	$06,	nE3,	$06
	dc.b		nRst,	$06,	nE3,	$06,	nRst,	$06,	nE3,	$06
	dc.b		nRst,	$06,	nG3,	$06,	nRst,	$06,	nG3,	$06
	dc.b		nRst,	$06,	nG3,	$06,	nRst,	$06,	nG3,	$06
	dc.b		nRst,	$06,	nC3,	$06,	nRst,	$06,	nC3,	$06
	dc.b		nRst,	$06,	nC3,	$06,	nRst,	$06,	nC3,	$06
	dc.b		nRst,	$06,	nA2,	$06,	nRst,	$06,	nA2,	$06
	dc.b		nRst,	$06,	nA2,	$06,	nRst,	$06,	nA2,	$06
	dc.b		nRst,	$06,	nE3,	$06,	nRst,	$06,	nE3,	$06
	dc.b		nRst,	$06,	nE3,	$06,	nRst,	$06,	nE3,	$06
	dc.b		nRst,	$06,	nE3,	$06,	nRst,	$06,	nE3,	$06
	dc.b		nRst,	$06,	nE3,	$06,	nRst,	$06,	nE3,	$06
	dc.b		nRst,	$30
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	smpsStop

; FM2 Data
trance_FM2:
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nRst,	$06,	nC2,	$06,	nRst,	$06,	nC2,	$06
	dc.b		nRst,	$06,	nC2,	$06,	nRst,	$06,	nC2,	$06
	dc.b		nRst,	$06,	nA1,	$06,	nRst,	$06,	nA1,	$06
	dc.b		nRst,	$06,	nA1,	$06,	nRst,	$06,	nA1,	$06
	dc.b		nRst,	$06,	nE2,	$06,	nRst,	$06,	nE2,	$06
	dc.b		nRst,	$06,	nE2,	$06,	nRst,	$06,	nE2,	$06
	dc.b		nRst,	$06,	nG2,	$06,	nRst,	$06,	nG2,	$06
	dc.b		nRst,	$06,	nG2,	$06,	nRst,	$06,	nG2,	$06
	dc.b		nRst,	$06,	nC2,	$06,	nRst,	$06,	nC2,	$06
	dc.b		nRst,	$06,	nC2,	$06,	nRst,	$06,	nC2,	$06
	dc.b		nRst,	$06,	nA1,	$06,	nRst,	$06,	nA1,	$06
	dc.b		nRst,	$06,	nA1,	$06,	nRst,	$06,	nA1,	$06
	dc.b		nRst,	$06,	nE2,	$06,	nRst,	$06,	nE2,	$06
	dc.b		nRst,	$06,	nE2,	$06,	nRst,	$06,	nE2,	$06
	dc.b		nRst,	$06,	nE2,	$06,	nRst,	$06,	nE2,	$06
	dc.b		nRst,	$06,	nE2,	$06,	nRst,	$06,	nE2,	$06
	dc.b		nRst,	$06,	nC2,	$06,	nRst,	$06,	nC2,	$06
	dc.b		nRst,	$06,	nC2,	$06,	nRst,	$06,	nC2,	$06
	dc.b		nRst,	$06,	nA1,	$06,	nRst,	$06,	nA1,	$06
	dc.b		nRst,	$06,	nA1,	$06,	nRst,	$06,	nA1,	$06
	dc.b		nRst,	$06,	nE2,	$06,	nRst,	$06,	nE2,	$06
	dc.b		nRst,	$06,	nE2,	$06,	nRst,	$06,	nE2,	$06
	dc.b		nRst,	$06,	nG2,	$06,	nRst,	$06,	nG2,	$06
	dc.b		nRst,	$06,	nG2,	$06,	nRst,	$06,	nG2,	$06
	dc.b		nRst,	$06,	nC2,	$06,	nRst,	$06,	nC2,	$06
	dc.b		nRst,	$06,	nC2,	$06,	nRst,	$06,	nC2,	$06
	dc.b		nRst,	$06,	nA1,	$06,	nRst,	$06,	nA1,	$06
	dc.b		nRst,	$06,	nA1,	$06,	nRst,	$06,	nA1,	$06
	dc.b		nRst,	$06,	nE2,	$06,	nRst,	$06,	nE2,	$06
	dc.b		nRst,	$06,	nE2,	$06,	nRst,	$06,	nE2,	$06
	dc.b		nRst,	$06,	nE2,	$06,	nRst,	$06,	nE2,	$06
	dc.b		nRst,	$06,	nE2,	$06,	nRst,	$06,	nE2,	$06
	dc.b		nRst,	$30
;	Set FM Voice	#
	smpsFMvoice	$00
	smpsStop

; FM3 Data
trance_FM3:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nRst,	$7F,	$7F,	$52,	nE5,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nB5,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nE6,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nE5,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nB5,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nE6,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nE5,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nB5,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nE6,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nE5,	$02,	nRst,	$01,	nB5,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nE6,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nE5,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nB5,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nE6,	$02,	nRst,	$01,	nE5,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nC6,	$02,	nRst,	$01,	nG6,	$02,	nRst,	$01
	dc.b		nC7,	$02,	nRst,	$01,	nC6,	$02,	nRst,	$01
	dc.b		nG6,	$02,	nRst,	$01,	nC7,	$02,	nRst,	$01
	dc.b		nC6,	$02,	nRst,	$01,	nG6,	$02,	nRst,	$01
	dc.b		nC7,	$02,	nRst,	$01,	nC6,	$02,	nRst,	$01
	dc.b		nG6,	$02,	nRst,	$01,	nC7,	$02,	nRst,	$01
	dc.b		nC6,	$02,	nRst,	$01,	nG6,	$02,	nRst,	$01
	dc.b		nC7,	$02,	nRst,	$01,	nC6,	$02,	nRst,	$01
	dc.b		nA5,	$02,	nRst,	$01,	nE6,	$02,	nRst,	$01
	dc.b		nA6,	$02,	nRst,	$01,	nA5,	$02,	nRst,	$01
	dc.b		nE6,	$02,	nRst,	$01,	nA6,	$02,	nRst,	$01
	dc.b		nA5,	$02,	nRst,	$01,	nE6,	$02,	nRst,	$01
	dc.b		nA6,	$02,	nRst,	$01,	nA5,	$02,	nRst,	$01
	dc.b		nE6,	$02,	nRst,	$01,	nA6,	$02,	nRst,	$01
	dc.b		nA5,	$02,	nRst,	$01,	nE6,	$02,	nRst,	$01
	dc.b		nA6,	$02,	nRst,	$01,	nA5,	$02,	nRst,	$01
	dc.b		nB6,	$02,	nRst,	$01,	nD6,	$02,	nRst,	$01
	dc.b		nB5,	$02,	nRst,	$01,	nB6,	$02,	nRst,	$01
	dc.b		nD6,	$02,	nRst,	$01,	nB5,	$02,	nRst,	$01
	dc.b		nB6,	$02,	nRst,	$01,	nD6,	$02,	nRst,	$01
	dc.b		nB5,	$02,	nRst,	$01,	nB6,	$02,	nRst,	$01
	dc.b		nD6,	$02,	nRst,	$01,	nB5,	$02,	nRst,	$01
	dc.b		nB6,	$02,	nRst,	$01,	nD6,	$02,	nRst,	$01
	dc.b		nB5,	$02,	nRst,	$01,	nB6,	$02,	nRst,	$01
	dc.b		nG5,	$02,	nRst,	$01,	nD6,	$02,	nRst,	$01
	dc.b		nG6,	$02,	nRst,	$01,	nG5,	$02,	nRst,	$01
	dc.b		nD6,	$02,	nRst,	$01,	nG6,	$02,	nRst,	$01
	dc.b		nG5,	$02,	nRst,	$01,	nD6,	$02,	nRst,	$01
	dc.b		nG6,	$02,	nRst,	$01,	nG5,	$02,	nRst,	$01
	dc.b		nD6,	$02,	nRst,	$01,	nG6,	$02,	nRst,	$01
	dc.b		nG5,	$02,	nRst,	$01,	nD6,	$02,	nRst,	$01
	dc.b		nG6,	$02,	nRst,	$01,	nG5,	$02,	nRst,	$01
	dc.b		nC6,	$02,	nRst,	$01,	nG6,	$02,	nRst,	$01
	dc.b		nC7,	$02,	nRst,	$01,	nC6,	$02,	nRst,	$01
	dc.b		nG6,	$02,	nRst,	$01,	nC7,	$02,	nRst,	$01
	dc.b		nC6,	$02,	nRst,	$01,	nG6,	$02,	nRst,	$01
	dc.b		nC7,	$02,	nRst,	$01,	nC6,	$02,	nRst,	$01
	dc.b		nG6,	$02,	nRst,	$01,	nC7,	$02,	nRst,	$01
	dc.b		nC6,	$02,	nRst,	$01,	nG6,	$02,	nRst,	$01
	dc.b		nC7,	$02,	nRst,	$01,	nC6,	$02,	nRst,	$01
	dc.b		nC6,	$02,	nRst,	$01,	nG6,	$02,	nRst,	$01
	dc.b		nB6,	$02,	nRst,	$01,	nC6,	$02,	nRst,	$01
	dc.b		nG6,	$02,	nRst,	$01,	nB6,	$02,	nRst,	$01
	dc.b		nC6,	$02,	nRst,	$01,	nG6,	$02,	nRst,	$01
	dc.b		nB6,	$02,	nRst,	$01,	nC6,	$02,	nRst,	$01
	dc.b		nG6,	$02,	nRst,	$01,	nB6,	$02,	nRst,	$01
	dc.b		nC6,	$02,	nRst,	$01,	nG6,	$02,	nRst,	$01
	dc.b		nB6,	$02,	nRst,	$01,	nC6,	$02,	nRst,	$01
	dc.b		nE6,	$02,	nRst,	$01,	nB5,	$02,	nRst,	$01
	dc.b		nE5,	$02,	nRst,	$01,	nE6,	$02,	nRst,	$01
	dc.b		nB5,	$02,	nRst,	$01,	nE5,	$02,	nRst,	$01
	dc.b		nE6,	$02,	nRst,	$01,	nB5,	$02,	nRst,	$01
	dc.b		nE5,	$02,	nRst,	$01,	nE6,	$02,	nRst,	$01
	dc.b		nB5,	$02,	nRst,	$01,	nE5,	$02,	nRst,	$01
	dc.b		nE6,	$02,	nRst,	$01,	nB5,	$02,	nRst,	$01
	dc.b		nE5,	$02,	nRst,	$01,	nE6,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nE6,	$02,	nRst,	$01,	nB5,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nE5,	$02,	nRst,	$01,	nE6,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB5,	$02,	nRst,	$01,	nE5,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nE6,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB5,	$02,	nRst,	$01,	nE5,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nE6,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB5,	$02,	nRst,	$01,	nE5,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nE6,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB5,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nE5,	$02,	nRst,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nE6,	$02,	nRst,	$31
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	smpsStop

; PSG1 Data
trance_PSG1:
	dc.b		nRst,	$0D,	nC2,	$02,	nRst,	$01,	nG2,	$02
	dc.b		nRst,	$04,	nC2,	$02,	nRst,	$01,	nG2,	$02
	dc.b		nRst,	$04,	nC2,	$02,	nRst,	$01,	nG2,	$02
	dc.b		nRst,	$04,	nC2,	$02,	nRst,	$01,	nG2,	$02
	dc.b		nRst,	$04,	nC2,	$02,	nRst,	$01,	nG2,	$02
	dc.b		nRst,	$01,	nC2,	$03,	nE2,	$02,	nRst,	$01
	dc.b		nA1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nD2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nD2,	$02,	nRst,	$01
	dc.b		nA1,	$03,	nFs2,	$02,	nRst,	$01,	nE1,	$02
	dc.b		nRst,	$01,	nE2,	$02,	nRst,	$04,	nE1,	$02
	dc.b		nRst,	$01,	nE2,	$02,	nRst,	$04,	nE1,	$02
	dc.b		nRst,	$01,	nE2,	$02,	nRst,	$04,	nE1,	$02
	dc.b		nRst,	$01,	nE2,	$02,	nRst,	$04,	nE1,	$02
	dc.b		nRst,	$01,	nE2,	$02,	nRst,	$01,	nE1,	$02
	dc.b		nRst,	$01,	nFs2,	$02,	nRst,	$01,	nG1,	$02
	dc.b		nRst,	$01,	nFs2,	$02,	nRst,	$04,	nG1,	$02
	dc.b		nRst,	$01,	nFs2,	$02,	nRst,	$04,	nG1,	$02
	dc.b		nRst,	$01,	nFs2,	$02,	nRst,	$04,	nG1,	$02
	dc.b		nRst,	$01,	nG2,	$02,	nRst,	$04,	nG1,	$02
	dc.b		nRst,	$01,	nG2,	$02,	nRst,	$01,	nG1,	$02
	dc.b		nRst,	$01,	nG2,	$02,	nRst,	$01,	nC2,	$02
	dc.b		nRst,	$01,	nG2,	$02,	nRst,	$04,	nC2,	$02
	dc.b		nRst,	$01,	nG2,	$02,	nRst,	$04,	nC2,	$02
	dc.b		nRst,	$01,	nG2,	$02,	nRst,	$04,	nC2,	$02
	dc.b		nRst,	$01,	nG2,	$02,	nRst,	$04,	nC2,	$02
	dc.b		nRst,	$01,	nG2,	$02,	nRst,	$01,	nC2,	$02
	dc.b		nRst,	$01,	nA2,	$02,	nRst,	$01,	nA1,	$02
	dc.b		nRst,	$01,	nA2,	$02,	nRst,	$04,	nA1,	$02
	dc.b		nRst,	$01,	nA2,	$02,	nRst,	$04,	nA1,	$02
	dc.b		nRst,	$01,	nA2,	$02,	nRst,	$04,	nA1,	$02
	dc.b		nRst,	$01,	nA2,	$02,	nRst,	$04,	nA1,	$02
	dc.b		nRst,	$01,	nA2,	$02,	nRst,	$01,	nA1,	$02
	dc.b		nRst,	$01,	nB2,	$02,	nRst,	$01,	nE1,	$02
	dc.b		nRst,	$01,	nB2,	$02,	nRst,	$04,	nE1,	$02
	dc.b		nRst,	$01,	nB2,	$02,	nRst,	$04,	nE1,	$02
	dc.b		nRst,	$01,	nB2,	$02,	nRst,	$04,	nE1,	$02
	dc.b		nRst,	$01,	nB2,	$02,	nRst,	$04,	nE1,	$02
	dc.b		nRst,	$01,	nB2,	$02,	nRst,	$01,	nE1,	$02
	dc.b		nRst,	$01,	nB2,	$02,	nRst,	$01,	nE1,	$02
	dc.b		nRst,	$01,	nB2,	$02,	nRst,	$04,	nE1,	$02
	dc.b		nRst,	$01,	nB2,	$02,	nRst,	$04,	nE1,	$02
	dc.b		nRst,	$01,	nB2,	$02,	nRst,	$04,	nE1,	$02
	dc.b		nRst,	$01,	nD3,	$02,	nRst,	$04,	nE1,	$02
	dc.b		nRst,	$01,	nE3,	$02,	nRst,	$01,	nE1,	$02
	dc.b		nRst,	$01,	nE1,	$02,	nRst,	$01,	nC2,	$02
	dc.b		nRst,	$01,	nG2,	$02,	nRst,	$04,	nC2,	$02
	dc.b		nRst,	$01,	nG2,	$02,	nRst,	$04,	nC2,	$02
	dc.b		nRst,	$01,	nG2,	$02,	nRst,	$04,	nC2,	$02
	dc.b		nRst,	$01,	nG2,	$02,	nRst,	$04,	nC2,	$02
	dc.b		nRst,	$01,	nG2,	$02,	nRst,	$01,	nC2,	$03
	dc.b		nE2,	$02,	nRst,	$01,	nA1,	$02,	nRst,	$01
	dc.b		nE2,	$02,	nRst,	$04,	nA1,	$02,	nRst,	$01
	dc.b		nE2,	$02,	nRst,	$04,	nA1,	$02,	nRst,	$01
	dc.b		nE2,	$02,	nRst,	$04,	nA1,	$02,	nRst,	$01
	dc.b		nD2,	$02,	nRst,	$04,	nA1,	$02,	nRst,	$01
	dc.b		nD2,	$02,	nRst,	$01,	nA1,	$03,	nFs2,	$02
	dc.b		nRst,	$01,	nE1,	$02,	nRst,	$01,	nE2,	$02
	dc.b		nRst,	$04,	nE1,	$02,	nRst,	$01,	nE2,	$02
	dc.b		nRst,	$04,	nE1,	$02,	nRst,	$01,	nE2,	$02
	dc.b		nRst,	$04,	nE1,	$02,	nRst,	$01,	nE2,	$02
	dc.b		nRst,	$04,	nE1,	$02,	nRst,	$01,	nE2,	$02
	dc.b		nRst,	$01,	nE1,	$02,	nRst,	$01,	nFs2,	$02
	dc.b		nRst,	$01,	nG1,	$02,	nRst,	$01,	nFs2,	$02
	dc.b		nRst,	$04,	nG1,	$02,	nRst,	$01,	nFs2,	$02
	dc.b		nRst,	$04,	nG1,	$02,	nRst,	$01,	nFs2,	$02
	dc.b		nRst,	$04,	nG1,	$02,	nRst,	$01,	nG2,	$02
	dc.b		nRst,	$04,	nG1,	$02,	nRst,	$01,	nG2,	$02
	dc.b		nRst,	$01,	nG1,	$02,	nRst,	$01,	nG2,	$02
	dc.b		nRst,	$01,	nC2,	$02,	nRst,	$01,	nG2,	$02
	dc.b		nRst,	$04,	nC2,	$02,	nRst,	$01,	nG2,	$02
	dc.b		nRst,	$04,	nC2,	$02,	nRst,	$01,	nG2,	$02
	dc.b		nRst,	$04,	nC2,	$02,	nRst,	$01,	nG2,	$02
	dc.b		nRst,	$04,	nC2,	$02,	nRst,	$01,	nG2,	$02
	dc.b		nRst,	$01,	nC2,	$02,	nRst,	$01,	nA2,	$02
	dc.b		nRst,	$01,	nA1,	$02,	nRst,	$01,	nA2,	$02
	dc.b		nRst,	$04,	nA1,	$02,	nRst,	$01,	nA2,	$02
	dc.b		nRst,	$04,	nA1,	$02,	nRst,	$01,	nA2,	$02
	dc.b		nRst,	$04,	nA1,	$02,	nRst,	$01,	nA2,	$02
	dc.b		nRst,	$04,	nA1,	$02,	nRst,	$01,	nA2,	$02
	dc.b		nRst,	$01,	nA1,	$02,	nRst,	$01,	nB2,	$02
	dc.b		nRst,	$01,	nE1,	$02,	nRst,	$01,	nB2,	$02
	dc.b		nRst,	$04,	nE1,	$02,	nRst,	$01,	nB2,	$02
	dc.b		nRst,	$04,	nE1,	$02,	nRst,	$01,	nB2,	$02
	dc.b		nRst,	$04,	nE1,	$02,	nRst,	$01,	nB2,	$02
	dc.b		nRst,	$04,	nE1,	$02,	nRst,	$01,	nB2,	$02
	dc.b		nRst,	$01,	nE1,	$02,	nRst,	$01,	nB2,	$02
	dc.b		nRst,	$01,	nE1,	$02,	nRst,	$01,	nB2,	$02
	dc.b		nRst,	$04,	nE1,	$02,	nRst,	$01,	nB2,	$02
	dc.b		nRst,	$04,	nE1,	$02,	nRst,	$01,	nB2,	$02
	dc.b		nRst,	$04,	nE1,	$02,	nRst,	$01,	nD3,	$02
	dc.b		nRst,	$04,	nE1,	$02,	nRst,	$01,	nE3,	$02
	dc.b		nRst,	$01,	nE1,	$02,	nRst,	$01,	nE1,	$02
	dc.b		nRst,	$24
;	Set PSG Voice	#
	smpsPSGvoice	$04
	smpsStop

; PSG2 Data
trance_PSG2:
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$01
	dc.b		nC2,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$01
	dc.b		nA1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nD2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nD2,	$02,	nRst,	$01
	dc.b		nA1,	$02,	nRst,	$01,	nFs2,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nFs2,	$02,	nRst,	$01
	dc.b		nG1,	$02,	nRst,	$01,	nFs2,	$02,	nRst,	$04
	dc.b		nG1,	$02,	nRst,	$01,	nFs2,	$02,	nRst,	$04
	dc.b		nG1,	$02,	nRst,	$01,	nFs2,	$02,	nRst,	$04
	dc.b		nG1,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nG1,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$01
	dc.b		nG1,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$01
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$01
	dc.b		nC2,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$01
	dc.b		nA1,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$01
	dc.b		nA1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nD3,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nE3,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nE1,	$02,	nRst,	$01
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$01
	dc.b		nC2,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$01
	dc.b		nA1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nD2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nD2,	$02,	nRst,	$01
	dc.b		nA1,	$02,	nRst,	$01,	nFs2,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nFs2,	$02,	nRst,	$01
	dc.b		nG1,	$02,	nRst,	$01,	nFs2,	$02,	nRst,	$04
	dc.b		nG1,	$02,	nRst,	$01,	nFs2,	$02,	nRst,	$04
	dc.b		nG1,	$02,	nRst,	$01,	nFs2,	$02,	nRst,	$04
	dc.b		nG1,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nG1,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$01
	dc.b		nG1,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$01
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$01
	dc.b		nC2,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$01
	dc.b		nA1,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$01
	dc.b		nA1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nD3,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nE3,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nE1,	$02,	nRst,	$31
;	Set PSG Voice	#
	smpsPSGvoice	$04
	smpsStop

; PSG3 Data
trance_PSG3:
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$01
	dc.b		nC2,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$01
	dc.b		nA1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nD2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nD2,	$02,	nRst,	$01
	dc.b		nA1,	$02,	nRst,	$01,	nFs2,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nFs2,	$02,	nRst,	$01
	dc.b		nG1,	$02,	nRst,	$01,	nFs2,	$02,	nRst,	$04
	dc.b		nG1,	$02,	nRst,	$01,	nFs2,	$02,	nRst,	$04
	dc.b		nG1,	$02,	nRst,	$01,	nFs2,	$02,	nRst,	$04
	dc.b		nG1,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nG1,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$01
	dc.b		nG1,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$01
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$01
	dc.b		nC2,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$01
	dc.b		nA1,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$01
	dc.b		nA1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nD3,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nE3,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nE1,	$02,	nRst,	$01
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$01
	dc.b		nC2,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$01
	dc.b		nA1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nD2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nD2,	$02,	nRst,	$01
	dc.b		nA1,	$02,	nRst,	$01,	nFs2,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nE2,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nFs2,	$02,	nRst,	$01
	dc.b		nG1,	$02,	nRst,	$01,	nFs2,	$02,	nRst,	$04
	dc.b		nG1,	$02,	nRst,	$01,	nFs2,	$02,	nRst,	$04
	dc.b		nG1,	$02,	nRst,	$01,	nFs2,	$02,	nRst,	$04
	dc.b		nG1,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nG1,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$01
	dc.b		nG1,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$01
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$04
	dc.b		nC2,	$02,	nRst,	$01,	nG2,	$02,	nRst,	$01
	dc.b		nC2,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$01
	dc.b		nA1,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$04
	dc.b		nA1,	$02,	nRst,	$01,	nA2,	$02,	nRst,	$01
	dc.b		nA1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nB2,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nD3,	$02,	nRst,	$04
	dc.b		nE1,	$02,	nRst,	$01,	nE3,	$02,	nRst,	$01
	dc.b		nE1,	$02,	nRst,	$01,	nE1,	$02,	nRst,	$31
;	Set PSG Voice	#
	smpsPSGvoice	$04
	smpsStop

; DAC Data
trance_DAC:
	smpsStop

trance_Voices:
;	Voice 00
;	$3A,$01,$07,$31,$71,$8E,$8E,$8D,$53,$0E,$0E,$0E,$06,$00,$00,$00,$00,$1F,$FF,$1F,$2F,$18,$28,$27,$00
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$07,	$01
	smpsVcRateScale		$01,	$02,	$02,	$02
	smpsVcAttackRate	$13,	$0D,	$0E,	$0E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$06,	$0E,	$0E,	$0E
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$02,	$01,	$0F,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$00,	$27,	$28,	$18

;	Voice 01
;	$3B,$3A,$31,$71,$74,$DF,$1F,$1F,$DF,$00,$0A,$0A,$05,$00,$05,$05,$03,$0F,$5F,$1F,$5F,$32,$1E,$0F,$00
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$07,	$03,	$03
	smpsVcCoarseFreq	$04,	$01,	$01,	$0A
	smpsVcRateScale		$03,	$00,	$00,	$03
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$0A,	$0A,	$00
	smpsVcDecayRate2	$03,	$05,	$05,	$00
	smpsVcDecayLevel	$05,	$01,	$05,	$00
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$00,	$0F,	$1E,	$32
	even
