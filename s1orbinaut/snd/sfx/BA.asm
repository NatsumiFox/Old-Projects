soundBA_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundBA_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $05, soundBA_FM5, $00, $07

soundBA_FM5:
	smpsSetvoice	$00
	dc.b nA3, $08
	smpsStop	

soundBA_Voices:
	; Voice $00
	; $1C
	; $2E, $02, $0F, $02,	$1F, $1F, $1F, $1F
	; $18, $0F, $14, $0E,	$00, $00, $00, $00
	; $FF, $FF, $FF, $FF,	$20, $80, $1B, $80
	smpsVcAlgorithm	$04
	smpsVcFeedback	$03
	smpsVcDetune	$00, $00, $00, $02
	smpsVcCoarseFreq	$02, $0F, $02, $0E
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0E, $14, $0F, $18
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$0F, $0F, $0F, $0F
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $1B, $00, $20
