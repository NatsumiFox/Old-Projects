soundCB_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$02
	sHeaderSFX	$80, $05, soundCB_FM5, $00, $00
	sHeaderSFX	$80, $C0, soundCB_PSG3, $00, $00

soundCB_FM5:
	sPatFM		$06
	ssMod68k	$03, $01, $20, $04

soundCB_Loop2:
	dc.b nC0, $18
	saVolFM		$0A
	sLoop		$00, $06, soundCB_Loop2
	sStop

soundCB_PSG3:
	ssMod68k	$01, $01, $0F, $05
	sNoisePSG	$E7

soundCB_Loop1:
	dc.b nB3, $18, sHold
	saVolPSG	$03
	sLoop		$00, $05, soundCB_Loop1
	sStop
