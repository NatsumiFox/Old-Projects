sfxcd_Header:
	sHeaderInit	; Z80 offset is $FB12
	sHeaderPatch	sfxcd_Patches
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $02, sfxcd_FM3, $00, $05

sfxcd_FM3:
sfxcd_Loopsfx1:
	sPatFM		$00
	ssModZ80	$01, $01, $C1, $8E
	dc.b nC0, $04, $04, $04, $04
	sLoopSFX	sfxcd_Loopsfx1
	sStop	

sfxcd_Patches:
	; Patch $00
	; $F9
	; $22, $30, $20, $30,	$10, $09, $1F, $1F
	; $00, $18, $09, $02,	$0C, $1F, $10, $05
	; $0F, $2F, $4F, $2F,	$11, $07, $04, $80
	spAlgorithm	$01
	spFeedback	$07
	spDetune	$02, $02, $03, $03
	spMultiple	$02, $00, $00, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$10, $1F, $09, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $09, $18, $02
	spSustainRt	$0C, $10, $1F, $05
	spSustainLv	$00, $04, $02, $02
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$11, $04, $07, $00
