; =============================================================================================
; Project Name:		Boss
; Created:		9th September 2012
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

Boss_Header:
;	Voice Pointer	location
	smpsHeaderVoice	Boss_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$01,	$00

;	DAC Pointer	location
	smpsHeaderDAC	Boss_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	Boss_FM1,	smpsPitch00+$01,	$0C
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	Boss_FM2,	smpsPitch00+$01,	$0C
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	Boss_FM3,	smpsPitch00+$01,	$0C
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	Boss_FM4,	smpsPitch00+$01,	$0C
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	Boss_FM5,	smpsPitch00+$01,	$13
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Boss_PSG1,	smpsPitch02lo,	$03,	$00
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Boss_PSG2,	smpsPitch02lo,	$02,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	Boss_PSG3,	smpsPitch02lo,	$02,	$00

; FM1 Data
Boss_FM1:
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0D,	$01,	$02,	$06
Boss_Loop01:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nB5,	$06,	nRst,	nB5,	nRst,	nB5,	nRst,	nB5
	dc.b		nRst,	nB5,	nRst,	nB5,	nRst,	nB5,	nRst,	nB5
	dc.b		nRst,	nB5,	nRst
;	Set FM Voice	#
	smpsFMvoice	$07
	dc.b		nE3,	$24,	nFs3,	$30
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	Boss_Loop01
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nE4,	$3C,	nFs4,	$0C,	nG4,	nA4,	nB4,	$18
	dc.b		nA4,	nG4,	nFs4,	nG4,	$0C,	nE4,	$06,	nRst
	dc.b		nE4,	nRst,	nE4,	$0C,	nB3,	$06,	nRst,	nB3
	dc.b		nRst,	nE4,	$0C,	nFs4,	$06,	nRst,	nA4,	$0C
	dc.b		nG4,	nFs4,	nA4,	$3C,	nE4,	nFs4,	$0C,	nG4
	dc.b		nA4,	nB4,	$18,	nA4,	nG4,	nFs4,	nG4,	$0C
	dc.b		nE4,	$06,	nRst,	nE4,	nRst,	nE4,	$0C,	nB3
	dc.b		$06,	nRst,	nB3,	nRst,	nE4,	$0C,	nFs4,	$06
	dc.b		nRst,	nA4,	$0C,	nG4,	nFs4,	nA4,	$18,	nA4
	dc.b		$0C,	nB4,	nA4,	nG4,	nE4,	$06,	nRst,	nC4
	dc.b		nRst,	nG4,	$0C,	nE4,	$06,	nRst,	nC4,	nRst
	dc.b		nG4,	$0C,	nE4,	$06,	nRst,	nA4,	$0C,	nFs4
	dc.b		$06,	nRst,	nD4,	nRst,	nA4,	$0C,	nFs4,	$06
	dc.b		nRst,	nD4,	nRst,	nA4,	$0C,	nFs4,	$06,	nRst
	dc.b		nB4,	$0C,	nG4,	$06,	nRst,	nE4,	nRst,	nB4
	dc.b		$0C,	nG4,	$06,	nRst,	nE4,	nRst,	nD5,	$0C
	dc.b		nC5,	$06,	nRst,	nB4,	$0C,	nC5,	$06,	nRst
	dc.b		nB4,	nRst,	nG4,	$3C,	nG4,	$0C,	nE4,	$06
	dc.b		nRst,	nC4,	nRst,	nG4,	$0C,	nE4,	$06,	nRst
	dc.b		nC4,	nRst,	nG4,	$0C,	nE4,	$06,	nRst,	nA4
	dc.b		$0C,	nFs4,	$06,	nRst,	nD4,	nRst,	nA4,	$0C
	dc.b		nFs4,	$06,	nRst,	nD4,	nRst,	nA4,	$0C,	nFs4
	dc.b		$06,	nRst,	nB4,	$0C,	nG4,	$06,	nRst,	nE4
	dc.b		nRst,	nB4,	$0C,	nG4,	$06,	nRst,	nE4,	nRst
	dc.b		nD5,	$0C,	nC5,	$06,	nRst,	nB4,	$0C,	nA4
	dc.b		$06,	nRst,	nB4,	nRst,	nE5,	$3C
