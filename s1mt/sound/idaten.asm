; =============================================================================================
; Project Name:		idaten
; Created:		3rd October 2015
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

idaten_Header:
;	Voice Pointer	location
	smpsHeaderVoice	idaten_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$01,	$00

;	DAC Pointer	location
	smpsHeaderDAC	idaten_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	idaten_FM1,	smpsPitch01hi,	$0B
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	idaten_FM2,	smpsPitch00,	$05
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	idaten_FM3,	smpsPitch00,	$1B
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	idaten_FM4,	smpsPitch00,	$1B
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	idaten_FM5,	smpsPitch00,	$13
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	idaten_PSG1,	smpsPitch03lo,	$05,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	idaten_PSG2,	smpsPitch03lo,	$06,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	idaten_PSG3,	smpsPitch00,	$02,	$00

; FM1 Data
idaten_FM1:
	dc.b		nRst,	$02
idaten_Jump01:
;	Set FM Voice	#
	smpsFMvoice	$07
;	Set Modulation	wait	speed	change	step
	smpsModSet	$40,	$02,	$02,	$02
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Alter Volume	value
	smpsAlterVol	$10
	dc.b		nC4,	$60,	nEb4,	nC4,	nEb4
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Alter Volume	value
	smpsAlterVol	$F0
;	Set FM Voice	#
	smpsFMvoice	$01
;	Call At	 	location
	smpsCall	idaten_Call01
	dc.b		nEb1,	$06,	nRst,	nEb1,	nRst,	$0C,	nEb1,	nEb1
	dc.b		$06,	nEb1,	nRst,	$0C,	nCs1,	nRst,	$06,	nEb1
	dc.b		$0C
;	Call At	 	location
	smpsCall	idaten_Call01
	dc.b		nCs1,	$12,	nEb1,	$0C,	nRst,	$42
;	Alter Volume	value
	smpsAlterVol	$03
;	Call At	 	location
	smpsCall	idaten_Call02
	dc.b		nEb2,	nRst,	nEb2,	nRst,	nRst,	nEb2,	nRst,	$18
	dc.b		nCs2,	$06,	nRst,	$12,	nEb2,	$06,	nRst
;	Alter Pitch	value
	smpsAlterPitch	$03
;	Call At	 	location
	smpsCall	idaten_Call02
;	Alter Pitch	value
	smpsAlterPitch	$FD
	dc.b		nEb2,	nRst,	nEb2,	nRst,	$1E,	nEb2,	$06,	nRst
	dc.b		$0C,	nCs2,	$12,	nEb2,	$0C
;	Call At	 	location
	smpsCall	idaten_Call02
	dc.b		nEb2,	nRst,	nEb2,	nRst,	nRst,	nEb2,	nRst,	$18
	dc.b		nEb2,	$06,	nRst,	$12,	nEb2,	$06,	nRst,	$06
;	Alter Pitch	value
	smpsAlterPitch	$03
;	Call At	 	location
	smpsCall	idaten_Call02
;	Alter Pitch	value
	smpsAlterPitch	$FD
	dc.b		nEb2,	nRst,	nEb2,	nRst,	$0C,	nEb2,	nEb2,	$06
	dc.b		nBb1,	$12,	nCs2,	nEb2,	$0C
;	Alter Volume	value
	smpsAlterVol	$FD
idaten_Loop01:
;	Call At	 	location
	smpsCall	idaten_Call03
;	Call At	 	location
	smpsCall	idaten_Call03
;	Alter Pitch	value
	smpsAlterPitch	$FE
;	Call At	 	location
	smpsCall	idaten_Call03
;	Call At	 	location
	smpsCall	idaten_Call03
;	Alter Pitch	value
	smpsAlterPitch	$02
;	Call At	 	location
	smpsCall	idaten_Call03
;	Call At	 	location
	smpsCall	idaten_Call03
;	Alter Pitch	value
	smpsAlterPitch	$FC
;	Call At	 	location
	smpsCall	idaten_Call03
;	Alter Pitch	value
	smpsAlterPitch	$04
	dc.b		nCs1,	$06,	nRst,	nCs1,	nRst,	$0C,	nCs1,	nCs1
	dc.b		$06,	nRst,	$0C,	nEb1,	$12,	nRst,	$06,	nF1
	dc.b		$0C
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	idaten_Loop01
idaten_Loop02:
;	Call At	 	location
	smpsCall	idaten_Call04
	dc.b		nBb1,	$06,	nRst,	nBb1,	$06,	nRst,	$0C,	nBb1
	dc.b		$12,	$06,	nRst,	$0C,	nBb1,	$12,	$0C
;	Call At	 	location
	smpsCall	idaten_Call04
	dc.b		nEb1,	$06,	nRst,	nEb1,	nRst,	$0C,	nEb1,	$12
	dc.b		nEb1,	$06,	nRst,	$0C,	nCs1,	$12,	nEb1,	$06
	dc.b		nRst
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	idaten_Loop02
;	Jump To	 	location
	smpsJump	idaten_Jump01

idaten_Call01:
	dc.b		nBb1,	$06,	nRst,	nBb1,	nRst,	$0C,	nBb1,	nBb1
	dc.b		$06,	nRst,	$0C,	nBb1,	$12,	nRst,	$06,	nBb1
	dc.b		$0C,	nBb1,	$06,	nRst,	nBb1,	nRst,	$0C,	nBb1
	dc.b		nBb1,	$06,	nRst,	$0C,	nBb1,	$12,	nRst,	$06
	dc.b		nBb1,	$0C,	nBb1,	$06,	nRst,	nBb1,	nRst,	$0C
	dc.b		nBb1,	nBb1,	$06,	nRst,	$0C,	nBb1,	$12,	nRst
	dc.b		$06,	nBb1,	$0C
	smpsReturn

idaten_Call02:
	dc.b		nBb1,	$0C,	$06,	nRst,	nRst,	nBb1,	nRst,	$18
	dc.b		nBb1,	$06,	nRst,	$12,	nBb1,	$06,	nRst,	$06
	smpsReturn

idaten_Call03:
	dc.b		nF1,	$06,	nRst,	nF1,	nRst,	$0C,	nF1,	nF1
	dc.b		$06,	nRst,	$0C,	nF1,	$12,	nRst,	$06,	nF1
	dc.b		$0C
	smpsReturn

idaten_Call04:
	dc.b		nBb1,	$06,	nRst,	nBb1,	nRst,	$0C,	nBb1,	$12
	dc.b		$06,	nRst,	nBb1,	$06,	nRst,	$0C,	nBb1,	$12
	smpsReturn

; FM4 Data
idaten_FM4:
	dc.b		nRst,	$02
idaten_Jump02:
;	Set FM Voice	#
	smpsFMvoice	$00
;	Alter Volume	value
	smpsAlterVol	$14
	dc.b		nRst,	$03
;	Call At	 	location
	smpsCall	idaten_Call05
	dc.b		nBb4,	$03
;	Alter Volume	value
	smpsAlterVol	$EC
;	Set FM Voice	#
	smpsFMvoice	$07
;	Set Modulation	wait	speed	change	step
	smpsModSet	$30,	$03,	$01,	$01
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Call At	 	location
	smpsCall	idaten_Call06
	dc.b		nEb5,	$48,	nCs5,	$0C,	nC5
;	Call At	 	location
	smpsCall	idaten_Call06
	dc.b		nEb5,	$12,	$0C,	nRst,	$18,	$0C,	nRst,	$06
	dc.b		$0C,	nRst,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
;	Alter Volume	value
	smpsAlterVol	$F9
;	Call At	 	location
	smpsCall	idaten_Call07
	dc.b		nBb3,	nCs4,	nEb4,	$0C
;	Call At	 	location
	smpsCall	idaten_Call07
	dc.b		nEb4,	nCs4,	nEb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$07
;	Set FM Voice	#
	smpsFMvoice	$06
;	Call At	 	location
	smpsCall	idaten_Call08
;	Call At	 	location
	smpsCall	idaten_Call08
;	Set FM Voice	#
	smpsFMvoice	$07
idaten_Loop03:
;	Call At	 	location
	smpsCall	idaten_Call09
	dc.b		nC4,	nEb4,	nG4,	$0C
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	idaten_Loop03
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Alter Volume	value
	smpsAlterVol	$06
;	Call At	 	location
	smpsCall	idaten_Call09
	dc.b		nC4,	nEb4,	nG4,	$0C
;	Call At	 	location
	smpsCall	idaten_Call09
	dc.b		nC5,	nEb5,	nG5,	$0C
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Alter Volume	value
	smpsAlterVol	$FA
;	Jump To	 	location
	smpsJump	idaten_Jump02

idaten_Call05:
	dc.b		nF5,	$06,	nC5,	nC5,	nG5,	nC5,	nC5,	nAb5
	dc.b		nC5,	nC5,	nG5,	nC5,	nC5,	nF5,	nC5,	nG5
	dc.b		nC5,	nG5,	nC5,	nC5,	nAb5,	nC5,	nC5,	nBb5
	dc.b		nC5,	nC5,	nAb5,	nC5,	nC5,	nG5,	nC5,	nAb5
	dc.b		nC5,	nF5,	nC5,	nC5,	nG5,	nC5,	nC5,	nAb5
	dc.b		nC5,	nC5,	nG5,	nC5,	nC5,	nF5,	nC5,	nG5
	dc.b		nC5,	nEb5,	nC5,	nC5,	nAb5,	nEb4,	nEb4,	nBb5
	dc.b		nEb4,	nEb4,	nEb5,	nBb4,	nBb4,	nG5,	nBb4,	nAb5
	smpsReturn

idaten_Call06:
	dc.b		nF4,	$48,	nBb4,	$18,	nG4,	$60,	nF4,	$48
	dc.b		nBb4,	$18
	smpsReturn

idaten_Call07:
	dc.b		nRst,	$0C,	nF3,	$12,	$1E,	$18,	$0C,	nRst
	dc.b		$0C,	nF3,	$12,	$1E,	$18,	$0C,	nRst,	$0C
	dc.b		nF4,	$12,	$1E,	nCs4,	$18,	$0C,	nRst,	$0C
	dc.b		nEb4,	nEb4,	$06,	$12
	smpsReturn

idaten_Call08:
	dc.b		nAb4,	$60,	nG4,	nFs4,	nAb4,	nG4,	nEb4,	nCs4
	dc.b		nRst,	$0C,	nAb4,	$18,	$0C,	nG4,	nAb4,	$18
	dc.b		nBb4,	$0C
	smpsReturn

idaten_Call09:
	dc.b		nRst,	$0C,	nAb4,	$12,	$1E,	$12,	nAb4,	nRst
	dc.b		$0C,	nG4,	$12,	nG4
	smpsReturn

; FM3 Data
idaten_FM3:
	dc.b		nRst,	$02
idaten_Jump03:
;	Set FM Voice	#
	smpsFMvoice	$07
;	Set Modulation	wait	speed	change	step
	smpsModSet	$40,	$02,	$02,	$02
;	Call At	 	location
	smpsCall	idaten_Call0A
;	Call At	 	location
	smpsCall	idaten_Call0A
;	Set Modulation	wait	speed	change	step
	smpsModSet	$30,	$03,	$01,	$01
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Call At	 	location
	smpsCall	idaten_Call0B
	dc.b		nG4,	$30,	smpsNoAttack,	$18,	nF4,	$0C,	nEb4
;	Call At	 	location
	smpsCall	idaten_Call0B
	dc.b		nF4,	$12,	$0C,	nRst,	$18,	$06,	nRst,	$0C
	dc.b		$06,	nRst,	$12
;	Set FM Voice	#
	smpsFMvoice	$02
;	Alter Volume	value
	smpsAlterVol	$F9
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
;	Call At	 	location
	smpsCall	idaten_Call0C
	dc.b		nRst,	$0C,	nC4,	nC4,	$06,	$12,	nG3,	nBb3
	dc.b		nC4,	$0C
;	Call At	 	location
	smpsCall	idaten_Call0C
	dc.b		nRst,	$0C,	nBb3,	nBb3,	$06,	$12,	nBb3,	nAb3
	dc.b		nBb3,	$0C
;	Alter Volume	value
	smpsAlterVol	$07
;	Set FM Voice	#
	smpsFMvoice	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Call At	 	location
	smpsCall	idaten_Call0D
;	Call At	 	location
	smpsCall	idaten_Call0D
;	Set FM Voice	#
	smpsFMvoice	$07
idaten_Loop04:
;	Call At	 	location
	smpsCall	idaten_Call0E
	dc.b		nBb3,	nC4,	nEb4,	$0C
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	idaten_Loop04
;	Call At	 	location
	smpsCall	idaten_Call0E
	dc.b		nBb4,	nC5,	nEb5,	$0C
;	Jump To	 	location
	smpsJump	idaten_Jump03

idaten_Call0A:
	dc.b		nF3,	$60,	nAb3
	smpsReturn

idaten_Call0B:
	dc.b		nBb3,	$30,	smpsNoAttack,	$18,	nF4,	nEb4,	$30,	smpsNoAttack
	dc.b		$30,	nBb3,	smpsNoAttack,	$18,	nF4
	smpsReturn

idaten_Call0C:
	dc.b		nRst,	$0C,	nCs4,	$12,	$1E,	$18,	$0C,	nRst
	dc.b		$0C,	nEb4,	$12,	$1E,	$18,	$0C,	nRst,	$0C
	dc.b		nCs4,	$12,	$1E,	nBb3,	$18,	$0C
	smpsReturn

idaten_Call0D:
	dc.b		nF4,	$60,	nEb4,	nCs4,	nEb4,	nEb4,	nC4,	nBb3
	dc.b		nRst,	$0C,	nCs4,	nC4,	nCs4,	$18,	nEb4,	nF4
	dc.b		$0C
	smpsReturn

idaten_Call0E:
	dc.b		nRst,	$0C,	nF4,	$12,	$1E,	$12,	nF4,	nRst
	dc.b		$0C,	nEb4,	$12,	nEb4
	smpsReturn

; FM5 Data
idaten_FM5:
	dc.b		nRst,	$02
idaten_Jump04:
;	Set FM Voice	#
	smpsFMvoice	$00
;	Call At	 	location
	smpsCall	idaten_Call05
	dc.b		nBb4
;	Alter Volume	value
	smpsAlterVol	$FA
;	Call At	 	location
	smpsCall	idaten_Call05
	dc.b		nBb4,	nF5,	$06,	nC5,	nC5,	nG5,	nC5,	nC5
	dc.b		nAb5,	nC5,	nC5,	nG5,	nC5,	nC5,	nF5,	nC5
	dc.b		nG5,	nC5,	nG5,	nC5,	nC5,	nAb5,	nC5,	nC5
	dc.b		nBb5,	nC5,	nC5,	nAb5,	nC5,	nC5,	nG5,	nC5
	dc.b		nAb5,	nC5,	nF5,	nC5,	nC5,	nG5,	nC5,	nC5
	dc.b		nAb5,	nC5,	nC5,	nG5,	nC5,	nC5,	nF5,	nC5
	dc.b		nG5,	nC5,	nEb5,	$0C,	nRst,	$06,	nEb5,	nRst
	dc.b		$48
;	Alter Volume	value
	smpsAlterVol	$06
;	Set FM Voice	#
	smpsFMvoice	$08
;	Alter Notes	value
	smpsAlterNote	$01
;	Alter Volume	value
	smpsAlterVol	$0C
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nRst,	$0C,	nC6,	$03,	nCs6,	$30,	smpsNoAttack,	$0F
	dc.b		nD6,	$03,	nEb6,	$1B,	nG5,	$30,	smpsNoAttack,	$1E
	dc.b		nF5,	$06,	nAb5,	nC6,	nF6,	nG6,	nRst,	nF6
	dc.b		nRst,	nCs6,	nAb5,	nRst,	nG5,	$30,	nAb5,	$12
	dc.b		nG5,	nAb5,	$0C,	nA5,	$03,	nBb5,	$15,	nG5
	dc.b		$18,	nE5,	$03,	nF5,	$30,	smpsNoAttack,	$0F,	nA5
	dc.b		$03,	nBb5,	$1B,	nG5,	$30,	nAb5,	$12,	nG5
	dc.b		nAb5,	$0C,	nF5,	$12,	nCs5,	nF5,	$0C,	nAb5
	dc.b		$12,	nG5,	nAb5,	$0C,	nA5,	$03,	nBb5,	$2D
	dc.b		nEb6,	$24
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Notes	value
	smpsAlterNote	$00
;	Alter Volume	value
	smpsAlterVol	$F4
;	Alter Volume	value
	smpsAlterVol	$FA
idaten_Loop05:
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nF5,	$06,	nC5,	nC5,	nG5,	nC5,	nC5,	nAb5
	dc.b		nC5,	nC5,	nG5,	nC5,	nC5,	nF5,	nC5,	nG5
	dc.b		nC5,	nG5,	nC5,	nC5,	nAb5,	nC5,	nC5,	nBb5
	dc.b		nC5,	nC5,	nAb5,	nC5,	nC5,	nG5,	nC5,	nAb5
	dc.b		nC5,	nFs5,	nCs5,	nCs5,	nEb5,	nCs5,	nCs5,	nCs6
	dc.b		nCs5,	nCs5,	nC6,	nCs5,	nCs5,	nCs6,	nCs5,	nEb6
	dc.b		nCs5,	nEb5,	nAb4,	nAb4,	nAb5,	nEb4,	nEb4,	nBb5
	dc.b		nEb4,	nEb4,	nEb5,	nBb4,	nBb4,	nAb5,	nBb4,	nBb4
	dc.b		nAb5,	nF5,	nC5,	nC5,	nG5,	nC5,	nC5,	nAb5
	dc.b		nC5,	nC5,	nG5,	nC5,	nC5,	nF5,	nC5,	nG5
	dc.b		nC5,	nG5,	nC5,	nC5,	nAb5,	nC5,	nC5,	nBb5
	dc.b		nC5,	nC5,	nAb5,	nC5,	nC5,	nAb5,	nEb5,	nBb5
	dc.b		nEb5,	nBb5,	nCs5,	nCs5,	nAb5,	nCs5,	nCs5,	nBb5
	dc.b		nCs5,	nCs5,	nAb5,	nCs5,	nCs5,	nBb5,	nCs5,	nAb5
	dc.b		nCs5,	nEb5,	nAb4,	nAb4,	nAb5,	nEb4,	nEb4,	nAb5
	dc.b		nEb4,	nEb4,	nEb5,	nBb4,	nBb4,	nAb5,	nEb4,	nEb4
	dc.b		nEb5
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	idaten_Loop05
;	Set FM Voice	#
	smpsFMvoice	$00
idaten_Loop06:
	dc.b		nC7,	$18
;	Alter Volume	value
	smpsAlterVol	$02
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$07,	idaten_Loop06
	dc.b		nC7,	$0C
;	Alter Volume	value
	smpsAlterVol	$F2
	dc.b		nC7,	$06,	$06
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$02,	idaten_Loop06
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nC7,	$08,	$08,	$08
;	Alter Volume	value
	smpsAlterVol	$04
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
idaten_Loop07:
	dc.b		nC7,	$08,	$08,	$08
;	Alter Volume	value
	smpsAlterVol	$04
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$06,	idaten_Loop07
	dc.b		nC7,	$0C
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Volume	value
	smpsAlterVol	$E0
	dc.b		nC7,	$06,	$06
idaten_Loop08:
	dc.b		nC7,	$18
;	Alter Volume	value
	smpsAlterVol	$02
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	idaten_Loop08
;	Alter Volume	value
	smpsAlterVol	$F0
;	Alter Volume	value
	smpsAlterVol	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Jump To	 	location
	smpsJump	idaten_Jump04

; FM2 Data
idaten_FM2:
	dc.b		nRst,	$02
idaten_Jump05:
;	Set FM Voice	#
	smpsFMvoice	$04
;	Alter Volume	value
	smpsAlterVol	$08
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$E7,	$01
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nRst,	$30,	nD3,	$06,	$12,	$0C,	$06,	nD3
	dc.b		smpsNoAttack,	nRst,	$60
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nRst,	$30,	nD3,	$0C,	$06,	$12,	$06,	nD3
	dc.b		smpsNoAttack,	nRst,	$60,	$00
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Volume	value
	smpsAlterVol	$F8
;	Set FM Voice	#
	smpsFMvoice	$08
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0C,	$02,	$03,	$03
;	Alter Volume	value
	smpsAlterVol	$0F
;	Call At	 	location
	smpsCall	idaten_Call0F
	dc.b		nEb5,	$12,	$0C,	nRst,	$1E
;	Set FM Voice	#
	smpsFMvoice	$04
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Volume	value
	smpsAlterVol	$F4
;	Set Modulation	wait	speed	change	step
	smpsModSet	$01,	$01,	$E7,	$01
	dc.b		nRst,	$0C,	nD3,	$06,	smpsNoAttack,	$12
;	Alter Volume	value
	smpsAlterVol	$0C
;	Set FM Voice	#
	smpsFMvoice	$08
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0C,	$02,	$03,	$03
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Call At	 	location
	smpsCall	idaten_Call10
;	Set FM Voice	#
	smpsFMvoice	$05
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
idaten_Loop09:
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nF6,	$0C
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nBb6
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nC7
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$05,	idaten_Loop09
	dc.b		nF6
idaten_Loop0A:
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nEb6
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nAb6
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nBb6
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$05,	idaten_Loop0A
	dc.b		nEb6
;	Alter Volume	value
	smpsAlterVol	$C4
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Alter Volume	value
	smpsAlterVol	$14
;	Set FM Voice	#
	smpsFMvoice	$07
	dc.b		nG4,	$60,	nEb4,	nCs4,	nRst,	$0C,	nAb4,	$18
	dc.b		$0C,	nG4,	nAb4,	$18,	nBb4,	$0C
;	Alter Volume	value
	smpsAlterVol	$E0
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nRst,	$30,	nRst,	$0C,	nC4,	nEb4,	nF4,	nBb4
	dc.b		$12,	nC5,	nEb5,	$0C,	nF5,	$12,	nBb5,	nC6
	dc.b		$0C,	nFs5,	$3C,	nEb6,	$03,	nF6,	$09,	nEb6
	dc.b		$0C,	nC6,	nEb6,	$03,	nF6,	$09,	nEb6,	$06
	dc.b		nC6,	nBb5,	$0C,	nAb5,	$18,	nF5,	$0C,	nAb5
	dc.b		nBb5,	nRst,	$30,	nRst,	$0C
;	Alter Volume	value
	smpsAlterVol	$FD
	dc.b		nAb5
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		nG5,	nEb5,	nBb4,	$12,	nC5,	nEb5,	$0C,	nF5
	dc.b		$12,	nBb5,	nC6,	$0C,	nCs6,	$3C,	nEb6,	$03
	dc.b		nF6,	nRst,	$06,	nEb6,	$0C,	nF6,	nBb6,	$60
	dc.b		nC7,	$30
idaten_Loop0B:
	dc.b		smpsNoAttack,	nC7,	$06
;	Alter Volume	value
	smpsAlterVol	$01
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$28,	idaten_Loop0B
;	Alter Volume	value
	smpsAlterVol	$D5
	dc.b		nRst,	$60
;	Alter Volume	value
	smpsAlterVol	$14
;	Set FM Voice	#
	smpsFMvoice	$07
	dc.b		nRst,	$0C,	nAb4,	$12,	$1E,	$12,	nAb4,	nRst
	dc.b		$0C,	nG4,	$12,	nG4,	nC4,	nEb4,	nG4,	$0C
	dc.b		nRst,	$0C,	nAb4,	$12,	$1E,	$12,	nAb4,	nRst
	dc.b		$0C,	nG4,	$12,	nG4,	nC5,	nEb5,	nG5,	$0C
;	Alter Volume	value
	smpsAlterVol	$EC
;	Jump To	 	location
	smpsJump	idaten_Jump05

idaten_Call0F:
	dc.b		nC4,	$03,	nCs4,	nF4,	nG4,	smpsNoAttack,	nF4,	$24
	dc.b		nC5,	$12,	nBb4,	nAb4,	$0C,	nG4,	$12,	nAb4
	dc.b		nBb4,	$0C,	nEb4,	$30,	nC4,	$03,	nCs4,	nF4
	dc.b		nG4,	smpsNoAttack,	nF4,	$24,	nC5,	$12,	nBb4,	nAb4
	dc.b		$0C,	nG4,	$12,	nAb4,	nBb4,	$0C,	nEb5,	$30
	dc.b		nG4,	$03,	nAb4,	nF5,	$2A,	nC6,	$12,	nBb5
	dc.b		nAb5,	$0C,	nG5,	$12,	nAb5,	nBb5,	$0C,	nEb5
	dc.b		$30,	nG4,	$03,	nAb4,	nF5,	$2A,	nC6,	$12
	dc.b		nBb5,	nAb5,	$0C
	smpsReturn

idaten_Call10:
	dc.b		nC6,	$03,	nCs6,	$30,	smpsNoAttack,	$0F,	nD6,	$03
	dc.b		nEb6,	$1B,	nG5,	$30,	smpsNoAttack,	$1E,	nF5,	$06
	dc.b		nAb5,	nC6,	nF6,	nG6,	nRst,	nF6,	nRst,	nCs6
	dc.b		nAb5,	nRst,	nG5,	$30,	nAb5,	$12,	nG5,	nAb5
	dc.b		$0C,	nA5,	$03,	nBb5,	$15,	nG5,	$18,	nE5
	dc.b		$03,	nF5,	$30,	smpsNoAttack,	$0F,	nA5,	$03,	nBb5
	dc.b		$1B,	nG5,	$30,	nAb5,	$12,	nG5,	nAb5,	$0C
	dc.b		nF5,	$12,	nCs5,	nF5,	$0C,	nAb5,	$12,	nG5
	dc.b		nAb5,	$0C,	nA5,	$03,	nBb5,	$2D,	nEb6,	$30
	smpsReturn

; PSG1 Data
idaten_PSG1:
	dc.b		nRst,	$02
idaten_Jump06:
;	Set Modulation	wait	speed	change	step
	smpsModSet	$10,	$02,	$02,	$02
	dc.b		nRst,	$60,	nRst,	nRst,	nRst
;	Call At	 	location
	smpsCall	idaten_Call0F
	dc.b		nEb5,	$12,	$0C,	nRst,	$42
;	Call At	 	location
	smpsCall	idaten_Call10
;	Call At	 	location
	smpsCall	idaten_Call11
;	Call At	 	location
	smpsCall	idaten_Call12
	dc.b		smpsModOn
idaten_Loop0C:
	dc.b		smpsNoAttack,	nC7,	$30
;	Set Volume	value
	smpsSetVol	$01
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$06,	idaten_Loop0C
;	Set Volume	value
	smpsSetVol	$FA
	dc.b		nRst,	$60,	nRst,	nRst,	nRst,	nRst
;	Jump To	 	location
	smpsJump	idaten_Jump06

idaten_Call11:
	dc.b		nRst,	$60
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	idaten_Call11
	smpsReturn

idaten_Call12:
	dc.b		nRst,	$30,	nRst,	$0C,	nC4,	nEb4,	nF4,	nBb4
	dc.b		$12,	nC5,	nEb5,	$0C,	nF5,	$12,	nBb5,	nC6
	dc.b		$0C,	nFs5,	$30,	smpsNoAttack,	$0C,	nEb6,	$03,	nF6
	dc.b		$09,	nEb6,	$0C,	nC6,	nEb6,	$03,	nF6,	$09
	dc.b		nEb6,	$06,	nC6,	nBb5,	$0C,	nAb5,	$18,	nF5
	dc.b		$0C,	nAb5,	nBb5,	nRst,	$30,	nRst,	$0C,	nAb5
	dc.b		nG5,	nEb5,	nBb4,	$12,	nC5,	nEb5,	$0C,	nF5
	dc.b		$12,	nBb5,	nC6,	$0C,	nCs6,	$30,	smpsNoAttack,	$0C
	dc.b		nEb6,	$03,	nF6,	nRst,	$06,	nEb6,	$0C,	nF6
	dc.b		nBb6,	$30,	smpsNoAttack,	$30
	smpsReturn

; PSG2 Data
idaten_PSG2:
	dc.b		nRst,	$02,	nRst,	$06
idaten_Jump07:
;	Set Modulation	wait	speed	change	step
	smpsModSet	$13,	$02,	$02,	$02
	dc.b		nRst,	$60,	nRst,	nRst,	nRst
;	Alter Notes	value
	smpsAlterNote	$01
;	Call At	 	location
	smpsCall	idaten_Call0F
	dc.b		nEb5,	$12,	$0C,	nRst,	$42
;	Alter Notes	value
	smpsAlterNote	$00
;	Call At	 	location
	smpsCall	idaten_Call10
;	Call At	 	location
	smpsCall	idaten_Call11
;	Call At	 	location
	smpsCall	idaten_Call12
	dc.b		smpsModOn
idaten_Loop0D:
	dc.b		smpsNoAttack,	nC7,	$30
;	Set Volume	value
	smpsSetVol	$01
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$06,	idaten_Loop0D
;	Set Volume	value
	smpsSetVol	$FA
	dc.b		nRst,	$60,	nRst,	nRst,	nRst,	nRst
;	Jump To	 	location
	smpsJump	idaten_Jump07

; DAC Data
idaten_DAC:
	dc.b		$02
idaten_Loop0E:
	dc.b		dSnare,	$18,	dSnare,	dSnare,	dSnare
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	idaten_Loop0E
	dc.b		dSnare,	$18,	dSnare,	dSnare,	dHiTimpani
idaten_Loop0F:
;	Call At	 	location
	smpsCall	idaten_Call13
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	idaten_Loop0F
	dc.b		dSnare,	$18,	dHiTimpani,	dHiTimpani,	$12,	dHiTimpani,	dHiTimpani,	$0C
idaten_Loop10:
;	Call At	 	location
	smpsCall	idaten_Call13
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	idaten_Loop10
	dc.b		dSnare,	$12,	dHiTimpani,	$2A,	dSnare,	$0C,	dHiTimpani,	$18
	dc.b		dSnare,	dHiTimpani,	dSnare,	dHiTimpani
;	Call At	 	location
	smpsCall	idaten_Call14
	dc.b		dSnare,	dHiTimpani,	dSnare,	dHiTimpani,	dSnare,	dHiTimpani,	dSnare,	dHiTimpani
;	Call At	 	location
	smpsCall	idaten_Call14
	dc.b		dSnare,	dHiTimpani,	$12,	dSnare,	$06,	dHiTimpani,	$0C,	dSnare
	dc.b		$06,	dSnare,	dHiTimpani,	$03,	$0F,	$06
