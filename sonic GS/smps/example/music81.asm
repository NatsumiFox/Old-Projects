; =============================================================================================
; Project Name:		GHZ
; Created:		22nd March 2008
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

GHZ_Header:
;	Voice Pointer	location
	smpsHeaderVoice	GHZ_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$01,	$03

;	DAC Pointer	location
	smpsHeaderDAC	GHZ_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	GHZ_FM1,	smpsPitch01lo,	$12
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	GHZ_FM2,	smpsPitch00,	$0B
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	GHZ_FM3,	smpsPitch01lo,	$14
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	GHZ_FM4,	smpsPitch01lo,	$08
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	GHZ_FM5,	smpsPitch01lo,	$20
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	GHZ_PSG1,	smpsPitch04lo,	$01,	$03
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	GHZ_PSG2,	smpsPitch04lo,	$03,	$06
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	GHZ_PSG3,	smpsPitch00,	$03,	$04

; FM1 Data
GHZ_FM1:
;	Set FM Voice	#
	smpsFMvoice	$02
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Call At	 	location
	smpsCall	GHZ_Call01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
GHZ_Loop01:
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nE7,	$04
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC7
;	Alter Volume	value
	smpsAlterVol	$01
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$0D,	GHZ_Loop01
	dc.b		nE7,	$04,	nRst,	$14
;	Alter Volume	value
	smpsAlterVol	$EB
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nRst,	$40,	nRst,	nRst,	nRst,	nRst,	nRst
GHZ_Jump01:
;	Set FM Voice	#
	smpsFMvoice	$06
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0D,	$01,	$07,	$04
;	Alter Pitch	value
	smpsAlterPitch	$F4
	dc.b		nRst,	$20
;	Call At	 	location
	smpsCall	GHZ_Call02
	dc.b		nC6,	$38
;	Call At	 	location
	smpsCall	GHZ_Call02
	dc.b		nC6,	$08,	$08,	nE6
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Set FM Voice	#
	smpsFMvoice	$06
;	Alter Pitch	value
	smpsAlterPitch	$F4
	dc.b		nD6,	$34,	smpsNoAttack,	$34,	nC6,	$08,	nD6,	nE6
	dc.b		$38,	smpsNoAttack,	$38,	nC6,	$08,	nC6,	nE6,	nEb6
	dc.b		$34,	smpsNoAttack,	$34,	nC6,	$08,	nEb6,	nD6,	$1C
	dc.b		smpsNoAttack,	$1C
;	Set FM Voice	#
	smpsFMvoice	$05
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Alter Volume	value
	smpsAlterVol	$0A
	dc.b		nRst,	$08,	nE7,	$0C,	nRst,	$04
;	Note Fill	duration
	smpsNoteFill	$0B
	dc.b		nE7,	$08,	nF7,	nE7,	nG7
;	Note Fill	duration
	smpsNoteFill	$14
	dc.b		nE7,	$10
;	Note Fill	duration
	smpsNoteFill	$0B
	dc.b		nC7,	$08
;	Note Fill	duration
	smpsNoteFill	$00
;	Alter Volume	value
	smpsAlterVol	$F6
;	Alter Pitch	value
	smpsAlterPitch	$18
;	Jump To	 	location
	smpsJump	GHZ_Jump01

GHZ_Call01:
	dc.b		nA6,	$04,	nF6,	nA6,	nF6,	nB6,	nG6,	nB6
	dc.b		nG6,	nC7,	nA6,	nC7,	nA6,	nD7,	nB6,	nD7
	dc.b		nB6
	smpsReturn

GHZ_Call02:
	dc.b		nC7,	$08,	nA6,	$10,	nC7,	$08,	nB6,	$10
	dc.b		nC7,	$08,	nB6,	$10,	nG6,	$30,	nA6,	$08
	dc.b		nE7,	nD7,	$10,	nC7,	$08,	nB6,	$10,	nC7
	dc.b		$08,	nB6,	$10,	nG6,	$38,	nC7,	$08,	nA6
	dc.b		$10,	nC7,	$08,	nB6,	$10,	nC7,	$08,	nB6
	dc.b		$10,	nG6,	$30,	nA6,	$08,	$08,	nF6,	$10
	dc.b		nA6,	$08,	nG6,	$10,	nA6,	$08,	nG6,	$10
	smpsReturn

