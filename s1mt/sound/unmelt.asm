; =============================================================================================
; Project Name:		unmelt
; Created:		3rd October 2015
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

unmelt_Header:
;	Voice Pointer	location
	smpsHeaderVoice	unmelt_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$02
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$02,	$0E

;	DAC Pointer	location
	smpsHeaderDAC	unmelt_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	unmelt_FM1,	smpsPitch00,	$12
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	unmelt_FM2,	smpsPitch01lo,	$0C
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	unmelt_FM4,	smpsPitch00,	$14
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	unmelt_FM5,	smpsPitch00,	$10
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	unmelt_FM3,	smpsPitch00,	$12
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	unmelt_PSG1,	smpsPitch03lo,	$02,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	unmelt_PSG2,	smpsPitch03lo,	$02,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
;	smpsHeaderPSG	unmelt_PSG3,	smpsPitch00,	$01,	$03

; FM1 Data
unmelt_FM1:
;	Set FM Voice	#
	smpsFMvoice	$0C
	dc.b		nC0,	$01,	nRst,	$07
unmelt_Jump01:
;	Set Modulation	wait	speed	change	step
	smpsModSet	$17,	$01,	$04,	$05
;	Set FM Voice	#
	smpsFMvoice	$02
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nA4,	$0C,	nC5,	$03,	nRst,	$09,	nB4,	nG4
	dc.b		$03,	nRst,	$06,	nA4,	$0C,	nC5,	nE5,	$1E
	dc.b		nA4,	$0C,	nC5,	$03,	nRst,	$09,	nB4,	nG4
	dc.b		$03,	nRst,	$06,	nA4,	$0C,	nG5,	nB5,	$1E
	dc.b		smpsNoAttack,	$30
unmelt_Loop01:
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC6,	$03,	nE5,	nC6,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC6,	$06,	nE5,	$03,	nC6
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nRst,	nC6,	$06,	nE5,	$03
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nB5,	nD5,	nB5,	nRst
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	unmelt_Loop01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
unmelt_Loop02:
	dc.b		nE5,	$09,	nD5,	$03,	nRst,	$06,	nD5,	$0C
	dc.b		nC5,	$03,	nRst,	nC5,	nRst,	nD5,	nRst,	nE5
	dc.b		$09,	nD5,	$03,	nRst,	$06,	nD5,	$0C,	nC5
	dc.b		$03,	nRst,	nC5,	$0C
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	unmelt_Loop02
	dc.b		nA5,	nA5,	$03,	nRst,	$09,	nG5,	nA5,	$03
	dc.b		nRst,	$06,	nE5,	$1E,	nD5,	$09,	nC5,	nD5
	dc.b		$06,	nF5,	$0C,	nF5,	$03,	nRst,	$09,	nE5
	dc.b		nD5,	$03,	nRst,	$06,	nC5,	$1B,	nRst,	$03
	dc.b		nC5,	$09,	nD5,	nE5,	$06,	nA5,	$0C,	nA5
	dc.b		$03,	nRst,	$09,	nG5,	nA5,	$03,	nRst,	$06
	dc.b		nE5,	$1E,	nD5,	$09,	nC5,	nD5,	$06,	nF5
	dc.b		$0C,	nF5,	$03,	nRst,	$09,	nAb5,	nA5,	$03
	dc.b		nRst,	$06,	nB5,	$0C,	nB5,	$03,	nRst,	nE5
	dc.b		nRst,	$09,	nB5,	$03,	nB5,	nRst,	nE5,	$06
	dc.b		nRst,	$09
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nC6,	$06,	nE6,	$03,	nRst,	nD6,	nRst,	nC6
	dc.b		nB5,	$18,	nRst,	$03,	nB5,	$06,	nD6,	$03
	dc.b		nRst,	nC6,	nRst,	nB5,	nA5,	$18,	nRst,	$03
	dc.b		nA5,	$06,	nC6,	$03,	nRst,	nB5,	nRst,	nA5
	dc.b		nB5,	$0F,	nG5,	$0C,	nE5,	$30,	nC6,	$06
	dc.b		nE6,	$03,	nRst,	nD6,	nRst,	nC6,	nB5,	$18
	dc.b		nRst,	$03,	nB5,	$06,	nD6,	$03,	nRst,	nC6
	dc.b		nRst,	nB5,	nA5,	$18,	nRst,	$03,	nA5,	$06
	dc.b		nC6,	$03,	nRst,	nB5,	nRst,	nA5,	nB5,	$0F
	dc.b		nG5,	$0C,	nA5,	$27,	smpsNoAttack,	$30,	nRst,	$02
	dc.b		nB5,	smpsNoAttack,	nC6,	smpsNoAttack,	nCs6,	$01,	smpsNoAttack,	nD6
	dc.b		smpsNoAttack,	nEb6,	smpsNoAttack,	nE6,	$2D,	nRst,	$01,	nF6
	dc.b		smpsNoAttack,	nFs6,	smpsNoAttack,	nG6,	$16,	nFs6,	$01,	smpsNoAttack
	dc.b		nF6,	smpsNoAttack,	nE6,	$12,	nD6,	$02,	nC6,	nB5
	dc.b		$01,	nBb5
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nA4,	$12,	nB4,	nC5,	nD5,	nE5,	$03,	nRst
	dc.b		nE5,	nRst,	nE5,	nG5,	nRst,	nA5,	nRst,	$09
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		nA5,	$03,	nRst,	$09
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		nA5,	$03,	nRst,	$09
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		nA5,	$03,	nRst,	$09,	nRst,	$03
;	Alter Volume	value
	smpsAlterVol	$F7
;	Jump To	 	location
	smpsJump	unmelt_Jump01

; FM2 Data
unmelt_FM2:
;	Set FM Voice	#
	smpsFMvoice	$0C
	dc.b		nC0,	$01,	nRst,	$07
unmelt_Jump02:
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nA3,	$18,	nG3,	$12,	nF3,	$21,	nA3,	$03
	dc.b		nC4,	nE4,	nG4,	nE4,	nC4,	nF3,	nA3,	$18
	dc.b		nG3,	$12,	nF3,	$36,	nE4,	$09,	nB4,	nG4
	dc.b		$0C,	nC5,	$09,	nB4
unmelt_Loop03:
	dc.b		nA3,	$03,	nRst,	nA3,	nRst,	nA3,	$09,	nA3
	dc.b		$03,	nRst,	nA3,	$06,	nG3,	$03,	nC4,	nRst
	dc.b		nB3,	$06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	unmelt_Loop03
	dc.b		nA3,	$03,	nRst,	nA3,	nRst,	nA3,	$09,	nA3
	dc.b		$03,	nRst,	nA3,	$06,	nG3,	$03,	nE4,	nD4
	dc.b		nG3,	nAb3,	nA3,	nA3,	nRst,	nG3,	nRst,	$06
	dc.b		nC4,	$0C,	nB3,	$03,	nRst,	nG3,	$06,	nAb3
	dc.b		$03,	nRst,	nA3,	nA3,	nRst,	nG3,	nRst,	$06
	dc.b		nC4,	$03,	nC4,	nRst,	nAb3,	nB3,	nRst,	nG3
	dc.b		$06,	nAb3,	$03,	nRst,	nA3,	nA3,	nRst,	nG3
	dc.b		nRst,	$06,	nC4,	$0C,	nB3,	$03,	nRst,	nG3
	dc.b		$06,	nAb3,	$03,	nRst,	nA3,	nA3,	nRst,	nG3
	dc.b		nRst,	$06,	nC4,	$03,	nC4,	nRst,	nAb3,	nB3
	dc.b		nRst,	nG3,	$06,	nA3,	$03,	nE3
;	Call At	 	location
	smpsCall	unmelt_Call01
	dc.b		nB3,	$03,	nRst,	nB3,	$06,	nD4,	nF4,	nE4
	dc.b		$09,	nB3,	$03,	nRst,	$06,	nA3,	$0C,	nA3
	dc.b		$03,	nRst,	nA3,	$09,	nA3,	$03,	nRst,	nA3
	dc.b		$06,	nG3,	$03,	nC4,	nRst,	nB3,	$06
;	Call At	 	location
	smpsCall	unmelt_Call01
	dc.b		nD4,	$03,	nRst,	nD3,	$06,	nF3,	nA3,	nB3
	dc.b		$09,	nA3,	$03,	nRst,	$06,	nB3,	$0C,	nE3
	dc.b		$03,	nRst,	nE3,	$06,	nRst,	$03,	nE3,	nE3
	dc.b		nE3,	nRst,	nE3,	nRst,	$0C
;	Call At	 	location
	smpsCall	unmelt_Call02
	dc.b		nA3,	$03,	nRst,	nA3,	$06,	nE4,	nG4,	$03
	dc.b		nFs4,	$09,	nD4,	$06,	nE4,	nA3
;	Call At	 	location
	smpsCall	unmelt_Call02
unmelt_Loop04:
	dc.b		nA4,	$03,	nRst,	nA3,	nRst,	nA3,	$09,	nA3
	dc.b		$03,	nRst,	nA3,	$06,	nG3,	$03,	nC4,	nRst
	dc.b		nB3,	$06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	unmelt_Loop04
	dc.b		nA3,	$03,	nRst,	nA3,	nRst,	nA3,	$09,	nA3
	dc.b		$03,	nRst,	nA3,	$06,	nG3,	$03,	nC4,	nB3
	dc.b		nG3,	nE3,	nF3,	$12,	nG3,	nF3,	nE3,	nD3
	dc.b		$03,	nRst,	nD3,	nRst,	nD3,	nD3,	nRst,	nD3
	dc.b		nRst,	$30
;	Jump To	 	location
	smpsJump	unmelt_Jump02

unmelt_Call01:
	dc.b		nF3,	$03,	nRst,	nF3,	$06,	nC4,	nF4,	nG4
	dc.b		$09,	nG3,	$03,	nRst,	$06,	nA3,	$0C,	nA3
	dc.b		$03,	nRst,	nA3,	$09,	nA3,	$03,	nRst,	nA3
	dc.b		$06,	nG3,	$03,	nC4,	nRst,	nB3,	$06
	smpsReturn

unmelt_Call02:
	dc.b		nF3,	$03,	nRst,	nF3,	$06,	nC4,	nF4,	$03
	dc.b		nG4,	$06,	nB3,	nG3,	$03,	nA3,	nAb3,	$06
	dc.b		nG3,	$03,	nE3,	nRst,	nE3,	$06,	nG3,	$03
	dc.b		nB3,	$06,	nA3,	$09,	nE4,	nA3,	nF3,	$03
	dc.b		nRst,	nF3,	$06,	nC4,	nF4,	$03,	nG3,	$06
	dc.b		nRst,	$03,	nG3,	$06,	nD4,	nG4
	smpsReturn

; FM3 Data
unmelt_FM3:
;	Set FM Voice	#
	smpsFMvoice	$0C
	dc.b		nC0,	$01,	nRst,	$07
unmelt_Jump03:
;	Set Modulation	wait	speed	change	step
	smpsModSet	$17,	$01,	$04,	$05
;	Set FM Voice	#
	smpsFMvoice	$02
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nE4,	$0C,	nA4,	$03,	nRst,	$09,	nG4,	nD4
	dc.b		$03,	nRst,	$06,	nE4,	$0C,	nA4,	nC5,	$1E
	dc.b		nE4,	$0C,	nA4,	$03,	nRst,	$09,	nG4,	nD4
	dc.b		$03,	nRst,	$06,	nE4,	$0C,	nE5,	nG5,	$1E
	dc.b		smpsNoAttack,	$30
unmelt_Loop05:
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA5,	$03,	nRst,	nA5,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nA5,	$06,	nRst,	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA5,	nRst,	nA5,	$06,	nRst,	$03
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG5,	nRst,	nG5,	nRst
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	unmelt_Loop05
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
unmelt_Loop06:
	dc.b		nC5,	$09,	nA4,	$03,	nRst,	$06,	nA4,	$0C
	dc.b		nG4,	$03,	nRst,	nG4,	nRst,	nA4,	nRst,	nC5
	dc.b		$09,	nA4,	$03,	nRst,	$06,	nA4,	$0C,	nG4
	dc.b		$03,	nRst,	nG4,	$0C
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	unmelt_Loop06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE5,	nE5,	$03,	nRst,	$09,	nD5,	nE5,	$03
	dc.b		nRst,	$06,	nB4,	$1E,	nA4,	$09,	nG4,	nA4
	dc.b		$06,	nD5,	$0C,	nD5,	$03,	nRst,	$09,	nB4
	dc.b		nB4,	$03,	nRst,	$06,	nG4,	$1B,	nRst,	$03
	dc.b		nG4,	$09,	nB4,	nC5,	$06,	nE5,	$0C,	nE5
	dc.b		$03,	nRst,	$09,	nD5,	nE5,	$03,	nRst,	$06
	dc.b		nB4,	$1E,	nA4,	$09,	nG4,	nA4,	$06,	nC5
	dc.b		$0F,	nRst,	$09,	nD4,	nE4,	$03,	nRst,	$06
	dc.b		nAb5,	$0C,	nAb5,	$03,	nRst,	nB4,	nRst,	$09
	dc.b		nAb5,	$03,	nAb5,	nRst,	nB4,	$06,	nRst,	$09
;	Set FM Voice	#
	smpsFMvoice	$02
;	Call At	 	location
	smpsCall	unmelt_Call03
	dc.b		nF5,	$06,	nA5,	$03,	nRst,	nG5,	nRst,	nF5
	dc.b		nG5,	$0F,	nE5,	$0C,	nC5,	$30
;	Call At	 	location
	smpsCall	unmelt_Call03
	dc.b		nF5,	$06,	nA5,	$03,	nRst,	nG5,	nRst,	nF5
	dc.b		nG5,	$0F,	nE5,	$0C
unmelt_Loop07:
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC6,	$03,	nE5,	nC6,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC6,	$06,	nE5,	$03,	nC6,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC6,	$06,	nE5,	$03
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nB5,	nD5,	nB5,	nRst
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	unmelt_Loop07
;	Set FM Voice	#
	smpsFMvoice	$03
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nE5,	$12
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nF5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nA5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB5,	$03,	nRst,	nB5,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nB5,	nD6,	nRst,	nE6,	nRst,	$09
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nE6,	$03,	nRst,	$09
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nE6,	$03,	nRst,	$09
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nE6,	$03,	nRst,	$09,	nRst,	$03
;	Alter Volume	value
	smpsAlterVol	$FA
;	Jump To	 	location
	smpsJump	unmelt_Jump03

unmelt_Call03:
	dc.b		nA5,	$06,	nC6,	$03,	nRst,	nB5,	nRst,	nA5
	dc.b		nG5,	$18,	nRst,	$03,	nG5,	$06,	nB5,	$03
	dc.b		nRst,	nA5,	nRst,	nG5,	nE5,	$18,	nRst,	$03
	smpsReturn

; FM4 Data
unmelt_FM4:
;	Set FM Voice	#
	smpsFMvoice	$0C
	dc.b		nC0,	$01,	nRst,	$07
unmelt_Jump04:
;	Set Modulation	wait	speed	change	step
	smpsModSet	$17,	$01,	$04,	$05
;	Set FM Voice	#
	smpsFMvoice	$02
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Pitch	value
	smpsAlterPitch	$F4
	dc.b		nA4,	$0C,	nC5,	$03,	nRst,	$09,	nB4,	nG4
	dc.b		$03,	nRst,	$06,	nA4,	$0C,	nC5,	nE5,	$1E
	dc.b		nA4,	$0C,	nC5,	$03,	nRst,	$09,	nB4,	nG4
	dc.b		$03,	nRst,	$06,	nA4,	$0C,	nG5,	nB5,	$1E
	dc.b		smpsNoAttack,	$30
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Set FM Voice	#
	smpsFMvoice	$07
unmelt_Loop08:
	dc.b		nA3,	$03,	nRst,	nA3,	nRst,	nA3,	$09,	nA3
	dc.b		$03,	nRst,	nA3,	$06,	nG3,	$03,	nC4,	nRst
	dc.b		nB3,	$06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	unmelt_Loop08
	dc.b		nA3,	$03,	nRst,	nA3,	nRst,	nA3,	$09,	nA3
	dc.b		$03,	nRst,	nA3,	$06,	nG3,	$03,	nE4,	nD4
	dc.b		nG3,	nAb3
;	Set FM Voice	#
	smpsFMvoice	$02
;	Alter Volume	value
	smpsAlterVol	$02
unmelt_Loop09:
	dc.b		nRst,	$03,	nC6,	$03,	nRst,	$06,	nC6,	nRst
	dc.b		$09,	nC6,	$06,	nRst,	$03,	nB5,	nD5,	nB5
	dc.b		nRst,	$03
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	unmelt_Loop09
;	Alter Volume	value
	smpsAlterVol	$FE
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Set FM Voice	#
	smpsFMvoice	$04
;	Call At	 	location
	smpsCall	unmelt_Call04
	dc.b		nRst,	nB3,	$03,	nF4,	nB4,	nF5,	nB5,	nD6
	dc.b		nF6,	nE6,	nB5,	nAb5,	nE5,	nB4,	nAb4,	nA4
	dc.b		$09,	nRst,	$03,	nA4,	$03,	nRst,	nA4,	$06
	dc.b		nRst,	$03,	nA4,	$06,	nA4,	nG4,	$03,	nC5
	dc.b		$06,	nB4
;	Call At	 	location
	smpsCall	unmelt_Call04
	dc.b		nRst,	$03,	nD4,	nA4,	nD5,	nF5,	nA5,	nC6
	dc.b		nE6,	nRst,	nD4,	nA4,	nD5,	nF5,	nA5,	nB5
	dc.b		$0C,	nC6,	$06,	nB5,	nC6,	nB5,	$03,	nB5
	dc.b		nRst,	nE5,	nRst,	$0C
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Set FM Voice	#
	smpsFMvoice	$08
	dc.b		nRst,	$03,	nF4,	$09,	nF4,	$03,	nRst,	$0C
	dc.b		nG4,	$09,	nG4,	$03,	nRst,	$0C,	nE4,	$09
	dc.b		nE4,	$03,	nRst,	$0C,	nA4,	$09,	nA4,	$03
	dc.b		nRst,	$0C,	nF4,	$09,	nF4,	$03,	nRst,	$0C
	dc.b		nG4,	$09,	nG4,	$03,	nRst,	$0C,	nRst,	$03
	dc.b		nE4,	$03,	nRst,	$06,	nE4,	$03,	nRst,	$06
	dc.b		nE4,	$03,	nE4,	nRst,	nD4,	nRst,	nE4,	$09
	dc.b		nRst,	$03,	nF4,	$09,	nF4,	$03,	nRst,	$0C
	dc.b		nG4,	$09,	nG4,	$03,	nRst,	$0C,	nE4,	$09
	dc.b		nE4,	$03,	nRst,	$0C,	nA4,	$09,	nA4,	$03
	dc.b		nRst,	$0C,	nF4,	$09,	nF4,	$03,	nRst,	$0C
	dc.b		nG4,	$09,	nG4,	$03,	nRst,	$09
;	Set FM Voice	#
	smpsFMvoice	$05
unmelt_Loop0A:
	dc.b		nA5,	$03,	nRst,	nA5,	nRst,	nA5,	$06,	nRst
	dc.b		$03,	nA5,	nRst,	nA5,	$06,	nRst,	$03,	nG5
	dc.b		nRst,	nG5,	nRst
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	unmelt_Loop0A
;	Set FM Voice	#
	smpsFMvoice	$03
;	Alter Pitch	value
	smpsAlterPitch	$0C
	dc.b		nA4,	$12,	nB4,	nC5,	nD5,	nE5,	$03,	nRst
	dc.b		nE5,	nRst,	nE5,	nG5,	nRst,	nA5,	nRst,	$09
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		nA5,	$03,	nRst,	$09
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		nA5,	$03,	nRst,	$09
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		nA5,	$03,	nRst,	$09,	nRst,	$03
;	Alter Volume	value
	smpsAlterVol	$F7
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Jump To	 	location
	smpsJump	unmelt_Jump04

unmelt_Call04:
	dc.b		nRst,	$03,	nF4,	nC5,	nF5,	nC6,	nRst,	nF6
	dc.b		nC6,	nG6,	$09,	nD6,	$03,	nRst,	$06,	nG5
	dc.b		$09,	nRst,	$03,	nG5,	nRst,	nAb5,	nRst,	nA5
	dc.b		$06,	nRst,	$03,	nG5,	nAb5,	nRst,	nA5,	$09
	dc.b		nRst,	$03
	smpsReturn

; FM5 Data
unmelt_FM5:
;	Set FM Voice	#
	smpsFMvoice	$0C
	dc.b		nC0,	$01,	nRst,	$07
;	Alter Volume	value
	smpsAlterVol	$0A
	dc.b		nRst,	$06
;	Jump To	 	location
	smpsJump	unmelt_FM1

; PSG1 Data
unmelt_PSG1:
	dc.b		nRst,	$08
unmelt_Jump05:
;	Set PSG Voice	#
	smpsPSGvoice	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0C,	$01,	$01,	$02
;	Set Volume	value
	smpsSetVol	$02
;	Alter Pitch	value
	smpsAlterPitch	$0C
	dc.b		nA4,	$0C,	nC5,	$03,	nRst,	$09,	nB4,	nG4
	dc.b		$03,	nRst,	$06,	nA4,	$0C,	nC5,	nE5,	$1E
	dc.b		nA4,	$0C,	nC5,	$03,	nRst,	$09,	nB4,	nG4
	dc.b		$03,	nRst,	$06,	nA4,	$0C,	nG5,	nB5,	$1E
	dc.b		smpsNoAttack,	$30
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Set Volume	value
	smpsSetVol	$FE
;	Set PSG Voice	#
	smpsPSGvoice	$03
unmelt_Loop0B:
	dc.b		nG4,	$03,	nRst,	nG4,	nRst,	nG4,	$06,	nRst
	dc.b		$03,	nG4,	nRst,	nG4,	$06,	nRst,	$03,	nF4
	dc.b		nRst,	nF4,	nRst
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	unmelt_Loop0B
;	Set PSG Voice	#
	smpsPSGvoice	$00
unmelt_Loop0C:
	dc.b		nG3,	$09,	nE3,	$03,	nRst,	$06,	nE3,	$0C
	dc.b		nD3,	$03,	nRst,	nD3,	nRst,	nE3,	nRst,	nG3
	dc.b		$09,	nE3,	$03,	nRst,	$06,	nE3,	$0C,	nD3
	dc.b		$03,	nRst,	nD3,	$0C
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	unmelt_Loop0C
	dc.b		nC4,	nC4,	$03,	nRst,	$09,	nB3,	nC4,	$03
	dc.b		nRst,	$06,	nG3,	$1E,	nE3,	$09,	nD3,	nE3
	dc.b		$06,	nB3,	$0C,	nB3,	$03,	nRst,	$09,	nAb3
	dc.b		nAb3,	$03,	nRst,	$06,	nE3,	$1B,	nRst,	$03
	dc.b		nE3,	$09,	nG3,	nA3,	$06,	nC4,	$0C,	nC4
	dc.b		$03,	nRst,	$09,	nB3,	nC4,	$03,	nRst,	$06
	dc.b		nG3,	$1E,	nE3,	$09,	nD3,	nE3,	$06,	nA3
	dc.b		$0C,	nA3,	$03,	nRst,	$09,	nB3,	nC4,	$03
	dc.b		nRst,	$06,	nD4,	$0C,	nD4,	$03,	nRst,	nB4
	dc.b		nRst,	$09,	nD4,	$03,	nD4,	nRst,	nB4,	nAb3
	dc.b		$02,	nB3,	nD4,	nE4,	nAb4,	nB4
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0C,	$01,	$02,	$02
;	Call At	 	location
	smpsCall	unmelt_Call05
	dc.b		nE5,	$30
