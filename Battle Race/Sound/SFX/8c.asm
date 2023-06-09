sfx8c_Header:
	sHeaderInit	; Z80 offset is $EDDF
	sHeaderPatch	sfx8c_Patches
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, sfx8c_FM5, $EC, $07

sfx8c_FM5:
	sPatFM		$00
	ssModZ80	$02, $01, $6B, $D5
	dc.b nB3, $06
	saVolFM		$0A
	dc.b nF4, $0B
	sStop	

sfx8c_Patches:
	; Patch $00
	; $3B
	; $0F, $0F, $10, $01,	$14, $1F, $0E, $14
	; $0C, $04, $01, $04,	$02, $02, $02, $03
	; $DF, $2F, $2F, $2F,	$22, $24, $13, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$00, $01, $00, $00
	spMultiple	$0F, $00, $0F, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$14, $0E, $1F, $14
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0C, $01, $04, $04
	spSustainRt	$02, $02, $02, $03
	spSustainLv	$0D, $02, $02, $02
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$22, $13, $24, $00
