; =============================================================================================
; Project Name:		MM5_Wave_Man
; Created:		7th March 2011
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

MM5_Wave_Man_Header:
;	Voice Pointer	location
	smpsHeaderVoice	MM5_Wave_Man_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$03,	$06

;	DAC Pointer	location
	smpsHeaderDAC	MM5_Wave_Man_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	MM5_Wave_Man_FM1,	smpsPitch01lo,	$0E
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	MM5_Wave_Man_FM2,	smpsPitch00,	$0E
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	MM5_Wave_Man_FM3,	smpsPitch00,	$10
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	MM5_Wave_Man_FM4,	smpsPitch00,	$10
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	MM5_Wave_Man_FM5,	smpsPitch00,	$10
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	MM5_Wave_Man_PSG1,	smpsPitch03lo,	$00,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	MM5_Wave_Man_PSG2,	smpsPitch03lo,	$00,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	MM5_Wave_Man_PSG3,	smpsPitch02hi+$0B,	$02,	$00

; FM1 Data
MM5_Wave_Man_FM1:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nF5,	$06,	nE5,	$08,	nRst,	$02,	nE5,	$06
	dc.b		nD5,	$08,	nRst,	$02,	nE5,	$06,	nD5,	$08
	dc.b		nRst,	$02,	nD5,	$06,	nE5,	nF5,	$04,	nD5
	dc.b		$06,	nC5,	$26,	nRst,	$04,	nF5,	nRst,	$02
	dc.b		nF5,	$04,	nFs5,	$06,	nF5,	nE5,	$08,	nRst
	dc.b		$02,	nE5,	$06,	nD5,	$08,	nRst,	$02,	nE5
	dc.b		$06,	nD5,	$08,	nRst,	$02,	nD5,	$06,	nE5
	dc.b		nF5,	$04,	nD5,	$06,	nC5,	$26,	nRst,	$04
	dc.b		nF5,	nRst,	$02,	nF5,	$04,	nFs5,	$06
MM5_Wave_Man_Jump01:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nG4,	$04,	nBb4,	$02,	nD5,	nRst,	nG4,	nBb4
	dc.b		$04,	nE5,	$06,	nF5,	$22,	nG5,	$08,	nE5
	dc.b		$04,	nF5,	$02,	nE5,	$04,	nD5,	$06,	nC5
	dc.b		$04,	nD5,	$02,	nC5,	$2A,	nG4,	$04,	nBb4
	dc.b		$02,	nD5,	nRst,	nG4,	nBb4,	$04,	nE5,	$06
	dc.b		nF5,	$22,	nG5,	$08,	nE5,	$04,	nF5,	$02
	dc.b		nE5,	$04,	nD5,	$06,	nC5,	$08,	nA5,	$04
	dc.b		nG5,	$24,	nF5,	$06,	nE5,	$08,	nRst,	$02
	dc.b		nEb5,	$01,	nE5,	$05,	nD5,	$08,	nRst,	$02
	dc.b		nEb5,	$01,	nE5,	$05,	nD5,	$08,	nRst,	$02
	dc.b		nD5,	$06,	nE5,	nF5,	$04,	nD5,	$06,	nC5
	dc.b		$32,	nRst,	$08,	nF5,	$06,	nE5,	$08,	nRst
	dc.b		$02,	nEb5,	$01,	nE5,	$05,	nD5,	$08,	nRst
	dc.b		$02,	nEb5,	$01,	nE5,	$05,	nD5,	$08,	nRst
	dc.b		$02,	nD5,	$06,	nE5,	nF5,	$04,	nD5,	$20
	dc.b		nRst,	$04,	nG5,	nRst,	$02,	nG5,	$04,	nRst
	dc.b		$02,	nG5,	$04,	nRst,	$0C,	nFs5,	$20,	$06
	dc.b		nE5,	$06,	nFs5,	$04,	nG5,	$06,	nA5,	nB5
	dc.b		$04,	nE5,	$01,	nFs5,	$05,	nE5,	$32,	nRst
	dc.b		$08,	nFs5,	$20,	$06,	nE5,	$06,	nFs5,	$04
	dc.b		nG5,	$06,	nA5,	nB5,	$04,	nE5,	$01,	nFs5
	dc.b		$05,	nE5,	$12,	nCs6,	$04,	nB5,	$02,	nA5
	dc.b		$22,	nG5,	$0C,	$08,	nFs5,	$04,	nG5,	nA5
	dc.b		nFs5,	$06,	nD5,	nE5,	$02,	nD5,	$12,	nF5
	dc.b		$0C,	$08,	nE5,	$04,	nF5,	nG5,	nE5,	nE5
	dc.b		nRst,	$02,	nE5,	$04,	nRst,	$02,	nE5,	$04
	dc.b		nRst,	nA5,	nAb5,	$01,	nG5,	nE5,	nCs5
;	Jump To	 	location
	smpsJump	MM5_Wave_Man_Jump01

; FM2 Data
MM5_Wave_Man_FM2:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$05
	dc.b		nRst,	$06,	nRst,	$02,	nRst,	nRst,	nRst,	$04
	dc.b		nRst,	$06,	nRst,	$02,	nRst,	nRst,	nRst,	$04
	dc.b		nRst,	$06,	nRst,	$02,	nRst,	nRst,	nRst,	$04
	dc.b		nRst,	$06,	nRst,	$02,	nRst,	nRst,	nRst,	$04
	dc.b		nRst,	$06,	nRst,	$02,	nRst,	nRst,	nRst,	$04
	dc.b		nRst,	$06,	nRst,	$02,	nRst,	nRst,	nRst,	$04
	dc.b		nRst,	$06,	nRst,	$02,	nRst,	nRst,	nRst,	$04
	dc.b		nF2,	$06,	$02,	nRst,	$02,	nFs2,	nFs3,	$04
	dc.b		nG2,	$06,	nD3,	$02,	nRst,	nD3,	nD2,	$04
	dc.b		nG2,	$06,	nD3,	$02,	nRst,	nD3,	nD2,	$04
	dc.b		nG2,	$06,	nD3,	$02,	nRst,	nD3,	nD2,	$04
	dc.b		nG2,	$06,	nD3,	$02,	nRst,	nD3,	nD2,	$04
	dc.b		nF2,	$06,	nC3,	$02,	nRst,	nC3,	nC2,	$04
	dc.b		nF2,	$06,	nC3,	$02,	nRst,	nC3,	nC2,	$04
	dc.b		nF2,	$06,	nC3,	$02,	nRst,	nC3,	nC2,	$04
	dc.b		nF2,	$06,	$02,	nRst,	$02,	nFs2,	nFs3,	$04
MM5_Wave_Man_Jump02:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$05
	dc.b		nG2,	$06,	nD3,	$02,	nRst,	nD3,	nD2,	$04
	dc.b		nG2,	$06,	nD3,	$02,	nRst,	nD3,	nD2,	$04
	dc.b		nG2,	$06,	nD3,	$02,	nRst,	nD3,	nD2,	$04
	dc.b		nG2,	$06,	nD3,	$02,	nRst,	nD3,	nD2,	$04
	dc.b		nF2,	$06,	nC3,	$02,	nRst,	nC3,	nC2,	$04
	dc.b		nF2,	$06,	nC3,	$02,	nRst,	nC3,	nC2,	$04
	dc.b		nF2,	$06,	nC3,	$02,	nRst,	nC3,	nC2,	$04
	dc.b		nF2,	$06,	$02,	nRst,	$02,	nFs2,	nFs3,	$04
	dc.b		nG2,	$06,	nD3,	$02,	nRst,	nD3,	nD2,	$04
	dc.b		nG2,	$06,	nD3,	$02,	nRst,	nD3,	nD2,	$04
	dc.b		nG2,	$06,	nD3,	$02,	nRst,	nD3,	nD2,	$04
	dc.b		nG2,	$06,	nD3,	$02,	nRst,	nD3,	nD2,	$04
	dc.b		nC3,	$06,	nG3,	$02,	nRst,	nG3,	nG2,	$04
	dc.b		nC3,	$06,	nG3,	$02,	nRst,	nG3,	nG2,	$04
	dc.b		nC3,	nC3,	nRst,	$02,	nC3,	$04,	nRst,	$02
	dc.b		nC3,	$04,	nRst,	$02,	nC3,	$04,	nB2,	$02
	dc.b		nBb2,	$04,	$06,	nF3,	$02,	nRst,	nF3,	nF2
	dc.b		$04,	nBb2,	$06,	nF3,	$02,	nRst,	nF3,	nF2
	dc.b		$04,	nBb2,	$06,	nF3,	$02,	nRst,	nF3,	nF2
	dc.b		$04,	nBb2,	$06,	nF3,	$02,	nRst,	nF3,	nF2
	dc.b		$04,	nA2,	$06,	nE3,	$02,	nRst,	nE3,	nE2
	dc.b		$04,	nA2,	$06,	nE3,	$02,	nRst,	nE3,	nE2
	dc.b		$04,	nA2,	$06,	nE3,	$02,	nRst,	nE3,	nE2
	dc.b		$04,	nA2,	$06,	$02,	nRst,	$02,	nA2,	nA3
	dc.b		$04,	nBb2,	$06,	nF3,	$02,	nRst,	nF3,	nF2
	dc.b		$04,	nBb2,	$06,	nF3,	$02,	nRst,	nF3,	nF2
	dc.b		$04,	nBb2,	$06,	nF3,	$02,	nRst,	nF3,	nF2
	dc.b		$04,	nBb2,	$06,	nF3,	$02,	nRst,	nF3,	nF2
	dc.b		$04,	nD2,	$06,	nA2,	$02,	nRst,	nA2,	nA1
	dc.b		$04,	nD2,	$06,	nA2,	$02,	nRst,	nA2,	nA1
	dc.b		$04,	nG2,	nRst,	$02,	nG2,	nRst,	nG2,	nRst
	dc.b		$04,	nG2,	$02,	nRst,	$06,	nG1,	$01,	nAb1
	dc.b		nA1,	nBb1,	nC2,	nCs2,	nD2,	nEb2,	nE2,	$06
	dc.b		$04,	nRst,	$02,	nB2,	$04,	nE2,	$06,	$04
	dc.b		nRst,	$02,	nB2,	$04,	nE2,	$06,	$04,	nRst
	dc.b		$02,	nB2,	$04,	nE2,	$06,	$04,	nRst,	$02
	dc.b		nB2,	$04,	nA2,	$06,	$04,	nRst,	$02,	nE3
	dc.b		$04,	nA2,	$06,	$04,	nRst,	$02,	nE3,	$04
	dc.b		nA2,	$06,	$04,	nRst,	$02,	nE3,	$04,	nA2
	dc.b		$06,	nAb2,	nG2,	$04,	nE2,	$06,	$04,	nRst
	dc.b		$02,	nB2,	$04,	nE2,	$06,	$04,	nRst,	$02
	dc.b		nB2,	$04,	nE2,	$06,	$04,	nRst,	$02,	nB2
	dc.b		$04,	nE2,	$06,	$04,	nRst,	$02,	nB2,	$04
	dc.b		nA2,	$06,	$04,	nRst,	$02,	nE3,	$04,	nA2
	dc.b		$06,	$04,	nRst,	$02,	nE3,	$04,	nA2,	$06
	dc.b		$04,	nRst,	$02,	nE3,	$04,	nA2,	$06,	nAb2
	dc.b		nG2,	$04,	nD2,	$06,	$04,	nRst,	$02,	nA2
	dc.b		$04,	nD2,	$06,	$04,	nRst,	$02,	nA2,	$04
	dc.b		nG2,	$06,	$04,	nRst,	$02,	nD3,	$04,	nG2
	dc.b		$06,	$04,	nRst,	$02,	nD3,	$04,	nC2,	$06
	dc.b		$04,	nRst,	$02,	nG2,	$04,	nC2,	$06,	$04
	dc.b		nRst,	$02,	nG2,	$04,	nA2,	nA2,	nRst,	$02
	dc.b		nA2,	$04,	nRst,	$02,	nA2,	$04,	nRst,	nD2
	dc.b		$08
