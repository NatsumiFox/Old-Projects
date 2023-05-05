; =============================================================================================
; Project Name:		WhirlWind
; Created:		13rd June 2015
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

PSG_Voice_0A = $04
PSG_Voice_08 = $02

WhirlWind_Header:
;	Voice Pointer	location
	smpsHeaderVoice	whirlwind_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$01,	$07

;	DAC Pointer	location
	smpsHeaderDAC	whirlwind_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	whirlwind_FM1,	smpsPitch01hi,	$06-2
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	whirlwind_FM2,	smpsPitch00,	$14-2
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	whirlwind_FM3,	smpsPitch00,	$14-2
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	whirlwind_FM4,	smpsPitch00,	$14-2
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	whirlwind_FM5,	smpsPitch00,	$14-2
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	whirlwind_PSG1,	smpsPitch03lo,	$03-2,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	whirlwind_PSG2,	smpsPitch03lo,	$03-2,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	whirlwind_PSG3,	smpsPitch00,	$03-2,	$03

; FM1 Data
WhirlWind_FM1:
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nRst,	$12
WhirlWind_Loop01:
	dc.b		nRst,	$48
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	WhirlWind_Loop01
	dc.b		nRst,	$30,	nRst,	$0F,	nC1,	$09,	$48,	smpsNoAttack
	dc.b		$48,	smpsNoAttack,	$48,	nRst,	$48
WhirlWind_Jump01:
	dc.b		nBb0,	$09,	nC1,	nRst,	$2D,	nBb0,	$09,	smpsNoAttack
	dc.b		nBb0,	nC1,	nC1,	nRst,	$24,	nEb1,	$09,	smpsNoAttack
	dc.b		nEb1,	nF1,	nRst,	nF1,	nRst,	nF1,	nRst,	nBb0
	dc.b		smpsNoAttack,	nBb0,	nBb0,	nRst,	nEb1,	nRst,	nD1,	nRst
	dc.b		nBb0,	smpsNoAttack,	nBb0,	nC1,	nC1,	nRst,	$24,	nBb0
	dc.b		$09,	smpsNoAttack,	nBb0,	nC1,	nC1,	nRst,	$24,	nEb1
	dc.b		$09,	smpsNoAttack,	nEb1,	nF1,	nRst,	nF1,	nRst,	nF1
	dc.b		nRst,	nD1,	smpsNoAttack,	nD1,	nD1,	nRst,	nEb1,	nRst
	dc.b		nD1,	nRst,	nC2
WhirlWind_Loop02:
;	Call At	 	location
	smpsCall	WhirlWind_Call01
	dc.b		smpsNoAttack,	nF1,	nD1,	nF1,	nBb1,	$12,	$09,	nBb1
	dc.b		smpsNoAttack,	nC2
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$03,	WhirlWind_Loop02
;	Call At	 	location
	smpsCall	WhirlWind_Call01
	dc.b		smpsNoAttack,	nF1,	nD1,	nF1,	nD1,	$12,	smpsNoAttack,	nD1
	dc.b		$1B
WhirlWind_Loop03:
	dc.b		nC1,	$09,	nC1,	nRst,	nC1,	nRst,	nC1,	nRst
	dc.b		nC1
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$08,	WhirlWind_Loop03
;	Jump To	 	location
	smpsJump	WhirlWind_Jump01

WhirlWind_Call01:
	dc.b		smpsNoAttack,	nC2,	$09,	nC2,	nC2,	nC2,	nC2,	nC2
	dc.b		nC2,	nBb1,	smpsNoAttack,	nBb1,	nBb1,	nBb1,	nBb1,	nBb1
	dc.b		nF1,	nBb1,	nAb1,	smpsNoAttack,	nAb1,	nAb1,	nAb1,	nAb1
	dc.b		nAb1,	nD1,	nAb1,	nF1
	smpsReturn

; FM2 Data
WhirlWind_FM2:
	dc.b		nRst,	$12
WhirlWind_Jump02:
;	Set Modulation	wait	speed	change	step
	smpsModSet	$40,	$02,	$03,	$03
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nG4,	$48,	smpsNoAttack,	$48,	nEb4,	$48,	nD4,	$48
	dc.b		nG4,	$48,	smpsNoAttack,	$48,	nEb4,	$48,	nBb4,	$48
WhirlWind_Loop04:
	dc.b		nRst,	$48
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$07,	WhirlWind_Loop04
	dc.b		nRst,	$30,	nRst,	$0F
;	Set Modulation	wait	speed	change	step
	smpsModSet	$40,	$02,	$03,	$03
;	Set FM Voice	#
	smpsFMvoice	$02
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nA4,	$03,	nBb4,	nB4,	smpsNoAttack,	nC5,	$1B
;	Set Modulation	wait	speed	change	step
	smpsModSet	$24,	$01,	$05,	$05
	dc.b		nG4,	$48,	smpsNoAttack
;	Set Modulation	wait	speed	change	step
	smpsModSet	$40,	$02,	$03,	$03
	dc.b		$09,	nD5,	nEb5,	nRst,	nC5,	$24,	nG5
;	Set Modulation	wait	speed	change	step
	smpsModSet	$24,	$01,	$05,	$05
	dc.b		smpsNoAttack,	nG5,	$48
;	Set Modulation	wait	speed	change	step
	smpsModSet	$40,	$02,	$03,	$03
	dc.b		nBb4,	$03,	nB4,	nC5,	smpsNoAttack,	nEb5,	$1B,	nD5
	dc.b		smpsNoAttack,	nBb4,	$36,	nD4,	$09,	nEb4,	nRst
;	Set Modulation	wait	speed	change	step
	smpsModSet	$24,	$01,	$05,	$05
	dc.b		nC4,	$48
;	Set Modulation	wait	speed	change	step
	smpsModSet	$40,	$02,	$03,	$03
;	Alter Volume	value
	smpsAlterVol	$04
;	Set FM Voice	#
	smpsFMvoice	$00
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nEb4,	$09,	nRst,	nEb4,	$12,	nD4,	$24
;	Set FM Voice	#
	smpsFMvoice	$02
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$40,	$02,	$03,	$03
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nA4,	$03,	nBb4,	nB4,	smpsNoAttack,	nC5,	$1B,	nG4
	dc.b		$24,	nG5,	$1B,	nF5,	$09,	nEb5,	nRst,	nF5
	dc.b		nRst,	nEb5,	$24,	nD5,	$1B,	nBb4,	$09,	nEb5
	dc.b		$24
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$03,	$03
	dc.b		nD5
;	Set Modulation	wait	speed	change	step
	smpsModSet	$40,	$02,	$03,	$03
	dc.b		nA4,	$03,	nBb4,	nB4,	smpsNoAttack,	nC5,	$1B,	nG4
	dc.b		$24,	nG5,	$1B,	nF5,	$09,	nEb5,	nRst,	nBb4
	dc.b		nRst
;	Set Modulation	wait	speed	change	step
	smpsModSet	$24,	$01,	$04,	$04
	dc.b		nC5,	$24,	smpsNoAttack,	$1B,	smpsNoAttack,	$09
;	Set Modulation	wait	speed	change	step
	smpsModSet	$40,	$02,	$03,	$03
;	Alter Volume	value
	smpsAlterVol	$04
;	Set FM Voice	#
	smpsFMvoice	$00
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nEb4,	nRst,	nEb4,	$12,	nF4,	$2D
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Jump To	 	location
	smpsJump	WhirlWind_Jump02

; FM3 Data
WhirlWind_FM3:
	dc.b		nRst,	$12
;	Set Modulation	wait	speed	change	step
	smpsModSet	$40,	$02,	$03,	$03
WhirlWind_Jump03:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
WhirlWind_Loop05:
	dc.b		nC3,	$09,	smpsNoAttack,	nC3,	smpsNoAttack,	nC3,	smpsNoAttack
;	Loop To	 	index	loops	location
	smpsLoop	$04,	$05,	WhirlWind_Loop05
	dc.b		nC3
WhirlWind_Loop06:
	dc.b		nC3,	$09,	smpsNoAttack,	nC3,	smpsNoAttack,	nC3,	smpsNoAttack,	nC3
	dc.b		smpsNoAttack,	nC3,	smpsNoAttack,	nC3,	smpsNoAttack,	nC3,	smpsNoAttack,	nC3
;	Loop To	 	index	loops	location
	smpsLoop	$03,	$02,	WhirlWind_Loop06
;	Loop To	 	index	loops	location
	smpsLoop	$02,	$02,	WhirlWind_Loop05
;	Set FM Voice	#
	smpsFMvoice	$00
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Call At	 	location
	smpsCall	WhirlWind_Call02
	dc.b		nD4,	$24,	nEb4,	$09,	nRst,	nD4,	$12,	nG4
	dc.b		$09,	smpsNoAttack
;	Call At	 	location
	smpsCall	WhirlWind_Call02
	dc.b		nD4,	$12,	$09,	nRst,	$09,	nEb4,	nRst,	nD4
	dc.b		$12,	nG3,	$09
WhirlWind_Loop07:
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nG3,	$12,	$09,	$12,	$09,	nG3,	nG4,	$12
	dc.b		$09,	nG4,	nG4,	$12,	$09,	nG4,	nF4,	$12
	dc.b		$09,	$12,	nEb4,	$09,	nF4,	$12,	nEb4,	nEb4
	dc.b		$09,	nRst,	nD4,	$24,	nG3,	$12,	$09,	$12
	dc.b		$09,	$12,	nG4,	nG4,	$09,	nG4,	nG4,	nG4
	dc.b		nG4,	$12,	nF4,	nF4,	$09,	$12,	nEb4,	$09
	dc.b		nF4,	$12,	nEb4,	$09,	nRst,	nEb4,	$12,	nD4
	dc.b		$09,	smpsNoAttack,	nD4,	smpsNoAttack,	nD4,	smpsNoAttack,	nD4,	smpsNoAttack
	dc.b		nD4
;	Loop To	 	index	loops	location
	smpsLoop	$02,	$02,	WhirlWind_Loop07
;	Jump To	 	location
	smpsJump	WhirlWind_Jump03

WhirlWind_Call02:
	dc.b		nG4,	$09,	smpsNoAttack,	nG4,	smpsNoAttack,	nG4,	smpsNoAttack,	nG4
	dc.b		smpsNoAttack,	nG4,	smpsNoAttack,	nG4,	smpsNoAttack,	nG4,	smpsNoAttack,	nG4
	dc.b		smpsNoAttack,	nG4,	smpsNoAttack,	nG4,	smpsNoAttack,	nG4,	smpsNoAttack,	nG4
	dc.b		smpsNoAttack,	nG4,	smpsNoAttack,	nG4,	smpsNoAttack,	nG4,	nEb4,	smpsNoAttack
	dc.b		nEb4,	smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4,	smpsNoAttack
	dc.b		nEb4,	smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4
	smpsReturn

; FM4 Data
WhirlWind_FM4:
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nRst,	$12
;	Set Modulation	wait	speed	change	step
	smpsModSet	$40,	$02,	$03,	$03
WhirlWind_Jump04:
;	Set FM Voice	#
	smpsFMvoice	$00
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Call At	 	location
	smpsCall	WhirlWind_Call03
	dc.b		nBb3,	smpsNoAttack,	nBb3,	smpsNoAttack,	nBb3,	smpsNoAttack,	nBb3,	smpsNoAttack
	dc.b		nBb3,	smpsNoAttack,	nBb3,	smpsNoAttack,	nBb3,	smpsNoAttack,	nBb3
;	Call At	 	location
	smpsCall	WhirlWind_Call03
	dc.b		nF4,	smpsNoAttack,	nF4,	smpsNoAttack,	nF4,	smpsNoAttack,	nF4,	smpsNoAttack
	dc.b		nF4,	smpsNoAttack,	nF4,	smpsNoAttack,	nF4,	smpsNoAttack,	nF4
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
;	Call At	 	location
	smpsCall	WhirlWind_Call04
	dc.b		nBb3,	$24,	$09,	nRst,	$09,	nBb3,	$12,	nEb4
	dc.b		$09,	smpsNoAttack
;	Call At	 	location
	smpsCall	WhirlWind_Call04
	dc.b		nBb3,	$12,	$09,	nRst,	$09,	nBb3,	nRst,	nBb3
	dc.b		$12,	nEb3,	$09
WhirlWind_Loop08:
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nEb3,	$09,	nEb3,	nEb3,	nEb3,	$12,	$09,	nEb3
	dc.b		nD4,	$12,	$09,	nD4,	nD4,	nD4,	$12,	$09
	dc.b		nC4,	$12,	$09,	$12,	nAb3,	$09,	nC4,	$12
	dc.b		nC4,	nC4,	$09,	nRst,	nBb3,	$24,	nEb3,	$12
	dc.b		$09,	$12,	$09,	$12,	nD4,	nD4,	$09,	nD4
	dc.b		nD4,	nD4,	nD4,	$12,	nC4,	nC4,	$09,	$12
	dc.b		nAb3,	$09,	nC4,	$12,	nC4,	$09,	nRst,	nC4
	dc.b		$12,	nBb3,	$09,	smpsNoAttack,	nBb3,	smpsNoAttack,	nBb3,	smpsNoAttack
	dc.b		nBb3,	smpsNoAttack,	nBb3
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$02,	WhirlWind_Loop08
;	Jump To	 	location
	smpsJump	WhirlWind_Jump04

WhirlWind_Call03:
	dc.b		nEb4,	$09,	smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4
	dc.b		smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4
	dc.b		smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4
	dc.b		smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4
	dc.b		nC4,	smpsNoAttack,	nC4,	smpsNoAttack,	nC4,	smpsNoAttack,	nC4,	smpsNoAttack
	dc.b		nC4,	smpsNoAttack,	nC4,	smpsNoAttack,	nC4,	smpsNoAttack,	nC4
	smpsReturn

WhirlWind_Call04:
	dc.b		nEb4,	$09,	smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4
	dc.b		smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4
	dc.b		smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4
	dc.b		smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4,	smpsNoAttack,	nEb4,	nC4,	smpsNoAttack
	dc.b		nC4,	smpsNoAttack,	nC4,	smpsNoAttack,	nC4,	smpsNoAttack,	nC4,	smpsNoAttack
	dc.b		nC4,	smpsNoAttack,	nC4,	smpsNoAttack,	nC4
	smpsReturn

; FM5 Data
WhirlWind_FM5:
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nRst,	$12
;	Set Modulation	wait	speed	change	step
	smpsModSet	$40,	$02,	$03,	$03
WhirlWind_Jump05:
;	Set FM Voice	#
	smpsFMvoice	$00
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Call At	 	location
	smpsCall	WhirlWind_Call05
	dc.b		nF3,	smpsNoAttack,	nF3,	smpsNoAttack,	nF3,	smpsNoAttack,	nF3,	smpsNoAttack
	dc.b		nF3,	smpsNoAttack,	nF3,	smpsNoAttack,	nF3,	smpsNoAttack,	nF3
;	Call At	 	location
	smpsCall	WhirlWind_Call05
	dc.b		nD4,	smpsNoAttack,	nD4,	smpsNoAttack,	nD4,	smpsNoAttack,	nD4,	smpsNoAttack
	dc.b		nD4,	smpsNoAttack,	nD4,	smpsNoAttack,	nD4,	smpsNoAttack,	nD4
;	Set FM Voice	#
	smpsFMvoice	$00
;	Call At	 	location
	smpsCall	WhirlWind_Call06
	dc.b		nF3,	$24,	$09,	nRst,	$09,	nD3,	$12,	nC3
	dc.b		$09,	smpsNoAttack
;	Call At	 	location
	smpsCall	WhirlWind_Call06
	dc.b		nF3,	$12,	$09,	nRst,	$09,	nF3,	nRst,	nD3
	dc.b		$12,	nC3,	$09
WhirlWind_Loop09:
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nC3,	$12,	$09,	$12,	$09,	nC3,	nBb3,	$12
	dc.b		$09,	nBb3,	nBb3,	nBb3,	$12,	$09,	nEb3,	$12
	dc.b		$09,	$12,	$09,	$12,	nAb3,	nAb3,	$09,	nRst
	dc.b		nG3,	$24,	nC3,	$12,	$09,	$12,	$09,	$12
	dc.b		nBb3,	nBb3,	$09,	nBb3,	nBb3,	nBb3,	nBb3,	$12
	dc.b		nEb3,	nEb3,	$09,	$12,	$09,	$12,	nAb3,	$09
	dc.b		nRst,	nAb3,	$12,	nG3,	$09,	smpsNoAttack,	nG3,	smpsNoAttack
	dc.b		nG3,	smpsNoAttack,	nG3,	smpsNoAttack,	nG3
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$02,	WhirlWind_Loop09
;	Jump To	 	location
	smpsJump	WhirlWind_Jump05

WhirlWind_Call05:
	dc.b		nC4,	$09,	smpsNoAttack,	nC4,	smpsNoAttack,	nC4,	smpsNoAttack,	nC4
	dc.b		smpsNoAttack,	nC4,	smpsNoAttack,	nC4,	smpsNoAttack,	nC4,	smpsNoAttack,	nC4
	dc.b		smpsNoAttack,	nC4,	smpsNoAttack,	nC4,	smpsNoAttack,	nC4,	smpsNoAttack,	nC4
	dc.b		smpsNoAttack,	nC4,	smpsNoAttack,	nC4,	smpsNoAttack,	nC4,	smpsNoAttack,	nC4
	dc.b		nAb3,	smpsNoAttack,	nAb3,	smpsNoAttack,	nAb3,	smpsNoAttack,	nAb3,	smpsNoAttack
	dc.b		nAb3,	smpsNoAttack,	nAb3,	smpsNoAttack,	nAb3,	smpsNoAttack,	nAb3
	smpsReturn

WhirlWind_Call06:
	dc.b		nC3,	$09,	smpsNoAttack,	nC3,	smpsNoAttack,	nC3,	smpsNoAttack,	nC3
	dc.b		smpsNoAttack,	nC3,	smpsNoAttack,	nC3,	smpsNoAttack,	nC3,	smpsNoAttack,	nC3
	dc.b		smpsNoAttack,	nC3,	smpsNoAttack,	nC3,	smpsNoAttack,	nC3,	smpsNoAttack,	nC3
	dc.b		smpsNoAttack,	nC3,	smpsNoAttack,	nC3,	smpsNoAttack,	nC3,	nAb3,	smpsNoAttack
	dc.b		nAb3,	smpsNoAttack,	nAb3,	smpsNoAttack,	nAb3,	smpsNoAttack,	nAb3,	smpsNoAttack
	dc.b		nAb3,	smpsNoAttack,	nAb3,	smpsNoAttack,	nAb3
	smpsReturn

; PSG1 Data
WhirlWind_PSG1:
	dc.b		nRst,	$12
;	Set Modulation	wait	speed	change	step
	smpsModSet	$13,	$02,	$01,	$01
WhirlWind_Jump06:
;	Call At	 	location
	smpsCall	WhirlWind_Call07
;	Call At	 	location
	smpsCall	WhirlWind_Call08
;	Jump To	 	location
	smpsJump	WhirlWind_Jump06

WhirlWind_Call07:
;	Set PSG Voice	#
	smpsPSGvoice	$02
;	Set Volume	value
	smpsSetVol	$02
WhirlWind_Loop0A:
	dc.b		nC6,	$09,	nG6,	nC7,	nC6,	nG6,	nC7,	nC6
	dc.b		nC7
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	WhirlWind_Loop0A
;	Set PSG Voice	#
	smpsPSGvoice	$00
;	Set Volume	value
	smpsSetVol	$FE
	dc.b		nRst,	$0C
	smpsReturn

WhirlWind_Call08:
	dc.b		nRst,	$48
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	WhirlWind_Call08
	dc.b		smpsNoAttack,	nC5,	$1B,	nG4,	$48,	smpsNoAttack,	$09,	nD5
	dc.b		nEb5,	nRst,	nC5,	$24,	nG5,	$18
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nC5,	$24,	nG5,	$30
;	Set Volume	value
	smpsSetVol	$FE
	dc.b		nBb4,	$03,	nB4,	nC5,	smpsNoAttack,	nEb5,	$1B,	nD5
	dc.b		smpsNoAttack,	nBb4,	$36,	nD4,	$09,	nEb4,	nRst,	nC4
	dc.b		$48
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nEb3,	$09,	nRst,	nEb3,	$12,	nD3,	$24
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nA4,	$03,	nBb4,	nB4,	smpsNoAttack,	nC5,	$1B,	nG4
	dc.b		$24,	nG5,	$1B,	nF5,	$09,	nEb5,	nRst,	nF5
	dc.b		nRst,	nEb5,	$24,	nD5,	$1B,	nBb4,	$09,	nEb5
	dc.b		$24,	nD5,	nA4,	$03,	nBb4,	nB4,	smpsNoAttack,	nC5
	dc.b		$1B,	nG4,	$24,	nG5,	$1B,	nF5,	$09,	nEb5
	dc.b		nRst,	nBb4,	nRst,	smpsNoAttack,	nC5,	$24,	smpsNoAttack,	$1B
	dc.b		smpsNoAttack,	$09
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nEb2,	nRst,	nEb2,	$12,	nF2,	$21
;	Set Volume	value
	smpsSetVol	$FC
	smpsReturn

; PSG2 Data
WhirlWind_PSG2:
	dc.b		nRst,	$0C,	nRst,	$12
;	Set Modulation	wait	speed	change	step
	smpsModSet	$13,	$02,	$01,	$01
;	Set Volume	value
	smpsSetVol	$02
WhirlWind_Jump07:
;	Alter Notes	value
	smpsAlterNote	$01
;	Call At	 	location
	smpsCall	WhirlWind_Call07
;	Call At	 	location
	smpsCall	WhirlWind_Call08
;	Jump To	 	location
	smpsJump	WhirlWind_Jump07

; PSG3 Data
WhirlWind_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
	dc.b		nRst,	$12
;	Set PSG Voice	#
	smpsPSGvoice	PSG_Voice_08
	dc.b		nAb5,	$48,	smpsNoAttack,	$48,	nRst,	$48,	nRst,	$24
	dc.b		nA5,	nRst,	$48,	nRst,	$48,	nRst,	$48,	nRst
	dc.b		$24,	nA5
WhirlWind_Jump08:
;	Set PSG Voice	#
	smpsPSGvoice	PSG_Voice_0A
	dc.b		nAb5,	$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nA5,	$09,	nA5,	nA5,	nA5,	nA5,	nA5,	nA5
	dc.b		nA5,	nA5,	nA5,	nA5,	nA5,	nA5
;	Set PSG Voice	#
	smpsPSGvoice	PSG_Voice_0A
	dc.b		nAb5,	$2D,	nA5,	$12,	$09,	nAb5,	$48,	$2D
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nA5,	$09,	nA5,	nA5,	nA5,	nA5,	nA5,	nA5
	dc.b		nA5,	nA5,	nA5,	nA5
;	Set PSG Voice	#
	smpsPSGvoice	PSG_Voice_0A
	dc.b		nAb5,	$2D,	nA5,	$12,	$09,	nAb5,	$24,	$12
	dc.b		nAb5,	nAb5,	$2D
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nA5,	$09,	nA5,	nA5,	nA5,	nA5,	nA5,	nA5
	dc.b		nA5,	nA5,	nA5,	nA5,	nA5,	nA5,	$09,	nA5
	dc.b		nA5,	nA5,	nA5,	nA5,	nA5
;	Set PSG Voice	#
	smpsPSGvoice	PSG_Voice_0A
	dc.b		nAb5,	$24,	$2D
WhirlWind_Loop0B:
;	Set PSG Voice	#
	smpsPSGvoice	PSG_Voice_0A
	dc.b		nAb5,	$24
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nA5,	$09,	nA5,	nA5
;	Call At	 	location
	smpsCall	WhirlWind_Call09
;	Set PSG Voice	#
	smpsPSGvoice	PSG_Voice_0A
	dc.b		nAb5,	$24,	$2D
;	Loop To	 	index	loops	location
	smpsLoop	$02,	$03,	WhirlWind_Loop0B
;	Set PSG Voice	#
	smpsPSGvoice	PSG_Voice_0A
	dc.b		nAb5,	$24
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nA5,	$09,	nA5,	nA5,	nA5
;	Call At	 	location
	smpsCall	WhirlWind_Call09
;	Set PSG Voice	#
	smpsPSGvoice	PSG_Voice_0A
	dc.b		nA5,	$12,	nA5,	nA5,	nA5,	nAb5,	$24
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nA5,	$09,	nA5,	nA5,	nA5
;	Call At	 	location
	smpsCall	WhirlWind_Call09
	dc.b		nA5,	nA5
;	Set PSG Voice	#
	smpsPSGvoice	PSG_Voice_0A
	dc.b		nA5,	$12,	nA5,	nA5,	$09
;	Set PSG Voice	#
	smpsPSGvoice	PSG_Voice_08
	dc.b		nAb5
;	Set PSG Voice	#
	smpsPSGvoice	PSG_Voice_0A
;	Jump To	 	location
	smpsJump	WhirlWind_Jump08

WhirlWind_Call09:
	dc.b		nA5,	nA5,	nA5,	nA5,	nA5,	nA5,	nA5,	nA5
	dc.b		nA5,	nA5,	nA5,	nA5,	nA5,	nA5,	nA5,	nA5
	smpsReturn

; DAC Data
WhirlWind_DAC:
	dc.b		nRst,	$09,	dKick,	dKick,	$30,	nRst,	$0F,	dKick
	dc.b		$09
WhirlWind_Loop0C:
	dc.b		$30,	nRst,	$0F,	dKick,	$09
;	Loop To	 	index	loops	location
	smpsLoop	$03,	$07,	WhirlWind_Loop0C
WhirlWind_Jump09:
	dc.b		dKick,	$12,	dSnare,	dKick,	dSnare,	$09,	dKick,	$1B
	dc.b		dSnare,	$12,	dKick,	dSnare,	$09,	dSnare,	dKick,	$12
	dc.b		dSnare,	dKick,	dSnare,	$09,	dSnare,	dKick,	$12,	dSnare
	dc.b		$09,	dKick,	$12,	$09,	dSnare,	dSnare,	dKick,	$12
	dc.b		dSnare,	dKick,	dSnare,	$09,	dKick,	$1B,	dSnare,	$12
	dc.b		dKick,	dSnare,	$09,	dSnare,	dKick,	$12,	dSnare,	dKick
	dc.b		dSnare,	$09,	dSnare,	dKick,	$12,	$09,	dSnare,	$12
	dc.b		dSnare,	dSnare,	$09
WhirlWind_Loop0D:
	dc.b		dKick,	$12,	dSnare,	dKick,	dSnare,	$09,	dKick,	$1B
	dc.b		dSnare,	$12,	dKick,	dSnare,	$09,	dKick,	$1B,	dSnare
	dc.b		$12,	dKick,	dSnare,	$09,	dSnare,	dKick,	$12,	dSnare
	dc.b		$09,	dSnare,	dKick,	$12,	dSnare
;	Loop To	 	index	loops	location
	smpsLoop	$02,	$04,	WhirlWind_Loop0D
	dc.b		dKick,	$12,	dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick
	dc.b		dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick,	dSnare,	$09
	dc.b		dKick,	nRst,	dMidTimpani,	dSnare,	dLowTimpani,	dKick,	$12,	dSnare
	dc.b		dKick,	dSnare,	dKick,	dSnare,	dKick,	dSnare,	dKick,	dSnare
	dc.b		dKick,	dSnare,	$09,	nRst,	dKick,	$12,	dSnare,	dKick
	dc.b		$09,	dHiTimpani,	nRst,	dLowTimpani
;	Jump To	 	location
	smpsJump	WhirlWind_Jump09

WhirlWind_Voices:
;	Voice 00
;	$3A,$33,$01,$00,$72,$9F,$8F,$4F,$4F,$16,$00,$00,$07,$01,$01,$01,$01,$1F,$0F,$0F,$0F,$15,$1F,$19,$00
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$00,	$00,	$03
	smpsVcCoarseFreq	$02,	$00,	$01,	$03
	smpsVcRateScale		$01,	$01,	$02,	$02
	smpsVcAttackRate	$0F,	$0F,	$0F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$07,	$00,	$00,	$16
	smpsVcDecayRate2	$01,	$01,	$01,	$01
	smpsVcDecayLevel	$00,	$00,	$00,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$00,	$19,	$1F,	$15

;	Voice 01
;	$20,$72,$31,$00,$00,$9F,$D8,$DC,$DF,$10,$0A,$04,$04,$0F,$08,$08,$08,$50,$50,$B0,$B6,$20,$2B,$14,$00
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$04
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$03,	$07
	smpsVcCoarseFreq	$00,	$00,	$01,	$02
	smpsVcRateScale		$03,	$03,	$03,	$02
	smpsVcAttackRate	$1F,	$1C,	$18,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$04,	$04,	$0A,	$10
	smpsVcDecayRate2	$08,	$08,	$08,	$0F
	smpsVcDecayLevel	$0B,	$0B,	$05,	$05
	smpsVcReleaseRate	$06,	$00,	$00,	$00
	smpsVcTotalLevel	$00,	$14,	$2B,	$20

;	Voice 02
;	$3D,$22,$11,$31,$21,$10,$10,$10,$10,$05,$04,$04,$03,$00,$00,$00,$00,$2B,$2B,$2B,$1B,$1A,$0A,$0A,$0A
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$02,	$03,	$01,	$02
	smpsVcCoarseFreq	$01,	$01,	$01,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$10,	$10,	$10,	$10
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$03,	$04,	$04,	$05
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$01,	$02,	$02,	$02
	smpsVcReleaseRate	$0B,	$0B,	$0B,	$0B
	smpsVcTotalLevel	$0A,	$0A,	$0A,	$1A

;	Voice 03
;	$3A,$33,$01,$00,$72,$9F,$8F,$4F,$4F,$11,$11,$11,$11,$01,$01,$01,$05,$1F,$0F,$0F,$0F,$17,$1F,$19,$00
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$00,	$00,	$03
	smpsVcCoarseFreq	$02,	$00,	$01,	$03
	smpsVcRateScale		$01,	$01,	$02,	$02
	smpsVcAttackRate	$0F,	$0F,	$0F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$11,	$11,	$11,	$11
	smpsVcDecayRate2	$05,	$01,	$01,	$01
	smpsVcDecayLevel	$00,	$00,	$00,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$00,	$19,	$1F,	$17
	even
