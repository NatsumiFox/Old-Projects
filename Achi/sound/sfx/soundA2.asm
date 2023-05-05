soundA2_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $C0, soundA2_PSG3, $00, $00

soundA2_PSG3:
	ssMod68k	$01, $01, $F0, $08
	sNoisePSG	$E7
	dc.b nEb5, $04, nCs6, $04

soundA2_Loop1:
	dc.b nEb5, $01
	saVolPSG	$01
	sLoop		$00, $06, soundA2_Loop1
	sStop
