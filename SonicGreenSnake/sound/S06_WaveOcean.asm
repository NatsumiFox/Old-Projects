; =============================================================================================
; Project Name:		Wave_Ocean__the_Inlet
; Created:		17th January 2014
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

Wave_Ocean__the_Inlet_Header:
;	Voice Pointer	location
	smpsHeaderVoice	Wave_Ocean__the_Inlet_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$02,	$06

;	DAC Pointer	location
	smpsHeaderDAC	Wave_Ocean__the_Inlet_DAC
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	Wave_Ocean__the_Inlet_FM4,	smpsPitch02lo,	$0C
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	Wave_Ocean__the_Inlet_FM1,	smpsPitch00,	$10
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	Wave_Ocean__the_Inlet_FM2,	smpsPitch01hi,	$10
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	Wave_Ocean__the_Inlet_FM3,	smpsPitch00,	$10
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	Wave_Ocean__the_Inlet_FM5,	smpsPitch00,	$10
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Wave_Ocean__the_Inlet_PSG1,	smpsPitch04lo,	$04,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Wave_Ocean__the_Inlet_PSG2,	smpsPitch03lo,	$04,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Wave_Ocean__the_Inlet_PSG3,	smpsPitch00+$0B, $03,	$00

; FM1 Data
Wave_Ocean__the_Inlet_FM1:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nAb2,	$04,	$04,	nC4,	$04,	nAb2,	nAb2,	nC4
	dc.b		nC4,	nC4,	nEb3,	nEb3,	nEb3,	nEb3,	nEb3,	nEb3
	dc.b		nEb3,	nEb3,	nF3,	nF3,	nC4,	nF3,	nF3,	nC4
	dc.b		nC4,	nC4,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3
	dc.b		nCs3,	nCs3,	nC3,	nC3,	nG3,	nC3,	nC3,	nG3
	dc.b		nG3,	nG3,	nF3,	nF3,	nF3,	nF3,	nF3,	nF3
	dc.b		nF3,	nF3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3
	dc.b		nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3
	dc.b		nCs3,	nCs3,	nAb2,	nAb2,	nAb2,	nAb2,	nAb2,	nAb2
	dc.b		nAb2,	nAb2,	nEb3,	nEb3,	nEb3,	nEb3,	nEb3,	nEb3
	dc.b		nEb3,	nEb3,	nF3,	nF3,	nC4,	nF3,	nF3,	nC4
	dc.b		nC4,	nC4,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3
	dc.b		nCs3,	nCs3,	nC3,	nC3,	nG3,	nC3,	nC3,	nG3
	dc.b		nG3,	nG3,	nF3,	nF3,	nF3,	nF3,	nF3,	nF3
	dc.b		nF3,	nF3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3
	dc.b		nCs3,	nCs3,	nAb3,	nCs3,	nCs3,	nCs4,	$08,	nCs3
	dc.b		$04,	$04,	$04,	nAb2,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	nEb3,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	nF3,	$04,	$04
	dc.b		nC4,	$04,	nF3,	nF3,	nC4,	nC4,	nC4,	nCs3
	dc.b		nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nC3
	dc.b		nC3,	nG3,	nC3,	nC3,	nG3,	nG3,	nG3,	nF3
	dc.b		nF3,	nF3,	nF3,	nF3,	nF3,	nF3,	nF3,	nCs3
	dc.b		nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3
	dc.b		nCs3,	nCs3,	nG3,	nG3,	nCs3,	nCs3,	nCs3,	nAb2
	dc.b		nAb2,	nAb2,	nAb2,	nAb2,	nAb2,	nAb2,	nAb2,	nEb3
	dc.b		nEb3,	nEb3,	nEb3,	nEb3,	nEb3,	nEb3,	nEb3,	nF3
	dc.b		nF3,	nC4,	nF3,	nF3,	nC4,	nC4,	nC4,	nCs3
	dc.b		nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nC3
	dc.b		nC3,	nG3,	nC3,	nC3,	nG3,	nG3,	nG3,	nF3
	dc.b		nF3,	nF3,	nF3,	nF3,	nF3,	nF3,	nF3,	nCs3
	dc.b		nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs4
	dc.b		nCs3,	nG3,	nCs3,	$08,	$04,	$04,	$04
Wave_Ocean__the_Inlet_Jump01:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nAb2,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	nEb3,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	nF3,	$04,	$04,	nC4,	$04,	nF3
	dc.b		nF3,	nC4,	nC4,	nC4,	nCs3,	nCs3,	nCs3,	nCs3
	dc.b		nCs3,	nCs3,	nCs3,	nCs3,	nC3,	nC3,	nG3,	nC3
	dc.b		nC3,	nG3,	nG3,	nG3,	nF3,	nF3,	nF3,	nF3
	dc.b		nF3,	nF3,	nF3,	nF3,	nCs3,	nCs3,	nCs3,	nCs3
	dc.b		nCs3,	nCs3,	nCs3,	nCs3,	nAb3,	nCs3,	nC3,	nCs3
	dc.b		$08,	$04,	$04,	$04,	nAb2,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	nEb3,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	nF3,	$04
	dc.b		$04,	nC4,	$04,	nF3,	nF3,	nC4,	nC4,	nC4
	dc.b		nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3,	nCs3
	dc.b		nC3,	nC3,	nG3,	nC3,	nC3,	nG3,	nG3,	nG3
	dc.b		nF3,	nF3,	nF3,	nF3,	nF3,	nF3,	nF3,	nF3
	dc.b		nBb2,	nBb2,	nF3,	nBb2,	nBb2,	nBb3,	nBb3,	nBb3
	dc.b		nEb3,	nEb3,	nBb3,	nEb3,	nEb3,	nBb3,	nBb3,	nBb3
	dc.b		nAb2,	nEb3,	nEb3,	nEb3,	nD3,	nEb3,	nEb3,	nEb3
	dc.b		nD3,	nEb3,	nEb3,	nAb2,	nRst,	nCs3,	$08,	nG3
	dc.b		$04,	nAb3,	nEb3,	nEb3,	nEb3,	nD3,	nEb3,	nEb3
	dc.b		nEb3,	nD3,	nEb3,	nRst,	nAb3,	$08,	$04,	nG3
	dc.b		$04,	$04,	nAb2,	$04,	nEb3,	nEb3,	nEb3,	nD3
	dc.b		nEb3,	nEb3,	nEb3,	nD3,	nEb3,	nEb3,	nAb2,	nRst
	dc.b		nCs3,	$08,	nG3,	$04,	nAb3,	nEb3,	nEb3,	nEb3
	dc.b		nD3,	nEb3,	nEb3,	nEb3,	nD3,	nEb3,	nRst,	nAb3
	dc.b		$08,	$04,	nG3,	$04,	$04,	nEb3,	$04,	$04
	dc.b		nAb2,	$04,	$04,	$04,	$04,	$04,	$04,	nBb3
	dc.b		$04,	$04,	nEb3,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	nAb3,	$04,	$04,	nCs3,	$04,	$04,	$04
	dc.b		$04,	$04,	nAb3,	$04,	nCs3,	nCs3,	nAb3,	nCs3
	dc.b		nCs3,	nCs4,	nCs4,	nCs4,	nEb3,	nEb3,	nAb2,	nAb2
	dc.b		nAb2,	nAb3,	nAb2,	nAb2,	nBb3,	nEb4,	nEb3,	nEb3
	dc.b		nEb3,	nEb4,	nEb3,	nEb3,	nAb3,	nAb3,	nCs3,	nCs3
	dc.b		nCs3,	nAb3,	nCs3,	nCs3,	nAb3,	nCs3,	nC3,	nCs4
	dc.b		$08,	$04,	$04,	$04,	nEb3,	$04,	$04,	nAb2
	dc.b		$04,	$04,	$04,	nAb3,	$04,	nAb2,	nAb2,	nBb3
	dc.b		nEb4,	nEb3,	nEb3,	nEb3,	nEb4,	nEb3,	nEb3,	nAb3
	dc.b		nAb3,	nCs3,	nCs3,	nCs3,	nAb3,	nCs3,	nCs3,	nAb3
	dc.b		nAb3,	nCs3,	nCs4,	nCs3,	nCs3,	nCs4,	nCs4,	nEb3
	dc.b		nEb3,	nAb2,	nAb2,	nAb2,	nAb3,	nAb2,	nAb2,	nBb3
	dc.b		nEb4,	nEb3,	nEb3,	nEb3,	nEb4,	nEb3,	nEb3,	nAb3
	dc.b		nAb3,	nCs3,	nCs3,	nCs3,	nAb3,	nCs3,	nCs3,	nAb3
	dc.b		nCs3,	nC3,	nCs4,	$08,	$04,	$04,	$04,	nBb2
	dc.b		$08,	nF3,	$04,	$04,	nRst,	$04,	nG3,	nRst
	dc.b		nCs3,	$0C,	nAb3,	$04,	nCs3,	$08,	$04,	nAb3
	dc.b		$08,	nBb2,	$0C,	nF3,	$04,	nRst,	nG3,	nRst
	dc.b		nCs3,	$08,	$04,	nAb3,	$0C,	$04,	$08,	nBb2
	dc.b		$08,	nF3,	$04,	$04,	nRst,	$04,	nG3,	nRst
	dc.b		nCs3,	$08,	$04,	$04,	$08,	$04,	nAb3,	$08
	dc.b		nEb3,	nEb3,	$04,	$04,	nD3,	$04,	nEb3,	nD3
	dc.b		nEb3,	nEb3,	nEb3,	nEb3,	nD3,	nEb3,	nEb3,	nEb3
	dc.b		nEb3,	nEb3,	$3C,	nRst,	$44,	nAb3,	$3C,	nRst
	dc.b		$44,	$20,	nE3,	$08,	nE2,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	nFs3,	$08,	nFs2,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	nAb3,	$08,	nAb2,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	nEb3,	$04,	$04,	$04,	nG2,	$04,	nEb3
	dc.b		nEb3,	nG2,	nAb3,	$08,	nEb3,	$04,	nAb3,	nAb3
	dc.b		nE2,	$08,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		nFs3,	$08,	nFs2,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	nAb2,	$08,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	nEb3,	$04,	$04
	dc.b		$04,	nG2,	$04,	nEb3,	nEb3,	nG2,	nAb3,	$08
	dc.b		nEb3,	$04,	nAb3,	nAb3,	nE3,	$08,	nE2,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	nFs3,	$08,	nFs2
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	nAb3,	$08
	dc.b		nAb2,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	nEb3,	$04,	$04,	$04,	nG2
	dc.b		$04,	nEb3,	nEb3,	nG2,	nAb3,	$08,	nEb3,	$04
	dc.b		nAb3,	nAb3,	nE3,	$08,	nE2,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	nCs3,	$08,	nFs2,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	nAb2,	$08,	nC4,	$04
	dc.b		nAb2,	nAb2,	nEb3,	nAb2,	nAb2,	nEb3,	nAb2,	nG3
	dc.b		nEb3,	nAb2,	nAb2,	nC4,	nAb2,	nAb2,	nAb2,	nAb3
	dc.b		nAb3,	nAb3,	nAb3,	nAb3,	nAb2,	nAb3,	nAb3,	nG3
	dc.b		nAb3,	$08,	nEb3,	$04,	nAb3,	nAb3,	nAb2,	nEb3
	dc.b		nEb3,	nEb3,	nD3,	nEb3,	nEb3,	nEb3,	nD3,	nEb3
	dc.b		nEb3,	nAb2,	nRst,	nCs3,	$08,	nG3,	$04,	nAb3
	dc.b		nEb3,	nEb3,	nEb3,	nD3,	nEb3,	nEb3,	nEb3,	nD3
	dc.b		nEb3,	nRst,	nAb3,	$08,	$04,	nG3,	$04,	$04
	dc.b		nAb2,	$04,	nEb3,	nEb3,	nEb3,	nD3,	nEb3,	nEb3
	dc.b		nEb3,	nD3,	nEb3,	nEb3,	nAb2,	nRst,	nCs3,	$08
	dc.b		nG3,	$04,	nAb3,	nEb3,	nEb3,	nEb3,	nD3,	nEb3
	dc.b		nEb3,	nEb3,	nD3,	nEb3,	nRst,	nAb3,	$08,	$04
	dc.b		nG3,	$04,	$04
;	Jump To	 	location
	smpsJump	Wave_Ocean__the_Inlet_Jump01

; FM2 Data
Wave_Ocean__the_Inlet_FM2:
	dc.b		nRst,	$7F,	$7F,	$7F,	$7B
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nEb2,	$08,	nAb1,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	nEb2,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	nF2,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	nCs2,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	nC2,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	nF2
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		nCs2,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	nC2,	$04,	nCs2,	$08,	$04
	dc.b		nEb2,	$08,	nAb1,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	nEb2,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	nF2,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	nCs2,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	nC2,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	nF2
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		nCs2,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	nC2,	$04,	nCs2,	$08,	$04
	dc.b		nEb2,	$08
Wave_Ocean__the_Inlet_Jump02:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nAb1,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	nEb2,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	nF2,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	nCs2,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	nC2,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	nF2,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	nCs2,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	nC2,	$04,	nCs2,	$08,	$04,	nEb2,	$08
	dc.b		nAb1,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	nEb2,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	nF2,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	nCs2,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	nC2,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	nF2,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	nBb1,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	nEb2
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		nAb1,	$04,	$04,	$04,	$04,	nG1,	$04,	nAb1
	dc.b		nAb1,	nAb1,	nG1,	nAb1,	nAb1,	nAb1,	nRst,	nCs2
	dc.b		$08,	nC2,	$04,	nAb1,	nAb1,	nAb1,	nAb1,	nG1
	dc.b		nAb1,	nAb1,	nAb1,	nG1,	nAb1,	nRst,	nCs2,	$08
	dc.b		$04,	nC2,	$04,	$04,	nAb1,	$04,	$04,	$04
	dc.b		$04,	nG1,	$04,	nAb1,	nAb1,	nAb1,	nG1,	nAb1
	dc.b		nAb1,	nAb1,	nRst,	nCs2,	$08,	nC2,	$04,	nAb1
	dc.b		nAb1,	nAb1,	nAb1,	nG1,	nAb1,	nAb1,	nAb1,	nG1
	dc.b		nAb1,	nRst,	nCs2,	$08,	$04,	nC2,	$04,	$04
	dc.b		nAb1,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	nEb2,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	nCs2,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	nAb1,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	nEb2,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	nCs2,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		nC2,	$04,	nCs2,	$08,	$04,	nEb2,	$08,	nAb1
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		nEb2,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	nCs2,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	nAb1,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	nEb2,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	nCs2,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	nC2
	dc.b		$04,	nCs2,	$08,	$04,	nEb2,	$08,	nBb1,	$04
	dc.b		$04,	$04,	$04,	nRst,	$04,	nC2,	nRst,	nCs2
	dc.b		$08,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		nBb1,	$04,	$04,	$04,	$04,	nRst,	$04,	nC2
	dc.b		nRst,	nCs2,	$08,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	nBb1,	$04,	$04,	$04,	$04,	nRst
	dc.b		$04,	nC2,	nRst,	nCs2,	$08,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	nEb2,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	nBb2,	$04,	nEb3,	nEb3
	dc.b		nEb3,	nEb3,	nEb3,	nEb3,	nEb3,	nEb3,	nAb1,	$3C
	dc.b		nRst,	$44,	nAb1,	$3C,	nRst,	$44,	$20,	nE2
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		nFs2,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	nAb2,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		nFs2,	$04,	$04,	nE2,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	nFs2,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	nAb2,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	nFs2,	$04,	$04,	nE2
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		nFs2,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	nAb2,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		nFs2,	$04,	$04,	nE2,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	nFs2,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	nAb2,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	nRst,	$7F
	dc.b		$6D,	nCs2,	$08,	$04,	nC2,	$04,	$04
;	Jump To	 	location
	smpsJump	Wave_Ocean__the_Inlet_Jump02

; FM3 Data
Wave_Ocean__the_Inlet_FM3:
	dc.b		nRst,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nAb2,	$04,	nRst,	$08,	nAb2,	$04,	$04,	$04
	dc.b		nRst,	$08,	nBb3,	$04,	nRst,	$08,	nEb4,	$04
	dc.b		nBb3,	nBb3,	nRst,	$08,	nF3,	$04,	nRst,	$08
	dc.b		nF3,	$04,	$04,	$04,	nRst,	$08,	nAb3,	$04
	dc.b		nRst,	$08,	nAb3,	$04,	$04,	$04,	nRst,	$08
	dc.b		nC3,	$04,	nRst,	$08,	nC3,	$04,	$04,	$04
	dc.b		nRst,	$08,	nC4,	$04,	nRst,	$08,	nC4,	$04
	dc.b		$04,	$04,	nRst,	$08,	nAb3,	$04,	nRst,	$08
	dc.b		nAb3,	$04,	$04,	nRst,	$0C,	nAb3,	$04,	nRst
	dc.b		$08,	nAb3,	$04,	$04,	$04,	nRst,	$08,	nEb3
	dc.b		$04,	nRst,	$08,	nEb3,	$04,	$04,	$04,	nRst
	dc.b		$08,	nBb3,	$04,	nRst,	$08,	nEb4,	$04,	nBb3
	dc.b		nBb3,	nRst,	$08,	nF3,	$04,	nRst,	$08,	nF3
	dc.b		$04,	$04,	$04,	nRst,	$08,	nAb3,	$04,	nRst
	dc.b		$08,	nAb3,	$04,	$04,	$04,	nRst,	$08,	nC3
	dc.b		$04,	nRst,	$08,	nC3,	$04,	$04,	$04,	nRst
	dc.b		$08,	nC4,	$04,	nRst,	$08,	nC4,	$04,	$04
	dc.b		$04,	nRst,	$08,	nAb3,	$04,	nRst,	$08,	nAb3
	dc.b		$04,	nRst,	$08,	nCs4,	$04,	nRst,	$08,	nAb3
	dc.b		nAb3,	$04,	$04,	$04,	nRst,	$08,	nEb3,	$04
	dc.b		nRst,	$08,	nEb3,	$04,	$04,	$04,	nRst,	$08
	dc.b		nBb3,	$04,	nRst,	$08,	nEb4,	$04,	nBb3,	nBb3
	dc.b		nRst,	$08,	nF3,	$04,	nRst,	$08,	nF3,	$04
	dc.b		$04,	$04,	nRst,	$08,	nAb3,	$04,	nRst,	$08
	dc.b		nAb3,	$04,	$04,	$04,	nRst,	$08,	nC3,	$04
	dc.b		nRst,	$08,	nC3,	$04,	$04,	$04,	nRst,	$08
	dc.b		nC4,	$04,	nRst,	$08,	nC4,	$04,	$04,	$04
	dc.b		nRst,	$08,	nAb3,	$04,	nRst,	$08,	nAb3,	$04
	dc.b		nRst,	$10,	nAb3,	$04,	nC3,	nC3,	nAb3,	nAb3
	dc.b		nAb3,	nRst,	$08,	nEb3,	$04,	nRst,	$08,	nEb3
	dc.b		$04,	$04,	$04,	nRst,	$08,	nBb3,	$04,	nRst
	dc.b		$08,	nEb4,	$04,	nBb3,	nBb3,	nRst,	$08,	nF3
	dc.b		$04,	nRst,	$08,	nF3,	$04,	$04,	$04,	nRst
	dc.b		$08,	nAb3,	$04,	nRst,	$08,	nAb3,	$04,	$04
	dc.b		$04,	nRst,	$08,	nC3,	$04,	nRst,	$08,	nC3
	dc.b		$04,	$04,	$04,	nRst,	$08,	nC4,	$04,	nRst
	dc.b		$08,	nC4,	$04,	$04,	$04,	nRst,	$08,	nAb3
	dc.b		$04,	nRst,	$08,	nAb3,	$04,	nRst,	$08,	nAb3
	dc.b		$04,	nRst,	nC3,	nAb3,	$08,	$04,	$04,	$04
Wave_Ocean__the_Inlet_Jump03:
	dc.b		nRst,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nEb3,	$04,	nRst,	$08,	nEb3,	$04,	$04,	$04
	dc.b		nRst,	$08,	nBb3,	$04,	nRst,	$08,	nEb4,	$04
	dc.b		nBb3,	nBb3,	nRst,	$08,	nF3,	$04,	nRst,	$08
	dc.b		nF3,	$04,	$04,	$04,	nRst,	$08,	nAb3,	$04
	dc.b		nRst,	$08,	nAb3,	$04,	$04,	$04,	nRst,	$08
	dc.b		nC3,	$04,	nRst,	$08,	nC3,	$04,	$04,	$04
	dc.b		nRst,	$08,	nC4,	$04,	nRst,	$08,	nC4,	$04
	dc.b		$04,	$04,	nRst,	$08,	nAb3,	$04,	nRst,	$08
	dc.b		nAb3,	$04,	nRst,	$08,	nCs4,	$04,	nRst,	nG3
	dc.b		nAb3,	$08,	$04,	$04,	$04,	nRst,	$08,	nEb3
	dc.b		$04,	nRst,	$08,	nEb3,	$04,	$04,	$04,	nRst
	dc.b		$08,	nBb3,	$04,	nRst,	$08,	nEb4,	$04,	nBb3
	dc.b		nBb3,	nRst,	$08,	nF3,	$04,	nRst,	$08,	nF3
	dc.b		$04,	$04,	$04,	nRst,	$08,	nAb3,	$04,	nRst
	dc.b		$08,	nAb3,	$04,	$04,	$04,	nRst,	$08,	nC3
	dc.b		$04,	nRst,	$08,	nC3,	$04,	$04,	$04,	nRst
	dc.b		$08,	nC4,	$04,	nRst,	$08,	nC4,	$04,	$04
	dc.b		$04,	nRst,	$08,	nBb3,	$04,	nRst,	$08,	nF3
	dc.b		$04,	$04,	$04,	nRst,	$08,	nEb4,	$04,	nRst
	dc.b		$08,	nEb4,	$04,	$04,	$04,	nEb3,	$04,	nAb3
	dc.b		nAb3,	nAb3,	nG3,	nAb3,	nAb3,	nAb3,	nG3,	nAb3
	dc.b		nAb3,	nEb3,	nRst,	nAb3,	$08,	nC4,	$04,	nEb3
	dc.b		nAb2,	nAb2,	nAb2,	nG2,	nAb2,	nAb2,	nAb2,	nG2
	dc.b		nAb2,	nRst,	nCs3,	$08,	$04,	nC3,	$04,	$04
	dc.b		nEb3,	$04,	nAb3,	nAb3,	nAb3,	nG3,	nAb3,	nAb3
	dc.b		nAb3,	nG3,	nAb3,	nAb3,	nEb3,	nRst,	nAb3,	$08
	dc.b		nC4,	$04,	nEb3,	nAb2,	nAb2,	nAb2,	nG2,	nAb2
	dc.b		nAb2,	nAb2,	nG2,	nAb2,	nRst,	nCs3,	$08,	$04
	dc.b		nC3,	$04,	$04,	nAb2,	$04,	$04,	nRst,	$18
	dc.b		nEb4,	$04,	$04,	nRst,	$18,	nCs4,	$04,	$04
	dc.b		nRst,	$14,	nCs4,	$04,	nRst,	$08,	nCs4,	$04
	dc.b		nRst,	$08,	nAb3,	$04,	$04,	$04,	nAb2,	$04
	dc.b		$04,	nRst,	$0C,	nEb3,	$04,	nRst,	$08,	nEb4
	dc.b		$04,	nBb3,	nRst,	$0C,	nBb3,	$04,	nRst,	$08
	dc.b		nCs4,	$04,	$04,	nRst,	$0C,	nCs4,	$04,	nRst
	dc.b		$08,	nCs4,	$04,	nRst,	nC4,	nAb3,	$08,	$04
	dc.b		$04,	$04,	nAb2,	$04,	$04,	nRst,	$0C,	nEb3
	dc.b		$04,	nRst,	$08,	nEb4,	$04,	nBb3,	nRst,	$0C
	dc.b		nBb3,	$04,	nRst,	$08,	nCs4,	$04,	$04,	nRst
	dc.b		$0C,	nCs4,	$04,	nRst,	$08,	nCs4,	$04,	$04
	dc.b		nRst,	$04,	nAb3,	nRst,	$08,	nAb3,	$04,	$04
	dc.b		nAb2,	$04,	$04,	nRst,	$0C,	nEb3,	$04,	nRst
	dc.b		$08,	nEb4,	$04,	nBb3,	nRst,	$0C,	nBb3,	$04
	dc.b		nRst,	$08,	nCs4,	$04,	$04,	nRst,	$0C,	nCs4
	dc.b		$04,	nRst,	$08,	nCs4,	$04,	nRst,	nC4,	nAb3
	dc.b		$08,	$04,	$04,	$04,	nF3,	$08,	nBb2,	$04
	dc.b		$04,	nRst,	$04,	nC4,	nRst,	nAb3,	$0C,	nCs3
	dc.b		$04,	nAb3,	$08,	$04,	nCs3,	$08,	nF3,	$0C
	dc.b		nBb2,	$04,	nRst,	nC4,	nRst,	nAb3,	$08,	$04
	dc.b		nCs3,	$0C,	$04,	$08,	nF3,	$08,	nBb2,	$04
	dc.b		$04,	nRst,	$04,	nC4,	nRst,	nAb3,	$08,	$04
	dc.b		$04,	$08,	$04,	nCs3,	$08,	nEb4,	nBb3,	$04
	dc.b		$04,	nA3,	$04,	nBb3,	nA3,	nBb3,	nBb3,	nBb3
	dc.b		nBb3,	nA3,	nBb3,	nBb3,	nBb3,	nBb3,	nAb2,	$3C
	dc.b		nRst,	$44,	nEb3,	$3C,	nRst,	$44,	$20,	nB2
	dc.b		$08,	nRst,	$38,	nCs3,	$08,	nRst,	$38,	nEb3
	dc.b		$08,	nRst,	$48,	nAb3,	$04,	$04,	$04,	nD3
	dc.b		$04,	nAb3,	nAb3,	nD3,	nEb3,	$08,	nAb3,	$04
	dc.b		nEb3,	nEb3,	nE3,	$08,	nRst,	$38,	nCs3,	$08
	dc.b		nRst,	$38,	nAb3,	$08,	nRst,	$48,	nAb3,	$04
	dc.b		$04,	$04,	nD3,	$04,	nAb3,	nAb3,	nD3,	nEb3
	dc.b		$08,	nAb3,	$04,	nEb3,	nEb3,	nB2,	$08,	nRst
	dc.b		$38,	nCs3,	$08,	nRst,	$38,	nEb3,	$08,	nRst
	dc.b		$48,	nAb3,	$04,	$04,	$04,	nD3,	$04,	nAb3
	dc.b		nAb3,	nD3,	nEb3,	$08,	nAb3,	$04,	nEb3,	nEb3
	dc.b		nB2,	$08,	nRst,	$38,	nFs3,	$08,	nRst,	$38
	dc.b		nEb3,	$08,	nAb3,	$04,	nRst,	$08,	nAb3,	$04
	dc.b		nRst,	$08,	nAb3,	$04,	nRst,	nD3,	nAb3,	nRst
	dc.b		$08,	nEb3,	$04,	nRst,	$0C,	nEb3,	$04,	$04
	dc.b		$04,	$04,	$04,	nAb3,	$04,	nEb3,	nEb3,	nD3
	dc.b		nEb3,	$08,	nAb3,	$04,	nEb3,	nEb3,	nEb3,	nAb3
	dc.b		nAb3,	nAb3,	nG3,	nAb3,	nAb3,	nAb3,	nG3,	nAb3
	dc.b		nAb3,	nEb3,	nRst,	nAb3,	$08,	nC4,	$04,	nEb3
	dc.b		nAb2,	nAb2,	nAb2,	nG2,	nAb2,	nAb2,	nAb2,	nG2
	dc.b		nAb2,	nRst,	nCs3,	$08,	$04,	nC3,	$04,	$04
	dc.b		nEb3,	$04,	nAb3,	nAb3,	nAb3,	nG3,	nAb3,	nAb3
	dc.b		nAb3,	nG3,	nAb3,	nAb3,	nEb3,	nRst,	nAb3,	$08
	dc.b		nC4,	$04,	nEb3,	nAb2,	nAb2,	nAb2,	nG2,	nAb2
	dc.b		nAb2,	nAb2,	nG2,	nAb2,	nRst,	nCs3,	$08,	$04
	dc.b		nC3,	$04,	$04
;	Jump To	 	location
	smpsJump	Wave_Ocean__the_Inlet_Jump03

; FM4 Data
Wave_Ocean__the_Inlet_FM4:
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$08
Wave_Ocean__the_Inlet_Jump04:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nAb3,	$0C,	nC4,	nEb4,	$08,	nG4,	$01,	nAb4
	dc.b		$0B,	nG4,	$0C,	nAb4,	$08,	nFs4,	$01,	nG4
	dc.b		$0B,	nF4,	$0C,	nEb4,	$08,	nE4,	$01,	nF4
	dc.b		$0B,	nAb3,	$0C,	nBb3,	$08,	nB3,	$01,	nC4
	dc.b		$0B,	nEb4,	$14,	nE4,	$01,	nF4,	$0B,	nAb3
	dc.b		$0C,	nC4,	$08,	nB3,	$01,	nC4,	$0B,	nCs4
	dc.b		$2C,	nRst,	$08,	nAb3,	$18,	nC4,	$04,	nEb4
	dc.b		nG4,	$01,	nAb4,	$0B,	nG4,	$0C,	nAb4,	$08
	dc.b		nFs4,	$01,	nG4,	$0B,	nF4,	$0C,	nEb4,	$08
	dc.b		nE4,	$01,	nF4,	$0B,	nAb4,	$0C,	nBb4,	$08
	dc.b		nB4,	$01,	nC5,	$0B,	nEb5,	$14,	nE5,	$01
	dc.b		nF5,	$0B,	nAb4,	$0C,	nC5,	$08,	nB4,	$01
	dc.b		nC5,	$0B,	nBb4,	$30,	nRst,	$04,	nRst,	$7F
	dc.b		$7F,	$02,	nAb4,	$0C,	nG4,	nAb4,	$08,	nD4
	dc.b		$01,	nEb4,	$0B,	nG4,	$0C,	nAb4,	$08,	nA4
	dc.b		$01,	nBb4,	$0B,	nAb4,	$2C,	nRst,	$08,	nG4
	dc.b		$01,	nAb4,	$0B,	nG4,	$0C,	nAb4,	$08,	nD4
	dc.b		$01,	nEb4,	$0B,	nG4,	$0C,	nAb4,	$08,	nD5
	dc.b		$01,	nEb5,	$13,	nCs5,	$04,	nC5,	nCs5,	$20
	dc.b		nRst,	$04,	nG4,	$01,	nAb4,	$0B,	nG4,	$0C
	dc.b		nAb4,	$08,	nD4,	$01,	nEb4,	$0B,	nG4,	$0C
	dc.b		nAb4,	$08,	nA4,	$01,	nBb4,	$0B,	nAb4,	$2C
	dc.b		nRst,	$08,	nB4,	$01,	nC5,	$0B,	nBb4,	$0C
	dc.b		nC5,	$08,	nA4,	$01,	nBb4,	$0B,	nC5,	$0C
	dc.b		nCs5,	$08,	nC5,	$01,	nCs5,	$07,	nC5,	$04
	dc.b		nAb4,	$2C,	nRst,	$08,	nRst,	$7F,	$7F,	$02
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nC6,	$0C,	nC7,	nAb6,	nFs6,	nAb6,	nAb5,	nC6
	dc.b		nBb5,	nEb6,	nFs6,	nAb6,	$08,	nC6,	$0C,	nC7
	dc.b		nAb6,	nFs6,	nAb6,	nAb5,	nC6,	nBb5,	nEb6,	nFs6
	dc.b		nAb6,	$10,	nRst,	$20
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nD5,	$01,	nEb5,	$0B,	nB4,	$0C,	nC5,	$01
	dc.b		nCs5,	$0B,	nFs4,	$0C,	nG4,	$01,	nAb4,	$0B
	dc.b		nE4,	$0C,	nF4,	$01,	nFs4,	$0B,	nB3,	$0C
	dc.b		nC4,	$01,	nCs4,	$0B,	nFs3,	$0C,	nAb3,	$32
	dc.b		nRst,	$0A,	$04,	nAb5,	$32,	nRst,	$1E,	nE3
	dc.b		$03,	nFs3,	nAb3,	$02,	nBb3,	$03,	nB3,	nCs4
	dc.b		$02,	nEb4,	$03,	nF4,	nG4,	$02,	nAb4,	$03
	dc.b		nBb4,	$02,	nB4,	$03,	nCs5,	nEb5,	$02,	nE5
	dc.b		$03,	nF5,	$02,	nG5,	$03,	nAb5,	nA5,	$01
	dc.b		nBb5,	$0B,	nFs5,	$34,	nAb5,	$32,	nRst,	$1E
	dc.b		$38,	nD5,	$01,	nEb5,	$0B,	nB4,	$0C,	nC5
	dc.b		$01,	nCs5,	$0B,	nFs4,	$0C,	nG4,	$01,	nAb4
	dc.b		$0B,	nE4,	$0C,	nF4,	$01,	nFs4,	$0B,	nB3
	dc.b		$0C,	nC4,	$01,	nCs4,	$0B,	nFs3,	$0C,	nAb3
	dc.b		$32,	nRst,	$0A,	$04,	nAb5,	$20,	nRst,	$30
	dc.b		nE3,	$03,	nFs3,	nAb3,	$02,	nBb3,	$03,	nB3
	dc.b		nCs4,	$02,	nEb4,	$03,	nF4,	nG4,	$02,	nAb4
	dc.b		$03,	nBb4,	$02,	nB4,	$03,	nCs5,	nEb5,	$02
	dc.b		nE5,	$03,	nF5,	$02,	nG5,	$03,	nAb5,	nA5
	dc.b		$01,	nBb5,	$0B,	nFs5,	$26,	nRst,	$0E,	nAb5
	dc.b		$20,	nRst,	$18,	nRst,	$7F,	$7F,	$4A
