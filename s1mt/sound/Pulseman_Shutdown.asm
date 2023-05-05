; =============================================================================================
; Project Name:		Pulseman_Shutdown
; Created:		17th January 2014
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

Pulseman_Shutdown_Header:
;	Voice Pointer	location
	smpsHeaderVoice	Pulseman_Shutdown_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$02,	$05

;	DAC Pointer	location
	smpsHeaderDAC	Pulseman_Shutdown_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	Pulseman_Shutdown_FM1,	smpsPitch00+$02,	$14
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	Pulseman_Shutdown_FM2,	smpsPitch00+$02,	$14
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	Pulseman_Shutdown_FM3,	smpsPitch00+$02,	$14
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	Pulseman_Shutdown_FM4,	smpsPitch00+$02,	$14
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	Pulseman_Shutdown_FM5,	smpsPitch00+$02,	$14
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Pulseman_Shutdown_PSG1,	smpsPitch02lo+$0A,	$08,	$101
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Pulseman_Shutdown_PSG2,	smpsPitch02lo+$0A,	$08,	$101
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Pulseman_Shutdown_PSG3,	smpsPitch00,	$06,	$02

; FM1 Data
Pulseman_Shutdown_FM1:
;	Set FM Voice	#
	smpsFMvoice	$00
;	Alter Notes	value
	smpsAlterNote	$04
	dc.b		nRst,	$1C,	nRst,	$20,	nRst,	nRst,	nC2,	$04
	dc.b		nC3,	nC2,	nCs3,	nC2,	nC3,	nC2,	nBb2,	nC2
	dc.b		nC3,	nC2,	nCs3,	nC2,	nC3,	nC2,	nEb3,	nC2
	dc.b		nC3,	nC2,	nCs3,	nC2,	nC3,	nC2,	nBb2,	nC2
	dc.b		nC3,	nC2,	nCs3,	nC2,	nC3,	nC2,	nEb3,	nC2
	dc.b		nC3,	nC2,	nCs3,	nC2,	nC3,	nC2,	nBb2,	nC2
	dc.b		nC3,	nC2,	nCs3,	nC2,	nC3,	nC2,	nEb3,	nC2
	dc.b		nC3,	nC2,	nCs3,	nC2,	nC3,	nC2,	nBb2,	nC2
	dc.b		nC3,	nC2,	nCs3,	nC2,	nC3,	nC3,	nEb3
Pulseman_Shutdown_Jump01:
	dc.b		nF2,	nF3,	nF2,	nFs3,	nF2,	nF3,	nF2,	nEb3
	dc.b		nF2,	nF3,	nF2,	nFs3,	nF2,	nF3,	nF2,	nAb3
	dc.b		nF2,	nF3,	nF2,	nFs3,	nF2,	nF3,	nF2,	nEb3
	dc.b		nF2,	nF3,	nF2,	nFs3,	nF2,	nAb3,	nAb3,	nFs3
	dc.b		nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC2,	nBb2
	dc.b		nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC2,	nEb3
	dc.b		nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC2,	nBb2
	dc.b		nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC3,	nEb3
	dc.b		nC2,	$04,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC2
	dc.b		nBb2,	nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC2
	dc.b		nEb3,	nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC2
	dc.b		nBb2,	nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC2
	dc.b		nEb3,	nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC2
	dc.b		nBb2,	nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC2
	dc.b		nEb3,	nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC2
	dc.b		nBb2,	nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC3
	dc.b		nEb3,	nF2,	nF3,	nF2,	nFs3,	nF2,	nF3,	nF2
	dc.b		nEb3,	nF2,	nF3,	nF2,	nFs3,	nF2,	nF3,	nF2
	dc.b		nAb3,	nF2,	nF3,	nF2,	nFs3,	nF2,	nF3,	nF2
	dc.b		nEb3,	nF2,	nF3,	nF2,	nFs3,	nF2,	nAb3,	nF2
	dc.b		nFs3,	nF2,	nF3,	nF2,	nFs3,	nF2,	nF3,	nF2
	dc.b		nEb3,	nF2,	nF3,	nF2,	nFs3,	nF2,	nF3,	nF2
	dc.b		nAb3,	nF2,	nF3,	nF2,	nFs3,	nF2,	nF3,	nF2
	dc.b		nEb3,	nF2,	nF3,	nF2,	nFs3,	nF2,	nAb3,	nAb3
	dc.b		nFs3,	nC2,	$04,	nC3,	nC2,	nCs3,	nRst,	$08
	dc.b		nC2,	$04,	nC3,	nC2,	nCs3,	nRst,	$08,	nC2
	dc.b		$04,	nEb3,	nCs3,	nCs3,	nC2,	nC3,	nC2,	nCs3
	dc.b		nRst,	$08,	nC2,	$04,	nC3,	nC2,	nCs3,	nRst
	dc.b		$08,	nC2,	$04,	nEb3,	nC3,	nCs3,	nC2,	nC3
	dc.b		nC2,	nCs3,	nRst,	$08,	nC2,	$04,	nC3,	nC2
	dc.b		nCs3,	nRst,	$08,	nC2,	$04,	nEb3,	nCs3,	nB2
	dc.b		nC2,	nC3,	nC2,	nCs3,	nC2,	$08,	nC2,	$04
	dc.b		nC3,	nC2,	nCs3,	nC2,	$08,	nC2,	$04,	nEb3
	dc.b		nEb3,	nCs3,	nRst,	$20,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nC2,	$04,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nBb2,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nEb3,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nBb2,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nEb3,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nBb2,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nEb3,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nBb2,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nEb3,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nBb2,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nEb3,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nBb2,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC3,	nEb3
;	Jump To	 	location
	smpsJump	Pulseman_Shutdown_Jump01

; FM2 Data
Pulseman_Shutdown_FM2:
;	Set FM Voice	#
	smpsFMvoice	$05
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nRst,	$1C,	nRst,	$20,	nG1,	$02,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nRst,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nRst,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nRst,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nRst,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nRst,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1
Pulseman_Shutdown_Jump02:
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nG1
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nG1
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nG1
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nG1
	dc.b		nG1,	$02,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	$02,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1
;	Jump To	 	location
	smpsJump	Pulseman_Shutdown_Jump02

; FM3 Data
Pulseman_Shutdown_FM3:
	dc.b		nRst,	$1C,	nRst,	$20,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	nRst,	nRst
Pulseman_Shutdown_Jump03:
	dc.b		nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
;	Set FM Voice	#
	smpsFMvoice	$02
;	Alter Notes	value
	smpsAlterNote	$FE
	dc.b		nC4,	$02,	nG3,	nC4,	nG3,	nC4,	nG3,	nC4
	dc.b		nG3,	nC4,	nG3,	nC4,	nG3,	nC4,	nG3,	nC4
	dc.b		nG3,	nCs4,	nAb3,	nCs4,	nAb3,	nCs4,	nAb3,	nCs4
	dc.b		nAb3,	nEb4,	nAb3,	nEb4,	nAb3,	nCs4,	nAb3,	nCs4
	dc.b		nAb3,	nC4,	nG3,	nC4,	nG3,	nC4,	nG3,	nC4
	dc.b		nG3,	nC4,	nG3,	nC4,	nG3,	nC4,	nG3,	nC4
	dc.b		nG3,	nB3,	nFs3,	nB3,	nFs3,	nB3,	nFs3,	nB3
	dc.b		nFs3,	nB3,	nFs3,	nB3,	nFs3,	nB3,	nFs3,	nB3
	dc.b		nFs3,	nC4,	nG3,	nC4,	nG3,	nC4,	nG3,	nC4
	dc.b		nG3,	nC4,	nG3,	nC4,	nG3,	nC4,	nG3,	nC4
	dc.b		nG3,	nCs4,	nAb3,	nCs4,	nAb3,	nCs4,	nAb3,	nCs4
	dc.b		nAb3,	nEb4,	nAb3,	nEb4,	nAb3,	nCs4,	nAb3,	nCs4
	dc.b		nAb3,	nD4,	nA3,	nD4,	nA3,	nD4,	nA3,	nD4
	dc.b		nA3,	nD4,	nA3,	nD4,	nA3,	nD4,	nA3,	nD4
	dc.b		nA3,	nEb4,	nBb3,	nEb4,	nBb3,	nEb4,	nBb3,	nEb4
	dc.b		nBb3,	nEb4,	nBb3,	nEb4,	nBb3,	nEb4,	nBb3,	nEb4
	dc.b		nBb3,	nF4,	nC4,	nF4,	nC4,	nF4,	nC4,	nF4
	dc.b		nC4,	nF4,	nC4,	nF4,	nC4,	nF4,	nC4,	nF4
	dc.b		nC4,	nFs4,	nCs4,	nFs4,	nCs4,	nFs4,	nCs4,	nFs4
	dc.b		nCs4,	nAb4,	nEb4,	nAb4,	nEb4,	nFs4,	nCs4,	nFs4
	dc.b		nCs4,	nF4,	nC4,	nF4,	nC4,	nF4,	nC4,	nF4
	dc.b		nC4,	nF4,	nC4,	nF4,	nC4,	nF4,	nC4,	nF4
	dc.b		nC4,	nE4,	nB3,	nE4,	nB3,	nE4,	nB3,	nE4
	dc.b		nB3,	nE4,	nB3,	nE4,	nB3,	nE4,	nB3,	nE4
	dc.b		nB3,	nF4,	nC4,	nF4,	nC4,	nF4,	nC4,	nF4
	dc.b		nC4,	nF4,	nC4,	nF4,	nC4,	nF4,	nC4,	nF4
	dc.b		nC4,	nFs4,	nCs4,	nFs4,	nCs4,	nFs4,	nCs4,	nFs4
	dc.b		nCs4,	nAb4,	nEb4,	nAb4,	nEb4,	nFs4,	nCs4,	nFs4
	dc.b		nCs4,	nG4,	nCs4,	nG4,	nCs4,	nG4,	nCs4,	nG4
	dc.b		nCs4,	nG4,	nCs4,	nG4,	nCs4,	nG4,	nCs4,	nG4
	dc.b		nCs4,	nCs5,	nAb4,	nCs5,	nAb4,	nCs5,	nAb4,	nCs5
	dc.b		nAb4,	nCs5,	nAb4,	nCs5,	nAb4,	nCs5,	nAb4,	nCs5
	dc.b		nAb4
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nC5,	$0C,	nCs5,	$02,	nRst,	$08,	nRst,	$02
	dc.b		nC5,	$0C,	nCs5,	$02,	nRst,	$08,	nRst,	$02
	dc.b		nEb5,	nRst,	nEb5,	nRst,	nCs5,	nRst,	$06,	nC5
	dc.b		$0C,	nCs5,	$02,	nRst,	$08,	nRst,	$02,	nC5
	dc.b		$0C,	nCs5,	$02,	nRst,	$08,	nRst,	$02,	nEb5
	dc.b		nRst,	nEb5,	nRst,	nEb5,	nRst,	nCs5,	nRst,	nC5
	dc.b		$0C,	nCs5,	$02,	nRst,	nC3,	$08,	nC5,	$0C
	dc.b		nCs5,	$02,	nRst,	nC3,	$08,	nEb5,	$02,	nRst
	dc.b		nEb5,	nRst,	nCs5,	nRst,	$06,	nC5,	$0C,	nCs5
	dc.b		$02,	nRst,	nC3,	$08,	nC5,	$0C,	nCs5,	$02
	dc.b		nRst,	nC3,	$08,	nEb5,	$02,	nRst,	nEb5,	nRst
	dc.b		nEb5,	nRst,	nCs5,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4,	nRst,	$20
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5,	$02
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4,	nRst,	$20
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5,	$02
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4,	nRst,	$20
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5,	$02
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4,	nRst,	$20
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5,	$02
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nG4,	nRst,	$20
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5,	$02
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nC5
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nG4
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nRst,	$20,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst
;	Jump To	 	location
	smpsJump	Pulseman_Shutdown_Jump03

