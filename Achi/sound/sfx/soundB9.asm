soundB9_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$04
	sHeaderSFX	$80, $02, soundB9_FM3, $10, $00
	sHeaderSFX	$80, $04, soundB9_FM4, $00, $00
	sHeaderSFX	$80, $05, soundB9_FM5, $10, $00
	sHeaderSFX	$80, $C0, soundB9_PSG3, $00, $00

soundB9_FM3:
	sPan		spRight, $00
	dc.b nRst, $02
	sJump		soundB9_Jump1

soundB9_FM5:
	sPan		spLeft, $00
	dc.b nRst, $01

soundB9_FM4:
soundB9_Jump1:
	sPatFM		$06
	ssMod68k	$03, $01, $20, $04

soundB9_Loop2:
	dc.b nC0, $18
	saVolFM		$0A
	sLoop		$00, $06, soundB9_Loop2
	sStop

soundB9_PSG3:
	ssMod68k	$01, $01, $0F, $05
	sNoisePSG	$E7

soundB9_Loop1:
	dc.b nB3, $18, sHold
	saVolPSG	$03
	sLoop		$00, $05, soundB9_Loop1
	sStop