; FM2 Data
GHZ_FM2:
;	Set FM Voice	#
	smpsFMvoice	$00
;	E2	 	#
	smpsE2		$01
	dc.b		nRst,	$08,	nA2,	nA3,	nA2,	nBb2,	nBb3,	nB2
	dc.b		nB3
;	Note Fill	duration
	smpsNoteFill	$04
;	Set FM Voice	#
	smpsFMvoice	$01
GHZ_Loop02:
	dc.b		nC3,	$08
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$18,	GHZ_Loop02
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nC3,	$04,	nRst,	nC3,	$08,	nA2,	$04,	nRst
	dc.b		nA2,	$08,	nBb2,	$04,	nRst,	nBb2,	$08,	nB2
	dc.b		$04,	nRst,	nB2,	$08
;	Note Fill	duration
	smpsNoteFill	$04
GHZ_Loop03:
	dc.b		nC3,	$08
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$1D,	GHZ_Loop03
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nC3,	nD3,	nE3
GHZ_Jump02:
;	Set FM Voice	#
	smpsFMvoice	$01
;	Call At	 	location
	smpsCall	GHZ_Call03
;	Call At	 	location
	smpsCall	GHZ_Call04
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nC3,	nD3,	nE3
;	Call At	 	location
	smpsCall	GHZ_Call03
;	Call At	 	location
	smpsCall	GHZ_Call04
	dc.b		nC3,	nC3,	nC3
;	Note Fill	duration
	smpsNoteFill	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nBb2,	$18,	nA2,	nG2,	nF2,	nE2,	$08,	nRst
	dc.b		nD2,	nRst,	nA2,	$18,	nB2,	nC3,	nD3,	nE3
	dc.b		$08,	nRst,	nA3,	nRst,	nAb3,	$18,	nG3,	nF3
	dc.b		nEb3,	nD3,	$08,	nRst,	nC3,	nRst,	nG2,	$18
	dc.b		nD3,	nG2,	nG3,	$08,	nE2,	nE3,	nF2,	nF3
	dc.b		nG2,	nG3
;	Note Fill	duration
	smpsNoteFill	$04
;	E2	 	#
	smpsE2		$01
;	Jump To	 	location
	smpsJump	GHZ_Jump02

GHZ_Call03:
;	Note Fill	duration
	smpsNoteFill	$04
	dc.b		nF3,	$08,	nF3,	nF3,	nF3,	nF3,	nF3,	nF3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nF3
;	Note Fill	duration
	smpsNoteFill	$04
	dc.b		nE3,	nE3,	nE3,	nE3,	nE3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nC3,	nD3,	nE3
;	Note Fill	duration
	smpsNoteFill	$04
	dc.b		nF3,	nF3,	nF3,	nF3,	nF3,	nF3,	nF3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nF3
;	Note Fill	duration
	smpsNoteFill	$04
	dc.b		nE3,	nE3,	nE3,	nE3,	nE3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nC3,	nD3,	nE3
	smpsReturn

GHZ_Call04:
;	Note Fill	duration
	smpsNoteFill	$04
	dc.b		nF3,	nF3,	nF3,	nF3,	nF3,	nF3,	nF3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nF3
;	Note Fill	duration
	smpsNoteFill	$04
	dc.b		nE3,	nE3,	nE3,	nE3,	nE3,	nE3,	nE3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nE3
;	Note Fill	duration
	smpsNoteFill	$04
	dc.b		nD3,	nD3,	nD3,	nD3,	nD3,	nD3,	nD3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD3
;	Note Fill	duration
	smpsNoteFill	$04
	dc.b		nC3,	nC3,	nC3,	nC3,	nC3
	smpsReturn

; FM3 Data
GHZ_FM3:
;	Set FM Voice	#
	smpsFMvoice	$02
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Call At	 	location
	smpsCall	GHZ_Call01
;	Set FM Voice	#
	smpsFMvoice	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Pitch	value
	smpsAlterPitch	$E8
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nRst,	$01
GHZ_Loop04:
	dc.b		nC6,	$01,	smpsNoAttack,	nB5,	$0F,	nRst,	$08,	nBb5
	dc.b		$01,	smpsNoAttack,	nA5,	$0F,	nRst,	$08
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	GHZ_Loop04
	dc.b		nC6,	$01,	smpsNoAttack,	nB5,	$07,	nRst,	$08,	nBb5
	dc.b		$01,	smpsNoAttack,	nA5,	$07,	nRst,	$08,	nCs6,	$01
	dc.b		smpsNoAttack,	nC6,	$0F,	nRst,	$08,	nC6,	$01,	smpsNoAttack
	dc.b		nB5,	$0F,	nRst,	$08,	nBb5,	$01,	smpsNoAttack,	nA5
	dc.b		$10,	smpsNoAttack,	$3B,	nRst,	$04
GHZ_Loop05:
	dc.b		nBb5,	$01,	smpsNoAttack,	nA5,	$0F,	nRst,	$08,	nC6
	dc.b		$01,	smpsNoAttack,	nB5,	$0F,	nRst,	$08,	nCs6,	$01
	dc.b		smpsNoAttack,	nC6,	$07,	nRst,	$08
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	GHZ_Loop05
	dc.b		nCs6,	$01,	smpsNoAttack,	nC6,	$0F,	nRst,	$08,	nC6
	dc.b		$01,	smpsNoAttack,	nB5,	$28,	smpsNoAttack,	$3E
;	Alter Volume	value
	smpsAlterVol	$02
;	Alter Pitch	value
	smpsAlterPitch	$18
GHZ_Jump03:
;	Set FM Voice	#
	smpsFMvoice	$05
;	Alter Pitch	value
	smpsAlterPitch	$E8
;	Call At	 	location
	smpsCall	GHZ_Call05
	dc.b		nA6
;	Call At	 	location
	smpsCall	GHZ_Call05
	dc.b		nE7
;	Call At	 	location
	smpsCall	GHZ_Call05
	dc.b		nA6,	nRst,	$24,	nRst,	nC7,	$04,	nRst,	$0C
	dc.b		nA6,	$10,	nG6,	$04,	nRst,	nA6,	nRst,	nC7
	dc.b		nRst,	smpsModOff
;	Set FM Voice	#
	smpsFMvoice	$05
;	Call At	 	location
	smpsCall	GHZ_Call06
	dc.b		nG6,	$04,	nA6,	nC7,	$08,	nA6
;	Call At	 	location
	smpsCall	GHZ_Call06
	dc.b		nG6,	$04,	nA6,	nC7,	$08,	nE7
;	Call At	 	location
	smpsCall	GHZ_Call06
	dc.b		nG6,	$04,	nA6,	nC7,	$08,	nA6
;	Alter Volume	value
	smpsAlterVol	$06
	dc.b		nC5,	nA4,	$04,	nRst,	$16,	nRst
;	Alter Volume	value
	smpsAlterVol	$FA
	dc.b		nE7,	$08,	nRst,	nC7,	nRst,	nA6,	nA6,	nA6
	dc.b		$04,	nRst,	nC7,	nRst,	nE7,	nRst
;	Alter Pitch	value
	smpsAlterPitch	$18
;	Set FM Voice	#
	smpsFMvoice	$07
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Note Fill	duration
	smpsNoteFill	$1E
;	Alter Volume	value
	smpsAlterVol	$06
	dc.b		nF5,	$18,	$18,	$18,	$18,	$08,	nRst,	nF5
	dc.b		nRst,	nE5,	$18,	$18,	$18,	$18,	$08,	nRst
	dc.b		nE5,	nRst,	nEb5,	$18,	$18,	$18,	$18,	$08
	dc.b		nRst,	nEb5,	nRst,	nA5,	$18,	$18,	$18,	$18
	dc.b		$08,	nRst,	nA5,	nRst
;	Alter Volume	value
	smpsAlterVol	$FA
;	Note Fill	duration
	smpsNoteFill	$00
;	Jump To	 	location
	smpsJump	GHZ_Jump03

GHZ_Call05:
	dc.b		nRst,	$34,	nRst,	nG6,	$04,	nA6,	nC7,	$08
	smpsReturn

GHZ_Call06:
;	Alter Volume	value
	smpsAlterVol	$06
	dc.b		nE5,	$08,	nC5,	$04,	nRst,	$12,	nRst,	nE5
	dc.b		$08,	nC5,	$04,	nRst,	nD5,	$08,	nB4,	$04
	dc.b		nRst,	$0E,	nRst
;	Alter Volume	value
	smpsAlterVol	$FA
	smpsReturn

; FM4 Data
GHZ_FM4:
;	Set FM Voice	#
	smpsFMvoice	$08
	dc.b		nRst,	$20,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Pitch	value
	smpsAlterPitch	$E8
;	Alter Volume	value
	smpsAlterVol	$0A
GHZ_Loop06:
	dc.b		nAb5,	$01,	smpsNoAttack,	nG5,	$0F,	nRst,	$08,	nFs5
	dc.b		$01,	smpsNoAttack,	nF5,	$0F,	nRst,	$08
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	GHZ_Loop06
	dc.b		nAb5,	$01,	smpsNoAttack,	nG5,	$07,	nRst,	$08,	nFs5
	dc.b		$01,	smpsNoAttack,	nF5,	$07,	nRst,	$08,	nBb5,	$01
	dc.b		smpsNoAttack,	nA5,	$0F,	nRst,	$08,	nAb5,	$01,	smpsNoAttack
	dc.b		nG5,	$0F,	nRst,	$08,	nFs5,	$01,	smpsNoAttack,	nF5
	dc.b		$10,	smpsNoAttack,	$3C,	nRst,	$04
GHZ_Loop07:
	dc.b		nFs5,	$01,	smpsNoAttack,	nF5,	$0F,	nRst,	$08,	nAb5
	dc.b		$01,	smpsNoAttack,	nG5,	$0F,	nRst,	$08,	nBb5,	$01
	dc.b		smpsNoAttack,	nA5,	$07,	nRst,	$08
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	GHZ_Loop07
	dc.b		nBb5,	$01,	smpsNoAttack,	nA5,	$0F,	nRst,	$08,	nAb5
	dc.b		$01,	smpsNoAttack,	nG5,	$28,	smpsNoAttack,	$3F
;	Alter Volume	value
	smpsAlterVol	$F6
;	Alter Pitch	value
	smpsAlterPitch	$18
	dc.b		smpsModOff
GHZ_Jump04:
;	Set FM Voice	#
	smpsFMvoice	$05
;	Alter Pitch	value
	smpsAlterPitch	$E8
;	Alter Volume	value
	smpsAlterVol	$18
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Alter Volume	value
	smpsAlterVol	$FD
;	Call At	 	location
	smpsCall	GHZ_Call07
	dc.b		nD5,	nD5,	nE5,	nE5,	nC5,	nC5,	nA4,	nA4
	dc.b		nF4,	nF4,	nD5,	nD5,	nB4,	nB4,	nG4,	nG4
	dc.b		nD5,	nD5
;	Call At	 	location
	smpsCall	GHZ_Call07
	dc.b		nE4,	nE4,	nC5,	nC5,	nA4,	nA4,	nF4,	nF4
	dc.b		nD4,	nD4,	nB4,	nB4
;	Alter Volume	value
	smpsAlterVol	$03
;	Alter Pitch	value
	smpsAlterPitch	$18
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		nG6,	$10,	nA6,	nB6
;	Alter Volume	value
	smpsAlterVol	$F9
	dc.b		nC7,	$28,	smpsNoAttack,	$28,	nD7,	$10,	nB6,	nG6
	dc.b		nC7,	$28,	smpsNoAttack,	$28,	nB6,	$10,	nG6,	nB6
	dc.b		nC7,	$28,	smpsNoAttack,	$28,	nD7,	$10,	nB6,	nG6
	dc.b		nC7,	$40,	smpsNoAttack,	$40
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Alter Volume	value
	smpsAlterVol	$07
;	Alter Volume	value
	smpsAlterVol	$E8
;	Set FM Voice	#
	smpsFMvoice	$07
;	Note Fill	duration
	smpsNoteFill	$1E
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Volume	value
	smpsAlterVol	$12
	dc.b		nD5,	$18,	$18,	$18,	$18,	$08,	nRst,	nD5
	dc.b		nRst,	nC5,	$18,	$18,	$18,	$18,	$08,	nRst
	dc.b		nC5,	nRst,	nC5,	$18,	$18,	$18,	$18,	$08
	dc.b		nRst,	nC5,	nRst,	nF5,	$18,	$18,	$18,	$18
	dc.b		$08,	nRst,	nF5,	nRst
;	Alter Volume	value
	smpsAlterVol	$EE
;	Note Fill	duration
	smpsNoteFill	$00
;	Jump To	 	location
	smpsJump	GHZ_Jump04

GHZ_Call07:
	dc.b		nE5,	$08,	nE5,	nC5,	nC5,	nA4,	nA4,	nF4
	dc.b		nF4,	nD5,	nD5,	nB4,	nB4,	nG4,	nG4
	smpsReturn

; FM5 Data
GHZ_FM5:
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nRst,	$20,	nRst
;	Set FM Voice	#
	smpsFMvoice	$08
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Pitch	value
	smpsAlterPitch	$E8
;	Alter Volume	value
	smpsAlterVol	$F2
GHZ_Loop08:
	dc.b		nF5,	$01,	smpsNoAttack,	nE5,	$0F,	nRst,	$08,	nEb5
	dc.b		$01,	smpsNoAttack,	nD5,	$0F,	nRst,	$08
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	GHZ_Loop08
	dc.b		nF5,	$01,	smpsNoAttack,	nE5,	$07,	nRst,	$08,	nEb5
	dc.b		$01,	smpsNoAttack,	nD5,	$07,	nRst,	$08,	nFs5,	$01
	dc.b		smpsNoAttack,	nF5,	$0F,	nRst,	$08,	nF5,	$01,	smpsNoAttack
	dc.b		nE5,	$0F,	nRst,	$08,	nEb5,	$01,	smpsNoAttack,	nD5
	dc.b		$10,	smpsNoAttack,	$3C,	nRst,	$04
GHZ_Loop09:
	dc.b		nEb5,	$01,	smpsNoAttack,	nD5,	$0F,	nRst,	$08,	nF5
	dc.b		$01,	smpsNoAttack,	nE5,	$0F,	nRst,	$08,	nFs5,	$01
	dc.b		smpsNoAttack,	nF5,	$07,	nRst,	$08
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	GHZ_Loop09
	dc.b		nFs5,	$01,	smpsNoAttack,	nF5,	$0F,	nRst,	$08,	nF5
	dc.b		$01,	smpsNoAttack,	nE5,	$28,	smpsNoAttack,	$3F
;	Alter Pitch	value
	smpsAlterPitch	$18
;	Alter Volume	value
	smpsAlterVol	$0E
GHZ_Jump05:
;	Set FM Voice	#
	smpsFMvoice	$05
;	Alter Pitch	value
	smpsAlterPitch	$E8
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Volume	value
	smpsAlterVol	$FD
;	Call At	 	location
	smpsCall	GHZ_Call08
	dc.b		nD5,	nD5,	nE5,	nE5,	nC5,	nC5,	nA4,	nA4
	dc.b		nF4,	nF4,	nD5,	nD5,	nB4,	nB4,	nG4,	nG4
	dc.b		nD5,	nD5
;	Call At	 	location
	smpsCall	GHZ_Call08
	dc.b		nE4,	nE4,	nC5,	nC5,	nA4,	nA4,	nF4,	nF4
	dc.b		nD4,	nD4,	nB4,	nB4
;	Alter Pitch	value
	smpsAlterPitch	$18
;	Alter Volume	value
	smpsAlterVol	$03
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Set FM Voice	#
	smpsFMvoice	$04
;	Alter Notes	value
	smpsAlterNote	$02
	dc.b		nG6,	$10,	nA6,	nB6
;	Alter Volume	value
	smpsAlterVol	$F9
	dc.b		nC7,	$28,	smpsNoAttack,	$28,	nD7,	$10,	nB6,	nG6
	dc.b		nC7,	$28,	smpsNoAttack,	$28,	nB6,	$10,	nG6,	nB6
	dc.b		nC7,	$28,	smpsNoAttack,	$28,	nD7,	$10,	nB6,	nG6
	dc.b		nC7,	$40,	smpsNoAttack,	$40
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Alter Notes	value
	smpsAlterNote	$00
;	Set FM Voice	#
	smpsFMvoice	$04
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Alter Volume	value
	smpsAlterVol	$FA
GHZ_Loop0A:
	dc.b		nBb6,	$08,	nF6,	nD7,	nF6,	nBb6,	nF6,	nD7
	dc.b		nF6
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	GHZ_Loop0A
GHZ_Loop0B:
	dc.b		nA6,	nE6,	nC7,	nE6,	nA6,	nE6,	nC7,	nE6
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	GHZ_Loop0B
GHZ_Loop0C:
	dc.b		nAb6,	nEb6,	nC7,	nEb6,	nAb6,	nEb6,	nC7,	nEb6
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	GHZ_Loop0C
GHZ_Loop0D:
	dc.b		nC7,	nA6,	nE7,	nA6,	nC7,	nA6,	nE7,	nA6
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	GHZ_Loop0D
;	Alter Volume	value
	smpsAlterVol	$0D
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Jump To	 	location
	smpsJump	GHZ_Jump05

GHZ_Call08:
	dc.b		nE5,	$08,	nE5,	nC5,	nC5,	nA4,	nA4,	nF4
	dc.b		nF4,	nD5,	nD5,	nB4,	nB4,	nG4,	nG4
	smpsReturn

; PSG1 Data
GHZ_PSG1:
;	Set PSG Voice	#
	smpsPSGvoice	$05
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0E,	$01,	$01,	$03
	dc.b		nRst,	$40
;	Note Fill	duration
	smpsNoteFill	$10
	dc.b		nE5,	$18,	nD5,	nE5,	nD5,	nE5,	$08,	nRst
	dc.b		nD5,	nRst,	nF5,	$18,	nE5
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD5,	$28,	smpsNoAttack,	$28
;	Note Fill	duration
	smpsNoteFill	$10
	dc.b		nD5,	$18,	nE5,	nF5,	$10,	nD5,	$18,	nE5
	dc.b		nF5,	$10,	$18
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nE5,	$34,	smpsNoAttack,	$34,	smpsModOff
GHZ_Loop0F:
;	Set PSG Voice	#
	smpsPSGvoice	$01
GHZ_Loop0E:
	dc.b		nRst,	$10,	nC6,	$04,	nRst,	$14,	nC6,	$08
	dc.b		nRst,	$20,	nB5,	$04,	nRst,	$14,	nB5,	$08
	dc.b		nRst,	$10
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$03,	GHZ_Loop0E
	dc.b		nRst,	$10,	nA5,	$04,	nRst,	$14,	nA5,	$08
	dc.b		nRst,	$20,	nG5,	$04,	nRst,	$14,	nG5,	$08
	dc.b		nRst,	$10
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	GHZ_Loop0F
;	Set PSG Voice	#
	smpsPSGvoice	$05
	dc.b		nBb6,	$18,	nA6,	nG6,	nF6,	nE6,	$08,	nRst
	dc.b		nD6,	nRst,	nA5,	$18,	nB5,	nC6,	nD6,	nE6
	dc.b		$08,	nRst,	nA6,	nRst,	nAb6,	$18,	nG6,	nF6
	dc.b		nEb6,	nD6,	$10,	nC6,	$08,	nRst,	nRst,	$08
	dc.b		nG6,	nA6,	nG6,	$10,	$08,	nA6,	nRst,	$10
;	Set Volume	value
	smpsSetVol	$01
	dc.b		nA5,	$18,	$08,	nRst,	nA5,	nRst
;	Set Volume	value
	smpsSetVol	$FF
;	Set PSG Voice	#
	smpsPSGvoice	$03
;	Jump To	 	location
	smpsJump	GHZ_Loop0F

; PSG2 Data
GHZ_PSG2:
	dc.b		nRst,	$40
;	Set Volume	value
	smpsSetVol	$FE
GHZ_Loop10:
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nC7,	$08,	nB6,	nA6,	nG6,	nC7,	nB6,	nA6
	dc.b		nG6
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	GHZ_Loop10
;	Note Fill	duration
	smpsNoteFill	$00
GHZ_Loop12:
;	Set PSG Voice	#
	smpsPSGvoice	$01
GHZ_Loop11:
	dc.b		nRst,	$10,	nE6,	$04,	nRst,	$14,	nE6,	$08
	dc.b		nRst,	$20,	nD6,	$04,	nRst,	$14,	nD6,	$08
	dc.b		nRst,	$10
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$03,	GHZ_Loop11
	dc.b		nRst,	$10,	nC6,	$04,	nRst,	$14,	nC6,	$08
	dc.b		nRst,	$20,	nB5,	$04,	nRst,	$14,	nB5,	$08
	dc.b		nRst,	$10
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	GHZ_Loop12
	dc.b		nD6,	$34,	smpsNoAttack,	$34,	nC6,	$08,	nD6,	nE6
	dc.b		$38,	smpsNoAttack,	$38,	nC6,	$08,	nC6,	nE6,	nEb6
	dc.b		$34,	smpsNoAttack,	$34,	nC6,	$08,	nEb6,	nD6
;	Set PSG Voice	#
	smpsPSGvoice	$05
	dc.b		nC5,	$18,	$18,	$18,	$18,	$08,	nRst,	nC5
	dc.b		nRst
;	Set PSG Voice	#
	smpsPSGvoice	$03
;	Jump To	 	location
	smpsJump	GHZ_Loop12

; PSG3 Data
GHZ_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nA5,	$10,	$10,	$10
GHZ_Jump06:
	dc.b		$08
;	Jump To	 	location
	smpsJump	GHZ_Jump06

; DAC Data
GHZ_DAC:
	dc.b		nRst,	$08,	dKick,	dSnare,	dKick,	dKick,	dSnare,	dSnare
	dc.b		dSnare
GHZ_Loop13:
	dc.b		dKick,	$10,	dSnare,	$08,	dKick,	$10,	$08,	dSnare
	dc.b		$10
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$07,	GHZ_Loop13
	dc.b		dKick,	$10,	dSnare,	$08,	dKick,	$10,	dSnare,	$08
	dc.b		$08,	$08
GHZ_Loop14:
	dc.b		dKick,	$10,	dSnare,	$08,	dKick,	$10,	$08,	dSnare
	dc.b		$10
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$07,	GHZ_Loop14
	dc.b		dKick,	$10,	dSnare,	$08,	dKick,	$10,	dSnare,	$08
	dc.b		$08,	$08
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$02,	GHZ_Loop14
;	Jump To	 	location
	smpsJump	GHZ_Loop14

GHZ_Voices:
;	Voice 00
;	$08,$0A,$70,$30,$00,$1F,$1F,$5F,$5F,$12,$0E,$0A,$0A,$00,$04,$04,$03,$2F,$2F,$2F,$2F,$24,$2D,$13,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$01
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$03,	$07,	$00
	smpsVcCoarseFreq	$00,	$00,	$00,	$0A
	smpsVcRateScale		$01,	$01,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$0A,	$0E,	$12
	smpsVcDecayRate2	$03,	$04,	$04,	$00
	smpsVcDecayLevel	$02,	$02,	$02,	$02
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$13,	$2D,	$24

;	Voice 01
;	$20,$36,$35,$30,$31,$DF,$DF,$9F,$9F,$07,$06,$09,$06,$07,$06,$06,$08,$20,$10,$10,$F8,$19,$37,$13,$80
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
	smpsVcTotalLevel	$80,	$13,	$37,	$19

;	Voice 02
;	$36,$0F,$01,$01,$01,$1F,$1F,$1F,$1F,$12,$11,$0E,$00,$00,$0A,$07,$09,$FF,$0F,$1F,$0F,$18,$80,$80,$80
;				#
	smpsVcAlgorithm		$06
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$0F
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$0E,	$11,	$12
	smpsVcDecayRate2	$09,	$07,	$0A,	$00
	smpsVcDecayLevel	$00,	$01,	$00,	$0F
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$80,	$80,	$18

;	Voice 03
;	$3D,$01,$02,$02,$02,$14,$0E,$8C,$0E,$08,$05,$02,$05,$00,$0D,$0D,$0D,$1F,$1F,$1F,$1F,$1A,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$02,	$02,	$02,	$01
	smpsVcRateScale		$00,	$02,	$00,	$00
	smpsVcAttackRate	$0E,	$0C,	$0E,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$02,	$05,	$08
	smpsVcDecayRate2	$0D,	$0D,	$0D,	$00
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$80,	$80,	$1A

;	Voice 04
;	$2C,$72,$78,$34,$34,$1F,$12,$1F,$12,$00,$0A,$00,$0A,$00,$00,$00,$00,$0F,$1F,$0F,$1F,$16,$80,$17,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$07,	$07
	smpsVcCoarseFreq	$04,	$04,	$08,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$12,	$1F,	$12,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$00,	$0A,	$00
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$01,	$00,	$01,	$00
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$17,	$80,	$16

;	Voice 05
;	$2C,$74,$74,$34,$34,$1F,$12,$1F,$1F,$00,$00,$00,$00,$00,$01,$00,$01,$0F,$3F,$0F,$3F,$16,$80,$17,$80
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
	smpsVcTotalLevel	$80,	$17,	$80,	$16

;	Voice 06
;	$04,$72,$42,$32,$32,$12,$12,$12,$12,$00,$08,$00,$08,$00,$08,$00,$08,$0F,$1F,$0F,$1F,$23,$80,$23,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$04,	$07
	smpsVcCoarseFreq	$02,	$02,	$02,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$12,	$12,	$12,	$12
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$08,	$00,	$08,	$00
	smpsVcDecayRate2	$08,	$00,	$08,	$00
	smpsVcDecayLevel	$01,	$00,	$01,	$00
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$23,	$80,	$23

;	Voice 07
;	$3D,$01,$02,$02,$02,$10,$50,$50,$50,$07,$08,$08,$08,$01,$00,$00,$00,$20,$17,$17,$17,$1C,$80,$80,$80
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
	smpsVcReleaseRate	$07,	$07,	$07,	$00
	smpsVcTotalLevel	$80,	$80,	$80,	$1C

;	Voice 08
;	$2C,$74,$74,$34,$34,$1F,$12,$1F,$1F,$00,$07,$00,$07,$00,$07,$00,$07,$00,$38,$00,$38,$16,$80,$17,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$07,	$07
	smpsVcCoarseFreq	$04,	$04,	$04,	$04
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$12,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$07,	$00,	$07,	$00
	smpsVcDecayRate2	$07,	$00,	$07,	$00
	smpsVcDecayLevel	$03,	$00,	$03,	$00
	smpsVcReleaseRate	$08,	$00,	$08,	$00
	smpsVcTotalLevel	$80,	$17,	$80,	$16
	even
