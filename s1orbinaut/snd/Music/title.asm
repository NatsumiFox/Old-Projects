music8A_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	music8A_Voices
	smpsHeaderChan	$06, $03
	smpsHeaderTempo	$01, $05
	smpsHeaderDAC	music8A_DAC
	smpsHeaderFM	music8A_FM1, $F4, $0C
	smpsHeaderFM	music8A_FM2, $F4, $09
	smpsHeaderFM	music8A_FM3, $F4, $0D
	smpsHeaderFM	music8A_FM4, $F4, $0C
	smpsHeaderFM	music8A_FM5, $F4, $0E
	smpsHeaderPSG	music8A_PSG1, $D0, $03, $00, VolEnv_05
	smpsHeaderPSG	music8A_PSG1, $DC, $06, $00, VolEnv_05
	smpsHeaderPSG	music8A_PSG2, $00, $04, $00, VolEnv_04

music8A_FM5:
	smpsAlterNote	$03

music8A_FM1:
	smpsSetvoice	$00
	dc.b nRst, $3C, nCs6, $15, nRst, $03, nCs6, $06
	dc.b nRst, nD6, $0F, nRst, $03, nB5, $18, nRst
	dc.b $06, nCs6, nRst, nCs6, nRst, nCs6, nRst, nA5
	dc.b nRst, nG5, $0F, nRst, $03, nB5, $0C, nRst
	dc.b $12, nA5, $06, nRst, nCs6, nRst, nA6, nRst
	dc.b nE6, $0C, nRst, $06, nAb6, $12, nA6, $06
	dc.b nRst, $72
	smpsStop

music8A_FM2:
	smpsSetvoice	$01
	dc.b nRst, $30, nA3, $06, nRst, nA3, nRst, nE3
	dc.b nRst, nE3, nRst, nG3, $12, nFs3, $0C, nG3
	dc.b $06, nFs3, $0C, nA3, $06, nRst, nA3, nRst
	dc.b nE3, nRst, nE3, nRst, nD4, $12, nCs4, $0C
	dc.b nD4, $06, nCs4, $0C, nRst, nA2, nRst, nA2
	dc.b nRst, $06, nAb3, $12, nA3, $06, nRst, nA2
	dc.b $6C
	smpsStop

music8A_FM3:
	smpsSetvoice	$02
	dc.b nRst, $30, nE6, $06, nRst, nE6, nRst, nCs6
	dc.b nRst, nCs6, nRst, nD6, $0F, nRst, $03, nD6
	dc.b $18, nRst, $06, nE6, nRst, nE6, nRst, nCs6
	dc.b nRst, nCs6, nRst, nG6, $0F, nRst, $03, nG6
	dc.b $18, nRst, $06, nE6, $0C, nRst, nE6, nRst
	dc.b nRst, $06, nEb6, $12, nE6, $0C
	smpsFMAlterVol	$FC
	smpsSetvoice	$01
	smpsAlterNote	$03
	dc.b nA2, $6C
	smpsStop

music8A_FM4:
	smpsSetvoice	$02
	dc.b nRst, $30, nCs6, $06, nRst, nCs6, nRst, nA5
	dc.b nRst, nA5, nRst, nB5, $0F, nRst, $03, nB5
	dc.b $18, nRst, $06, nCs6, nRst, nCs6, nRst, nA5
	dc.b nRst, nA5, nRst, nD6, $0F, nRst, $03, nD6
	dc.b $18, nRst, $06, nCs6, $0C, nRst, nCs6, nRst
	dc.b nRst, $06, nC6, $12, nCs6, $0C
	smpsFMAlterVol	$FD
	smpsSetvoice	$01
	smpsModSet	$00, $01, $06, $04
	dc.b nA2, $6C
	smpsStop

music8A_PSG2:
	smpsPSGform	$E7
	dc.b nRst, $30

music8A_Loop1:
	smpsNoteFill	$03
	dc.b nA5, $0C
	smpsNoteFill	$0C
	dc.b $0C
	smpsNoteFill	$03
	dc.b $0C
	smpsNoteFill	$0C
	dc.b $0C
	smpsLoop	$00, $05, music8A_Loop1
	smpsNoteFill	$03
	dc.b $06
	smpsNoteFill	$0E
	dc.b $12
	smpsNoteFill	$03
	dc.b $0C
	smpsNoteFill	$0F
	dc.b $0C
	smpsStop

music8A_DAC:
	dc.b nRst, $0C, dSnare, dSnare, dSnare, dKick, dSnare, dKick
	dc.b dSnare, dKick, dSnare, dKick, dSnare, dKick, dSnare, dKick
	dc.b dSnare, dKick, dSnare, dKick, $06, nRst, $02, dSnare
	dc.b dSnare, dSnare, $09, dSnare, $03, dKick, $0C, dSnare
	dc.b dKick, dSnare, dKick, $06, dSnare, $12, dSnare, $0C
	dc.b dKick
music8A_PSG1:
	smpsStop

music8A_Voices:
	; Voice $00
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
