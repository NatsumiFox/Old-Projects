soundA1_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundA1_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $05, soundA1_FM5, $00, $01

soundA1_FM5:
	smpsSetvoice	$00
	dc.b nC5, $06, nA4, $16
	smpsStop	

soundA1_Voices:
	; Voice $00
	; $3C
	; $05, $01, $0A, $01,	$56, $5C, $5C, $5C
	; $0E, $11, $11, $11,	$09, $0A, $06, $0A
	; $4F, $3F, $3F, $3F,	$17, $80, $20, $80
	smpsVcAlgorithm	$04
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$01, $0A, $01, $05
	smpsVcRateScale	$01, $01, $01, $01
	smpsVcAttackRate	$1C, $1C, $1C, $16
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$11, $11, $11, $0E
	smpsVcDecayRate2	$0A, $06, $0A, $09
	smpsVcDecayLevel	$03, $03, $03, $04
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $20, $00, $17
