soundA6_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, soundA6_FM5, $F2, $00

soundA6_FM5:
	sPatFM		$03
	ssMod68k	$01, $01, $10, $FF
	dc.b nFs6, $05, nD7, $25
	sStop
