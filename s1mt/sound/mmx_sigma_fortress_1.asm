; =============================================================================================
; Project Name:		MMX_Sigma_Fortress1
; Created:		3rd February 2014
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

MMX_Sigma_Fortress1_Header:
;	Voice Pointer	location
	smpsHeaderVoice	MMX_Sigma_Fortress1_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$01,	$04

;	DAC Pointer	location
	smpsHeaderDAC	MMX_Sigma_Fortress1_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	MMX_Sigma_Fortress1_FM1,	smpsPitch00,	$0E
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	MMX_Sigma_Fortress1_FM2,	smpsPitch00,	$19
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	MMX_Sigma_Fortress1_FM3,	smpsPitch00,	$19
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	MMX_Sigma_Fortress1_FM4,	smpsPitch00,	$1E
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	MMX_Sigma_Fortress1_FM5,	smpsPitch00,	$1D
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	MMX_Sigma_Fortress1_PSG2,	smpsPitch00,	$06,	$00
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	MMX_Sigma_Fortress1_PSG1,	smpsPitch00,	$03,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	MMX_Sigma_Fortress1_PSG3,	smpsPitch00,	$02,	$00

; DAC Data
MMX_Sigma_Fortress1_DAC:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nRst,	$40,	$40,	$40,	$40,	$40,	$40,	$40
	dc.b		$40
MMX_Sigma_Fortress1_Jump01:
;	Set FM Voice	#
	smpsFMvoice	$FF
	dc.b		$84,	$10,	$97,	$0C,	$98,	$04,	$98,	$08
	dc.b		$98,	$08,	$97,	$10,	$98,	$10,	$97,	$10
	dc.b		$98,	$04,	$97,	$04,	$98,	$08,	$97,	$08
	dc.b		$97,	$04,	$97,	$04,	$84,	$10,	$97,	$0C
	dc.b		$98,	$04,	$98,	$08,	$98,	$08,	$97,	$10
	dc.b		$98,	$10,	$97,	$10,	$98,	$04,	$97,	$04
	dc.b		$98,	$08,	$97,	$08,	$97,	$04,	$97,	$04
	dc.b		$84,	$10,	$97,	$0C,	$98,	$04,	$98,	$08
	dc.b		$98,	$08,	$97,	$10,	$98,	$10,	$97,	$10
	dc.b		$98,	$04,	$97,	$04,	$98,	$08,	$97,	$08
	dc.b		$97,	$04,	$97,	$04,	$84,	$10,	$97,	$0C
	dc.b		$98,	$04,	$98,	$08,	$98,	$08,	$97,	$10
	dc.b		$98,	$08,	$97,	$08,	dMidTimpani,	$05,	dMidTimpani,	$06
	dc.b		dMidTimpani,	$05,	dLowTimpani,	$05,	dLowTimpani,	$06,	dLowTimpani,	$05
	dc.b		dVLowTimpani,	$05,	dVLowTimpani,	$06,	dVLowTimpani,	$05,	$98,	$20
	dc.b		$97,	$08,	$98,	$0C,	$98,	$0C,	$98,	$20
	dc.b		$97,	$20,	$98,	$20,	$97,	$08,	$98,	$0C
	dc.b		$98,	$0C,	$98,	$20,	$97,	$20,	$98,	$20
	dc.b		$97,	$08,	$98,	$0C,	$98,	$0C,	$98,	$20
	dc.b		$97,	$20,	$98,	$20,	$97,	$08,	$98,	$0C
	dc.b		$98,	$0C,	$98,	$20,	$97,	$10,	$97,	$04
	dc.b		$97,	$04,	$98,	$04,	$97,	$04,	$84,	$10
	dc.b		$97,	$08,	$98,	$10,	$98,	$08,	$97,	$10
	dc.b		$98,	$08,	$98,	$08,	$97,	$18,	$98,	$08
	dc.b		$97,	$10,	$98,	$10,	$97,	$08,	$98,	$10
	dc.b		$98,	$08,	$97,	$10,	$98,	$08,	$98,	$08
	dc.b		$97,	$18,	$98,	$08,	$97,	$10,	$84,	$10
	dc.b		$97,	$08,	$98,	$10,	$98,	$08,	$97,	$10
	dc.b		$98,	$08,	$98,	$08,	$97,	$18,	$98,	$08
	dc.b		$97,	$10,	$98,	$10,	$97,	$08,	$98,	$10
	dc.b		$98,	$08,	$97,	$10,	$98,	$08,	$98,	$08
	dc.b		$97,	$14,	dHiTimpani,	$04,	dHiTimpani,	$04,	dMidTimpani,	$04
	dc.b		dMidTimpani,	$04,	dLowTimpani,	$04,	$97,	$04,	dVLowTimpani,	$04
	dc.b		$84,	$10,	$97,	$08,	$98,	$10,	$98,	$08
	dc.b		$97,	$10,	$98,	$10,	$97,	$18,	$98,	$04
	dc.b		$98,	$04,	$97,	$10,	$98,	$10,	$97,	$08
	dc.b		$98,	$10,	$98,	$08,	$97,	$10,	$98,	$10
	dc.b		$97,	$10,	$98,	$04,	$98,	$04,	$97,	$08
	dc.b		$98,	$04,	$98,	$04,	$97,	$08,	$84,	$10
	dc.b		$97,	$08,	$98,	$10,	$98,	$08,	$97,	$10
	dc.b		$98,	$10,	$97,	$18,	$98,	$04,	$98,	$04
	dc.b		$97,	$10,	$98,	$10,	$97,	$08,	$98,	$10
	dc.b		$98,	$08,	$97,	$10,	$98,	$10,	$97,	$10
	dc.b		dHiTimpani,	$04,	dHiTimpani,	$04,	dMidTimpani,	$04,	dMidTimpani,	$04
	dc.b		dLowTimpani,	$04,	dLowTimpani,	$04,	dVLowTimpani,	$04,	dVLowTimpani,	$04
;	Jump To	 	location
	smpsJump	MMX_Sigma_Fortress1_Jump01

; FM1 Data
MMX_Sigma_Fortress1_FM1:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Notes	value
	smpsAlterNote	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nEb2,	$10,	nEb2,	$08,	nCs2,	$04,	nEb2,	$10
	dc.b		nRst,	$14
;	Alter Volume	value
	smpsAlterVol	$15
	dc.b		nEb2,	$08,	nEb3,	$10,	nEb2,	$08,	nEb3,	$10
	dc.b		nEb2,	$10
;	Alter Volume	value
	smpsAlterVol	$EB
	dc.b		nEb2,	$10,	nEb2,	$08,	nCs2,	$04,	nEb2,	$10
	dc.b		nRst,	$14
;	Alter Volume	value
	smpsAlterVol	$15
	dc.b		nEb2,	$08,	nEb3,	$10,	nEb2,	$08,	nEb3,	$10
	dc.b		nEb2,	$10
;	Alter Volume	value
	smpsAlterVol	$EB
	dc.b		nEb2,	$10,	nEb2,	$08,	nCs2,	$04,	nEb2,	$10
	dc.b		nRst,	$14
;	Alter Volume	value
	smpsAlterVol	$15
	dc.b		nEb2,	$08,	nEb3,	$10,	nEb2,	$08,	nEb3,	$10
	dc.b		nEb2,	$10
;	Alter Volume	value
	smpsAlterVol	$EB
	dc.b		nEb2,	$10,	nEb2,	$08,	nCs2,	$04,	nEb2,	$10
	dc.b		nRst,	$14
;	Alter Volume	value
	smpsAlterVol	$15
	dc.b		nEb2,	$08,	nEb3,	$10,	nEb2,	$08,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$EB
	dc.b		nBb2,	$04,	nCs3,	$04,	nEb3,	$04,	nCs3,	$04
	dc.b		nC3,	$04,	nAb2,	$04,	nF2,	$04
MMX_Sigma_Fortress1_Jump02:
	dc.b		nEb2,	$10,	nEb2,	$08,	nCs2,	$04,	nEb2,	$10
	dc.b		nRst,	$1C,	nBb1,	$04,	nCs2,	$04,	nEb2,	$04
	dc.b		nFs2,	$04,	nEb2,	$04,	nCs2,	$04,	nAb2,	$08
	dc.b		nAb3,	$08,	nBb2,	$08,	nBb3,	$08,	nEb2,	$10
	dc.b		nEb2,	$08,	nCs2,	$04,	nEb2,	$10,	nRst,	$1C
	dc.b		nBb1,	$04,	nCs2,	$04,	nEb2,	$04,	nFs2,	$04
	dc.b		nEb2,	$04,	nCs2,	$04,	nAb2,	$08,	nAb3,	$08
	dc.b		nBb2,	$08,	nBb3,	$08,	nEb2,	$10,	nEb2,	$08
	dc.b		nCs2,	$04,	nEb2,	$10,	nRst,	$1C,	nBb1,	$04
	dc.b		nCs2,	$04,	nEb2,	$04,	nFs2,	$04,	nEb2,	$04
	dc.b		nCs2,	$04,	nAb2,	$08,	nAb3,	$08,	nBb2,	$08
	dc.b		nBb3,	$08,	nEb2,	$10,	nEb2,	$08,	nCs2,	$04
	dc.b		nEb2,	$10,	nRst,	$14,	nAb2,	$08,	nAb2,	$10
	dc.b		nRst,	$04,	nCs2,	$1F,	nRst,	$05,	nEb2,	$10
	dc.b		nEb2,	$08,	nCs2,	$04,	nEb2,	$10,	nRst,	$14
;	Alter Volume	value
	smpsAlterVol	$15
	dc.b		nEb2,	$08,	nEb3,	$10,	nEb2,	$08,	nEb3,	$10
	dc.b		nEb2,	$10
;	Alter Volume	value
	smpsAlterVol	$EB
	dc.b		nEb2,	$10,	nEb2,	$08,	nCs2,	$04,	nEb2,	$10
	dc.b		nRst,	$14
;	Alter Volume	value
	smpsAlterVol	$15
	dc.b		nEb2,	$08,	nEb3,	$10,	nEb2,	$08,	nEb3,	$10
	dc.b		nEb2,	$10
;	Alter Volume	value
	smpsAlterVol	$EB
	dc.b		nEb2,	$10,	nEb2,	$08,	nCs2,	$04,	nEb2,	$10
	dc.b		nRst,	$14
;	Alter Volume	value
	smpsAlterVol	$15
	dc.b		nEb2,	$08,	nEb3,	$10,	nEb2,	$08,	nEb3,	$10
	dc.b		nEb2,	$10
;	Alter Volume	value
	smpsAlterVol	$EB
	dc.b		nEb2,	$10,	nEb2,	$08,	nCs2,	$04,	nEb2,	$10
	dc.b		nRst,	$14
;	Alter Volume	value
	smpsAlterVol	$15
	dc.b		nEb2,	$08,	nEb3,	$10,	nEb2,	$08,	nEb3,	$10
	dc.b		nEb2,	$10
;	Alter Volume	value
	smpsAlterVol	$EB
	dc.b		nEb2,	$10,	nEb2,	$08,	nCs2,	$04,	nEb2,	$10
	dc.b		nRst,	$14
;	Alter Volume	value
	smpsAlterVol	$15
	dc.b		nEb2,	$08,	nEb3,	$10,	nEb2,	$08,	nRst,	$04
;	Alter Volume	value
	smpsAlterVol	$EB
	dc.b		nBb2,	$04,	nCs3,	$04,	nEb3,	$04,	nCs3,	$04
	dc.b		nC3,	$04,	nAb2,	$04,	nF2,	$04,	nEb2,	$10
	dc.b		nEb2,	$08,	nCs2,	$04,	nEb2,	$10,	nRst,	$1C
	dc.b		nBb1,	$04,	nCs2,	$04,	nEb2,	$04,	nFs2,	$04
	dc.b		nEb2,	$04,	nCs2,	$04,	nAb2,	$08,	nAb3,	$08
	dc.b		nBb2,	$08,	nBb3,	$08,	nEb2,	$10,	nEb2,	$08
	dc.b		nCs2,	$04,	nEb2,	$10,	nRst,	$1C,	nBb1,	$04
	dc.b		nCs2,	$04,	nEb2,	$04,	nFs2,	$04,	nEb2,	$04
	dc.b		nCs2,	$04,	nAb2,	$08,	nAb3,	$08,	nBb2,	$08
	dc.b		nBb3,	$08,	nEb2,	$10,	nEb2,	$08,	nCs2,	$04
	dc.b		nEb2,	$10,	nRst,	$1C,	nBb1,	$04,	nCs2,	$04
	dc.b		nEb2,	$04,	nFs2,	$04,	nEb2,	$04,	nCs2,	$04
	dc.b		nAb2,	$08,	nFs2,	$08,	nF2,	$08,	nCs2,	$08
	dc.b		nAb2,	$10,	nAb2,	$08,	nBb2,	$04,	nAb2,	$10
	dc.b		nRst,	$14,	nFs2,	$10,	nFs2,	$08,	nAb2,	$04
	dc.b		nFs2,	$10,	nRst,	$14,	nF2,	$10,	nFs2,	$08
	dc.b		nF2,	$04,	nCs2,	$10,	nRst,	$1C,	nBb1,	$04
	dc.b		nCs2,	$04,	nEb2,	$04,	nFs2,	$04,	nEb2,	$04
	dc.b		nCs2,	$04,	nAb2,	$08,	nAb3,	$08,	nBb2,	$08
	dc.b		nBb3,	$08,	nAb2,	$10,	nAb2,	$08,	nBb2,	$04
	dc.b		nAb2,	$10,	nRst,	$14,	nFs2,	$10,	nFs2,	$08
	dc.b		nAb2,	$04,	nFs2,	$10,	nRst,	$14,	nB2,	$08
	dc.b		nB2,	$08,	nB2,	$08,	nAb2,	$08,	nF2,	$08
	dc.b		nB1,	$08,	nF2,	$08,	nAb2,	$08,	nRst,	$24
	dc.b		nBb2,	$04,	nCs3,	$04,	nEb3,	$04,	nCs3,	$04
	dc.b		nC3,	$04,	nAb2,	$04,	nF2,	$04
;	Jump To	 	location
	smpsJump	MMX_Sigma_Fortress1_Jump02

; FM2 Data
MMX_Sigma_Fortress1_FM2:
	dc.b		smpsModOff,	smpsModOff,	smpsModOff
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		smpsModOff,	smpsModOff
;	Set FM Voice	#
	smpsFMvoice	$02
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nBb2,	$10
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$05,	$04
	dc.b		smpsNoAttack,	$70,	smpsModOff,	nAb2,	$10,	smpsModOn,	smpsNoAttack,	$70
	dc.b		smpsModOff,	nFs2,	$10,	smpsModOn,	smpsNoAttack,	$70,	smpsModOff,	nAb2
	dc.b		$10,	smpsModOn,	smpsNoAttack,	$70
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		smpsModOff
MMX_Sigma_Fortress1_Jump03:
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nBb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$0D
	dc.b		nBb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$F3
	dc.b		nAb4,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$05,	$04
	dc.b		smpsNoAttack,	$3C,	smpsModOff
