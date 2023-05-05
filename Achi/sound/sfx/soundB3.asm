soundB3_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, ctFM5, .FM5, $EE, $00

.FM5	sPatFM		$2A
	dc.b nB2, $06, nEb3
	sStop
