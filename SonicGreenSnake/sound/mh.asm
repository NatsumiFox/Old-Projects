; =============================================================================================
; Project Name:		mh
; Created:		8th May 2015
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

mh_Header:
;	Voice Pointer	location
	smpsHeaderVoice	mh_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$07,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$01,	$03

;	DAC Pointer	location
	smpsHeaderDAC	mh_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	mh_FM1,	smpsPitch00,	volWOI+$02
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	mh_FM2,	smpsPitch01lo,	volWOI+$01
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	mh_FM3,	smpsPitch00,	volWOI+$01
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	mh_FM4,	smpsPitch00,	volWOI+$02
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	mh_FM5,	smpsPitch00,	volWOI+$04
;	FM6 Pointer	location	pitch		volume
	smpsHeaderFM	mh_FM6,	smpsPitch00,	volWOI+$03
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	mh_PSG1,	smpsPitch04lo,	$02,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	mh_PSG2,	smpsPitch04lo,	$02,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	mh_PSG3,	smpsPitch04lo,	$02,	$00

; DAC Data
mh_DAC:
	smpsStop

; FM1 Data
mh_FM1:
	smpsSetVolWOI 2
;	Set FM Voice	#
	smpsFMvoice	$00
mh_Loop01:
	dc.b		nAb2,	$06,	nEb3,	nAb3,	nA3,	nB3,	nEb4,	nAb4
	dc.b		nA4,	nB4,	nEb5,	nA5,	nB5,	nA5,	nFs5,	nCs5
	dc.b		nA4,	nFs4,	nCs4,	nA3,	nFs3,	nCs3,	nA2,	nFs2
	dc.b		nFs3
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	mh_Loop01
mh_Loop02:
	dc.b		nEb2,	$06,	nBb2,	nCs3,	nF3,	nG3,	nBb3,	nCs4
	dc.b		nF4,	nG4,	nBb4,	nCs5,	nF5,	nCs2,	nAb2,	nB2
	dc.b		nEb3,	nE3,	nAb3,	nB3,	nEb4,	nE4,	nAb4,	nB4
	dc.b		nEb5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	mh_Loop02
;	Jump To	 	location
	smpsJump	mh_Loop01

; FM2 Data
mh_FM2:
	smpsSetVolWOI 1
;	Set FM Voice	#
	smpsFMvoice	$01
mh_Loop03:
	dc.b		nAb3,	$18,	nEb4,	nB4,	nA4,	nCs4,	nFs3,	nAb3
	dc.b		$18,	nEb4,	nB4,	nFs4,	nCs4,	nFs3
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	mh_Loop03
mh_Loop04:
	dc.b		nEb3,	$18,	nBb3,	nG4,	nCs3,	nB3,	nEb4
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	mh_Loop04
;	Jump To	 	location
	smpsJump	mh_Loop03

; FM3 Data
mh_FM3:
	smpsSetVolWOI 1
;	Set FM Voice	#
	smpsFMvoice	$02
mh_Jump01:
;	Call At	 	location
	smpsCall	mh_Call01
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nB4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nB4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nE5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nE5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nAb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nAb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nFs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nFs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nE5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nE5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Call At	 	location
	smpsCall	mh_Call01
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nB4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nB4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nE5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nE5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nAb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nAb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nFs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nA5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nA5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nA5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nA5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nA5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
mh_Loop05:
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nD5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nD5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	mh_Loop05
;	Jump To	 	location
	smpsJump	mh_Jump01

mh_Call01:
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nB4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nB4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nE5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nE5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nB4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nB4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nAb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nAb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nA4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nA4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	smpsReturn

; FM4 Data
mh_FM4:
;	Set FM Voice	#
	smpsSetVolWOI 2
	smpsFMvoice	$02
	dc.b 		nRst,	$06
;	Alter Pitch	value
	smpsAlterPitch	$F4
mh_Jump02:
;	Call At	 	location
	smpsCall	mh_Call02
;	Alter Volume	value
	smpsAlterVol	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nB4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nE5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nAb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nAb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nFs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nFs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nE5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nE5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Call At	 	location
	smpsCall	mh_Call02
;	Alter Volume	value
	smpsAlterVol	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nB4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nE5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nAb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nAb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nFs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nFs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nA5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nA5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nA5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nA5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nA5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nA5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
mh_Loop06:
;	Alter Volume	value
	smpsAlterVol	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nD5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nD5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	mh_Loop06
;	Jump To	 	location
	smpsJump	mh_Jump02

mh_Call02:
;	Alter Volume	value
	smpsAlterVol	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nB4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nE5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nCs5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb5,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nB4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nB4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nAb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nAb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nA4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nA4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
	smpsReturn

; FM5 Data
mh_FM5:
;	Set FM Voice	#
	smpsSetVolWOI 4
	smpsFMvoice	$03
	dc.b		nRst,	$09
mh_Jump03:
;	Call At	 	location
	smpsCall	mh_Call03
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nEb5,	$06,	nEb4,	nEb5,	nEb4,	nB4,	$06,	nB3
	dc.b		nB4,	nB3
