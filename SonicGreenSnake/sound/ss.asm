; =============================================================================================
; Project Name:		ss
; Created:		6th May 2015
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

ss_Header:
;	Voice Pointer	location
	smpsHeaderVoice	ss_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$02,	$00

;	DAC Pointer	location
	smpsHeaderDAC	ss_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	ss_FM1,	smpsPitch00,	$12
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	ss_FM2,	smpsPitch00,	$0E
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	ss_FM3,	smpsPitch00,	$12
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	ss_FM4,	smpsPitch00,	$11
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	ss_FM5,	smpsPitch00,	$0F
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	ss_PSG1,	smpsPitch00,	$07,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	ss_PSG2,	smpsPitch00,	$07,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	ss_PSG3,	smpsPitch00,	$04,	$01

; DAC Data
ss_DAC:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nRst,	$24,	dKick,	$0C,	dKick,	$54,	dKick,	$0C
	dc.b		dKick,	$54,	dKick,	$0C,	dKick,	$54,	dKick,	$0C
	dc.b		dKick,	$54,	dKick,	$0C,	dKick,	$54,	dKick,	$0C
	dc.b		dKick,	$54,	dKick,	$0C,	dKick,	$54,	dKick,	$0C
	dc.b		dKick,	$6E,	nRst,	$6E,	nRst,	$6E,	nRst,	$6E
	dc.b		nRst,	$6E,	nRst,	$6E,	dKick,	$0C,	dKick,	$24
	dc.b		dKick,	$0C,	dKick,	$24,	dKick,	$0C,	dKick,	$24
	dc.b		dKick,	$3C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	smpsStop

; FM1 Data
ss_FM1:
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Notes	value
	smpsAlterNote	$04
;	Set FM Voice	#
	smpsFMvoice	$02
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$02,	$04
	dc.b		smpsModOn,	smpsModOn,	nRst,	$05
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Alter Volume	value
	smpsAlterVol	$F9
	dc.b		nA3,	$09,	smpsModOn,	smpsNoAttack,	$1B,	smpsModOff,	nB3,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$03,	smpsModOff,	nC4,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$03,	smpsModOff,	nD4,	$09,	smpsModOn,	smpsNoAttack,	$03,	smpsModOff
	dc.b		nE4,	$08,	nF4,	$08,	nB4,	$08,	nA4,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$0F,	smpsModOff,	nG4,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$0F,	smpsModOff,	nE4,	$09,	smpsModOn,	smpsNoAttack,	$0F,	smpsModOff
	dc.b		nC4,	$09,	smpsModOn,	smpsNoAttack,	$0F,	smpsModOff,	nE4,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$1B,	smpsModOff,	nC4,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$03,	smpsModOff,	nA3,	$09,	smpsModOn,	smpsNoAttack,	$7F,	smpsNoAttack
	dc.b		$08,	smpsModOff,	nEb4,	$09,	smpsModOn,	smpsNoAttack,	$03,	smpsModOff
	dc.b		nBb4,	$09,	smpsModOn,	smpsNoAttack,	$0F,	smpsModOff,	nAb4,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$03,	smpsModOff,	nG4,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$7F,	smpsNoAttack,	$7F,	smpsNoAttack,	$44,	nRst,	$30
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Notes	value
	smpsAlterNote	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		smpsModOn,	smpsModOn,	smpsModOn
	smpsStop

; FM2 Data
ss_FM2:
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$06,	nAb6,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA6,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE6,	$0C,	nRst,	$4E
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Volume	value
	smpsAlterVol	$06
	dc.b		nE7,	$03,	nD7,	$03,	nC7,	$03,	nB6,	$03
	dc.b		nA6,	$03,	nG6,	$03,	nF6,	$03,	nE6,	$03
	dc.b		nD6,	$03,	nC6,	$03,	nB5,	$03,	nA5,	$03
	dc.b		nG5,	$03,	nF5,	$03,	nE5,	$03,	nF5,	$03
	dc.b		nE5,	$03,	nF5,	$03,	nE5,	$03,	nF5,	$03
	dc.b		nE5,	$03,	nF5,	$03,	nE5,	$03,	nF5,	$03
	dc.b		nE5,	$03,	nF5,	$03,	nE5,	$03,	nF5,	$03
	dc.b		nE5,	$03,	nF5,	$03,	nE5,	$30,	nRst,	$06
	dc.b		nG7,	$03,	nF7,	$03,	nE7,	$03,	nD7,	$03
	dc.b		nC7,	$03,	nB6,	$03,	nA6,	$03,	nG6,	$03
	dc.b		nF6,	$03,	nE6,	$03,	nD6,	$03,	nC6,	$03
	dc.b		nB5,	$03,	nA5,	$03,	nG5,	$03,	nA5,	$03
	dc.b		nG5,	$03,	nA5,	$03,	nG5,	$03,	nA5,	$03
	dc.b		nG5,	$03,	nA5,	$03,	nG5,	$03,	nA5,	$03
	dc.b		nG5,	$03,	nA5,	$03,	nG5,	$03,	nA5,	$03
	dc.b		nG5,	$03,	nA5,	$03,	nG5,	$30,	nRst,	$1E
	dc.b		nBb7,	$03,	nAb7,	$03,	nG7,	$03,	nF7,	$03
	dc.b		nEb7,	$03,	nD7,	$03,	nC7,	$03,	nBb6,	$03
	dc.b		nAb6,	$03,	nG6,	$03,	nF6,	$03,	nEb6,	$03
	dc.b		nD6,	$03,	nC6,	$03,	nBb5,	$03,	nAb5,	$03
	dc.b		nG5,	$03,	nF5,	$03,	nEb5,	$03,	nD5,	$03
	dc.b		nC5,	$03,	nBb4,	$03,	nAb4,	$03,	nBb4,	$03
	dc.b		nAb4,	$03,	nBb4,	$03,	nAb4,	$03,	nBb4,	$03
	dc.b		nAb4,	$03,	nBb4,	$03,	nAb4,	$03,	nBb4,	$03
	dc.b		nAb4,	$03,	nBb4,	$03,	nAb4,	$03,	nBb4,	$03
	dc.b		nAb4,	$03,	nBb4,	$03,	nAb4,	$18,	nBb4,	$18
	dc.b		nB6,	$03,	nC7,	$03,	nE7,	$03,	nG7,	$03
	dc.b		nBb7,	$03,	nG7,	$03,	nE7,	$03,	nC7,	$03
	dc.b		nB6,	$03,	nG6,	$03,	nE6,	$03,	nC6,	$03
	dc.b		nB5,	$03,	nG5,	$03,	nE5,	$03,	nC5,	$03
	dc.b		nB5,	$03,	nC6,	$03,	nE6,	$03,	nG6,	$03
	dc.b		nB6,	$03,	nG6,	$03,	nE6,	$03,	nC6,	$03
	dc.b		nB5,	$03,	nG5,	$03,	nE5,	$03,	nC5,	$03
	dc.b		nB4,	$03,	nG4,	$03,	nE4,	$03,	nC4,	$03
	dc.b		nB3,	$03,	nC4,	$03
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB3,	$03,	nC4,	$03
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB3,	$03,	nC4,	$03
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB3,	$03,	nC4,	$03
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nB3,	$03,	nC4,	$03
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB3,	$03,	nC4,	$03
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB3,	$03,	nC4,	$03
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB3,	$03,	nC4,	$03
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nB3,	$03,	nC4,	$03
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB3,	$03,	nC4,	$03
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nB3,	$03,	nC4,	$03
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nB3,	$03,	nC4,	$03
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nB3,	$03,	nC4,	$03
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nB3,	$03,	nC4,	$03
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nB3,	$03,	nC4,	$03
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nB3,	$03,	nC4,	$03,	nRst,	$30
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	smpsStop

