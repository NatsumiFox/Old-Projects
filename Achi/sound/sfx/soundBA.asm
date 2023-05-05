soundBA_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, ctFM5, .FM5, $11, $00

.FM5	sPatFM		$2B
	dc.b nBb5, $02
	sStop
