; =============================================================================================
; Project Name:		MM9_Plug_Electric
; Created:		17th January 2014
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

MM9_Plug_Electric_Header:
;	Voice Pointer	location
	smpsHeaderVoice	MM9_Plug_Electric_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$02,	$0C

;	DAC Pointer	location
	smpsHeaderDAC	MM9_Plug_Electric_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	MM9_Plug_Electric_FM1,	smpsPitch00,	$0E
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	MM9_Plug_Electric_FM2,	smpsPitch01hi,	$10
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	MM9_Plug_Electric_FM3,	smpsPitch00,	$10
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	MM9_Plug_Electric_FM4,	smpsPitch00,	$10
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	MM9_Plug_Electric_FM5,	smpsPitch00,	$10
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	MM9_Plug_Electric_PSG1,	smpsPitch02lo,	$07,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	MM9_Plug_Electric_PSG2,	smpsPitch02lo,	$03,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	MM9_Plug_Electric_PSG3,	smpsPitch00+$0B,	$04,	$00

; FM1 Data
MM9_Plug_Electric_FM1:
	dc.b		nRst,	$30
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nA4,	$09,	nB4,	$03,	nRst,	$06,	nC5,	$0C
	dc.b		nE5,	$06,	nD5,	$03,	nC5,	$09,	nB4,	nB4
	dc.b		$01,	nRst,	$08,	nG4,	$15,	nRst,	$09,	nA4
	dc.b		nB4,	$03,	nRst,	$06,	nC5,	$09,	nRst,	$03
	dc.b		nE5,	$06,	nD5,	$03,	nC5,	$09,	nB4,	nB4
	dc.b		$03,	nRst,	$06,	nG5,	$09,	nRst,	$03,	nF5
	dc.b		nRst,	nE5,	nD5,	$09,	nC5,	nC5,	$01,	nRst
	dc.b		$08
MM9_Plug_Electric_Jump01:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nA4,	$09,	nRst,	$03,	nA4,	$09,	nC5,	nB4
	dc.b		$12,	nG4,	$09,	nRst,	$03,	nG4,	$06,	nA4
	dc.b		$03,	nB4,	$06,	nRst,	$03,	nA4,	$27,	nRst
	dc.b		$0F
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nC5,	$03,	nRst,	nB4,	nRst,	nC5,	nRst,	nB4
	dc.b		nRst,	nG4,	nA4,	nRst,	nE4,	nG4,	nA4
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nA4,	$09,	nB4,	$03,	nRst,	$06,	nC5,	$0C
	dc.b		nE5,	$06,	nD5,	$03,	nC5,	$09,	nB4,	nB4
	dc.b		$03,	nRst,	$06,	nG4,	$15,	nRst,	$09,	nA4
	dc.b		nB4,	$03,	nRst,	$06,	nC5,	$09,	nRst,	$03
	dc.b		nE5,	$06,	nD5,	$03,	nC5,	$09,	nB4,	nB4
	dc.b		$03,	nRst,	$06,	nG5,	$09,	nRst,	$03,	nF5
	dc.b		nRst,	nE5,	nD5,	$09,	nC5,	nC5,	$03,	nRst
	dc.b		$06,	nA4,	$09,	nRst,	$03,	nA4,	$06,	nB4
	dc.b		$03,	nC5,	$06,	nRst,	$03,	nB4,	$12,	nG4
	dc.b		$09,	nRst,	$03,	nG4,	$06,	nE4,	$03,	nB4
	dc.b		$06,	nRst,	$03,	nA4,	$27,	nRst,	$0F
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nC5,	$03,	nRst,	nB4,	nRst,	nC5,	nRst,	nB4
	dc.b		nRst,	nG4,	nA4,	nRst,	$0C
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		$10,	$10,	$10,	$10,	$10,	$10,	$06
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nC5,	$03,	nRst,	nD5,	nRst,	$09,	nC5,	$03
	dc.b		$03,	nRst,	$03,	nD5,	nRst,	$06,	nD5,	nRst
	dc.b		nC5,	$03,	nRst,	nB4,	nRst,	nC5,	nRst,	nB4
	dc.b		nRst,	nG4,	nA4,	nRst,	$72,	nC5,	$03,	nRst
	dc.b		nD5,	nRst,	$09,	nC5,	$03,	$03,	nRst,	$03
	dc.b		nD5,	nRst,	$06,	nD5,	nRst,	nC5,	$03,	nRst
	dc.b		nB4,	nRst,	nC5,	nRst,	nB4,	nRst,	nG4,	nA4
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		nA3,	nC4,	nD4,	nF4,	nBb4,	$18,	$09,	nA4
	dc.b		$09,	nG4,	$06,	nA4,	$09,	nF4,	nD4,	$0F
	dc.b		nRst,	$03,	nA3,	nC4,	nD4,	nF4,	nBb4,	$18
	dc.b		$09,	nC5,	$09,	nBb4,	$06,	nA4,	$09,	nF4
	dc.b		nD4,	$12,	$09,	nE4,	$03,	nF4,	$18,	$09
	dc.b		nE4,	$06,	nRst,	$03,	nF4,	$06,	nG4,	$18
	dc.b		$09,	nF4,	$09,	nG4,	$06,	nAb4,	$18,	$09
	dc.b		nG4,	$09,	nAb4,	$06,	nBb4,	$18,	$09,	nG4
	dc.b		$09,	nEb5,	$06,	nF5,	$60
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nA4,	$09,	nB4,	$03,	nRst,	$06,	nC5,	$0C
	dc.b		nE5,	$06,	nD5,	$03,	nC5,	$09,	nB4,	nB4
	dc.b		$01,	nRst,	$08,	nG4,	$15,	nRst,	$09,	nA4
	dc.b		nB4,	$03,	nRst,	$06,	nC5,	$09,	nRst,	$03
	dc.b		nE5,	$06,	nD5,	$03,	nC5,	$09,	nB4,	nB4
	dc.b		$03,	nRst,	$06,	nG5,	$09,	nRst,	$03,	nF5
	dc.b		nRst,	nE5,	nD5,	$09,	nC5,	nC5,	$01,	nRst
	dc.b		$08
;	Jump To	 	location
	smpsJump	MM9_Plug_Electric_Jump01

; FM2 Data
MM9_Plug_Electric_FM2:
	dc.b		nRst,	$30
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nA1,	$06,	nG1,	nRst,	nA1,	$0C,	nE2,	$03
	dc.b		nRst,	nC2,	nA1,	$06,	$03,	nG1,	$06,	nF1
	dc.b		nRst,	nG1,	$0C,	nD2,	$03,	nRst,	nB1,	nG1
	dc.b		$06,	$03,	nA1,	$06,	nG1,	nRst,	nA1,	$0C
	dc.b		nE2,	$03,	nRst,	nC2,	nA1,	$06,	$03,	nG1
	dc.b		$06,	nF1,	nRst,	nG1,	$0C,	nD2,	$03,	nRst
	dc.b		nB1,	nG1,	$06,	$03,	nF1,	$06,	nE1,	nRst
MM9_Plug_Electric_Jump02:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nF1,	$0C,	nC2,	$03,	nRst,	nA1,	nF1,	$06
	dc.b		$03,	nG1,	$06,	nF1,	nRst,	nG1,	$0C,	nD2
	dc.b		$03,	nRst,	nB1,	nG1,	$06,	nC2,	$03,	nD2
	dc.b		nD2,	nC2,	nD2,	nRst,	$06,	nC2,	$03,	nRst
	dc.b		nD2,	nRst,	nA2,	nRst,	nG2,	nC2,	nRst,	$06
	dc.b		nD2,	$03,	$03,	nC2,	$03,	nD2,	nRst,	$06
	dc.b		nC2,	$03,	nRst,	nD2,	nRst,	nD2,	nRst,	nF2
	dc.b		nD2,	nRst,	$06,	nA1,	nG1,	nRst,	nA1,	$0C
	dc.b		nE2,	$03,	nRst,	nC2,	nA1,	$06,	$03,	nG1
	dc.b		$06,	nF1,	nRst,	nG1,	$0C,	nD2,	$03,	nRst
	dc.b		nB1,	nG1,	$06,	$03,	nA1,	$06,	nG1,	nRst
	dc.b		nA1,	$0C,	nE2,	$03,	nRst,	nC2,	nA1,	$06
	dc.b		$03,	nG1,	$06,	nF1,	nRst,	nG1,	$0C,	nD2
	dc.b		$03,	nRst,	nB1,	nG1,	$06,	$03,	nF1,	$06
	dc.b		nE1,	nRst,	nF1,	$0C,	nC2,	$03,	nRst,	nA1
	dc.b		nF1,	$06,	$03,	nG1,	$06,	nF1,	nRst,	nG1
	dc.b		$0C,	nD2,	$03,	nRst,	nB1,	nG1,	$06,	$03
	dc.b		nA1,	$03,	$03,	nG1,	$03,	nA1,	$06,	nRst
	dc.b		$03,	nG1,	nRst,	nA1,	$06,	nC2,	nB1,	$03
	dc.b		nG1,	$09,	nA1,	$03,	$03,	nG1,	$03,	nA1
	dc.b		$06,	nRst,	$03,	nG1,	nRst,	nA1,	$06,	$06
	dc.b		nC2,	$03,	nA1,	$09,	nBb1,	$06,	nA1,	nRst
	dc.b		nBb1,	$0C,	nF2,	$03,	nRst,	nD2,	nBb1,	$06
	dc.b		$03,	nC2,	$06,	nBb1,	nRst,	nC2,	$0C,	nG2
	dc.b		$03,	nRst,	nE2,	nC2,	$06,	$03,	nD2,	$06
	dc.b		$06,	nRst,	$06,	nD2,	$0C,	$03,	nRst,	$03
	dc.b		nD2,	nD2,	$06,	$03,	$06,	$06,	nRst,	$06
	dc.b		nD2,	$0C,	$03,	nRst,	$03,	nD2,	$06,	nC2
	dc.b		nBb1,	nA1,	nRst,	nBb1,	$0C,	nF2,	$03,	nRst
	dc.b		nD2,	nBb1,	$06,	$03,	nC2,	$06,	nBb1,	nRst
	dc.b		nC2,	$0C,	nG2,	$03,	nRst,	nE2,	nC2,	$06
	dc.b		$03,	nD2,	$06,	$06,	nRst,	$06,	nD2,	$0C
	dc.b		$03,	nRst,	$03,	nD2,	nD2,	$06,	$03,	$06
	dc.b		$06,	nRst,	$06,	nD2,	$0C,	$03,	nRst,	$03
	dc.b		nD2,	$06,	$03,	$03,	nEb2,	$0C,	nRst,	$06
	dc.b		nEb2,	$0C,	nBb2,	$03,	nRst,	nG2,	nEb2,	$06
	dc.b		$03,	nD2,	$0C,	nRst,	$06,	nD2,	$0C,	nA2
	dc.b		$03,	nRst,	nF2,	nD2,	$06,	$03,	nEb2,	$0C
	dc.b		nRst,	$06,	nEb2,	$0C,	nBb2,	$03,	nRst,	nG2
	dc.b		nEb2,	$06,	$03,	nD2,	$0C,	nRst,	$06,	nD2
	dc.b		$0C,	nA2,	$03,	nRst,	nF2,	nD2,	$06,	$03
	dc.b		nBb1,	$0C,	nRst,	$06,	nBb1,	$09,	nRst,	$03
	dc.b		nBb1,	$06,	nF2,	$03,	nBb1,	$09,	nC2,	$0C
	dc.b		nRst,	$06,	nC2,	$09,	nRst,	$03,	nC2,	$06
	dc.b		nG2,	$03,	nC2,	$09,	nCs2,	$0C,	nRst,	$06
	dc.b		nCs2,	$09,	nRst,	$03,	nCs2,	$06,	nAb2,	$03
	dc.b		nCs2,	$09,	nEb2,	$0C,	nRst,	$06,	nEb2,	$09
	dc.b		nRst,	$03,	nEb2,	$06,	nBb2,	$03,	nEb2,	$09
	dc.b		nF2,	$0C,	nRst,	$06,	nF2,	$09,	nRst,	$03
	dc.b		nF2,	$06,	nC3,	$03,	nF2,	$09,	nRst,	$06
	dc.b		nF2,	nA2,	nC3,	nF3,	nA3,	nC4,	nF4,	nA1
	dc.b		nG1,	nRst,	nA1,	$0C,	nE2,	$03,	nRst,	nC2
	dc.b		nA1,	$06,	$03,	nG1,	$06,	nF1,	nRst,	nG1
	dc.b		$0C,	nD2,	$03,	nRst,	nB1,	nG1,	$06,	$03
	dc.b		nA1,	$06,	nG1,	nRst,	nA1,	$0C,	nE2,	$03
	dc.b		nRst,	nC2,	nA1,	$06,	$03,	nG1,	$06,	nRst
	dc.b		$03,	nF1,	$06,	nRst,	$03,	nG1,	$0C,	nD2
	dc.b		$03,	nRst,	nB1,	nG1,	$06,	$03,	nF1,	$06
	dc.b		nE1,	nRst
;	Jump To	 	location
	smpsJump	MM9_Plug_Electric_Jump02

; FM3 Data
MM9_Plug_Electric_FM3:
	dc.b		nRst,	$30
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nE4,	$09,	$03,	nRst,	$06,	nA4,	$0C,	nC5
	dc.b		$06,	nB4,	$03,	nA4,	$09,	nG4,	nG4,	$03
	dc.b		nRst,	$06,	nD4,	$15,	nRst,	$09,	nE4,	nE4
	dc.b		$03,	nRst,	$06,	nA4,	$09,	nRst,	$03,	nC5
	dc.b		$06,	nB4,	$03,	nA4,	$09,	nG4,	nG4,	$03
	dc.b		nRst,	$06,	nD5,	$09,	nRst,	$03,	nC5,	nRst
	dc.b		nB4,	nA4,	$09,	nF4,	nF4,	$01,	nRst,	$08
MM9_Plug_Electric_Jump03:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nF4,	$09,	nRst,	$03,	nF4,	$06,	nB4,	$03
	dc.b		nF4,	$09,	nG4,	$12,	nD4,	$09,	nRst,	$03
	dc.b		nD4,	$06,	nE4,	$03,	nG4,	$06,	nRst,	$03
	dc.b		nD4,	$27,	nRst,	$33,	nE4,	$03,	nG4,	nE4
	dc.b		$09,	$03,	nRst,	$06,	nA4,	$0C,	nC5,	$06
	dc.b		nB4,	$03,	nA4,	$09,	nG4,	nG4,	$03,	nRst
	dc.b		$06,	nD4,	$15,	nRst,	$09,	nE4,	nE4,	$03
	dc.b		nRst,	$06,	nA4,	$09,	nRst,	$03,	nC5,	$06
	dc.b		nB4,	$03,	nA4,	$09,	nG4,	nG4,	$03,	nRst
	dc.b		$06,	nD5,	$09,	nRst,	$03,	nC5,	nRst,	nB4
	dc.b		nA4,	$09,	nF4,	nF4,	$03,	nRst,	$06,	nF4
	dc.b		$09,	nRst,	$03,	nF4,	$09,	$06,	nRst,	$03
	dc.b		nG4,	$12,	nD4,	$09,	nRst,	$03,	nD4,	$06
	dc.b		nA4,	$03,	nG4,	$06,	nRst,	$03,	nE4,	$27
	dc.b		nRst,	$09,	$06,	$06,	$06,	$06,	$06,	$06
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nA3,	$03,	nC4,	nD4,	nF4,	nA4,	$18,	$09
	dc.b		nG4,	$09,	nF4,	$06,	nE4,	$24,	nC4,	$0C
	dc.b		nD4,	$40
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nRst,	$10,	$01,	$03
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nA3,	$03,	nC4,	nD4,	nF4,	nA4,	$18,	$09
	dc.b		nG4,	$09,	nF4,	$06,	nE4,	$18,	$09,	nC4
	dc.b		$09,	nC5,	$06,	nA4,	$51,	nRst,	$0F
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		$10,	$10,	$10,	$10,	$0F,	$11,	$10,	$10
	dc.b		$10,	$10,	$10,	$10,	$10,	$10,	$10,	$10
	dc.b		$10,	$10,	$10,	$10,	$0F,	$11,	$10,	$10
	dc.b		$10,	$10,	$10,	$10,	$10,	$10,	nE4,	$09
	dc.b		$03,	nRst,	$06,	nA4,	$0C,	nC5,	$06,	nB4
	dc.b		$03,	nA4,	$09,	nG4,	nG4,	$03,	nRst,	$06
	dc.b		nD4,	$15,	nRst,	$09,	nE4,	nE4,	$03,	nRst
	dc.b		$06,	nA4,	$09,	nRst,	$03,	nC5,	$06,	nB4
	dc.b		$03,	nA4,	$09,	nG4,	nG4,	$03,	nRst,	$06
	dc.b		nD5,	$09,	nRst,	$03,	nC5,	nRst,	nB4,	nA4
	dc.b		$09,	nF4,	nF4,	$01,	nRst,	$08
