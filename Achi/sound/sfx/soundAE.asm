	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, ctFM5, @fm5, $F3, $00

@fm5	sVoice		$26
	dc.b nCs1, $05, nEb1
	sStop
