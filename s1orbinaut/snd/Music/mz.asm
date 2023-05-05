music83_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	music83_Voices
	smpsHeaderChan	$06, $03
	smpsHeaderTempo	$02, $09
	smpsHeaderDAC	music83_DAC
	smpsHeaderFM	music83_FM1, $E8, $15
	smpsHeaderFM	music83_FM2, $E8, $0E
	smpsHeaderFM	music83_FM3, $E8, $15
	smpsHeaderFM	music83_FM4, $E8, $17
	smpsHeaderFM	music83_FM5, $E8, $17
	smpsHeaderPSG	music83_PSG1, $D0, $03, $00, VolEnv_08
	smpsHeaderPSG	music83_PSG2, $D0, $05, $00, VolEnv_08
	smpsHeaderPSG	music83_PSG3, $0B, $03, $00, VolEnv_09

music83_FM3:
	smpsAlterNote	$02

music83_FM1:
	smpsSetvoice	$00
	dc.b nRst, $24

music83_Jump2:
	smpsCall	music83_Call1
	dc.b nA6, $09, nRst, $03, nA6, $06, nG6, nA6
	dc.b $09, nRst, $03, nA6, $06, nG6, nA6, $09
	dc.b nRst, $03, nA6, $06, nG6, nA6, $0C, nB6
	dc.b nF6, $12, nE6, $35, nRst, $01
	smpsCall	music83_Call1
	dc.b nA6, $24, nB6, $0C, nAb6, $24, nB6, $09
	dc.b nRst, $03, nB6, $12, nA6, $4D, nRst, $61
	dc.b nRst, $48
	smpsJump	music83_Jump2

music83_Call1:
	dc.b nA5, $06, nB5, nC6, nE6, nB6, $09, nRst
	dc.b $03, nB6, $06, nA6, nB6, $09, nRst, $03
	dc.b nB6, $06, nA6, nB6, $09, nRst, $03, nB6
	dc.b $06, nA6, nB6, nA6, nE6, nC6, nG6, $0C
	dc.b nA6, $06, smpsNoAttack, nF6, $4D, nRst, $01
	smpsReturn

music83_FM4:
	smpsSetvoice	$03
	smpsFMAlterVol	$F7
	dc.b nRst, $06, nE5, $03, $03, $06, nRst, nE4
	dc.b $1E
	smpsSetvoice	$02
	smpsFMAlterVol	$09
	dc.b nB6, $06

music83_Jump4:
	smpsCall	music83_Call3
	dc.b nA6, $09, nRst, $03, nA6, nRst, nB6, $06
	dc.b nRst, nA6, $0C, nRst, $06, nA6, $09, nRst
	dc.b $03, nA6, nRst, nB6, $06, nRst, nA6, $0C
	dc.b nRst, $18, nG6, $03, nRst, $0F, nG6, $03
	dc.b nRst, $39, nB6, $06
	smpsCall	music83_Call3
	dc.b nF6, $09, nRst, $03, nF6, nRst, nA6, $06
	dc.b nRst, nF6, $0C, nRst, $06, nAb6, $09, nRst
	dc.b $03, nAb6, nRst, nB6, $06, nRst, nAb6, $0C
	dc.b nRst, $18, nC7, $03, nRst, $0F, nC7, $03
	dc.b nRst, $09, nE7, $09, nRst, $03, nE7, nRst
	dc.b nD7, $06, nRst, nC7, $03, nRst, nB6, $12
	smpsCall	music83_Call4
	smpsJump	music83_Jump4

music83_Call3:
	dc.b smpsNoAttack, $03, nRst, nB6, nRst, nC7, $06, nRst
	dc.b nB6, $0C, nRst, $06, nB6, $09, nRst, $03
	dc.b nB6, nRst, nC7, $06, nRst, nB6, $0C, nRst
	dc.b $18, nC7, $03, nRst, $0F, nC7, $03, nRst
	dc.b $1B, nC7, $03, nRst, $0F, nC7, $03, nRst
	dc.b $09
	smpsReturn

music83_FM5:
	smpsSetvoice	$04
	smpsFMAlterVol	$FC
	smpsAlterPitch	$24
	dc.b nRst, $06, nE4, $03, $03, $06, nRst, nE3
	dc.b $1E
	smpsSetvoice	$02
	smpsAlterPitch	$DC
	smpsFMAlterVol	$04
	dc.b nG6, $06

