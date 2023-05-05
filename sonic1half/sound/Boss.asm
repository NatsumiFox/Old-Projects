; =============================================================================================
; Project Name:		Eggman
; Created:		29th July 2012
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

Eggman_Header:
;	Voice Pointer	location
	smpsHeaderVoice	Eggman_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$01
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$02,	$03

;	DAC Pointer	location
	smpsHeaderDAC	Eggman_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	Eggman_FM1,	smpsPitch00,	$10
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	Eggman_FM2,	smpsPitch00,	$10
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	Eggman_FM3,	smpsPitch00,	$10
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	Eggman_FM4,	smpsPitch00,	$10
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	Eggman_FM5,	smpsPitch00,	$0D
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Eggman_PSG1,	smpsPitch00+$0B,	$00,	$00

; FM1 Data
Eggman_FM1:
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nCs3,	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs3,	nAb3,	nCs3,	nB3,	nCs4,	nCs3,	nFs3,	nAb3
	dc.b		nCs3,	nB3,	nCs4,	nRst,	nA1,	$08,	nB1,	$04
	dc.b		nCs3,	nFs3,	nAb3,	nCs3,	nB3,	nCs4,	nCs3,	nFs3
	dc.b		nAb3,	nCs3,	nB3,	nCs4,	nRst,	nA2,	$08,	nB2
	dc.b		$04,	nCs3,	nFs3,	nAb3,	nCs3,	nB3,	nCs4,	nCs3
	dc.b		nFs3,	nAb3,	nCs3,	nD4,	nCs4,	nD3,	$08,	nRst
	dc.b		nCs3,	$04,	nFs3,	nAb3,	nCs3,	nB3,	nCs4,	nCs3
	dc.b		nFs3,	nAb3,	nCs3,	nB3,	nCs4,	nRst,	nA2,	$08
	dc.b		nB2,	$04,	nCs3,	nFs3,	nAb3,	nCs3,	nB3,	nCs4
	dc.b		nD4,	nCs4,	nRst,	$10,	nCs2,	$20,	nE2,	nFs1
	dc.b		nB1,	$10,	nCs2,	nCs2,	$01,	nRst,	$1F,	nE2
	dc.b		$20,	nFs2,	nB2,	$10,	nCs2,	nE2,	$04,	nRst
	dc.b		nE1,	$28,	nRst,	$10,	nE2,	$04,	nRst,	nE1
	dc.b		$28,	nRst,	$10,	nE1,	$04,	nRst,	nE2,	$20
	dc.b		nRst,	$18,	nE2,	$04,	nRst,	nE2,	$20,	nRst
	dc.b		$18,	nF4,	$04,	nC4,	nE4,	nB3,	nEb4,	nBb3
	dc.b		nD4,	nA3
;	Jump To	 	location
	smpsJump	Eggman_FM1

; FM2 Data
Eggman_FM2:
	dc.b		nRst,	$34
Eggman_Jump01:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nA2,	$08,	nRst,	$38,	nA1,	$08,	nB1,	$04
	dc.b		nRst,	$30,	nD2,	$08,	nB1,	nRst,	$34,	nA1
	dc.b		$08,	nB1,	$04,	nRst,	$30,	nCs3,	$20,	nE1
	dc.b		nFs2,	nB2,	$10,	nCs3,	nCs3,	$01,	nRst,	$1F
	dc.b		nE1,	$20,	nFs1,	nB1,	$10,	nCs3,	nE1,	$04
	dc.b		nRst,	nE2,	$20,	nRst,	$18,	nE1,	$04,	nRst
	dc.b		nE2,	$20,	nRst,	$18,	nE2,	$04,	nRst,	nE1
	dc.b		$28,	nRst,	$7F,	$25
;	Jump To	 	location
	smpsJump	Eggman_Jump01

; FM3 Data
Eggman_FM3:
	dc.b		nRst,	$34
Eggman_Jump02:
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set FM Voice	#
	smpsFMvoice	$05
	dc.b		nA2,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nB2,	$04,	nRst,	$34,	nA2,	$08,	nB2,	$04
	dc.b		nRst,	$74,	nA2,	$08,	nB2,	$04,	nRst,	$7F
	dc.b		$25,	nCs3,	$02,	nRst,	$06,	nCs3,	$0C,	nRst
	dc.b		$7F,	$7F,	$7E,	nF2,	$01,	nRst,	$05,	nF2
	dc.b		$01,	nRst,	$05,	nE2,	$01,	nRst,	$05,	nEb2
	dc.b		$01,	nRst,	$05,	nEb2,	$01,	nRst,	$37
;	Jump To	 	location
	smpsJump	Eggman_Jump02

; FM4 Data
Eggman_FM4:
	dc.b		nRst,	$3C
Eggman_Jump03:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nB2,	$04,	nRst,	$78,	nB2,	$08,	nRst,	$7F
	dc.b		$71,	nCs2,	$20,	nRst,	$7F,	$7F,	$7F,	$3F
;	Jump To	 	location
	smpsJump	Eggman_Jump03

; FM5 Data
Eggman_FM5:
	dc.b		nRst,	$7F,	$7F,	$2E
Eggman_Jump04:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$08
	dc.b		nCs4,	$04,	nE4,	nE4,	nCs4,	nE4,	$08,	nRst
	dc.b		nCs4,	$04,	nE4,	nE4,	nCs4,	nE4,	$09,	nRst
	dc.b		$07,	nCs4,	$04,	nE4,	nE4,	$01,	nRst,	$03
	dc.b		nCs4,	$04,	nE4,	$07,	nRst,	$01,	nE4,	$04
	dc.b		nRst,	nB3,	$06,	nRst,	$02,	nCs4,	$06,	nRst
	dc.b		$02,	nCs4,	$06,	nRst,	$0B,	nCs4,	$03,	nRst
	dc.b		$01,	nE4,	$03,	nRst,	$01,	nE4,	$03,	nRst
	dc.b		$01,	nCs4,	$03,	nRst,	$01,	nE4,	$08,	nRst
	dc.b		nCs4,	$03,	nRst,	$04,	nE4,	nCs4,	nE4,	$08
	dc.b		nRst,	nCs4,	$04,	nE4,	nE4,	$01,	nRst,	$03
	dc.b		nCs4,	$04,	nE4,	nRst,	nE4,	nRst,	nCs4,	nAb4
	dc.b		nFs4,	nE4,	nCs4,	nRst,	nB3,	nB3,	nCs4,	nE4
	dc.b		nRst,	nE4,	$08,	nRst,	$0C,	nCs4,	$04,	nE4
	dc.b		nE4,	nRst,	nB3,	nRst,	nB3,	nB3,	nCs4,	nE4
	dc.b		nRst,	nE4,	$08,	nRst,	$04,	nCs4,	nCs4,	nCs4
	dc.b		nE4,	nRst,	nE4,	nCs4,	nRst,	nB3,	nB3,	nCs4
	dc.b		nE4,	nRst,	nE4,	$08,	nRst,	$0C,	nCs4,	$04
	dc.b		nE4,	nE4,	nRst,	nB3,	nRst,	nB3,	nB3,	nCs4
	dc.b		nE4,	nRst,	nE4,	$08,	nRst,	$04,	nCs4,	nCs4
	dc.b		nCs4,	nAb4,	nFs4,	nE4,	nCs4,	nRst,	$7F,	$7F
	dc.b		$5E
;	Jump To	 	location
	smpsJump	Eggman_Jump04

; PSG1 Data
Eggman_PSG1:
;	Set PSG WvForm	#
	smpsPSGform	$E7
	dc.b		nRst,	$08
