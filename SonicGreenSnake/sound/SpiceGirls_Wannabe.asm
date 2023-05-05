; =============================================================================================
; Project Name:		Spice_Girls_Wannabe
; Created:		28th April 2009
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

Spice_Girls_Wannabe_Header:
;	Voice Pointer	location
	smpsHeaderVoice	Spice_Girls_Wannabe_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$01,	$02

;	DAC Pointer	location
	smpsHeaderDAC	Spice_Girls_Wannabe_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	Spice_Girls_Wannabe_FM1,	smpsPitch00,	$0A
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	Spice_Girls_Wannabe_FM2,	smpsPitch00,	$0B
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	Spice_Girls_Wannabe_FM3,	smpsPitch00,	$0B
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	Spice_Girls_Wannabe_FM4,	smpsPitch00,	$0C
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	Spice_Girls_Wannabe_FM5,	smpsPitch01hi,	$12
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Spice_Girls_Wannabe_PSG1,	smpsPitch03lo,	$07,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Spice_Girls_Wannabe_PSG2,	smpsPitch03lo,	$07,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Spice_Girls_Wannabe_PSG3,	smpsPitch03lo,	$05,	$00

; FM1 Data
Spice_Girls_Wannabe_FM1:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		nB1,	$0B,	nRst,	$0D,	nB1,	$07,	nRst,	$01
	dc.b		nD3,	$0B,	nRst,	$0D
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD2,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE2,	$0E,	nRst,	$0A
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE3,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nA2,	$06,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nA1,	$05,	nRst,	$07,	nBb2,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nB1,	$0B,	nRst,	$0D
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nB1,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD3,	$0B,	nRst,	$0D
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD2,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE2,	$0E,	nRst,	$0A
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE3,	$07,	nRst,	$01,	nA2,	$06,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nA1,	$05,	nRst,	$07,	nBb2,	nRst,	$01,	nB1
	dc.b		$0B,	nRst,	$0D
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nB1,	$07,	nRst,	$01,	nD3,	$0B,	nRst,	$0D
	dc.b		nD2,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE2,	$0E,	nRst,	$0A,	nE3,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nA2,	$06,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nA1,	$05,	nRst,	$07
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb2,	nRst,	$09
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$05
	dc.b		nCs5,	$02,	nRst,	nCs5,	$03,	nRst,	$01,	nEb5
	dc.b		$03,	nRst,	$05
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$03,	nRst,	$05
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$03,	nRst,	$05
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nAb5,	$0F,	nRst,	$11
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$02,	nRst,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$03,	nRst,	$05,	nFs5,	nRst,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb5,	$08,	nCs5,	$10,	nRst,	nFs5,	$01,	nRst
	dc.b		$03,	nFs5,	$01,	nRst,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$01,	nRst,	$07
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$03,	nRst,	$05
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nAb5,	$03,	nRst,	$05
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$02,	nRst,	$06,	nFs5,	$14,	nRst,	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$02,	nRst,	nFs5,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$03,	nRst,	$05
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$06,	nRst,	$02,	nEb5,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nCs5,	$0C,	nRst,	$14
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nCs5,	$03,	nRst,	$05,	nEb5,	$04,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$03,	nRst,	$05,	nAb5,	$03,	nRst,	$05
	dc.b		nBb5,	$15,	nRst,	$0B
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nCs5,	$05,	nRst,	$03,	nEb5,	$05,	nRst,	$03
	dc.b		nA5,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nAb5,	$14,	nRst,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$03,	nRst,	$05,	nFs5,	$04,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$02,	nRst,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$01,	nRst,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nAb5,	$0B,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE5,	nEb5,	nCs5,	$0C,	nFs5,	nEb5,	$16,	nRst
	dc.b		$12
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		nB1,	$0B,	nRst,	$0D,	nB1,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD3,	$0B,	nRst,	$0D,	nD2,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE2,	$0E,	nRst,	$0A
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE3,	$07,	nRst,	$01,	nA2,	$06,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nA1,	$05,	nRst,	$07
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb2,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nB1,	$0B,	nRst,	$0D
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nB1,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD3,	$0B,	nRst,	$0D
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD2,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE2,	$0E,	nRst,	$0A,	nE3,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nA2,	$06,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nA1,	$05,	nRst,	$07,	nBb2,	nRst,	$01
;	Set FM Voice	#
	smpsFMvoice	$05
	dc.b		nFs5,	nRst,	$03,	nFs5,	$01,	nRst,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$01,	nRst,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$01,	nRst,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nAb5,	$06,	nRst,	$02
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nCs5,	$04,	nRst,	$10,	nCs5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04,	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04,	nRst,	$04,	nCs5,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nB4,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb5,	$0C,	nRst,	$14,	nFs5,	$03,	nRst,	$05
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$03,	nRst,	$05
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nAb5,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	nCs5,	$03,	nRst,	$0D,	nB5,	$03,	nRst
	dc.b		$09,	nB5,	$0A,	nRst,	$02
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb5,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$05,	nRst,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$18,	nRst,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$02,	nRst,	nFs5,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$04,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nAb5,	$05,	nRst,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nCs5,	$12,	nRst,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nCs5,	$04,	nRst,	nCs5,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nCs5,	$06,	nRst,	$02,	nB4,	$06,	nRst,	$02
	dc.b		nEb5,	$13,	nRst,	$0D
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$03,	nRst,	$05
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$03,	nRst,	$05
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nAb5,	$08,	nFs5
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nCs5,	$04,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nCs5,	$05,	nRst,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nB5,	$05,	nRst,	$07
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nB5,	$0C,	nCs6,	$07,	nRst,	$01,	nFs5,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nAb5,	$0B
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb5,	$02
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nAb5,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$0C,	nRst,	$08,	nCs5,	$02,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nCs5,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nCs5,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb5,	nRst,	nEb5,	nRst,	nFs5,	nRst,	$06,	nAb5
	dc.b		$07,	nRst,	$09
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb5,	$06,	nRst,	$02
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE5,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE5
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb5,	$04,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb5,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nCs5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nB4,	$1A,	nRst,	$06,	nFs5,	$04,	nRst,	nFs5
	dc.b		$03,	nRst,	$05,	nFs5,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nAb5,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$03,	nRst,	$05,	nFs5,	$03,	nRst,	$05
	dc.b		nFs5,	$07,	nRst,	$09,	nFs5,	$04,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nAb5
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb5,	$1D,	nRst,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb5,	$0F,	nRst,	$01,	nEb5,	$03,	nRst,	$05
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$03,	nRst,	$05,	nAb5,	$03,	nRst,	$05
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb5,	$16,	nRst,	$06,	nCs5,	$02,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb5,	$01,	nRst,	$07,	nFs5,	$03,	nRst,	$05
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nA5,	$07,	nRst,	$01,	nAb5,	$15,	nRst,	$0B
	dc.b		nFs5,	$02,	nRst,	$06,	nFs5,	$02,	nRst,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$02,	nRst,	$06,	nFs5,	$02,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nAb5,	$0C,	nFs5,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE5
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb5
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nCs5,	$0C,	nFs5
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb5,	$17,	nRst,	$11
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		nB1,	$0B,	nRst,	$0D,	nB1,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD3,	$0B,	nRst,	$0D,	nD2,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE2,	$0E,	nRst,	$0A,	nE3,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nA2,	$06,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nA1,	$05,	nRst,	$07
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb2,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nB1,	$0B,	nRst,	$0D
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nB1,	$07,	nRst,	$01,	nD3,	$0B,	nRst,	$0D
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nD2,	$07,	nRst,	$01,	nE2,	$0E,	nRst,	$0A
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nE3,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nA2,	$06,	nRst,	nA1,	$05,	nRst,	$07
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb2,	nRst,	$01
;	Set FM Voice	#
	smpsFMvoice	$05
	dc.b		nFs5,	nRst,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$01,	nRst,	$03,	nFs5,	$01,	nRst,	$03
	dc.b		nFs5,	$01,	nRst,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nAb5,	$06,	nRst,	$02
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nCs5,	$01,	nRst,	$13,	nCs5,	$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$04,	nRst,	$04,	nCs5,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nB4,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb5,	$0C,	nRst,	$14
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$03,	nRst,	$05,	nFs5,	$03,	nRst,	$05
	dc.b		nFs5,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nAb5,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nCs5,	$03,	nRst,	$0D,	nB5,	$03,	nRst,	$09
	dc.b		nB5,	$0A,	nRst,	$02
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nBb5,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$05,	nRst,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$18,	nRst,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$02,	nRst,	nFs5,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	nRst,	nFs5,	nRst,	nFs5,	$04,	nRst,	nAb5
	dc.b		$05,	nRst,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nCs5,	$12,	nRst,	$06,	nCs5,	$04,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nB4,	$06,	nRst,	$02,	nCs5,	$06,	nRst,	$02
	dc.b		nB4,	$06,	nRst,	$02
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nEb5,	$13,	nRst,	$0D
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$03,	nRst,	$05
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$03,	nRst,	$05
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nAb5,	$08,	nFs5,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nCs5,	$04,	nRst
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nCs5,	$05,	nRst,	$03,	nB5,	$05,	nRst,	$07
	dc.b		nB5,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nCs6,	$07,	nRst,	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$08,	nAb5,	$0B,	nBb5,	$02
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nAb5,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		nFs5,	$0C,	nRst,	$04
;	Jump To	 	location
	smpsJump	Spice_Girls_Wannabe_FM1

