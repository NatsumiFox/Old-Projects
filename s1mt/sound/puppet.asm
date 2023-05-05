; =============================================================================================
; Project Name:		puppet
; Created:		21st September 2015
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

puppet_Header:
;	Voice Pointer	location
	smpsHeaderVoice	puppet_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$02,	$22

;	DAC Pointer	location
	smpsHeaderDAC	puppet_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	puppet_FM1,	smpsPitch00,	$10
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	puppet_FM2,	smpsPitch00,	$0A
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	puppet_FM3,	smpsPitch00,	$10
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	puppet_FM4,	smpsPitch00,	$10
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	puppet_FM5,	smpsPitch00,	$1F
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	puppet_PSG1,	smpsPitch03lo,	$01,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	puppet_PSG2,	smpsPitch03lo,	$03,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	puppet_PSG3,	smpsPitch00,	$01,	$03

; FM1 Data
puppet_FM1:
;	Alter Volume	value
	smpsAlterVol	$02
;	Set FM Voice	#
	smpsFMvoice	$1B
;	Set Modulation	wait	speed	change	step
	smpsModSet	$14,	$02,	$05,	$02
	dc.b		nC5,	$02,	nD5,	$0C,	nRst,	$04,	nC5,	$18
	dc.b		nRst,	$06,	nA4,	$01,	nB4,	$0C,	nRst,	$05
	dc.b		nC5,	$18,	nRst,	$06,	nD5,	$0C,	nRst,	$06
	dc.b		nC5,	$18,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$FE
;	Set Modulation	wait	speed	change	step
	smpsModSet	$14,	$02,	$02,	$06
;	Alter Volume	value
	smpsAlterVol	$FB
;	Set FM Voice	#
	smpsFMvoice	$06
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nC5,	$02,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nCs5,	$02,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nC5,	$02,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nD5,	$02,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nC5,	$02,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb5,	$02,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nC5,	$02,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nE5,	$02,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$05
;	Set Modulation	wait	speed	change	step
	smpsModSet	$14,	$02,	$05,	$02
;	Alter Volume	value
	smpsAlterVol	$02
;	Set FM Voice	#
	smpsFMvoice	$1B
	dc.b		nC5,	$01,	nD5,	$0C,	nRst,	$05,	nC5,	$18
	dc.b		nRst,	$06,	nB4,	$0C,	nRst,	$06,	nC5,	$18
	dc.b		nRst,	$06,	nC5,	$01,	nD5,	$0C,	nRst,	$05
	dc.b		nC5,	$18,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$FE
;	Set Modulation	wait	speed	change	step
	smpsModSet	$14,	$02,	$02,	$06
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set FM Voice	#
	smpsFMvoice	$1D
	dc.b		nG5,	$02,	nRst,	$07,	nFs5,	$02,	nRst,	$07
	dc.b		nF5,	$02,	nRst,	$07,	nE5,	$02,	nRst,	$07
	dc.b		nEb5,	$02,	nRst,	$04,	nD5,	$02,	nRst,	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nRst,	$0C
;	Set FM Voice	#
	smpsFMvoice	$01
;	Alter Volume	value
	smpsAlterVol	$F0
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4,	$01,	nFs4,	nF4,	nE4,	nEb4,	nD4,	nCs4
;	Alter Volume	value
	smpsAlterVol	$10
;	Alter Volume	value
	smpsAlterVol	$FB
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nC4,	nB3
;	Alter Volume	value
	smpsAlterVol	$05
;	Alter Volume	value
	smpsAlterVol	$F7
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nBb3
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nA3
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nAb3
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Volume	value
	smpsAlterVol	$06
;	Alter Volume	value
	smpsAlterVol	$02
;	Set FM Voice	#
	smpsFMvoice	$0E
puppet_Loop01:
	dc.b		nA5,	$02,	nRst,	$10,	nAb5,	$03,	nRst,	nRst
	dc.b		$12,	nBb5,	$1E,	nRst,	$06,	nF5,	$02,	nRst
	dc.b		$04,	nF5,	$06,	nBb5,	$02,	nRst,	$04,	nA5
	dc.b		$03,	nRst,	$0F,	nAb5,	$04,	nRst,	$02,	nRst
	dc.b		$12,	nBb5,	$0F,	nRst,	$03,	nBb5,	$09,	nRst
	dc.b		$03,	nF5,	$02,	nRst,	$04,	nBb5,	$0C,	nRst
	dc.b		$06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	puppet_Loop01
;	Alter Volume	value
	smpsAlterVol	$FE
;	Alter Volume	value
	smpsAlterVol	$FF
;	Set FM Voice	#
	smpsFMvoice	$0D
	dc.b		nC6,	$02,	nRst,	$01,	nC5,	$02,	nRst,	$01
	dc.b		nF5,	$02,	nRst,	$04,	nC6,	$02,	nRst,	$04
	dc.b		nBb5,	$09,	nC5,	$02,	nRst,	$01,	nF5,	$02
	dc.b		nRst,	$04,	nBb5,	$02,	nRst,	$04,	nA5,	$06
	dc.b		smpsNoAttack,	nA5,	$03,	nC5,	$02,	nRst,	$01,	nF5
	dc.b		$02,	nRst,	$04,	nA5,	$02,	nRst,	$04,	nG5
	dc.b		$0C,	nF5,	$02,	nRst,	$04,	nE5,	$02,	nRst
	dc.b		$04,	nF5,	$06,	smpsNoAttack,	nF5,	$06,	nC5,	$02
	dc.b		nRst,	$04,	nF5,	$02,	nRst,	$04,	nC6,	$0C
	dc.b		nC5,	$02,	nRst,	$04,	nC5,	$02,	nRst,	$04
	dc.b		nF5,	$06,	smpsNoAttack,	nF5,	nE5,	$02,	nRst,	$04
	dc.b		nF5,	$02,	nRst,	$04,	nC5,	$06,	smpsNoAttack,	nC5
	dc.b		$04,	nRst,	$02,	nBb4,	$04,	nRst,	$02,	nRst
	dc.b		$0C,	nC6,	$02,	nRst,	$01,	nC5,	$02,	nRst
	dc.b		$01,	nF5,	$02,	nRst,	$04,	nC6,	$02,	nRst
	dc.b		$04,	nBb5,	$09,	nC5,	$02,	nRst,	$01,	nF5
	dc.b		$02,	nRst,	$04,	nBb5,	$02,	nRst,	$04,	nA5
	dc.b		$06,	smpsNoAttack,	nA5,	$03,	nC5,	$02,	nRst,	$01
	dc.b		nF5,	$02,	nRst,	$04,	nA5,	$02,	nRst,	$04
	dc.b		nG5,	$0C,	nF5,	$02,	nRst,	$04,	nE5,	$02
	dc.b		nRst,	$04,	nF5,	$06,	smpsNoAttack,	nF5,	nC6,	$0C
	dc.b		nF6,	nC6,	$02,	nRst,	$04,	nC6,	$02,	nRst
	dc.b		$04,	nEb6,	$06,	smpsNoAttack,	nEb6,	nD6,	$02,	nRst
	dc.b		$04,	nBb5,	$02,	nRst,	$04,	nF5,	$06,	smpsNoAttack
	dc.b		nF5,	$04,	nRst,	$02,	nG5,	$04,	nRst,	$02
	dc.b		nRst,	$0C
;	Alter Volume	value
	smpsAlterVol	$01
;	Alter Volume	value
	smpsAlterVol	$FC
;	Set FM Voice	#
	smpsFMvoice	$1A
	dc.b		nA5,	$02,	nRst,	$04,	nB5,	$02,	nRst,	$04
	dc.b		nCs6,	$02,	nRst,	$04,	nE6,	$06,	nRst,	nD6
	dc.b		$02,	nRst,	$04,	nCs6,	$02,	nRst,	$04,	nCs6
	dc.b		$0C,	nRst,	$06,	nD6,	$03,	nRst,	nG5,	$06
	dc.b		smpsNoAttack,	nG5,	$12,	nRst,	$06,	nFs5,	$02,	nRst
	dc.b		$04,	nG5,	$02,	nRst,	$04,	nA5,	$03,	nRst
	dc.b		nCs6,	$06,	nRst,	nB5,	$03,	nRst,	nFs5,	$02
	dc.b		nRst,	$04,	nA5,	$09,	nRst,	$03,	nG5,	$02
	dc.b		nRst,	$04,	nFs5,	$02,	nRst,	$04,	nG5,	$06
	dc.b		smpsNoAttack,	nG5,	$12,	nRst,	$06,	nAb5,	$12,	nFs5
	dc.b		nE5,	$0C,	nRst,	$06,	nE6,	$0F,	nRst,	$03
	dc.b		nEb6,	$06,	nRst,	nB5,	nRst,	nCs6,	$02,	nRst
	dc.b		$04,	nE5,	$02,	nRst,	$04,	nE5,	$18,	nRst
	dc.b		$06,	nE5,	$02,	nRst,	$01,	nFs5,	$03,	nAb5
	dc.b		$06,	nCs5,	$02,	nRst,	$04,	nAb5,	$03,	nRst
	dc.b		nFs5,	$06,	smpsNoAttack,	nFs5,	nAb5,	$02,	nRst,	$04
	dc.b		nA5,	$0C,	nB5,	$24,	nE5,	$0C,	nB5,	$12
	dc.b		nA5,	nD6,	$0C,	nE6,	$60
;	Alter Volume	value
	smpsAlterVol	$04
;	Jump To	 	location
	smpsJump	puppet_FM1

; FM2 Data
puppet_FM2:
;	Alter Volume	value
	smpsAlterVol	$04
;	Set FM Voice	#
	smpsFMvoice	$11
	dc.b		nF3,	$06,	nA3,	nB3,	nC4,	nB3,	nC4,	nA3
	dc.b		nD4,	nF3,	nA3,	nB3,	nC4,	nB3,	nC4,	nA3
	dc.b		nD4,	nF3,	nA3,	nB3,	nC4,	nB3,	nC4,	nA3
	dc.b		nD4,	nC3,	nEb3,	nC3,	nE3,	nC3,	nF3,	nC3
	dc.b		nFs3,	nF3,	nA3,	nB3,	nC4,	nB3,	nC4,	nA3
	dc.b		nD4,	nF3,	nA3,	nB3,	nC4,	nB3,	nC4,	nA3
	dc.b		nD4,	nF3,	nA3,	nB3,	nC4,	nB3,	nC4,	nA3
	dc.b		nD4,	nCs3,	$09,	nC3,	nB2,	nBb2,	nA2,	$06
	dc.b		nAb2
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nRst,	$18
;	Set FM Voice	#
	smpsFMvoice	$17
	dc.b		nF2,	$06,	nF3,	nE3,	nF3,	nA2,	nF3,	nBb2
	dc.b		nF3,	nC3,	nF3,	nE3,	nF3,	nBb2,	nF3,	nC3
	dc.b		nF3,	nF2,	nF3,	nE3,	nF3,	nA2,	nF3,	nBb2
	dc.b		nF3,	nC3,	nF3,	nE3,	nF3,	nBb2,	nF3,	nC3
	dc.b		nF3,	nF2,	nF3,	nE3,	nF3,	nA2,	nF3,	nBb2
	dc.b		nF3,	nC3,	nF3,	nE3,	nF3,	nBb2,	nF3,	nC3
	dc.b		nF3,	nF2,	nF3,	nE3,	nF3,	nA2,	nF3,	nBb2
	dc.b		nF3,	nC3,	nF3,	nE3,	nF3,	nBb2,	nF3,	nC3
	dc.b		nF3,	nF2,	$06,	nF2,	$02,	nRst,	$04,	nF2
	dc.b		$02,	nRst,	$04,	nF2,	$03,	nRst,	nF2,	$02
	dc.b		nRst,	$04,	nF2,	$02,	nRst,	$04,	nF2,	$02
	dc.b		nRst,	$04,	nF2,	$02,	nRst,	$04,	nF2,	$02
	dc.b		nRst,	$04,	nF2,	$02,	nRst,	$04,	nF2,	$02
	dc.b		nRst,	$04,	nBb2,	$0C,	nBb2,	$02,	nRst,	$04
	dc.b		nBb2,	$0C,	nA2,	$02,	nRst,	$04,	nA2,	$02
	dc.b		nRst,	$04,	nA2,	$02,	nRst,	$04,	nAb2,	$0C
	dc.b		nAb2,	$02,	nRst,	$04,	nAb2,	$02,	nRst,	$04
	dc.b		nG2,	$06,	smpsNoAttack,	nG2,	$06,	nG2,	$02,	nRst
	dc.b		$04,	nG2,	$02,	nRst,	$04,	nC2,	$06,	smpsNoAttack
	dc.b		nC2,	nD2,	nE2,	$0C,	nF2,	$02,	nRst,	$04
	dc.b		nF2,	$02,	nRst,	$04,	nF2,	$02,	nRst,	$04
	dc.b		nF2,	$03,	nRst,	nF2,	$02,	nRst,	$04,	nF2
	dc.b		$02,	nRst,	$04,	nF2,	$02,	nRst,	$04,	nF2
	dc.b		$02,	nRst,	$04,	nF2,	$02,	nRst,	$04,	nF2
	dc.b		$02,	nRst,	$04,	nF2,	$02,	nRst,	$04,	nBb2
	dc.b		$0C,	nBb2,	$02,	nRst,	$04,	nBb2,	$0C,	nA2
	dc.b		$02,	nRst,	$04,	nA2,	$02,	nRst,	$04,	nA2
	dc.b		$03,	nRst,	nAb2,	$0C,	nAb2,	$02,	nRst,	$04
	dc.b		nAb2,	$03,	nRst,	nG2,	$09,	nRst,	$03,	nG2
	dc.b		$02,	nRst,	$04,	nG2,	$06,	nC3,	smpsNoAttack,	nC3
	dc.b		nD3,	nE3,	$09,	nRst,	$03,	nD3,	$02,	nRst
	dc.b		$04,	nD3,	$02,	nRst,	$04,	nD3,	$02,	nRst
	dc.b		$04,	nD3,	$02,	nRst,	$04,	nD3,	$02,	nRst
	dc.b		$04,	nD3,	$02,	nRst,	$04,	nD3,	$06,	nG2
	dc.b		$02,	nRst,	$04,	nG2,	$02,	nRst,	$04,	nG2
	dc.b		$02,	nRst,	$04,	nG2,	$03,	nRst,	nA2,	$02
	dc.b		nRst,	$04,	nA2,	$02,	nRst,	$04,	nA2,	$02
	dc.b		nRst,	$04,	nA2,	$06,	nB2,	$02,	nRst,	$04
	dc.b		nB2,	$02,	nRst,	$04,	nB2,	$02,	nRst,	$04
	dc.b		nB2,	$02,	nRst,	$04,	nB2,	$02,	nRst,	$04
	dc.b		nB2,	$02,	nRst,	$04,	nB2,	$02,	nRst,	$04
	dc.b		nB2,	$06,	nC3,	$03,	nRst,	nC3,	$02,	nRst
	dc.b		$04,	nC3,	$02,	nRst,	$04,	nC3,	$03,	nRst
	dc.b		nD3,	$02,	nRst,	$04,	nD3,	$02,	nRst,	$04
	dc.b		nD3,	$02,	nRst,	$04,	nC3,	$02,	nRst,	$04
	dc.b		nC3,	$02,	nRst,	$04,	nB2,	$02,	nRst,	$04
	dc.b		nB2,	$02,	nRst,	$04,	nB2,	$02,	nRst,	$04
	dc.b		nB2,	$02,	nRst,	$04,	nB2,	$02,	nRst,	$04
	dc.b		nB2,	$02,	nRst,	$04,	nB2,	$06,	nBb2,	$02
	dc.b		nRst,	$04,	nBb2,	$02,	nRst,	$04,	nBb2,	$02
	dc.b		nRst,	$04,	nBb2,	$02,	nRst,	$04,	nBb2,	$02
	dc.b		nRst,	$04,	nBb2,	$02,	nRst,	$04,	nBb2,	$02
	dc.b		nRst,	$04,	nBb2,	$03,	nRst,	nA2,	nRst,	nA2
	dc.b		$02,	nRst,	$04,	nA2,	$02,	nRst,	$04,	nA2
	dc.b		$02,	nRst,	$04,	nA2,	$02,	nRst,	$04,	nA2
	dc.b		$02,	nRst,	$04,	nA2,	$02,	nRst,	$04,	nA2
	dc.b		$06,	nB2,	$02,	nRst,	$04,	nB2,	$02,	nRst
	dc.b		$04,	nB2,	$02,	nRst,	$04,	nB2,	$02,	nRst
	dc.b		$04,	nB2,	$02,	nRst,	$04,	nB2,	$02,	nRst
	dc.b		$04,	nB2,	$02,	nRst,	$04,	nB2,	$06,	nC3
	dc.b		$03,	nRst,	nC3,	$02,	nRst,	$04,	nC3,	$02
	dc.b		nRst,	$04,	nC3,	$02,	nRst,	$04,	nC3,	$02
	dc.b		nRst,	$04,	nC3,	$02,	nRst,	$04,	nC3,	$02
	dc.b		nRst,	$04,	nC3,	$06,	nD3,	$02,	nRst,	$04
	dc.b		nD3,	$02,	nRst,	$04,	nD3,	$02,	nRst,	$04
	dc.b		nD3,	$02,	nRst,	$04,	nD3,	$02,	nRst,	$04
	dc.b		nD3,	$03,	nRst,	nD2,	$02,	nRst,	$04,	nD2
	dc.b		$06,	nD3,	nE2,	$02,	nRst,	$04,	nE2,	$02
	dc.b		nRst,	$04,	nE3,	$06,	nE2,	nD3,	nE2,	$02
	dc.b		nRst,	$04,	nE2,	$03,	nRst,	nC3,	$06,	nE2
	dc.b		$02,	nRst,	$04,	nE2,	$06,	nB2,	nE2,	$03
	dc.b		nRst,	nAb2,	$06,	nA2,	nB2,	nE3
;	Jump To	 	location
	smpsJump	puppet_FM2

; FM3 Data
puppet_FM3:
;	Alter Volume	value
	smpsAlterVol	$02
;	Set Modulation	wait	speed	change	step
	smpsModSet	$16,	$02,	$03,	$04
;	Set FM Voice	#
	smpsFMvoice	$1A
	dc.b		nBb4,	$0C,	nRst,	$06,	nA4,	$18,	nRst,	$06
	dc.b		nAb4,	$0C,	nRst,	$06,	nA4,	$18,	nRst,	$06
	dc.b		nBb4,	$0C,	nRst,	$06,	nA4,	$18,	nRst,	$06
	dc.b		nRst,	$30,	nBb4,	$0C,	nRst,	$06,	nA4,	$18
	dc.b		nRst,	$06,	nAb4,	$0C,	nRst,	$06,	nA4,	$18
	dc.b		nRst,	$06,	nBb4,	$0C,	nRst,	$06,	nA4,	$18
	dc.b		nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$FE
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Set FM Voice	#
	smpsFMvoice	$1D
	dc.b		nG4,	$02,	nRst,	$07,	nFs4,	$02,	nRst,	$07
	dc.b		nF4,	$02,	nRst,	$07,	nE4,	$02,	nRst,	$07
	dc.b		nEb4,	$02,	nRst,	$04,	nD4,	$02,	nRst,	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Pitch	value
	smpsAlterPitch	$0C
	dc.b		nRst,	$18
;	Alter Volume	value
	smpsAlterVol	$F8
;	Set Modulation	wait	speed	change	step
	smpsModSet	$11,	$01,	$04,	$05
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set FM Voice	#
	smpsFMvoice	$0A
puppet_Loop02:
	dc.b		nC6,	$02,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$14
	dc.b		nC6,	$02,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
	dc.b		nC6,	$02,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$E2
	dc.b		nC6,	$03,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$14
	dc.b		nC6,	$02,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
	dc.b		nC6,	$02,	nRst,	$09
;	Alter Volume	value
	smpsAlterVol	$E2
	dc.b		nC6,	$1E,	nRst,	$06,	nBb5,	$02,	nRst,	$04
	dc.b		nBb5,	$06,	nC6,	$03,	nRst,	nC6,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$14
	dc.b		nC6,	$02,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
	dc.b		nC6,	$02,	nRst,	$03
;	Alter Volume	value
	smpsAlterVol	$E2
	dc.b		nC6,	$04,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$14
	dc.b		nC6,	$02,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
	dc.b		nC6,	$02,	nRst,	$08
;	Alter Volume	value
	smpsAlterVol	$E2
	dc.b		nEb6,	$0F,	nRst,	$03,	nD6,	$09,	nRst,	$03
	dc.b		nBb5,	$02,	nRst,	$04,	nD6,	$0C,	nRst,	$06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	puppet_Loop02
;	Alter Volume	value
	smpsAlterVol	$08
;	Alter Volume	value
	smpsAlterVol	$F6
;	Set FM Voice	#
	smpsFMvoice	$1E
puppet_Loop03:
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nE5,	$03,	nF5,	nC6
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE5,	nF5,	nC6
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nE5,	nF5,	nC6
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE5,	nF5,	nC6,	nRst,	$0C
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	puppet_Loop03
;	Alter Volume	value
	smpsAlterVol	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Volume	value
	smpsAlterVol	$F4
;	Set FM Voice	#
	smpsFMvoice	$0C
puppet_Loop04:
	dc.b		nD3,	$02,	nRst
;	Alter Volume	value
	smpsAlterVol	$0C
	dc.b		nD3,	$01
;	Alter Volume	value
	smpsAlterVol	$F4
	dc.b		nRst
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$07,	puppet_Loop04
puppet_Loop05:
	dc.b		nG3,	$02,	nRst
;	Alter Volume	value
	smpsAlterVol	$0C
	dc.b		nG3,	$01
;	Alter Volume	value
	smpsAlterVol	$F4
	dc.b		nRst
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	puppet_Loop05
puppet_Loop06:
	dc.b		nA3,	$02,	nRst
;	Alter Volume	value
	smpsAlterVol	$0C
	dc.b		nA3,	$01
;	Alter Volume	value
	smpsAlterVol	$F4
	dc.b		nRst
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	puppet_Loop06
puppet_Loop07:
	dc.b		nB3,	$02,	nRst
;	Alter Volume	value
	smpsAlterVol	$0C
	dc.b		nB3,	$01
;	Alter Volume	value
	smpsAlterVol	$F4
	dc.b		nRst
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$07,	puppet_Loop07
;	Set Modulation	wait	speed	change	step
	smpsModSet	$05,	$01,	$04,	$05
	dc.b		nB3,	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0A,	$01,	$04,	$05
puppet_Loop08:
	dc.b		nC4,	$02,	nRst
;	Alter Volume	value
	smpsAlterVol	$0C
	dc.b		nC4,	$01
;	Alter Volume	value
	smpsAlterVol	$F4
	dc.b		nRst
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	puppet_Loop08
puppet_Loop09:
	dc.b		nD4,	$02,	nRst
;	Alter Volume	value
	smpsAlterVol	$0C
	dc.b		nD4,	$01
;	Alter Volume	value
	smpsAlterVol	$F4
	dc.b		nRst
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	puppet_Loop09
	dc.b		nC4,	$02,	nRst
;	Alter Volume	value
	smpsAlterVol	$0C
	dc.b		nC4,	$01
;	Alter Volume	value
	smpsAlterVol	$F4
	dc.b		nRst,	nC4,	$02,	nRst
;	Alter Volume	value
	smpsAlterVol	$0C
	dc.b		nC4,	$01
;	Alter Volume	value
	smpsAlterVol	$F4
	dc.b		nRst
puppet_Loop0A:
	dc.b		nB3,	$02,	nRst
;	Alter Volume	value
	smpsAlterVol	$0C
	dc.b		nB3,	$01
;	Alter Volume	value
	smpsAlterVol	$F4
	dc.b		nRst
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$06,	puppet_Loop0A
;	Set Modulation	wait	speed	change	step
	smpsModSet	$05,	$01,	$04,	$05
	dc.b		nB3,	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0A,	$01,	$04,	$05
puppet_Loop0B:
	dc.b		nBb3,	$02,	nRst
;	Alter Volume	value
	smpsAlterVol	$0C
	dc.b		nBb3,	$01
;	Alter Volume	value
	smpsAlterVol	$F4
	dc.b		nRst,	nBb3,	$02,	nRst
;	Alter Volume	value
	smpsAlterVol	$0C
	dc.b		nBb3,	$01
;	Alter Volume	value
	smpsAlterVol	$F4
	dc.b		nRst,	nBb3,	$02
;	Alter Volume	value
	smpsAlterVol	$0C
	dc.b		nBb3,	$01
;	Alter Volume	value
	smpsAlterVol	$F4
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	puppet_Loop0B
	dc.b		nRst,	$06
puppet_Loop0C:
	dc.b		nBb3,	$02,	nRst
;	Alter Volume	value
	smpsAlterVol	$0C
	dc.b		nBb3,	$01
;	Alter Volume	value
	smpsAlterVol	$F4
	dc.b		nRst
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	puppet_Loop0C
puppet_Loop0D:
	dc.b		nA3,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nA3,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nA3,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nA3,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nAb4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nAb4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nAb4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nAb4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	puppet_Loop0D
puppet_Loop0E:
	dc.b		nB3,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nB3,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nB3,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nB3,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nAb4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nAb4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nAb4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nAb4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	puppet_Loop0E
;	Alter Volume	value
	smpsAlterVol	$0C
;	Alter Volume	value
	smpsAlterVol	$F4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set FM Voice	#
	smpsFMvoice	$0C
	dc.b		nC4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nC4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nC4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nC4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$03
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nC5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nC5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nC5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nC5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nB4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nB4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nB4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nB4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Alter Volume	value
	smpsAlterVol	$FD
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set FM Voice	#
	smpsFMvoice	$0C
	dc.b		nC4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nC4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nC4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nC4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$03
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nC5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nC5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nC5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nC5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Alter Volume	value
	smpsAlterVol	$FD
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set FM Voice	#
	smpsFMvoice	$0C
	dc.b		nC4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nC4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$03
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nB4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nB4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nB4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nB4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Alter Volume	value
	smpsAlterVol	$FD
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set FM Voice	#
	smpsFMvoice	$0C
	dc.b		nC4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nC4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nC4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nC4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$03
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nC5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nC5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Alter Volume	value
	smpsAlterVol	$FD
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set FM Voice	#
	smpsFMvoice	$0C
	dc.b		nD4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nD4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nD4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nD4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$03
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nD5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nD5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nD5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nD5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nC5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nC5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nC5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nC5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Alter Volume	value
	smpsAlterVol	$FD
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set FM Voice	#
	smpsFMvoice	$0C
	dc.b		nD4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nD4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nD4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nD4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$03
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nD5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nD5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nD5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nD5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Alter Volume	value
	smpsAlterVol	$FD
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set FM Voice	#
	smpsFMvoice	$0C
	dc.b		nD4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nD4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$03
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nC5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nC5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nC5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nC5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Alter Volume	value
	smpsAlterVol	$FD
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set FM Voice	#
	smpsFMvoice	$0C
	dc.b		nD4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nD4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nD4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nD4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$03
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nD5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nD5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Alter Volume	value
	smpsAlterVol	$FD
puppet_Loop0F:
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set FM Voice	#
	smpsFMvoice	$0C
	dc.b		nE4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nE4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nE4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nE4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$03
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nE5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nE5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nE5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nE5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nD5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nD5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nD5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nD5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Alter Volume	value
	smpsAlterVol	$FD
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set FM Voice	#
	smpsFMvoice	$0C
	dc.b		nE4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nE4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nE4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nE4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$03
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nE5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nE5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nE5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nE5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Alter Volume	value
	smpsAlterVol	$FD
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set FM Voice	#
	smpsFMvoice	$0C
	dc.b		nE4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nE4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$03
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nD5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nD5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nD5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nD5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Alter Volume	value
	smpsAlterVol	$FD
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set FM Voice	#
	smpsFMvoice	$0C
	dc.b		nE4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nE4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nE4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nE4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$03
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nE5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nE5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
;	Alter Volume	value
	smpsAlterVol	$FD
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	puppet_Loop0F
;	Alter Volume	value
	smpsAlterVol	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Jump To	 	location
	smpsJump	puppet_FM3

; FM4 Data
puppet_FM4:
	dc.b		nRst,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$F0
;	Set FM Voice	#
	smpsFMvoice	$07
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0C,	$01,	$A1,	$CA
	dc.b		nF3,	nRst,	nF3,	smpsModOn
;	Alter Volume	value
	smpsAlterVol	$10
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Volume	value
	smpsAlterVol	$F4
;	Set FM Voice	#
	smpsFMvoice	$08
	dc.b		nC6,	$03,	nC6,	nC6,	nC6
;	Alter Volume	value
	smpsAlterVol	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$F0
;	Set FM Voice	#
	smpsFMvoice	$07
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0C,	$01,	$A1,	$CA
	dc.b		nF3,	$06,	smpsModOn
;	Alter Volume	value
	smpsAlterVol	$10
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Volume	value
	smpsAlterVol	$F4
;	Set FM Voice	#
	smpsFMvoice	$08
	dc.b		nC6,	$03,	nC6,	nC6,	nC6,	nC6,	$06
;	Alter Volume	value
	smpsAlterVol	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$F0
;	Set FM Voice	#
	smpsFMvoice	$07
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0C,	$01,	$A1,	$CA
	dc.b		nF3,	$06,	smpsModOn
;	Alter Volume	value
	smpsAlterVol	$10
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Volume	value
	smpsAlterVol	$F4
;	Set FM Voice	#
	smpsFMvoice	$08
	dc.b		nC6,	$03,	nC6
;	Alter Volume	value
	smpsAlterVol	$0C
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	puppet_FM4
	dc.b		nRst,	$18
;	Alter Volume	value
	smpsAlterVol	$F9
;	Set Modulation	wait	speed	change	step
	smpsModSet	$10,	$01,	$04,	$05
;	Set FM Voice	#
	smpsFMvoice	$1C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
puppet_Loop10:
	dc.b		nF5,	$02,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$14
	dc.b		nF5,	$02,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
	dc.b		nF5,	$02,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$E2
	dc.b		nEb5,	$03,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$14
	dc.b		nEb5,	$02,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
	dc.b		nEb5,	$02,	nRst,	$09
;	Alter Volume	value
	smpsAlterVol	$E2
	dc.b		nD5,	$1E,	nRst,	$06,	nD5,	$02,	nRst,	$04
	dc.b		nD5,	$06,	nE5,	$03,	nRst,	nF5,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$14
	dc.b		nF5,	$02,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
	dc.b		nF5,	$02,	nRst,	$03
;	Alter Volume	value
	smpsAlterVol	$E2
	dc.b		nEb5,	$04,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$14
	dc.b		nEb5,	$02,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
	dc.b		nEb5,	$02,	nRst,	$08
;	Alter Volume	value
	smpsAlterVol	$E2
	dc.b		nG5,	$0F,	nRst,	$03,	nF5,	$09,	nRst,	$03
	dc.b		nD5,	$02,	nRst,	$04,	nF5,	$0C,	nRst,	$06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	puppet_Loop10
;	Alter Volume	value
	smpsAlterVol	$07
	dc.b		smpsModOn,	nRst,	$18,	nRst,	$30,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	$18
;	Alter Volume	value
	smpsAlterVol	$05
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Set FM Voice	#
	smpsFMvoice	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$11,	$02,	$04,	$04
	dc.b		nD5,	$18,	smpsNoAttack,	nD5,	$1E,	nCs5,	$06,	nD5
	dc.b		nG5,	smpsNoAttack,	nG5,	nFs5,	$0C,	nE5,	$18,	nCs5
	dc.b		$12,	nD5,	$0C,	nA5,	$18,	smpsNoAttack,	nA5,	$06
	dc.b		nG5,	$06,	nFs5,	nG5,	smpsModOn
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Alter Volume	value
	smpsAlterVol	$FB
;	Alter Volume	value
	smpsAlterVol	$F7
;	Set FM Voice	#
	smpsFMvoice	$1E
	dc.b		nB4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nB4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nE5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nE5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nAb5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nAb5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nB4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nB4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nE5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nE5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nAb5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nAb5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nB4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nB4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nE5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nE5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nAb5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nAb5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nB4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nB4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nE5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nE5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nAb5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nAb5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nRst,	$0C,	nBb4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nBb4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nCs5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nCs5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nFs5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nFs5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nBb4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nBb4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nCs5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nCs5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nFs5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nFs5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nBb4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nBb4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nCs5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nCs5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nFs4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nFs5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nBb4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nBb4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nCs5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nCs5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nFs5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nFs5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nRst,	$0C,	nA4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nA4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nCs5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nCs5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nE5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nE5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nA4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nA4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nCs5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nCs5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nE5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nE5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nA4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nA4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nCs5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nCs5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nE5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nE5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nA4,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nA4,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nCs5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nCs5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nE5,	$02
;	Alter Volume	value
	smpsAlterVol	$0B
	dc.b		nE5,	$01
;	Alter Volume	value
	smpsAlterVol	$F5
	dc.b		nRst,	$0C
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nCs5,	$06,	nA4,	nCs5,	nB4,	nRst,	nCs5
;	Set FM Voice	#
	smpsFMvoice	$20
	dc.b		nEb5,	smpsNoAttack,	nD5,	$01,	smpsNoAttack,	nCs5,	smpsNoAttack,	nC5
	dc.b		smpsNoAttack,	nB4,	smpsNoAttack,	nBb4,	smpsNoAttack,	nA4,	smpsNoAttack,	nAb4
	dc.b		smpsNoAttack,	nG4,	smpsNoAttack,	nFs4,	smpsNoAttack,	nF4,	smpsNoAttack,	nE4
	dc.b		smpsNoAttack,	nEb4,	nRst,	$12
;	Alter Volume	value
	smpsAlterVol	$02
;	Alter Volume	value
	smpsAlterVol	$09
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0C,	$01,	$A1,	$CA
;	Alter Volume	value
	smpsAlterVol	$01
;	Set FM Voice	#
	smpsFMvoice	$05
;	Alter Pitch	value
	smpsAlterPitch	$18
	dc.b		nRst,	$30,	nRst,	$18,	nE2,	$02,	nRst,	$04
	dc.b		nE2,	$02,	nRst,	$04,	nE3,	$06,	nE2,	nD3
	dc.b		nE2,	$02,	nRst,	$04,	nE2,	$03,	nRst,	nC3
	dc.b		$06,	nE2,	$02,	nRst,	$04,	nE2,	$06,	nB2
	dc.b		nE2,	$03,	nRst,	nAb2,	$06,	nA2,	nB2,	nE3
	dc.b		smpsModOn
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Pitch	value
	smpsAlterPitch	$E8
;	Jump To	 	location
	smpsJump	puppet_FM4

; FM5 Data
puppet_FM5:
	dc.b		nRst,	$0C
;	Jump To	 	location
	smpsJump	puppet_FM1

; PSG1 Data
puppet_PSG1:
	dc.b		nRst,	$30,	nRst,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$0A
;	Set Volume	value
	smpsSetVol	$01
	dc.b		nC6,	$04,	nRst,	$02,	nCs6,	$04,	nRst,	$02
	dc.b		nC6,	$04,	nRst,	$02,	nD6,	$04,	nRst,	$02
	dc.b		nC6,	$04,	nRst,	$02,	nEb6,	$04,	nRst,	$02
	dc.b		nC6,	$04,	nRst,	$02,	nE6,	$04,	nRst,	$02
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nRst,	$30,	nRst,	nRst,	nRst,	nRst,	$18
;	Set PSG Voice	#
	smpsPSGvoice	$00
;	Set Volume	value
	smpsSetVol	$01
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Set Modulation	wait	speed	change	step
	smpsModSet	$13,	$02,	$02,	$02
puppet_Loop11:
	dc.b		nA5,	$02,	nRst,	$10,	nAb5,	$03,	nRst,	nRst
	dc.b		$12,	nBb5,	$1E,	nRst,	$06,	nF5,	$02,	nRst
	dc.b		$04,	nF5,	$06,	nBb5,	$02,	nRst,	$04,	nA5
	dc.b		$03,	nRst,	$0F,	nAb5,	$04,	nRst,	$02,	nRst
	dc.b		$12,	nBb5,	$0F,	nRst,	$03,	nBb5,	$09,	nRst
	dc.b		$03,	nF5,	$02,	nRst,	$04,	nBb5,	$0C,	nRst
	dc.b		$06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	puppet_Loop11
;	Set Volume	value
	smpsSetVol	$FF
;	Alter Pitch	value
	smpsAlterPitch	$0C
	dc.b		smpsModOn
;	Set Volume	value
	smpsSetVol	$01
	dc.b		nC6,	$02,	nRst,	$01,	nC5,	$02,	nRst,	$01
	dc.b		nF5,	$02,	nRst,	$04,	nC6,	$02,	nRst,	$04
	dc.b		nBb5,	$09,	nC5,	$02,	nRst,	$01,	nF5,	$02
	dc.b		nRst,	$04,	nBb5,	$02,	nRst,	$04,	nA5,	$06
	dc.b		smpsNoAttack,	nA5,	$03,	nC5,	$02,	nRst,	$01,	nF5
	dc.b		$02,	nRst,	$04,	nA5,	$02,	nRst,	$04,	nG5
	dc.b		$0C,	nF5,	$02,	nRst,	$04,	nE5,	$02,	nRst
	dc.b		$04,	nF5,	$06,	smpsNoAttack,	nF5,	$06,	nC5,	$02
	dc.b		nRst,	$04,	nF5,	$02,	nRst,	$04,	nC6,	$0C
	dc.b		nC5,	$02,	nRst,	$04,	nC5,	$02,	nRst,	$04
	dc.b		nF5,	$06,	smpsNoAttack,	nF5,	nE5,	$02,	nRst,	$04
	dc.b		nF5,	$02,	nRst,	$04,	nC5,	$06,	smpsNoAttack,	nC5
	dc.b		$04,	nRst,	$02,	nBb4,	$04,	nRst,	$02,	nRst
	dc.b		$0C,	nC6,	$02,	nRst,	$01,	nC5,	$02,	nRst
	dc.b		$01,	nF5,	$02,	nRst,	$04,	nC6,	$02,	nRst
	dc.b		$04,	nBb5,	$09,	nC5,	$02,	nRst,	$01,	nF5
	dc.b		$02,	nRst,	$04,	nBb5,	$02,	nRst,	$04,	nA5
	dc.b		$06,	smpsNoAttack,	nA5,	$03,	nC5,	$02,	nRst,	$01
	dc.b		nF5,	$02,	nRst,	$04,	nA5,	$02,	nRst,	$04
	dc.b		nG5,	$0C,	nF5,	$02,	nRst,	$04,	nE5,	$02
	dc.b		nRst,	$04,	nF5,	$06,	smpsNoAttack,	nF5,	nC6,	$0C
	dc.b		nF6,	nC6,	$02,	nRst,	$04,	nC6,	$02,	nRst
	dc.b		$04,	nEb6,	$06,	smpsNoAttack,	nEb6,	nD6,	$02,	nRst
	dc.b		$04,	nBb5,	$02,	nRst,	$04,	nF5,	$06,	smpsNoAttack
	dc.b		nF5,	$04,	nRst,	$02,	nG5,	$04,	nRst,	$02
	dc.b		nRst,	$0C
;	Set Volume	value
	smpsSetVol	$FF
;	Set Volume	value
	smpsSetVol	$01
;	Set PSG Voice	#
	smpsPSGvoice	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$14,	$02,	$02,	$02
	dc.b		nD5,	$18,	smpsNoAttack,	nD5,	$1E,	nCs5,	$06,	nD5
	dc.b		nG5,	smpsNoAttack,	nG5,	nFs5,	$0C,	nE5,	$16,	nRst
	dc.b		$02,	nCs5,	$12,	nD5,	$0B,	nRst,	$01,	nA5
	dc.b		$18,	smpsNoAttack,	nA5,	$05,	nRst,	$01,	nG5,	$06
	dc.b		nFs5,	nG5
;	Set Volume	value
	smpsSetVol	$FF
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nAb5,	$11,	nRst,	$01,	nFs5,	$12,	nE5,	$0D
	dc.b		nRst,	$05,	nE6,	$12,	nEb6,	$0C,	nB5,	$09
	dc.b		nRst,	$03,	nCs6,	$06,	nE5,	$04,	nRst,	$02
	dc.b		nE5,	$18,	nRst,	$06,	nE5,	$02,	nRst,	$01
	dc.b		nFs5,	$02,	nRst,	$01,	nCs5,	$06,	nA4,	$03
	dc.b		nRst,	nCs5,	$06,	nB4,	smpsNoAttack,	nB4,	nCs5,	nEb5
	dc.b		$0C
;	Set Volume	value
	smpsSetVol	$FE
	dc.b		nE5,	$12,	nA5,	$03,	nE6,	smpsNoAttack,	nE6,	$0C
	dc.b		nE5,	$09,	nRst,	$03,	nE5,	$12,	nA5,	$03
	dc.b		nE6,	smpsNoAttack,	nE6,	$0C,	nE5,	$09,	nRst,	$03
;	Set Modulation	wait	speed	change	step
	smpsModSet	$04,	$01,	$02,	$08
	dc.b		nE5,	nA5,	nE6,	nE5,	nA5,	nE6,	nE5,	nA5
	dc.b		nE6,	nE5,	nA5,	nE6,	nE5,	nA5,	nE6,	nE5
	dc.b		nA5,	nB5,	nD6,	nA5,	nAb5,	nA5,	nD6,	nFs5
	dc.b		nAb5,	nB5,	nFs5,	nA5,	nAb5,	nD5,	nE5,	nD6
	dc.b		smpsModOn
;	Jump To	 	location
	smpsJump	puppet_PSG1

; PSG2 Data
puppet_PSG2:
	dc.b		nRst,	$30,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	$18
;	Set Volume	value
	smpsSetVol	$02
;	Set Modulation	wait	speed	change	step
	smpsModSet	$14,	$02,	$02,	$02
puppet_Loop12:
	dc.b		nF5,	$02,	nRst,	$04
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nF5,	$02,	nRst,	$04
;	Set Volume	value
	smpsSetVol	$01
	dc.b		nF5,	$02,	nRst,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nEb5,	$03,	nRst,	$04
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nEb5,	$02,	nRst,	$04
;	Set Volume	value
	smpsSetVol	$01
	dc.b		nEb5,	$02,	nRst,	$09
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nD5,	$1E,	nRst,	$06,	nD5,	$02,	nRst,	$04
	dc.b		nD5,	$06,	nE5,	$03,	nRst,	nF5,	nRst,	$04
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nF5,	$02,	nRst,	$04
;	Set Volume	value
	smpsSetVol	$01
	dc.b		nF5,	$02,	nRst,	$03
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nEb5,	$04,	nRst,	$04
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nEb5,	$02,	nRst,	$04
;	Set Volume	value
	smpsSetVol	$01
	dc.b		nEb5,	$02,	nRst,	$08
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nG5,	$0F,	nRst,	$03,	nF5,	$09,	nRst,	$03
	dc.b		nD5,	$02,	nRst,	$04,	nF5,	$0C,	nRst,	$06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	puppet_Loop12
	dc.b		smpsModOn
;	Set Volume	value
	smpsSetVol	$FE
;	Set Volume	value
	smpsSetVol	$02
;	Alter Pitch	value
	smpsAlterPitch	$F4
puppet_Loop13:
	dc.b		nE5,	$03,	nF5,	nC6,	nE5,	nF5,	nC6,	nE5
	dc.b		nF5,	nC6,	nE5,	nF5,	nC6,	nRst,	$0C
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	puppet_Loop13
;	Set Volume	value
	smpsSetVol	$FE
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Set Modulation	wait	speed	change	step
	smpsModSet	$16,	$02,	$02,	$02
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nA5,	$04,	nRst,	$02,	nB5,	$04,	nRst,	$02
	dc.b		nCs6,	$04,	nRst,	$02,	nE6,	$0C,	nD6,	$04
	dc.b		nRst,	$02,	nCs6,	$04,	nRst,	$02,	nCs6,	$0C
	dc.b		nRst,	$06,	nD6,	$03,	nRst,	nG5,	$06,	smpsNoAttack
	dc.b		nG5,	$12,	nRst,	$06,	nFs5,	$04,	nRst,	$02
	dc.b		nG5,	$04,	nRst,	$02,	nA5,	$04,	nRst,	$02
	dc.b		nCs6,	$0C,	nB5,	$04,	nRst,	$02,	nFs5,	$04
	dc.b		nRst,	$02,	nA5,	$09,	nRst,	$03,	nG5,	$04
	dc.b		nRst,	$02,	nFs5,	$04,	nRst,	$02,	nG5,	$06
	dc.b		smpsNoAttack,	nG5,	$12,	nRst,	$06
;	Set Volume	value
	smpsSetVol	$FE
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Set Volume	value
	smpsSetVol	$01
	dc.b		nB4,	$03,	nE5,	nAb5,	nB4,	nE5,	nAb5,	nB4
	dc.b		nE5,	nAb5,	nB4,	nE5,	nAb5,	nRst,	$0C,	nBb4
	dc.b		$03,	nCs5,	nFs5,	nBb4,	nCs5,	nFs5,	nBb4,	nCs5
	dc.b		nFs5,	nBb4,	nCs5,	nFs5,	nRst,	$0C,	nA4,	$03
	dc.b		nCs5,	nE5,	nA4,	nCs5,	nE5,	nA4,	nCs5,	nE5
	dc.b		nA4,	nCs5,	nE5,	nRst,	$0C,	nCs5,	$06,	nA4
	dc.b		nCs5,	nB4,	nRst,	nCs5,	nEb5,	nRst
;	Set Volume	value
	smpsSetVol	$FF
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Set Volume	value
	smpsSetVol	$01
;	Set Modulation	wait	speed	change	step
	smpsModSet	$14,	$02,	$02,	$02
	dc.b		nB5,	$24,	nE5,	$0C,	nB5,	$12,	nA5,	nD6
	dc.b		$0C,	nE6,	$60
;	Set Volume	value
	smpsSetVol	$FF
;	Jump To	 	location
	smpsJump	puppet_PSG2

; PSG3 Data
puppet_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
puppet_Loop14:
;	Note Fill	duration
	smpsNoteFill	$01
;	Set PSG Voice	#
	smpsPSGvoice	$03
	dc.b		nA5,	$03,	nA5
;	Note Fill	duration
	smpsNoteFill	$03
