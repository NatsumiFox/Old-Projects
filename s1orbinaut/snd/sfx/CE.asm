soundCE_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundCE_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $04, soundCE_FM4, $00, $05

soundCE_FM4:
	smpsSetvoice	$00
	smpsPan	panLeft, $00
	dc.b nE5, $04, nG5, $05, nC6, $1B
	smpsStop	

soundCE_Voices:
	; Voice $00
	; $04
	; $37, $72, $77, $49,	$1F, $1F, $1F, $1F
	; $07, $0A, $07, $0D,	$00, $0B, $00, $0B
	; $1F, $0F, $1F, $0F,	$23, $80, $23, $80
	smpsVcAlgorithm	$04
	smpsVcFeedback	$00
	smpsVcDetune	$04, $07, $07, $03
	smpsVcCoarseFreq	$09, $07, $02, $07
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0D, $07, $0A, $07
	smpsVcDecayRate2	$0B, $00, $0B, $00
	smpsVcDecayLevel	$00, $01, $00, $01
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $23, $00, $23
