soundB8_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $C0, soundB8_PSG3, $00, $00

soundB8_PSG3:
	ssMod68k	$01, $01, $F0, $08
	sNoisePSG	$E7
	dc.b nEb4, $08

soundB8_Loop1:
	dc.b nB3, $02
	saVolPSG	$01
	sLoop		$00, $03, soundB8_Loop1
	sStop
