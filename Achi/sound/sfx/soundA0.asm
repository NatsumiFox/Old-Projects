soundA0_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $80, soundA0_PSG1, $F4, $00

soundA0_PSG1:
	sVolEnvPSG	VolEnv_00
	dc.b nF2, $05
	ssMod68k	$02, $01, $F8, $65
	dc.b nBb2, $15
	sStop
