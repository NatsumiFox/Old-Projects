Snd_UGT_Header:
	sHeaderInit
	sHeaderTempo	$01, $02
	sHeaderCh	$06, $00

	sHeaderDAC	Snd_UGT_DAC1,	$04
	sHeaderDAC	Snd_UGT_DAC2
	sHeaderFM	Snd_UGT_FM1,	$00, $00
	sHeaderFM	Snd_UGT_FM2,	$00, $00
	sHeaderFM	Snd_UGT_FM3,	$00, $00
	sHeaderFM	Snd_UGT_FM4,	$00, $00
	sHeaderFM	Snd_UGT_FM5,	$00, $00
	sHeaderFM	Snd_UGT_FM6,	$00, $00

;	Voice $00
;	$04
;	$30, $78, $30, $08, 	$04, $1F, $04, $1F, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$F2, $FF, $F2, $F8, 	$7F, $7F, $06, $00
	spAlgorithm	$04
	spFeedback	$00
	spDetune	$03, $03, $07, $00
	spMultiple	$00, $00, $08, $08
	spRateScale	$00, $00, $00, $00
	spAttackRt	$04, $04, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$02, $02, $0F, $08
	spSSGEG		$00, $00, $00, $00
	spTotalLv	$7F, $06, $7F, $00

;	Voice $01
;	$04
;	$02, $01, $00, $00, 	$1F, $18, $1F, $1F, 	$1B, $0C, $09, $14
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$1B, $00, $2D, $19
	spAlgorithm	$04
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$02, $00, $01, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $18, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$1B, $09, $0C, $14
	spDecayRt	$00, $00, $00, $00
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spSSGEG		$00, $00, $00, $00
	spTotalLv	$1B, $2D, $00, $19

;	Voice $02
;	$2C
;	$62, $72, $02, $31, 	$1F, $0B, $1F, $1F, 	$00, $00, $06, $00
;	$00, $00, $00, $00, 	$0F, $FF, $F0, $F0, 	$00, $0F, $31, $00
	spAlgorithm	$04
	spFeedback	$05
	spDetune	$06, $00, $07, $03
	spMultiple	$02, $02, $02, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $0B, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $06, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainLv	$00, $0F, $0F, $0F
	spReleaseRt	$0F, $00, $0F, $00
	spSSGEG		$00, $00, $08, $00
	spTotalLv	$00, $31, $0F, $00

;	Voice $03
;	$27
;	$31, $72, $00, $38, 	$1F, $05, $1F, $1F, 	$0D, $00, $00, $00
;	$00, $00, $00, $00, 	$FB, $02, $F4, $F6, 	$00, $7F, $7F, $7F
	spAlgorithm	$07
	spFeedback	$04
	spDetune	$03, $00, $07, $03
	spMultiple	$01, $00, $02, $08
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $05, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0D, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainLv	$0F, $0F, $00, $0F
	spReleaseRt	$0B, $04, $02, $06
	spSSGEG		$08, $08, $08, $0C
	spTotalLv	$00, $7F, $7F, $7F

;	Voice $04
;	$27
;	$01, $05, $03, $00, 	$1F, $1F, $1F, $1F, 	$14, $14, $14, $16
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$00, $00, $00, $7F
	spAlgorithm	$07
	spFeedback	$04
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $03, $05, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$14, $14, $14, $16
	spDecayRt	$00, $00, $00, $00
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spSSGEG		$08, $08, $08, $0C
	spTotalLv	$00, $00, $00, $7F

;	Voice $05
;	$27
;	$01, $05, $04, $00, 	$1F, $1F, $1F, $1F, 	$14, $14, $14, $16
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$00, $00, $00, $7F
	spAlgorithm	$07
	spFeedback	$04
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $04, $05, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$14, $14, $14, $16
	spDecayRt	$00, $00, $00, $00
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spSSGEG		$08, $08, $08, $0C
	spTotalLv	$00, $00, $00, $7F

;	Voice $06
;	$27
;	$00, $01, $03, $00, 	$1F, $1F, $1F, $1F, 	$14, $14, $14, $16
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$00, $00, $00, $7F
	spAlgorithm	$07
	spFeedback	$04
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $03, $01, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$14, $14, $14, $16
	spDecayRt	$00, $00, $00, $00
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spSSGEG		$08, $08, $08, $0C
	spTotalLv	$00, $00, $00, $7F

;	Voice $07
;	$27
;	$00, $01, $04, $00, 	$1F, $1F, $1F, $1F, 	$14, $14, $14, $16
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$00, $00, $00, $7F
	spAlgorithm	$07
	spFeedback	$04
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $04, $01, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$14, $14, $14, $16
	spDecayRt	$00, $00, $00, $00
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spSSGEG		$08, $08, $08, $0C
	spTotalLv	$00, $00, $00, $7F

;	Voice $08
;	$38
;	$00, $00, $00, $00, 	$1F, $1F, $1F, $11, 	$00, $00, $00, $1F
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $4F, 	$7F, $00, $00, $00
	spAlgorithm	$00
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $00, $00, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $11
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $00, $00, $1F
	spDecayRt	$00, $00, $00, $00
	spSustainLv	$00, $00, $00, $04
	spReleaseRt	$0F, $0F, $0F, $0F
	spSSGEG		$00, $00, $00, $00
	spTotalLv	$7F, $00, $00, $00

;	Voice $09
;	$27
;	$03, $04, $02, $00, 	$1F, $1F, $1F, $1F, 	$14, $14, $14, $16
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$00, $00, $00, $7F
	spAlgorithm	$07
	spFeedback	$04
	spDetune	$00, $00, $00, $00
	spMultiple	$03, $02, $04, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$14, $14, $14, $16
	spDecayRt	$00, $00, $00, $00
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spSSGEG		$08, $08, $08, $0C
	spTotalLv	$00, $00, $00, $7F

;	Voice $0A
;	$27
;	$03, $04, $04, $00, 	$1F, $1F, $1F, $1F, 	$14, $14, $14, $16
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$00, $00, $00, $7F
	spAlgorithm	$07
	spFeedback	$04
	spDetune	$00, $00, $00, $00
	spMultiple	$03, $04, $04, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$14, $14, $14, $16
	spDecayRt	$00, $00, $00, $00
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spSSGEG		$08, $08, $08, $0C
	spTotalLv	$00, $00, $00, $7F

;	Voice $0B
;	$1F
;	$02, $01, $01, $00, 	$18, $18, $18, $1F, 	$14, $14, $14, $16
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$00, $00, $00, $7F
	spAlgorithm	$07
	spFeedback	$03
	spDetune	$00, $00, $00, $00
	spMultiple	$02, $01, $01, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$18, $18, $18, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$14, $14, $14, $16
	spDecayRt	$00, $00, $00, $00
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spSSGEG		$00, $00, $00, $00
	spTotalLv	$00, $00, $00, $7F

;	Voice $0C
;	$1F
;	$01, $01, $02, $00, 	$18, $18, $18, $1F, 	$14, $14, $14, $16
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$00, $00, $00, $7F
	spAlgorithm	$07
	spFeedback	$03
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $02, $01, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$18, $18, $18, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$14, $14, $14, $16
	spDecayRt	$00, $00, $00, $00
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spSSGEG		$08, $08, $08, $0C
	spTotalLv	$00, $00, $00, $7F

;	Voice $0D
;	$38
;	$0F, $01, $01, $00, 	$1F, $1F, $1F, $1F, 	$00, $00, $00, $15
;	$00, $00, $00, $16, 	$0F, $0F, $0F, $3F, 	$00, $00, $00, $00
	spAlgorithm	$00
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$0F, $01, $01, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $00, $00, $15
	spDecayRt	$00, $00, $00, $16
	spSustainLv	$00, $00, $00, $03
	spReleaseRt	$0F, $0F, $0F, $0F
	spSSGEG		$08, $08, $08, $0C
	spTotalLv	$00, $00, $00, $00

;	Voice $0E
;	$33
;	$3D, $72, $00, $38, 	$04, $05, $09, $1F, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$00, $02, $F4, $F6, 	$11, $20, $04, $00
	spAlgorithm	$03
	spFeedback	$06
	spDetune	$03, $00, $07, $03
	spMultiple	$0D, $00, $02, $08
	spRateScale	$00, $00, $00, $00
	spAttackRt	$04, $09, $05, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainLv	$00, $0F, $00, $0F
	spReleaseRt	$00, $04, $02, $06
	spSSGEG		$00, $00, $00, $00
	spTotalLv	$11, $04, $20, $00

;	Voice $0F
;	$33
;	$3D, $72, $00, $38, 	$04, $05, $1F, $1F, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$06, $05, $F4, $F6, 	$11, $20, $04, $00
	spAlgorithm	$03
	spFeedback	$06
	spDetune	$03, $00, $07, $03
	spMultiple	$0D, $00, $02, $08
	spRateScale	$00, $00, $00, $00
	spAttackRt	$04, $1F, $05, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainLv	$00, $0F, $00, $0F
	spReleaseRt	$06, $04, $05, $06
	spSSGEG		$00, $00, $00, $00
	spTotalLv	$11, $04, $20, $00

;	Voice $10
;	$33
;	$3D, $72, $00, $38, 	$04, $05, $1F, $1F, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$07, $07, $F4, $F6, 	$11, $20, $04, $00
	spAlgorithm	$03
	spFeedback	$06
	spDetune	$03, $00, $07, $03
	spMultiple	$0D, $00, $02, $08
	spRateScale	$00, $00, $00, $00
	spAttackRt	$04, $1F, $05, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainLv	$00, $0F, $00, $0F
	spReleaseRt	$07, $04, $07, $06
	spSSGEG		$00, $00, $00, $00
	spTotalLv	$11, $04, $20, $00

; FM1 Data
Snd_UGT_FM1:
	sVoice		$00
	ssVol		$15
	sPan		spCenter, $00
	dc.b nF2, $03, nRst, $05
	saVol		$F1
	dc.b nF2, $06, nRst, $08, nF2, $03, nRst
	saVol		$0F
	dc.b nF2, $04
	saVol		$F9
	dc.b sHold, nF2, $05, nRst, $06, sHold, nF2, $03, nRst, $05, sHold, nF2
	dc.b $06, nRst, $09
	saVol		$F8
	dc.b nF2, $03, nRst, nF2, $08, nRst, $06
	saVol		$0F
	dc.b nEb2, $03
	saVol		$F9
	dc.b sHold, nEb2, $06, nRst, nFs2, $08, nRst, $06
	saVol		$07
	dc.b nF2, $03, nRst, $06
	saVol		$F1
	dc.b nF2, nRst, $08, nF2, $03, nRst
	saVol		$0F
	dc.b nF2
	saVol		$F9
	dc.b sHold, nF2, $06, nRst, $06, sHold, nF2, $03, nRst, $05, sHold, nF2
	dc.b $06, nRst, $08
	saVol		$F8
	dc.b nF2, $04, nRst, $03, nF2, $08, nRst, $06
	saVol		$0F
	dc.b nFs2, $03
	saVol		$F9
	dc.b sHold, nFs2, $05, nRst, $07, nEb2, $08, nRst, $06
	sVoice		$0E
	saVol		$0A
	dc.b nF2, $03, nRst, $05
	saVol		$F2
	dc.b nF2, $07, nRst, $08, nF2, $03, nRst
	saVol		$0E
	dc.b nF2
	saVol		$FA
	dc.b sHold, nF2, $05, nRst, $07, sHold, nF2, $03, nRst, $05, sHold, nF2
	dc.b $06, nRst, $08
	saVol		$F8
	dc.b nF2, $03, nRst, $04, nF2, $08, nRst, $06
	saVol		$0E
	dc.b nEb2, $03
	saVol		$FA
	dc.b sHold, nEb2, $05, nRst, $06, nFs2, $09, nRst, $06
	saVol		$06
	dc.b nF2, $03, nRst, $05
	saVol		$F2
	dc.b nF2, $06, nRst, $09, nF2, $03, nRst
	saVol		$0E
	dc.b nF2
	saVol		$FA
	dc.b sHold, nF2, $05, nRst, $06, sHold, nF2, $03, nRst, $06, sHold, nF2
	dc.b $06, nRst, $08
	saVol		$F8
	dc.b nF2, $03, nRst, nF2, $09, nRst, $06
	saVol		$0E
	dc.b nFs2, $03
	saVol		$FA
	dc.b sHold, nFs2, $05, nRst, $06, nEb2, $09, nRst, $06
	sVoice		$0F
	saVol		$08
	dc.b nF2, $03, nRst, $05
	saVol		$F2
	dc.b nF2, $06, nRst, $08, nF2, $04, nRst, $03
	saVol		$0E
	dc.b nF2
	saVol		$FA
	dc.b sHold, nF2, $05, nRst, $06, sHold, nF2, $03, nRst, $05, sHold, nF2
	dc.b $07, nRst, $08
	saVol		$F8
	dc.b nF2, $03, nRst, nF2, $08, nRst, $07
	saVol		$0E
	dc.b nEb2, $03
	saVol		$FA
	dc.b sHold, nEb2, $05, nRst, $06, nFs2, $08, nRst, $07
	saVol		$06
	dc.b nF2, $03, nRst, $05
	saVol		$F2
	dc.b nF2, $06, nRst, $08, nF2, $03, nRst, $04
	saVol		$0E
	dc.b nF2, $03
	saVol		$FA
	dc.b sHold, nF2, $05, nRst, $06, sHold, nF2, $03, nRst, $05, sHold, nF2
	dc.b $06, nRst, $09
	saVol		$F8
	dc.b nF2, $03, nRst, nF2, $08, nRst, $06
	saVol		$0E
	dc.b nFs2, $04
	saVol		$FA
	dc.b sHold, nFs2, $05, nRst, $06, nEb2, $08, nRst, $06
	sVoice		$0E
	saVol		$04
	dc.b nF2, $03, nRst, $06
	saVol		$F2
	dc.b nF2, nRst, $08, nF2, $03, nRst
	saVol		$0E
	dc.b nF2
	saVol		$FA
	dc.b sHold, nF2, $06, nRst, $06, sHold, nF2, $03, nRst, $05, sHold, nF2
	dc.b $06, nRst, $09
	saVol		$F8
	dc.b nF2, $03, nRst, nF2, $08, nRst, $06
	saVol		$0E
	dc.b nEb2, $03
	saVol		$FA
	dc.b sHold, nEb2, $05, nRst, $07, nFs2, $08, nRst, $06, nF2, $03, nRst
	dc.b $05, nF2, $07, nRst, $08, nF2, $03, nRst, nF2, $08, nRst, $07
	dc.b nF2, $03, nRst, $05, nF2, $06, nRst, $08, nF2, $03, nRst, $04
	dc.b nF2, $08
	sVoice		$10
	saVol		$02
	dc.b nRst, $06, nFs2, $08, nRst, $07, nEb2, $08, nRst, $04

	; NAT: set release rate to immediate
	sCmdYM		$80, $0F
	sCmdYM		$88, $0F
	sCmdYM		$84, $0F
	sCmdYM		$8C, $0F
	dc.b sHold, $02
	sJump		Snd_UGT_FM1

