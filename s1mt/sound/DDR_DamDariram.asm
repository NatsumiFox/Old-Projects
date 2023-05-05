; =============================================================================================
; Project Name:		DDR_Dam_Dariram
; Created:		17th January 2014
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

DDR_Dam_Dariram_Header:
;	Voice Pointer	location
	smpsHeaderVoice	DDR_Dam_Dariram_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$02
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$02,	$03

;	DAC Pointer	location
	smpsHeaderDAC	DDR_Dam_Dariram_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	DDR_Dam_Dariram_FM1,	smpsPitch01lo,	$10
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	DDR_Dam_Dariram_FM2,	smpsPitch04lo,	$11
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	DDR_Dam_Dariram_FM3,	smpsPitch01hi,	$0A
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	DDR_Dam_Dariram_FM4,	smpsPitch00,	$0C
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	DDR_Dam_Dariram_FM5,	smpsPitch01hi,	$04
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	DDR_Dam_Dariram_PSG1,	smpsPitch03lo,	$04,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	DDR_Dam_Dariram_PSG2,	smpsPitch02hi+$0B,	$02,	$00

; FM1 Data
DDR_Dam_Dariram_FM1:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		nFs4,	$20,	nAb4,	nA4,	nB4,	nFs4,	nAb4,	nA4
	dc.b		nD5,	nRst,	$7F,	$7F,	$02,	nFs4,	$20,	nAb4
	dc.b		nA4,	nD5,	nFs4,	nAb4,	nA4,	nRst,	nFs4,	nAb4
	dc.b		nA4,	nB4,	nFs4,	nAb4,	nA4,	nB4
;	Jump To	 	location
	smpsJump	DDR_Dam_Dariram_FM1

; FM2 Data
DDR_Dam_Dariram_FM2:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nFs5,	$20,	nAb5,	nA5,	nB5,	nFs5,	nAb5,	nA5
	dc.b		nB5,	nRst,	$7F,	$7F,	$02,	nFs5,	$20,	nAb5
	dc.b		nA5,	nD6,	nFs5,	nAb5,	nA5,	nRst,	nFs5,	nAb5
	dc.b		nA5,	nB5,	nFs5,	nAb5,	nA5,	nB5
;	Jump To	 	location
	smpsJump	DDR_Dam_Dariram_FM2

; FM3 Data
DDR_Dam_Dariram_FM3:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs1,	$04,	nFs2,	$02,	$02,	nFs1,	$04,	nFs2
	dc.b		nFs1,	nFs2,	$02,	$02,	nFs1,	$04,	nFs2,	nE1
	dc.b		nE2,	$02,	$02,	nE1,	$04,	nE2,	nE1,	nE2
	dc.b		$02,	$02,	nE1,	$04,	nE2,	nD1,	nD2,	$02
	dc.b		$02,	nD1,	$04,	nD2,	nD1,	nD2,	$02,	$02
	dc.b		nD1,	$04,	nD2,	nB0,	nB1,	$02,	$02,	nB0
	dc.b		$04,	nB1,	nB0,	nB1,	$02,	$02,	nB0,	$04
	dc.b		nB1
;	Jump To	 	location
	smpsJump	DDR_Dam_Dariram_FM3

