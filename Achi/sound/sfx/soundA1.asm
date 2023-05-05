soundA1_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, soundA1_FM5, $00, $01

soundA1_FM5:
	sPatFM		$00
	dc.b nC5, $06, nA4, $16
	sStop
