soundC6_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundC6_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$02
	smpsHeaderSFX	$80, $04, soundC6_FM4, $00, $05
	smpsHeaderSFX	$80, $05, soundC6_FM5, $00, $08

soundC6_FM4:
	smpsSetvoice	$00
	dc.b nA5, $02, $05, $05, $05, $05, $05, $05
	dc.b $3A
	smpsStop	

soundC6_FM5:
	smpsSetvoice	$00
	dc.b nRst, $02, nG5, $02, $05, $15, $02, $05
	dc.b $32
	smpsStop	

soundC6_Voices:
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