; FM2 Data
Snd_UGT_FM2:
	sPan		spCenter, $00
	dc.b nRst, $08
	sVoice		$00
	ssVol		$06
	sPan		spLeft, $00
	dc.b nF2, $03, nRst, nF2, $08, nRst, $06
	saVol		$0F
	dc.b nF2, $04, nRst, $05
	saVol		$F1
	dc.b nF2, $06, nRst, $08, nF2, $03, nRst
	saVol		$0F
	dc.b nF2, $04
	saVol		$F9
	dc.b sHold, nF2, $05, nRst, $06, sHold, nF2, $03, nRst, $05, sHold, nF2
	dc.b $06, nRst, $09
	saVol		$F8
	dc.b nEb2, $06, nRst, $08, nFs2, $06, nRst, $03
	saVol		$08
	dc.b sHold, nRst, $06
	saVol		$F8
	dc.b nF2, $03, nRst, nF2, $08, nRst, $06
	saVol		$0F
	dc.b nF2, $03, nRst, $06
	saVol		$F1
	dc.b nF2, nRst, $08, nF2, $03, nRst
	saVol		$0F
	dc.b nF2
	saVol		$F9
	dc.b sHold, nF2, $05, nRst, $07, sHold, nF2, $03, nRst, $05, sHold, nF2
	dc.b $06, nRst, $08
	saVol		$F8
	dc.b nFs2, $07, nRst, $08, nEb2, $06, nRst, $03
	saVol		$08
	dc.b sHold, nRst, $05
	sVoice		$0E
	saVol		$FC
	dc.b nF2, $03, nRst, $04, nF2, $08, nRst, $06
	saVol		$0E
	dc.b nF2, $03, nRst, $05
	saVol		$F2
	dc.b nF2, $07, nRst, $08, nF2, $03, nRst
	saVol		$0E
	dc.b nF2
	saVol		$FA
	dc.b sHold, nF2, $05, nRst, $07, sHold, nF2, $03, nRst, $05, sHold, nF2
	dc.b $06, nRst, $08
	saVol		$F8
	dc.b nEb2, $06, nRst, $09, nFs2, $06, nRst, $03
	saVol		$08
	dc.b sHold, nRst, $05
	saVol		$F8
	dc.b nF2, $03, nRst, nF2, $09, nRst, $06
	saVol		$0E
	dc.b nF2, $03, nRst, $05
	saVol		$F2
	dc.b nF2, $06, nRst, $09, nF2, $03, nRst
	saVol		$0E
	dc.b nF2
	saVol		$FA
	dc.b sHold, nF2, $05, nRst, $06, sHold, nF2, $03, nRst, $06, sHold, nF2
	dc.b $06, nRst, $08
	saVol		$F8
	dc.b nFs2, $06, nRst, $09, nEb2, $06
	saVol		$0E
	dc.b sHold, nEb2, $03
	saVol		$FA
	dc.b sHold, nEb2, $05
	sVoice		$0F
	saVol		$FA
	dc.b nF2, $03, nRst, nF2, $08, nRst, $07
	saVol		$0E
	dc.b nF2, $03, nRst, $05
	saVol		$F2
	dc.b nF2, $06, nRst, $08, nF2, $04, nRst, $03
	saVol		$0E
	dc.b nF2
	saVol		$FA
	dc.b sHold, nF2, $05, nRst, $06, sHold, nF2, $03, nRst, $05, sHold, nF2
	dc.b $07, nRst, $08
	saVol		$F8
	dc.b nEb2, $06, nRst, $08, nFs2, $07, nRst, $03
	saVol		$08
	dc.b sHold, nRst, $05
	saVol		$F8
	dc.b nF2, $03, nRst, nF2, $08, nRst, $07
	saVol		$0E
	dc.b nF2, $03, nRst, $05
	saVol		$F2
	dc.b nF2, $06, nRst, $08, nF2, $03, nRst
	saVol		$0E
	dc.b nF2, $04
	saVol		$FA
	dc.b sHold, nF2, $05, nRst, $06, sHold, nF2, $03, nRst, $05, sHold, nF2
	dc.b $06, nRst, $09
	saVol		$F8
	dc.b nFs2, $06, nRst, $08, nEb2, $06, nRst, $03
	saVol		$08
	dc.b sHold, nRst, $06
	sVoice		$0E
	saVol		$F6
	dc.b nF2, $03, nRst, nF2, $08, nRst, $06
	saVol		$0E
	dc.b nF2, $03, nRst, $06
	saVol		$F2
	dc.b nF2, nRst, $08, nF2, $03, nRst
	saVol		$0E
	dc.b nF2
	saVol		$FA
	dc.b sHold, nF2, $06, nRst, $06, sHold, nF2, $03, nRst, $05, sHold, nF2
	dc.b $06, nRst, $08
	saVol		$F8
	dc.b nEb2, $07, nRst, $08, nFs2, $06, nRst, $08, nF2, $04, nRst, $03
	dc.b nF2, $08, nRst, $06, nF2, $03, nRst, $05, nF2, $07, nRst, $08
	dc.b nF2, $03, nRst, nF2, $08, nRst, $07, nF2, $03, nRst, $05, nF2
	dc.b $06
	sVoice		$10
	saVol		$02
	dc.b nRst, $08, nFs2, $07, nRst, $08, nEb2, $04

	; NAT: set release rate to immediate
	sCmdYM		$80, $0F
	sCmdYM		$88, $0F
	sCmdYM		$84, $0F
	sCmdYM		$8C, $0F
	dc.b sHold, $02
	sJump		Snd_UGT_FM2