;	Alter Volume	value
	smpsAlterVol	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nAb4,	$06,	nAb3,	nAb4,	nAb3,	nA4,	$06,	nA3
	dc.b		nA4,	nA3
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nEb4,	$06,	nEb3,	nEb4,	nEb3,	nEb4,	$06,	nEb3
	dc.b		nEb4,	nEb3
;	Call At	 	location
	smpsCall	mh_Call03
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nEb5,	$06,	nEb4,	nEb5,	nEb4,	nAb5,	$06,	nAb4
	dc.b		nAb5,	nAb4
;	Alter Volume	value
	smpsAlterVol	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$06,	nFs4,	nFs5,	nFs4,	nE5,	$06,	nE4
	dc.b		nE5,	nE4
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nEb5,	$06,	nEb4,	nEb5,	nEb4,	nCs5,	$06,	nCs4
	dc.b		nCs5,	nCs4
;	Call At	 	location
	smpsCall	mh_Call03
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nEb5,	$06,	nEb4,	nEb5,	nEb4,	nB4,	$06,	nB3
	dc.b		nB4,	nB3
;	Alter Volume	value
	smpsAlterVol	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nAb4,	$06,	nAb3,	nAb4,	nAb3,	nA4,	$06,	nA3
	dc.b		nA4,	nA3
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nEb4,	$06,	nEb3,	nEb4,	nEb3,	nEb4,	$06,	nEb3
	dc.b		nEb4,	nEb3
;	Call At	 	location
	smpsCall	mh_Call03
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nEb5,	$06,	nEb4,	nEb5,	nEb4,	nAb5,	$06,	nAb4
	dc.b		nAb5,	nAb4
;	Alter Volume	value
	smpsAlterVol	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$06,	nFs4,	nFs5,	nFs4,	nA5,	$06,	nA4
	dc.b		nA5,	nA4
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA5,	$06,	nA4,	nA5,	nA4,	nA5,	$06,	nA4
	dc.b		nA5,	nA4
mh_Loop07:
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nEb5,	$06,	nEb4,	nEb5,	nEb4,	nEb5,	$06,	nEb4
	dc.b		nEb5,	nEb4
;	Alter Volume	value
	smpsAlterVol	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb5,	$06,	nEb4,	nEb5,	nEb4,	nCs5,	$06,	nCs4
	dc.b		nCs5,	nCs4
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nCs5,	$06,	nCs4,	nCs5,	nCs4,	nD5,	$06,	nD4
	dc.b		nD5,	nD4
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	mh_Loop07
;	Jump To	 	location
	smpsJump	mh_Jump03

mh_Call03:
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nEb4,	$06,	nEb3,	nEb4,	nEb3,	nEb5,	$06,	nEb4
	dc.b		nEb5,	nEb4
;	Alter Volume	value
	smpsAlterVol	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nB4,	$06,	nB3,	nB4,	nB3,	nCs5,	$06,	nCs4
	dc.b		nCs5,	nCs4
;	Alter Volume	value
	smpsAlterVol	$FC
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nE5,	$06,	nE4,	nE5,	nE4,	nCs5,	$06,	nCs4
	dc.b		nCs5,	nCs4
	smpsReturn

; FM6 Data
mh_FM6:
;	Set FM Voice	#
	smpsFMvoice	$00
	smpsSetVolWOI 3
	dc.b 		nRst,	$10
;	Jump To	 	location
	smpsJump	mh_Loop01


mh_PSGvoice	equ $8
; PSG1 Data
mh_PSG1:
;	Set PSG Voice	#
	smpsPSGvoice	mh_PSGvoice
;	smpsSetVolWOI 3
mh_Loop08:
	dc.b		nAb5,	$30,	smpsNoAttack,	$18,	nFs5,	$30,	nA5,	$18
	dc.b		nAb5,	$30,	smpsNoAttack,	$18,	nA5,	nB5,	nA5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	mh_Loop08
	dc.b		nF5,	$0C,	nG5,	$04,	nF5,	nEb5,	nF5,	$0C
	dc.b		nG5,	nAb5,	nBb5,	nB5,	nBb5,	$04,	nB5,	nBb5
	dc.b		nAb5,	$0C,	nG5,	nAb5,	nBb5,	nAb5,	nG5,	$04
	dc.b		nAb5,	nG5,	nF5,	$0C,	nEb5,	nF5,	nG5,	nF5
	dc.b		nEb5,	$04,	nF5,	nEb5,	nCs5,	$0C,	nB4,	nCs5
	dc.b		nEb5,	nEb5,	nF5,	$04,	nEb5,	nCs5,	nEb5,	$0C
	dc.b		nF5,	nG5,	nAb5,	nBb5,	nAb5,	$04,	nBb5,	nAb5
	dc.b		nG5,	$0C,	nF5,	nG5,	nAb5,	nG5,	nF5,	$04
	dc.b		nG5,	nF5,	nEb5,	$0C,	nCs5,	nEb5,	nF5,	nEb5
	dc.b		nCs5,	$04,	nEb5,	nCs5,	nB4,	$0C,	nA4,	nB4
	dc.b		nCs5
;	Jump To	 	location
	smpsJump	mh_Loop08


; PSG3 Data
mh_PSG3:
;	Set PSG Voice	#
	smpsPSGvoice	mh_PSGvoice
;	Alter Notes	value
	smpsAlterNote	$03
;	smpsSetVolWOI 4
	dc.b		nRst,	$09
;	Jump To	 	location
	smpsJump	mh_Loop08

; PSG2 Data
mh_PSG2:
;	Set PSG Voice	#
	smpsPSGvoice	mh_PSGvoice
;	smpsSetVolWOI 3
mh_Loop09:
	dc.b		nEb5,	$30,	smpsNoAttack,	$18,	nCs5,	$30,	nE5,	$18
	dc.b		nEb5,	$30,	smpsNoAttack,	$18,	nE5,	nFs5,	nE5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	mh_Loop09
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nRst,	$07,	nF5,	$0C,	nG5,	$04,	nF5,	nEb5
	dc.b		nF5,	$0C,	nG5,	nAb5,	nBb5,	nB5,	nBb5,	$04
	dc.b		nB5,	nBb5,	nAb5,	$0C,	nG5,	nAb5,	nBb5,	nAb5
	dc.b		nG5,	$04,	nAb5,	nG5,	nF5,	$0C,	nEb5,	nF5
	dc.b		nG5,	nF5,	nEb5,	$04,	nF5,	nEb5,	nCs5,	$0C
	dc.b		nB4,	nCs5,	nEb5,	$05
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nG5,	$0C,	nAb5,	$04,	nG5,	nF5,	nG5,	$0C
	dc.b		nAb5,	nBb5,	nB5,	nCs6,	nB5,	$04,	nCs6,	nB5
	dc.b		nBb5,	$0C,	nAb5,	nBb5,	nB5,	nBb5,	nAb5,	$04
	dc.b		nBb5,	nAb5,	nG5,	$0C,	nF5,	nG5,	nAb5,	nG5
	dc.b		nF5,	$04,	nG5,	nF5,	nEb5,	$0C,	nCs5,	nEb5
	dc.b		nE5
;	Jump To	 	location
	smpsJump	mh_Loop09

mh_Voices:
;	Voice 00
;	$2D,$51,$61,$56,$64,$2F,$2F,$2F,$2F,$0F,$0F,$0F,$0F,$02,$02,$02,$02,$3F,$3A,$3B,$3B,$6B,$00,$00,$00
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$06,	$05,	$06,	$05
	smpsVcCoarseFreq	$04,	$06,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$0F,	$0F,	$0F,	$0F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$0F,	$0F,	$0F
	smpsVcDecayRate2	$02,	$02,	$02,	$02
	smpsVcDecayLevel	$03,	$03,	$03,	$03
	smpsVcReleaseRate	$0B,	$0B,	$0A,	$0F
	smpsVcTotalLevel	$00,	$00,	$00,	$6B

;	Voice 01
;	$35,$22,$01,$01,$30,$1C,$1B,$1B,$1C,$0E,$0F,$0E,$0A,$01,$01,$01,$01,$7F,$6F,$6C,$6F,$30,$00,$00,$00
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$00,	$00,	$02
	smpsVcCoarseFreq	$00,	$01,	$01,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1C,	$1B,	$1B,	$1C
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$0E,	$0F,	$0E
	smpsVcDecayRate2	$01,	$01,	$01,	$01
	smpsVcDecayLevel	$06,	$06,	$06,	$07
	smpsVcReleaseRate	$0F,	$0C,	$0F,	$0F
	smpsVcTotalLevel	$00,	$00,	$00,	$30

;	Voice 02
;	$04,$2A,$11,$2A,$21,$57,$57,$57,$57,$0A,$0C,$0C,$0F,$01,$01,$01,$01,$4C,$46,$4B,$47,$20,$00,$40,$00
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$02,	$02,	$01,	$02
	smpsVcCoarseFreq	$01,	$0A,	$01,	$0A
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$17,	$17,	$17,	$17
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$0C,	$0C,	$0A
	smpsVcDecayRate2	$01,	$01,	$01,	$01
	smpsVcDecayLevel	$04,	$04,	$04,	$04
	smpsVcReleaseRate	$07,	$0B,	$06,	$0C
	smpsVcTotalLevel	$00,	$40,	$00,	$20

;	Voice 03
;	$04,$2A,$11,$2A,$21,$0C,$0C,$0C,$0C,$0A,$0C,$0C,$0F,$01,$01,$01,$01,$3F,$3F,$3F,$3F,$20,$00,$40,$00
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$02,	$02,	$01,	$02
	smpsVcCoarseFreq	$01,	$0A,	$01,	$0A
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$0C,	$0C,	$0C,	$0C
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$0C,	$0C,	$0A
	smpsVcDecayRate2	$01,	$01,	$01,	$01
	smpsVcDecayLevel	$03,	$03,	$03,	$03
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$00,	$40,	$00,	$20
	even
