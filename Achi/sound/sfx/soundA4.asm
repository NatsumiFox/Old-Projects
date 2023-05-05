soundA4_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$02
	sHeaderSFX	$80, $A0, soundA4_PSG2, $F4, $00
	sHeaderSFX	$80, $C0, soundA4_PSG3, $F4, $00

soundA4_PSG2:
	sVolEnvPSG	VolEnv_00
	dc.b nBb3, $01, nRst, nBb3, nRst, $03

soundA4_Loop2:
	dc.b nBb3, $01, nRst, $01
	sLoop		$00, $0B, soundA4_Loop2
	sStop

soundA4_PSG3:
	sVolEnvPSG	VolEnv_00
	dc.b nRst, $01, nAb3, nRst, nAb3, nRst, $03

soundA4_Loop1:
	dc.b nAb3, $01, nRst, $01
	sLoop		$00, $0B, soundA4_Loop1
	sStop
