; =============================================================================================
; Project Name:		Jungle_Zone
; Created:		17th January 2014
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

Jungle_Zone_Header:
;	Voice Pointer	location
	smpsHeaderVoice	Jungle_Zone_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$01,	$07

;	DAC Pointer	location
	smpsHeaderDAC	Jungle_Zone_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	Jungle_Zone_FM1,	smpsPitch01hi,	$12
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	Jungle_Zone_FM2,	smpsPitch01hi,	$12
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	Jungle_Zone_FM3,	smpsPitch01lo,	$08
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	Jungle_Zone_FM4,	smpsPitch01lo,	$08
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	Jungle_Zone_FM5,	smpsPitch00,	$0C
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Jungle_Zone_PSG1,	smpsPitch03lo,	$05,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Jungle_Zone_PSG2,	smpsPitch03lo,	$05,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Jungle_Zone_PSG3,	smpsPitch00+$0B,	$03,	$00

; FM1 Data
Jungle_Zone_FM1:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nD2,	$0B,	nA1,	$05,	nB1,	nRst,	$06,	nD2
	dc.b		$05,	nA1,	nRst,	$06,	nB1,	$05,	nRst,	$0B
	dc.b		nD2,	$10,	$05,	nRst,	$0B,	nD2,	$05,	nRst
	dc.b		$0B,	nE2,	$05,	nFs2,	nRst,	$0B,	nG2,	$05
	dc.b		nRst,	$0B,	nG2,	$05,	nRst,	$06,	nG2,	$05
	dc.b		nAb2,	nRst,	$0B,	nAb2,	$05,	nRst,	$06,	nA2
	dc.b		$05,	nRst,	$0B,	nA2,	$05,	$05,	nRst,	$0B
	dc.b		nA1,	$05,	nRst,	$06,	nA1,	$05,	nB1,	nRst
	dc.b		$06,	nA1,	$05,	nG2,	$0B,	nD2,	$05,	nG2
	dc.b		nRst,	$06,	nD2,	$10,	nE2,	$05,	nG2,	nRst
	dc.b		$0B,	nFs2,	nB1,	$05,	nFs2,	nRst,	$06,	nB1
	dc.b		$05,	nRst,	$0B,	nCs2,	$05,	nD2,	nRst,	$0B
	dc.b		nE2,	$05,	nRst,	$0B,	nE2,	$05,	nRst,	$0B
	dc.b		nE2,	$05,	nRst,	$0B,	nE2,	$05,	nRst,	$06
	dc.b		nA2,	$05,	nRst,	$0B,	nE2,	$05,	nCs3,	$0B
	dc.b		nB2,	$05,	nA2,	$0B,	nG2,	$05,	nE2,	nRst
	dc.b		$06,	nA1,	$05,	nD2,	$0B,	nA1,	$05,	nB1
	dc.b		nRst,	$06,	nD2,	$05,	nA1,	nRst,	$06,	nB1
	dc.b		$05,	nRst,	$0B,	nD2,	$10,	$05,	nRst,	$0B
	dc.b		nD2,	$05,	nRst,	$0B,	nE2,	$05,	nFs2,	nRst
	dc.b		$0B
Jungle_Zone_Jump01:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nG2,	$05,	nRst,	$0B,	nG2,	$05,	nRst,	$06
	dc.b		nG2,	$05,	nAb2,	nRst,	$0B,	nAb2,	$05,	nRst
	dc.b		$06,	nA2,	$05,	nRst,	$0B,	nA2,	$05,	$05
	dc.b		nRst,	$0B,	nA1,	$05,	nRst,	$06,	nA1,	$05
	dc.b		nB1,	nRst,	$06,	nA1,	$05,	nG2,	$0B,	nD2
	dc.b		$05,	nG2,	nRst,	$06,	nD2,	$10,	nE2,	$05
	dc.b		nG2,	nRst,	$0B,	nFs2,	nB1,	$05,	nFs2,	nRst
	dc.b		$06,	nB1,	$05,	nRst,	$0B,	nCs2,	$05,	nD2
	dc.b		nRst,	$0B,	nE2,	$05,	nRst,	$06,	nD2,	$05
	dc.b		nE2,	nRst,	$06,	nE2,	$05,	nA2,	nRst,	$06
	dc.b		nA1,	$05,	nB1,	nRst,	$06,	nCs2,	$05,	nD2
	dc.b		nRst,	$0B,	nA1,	$05,	nRst,	$0B,	nD2,	$05
	dc.b		nRst,	$06,	nD2,	$05,	nE2,	nRst,	$06,	nFs2
	dc.b		$05,	nG2,	$10,	nD2,	nE2,	nD2,	nG2,	nFs2
	dc.b		nE2,	nD2,	nD2,	nA1,	nB1,	nA1,	nD2,	nCs2
	dc.b		nB1,	nA1,	nG2,	nD2,	nE2,	nD2,	nG2,	nFs2
	dc.b		nE2,	nD2,	nA2,	$05,	nRst,	$0B,	nA1,	$05
	dc.b		nRst,	$06,	nBb1,	$05,	nB1,	nRst,	$06,	nBb1
	dc.b		$05,	nA1,	nRst,	$0B,	nA2,	$05,	nRst,	$06
	dc.b		nA1,	$05,	nRst,	$0B,	nA1,	$05,	nB1,	nRst
	dc.b		$0B,	nCs2,	$05,	nRst,	$0B,	nD2,	nA1,	$05
	dc.b		nB1,	nRst,	$06,	nD2,	$05,	nA1,	nRst,	$06
	dc.b		nB1,	$05,	nRst,	$0B,	nD2,	$10,	$05,	nRst
	dc.b		$0B,	nD2,	$05,	nRst,	$0B,	nE2,	$05,	nFs2
	dc.b		nRst,	$0B,	nG2,	$05,	nRst,	$0B,	nG2,	$05
	dc.b		nRst,	$06,	nG2,	$05,	nAb2,	nRst,	$0B,	nAb2
	dc.b		$05,	nRst,	$06,	nA2,	$05,	nRst,	$0B,	nA2
	dc.b		$05,	$05,	nRst,	$0B,	nA1,	$05,	nRst,	$06
	dc.b		nA1,	$05,	nB1,	nRst,	$06,	nA1,	$05,	nG2
	dc.b		$0B,	nD2,	$05,	nG2,	nRst,	$06,	nD2,	$10
	dc.b		nE2,	$05,	nG2,	nRst,	$0B,	nFs2,	nB1,	$05
	dc.b		nFs2,	nRst,	$06,	nB1,	$05,	nRst,	$0B,	nCs2
	dc.b		$05,	nD2,	nRst,	$0B,	nE2,	$05,	nRst,	$0B
	dc.b		nE2,	$05,	nRst,	$0B,	nE2,	$05,	nRst,	$0B
	dc.b		nE2,	$05,	nRst,	$06,	nA2,	$05,	nRst,	$0B
	dc.b		nE2,	$05,	nCs3,	$0B,	nB2,	$05,	nA2,	$0B
	dc.b		nG2,	$05,	nE2,	nRst,	$06,	nA1,	$05,	nD2
	dc.b		$0B,	nA1,	$05,	nB1,	nRst,	$06,	nD2,	$05
	dc.b		nA1,	nRst,	$06,	nB1,	$05,	nRst,	$0B,	nD2
	dc.b		$10,	$05,	nRst,	$0B,	nD2,	$05,	nRst,	$0B
	dc.b		nE2,	$05,	nFs2,	nRst,	$0B
;	Jump To	 	location
	smpsJump	Jungle_Zone_Jump01

; FM2 Data
Jungle_Zone_FM2:
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nD2,	$0B,	nA1,	$05,	nB1,	nRst,	$06,	nD2
	dc.b		$05,	nA1,	nRst,	$06,	nB1,	$05,	nRst,	$0B
	dc.b		nD2,	$10,	$05,	nRst,	$0B,	nD2,	$05,	nRst
	dc.b		$0B,	nE2,	$05,	nFs2,	nRst,	$0B
