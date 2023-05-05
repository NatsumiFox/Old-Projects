soundCF_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundCF_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$02
	smpsHeaderSFX	$80, $04, soundCF_FM4, $27, $03
	smpsHeaderSFX	$80, $05, soundCF_FM5, $27, $00

soundCF_FM4:
	dc.b nRst, $04
soundCF_FM5:
	smpsSetvoice	$00

soundCF_Loop1:
	dc.b nEb4, $05
	smpsFMAlterVol	$02
	smpsLoop	$00, $15, soundCF_Loop1
	smpsStop	

soundCF_Voices:
	; Voice $00
	; $F4
	; $06, $04, $0F, $0E,	$1F, $1F, $1F, $1F
	; $00, $00, $0B, $0B,	$00, $00, $05, $08
	; $0F, $0F, $FF, $FF,	$0C, $8B, $03, $80
	smpsVcAlgorithm	$04
	smpsVcFeedback	$06
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$0E, $0F, $04, $06
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0B, $0B, $00, $00
	smpsVcDecayRate2	$08, $05, $00, $00
	smpsVcDecayLevel	$0F, $0F, $00, $00
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $03, $0B, $0C
