music86_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	music86_Voices
	smpsHeaderChan	$06, $03
	smpsHeaderTempo	$02, $05
	smpsHeaderDAC	music86_DAC
	smpsHeaderFM	music86_FM1, $F4, $0D
	smpsHeaderFM	music86_FM2, $F4, $0D
	smpsHeaderFM	music86_FM3, $F4, $13
	smpsHeaderFM	music86_FM4, $F4, $17
	smpsHeaderFM	music86_FM5, $F4, $17
	smpsHeaderPSG	music86_PSG1, $D0, $03, $00, VolEnv_00
	smpsHeaderPSG	music86_PSG2, $D0, $03, $00, VolEnv_00
	smpsHeaderPSG	music86_PSG3, $00, $03, $00, VolEnv_04

music86_FM1:
music86_Jump2:
	smpsSetvoice	$02
	smpsFMAlterVol	$08
	dc.b nRst, $24, nE6, $03, nD6, nC6, nB5, nF6
	dc.b nE6, nD6, nC6, nG6, nF6, nE6, nD6, nA6
	dc.b nG6, nF6, nE6, nB6, nA6, nG6, nF6
	smpsFMAlterVol	$F8
	smpsSetvoice	$03
	smpsModSet	$0D, $01, $08, $05
	smpsCall	music86_Call2
	smpsSetvoice	$05
	smpsAlterNote	$FE
	smpsPan	panRight, $00
	smpsFMAlterVol	$03
	smpsAlterPitch	$F4
	smpsCall	music86_Call3
	smpsAlterPitch	$0C
	smpsFMAlterVol	$FD
	smpsPan	panCentre, $00
	smpsFMAlterVol	$FE
	smpsAlterNote	$00
	smpsSetvoice	$03

music86_Loop6:
	smpsCall	music86_Call5
	smpsLoop	$00, $02, music86_Loop6
	smpsFMAlterVol	$02
	smpsJump	music86_Jump2

music86_FM2:
music86_Jump3:
	smpsSetvoice	$00
	smpsFMAlterVol	$FD
	smpsNoteFill	$06
	dc.b nA3, $03, nB3, nRst, nC4, nRst, nD4, nE4
	smpsNoteFill	$00
	dc.b nG4, $09

music86_Loop7:
	dc.b nG3, $06, nG4
	smpsLoop	$00, $05, music86_Loop7
	dc.b nG3
	smpsFMAlterVol	$03
	smpsNoteFill	$06

music86_Loop11:
	smpsCall	music86_Call6

music86_Loop9:
	dc.b nG4, nG4, nD4, nD4, nF4, nF4, nD4, nD4
	smpsLoop	$00, $04, music86_Loop9

music86_Loop10:
	dc.b nF4, nF4, nC4, nC4, nEb4, nEb4, nC4, nC4
	smpsLoop	$00, $04, music86_Loop10
	smpsCall	music86_Call6
	smpsLoop	$01, $02, music86_Loop11
	smpsPan	panLeft, $00
	smpsCall	music86_Call3
	smpsPan	panCentre, $00

music86_Loop12:
	dc.b nC4, $03, nC4, nG3, nG3, nA3, nA3, nG3
	dc.b nG3
	smpsLoop	$00, $02, music86_Loop12

music86_Loop13:
	dc.b nFs4, nFs4, nCs4, nCs4, nEb4, nEb4, nCs4, nCs4
	smpsLoop	$00, $02, music86_Loop13

music86_Loop14:
	dc.b nF4, nF4, nC4, nC4, nD4, nD4, nC4, nC4
	smpsLoop	$00, $02, music86_Loop14

music86_Loop15:
	dc.b nG4, nG4, nD4, nD4, nE4, nE4, nD4, nD4
	smpsLoop	$00, $02, music86_Loop15
	smpsLoop	$01, $04, music86_Loop12
	smpsNoteFill	$00
	smpsJump	music86_Jump3

music86_Call6:
music86_Loop8:
	dc.b nA4, $03, nA4, nE4, nE4, nG4, nG4, nE4
	dc.b nE4
	smpsLoop	$00, $04, music86_Loop8
	smpsReturn

music86_FM3:
music86_Jump4:
	smpsSetvoice	$01
	smpsNoteFill	$06
	dc.b nA4, $03, nB4, nRst, nC5, nRst, nD5, nE5
	smpsNoteFill	$00
	dc.b nG5, $4B
	smpsSetvoice	$03
	smpsAlterNote	$03
	smpsFMAlterVol	$FA
	smpsCall	music86_Call2
	smpsSetvoice	$00
	smpsPan	panRight, $00
	smpsNoteFill	$06
	smpsCall	music86_Call3
	smpsPan	panCentre, $00
	smpsSetvoice	$03
	smpsNoteFill	$00
	smpsFMAlterVol	$FE

music86_Loop16:
	smpsCall	music86_Call5
	smpsLoop	$00, $02, music86_Loop16
	smpsFMAlterVol	$08
	smpsJump	music86_Jump4

music86_FM4:
music86_Jump5:
	smpsSetvoice	$04
	smpsPan	panLeft, $00
	smpsModSet	$5C, $01, $05, $04
	smpsNoteFill	$06
	smpsCall	music86_Call7
	smpsAlterNote	$04
	smpsCall	music86_Call8
	smpsFMAlterVol	$06
	smpsSetvoice	$05
	smpsAlterNote	$02
	smpsFMAlterVol	$ED
	smpsAlterPitch	$F4
	smpsCall	music86_Call3
	smpsFMAlterVol	$13
	smpsAlterPitch	$0C
	smpsFMAlterVol	$F3
	smpsSetvoice	$04
	smpsModOff
	smpsFMAlterVol	$FA

music86_Loop18:
	smpsModOff
	smpsCall	music86_Call9
	dc.b nRst, $0C, nA5, $02
	smpsAlterNote	$00
	dc.b smpsNoAttack, $0A, nRst, $03, nA5, nRst, nRst, nA5
	dc.b nRst, $09
	smpsCall	music86_Call9
	dc.b nA5, $02
	smpsAlterNote	$00
	dc.b $0A, nRst, $06
	smpsModSet	$18, $01, $07, $04
	smpsAlterNote	$E2
	dc.b nA5, $02, smpsNoAttack
	smpsAlterNote	$00
	dc.b $1C
	smpsLoop	$00, $02, music86_Loop18
	smpsFMAlterVol	$06
	smpsFMAlterVol	$01
	smpsJump	music86_Jump5

music86_Call7:
	dc.b nE5, $03, nE5, nRst, nE5, nRst, nE5, nE5
	smpsNoteFill	$00
	dc.b nD5, $4B
	smpsReturn

music86_Call8:
	smpsSetvoice	$02
	smpsFMAlterVol	$06
	smpsModSet	$08, $01, $08, $04

music86_Loop17:
music86_Call11:
	dc.b nRst, $60, nRst, nRst, nE6, $18, nFs6, nG6
	dc.b nAb6
	smpsLoop	$00, $02, music86_Loop17
	smpsReturn

music86_Call9:
	dc.b nRst, $0C
	smpsAlterNote	$EC
	dc.b nG5, $02
	smpsAlterNote	$00
	dc.b smpsNoAttack, $06, nRst, $01, nG5, $03, nRst, $18
	dc.b nRst, $0C
	smpsAlterNote	$EC
	dc.b nCs6, $02
	smpsAlterNote	$00
	dc.b smpsNoAttack, $06, nRst, $01, nCs6, $03, nRst, $18
	dc.b nRst, $0C
	smpsAlterNote	$EC
	dc.b nC6, $02
	smpsAlterNote	$00
	dc.b smpsNoAttack, $06, nRst, $01, nC6, $03, nRst, $18
	smpsAlterNote	$EC
	smpsReturn

music86_FM5:
music86_Jump6:
	smpsSetvoice	$04
	smpsPan	panRight, $00
	smpsModSet	$5C, $01, $05, $04
	smpsNoteFill	$06
	dc.b nC5, $03, nC5, nRst, nC5, nRst, nC5, nC5
	smpsNoteFill	$00
	dc.b nB4, $4B
	smpsCall	music86_Call8
	smpsFMAlterVol	$06

music86_Loop19:
	dc.b nRst, $60
	smpsLoop	$00, $01, music86_Loop19
	smpsSetvoice	$06
	smpsFMAlterVol	$EB
	smpsAlterPitch	$0C
	smpsModOff

music86_Loop20:
	smpsCall	music86_Call10
	dc.b nE6, nF6, nG6
	smpsCall	music86_Call10
	dc.b nG6, nF6, nE6
	smpsLoop	$00, $02, music86_Loop20
	smpsFMAlterVol	$09
	smpsAlterPitch	$F4
	smpsJump	music86_Jump6

