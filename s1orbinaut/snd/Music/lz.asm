music82_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	music82_Voices
	smpsHeaderChan	$06, $03
	smpsHeaderTempo	$02, $06
	smpsHeaderDAC	music82_DAC
	smpsHeaderFM	music82_FM1, $F4, $0C
	smpsHeaderFM	music82_FM2, $E8, $0D
	smpsHeaderFM	music82_FM3, $F4, $18
	smpsHeaderFM	music82_FM4, $F4, $18
	smpsHeaderFM	music82_FM5, $00, $12
	smpsHeaderPSG	music82_PSG1, $D0, $02, $00, VolEnv_09
	smpsHeaderPSG	music82_PSG2, $D0, $02, $00, VolEnv_09
	smpsHeaderPSG	music82_PSG3, $00, $02, $00, VolEnv_04

music82_FM1:
	smpsSetvoice	$00
	dc.b nRst, $30

music82_Loop2:
music82_Jump2:
	dc.b nRst, $06, nE5, nG5, nE5, nG5, $09, nA5
	dc.b nB5, $0C, nC6, $06, nB5, nA5, nG5, $09
	dc.b nA5, $06, nG5, $03, nE5, $06
	smpsLoop	$00, $02, music82_Loop2
	smpsCall	music82_Call2
	dc.b nC6, $09, nD6, $06, nC6, $03, nA5, $06
	smpsCall	music82_Call2
	dc.b nC6, $0C, nA5, nD6, $04, nC6, nD6, nC6
	dc.b $24, nRst, $30
	smpsCall	music82_Call3
	dc.b nC6, $0C, nC6, $06, nC6, nD6, $09, nC6
	dc.b nE6, $36
	smpsCall	music82_Call3
	dc.b nF6, $06, nE6, nD6, nC6, nBb5, nA5, nG5
	dc.b nF5, nE5, nC6, $12, nRst, $18
	smpsJump	music82_Jump2

music82_Call2:
	dc.b nRst, nA5, nC6, nA5, nC6, $09, nD6, nE6
	dc.b $0C, nF6, $06, nE6, nD6
	smpsReturn

music82_Call3:
	dc.b nC6, $0C, nC6, $06, nC6, nD6, $09, nC6
	dc.b nF6, $0C, nE6, $06, nD6, nC6, nD6, $09
	dc.b nE6, $0F
	smpsReturn

music82_FM2:
	smpsSetvoice	$01
	dc.b nRst, $12, nD4, $0C, nG4, $03, nRst, nG4
	dc.b nRst, $09

music82_Loop3:
music82_Jump3:
	dc.b nC4, $0F, nRst, $03, nE4, nRst, nG4, $09
	dc.b nRst, $03, nA4, $09, nRst, $03, nB4, $0F
	dc.b nRst, $03, nA4, nRst, nG4, $09, nRst, $03
	dc.b nE4, $09, nRst, $03
	smpsLoop	$00, $02, music82_Loop3

music82_Loop4:
	dc.b nF4, $0F, nRst, $03, nA4, nRst, nC5, $09
	dc.b nRst, $03, nD5, $09, nRst, $03, nE5, $0F
	dc.b nRst, $03, nD5, nRst, nC5, $09, nRst, $03
	dc.b nA4, $09, nRst, $03
	smpsLoop	$00, $02, music82_Loop4
	dc.b nC4, $0F, nRst, $03, nE4, nRst, nG4, $09
	dc.b nRst, $03, nE4, $09, nRst, $03, nC5, nRst
	dc.b nC5, $06, nG4, nC5, nFs4, $18
	smpsCall	music82_Call4
	dc.b nE4, nRst, nRst, nE4, nA4, nRst, nRst, nA4
	dc.b nA4, $18
	smpsCall	music82_Call4
	dc.b nBb4, nRst, nRst, nBb4, nC5, nRst, nRst, nC5
	dc.b nG4, $0C, nG4
	smpsJump	music82_Jump3

music82_Call4:
	dc.b nF4, $06, nRst, nRst, nF4, nE4, nRst, nRst
	dc.b nE4, nD4, nRst, nRst, nD4, nC4, nD4, nE4
	dc.b $0C, nF4, $06, nRst, nRst, nF4
	smpsReturn

music82_FM3:
	smpsPan	panLeft, $00
	smpsCall	music82_Call5
	smpsModSet	$01, $01, $01, $04

music82_Jump4:
	dc.b nRst, $60, nRst, nRst, nRst, nRst, nE6, $48
	dc.b nF6, $0C, nG6, nC6, $30, nRst, nE6, $48
	dc.b nF6, $0C, nG6, nC6, $18, nD6, nE6, nG6
	smpsJump	music82_Jump4

music82_Call5:
	smpsSetvoice	$03
	smpsNoteFill	$08
	dc.b nA6, $06, nF6, nD6
	smpsNoteFill	$00
	dc.b nG6, $0A, nRst, $02, nG6, $03, nRst, nG6
	dc.b nRst, $09
	smpsReturn

