sfxc8_Header:
	sHeaderInit	; Z80 offset is $FA21
	sHeaderPatch	sfxc8_Patches
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $02, sfxc8_FM3, $0A, $18
