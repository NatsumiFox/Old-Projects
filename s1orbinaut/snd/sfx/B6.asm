soundB6_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundB6_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $C0, soundB6_PSG3, $00, $00

soundB6_PSG3:
	smpsModSet	$01, $01, $F0, $08
	smpsPSGform	$E7
	dc.b nE5, $07

soundB6_Loop1:
	dc.b nG6, $01
	smpsPSGAlterVol	$01
	smpsLoop	$00, $0C, soundB6_Loop1
	smpsStop	

soundB6_Voices:
