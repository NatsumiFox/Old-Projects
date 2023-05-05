soundB7_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, soundB7_FM5, $00, $00

soundB7_FM5:
	sPatFM		$10
	ssMod68k	$01, $01, $20, $08

soundB7_Loop1:
	dc.b nBb0, $0A
	sLoop		$00, $08, soundB7_Loop1

soundB7_Loop2:
	dc.b nBb0, $10
	saVolFM		$03
	sLoop		$00, $09, soundB7_Loop2
	sStop
