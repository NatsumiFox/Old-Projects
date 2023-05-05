soundBF_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	soundBF_Voices
	smpsHeaderTick	$01
	smpsHeaderChan	$03
	smpsHeaderSFX	$80, $02, soundBF_FM3, $F4, $06
	smpsHeaderSFX	$80, $04, soundBF_FM4, $F4, $06
	smpsHeaderSFX	$80, $05, soundBF_FM5, $F4, $06

soundBF_FM3:
	smpsSetvoice	$00
	dc.b nC6, $07, nE6, nG6, nD6, nF6, nA6, nE6
	dc.b nG6, nB6, nF6, nA6, nC7

soundBF_Loop1:
	dc.b nG6, $07, nB6, nD7
	smpsFMAlterVol	$05
	smpsLoop	$00, $08, soundBF_Loop1
	smpsStop	

soundBF_FM4:
	smpsSetvoice	$00
	smpsAlterNote	$01
	dc.b nRst, $07, nE6, $15, nF6, nG6, nA6

soundBF_Loop2:
	dc.b nB6, $15
	smpsFMAlterVol	$05
	smpsLoop	$00, $08, soundBF_Loop2
	smpsStop	

soundBF_FM5:
	smpsSetvoice	$00
	smpsAlterNote	$01
	dc.b nC6, $15, nD6, nE6, nF6

soundBF_Loop3:
	dc.b nG6, $15
	smpsFMAlterVol	$05
	smpsLoop	$00, $08, soundBF_Loop3
	smpsStop	

soundBF_Voices:
	; Voice $00
	; $14
	; $25, $33, $36, $11,	$1F, $1F, $1F, $1F
	; $15, $18, $1C, $13,	$0B, $08, $0D, $09
	; $0F, $9F, $8F, $0F,	$24, $05, $0A, $80
	smpsVcAlgorithm	$04
	smpsVcFeedback	$02
	smpsVcDetune	$01, $03, $03, $02
	smpsVcCoarseFreq	$01, $06, $03, $05
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$13, $1C, $18, $15
	smpsVcDecayRate2	$09, $0D, $08, $0B
	smpsVcDecayLevel	$00, $08, $09, $00
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $0A, $05, $24