Jungle_Zone_Jump02:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nG2,	$05,	nRst,	$0B,	nG2,	$05,	nRst,	$06
	dc.b		nG2,	$05,	nAb2,	nRst,	$0B,	nAb2,	$05,	nRst
	dc.b		$06,	nA2,	$05,	nRst,	$0B,	nA2,	$05,	$05
	dc.b		nRst,	$0B,	nA1,	$05,	nRst,	$06,	nA1,	$05
	dc.b		nB1,	nRst,	$06,	nA1,	$05,	nG2,	$0B,	nD2
	dc.b		$05,	nG2,	nRst,	$06,	nD2,	$10,	nE2,	$05
	dc.b		nG2,	nRst,	$0B,	nFs2,	nB1,	$05,	nFs2,	nRst
	dc.b		$06,	nB1,	$05,	nRst,	$0B,	nCs2,	$05,	nD2
	dc.b		nRst,	$0B,	nE2,	$05,	nRst,	$06,	nD2,	$05
	dc.b		nE2,	nRst,	$06,	nE2,	$05,	nA2,	nRst,	$06
	dc.b		nA1,	$05,	nB1,	nRst,	$06,	nCs2,	$05,	nD2
	dc.b		nRst,	$0B,	nA1,	$05,	nRst,	$0B,	nD2,	$05
	dc.b		nRst,	$06,	nD2,	$05,	nE2,	nRst,	$06,	nFs2
	dc.b		$05,	nG2,	$10,	nD2,	nE2,	nD2,	nG2,	nFs2
	dc.b		nE2,	nD2,	nD2,	nA1,	nB1,	nA1,	nD2,	nCs2
	dc.b		nB1,	nA1,	nG2,	nD2,	nE2,	nD2,	nG2,	nFs2
	dc.b		nE2,	nD2,	nA2,	$05,	nRst,	$0B,	nA1,	$05
	dc.b		nRst,	$06,	nBb1,	$05,	nB1,	nRst,	$06,	nBb1
	dc.b		$05,	nA1,	nRst,	$0B,	nA2,	$05,	nRst,	$06
	dc.b		nA1,	$05,	nRst,	$0B,	nA1,	$05,	nB1,	nRst
	dc.b		$0B,	nCs2,	$05,	nRst,	$0B,	nD2,	nA1,	$05
	dc.b		nB1,	nRst,	$06,	nD2,	$05,	nA1,	nRst,	$06
	dc.b		nB1,	$05,	nRst,	$0B,	nD2,	$10,	$05,	nRst
	dc.b		$0B,	nD2,	$05,	nRst,	$0B,	nE2,	$05,	nFs2
	dc.b		nRst,	$0B,	nG2,	$05,	nRst,	$0B,	nG2,	$05
	dc.b		nRst,	$06,	nG2,	$05,	nAb2,	nRst,	$0B,	nAb2
	dc.b		$05,	nRst,	$06,	nA2,	$05,	nRst,	$0B,	nA2
	dc.b		$05,	$05,	nRst,	$0B,	nA1,	$05,	nRst,	$06
	dc.b		nA1,	$05,	nB1,	nRst,	$06,	nA1,	$05,	nG2
	dc.b		$0B,	nD2,	$05,	nG2,	nRst,	$06,	nD2,	$10
	dc.b		nE2,	$05,	nG2,	nRst,	$0B,	nFs2,	nB1,	$05
	dc.b		nFs2,	nRst,	$06,	nB1,	$05,	nRst,	$0B,	nCs2
	dc.b		$05,	nD2,	nRst,	$0B,	nE2,	$05,	nRst,	$0B
	dc.b		nE2,	$05,	nRst,	$0B,	nE2,	$05,	nRst,	$0B
	dc.b		nE2,	$05,	nRst,	$06,	nA2,	$05,	nRst,	$0B
	dc.b		nE2,	$05,	nCs3,	$0B,	nB2,	$05,	nA2,	$0B
	dc.b		nG2,	$05,	nE2,	nRst,	$06,	nA1,	$05,	nD2
	dc.b		$0B,	nA1,	$05,	nB1,	nRst,	$06,	nD2,	$05
	dc.b		nA1,	nRst,	$06,	nB1,	$05,	nRst,	$0B,	nD2
	dc.b		$10,	$05,	nRst,	$0B,	nD2,	$05,	nRst,	$0B
	dc.b		nE2,	$05,	nFs2,	nRst,	$0B
;	Jump To	 	location
	smpsJump	Jungle_Zone_Jump02

; FM3 Data
Jungle_Zone_FM3:
	dc.b		nRst,	$10
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nA5,	$05,	nRst,	$0B,	nFs5,	nA5,	$05,	nRst
	dc.b		$0B,	nB5,	$05,	nRst,	$0B,	nFs5,	$05,	nRst
	dc.b		$0B,	nFs5,	$05,	nRst,	$0B,	nE5,	$05,	nD5
	dc.b		nRst,	$0B,	nB4,	$05,	nRst,	$0B,	nD5,	$05
	dc.b		nRst,	$06,	nD5,	$05,	nE5,	nRst,	$06,	nFs5
	dc.b		$05,	nRst,	$0B,	nE5,	$32,	nRst,	$03,	$20
	dc.b		nB4,	$10,	nD5,	nB5,	nA5,	nFs5,	$0B,	nD5
	dc.b		$05,	nRst,	$0B,	nE5,	$05,	nFs5,	nRst,	$0B
	dc.b		nG5,	$05,	nRst,	$0B,	nG5,	$05,	nRst,	$0B
	dc.b		nAb5,	$05,	nRst,	$0B,	nAb5,	$05,	nRst,	$06
	dc.b		nA5,	$05,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	nRst,	$10,	nA5,	$05,	nRst,	$0B
	dc.b		nFs5,	nA5,	$05,	nRst,	$0B,	nB5,	$05,	nRst
	dc.b		$0B,	nFs5,	$05,	nRst,	$0B,	nFs5,	$05,	nRst
	dc.b		$0B,	nE5,	$05,	nD5,	nRst,	$0B