idaten_Loop11:
;	Call At	 	location
	smpsCall	idaten_Call13
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	idaten_Loop11
	dc.b		dSnare,	$18,	dHiTimpani,	dSnare,	dHiTimpani,	$0C,	dLowTimpani
idaten_Loop12:
;	Call At	 	location
	smpsCall	idaten_Call13
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	idaten_Loop12
	dc.b		dSnare,	$18,	dHiTimpani,	$12,	dHiTimpani,	$06,	dMidTimpani,	dLowTimpani
	dc.b		dSnare,	$0C,	dHiTimpani,	dHiTimpani,	$06,	dHiTimpani
idaten_Loop13:
;	Call At	 	location
	smpsCall	idaten_Call13
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	idaten_Loop13
	dc.b		dSnare,	$18,	dHiTimpani,	$24,	dSnare,	$0C,	dHiTimpani,	$18
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$02,	idaten_Loop13
idaten_Loop14:
;	Call At	 	location
	smpsCall	idaten_Call13
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	idaten_Loop14
	dc.b		dSnare,	$18,	dHiTimpani,	dSnare,	$0C,	dHiTimpani,	nRst,	dHiTimpani
idaten_Loop15:
;	Call At	 	location
	smpsCall	idaten_Call13
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	idaten_Loop15
	dc.b		dSnare,	$18,	dHiTimpani,	dSnare,	$06,	nRst,	dHiTimpani,	dHiTimpani
	dc.b		dSnare,	nRst,	dHiTimpani,	dHiTimpani
;	Call At	 	location
	smpsCall	idaten_Call13
;	Call At	 	location
	smpsCall	idaten_Call13
;	Call At	 	location
	smpsCall	idaten_Call13
	dc.b		dSnare,	dHiTimpani,	dHiTimpani,	$12,	dMidTimpani,	dLowTimpani,	$0C
;	Jump To	 	location
	smpsJump	idaten_Loop0F

idaten_Call13:
	dc.b		dSnare,	$18,	dHiTimpani,	dSnare,	dHiTimpani
	smpsReturn

idaten_Call14:
	dc.b		dSnare,	dHiTimpani,	$24,	dSnare,	$06,	dSnare,	dHiTimpani,	$18
	dc.b		dSnare,	dHiTimpani,	dSnare,	dHiTimpani
	smpsReturn

; PSG3 Data
idaten_PSG3:
	dc.b		nRst,	$02
;	Set PSG WvForm	#
	smpsPSGform	$E7
;	Set PSG Voice	#
	smpsPSGvoice	$03
;	Set Volume	value
	smpsSetVol	$02
;	Set PSG Voice	#
	smpsPSGvoice	$0A
	dc.b		nAb5,	$60,	nRst,	nRst,	nRst
;	Set Volume	value
	smpsSetVol	$FE
idaten_Loop16:
;	Set PSG Voice	#
	smpsPSGvoice	$03
	dc.b		nA5,	$0C,	$06,	$06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$0C,	idaten_Loop16
	dc.b		nA5,	$0C,	$06,	nA5,	nA5,	$0C,	$06,	nA5
;	Set Volume	value
	smpsSetVol	$02
;	Set PSG Voice	#
	smpsPSGvoice	$0A
	dc.b		nAb5,	$12,	nAb5,	nAb5,	$0C
;	Set Volume	value
	smpsSetVol	$FE
idaten_Loop17:
;	Set PSG Voice	#
	smpsPSGvoice	$03
	dc.b		nA5,	$0C,	$06,	$06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$0C,	idaten_Loop17
;	Set Volume	value
	smpsSetVol	$04
;	Set PSG Voice	#
	smpsPSGvoice	$0A
	dc.b		nAb5,	$12,	$30,	smpsNoAttack,	$06,	nRst,	$18
;	Set PSG Voice	#
	smpsPSGvoice	$03
;	Set Volume	value
	smpsSetVol	$FC
idaten_Loop18:
	dc.b		nA5,	$0C,	$06,	$06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$1C,	idaten_Loop18
;	Set PSG Voice	#
	smpsPSGvoice	$03
	dc.b		nA5,	$0C,	$06,	$06,	$0C,	$06,	$06,	nA5
	dc.b		$06,	nA5,	nA5,	nA5,	nA5,	nA5,	nA5,	nA5
;	Set Volume	value
	smpsSetVol	$01
;	Set PSG Voice	#
	smpsPSGvoice	$0A
	dc.b		nAb5,	$60
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nRst,	$60,	nRst,	nRst,	nRst,	nRst,	nRst
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nRst,	$30,	nA5,	$18,	nA5
;	Set PSG Voice	#
	smpsPSGvoice	$03
;	Set Volume	value
	smpsSetVol	$FD
idaten_Loop19:
	dc.b		nA5,	$0C,	$06,	$06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$50,	idaten_Loop19
;	Jump To	 	location
	smpsJump	idaten_Loop16

idaten_Voices:
;	Voice 00
;	$38,$73,$03,$02,$31,$C8,$BF,$BF,$BF,$0B,$0B,$09,$0F,$08,$08,$08,$08,$23,$13,$25,$27,$1E,$1E,$1E,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$00,	$00,	$07
	smpsVcCoarseFreq	$01,	$02,	$03,	$03
	smpsVcRateScale		$02,	$02,	$02,	$03
	smpsVcAttackRate	$1F,	$1F,	$1F,	$08
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$09,	$0B,	$0B
	smpsVcDecayRate2	$08,	$08,	$08,	$08
	smpsVcDecayLevel	$02,	$02,	$01,	$02
	smpsVcReleaseRate	$07,	$05,	$03,	$03
	smpsVcTotalLevel	$80,	$1E,	$1E,	$1E

