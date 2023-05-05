soundB6_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $C0, soundB6_PSG3, $00, $00

soundB6_PSG3:
	ssMod68k	$01, $01, $F0, $08
	sNoisePSG	$E7
	dc.b nE5, $07

soundB6_Loop1:
	dc.b nG6, $01
	saVolPSG	$01
	sLoop		$00, $0C, soundB6_Loop1
	sStop
