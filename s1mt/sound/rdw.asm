; =============================================================================================
; Project Name:		rdw
; Created:		21st September 2015
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

rdw_Header:
;	Voice Pointer	location
	smpsHeaderVoice	rdw_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$07,	$03
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$02,	$05

;	DAC Pointer	location
	smpsHeaderDAC	rdw_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	rdw_FM1,	smpsPitch00,	$16
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	rdw_FM2,	smpsPitch00,	$0A
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	rdw_FM3,	smpsPitch00,	$10
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	rdw_FM4,	smpsPitch01hi+$04,	$0D
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	rdw_FM5,	smpsPitch00,	$10
;	FM6 Pointer	location	pitch		volume
	smpsHeaderFM	rdw_FM6,	smpsPitch00,	$12
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	rdw_PSG1,	smpsPitch03lo,	$04,	$02
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	rdw_PSG2,	smpsPitch03lo,	$07,	$00
;	PSG3 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	rdw_PSG3,	smpsPitch00,	$03,	$00

; FM1 Data
rdw_FM1:
	dc.b		nRst,	$01
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nC0,	$01
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Notes	value
	smpsAlterNote	$05
;	Jump To	 	location
	smpsJump	rdw_FM3

; FM3 Data
rdw_FM3:
	dc.b		nRst,	$01
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nC0,	$01
rdw_Jump01:
;	Set FM Voice	#
	smpsFMvoice	$02
;	Set Modulation	wait	speed	change	step
	smpsModSet	$00,	$01,	$02,	$02
	dc.b		nB3,	$7F,	nRst,	$20,	nF3,	$7F,	nRst,	$20
	dc.b		nA3,	$7F,	nRst,	$20,	nEb3,	$7F,	nRst,	$20
;	Jump To	 	location
	smpsJump	rdw_Jump01

; FM2 Data
rdw_FM2:
	dc.b		nRst,	$18
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nC0,	$01
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nG4,	$01,	nRst,	$01
rdw_Loop01:
	dc.b		nAb4,	$02
;	Alter Pitch	value
	smpsAlterPitch	$01
;	Alter Volume	value
	smpsAlterVol	$01
;	Loop To	 	index	loops	location
	smpsLoop	$00,	$10,	rdw_Loop01
;	Alter Pitch	value
	smpsAlterPitch	$F0
;	Alter Volume	value
	smpsAlterVol	$F9
;	Set FM Voice	#
	smpsFMvoice	$01
;	Loop To	 	index	loops	location
	smpsLoop	$01,	$03,	rdw_Loop01
	dc.b		nRst,	$26
;	Alter Volume	value
	smpsAlterVol	$E5
;	Jump To	 	location
	smpsJump	rdw_FM2

; FM4 Data
rdw_FM4:
	dc.b		nRst,	$01
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nC0,	$01,	nRst,	$10
;	Alter Notes	value
	smpsAlterNote	$FB
;	Jump To	 	location
	smpsJump	rdw_FM2

; FM5 Data
rdw_FM5:
	dc.b		nRst,	$01
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nC0,	$01
	smpsStop

; FM6 Data
rdw_FM6:
	dc.b		nRst,	$01
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nC0,	$01,	nRst,	$0A
;	Panning	 	direction	amsfms
	smpsPan		panRight,	$00
;	Alter Notes	value
	smpsAlterNote	$04
;	Jump To	 	location
	smpsJump	rdw_FM2

; PSG1 Data
rdw_PSG1:
	dc.b		nRst,	$02
	smpsStop

; PSG2 Data
rdw_PSG2:
	dc.b		nRst,	$02
	smpsStop

; PSG3 Data
rdw_PSG3:
	dc.b		nRst,	$02
	smpsStop

; DAC Data
rdw_DAC:
	smpsStop

rdw_Voices:
;	Voice 00
;	$3C,$01,$01,$01,$01,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$0F,$0F,$0F,$0F,$30,$30,$30,$C0
;				#
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
;				op1	op2	op3	op4
	smpsVcDetune		$00,	$00,	$00,	$00
	smpsVcCoarseFreq	$01,	$01,	$01,	$01
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$1F,	$1F,	$1F,	$1F
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$1F,	$1F,	$1F,	$1F
	smpsVcDecayRate2	$1F,	$1F,	$1F,	$1F
	smpsVcDecayLevel	$00,	$00,	$00,	$00
	smpsVcReleaseRate	$0F,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$C0,	$30,	$30,	$30

;	Voice 01
;	$1A,$45,$60,$72,$53,$12,$1F,$1F,$06,$1F,$1F,$1F,$0F,$16,$01,$13,$10,$1F,$1F,$0F,$17,$10,$01,$27,$84
;				#
	smpsVcAlgorithm		$02
	smpsVcFeedback		$03
;				op1	op2	op3	op4
	smpsVcDetune		$05,	$07,	$06,	$04
	smpsVcCoarseFreq	$03,	$02,	$00,	$05
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$06,	$1F,	$1F,	$12
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$0F,	$1F,	$1F,	$1F
	smpsVcDecayRate2	$10,	$13,	$01,	$16
	smpsVcDecayLevel	$01,	$00,	$01,	$01
	smpsVcReleaseRate	$07,	$0F,	$0F,	$0F
	smpsVcTotalLevel	$84,	$27,	$01,	$10

;	Voice 02
;	$15,$46,$34,$74,$1F,$03,$06,$06,$06,$0A,$08,$08,$08,$05,$02,$02,$02,$12,$15,$15,$15,$10,$85,$80,$80
;				#
	smpsVcAlgorithm		$05
	smpsVcFeedback		$02
;				op1	op2	op3	op4
	smpsVcDetune		$01,	$07,	$03,	$04
	smpsVcCoarseFreq	$0F,	$04,	$04,	$06
	smpsVcRateScale		$00,	$00,	$00,	$00
	smpsVcAttackRate	$06,	$06,	$06,	$03
	smpsVcAmpMod		$00,	$00,	$00,	$00
	smpsVcDecayRate1	$08,	$08,	$08,	$0A
	smpsVcDecayRate2	$02,	$02,	$02,	$05
	smpsVcDecayLevel	$01,	$01,	$01,	$01
	smpsVcReleaseRate	$05,	$05,	$05,	$02
	smpsVcTotalLevel	$80,	$80,	$85,	$10
	even
