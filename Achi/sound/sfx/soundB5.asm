soundB5_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, soundB5_FM5, $00, $05

soundB5_FM5:
	sPan		spRight, $00

soundB5_Com:
	sPatFM		$0F
	dc.b nE5, $05, nG5, $05, nC6, $1B
	sStop