;	Jump To	 	location
	smpsJump	MM9_Plug_Electric_Jump03

; FM4 Data
MM9_Plug_Electric_FM4:
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nRst,	$10,	$10,	$10,	$10,	$10,	$10,	$10
	dc.b		$10,	$10,	$12,	$15,	$1B,	$0C,	$12,	$09
	dc.b		$07
MM9_Plug_Electric_Jump04:
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nRst,	$10,	$10,	$10,	$10,	$10,	$10,	$10
	dc.b		$10,	$10,	$10,	$10,	$20,	$20,	$10,	$10
	dc.b		$08,	$08,	$08,	$08,	$08,	$08,	$08,	$08
	dc.b		$08,	$08,	$08,	$08,	$08,	$08,	$08,	$08
	dc.b		$08,	$08,	$08,	$08,	$08,	$08,	$08,	$08
	dc.b		$08,	$08,	$08,	$08,	$08,	$08,	$10,	$10
	dc.b		$10,	$10,	$10,	$10,	$10,	$10,	$10,	$10
	dc.b		$10,	$0A
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nG5,	$06,	nRst,	nF5,	$03,	nRst,	nE5,	nRst
	dc.b		nF5,	nRst,	nE5,	nRst,	nC5,	nD5,	nRst,	$0C
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		$0F,	$11,	$10,	$10,	$10,	$10,	$10,	$10
	dc.b		$0A
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nG5,	$06,	nRst,	nF5,	$03,	nRst,	nE5,	nRst
	dc.b		nF5,	nRst,	nE5,	nRst,	nC5,	nD5,	nRst,	$1C
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		$10,	$10,	$10,	$0F,	$01,	$10,	$10,	$10
	dc.b		$10,	$10,	$10,	$10,	$10,	$10,	$10,	$10
	dc.b		$10,	$10,	$10,	$10,	$0F,	$11,	$10,	$10
	dc.b		$10,	$10,	$10,	$02,	$0E,	$0B,	$05,	$10
	dc.b		$0F,	$0F,	$12,	$10,	$17,	$18,	$01,	$0C
	dc.b		$0C,	$0C,	$0C,	$0C,	$0C,	$0C,	$0B,	$01
;	Jump To	 	location
	smpsJump	MM9_Plug_Electric_Jump04

; FM5 Data
MM9_Plug_Electric_FM5:
	dc.b		nRst,	$7F,	$7F,	$03
	smpsStop

; PSG1 Data
MM9_Plug_Electric_PSG1:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nRst,	$10,	$10,	$10,	$10,	$10,	$10,	$10
	dc.b		$10,	$10,	$12,	$15,	$1B,	$0C,	$12,	$09
	dc.b		$07
MM9_Plug_Electric_Jump05:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nRst,	$10,	$10,	$10,	$10,	$10,	$10,	$11
	dc.b		nD5,	$03,	nA4,	nFs4,	nD4,	nA4,	nFs4,	nD4
	dc.b		nA4,	nFs4,	nD4,	nA4,	nFs4,	nD4,	nRst,	$18
	dc.b		$20,	$20,	$10,	$1F,	$01,	$20,	$20,	$1F
	dc.b		$21,	$0F,	$18,	$18,	$12,	nC5,	$03,	nA4
	dc.b		nE4,	nC4,	nA4,	nE4,	nC4,	nA4,	nE4,	nC4
	dc.b		nA4,	nE4,	nC4,	nRst,	$08,	$10,	$10,	$10
	dc.b		$10,	$10,	$10,	$10,	$10,	$10,	$10,	$10
	dc.b		$10,	$10,	$0F,	$11,	$10,	$0F,	$01,	$10
	dc.b		$10,	$0F,	$01,	$10,	$1F,	$30,	$30,	$11
	dc.b		$10,	$0F,	$01,	$10,	$10,	$10,	$10,	$10
	dc.b		$09,	nA4,	$03,	nRst,	$06,	nA4,	$03,	nRst
	dc.b		nD4,	nA3,	nF4,	nA4,	nA3,	nF4,	nA4,	nA3
	dc.b		nD4,	nA3,	nF4,	nC5,	nA3,	nF4,	nC5,	nA3
	dc.b		nE4,	nC4,	nG4,	nC5,	nC4,	nG4,	nC5,	nC4
	dc.b		nE4,	nC4,	nG4,	nCs5,	nC4,	nG4,	nCs5,	nC4
	dc.b		nF4,	nCs4,	nAb4,	nCs5,	nCs4,	nAb4,	nCs5,	nCs4
	dc.b		nF4,	nCs4,	nAb4,	nEb5,	nCs4,	nAb4,	nEb5,	nCs4
	dc.b		nG4,	nEb4,	nBb4,	nEb5,	nEb4,	nBb4,	nEb5,	nEb4
	dc.b		nG4,	nEb4,	nBb4,	nF5,	nEb4,	nBb4,	nF5,	nEb4
	dc.b		nA4,	nF4,	nC5,	nF5,	nF4,	nC5,	nF5,	nF4
	dc.b		nRst,	nF5,	nC5,	nA4,	nF4,	nC5,	nA4,	nF4
	dc.b		nRst,	$18,	$0F,	$0F,	$12,	$10,	$17,	$18
	dc.b		$01,	$0C,	$0C,	$0C,	$0B,	$01,	$0C,	$0C
	dc.b		$0C,	$0B,	$01
;	Jump To	 	location
	smpsJump	MM9_Plug_Electric_Jump05

; PSG2 Data
MM9_Plug_Electric_PSG2:
	dc.b		nRst,	$3C
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nRst,	$18,	$0C,	$10,	$10,	$10,	$12,	$15
	dc.b		$1B,	$0C,	$12,	$09,	$07
MM9_Plug_Electric_Jump06:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nRst,	$10,	$10,	$10,	$10,	$10,	$10,	$08
	dc.b		nD5,	$03,	nA4,	nFs4,	nD4,	nRst,	$1C,	$20
	dc.b		$20,	$20,	$10,	$10,	$0F,	$18,	$13,	$16
	dc.b		$10,	$08,	$18,	$07,	$09,	$10,	$17,	$21
	dc.b		nC5,	$03,	nA4,	nE4,	nC4,	nRst,	$0C,	$10
	dc.b		$10,	$10,	$10,	$10,	$10,	$10,	$10,	$10
	dc.b		$10,	$10,	$10,	$10,	$10,	$10,	$0F,	$11
	dc.b		$10,	$10,	$10,	$10,	$10,	$10,	$10,	$10
	dc.b		$10,	$10,	$10,	$10,	$10,	$10,	$0F,	$01
	dc.b		$10,	$10,	$10,	$10,	$10,	$10,	$10,	nA4
	dc.b		$03,	nF4,	nD4,	nA3,	nF4,	nD4,	nA3,	nF4
	dc.b		nA4,	nF4,	nD4,	nA3,	nF4,	nD4,	nA3,	nF4
	dc.b		nC5,	nG4,	nE4,	nC4,	nG4,	nE4,	nC4,	nG4
	dc.b		nC5,	nG4,	nE4,	nC4,	nG4,	nE4,	nC4,	nG4
	dc.b		nCs5,	nAb4,	nF4,	nCs4,	nAb4,	nF4,	nCs4,	nAb4
	dc.b		nCs5,	nAb4,	nF4,	nCs4,	nAb4,	nF4,	nCs4,	nAb4
	dc.b		nEb5,	nBb4,	nG4,	nEb4,	nBb4,	nG4,	nEb4,	nBb4
	dc.b		nEb5,	nBb4,	nG4,	nEb4,	nBb4,	nG4,	nEb4,	nBb4
	dc.b		nF5,	nC5,	nA4,	nF4,	nC5,	nA4,	nF4,	nC5
	dc.b		nF5,	nC5,	nA4,	nF4,	nC5,	nA4,	nF4,	nC5
	dc.b		nA4,	nF4,	nRst,	$0A,	$10,	$10,	$0F,	$0F
	dc.b		$12,	$10,	$17,	$18,	$03,	$0C,	$16,	$0C
	dc.b		$0C,	$0C,	$0C,	$0C
