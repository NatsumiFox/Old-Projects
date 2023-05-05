; =============================================================================================
; Project Name:		sonic3title
; Created:		16th March 2015
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

sonic3title_Header:
;	Voice Pointer	location
	smpsHeaderVoice	sonic3title_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$01,	$30

;	DAC Pointer	location
	smpsHeaderDAC	sonic3title_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	sonic3title_FM1,	smpsPitch02hi,	$10
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	sonic3title_FM2,	smpsPitch02hi,	$1B
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	sonic3title_FM3,	smpsPitch00,	$05
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	sonic3title_FM4,	smpsPitch02hi,	$18
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	sonic3title_FM5,	smpsPitch02hi,	$13
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	sonic3title_PSG1,	smpsPitch01lo,	$01,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	sonic3title_PSG2,	smpsPitch01lo,	$01,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	sonic3title_PSG3,	smpsPitch00,	$04,	$00

; FM1 Data
sonic3title_FM1:
;	Set FM Voice	#
	smpsFMvoice	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$14,	$01,	$06,	$06
	dc.b		nRst,	$60,	nB3,	$06,	nRst,	nB3,	$0C,	nC4
	dc.b		$06,	nRst,	nC4,	$0C,	nD4,	$0C,	nRst,	nD4
	dc.b		$06,	nRst,	nBb3,	$04,	smpsNoAttack,	nB3,	$0E,	nRst
	dc.b		$06,	nB3,	$0C,	nC4,	$06,	nRst,	nD4,	$12
	dc.b		nRst,	$06,	nD4,	nRst,	nD4,	$12,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nC4,	$0C,	nRst,	nC4,	nRst,	nC4,	nB3,	nC4
	dc.b		$06,	nRst
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nAb3,	$04,	smpsNoAttack,	nA3,	$5C,	nRst,	$0C
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nB3,	$06,	nRst,	nB3,	$0C,	nC4,	$06,	nRst
	dc.b		nC4,	$0C,	nD4,	$0C,	nRst,	nD4,	$06,	nRst
	dc.b		nBb3,	$04,	smpsNoAttack,	nB3,	$0E,	nRst,	$06,	nB3
	dc.b		$0C,	nC4,	$06,	nRst,	nD4,	$12,	nRst,	$06
	dc.b		nD4,	nRst,	nD4,	$12,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nF4,	$0C,	nRst,	nF4,	nRst,	nF4,	nE4,	nF4
	dc.b		$06,	nRst
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nFs4,	$04,	smpsNoAttack,	nG4,	$5C,	nRst,	$0C
	smpsStop

; FM2 Data
sonic3title_FM2:
;	Set FM Voice	#
	smpsFMvoice	$00
;	Set Modulation	wait	speed	change	step
	smpsModSet	$15,	$01,	$06,	$06
	dc.b		nRst,	$60,	nRst,	$03
;	Alter Notes	value
	smpsAlterNote	$03
	dc.b		nG3,	$06,	nRst,	nG3,	$0C,	nA3,	$06,	nRst
	dc.b		nA3,	$0C,	nB3,	$0C,	nRst,	nB3,	$06,	nRst
	dc.b		nFs3,	$04,	smpsNoAttack,	nG3,	$0E,	nRst,	$06,	nG3
	dc.b		$0C,	nA3,	$06,	nRst,	nB3,	$12,	nRst,	$06
	dc.b		nB3,	nRst,	nB3,	$12,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nA3,	$0C,	nRst,	nA3,	nRst,	nA3,	nG3,	nA3
	dc.b		$06,	nRst
;	Alter Volume	value
	smpsAlterVol	$01
	dc.b		nF3,	$04,	smpsNoAttack,	nFs3,	$5C,	nRst,	$0C
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nG3,	$06,	nRst,	nG3,	$0C,	nA3,	$06,	nRst
	dc.b		nA3,	$0C,	nB3,	$0C,	nRst,	nB3,	$06,	nRst
	dc.b		nFs3,	$04,	smpsNoAttack,	nG3,	$0E,	nRst,	$06,	nG3
	dc.b		$0C,	nA3,	$06,	nRst,	nB3,	$12,	nRst,	$06
	dc.b		nB3,	nRst,	nB3,	$12,	nRst,	$06
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nC4,	$0C,	nRst,	nC4,	nRst,	nC4,	nB3,	nC4
	dc.b		$06,	nRst
;	Alter Volume	value
	smpsAlterVol	$FE
	dc.b		nBb3,	$04,	smpsNoAttack,	nB3,	$5C,	nRst,	$0C
;	Set FM Voice	#
	smpsFMvoice	$03
;	Alter Volume	value
	smpsAlterVol	$03
	dc.b		nRst,	$02
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
sonic3title_Loop01:
;	Call At	 	location
	smpsCall	sonic3title_Call01
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	sonic3title_Loop01
	smpsStop

; FM3 Data
sonic3title_FM3:
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nRst,	$06,	nD2,	$05,	nRst,	$01,	nD2,	$05
	dc.b		nRst,	$01,	nRst,	$06,	nD2,	$05,	nRst,	$0D
	dc.b		nD2,	$05,	nRst,	$01,	nD2,	$05,	nRst,	$07
	dc.b		nD2,	$05,	nRst,	$07,	nD2,	$05,	nRst,	$01
	dc.b		nD2,	$05,	nRst,	$01,	nD2,	$05,	nRst,	$01
	dc.b		nD2,	$05,	nRst,	$01
;	Call At	 	location
	smpsCall	sonic3title_Call02
;	Call At	 	location
	smpsCall	sonic3title_Call03
	dc.b		nE2,	$05,	nRst,	$01,	nRst,	$06
;	Call At	 	location
	smpsCall	sonic3title_Call04
	dc.b		nF2,	$05,	nRst,	$01,	nRst,	$06
;	Call At	 	location
	smpsCall	sonic3title_Call03
	dc.b		nD2,	$05,	nRst,	$01,	nRst,	$06
;	Call At	 	location
	smpsCall	sonic3title_Call02
;	Call At	 	location
	smpsCall	sonic3title_Call03
	dc.b		nE2,	$05,	nRst,	$01,	nRst,	$06
;	Call At	 	location
	smpsCall	sonic3title_Call04
	dc.b		nA2,	$05,	nRst,	$01,	nRst,	$06,	nG2,	$05
	dc.b		nRst,	$01,	nG2,	$05,	nRst,	$01,	nG2,	$05
	dc.b		nRst,	$01,	nRst,	$06,	nG2,	$05,	nRst,	$01
	dc.b		nRst,	$06,	nG2,	$05,	nRst,	$01,	nG2,	$05
	dc.b		nRst,	$01,	nRst,	$06,	nG2,	$05,	nRst,	$01
	dc.b		nG2,	$05,	nRst,	$01,	nRst,	$06,	nG2,	$18
	smpsStop

sonic3title_Call02:
	dc.b		nG2,	$05,	nRst,	$01,	nG2,	$05,	nRst,	$01
	dc.b		nG2,	$05,	nRst,	$01,	nRst,	$06,	nG2,	$05
	dc.b		nRst,	$01,	nRst,	$06,	nG2,	$05,	nRst,	$01
	dc.b		nG2,	$05,	nRst,	$01,	nRst,	$06,	nG2,	$05
	dc.b		nRst,	$01,	nG2,	$05,	nRst,	$01,	nRst,	$06
	dc.b		nG2,	$05,	nRst,	$01,	nRst,	$06,	nG2,	$05
	dc.b		nRst,	$01,	nRst,	$06
	smpsReturn

sonic3title_Call03:
	dc.b		nD2,	$05,	nRst,	$01,	nD2,	$05,	nRst,	$01
	dc.b		nD2,	$05,	nRst,	$01,	nRst,	$06,	nD2,	$05
	dc.b		nRst,	$01,	nRst,	$06,	nD2,	$05,	nRst,	$01
	dc.b		nD2,	$05,	nRst,	$01,	nRst,	$06,	nD2,	$05
	dc.b		nRst,	$01,	nD2,	$05,	nRst,	$01,	nRst,	$06
	dc.b		nD2,	$05,	nRst,	$01,	nRst,	$06
	smpsReturn

sonic3title_Call04:
	dc.b		nF2,	$05,	nRst,	$01,	nF2,	$05,	nRst,	$01
	dc.b		nF2,	$05,	nRst,	$01,	nRst,	$06,	nF2,	$05
	dc.b		nRst,	$01,	nRst,	$06,	nF2,	$05,	nRst,	$01
	dc.b		nF2,	$05,	nRst,	$01,	nRst,	$06,	nF2,	$05
	dc.b		nRst,	$01,	nF2,	$05,	nRst,	$01,	nRst,	$06
	dc.b		nF2,	$05,	nRst,	$01,	nRst,	$06
	smpsReturn

; FM4 Data
sonic3title_FM4:
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nRst,	$60
sonic3title_Loop02:
;	Call At	 	location
	smpsCall	sonic3title_Call05
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	sonic3title_Loop02
sonic3title_Loop03:
;	Call At	 	location
	smpsCall	sonic3title_Call06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	sonic3title_Loop03
sonic3title_Loop04:
;	Call At	 	location
	smpsCall	sonic3title_Call07
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	sonic3title_Loop04
sonic3title_Loop05:
;	Call At	 	location
	smpsCall	sonic3title_Call05
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	sonic3title_Loop05
sonic3title_Loop06:
;	Call At	 	location
	smpsCall	sonic3title_Call06
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	sonic3title_Loop06
sonic3title_Loop07:
;	Call At	 	location
	smpsCall	sonic3title_Call05
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	sonic3title_Loop07
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
sonic3title_Loop08:
;	Call At	 	location
	smpsCall	sonic3title_Call01
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$04,	sonic3title_Loop08
	smpsStop

sonic3title_Call05:
	dc.b		nG4,	$06,	nF4,	nD4,	nF4
	smpsReturn

sonic3title_Call06:
	dc.b		nA4,	$06,	nG4,	nE4,	nG4
	smpsReturn

sonic3title_Call07:
	dc.b		nD4,	$06,	nC4,	nA3,	nC4
	smpsReturn

sonic3title_Call01:
	dc.b		nG4,	$06
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nF4
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nD4
;	Alter Volume	value
	smpsAlterVol	$04
	dc.b		nF4
;	Alter Volume	value
	smpsAlterVol	$04
	smpsReturn

; FM5 Data
sonic3title_FM5:
	dc.b		nRst,	$08
;	Alter Volume	value
	smpsAlterVol	$05
;	Jump To	 	location
	smpsJump	sonic3title_FM1

; PSG1 Data
sonic3title_PSG1:
;	Set PSG Voice	#
	smpsPSGvoice	$08
	dc.b		nRst,	$60,	nG3,	$60,	nA3,	nE3,	nD3,	nG3
	dc.b		nA3,	nC4,	nD4
	smpsStop

; PSG2 Data
sonic3title_PSG2:
;	Set PSG Voice	#
	smpsPSGvoice	$08
	dc.b		nRst,	$60,	nD3,	$60,	nF3,	nC3,	nFs3,	nD3
	dc.b		nF3,	nA3,	nB3
	smpsStop

; PSG3 Data
sonic3title_PSG3:
;	Set PSG WvForm	#
	smpsPSGform	$E7
;	Set PSG Voice	#
	smpsPSGvoice	$02
sonic3title_Loop09:
	dc.b		nB6,	$06,	nB6
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB6,	$06,	nB6
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nB6,	$06,	nB6
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB6,	$06,	nB6
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nB6,	$06,	nB6
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB6,	$06,	nB6
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nB6,	$06,	nB6
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB6,	$06,	nB6
;	Set Volume	value
	smpsSetVol	$04
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$08,	sonic3title_Loop09
	dc.b		nB6,	$06,	nB6
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB6,	$06,	nB6
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nB6,	$06,	nB6
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB6,	$06,	nB6
;	Set Volume	value
	smpsSetVol	$04
	dc.b		nB6,	$06,	nB6
;	Set Volume	value
	smpsSetVol	$FC
	dc.b		nB6,	$06,	nB6,	nB6,	nB6,	nB6,	nB6
	smpsStop

s3t_1	equ $99
s3t_2	equ $98
; DAC Data
sonic3title_DAC:
	dc.b		s3t_1,	$06,	s3t_1,	s3t_1,	nRst,	s3t_1,	nRst,	$0C
	dc.b		s3t_1,	$06,	s3t_1,	nRst,	s3t_1,	nRst,	s3t_1,	s3t_1
	dc.b		s3t_1,	s3t_1,	s3t_2,	$18,	s3t_1,	s3t_2,	s3t_1,	s3t_2
	dc.b		s3t_1,	s3t_2,	s3t_1,	$06,	nRst,	$0C,	s3t_1,	$06
	dc.b		s3t_2,	$18,	s3t_1,	s3t_2,	s3t_1,	s3t_2,	s3t_1,	$06
	dc.b		nRst,	$12,	s3t_2,	$06,	nRst,	s3t_1,	nRst,	s3t_1
	dc.b		$06,	s3t_1,	nRst,	s3t_1,	s3t_2,	$18,	s3t_1,	s3t_2
	dc.b		s3t_1,	s3t_2,	s3t_1,	s3t_2,	s3t_1,	$06,	nRst,	$0C
	dc.b		s3t_1,	$06,	s3t_2,	$18,	s3t_1,	s3t_2,	s3t_1,	s3t_1
	dc.b		$06,	s3t_1,	s3t_1,	nRst,	s3t_1,	nRst,	s3t_1,	s3t_1
	dc.b		nRst,	s3t_1,	s3t_1,	s3t_1,	s3t_1,	s3t_1,	s3t_1,	s3t_1
	smpsStop

