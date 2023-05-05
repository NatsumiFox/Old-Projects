soundA9_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundA9_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $A0, soundA9_PSG2, $00, $00

soundA9_PSG2:
	smpsModSet	$01, $01, $E6, $35
	dc.b nCs1, $06
	smpsStop	

soundA9_Voices:
