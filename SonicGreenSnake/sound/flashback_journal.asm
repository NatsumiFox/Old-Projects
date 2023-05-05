; =============================================================================================
; Project Name:		FlashBack_Journal
; Created:		17th January 2014
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

FlashBack_Journal_Header:
;	Voice Pointer	location
	smpsHeaderVoice	FlashBack_Journal_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$02,	$06

;	DAC Pointer	location
	smpsHeaderDAC	FlashBack_Journal_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	FlashBack_Journal_FM1,	smpsPitch00,	$0B
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	FlashBack_Journal_FM2,	smpsPitch00,	$0D
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	FlashBack_Journal_FM3,	smpsPitch00,	$0D
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	FlashBack_Journal_FM4,	smpsPitch00,	$15
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	FlashBack_Journal_FM5,	smpsPitch00,	$1B
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	FlashBack_Journal_PSG1,	smpsPitch03lo,	$07,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	FlashBack_Journal_PSG2,	smpsPitch03lo,	$07,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	FlashBack_Journal_PSG3,	smpsPitch00+$0B,	$03,	$00

; FM1 Data
FlashBack_Journal_FM1:
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$2C
FlashBack_Journal_Jump01:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nB4,	$0C,	nA4,	nB4,	nE4,	$10,	nRst,	$20
	dc.b		nE4,	$04,	nFs4,	nG4,	nA4,	$10,	nRst,	nB4
	dc.b		$0C,	nA4,	nE4,	$10,	nRst,	$58,	nB4,	$0C
	dc.b		nA4,	nB4,	nE4,	$10,	nRst,	$20,	nE4,	$04
	dc.b		nFs4,	nG4,	nA4,	$10,	nRst,	nB4,	$0C,	nA4
	dc.b		nE4,	nFs4,	nD4,	nRst,	$04,	nB3,	$08,	nD4
	dc.b		nE4,	nRst,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$30
;	Jump To	 	location
	smpsJump	FlashBack_Journal_Jump01

; FM2 Data
FlashBack_Journal_FM2:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nE2,	$04,	nB1,	nD2,	nE1,	nRst,	nD1,	nE1
	dc.b		$0C,	nB1,	$02,	nRst,	nB1,	nRst,	nB1,	nRst
	dc.b		nD2,	$08,	nB1,	$04,	nA1,	nE1,	$0C,	$04
	dc.b		nRst,	$04,	nD1,	nE1,	$0C,	nB1,	$02,	nRst
	dc.b		nB1,	nRst,	nB1,	nRst,	nD2,	$08,	nB1,	$04
	dc.b		nA1,	nE2,	nB1,	nD2,	nB1,	nRst,	nA1,	nB1
	dc.b		$0C,	$02,	nRst,	$02,	nB1,	nRst,	nB1,	nRst
	dc.b		nD2,	$08,	nB1,	$04,	nA1,	nA1,	$0C,	$04
	dc.b		nRst,	$04,	nG1,	nA1,	$0C,	$02,	nRst,	$02
	dc.b		nA1,	nRst,	nA1,	nRst,	nB1,	$08,	nD2,	$04
	dc.b		nE2,	nE2,	nB1,	nD2,	nE1,	nRst,	nD1,	nE1
	dc.b		$0C,	nB1,	$02,	nRst,	nB1,	nRst,	nB1,	nRst
	dc.b		nD2,	$08,	nB1,	$04,	nA1,	nE1,	$0C,	$04
	dc.b		nRst,	$04,	nD1,	nE1,	$0C,	nB1,	$02,	nRst
	dc.b		nB1,	nRst,	nB1,	nRst,	nD2,	$08,	nB1,	$04
	dc.b		nA1,	nE2,	nB1,	nD2,	nB1,	nRst,	nA1,	nB1
	dc.b		$0C,	$02,	nRst,	$02,	nB1,	nRst,	nB1,	nRst
	dc.b		nD2,	$08,	nB1,	$04,	nA1,	nA1,	$0C,	$04
	dc.b		nRst,	$04,	nG1,	nA1,	$0C,	$02,	nRst,	$02
	dc.b		nA1,	nRst,	nA1,	nRst,	nB1,	$08,	nD2,	$04
	dc.b		nE2
