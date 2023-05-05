soundCE_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $04, soundCE_FM4, $00, $05

soundCE_FM4:
	sPan		spLeft, $00
	sJump		soundB5_Com