; FM4 Data
DDR_Dam_Dariram_FM4:
	dc.b		nRst,	$7F,	$7F,	$02
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nCs4,	$0E,	nRst,	$06,	nCs4,	$04,	nB3,	nCs4
	dc.b		$08,	nD4,	nCs4,	nB3,	nCs4,	$12,	nRst,	$06
	dc.b		nCs4,	$04,	nD4,	nE4,	$08,	nD4,	nCs4,	nB3
	dc.b		nCs4,	$12,	nRst,	$06,	nCs4,	$04,	nB3,	nCs4
	dc.b		$08,	nD4,	nCs4,	nB3,	nA3,	$0E,	nRst,	$02
	dc.b		nA3,	$04,	$04,	nAb3,	$08,	$08,	nA3,	$04
	dc.b		$14,	nRst,	$04,	nFs4,	$08,	nCs4,	$04,	$04
	dc.b		$04,	$04,	$04,	nAb4,	$0C,	nCs4,	$04,	$04
	dc.b		$04,	$04,	$04,	nA4,	$0C,	$04,	nAb4,	$08
	dc.b		nE4,	nCs4,	nD4,	$04,	$14,	nRst,	$04,	nFs4
	dc.b		$08,	nCs4,	$04,	$04,	$04,	$04,	$04,	nAb4
	dc.b		$0C,	nCs4,	$04,	$04,	$04,	$04,	$04,	nA4
	dc.b		$08,	nAb4,	nA4,	nB4,	nAb4,	nA4,	$02,	nAb4
	dc.b		nFs4,	$0A,	nRst,	$02,	nCs4,	$04,	nFs4,	nAb4
	dc.b		nA4,	$08,	$04,	nAb4,	$04,	nA4,	$08,	$04
	dc.b		nAb4,	$04,	nA4,	$08,	$04,	nAb4,	$04,	nA4
	dc.b		nB4,	nA4,	nAb4,	nA4,	$08,	$04,	nAb4,	$04
	dc.b		nA4,	nAb4,	$08,	nFs4,	$12,	nRst,	$06,	nCs4
	dc.b		$04,	nFs4,	nAb4,	nA4,	$08,	$04,	nAb4,	$04
	dc.b		nA4,	$08,	$04,	nAb4,	$04,	nA4,	$08,	$04
	dc.b		nAb4,	$04,	nA4,	nB4,	nA4,	nAb4,	nA4,	$08
	dc.b		$04,	nAb4,	$04,	nA4,	nAb4,	$08,	nFs4,	$0C
	dc.b		nCs4,	$04,	$04,	nA4,	$04,	nAb4,	nFs4,	nAb4
;	Jump To	 	location
	smpsJump	DDR_Dam_Dariram_FM4

; FM5 Data
DDR_Dam_Dariram_FM5:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nA4,	$04,	nCs4,	$02,	nAb4,	$04,	nCs4,	$02
	dc.b		nA4,	$04,	nCs4,	$02,	nAb4,	$04,	nCs4,	$02
	dc.b		nA4,	$04,	nB4,	nAb4,	nCs4,	$02,	nFs4,	$04
	dc.b		nCs4,	$02,	nAb4,	$04,	nCs4,	$02,	nFs4,	$04
	dc.b		nCs4,	$02,	nAb4,	$04,	nFs4,	nA4,	nD4,	$02
	dc.b		nAb4,	$04,	nD4,	$02,	nA4,	$04,	nD4,	$02
	dc.b		nAb4,	$04,	nD4,	$02,	nA4,	$04,	nAb4,	nA4
	dc.b		nD4,	$02,	nAb4,	$04,	nD4,	$02,	nA4,	$04
	dc.b		nD4,	$02,	nAb4,	$04,	nD4,	$02,	nA4,	$04
	dc.b		nB4,	nA4,	nCs4,	$02,	nAb4,	$04,	nCs4,	$02
	dc.b		nA4,	$04,	nCs4,	$02,	nAb4,	$04,	nCs4,	$02
	dc.b		nA4,	$04,	nB4,	nAb4,	nCs4,	$02,	nFs4,	$04
	dc.b		nCs4,	$02,	nAb4,	$04,	nCs4,	$02,	nFs4,	$04
	dc.b		nCs4,	$02,	nAb4,	$04,	nFs4,	nA4,	nD4,	$02
	dc.b		nAb4,	$04,	nD4,	$02,	nA4,	$04,	nD4,	$02
	dc.b		nAb4,	$04,	nD4,	$02,	nA4,	$04,	nAb4,	nA4
	dc.b		nD4,	$02,	nAb4,	$04,	nD4,	$02,	nA4,	$04
	dc.b		nD4,	$02,	nAb4,	$04,	nD4,	$02,	nA4,	$04
	dc.b		nB4,	nRst,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$06
;	Jump To	 	location
	smpsJump	DDR_Dam_Dariram_FM5