FlashBack_Journal_Jump02:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nE2,	$04,	nB1,	nD2,	nE1,	nRst,	nD1,	nE1
	dc.b		$0C,	nB1,	$02,	nRst,	nB1,	nRst,	nB1,	nRst
	dc.b		nD2,	$08,	nB1,	$04,	nA1,	nE1,	$0C,	$04
	dc.b		nRst,	$04,	nD1,	nE1,	$0C,	nB1,	$02,	nRst
	dc.b		nB1,	nRst,	nB1,	nRst,	nD2,	$08,	nB1,	$04
	dc.b		nA1,	nE2,	nB1,	nD2,	nB1,	nRst,	nA1,	nB1
	dc.b		$0C,	$02,	nRst,	$02,	nB1,	nRst,	nB1,	nRst
	dc.b		nD2,	$08,	nB1,	$04,	nA1,	nA1,	$0C,	$04
	dc.b		nRst,	$04,	nG1,	nA1,	$0C,	$02,	nRst,	$02
	dc.b		nA1,	nRst,	nA1,	nRst,	nB1,	$08,	nD2,	$04
	dc.b		nE2
;	Jump To	 	location
	smpsJump	FlashBack_Journal_Jump02

; FM3 Data
FlashBack_Journal_FM3:
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$10
FlashBack_Journal_Jump03:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nE3,	$04,	nRst,	nE3,	nRst,	$08,	nE3,	$04
	dc.b		nRst,	nE3,	nRst,	nE3,	nG3,	nRst,	nE3,	nRst
	dc.b		$0C,	nE3,	$04,	nRst,	nE3,	nRst,	$08,	nE3
	dc.b		$04,	nRst,	nE3,	nRst,	nE3,	nC4,	nRst,	nB3
	dc.b		nRst,	$0C,	nE3,	$04,	nRst,	nE3,	nRst,	$08
	dc.b		nE3,	$04,	nRst,	nE3,	nRst,	nE3,	nG3,	nRst
	dc.b		nE3,	nRst,	$0C,	nE3,	$04,	nRst,	nE3,	nRst
	dc.b		$08,	nE3,	$04,	nRst,	nE3,	nRst,	nE3,	nD3
	dc.b		nRst,	nE3,	nRst,	$0C,	nE3,	$04,	nRst,	nE3
	dc.b		nRst,	$08,	nE3,	$04,	nRst,	nE3,	nRst,	nE3
	dc.b		nG3,	nRst,	nE3,	nRst,	$0C,	nE3,	$04,	nRst
	dc.b		nE3,	nRst,	$08,	nE3,	$04,	nRst,	nE3,	nRst
	dc.b		nE3,	nC4,	nRst,	nB3,	nRst,	$0C,	nE3,	$04
	dc.b		nRst,	nE3,	nRst,	$08,	nE3,	$04,	nRst,	nE3
	dc.b		nRst,	nE3,	nG3,	nRst,	nE3,	nRst,	$0C,	nE3
	dc.b		$04,	nRst,	nE3,	nRst,	$08,	nE3,	$04,	nRst
	dc.b		nE3,	nRst,	nE3,	nD3,	nRst,	nE3,	nRst,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$14
;	Jump To	 	location
	smpsJump	FlashBack_Journal_Jump03

; FM4 Data
FlashBack_Journal_FM4:
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$34
FlashBack_Journal_Jump04:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nB4,	$0C,	nA4,	nB4,	nE4,	$10,	nRst,	$20
	dc.b		nE4,	$04,	nFs4,	nG4,	nA4,	$10,	nRst,	nB4
	dc.b		$0C,	nA4,	nE4,	$10,	nRst,	$58,	nB4,	$0C
	dc.b		nA4,	nB4,	nE4,	$10,	nRst,	$20,	nE4,	$04
	dc.b		nFs4,	nG4,	nA4,	$10,	nRst,	nB4,	$0C,	nA4
	dc.b		nE4,	nFs4,	nD4,	nRst,	$04,	nB3,	$08,	nD4
	dc.b		nE4,	nRst,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$30
;	Jump To	 	location
	smpsJump	FlashBack_Journal_Jump04

; FM5 Data
FlashBack_Journal_FM5:
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$18
FlashBack_Journal_Jump05:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nE3,	$04,	nRst,	nE3,	nRst,	$08,	nE3,	$04
	dc.b		nRst,	nE3,	nRst,	nE3,	nG3,	nRst,	nE3,	nRst
	dc.b		$0C,	nE3,	$04,	nRst,	nE3,	nRst,	$08,	nE3
	dc.b		$04,	nRst,	nE3,	nRst,	nE3,	nC4,	nRst,	nB3
	dc.b		nRst,	$0C,	nE3,	$04,	nRst,	nE3,	nRst,	$08
	dc.b		nE3,	$04,	nRst,	nE3,	nRst,	nE3,	nG3,	nRst
	dc.b		nE3,	nRst,	$0C,	nE3,	$04,	nRst,	nE3,	nRst
	dc.b		$08,	nE3,	$04,	nRst,	nE3,	nRst,	nE3,	nD3
	dc.b		nRst,	nE3,	nRst,	$0C,	nE3,	$04,	nRst,	nE3
	dc.b		nRst,	$08,	nE3,	$04,	nRst,	nE3,	nRst,	nE3
	dc.b		nG3,	nRst,	nE3,	nRst,	$0C,	nE3,	$04,	nRst
	dc.b		nE3,	nRst,	$08,	nE3,	$04,	nRst,	nE3,	nRst
	dc.b		nE3,	nC4,	nRst,	nB3,	nRst,	$0C,	nE3,	$04
	dc.b		nRst,	nE3,	nRst,	$08,	nE3,	$04,	nRst,	nE3
	dc.b		nRst,	nE3,	nG3,	nRst,	nE3,	nRst,	$0C,	nE3
	dc.b		$04,	nRst,	nE3,	nRst,	$08,	nE3,	$04,	nRst
	dc.b		nE3,	nRst,	nE3,	nD3,	nRst,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$1C
;	Jump To	 	location
	smpsJump	FlashBack_Journal_Jump05

; PSG1 Data
FlashBack_Journal_PSG1:
;	Set PSG Voice	#
	smpsPSGvoice	$06
	dc.b		nB3,	$7F,	smpsNoAttack,	$01,	nD4,	$40,	nA3,	nB3
	dc.b		$7F,	smpsNoAttack,	$01,	nD4,	$40,	nA3
FlashBack_Journal_Jump06:
;	Set PSG Voice	#
	smpsPSGvoice	$06
	dc.b		nB3,	$7F,	smpsNoAttack,	$01,	nD4,	$40,	nA3
;	Jump To	 	location
	smpsJump	FlashBack_Journal_Jump06

; PSG2 Data
FlashBack_Journal_PSG2:
;	Set PSG Voice	#
	smpsPSGvoice	$06
	dc.b		nE4,	$7F,	smpsNoAttack,	$01,	nG4,	$40,	nCs4,	nE4
	dc.b		$7F,	smpsNoAttack,	$01,	nG4,	$40,	nCs4
FlashBack_Journal_Jump07:
;	Set PSG Voice	#
	smpsPSGvoice	$06
	dc.b		nE4,	$7F,	smpsNoAttack,	$01,	nG4,	$40,	nCs4
;	Jump To	 	location
	smpsJump	FlashBack_Journal_Jump07

; PSG3 Data
FlashBack_Journal_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
	dc.b		nRst,	$7F,	$7F,	$02
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$10,	$10,	$10,	$10,	$10,	$04,	nRst
	dc.b		$0C,	nAb6,	$04,	nRst,	$0C,	nAb6,	$04,	nRst
	dc.b		$0C,	nAb6,	$04,	nRst,	$0C,	nAb6,	$04,	nRst
	dc.b		$0C,	nAb6,	$04,	nRst,	$0C,	nAb6,	$04,	nRst
	dc.b		$0C,	nAb6,	$04,	nRst,	$0C,	nAb6,	$04,	nRst
	dc.b		$0C,	nAb6,	$04,	nRst,	$0C,	nAb6,	$04,	nRst
	dc.b		$14
;	Set PSG WvForm	#
	smpsPSGform	$E7
FlashBack_Journal_Jump08:
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$04,	$04,	nRst,	$08,	nAb6,	$04,	nRst
	dc.b		$0C,	nAb6,	$04,	$04,	nRst,	$04,	nAb6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$0C
;	Jump To	 	location
	smpsJump	FlashBack_Journal_Jump08

; DAC Data
FlashBack_Journal_DAC:
		dc.b		nRst,	$7F,	$7F,	$02
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dKick,	$10,	nRst,	$24,	dKick,	$04,	nRst,	dKick
	dc.b		dKick,	$10,	nRst,	$30,	dKick,	$04,	nRst,	$30
	dc.b		dKick,	$04,	nRst,	dKick,	dKick,	nRst,	$2C,	dKick2
	dc.b		$04,	$04,	dKick2,	$04,	dKick2
FlashBack_Journal_Jump09:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dVLowTimpani,	$08,	nRst,	$04,	dKick,	dSnare,	nRst,	dKick
	dc.b		nRst,	$0C,	dKick,	$04,	nRst,	dSnare,	nRst,	$0C
	dc.b		dKick,	$04,	nRst,	$08,	dKick,	$04,	dSnare,	nRst
	dc.b		dKick,	nRst,	$0C,	dKick,	$04,	nRst,	dSnare,	nRst
	dc.b		$0C,	dKick,	$04,	nRst,	$08,	dKick,	$04,	dSnare
	dc.b		nRst,	dKick,	nRst,	$0C,	dKick,	$04,	nRst,	dSnare
	dc.b		nRst,	$0C,	dKick,	$04,	nRst,	$08,	dKick,	$04
	dc.b		dSnare,	nRst,	dKick,	nRst,	$0C,	dKick,	$04,	nRst
	dc.b		dSnare,	dSnare,	nRst,	$08,	dVLowTimpani,	nRst,	$04,	dKick
	dc.b		dSnare,	nRst,	dKick,	nRst,	$0C,	dKick,	$04,	nRst
	dc.b		dSnare,	nRst,	$0C,	dKick,	$04,	nRst,	$08,	dKick
	dc.b		$04,	dSnare,	nRst,	dKick,	nRst,	$0C,	dKick,	$04
	dc.b		nRst,	dSnare,	nRst,	$0C,	dKick,	$04,	nRst,	$08
	dc.b		dKick,	$04,	dSnare,	nRst,	dKick,	nRst,	$0C,	dKick
	dc.b		$04,	nRst,	dSnare,	nRst,	$0C,	dKick,	$04,	nRst
	dc.b		$08,	dKick,	$04,	dSnare,	nRst,	dKick,	nRst,	$0C
	dc.b		dKick,	$04,	nRst,	dSnare,	dSnare,	dSnare,	dSnare,	dVLowTimpani
	dc.b		$08,	nRst,	$04,	dKick,	dSnare,	nRst,	dKick,	nRst
	dc.b		$0C,	dKick,	$04,	nRst,	dSnare,	nRst,	$0C,	dKick
	dc.b		$04,	nRst,	$08,	dKick,	$04,	dSnare,	nRst,	dKick
	dc.b		nRst,	$0C,	dKick,	$04,	nRst,	dSnare,	nRst,	$0C
	dc.b		dKick,	$04,	nRst,	$08,	dKick,	$04,	dSnare,	nRst
	dc.b		dKick,	nRst,	$0C,	dKick,	$04,	nRst,	dSnare,	nRst
	dc.b		$0C,	dKick,	$04,	nRst,	$08,	dKick,	$04,	dSnare
	dc.b		nRst,	dKick,	nRst,	$0C,	dKick,	$04,	nRst,	dSnare
	dc.b		nRst,	$0C,	dVLowTimpani,	$08,	nRst,	$04,	dKick,	dSnare
	dc.b		nRst,	dKick,	nRst,	$0C,	dKick,	$04,	nRst,	dSnare
	dc.b		nRst,	$0C,	dKick,	$04,	nRst,	$08,	dKick,	$04
	dc.b		dSnare,	nRst,	dKick,	nRst,	$0C,	dKick,	$04,	nRst
	dc.b		dSnare,	nRst,	$0C,	dKick,	$04,	nRst,	$08,	dKick
	dc.b		$04,	dSnare,	nRst,	dKick,	nRst,	$0C,	dKick,	$04
	dc.b		nRst,	dSnare,	nRst,	$0C,	dKick,	$04,	nRst,	$08
	dc.b		dKick,	$04,	dSnare,	nRst,	dKick,	nRst,	$0C,	dKick
	dc.b		$04,	nRst,	dSnare,	nRst,	$0C,	dVLowTimpani,	$08,	nRst
	dc.b		$04,	dKick,	dSnare,	nRst,	dKick,	nRst,	$0C,	dKick
	dc.b		$04,	nRst,	dSnare,	nRst,	$0C,	dKick,	$04,	nRst
	dc.b		$08,	dKick,	$04,	dSnare,	nRst,	dKick,	nRst,	$0C
	dc.b		dKick,	$04,	nRst,	dSnare,	nRst,	$0C,	dKick,	$04
	dc.b		nRst,	$08,	dKick,	$04,	dSnare,	nRst,	dKick,	nRst
	dc.b		$0C,	dKick,	$04,	nRst,	dSnare,	nRst,	$0C,	dKick
	dc.b		$04,	nRst,	$08,	dKick,	$04,	dSnare,	nRst,	dKick
	dc.b		nRst,	$0C,	dKick,	$04,	nRst,	dSnare,	dSnare,	nRst
	dc.b		$08,	dVLowTimpani,	nRst,	$04,	dKick,	dSnare,	nRst,	dKick
	dc.b		nRst,	$0C,	dKick,	$04,	nRst,	dSnare,	nRst,	$0C
	dc.b		dKick,	$04,	nRst,	$08,	dKick,	$04,	dSnare,	nRst
	dc.b		dKick,	nRst,	$0C,	dKick,	$04,	nRst,	dSnare,	nRst
	dc.b		$0C,	dKick,	$04,	nRst,	$08,	dKick,	$04,	dSnare
	dc.b		nRst,	dKick,	nRst,	$0C,	dKick,	$04,	nRst,	dSnare
	dc.b		nRst,	$0C,	dKick,	$04,	nRst,	$08,	dKick,	$04
	dc.b		dSnare,	nRst,	dKick,	nRst,	$0C,	dKick,	$04,	nRst
	dc.b		dSnare,	dSnare,	nRst,	$08
;	Jump To	 	location
	smpsJump	FlashBack_Journal_Jump09

FlashBack_Journal_Voices:
;	Voice 00
;	$24,$3E,$31,$16,$11,$1F,$98,$1F,$9F,$0F,$01,$0E,$01,$0E,$05,$08,$05,$50,$02,$60,$02,$2A,$14,$2F,$00
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$04
;				op1	op2	op3	op4
	smpsVcDetune		$01,	$01,	$03,	$03
	smpsVcCoarseFreq	$01,	$06,	$01,	$0E
	smpsVcRateScale		$02,	$00,	$02,	$00
	smpsVcAttackRate	$1F,	$1F,	$18,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$01,	$0E,	$01,	$0F
	smpsVcDecayRate2	$05,	$08,	$05,	$0E
	smpsVcDecayLevel	$00,	$06,	$00,	$05
	smpsVcReleaseRate	$02,	$00,	$02,	$00
	smpsVcTotalLevel	$00,	$2F,	$14,	$2A

;	Voice 01
;	$3C,$01,$01,$01,$01,$1F,$1F,$1F,$1F,$0F,$0C,$08,$0B,$06,$0B,$0A,$0B,$FF,$FF,$FF,$FF,$1D,$80,$1F,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0B,	$08,	$0C,	$0F
	smpsVcDecayRate2	$0B,	$0A,	$0B,	$06
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$1F,	$80,	$1D

;	Voice 02
;	$2C,$61,$22,$22,$43,$5F,$94,$5F,$94,$05,$05,$05,$07,$02,$02,$02,$02,$1F,$6F,$1F,$AF,$1E,$80,$1E,$92
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$04,	$02,	$02,	$06
	smpsVcCoarseFreq	$03,	$02,	$02,	$01
	smpsVcRateScale		$02,	$01,	$02,	$01
	smpsVcAttackRate	$14,	$1F,	$14,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$07,	$05,	$05,	$05
	smpsVcDecayRate2	$02,	$02,	$02,	$02
	smpsVcDecayLevel	$0A,	$01,	$06,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$92,	$1E,	$80,	$1E
	even
