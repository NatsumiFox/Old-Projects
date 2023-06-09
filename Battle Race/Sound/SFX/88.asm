sfx88_Header:
	sHeaderInit	; Z80 offset is $ED3B
	sHeaderPatch	sfx88_Patches
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, sfx88_FM5, $05, $0C

sfx88_FM5:
	sPatFM		$00
	ssModZ80	$01, $01, $02, $76
	dc.b nAb2, $11
	sStop	

sfx88_Patches:
	; Patch $00
	; $FA
	; $3F, $A0, $FF, $9F,	$1F, $18, $0B, $11
	; $08, $1F, $08, $02,	$0B, $1F, $11, $05
	; $2C, $FE, $4F, $2F,	$18, $02, $04, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$03, $0F, $0A, $09
	spMultiple	$0F, $0F, $00, $0F
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $0B, $18, $11
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$08, $08, $1F, $02
	spSustainRt	$0B, $11, $1F, $05
	spSustainLv	$02, $04, $0F, $02
	spReleaseRt	$0C, $0F, $0E, $0F
	spTotalLv	$18, $04, $02, $00
