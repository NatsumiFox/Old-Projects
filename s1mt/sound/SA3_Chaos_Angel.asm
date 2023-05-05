; =============================================================================================
; Project Name:		SA3_Chaos_Angle
; Created:		17th January 2014
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

SA3_Chaos_Angle_Header:
;	Voice Pointer	location
	smpsHeaderVoice	SA3_Chaos_Angle_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$01,	$0C

;	DAC Pointer	location
	smpsHeaderDAC	SA3_Chaos_Angle_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	SA3_Chaos_Angle_FM1,	smpsPitch00,	$0A
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	SA3_Chaos_Angle_FM2,	smpsPitch00,	$10
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	SA3_Chaos_Angle_FM3,	smpsPitch01lo,	$0F
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	SA3_Chaos_Angle_FM4,	smpsPitch00,	$14
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	SA3_Chaos_Angle_FM5,	smpsPitch00,	$0F
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	SA3_Chaos_Angle_PSG1,	smpsPitch02lo,	$0C,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	SA3_Chaos_Angle_PSG2,	smpsPitch03lo,	$02,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	SA3_Chaos_Angle_PSG3,	smpsPitch02hi+$0B,	$01,	$00

; FM1 Data
SA3_Chaos_Angle_FM1:
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$7F,	$05
SA3_Chaos_Angle_Jump01:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nD4,	$0D,	nRst,	$02,	nG4,	$0F,	nFs4,	$04
	dc.b		nRst,	$01,	nG4,	$04,	nRst,	$01,	nD4,	$0F
	dc.b		nRst,	$05,	nG4,	$12,	nRst,	$02,	nD4,	$0D
	dc.b		nRst,	$02,	nG4,	$0F,	nFs4,	$04,	nRst,	$01
	dc.b		nG4,	$04,	nRst,	$01,	nA4,	$0F,	nRst,	$05
	dc.b		nC5,	$12,	nRst,	$02,	nD4,	$0D,	nRst,	$02
	dc.b		nG4,	$0F,	nBb4,	$04,	nRst,	$01,	nC5,	$04
	dc.b		nRst,	$01,	nD5,	$0F,	nRst,	$05,	nF4,	$12
	dc.b		nRst,	$02,	nG4,	$0F,	nRst,	$05,	nD5,	$0A
	dc.b		nC5,	nRst,	nBb4,	$14,	nA4,	$0A,	nF4,	$14
	dc.b		nEb5,	$0A,	nD5,	$14,	nF5,	nD5,	nRst,	$0A
	dc.b		nC5,	nBb4,	$14,	nD5,	nRst,	$0A,	nA4,	$14
	dc.b		nBb4,	$0A,	nA4,	$14,	nG4,	$0A,	nEb4,	nD4
	dc.b		nRst,	$50,	nD4,	$0D,	nRst,	$02,	nG4,	$0F
	dc.b		nFs4,	$04,	nRst,	$01,	nG4,	$04,	nRst,	$01
	dc.b		nD4,	$0F,	nRst,	$05,	nG4,	$12,	nRst,	$02
	dc.b		nD4,	$0D,	nRst,	$02,	nG4,	$0F,	nFs4,	$04
	dc.b		nRst,	$01,	nG4,	$04,	nRst,	$01,	nA4,	$0F
	dc.b		nRst,	$05,	nC5,	$12,	nRst,	$02,	nD4,	$0D
	dc.b		nRst,	$02,	nG4,	$0F,	nBb4,	$04,	nRst,	$01
	dc.b		nC5,	$04,	nRst,	$01,	nD5,	$0F,	nRst,	$05
	dc.b		nF4,	$12,	nRst,	$02,	nG4,	$0F,	nRst,	$05
	dc.b		nD5,	$0A,	nC5,	nRst,	nBb4,	$14,	nA4,	$0A
	dc.b		nF4,	$14,	nEb5,	$0A,	nD5,	$14,	nF5,	nD5
	dc.b		nRst,	$0A,	nC5,	nBb4,	$14,	nD5,	nRst,	$0A
	dc.b		nFs4,	nBb4,	nEb5,	nD5,	$14,	nFs5,	nD5,	$0A
	dc.b		nG5,	$1C,	nRst,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$2B
