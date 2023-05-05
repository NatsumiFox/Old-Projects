soundA0_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundA0_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $80, soundA0_PSG1, $F4, $00

soundA0_PSG1:
	smpsPSGvoice	$00
	dc.b nF2, $05
	smpsModSet	$02, $01, $F8, $65
	dc.b nBb2, $15
	smpsStop	

soundA0_Voices:
