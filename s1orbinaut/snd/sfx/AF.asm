soundAF_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundAF_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $05, soundAF_FM5, $0C, $00

soundAF_FM5:
	smpsSetvoice	$00
	dc.b nRst, $01, nBb2, $05, smpsNoAttack, nB2, $26
	smpsStop	

soundAF_Voices:
	; Voice $00
	; $30
	; $30, $30, $30, $30,	$9E, $A8, $AC, $DC
	; $0E, $0A, $04, $05,	$08, $08, $08, $08
	; $BF, $BF, $BF, $BF,	$04, $2C, $14, $80
	smpsVcAlgorithm	$00
	smpsVcFeedback	$06
	smpsVcDetune	$03, $03, $03, $03
	smpsVcCoarseFreq	$00, $00, $00, $00
	smpsVcRateScale	$03, $02, $02, $02
	smpsVcAttackRate	$1C, $0C, $08, $1E
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$05, $04, $0A, $0E
	smpsVcDecayRate2	$08, $08, $08, $08
	smpsVcDecayLevel	$0B, $0B, $0B, $0B
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $14, $2C, $04