music86_Call10:
	dc.b nRst, $03, nE6, nC6, $06, $06, nG5, nC6
	dc.b $09, nE6, $09, nRst, $06, nRst, $03, nF6
	dc.b nCs6, $06, $06, nBb5, nCs6, $09, nF6, $09
	dc.b nRst, $06, nRst, $03, nE6, nC6, $06, $06
	dc.b nA5, nC6, $09, nE6, $0F, nD6, $0C
	smpsReturn

music86_PSG1:
music86_Jump7:
	smpsPSGAlterVol	$01
	smpsPSGvoice	$00
	smpsCall	music86_Call7
	smpsPSGvoice	VolEnv_06
	smpsPSGAlterVol	$FF
	smpsCall	music86_Call11
	dc.b nRst, $60
	smpsPSGvoice	$00
	smpsPSGAlterVol	$FF

music86_Loop21:
	smpsCall	music86_Call12
	dc.b nRst, $0C, nF5, nRst, $03, nF5, nRst, nRst
	dc.b nF5, nRst, $09
	smpsCall	music86_Call12
	dc.b nF5, $0C, nRst, $06, nF5, $1E
	smpsLoop	$00, $02, music86_Loop21
	smpsPSGAlterVol	$01
	smpsJump	music86_Jump7

music86_Call12:
	dc.b nRst, $0C, nE5, $07, nRst, $02, nE5, $03
	dc.b nRst, $18, nRst, $0C, nBb5, $07, nRst, $02
	dc.b nBb5, $03, nRst, $18, nRst, $0C, nA5, $07
	dc.b nRst, $02, nA5, $03, nRst, $18
	smpsReturn

music86_PSG2:
music86_Jump8:
	smpsPSGvoice	$00
	smpsPSGAlterVol	$01
	dc.b nC5, $03, nC5, nRst, nC5, nRst, nC5, nC5
	smpsNoteFill	$00
	dc.b nB4, $4B
	smpsPSGAlterVol	$FF

music86_Loop25:
	smpsPSGvoice	VolEnv_05
	smpsNoteFill	$03
	smpsCall	music86_Call13

music86_Loop23:
	dc.b nG6, nG6, nD7, nG6, nC7, nG6, nB6, nG6
	smpsLoop	$00, $04, music86_Loop23

music86_Loop24:
	dc.b nA6, nA6, nEb7, nA6, nD7, nA6, nC7, nA6
	smpsLoop	$00, $04, music86_Loop24
	smpsCall	music86_Call13
	smpsLoop	$01, $02, music86_Loop25
	dc.b nRst, $60
	smpsPSGAlterVol	$01

music86_Loop26:
	dc.b nC7, $03, nC7, nG7, nC7, nF7, nC7, nE7
	dc.b nC7
	smpsLoop	$00, $02, music86_Loop26

music86_Loop27:
	dc.b nBb6, nBb6, nF7, nBb6, nEb7, nBb6, nCs7, nBb6
	smpsLoop	$00, $02, music86_Loop27

music86_Loop28:
	dc.b nA6, nA6, nE7, nA6, nD7, nA6, nC7, nA6
	smpsLoop	$00, $04, music86_Loop28
	smpsLoop	$01, $04, music86_Loop26
	smpsPSGAlterVol	$FF
	smpsJump	music86_Jump8

music86_Call13:
music86_Loop22:
	dc.b nA6, $03, nA6, nE7, nA6, nD7, nA6, nC7
	dc.b nA6
	smpsLoop	$00, $04, music86_Loop22
	smpsReturn

music86_PSG3:
music86_Jump9:
	smpsPSGform	$E7
	smpsNoteFill	$03
	dc.b nA5, $03, $06, nRst, nA5, $06, $0F, $0C
	dc.b $0C, $0C, $18

music86_Loop29:
	dc.b nA5, $03, $03
	smpsPSGAlterVol	$02
	smpsPSGvoice	VolEnv_08
	smpsNoteFill	$08
	dc.b $06
	smpsPSGvoice	VolEnv_04
	smpsNoteFill	$03
	smpsPSGAlterVol	$FE
	smpsLoop	$00, $88, music86_Loop29
	smpsJump	music86_Jump9

music86_DAC:
music86_Jump1:
	dc.b dSnare, $03, $06, $06, $03, $03, $0F, dKick
	dc.b $0C, nRst, $0C, dKick, dKick, $06, dSnare, dSnare
	dc.b dSnare, $03, $03
music86_Loop1:
	dc.b dKick, $0C, dSnare, dKick, dSnare, dKick, dSnare, $01
	dc.b dMidTimpani, $05, dHiTimpani, $06, dKick, $01, dMidTimpani, $05
	dc.b dHiTimpani, $06, dSnare, $01, dMidTimpani, $05, dHiTimpani, $06
	smpsLoop	$00, $02, music86_Loop1
	dc.b dKick, $0C, dSnare, dKick, dSnare, dKick, dSnare, dKick
	dc.b dSnare, $06, dHiTimpani, $03, dHiTimpani, dKick, $0C, dSnare
	dc.b dKick, dSnare, dKick, $06, dHiTimpani, dSnare, $01, dMidTimpani
	dc.b $05, dHiTimpani, $06, dKick, $01, dMidTimpani, $05, dSnare
	dc.b $01, dHiTimpani, $05, dSnare, $01, dMidTimpani, $05, dSnare
	dc.b $03, $03
	smpsLoop	$01, $02, music86_Loop1

music86_Loop2:
	dc.b dSnare, $03, dSnare, dKick, dKick, dKick, dKick, dSnare
	dc.b dSnare, dKick, dKick, dKick, dKick, dSnare, dSnare, dSnare
	dc.b dSnare
	smpsLoop	$00, $02, music86_Loop2

music86_Loop4:
	smpsCall	music86_Call1
	dc.b dHiTimpani, $02, dKick, $01, dMidTimpani, $05, dSnare, $01
	dc.b dHiTimpani, $05, dMidTimpani, $06
	smpsCall	music86_Call1
	dc.b dMidTimpani, $02, dSnare, $01, dHiTimpani, $05, dSnare, $01
	dc.b dMidTimpani, $05, dSnare, $01, dHiTimpani, $02, dSnare, $03
	smpsLoop	$01, $02, music86_Loop4
	smpsJump	music86_Jump1

music86_Call1:
music86_Loop3:
	dc.b dKick, $0C, dSnare, $09, dKick, $06, $03, dKick
	dc.b $01, dHiTimpani, $02, dMidTimpani, $03, dSnare, $01, dHiTimpani
	dc.b $0B
	smpsLoop	$00, $03, music86_Loop3
	dc.b dKick, $0C, dSnare, $09, dKick, $06, dSnare, $01
	smpsReturn

music86_Call2:
music86_Loop5:
	dc.b nA6, $1E, nG6, $06, nF6, nG6, nE6, $30
	dc.b nG6, $1E, nF6, $06, nE6, nF6, nD6, $30
	dc.b nF6, $1E, nEb6, $06, nD6, nEb6, nC6, $18
	dc.b nD6, nE6, $03, nF6, nE6, $5A
	smpsLoop	$00, $02, music86_Loop5
	smpsReturn

music86_Call5:
	dc.b nG6, $1E, nE6, $06, nC6, nC7, nBb6, $0C
	dc.b nC7, $06, nBb6, $0C, nG6, $06, nBb6, nA6
	dc.b $24, nE6, $06, nF6, nG6, $12, nA6, $06
	dc.b nG6, $12, nE6, $0C, nG6, $1E, nE6, $06
	dc.b nC6, nC7, nBb6, $0C, nC7, $06, nBb6, $0C
	dc.b nG6, $06, nBb6, nA6, $24, nE6, $06, nF6
	dc.b nG6, $30, nRst, $06
	smpsReturn

music86_Call3:
	smpsCall	music86_Call4
	dc.b nG4, nG4, $09
	smpsCall	music86_Call4
	dc.b nRst, $0C
	smpsReturn

music86_Call4:
	dc.b nA4, $03, nA4, nAb4, nAb4, nG4, nG4, nA4
	dc.b nA4, nAb4, nAb4, nG4, nG4
	smpsReturn