; PSG1 Data
DDR_Dam_Dariram_PSG1:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nA5,	$04,	nCs5,	$02,	nAb5,	$04,	nCs5,	$02
	dc.b		nA5,	$04,	nCs5,	$02,	nAb5,	$04,	nCs5,	$02
	dc.b		nA5,	$04,	nB5,	nAb5,	nCs5,	$02,	nFs5,	$04
	dc.b		nCs5,	$02,	nAb5,	$04,	nCs5,	$02,	nFs5,	$04
	dc.b		nCs5,	$02,	nAb5,	$04,	nFs5,	nA5,	nD5,	$02
	dc.b		nAb5,	$04,	nD5,	$02,	nA5,	$04,	nD5,	$02
	dc.b		nAb5,	$04,	nD5,	$02,	nA5,	$04,	nAb5,	nA5
	dc.b		nD5,	$02,	nAb5,	$04,	nD5,	$02,	nA5,	$04
	dc.b		nD5,	$02,	nAb5,	$04,	nD5,	$02,	nA5,	$04
	dc.b		nB5,	nA5,	nCs5,	$02,	nAb5,	$04,	nCs5,	$02
	dc.b		nA5,	$04,	nCs5,	$02,	nAb5,	$04,	nCs5,	$02
	dc.b		nA5,	$04,	nB5,	nAb5,	nCs5,	$02,	nFs5,	$04
	dc.b		nCs5,	$02,	nAb5,	$04,	nCs5,	$02,	nFs5,	$04
	dc.b		nCs5,	$02,	nAb5,	$04,	nFs5,	nA5,	nD5,	$02
	dc.b		nAb5,	$04,	nD5,	$02,	nA5,	$04,	nD5,	$02
	dc.b		nAb5,	$04,	nD5,	$02,	nA5,	$04,	nAb5,	nA5
	dc.b		nD5,	$02,	nAb5,	$04,	nD5,	$02,	nA5,	$04
	dc.b		nD5,	$02,	nAb5,	$04,	nD5,	$02,	nA5,	$04
	dc.b		nB5,	nCs5,	$01,	nRst,	nFs4,	nRst,	nFs5,	nRst
	dc.b		nFs4,	nRst,	nCs5,	nRst,	nFs4,	nRst,	nFs5,	nRst
	dc.b		nFs4,	nRst,	nCs5,	nRst,	nFs4,	nRst,	nFs5,	nRst
	dc.b		nFs4,	nRst,	nCs5,	nRst,	nFs4,	nRst,	nFs5,	nRst
	dc.b		nFs4,	nRst,	nB4,	nRst,	nAb4,	nRst,	nE5,	nRst
	dc.b		nAb4,	nRst,	nB4,	nRst,	nAb4,	nRst,	nE5,	nRst
	dc.b		nAb4,	nRst,	nB4,	nRst,	nAb4,	nRst,	nE5,	nRst
	dc.b		nAb4,	nRst,	nB4,	nRst,	nAb4,	nRst,	nE5,	nRst
	dc.b		nAb4,	nRst,	nD5,	nRst,	nA4,	nRst,	nFs5,	nRst
	dc.b		nA4,	nRst,	nD5,	nRst,	nA4,	nRst,	nFs5,	nRst
	dc.b		nA4,	nRst,	nD5,	nRst,	nA4,	nRst,	nFs5,	nRst
	dc.b		nA4,	nRst,	nD5,	nRst,	nA4,	nRst,	nFs5,	nRst
	dc.b		nA4,	nRst,	nD5,	nRst,	nB4,	nRst,	nFs5,	nRst
	dc.b		nB4,	nRst,	nD5,	nRst,	nB4,	nRst,	nFs5,	nRst
	dc.b		nB4,	nRst,	nD5,	nRst,	nB4,	nRst,	nFs5,	nRst
	dc.b		nB4,	nRst,	nD5,	nRst,	nB4,	nRst,	nFs5,	nRst
	dc.b		nB4,	nRst,	nCs5,	nRst,	nFs4,	nRst,	nFs5,	nRst
	dc.b		nFs4,	nRst,	nCs5,	nRst,	nFs4,	nRst,	nFs5,	nRst
	dc.b		nFs4,	nRst,	nCs5,	nRst,	nFs4,	nRst,	nFs5,	nRst
	dc.b		nFs4,	nRst,	nCs5,	nRst,	nFs4,	nRst,	nFs5,	nRst
	dc.b		nFs4,	nRst,	nB4,	nRst,	nAb4,	nRst,	nE5,	nRst
	dc.b		nAb4,	nRst,	nB4,	nRst,	nAb4,	nRst,	nE5,	nRst
	dc.b		nAb4,	nRst,	nB4,	nRst,	nAb4,	nRst,	nE5,	nRst
	dc.b		nAb4,	nRst,	nB4,	nRst,	nAb4,	nRst,	nE5,	nRst
	dc.b		nAb4,	nRst,	nD5,	nRst,	nA4,	nRst,	nFs5,	nRst
	dc.b		nA4,	nRst,	nD5,	nRst,	nA4,	nRst,	nFs5,	nRst
	dc.b		nA4,	nRst,	nD5,	nRst,	nA4,	nRst,	nFs5,	nRst
	dc.b		nA4,	nRst,	nD5,	nRst,	nA4,	nRst,	nFs5,	nRst
	dc.b		nA4,	nRst,	nD5,	nRst,	nB4,	nRst,	nFs5,	nRst
	dc.b		nB4,	nRst,	nD5,	nRst,	nB4,	nRst,	nFs5,	nRst
	dc.b		nB4,	nRst,	nD5,	nRst,	nB4,	nRst,	nFs5,	nRst
	dc.b		nB4,	nRst,	nD5,	nRst,	nB4,	nRst,	nFs5,	nRst
	dc.b		nB4,	$02,	nCs5,	$01,	nRst,	nFs4,	nRst,	nFs5
	dc.b		nRst,	nFs4,	nRst,	nCs5,	nRst,	nFs4,	nRst,	nFs5
	dc.b		nRst,	nFs4,	nRst,	nCs5,	nRst,	nFs4,	nRst,	nFs5
	dc.b		nRst,	nFs4,	nRst,	nCs5,	nRst,	nFs4,	nRst,	nFs5
	dc.b		nRst,	nFs4,	nRst,	nB4,	nRst,	nAb4,	nRst,	nE5
	dc.b		nRst,	nAb4,	nRst,	nB4,	nRst,	nAb4,	nRst,	nE5
	dc.b		nRst,	nAb4,	nRst,	nB4,	nRst,	nAb4,	nRst,	nE5
	dc.b		nRst,	nAb4,	nRst,	nB4,	nRst,	nAb4,	nRst,	nE5
	dc.b		nRst,	nAb4,	nRst,	nD5,	nRst,	nA4,	nRst,	nFs5
	dc.b		nRst,	nA4,	nRst,	nD5,	nRst,	nA4,	nRst,	nFs5
	dc.b		nRst,	nA4,	nRst,	nD5,	nRst,	nA4,	nRst,	nFs5
	dc.b		nRst,	nA4,	nRst,	nD5,	nRst,	nA4,	nRst,	nFs5
	dc.b		nRst,	nA4,	nRst,	nD5,	nRst,	nB4,	nRst,	nFs5
	dc.b		nRst,	nB4,	nRst,	nD5,	nRst,	nB4,	nRst,	nFs5
	dc.b		nRst,	nB4,	nRst,	nD5,	nRst,	nB4,	nRst,	nFs5
	dc.b		nRst,	nB4,	nRst,	nD5,	nRst,	nB4,	nRst,	nFs5
	dc.b		nRst,	nB4,	nRst,	nCs5,	nRst,	nFs4,	nRst,	nFs5
	dc.b		nRst,	nFs4,	nRst,	nCs5,	nRst,	nFs4,	nRst,	nFs5
	dc.b		nRst,	nFs4,	nRst,	nCs5,	nRst,	nFs4,	nRst,	nFs5
	dc.b		nRst,	nFs4,	nRst,	nCs5,	nRst,	nFs4,	nRst,	nFs5
	dc.b		nRst,	nFs4,	nRst,	nB4,	nRst,	nAb4,	nRst,	nE5
	dc.b		nRst,	nAb4,	nRst,	nB4,	nRst,	nAb4,	nRst,	nE5
	dc.b		nRst,	nAb4,	nRst,	nB4,	nRst,	nAb4,	nRst,	nE5
	dc.b		nRst,	nAb4,	nRst,	nB4,	nRst,	nAb4,	nRst,	nE5
	dc.b		nRst,	nAb4,	nRst,	nD5,	nRst,	nA4,	nRst,	nFs5
	dc.b		nRst,	nA4,	nRst,	nD5,	nRst,	nA4,	nRst,	nFs5
	dc.b		nRst,	nA4,	nRst,	nD5,	nRst,	nA4,	nRst,	nFs5
	dc.b		nRst,	nA4,	nRst,	nD5,	nRst,	nA4,	nRst,	nFs5
	dc.b		nRst,	nA4,	nRst,	$21,	nCs5,	$01,	nRst,	nFs4
	dc.b		nRst,	nFs5,	nRst,	nFs4,	nRst,	nCs5,	nRst,	nFs4
	dc.b		nRst,	nFs5,	nRst,	nFs4,	nRst,	nCs5,	nRst,	nFs4
	dc.b		nRst,	nFs5,	nRst,	nFs4,	nRst,	nCs5,	nRst,	nFs4
	dc.b		nRst,	nFs5,	nRst,	nFs4,	nRst,	nB4,	nRst,	nAb4
	dc.b		nRst,	nE5,	nRst,	nAb4,	nRst,	nB4,	nRst,	nAb4
	dc.b		nRst,	nE5,	nRst,	nAb4,	nRst,	nB4,	nRst,	nAb4
	dc.b		nRst,	nE5,	nRst,	nAb4,	nRst,	nB4,	nRst,	nAb4
	dc.b		nRst,	nE5,	nRst,	nAb4,	nRst,	nD5,	nRst,	nA4
	dc.b		nRst,	nFs5,	nRst,	nA4,	nRst,	nD5,	nRst,	nA4
	dc.b		nRst,	nFs5,	nRst,	nA4,	nRst,	nD5,	nRst,	nA4
	dc.b		nRst,	nFs5,	nRst,	nA4,	nRst,	nD5,	nRst,	nA4
	dc.b		nRst,	nFs5,	nRst,	nA4,	nRst,	nD5,	nRst,	nB4
	dc.b		nRst,	nFs5,	nRst,	nB4,	nRst,	nD5,	nRst,	nB4
	dc.b		nRst,	nFs5,	nRst,	nB4,	nRst,	nD5,	nRst,	nB4
	dc.b		nRst,	nFs5,	nRst,	nB4,	nRst,	nD5,	nRst,	nB4
	dc.b		nRst,	nFs5,	nRst,	nB4,	nRst,	nCs5,	nRst,	nFs4
	dc.b		nRst,	nFs5,	nRst,	nFs4,	nRst,	nCs5,	nRst,	nFs4
	dc.b		nRst,	nFs5,	nRst,	nFs4,	nRst,	nCs5,	nRst,	nFs4
	dc.b		nRst,	nFs5,	nRst,	nFs4,	nRst,	nCs5,	nRst,	nFs4
	dc.b		nRst,	nFs5,	nRst,	nFs4,	nRst,	nB4,	nRst,	nAb4
	dc.b		nRst,	nE5,	nRst,	nAb4,	nRst,	nB4,	nRst,	nAb4
	dc.b		nRst,	nE5,	nRst,	nAb4,	nRst,	nB4,	nRst,	nAb4
	dc.b		nRst,	nE5,	nRst,	nAb4,	nRst,	nB4,	nRst,	nAb4
	dc.b		nRst,	nE5,	nRst,	nAb4,	nRst,	nD5,	nRst,	nA4
	dc.b		nRst,	nFs5,	nRst,	nA4,	nRst,	nD5,	nRst,	nA4
	dc.b		nRst,	nFs5,	nRst,	nA4,	nRst,	nD5,	nRst,	nA4
	dc.b		nRst,	nFs5,	nRst,	nA4,	nRst,	nD5,	nRst,	nA4
	dc.b		nRst,	nFs5,	nRst,	nA4,	nRst,	nD5,	nRst,	nB4
	dc.b		nRst,	nFs5,	nRst,	nB4,	nRst,	nD5,	nRst,	nB4
	dc.b		nRst,	nFs5,	nRst,	nB4,	nRst,	nD5,	nRst,	nB4
	dc.b		nRst,	nFs5,	nRst,	nB4,	nRst,	nD5,	nRst,	nB4
	dc.b		nRst,	nFs5,	nRst,	nB4,	nRst