;	Jump To	 	location
	smpsJump	MM9_Plug_Electric_Jump06

; PSG3 Data
MM9_Plug_Electric_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$03,	nRst
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
;	Set PSG WvForm	#
	smpsPSGform	$E7
MM9_Plug_Electric_Jump07:
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$03,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	nAb6,	$09,	$03,	$09,	$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$03,	$03
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
;	Jump To	 	location
	smpsJump	MM9_Plug_Electric_Jump07

; DAC Data
MM9_Plug_Electric_DAC:
	dc.b		nRst,	$18
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
		dc.b		dKick2,	$03,	$03,	$03,	$03,	dKick2,	$03,	$03
	dc.b		$03,	$03,	dKick2,	$03,	nRst,	$06,	dKick2,	$03
	dc.b		dSnare,	nRst,	dKick2,	dKick2,	nRst,	dKick2,	$06,	$03
	dc.b		dSnare,	$03,	nRst,	dKick2,	nRst,	dKick2,	nRst,	$06
	dc.b		dKick2,	$03,	dSnare,	nRst,	dKick2,	dKick2,	nRst,	dKick2
	dc.b		$06,	$03,	dSnare,	$03,	nRst,	dKick2,	nRst,	dKick2
	dc.b		nRst,	$06,	dKick2,	$03,	dSnare,	nRst,	dKick2,	dKick2
	dc.b		nRst,	dKick2,	$06,	$03,	dSnare,	$03,	nRst,	dKick2
	dc.b		nRst,	dKick2,	nRst,	$06,	dKick2,	$03,	dSnare,	nRst
	dc.b		dKick2,	dKick2,	nRst,	dKick2,	$06,	$03,	dSnare,	$03
	dc.b		nRst,	dKick2,	nRst,	dKick2,	nRst,	$06,	dKick2,	$03
	dc.b		dSnare,	nRst
