sfx6f_Header:
	sHeaderInit	; Z80 offset is $E886
	sHeaderPatch	sfx6f_Patches
	sHeaderTick	$01
	sHeaderCh	$02
	sHeaderSFX	$80, $02, sfx6f_FM3, $00, $06
	sHeaderSFX	$80, $04, sfx6f_FM4, $00, $06
