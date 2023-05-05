soundC1_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundC1_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$02
	smpsHeaderSFX	$80, $05, soundC1_FM5, $00, $00
	smpsHeaderSFX	$80, $C0, soundC1_PSG3, $00, $02

soundC1_FM5:
	smpsModSet	$03, $01, $72, $0B
	smpsSetvoice	$00
	dc.b nA4, $16
	smpsStop	

soundC1_PSG3:
	smpsPSGvoice	VolEnv_00
	smpsPSGform	$E7
	dc.b nB3, $1B
	smpsStop	

soundC1_Voices:
	; Voice $00
	; $3C
	; $0F, $01, $03, $01,	$1F, $1F, $1F, $1F
	; $19, $12, $19, $0E,	$05, $12, $00, $0F
	; $0F, $7F, $FF, $FF,	$00, $80, $00, $80
	smpsVcAlgorithm	$04
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$01, $03, $01, $0F
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0E, $19, $12, $19
	smpsVcDecayRate2	$0F, $00, $12, $05
	smpsVcDecayLevel	$0F, $0F, $07, $00
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $00, $00, $00