music83_Jump5:
	smpsCall	music83_Call5
	dc.b nF6, $09, nRst, $03, nF6, nRst, nG6, $06
	dc.b nRst, nF6, $0C, nRst, $06, nF6, $09, nRst
	dc.b $03, nF6, nRst, nG6, $06, nRst, nF6, $0C
	dc.b nRst, $18, nE6, $03, nRst, $0F, nE6, $03
	dc.b nRst, $39, nG6, $06
	smpsCall	music83_Call5
	dc.b nD6, $09, nRst, $03, nD6, nRst, nF6, $06
	dc.b nRst, nD6, $0C, nRst, $06, nE6, $09, nRst
	dc.b $03, nE6, nRst, nAb6, $06, nRst, nE6, $0C
	dc.b nRst, $18, nA6, $03, nRst, $0F, nA6, $03
	dc.b nRst, $09, nC7, $09, nRst, $03, nC7, nRst
	dc.b nB6, $06, nRst, nA6, $03, nRst, nAb6, $12
	smpsAlterNote	$03
	smpsCall	music83_Call4
	smpsAlterNote	$00
	smpsJump	music83_Jump5

music83_Call5:
	dc.b smpsNoAttack, $03, nRst, nG6, nRst, nA6, $06, nRst
	dc.b nG6, $0C, nRst, $06, nG6, $09, nRst, $03
	dc.b nG6, nRst, nA6, $06, nRst, nG6, $0C, nRst
	dc.b $18, nA6, $03, nRst, $0F, nA6, $03, nRst
	dc.b $1B, nA6, $03, nRst, $0F, nA6, $03, nRst
	dc.b $09
	smpsReturn

music83_FM2:
	smpsSetvoice	$01
	dc.b nRst, $06, nE4, $03, nE4
	dc.b nE4, $06, nRst, nE3, $24

music83_Jump3:
	smpsCall	music83_Call2

music83_Loop3:
	dc.b nG3, $03, nRst, nG3, $06, nD4, $03, nRst
	dc.b nD4, $06, nB3, $03, nRst, nB3, $06, nD4
	dc.b $03, nRst, nD4, $06
	smpsLoop	$01, $02, music83_Loop3
	dc.b nC4, $03, nRst, nC4, $06, nG4, $03, nRst
	dc.b nG4, $06, nE4, $03, nRst, nE4, $06, nG4
	dc.b $03, nRst, nG4, $06, nB3, $03, nRst, nB3
	dc.b $06, nF4, $03, nRst, nF4, $06, nE4, $03
	dc.b nRst, nE4, $06, nB3, $03, nRst, nB3, $06
	smpsCall	music83_Call2
	dc.b nB3, $03, nRst, nB3, $06, nF4, $03, nRst
	dc.b nF4, $06, nD4, $03, nRst, nD4, $06, nF4
	dc.b $03, nRst, nF4, $06, nE4, $03, nRst, nE4
	dc.b $06, nB4, $03, nRst, nB4, $06, nAb4, $03
	dc.b nRst, nAb4, $06, nB4, $03, nRst, nB4, $06
	dc.b nA3, $03, nRst, nA3, $06, nE4, $03, nRst
	dc.b nE4, $06, nC4, $03, nRst, nC4, $06, nE4
	dc.b $03, nRst, nE4, $06, nA3, $03, nRst, nA3
	dc.b $06, nE4, $03, nRst, nE4, $06, nD4, $03
	dc.b nRst, nD4, $06, nE4, $03, nRst, nE4, $06

music83_Loop4:
	dc.b nA3, $12, nA3, $06, nG3, $12, nG3, $06
	dc.b nF3, $12, nF3, $06, nG3, $12, nG3, $06
	smpsLoop	$01, $02, music83_Loop4
	smpsJump	music83_Jump3

music83_Call2:
music83_Loop1:
	dc.b nA3, $03, nRst, nA3, $06, nE4, $03, nRst
	dc.b nE4, $06, nD4, $03, nRst, nD4, $06, nE4
	dc.b $03, nRst, nE4, $06
	smpsLoop	$00, $02, music83_Loop1

music83_Loop2:
	dc.b nD4, $03, nRst, nD4, $06, nA4, $03, nRst
	dc.b nA4, $06, nF4, $03, nRst, nF4, $06, nA4
	dc.b $03, nRst, nA4, $06
	smpsLoop	$00, $02, music83_Loop2
	smpsReturn

music83_PSG1:
music83_Jump7:
	dc.b nRst, $3C
music83_Jump6:
	dc.b nRst, $60
	smpsCall	music83_Call6
	dc.b nRst, $2A, nF7, $0C, nF7, $06, nD7, $0C
	dc.b nB6, $06, nAb6, $2A, nRst, $48
	smpsCall	music83_Call6
	dc.b nRst, $60

music83_Loop6:
	dc.b nA6, $06, nC7, $03, nA6, nC7, $06, nA6
	dc.b nB6, nG6, nD6, nB6, nF6, nA6, $03, nF6
	dc.b nA6, $06, nF6, nG6, nA6, nB6, nG6
	smpsLoop	$00, $02, music83_Loop6
	smpsJump	music83_Jump6

music83_Call6:
	dc.b nRst, $30, nF7, $03, nD7, nA6, nF6, nD7
	dc.b nA6, nF6, nD6, nA6, nF6, nD6, nA5, nF6
	dc.b nD6, nA5, nF5, $27, nRst, $3C
	smpsReturn

music83_PSG2:
	dc.b nRst, $02
	smpsAlterNote	$01
	smpsJump	music83_Jump7

music83_PSG3:
	smpsPSGform	$E7
	smpsPSGAlterVol	$FF
	dc.b nRst, $06, nE5, $03, $03, $06, nRst, nE4
	dc.b $24
	smpsPSGAlterVol	$01

music83_Jump8:
	smpsCall	music83_Call7
	dc.b nG3, nG3, nD4, nD4, nB3, nB3, nD4, nD4
	dc.b nG3, nG3, nD4, nD4, nB3, nB3, nD4, nD4
	dc.b nC4, nC4, nG4, nG4, nE4, nE4, nG4, nG4
	dc.b nB3, nB3, nF4, nF4, nE4, nE4, nB3, nB3
	smpsCall	music83_Call7
	dc.b nB3, nB3, nF4, nF4, nD4, nD4, nF4, nF4
	dc.b nE4, nE4, nB4, nB4, nAb4, nAb4, nB4, nB4
	dc.b nA3, nA3, nE4, nE4, nC4, nC4, nE4, nE4
	dc.b nA3, nA3, nE4, nE4, nD4, nD4, nE4, nE4
	smpsPSGAlterVol	$FF

music83_Loop7:
	dc.b nA4, $12, nA4, $06, nG4, $12, nG4, $06
	dc.b nF4, $12, nF4, $06, nG4, $12, nG4, $06
	smpsLoop	$00, $02, music83_Loop7
	smpsPSGAlterVol	$01
	smpsJump	music83_Jump8

music83_Call7:
	dc.b nA3, $06, nA3, nE4, nE4, nD4, nD4, nE4
	dc.b nE4, nA3, nA3, nE4, nE4, nD4, nD4, nE4
	dc.b nE4, nD4, nD4, nA4, nA4, nF4, nF4, nA4
	dc.b nA4, nD4, nD4, nA4, nA4, nF4, nF4, nA4
	dc.b nA4
	smpsReturn

music83_DAC:
	dc.b nRst, $06, dSnare, $03, $03, $0C, dKick, $0C
	dc.b $0C, $0C
music83_Jump1:
	dc.b dKick, $0C
	smpsJump	music83_Jump1

music83_Call4:
	smpsNoteFill	$06

music83_Loop5:
	dc.b nRst, $06, nE7, nC7, nA6, $0C, nD7, $06
	dc.b nB6, nG6, nRst, nC7, nA6, nF6, $0C, nD7
	dc.b $06, nB6, nG6
	smpsLoop	$00, $02, music83_Loop5
	smpsNoteFill	$00
	smpsReturn

music83_Voices:
	; Voice $00
	; $22
	; $0A, $13, $05, $11,	$03, $12, $12, $11
	; $00, $13, $13, $00,	$03, $02, $02, $01
	; $1F, $1F, $0F, $0F,	$1E, $18, $26, $81
	smpsVcAlgorithm	$02
	smpsVcFeedback	$04
	smpsVcDetune	$01, $00, $01, $00
	smpsVcCoarseFreq	$01, $05, $03, $0A
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$11, $12, $12, $03
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$00, $13, $13, $00
	smpsVcDecayRate2	$01, $02, $02, $03
	smpsVcDecayLevel	$00, $00, $01, $01
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$01, $26, $18, $1E

	; Voice $01
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
	; $23
	; $7C, $32, $00, $00,	$5F, $58, $DC, $DF
	; $04, $0B, $04, $04,	$06, $0C, $08, $08
	; $1F, $1F, $BF, $BF,	$24, $26, $16, $80
	smpsVcAlgorithm	$03
	smpsVcFeedback	$04
	smpsVcDetune	$00, $00, $03, $07
	smpsVcCoarseFreq	$00, $00, $02, $0C
	smpsVcRateScale	$03, $03, $01, $01
	smpsVcAttackRate	$1F, $1C, $18, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$04, $04, $0B, $04
	smpsVcDecayRate2	$08, $08, $0C, $06
	smpsVcDecayLevel	$0B, $0B, $01, $01
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $16, $26, $24

	; Voice $04
	; $02
	; $3C, $32, $55, $51,	$1F, $98, $1F, $9F
	; $0F, $11, $0E, $11,	$0E, $05, $08, $05
	; $5F, $0F, $6F, $0F,	$2D, $2D, $2F, $80
	smpsVcAlgorithm	$02
	smpsVcFeedback	$00
	smpsVcDetune	$05, $05, $03, $03
	smpsVcCoarseFreq	$01, $05, $02, $0C
	smpsVcRateScale	$02, $00, $02, $00
	smpsVcAttackRate	$1F, $1F, $18, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$11, $0E, $11, $0F
	smpsVcDecayRate2	$05, $08, $05, $0E
	smpsVcDecayLevel	$00, $06, $00, $05
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $2F, $2D, $2D