Jungle_Zone_Jump03:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nB4,	$05,	nRst,	$0B,	nD5,	$05,	nRst,	$06
	dc.b		nD5,	$05,	nE5,	nRst,	$06,	nFs5,	$05,	nRst
	dc.b		$0B,	nE5,	$32,	nRst,	$03,	$20,	nB4,	$10
	dc.b		nD5,	nB5,	nA5,	nFs5,	$0B,	nD5,	$05,	nRst
	dc.b		$0B,	nE5,	$05,	nFs5,	nRst,	$0B,	nE5,	$05
	dc.b		nRst,	$0B,	nE5,	$05,	nRst,	$06,	nE5,	$05
	dc.b		nA4,	$0B,	nB4,	$05,	nCs5,	$0B,	nD5,	$32
	dc.b		nRst,	$03,	$20,	nBb5,	$03,	nRst,	$0D,	nBb5
	dc.b		$03,	nRst,	$0D,	nG5,	$03,	nRst,	$08,	nG5
	dc.b		$02,	nRst,	$0F,	nB5,	$03,	nRst,	$0B,	nB5
	dc.b		$03,	nRst,	nD6,	nRst,	$0D,	nB5,	$03,	nRst
	dc.b		$19,	nA5,	$03,	nRst,	$0B,	nA5,	$03,	nRst
	dc.b		nD6,	nRst,	$0D,	nA5,	$03,	nRst,	$09,	nFs5
	dc.b		$01,	nRst,	nA5,	$02,	nFs5,	$03,	nA5,	$02
	dc.b		nRst,	$01,	nFs5,	$02,	nA5,	$03,	nFs5,	$02
	dc.b		nRst,	$01,	nA5,	$02,	nFs5,	$03,	nA5,	$02
	dc.b		nRst,	$01,	nFs5,	$02,	nA5,	$03,	nFs5,	$02
	dc.b		nRst,	$01,	nA5,	$02,	nFs5,	$03,	nA5,	$02
	dc.b		nRst,	$01,	nFs5,	$02,	nA5,	$03,	nFs5,	$02
	dc.b		nRst,	$01,	nA5,	$02,	nFs5,	$03,	nA5,	$02
	dc.b		nRst,	$01,	nFs5,	$02,	nA5,	$03,	nFs5,	$02
	dc.b		nRst,	$01,	nA5,	$02,	nRst,	$10,	nBb5,	$03
	dc.b		nRst,	$0D,	nBb5,	$03,	nRst,	$0D,	nG5,	$03
	dc.b		nRst,	$08,	nG5,	$02,	nRst,	$0E,	nG5,	$05
	dc.b		nRst,	$0B,	nG5,	$05,	nA5,	nRst,	$0B,	nB5
	dc.b		$05,	nRst,	$0B,	nA5,	$05,	nRst,	$3B,	nA5
	dc.b		$05,	nRst,	$06,	nB5,	$05,	nRst,	$0B,	nA5
	dc.b		$05,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	nRst,	$10,	nA5,	$05,	nRst,	$0B,	nFs5
	dc.b		nA5,	$05,	nRst,	$0B,	nB5,	$05,	nRst,	$0B
	dc.b		nFs5,	$05,	nRst,	$0B,	nFs5,	$05,	nRst,	$0B
	dc.b		nE5,	$05,	nD5,	nRst,	$0B,	nB4,	$05,	nRst
	dc.b		$0B,	nD5,	$05,	nRst,	$06,	nD5,	$05,	nE5
	dc.b		nRst,	$06,	nFs5,	$05,	nRst,	$0B,	nE5,	$32
	dc.b		nRst,	$03,	$20,	nB4,	$10,	nD5,	nB5,	nA5
	dc.b		nFs5,	$0B,	nD5,	$05,	nRst,	$0B,	nE5,	$05
	dc.b		nFs5,	nRst,	$0B,	nG5,	$05,	nRst,	$0B,	nG5
	dc.b		$05,	nRst,	$0B,	nAb5,	$05,	nRst,	$0B,	nAb5
	dc.b		$05,	nRst,	$06,	nA5,	$32,	nRst,	$03,	$10
	dc.b		$10,	nA5,	$05,	nRst,	$0B,	nFs5,	nA5,	$05
	dc.b		nRst,	$0B,	nB5,	$05,	nRst,	$0B,	nFs5,	$05
	dc.b		nRst,	$0B,	nFs5,	$05,	nRst,	$0B,	nE5,	$05
	dc.b		nD5,	nRst,	$0B
;	Jump To	 	location
	smpsJump	Jungle_Zone_Jump03

; FM4 Data
Jungle_Zone_FM4:
	dc.b		nRst,	$10
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nFs5,	$05,	nRst,	$0B,	nD5,	nFs5,	$05,	nRst
	dc.b		$0B,	nFs5,	$05,	nRst,	$0B,	nD5,	$05,	nRst
	dc.b		$0B,	nD5,	$05,	nRst,	$0B,	nA4,	$05,	$05
	dc.b		nRst,	$0B,	nG4,	$05,	nRst,	$0B,	nG4,	$05
	dc.b		nRst,	$06,	nA4,	$05,	nB4,	nRst,	$06,	nB4
	dc.b		$05,	nRst,	$0B,	nA4,	$35,	nRst,	$20,	nG4
	dc.b		$10,	nB4,	nD5,	nFs5,	nA4,	$0B,	$05,	nRst
	dc.b		$0B,	nB4,	$05,	$05,	nRst,	$0B,	nB4,	$05
	dc.b		nRst,	$0B,	nB4,	$05,	nRst,	$0B,	nB4,	$05
	dc.b		nRst,	$0B,	nB4,	$05,	nRst,	$06,	nCs5,	$05
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		nRst,	$10,	nFs5,	$05,	nRst,	$0B,	nD5,	nFs5
	dc.b		$05,	nRst,	$0B,	nFs5,	$05,	nRst,	$0B,	nD5
	dc.b		$05,	nRst,	$0B,	nD5,	$05,	nRst,	$0B,	nA4
	dc.b		$05,	$05,	nRst,	$0B
Jungle_Zone_Jump04:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nG4,	$05,	nRst,	$0B,	nG4,	$05,	nRst,	$0B
	dc.b		nB4,	$05,	nRst,	$06,	nB4,	$05,	nRst,	$0B
	dc.b		nA4,	$32,	nRst,	$23,	nG4,	$10,	nB4,	nD5
	dc.b		nFs5,	nA4,	$0B,	$05,	nRst,	$0B,	nB4,	$05
	dc.b		$05,	nRst,	$0B,	nB4,	$05,	nRst,	$0B,	nB4
	dc.b		$05,	nRst,	$0B,	nE4,	nE4,	$05,	$0B,	nA4
	dc.b		$32,	nRst,	$23,	nG5,	$03,	nRst,	$0D,	nG5
	dc.b		$03,	nRst,	$0D,	nD5,	$03,	nRst,	$08,	nD5
	dc.b		$02,	nRst,	$0E,	nG5,	$02,	nRst,	$0E,	nG5
	dc.b		$02,	nRst,	$03,	nB5,	nRst,	$0D,	nG5,	$03
	dc.b		nRst,	$18,	nFs5,	$02,	nRst,	$0E,	nFs5,	$02
	dc.b		nRst,	$03,	nA5,	nRst,	$0D,	nFs5,	$03,	nRst
	dc.b		$5D,	nG5,	$03,	nRst,	$0D,	nG5,	$03,	nRst
	dc.b		$0D,	nD5,	$03,	nRst,	$08,	nD5,	$02,	nRst
	dc.b		$0E,	nD5,	$05,	nRst,	$0B,	nD5,	$05,	$05
	dc.b		nRst,	$0B,	nD5,	$05,	nRst,	$0B,	nE5,	$05
	dc.b		nRst,	$3B,	nE5,	$05,	nRst,	$06,	nE5,	$05
	dc.b		nRst,	$0B,	nE5,	$25,	nRst,	$10,	nFs5,	$05
	dc.b		nRst,	$0B,	nD5,	nFs5,	$05,	nRst,	$0B,	nFs5
	dc.b		$05,	nRst,	$0B,	nD5,	$05,	nRst,	$0B,	nD5
	dc.b		$05,	nRst,	$0B,	nA4,	$05,	$05,	nRst,	$0B
	dc.b		nG4,	$05,	nRst,	$0B,	nG4,	$05,	nRst,	$0B
	dc.b		nB4,	$05,	nRst,	$06,	nB4,	$05,	nRst,	$0B
	dc.b		nA4,	$32,	nRst,	$13,	$10,	nG4,	$10,	nB4
	dc.b		nD5,	nFs5,	nA4,	$0B,	$05,	nRst,	$0B,	nB4
	dc.b		$05,	$05,	nRst,	$0B,	nB4,	$05,	nRst,	$0B
	dc.b		nB4,	$05,	nRst,	$0B,	nB4,	$05,	nRst,	$0B
	dc.b		nB4,	$05,	nRst,	$06,	nCs5,	$32,	nRst,	$13
	dc.b		$10,	nFs5,	$05,	nRst,	$0B,	nD5,	nFs5,	$05
	dc.b		nRst,	$0B,	nFs5,	$05,	nRst,	$0B,	nD5,	$05
	dc.b		nRst,	$0B,	nD5,	$05,	nRst,	$0B,	nA4,	$05
	dc.b		$05,	nRst,	$0B