; FM3 Data
Snd_UGT_FM3:
	sVoice		$01
	sPan		spRight, $00
	ssVol		$00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, $02, sHold
	ssDetune	$0B
	dc.b nEb2, $01, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, $02, sHold
	ssDetune	$F2
	dc.b nD2, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $03, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nFs1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, sHold
	ssDetune	$00
	dc.b nBb1, $01, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, $02, sHold, nA1, $01
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $07
	sVoice		$04
	dc.b nA3, $03
	sVoice		$06
	dc.b sHold, nA3, $05
	sVoice		$03
	saVol		$FB
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2
	sVoice		$09
	sPan		spLeft, $00
	ssDetune	$00
	dc.b nF3, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, $02, sHold
	ssDetune	$00
	dc.b nAb1, $01, sHold
	ssDetune	$0B
	dc.b nEb1, $03, sHold
	ssDetune	$00
	dc.b nAb0, $01
	sVoice		$08
	saVol		$0E
	dc.b nE0, $03
	sVoice		$0B
	saVol		$F2
	dc.b nB4, $08
	sVoice		$03
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $07
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $07
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $07
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $09
	saVol		$FD
	dc.b nFs1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $09
	saVol		$FD
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $09
	saVol		$FD
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $09
	saVol		$FD
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $09
	saVol		$FD
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nF1, $07
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nF1, $07
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nF1, $07
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nFs1, $07
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nF1, $07
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, $02, sHold
	ssDetune	$0B
	dc.b nEb2, $01, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	sVoice		$04
	dc.b nA3, $03
	sVoice		$06
	dc.b sHold, nA3, $05
	sVoice		$03
	saVol		$FB
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, $02
	sVoice		$09
	sPan		spLeft, $00
	ssDetune	$00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, $02, sHold
	ssDetune	$00
	dc.b nAb1, $01, sHold
	ssDetune	$0B
	dc.b nEb1, $02, sHold
	ssDetune	$00
	dc.b nAb0, $01
	sVoice		$08
	saVol		$0E
	dc.b nE0, $03
	sVoice		$0B
	saVol		$F2
	dc.b nB4, $08
	sVoice		$03
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $03, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, sHold
	ssDetune	$00
	dc.b nBb1, $01, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, $02, sHold, nA1, $01
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $06
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $07
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nFs1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $07
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $07
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $07
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nF1, $06
	sVoice		$01
	sPan		spRight, $00
	dc.b nF3, $01, sHold, nAb2, sHold
	ssDetune	$0B
	dc.b nEb2, sHold
	ssDetune	$F2
	dc.b nD2, $02, sHold
	ssDetune	$04
	dc.b nB1, $01, sHold
	ssDetune	$00
	dc.b nBb1, sHold, nA1
	sVoice		$03
	saVol		$05
	sPan		spLeft, $00
	dc.b nF1, $07
	saVol		$FE
	sPan		spCenter, $00
	dc.b nF1, $08
	saVol		$FD
	dc.b nF1, $06
	sJump		Snd_UGT_FM3

Snd_UGT_FM6:
	sPan		spCentre, $00
	dc.b nRst, $06
	sVoice		$02
	saVol		$08
	sJump		Snd_UGT_FM46

