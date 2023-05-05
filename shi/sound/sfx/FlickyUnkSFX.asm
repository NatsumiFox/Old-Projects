FlickyUnkSFX_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	FlickyUnkSFX_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $05, FlickyUnkSFX_FM5, $F9, $0C

FlickyUnkSFX_FM5:
	smpsSetvoice	$00
	smpsModSet	$01, $01, $32, $00
	dc.b nA6, $04, nFs6
	smpsStop	

FlickyUnkSFX_Voices:
	; Voice $00
	; $6E
	; $13, $13, $13, $13,	$13, $13, $13, $14
	; $12, $10, $10, $12,	$17, $12, $12, $12
	; $4F, $1F, $AF, $3F,	$18, $80, $80, $80
	smpsVcAlgorithm	$06
	smpsVcFeedback	$05
	smpsVcDetune	$01, $01, $01, $01
	smpsVcCoarseFreq	$03, $03, $03, $03
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$14, $13, $13, $13
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$12, $10, $10, $12
	smpsVcDecayRate2	$12, $12, $12, $17
	smpsVcDecayLevel	$03, $0A, $01, $04
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $00, $00, $18
