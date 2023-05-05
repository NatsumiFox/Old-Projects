soundC0_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, soundC0_FM5, $00, $03

soundC0_FM5:
	sPatFM		$18
	dc.b nG1, $05, nRst, $05, nG1, $04, nRst, $04
	sStop
