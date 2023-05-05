soundA7_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $04, soundA7_FM4, $00, $06

soundA7_FM4:
	sPatFM		$04
	dc.b nD1, $07, nRst, $02, nD1, $06, nRst, $10
;	sClrPush
	sStop
