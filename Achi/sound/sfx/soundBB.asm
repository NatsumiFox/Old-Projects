soundBB_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$02
	sHeaderSFX	$80, ctFM5, .FM5, $F8, $08
	sHeaderSFX	$80, ctFM4, .FM4, $F1, $0F

.FM4	dc.b nRst, $03
.FM5	sPatFM		$2C
	ssMod68k	$01, $01, $F8, $04
	dc.b nA3, $13
	saVolFM		$14
	sLoop		$00, $05, .FM5
	sStop