; FM4 Data
Snd_UGT_FM4:
	sPan		spRight, $00
	sVoice		$02

Snd_UGT_FM46:
	dc.b nF1, $19, nRst, $03, nF1, $1A, nRst, $03, nF1, $1A, nRst, $03
	dc.b nF1, $1A, nRst, $03, nF1, $1A, nRst, $03, nF1, $1A, nRst, $03
	dc.b nF1, $1A, nRst, $03, nF1, $1A, nRst, $03, nF1, $1A, nRst, $03
	dc.b nF1, $1A, nRst, $03, nF1, $1A, nRst, $03, nF1, $1A, nRst, $03
	dc.b nF1, $1A, nRst, $03, nF1, $1A, nRst, $03, nF1, $1A, nRst, $03
	dc.b nF1, $1A, nRst, $03, nF1, $1A, nRst, $03, nF1, $1A, nRst, $03
	dc.b nF1, $19, nRst, $04, nF1, $19, nRst, $04, nF1, $19, nRst, $04
	dc.b nF1, $19, nRst, $03, nF1, $1A, nRst, $03, nF1, $1A, nRst, $03
	dc.b nF1, $1A, nRst, $03, nF1, $1A, nRst, $03, nF1, $1A, nRst, $03
	dc.b nF1, $1A, nRst, $03, nF1, $1A, nRst, $03, nF1, $1A, nRst, $03
	dc.b nF1, $1A, nRst, $03, nF1, $1A, nRst, $03
	sJump		Snd_UGT_FM46

; FM5 Data
Snd_UGT_FM5:
	sPan		spCenter, $00
	dc.b nRst, $7F, $3D
	sVoice		$05
	ssVol		$05
	sPan		spRight, $00
	dc.b nA3, $03
	sVoice		$07
	dc.b sHold, nA3, $0B
	sVoice		$08
	saVol		$0D
	dc.b nD0, $03
	sVoice		$0A
	saVol		$F3
	dc.b nF3, $09
	sVoice		$08
	saVol		$0D
	dc.b nE0, $03
	sVoice		$0C
	saVol		$F3
	dc.b nB4, $08
	sVoice		$0D
	saVol		$0A
	dc.b nG4, $7F, sHold, $7F, sHold, $7F, sHold, $2D
	sVoice		$05
	saVol		$F6
	dc.b nA3, $03
	sVoice		$07
	dc.b sHold, nA3, $0B
	sVoice		$08
	saVol		$0D
	dc.b nD0, $04
	sVoice		$0A
	saVol		$F3
	dc.b nF3, $08
	sVoice		$08
	saVol		$0D
	dc.b nE0, $03
	sVoice		$0C
	saVol		$F3
	dc.b nB4, $08
	sVoice		$0D
	saVol		$0A
	dc.b nG4, $7F, sHold, $6F
	sJump		Snd_UGT_FM5

; DAC Data
Snd_UGT_DAC2:
	ssDetune	-$34
	dc.b dKick, $1C, $1D, $1D, $1D, $1D, $1D, $1D
	dc.b $1D, $1D, $1D, $1D, $1D, $1D, $1D
	dc.b $1D, $1D, $1D, $1D, nRst, $1D, $1D
	dc.b dKick, $1D, $1C, $1D, $1D, $1D, $1D
	dc.b $1D, $1D, $1D, $1D, $1D, $1D
	sJump		Snd_UGT_DAC2

Snd_UGT_DAC1:
	dc.b nRst, $1C

.loop
	dc.b dClap, $3A, $3A, $3A, $1D

	sVoice		dClap
	sModePitchDAC
	ssMod68k	$01, $01, -$20, $06

	dc.b nA4, $1D, $1D, $1D, $1D
	dc.b nG4, $0E, nA4, $1D
	dc.b $0F, $1D
	dc.b nAb4, $0E, nA4, $1D
	dc.b $07, $0F
	dc.b $07, $0F
	sModOff
	sModeSampDAC

	dc.b nRst, $7F, $4A
	dc.b dClap, $3A, $3A, $3A, $3A
	sJump		.loop
	sStop
