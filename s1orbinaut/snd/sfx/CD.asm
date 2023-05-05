soundCD_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundCD_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $C0, soundCD_PSG3, $00, $00

soundCD_PSG3:
	dc.b nBb4, $02
	smpsStop	

soundCD_Voices:
