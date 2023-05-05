soundB8_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundB8_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $C0, soundB8_PSG3, $00, $00

soundB8_PSG3:
	smpsModSet	$01, $01, $F0, $08
	smpsPSGform	$E7
	dc.b nEb4, $08

soundB8_Loop1:
	dc.b nB3, $02
	smpsPSGAlterVol	$01
	smpsLoop	$00, $03, soundB8_Loop1
	smpsStop	

soundB8_Voices:
