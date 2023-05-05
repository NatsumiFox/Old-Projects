soundD0_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $04, soundD0_FM4, $00, $10

soundD0_FM4:
	sPatFM		$24
	dc.b nG6, $02

soundD0_Loop1:
	dc.b sHold, $01
	sLoop		$00, $40, soundD0_Loop1

soundD0_Loop2:
	dc.b sHold, $01
	saVolFM		$01
	sLoop		$00, $22, soundD0_Loop2
	dc.b nRst, $01
	sStop