;	Jump To	 	location
	smpsJump	Boss_FM1
	smpsStop

; FM2 Data
Boss_FM2:
;	Set FM Voice	#
	smpsFMvoice	$01
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0D,	$01,	$02,	$06
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
Boss_Loop02:
	dc.b		nE3,	$0C,	nE3,	$06,	nRst,	nE3,	nRst,	nE3
	dc.b		$0C,	nE3,	$06,	nRst,	nE3,	nRst,	nE3,	$0C
	dc.b		nE3,	nRst,	nC3,	$24,	nD3,	$30
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	Boss_Loop02
Boss_Loop03:
	dc.b		nE2,	$0C,	nE3,	nE2,	nE3,	nE2,	nE3,	nE2
	dc.b		nE3,	nE2,	nE3,	nE2,	nE3,	nE2,	nE3,	nE2
	dc.b		nE3,	nE2,	nE3,	nE2,	nE3,	nE2,	nE3,	nE2
	dc.b		nE3,	nD3,	nD4,	nD3,	nD4,	nD3,	nD4,	nD3
	dc.b		nD4
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	Boss_Loop03
	dc.b		nC3,	$0C,	nC3,	nC4,	nC4,	nG3,	nG3,	nC4
	dc.b		nC4,	nD3,	nD3,	nD4,	nD4,	nA3,	nA3,	nD4
	dc.b		nD4,	nE2,	nE2,	nE3,	nE3,	nB2,	nB2,	nE2
	dc.b		nE2,	nE3,	nD3,	nE3,	nE2,	nE2,	nB2,	nE3
	dc.b		nB3,	nC3,	nC3,	nC4,	nC4,	nG3,	nG3,	nC4
	dc.b		nC4,	nD3,	nD3,	nD4,	nD4,	nA3,	nA3,	nD4
	dc.b		nD4,	nE2,	nE3,	nE3,	nE2,	nE3,	nE3,	nD3
	dc.b		nE3,	nA3,	nB3,	nD3,	nE3,	nA2,	nB2,	nE2
	dc.b		$18
;	Jump To	 	location
	smpsJump	Boss_FM2
	smpsStop

; FM3 Data
Boss_FM3:
;	Set FM Voice	#
	smpsFMvoice	$03
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0D,	$01,	$02,	$06
Boss_Loop04:
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
	dc.b		nE5,	$0C,	nB4,	$06,	nRst,	nB4,	nRst,	nB4
	dc.b		$0C,	nG4,	$06,	nRst,	nG4,	nRst,	nG4,	$0C
	dc.b		nE4,	$06,	nRst,	nE4,	nRst,	nG4,	$24,	nA4
	dc.b		$30
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	Boss_Loop04
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		nB3,	$0C,	nRst,	$54,	nG3,	$0C,	nRst,	$54
	dc.b		nB3,	$0C,	nRst,	$54
;	Set FM Voice	#
	smpsFMvoice	$05
	dc.b		nC5,	$0C,	nB4,	nA4,	nA4,	$3C
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		nB3,	$0C,	nRst,	$54,	nG3,	$0C,	nRst,	$54
	dc.b		nB3,	$0C,	nRst,	$54
;	Set FM Voice	#
	smpsFMvoice	$05
	dc.b		nC5,	$0C,	nB4,	nA4,	nD5,	$3C
Boss_Loop05:
;	Set FM Voice	#
	smpsFMvoice	$06
	dc.b		nG3,	$30,	nC4,	nA3,	nD4,	nG3,	nB3,	nE4
	dc.b		$18,	nB3,	nG3,	nE3
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	Boss_Loop05
;	Jump To	 	location
	smpsJump	Boss_FM3
	smpsStop

