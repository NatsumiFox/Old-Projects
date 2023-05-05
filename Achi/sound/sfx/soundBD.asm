soundBD_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$02
	sHeaderSFX	$80, $05, soundBD_FM5, $10, $0A
	sHeaderSFX	$80, $04, soundBD_FM4, $00, $00

soundBD_FM5:
	sPatFM		$14
	ssMod68k	$01, $01, $60, $01
	dc.b nD3, $08
	sStop

soundBD_FM4:
	dc.b nRst, $08
	sPatFM		$15
	dc.b nEb0, $22
	sStop
