	nolist				; do not list this voice bank, it'd be huge!
VoiceBank:
sPatNum = 0
	spSSGEG		$00, $00, $00, $00

	; Patch $00
	; $3C
	; $05, $01, $0A, $01,	$56, $5C, $5C, $5C
	; $0E, $11, $11, $11,	$09, $0A, $06, $0A
	; $4F, $3F, $3F, $3F,	$17, $80, $20, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$05, $0A, $01, $01
	spRateScale	$01, $01, $01, $01
	spAttackRt	$16, $1C, $1C, $1C
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0E, $11, $11, $11
	spSustainRt	$09, $06, $0A, $0A
	spSustainLv	$04, $03, $03, $03
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$17, $20, $00, $00

	; Patch $01
	; $30
	; $30, $30, $30, $30,	$9E, $D8, $DC, $DC
	; $0E, $0A, $04, $05,	$08, $08, $08, $08
	; $BF, $BF, $BF, $BF,	$14, $3C, $14, $80
	spAlgorithm	$00
	spFeedback	$06
	spDetune	$03, $03, $03, $03
	spMultiple	$00, $00, $00, $00
	spRateScale	$02, $03, $03, $03
	spAttackRt	$1E, $1C, $18, $1C
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0E, $04, $0A, $05
	spSustainRt	$08, $08, $08, $08
	spSustainLv	$0B, $0B, $0B, $0B
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$14, $14, $3C, $00

	; Patch $02
	; $FA
	; $21, $30, $10, $32,	$2F, $1F, $2F, $2F
	; $05, $08, $09, $02,	$06, $0F, $06, $02
	; $1F, $2F, $4F, $2F,	$0F, $1A, $0E, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$02, $01, $03, $03
	spMultiple	$01, $00, $00, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$0F, $0F, $1F, $0F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$05, $09, $08, $02
	spSustainRt	$06, $06, $0F, $02
	spSustainLv	$01, $04, $02, $02
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0F, $0E, $1A, $00

	; Patch $03
	; $3B
	; $3C, $39, $30, $31,	$DF, $1F, $1F, $DF
	; $04, $05, $04, $01,	$04, $04, $04, $02
	; $FF, $0F, $1F, $AF,	$29, $20, $0F, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$03, $03, $03, $03
	spMultiple	$0C, $00, $09, $01
	spRateScale	$03, $00, $00, $03
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$04, $04, $05, $01
	spSustainRt	$04, $04, $04, $02
	spSustainLv	$0F, $01, $00, $0A
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$29, $0F, $20, $00

	; Patch $04
	; $FA
	; $21, $30, $10, $32,	$1F, $1F, $1F, $1F
	; $05, $18, $09, $02,	$06, $0F, $06, $02
	; $1F, $2F, $4F, $2F,	$0F, $0E, $0E, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$02, $01, $03, $03
	spMultiple	$01, $00, $00, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$05, $09, $18, $02
	spSustainRt	$06, $06, $0F, $02
	spSustainLv	$01, $04, $02, $02
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0F, $0E, $0E, $00

	; Patch $05
	; $00
	; $00, $03, $02, $00,	$D9, $DF, $1F, $1F
	; $12, $11, $14, $0F,	$0A, $00, $0A, $0D
	; $FF, $FF, $FF, $FF,	$22, $07, $27, $80
	spAlgorithm	$00
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $02, $03, $00
	spRateScale	$03, $00, $03, $00
	spAttackRt	$19, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$12, $14, $11, $0F
	spSustainRt	$0A, $0A, $00, $0D
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$22, $27, $07, $00

	; Patch $06
	; $F9
	; $21, $30, $10, $32,	$1F, $1F, $1F, $1F
	; $05, $18, $09, $02,	$0B, $1F, $10, $05
	; $1F, $2F, $4F, $2F,	$0E, $07, $04, $80
	spAlgorithm	$01
	spFeedback	$07
	spDetune	$02, $01, $03, $03
	spMultiple	$01, $00, $00, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$05, $09, $18, $02
	spSustainRt	$0B, $10, $1F, $05
	spSustainLv	$01, $04, $02, $02
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0E, $04, $07, $00

	; Patch $07
	; $35
	; $05, $09, $08, $07,	$1E, $0D, $0D, $0E
	; $0C, $15, $03, $06,	$16, $0E, $09, $10
	; $2F, $2F, $1F, $1F,	$15, $12, $12, $80
	spAlgorithm	$05
	spFeedback	$06
	spDetune	$00, $00, $00, $00
	spMultiple	$05, $08, $09, $07
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1E, $0D, $0D, $0E
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0C, $03, $15, $06
	spSustainRt	$16, $09, $0E, $10
	spSustainLv	$02, $01, $02, $01
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$15, $12, $12, $00

	; Patch $08
	; $FA
	; $02, $03, $00, $05,	$12, $11, $0F, $13
	; $05, $18, $09, $02,	$06, $0F, $06, $02
	; $1F, $2F, $4F, $2F,	$2F, $1A, $0E, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$02, $00, $03, $05
	spRateScale	$00, $00, $00, $00
	spAttackRt	$12, $0F, $11, $13
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$05, $09, $18, $02
	spSustainRt	$06, $06, $0F, $02
	spSustainLv	$01, $04, $02, $02
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$2F, $0E, $1A, $00

	; Patch $09
	; $30
	; $30, $30, $30, $30,	$9E, $A8, $AC, $DC
	; $0E, $0A, $04, $05,	$08, $08, $08, $08
	; $BF, $BF, $BF, $BF,	$04, $2C, $14, $80
	spAlgorithm	$00
	spFeedback	$06
	spDetune	$03, $03, $03, $03
	spMultiple	$00, $00, $00, $00
	spRateScale	$02, $02, $02, $03
	spAttackRt	$1E, $0C, $08, $1C
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0E, $04, $0A, $05
	spSustainRt	$08, $08, $08, $08
	spSustainLv	$0B, $0B, $0B, $0B
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$04, $14, $2C, $00

	; Patch $0A
	; $83
	; $1F, $15, $1F, $1F,	$1F, $1F, $1F, $1F
	; $00, $00, $00, $00,	$02, $02, $02, $02
	; $2F, $2F, $FF, $3F,	$0B, $16, $01, $82
	spAlgorithm	$03
	spFeedback	$00
	spDetune	$01, $01, $01, $01
	spMultiple	$0F, $0F, $05, $0F
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$02, $02, $02, $02
	spSustainLv	$02, $0F, $02, $03
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0B, $01, $16, $02

	; Patch $0B
	; $83
	; $12, $10, $13, $1E,	$1F, $1F, $1F, $1F
	; $00, $00, $00, $00,	$02, $02, $02, $02
	; $2F, $2F, $FF, $3F,	$05, $10, $34, $87
	spAlgorithm	$03
	spFeedback	$00
	spDetune	$01, $01, $01, $01
	spMultiple	$02, $03, $00, $0E
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$02, $02, $02, $02
	spSustainLv	$02, $0F, $02, $03
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$05, $34, $10, $07

	; Patch $0C
	; $35
	; $14, $1A, $04, $09,	$0E, $10, $11, $0E
	; $0C, $15, $03, $06,	$16, $0E, $09, $10
	; $2F, $2F, $4F, $4F,	$2F, $12, $12, $80
	spAlgorithm	$05
	spFeedback	$06
	spDetune	$01, $00, $01, $00
	spMultiple	$04, $04, $0A, $09
	spRateScale	$00, $00, $00, $00
	spAttackRt	$0E, $11, $10, $0E
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0C, $03, $15, $06
	spSustainRt	$16, $09, $0E, $10
	spSustainLv	$02, $04, $02, $04
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$2F, $12, $12, $00

	; Patch $0D
	; $3C
	; $05, $01, $0A, $01,	$56, $5C, $5C, $5C
	; $0E, $11, $11, $11,	$09, $0A, $06, $0A
	; $4F, $3F, $3F, $3F,	$1F, $80, $2B, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$05, $0A, $01, $01
	spRateScale	$01, $01, $01, $01
	spAttackRt	$16, $1C, $1C, $1C
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0E, $11, $11, $11
	spSustainRt	$09, $06, $0A, $0A
	spSustainLv	$04, $03, $03, $03
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1F, $2B, $00, $00

	; Patch $0E
	; $05
	; $00, $00, $00, $00,	$1F, $1F, $1F, $1F
	; $12, $0C, $0C, $0C,	$12, $08, $08, $08
	; $1F, $5F, $5F, $5F,	$07, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $00, $00, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$12, $0C, $0C, $0C
	spSustainRt	$12, $08, $08, $08
	spSustainLv	$01, $05, $05, $05
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$07, $00, $00, $00

	; Patch $0F
	; $04
	; $37, $72, $77, $49,	$1F, $1F, $1F, $1F
	; $07, $0A, $07, $0D,	$00, $0B, $00, $0B
	; $1F, $0F, $1F, $0F,	$23, $80, $23, $80
	spAlgorithm	$04
	spFeedback	$00
	spDetune	$03, $07, $07, $04
	spMultiple	$07, $07, $02, $09
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$07, $07, $0A, $0D
	spSustainRt	$00, $00, $0B, $0B
	spSustainLv	$01, $01, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$23, $23, $00, $00

	; Patch $10
	; $FA
	; $21, $30, $10, $32,	$1F, $1F, $1F, $1F
	; $05, $18, $09, $02,	$06, $0F, $06, $02
	; $1F, $2F, $4F, $2F,	$0F, $1A, $0E, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$02, $01, $03, $03
	spMultiple	$01, $00, $00, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$05, $09, $18, $02
	spSustainRt	$06, $06, $0F, $02
	spSustainLv	$01, $04, $02, $02
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0F, $0E, $1A, $00

	; Patch $11
	; $1C
	; $2E, $02, $0F, $02,	$1F, $1F, $1F, $1F
	; $18, $0F, $14, $0E,	$00, $00, $00, $00
	; $FF, $FF, $FF, $FF,	$20, $80, $1B, $80
	spAlgorithm	$04
	spFeedback	$03
	spDetune	$02, $00, $00, $00
	spMultiple	$0E, $0F, $02, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$18, $14, $0F, $0E
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$20, $1B, $00, $00

	; Patch $12
	; $3C
	; $00, $00, $00, $00,	$1F, $1F, $1F, $1F
	; $00, $16, $0F, $0F,	$00, $00, $00, $00
	; $0F, $AF, $FF, $FF,	$00, $80, $0A, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $00, $00, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $0F, $16, $0F
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$00, $0F, $0A, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$00, $0A, $00, $00

	; Patch $13
	; $FD
	; $09, $03, $00, $00,	$1F, $1F, $1F, $1F
	; $10, $0C, $0C, $0C,	$0B, $1F, $10, $05
	; $1F, $2F, $4F, $2F,	$09, $84, $92, $8E
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$09, $00, $03, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$10, $0C, $0C, $0C
	spSustainRt	$0B, $10, $1F, $05
	spSustainLv	$01, $04, $02, $02
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$09, $12, $04, $0E

	; Patch $14
	; $FA
	; $21, $3A, $19, $30,	$1F, $1F, $1F, $1F
	; $05, $18, $09, $02,	$0B, $1F, $10, $05
	; $1F, $2F, $4F, $2F,	$0E, $07, $04, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$02, $01, $03, $03
	spMultiple	$01, $09, $0A, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$05, $09, $18, $02
	spSustainRt	$0B, $10, $1F, $05
	spSustainLv	$01, $04, $02, $02
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0E, $04, $07, $00

	; Patch $15
	; $FA
	; $31, $30, $10, $32,	$1F, $1F, $1F, $1F
	; $05, $18, $05, $10,	$0B, $1F, $10, $10
	; $1F, $2F, $1F, $2F,	$0D, $00, $01, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$03, $01, $03, $03
	spMultiple	$01, $00, $00, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$05, $05, $18, $10
	spSustainRt	$0B, $10, $1F, $10
	spSustainLv	$01, $01, $02, $02
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0D, $01, $00, $00

	; Patch $16
	; $3C
	; $00, $44, $02, $02,	$1F, $1F, $1F, $15
	; $00, $1F, $00, $00,	$00, $00, $00, $00
	; $0F, $0F, $0F, $0F,	$0D, $00, $28, $00
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$00, $00, $04, $00
	spMultiple	$00, $02, $04, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $15
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $1F, $00
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0D, $28, $00, $00

	; Patch $17
	; $14
	; $25, $33, $36, $11,	$1F, $1F, $1F, $1F
	; $15, $18, $1C, $13,	$0B, $08, $0D, $09
	; $0F, $9F, $8F, $0F,	$24, $05, $0A, $80
	spAlgorithm	$04
	spFeedback	$02
	spDetune	$02, $03, $03, $01
	spMultiple	$05, $06, $03, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$15, $1C, $18, $13
	spSustainRt	$0B, $0D, $08, $09
	spSustainLv	$00, $08, $09, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$24, $0A, $05, $00

	; Patch $18
	; $38
	; $08, $08, $08, $08,	$1F, $1F, $1F, $0E
	; $00, $00, $00, $00,	$00, $00, $00, $00
	; $0F, $0F, $0F, $1F,	$00, $00, $00, $80
	spAlgorithm	$00
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$08, $08, $08, $08
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $0E
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$00, $00, $00, $01
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$00, $00, $00, $00

	; Patch $19
	; $3C
	; $0F, $01, $03, $01,	$1F, $1F, $1F, $1F
	; $19, $12, $19, $0E,	$05, $12, $00, $0F
	; $0F, $7F, $FF, $FF,	$00, $80, $00, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$0F, $03, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$19, $19, $12, $0E
	spSustainRt	$05, $00, $12, $0F
	spSustainLv	$00, $0F, $07, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$00, $00, $00, $00

	; Patch $1A
	; $30
	; $30, $5C, $34, $30,	$9E, $A8, $AC, $DC
	; $0E, $0A, $04, $05,	$08, $08, $08, $08
	; $BF, $BF, $BF, $BF,	$24, $1C, $04, $80
	spAlgorithm	$00
	spFeedback	$06
	spDetune	$03, $03, $05, $03
	spMultiple	$00, $04, $0C, $00
	spRateScale	$02, $02, $02, $03
	spAttackRt	$1E, $0C, $08, $1C
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0E, $04, $0A, $05
	spSustainRt	$08, $08, $08, $08
	spSustainLv	$0B, $0B, $0B, $0B
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$24, $04, $1C, $00

	; Patch $1B
	; $30
	; $30, $5C, $34, $30,	$9E, $A8, $AC, $DC
	; $0E, $0A, $04, $05,	$08, $08, $08, $08
	; $BF, $BF, $BF, $BF,	$24, $2C, $04, $80
	spAlgorithm	$00
	spFeedback	$06
	spDetune	$03, $03, $05, $03
	spMultiple	$00, $04, $0C, $00
	spRateScale	$02, $02, $02, $03
	spAttackRt	$1E, $0C, $08, $1C
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0E, $04, $0A, $05
	spSustainRt	$08, $08, $08, $08
	spSustainLv	$0B, $0B, $0B, $0B
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$24, $04, $2C, $00

	; Patch $1C
	; $04
	; $37, $72, $77, $49,	$1F, $1F, $1F, $1F
	; $07, $0A, $07, $0D,	$00, $0B, $00, $0B
	; $1F, $0F, $1F, $0F,	$13, $81, $13, $88
	spAlgorithm	$04
	spFeedback	$00
	spDetune	$03, $07, $07, $04
	spMultiple	$07, $07, $02, $09
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$07, $07, $0A, $0D
	spSustainRt	$00, $00, $0B, $0B
	spSustainLv	$01, $01, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$13, $13, $01, $08

	; Patch $1D
	; $FA
	; $21, $30, $10, $32,	$1F, $1F, $1F, $1F
	; $05, $18, $05, $10,	$0B, $1F, $10, $10
	; $1F, $2F, $4F, $2F,	$0D, $07, $04, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$02, $01, $03, $03
	spMultiple	$01, $00, $00, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$05, $05, $18, $10
	spSustainRt	$0B, $10, $1F, $10
	spSustainLv	$01, $04, $02, $02
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0D, $04, $07, $00

	; Patch $1E
	; $3B
	; $03, $02, $02, $06,	$18, $1A, $1A, $96
	; $17, $0E, $0A, $10,	$00, $00, $00, $00
	; $FF, $FF, $FF, $FF,	$00, $28, $39, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$03, $02, $02, $06
	spRateScale	$00, $00, $00, $02
	spAttackRt	$18, $1A, $1A, $16
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$17, $0A, $0E, $10
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$00, $39, $28, $00

	; Patch $1F
	; $28
	; $2F, $5F, $37, $2B,	$1F, $1F, $1F, $1F
	; $15, $15, $15, $13,	$13, $0C, $0D, $10
	; $2F, $2F, $3F, $2F,	$00, $10, $1F, $80
	spAlgorithm	$00
	spFeedback	$05
	spDetune	$02, $03, $05, $02
	spMultiple	$0F, $07, $0F, $0B
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$15, $15, $15, $13
	spSustainRt	$13, $0D, $0C, $10
	spSustainLv	$02, $03, $02, $02
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$00, $1F, $10, $00

	; Patch $20
	; $3B
	; $0A, $31, $05, $02,	$5F, $5F, $5F, $5F
	; $04, $14, $16, $0C,	$00, $04, $00, $00
	; $1F, $6F, $D8, $FF,	$03, $25, $00, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$00, $00, $03, $00
	spMultiple	$0A, $05, $01, $02
	spRateScale	$01, $01, $01, $01
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$04, $16, $14, $0C
	spSustainRt	$00, $00, $04, $00
	spSustainLv	$01, $0D, $06, $0F
	spReleaseRt	$0F, $08, $0F, $0F
	spTotalLv	$03, $00, $25, $00

	; Patch $21
	; $20
	; $36, $35, $30, $31,	$41, $49, $3B, $4B
	; $09, $06, $09, $08,	$01, $03, $02, $A9
	; $0F, $0F, $0F, $0F,	$29, $27, $23, $80
	spAlgorithm	$00
	spFeedback	$04
	spDetune	$03, $03, $03, $03
	spMultiple	$06, $00, $05, $01
	spRateScale	$01, $00, $01, $01
	spAttackRt	$01, $1B, $09, $0B
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$09, $09, $06, $08
	spSustainRt	$01, $02, $03, $A9
	spSustainLv	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$29, $23, $27, $00

	; Patch $22
	; $20
	; $36, $35, $30, $31,	$DF, $DF, $9F, $9F
	; $07, $06, $09, $06,	$07, $06, $06, $08
	; $2F, $1F, $1F, $FF,	$16, $30, $13, $80
	spAlgorithm	$00
	spFeedback	$04
	spDetune	$03, $03, $03, $03
	spMultiple	$06, $00, $05, $01
	spRateScale	$03, $02, $03, $02
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$07, $09, $06, $06
	spSustainRt	$07, $06, $06, $08
	spSustainLv	$02, $01, $01, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$16, $13, $30, $00

	; Patch $23
	; $F4
	; $06, $04, $0F, $0E,	$1F, $1F, $1F, $1F
	; $00, $00, $0B, $0B,	$00, $00, $05, $08
	; $0F, $0F, $FF, $FF,	$0C, $8B, $03, $80
	spAlgorithm	$04
	spFeedback	$06
	spDetune	$00, $00, $00, $00
	spMultiple	$06, $0F, $04, $0E
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $0B, $00, $0B
	spSustainRt	$00, $05, $00, $08
	spSustainLv	$00, $0F, $00, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0C, $03, $0B, $00

	; Patch $24
	; $38
	; $0F, $0F, $0F, $0F,	$1F, $1F, $1F, $0E
	; $00, $00, $00, $00,	$00, $00, $00, $00
	; $0F, $0F, $0F, $1F,	$00, $00, $00, $80
	spAlgorithm	$00
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$0F, $0F, $0F, $0F
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $0E
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$00, $00, $00, $01
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$00, $00, $00, $00

	; Patch $25	(Sonic3D SFX $06 FM $00)
	; $01
	; $04, $01, $02, $01,	$1E, $10, $10, $10
	; $0C, $05, $03, $11,	$00, $00, $09, $08
	; $2F, $2F, $1F, $FF,	$18, $10, $2D, $80
	spAlgorithm	$01
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$04, $02, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1E, $10, $10, $10
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0C, $03, $05, $11
	spSustainRt	$00, $09, $00, $08
	spSustainLv	$02, $01, $02, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$18, $2D, $10, $00

	; Patch $26	(Sonic3K SFX $5D FM $00)
	; $20
	; $00, $00, $00, $00,	$1F, $1F, $1F, $1F
	; $00, $11, $00, $00,	$00, $00, $00, $09
	; $0F, $FF, $FF, $0F,	$03, $10, $1A, $80
	spAlgorithm	$00
	spFeedback	$04
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $00, $00, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $11, $00
	spSustainRt	$00, $00, $00, $09
	spSustainLv	$00, $0F, $0F, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$03, $1A, $10, $00

	; Patch $27	(Sonic3K SFX $5F FM $00)
	; $20
	; $00, $01, $00, $00,	$1F, $1F, $1F, $1F
	; $00, $0C, $00, $00,	$00, $00, $00, $0C
	; $FF, $FF, $FF, $0F,	$04, $0A, $18, $80
	spAlgorithm	$00
	spFeedback	$04
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $00, $01, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $0C, $00
	spSustainRt	$00, $00, $00, $0C
	spSustainLv	$0F, $0F, $0F, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$04, $18, $0A, $00

	; Patch $28	(Sonic3K SFX $7B FM $00)
	; $F1
	; $23, $30, $11, $30,	$1F, $18, $1F, $1F
	; $05, $1F, $09, $01,	$0B, $12, $03, $03
	; $1F, $0F, $4F, $2F,	$6F, $31, $00, $80
	spAlgorithm	$01
	spFeedback	$06
	spDetune	$02, $01, $03, $03
	spMultiple	$03, $01, $00, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $18, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$05, $09, $1F, $01
	spSustainRt	$0B, $03, $12, $03
	spSustainLv	$01, $04, $00, $02
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$6F, $00, $31, $00

	; Patch $29	(Sonic3K SFX $A7 FM $00)
	; $07
	; $30, $70, $10, $20,	$17, $19, $14, $14
	; $00, $00, $00, $00,	$0C, $0C, $0C, $0C
	; $0F, $0F, $0F, $0F,	$80, $80, $80, $80
	spAlgorithm	$07
	spFeedback	$00
	spDetune	$03, $01, $07, $02
	spMultiple	$00, $00, $00, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$17, $14, $19, $14
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$0C, $0C, $0C, $0C
	spSustainLv	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$00, $00, $00, $00

	; Patch $2A	(Sonic3K SFX $4C FM $00)
	; $3C
	; $00, $0A, $00, $00,	$1F, $1F, $1F, $0F
	; $00, $16, $15, $0F,	$00, $00, $00, $00
	; $0F, $AF, $FF, $FF,	$00, $80, $04, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $00, $0A, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $0F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $15, $16, $0F
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$00, $0F, $0A, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$00, $04, $00, $00

	; Patch $2B	(Sonic3K SFX $55 FM $00)
	; $24
	; $2A, $05, $02, $01,	$1A, $10, $1F, $1F
	; $0F, $1F, $1F, $1F,	$0C, $11, $0D, $11
	; $0C, $09, $09, $0F,	$0E, $80, $04, $80
	spAlgorithm	$04
	spFeedback	$04
	spDetune	$02, $00, $00, $00
	spMultiple	$0A, $02, $05, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1A, $1F, $10, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0F, $1F, $1F, $1F
	spSustainRt	$0C, $0D, $11, $11
	spSustainLv	$00, $00, $00, $00
	spReleaseRt	$0C, $09, $09, $0F
	spTotalLv	$0E, $04, $00, $00

	; Patch $2C	(Sonic3K SFX $9F FM $00)
	; $7A
	; $1F, $1F, $04, $1F,	$10, $1F, $18, $10
	; $10, $16, $0C, $00,	$02, $02, $02, $02
	; $2F, $2F, $FF, $3F,	$42, $16, $11, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$01, $00, $01, $01
	spMultiple	$0F, $04, $0F, $0F
	spRateScale	$00, $00, $00, $00
	spAttackRt	$10, $18, $1F, $10
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$10, $0C, $16, $00
	spSustainRt	$02, $02, $02, $02
	spSustainLv	$02, $0F, $02, $03
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$42, $11, $16, $00

	list				; do not list this voice bank, it'd be huge!