; FM4 Data
Boss_FM4:
;	Set FM Voice	#
	smpsFMvoice	$03
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0D,	$01,	$02,	$06
Boss_Loop06:
;	Panning	 	direction	amsfms
	smpsPan		panLeft,	$00
	dc.b		nB4,	$0C,	nG4,	$06,	nRst,	nG4,	nRst,	nG4
	dc.b		$0C,	nE4,	$06,	nRst,	nE4,	nRst,	nE4,	$0C
	dc.b		nB3,	$06,	nRst,	nB3,	nRst,	nE4,	$24,	nFs4
	dc.b		$30
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	Boss_Loop06
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		nG3,	$0C,	nRst,	$54,	nE3,	$0C,	nRst,	$54
	dc.b		nG3,	$0C,	nRst,	$54
;	Set FM Voice	#
	smpsFMvoice	$05
	dc.b		nD4,	$0C,	nD4,	nD4,	nFs4,	$3C
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		nG3,	$0C,	nRst,	$54,	nE3,	$0C,	nRst,	$54
	dc.b		nG3,	$0C,	nRst,	$54
;	Set FM Voice	#
	smpsFMvoice	$05
	dc.b		nD4,	$0C,	nD4,	nD4,	nFs4,	$3C
Boss_Loop07:
;	Set FM Voice	#
	smpsFMvoice	$06
	dc.b		nE3,	$30,	nG3,	nFs3,	nA3,	nE3,	nG3,	nB3
	dc.b		$18,	nG3,	nE3,	nB2
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	Boss_Loop07
;	Jump To	 	location
	smpsJump	Boss_FM4
	smpsStop

; FM5 Data
Boss_FM5:
	dc.b		nRst,	$1D
Boss_Jump01:
;	Set Modulation	wait	speed	change	step
	smpsModSet	$0D,	$01,	$02,	$06
Boss_Loop08:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nB5,	$06,	nRst,	nB5,	nRst,	nB5,	nRst,	nB5
	dc.b		nRst,	nB5,	nRst,	nB5,	nRst,	nB5,	nRst,	nB5
	dc.b		nRst,	nB5,	nRst
;	Set FM Voice	#
	smpsFMvoice	$07
	dc.b		nE3,	$24,	nFs3,	$30
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$02,	Boss_Loop08
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nE4,	$3C,	nFs4,	$0C,	nG4,	nA4,	nB4,	$18
	dc.b		nA4,	nG4,	nFs4,	nG4,	$0C,	nE4,	$06,	nRst
	dc.b		nE4,	nRst,	nE4,	$0C,	nB3,	$06,	nRst,	nB3
	dc.b		nRst,	nE4,	$0C,	nFs4,	$06,	nRst,	nA4,	$0C
	dc.b		nG4,	nFs4,	nA4,	$3C,	nE4,	nFs4,	$0C,	nG4
	dc.b		nA4,	nB4,	$18,	nA4,	nG4,	nFs4,	nG4,	$0C
	dc.b		nE4,	$06,	nRst,	nE4,	nRst,	nE4,	$0C,	nB3
	dc.b		$06,	nRst,	nB3,	nRst,	nE4,	$0C,	nFs4,	$06
	dc.b		nRst,	nA4,	$0C,	nG4,	nFs4,	nA4,	$18,	nA4
	dc.b		$0C,	nB4,	nA4,	nG4,	nE4,	$06,	nRst,	nC4
	dc.b		nRst,	nG4,	$0C,	nE4,	$06,	nRst,	nC4,	nRst
	dc.b		nG4,	$0C,	nE4,	$06,	nRst,	nA4,	$0C,	nFs4
	dc.b		$06,	nRst,	nD4,	nRst,	nA4,	$0C,	nFs4,	$06
	dc.b		nRst,	nD4,	nRst,	nA4,	$0C,	nFs4,	$06,	nRst
	dc.b		nB4,	$0C,	nG4,	$06,	nRst,	nE4,	nRst,	nB4
	dc.b		$0C,	nG4,	$06,	nRst,	nE4,	nRst,	nD5,	$0C
	dc.b		nC5,	$06,	nRst,	nB4,	$0C,	nC5,	$06,	nRst
	dc.b		nB4,	nRst,	nG4,	$3C,	nG4,	$0C,	nE4,	$06
	dc.b		nRst,	nC4,	nRst,	nG4,	$0C,	nE4,	$06,	nRst
	dc.b		nC4,	nRst,	nG4,	$0C,	nE4,	$06,	nRst,	nA4
	dc.b		$0C,	nFs4,	$06,	nRst,	nD4,	nRst,	nA4,	$0C
	dc.b		nFs4,	$06,	nRst,	nD4,	nRst,	nA4,	$0C,	nFs4
	dc.b		$06,	nRst,	nB4,	$0C,	nG4,	$06,	nRst,	nE4
	dc.b		nRst,	nB4,	$0C,	nG4,	$06,	nRst,	nE4,	nRst
	dc.b		nD5,	$0C,	nC5,	$06,	nRst,	nB4,	$0C,	nA4
	dc.b		$06,	nRst,	nB4,	nRst,	nE5,	$3C