;	Jump To	 	location
	smpsJump	Jungle_Zone_Jump04

; FM5 Data
Jungle_Zone_FM5:
	dc.b		nRst,	$7F,	$4C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nA4,	$05,	nFs4,	nRst,	$06,	nD4,	$05,	nA4
	dc.b		nRst,	$06,	nA4,	$05,	nB4,	nRst,	$06,	nA4
	dc.b		$05,	nRst,	$7F,	$4C,	nD5,	$05,	nE5,	nRst
	dc.b		$06,	nFs5,	$05,	nE5,	nRst,	$06,	nCs5,	$05
	dc.b		nA4,	nRst,	$06,	nFs4,	$05,	nRst,	$7F,	$4C
Jungle_Zone_Jump05:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nA4,	$05,	nFs4,	nRst,	$06,	nD4,	$05,	nA4
	dc.b		nRst,	$06,	nA4,	$05,	nB4,	nRst,	$06,	nA4
	dc.b		$05,	nRst,	$7F,	$61,	nD3,	$05,	nE3,	nRst
	dc.b		$01,	nFs3,	$05,	nA3,	nD4,	nRst,	$01,	nFs4
	dc.b		$05,	nG5,	nRst,	$0B,	nG5,	$05,	nRst,	$0B
	dc.b		nG5,	$05,	nRst,	$0B,	nD5,	$05,	nRst,	$06
	dc.b		nB4,	$05,	nRst,	$0B,	nG5,	$05,	nRst,	$0B
	dc.b		nG5,	$05,	nB5,	nRst,	$0B,	nG5,	$05,	nRst
	dc.b		$16,	nFs5,	$05,	nRst,	$0B,	nFs5,	$05,	nA5
	dc.b		nRst,	$0B,	nD5,	$05,	nRst,	$06,	nFs5,	$15
	dc.b		nD4,	$10,	nE4,	nFs4,	nG4,	nG5,	$05,	nRst
	dc.b		$0B,	nG5,	$05,	nRst,	$0B,	nD5,	$05,	nRst
	dc.b		$06,	nB4,	$05,	nRst,	$7F,	$7F,	$7F,	$0E
	dc.b		nA4,	$05,	nFs4,	nRst,	$06,	nD4,	$05,	nA4
	dc.b		nRst,	$06,	nA4,	$05,	nB4,	nRst,	$06,	nA4
	dc.b		$05,	nRst,	$7F,	$4C,	nD5,	$05,	nE5,	nRst
	dc.b		$06,	nFs5,	$05,	nE5,	nRst,	$06,	nCs5,	$05
	dc.b		nA4,	nRst,	$06,	nFs4,	$05,	nRst,	$7F,	$4C
;	Jump To	 	location
	smpsJump	Jungle_Zone_Jump05

; PSG1 Data
Jungle_Zone_PSG1:
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nA4,	$7F,	smpsNoAttack,	$01
Jungle_Zone_Jump06:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nB4,	$40,	nCs5,	nB4,	nA4,	nG4,	$20,	nE4
	dc.b		nFs4,	$40,	nD5,	$7F,	smpsNoAttack,	$01,	nD5,	$7F
	dc.b		smpsNoAttack,	$01,	nD5,	$7F,	smpsNoAttack,	$01,	nE5,	$08
	dc.b		nRst,	$38,	nCs5,	$40,	nA4,	$7F,	smpsNoAttack,	$01
	dc.b		nB4,	$40,	nCs5,	nD5,	nCs5,	nD5,	$20,	nEb5
	dc.b		nE5,	$40,	nA4,	$7F,	smpsNoAttack,	$01
;	Jump To	 	location
	smpsJump	Jungle_Zone_Jump06