MM9_Plug_Electric_Jump08:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dKick2,	$03,	$03,	nRst,	$03,	dKick2,	$06,	$03
	dc.b		dSnare,	$03,	nRst,	dKick2,	nRst,	dKick2,	nRst,	$06
	dc.b		dKick2,	$03,	dSnare,	nRst,	dKick2,	dKick2,	nRst,	dKick2
	dc.b		$06,	$03,	dSnare,	$03,	nRst,	dKick2,	nRst,	dKick2
	dc.b		nRst,	$06,	dKick2,	$03,	dSnare,	nRst,	dKick2,	dKick2
	dc.b		nRst,	dKick2,	$06,	$03,	dSnare,	$03,	nRst,	dKick2
	dc.b		nRst,	dKick2,	nRst,	$06,	dKick2,	$03,	dSnare,	nRst
	dc.b		dKick2,	dKick2,	nRst,	dKick2,	$06,	$03,	dSnare,	$03
	dc.b		nRst,	dKick2,	nRst,	dKick2,	nRst,	$06,	dKick2,	$03
	dc.b		dSnare,	nRst,	dKick2,	dKick2,	nRst,	dKick2,	$06,	$03
	dc.b		dSnare,	$03,	nRst,	dKick2,	nRst,	dKick2,	nRst,	$06
	dc.b		dKick2,	$03,	dSnare,	nRst,	dKick2,	dKick2,	nRst,	dKick2
	dc.b		$06,	$03,	dSnare,	$03,	nRst,	dKick2,	nRst,	dKick2
	dc.b		nRst,	$06,	dKick2,	$03,	dSnare,	nRst,	dKick2,	dKick2
	dc.b		nRst,	dKick2,	$06,	$03,	dSnare,	$03,	nRst,	dKick2
	dc.b		nRst,	dKick2,	nRst,	$06,	dKick2,	$03,	dSnare,	nRst
	dc.b		dKick2,	dKick2,	nRst,	dKick2,	$06,	$03,	dSnare,	$03
	dc.b		nRst,	dKick2,	nRst,	dKick2,	nRst,	$06,	dKick2,	$03
	dc.b		dSnare,	nRst,	dKick2,	dKick2,	nRst,	dKick2,	$06,	$03
	dc.b		dSnare,	$03,	nRst,	dKick2,	nRst,	dKick2,	nRst,	$06
	dc.b		dKick2,	$03,	dSnare,	nRst,	dKick2,	dKick2,	nRst,	dKick2
	dc.b		$06,	$03,	dSnare,	$03,	nRst,	dKick2,	nRst,	dKick2
	dc.b		nRst,	$06,	dKick2,	$03,	dSnare,	nRst,	dKick2,	dKick2
	dc.b		nRst,	dKick2,	$06,	$03,	dSnare,	$03,	nRst,	dKick2
	dc.b		nRst,	dKick2,	nRst,	$06,	dKick2,	$03,	dSnare,	nRst
	dc.b		dKick2,	nRst,	dSnare,	dSnare,	$09,	$03,	dKick2,	$03
	dc.b		dSnare,	dSnare,	dKick2,	nRst,	$06,	dKick2,	$03,	dSnare
	dc.b		nRst,	dKick2,	dKick2,	nRst,	dKick2,	$06,	$03,	dSnare
	dc.b		$03,	nRst,	dKick2,	nRst,	dKick2,	nRst,	$06,	dKick2
	dc.b		$03,	dSnare,	nRst,	dKick2,	dKick2,	nRst,	dKick2,	$06
	dc.b		$03,	dSnare,	$03,	nRst,	dKick2,	nRst,	dKick2,	nRst
	dc.b		$06,	dKick2,	$03,	dSnare,	nRst,	dKick2,	dKick2,	nRst
	dc.b		dKick2,	$06,	$03,	dSnare,	$03,	nRst,	dKick2,	nRst
	dc.b		dKick2,	nRst,	$06,	dKick2,	$03,	dSnare,	nRst,	dKick2
	dc.b		dKick2,	nRst,	dKick2,	$06,	$03,	dSnare,	$03,	nRst
	dc.b		dKick2,	nRst,	dKick2,	nRst,	$06,	dKick2,	$03,	dSnare
	dc.b		nRst,	dKick2,	dKick2,	nRst,	dKick2,	$06,	$03,	dSnare
	dc.b		$03,	nRst,	dKick2,	nRst,	dKick2,	nRst,	$06,	dKick2
	dc.b		$03,	dSnare,	nRst,	dKick2,	dKick2,	nRst,	dKick2,	$06
	dc.b		$03,	dSnare,	$03,	nRst,	dKick2,	nRst,	dKick2,	nRst
	dc.b		$06,	dKick2,	$03,	dSnare,	nRst,	dKick2,	dKick2,	nRst
	dc.b		dKick2,	$06,	$03,	dSnare,	$03,	nRst,	dKick2,	nRst
	dc.b		dKick2,	nRst,	$06,	dKick2,	$03,	dSnare,	nRst,	dKick2
	dc.b		dKick2,	nRst,	dKick2,	$06,	$03,	dSnare,	$03,	nRst
	dc.b		dKick2,	nRst,	dKick2,	nRst,	$06,	dKick2,	$03,	dSnare
	dc.b		nRst,	dKick2,	dKick2,	nRst,	dKick2,	$06,	$03,	dSnare
	dc.b		$03,	nRst,	dKick2,	nRst,	dKick2,	nRst,	$06,	dKick2
	dc.b		$03,	dSnare,	nRst,	dKick2,	dKick2,	nRst,	dKick2,	$06
	dc.b		$03,	dSnare,	$03,	nRst,	dKick2,	nRst,	dKick2,	nRst
	dc.b		$06,	dKick2,	$03,	dSnare,	nRst,	dKick2,	dKick2,	nRst
	dc.b		dKick2,	$06,	$03,	dSnare,	$03,	nRst,	dKick2,	nRst
	dc.b		dKick2,	nRst,	$06,	dKick2,	$03,	dSnare,	nRst,	dKick2
	dc.b		dKick2,	nRst,	dKick2,	$06,	$03,	dSnare,	$03,	nRst
	dc.b		dKick2,	nRst,	dKick2,	nRst,	$06,	dKick2,	$03,	dSnare
	dc.b		nRst,	dKick2,	dKick2,	nRst,	dKick2,	$06,	$03,	dSnare
	dc.b		$03,	nRst,	dKick2,	nRst,	dKick2,	nRst,	$06,	dKick2
	dc.b		$03,	dSnare,	nRst,	dKick2,	dKick2,	nRst,	dKick2,	$06
	dc.b		$03,	dSnare,	$03,	nRst,	dKick2,	nRst,	dKick2,	nRst
	dc.b		$06,	dKick2,	$03,	dSnare,	nRst,	dKick2,	dKick2,	nRst
	dc.b		dKick2,	$06,	$03,	dSnare,	$03,	nRst,	dKick2,	nRst
	dc.b		dKick2,	nRst,	$06,	dKick2,	$03,	dSnare,	nRst,	dKick2
	dc.b		dKick2,	nRst,	dKick2,	$06,	$03,	dSnare,	$03,	nRst
	dc.b		dKick2,	nRst,	dKick2,	nRst,	$06,	dKick2,	$03,	dSnare
	dc.b		nRst,	dKick2,	dKick2,	nRst,	dKick2,	$06,	$03,	dSnare
	dc.b		$03,	nRst,	dKick2,	nRst,	dSnare,	nRst,	$09,	dSnare
	dc.b		$03,	nRst,	$09,	dSnare,	$03,	$03,	$03,	$03
	dc.b		$03,	$03,	$03,	$03,	dKick2,	$03,	nRst,	$06
	dc.b		dKick2,	$03,	dSnare,	nRst,	dKick2,	dKick2,	nRst,	dKick2
	dc.b		$06,	$03,	dSnare,	$03,	nRst,	dKick2,	nRst,	dKick2
	dc.b		nRst,	$06,	dKick2,	$03,	dSnare,	nRst,	dKick2,	dKick2
	dc.b		nRst,	dKick2,	$06,	$03,	dSnare,	$03,	nRst,	dKick2
	dc.b		nRst,	dKick2,	nRst,	$06,	dKick2,	$03,	dSnare,	nRst
	dc.b		dKick2,	dKick2,	nRst,	dKick2,	$06,	$03,	dSnare,	$03
	dc.b		nRst,	dKick2,	nRst,	dKick2,	nRst,	$06,	dKick2,	$03
	dc.b		dSnare,	nRst,	dKick2,	dKick2,	nRst,	dKick2,	$06,	$03
	dc.b		dSnare,	$03,	nRst,	dKick2,	nRst,	dKick2,	nRst,	$06
	dc.b		dKick2,	$03,	dSnare,	nRst
