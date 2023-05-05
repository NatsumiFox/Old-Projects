soundC0_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundC0_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $05, soundC0_FM5, $00, $03

soundC0_FM5:
	smpsSetvoice	$00
	dc.b nG1, $05, nRst, $05, nG1, $04, nRst, $04
	smpsStop	

soundC0_Voices:
	; Voice $00
	; $38
	; $08, $08, $08, $08,	$1F, $1F, $1F, $0E
	; $00, $00, $00, $00,	$00, $00, $00, $00
	; $0F, $0F, $0F, $1F,	$00, $00, $00, $80
	smpsVcAlgorithm	$00
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$08, $08, $08, $08
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$0E, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$00, $00, $00, $00
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$01, $00, $00, $00
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $00, $00, $00
