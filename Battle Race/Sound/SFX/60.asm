sfx60_Header:
	sHeaderInit	; Z80 offset is $E5DA
	sHeaderPatch	sfx60_Patches
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, sfx60_FM5, $E7, $00

sfx60_FM5:
	sPatFM		$00

sfx60_Loop1:
	dc.b nC6, $01
	saTranspose	$FF
	saVolFM		$01
	sLoop		$00, $06, sfx60_Loop1
	ssModZ80	$01, $01, $03, $00
	dc.b nC6, $50

sfx60_Loop2:
	dc.b sHold, $04
	saVolFM		$01
	sLoop		$00, $08, sfx60_Loop2
	sStop	

sfx60_Patches:
	; Patch $00
	; $3A
	; $41, $12, $62, $52,	$5F, $1F, $1F, $8C
	; $08, $05, $04, $1E,	$03, $04, $02, $06
	; $2F, $2F, $1F, $0F,	$29, $27, $1F, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$04, $06, $01, $05
	spMultiple	$01, $02, $02, $02
	spRateScale	$01, $00, $00, $02
	spAttackRt	$1F, $1F, $1F, $0C
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$08, $04, $05, $1E
	spSustainRt	$03, $02, $04, $06
	spSustainLv	$02, $01, $02, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$29, $1F, $27, $00