;	Jump To	 	location
	smpsJump	SA3_Chaos_Angle_Jump01

; FM2 Data
SA3_Chaos_Angle_FM2:
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nG2,	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nBb2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nG2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nD3,	nG2,	nBb2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG2,	nD3
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nBb2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nD3,	nFs2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nBb2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nFs2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD3,	nF2,	nBb2,	nF2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nD3,	nF2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb2,	nF2,	nD3
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nE2,	nG2,	nBb2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC3
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nBb2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD3
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nG2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nBb2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nG2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD3,	nG2,	nBb2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD3
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nFs2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nBb2,	nFs2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD3
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nFs2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nBb2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs2,	nD3
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nF2,	nBb2,	nF2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD3
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nF2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nF2,	nD3
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE2,	nG2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nBb2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC3
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE2,	nD3
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD3
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG2,	nBb2,	nG2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD3,	nFs2,	nBb2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs2,	nD3
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nFs2,	nBb2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nFs2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD3,	nF2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nBb2,	nF2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nD3,	nF2,	nBb2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nF2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD3
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG2,	nBb2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nC3,	nBb2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD3,	nF2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC3
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nF3
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG3
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nF3,	nC3
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nF2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nA2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nBb2,	nF3,	nBb3,	nA3,	nF3,	nD3,	nBb2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nF2,	nEb2,	nBb2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb3
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nF3
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nEb3
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nEb2,	nBb2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nA2,	nC3
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD3,	nC3
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nA2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nFs2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nG2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nBb2,	nG2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nD3,	nG2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nD3
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nFs2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nBb2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nFs2,	nD3
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nFs2,	nBb2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs2,	nD3
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nBb2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nF3
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nBb3
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nA3
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nF3
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD3,	nBb2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nF2,	nE2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nG2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nBb2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nC3
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nBb2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nG2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nE2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD3
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nF2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nC3
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nF3,	nG3
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nF3
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nC3
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nF2,	nA2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD3
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nF2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nBb2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nF2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD3
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nA2,	nC3,	nD3,	nC3,	nA2,	nD2,	nFs2,	nRst
	dc.b		nG2
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG1
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG2,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nF2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nF1
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nF2,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nEb2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nEb1
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb2,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nD2
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD1
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD2,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG1
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG2,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nF2,	nF1,	nF2,	nRst,	nEb2,	nEb1
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nEb2,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD2
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD1,	nD2
;	Jump To	 	location
	smpsJump	SA3_Chaos_Angle_FM2

; FM3 Data
SA3_Chaos_Angle_FM3:
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nG4,	$05,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nG5,	$0A,	nRst,	$05
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD5,	$0A
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nBb4,	$05,	nA4,	nG4
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nA4,	nBb4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG5
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs4,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nFs5,	$0A,	nRst,	$05,	nFs4
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD5,	$0A
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nBb4,	$05
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nA4,	nFs4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nA4,	nBb4,	nC5,	nD5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nFs5
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nF4,	nRst,	nF5,	$0A,	nRst,	$05
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nF4,	nD5,	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nBb4,	$05
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nA4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nF4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nA4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nBb4,	nC5,	nD5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nF5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nBb5,	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nA5,	$05,	nG5,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nBb5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE5,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nD5,	$04,	nE5,	$03
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nC5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE5,	$03,	nC6,	nBb4,	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE5,	$03,	nBb5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nE5,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nC6
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nD5,	$05,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD6,	$0A,	nRst,	$05,	nD5,	nC6,	$0A
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nD6,	$05
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC6
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nBb5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC6
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nA5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nBb5
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD6
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD5,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nD6,	$0A,	nRst,	$05
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD5,	nC6,	$0A
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nD6,	$05,	nC6,	nBb5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	nA5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nBb5
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD6
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nD5,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nD6,	$0A,	nRst,	$05,	nD5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC6,	$0A,	nD6,	$05
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nC6
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nBb5
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nC6
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG5
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nA5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nBb5,	nD6,	$0F,	nC6,	$05,	nBb5,	nRst,	nD6
	dc.b		nBb5,	nRst,	nG5,	$04,	nBb5,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nG6
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nF5,	$04,	nBb5,	$03
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nF6
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nE5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nBb5,	$03,	nE6
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nG5,	$04,	nBb5,	$03
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG6,	nRst,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7B
;	Jump To	 	location
	smpsJump	SA3_Chaos_Angle_FM3

