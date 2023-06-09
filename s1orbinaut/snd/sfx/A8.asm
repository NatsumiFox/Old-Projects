soundA8_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundA8_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$01
	smpsHeaderSFX	$80, $05, soundA8_FM5, $F2, $04

soundA8_FM5:
	smpsSetvoice	$00
	dc.b nCs3

soundA8_Loop1:
	dc.b $02, smpsNoAttack, nB2, $01, smpsNoAttack
	smpsAlterPitch	$02
	smpsLoop	$00, $26, soundA8_Loop1
	smpsStop	

soundA8_Voices:
	; Voice $00
	; $3B
	; $3C, $39, $30, $31,	$DF, $1F, $1F, $DF
	; $04, $05, $04, $01,	$04, $04, $04, $02
	; $FF, $0F, $1F, $AF,	$29, $20, $0F, $80
	smpsVcAlgorithm	$03
	smpsVcFeedback	$07
	smpsVcDetune	$03, $03, $03, $03
	smpsVcCoarseFreq	$01, $00, $09, $0C
	smpsVcRateScale	$03, $00, $00, $03
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$01, $04, $05, $04
	smpsVcDecayRate2	$02, $04, $04, $04
	smpsVcDecayLevel	$0A, $01, $00, $0F
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $0F, $20, $29