; PSG2 Data
Jungle_Zone_PSG2:
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nFs5,	$7F,	smpsNoAttack,	$01
Jungle_Zone_Jump07:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nG5,	$20,	nAb5,	nA5,	$40,	nG5,	nFs5,	nE5
	dc.b		$20,	nCs5,	nD5,	$40,	nG5,	$7F,	smpsNoAttack,	$01
	dc.b		nFs5,	$7F,	smpsNoAttack,	$01,	nG5,	$7F,	smpsNoAttack,	$01
	dc.b		nA5,	$08,	nRst,	$38,	nA5,	$40,	nFs5,	$7F
	dc.b		smpsNoAttack,	$01,	nG5,	$20,	nAb5,	nA5,	$40,	nB5
	dc.b		nA5,	nB5,	$20,	nC6,	nCs6,	$40,	nFs5,	$7F
	dc.b		smpsNoAttack,	$01
;	Jump To	 	location
	smpsJump	Jungle_Zone_Jump07

; PSG3 Data
Jungle_Zone_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG WvForm	#
	smpsPSGform	$E7
Jungle_Zone_Jump08:
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05,	nRst,	$0B,	nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05,	nRst,	$0B,	nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05,	nRst,	$0B,	nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05,	nRst,	$10
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$05,	nRst,	$0B,	nAb6,	$05,	nRst,	$0B
	dc.b		nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05,	nRst,	$3B
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05,	nRst,	$0B,	nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05,	nRst,	$0B,	nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$05,	nRst,	$06,	nAb6,	$05,	nRst,	$0B
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$05
;	Jump To	 	location
	smpsJump	Jungle_Zone_Jump08

; DAC Data
Jungle_Zone_DAC:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$98,	$0B,	$05,	$82,	$0B,	$98,	$05,	$0B
	dc.b		$05,	$82,	$0B,	$98,	$05,	$0B,	$05,	$82
	dc.b		$0B,	$98,	$05,	$0B,	$05,	$82,	$0B,	$98
	dc.b		$05,	$0B,	$05,	$82,	$0B,	$98,	$05,	$0B
	dc.b		$05,	$82,	$0B,	$98,	$05,	$0B,	$05,	$82
	dc.b		$0B,	$98,	$05,	$0B,	$05,	$82,	$0B,	$98
	dc.b		$05,	$0B,	$05,	$82,	$0B,	$98,	$05,	$0B
	dc.b		$05,	$82,	$0B,	$98,	$05,	$0B,	$05,	$82
	dc.b		$0B,	$98,	$05,	$0B,	$05,	$82,	$0B,	$98
	dc.b		$05,	$0B,	$05,	$82,	$0B,	$98,	$05,	$0B
	dc.b		$05,	$82,	$0B,	$98,	$05,	$90,	$04,	$04
	dc.b		$04,	$04,	$98,	$04,	$04,	$04,	$04,	$98
	dc.b		$04,	$04,	$04,	$04,	$99,	$04,	$04,	$04
	dc.b		$04,	$83,	$0B,	$98,	$05,	$82,	$0B,	$98
	dc.b		$05,	$0B,	$05,	$82,	$0B,	$98,	$05,	$0B
	dc.b		$05,	$82,	$0B,	$98,	$05,	$0B,	$05,	$82
	dc.b		$0B,	$98,	$05
