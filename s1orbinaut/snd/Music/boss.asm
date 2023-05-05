music8C_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	music8C_Voices
	smpsHeaderChan	$06, $03
	smpsHeaderTempo	$02, $04
	smpsHeaderDAC	music8C_DAC
	smpsHeaderFM	music8C_FM1, $F4, $12
	smpsHeaderFM	music8C_FM2, $E8, $08
	smpsHeaderFM	music8C_FM3, $F4, $0F
	smpsHeaderFM	music8C_FM4, $F4, $12
	smpsHeaderFM	music8C_FM5, $E8, $0F
	smpsHeaderPSG	music8C_PSG1, $D0, $03, $00, VolEnv_05
	smpsHeaderPSG	music8C_PSG2, $D0, $03, $00, VolEnv_05
	smpsHeaderPSG	music8C_PSG3, $DC, $01, $00, VolEnv_08

music8C_FM5:
	smpsSetvoice	$05

music8C_Jump6:
	dc.b nFs7, $0C, nFs7, nFs7, nFs7
	smpsFMAlterVol	$02
	smpsCall	music8C_Call4
	dc.b nA6, nFs6, nG6, nFs6, nE6, nFs6, nA6, nFs6
	dc.b nG6, nFs6, nCs7, nFs6, nE6, nFs6
	smpsCall	music8C_Call4
	dc.b nB6, nFs6, nA6, nFs6, nG6, nFs6, nA6, nFs6
	dc.b nB6, nFs6, nCs7, nB6, nF7, nCs7
	smpsFMAlterVol	$FE

music8C_Loop2:
	dc.b nFs7, $03, nD7, $03, nFs7, $03, nD7, $03
	smpsLoop	$00, $04, music8C_Loop2
	smpsJump	music8C_Jump6

music8C_Call4:
	dc.b nB6, $06, nFs6, nD7, nFs6, nB6, nFs6, nE6
	dc.b nFs6, nB6, nFs6, nD7, nFs6, nB6, nFs6, nA6
	dc.b nFs6, nG6, nFs6
	smpsReturn

music8C_FM2:
	smpsSetvoice	$00

music8C_Jump4:
	dc.b nFs4, $06, nFs5, nFs4, nFs5, nFs4, nFs5, nFs4
	dc.b nFs5
	smpsCall	music8C_Call2
	dc.b nB3, $06, nE4, nE4, $0C, nB3, $06
	smpsCall	music8C_Call2
	dc.b nE4, $06, nD4, nD4, $0C, nD4, $06, nCs4
	dc.b $30
	smpsJump	music8C_Jump4

music8C_Call2:
	dc.b nB3, $06, nB3, nD4, nD4, nCs4, nCs4, nC4
	dc.b nC4, nB3, $12, nFs4, $06, nB4, $0C, nA4
	dc.b nG4, $06, nG4, $0C, nD4, $06, nG4, nG4
	dc.b $0C, nFs4, $06, nE4, nE4, $0C
	smpsReturn

music8C_PSG2:
	smpsAlterNote	$02
	smpsJump	music8C_Jump5

music8C_FM3:
	smpsSetvoice	$01
	smpsPan	panLeft, $00

music8C_Jump5:
	dc.b nRst, $30
	smpsCall	music8C_Call3
	dc.b nE5, $12, nRst, nD6, $03, nRst, nCs6, nRst
	dc.b nA5, $12
	smpsCall	music8C_Call3
	dc.b nE5, $0C, nB5, $03, nRst, nE6, nRst, nE6
	dc.b $0C, nE6, $03, nRst, nF6, nRst, nF6, $0C
	dc.b nF6, $03, nRst, nFs6, $30
	smpsJump	music8C_Jump5

music8C_Call3:
	dc.b nRst, $1E, nFs5, $03, nRst, nB5, nRst, nCs6
	dc.b nRst, nD6, $30, nRst, $12, nB5, $03, nRst
	dc.b nG5, nRst
	smpsReturn

music8C_FM1:
	smpsAlterNote	$03
	smpsJump	music8C_Jump2

music8C_FM4:
	smpsPan	panRight, $00

music8C_Jump2:
	smpsSetvoice	$02
	smpsModSet	$0C, $01, $04, $06

music8C_PSG1:
music8C_Jump3:
	dc.b nRst, $30
	smpsCall	music8C_Call1
	dc.b nE7
	smpsCall	music8C_Call1
	dc.b nE7, $18, nF7, nFs7, $30
	smpsJump	music8C_Jump3

music8C_Call1:
	dc.b nB6, $04, nA6, nC7, nB6, $24, nRst, $0C
	dc.b nFs6, nB6, nCs7, nD7, $30
	smpsReturn

music8C_PSG3:
	smpsStop

music8C_DAC:
music8C_Jump1:
	dc.b dHiTimpani, $06, dLowTimpani, dHiTimpani, dLowTimpani, dHiTimpani, dLowTimpani, dHiTimpani
	dc.b dLowTimpani
music8C_Loop1:
	dc.b dSnare, $0C, dSnare, $04, dSnare, dSnare, dSnare, $06
	dc.b dSnare, $0C, dSnare, $06, dSnare, $12, dSnare, $06
	dc.b dSnare, $0C, dSnare, $0C
	smpsLoop	$00, $03, music8C_Loop1
	dc.b dSnare, $0C, dSnare, $04, dSnare, dSnare, dSnare, $06
	dc.b dSnare, $0C, dSnare, $06, dSnare, $06, dSnare, $0C
	dc.b dSnare, $06, dSnare, $06, dSnare, $0C, dSnare, $06
	dc.b dSnare, $01, dHiTimpani, $05, dLowTimpani, $06, dHiTimpani, dLowTimpani
	dc.b dHiTimpani, dLowTimpani, dHiTimpani, dLowTimpani
	smpsJump	music8C_Jump1

music8C_Voices:
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

	; Voice $02
	; $3D
	; $01, $02, $02, $02,	$14, $0E, $8C, $0E
	; $08, $05, $02, $05,	$00, $00, $00, $00
	; $1F, $1F, $1F, $1F,	$1A, $92, $A7, $80
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
	smpsVcTotalLevel	$00, $27, $12, $1A

	; Voice $03
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

	; Voice $04
	; $39
	; $01, $51, $00, $00,	$1F, $5F, $5F, $5F
	; $10, $11, $09, $09,	$07, $00, $00, $00
	; $2F, $2F, $2F, $1F,	$20, $22, $20, $80
	smpsVcAlgorithm	$01
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $05, $00
	smpsVcCoarseFreq	$00, $00, $01, $01
	smpsVcRateScale	$01, $01, $01, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$09, $09, $11, $10
	smpsVcDecayRate2	$00, $00, $00, $07
	smpsVcDecayLevel	$01, $02, $02, $02
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $20, $22, $20

	; Voice $05
	; $3A
	; $42, $43, $14, $71,	$1F, $12, $1F, $1F
	; $04, $02, $04, $0A,	$01, $01, $02, $0B
	; $1F, $1F, $1F, $1F,	$1A, $16, $19, $80
	smpsVcAlgorithm	$02
	smpsVcFeedback	$07
	smpsVcDetune	$07, $01, $04, $04
	smpsVcCoarseFreq	$01, $04, $03, $02
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $12, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0A, $04, $02, $04
	smpsVcDecayRate2	$0B, $02, $01, $01
	smpsVcDecayLevel	$01, $01, $01, $01
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $19, $16, $1A