;	Jump To	 	location
	smpsJump	Wave_Ocean__the_Inlet_Jump04

; FM5 Data
Wave_Ocean__the_Inlet_FM5:
	dc.b		nRst,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nEb3,	$04,	nRst,	$08,	nEb3,	$04,	$04,	$04
	dc.b		nRst,	$08,	nEb4,	$04,	nRst,	$08,	nBb3,	$04
	dc.b		nEb4,	nEb4,	nRst,	$08,	nF4,	$04,	nRst,	$08
	dc.b		nF4,	$04,	$04,	$04,	nRst,	$08,	nCs4,	$04
	dc.b		nRst,	$08,	nCs4,	$04,	$04,	$04,	nRst,	$08
	dc.b		nC4,	$04,	nRst,	$08,	nC4,	$04,	$04,	$04
	dc.b		nRst,	$08,	nF4,	$04,	nRst,	$08,	nF4,	$04
	dc.b		$04,	$04,	nRst,	$08,	nCs4,	$04,	nRst,	$08
	dc.b		nCs4,	$04,	$04,	nRst,	$0C,	nCs4,	$04,	nRst
	dc.b		$08,	nCs4,	$04,	$04,	$04,	nRst,	$08,	nAb3
	dc.b		$04,	nRst,	$08,	nAb3,	$04,	$04,	$04,	nRst
	dc.b		$08,	nEb4,	$04,	nRst,	$08,	nBb3,	$04,	nEb4
	dc.b		nEb4,	nRst,	$08,	nF4,	$04,	nRst,	$08,	nF4
	dc.b		$04,	$04,	$04,	nRst,	$08,	nCs4,	$04,	nRst
	dc.b		$08,	nCs4,	$04,	$04,	$04,	nRst,	$08,	nC4
	dc.b		$04,	nRst,	$08,	nC4,	$04,	$04,	$04,	nRst
	dc.b		$08,	nF4,	$04,	nRst,	$08,	nF4,	$04,	$04
	dc.b		$04,	nRst,	$08,	nCs4,	$04,	nRst,	$08,	nCs4
	dc.b		$04,	nRst,	$08,	nCs3,	$04,	nRst,	$08,	nCs3
	dc.b		nCs4,	$04,	$04,	$04,	nRst,	$08,	nAb3,	$04
	dc.b		nRst,	$08,	nAb3,	$04,	$04,	$04,	nRst,	$08
	dc.b		nEb4,	$04,	nRst,	$08,	nBb3,	$04,	nEb4,	nEb4
	dc.b		nRst,	$08,	nF4,	$04,	nRst,	$08,	nF4,	$04
	dc.b		$04,	$04,	nRst,	$08,	nCs4,	$04,	nRst,	$08
	dc.b		nCs4,	$04,	$04,	$04,	nRst,	$08,	nC4,	$04
	dc.b		nRst,	$08,	nC4,	$04,	$04,	$04,	nRst,	$08
	dc.b		nF4,	$04,	nRst,	$08,	nF4,	$04,	$04,	$04
	dc.b		nRst,	$08,	nCs4,	$04,	nRst,	$08,	nCs4,	$04
	dc.b		nRst,	$10,	nCs4,	$04,	nC4,	nC4,	nCs4,	nCs4
	dc.b		nCs4,	nRst,	$08,	nAb3,	$04,	nRst,	$08,	nAb3
	dc.b		$04,	$04,	$04,	nRst,	$08,	nEb4,	$04,	nRst
	dc.b		$08,	nBb3,	$04,	nEb4,	nEb4,	nRst,	$08,	nF4
	dc.b		$04,	nRst,	$08,	nF4,	$04,	$04,	$04,	nRst
	dc.b		$08,	nCs4,	$04,	nRst,	$08,	nCs4,	$04,	$04
	dc.b		$04,	nRst,	$08,	nC4,	$04,	nRst,	$08,	nC4
	dc.b		$04,	$04,	$04,	nRst,	$08,	nF4,	$04,	nRst
	dc.b		$08,	nF4,	$04,	$04,	$04,	nRst,	$08,	nCs4
	dc.b		$04,	nRst,	$08,	nCs4,	$04,	nRst,	$08,	nCs3
	dc.b		$04,	nRst,	nC4,	nCs4,	$08,	$04,	$04,	$04
Wave_Ocean__the_Inlet_Jump05:
	dc.b		nRst,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nAb3,	$04,	nRst,	$08,	nAb3,	$04,	$04,	$04
	dc.b		nRst,	$08,	nEb4,	$04,	nRst,	$08,	nBb3,	$04
	dc.b		nEb4,	nEb4,	nRst,	$08,	nF4,	$04,	nRst,	$08
	dc.b		nF4,	$04,	$04,	$04,	nRst,	$08,	nCs4,	$04
	dc.b		nRst,	$08,	nCs4,	$04,	$04,	$04,	nRst,	$08
	dc.b		nC4,	$04,	nRst,	$08,	nC4,	$04,	$04,	$04
	dc.b		nRst,	$08,	nF4,	$04,	nRst,	$08,	nF4,	$04
	dc.b		$04,	$04,	nRst,	$08,	nCs4,	$04,	nRst,	$08
	dc.b		nCs4,	$04,	nRst,	$08,	nCs3,	$04,	nRst,	nC4
	dc.b		nCs4,	$08,	$04,	$04,	$04,	nRst,	$08,	nAb3
	dc.b		$04,	nRst,	$08,	nAb3,	$04,	$04,	$04,	nRst
	dc.b		$08,	nEb4,	$04,	nRst,	$08,	nBb3,	$04,	nEb4
	dc.b		nEb4,	nRst,	$08,	nF4,	$04,	nRst,	$08,	nF4
	dc.b		$04,	$04,	$04,	nRst,	$08,	nCs4,	$04,	nRst
	dc.b		$08,	nCs4,	$04,	$04,	$04,	nRst,	$08,	nC4
	dc.b		$04,	nRst,	$08,	nC4,	$04,	$04,	$04,	nRst
	dc.b		$08,	nF4,	$04,	nRst,	$08,	nF4,	$04,	$04
	dc.b		$04,	nRst,	$08,	nBb2,	$04,	nRst,	$08,	nBb2
	dc.b		$04,	$04,	$04,	nRst,	$08,	nEb3,	$04,	nRst
	dc.b		$08,	nEb3,	$04,	$04,	$04,	nAb3,	$04,	nAb2
	dc.b		nAb2,	nAb2,	nG2,	nAb2,	nAb2,	nAb2,	nG2,	nAb2
	dc.b		nAb2,	nAb3,	nRst,	nCs4,	$08,	nC3,	$04,	nAb2
	dc.b		nAb3,	nAb3,	nAb3,	nG3,	nAb3,	nAb3,	nAb3,	nG3
	dc.b		nAb3,	nRst,	nCs4,	$08,	$04,	nC4,	$04,	$04
	dc.b		nAb3,	$04,	nAb2,	nAb2,	nAb2,	nG2,	nAb2,	nAb2
	dc.b		nAb2,	nG2,	nAb2,	nAb2,	nAb3,	nRst,	nCs4,	$08
	dc.b		nC3,	$04,	nAb2,	nAb3,	nAb3,	nAb3,	nG3,	nAb3
	dc.b		nAb3,	nAb3,	nG3,	nAb3,	nRst,	nCs4,	$08,	$04
	dc.b		nC4,	$04,	$04,	nAb3,	$04,	$04,	nRst,	$18
	dc.b		nEb3,	$04,	$04,	nRst,	$18,	nCs3,	$04,	$04
	dc.b		nRst,	$14,	nCs3,	$04,	nRst,	$08,	nCs3,	$04
	dc.b		nRst,	$08,	nCs3,	$04,	$04,	$04,	nAb3,	$04
	dc.b		$04,	nRst,	$0C,	nAb2,	$04,	nRst,	$08,	nEb3
	dc.b		$04,	$04,	nRst,	$0C,	nEb3,	$04,	nRst,	$08
	dc.b		nCs3,	$04,	$04,	nRst,	$0C,	nCs3,	$04,	nRst
	dc.b		$08,	nCs3,	$04,	nRst,	nG3,	nCs3,	nCs3,	nCs3
	dc.b		nCs3,	nCs3,	nAb3,	nAb3,	nRst,	$0C,	nAb2,	$04
	dc.b		nRst,	$08,	nEb3,	$04,	$04,	nRst,	$0C,	nEb3
	dc.b		$04,	nRst,	$08,	nCs3,	$04,	$04,	nRst,	$0C
	dc.b		nCs3,	$04,	nRst,	$08,	nCs3,	$04,	$04,	nRst
	dc.b		$04,	nCs3,	nRst,	$08,	nCs3,	$04,	$04,	nAb3
	dc.b		$04,	$04,	nRst,	$0C,	nAb2,	$04,	nRst,	$08
	dc.b		nEb3,	$04,	$04,	nRst,	$0C,	nEb3,	$04,	nRst
	dc.b		$08,	nCs3,	$04,	$04,	nRst,	$0C,	nCs3,	$04
	dc.b		nRst,	$08,	nCs3,	$04,	nRst,	nG3,	nCs3,	nCs3
	dc.b		nCs3,	nCs3,	nCs3,	nBb3,	$08,	$04,	$04,	nRst
	dc.b		$04,	nC3,	nRst,	nCs4,	$0C,	$04,	$08,	$04
	dc.b		$08,	nBb3,	$0C,	$04,	nRst,	$04,	nC3,	nRst
	dc.b		nCs4,	$08,	$04,	$0C,	$04,	$08,	nBb3,	$08
	dc.b		$04,	$04,	nRst,	$04,	nC3,	nRst,	nCs4,	$08
	dc.b		$04,	$04,	$08,	$04,	$08,	nBb3,	$08,	nEb4
	dc.b		$04,	$04,	nD4,	$04,	nEb4,	nD4,	nEb4,	nEb4
	dc.b		nEb4,	nEb4,	nD4,	nEb4,	nEb4,	nEb4,	nEb4,	nAb3
	dc.b		$3C,	nRst,	$44,	nAb2,	$3C,	nRst,	$44,	$20
	dc.b		nE2,	$08,	nRst,	$38,	nFs2,	$08,	nRst,	$38
	dc.b		nAb2,	$08,	nRst,	$48,	nAb2,	$04,	$04,	$04
	dc.b		nG3,	$04,	nAb2,	nAb2,	nG3,	nAb2,	nAb2,	nAb2
	dc.b		nAb2,	nAb2,	nB2,	$08,	nRst,	$38,	nFs2,	$08
	dc.b		nRst,	$38,	nEb3,	$08,	nRst,	$48,	nAb2,	$04
	dc.b		$04,	$04,	nG3,	$04,	nAb2,	nAb2,	nG3,	nAb2
	dc.b		nAb2,	nAb2,	nAb2,	nAb2,	nE2,	$08,	nRst,	$38
	dc.b		nFs2,	$08,	nRst,	$38,	nAb2,	$08,	nRst,	$48
	dc.b		nAb2,	$04,	$04,	$04,	nG3,	$04,	nAb2,	nAb2
	dc.b		nG3,	nAb2,	nAb2,	nAb2,	nAb2,	nAb2,	nE2,	$08
	dc.b		nRst,	$38,	nFs2,	$04,	$04,	nRst,	$38,	nAb3
	dc.b		$08,	nEb3,	$04,	nRst,	$08,	nC4,	$04,	nRst
	dc.b		$08,	nAb2,	$04,	nRst,	nG2,	nAb2,	nRst,	$08
	dc.b		nAb3,	$04,	nRst,	$0C,	nAb2,	$04,	$04,	$04
	dc.b		$04,	$04,	nEb3,	$04,	nAb2,	nAb2,	nG2,	nAb2
	dc.b		nAb2,	nAb2,	nAb2,	nAb2,	nAb3,	nAb2,	nAb2,	nAb2
	dc.b		nG2,	nAb2,	nAb2,	nAb2,	nG2,	nAb2,	nAb2,	nAb3
	dc.b		nRst,	nCs4,	$08,	nC3,	$04,	nAb2,	nAb3,	nAb3
	dc.b		nAb3,	nG3,	nAb3,	nAb3,	nAb3,	nG3,	nAb3,	nRst
	dc.b		nCs4,	$08,	$04,	nC4,	$04,	$04,	nAb3,	$04
	dc.b		nAb2,	nAb2,	nAb2,	nG2,	nAb2,	nAb2,	nAb2,	nG2
	dc.b		nAb2,	nAb2,	nAb3,	nRst,	nCs4,	$08,	nC3,	$04
	dc.b		nAb2,	nAb3,	nAb3,	nAb3,	nG3,	nAb3,	nAb3,	nAb3
	dc.b		nG3,	nAb3,	nRst,	nCs4,	$08,	$04,	nC4,	$04
	dc.b		$04
;	Jump To	 	location
	smpsJump	Wave_Ocean__the_Inlet_Jump05

; PSG1 Data
Wave_Ocean__the_Inlet_PSG1:
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$26
Wave_Ocean__the_Inlet_Jump06:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nAb3,	$02,	nBb3,	nB3,	nCs4,	nEb4,	nE4,	nF4
	dc.b		nFs4,	nAb4,	$32,	nRst,	$0E,	nBb4,	$32,	nRst
	dc.b		$0E,	nC5,	$32,	nRst,	$0E,	nEb5,	$10,	nRst
	dc.b		$22,	$0E,	nAb4,	$32,	nRst,	$0E,	nBb4,	$32
	dc.b		nRst,	$0E,	nC5,	$32,	nRst,	$4E,	nAb4,	$32
	dc.b		nRst,	$0E,	nBb4,	$32,	nRst,	$0E,	nC5,	$32
	dc.b		nRst,	$0E,	nEb5,	$32,	nRst,	$0E,	nAb4,	$32
	dc.b		nRst,	$0E,	nBb4,	$32,	nRst,	$0E,	nC5,	$32
	dc.b		nRst,	$4E,	nRst,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$20
;	Jump To	 	location
	smpsJump	Wave_Ocean__the_Inlet_Jump06

; PSG2 Data
Wave_Ocean__the_Inlet_PSG2:
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$26
Wave_Ocean__the_Inlet_Jump07:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nAb4,	$02,	nBb4,	nB4,	nCs5,	nEb5,	nE5,	nF5
	dc.b		nFs5,	nAb5,	$32,	nRst,	$0E,	nBb5,	$32,	nRst
	dc.b		$0E,	nC6,	$32,	nRst,	$0E,	nEb6,	$10,	nRst
	dc.b		$22,	$0E,	nAb5,	$32,	nRst,	$0E,	nBb5,	$32
	dc.b		nRst,	$0E,	nC6,	$32,	nRst,	$4E,	nAb5,	$32
	dc.b		nRst,	$0E,	nBb5,	$32,	nRst,	$0E,	nC6,	$32
	dc.b		nRst,	$0E,	nEb6,	$32,	nRst,	$0E,	nAb5,	$32
	dc.b		nRst,	$0E,	nBb5,	$32,	nRst,	$0E,	nC6,	$32
	dc.b		nRst,	$4E,	nRst,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$20
