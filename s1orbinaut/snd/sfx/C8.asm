soundC8_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundC8_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $C0, soundC8_PSG3, $00, $00

soundC8_PSG3:
	smpsPSGvoice	$00
	smpsPSGform	$E7
	dc.b nD3, $25
	smpsStop	

soundC8_Voices:
