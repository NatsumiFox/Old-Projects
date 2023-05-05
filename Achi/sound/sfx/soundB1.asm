soundB1_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, soundB1_FM5, $17, $04

soundB1_FM5:
	sPatFM		$28
	ssMod68k	$01, $01, $0C, $01
	dc.b nC0, $08
	saVolFM		$10
	dc.b nE0
	sStop
