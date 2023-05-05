; =============================================================================================
; Project Name:		Golden_Axe_3_Ancient_Mount
; Created:		17th January 2014
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

Golden_Axe_3_Ancient_Mount_Header:
;	Voice Pointer	location
	smpsHeaderVoice	Golden_Axe_3_Ancient_Mount_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$01,	$03

;	DAC Pointer	location
	smpsHeaderDAC	Golden_Axe_3_Ancient_Mount_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	Golden_Axe_3_Ancient_Mount_FM1,	smpsPitch00,	$14
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	Golden_Axe_3_Ancient_Mount_FM2,	smpsPitch00,	$0F
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	Golden_Axe_3_Ancient_Mount_FM3,	smpsPitch00,	$1C
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	Golden_Axe_3_Ancient_Mount_FM4,	smpsPitch00,	$1C
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	Golden_Axe_3_Ancient_Mount_FM5,	smpsPitch00,	$24
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Golden_Axe_3_Ancient_Mount_PSG1,	smpsPitch03lo,	$00,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Golden_Axe_3_Ancient_Mount_PSG2,	smpsPitch03lo,	$03,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Golden_Axe_3_Ancient_Mount_PSG3,	smpsPitch01lo+$02,	$03,	$00

; FM1 Data
Golden_Axe_3_Ancient_Mount_FM1:
;	Set FM Voice	#
	smpsFMvoice	$00
;	Alter Volume	value
	smpsAlterVol	$02
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0A,	$01,	$01,	$04
	dc.b		nD4,	$0C,	nA4,	nG4,	nA4,	$06,	nC4,	nRst
	dc.b		nD4,	nA4,	$0C,	nG4,	nA4,	$06,	nC4
;	Alter Volume	value
	smpsAlterVol	$FE
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	Golden_Axe_3_Ancient_Mount_FM1
	dc.b		nD4,	$0C,	nA4,	nG4,	nA4,	$06,	nC4,	nRst
;	Alter Volume	value
	smpsAlterVol	$FE
;	Alter Pitch	value
	smpsAlterPitch	$0C
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0A,	$04,	$01,	$04
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nG3,	nA3,	nG3,	nA3,	nG3,	nA3,	nC3
;	Alter Pitch	value
	smpsAlterPitch	$F4
;	Alter Volume	value
	smpsAlterVol	$02
;	Set FM Voice	#
	smpsFMvoice	$01
Golden_Axe_3_Ancient_Mount_Loop01:
;	Alter Volume	value
	smpsAlterVol	$FC
	dc.b		nD4,	$24,	nC4,	$06,	nD4,	nA4,	$30,	smpsNoAttack
	dc.b		$24,	nG4,	$06,	nA4,	nC5,	$18,	nB4,	$08
	dc.b		nA4,	nG4,	nF4,	$24,	nE4,	$06,	nD4,	nC4
	dc.b		$18,	smpsNoAttack,	$08,	nA3,	nC4,	nD4,	$30,	smpsNoAttack
	dc.b		$30
;	Alter Volume	value
	smpsAlterVol	$04
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	Golden_Axe_3_Ancient_Mount_Loop01
;	Alter Volume	value
	smpsAlterVol	$FA
	dc.b		nD5,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$18,	nE5
	dc.b		$0C,	nF5,	nG5,	$30,	nF5,	$18,	nE5,	$0C
	dc.b		nD5,	nD5,	$30,	nC5
;	Alter Volume	value
	smpsAlterVol	$06
;	Alter Volume	value
	smpsAlterVol	$FE
;	Set FM Voice	#
	smpsFMvoice	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$1B,	$03,	$01,	$18
;	Call At	 	location
	smpsCall	Golden_Axe_3_Ancient_Mount_Call01
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nA3,	nA4,	$0C
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nAb4,	$06,	nG4,	nF4,	nE4
;	Call At	 	location
	smpsCall	Golden_Axe_3_Ancient_Mount_Call01
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nA3,	nA4,	$0C
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nAb4,	$06,	nG4,	nAb4,	nA4
;	Set FM Voice	#
	smpsFMvoice	$01
;	Alter Volume	value
	smpsAlterVol	$FA
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0A,	$01,	$01,	$04
	dc.b		nF5,	$24,	nG5,	$0C
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nF5,	nE5,	nD5,	nC5,	nBb4,	$06,	$0C,	nBb4
	dc.b		nBb4,	$06,	nBb4,	nBb4,	nC5,	$18,	nD5,	$0C
	dc.b		nE5,	nG5,	$06,	nF5,	nE5,	nF5,	nG5,	nF5
	dc.b		nE5,	nD5,	nRst,	nF5,	nE5,	nD5,	nE5,	nD5
	dc.b		nC5,	nA4
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD5,	$24,	nF5,	$0C,	nE5,	$18,	nC5
;	Alter Volume	value
	smpsAlterVol	$02
	dc.b		nD5,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30
	dc.b		nD6,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$18,	nC6
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nRst,	$0C,	nF4,	nF4,	$06,	nE4,	nF4,	nG4
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nF4,	nE4,	nD4,	nC4,	nC4,	$0C,	nD4,	$06
	dc.b		nC4
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nBb3,	nBb3,	$0C,	nBb3,	nBb3,	$06,	nBb3,	nBb3
	dc.b		nC4,	nC4,	$0C,	nCs4,	nA3,	$06,	nCs4,	nE4
	dc.b		nRst,	$0C,	nF4,	nF4,	$06,	nE4,	nF4,	nG4
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nF4,	nE4,	nD4,	nC4,	nC4,	$0C,	nD4,	$06
	dc.b		nC4
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nBb3,	nBb3,	$0C,	nBb3,	nBb3,	$06,	nBb3,	nBb3
	dc.b		nC4,	nC4,	$0C,	nCs4,	nA3,	$06,	nCs4,	nE4
;	Note Fill	duration
	smpsNoteFill	$00
;	Alter Volume	value
	smpsAlterVol	$06
;	Jump To	 	location
	smpsJump	Golden_Axe_3_Ancient_Mount_FM1

Golden_Axe_3_Ancient_Mount_Call01:
	dc.b		nRst,	$30,	nRst,	$06,	nD5,	nA4,	nAb4,	nG4
	dc.b		nF4,	nE4,	nD4,	nRst,	$30,	nRst,	$06
	smpsReturn

; FM2 Data
Golden_Axe_3_Ancient_Mount_FM2:
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nD2,	$0C,	nD2,	nRst,	nD2,	$06,	nD2,	nD2
	dc.b		$0C,	nD2,	nRst,	$06,	nG1,	nA1,	nC2,	nD2
	dc.b		$0C,	nD2,	nRst,	nD2,	$06,	nD2,	nD2,	$0C
	dc.b		nD2,	nRst,	$06,	nG2,	nA2,	nC2,	nD2,	$0C
	dc.b		nD2,	nRst,	nD2,	$06,	nD2,	nD2,	$0C,	nD2
	dc.b		nRst,	$06,	nG1,	nA1,	nC2,	nD2,	$0C,	nD2
	dc.b		nRst,	nD2,	$06,	nD2,	nD2,	$0C,	nD2,	nRst
	dc.b		$06,	nG2,	nA2,	nC3
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	Golden_Axe_3_Ancient_Mount_FM2
;	Call At	 	location
	smpsCall	Golden_Axe_3_Ancient_Mount_Call02
	dc.b		nF2,	nF2,	nRst,	nF2,	$0C,	nE2,	$06,	nF2
	dc.b		nG2,	nAb2,	nA2,	$0C,	nA1,	$06,	nA1,	nBb1
	dc.b		nC2,	nCs2
;	Call At	 	location
	smpsCall	Golden_Axe_3_Ancient_Mount_Call02
	dc.b		nBb2,	nBb2,	nRst,	nBb2,	$0C,	$06,	nBb2,	nC3
	dc.b		nRst,	nC3,	nC3,	nC3,	nCs3,	nA2,	nAb2,	nG2
;	Call At	 	location
	smpsCall	Golden_Axe_3_Ancient_Mount_Call03
	dc.b		nCs2,	nA2,	$0C,	nAb2,	nA2,	$06,	nF2,	nEb2
	dc.b		nD2,	nD2,	nD2,	nG1,	nA1,	nA1,	nC2,	nCs2
;	Call At	 	location
	smpsCall	Golden_Axe_3_Ancient_Mount_Call03
	dc.b		nCs2,	nCs2,	$0C,	$06,	nA1,	nCs2,	nRst,	nAb2
	dc.b		nA2,	nA1,	nA1,	$0C,	$06,	nRst,	$0C,	nCs2
	dc.b		$06
Golden_Axe_3_Ancient_Mount_Loop02:
	dc.b		nD2,	$0C,	nD2,	nRst,	$06,	nD2,	nD2,	nA1
	dc.b		nD2,	$0C,	nD2,	nRst,	$06,	nD2,	nD2,	nF2
	dc.b		nG2,	$0C,	nG2,	nRst,	$06,	nG2,	nG2,	nG2
	dc.b		nA2,	$0C,	nA2,	nA2,	$06,	nC2,	nCs2,	$0C
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	Golden_Axe_3_Ancient_Mount_Loop02
Golden_Axe_3_Ancient_Mount_Loop03:
	dc.b		nBb2,	$0C,	nBb2,	nBb2,	$06,	nF2,	nE2,	nD2
	dc.b		nRst,	nD2,	nE2,	nF2,	$0C,	nD2,	$06,	nC2
	dc.b		nD2,	nG1,	nG1,	$0C,	nG1,	nG1,	$06,	nG1
	dc.b		nG1,	nA1,	nA1,	$0C,	$06,	nC2,	nA1,	nC2
	dc.b		nCs2
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	Golden_Axe_3_Ancient_Mount_Loop03
Golden_Axe_3_Ancient_Mount_Loop04:
	dc.b		nD2,	$0C,	nD2,	nRst,	nD2,	$06,	nD2,	nD2
	dc.b		$0C,	nD2,	nRst,	$06,	nF1,	nG1,	nA1,	nG1
	dc.b		$12,	nG2,	$06,	nRst,	nG1,	$12,	nA1,	nA2
	dc.b		$06,	nG1,	nA1,	nA1,	$0C
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	Golden_Axe_3_Ancient_Mount_Loop04
;	Jump To	 	location
	smpsJump	Golden_Axe_3_Ancient_Mount_FM2

Golden_Axe_3_Ancient_Mount_Call02:
	dc.b		nBb2,	nC3,	nBb2,	nA2,	nRst,	nG2,	nF2,	nG2
	dc.b		nRst,	nBb1,	nBb1,	nC2,	nD2,	nC2,	nD2,	nE2
	smpsReturn

Golden_Axe_3_Ancient_Mount_Call03:
	dc.b		nF2,	nG2,	nF2,	nE2,	nD2,	nE2,	nD2,	nC2
	dc.b		nRst,	nBb1,	nBb1,	nBb1,	$0C,	$06,	nBb1,	nC2
	smpsReturn

; FM3 Data
Golden_Axe_3_Ancient_Mount_FM3:
;	Set FM Voice	#
	smpsFMvoice	$05
Golden_Axe_3_Ancient_Mount_Loop05:
;	Call At	 	location
	smpsCall	Golden_Axe_3_Ancient_Mount_Call04
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$07,	Golden_Axe_3_Ancient_Mount_Loop05
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nD5,	$06,	nD5,	nD6,	$0C,	nD6,	$06,	nC6
	dc.b		$0C,	nD6,	$06,	nRst,	nA5,	nC6,	nG5,	nA5
	dc.b		nF5,	nG5,	nC5
