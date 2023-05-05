; =============================================================================================
; Project Name:		subspace
; Created:		3rd October 2015
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

subspace_Header:
;	Voice Pointer	location
	smpsHeaderVoice	subspace_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$02,	$11

;	DAC Pointer	location
	smpsHeaderDAC	subspace_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	subspace_FM1,	smpsPitch00+$01,	$08
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	subspace_FM2,	smpsPitch00+$01,	$12
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	subspace_FM3,	smpsPitch00+$01,	$19
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	subspace_FM4,	smpsPitch00+$01,	$13
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	subspace_FM5,	smpsPitch00+$01,	$13
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	subspace_PSG1,	smpsPitch02lo,	$05,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	subspace_PSG2,	smpsPitch02lo,	$06,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	subspace_PSG3,	smpsPitch00,	$02,	$00

; FM1 Data
subspace_FM1:
;	Alter Notes	value
	smpsAlterNote	$05
subspace_Jump01:
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$F7,	$FF
;	Set FM Voice	#
	smpsFMvoice	$00
;	Alter Volume	value
	smpsAlterVol	$FD
	dc.b		nE2,	$0C,	nRst,	$24,	nRst,	nRst,	$06,	nD2
	dc.b		nE2,	nE2,	nRst,	$24,	nRst,	nRst,	$06,	nD2
	dc.b		nE2,	$0C,	nRst,	$24,	nRst,	nRst,	$06,	nD2
	dc.b		nE2,	$0C,	nRst,	$24,	nRst,	$12,	nD2,	$0C
	dc.b		nA2,	$12
;	Alter Volume	value
	smpsAlterVol	$03
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$01,	$01
;	Set FM Voice	#
	smpsFMvoice	$10
;	Alter Pitch	value
	smpsAlterPitch	$F4
	dc.b		nG2,	$06,	nG2,	nG3,	nA2,	$0C,	nA2,	$06
	dc.b		nA3,	nG2,	$12,	nG3,	$06,	nA2,	$1E,	nG2
	dc.b		$06,	nG2,	nG3,	nA2,	$0C,	nA3,	nA2,	$06
	dc.b		nB2,	nB3,	nB2,	nA3,	$12
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$F5,	$FF
;	Alter Volume	value
	smpsAlterVol	$F9
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nE3,	$0C
;	Alter Volume	value
	smpsAlterVol	$07
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$01,	$01
;	Set FM Voice	#
	smpsFMvoice	$10
	dc.b		nG2,	$06,	nG2,	nG3,	nA2,	$0C,	nA3,	$12
	dc.b		nG2,	$06,	nG3,	nG2,	nA2,	$1E,	nG2,	$06
	dc.b		nG3,	nG2,	nA2,	$0C,	nA3,	$12,	nB2,	$06
	dc.b		nB3,	nB2,	nG3,	$0C,	nA2,	$06,	nA3,	nG3
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$05,	$F7,	$FF
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nE2,	nE2,	nRst,	nB2,	nE3,	nB2,	$03,	nD3
	dc.b		$09,	nE3,	$06,	nE2,	nE2,	nRst,	nB2,	nE3
	dc.b		nB2,	$03,	nD3,	$09,	nE3,	$06,	nE2,	nE2
	dc.b		nRst,	nB2,	nE3,	nB2,	$03,	nD3,	$09,	nE3
	dc.b		$06,	nE2,	nE2,	nRst,	nE2,	nE3,	nB2,	$03
	dc.b		nD3,	$09,	nE3,	$06,	nE2,	nE2,	nRst,	nB2
	dc.b		nE3,	nB2,	$03,	nD3,	$09,	nE3,	$06,	nE2
	dc.b		nE2,	nRst,	nB2,	nE3,	nB2,	$03,	nD3,	$09
	dc.b		nE3,	$06,	nE2,	nE2,	nRst,	nB2,	nE3,	nB2
	dc.b		$03,	nD3,	$09,	nE3,	$06,	nE2,	nE2,	nRst
	dc.b		nB2,	nG3,	nA2,	$03,	nF3,	$09,	nD3,	$06
	dc.b		nE2,	nE2,	nRst,	nB2,	nE3,	nA2,	$03,	nD3
	dc.b		$09,	nE3,	$06,	nE2,	nE2,	nRst,	nB2,	nE3
	dc.b		nB2,	$03,	nD3,	$09,	nE3,	$06,	nE2,	nE2
	dc.b		nRst,	nB2,	nE3,	nA2,	$03,	nD3,	$09,	nE3
	dc.b		$06,	nE2,	nE2,	nRst,	nB2,	nE3,	nA2,	$03
	dc.b		nD3,	$09,	nE3,	$06,	nE2,	nE2,	nRst,	nB2
	dc.b		nE3,	nB2,	$03,	nD3,	$09,	nE3,	$06,	nE2
	dc.b		nE2,	nRst,	nB2,	nE3,	nA2,	$03,	nD3,	$09
	dc.b		nE3,	$06,	nE2,	nE2,	nRst,	nB2,	nE3,	nB2
	dc.b		$03,	nD3,	$09,	nE3,	$06,	nE2,	nE2,	nRst
	dc.b		nB2,	nG3,	nA2,	$03,	nF3,	$09,	nD3,	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$08,	$04
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Set FM Voice	#
	smpsFMvoice	$14
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nAb2,	$06,	nAb2,	nAb3,	nG3,	$03,	nAb3,	$06
	dc.b		nG3,	$03,	nAb2,	$06,	nAb3,	nG3,	$03,	nAb3
	dc.b		nRst,	nAb3,	nAb2,	$06,	nRst,	nAb2,	nAb3,	nG3
	dc.b		$03,	nAb3,	nRst,	$06,	nAb3,	nG2,	$06,	nG2
	dc.b		nG3,	nF3,	$03,	nG3,	nRst,	nG3,	nG2,	$06
	dc.b		nG3,	nF3,	$03,	nG3,	nRst,	nG3,	nG2,	$06
	dc.b		nRst,	nG2,	nG2,	$09,	nG3,	$03,	nRst,	$06
	dc.b		nG2,	nAb2,	$06,	nAb2,	nAb3,	nG3,	$03,	nAb3
	dc.b		nRst,	nAb3,	nAb2,	$06,	nAb3,	nG3,	$03,	nAb3
	dc.b		nRst,	nAb3,	nAb2,	$06,	nAb2,	$0C,	nAb3,	$09
	dc.b		nAb2,	$03,	nRst,	$06,	nAb3,	nRst,	nG3,	nAb3
	dc.b		nAb2,	nG3,	$09,	nF3,	$03,	nRst,	$06,	nG3
	dc.b		nG2,	nF3,	nEb3,	nG2,	nD3,	nG2,	nC3,	nD3
;	Alter Pitch	value
	smpsAlterPitch	$0C
	dc.b		nEb2,	nEb2,	nEb3,	nD3,	$03,	nEb3,	nRst,	nEb3
	dc.b		nEb2,	$06,	nEb3,	nD3,	$03,	nEb3,	nRst,	nEb3
	dc.b		nEb2,	$06,	nEb3,	$0C,	nEb3,	$09,	nEb2,	$03
	dc.b		nRst,	$06,	nEb3,	nD2,	nD2,	nD3,	nC3,	$03
	dc.b		nD3,	nRst,	nD3,	nD2,	$06,	nD3,	nC3,	$03
	dc.b		nD3,	nRst,	$06,	nCs2,	nCs3,	$0C,	nBb2,	$06
	dc.b		nCs3,	$03,	nBb2,	nRst,	$06,	nAb3,	nC2,	$06
	dc.b		nC2,	nC3,	nBb2,	$03,	nC3,	nRst,	nC3,	nC2
	dc.b		$06,	nC3,	nD2,	$03,	nC2,	nBb2,	$06,	nBb2
	dc.b		nBb3,	nA3,	$03,	nBb3,	nRst,	nBb3,	nBb2,	$06
	dc.b		nA2,	nBb2
;	Alter Volume	value
	smpsAlterVol	$04
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$F7,	$FF
;	Set FM Voice	#
	smpsFMvoice	$03
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nBb2,	$03,	nBb2,	nBb2,	$06,	nBb2,	nBb2,	$03
	dc.b		nBb2,	nBb2,	nBb2,	nBb2,	$06,	nBb2,	nBb2,	$03
	dc.b		nBb2,	nRst,	nBb2,	nBb2,	$06,	nBb2,	nBb2,	$03
	dc.b		nBb2,	nBb2,	$08,	nBb2,	nBb2
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nRst,	$24
;	Set FM Voice	#
	smpsFMvoice	$00
subspace_Loop01:
	dc.b		nE2,	$06,	nE2,	$03,	nE2,	nE2,	nE2,	nE2
	dc.b		$06,	nE2,	$03,	nE2,	nE2,	nE2,	nE2,	$06
	dc.b		nE2,	$03,	nE2,	nE2,	nE2,	nE2,	$06,	nE2
	dc.b		$03,	nE2,	nE3,	nE2
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	subspace_Loop01
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$05,	$F7,	$FF
	dc.b		nB2,	$03,	nE3,	nG3,	nB2,	nF3,	$18,	nRst
	dc.b		$08,	nF2,	nF3,	nE3,	nF2,	nD3,	nRst,	$12
;	Jump To	 	location
	smpsJump	subspace_Jump01

; FM2 Data
subspace_FM2:
;	Alter Notes	value
	smpsAlterNote	$05
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$06,	$03
subspace_Jump02:
;	Set FM Voice	#
	smpsFMvoice	$0A
;	Alter Volume	value
	smpsAlterVol	$FD
	dc.b		nE4,	$0C
;	Alter Volume	value
	smpsAlterVol	$03
;	Alter Volume	value
	smpsAlterVol	$09
;	Set FM Voice	#
	smpsFMvoice	$13
	dc.b		nRst,	$03,	nD5,	$3C,	nCs5,	$09,	nB4,	$15
	dc.b		nA4,	$0C,	nE4,	$1E,	nRst,	$03,	nA3,	smpsNoAttack
	dc.b		nB3,	nCs4,	smpsNoAttack,	nD4,	smpsNoAttack,	nB3,	smpsNoAttack,	nCs4
	dc.b		nD4,	$06,	nE4,	$03,	nFs4,	nE4,	smpsNoAttack,	nFs4
;	Alter Volume	value
	smpsAlterVol	$F7
;	Alter Volume	value
	smpsAlterVol	$FD
;	Set FM Voice	#
	smpsFMvoice	$0A
	dc.b		nE4,	$06,	nE4,	$0C
;	Alter Volume	value
	smpsAlterVol	$03
;	Alter Volume	value
	smpsAlterVol	$09
;	Set FM Voice	#
	smpsFMvoice	$13
	dc.b		nRst,	$03,	nD5,	$0C,	nB4,	$03,	nA4,	smpsNoAttack
	dc.b		nB4,	nCs5,	smpsNoAttack,	nD5,	smpsNoAttack,	nE5,	nFs5,	nA5
	dc.b		$15,	nG5,	$03,	nB5,	nA5,	nG5,	nE5,	nG5
	dc.b		$18,	nFs5,	$09,	nCs5,	$0C,	nE5,	$06,	nA4
	dc.b		$24,	nRst,	$0F
;	Alter Volume	value
	smpsAlterVol	$F7
;	Alter Volume	value
	smpsAlterVol	$FD
;	Set FM Voice	#
	smpsFMvoice	$0A
	dc.b		nE4,	$06
;	Alter Volume	value
	smpsAlterVol	$03
;	Set FM Voice	#
	smpsFMvoice	$08
;	Alter Volume	value
	smpsAlterVol	$FF
subspace_Loop02:
	dc.b		nE5,	$06,	nRst
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$20,	subspace_Loop02
;	Alter Volume	value
	smpsAlterVol	$01
;	Set FM Voice	#
	smpsFMvoice	$0F
	dc.b		nE4,	$12,	nE5,	$2A,	nE4,	$0C,	nF4,	$09
	dc.b		nE5,	nD5,	$06,	nC5,	$09,	nB4,	nD4,	$3F
	dc.b		nC4,	$09,	nA4,	$0F,	nB4,	$09,	nG4,	$27
	dc.b		nF4,	$09,	nE4,	$06,	nD4,	$09,	nC4,	nF4
	dc.b		$0F,	nE4,	$09,	nB3,	$4E,	nE4,	$12,	nE5
	dc.b		$2A,	nE4,	$0C,	nF4,	$09,	nE5,	nD5,	$06
	dc.b		nC5,	$09,	nB4,	nD4,	$3F,	nC4,	$09,	nF4
	dc.b		$0F,	nE4,	$09,	nB4,	$0F,	nA4,	$09,	nD5
	dc.b		$27,	nC5,	$09,	nD5,	$06,	nE5,	$09,	nB4
	dc.b		$30,	nA4,	$09,	nD5,	$06,	nC5,	$09,	nB4
	dc.b		nG4,	$06
;	Set FM Voice	#
	smpsFMvoice	$07
;	Alter Pitch	value
	smpsAlterPitch	$0C
	dc.b		nD5,	$30,	nD5,	$12,	nBb4,	nC5,	$0C,	nD5
	dc.b		$09,	nBb4,	$21,	nBb4,	$06,	nA4,	$09,	nF4
	dc.b		$27,	nD5,	$24,	nRst,	$06,	nD5,	$03,	nEb5
	dc.b		nF5,	$09,	nEb5,	nD5,	$0F,	nBb4,	$09,	nD5
	dc.b		$06,	nD5,	$30,	nEb5,	$09,	nD5,	nF5,	$06
	dc.b		nEb5,	$09,	nD5,	nBb4,	$06
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Set FM Voice	#
	smpsFMvoice	$0F
;	Alter Pitch	value
	smpsAlterPitch	$0C
	dc.b		nA4,	$12,	nBb4,	$2A,	nF4,	$0C,	nC5,	$08
	dc.b		nBb4,	nA4,	nA4,	$12,	nBb4,	nF4,	$12,	nEb4
	dc.b		$18,	nF4,	$06,	nFs4,	nAb4,	nBb4,	$08,	nC5
	dc.b		nEb5,	nEb5,	nD5,	nC5,	nBb4,	nAb4,	nEb4,	$14
	dc.b		nF4,	$0C
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Set FM Voice	#
	smpsFMvoice	$0A
	dc.b		nFs3,	$12,	nC4,	nF3,	nCs4,	nAb3,	$08,	nFs3
	dc.b		nD4,	nRst,	$24,	nE3,	$06,	nE4,	nE3,	nF3
	dc.b		nF4,	nF3,	nD3,	nD4,	nD3,	nE3,	nE4,	nE3
	dc.b		nE3,	nE4,	nE3,	nF3,	nF4,	nF3,	nG3,	nG4
	dc.b		nG3,	nF4,	nF3,	nF4
;	Set FM Voice	#
	smpsFMvoice	$09
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		nB3,	$03,	nE4,	nG4,	nB3,	nF4,	$18
;	Alter Volume	value
	smpsAlterVol	$FD
;	Set FM Voice	#
	smpsFMvoice	$06
	dc.b		nRst,	$08,	nF2,	nF3,	nE3,	nF2,	nD3,	nRst
	dc.b		$12
;	Jump To	 	location
	smpsJump	subspace_Jump02

; FM3 Data
subspace_FM3:
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$0F,	$01,	$04
;	Alter Notes	value
	smpsAlterNote	$0F
	dc.b		nRst,	$05
;	Jump To	 	location
	smpsJump	subspace_Jump02

; FM4 Data
subspace_FM4:
	dc.b		nRst,	$01
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$08,	$04
subspace_Jump03:
;	Alter Notes	value
	smpsAlterNote	$0C
;	Set FM Voice	#
	smpsFMvoice	$0C
;	Alter Volume	value
	smpsAlterVol	$FF
	dc.b		nE4,	$03,	nA4,	nB4,	nD5,	nE4,	nRst,	nD5
	dc.b		nRst,	nE4,	nRst,	nCs5,	nRst,	nE4,	nRst,	nA4
	dc.b		nRst,	nB4,	nA4,	nE4,	nD5,	nE4,	nRst,	nCs5
	dc.b		nRst,	nA4,	nRst,	nE4,	nRst,	nB4,	nRst,	nA4
	dc.b		nD4,	nRst,	nRst,	nE4,	nRst,	nA4,	nRst,	nB4
	dc.b		nE4,	nE5,	nRst,	nE4,	nRst,	nD5,	nRst,	nE4
	dc.b		nRst,	nCs5,	nE4,	nA4,	nB4,	nE4,	nRst,	nCs5
	dc.b		nRst,	nD5,	nRst,	nCs5,	nRst,	nB4,	nRst,	nA4
	dc.b		nRst,	nE4,	nA4,	nB4,	nD5,	nE4,	nRst,	nD5
	dc.b		nRst,	nE4,	nRst,	nCs5,	nRst,	nE4,	nRst,	nA4
	dc.b		nB4,	nCs5,	nRst,	nE4,	nRst,	nD5,	nRst,	nCs5
	dc.b		nRst,	nB4,	nRst,	nA4,	nRst,	nG4,	nRst,	nE4
	dc.b		nRst,	nA4,	nE4,	nG4,	nA4,	nB4,	nRst,	nE4
	dc.b		nRst,	nE4,	nRst,	nCs5,	nRst,	nE4,	nRst,	nD5
	dc.b		nRst,	nA4,	nRst,	nB4,	nRst,	nCs5,	nRst,	nD5
	dc.b		nRst,	nA4,	nRst,	nG4,	nRst,	nFs4,	nRst,	nE4
	dc.b		nRst
;	Alter Volume	value
	smpsAlterVol	$01
;	Alter Notes	value
	smpsAlterNote	$0F
;	Set FM Voice	#
	smpsFMvoice	$0B
;	Alter Volume	value
	smpsAlterVol	$F9
	dc.b		nG2,	$06,	nG2,	nG3,	nA2,	$0C,	nA2,	$06
	dc.b		nA3,	nG2,	$12,	nG3,	$06,	nA2,	$1E,	nG2
	dc.b		$06,	nG2,	nG3,	nA2,	$0C,	nA3,	nA2,	$06
	dc.b		nB2,	nB3,	nB2,	nA3,	$12,	nRst,	$0C,	nG2
	dc.b		$06,	nG2,	nG3,	nA2,	$0C,	nA3,	$12,	nG2
	dc.b		$06,	nG3,	nG2,	nA2,	$1E,	nG2,	$06,	nG3
	dc.b		nG2,	nA2,	$0C,	nA3,	$12,	nB2,	$06,	nB3
	dc.b		nB2,	nG3,	$0C,	nA2,	$06,	nA3,	nG3
;	Alter Volume	value
	smpsAlterVol	$07
;	Alter Notes	value
	smpsAlterNote	$0C
;	Set FM Voice	#
	smpsFMvoice	$07
	dc.b		nE4,	$12,	nE5,	$2A,	nE4,	$0C,	nF4,	$09
	dc.b		nE5,	nD5,	$06,	nC5,	$09,	nB4,	nD4,	$3F
	dc.b		nC4,	$09,	nA4,	$0F,	nB4,	$09,	nG4,	$27
	dc.b		nF4,	$09,	nE4,	$06,	nD4,	$09,	nC4,	nF4
	dc.b		$0F,	nE4,	$09,	nB3,	$4E,	nE4,	$12,	nE5
	dc.b		$2A,	nE4,	$0C,	nF4,	$09,	nE5,	nD5,	$06
	dc.b		nC5,	$09,	nB4,	nD4,	$3F,	nC4,	$09,	nF4
	dc.b		$0F,	nE4,	$09,	nB4,	$0F,	nA4,	$09,	nD5
	dc.b		$27,	nC5,	$09,	nD5,	$06,	nE5,	$09,	nB4
	dc.b		$30,	nA4,	$09,	nD5,	$06,	nC5,	$09,	nB4
	dc.b		nG4,	$06
;	Set FM Voice	#
	smpsFMvoice	$08
	dc.b		nD5,	$30,	nD5,	$12,	nBb4,	nC5,	$0C,	nD5
	dc.b		$09,	nBb4,	$21,	nBb4,	$06,	nA4,	$09,	nF4
	dc.b		$27,	nD5,	$24,	nRst,	$06,	nD5,	$03,	nEb5
	dc.b		nF5,	$09,	nEb5,	nD5,	$0F,	nBb4,	$09,	nD5
	dc.b		$06,	nD5,	$30,	nEb5,	$09,	nD5,	nF5,	$06
	dc.b		nEb5,	$09,	nD5,	nBb4,	$06
;	Set FM Voice	#
	smpsFMvoice	$07
	dc.b		nC4,	$12,	nD4,	$2A,	nC4,	$0C,	nA4,	$08
	dc.b		nG4,	nF4,	nC4,	$12,	nD4,	nF4,	$12,	nEb4
	dc.b		$18,	nF4,	$06,	nFs4,	nAb4,	nF4,	$08,	nG4
	dc.b		nBb4,	nBb4,	nA4,	nG4,	nF4,	nEb4,	nB3,	$14
	dc.b		nCs4,	$0C
;	Set FM Voice	#
	smpsFMvoice	$0A
	dc.b		nAb2,	$12,	nD3,	nG2,	nEb3,	nB2,	$08,	nA2
	dc.b		nF3,	nRst,	$24
;	Alter Pitch	value
	smpsAlterPitch	$0C
	dc.b		nE3,	$06,	nE4,	nE3,	nF3,	nF4,	nF3,	nD3
	dc.b		nD4,	nD3,	nE3,	nE4,	nE3,	nE3,	nE4,	nE3
	dc.b		nF3,	nF4,	nF3,	nG3,	nG4,	nG3,	nF4,	nF3
	dc.b		nF4
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Set FM Voice	#
	smpsFMvoice	$0C
	dc.b		nB2,	$03,	nE3,	nG3,	nB2,	nF3,	$18
;	Set FM Voice	#
	smpsFMvoice	$05
	dc.b		nRst,	$08,	nF2,	nF3,	nE3,	nF2,	nD3,	nRst
	dc.b		$12
;	Jump To	 	location
	smpsJump	subspace_Jump03

; FM5 Data
subspace_FM5:
;	Alter Notes	value
	smpsAlterNote	$12
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$04,	$FE,	$FF
	dc.b		nRst,	$01
subspace_Jump04:
;	Alter Volume	value
	smpsAlterVol	$F8
;	Set FM Voice	#
	smpsFMvoice	$0F
	dc.b		nE6,	$06,	nRst
;	Alter Volume	value
	smpsAlterVol	$08
;	Set FM Voice	#
	smpsFMvoice	$13
	dc.b		nD5,	$3C,	nCs5,	$09,	nB4,	$15,	nA4,	$0C
	dc.b		nE4,	$1E,	nRst,	$03,	nA3,	smpsNoAttack,	nB3,	nCs4
	dc.b		smpsNoAttack,	nD4,	smpsNoAttack,	nB3,	smpsNoAttack,	nCs4,	nD4,	$06
	dc.b		nE4,	$03,	nFs4,	nE4,	smpsNoAttack,	nFs4,	nG4,	smpsNoAttack
	dc.b		nB4,	nA4
;	Alter Volume	value
	smpsAlterVol	$F8
;	Set FM Voice	#
	smpsFMvoice	$0F
	dc.b		nE6,	$06,	nRst
;	Alter Volume	value
	smpsAlterVol	$08
;	Set FM Voice	#
	smpsFMvoice	$13
	dc.b		nD5,	$0C,	nB4,	$03,	nA4,	smpsNoAttack,	nB4,	nCs5
	dc.b		smpsNoAttack,	nD5,	smpsNoAttack,	nE5,	nFs5,	nA5,	$15,	nG5
	dc.b		$03,	nB5,	nA5,	nG5,	nE5,	nG5,	$18,	nFs5
	dc.b		$09,	nCs5,	$0C,	nE5,	$06,	nA4,	$24
;	Set FM Voice	#
	smpsFMvoice	$0A
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nRst,	$02,	nRst,	$06,	nB4,	nD5,	$0C,	nG5
	dc.b		$12,	nA5,	$0C,	nD5,	nCs5,	nFs5,	nA4,	nB4
	dc.b		$12,	nRst,	$06,	nD5,	$0C,	nCs5,	nB4,	nE5
	dc.b		nFs5,	nD5,	nCs5,	$06,	nD5,	nB5,	$12,	nA5
	dc.b		$06,	nD5,	$12,	nA5,	nG5,	$06,	nB4,	$12
	dc.b		nA4,	$06,	nB4,	nE5,	$0C,	nB4,	nFs5,	nD5
	dc.b		$06,	nA5,	$1E,	nB5,	$0C,	nD6,	$10
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Alter Volume	value
	smpsAlterVol	$04
;	Set FM Voice	#
	smpsFMvoice	$09
;	Alter Volume	value
	smpsAlterVol	$02
;	Alter Pitch	value
	smpsAlterPitch	$F4
	dc.b		nG3,	$30,	nA3,	nB3,	nA3,	nG3,	nA3,	nB3
	dc.b		nA3,	$09,	nG3,	$0F,	nF3,	$09,	nE3,	$0F
;	Alter Pitch	value
	smpsAlterPitch	$0C
subspace_Loop03:
	dc.b		nB3,	$03,	nRst,	nE4,	nRst,	nG4,	nRst,	nB3
	dc.b		nE4,	nRst,	nG4,	nRst,	nB3,	nE4,	nRst,	nG4
	dc.b		nRst,	nC4,	nRst,	nF4,	nRst,	nG4,	nRst,	nC4
	dc.b		nF4,	nRst,	nG4,	nRst,	nC4,	nF4,	nRst,	nG4
	dc.b		nRst
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	subspace_Loop03
;	Alter Volume	value
	smpsAlterVol	$FE
;	Set FM Voice	#
	smpsFMvoice	$0D
;	Alter Volume	value
	smpsAlterVol	$FE
subspace_Loop04:
	dc.b		nD6,	$06,	nRst
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$20,	subspace_Loop04
;	Alter Volume	value
	smpsAlterVol	$02
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$08,	$03
;	Set FM Voice	#
	smpsFMvoice	$0D
;	Alter Pitch	value
	smpsAlterPitch	$0C
	dc.b		nF4,	$12,	nF4,	$2A,	nC4,	$0C,	nA4,	$08
	dc.b		nG4,	nF4,	nF4,	$12,	nF4,	nF4,	$12,	nEb4
	dc.b		$18,	nF4,	$06,	nFs4,	nAb4,	nF4,	$08,	nG4
	dc.b		nBb4,	nBb4,	nA4,	nG4,	nF4,	nEb4,	nB3,	$14
	dc.b		nCs4,	$0C
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$04,	$FE,	$FF
;	Set FM Voice	#
	smpsFMvoice	$0A
	dc.b		nCs3,	$12,	nG3,	nC3,	nAb3,	nEb3,	$08,	nCs3
	dc.b		nA3,	nRst,	$24
;	Set FM Voice	#
	smpsFMvoice	$04
;	Alter Pitch	value
	smpsAlterPitch	$0C
	dc.b		nE3,	$02,	nG3,	nB3,	nE4,	nG4,	nG3,	nB3
	dc.b		nE4,	nE3,	nG3,	nB3,	nG3,	nE4,	nE3,	nB3
	dc.b		nG3,	nB3,	nE3,	nE3,	nF3,	nC4,	nA3,	nF4
	dc.b		nF3,	nC4,	nA3,	nA4,	nF3,	nF4,	nA3,	nF4
	dc.b		nC4,	nF4,	nF3,	nA3,	nC4,	nE3,	nG3,	nE4
	dc.b		nE3,	nB3,	nG3,	nE4,	nE3,	nG4,	nG3,	nB3
	dc.b		nE4,	nG3,	nB3,	nG4,	nG3,	nE4,	nB4,	nE3
	dc.b		nF3,	nA3,	nF4,	nC4,	nA4,	nF4,	nC5,	nA4
	dc.b		nF4,	nC4,	nA3,	nF3,	nA3,	nC4,	nA4,	nF4
	dc.b		nC5
;	Alter Pitch	value
	smpsAlterPitch	$F4
	dc.b		nB2,	$03,	nE3,	nG3,	nB2,	nF3,	$18
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nRst,	$08,	nF2,	nF3,	nE3,	nF2,	nD3,	nRst
	dc.b		$12
;	Jump To	 	location
	smpsJump	subspace_Jump04

; PSG1 Data
subspace_PSG1:
;	Alter Notes	value
	smpsAlterNote	$01
;	Alter Pitch	value
	smpsAlterPitch	$FF
