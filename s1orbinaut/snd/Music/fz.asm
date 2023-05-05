music8D_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	music8D_Voices
	smpsHeaderChan	$06, $03
	smpsHeaderTempo	$02, $06
	smpsHeaderDAC	music8D_DAC
	smpsHeaderFM	music8D_FM1, $00, $12
	smpsHeaderFM	music8D_FM2, $F4, $0D
	smpsHeaderFM	music8D_FM3, $F4, $0A
	smpsHeaderFM	music8D_FM4, $F4, $0F
	smpsHeaderFM	music8D_FM5, $00, $12
	smpsHeaderPSG	music8D_PSG1, $D0, $03, $00, VolEnv_05
	smpsHeaderPSG	music8D_PSG1, $DC, $06, $00, VolEnv_05
	smpsHeaderPSG	music8D_PSG1, $DC, $00, $00, VolEnv_04

music8D_FM5:
	smpsAlterNote	$03
	smpsJump	music8D_Jump6

music8D_FM1:
	smpsModSet	$1A, $01, $06, $04

music8D_Jump6:
	smpsSetvoice	$00
	dc.b nB6, $03, nRst, nAb6, nRst, nAb6, nRst, nB6
	dc.b nB6, nRst, $18

music8D_Jump2:
	dc.b nRst, $0C, nA5, nB5, nC6, nD6, nC6, nB5
	dc.b nC6, nE6, $60, nRst, $0C, nA5, nB5, nC6
	dc.b nD6, nC6, nB5, nC6, nF6, $30, nG6, $18
	dc.b nAb6, nA5, $0C, nA5, nA5, nA5, nB5, nB5
	dc.b nB5, nB5
	smpsJump	music8D_Jump2

music8D_FM2:
	smpsSetvoice	$01
	dc.b nE4, $03, nRst, nE3, nRst, nE3, nRst, nE4
	dc.b nE4, nRst, $12, nC4, $03, nB3

music8D_Jump3:
	smpsCall	music8D_Call1
	dc.b nC4, $03, nB3
	smpsCall	music8D_Call1
	dc.b nAb3, $06, nF3, $0C, nF3, $09, nF3, $03
	dc.b nF3, $06, nF3, $0C, nC3, $06, nG3, nG3
	dc.b $0C, nG3, $06, nE3, nE3, $0C, nC4, $03
	dc.b nB3
	smpsJump	music8D_Jump3

music8D_Call1:
	dc.b nA3, $0C, nA3, $09, nA3, $03, nA3, $06
	dc.b nA3, $0C, nE3, $06, nA3, $03, nE3, nA3
	dc.b $0C, nE3, $06, nA3, $0C, nG3, nF3, nF3
	dc.b $09, nF3, $03, nF3, $06, nF3, $0C, nC3
	dc.b $06, nG3, nG3, $0C, nG3, $06, nAb3, nAb3
	dc.b $0C
	smpsReturn

music8D_FM3:
	smpsSetvoice	$02
	dc.b nE7, $03, nRst, nE6, nRst, nE6, nRst, nE7
	dc.b nE7, $03, nRst, $18

music8D_Jump4:
	smpsCall	music8D_Call2
	dc.b nD7, $06, nRst, nC7, $03, nRst, nB6, nRst
	dc.b nAb6, $12
	smpsCall	music8D_Call2
	dc.b nD7, $06, nRst, nC7, $03, nRst, nB6, nRst
	dc.b nAb6, $12, nA5, $18, nB5, $0C, nC6, nB5
	dc.b $18, nC6, $0C, nD6
	smpsJump	music8D_Jump4

music8D_Call2:
	dc.b nRst, $1E, nA4, $03, nRst, nC5, nRst, nE5
	dc.b nRst, nA5, $03, nG5, nA5, $30, nC7, $06
	dc.b nRst, nA6, $03, nRst, nF6, nRst, nD6, $18
	smpsReturn

music8D_FM4:
	smpsSetvoice	$02
	smpsFMAlterVol	$FC
	smpsAlterNote	$03
	dc.b nE7, $03, nRst, nE6, nRst, nE6, nRst, nE7
	dc.b nE7, $03, nRst, $18
	smpsFMAlterVol	$04
	smpsSetvoice	$03

music8D_Loop2:
music8D_Jump5:
	dc.b nA4, $06, nE4, nB4, nE4, nC5, nE4, nB4
	dc.b nE4, nA4, nE4, nB4, nE4, nC5, nE4, nB4
	dc.b nE4, nA4, nE4, nB4, nE4, nC5, nE4, nA4
	dc.b nE4, nB4, nE4, nD5, nE4, nC5, nE4, nB4
	dc.b nE4
	smpsLoop	$00, $02, music8D_Loop2

music8D_Loop3:
	dc.b nC7, $03, nB6, nBb6, nA6
	smpsLoop	$00, $04, music8D_Loop3

music8D_Loop4:
	dc.b nD7, nCs7, nC7, nB6
	smpsLoop	$00, $04, music8D_Loop4
	smpsJump	music8D_Jump5

music8D_PSG1:
	smpsStop

music8D_DAC:
	dc.b dHiTimpani, $06, dLowTimpani, dLowTimpani, dHiTimpani, $03, dHiTimpani, $09
	dc.b dSnare, $03, dSnare, $03, dSnare, $03, dSnare, $03
	dc.b dLowTimpani, dLowTimpani
music8D_Loop1:
music8D_Jump1:
	dc.b dSnare, $0C, $09, $03, $06, $06, dHiTimpani, dLowTimpani
	dc.b dSnare, dSnare, $0C, $06, $0C, $0C, $0C, $09
	dc.b $03, $06, $06, dHiTimpani, $03, dHiTimpani, dLowTimpani, $06
	dc.b dSnare, $06, $0C, $06, $06, $0C, $06
	smpsLoop	$00, $02, music8D_Loop1
	dc.b $0C, $09, $03, $06, $0C, $06, dHiTimpani, $06
	dc.b dLowTimpani, dHiTimpani, dLowTimpani, dHiTimpani, dLowTimpani, dHiTimpani, dLowTimpani
	smpsJump	music8D_Jump1

music8D_Voices:
	; Voice $00
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
	; $42, $43, $14, $71,	$1F, $12, $1F, $1F
	; $04, $02, $04, $0A,	$01, $01, $02, $02
	; $1F, $1F, $1F, $1F,	$1A, $16, $19, $80
	smpsVcAlgorithm	$02
	smpsVcFeedback	$07
	smpsVcDetune	$07, $01, $04, $04
	smpsVcCoarseFreq	$01, $04, $03, $02
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $12, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0A, $04, $02, $04
	smpsVcDecayRate2	$02, $02, $01, $01
	smpsVcDecayLevel	$01, $01, $01, $01
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $19, $16, $1A
