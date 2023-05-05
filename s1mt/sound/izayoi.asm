; =============================================================================================
; Project Name:		izayoi
; Created:		21st September 2015
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

izayoi_Header:
;	Voice Pointer	location
	smpsHeaderVoice	izayoi_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$01,	$08

;	DAC Pointer	location
	smpsHeaderDAC	izayoi_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	izayoi_FM1,	smpsPitch00,	$08
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	izayoi_FM2,	smpsPitch00,	$08
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	izayoi_FM3,	smpsPitch00,	$0E
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	izayoi_FM4,	smpsPitch00,	$10
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	izayoi_FM5,	smpsPitch00,	$15
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	izayoi_PSG1,	smpsPitch03lo,	$06,	$08
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	izayoi_PSG2,	smpsPitch03lo,	$09,	$08
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	izayoi_PSG3,	smpsPitch00,	$01,	$03

; FM1 Data
izayoi_FM1:
	dc.b		nRst,	$30,	nRst,	$0F
;	Set FM Voice	#
	smpsFMvoice	$3F
;	Alter Volume	value
	smpsAlterVol	$02
;	Set Modulation	wait	speed	change	step
	smpsModSet	$05,	$03,	$BE,	$A4
	dc.b		nE4,	$15,	smpsModOn
;	Alter Volume	value
	smpsAlterVol	$FE
;	Set FM Voice	#
	smpsFMvoice	$13
	dc.b		nC3,	$0C
izayoi_Jump01:
;	Call At	 	location
	smpsCall	izayoi_Call01
;	Call At	 	location
	smpsCall	izayoi_Call01
	dc.b		nRst,	$30
;	Call At	 	location
	smpsCall	izayoi_Call02
	dc.b		smpsNoAttack,	$30
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$0A,	$04
;	Alter Volume	value
	smpsAlterVol	$0A
	dc.b		smpsNoAttack,	$0C
;	Alter Volume	value
	smpsAlterVol	$0A
	dc.b		smpsNoAttack,	$0C
;	Alter Volume	value
	smpsAlterVol	$0A
	dc.b		smpsNoAttack,	$0C
;	Alter Volume	value
	smpsAlterVol	$0A
	dc.b		smpsNoAttack,	$0C,	nRst,	$18
;	Alter Volume	value
	smpsAlterVol	$D8
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
;	Alter Volume	value
	smpsAlterVol	$07
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Call At	 	location
	smpsCall	izayoi_Call01
	dc.b		nRst,	$30
;	Call At	 	location
	smpsCall	izayoi_Call02
	dc.b		smpsNoAttack,	$18
;	Alter Volume	value
	smpsAlterVol	$07
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$41
	dc.b		nA2,	$04,	nG2,	nA2,	nB2,	nA2,	nB2,	nC3
	dc.b		nB2,	nC3,	nD3,	nC3,	nD3
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nE3,	nD3,	nE3,	nFs3,	nE3,	nFs3,	nG3,	nFs3
	dc.b		nG3,	nA3,	nG3,	nA3,	smpsNoAttack,	nAb3,	$03,	smpsNoAttack
	dc.b		nG3,	smpsNoAttack,	nFs3,	smpsNoAttack,	nF3,	smpsNoAttack,	nE3,	smpsNoAttack
	dc.b		nEb3,	smpsNoAttack,	nD3,	smpsNoAttack,	nCs3,	smpsNoAttack,	nC3,	smpsNoAttack
	dc.b		nB2,	smpsNoAttack,	nBb2,	smpsNoAttack,	nA2,	smpsNoAttack,	nAb2,	smpsNoAttack
	dc.b		nG2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Volume	value
	smpsAlterVol	$01
;	Call At	 	location
	smpsCall	izayoi_Call03
;	Call At	 	location
	smpsCall	izayoi_Call04
;	Jump To	 	location
	smpsJump	izayoi_Jump01

izayoi_Call01:
;	Set FM Voice	#
	smpsFMvoice	$41
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0F,	$01,	$04,	$05
;	Alter Volume	value
	smpsAlterVol	$FA
;	Note Fill	duration
	smpsNoteFill	$02
;	Set FM Voice	#
	smpsFMvoice	$44
	dc.b		nA2,	$06,	nA2,	nA2,	nA2
;	Note Fill	duration
	smpsNoteFill	$08
;	Set FM Voice	#
	smpsFMvoice	$41
	dc.b		nE3,	nD3,	nC3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD3,	smpsNoAttack,	nD3,	nC3,	nB2,	nA2,	$0C,	nB2
	dc.b		$06,	nG2,	$0C
;	Note Fill	duration
	smpsNoteFill	$02
;	Set FM Voice	#
	smpsFMvoice	$44
	dc.b		nA2,	$06,	nA2,	nA2,	nA2
;	Set FM Voice	#
	smpsFMvoice	$41
;	Note Fill	duration
	smpsNoteFill	$08
	dc.b		nE3,	nD3,	nC3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD3,	smpsNoAttack,	nD3,	$30
;	Note Fill	duration
	smpsNoteFill	$02
;	Set FM Voice	#
	smpsFMvoice	$44
	dc.b		nA2,	$06,	nA2,	nA2,	nA2
;	Set FM Voice	#
	smpsFMvoice	$41
;	Note Fill	duration
	smpsNoteFill	$08
	dc.b		nE3,	nD3,	nC3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD3,	smpsNoAttack,	nD3,	nC3,	nB2,	nA2,	$0C,	nB2
	dc.b		$06,	nG2,	$0C
;	Note Fill	duration
	smpsNoteFill	$02
;	Set FM Voice	#
	smpsFMvoice	$44
	dc.b		nA2,	$06,	nA2,	nA2,	nA2
;	Set FM Voice	#
	smpsFMvoice	$41
;	Note Fill	duration
	smpsNoteFill	$08
	dc.b		nE3,	nD3,	nC3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD3,	smpsNoAttack,	nD3,	$30,	smpsNoAttack,	nD3,	$30
;	Alter Volume	value
	smpsAlterVol	$06
	smpsReturn

izayoi_Call02:
;	Alter Volume	value
	smpsAlterVol	$04
;	Set FM Voice	#
	smpsFMvoice	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nA4,	$06,	nC5,	nE5,	nG5,	$06,	smpsNoAttack,	$18
	dc.b		smpsNoAttack,	$30,	nA4,	$06,	nC5,	nE5,	nG5,	$0C
	dc.b		nFs5,	$06,	nD5,	nFs5,	$0C,	nE5,	$06,	nC5
	dc.b		nE5,	$0C,	nD5,	$06,	nAb4,	$0C,	nA4,	$06
	dc.b		nC5,	nE5,	nG5,	$06,	smpsNoAttack,	$18,	smpsNoAttack,	$30
	dc.b		nC5,	$06,	nE5,	nA5,	nB5,	$0C,	nA5,	$06
	dc.b		nB5,	nC6,	$0C,	nB5,	$06,	nC6,	nD6,	$0C
	dc.b		nC6,	$06,	nAb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Set FM Voice	#
	smpsFMvoice	$41
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
;	Alter Volume	value
	smpsAlterVol	$F9
	dc.b		nD3,	$06,	nA3,	nE4,	nD4,	smpsNoAttack,	$18,	nRst
	dc.b		$06,	nD4,	nC4,	nG3,	nC4,	nB3,	nG3,	nA3
	dc.b		smpsNoAttack,	$06,	nFs3,	nD3,	nG3,	$0C,	nE3,	$06
	dc.b		nC3,	nFs3,	smpsNoAttack,	$06,	nD3,	nA2,	nE3,	$0C
	dc.b		nC3,	$06,	nG2,	$0C,	nF3,	$06,	nC4,	nG4
	dc.b		nF4,	smpsNoAttack,	$18,	nRst,	$06,	nF4,	nEb4,	nBb3
	dc.b		nEb4,	nD4,	nBb3,	nC4,	smpsNoAttack,	$06,	nA3,	nF3
	dc.b		nD4,	$0C,	nB3,	$06,	nG3,	nE4,	smpsNoAttack,	$06
	dc.b		nCs4,	nA3,	nFs4,	smpsNoAttack,	$18
	smpsReturn

izayoi_Call03:
;	Set FM Voice	#
	smpsFMvoice	$41
;	Alter Volume	value
	smpsAlterVol	$FD
izayoi_Loop01:
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$03,	$3F,	$AF
	dc.b		nD4,	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
	dc.b		smpsNoAttack,	nE4,	$12,	smpsNoAttack,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$03,	$3F,	$AF
	dc.b		nF4,	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
	dc.b		smpsNoAttack,	nG4,	$12,	smpsNoAttack,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$03,	$3F,	$AF
	dc.b		nE4,	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
	dc.b		smpsNoAttack,	nFs4,	$12,	smpsNoAttack,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$03,	$3F,	$AF
	dc.b		nEb4,	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
	dc.b		smpsNoAttack,	nF4,	$12,	smpsNoAttack,	$18
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	izayoi_Loop01
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$03,	$3F,	$AF
	dc.b		nF4,	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
	dc.b		smpsNoAttack,	nG4,	$12,	smpsNoAttack,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$03,	$3F,	$AF
	dc.b		nAb4,	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
	dc.b		smpsNoAttack,	nBb4,	$12,	smpsNoAttack,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$03,	$3F,	$AF
	dc.b		nG4,	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
	dc.b		smpsNoAttack,	nA4,	$12,	smpsNoAttack,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$03,	$3F,	$AF
	dc.b		nFs4,	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
	dc.b		smpsNoAttack,	nAb4,	$12,	smpsNoAttack,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$03,	$3F,	$AF
	dc.b		nF4,	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
	dc.b		smpsNoAttack,	nG4,	$12,	smpsNoAttack,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$03,	$3F,	$AF
	dc.b		nAb4,	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
	dc.b		smpsNoAttack,	nBb4,	$12,	smpsNoAttack,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$03,	$3F,	$AF
	dc.b		nG4,	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
	dc.b		smpsNoAttack,	nA4,	$12,	smpsNoAttack,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$03,	$3F,	$AF
	dc.b		nFs4,	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
	dc.b		smpsNoAttack,	nAb4,	$24,	smpsNoAttack,	$0C
;	Alter Volume	value
	smpsAlterVol	$03
	smpsReturn

izayoi_Call04:
;	Set FM Voice	#
	smpsFMvoice	$42
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
;	Alter Volume	value
	smpsAlterVol	$FD
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb2,	$06,	nE4,	$0C,	nBb2,	$06,	nFs4,	$18
	dc.b		smpsNoAttack,	$30,	nG4,	$06,	nFs4,	nE4,	nD4,	nE3
	dc.b		nC4,	nRst,	nD4
;	Set FM Voice	#
	smpsFMvoice	$41
;	Alter Volume	value
	smpsAlterVol	$FB
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB3,	$03,	nC4,	nB3,	nC4,	nB3,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC4,	$03,	nB3,	nA3,	nG3,	nFs3,	nE3,	nEb3
	dc.b		nD3
;	Alter Volume	value
	smpsAlterVol	$05
;	Set FM Voice	#
	smpsFMvoice	$42
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb2,	$06,	nE4,	$0C,	nBb2,	$06,	nFs4,	$18
	dc.b		smpsNoAttack,	$30,	nG4,	$06,	nFs4,	nE4,	nD4,	nE3
	dc.b		nC4,	nRst,	nD4
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nG5,	$03,	nC5,	nEb5,	nC5,	nFs5,	$03,	nB4
	dc.b		nD5,	nB4,	nF5,	$03,	nBb4,	nCs5,	nBb4,	nE5
	dc.b		$03,	nA4,	nC5,	nA4
;	Alter Volume	value
	smpsAlterVol	$02
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb2,	$06,	nE4,	$0C,	nBb2,	$06,	nFs4,	$18
	dc.b		smpsNoAttack,	$30,	nG4,	$06,	nFs4,	nE4,	nD4,	nE3
	dc.b		nC4,	nRst,	nD4
;	Set FM Voice	#
	smpsFMvoice	$41