Eggman_Jump05:
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$1F,	nAb6,	$02,	nRst,	$16
	dc.b		nAb6,	$02,	nRst,	$12,	nAb6,	$02,	nRst,	nAb6
	dc.b		nRst,	nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst
	dc.b		$07,	nAb6,	$02,	nRst,	$05,	nAb6,	$01,	nRst
	dc.b		$04,	nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst
	dc.b		$03,	nAb6,	$02,	nRst,	nAb6,	nRst,	$12,	nAb6
	dc.b		$02,	nRst,	nAb6,	nRst,	nAb6,	$01,	nRst,	$03
	dc.b		nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst,	$05
	dc.b		nAb6,	$01,	$01,	nRst,	$03,	nAb6,	$02,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	$12,	nAb6
	dc.b		$01,	nRst,	$03,	nAb6,	$02,	nRst,	nAb6,	$01
	dc.b		nRst,	$03,	nAb6,	$01,	nRst,	$07,	nAb6,	$01
	dc.b		nRst,	$06,	nAb6,	$01,	nRst,	$04,	nAb6,	$01
	dc.b		nRst,	$03,	nAb6,	$02,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	$12,	nAb6,	$01,	nRst,	$03,	nAb6,	$02
	dc.b		nRst,	nAb6,	$01,	nRst,	$13,	nAb6,	$02,	nRst
	dc.b		$06,	nAb6,	$02,	nRst,	$0E,	nAb6,	$02,	nRst
	dc.b		$0E,	nAb6,	$02,	nRst,	$0E,	nAb6,	$02,	nRst
	dc.b		$0E,	nAb6,	$02,	nRst,	$0E,	nAb6,	$02,	nRst
	dc.b		$0E,	nAb6,	$02,	nRst,	$0E,	nAb6,	$02,	nRst
	dc.b		$06,	nAb6,	$02,	nRst,	$06,	nAb6,	$02,	nRst
	dc.b		$0E,	nAb6,	$02,	nRst,	$0E,	nAb6,	$02,	nRst
	dc.b		$0E,	nAb6,	$02,	nRst,	$0E,	nAb6,	$02,	nRst
	dc.b		$0E,	nAb6,	$02,	nRst,	$0E,	nAb6,	$02,	nRst
	dc.b		$1E,	nAb6,	$02,	nRst,	$0E,	nAb6,	$02,	nRst
	dc.b		$0E,	nAb6,	$02,	nRst,	$0E,	nAb6,	$02,	nRst
	dc.b		$0E,	nAb6,	$02,	nRst,	$0E,	nAb6,	$02,	nRst
	dc.b		$0E,	nAb6,	$02,	nRst,	$0E,	nAb6,	$02,	nRst
	dc.b		$0E,	nAb6,	$02,	nRst,	$0E,	nAb6,	$02,	nRst
	dc.b		$0E,	nAb6,	$02,	nRst,	$0E,	nAb6,	$02,	nRst
	dc.b		$0E,	nAb6,	$02,	nRst,	$0E,	nAb6,	$02,	nRst
	dc.b		$0E,	nAb6,	$02,	nRst,	$0E,	nAb6,	$02,	nRst
	dc.b		$0E,	nAb6,	$02,	nRst,	$0E,	nAb6,	$02,	nRst
	dc.b		$0E
;	Jump To	 	location
	smpsJump	Eggman_Jump05

; DAC Data
Eggman_DAC:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dLowTimpani,	$02,	nRst,	dKick,	$01,	$01,	$01,	$01
	dc.b		dSnare,	$02,	nRst,	$04,	dLowTimpani,	$02,	nRst,	$04
	dc.b		dLowTimpani,	$02,	nRst,	dSnare,	nRst,	dLowTimpani,	nRst,	dLowTimpani
	dc.b		nRst,	dKick,	$01,	$01,	$01,	$01,	$01,	nRst
	dc.b		$05,	dLowTimpani,	$02,	nRst,	$04,	dLowTimpani,	$02,	nRst
	dc.b		dSnare,	nRst,	dLowTimpani,	nRst,	dSnare,	nRst,	dKick,	nRst
	dc.b		dSnare,	nRst,	dKick,	dLowTimpani,	dKick,	nRst,	dKick,	$01
	dc.b		nRst,	$02,	dKick,	$01,	$01,	nRst,	$03,	dLowTimpani
	dc.b		$02,	nRst,	$01,	dKick,	dLowTimpani,	$02,	nRst,	$01
	dc.b		dKick,	dKick,	nRst,	$02,	dKick,	$01,	$01,	nRst
	dc.b		$02,	dKick,	$01,	$01,	nRst,	$01,	dLowTimpani,	$02
	dc.b		dKick,	$01,	nRst,	$03,	dLowTimpani,	$02,	nRst,	dSnare
	dc.b		nRst,	dKick,	nRst,	dSnare,	nRst,	dKick,	nRst,	dSnare
	dc.b		nRst,	dKick,	dLowTimpani,	dKick,	nRst,	dKick,	$01,	nRst
	dc.b		$02,	dKick,	$01,	$01,	nRst,	$03,	dLowTimpani,	$02
	dc.b		nRst,	$01,	dKick,	dKick,	nRst,	$02,	dKick,	$01
	dc.b		$01,	nRst,	$02,	dKick,	$01,	$01,	nRst,	$02
	dc.b		dKick,	$01,	$01,	nRst,	$01,	dLowTimpani,	$02,	nRst
	dc.b		$04,	dKick,	$01,	nRst,	$03,	dKick,	$01,	nRst
	dc.b		$03,	dKick,	$02,	nRst,	dSnare,	nRst,	dKick,	nRst
	dc.b		dSnare,	nRst,	dKick,	dLowTimpani,	dKick,	nRst,	dLowTimpani,	nRst
	dc.b		$01,	dKick,	dKick,	nRst,	$03,	dLowTimpani,	$02,	nRst
	dc.b		$01,	dKick,	dLowTimpani,	$02,	nRst,	$01,	dKick,	dKick
	dc.b		nRst,	$02,	dKick,	$01,	dSnare,	$02,	nRst,	$01
	dc.b		dKick,	dKick,	nRst,	dLowTimpani,	$02,	dKick,	$01,	nRst
	dc.b		$03,	dLowTimpani,	$02,	nRst,	dKick,	$01,	nRst,	$03
	dc.b		dLowTimpani,	$02,	nRst,	dLowTimpani,	nRst,	dKick,	nRst,	dSnare
	dc.b		nRst,	dKick,	dLowTimpani,	dKick,	nRst,	dLowTimpani,	nRst,	$01
	dc.b		dKick,	dKick,	nRst,	$03,	dLowTimpani,	$02,	nRst,	dLowTimpani
	dc.b		dLowTimpani,	$01,	nRst,	dLowTimpani,	nRst,	$03,	dSnare,	$02
	dc.b		nRst,	$06,	dSnare,	$02,	nRst,	$06,	dLowTimpani,	$02
	dc.b		nRst,	$06,	dLowTimpani,	$02,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	$04,	dLowTimpani,	$02,	$01,	nRst,	$07,	dSnare
	dc.b		$02,	nRst,	$06,	dLowTimpani,	$02,	nRst,	$06,	dSnare
	dc.b		$02,	nRst,	$04,	dLowTimpani,	$02,	$01,	nRst,	$07
	dc.b		dLowTimpani,	$02,	nRst,	$06,	dLowTimpani,	$02,	nRst,	$06
	dc.b		dLowTimpani,	$02,	nRst,	$04,	dLowTimpani,	$02,	$01,	nRst
	dc.b		$07,	dLowTimpani,	$02,	nRst,	$06,	dLowTimpani,	$02,	nRst
	dc.b		$06,	dLowTimpani,	$02,	nRst,	$04,	dLowTimpani,	$02,	dSnare
	dc.b		nRst,	$06,	dLowTimpani,	$02,	nRst,	$06,	dLowTimpani,	$02
	dc.b		nRst,	$06,	dSnare,	$02,	nRst,	$04,	dLowTimpani,	$02
	dc.b		$01,	nRst,	$07,	dSnare,	$02,	nRst,	$06,	dLowTimpani
	dc.b		$02,	nRst,	$06,	dSnare,	$02,	nRst,	$04,	dLowTimpani
	dc.b		$02,	$01,	nRst,	$07,	dSnare,	$02,	nRst,	$06
	dc.b		dLowTimpani,	$02,	nRst,	$06,	dLowTimpani,	$02,	nRst,	$04
	dc.b		dLowTimpani,	$02,	$01,	nRst,	$07,	dSnare,	$02,	nRst
	dc.b		$06,	dLowTimpani,	$02,	nRst,	dLowTimpani,	nRst,	dSnare,	nRst
	dc.b		dLowTimpani,	nRst,	dLowTimpani,	nRst,	$06,	dSnare,	$02,	nRst
	dc.b		$06,	dLowTimpani,	$02,	nRst,	$06,	dSnare,	$02,	nRst
	dc.b		$04,	dLowTimpani,	$02,	$02,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	$06,	dLowTimpani,	$02,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	$06,	dLowTimpani,	$02,	nRst,	$06,	dLowTimpani,	$02
	dc.b		nRst,	$06,	dLowTimpani,	$02,	nRst,	$06,	dLowTimpani,	$02
	dc.b		nRst,	$04,	dLowTimpani,	$02,	$01,	nRst,	$07,	dSnare
	dc.b		$02,	nRst,	$06,	dLowTimpani,	$02,	nRst,	$06,	dSnare
	dc.b		$02,	nRst,	$06,	dLowTimpani,	$02,	nRst,	$06,	dSnare
	dc.b		$02,	nRst,	$06,	dLowTimpani,	$02,	nRst,	$06,	dSnare
	dc.b		$02,	nRst,	$04,	dLowTimpani,	$02,	$02,	nRst,	$06
	dc.b		dSnare,	$02,	nRst,	$06,	dLowTimpani,	$02,	nRst,	$06
	dc.b		dLowTimpani,	$02,	nRst,	$06,	dLowTimpani,	$02,	nRst,	$06
	dc.b		dLowTimpani,	$02,	nRst,	$06,	dLowTimpani,	$02,	nRst,	$06
	dc.b		dLowTimpani,	$02,	nRst,	$04,	dLowTimpani,	$02,	$01,	nRst
	dc.b		$07,	dSnare,	$02,	nRst,	$06,	dLowTimpani,	$02,	nRst
	dc.b		dSnare,	nRst,	dSnare,	nRst,	$06,	dLowTimpani,	$02,	nRst
	dc.b		$06,	dSnare,	$02,	nRst,	$06,	dLowTimpani,	$02,	nRst
	dc.b		$06,	dSnare,	$02,	nRst,	$06
;	Jump To	 	location
	smpsJump	Eggman_DAC

Eggman_Voices:
;	Voice 00
;	$38,$33,$01,$51,$01,$10,$13,$1A,$1B,$0F,$1F,$1F,$1F,$01,$01,$01,$01,$33,$03,$03,$08,$16,$1A,$19,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$05,	$00,	$03
	smpsVcCoarseFreq	$01,	$01,	$01,	$03
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1B,	$1A,	$13,	$10
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$1F,	$1F,	$0F
	smpsVcDecayRate2	$01,	$01,	$01,	$01
	smpsVcDecayLevel	$00,	$00,	$00,	$03
	smpsVcReleaseRate	$08,	$03,	$03,	$03
	smpsVcTotalLevel	$80,	$19,	$1A,	$16

;	Voice 01
;	$38,$33,$01,$51,$01,$10,$13,$1A,$1B,$0F,$1F,$1F,$1F,$01,$01,$01,$01,$33,$03,$03,$08,$16,$1A,$19,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$05,	$00,	$03
	smpsVcCoarseFreq	$01,	$01,	$01,	$03
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1B,	$1A,	$13,	$10
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$1F,	$1F,	$0F
	smpsVcDecayRate2	$01,	$01,	$01,	$01
	smpsVcDecayLevel	$00,	$00,	$00,	$03
	smpsVcReleaseRate	$08,	$03,	$03,	$03
	smpsVcTotalLevel	$80,	$19,	$1A,	$16

;	Voice 02
;	$3D,$01,$01,$01,$01,$94,$19,$19,$19,$0F,$0D,$0D,$0D,$07,$04,$04,$04,$25,$1A,$1A,$1A,$15,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$02
	smpsVcAttackRate	$19,	$19,	$19,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0D,	$0D,	$0D,	$0F
	smpsVcDecayRate2	$04,	$04,	$04,	$07
	smpsVcDecayLevel	$01,	$01,	$01,	$02
	smpsVcReleaseRate	$0A,	$0A,	$0A,	$05
	smpsVcTotalLevel	$80,	$80,	$80,	$15

;	Voice 03
;	$3D,$01,$01,$01,$01,$94,$19,$19,$19,$0F,$0D,$0D,$0D,$07,$04,$04,$04,$25,$1A,$1A,$1A,$15,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$02
	smpsVcAttackRate	$19,	$19,	$19,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0D,	$0D,	$0D,	$0F
	smpsVcDecayRate2	$04,	$04,	$04,	$07
	smpsVcDecayLevel	$01,	$01,	$01,	$02
	smpsVcReleaseRate	$0A,	$0A,	$0A,	$05
	smpsVcTotalLevel	$80,	$80,	$80,	$15

