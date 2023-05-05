soundC9_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundC9_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $05, soundC9_FM5, $0E, $00

soundC9_FM5:
	smpsSetvoice	$00
	smpsModSet	$01, $01, $33, $18
	dc.b nAb4, $1A
	smpsStop	

soundC9_Voices:
	; Voice $00
	; $3B
	; $0A, $31, $05, $02,	$5F, $5F, $5F, $5F
	; $04, $14, $16, $0C,	$00, $04, $00, $00
	; $1F, $6F, $D8, $FF,	$03, $25, $00, $80
	smpsVcAlgorithm	$03
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $03, $00
	smpsVcCoarseFreq	$02, $05, $01, $0A
	smpsVcRateScale	$01, $01, $01, $01
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0C, $16, $14, $04
	smpsVcDecayRate2	$00, $00, $04, $00
	smpsVcDecayLevel	$0F, $0D, $06, $01
	smpsVcReleaseRate	$0F, $08, $0F, $0F
	smpsVcTotalLevel	$00, $00, $25, $03
