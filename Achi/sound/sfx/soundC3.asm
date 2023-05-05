soundC3_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$02
	sHeaderSFX	$80, $04, soundC3_FM4, $0C, $00
	sHeaderSFX	$80, $05, soundC3_FM5, $00, $13

soundC3_FM4:
	sPatFM		$1B
	dc.b nRst, $01, nA2, $08
	sPatFM		$1A
	dc.b sHold, nAb3, $26
	sStop

soundC3_FM5:
	sPatFM		$1C
	ssMod68k	$06, $01, $03, $FF
	dc.b nRst, $0A

soundC3_Loop1:
	dc.b nFs5, $06
	sLoop		$00, $05, soundC3_Loop1
	dc.b nFs5, $17
	sStop