;	Alter Volume	value
	smpsAlterVol	$FB
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nB3,	$03,	nC4,	nB3,	nC4,	nB3,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC4,	$03,	nB3,	nA3,	nG3,	nFs3,	nE3,	nEb3
	dc.b		nD3
;	Alter Volume	value
	smpsAlterVol	$05
;	Set FM Voice	#
	smpsFMvoice	$42
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb2,	$06,	nE4,	$0C,	nBb2,	$06,	nFs4,	$0C
	dc.b		nC3,	$06,	nG4,	$0C,	nC3,	$06,	nA4,	$0C
	dc.b		nEb3,	$06,	nBb4,	$0C,	nEb3,	$06,	nC5,	$30
	dc.b		smpsNoAttack,	$30,	nCs5,	$06,	nC5,	nBb4,	nAb4,	nBb4
	dc.b		nFs4,	nRst
;	Alter Volume	value
	smpsAlterVol	$FD
	dc.b		nAb4
;	Alter Volume	value
	smpsAlterVol	$01
;	Set Modulation	wait	speed	change	step
	smpsModSet	$14,	$02,	$DF,	$AF
	dc.b		smpsNoAttack,	$60
;	Alter Volume	value
	smpsAlterVol	$02
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
;	Alter Volume	value
	smpsAlterVol	$03
	smpsReturn

; FM2 Data
izayoi_FM2:
	dc.b		nRst,	$30,	nRst
izayoi_Jump02:
;	Alter Volume	value
	smpsAlterVol	$FE
;	Set FM Voice	#
	smpsFMvoice	$08
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nA2,	$06,	nA2,	nRst,	$24,	nRst,	$30
;	Alter Volume	value
	smpsAlterVol	$02
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$60,	$03
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nA2,	$06,	nA3,	nA2,	nA3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		smpsModOn
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nRst,	$18,	nRst,	$30
;	Alter Volume	value
	smpsAlterVol	$FE
;	Set FM Voice	#
	smpsFMvoice	$08
	dc.b		nA2,	$06,	nA2,	nRst,	$24,	nRst,	$30
;	Alter Volume	value
	smpsAlterVol	$02
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$60,	$03
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nA2,	$06,	nA3,	nA2,	nA3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		smpsModOn
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nRst,	$12
;	Alter Volume	value
	smpsAlterVol	$FC
;	Set FM Voice	#
	smpsFMvoice	$41
	dc.b		nA3,	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$05,	$E5,	$A0
	dc.b		smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsModOn
;	Alter Volume	value
	smpsAlterVol	$04
;	Alter Volume	value
	smpsAlterVol	$01
;	Set FM Voice	#
	smpsFMvoice	$43
izayoi_Loop02:
	dc.b		nA2,	$06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$17,	izayoi_Loop02
	dc.b		nD3,	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$14,	$01,	$DF,	$AF
	dc.b		smpsNoAttack,	$18,	smpsModOn,	nD3,	$06,	nD3,	nD2,	nD3
izayoi_Loop03:
	dc.b		nA2,	$06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$17,	izayoi_Loop03
	dc.b		nD3,	$06,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	nRst,	$30
izayoi_Loop04:
	dc.b		nA2,	$06,	nA2,	nA2,	nA2,	nA2,	$06,	nA2
	dc.b		nA2,	nA2,	nA2,	nC3,	smpsNoAttack,	$0C,	nG2,	$18
	dc.b		nA2,	$06,	nA2,	nA2,	nA2,	nA2,	$06,	nA2
	dc.b		nA2,	nA2,	nA2,	nE3,	smpsNoAttack,	$0C,	nEb3,	$06
	dc.b		nEb2,	nE3,	nE2
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	izayoi_Loop04
	dc.b		nD3,	$06,	nD3,	nD2,	nD3,	$0C,	nD3,	$06
	dc.b		nD2,	nD3,	smpsNoAttack,	$06,	nD3,	nD2,	nD3,	$0C
	dc.b		nD3,	$06,	nD2,	nD3,	nD3,	$06,	nD3,	nD2
	dc.b		nD3,	$0C,	nD3,	$06,	nD2,	nD3,	smpsNoAttack,	$06
	dc.b		nD3,	nD2,	nD3,	$0C,	nD3,	$06,	nD2,	nD3
	dc.b		nF3,	$06,	nF3,	nF2,	nF3,	$0C,	nF3,	$06
	dc.b		nF2,	nF3,	smpsNoAttack,	$06,	nF3,	nF2,	nF3,	$0C
	dc.b		nF3,	$06,	nF2,	nC3,	smpsNoAttack,	$06,	nC2,	nC2
	dc.b		nD3,	$0C,	nD2,	$06,	nD2,	nE3,	smpsNoAttack,	$06
	dc.b		nE2,	nE2,	nFs3,	smpsNoAttack,	$18,	smpsNoAttack,	$18,	nFs3
	dc.b		$02,	smpsNoAttack,	nF3,	smpsNoAttack,	nE3,	smpsNoAttack,	nEb3,	smpsNoAttack
	dc.b		nD3,	smpsNoAttack,	nCs3,	smpsNoAttack,	nC3,	smpsNoAttack,	nB2,	smpsNoAttack
	dc.b		nBb2,	smpsNoAttack,	nA2,	smpsNoAttack,	nAb2,	smpsNoAttack,	nG2,	smpsNoAttack
	dc.b		nFs2,	smpsNoAttack,	nF2,	smpsNoAttack,	nE2,	smpsNoAttack,	nEb2,	smpsNoAttack
	dc.b		nD2,	smpsNoAttack,	nCs2,	nRst,	$24,	nRst,	$18
izayoi_Loop05:
	dc.b		nA2,	$06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$17,	izayoi_Loop05
	dc.b		nD3,	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$14,	$01,	$DF,	$AF
	dc.b		smpsNoAttack,	$18,	smpsModOn,	nD3,	$06,	nD3,	nD2,	nD3
izayoi_Loop06:
	dc.b		nA2,	$06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$17,	izayoi_Loop06
	dc.b		nD3,	$06,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	nRst,	$30
izayoi_Loop07:
	dc.b		nA2,	$06,	nA2,	nA2,	nA2,	nA2,	$06,	nA2
	dc.b		nA2,	nA2,	nA2,	nC3,	smpsNoAttack,	$0C,	nG2,	$18
	dc.b		nA2,	$06,	nA2,	nA2,	nA2,	nA2,	$06,	nA2
	dc.b		nA2,	nA2,	nA2,	nE3,	smpsNoAttack,	$0C,	nEb3,	$06
	dc.b		nEb2,	nE3,	nE2
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	izayoi_Loop07
	dc.b		nD3,	$06,	nD3,	nD2,	nD3,	$0C,	nD3,	$06
	dc.b		nD2,	nD3,	smpsNoAttack,	$06,	nD3,	nD2,	nD3,	$0C
	dc.b		nD3,	$06,	nD2,	nD3,	nD3,	$06,	nD3,	nD2
	dc.b		nD3,	$0C,	nD3,	$06,	nD2,	nD3,	smpsNoAttack,	$06
	dc.b		nD3,	nD2,	nD3,	$0C,	nD3,	$06,	nD2,	nD3
	dc.b		nF3,	$06,	nF3,	nF2,	nF3,	$0C,	nF3,	$06
	dc.b		nF2,	nF3,	smpsNoAttack,	$06,	nF3,	nF2,	nF3,	$0C
	dc.b		nF3,	$06,	nF2,	nC3,	smpsNoAttack,	$06,	nC2,	nC2
	dc.b		nD3,	$0C,	nD2,	$06,	nD2,	nE3,	smpsNoAttack,	$06
	dc.b		nE2,	nE2,	nFs3,	smpsNoAttack,	$18,	smpsNoAttack,	$18,	nFs3
	dc.b		$02,	smpsNoAttack,	nF3,	smpsNoAttack,	nE3,	smpsNoAttack,	nEb3,	smpsNoAttack
	dc.b		nD3,	smpsNoAttack,	nCs3,	smpsNoAttack,	nC3,	smpsNoAttack,	nB2,	smpsNoAttack
	dc.b		nBb2,	smpsNoAttack,	nA2,	smpsNoAttack,	nAb2,	smpsNoAttack,	nG2,	smpsNoAttack
	dc.b		nFs2,	smpsNoAttack,	nF2,	smpsNoAttack,	nE2,	smpsNoAttack,	nEb2,	smpsNoAttack
	dc.b		nD2,	smpsNoAttack,	nCs2,	nRst,	$24,	nRst,	$30,	nRst
	dc.b		$12
izayoi_Loop08:
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nA2,	$0C
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nA2,	$06,	nA2,	nA2
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nA2,	nA1,	nRst,	nA2,	$0C
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nA2,	$06,	nA2,	nA2,	nA2
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nA3,	nA2
;	Alter Volume	value
	smpsAlterVol	$02
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	izayoi_Loop08
izayoi_Loop09:
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nC3,	$0C
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nC3,	$06,	nC3,	nC3
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nC3,	nC2,	nRst,	nC3,	$0C
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nC3,	$06,	nC3,	nC3,	nC3
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nC4,	nC3
;	Alter Volume	value
	smpsAlterVol	$02
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	izayoi_Loop09
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nC3,	$0C
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nC3,	$06,	nC3,	nC3
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nC3,	nC2,	nRst,	nC3,	$0C
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nC3,	$06,	nC3,	nC3,	nC3
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nC4,	nC3,	$0C
;	Alter Volume	value
	smpsAlterVol	$02
izayoi_Loop0A:
	dc.b		nA2,	$12,	nA2,	$06,	nA2,	$18,	nA2,	$06
	dc.b		nA2,	nA2,	nA2,	nA2,	$06,	nA2,	nA2,	nA2
	dc.b		nA2,	$06,	nA2,	nA2,	nA2,	nA2,	$06,	nA2
	dc.b		nA2,	nA2,	nA2,	$06,	nA2,	nA2,	nA2,	nA2
	dc.b		$06,	nA2,	nA2,	nA2
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	izayoi_Loop0A
	dc.b		nA2,	$12,	nA2,	$06,	nA2,	$0C,	nC3,	$12
	dc.b		nC3,	$06,	nC3,	$0C,	nEb3,	$12,	nEb3,	$06
	dc.b		nEb3,	$06,	nEb2,	nEb3,	nEb2,	nEb3,	$06,	nEb2
	dc.b		nEb3,	nEb2,	nEb3,	nEb3,	nEb3,	$03,	nD3,	nCs3
	dc.b		nC3,	nBb2,	nA2,	nAb2,	nG2,	nF2,	nE2,	nEb2
	dc.b		nD2,	nEb3,	$06,	nEb3,	nRst,	$18,	nRst,	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$14,	$01,	$DF,	$AF
	dc.b		nE3,	$06,	smpsNoAttack,	$60,	smpsModOn
;	Alter Volume	value
	smpsAlterVol	$FF
;	Jump To	 	location
	smpsJump	izayoi_Jump02

; FM3 Data
izayoi_FM3:
	dc.b		nRst,	$30,	nRst
izayoi_Jump03:
;	Call At	 	location
	smpsCall	izayoi_Call05
;	Call At	 	location
	smpsCall	izayoi_Call06
	dc.b		nRst,	$30
;	Call At	 	location
	smpsCall	izayoi_Call07
;	Call At	 	location
	smpsCall	izayoi_Call08
	dc.b		smpsNoAttack,	$12,	nRst,	$06,	nRst,	$30,	nRst,	$18
;	Alter Volume	value
	smpsAlterVol	$03
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Call At	 	location
	smpsCall	izayoi_Call06
	dc.b		nRst,	$30
;	Call At	 	location
	smpsCall	izayoi_Call07
;	Call At	 	location
	smpsCall	izayoi_Call08
;	Alter Volume	value
	smpsAlterVol	$03
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Volume	value
	smpsAlterVol	$FF
;	Set FM Voice	#
	smpsFMvoice	$41
	dc.b		nC3,	$04,	nB2,	nC3,	nD3,	nC3,	nD3,	nE3
	dc.b		nD3,	nE3,	nFs3,	nE3,	nFs3,	nG3,	nFs3,	nG3
	dc.b		nA3,	nG3,	nA3
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nB3,	nA3,	nB3,	nC4,	nB3,	nC4,	smpsNoAttack,	nB3
	dc.b		$03,	smpsNoAttack,	nBb3,	smpsNoAttack,	nA3,	smpsNoAttack,	nAb3,	smpsNoAttack
	dc.b		nG3,	smpsNoAttack,	nFs3,	smpsNoAttack,	nF3,	smpsNoAttack,	nE3,	smpsNoAttack
	dc.b		nEb3,	smpsNoAttack,	nD3,	smpsNoAttack,	nCs3,	smpsNoAttack,	nC3,	smpsNoAttack
	dc.b		nB2,	smpsNoAttack,	nBb2
;	Alter Volume	value
	smpsAlterVol	$02
;	Call At	 	location
	smpsCall	izayoi_Call09
;	Jump To	 	location
	smpsJump	izayoi_Jump03

izayoi_Call05:
;	Set FM Voice	#
	smpsFMvoice	$42
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0C,	$01,	$05,	$03
;	Alter Volume	value
	smpsAlterVol	$FA
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Note Fill	duration
	smpsNoteFill	$02
	dc.b		nA1,	$06,	nA1,	nA1,	nA1
;	Note Fill	duration
	smpsNoteFill	$08
	dc.b		nB3,	nA3,	nG3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nA3,	smpsNoAttack,	nA3,	nG3,	nFs3,	nE3,	$0C,	nFs3
	dc.b		$06,	nD3,	$0C
;	Note Fill	duration
	smpsNoteFill	$02
	dc.b		nA1,	$06,	nA1,	nA1,	nA1
;	Note Fill	duration
	smpsNoteFill	$08
	dc.b		nB3,	nA3,	nG3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nA3,	smpsNoAttack,	nA3,	$30
;	Note Fill	duration
	smpsNoteFill	$02
	dc.b		nA1,	$06,	nA1,	nA1,	nA1
;	Note Fill	duration
	smpsNoteFill	$08
	dc.b		nB3,	nA3,	nG3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nA3,	smpsNoAttack,	nA3,	nG3,	nFs3,	nE3,	$0C,	nFs3
	dc.b		$06,	nD3,	$0C
;	Note Fill	duration
	smpsNoteFill	$02
	dc.b		nA1,	$06,	nA1,	nA1,	nA1
;	Note Fill	duration
	smpsNoteFill	$08
	dc.b		nB3,	nA3,	nG3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nA3,	smpsNoAttack,	nA3,	$30,	smpsNoAttack,	nA3,	$30
;	Alter Volume	value
	smpsAlterVol	$06
;	Alter Pitch	value
	smpsAlterPitch	$F4
	smpsReturn

izayoi_Call06:
;	Set FM Voice	#
	smpsFMvoice	$42
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0C,	$01,	$05,	$03
;	Alter Volume	value
	smpsAlterVol	$FA
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Note Fill	duration
	smpsNoteFill	$05
	dc.b		nE2,	$06,	nE2,	nE2,	nE2
;	Note Fill	duration
	smpsNoteFill	$08
	dc.b		nB3,	nA3,	nG3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nA3,	smpsNoAttack,	nA3,	nG3,	nFs3,	nE3,	$0C,	nFs3
	dc.b		$06,	nD3,	$0C
;	Note Fill	duration
	smpsNoteFill	$05
	dc.b		nE2,	$06,	nE2,	nE2,	nE2
;	Note Fill	duration
	smpsNoteFill	$08
	dc.b		nB3,	nA3,	nG3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nA3,	smpsNoAttack,	nA3,	$30
;	Note Fill	duration
	smpsNoteFill	$05
	dc.b		nE2,	$06,	nE2,	nE2,	nE2
;	Note Fill	duration
	smpsNoteFill	$08
	dc.b		nB3,	nA3,	nG3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nA3,	smpsNoAttack,	nA3,	nG3,	nFs3,	nE3,	$0C,	nFs3
	dc.b		$06,	nD3,	$0C
;	Note Fill	duration
	smpsNoteFill	$05
	dc.b		nE2,	$06,	nE2,	nE2,	nE2
;	Note Fill	duration
	smpsNoteFill	$08
	dc.b		nB3,	nA3,	nG3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nA3,	smpsNoAttack,	nA3,	$30,	smpsNoAttack,	nA3,	$30
;	Alter Volume	value
	smpsAlterVol	$06
;	Alter Pitch	value
	smpsAlterPitch	$F4
	smpsReturn

izayoi_Call07:
;	Set FM Voice	#
	smpsFMvoice	$41
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0F,	$01,	$04,	$05
;	Alter Volume	value
	smpsAlterVol	$FB
izayoi_Loop0B:
;	Note Fill	duration
	smpsNoteFill	$05
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nA2,	$06
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nA2,	nA2
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nA2
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nA2,	nA2
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nA2
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nA2
;	Note Fill	duration
	smpsNoteFill	$08
	dc.b		nA2
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nC3,	smpsNoAttack,	$0C
;	Note Fill	duration
	smpsNoteFill	$00
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nG2,	$18
;	Note Fill	duration
	smpsNoteFill	$05
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nA2,	$06
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nA2,	nA2
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nA2
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nA2,	nA2
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nA2
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nA2
;	Note Fill	duration
	smpsNoteFill	$08
	dc.b		nA2
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nE3,	smpsNoAttack,	$0C
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nEb3,	$06,	nRst,	nE3,	nRst
;	Alter Volume	value
	smpsAlterVol	$02
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	izayoi_Loop0B
;	Alter Volume	value
	smpsAlterVol	$05
	smpsReturn

izayoi_Call08:
;	Set FM Voice	#
	smpsFMvoice	$42
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nA2,	$30
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nA2,	$06
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nA2
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nA2,	nD4
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nA2,	$0C
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nA2,	$06
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nA2,	smpsNoAttack,	$18
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nA2,	$06
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nA2
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nA2
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nA2,	smpsNoAttack,	$0C
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nA2,	$06
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nA2,	$06,	smpsNoAttack,	$18,	nC3,	$30
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nC3,	$06
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nC3
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nC3,	nC4
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nC3,	$0C
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nC3,	$06
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nF2,	smpsNoAttack,	$0C
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nF2,	$06
;	Alter Volume	value
	smpsAlterVol	$FF
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nG2,	$12
;	Alter Volume	value
	smpsAlterVol	$01
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nG2,	$06
;	Alter Volume	value
	smpsAlterVol	$FE
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nA2,	$12
;	Alter Volume	value
	smpsAlterVol	$02
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nA2,	$06
;	Alter Volume	value
	smpsAlterVol	$FD
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nB2,	$06,	smpsNoAttack,	$18,	smpsNoAttack,	$18
;	Alter Volume	value
	smpsAlterVol	$04
	smpsReturn

izayoi_Call09:
;	Set FM Voice	#
	smpsFMvoice	$41
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
;	Alter Volume	value
	smpsAlterVol	$F8
izayoi_Loop0C:
	dc.b		nA4,	$06,	smpsNoAttack,	$24,	smpsNoAttack,	$06,	nC5,	$06
	dc.b		smpsNoAttack,	$24,	smpsNoAttack,	$06,	nB4,	$06,	smpsNoAttack,	$24
	dc.b		smpsNoAttack,	$06,	nBb4,	$06,	smpsNoAttack,	$24,	smpsNoAttack,	$06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	izayoi_Loop0C
	dc.b		nC5,	$06,	smpsNoAttack,	$24,	smpsNoAttack,	$06,	nEb5,	$06
	dc.b		smpsNoAttack,	$24,	smpsNoAttack,	$06,	nD5,	$06,	smpsNoAttack,	$24
	dc.b		smpsNoAttack,	$06,	nCs5,	$06,	smpsNoAttack,	$24,	smpsNoAttack,	$06
	dc.b		nC5,	$06,	smpsNoAttack,	$24,	smpsNoAttack,	$06,	nEb5,	$06
	dc.b		smpsNoAttack,	$24,	smpsNoAttack,	$06,	nD5,	$06,	smpsNoAttack,	$24
	dc.b		smpsNoAttack,	$06,	nCs5,	$06,	smpsNoAttack,	$30
;	Alter Volume	value
	smpsAlterVol	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nRst,	$06,	nC4,	$0C,	nRst,	$06,	nD4,	$18
	dc.b		smpsNoAttack,	$30,	nEb4,	$06,	nD4,	nC4,	nA3,	nC4
	dc.b		nG3,	nRst,	nA3
;	Alter Volume	value
	smpsAlterVol	$FA
;	Set FM Voice	#
	smpsFMvoice	$42
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nFs4,	$03,	nG4,	nFs4,	nG4,	nFs4,	$0C
;	Alter Volume	value
	smpsAlterVol	$06
	dc.b		nRst,	$18
;	Set FM Voice	#
	smpsFMvoice	$41
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nRst,	$06,	nC4,	$0C,	nRst,	$06,	nD4,	$18
	dc.b		smpsNoAttack,	$30,	nEb4,	$06,	nD4,	nC4,	nA3,	nC4
	dc.b		nG3,	nRst,	nA3,	nRst,	$30,	nRst,	$06,	nC4
	dc.b		$0C,	nRst,	$06,	nD4,	$18,	smpsNoAttack,	$30,	nEb4
	dc.b		$06,	nD4,	nC4,	nA3,	nC4,	nG3,	nRst,	nA3
;	Alter Volume	value
	smpsAlterVol	$FA
;	Set FM Voice	#
	smpsFMvoice	$42
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nFs4,	$03,	nG4,	nFs4,	nG4,	nFs4,	$0C
;	Alter Volume	value
	smpsAlterVol	$06
	dc.b		nRst,	$18
;	Set FM Voice	#
	smpsFMvoice	$41
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nRst,	$06,	nC4,	$0C,	nRst,	$06,	nD4,	$0C
	dc.b		nRst,	$06,	nEb4,	$0C,	nRst,	$06,	nF4,	$0C
	dc.b		nRst,	$06,	nFs4,	$0C,	nRst,	$06,	nAb4,	$30
	dc.b		smpsNoAttack,	$30
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
	dc.b		nA4,	$06,	nAb4,	nFs4,	nEb4,	nFs4,	nCs4,	nRst
;	Alter Volume	value
	smpsAlterVol	$FD
	dc.b		nEb4,	$06
;	Alter Volume	value
	smpsAlterVol	$01
;	Set Modulation	wait	speed	change	step
	smpsModSet	$14,	$02,	$DF,	$AF
	dc.b		smpsNoAttack,	$60
;	Alter Volume	value
	smpsAlterVol	$02
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
	smpsReturn

; FM4 Data
izayoi_FM4:
	dc.b		nRst,	$30,	nRst
izayoi_Jump04:
	dc.b		nRst,	$30,	nRst,	nRst,	$30,	nRst,	nRst,	$30
	dc.b		nRst,	nRst,	$24,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$FC
;	Set FM Voice	#
	smpsFMvoice	$1F
	dc.b		nA3,	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$05,	$E5,	$A0
	dc.b		smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsModOn
;	Alter Volume	value
	smpsAlterVol	$04
;	Call At	 	location
	smpsCall	izayoi_Call0A
;	Call At	 	location
	smpsCall	izayoi_Call0B
;	Call At	 	location
	smpsCall	izayoi_Call0C
	dc.b		smpsNoAttack,	$12,	nRst,	$06,	nRst,	$30,	nRst,	$18
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Call At	 	location
	smpsCall	izayoi_Call0A
;	Call At	 	location
	smpsCall	izayoi_Call0B
;	Call At	 	location
	smpsCall	izayoi_Call0C
	dc.b		nRst,	$18,	nRst,	$30,	nRst,	$18
;	Alter Pitch	value
	smpsAlterPitch	$F4
	dc.b		nRst,	$30
;	Call At	 	location
	smpsCall	izayoi_Call0D
;	Call At	 	location
	smpsCall	izayoi_Call0E
;	Jump To	 	location
	smpsJump	izayoi_Jump04

izayoi_Call0A:
	dc.b		nRst,	$30,	nRst,	nRst,	$30,	nRst,	nRst,	$30
	dc.b		nRst,	nRst,	$30,	nRst,	nRst,	$30,	nRst
	smpsReturn

izayoi_Call0B:
;	Set FM Voice	#
	smpsFMvoice	$41
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0F,	$01,	$04,	$05
;	Alter Volume	value
	smpsAlterVol	$F9
izayoi_Loop0D:
;	Note Fill	duration
	smpsNoteFill	$05
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nE3,	$06
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nE3,	nE3
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nE3
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nE3,	nE3
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nE3
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nE3
;	Note Fill	duration
	smpsNoteFill	$08
	dc.b		nE3
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nG3,	smpsNoAttack,	$0C
;	Note Fill	duration
	smpsNoteFill	$00
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nC3,	$18
;	Note Fill	duration
	smpsNoteFill	$05
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nE3,	$06
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nE3,	nE3
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nE3
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nE3,	nE3
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nE3
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nE3
;	Note Fill	duration
	smpsNoteFill	$08
	dc.b		nE3
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nB3,	smpsNoAttack,	$0C
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nBb3,	$06,	nRst,	nB3,	nRst
;	Alter Volume	value
	smpsAlterVol	$02
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	izayoi_Loop0D
;	Alter Volume	value
	smpsAlterVol	$07
	smpsReturn

izayoi_Call0C:
;	Set FM Voice	#
	smpsFMvoice	$42
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$01,	$0A,	$04
	dc.b		nD3,	$30
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nD3,	$06
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD3
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nD3,	nD4
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD3,	$0C
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nD3,	$06
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD3,	smpsNoAttack,	$18
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nD3,	$06
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD3
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nD3
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD3,	smpsNoAttack,	$0C
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nD3,	$06
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD3,	$06,	smpsNoAttack,	$18,	nF3,	$30
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nF3,	$06
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nF3
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nF3,	nF4
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nF3,	$0C
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nF3,	$06
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nA2,	smpsNoAttack,	$0C
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nA2,	$06
;	Alter Volume	value
	smpsAlterVol	$FF
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nB2,	$12
;	Alter Volume	value
	smpsAlterVol	$01
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nB2,	$06
;	Alter Volume	value
	smpsAlterVol	$FE
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nCs3,	$12
;	Alter Volume	value
	smpsAlterVol	$02
;	Set FM Voice	#
	smpsFMvoice	$1F
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nCs3,	$06
;	Alter Volume	value
	smpsAlterVol	$FD
;	Set FM Voice	#
	smpsFMvoice	$42
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nEb3,	$06,	smpsNoAttack,	$18,	smpsNoAttack,	$18
;	Alter Volume	value
	smpsAlterVol	$03
	smpsReturn

izayoi_Call0D:
	dc.b		nRst,	$30,	nRst,	nRst,	$30,	nRst,	nRst,	$30
	dc.b		nRst,	nRst,	$30,	nRst,	nRst,	$30,	nRst,	nRst
	dc.b		$30,	nRst,	nRst,	$30,	nRst,	nRst,	$30,	nRst
	smpsReturn

izayoi_Call0E:
	dc.b		nRst,	$30,	nRst,	nRst,	$30,	nRst,	nRst,	$30
	dc.b		nRst,	nRst,	$30,	nRst,	nRst,	$30,	nRst,	nRst
	dc.b		$30,	nRst,	nRst,	$30,	nRst,	nRst,	$30,	nRst
	dc.b		nRst,	$30,	nRst,	nRst,	$30
	smpsReturn

; FM5 Data
izayoi_FM5:
	dc.b		nRst,	$12
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Jump To	 	location
	smpsJump	izayoi_FM1

; PSG1 Data
izayoi_PSG1:
	dc.b		nRst,	$30,	nRst
izayoi_Jump05:
;	Call At	 	location
	smpsCall	izayoi_Call0F
;	Call At	 	location
	smpsCall	izayoi_Call10
;	Call At	 	location
	smpsCall	izayoi_Call11
;	Call At	 	location
	smpsCall	izayoi_Call12
	dc.b		smpsNoAttack,	$12,	nRst,	$06,	nRst,	$30,	nRst,	$18
;	Call At	 	location
	smpsCall	izayoi_Call10
;	Call At	 	location
	smpsCall	izayoi_Call11
;	Call At	 	location
	smpsCall	izayoi_Call12
	dc.b		nRst,	$18,	nRst,	$30,	nRst,	$18,	nRst,	$2A
;	Call At	 	location
	smpsCall	izayoi_Call13
;	Call At	 	location
	smpsCall	izayoi_Call14
;	Jump To	 	location
	smpsJump	izayoi_Jump05

izayoi_Call0F:
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0C,	$02,	$02,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$08
	dc.b		nRst,	$30,	nRst,	nRst,	$30,	nRst,	nRst,	$30
	dc.b		nRst,	nRst,	$30,	nRst,	nRst
;	Alter Pitch	value
	smpsAlterPitch	$F4
	smpsReturn

izayoi_Call10:
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0C,	$02,	$02,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$08
	dc.b		nRst,	$30,	nRst,	nRst,	$30,	nRst,	nRst,	$30
	dc.b		nRst,	nRst,	$30,	nRst,	nRst,	$30,	nRst
;	Alter Pitch	value
	smpsAlterPitch	$F4
	smpsReturn

izayoi_Call11:
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0C,	$02,	$02,	$03
izayoi_Loop0E:
;	Set PSG Voice	#
	smpsPSGvoice	$08
;	Note Fill	duration
	smpsNoteFill	$05
;	Set Volume	value
	smpsSetVol	$FE
	dc.b		nE3,	$06
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nE3,	nE3
;	Set Volume	value
	smpsSetVol	$FE
	dc.b		nE3
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nE3,	nE3
;	Set Volume	value
	smpsSetVol	$FE
	dc.b		nE3
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nE3
;	Note Fill	duration
	smpsNoteFill	$08
	dc.b		nE3
;	Set Volume	value
	smpsSetVol	$FE
	dc.b		nG3,	smpsNoAttack,	$0C
;	Note Fill	duration
	smpsNoteFill	$00
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nC3,	$18
;	Note Fill	duration
	smpsNoteFill	$05
;	Set Volume	value
	smpsSetVol	$FE
	dc.b		nE3,	$06
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nE3,	nE3
;	Set Volume	value
	smpsSetVol	$FE
	dc.b		nE3
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nE3,	nE3
;	Set Volume	value
	smpsSetVol	$FE
	dc.b		nE3
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nE3
;	Note Fill	duration
	smpsNoteFill	$08
	dc.b		nE3
;	Set Volume	value
	smpsSetVol	$FE
	dc.b		nB3,	smpsNoAttack,	$0C
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nBb3,	$06,	nRst,	nB3,	nRst
;	Set Volume	value
	smpsSetVol	$02
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	izayoi_Loop0E
;	Alter Pitch	value
	smpsAlterPitch	$F4
	smpsReturn

izayoi_Call12:
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0C,	$02,	$02,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$08
	dc.b		nD3,	$30
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nD3,	$06
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD3
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nD3,	nD4
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD3,	$0C
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nD3,	$06
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD3,	smpsNoAttack,	$18
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nD3,	$06
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD3
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nD3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD3,	smpsNoAttack,	$0C
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nD3,	$06
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD3,	$06,	smpsNoAttack,	$18,	nF3,	$30
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nF3,	$06
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nF3
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nF3,	nF4
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nF3,	$0C
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nF3,	$06
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nA2,	smpsNoAttack,	$0C
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nA2,	$06
;	Set Volume	value
	smpsSetVol	$FF
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nB2,	$12
;	Set Volume	value
	smpsSetVol	$01
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nB2,	$06
;	Set Volume	value
	smpsSetVol	$FE
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nCs3,	$12
;	Set Volume	value
	smpsSetVol	$02
;	Note Fill	duration
	smpsNoteFill	$01
	dc.b		nCs3,	$06
;	Set Volume	value
	smpsSetVol	$FD
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nEb3,	$06,	smpsNoAttack,	$18,	smpsNoAttack,	$18
;	Set Volume	value
	smpsSetVol	$03
;	Alter Pitch	value
	smpsAlterPitch	$F4
	smpsReturn

izayoi_Call13:
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1C,	$02,	$03,	$02
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Set Volume	value
	smpsSetVol	$FD
;	Set PSG Voice	#
	smpsPSGvoice	$00
izayoi_Loop0F:
	dc.b		nE4,	$06,	smpsNoAttack,	$24,	smpsNoAttack,	$06,	nG4,	$06
	dc.b		smpsNoAttack,	$24,	smpsNoAttack,	$06,	nFs4,	$06,	smpsNoAttack,	$24
	dc.b		smpsNoAttack,	$06,	nF4,	$06,	smpsNoAttack,	$24,	smpsNoAttack,	$06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	izayoi_Loop0F
	dc.b		nG4,	$06,	smpsNoAttack,	$24,	smpsNoAttack,	$06,	nBb4,	$06
	dc.b		smpsNoAttack,	$24,	smpsNoAttack,	$06,	nA4,	$06,	smpsNoAttack,	$24
	dc.b		smpsNoAttack,	$06,	nAb4,	$06,	smpsNoAttack,	$24,	smpsNoAttack,	$06
	dc.b		nG4,	$06,	smpsNoAttack,	$24,	smpsNoAttack,	$06,	nBb4,	$06
	dc.b		smpsNoAttack,	$24,	smpsNoAttack,	$06,	nA4,	$06,	smpsNoAttack,	$24
	dc.b		smpsNoAttack,	$06,	nAb4,	$06,	smpsNoAttack,	$30
;	Set Volume	value
	smpsSetVol	$03
;	Alter Pitch	value
	smpsAlterPitch	$F4
	smpsReturn

izayoi_Call14:
	dc.b		nRst,	$30,	nRst,	nRst,	$30,	nRst,	nRst,	$30
	dc.b		nRst,	nRst,	$30,	nRst,	nRst,	$30,	nRst,	nRst
	dc.b		$30,	nRst,	nRst,	$30,	nRst,	nRst,	$30,	nRst
	dc.b		nRst,	$30,	nRst,	nRst,	$30
	smpsReturn

; PSG2 Data
izayoi_PSG2:
	dc.b		nRst,	$09
;	Jump To	 	location
	smpsJump	izayoi_PSG1

; PSG3 Data
izayoi_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
	dc.b		nRst,	$30,	nRst
izayoi_Jump06:
	dc.b		nRst,	$30,	nRst,	nRst,	nRst,	nRst,	$30,	nRst
	dc.b		nRst,	nRst,	nRst,	$30,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	$30,	nRst,	nRst,	nRst,	nRst,	$30,	nRst
	dc.b		nRst,	$30,	nRst,	nRst,	nRst
izayoi_Loop10:
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Note Fill	duration
	smpsNoteFill	$02
	dc.b		nA5,	$06,	nA5,	nA5,	nA5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$1D,	izayoi_Loop10
izayoi_Loop11:
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Note Fill	duration
	smpsNoteFill	$14
	dc.b		nA5,	$0C,	nA5,	nA5,	nA5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$09,	izayoi_Loop11
	dc.b		nRst,	$30
izayoi_Loop12:
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Note Fill	duration
	smpsNoteFill	$02
	dc.b		nA5,	$06,	nA5,	nA5,	nA5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$10,	izayoi_Loop12
izayoi_Loop13:
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Note Fill	duration
	smpsNoteFill	$14
	dc.b		nA5,	$0C,	nA5,	nA5,	nA5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$0B,	izayoi_Loop13
	dc.b		nRst,	$18
izayoi_Loop14:
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Note Fill	duration
	smpsNoteFill	$0F
	dc.b		nA5,	$18
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$18,	izayoi_Loop14
izayoi_Loop15:
;	Note Fill	duration
	smpsNoteFill	$02
	dc.b		nA5,	$06,	nA5,	nA5,	nA5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	izayoi_Loop15
