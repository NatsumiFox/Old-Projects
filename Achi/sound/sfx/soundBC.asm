soundBC_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$02
	sHeaderSFX	$80, $05, soundBC_FM5, $90, $00
	sHeaderSFX	$80, $C0, soundBC_PSG3, $00, $00

soundBC_FM5:
	sPatFM		$13
	ssMod68k	$01, $01, $C5, $1A
	dc.b nE6, $07
	sStop

soundBC_PSG3:
	sVolEnvPSG	VolEnv_07
	dc.b nRst, $07
	ssMod68k	$01, $02, $05, $FF
	sNoisePSG	$E7
	dc.b nBb4, $4F
	sStop
