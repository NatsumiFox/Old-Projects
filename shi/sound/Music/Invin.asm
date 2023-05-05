Invinciblity_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	Invinciblity_Voices
	smpsHeaderChan	$06, $03
	smpsHeaderTempo	$01, $2C
	smpsHeaderDAC	Invinciblity_DAC
	smpsHeaderFM	Invinciblity_FM1, $18, $12
	smpsHeaderFM	Invinciblity_FM2, $00, $09
	smpsHeaderFM	Invinciblity_FM3, $18, $1C
	smpsHeaderFM	Invinciblity_FM4, $00, $1C
	smpsHeaderFM	Invinciblity_FM5, $00, $1C
	smpsHeaderPSG	Invinciblity_PSG1, $F4, $06, $00, $00
	smpsHeaderPSG	Invinciblity_PSG2, $F4, $06, $00, $00
	smpsHeaderPSG	Invinciblity_PSG3, $3B, $02, $00, $00

Invinciblity_FM1:
Invinciblity_Jump2:
	smpsSetvoice	$00
	smpsModSet	$14, $01, $06, $06
	dc.b nB3, $04, nRst, nB3, $08, nC4, $04, nRst
	dc.b nC4, $08, nD4, $08, nRst, nD4, $04, nRst
	dc.b nBb3, $04, smpsNoAttack, nB3, $08, nRst, $04, nB3
	dc.b $08, nC4, $04, nRst, nD4, $0C, nRst, $04
	dc.b nD4, nRst, nD4, $0C, nRst, $04, nF4, $0C
	dc.b nRst, $04, nF4, $0C, nRst, $04, nF4, $0C
	dc.b nRst, $04, nF4, $0C, nRst, $04
	smpsFMAlterVol	$FE

Invinciblity_Loop1:
	dc.b nF4, $03, nRst, $05
	smpsLoop	$00, $08, Invinciblity_Loop1
	smpsFMAlterVol	$02
	dc.b nB3, $04, nRst, nB3, $08, nC4, $04, nRst
	dc.b nC4, $08, nD4, $08, nRst, nD4, $04, nRst
	dc.b nBb3, $04, smpsNoAttack, nB3, $08, nRst, $04, nB3
	dc.b $08, nC4, $04, nRst, nD4, $0C, nRst, $04
	dc.b nD4, nRst, nD4, $0C, nRst, $04, nF4, $0C
	dc.b nRst, $04, nF4, $0C, nRst, $04, nF4, $0C
	dc.b nRst, $04, nF4, $0C, nRst, $04
	smpsFMAlterVol	$FE

Invinciblity_Loop2:
	dc.b nA4, $03, nRst, $05
	smpsLoop	$00, $08, Invinciblity_Loop2
	smpsFMAlterVol	$02
	smpsJump	Invinciblity_Jump2

Invinciblity_FM2:
Invinciblity_Jump3:
	smpsSetvoice	$01
	dc.b nG2, $04, nRst, nG2, nRst, nG2, nRst, nG2
	dc.b nRst, nD2, $0C, nRst, $04, nD2, nRst, nG2
	dc.b $08, nRst, $08, nG2, $04, nRst, nG2, nRst
	dc.b nD2, $08, nRst, nD2, $04, nRst, nD2, $0C
	dc.b nRst, $04

Invinciblity_Loop3:
	dc.b nF2, $03, nRst, $05
	smpsLoop	$00, $10, Invinciblity_Loop3
	dc.b nG2, $04, nRst, nG2, nRst, nG2, nRst, nG2
	dc.b nRst, nD2, $0C, nRst, $04, nD2, nRst, nG2
	dc.b $08, nRst, $08, nG2, $04, nRst, nG2, nRst
	dc.b nD2, $08, nRst, nD2, $04, nRst, nD2, $0C
	dc.b nRst, $04

Invinciblity_Loop4:
	dc.b nF2, $03, nRst, $05
	smpsLoop	$00, $08, Invinciblity_Loop4

Invinciblity_Loop5:
	dc.b nA2, $03, nRst, $05
	smpsLoop	$00, $08, Invinciblity_Loop5
	smpsJump	Invinciblity_Jump3

Invinciblity_FM3:
	smpsSetvoice	$00
	smpsModSet	$15, $01, $06, $06
	dc.b nRst, $03
	smpsAlterNote	$03

Invinciblity_Jump4:
	dc.b nG3, $04, nRst, nG3, $08, nA3, $04, nRst
	dc.b nA3, $08, nB3, $08, nRst, nB3, $04, nRst
	dc.b nFs3, $04, smpsNoAttack, nG3, $08, nRst, $04, nG3
	dc.b $08, nA3, $04, nRst, nB3, $0C, nRst, $04
	dc.b nB3, nRst, nB3, $0C, nRst, $04, nC4, $0C
	dc.b nRst, $04, nC4, $0C, nRst, $04, nC4, $0C
	dc.b nRst, $04, nC4, $0C, nRst, $04
	smpsFMAlterVol	$FE

Invinciblity_Loop6:
	dc.b nC4, $03, nRst, $05
	smpsLoop	$00, $08, Invinciblity_Loop6
	smpsFMAlterVol	$02
	dc.b nG3, $04, nRst, nG3, $08, nA3, $04, nRst
	dc.b nA3, $08, nB3, $08, nRst, nB3, $04, nRst
	dc.b nFs3, $04, smpsNoAttack, nG3, $08, nRst, $04, nG3
	dc.b $08, nA3, $04, nRst, nB3, $0C, nRst, $04
	dc.b nB3, nRst, nB3, $0C, nRst, $04, nC4, $0C
	dc.b nRst, $04, nC4, $0C, nRst, $04, nC4, $0C
	dc.b nRst, $04, nC4, $0C, nRst, $04
	smpsFMAlterVol	$FE

Invinciblity_Loop7:
	dc.b nA4, $03, nRst, $05
	smpsLoop	$00, $08, Invinciblity_Loop7
	smpsFMAlterVol	$02
	smpsJump	Invinciblity_Jump4

Invinciblity_FM4:
	smpsSetvoice	$02
	smpsPan	 panRight, $00

Invinciblity_Loop8:
Invinciblity_Jump5:
	dc.b nG5, $04, nD5
	smpsLoop	$00, $10, Invinciblity_Loop8

Invinciblity_Loop9:
	dc.b nA5, $04, nF5
	smpsLoop	$00, $10, Invinciblity_Loop9

Invinciblity_Loop10:
	dc.b nG5, $04, nD5
	smpsLoop	$00, $10, Invinciblity_Loop10

Invinciblity_Loop11:
	dc.b nA5, $04, nF5
	smpsLoop	$00, $08, Invinciblity_Loop11

Invinciblity_Loop12:
	dc.b nC6, $04, nF5
	smpsLoop	$00, $08, Invinciblity_Loop12
	smpsJump	Invinciblity_Jump5

Invinciblity_FM5:
	smpsSetvoice	$02
	smpsPan	 panLeft, $00

Invinciblity_Loop13:
Invinciblity_Jump6:
	dc.b nB4, $04, nG4
	smpsLoop	$00, $10, Invinciblity_Loop13

Invinciblity_Loop14:
	dc.b nC5, $04, nA4
	smpsLoop	$00, $10, Invinciblity_Loop14

Invinciblity_Loop15:
	dc.b nB4, $04, nG4
	smpsLoop	$00, $10, Invinciblity_Loop15

Invinciblity_Loop16:
	dc.b nC5, $04, nA4
	smpsLoop	$00, $08, Invinciblity_Loop16

Invinciblity_Loop17:
	dc.b nF5, $04, nA4
	smpsLoop	$00, $08, Invinciblity_Loop17
	smpsJump	Invinciblity_Jump6

Invinciblity_DAC:
Invinciblity_Jump1:
	dc.b dKickS3, $10
	smpsJump	Invinciblity_Jump1

Invinciblity_PSG1:
	smpsPSGvoice	 sTone_0A
	dc.b nRst, $02
	smpsJump	Invinciblity_Jump5

Invinciblity_PSG2:
	smpsPSGvoice	 sTone_0A
	dc.b nRst, $02
	smpsJump	Invinciblity_Jump6

Invinciblity_PSG3:
	smpsStop

Invinciblity_Voices:
	; Voice $00
	; $3D
	; $01, $00, $04, $03,	$1F, $1F, $1F, $1F
	; $10, $06, $06, $06,	$01, $06, $06, $06
	smpsVcAlgorithm	$05
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$03, $04, $00, $01
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$06, $06, $06, $10
	smpsVcDecayRate2	$06, $06, $06, $01
	smpsVcDecayLevel	$01, $01, $01, $03
	smpsVcReleaseRate	$0A, $08, $0A, $05
	smpsVcTotalLevel	$00, $02, $02, $12

	; Voice $01
	; $3A
	; $01, $02, $01, $01,	$1F, $5F, $5F, $5F
	; $10, $11, $09, $09,	$07, $00, $00, $00
	smpsVcAlgorithm	$02
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$01, $01, $02, $01
	smpsVcRateScale	$01, $01, $01, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$09, $09, $11, $10
	smpsVcDecayRate2	$00, $00, $00, $07
	smpsVcDecayLevel	$0F, $0F, $0F, $0C
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $18, $22, $1C

	; Voice $02
	; $3D
	; $01, $01, $01, $01,	$94, $19, $19, $19
	; $0F, $0D, $0D, $0D,	$07, $04, $04, $04
	smpsVcAlgorithm	$05
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$01, $01, $01, $01
	smpsVcRateScale	$00, $00, $00, $02
	smpsVcAttackRate	$19, $19, $19, $14
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0D, $0D, $0D, $0F
	smpsVcDecayRate2	$04, $04, $04, $07
	smpsVcDecayLevel	$01, $01, $01, $02
	smpsVcReleaseRate	$0A, $0A, $0A, $05
	smpsVcTotalLevel	$00, $00, $00, $15