izayoi_Loop16:
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Note Fill	duration
	smpsNoteFill	$14
	dc.b		nA5,	$0C,	nA5,	nA5,	nA5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$10,	izayoi_Loop16
	dc.b		nA5,	$06,	nA5,	nA5,	nA5,	nA5,	nA5,	nRst
;	Note Fill	duration
	smpsNoteFill	$1E
	dc.b		nA5,	$06,	smpsNoAttack,	$18,	nRst,	nRst,	$30
;	Jump To	 	location
	smpsJump	izayoi_Jump06

; DAC Data
izayoi_DAC:
	dc.b		$C1,	$08,	$C2,	$C3,	$A5,	$04,	$A6,	$A7
	dc.b		$C1,	$C1,	$C2,	dSnare,	$03,	dSnare,	dSnare,	dSnare
	dc.b		$C3,	$0C,	nRst,	$0C,	$C1,	$0C
izayoi_Jump07:
	dc.b		$C0,	$06,	$C0,	nRst,	$24,	nRst,	$30,	nRst
	dc.b		nRst,	$18,	dMidTimpani,	$06,	$C1,	$C2,	$C3,	dSnare
	dc.b		$06,	dSnare,	$C0,	$0C,	nRst,	$18,	nRst,	$30
	dc.b		nRst,	nRst,	nRst,	$24,	$C0,	$02,	$C2,	$0A
izayoi_Loop17:
	dc.b		dSnare,	$0C,	$C0,	dSnare,	$06,	dSnare,	$C0,	$0C
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$06,	izayoi_Loop17
	dc.b		dSnare,	$0C,	$C0,	dSnare,	$06,	$C1,	$C2,	$8C
	dc.b		nRst,	$30,	dSnare,	$06,	$C0,	$03,	$C0,	$C3
	dc.b		$0C,	dSnare,	$06,	$C0,	$03,	$C0,	$C0,	$C0
	dc.b		$C0,	$C0,	$C0,	$06,	dHiTimpani,	$C0,	dHiTimpani,	$C0
	dc.b		$A5,	dKick,	$03,	dKick,	$C2,	$06,	dSnare,	$0C
	dc.b		$C0,	dSnare,	$06,	dSnare,	$C0,	$0C,	dSnare,	$06
	dc.b		$8C,	$0C,	$C0,	$06,	dSnare,	dSnare,	$C0,	$0C
	dc.b		dSnare,	$0C,	$C0,	dSnare,	$06,	dSnare,	$C0,	$0C
	dc.b		dSnare,	$06,	$8C,	$0C,	$C0,	$06,	dSnare,	$0C
	dc.b		$C0,	dSnare,	$0C,	$C0,	dSnare,	$06,	dSnare,	$C0
	dc.b		$0C,	dSnare,	$06,	$8C,	$0C,	$C0,	$06,	dSnare
	dc.b		dSnare,	$C0,	$0C,	dSnare,	$0C,	$C0,	dSnare,	$06
	dc.b		dSnare,	$C0,	$0C,	dSnare,	$06,	$8C,	$0C,	$C0
	dc.b		$06,	dSnare,	$C0,	$C0,	$C0,	dSnare,	$0C,	$C0
	dc.b		dSnare,	$C0,	dSnare,	$0C,	$C0,	dSnare,	$06,	dSnare
	dc.b		$C0,	$06,	dSnare,	nRst,	dSnare,	$C0,	dSnare,	nRst
	dc.b		dSnare,	$C0,	dSnare,	nRst,	dSnare,	$C0,	dSnare,	nRst
	dc.b		dSnare,	$C0,	$0C,	dSnare,	$0C,	$C0,	dSnare,	$C0
	dc.b		dSnare,	$0C,	$C0,	dSnare,	$06,	dSnare,	$C0,	$06
	dc.b		dSnare,	nRst,	dSnare,	$C0,	dSnare,	nRst,	dSnare,	$C0
	dc.b		dSnare,	nRst,	dSnare,	$C0,	$8C,	nRst,	$18,	nRst
	dc.b		$18,	dHiTimpani,	$03,	dHiTimpani,	$C0,	$06,	$C0,	$C0
	dc.b		$C0,	$06,	$C0,	$C0,	$C0,	$C0,	$C0,	dMidTimpani
	dc.b		dMidTimpani,	$C1,	$C1,	$C2,	$C3
izayoi_Loop18:
	dc.b		dSnare,	$0C,	$C0,	dSnare,	$06,	dSnare,	$C0,	$0C
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$06,	izayoi_Loop18
	dc.b		dSnare,	$0C,	$C0,	dSnare,	$06,	$C1,	$C2,	$8C
	dc.b		nRst,	$30,	dSnare,	$06,	$C0,	$03,	$C0,	$C3
	dc.b		$0C,	dSnare,	$06,	$C0,	$03,	$C0,	$C0,	$C0
	dc.b		$C0,	$C0,	$C0,	$06,	dHiTimpani,	$C0,	dHiTimpani,	$C0
	dc.b		dHiTimpani,	dKick,	$03,	dKick,	$C2,	$06,	dSnare,	$0C
	dc.b		$C0,	dSnare,	$06,	dSnare,	$C0,	$0C,	dSnare,	$06
	dc.b		$8C,	$0C,	$C0,	$06,	dSnare,	dSnare,	$C0,	$0C
	dc.b		dSnare,	$0C,	$C0,	dSnare,	$06,	dSnare,	$C0,	$0C
	dc.b		dSnare,	$06,	$8C,	$0C,	$C0,	$06,	dSnare,	$0C
	dc.b		$C0,	dSnare,	$0C,	$C0,	dSnare,	$06,	dSnare,	$C0
	dc.b		$0C,	dSnare,	$06,	$8C,	$0C,	$C0,	$06,	dSnare
	dc.b		dSnare,	$C0,	$0C,	dSnare,	$0C,	$C0,	dSnare,	$06
	dc.b		dSnare,	$C0,	$0C,	dSnare,	$06,	$8C,	$0C,	$C0
	dc.b		$06,	dSnare,	$C0,	$C0,	$C0,	dSnare,	$0C,	$C0
	dc.b		dSnare,	$C0,	dSnare,	$0C,	$C0,	dSnare,	$06,	dSnare
	dc.b		$C0,	$06,	dSnare,	nRst,	dSnare,	$C0,	dSnare,	nRst
	dc.b		dSnare,	$C0,	dSnare,	nRst,	dSnare,	$C0,	dSnare,	nRst
	dc.b		dSnare,	$C0,	$0C,	dSnare,	$0C,	$C0,	dSnare,	$C0
	dc.b		dSnare,	$0C,	$C0,	dSnare,	$06,	dSnare,	$C0,	$06
	dc.b		dSnare,	nRst,	dSnare,	$C0,	dSnare,	nRst,	dSnare,	$C0
	dc.b		dSnare,	nRst,	dSnare,	$C0,	$8C,	nRst,	$18,	nRst
	dc.b		$18,	$8C,	$0C,	nRst,	nRst,	$30,	nRst,	$0C
	dc.b		$C0,	$04,	$C0,	$8C,	nRst,	$18,	$8C,	$06
	dc.b		$C0,	$03,	$C0,	$C1,	$06,	$8C,	$06,	nRst
	dc.b		dSnare,	$C0,	$0C,	dSnare,	$C0,	$06,	$8C,	$06
	dc.b		nRst,	dSnare,	$C0,	$0C,	dSnare,	$C0,	$06,	$8C
	dc.b		$06,	nRst,	dSnare,	$C0,	$0C,	dSnare,	$C0,	$06
	dc.b		$8C,	$06,	nRst,	dSnare,	$C0,	$0C,	dSnare,	$C0
	dc.b		$06,	$8C,	$06,	nRst,	dSnare,	$C0,	$0C,	dSnare
	dc.b		$C0,	$06,	$8C,	$06,	nRst,	dSnare,	$C0,	$0C
	dc.b		dSnare,	$C0,	$06,	$8C,	$06,	nRst,	dSnare,	$C0
	dc.b		$0C,	dSnare,	$C0,	$06,	$8C,	$06,	nRst,	dSnare
	dc.b		$C0,	dSnare,	$C0,	$C0,	$C0,	$8C,	$06,	nRst
	dc.b		dSnare,	$C0,	$0C,	dSnare,	$C0,	$06,	$8C,	$06
	dc.b		nRst,	dSnare,	$C0,	$0C,	dSnare,	$C0,	$06,	$8C
	dc.b		$06,	nRst,	dSnare,	$C0,	$0C,	dSnare,	$C0,	$06
	dc.b		$8C,	$06,	nRst,	dSnare,	$C0,	$0C,	dSnare,	$C0
	dc.b		$06,	$8C,	$06,	nRst,	dSnare,	$C0,	$0C,	dSnare
	dc.b		$C0,	$06,	$8C,	$06,	nRst,	dSnare,	$C0,	$0C
	dc.b		dSnare,	$C0,	$06,	$8C,	$06,	nRst,	dSnare,	$C0
	dc.b		$0C,	dSnare,	$C0,	$06,	$8C,	$06,	nRst,	$C0
	dc.b		$C0,	$C0,	$C0,	$C0,	$C0,	$C0
izayoi_Loop19:
	dc.b		dSnare,	$0C,	$C0,	dSnare,	$C0,	dSnare,	$C0,	dSnare
	dc.b		$06,	dSnare,	$C0,	$0C,	dSnare,	$0C,	$C0,	dSnare
	dc.b		$06,	dSnare,	$C0,	$8C,	nRst,	dSnare,	$C0,	$0C
	dc.b		dSnare,	$06,	dSnare,	$C0,	$0C
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	izayoi_Loop19
	dc.b		dSnare,	$06,	$8C,	$0C,	dSnare,	$06,	$C0,	$C0
	dc.b		dSnare,	$06,	$8C,	$0C,	dSnare,	$06,	$C0,	$C0
	dc.b		dSnare,	$06,	$8C,	$0C,	dSnare,	$06,	$8C,	$0C
	dc.b		$C0,	dSnare,	$06,	dSnare,	$C0,	$0C,	dSnare,	$06
	dc.b		dSnare,	$C0,	$0C,	dSnare,	$06,	dSnare,	$C0,	$0C
	dc.b		$C0,	$06,	$C0,	$C0,	$C0,	$C0,	$C0,	nRst
	dc.b		$8C,	nRst,	$06,	dSnare,	$C0,	$0C,	dSnare,	$C1
	dc.b		dHiTimpani,	$04,	dHiTimpani,	dHiTimpani,	dHiTimpani,	dHiTimpani,	dHiTimpani,	$C0
	dc.b		$C0,	$C0,	$C0,	$C0,	$C0
;	Jump To	 	location
	smpsJump	izayoi_Jump07

izayoi_Voices:
;	Voice 00
;	$06,$01,$33,$72,$31,$0A,$8C,$4C,$52,$00,$00,$00,$00,$01,$00,$01,$00,$03,$05,$26,$06,$4D,$87,$80,$91
;				#
	smpsVcAlgorithm		$06
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$07,	$03,	$00
	smpsVcCoarseFreq	$01,	$02,	$03,	$01
	smpsVcRateScale		$01,	$01,	$02,	$00
	smpsVcAttackRate	$12,	$0C,	$0C,	$0A
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$00,	$00,	$00
	smpsVcDecayRate2	$00,	$01,	$00,	$01
	smpsVcDecayLevel	$00,	$02,	$00,	$00
	smpsVcReleaseRate	$06,	$06,	$05,	$03
	smpsVcTotalLevel	$91,	$80,	$87,	$4D

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
;	$15,$71,$72,$31,$31,$0F,$12,$0F,$0F,$00,$0F,$09,$0A,$01,$02,$01,$01,$06,$A7,$06,$07,$32,$80,$A8,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$02
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$07,	$07
	smpsVcCoarseFreq	$01,	$01,	$02,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$0F,	$0F,	$12,	$0F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$09,	$0F,	$00
	smpsVcDecayRate2	$01,	$01,	$02,	$01
	smpsVcDecayLevel	$00,	$00,	$0A,	$00
	smpsVcReleaseRate	$07,	$06,	$07,	$06
	smpsVcTotalLevel	$80,	$A8,	$80,	$32