;	Jump To	 	location
	smpsJump	DDR_Dam_Dariram_PSG1

; PSG2 Data
DDR_Dam_Dariram_PSG2:
;	Set PSG WvForm	#
	smpsPSGform	$E7
DDR_Dam_Dariram_Jump01:
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$02,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6,	$01,	$01,	$04,	$04,	nRst
	dc.b		$04,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$02
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$02,	$02,	nRst,	$02
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$22,	$02,	nRst,	$02
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nAb6,	$10
;	Jump To	 	location
	smpsJump	DDR_Dam_Dariram_Jump01

; DAC Data
DDR_Dam_Dariram_DAC:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dVLowTimpani,	$08,	dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick
	dc.b		dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick
	dc.b		$06,	$02,	dSnare,	$04,	dKick,	dKick,	$08,	dSnare
	dc.b		dKick,	dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick,	dSnare
	dc.b		dKick,	dSnare,	dKick,	dSnare,	$06,	dKick,	$02,	$06
	dc.b		$02,	dSnare,	$04,	dKick,	dKick,	$08,	dSnare,	dKick
	dc.b		dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick
	dc.b		dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick
	dc.b		dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick
	dc.b		dSnare,	dKick,	dSnare,	dKick,	$10,	$08,	dSnare,	$08
	dc.b		dKick,	dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick,	dSnare
	dc.b		dKick,	dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick,	dSnare
	dc.b		dKick,	dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick,	dSnare
	dc.b		dKick,	dSnare,	dVLowTimpani,	$0C,	$84,	$04,	$04,	$0C
	dc.b		dKick,	$08,	dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick
	dc.b		dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick
	dc.b		dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick
	dc.b		dSnare,	dKick,	dSnare,	dKick,	dSnare,	dVLowTimpani,	$0E,	$02
	dc.b		$04,	$0C
