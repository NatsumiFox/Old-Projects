sfx6c_Header:
	sHeaderInit	; Z80 offset is $E823
	sHeaderPatch	sfx6c_Patches
	sHeaderTick	$01
	sHeaderCh	$02
	sHeaderSFX	$80, $C0, sfx6c_PSG3, $0C, $03
	sHeaderSFX	$80, $05, sfx6c_FM5, $00, $06
