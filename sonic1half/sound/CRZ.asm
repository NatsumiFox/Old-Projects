; =============================================================================================
; Project Name:		CityEscapeClassic
; Created:		2nd August 2012
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

CityEscapeClassic_Header:
;	Voice Pointer	location
	smpsHeaderVoice	CityEscapeClassic_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$00
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$02,	$03

;	DAC Pointer	location
	smpsHeaderDAC	CityEscapeClassic_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	CityEscapeClassic_FM1,	smpsPitch00,	$10
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	CityEscapeClassic_FM2,	smpsPitch00+$02,	$0B
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	CityEscapeClassic_FM3,	smpsPitch00,	$0E
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	CityEscapeClassic_FM5,	smpsPitch00,	$00
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	CityEscapeClassic_FM4,	smpsPitch00,	$0E

; FM1 Data
CityEscapeClassic_FM1:
	dc.b		nRst,	$1D
CityEscapeClassic_Jump01:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		nC5,	$01,	nD5,	nAb5,	nBb5,	nB5,	$05,	nRst
	dc.b		$31,	nE5,	$08,	nEb5,	nRst,	$3D,	nFs5,	$04
	dc.b		$04,	$04,	$06,	nE5,	$06,	nEb5,	$04,	nCs5
	dc.b		$06,	nEb5,	nB4,	$0C,	nRst,	$04,	nB4,	nEb5
	dc.b		$06,	nCs5,	nB4,	$04,	nCs5,	$06,	nB4,	nB4
	dc.b		$04,	nAb5,	$06,	nFs5,	nEb5,	$04,	nFs5,	$08
	dc.b		nEb5,	nRst,	$04,	nFs5,	nFs5,	nFs5,	nAb5,	$06
	dc.b		nEb5,	nEb5,	$04,	nFs5,	$06,	nEb5,	nB4,	$04
	dc.b		$08,	nRst,	$04,	nB4,	nEb5,	$06,	nCs5,	nB4
	dc.b		$04,	nCs5,	$06,	nB4,	nB4,	$04,	nAb5,	$06
	dc.b		nFs5,	nEb5,	$04,	nFs5,	$08,	nAb5,	nRst,	nAb5
	dc.b		nFs5,	nE5,	nEb5,	$04,	nE5,	nEb5,	nCs5,	$08
	dc.b		nB4,	nRst,	nAb5,	$04,	$04,	$04,	$04,	nFs5
	dc.b		$04,	$04,	nE5,	$04,	nEb5,	nE5,	nFs5,	nAb5
	dc.b		$08,	nFs5,	nRst,	$0C,	nAb5,	$08,	nFs5,	nE5
	dc.b		nEb5,	$04,	nE5,	nEb5,	nCs5,	$08,	nB4,	nRst
	dc.b		$04,	nE5,	$08,	nB4,	nAb4,	nB4,	nD5,	nCs5
	dc.b		nCs5,	nRst,	nEb5,	$06,	nCs5,	nB4,	$0C,	nRst
	dc.b		$08,	nEb5,	$06,	nCs5,	nCs5,	$0C,	nRst,	$08
	dc.b		nEb5,	$06,	nCs5,	nB4,	$04,	$06,	nCs5,	$06
	dc.b		nEb5,	$04,	nFs5,	$06,	nE5,	nEb5,	$04,	nCs5
	dc.b		$08,	nB4,	nRst,	nFs5,	nE5,	nEb5,	nCs5,	nRst
	dc.b		nD5,	nCs5,	nB4,	$0C
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		$04,	$10
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		nD5,	$06,	nCs5,	$04,	nRst,	$02,	nB4,	$04
	dc.b		$10,	nEb5,	$06,	nCs5,	$04,	nRst,	$02,	nB4
	dc.b		$04,	$04,	nAb4,	$04,	nB4,	nCs5,	nE5,	$08
	dc.b		nEb5,	nB4,	nAb4,	nB4,	$20,	nRst,	$5D
;	Jump To	 	location
	smpsJump	CityEscapeClassic_Jump01

; FM2 Data
CityEscapeClassic_FM2:
	dc.b		nRst,	$20
CityEscapeClassic_Jump02:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$05
	dc.b		nB1,	$04,	$04,	$02,	$02,	$02,	nA1,	$04
	dc.b		$04,	nAb1,	$04,	nFs1,	$02,	nE1,	$04,	nB1
	dc.b		nB1,	nB1,	$02,	$02,	$02,	nA1,	$04,	$04
	dc.b		nAb1,	$04,	nFs1,	$02,	nE1,	$04,	nB1,	nB1
	dc.b		nB1,	$02,	$02,	$02,	nA1,	$04,	$04,	nAb1
	dc.b		$04,	nFs1,	$02,	nE1,	$04,	nB1,	nB1,	nB1
	dc.b		$02,	$02,	$02,	nA1,	$04,	nRst,	$0E,	nB1
	dc.b		$04,	nRst,	$02,	nB1,	nFs1,	$04,	nA1,	nB1
	dc.b		nRst,	$02,	nFs1,	$04,	$02,	nA1,	$04,	nAb1
	dc.b		nRst,	$02,	nAb1,	nEb2,	$04,	nAb2,	nAb1,	nRst
	dc.b		$02,	nAb1,	$06,	$04,	nE1,	$04,	nRst,	$02
	dc.b		nE1,	nE2,	$08,	nE1,	$04,	nRst,	$02,	nE2
	dc.b		$04,	nRst,	$02,	nE2,	$04,	nE1,	nRst,	$02
	dc.b		nE1,	$04,	nRst,	$02,	nE1,	$0E,	nRst,	$02
	dc.b		nFs1,	nA1,	nB1,	$04,	nRst,	$02,	nB1,	nFs1
	dc.b		$04,	nA1,	nB1,	nRst,	$02,	nFs1,	$04,	$02
	dc.b		nA1,	$04,	nAb1,	nRst,	$02,	nAb1,	nEb2,	$04
	dc.b		nAb2,	nAb1,	nRst,	$02,	nAb1,	$06,	$04,	nE1
	dc.b		$04,	nRst,	$02,	nE1,	nE2,	$08,	nE1,	$04
	dc.b		nRst,	$02,	nE2,	$04,	nRst,	$02,	nE2,	$04
	dc.b		nFs1,	nRst,	$02,	nFs1,	$04,	nRst,	$02,	nFs1
	dc.b		$04,	nAb1,	$08,	nFs1,	nE1,	$04,	$02,	nE2
	dc.b		$02,	nE1,	nE1,	nE1,	$04,	nFs1,	nFs1,	$02
	dc.b		nFs2,	nFs1,	nFs1,	nFs1,	$04,	nB1,	nB1,	$02
	dc.b		nB2,	nB1,	nB1,	nB1,	$04,	nAb1,	nAb1,	$02
	dc.b		nAb2,	nAb1,	nAb1,	nAb1,	$04,	nE1,	nE1,	$02
	dc.b		nE2,	nE1,	nE1,	nE1,	$04,	nFs1,	nFs1,	$02
	dc.b		nFs2,	nFs1,	nFs1,	nFs1,	$04,	nB1,	nB1,	$02
	dc.b		nB2,	nB1,	nB1,	nB1,	$04,	nAb1,	nAb1,	$02
	dc.b		nAb2,	nAb1,	nAb1,	nAb1,	$04,	nE1,	nE1,	$02
	dc.b		nE2,	nE1,	nE1,	nE1,	$04,	nFs1,	nFs1,	$02
	dc.b		nFs2,	nFs1,	nFs1,	nFs1,	$04,	nB1,	nB1,	$02
	dc.b		nB2,	nB1,	nB1,	nB1,	$04,	nAb1,	nAb1,	$02
	dc.b		nAb2,	nAb1,	nAb1,	nAb1,	$04,	nE1,	nE1,	$02
	dc.b		$04,	$02,	$04,	$02,	$04,	$02,	$04,	nFs1
	dc.b		$04,	nG1,	nG1,	$02,	$04,	$02,	$04,	$02
	dc.b		$04,	$02,	nA1,	$08,	nFs1,	$06,	nB1,	nCs2
	dc.b		$04,	nD2,	$06,	nCs2,	nB1,	$04,	nG1,	$06
	dc.b		nB1,	nCs2,	$04,	nEb2,	$06,	nCs2,	nB1,	$04
	dc.b		nAb1,	$06,	nB1,	nCs2,	$04,	nE2,	$06,	nCs2
	dc.b		nB1,	$04,	nA1,	$08,	nE2,	$04,	nRst,	nE2
	dc.b		$06,	nA1,	nE2,	$04,	nE1,	$02,	$02,	$02
	dc.b		$02,	$02,	$02,	$02,	$02,	$02,	$02,	$02
	dc.b		$02,	$02,	$02,	$02,	nFs1,	$02,	nRst,	$04
	dc.b		nG1,	$08,	$04,	nA1,	$04,	nRst,	nA1,	$08
	dc.b		nFs1,	$06,	nB1,	nCs2,	$04,	nD2,	$06,	nCs2
	dc.b		nB1,	$04,	nG1,	$06,	nB1,	nCs2,	$04,	nEb2
	dc.b		$06,	nCs2,	nB1,	$04,	nAb1,	$06,	nB1,	nCs2
	dc.b		$04,	nE2,	$06,	nCs2,	nB1,	$04,	nA1,	$06
	dc.b		nE2,	nA1,	$04,	nE2,	$06,	nA1,	nE2,	$04
	dc.b		nE1,	$02,	$02,	$02,	$02,	$02,	$02,	$02
	dc.b		$02,	$02,	$02,	$02,	$02,	$02,	$02,	$02
	dc.b		nFs1,	$02,	nRst,	$04,	nG1,	$08,	$04,	$06
	dc.b		$06,	$04,	nA1,	$06,	nG1,	nAb1,	$04,	nA1
	dc.b		nRst,	nA1,	$28
;	Jump To	 	location
	smpsJump	CityEscapeClassic_Jump02

; FM3 Data
CityEscapeClassic_FM3:
	dc.b		nRst,	$20
CityEscapeClassic_Jump03:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$06
	dc.b		nB3,	$04,	$04,	$02,	$02,	$02,	nA3,	$04
	dc.b		$04,	nAb3,	$04,	nFs3,	$02,	nE3,	$04,	nB3
	dc.b		nB3,	nB3,	$02,	$02,	$02,	nA3,	$04,	$04
	dc.b		nAb3,	$04,	nFs3,	$02,	nE3,	$04,	nB3,	nB3
	dc.b		nB3,	$02,	$02,	$02,	nA3,	$04,	$04,	nAb3
	dc.b		$04,	nFs3,	$02,	nE3,	$04,	nB3,	nB3,	nB3
	dc.b		$02,	$02,	$02,	nA3,	$04,	nRst,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$53
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		nEb4,	$06,	nCs4,	nRst,	$7F,	$75
;	Jump To	 	location
	smpsJump	CityEscapeClassic_Jump03

; FM4 Data
CityEscapeClassic_FM4:
	dc.b		nRst,	$7F,	$21
CityEscapeClassic_Jump04:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$09
	dc.b		nB3,	$01,	nRst,	$03,	nB4,	$01,	nRst,	nB4
	dc.b		nRst,	nB3,	nRst,	nB3,	nRst,	nB4,	nRst,	nB3
	dc.b		nRst,	nB3,	nRst,	nB3,	nRst,	nB4,	nRst,	nB3
	dc.b		nRst,	$03,	nB3,	$01,	nRst,	nB4,	nRst,	$03
	dc.b		nAb3,	$01,	nRst,	$03,	nAb4,	$01,	nRst,	nAb4
	dc.b		nRst,	nAb3,	nRst,	nAb3,	nRst,	nAb4,	nRst,	nAb3
	dc.b		nRst,	nAb3,	nRst,	nAb3,	nRst,	nAb4,	nRst,	nAb3
	dc.b		nRst,	$03,	nAb3,	$01,	nRst,	nAb4,	nRst,	$03
	dc.b		nAb3,	$01,	nRst,	$03,	nAb4,	$01,	nRst,	nAb4
	dc.b		nRst,	nAb3,	nRst,	nAb3,	nRst,	nAb4,	nRst,	nAb3
	dc.b		nRst,	nAb3,	nRst,	nAb3,	nRst,	nAb4,	nRst,	nAb3
	dc.b		nRst,	$03,	nAb3,	$01,	nRst,	nAb4,	nRst,	$23
	dc.b		nB3,	$01,	nRst,	$03,	nB4,	$01,	nRst,	nB4
	dc.b		nRst,	nB3,	nRst,	nB3,	nRst,	nB4,	nRst,	nB3
	dc.b		nRst,	nB3,	nRst,	nB3,	nRst,	nB4,	nRst,	nB3
	dc.b		nRst,	$03,	nB3,	$01,	nRst,	nB4,	nRst,	$03
	dc.b		nAb3,	$01,	nRst,	$03,	nAb4,	$01,	nRst,	nAb4
	dc.b		nRst,	nAb3,	nRst,	nAb3,	nRst,	nAb4,	nRst,	nAb3
	dc.b		nRst,	nAb3,	nRst,	nAb3,	nRst,	nAb4,	nRst,	nAb3
	dc.b		nRst,	$03,	nAb3,	$01,	nRst,	nAb4,	nRst,	$03
	dc.b		nAb3,	$01,	nRst,	$03,	nAb4,	$01,	nRst,	nAb4
	dc.b		nRst,	nAb3,	nRst,	nAb3,	nRst,	nAb4,	nRst,	nAb3
	dc.b		nRst,	nAb3,	nRst,	nAb3,	nRst,	nAb4,	nRst,	nAb3
	dc.b		nRst,	$03,	nAb3,	$01,	nRst,	nAb4,	nRst,	$23
	dc.b		nE3,	$04,	nE4,	$01,	nRst,	nE4,	nRst,	nE3
	dc.b		$02,	$02,	nE4,	$01,	nRst,	$03,	nFs3,	$04
	dc.b		nFs4,	$01,	nRst,	nFs4,	nRst,	nFs3,	$02,	$02
	dc.b		nFs4,	$01,	nRst,	$03,	nB3,	$04,	nB4,	$01
	dc.b		nRst,	nB4,	nRst,	nB3,	$02,	$02,	nB4,	$01
	dc.b		nRst,	$03,	nAb3,	$04,	nAb4,	$01,	nRst,	nAb4
	dc.b		nRst,	nAb3,	$02,	$02,	nAb4,	$01,	nRst,	$03
	dc.b		nE3,	$04,	nE4,	$01,	nRst,	nE4,	nRst,	nE3
	dc.b		$02,	$02,	nE4,	$01,	nRst,	$03,	nFs3,	$04
	dc.b		nFs4,	$01,	nRst,	nFs4,	nRst,	nFs3,	$02,	$02
	dc.b		nFs4,	$01,	nRst,	$03,	nB3,	$04,	nB4,	$01
	dc.b		nRst,	nB4,	nRst,	nB3,	$02,	$02,	nB4,	$01
	dc.b		nRst,	$03,	nAb3,	$04,	nAb4,	$01,	nRst,	nAb4
	dc.b		nRst,	nAb3,	$02,	$02,	nAb4,	$01,	nRst,	$03
	dc.b		nE3,	$04,	nE4,	$01,	nRst,	nE4,	nRst,	nE3
	dc.b		$02,	$02,	nE4,	$01,	nRst,	$03,	nFs3,	$04
	dc.b		nFs4,	$01,	nRst,	nFs4,	nRst,	nFs3,	$02,	$02
	dc.b		nFs4,	$01,	nRst,	$03,	nB3,	$04,	nB4,	$01
	dc.b		nRst,	nB4,	nRst,	nB3,	$02,	$02,	nB4,	$01
	dc.b		nRst,	$03,	nAb3,	$04,	nAb4,	$01,	nRst,	nAb4
	dc.b		nRst,	nAb3,	$02,	$02,	nAb4,	$01,	nRst,	$03
	dc.b		nE3,	$04,	nE4,	$01,	nRst,	nE4,	nRst,	nE3
	dc.b		$02,	$02,	nE4,	$01,	nRst,	$03,	nE3,	$04
	dc.b		nE4,	$01,	nRst,	nE4,	nRst,	nE3,	$02,	$02
	dc.b		nFs4,	$01,	nRst,	$23,	nFs3,	$04,	nFs4,	$01
	dc.b		nRst,	nFs4,	nRst,	nFs3,	$02,	$02,	nFs4,	$01
	dc.b		nRst,	$03,	nFs3,	$04,	nFs4,	$01,	nRst,	nFs4
	dc.b		nRst,	nFs3,	$02,	$02,	nFs4,	$01,	nRst,	$03
	dc.b		nG3,	$04,	nG4,	$01,	nRst,	nG4,	nRst,	nG3
	dc.b		$02,	$02,	nG4,	$01,	nRst,	$03,	nG3,	$04
	dc.b		nG4,	$01,	nRst,	nG4,	nRst,	nG3,	$02,	$02
	dc.b		nG4,	$01,	nRst,	$03,	nAb3,	$04,	nAb4,	$01
	dc.b		nRst,	nAb4,	nRst,	nAb3,	$02,	$02,	nAb4,	$01
	dc.b		nRst,	$03,	nAb3,	$04,	nAb4,	$01,	nRst,	nAb4
	dc.b		nRst,	nAb3,	$02,	$02,	nAb4,	$01,	nRst,	$03
	dc.b		nA3,	$04,	nA4,	$01,	nRst,	nA4,	nRst,	nA3
	dc.b		$02,	$02,	nA4,	$01,	nRst,	$03,	nA3,	$04
	dc.b		nA4,	$01,	nRst,	nA4,	nRst,	nA3,	$02,	$02
	dc.b		nA4,	$01,	nRst,	$03,	nE3,	$04,	nE4,	$01
	dc.b		nRst,	nE4,	nRst,	nE3,	$02,	$02,	nE4,	$01
	dc.b		nRst,	$03,	nE3,	$04,	nE4,	$01,	nRst,	nE4
	dc.b		nRst,	nE3,	$02,	$02,	nE4,	$01,	nRst,	$23
	dc.b		nFs3,	$04,	nFs4,	$01,	nRst,	nFs4,	nRst,	nFs3
	dc.b		$02,	$02,	nFs4,	$01,	nRst,	$03,	nFs3,	$04
	dc.b		nFs4,	$01,	nRst,	nFs4,	nRst,	nFs3,	$02,	$02
	dc.b		nFs4,	$01,	nRst,	$03,	nG3,	$04,	nG4,	$01
	dc.b		nRst,	nG4,	nRst,	nG3,	$02,	$02,	nG4,	$01
	dc.b		nRst,	$03,	nG3,	$04,	nG4,	$01,	nRst,	nG4
	dc.b		nRst,	nG3,	$02,	$02,	nG4,	$01,	nRst,	$03
	dc.b		nAb3,	$04,	nAb4,	$01,	nRst,	nAb4,	nRst,	nAb3
	dc.b		$02,	$02,	nAb4,	$01,	nRst,	$03,	nAb3,	$04
	dc.b		nAb4,	$01,	nRst,	nAb4,	nRst,	nAb3,	$02,	$02
	dc.b		nAb4,	$01,	nRst,	$03,	nA3,	$04,	nA4,	$01
	dc.b		nRst,	nA4,	nRst,	nA3,	$02,	$02,	nA4,	$01
	dc.b		nRst,	$03,	nA3,	$04,	nA4,	$01,	nRst,	nA4
	dc.b		nRst,	nA3,	$02,	$02,	nA4,	$01,	nRst,	$03
	dc.b		nE3,	$04,	nE4,	$01,	nRst,	nE4,	nRst,	nE3
	dc.b		$02,	$02,	nE4,	$01,	nRst,	$03,	nE3,	$04
	dc.b		nE4,	$01,	nRst,	nE4,	nRst,	nE3,	$02,	$02
	dc.b		nE4,	$01,	nRst,	$7F,	$64
