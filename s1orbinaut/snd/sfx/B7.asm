soundB7_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundB7_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $05, soundB7_FM5, $00, $00

soundB7_FM5:
	smpsSetvoice	$00
	smpsModSet	$01, $01, $20, $08

soundB7_Loop1:
	dc.b nBb0, $0A
	smpsLoop	$00, $08, soundB7_Loop1

soundB7_Loop2:
	dc.b nBb0, $10
	smpsFMAlterVol	$03
	smpsLoop	$00, $09, soundB7_Loop2
	smpsStop	

soundB7_Voices:
	; Voice $00
	; $FA
	; $21, $30, $10, $32,	$1F, $1F, $1F, $1F
	; $05, $18, $09, $02,	$06, $0F, $06, $02
	; $1F, $2F, $4F, $2F,	$0F, $1A, $0E, $80
	smpsVcAlgorithm	$02
	smpsVcFeedback	$07
	smpsVcDetune	$03, $01, $03, $02
	smpsVcCoarseFreq	$02, $00, $00, $01
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$02, $09, $18, $05
	smpsVcDecayRate2	$02, $06, $0F, $06
	smpsVcDecayLevel	$02, $04, $02, $01
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $0E, $1A, $0F
