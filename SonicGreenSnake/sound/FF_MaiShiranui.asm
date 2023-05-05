; =============================================================================================
; Project Name:		FF2_Mai_Shiranui
; Created:		17th January 2014
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

FF2_Mai_Shiranui_Header:
;	Voice Pointer	location
	smpsHeaderVoice	FF2_Mai_Shiranui_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$01,	$07

;	DAC Pointer	location
	smpsHeaderDAC	FF2_Mai_Shiranui_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	FF2_Mai_Shiranui_FM1,	smpsPitch01hi,	$18
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	FF2_Mai_Shiranui_FM2,	smpsPitch01lo,	$0E
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	FF2_Mai_Shiranui_FM3,	smpsPitch01hi,	$14
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	FF2_Mai_Shiranui_FM4,	smpsPitch01hi,	$18
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	FF2_Mai_Shiranui_FM5,	smpsPitch01hi,	$1C
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	FF2_Mai_Shiranui_PSG1,	smpsPitch02lo,	$05,	$01
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	FF2_Mai_Shiranui_PSG2,	smpsPitch02lo,	$05,	$01
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	FF2_Mai_Shiranui_PSG3,	smpsPitch00,	$08,	$00

; FM1 Data
FF2_Mai_Shiranui_FM1:
;	Set FM Voice	#
	smpsFMvoice	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$10,	$01,	$06,	$04
	dc.b		nA4,	$02,	nBb4,	nB4,	$08,	nA4,	$0C,	nF4
	dc.b		$1E,	nA4,	$06,	nF4,	nD4,	$0C,	nEb4,	nE4
	dc.b		$24,	nEb4,	$04,	nD4,	nCs4
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nE4,	$24,	nEb4,	$04,	nD4,	nCs4
;	Alter Volume	value
	smpsAlterVol	$F8
FF2_Mai_Shiranui_Jump01:
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nB4,	$30
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nB4
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nB4,	nRst
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nB4
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nB4
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nB4,	nRst,	$18
;	Alter Volume	value
	smpsAlterVol	$F8
;	Alter Volume	value
	smpsAlterVol	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nB3,	$06,	nE4,	nFs4,	nA4,	nB4,	$3C,	nRst
	dc.b		$0C,	nA4,	$08,	nB4,	nA4,	nF4,	$54,	nE4
	dc.b		$06,	nF4,	nE4,	$48,	nEb4,	$04,	nD4,	nCs4
	dc.b		nD4,	$0C,	nE4,	$48,	nB3,	$06,	nE4,	nFs4
	dc.b		nA4,	nB4,	$3C,	nRst,	$0C,	nA4,	$08,	nB4
	dc.b		nA4,	nF4,	$54,	nCs4,	$01,	nD4,	nEb4,	nE4
	dc.b		$09,	nB4,	$48,	nA4,	$08,	nB4,	nA4,	nB4
	dc.b		$60
;	Alter Pitch	value
	smpsAlterPitch	$E8
;	Set FM Voice	#
	smpsFMvoice	$05
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
FF2_Mai_Shiranui_Loop01:
	dc.b		nD4,	$01,	nEb4,	nE4,	nF4,	$60,	smpsNoAttack,	$5D
	dc.b		nCs4,	$01,	nD4,	nEb4,	nE4,	$60,	smpsNoAttack,	$46
	dc.b		nRst,	$17
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$02,	FF2_Mai_Shiranui_Loop01
;	Alter Pitch	value
	smpsAlterPitch	$18
;	Set FM Voice	#
	smpsFMvoice	$00
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Jump To	 	location
	smpsJump	FF2_Mai_Shiranui_Jump01

; FM2 Data
FF2_Mai_Shiranui_FM2:
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nA4,	$02,	nBb4,	nB4,	$08,	nA4,	$0C,	nF4
	dc.b		$1E,	nA4,	$06,	nF4,	nD4,	$0C,	nEb4,	nE4
	dc.b		$24,	nEb4,	$04,	nD4,	nCs4
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nE4,	$24,	nEb4,	$04,	nD4,	nCs4
;	Alter Volume	value
	smpsAlterVol	$F8
;	Note Fill	duration
	smpsNoteFill	$0D
FF2_Mai_Shiranui_Loop02:
	dc.b		nE3,	$0C,	nD3,	nF3,	nD3,	$06,	nE3,	$0C
	dc.b		nE3,	nD3,	$06,	nE3,	$0C,	nD3
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$0C,	FF2_Mai_Shiranui_Loop02
FF2_Mai_Shiranui_Loop03:
	dc.b		nF3,	$0C,	nE3,	nF3,	nE3,	$06,	nF3,	$0C
	dc.b		nF3,	nE3,	$06,	nF3,	$0C,	nE3
;	Loop To	 	index	loops	location
	smpsLoop	$02,	$02,	FF2_Mai_Shiranui_Loop03
FF2_Mai_Shiranui_Loop04:
	dc.b		nE3,	$0C,	nD3,	nF3,	nD3,	$06,	nE3,	$0C
	dc.b		nE3,	nD3,	$06,	nE3,	$0C,	nD3
;	Loop To	 	index	loops	location
	smpsLoop	$02,	$02,	FF2_Mai_Shiranui_Loop04
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$02,	FF2_Mai_Shiranui_Loop03
;	Jump To	 	location
	smpsJump	FF2_Mai_Shiranui_Loop02
	smpsStop

; FM3 Data
FF2_Mai_Shiranui_FM3:
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nE5,	$02,	nF5,	nFs5,	$08,	nE5,	$0C,	nC5
	dc.b		$1E,	nE5,	$06,	nC5,	nA4,	$0C,	nBb4,	nB4
	dc.b		$18,	nRst,	nB4,	nRst
FF2_Mai_Shiranui_Jump02:
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nE3,	$06,	nE4,	nB3,	nG3,	nB3,	nG3,	nE3
	dc.b		nD4,	nE4,	nB3,	nG3,	nB3,	nG3,	nE3,	nG3
	dc.b		nB3,	nE3,	nE4,	nB3,	nG3,	nB3,	nG3,	nE3
	dc.b		nD4,	nE4,	nB3,	nG3,	$04,	nAb3,	nA3,	nE4
	dc.b		$06,	nB3,	nG3,	nE3,	nE3,	nE4,	nB3,	nG3
	dc.b		nB3,	nG3,	nE3,	nD4,	nE4,	nB3,	nG3,	nB3
	dc.b		nG3,	nE3,	nG3,	nB3,	nE3,	nE4,	nB3,	nG3
	dc.b		nB3,	nG3,	nE3,	nD4,	nE4,	nB3,	nG3,	$04
	dc.b		nAb3,	nA3
;	Set FM Voice	#
	smpsFMvoice	$04
;	Alter Volume	value
	smpsAlterVol	$FC
;	Alter Pitch	value
	smpsAlterPitch	$F4
	dc.b		nFs4,	$06,	nB4,	nCs5,	nE5
FF2_Mai_Shiranui_Loop05:
	dc.b		nFs5,	$12,	$06
;	Note Fill	duration
	smpsNoteFill	$05
	dc.b		nB4,	nB4,	nF4,	nF4,	nE4,	nF4,	nD4,	nE4
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nE5,	$08,	nFs5,	nE5,	nC5,	$12,	$06,	nRst
	dc.b		$06,	nB4,	$12,	$06,	nRst,	$06,	nA4,	$12
	dc.b		$06,	nB4,	nC5
;	Set FM Voice	#
	smpsFMvoice	$00
;	Alter Pitch	value
	smpsAlterPitch	$0C
	dc.b		nE3,	nE4,	nB3,	nG3,	nB3,	nG3,	nE3,	nD4
	dc.b		nE4,	nB3,	nG3,	nB3,	nG3,	nE3,	nG3,	nB3
	dc.b		nE3,	nE4,	nB3,	nG3,	nB3,	nG3,	nE3,	nD4
	dc.b		nE4,	nB3,	nG3,	$04,	nAb3,	nA3
;	Set FM Voice	#
	smpsFMvoice	$04
;	Alter Pitch	value
	smpsAlterPitch	$F4
	dc.b		nFs4,	$06,	nB4,	nCs5,	nE5
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$02,	FF2_Mai_Shiranui_Loop05
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Alter Volume	value
	smpsAlterVol	$08
;	Set Modulation	wait	speed	change	step
	smpsModSet	$08,	$01,	$06,	$04
	dc.b		nRst,	$60,	nRst,	$30,	nC6,	$06,	nA5,	nG5
	dc.b		$04,	nF5,	nE5,	nF5,	$06,	nG5,	nF5,	$04
	dc.b		nE5,	nEb5,	nE5,	$3C,	nF5,	$04,	nFs5,	nG5
	dc.b		nB5,	$06,	nC6,	nB5,	$04,	nBb5,	nA5,	nE5
	dc.b		$06,	nB4,	nG4,	nB4,	nD5,	nE5,	nF5,	$04
	dc.b		nFs5,	nG5,	nC6,	$06,	nB5,	nBb5,	$04,	nA5
	dc.b		nAb5,	nE5,	$18,	nF5,	$30
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nF5,	$30
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nF5,	$18
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nF5,	$06,	nD5,	nC5,	$04,	nF5,	nA5,	nC6
	dc.b		$06,	nA5,	nF6,	nA6,	nF6,	$04,	nE6,	nC6
	dc.b		nA5,	$06,	nF5,	nE5,	$18,	nC6,	$06,	nC6
	dc.b		nB5,	nB5,	nA5,	nA5,	nG5,	$04,	nF5,	nE5
	dc.b		nF5,	$06,	nG5,	nF5,	nD5,	nF5,	nF5,	nE5
	dc.b		nE5,	nD5,	nD5,	nC5,	$04,	nB4,	nA4,	nE5
	dc.b		$06,	nF5,	nE5,	nD5,	nC5,	nB4,	$12
;	Set FM Voice	#
	smpsFMvoice	$00
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Alter Volume	value
	smpsAlterVol	$FC
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$00,	$00,	$00
;	Jump To	 	location
	smpsJump	FF2_Mai_Shiranui_Jump02
	smpsStop

; FM4 Data
FF2_Mai_Shiranui_FM4:
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nRst,	$07,	nE5,	$02,	nF5,	nFs5,	$08,	nE5
	dc.b		$0C,	nC5,	$1E,	nE5,	$06,	nC5,	nA4,	$0C
	dc.b		nBb4,	nB4,	$18,	nRst,	nB4,	nRst,	$11
FF2_Mai_Shiranui_Jump03:
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nRst,	$04,	nE3,	$06,	nE4,	nB3,	nG3,	nB3
	dc.b		nG3,	nE3,	nD4,	nE4,	nB3,	nG3,	nB3,	nG3
	dc.b		nE3,	nG3,	nB3,	nE3,	nE4,	nB3,	nG3,	nB3
	dc.b		nG3,	nE3,	nD4,	nE4,	nB3,	nG3,	$04,	nAb3
	dc.b		nA3,	nE4,	$06,	nB3,	nG3,	nE3,	nE3,	nE4
	dc.b		nB3,	nG3,	nB3,	nG3,	nE3,	nD4,	nE4,	nB3
	dc.b		nG3,	nB3,	nG3,	nE3,	nG3,	nB3,	nE3,	nE4
	dc.b		nB3,	nG3,	nB3,	nG3,	nE3,	nD4,	nE4,	nB3
	dc.b		nG3,	$04,	nAb3,	nA3
;	Set FM Voice	#
	smpsFMvoice	$04
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nFs4,	$06,	nB4,	nCs5,	nE5,	$02
FF2_Mai_Shiranui_Loop06:
	dc.b		nD5,	$12,	$06
;	Note Fill	duration
	smpsNoteFill	$05
	dc.b		nFs4,	nFs4,	nC4,	nC4,	nB3,	nC4,	nA3,	nB3
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nC5,	$08,	nD5,	nC5,	nA4,	$12,	$06,	nRst
	dc.b		$06,	nG4,	$12,	$06,	nRst,	$06,	nF4,	$12
	dc.b		$06,	nG4,	nA4,	nRst,	$04,	nE3,	$06,	nE4
	dc.b		nB3
;	Set FM Voice	#
	smpsFMvoice	$00
;	Alter Pitch	value
	smpsAlterPitch	$0C
	dc.b		nG3,	nB3,	nG3,	nE3,	nD4,	nE4,	nB3,	nG3
	dc.b		nB3,	nG3,	nE3,	nG3,	nB3,	nE3,	nE4,	nB3
	dc.b		nG3,	nB3,	nG3,	nE3,	nD4,	nE4,	nB3,	nG3
	dc.b		$04,	nAb3,	nA3
