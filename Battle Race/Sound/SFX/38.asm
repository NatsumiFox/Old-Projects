sfx38_Header:
	sHeaderInit	; Z80 offset is $DEF4
	sHeaderPatch	sfx38_Patches
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, sfx38_FM5, $0E, $00

sfx38_FM5:
	sPatFM		$00
	ssModZ80	$01, $01, $21, $6E
	dc.b nCs3, $07, nRst, $06
	ssModZ80	$01, $01, $44, $1E
	dc.b nAb3, $08
	sStop	

sfx38_Patches:
	; Patch $00
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