;	Jump To	 	location
	smpsJump	DDR_Dam_Dariram_DAC

DDR_Dam_Dariram_Voices:
;	Voice 00
;	$28,$33,$71,$37,$71,$1F,$1F,$52,$1F,$05,$06,$05,$0C,$00,$04,$04,$04,$00,$00,$17,$18,$14,$16,$14,$00
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$07,	$03
	smpsVcCoarseFreq	$01,	$07,	$01,	$03
	smpsVcRateScale		$00,	$01,	$00,	$00
	smpsVcAttackRate	$1F,	$12,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0C,	$05,	$06,	$05
	smpsVcDecayRate2	$04,	$04,	$04,	$00
	smpsVcDecayLevel	$01,	$01,	$00,	$00
	smpsVcReleaseRate	$08,	$07,	$00,	$00
	smpsVcTotalLevel	$00,	$14,	$16,	$14

;	Voice 01
;	$3B,$0D,$00,$01,$00,$9F,$1F,$1F,$1F,$0E,$09,$0D,$09,$00,$00,$00,$00,$D6,$D6,$D6,$D7,$33,$17,$15,$00
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$00,	$01,	$00,	$0D
	smpsVcRateScale		$00,	$00,	$00,	$02
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$09,	$0D,	$09,	$0E
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$0D,	$0D,	$0D,	$0D
	smpsVcReleaseRate	$07,	$06,	$06,	$06
	smpsVcTotalLevel	$00,	$15,	$17,	$33