;	Jump To	 	location
	smpsJump	Wave_Ocean__the_Inlet_Jump07

; PSG3 Data
Wave_Ocean__the_Inlet_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
	dc.b		nRst,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$02,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nRst
	dc.b		$04,	nAb6,	$02,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nRst,	$04,	nAb6,	$02,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nAb6
;	Set PSG WvForm	#
	smpsPSGform	$E7
Wave_Ocean__the_Inlet_Jump08:
	dc.b		nRst,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$02,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	$06
	dc.b		nAb6,	$02,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nRst
	dc.b		$04,	nAb6,	$02,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nRst,	$04,	nAb6,	$02,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	$06,	nAb6,	$02,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nRst,	$04,	nAb6,	$02,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	$04,	nAb6,	$02,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nAb6,	nRst,	$04,	nAb6,	$02,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	$04,	nAb6,	$02
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nRst,	$04,	nAb6
	dc.b		$02,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nRst,	$04
	dc.b		nAb6,	$02,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nRst
	dc.b		$04,	nAb6,	$02,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst
	dc.b		nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nRst,	$04,	nAb6,	$02,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6,	nRst,	nAb6
	dc.b		nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6,	nAb6
	dc.b		nAb6
;	Jump To	 	location
	smpsJump	Wave_Ocean__the_Inlet_Jump08

; DAC Data
Wave_Ocean__the_Inlet_DAC:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$96,	$18,	nRst,	$7F,	$69,	$96,	$10,	nRst
	dc.b		$7F,	$71,	$96,	$08,	dSnare,	$02,	nRst,	$0A
	dc.b		dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02
	dc.b		nRst,	$06,	dSnare,	$02,	nRst,	$0A,	dKick,	$02
	dc.b		nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06
	dc.b		dSnare,	$02,	nRst,	$0A,	dKick,	$02,	nRst,	dSnare
	dc.b		nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	dKick,	nRst,	$06,	dKick,	$02,	nRst,	dSnare
	dc.b		nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	$0A,	dKick,	$02,	nRst,	dSnare,	nRst,	$06
	dc.b		dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst,	$0A
	dc.b		dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02
	dc.b		nRst,	$06,	dSnare,	$02,	nRst,	$0A,	dKick,	$02
	dc.b		nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06
	dc.b		dSnare,	$02,	nRst,	dKick,	nRst,	$06,	dKick,	$02
	dc.b		nRst,	dSnare,	nRst,	$06,	$96,	$08,	dSnare,	$02
	dc.b		nRst,	$0A,	dKick,	$02,	nRst,	dSnare,	nRst,	$06
	dc.b		dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst,	$0A
	dc.b		dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02
	dc.b		nRst,	$06,	dSnare,	$02,	nRst,	$0A,	dKick,	$02
	dc.b		nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06
	dc.b		dSnare,	$02,	nRst,	dKick,	nRst,	$06,	dKick,	$02
	dc.b		nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06
	dc.b		dSnare,	$02,	nRst,	$0A,	dKick,	$02,	nRst,	dSnare
	dc.b		nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	$0A,	dKick,	$02,	nRst,	dSnare,	nRst,	$06
	dc.b		dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst,	$0A
	dc.b		dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02
	dc.b		nRst,	$06,	dSnare,	$02,	nRst,	dKick,	nRst,	$06
	dc.b		dKick,	$02,	nRst,	dSnare,	nRst,	$06