Jungle_Zone_Jump09:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$98,	$0B,	$05,	$82,	$0B,	$98,	$05,	$0B
	dc.b		$05,	$82,	$0B,	$98,	$05,	$0B,	$05,	$82
	dc.b		$0B,	$98,	$05,	$0B,	$05,	$82,	$0B,	$98
	dc.b		$05,	$0B,	$05,	$82,	$0B,	$98,	$05,	$0B
	dc.b		$05,	$82,	$0B,	$98,	$05,	$0B,	$05,	$82
	dc.b		$0B,	$98,	$05,	$0B,	$05,	$82,	$0B,	$98
	dc.b		$05,	$0B,	$05,	$82,	$0B,	$98,	$05,	$0B
	dc.b		$05,	$82,	$0B,	$98,	$05,	$0B,	$05,	$82
	dc.b		$0B,	$98,	$05,	$0B,	$05,	$82,	$05,	$06
	dc.b		$05,	$98,	$0B,	$05,	$82,	$0B,	$98,	$05
	dc.b		$0B,	$05,	$82,	$0B,	$98,	$05,	$0B,	$05
	dc.b		$82,	$0B,	$98,	$05,	$0B,	$05,	$82,	$0B
	dc.b		$98,	$05,	$0B,	$05,	$82,	$0B,	$98,	$05
	dc.b		$0B,	$05,	$82,	$0B,	$98,	$05,	$0B,	$05
	dc.b		$82,	$0B,	$98,	$05,	$0B,	$05,	$82,	$0B
	dc.b		$98,	$05,	$0B,	$05,	$82,	$0B,	$98,	$05
	dc.b		$0B,	$05,	$82,	$0B,	$98,	$05,	$0B,	$05
	dc.b		$82,	$0B,	$98,	$05,	$0B,	$05,	$82,	$0B
	dc.b		$98,	$05,	$82,	$10,	$98,	$98,	$98,	$82
	dc.b		$06,	$05,	$05,	$06,	$05,	$05,	$06,	$05
	dc.b		$05,	$06,	$05,	$05,	$98,	$0B,	$05,	$82
	dc.b		$0B,	$98,	$05,	$0B,	$05,	$82,	$0B,	$98
	dc.b		$05,	$0B,	$05,	$82,	$0B,	$98,	$05,	$0B
	dc.b		$05,	$82,	$0B,	$98,	$05,	$0B,	$05,	$82
	dc.b		$0B,	$98,	$05,	$0B,	$05,	$82,	$0B,	$98
	dc.b		$05,	$0B,	$05,	$82,	$0B,	$98,	$05,	$0B
	dc.b		$05,	$82,	$0B,	$98,	$05,	$0B,	$05,	$82
	dc.b		$0B,	$98,	$05,	$0B,	$05,	$82,	$0B,	$98
	dc.b		$05,	$0B,	$05,	$82,	$0B,	$98,	$05,	$0B
	dc.b		$05,	$82,	$0B,	$98,	$05,	$0B,	$05,	$82
	dc.b		$0B,	$98,	$05,	$0B,	$05,	$82,	$0B,	$98
	dc.b		$05,	$0B,	$05,	$82,	$0B,	$98,	$05,	$0B
	dc.b		$05,	$82,	$0B,	$98,	$05,	$0B,	$05,	$82
	dc.b		$0B,	$98,	$05,	$0B,	$05,	$82,	$0B,	$98
	dc.b		$05,	$0B,	$05,	$82,	$0B,	$98,	$05,	$0B
	dc.b		$05,	$82,	$0B,	$98,	$05
        smpsJump	Jungle_Zone_Jump09
Jungle_Zone_Voices:
;	Voice 00
;	$3C,$01,$00,$00,$00,$1F,$1F,$15,$1F,$11,$0D,$12,$05,$07,$04,$09,$02,$55,$3A,$25,$1A,$1A,$80,$07,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$00,	$00,	$00,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$15,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$12,	$0D,	$11
	smpsVcDecayRate2	$02,	$09,	$04,	$07
	smpsVcDecayLevel	$01,	$02,	$03,	$05
	smpsVcReleaseRate	$0A,	$05,	$0A,	$05
	smpsVcTotalLevel	$80,	$07,	$80,	$1A

;	Voice 01
;	$20,$36,$35,$30,$31,$DF,$DF,$9F,$9F,$07,$06,$09,$06,$07,$06,$06,$08,$20,$10,$10,$F8,$19,$37,$13,$00
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$04
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$03,	$03
	smpsVcCoarseFreq	$01,	$00,	$05,	$06
	smpsVcRateScale		$02,	$02,	$03,	$03
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$06,	$09,	$06,	$07
	smpsVcDecayRate2	$08,	$06,	$06,	$07
	smpsVcDecayLevel	$0F,	$01,	$01,	$02
	smpsVcReleaseRate	$08,	$00,	$00,	$00
	smpsVcTotalLevel	$00,	$13,	$37,	$19

;	Voice 02
;	$39,$08,$06,$04,$12,$1F,$1F,$1F,$1F,$14,$09,$09,$02,$00,$00,$00,$00,$8B,$5A,$3A,$3A,$10,$28,$29,$80
;				#
	smpsVcAlgorithm		$01
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$01,	$00,	$00,	$00
	smpsVcCoarseFreq	$02,	$04,	$06,	$08
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$02,	$09,	$09,	$14
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$03,	$03,	$05,	$08
	smpsVcReleaseRate	$0A,	$0A,	$0A,	$0B
	smpsVcTotalLevel	$80,	$29,	$28,	$10

;	Voice 03
;	$3C,$36,$31,$76,$71,$94,$9F,$96,$9F,$12,$00,$14,$0F,$04,$0A,$04,$0D,$2F,$0F,$4F,$2F,$33,$80,$1A,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$07,	$03,	$03
	smpsVcCoarseFreq	$01,	$06,	$01,	$06
	smpsVcRateScale		$02,	$02,	$02,	$02
	smpsVcAttackRate	$1F,	$16,	$1F,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$14,	$00,	$12
	smpsVcDecayRate2	$0D,	$04,	$0A,	$04
	smpsVcDecayLevel	$02,	$04,	$00,	$02
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$1A,	$80,	$33
	even
