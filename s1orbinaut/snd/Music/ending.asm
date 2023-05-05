music8B_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	music8B_Voices
	smpsHeaderChan	$06, $03
	smpsHeaderTempo	$01, $05
	smpsHeaderDAC	music8B_DAC
	smpsHeaderFM	music8B_FM1, $F4, $0E
	smpsHeaderFM	music8B_FM2, $F4, $09
	smpsHeaderFM	music8B_FM3, $F4, $0D
	smpsHeaderFM	music8B_FM4, $F4, $0D
	smpsHeaderFM	music8B_FM5, $F4, $17
	smpsHeaderPSG	music8B_PSG1, $D0, $05, $00, VolEnv_05
	smpsHeaderPSG	music8B_PSG2, $DC, $05, $00, VolEnv_05
	smpsHeaderPSG	music8B_PSG3, $00, $03, $00, VolEnv_04

music8B_FM1:
	smpsSetvoice	$03
	dc.b nRst, $60
	smpsCall	music8B_Call1
	dc.b nRst, $60
	smpsFMAlterVol	$FB
	dc.b nRst, $0C, nE6, $06, nRst, nB6, nE6, $06
	dc.b nRst, $0C, nE6, $06, nRst, nB6, nE6, $06
	dc.b nRst, $18
	smpsFMAlterVol	$05
	dc.b nRst, $0C, nA3, nRst, nA3, nRst, $24
	smpsAlterNote	$02
	smpsFMAlterVol	$08
	dc.b nA2, $6C
	smpsStop

music8B_Call1:
music8B_Loop2:
	dc.b nRst, $0C, nCs6, $15, nRst, $03, nCs6, $06
	dc.b nRst, nD6, $0F, nRst, $03, nB5, $18, nRst
	dc.b $06, nCs6, nRst, nCs6, nRst, nCs6, nRst, nA5
	dc.b nRst, nG5, $0F, nRst, $03, nB5, $18, nRst
	dc.b $06
	smpsLoop	$00, $02, music8B_Loop2
	smpsReturn

music8B_FM2:
	smpsSetvoice	$01
	dc.b nRst, $60

music8B_Loop3:
	dc.b nA3, $06, nRst, nA3, nRst, nE3, nRst, nE3
	dc.b nRst, nG3, $12, nFs3, $0C, nG3, $06, nFs3
	dc.b $0C, nA3, $06, nRst, nA3, nRst, nE3, nRst
	dc.b nE3, nRst, nD4, $12, nCs4, $0C, nD4, $06
	dc.b nCs4, $0C
	smpsLoop	$00, $02, music8B_Loop3
	dc.b nG3, $06, nRst, nE3, nRst, nF3, nRst, nFs3
	dc.b nRst, nG3, nG3, nE3, nRst, nF3, nRst, nG3
	dc.b nRst, nE3, nRst, nE3, nRst, nAb3, nRst, nAb3
	dc.b nRst, nB3, nRst, nB3, nRst, nD4, nRst, nD4
	dc.b nRst, nRst, $0C, nA2, $12, nRst, $06, nA2
	dc.b $12, nAb3, nA3, $06, nRst
	smpsFMAlterVol	$FD
	dc.b nA2, $6C
	smpsStop

music8B_FM3:
	smpsSetvoice	$02
	dc.b nRst, $60

music8B_Loop4:
	dc.b nE6, $06, nRst, nE6, nRst, nCs6, nRst, nCs6
	dc.b nRst, nD6, $12, nD6, $1E, nE6, $06, nRst
	dc.b nE6, nRst, nCs6, nRst, nCs6, nRst, nG6, $12
	dc.b nG6, $1E
	smpsLoop	$00, $02, music8B_Loop4
	dc.b nRst, $0C, nD6, $12, nRst, $06, nD6, nRst
	dc.b nCs6, $12, nD6, nCs6, $0C, nAb5, $18, nB5
	dc.b nD6, nAb6, nRst, $0C, nE6, nRst, nE6, $12
	dc.b nEb6, nE6, $06, nRst
	smpsFMAlterVol	$F8
	smpsSetvoice	$01
	smpsAlterNote	$03
	dc.b nA2, $6C
	smpsStop

music8B_FM4:
	smpsSetvoice	$02
	dc.b nRst, $60

music8B_Loop5:
	dc.b nCs6, $06, nRst, nCs6, nRst, nA5, nRst, nA5
	dc.b nRst, nB5, $12, nB5, $1E, nCs6, $06, nRst
	dc.b nCs6, nRst, nA5, nRst, nA5, nRst, nD6, $12
	dc.b nD6, $1E
	smpsLoop	$00, $02, music8B_Loop5
	smpsAlterNote	$03
	smpsFMAlterVol	$08
	smpsCall	music8B_Call2
	smpsFMAlterVol	$F0
	smpsSetvoice	$01
	smpsModSet	$00, $01, $06, $04
	dc.b nA2, $6C
	smpsStop

music8B_Call2:
	smpsSetvoice	$00
	dc.b nRst, $0C, nG6, nB6, nD7, nFs7, $0C, nRst
	dc.b $06, nFs7, $0C, nG7, $06, nFs7, $0C, nAb7
	dc.b $60, nA7, $0C, nRst, nA7, nRst, nRst, $06
	dc.b nAb7, $12, nA7, $0C
	smpsReturn

music8B_FM5:
	smpsSetvoice	$03
	smpsAlterNote	$03
	smpsFMAlterVol	$F7
	dc.b nRst, $60
	smpsCall	music8B_Call1
	smpsFMAlterVol	$09
	smpsModSet	$00, $01, $06, $04
	smpsCall	music8B_Call2
	smpsStop

music8B_PSG1:
	dc.b nRst, $60, nRst, nRst, nRst, nRst, nRst, $0C
	dc.b nB5, $12, nRst, $06, nB5, nRst, nA5, $12
	dc.b nB5, nA5, $0C, nE5, $18, nAb5, nB5, nD6
	dc.b nRst, $0C, nCs6, nRst, nCs6, $12, nC6, nCs6
	dc.b $06
	smpsStop

music8B_PSG2:
	smpsAlterNote	$01
	dc.b nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b $0C, nE6, $06, nRst, nB6, nE6, nRst, $0C
	dc.b nE6, $06, nRst, nB6, nE6, nRst, $18
	smpsStop

music8B_PSG3:
	smpsPSGform	$E7

music8B_Loop6:
	smpsNoteFill	$03
	dc.b nA5, $0C
	smpsNoteFill	$0C
	dc.b $0C
	smpsNoteFill	$03
	dc.b $0C
	smpsNoteFill	$0C
	dc.b $0C
	smpsLoop	$00, $0F, music8B_Loop6
	smpsNoteFill	$03
	dc.b nA5, $06
	smpsNoteFill	$0E
	dc.b $12
	smpsNoteFill	$03
	dc.b $0C
	smpsNoteFill	$0F
	dc.b $0C
	smpsStop

music8B_DAC:
	dc.b dKick, $0C, dSnare, dKick, dSnare, dKick, $0C, dSnare
	dc.b dKick, $06, nRst, $02, dSnare, dSnare, dSnare, $09
	dc.b dSnare, $03
music8B_Loop1:
	dc.b dKick, $0C, dSnare, dKick, dSnare, dKick, $0C, dSnare
	dc.b dKick, dSnare, dKick, $0C, dSnare, dKick, dSnare, dKick
	dc.b $0C, dSnare, dKick, $06, nRst, $02, dSnare, dSnare
	dc.b dSnare, $09, dSnare, $03
	smpsLoop	$00, $03, music8B_Loop1
	dc.b dKick, $0C, dSnare, dKick, dSnare, dKick, $06, dSnare
	dc.b $12, dSnare, $0C, dKick
	smpsStop

music8B_Voices:
	; Voice $00
	; $3D
	; $01, $02, $02, $02,	$14, $0E, $8C, $0E
	; $08, $05, $02, $05,	$00, $00, $00, $00
	; $1F, $1F, $1F, $1F,	$1A, $80, $80, $80
	smpsVcAlgorithm	$05
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$02, $02, $02, $01
	smpsVcRateScale	$00, $02, $00, $00
	smpsVcAttackRate	$0E, $0C, $0E, $14
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$05, $02, $05, $08
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$01, $01, $01, $01
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $00, $00, $1A

	; Voice $01
	; $20
	; $36, $35, $30, $31,	$DF, $DF, $9F, $9F
	; $07, $06, $09, $06,	$07, $06, $06, $08
	; $2F, $1F, $1F, $FF,	$19, $37, $13, $80
	smpsVcAlgorithm	$00
	smpsVcFeedback	$04
	smpsVcDetune	$03, $03, $03, $03
	smpsVcCoarseFreq	$01, $00, $05, $06
	smpsVcRateScale	$02, $02, $03, $03
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$06, $09, $06, $07
	smpsVcDecayRate2	$08, $06, $06, $07
	smpsVcDecayLevel	$0F, $01, $01, $02
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $13, $37, $19

	; Voice $02
	; $3A
	; $01, $07, $01, $01,	$8E, $8E, $8D, $53
	; $0E, $0E, $0E, $03,	$00, $00, $00, $00
	; $1F, $FF, $1F, $0F,	$18, $28, $27, $80
	smpsVcAlgorithm	$02
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$01, $01, $07, $01
	smpsVcRateScale	$01, $02, $02, $02
	smpsVcAttackRate	$13, $0D, $0E, $0E
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$03, $0E, $0E, $0E
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$00, $01, $0F, $01
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $27, $28, $18

	; Voice $03
	; $3A
	; $51, $08, $51, $02,	$1E, $1E, $1E, $10
	; $1F, $1F, $1F, $0F,	$00, $00, $00, $02
	; $0F, $0F, $0F, $1F,	$18, $24, $22, $81
	smpsVcAlgorithm	$02
	smpsVcFeedback	$07
	smpsVcDetune	$00, $05, $00, $05
	smpsVcCoarseFreq	$02, $01, $08, $01
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$10, $1E, $1E, $1E
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0F, $1F, $1F, $1F
	smpsVcDecayRate2	$02, $00, $00, $00
	smpsVcDecayLevel	$01, $00, $00, $00
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$01, $22, $24, $18
