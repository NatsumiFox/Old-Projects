	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, ctFM5, .fm5, $17, $0C

.fm5	sPatFM		$29
	dc.b nB4, $48
	sStop
