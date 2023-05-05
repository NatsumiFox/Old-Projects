soundBE_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $04, soundBE_FM4, $0C, $05

soundBE_FM4:
	sPatFM		$16
	dc.b nRst, $01
	ssMod68k	$03, $01, $09, $FF
	dc.b nCs6, $25
	sModOff

soundBE_Loop1:
	saVolFM		$01
	dc.b sHold, nG6, $02
	sLoop		$00, $2A, soundBE_Loop1
	sStop
