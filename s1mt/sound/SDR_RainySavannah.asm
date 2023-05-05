; =============================================================================================
; Project Name:		SDR_Rainy_Savannah
; Created:		30th April 2010
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

SDR_Rainy_Savannah_Header:
;	Voice Pointer	location
	smpsHeaderVoice	SDR_Rainy_Savannah_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$01,	$02

;	DAC Pointer	location
	smpsHeaderDAC	SDR_Rainy_Savannah_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	SDR_Rainy_Savannah_FM1,	smpsPitch00-$00,	$10
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	SDR_Rainy_Savannah_FM2,	smpsPitch01lo,	$12
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	SDR_Rainy_Savannah_FM3,	smpsPitch00-$00,	$E
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	SDR_Rainy_Savannah_FM4,	smpsPitch00,	$10
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	SDR_Rainy_Savannah_FM5,	smpsPitch00,	$10
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	SDR_Rainy_Savannah_PSG1,	smpsPitch03lo,	$00,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	SDR_Rainy_Savannah_PSG2,	smpsPitch03lo,	$00,	$00
;	PSG3 Pointer	location			pitch				volume	instrument
	smpsHeaderPSG	SDR_Rainy_Savannah_PSG3,	smpsPitch00+$0B,	$03,	$00

; FM1 Data
SDR_Rainy_Savannah_FM1:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	;SetModulation	wait	speed	change	step
;	smpsModSet	$00,	$08,	$06,	$04
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nAb4,	$0C,	nD5,	$14,	nE5,	$0C,	nA4,	$14
	dc.b		nCs5,	$0C,	nB4,	$04,	nRst,	nCs5,	nRst,	nD5
	dc.b		nRst,	nE5,	nRst,	nCs5,	$08,	nB4,	$04,	nCs5
	dc.b		$08,	nA4,	$0C,	nB4,	$14,	nCs5,	$0C,	nFs4
	dc.b		$14,	$0C,	nCs5,	$04,	nRst,	nD5,	nRst,	nE5
	dc.b		nRst,	nD5,	nRst,	nCs5,	$08,	nFs4,	$04,	nA4
	dc.b		$08,	nAb4,	$0C,	nD5,	$14,	nE5,	$0C,	nA4
	dc.b		$14,	nCs5,	$0C,	nB4,	$04,	nRst,	nCs5,	nRst
	dc.b		nD5,	nRst,	nE5,	nRst,	nCs5,	$08,	nB4,	$04
	dc.b		nCs5,	$08,	nFs4,	$04,	nFs5,	nCs5,	nB4,	$08
	dc.b		nFs5,	$04,	nB4,	nA4,	$08,	nFs5,	$04,	nA4
	dc.b		nB4,	$08,	nFs5,	$04,	nB4,	nFs5,	nCs5,	nFs5
	dc.b		nCs5,	nB4,	$08,	nE5,	$04,	nAb5,	nB5,	nA5
	dc.b		nAb5,	nFs5,	nFs5,	nRst,	nE5,	$0C
;	Jump To	 	location
	smpsJump	SDR_Rainy_Savannah_FM1

; FM2 Data
SDR_Rainy_Savannah_FM2:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nFs3,	$04,	nFs4,	nFs3,	nFs4,	nFs3,	nFs4,	nFs3
	dc.b		nFs4,	nFs3,	nFs4,	nFs3,	nFs4,	nFs3,	nFs4,	nFs3
	dc.b		nFs4,	nE3,	nE4,	nE3,	nE4,	nE3,	nE4,	nE3
	dc.b		nE4,	nE3,	nE4,	nE3,	nE4,	nE3,	nE4,	nE3
	dc.b		nE4,	nD3,	nD4,	nD3,	nD4,	nD3,	nD4,	nD3
	dc.b		nD4,	nD3,	nD4,	nD3,	nD4,	nD3,	nD4,	nD3
	dc.b		nD4,	nE3,	nE4,	nE3,	nE4,	nE3,	nE4,	nE3
	dc.b		nE4,	nE3,	nE4,	nE3,	nE4,	nE3,	nE4,	nE3
	dc.b		nE4,	nFs3,	nFs4,	nFs3,	nFs4,	nFs3,	nFs4,	nFs3
	dc.b		nFs4,	nFs3,	nFs4,	nFs3,	nFs4,	nFs3,	nFs4,	nFs3
	dc.b		nFs4,	nE3,	nE4,	nE3,	nE4,	nE3,	nE4,	nE3
	dc.b		nE4,	nE3,	nE4,	nE3,	nE4,	nE3,	nE4,	nC4
	dc.b		nC4,	nB2,	nB3,	nB2,	nCs3,	$08,	nCs4,	$04
	dc.b		nCs3,	nD3,	$08,	nD4,	$04,	nD3,	nE3,	$08
	dc.b		nE4,	$04,	nCs3,	nC3,	nB2,	nB3,	nB2,	nCs3
	dc.b		$08,	nCs4,	$04,	nCs3,	nCs4,	nD3,	nD3,	nD3
	dc.b		nE3,	nRst,	nE3,	nE3,	nE3