;	Call At	 	location
	smpsCall	unmelt_Call05
	dc.b		nE5,	$27,	smpsNoAttack,	$30,	nRst,	$02,	nFs5,	nG5
	dc.b		nAb5,	$01,	nA5,	nBb5,	nC6,	$2D,	nRst,	$01
	dc.b		nCs6,	nD6,	nE6,	$16,	nD6,	$01,	nCs6,	nC6
	dc.b		$12,	nA5,	$02,	nG5,	nFs5,	$01,	nF5
;	Set PSG Voice	#
	smpsPSGvoice	$05
	dc.b		nE4,	$12,	nFs4,	nG4,	nA4,	nB4,	$03,	nRst
	dc.b		nB4,	nRst,	nB4,	nD5,	nRst,	nE5,	nRst,	$30
;	Jump To	 	location
	smpsJump	unmelt_Jump05

unmelt_Call05:
	dc.b		nC6,	$06,	nE6,	$03,	nRst,	nD6,	nRst,	nC6
	dc.b		nB5,	$18,	nRst,	$03,	nB5,	$06,	nD6,	$03
	dc.b		nRst,	nC6,	nRst,	nB5,	nA5,	$18,	nRst,	$03
	dc.b		nA5,	$06,	nC6,	$03,	nRst,	nB5,	nRst,	nA5
	dc.b		nB5,	$0F,	nG5,	$0C
	smpsReturn

; PSG2 Data
unmelt_PSG2:
	dc.b		nRst,	$08
unmelt_Jump06:
;	Set PSG Voice	#
	smpsPSGvoice	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0C,	$01,	$01,	$02
;	Set Volume	value
	smpsSetVol	$02
;	Alter Pitch	value
	smpsAlterPitch	$0C
	dc.b		nRst,	$06,	nA4,	$0C,	nC5,	$03,	nRst,	$09
	dc.b		nB4,	nG4,	$03,	nRst,	$06,	nA4,	$0C,	nC5
	dc.b		nE5,	$1E,	nA4,	$0C,	nC5,	$03,	nRst,	$09
	dc.b		nB4,	nG4,	$03,	nRst,	$06,	nA4,	$0C,	nG5
	dc.b		nB5,	$18,	smpsNoAttack,	$30
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Set Volume	value
	smpsSetVol	$FE
;	Set PSG Voice	#
	smpsPSGvoice	$03
;	Set Volume	value
	smpsSetVol	$FF
unmelt_Loop0D:
	dc.b		nC6,	$03,	nE5,	nC6,	nRst,	nC6,	$06,	nE5
	dc.b		$03,	nC6,	nRst,	nC6,	$06,	nE5,	$03,	nB5
	dc.b		nD5,	nB5,	nRst
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	unmelt_Loop0D
;	Set PSG Voice	#
	smpsPSGvoice	$04
unmelt_Loop0E:
	dc.b		nRst,	$03,	nA4,	$03,	nRst,	$06,	nA4,	nRst
	dc.b		$09,	nA4,	$06,	nRst,	$03,	nG4,	nRst,	nG4
	dc.b		nRst
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	unmelt_Loop0E
;	Set PSG Voice	#
	smpsPSGvoice	$06
;	Set Volume	value
	smpsSetVol	$01
;	Call At	 	location
	smpsCall	unmelt_Call06
	dc.b		nRst,	nB3,	$03,	nF4,	nB4,	nF5,	nB5,	nD6
	dc.b		nF6,	nE6,	nB5,	nAb5,	nE5,	nB4,	nAb4,	nA4
	dc.b		$09,	nRst,	$03,	nA4,	$03,	nRst,	nA4,	$06
	dc.b		nRst,	$03,	nA4,	$06,	nA4,	nG4,	$03,	nC5
	dc.b		$06,	nB4
;	Call At	 	location
	smpsCall	unmelt_Call06
	dc.b		nRst,	$03,	nD4,	nA4,	nD5,	nF5,	nA5,	nC6
	dc.b		nE6,	nRst,	nD4,	nA4,	nD5,	nF5,	nA5,	nB5
	dc.b		$0C,	nC6,	$06,	nB5,	nC6,	nB5,	$03,	nB5
	dc.b		nRst,	nE5,	nE3,	$02,	nAb3,	nB3,	nE4,	nAb4
	dc.b		nB4
;	Set PSG Voice	#
	smpsPSGvoice	$05
	dc.b		nRst,	$03,	nC4,	$09,	nC4,	$03,	nRst,	$0C
	dc.b		nD4,	$09,	nD4,	$03,	nRst,	$0C,	nB3,	$09
	dc.b		nB3,	$03,	nRst,	$0C,	nE4,	$09,	nE4,	$03
	dc.b		nRst,	$0C,	nC4,	$09,	nC4,	$03,	nRst,	$0C
	dc.b		nD4,	$09,	nD4,	$03,	nRst,	$0C,	nRst,	$03
	dc.b		nB3,	$09,	nB3,	$03,	nRst,	$06,	nB3,	$03
	dc.b		nB3,	nRst,	nA3,	nRst,	nB3,	$09,	nRst,	$03
	dc.b		nC4,	$09,	nC4,	$03,	nRst,	$0C,	nD4,	$09
	dc.b		nD4,	$03,	nRst,	$0C,	nB3,	$09,	nB3,	$03
	dc.b		nRst,	$0C,	nE4,	$09,	nE4,	$03,	nRst,	$0C
	dc.b		nC4,	$09,	nC4,	$03,	nRst,	$0C,	nD4,	$09
	dc.b		nD4,	$03,	nRst,	$09
;	Set Volume	value
	smpsSetVol	$FF
;	Set PSG Voice	#
	smpsPSGvoice	$03
unmelt_Loop0F:
	dc.b		nG4,	$03,	nRst,	nG4,	nRst,	nG4,	$06,	nRst
	dc.b		$03,	nG4,	nRst,	nG4,	$06,	nRst,	$03,	nF4
	dc.b		nRst,	nF4,	nRst
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	unmelt_Loop0F
;	Set Volume	value
	smpsSetVol	$01
;	Set PSG Voice	#
	smpsPSGvoice	$05
	dc.b		nA3,	$12,	nB3,	nC4,	nD4,	nE4,	$03,	nRst
	dc.b		nE4,	nRst,	nE4,	nG4,	nRst,	nA4,	nRst,	$30
;	Jump To	 	location
	smpsJump	unmelt_Jump06

unmelt_Call06:
	dc.b		nRst,	$03,	nF4,	nC5,	nF5,	nC6,	nRst,	nF6
	dc.b		nC6,	nG6,	$09,	nD6,	$03,	nRst,	$06,	nG5
	dc.b		$09,	nRst,	$03,	nG5,	nRst,	nAb5,	nRst,	nA5
	dc.b		$06,	nRst,	$03,	nG5,	nAb5,	nRst,	nA5,	$09
	dc.b		nRst,	$03
	smpsReturn

; PSG3 Data
unmelt_PSG3:
	dc.b		nRst,	$08
;	Set PSG WvForm	#
	smpsPSGform	$E7
unmelt_Jump07:
;	Set PSG Voice	#
	smpsPSGvoice	$03
	dc.b		nA5,	$03,	nA5,	$06,	nA5,	$03,	nA5,	nA5
	dc.b		nA5,	nA5,	$06,	nA5,	$03,	nA5,	$06,	nA5
	dc.b		$03,	nA5,	nA5,	nA5
;	Jump To	 	location
	smpsJump	unmelt_Jump07

; DAC Data
unmelt_DAC:
	dc.b		nRst,	$08
unmelt_Jump08:
	dc.b		dSnare,	$0C,	dSnare,	dHiTimpani,	$03,	dSnare,	$06,	dHiTimpani
	dc.b		$03,	dSnare,	$06,	dHiTimpani,	dSnare,	$0C,	dSnare,	dSnare
	dc.b		$03,	introduce_dac_8E,	$06,	introduce_dac_8D,	$03,	introduce_dac_8D,	dSnare,	introduce_dac_8E
	dc.b		$06,	dSnare,	$0C,	dSnare,	dHiTimpani,	$03,	dSnare,	$06
	dc.b		dHiTimpani,	$03,	dSnare,	$06,	dHiTimpani,	dSnare,	$0C,	dSnare
	dc.b		dSnare,	dSnare,	$03,	dSnare,	introduce_dac_8E,	$06,	dSnare,	$0C
	dc.b		dSnare,	dSnare,	$03,	dHiTimpani,	$06,	dHiTimpani,	$03,	dHiTimpani
	dc.b		dHiTimpani,	dHiTimpani,	dHiTimpani,	dSnare,	$0C,	dHiTimpani,	$09,	dSnare
	dc.b		$06,	dSnare,	dSnare,	$03,	dHiTimpani,	$06,	dSnare,	dSnare
	dc.b		$0C,	dHiTimpani,	$09,	dSnare,	$06,	dSnare,	dSnare,	$03
	dc.b		dHiTimpani,	$06,	dSnare,	dSnare,	$0C,	dHiTimpani,	$09,	dSnare
	dc.b		$06,	dSnare,	dSnare,	$03,	dHiTimpani,	$06,	dHiTimpani,	$03
	dc.b		dHiTimpani,	dSnare,	$0C,	dHiTimpani,	$09,	dSnare,	$06,	nRst
	dc.b		$03,	dSnare,	nRst,	dHiTimpani,	$06,	dSnare,	dSnare,	$0C
	dc.b		dHiTimpani,	$09,	dSnare,	$06,	nRst,	$03,	dSnare,	nRst
	dc.b		dHiTimpani,	$06,	dSnare,	dSnare,	$0C,	dHiTimpani,	$09,	dSnare
	dc.b		$06,	nRst,	$03,	dSnare,	nRst,	dHiTimpani,	$06,	dSnare
	dc.b		dSnare,	$0C,	dHiTimpani,	$09,	dSnare,	$06,	nRst,	$03
	dc.b		dSnare,	nRst,	dHiTimpani,	$06,	dSnare,	dSnare,	$0C,	dHiTimpani
	dc.b		$09,	dSnare,	$03,	dHiTimpani,	$09,	dHiTimpani,	dSnare,	$06
	dc.b		nRst,	dSnare,	dHiTimpani,	$09,	dSnare,	$06,	dSnare,	$03
	dc.b		dSnare,	$06,	dHiTimpani,	dSnare,	dSnare,	$0C,	dHiTimpani,	$09
	dc.b		dSnare,	$03,	dHiTimpani,	$09,	dHiTimpani,	dSnare,	$06,	nRst
	dc.b		dSnare,	dHiTimpani,	$09,	dSnare,	$06,	dSnare,	$03,	dSnare
	dc.b		$06,	dHiTimpani,	dSnare,	dSnare,	$0C,	dHiTimpani,	$09,	dSnare
	dc.b		$03,	dHiTimpani,	$09,	dHiTimpani,	dSnare,	$06,	nRst,	dSnare
	dc.b		dHiTimpani,	$09,	dSnare,	$06,	dSnare,	$03,	dSnare,	$06
	dc.b		dHiTimpani,	dSnare,	dSnare,	$0C,	dHiTimpani,	$09,	dSnare,	$03
	dc.b		dHiTimpani,	$09,	dHiTimpani,	dSnare,	$06,	nRst,	dSnare,	dHiTimpani
	dc.b		$09,	dSnare,	$03,	dHiTimpani,	dHiTimpani,	$06,	dHiTimpani,	$03
	dc.b		dSnare,	$06,	dHiTimpani,	$03,	dHiTimpani,	dSnare,	$06,	dSnare
	dc.b		dHiTimpani,	$09,	dSnare,	dSnare,	$06,	dHiTimpani,	dSnare,	$03
	dc.b		dHiTimpani,	dSnare,	$06,	dSnare,	dHiTimpani,	$09,	dSnare,	dSnare
	dc.b		$06,	dHiTimpani,	dSnare,	$03,	dHiTimpani,	dSnare,	$06,	dSnare
	dc.b		dHiTimpani,	$09,	dSnare,	dSnare,	$06,	dHiTimpani,	dSnare,	$03
	dc.b		dHiTimpani,	dSnare,	$06,	dSnare,	dHiTimpani,	$09,	dSnare,	dSnare
	dc.b		$06,	dHiTimpani,	dSnare,	$03,	dHiTimpani,	dSnare,	$06,	dSnare
	dc.b		dHiTimpani,	$09,	dSnare,	dSnare,	$06,	dHiTimpani,	dSnare,	$03
	dc.b		dHiTimpani,	dSnare,	$06,	dSnare,	dHiTimpani,	$09,	dSnare,	dSnare
	dc.b		$06,	dHiTimpani,	dSnare,	$03,	dHiTimpani,	dSnare,	$06,	dSnare
	dc.b		dHiTimpani,	$09,	dSnare,	dSnare,	$06,	dHiTimpani,	dHiTimpani,	$03
	dc.b		dHiTimpani,	dSnare,	$0C,	dHiTimpani,	$09,	dSnare,	$06,	dSnare
	dc.b		dSnare,	$03,	dHiTimpani,	$06,	dSnare,	dSnare,	$0C,	dHiTimpani
	dc.b		$09,	dSnare,	$06,	dSnare,	dSnare,	$03,	dHiTimpani,	$06
	dc.b		dSnare,	dSnare,	$0C,	dHiTimpani,	$09,	dSnare,	$06,	dSnare
	dc.b		dSnare,	$03,	dHiTimpani,	$06,	dSnare,	dSnare,	$0C,	dHiTimpani
	dc.b		$09,	dSnare,	$06,	dSnare,	dSnare,	$03,	dHiTimpani,	$06
	dc.b		dSnare,	introduce_dac_8C,	dSnare,	dSnare,	introduce_dac_8E,	dSnare,	dSnare,	introduce_dac_8C
	dc.b		$03,	introduce_dac_8D,	dSnare,	dSnare,	dSnare,	dSnare,	introduce_dac_8D,	introduce_dac_8E
	dc.b		dSnare,	dSnare,	dSnare,	dSnare,	dHiTimpani,	$06,	dHiTimpani,	dHiTimpani
	dc.b		$03,	dHiTimpani,	$06,	dHiTimpani,	$03,	nRst,	dSnare,	$09
	dc.b		dSnare,	dHiTimpani,	$01,	dHiTimpani,	dHiTimpani,	dHiTimpani,	$03,	dHiTimpani
	dc.b		introduce_dac_8C,	nRst,	introduce_dac_8D,	introduce_dac_8E,	introduce_dac_8C,	introduce_dac_8E