subspace_Jump06:
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$FE,	$EF
;	Alter Pitch	value
	smpsAlterPitch	$F4
	dc.b		nE4,	$03,	nA4,	nB4,	nD5,	nE4,	nRst,	nD5
	dc.b		nRst,	nE4,	nRst,	nCs5,	nRst,	nE4,	nRst,	nA4
	dc.b		nRst,	nB4,	nA4,	nE4,	nD5,	nE4,	nRst,	nCs5
	dc.b		nRst,	nA4,	nRst,	nE4,	nRst,	nB4,	nRst,	nA4
	dc.b		nD4,	nRst,	nRst,	nE4,	nRst,	nA4,	nRst,	nB4
	dc.b		nE4,	nE5,	nRst,	nE4,	nRst,	nD5,	nRst,	nE4
	dc.b		nRst,	nCs5,	nE4,	nA4,	nB4,	nE4,	nRst,	nCs5
	dc.b		nRst,	nD5,	nRst,	nCs5,	nRst,	nB4,	nRst,	nA4
	dc.b		nRst,	nE4,	nA4,	nB4,	nD5,	nE4,	nRst,	nD5
	dc.b		nRst,	nE4,	nRst,	nCs5,	nRst,	nE4,	nRst,	nA4
	dc.b		nB4,	nCs5,	nRst,	nE4,	nRst,	nD5,	nRst,	nCs5
	dc.b		nRst,	nB4,	nRst,	nA4,	nRst,	nG4,	nRst,	nE4
	dc.b		nRst,	nA4,	nE4,	nG4,	nA4,	nB4,	nRst,	nE4
	dc.b		nRst,	nE4,	nRst,	nCs5,	nRst,	nE4,	nRst,	nD5
	dc.b		nRst,	nA4,	nRst,	nB4,	nRst,	nCs5,	nRst,	nD5
	dc.b		nRst,	nA4,	nRst
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Set Volume	value
	smpsSetVol	$FF
	dc.b		nB4,	$06,	nD5,	$0C
subspace_Jump05:
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1F,	$01,	$04,	$04
	dc.b		nG5,	$12,	nA5,	$0C,	nD5,	nCs5,	nFs5,	nA4
	dc.b		nB4,	$12,	nRst,	$06,	nD5,	$0C,	nCs5,	nB4
	dc.b		nE5,	nFs5,	nD5,	nCs5,	$06,	nD5,	nB5,	$12
	dc.b		nA5,	$06,	nD5,	$12,	nA5,	nG5,	$06,	nB4
	dc.b		$12,	nA4,	$06,	nB4,	nE5,	$0C,	nB4,	nFs5
	dc.b		nD5,	$06,	nA5,	$1E,	nB5,	$0C
;	Set Volume	value
	smpsSetVol	$01
;	Set Volume	value
	smpsSetVol	$FE
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$0F,	$FF
	dc.b		nD4,	$12
;	Set Volume	value
	smpsSetVol	$02
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1F,	$01,	$04,	$04
	dc.b		nB3,	$30,	nC4,	nD4,	nC4,	nB3,	nC4,	nD4
	dc.b		nC4,	$09,	nB3,	$0F,	nA3,	$09,	nG3,	$0F
;	Alter Pitch	value
	smpsAlterPitch	$F4
	dc.b		nB3,	$30,	nC4,	nD4,	nC4,	nB3,	nC4,	nD4
	dc.b		nE4,	$09,	nD4,	nC4,	$06,	nB3,	$09,	nA3
	dc.b		nD4,	$06
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Set Volume	value
	smpsSetVol	$FF
;	Alter Pitch	value
	smpsAlterPitch	$F4
	dc.b		nBb4,	$30,	nBb4,	$12,	nF4,	nG4,	$0C,	nBb4
	dc.b		$09,	nG4,	$21,	nG4,	$06,	nF4,	$09,	nD4
	dc.b		$27,	nBb4,	$24,	nRst,	$06,	nBb4,	$03,	nC5
	dc.b		nD5,	$09,	nC5,	nBb4,	$0F,	nF4,	$09,	nBb4
	dc.b		$06,	nBb4,	$30,	nC5,	$09,	nBb4,	nD5,	$06
	dc.b		nC5,	$09,	nBb4,	nG4,	$06
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Set Volume	value
	smpsSetVol	$01
	dc.b		nF4,	$12,	nF4,	$2A,	nC4,	$0C,	nA4,	$08
	dc.b		nG4,	nF4,	nF4,	$12,	nF4,	nF4,	$12,	nEb4
	dc.b		$18,	nF4,	$06,	nFs4,	nAb4,	nF4,	$08,	nG4
	dc.b		nBb4,	nBb4,	nA4,	nG4,	nF4,	nEb4,	nB3,	$14
	dc.b		nCs4,	$0C,	nCs4,	$12,	nG4,	nC4,	nAb4,	nEb4
	dc.b		$08,	nCs4,	nA4
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$FB,	$FF
	dc.b		nA3,	$24
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$FE,	$EF
;	Alter Pitch	value
	smpsAlterPitch	$0C
	dc.b		nE3,	$02,	nG3,	nB3,	nE4,	nG4,	nG3,	nB3
	dc.b		nE4,	nE3,	nG3,	nB3,	nG3,	nE4,	nE3,	nB3
	dc.b		nG3,	nB3,	nE3,	nE3,	nF3,	nC4,	nA3,	nF4
	dc.b		nF3,	nC4,	nA3,	nA4,	nF3,	nF4,	nA3,	nF4
	dc.b		nC4,	nF4,	nF3,	nA3,	nC4,	nE3,	nG3,	nE4
	dc.b		nE3,	nB3,	nG3,	nE4,	nE3,	nG4,	nG3,	nB3
	dc.b		nE4,	nG3,	nB3,	nG4,	nG3,	nE4,	nB4,	nE3
	dc.b		nF3,	nA3,	nF4,	nC4,	nA4,	nF4,	nC5,	nA4
	dc.b		nF4,	nC4,	nA3,	nF3,	nA3,	nC4,	nA4,	nF4
	dc.b		nC5
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1F,	$01,	$04,	$04
	dc.b		nB2,	$03,	nE3,	nG3,	nB2,	nF3,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$0F,	$FF
;	Set Volume	value
	smpsSetVol	$FE
	dc.b		nRst,	$08,	nF3,	nF4,	nE4,	nF3,	nD4
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nRst,	$12
;	Set Volume	value
	smpsSetVol	$FF
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$EC,	$FB
	dc.b		nE4,	$30,	nE4,	nE4,	nE4
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$3C,	$FB
	dc.b		nE4,	nG4,	nB4
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$EC,	$FB
	dc.b		nE5,	$18
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$FE,	$F3
	dc.b		nRst,	$06,	nB4,	$06,	nD5,	$0C
;	Jump To	 	location
	smpsJump	subspace_Jump05

; PSG2 Data
subspace_PSG2:
;	Alter Notes	value
	smpsAlterNote	$02
	dc.b		nRst,	$09
;	Alter Pitch	value
	smpsAlterPitch	$FF
;	Jump To	 	location
	smpsJump	subspace_Jump06

; PSG3 Data
subspace_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
;	Alter Notes	value
	smpsAlterNote	$01
subspace_Loop05:
;	Note Fill	duration
	smpsNoteFill	$02
	dc.b		nA5,	$06,	nA5,	nA5,	nA5,	$03
;	Note Fill	duration
	smpsNoteFill	$04
	dc.b		nA5
;	Note Fill	duration
	smpsNoteFill	$02
	dc.b		nA5,	nA5,	nA5,	$06,	nA5,	nA5,	$03
;	Note Fill	duration
	smpsNoteFill	$04
	dc.b		nA5
;	Note Fill	duration
	smpsNoteFill	$02
	dc.b		nA5,	$06,	nA5,	nA5,	nA5,	$03
;	Note Fill	duration
	smpsNoteFill	$04
	dc.b		nA5
;	Note Fill	duration
	smpsNoteFill	$02
	dc.b		nA5,	nA5,	nA5,	$06,	nA5
;	Note Fill	duration
	smpsNoteFill	$04
	dc.b		nA5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$17,	subspace_Loop05
;	Note Fill	duration
	smpsNoteFill	$02
subspace_Loop06:
	dc.b		nA5,	$03,	nA5,	nA5,	nA5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	subspace_Loop06
	dc.b		nRst,	$24
subspace_Loop07:
	dc.b		nA5,	$06,	nA5,	nA5,	nA5,	nA5,	nA5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$05,	subspace_Loop07
	dc.b		nA5,	$0C,	nA5,	nA5,	nA5,	nRst,	$12
;	Jump To	 	location
	smpsJump	subspace_Loop05

; DAC Data
subspace_DAC:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
subspace_Jump07:
	dc.b		dSnare,	$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09,	dSnare
	dc.b		$03,	nRst,	$09,	dSnare,	$03,	dHiTimpani,	$0C,	dSnare
	dc.b		$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09,	dSnare,	$03
	dc.b		nRst,	$06,	dSnare,	dHiTimpani,	$0C,	dSnare,	$03,	dSnare
	dc.b		dSnare,	nRst,	dHiTimpani,	$09,	dSnare,	$03,	nRst,	$0C
	dc.b		dHiTimpani,	dSnare,	$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09
	dc.b		dSnare,	$03,	nRst,	$06,	dSnare,	dHiTimpani,	$0C,	dSnare
	dc.b		$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09,	dSnare,	$03
	dc.b		nRst,	$09,	dSnare,	$03,	dHiTimpani,	$0C,	dSnare,	$03
	dc.b		dSnare,	dSnare,	nRst,	dHiTimpani,	$09,	dSnare,	$03,	nRst
	dc.b		$06,	dSnare,	dHiTimpani,	$0C,	dSnare,	$03,	dSnare,	dSnare
	dc.b		nRst,	dHiTimpani,	$09,	dSnare,	$03,	nRst,	$06,	dSnare
	dc.b		dHiTimpani,	$0C,	dSnare,	$03,	dSnare,	dSnare,	nRst,	dHiTimpani
	dc.b		$0C,	nRst,	$06,	dSnare,	$03,	$8E,	dHiTimpani,	$0C
	dc.b		dSnare,	$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09,	dSnare
	dc.b		$03,	nRst,	$09,	dSnare,	$03,	dHiTimpani,	$0C,	dSnare
	dc.b		$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09,	dSnare,	$03
	dc.b		nRst,	$06,	dSnare,	dHiTimpani,	$0C,	dSnare,	$03,	dSnare
	dc.b		dSnare,	nRst,	dHiTimpani,	$09,	dSnare,	$03,	nRst,	$0C
	dc.b		dHiTimpani,	dSnare,	$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09
	dc.b		dSnare,	$03,	nRst,	$06,	dSnare,	dHiTimpani,	$06,	dMidTimpani
	dc.b		$03,	$8E,	dSnare,	$03,	dSnare,	dSnare,	nRst,	dHiTimpani
	dc.b		$09,	dSnare,	$03,	nRst,	$09,	dSnare,	$03,	dHiTimpani
	dc.b		$0C,	dSnare,	$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09
	dc.b		dSnare,	$03,	nRst,	$06,	dSnare,	dHiTimpani,	$0C,	dSnare
	dc.b		$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09,	dSnare,	$03
	dc.b		nRst,	$06,	dSnare,	dHiTimpani,	$0C,	dSnare,	$03,	dSnare
	dc.b		dSnare,	nRst,	dHiTimpani,	$0C,	dHiTimpani,	$06,	dHiTimpani,	$03
	dc.b		$8D,	$8C,	dSnare,	dHiTimpani,	$8E
;	Call At	 	location
	smpsCall	subspace_Call01
;	Call At	 	location
	smpsCall	subspace_Call02
;	Call At	 	location
	smpsCall	subspace_Call01
	dc.b		dSnare,	$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09,	dSnare
	dc.b		$03,	nRst,	$09,	dSnare,	$03,	dHiTimpani,	$0C,	dSnare
	dc.b		$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09,	dSnare,	$03
	dc.b		nRst,	$06,	dSnare,	dHiTimpani,	$0C,	dSnare,	$03,	dSnare
	dc.b		dSnare,	nRst,	dHiTimpani,	$09,	dSnare,	$03,	nRst,	$0C
	dc.b		dHiTimpani,	dSnare,	$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09
	dc.b		dSnare,	$03,	nRst,	$06,	dSnare,	dHiTimpani,	$0C,	dSnare
	dc.b		$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09,	dSnare,	$03
	dc.b		nRst,	$09,	dSnare,	$03,	dHiTimpani,	$0C,	dSnare,	$03
	dc.b		dSnare,	dSnare,	nRst,	dHiTimpani,	$09,	dSnare,	$03,	nRst
	dc.b		$06,	dSnare,	dHiTimpani,	$0C,	dSnare,	$03,	dSnare,	dSnare
	dc.b		nRst,	dHiTimpani,	$09,	dSnare,	$03,	nRst,	$06,	dSnare
	dc.b		dHiTimpani,	$0C,	dHiTimpani,	$03,	dSnare,	dSnare,	dHiTimpani,	dSnare
	dc.b		dSnare,	dHiTimpani,	$8D,	$8E,	dSnare,	dSnare,	$8C,	dSnare
	dc.b		dSnare,	$8D,	$8E,	$8C,	$08,	$8D,	$8E,	dSnare
	dc.b		$03,	dHiTimpani,	dHiTimpani,	dHiTimpani,	dHiTimpani,	dSnare,	$8C,	dSnare
	dc.b		$8D,	dSnare,	dHiTimpani,	dSnare,	dSnare,	dHiTimpani,	$8C,	dHiTimpani
	dc.b		dHiTimpani,	dHiTimpani,	dSnare,	dHiTimpani,	dSnare,	$8D,	$8E,	dSnare
	dc.b		dSnare,	dHiTimpani,	dSnare,	dHiTimpani,	dHiTimpani,	dHiTimpani,	dSnare,	dHiTimpani
	dc.b		dSnare,	dSnare,	dHiTimpani,	dSnare,	$8C,	$8D,	dHiTimpani,	dSnare
	dc.b		$8E,	dHiTimpani,	dHiTimpani,	dSnare,	dHiTimpani,	dSnare,	$8E,	$8E
	dc.b		$8D,	dSnare,	$8E,	dSnare,	dHiTimpani,	dSnare,	dHiTimpani,	dSnare
	dc.b		dHiTimpani,	dSnare,	dHiTimpani,	dSnare,	dHiTimpani,	dSnare,	dHiTimpani,	$8D
	dc.b		$8E,	$08,	dHiTimpani,	$8D,	$8C,	dSnare,	$8E,	dHiTimpani
	dc.b		$02,	dHiTimpani,	dHiTimpani,	dHiTimpani,	$03,	dHiTimpani,	dHiTimpani,	$8E
;	Jump To	 	location
	smpsJump	subspace_Jump07

subspace_Call01:
	dc.b		dSnare,	$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09,	dSnare
	dc.b		$03,	nRst,	$09,	dSnare,	$03,	dHiTimpani,	$0C,	dSnare
	dc.b		$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09,	dSnare,	$03
	dc.b		nRst,	$06,	dSnare,	dHiTimpani,	$0C,	dSnare,	$03,	dSnare
	dc.b		dSnare,	nRst,	dHiTimpani,	$09,	dSnare,	$03,	nRst,	$0C
	dc.b		dHiTimpani,	dSnare,	$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09
	dc.b		dSnare,	$03,	nRst,	$06,	dSnare,	dHiTimpani,	$0C,	dSnare
	dc.b		$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09,	dSnare,	$03
	dc.b		nRst,	$09,	dSnare,	$03,	dHiTimpani,	$0C,	dSnare,	$03
	dc.b		dSnare,	dSnare,	nRst,	dHiTimpani,	$09,	dSnare,	$03,	nRst
	dc.b		$06,	dSnare,	dHiTimpani,	$0C,	dSnare,	$03,	dSnare,	dSnare
	dc.b		nRst,	dHiTimpani,	$09,	dSnare,	$03,	nRst,	$06,	dSnare
	dc.b		dHiTimpani,	$0C,	dSnare,	$03,	dSnare,	dSnare,	nRst,	dHiTimpani
	dc.b		$0C,	nRst,	$06,	dSnare,	$03,	$8E,	dHiTimpani,	$0C
	smpsReturn

subspace_Call02:
	dc.b		dSnare,	$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09,	dSnare
	dc.b		$03,	nRst,	$09,	dSnare,	$03,	dHiTimpani,	$0C,	dSnare
	dc.b		$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09,	dSnare,	$03
	dc.b		nRst,	$06,	dSnare,	dHiTimpani,	$0C,	dSnare,	$03,	dSnare
	dc.b		dSnare,	nRst,	dHiTimpani,	$09,	dSnare,	$03,	nRst,	$0C
	dc.b		dHiTimpani,	dSnare,	$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09
	dc.b		dSnare,	$03,	nRst,	$06,	dSnare,	dHiTimpani,	$0C,	dSnare
	dc.b		$03,	dSnare,	dSnare,	nRst,	dHiTimpani,	$09,	dSnare,	$03
	dc.b		nRst,	$09,	dSnare,	$03,	dHiTimpani,	$0C,	dSnare,	$03
	dc.b		dSnare,	dSnare,	nRst,	dHiTimpani,	$09,	dSnare,	$03,	nRst
	dc.b		$06,	dSnare,	dHiTimpani,	$0C,	dSnare,	$03,	dSnare,	dSnare
	dc.b		nRst,	dHiTimpani,	$09,	dSnare,	$03,	nRst,	$06,	dSnare
	dc.b		dHiTimpani,	$0C,	dSnare,	$03,	dSnare,	dSnare,	nRst,	dHiTimpani
	dc.b		$0C,	dHiTimpani,	$06,	dHiTimpani,	$03,	$8D,	$8C,	dSnare
	dc.b		dHiTimpani,	$8E
	smpsReturn

subspace_Voices:
;	Voice 00
;	$7D,$71,$31,$30,$72,$5F,$5F,$5F,$5F,$1F,$0F,$0F,$0F,$0A,$00,$00,$00,$68,$58,$58,$58,$00,$00,$00,$00
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$07
	smpsVcCoarseFreq	$02,	$00,	$01,	$01
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$0F,	$0F,	$1F
	smpsVcDecayRate2	$00,	$00,	$00,	$0A
	smpsVcDecayLevel	$05,	$05,	$05,	$06
	smpsVcReleaseRate	$08,	$08,	$08,	$08
	smpsVcTotalLevel	$00,	$00,	$00,	$00

;	Voice 01
;	$F4,$71,$30,$31,$70,$5F,$5F,$5F,$5F,$17,$0A,$19,$0A,$07,$0A,$09,$0A,$FF,$F7,$FF,$FF,$00,$00,$00,$00
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$07
	smpsVcCoarseFreq	$00,	$01,	$00,	$01
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$19,	$0A,	$17
	smpsVcDecayRate2	$0A,	$09,	$0A,	$07
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$0F,	$0F,	$07,	$0F
	smpsVcTotalLevel	$00,	$00,	$00,	$00

;	Voice 02
;	$76,$3F,$73,$33,$73,$1F,$1F,$1F,$1F,$1F,$00,$00,$00,$0F,$00,$00,$00,$15,$08,$08,$08,$07,$07,$07,$07
;				#
	smpsVcAlgorithm		$06
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$07,	$03
	smpsVcCoarseFreq	$03,	$03,	$03,	$0F
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$00,	$00,	$1F
	smpsVcDecayRate2	$00,	$00,	$00,	$0F
	smpsVcDecayLevel	$00,	$00,	$00,	$01
	smpsVcReleaseRate	$08,	$08,	$08,	$05
	smpsVcTotalLevel	$07,	$07,	$07,	$07

;	Voice 03
;	$78,$7F,$3F,$30,$71,$1F,$1F,$5F,$5F,$1F,$14,$0F,$0A,$0F,$0F,$0F,$0A,$59,$59,$59,$59,$1F,$20,$14,$06
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$07
	smpsVcCoarseFreq	$01,	$00,	$0F,	$0F
	smpsVcRateScale		$01,	$01,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$0F,	$14,	$1F
	smpsVcDecayRate2	$0A,	$0F,	$0F,	$0F
	smpsVcDecayLevel	$05,	$05,	$05,	$05
	smpsVcReleaseRate	$09,	$09,	$09,	$09
	smpsVcTotalLevel	$06,	$14,	$20,	$1F

;	Voice 04
;	$7D,$71,$31,$3F,$72,$5F,$5F,$5F,$5F,$1F,$0F,$0F,$0F,$0A,$00,$00,$00,$68,$58,$58,$58,$00,$07,$07,$07
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$07
	smpsVcCoarseFreq	$02,	$0F,	$01,	$01
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$0F,	$0F,	$1F
	smpsVcDecayRate2	$00,	$00,	$00,	$0A
	smpsVcDecayLevel	$05,	$05,	$05,	$06
	smpsVcReleaseRate	$08,	$08,	$08,	$08
	smpsVcTotalLevel	$07,	$07,	$07,	$00

;	Voice 05
;	$7C,$71,$38,$31,$73,$1F,$1F,$1F,$1F,$1F,$0F,$0F,$04,$0F,$0F,$0F,$04,$1F,$1F,$1F,$1F,$30,$09,$0F,$03
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$07
	smpsVcCoarseFreq	$03,	$01,	$08,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$04,	$0F,	$0F,	$1F
	smpsVcDecayRate2	$04,	$0F,	$0F,	$0F
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$03,	$0F,	$09,	$30

;	Voice 06
;	$F0,$72,$30,$3B,$78,$1F,$1F,$1F,$1F,$1F,$1C,$1C,$0C,$1F,$0C,$0C,$0C,$5F,$5F,$5F,$5F,$00,$00,$07,$00
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$07
	smpsVcCoarseFreq	$08,	$0B,	$00,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0C,	$1C,	$1C,	$1F
	smpsVcDecayRate2	$0C,	$0C,	$0C,	$1F
	smpsVcDecayLevel	$05,	$05,	$05,	$05
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$00,	$07,	$00,	$00

;	Voice 07
;	$76,$7F,$30,$32,$77,$5F,$5F,$5F,$5F,$1F,$0F,$0F,$0F,$10,$05,$05,$05,$5F,$1C,$1C,$2C,$00,$04,$04,$04
;				#
	smpsVcAlgorithm		$06
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$07
	smpsVcCoarseFreq	$07,	$02,	$00,	$0F
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$0F,	$0F,	$1F
	smpsVcDecayRate2	$05,	$05,	$05,	$10
	smpsVcDecayLevel	$02,	$01,	$01,	$05
	smpsVcReleaseRate	$0C,	$0C,	$0C,	$0F
	smpsVcTotalLevel	$04,	$04,	$04,	$00

;	Voice 08
;	$F7,$3E,$72,$78,$38,$1F,$1F,$1F,$1F,$0A,$0A,$0A,$0A,$00,$00,$00,$00,$17,$17,$17,$17,$08,$08,$08,$08
;				#
	smpsVcAlgorithm		$07
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$07,	$07,	$03
	smpsVcCoarseFreq	$08,	$08,	$02,	$0E
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$0A,	$0A,	$0A
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$07,	$07,	$07,	$07
	smpsVcTotalLevel	$08,	$08,	$08,	$08

;	Voice 09
;	$F7,$7C,$33,$34,$74,$DF,$0F,$0F,$DF,$0F,$0F,$0D,$0B,$0F,$0F,$0D,$0B,$FF,$FF,$FF,$FF,$00,$00,$00,$00
;				#
	smpsVcAlgorithm		$07
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$07
	smpsVcCoarseFreq	$04,	$04,	$03,	$0C
	smpsVcRateScale		$03,	$00,	$00,	$03
	smpsVcAttackRate	$1F,	$0F,	$0F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0B,	$0D,	$0F,	$0F
	smpsVcDecayRate2	$0B,	$0D,	$0F,	$0F
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$00,	$00,	$00,	$00

;	Voice 0A
;	$75,$74,$34,$34,$74,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$0A,$00,$00,$00,$0F,$17,$17,$17,$0F,$07,$06,$07
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$07
	smpsVcCoarseFreq	$04,	$04,	$04,	$04
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$1F,	$1F,	$1F
	smpsVcDecayRate2	$00,	$00,	$00,	$0A
	smpsVcDecayLevel	$01,	$01,	$01,	$00
	smpsVcReleaseRate	$07,	$07,	$07,	$0F
	smpsVcTotalLevel	$07,	$06,	$07,	$0F

;	Voice 0B
;	$40,$77,$31,$3F,$72,$1F,$F8,$1F,$F8,$11,$11,$11,$15,$00,$00,$00,$00,$24,$24,$24,$24,$0E,$0C,$1A,$00
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$07
	smpsVcCoarseFreq	$02,	$0F,	$01,	$07
	smpsVcRateScale		$03,	$00,	$03,	$00
	smpsVcAttackRate	$18,	$1F,	$18,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$15,	$11,	$11,	$11
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$02,	$02,	$02,	$02
	smpsVcReleaseRate	$04,	$04,	$04,	$04
	smpsVcTotalLevel	$00,	$1A,	$0C,	$0E

;	Voice 0C
;	$F6,$7F,$38,$31,$76,$1F,$1F,$1F,$1F,$1F,$00,$00,$00,$0F,$0F,$05,$00,$18,$18,$18,$18,$0C,$06,$08,$06
;				#
	smpsVcAlgorithm		$06
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$07
	smpsVcCoarseFreq	$06,	$01,	$08,	$0F
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$00,	$00,	$1F
	smpsVcDecayRate2	$00,	$05,	$0F,	$0F
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$08,	$08,	$08,	$08
	smpsVcTotalLevel	$06,	$08,	$06,	$0C

;	Voice 0D
;	$6C,$71,$33,$35,$7F,$1F,$1F,$1F,$1F,$0C,$0A,$07,$0E,$0C,$01,$07,$01,$F5,$F8,$F5,$F8,$07,$03,$0F,$03
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$07
	smpsVcCoarseFreq	$0F,	$05,	$03,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0E,	$07,	$0A,	$0C
	smpsVcDecayRate2	$01,	$07,	$01,	$0C
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$08,	$05,	$08,	$05
	smpsVcTotalLevel	$03,	$0F,	$03,	$07

;	Voice 0E
;	$72,$74,$32,$34,$78,$5F,$5F,$5F,$5F,$10,$0C,$0C,$00,$03,$03,$02,$00,$1F,$1F,$1F,$1F,$0F,$0F,$0F,$00
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$07
	smpsVcCoarseFreq	$08,	$04,	$02,	$04
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$0C,	$0C,	$10
	smpsVcDecayRate2	$00,	$02,	$03,	$03
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$00,	$0F,	$0F,	$0F

;	Voice 0F
;	$75,$71,$32,$72,$32,$5F,$5F,$5F,$5F,$0F,$0C,$0C,$00,$07,$0C,$0C,$00,$1F,$1F,$1F,$1F,$0C,$05,$00,$00
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$07,	$03,	$07
	smpsVcCoarseFreq	$02,	$02,	$02,	$01
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$0C,	$0C,	$0F
	smpsVcDecayRate2	$00,	$0C,	$0C,	$07
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$00,	$00,	$05,	$0C

;	Voice 10
;	$72,$72,$31,$32,$72,$1F,$1F,$1F,$1F,$0F,$1F,$0F,$00,$08,$0F,$00,$00,$1A,$18,$1E,$19,$0F,$07,$1F,$02
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$07
	smpsVcCoarseFreq	$02,	$02,	$01,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$0F,	$1F,	$0F
	smpsVcDecayRate2	$00,	$00,	$0F,	$08
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$09,	$0E,	$08,	$0A
	smpsVcTotalLevel	$02,	$1F,	$07,	$0F

;	Voice 11
;	$40,$76,$32,$33,$78,$1F,$1F,$1F,$1F,$1A,$1E,$17,$07,$0A,$0E,$07,$07,$2C,$2C,$2C,$2C,$15,$15,$07,$00
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$07
	smpsVcCoarseFreq	$08,	$03,	$02,	$06
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$07,	$17,	$1E,	$1A
	smpsVcDecayRate2	$07,	$07,	$0E,	$0A
	smpsVcDecayLevel	$02,	$02,	$02,	$02
	smpsVcReleaseRate	$0C,	$0C,	$0C,	$0C
	smpsVcTotalLevel	$00,	$07,	$15,	$15

;	Voice 12
;	$48,$76,$34,$31,$74,$1F,$1F,$1F,$1F,$1F,$0F,$1F,$07,$05,$07,$08,$07,$24,$24,$24,$24,$10,$15,$0C,$01
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$01
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$07
	smpsVcCoarseFreq	$04,	$01,	$04,	$06
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$07,	$1F,	$0F,	$1F
	smpsVcDecayRate2	$07,	$08,	$07,	$05
	smpsVcDecayLevel	$02,	$02,	$02,	$02
	smpsVcReleaseRate	$04,	$04,	$04,	$04
	smpsVcTotalLevel	$01,	$0C,	$15,	$10

;	Voice 13
;	$7D,$7F,$3F,$31,$75,$1F,$1F,$1F,$1F,$1F,$0B,$0B,$0B,$12,$0B,$0B,$0B,$1A,$0A,$0A,$0A,$10,$05,$05,$05
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$07
	smpsVcCoarseFreq	$05,	$01,	$0F,	$0F
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0B,	$0B,	$0B,	$1F
	smpsVcDecayRate2	$0B,	$0B,	$0B,	$12
	smpsVcDecayLevel	$00,	$00,	$00,	$01
	smpsVcReleaseRate	$0A,	$0A,	$0A,	$0A
	smpsVcTotalLevel	$05,	$05,	$05,	$10

;	Voice 14
;	$64,$71,$30,$30,$71,$5F,$5F,$5F,$5F,$15,$05,$13,$05,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$00,$08,$00,$08
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$04
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$07
	smpsVcCoarseFreq	$01,	$00,	$00,	$01
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$13,	$05,	$15
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$08,	$00,	$08,	$00
	even
