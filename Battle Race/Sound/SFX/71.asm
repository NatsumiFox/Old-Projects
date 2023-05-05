sfx71_Header:
	sHeaderInit	; Z80 offset is $E8E0
	sHeaderPatch	sfx71_Patches
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, sfx71_FM5, $0C, $00
