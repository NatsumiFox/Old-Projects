soundAC_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, soundAC_FM5, $00, $00

soundAC_FM5:
	sPatFM		$06
	ssMod68k	$01, $01, $0C, $01

soundAC_Loop1:
	dc.b nC0, $0A
	saVolFM		$10
	sLoop		$00, $04, soundAC_Loop1
	sStop
