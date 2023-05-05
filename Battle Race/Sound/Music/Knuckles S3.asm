KnucklesS3_Header:
	sHeaderInit	; Z80 offset is $97FD
	sHeaderPatch	KnucklesS3_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $43
	sHeaderDAC	KnucklesS3_DAC
	sHeaderFM	KnucklesS3_FM1, $C2, $03
	sHeaderFM	KnucklesS3_FM2, $E0, $18
	sHeaderFM	KnucklesS3_FM3, $0C, $10
	sHeaderFM	KnucklesS3_FM3, $00, $14
	sHeaderFM	KnucklesS3_FM3, $00, $14
	sHeaderPSG	KnucklesS3_PSG1, $03, $01, $00, VolEnv_00
	sHeaderPSG	KnucklesS3_PSG1, $00, $01, $00, VolEnv_00
	sHeaderPSG	KnucklesS3_PSG1, $00, $00, $00, VolEnv_00

KnucklesS3_FM1:
KnucklesS3_Jump2:
	sPatFM		$01
	dc.b nC1, $08, $04, nRst, $07, nC1, $05
	sPatFM		$02
	dc.b nE3, $0C
	sPatFM		$01
	dc.b nC1, nRst, nC1
	sPatFM		$02
	dc.b nE3, $18
	sPatFM		$01
	dc.b nC1, $0C, nRst, $07, nC1, $05
	sPatFM		$02
	dc.b nE3, $0C
	sPatFM		$01
	dc.b nC1, nRst, $07, nRst, $05, nC1, $0C
	sPatFM		$02
	dc.b nE3, $13, nRst, $05
	sJump		KnucklesS3_Jump2

KnucklesS3_FM2:
KnucklesS3_Jump1:
	sPatFM		$00
	dc.b nC4, $07, $05, $07, nRst, $05, nRst, $07
	dc.b nC4, $05, $07, $05, nC4, $07, $05, $07
	dc.b $05, $07, $05, $07, $05
	sJump		KnucklesS3_Jump1

KnucklesS3_FM3:
KnucklesS3_PSG1:
	sStop

KnucklesS3_DAC:
KnucklesS3_Loop1:
	sCall		KnucklesS3_Call1
	sLoop		$00, $04, KnucklesS3_Loop1

KnucklesS3_Jump3:
	sCall		KnucklesS3_Call2

KnucklesS3_Loop2:
	sCall		KnucklesS3_Call1
	sLoop		$00, $03, KnucklesS3_Loop2
	sJump		KnucklesS3_Jump3

KnucklesS3_Call1:
	dc.b nRst, $0C, dLowerEchoedClapHit3, dEchoedClapHit3, $08, dLowerEchoedClapHit3, $04, $0C
	dc.b $0C, $08, $04, dEchoedClapHit3, $18, nRst, $0C, dLowerEchoedClapHit3
	dc.b dEchoedClapHit3, $08, dLowerEchoedClapHit3, $04, $0C, $14, $04, dEchoedClapHit3
	dc.b $18, nRst, $0C, dLowerEchoedClapHit3, dEchoedClapHit3, $08, dLowerEchoedClapHit3, $04
	dc.b $0C, $0C, $08, $04, dEchoedClapHit3, $18, nRst, $0C
	dc.b dLowerEchoedClapHit3, dEchoedClapHit3, $08, dLowerEchoedClapHit3, $04, $0C, $14, $04
	dc.b dEchoedClapHit3, $18
	sRet

KnucklesS3_Call2:
	dc.b dBassHey, $0C, dLowerEchoedClapHit3, dEchoedClapHit3, $08, dLowerEchoedClapHit3, $04, $0C
	dc.b $0C, $08, $04, dEchoedClapHit3, $18, nRst, $0C, dLowerEchoedClapHit3
	dc.b dEchoedClapHit3, $08, dLowerEchoedClapHit3, $04, $0C, $14, $04, dEchoedClapHit3
	dc.b $18, nRst, $0C, dLowerEchoedClapHit3, dEchoedClapHit3, $08, dLowerEchoedClapHit3, $04
	dc.b $0C, $0C, $08, $04, dEchoedClapHit3, $18, nRst, $0C
	dc.b dLowerEchoedClapHit3, dEchoedClapHit3, $08, dLowerEchoedClapHit3, $04, $0C, $14, $04
	dc.b dEchoedClapHit3, $18
	sRet

KnucklesS3_Patches:
	; Patch $00
	; $01
	; $02, $00, $00, $00,	$1F, $1F, $1F, $1F
	; $10, $18, $18, $10,	$0E, $00, $00, $08
	; $FF, $FF, $FF, $0F,	$12, $10, $10, $80
	spAlgorithm	$01
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$02, $00, $00, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0E, $00, $00, $08
	spSustainRt	$10, $18, $18, $10
	spSustainLv	$0F, $0F, $0F, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$12, $10, $10, $00

	; Patch $01
	; $05
	; $00, $00, $00, $00,	$1F, $1F, $1F, $1F
	; $12, $0C, $0C, $0C,	$12, $18, $1F, $1F
	; $1F, $1F, $1F, $1F,	$07, $86, $86, $86
	spAlgorithm	$05
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $00, $00, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$12, $1F, $18, $1F
	spSustainRt	$12, $0C, $0C, $0C
	spSustainLv	$01, $01, $01, $01
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$07, $06, $06, $06

	; Patch $02
	; $3C
	; $00, $00, $F0, $F1,	$1F, $1F, $17, $1F
	; $1F, $1F, $14, $1F,	$09, $11, $3A, $1D
	; $02, $0F, $9F, $7F,	$03, $80, $02, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$00, $0F, $00, $0F
	spMultiple	$00, $00, $00, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $17, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$09, $3A, $11, $1D
	spSustainRt	$1F, $14, $1F, $1F
	spSustainLv	$00, $09, $00, $07
	spReleaseRt	$02, $0F, $0F, $0F
	spTotalLv	$03, $02, $00, $00
