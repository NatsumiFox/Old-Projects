soundCC_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $04, soundCC_FM4, $00, $02

soundCC_FM4:
	sPatFM		$22
	dc.b nRst, $01
	ssMod68k	$03, $01, $5D, $0F
	dc.b nB3, $0C
	sModOff

soundCC_Loop1:
	dc.b sHold
	saVol		$02
	dc.b nC5, $02
	sLoop		$00, $19, soundCC_Loop1
	sStop
