soundAF_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $05, soundAF_FM5, $0C, $00

soundAF_FM5:
	sPatFM		$09
	dc.b nRst, $01, nBb2, $05, sHold, nB2, $26
	sStop