;	Jump To	 	location
	smpsJump	Boss_Jump01
	smpsStop

; DAC Data
Boss_DAC:
	dc.b		dSnare,	$0C,	dKick,	dKick,	dSnare,	dKick,	dKick,	dSnare
	dc.b		dKick,	dSnare,	dKick,	$24,	dKick,	$18,	dSnare,	$0C
	dc.b		dSnare,	dSnare,	dKick,	dKick,	dSnare,	dKick,	dKick,	dSnare
	dc.b		dKick,	dSnare,	dKick,	$24,	dKick,	$0C,	dSnare,	dSnare
	dc.b		dSnare
Boss_Loop09:
	dc.b		dKick,	$0C,	dSnare,	dSnare,	dSnare,	$06,	dSnare,	dKick
	dc.b		$0C,	dSnare,	dKick,	dSnare
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$0F,	Boss_Loop09
	dc.b		dKick,	$0C,	dSnare,	dSnare,	dSnare,	$06,	dSnare,	dKick
	dc.b		$0C,	dSnare,	dSnare,	dSnare
;	Jump To	 	location
	smpsJump	Boss_DAC
	smpsStop

; PSG1 Data
Boss_PSG1:
	dc.b		nCs0,	$0D,	$01,	$02,	$06,	nRst,	$60,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	nRst,	nCs0,	$0C,	nCs0
	dc.b		$06,	nRst,	nCs0,	nRst,	nCs0,	$3C,	nCs0,	$0C
	dc.b		nCs0,	$06,	nRst,	nCs0,	nRst,	nCs0,	$0C,	nCs0
	dc.b		$06,	nRst,	nCs0,	nRst,	nCs0,	$0C,	nCs0,	$06
	dc.b		nRst,	nCs0,	$0C,	nCs0,	$06,	nRst,	nCs0,	nRst
	dc.b		nCs0,	$0C,	nCs0,	$06,	nRst,	nCs0,	nRst,	nCs0
	dc.b		$0C,	nCs0,	$06,	nRst,	nCs0,	$0C,	nCs0,	$06
	dc.b		nRst,	nCs0,	nRst,	nCs0,	$0C,	nCs0,	$06,	nRst
	dc.b		nCs0,	nRst,	nCs0,	$0C,	nCs0,	$06,	nRst,	nCs0
	dc.b		$0C,	nCs0,	$06,	nRst,	nCs0,	nRst,	nCs0,	$3C
;	Jump To	 	location
	smpsJump	Boss_PSG1
	smpsStop

; PSG2 Data
Boss_PSG2:
	smpsStop
	smpsStop

; PSG3 Data
Boss_PSG3:
	smpsStop

Boss_Voices:
;	Voice 00
;	$3A,$48,$56,$54,$41,$0F,$14,$53,$14,$04,$06,$06,$03,$00,$0F,$00,$00,$1F,$3F,$5F,$1F,$22,$13,$26,$84
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$04,	$05,	$05,	$04
	smpsVcCoarseFreq	$01,	$04,	$06,	$08
	smpsVcRateScale		$00,	$01,	$00,	$00
	smpsVcAttackRate	$14,	$13,	$14,	$0F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$03,	$06,	$06,	$04
	smpsVcDecayRate2	$00,	$00,	$0F,	$00
	smpsVcDecayLevel	$01,	$05,	$03,	$01
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$84,	$26,	$13,	$22

