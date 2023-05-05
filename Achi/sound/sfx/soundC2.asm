soundC2_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, soundC2_FM5, $0C, $08

soundC2_FM5:
	sPatFM		$17
	dc.b nA4, $08, nA4, $25
	sStop
