soundCF_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$02
	sHeaderSFX	$80, $04, soundCF_FM4, $27, $03
	sHeaderSFX	$80, $05, soundCF_FM5, $27, $00

soundCF_FM4:
	dc.b nRst, $04
soundCF_FM5:
	sPatFM		$23

soundCF_Loop1:
	dc.b nEb4, $05
	saVolFM		$02
	sLoop		$00, $15, soundCF_Loop1
	sStop
