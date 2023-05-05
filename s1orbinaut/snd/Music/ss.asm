music89_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	music89_Voices
	smpsHeaderChan	$07, $03
	smpsHeaderTempo	$02, $08
	smpsHeaderDAC	music89_DAC
	smpsHeaderFM	music89_FM1, $DC, $18
	smpsHeaderFM	music89_FM2, $DC, $0C
	smpsHeaderFM	music89_FM3, $E8, $18
	smpsHeaderFM	music89_FM4, $E8, $18
	smpsHeaderFM	music89_FM5, $E8, $18
	smpsHeaderFM	music89_FM6, $E8, $14
	smpsHeaderPSG	music89_PSG1, $DC, $03, $00, VolEnv_04
	smpsHeaderPSG	music89_PSG2, $FD, $01, $00, VolEnv_08
	smpsHeaderPSG	music89_PSG3, $DC, $04, $00, VolEnv_04

music89_FM1:
	smpsSetvoice	$00

music89_Loop1:
music89_Jump1:
	dc.b nE5, $18, nF5, $0C, nG5, $18, nE5, $0C
	dc.b $18, nC5, $0C, nE5, $18, nC5, $0C, nE5
	dc.b $18, nF5, $0C, nG5, $18, nE5, $0C, nC5
	dc.b $18, nD5, $0C, nC5, $24
	smpsLoop	$00, $02, music89_Loop1
	dc.b smpsNoAttack, $03, nRst, $09, nD5, $0C, nE5, nF5
	dc.b nE5, nF5, nG5, $18, nE5, $0C, nC5, $24
	dc.b nRst, $0C, nD5, nE5, nF5, nE5, nF5, nG5
	dc.b $18, nA5, $0C, nG5, $21, nRst, $03
	smpsJump	music89_Jump1

music89_FM2:
	smpsSetvoice	$02

music89_Loop2:
music89_Jump2:
	dc.b nF5, $0C, nRst, $18, nE5, $0C, nRst, $18
	dc.b nD5, $0C, nRst, $18, nC5, $0C, nD5, nE5
	dc.b nF5, $0C, nRst, $18, nE5, $0C, nRst, $18
	dc.b nD5, $12, nE5, $06, nD5, $0C, nC5, $24
	smpsLoop	$00, $02, music89_Loop2
	dc.b nBb4, $0C, nRst, $18, nBb4, $0C, nRst, $18
	dc.b nC5, $0C, nRst, $18, nC5, $0C, nRst, $18
	dc.b nBb4, $0C, nRst, $18, nBb4, $0C, nRst, $18
	dc.b nD5, $0C, nRst, $18, nG5, $24
	smpsJump	music89_Jump2

music89_FM3:
	smpsSetvoice	$03
	smpsModSet	$1A, $01, $04, $06
	smpsPan	panCentre, $00

music89_Loop3:
music89_Jump3:
	smpsCall	music89_Call1
	dc.b nRst, nC7, $03, nRst, $09, nC7, $0C, nB6
	dc.b nC7, nD7
	smpsCall	music89_Call1
	dc.b nC7, $12, nD7, $06, nC7, $0C, nB6, $24
	smpsLoop	$00, $02, music89_Loop3
	smpsCall	music89_Call2
	dc.b nRst, nB6, $03, nRst, $09, nB6, $0C, nRst
	dc.b nB6, $03, nRst, $09, nB6, $0C
	smpsCall	music89_Call2
	dc.b nRst, nC7, $03, nRst, $09, nC7, $0C, $24
	smpsJump	music89_Jump3

music89_Call1:
	dc.b nRst, $0C, nE7, $03, nRst, $09, nE7, $0C
	dc.b nRst, nD7, $03, nRst, $09, nD7, $0C
	smpsReturn

music89_Call2:
	dc.b nRst, $0C, nA6, $03, nRst, $09, nA6, $0C
	dc.b nRst, nA6, $03, nRst, $09, nA6, $0C
	smpsReturn

music89_FM4:
	smpsSetvoice	$03
	smpsModSet	$1A, $01, $04, $06
	smpsPan	panRight, $00

music89_Loop4:
music89_Jump4:
	smpsCall	music89_Call3
	dc.b nRst, nA6, $03, nRst, $09, nA6, $0C, nG6
	dc.b nA6, nB6
	smpsCall	music89_Call3
	dc.b nA6, $12, nB6, $06, nA6, $0C, nG6, $24
	smpsLoop	$00, $02, music89_Loop4
	smpsCall	music89_Call4
	dc.b nRst, nG6, $03, nRst, $09, nG6, $0C, nRst
	dc.b nG6, $03, nRst, $09, nG6, $0C
	smpsCall	music89_Call4
	dc.b nRst, nA6, $03, nRst, $09, nA6, $0C, $24
	smpsJump	music89_Jump4

music89_Call3:
	dc.b nRst, $0C, nC7, $03, nRst, $09, nC7, $0C
	dc.b nRst, nB6, $03, nRst, $09, nB6, $0C
	smpsReturn

music89_Call4:
	dc.b nRst, $0C, nF6, $03, nRst, $09, nF6, $0C
	dc.b nRst, nF6, $03, nRst, $09, nF6, $0C
	smpsReturn

music89_FM5:
	smpsSetvoice	$03
	smpsModSet	$1A, $01, $04, $06
	smpsPan	panLeft, $00

music89_Loop5:
music89_Jump5:
	smpsCall	music89_Call5
	dc.b nRst, nF6, $03, nRst, $09, nF6, $0C, nE6
	dc.b nF6, nG6
	smpsCall	music89_Call5
	dc.b nF6, $12, nG6, $06, nF6, $0C, nE6, $24
	smpsLoop	$00, $02, music89_Loop5
	smpsCall	music89_Call6
	dc.b nRst, nE6, $03, nRst, $09, nE6, $0C, nRst
	dc.b nE6, $03, nRst, $09, nE6, $0C
	smpsCall	music89_Call6
	dc.b nRst, nF6, $03, nRst, $09, nF6, $0C, $24
	smpsJump	music89_Jump5

music89_Call5:
	dc.b nRst, $0C, nA6, $03, nRst, $09, nA6, $0C
	dc.b nRst, nG6, $03, nRst, $09, nG6, $0C
	smpsReturn

music89_Call6:
	dc.b nRst, $0C, nD6, $03, nRst, $09, nD6, $0C
	dc.b nRst, nD6, $03, nRst, $09, nD6, $0C
	smpsReturn

music89_PSG1:
	smpsNoteFill	$06

music89_Loop7:
music89_Jump7:
	smpsCall	music89_Call7
	dc.b nC6, $06, $06, nA5, $03, nRst, $09, nF5
	dc.b $03, nRst, $09, nB5, $03, nRst, $21
	smpsCall	music89_Call7
	dc.b nC6, $03, nRst, $15, nD6, $03, nRst, $09
	dc.b nC6, $03, nRst, $21
	smpsLoop	$00, $02, music89_Loop7
	smpsCall	music89_Call8
	dc.b nB6, $06, $06, nG6, nG6, nE6, nE6, nB6
	dc.b nB6, nG6, nG6, nE6, $03, nRst, $09
	smpsCall	music89_Call8
	dc.b nC7, $06, $06, nA6, nA6, nF6, nF6, nG6
	dc.b $09, nRst, $1B
	smpsJump	music89_Jump7

music89_Call7:
	dc.b nE6, $06, $06, nC6, $03, nRst, $09, nA5
	dc.b $03, nRst, $09, nD6, $06, $06, nB5, $03
	dc.b nRst, $09, nG5, $03, nRst, $09
	smpsReturn

music89_Call8:
	dc.b nA6, $06, $06, nF6, nF6, nD6, nD6, nA6
	dc.b nA6, nF6, nF6, nD6, $03, nRst, $09
	smpsReturn

music89_PSG2:
music89_Jump8:
	dc.b nRst, $0C, nC5, nC5, nRst, nC5, nC5, nRst
	dc.b nC5, nC5, nRst, nC5, $06, $06, $0C, nRst
	dc.b nC5, nC5, nRst, nC5, nC5, nRst, nC5, nC5
	dc.b nC5, $24
	smpsJump	music89_Jump8

music89_DAC:
music89_PSG3:
	smpsStop

music89_FM6:
	smpsSetvoice	$01

music89_Loop6:
music89_Jump6:
	dc.b nE7, $18, nF7, $0C, nG7, $18, nE7, $0C
	dc.b $18, nC7, $0C, nE7, $18, nC7, $0C, nE7
	dc.b $18, nF7, $0C, nG7, $18, nE7, $0C, nC7
	dc.b $18, nD7, $0C, nC7, $24
	smpsLoop	$00, $02, music89_Loop6
	dc.b nRst, $0C, nD7, nE7, nF7, nE7, nF7, nG7
	dc.b $18, nE7, $0C, nC7, $24, nRst, $0C, nD7
	dc.b nE7, nF7, nE7, nF7, nG7, $18, nA7, $0C
	dc.b nG7, $21, nRst, $03
	smpsJump	music89_Jump6

music89_Voices:
	; Voice $00
	; $2C
	; $74, $74, $34, $34,	$1F, $12, $1F, $1F
	; $00, $00, $00, $00,	$00, $01, $00, $01
	; $00, $36, $00, $36,	$16, $80, $17, $80
	smpsVcAlgorithm	$04
	smpsVcFeedback	$05
	smpsVcDetune	$03, $03, $07, $07
	smpsVcCoarseFreq	$04, $04, $04, $04
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $12, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$00, $00, $00, $00
	smpsVcDecayRate2	$01, $00, $01, $00
	smpsVcDecayLevel	$03, $00, $03, $00
	smpsVcReleaseRate	$06, $00, $06, $00
	smpsVcTotalLevel	$00, $17, $00, $16

	; Voice $01
	; $2C
	; $72, $78, $34, $34,	$1F, $12, $1F, $12
	; $00, $0A, $00, $0A,	$00, $00, $00, $00
	; $00, $16, $00, $16,	$16, $80, $17, $80
	smpsVcAlgorithm	$04
	smpsVcFeedback	$05
	smpsVcDetune	$03, $03, $07, $07
	smpsVcCoarseFreq	$04, $04, $08, $02
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$12, $1F, $12, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0A, $00, $0A, $00
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$01, $00, $01, $00
	smpsVcReleaseRate	$06, $00, $06, $00
	smpsVcTotalLevel	$00, $17, $00, $16

	; Voice $02
	; $30
	; $30, $30, $30, $30,	$9E, $D8, $DC, $DC
	; $0E, $0A, $04, $05,	$08, $08, $08, $08
	; $B0, $B0, $B0, $B5,	$14, $3C, $14, $80
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
	smpsVcReleaseRate	$05, $00, $00, $00
	smpsVcTotalLevel	$00, $14, $3C, $14

	; Voice $03
	; $3D
	; $01, $02, $00, $01,	$1F, $10, $10, $10
	; $07, $1F, $1F, $1F,	$00, $00, $00, $00
	; $10, $07, $07, $07,	$17, $80, $80, $80
	smpsVcAlgorithm	$05
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$01, $00, $02, $01
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$10, $10, $10, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$1F, $1F, $1F, $07
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$00, $00, $00, $01
	smpsVcReleaseRate	$07, $07, $07, $00
	smpsVcTotalLevel	$00, $00, $00, $17
