soundAD_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundAD_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $05, soundAD_FM5, $0E, $00

soundAD_FM5:
	smpsSetvoice	$00
	smpsModSet	$01, $01, $21, $6E
	dc.b nCs3, $07, nRst, $06
	smpsModSet	$01, $01, $44, $1E
	dc.b nAb3, $08
	smpsStop	

soundAD_Voices:
	; Voice $00
	; $35
	; $05, $09, $08, $07,	$1E, $0D, $0D, $0E
	; $0C, $15, $03, $06,	$16, $0E, $09, $10
	; $2F, $2F, $1F, $1F,	$15, $12, $12, $80
	smpsVcAlgorithm	$05
	smpsVcFeedback	$06
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$07, $08, $09, $05
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$0E, $0D, $0D, $1E
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$06, $03, $15, $0C
	smpsVcDecayRate2	$10, $09, $0E, $16
	smpsVcDecayLevel	$01, $01, $02, $02
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $12, $12, $15
