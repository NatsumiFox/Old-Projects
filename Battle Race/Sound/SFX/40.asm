sfx40_Header:
	sHeaderInit	; Z80 offset is $E0AB
	sHeaderPatch	sfx40_Patches
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, sfx40_FM5, $FC, $04

sfx40_Patches:
	; Patch $00
	; $32
	; $05, $02, $13, $31,	$0B, $1C, $10, $0D
	; $00, $00, $04, $00,	$00, $00, $00, $0C
	; $0F, $0F, $1F, $0F,	$0B, $17, $0C, $80
	spAlgorithm	$02
	spFeedback	$06
	spDetune	$00, $01, $00, $03
	spMultiple	$05, $03, $02, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$0B, $10, $1C, $0D
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $04, $00, $00
	spSustainRt	$00, $00, $00, $0C
	spSustainLv	$00, $01, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0B, $0C, $17, $00