;	Set FM Voice	#
	smpsFMvoice	$05
Golden_Axe_3_Ancient_Mount_Loop06:
;	Call At	 	location
	smpsCall	Golden_Axe_3_Ancient_Mount_Call04
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	Golden_Axe_3_Ancient_Mount_Loop06
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nA5,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$24
	dc.b		nG4,	$0C,	nA4,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30
	dc.b		smpsNoAttack,	$30
Golden_Axe_3_Ancient_Mount_Loop07:
	dc.b		nRst,	$30
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	Golden_Axe_3_Ancient_Mount_Loop07
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		nA4,	smpsNoAttack,	$30,	nG4,	nA4,	nD5,	smpsNoAttack,	$30
	dc.b		nG5,	smpsNoAttack,	$24,	nG5,	$06,	nRst,	nA5,	$30
	dc.b		smpsNoAttack,	$30,	smpsNoAttack,	nA5,	nG4,	nA4,	smpsNoAttack,	$30
	dc.b		smpsNoAttack,	nA4,	nG4,	nA4,	smpsNoAttack,	$30,	smpsNoAttack,	nA5
	dc.b		nRst,	$0C
;	Alter Volume	value
	smpsAlterVol	$FD
;	Alter Volume	value
	smpsAlterVol	$02
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nA5,	nA5,	$06,	nG5,	$0C
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nA5,	$06,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	nA4,	nRst
	dc.b		$0C
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nA4,	nA4,	$06,	nG4,	$12
;	Note Fill	duration
	smpsNoteFill	$00
;	Alter Volume	value
	smpsAlterVol	$FE
;	Set FM Voice	#
	smpsFMvoice	$05
;	Jump To	 	location
	smpsJump	Golden_Axe_3_Ancient_Mount_Loop05

Golden_Axe_3_Ancient_Mount_Call04:
	dc.b		nRst,	$0C,	nC5,	nA4,	$06,	nC5,	$0C,	nA4
	dc.b		$06,	nC5,	$0C,	nA4,	$06,	nC5,	$0C,	nA4
	dc.b		$06,	nC5,	nD5
	smpsReturn

; FM4 Data
Golden_Axe_3_Ancient_Mount_FM4:
;	Set FM Voice	#
	smpsFMvoice	$05
Golden_Axe_3_Ancient_Mount_Loop08:
;	Call At	 	location
	smpsCall	Golden_Axe_3_Ancient_Mount_Call05
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$07,	Golden_Axe_3_Ancient_Mount_Loop08
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nA4,	$06,	nA4,	nA5,	$0C,	nA5,	$06,	nG5
	dc.b		$0C,	nA5,	$06,	nRst,	nD5,	nF5,	nC5,	nD5
	dc.b		nA4,	nC4,	nG3
;	Set FM Voice	#
	smpsFMvoice	$05
Golden_Axe_3_Ancient_Mount_Loop09:
;	Call At	 	location
	smpsCall	Golden_Axe_3_Ancient_Mount_Call05
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	Golden_Axe_3_Ancient_Mount_Loop09
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nD5,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$24
	dc.b		nC4,	$0C,	nD4,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30
	dc.b		smpsNoAttack,	$30
Golden_Axe_3_Ancient_Mount_Loop0A:
	dc.b		nRst,	$30
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	Golden_Axe_3_Ancient_Mount_Loop0A
	dc.b		nF4,	$30,	smpsNoAttack,	$30,	nF4,	nG4,	nF4,	smpsNoAttack
	dc.b		$30,	nE5,	smpsNoAttack,	$24,	$06,	nRst,	$06,	nF5
	dc.b		$30,	smpsNoAttack,	$30,	smpsNoAttack,	nF5,	nE4,	nF4,	smpsNoAttack
	dc.b		$30,	smpsNoAttack,	nF4,	nE4,	nD4,	smpsNoAttack,	$30,	smpsNoAttack
	dc.b		nD5,	nRst,	$0C
;	Alter Volume	value
	smpsAlterVol	$01
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nD5,	nD5,	$06,	nC5,	$0C
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nD5,	$06,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	nD4,	nRst
	dc.b		$0C
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nD4,	nD4,	$06,	nC4,	$12
;	Note Fill	duration
	smpsNoteFill	$00
;	Alter Volume	value
	smpsAlterVol	$FF
;	Set FM Voice	#
	smpsFMvoice	$05
;	Jump To	 	location
	smpsJump	Golden_Axe_3_Ancient_Mount_Loop08

Golden_Axe_3_Ancient_Mount_Call05:
	dc.b		nRst,	$0C,	nF5,	nRst,	$06,	nF5,	$0C,	nRst
	dc.b		$06,	nF5,	$0C,	nRst,	$06,	nF5,	$0C,	nRst
	dc.b		$06,	nF5,	nG5
	smpsReturn

; FM5 Data
Golden_Axe_3_Ancient_Mount_FM5:
	dc.b		nRst,	$0C
;	Jump To	 	location
	smpsJump	Golden_Axe_3_Ancient_Mount_FM1

; PSG1 Data
Golden_Axe_3_Ancient_Mount_PSG1:
;	Set PSG Voice	#
	smpsPSGvoice	$05
;	Alter Notes	value
	smpsAlterNote	$FE
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nD4,	$0C,	nA4,	nG4,	nA4,	$06,	nC4,	nRst
	dc.b		nD4,	nA4,	$0C,	nG4,	nA4,	$06,	nC4
;	Set Volume	value
	smpsSetVol	$FE
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	Golden_Axe_3_Ancient_Mount_PSG1
;	Alter Notes	value
	smpsAlterNote	$00
;	Set Volume	value
	smpsSetVol	$02
	dc.b		nD4,	$0C,	nA4,	nG4,	nA4,	$06,	nC4,	nRst
	dc.b		nG3,	nA3,	nG3,	nA3,	nG3,	nA3,	nC3
