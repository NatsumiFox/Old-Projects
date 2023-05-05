; =============================================================================================
; Project Name:		angry
; Created:		21st September 2015
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

angry_Header:
;	Voice Pointer	location
	smpsHeaderVoice	angry_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$01,	$18

;	DAC Pointer	location
	smpsHeaderDAC	angry_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	angry_FM1,	smpsPitch00,	$0E
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	angry_FM2,	smpsPitch00,	$10
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	angry_FM3,	smpsPitch01hi,	$02
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	angry_FM4,	smpsPitch00,	$18
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	angry_FM5,	smpsPitch00,	$0F
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	angry_PSG1,	smpsPitch03lo,	$02,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	angry_PSG2,	smpsPitch03lo,	$01,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	angry_PSG3,	smpsPitch00,	$01,	$03

; FM1 Data
angry_FM1:
	dc.b		nRst,	$30,	nRst,	nRst,	nRst
;	Alter Volume	value
	smpsAlterVol	$F7
;	Set FM Voice	#
	smpsFMvoice	$16
;	Set Modulation	wait	speed	change	step
	smpsModSet	$08,	$02,	$4D,	$AF
	dc.b		nE2,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$28,	$03,	$F7,	$A6
	dc.b		smpsNoAttack,	nE3,	$48,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack
	dc.b		$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack
	dc.b		$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack
	dc.b		$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30
;	Alter Volume	value
	smpsAlterVol	$09
	dc.b		smpsModOn
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0C,	$01,	$07,	$03
;	Alter Volume	value
	smpsAlterVol	$FE
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		nG4,	$60,	smpsNoAttack,	$60
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		smpsModOn
angry_Jump01:
;	Set Modulation	wait	speed	change	step
	smpsModSet	$30,	$02,	$70,	$70
;	Alter Volume	value
	smpsAlterVol	$03
;	Set FM Voice	#
	smpsFMvoice	$18
	dc.b		nG4,	$60,	nF4,	$60,	nE4,	$60,	smpsNoAttack,	$60
	dc.b		smpsNoAttack,	$30
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$04,	$7F,	$7F
	dc.b		smpsNoAttack,	$30
;	Alter Volume	value
	smpsAlterVol	$04
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$03,	$9F,	$AF
	dc.b		smpsNoAttack,	$42
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$FD
	dc.b		smpsModOn,	nRst,	$06
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Set Modulation	wait	speed	change	step
	smpsModSet	$10,	$01,	$0C,	$06
;	Set FM Voice	#
	smpsFMvoice	$11
;	Call At	 	location
	smpsCall	angry_Call01
;	Alter Pitch	value
	smpsAlterPitch	$0C
	dc.b		smpsModOn,	nRst,	$30
;	Set FM Voice	#
	smpsFMvoice	$14
;	Alter Volume	value
	smpsAlterVol	$FE
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$0B,	$04
	dc.b		nG3,	$30,	smpsNoAttack,	$30,	nRst,	$18,	nE3,	nA3
	dc.b		nE3,	nG3,	nA3,	nBb3,	nE3,	nG3,	nA3,	nB3
	dc.b		nD4
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		smpsModOn,	nRst,	$30,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		$2A
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Set Modulation	wait	speed	change	step
	smpsModSet	$10,	$01,	$0C,	$06
;	Set FM Voice	#
	smpsFMvoice	$11
;	Call At	 	location
	smpsCall	angry_Call01
;	Alter Pitch	value
	smpsAlterPitch	$0C
	dc.b		smpsModOn,	nRst,	$30
;	Set FM Voice	#
	smpsFMvoice	$14
;	Alter Volume	value
	smpsAlterVol	$FF
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$0B,	$04
	dc.b		nG3,	$30,	smpsNoAttack,	$30,	nRst,	$18,	nE3,	nA3
	dc.b		nE3,	nG3,	nA3,	nBb3,	nE3,	nG3,	nA3,	nB3
	dc.b		nD4
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		smpsModOn,	nRst,	$1E,	nRst,	$30,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	$2A
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Set Modulation	wait	speed	change	step
	smpsModSet	$10,	$01,	$0C,	$06
;	Set FM Voice	#
	smpsFMvoice	$11
	dc.b		nD5,	$06,	nRst,	nE5,	$0C,	nF5,	$18,	nE5
	dc.b		$0C,	nF5,	nG5,	nF5,	nE5,	$06,	nRst,	nF5
	dc.b		$0C,	nE5,	$08,	nF5,	$04,	nE5,	$06,	nD5
	dc.b		$30,	smpsNoAttack,	$0C,	nRst,	$06,	nC5,	$0C,	nB4
	dc.b		$18,	nA4,	$10,	nB4,	$14,	nC5,	$0C,	nB4
	dc.b		$06,	smpsNoAttack,	$60,	nRst,	$18,	nG5,	$06,	nF5
	dc.b		nE5,	nF5,	$18,	nF5,	$06,	nE5,	nF5,	nG5
	dc.b		nD5,	smpsNoAttack,	$30,	nRst,	$12,	nB5,	$18,	nB4
	dc.b		$06,	nRst,	$12,	nD5,	$18,	nE5,	$0C,	nD5
	dc.b		nE5,	$06,	nD5,	nB4,	nE4
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nD5,	nB4,	nE4,	nD4
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nB4,	nE4,	nD4,	nB3
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nE4,	nD4,	nB3,	nA3
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nD4,	nB3,	nA3,	nE3
;	Alter Volume	value
	smpsAlterVol	$04
;	Alter Pitch	value
	smpsAlterPitch	$0C
	dc.b		smpsModOn
;	Jump To	 	location
	smpsJump	angry_Jump01

angry_Call01:
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nD4,	$0C,	nE4
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nG4,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	nRst,	$18
	dc.b		nD4,	$0C,	nE4,	nG4,	$30,	smpsNoAttack,	$30,	smpsNoAttack
	dc.b		$30,	nRst,	$18,	nF4,	$0C,	nG4,	nBb4,	$30
	dc.b		smpsNoAttack,	$30,	smpsNoAttack,	$30,	nRst,	$18,	nF4,	$0C
	dc.b		nG4,	nBb4,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack
	dc.b		$18,	nRst,	$18,	nE6,	$06,	nA5,	$0C,	nA4
	dc.b		$30,	smpsNoAttack,	$1E,	smpsNoAttack,	$60,	nRst,	$18,	nBb4
	dc.b		nG4,	nA4,	nBb4,	nG4,	nA4,	nD5,	nCs5,	$30
	dc.b		smpsNoAttack,	$48,	nRst,	$18,	nB4,	$12,	nCs5,	nD5
	dc.b		$0C,	nG4,	$18,	nEb4,	nFs4,	$30,	smpsNoAttack,	$48
	dc.b		nRst,	$18,	nG5,	$60,	nRst,	$18,	nG5,	nFs5
	dc.b		nD5,	nE5,	$24,	nA4,	$06,	nRst,	nA4,	$30
	dc.b		smpsNoAttack,	$48,	nRst,	$18,	nG5,	$60,	nRst,	$18
	dc.b		nG5,	nFs5,	nD5,	nE5,	$24,	nA4,	$06,	nRst
	dc.b		nA4,	$60
	smpsReturn

; FM2 Data
angry_FM2:
;	Set FM Voice	#
	smpsFMvoice	$10
;	Note Fill	duration
	smpsNoteFill	$02
angry_Loop01:
	dc.b		nE3,	$06,	nE3,	nE3,	nE3,	nE3,	nE3,	nE3
	dc.b		nE3,	nE3,	nE3,	nE3,	nE3,	nE3,	nE3,	nE3
	dc.b		nE3
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$0C,	angry_Loop01
angry_Loop02:
	dc.b		nE3,	$06,	nE3,	nE3,	nE3,	nE3,	nE3,	nE3
	dc.b		nE3,	nE3,	nE3,	nE3,	nE3,	nE3,	nE3,	nE3
	dc.b		nE3
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$07,	angry_Loop02
;	Call At	 	location
	smpsCall	angry_Call02
;	Set FM Voice	#
	smpsFMvoice	$15
;	Alter Volume	value
	smpsAlterVol	$F6
;	Note Fill	duration
	smpsNoteFill	$04
	dc.b		nD4,	$06,	nD4,	nD4,	nD4,	nD4,	nD4,	nD4
	dc.b		nD4,	nD4,	nD4,	nD4,	nD4,	nD4,	nD4,	nD4
	dc.b		nD4,	nD4,	nD4,	nRst,	nD4,	$0C,	nD4
;	Alter Volume	value
	smpsAlterVol	$0A
	dc.b		nRst,	$30,	nRst
;	Call At	 	location
	smpsCall	angry_Call02
;	Set FM Voice	#
	smpsFMvoice	$15
;	Alter Volume	value
	smpsAlterVol	$F6
;	Note Fill	duration
	smpsNoteFill	$04
	dc.b		nD4,	$06,	nD4,	nD4,	nD4,	nD4,	nD4,	nD4
	dc.b		nD4,	nD4,	nD4,	nD4,	nD4,	nD4,	nD4,	nD4
	dc.b		nD4
;	Alter Volume	value
	smpsAlterVol	$0A
	dc.b		nRst,	$06,	nRst,	$30,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	$2A
;	Note Fill	duration
	smpsNoteFill	$00
;	Alter Volume	value
	smpsAlterVol	$FE
;	Set FM Voice	#
	smpsFMvoice	$1A
	dc.b		nG4,	$06,	nF4,	nG4,	$0C,	nA4,	$06,	nG4
	dc.b		nF4,	nE4
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nCs5,	$01,	smpsNoAttack,	nD5,	$06,	nRst,	$11,	nRst
	dc.b		$18
;	Alter Volume	value
	smpsAlterVol	$04
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nRst,	$30,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
;	Set FM Voice	#
	smpsFMvoice	$10
;	Note Fill	duration
	smpsNoteFill	$02
;	Jump To	 	location
	smpsJump	angry_Loop02

angry_Call02:
;	Note Fill	duration
	smpsNoteFill	$00
;	Alter Volume	value
	smpsAlterVol	$01
;	Set FM Voice	#
	smpsFMvoice	$1A
	dc.b		nD5,	$06,	nE5,	nRst,	nE5,	$04,	nRst,	$08
	dc.b		nE5,	$06,	nD5,	nRst,	nG5
;	Set Modulation	wait	speed	change	step
	smpsModSet	$20,	$01,	$DF,	$FF
	dc.b		nE5,	$24,	nRst,	$06,	smpsModOn,	nRst,	$30,	nRst
	dc.b		nRst,	$0C,	nE5,	$18,	nD5,	$05,	nRst,	$07
	dc.b		nG4,	$06,	nA4,	nG4,	nA4,	nBb4,	nA4,	nG4
	dc.b		nE4,	nG4,	nE4,	$0C
;	Set Modulation	wait	speed	change	step
	smpsModSet	$20,	$01,	$DF,	$FF
	dc.b		nE5,	$24,	smpsModOn,	nRst,	$2A,	nRst,	$30,	nC5
	dc.b		$06,	nBb4,	nA4,	nG4,	nBb4,	nA4,	nG4,	nF4
	dc.b		nF4,	nF5,	nRst,	nF5,	nRst,	nF5,	nRst,	nE5
	dc.b		nD5,	nBb4,	nRst,	$24,	nD4,	$06,	nD4,	nE4
	dc.b		nE4,	nF4,	nE4,	nF4,	nG4,	nA4,	nA4,	nBb4
	dc.b		nB4,	nC5,	nB4,	nBb4,	nA4
;	Set Modulation	wait	speed	change	step
	smpsModSet	$28,	$01,	$EF,	$FF
	dc.b		nE5,	$30,	smpsModOn,	nRst,	nRst,	nRst
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nFs5,	$06,	nFs5,	nFs5,	nFs5
;	Note Fill	duration
	smpsNoteFill	$0A
	dc.b		nFs5,	$12,	nRst,	$30,	nRst,	$06
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nFs5,	$06,	nFs5,	nFs5,	nFs5
;	Note Fill	duration
	smpsNoteFill	$0A
	dc.b		nFs5,	$06
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		smpsNoAttack,	nG5,	$08,	nRst,	$30,	nRst,	$0A
;	Alter Volume	value
	smpsAlterVol	$02
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nFs5,	$06,	nFs5,	nFs5,	nFs5
;	Note Fill	duration
	smpsNoteFill	$0A
	dc.b		nFs5,	$12,	nRst,	$30,	nRst,	$06
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nFs5,	$06,	nFs5,	nFs5,	nFs5
;	Note Fill	duration
	smpsNoteFill	$0A
	dc.b		nFs5,	$06
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		smpsNoAttack,	nG5,	$08,	nRst,	$30,	nRst,	$0A
;	Alter Volume	value
	smpsAlterVol	$02
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nFs5,	$06,	nFs5,	nFs5,	nFs5
;	Note Fill	duration
	smpsNoteFill	$0A
	dc.b		nFs5,	$12,	nRst,	$30,	nRst,	$06
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nFs5,	$06,	nFs5,	nFs5,	nFs5
;	Note Fill	duration
	smpsNoteFill	$0A
	dc.b		nFs5,	$05,	nRst,	$01
;	Note Fill	duration
	smpsNoteFill	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1E,	$01,	$DF,	$FF
	dc.b		nG5,	$28,	smpsModOn,	nRst,	$02,	nA5,	$18
;	Alter Volume	value
	smpsAlterVol	$FF
;	Set FM Voice	#
	smpsFMvoice	$14
;	Alter Volume	value
	smpsAlterVol	$FB
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$0B,	$04
	dc.b		nA3,	$60,	nRst,	$18,	nG3,	nA3,	nG3,	nFs3
	dc.b		$24,	nE3,	$06,	nRst,	nE3,	$30,	smpsNoAttack,	$48
	dc.b		nRst,	$18,	nA3,	$60,	nRst,	$18,	nG3,	nA3
	dc.b		nG3,	nFs3,	$24,	nE3,	$06,	nRst,	nE3,	$30
	dc.b		smpsNoAttack,	$48,	nRst,	$18
;	Alter Volume	value
	smpsAlterVol	$05
	dc.b		smpsModOn
;	Note Fill	duration
	smpsNoteFill	$00
;	Set FM Voice	#
	smpsFMvoice	$1A
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nB4,	$48
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nB4,	$06,	nA4,	nG4,	nE4,	nA4,	$18,	$06
	dc.b		nG4,	nFs4,	nE4,	nD4,	nD4,	nRst,	nD4,	nRst
	dc.b		$18,	nB3,	$06,	nB3,	nD4,	nD4,	nA4,	nG4
	dc.b		nFs4,	nE4,	nRst,	$30,	nB3,	$06,	nB3,	nD4
	dc.b		nD4,	nA4,	nG4,	nFs4,	nE4,	$1E,	nG5,	$06
	dc.b		nA5,	$06,	smpsNoAttack,	nAb5,	$03,	smpsNoAttack,	nG5,	$01
	dc.b		smpsNoAttack,	nFs5,	smpsNoAttack,	nE5,	smpsNoAttack,	nEb5,	smpsNoAttack,	nD5
	dc.b		nRst,	$04,	nE5,	$06,	nE5,	nE5,	nE5,	nRst
	dc.b		$0C,	nE5,	$06,	nE5,	nE5,	nE5,	nRst,	$0C
	dc.b		nE5,	$06,	nE5,	nE5,	nE5,	nRst,	$0C,	nF5
	dc.b		$10,	nF5,	nF5,	nE5,	$06,	nE5,	nE5,	nE5
	dc.b		nRst,	$0C,	nE5,	$06,	nE5,	nE5,	nE5,	nRst
	dc.b		$0C,	nE5,	$06,	nE5,	nE5,	nE5,	nRst,	$0C
	dc.b		nF5,	$10,	nF5,	nF5,	nE5,	$06,	nE5,	nE5
	dc.b		nE5,	nRst,	$0C,	nE5,	$06,	nE5,	nE5,	nE5
	dc.b		nRst,	$0C,	nE5,	$06,	nE5,	nE5,	nE5,	nRst
	dc.b		$0C,	nF6,	$10,	nF6,	nF6
;	Note Fill	duration
	smpsNoteFill	$07
	dc.b		nE6,	$06,	nE6,	nE6,	nE6,	nRst,	$0C,	nE6
	dc.b		$06,	nE6,	nE6,	nE6,	nRst,	$0C,	nE6,	$06
	dc.b		nE6
;	Note Fill	duration
	smpsNoteFill	$00
	smpsReturn

; FM3 Data
angry_FM3:
	dc.b		nRst,	$30,	nRst,	nRst,	nRst
;	Set FM Voice	#
	smpsFMvoice	$07
angry_Loop03:
	dc.b		nE1,	$0C,	nRst,	nE1,	nRst,	nE1,	nRst,	nE1
	dc.b		nD1
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$07,	angry_Loop03
	dc.b		nE1,	nRst,	nE1,	nRst,	nE1,	$06,	nRst,	nE1
	dc.b		nRst,	nE1,	nRst,	nE1,	nRst,	nRst,	$30,	nRst
	dc.b		nRst,	nRst
angry_Jump02:
	dc.b		nRst,	$30,	nRst,	nRst,	nRst
;	Set FM Voice	#
	smpsFMvoice	$07
	dc.b		nE1,	$0C,	nRst,	nE1,	nRst,	nE1,	nRst,	nE1
	dc.b		nD1,	nE1,	nRst,	nE1,	nRst,	nE1,	nRst,	nE1
	dc.b		nD1,	nE1,	nRst,	nE1,	nRst,	nE1,	nRst,	nE1
	dc.b		nD1,	nE1,	nRst,	nE1,	nRst,	nE1,	$06,	nRst
	dc.b		nE1,	nRst,	nE1,	nRst,	nE1,	nRst
;	Call At	 	location
	smpsCall	angry_Call03
	dc.b		nE1,	$06,	nE1,	nE1,	nE1,	nRst,	nB0,	nE1
	dc.b		nE1,	nE1,	nE1,	nRst,	nB0,	nE1,	nE1,	nE1
	dc.b		$0A,	nRst,	$0E,	nE1,	$0A,	nRst,	$0E,	nE1
	dc.b		$0A,	nRst,	$08,	nE1,	$06,	nE1,	nE1,	nE1
	dc.b		nE1,	nRst,	$12,	nE1,	$06,	nRst,	nE1,	nRst
;	Call At	 	location
	smpsCall	angry_Call03
	dc.b		nE1,	$06,	nE1,	nE1,	nE1,	nRst,	nB0,	nE1
	dc.b		nE1,	nE1,	nE1,	nRst,	nB0,	nE1,	nE1,	nE1
	dc.b		nRst,	$12,	nE1,	$0A,	nRst,	$0E,	nE1,	$0A
	dc.b		nRst,	$08,	nE1,	$06,	nE1,	nE1,	nE1,	nE1
	dc.b		nG1,	nRst,	$12,	nG1,	$0C,	nRst,	nG1,	nRst
	dc.b		nG1,	nF1,	nG1,	$06,	nRst,	$12,	nG1,	$0C
	dc.b		nRst,	nG1,	nRst,	nG1,	nG1,	nG1,	$06,	nRst
	dc.b		$12,	nG1,	$0C,	nRst,	nG1,	nRst,	nG1,	nF1
	dc.b		nG1,	$06,	nRst,	$12,	nG1,	$0C,	nRst,	nG1
	dc.b		nG1,	nG1,	nG1,	nB1,	$06,	nRst,	$12,	nB1
	dc.b		$0C,	nRst,	nB1,	nRst,	nB1,	nA1,	nB1,	$06
	dc.b		nRst,	$12,	nB1,	$0C,	nRst,	nB1,	nRst,	nB1
	dc.b		nRst,	nB1,	$06,	nRst,	$12,	nB1,	$0C,	nRst
	dc.b		nB1,	nRst,	nB1,	nRst,	nE1,	$06,	nRst,	nE1
	dc.b		$0C,	nE1,	nE1,	nE1,	nE1,	nE1,	nE1
;	Jump To	 	location
	smpsJump	angry_Jump02

angry_Call03:
	dc.b		nE1,	$0C,	nRst,	nE1,	nRst,	nE1,	nRst,	nE1
	dc.b		nD1,	nE1,	nRst,	nE1,	nRst,	nE1,	nRst,	nE1
	dc.b		nD1,	nE1,	nRst,	nE1,	nRst,	nE1,	nRst,	nE1
	dc.b		nD1,	nE1,	nRst,	nE1,	nRst,	nE1,	nRst,	nE1
	dc.b		nD1,	nG1,	nRst,	nG1,	nRst,	nG1,	nRst,	nG1
	dc.b		nF1,	nG1,	nRst,	nG1,	nRst,	nG1,	nRst,	nG1
	dc.b		nF1,	nG1,	nRst,	nG1,	nRst,	nG1,	nRst,	nG1
	dc.b		nF1,	nG1,	nRst,	nG1,	nRst,	nG1,	$06,	nRst
	dc.b		nG1,	nRst,	nG1,	nRst,	nG1,	nRst,	nE1,	$0C
	dc.b		nRst,	nE1,	nRst,	nE1,	nRst,	nE1,	nD1,	nE1
	dc.b		nRst,	nE1,	nRst,	nE1,	nRst,	nE1,	nD1,	nE1
	dc.b		nRst,	nE1,	nRst,	nE1,	nRst,	nE1,	nD1,	nE1
	dc.b		nRst,	nE1,	nRst,	nE1,	nRst,	nE1,	nD1,	nE1
	dc.b		nRst,	nE1,	nRst,	nE1,	nRst,	nE1,	nD1,	nE1
	dc.b		nRst,	nE1,	nRst,	nE1,	nRst,	nE1,	nD1,	nE1
	dc.b		nRst,	nE1,	nRst,	nE1,	nRst,	nE1,	nD1,	nE1
	dc.b		nRst,	nE1,	nRst,	nE1,	$06,	nRst,	nE1,	nRst
	dc.b		nE1,	nRst,	nE1,	nRst,	nA1,	$0C,	nRst,	nA1
	dc.b		nRst,	nA1,	nRst,	nA1,	nG1,	nA1,	nRst,	nA1
	dc.b		nRst,	nA1,	nRst,	nA1,	nG1,	nA1,	nRst,	nA1
	dc.b		nRst,	nA1,	nRst,	nA1,	nG1,	nA1,	nRst,	nA1
	dc.b		nRst,	nA1,	nRst,	nA1,	nRst,	nA1,	nRst,	nA1
	dc.b		nRst,	nA1,	nRst,	nA1,	nG1,	nA1,	nRst,	nA1
	dc.b		nRst,	nA1,	nRst,	nA1,	nG1,	nA1,	nRst,	nA1
	dc.b		nRst,	nA1,	nRst,	nA1,	nG1,	nA1,	nRst,	nA1
	dc.b		nRst,	nA1,	nRst,	nA1,	nRst,	nE1,	nRst,	nE1
	dc.b		nRst,	nE1,	nRst,	nE1,	nD1,	nE1,	nRst,	nE1
	dc.b		nRst,	nE1,	nRst,	nE1,	nD1,	nE1,	nRst,	nE1
	dc.b		nRst,	nE1,	nRst,	nE1,	nD1,	nE1,	nRst,	nE1
	dc.b		nRst,	nE1,	nRst,	nE1,	nD1,	nE1,	$06,	nE1
	dc.b		nE1,	nE1,	nRst,	nB0,	nE1,	nE1,	nE1,	nE1
	dc.b		nRst,	nB0,	nE1,	nE1,	nE1,	nE1,	nRst,	nB0
	dc.b		nF1,	$10,	nF1,	nF1,	nE1,	$06,	nE1,	nE1
	dc.b		nE1,	nRst,	nB0,	nE1,	nE1,	nE1,	nE1,	nRst
	dc.b		nB0,	nE1,	nE1,	nE1,	nE1,	nRst,	nB0,	nF1
	dc.b		$10,	nF1,	nF1,	nE1,	$06,	nE1,	nE1,	nE1
	dc.b		nRst,	nB0,	nE1,	nE1,	nE1,	nE1,	nRst,	nB0
	dc.b		nE1,	nE1,	nE1,	nE1,	nRst,	nB0,	nF1,	$10
	dc.b		nF1,	nF1
	smpsReturn

; FM4 Data
angry_FM4:
	dc.b		nRst,	$30,	nRst,	nRst,	nRst,	nRst,	$0C
;	Alter Volume	value
	smpsAlterVol	$FB
;	Set FM Voice	#
	smpsFMvoice	$16
;	Set Modulation	wait	speed	change	step
	smpsModSet	$08,	$02,	$4D,	$AF
	dc.b		nE2,	$18,	smpsNoAttack
;	Set Modulation	wait	speed	change	step
	smpsModSet	$28,	$03,	$F7,	$A6
	dc.b		nE3,	$48,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30
	dc.b		smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30
	dc.b		smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30
	dc.b		smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsModOn
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0C,	$01,	$07,	$03
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		nG4,	$60,	smpsNoAttack,	$54,	smpsModOn
;	Alter Volume	value
	smpsAlterVol	$05
angry_Jump03:
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nRst,	$0C
;	Set Modulation	wait	speed	change	step
	smpsModSet	$30,	$02,	$70,	$70
;	Set FM Voice	#
	smpsFMvoice	$18
	dc.b		nG4,	$60,	nF4,	$60,	nE4,	$60,	smpsNoAttack,	$60
	dc.b		smpsNoAttack,	$30
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$04,	$7F,	$7F
	dc.b		smpsNoAttack,	$30
;	Alter Volume	value
	smpsAlterVol	$04
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$03,	$9F,	$AF
	dc.b		smpsNoAttack,	$48,	smpsModOn
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nRst,	$30,	nRst,	$3C
;	Alter Volume	value
	smpsAlterVol	$04
;	Set FM Voice	#
	smpsFMvoice	$1A
;	Alter Notes	value
	smpsAlterNote	$01
;	Call At	 	location
	smpsCall	angry_Call04
	dc.b		nRst,	$18,	nRst,	$30,	nRst,	nRst,	nRst,	nRst
	dc.b		$12
;	Set FM Voice	#
	smpsFMvoice	$1A
;	Call At	 	location
	smpsCall	angry_Call04
	dc.b		nRst,	$06,	nRst,	$30,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	$2A
;	Alter Volume	value
	smpsAlterVol	$FE
;	Set FM Voice	#
	smpsFMvoice	$1A
	dc.b		nC5,	$06,	nB4,	nC5,	$0C,	nD5,	$06,	nB4
	dc.b		nA4,	nG4
;	Alter Volume	value
	smpsAlterVol	$FD
	dc.b		nE5,	$01,	smpsNoAttack,	nF5,	$06,	nRst,	$11
;	Alter Volume	value
	smpsAlterVol	$03
;	Alter Volume	value
	smpsAlterVol	$02
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nRst,	$18
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Alter Volume	value
	smpsAlterVol	$02
;	Set Modulation	wait	speed	change	step
	smpsModSet	$10,	$01,	$0C,	$06
;	Set FM Voice	#
	smpsFMvoice	$11
	dc.b		nRst,	$06,	nF5,	$18,	nF5,	$06,	nE5,	nF5
	dc.b		nG5,	nD5,	smpsNoAttack,	$30,	nRst,	$12,	nB5,	$18
	dc.b		nB4,	$06,	nRst,	$12,	nD5,	$18,	nE5,	$0C
	dc.b		nD5,	nE5,	$06,	nD5,	nB4,	nE4
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nD5,	nB4,	nE4,	nD4
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nB4,	nE4,	nD4,	nB3
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nE4,	nD4,	nB3,	nA3
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nD4,	nB3,	nA3
;	Alter Volume	value
	smpsAlterVol	$03
;	Alter Pitch	value
	smpsAlterPitch	$0C
	dc.b		smpsModOn
;	Jump To	 	location
	smpsJump	angry_Jump03

angry_Call04:
	dc.b		nA4,	$06,	nB4,	nRst,	nB4,	$04,	nRst,	$08
	dc.b		nB4,	$06,	nA4,	nRst,	nD5
;	Set Modulation	wait	speed	change	step
	smpsModSet	$20,	$01,	$DF,	$FF
	dc.b		nB4,	$24,	nRst,	$06,	smpsModOn,	nRst,	$30,	nRst
	dc.b		nRst,	$0C,	nB4,	$18,	nA4,	$05,	nRst,	$07
	dc.b		nD4,	$06,	nE4,	nD4,	nE4,	nF4,	nE4,	nD4
	dc.b		nB3,	nD4,	nB3,	$0C
