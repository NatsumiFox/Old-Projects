soundC4_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, soundC4_FM5, $00, $00

soundC4_FM5:
	sPatFM		$1D
	dc.b nA0, $22
	sStop