;	Jump To	 	location
	smpsJump	MM5_Wave_Man_Jump02

; FM3 Data
MM5_Wave_Man_FM3:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		nD4,	$06,	nC4,	$08,	nRst,	$02,	nC4,	$06
	dc.b		nBb3,	$08,	nRst,	$02,	nC4,	$06,	nBb3,	$08
	dc.b		nRst,	$02,	nBb3,	$06,	nC4,	nD4,	$04,	nBb3
	dc.b		$06,	nG3,	$04,	$02,	nA3,	$04,	nG3,	$06
	dc.b		nE3,	nF3,	$04,	nG3,	$06,	nC3,	nC3,	$04
	dc.b		nC4,	nA3,	$02,	nC4,	$04,	nCs4,	$06,	nD4
	dc.b		nC4,	$08,	nRst,	$02,	nC4,	$06,	nBb3,	$08
	dc.b		nRst,	$02,	nC4,	$06,	nBb3,	$08,	nRst,	$02
	dc.b		nBb3,	$06,	nC4,	nD4,	$04,	nBb3,	$06,	nG3
	dc.b		$04,	$02,	nA3,	$04,	nG3,	$06,	nE3,	nF3
	dc.b		$04,	nG3,	$06,	nC3,	nC3,	$04,	nC4,	nA3
	dc.b		$02,	nC4,	$04,	nCs4,	$06
MM5_Wave_Man_Jump03:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nBb3,	$04,	nG3,	$02,	$02,	nRst,	$02,	nBb3
	dc.b		$06,	nC4,	$04,	nG3,	$02,	nD4,	$06,	nG3
	dc.b		$04,	nG4,	$02,	nD4,	nF4,	nBb4,	nD4,	nF4
	dc.b		nC5,	nD4,	nF4,	nBb4,	nD4,	nF4,	nD5,	nD4
	dc.b		nG4,	nD4,	nA3,	$04,	nF3,	$02,	$02,	nRst
	dc.b		$02,	nG3,	$06,	nA3,	$04,	nC3,	$02,	$06
	dc.b		nRst,	$04,	nF4,	$02,	nC4,	nF4,	nG4,	nC4
	dc.b		nF4,	nA4,	nC4,	nF4,	nF4,	nC4,	nF4,	$04
	dc.b		nFs4,	$06,	nBb3,	$04,	nG3,	$02,	$02,	nRst
	dc.b		$02,	nBb3,	$06,	nC4,	$04,	nG3,	$02,	nD4
	dc.b		$06,	nG3,	$04,	nG4,	$02,	nD4,	nF4,	nBb4
	dc.b		nD4,	nF4,	nC5,	nD4,	nF4,	nBb4,	nD4,	nF4
	dc.b		nD5,	nD4,	nG4,	nD4,	nC4,	$04,	nG3,	$02
	dc.b		$02,	nRst,	$02,	nD4,	$06,	nC4,	$04,	nG3
	dc.b		$02,	$06,	nRst,	$04,	nC4,	nG4,	$02,	nC5
	dc.b		nRst,	nC5,	nRst,	$04,	nC5,	$02,	nRst,	$04
	dc.b		nE4,	nEb4,	$02,	nD4,	$04,	nD5,	$06,	nC5
	dc.b		$08,	nRst,	$02,	nB4,	$01,	nC5,	$05,	nBb4
	dc.b		$08,	nRst,	$02,	nB4,	$01,	nC5,	$05,	nBb4
	dc.b		$06,	nA3,	$04,	nBb3,	$08,	nF4,	nA4,	nA3
	dc.b		nC4,	nE4,	nG4,	nA4,	nBb4,	nA4,	nD5,	$06
	dc.b		nC5,	$08,	nRst,	$02,	nB4,	$01,	nC5,	$05
	dc.b		nBb4,	$08,	nRst,	$02,	nB4,	$01,	nC5,	$05
	dc.b		nBb4,	$06,	nA3,	$04,	nBb3,	$08,	nF4,	nC5
	dc.b		nD4,	nFs4,	nA4,	nG4,	$04,	nD5,	nRst,	$02
	dc.b		nD5,	$04,	nRst,	$02,	nD5,	$04,	nCs5,	$01
	dc.b		nC5,	nA4,	nFs4,	nEb4,	nRst,	$07,	nB4,	$04
	dc.b		nE4,	$02,	nG4,	$04,	nE4,	$02,	nD5,	$04
	dc.b		nB4,	nE4,	nG4,	nD5,	nB4,	nE4,	$02,	nG4
	dc.b		$04,	nE4,	$02,	nD5,	$04,	nB4,	nE4,	nG4
	dc.b		nD5,	nCs5,	nE4,	$02,	nG4,	$04,	nE4,	$02
	dc.b		nD5,	$04,	nCs5,	nE4,	nA4,	nE4,	nCs5,	nE4
	dc.b		$02,	nG4,	$04,	nE4,	$02,	nD5,	$04,	nCs5
	dc.b		nE4,	nA4,	nE4,	nB4,	nE4,	$02,	nG4,	$04
	dc.b		nE4,	$02,	nD5,	$04,	nB4,	nE4,	nG4,	nD5
	dc.b		nB4,	nE4,	$02,	nG4,	$04,	nE4,	$02,	nD5
	dc.b		$04,	nB4,	nE4,	nG4,	nD5,	nCs5,	nE4,	$02
	dc.b		nG4,	$04,	nE4,	$02,	nD5,	$04,	nCs5,	nE4
	dc.b		nA4,	nE4,	nCs5,	nE4,	$02,	nG4,	$04,	nE4
	dc.b		$02,	nD5,	$04,	nCs5,	nE4,	nA4,	nE4,	nG4
	dc.b		$02,	nG3,	$04,	nA3,	nC4,	$06,	nE4,	nG4
	dc.b		nC5,	$04,	nB4,	$02,	nB3,	$04,	nD4,	nE4
	dc.b		$06,	nG4,	nA4,	nB4,	$04,	nBb4,	$02,	nBb3
	dc.b		$04,	nC4,	nE4,	$06,	nG4,	nA4,	nBb4,	$04
	dc.b		nA4,	nA4,	nRst,	$02,	nA4,	$04,	nRst,	$02
	dc.b		nA4,	$04,	nRst,	nFs4,	$08
;	Jump To	 	location
	smpsJump	MM5_Wave_Man_Jump03

; FM4 Data
MM5_Wave_Man_FM4:
	dc.b		nRst,	$7F,	$7F,	$03
	smpsStop

; FM5 Data
MM5_Wave_Man_FM5:
	dc.b		nRst,	$7F,	$7F,	$03
	smpsStop

; PSG1 Data
MM5_Wave_Man_PSG1:
	dc.b		nRst,	$7F,	$7F,	$03
	smpsStop

; PSG2 Data
MM5_Wave_Man_PSG2:
	dc.b		nRst,	$7F,	$7F,	$03
	smpsStop

; PSG3 Data
MM5_Wave_Man_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$02,	$02,	$02,	$02,	$02,	$02,	$02
	dc.b		$02,	$02,	$02,	$02,	$02,	$02,	$02,	$02
	dc.b		$02,	$02,	$02,	$02,	$02,	$02,	$02,	$02
	dc.b		$02,	$02,	$02,	$02,	$02,	$02,	$02,	$02
	dc.b		$02,	$02,	$02,	$02,	$02,	$02,	$02,	$02
	dc.b		$02,	$02,	$02,	$02,	$02,	$02,	$02,	$02
	dc.b		$02,	$02,	$02,	$02,	$02,	$02,	$02,	$02
	dc.b		$02,	$02,	$02,	$02,	$02,	$02,	$02,	$02
	dc.b		$02,	$02,	$02,	$02,	$02,	$02,	$02,	$02
	dc.b		$02,	$02,	$02,	$02,	$02,	$02,	$02,	$02
	dc.b		$02,	$02,	$02,	$02,	$02,	$02,	$02,	$02
	dc.b		$02,	$02,	$02,	$02,	$02,	$02,	$02,	$02
	dc.b		$02,	$02,	$02,	$02,	$02,	$02,	$02,	$02
	dc.b		$02,	$02,	$02,	$02,	$02,	$02,	$02,	$02
	dc.b		$02,	$02,	$02,	$02,	$02,	$02,	$02,	$02
	dc.b		$02,	$02,	$02,	$02,	$02,	$02,	$02,	$02
	dc.b		$04
;	Set PSG WvForm	#
	smpsPSGform	$E7
MM5_Wave_Man_Jump04:
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$02,	$06,	$02,	$02,	$04,	$02,	$06
	dc.b		$02,	$02,	$04,	$02,	$06,	$02,	$02,	$04
	dc.b		$02,	$06,	$02,	$02,	$04,	$02,	$06,	$02
	dc.b		$02,	$04,	$02,	$06,	$02,	$02,	$04,	$02
	dc.b		$06,	$02,	$02,	$04,	$02,	$04,	$04,	$02
	dc.b		$04
;	Jump To	 	location
	smpsJump	MM5_Wave_Man_Jump04

; DAC Data
MM5_Wave_Man_DAC:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nRst,	$06,	$02,	$84,	$08,	nRst,	$06,	$02
	dc.b		$84,	$08,	nRst,	$06,	$02,	$84,	$08,	nRst
	dc.b		$06,	$02,	$84,	$08,	nRst,	$06,	$02,	$84
	dc.b		$08,	nRst,	$06,	$02,	$84,	$08,	nRst,	$06
	dc.b		$02,	$84,	$06,	dKick,	$02,	dSnare,	$04,	dSnare
	dc.b		$02,	dSnare,	$04,	$02,	$04,	dKick2,	$06,	dKick
	dc.b		$02,	dSnare,	$08,	dKick,	$06,	$02,	dSnare,	$08
	dc.b		dKick,	$06,	$02,	dSnare,	$08,	dKick,	$06,	$02
	dc.b		dSnare,	$08,	dKick,	$06,	$02,	dSnare,	$08,	dKick
	dc.b		$06,	$02,	dSnare,	$08,	dKick,	$06,	$02,	dSnare
	dc.b		$06,	dKick,	$02,	dSnare,	$04,	$02,	$04,	$02
	dc.b		$04
MM5_Wave_Man_Jump05:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dKick2,	$06,	dKick,	$02,	dSnare,	$08,	dKick,	$06
	dc.b		$02,	dSnare,	$08,	dKick,	$06,	$02,	dSnare,	$08
	dc.b		dKick,	$06,	$02,	dSnare,	$08,	dKick,	$06,	$02
	dc.b		dSnare,	$08,	dKick,	$06,	$02,	dSnare,	$08,	dKick
	dc.b		$06,	$02,	dSnare,	$08,	dKick,	$06,	dSnare,	$04
	dc.b		$06,	dKick2,	$06,	dKick,	$02,	dSnare,	$08,	dKick
	dc.b		$06,	$02,	dSnare,	$08,	dKick,	$06,	$02,	dSnare
	dc.b		$08,	dKick,	$06,	$02,	dSnare,	$08,	dKick,	$06
	dc.b		$02,	dSnare,	$08,	dKick,	$06,	$02,	dSnare,	$08
	dc.b		dKick,	$04,	dSnare,	$02,	$02,	$02,	$02,	dKick
	dc.b		$02,	$02,	dSnare,	$04,	$02,	$04,	$02,	$04
	dc.b		dKick2,	$06,	dKick,	$02,	dSnare,	$08,	dKick,	$06
	dc.b		$02,	dSnare,	$08,	dKick,	$06,	$02,	dSnare,	$08
	dc.b		dKick,	$06,	$02,	dSnare,	$08,	dKick,	$06,	$02
	dc.b		dSnare,	$08,	dKick,	$06,	$02,	dSnare,	$08,	dKick
	dc.b		$06,	$02,	dSnare,	$08,	dKick,	$04,	dSnare,	$02
	dc.b		$04,	$02,	$04,	dKick2,	$06,	dKick,	$02,	dSnare
	dc.b		$08,	dKick,	$06,	$02,	dSnare,	$08,	dKick,	$06
	dc.b		$02,	dSnare,	$08,	dKick,	$06,	$02,	dSnare,	$08
	dc.b		dKick,	$06,	$02,	dSnare,	$08,	dKick,	$06,	$02
	dc.b		dSnare,	$08,	dKick,	$04,	dSnare,	$02,	dKick,	$04
	dc.b		dSnare,	$02,	dKick,	$04,	dSnare,	$06,	$02,	$02
	dc.b		$02,	$02,	$02,	dKick2,	$06,	dKick,	$02,	dSnare
	dc.b		$08,	dKick,	$06,	$02,	dSnare,	$08,	dKick,	$06
	dc.b		$02,	dSnare,	$08,	dKick,	$06,	$02,	dSnare,	$08
	dc.b		dKick,	$06,	$02,	dSnare,	$08,	dKick,	$06,	$02
	dc.b		dSnare,	$08,	dKick,	$06,	$02,	dSnare,	$08,	dKick
	dc.b		$06,	$02,	dSnare,	$08,	dKick,	$06,	$02,	dSnare
	dc.b		$08,	dKick,	$06,	$02,	dSnare,	$08,	dKick,	$06
	dc.b		$02,	dSnare,	$08,	dKick,	$06,	$02,	dSnare,	$08
	dc.b		dKick,	$06,	$02,	dSnare,	$08,	dKick,	$06,	$02
	dc.b		dSnare,	$08,	dKick,	$06,	$02,	dSnare,	$08,	dKick
	dc.b		$06,	$02,	dSnare,	$08,	dKick2,	$06,	dKick,	$02
	dc.b		dSnare,	$08,	dKick,	$06,	$02,	dSnare,	$08,	dKick
	dc.b		$06,	$02,	dSnare,	$08,	dKick,	$06,	$02,	dSnare
	dc.b		$08,	dKick,	$06,	$02,	dSnare,	$08,	dKick,	$06
	dc.b		$02,	dSnare,	$08,	dKick,	$04,	dSnare,	$02,	$02
	dc.b		$02,	$02,	dKick,	$02,	$02,	dSnare,	$04,	dKick
	dc.b		$02,	$02,	dSnare,	$02,	dKick,	dSnare,	dSnare
;	Jump To	 	location
	smpsJump	MM5_Wave_Man_Jump05

MM5_Wave_Man_Voices:
	dc.b		$38,$01,$02,$02,$02,$1C,$10,$10,$11,$10,$0E,$01,$01,$0D,$13,$01
	dc.b		$01,$2F,$FF,$1F,$1F,$1D,$32,$2B,$00;			Voice 00
	dc.b		$28,$36,$03,$00,$01,$DF,$DC,$DD,$DF,$06,$09,$02,$05,$06,$04,$01
	dc.b		$00,$23,$33,$13,$08,$19,$20,$20,$00;			Voice 01
	dc.b		$34,$22,$02,$02,$22,$1A,$10,$1A,$18,$10,$0C,$0C,$10,$00,$00,$00
	dc.b		$00,$08,$08,$08,$08,$13,$18,$18,$09;			Voice 02
	dc.b		$34,$72,$31,$32,$71,$1F,$15,$1F,$14,$19,$0D,$11,$11,$00,$00,$00
	dc.b		$00,$03,$07,$03,$07,$14,$10,$20,$00;			Voice 03
	dc.b		$02,$73,$34,$72,$31,$5B,$19,$9F,$50,$0D,$0B,$8B,$00,$00,$00,$00
	dc.b		$00,$29,$96,$15,$08,$21,$13,$23,$04;			Voice 04
	dc.b		$13,$66,$40,$40,$31,$1F,$1F,$1F,$1F,$12,$05,$02,$01,$01,$00,$04
	dc.b		$06,$AA,$6A,$16,$1A,$1A,$19,$2C,$80;			Voice 05
	even