;	Set Volume	value
	smpsSetVol	$FE
	dc.b		nRst,	$24,	$0C
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0A,	$01,	$01,	$04
	dc.b		nD4,	$24,	nC4,	$06,	nD4,	nA4,	$30,	smpsNoAttack
	dc.b		$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack
	dc.b		$30,	nRst,	$30,	nD4,	$24,	nC4,	$06,	nD4
	dc.b		nA4,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	smpsNoAttack,	$30
	dc.b		smpsNoAttack,	$30,	smpsNoAttack,	$30,	nBb4,	smpsNoAttack,	$30,	smpsNoAttack
	dc.b		$30,	smpsNoAttack,	$18,	nC5,	$0C,	nD5,	nE5,	$30
	dc.b		nD5,	$18,	nC5,	$0C,	nBb4,	nBb4,	$30,	nA4
	dc.b		$24,	nG4,	$0C,	nA4,	$30,	smpsNoAttack,	$30
Golden_Axe_3_Ancient_Mount_Loop0B:
	dc.b		nRst,	$30
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$06,	Golden_Axe_3_Ancient_Mount_Loop0B
	dc.b		nA4,	smpsNoAttack,	$30,	nG4,	nA4,	nD5,	smpsNoAttack,	$30
	dc.b		nG5,	smpsNoAttack,	$24,	$0C,	nA5,	$30,	smpsNoAttack,	$30
	dc.b		smpsNoAttack,	nA5,	nG4,	nA4,	smpsNoAttack,	$30,	smpsNoAttack,	nA4
	dc.b		nG4,	nA4,	smpsNoAttack,	$30,	smpsNoAttack,	nA5,	smpsNoAttack,	$0C
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nA5,	nA5,	$06,	nG5,	$0C
;	Note Fill	duration
	smpsNoteFill	$00
	dc.b		nA5,	$06,	smpsNoAttack,	$30,	smpsNoAttack,	$30,	nA4,	smpsNoAttack
	dc.b		$0C
;	Note Fill	duration
	smpsNoteFill	$06
	dc.b		nA4,	nA4,	$06,	nG4,	$12
;	Note Fill	duration
	smpsNoteFill	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$00,	$00,	$00
;	Jump To	 	location
	smpsJump	Golden_Axe_3_Ancient_Mount_PSG1

; PSG2 Data
Golden_Axe_3_Ancient_Mount_PSG2:
	dc.b		nRst,	$0C
;	Jump To	 	location
	smpsJump	Golden_Axe_3_Ancient_Mount_PSG1

; PSG3 Data
Golden_Axe_3_Ancient_Mount_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
;	Set PSG Voice	#
	smpsPSGvoice	$02
Golden_Axe_3_Ancient_Mount_Loop0C:
	dc.b		nA6,	$06
;	Set Volume	value
	smpsSetVol	$03
	dc.b		$06,	$06,	$06
;	Set Volume	value
	smpsSetVol	$FD
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	Golden_Axe_3_Ancient_Mount_Loop0C
	dc.b		nA6,	$06
;	Set Volume	value
	smpsSetVol	$03
	dc.b		$06
;	Set Volume	value
	smpsSetVol	$FD
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nA6,	$0C
;	Jump To	 	location
	smpsJump	Golden_Axe_3_Ancient_Mount_PSG3

; DAC Data
Golden_Axe_3_Ancient_Mount_DAC:
	dc.b		dKick,	$0C,	dKick,	dSnare,	$12,	dKick,	dKick,	$0C
	dc.b		dSnare,	$12,	dKick,	$06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	Golden_Axe_3_Ancient_Mount_DAC
	dc.b		dKick,	$06,	$06,	dSnare,	$12,	dKick,	$0C,	$06
	dc.b		$06,	dSnare,	dSnare,	dTimpani,	dTimpani,	$91,	dKick,	dSnare
Golden_Axe_3_Ancient_Mount_Loop0D:
	dc.b		dKick,	$0C,	dKick,	dSnare,	$12,	dKick,	dKick,	$0C
	dc.b		dSnare,	$18
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	Golden_Axe_3_Ancient_Mount_Loop0D
	dc.b		dKick,	$0C,	dKick,	dSnare,	$12,	dKick,	$0C,	$06
	dc.b		$0C,	dSnare,	$18
Golden_Axe_3_Ancient_Mount_Loop0E:
	dc.b		dKick,	dSnare,	$12,	dKick,	dKick,	$0C,	dSnare,	$18
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	Golden_Axe_3_Ancient_Mount_Loop0E
	dc.b		dKick,	dSnare,	$12,	dKick,	$0C,	$06,	$0C,	dSnare
	dc.b		$06,	nRst,	dSnare,	dSnare
Golden_Axe_3_Ancient_Mount_Loop0F:
	dc.b		dKick,	$0C,	dKick,	dSnare,	$12,	dKick,	dKick,	$0C
	dc.b		dSnare,	$18
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$03,	Golden_Axe_3_Ancient_Mount_Loop0F
	dc.b		dKick,	$0C,	dKick,	dSnare,	$12,	dKick,	$06,	$0C
	dc.b		dKick,	dSnare,	dSnare,	$06,	dSnare
Golden_Axe_3_Ancient_Mount_Loop10:
	dc.b		dKick,	$18,	dSnare,	$12,	dKick,	dKick,	$0C,	dSnare
	dc.b		$18
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	Golden_Axe_3_Ancient_Mount_Loop10
Golden_Axe_3_Ancient_Mount_Loop11:
	dc.b		dKick,	$18,	dSnare,	dKick,	dSnare,	$0C,	$06,	dSnare
	dc.b		dKick,	$18,	dSnare,	$0C,	dKick,	$1E,	$06,	dSnare
	dc.b		$0C,	$06,	dSnare
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	Golden_Axe_3_Ancient_Mount_Loop11
	dc.b		dKick,	$0C,	dSnare,	nRst,	$06,	dKick,	dSnare,	dKick
	dc.b		nRst,	dKick,	dSnare,	dKick,	nRst,	dKick,	dSnare,	dKick
	dc.b		dKick,	$0C,	dSnare,	nRst,	$06,	dKick,	dSnare,	dKick
	dc.b		dKick,	$0C,	dSnare,	$12,	dSnare,	$06,	dSnare,	dSnare
	dc.b		dKick,	$0C,	dSnare,	nRst,	$06,	dKick,	dSnare,	dKick
	dc.b		nRst,	dKick,	dSnare,	dSnare,	nRst,	dSnare,	dSnare,	dSnare
	dc.b		dKick,	$0C,	dSnare,	nRst,	$06,	dKick,	dSnare,	dKick
	dc.b		dKick,	$0C,	dSnare,	$12,	dSnare,	$06,	dSnare,	dSnare
	dc.b		dKick,	$18,	dSnare,	$12,	dKick,	dKick,	$0C,	dSnare
	dc.b		$18
Golden_Axe_3_Ancient_Mount_Loop12:
	dc.b		dKick,	dSnare,	$12,	dKick,	dKick,	$0C,	dSnare,	$18
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	Golden_Axe_3_Ancient_Mount_Loop12
	dc.b		dKick,	dSnare,	$12,	dKick,	$0C,	$06,	$0C,	dSnare
	dc.b		$06,	dSnare,	dSnare,	dSnare
;	Jump To	 	location
	smpsJump	Golden_Axe_3_Ancient_Mount_DAC

Golden_Axe_3_Ancient_Mount_Voices:
;	Voice 00
;	$3D,$32,$23,$22,$33,$1F,$1F,$1F,$1F,$07,$06,$0D,$00,$06,$06,$0A,$0F,$1F,$5F,$0F,$0F,$15,$83,$85,$84
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$02,	$02,	$03
	smpsVcCoarseFreq	$03,	$02,	$03,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$0D,	$06,	$07
	smpsVcDecayRate2	$0F,	$0A,	$06,	$06
	smpsVcDecayLevel	$00,	$00,	$05,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$84,	$85,	$83,	$15

;	Voice 01
;	$5D,$42,$35,$31,$61,$0F,$0E,$0B,$0F,$03,$08,$0A,$07,$04,$0A,$0C,$07,$08,$09,$0B,$0A,$22,$98,$84,$84
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$03
;				op1	op2	op3	op4
	smpsVcDetune		$06,	$03,	$03,	$04
	smpsVcCoarseFreq	$01,	$01,	$05,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$0F,	$0B,	$0E,	$0F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$07,	$0A,	$08,	$03
	smpsVcDecayRate2	$07,	$0C,	$0A,	$04
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$0A,	$0B,	$09,	$08
	smpsVcTotalLevel	$84,	$84,	$98,	$22

;	Voice 02
;	$29,$72,$51,$51,$12,$1B,$1A,$1A,$1F,$10,$0A,$08,$08,$10,$06,$04,$07,$2C,$1F,$1F,$FF,$10,$14,$23,$80
;				#
	smpsVcAlgorithm		$01
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$01,	$05,	$05,	$07
	smpsVcCoarseFreq	$02,	$01,	$01,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1A,	$1A,	$1B
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$08,	$08,	$0A,	$10
	smpsVcDecayRate2	$07,	$04,	$06,	$10
	smpsVcDecayLevel	$0F,	$01,	$01,	$02
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0C
	smpsVcTotalLevel	$80,	$23,	$14,	$10

;	Voice 03
;	$24,$00,$01,$01,$02,$1F,$1F,$1F,$1F,$04,$02,$04,$02,$0C,$06,$0C,$06,$1F,$0F,$1F,$0F,$0F,$80,$14,$80
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$04
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$02,	$01,	$01,	$00
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$02,	$04,	$02,	$04
	smpsVcDecayRate2	$06,	$0C,	$06,	$0C
	smpsVcDecayLevel	$00,	$01,	$00,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$14,	$80,	$0F

;	Voice 04
;	$2A,$01,$00,$05,$01,$85,$85,$85,$53,$0E,$0C,$0E,$03,$00,$00,$00,$00,$1F,$FF,$1F,$0F,$1B,$21,$29,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$05,	$00,	$01
	smpsVcRateScale		$01,	$02,	$02,	$02
	smpsVcAttackRate	$13,	$05,	$05,	$05
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$03,	$0E,	$0C,	$0E
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$00,	$01,	$0F,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$29,	$21,	$1B

;	Voice 05
;	$35,$00,$01,$02,$02,$1F,$1F,$13,$1F,$0E,$0C,$0E,$03,$02,$02,$02,$01,$1A,$1F,$1F,$1F,$18,$84,$84,$84
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$02,	$02,	$01,	$00
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$13,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$03,	$0E,	$0C,	$0E
	smpsVcDecayRate2	$01,	$02,	$02,	$02
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0A
	smpsVcTotalLevel	$84,	$84,	$84,	$18

;	Voice 06
;	$00,$01,$8F,$05,$03,$01,$0C,$01,$89,$00,$00,$00,$2C,$E0,$0E,$00,$95,$F8,$12,$01,$0C,$F8,$1B,$01,$16
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$08,	$00
	smpsVcCoarseFreq	$03,	$05,	$0F,	$01
	smpsVcRateScale		$02,	$00,	$00,	$00
	smpsVcAttackRate	$09,	$01,	$0C,	$01
	smpsVcAmpMod		$01,	$00,	$00,	$00
	smpsVcDecayRate1	$0C,	$00,	$00,	$00
	smpsVcDecayRate2	$95,	$00,	$0E,	$E0
	smpsVcDecayLevel	$00,	$00,	$01,	$0F
	smpsVcReleaseRate	$0C,	$01,	$02,	$08
	smpsVcTotalLevel	$16,	$01,	$1B,	$F8

;	Voice 07
;	$F8,$1B,$01,$32,$D4,$02,$00,$00,$01,$2B,$D4,$05,$00,$00,$01,$7C,$04,$03,$00,$02,$EF,$00,$B3,$08,$04
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$0D,	$03,	$00,	$01
	smpsVcCoarseFreq	$04,	$02,	$01,	$0B
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$01,	$00,	$00,	$02
	smpsVcAmpMod		$00,	$00,	$06,	$01
	smpsVcDecayRate1	$00,	$05,	$14,	$0B
	smpsVcDecayRate2	$04,	$7C,	$01,	$00
	smpsVcDecayLevel	$0E,	$00,	$00,	$00
	smpsVcReleaseRate	$0F,	$02,	$00,	$03
	smpsVcTotalLevel	$04,	$08,	$B3,	$00

;	Voice 08
;	$BF,$08,$B3,$04,$08,$BF,$04,$B3,$08,$04,$BF,$08,$B3,$04,$08,$04,$08,$BF,$04,$B3,$08,$04,$AF,$08,$04
;				#
	smpsVcAlgorithm		$07
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$0B,	$00
	smpsVcCoarseFreq	$08,	$04,	$03,	$08
	smpsVcRateScale		$00,	$02,	$00,	$02
	smpsVcAttackRate	$08,	$13,	$04,	$1F
	smpsVcAmpMod		$05,	$00,	$05,	$00
	smpsVcDecayRate1	$13,	$08,	$1F,	$04
	smpsVcDecayRate2	$08,	$04,	$08,	$04
	smpsVcDecayLevel	$00,	$0B,	$00,	$0B
	smpsVcReleaseRate	$08,	$03,	$04,	$0F
	smpsVcTotalLevel	$04,	$08,	$AF,	$04

;	Voice 09
;	$BB,$08,$AF,$04,$08,$BB,$04,$AF,$08,$04,$BB,$08,$AF,$04,$08,$04,$08,$BB,$04,$AF,$08,$04,$AC,$08,$04
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$0A,	$00
	smpsVcCoarseFreq	$08,	$04,	$0F,	$08
	smpsVcRateScale		$00,	$02,	$00,	$02
	smpsVcAttackRate	$08,	$0F,	$04,	$1B
	smpsVcAmpMod		$05,	$00,	$05,	$00
	smpsVcDecayRate1	$0F,	$08,	$1B,	$04
	smpsVcDecayRate2	$08,	$04,	$08,	$04
	smpsVcDecayLevel	$00,	$0A,	$00,	$0B
	smpsVcReleaseRate	$08,	$0F,	$04,	$0B
	smpsVcTotalLevel	$04,	$08,	$AC,	$04

;	Voice 0A
;	$B8,$08,$AC,$04,$08,$B8,$04,$AC,$08,$04,$B8,$08,$AC,$04,$08,$04,$08,$B8,$04,$AC,$08,$04,$AE,$08,$04
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$0A,	$00
	smpsVcCoarseFreq	$08,	$04,	$0C,	$08
	smpsVcRateScale		$00,	$02,	$00,	$02
	smpsVcAttackRate	$08,	$0C,	$04,	$18
	smpsVcAmpMod		$05,	$00,	$05,	$00
	smpsVcDecayRate1	$0C,	$08,	$18,	$04
	smpsVcDecayRate2	$08,	$04,	$08,	$04
	smpsVcDecayLevel	$00,	$0A,	$00,	$0B
	smpsVcReleaseRate	$08,	$0C,	$04,	$08
	smpsVcTotalLevel	$04,	$08,	$AE,	$04

;	Voice 0B
;	$BA,$08,$AE,$04,$08,$BA,$04,$AE,$08,$04,$BA,$08,$AE,$04,$08,$04,$08,$BA,$04,$AE,$08,$04,$F6,$FF,$9A
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$0A,	$00
	smpsVcCoarseFreq	$08,	$04,	$0E,	$08
	smpsVcRateScale		$00,	$02,	$00,	$02
	smpsVcAttackRate	$08,	$0E,	$04,	$1A
	smpsVcAmpMod		$05,	$00,	$05,	$00
	smpsVcDecayRate1	$0E,	$08,	$1A,	$04
	smpsVcDecayRate2	$08,	$04,	$08,	$04
	smpsVcDecayLevel	$00,	$0A,	$00,	$0B
	smpsVcReleaseRate	$08,	$0E,	$04,	$0A
	smpsVcTotalLevel	$9A,	$FF,	$F6,	$04

;	Voice 0C
;	$F0,$20,$01,$05,$05,$EF,$03,$C1,$60,$C4,$BD,$60,$BC,$30,$BC,$10,$BD,$BF,$C1,$60,$C4,$C9,$60,$C8,$30
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$02
	smpsVcCoarseFreq	$05,	$05,	$01,	$00
	smpsVcRateScale		$01,	$03,	$00,	$03
	smpsVcAttackRate	$00,	$01,	$03,	$0F
	smpsVcAmpMod		$05,	$03,	$05,	$06
	smpsVcDecayRate1	$1C,	$00,	$1D,	$04
	smpsVcDecayRate2	$BD,	$10,	$BC,	$30
	smpsVcDecayLevel	$0C,	$06,	$0C,	$0B
	smpsVcReleaseRate	$04,	$00,	$01,	$0F
	smpsVcTotalLevel	$30,	$C8,	$60,	$C9

