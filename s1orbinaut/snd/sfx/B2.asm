soundB2_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundB2_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$02
	smpsHeaderSFX	$80, $04, soundB2_FM4, $0C, $04
	smpsHeaderSFX	$80, $05, soundB2_FM5, $0E, $02

soundB2_FM5:
	smpsSetvoice	$00
	smpsModSet	$01, $01, $83, $0C

soundB2_Loop2:
	dc.b nA0, $05, $05
	smpsFMAlterVol	$03
	smpsLoop	$00, $0A, soundB2_Loop2
	smpsStop	

soundB2_FM4:
	dc.b nRst, $06
	smpsSetvoice	$00
	smpsModSet	$01, $01, $6F, $0E

soundB2_Loop1:
	dc.b nC1, $04, $05
	smpsFMAlterVol	$03
	smpsLoop	$00, $0A, soundB2_Loop1
	smpsStop	

soundB2_Voices:
	; Voice $00
	; $35
	; $14, $1A, $04, $09,	$0E, $10, $11, $0E
	; $0C, $15, $03, $06,	$16, $0E, $09, $10
	; $2F, $2F, $4F, $4F,	$2F, $12, $12, $80
	smpsVcAlgorithm	$05
	smpsVcFeedback	$06
	smpsVcDetune	$00, $00, $01, $01
	smpsVcCoarseFreq	$09, $04, $0A, $04
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$0E, $11, $10, $0E
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$06, $03, $15, $0C
	smpsVcDecayRate2	$10, $09, $0E, $16
	smpsVcDecayLevel	$04, $04, $02, $02
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $12, $12, $2F
