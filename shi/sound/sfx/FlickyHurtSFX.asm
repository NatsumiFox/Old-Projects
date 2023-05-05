FlickyHurtSFX_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	FlickyHurtSFX_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $05, FlickyHurtSFX_FM5, $0C, $0C

FlickyHurtSFX_FM5:
	smpsModSet	$01, $01, $36, $00
	smpsSetvoice	$00
	dc.b nF5, $02, nEb5, nD5, nD5, nEb5, nBb4, nBb4
	dc.b nEb5, nG5
	smpsStop	

FlickyHurtSFX_Voices:
	; Voice $00
	; $3D
	; $03, $03, $16, $33,	$0F, $0F, $1F, $0F
	; $00, $10, $10, $14,	$00, $00, $00, $10
	; $6F, $4F, $5F, $6F,	$28, $80, $80, $80
	smpsVcAlgorithm	$05
	smpsVcFeedback	$07
	smpsVcDetune	$03, $01, $00, $00
	smpsVcCoarseFreq	$03, $06, $03, $03
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$0F, $1F, $0F, $0F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$14, $10, $10, $00
	smpsVcDecayRate2	$10, $00, $00, $00
	smpsVcDecayLevel	$06, $05, $04, $06
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $00, $00, $28