music86_Voices:
	; Voice $00
	; $08
	; $0A, $70, $30, $00,	$1F, $1F, $5F, $5F
	; $12, $0E, $0A, $0A,	$00, $04, $04, $03
	; $2F, $2F, $2F, $2F,	$24, $2D, $13, $80
	smpsVcAlgorithm	$00
	smpsVcFeedback	$01
	smpsVcDetune	$00, $03, $07, $00
	smpsVcCoarseFreq	$00, $00, $00, $0A
	smpsVcRateScale	$01, $01, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0A, $0A, $0E, $12
	smpsVcDecayRate2	$03, $04, $04, $00
	smpsVcDecayLevel	$02, $02, $02, $02
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $13, $2D, $24

	; Voice $01
	; $2C
	; $74, $74, $34, $34,	$1F, $12, $1F, $1F
	; $00, $04, $00, $04,	$00, $09, $00, $09
	; $00, $08, $00, $08,	$16, $80, $17, $80
	smpsVcAlgorithm	$04
	smpsVcFeedback	$05
	smpsVcDetune	$03, $03, $07, $07
	smpsVcCoarseFreq	$04, $04, $04, $04
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $12, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$04, $00, $04, $00
	smpsVcDecayRate2	$09, $00, $09, $00
	smpsVcDecayLevel	$00, $00, $00, $00
	smpsVcReleaseRate	$08, $00, $08, $00
	smpsVcTotalLevel	$00, $17, $00, $16

	; Voice $02
	; $3D
	; $01, $02, $02, $02,	$14, $0E, $8C, $0E
	; $08, $05, $02, $05,	$00, $08, $08, $08
	; $1F, $1F, $1F, $1F,	$1A, $92, $A7, $80
	smpsVcAlgorithm	$05
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$02, $02, $02, $01
	smpsVcRateScale	$00, $02, $00, $00
	smpsVcAttackRate	$0E, $0C, $0E, $14
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$05, $02, $05, $08
	smpsVcDecayRate2	$08, $08, $08, $00
	smpsVcDecayLevel	$01, $01, $01, $01
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $27, $12, $1A

	; Voice $03
	; $29
	; $36, $74, $71, $31,	$04, $04, $05, $1D
	; $12, $0E, $1F, $1F,	$04, $06, $03, $01
	; $5F, $6F, $0F, $0F,	$27, $27, $2E, $80
	smpsVcAlgorithm	$01
	smpsVcFeedback	$05
	smpsVcDetune	$03, $07, $07, $03
	smpsVcCoarseFreq	$01, $01, $04, $06
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1D, $05, $04, $04
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$1F, $1F, $0E, $12
	smpsVcDecayRate2	$01, $03, $06, $04
	smpsVcDecayLevel	$00, $00, $06, $05
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $2E, $27, $27

	; Voice $04
	; $3D
	; $01, $01, $01, $01,	$8E, $52, $14, $4C
	; $08, $08, $0E, $03,	$00, $00, $00, $00
	; $1F, $1F, $1F, $1F,	$1B, $80, $80, $9B
	smpsVcAlgorithm	$05
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$01, $01, $01, $01
	smpsVcRateScale	$01, $00, $01, $02
	smpsVcAttackRate	$0C, $14, $12, $0E
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$03, $0E, $08, $08
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$01, $01, $01, $01
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$1B, $00, $00, $1B

	; Voice $05
	; $30
	; $30, $30, $30, $30,	$9E, $D8, $DC, $DC
	; $0E, $0A, $04, $05,	$08, $08, $08, $08
	; $BF, $BF, $BF, $BF,	$14, $3C, $14, $80
	smpsVcAlgorithm	$00
	smpsVcFeedback	$06
	smpsVcDetune	$03, $03, $03, $03
	smpsVcCoarseFreq	$00, $00, $00, $00
	smpsVcRateScale	$03, $03, $03, $02
	smpsVcAttackRate	$1C, $1C, $18, $1E
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$05, $04, $0A, $0E
	smpsVcDecayRate2	$08, $08, $08, $08
	smpsVcDecayLevel	$0B, $0B, $0B, $0B
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $14, $3C, $14

	; Voice $06
	; $3D
	; $01, $02, $00, $01,	$1F, $0E, $0E, $0E
	; $07, $1F, $1F, $1F,	$00, $00, $00, $00
	; $1F, $0F, $0F, $0F,	$17, $8D, $8C, $8C
	smpsVcAlgorithm	$05
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$01, $00, $02, $01
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$0E, $0E, $0E, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$1F, $1F, $1F, $07
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$00, $00, $00, $01
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$0C, $0C, $0D, $17