; FM3 Data
ss_FM3:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$02,	$04
	dc.b		smpsModOn,	smpsModOn,	nRst,	$0D
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nF3,	$09,	smpsModOn,	smpsNoAttack,	$1B,	smpsModOff,	nG3,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$03,	smpsModOff,	nAb3,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$03,	smpsModOff,	nBb3,	$09,	smpsModOn,	smpsNoAttack,	$03,	smpsModOff
	dc.b		nB3,	$08,	nC4,	$08,	nAb4,	$08,	nE4,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$57,	smpsModOff,	nF4,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$03,	smpsModOff,	nE4,	$09,	smpsModOn,	smpsNoAttack,	$03,	smpsModOff
	dc.b		nAb3,	$09,	smpsModOn,	smpsNoAttack,	$27,	smpsModOff,	nG3,	$08
	dc.b		nCs4,	$08,	nC4,	$08,	nE3,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$4A,	nRst,	$03,	smpsModOff
;	Set FM Voice	#
	smpsFMvoice	$01
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nF4,	$09,	smpsModOn,	smpsNoAttack,	$1B,	smpsModOff,	nG4,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$03,	smpsModOff,	nAb4,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$03,	smpsModOff,	nBb4,	$09,	smpsModOn,	smpsNoAttack,	$03,	smpsModOff
	dc.b		nB4,	$08,	nC5,	$08,	nAb5,	$08,	nE5,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$57,	smpsModOff,	nF5,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$03,	smpsModOff,	nE5,	$09,	smpsModOn,	smpsNoAttack,	$03,	smpsModOff
	dc.b		nAb4,	$09,	smpsModOn,	smpsNoAttack,	$27,	smpsModOff,	nG4,	$08
	dc.b		nCs5,	$08,	nC5,	$08,	nE4,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$54,	smpsModOff
;	Set FM Voice	#
	smpsFMvoice	$00
;	Alter Volume	value
	smpsAlterVol	$FD
	dc.b		nF5,	$09,	smpsModOn,	smpsNoAttack,	$1B,	smpsModOff,	nC5,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$03,	smpsModOff,	nF5,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$03,	smpsModOff,	nG5,	$09,	smpsModOn,	smpsNoAttack,	$03,	smpsModOff
	dc.b		nA5,	$09,	smpsModOn,	smpsNoAttack,	$03,	smpsModOff,	nG5,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$03,	smpsModOff,	nF5,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$33,	smpsModOff,	nG5,	$09,	smpsModOn,	smpsNoAttack,	$03,	smpsModOff
	dc.b		nA5,	$09,	smpsModOn,	smpsNoAttack,	$03,	smpsModOff,	nF5,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$03,	smpsModOff,	nD5,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$3F,	smpsModOff
;	Set FM Voice	#
	smpsFMvoice	$04
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nG5,	$09,	smpsModOn,	smpsNoAttack,	$03,	smpsModOff,	nF5,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$03,	smpsModOff,	nE5,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$0F,	smpsModOff,	nD5,	$09,	smpsModOn,	smpsNoAttack,	$0F,	smpsModOff
	dc.b		nC5,	$09,	smpsModOn,	smpsNoAttack,	$0F,	smpsModOff,	nD5,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$0F,	smpsModOff,	nEb5,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$3F,	smpsModOff,	nC5,	$09,	smpsModOn,	smpsNoAttack,	$03,	smpsModOff
	dc.b		nG5,	$09,	smpsModOn,	smpsNoAttack,	$0F,	smpsModOff,	nF5,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$03,	smpsModOff,	nEb5,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$03,	smpsModOff,	nD5,	$09,	smpsModOn,	smpsNoAttack,	$03,	smpsModOff
	dc.b		nC5,	$09,	smpsModOn,	smpsNoAttack,	$0F,	smpsModOff,	nD5,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$0F,	smpsModOff,	nE5,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$7F,	smpsNoAttack,	$38,	nRst,	$30
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		smpsModOn,	smpsModOn,	smpsModOn
	smpsStop