;	Alter Volume	value
	smpsAlterVol	$0D
	dc.b		nAb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$F3
	dc.b		nCs4,	$04,	nCs4,	$04,	nFs4,	$0C
;	Alter Volume	value
	smpsAlterVol	$0D
	dc.b		nFs4,	$0C
;	Alter Volume	value
	smpsAlterVol	$F3
	dc.b		nAb4,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$06,	$04
	dc.b		smpsNoAttack,	$3C,	smpsModOff
;	Alter Volume	value
	smpsAlterVol	$0D
	dc.b		nAb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$F3
	dc.b		nCs4,	$04,	nCs4,	$04,	nBb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$0D
	dc.b		nBb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$F3
	dc.b		nAb4,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$05,	$04
	dc.b		smpsNoAttack,	$3C,	smpsModOff
;	Alter Volume	value
	smpsAlterVol	$0D
	dc.b		nAb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$F3
	dc.b		nCs4,	$04,	nCs4,	$04,	nFs4,	$0C
;	Alter Volume	value
	smpsAlterVol	$0D
	dc.b		nFs4,	$0C
;	Alter Volume	value
	smpsAlterVol	$F3
	dc.b		nF4,	$18,	smpsModOn,	smpsNoAttack,	$3C,	smpsModOff
;	Alter Volume	value
	smpsAlterVol	$0D
	dc.b		nF4,	$0C,	nRst,	$08
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
;	Alter Volume	value
	smpsAlterVol	$F3
	dc.b		nBb2,	$10,	smpsModOn,	smpsNoAttack,	$70,	smpsModOff,	nAb2,	$10
	dc.b		smpsModOn,	smpsNoAttack,	$70,	smpsModOff,	nFs2,	$10,	smpsModOn,	smpsNoAttack
	dc.b		$70,	smpsModOff,	nAb2,	$10,	smpsModOn,	smpsNoAttack,	$70,	smpsModOff
	dc.b		nBb2,	$10,	smpsModOn,	smpsNoAttack,	$70,	smpsModOff,	nAb2,	$10
	dc.b		smpsModOn,	smpsNoAttack,	$70,	smpsModOff,	nFs2,	$10,	smpsModOn,	smpsNoAttack
	dc.b		$70,	smpsModOff,	nAb2,	$10,	smpsModOn,	smpsNoAttack,	$70,	smpsModOff
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb2,	$10,	smpsModOn,	smpsNoAttack,	$30,	smpsModOff,	nFs2,	$10
	dc.b		smpsModOn,	smpsNoAttack,	$30,	smpsModOff,	nF2,	$10,	smpsModOn,	smpsNoAttack
	dc.b		$30,	smpsModOff,	nEb2,	$10,	smpsModOn,	smpsNoAttack,	$30,	smpsModOff
	dc.b		nAb2,	$10,	smpsModOn,	smpsNoAttack,	$30,	smpsModOff,	nFs2,	$10
	dc.b		smpsModOn,	smpsNoAttack,	$30,	smpsModOff,	nFs3,	$10,	smpsModOn,	smpsNoAttack
	dc.b		$30,	smpsModOff,	nF3,	$10,	smpsModOn,	smpsNoAttack,	$30
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		smpsModOff
;	Alter Volume	value
	smpsAlterVol	$05
;	Jump To	 	location
	smpsJump	MMX_Sigma_Fortress1_Jump03

; FM3 Data
MMX_Sigma_Fortress1_FM3:
	dc.b		smpsModOff,	smpsModOff,	smpsModOff
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		smpsModOff
;	Set FM Voice	#
	smpsFMvoice	$02
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		smpsModOff,	nEb2,	$10
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$05,	$04
	dc.b		smpsNoAttack,	$70,	smpsModOff,	nCs2,	$10,	smpsModOn,	smpsNoAttack,	$70
	dc.b		smpsModOff,	nB1,	$10,	smpsModOn,	smpsNoAttack,	$70,	smpsModOff,	nCs2
	dc.b		$10,	smpsModOn,	smpsNoAttack,	$70
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		smpsModOff
MMX_Sigma_Fortress1_Jump04:
;	Alter Volume	value
	smpsAlterVol	$FD
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$0E
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$F2
	dc.b		nCs4,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$05,	$04
	dc.b		smpsNoAttack,	$3C,	smpsModOff
;	Alter Volume	value
	smpsAlterVol	$0E
	dc.b		nCs4,	$0C
;	Alter Volume	value
	smpsAlterVol	$F2
	dc.b		nCs4,	$04,	nCs4,	$04,	nB3,	$0C
;	Alter Volume	value
	smpsAlterVol	$0E
	dc.b		nB3,	$0C
;	Alter Volume	value
	smpsAlterVol	$F2
	dc.b		nCs4,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$06,	$04
	dc.b		smpsNoAttack,	$3C,	smpsModOff
;	Alter Volume	value
	smpsAlterVol	$0E
	dc.b		nCs4,	$0C
;	Alter Volume	value
	smpsAlterVol	$F2
	dc.b		nCs4,	$04,	nCs4,	$04,	nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$0E
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$F2
	dc.b		nCs4,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$05,	$04
	dc.b		smpsNoAttack,	$3C,	smpsModOff
;	Alter Volume	value
	smpsAlterVol	$0E
	dc.b		nCs4,	$0C
;	Alter Volume	value
	smpsAlterVol	$F2
	dc.b		nCs4,	$04,	nCs4,	$04,	nB3,	$0C
;	Alter Volume	value
	smpsAlterVol	$0E
	dc.b		nB3,	$0C
;	Alter Volume	value
	smpsAlterVol	$F2
	dc.b		nAb3,	$18,	smpsModOn,	smpsNoAttack,	$3C,	smpsModOff
;	Alter Volume	value
	smpsAlterVol	$0E
	dc.b		nAb3,	$0C,	nRst,	$08
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
;	Alter Volume	value
	smpsAlterVol	$F2
	dc.b		nEb2,	$10,	smpsModOn,	smpsNoAttack,	$70,	smpsModOff,	nCs2,	$10
	dc.b		smpsModOn,	smpsNoAttack,	$70,	smpsModOff,	nB1,	$10,	smpsModOn,	smpsNoAttack
	dc.b		$70,	smpsModOff,	nCs2,	$10,	smpsModOn,	smpsNoAttack,	$70,	smpsModOff
	dc.b		nEb2,	$10,	smpsModOn,	smpsNoAttack,	$70,	smpsModOff,	nCs2,	$10
	dc.b		smpsModOn,	smpsNoAttack,	$70,	smpsModOff,	nB1,	$10,	smpsModOn,	smpsNoAttack
	dc.b		$70,	smpsModOff,	nCs2,	$10,	smpsModOn,	smpsNoAttack,	$70,	smpsModOff
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb2,	$10,	smpsModOn,	smpsNoAttack,	$30,	smpsModOff,	nCs2,	$10
	dc.b		smpsModOn,	smpsNoAttack,	$30,	smpsModOff,	nC2,	$10,	smpsModOn,	smpsNoAttack
	dc.b		$30,	smpsModOff,	nBb1,	$10,	smpsModOn,	smpsNoAttack,	$30,	smpsModOff
	dc.b		nEb2,	$10,	smpsModOn,	smpsNoAttack,	$30,	smpsModOff,	nCs2,	$10
	dc.b		smpsModOn,	smpsNoAttack,	$30,	smpsModOff,	nB2,	$10,	smpsModOn,	smpsNoAttack
	dc.b		$30,	smpsModOff,	nBb2,	$10,	smpsModOn,	smpsNoAttack,	$30
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		smpsModOff
;	Alter Volume	value
	smpsAlterVol	$04
;	Jump To	 	location
	smpsJump	MMX_Sigma_Fortress1_Jump04

; FM4 Data
MMX_Sigma_Fortress1_FM4:
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$05,	$04
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$05,	$04
;	Alter Notes	value
	smpsAlterNote	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$05,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb2,	$7F,	smpsNoAttack,	$01,	nEb2,	$7F,	smpsNoAttack,	$01
	dc.b		nEb2,	$7F,	smpsNoAttack,	$01,	nEb2,	$7F,	smpsNoAttack,	$01
;	Set FM Voice	#
	smpsFMvoice	$03
MMX_Sigma_Fortress1_Jump05:
;	Alter Volume	value
	smpsAlterVol	$FA
	dc.b		nBb2,	$08,	nEb2,	$03,	nRst,	$05,	nEb2,	$03
	dc.b		nRst,	$05,	nBb2,	$08,	nEb2,	$03,	nRst,	$05
	dc.b		nEb2,	$03,	nRst,	$05,	nBb2,	$08,	nEb2,	$03
	dc.b		nRst,	$05,	nEb2,	$03,	nRst,	$05,	nBb2,	$08
	dc.b		nEb2,	$03,	nRst,	$05,	nEb2,	$03,	nRst,	$05
	dc.b		nAb2,	$08,	nAb2,	$01,	nRst,	$07,	nBb2,	$08
	dc.b		nBb2,	$01,	nRst,	$07,	nEb2,	$03,	nRst,	$05
	dc.b		nBb2,	$08,	nEb2,	$03,	nRst,	$05,	nCs3,	$08
	dc.b		nBb2,	$08,	nEb2,	$03,	nRst,	$05,	nEb2,	$03
	dc.b		nRst,	$05,	nBb2,	$08,	nEb2,	$03,	nRst,	$05
	dc.b		nBb2,	$08,	nEb2,	$03,	nRst,	$05,	nEb2,	$03
	dc.b		nRst,	$05,	nEb3,	$08,	nAb2,	$01,	nRst,	$07
	dc.b		nF3,	$08,	nBb2,	$01,	nRst,	$07,	nBb2,	$08
	dc.b		nEb2,	$03,	nRst,	$05,	nEb2,	$03,	nRst,	$05
	dc.b		nBb2,	$08,	nEb2,	$03,	nRst,	$05,	nEb2,	$03
	dc.b		nRst,	$05,	nBb2,	$08,	nEb2,	$03,	nRst,	$05
	dc.b		nEb2,	$03,	nRst,	$05,	nBb2,	$08,	nEb2,	$03
	dc.b		nRst,	$05,	nEb2,	$03,	nRst,	$05,	nEb3,	$08
	dc.b		nAb2,	$01,	nRst,	$07,	nF3,	$08,	nBb2,	$01
	dc.b		nRst,	$07,	nEb2,	$03,	nRst,	$05,	nBb2,	$08
	dc.b		nEb2,	$03,	nRst,	$05,	nCs3,	$08,	nBb2,	$08
	dc.b		nEb2,	$03,	nRst,	$05,	nEb2,	$03,	nRst,	$05
	dc.b		nEb2,	$03,	nRst,	$05,	nEb3,	$1C,	nAb2,	$24
;	Set FM Voice	#
	smpsFMvoice	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$07,	$04
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Volume	value
	smpsAlterVol	$67
	dc.b		nEb2,	$02
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$F0
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$F6
	dc.b		nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FA
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FB
	dc.b		nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FD
	dc.b		nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FD
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FD
	dc.b		nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nBb2,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb2,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb2,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb2,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nBb2,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01,	nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb2,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nBb2,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb2,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nBb2,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nBb2,	$01,	smpsNoAttack,	$01,	nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nBb2,	$01,	smpsNoAttack,	$01,	nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nBb2,	$01,	smpsNoAttack,	$01,	nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01,	nBb2,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb2,	$01,	smpsNoAttack,	$01,	nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01,	nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb2,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nBb2,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb2,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01,	nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$05
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$07
	dc.b		nEb2,	$01
;	Alter Volume	value
	smpsAlterVol	$09
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$10
	dc.b		nBb2,	$01
;	Alter Volume	value
	smpsAlterVol	$10
	dc.b		smpsNoAttack,	$01
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$06
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$F0
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$F7
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$F9
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FA
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FD
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01,	nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01,	nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nAb3,	$01,	smpsNoAttack,	$01,	nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nAb3,	$01,	smpsNoAttack,	$01,	nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nAb3,	$01,	smpsNoAttack,	$01,	nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01,	nAb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb3,	$01,	smpsNoAttack,	$01,	nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01,	nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nAb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01,	nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$05
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$05
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$0C
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$19
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$06
	dc.b		smpsNoAttack,	$01
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$F0
	dc.b		nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$F7
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FA
	dc.b		nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$FA
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FD
	dc.b		nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$FD
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nFs3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nB2,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nFs3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nB2,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nFs3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nFs3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nFs3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01,	nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nB2,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nFs3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nB2,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01,	nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01,	nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01,	nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01,	nFs3,	$01,	smpsNoAttack,	$01,	nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nFs3,	$01,	smpsNoAttack,	$01,	nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01,	nFs3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB2,	$01,	smpsNoAttack,	$01,	nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB2,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nFs3,	$01,	smpsNoAttack,	$01,	nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB2,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nFs3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB2,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01,	nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01,	nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$05
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$06
	dc.b		nB2,	$01
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$0C
	dc.b		nFs3,	$01
;	Alter Volume	value
	smpsAlterVol	$19
	dc.b		smpsNoAttack,	$01
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$06
;	Alter Volume	value
	smpsAlterVol	$F6
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$F4
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FA
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FD
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FD
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FD
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01,	nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01,	nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nEb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nAb3,	$01,	smpsNoAttack,	$01,	nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nAb3,	$01,	smpsNoAttack,	$01,	nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nAb3,	$01,	smpsNoAttack,	$01,	nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nAb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb3,	$01,	smpsNoAttack,	$01,	nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nAb3,	$01,	smpsNoAttack,	$01,	nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01,	nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01,	nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01,	nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01,	nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01,	nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nAb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nAb3,	$01,	smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$FF
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		nEb3,	$01
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nAb3,	$01
;	Alter Volume	value
	smpsAlterVol	$06
	dc.b		smpsNoAttack,	$01
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		nEb3,	$02
;	Alter Volume	value
	smpsAlterVol	$16
	dc.b		nAb3,	$02,	smpsModOff
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$07
;	Alter Volume	value
	smpsAlterVol	$AF
	dc.b		nBb0,	$20
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$05,	$04
	dc.b		smpsNoAttack,	$40
;	Alter Volume	value
	smpsAlterVol	$12
	dc.b		nBb0,	$08,	smpsModOff
;	Alter Volume	value
	smpsAlterVol	$EE
	dc.b		nBb0,	$0D,	nCs1,	$0B,	nEb1,	$10,	nAb0,	$10
	dc.b		smpsModOn,	smpsNoAttack,	$48
;	Alter Volume	value
	smpsAlterVol	$12
	dc.b		nAb0,	$08