;	Set FM Voice	#
	smpsFMvoice	$04
;	Alter Pitch	value
	smpsAlterPitch	$F4
	dc.b		nFs4,	$06,	nB4,	nCs5,	nE5,	$02
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$02,	FF2_Mai_Shiranui_Loop06
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Alter Volume	value
	smpsAlterVol	$08
	dc.b		nRst,	$60,	nRst,	$32,	nC5,	$06,	nA4,	nG4
	dc.b		$04,	nF4,	nE4,	nF4,	$06,	nG4,	nF4,	$04
	dc.b		nE4,	nEb4,	nE4,	$3C,	nF4,	$04,	nFs4,	nG4
	dc.b		nB4,	$06,	nC5,	nB4,	$04,	nBb4,	nA4,	nE4
	dc.b		$06,	nB3,	nG3,	nB3,	nD4,	nE4,	nF4,	$04
	dc.b		nFs4,	nG4,	nC5,	$06,	nB4,	nBb4,	$04,	nA4
	dc.b		nAb4,	nE4,	$18,	nF4,	$30
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nF4,	$30
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nF4,	$18
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nF4,	$06,	nD4,	nC4,	$04,	nF4,	nA4,	nC5
	dc.b		$06,	nA4,	nF5,	nA5,	nF5,	$04,	nE5,	nC5
	dc.b		nA4,	$06,	nF4,	nE4,	$18,	nC5,	$06,	nC5
	dc.b		nB4,	nB4,	nA4,	nA4,	nG4,	$04,	nF4,	nE4
	dc.b		nF4,	$06,	nG4,	nF4,	nD4,	nF4,	nF4,	nE4
	dc.b		nE4,	nD4,	nD4,	nC4,	$04,	nB3,	nA3,	nE4
	dc.b		$06,	nF4,	nE4,	nD4,	nC4,	nB3,	$10
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Set FM Voice	#
	smpsFMvoice	$00
;	Alter Volume	value
	smpsAlterVol	$FC
;	Jump To	 	location
	smpsJump	FF2_Mai_Shiranui_Jump03
	smpsStop

; FM5 Data
FF2_Mai_Shiranui_FM5:
;	Alter Notes	value
	smpsAlterNote	$01
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nRst,	$0E,	nA4,	$02,	nBb4,	nB4,	$08,	nA4
	dc.b		$0C,	nF4,	$1E,	nA4,	$06,	nF4,	nD4,	$0C
	dc.b		nEb4,	nE4,	$18,	nRst,	nE4,	nRst,	$0A
FF2_Mai_Shiranui_Jump04:
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nRst,	$0E,	nB4,	$30
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nB4
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nB4,	nRst
;	Alter Volume	value
	smpsAlterVol	$F8
	dc.b		nB4
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nB4
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nB4,	nRst,	$18
;	Alter Volume	value
	smpsAlterVol	$F8
;	Alter Volume	value
	smpsAlterVol	$04
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nB3,	$06,	nE4,	nFs4,	nA4,	nB4,	$3C,	nRst
	dc.b		$0C,	nA4,	$08,	nB4,	nA4,	nF4,	$54,	nE4
	dc.b		$06,	nF4,	nE4,	$48,	nEb4,	$04,	nD4,	nCs4
	dc.b		nD4,	$0C,	nE4,	$48,	nB3,	$06,	nE4,	nFs4
	dc.b		nA4,	nB4,	$3C,	nRst,	$0C,	nA4,	$08,	nB4
	dc.b		nA4,	nF4,	$54,	nCs4,	$01,	nD4,	nEb4,	nE4
	dc.b		$09,	nB4,	$48,	nA4,	$08,	nB4,	nA4,	nB4
	dc.b		$52
;	Alter Volume	value
	smpsAlterVol	$F5
;	Alter Pitch	value
	smpsAlterPitch	$E8
;	Set FM Voice	#
	smpsFMvoice	$05
;	Alter Notes	value
	smpsAlterNote	$00
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
FF2_Mai_Shiranui_Loop07:
	dc.b		nA4,	$01,	nBb4,	nB4,	nC5,	$60,	smpsNoAttack,	$5D
	dc.b		nAb4,	$01,	nA4,	nBb4,	nB4,	$60,	smpsNoAttack,	$48
	dc.b		nRst,	$15
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$02,	FF2_Mai_Shiranui_Loop07
;	Alter Volume	value
	smpsAlterVol	$0B
;	Alter Pitch	value
	smpsAlterPitch	$18
;	Alter Notes	value
	smpsAlterNote	$01
;	Set FM Voice	#
	smpsFMvoice	$00
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Jump To	 	location
	smpsJump	FF2_Mai_Shiranui_Jump04
	smpsStop

; PSG1 Data
FF2_Mai_Shiranui_PSG1:
	dc.b		nRst,	$60,	nRst,	$5A
FF2_Mai_Shiranui_Jump05:
	dc.b		nFs4,	$30
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nFs4
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nFs4,	nRst
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nFs4
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nFs4
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nFs4,	nRst,	$18
;	Set Volume	value
	smpsSetVol	$FC
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nB3,	$06,	nE4,	nFs4,	nA4,	nD4,	$3C,	nRst
	dc.b		$0C,	nC4,	$08,	nD4,	nC4,	nA3,	$54,	nG3
	dc.b		$06,	nAb3,	nG3,	$48,	nFs3,	$04,	nF3,	nE3
	dc.b		nF3,	$0C,	nG3,	$48,	nD3,	$06,	nG3,	nA3
	dc.b		nC4,	nD4,	$3C,	nRst,	$0C,	nC4,	$08,	nD4
	dc.b		nC4,	nA3,	$54,	nE3,	$01,	nF3,	nFs3,	nG3
	dc.b		$09,	$48,	nC4,	$08,	nD4,	nC4,	nE3,	$60
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
FF2_Mai_Shiranui_Loop08:
	dc.b		nA3,	$48,	nG3,	$18,	nF3,	$30,	nA3,	nG3
	dc.b		$48,	nFs3,	$18,	nE3,	$30,	nG3,	$10
;	Set Volume	value
	smpsSetVol	$FE
	dc.b		nE2,	$04,	nG2,	nB2,	nE3,	nG3,	nB3,	nE4
	dc.b		nB4
;	Set Volume	value
	smpsSetVol	$02
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$02,	FF2_Mai_Shiranui_Loop08
;	Set PSG Voice	#
	smpsPSGvoice	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Jump To	 	location
	smpsJump	FF2_Mai_Shiranui_Jump05
	smpsStop

; PSG2 Data
FF2_Mai_Shiranui_PSG2:
	dc.b		nRst,	$60,	nRst,	$5A
FF2_Mai_Shiranui_Jump06:
	dc.b		nD4,	$30
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nD4
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nD4,	nRst
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nD4
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nD4
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nD4,	nRst,	$1F
;	Set Volume	value
	smpsSetVol	$FC
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nFs3,	$06,	nB3,	nCs4,	nE4
;	Set Volume	value
	smpsSetVol	$02
;	Alter Notes	value
	smpsAlterNote	$01
	dc.b		nD4,	$3C,	nRst,	$0C,	nC4,	$08,	nD4,	nC4
	dc.b		nA3,	$54,	nG3,	$06,	nAb3,	nG3,	$48,	nFs3
	dc.b		$04,	nF3,	nE3,	nF3,	$0C,	nG3,	$48,	nD3
	dc.b		$06,	nG3,	nA3,	nC4,	nD4,	$3C,	nRst,	$0C
	dc.b		nC4,	$08,	nD4,	nC4,	nA3,	$54,	nE3,	$01
	dc.b		nF3,	nFs3,	nG3,	$09,	$48,	nC4,	$08,	nD4
	dc.b		nC4,	nE3,	$59
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nRst,	$06,	nA3,	$48,	nG3,	$18,	nF3,	$30
	dc.b		nA3,	nG3,	$48,	nFs3,	$18,	nE3,	$30,	nG3
	dc.b		$10,	nE2,	$04,	nG2,	nB2,	nE3,	nG3,	nB3
	dc.b		nE4,	nB4,	nA3,	$48,	nG3,	$18,	nF3,	$30
	dc.b		nA3,	nG3,	$48,	nFs3,	$18,	nE3,	$30,	nG3
	dc.b		$10
;	Set Volume	value
	smpsSetVol	$FE
	dc.b		nE2,	$04,	nG2,	nB2,	nE3,	nG3,	nB3,	nE4
	dc.b		$02
;	Set Volume	value
	smpsSetVol	$02
;	Set Volume	value
	smpsSetVol	$FE
;	Alter Notes	value
	smpsAlterNote	$00
;	Set PSG Voice	#
	smpsPSGvoice	$01
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Jump To	 	location
	smpsJump	FF2_Mai_Shiranui_Jump06
	smpsStop

; PSG3 Data
FF2_Mai_Shiranui_PSG3:
	smpsStop

; DAC Data
FF2_Mai_Shiranui_DAC:
	dc.b		nRst,	$5A,	dKick,	$0C,	nRst,	dKick,	nRst,	dKick
	dc.b		$12,	$06,	dMidTimpani,	$0C,	dKick,	$06,	dMidTimpani
FF2_Mai_Shiranui_Loop09:
	dc.b		dKick,	$12,	$06,	dMidTimpani,	$0C,	dKick,	nRst,	$06
	dc.b		dKick,	dKick,	$0C,	dMidTimpani,	dKick,	$06,	dKick
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$13,	FF2_Mai_Shiranui_Loop09
	dc.b		dKick,	$12,	$06,	dMidTimpani,	$0C,	dKick,	nRst,	$06
	dc.b		dKick,	dKick,	$0C,	dMidTimpani,	$06,	dMidTimpani,	dMidTimpani,	dMidTimpani
;	Jump To	 	location
	smpsJump	FF2_Mai_Shiranui_Loop09
	smpsStop

FF2_Mai_Shiranui_Voices:
;	Voice 00
;	$02,$01,$01,$00,$02,$5C,$54,$1C,$D0,$0C,$08,$0A,$05,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$24,$1B,$1E,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$02,	$00,	$01,	$01
	smpsVcRateScale		$03,	$00,	$01,	$01
	smpsVcAttackRate	$10,	$1C,	$14,	$1C
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$0A,	$08,	$0C
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$1E,	$1B,	$24

;	Voice 01
;	$3D,$01,$01,$01,$01,$8E,$52,$14,$4C,$08,$08,$0E,$03,$00,$00,$00,$00,$1F,$1F,$1F,$1F,$1B,$87,$87,$87
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
	smpsVcTotalLevel	$87,	$87,	$87,	$1B

;	Voice 02
;	$2C,$71,$73,$32,$32,$1F,$12,$1F,$1F,$00,$0F,$00,$0F,$00,$01,$00,$01,$0F,$3F,$0F,$3F,$16,$80,$17,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$03,	$07,	$07
	smpsVcCoarseFreq	$02,	$02,	$03,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$12,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$00,	$0F,	$00
	smpsVcDecayRate2	$01,	$00,	$01,	$00
	smpsVcDecayLevel	$03,	$00,	$03,	$00
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$17,	$80,	$16

;	Voice 03
;	$3A,$61,$3C,$14,$31,$9C,$DB,$9C,$DA,$04,$09,$04,$03,$03,$01,$03,$00,$1F,$0F,$0F,$AF,$21,$47,$31,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$01,	$03,	$06
	smpsVcCoarseFreq	$01,	$04,	$0C,	$01
	smpsVcRateScale		$03,	$02,	$03,	$02
	smpsVcAttackRate	$1A,	$1C,	$1B,	$1C
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$03,	$04,	$09,	$04
	smpsVcDecayRate2	$00,	$03,	$01,	$03
	smpsVcDecayLevel	$0A,	$00,	$00,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$31,	$47,	$21

;	Voice 04
;	$3D,$02,$01,$02,$03,$8E,$52,$14,$4C,$08,$08,$0E,$03,$00,$00,$00,$00,$1F,$1F,$1F,$1F,$1B,$87,$87,$87
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$03,	$02,	$01,	$02
	smpsVcRateScale		$01,	$00,	$01,	$02
	smpsVcAttackRate	$0C,	$14,	$12,	$0E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$03,	$0E,	$08,	$08
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$87,	$87,	$87,	$1B

;	Voice 05
;	$2C,$72,$78,$34,$34,$1F,$12,$1F,$12,$00,$0A,$00,$0A,$00,$00,$00,$00,$0F,$1F,$0F,$1F,$16,$90,$17,$90
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
	smpsVcTotalLevel	$90,	$17,	$90,	$16
	even