;	Voice 01
;	$00,$71,$10,$70,$10,$18,$58,$18,$1A,$09,$08,$01,$01,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$1A,$17,$1C,$83
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$01,	$07,	$01,	$07
	smpsVcCoarseFreq	$00,	$00,	$00,	$01
	smpsVcRateScale		$00,	$00,	$01,	$00
	smpsVcAttackRate	$1A,	$18,	$18,	$18
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$01,	$01,	$08,	$09
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$83,	$1C,	$17,	$1A

;	Voice 02
;	$34,$74,$21,$16,$71,$11,$1F,$1F,$1F,$08,$05,$08,$09,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$17,$88,$10,$88
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$06
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$01,	$02,	$07
	smpsVcCoarseFreq	$01,	$06,	$01,	$04
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$11
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$09,	$08,	$05,	$08
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$88,	$10,	$88,	$17

;	Voice 03
;	$2C,$43,$01,$21,$71,$0E,$11,$12,$17,$00,$00,$00,$00,$08,$00,$09,$00,$89,$F8,$F9,$F8,$17,$8F,$0C,$89
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$05
;				op1	op2	op3	op4
	smpsVcDetune		$07,	$02,	$00,	$04
	smpsVcCoarseFreq	$01,	$01,	$01,	$03
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$17,	$12,	$11,	$0E
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$00,	$00,	$00
	smpsVcDecayRate2	$00,	$09,	$00,	$08
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$08
	smpsVcReleaseRate	$08,	$09,	$08,	$09
	smpsVcTotalLevel	$89,	$0C,	$8F,	$17

;	Voice 04
;	$3D,$31,$50,$21,$41,$0D,$13,$13,$14,$03,$01,$06,$05,$05,$01,$05,$01,$FF,$FF,$FF,$FF,$1D,$8A,$88,$87
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$04,	$02,	$05,	$03
	smpsVcCoarseFreq	$01,	$01,	$00,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$14,	$13,	$13,	$0D
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$05,	$06,	$01,	$03
	smpsVcDecayRate2	$01,	$05,	$01,	$05
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$87,	$88,	$8A,	$1D

;	Voice 05
;	$07,$75,$53,$12,$31,$1F,$1F,$1F,$1F,$00,$00,$00,$00,$0C,$13,$0C,$0B,$FF,$FF,$FF,$FF,$8E,$86,$85,$89
;				#
	smpsVcAlgorithm		$07
	smpsVcFeedback		$00
;				op1	op2	op3	op4
	smpsVcDetune		$03,	$01,	$05,	$07
	smpsVcCoarseFreq	$01,	$02,	$03,	$05
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$00,	$00,	$00,	$00
	smpsVcDecayRate2	$0B,	$0C,	$13,	$0C
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$89,	$85,	$86,	$8E

;	Voice 06
;	$3D,$71,$23,$41,$41,$10,$18,$14,$14,$01,$04,$02,$03,$00,$06,$04,$07,$FF,$FC,$FF,$F8,$1D,$88,$86,$86
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$04,	$04,	$02,	$07
	smpsVcCoarseFreq	$01,	$01,	$03,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$14,	$14,	$18,	$10
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$03,	$02,	$04,	$01
	smpsVcDecayRate2	$07,	$04,	$06,	$00
	smpsVcDecayLevel	$0F,	$0F,	$0F,	$0F
	smpsVcReleaseRate	$08,	$0F,	$0C,	$0F
	smpsVcTotalLevel	$86,	$86,	$88,	$1D

;	Voice 07
;	$10,$21,$13,$38,$44,$1D,$1D,$1D,$1E,$04,$07,$04,$07,$00,$00,$00,$00,$5F,$5F,$5F,$5F,$25,$0A,$1F,$8B
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$02
;				op1	op2	op3	op4
	smpsVcDetune		$04,	$03,	$01,	$02
	smpsVcCoarseFreq	$04,	$08,	$03,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1E,	$1D,	$1D,	$1D
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$07,	$04,	$07,	$04
	smpsVcDecayRate2	$00,	$00,	$00,	$00
	smpsVcDecayLevel	$05,	$05,	$05,	$05
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$8B,	$1F,	$0A,	$25
	even