; FM2 Data
Spice_Girls_Wannabe_FM2:
	dc.b		nRst,	$7F,	$7F,	$7F,	$03
Spice_Girls_Wannabe_Jump01:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nFs1,	$0A,	nRst,	$0E,	nFs1,	$08,	nAb1,	$09
	dc.b		nRst,	$0F,	nAb1,	$08,	nE1,	$0A,	nRst,	$0E
	dc.b		nE1,	$07,	nRst,	$01,	nB1,	$04,	nFs2,	$08
	dc.b		nB1,	$04,	nFs2,	$08,	nB1,	nFs1,	$09,	nRst
	dc.b		$0F,	nFs1,	$08,	nAb1,	$09,	nRst,	$0F,	nAb1
	dc.b		$08,	nE1,	$0A,	nRst,	$0E,	nE1,	$06,	nRst
	dc.b		$02,	nB1,	$04,	nFs2,	$08,	nB1,	$04,	nFs2
	dc.b		$08,	nB1,	nFs1,	$0A,	nRst,	$0E,	nFs1,	$08
	dc.b		nAb1,	$09,	nRst,	$0F,	nAb1,	$08,	nE1,	$0A
	dc.b		nRst,	$0E,	nE1,	$07,	nRst,	$01,	nB1,	$04
	dc.b		nFs2,	$08,	nB1,	$04,	nFs2,	$08,	nB1,	nFs1
	dc.b		$0A,	nRst,	$0E,	nFs1,	$08,	nAb1,	$09,	nRst
	dc.b		$0F,	nAb1,	$08,	nE1,	$0A,	nRst,	$0E,	nE1
	dc.b		$07,	nRst,	$01,	nB1,	$04,	nFs2,	$08,	nB1
	dc.b		$04,	nFs2,	$08,	nB1,	nRst,	$7F,	$7F,	$02
	dc.b		nFs1,	$0A,	nRst,	$0E,	nFs1,	$08,	nAb1,	$09
	dc.b		nRst,	$0F,	nAb1,	$08,	nE1,	$0A,	nRst,	$0E
	dc.b		nE1,	$07,	nRst,	$01,	nB1,	$04,	nFs2,	$08
	dc.b		nB1,	$04,	nFs2,	$08,	nB1,	nFs1,	$0A,	nRst
	dc.b		$0E,	nFs1,	$08,	nAb1,	$09,	nRst,	$0F,	nAb1
	dc.b		$08,	nE1,	$0A,	nRst,	$0E,	nE1,	$06,	nRst
	dc.b		$02,	nB1,	$04,	nFs2,	$08,	nB1,	$04,	nFs2
	dc.b		$08,	nB1,	nFs1,	$0A,	nRst,	$0E,	nFs1,	$08
	dc.b		nAb1,	$09,	nRst,	$0F,	nAb1,	$08,	nE1,	$0A
	dc.b		nRst,	$0E,	nE1,	$07,	nRst,	$01,	nB1,	$04
	dc.b		nFs2,	$08,	nB1,	$04,	nFs2,	$08,	nB1,	nFs1
	dc.b		$0A,	nRst,	$0E,	nFs1,	$08,	nAb1,	$09,	nRst
	dc.b		$0F,	nAb1,	$08,	nE1,	$0A,	nRst,	$0E,	nE1
	dc.b		$07,	nRst,	$01,	nB1,	$04,	nFs2,	$08,	nB1
	dc.b		$04,	nFs2,	$08,	nB1,	nRst,	$40,	nE1,	$0A
	dc.b		nRst,	$0E,	nE1,	$07,	nRst,	$01,	nB1,	$04
	dc.b		nFs2,	$08,	nB1,	$04,	nFs2,	$08,	nB1,	nFs1
	dc.b		$0A,	nRst,	$0E,	nFs1,	$08,	nAb1,	$09,	nRst
	dc.b		$0F,	nAb1,	$08,	nE1,	$0A,	nRst,	$0E,	nE1
	dc.b		$06,	nRst,	$02,	nB1,	$04,	nFs2,	$08,	nB1
	dc.b		$04,	nFs2,	$08,	nB1,	nFs1,	$09,	nRst,	$0F
	dc.b		nFs1,	$08,	nAb1,	$09,	nRst,	$0F,	nAb1,	$08
	dc.b		nE1,	$0A,	nRst,	$0E,	nE1,	$07,	nRst,	$01
	dc.b		nB1,	$04,	nFs2,	$08,	nB1,	$04,	nFs2,	$08
	dc.b		nB1,	nFs1,	$0A,	nRst,	$0E,	nFs1,	$08,	nAb1
	dc.b		$09,	nRst,	$0F,	nAb1,	$08,	nE1,	$0A,	nRst
	dc.b		$0E,	nE1,	$07,	nRst,	$01,	nB1,	$04,	nFs2
	dc.b		$08,	nB1,	$04,	nFs2,	$08,	nB1,	nRst,	$7F
	dc.b		$7F,	$42,	nE1,	$0A,	nRst,	$0E,	nE1,	$07
	dc.b		nRst,	$01,	nB1,	$04,	nFs2,	$08,	nB1,	$04
	dc.b		nFs2,	$08,	nB1,	nFs1,	$0A,	nRst,	$0E,	nFs1
	dc.b		$08,	nAb1,	$09,	nRst,	$0F,	nAb1,	$08,	nE1
	dc.b		$0A,	nRst,	$0E,	nE1,	$07,	nRst,	$01,	nB1
	dc.b		$04,	nFs2,	$08,	nB1,	$04,	nFs2,	$08,	nB1
	dc.b		nFs1,	$09,	nRst,	$0F,	nFs1,	$08,	nAb1,	$09
	dc.b		nRst,	$0F,	nAb1,	$08,	nE1,	$0A,	nRst,	$0E
	dc.b		nE1,	$07,	nRst,	$01,	nB1,	$04,	nFs2,	$08
	dc.b		nB1,	$04,	nFs2,	$08,	nB1,	nFs1,	$0A,	nRst
	dc.b		$0E,	nFs1,	$08,	nAb1,	$09,	nRst,	$0F,	nAb1
	dc.b		$08,	nE1,	$0A,	nRst,	$0E,	nE1,	$07,	nRst
	dc.b		$01,	nB1,	$04,	nFs2,	$08,	nB1,	$04,	nFs2
	dc.b		$08,	nB1,	$7F,	smpsNoAttack,	$7F,	smpsNoAttack,	$7F,	smpsNoAttack
	dc.b		$0B
