soundAC_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundAC_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $05, soundAC_FM5, $00, $00

soundAC_FM5:
	smpsSetvoice	$00
	smpsModSet	$01, $01, $0C, $01

soundAC_Loop1:
	dc.b nC0, $0A
	smpsFMAlterVol	$10
	smpsLoop	$00, $04, soundAC_Loop1
	smpsStop	

soundAC_Voices:
	; Voice $00
	; $F9
	; $21, $30, $10, $32,	$1F, $1F, $1F, $1F
	; $05, $18, $09, $02,	$0B, $1F, $10, $05
	; $1F, $2F, $4F, $2F,	$0E, $07, $04, $80
	smpsVcAlgorithm	$01
	smpsVcFeedback	$07
	smpsVcDetune	$03, $01, $03, $02
	smpsVcCoarseFreq	$02, $00, $00, $01
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$02, $09, $18, $05
	smpsVcDecayRate2	$05, $10, $1F, $0B
	smpsVcDecayLevel	$02, $04, $02, $01
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $04, $07, $0E
