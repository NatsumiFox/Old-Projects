music93_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	music93_Voices
	smpsHeaderChan	$07, $03
	smpsHeaderTempo	$01, $06
	smpsHeaderDAC	music93_DAC
	smpsHeaderFM	music93_FM1, $F4, $08
	smpsHeaderFM	music93_FM2, $F4, $08
	smpsHeaderFM	music93_FM3, $F4, $07
	smpsHeaderFM	music93_FM4, $F4, $16
	smpsHeaderFM	music93_FM5, $F4, $16
	smpsHeaderFM	music93_FM6, $F4, $16
	smpsHeaderPSG	music93_PSG1, $F4, $02, $00, VolEnv_04
	smpsHeaderPSG	music93_PSG2, $F4, $02, $00, VolEnv_05
	smpsHeaderPSG	music93_PSG3, $F4, $00, $00, VolEnv_04

music93_FM3:
	smpsAlterNote	$02

music93_FM1:
	smpsSetvoice	$00
	dc.b nE5, $06, nG5, nC6, nE6, $0C, nC6, nG6
	dc.b $2A
	smpsStop

music93_FM2:
	smpsSetvoice	$00
	dc.b nC5, $06, nE5, nG5, nC6, $0C, nA5, nD6
	dc.b $2A
	smpsStop

music93_FM4:
	smpsSetvoice	$01
	dc.b nE5, $0C, nE5, $06, nG5, $06, nRst, nG5
	dc.b nRst, nC6, $2A
	smpsStop

music93_FM5:
	smpsSetvoice	$01
	dc.b nC6, $0C, nC6, $06, nE6, $06, nRst, nE6
	dc.b nRst, nG6, $2A
	smpsStop

music93_FM6:
	smpsSetvoice	$01
	dc.b nG5, $0C, nG5, $06, nC6, $06, nRst, nC6
	dc.b nRst, nE6, $2A
	smpsStop

music93_PSG2:
	dc.b nRst, $2D
music93_Loop2:
	dc.b nG5, $06, nF5, nE5, nD5
	smpsPSGAlterVol	$03
	smpsLoop	$00, $04, music93_Loop2
	smpsStop

music93_PSG1:
	dc.b nRst, $02, nRst, $2D

music93_Loop1:
	dc.b nG5, $06, nF5, nE5, nD5
	smpsPSGAlterVol	$03
	smpsLoop	$00, $04, music93_Loop1

music93_DAC:
music93_PSG3:
	smpsStop

music93_Voices:
	; Voice $00
	; $04
	; $35, $72, $54, $46,	$1F, $1F, $1F, $1F
	; $07, $0A, $07, $0D,	$00, $0B, $00, $0B
	; $1F, $0F, $1F, $0F,	$23, $14, $1D, $80
	smpsVcAlgorithm	$04
	smpsVcFeedback	$00
	smpsVcDetune	$04, $05, $07, $03
	smpsVcCoarseFreq	$06, $04, $02, $05
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0D, $07, $0A, $07
	smpsVcDecayRate2	$0B, $00, $0B, $00
	smpsVcDecayLevel	$00, $01, $00, $01
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $1D, $14, $23

	; Voice $01
	; $3C
	; $31, $52, $50, $30,	$52, $53, $52, $53
	; $08, $00, $08, $00,	$04, $00, $04, $00
	; $10, $07, $10, $07,	$1A, $80, $16, $80
	smpsVcAlgorithm	$04
	smpsVcFeedback	$07
	smpsVcDetune	$03, $05, $05, $03
	smpsVcCoarseFreq	$00, $00, $02, $01
	smpsVcRateScale	$01, $01, $01, $01
	smpsVcAttackRate	$13, $12, $13, $12
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$00, $08, $00, $08
	smpsVcDecayRate2	$00, $04, $00, $04
	smpsVcDecayLevel	$00, $01, $00, $01
	smpsVcReleaseRate	$07, $00, $07, $00
	smpsVcTotalLevel	$00, $16, $00, $1A