;	Jump To	 	location
	smpsJump	Spice_Girls_Wannabe_Jump01

; FM3 Data
Spice_Girls_Wannabe_FM3:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		nB2,	$0B,	nRst,	$0D,	nB2,	$07,	nRst,	$01
	dc.b		nD2,	$0B,	nRst,	$0D,	nD3,	$07,	nRst,	$01
	dc.b		nE3,	$0E,	nRst,	$0A,	nE2,	$07,	nRst,	$01
	dc.b		nA1,	$06,	nRst,	nA2,	$05,	nRst,	$07,	nBb1
	dc.b		nRst,	$01,	nB2,	$0B,	nRst,	$0D,	nB2,	$07
	dc.b		nRst,	$01,	nD2,	$0B,	nRst,	$0D,	nD3,	$07
	dc.b		nRst,	$01,	nE3,	$0E,	nRst,	$0A,	nE2,	$07
	dc.b		nRst,	$01,	nA1,	$06,	nRst,	nA2,	$05,	nRst
	dc.b		$07,	nBb1,	nRst,	$01,	nB2,	$0B,	nRst,	$0D
	dc.b		nB2,	$07,	nRst,	$01,	nD2,	$0B,	nRst,	$0D
	dc.b		nD3,	$07,	nRst,	$01,	nE3,	$0E,	nRst,	$0A
	dc.b		nE2,	$07,	nRst,	$01,	nA1,	$06,	nRst,	nA2
	dc.b		$05,	nRst,	$07,	nBb1,	nRst,	$7F,	$7F,	$7F
	dc.b		$7F,	$05,	nB2,	$0B,	nRst,	$0D,	nB2,	$07
	dc.b		nRst,	$01,	nD2,	$0B,	nRst,	$0D,	nD3,	$07
	dc.b		nRst,	$01,	nE3,	$0E,	nRst,	$0A,	nE2,	$07
	dc.b		nRst,	$01,	nA1,	$06,	nRst,	nA2,	$05,	nRst
	dc.b		$07,	nBb1,	nRst,	$01,	nB2,	$0B,	nRst,	$0D
	dc.b		nB2,	$07,	nRst,	$01,	nD2,	$0B,	nRst,	$0D
	dc.b		nD3,	$07,	nRst,	$01,	nE3,	$0E,	nRst,	$0A
	dc.b		nE2,	$07,	nRst,	$01,	nA1,	$06,	nRst,	nA2
	dc.b		$05,	nRst,	$07,	nBb1,	nRst,	$01
