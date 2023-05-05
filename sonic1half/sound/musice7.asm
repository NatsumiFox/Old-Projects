; =============================================================================================
; Project Name:		Guile
; Created:		7th August 2012
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

Guile_Header:
;	Voice Pointer	location
	smpsHeaderVoice	Guile_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$02
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$02,	$02

;	DAC Pointer	location
	smpsHeaderDAC	Guile_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	Guile_FM1,	smpsPitch00,	$04
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	Guile_FM2,	smpsPitch00,	$04
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	Guile_FM3,	smpsPitch00,	$00
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	Guile_FM4,	smpsPitch00,	$04
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	Guile_FM5,	smpsPitch00,	$04
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Guile_PSG1,	smpsPitch03lo,	$03,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Guile_PSG2,	smpsPitch03lo,	$03,	$00

; FM1 Data
Guile_FM1:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nA4,	$02,	nRst,	nA4,	nG4,	nRst,	nG4,	nA4
	dc.b		$0E,	$02,	nG4,	$02,	nRst,	nA4,	nRst,	nA4
	dc.b		nG4,	nRst,	nG4,	nA4,	$0E,	$02,	nG4,	$02
	dc.b		nRst,	nA4,	nG4,	nRst,	nA4,	nRst,	nG4,	nRst
	dc.b		nBb4,	nRst,	nBb4,	nA4,	$04,	nG4,	nE4,	nA4
	dc.b		$02,	nRst,	nA4,	nG4,	nRst,	nG4,	nA4,	$0E
	dc.b		$02,	nG4,	$02,	nRst,	nA4,	nRst,	nA4,	nG4
	dc.b		nRst,	nG4,	nA4,	$0E,	$02,	nG4,	$02,	nRst
	dc.b		nA4,	nG4,	nRst,	nA4,	nRst,	nG4,	nRst,	nBb4
	dc.b		nRst,	nBb4,	nA4,	$04,	nG4,	nE4
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nD4,	$14,	nE4,	$04,	nF4,	$02,	nG4,	$06
	dc.b		nA4,	nRst,	nC5,	$08,	nRst,	$04,	nA4,	$02
	dc.b		nBb4,	$06,	nE4,	$04,	nRst,	$02,	nF4,	$04
	dc.b		nRst,	$02,	nG4,	$04,	nRst,	nC4,	nE4,	nG4
	dc.b		nBb4,	$06,	nC5,	nA4,	$04,	nRst,	nA4,	nG4
	dc.b		nRst,	nD4,	$14,	nE4,	$02,	nRst,	nF4,	nBb3
	dc.b		$04,	nRst,	$02,	nA4,	$06,	nRst,	$12,	nA4
	dc.b		$02,	nRst,	$06,	nC5,	$14,	nD5,	$02,	nRst
	dc.b		nE5,	nF5,	$04,	nRst,	$02,	nA5,	$06,	nRst
	dc.b		$0A,	nE5,	$06,	nRst,	$02,	nC5,	$06,	nRst
	dc.b		$7F,	$03,	nBb5,	$14,	nRst,	$0C,	nG5,	$06
	dc.b		nRst,	$0A,	nE5,	$06,	nRst,	$4A,	nD5,	$14
	dc.b		nE5,	$02,	nRst,	nF5,	nRst,	$04,	nA5,	$08
	dc.b		nBb5,	$04,	nRst,	$02,	nBb4,	nRst,	$06,	nE5
	dc.b		$02,	nRst,	nD5,	nE5,	$04,	nRst,	$02,	nE5
	dc.b		$07,	nRst,	$01,	nF5,	$06,	nG5,	$02,	nRst
	dc.b		$06,	nC5,	$04,	nE5,	$02,	nRst,	nBb5,	$0C
	dc.b		nRst,	$02,	nA5,	nG5,	nA5,	$06,	nRst,	$02
	dc.b		nG5,	$04,	nF5,	nD5,	$14,	nE5,	$04,	nF5
	dc.b		nG5,	nG5,	$0E,	nRst,	$0A,	nF5,	$02,	nRst
	dc.b		$06,	nE5,	$04,	nRst,	$02,	nD5,	$18,	nRst
	dc.b		$22,	nD5,	$0E,	nRst,	$06,	nE5,	$02,	nRst
	dc.b		nF5,	nG5,	nRst,	nA5,	$08,	nRst,	$02,	nD5
	dc.b		$06,	nC6,	nBb5,	$04,	nA5,	nG5,	nE5,	nRst
	dc.b		$02,	nD5,	$18,	nRst,	$22
;	Jump To	 	location
	smpsJump	Guile_FM1

; FM2 Data
Guile_FM2:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nF5,	$02,	nRst,	nF5,	nE5,	nRst,	nE5,	nF5
	dc.b		$0F,	nRst,	$01,	nE5,	$02,	nRst,	nF5,	nRst
	dc.b		nF5,	nE5,	nRst,	nE5,	nF5,	$0F,	nRst,	$01
	dc.b		nE5,	$02,	nRst,	nF5,	nE5,	nRst,	nF5,	nRst
	dc.b		nE5,	nRst,	nG5,	nRst,	nG5,	nF5,	$04,	nE5
	dc.b		nC5,	nF5,	$02,	nRst,	nF5,	nE5,	nRst,	nE5
	dc.b		nF5,	$0F,	nRst,	$01,	nE5,	$02,	nRst,	nF5
	dc.b		nRst,	nF5,	nE5,	nRst,	nE5,	nF5,	$0F,	nRst
	dc.b		$01,	nE5,	$02,	nRst,	nF5,	nE5,	nRst,	nF5
	dc.b		nRst,	nE5,	nRst,	nG5,	nRst,	nG5,	nF5,	nRst
	dc.b		nE5,	nRst,	nC5,	nRst
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nF3,	$14,	nG3,	$04,	nA3,	$02,	nBb3,	$06
	dc.b		nC4,	nA4,	$02,	nG4,	$04,	nD4,	$08,	nBb4
	dc.b		$04,	nC4,	$02,	nD4,	$06,	nC4,	$04,	nRst
	dc.b		$02,	nD4,	$04,	nRst,	$02,	nE4,	$04,	nRst
	dc.b		nG3,	nBb3,	nE4,	nG4,	$06,	nA4,	nE4,	$04
	dc.b		nRst,	nC4,	nC4,	nE4,	nF3,	$14,	nG3,	$02
	dc.b		nRst,	nA3,	nG4,	$04,	nRst,	$02,	nD4,	$06
	dc.b		nA4,	$02,	nBb4,	$04,	nG4,	nRst,	nG4,	$02
	dc.b		nRst,	nF4,	nBb4,	nRst,	$04,	nG4,	$14,	nA4
	dc.b		$02,	nRst,	nG4,	nF4,	$04,	nRst,	$02,	nE4
	dc.b		$06,	nRst,	$02,	nG5,	$06,	nRst,	$02,	nG4
	dc.b		$06,	nRst,	$02,	nA4,	$06,	nRst,	$02,	nD5
	dc.b		$14,	nE5,	$04,	nF5,	nG5,	nD5,	$14,	nE5
	dc.b		$04,	nF5,	nG5,	nA5,	$32,	nRst,	$04,	$02
	dc.b		nD5,	$04,	$04,	nF4,	$14,	nA5,	$02,	nRst
	dc.b		nG5,	nA5,	$04,	nRst,	$02,	nG4,	$06,	nRst
	dc.b		$02,	nF5,	$06,	nRst,	$02,	nE4,	$06,	nRst
	dc.b		$02,	nC5,	$06,	nRst,	$02,	nD5,	$06,	nRst
	dc.b		$02,	nA4,	$2E,	nRst,	$02,	nC5,	$04,	$04
	dc.b		nF4,	$14,	nG4,	$02,	nRst,	nA4,	nG5,	nRst
	dc.b		nC5,	$08,	nD5,	$04,	nRst,	$02,	nG5,	nRst
	dc.b		$06,	nG4,	$02,	nRst,	nG4,	nG4,	$04,	nRst
	dc.b		$02,	nC4,	$07,	nRst,	$01,	nD4,	$06,	nE4
	dc.b		$02,	nRst,	$06,	nE4,	$04,	$02,	nRst,	$02
	dc.b		nG4,	$0C,	nRst,	$02,	nF4,	nE4,	nF4,	$06
	dc.b		nRst,	$02,	nE4,	$04,	nD4,	nF4,	$14,	nA4
	dc.b		$04,	nBb4,	nA4,	nC5,	$0E,	nRst,	$02,	nBb4
	dc.b		$04,	nA5,	nA4,	$02,	nE5,	$04,	nRst,	$02
	dc.b		nG4,	$04,	nF5,	$02,	nF4,	$18,	nRst,	$1A
	dc.b		nC5,	$02,	nRst,	nC5,	nRst,	nF4,	$0E,	nRst
	dc.b		$06,	nG4,	$02,	nRst,	nA4,	nBb4,	nRst,	nC5
	dc.b		$08,	nRst,	$02,	nA4,	$06,	$06,	nG4,	$04
	dc.b		nF4,	nE4
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		nF4,	$02,	nE4,	nRst,	nF4,	$16,	nE4,	$02
	dc.b		nRst,	nF4,	nRst,	nF4,	nE4,	nRst,	nE4,	nF4
	dc.b		$0B,	nRst,	$01,	nF4,	$02,	nRst,	nE4,	nRst
;	Jump To	 	location
	smpsJump	Guile_FM2

; FM3 Data
Guile_FM3:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nD2,	$0E,	nRst,	$04,	nG2,	$02,	nA2,	nG2
	dc.b		nF2,	nE2,	nD2,	nC2,	nBb1,	$0E,	nRst,	$04
	dc.b		nBb1,	$02,	nA2,	nBb2,	nRst,	nBb2,	nRst,	nBb2
	dc.b		nG1,	nG1,	nRst,	nG1,	$08,	nA1,	$02,	nRst
	dc.b		nA1,	nRst,	nA1,	nA1,	nRst,	nC2,	nRst,	nD2
	dc.b		nRst,	nC3,	nD3,	nRst,	nC3,	nD3,	nD2,	nRst
	dc.b		nG2,	nA2,	nG2,	nF2,	nE2,	nD2,	nC2,	nBb1
	dc.b		nRst,	nA2,	nBb2,	nRst,	nA2,	nBb2,	nBb1,	nRst
	dc.b		nBb1,	nA2,	nBb2,	nRst,	nBb2,	nRst,	nBb2,	nG1
	dc.b		nG1,	nRst,	nG1,	$08,	nA1,	$02,	nRst,	nA1
	dc.b		nRst,	nA1,	nA1,	nRst,	nC2,	nRst,	nD2,	nD2
	dc.b		nRst,	nD2,	nD2,	$07,	nRst,	$05,	nD2,	$02
	dc.b		nRst,	nD2,	nD2,	$06,	nBb1,	$02,	$02,	nRst
	dc.b		$02,	nBb1,	nBb1,	$07,	nRst,	$05,	nBb1,	$02
	dc.b		nRst,	nBb1,	nBb1,	$06,	nC2,	$02,	$02,	nRst
	dc.b		$02,	nC2,	nC2,	$07,	nRst,	$05,	nC2,	$02
	dc.b		nRst,	nC2,	nC2,	$06,	nA1,	$02,	$02,	nRst
	dc.b		$04,	nA1,	$07,	nRst,	$03,	nE2,	$02,	nF2
	dc.b		nG2,	nA2,	nG2,	nF2,	nC2,	nD2,	nD2,	nRst
	dc.b		nD2,	nD2,	$07,	nRst,	$05,	nD2,	$02,	nRst
	dc.b		nD2,	nD2,	$06,	nBb1,	$02,	$02,	nRst,	$02
	dc.b		nBb1,	nBb1,	$07,	nRst,	$05,	nBb1,	$02,	nRst
	dc.b		nBb1,	nBb1,	$06,	nC2,	$02,	$02,	nRst,	$02
	dc.b		nC2,	nC2,	$07,	nRst,	$05,	nC2,	$02,	nRst
	dc.b		nC2,	nC2,	$06,	nA1,	$02,	$02,	nRst,	$04
	dc.b		nA1,	$07,	nRst,	$03,	nE2,	$02,	nF2,	nG2
	dc.b		nA2,	nG2,	nF2,	nC2,	nBb1,	nRst,	$04,	nBb1
	dc.b		$02,	$02,	$02,	nRst,	$02,	nBb1,	nBb1,	$07
	dc.b		nRst,	$05,	nG2,	$02,	nA2,	nC2,	nRst,	$04
	dc.b		nC2,	$02,	$02,	$02,	nRst,	$02,	nC2,	nC2
	dc.b		$07,	nRst,	$05,	nG2,	$02,	nA2,	nD2,	nC2
	dc.b		nRst,	nD2,	$0C,	nRst,	$02,	nD2,	nD2,	nD2
	dc.b		$07,	nRst,	$01,	nC2,	$02,	nD2,	nRst,	nD2
	dc.b		$08,	nRst,	$04,	nD2,	$02,	nF2,	nG2,	nA2
	dc.b		nG2,	nE2,	nC2,	nBb1,	nRst,	$04,	nBb1,	$02
	dc.b		$02,	$02,	nRst,	$02,	nBb1,	nBb1,	$07,	nRst
	dc.b		$05,	nG2,	$02,	nA2,	nC2,	nRst,	$04,	nC2
	dc.b		$02,	$02,	$02,	nRst,	$02,	nC2,	nC2,	$07
	dc.b		nRst,	$05,	nG2,	$02,	nA2,	nD2,	nC2,	nRst
	dc.b		nD2,	$0C,	nRst,	$02,	nD2,	nD2,	nD2,	$07
	dc.b		nRst,	$01,	nD2,	$02,	nRst,	nC2,	nD2,	nRst
	dc.b		nC2,	nD2,	$06,	$02,	nF2,	$02,	nG2,	nA2
	dc.b		nG2,	nE2,	nC2,	nC2,	nD2,	nRst,	nD2,	$0C
	dc.b		nRst,	$02,	nD2,	nRst,	$04,	nD2,	$02,	nF2
	dc.b		$08,	nRst,	$02,	nG2,	nRst,	$04,	nG2,	$02
	dc.b		nRst,	$06,	nG2,	$02,	nRst,	nF2,	nRst,	nF2
	dc.b		nG2,	nBb1,	nC2,	nRst,	nC2,	$0D,	nRst,	$01
	dc.b		nC2,	$04,	nRst,	$02,	nD2,	nRst,	nF2,	$06
	dc.b		nRst,	$02,	nF2,	nF2,	nRst,	nF2,	nRst,	nF2
	dc.b		nRst,	$04,	nF2,	$02,	nRst,	nF2,	nRst,	nF2
	dc.b		nA1,	$06,	nBb1,	$02,	nRst,	nBb1,	nRst,	nBb1
	dc.b		nBb1,	$07,	nRst,	$05,	nA2,	$02,	nBb2,	nBb1
	dc.b		$06,	nC2,	$02,	nRst,	nC2,	nRst,	nC2,	nC2
	dc.b		$07,	nRst,	$05,	nC2,	$02,	$02,	$02,	nRst
	dc.b		$04,	nD2,	$09,	nRst,	$03,	nD2,	$02,	nRst
	dc.b		$04,	nD2,	$02,	nRst,	$06,	nC2,	$02,	nD2
	dc.b		nRst,	nD2,	$09,	nRst,	$03,	nD2,	$02,	nF2
	dc.b		nG2,	nA2,	nG2,	nF2,	nC2,	nA1,	$06,	nBb1
	dc.b		$02,	nRst,	nBb1,	nRst,	nBb1,	nBb1,	$07,	nRst
	dc.b		$05,	nA2,	$02,	nBb2,	nBb1,	$06,	nC2,	$02
	dc.b		nRst,	nC2,	nRst,	nC2,	nC2,	$07,	nRst,	$05
	dc.b		nC2,	$02,	$02,	$02,	nRst,	$04,	nD2,	$09
	dc.b		nRst,	$03,	nD2,	$02,	nRst,	$04,	nD2,	$07
	dc.b		nRst,	$01,	nC2,	$02,	nD2,	nRst,	nD2,	$09
	dc.b		nRst,	$03,	nD2,	$02,	nF2,	nG2,	nA2,	nG2
	dc.b		nF2,	nC2
;	Jump To	 	location
	smpsJump	Guile_FM3

; FM4 Data
Guile_FM4:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nA4,	$02,	nRst,	nA4,	nG4,	nRst,	nG4,	nA4
	dc.b		$0E,	$02,	nG4,	$02,	nRst,	nA4,	nRst,	nA4
	dc.b		nG4,	nRst,	nG4,	nA4,	$0E,	$02,	nG4,	$02
	dc.b		nRst,	nA4,	nG4,	nRst,	nA4,	nRst,	nG4,	nRst
	dc.b		nBb4,	nRst,	nBb4,	nA4,	$04,	nG4,	nE4,	nA4
	dc.b		$02,	nRst,	nA4,	nG4,	nRst,	nG4,	nA4,	$0E
	dc.b		$02,	nG4,	$02,	nRst,	nA4,	nRst,	nA4,	nG4
	dc.b		nRst,	nG4,	nA4,	$0E,	$02,	nG4,	$02,	nRst
	dc.b		nA4,	nG4,	nRst,	nA4,	nRst,	nG4,	nRst,	nBb4
	dc.b		nRst,	nBb4,	nA4,	$04,	nG4,	nE4
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nD4,	$14,	nE4,	$04,	nF4,	$02,	nG4,	$06
	dc.b		nA4,	nRst,	nC5,	$08,	nRst,	$04,	nA4,	$02
	dc.b		nBb4,	$06,	nE4,	$04,	nRst,	$02,	nF4,	$04
	dc.b		nRst,	$02,	nG4,	$04,	nRst,	nC4,	nE4,	nG4
	dc.b		nBb4,	$06,	nC5,	nA4,	$04,	nRst,	nA4,	nG4
	dc.b		nRst,	nD4,	$14,	nE4,	$02,	nRst,	nF4,	nBb3
	dc.b		$04,	nRst,	$02,	nA4,	$06,	nRst,	$12,	nA4
	dc.b		$02,	nRst,	$06,	nC5,	$14,	nD5,	$02,	nRst
	dc.b		nE5,	nF5,	$04,	nRst,	$02,	nA5,	$06,	nRst
	dc.b		$0A,	nE5,	$06,	nRst,	$02,	nC5,	$06,	nRst
	dc.b		$7F,	$03,	nBb5,	$14,	nRst,	$0C,	nG5,	$06
	dc.b		nRst,	$0A,	nE5,	$06,	nRst,	$4A,	nD5,	$14
	dc.b		nE5,	$02,	nRst,	nF5,	nRst,	$04,	nA5,	$08
	dc.b		nBb5,	$04,	nRst,	$02,	nBb4,	nRst,	$06,	nE5
	dc.b		$02,	nRst,	nD5,	nE5,	$04,	nRst,	$02,	nE5
	dc.b		$07,	nRst,	$01,	nF5,	$06,	nG5,	$02,	nRst
	dc.b		$06,	nC5,	$04,	nE5,	$02,	nRst,	nBb5,	$0C
	dc.b		nRst,	$02,	nA5,	nG5,	nA5,	$06,	nRst,	$02
	dc.b		nG5,	$04,	nF5,	nD5,	$14,	nE5,	$04,	nF5
	dc.b		nG5,	nG5,	$0E,	nRst,	$0A,	nF5,	$02,	nRst
	dc.b		$06,	nE5,	$04,	nRst,	$02,	nD5,	$18,	nRst
	dc.b		$22,	nD5,	$0E,	nRst,	$06,	nE5,	$02,	nRst
	dc.b		nF5,	nG5,	nRst,	nA5,	$08,	nRst,	$02,	nD5
	dc.b		$06,	nC6,	nBb5,	$04,	nA5,	nG5,	nE5,	nRst
	dc.b		$02,	nD5,	$18,	nRst,	$22
;	Jump To	 	location
	smpsJump	Guile_FM4

; FM5 Data
Guile_FM5:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nF5,	$02,	nRst,	nF5,	nE5,	nRst,	nE5,	nF5
	dc.b		$0F,	nRst,	$01,	nE5,	$02,	nRst,	nF5,	nRst
	dc.b		nF5,	nE5,	nRst,	nE5,	nF5,	$0F,	nRst,	$01
	dc.b		nE5,	$02,	nRst,	nF5,	nE5,	nRst,	nF5,	nRst
	dc.b		nE5,	nRst,	nG5,	nRst,	nG5,	nF5,	$04,	nE5
	dc.b		nC5,	nF5,	$02,	nRst,	nF5,	nE5,	nRst,	nE5
	dc.b		nF5,	$0F,	nRst,	$01,	nE5,	$02,	nRst,	nF5
	dc.b		nRst,	nF5,	nE5,	nRst,	nE5,	nF5,	$0F,	nRst
	dc.b		$01,	nE5,	$02,	nRst,	nF5,	nE5,	nRst,	nF5
	dc.b		nRst,	nE5,	nRst,	nG5,	nRst,	nG5,	nF5,	nRst
	dc.b		nE5,	nRst,	nC5,	nRst
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nF3,	$14,	nG3,	$04,	nA3,	$02,	nBb3,	$06
	dc.b		nC4,	nA4,	$02,	nG4,	$04,	nD4,	$08,	nBb4
	dc.b		$04,	nC4,	$02,	nD4,	$06,	nC4,	$04,	nRst
	dc.b		$02,	nD4,	$04,	nRst,	$02,	nE4,	$04,	nRst
	dc.b		nG3,	nBb3,	nE4,	nG4,	$06,	nA4,	nE4,	$04
	dc.b		nRst,	nC4,	nC4,	nE4,	nF3,	$14,	nG3,	$02
	dc.b		nRst,	nA3,	nG4,	$04,	nRst,	$02,	nD4,	$06
	dc.b		nA4,	$02,	nBb4,	$04,	nG4,	nRst,	nG4,	$02
	dc.b		nRst,	nF4,	nBb4,	nRst,	$04,	nG4,	$14,	nA4
	dc.b		$02,	nRst,	nG4,	nF4,	$04,	nRst,	$02,	nE4
	dc.b		$06,	nRst,	$02,	nG5,	$06,	nRst,	$02,	nG4
	dc.b		$06,	nRst,	$02,	nA4,	$06,	nRst,	$02,	nD5
	dc.b		$14,	nE5,	$04,	nF5,	nG5,	nD5,	$14,	nE5
	dc.b		$04,	nF5,	nG5,	nA5,	$32,	nRst,	$04,	$02
	dc.b		nD5,	$04,	$04,	nF4,	$14,	nA5,	$02,	nRst
	dc.b		nG5,	nA5,	$04,	nRst,	$02,	nG4,	$06,	nRst
	dc.b		$02,	nF5,	$06,	nRst,	$02,	nE4,	$06,	nRst
	dc.b		$02,	nC5,	$06,	nRst,	$02,	nD5,	$06,	nRst
	dc.b		$02,	nA4,	$2E,	nRst,	$02,	nC5,	$04,	$04
	dc.b		nF4,	$14,	nG4,	$02,	nRst,	nA4,	nG5,	nRst
	dc.b		nC5,	$08,	nD5,	$04,	nRst,	$02,	nG5,	nRst
	dc.b		$06,	nG4,	$02,	nRst,	nG4,	nG4,	$04,	nRst
	dc.b		$02,	nC4,	$07,	nRst,	$01,	nD4,	$06,	nE4
	dc.b		$02,	nRst,	$06,	nE4,	$04,	$02,	nRst,	$02
	dc.b		nG4,	$0C,	nRst,	$02,	nF4,	nE4,	nF4,	$06
	dc.b		nRst,	$02,	nE4,	$04,	nD4,	nF4,	$14,	nA4
	dc.b		$04,	nBb4,	nA4,	nC5,	$0E,	nRst,	$02,	nBb4
	dc.b		$04,	nA5,	nA4,	$02,	nE5,	$04,	nRst,	$02
	dc.b		nG4,	$04,	nF5,	$02,	nF4,	$18,	nRst,	$1A
	dc.b		nC5,	$02,	nRst,	nC5,	nRst,	nF4,	$0E,	nRst
	dc.b		$06,	nG4,	$02,	nRst,	nA4,	nBb4,	nRst,	nC5
	dc.b		$08,	nRst,	$02,	nA4,	$06,	$06,	nG4,	$04
	dc.b		nF4,	nE4,	nG4,	nF5,	$02,	nF4,	$18,	nRst
	dc.b		$22
;	Jump To	 	location
	smpsJump	Guile_FM5

; PSG1 Data
Guile_PSG1:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nA4,	$02,	nRst,	nA4,	nG4,	nRst,	nG4,	nA4
	dc.b		$0E,	$02,	nG4,	$02,	nRst,	nA4,	nRst,	nA4
	dc.b		nG4,	nRst,	nG4,	nA4,	$0E,	$02,	nG4,	$02
	dc.b		nRst,	nA4,	nG4,	nRst,	nA4,	nRst,	nG4,	nRst
	dc.b		nBb4,	nRst,	nBb4,	nA4,	$04,	nG4,	nE4,	nA4
	dc.b		$02,	nRst,	nA4,	nG4,	nRst,	nG4,	nA4,	$0E
	dc.b		$02,	nG4,	$02,	nRst,	nA4,	nRst,	nA4,	nG4
	dc.b		nRst,	nG4,	nA4,	$0E,	$02,	nG4,	$02,	nRst
	dc.b		nA4,	nG4,	nRst,	nA4,	nRst,	nG4,	nRst,	nBb4
	dc.b		nRst,	nBb4,	nA4,	$04,	nG4,	nE4,	nRst,	$02
	dc.b		nC4,	nRst,	nD4,	$0D,	nRst,	$01,	nC4,	$02
	dc.b		nRst,	$04,	nD4,	nRst,	$02,	nD4,	nC4,	nRst
	dc.b		nD4,	$0D,	nRst,	$01,	nC4,	$02,	nRst,	$04
	dc.b		nD4,	nRst,	$02,	nE4,	nD4,	nRst,	nE4,	$0D
	dc.b		nRst,	$01,	nD4,	$02,	nRst,	$04,	nE4,	nRst
	dc.b		$02,	nE4,	nE4,	nRst,	$04,	nE4,	$0B,	nRst
	dc.b		$01,	nE4,	$02,	nRst,	$04,	nE4,	$06,	nD4
	dc.b		$02,	nC4,	nRst,	nD4,	$0D,	nRst,	$01,	nC4
	dc.b		$02,	nRst,	$04,	nF4,	nRst,	$02,	nD4,	nC4
	dc.b		nRst,	nD4,	$0D,	nRst,	$01,	nC4,	$02,	nRst
	dc.b		$04,	nD4,	nRst,	$02,	nE4,	nD4,	nRst,	nE4
	dc.b		$0D,	nRst,	$01,	nD4,	$02,	nRst,	$04,	nE4
	dc.b		nRst,	$02,	nE4,	nE4,	nRst,	$04,	nE4,	$0B
	dc.b		nRst,	$01,	nE4,	$02,	nRst,	$04,	nE4,	$06
	dc.b		nF4,	$1E,	nRst,	$02,	nG4,	$0E,	nRst,	$02
	dc.b		nE4,	$0E,	nRst,	$02,	nD5,	nC5,	nRst,	nD5
	dc.b		$16,	nC5,	$02,	nRst,	nD5,	nRst,	nD5,	nC5
	dc.b		nRst,	nC5,	nD5,	$12,	nRst,	$02,	nF4,	$1E
	dc.b		nRst,	$02,	nG4,	$0E,	nRst,	$02,	nE4,	$0E
	dc.b		nRst,	$02,	nD5,	nC5,	nRst,	nD5,	$16,	nC5
	dc.b		$02,	nRst,	nD5,	nRst,	nD5,	nC5,	nRst,	nC5
	dc.b		nD5,	$0B,	nRst,	$01,	nD5,	$04,	nC5,	nD4
	dc.b		$02,	nC4,	nRst,	nD4,	$0D,	nRst,	$01,	nC4
	dc.b		$02,	nRst,	$04,	nD4,	nD4,	$08,	$06,	nF4
	dc.b		$04,	nD4,	$02,	nRst,	nD4,	nRst,	nD4,	nD4
	dc.b		$06,	nE4,	$02,	nD4,	nRst,	$04,	nE4,	$0B
	dc.b		nRst,	$01,	nC4,	$02,	nRst,	$04,	nE4,	nF4
	dc.b		$0D,	nRst,	$01,	nE4,	$04,	nF4,	$02,	nRst
	dc.b		nF4,	nRst,	nF4,	nE4,	$06,	nD4,	$1E,	nRst
	dc.b		$02,	nC4,	$0E,	nRst,	$02,	nE4,	$0E,	nRst
	dc.b		$02,	nD4,	nC4,	nRst,	nD4,	$16,	nC4,	$02
	dc.b		nRst,	nD4,	nRst,	nD4,	nC4,	nRst,	nC4,	nD4
	dc.b		$0B,	nRst,	$01,	nF4,	$02,	nRst,	nE4,	nRst
	dc.b		nD4,	$1E,	nRst,	$02,	nC4,	$0E,	nRst,	$02
	dc.b		nE4,	$0E,	nRst,	$02,	nD4,	nC4,	nRst,	nD4
	dc.b		$16,	nC4,	$02,	nRst,	nD4,	nRst,	nD4,	nC4
	dc.b		nRst,	nC4,	nD4,	$0B,	nRst,	$01,	nD4,	$02
	dc.b		nRst,	nC4,	nRst
;	Jump To	 	location
	smpsJump	Guile_PSG1

; PSG2 Data
Guile_PSG2:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nF5,	$02,	nRst,	nF5,	nE5,	nRst,	nE5,	nF5
	dc.b		$0F,	nRst,	$01,	nE5,	$02,	nRst,	nF5,	nRst
	dc.b		nF5,	nE5,	nRst,	nE5,	nF5,	$0F,	nRst,	$01
	dc.b		nE5,	$02,	nRst,	nF5,	nE5,	nRst,	nF5,	nRst
	dc.b		nE5,	nRst,	nG5,	nRst,	nG5,	nF5,	$04,	nE5
	dc.b		nC5,	nF5,	$02,	nRst,	nF5,	nE5,	nRst,	nE5
	dc.b		nF5,	$0F,	nRst,	$01,	nE5,	$02,	nRst,	nF5
	dc.b		nRst,	nF5,	nE5,	nRst,	nE5,	nF5,	$0F,	nRst
	dc.b		$01,	nE5,	$02,	nRst,	nF5,	nE5,	nRst,	nF5
	dc.b		nRst,	nE5,	nRst,	nG5,	nRst,	nG5,	nF5,	nRst
	dc.b		nE5,	nRst,	nC5,	nRst,	$04,	nE4,	$02,	nRst
	dc.b		nF4,	$0D,	nRst,	$01,	nE4,	$02,	nRst,	$04
	dc.b		nF4,	nRst,	$02,	nF4,	nE4,	nRst,	nF4,	$0D
	dc.b		nRst,	$01,	nE4,	$02,	nRst,	$04,	nF4,	nRst
	dc.b		$02,	nG4,	nF4,	nRst,	nG4,	$0D,	nRst,	$01
	dc.b		nF4,	$02,	nRst,	$04,	nG4,	nRst,	$02,	nG4
	dc.b		nG4,	nRst,	$04,	nA4,	$0B,	nRst,	$01,	nG4
	dc.b		$02,	nRst,	$04,	nA4,	$06,	nF4,	$02,	nE4
	dc.b		nRst,	nF4,	$0D,	nRst,	$01,	nE4,	$02,	nRst
	dc.b		$04,	nD4,	nRst,	$02,	nF4,	nE4,	nRst,	nF4
	dc.b		$0D,	nRst,	$01,	nE4,	$02,	nRst,	$04,	nF4
	dc.b		nRst,	$02,	nG4,	nF4,	nRst,	nG4,	$0D,	nRst
	dc.b		$01,	nF4,	$02,	nRst,	$04,	nG4,	nRst,	$02
	dc.b		nG4,	nG4,	nRst,	$04,	nA4,	$0B,	nRst,	$01
	dc.b		nG4,	$02,	nRst,	$04,	nA4,	$06,	$1E,	nRst
	dc.b		$22,	nF5,	$02,	nE5,	nRst,	nF5,	$16,	nE5
	dc.b		$02,	nRst,	nF5,	nRst,	nF5,	nE5,	nRst,	nE5
	dc.b		nF5,	$12,	nRst,	$02,	nA4,	$1E,	nRst,	$22
	dc.b		nF5,	$02,	nE5,	nRst,	nF5,	$16,	nE5,	$02
	dc.b		nRst,	nF5,	nRst,	nF5,	nE5,	nRst,	nE5,	nF5
	dc.b		$0B,	nRst,	$01,	nF5,	$04,	nE5,	nF4,	$02
	dc.b		nE4,	nRst,	nF4,	$0D,	nRst,	$01,	nE4,	$02
	dc.b		nRst,	$04,	nF4,	nF4,	$08,	nG4,	$06,	nF4
	dc.b		$04,	nG4,	$02,	nRst,	nG4,	nRst,	nG4,	nF4
	dc.b		$06,	nG4,	$02,	nF4,	nRst,	$04,	nG4,	$0B
	dc.b		nRst,	$01,	nE4,	$02,	nRst,	$04,	nG4,	nA4
	dc.b		$0D,	nRst,	$01,	nG4,	$04,	nA4,	$02,	nRst
	dc.b		nA4,	nRst,	nA4,	nG4,	$06,	nF4,	$1E,	nRst
	dc.b		$22,	nF4,	$02,	nE4,	nRst,	nF4,	$16,	nE4
	dc.b		$02,	nRst,	nF4,	nRst,	nF4,	nE4,	nRst,	nE4
	dc.b		nF4,	$0B,	nRst,	$01,	nA4,	$02,	nRst,	nG4
	dc.b		nRst,	nF4,	$1E,	nRst,	$22,	nF4,	$02,	nE4
	dc.b		nRst,	nF4,	$16,	nE4,	$02,	nRst,	nF4,	nRst
	dc.b		nF4,	nE4,	nRst,	nE4,	nF4,	$0B,	nRst,	$01
	dc.b		nF4,	$02,	nRst,	nE4,	nRst
;	Jump To	 	location
	smpsJump	Guile_PSG2

; DAC Data
Guile_DAC:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$85,	$07,	nRst,	$01,	dKick,	$07,	nRst,	$09
	dc.b		dSnare,	$07,	nRst,	$01,	$85,	$07,	nRst,	$01
	dc.b		dKick,	$07,	nRst,	$09,	dSnare,	$07,	nRst,	$01
	dc.b		dKick,	$02,	$02,	nRst,	$04,	dSnare,	$02,	nRst
	dc.b		$04,	dKick,	$02,	nRst,	$06,	dKick,	$02,	dSnare
	dc.b		dMidTimpani,	nRst,	dLowTimpani,	$85,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	$04,	dKick,	$02,	nRst,	$04,	dKick,	$02
	dc.b		$02,	dSnare,	$02,	nRst,	$06,	$85,	$02,	nRst
	dc.b		$06,	dSnare,	$02,	nRst,	$04,	dKick,	$02,	nRst
	dc.b		$04,	dKick,	$02,	$02,	dSnare,	$02,	nRst,	$06
	dc.b		dKick,	$02,	$02,	nRst,	$04,	dSnare,	$02,	nRst
	dc.b		$04,	dKick,	$02,	nRst,	dLowTimpani,	dVLowTimpani,	nRst,	dVLowTimpani
	dc.b		dMidTimpani,	nRst,	dLowTimpani,	$85,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	$04,	dKick,	$02,	nRst,	$04,	dKick,	$02
	dc.b		$02,	dSnare,	$02,	nRst,	$06,	dKick,	$02,	nRst
	dc.b		$06,	dSnare,	$02,	nRst,	$04,	dKick,	$02,	nRst
	dc.b		dKick,	nRst,	dKick,	dSnare,	nRst,	dKick,	nRst,	dKick
	dc.b		nRst,	$06,	dSnare,	$02,	nRst,	$04,	dKick,	$02
	dc.b		nRst,	$04,	dKick,	$02,	$02,	dSnare,	$02,	nRst
	dc.b		$06,	dKick,	$02,	$02,	nRst,	$04,	dSnare,	$02
	dc.b		nRst,	dKick,	nRst,	$04,	dKick,	$02,	nRst,	dKick
	dc.b		dSnare,	nRst,	dKick,	nRst,	$85,	nRst,	$06,	dSnare
	dc.b		$02,	nRst,	$04,	dKick,	$02,	nRst,	$04,	dKick
	dc.b		$02,	$02,	dSnare,	$02,	nRst,	$06,	dKick,	$02
	dc.b		nRst,	$06,	dSnare,	$02,	nRst,	$04,	dKick,	$02
	dc.b		nRst,	dKick,	nRst,	dKick,	dSnare,	nRst,	dKick,	nRst
	dc.b		dKick,	nRst,	$06,	dSnare,	$02,	nRst,	$04,	dKick
	dc.b		$02,	nRst,	$04,	dKick,	$02,	$02,	dSnare,	$02
	dc.b		nRst,	$06,	$85,	$02,	nRst,	$06,	$85,	$02
	dc.b		nRst,	$04,	dKick,	$02,	dSnare,	dKick,	dSnare,	dKick
	dc.b		dSnare,	dSnare,	dKick,	dKick,	$85,	nRst,	$04,	dKick
	dc.b		$02,	dSnare,	dKick,	nRst,	dKick,	dKick,	nRst,	$06
	dc.b		dSnare,	$02,	nRst,	$06,	$85,	$02,	nRst,	$04
	dc.b		dKick,	$02,	dSnare,	dKick,	nRst,	dKick,	dKick,	nRst
	dc.b		$06,	dSnare,	$02,	nRst,	$06,	dKick,	$02,	nRst
	dc.b		$06,	dSnare,	$02,	nRst,	$04,	dKick,	$02,	nRst
	dc.b		$04,	dKick,	$02,	$02,	dSnare,	$02,	nRst,	$06
	dc.b		dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst,	$04
	dc.b		dKick,	$02,	nRst,	$04,	dKick,	$02,	$02,	dSnare
	dc.b		$02,	nRst,	$06,	$85,	$02,	nRst,	$04,	dKick
	dc.b		$02,	dSnare,	dKick,	nRst,	dKick,	dKick,	nRst,	$06
	dc.b		dSnare,	$02,	nRst,	$06,	$85,	$02,	nRst,	$04
	dc.b		dKick,	$02,	dSnare,	dKick,	nRst,	dKick,	dKick,	nRst
	dc.b		$06,	dSnare,	$02,	nRst,	$06,	dKick,	$02,	nRst
	dc.b		$06,	dSnare,	$02,	nRst,	$04,	dKick,	$02,	nRst
	dc.b		$04,	dKick,	$02,	$02,	dSnare,	$02,	nRst,	$06
	dc.b		$85,	$02,	nRst,	dKick,	$85,	nRst,	dKick,	$85
	dc.b		nRst,	$04,	dVLowTimpani,	$02,	$02,	nRst,	$02,	dVLowTimpani
	dc.b		dMidTimpani,	$01,	$01,	dLowTimpani,	$02,	dVLowTimpani,	$85,	nRst
	dc.b		$06,	dSnare,	$02,	nRst,	$04,	dKick,	$02,	$02
	dc.b		nRst,	$06,	dSnare,	$02,	nRst,	$04,	dKick,	$02
	dc.b		nRst,	$06,	dKick,	$02,	dSnare,	nRst,	dKick,	nRst
	dc.b		dKick,	nRst,	$06,	dSnare,	$02,	nRst,	dKick,	nRst
	dc.b		dKick,	nRst,	$06,	dSnare,	$02,	nRst,	dKick,	dKick
	dc.b		nRst,	$08,	dSnare,	$02,	dKick,	nRst,	dKick,	nRst
	dc.b		$06,	dKick,	$02,	dSnare,	nRst,	dKick,	nRst,	dKick
	dc.b		nRst,	$04,	dKick,	$02,	dSnare,	nRst,	$06,	dKick
	dc.b		$02,	nRst,	$04,	dKick,	$02,	dSnare,	dKick,	nRst
	dc.b		dKick,	dKick,	nRst,	$06,	dSnare,	$02,	nRst,	$06
	dc.b		dKick,	$02,	nRst,	$04,	dKick,	$02,	dSnare,	dKick
	dc.b		nRst,	dKick,	dKick,	nRst,	$06,	dSnare,	$02,	nRst
	dc.b		$06,	$85,	$02,	nRst,	dKick,	$85,	nRst,	$04
	dc.b		dKick,	$02,	nRst,	dSnare,	dKick,	nRst,	dSnare,	nRst
	dc.b		$06,	dVLowTimpani,	$02,	dKick,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	dKick,	nRst,	$04,	dVLowTimpani,	$02,	dMidTimpani,	dLowTimpani
	dc.b		dSnare,	nRst,	dSnare,	dSnare,	dKick,	nRst,	$04,	dKick
	dc.b		$02,	dSnare,	dKick,	nRst,	dKick,	dKick,	nRst,	$06
	dc.b		dSnare,	$02,	nRst,	dKick,	nRst,	dKick,	nRst,	$04
	dc.b		dKick,	$02,	dSnare,	dKick,	nRst,	dKick,	dKick,	nRst
	dc.b		dSnare,	$01,	$01,	$01,	$01,	$02,	nRst,	$06
	dc.b		$85,	$02,	dKick,	nRst,	$85,	nRst,	$08,	dVLowTimpani
	dc.b		$02,	dMidTimpani,	dLowTimpani,	dVLowTimpani,	dSnare,	dKick,	nRst,	$04
	dc.b		$85,	$02,	dKick,	nRst,	$85,	nRst,	dKick,	$85
	dc.b		nRst,	$06,	dVLowTimpani,	$02,	dMidTimpani,	dLowTimpani,	nRst,	dVLowTimpani
	dc.b		dMidTimpani
;	Jump To	 	location
	smpsJump	Guile_DAC

Guile_Voices:
	dc.b		$3A,$E1,$EA,$11,$E2,$10,$91,$51,$11,$0E,$0E,$0E,$03,$00,$00,$00
	dc.b		$00,$17,$F7,$17,$07,$17,$3A,$1A,$14;			Voice 00
	dc.b		$20,$36,$35,$30,$31,$DF,$DF,$9F,$9F,$07,$06,$09,$06,$07,$06,$06
	dc.b		$08,$20,$10,$10,$F8,$19,$37,$13,$0C;			Voice 01
	dc.b		$3B,$06,$02,$02,$01,$12,$14,$19,$4F,$08,$05,$01,$01,$01,$01,$01
	dc.b		$01,$76,$FA,$F8,$F9,$1F,$39,$1F,$10;			Voice 02
	dc.b		$0D,$01,$01,$02,$01,$14,$0E,$0E,$0E,$00,$00,$00,$00,$00,$00,$00
	dc.b		$00,$06,$07,$07,$07,$2F,$10,$1C,$10;			Voice 03
	even