; FM4 Data
Pulseman_Shutdown_FM4:
;	Set FM Voice	#
	smpsFMvoice	$03
;	Alter Notes	value
	smpsAlterNote	$02
	dc.b		nRst,	$1C,	nRst,	$20,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nG4,	$0C,	nFs4,	nF4,	nE4,	nEb4
	dc.b		$08,	nD4,	nG4,	$0C,	nFs4,	nF4,	nE4,	nEb4
	dc.b		$08,	nD4
Pulseman_Shutdown_Jump04:
	dc.b		nG4,	$0C,	nFs4,	nF4,	nE4,	nEb4,	$08,	nD4
	dc.b		nG4,	$0C,	nFs4,	nF4,	nE4,	nEb4,	$08,	nD4
	dc.b		nG4,	$0C,	nFs4,	nF4,	nE4,	nEb4,	$08,	nD4
	dc.b		nG4,	$0C,	nFs4,	nF4,	nE4,	nEb4,	$08,	nD4
	dc.b		nBb3,	$20,	nB3,	nBb3,	nA3,	nBb3,	nB3,	nC4
	dc.b		nCs4,	$10,	nD4,	nEb4,	$20,	nD4,	nCs4,	nC4
	dc.b		nEb4,	nE4,	nF4,	nCs5
;	Set FM Voice	#
	smpsFMvoice	$01
;	Alter Notes	value
	smpsAlterNote	$00
	dc.b		nG4,	$0C,	nAb4,	$02,	nRst,	$08,	nRst,	$02
	dc.b		nG4,	$0C,	nAb4,	$02,	nRst,	$08,	nRst,	$02
	dc.b		nBb4,	nRst,	nBb4,	nRst,	nAb4,	nRst,	$06,	nG4
	dc.b		$0C,	nAb4,	$02,	nRst,	$08,	nRst,	$02,	nG4
	dc.b		$0C,	nAb4,	$02,	nRst,	$08,	nRst,	$02,	nBb4
	dc.b		nRst,	nBb4,	nRst,	nBb4,	nRst,	nAb4,	nRst,	nG4
	dc.b		$0C,	nAb4,	$02,	nRst,	nC3,	$08,	nG4,	$0C
	dc.b		nAb4,	$02,	nRst,	nC3,	$08,	nBb4,	$02,	nRst
	dc.b		nBb4,	nRst,	nAb4,	nRst,	$06,	nG4,	$0C,	nAb4
	dc.b		$02,	nRst,	nC3,	$08,	nG4,	$0C,	nAb4,	$02
	dc.b		nRst,	nC3,	$08,	nBb4,	$02,	nRst,	nBb4,	nRst
	dc.b		nBb4,	nRst,	nAb4,	nRst
;	Set FM Voice	#
	smpsFMvoice	$03
;	Alter Notes	value
	smpsAlterNote	$02
	dc.b		nG4,	$0C,	nFs4,	nF4,	nE4,	nEb4,	$08,	nD4
	dc.b		nG4,	$0C,	nFs4,	nF4,	nE4,	nEb4,	$08,	nD4
	dc.b		nG4,	$0C,	nFs4,	nF4,	nE4,	nEb4,	$08,	nD4
	dc.b		nG4,	$0C,	nFs4,	nF4,	nE4,	nEb4,	$08,	nD4
	dc.b		nRst,	$20,	nRst,	nRst,	nRst,	nG4,	$0C,	nFs4
	dc.b		nF4,	nE4,	nEb4,	$08,	nD4,	nG4,	$0C,	nFs4
	dc.b		nF4,	nE4,	nEb4,	$08,	nD4,	nG4,	$0C,	nFs4
	dc.b		nF4,	nE4,	nEb4,	$08,	nD4,	nG4,	$0C,	nFs4
	dc.b		nF4,	nE4,	nEb4,	$08,	nD4
;	Jump To	 	location
	smpsJump	Pulseman_Shutdown_Jump04

; FM5 Data
Pulseman_Shutdown_FM5:
;	Set FM Voice	#
	smpsFMvoice	$04
;	Alter Notes	value
	smpsAlterNote	$FC
	dc.b		nRst,	$1C,	nRst,	$20,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nC4,	$02,	nG3,	nC4,	nAb3,	nC4
	dc.b		nFs3,	nC4,	nAb3,	nC4,	nFs3,	nC4,	nG3,	nC4
	dc.b		nFs3,	nC4,	nFs3,	nC4,	nA3,	nC4,	nG3,	nC4
	dc.b		nAb3,	nC4,	nFs3,	nC4,	nA3,	nC4,	nAb3,	nC4
	dc.b		nG3,	nC4,	nA3,	nCs4,	nAb3,	nCs4,	nA3,	nCs4
	dc.b		nG3,	nCs4,	nA3,	nCs4,	nG3,	nCs4,	nAb3,	nCs4
	dc.b		nG3,	nCs4,	nG3,	nCs4,	nBb3,	nCs4,	nAb3,	nCs4
	dc.b		nA3,	nCs4,	nG3,	nCs4,	nBb3,	nCs4,	nA3,	nCs4
	dc.b		nAb3,	nCs4,	nBb3
Pulseman_Shutdown_Jump05:
	dc.b		nC4,	nG3,	nC4,	nAb3,	nC4,	nFs3,	nC4,	nAb3
	dc.b		nC4,	nFs3,	nC4,	nG3,	nC4,	nFs3,	nC4,	nFs3
	dc.b		nC4,	nA3,	nC4,	nG3,	nC4,	nAb3,	nC4,	nFs3
	dc.b		nC4,	nA3,	nC4,	nAb3,	nC4,	nG3,	nC4,	nA3
	dc.b		nB3,	nFs3,	nB3,	nG3,	nB3,	nF3,	nB3,	nG3
	dc.b		nB3,	nF3,	nB3,	nFs3,	nB3,	nF3,	nB3,	nF3
	dc.b		nB3,	nAb3,	nB3,	nFs3,	nB3,	nG3,	nB3,	nF3
	dc.b		nB3,	nAb3,	nB3,	nG3,	nB3,	nFs3,	nB3,	nAb3
	dc.b		nBb3,	nF3,	nBb3,	nFs3,	nBb3,	nE3,	nBb3,	nFs3
	dc.b		nBb3,	nE3,	nBb3,	nF3,	nBb3,	nE3,	nBb3,	nE3
	dc.b		nBb3,	nG3,	nBb3,	nF3,	nBb3,	nFs3,	nBb3,	nE3
	dc.b		nBb3,	nG3,	nBb3,	nFs3,	nBb3,	nF3,	nBb3,	nG3
	dc.b		nB3,	nFs3,	nB3,	nG3,	nB3,	nF3,	nB3,	nG3
	dc.b		nB3,	nF3,	nB3,	nFs3,	nB3,	nF3,	nB3,	nF3
	dc.b		nB3,	nAb3,	nB3,	nFs3,	nB3,	nG3,	nB3,	nF3
	dc.b		nB3,	nAb3,	nB3,	nG3,	nB3,	nFs3,	nB3,	nAb3
	dc.b		nRst,	$20,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nC4,	$0C,	nCs4,	$02,	nRst,	$08,	nRst
	dc.b		$02,	nC4,	$0C,	nCs4,	$02,	nRst,	$08,	nRst
	dc.b		$02,	nEb4,	nRst,	nEb4,	nRst,	nCs4,	nRst,	$06
	dc.b		nC4,	$0C,	nCs4,	$02,	nRst,	$08,	nRst,	$02
	dc.b		nC4,	$0C,	nCs4,	$02,	nRst,	$08,	nRst,	$02
	dc.b		nEb4,	nRst,	nEb4,	nRst,	nEb4,	nRst,	nCs4,	nRst
	dc.b		nC4,	$0C,	nCs4,	$02,	nRst,	$08,	nRst,	$02
	dc.b		nC4,	$0C,	nCs4,	$02,	nRst,	$08,	nRst,	$02
	dc.b		nEb4,	nRst,	nEb4,	nRst,	nCs4,	nRst,	$06,	nC4
	dc.b		$0C,	nCs4,	$02,	nRst,	$08,	nRst,	$02,	nC4
	dc.b		$0C,	nCs4,	$02,	nRst,	$08,	nRst,	$02,	nEb4
	dc.b		nRst,	nEb4,	nRst,	nEb4,	nRst,	nCs4,	nRst,	nRst
	dc.b		$20,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	nC4,	$02,	nG3,	nC4
	dc.b		nAb3,	nC4,	nFs3,	nC4,	nAb3,	nC4,	nFs3,	nC4
	dc.b		nG3,	nC4,	nFs3,	nC4,	nFs3,	nC4,	nA3,	nC4
	dc.b		nG3,	nC4,	nAb3,	nC4,	nFs3,	nC4,	nA3,	nC4
	dc.b		nAb3,	nC4,	nG3,	nC4,	nA3,	nB3,	nFs3,	nB3
	dc.b		nG3,	nB3,	nF3,	nB3,	nG3,	nB3,	nF3,	nB3
	dc.b		nFs3,	nB3,	nF3,	nB3,	nF3,	nB3,	nAb3,	nB3
	dc.b		nFs3,	nB3,	nG3,	nB3,	nF3,	nB3,	nAb3,	nB3
	dc.b		nG3,	nB3,	nFs3,	nB3,	nAb3,	nC4,	nG3,	nC4
	dc.b		nAb3,	nC4,	nFs3,	nC4,	nAb3,	nC4,	nFs3,	nC4
	dc.b		nG3,	nC4,	nFs3,	nC4,	nFs3,	nC4,	nA3,	nC4
	dc.b		nG3,	nC4,	nAb3,	nC4,	nFs3,	nC4,	nA3,	nC4
	dc.b		nAb3,	nC4,	nG3,	nC4,	nA3,	nCs4,	nAb3,	nCs4
	dc.b		nA3,	nCs4,	nG3,	nCs4,	nA3,	nCs4,	nG3,	nCs4
	dc.b		nAb3,	nCs4,	nG3,	nCs4,	nG3,	nCs4,	nBb3,	nCs4
	dc.b		nAb3,	nCs4,	nA3,	nCs4,	nG3,	nCs4,	nBb3,	nCs4
	dc.b		nA3,	nCs4,	nAb3,	nCs4,	nBb3
;	Jump To	 	location
	smpsJump	Pulseman_Shutdown_Jump05

; PSG1 Data
Pulseman_Shutdown_PSG1:
	dc.b		nRst,	$1C
Pulseman_Shutdown_Loop01:
	dc.b		nRst,	$20
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$0C,	Pulseman_Shutdown_Loop01
Pulseman_Shutdown_Loop02:
	dc.b		nRst,	$20
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$17,	Pulseman_Shutdown_Loop02
	dc.b		nCs4,	$20
Pulseman_Shutdown_Loop03:
	dc.b		nRst,	$20
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$1C,	Pulseman_Shutdown_Loop03
;	Jump To	 	location
	smpsJump	Pulseman_Shutdown_Loop02

; PSG2 Data
Pulseman_Shutdown_PSG2:
	smpsStop

; PSG3 Data
Pulseman_Shutdown_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nRst,	$14,	nRst,	$20,	nRst,	nRst,	nRst,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nRst,	nRst,	$0C,	nRst,	$20
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$08,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
Pulseman_Shutdown_Jump06:
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$08
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	$02,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nG6,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
;	Jump To	 	location
	smpsJump	Pulseman_Shutdown_Jump06

; DAC Data
Pulseman_Shutdown_DAC:
;	Alter Notes	value
	smpsAlterNote	$02
		dc.b		DSnare,	$04,	dKick,	DSnare,	dKick,	DSnare,	dKick,	DSnare
	dc.b		dKick,	DSnare,	dKick,	DSnare,	dKick,	DSnare,	dKick,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
Pulseman_Shutdown_Jump07:
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	$04,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2
	dc.b		DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2
	dc.b		DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2
	dc.b		DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2
	dc.b		DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2
	dc.b		DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2
	dc.b		DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2
	dc.b		DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2
	dc.b		DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2
	dc.b		DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2
	dc.b		DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2
	dc.b		DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2
	dc.b		DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2
	dc.b		DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2
	dc.b		DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2
	dc.b		DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2
	dc.b		DSnare,	dKick2,	$04,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dCymbal, $20, dCymbal, dCymbal, dCymbal, dKick
	dc.b		$04,	DSnare,	dKick,	DSnare,	dKick,	DSnare,	dKick,	DSnare
	dc.b		dKick,	DSnare,	dKick,	DSnare,	dKick,	DSnare,	dKick,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
	dc.b		dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare,	dKick2,	DSnare
;	Jump To	 	location
	smpsJump	Pulseman_Shutdown_Jump07

Pulseman_Shutdown_Voices:
;	Voice 00
;	$15,$01,$02,$00,$02,$FF,$FF,$FF,$FF,$08,$08,$08,$08,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$8C,$80,$8B,$7C
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$02
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$02,	$00,	$02,	$01
	smpsVcRateScale		$03,	$03,	$03,	$03
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$08,	$08,	$08,	$08
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$7C,	$8B,	$80,	$8C

;	Voice 01
;	$72,$21,$22,$02,$22,$1F,$1F,$1F,$1F,$04,$09,$00,$11,$01,$1F,$0A,$05,$08,$0A,$08,$08,$97,$80,$94,$7E
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$02,	$00,	$02,	$02
	smpsVcCoarseFreq	$02,	$02,	$02,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$11,	$00,	$09,	$04
	smpsVcDecayRate2	$05,	$0A,	$1F,	$01
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$08,	$08,	$0A,	$08
	smpsVcTotalLevel	$7E,	$94,	$80,	$97

;	Voice 02
;	$75,$21,$64,$5C,$22,$1F,$1F,$1F,$1E,$05,$09,$00,$08,$00,$1F,$0A,$05,$08,$0A,$08,$08,$9B,$80,$8C,$78
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$02,	$05,	$06,	$02
	smpsVcCoarseFreq	$02,	$0C,	$04,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1E,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$08,	$00,	$09,	$05
	smpsVcDecayRate2	$05,	$0A,	$1F,	$00
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$08,	$08,	$0A,	$08
	smpsVcTotalLevel	$78,	$8C,	$80,	$9B

;	Voice 03
;	$75,$02,$03,$02,$02,$1F,$1F,$1F,$1F,$1F,$09,$00,$11,$06,$1F,$00,$00,$78,$08,$08,$0A,$84,$80,$80,$88
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$02,	$02,	$03,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$11,	$00,	$09,	$1F
	smpsVcDecayRate2	$00,	$00,	$1F,	$06
	smpsVcDecayLevel	$00,	$00,	$00,	$07
	smpsVcReleaseRate	$0A,	$08,	$08,	$08
	smpsVcTotalLevel	$88,	$80,	$80,	$84

;	Voice 04
;	$75,$12,$12,$12,$12,$18,$1A,$1D,$1E,$00,$06,$0C,$00,$00,$06,$0A,$08,$1F,$1F,$1F,$1F,$90,$80,$90,$A0
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$01,	$01,	$01,	$01
	smpsVcCoarseFreq	$02,	$02,	$02,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1E,	$1D,	$1A,	$18
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$0C,	$06,	$00
	smpsVcDecayRate2	$08,	$0A,	$06,	$00
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$A0,	$90,	$80,	$90

;	Voice 05
;	$75,$C4,$54,$74,$44,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$03,$10,$10,$10,$08,$08,$08,$08,$80,$80,$80,$7F
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$04,	$07,	$05,	$0C
	smpsVcCoarseFreq	$04,	$04,	$04,	$04
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$1F,	$1F,	$1F
	smpsVcDecayRate2	$10,	$10,	$10,	$03
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$08,	$08,	$08,	$08
	smpsVcTotalLevel	$7F,	$80,	$80,	$80
	even
