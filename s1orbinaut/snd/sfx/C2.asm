soundC2_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundC2_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $05, soundC2_FM5, $0C, $08

soundC2_FM5:
	smpsSetvoice	$00
	dc.b nA4, $08, nA4, $25
	smpsStop	

soundC2_Voices:
	; Voice $00
	; $14
	; $25, $33, $36, $11,	$1F, $1F, $1F, $1F
	; $15, $18, $1C, $13,	$0B, $08, $0D, $09
	; $0F, $9F, $8F, $0F,	$24, $05, $0A, $80
	smpsVcAlgorithm	$04
	smpsVcFeedback	$02
	smpsVcDetune	$01, $03, $03, $02
	smpsVcCoarseFreq	$01, $06, $03, $05
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$13, $1C, $18, $15
	smpsVcDecayRate2	$09, $0D, $08, $0B
	smpsVcDecayLevel	$00, $08, $09, $00
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $0A, $05, $24