;	Set FM Voice	#
	smpsFMvoice	$05
	dc.b		nCs5,	$02,	nRst,	nCs5,	nRst,	nCs5,	nRst,	nBb5
	dc.b		nRst,	nBb5,	$06,	nRst,	$02,	nB5,	$08,	nBb5
	dc.b		nRst,	$58,	nBb5,	$04,	nRst,	nBb5,	nRst,	nCs5
	dc.b		$07,	nRst,	$01,	nB5,	$07,	nRst,	$01,	nBb5
	dc.b		$08,	nRst,	$58,	nBb5,	$02,	nRst,	nBb5,	nRst
	dc.b		nBb5,	nRst,	nBb5,	nRst,	nBb5,	$06,	nRst,	$02
	dc.b		nEb5,	$06,	nRst,	$02,	nBb5,	$07,	nRst,	$59
	dc.b		nBb5,	$05,	nRst,	$03,	nBb5,	$05,	nRst,	$03
	dc.b		nBb5,	$06,	nRst,	$02,	nB5,	$07,	nRst,	$01
	dc.b		nCs5,	$06,	nRst,	$7F,	$7F,	$44,	nB4,	$03
	dc.b		nRst,	$05,	nB4,	$04,	nRst,	nB4,	$07,	nRst
	dc.b		$09,	nCs4,	$03,	nRst,	$7F,	$76
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		nB2,	$0B,	nRst,	$0D,	nB2,	$07,	nRst,	$01
	dc.b		nD2,	$0B,	nRst,	$0D,	nD3,	$07,	nRst,	$01
	dc.b		nE3,	$0E,	nRst,	$0A,	nE2,	$07,	nRst,	$01
	dc.b		nA1,	$06,	nRst,	nA2,	$05,	nRst,	$07,	nBb1
	dc.b		nRst,	$01,	nB2,	$0B,	nRst,	$0D,	nB2,	$07
	dc.b		nRst,	$01,	nD2,	$0B,	nRst,	$0D,	nD3,	$07
	dc.b		nRst,	$01,	nE3,	$0E,	nRst,	$0A,	nE2,	$07
	dc.b		nRst,	$01,	nA1,	$06,	nRst,	nA2,	$05,	nRst
	dc.b		$07,	nBb1,	nRst,	$01
