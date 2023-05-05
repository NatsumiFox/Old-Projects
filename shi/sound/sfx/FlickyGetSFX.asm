FlickyGetSFX_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	FlickyGetSFX_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$02
	smpsHeaderSFX	$80, $04, FlickyGetSFX_FM4, $00, $09
	smpsHeaderSFX	$80, $05, FlickyGetSFX_FM5, $00, $09

FlickyGetSFX_FM4:
	smpsSetvoice	$00
	dc.b nG5, $06, nF5, nE5, nC6, $0C
	smpsStop	

FlickyGetSFX_FM5:
	smpsSetvoice	$00
	dc.b nE5, $06, nD5, nC5, nG6, $0C
	smpsStop	

FlickyGetSFX_Voices:
	; Voice $00
	; $01
	; $04, $01, $02, $01,	$1E, $10, $10, $10
	; $0C, $05, $03, $11,	$00, $00, $09, $08
	; $2F, $2F, $1F, $FF,	$18, $10, $2D, $80
	smpsVcAlgorithm	$01
	smpsVcFeedback	$00
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$01, $02, $01, $04
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$10, $10, $10, $1E
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$11, $03, $05, $0C
	smpsVcDecayRate2	$08, $09, $00, $00
	smpsVcDecayLevel	$0F, $01, $02, $02
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $2D, $10, $18