;	Jump To	 	location
	smpsJump	SDR_Rainy_Savannah_FM2

; FM3 Data
SDR_Rainy_Savannah_FM3:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
		;SetModulation	wait	speed	change	step
;	smpsModSet	$00,	$08,	$06,	$04
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nCs5,	$0C,	nA4,	$14,	nB4,	$0C,	nD5,	$14
	dc.b		nAb4,	$0C,	nFs4,	$04,	nRst,	nAb4,	nRst,	nA4
	dc.b		nRst,	nB4,	nRst,	nAb4,	$08,	nFs4,	$04,	nAb4
	dc.b		$08,	nE4,	$0C,	nFs4,	$14,	nAb4,	$0C,	nB4
	dc.b		$14,	$0C,	nAb4,	$04,	nRst,	nA4,	nRst,	nB4
	dc.b		nRst,	nA4,	nRst,	nAb4,	$08,	nB4,	$04,	nE4
	dc.b		$08,	nCs5,	$0C,	nA4,	$14,	nB4,	$0C,	nD5
	dc.b		$14,	nAb4,	$0C,	nFs4,	$04,	nRst,	nAb4,	nRst
	dc.b		nA4,	nRst,	nB4,	nRst,	nAb4,	$08,	nFs4,	$04
	dc.b		nAb4,	$08,	nRst,	$7F,	$01
;	Jump To	 	location
	smpsJump	SDR_Rainy_Savannah_FM3

; FM4 Data
SDR_Rainy_Savannah_FM4:
	dc.b		nRst,	$01
	smpsStop

; FM5 Data
SDR_Rainy_Savannah_FM5:
	dc.b		nRst,	$01
	smpsStop

; PSG1 Data
SDR_Rainy_Savannah_PSG1:
	dc.b		nRst,	$01
	smpsStop

; PSG2 Data
SDR_Rainy_Savannah_PSG2:
	dc.b		nRst,	$01
	smpsStop

; PSG3 Data
SDR_Rainy_Savannah_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
SDR_Rainy_Savannah_Jump01:
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$04,	$04
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		$04
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		$04
;	Jump To	 	location
	smpsJump	SDR_Rainy_Savannah_Jump01

; DAC Data
SDR_Rainy_Savannah_DAC:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		$8B,	$08,	$82,	$04,	$95,	$08,	$04,	$82
	dc.b		$04,	$95,	$95,	$08,	$82,	$04,	$95,	$08
	dc.b		$04,	$82,	$04,	$95,	$95,	$08,	$82,	$04
	dc.b		$95,	$08,	$04,	$82,	$04,	$95,	$95,	$08
	dc.b		$82,	$04,	$95,	$08,	$04,	$82,	$04,	$95
	dc.b		$95,	$08,	$82,	$04,	$95,	$08,	$04,	$82
	dc.b		$04,	$95,	$95,	$08,	$82,	$04,	$95,	$08
	dc.b		$04,	$82,	$04,	$95,	$95,	$08,	$82,	$04
	dc.b		$95,	$08,	$04,	$82,	$04,	$95,	$95,	$08
	dc.b		$82,	$04,	$95,	$08,	$04,	$04,	$04,	$84
	dc.b		$08,	$82,	$04,	$95,	$08,	$04,	$82,	$04
	dc.b		$95,	$95,	$08,	$82,	$04,	$95,	$08,	$04
	dc.b		$82,	$04,	$95,	$95,	$08,	$82,	$04,	$95
	dc.b		$08,	$04,	$82,	$04,	$95,	$95,	$08,	$82
	dc.b		$04,	$95,	$08,	$04,	$82,	$04,	$95,	$95
	dc.b		$08,	$04,	$82,	$04,	$8C,	$08,	$95,	$04
	dc.b		$82,	$8C,	$08,	$95,	$04,	$82,	$97,	$95
	dc.b		$08,	$04,	$04,	$04,	$04,	$82,	$04,	$97
	dc.b		$99,	$95,	$08,	$04,	$04,	$04,	$82,	$04
	dc.b		$95,	$95,	$82,	$95
;	Jump To	 	location
	smpsJump	SDR_Rainy_Savannah_DAC

SDR_Rainy_Savannah_Voices:
	dc.b		$3D,$01,$02,$02,$02,$10,$50,$50,$50,$07,$08,$08,$08,$01,$00,$00,$00,$20,$17,$17,$17,$1C,$18,$18,$84;			Voice 00
	dc.b		$13,$66,$40,$40,$31,$1F,$1F,$1F,$1F,$12,$05,$02,$01,$01,$00,$04,$06,$AA,$6A,$16,$18,$19,$21,$1C,$80;			Voice 01
	dc.b		$3B,$30,$70,$71,$01,$1F,$16,$0F,$12,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$06,$21,$1C,$1E,$00;			Voice 02

	even
