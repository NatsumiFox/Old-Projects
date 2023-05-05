	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, ctDAC1, @dac1, $00, $00

@dac1	dc.b dLife, $30
	sStop