;	Alter Volume	value
	smpsAlterVol	$EE
	dc.b		nFs0,	$05,	smpsModOff,	smpsNoAttack,	$03,	nAb0,	$08,	nBb0
	dc.b		$0B,	nCs1,	$0D,	nEb1,	$08,	smpsModOn,	smpsNoAttack,	$50
;	Alter Volume	value
	smpsAlterVol	$12
	dc.b		nEb1,	$05,	smpsModOff,	smpsNoAttack,	$03
;	Alter Volume	value
	smpsAlterVol	$EE
	dc.b		nFs1,	$04,	nF1,	$04,	nEb1,	$18
;	Alter Volume	value
	smpsAlterVol	$12
	dc.b		nEb1,	$08,	smpsModOn
;	Alter Volume	value
	smpsAlterVol	$EE
	dc.b		nF1,	$18
;	Alter Volume	value
	smpsAlterVol	$12
	dc.b		nF1,	$08,	smpsModOff
;	Alter Volume	value
	smpsAlterVol	$EE
	dc.b		nB0,	$18
;	Alter Volume	value
	smpsAlterVol	$12
	dc.b		nB0,	$08,	smpsModOn
;	Alter Volume	value
	smpsAlterVol	$EE
	dc.b		nAb1,	$18
;	Alter Volume	value
	smpsAlterVol	$07
	dc.b		nAb1,	$08,	smpsModOff
;	Alter Volume	value
	smpsAlterVol	$06
	dc.b		nAb1,	$08
;	Alter Volume	value
	smpsAlterVol	$0F
	dc.b		nAb1,	$08
;	Alter Volume	value
	smpsAlterVol	$E4
	dc.b		nAb1,	$08,	nFs1,	$08,	nF1,	$08,	nFs1,	$08
;	Alter Volume	value
	smpsAlterVol	$0D
	dc.b		nFs1,	$08
;	Alter Volume	value
	smpsAlterVol	$F3
	dc.b		nF1,	$08
;	Alter Volume	value
	smpsAlterVol	$0D
	dc.b		nF1,	$08
;	Alter Volume	value
	smpsAlterVol	$F3
	dc.b		nCs1,	$08,	nEb1,	$10,	smpsModOn,	smpsNoAttack,	$18,	smpsModOff
	dc.b		nFs1,	$04,	nAb1,	$04,	nF1,	$08
;	Alter Volume	value
	smpsAlterVol	$0D
	dc.b		nF1,	$08
;	Alter Volume	value
	smpsAlterVol	$F3
	dc.b		nCs1,	$0C
;	Alter Volume	value
	smpsAlterVol	$06
	dc.b		nCs1,	$0C
;	Alter Volume	value
	smpsAlterVol	$07
	dc.b		nCs1,	$08
;	Alter Volume	value
	smpsAlterVol	$F3
	dc.b		nFs1,	$05,	nF1,	$06,	nCs1,	$05,	nEb1,	$40
	dc.b		nRst,	$08,	nB0,	$08,	nCs1,	$08,	nEb1,	$08
	dc.b		nFs1,	$08,	nF1,	$08,	nCs1,	$08,	nAb1,	$08
;	Alter Volume	value
	smpsAlterVol	$0D
	dc.b		nAb1,	$08
;	Alter Volume	value
	smpsAlterVol	$F3
	dc.b		nFs1,	$04
;	Alter Volume	value
	smpsAlterVol	$0D
	dc.b		nFs1,	$04
;	Alter Volume	value
	smpsAlterVol	$F3
	dc.b		nFs1,	$30,	nB1,	$08
;	Alter Volume	value
	smpsAlterVol	$0D
	dc.b		nB1,	$08
;	Alter Volume	value
	smpsAlterVol	$F3
	dc.b		nAb1,	$08
;	Alter Volume	value
	smpsAlterVol	$0D
	dc.b		nAb1,	$08
;	Alter Volume	value
	smpsAlterVol	$F3
	dc.b		nFs1,	$04
;	Alter Volume	value
	smpsAlterVol	$0D
	dc.b		nFs1,	$04
;	Alter Volume	value
	smpsAlterVol	$F3
	dc.b		nF1,	$08
;	Alter Volume	value
	smpsAlterVol	$0D
	dc.b		nF1,	$08
;	Alter Volume	value
	smpsAlterVol	$F3
	dc.b		nBb1,	$18,	smpsModOn,	smpsNoAttack,	$30
;	Set FM Voice	#
	smpsFMvoice	$03
;	Alter Volume	value
	smpsAlterVol	$0A
;	Jump To	 	location
	smpsJump	MMX_Sigma_Fortress1_Jump05

; FM5 Data
MMX_Sigma_Fortress1_FM5:
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$01,	$04
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$01,	$04
;	Alter Notes	value
	smpsAlterNote	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$01,	$04
;	Set FM Voice	#
	smpsFMvoice	$05
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb4,	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		smpsNoAttack,	$0C
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$01,	$04
	dc.b		smpsNoAttack,	$30
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nEb5,	$04,	nFs5,	$04,	nBb5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$05
	dc.b		nEb5,	$04,	nFs5,	$04,	nBb5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$04,	nFs5,	$04,	nBb5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$0F
	dc.b		nEb5,	$04,	nFs5,	$04,	nBb5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Volume	value
	smpsAlterVol	$13
	dc.b		nEb5,	$04,	nFs5,	$04,	nBb5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nRst,	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Volume	value
	smpsAlterVol	$DD
	dc.b		nAb4,	$40
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nCs5,	$04,	nF5,	$04,	nAb5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$05
	dc.b		nCs5,	$04,	nF5,	$04,	nAb5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nCs5,	$04,	nF5,	$04,	nAb5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$0F
	dc.b		nCs5,	$04,	nF5,	$04,	nAb5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Volume	value
	smpsAlterVol	$13
	dc.b		nCs5,	$04,	nF5,	$04,	nAb5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nRst,	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Volume	value
	smpsAlterVol	$DD
	dc.b		nFs4,	$40
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nB4,	$04,	nEb5,	$04,	nFs5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$05
	dc.b		nB4,	$04,	nEb5,	$04,	nFs5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nB4,	$04,	nEb5,	$04,	nFs5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$0F
	dc.b		nB4,	$04,	nEb5,	$04,	nFs5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Volume	value
	smpsAlterVol	$13
	dc.b		nB4,	$04,	nEb5,	$04,	nFs5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nRst,	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Volume	value
	smpsAlterVol	$DD
	dc.b		nAb4,	$40
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nCs5,	$04,	nF5,	$04,	nAb5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$05
	dc.b		nCs5,	$04,	nF5,	$04,	nAb5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nCs5,	$04,	nF5,	$04,	nAb5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$0F
	dc.b		nCs5,	$04,	nF5,	$04,	nAb5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Volume	value
	smpsAlterVol	$13
	dc.b		nCs5,	$04,	nF5,	$04,	nAb5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nRst,	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$04
MMX_Sigma_Fortress1_Jump06:
;	Alter Volume	value
	smpsAlterVol	$D7
	dc.b		nEb2,	$08,	nEb2,	$01,	nRst,	$07,	nEb2,	$01
	dc.b		nRst,	$07,	nEb2,	$08,	nEb2,	$01,	nRst,	$07
	dc.b		nEb2,	$01,	nRst,	$07,	nEb2,	$08,	nEb2,	$01
	dc.b		nRst,	$07,	nEb2,	$01,	nRst,	$07,	nEb2,	$08
	dc.b		nEb2,	$01,	nRst,	$07,	nEb2,	$01,	nRst,	$07
	dc.b		nAb2,	$08,	nAb2,	$01,	nRst,	$07,	nBb2,	$08
	dc.b		nBb2,	$01,	nRst,	$07,	nEb2,	$01,	nRst,	$07
	dc.b		nEb2,	$08,	nEb2,	$01,	nRst,	$07,	nFs2,	$08
	dc.b		nEb2,	$08,	nEb2,	$01,	nRst,	$07,	nEb2,	$01
	dc.b		nRst,	$07,	nEb2,	$08,	nEb2,	$01,	nRst,	$07
	dc.b		nEb2,	$08,	nEb2,	$01,	nRst,	$07,	nEb2,	$01
	dc.b		nRst,	$07,	nAb2,	$08,	nAb2,	$01,	nRst,	$07
	dc.b		nBb2,	$08,	nBb2,	$01,	nRst,	$07,	nEb2,	$08
	dc.b		nEb2,	$01,	nRst,	$07,	nEb2,	$01,	nRst,	$07
	dc.b		nEb2,	$08,	nEb2,	$01,	nRst,	$07,	nEb2,	$01
	dc.b		nRst,	$07,	nEb2,	$08,	nEb2,	$01,	nRst,	$07
	dc.b		nEb2,	$01,	nRst,	$07,	nEb2,	$08,	nEb2,	$01
	dc.b		nRst,	$07,	nEb2,	$01,	nRst,	$07,	nAb2,	$08
	dc.b		nAb2,	$01,	nRst,	$07,	nBb2,	$08,	nBb2,	$01
	dc.b		nRst,	$07,	nEb2,	$01,	nRst,	$07,	nEb2,	$08
	dc.b		nEb2,	$01,	nRst,	$07,	nFs2,	$08,	nEb2,	$08
	dc.b		nEb2,	$01,	nRst,	$07,	nEb2,	$01,	nRst,	$07
	dc.b		nEb2,	$01,	nRst,	$07,	nAb2,	$1C,	nCs2,	$24
;	Set FM Voice	#
	smpsFMvoice	$01
;	Alter Volume	value
	smpsAlterVol	$06
	dc.b		nEb2,	$7F,	smpsNoAttack,	$01,	nEb2,	$7F,	smpsNoAttack,	$01
	dc.b		nEb2,	$7F,	smpsNoAttack,	$01,	nEb2,	$7F,	smpsNoAttack,	$01
;	Set FM Voice	#
	smpsFMvoice	$04
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nEb2,	$08
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nEb2,	$02,	nRst,	$06,	nEb2,	$02,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nEb2,	$08
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nEb2,	$02,	nRst,	$06,	nEb2,	$02,	nRst,	$06
	dc.b		nEb2,	$02,	nRst,	$06,	nEb2,	$02,	nRst,	$06
	dc.b		nEb2,	$02,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nEb2,	$08
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nEb2,	$02,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nCs2,	$08,	nEb2,	$08
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nEb2,	$02,	nRst,	$06,	nEb2,	$02,	nRst,	$06
	dc.b		nEb2,	$02,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nEb2,	$08
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nEb2,	$02,	nRst,	$06,	nEb2,	$02,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nEb2,	$08
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nEb2,	$02,	nRst,	$06,	nEb2,	$02,	nRst,	$06
	dc.b		nEb2,	$02,	nRst,	$06,	nEb2,	$02,	nRst,	$06
	dc.b		nEb2,	$02,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nEb2,	$08
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nEb2,	$02,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nCs2,	$08,	nEb2,	$08
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nEb2,	$02,	nRst,	$06,	nEb2,	$02,	nRst,	$06
	dc.b		nEb2,	$02,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nEb2,	$08
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nEb2,	$02,	nRst,	$06,	nEb2,	$02,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nEb2,	$08
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nEb2,	$02,	nRst,	$06,	nEb2,	$02,	nRst,	$06
	dc.b		nEb2,	$02,	nRst,	$06,	nEb2,	$02,	nRst,	$06
	dc.b		nEb2,	$02,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nEb2,	$08
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nEb2,	$02,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nCs2,	$08,	nEb2,	$08
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nEb2,	$02,	nRst,	$06,	nEb2,	$02,	nRst,	$06
	dc.b		nEb2,	$02,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nEb2,	$08
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nEb2,	$02,	nRst,	$06,	nEb2,	$02,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nEb2,	$08
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nEb2,	$02,	nRst,	$06,	nEb2,	$02,	nRst,	$06
	dc.b		nEb2,	$02,	nRst,	$06,	nEb2,	$02,	nRst,	$06
	dc.b		nEb2,	$02,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nEb2,	$08
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nEb2,	$02,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nCs2,	$08,	nEb2,	$08
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nEb2,	$02,	nRst,	$06,	nEb2,	$02,	nRst,	$06
	dc.b		nEb2,	$02,	nRst,	$06
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		smpsModOff,	nAb2,	$40,	nFs2,	$20
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$05,	$04
	dc.b		smpsNoAttack,	$18,	smpsModOff,	smpsNoAttack,	$08,	nF2,	$40,	nEb2
	dc.b		$10,	smpsModOn,	smpsNoAttack,	$30,	smpsModOff,	nAb2,	$40,	nFs2
	dc.b		$10,	smpsModOn,	smpsNoAttack,	$30,	smpsModOff,	nB2,	$40,	nBb2
	dc.b		$10,	smpsModOn,	smpsNoAttack,	$30
;	Set FM Voice	#
	smpsFMvoice	$04
;	Alter Volume	value
	smpsAlterVol	$23
;	Jump To	 	location
	smpsJump	MMX_Sigma_Fortress1_Jump06

; PSG1 Data
MMX_Sigma_Fortress1_PSG1:
	dc.b		smpsModOff,	smpsModOff,	smpsModOff
;	Alter Notes	value
	smpsAlterNote	$00
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		smpsModOff,	smpsModOff,	nRst,	$40,	nEb2,	$04,	nFs2,	$04
	dc.b		nBb2,	$04
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nEb2,	$04,	nFs2,	$04,	nBb2,	$04
;	Set Volume	value
	smpsSetVol	$01
	dc.b		nEb2,	$04,	nFs2,	$04,	nBb2,	$04
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nEb2,	$04,	nFs2,	$04,	nBb2,	$04
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nEb2,	$04,	nFs2,	$04,	nBb2,	$04,	nRst,	$04
	dc.b		nRst,	$40
;	Set Volume	value
	smpsSetVol	$F5
	dc.b		nCs2,	$04,	nF2,	$04,	nAb2,	$04
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nCs2,	$04,	nF2,	$04,	nAb2,	$04
;	Set Volume	value
	smpsSetVol	$01
	dc.b		nCs2,	$04,	nF2,	$04,	nAb2,	$04
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nCs2,	$04,	nF2,	$04,	nAb2,	$04
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nCs2,	$04,	nF2,	$04,	nAb2,	$04,	nRst,	$04
	dc.b		nRst,	$40
;	Set Volume	value
	smpsSetVol	$F5
	dc.b		nB1,	$04,	nEb2,	$04,	nFs2,	$04
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nB1,	$04,	nEb2,	$04,	nFs2,	$04
;	Set Volume	value
	smpsSetVol	$01
	dc.b		nB1,	$04,	nEb2,	$04,	nFs2,	$04
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nB1,	$04,	nEb2,	$04,	nFs2,	$04
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nB1,	$04,	nEb2,	$04,	nFs2,	$04,	nRst,	$04
	dc.b		nRst,	$40
;	Set Volume	value
	smpsSetVol	$F5
	dc.b		nCs2,	$04,	nF2,	$04,	nAb2,	$04
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nCs2,	$04,	nF2,	$04,	nAb2,	$04
;	Set Volume	value
	smpsSetVol	$01
	dc.b		nCs2,	$04,	nF2,	$04,	nAb2,	$04
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nCs2,	$04,	nF2,	$04,	nAb2,	$04
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nCs2,	$04,	nF2,	$04,	nAb2,	$04,	nRst,	$04
;	Alter Notes	value
	smpsAlterNote	$00
MMX_Sigma_Fortress1_Jump07:
;	Set Volume	value
	smpsSetVol	$F7
	dc.b		nBb1,	$0C
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nBb1,	$0C
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nAb1,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$02,	$03,	$02
	dc.b		smpsNoAttack,	$3C,	smpsModOff
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nAb1,	$0C
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs1,	$04,	nCs1,	$04,	nFs1,	$0C
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nFs1,	$0C
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nAb1,	$18,	smpsModOn,	smpsNoAttack,	$3C,	smpsModOff
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nAb1,	$0C
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs1,	$04,	nCs1,	$04,	nBb1,	$0C
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nBb1,	$0C
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nAb1,	$18,	smpsModOn,	smpsNoAttack,	$3C,	smpsModOff
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nAb1,	$0C
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs1,	$04,	nCs1,	$04,	nFs1,	$0C
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nFs1,	$0C
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nF1,	$18,	smpsModOn,	smpsNoAttack,	$3C,	smpsModOff
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nF1,	$0C,	nRst,	$14
;	Alter Notes	value
	smpsAlterNote	$01
;	Set Volume	value
	smpsSetVol	$FF
	dc.b		nBb1,	$20,	smpsModOn,	smpsNoAttack,	$40
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nBb1,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nBb1,	$0C,	nCs2,	$0C,	nEb2,	$10,	nAb1,	$10
	dc.b		smpsModOn,	smpsNoAttack,	$4D
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nAb1,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nFs1,	$06,	nF1,	$05,	nFs1,	$20,	smpsModOn,	smpsNoAttack
	dc.b		$4D
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nFs1,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nAb1,	$06,	nBb1,	$05,	nAb1,	$20,	smpsModOn,	smpsNoAttack
	dc.b		$18
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nAb1,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nCs1,	$20,	smpsModOn,	smpsNoAttack,	$18
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nCs1,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nBb1,	$20,	smpsModOn,	smpsNoAttack,	$40
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nBb1,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nBb1,	$0D,	nCs2,	$0B,	nEb2,	$10,	nAb1,	$20
	dc.b		smpsModOn,	smpsNoAttack,	$38
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nAb1,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nFs1,	$08,	nAb1,	$08,	nBb1,	$0B,	nCs2,	$0D
	dc.b		nEb2,	$18,	smpsModOn,	smpsNoAttack,	$40
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nEb2,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nFs2,	$04,	nF2,	$04,	nEb2,	$10,	smpsModOn,	smpsNoAttack
	dc.b		$08
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nEb2,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nF2,	$10,	smpsModOn,	smpsNoAttack,	$08
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nF2,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nB1,	$10,	smpsModOn,	smpsNoAttack,	$08
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nB1,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nAb2,	$10,	smpsModOn,	smpsNoAttack,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nAb2,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nAb2,	$08
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nAb2,	$08
;	Set Volume	value
	smpsSetVol	$F9
	dc.b		nAb2,	$08,	nFs2,	$08,	nF2,	$08,	nFs2,	$08
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nFs2,	$08
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nF2,	$08
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nF2,	$08
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nCs2,	$08,	nEb2,	$10,	smpsModOn,	smpsNoAttack,	$18,	smpsModOff
	dc.b		nFs2,	$04,	nAb2,	$04,	nF2,	$08
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nF2,	$08
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nCs2,	$0C
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nCs2,	$0C
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nCs2,	$08
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nFs2,	$05,	nF2,	$06,	nCs2,	$05,	nEb2,	$10
	dc.b		smpsModOn,	smpsNoAttack,	$30,	smpsModOff,	nRst,	$08,	nB1,	$08
	dc.b		nCs2,	$08,	nEb2,	$08,	nFs2,	$08,	nF2,	$08
	dc.b		nCs2,	$08,	nAb2,	$08
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nAb2,	$08
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nFs2,	$04
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nFs2,	$04,	smpsModOn
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nFs2,	$30,	smpsModOff,	nB2,	$08
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nB2,	$08
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nAb2,	$08
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nAb2,	$08
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nFs2,	$04
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nFs2,	$04
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nF2,	$08
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nF2,	$08
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nBb2,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$02,	$02,	$02
	dc.b		smpsNoAttack,	$24
;	Alter Notes	value
	smpsAlterNote	$00
;	Set Volume	value
	smpsSetVol	$06
;	Jump To	 	location
	smpsJump	MMX_Sigma_Fortress1_Jump07

; PSG2 Data
MMX_Sigma_Fortress1_PSG2:
	dc.b		smpsModOff,	smpsModOff
;	Alter Notes	value
	smpsAlterNote	$00
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		smpsModOff,	nRst,	$70,	nF2,	$05
;	Set Volume	value
	smpsSetVol	$07
	dc.b		nF2,	$06
;	Set Volume	value
	smpsSetVol	$F9
	dc.b		nCs2,	$08
;	Set Volume	value
	smpsSetVol	$07
	dc.b		nCs2,	$08
;	Set Volume	value
	smpsSetVol	$F9
	dc.b		nAb1,	$15
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$02,	$03,	$02
	dc.b		smpsNoAttack,	$58,	smpsModOff,	nFs1,	$05,	nAb1,	$06,	nBb1
	dc.b		$1D,	smpsModOn,	smpsNoAttack,	$5B,	smpsModOff,	nAb1,	$05,	nFs1
	dc.b		$05,	nF1,	$1B,	smpsModOn,	smpsNoAttack,	$48,	smpsModOff,	nFs1
	dc.b		$08,	nF1,	$10
MMX_Sigma_Fortress1_Jump08:
;	Set Volume	value
	smpsSetVol	$FF
	dc.b		nEb1,	$0C
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nEb1,	$0C
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs1,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$02,	$03,	$02
	dc.b		smpsNoAttack,	$3C,	smpsModOff
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nCs1,	$0C
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs1,	$04,	nCs1,	$04,	nB0,	$0C
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nB0,	$0C
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs1,	$18,	smpsModOn,	smpsNoAttack,	$3C,	smpsModOff
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nCs1,	$0C
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs1,	$04,	nCs1,	$04,	nEb1,	$0C
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nEb1,	$0C
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs1,	$18,	smpsModOn,	smpsNoAttack,	$3C,	smpsModOff
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nCs1,	$0C
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs1,	$04,	nCs1,	$04,	nB0,	$0C
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nB0,	$0C
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nAb0,	$18,	smpsModOn,	smpsNoAttack,	$3C,	smpsModOff
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nAb0,	$0C,	nRst,	$08
;	Set Volume	value
	smpsSetVol	$F9
	dc.b		nBb1,	$20,	smpsModOn,	smpsNoAttack,	$40
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nBb1,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nBb1,	$0C,	nCs2,	$0C,	nEb2,	$10,	nAb1,	$10
	dc.b		smpsModOn,	smpsNoAttack,	$4D
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nAb1,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nFs1,	$06,	nF1,	$05,	nFs1,	$20,	smpsModOn,	smpsNoAttack
	dc.b		$4D
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nFs1,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nAb1,	$06,	nBb1,	$05,	nAb1,	$20,	smpsModOn,	smpsNoAttack
	dc.b		$18
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nAb1,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nCs1,	$20,	smpsModOn,	smpsNoAttack,	$18
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nCs1,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nBb1,	$20,	smpsModOn,	smpsNoAttack,	$40
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nBb1,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nBb1,	$0D,	nCs2,	$0B,	nEb2,	$10,	nAb1,	$20
	dc.b		smpsModOn,	smpsNoAttack,	$38
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nAb1,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nFs1,	$08,	nAb1,	$08,	nBb1,	$0B,	nCs2,	$0D
	dc.b		nEb2,	$18,	smpsModOn,	smpsNoAttack,	$40
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nEb2,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nFs2,	$04,	nF2,	$04,	nEb2,	$10,	smpsModOn,	smpsNoAttack
	dc.b		$08
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nEb2,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nF2,	$10,	smpsModOn,	smpsNoAttack,	$08
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nF2,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nB1,	$10,	smpsModOn,	smpsNoAttack,	$08
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nB1,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nAb2,	$10,	smpsModOn,	smpsNoAttack,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nAb2,	$08,	smpsModOff
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nAb2,	$08
;	Set Volume	value
	smpsSetVol	$06
	dc.b		nAb2,	$08
