sfxba_Header:
	sHeaderInit	; Z80 offset is $F794
	sHeaderPatch	sfxba_Patches
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $04, sfxba_FM4, $0A, $0B

sfxba_FM4:
	sPatFM		$00
	dc.b nE2, $06, $06, $06
	sStop	

sfxba_Patches:
	; Patch $00
	; $3C
	; $00, $01, $00, $01,	$1F, $0D, $12, $14
	; $10, $00, $1F, $00,	$09, $13, $0A, $12
	; $FF, $0F, $FF, $0F,	$00, $A0, $00, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $00, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $12, $0D, $14
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$10, $1F, $00, $00
	spSustainRt	$09, $0A, $13, $12
	spSustainLv	$0F, $0F, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$00, $00, $20, $00