;	Voice 0D
;	$C8,$10,$C9,$CB,$CD,$48,$D0,$18,$D5,$08,$D1,$04,$80,$08,$D0,$06,$80,$CE,$80,$CC,$04,$CD,$08,$D0,$04
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$01
;				op1	op2	op3	op4
	smpsVcDetune		$0C,	$0C,	$0C,	$01
	smpsVcCoarseFreq	$0D,	$0B,	$09,	$00
	smpsVcRateScale		$03,	$00,	$03,	$01
	smpsVcAttackRate	$15,	$18,	$10,	$08
	smpsVcAmpMod		$04,	$00,	$06,	$00
	smpsVcDecayRate1	$00,	$04,	$11,	$08
	smpsVcDecayRate2	$80,	$06,	$D0,	$08
	smpsVcDecayLevel	$00,	$0C,	$08,	$0C
	smpsVcReleaseRate	$04,	$0C,	$00,	$0E
	smpsVcTotalLevel	$04,	$D0,	$08,	$CD

;	Voice 0E
;	$C9,$08,$C5,$04,$C4,$08,$C2,$04,$C1,$08,$BF,$04,$C1,$0C,$0C,$BD,$BD,$08,$BA,$06,$80,$C4,$04,$C6,$08
;				#
	smpsVcAlgorithm		$01
	smpsVcFeedback		$01
;				op1	op2	op3	op4
	smpsVcDetune		$0C,	$00,	$0C,	$00
	smpsVcCoarseFreq	$04,	$04,	$05,	$08
	smpsVcRateScale		$03,	$00,	$03,	$00
	smpsVcAttackRate	$01,	$04,	$02,	$08
	smpsVcAmpMod		$06,	$00,	$05,	$00
	smpsVcDecayRate1	$01,	$04,	$1F,	$08
	smpsVcDecayRate2	$BD,	$BD,	$0C,	$0C
	smpsVcDecayLevel	$08,	$00,	$0B,	$00
	smpsVcReleaseRate	$00,	$06,	$0A,	$08
	smpsVcTotalLevel	$08,	$C6,	$04,	$C4

;	Voice 0F
;	$C9,$04,$80,$08,$C6,$04,$C9,$08,$CB,$04,$CD,$08,$CE,$04,$CD,$08,$CE,$04,$C9,$08,$C6,$04,$C9,$08,$CB
;				#
	smpsVcAlgorithm		$01
	smpsVcFeedback		$01
;				op1	op2	op3	op4
	smpsVcDetune		$0C,	$00,	$08,	$00
	smpsVcCoarseFreq	$06,	$08,	$00,	$04
	smpsVcRateScale		$03,	$00,	$03,	$00
	smpsVcAttackRate	$0B,	$08,	$09,	$04
	smpsVcAmpMod		$06,	$00,	$06,	$00
	smpsVcDecayRate1	$0E,	$08,	$0D,	$04
	smpsVcDecayRate2	$CE,	$08,	$CD,	$04
	smpsVcDecayLevel	$0C,	$00,	$0C,	$00
	smpsVcReleaseRate	$06,	$08,	$09,	$04
	smpsVcTotalLevel	$CB,	$08,	$C9,	$04

;	Voice 10
;	$04,$C4,$18,$D0,$10,$CF,$04,$CE,$CD,$60,$E7,$60,$E7,$60,$E7,$60,$F6,$FF,$91,$E1,$02,$E0,$80,$80,$0F
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$01,	$0D,	$01,	$0C
	smpsVcCoarseFreq	$00,	$00,	$08,	$04
	smpsVcRateScale		$03,	$03,	$00,	$03
	smpsVcAttackRate	$0D,	$0E,	$04,	$0F
	smpsVcAmpMod		$07,	$03,	$07,	$03
	smpsVcDecayRate1	$07,	$00,	$07,	$00
	smpsVcDecayRate2	$F6,	$60,	$E7,	$60
	smpsVcDecayLevel	$00,	$0E,	$09,	$0F
	smpsVcReleaseRate	$02,	$01,	$01,	$0F
	smpsVcTotalLevel	$0F,	$80,	$80,	$E0

;	Voice 11
;	$F6,$FF,$81,$F2,$E1,$FE,$E0,$40,$80,$0F,$F6,$FF,$77,$F2,$EF,$01,$A5,$0C,$EF,$02,$A5,$0C,$F6,$FF,$EC
;				#
	smpsVcAlgorithm		$06
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$0E,	$0F,	$08,	$0F
	smpsVcCoarseFreq	$01,	$02,	$01,	$0F
	smpsVcRateScale		$02,	$01,	$03,	$03
	smpsVcAttackRate	$00,	$00,	$00,	$1E
	smpsVcAmpMod		$03,	$07,	$07,	$00
	smpsVcDecayRate1	$17,	$1F,	$16,	$0F
	smpsVcDecayRate2	$A5,	$01,	$EF,	$F2
	smpsVcDecayLevel	$0A,	$00,	$0E,	$00
	smpsVcReleaseRate	$05,	$02,	$0F,	$0C
	smpsVcTotalLevel	$EC,	$FF,	$F6,	$0C

;	Voice 12
;	$F0,$01,$01,$01,$02,$80,$0C,$F5,$26,$EC,$04,$D0,$08,$CD,$04,$C9,$08,$C4,$04,$EC,$FF,$F7,$00,$04,$FF
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$02,	$01,	$01,	$01
	smpsVcRateScale		$00,	$03,	$00,	$02
	smpsVcAttackRate	$06,	$15,	$0C,	$00
	smpsVcAmpMod		$00,	$06,	$00,	$07
	smpsVcDecayRate1	$08,	$10,	$04,	$0C
	smpsVcDecayRate2	$08,	$C9,	$04,	$CD
	smpsVcDecayLevel	$0F,	$0E,	$00,	$0C
	smpsVcReleaseRate	$0F,	$0C,	$04,	$04
	smpsVcTotalLevel	$FF,	$04,	$00,	$F7

;	Voice 13
;	$F2,$EC,$04,$D0,$08,$CC,$04,$C9,$08,$C5,$04,$EC,$FF,$F7,$00,$04,$FF,$F2,$EC,$04,$CD,$08,$C9,$04,$C6
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$0D,	$00,	$0E
	smpsVcCoarseFreq	$08,	$00,	$04,	$0C
	smpsVcRateScale		$00,	$03,	$00,	$03
	smpsVcAttackRate	$08,	$09,	$04,	$0C
	smpsVcAmpMod		$07,	$07,	$00,	$06
	smpsVcDecayRate1	$1F,	$0C,	$04,	$05
	smpsVcDecayRate2	$FF,	$04,	$00,	$F7
	smpsVcDecayLevel	$0C,	$00,	$0E,	$0F
	smpsVcReleaseRate	$0D,	$04,	$0C,	$02
	smpsVcTotalLevel	$C6,	$04,	$C9,	$08

;	Voice 14
;	$08,$C2,$04,$EC,$FF,$F7,$00,$04,$FF,$F2,$EC,$04,$D0,$08,$CB,$04,$C8,$08,$C4,$04,$EC,$FF,$F7,$00,$04
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$01
;				op1	op2	op3	op4
	smpsVcDetune		$0F,	$0E,	$00,	$0C
	smpsVcCoarseFreq	$0F,	$0C,	$04,	$02
	smpsVcRateScale		$03,	$00,	$00,	$03
	smpsVcAttackRate	$1F,	$04,	$00,	$17
	smpsVcAmpMod		$06,	$00,	$07,	$07
	smpsVcDecayRate1	$10,	$04,	$0C,	$12
	smpsVcDecayRate2	$C8,	$04,	$CB,	$08
	smpsVcDecayLevel	$0E,	$00,	$0C,	$00
	smpsVcReleaseRate	$0C,	$04,	$04,	$08
	smpsVcTotalLevel	$04,	$00,	$F7,	$FF

;	Voice 15
;	$FF,$F2,$F6,$FF,$B8,$F2,$F3,$E7,$F5,$02,$CE,$08,$04,$08,$04,$F6,$FF,$F9,$F2,$81,$18,$82,$F6,$FF,$FB
;				#
	smpsVcAlgorithm		$07
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$0B,	$0F,	$0F,	$0F
	smpsVcCoarseFreq	$08,	$0F,	$06,	$02
	smpsVcRateScale		$03,	$03,	$03,	$03
	smpsVcAttackRate	$15,	$07,	$13,	$12
	smpsVcAmpMod		$00,	$00,	$06,	$00
	smpsVcDecayRate1	$04,	$08,	$0E,	$02
	smpsVcDecayRate2	$FF,	$F6,	$04,	$08
	smpsVcDecayLevel	$01,	$08,	$0F,	$0F
	smpsVcReleaseRate	$08,	$01,	$02,	$09
	smpsVcTotalLevel	$FB,	$FF,	$F6,	$82

;	Voice 16
;	$3B,$22,$31,$11,$71,$1F,$1F,$1F,$1F,$0A,$0B,$08,$0A,$0E,$08,$07,$02,$0F,$0C,$0A,$0F,$1A,$21,$1D,$80
;				#
	smpsVcAlgorithm		$03
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$01,	$03,	$02
	smpsVcCoarseFreq	$01,	$01,	$01,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0A,	$08,	$0B,	$0A
	smpsVcDecayRate2	$02,	$07,	$08,	$0E
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$0F,	$0A,	$0C,	$0F
	smpsVcTotalLevel	$80,	$1D,	$21,	$1A

;	Voice 17
;	$20,$70,$70,$71,$71,$DF,$DF,$DF,$DF,$07,$00,$07,$00,$09,$18,$13,$07,$0C,$0C,$0C,$0C,$02,$00,$10,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$04
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$07,	$07,	$07
	smpsVcCoarseFreq	$01,	$01,	$00,	$00
	smpsVcRateScale		$03,	$03,	$03,	$03
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$07,	$00,	$07
	smpsVcDecayRate2	$07,	$13,	$18,	$09
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$0C,	$0C,	$0C,	$0C
	smpsVcTotalLevel	$80,	$10,	$00,	$02

;	Voice 18
;	$00,$0F,$00,$00,$00,$DF,$DF,$DF,$DF,$0C,$0B,$0C,$0C,$0A,$0B,$0C,$0D,$0C,$0C,$0C,$02,$0A,$00,$00,$92
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$00,	$00,	$00,	$0F
	smpsVcRateScale		$03,	$03,	$03,	$03
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0C,	$0C,	$0B,	$0C
	smpsVcDecayRate2	$0D,	$0C,	$0B,	$0A
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$02,	$0C,	$0C,	$0C
	smpsVcTotalLevel	$92,	$00,	$00,	$0A

;	Voice 19
;	$3D,$23,$31,$32,$73,$1F,$1F,$1F,$1F,$00,$02,$04,$05,$04,$02,$05,$05,$0F,$0C,$0A,$0F,$18,$88,$88,$88
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$02
	smpsVcCoarseFreq	$03,	$02,	$01,	$03
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$04,	$02,	$00
	smpsVcDecayRate2	$05,	$05,	$02,	$04
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$0F,	$0A,	$0C,	$0F
	smpsVcTotalLevel	$88,	$88,	$88,	$18

;	Voice 1A
;	$00,$23,$31,$32,$73,$1F,$1F,$1F,$1F,$00,$02,$04,$05,$04,$02,$05,$05,$0F,$0C,$0A,$0F,$18,$88,$88,$88
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$03,	$03,	$02
	smpsVcCoarseFreq	$03,	$02,	$01,	$03
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$04,	$02,	$00
	smpsVcDecayRate2	$05,	$05,	$02,	$04
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$0F,	$0A,	$0C,	$0F
	smpsVcTotalLevel	$88,	$88,	$88,	$18
	even
