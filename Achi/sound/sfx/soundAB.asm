soundAB_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, $C0, soundAB_PSG3, $00, $00

soundAB_PSG3:
	sVolEnvPSG	VolEnv_00
	sNoisePSG	$E7
	dc.b nA5, $03, nRst, $03, nA5, $01, sHold

soundAB_Loop1:
	dc.b $01
	saVolPSG	$01
	dc.b sHold
	sLoop		$00, $15, soundAB_Loop1
	sStop
