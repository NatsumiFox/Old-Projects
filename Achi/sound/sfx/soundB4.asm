soundB4_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$03
	sHeaderSFX	$80, $05, soundB4_FM5, $00, $00
	sHeaderSFX	$80, $04, soundB4_FM4, $00, $00
	sHeaderSFX	$80, $02, soundB4_FM3, $00, $02

soundB4_FM5:
	sPatFM		$0D
	sJump		soundB4_Jump1

soundB4_FM4:
	sPatFM		$00
	saDetune	$07
	dc.b nRst, $01

soundB4_Jump1:
	dc.b nA4, $20
	sStop

soundB4_FM3:
	sPatFM		$0E
	dc.b nCs2, $03
	sStop
