soundA5_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, soundA5_FM5, $00, $00

soundA5_FM5:
	sPatFM		$02
	dc.b nRst, $01, nBb0, $0A, nRst, $02
	sStop