;	Voice 03
;	$16,$7A,$74,$3C,$31,$1F,$1F,$1F,$1F,$0A,$08,$0C,$0A,$07,$0A,$07,$05,$25,$A7,$A7,$55,$14,$85,$8A,$80
;				#
	smpsVcAlgorithm		$06
	smpsVcFeedback		$02
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$07,	$07
	smpsVcCoarseFreq	$01,	$0C,	$04,	$0A
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$0C,	$08,	$0A
	smpsVcDecayRate2	$05,	$07,	$0A,	$07
	smpsVcDecayLevel	$05,	$0A,	$0A,	$02
	smpsVcReleaseRate	$05,	$07,	$07,	$05
	smpsVcTotalLevel	$80,	$8A,	$85,	$14

;	Voice 04
;	$3A,$0C,$1F,$01,$13,$1F,$DF,$1F,$9F,$0C,$02,$0C,$05,$04,$04,$04,$07,$1A,$F6,$06,$27,$1D,$36,$1B,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$01,	$00,	$01,	$00
	smpsVcCoarseFreq	$03,	$01,	$0F,	$0C
	smpsVcRateScale		$02,	$00,	$03,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$0C,	$02,	$0C
	smpsVcDecayRate2	$07,	$04,	$04,	$04
	smpsVcDecayLevel	$02,	$00,	$0F,	$01
	smpsVcReleaseRate	$07,	$06,	$06,	$0A
	smpsVcTotalLevel	$80,	$1B,	$36,	$1D

;	Voice 05
;	$3E,$0F,$02,$32,$72,$1F,$1F,$1F,$1F,$00,$18,$00,$00,$00,$0F,$0F,$0F,$20,$97,$08,$08,$00,$80,$80,$80
;				#
	smpsVcAlgorithm		$06
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$00,	$00
	smpsVcCoarseFreq	$02,	$02,	$02,	$0F
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$00,	$18,	$00
	smpsVcDecayRate2	$0F,	$0F,	$0F,	$00
	smpsVcDecayLevel	$00,	$00,	$09,	$02
	smpsVcReleaseRate	$08,	$08,	$07,	$00
	smpsVcTotalLevel	$80,	$80,	$80,	$00

;	Voice 06
;	$3A,$32,$02,$02,$72,$8F,$8F,$4F,$4D,$09,$09,$00,$03,$00,$00,$00,$00,$15,$F5,$05,$08,$19,$1F,$19,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$00,	$00,	$03
	smpsVcCoarseFreq	$02,	$02,	$02,	$02
	smpsVcRateScale		$01,	$01,	$02,	$02
	smpsVcAttackRate	$0D,	$0F,	$0F,	$0F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$03,	$00,	$09,	$09
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$00,	$0F,	$01
	smpsVcReleaseRate	$08,	$05,	$05,	$05
	smpsVcTotalLevel	$80,	$19,	$1F,	$19

;	Voice 07
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

;	Voice 08
;	$3A,$60,$66,$60,$61,$1F,$94,$1F,$1F,$0F,$10,$05,$0D,$07,$06,$06,$07,$2F,$4F,$1F,$5F,$21,$14,$22,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$06,	$06,	$06,	$06
	smpsVcCoarseFreq	$01,	$00,	$06,	$00
	smpsVcRateScale		$00,	$00,	$02,	$00
	smpsVcAttackRate	$1F,	$1F,	$14,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0D,	$05,	$10,	$0F
	smpsVcDecayRate2	$07,	$06,	$06,	$07
	smpsVcDecayLevel	$05,	$01,	$04,	$02
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$22,	$14,	$21

;	Voice 09
;	$3C,$52,$36,$63,$52,$DF,$59,$CF,$8A,$0A,$0A,$01,$05,$14,$14,$0A,$14,$AF,$5F,$AF,$5F,$1E,$85,$28,$82
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$05,	$06,	$03,	$05
	smpsVcCoarseFreq	$02,	$03,	$06,	$02
	smpsVcRateScale		$02,	$03,	$01,	$03
	smpsVcAttackRate	$0A,	$0F,	$19,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$01,	$0A,	$0A
	smpsVcDecayRate2	$14,	$0A,	$14,	$14
	smpsVcDecayLevel	$05,	$0A,	$05,	$0A
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$82,	$28,	$85,	$1E

;	Voice 0A
;	$0C,$00,$00,$06,$01,$1B,$59,$DA,$59,$02,$06,$02,$0C,$0A,$0A,$09,$0F,$14,$15,$02,$A5,$14,$80,$1A,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$01
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$06,	$00,	$00
	smpsVcRateScale		$01,	$03,	$01,	$00
	smpsVcAttackRate	$19,	$1A,	$19,	$1B
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0C,	$02,	$06,	$02
	smpsVcDecayRate2	$0F,	$09,	$0A,	$0A
	smpsVcDecayLevel	$0A,	$00,	$01,	$01
	smpsVcReleaseRate	$05,	$02,	$05,	$04
	smpsVcTotalLevel	$80,	$1A,	$80,	$14

;	Voice 0B
;	$3B,$61,$02,$24,$05,$5F,$5F,$5F,$4F,$03,$03,$03,$07,$00,$00,$00,$04,$23,$22,$22,$27,$1F,$20,$25,$80
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$02,	$00,	$06
	smpsVcCoarseFreq	$05,	$04,	$02,	$01
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$0F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$07,	$03,	$03,	$03
	smpsVcDecayRate2	$04,	$00,	$00,	$00
	smpsVcDecayLevel	$02,	$02,	$02,	$02
	smpsVcReleaseRate	$07,	$02,	$02,	$03
	smpsVcTotalLevel	$80,	$25,	$20,	$1F

;	Voice 0C
;	$3D,$01,$02,$02,$02,$10,$50,$50,$50,$07,$08,$08,$08,$01,$00,$00,$00,$24,$18,$18,$18,$1C,$89,$89,$89
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$02,	$02,	$02,	$01
	smpsVcRateScale		$01,	$01,	$01,	$00
	smpsVcAttackRate	$10,	$10,	$10,	$10
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$08,	$08,	$08,	$07
	smpsVcDecayRate2	$00,	$00,	$00,	$01
	smpsVcDecayLevel	$01,	$01,	$01,	$02
	smpsVcReleaseRate	$08,	$08,	$08,	$04
	smpsVcTotalLevel	$89,	$89,	$89,	$1C

;	Voice 0D
;	$3C,$21,$02,$01,$62,$CF,$0D,$CF,$0C,$00,$04,$00,$04,$00,$00,$00,$00,$02,$37,$02,$38,$1E,$80,$1F,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$06,	$00,	$00,	$02
	smpsVcCoarseFreq	$02,	$01,	$02,	$01
	smpsVcRateScale		$00,	$03,	$00,	$03
	smpsVcAttackRate	$0C,	$0F,	$0D,	$0F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$04,	$00,	$04,	$00
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$03,	$00,	$03,	$00
	smpsVcReleaseRate	$08,	$02,	$07,	$02
	smpsVcTotalLevel	$80,	$1F,	$80,	$1E

;	Voice 0E
;	$34,$33,$41,$7E,$74,$5B,$9F,$5F,$1F,$04,$07,$07,$08,$00,$00,$00,$00,$FF,$FF,$EF,$FF,$23,$90,$29,$97
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$07,	$04,	$03
	smpsVcCoarseFreq	$04,	$0E,	$01,	$03
	smpsVcRateScale		$00,	$01,	$02,	$01
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1B
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$08,	$07,	$07,	$04
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$0F,	$0E,	$0F,	$0F
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$97,	$29,	$90,	$23

;	Voice 0F
;	$3E,$34,$00,$75,$02,$5E,$DF,$5F,$9C,$0F,$04,$0F,$0A,$02,$02,$05,$05,$A7,$A2,$FA,$F6,$28,$80,$A3,$80
;				#
	smpsVcAlgorithm		$06
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$07,	$00,	$03
	smpsVcCoarseFreq	$02,	$05,	$00,	$04
	smpsVcRateScale		$02,	$01,	$03,	$01
	smpsVcAttackRate	$1C,	$1F,	$1F,	$1E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$0F,	$04,	$0F
	smpsVcDecayRate2	$05,	$05,	$02,	$02
	smpsVcDecayLevel	$0F,	$0F,	$0A,	$0A
	smpsVcReleaseRate	$06,	$0A,	$02,	$07
	smpsVcTotalLevel	$80,	$A3,	$80,	$28

;	Voice 10
;	$3A,$01,$02,$01,$01,$14,$14,$17,$14,$0A,$0C,$03,$07,$02,$08,$08,$03,$07,$F9,$A8,$18,$1C,$2B,$28,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$02,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$14,	$17,	$14,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$07,	$03,	$0C,	$0A
	smpsVcDecayRate2	$03,	$08,	$08,	$02
	smpsVcDecayLevel	$01,	$0A,	$0F,	$00
	smpsVcReleaseRate	$08,	$08,	$09,	$07
	smpsVcTotalLevel	$80,	$28,	$2B,	$1C

;	Voice 11
;	$3A,$01,$07,$01,$01,$0F,$0F,$0F,$14,$0A,$0A,$0A,$05,$02,$02,$02,$02,$56,$A6,$56,$18,$19,$28,$28,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$07,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$14,	$0F,	$0F,	$0F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$0A,	$0A,	$0A
	smpsVcDecayRate2	$02,	$02,	$02,	$02
	smpsVcDecayLevel	$01,	$05,	$0A,	$05
	smpsVcReleaseRate	$08,	$06,	$06,	$06
	smpsVcTotalLevel	$80,	$28,	$28,	$19

;	Voice 12
;	$38,$0F,$0F,$0F,$0F,$1F,$1F,$1F,$11,$00,$00,$00,$0E,$00,$00,$00,$19,$03,$03,$03,$1A,$07,$07,$07,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$0F,	$0F,	$0F,	$0F
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$11,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0E,	$00,	$00,	$00
	smpsVcDecayRate2	$19,	$00,	$00,	$00
	smpsVcDecayLevel	$01,	$00,	$00,	$00
	smpsVcReleaseRate	$0A,	$03,	$03,	$03
	smpsVcTotalLevel	$80,	$07,	$07,	$07

;	Voice 13
;	$3C,$03,$01,$01,$01,$1F,$1F,$1F,$1F,$12,$0F,$14,$0F,$01,$0F,$0C,$0F,$17,$F9,$F7,$F9,$00,$81,$05,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$03
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$14,	$0F,	$12
	smpsVcDecayRate2	$0F,	$0C,	$0F,	$01
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$01
	smpsVcReleaseRate	$09,	$07,	$09,	$07
	smpsVcTotalLevel	$80,	$05,	$81,	$00

;	Voice 14
;	$00,$00,$03,$02,$00,$DF,$DF,$1F,$1F,$12,$11,$14,$0E,$0A,$00,$0A,$0D,$F3,$F6,$F3,$F8,$22,$07,$27,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$00,	$02,	$03,	$00
	smpsVcRateScale		$00,	$00,	$03,	$03
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0E,	$14,	$11,	$12
	smpsVcDecayRate2	$0D,	$0A,	$00,	$0A
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$08,	$03,	$06,	$03
	smpsVcTotalLevel	$80,	$27,	$07,	$22

;	Voice 15
;	$3B,$08,$04,$0F,$0C,$1F,$1F,$1F,$1F,$1F,$1F,$1C,$1F,$00,$04,$00,$06,$10,$10,$00,$07,$0D,$21,$4D,$80
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$0C,	$0F,	$04,	$08
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$1C,	$1F,	$1F
	smpsVcDecayRate2	$06,	$00,	$04,	$00
	smpsVcDecayLevel	$00,	$00,	$01,	$01
	smpsVcReleaseRate	$07,	$00,	$00,	$00
	smpsVcTotalLevel	$80,	$4D,	$21,	$0D

;	Voice 16
;	$3B,$61,$02,$23,$02,$59,$59,$59,$4A,$03,$03,$03,$05,$00,$00,$00,$00,$22,$22,$22,$27,$1E,$20,$25,$80
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$02,	$00,	$06
	smpsVcCoarseFreq	$02,	$03,	$02,	$01
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$0A,	$19,	$19,	$19
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$03,	$03,	$03
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$02,	$02,	$02,	$02
	smpsVcReleaseRate	$07,	$02,	$02,	$02
	smpsVcTotalLevel	$80,	$25,	$20,	$1E

;	Voice 17
;	$38,$6A,$0A,$11,$02,$19,$18,$0F,$0F,$05,$08,$02,$08,$00,$00,$00,$00,$A6,$16,$16,$17,$1C,$2D,$28,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$01,	$00,	$06
	smpsVcCoarseFreq	$02,	$01,	$0A,	$0A
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$0F,	$0F,	$18,	$19
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$08,	$02,	$08,	$05
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$01,	$01,	$01,	$0A
	smpsVcReleaseRate	$07,	$06,	$06,	$06
	smpsVcTotalLevel	$80,	$28,	$2D,	$1C

;	Voice 18
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

;	Voice 19
;	$2C,$71,$71,$31,$31,$5F,$54,$5F,$5F,$05,$0A,$03,$0C,$00,$03,$00,$03,$00,$87,$00,$A7,$17,$80,$19,$82
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$07,	$07
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$1F,	$1F,	$14,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0C,	$03,	$0A,	$05
	smpsVcDecayRate2	$03,	$00,	$03,	$00
	smpsVcDecayLevel	$0A,	$00,	$08,	$00
	smpsVcReleaseRate	$07,	$00,	$07,	$00
	smpsVcTotalLevel	$82,	$19,	$80,	$17

;	Voice 1A
;	$3A,$01,$03,$02,$03,$D6,$D6,$16,$11,$08,$08,$0A,$09,$00,$0C,$01,$01,$33,$33,$13,$07,$18,$18,$2F,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$03,	$02,	$03,	$01
	smpsVcRateScale		$00,	$00,	$03,	$03
	smpsVcAttackRate	$11,	$16,	$16,	$16
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$09,	$0A,	$08,	$08
	smpsVcDecayRate2	$01,	$01,	$0C,	$00
	smpsVcDecayLevel	$00,	$01,	$03,	$03
	smpsVcReleaseRate	$07,	$03,	$03,	$03
	smpsVcTotalLevel	$80,	$2F,	$18,	$18

;	Voice 1B
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

;	Voice 1C
;	$3A,$31,$37,$31,$31,$8D,$8D,$8E,$53,$0E,$0E,$0E,$03,$00,$00,$00,$00,$1F,$FF,$1F,$0F,$17,$25,$23,$80
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
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$01,	$0F,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$23,	$25,	$17

;	Voice 1D
;	$3A,$41,$45,$32,$41,$59,$59,$5C,$4E,$0A,$0B,$0D,$04,$00,$00,$00,$00,$1F,$5F,$2F,$0F,$1D,$0F,$20,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$04,	$03,	$04,	$04
	smpsVcCoarseFreq	$01,	$02,	$05,	$01
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$0E,	$1C,	$19,	$19
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$04,	$0D,	$0B,	$0A
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$02,	$05,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$20,	$0F,	$1D

;	Voice 1E
;	$2A,$21,$39,$31,$74,$1E,$1F,$1F,$1F,$17,$1B,$02,$03,$00,$08,$03,$0B,$3F,$3F,$0F,$6F,$11,$0C,$1C,$8A
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$02
	smpsVcCoarseFreq	$04,	$01,	$09,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$03,	$02,	$1B,	$17
	smpsVcDecayRate2	$0B,	$03,	$08,	$00
	smpsVcDecayLevel	$06,	$00,	$03,	$03
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$8A,	$1C,	$0C,	$11

;	Voice 1F
;	$3D,$0A,$65,$14,$31,$8E,$52,$14,$4C,$08,$08,$0E,$03,$00,$00,$00,$00,$1F,$1B,$1F,$16,$10,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$01,	$06,	$00
	smpsVcCoarseFreq	$01,	$04,	$05,	$0A
	smpsVcRateScale		$01,	$00,	$01,	$02
	smpsVcAttackRate	$0C,	$14,	$12,	$0E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$03,	$0E,	$08,	$08
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$06,	$0F,	$0B,	$0F
	smpsVcTotalLevel	$80,	$80,	$80,	$10

;	Voice 20
;	$02,$00,$00,$00,$00,$5C,$54,$1C,$D0,$0C,$08,$0A,$05,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$24,$1B,$22,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$00,	$00,	$00,	$00
	smpsVcRateScale		$03,	$00,	$01,	$01
	smpsVcAttackRate	$10,	$1C,	$14,	$1C
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$0A,	$08,	$0C
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$22,	$1B,	$24

;	Voice 21
;	$39,$01,$51,$00,$00,$1F,$5F,$5F,$5F,$10,$11,$09,$09,$07,$00,$00,$00,$CF,$FF,$FF,$FF,$1C,$1D,$1F,$80
;				#
	smpsVcAlgorithm		$01
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$05,	$00
	smpsVcCoarseFreq	$00,	$00,	$01,	$01
	smpsVcRateScale		$01,	$01,	$01,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$09,	$09,	$11,	$10
	smpsVcDecayRate2	$00,	$00,	$00,	$07
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0C
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$1F,	$1D,	$1C

;	Voice 22
;	$2C,$61,$03,$01,$33,$5F,$94,$5F,$94,$05,$05,$05,$07,$02,$02,$02,$02,$1F,$6F,$1F,$AF,$1E,$80,$1E,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$00,	$00,	$06
	smpsVcCoarseFreq	$03,	$01,	$03,	$01
	smpsVcRateScale		$02,	$01,	$02,	$01
	smpsVcAttackRate	$14,	$1F,	$14,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$07,	$05,	$05,	$05
	smpsVcDecayRate2	$02,	$02,	$02,	$02
	smpsVcDecayLevel	$0A,	$01,	$06,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$1E,	$80,	$1E

;	Voice 23
;	$3D,$01,$02,$02,$02,$1F,$08,$8A,$0A,$08,$08,$08,$08,$00,$01,$00,$00,$0F,$1F,$1F,$1F,$1F,$88,$88,$87
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$02,	$02,	$02,	$01
	smpsVcRateScale		$00,	$02,	$00,	$00
	smpsVcAttackRate	$0A,	$0A,	$08,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$08,	$08,	$08,	$08
	smpsVcDecayRate2	$00,	$00,	$01,	$00
	smpsVcDecayLevel	$01,	$01,	$01,	$00
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$87,	$88,	$88,	$1F

;	Voice 24
;	$3B,$03,$01,$30,$01,$1C,$DC,$DC,$5E,$14,$13,$0F,$0C,$0C,$05,$0A,$07,$AF,$AF,$5F,$6F,$16,$11,$11,$80
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$03,	$00,	$00
	smpsVcCoarseFreq	$01,	$00,	$01,	$03
	smpsVcRateScale		$01,	$03,	$03,	$00
	smpsVcAttackRate	$1E,	$1C,	$1C,	$1C
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0C,	$0F,	$13,	$14
	smpsVcDecayRate2	$07,	$0A,	$05,	$0C
	smpsVcDecayLevel	$06,	$05,	$0A,	$0A
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$11,	$11,	$16

;	Voice 25
;	$3D,$08,$01,$01,$01,$1F,$1F,$1F,$1F,$19,$19,$19,$11,$05,$11,$00,$0F,$0F,$7F,$FF,$FF,$00,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$08
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$11,	$19,	$19,	$19
	smpsVcDecayRate2	$0F,	$00,	$11,	$05
	smpsVcDecayLevel	$0F,	$0F,	$07,	$00
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$80,	$80,	$00

;	Voice 26
;	$3A,$60,$66,$60,$61,$1F,$94,$1F,$1F,$0F,$10,$05,$0D,$07,$06,$06,$07,$2F,$4F,$1F,$5F,$21,$14,$28,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$06,	$06,	$06,	$06
	smpsVcCoarseFreq	$01,	$00,	$06,	$00
	smpsVcRateScale		$00,	$00,	$02,	$00
	smpsVcAttackRate	$1F,	$1F,	$14,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0D,	$05,	$10,	$0F
	smpsVcDecayRate2	$07,	$06,	$06,	$07
	smpsVcDecayLevel	$05,	$01,	$04,	$02
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$28,	$14,	$21

;	Voice 27
;	$00,$60,$32,$32,$30,$06,$06,$08,$0E,$06,$00,$00,$04,$02,$00,$00,$04,$3F,$2F,$2F,$4F,$10,$19,$1A,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$03,	$06
	smpsVcCoarseFreq	$00,	$02,	$02,	$00
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$0E,	$08,	$06,	$06
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$04,	$00,	$00,	$06
	smpsVcDecayRate2	$04,	$00,	$00,	$02
	smpsVcDecayLevel	$04,	$02,	$02,	$03
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$1A,	$19,	$10

;	Voice 28
;	$3C,$78,$78,$34,$34,$1F,$12,$1F,$1F,$00,$0F,$00,$0F,$00,$01,$00,$01,$0F,$3F,$0F,$3F,$21,$90,$18,$87
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$07,	$07
	smpsVcCoarseFreq	$04,	$04,	$08,	$08
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$12,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$00,	$0F,	$00
	smpsVcDecayRate2	$01,	$00,	$01,	$00
	smpsVcDecayLevel	$03,	$00,	$03,	$00
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$87,	$18,	$90,	$21

;	Voice 29
;	$3C,$78,$78,$34,$34,$1F,$12,$1F,$1F,$00,$0F,$00,$0F,$00,$09,$00,$09,$0F,$3F,$0F,$3F,$21,$90,$18,$87
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$07,	$07
	smpsVcCoarseFreq	$04,	$04,	$08,	$08
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$12,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$00,	$0F,	$00
	smpsVcDecayRate2	$09,	$00,	$09,	$00
	smpsVcDecayLevel	$03,	$00,	$03,	$00
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$87,	$18,	$90,	$21

;	Voice 2A
;	$2C,$72,$72,$32,$32,$1F,$12,$1F,$1F,$00,$0F,$00,$0F,$00,$09,$00,$09,$0F,$3F,$0F,$3F,$0E,$88,$0E,$88
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$07,	$07
	smpsVcCoarseFreq	$02,	$02,	$02,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$12,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$00,	$0F,	$00
	smpsVcDecayRate2	$09,	$00,	$09,	$00
	smpsVcDecayLevel	$03,	$00,	$03,	$00
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$88,	$0E,	$88,	$0E

;	Voice 2B
;	$3C,$52,$36,$63,$52,$DF,$59,$CF,$8A,$0A,$0A,$01,$05,$14,$14,$0A,$14,$AF,$5F,$AF,$5F,$1E,$85,$28,$82
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$05,	$06,	$03,	$05
	smpsVcCoarseFreq	$02,	$03,	$06,	$02
	smpsVcRateScale		$02,	$03,	$01,	$03
	smpsVcAttackRate	$0A,	$0F,	$19,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$01,	$0A,	$0A
	smpsVcDecayRate2	$14,	$0A,	$14,	$14
	smpsVcDecayLevel	$05,	$0A,	$05,	$0A
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$82,	$28,	$85,	$1E

;	Voice 2C
;	$38,$20,$62,$70,$30,$14,$12,$0A,$0A,$0E,$0E,$09,$1F,$00,$00,$00,$00,$5F,$5F,$AF,$0F,$1C,$28,$14,$85
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$07,	$06,	$02
	smpsVcCoarseFreq	$00,	$00,	$02,	$00
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$0A,	$0A,	$12,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$09,	$0E,	$0E
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$0A,	$05,	$05
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$85,	$14,	$28,	$1C

;	Voice 2D
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

;	Voice 2E
;	$1C,$6B,$33,$37,$92,$DF,$DF,$5F,$DF,$0E,$07,$10,$0F,$00,$0B,$05,$04,$FF,$17,$AF,$1F,$14,$80,$27,$85
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$03
;				op1	op2	op3	op4
	smpsVcDetune		$09,	$03,	$03,	$06
	smpsVcCoarseFreq	$02,	$07,	$03,	$0B
	smpsVcRateScale		$03,	$01,	$03,	$03
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$10,	$07,	$0E
	smpsVcDecayRate2	$04,	$05,	$0B,	$00
	smpsVcDecayLevel	$01,	$0A,	$01,	$0F
	smpsVcReleaseRate	$0F,	$0F,	$07,	$0F
	smpsVcTotalLevel	$85,	$27,	$80,	$14

;	Voice 2F
;	$2A,$21,$39,$31,$74,$1E,$1F,$1F,$1F,$17,$1B,$02,$03,$00,$08,$03,$0B,$3F,$3F,$0F,$6F,$1A,$0D,$27,$87
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$02
	smpsVcCoarseFreq	$04,	$01,	$09,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$03,	$02,	$1B,	$17
	smpsVcDecayRate2	$0B,	$03,	$08,	$00
	smpsVcDecayLevel	$06,	$00,	$03,	$03
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$87,	$27,	$0D,	$1A

;	Voice 30
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

;	Voice 31
;	$3D,$65,$28,$02,$61,$DF,$1F,$1F,$1F,$12,$04,$0F,$0F,$00,$00,$00,$00,$2F,$0F,$0F,$0F,$27,$91,$9B,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$06,	$00,	$02,	$06
	smpsVcCoarseFreq	$01,	$02,	$08,	$05
	smpsVcRateScale		$00,	$00,	$00,	$03
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$0F,	$04,	$12
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$00,	$00,	$02
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$9B,	$91,	$27

;	Voice 32
;	$1F,$16,$61,$03,$52,$1C,$9F,$1F,$1F,$12,$0F,$0F,$0F,$00,$00,$00,$00,$FF,$0F,$0F,$0F,$91,$8A,$8A,$80
;				#
	smpsVcAlgorithm		$07
	smpsVcFeedback		$03
;				op1	op2	op3	op4
	smpsVcDetune		$05,	$00,	$06,	$01
	smpsVcCoarseFreq	$02,	$03,	$01,	$06
	smpsVcRateScale		$00,	$00,	$02,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1C
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$0F,	$0F,	$12
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$00,	$00,	$0F
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$8A,	$8A,	$91

;	Voice 33
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

;	Voice 34
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

;	Voice 35
;	$3A,$42,$4A,$32,$42,$5C,$53,$5C,$4D,$07,$09,$07,$04,$00,$00,$00,$00,$1F,$3F,$1F,$0F,$1B,$18,$33,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$04,	$03,	$04,	$04
	smpsVcCoarseFreq	$02,	$02,	$0A,	$02
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$0D,	$1C,	$13,	$1C
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$04,	$07,	$09,	$07
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$01,	$03,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$33,	$18,	$1B

;	Voice 36
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

;	Voice 37
;	$30,$31,$3A,$30,$31,$9E,$D8,$DC,$DC,$0E,$0A,$01,$05,$08,$08,$08,$08,$BF,$B6,$B6,$BA,$14,$2F,$14,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$03,	$03
	smpsVcCoarseFreq	$01,	$00,	$0A,	$01
	smpsVcRateScale		$03,	$03,	$03,	$02
	smpsVcAttackRate	$1C,	$1C,	$18,	$1E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$01,	$0A,	$0E
	smpsVcDecayRate2	$08,	$08,	$08,	$08
	smpsVcDecayLevel	$0B,	$0B,	$0B,	$0B
	smpsVcReleaseRate	$0A,	$06,	$06,	$0F
	smpsVcTotalLevel	$80,	$14,	$2F,	$14

;	Voice 38
;	$3A,$41,$45,$32,$41,$59,$4F,$5C,$4E,$0A,$0B,$0D,$04,$00,$01,$00,$00,$1F,$5F,$2F,$08,$1D,$0F,$20,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$04,	$03,	$04,	$04
	smpsVcCoarseFreq	$01,	$02,	$05,	$01
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$0E,	$1C,	$0F,	$19
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$04,	$0D,	$0B,	$0A
	smpsVcDecayRate2	$00,	$00,	$01,	$00
	smpsVcDecayLevel	$00,	$02,	$05,	$01
	smpsVcReleaseRate	$08,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$20,	$0F,	$1D

;	Voice 39
;	$30,$30,$3A,$30,$31,$9E,$D8,$DC,$DC,$0E,$0A,$01,$05,$08,$08,$08,$08,$B6,$B6,$B6,$B6,$14,$2F,$14,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$03,	$03
	smpsVcCoarseFreq	$01,	$00,	$0A,	$00
	smpsVcRateScale		$03,	$03,	$03,	$02
	smpsVcAttackRate	$1C,	$1C,	$18,	$1E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$01,	$0A,	$0E
	smpsVcDecayRate2	$08,	$08,	$08,	$08
	smpsVcDecayLevel	$0B,	$0B,	$0B,	$0B
	smpsVcReleaseRate	$06,	$06,	$06,	$06
	smpsVcTotalLevel	$80,	$14,	$2F,	$14

;	Voice 3A
;	$3A,$32,$02,$02,$72,$8F,$8F,$4F,$4D,$09,$09,$00,$03,$00,$00,$00,$00,$15,$F5,$05,$08,$19,$1F,$19,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$00,	$00,	$03
	smpsVcCoarseFreq	$02,	$02,	$02,	$02
	smpsVcRateScale		$01,	$01,	$02,	$02
	smpsVcAttackRate	$0D,	$0F,	$0F,	$0F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$03,	$00,	$09,	$09
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$00,	$0F,	$01
	smpsVcReleaseRate	$08,	$05,	$05,	$05
	smpsVcTotalLevel	$80,	$19,	$1F,	$19

;	Voice 3B
;	$3A,$20,$29,$20,$01,$1E,$1F,$1F,$1F,$0A,$0A,$0B,$0A,$05,$07,$0A,$08,$A4,$85,$96,$77,$21,$25,$28,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$02,	$02,	$02
	smpsVcCoarseFreq	$01,	$00,	$09,	$00
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$0B,	$0A,	$0A
	smpsVcDecayRate2	$08,	$0A,	$07,	$05
	smpsVcDecayLevel	$07,	$09,	$08,	$0A
	smpsVcReleaseRate	$07,	$06,	$05,	$04
	smpsVcTotalLevel	$80,	$28,	$25,	$21

;	Voice 3C
;	$3F,$14,$04,$12,$01,$1F,$1F,$1F,$1F,$00,$00,$00,$00,$00,$00,$00,$00,$AA,$AA,$AA,$9A,$AF,$88,$80,$80
;				#
	smpsVcAlgorithm		$07
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$01,	$00,	$01
	smpsVcCoarseFreq	$01,	$02,	$04,	$04
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$00,	$00,	$00
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$09,	$0A,	$0A,	$0A
	smpsVcReleaseRate	$0A,	$0A,	$0A,	$0A
	smpsVcTotalLevel	$80,	$80,	$88,	$AF

;	Voice 3D
;	$3D,$01,$22,$42,$02,$19,$52,$52,$53,$07,$08,$08,$0A,$01,$00,$00,$04,$24,$1A,$1A,$16,$1C,$87,$87,$87
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$04,	$02,	$00
	smpsVcCoarseFreq	$02,	$02,	$02,	$01
	smpsVcRateScale		$01,	$01,	$01,	$00
	smpsVcAttackRate	$13,	$12,	$12,	$19
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$08,	$08,	$07
	smpsVcDecayRate2	$04,	$00,	$00,	$01
	smpsVcDecayLevel	$01,	$01,	$01,	$02
	smpsVcReleaseRate	$06,	$0A,	$0A,	$04
	smpsVcTotalLevel	$87,	$87,	$87,	$1C

;	Voice 3E
;	$08,$0A,$30,$30,$00,$1F,$1F,$5F,$5F,$12,$0E,$0A,$0A,$00,$04,$04,$03,$26,$26,$26,$26,$24,$2D,$13,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$01
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$03,	$03,	$00
	smpsVcCoarseFreq	$00,	$00,	$00,	$0A
	smpsVcRateScale		$01,	$01,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$0A,	$0E,	$12
	smpsVcDecayRate2	$03,	$04,	$04,	$00
	smpsVcDecayLevel	$02,	$02,	$02,	$02
	smpsVcReleaseRate	$06,	$06,	$06,	$06
	smpsVcTotalLevel	$80,	$13,	$2D,	$24

;	Voice 3F
;	$14,$70,$70,$30,$30,$5F,$5F,$5F,$5F,$17,$0A,$19,$0A,$00,$00,$00,$00,$FF,$F7,$FF,$F7,$00,$80,$00,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$02
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$07,	$07
	smpsVcCoarseFreq	$00,	$00,	$00,	$00
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$19,	$0A,	$17
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$07,	$0F,	$07,	$0F
	smpsVcTotalLevel	$80,	$00,	$80,	$00

;	Voice 40
;	$3C,$0B,$02,$0A,$02,$1F,$1E,$1F,$1F,$0F,$0E,$11,$10,$13,$0F,$11,$0E,$24,$07,$17,$08,$20,$80,$1B,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$02,	$0A,	$02,	$0B
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1E,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$10,	$11,	$0E,	$0F
	smpsVcDecayRate2	$0E,	$11,	$0F,	$13
	smpsVcDecayLevel	$00,	$01,	$00,	$02
	smpsVcReleaseRate	$08,	$07,	$07,	$04
	smpsVcTotalLevel	$80,	$1B,	$80,	$20

;	Voice 41
;	$28,$03,$0F,$17,$71,$1F,$12,$1F,$1F,$04,$01,$04,$0C,$01,$01,$01,$00,$10,$19,$10,$17,$17,$26,$1B,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$01,	$00,	$00
	smpsVcCoarseFreq	$01,	$07,	$0F,	$03
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$12,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0C,	$04,	$01,	$04
	smpsVcDecayRate2	$00,	$01,	$01,	$01
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$07,	$00,	$09,	$00
	smpsVcTotalLevel	$80,	$1B,	$26,	$17

;	Voice 42
;	$3A,$01,$40,$01,$31,$1F,$1F,$1F,$1F,$0B,$04,$04,$04,$02,$04,$03,$02,$53,$1C,$53,$26,$18,$05,$11,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$00,	$04,	$00
	smpsVcCoarseFreq	$01,	$01,	$00,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$04,	$04,	$04,	$0B
	smpsVcDecayRate2	$02,	$03,	$04,	$02
	smpsVcDecayLevel	$02,	$05,	$01,	$05
	smpsVcReleaseRate	$06,	$03,	$0C,	$03
	smpsVcTotalLevel	$80,	$11,	$05,	$18

;	Voice 43
;	$20,$66,$65,$60,$61,$DF,$DF,$9F,$9F,$07,$06,$09,$06,$07,$06,$06,$08,$2F,$1F,$1F,$FF,$1C,$2E,$16,$81
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$04
;				op1	op2	op3	op4
	smpsVcDetune		$06,	$06,	$06,	$06
	smpsVcCoarseFreq	$01,	$00,	$05,	$06
	smpsVcRateScale		$02,	$02,	$03,	$03
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$06,	$09,	$06,	$07
	smpsVcDecayRate2	$08,	$06,	$06,	$07
	smpsVcDecayLevel	$0F,	$01,	$01,	$02
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$81,	$16,	$2E,	$1C

;	Voice 44
;	$28,$03,$0F,$17,$71,$1F,$12,$1F,$1F,$04,$01,$04,$0C,$01,$01,$01,$00,$10,$19,$10,$17,$17,$1F,$1B,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$01,	$00,	$00
	smpsVcCoarseFreq	$01,	$07,	$0F,	$03
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$12,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0C,	$04,	$01,	$04
	smpsVcDecayRate2	$00,	$01,	$01,	$01
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$07,	$00,	$09,	$00
	smpsVcTotalLevel	$80,	$1B,	$1F,	$17
	even
