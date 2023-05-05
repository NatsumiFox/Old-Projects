music90_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	music90_Voices
	smpsHeaderChan	$06, $03
	smpsHeaderTempo	$01, $07
	smpsHeaderDAC	music90_DAC
	smpsHeaderFM	music90_FM1, $E5, $08
	smpsHeaderFM	music90_FM2, $E8, $08
	smpsHeaderFM	music90_FM3, $F4, $0F
	smpsHeaderFM	music90_FM4, $F4, $0F
	smpsHeaderFM	music90_FM5, $F4, $0A
	smpsHeaderPSG	music90_PSG1, $D0, $03, $00, VolEnv_05
	smpsHeaderPSG	music90_PSG1, $DC, $06, $00, VolEnv_05
	smpsHeaderPSG	music90_PSG1, $DC, $00, $00, VolEnv_04

music90_FM1:
	smpsSetvoice	$00
	dc.b nRst, $30

music90_Loop2:
	smpsAlterPitch	$01
	dc.b nRst, $0C, nEb6, $12, nRst, $06, nEb6, nRst
	dc.b nE6, $0C, nRst, $06, nCs6, $18, nRst, $06
	smpsLoop	$00, $03, music90_Loop2
	dc.b nF6, $06, nRst, nF6, nRst, nF6, nRst, nC6
	dc.b nRst, nBb5, $0C, nRst, $06, nD6, $4E
	smpsStop

music90_FM2:
	smpsSetvoice	$01
	smpsFMAlterVol	$02
	smpsAlterPitch	$F4
	dc.b nA5, $0C, nAb5, nG5, nFs5
	smpsFMAlterVol	$FE
	smpsAlterPitch	$0C
	smpsSetvoice	$02

music90_Loop3:
	dc.b nA4, $06, nRst, nA4, nRst, nE4, nRst, nE4
	dc.b nRst, nG4, $12, nFs4, $0C, nG4, $06, nFs4
	dc.b $0C
	smpsAlterPitch	$01
	smpsLoop	$00, $03, music90_Loop3
	smpsAlterPitch	$FD
	dc.b nB4, $06, nRst, nB4, nRst, nFs4, nRst, nFs4
	dc.b nRst, nE5, $0C, nRst, $06, nEb5, $4E
	smpsStop

music90_FM3:
	smpsSetvoice	$03
	dc.b nRst, $30

music90_Loop4:
	dc.b nE6, $06, nRst, nE6, nRst, nCs6, nRst, nCs6
	dc.b nRst, nD6, $12, nD6, $1E
	smpsLoop	$00, $03, music90_Loop4
	dc.b nE6, $06, nRst, nE6, nRst, nCs6, nRst, nCs6
	dc.b nRst, nG6, $0C, nRst, $06, nG6, $1E, smpsNoAttack
	dc.b $30
	smpsStop

music90_FM4:
	smpsSetvoice	$03
	dc.b nRst, $30

music90_Loop5:
	dc.b nCs6, $06, nRst, nCs6, nRst, nA5, nRst, nA5
	dc.b nRst, nB5, $12, nB5, $1E
	smpsLoop	$00, $03, music90_Loop5
	dc.b nCs6, $06, nRst, nCs6, nRst, nA5, nRst, nA5
	dc.b nRst, nD6, $0C, nRst, $06, nD6, $4E

music90_FM5:
music90_PSG1:
	smpsStop

music90_DAC:
	dc.b nRst, $30
music90_Loop1:
	dc.b dKick, $0C, dSnare
	smpsLoop	$00, $0E, music90_Loop1
	dc.b dKick, $0C, dSnare, $06, dKick, $0C
	smpsStop

music90_Voices:
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
	; $3B
	; $52, $31, $31, $51,	$12, $14, $12, $14
	; $0D, $00, $0D, $02,	$00, $00, $00, $01
	; $4F, $0F, $5F, $3F,	$1E, $18, $2D, $80
	smpsVcAlgorithm	$03
	smpsVcFeedback	$07
	smpsVcDetune	$05, $03, $03, $05
	smpsVcCoarseFreq	$01, $01, $01, $02
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$14, $12, $14, $12
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$02, $0D, $00, $0D
	smpsVcDecayRate2	$01, $00, $00, $00
	smpsVcDecayLevel	$03, $05, $00, $04
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $2D, $18, $1E

	; Voice $02
	; $3A
	; $61, $3C, $14, $31,	$9C, $DB, $9C, $DA
	; $04, $09, $04, $03,	$03, $01, $03, $00
	; $1F, $0F, $0F, $AF,	$21, $47, $31, $80
	smpsVcAlgorithm	$02
	smpsVcFeedback	$07
	smpsVcDetune	$03, $01, $03, $06
	smpsVcCoarseFreq	$01, $04, $0C, $01
	smpsVcRateScale	$03, $02, $03, $02
	smpsVcAttackRate	$1A, $1C, $1B, $1C
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$03, $04, $09, $04
	smpsVcDecayRate2	$00, $03, $01, $03
	smpsVcDecayLevel	$0A, $00, $00, $01
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $31, $47, $21

	; Voice $03
	; $1C
	; $6F, $01, $21, $71,	$9F, $DB, $9E, $5E
	; $0F, $07, $06, $07,	$08, $0A, $0B, $00
	; $8F, $8F, $FF, $FF,	$18, $8D, $26, $80
	smpsVcAlgorithm	$04
	smpsVcFeedback	$03
	smpsVcDetune	$07, $02, $00, $06
	smpsVcCoarseFreq	$01, $01, $01, $0F
	smpsVcRateScale	$01, $02, $03, $02
	smpsVcAttackRate	$1E, $1E, $1B, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$07, $06, $07, $0F
	smpsVcDecayRate2	$00, $0B, $0A, $08
	smpsVcDecayLevel	$0F, $0F, $08, $08
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $26, $0D, $18