sonic3title_Voices:
;	Voice 00
;	$3D,$01,$00,$04,$03,$1F,$1F,$1F,$1F,$10,$06,$06,$06,$01,$06,$06,$06,$35,$1A,$18,$1A,$12,$82,$82,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$03,	$04,	$00,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$06,	$06,	$06,	$10
	smpsVcDecayRate2	$06,	$06,	$06,	$01
	smpsVcDecayLevel	$01,	$01,	$01,	$03
	smpsVcReleaseRate	$0A,	$08,	$0A,	$05
	smpsVcTotalLevel	$80,	$82,	$82,	$12

;	Voice 01
;	$3A,$01,$02,$01,$01,$1F,$5F,$5F,$5F,$10,$11,$09,$09,$07,$00,$00,$00,$CF,$FF,$FF,$FF,$1C,$22,$18,$80
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$02,	$01
	smpsVcRateScale		$01,	$01,	$01,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$09,	$09,	$11,	$10
	smpsVcDecayRate2	$00,	$00,	$00,	$07
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0C
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$80,	$18,	$22,	$1C

;	Voice 02
;	$3C,$71,$31,$12,$11,$17,$1F,$19,$2F,$04,$01,$07,$01,$00,$00,$00,$00,$F7,$F8,$F7,$F8,$1D,$84,$19,$84
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$01,	$01,	$03,	$07
	smpsVcCoarseFreq	$01,	$02,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$0F,	$19,	$1F,	$17
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$01,	$07,	$01,	$04
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$08,	$07,	$08,	$07
	smpsVcTotalLevel	$84,	$19,	$84,	$1D

;	Voice 03
;	$3D,$01,$01,$01,$01,$94,$19,$19,$19,$0F,$0D,$0D,$0D,$07,$04,$04,$04,$25,$1A,$1A,$1A,$15,$80,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$02
	smpsVcAttackRate	$19,	$19,	$19,	$14
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0D,	$0D,	$0D,	$0F
	smpsVcDecayRate2	$04,	$04,	$04,	$07
	smpsVcDecayLevel	$01,	$01,	$01,	$02
	smpsVcReleaseRate	$0A,	$0A,	$0A,	$05
	smpsVcTotalLevel	$80,	$80,	$80,	$15

;	Voice 04
;	$80,$86,$86,$80,$86,$81,$86,$86,$80,$86,$80,$86,$80,$81,$80,$86,$80,$86,$86,$80,$86,$81,$86,$86,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$08,	$08,	$08,	$08
	smpsVcCoarseFreq	$06,	$00,	$06,	$06
	smpsVcRateScale		$02,	$02,	$02,	$02
	smpsVcAttackRate	$00,	$06,	$06,	$01
	smpsVcAmpMod		$04,	$04,	$04,	$04
	smpsVcDecayRate1	$00,	$06,	$00,	$06
	smpsVcDecayRate2	$80,	$86,	$80,	$81
	smpsVcDecayLevel	$08,	$08,	$08,	$08
	smpsVcReleaseRate	$06,	$00,	$06,	$06
	smpsVcTotalLevel	$80,	$86,	$86,	$81

;	Voice 05
;	$80,$86,$80,$86,$81,$86,$86,$86,$86,$80,$80,$80,$81,$80,$80,$81,$86,$0C,$86,$81,$88,$F2,$3D,$61,$02
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$08,	$08,	$08,	$08
	smpsVcCoarseFreq	$01,	$06,	$00,	$06
	smpsVcRateScale		$02,	$02,	$02,	$02
	smpsVcAttackRate	$06,	$06,	$06,	$06
	smpsVcAmpMod		$04,	$04,	$04,	$04
	smpsVcDecayRate1	$01,	$00,	$00,	$00
	smpsVcDecayRate2	$86,	$81,	$80,	$80
	smpsVcDecayLevel	$08,	$08,	$08,	$00
	smpsVcReleaseRate	$08,	$01,	$06,	$0C
	smpsVcTotalLevel	$02,	$61,	$3D,	$F2

