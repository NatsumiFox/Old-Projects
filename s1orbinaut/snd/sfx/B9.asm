soundB9_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundB9_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$04
	smpsHeaderSFX	$80, $02, soundB9_FM3, $10, $00
	smpsHeaderSFX	$80, $04, soundB9_FM4, $00, $00
	smpsHeaderSFX	$80, $05, soundB9_FM5, $10, $00
	smpsHeaderSFX	$80, $C0, soundB9_PSG3, $00, $00

soundB9_FM3:
	smpsPan	panRight, $00
	dc.b nRst, $02
	smpsJump	soundB9_Jump1

soundB9_FM5:
	smpsPan	panLeft, $00
	dc.b nRst, $01

soundB9_FM4:
soundB9_Jump1:
	smpsSetvoice	$00
	smpsModSet	$03, $01, $20, $04

soundB9_Loop1:
	dc.b nC0, $18
	smpsFMAlterVol	$0A
	smpsLoop	$00, $06, soundB9_Loop1
	smpsStop	

soundB9_PSG3:
	smpsModSet	$01, $01, $0F, $05
	smpsPSGform	$E7

soundB9_Loop2:
	dc.b nB3, $18, smpsNoAttack
	smpsPSGAlterVol	$03
	smpsLoop	$00, $05, soundB9_Loop2
	smpsStop	

soundB9_Voices:
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
