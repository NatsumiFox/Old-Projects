soundC8_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $C0, soundC8_PSG3, $00, $00

soundC8_PSG3:
	sVolEnvPSG	VolEnv_00
	sNoisePSG	$E7
	dc.b nD3, $25
	sStop