;	Voice 06
;	$12,$52,$1F,$18,$18,$1B,$09,$02,$01,$02,$06,$00,$00,$00,$5F,$4F,$3F,$4F,$17,$80,$80,$80,$2D,$01,$51
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$02
;				op1	op2	op3	op4
	smpsVcDetune		$01,	$01,	$01,	$05
	smpsVcCoarseFreq	$08,	$08,	$0F,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$01,	$02,	$09,	$1B
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$00,	$06,	$02
	smpsVcDecayRate2	$3F,	$4F,	$5F,	$00
	smpsVcDecayLevel	$08,	$08,	$01,	$04
	smpsVcReleaseRate	$00,	$00,	$07,	$0F
	smpsVcTotalLevel	$51,	$01,	$2D,	$80

;	Voice 07
;	$31,$21,$13,$1F,$19,$1F,$0B,$09,$00,$0B,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$0C,$80,$80,$80,$0A,$51,$76
;				#
	smpsVcAlgorithm		$01
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$01,	$01,	$01,	$02
	smpsVcCoarseFreq	$09,	$0F,	$03,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$00,	$09,	$0B,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$00,	$00,	$0B
	smpsVcDecayRate2	$FF,	$FF,	$FF,	$00
	smpsVcDecayLevel	$08,	$08,	$00,	$0F
	smpsVcReleaseRate	$00,	$00,	$0C,	$0F
	smpsVcTotalLevel	$76,	$51,	$0A,	$80

;	Voice 08
;	$01,$19,$1C,$1B,$1C,$1F,$00,$08,$04,$11,$00,$01,$00,$00,$1F,$FF,$FF,$7F,$82,$10,$32,$0C,$2A,$32,$2A
;				#
	smpsVcAlgorithm		$01
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$01,	$01,	$01,	$01
	smpsVcCoarseFreq	$0C,	$0B,	$0C,	$09
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$04,	$08,	$00,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$01,	$00,	$11
	smpsVcDecayRate2	$FF,	$FF,	$1F,	$00
	smpsVcDecayLevel	$03,	$01,	$08,	$07
	smpsVcReleaseRate	$02,	$00,	$02,	$0F
	smpsVcTotalLevel	$2A,	$32,	$2A,	$0C

;	Voice 09
;	$01,$02,$12,$12,$11,$16,$0A,$0E,$0E,$08,$00,$00,$00,$00,$FF,$FF,$1F,$CF,$15,$15,$2C,$85,$3D,$12,$58
;				#
	smpsVcAlgorithm		$01
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$01,	$01,	$01,	$00
	smpsVcCoarseFreq	$01,	$02,	$02,	$02
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$0E,	$0E,	$0A,	$16
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$00,	$00,	$08
	smpsVcDecayRate2	$1F,	$FF,	$FF,	$00
	smpsVcDecayLevel	$02,	$01,	$01,	$0C
	smpsVcReleaseRate	$0C,	$05,	$05,	$0F
	smpsVcTotalLevel	$58,	$12,	$3D,	$85

;	Voice 0A
;	$04,$15,$0F,$1A,$1C,$1A,$00,$00,$0F,$05,$00,$00,$00,$00,$0F,$0F,$1F,$FF,$22,$86,$86,$86,$3D,$51,$21
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$01,	$01,	$00,	$01
	smpsVcCoarseFreq	$0C,	$0A,	$0F,	$05
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$0F,	$00,	$00,	$1A
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$00,	$00,	$05
	smpsVcDecayRate2	$1F,	$0F,	$0F,	$00
	smpsVcDecayLevel	$08,	$08,	$02,	$0F
	smpsVcReleaseRate	$06,	$06,	$02,	$0F
	smpsVcTotalLevel	$21,	$51,	$3D,	$86

;	Voice 0B
;	$30,$10,$1F,$1F,$1F,$1F,$0F,$00,$00,$00,$00,$00,$00,$00,$1F,$4F,$4F,$4F,$10,$8E,$8E,$8E,$11,$51,$21
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$01,	$01,	$01,	$01
	smpsVcCoarseFreq	$0F,	$0F,	$0F,	$00
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$00,	$00,	$0F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$00,	$00,	$00
	smpsVcDecayRate2	$4F,	$4F,	$1F,	$00
	smpsVcDecayLevel	$08,	$08,	$01,	$04
	smpsVcReleaseRate	$0E,	$0E,	$00,	$0F
	smpsVcTotalLevel	$21,	$51,	$11,	$8E
	even