;	Set PSG Voice	#
	smpsPSGvoice	$05
	dc.b		nA5
;	Note Fill	duration
	smpsNoteFill	$01
;	Set PSG Voice	#
	smpsPSGvoice	$03
	dc.b		nA5,	nA5,	nA5
;	Note Fill	duration
	smpsNoteFill	$03
;	Set PSG Voice	#
	smpsPSGvoice	$05
	dc.b		nA5
;	Note Fill	duration
	smpsNoteFill	$01
;	Set PSG Voice	#
	smpsPSGvoice	$03
	dc.b		nA5,	nA5,	nA5
;	Note Fill	duration
	smpsNoteFill	$03
;	Set PSG Voice	#
	smpsPSGvoice	$05
	dc.b		nA5
;	Note Fill	duration
	smpsNoteFill	$01
;	Set PSG Voice	#
	smpsPSGvoice	$03
	dc.b		nA5,	nA5
;	Note Fill	duration
	smpsNoteFill	$03
;	Set PSG Voice	#
	smpsPSGvoice	$05
	dc.b		nA5
;	Note Fill	duration
	smpsNoteFill	$04
;	Set PSG Voice	#
	smpsPSGvoice	$05
	dc.b		nA5
;	Note Fill	duration
	smpsNoteFill	$01
;	Set PSG Voice	#
	smpsPSGvoice	$03
	dc.b		nA5
;	Note Fill	duration
	smpsNoteFill	$05
;	Set PSG Voice	#
	smpsPSGvoice	$03
	dc.b		nA5,	$0C,	nA5,	nA5,	nA5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$12,	puppet_Loop14
;	Note Fill	duration
	smpsNoteFill	$01
;	Set PSG Voice	#
	smpsPSGvoice	$03
	dc.b		nA5,	$03,	nA5
;	Note Fill	duration
	smpsNoteFill	$03
;	Set PSG Voice	#
	smpsPSGvoice	$05
	dc.b		nA5
;	Note Fill	duration
	smpsNoteFill	$01
;	Set PSG Voice	#
	smpsPSGvoice	$03
	dc.b		nA5,	nA5,	nA5
;	Note Fill	duration
	smpsNoteFill	$03
;	Set PSG Voice	#
	smpsPSGvoice	$05
	dc.b		nA5
;	Note Fill	duration
	smpsNoteFill	$01
;	Set PSG Voice	#
	smpsPSGvoice	$03
	dc.b		nA5
;	Jump To	 	location
	smpsJump	puppet_PSG3

; DAC Data
puppet_DAC:
dac8C = dKick
dac95 = $90
dac96 = $90
dacA2 = $97
dacA3 = $97

	dc.b		dac8C,	$0C,	dMidTimpani,	$06,	dSnare,	$06,	dSnare,	$0C
	dc.b		dMidTimpani
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	$03,	dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dMidTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	$03,	dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	dLowTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dMidTimpani,	dSnare,	$03,	dLowTimpani,	dSnare,	$0C,	dMidTimpani,	$06
	dc.b		dSnare,	dSnare,	$0C,	dMidTimpani,	$06,	dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dMidTimpani,	$06,	dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	dLowTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dMidTimpani,	$06,	dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		dac8C,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dMidTimpani,	$06,	dSnare,	dSnare,	$0C,	dMidTimpani,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	$03,	dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dMidTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	$03,	dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	dLowTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dMidTimpani,	$06,	dSnare,	$03,	dLowTimpani,	dSnare,	$0C,	dMidTimpani
	dc.b		$06,	dSnare,	$06,	dSnare,	$0C,	dMidTimpani,	$06,	dSnare
	dc.b		dac95,	$09,	dac96,	dac96,	dac96,	dac96,	$06, dac96
	dc.b		dHiTimpani,	$03,	dHiTimpani,	dac8C,	$0C,	dSnare,	$02,	dSnare
	dc.b		dSnare,	dSnare,	$0C,	dHiTimpani,	$06,	dSnare,	dSnare,	$0C
	dc.b		dHiTimpani,	dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nRst,	dSnare,	dHiTimpani,	$06,	dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	nRst,	dSnare,	dSnare,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$06,	dSnare,	$03,	dLowTimpani,	dSnare,	$0C,	dHiTimpani
	dc.b		$06,	dSnare,	dSnare,	nRst,	dHiTimpani,	dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	$06,	dSnare,	$03,	dHiTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	$03,	dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	dSnare,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$03,	dHiTimpani
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dacA2,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dacA3,	$0C,	dHiTimpani,	$06,	dSnare,	dSnare,	$03,	dMidTimpani
	dc.b		dLowTimpani,	$06,	dHiTimpani,	dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	dHiTimpani,	$06,	dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	dSnare,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dacA2,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dacA3,	$0C,	dHiTimpani,	$06,	dSnare,	dSnare,	$0C,	dHiTimpani
	dc.b		$06,	dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dMidTimpani,	dLowTimpani
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$06,	dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	dSnare,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$03,	dHiTimpani,	dMidTimpani,	dHiTimpani
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		dac8C,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$06,	dSnare,	dSnare,	$0C,	dHiTimpani,	dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	$03,	dHiTimpani,	$06,	dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	nRst,	dSnare,	dSnare,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	dLowTimpani,	dSnare,	$0C,	dHiTimpani,	$06,	dSnare,	dSnare
	dc.b		$0C,	dHiTimpani,	$06,	dSnare,	$09,	dSnare,	$03,	dSnare
	dc.b		$06,	dHiTimpani,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dac8C,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$06,	dSnare,	dSnare,	$0C,	dHiTimpani,	$06,	dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	dHiTimpani,	$06,	dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	dMidTimpani,	dLowTimpani,	$06,	dHiTimpani,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	dHiTimpani,	dSnare,	$0C,	dHiTimpani,	$06,	dSnare,	dSnare
	dc.b		$0C,	dHiTimpani,	$06,	dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$06,	dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	dHiTimpani,	dHiTimpani,	dHiTimpani
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dMidTimpani,	dLowTimpani,	dLowTimpani
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dac8C,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$06,	dSnare,	dSnare,	$0C,	dHiTimpani,	dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	$03,	dHiTimpani,	$06,	dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nRst,	dMidTimpani,	dLowTimpani,	$06,	dHiTimpani,	$03,	dHiTimpani,	dSnare
	dc.b		dHiTimpani
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dac8C,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$06,	dSnare,	dSnare,	$0C,	dHiTimpani,	$06,	dSnare
	dc.b		$09,	dSnare,	$03,	dSnare,	$06,	dHiTimpani,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	$03,	dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	dMidTimpani,	dLowTimpani,	dHiTimpani
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dac8C,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$06,	dSnare,	dSnare,	$0C,	dHiTimpani,	$06,	dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	dHiTimpani,	$06,	dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	dSnare,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	dLowTimpani
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dac8C,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$06,	dSnare,	dSnare,	$0C,	dHiTimpani,	$06,	dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$06,	dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	dSnare,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$03,	dMidTimpani,	dLowTimpani,	dLowTimpani
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dac8C,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$06,	dSnare,	dSnare,	$0C,	dHiTimpani,	dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	$03,	dHiTimpani,	$06,	dSnare,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare,	nRst,	dSnare,	dSnare,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	dLowTimpani
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dac8C,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$06,	dSnare,	dSnare,	$0C,	dHiTimpani,	$06,	dSnare
	dc.b		$09,	dHiTimpani,	$03,	dSnare,	dHiTimpani,	dHiTimpani
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dSnare
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	dMidTimpani,	dHiTimpani,	dMidTimpani,	dHiTimpani,	dMidTimpani,	dHiTimpani,	dMidTimpani
	dc.b		dLowTimpani,	dHiTimpani
;	Jump To	 	location
	smpsJump	puppet_DAC

puppet_Voices:
;	Voice 00
;	$06,$01,$33,$71,$32,$0A,$88,$4C,$52,$00,$05,$00,$09,$01,$00,$01,$00,$03,$03,$24,$05,$4D,$85,$80,$81
;				#
	smpsVcAlgorithm		$06
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$07,	$03,	$00
	smpsVcCoarseFreq	$02,	$01,	$03,	$01
	smpsVcRateScale		$01,	$01,	$02,	$00
	smpsVcAttackRate	$12,	$0C,	$08,	$0A
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$09,	$00,	$05,	$00
	smpsVcDecayRate2	$00,	$01,	$00,	$01
	smpsVcDecayLevel	$00,	$02,	$00,	$00
	smpsVcReleaseRate	$05,	$04,	$03,	$03
	smpsVcTotalLevel	$81,	$80,	$85,	$4D

;	Voice 01
;	$3D,$01,$21,$51,$01,$12,$14,$14,$0F,$0A,$05,$05,$05,$00,$00,$00,$00,$26,$28,$28,$18,$19,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$05,	$02,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$0F,	$14,	$14,	$12
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$05,	$05,	$0A
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$01,	$02,	$02,	$02
	smpsVcReleaseRate	$08,	$08,	$08,	$06
	smpsVcTotalLevel	$80,	$80,	$80,	$19

;	Voice 02
;	$16,$7A,$74,$3C,$31,$1F,$1F,$1F,$1F,$0A,$07,$0C,$06,$07,$0A,$07,$05,$25,$A7,$A7,$55,$14,$85,$8A,$80
;				#
	smpsVcAlgorithm		$06
	smpsVcFeedback		$02
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$07,	$07
	smpsVcCoarseFreq	$01,	$0C,	$04,	$0A
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$06,	$0C,	$07,	$0A
	smpsVcDecayRate2	$05,	$07,	$0A,	$07
	smpsVcDecayLevel	$05,	$0A,	$0A,	$02
	smpsVcReleaseRate	$05,	$07,	$07,	$05
	smpsVcTotalLevel	$80,	$8A,	$85,	$14

;	Voice 03
;	$3B,$00,$00,$00,$01,$99,$9F,$1F,$1F,$0F,$0F,$14,$0F,$00,$00,$00,$00,$F8,$F8,$F8,$FA,$28,$1E,$05,$80
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$00,	$00,	$00
	smpsVcRateScale		$00,	$00,	$02,	$02
	smpsVcAttackRate	$1F,	$1F,	$1F,	$19
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$14,	$0F,	$0F
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$0A,	$08,	$08,	$08
	smpsVcTotalLevel	$80,	$05,	$1E,	$28

;	Voice 04
;	$3A,$31,$02,$02,$72,$8F,$8F,$4F,$4D,$09,$09,$00,$06,$00,$00,$00,$00,$15,$F5,$05,$08,$17,$1E,$16,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$00,	$00,	$03
	smpsVcCoarseFreq	$02,	$02,	$02,	$01
	smpsVcRateScale		$01,	$01,	$02,	$02
	smpsVcAttackRate	$0D,	$0F,	$0F,	$0F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$06,	$00,	$09,	$09
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$00,	$0F,	$01
	smpsVcReleaseRate	$08,	$05,	$05,	$05
	smpsVcTotalLevel	$80,	$16,	$1E,	$17

;	Voice 05
;	$30,$30,$3A,$30,$30,$9E,$D8,$DC,$DC,$0E,$0A,$04,$05,$08,$08,$08,$08,$B6,$B6,$B6,$B6,$14,$2F,$14,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$03,	$03
	smpsVcCoarseFreq	$00,	$00,	$0A,	$00
	smpsVcRateScale		$03,	$03,	$03,	$02
	smpsVcAttackRate	$1C,	$1C,	$18,	$1E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$04,	$0A,	$0E
	smpsVcDecayRate2	$08,	$08,	$08,	$08
	smpsVcDecayLevel	$0B,	$0B,	$0B,	$0B
	smpsVcReleaseRate	$06,	$06,	$06,	$06
	smpsVcTotalLevel	$80,	$14,	$2F,	$14

;	Voice 06
;	$3B,$61,$02,$24,$05,$5F,$5B,$5E,$4D,$04,$04,$08,$06,$00,$00,$00,$04,$24,$23,$28,$26,$1E,$20,$24,$80
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$02,	$00,	$06
	smpsVcCoarseFreq	$05,	$04,	$02,	$01
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$0D,	$1E,	$1B,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$06,	$08,	$04,	$04
	smpsVcDecayRate2	$04,	$00,	$00,	$00
	smpsVcDecayLevel	$02,	$02,	$02,	$02
	smpsVcReleaseRate	$06,	$08,	$03,	$04
	smpsVcTotalLevel	$80,	$24,	$20,	$1E

;	Voice 07
;	$00,$02,$07,$00,$01,$DF,$DF,$1F,$1F,$12,$11,$14,$0E,$0A,$00,$0A,$0D,$F3,$F6,$F3,$F8,$22,$07,$20,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$00,	$07,	$02
	smpsVcRateScale		$00,	$00,	$03,	$03
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0E,	$14,	$11,	$12
	smpsVcDecayRate2	$0D,	$0A,	$00,	$0A
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$08,	$03,	$06,	$03
	smpsVcTotalLevel	$80,	$20,	$07,	$22

;	Voice 08
;	$28,$2F,$68,$37,$32,$1F,$1F,$1F,$1F,$15,$15,$15,$13,$13,$0C,$0D,$10,$26,$26,$36,$29,$00,$06,$1A,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$06,	$02
	smpsVcCoarseFreq	$02,	$07,	$08,	$0F
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$13,	$15,	$15,	$15
	smpsVcDecayRate2	$10,	$0D,	$0C,	$13
	smpsVcDecayLevel	$02,	$03,	$02,	$02
	smpsVcReleaseRate	$09,	$06,	$06,	$06
	smpsVcTotalLevel	$80,	$1A,	$06,	$00

;	Voice 09
;	$3A,$32,$56,$32,$42,$8D,$4F,$15,$52,$06,$08,$07,$04,$02,$00,$00,$00,$1F,$1F,$2F,$2F,$19,$20,$2A,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$04,	$03,	$05,	$03
	smpsVcCoarseFreq	$02,	$02,	$06,	$02
	smpsVcRateScale		$01,	$00,	$01,	$02
	smpsVcAttackRate	$12,	$15,	$0F,	$0D
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$04,	$07,	$08,	$06
	smpsVcDecayRate2	$00,	$00,	$00,	$02
	smpsVcDecayLevel	$02,	$02,	$01,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$2A,	$20,	$19

;	Voice 0A
;	$3A,$31,$37,$31,$31,$8D,$8D,$8E,$53,$0E,$0E,$0E,$03,$06,$06,$06,$05,$1F,$FF,$1F,$0F,$17,$25,$23,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$03,	$03
	smpsVcCoarseFreq	$01,	$01,	$07,	$01
	smpsVcRateScale		$01,	$02,	$02,	$02
	smpsVcAttackRate	$13,	$0E,	$0D,	$0D
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$03,	$0E,	$0E,	$0E
	smpsVcDecayRate2	$05,	$06,	$06,	$06
	smpsVcDecayLevel	$00,	$01,	$0F,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$23,	$25,	$17

;	Voice 0B
;	$3A,$41,$45,$31,$41,$59,$59,$5C,$4E,$0A,$0B,$0D,$04,$00,$00,$00,$00,$1F,$5F,$2F,$0F,$1D,$0F,$30,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$04,	$03,	$04,	$04
	smpsVcCoarseFreq	$01,	$01,	$05,	$01
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$0E,	$1C,	$19,	$19
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$04,	$0D,	$0B,	$0A
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$02,	$05,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$30,	$0F,	$1D

;	Voice 0C
;	$2A,$23,$3A,$32,$74,$1E,$1F,$1F,$1F,$17,$1B,$02,$03,$00,$08,$03,$0B,$3F,$3F,$0F,$6F,$0C,$0C,$1C,$84
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$02
	smpsVcCoarseFreq	$04,	$02,	$0A,	$03
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$03,	$02,	$1B,	$17
	smpsVcDecayRate2	$0B,	$03,	$08,	$00
	smpsVcDecayLevel	$06,	$00,	$03,	$03
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$84,	$1C,	$0C,	$0C

;	Voice 0D
;	$3D,$01,$65,$14,$30,$8E,$52,$17,$4C,$08,$08,$0E,$03,$00,$00,$00,$00,$1D,$1A,$18,$1A,$1A,$80,$80,$88
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$01,	$06,	$00
	smpsVcCoarseFreq	$00,	$04,	$05,	$01
	smpsVcRateScale		$01,	$00,	$01,	$02
	smpsVcAttackRate	$0C,	$17,	$12,	$0E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$03,	$0E,	$08,	$08
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$0A,	$08,	$0A,	$0D
	smpsVcTotalLevel	$88,	$80,	$80,	$1A

;	Voice 0E
;	$2C,$61,$04,$01,$33,$5F,$94,$58,$94,$05,$05,$05,$07,$02,$02,$02,$02,$1F,$68,$16,$A7,$1E,$80,$15,$81
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$00,	$00,	$06
	smpsVcCoarseFreq	$03,	$01,	$04,	$01
	smpsVcRateScale		$02,	$01,	$02,	$01
	smpsVcAttackRate	$14,	$18,	$14,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$07,	$05,	$05,	$05
	smpsVcDecayRate2	$02,	$02,	$02,	$02
	smpsVcDecayLevel	$0A,	$01,	$06,	$01
	smpsVcReleaseRate	$07,	$06,	$08,	$0F
	smpsVcTotalLevel	$81,	$15,	$80,	$1E

;	Voice 0F
;	$3A,$3C,$4F,$31,$23,$1F,$DF,$1F,$9F,$0C,$02,$0C,$05,$04,$04,$04,$07,$1F,$FF,$0F,$2F,$20,$39,$1E,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$02,	$03,	$04,	$03
	smpsVcCoarseFreq	$03,	$01,	$0F,	$0C
	smpsVcRateScale		$02,	$00,	$03,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$0C,	$02,	$0C
	smpsVcDecayRate2	$07,	$04,	$04,	$04
	smpsVcDecayLevel	$02,	$00,	$0F,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$1E,	$39,	$20

;	Voice 10
;	$38,$63,$31,$31,$31,$10,$13,$1A,$1B,$0E,$00,$00,$00,$00,$00,$00,$00,$3F,$0F,$0F,$0F,$1A,$19,$1A,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$03,	$06
	smpsVcCoarseFreq	$01,	$01,	$01,	$03
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1B,	$1A,	$13,	$10
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$00,	$00,	$0E
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$00,	$00,	$03
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$1A,	$19,	$1A

;	Voice 11
;	$3D,$65,$28,$04,$61,$DF,$1F,$1F,$1F,$12,$04,$0F,$0F,$00,$00,$00,$00,$2F,$09,$0F,$0F,$26,$8A,$8B,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$06,	$00,	$02,	$06
	smpsVcCoarseFreq	$01,	$04,	$08,	$05
	smpsVcRateScale		$00,	$00,	$00,	$03
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$0F,	$04,	$12
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$00,	$00,	$02
	smpsVcReleaseRate	$0F,	$0F,	$09,	$0F
	smpsVcTotalLevel	$80,	$8B,	$8A,	$26

;	Voice 12
;	$30,$75,$75,$71,$31,$D8,$58,$96,$94,$01,$0B,$03,$08,$01,$04,$01,$01,$F3,$23,$34,$35,$34,$29,$10,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$07,	$07,	$07
	smpsVcCoarseFreq	$01,	$01,	$05,	$05
	smpsVcRateScale		$02,	$02,	$01,	$03
	smpsVcAttackRate	$14,	$16,	$18,	$18
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$08,	$03,	$0B,	$01
	smpsVcDecayRate2	$01,	$01,	$04,	$01
	smpsVcDecayLevel	$03,	$03,	$02,	$0F
	smpsVcReleaseRate	$05,	$04,	$03,	$03
	smpsVcTotalLevel	$80,	$10,	$29,	$34

;	Voice 13
;	$1C,$76,$74,$36,$34,$94,$99,$94,$99,$08,$0A,$08,$0A,$00,$05,$00,$05,$35,$47,$35,$47,$1E,$80,$19,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$03
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$07,	$07
	smpsVcCoarseFreq	$04,	$06,	$04,	$06
	smpsVcRateScale		$02,	$02,	$02,	$02
	smpsVcAttackRate	$19,	$14,	$19,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$08,	$0A,	$08
	smpsVcDecayRate2	$05,	$00,	$05,	$00
	smpsVcDecayLevel	$04,	$03,	$04,	$03
	smpsVcReleaseRate	$07,	$05,	$07,	$05
	smpsVcTotalLevel	$80,	$19,	$80,	$1E

;	Voice 14
;	$3A,$42,$4A,$32,$42,$5C,$53,$5C,$4F,$07,$0F,$0C,$0A,$00,$00,$00,$00,$1F,$36,$18,$07,$1B,$0C,$33,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$04,	$03,	$04,	$04
	smpsVcCoarseFreq	$02,	$02,	$0A,	$02
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$0F,	$1C,	$13,	$1C
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$0C,	$0F,	$07
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$01,	$03,	$01
	smpsVcReleaseRate	$07,	$08,	$06,	$0F
	smpsVcTotalLevel	$80,	$33,	$0C,	$1B

;	Voice 15
;	$16,$7A,$74,$3C,$31,$1F,$1F,$1F,$1F,$0A,$07,$0C,$06,$07,$0A,$07,$05,$25,$A7,$A7,$55,$14,$85,$8A,$80
;				#
	smpsVcAlgorithm		$06
	smpsVcFeedback		$02
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$07,	$07
	smpsVcCoarseFreq	$01,	$0C,	$04,	$0A
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$06,	$0C,	$07,	$0A
	smpsVcDecayRate2	$05,	$07,	$0A,	$07
	smpsVcDecayLevel	$05,	$0A,	$0A,	$02
	smpsVcReleaseRate	$05,	$07,	$07,	$05
	smpsVcTotalLevel	$80,	$8A,	$85,	$14

;	Voice 16
;	$3D,$01,$21,$51,$01,$12,$14,$14,$0F,$0A,$05,$05,$05,$00,$00,$00,$00,$2B,$2B,$2B,$1B,$19,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$05,	$02,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$0F,	$14,	$14,	$12
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$05,	$05,	$0A
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$01,	$02,	$02,	$02
	smpsVcReleaseRate	$0B,	$0B,	$0B,	$0B
	smpsVcTotalLevel	$80,	$80,	$80,	$19

;	Voice 17
;	$35,$31,$38,$30,$31,$9E,$D8,$DF,$DC,$0E,$0A,$01,$05,$08,$08,$08,$08,$B6,$B6,$B6,$B6,$14,$87,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$03,	$03
	smpsVcCoarseFreq	$01,	$00,	$08,	$01
	smpsVcRateScale		$03,	$03,	$03,	$02
	smpsVcAttackRate	$1C,	$1F,	$18,	$1E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$01,	$0A,	$0E
	smpsVcDecayRate2	$08,	$08,	$08,	$08
	smpsVcDecayLevel	$0B,	$0B,	$0B,	$0B
	smpsVcReleaseRate	$06,	$06,	$06,	$06
	smpsVcTotalLevel	$80,	$80,	$87,	$14

;	Voice 18
;	$18,$32,$30,$30,$30,$9E,$DC,$1C,$9A,$0D,$06,$04,$01,$08,$0A,$03,$05,$B6,$B6,$36,$26,$2C,$22,$14,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$03
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$03,	$03
	smpsVcCoarseFreq	$00,	$00,	$00,	$02
	smpsVcRateScale		$02,	$00,	$03,	$02
	smpsVcAttackRate	$1A,	$1C,	$1C,	$1E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$01,	$04,	$06,	$0D
	smpsVcDecayRate2	$05,	$03,	$0A,	$08
	smpsVcDecayLevel	$02,	$03,	$0B,	$0B
	smpsVcReleaseRate	$06,	$06,	$06,	$06
	smpsVcTotalLevel	$80,	$14,	$22,	$2C

;	Voice 19
;	$38,$58,$33,$53,$31,$5F,$5F,$1C,$5F,$09,$0A,$06,$02,$00,$00,$00,$08,$F6,$F9,$F8,$08,$27,$1D,$22,$81
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$05,	$03,	$05
	smpsVcCoarseFreq	$01,	$03,	$03,	$08
	smpsVcRateScale		$01,	$00,	$01,	$01
	smpsVcAttackRate	$1F,	$1C,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$02,	$06,	$0A,	$09
	smpsVcDecayRate2	$08,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$08,	$08,	$09,	$06
	smpsVcTotalLevel	$81,	$22,	$1D,	$27

;	Voice 1A
;	$24,$3E,$31,$16,$11,$1F,$98,$1F,$9F,$0F,$01,$0E,$01,$0E,$05,$08,$05,$50,$02,$60,$02,$2A,$81,$20,$81
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
	smpsVcTotalLevel	$81,	$20,	$81,	$2A

;	Voice 1B
;	$1C,$3F,$03,$31,$31,$1F,$1B,$1E,$1E,$0F,$07,$06,$07,$00,$0A,$00,$00,$8A,$86,$F6,$F7,$26,$80,$17,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$03
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$00,	$03
	smpsVcCoarseFreq	$01,	$01,	$03,	$0F
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1E,	$1E,	$1B,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$07,	$06,	$07,	$0F
	smpsVcDecayRate2	$00,	$00,	$0A,	$00
	smpsVcDecayLevel	$0F,	$0F,	$08,	$08
	smpsVcReleaseRate	$07,	$06,	$06,	$0A
	smpsVcTotalLevel	$80,	$17,	$80,	$26

;	Voice 1C
;	$3A,$31,$37,$31,$31,$8D,$8D,$8E,$53,$0E,$0E,$0E,$03,$06,$06,$06,$04,$1F,$FF,$1F,$0F,$18,$23,$1E,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$03,	$03
	smpsVcCoarseFreq	$01,	$01,	$07,	$01
	smpsVcRateScale		$01,	$02,	$02,	$02
	smpsVcAttackRate	$13,	$0E,	$0D,	$0D
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$03,	$0E,	$0E,	$0E
	smpsVcDecayRate2	$04,	$06,	$06,	$06
	smpsVcDecayLevel	$00,	$01,	$0F,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$1E,	$23,	$18

;	Voice 1D
;	$3C,$32,$32,$51,$02,$1F,$0B,$1F,$0E,$07,$1F,$07,$1F,$00,$00,$00,$00,$12,$05,$13,$07,$1B,$81,$12,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$05,	$03,	$03
	smpsVcCoarseFreq	$02,	$01,	$02,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$0E,	$1F,	$0B,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$07,	$1F,	$07
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$01,	$00,	$01
	smpsVcReleaseRate	$07,	$03,	$05,	$02
	smpsVcTotalLevel	$80,	$12,	$81,	$1B

;	Voice 1E
;	$3A,$11,$01,$01,$01,$DF,$1F,$1F,$1A,$1F,$1F,$1F,$1F,$09,$08,$07,$00,$04,$04,$04,$05,$1D,$26,$18,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$01
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$03
	smpsVcAttackRate	$1A,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$1F,	$1F,	$1F
	smpsVcDecayRate2	$00,	$07,	$08,	$09
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$05,	$04,	$04,	$04
	smpsVcTotalLevel	$80,	$18,	$26,	$1D

;	Voice 1F
;	$38,$20,$62,$70,$32,$14,$12,$0A,$0A,$0E,$0E,$09,$1F,$00,$00,$00,$00,$5F,$5F,$AF,$0F,$1C,$28,$14,$83
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$07,	$06,	$02
	smpsVcCoarseFreq	$02,	$00,	$02,	$00
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$0A,	$0A,	$12,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$09,	$0E,	$0E
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$0A,	$05,	$05
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$83,	$14,	$28,	$1C

;	Voice 20
;	$3A,$11,$01,$01,$01,$DF,$1F,$1F,$1A,$1F,$1F,$1F,$1F,$09,$08,$07,$00,$04,$04,$04,$0A,$1D,$26,$18,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$01
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$03
	smpsVcAttackRate	$1A,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$1F,	$1F,	$1F
	smpsVcDecayRate2	$00,	$07,	$08,	$09
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$0A,	$04,	$04,	$04
	smpsVcTotalLevel	$80,	$18,	$26,	$1D
	even
