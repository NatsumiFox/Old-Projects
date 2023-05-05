; =============================================================================================
; Project Name:		zoneclear_jw
; Created:		25th July 2012
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

zoneclear_jw_Header:
;	Voice Pointer	location
	smpsHeaderVoice	zoneclear_jw_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$04,	$00
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$02,	$F

;	DAC Pointer	location
	smpsHeaderDAC	zoneclear_jw_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	zoneclear_jw_FM1,	smpsPitch00,	$10
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	zoneclear_jw_FM2,	smpsPitch00,	$10
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	zoneclear_jw_FM3,	smpsPitch00,	$0E

; FM1 Data
zoneclear_jw_FM1:
	dc.b		nRst,	$10
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nF4,	$08,	nG4,	$06,	nF4,	$22,	nEb4,	$10
	dc.b		nF4,	nG4,	$04,	$04,	nRst,	$04,	nG4,	nF4
	dc.b		$10,	nRst,	nF4,	$08,	nG4,	$06,	nF4,	$22
	dc.b		nBb4,	$10,	$06,	nA4,	$05,	nF4,	nG4,	$20
	dc.b		nRst,	$01
	smpsStop

; FM2 Data
zoneclear_jw_FM2:
	dc.b		nRst,	$10
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$04
	dc.b		nF4,	$08,	nG4,	$06,	nF4,	$22,	nEb4,	$10
	dc.b		nF4,	nG4,	$04,	$04,	nRst,	$04,	nG4,	nF4
	dc.b		$10,	nRst,	nF4,	$08,	nG4,	$06,	nF4,	$22
	dc.b		nBb4,	$10,	$06,	nA4,	$05,	nF4,	nG4,	$18
	dc.b		nRst,	$09
	smpsStop

; FM3 Data
zoneclear_jw_FM3:
	dc.b		nRst,	$28
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$05
	dc.b		nA1,	$04,	nB1,	nC2,	nRst,	nA1,	nB1,	nC2
	dc.b		$10,	nRst,	nEb2,	nD2,	nRst,	$28,	nA1,	$04
	dc.b		nB1,	nC2,	nRst,	nA1,	nB1,	nC2,	$10,	nRst
	dc.b		nC2,	nRst,	$11
	smpsStop

; DAC Data
zoneclear_jw_DAC:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		dSnare,	$08,	dKick,	$02,	nRst,	$01,	dSnare,	$02
	dc.b		nRst,	$01,	dSnare,	$02,	$04,	nRst,	$04,	dSnare
	dc.b		nRst,	$02,	dSnare,	$04,	nRst,	$0E,	dTimpani,	$08
	dc.b		dKick,	nRst,	$10,	dSnare,	$08,	nRst,	$18,	dSnare
	dc.b		$08,	nRst,	dSnare,	dSnare,	$02,	nRst,	$01,	dSnare
	dc.b		$02,	nRst,	$01,	dSnare,	$02,	$04,	nRst,	$04
	dc.b		dSnare,	nRst,	$02,	dSnare,	$04,	nRst,	$0E,	dTimpani
	dc.b		$08,	dKick,	nRst,	$10,	dTimpani,	$08,	nRst,	dTimpani
	dc.b		nRst,	$19
	smpsStop

zoneclear_jw_Voices:
;	Voice 00
;	$38,$33,$01,$51,$01,$10,$13,$1A,$1B,$0F,$1F,$1F,$1F,$01,$01,$01,$01,$33,$03,$03,$08,$16,$1A,$19,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$05,	$00,	$03
	smpsVcCoarseFreq	$01,	$01,	$01,	$03
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1B,	$1A,	$13,	$10
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$1F,	$1F,	$0F
	smpsVcDecayRate2	$01,	$01,	$01,	$01
	smpsVcDecayLevel	$00,	$00,	$00,	$03
	smpsVcReleaseRate	$08,	$03,	$03,	$03
	smpsVcTotalLevel	$80,	$19,	$1A,	$16

;	Voice 01
;	$38,$33,$01,$51,$01,$10,$13,$1A,$1B,$0F,$1F,$1F,$1F,$01,$01,$01,$01,$33,$03,$03,$08,$16,$1A,$19,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$05,	$00,	$03
	smpsVcCoarseFreq	$01,	$01,	$01,	$03
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1B,	$1A,	$13,	$10
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$1F,	$1F,	$0F
	smpsVcDecayRate2	$01,	$01,	$01,	$01
	smpsVcDecayLevel	$00,	$00,	$00,	$03
	smpsVcReleaseRate	$08,	$03,	$03,	$03
	smpsVcTotalLevel	$80,	$19,	$1A,	$16

;	Voice 02
;	$38,$33,$01,$51,$01,$10,$13,$1A,$1B,$0F,$1F,$1F,$1F,$01,$01,$01,$01,$33,$03,$03,$08,$16,$1A,$19,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$05,	$00,	$03
	smpsVcCoarseFreq	$01,	$01,	$01,	$03
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1B,	$1A,	$13,	$10
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$1F,	$1F,	$0F
	smpsVcDecayRate2	$01,	$01,	$01,	$01
	smpsVcDecayLevel	$00,	$00,	$00,	$03
	smpsVcReleaseRate	$08,	$03,	$03,	$03
	smpsVcTotalLevel	$80,	$19,	$1A,	$16

;	Voice 03
;	$38,$33,$01,$51,$01,$10,$13,$1A,$1B,$0F,$1F,$1F,$1F,$01,$01,$01,$01,$33,$03,$03,$08,$16,$1A,$19,$80
;				#
	smpsVcAlgorithm		$00
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$05,	$00,	$03
	smpsVcCoarseFreq	$01,	$01,	$01,	$03
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1B,	$1A,	$13,	$10
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$1F,	$1F,	$0F
	smpsVcDecayRate2	$01,	$01,	$01,	$01
	smpsVcDecayLevel	$00,	$00,	$00,	$03
	smpsVcReleaseRate	$08,	$03,	$03,	$03
	smpsVcTotalLevel	$80,	$19,	$1A,	$16

;	Voice 04
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

;	Voice 05
;	$39,$0A,$D0,$00,$01,$1F,$5F,$5F,$5F,$13,$12,$0D,$08,$0C,$0F,$0F,$0C,$8F,$8F,$7F,$4F,$28,$27,$20,$06
;				#
	smpsVcAlgorithm		$01
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$0D,	$00
	smpsVcCoarseFreq	$01,	$00,	$00,	$0A
	smpsVcRateScale		$01,	$01,	$01,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$08,	$0D,	$12,	$13
	smpsVcDecayRate2	$0C,	$0F,	$0F,	$0C
	smpsVcDecayLevel	$04,	$07,	$08,	$08
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$06,	$20,	$27,	$28
	even
