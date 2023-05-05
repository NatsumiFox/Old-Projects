soundA8_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, ctbDAC, @dac1, $00, $00

@dac1	ssVol	-$40
	dc.b dLife, $0F
	sStop