;	Set Volume	value
	smpsSetVol	$F5
	dc.b		nAb2,	$08,	nFs2,	$08,	nF2,	$08,	nFs2,	$08
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nFs2,	$08
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nF2,	$08
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nF2,	$08
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nCs2,	$08,	nEb2,	$10,	smpsModOn,	smpsNoAttack,	$18,	smpsModOff
	dc.b		nFs2,	$04,	nAb2,	$04,	nF2,	$08
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nF2,	$08
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nCs2,	$0C
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nCs2,	$0C
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nCs2,	$08
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nFs2,	$05,	nF2,	$06,	nCs2,	$05,	nEb2,	$10
	dc.b		smpsModOn,	smpsNoAttack,	$30,	smpsModOff,	nRst,	$08,	nB1,	$08
	dc.b		nCs2,	$08,	nEb2,	$08,	nFs2,	$08,	nF2,	$08
	dc.b		nCs2,	$08,	nAb2,	$08
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nAb2,	$08
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nFs2,	$04
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nFs2,	$04,	smpsModOn
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nFs2,	$30,	smpsModOff,	nB2,	$08
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nB2,	$08
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nAb2,	$08
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nAb2,	$08
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nFs2,	$04
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nFs2,	$04
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nF2,	$08
;	Set Volume	value
	smpsSetVol	$05
	dc.b		nF2,	$08
;	Set Volume	value
	smpsSetVol	$FB
	dc.b		nBb2,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$02,	$02,	$02
	dc.b		smpsNoAttack,	$30
;	Set Volume	value
	smpsSetVol	$04
;	Jump To	 	location
	smpsJump	MMX_Sigma_Fortress1_Jump08

; PSG3 Data
MMX_Sigma_Fortress1_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
;	Alter Notes	value
	smpsAlterNote	$00
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
MMX_Sigma_Fortress1_Jump09:
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$44
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$06
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FA
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Set Volume	value
	smpsSetVol	$FD
	dc.b		nA5,	$08
;	Set Volume	value
	smpsSetVol	$03
	dc.b		nA5,	$04,	nA5,	$04
;	Jump To	 	location
	smpsJump	MMX_Sigma_Fortress1_Jump09

MMX_Sigma_Fortress1_Voices:
;	Voice 00
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

;	Voice 01
;	$38,$60,$73,$30,$00,$1F,$1E,$1C,$1F,$16,$10,$10,$04,$00,$00,$00,$00,$55,$39,$06,$07,$13,$13,$13,$00
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$03,	$07,	$06
	smpsVcCoarseFreq	$00,	$00,	$03,	$00
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1C,	$1E,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$04,	$10,	$10,	$16
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$00,	$03,	$05
	smpsVcReleaseRate	$07,	$06,	$09,	$05
	smpsVcTotalLevel	$00,	$13,	$13,	$13

;	Voice 02
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

;	Voice 03
;	$38,$53,$51,$51,$51,$DF,$DF,$1F,$1F,$07,$0E,$07,$04,$04,$03,$03,$08,$F7,$33,$74,$67,$1B,$11,$10,$00
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$05,	$05,	$05,	$05
	smpsVcCoarseFreq	$01,	$01,	$01,	$03
	smpsVcRateScale		$00,	$00,	$03,	$03
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$04,	$07,	$0E,	$07
	smpsVcDecayRate2	$08,	$03,	$03,	$04
	smpsVcDecayLevel	$06,	$07,	$03,	$0F
	smpsVcReleaseRate	$07,	$04,	$03,	$07
	smpsVcTotalLevel	$00,	$10,	$11,	$1B

;	Voice 04
;	$28,$33,$53,$70,$30,$DF,$DC,$1F,$1F,$14,$05,$01,$01,$00,$01,$00,$1D,$11,$21,$10,$F9,$0E,$1B,$12,$00
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$07,	$05,	$03
	smpsVcCoarseFreq	$00,	$00,	$03,	$03
	smpsVcRateScale		$00,	$00,	$03,	$03
	smpsVcAttackRate	$1F,	$1F,	$1C,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$01,	$01,	$05,	$14
	smpsVcDecayRate2	$1D,	$00,	$01,	$00
	smpsVcDecayLevel	$0F,	$01,	$02,	$01
	smpsVcReleaseRate	$09,	$00,	$01,	$01
	smpsVcTotalLevel	$00,	$12,	$1B,	$0E

;	Voice 05
;	$3C,$71,$72,$3F,$34,$8D,$52,$9F,$1F,$09,$00,$00,$0D,$00,$00,$00,$00,$23,$08,$02,$F7,$15,$00,$1D,$07
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$07,	$07
	smpsVcCoarseFreq	$04,	$0F,	$02,	$01
	smpsVcRateScale		$00,	$02,	$01,	$02
	smpsVcAttackRate	$1F,	$1F,	$12,	$0D
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0D,	$00,	$00,	$09
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$0F,	$00,	$00,	$02
	smpsVcReleaseRate	$07,	$02,	$08,	$03
	smpsVcTotalLevel	$07,	$1D,	$00,	$15

;	Voice 06
;	$29,$33,$02,$02,$01,$1F,$1F,$1F,$19,$00,$02,$00,$0B,$03,$02,$00,$03,$00,$11,$00,$16,$1A,$1D,$20,$00
;				#
	smpsVcAlgorithm		$01
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$03
	smpsVcCoarseFreq	$01,	$02,	$02,	$03
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$19,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0B,	$00,	$02,	$00
	smpsVcDecayRate2	$03,	$00,	$02,	$03
	smpsVcDecayLevel	$01,	$00,	$01,	$00
	smpsVcReleaseRate	$06,	$00,	$01,	$00
	smpsVcTotalLevel	$00,	$20,	$1D,	$1A

;	Voice 07
;	$3A,$38,$78,$08,$08,$54,$52,$58,$54,$08,$08,$05,$04,$02,$04,$04,$03,$27,$17,$24,$25,$1B,$18,$22,$00
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$07,	$03
	smpsVcCoarseFreq	$08,	$08,	$08,	$08
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$14,	$18,	$12,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$04,	$05,	$08,	$08
	smpsVcDecayRate2	$03,	$04,	$04,	$02
	smpsVcDecayLevel	$02,	$02,	$01,	$02
	smpsVcReleaseRate	$05,	$04,	$07,	$07
	smpsVcTotalLevel	$00,	$22,	$18,	$1B
	even