; FM4 Data
ss_FM4:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Notes	value
	smpsAlterNote	$02
;	Set FM Voice	#
	smpsFMvoice	$01
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$02,	$04
	dc.b		smpsModOn,	smpsModOn,	nRst,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nF3,	$08,	smpsModOn,	smpsNoAttack,	$1B,	nRst,	$01,	smpsModOff
	dc.b		nG3,	$08,	smpsModOn,	smpsNoAttack,	$03,	nRst,	$01,	smpsModOff
	dc.b		nAb3,	$08,	smpsModOn,	smpsNoAttack,	$03,	nRst,	$01,	smpsModOff
	dc.b		nBb3,	$08,	smpsModOn,	smpsNoAttack,	$03,	nRst,	$01,	smpsModOff
	dc.b		nB3,	$07,	nRst,	$01,	nC4,	$07,	nRst,	$01
	dc.b		nAb4,	$07,	nRst,	$01,	nE4,	$08,	smpsModOn,	smpsNoAttack
	dc.b		$57,	nRst,	$01,	smpsModOff,	nF4,	$08,	smpsModOn,	smpsNoAttack
	dc.b		$03,	nRst,	$01,	smpsModOff,	nE4,	$08,	smpsModOn,	smpsNoAttack
	dc.b		$03,	nRst,	$01,	smpsModOff,	nAb3,	$08,	smpsModOn,	smpsNoAttack
	dc.b		$27,	nRst,	$01,	smpsModOff,	nG3,	$07,	nRst,	$01
	dc.b		nCs4,	$07,	nRst,	$01,	nC4,	$07,	nRst,	$01
	dc.b		nE3,	$08,	smpsModOn,	smpsNoAttack,	$52,	smpsModOff
;	Set FM Voice	#
	smpsFMvoice	$01
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nF4,	$09,	smpsModOn,	smpsNoAttack,	$1B,	smpsModOff,	nG4,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$03,	smpsModOff,	nAb4,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$03,	smpsModOff,	nBb4,	$09,	smpsModOn,	smpsNoAttack,	$03,	smpsModOff
	dc.b		nB4,	$08,	nC5,	$08,	nAb5,	$08,	nE5,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$57,	smpsModOff,	nF5,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$03,	smpsModOff,	nE5,	$09,	smpsModOn,	smpsNoAttack,	$03,	smpsModOff
	dc.b		nAb4,	$09,	smpsModOn,	smpsNoAttack,	$27,	smpsModOff,	nG4,	$08
	dc.b		nCs5,	$08,	nC5,	$08,	nE4,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$57,	smpsModOff
;	Set FM Voice	#
	smpsFMvoice	$00
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nA4,	$24,	nB4,	$0C,	nC5,	$0C,	nD5,	$0C
	dc.b		nE5,	$08,	nF5,	$08,	nB5,	$08,	nA5,	$18
	dc.b		nG5,	$18,	nE5,	$18,	nC5,	$18,	nE5,	$24
	dc.b		nC5,	$0C,	nA4,	$7F,	smpsNoAttack,	$11,	nEb5,	$0C
	dc.b		nBb5,	$18,	nAb5,	$0C,	nG5,	$7F,	smpsNoAttack,	$7F
	dc.b		smpsNoAttack,	$52,	nRst,	$30
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Notes	value
	smpsAlterNote	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		smpsModOff,	smpsModOff,	smpsModOff
	smpsStop

; FM5 Data
ss_FM5:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$02,	$04
	dc.b		smpsModOn,	smpsModOn,	nF3,	$09,	smpsModOn,	smpsNoAttack,	$1B,	smpsModOff
	dc.b		nG3,	$09,	smpsModOn,	smpsNoAttack,	$03,	smpsModOff,	nAb3,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$03,	smpsModOff,	nBb3,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$03,	smpsModOff,	nB3,	$08,	nC4,	$08,	nAb4,	$08
	dc.b		nE4,	$09,	smpsModOn,	smpsNoAttack,	$57,	smpsModOff,	nF4,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$03,	smpsModOff,	nE4,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$03,	smpsModOff,	nAb3,	$09,	smpsModOn,	smpsNoAttack,	$27,	smpsModOff
	dc.b		nG3,	$08,	nCs4,	$08,	nC4,	$08,	nE3,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$57,	smpsModOff,	nF2,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$1B,	smpsModOff,	nE2,	$09,	smpsModOn,	smpsNoAttack,	$03,	smpsModOff
	dc.b		nF2,	$09,	smpsModOn,	smpsNoAttack,	$03,	smpsModOff,	nG2,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$03,	smpsModOff,	nAb2,	$08,	nBb2,	$08
	dc.b		nB2,	$08,	nC3,	$09,	smpsModOn,	smpsNoAttack,	$57,	smpsModOff
	dc.b		nCs3,	$09,	smpsModOn,	smpsNoAttack,	$03,	smpsModOff,	nC3,	$09
	dc.b		smpsModOn,	smpsNoAttack,	$03,	smpsModOff,	nE3,	$09,	smpsModOn,	smpsNoAttack
	dc.b		$27,	smpsModOff,	nEb3,	$08,	nA3,	$08,	nAb3,	$08
	dc.b		nC3,	$09,	smpsModOn,	smpsNoAttack,	$57,	smpsModOff
;	Set FM Voice	#
	smpsFMvoice	$03
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nF3,	$0C,	nRst,	$0C,	nC3,	$0C,	nRst,	$0C
	dc.b		nF3,	$0C,	nRst,	$0C,	nC3,	$0C,	nRst,	$0C
	dc.b		nF3,	$0C,	nRst,	$0C,	nC3,	$0C,	nRst,	$0C
	dc.b		nF3,	$0C,	nRst,	$0C,	nC3,	$0C,	nRst,	$0C
	dc.b		nD3,	$0C,	nRst,	$0C,	nA2,	$0C,	nRst,	$0C
	dc.b		nD3,	$0C,	nRst,	$0C,	nA2,	$0C,	nRst,	$0C
	dc.b		nD3,	$0C,	nRst,	$0C,	nA2,	$0C,	nRst,	$0C
	dc.b		nD3,	$0C,	nRst,	$0C,	nA2,	$0C,	nRst,	$0C
	dc.b		nF3,	$0C,	nRst,	$0C,	nC3,	$0C,	nRst,	$0C
	dc.b		nF3,	$0C,	nRst,	$0C,	nC3,	$0C,	nRst,	$0C
	dc.b		nF3,	$0C,	nRst,	$0C,	nC3,	$0C,	nRst,	$0C
	dc.b		nF3,	$0C,	nRst,	$0C,	nC3,	$0C,	nRst,	$0C
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nC4,	$54,	nG4,	$06,	nD4,	$06,	nE4,	$0C
	dc.b		nB3,	$06,	nG3,	$06,	nA3,	$0C,	nG3,	$06
	dc.b		nD3,	$06,	nE3,	$30,	nRst,	$30
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		smpsModOff,	smpsModOff,	smpsModOff
	smpsStop

; PSG1 Data
ss_PSG1:
	dc.b		nRst,	$60
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nE2,	$03,	smpsNoAttack,	nD2,	$03,	nE2,	$03,	smpsNoAttack
	dc.b		nD2,	$03,	nE2,	$03,	smpsNoAttack,	nD2,	$03,	nE2
	dc.b		$03,	smpsNoAttack,	nD2,	$03,	nE2,	$03,	smpsNoAttack,	nD2
	dc.b		$03,	nE2,	$03,	smpsNoAttack,	nD2,	$03,	nE2,	$03
	dc.b		smpsNoAttack,	nD2,	$03,	nE2,	$03,	smpsNoAttack,	nD2,	$03
	dc.b		nE2,	$03,	smpsNoAttack,	nD2,	$03,	nE2,	$03,	smpsNoAttack
	dc.b		nD2,	$03,	nE2,	$03,	smpsNoAttack,	nD2,	$03,	nE2
	dc.b		$03,	smpsNoAttack,	nD2,	$03,	nE2,	$03,	smpsNoAttack,	nD2
	dc.b		$03,	nE2,	$03,	smpsNoAttack,	nD2,	$03,	nE2,	$03
	dc.b		smpsNoAttack,	nD2,	$03,	nE2,	$03,	smpsNoAttack,	nD2,	$03
	dc.b		nE2,	$03,	smpsNoAttack,	nD2,	$03,	nE2,	$03,	smpsNoAttack
	dc.b		nD2,	$03,	nE2,	$03,	smpsNoAttack,	nD2,	$03,	nE2
	dc.b		$03,	smpsNoAttack,	nD2,	$03,	nE2,	$03,	smpsNoAttack,	nD2
	dc.b		$03,	nE2,	$03,	smpsNoAttack,	nD2,	$03,	nE2,	$03
	dc.b		smpsNoAttack,	nD2,	$03,	nE2,	$03,	smpsNoAttack,	nD2,	$03
	dc.b		nE2,	$03,	smpsNoAttack,	nD2,	$03,	nE2,	$03,	smpsNoAttack
	dc.b		nD2,	$03,	nE2,	$03,	smpsNoAttack,	nD2,	$03,	nE2
	dc.b		$03,	smpsNoAttack,	nD2,	$03,	nE2,	$03,	smpsNoAttack,	nD2
	dc.b		$03,	nE2,	$03,	smpsNoAttack,	nD2,	$03,	nE2,	$03
	dc.b		smpsNoAttack,	nD2,	$03,	nE2,	$03,	smpsNoAttack,	nD2,	$03
	dc.b		nE2,	$03,	smpsNoAttack,	nD2,	$03,	nE2,	$03,	smpsNoAttack
	dc.b		nD2,	$03,	nE2,	$03,	smpsNoAttack,	nD2,	$03,	nE2
	dc.b		$03,	smpsNoAttack,	nD2,	$03,	nE2,	$03,	smpsNoAttack,	nD2
	dc.b		$03,	nE2,	$03,	smpsNoAttack,	nD2,	$03,	nE2,	$03
	dc.b		smpsNoAttack,	nD2,	$03,	nE2,	$03,	smpsNoAttack,	nD2,	$03
	dc.b		nE2,	$03,	smpsNoAttack,	nD2,	$03,	nE2,	$03,	smpsNoAttack
	dc.b		nD2,	$03,	nE2,	$03,	smpsNoAttack,	nD2,	$03,	nE2
	dc.b		$03,	smpsNoAttack,	nD2,	$03,	nE2,	$03,	smpsNoAttack,	nD2
	dc.b		$03,	nE2,	$03,	smpsNoAttack,	nD2,	$03,	nE2,	$03
	dc.b		smpsNoAttack,	nD2,	$03,	nE2,	$03,	smpsNoAttack,	nD2,	$03
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nAb1,	$03
;	Alter Notes	value
	smpsAlterNote	$F9
	dc.b		smpsNoAttack,	$03
;	Alter Notes	value
	smpsAlterNote	$00
;	Set Volume	value
	smpsSetVol	$FE
	dc.b		nA0,	$0C,	nE0,	$0C,	nA0,	$0C,	nE0,	$0C
	dc.b		nA0,	$0C,	nE0,	$0C,	nA0,	$0C,	nE0,	$0C
	dc.b		nA0,	$0C,	nE0,	$0C,	nA0,	$0C,	nE0,	$0C
	dc.b		nA0,	$0C,	nE0,	$0C,	nA0,	$0C,	nE0,	$0C
	dc.b		nA0,	$0C,	nF0,	$0C,	nA0,	$0C,	nF0,	$0C
	dc.b		nA0,	$0C,	nF0,	$0C,	nA0,	$0C,	nF0,	$0C
	dc.b		nA0,	$0C,	nF0,	$0C,	nA0,	$0C,	nF0,	$0C
	dc.b		nA0,	$0C,	nF0,	$0C,	nA0,	$0C,	nF0,	$0C
	dc.b		nC1,	$0C,	nEb1,	$0C,	nC1,	$0C,	nEb1,	$0C
	dc.b		nC1,	$0C,	nEb1,	$0C,	nC1,	$0C,	nEb1,	$0C
	dc.b		nC1,	$0C,	nEb1,	$0C,	nC1,	$0C,	nEb1,	$0C
	dc.b		nC1,	$0C,	nEb1,	$0C,	nC1,	$0C,	nEb1,	$0C
	dc.b		nRst,	$24
;	Set Volume	value
	smpsSetVol	$01
	dc.b		nB0,	$06,	nG0,	$06,	nA0,	$7F,	smpsNoAttack,	$11
	dc.b		nRst,	$30
;	Set PSG Voice	#
	smpsPSGvoice	$00
	smpsStop

; PSG2 Data
ss_PSG2:
	dc.b		nRst,	$60
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nC2,	$03
;	Alter Notes	value
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nB1,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nF2,	$03
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	nEb2,	$03
;	Alter Notes	value
	smpsAlterNote	$00
;	Set Volume	value
	smpsSetVol	$FE
	dc.b		nF0,	$0C,	nC0,	$0C,	nF0,	$0C,	nC0,	$0C
	dc.b		nF0,	$0C,	nC0,	$0C,	nF0,	$0C,	nC0,	$0C
	dc.b		nF0,	$0C,	nC0,	$0C,	nF0,	$0C,	nC0,	$0C
	dc.b		nF0,	$0C,	nC0,	$0C,	nF0,	$0C,	nC0,	$0C
	dc.b		nD0,	$0C,	nC1,	$0C,	nD0,	$0C,	nC1,	$0C
	dc.b		nD0,	$0C,	nC1,	$0C,	nD0,	$0C,	nC1,	$0C
	dc.b		nD0,	$0C,	nC1,	$0C,	nD0,	$0C,	nC1,	$0C
	dc.b		nD0,	$0C,	nC1,	$0C,	nD0,	$0C,	nC1,	$0C
	dc.b		nAb0,	$0C,	nC1,	$0C,	nAb0,	$0C,	nC1,	$0C
	dc.b		nAb0,	$0C,	nC1,	$0C,	nAb0,	$0C,	nC1,	$0C
	dc.b		nAb0,	$0C,	nC1,	$0C,	nAb0,	$0C,	nC1,	$0C
	dc.b		nAb0,	$0C,	nC1,	$0C,	nAb0,	$0C,	nC1,	$0C
	dc.b		nRst,	$27
;	Set Volume	value
	smpsSetVol	$01
	dc.b		nB0,	$06,	nG0,	$06,	nA0,	$7F,	smpsNoAttack,	$0E
	dc.b		nRst,	$30
;	Set PSG Voice	#
	smpsPSGvoice	$00
	smpsStop

; PSG3 Data
ss_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
	dc.b		nA5,	$60,	nA5,	$60,	nA5,	$60,	nA5,	$60
	dc.b		nA5,	$60,	nA5,	$60,	nA5,	$60,	nA5,	$72
	dc.b		smpsNoAttack,	$72,	smpsNoAttack,	$72,	smpsNoAttack,	$72,	smpsNoAttack,	$72
	dc.b		smpsNoAttack,	$72,	smpsNoAttack,	$72,	smpsNoAttack,	$72
	smpsStop

ss_Voices:
;	Voice 00
;	$04,$01,$00,$00,$00,$1F,$1F,$DD,$1F,$11,$0D,$05,$05,$00,$02,$02,$02,$65,$3A,$15,$1A,$27,$00,$13,$00
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$00,	$00,	$00,	$01
	smpsVcRateScale		$00,	$03,	$00,	$00
	smpsVcAttackRate	$1F,	$1D,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$05,	$0D,	$11
	smpsVcDecayRate2	$02,	$02,	$02,	$00
	smpsVcDecayLevel	$01,	$01,	$03,	$06
	smpsVcReleaseRate	$0A,	$05,	$0A,	$05
	smpsVcTotalLevel	$00,	$13,	$00,	$27

;	Voice 01
;	$3B,$46,$42,$42,$43,$10,$12,$19,$4F,$08,$05,$01,$01,$01,$01,$01,$01,$76,$F1,$F7,$F9,$41,$23,$2B,$00
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$04,	$04,	$04,	$04
	smpsVcCoarseFreq	$03,	$02,	$02,	$06
	smpsVcRateScale		$01,	$00,	$00,	$00
	smpsVcAttackRate	$0F,	$19,	$12,	$10
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$01,	$01,	$05,	$08
	smpsVcDecayRate2	$01,	$01,	$01,	$01
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$07
	smpsVcReleaseRate	$09,	$07,	$01,	$06
	smpsVcTotalLevel	$00,	$2B,	$23,	$41

;	Voice 02
;	$3E,$38,$01,$7A,$34,$59,$D9,$5F,$9C,$0F,$04,$0F,$0A,$02,$02,$05,$05,$AF,$AF,$66,$66,$28,$00,$23,$00
;				#
	smpsVcAlgorithm		$06
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$07,	$00,	$03
	smpsVcCoarseFreq	$04,	$0A,	$01,	$08
	smpsVcRateScale		$02,	$01,	$03,	$01
	smpsVcAttackRate	$1C,	$1F,	$19,	$19
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$0F,	$04,	$0F
	smpsVcDecayRate2	$05,	$05,	$02,	$02
	smpsVcDecayLevel	$06,	$06,	$0A,	$0A
	smpsVcReleaseRate	$06,	$06,	$0F,	$0F
	smpsVcTotalLevel	$00,	$23,	$00,	$28

;	Voice 03
;	$2A,$50,$03,$11,$00,$90,$CE,$CD,$9B,$05,$8A,$09,$08,$00,$00,$12,$0C,$09,$FF,$50,$4A,$18,$27,$25,$00
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$01,	$00,	$05
	smpsVcCoarseFreq	$00,	$01,	$03,	$00
	smpsVcRateScale		$02,	$03,	$03,	$02
	smpsVcAttackRate	$1B,	$0D,	$0E,	$10
	smpsVcAmpMod		$00,	$00,	$04,	$00
	smpsVcDecayRate1	$08,	$09,	$0A,	$05
	smpsVcDecayRate2	$0C,	$12,	$00,	$00
	smpsVcDecayLevel	$04,	$05,	$0F,	$00
	smpsVcReleaseRate	$0A,	$00,	$0F,	$09
	smpsVcTotalLevel	$00,	$25,	$27,	$18

;	Voice 04
;	$28,$38,$35,$30,$31,$1F,$1F,$1F,$1F,$0C,$0A,$07,$0A,$07,$07,$07,$09,$27,$17,$17,$F7,$17,$32,$14,$00
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$03,	$03
	smpsVcCoarseFreq	$01,	$00,	$05,	$08
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$07,	$0A,	$0C
	smpsVcDecayRate2	$09,	$07,	$07,	$07
	smpsVcDecayLevel	$0F,	$01,	$01,	$02
	smpsVcReleaseRate	$07,	$07,	$07,	$07
	smpsVcTotalLevel	$00,	$14,	$32,	$17
	even
