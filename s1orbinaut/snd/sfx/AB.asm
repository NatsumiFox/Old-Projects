soundAB_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundAB_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $C0, soundAB_PSG3, $00, $00

soundAB_PSG3:
	smpsPSGvoice	$00
	smpsPSGform	$E7
	dc.b nA5, $03, nRst, $03, nA5, $01, smpsNoAttack

soundAB_Loop1:
	dc.b $01
	smpsPSGAlterVol	$01
	dc.b smpsNoAttack
	smpsLoop	$00, $15, soundAB_Loop1
	smpsStop	

soundAB_Voices:
