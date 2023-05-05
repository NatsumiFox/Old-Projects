; =============================================================================================
; Project Name:		Crack_Down_3
; Created:		17th January 2014
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

Crack_Down_3_Header:
;	Voice Pointer	location
	smpsHeaderVoice	Crack_Down_3_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$01,	$05

;	DAC Pointer	location
	smpsHeaderDAC	Crack_Down_3_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	Crack_Down_3_FM1,	smpsPitch01lo,	$00
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	Crack_Down_3_FM2,	smpsPitch00,	$0A
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	Crack_Down_3_FM3,	smpsPitch01lo,	$00
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	Crack_Down_3_FM4,	smpsPitch00,	$0A
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	Crack_Down_3_FM5,	smpsPitch00,	$0A
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Crack_Down_3_PSG1,	smpsPitch03lo,	$03,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Crack_Down_3_PSG2,	smpsPitch03lo,	$03,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Crack_Down_3_PSG3,	smpsPitch00+$0B,	$04,	$00

; FM1 Data
Crack_Down_3_FM1:
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nC3,	$06,	nRst,	$0C,	nEb4,	$06,	nRst,	$0C
	dc.b		nC3,	$06,	nRst,	$0C,	nBb3,	$06,	nRst,	$0C
	dc.b		nG3,	$06,	nRst,	nBb3,	nRst,	nC3,	nRst,	$0C
	dc.b		nEb4,	$06,	nRst,	$0C,	nC4,	$06,	nRst,	$0C
	dc.b		nBb2,	$06,	nRst,	$0C,	nG3,	$06,	nRst,	nBb3
	dc.b		nRst,	nC4,	nRst,	$0C,	nEb4,	$06,	nRst,	$0C
	dc.b		nC4,	$06,	nRst,	$0C,	nBb3,	$06,	nRst,	$0C
	dc.b		nG2,	$06,	nRst,	nBb2,	nRst,	nC4,	nRst,	$0C
	dc.b		nEb4,	$06,	nRst,	$0C,	nC4,	$06,	nRst,	$0C
	dc.b		nFs4,	$06,	nRst,	$0C,	nF4,	$06,	nRst,	$12
	dc.b		nC3,	$06,	nRst,	$0C,	nEb4,	$06,	nRst,	$0C
	dc.b		nC4,	$06,	nRst,	$0C,	nBb3,	$06,	nRst,	$0C
	dc.b		nG3,	$06,	nRst,	nBb2,	nRst,	nC3,	nRst,	$0C
	dc.b		nEb4,	$06,	nRst,	$0C,	nC4,	$06,	nRst,	$0C
	dc.b		nBb3,	$06,	nRst,	$0C,	nG3,	$06,	nRst,	nBb2
	dc.b		nRst,	nC3,	nRst,	$0C,	nEb3,	$06,	nRst,	$0C
	dc.b		nC4,	$06,	nRst,	$0C,	nBb2,	$06,	nRst,	$0C
	dc.b		nG3,	$06,	nRst,	nBb2,	nRst,	nC3,	nRst,	$0C
	dc.b		nEb3,	$06,	nRst,	$0C,	nC3,	$06,	nRst,	$0C
	dc.b		nFs4,	$06,	nRst,	$0C,	nF3,	$06,	nRst,	nEb4
	dc.b		nRst
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nC5,	nRst,	nBb5,	nRst,	$0C,	nFs5,	$06,	nRst
	dc.b		$0C,	nF5,	$06,	nRst,	nF5,	nEb5,	nRst,	nC5
	dc.b		nD5,	nRst,	nC5,	nRst,	nG5,	nRst,	$0C,	nFs5
	dc.b		$06,	nRst,	$0C,	nBb5,	$06,	nRst,	$1E,	nD5
	dc.b		$06,	nRst,	nC5,	nRst,	nG5,	nRst,	$0C,	nFs5
	dc.b		$06,	nRst,	$0C,	nBb5,	$06,	nRst,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
Crack_Down_3_Jump01:
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nEb5,	$06,	nRst,	$0C,	nBb5,	$06,	nRst,	$12
	dc.b		nBb5,	$06,	nRst,	$0C,	nF5,	$06,	nRst,	nC5
	dc.b		nBb5,	nRst,	$1E,	nBb5,	$06,	nC6,	nC5,	nRst
	dc.b		nBb5,	nRst,	$0C,	nFs5,	$06,	nRst,	$0C,	nF5
	dc.b		$06,	nRst,	$0C,	nEb5,	$06,	nRst,	nC5,	nD5
	dc.b		nRst,	nC5,	nRst,	nG5,	nRst,	$0C,	nFs5,	$06
	dc.b		nRst,	$0C,	nBb5,	$06,	nRst,	$1E,	nD5,	$06
	dc.b		nRst,	nC5,	nRst,	nG5,	nRst,	$0C,	nFs5,	$06
	dc.b		nRst,	$0C,	nBb5,	$06,	nRst,	$0C,	nEb5,	$06
	dc.b		nRst,	$0C,	nBb5,	$06,	nRst,	$12,	nBb5,	$06
	dc.b		nRst,	$0C,	nF5,	$06,	nRst,	nC5,	nBb5,	nRst
	dc.b		$1E,	nBb5,	$06,	nC6
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nC3,	nRst,	$0C,	nEb4,	$06,	nRst,	$0C,	nC3
	dc.b		$06,	nRst,	$0C,	nBb3,	$06,	nRst,	$0C,	nG3
	dc.b		$06,	nRst,	nBb3,	nRst,	nC3,	nRst,	$0C,	nEb4
	dc.b		$06,	nRst,	$0C,	nC4,	$06,	nRst,	$0C,	nBb2
	dc.b		$06,	nRst,	$0C,	nG3,	$06,	nRst,	nBb3,	nRst
	dc.b		nC4,	nRst,	$0C,	nEb4,	$06,	nRst,	$0C,	nC4
	dc.b		$06,	nRst,	$0C,	nBb3,	$06,	nRst,	$0C,	nG2
	dc.b		$06,	nRst,	nBb2,	nRst,	nC4,	nRst,	$0C,	nEb4
	dc.b		$06,	nRst,	$0C,	nC4,	$06,	nRst,	$0C,	nFs4
	dc.b		$06,	nRst,	$0C,	nF4,	$06,	nRst,	$12,	nC3
	dc.b		$06,	nRst,	$0C,	nEb4,	$06,	nRst,	$0C,	nC4
	dc.b		$06,	nRst,	$0C,	nBb3,	$06,	nRst,	$0C,	nG3
	dc.b		$06,	nRst,	nBb2,	nRst,	nC3,	nRst,	$0C,	nEb4
	dc.b		$06,	nRst,	$0C,	nC4,	$06,	nRst,	$0C,	nBb3
	dc.b		$06,	nRst,	$0C,	nG3,	$06,	nRst,	nBb2,	nRst
	dc.b		nC3,	nRst,	$0C,	nEb3,	$06,	nRst,	$0C,	nC4
	dc.b		$06,	nRst,	$0C,	nBb2,	$06,	nRst,	$0C,	nG3
	dc.b		$06,	nRst,	nBb2,	nRst,	nC3,	nRst,	$0C,	nEb3
	dc.b		$06,	nRst,	$0C,	nC3,	$06,	nRst,	$0C,	nFs4
	dc.b		$06,	nRst,	$0C,	nF3,	$06,	nRst,	nEb4,	nRst
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nC5,	nRst,	nBb5,	nRst,	$0C,	nFs5,	$06,	nRst
	dc.b		$0C,	nF5,	$06,	nRst,	nF5,	nEb5,	nRst,	nC5
	dc.b		nD5,	nRst,	nC5,	nRst,	nG5,	nRst,	$0C,	nFs5
	dc.b		$06,	nRst,	$0C,	nBb5,	$06,	nRst,	$1E,	nD5
	dc.b		$06,	nRst,	nC5,	nRst,	nG5,	nRst,	$0C,	nFs5
	dc.b		$06,	nRst,	$0C,	nBb5,	$06,	nRst,	$0C,	nEb5
	dc.b		$06,	nRst,	$0C,	nBb5,	$06,	nRst,	$12,	nBb5
	dc.b		$06,	nRst,	$0C,	nF5,	$06,	nRst,	nC5,	nBb5
	dc.b		nRst,	$1E,	nBb5,	$06,	nC6,	nC5,	nRst,	nBb5
	dc.b		nRst,	$0C,	nFs5,	$06,	nRst,	$0C,	nF5,	$06
	dc.b		nRst,	$0C,	nEb5,	$06,	nRst,	nC5,	nD5,	nRst
	dc.b		nC5,	nRst,	nG5,	nRst,	$0C,	nFs5,	$06,	nRst
	dc.b		$0C,	nBb5,	$06,	nRst,	$1E,	nD5,	$06,	nRst
	dc.b		nC5,	nRst,	nG5,	nRst,	$0C,	nFs5,	$06,	nRst
	dc.b		$0C,	nBb5,	$06,	nRst,	$0C,	nEb5,	$06,	nRst
	dc.b		$0C,	nBb5,	$06,	nRst,	$12,	nBb5,	$06,	nRst
	dc.b		$0C,	nF5,	$06,	nRst,	nC5,	nBb5,	nRst,	$1E
	dc.b		nBb5,	$06,	nC6
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nC3,	nRst,	$0C,	nEb4,	$06,	nRst,	$0C,	nC3
	dc.b		$06,	nRst,	$0C,	nBb3,	$06,	nRst,	$0C,	nG3
	dc.b		$06,	nRst,	nBb3,	nRst,	nC3,	nRst,	$0C,	nEb4
	dc.b		$06,	nRst,	$0C,	nC4,	$06,	nRst,	$0C,	nBb2
	dc.b		$06,	nRst,	$0C,	nG3,	$06,	nRst,	nBb3,	nRst
	dc.b		nC4,	nRst,	$0C,	nEb4,	$06,	nRst,	$0C,	nC4
	dc.b		$06,	nRst,	$0C,	nBb3,	$06,	nRst,	$0C,	nG2
	dc.b		$06,	nRst,	nBb2,	nRst,	nC4,	nRst,	$0C,	nEb4
	dc.b		$06,	nRst,	$0C,	nC4,	$06,	nRst,	$0C,	nFs4
	dc.b		$06,	nRst,	$0C,	nF4,	$06,	nRst,	$12,	nC3
	dc.b		$06,	nRst,	$0C,	nEb4,	$06,	nRst,	$0C,	nC4
	dc.b		$06,	nRst,	$0C,	nBb3,	$06,	nRst,	$0C,	nG3
	dc.b		$06,	nRst,	nBb2,	nRst,	nC3,	nRst,	$0C,	nEb4
	dc.b		$06,	nRst,	$0C,	nC4,	$06,	nRst,	$0C,	nBb3
	dc.b		$06,	nRst,	$0C,	nG3,	$06,	nRst,	nBb2,	nRst
	dc.b		nC3,	nRst,	$0C,	nEb3,	$06,	nRst,	$0C,	nC4
	dc.b		$06,	nRst,	$0C,	nBb2,	$06,	nRst,	$0C,	nG3
	dc.b		$06,	nRst,	nBb2,	nRst,	nC3,	nRst,	$0C,	nEb3
	dc.b		$06,	nRst,	$0C,	nC3,	$06,	nRst,	$0C,	nFs4
	dc.b		$06,	nRst,	$0C,	nF3,	$06,	nRst,	nEb4,	nRst
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nC5,	nRst,	nBb5,	nRst,	$0C,	nFs5,	$06,	nRst
	dc.b		$0C,	nF5,	$06,	nRst,	nF5,	nEb5,	nRst,	nC5
	dc.b		nD5,	nRst,	nC5,	nRst,	nG5,	nRst,	$0C,	nFs5
	dc.b		$06,	nRst,	$0C,	nBb5,	$06,	nRst,	$1E,	nD5
	dc.b		$06,	nRst,	nC5,	nRst,	nG5,	nRst,	$0C,	nFs5
	dc.b		$06,	nRst,	$0C,	nBb5,	$06,	nRst,	$0C
;	Jump To	 	location
	smpsJump	Crack_Down_3_Jump01

; FM2 Data
Crack_Down_3_FM2:
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nC2,	$06,	nRst,	$0C,	nEb2,	$06,	nRst,	$0C
	dc.b		nC2,	$06,	nRst,	$0C,	nBb1,	$06,	nRst,	$0C
	dc.b		nG1,	$06,	nRst,	nBb1,	nRst,	nC2,	nRst,	$0C
	dc.b		nEb2,	$06,	nRst,	$0C,	nC2,	$06,	nRst,	$0C
	dc.b		nBb1,	$06,	nRst,	$0C,	nG1,	$06,	nRst,	nBb1
	dc.b		nRst,	nC2,	nRst,	$0C,	nEb2,	$06,	nRst,	$0C
	dc.b		nC2,	$06,	nRst,	$0C,	nBb1,	$06,	nRst,	$0C
	dc.b		nG1,	$06,	nRst,	nBb1,	nRst,	nC2,	nRst,	$0C
	dc.b		nEb2,	$06,	nRst,	$0C,	nC2,	$06,	nRst,	$0C
	dc.b		nFs2,	$12,	nF2,	$06,	nRst,	nEb2,	nRst,	nC2
	dc.b		nRst,	$0C,	nEb2,	$06,	nRst,	$0C,	nC2,	$06
	dc.b		nRst,	$0C,	nBb1,	$06,	nRst,	$0C,	nG1,	$06
	dc.b		nRst,	nBb1,	nRst,	nC2,	nRst,	$0C,	nEb2,	$06
	dc.b		nRst,	$0C,	nC2,	$06,	nRst,	$0C,	nBb1,	$06
	dc.b		nRst,	$0C,	nG1,	$06,	nRst,	nBb1,	nRst,	nC2
	dc.b		nRst,	$0C,	nEb2,	$06,	nRst,	$0C,	nC2,	$06
	dc.b		nRst,	$0C,	nBb1,	$06,	nRst,	$0C,	nG1,	$06
	dc.b		nRst,	nBb1,	nRst,	nC2,	nRst,	$0C,	nEb2,	$06
	dc.b		nRst,	$0C,	nC2,	$06,	nRst,	$0C,	nFs2,	$12
	dc.b		nF2,	$06,	nRst,	nEb2,	nRst,	nC2,	$0C,	nRst
	dc.b		$48,	nC2,	$0C,	$0C,	nRst,	$54,	nC2,	$0C
	dc.b		nRst,	$48
Crack_Down_3_Jump02:
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nC2,	$0C,	$0C,	nRst,	$54,	nC2,	$0C,	nRst
	dc.b		$48,	nC2,	$0C,	$0C,	nRst,	$54,	nC2,	$0C
	dc.b		nRst,	$48,	nC2,	$0C,	$0C,	nRst,	$54,	nC2
	dc.b		$06,	nRst,	$0C,	nEb2,	$06,	nRst,	$0C,	nC2
	dc.b		$06,	nRst,	$0C,	nBb1,	$06,	nRst,	$0C,	nG1
	dc.b		$06,	nRst,	nBb1,	nRst,	nC2,	nRst,	$0C,	nEb2
	dc.b		$06,	nRst,	$0C,	nC2,	$06,	nRst,	$0C,	nBb1
	dc.b		$06,	nRst,	$0C,	nG1,	$06,	nRst,	nBb1,	nRst
	dc.b		nC2,	nRst,	$0C,	nEb2,	$06,	nRst,	$0C,	nC2
	dc.b		$06,	nRst,	$0C,	nBb1,	$06,	nRst,	$0C,	nG1
	dc.b		$06,	nRst,	nBb1,	nRst,	nC2,	nRst,	$0C,	nEb2
	dc.b		$06,	nRst,	$0C,	nC2,	$06,	nRst,	$0C,	nFs2
	dc.b		$12,	nF2,	$06,	nRst,	nEb2,	nRst,	nC2,	nRst
	dc.b		$0C,	nEb2,	$06,	nRst,	$0C,	nC2,	$06,	nRst
	dc.b		$0C,	nBb1,	$06,	nRst,	$0C,	nG1,	$06,	nRst
	dc.b		nBb1,	nRst,	nC2,	nRst,	$0C,	nEb2,	$06,	nRst
	dc.b		$0C,	nC2,	$06,	nRst,	$0C,	nBb1,	$06,	nRst
	dc.b		$0C,	nG1,	$06,	nRst,	nBb1,	nRst,	nC2,	nRst
	dc.b		$0C,	nEb2,	$06,	nRst,	$0C,	nC2,	$06,	nRst
	dc.b		$0C,	nBb1,	$06,	nRst,	$0C,	nG1,	$06,	nRst
	dc.b		nBb1,	nRst,	nC2,	nRst,	$0C,	nEb2,	$06,	nRst
	dc.b		$0C,	nC2,	$06,	nRst,	$0C,	nFs2,	$12,	nF2
	dc.b		$06,	nRst,	nEb2,	nRst,	nC2,	$0C,	nRst,	$48
	dc.b		nC2,	$0C,	$0C,	nRst,	$54,	nC2,	$0C,	nRst
	dc.b		$48,	nC2,	$0C,	$0C,	nRst,	$54,	nC2,	$0C
	dc.b		nRst,	$48,	nC2,	$0C,	$0C,	nRst,	$54,	nC2
	dc.b		$0C,	nRst,	$48,	nC2,	$0C,	$0C,	nRst,	$54
	dc.b		nC2,	$06,	nRst,	$0C,	nEb2,	$06,	nRst,	$0C
	dc.b		nC2,	$06,	nRst,	$0C,	nBb1,	$06,	nRst,	$0C
	dc.b		nG1,	$06,	nRst,	nBb1,	nRst,	nC2,	nRst,	$0C
	dc.b		nEb2,	$06,	nRst,	$0C,	nC2,	$06,	nRst,	$0C
	dc.b		nBb1,	$06,	nRst,	$0C,	nG1,	$06,	nRst,	nBb1
	dc.b		nRst,	nC2,	nRst,	$0C,	nEb2,	$06,	nRst,	$0C
	dc.b		nC2,	$06,	nRst,	$0C,	nBb1,	$06,	nRst,	$0C
	dc.b		nG1,	$06,	nRst,	nBb1,	nRst,	nC2,	nRst,	$0C
	dc.b		nEb2,	$06,	nRst,	$0C,	nC2,	$06,	nRst,	$0C
	dc.b		nFs2,	$12,	nF2,	$06,	nRst,	nEb2,	nRst,	nC2
	dc.b		nRst,	$0C,	nEb2,	$06,	nRst,	$0C,	nC2,	$06
	dc.b		nRst,	$0C,	nBb1,	$06,	nRst,	$0C,	nG1,	$06
	dc.b		nRst,	nBb1,	nRst,	nC2,	nRst,	$0C,	nEb2,	$06
	dc.b		nRst,	$0C,	nC2,	$06,	nRst,	$0C,	nBb1,	$06
	dc.b		nRst,	$0C,	nG1,	$06,	nRst,	nBb1,	nRst,	nC2
	dc.b		nRst,	$0C,	nEb2,	$06,	nRst,	$0C,	nC2,	$06
	dc.b		nRst,	$0C,	nBb1,	$06,	nRst,	$0C,	nG1,	$06
	dc.b		nRst,	nBb1,	nRst,	nC2,	nRst,	$0C,	nEb2,	$06
	dc.b		nRst,	$0C,	nC2,	$06,	nRst,	$0C,	nFs2,	$12
	dc.b		nF2,	$06,	nRst,	nEb2,	nRst,	nC2,	$0C,	nRst
	dc.b		$48,	nC2,	$0C,	$0C,	nRst,	$54,	nC2,	$0C
	dc.b		nRst,	$48
;	Jump To	 	location
	smpsJump	Crack_Down_3_Jump02

; FM3 Data
Crack_Down_3_FM3:
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nC4,	$06,	nRst,	$0C,	nEb3,	$06,	nRst,	$0C
	dc.b		nC4,	$06,	nRst,	$0C,	nBb2,	$06,	nRst,	$0C
	dc.b		nG2,	$06,	nRst,	nBb2,	nRst,	nC4,	nRst,	$0C
	dc.b		nEb3,	$06,	nRst,	$0C,	nC3,	$06,	nRst,	$0C
	dc.b		nBb3,	$06,	nRst,	$0C,	nG2,	$06,	nRst,	nBb2
	dc.b		nRst,	nC3,	nRst,	$0C,	nEb3,	$06,	nRst,	$0C
	dc.b		nC3,	$06,	nRst,	$0C,	nBb2,	$06,	nRst,	$0C
	dc.b		nG3,	$06,	nRst,	nBb3,	nRst,	nC3,	nRst,	$0C
	dc.b		nEb3,	$06,	nRst,	$0C,	nC3,	$06,	nRst,	$0C
	dc.b		nFs3,	$06,	nRst,	$0C,	nF3,	$06,	nRst,	$24
	dc.b		nEb3,	$06,	nRst,	$0C,	nC3,	$06,	nRst,	$0C
	dc.b		nBb2,	$06,	nRst,	$0C,	nG2,	$06,	nRst,	nBb3
	dc.b		nRst,	nC4,	nRst,	$0C,	nEb3,	$06,	nRst,	$0C
	dc.b		nC3,	$06,	nRst,	$0C,	nBb2,	$06,	nRst,	$0C
	dc.b		nG2,	$06,	nRst,	nBb3,	nRst,	nC4,	nRst,	$0C
	dc.b		nEb4,	$06,	nRst,	$0C,	nC3,	$06,	nRst,	$0C
	dc.b		nBb3,	$06,	nRst,	$0C,	nG2,	$06,	nRst,	nBb3
	dc.b		nRst,	nC4,	nRst,	$0C,	nEb4,	$06,	nRst,	$0C
	dc.b		nC4,	$06,	nRst,	$0C,	nFs3,	$06,	nRst,	$0C
	dc.b		nF4,	$06,	nRst,	nEb3,	nRst,	$12
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nG5,	$06,	nRst,	$0C,	nA5,	$06,	nRst,	$0C
	dc.b		nBb5,	$06,	nRst,	nC5,	nA5,	nRst,	$0C,	nBb5
	dc.b		$06,	nBb4,	nRst,	$1E,	nA5,	$06,	nRst,	nC5
	dc.b		nF5,	nRst,	$0C,	nEb5,	$06,	nRst,	nC5,	nRst
	dc.b		nBb4,	nRst,	$0C,	nBb5,	$06,	nRst,	$0C,	nA5
	dc.b		$06,	nRst,	nC5,	nF5,	nRst,	nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
Crack_Down_3_Jump03:
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nA5,	$06,	nRst,	nC5,	nD5,	nBb4,	nC5,	nRst
	dc.b		nEb5,	nRst,	$0C,	nA5,	$06,	nRst,	$0C,	nFs5
	dc.b		$06,	nRst,	$0C,	nG5,	$06,	nRst,	$24,	nG5
	dc.b		$06,	nRst,	$0C,	nA5,	$06,	nRst,	$0C,	nBb5
	dc.b		$06,	nRst,	nC5,	nA5,	nRst,	$0C,	nBb5,	$06
	dc.b		nBb4,	nRst,	$1E,	nA5,	$06,	nRst,	nC5,	nF5
	dc.b		nRst,	$0C,	nEb5,	$06,	nRst,	nC5,	nRst,	nBb4
	dc.b		nRst,	$0C,	nBb5,	$06,	nRst,	$0C,	nA5,	$06
	dc.b		nRst,	nC5,	nF5,	nRst,	nC5,	nA5,	nRst,	nC5
	dc.b		nD5,	nBb4,	nC5,	nRst,	nEb5,	nRst,	$0C,	nA5
	dc.b		$06,	nRst,	$0C,	nFs5,	$06,	nRst,	$0C,	nG5
	dc.b		$06,	nRst,	$18
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nC4,	$06,	nRst,	$0C,	nEb3,	$06,	nRst,	$0C
	dc.b		nC4,	$06,	nRst,	$0C,	nBb2,	$06,	nRst,	$0C
	dc.b		nG2,	$06,	nRst,	nBb2,	nRst,	nC4,	nRst,	$0C
	dc.b		nEb3,	$06,	nRst,	$0C,	nC3,	$06,	nRst,	$0C
	dc.b		nBb3,	$06,	nRst,	$0C,	nG2,	$06,	nRst,	nBb2
	dc.b		nRst,	nC3,	nRst,	$0C,	nEb3,	$06,	nRst,	$0C
	dc.b		nC3,	$06,	nRst,	$0C,	nBb2,	$06,	nRst,	$0C
	dc.b		nG3,	$06,	nRst,	nBb3,	nRst,	nC3,	nRst,	$0C
	dc.b		nEb3,	$06,	nRst,	$0C,	nC3,	$06,	nRst,	$0C
	dc.b		nFs3,	$06,	nRst,	$0C,	nF3,	$06,	nRst,	$24
	dc.b		nEb3,	$06,	nRst,	$0C,	nC3,	$06,	nRst,	$0C
	dc.b		nBb2,	$06,	nRst,	$0C,	nG2,	$06,	nRst,	nBb3
	dc.b		nRst,	nC4,	nRst,	$0C,	nEb3,	$06,	nRst,	$0C
	dc.b		nC3,	$06,	nRst,	$0C,	nBb2,	$06,	nRst,	$0C
	dc.b		nG2,	$06,	nRst,	nBb3,	nRst,	nC4,	nRst,	$0C
	dc.b		nEb4,	$06,	nRst,	$0C,	nC3,	$06,	nRst,	$0C
	dc.b		nBb3,	$06,	nRst,	$0C,	nG2,	$06,	nRst,	nBb3
	dc.b		nRst,	nC4,	nRst,	$0C,	nEb4,	$06,	nRst,	$0C
	dc.b		nC4,	$06,	nRst,	$0C,	nFs3,	$06,	nRst,	$0C
	dc.b		nF4,	$06,	nRst,	nEb3,	nRst,	$12
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nG5,	$06,	nRst,	$0C,	nA5,	$06,	nRst,	$0C
	dc.b		nBb5,	$06,	nRst,	nC5,	nA5,	nRst,	$0C,	nBb5
	dc.b		$06,	nBb4,	nRst,	$1E,	nA5,	$06,	nRst,	nC5
	dc.b		nF5,	nRst,	$0C,	nEb5,	$06,	nRst,	nC5,	nRst
	dc.b		nBb4,	nRst,	$0C,	nBb5,	$06,	nRst,	$0C,	nA5
	dc.b		$06,	nRst,	nC5,	nF5,	nRst,	nC5,	nA5,	nRst
	dc.b		nC5,	nD5,	nBb4,	nC5,	nRst,	nEb5,	nRst,	$0C
	dc.b		nA5,	$06,	nRst,	$0C,	nFs5,	$06,	nRst,	$0C
	dc.b		nG5,	$06,	nRst,	$24,	nG5,	$06,	nRst,	$0C
	dc.b		nA5,	$06,	nRst,	$0C,	nBb5,	$06,	nRst,	nC5
	dc.b		nA5,	nRst,	$0C,	nBb5,	$06,	nBb4,	nRst,	$1E
	dc.b		nA5,	$06,	nRst,	nC5,	nF5,	nRst,	$0C,	nEb5
	dc.b		$06,	nRst,	nC5,	nRst,	nBb4,	nRst,	$0C,	nBb5
	dc.b		$06,	nRst,	$0C,	nA5,	$06,	nRst,	nC5,	nF5
	dc.b		nRst,	nC5,	nA5,	nRst,	nC5,	nD5,	nBb4,	nC5
	dc.b		nRst,	nEb5,	nRst,	$0C,	nA5,	$06,	nRst,	$0C
	dc.b		nFs5,	$06,	nRst,	$0C,	nG5,	$06,	nRst,	$18
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nC4,	$06,	nRst,	$0C,	nEb3,	$06,	nRst,	$0C
	dc.b		nC4,	$06,	nRst,	$0C,	nBb2,	$06,	nRst,	$0C
	dc.b		nG2,	$06,	nRst,	nBb2,	nRst,	nC4,	nRst,	$0C
	dc.b		nEb3,	$06,	nRst,	$0C,	nC3,	$06,	nRst,	$0C
	dc.b		nBb3,	$06,	nRst,	$0C,	nG2,	$06,	nRst,	nBb2
	dc.b		nRst,	nC3,	nRst,	$0C,	nEb3,	$06,	nRst,	$0C
	dc.b		nC3,	$06,	nRst,	$0C,	nBb2,	$06,	nRst,	$0C
	dc.b		nG3,	$06,	nRst,	nBb3,	nRst,	nC3,	nRst,	$0C
	dc.b		nEb3,	$06,	nRst,	$0C,	nC3,	$06,	nRst,	$0C
	dc.b		nFs3,	$06,	nRst,	$0C,	nF3,	$06,	nRst,	$24
	dc.b		nEb3,	$06,	nRst,	$0C,	nC3,	$06,	nRst,	$0C
	dc.b		nBb2,	$06,	nRst,	$0C,	nG2,	$06,	nRst,	nBb3
	dc.b		nRst,	nC4,	nRst,	$0C,	nEb3,	$06,	nRst,	$0C
	dc.b		nC3,	$06,	nRst,	$0C,	nBb2,	$06,	nRst,	$0C
	dc.b		nG2,	$06,	nRst,	nBb3,	nRst,	nC4,	nRst,	$0C
	dc.b		nEb4,	$06,	nRst,	$0C,	nC3,	$06,	nRst,	$0C
	dc.b		nBb3,	$06,	nRst,	$0C,	nG2,	$06,	nRst,	nBb3
	dc.b		nRst,	nC4,	nRst,	$0C,	nEb4,	$06,	nRst,	$0C
	dc.b		nC4,	$06,	nRst,	$0C,	nFs3,	$06,	nRst,	$0C
	dc.b		nF4,	$06,	nRst,	nEb3,	nRst,	$12
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nG5,	$06,	nRst,	$0C,	nA5,	$06,	nRst,	$0C
	dc.b		nBb5,	$06,	nRst,	nC5,	nA5,	nRst,	$0C,	nBb5
	dc.b		$06,	nBb4,	nRst,	$1E,	nA5,	$06,	nRst,	nC5
	dc.b		nF5,	nRst,	$0C,	nEb5,	$06,	nRst,	nC5,	nRst
	dc.b		nBb4,	nRst,	$0C,	nBb5,	$06,	nRst,	$0C,	nA5
	dc.b		$06,	nRst,	nC5,	nF5,	nRst,	nC5
;	Jump To	 	location
	smpsJump	Crack_Down_3_Jump03

; FM4 Data
Crack_Down_3_FM4:
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$1E
	dc.b		nRst,	$12
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nA4,	$06,	nRst,	$2A,	nC4,	$06,	nRst,	$18
	dc.b		nG4,	$06,	nRst,	$0C,	nFs4,	$06,	nRst,	$12
	dc.b		nC4,	$06,	nRst,	nEb4,	nRst,	nC4,	nRst,	$18
	dc.b		nG4,	$06,	nRst,	$0C,	nFs4,	$06,	nRst,	$0C
	dc.b		nF4,	$04
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
Crack_Down_3_Jump04:
	dc.b		nRst,	$0E
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nEb4,	$06,	nRst,	nC4,	nD4,	nRst,	$12,	nC4
	dc.b		$06,	nRst,	$24,	nC4,	$06,	nRst,	$30,	nC4
	dc.b		$06,	nRst,	$0C,	nA4,	$06,	nRst,	$0C,	nF4
	dc.b		$06,	nRst,	$18,	nC4,	$06,	nRst,	$18,	nG4
	dc.b		$06,	nRst,	$0C,	nFs4,	$06,	nRst,	$12,	nC4
	dc.b		$06,	nRst,	nEb4,	nRst,	nC4,	nRst,	$18,	nG4
	dc.b		$06,	nRst,	$0C,	nFs4,	$06,	nRst,	$0C,	nF4
	dc.b		$06,	nRst,	$0C,	nEb4,	$06,	nRst,	nC4,	nD4
	dc.b		nRst,	$12,	nC4,	$06,	nRst,	$24,	nC4,	$06
	dc.b		nRst,	$18
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nG4,	$06,	$06,	nRst,	$06,	nG4,	nG4,	nRst
	dc.b		nG4,	nG4,	nRst,	nG4,	nG4,	nRst,	nA4,	nRst
	dc.b		nBb4,	nRst,	nG4,	nG4,	nRst,	nG4,	nG4,	nRst
	dc.b		nG4,	nG4,	nRst,	nG4,	nG4,	nRst,	nF4,	nRst
	dc.b		nEb4,	nRst,	nG4,	nG4,	nRst,	nG4,	nG4,	nRst
	dc.b		nG4,	nG4,	nRst,	nG4,	nG4,	nRst,	nA4,	nRst
	dc.b		nBb4,	nRst,	nG4,	nG4,	nRst,	nG4,	nG4,	nRst
	dc.b		nG4,	nG4,	nRst,	nG4,	nG4,	nRst,	nF4,	nRst
	dc.b		nEb4,	nRst,	nG4,	nG4,	nRst,	nG4,	nG4,	nRst
	dc.b		nG4,	nG4,	nRst,	nG4,	nG4,	nRst,	nA4,	nRst
	dc.b		nBb4,	nRst,	nG4,	nG4,	nRst,	nG4,	nG4,	nRst
	dc.b		nG4,	nG4,	nRst,	nG4,	nG4,	nRst,	nF4,	nRst
	dc.b		nEb4,	nRst,	nG4,	nG4,	nRst,	nG4,	nG4,	nRst
	dc.b		nG4,	nG4,	nRst,	nG4,	nG4,	nRst,	nA4,	nRst
	dc.b		nBb4,	nRst,	nG4,	nG4,	nRst,	nG4,	nG4,	nRst
	dc.b		nG4,	nG4,	nRst,	nG4,	nG4,	nRst,	nF4,	nRst
	dc.b		nEb4,	nRst,	$1E,	$12
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nA4,	$06,	nRst,	$2A,	nC4,	$06,	nRst,	$18
	dc.b		nG4,	$06,	nRst,	$0C,	nFs4,	$06,	nRst,	$12
	dc.b		nC4,	$06,	nRst,	nEb4,	nRst,	nC4,	nRst,	$18
	dc.b		nG4,	$06,	nRst,	$0C,	nFs4,	$06,	nRst,	$0C
	dc.b		nF4,	$06,	nRst,	$0C,	nEb4,	$06,	nRst,	nC4
	dc.b		nD4,	nRst,	$12,	nC4,	$06,	nRst,	$24,	nC4
	dc.b		$06,	nRst,	$30,	nC4,	$06,	nRst,	$0C,	nA4
	dc.b		$06,	nRst,	$0C,	nF4,	$06,	nRst,	$18,	nC4
	dc.b		$06,	nRst,	$18,	nG4,	$06,	nRst,	$0C,	nFs4
	dc.b		$06,	nRst,	$12,	nC4,	$06,	nRst,	nEb4,	$0C
	dc.b		nC4,	$06,	nRst,	$18,	nG4,	$06,	nRst,	$0C
	dc.b		nFs4,	$06,	nRst,	$0C,	nF4,	$06,	nRst,	$0C
	dc.b		nEb4,	$06,	nRst,	nC4,	nD4,	nRst,	$12,	nC4
	dc.b		$06,	nRst,	$24,	nC4,	$06,	nRst,	$18
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nG4,	$06,	$06,	nRst,	$06,	nG4,	nG4,	nRst
	dc.b		nG4,	nG4,	nRst,	nG4,	nG4,	nRst,	nA4,	nRst
	dc.b		nBb4,	nRst,	nG4,	nG4,	nRst,	nG4,	nG4,	nRst
	dc.b		nG4,	nG4,	nRst,	nG4,	nG4,	nRst,	nF4,	nRst
	dc.b		nEb4,	nRst,	nG4,	nG4,	nRst,	nG4,	nG4,	nRst
	dc.b		nG4,	nG4,	nRst,	nG4,	nG4,	nRst,	nA4,	nRst
	dc.b		nBb4,	nRst,	nG4,	nG4,	nRst,	nG4,	nG4,	nRst
	dc.b		nG4,	nG4,	nRst,	nG4,	nG4,	nRst,	nF4,	nRst
	dc.b		nEb4,	nRst,	nG4,	nG4,	nRst,	nG4,	nG4,	nRst
	dc.b		nG4,	nG4,	nRst,	nG4,	nG4,	nRst,	nA4,	nRst
	dc.b		nBb4,	nRst,	nG4,	nG4,	nRst,	nG4,	nG4,	nRst
	dc.b		nG4,	nG4,	nRst,	nG4,	nG4,	nRst,	nF4,	nRst
	dc.b		nEb4,	nRst,	nG4,	nG4,	nRst,	nG4,	nG4,	nRst
	dc.b		nG4,	nG4,	nRst,	nG4,	nG4,	nRst,	nA4,	nRst
	dc.b		nBb4,	nRst,	nG4,	nG4,	nRst,	nG4,	nG4,	nRst
	dc.b		nG4,	nG4,	nRst,	nG4,	nG4,	nRst,	nF4,	nRst
	dc.b		nEb4,	nRst,	$1E,	$12
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nA4,	$06,	nRst,	$2A,	nC4,	$06,	nRst,	$18
	dc.b		nG4,	$06,	nRst,	$0C,	nFs4,	$06,	nRst,	$12
	dc.b		nC4,	$06,	nRst,	nEb4,	nRst,	nC4,	nRst,	$18
	dc.b		nG4,	$06,	nRst,	$0C,	nFs4,	$06,	nRst,	$0C
	dc.b		nF4,	$04
;	Jump To	 	location
	smpsJump	Crack_Down_3_Jump04

; FM5 Data
Crack_Down_3_FM5:
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$30
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nFs4,	$06,	nRst,	$1E,	nEb4,	$06,	nRst,	$0C
	dc.b		nD4,	$06,	nRst,	nBb4,	nRst,	nC4,	nRst,	$42
	dc.b		nD4,	$06,	nRst,	$12,	nC4,	$06,	nRst,	$5A
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
Crack_Down_3_Jump05:
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nEb4,	$06,	nRst,	$3C,	nG4,	$06,	nRst,	$2A
	dc.b		nFs4,	$06,	nRst,	$1E,	nEb4,	$06,	nRst,	$0C
	dc.b		nD4,	$06,	nRst,	nBb4,	nRst,	nC4,	nRst,	$42
	dc.b		nD4,	$06,	nRst,	$12,	nC4,	$06,	nRst,	$5A
	dc.b		nEb4,	$06,	nRst,	$3C,	nG4,	$06
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nBb4,	nBb4,	nRst,	nBb4,	nBb4,	nRst,	nBb4,	nBb4
	dc.b		nRst,	nBb4,	nBb4,	nRst,	nC5,	nRst,	nD5,	nRst
	dc.b		nBb4,	nBb4,	nRst,	nBb4,	nBb4,	nRst,	nBb4,	nBb4
	dc.b		nRst,	nBb4,	nBb4,	nRst,	nA4,	nRst,	nG4,	nRst
	dc.b		nBb4,	nBb4,	nRst,	nBb4,	nBb4,	nRst,	nBb4,	nBb4
	dc.b		nRst,	nBb4,	nBb4,	nRst,	nC5,	nRst,	nD5,	nRst
	dc.b		nBb4,	nBb4,	nRst,	nBb4,	nBb4,	nRst,	nBb4,	nBb4
	dc.b		nRst,	nBb4,	nBb4,	nRst,	nA4,	nRst,	nG4,	nRst
	dc.b		nBb4,	nBb4,	nRst,	nBb4,	nBb4,	nRst,	nBb4,	nBb4
	dc.b		nRst,	nBb4,	nBb4,	nRst,	nC5,	nRst,	nD5,	nRst
	dc.b		nBb4,	nBb4,	nRst,	nBb4,	nBb4,	nRst,	nBb4,	nBb4
	dc.b		nRst,	nBb4,	nBb4,	nRst,	nA4,	nRst,	nG4,	nRst
	dc.b		nBb4,	nBb4,	nRst,	nBb4,	nBb4,	nRst,	nBb4,	nBb4
	dc.b		nRst,	nBb4,	nBb4,	nRst,	nC5,	nRst,	nD5,	nRst
	dc.b		nBb4,	nBb4,	nRst,	nBb4,	nBb4,	nRst,	nBb4,	nBb4
	dc.b		nRst,	nBb4,	nBb4,	nRst,	nA4,	nRst,	nG4,	nRst
	dc.b		$30
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nFs4,	$06,	nRst,	$1E,	nEb4,	$06,	nRst,	$0C
	dc.b		nD4,	$06,	nRst,	nBb4,	nRst,	nC4,	nRst,	$42
	dc.b		nD4,	$06,	nRst,	$12,	nC4,	$06,	nRst,	$5A
	dc.b		nEb4,	$06,	nRst,	$3C,	nG4,	$06,	nRst,	$2A
	dc.b		nFs4,	$06,	nRst,	$1E,	nEb4,	$06,	nRst,	$0C
	dc.b		nD4,	$06,	nRst,	nBb4,	nRst,	nC4,	nRst,	$42
	dc.b		nD4,	$06,	nRst,	$12,	nC4,	$06,	nRst,	$5A
	dc.b		nEb4,	$06,	nRst,	$3C,	nG4,	$06
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nBb4,	nBb4,	nRst,	nBb4,	nBb4,	nRst,	nBb4,	nBb4
	dc.b		nRst,	nBb4,	nBb4,	nRst,	nC5,	nRst,	nD5,	nRst
	dc.b		nBb4,	nBb4,	nRst,	nBb4,	nBb4,	nRst,	nBb4,	nBb4
	dc.b		nRst,	nBb4,	nBb4,	nRst,	nA4,	nRst,	nG4,	nRst
	dc.b		nBb4,	nBb4,	nRst,	nBb4,	nBb4,	nRst,	nBb4,	nBb4
	dc.b		nRst,	nBb4,	nBb4,	nRst,	nC5,	nRst,	nD5,	nRst
	dc.b		nBb4,	nBb4,	nRst,	nBb4,	nBb4,	nRst,	nBb4,	nBb4
	dc.b		nRst,	nBb4,	nBb4,	nRst,	nA4,	nRst,	nG4,	nRst
	dc.b		nBb4,	nBb4,	nRst,	nBb4,	nBb4,	nRst,	nBb4,	nBb4
	dc.b		nRst,	nBb4,	nBb4,	nRst,	nC5,	nRst,	nD5,	nRst
	dc.b		nBb4,	nBb4,	nRst,	nBb4,	nBb4,	nRst,	nBb4,	nBb4
	dc.b		nRst,	nBb4,	nBb4,	nRst,	nA4,	nRst,	nG4,	nRst
	dc.b		nBb4,	nBb4,	nRst,	nBb4,	nBb4,	nRst,	nBb4,	nBb4
	dc.b		nRst,	nBb4,	nBb4,	nRst,	nC5,	nRst,	nD5,	nRst
	dc.b		nBb4,	nBb4,	nRst,	nBb4,	nBb4,	nRst,	nBb4,	nBb4
	dc.b		nRst,	nBb4,	nBb4,	nRst,	nA4,	nRst,	nG4,	nRst
	dc.b		$30
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nFs4,	$06,	nRst,	$1E,	nEb4,	$06,	nRst,	$0C
	dc.b		nD4,	$06,	nRst,	nBb4,	nRst,	nC4,	nRst,	$42
	dc.b		nD4,	$06,	nRst,	$12,	nC4,	$06,	nRst,	$5A
;	Jump To	 	location
	smpsJump	Crack_Down_3_Jump05

; PSG1 Data
Crack_Down_3_PSG1:
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$18
Crack_Down_3_Jump06:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nD4,	$7F,	smpsNoAttack,	$11,	nF4,	$30,	nD4,	$7F
	dc.b		smpsNoAttack,	$11,	nG3,	$30,	nD4,	$7F,	smpsNoAttack,	$11
	dc.b		nF4,	$30,	nD4,	$78,	nG3,	$48,	nRst,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$12