;	Voice 01
;	$08,$0A,$70,$30,$00,$1F,$1F,$5F,$5F,$12,$0E,$0A,$0A,$00,$04,$04,$03,$27,$27,$27,$27,$24,$2D,$13,$80
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
	smpsVcReleaseRate	$07,	$07,	$07,	$07
	smpsVcTotalLevel	$80,	$13,	$2D,	$24

;	Voice 02
;	$39,$73,$23,$22,$31,$DF,$DF,$DF,$DF,$07,$05,$05,$0A,$03,$03,$03,$03,$23,$13,$25,$27,$1D,$1D,$1D,$00
;				#
	smpsVcAlgorithm		$01
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$02,	$02,	$07
	smpsVcCoarseFreq	$01,	$02,	$03,	$03
	smpsVcRateScale		$03,	$03,	$03,	$03
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$05,	$05,	$07
	smpsVcDecayRate2	$03,	$03,	$03,	$03
	smpsVcDecayLevel	$02,	$02,	$01,	$02
	smpsVcReleaseRate	$07,	$05,	$03,	$03
	smpsVcTotalLevel	$00,	$1D,	$1D,	$1D

;	Voice 03
;	$3E,$11,$12,$12,$13,$0B,$0F,$8F,$0F,$07,$07,$07,$07,$02,$02,$02,$02,$23,$1F,$1F,$1F,$18,$8B,$8B,$8B
;				#
	smpsVcAlgorithm		$06
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$01,	$01,	$01,	$01
	smpsVcCoarseFreq	$03,	$02,	$02,	$01
	smpsVcRateScale		$00,	$02,	$00,	$00
	smpsVcAttackRate	$0F,	$0F,	$0F,	$0B
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$07,	$07,	$07,	$07
	smpsVcDecayRate2	$02,	$02,	$02,	$02
	smpsVcDecayLevel	$01,	$01,	$01,	$02
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$03
	smpsVcTotalLevel	$8B,	$8B,	$8B,	$18

;	Voice 04
;	$3E,$20,$0F,$0E,$0F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$0F,$0F,$0E,$0E,$0F,$0F,$0F,$0F,$0C,$00,$00,$00
;				#
	smpsVcAlgorithm		$06
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$02
	smpsVcCoarseFreq	$0F,	$0E,	$0F,	$00
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$1F,	$1F,	$1F
	smpsVcDecayRate2	$0E,	$0E,	$0F,	$0F
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$00,	$00,	$00,	$0C

;	Voice 05
;	$04,$35,$72,$54,$46,$1F,$1F,$1F,$1F,$07,$0A,$07,$0D,$00,$0B,$00,$0B,$1F,$0F,$1F,$0F,$23,$14,$1D,$00
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$04,	$05,	$07,	$03
	smpsVcCoarseFreq	$06,	$04,	$02,	$05
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0D,	$07,	$0A,	$07
	smpsVcDecayRate2	$0B,	$00,	$0B,	$00
	smpsVcDecayLevel	$00,	$01,	$00,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$00,	$1D,	$14,	$23

;	Voice 06
;	$3A,$32,$00,$02,$73,$9F,$8F,$4F,$4F,$0F,$0F,$0F,$0F,$02,$02,$02,$02,$1F,$0F,$0F,$0F,$17,$1F,$19,$00
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$00,	$00,	$03
	smpsVcCoarseFreq	$03,	$02,	$00,	$02
	smpsVcRateScale		$01,	$01,	$02,	$02
	smpsVcAttackRate	$0F,	$0F,	$0F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$0F,	$0F,	$0F
	smpsVcDecayRate2	$02,	$02,	$02,	$02
	smpsVcDecayLevel	$00,	$00,	$00,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$00,	$19,	$1F,	$17

;	Voice 07
;	$3A,$32,$00,$02,$73,$9F,$8F,$4F,$4F,$0F,$0F,$0F,$0F,$03,$03,$03,$03,$1F,$0F,$0F,$0F,$17,$1F,$19,$00
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$00,	$00,	$03
	smpsVcCoarseFreq	$03,	$02,	$00,	$02
	smpsVcRateScale		$01,	$01,	$02,	$02
	smpsVcAttackRate	$0F,	$0F,	$0F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$0F,	$0F,	$0F
	smpsVcDecayRate2	$03,	$03,	$03,	$03
	smpsVcDecayLevel	$00,	$00,	$00,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$00,	$19,	$1F,	$17

;	Voice 08
;	$3D,$01,$21,$51,$01,$12,$14,$14,$0F,$0A,$05,$05,$05,$00,$00,$00,$00,$2B,$2B,$2B,$1B,$19,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$05,	$02,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$0F,	$14,	$14,	$12
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$05,	$05,	$0A
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$01,	$02,	$02,	$02
	smpsVcReleaseRate	$0B,	$0B,	$0B,	$0B
	smpsVcTotalLevel	$80,	$80,	$80,	$19
	even