;	Voice 02
;	$39,$03,$61,$22,$21,$1F,$1F,$12,$1F,$05,$05,$05,$0B,$00,$00,$00,$00,$10,$10,$18,$18,$1E,$1D,$15,$00
;				#
	smpsVcAlgorithm		$01
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$02,	$02,	$06,	$00
	smpsVcCoarseFreq	$01,	$02,	$01,	$03
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$12,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0B,	$05,	$05,	$05
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$08,	$08,	$00,	$00
	smpsVcTotalLevel	$00,	$15,	$1D,	$1E

;	Voice 03
;	$38,$73,$01,$02,$31,$DF,$DF,$DF,$DF,$07,$05,$05,$0A,$03,$03,$03,$03,$23,$25,$13,$27,$1E,$1E,$1E,$00
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$00,	$00,	$07
	smpsVcCoarseFreq	$01,	$02,	$01,	$03
	smpsVcRateScale		$03,	$03,	$03,	$03
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$05,	$05,	$07
	smpsVcDecayRate2	$03,	$03,	$03,	$03
	smpsVcDecayLevel	$02,	$01,	$02,	$02
	smpsVcReleaseRate	$07,	$03,	$05,	$03
	smpsVcTotalLevel	$00,	$1E,	$1E,	$1E

;	Voice 04
;	$01,$04,$01,$00,$01,$55,$56,$50,$52,$0B,$04,$00,$01,$06,$05,$05,$11,$20,$50,$50,$1E,$0B,$00,$14,$00
;				#
	smpsVcAlgorithm		$01
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$00,	$01,	$04
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$12,	$10,	$16,	$15
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$01,	$00,	$04,	$0B
	smpsVcDecayRate2	$11,	$05,	$05,	$06
	smpsVcDecayLevel	$01,	$05,	$05,	$02
	smpsVcReleaseRate	$0E,	$00,	$00,	$00
	smpsVcTotalLevel	$00,	$14,	$00,	$0B
	even
