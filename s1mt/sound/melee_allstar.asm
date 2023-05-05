; =============================================================================================
; Project Name:		Melee_Allstar
; Created:		17th January 2014
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

Melee_Allstar_Header:
;	Voice Pointer	location
	smpsHeaderVoice	Melee_Allstar_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$07,	$02
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$02,	$04

;	DAC Pointer	location
	smpsHeaderDAC	Melee_Allstar_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	Melee_Allstar_FM1,	smpsPitch00,	$10
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	Melee_Allstar_FM2,	smpsPitch00,	$10
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	Melee_Allstar_FM3,	smpsPitch00,	$10
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	Melee_Allstar_FM4,	smpsPitch00,	$10
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	Melee_Allstar_FM5,	smpsPitch00,	$10
;	FM6 Pointer	location	pitch		volume
	smpsHeaderFM	Melee_Allstar_FM6,	smpsPitch00,	$10
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Melee_Allstar_PSG1,	smpsPitch03lo,	$04,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Melee_Allstar_PSG2,	smpsPitch03lo,	$01,	$00

; FM1 Data
Melee_Allstar_FM1:
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
Melee_Allstar_Jump01:
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nC2,	$40,	nB1,	nC2,	nB1,	$30,	nF2,	$10
	dc.b		nEb2,	$40,	nD2,	nEb2,	nD2,	$10,	nC2,	nD2
	dc.b		$20
;	Jump To	 	location
	smpsJump	Melee_Allstar_Jump01

; FM2 Data
Melee_Allstar_FM2:
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
Melee_Allstar_Jump02:
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nE2,	$40,	nD2,	nE2,	nD2,	$30,	$10,	nG2
	dc.b		$40,	nF2,	nG2,	nF2,	$10,	nEb2,	nF2,	$20
;	Jump To	 	location
	smpsJump	Melee_Allstar_Jump02

; FM3 Data
Melee_Allstar_FM3:
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
Melee_Allstar_Jump03:
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nC4,	$10,	$10,	$10,	nE4,	$10,	nB3,	nD4
	dc.b		nD4,	nB3,	nC4,	nE4,	nE4,	nC4,	nB3,	nD4
	dc.b		nB3,	nD4,	nAb2,	nAb2,	nG4,	nG4,	nG2,	nF4
	dc.b		nF4,	nF4,	nAb2,	nEb4,	nG4,	nEb4,	nRst,	$40
;	Jump To	 	location
	smpsJump	Melee_Allstar_Jump03

; FM4 Data
Melee_Allstar_FM4:
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
Melee_Allstar_Jump04:
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nE4,	$10,	$10,	$10,	nC4,	$10,	nD4,	nB3
	dc.b		nB3,	nD4,	nE4,	nC4,	nC4,	nE4,	nD4,	nB3
	dc.b		nD4,	nE2,	nEb4,	nEb4,	nAb2,	nAb2,	nD4,	nD4
	dc.b		nG2,	nG2,	nEb4,	nG4,	nEb4,	nAb2,	nRst,	$40
;	Jump To	 	location
	smpsJump	Melee_Allstar_Jump04

; FM5 Data
Melee_Allstar_FM5:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nE5,	$30,	nD5,	$08,	nC5,	$04,	nD5,	$32
	dc.b		nRst,	$02,	nC5,	$08,	nD5,	$04,	nE5,	$32
	dc.b		nRst,	$02,	nD5,	$08,	nC5,	$04,	nD5,	$32
	dc.b		nRst,	$02,	nEb5,	$08,	nF5,	$04,	nG5,	$32
	dc.b		nRst,	$02,	nF5,	$08,	nEb5,	$04,	nF5,	$32
	dc.b		nRst,	$02,	nEb5,	$08,	nF5,	$04,	nG5,	$32
	dc.b		nRst,	$02,	nC6,	$10,	nG5,	$20,	nF5
;	Jump To	 	location
	smpsJump	Melee_Allstar_FM5

; FM6 Data
Melee_Allstar_FM6:
	dc.b		nRst,	$7F,	$71
Melee_Allstar_Jump05:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nF4,	$10,	nG4,	nG4,	nEb4,	nEb4,	nF4,	nG2
	dc.b		nD4,	nD4,	nG4,	nAb2,	nAb2,	nG4,	nRst,	$7F
	dc.b		$7F,	$32
;	Jump To	 	location
	smpsJump	Melee_Allstar_Jump05

; PSG1 Data
Melee_Allstar_PSG1:
	dc.b		nRst,	$03
Melee_Allstar_Jump06:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nF3,	$04,	nC4,	nG4,	nA4,	nF3,	nC4,	nG4
	dc.b		nA4,	nF3,	nC4,	nG4,	nA4,	nF3,	nC4,	nG4
	dc.b		nA4,	nE3,	nB3,	nFs4,	nG4,	nE3,	nB3,	nFs4
	dc.b		nG4,	nE3,	nB3,	nFs4,	nG4,	nE3,	nB3,	nFs4
	dc.b		nG4,	nF3,	nC4,	nG4,	nA4,	nF3,	nC4,	nG4
	dc.b		nA4,	nF3,	nC4,	nG4,	nA4,	nF3,	nC4,	nG4
	dc.b		nA4,	nE3,	nB3,	nFs4,	nG4,	nE3,	nB3,	nFs4
	dc.b		nG4,	nE3,	nB3,	nFs4,	nG4,	nE3,	nB3,	nFs4
	dc.b		nG4,	nAb3,	nEb4,	nBb4,	nC5,	nAb3,	nEb4,	nBb4
	dc.b		nC5,	nAb3,	nEb4,	nBb4,	nC5,	nAb3,	nEb4,	nBb4
	dc.b		nC5,	nG3,	nD4,	nA4,	nBb4,	nG3,	nD4,	nA4
	dc.b		nBb4,	nG3,	nD4,	nA4,	nBb4,	nG3,	nD4,	nA4
	dc.b		nBb4,	nAb3,	nEb4,	nBb4,	nC5,	nAb3,	nEb4,	nBb4
	dc.b		nC5,	nAb3,	nEb4,	nBb4,	nC5,	nAb3,	nEb4,	nBb4
	dc.b		nC5,	nRst,	$40
;	Jump To	 	location
	smpsJump	Melee_Allstar_Jump06

; PSG2 Data
Melee_Allstar_PSG2:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nF3,	$04,	nC4,	nG4,	nA4,	nF3,	nC4,	nG4
	dc.b		nA4,	nF3,	nC4,	nG4,	nA4,	nF3,	nC4,	nG4
	dc.b		nA4,	nE3,	nB3,	nFs4,	nG4,	nE3,	nB3,	nFs4
	dc.b		nG4,	nE3,	nB3,	nFs4,	nG4,	nE3,	nB3,	nFs4
	dc.b		nG4,	nF3,	nC4,	nG4,	nA4,	nF3,	nC4,	nG4
	dc.b		nA4,	nF3,	nC4,	nG4,	nA4,	nF3,	nC4,	nG4
	dc.b		nA4,	nE3,	nB3,	nFs4,	nG4,	nE3,	nB3,	nFs4
	dc.b		nG4,	nE3,	nB3,	nFs4,	nG4,	nE3,	nB3,	nFs4
	dc.b		nG4,	nAb3,	nEb4,	nBb4,	nC5,	nAb3,	nEb4,	nBb4
	dc.b		nC5,	nAb3,	nEb4,	nBb4,	nC5,	nAb3,	nEb4,	nBb4
	dc.b		nC5,	nG3,	nD4,	nA4,	nBb4,	nG3,	nD4,	nA4
	dc.b		nBb4,	nG3,	nD4,	nA4,	nBb4,	nG3,	nD4,	nA4
	dc.b		nBb4,	nAb3,	nEb4,	nBb4,	nC5,	nAb3,	nEb4,	nBb4
	dc.b		nC5,	nAb3,	nEb4,	nBb4,	nC5,	nAb3,	nEb4,	nBb4
	dc.b		nC5,	nRst,	$40
;	Jump To	 	location
	smpsJump	Melee_Allstar_PSG2

; DAC Data
Melee_Allstar_DAC:
	smpsStop

Melee_Allstar_Voices:
;	Voice 00
;	$3C,$31,$31,$3A,$31,$1F,$19,$1F,$1F,$00,$0C,$00,$0C,$00,$0A,$00,$0A,$00,$0F,$00,$4F,$23,$00,$26,$00
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$03,	$03
	smpsVcCoarseFreq	$01,	$0A,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$19,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0C,	$00,	$0C,	$00
	smpsVcDecayRate2	$0A,	$00,	$0A,	$00
	smpsVcDecayLevel	$04,	$00,	$00,	$00
	smpsVcReleaseRate	$0F,	$00,	$0F,	$00
	smpsVcTotalLevel	$00,	$26,	$00,	$23

;	Voice 01
;	$2C,$74,$74,$34,$34,$1F,$12,$1F,$1F,$00,$00,$00,$00,$00,$01,$00,$01,$0F,$3F,$0F,$3F,$16,$00,$17,$00
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$07,	$07
	smpsVcCoarseFreq	$04,	$04,	$04,	$04
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$12,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$00,	$00,	$00
	smpsVcDecayRate2	$01,	$00,	$01,	$00
	smpsVcDecayLevel	$03,	$00,	$03,	$00
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$00,	$17,	$00,	$16

;	Voice 02
;	$32,$71,$0D,$33,$01,$5F,$99,$5F,$94,$05,$05,$05,$07,$02,$02,$02,$02,$11,$11,$11,$72,$23,$2D,$26,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$03,	$00,	$07
	smpsVcCoarseFreq	$01,	$03,	$0D,	$01
	smpsVcRateScale		$02,	$01,	$02,	$01
	smpsVcAttackRate	$14,	$1F,	$19,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$07,	$05,	$05,	$05
	smpsVcDecayRate2	$02,	$02,	$02,	$02
	smpsVcDecayLevel	$07,	$01,	$01,	$01
	smpsVcReleaseRate	$02,	$01,	$01,	$01
	smpsVcTotalLevel	$80,	$26,	$2D,	$23
	even