;	Set Modulation	wait	speed	change	step
	smpsModSet	$20,	$01,	$DF,	$FF
	dc.b		nB4,	$24,	smpsModOn,	nRst,	$2A,	nRst,	$30,	nG4
	dc.b		$06,	nF4,	nE4,	nD4,	nF4,	nE4,	nD4,	nC4
	dc.b		nC4,	nC5,	nRst,	nC5,	nRst,	nC5,	nRst,	nB4
	dc.b		nA4,	nF4,	nRst,	$24,	nA3,	$06,	nA3,	nB3
	dc.b		nB3,	nC4,	nB3,	nC4,	nD4,	nE4,	nE4,	nF4
	dc.b		nFs4,	nG4,	nFs4,	nF4,	nE4
;	Set Modulation	wait	speed	change	step
	smpsModSet	$28,	$01,	$EF,	$FF
	dc.b		nB5,	$30,	smpsModOn,	nRst,	nRst,	nRst,	nCs5,	$04
	dc.b		nRst,	$02,	nCs5,	$04,	nRst,	$02,	nCs5,	$04
	dc.b		nRst,	$02,	nCs5,	$04,	nRst,	$02
;	Note Fill	duration
	smpsNoteFill	$0A
	dc.b		nCs5,	$12,	nRst,	$30,	nRst,	$06
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nCs5,	$04,	nRst,	$02,	nCs5,	$04,	nRst,	$02
	dc.b		nCs5,	$04,	nRst,	$02,	nCs5,	$04,	nRst,	$02
;	Note Fill	duration
	smpsNoteFill	$0A
	dc.b		nCs5,	$06,	smpsNoAttack,	nD5,	$08,	nRst,	$30,	nRst
	dc.b		$0A
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nCs5,	$04,	nRst,	$02,	nCs5,	$04,	nRst,	$02
	dc.b		nCs5,	$04,	nRst,	$02,	nCs5,	$04,	nRst,	$02
;	Note Fill	duration
	smpsNoteFill	$0A
	dc.b		nCs5,	$12,	nRst,	$30,	nRst,	$06
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nCs5,	$04,	nRst,	$02,	nCs5,	$04,	nRst,	$02
	dc.b		nCs5,	$04,	nRst,	$02,	nCs5,	$04,	nRst,	$02
;	Note Fill	duration
	smpsNoteFill	$0A
	dc.b		nCs5,	$06,	smpsNoAttack,	nD5,	$08,	nRst,	$30,	nRst
	dc.b		$0A
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nCs5,	$04,	nRst,	$02,	nCs5,	$04,	nRst,	$02
	dc.b		nCs5,	$04,	nRst,	$02,	nCs5,	$04,	nRst,	$02
;	Note Fill	duration
	smpsNoteFill	$0A
	dc.b		nCs5,	$12,	nRst,	$30,	nRst,	$06
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nCs5,	$04,	nRst,	$02,	nCs5,	$04,	nRst,	$02
	dc.b		nCs5,	$04,	nRst,	$02,	nCs5,	$04,	nRst,	$02
;	Note Fill	duration
	smpsNoteFill	$0A
	dc.b		nCs5,	$05,	nRst,	$01
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1E,	$01,	$DF,	$FF
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD5,	$28,	smpsModOn,	nRst,	$02,	nE5,	$18,	nRst
	dc.b		$30,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nE5,	smpsNoAttack,	$18
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nE5,	$06,	nD5,	nCs5,	nB4,	nD5,	$18,	$06
	dc.b		nCs5,	nB4,	nA4,	nG4,	nG4,	nRst,	nG4,	nRst
	dc.b		$18,	nE4,	$06,	nE4,	nG4,	nG4,	nD5,	nCs5
	dc.b		nB4,	nA4,	nRst,	$30,	nE4,	$06,	nE4,	nG4
	dc.b		nG4,	nD5,	nCs5,	nB4,	nA4,	$1E,	nD5,	$06
	dc.b		nE5,	$06,	smpsNoAttack,	nEb5,	$03,	smpsNoAttack,	nD5,	$01
	dc.b		smpsNoAttack,	nCs5,	smpsNoAttack,	nC5,	smpsNoAttack,	nB4,	smpsNoAttack,	nBb4
	dc.b		nRst,	$04,	nB4,	$06,	nB4,	nB4,	nB4,	nRst
	dc.b		$0C,	nB4,	$06,	nB4,	nB4,	nB4,	nRst,	$0C
	dc.b		nB4,	$06,	nB4,	nB4,	nB4,	nRst,	$0C,	nC5
	dc.b		$10,	nC5,	nC5,	nB4,	$06,	nB4,	nB4,	nB4
	dc.b		nRst,	$0C,	nB4,	$06,	nB4,	nB4,	nB4,	nRst
	dc.b		$0C,	nB4,	$06,	nB4,	nB4,	nB4,	nRst,	$0C
	dc.b		nC5,	$10,	nC5,	nC5,	nB4,	$06,	nB4,	nB4
	dc.b		nB4,	nRst,	$0C,	nB4,	$06,	nB4,	nB4,	nB4
	dc.b		nRst,	$0C,	nB4,	$06,	nB4,	nB4,	nB4,	nRst
	dc.b		$0C,	nC6,	$10,	nC6,	nC6
;	Note Fill	duration
	smpsNoteFill	$07
	dc.b		nB5,	$06,	nB5,	nB5,	nB5,	nRst,	$0C,	nB5
	dc.b		$06,	nB5,	nB5,	nB5,	nRst,	$0C,	nB5,	$06
	dc.b		nB5
;	Note Fill	duration
	smpsNoteFill	$00
	smpsReturn

; FM5 Data
angry_FM5:
	dc.b		nRst,	$30,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
;	Set Modulation	wait	speed	change	step
	smpsModSet	$04,	$01,	$8F,	$FF
;	Set FM Voice	#
	smpsFMvoice	$19
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nG2,	$06,	nG2,	nG2,	nG2,	nG2,	$0C,	nRst
	dc.b		nRst,	$30
angry_Loop04:
	dc.b		nG2,	$06,	nG2,	nG2,	nG2,	nG2,	$0C,	nRst
	dc.b		nRst,	$30
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$16,	angry_Loop04
;	Alter Volume	value
	smpsAlterVol	$01
;	Alter Pitch	value
	smpsAlterPitch	$E8
;	Set Modulation	wait	speed	change	step
	smpsModSet	$05,	$01,	$8F,	$FF
;	Set FM Voice	#
	smpsFMvoice	$13
	dc.b		nA4,	$06,	nA4,	nRst,	$0C,	nA4,	$06,	nA4
	dc.b		nRst,	$0C,	nA4,	$06,	nA4,	nRst,	$0C,	nA4
	dc.b		$06,	nA4,	nRst,	$0C,	nA4,	$06,	nA4,	nRst
	dc.b		$0C,	nA4,	$06,	nA4,	nRst,	$0C,	nA4,	$06
	dc.b		nRst,	nA4,	nRst,	nA4,	nRst,	nA4,	nRst,	nA4
	dc.b		$06,	nA4,	nRst,	$0C,	nA4,	$06,	nA4,	nRst
	dc.b		$0C,	nA4,	$06,	nA4,	nRst,	$0C,	nA4,	$06
	dc.b		nA4,	nRst,	$0C,	nA4,	$06,	nA4,	nRst,	$0C
	dc.b		nA4,	$06,	nA4,	nRst,	$0C,	nA4,	$06,	nRst
	dc.b		nA4,	nRst,	nA4,	nRst,	nA4,	nRst,	nA4,	$06
	dc.b		nA4,	nRst,	$0C,	nA4,	$06,	nA4,	nRst,	$0C
	dc.b		nA4,	$06,	nA4,	nRst,	$0C,	nA4,	$06,	nA4
	dc.b		nRst,	$0C,	nA4,	$06,	nA4,	nRst,	$0C,	nA4
	dc.b		$06,	nA4,	nRst,	$0C,	nA4,	$06,	nRst,	nA4
	dc.b		nRst,	nA4,	nRst,	nA4,	nRst,	nA4,	$06,	nA4
	dc.b		nRst,	$0C,	nA4,	$06,	nA4,	nRst,	$0C,	nA4
	dc.b		$06,	nA4,	nRst,	$0C,	nA4,	$06,	nA4,	nRst
	dc.b		$0C,	nA4,	$06,	nA4,	nRst,	$0C,	nA4,	$06
	dc.b		nA4,	nRst,	$0C,	nA4,	$06,	nA4,	nRst,	$0C
	dc.b		nA4,	$06,	nA4,	nRst,	$0C,	nRst,	$30,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nE4,	$06
	dc.b		nE4,	nE4,	nE4,	nRst,	$0C,	nE4,	$06,	nE4
	dc.b		nE4,	nE4,	nRst,	$0C,	nE4,	$06,	nE4,	nE4
	dc.b		nE4,	nRst,	$0C,	nF3,	$10,	nF3,	nF3,	nE4
	dc.b		$06,	nE4,	nE4,	nE4,	nRst,	$0C,	nE4,	$06
	dc.b		nE4,	nE4,	nE4,	nRst,	$0C,	nE4,	$06,	nE4
	dc.b		nE4,	nE4,	nRst,	$0C,	nF3,	$10,	nF3,	nF3
	dc.b		nE4,	$06,	nE4,	nE4,	nE4,	nRst,	$0C,	nE4
	dc.b		$06,	nE4,	nE4,	nE4,	nRst,	$0C,	nE4,	$06
	dc.b		nE4,	nE4,	nE4,	nRst,	$0C,	nF3,	$10,	nF3
	dc.b		nF3,	nE4,	$06,	nE4,	nE4,	nE4,	nRst,	$0C
	dc.b		nE4,	$06,	nE4,	nE4,	nE4,	nRst,	$0C,	nE4
	dc.b		$06,	nE4,	nRst,	$18
;	Alter Pitch	value
	smpsAlterPitch	$18
	dc.b		nRst,	$18,	nRst,	$12
;	Set Modulation	wait	speed	change	step
	smpsModSet	$04,	$01,	$8F,	$FF
;	Alter Volume	value
	smpsAlterVol	$FF
;	Set FM Voice	#
	smpsFMvoice	$19
	dc.b		nG2,	$06,	nG2,	nG2,	nG2,	nG2,	nRst,	$2A
angry_Loop05:
	dc.b		nG2,	$06,	nG2,	nG2,	nG2,	nG2,	$0C,	nRst
	dc.b		nRst,	$30
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	angry_Loop05
angry_Loop06:
	dc.b		nD3,	$06,	nD3,	nD3,	nD3,	nD3,	$0C,	nRst
	dc.b		nRst,	$30
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	angry_Loop06
angry_Loop07:
	dc.b		nG2,	$06,	nG2,	nG2,	nG2,	nG2,	$0C,	nRst
	dc.b		nRst,	$30
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	angry_Loop07
;	Alter Volume	value
	smpsAlterVol	$01
;	Alter Pitch	value
	smpsAlterPitch	$E8
;	Set Modulation	wait	speed	change	step
	smpsModSet	$05,	$01,	$8F,	$FF
;	Set FM Voice	#
	smpsFMvoice	$13
	dc.b		nA4,	$06,	nA4,	nRst,	$0C,	nA4,	$06,	nA4
	dc.b		nRst,	$0C,	nA4,	$06,	nA4,	nRst,	$0C,	nA4
	dc.b		$06,	nA4,	nRst,	$0C,	nA4,	$06,	nA4,	nRst
	dc.b		$0C,	nA4,	$06,	nA4,	nRst,	$0C,	nA4,	$06
	dc.b		nRst,	nA4,	nRst,	nA4,	nRst,	nA4,	nRst,	nA4
	dc.b		$06,	nA4,	nRst,	$0C,	nA4,	$06,	nA4,	nRst
	dc.b		$0C,	nA4,	$06,	nA4,	nRst,	$0C,	nA4,	$06
	dc.b		nA4,	nRst,	$0C,	nA4,	$06,	nA4,	nRst,	$0C
	dc.b		nA4,	$06,	nA4,	nRst,	$0C,	nA4,	$06,	nRst
	dc.b		nA4,	nRst,	nA4,	nRst,	nA4,	nRst,	nA4,	$06
	dc.b		nA4,	nRst,	$0C,	nA4,	$06,	nA4,	nRst,	$0C
	dc.b		nA4,	$06,	nA4,	nRst,	$0C,	nA4,	$06,	nA4
	dc.b		nRst,	$0C,	nA4,	$06,	nA4,	nRst,	$0C,	nA4
	dc.b		$06,	nA4,	nRst,	$0C,	nA4,	$06,	nRst,	nA4
	dc.b		nRst,	nA4,	nRst,	nA4,	nRst,	nA4,	$06,	nA4
	dc.b		nRst,	$0C,	nA4,	$06,	nA4,	nRst,	$0C,	nA4
	dc.b		$06,	nA4,	nRst,	$0C,	nA4,	$06,	nA4,	nRst
	dc.b		$0C,	nA4,	$06,	nA4,	nRst,	$0C,	nA4,	$06
	dc.b		nA4,	nRst,	$0C,	nA4,	$06,	nA4,	nRst,	$0C
	dc.b		nA4,	$06,	nA4,	nRst,	$30,	nRst,	$2A,	nRst
	dc.b		$30,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	$12
	dc.b		nE4,	$06,	nE4,	nE4,	nE4,	nRst,	$0C,	nE4
	dc.b		$06,	nE4,	nE4,	nE4,	nRst,	$0C,	nE4,	$06
	dc.b		nE4,	nE4,	nE4,	nRst,	$0C,	nF3,	$10,	nF3
	dc.b		nF3,	nE4,	$06,	nE4,	nE4,	nE4,	nRst,	$0C
	dc.b		nE4,	$06,	nE4,	nE4,	nE4,	nRst,	$0C,	nE4
	dc.b		$06,	nE4,	nE4,	nE4,	nRst,	$0C,	nF3,	$10
	dc.b		nF3,	nF3,	nE4,	$06,	nE4,	nE4,	nE4,	nRst
	dc.b		$0C,	nE4,	$06,	nE4,	nE4,	nE4,	nRst,	$0C
	dc.b		nE4,	$06,	nE4,	nE4,	nE4,	nRst,	$0C,	nF3
	dc.b		$10,	nF3,	nF3,	nE4,	$06,	nE4,	nE4,	nE4
	dc.b		nRst,	$0C,	nE4,	$06,	nE4,	nE4,	nE4,	nRst
	dc.b		$0C,	nE4,	$06,	nE4,	nRst,	nRst,	$30,	nRst
	dc.b		$2A
angry_Loop08:
	dc.b		nA2,	$06,	nA2,	nA2,	nA2,	nA2,	nA2,	nA2
	dc.b		nA2,	nA2,	nA2,	nA2,	nA2,	nA2,	nA2,	nA2
	dc.b		nA2
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	angry_Loop08
;	Alter Pitch	value
	smpsAlterPitch	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$04,	$01,	$8F,	$FF
;	Set FM Voice	#
	smpsFMvoice	$19
;	Alter Volume	value
	smpsAlterVol	$FF
;	Jump To	 	location
	smpsJump	angry_Loop04

; PSG1 Data
angry_PSG1:
	dc.b		nRst,	$30,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst
angry_Jump04:
	dc.b		nRst,	$30,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$0A
;	Call At	 	location
	smpsCall	angry_Call05
	dc.b		nRst,	$18,	nRst,	$30,	nRst,	nRst,	nRst,	nRst
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$0A
;	Call At	 	location
	smpsCall	angry_Call05
	dc.b		nRst,	$06,	nRst,	$30,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	$2A
;	Set PSG Voice	#
	smpsPSGvoice	$0A
	dc.b		nC5,	$06,	nB4,	nC5,	$0C,	nD5,	$06,	nB4
	dc.b		nA4,	nG4
;	Set Volume	value
	smpsSetVol	$FF
	dc.b		nE5,	$01,	smpsNoAttack,	nF5,	$06
;	Set Volume	value
	smpsSetVol	$01
	dc.b		nRst,	$11,	nRst,	$18,	nRst,	$30,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst
;	Jump To	 	location
	smpsJump	angry_Jump04

angry_Call05:
	dc.b		nA4,	$06,	nB4,	nRst,	nB4,	$04,	nRst,	$08
	dc.b		nB4,	$06,	nA4,	nRst,	nD5
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1B,	$02,	$20,	$FF
	dc.b		nB4,	$24,	nRst,	$06,	smpsModOn,	nRst,	$30,	nRst
	dc.b		nRst,	$0C,	nB4,	$18,	nA4,	$05,	nRst,	$07
	dc.b		nD4,	$06,	nE4,	nD4,	nE4,	nF4,	nE4,	nD4
	dc.b		nB3,	nD4,	nB3,	$0C
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1E,	$02,	$20,	$FF
	dc.b		nB4,	$24,	smpsModOn,	nRst,	$2A,	nRst,	$30,	nG4
	dc.b		$06,	nF4,	nE4,	nD4,	nF4,	nE4,	nD4,	nC4
	dc.b		nC4,	nC5,	nRst,	nC5,	nRst,	nC5,	nRst,	nB4
	dc.b		nA4,	nF4,	nRst,	$24,	nA3,	$06,	nA3,	nB3
	dc.b		nB3,	nC4,	nB3,	nC4,	nD4,	nE4,	nE4,	nF4
	dc.b		nFs4,	nG4,	nFs4,	nF4,	nE4
;	Set Modulation	wait	speed	change	step
	smpsModSet	$26,	$02,	$16,	$FF
	dc.b		nB5,	$30,	smpsModOn,	nRst,	nRst,	nRst
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nCs5,	$06,	nCs5,	nCs5,	nCs5
;	Note Fill	duration
	smpsNoteFill	$0A
	dc.b		nCs5,	$12,	nRst,	$30,	nRst,	$06
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nCs5,	nCs5,	nCs5,	nCs5,	nCs5
;	Note Fill	duration
	smpsNoteFill	$0A
	dc.b		nD5,	$0C,	nRst,	$30,	nRst,	$06
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nCs5,	nCs5,	nCs5,	nCs5
;	Note Fill	duration
	smpsNoteFill	$0A
	dc.b		nCs5,	$12,	nRst,	$30,	nRst,	$06
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nCs5,	nCs5,	nCs5,	nCs5,	nCs5
;	Note Fill	duration
	smpsNoteFill	$0A
	dc.b		nD5,	$0C,	nRst,	$30,	nRst,	$06
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nCs5,	nCs5,	nCs5,	nCs5
;	Note Fill	duration
	smpsNoteFill	$0A
	dc.b		nCs5,	$12,	nRst,	$30,	nRst,	$06
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nCs5,	nCs5,	nCs5,	nCs5
;	Note Fill	duration
	smpsNoteFill	$0A
	dc.b		nCs5,	$04,	nRst,	$02
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1B,	$02,	$20,	$FF
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD5,	$28,	smpsModOn,	nRst,	$02,	nE5,	$18,	nRst
	dc.b		$30,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nE5,	smpsNoAttack,	$18,	$06,	nD5,	nCs5,	nB4,	nD5
	dc.b		$18,	$06,	nCs5,	nB4,	nA4,	nG4,	nG4,	nRst
	dc.b		nG4,	nRst,	$18,	nE4,	$06,	nE4,	nG4,	nG4
	dc.b		nD5,	nCs5,	nB4,	nA4,	nRst,	$30,	nE4,	$06
	dc.b		nE4,	nG4,	nG4,	nD5,	nCs5,	nB4,	nA4,	$1E
	dc.b		nD5,	$06,	nE5,	$06,	smpsNoAttack,	nEb5,	$03,	smpsNoAttack
	dc.b		nD5,	$01,	smpsNoAttack,	nCs5,	smpsNoAttack,	nC5,	smpsNoAttack,	nB4
	dc.b		smpsNoAttack,	nBb4,	nRst,	$04,	nB4,	$06,	nB4,	nB4
	dc.b		nB4,	nRst,	$0C,	nB4,	$06,	nB4,	nB4,	nB4
	dc.b		nRst,	$0C,	nB4,	$06,	nB4,	nB4,	nB4,	nRst
	dc.b		$0C,	nC5,	$10,	nC5,	nC5,	nB4,	$06,	nB4
	dc.b		nB4,	nB4,	nRst,	$0C,	nB4,	$06,	nB4,	nB4
	dc.b		nB4,	nRst,	$0C,	nB4,	$06,	nB4,	nB4,	nB4
	dc.b		nRst,	$0C,	nC5,	$10,	nC5,	nC5,	nB4,	$06
	dc.b		nB4,	nB4,	nB4,	nRst,	$0C,	nB4,	$06,	nB4
	dc.b		nB4,	nB4,	nRst,	$0C,	nB4,	$06,	nB4,	nB4
	dc.b		nB4,	nRst,	$0C,	nC6,	$10,	nC6,	nC6
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nB5,	$06,	nB5,	nB5,	nB5,	nRst,	$0C,	nB5
	dc.b		$06,	nB5,	nB5,	nB5,	nRst,	$0C,	nB5,	$06
	dc.b		nB5
;	Note Fill	duration
	smpsNoteFill	$00
	smpsReturn

; PSG2 Data
angry_PSG2:
	dc.b		nRst,	$30,	nRst,	nRst,	$30,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$05
;	Note Fill	duration
	smpsNoteFill	$02
angry_Loop09:
	dc.b		nB4,	$02
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs5
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nCs5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nRst,	$06,	nD5,	$02
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nD5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs5
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nCs5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nG4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nG4
;	Set Volume	value
	smpsSetVol	$FC
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$10,	angry_Loop09
	dc.b		nRst,	$30,	nRst,	nRst,	nRst
angry_Jump05:
	dc.b		nRst,	$30,	nRst,	nRst,	nRst
angry_Loop0A:
	dc.b		nB4,	$02
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs5
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nCs5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nRst,	$06,	nD5,	$02
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nD5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs5
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nCs5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nG4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nG4
;	Set Volume	value
	smpsSetVol	$FC
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$10,	angry_Loop0A
;	Set PSG Voice	#
	smpsPSGvoice	$0B
;	Note Fill	duration
	smpsNoteFill	$03
	dc.b		nB3,	$06,	nD4,	nF4,	nA4,	nRst,	$30,	nB3
	dc.b		$06,	nD4,	nF4,	nA4,	nRst,	$18,	nB3,	$06
	dc.b		nD4,	nF4,	nA4,	nRst,	$30,	nB3,	$06,	nD4
	dc.b		nF4,	nA4,	nRst,	$30,	nB3,	$06,	nD4,	nF4
	dc.b		nA4,	nRst,	$18,	nB3,	$06,	nD4,	nF4,	nA4
	dc.b		nRst,	$18,	nB3,	$06,	nD4,	nF4,	nB3
;	Set PSG Voice	#
	smpsPSGvoice	$05
;	Note Fill	duration
	smpsNoteFill	$02
angry_Loop0B:
	dc.b		nB4,	$02
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs5
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nCs5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nRst,	$06,	nD5,	$02
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nD5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs5
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nCs5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nG4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nG4
;	Set Volume	value
	smpsSetVol	$FC
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$10,	angry_Loop0B
;	Set PSG Voice	#
	smpsPSGvoice	$0B
;	Note Fill	duration
	smpsNoteFill	$03
angry_Loop0C:
	dc.b		nA4,	$06,	nE4,	nD5,	nRst,	nCs5,	nD5,	nCs5
	dc.b		nA4,	nA4,	nE4,	nE5,	nRst,	nCs5,	nD5,	nCs5
	dc.b		nA4
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	angry_Loop0C
;	Set PSG Voice	#
	smpsPSGvoice	$05
;	Note Fill	duration
	smpsNoteFill	$02
angry_Loop0D:
	dc.b		nB4,	$02
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs5
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nCs5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nRst,	$06,	nD5,	$02
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nD5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs5
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nCs5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nG4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nG4
;	Set Volume	value
	smpsSetVol	$FC
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	angry_Loop0D
;	Set PSG Voice	#
	smpsPSGvoice	$0B
;	Note Fill	duration
	smpsNoteFill	$03
;	Set Volume	value
	smpsSetVol	$01
angry_Loop0E:
	dc.b		nE5,	$06,	nE5,	nE5,	nE5,	nE5,	nE5,	nE5
	dc.b		nE5,	nE5,	nE5,	nE5,	nE5,	nE5,	nE5,	nE5
	dc.b		nE5,	nE5,	nE5,	nF5,	nF5,	nF5,	nF5,	nF5
	dc.b		nF5,	nF5,	nF5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	angry_Loop0E
	dc.b		nE5,	nE5,	nE5,	nE5,	nE5,	nE5,	nE5,	nE5
	dc.b		nE5,	nE5,	nE5,	nE5,	nE5,	nE5,	nRst,	$60
	dc.b		nRst,	$12,	nD5,	$06,	nCs5,	nB4,	nG4
;	Set Volume	value
	smpsSetVol	$FF
;	Set PSG Voice	#
	smpsPSGvoice	$05
;	Note Fill	duration
	smpsNoteFill	$02
angry_Loop0F:
	dc.b		nB4,	$02
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs5
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nCs5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nRst,	$06,	nD5,	$02
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nD5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs5
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nCs5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nG4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nG4
;	Set Volume	value
	smpsSetVol	$FC
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	angry_Loop0F
;	Set PSG Voice	#
	smpsPSGvoice	$0B
;	Note Fill	duration
	smpsNoteFill	$03
	dc.b		nB3,	$06,	nD4,	nF4,	nA4,	nRst,	$30,	nB3
	dc.b		$06,	nD4,	nF4,	nA4,	nRst,	$18,	nB3,	$06
	dc.b		nD4,	nF4,	nA4,	nRst,	$30,	nB3,	$06,	nD4
	dc.b		nF4,	nA4,	nRst,	$30,	nB3,	$06,	nD4,	nF4
	dc.b		nA4,	nRst,	$18,	nB3,	$06,	nD4,	nF4,	nA4
	dc.b		nRst,	$18,	nB3,	$06,	nD4,	nF4,	nB3
;	Set PSG Voice	#
	smpsPSGvoice	$05
;	Note Fill	duration
	smpsNoteFill	$02
angry_Loop10:
	dc.b		nB4,	$02
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs5
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nCs5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nRst,	$06,	nD5,	$02
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nD5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs5
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nCs5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nG4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nG4
;	Set Volume	value
	smpsSetVol	$FC
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$10,	angry_Loop10
;	Set PSG Voice	#
	smpsPSGvoice	$0B
;	Note Fill	duration
	smpsNoteFill	$03
angry_Loop11:
	dc.b		nA4,	$06,	nE4,	nD5,	nRst,	nCs5,	nD5,	nCs5
	dc.b		nA4,	nA4,	nE4,	nE5,	nRst,	nCs5,	nD5,	nCs5
	dc.b		nA4
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	angry_Loop11
;	Set PSG Voice	#
	smpsPSGvoice	$05
;	Note Fill	duration
	smpsNoteFill	$02
angry_Loop12:
	dc.b		nB4,	$02
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs5
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nCs5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nRst,	$06,	nD5,	$02
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nD5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs5
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nCs5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nG4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nG4
;	Set Volume	value
	smpsSetVol	$FC
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	angry_Loop12
;	Set PSG Voice	#
	smpsPSGvoice	$0B
;	Note Fill	duration
	smpsNoteFill	$03
;	Set Volume	value
	smpsSetVol	$01
angry_Loop13:
	dc.b		nE5,	$06,	nE5,	nE5,	nE5,	nE5,	nE5,	nE5
	dc.b		nE5,	nE5,	nE5,	nE5,	nE5,	nE5,	nE5,	nE5
	dc.b		nE5,	nE5,	nE5,	nF5,	nF5,	nF5,	nF5,	nF5
	dc.b		nF5,	nF5,	nF5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	angry_Loop13
	dc.b		nE5,	nE5,	nE5,	nE5,	nE5,	nE5,	nE5,	nE5
	dc.b		nE5,	nE5,	nE5,	nE5,	nE5,	nE5,	nRst,	$60
;	Set Volume	value
	smpsSetVol	$FF
;	Set PSG Voice	#
	smpsPSGvoice	$05
;	Note Fill	duration
	smpsNoteFill	$02
angry_Loop14:
	dc.b		nB4,	$02
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs5
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nCs5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nRst,	$06,	nD5,	$02
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nD5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nCs5
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nCs5
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nB4
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nG4
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	nG4
;	Set Volume	value
	smpsSetVol	$FC
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$10,	angry_Loop14
;	Jump To	 	location
	smpsJump	angry_Jump05

; PSG3 Data
angry_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
;	Note Fill	duration
	smpsNoteFill	$02
angry_Loop15:
	dc.b		nA5,	$06,	nRst,	nA5,	nA5,	nA5,	nRst,	nA5
	dc.b		nA5,	nA5,	nRst,	nA5,	nA5,	nA5,	nRst,	nA5
	dc.b		nA5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$0C,	angry_Loop15
angry_Loop16:
	dc.b		nA5,	$06,	nRst,	nA5,	nA5,	nA5,	nRst,	nA5
	dc.b		nA5,	nA5,	nRst,	nA5,	nA5,	nA5,	nRst,	nA5
	dc.b		nA5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$22,	angry_Loop16
	dc.b		nA5,	$06,	nRst,	nA5,	nA5,	nA5,	nRst,	nA5
	dc.b		nA5,	nA5,	nRst,	nA5,	nA5,	nA5,	nRst,	nA5
	dc.b		nA5,	nA5,	nRst,	nA5,	$06,	nA5,	nA5,	nRst
	dc.b		nA5,	$06,	nA5,	nA5,	nRst,	nA5,	nA5,	nA5
	dc.b		nRst,	nA5,	nA5,	nA5,	nRst,	nA5,	nA5,	nA5
	dc.b		nRst,	nA5,	nA5,	nA5,	nRst,	nA5,	nA5,	nA5
	dc.b		nRst,	nA5,	nA5,	nA5,	nRst,	nA5,	nA5,	nA5
	dc.b		$06,	nRst,	nA5,	nA5,	nA5,	nRst,	nA5,	nA5
	dc.b		nA5,	nRst,	nA5,	nA5,	nA5,	nRst,	nA5,	nA5
	dc.b		nA5,	nRst,	nA5,	$06,	nA5,	nA5,	nRst,	nA5
	dc.b		$06,	nA5,	nA5,	nRst,	nA5,	nA5,	nA5,	nRst
	dc.b		nA5,	nA5,	nA5,	nRst,	nA5,	nA5,	nA5,	nRst
	dc.b		nA5,	nA5,	nRst,	$60,	nRst,	$12,	nA5,	$06
	dc.b		nRst,	nA5,	nA5
angry_Loop17:
	dc.b		nA5,	$06,	nRst,	nA5,	nA5,	nA5,	nRst,	nA5
	dc.b		nA5,	nA5,	nRst,	nA5,	nA5,	nA5,	nRst,	nA5
	dc.b		nA5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$1C,	angry_Loop17
	dc.b		nA5,	$06,	nRst,	nA5,	nA5,	nA5,	nRst,	nA5
	dc.b		nA5,	nA5,	nRst,	nA5,	nA5,	nA5,	nRst,	nA5
	dc.b		nA5,	nA5,	nRst,	nA5,	$06,	nA5,	nA5,	nRst
	dc.b		nA5,	$06,	nA5,	nA5,	nRst,	nA5,	nA5,	nA5
	dc.b		nRst,	nA5,	nA5,	nA5,	nRst,	nA5,	nA5,	nA5
	dc.b		nRst,	nA5,	nA5,	nA5,	nRst,	nA5,	nA5,	nA5
	dc.b		nRst,	nA5,	nA5,	nA5,	nRst,	nA5,	nA5,	nA5
	dc.b		$06,	nRst,	nA5,	nA5,	nA5,	nRst,	nA5,	nA5
	dc.b		nA5,	nRst,	nA5,	nA5,	nA5,	nRst,	nA5,	nA5
	dc.b		nA5,	nRst,	nA5,	$06,	nA5,	nA5,	nRst,	nA5
	dc.b		$06,	nA5,	nA5,	nRst,	nA5,	nA5,	nA5,	nRst
	dc.b		nA5,	nA5,	nA5,	nRst,	nA5,	nA5,	nA5,	nRst
	dc.b		nA5,	nA5,	nRst,	$60
angry_Loop18:
	dc.b		nA5,	$06,	nRst,	nA5,	nA5,	nA5,	nRst,	nA5
	dc.b		nA5,	nA5,	nRst,	nA5,	nA5,	nA5,	nRst,	nA5
	dc.b		nA5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	angry_Loop18
;	Jump To	 	location
	smpsJump	angry_Loop16

; DAC Data
angry_DAC:
;	Call At	 	location
	smpsCall	angry_Call06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	angry_DAC
angry_Loop19:
;	Call At	 	location
	smpsCall	angry_Call06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$0E,	angry_Loop19
	dc.b		dSnare,	$0C,	dMidTimpani,	dHiTimpani,	$0C,	dLowTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dHiTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dMidTimpani,	$0C,	dHiTimpani,	dLowTimpani,	dLowTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dHiTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
angry_Loop1A:
;	Call At	 	location
	smpsCall	angry_Call06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	angry_Loop1A
angry_Loop1B:
;	Call At	 	location
	smpsCall	angry_Call06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$0A,	angry_Loop1B
	dc.b		dSnare,	$0C,	dMidTimpani,	dHiTimpani,	$0C,	dLowTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dHiTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dMidTimpani,	$0C,	dHiTimpani,	dLowTimpani,	dLowTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dHiTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
angry_Loop1C:
;	Call At	 	location
	smpsCall	angry_Call06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$0E,	angry_Loop1C
	dc.b		dSnare,	$0C,	dMidTimpani,	dHiTimpani,	$0C,	dLowTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dHiTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dMidTimpani,	$0C,	dHiTimpani,	dLowTimpani,	dLowTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dHiTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
angry_Loop1D:
;	Call At	 	location
	smpsCall	angry_Call06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$0E,	angry_Loop1D
	dc.b		dSnare,	$0C,	dMidTimpani,	dHiTimpani,	$0C,	dLowTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dHiTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dMidTimpani,	$0C,	dHiTimpani,	dLowTimpani,	dLowTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dHiTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
angry_Loop1E:
;	Call At	 	location
	smpsCall	angry_Call06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$0F,	angry_Loop1E
	dc.b		dSnare,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		dLowTimpani,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$06,	dHiTimpani,	dMidTimpani,	dLowTimpani
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
angry_Loop1F:
;	Call At	 	location
	smpsCall	angry_Call06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$07,	angry_Loop1F
	dc.b		dSnare,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		dLowTimpani,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dLowTimpani,	$06,	dLowTimpani
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dHiTimpani,	$06,	dHiTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	$18,	dSnare,	dSnare,	dSnare,	dSnare,	dSnare,	dSnare
	dc.b		dSnare,	dSnare,	dSnare,	dSnare,	dSnare,	dSnare,	dSnare,	$18
	dc.b		dSnare,	dSnare,	dSnare,	dSnare,	dSnare,	dSnare,	dSnare,	dSnare
	dc.b		dSnare,	dSnare,	$18,	dSnare,	dSnare,	$0C,	dHiTimpani,	$06
	dc.b		dMidTimpani,	dHiTimpani,	dMidTimpani,	nRst,	$0C,	dLowTimpani,	$06,	dLowTimpani
	dc.b		dMidTimpani,	dHiTimpani,	$0C,	dLowTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dHiTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
angry_Loop20:
;	Call At	 	location
	smpsCall	angry_Call06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$0E,	angry_Loop20
	dc.b		dSnare,	$0C,	dMidTimpani,	dHiTimpani,	$0C,	dLowTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dHiTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dMidTimpani,	$0C,	dHiTimpani,	dLowTimpani,	dLowTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dHiTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
angry_Loop21:
;	Call At	 	location
	smpsCall	angry_Call06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$0E,	angry_Loop21
	dc.b		dSnare,	$0C,	dMidTimpani,	dHiTimpani,	$0C,	dLowTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dHiTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dMidTimpani,	$0C,	dHiTimpani,	dLowTimpani,	dLowTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dHiTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
angry_Loop22:
;	Call At	 	location
	smpsCall	angry_Call06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$0F,	angry_Loop22
	dc.b		dSnare,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		dLowTimpani,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dHiTimpani,	$06,	dHiTimpani,	dMidTimpani,	dLowTimpani
angry_Loop23:
;	Call At	 	location
	smpsCall	angry_Call06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$07,	angry_Loop23
	dc.b		dSnare,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		dLowTimpani,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dLowTimpani,	$06,	dLowTimpani
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dHiTimpani,	$06,	dHiTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	$18,	dSnare,	dSnare,	dSnare,	dSnare,	dSnare,	dSnare
	dc.b		dSnare,	dSnare,	dSnare,	dSnare,	dSnare,	dSnare,	dSnare,	$18
	dc.b		dSnare,	dSnare,	dSnare,	dSnare,	dSnare,	dSnare,	dSnare,	dSnare
	dc.b		dSnare,	dSnare,	$18,	dSnare,	dSnare,	$0C,	dHiTimpani,	$06
	dc.b		dMidTimpani,	dHiTimpani,	dMidTimpani,	nRst,	$0C
angry_Loop24:
	dc.b		dSnare,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dLowTimpani,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dKick,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		dHiTimpani,	$06,	dHiTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$10,	angry_Loop24
;	Jump To	 	location
	smpsJump	angry_Loop1B

angry_Call06:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		dHiTimpani,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$B4,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		dLowTimpani,	$06,	dLowTimpani,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	smpsReturn

angry_Voices:
;	Voice 00
;	$3A,$00,$03,$00,$02,$15,$13,$16,$12,$0C,$0A,$0B,$0B,$00,$00,$00,$00,$07,$07,$07,$08,$1F,$16,$2D,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$02,	$00,	$03,	$00
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$12,	$16,	$13,	$15
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0B,	$0B,	$0A,	$0C
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$08,	$07,	$07,	$07
	smpsVcTotalLevel	$80,	$2D,	$16,	$1F

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
;	$3B,$71,$01,$31,$31,$14,$0F,$0F,$0F,$14,$05,$05,$00,$00,$00,$00,$00,$F6,$F6,$06,$07,$23,$28,$32,$80
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$00,	$07
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$0F,	$0F,	$0F,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$05,	$05,	$14
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$00,	$0F,	$0F
	smpsVcReleaseRate	$07,	$06,	$06,	$06
	smpsVcTotalLevel	$80,	$32,	$28,	$23

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
;	$3B,$08,$14,$02,$11,$5F,$CF,$08,$59,$0C,$02,$0C,$05,$04,$04,$04,$07,$16,$15,$05,$26,$1D,$36,$0B,$80
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$01,	$00,	$01,	$00
	smpsVcCoarseFreq	$01,	$02,	$04,	$08
	smpsVcRateScale		$01,	$00,	$03,	$01
	smpsVcAttackRate	$19,	$08,	$0F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$0C,	$02,	$0C
	smpsVcDecayRate2	$07,	$04,	$04,	$04
	smpsVcDecayLevel	$02,	$00,	$01,	$01
	smpsVcReleaseRate	$06,	$05,	$05,	$06
	smpsVcTotalLevel	$80,	$0B,	$36,	$1D

;	Voice 05
;	$3C,$01,$02,$0F,$04,$8D,$52,$9F,$1F,$09,$00,$00,$0D,$00,$00,$00,$00,$23,$08,$02,$F7,$15,$80,$1D,$87
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$04,	$0F,	$02,	$01
	smpsVcRateScale		$00,	$02,	$01,	$02
	smpsVcAttackRate	$1F,	$1F,	$12,	$0D
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0D,	$00,	$00,	$09
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$0F,	$00,	$00,	$02
	smpsVcReleaseRate	$07,	$02,	$08,	$03
	smpsVcTotalLevel	$87,	$1D,	$80,	$15

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
;	$30,$30,$30,$30,$30,$9E,$D8,$DC,$DC,$0E,$0A,$04,$05,$08,$08,$08,$08,$B6,$B6,$B6,$B6,$14,$2C,$12,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$03,	$03
	smpsVcCoarseFreq	$00,	$00,	$00,	$00
	smpsVcRateScale		$03,	$03,	$03,	$02
	smpsVcAttackRate	$1C,	$1C,	$18,	$1E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$04,	$0A,	$0E
	smpsVcDecayRate2	$08,	$08,	$08,	$08
	smpsVcDecayLevel	$0B,	$0B,	$0B,	$0B
	smpsVcReleaseRate	$06,	$06,	$06,	$06
	smpsVcTotalLevel	$80,	$12,	$2C,	$14

;	Voice 08
;	$3A,$20,$23,$20,$01,$1E,$1F,$1F,$1F,$0A,$0A,$0B,$0A,$05,$07,$0A,$08,$A4,$85,$96,$77,$21,$25,$28,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$02,	$02,	$02
	smpsVcCoarseFreq	$01,	$00,	$03,	$00
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$0B,	$0A,	$0A
	smpsVcDecayRate2	$08,	$0A,	$07,	$05
	smpsVcDecayLevel	$07,	$09,	$08,	$0A
	smpsVcReleaseRate	$07,	$06,	$05,	$04
	smpsVcTotalLevel	$80,	$28,	$25,	$21

;	Voice 09
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

;	Voice 0A
;	$0C,$00,$00,$06,$01,$19,$59,$D9,$59,$02,$06,$02,$0C,$0A,$0A,$09,$0F,$14,$15,$02,$A5,$14,$80,$1A,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$01
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$06,	$00,	$00
	smpsVcRateScale		$01,	$03,	$01,	$00
	smpsVcAttackRate	$19,	$19,	$19,	$19
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
;	$3B,$3F,$31,$10,$34,$0D,$1F,$0E,$1F,$0A,$0A,$A0,$04,$00,$00,$00,$05,$53,$A0,$15,$A9,$26,$1D,$11,$80
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$01,	$03,	$03
	smpsVcCoarseFreq	$04,	$00,	$01,	$0F
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$0E,	$1F,	$0D
	smpsVcAmpMod		$00,	$05,	$00,	$00
	smpsVcDecayRate1	$04,	$00,	$0A,	$0A
	smpsVcDecayRate2	$05,	$00,	$00,	$00
	smpsVcDecayLevel	$0A,	$01,	$0A,	$05
	smpsVcReleaseRate	$09,	$05,	$00,	$03
	smpsVcTotalLevel	$80,	$11,	$1D,	$26

;	Voice 11
;	$3C,$62,$24,$13,$46,$C9,$AE,$C9,$4E,$03,$05,$03,$05,$01,$00,$01,$00,$22,$26,$22,$27,$11,$83,$10,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$04,	$01,	$02,	$06
	smpsVcCoarseFreq	$06,	$03,	$04,	$02
	smpsVcRateScale		$01,	$03,	$02,	$03
	smpsVcAttackRate	$0E,	$09,	$0E,	$09
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$03,	$05,	$03
	smpsVcDecayRate2	$00,	$01,	$00,	$01
	smpsVcDecayLevel	$02,	$02,	$02,	$02
	smpsVcReleaseRate	$07,	$02,	$06,	$02
	smpsVcTotalLevel	$80,	$10,	$83,	$11

;	Voice 12
;	$3C,$24,$18,$23,$26,$59,$4A,$59,$4A,$03,$05,$03,$05,$00,$00,$00,$00,$22,$27,$22,$27,$1C,$85,$19,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$02,	$02,	$01,	$02
	smpsVcCoarseFreq	$06,	$03,	$08,	$04
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$0A,	$19,	$0A,	$19
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$03,	$05,	$03
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$02,	$02,	$02,	$02
	smpsVcReleaseRate	$07,	$02,	$07,	$02
	smpsVcTotalLevel	$80,	$19,	$85,	$1C

;	Voice 13
;	$3C,$0B,$04,$0A,$01,$1F,$1E,$1F,$1F,$0F,$0E,$11,$10,$13,$0F,$11,$0E,$24,$07,$17,$08,$10,$80,$0B,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$0A,	$04,	$0B
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1E,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$10,	$11,	$0E,	$0F
	smpsVcDecayRate2	$0E,	$11,	$0F,	$13
	smpsVcDecayLevel	$00,	$01,	$00,	$02
	smpsVcReleaseRate	$08,	$07,	$07,	$04
	smpsVcTotalLevel	$80,	$0B,	$80,	$10

;	Voice 14
;	$06,$02,$34,$73,$32,$0A,$8C,$4C,$52,$00,$00,$00,$00,$01,$00,$01,$00,$03,$05,$26,$06,$3D,$85,$80,$90
;				#
	smpsVcAlgorithm		$06
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$07,	$03,	$00
	smpsVcCoarseFreq	$02,	$03,	$04,	$02
	smpsVcRateScale		$01,	$01,	$02,	$00
	smpsVcAttackRate	$12,	$0C,	$0C,	$0A
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$00,	$00,	$00
	smpsVcDecayRate2	$00,	$01,	$00,	$01
	smpsVcDecayLevel	$00,	$02,	$00,	$00
	smpsVcReleaseRate	$06,	$06,	$05,	$03
	smpsVcTotalLevel	$90,	$80,	$85,	$3D

;	Voice 15
;	$3A,$38,$4A,$40,$31,$1F,$DF,$5F,$9F,$0C,$0A,$0C,$0F,$04,$04,$04,$0B,$1F,$FF,$0F,$3F,$1E,$31,$0C,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$04,	$04,	$03
	smpsVcCoarseFreq	$01,	$00,	$0A,	$08
	smpsVcRateScale		$02,	$01,	$03,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$0C,	$0A,	$0C
	smpsVcDecayRate2	$0B,	$04,	$04,	$04
	smpsVcDecayLevel	$03,	$00,	$0F,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$0C,	$31,	$1E

;	Voice 16
;	$40,$01,$03,$00,$01,$15,$13,$16,$12,$0C,$0A,$0B,$0B,$00,$00,$00,$00,$07,$07,$07,$08,$1F,$16,$2D,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$00,	$03,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$12,	$16,	$13,	$15
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0B,	$0B,	$0A,	$0C
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$08,	$07,	$07,	$07
	smpsVcTotalLevel	$80,	$2D,	$16,	$1F

;	Voice 17
;	$3B,$52,$31,$31,$51,$0C,$14,$12,$14,$0C,$00,$0E,$02,$0E,$09,$09,$01,$46,$03,$54,$3A,$1C,$18,$1D,$80
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$05,	$03,	$03,	$05
	smpsVcCoarseFreq	$01,	$01,	$01,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$14,	$12,	$14,	$0C
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$02,	$0E,	$00,	$0C
	smpsVcDecayRate2	$01,	$09,	$09,	$0E
	smpsVcDecayLevel	$03,	$05,	$00,	$04
	smpsVcReleaseRate	$0A,	$04,	$03,	$06
	smpsVcTotalLevel	$80,	$1D,	$18,	$1C

;	Voice 18
;	$0B,$02,$01,$0F,$02,$07,$1F,$09,$1F,$05,$02,$0C,$1F,$00,$04,$00,$00,$3F,$0F,$3F,$0F,$0B,$10,$3A,$80
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$01
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$02,	$0F,	$01,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$09,	$1F,	$07
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$0C,	$02,	$05
	smpsVcDecayRate2	$00,	$00,	$04,	$00
	smpsVcDecayLevel	$00,	$03,	$00,	$03
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$3A,	$10,	$0B

;	Voice 19
;	$3E,$0F,$02,$32,$72,$1F,$1F,$1F,$1F,$00,$18,$00,$00,$00,$0F,$0F,$0F,$20,$9A,$0C,$04,$00,$80,$80,$80
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
	smpsVcReleaseRate	$04,	$0C,	$0A,	$00
	smpsVcTotalLevel	$80,	$80,	$80,	$00

;	Voice 1A
;	$3D,$01,$21,$51,$01,$12,$14,$1A,$0F,$0A,$07,$07,$07,$00,$00,$00,$00,$2B,$2B,$2B,$18,$19,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$05,	$02,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$0F,	$1A,	$14,	$12
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$07,	$07,	$07,	$0A
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$01,	$02,	$02,	$02
	smpsVcReleaseRate	$08,	$0B,	$0B,	$0B
	smpsVcTotalLevel	$80,	$80,	$80,	$19
	even