; FM4 Data
SA3_Chaos_Angle_FM4:
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$75
SA3_Chaos_Angle_Jump02:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$07
	dc.b		nE2,	$05,	nRst,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7B
;	Jump To	 	location
	smpsJump	SA3_Chaos_Angle_Jump02

; FM5 Data
SA3_Chaos_Angle_FM5:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nG3,	$0A,	nG2,	nG3,	$14,	nG2,	$0A,	nG3
	dc.b		nG2,	nFs3,	$14,	nFs2,	$0A,	nFs3,	nRst,	nD3
	dc.b		nFs2,	nE3,	nFs2,	nF3,	nF2,	nF3,	$14,	nF2
	dc.b		$0A,	nG3,	nF2,	nE3,	$14,	nE2,	$0A,	nE3
	dc.b		nE2,	$05,	nRst,	nE2,	$0A,	nE3,	nF3,	nE3
	dc.b		nG3,	nG2,	nG3,	$14,	nG2,	$0A,	nG3,	nG2
	dc.b		nFs3,	$14,	nFs2,	$0A,	nFs3,	nRst,	nD3,	nFs2
	dc.b		nE3,	nFs2,	nF3,	nF2,	nF3,	$14,	nF2,	$0A
	dc.b		nG3,	nF2,	nE3,	$14,	nE2,	$0A,	nE3,	nE2
	dc.b		$05,	nRst,	nG3,	$14,	nC4,	nBb3,	$0A,	nG3
	dc.b		nRst,	$6E,	nG3,	$08,	nRst,	$02,	nBb3,	$14
	dc.b		$0A,	nG3,	$0A,	nRst,	$7F,	$7F,	$7F,	$4F
	dc.b		nBb3,	$0A,	nG3,	nRst,	$6E,	nG3,	$08,	nRst
	dc.b		$02,	nBb3,	$14,	$0A,	nG3,	$0A,	nRst,	$7F
	dc.b		$7F,	$7E,	nG2,	$14,	nG3,	nF2,	nG3,	nEb2
	dc.b		nG3,	nD2,	nG3,	nC2,	nG3,	nBb1,	nG3,	nA1
	dc.b		nG3,	nFs1,	nG3
;	Jump To	 	location
	smpsJump	SA3_Chaos_Angle_FM5