;	Jump To	 	location
	smpsJump	CityEscapeClassic_Jump04

; FM5 Data
CityEscapeClassic_FM5:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nB4,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		$04,	$02,	$02,	$02,	nA4,	$04,	$04,	nAb4
	dc.b		$04,	nFs4,	$02,	nE4,	$04,	nRst,	$7F,	$7F
	dc.b		$7F,	$03,	nB4,	$04,	nF4,	nB4,	nF4,	nB4
	dc.b		nF4,	nB4,	nF4,	nB4,	nB4,	nBb4,	nB4,	nF4
	dc.b		nB4,	nBb4,	nB4,	nB4,	nF4,	nB4,	nF4,	nCs5
	dc.b		nFs4,	nCs5,	nFs4,	nEb5,	nAb4,	nEb5,	nFs5,	nEb5
	dc.b		nCs5,	nB4,	$08,	$04,	nF4,	$04,	nB4,	nF4
	dc.b		nCs5,	nFs4,	nCs5,	nFs4,	nEb5,	nAb4,	nEb5,	nAb4
	dc.b		nE5,	nEb5,	nCs5,	nB4,	nE5,	nAb4,	nB4,	nFs4
	dc.b		nAb4,	nE4,	nB4,	$08,	nD5,	nCs5,	nB4,	nCs5
	dc.b		nEb5,	$06,	nCs5,	$04,	nRst,	$02,	nB4,	$04
	dc.b		$10,	nD5,	$06,	nCs5,	$04,	nRst,	$02,	nB4
	dc.b		$04,	$10,	nEb5,	$06,	nCs5,	$04,	nRst,	$02
	dc.b		nB4,	$04,	$04,	nAb4,	$04,	nB4,	nCs5,	nE5
	dc.b		$08,	nEb5,	nB4,	nAb4,	nB4,	$20,	nRst,	$04
	dc.b		nB4,	$08,	$04,	nCs5,	$04,	nRst,	nCs5,	$08
	dc.b		nEb5,	$06,	nCs5,	$04,	nRst,	$02,	nB4,	$04
	dc.b		$10,	nD5,	$06,	nCs5,	$04,	nRst,	$02,	nB4
	dc.b		$04,	$10,	nEb5,	$06,	nCs5,	$04,	nRst,	$02
	dc.b		nB4,	$04,	$04,	nAb4,	$04,	nB4,	nCs5,	nE5
	dc.b		$08,	nEb5,	nB4,	nAb4,	nB4,	$20,	nRst,	$04
	dc.b		nD5,	$1C,	nE5,	$06,	nD5,	nEb5,	$04,	nE5
	dc.b		nRst,	nE5,	nE5
;	Jump To	 	location
	smpsJump	CityEscapeClassic_FM5

; DAC Data
CityEscapeClassic_DAC:
	dc.b		nRst,	$20
CityEscapeClassic_Jump05:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$86,	$04,	nRst,	$85,	nRst,	$85,	nRst,	$85
	dc.b		nRst,	$85,	nRst,	$85,	nRst,	$85,	nRst,	$85
	dc.b		nRst,	$85,	nRst,	dKick,	$02,	nRst,	$06,	dKick
	dc.b		$02,	nRst,	$06,	dKick,	$02,	nRst,	$06,	dKick
	dc.b		$02,	nRst,	$0E,	$82,	$03,	nRst,	$01,	$82
	dc.b		$03,	nRst,	$01,	$82,	nRst,	$82,	nRst,	$82
	dc.b		nRst,	$82,	nRst,	$85,	$04,	nRst,	$82,	nRst
	dc.b		$85,	nRst,	$82,	nRst,	$85,	nRst,	$82,	nRst
	dc.b		$85,	nRst,	$82,	nRst,	$85,	nRst,	$82,	nRst
	dc.b		$85,	nRst,	$82,	nRst,	$85,	nRst,	$82,	nRst
	dc.b		$85,	nRst,	$82,	nRst,	$85,	nRst,	$82,	nRst
	dc.b		$85,	nRst,	$82,	nRst,	$85,	nRst,	$82,	nRst
	dc.b		$85,	nRst,	$82,	nRst,	$85,	nRst,	$82,	nRst
	dc.b		$85,	nRst,	$82,	nRst,	$85,	nRst,	$0C,	dKick
	dc.b		$10,	$85,	$04,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$85,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$85,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$85,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$85,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$85,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$85,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$85,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$85,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$85,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$85,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$85,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$85,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$85,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$85,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$85,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$85,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$85,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$85,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$85,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$85,	nRst,	$82,	nRst,	$85,	nRst
	dc.b		$82,	nRst,	$24
;	Jump To	 	location
	smpsJump	CityEscapeClassic_Jump05

CityEscapeClassic_Voices:
	dc.b		$3A,$01,$05,$31,$01,$59,$59,$5C,$4E,$0A,$0B,$0D,$04,$00,$00,$00
	dc.b		$00,$15,$58,$27,$06,$1D,$0F,$30,$10;			Voice 00
	dc.b		$3A,$01,$05,$31,$01,$59,$59,$5C,$4E,$0A,$0B,$0D,$04,$00,$00,$00
	dc.b		$00,$15,$58,$27,$06,$1D,$0F,$30,$10;			Voice 01
	dc.b		$3A,$01,$05,$31,$01,$59,$59,$5C,$4E,$0A,$0B,$0D,$04,$00,$00,$00
	dc.b		$00,$15,$58,$27,$06,$1D,$0F,$30,$10;			Voice 02
	dc.b		$3D,$01,$01,$01,$01,$94,$19,$19,$19,$0F,$0D,$0D,$0D,$07,$04,$04
	dc.b		$04,$25,$1A,$1A,$1A,$15,$80,$80,$80;			Voice 03
	dc.b		$3D,$01,$01,$01,$01,$94,$19,$19,$19,$0F,$0D,$0D,$0D,$07,$04,$04
	dc.b		$04,$25,$1A,$1A,$1A,$15,$80,$80,$80;			Voice 04
	dc.b		$3D,$01,$01,$01,$01,$94,$19,$19,$19,$0F,$0D,$0D,$0D,$07,$04,$04
	dc.b		$04,$25,$1A,$1A,$1A,$15,$80,$80,$80;			Voice 05
	dc.b		$38,$33,$01,$51,$01,$10,$13,$1A,$1B,$0F,$1F,$1F,$1F,$01,$01,$01
	dc.b		$01,$33,$03,$03,$08,$16,$1A,$19,$80;			Voice 06
	dc.b		$39,$03,$61,$22,$21,$1F,$1F,$12,$1F,$05,$05,$05,$0B,$00,$00,$00
	dc.b		$00,$10,$10,$18,$18,$1E,$1D,$15,$00;			Voice 07
	dc.b		$39,$03,$61,$22,$21,$1F,$1F,$12,$1F,$05,$05,$05,$0B,$00,$00,$00
	dc.b		$00,$10,$10,$18,$18,$1E,$1D,$15,$00;			Voice 08
	dc.b		$39,$03,$61,$22,$21,$1F,$1F,$12,$1F,$05,$05,$05,$0B,$00,$00,$00
	dc.b		$00,$10,$10,$18,$18,$1E,$1D,$15,$00;			Voice 09
	even
