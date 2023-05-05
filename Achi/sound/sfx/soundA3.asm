soundA3_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, soundA3_FM5, $F4, $00

soundA3_FM5:
	sPatFM		$01
	dc.b nB3, $07, sHold, nAb3

soundA3_Loop1:
	dc.b $01
	saVolFM		$01
	sLoop		$00, $2F, soundA3_Loop1
	sStop