;	Voice 04
;	$3D,$01,$01,$01,$01,$94,$19,$19,$19,$0F,$0D,$0D,$0D,$07,$04,$04,$04,$25,$1A,$1A,$1A,$15,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$02
	smpsVcAttackRate	$19,	$19,	$19,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0D,	$0D,	$0D,	$0F
	smpsVcDecayRate2	$04,	$04,	$04,	$07
	smpsVcDecayLevel	$01,	$01,	$01,	$02
	smpsVcReleaseRate	$0A,	$0A,	$0A,	$05
	smpsVcTotalLevel	$80,	$80,	$80,	$15

;	Voice 05
;	$3D,$01,$01,$01,$01,$94,$19,$19,$19,$0F,$0D,$0D,$0D,$07,$04,$04,$04,$25,$1A,$1A,$1A,$15,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$02
	smpsVcAttackRate	$19,	$19,	$19,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0D,	$0D,	$0D,	$0F
	smpsVcDecayRate2	$04,	$04,	$04,	$07
	smpsVcDecayLevel	$01,	$01,	$01,	$02
	smpsVcReleaseRate	$0A,	$0A,	$0A,	$05
	smpsVcTotalLevel	$80,	$80,	$80,	$15

;	Voice 06
;	$3D,$01,$01,$01,$01,$94,$19,$19,$19,$0F,$0D,$0D,$0D,$07,$04,$04,$04,$25,$1A,$1A,$1A,$15,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$02
	smpsVcAttackRate	$19,	$19,	$19,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0D,	$0D,	$0D,	$0F
	smpsVcDecayRate2	$04,	$04,	$04,	$07
	smpsVcDecayLevel	$01,	$01,	$01,	$02
	smpsVcReleaseRate	$0A,	$0A,	$0A,	$05
	smpsVcTotalLevel	$80,	$80,	$80,	$15

;	Voice 07
;	$3D,$01,$01,$01,$01,$94,$19,$19,$19,$0F,$0D,$0D,$0D,$07,$04,$04,$04,$25,$1A,$1A,$1A,$15,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$02
	smpsVcAttackRate	$19,	$19,	$19,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0D,	$0D,	$0D,	$0F
	smpsVcDecayRate2	$04,	$04,	$04,	$07
	smpsVcDecayLevel	$01,	$01,	$01,	$02
	smpsVcReleaseRate	$0A,	$0A,	$0A,	$05
	smpsVcTotalLevel	$80,	$80,	$80,	$15

;	Voice 08
;	$3D,$01,$01,$01,$01,$94,$19,$19,$19,$0F,$0D,$0D,$0D,$07,$04,$04,$04,$25,$1A,$1A,$1A,$15,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$02
	smpsVcAttackRate	$19,	$19,	$19,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0D,	$0D,	$0D,	$0F
	smpsVcDecayRate2	$04,	$04,	$04,	$07
	smpsVcDecayLevel	$01,	$01,	$01,	$02
	smpsVcReleaseRate	$0A,	$0A,	$0A,	$05
	smpsVcTotalLevel	$80,	$80,	$80,	$15

;	Voice 09
;	$3D,$01,$01,$01,$01,$94,$19,$19,$19,$0F,$0D,$0D,$0D,$07,$04,$04,$04,$25,$1A,$1A,$1A,$15,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$02
	smpsVcAttackRate	$19,	$19,	$19,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0D,	$0D,	$0D,	$0F
	smpsVcDecayRate2	$04,	$04,	$04,	$07
	smpsVcDecayLevel	$01,	$01,	$01,	$02
	smpsVcReleaseRate	$0A,	$0A,	$0A,	$05
	smpsVcTotalLevel	$80,	$80,	$80,	$15

;	Voice 0A
;	$3D,$01,$01,$01,$01,$94,$19,$19,$19,$0F,$0D,$0D,$0D,$07,$04,$04,$04,$25,$1A,$1A,$1A,$15,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$02
	smpsVcAttackRate	$19,	$19,	$19,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0D,	$0D,	$0D,	$0F
	smpsVcDecayRate2	$04,	$04,	$04,	$07
	smpsVcDecayLevel	$01,	$01,	$01,	$02
	smpsVcReleaseRate	$0A,	$0A,	$0A,	$05
	smpsVcTotalLevel	$80,	$80,	$80,	$15
	even
