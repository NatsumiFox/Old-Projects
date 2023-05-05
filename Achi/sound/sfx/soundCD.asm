soundCD_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $C0, soundCD_PSG3, $00, $00

soundCD_PSG3:
	dc.b nBb4, $02
	sStop