Wave_Ocean__the_Inlet_Jump09:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$96,	$08,	dSnare,	$02,	nRst,	$0A,	dKick,	$02
	dc.b		nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06
	dc.b		dSnare,	$02,	nRst,	$0A,	dKick,	$02,	nRst,	dSnare
	dc.b		nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	$0A,	dKick,	$02,	nRst,	dSnare,	nRst,	$06
	dc.b		dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst,	dKick
	dc.b		nRst,	$06,	dKick,	$02,	nRst,	dSnare,	nRst,	$06
	dc.b		dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst,	$0A
	dc.b		dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02
	dc.b		nRst,	$06,	dSnare,	$02,	nRst,	$0A,	dKick,	$02
	dc.b		nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06
	dc.b		dSnare,	$02,	nRst,	$0A,	dKick,	$02,	nRst,	dSnare
	dc.b		nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	dKick,	nRst,	$06,	dKick,	$02,	nRst,	dSnare
	dc.b		nRst,	$06,	$96,	$08,	dSnare,	$02,	nRst,	$0A
	dc.b		dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02
	dc.b		nRst,	$06,	dSnare,	$02,	nRst,	$0A,	dKick,	$02
	dc.b		nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06
	dc.b		dSnare,	$02,	nRst,	$0A,	dKick,	$02,	nRst,	dSnare
	dc.b		nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	dKick,	nRst,	$06,	dKick,	$02,	nRst,	dSnare
	dc.b		nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	$0A,	dKick,	$02,	nRst,	dSnare,	nRst,	$06
	dc.b		dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst,	$0A
	dc.b		dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02
	dc.b		nRst,	$06,	dSnare,	$02,	nRst,	$0A,	dKick,	$02
	dc.b		nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06
	dc.b		dSnare,	$02,	nRst,	dKick,	nRst,	$06,	dKick,	$02
	dc.b		nRst,	dSnare,	nRst,	$06,	$96,	$08,	dSnare,	$02
	dc.b		nRst,	$0A,	dKick,	$02,	nRst,	dSnare,	nRst,	$06
	dc.b		dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst,	$0A
	dc.b		dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02
	dc.b		nRst,	$06,	dSnare,	$02,	nRst,	$0A,	dKick,	$02
	dc.b		nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06
	dc.b		dSnare,	$02,	nRst,	dKick,	nRst,	$06,	dKick,	$02
	dc.b		nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06
	dc.b		dSnare,	$02,	nRst,	$0A,	dKick,	$02,	nRst,	dSnare
	dc.b		nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	$0A,	dKick,	$02,	nRst,	dSnare,	nRst,	$06
	dc.b		dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst,	$0A
	dc.b		dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02
	dc.b		nRst,	$06,	dSnare,	$02,	nRst,	dKick,	nRst,	$06
	dc.b		dKick,	$02,	nRst,	dSnare,	nRst,	$06,	$96,	$08
	dc.b		dSnare,	$02,	nRst,	$0A,	dKick,	$02,	nRst,	dSnare
	dc.b		nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	$0A,	dKick,	$02,	nRst,	dSnare,	nRst,	$06
	dc.b		dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst,	$0A
	dc.b		dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02
	dc.b		nRst,	$06,	dSnare,	$02,	nRst,	dKick,	nRst,	$06
	dc.b		dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02
	dc.b		nRst,	$06,	dSnare,	$02,	nRst,	$0A,	dKick,	$02
	dc.b		nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06
	dc.b		dSnare,	$02,	nRst,	$0A,	dKick,	$02,	nRst,	dSnare
	dc.b		nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	$0A,	dKick,	$02,	nRst,	dSnare,	nRst,	$06
	dc.b		dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst,	dKick
	dc.b		nRst,	$06,	dKick,	$02,	nRst,	dSnare,	nRst,	$06
	dc.b		$96,	$08,	dSnare,	$02,	nRst,	$0A,	dKick,	$02
	dc.b		nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06
	dc.b		dSnare,	$02,	nRst,	$0A,	dKick,	$02,	nRst,	dSnare
	dc.b		nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	$0A,	dKick,	$02,	nRst,	dSnare,	nRst,	$06
	dc.b		dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst,	dKick
	dc.b		nRst,	$06,	dKick,	$02,	nRst,	dSnare,	nRst,	$06
	dc.b		dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst,	$0A
	dc.b		dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02
	dc.b		nRst,	$06,	dSnare,	$02,	nRst,	$0A,	dKick,	$02
	dc.b		nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06
	dc.b		dSnare,	$02,	nRst,	$0A,	dKick,	$02,	nRst,	dSnare
	dc.b		nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	dKick,	nRst,	$06,	dKick,	$02,	nRst,	dSnare
	dc.b		nRst,	$06,	$96,	$08,	dSnare,	$02,	nRst,	$0A
	dc.b		dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02
	dc.b		nRst,	$06,	dSnare,	$02,	nRst,	$0A,	dKick,	$02
	dc.b		nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06
	dc.b		dSnare,	$02,	nRst,	$0A,	dKick,	$02,	nRst,	dSnare
	dc.b		nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	dKick,	nRst,	$06,	dKick,	$02,	nRst,	dSnare
	dc.b		nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	$0A,	dKick,	$02,	nRst,	dSnare,	nRst,	$06
	dc.b		dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst,	$0A
	dc.b		dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02
	dc.b		nRst,	$06,	dSnare,	$02,	nRst,	$0A,	dKick,	$02
	dc.b		nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06
	dc.b		dSnare,	$02,	nRst,	dKick,	nRst,	$06,	dKick,	$02
	dc.b		nRst,	dSnare,	nRst,	$06,	$96,	$7F,	nRst,	$01
	dc.b		$96,	$7F,	nRst,	$11,	dSnare,	$02,	$02,	$02
	dc.b		$02,	$02,	$02,	$02,	$02,	$96,	$08,	dSnare
	dc.b		$02,	nRst,	$0A,	dKick,	$02,	nRst,	dSnare,	nRst
	dc.b		$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst
	dc.b		$0A,	dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick
	dc.b		$02,	nRst,	$06,	dSnare,	$02,	nRst,	$0A,	dKick
	dc.b		$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst
	dc.b		$06,	dSnare,	$02,	nRst,	dKick,	nRst,	$06,	dKick
	dc.b		$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst
	dc.b		$06,	dSnare,	$02,	nRst,	$0A,	dKick,	$02,	nRst
	dc.b		dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare
	dc.b		$02,	nRst,	$0A,	dKick,	$02,	nRst,	dSnare,	nRst
	dc.b		$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst
	dc.b		$0A,	dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick
	dc.b		$02,	nRst,	$06,	dSnare,	$02,	nRst,	dKick,	nRst
	dc.b		$06,	dKick,	$02,	nRst,	dSnare,	nRst,	$06,	$96
	dc.b		$08,	dSnare,	$02,	nRst,	$0A,	dKick,	$02,	nRst
	dc.b		dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare
	dc.b		$02,	nRst,	$0A,	dKick,	$02,	nRst,	dSnare,	nRst
	dc.b		$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst
	dc.b		$0A,	dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick
	dc.b		$02,	nRst,	$06,	dSnare,	$02,	nRst,	dKick,	nRst
	dc.b		$06,	dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick
	dc.b		$02,	nRst,	$06,	dSnare,	$02,	nRst,	$0A,	dKick
	dc.b		$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst
	dc.b		$06,	dSnare,	$02,	nRst,	$0A,	dKick,	$02,	nRst
	dc.b		dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare
	dc.b		$02,	nRst,	$0A,	dKick,	$02,	nRst,	dSnare,	nRst
	dc.b		$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst
	dc.b		dKick,	nRst,	$06,	dKick,	$02,	nRst,	dSnare,	nRst
	dc.b		$06,	$96,	$08,	dSnare,	$02,	nRst,	$0A,	dKick
	dc.b		$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst
	dc.b		$06,	dSnare,	$02,	nRst,	$0A,	dKick,	$02,	nRst
	dc.b		dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare
	dc.b		$02,	nRst,	$0A,	dKick,	$02,	nRst,	dSnare,	nRst
	dc.b		$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst
	dc.b		dKick,	nRst,	$06,	dKick,	$02,	nRst,	dSnare,	nRst
	dc.b		$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst
	dc.b		$0A,	dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick
	dc.b		$02,	nRst,	$06,	dSnare,	$02,	nRst,	$0A,	dKick
	dc.b		$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst
	dc.b		$06,	dSnare,	$02,	nRst,	$0A,	dKick,	$02,	nRst
	dc.b		dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare
	dc.b		$02,	nRst,	dKick,	nRst,	$06,	dKick,	$02,	nRst
	dc.b		dSnare,	nRst,	$06,	$96,	$08,	dSnare,	$02,	nRst
	dc.b		$0A,	dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick
	dc.b		$02,	nRst,	$06,	dSnare,	$02,	nRst,	$0A,	dKick
	dc.b		$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst
	dc.b		$06,	dSnare,	$02,	nRst,	$0A,	dKick,	$02,	nRst
	dc.b		dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare
	dc.b		$02,	nRst,	dKick,	nRst,	$06,	dKick,	$02,	nRst
	dc.b		dSnare,	nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare
	dc.b		$02,	nRst,	$0A,	dKick,	$02,	nRst,	dSnare,	nRst
	dc.b		$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst
	dc.b		$0A,	dKick,	$02,	nRst,	dSnare,	nRst,	$06,	dKick
	dc.b		$02,	nRst,	$06,	dSnare,	$02,	nRst,	$0A,	dKick
	dc.b		$02,	nRst,	dSnare,	nRst,	$06,	dKick,	$02,	nRst
	dc.b		$06,	dSnare,	$02,	nRst,	dKick,	nRst,	$06,	dKick
	dc.b		$02,	nRst,	dSnare,	nRst,	$06,	$96,	$08,	dSnare
	dc.b		$02,	nRst,	$0A,	dKick,	$02,	nRst,	$06,	dSnare
	dc.b		$02,	nRst,	dKick,	nRst,	dKick,	nRst,	dSnare,	nRst
	dc.b		$0A,	dKick,	$02,	$02,	dSnare,	$02,	nRst,	$06
	dc.b		dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst,	$0A
	dc.b		dKick,	$02,	nRst,	$06,	dSnare,	$02,	nRst,	dKick
	dc.b		nRst,	dKick,	nRst,	dSnare,	nRst,	$0A,	dKick,	$02
	dc.b		$02,	dSnare,	$02,	nRst,	$06,	dKick,	$02,	nRst
	dc.b		$06,	dSnare,	$02,	nRst,	$0A,	dKick,	$02,	nRst
	dc.b		$06,	dSnare,	$02,	nRst,	dKick,	nRst,	dKick,	nRst
	dc.b		dSnare,	nRst,	$0A,	dKick,	$02,	$02,	dSnare,	$02
	dc.b		nRst,	$06,	dKick,	$02,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	$0A,	dKick,	$02,	nRst,	$06,	dSnare,	$02
	dc.b		nRst,	dKick,	nRst,	dKick,	nRst,	dSnare,	nRst,	$0A
	dc.b		dKick,	$02,	$02,	dSnare,	$02,	nRst,	$06
;	Jump To	 	location
	smpsJump	Wave_Ocean__the_Inlet_Jump09

Wave_Ocean__the_Inlet_Voices:
;	Voice 00
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

;	Voice 01
;	$39,$03,$61,$22,$21,$1F,$1F,$12,$1F,$05,$05,$05,$0B,$00,$00,$00,$00,$10,$10,$18,$18,$1E,$1D,$15,$00
;				#
	smpsVcAlgorithm		$01
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$02,	$02,	$06,	$00
	smpsVcCoarseFreq	$01,	$02,	$01,	$03
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$12,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0B,	$05,	$05,	$05
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$08,	$08,	$00,	$00
	smpsVcTotalLevel	$00,	$15,	$1D,	$1E

;	Voice 02
;	$2C,$74,$74,$34,$34,$1F,$12,$1F,$1F,$00,$00,$00,$00,$00,$01,$00,$01,$0F,$3F,$0F,$3F,$16,$80,$17,$84
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
	smpsVcTotalLevel	$84,	$17,	$80,	$16

;	Voice 03
;	$39,$0D,$01,$02,$01,$9F,$1F,$1F,$5F,$0A,$09,$09,$04,$08,$07,$07,$07,$24,$24,$24,$28,$22,$26,$24,$00
;				#
	smpsVcAlgorithm		$01
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$02,	$01,	$0D
	smpsVcRateScale		$01,	$00,	$00,	$02
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$04,	$09,	$09,	$0A
	smpsVcDecayRate2	$07,	$07,	$07,	$08
	smpsVcDecayLevel	$02,	$02,	$02,	$02
	smpsVcReleaseRate	$08,	$04,	$04,	$04
	smpsVcTotalLevel	$00,	$24,	$26,	$22

;	Voice 04
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
	even
