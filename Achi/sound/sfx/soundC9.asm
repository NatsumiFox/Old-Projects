soundC9_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, soundC9_FM5, $0E, $00

soundC9_FM5:
	sPatFM		$20
	ssMod68k	$01, $01, $33, $18
	dc.b nAb4, $1A
	sStop
