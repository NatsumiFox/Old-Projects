soundC1_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$02
	sHeaderSFX	$80, $05, soundC1_FM5, $00, $00
	sHeaderSFX	$80, $C0, soundC1_PSG3, $00, $02

soundC1_FM5:
	ssMod68k	$03, $01, $72, $0B
	sPatFM		$19
	dc.b nA4, $16
	sStop

soundC1_PSG3:
	sVolEnvPSG	VolEnv_01
	sNoisePSG	$E7
	dc.b nB3, $1B
	sStop