;	Jump To	 	location
	smpsJump	Crack_Down_3_Jump06

; PSG2 Data
Crack_Down_3_PSG2:
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$18
Crack_Down_3_Jump07:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nD5,	$7F,	smpsNoAttack,	$11,	nF5,	$30,	nD5,	$7F
	dc.b		smpsNoAttack,	$11,	nG4,	$18,	nF4,	$06,	nG4,	nF4
	dc.b		nBb4,	nD5,	$7F,	smpsNoAttack,	$11,	nF5,	$30,	nD5
	dc.b		$7F,	smpsNoAttack,	$11,	nG4,	$30,	nRst,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$12
;	Jump To	 	location
	smpsJump	Crack_Down_3_Jump07

; PSG3 Data
Crack_Down_3_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
	dc.b		nRst,	$7F,	$4D
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$18,	$18,	$0C,	nRst,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12,	$0C,	nRst,	$0C,	nAb6,	nRst,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12,	$0C,	nRst,	$0C,	nAb6,	nRst,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12,	$0C,	nRst,	$0C,	nAb6,	nRst,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12,	$0C,	nRst,	$0C,	nAb6,	nRst,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12,	$0C,	nRst,	$0C,	nAb6,	nRst,	nAb6,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$0C,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$0C,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$0C,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$12
;	Set PSG WvForm	#
	smpsPSGform	$E7
Crack_Down_3_Jump08:
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$0C,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$0C,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$0C,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$0C,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$0C,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$18,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$0C,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$0C,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$0C,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$0C,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$0C,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$0C,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$0C,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$0C,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$18,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06,	$0C,	$0C,	$0C,	$0C,	$03,	nRst,	$09
	dc.b		nAb6,	$0C,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C,	$0C
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$0C,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$0C,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$12
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$06
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$0C,	$06
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$12
;	Jump To	 	location
	smpsJump	Crack_Down_3_Jump08

; DAC Data
Crack_Down_3_DAC:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
		dc.b		dKick2,	$03,	nRst,	$15,	$97,	$03,	nRst,	$15
	dc.b		dKick2,	$03,	nRst,	$15,	$97,	$03,	nRst,	$15
	dc.b		dKick2,	$03,	nRst,	$15,	$97,	$03,	nRst,	$15
	dc.b		dKick2,	$03,	nRst,	$15,	$97,	$03,	nRst,	$0F
	dc.b		dKick2,	$03,	nRst,	dKick2,	nRst,	$15,	$97,	$03
	dc.b		nRst,	$15,	dKick2,	$03,	nRst,	$15,	$97,	$03
	dc.b		nRst,	$0F,	dKick2,	$03,	nRst,	dKick2,	nRst,	$15
	dc.b		$97,	$03,	nRst,	$15,	dKick2,	$03,	nRst,	$97
	dc.b		nRst,	$97,	nRst,	$97,	nRst,	$97,	nRst,	$09
	dc.b		$97,	$03,	nRst,	dKick2,	nRst,	dVLowTimpani,	nRst,	$15
	dc.b		$97,	$03,	nRst,	$15,	dKick2,	$03,	nRst,	$15
	dc.b		$97,	$03,	nRst,	$0F,	dKick2,	$03,	nRst,	dKick2
	dc.b		nRst,	$15,	$97,	$03,	nRst,	$15,	dKick2,	$03
	dc.b		nRst,	$15,	$97,	$03,	nRst,	$0F,	dKick2,	$03
	dc.b		nRst,	dKick2,	nRst,	$15,	$97,	$03,	nRst,	$15
	dc.b		dKick2,	$03,	nRst,	$15,	$97,	$03,	nRst,	$0F
	dc.b		dKick2,	$03,	nRst,	dKick2,	nRst,	$15,	$97,	$03
	dc.b		nRst,	$15,	dKick2,	$03,	nRst,	$15,	$97,	$03
	dc.b		nRst,	$09,	$97,	$03,	nRst,	$97,	nRst,	dKick2
	dc.b		nRst,	$15,	$97,	$03,	nRst,	$15,	dKick2,	$03
	dc.b		nRst,	$15,	$97,	$03,	nRst,	$0F,	dKick2,	$03
	dc.b		nRst,	dKick2,	nRst,	$15,	$97,	$03,	nRst,	$15
	dc.b		dKick2,	$03,	nRst,	$15,	$97,	$03,	nRst,	$0F
	dc.b		dKick2,	$03,	nRst,	dKick2,	nRst,	$15,	$97,	$03
	dc.b		nRst,	$15,	dKick2,	$03,	nRst,	$15
Crack_Down_3_Jump09:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$97,	$03,	nRst,	$0F,	dKick2,	$03,	nRst,	dKick2
	dc.b		nRst,	$15,	$97,	$03,	nRst,	$15,	dKick2,	$03
	dc.b		nRst,	$15,	$97,	$03,	nRst,	$0F,	dKick2,	$03
	dc.b		nRst,	dKick2,	nRst,	$15,	$97,	$03,	nRst,	$15
	dc.b		dKick2,	$03,	nRst,	$15,	$97,	$03,	nRst,	$0F
	dc.b		dKick2,	$03,	nRst,	dKick2,	nRst,	$15,	$97,	$03
	dc.b		nRst,	$15,	dKick2,	$03,	nRst,	$15,	$97,	$03
	dc.b		nRst,	$0F,	dKick2,	$03,	nRst,	dKick2,	nRst,	$15
	dc.b		$97,	$03,	nRst,	$15,	dKick2,	$03,	nRst,	$15
	dc.b		$97,	$03,	nRst,	$0F,	dKick2,	$03,	nRst,	dKick2
	dc.b		nRst,	$15,	$97,	$03,	nRst,	$09,	$97,	$03
	dc.b		nRst,	dKick2,	nRst,	$09,	$97,	$03,	nRst,	$09
	dc.b		dKick2,	$03,	nRst,	$97,	nRst,	$09,	$97,	$03
	dc.b		nRst,	$97,	nRst,	dVLowTimpani,	nRst,	$15,	$97,	$03
	dc.b		nRst,	$15,	dKick2,	$03,	nRst,	$15,	$97,	$03
	dc.b		nRst,	$0F,	dKick2,	$03,	nRst,	dKick2,	nRst,	$15
	dc.b		$97,	$03,	nRst,	$15,	dKick2,	$03,	nRst,	$15
	dc.b		$97,	$03,	nRst,	$0F,	dKick2,	$03,	nRst,	dKick2
	dc.b		nRst,	$15,	$97,	$03,	nRst,	$15,	dKick2,	$03
	dc.b		nRst,	$15,	$97,	$03,	nRst,	$0F,	dKick2,	$03
	dc.b		nRst,	dKick2,	nRst,	$15,	$97,	$03,	nRst,	$15
	dc.b		dKick2,	$03,	nRst,	$15,	$97,	$03,	nRst,	$0F
	dc.b		dKick2,	$03,	nRst,	dKick2,	nRst,	$15,	$97,	$03
	dc.b		nRst,	$15,	dKick2,	$03,	nRst,	$15,	$97,	$03
	dc.b		nRst,	$0F,	dKick2,	$03,	nRst,	dKick2,	nRst,	$15
	dc.b		$97,	$03,	nRst,	$15,	dKick2,	$03,	nRst,	$15
	dc.b		$97,	$03,	nRst,	$0F,	dKick2,	$03,	nRst,	dKick2
	dc.b		nRst,	$15,	$97,	$03,	nRst,	$15,	dKick2,	$03
	dc.b		nRst,	$15,	$97,	$03,	nRst,	$0F,	dKick2,	$03
	dc.b		nRst,	dKick2,	nRst,	$15,	$97,	$03,	nRst,	$15
	dc.b		dKick2,	$03,	nRst,	$15,	$97,	$03,	nRst,	$09
	dc.b		$97,	$03,	nRst,	$97,	nRst,	dKick2,	nRst,	$15
	dc.b		$97,	$03,	nRst,	$15,	dKick2,	$03,	nRst,	$15
	dc.b		$97,	$03,	nRst,	$0F,	dKick2,	$03,	nRst,	dKick2
	dc.b		nRst,	$15,	$97,	$03,	nRst,	$15,	dKick2,	$03
	dc.b		nRst,	$15,	$97,	$03,	nRst,	$0F,	dKick2,	$03
	dc.b		nRst,	dKick2,	nRst,	$15,	$97,	$03,	nRst,	$15
	dc.b		dKick2,	$03,	nRst,	$15,	$97,	$03,	nRst,	$0F
	dc.b		dKick2,	$03,	nRst,	dKick2,	nRst,	$15,	$97,	$03
	dc.b		nRst,	$15,	dKick2,	$03,	nRst,	$15,	$97,	$03
	dc.b		nRst,	$0F,	dKick2,	$03,	nRst,	dKick2,	nRst,	$15
	dc.b		$97,	$03,	nRst,	$15,	dKick2,	$03,	nRst,	$15
	dc.b		$97,	$03,	nRst,	$0F,	dKick2,	$03,	nRst,	dKick2
	dc.b		nRst,	$15,	$97,	$03,	nRst,	$15,	dKick2,	$03
	dc.b		nRst,	$15,	$97,	$03,	nRst,	$0F,	dKick2,	$03
	dc.b		nRst,	dKick2,	nRst,	$15,	$97,	$03,	nRst,	$15
	dc.b		dKick2,	$03,	nRst,	$15,	$97,	$03,	nRst,	$0F
	dc.b		dKick2,	$03,	nRst,	dKick2,	nRst,	$15,	$97,	$03
	dc.b		nRst,	$09,	$97,	$03,	nRst,	dKick2,	nRst,	$09
	dc.b		$97,	$03,	nRst,	$09,	dKick2,	$03,	nRst,	$97
	dc.b		nRst,	$09,	$97,	$03,	nRst,	$97,	nRst,	dVLowTimpani
	dc.b		nRst,	$15,	$97,	$03,	nRst,	$15,	dKick2,	$03
	dc.b		nRst,	$15,	$97,	$03,	nRst,	$0F,	dKick2,	$03
	dc.b		nRst,	dKick2,	nRst,	$15,	$97,	$03,	nRst,	$15
	dc.b		dKick2,	$03,	nRst,	$15,	$97,	$03,	nRst,	$0F
	dc.b		dKick2,	$03,	nRst,	dKick2,	nRst,	$15,	$97,	$03
	dc.b		nRst,	$15,	dKick2,	$03,	nRst,	$15,	$97,	$03
	dc.b		nRst,	$0F,	dKick2,	$03,	nRst,	dKick2,	nRst,	$15
	dc.b		$97,	$03,	nRst,	$15,	dKick2,	$03,	nRst,	$15
	dc.b		$97,	$03,	nRst,	$0F,	dKick2,	$03,	nRst,	dKick2
	dc.b		nRst,	$15,	$97,	$03,	nRst,	$15,	dKick2,	$03
	dc.b		nRst,	$15,	$97,	$03,	nRst,	$0F,	dKick2,	$03
	dc.b		nRst,	dKick2,	nRst,	$15,	$97,	$03,	nRst,	$15
	dc.b		dKick2,	$03,	nRst,	$15,	$97,	$03,	nRst,	$0F
	dc.b		dKick2,	$03,	nRst,	dKick2,	nRst,	$15,	$97,	$03
	dc.b		nRst,	$15,	dKick2,	$03,	nRst,	$15,	$97,	$03
	dc.b		nRst,	$0F,	dKick2,	$03,	nRst,	dKick2,	nRst,	$15
	dc.b		$97,	$03,	nRst,	$15,	dKick2,	$03,	nRst,	$15
	dc.b		$97,	$03,	nRst,	$09,	$97,	$03,	nRst,	$97
	dc.b		nRst,	dKick2,	nRst,	$15,	$97,	$03,	nRst,	$15
	dc.b		dKick2,	$03,	nRst,	$15,	$97,	$03,	nRst,	$0F
	dc.b		dKick2,	$03,	nRst,	dKick2,	nRst,	$15,	$97,	$03
	dc.b		nRst,	$15,	dKick2,	$03,	nRst,	$15,	$97,	$03
	dc.b		nRst,	$0F,	dKick2,	$03,	nRst,	dKick2,	nRst,	$15
	dc.b		$97,	$03,	nRst,	$15,	dKick2,	$03,	nRst,	$15
;	Jump To	 	location
	smpsJump	Crack_Down_3_Jump09

Crack_Down_3_Voices:
;	Voice 00
;	$31,$02,$20,$30,$40,$1F,$1F,$1F,$15,$00,$00,$00,$0B,$03,$04,$0C,$04,$0E,$1F,$1F,$3F,$09,$13,$1D,$90
;				#
	smpsVcAlgorithm		$01
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$04,	$03,	$02,	$00
	smpsVcCoarseFreq	$00,	$00,	$00,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$15,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0B,	$00,	$00,	$00
	smpsVcDecayRate2	$04,	$0C,	$04,	$03
	smpsVcDecayLevel	$03,	$01,	$01,	$00
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0E
	smpsVcTotalLevel	$90,	$1D,	$13,	$09

;	Voice 01
;	$3C,$01,$01,$01,$01,$1F,$1F,$1F,$1F,$0F,$0C,$08,$0B,$06,$0B,$0A,$0B,$FF,$FF,$FF,$FF,$1D,$80,$1F,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0B,	$08,	$0C,	$0F
	smpsVcDecayRate2	$0B,	$0A,	$0B,	$06
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$1F,	$80,	$1D

;	Voice 02
;	$2C,$3F,$01,$01,$01,$9F,$9F,$5F,$58,$16,$10,$09,$06,$06,$01,$01,$01,$2F,$5F,$2F,$3F,$1F,$0D,$29,$08
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$03
	smpsVcCoarseFreq	$01,	$01,	$01,	$0F
	smpsVcRateScale		$01,	$01,	$02,	$02
	smpsVcAttackRate	$18,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$06,	$09,	$10,	$16
	smpsVcDecayRate2	$01,	$01,	$01,	$06
	smpsVcDecayLevel	$03,	$02,	$05,	$02
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$08,	$29,	$0D,	$1F

;	Voice 03
;	$3A,$01,$07,$01,$01,$8E,$8E,$8D,$53,$0E,$0E,$0E,$03,$00,$00,$00,$00,$1F,$FF,$1F,$0F,$18,$28,$27,$00
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$07,	$01
	smpsVcRateScale		$01,	$02,	$02,	$02
	smpsVcAttackRate	$13,	$0D,	$0E,	$0E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$03,	$0E,	$0E,	$0E
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$01,	$0F,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$00,	$27,	$28,	$18
	even
