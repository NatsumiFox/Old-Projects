Flicky_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$02
	sHeaderSFX	$80, $04, Flicky_FM4, $00, $09
	sHeaderSFX	$80, $05, Flicky_FM5, $00, $09

Flicky_FM4:
	sPatFM		$25
	dc.b nG5, $06, nF5, nE5, nC6, $0C
	sStop

Flicky_FM5:
	sPatFM		$25
	dc.b nE5, $06, nD5, nC5, nG6, $0C
	sStop
