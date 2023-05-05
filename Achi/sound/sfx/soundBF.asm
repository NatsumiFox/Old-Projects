soundBF_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$03
	sHeaderSFX	$80, $02, soundBF_FM3, $F4, $06
	sHeaderSFX	$80, $04, soundBF_FM4, $F4, $06
	sHeaderSFX	$80, $05, soundBF_FM5, $F4, $06

soundBF_FM3:
	sPatFM		$17
	dc.b nC6, $07, nE6, nG6, nD6, nF6, nA6, nE6
	dc.b nG6, nB6, nF6, nA6, nC7

soundBF_Loop3:
	dc.b nG6, $07, nB6, nD7
	saVolFM		$05
	sLoop		$00, $08, soundBF_Loop3
	sStop

soundBF_FM4:
	sPatFM		$17
	saDetune	$01
	dc.b nRst, $07, nE6, $15, nF6, nG6, nA6

soundBF_Loop2:
	dc.b nB6, $15
	saVolFM		$05
	sLoop		$00, $08, soundBF_Loop2
	sStop

soundBF_FM5:
	sPatFM		$17
	saDetune	$01
	dc.b nC6, $15, nD6, nE6, nF6

soundBF_Loop1:
	dc.b nG6, $15
	saVolFM		$05
	sLoop		$00, $08, soundBF_Loop1
	sStop