; PSG1 Data
SA3_Chaos_Angle_PSG1:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nG3,	$0A,	nBb3,	nG3,	nD4,	nG3,	nBb3,	nG3
	dc.b		nD4,	nFs3,	nBb3,	nFs3,	nD4,	nFs3,	nBb3,	nFs3
	dc.b		nD4,	nF3,	nBb3,	nF3,	nD4,	nF3,	nBb3,	nF3
	dc.b		nD4,	nE3,	nG3,	nBb3,	nC4,	nBb3,	nG3,	nE3
	dc.b		nD4,	nG3,	nBb3,	nG3,	nD4,	nG3,	nBb3,	nG3
	dc.b		nD4,	nFs3,	nBb3,	nFs3,	nD4,	nFs3,	nBb3,	nFs3
	dc.b		nD4,	nF3,	nBb3,	nF3,	nD4,	nF3,	nBb3,	nF3
	dc.b		nD4,	nE3,	nG3,	nBb3,	nC4,	nBb3,	nG3,	nE3
	dc.b		nD4,	nG3,	nBb3,	nG3,	nD4,	nG3,	nBb3,	nG3
	dc.b		nD4,	nFs3,	nBb3,	nFs3,	nD4,	nFs3,	nBb3,	nFs3
	dc.b		nD4,	nF3,	nBb3,	nF3,	nD4,	nF3,	nBb3,	nF3
	dc.b		nD4,	nE3,	nG3,	nBb3,	nC4,	nBb3,	nG3,	nE3
	dc.b		nD4,	nF3,	nC4,	nF4,	nG4,	nF4,	nC4,	nF3
	dc.b		nA3,	nBb3,	nF4,	nBb4,	nA4,	nF4,	nD4,	nBb3
	dc.b		nF3,	nEb3,	nBb3,	nEb4,	nF4,	nEb4,	nBb3,	nEb3
	dc.b		nBb3,	nD3,	nA3,	nC4,	nD4,	nC4,	nA3,	nD3
	dc.b		nFs3,	nG3,	nBb3,	nG3,	nD4,	nG3,	nBb3,	nG3
	dc.b		nD4,	nFs3,	nBb3,	nFs3,	nD4,	nFs3,	nBb3,	nFs3
	dc.b		nD4,	nBb3,	nF4,	nBb4,	nA4,	nF4,	nD4,	nBb3
	dc.b		nF3,	nE3,	nG3,	nBb3,	nC4,	nBb3,	nG3,	nE3
	dc.b		nD4,	nF3,	nC4,	nF4,	nG4,	nF4,	nC4,	nF3
	dc.b		nA3,	nG3,	nBb3,	nG3,	nD4,	nF3,	nBb3,	nF3
	dc.b		nD4,	nD3,	nA3,	nC4,	nD4,	nC4,	nA3,	nD3
	dc.b		nFs3,	nRst,	nG3,	nG2,	nG3,	nRst,	nF3,	nF2
	dc.b		nF3,	nRst,	nEb3,	nEb2,	nEb3,	nRst,	nD3,	nD2
	dc.b		nD3,	nRst,	nG3,	nG2,	nG3,	nRst,	nF3,	nF2
	dc.b		nF3,	nRst,	nEb3,	nEb2,	nEb3,	nRst,	nD3,	nD2
	dc.b		nD3
;	Jump To	 	location
	smpsJump	SA3_Chaos_Angle_PSG1

; PSG2 Data
SA3_Chaos_Angle_PSG2:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nG4,	$05,	nRst,	nG5,	$0A,	nRst,	$05,	nG4
	dc.b		nD5,	$0A,	nBb4,	$05,	nA4,	nG4,	nA4,	nBb4
	dc.b		nC5,	nD5,	nG5,	nFs4,	nRst,	nFs5,	$0A,	nRst
	dc.b		$05,	nFs4,	nD5,	$0A,	nBb4,	$05,	nA4,	nFs4
	dc.b		nA4,	nBb4,	nC5,	nD5,	nFs5,	nF4,	nRst,	nF5
	dc.b		$0A,	nRst,	$05,	nF4,	nD5,	$0A,	nBb4,	$05
	dc.b		nA4,	nF4,	nA4,	nBb4,	nC5,	nD5,	nF5,	nBb5
	dc.b		$0A,	nA5,	$05,	nG5,	nRst,	nBb5,	nE5,	nRst
	dc.b		nD5,	$04,	nE5,	$03,	nD6,	nC5,	$04,	nE5
	dc.b		$03,	nC6,	nBb4,	$04,	nE5,	$03,	nBb5,	nC5
	dc.b		$04,	nE5,	$03,	nC6,	nD5,	$05,	nRst,	nD6
	dc.b		$0A,	nRst,	$05,	nD5,	nC6,	$0A,	nD6,	$05
	dc.b		nC6,	nBb5,	nC6,	nG5,	nA5,	nBb5,	nD6,	nD5
	dc.b		nRst,	nD6,	$0A,	nRst,	$05,	nD5,	nC6,	$0A
	dc.b		nD6,	$05,	nC6,	nBb5,	nC6,	nFs5,	nA5,	nBb5
	dc.b		nD6,	nD5,	nRst,	nD6,	$0A,	nRst,	$05,	nD5
	dc.b		nC6,	$0A,	nD6,	$05,	nC6,	nBb5,	nC6,	nG5
	dc.b		nA5,	nBb5,	nD6,	$0F,	nC6,	$05,	nBb5,	nRst
	dc.b		nD6,	nBb5,	nRst,	nG5,	$04,	nBb5,	$03,	nG6
	dc.b		nF5,	$04,	nBb5,	$03,	nF6,	nE5,	$04,	nBb5
	dc.b		$03,	nE6,	nG5,	$04,	nBb5,	$03,	nG6,	nRst
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7B
;	Jump To	 	location
	smpsJump	SA3_Chaos_Angle_PSG2

; PSG3 Data
SA3_Chaos_Angle_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
SA3_Chaos_Angle_Jump03:
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$05,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$05,	$05,	$0A,	$05,	$05,	$05,	$05,	$05
	dc.b		$05,	$0A,	$05,	$05,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$05,	$05,	$05,	$05,	$0A
	dc.b		$05,	$05,	$05,	$05,	$05,	$05,	$0A,	$05
	dc.b		$05,	$05,	$05,	$05,	$05,	$0A,	$05,	$05
	dc.b		$03,	$02,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$05,	$05,	$0A,	$05,	$05,	$05,	$05,	$05
	dc.b		$05,	$0A,	$05,	$05,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$05,	$05,	$05,	$05,	$0A
	dc.b		$05,	$05,	$05,	$05,	$05,	$05,	$0A,	$05
	dc.b		$05,	$05,	$05,	$05,	$05,	$0A,	$05,	$05
	dc.b		$03,	$02,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$05,	$05,	$0A,	$05,	$05,	$05,	$05,	$05
	dc.b		$05,	$0A,	$05,	$05,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$05,	$05,	$05,	$05,	$0A
	dc.b		$05,	$05,	$05,	$05,	$05,	$05,	$0A,	$05
	dc.b		$05,	$05,	$05,	$05,	$05,	$0A,	$05,	$05
	dc.b		$03,	$02,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$05,	$05,	$0A,	$05,	$05,	$05,	$05,	$05
	dc.b		$05,	$0A,	$05,	$05,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$05,	$05,	$05,	$05,	$0A
	dc.b		$05,	$05,	$05,	$05,	$05,	$05,	$0A,	$05
	dc.b		$05,	$05,	$05,	$05,	$05,	$0A,	$05,	$05
	dc.b		$03,	$02,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$05,	$05,	$0A,	$05,	$05,	$05,	$05,	$05
	dc.b		$05,	$0A,	$05,	$05,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$05,	$05,	$05,	$05,	$0A
	dc.b		$05,	$05,	$05,	$05,	$05,	$05,	$0A,	$05
	dc.b		$05,	$05,	$05,	$05,	$05,	$0A,	$05,	$05
	dc.b		$03,	$02,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$05,	$05,	$0A,	$05,	$05,	$05,	$05,	$05
	dc.b		$05,	$0A,	$05,	$05,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$05,	$05,	$05,	$05,	$0A
	dc.b		$05,	$05,	$05,	$05,	$05,	$05,	$0A,	$05
	dc.b		$05,	$05,	$05,	$05,	$05,	$05,	$05,	$05
	dc.b		$05,	$04,	$03,	$03,	$05,	$05,	$05,	$05
	dc.b		$05,	$05,	$04,	$03,	$03,	$05,	$05,	$05
	dc.b		$05,	$05,	$05,	$04,	$03,	$03,	$05,	$05
	dc.b		$05,	$05,	$05,	$05,	$04,	$03,	$03,	$05
	dc.b		$05,	$05,	$05,	$05,	$05,	$04,	$03,	$03
	dc.b		$05,	$05,	$05,	$05,	$05,	$05,	$04,	$03
	dc.b		$03,	$05,	$05,	$05,	$05,	$05,	$05,	$04
	dc.b		$03,	$03,	$05,	$05,	$05,	$05,	$05,	$05
	dc.b		$04,	$03,	$03