;	Jump To	 	location
	smpsJump	unmelt_Jump08

unmelt_Voices:
;	Voice 00
;	$35,$00,$0C,$00,$00,$4E,$1C,$1D,$1F,$1B,$0D,$17,$1F,$00,$14,$07,$09,$27,$0F,$0F,$07,$12,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$00,	$00,	$0C,	$00
	smpsVcRateScale		$00,	$00,	$00,	$01
	smpsVcAttackRate	$1F,	$1D,	$1C,	$0E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$17,	$0D,	$1B
	smpsVcDecayRate2	$09,	$07,	$14,	$00
	smpsVcDecayLevel	$00,	$00,	$00,	$02
	smpsVcReleaseRate	$07,	$0F,	$0F,	$07
	smpsVcTotalLevel	$80,	$80,	$80,	$12

;	Voice 01
;	$30,$01,$00,$00,$01,$9F,$1F,$1F,$5C,$0F,$10,$0D,$14,$08,$05,$08,$08,$6F,$0F,$07,$1C,$08,$19,$19,$79
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$00,	$00,	$01
	smpsVcRateScale		$01,	$00,	$00,	$02
	smpsVcAttackRate	$1C,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$14,	$0D,	$10,	$0F
	smpsVcDecayRate2	$08,	$08,	$05,	$08
	smpsVcDecayLevel	$01,	$00,	$00,	$06
	smpsVcReleaseRate	$0C,	$07,	$0F,	$0F
	smpsVcTotalLevel	$79,	$19,	$19,	$08

;	Voice 02
;	$3D,$01,$21,$31,$20,$1F,$1F,$1F,$1F,$07,$04,$04,$04,$06,$0A,$0C,$08,$AA,$E9,$E9,$E9,$17,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$02,	$03,	$02,	$00
	smpsVcCoarseFreq	$00,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$04,	$04,	$04,	$07
	smpsVcDecayRate2	$08,	$0C,	$0A,	$06
	smpsVcDecayLevel	$0E,	$0E,	$0E,	$0A
	smpsVcReleaseRate	$09,	$09,	$09,	$0A
	smpsVcTotalLevel	$80,	$80,	$80,	$17

;	Voice 03
;	$3A,$21,$22,$00,$00,$1B,$1F,$1F,$1D,$07,$1F,$1F,$06,$0B,$06,$06,$10,$00,$0F,$0F,$7D,$14,$19,$10,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$02,	$02
	smpsVcCoarseFreq	$00,	$00,	$02,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1D,	$1F,	$1F,	$1B
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$06,	$1F,	$1F,	$07
	smpsVcDecayRate2	$10,	$06,	$06,	$0B
	smpsVcDecayLevel	$07,	$00,	$00,	$00
	smpsVcReleaseRate	$0D,	$0F,	$0F,	$00
	smpsVcTotalLevel	$80,	$10,	$19,	$14

;	Voice 04
;	$3C,$31,$43,$62,$01,$12,$10,$14,$10,$04,$08,$04,$08,$02,$05,$04,$07,$12,$15,$12,$15,$20,$80,$20,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$06,	$04,	$03
	smpsVcCoarseFreq	$01,	$02,	$03,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$10,	$14,	$10,	$12
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$08,	$04,	$08,	$04
	smpsVcDecayRate2	$07,	$04,	$05,	$02
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$05,	$02,	$05,	$02
	smpsVcTotalLevel	$80,	$20,	$80,	$20

;	Voice 05
;	$04,$37,$11,$01,$72,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$00,$00,$00,$00,$0F,$0F,$0F,$0F,$21,$80,$10,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$00,	$01,	$03
	smpsVcCoarseFreq	$02,	$01,	$01,	$07
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$1F,	$1F,	$1F
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$10,	$80,	$21

;	Voice 06
;	$3C,$32,$30,$62,$64,$0F,$1F,$13,$1F,$1F,$1F,$1F,$08,$07,$00,$00,$07,$09,$09,$07,$09,$18,$80,$13,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$06,	$06,	$03,	$03
	smpsVcCoarseFreq	$04,	$02,	$00,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$13,	$1F,	$0F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$08,	$1F,	$1F,	$1F
	smpsVcDecayRate2	$07,	$00,	$00,	$07
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$09,	$07,	$09,	$09
	smpsVcTotalLevel	$80,	$13,	$80,	$18

;	Voice 07
;	$26,$3E,$53,$02,$01,$9F,$5F,$57,$5E,$0C,$0C,$0F,$05,$00,$01,$01,$01,$BA,$88,$7F,$37,$1E,$80,$80,$80
;				#
	smpsVcAlgorithm		$06
	smpsVcFeedback		$04
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$05,	$03
	smpsVcCoarseFreq	$01,	$02,	$03,	$0E
	smpsVcRateScale		$01,	$01,	$01,	$02
	smpsVcAttackRate	$1E,	$17,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$0F,	$0C,	$0C
	smpsVcDecayRate2	$01,	$01,	$01,	$00
	smpsVcDecayLevel	$03,	$07,	$08,	$0B
	smpsVcReleaseRate	$07,	$0F,	$08,	$0A
	smpsVcTotalLevel	$80,	$80,	$80,	$1E

;	Voice 08
;	$3A,$32,$21,$60,$02,$50,$18,$18,$90,$02,$02,$02,$04,$03,$04,$02,$04,$12,$12,$12,$15,$1B,$1C,$18,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$06,	$02,	$03
	smpsVcCoarseFreq	$02,	$00,	$01,	$02
	smpsVcRateScale		$02,	$00,	$00,	$01
	smpsVcAttackRate	$10,	$18,	$18,	$10
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$04,	$02,	$02,	$02
	smpsVcDecayRate2	$04,	$02,	$04,	$03
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$05,	$02,	$02,	$02
	smpsVcTotalLevel	$80,	$18,	$1C,	$1B

;	Voice 09
;	$38,$33,$51,$31,$61,$1A,$1A,$10,$1F,$1F,$1F,$1F,$1F,$00,$00,$00,$07,$09,$09,$07,$09,$80,$7F,$87,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$06,	$03,	$05,	$03
	smpsVcCoarseFreq	$01,	$01,	$01,	$03
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$10,	$1A,	$1A
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$1F,	$1F,	$1F
	smpsVcDecayRate2	$07,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$09,	$07,	$09,	$09
	smpsVcTotalLevel	$80,	$87,	$7F,	$80

;	Voice 0A
;	$30,$13,$02,$41,$01,$10,$1F,$1F,$10,$06,$0B,$04,$1F,$00,$00,$00,$00,$15,$0A,$05,$0A,$19,$38,$10,$79
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$04,	$00,	$01
	smpsVcCoarseFreq	$01,	$01,	$02,	$03
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$10,	$1F,	$1F,	$10
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$04,	$0B,	$06
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$00,	$00,	$01
	smpsVcReleaseRate	$0A,	$05,	$0A,	$05
	smpsVcTotalLevel	$79,	$10,	$38,	$19

;	Voice 0B
;	$3B,$52,$31,$31,$51,$12,$14,$12,$14,$0E,$00,$0E,$02,$00,$00,$00,$01,$4A,$0A,$5A,$3A,$1C,$15,$14,$80
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$05,	$03,	$03,	$05
	smpsVcCoarseFreq	$01,	$01,	$01,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$14,	$12,	$14,	$12
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$02,	$0E,	$00,	$0E
	smpsVcDecayRate2	$01,	$00,	$00,	$00
	smpsVcDecayLevel	$03,	$05,	$00,	$04
	smpsVcReleaseRate	$0A,	$0A,	$0A,	$0A
	smpsVcTotalLevel	$80,	$14,	$15,	$1C

;	Voice 0C
;	$00,$70,$14,$02,$42,$12,$1F,$1F,$1F,$14,$0F,$0F,$0F,$08,$06,$06,$06,$22,$29,$29,$29,$E0,$E0,$E0,$E0
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$04,	$00,	$01,	$07
	smpsVcCoarseFreq	$02,	$02,	$04,	$00
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$12
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$0F,	$0F,	$14
	smpsVcDecayRate2	$06,	$06,	$06,	$08
	smpsVcDecayLevel	$02,	$02,	$02,	$02
	smpsVcReleaseRate	$09,	$09,	$09,	$02
	smpsVcTotalLevel	$E0,	$E0,	$E0,	$E0
	even