;	Jump To	 	location
	smpsJump	MM9_Plug_Electric_Jump08

MM9_Plug_Electric_Voices:
;	Voice 00
;	$28,$36,$03,$00,$01,$DF,$DC,$DD,$DF,$06,$09,$02,$05,$06,$04,$01,$00,$23,$33,$13,$08,$19,$20,$20,$00
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$03
	smpsVcCoarseFreq	$01,	$00,	$03,	$06
	smpsVcRateScale		$03,	$03,	$03,	$03
	smpsVcAttackRate	$1F,	$1D,	$1C,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$02,	$09,	$06
	smpsVcDecayRate2	$00,	$01,	$04,	$06
	smpsVcDecayLevel	$00,	$01,	$03,	$02
	smpsVcReleaseRate	$08,	$03,	$03,	$03
	smpsVcTotalLevel	$00,	$20,	$20,	$19

;	Voice 01
;	$28,$02,$09,$11,$D1,$1F,$1F,$1F,$19,$04,$01,$04,$06,$01,$01,$01,$00,$F9,$F9,$F8,$EA,$0A,$1B,$16,$00
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$0D,	$01,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$09,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$19,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$06,	$04,	$01,	$04
	smpsVcDecayRate2	$00,	$01,	$01,	$01
	smpsVcDecayLevel	$0E,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$0A,	$08,	$09,	$09
	smpsVcTotalLevel	$00,	$16,	$1B,	$0A

;	Voice 02
;	$3A,$30,$07,$24,$01,$9C,$DB,$9C,$DC,$04,$09,$00,$04,$03,$0D,$00,$0E,$07,$A2,$56,$94,$20,$30,$28,$00
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$02,	$00,	$03
	smpsVcCoarseFreq	$01,	$04,	$07,	$00
	smpsVcRateScale		$03,	$02,	$03,	$02
	smpsVcAttackRate	$1C,	$1C,	$1B,	$1C
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$04,	$00,	$09,	$04
	smpsVcDecayRate2	$0E,	$00,	$0D,	$03
	smpsVcDecayLevel	$09,	$05,	$0A,	$00
	smpsVcReleaseRate	$04,	$06,	$02,	$07
	smpsVcTotalLevel	$00,	$28,	$30,	$20

;	Voice 03
;	$07,$12,$14,$D8,$D2,$14,$11,$10,$11,$00,$01,$00,$01,$04,$04,$04,$04,$F8,$F8,$F8,$F8,$25,$0E,$15,$00
;				#
	smpsVcAlgorithm		$07
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$0D,	$0D,	$01,	$01
	smpsVcCoarseFreq	$02,	$08,	$04,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$11,	$10,	$11,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$01,	$00,	$01,	$00
	smpsVcDecayRate2	$04,	$04,	$04,	$04
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$08,	$08,	$08,	$08
	smpsVcTotalLevel	$00,	$15,	$0E,	$25

;	Voice 04
;	$3D,$02,$02,$02,$02,$94,$19,$19,$19,$0F,$0D,$0D,$0D,$04,$01,$01,$01,$25,$1A,$1A,$1A,$15,$06,$06,$0A
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$02,	$02,	$02,	$02
	smpsVcRateScale		$00,	$00,	$00,	$02
	smpsVcAttackRate	$19,	$19,	$19,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0D,	$0D,	$0D,	$0F
	smpsVcDecayRate2	$01,	$01,	$01,	$04
	smpsVcDecayLevel	$01,	$01,	$01,	$02
	smpsVcReleaseRate	$0A,	$0A,	$0A,	$05
	smpsVcTotalLevel	$0A,	$06,	$06,	$15
	even
