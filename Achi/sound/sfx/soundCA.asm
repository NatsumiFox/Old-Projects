soundCA_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, soundCA_FM5, $00, $02

soundCA_FM5:
	sPatFM		$21
	ssMod68k	$01, $01, $5B, $02
	dc.b nEb6, $65
	sStop
