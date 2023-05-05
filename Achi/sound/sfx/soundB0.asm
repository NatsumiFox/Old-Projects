	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, ctFM5, .FM5, $00, $00

.FM5	sPatFM		$27
	dc.b nC0, $25
	sStop
