soundC5_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$03
	sHeaderSFX	$80, $05, soundC5_FM5, $00, $00
	sHeaderSFX	$80, $04, soundC5_FM4, $00, $00
	sHeaderSFX	$80, $C0, soundC5_PSG3, $00, $00

soundC5_FM5:
	sPatFM		$1E
	dc.b nA0, $08, nRst, $02, nA0, $08
	sStop

soundC5_FM4:
	sPatFM		$0F
	dc.b nRst, $12, nA5, $55
	sStop

soundC5_PSG3:
	sVolEnvPSG	VolEnv_02
	sNoisePSG	$E7
	dc.b nRst, $02, nF5, $05, nG5, $04, nF5, $05
	dc.b nG5, $04
	sStop
