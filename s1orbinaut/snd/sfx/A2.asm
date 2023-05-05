soundA2_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundA2_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $C0, soundA2_PSG3, $00, $00

soundA2_PSG3:
	smpsModSet	$01, $01, $F0, $08
	smpsPSGform	$E7
	dc.b nEb5, $04, nCs6, $04

soundA2_Loop1:
	dc.b nEb5, $01
	smpsPSGAlterVol	$01
	smpsLoop	$00, $06, soundA2_Loop1
	smpsStop	

soundA2_Voices:
