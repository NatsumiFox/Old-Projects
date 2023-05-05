soundA4_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundA4_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$02
	smpsHeaderSFX	$80, $A0, soundA4_PSG2, $F4, $00
	smpsHeaderSFX	$80, $C0, soundA4_PSG3, $F4, $00

soundA4_PSG2:
	smpsPSGvoice	$00
	dc.b nBb3, $01, nRst, nBb3, nRst, $03

soundA4_Loop1:
	dc.b nBb3, $01, nRst, $01
	smpsLoop	$00, $0B, soundA4_Loop1
	smpsStop	

soundA4_PSG3:
	smpsPSGvoice	$00
	dc.b nRst, $01, nAb3, nRst, nAb3, nRst, $03

soundA4_Loop2:
	dc.b nAb3, $01, nRst, $01
	smpsLoop	$00, $0B, soundA4_Loop2
	smpsStop	

soundA4_Voices:
