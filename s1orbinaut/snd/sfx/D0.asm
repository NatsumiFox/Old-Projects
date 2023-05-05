soundD0_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundD0_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $04, soundD0_FM4, $00, $10

soundD0_FM4:
	smpsSetvoice	$00
	dc.b nG6, $02

soundD0_Loop1:
	dc.b smpsNoAttack, $01
	smpsLoop	$00, $40, soundD0_Loop1

soundD0_Loop2:
	dc.b smpsNoAttack, $01
	smpsFMAlterVol	$01
	smpsLoop	$00, $22, soundD0_Loop2
	dc.b nRst, $01
	smpsStop

soundD0_Voices:
	; Voice $00
	; $38
	; $0F, $0F, $0F, $0F,	$1F, $1F, $1F, $0E
	; $00, $00, $00, $00,	$00, $00, $00, $00
	; $0F, $0F, $0F, $1F,	$00, $00, $00, $80
	smpsVcAlgorithm	$00
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$0F, $0F, $0F, $0F
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$0E, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$00, $00, $00, $00
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$01, $00, $00, $00
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $00, $00, $00
