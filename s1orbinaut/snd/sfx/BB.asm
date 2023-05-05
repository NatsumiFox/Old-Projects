soundBB_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundBB_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $05, soundBB_FM5, $F4, $00

soundBB_FM5:
	smpsSetvoice	$00
	dc.b nD2, $04, nRst, nG2, $06
	smpsStop	

soundBB_Voices:
	; Voice $00
	; $3C
	; $00, $00, $00, $00,	$1F, $1F, $1F, $1F
	; $00, $16, $0F, $0F,	$00, $00, $00, $00
	; $0F, $AF, $FF, $FF,	$00, $80, $0A, $80
	smpsVcAlgorithm	$04
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$00, $00, $00, $00
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0F, $0F, $16, $00
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$0F, $0F, $0A, $00
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $0A, $00, $00