;	Set FM Voice	#
	smpsFMvoice	$05
	dc.b		nCs5,	$02,	nRst,	nCs5,	nRst,	nCs5,	nRst,	nCs5
	dc.b		nRst,	nCs5,	$07,	nRst,	$01,	nEb5,	$08,	nCs5
	dc.b		nRst,	$58,	nBb5,	$04,	nRst,	nCs5,	nRst,	nCs5
	dc.b		$08,	nEb5,	nCs5,	$09,	nRst,	$57,	nCs5,	$02
	dc.b		nRst,	nCs5,	nRst,	nCs5,	nRst,	nCs5,	nRst,	nCs5
	dc.b		$08,	nEb5,	nCs5,	$09,	nRst,	$57,	nCs5,	$05
	dc.b		nRst,	$03,	nCs5,	$05,	nRst,	$03,	nCs5,	$08
	dc.b		nEb5,	nCs5,	$09,	nRst,	$57
;	Jump To	 	location
	smpsJump	Spice_Girls_Wannabe_FM3

; FM4 Data
Spice_Girls_Wannabe_FM4:
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$09
Spice_Girls_Wannabe_Jump02:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$05
	dc.b		nBb5,	$02,	nRst,	nBb5,	nRst,	nBb5,	nRst,	nCs5
	dc.b		nRst,	nCs5,	$06,	nRst,	$02,	nEb5,	$08,	nCs5
	dc.b		nRst,	$58,	nCs5,	$04,	nRst,	nCs5,	nRst,	nBb5
	dc.b		$07,	nRst,	$01,	nEb5,	$08,	nCs5,	nRst,	$58
	dc.b		nCs5,	$02,	nRst,	nCs5,	nRst,	nCs5,	nRst,	nCs5
	dc.b		nRst,	nCs5,	$06,	nRst,	$02,	nB5,	$06,	nRst
	dc.b		$02,	nCs5,	$07,	nRst,	$59,	nCs5,	$05,	nRst
	dc.b		$03,	nCs5,	$04,	nRst,	nCs5,	$06,	nRst,	$02
	dc.b		nEb5,	$08,	nBb5,	$07,	nRst,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$5F,	nBb5,	$02,	nRst,	nBb5
	dc.b		nRst,	nBb5,	$01,	nRst,	$03,	nBb5,	$02,	nRst
	dc.b		nBb5,	$07,	nRst,	$01,	nB5,	$08,	nBb5,	nRst
	dc.b		$58,	nCs5,	$03,	nRst,	$05,	nBb5,	$04,	nRst
	dc.b		nBb5,	$08,	nB5,	nBb5,	nRst,	$58,	nBb5,	$02
	dc.b		nRst,	nBb5,	nRst,	nBb5,	nRst,	nBb5,	nRst,	nBb5
	dc.b		$08,	nB5,	nBb5,	nRst,	$58,	nBb5,	$05,	nRst
	dc.b		$03,	nBb5,	$05,	nRst,	$03,	nBb5,	$08,	nB5
	dc.b		$07,	nRst,	$01,	nBb5,	$09,	nRst,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$60
;	Jump To	 	location
	smpsJump	Spice_Girls_Wannabe_Jump02

; FM5 Data
Spice_Girls_Wannabe_FM5:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nFs3,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	$04,	$04,	$04,	$04,	$04,	$04
	dc.b		nBb2,	$04,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nBb2,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nBb2,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nBb2,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nBb2,	nFs3,	nRst,	$34
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nBb2,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nBb2,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nBb2,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nBb2
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nBb2,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nBb2,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nBb2,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3,	nFs3
	dc.b		nFs3,	nBb2,	$34
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs2,	$08,	$10,	$08,	$08,	$08,	$08,	$04
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nBb2,	$04
;	Jump To	 	location
	smpsJump	Spice_Girls_Wannabe_FM5

; PSG1 Data
Spice_Girls_Wannabe_PSG1:
	dc.b		nRst,	$7F,	$7F,	$7F,	$03
Spice_Girls_Wannabe_Jump03:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nBb3,	$17,	nRst,	$01,	nB3,	$27,	nRst,	$01
	dc.b		nAb3,	$17,	nRst,	$01,	nB3,	$27,	nRst,	$01
	dc.b		nBb3,	$17,	nRst,	$01,	nB3,	$27,	nRst,	$01
	dc.b		nAb3,	$17,	nRst,	$01,	nB3,	$27,	nRst,	$01
	dc.b		nBb3,	$17,	nRst,	$01,	nB3,	$27,	nRst,	$01
	dc.b		nAb3,	$17,	nRst,	$01,	nB3,	$27,	nRst,	$01
	dc.b		nBb3,	$17,	nRst,	$01,	nB3,	$27,	nRst,	$01
	dc.b		nAb3,	$17,	nRst,	$01,	nB3,	$27,	nRst,	$7F
	dc.b		$7F,	$03,	nBb3,	$17,	nRst,	$01,	nB3,	$27
	dc.b		nRst,	$01,	nAb3,	$17,	nRst,	$01,	nB3,	$27
	dc.b		nRst,	$01,	nBb3,	$17,	nRst,	$01,	nB3,	$27
	dc.b		nRst,	$01,	nAb3,	$17,	nRst,	$01,	nB3,	$27
	dc.b		nRst,	$01,	nBb3,	$17,	nRst,	$01,	nB3,	$27
	dc.b		nRst,	$01,	nAb3,	$17,	nRst,	$01,	nB3,	$27
	dc.b		nRst,	$01,	nBb3,	$17,	nRst,	$01,	nB3,	$27
	dc.b		nRst,	$01,	nAb3,	$17,	nRst,	$01,	nB3,	$27
	dc.b		nRst,	$41,	nAb3,	$17,	nRst,	$01,	nB3,	$27
	dc.b		nRst,	$01,	nBb3,	$17,	nRst,	$01,	nB3,	$27
	dc.b		nRst,	$01,	nAb3,	$17,	nRst,	$01,	nB3,	$27
	dc.b		nRst,	$01,	nBb3,	$17,	nRst,	$01,	nB3,	$27
	dc.b		nRst,	$01,	nAb3,	$17,	nRst,	$01,	nB3,	$27
	dc.b		nRst,	$01,	nBb3,	$17,	nRst,	$01,	nB3,	$27
	dc.b		nRst,	$01,	nAb3,	$17,	nRst,	$01,	nB3,	$27
	dc.b		nRst,	$7F,	$7F,	$43,	nAb3,	$17,	nRst,	$01
	dc.b		nB3,	$27,	nRst,	$01,	nBb3,	$17,	nRst,	$01
	dc.b		nB3,	$27,	nRst,	$01,	nAb3,	$17,	nRst,	$01
	dc.b		nB3,	$27,	nRst,	$01,	nBb3,	$17,	nRst,	$01
	dc.b		nB3,	$27,	nRst,	$01,	nAb3,	$17,	nRst,	$01
	dc.b		nB3,	$27,	nRst,	$01,	nBb3,	$17,	nRst,	$01
	dc.b		nB3,	$27,	nRst,	$01,	nAb3,	$17,	nRst,	$01
	dc.b		nB3,	$27,	nRst,	$7F,	$7F,	$7F,	$04
;	Jump To	 	location
	smpsJump	Spice_Girls_Wannabe_Jump03

; PSG2 Data
Spice_Girls_Wannabe_PSG2:
	dc.b		nRst,	$7F,	$7F,	$7F,	$03
Spice_Girls_Wannabe_Jump04:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nFs3,	$17,	nRst,	$01,	nAb3,	$27,	nRst,	$01
	dc.b		nB3,	$17,	nRst,	$01,	nFs3,	$27,	nRst,	$01
	dc.b		nFs3,	$17,	nRst,	$01,	nAb3,	$27,	nRst,	$01
	dc.b		nB3,	$17,	nRst,	$01,	nFs3,	$27,	nRst,	$01
	dc.b		nFs3,	$17,	nRst,	$01,	nAb3,	$27,	nRst,	$01
	dc.b		nB3,	$17,	nRst,	$01,	nFs3,	$27,	nRst,	$01
	dc.b		nFs3,	$17,	nRst,	$01,	nAb3,	$27,	nRst,	$01
	dc.b		nB3,	$17,	nRst,	$01,	nFs3,	$27,	nRst,	$7F
	dc.b		$7F,	$03,	nFs3,	$17,	nRst,	$01,	nAb3,	$27
	dc.b		nRst,	$01,	nB3,	$17,	nRst,	$01,	nFs3,	$27
	dc.b		nRst,	$01,	nFs3,	$17,	nRst,	$01,	nAb3,	$27
	dc.b		nRst,	$01,	nB3,	$17,	nRst,	$01,	nFs3,	$27
	dc.b		nRst,	$01,	nFs3,	$17,	nRst,	$01,	nAb3,	$27
	dc.b		nRst,	$01,	nB3,	$17,	nRst,	$01,	nFs3,	$27
	dc.b		nRst,	$01,	nFs3,	$17,	nRst,	$01,	nAb3,	$27
	dc.b		nRst,	$01,	nB3,	$17,	nRst,	$01,	nFs3,	$27
	dc.b		nRst,	$41,	nB3,	$17,	nRst,	$01,	nFs3,	$27
	dc.b		nRst,	$01,	nFs3,	$17,	nRst,	$01,	nAb3,	$27
	dc.b		nRst,	$01,	nB3,	$17,	nRst,	$01,	nFs3,	$27
	dc.b		nRst,	$01,	nFs3,	$17,	nRst,	$01,	nAb3,	$27
	dc.b		nRst,	$01,	nB3,	$17,	nRst,	$01,	nFs3,	$27
	dc.b		nRst,	$01,	nFs3,	$17,	nRst,	$01,	nAb3,	$27
	dc.b		nRst,	$01,	nB3,	$17,	nRst,	$01,	nFs3,	$27
	dc.b		nRst,	$7F,	$7F,	$43,	nB3,	$17,	nRst,	$01
	dc.b		nFs3,	$27,	nRst,	$01,	nFs3,	$17,	nRst,	$01
	dc.b		nAb3,	$27,	nRst,	$01,	nB3,	$17,	nRst,	$01
	dc.b		nFs3,	$27,	nRst,	$01,	nFs3,	$17,	nRst,	$01
	dc.b		nAb3,	$27,	nRst,	$01,	nB3,	$17,	nRst,	$01
	dc.b		nFs3,	$27,	nRst,	$01,	nFs3,	$17,	nRst,	$01
	dc.b		nAb3,	$27,	nRst,	$01,	nB3,	$17,	nRst,	$01
	dc.b		nFs3,	$27,	nRst,	$7F,	$7F,	$7F,	$04
;	Jump To	 	location
	smpsJump	Spice_Girls_Wannabe_Jump04

; PSG3 Data
Spice_Girls_Wannabe_PSG3:
	dc.b		nRst,	$7F,	$7F,	$7F,	$03
Spice_Girls_Wannabe_Jump05:
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nCs4,	$17,	nRst,	$01,	nEb4,	$27,	nRst,	$01
	dc.b		nE3,	$17,	nRst,	$01,	nEb4,	$27,	nRst,	$01
	dc.b		nCs4,	$17,	nRst,	$01,	nEb4,	$27,	nRst,	$01
	dc.b		nE3,	$17,	nRst,	$01,	nEb4,	$27,	nRst,	$01
	dc.b		nCs4,	$17,	nRst,	$01,	nEb4,	$27,	nRst,	$01
	dc.b		nE3,	$17,	nRst,	$01,	nEb4,	$27,	nRst,	$01
	dc.b		nCs4,	$17,	nRst,	$01,	nEb4,	$27,	nRst,	$01
	dc.b		nE3,	$17,	nRst,	$01,	nEb4,	$27,	nRst,	$7F
	dc.b		$7F,	$03,	nCs4,	$17,	nRst,	$01,	nEb4,	$27
	dc.b		nRst,	$01,	nE3,	$17,	nRst,	$01,	nEb4,	$27
	dc.b		nRst,	$01,	nCs4,	$17,	nRst,	$01,	nEb4,	$27
	dc.b		nRst,	$01,	nE3,	$17,	nRst,	$01,	nEb4,	$27
	dc.b		nRst,	$01,	nCs4,	$17,	nRst,	$01,	nEb4,	$27
	dc.b		nRst,	$01,	nE3,	$17,	nRst,	$01,	nEb4,	$27
	dc.b		nRst,	$01,	nCs4,	$17,	nRst,	$01,	nEb4,	$27
	dc.b		nRst,	$01,	nE3,	$17,	nRst,	$01,	nEb4,	$27
	dc.b		nRst,	$41,	nE3,	$17,	nRst,	$01,	nEb4,	$27
	dc.b		nRst,	$01,	nCs4,	$17,	nRst,	$01,	nEb4,	$27
	dc.b		nRst,	$01,	nE3,	$17,	nRst,	$01,	nEb4,	$27
	dc.b		nRst,	$01,	nCs4,	$17,	nRst,	$01,	nEb4,	$27
	dc.b		nRst,	$01,	nE3,	$17,	nRst,	$01,	nEb4,	$27
	dc.b		nRst,	$01,	nCs4,	$17,	nRst,	$01,	nEb4,	$27
	dc.b		nRst,	$01,	nE3,	$17,	nRst,	$01,	nEb4,	$27
	dc.b		nRst,	$7F,	$7F,	$43,	nE3,	$17,	nRst,	$01
	dc.b		nEb4,	$27,	nRst,	$01,	nCs4,	$17,	nRst,	$01
	dc.b		nEb4,	$27,	nRst,	$01,	nE3,	$17,	nRst,	$01
	dc.b		nEb4,	$27,	nRst,	$01,	nCs4,	$17,	nRst,	$01
	dc.b		nEb4,	$27,	nRst,	$01,	nE3,	$17,	nRst,	$01
	dc.b		nEb4,	$27,	nRst,	$01,	nCs4,	$17,	nRst,	$01
	dc.b		nEb4,	$27,	nRst,	$01,	nE3,	$17,	nRst,	$01
	dc.b		nEb4,	$27,	nRst,	$7F,	$7F,	$7F,	$04
;	Jump To	 	location
	smpsJump	Spice_Girls_Wannabe_Jump05

; DAC Data
Spice_Girls_Wannabe_DAC:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$84,	$0C,	$98,	$04,	$83,	$10,	$98,	$83
	dc.b		$98,	$0C,	$04,	$83,	$10,	$98,	$0C,	$04
	dc.b		$83,	$08,	$98,	$84,	$10,	$83,	$98,	$83
	dc.b		$98,	$83,	$98,	$83,	$84,	$83,	$98,	$83
	dc.b		$98,	$2C,	$04,	$83,	$08,	$98,	$84,	$10
	dc.b		$83,	$98,	$83,	$98,	$83,	$98,	$0C,	$04
	dc.b		$83,	$08,	$98,	$98,	$10,	$83,	$98,	$83
	dc.b		$98,	$83,	$98,	$0C,	$04,	$83,	$08,	$98
	dc.b		$98,	$10,	$83,	$98,	$83,	$98,	$83,	$98
	dc.b		$0C,	$04,	$83,	$08,	$98,	$98,	$10,	$83
	dc.b		$98,	$83,	$98,	$83,	$98,	$0C,	$04,	$83
	dc.b		$08,	$98,	$84,	$0C,	$98,	$04,	$83,	$10
	dc.b		$98,	$83,	$98,	$0C,	$04,	$83,	$10,	$98
	dc.b		$0C,	$04,	$83,	$08,	$98,	$84,	$0C,	$98
	dc.b		$04,	$83,	$10,	$98,	$83,	$98,	$0C,	$04
	dc.b		$83,	$10,	$98,	$0C,	$04,	$83,	$08,	$98
	dc.b		$84,	$0C,	$98,	$04,	$83,	$10,	$98,	$0C
	dc.b		$04,	$83,	$08,	$98,	$98,	$10,	$83,	$98
	dc.b		$0C,	$04,	$83,	$08,	$98,	$98,	$0C,	$04
	dc.b		$83,	$08,	$98,	$98,	$0C,	$04,	$83,	$10
	dc.b		$98,	$83,	$08,	$98,	$98,	$0C,	$04,	$83
	dc.b		$08,	$98,	$98,	$10,	$83,	$98,	$0C,	$04
	dc.b		$83,	$08,	$98,	$98,	$10,	$83,	$08,	$98
	dc.b		$98,	$0C,	$04,	$83,	$08,	$98,	$98,	$0C
	dc.b		$04,	$83,	$08,	$98,	$98,	$0C,	$04,	$83
	dc.b		$10,	$98,	$0C,	$04,	$83,	$08,	$98,	$98
	dc.b		$10,	$83,	$08,	$98,	$84,	$0C,	$98,	$04
	dc.b		$83,	$10,	$98,	$83,	$0C,	$98,	$04,	$0C
	dc.b		$04,	$83,	$10,	$98,	$0C,	$04,	$83,	$10
	dc.b		$98,	$83,	$98,	$0C,	$04,	$83,	$08,	$98
	dc.b		$98,	$10,	$83,	$98,	$0C,	$04,	$83,	$10
	dc.b		$98,	$83,	$98,	$0C,	$04,	$83,	$08,	$98
	dc.b		$98,	$10,	$83,	$98,	$0C,	$04,	$83,	$0C
	dc.b		$98,	$04,	$10,	$83,	$10,	$98,	$0C,	$04
	dc.b		$83,	$10,	$98,	$83,	$98,	$0C,	$04,	$83
	dc.b		$08,	$98,	$84,	$0C,	$98,	$04,	$83,	$08
	dc.b		$98,	$98,	$10,	$83,	$08,	$98,	$98,	$0C
	dc.b		$04,	$83,	$08,	$98,	$98,	$0C,	$04,	$83
	dc.b		$08,	$98,	$84,	$0C,	$98,	$04,	$83,	$08
	dc.b		$98,	$98,	$10,	$83,	$08,	$98,	$98,	$0C
	dc.b		$04,	$83,	$08,	$98,	$98,	$0C,	$04,	$83
	dc.b		$08,	$98,	$84,	$28,	$98,	$08,	$83,	$10
	dc.b		$84,	$83,	$08,	$98,	$98,	$0C,	$04,	$83
	dc.b		$10,	$98,	$83,	$98,	$83,	$98,	$83,	$98
	dc.b		$83,	$98,	$0C,	$04,	$83,	$08,	$98,	$98
	dc.b		$10,	$83,	$98,	$0C,	$04,	$83,	$08,	$98
	dc.b		$98,	$10,	$83,	$0C,	$98,	$04,	$0C,	$04
	dc.b		$83,	$08,	$98,	$98,	$10,	$83,	$98,	$0C
	dc.b		$04,	$83,	$08,	$98,	$98,	$0C,	$04,	$83
	dc.b		$08,	$98
;	Jump To	 	location
	smpsJump	Spice_Girls_Wannabe_DAC

Spice_Girls_Wannabe_Voices:
	dc.b		$24,$01,$02,$04,$41,$1E,$1E,$1E,$1E,$0B,$09,$18,$04,$0B,$19,$18
	dc.b		$1D,$2F,$4F,$4F,$4F,$0F,$80,$40,$80;			Voice 00
	dc.b		$38,$0F,$79,$0B,$39,$1B,$5F,$1F,$5F,$00,$0A,$04,$13,$0A,$0A,$0A
	dc.b		$0A,$F0,$FE,$FE,$FF,$27,$05,$1E,$00;			Voice 01
	dc.b		$3C,$0F,$00,$00,$0F,$5F,$5F,$5F,$19,$0B,$00,$11,$13,$00,$0C,$0C
	dc.b		$0C,$50,$0F,$99,$FF,$00,$00,$00,$11;			Voice 02
	dc.b		$3D,$41,$21,$51,$31,$94,$19,$19,$19,$0F,$0F,$0F,$0F,$05,$08,$09
	dc.b		$08,$25,$1A,$1A,$1A,$19,$80,$80,$80;			Voice 03
	dc.b		$32,$71,$0D,$33,$01,$5F,$99,$5F,$94,$05,$05,$05,$07,$02,$02,$02
	dc.b		$02,$11,$11,$11,$72,$23,$2D,$26,$80;			Voice 04
	dc.b		$3A,$01,$07,$01,$01,$8E,$8E,$8D,$53,$0E,$0E,$0E,$03,$00,$00,$00
	dc.b		$00,$1F,$FF,$1F,$0F,$18,$28,$27,$00;			Voice 05
	even
