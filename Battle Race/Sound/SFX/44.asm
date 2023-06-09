sfx44_Header:
	sHeaderInit	; Z80 offset is $E122
	sHeaderPatch	sfx44_Patches
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, sfx44_FM5, $EE, $00

sfx44_FM5:
	sPatFM		$00
	ssModZ80	$03, $01, $32, $2B
	dc.b nB2, $20
	sStop	

sfx44_Patches:
	; Patch $00
	; $04
	; $02, $01, $22, $21,	$1F, $1F, $1F, $1F
	; $0B, $00, $0B, $00,	$00, $0E, $00, $0E
	; $FF, $0F, $FF, $0F,	$14, $80, $14, $80
	spAlgorithm	$04
	spFeedback	$00
	spDetune	$00, $02, $00, $02
	spMultiple	$02, $02, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0B, $0B, $00, $00
	spSustainRt	$00, $00, $0E, $0E
	spSustainLv	$0F, $0F, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$14, $14, $00, $00