music82_FM4:
	smpsPan	panRight, $00
	smpsAlterNote	$02
	smpsCall	music82_Call5
	smpsModSet	$02, $01, $02, $04
	smpsJump	music82_Jump4

music82_FM5:
	smpsSetvoice	$02
	smpsNoteFill	$08
	dc.b nC5, $06, nA4, nF4
	smpsNoteFill	$00
	dc.b nC5, $09, nRst, $03, nC5, nRst, nC5, nRst
	dc.b $09
	smpsFMAlterVol	$03

music82_Jump5:
	smpsSetvoice	$04
	dc.b nRst, $4E, nG4, $03, nA4, nC5, nRst, nA4
	dc.b nRst, $51, nE5, $03, nC5, nA4, nRst, nC5
	dc.b nRst, $51, nC5, $03, nD5, nF5, nRst, nD5
	dc.b nRst, $51, nA5, $03, nF5, nC5, nRst, nF5
	dc.b nRst, $39, nG4, $06, nRst, nA4, nRst, nBb4
	dc.b $03, nRst, nBb4, nRst, nCs5, nRst
	smpsNoteFill	$0A
	smpsCall	music82_Call6
	dc.b nRst, $06, nA4, nRst, nB4, nRst, nCs5, nCs5
	dc.b nE5
	smpsCall	music82_Call6
	smpsNoteFill	$05
	dc.b nRst, $06, nG4, $03, nA4

music82_Loop5:
	dc.b nC5, nC5, nA4, nG4
	smpsLoop	$00, $03, music82_Loop5
	smpsNoteFill	$00
	smpsJump	music82_Jump5

music82_Call6:
	dc.b nE5, $12, $06, nD5, $12, $06, nC5, $12
	dc.b $06, nB4, nC5
	smpsNoteFill	$14
	dc.b nD5, $0C
	smpsNoteFill	$0A
	dc.b nE5, $12, $06, nD5, $12, $06
	smpsReturn

music82_PSG1:
	dc.b nA6, $03, nA6, nF6, nF6, nD6, nD6, $21
music82_Loop6:
music82_Jump6:
	smpsCall	music82_Call7
	smpsAlterPitch	$05
	smpsLoop	$00, $02, music82_Loop6
	smpsAlterPitch	$F6
	dc.b nRst, $06, nE6, $0C, $0C, $0C, $06, nRst
	dc.b $06, nE6, $03, $09, $0C, nBb6, nBb6, $06
	smpsCall	music82_Call8
	dc.b nG6, $03, $09, $06, nRst, $06, nB6, $0C
	dc.b $0C, $03, $09, $06
	smpsCall	music82_Call8
	dc.b nBb6, $03, $09, $06, nRst, $06, nE6, $0C
	dc.b $06, nD6, nF6, nA6, $0C
	smpsJump	music82_Jump6

music82_Call7:
	dc.b nRst, $06, nE6, $0C, $0C, $0C, $06, nRst
	dc.b nE6, $0C, $0C, $03, $09, $06, nRst, nE6
	dc.b $0C, $0C, $0C, $06, nRst, nE6, $0C, $0C
	dc.b $03, $09, $06
	smpsReturn

music82_Call8:
	dc.b nRst, $06, nA6, $0C, nA6, nG6, $03, $09
	dc.b $06, nRst, nF6, $0C, $0C, nE6, $03, $09
	dc.b $06, nRst, nA6, $0C, $0C
	smpsReturn

music82_PSG2:
	dc.b nC7, $03, nC7, nA6, nA6, nF6, nF6, $21
music82_Jump7:
	smpsAlterPitch	$03

music82_Loop7:
	smpsCall	music82_Call7
	smpsAlterPitch	$05
	smpsLoop	$00, $02, music82_Loop7
	smpsAlterPitch	$F3
	dc.b nRst, $06, nG6, $0C, $0C, $0C, $06, nRst
	dc.b $06, nG6, $03, $09, $0C, nCs7, $0C, $06
	smpsCall	music82_Call9
	dc.b nB6, $03, $09, $06, nRst, $06, nD7, $0C
	dc.b $0C, nCs7, $03, $09, $06
	smpsCall	music82_Call9
	dc.b nD7, $03, $09, $06, nRst, $06, nG6, $0C
	dc.b $06, nF6, $06, nA6, nC7, $0C
	smpsJump	music82_Jump7

music82_Call9:
	dc.b nRst, $06, nC7, $0C, $0C, nB6, $03, $09
	dc.b $06, nRst, nA6, $0C, $0C, nG6, $03, $09
	dc.b $06, nRst, nC7, $0C, $0C
	smpsReturn

music82_PSG3:
	smpsPSGform	$E7
	dc.b nRst, $12
	smpsNoteFill	$0E
	dc.b nA5, $0C
	smpsNoteFill	$03
	dc.b $06, $0C

music82_Jump8:
	smpsCall	music82_Call10
	smpsCall	music82_Call11
	smpsCall	music82_Call10
	smpsNoteFill	$0E
	dc.b $0C
	smpsNoteFill	$03
	dc.b $06, $06, $03, $03, $06, $03, $03, $06
	smpsCall	music82_Call10
	smpsCall	music82_Call11
	smpsCall	music82_Call10
	smpsCall	music82_Call10
	smpsCall	music82_Call10
	smpsCall	music82_Call10
	smpsCall	music82_Call12
	dc.b $03, $03
	smpsNoteFill	$0E
	dc.b $06
	smpsNoteFill	$03
	dc.b $03, $03
	smpsNoteFill	$0E
	dc.b $06
	smpsCall	music82_Call12
	smpsPSGAlterVol	$FF
	smpsNoteFill	$0E
	dc.b $0C, $0C
	smpsPSGAlterVol	$01
	smpsJump	music82_Jump8

music82_Call10:
	smpsNoteFill	$0E
	dc.b $0C
	smpsNoteFill	$03
	dc.b $06, $06, $06, $06, $06, $06
	smpsReturn

music82_Call11:
	smpsNoteFill	$0E
	dc.b $0C
	smpsNoteFill	$03
	dc.b $06, $06, $06, $06, $06, $03, $03
	smpsReturn

music82_Call12:
	dc.b nRst, $03
	smpsNoteFill	$03
	dc.b nA5, $06, $06, $03
	smpsNoteFill	$0E
	dc.b $06
	smpsNoteFill	$03
	dc.b $06, $06, $06, $06, $06, $06, $06, $06
	smpsNoteFill	$03
	dc.b $06, $06, $06
	smpsNoteFill	$0E
	dc.b $06
	smpsNoteFill	$03
	dc.b $06, $06, $06, $06, $06, $06, $06, $06
	dc.b $06, $06, $06, $06
	smpsReturn

music82_DAC:
	dc.b dSnare, $06, dSnare, dSnare, dKick, $0C, dSnare, $06
	dc.b $0C
music82_Loop1:
music82_Jump1:
	dc.b dKick, $12, dKick, $06, dKick, $0C, dSnare
	smpsLoop	$00, $09, music82_Loop1
	dc.b dKick, $12, dKick, $06, dKick, dSnare, dSnare, dSnare
	smpsCall	music82_Call1
	dc.b dKick, $0C, dSnare, $06, dKick, dKick, $06, dSnare
	dc.b dSnare, $0C
	smpsCall	music82_Call1
	dc.b dKick, $0C, dSnare, $06, dKick, dKick, dSnare, dSnare
	dc.b dSnare
	smpsJump	music82_Jump1

music82_Call1:
	dc.b dKick, $0C, dSnare, $06, dKick, dKick, $0C, dSnare
	dc.b dKick, $0C, dSnare, $06, dKick, dKick, $0C, dSnare
	dc.b dKick, $0C, dSnare, $06, dKick, dKick, $0C, dSnare
	smpsReturn

music82_Voices:
	; Voice $00
	; $31
	; $34, $35, $30, $31,	$DF, $DF, $9F, $9F
	; $0C, $07, $0C, $09,	$07, $07, $07, $08
	; $2F, $1F, $1F, $2F,	$17, $32, $14, $80
	smpsVcAlgorithm	$01
	smpsVcFeedback	$06
	smpsVcDetune	$03, $03, $03, $03
	smpsVcCoarseFreq	$01, $00, $05, $04
	smpsVcRateScale	$02, $02, $03, $03
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$09, $0C, $07, $0C
	smpsVcDecayRate2	$08, $07, $07, $07
	smpsVcDecayLevel	$02, $01, $01, $02
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $14, $32, $17

	; Voice $01
	; $18
	; $37, $30, $30, $31,	$9E, $DC, $1C, $9C
	; $0D, $06, $04, $01,	$08, $0A, $03, $05
	; $BF, $BF, $3F, $2F,	$2C, $22, $14, $80
	smpsVcAlgorithm	$00
	smpsVcFeedback	$03
	smpsVcDetune	$03, $03, $03, $03
	smpsVcCoarseFreq	$01, $00, $00, $07
	smpsVcRateScale	$02, $00, $03, $02
	smpsVcAttackRate	$1C, $1C, $1C, $1E
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$01, $04, $06, $0D
	smpsVcDecayRate2	$05, $03, $0A, $08
	smpsVcDecayLevel	$02, $03, $0B, $0B
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $14, $22, $2C

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

	; Voice $04
	; $3C
	; $31, $52, $50, $30,	$52, $53, $52, $53
	; $08, $00, $08, $00,	$04, $00, $04, $00
	; $1F, $0F, $1F, $0F,	$1A, $80, $16, $80
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
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $16, $00, $1A
