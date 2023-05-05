soundC7_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, soundC7_FM5, $00, $00

soundC7_FM5:
	sPatFM		$1F
	dc.b nCs5, $05, nRst, $04, nCs5, $04, nRst, $04
	sStop
