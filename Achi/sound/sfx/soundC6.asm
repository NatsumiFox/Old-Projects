soundC6_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$02
	sHeaderSFX	$80, $04, soundC6_FM4, $00, $05
	sHeaderSFX	$80, $05, soundC6_FM5, $00, $08

soundC6_FM4:
	sPatFM		$0F
	dc.b nA5, $02, $05, $05, $05, $05, $05, $05
	dc.b $3A
	sStop

soundC6_FM5:
	sPatFM		$0F
	dc.b nRst, $02, nG5, $02, $05, $15, $02, $05
	dc.b $32
	sStop