;	Jump To	 	location
	smpsJump	SA3_Chaos_Angle_Jump03

; DAC Data
SA3_Chaos_Angle_DAC:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dKick,	$0A,	nRst,	dSnare,	nRst,	$14,	dKick,	$0A
	dc.b		dSnare,	dKick,	nRst,	dKick,	dSnare,	nRst,	dKick,	dKick
	dc.b		dSnare,	dKick,	dKick,	nRst,	dSnare,	dKick,	nRst,	dKick
	dc.b		dSnare,	dKick,	nRst,	dKick,	dSnare,	nRst,	dSnare,	dKick
	dc.b		dKick,	dSnare,	dKick,	nRst,	dSnare,	nRst,	dKick,	dKick
	dc.b		dSnare,	dKick,	nRst,	dKick,	dSnare,	dKick,	dSnare,	nRst
	dc.b		dKick,	dSnare,	dKick,	nRst,	dSnare,	nRst,	dKick,	dKick
	dc.b		dSnare,	dKick,	dSnare,	dKick,	dKick,	dSnare,	nRst,	dSnare
	dc.b		dKick,	dSnare,	$05,	$05,	$8A,	$09,	nRst,	$01
	dc.b		$8A,	$0A,	nRst,	$14,	$8A,	$09,	nRst,	$01
	dc.b		$8A,	$0A,	nRst,	$14,	$8A,	$09,	nRst,	$01
	dc.b		$8A,	$0A,	nRst,	$14,	$CF,	$09,	nRst,	$01
	dc.b		$8B,	$0A,	nRst,	$14,	$8A,	$09,	nRst,	$01
	dc.b		$8A,	$0A,	nRst,	$14,	$8A,	$09,	nRst,	$01
	dc.b		$8A,	$0A,	nRst,	$14,	$8A,	$09,	nRst,	$01
	dc.b		$8A,	$0A,	nRst,	$14,	$CF,	$09,	nRst,	$01
	dc.b		$8B,	$0A,	nRst,	$14,	dKick,	$0A,	nRst,	dSnare
	dc.b		nRst,	dKick,	dKick,	dSnare,	dKick,	nRst,	dKick,	dSnare
	dc.b		dKick,	dSnare,	nRst,	dKick,	dSnare,	dKick,	nRst,	dSnare
	dc.b		nRst,	dKick,	dKick,	dSnare,	dKick,	dSnare,	dKick,	dKick
	dc.b		dSnare,	nRst,	dSnare,	dKick,	dSnare,	$05,	$05,	dKick
	dc.b		$0A,	nRst,	dSnare,	nRst,	$14,	dKick,	$0A,	dSnare
	dc.b		dKick,	nRst,	dKick,	dSnare,	nRst,	dKick,	dKick,	dSnare
	dc.b		dKick,	dKick,	nRst,	dSnare,	dKick,	nRst,	dKick,	dSnare
	dc.b		dKick,	nRst,	dKick,	dSnare,	nRst,	dSnare,	dKick,	dKick
	dc.b		dSnare,	dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	dSnare
	dc.b		dKick,	nRst,	dKick,	dSnare,	dKick,	dSnare,	nRst,	dKick
	dc.b		dSnare,	dKick,	nRst,	dSnare,	nRst,	dKick,	dKick,	dSnare
	dc.b		dKick,	nRst,	$14,	dKick2,	nRst,	dKick2,	nRst,	dKick2
	dc.b		nRst,	dKick2,	nRst,	dKick2,	nRst,	dKick2,	nRst,	dKick2
	dc.b		nRst,	dKick2
;	Jump To	 	location
	smpsJump	SA3_Chaos_Angle_DAC

SA3_Chaos_Angle_Voices:
;	Voice 00
;	$3C,$31,$52,$50,$30,$52,$53,$52,$53,$08,$00,$08,$00,$04,$00,$04,$00,$10,$0B,$10,$0D,$19,$80,$0B,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$05,	$05,	$03
	smpsVcCoarseFreq	$00,	$00,	$02,	$01
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$13,	$12,	$13,	$12
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$08,	$00,	$08
	smpsVcDecayRate2	$00,	$04,	$00,	$04
	smpsVcDecayLevel	$00,	$01,	$00,	$01
	smpsVcReleaseRate	$0D,	$00,	$0B,	$00
	smpsVcTotalLevel	$80,	$0B,	$80,	$19

;	Voice 01
;	$3A,$01,$07,$01,$01,$8E,$8E,$8D,$53,$0E,$0E,$0E,$03,$00,$00,$00,$01,$1F,$FF,$1F,$0F,$17,$28,$27,$80
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
	smpsVcDecayRate2	$01,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$01,	$0F,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$27,	$28,	$17

;	Voice 02
;	$3A,$01,$40,$01,$31,$1F,$1F,$1F,$1F,$0B,$04,$04,$04,$02,$04,$03,$02,$5F,$1F,$5F,$2F,$18,$05,$11,$80
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
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$11,	$05,	$18

;	Voice 03
;	$29,$16,$14,$58,$54,$1F,$1F,$DF,$1F,$00,$00,$01,$00,$00,$00,$03,$00,$06,$06,$06,$0A,$1B,$1C,$16,$00
;				#
	smpsVcAlgorithm		$01
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$05,	$05,	$01,	$01
	smpsVcCoarseFreq	$04,	$08,	$04,	$06
	smpsVcRateScale		$00,	$03,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$01,	$00,	$00
	smpsVcDecayRate2	$00,	$03,	$00,	$00
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$0A,	$06,	$06,	$06
	smpsVcTotalLevel	$00,	$16,	$1C,	$1B

;	Voice 04
;	$08,$09,$70,$30,$00,$1F,$1F,$5F,$5F,$12,$0E,$0A,$0A,$00,$04,$04,$03,$2F,$2F,$2F,$2F,$25,$30,$0E,$84
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$01
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$03,	$07,	$00
	smpsVcCoarseFreq	$00,	$00,	$00,	$09
	smpsVcRateScale		$01,	$01,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$0A,	$0E,	$12
	smpsVcDecayRate2	$03,	$04,	$04,	$00
	smpsVcDecayLevel	$02,	$02,	$02,	$02
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$84,	$0E,	$30,	$25

;	Voice 05
;	$08,$09,$70,$30,$00,$1F,$1F,$5F,$5F,$12,$0E,$0A,$0A,$00,$04,$04,$03,$2F,$2F,$2F,$2F,$25,$30,$13,$84
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$01
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$03,	$07,	$00
	smpsVcCoarseFreq	$00,	$00,	$00,	$09
	smpsVcRateScale		$01,	$01,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$0A,	$0E,	$12
	smpsVcDecayRate2	$03,	$04,	$04,	$00
	smpsVcDecayLevel	$02,	$02,	$02,	$02
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$84,	$13,	$30,	$25

;	Voice 06
;	$3D,$01,$01,$01,$01,$8E,$52,$14,$4C,$08,$08,$0E,$03,$00,$00,$00,$00,$1F,$1F,$1F,$1F,$1B,$80,$80,$9B
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$01,	$00,	$01,	$02
	smpsVcAttackRate	$0C,	$14,	$12,	$0E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$03,	$0E,	$08,	$08
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$9B,	$80,	$80,	$1B

;	Voice 07
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

;	Voice 08
;	$2C,$74,$74,$34,$34,$1F,$12,$1F,$1F,$00,$00,$00,$00,$00,$01,$00,$01,$0F,$3F,$0F,$3F,$16,$90,$17,$90
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
	smpsVcTotalLevel	$90,	$17,	$90,	$16

;	Voice 09
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

;	Voice 0A
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

;	Voice 0B
;	$3C,$31,$52,$50,$30,$52,$53,$52,$53,$08,$00,$08,$00,$04,$00,$04,$00,$1F,$0F,$1F,$0F,$1A,$80,$16,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$05,	$05,	$03
	smpsVcCoarseFreq	$00,	$00,	$02,	$01
	smpsVcRateScale		$01,	$01,	$01,	$01
	smpsVcAttackRate	$13,	$12,	$13,	$12
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$08,	$00,	$08
	smpsVcDecayRate2	$00,	$04,	$00,	$04
	smpsVcDecayLevel	$00,	$01,	$00,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$16,	$80,	$1A

;	Voice 0C
;	$38,$02,$02,$02,$01,$1F,$11,$11,$10,$00,$00,$00,$02,$01,$01,$01,$01,$0F,$0F,$0F,$3F,$2C,$22,$22,$83
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$02,	$02,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$10,	$11,	$11,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$02,	$00,	$00,	$00
	smpsVcDecayRate2	$01,	$01,	$01,	$01
	smpsVcDecayLevel	$03,	$00,	$00,	$00
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$83,	$22,	$22,	$2C

;	Voice 0D
;	$38,$35,$05,$10,$01,$14,$14,$10,$0E,$05,$08,$02,$08,$00,$00,$00,$00,$9F,$0F,$0F,$1F,$25,$31,$2A,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$01,	$00,	$03
	smpsVcCoarseFreq	$01,	$00,	$05,	$05
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$0E,	$10,	$14,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$08,	$02,	$08,	$05
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$01,	$00,	$00,	$09
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$2A,	$31,	$25

;	Voice 0E
;	$37,$52,$31,$34,$50,$1F,$1F,$1F,$1F,$00,$00,$00,$00,$00,$00,$00,$00,$0F,$0F,$0F,$0F,$80,$87,$87,$87
;				#
	smpsVcAlgorithm		$07
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$05,	$03,	$03,	$05
	smpsVcCoarseFreq	$00,	$04,	$01,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$00,	$00,	$00
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$87,	$87,	$87,	$80

;	Voice 0F
;	$06,$61,$03,$32,$71,$1F,$1F,$1F,$1F,$00,$00,$00,$00,$00,$00,$00,$00,$0F,$0F,$0F,$0F,$1E,$85,$80,$80
;				#
	smpsVcAlgorithm		$06
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$00,	$06
	smpsVcCoarseFreq	$01,	$02,	$03,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$00,	$00,	$00
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$80,	$85,	$1E

;	Voice 10
;	$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$00
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$0F,	$0F,	$0F,	$0F
	smpsVcCoarseFreq	$0F,	$0F,	$0F,	$0F
	smpsVcRateScale		$03,	$03,	$03,	$03
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$07,	$07,	$07,	$07
	smpsVcDecayRate1	$1F,	$1F,	$1F,	$1F
	smpsVcDecayRate2	$FF,	$FF,	$FF,	$FF
	smpsVcDecayLevel	$00,	$00,	$0F,	$0F
	smpsVcReleaseRate	$00,	$00,	$0F,	$0F
	smpsVcTotalLevel	$00,	$00,	$00,	$00
	even
