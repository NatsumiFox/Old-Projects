woiship_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	woiship_Voices
	smpsHeaderChan	$07, $03
	smpsHeaderTempo	$01, $00
	smpsHeaderDAC	woiship_DAC
	smpsHeaderFM	woiship_FM1, $00, $00
	smpsHeaderFM	woiship_FM2, $00, $00
	smpsHeaderFM	woiship_FM3, $0C, $00
	smpsHeaderFM	woiship_FM4, $00, $00
	smpsHeaderFM	woiship_FM5, $00, $00
	smpsHeaderFM	woiship_FM6, $00, $00
	smpsHeaderPSG	woiship_PSG1, $F4, $00, $00, $00
	smpsHeaderPSG	woiship_PSG2, $F4, $00, $00, $00
	smpsHeaderPSG	woiship_PSG3, $F4, $00, $00, $00

woiship_Voices:
	; Voice $00
	; $32
	; $71, $21, $40, $20,	$16, $16, $19, $0F
	; $05, $05, $01, $07,	$02, $01, $02, $01
	smpsVcAlgorithm	$02
	smpsVcFeedback	$06
	smpsVcDetune	$02, $04, $02, $07
	smpsVcCoarseFreq	$00, $00, $01, $01
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$0F, $19, $16, $16
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$07, $01, $05, $05
	smpsVcDecayRate2	$01, $02, $01, $02
	smpsVcDecayLevel	$01, $01, $01, $01
	smpsVcReleaseRate	$0F, $0A, $0A, $08
	smpsVcTotalLevel	$06, $1A, $30, $21

	; Voice $01
	; $3B
	; $01, $02, $04, $01,	$5F, $13, $5F, $53
	; $00, $0B, $0F, $0F,	$00, $00, $00, $00
	smpsVcAlgorithm	$03
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$01, $04, $02, $01
	smpsVcRateScale	$01, $01, $00, $01
	smpsVcAttackRate	$13, $1F, $13, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0F, $0F, $0B, $00
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$00, $00, $04, $00
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $30, $31, $2D

	; Voice $02
	; $3A
	; $01, $04, $01, $43,	$12, $12, $12, $0E
	; $00, $00, $00, $00,	$00, $00, $00, $00
	smpsVcAlgorithm	$02
	smpsVcFeedback	$07
	smpsVcDetune	$04, $00, $00, $00
	smpsVcCoarseFreq	$03, $01, $04, $01
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$0E, $12, $12, $12
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$00, $00, $00, $00
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$01, $00, $03, $00
	smpsVcReleaseRate	$08, $06, $06, $06
	smpsVcTotalLevel	$00, $27, $26, $18

	; Voice $03
	; $3B
	; $3C, $14, $04, $04,	$5E, $18, $18, $50
	; $0D, $00, $03, $00,	$19, $00, $02, $00
	smpsVcAlgorithm	$03
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $01, $03
	smpsVcCoarseFreq	$04, $04, $04, $0C
	smpsVcRateScale	$01, $00, $00, $01
	smpsVcAttackRate	$10, $18, $18, $1E
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$00, $03, $00, $0D
	smpsVcDecayRate2	$00, $02, $00, $19
	smpsVcDecayLevel	$00, $03, $00, $05
	smpsVcReleaseRate	$07, $05, $05, $05
	smpsVcTotalLevel	$00, $18, $2E, $1C

	; Voice $04
	; $2C
	; $0E, $64, $64, $24,	$5A, $59, $58, $57
	; $10, $0C, $0A, $0A,	$06, $06, $05, $05
	smpsVcAlgorithm	$04
	smpsVcFeedback	$05
	smpsVcDetune	$02, $06, $06, $00
	smpsVcCoarseFreq	$04, $04, $04, $0E
	smpsVcRateScale	$01, $01, $01, $01
	smpsVcAttackRate	$17, $18, $19, $1A
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0A, $0A, $0C, $10
	smpsVcDecayRate2	$05, $05, $06, $06
	smpsVcDecayLevel	$0A, $0C, $0C, $0C
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $25, $00, $18

	; Voice $05
	; $00
	; $0A, $0B, $05, $05,	$1F, $1F, $1F, $14
	; $0C, $09, $15, $0A,	$02, $00, $02, $0C
	smpsVcAlgorithm	$00
	smpsVcFeedback	$00
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$05, $05, $0B, $0A
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$14, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0A, $15, $09, $0C
	smpsVcDecayRate2	$0C, $02, $00, $02
	smpsVcDecayLevel	$05, $00, $00, $02
	smpsVcReleaseRate	$07, $03, $03, $03
	smpsVcTotalLevel	$00, $0B, $20, $1B

	; Voice $06
	; $2E
	; $0C, $0C, $0C, $3C,	$1A, $13, $12, $54
	; $15, $17, $03, $0D,	$09, $12, $00, $12
	smpsVcAlgorithm	$06
	smpsVcFeedback	$05
	smpsVcDetune	$03, $00, $00, $00
	smpsVcCoarseFreq	$0C, $0C, $0C, $0C
	smpsVcRateScale	$01, $00, $00, $00
	smpsVcAttackRate	$14, $12, $13, $1A
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0D, $03, $17, $15
	smpsVcDecayRate2	$12, $00, $12, $09
	smpsVcDecayLevel	$0F, $00, $0F, $00
	smpsVcReleaseRate	$0F, $04, $0B, $0C
	smpsVcTotalLevel	$00, $28, $00, $2D

	; Voice $07
	; $3C
	; $01, $01, $01, $01,	$1F, $1F, $1F, $1F
	; $18, $0F, $16, $0F,	$1F, $1F, $1F, $1F
	smpsVcAlgorithm	$04
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$01, $01, $01, $01
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0F, $16, $0F, $18
	smpsVcDecayRate2	$1F, $1F, $1F, $1F
	smpsVcDecayLevel	$0F, $0F, $0F, $0F
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $06, $00, $03

	; Voice $08
	; $4B
	; $00, $00, $00, $00,	$1F, $1F, $1F, $1F
	; $12, $0F, $19, $19,	$05, $1A, $07, $07
	smpsVcAlgorithm	$03
	smpsVcFeedback	$01
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$00, $00, $00, $00
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$19, $19, $0F, $12
	smpsVcDecayRate2	$07, $07, $1A, $05
	smpsVcDecayLevel	$00, $00, $03, $04
	smpsVcReleaseRate	$06, $03, $07, $04
	smpsVcTotalLevel	$00, $33, $0E, $22

woiship_DAC:
	smpsStop

woiship_FM1:
	smpsAlterPitch	$0C

woiship_Jump1:
	smpsSetVol -(($01*4)+$10)&$7F
	smpsModSet	$14, $01, $04, $05
	smpsSetvoice	$00
	smpsCall	woiship_Call1
	dc.b smpsNoAttack, $30, smpsNoAttack, $2F, nRst, $01
	smpsAlterPitch	$F4
	dc.b nF2, $30, smpsNoAttack, $17, nRst, $01, nE2, $17
	dc.b nRst, $01, nF2, $17, nRst, $01, nG2, $17
	dc.b nRst, $01, nAb2, $0F, nRst, $01, nBb2, $0F
	dc.b nRst, $01, nB2, $0F, nRst, $01, nC3, $30
	dc.b smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $2F, nRst, $01
	dc.b nCs3, $17, nRst, $01, nC3, $17, nRst, $01
	dc.b nE3, $30, smpsNoAttack, $2F, nRst, $01, nEb3, $0F
	dc.b nRst, $01, nA3, $0F, nRst, $01, nAb3, $0F
	dc.b nRst, $01, nC3, $30, smpsNoAttack, $30, smpsNoAttack, $30
	dc.b smpsNoAttack, $2F, nRst, $01
	smpsAlterPitch	$0C
	smpsSetvoice	$08
	smpsModSet	$01, $01, $00, $00
	smpsSetVol -(($00*4)+$10)&$7F

woiship_Loop1:
	dc.b nF2, $18, nRst, nC2, nRst
	smpsLoop	$00, $04, woiship_Loop1

woiship_Loop2:
	dc.b nD2, $18, nRst, nA1, nRst
	smpsLoop	$00, $04, woiship_Loop2

woiship_Loop3:
	dc.b nF2, $18, nRst, nC2, nRst
	smpsLoop	$00, $04, woiship_Loop3
	smpsSetvoice	$00
	smpsAlterPitch	$0C
	dc.b nC2, $30, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $17
	dc.b nRst, $01, nG2, $0B, nRst, $01, nD2, $0B
	dc.b nRst, $01, nE2, $17, nRst, $01, nB1, $0B
	dc.b nRst, $01, nG1, $0B, nRst, $01, nA1, $17
	dc.b nRst, $01, nG1, $0B, nRst, $01, nD1, $0B
	dc.b nRst, $01, nE1, $30, smpsNoAttack, $2F, nRst, $01
	smpsAlterPitch	$F4
	smpsJump	woiship_Jump1

woiship_Call1:
	dc.b nF2, $30, smpsNoAttack, $17, nRst, $01, nG2, $17
	dc.b nRst, $01, nAb2, $17, nRst, $01, nBb2, $17
	dc.b nRst, $01, nB2, $0F, nRst, $01, nC3, $0F
	dc.b nRst, $01, nAb3, $0F, nRst, $01, nE3, $30
	dc.b smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $2F, nRst, $01
	dc.b nF3, $17, nRst, $01, nE3, $17, nRst, $01
	dc.b nAb2, $5F, nRst, $01, nG2, $0F, nRst, $01
	dc.b nCs3, $0F, nRst, $01, nC3, $0F, nRst, $01
	dc.b nE2, $60
	smpsReturn

woiship_FM2:
	smpsSetVol -(($02*4)+$10)&$7F

woiship_Jump2:
	smpsAlterNote	$03
	smpsModSet	$14, $01, $04, $05
	smpsAlterPitch	$0C
	dc.b nRst, $0B
	smpsSetvoice	$00
	smpsCall	woiship_Call1
	dc.b smpsNoAttack, $30, smpsNoAttack, $25
	smpsSetvoice	$01
	smpsFMAlterVol	$04
	smpsAlterPitch	$0C
	smpsCall	woiship_Call1
	dc.b smpsNoAttack, $30, smpsNoAttack, $2F, nRst, $01
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$F8
	smpsAlterPitch	$E8
	smpsModSet	$01, $01, $00, $00
	smpsSetvoice	$00
	dc.b nA4, $30, smpsNoAttack, $17, nRst, $01, nB4, $17
	dc.b nRst, $01, nC5, $17, nRst, $01, nD5, $17
	dc.b nRst, $01, nE5, $0F, nRst, $01, nF5, $0F
	dc.b nRst, $01, nB5, $0F, nRst, $01, nA5, $2F
	dc.b nRst, $01, nG5, $2F, nRst, $01, nE5, $2F
	dc.b nRst, $01, nC5, $2F, nRst, $01, nE5, $30
	dc.b smpsNoAttack, $17, nRst, $01, nC5, $17, nRst, $01
	dc.b nA4, $30, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30
	dc.b smpsNoAttack, $30, smpsNoAttack, $2F, nRst, $01, nEb5, $17
	dc.b nRst, $01, nBb5, $2F, nRst, $01, nAb5, $17
	dc.b nRst, $01, nG5, $30, smpsNoAttack, $30, smpsNoAttack, $30
	dc.b smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30
	dc.b smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30
	dc.b smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $2F, nRst, $01
	smpsFMAlterVol	$08
	smpsJump	woiship_Jump2

woiship_FM3:
woiship_Jump3:
	smpsSetVol -(($03*4)+$10)&$7F
	smpsModSet	$14, $01, $04, $05
	smpsSetvoice	$00
	dc.b nRst, $1A
	smpsCall	woiship_Call1
	dc.b smpsNoAttack, $30, smpsNoAttack, $16
	smpsFMAlterVol	$04
	smpsSetvoice	$01
	dc.b nRst, $06
	smpsAlterPitch	$0C
	smpsCall	woiship_Call1
	dc.b smpsNoAttack, $30, smpsNoAttack, $2A
	smpsAlterPitch	$F4
	smpsFMAlterVol	$FC
	smpsSetVol -(($02*4)+$10)&$7F
	smpsAlterPitch	$F4
	smpsSetvoice	$00
	dc.b nF5, $30, smpsNoAttack, $17, nRst, $01, nC5, $17
	dc.b nRst, $01, nF5, $17, nRst, $01, nG5, $17
	dc.b nRst, $01, nA5, $17, nRst, $01, nG5, $17
	dc.b nRst, $01, nF5, $30, smpsNoAttack, $30, smpsNoAttack, $17
	dc.b nRst, $01, nG5, $17, nRst, $01, nA5, $17
	dc.b nRst, $01, nF5, $17, nRst, $01, nD5, $30
	dc.b smpsNoAttack, $30, smpsNoAttack, $2F, nRst, $01
	smpsSetVol -(($03*4)+$10)&$7F
	smpsAlterPitch	$E8
	smpsSetvoice	$03
	dc.b nG5, $17, nRst, $01, nF5, $17, nRst, $01
	dc.b nE5, $2F, nRst, $01, nD5, $2F, nRst, $01
	dc.b nC5, $2F, nRst, $01, nD5, $2F, nRst, $01
	dc.b nEb5, $30, smpsNoAttack, $30, smpsNoAttack, $30, nC5, $17
	dc.b nRst, $01, nG5, $2F, nRst, $01, nF5, $17
	dc.b nRst, $01, nEb5, $17, nRst, $01, nD5, $17
	dc.b nRst, $01, nC5, $2F, nRst, $01, nD5, $2F
	dc.b nRst, $01, nE5, $30, smpsNoAttack, $30, smpsNoAttack, $30
	dc.b smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30
	dc.b smpsNoAttack, $2F, nRst, $01
	smpsAlterPitch	$24
	smpsJump	woiship_Jump3

woiship_FM4:
	smpsSetvoice	$04

woiship_Loop4:
woiship_Jump4:
	smpsSetVol -(($03*4)+$10)&$7F
	smpsPan	 panLeft, $00
	dc.b nA4, $18
	smpsPan	 panRight, $00
	dc.b nC5, $18
	smpsPan	 panLeft, $00
	dc.b nB4, $18
	smpsPan	 panRight, $00
	dc.b nE4, $0C, nAb4
	smpsPan	 panLeft, $00
	dc.b nA4, $18
	smpsPan	 panRight, $00
	dc.b nE4, $18
	smpsLoop	$00, $0B, woiship_Loop4
	smpsSetVol -(($04*4)+$10)&$7F
	smpsPan	 panCentre, $00
	dc.b nRst, $30, nRst, nRst, nRst, $0C, nE5, $06
	dc.b nD5, nC5, nB4, nA4, nG4, nF4, nE4, nD4
	dc.b nC4, nB3, nA3, nG3, nF3

woiship_Loop5:
	dc.b nE3, nF3
	smpsLoop	$00, $08, woiship_Loop5
	dc.b nE3, $30, smpsNoAttack, $30, nRst, $0C, nG5, $06
	dc.b nF5, nE5, nD5, nC5, nB4, nA4, nG4, nF4
	dc.b nE4, nD4, nC4, nB3, nA3

woiship_Loop6:
	dc.b nG3, nA3
	smpsLoop	$00, $08, woiship_Loop6
	dc.b nG3, $30, smpsNoAttack, $30, nRst, $30, nRst, $0C
	dc.b nBb5, $06, nAb5, nG5, nF5, nEb5, nD5, nC5
	dc.b nBb4, nAb4, nG4, nF4, nEb4, nD4, nC4, nBb3
	dc.b nAb3, nG3, nF3, nEb3, nD3, nC3, nBb2

woiship_Loop7:
	dc.b nAb2, nBb2
	smpsLoop	$00, $08, woiship_Loop7
	dc.b nAb2, $30, nBb2, nB4, $06, nC5, nE5, nG5
	dc.b nB5, nG5, nE5, nC5, nB4, nG4, nE4, nC4
	dc.b nB3, nG3, nE3, nC3, nB3, nC4, nE4, nG4
	dc.b nB4, nG4, nE4, nC4, nB3, nG3, nE3, nC3
	dc.b nB2, nG2, nE2, nC2

woiship_Loop8:
	dc.b nB1, $06, nC2
	smpsFMAlterVol	$02
	smpsLoop	$00, $10, woiship_Loop8
	smpsJump	woiship_Jump4

woiship_FM5:
woiship_Loop9:
woiship_Jump5:
	smpsSetVol -(($03*4)+$10)&$7F
	smpsSetvoice	$05
	smpsModSet	$01, $03, $55, $03
	dc.b nAb5, $30, smpsNoAttack, $18
	smpsModSet	$01, $01, $00, $00
	smpsSetVol -(($00*4)+$10)&$7F
	smpsSetvoice	$07
	smpsModSet	$01, $01, $F0, $00
	dc.b nC2, $18, nC2, $18, nRst, $48
	smpsModSet	$01, $01, $00, $00
	smpsLoop	$00, $08, woiship_Loop9
	dc.b nRst, $10, nRst, $30, nRst, $30, nRst, $30
	dc.b nRst, $30
	smpsSetVol -(($06*4)+$10)&$7F
	smpsSetvoice	$04
	dc.b nRst, $0C, nE5, $06, nD5, nC5, nB4, nA4
	dc.b nG4, nF4, nE4, nD4, nC4, nB3, nA3, nG3
	dc.b nF3

woiship_Loop10:
	dc.b nE3, nF3
	smpsLoop	$00, $08, woiship_Loop10
	dc.b nE3, $30, smpsNoAttack, $30, nRst, $0C, nG5, $06
	dc.b nF5, nE5, nD5, nC5, nB4, nA4, nG4, nF4
	dc.b nE4, nD4, nC4, nB3, nA3

woiship_Loop11:
	dc.b nG3, nA3
	smpsLoop	$00, $08, woiship_Loop11
	dc.b nG3, $30, smpsNoAttack, $30, nRst, $30, nRst, $0C
	dc.b nBb5, $06, nAb5, nG5, nF5, nEb5, nD5, nC5
	dc.b nBb4, nAb4, nG4, nF4, nEb4, nD4, nC4, nBb3
	dc.b nAb3, nG3, nF3, nEb3, nD3, nC3, nBb2

woiship_Loop12:
	dc.b nAb2, nBb2
	smpsLoop	$00, $08, woiship_Loop12
	dc.b nAb2, $30, nBb2, $20
	smpsSetVol -(($00*4)+$10)&$7F
	smpsModSet	$01, $01, $F0, $00
	smpsSetvoice	$07
	dc.b nRst, $30, nRst, $18, nC2, nC2, $30, smpsNoAttack
	dc.b $18, nC2, nC2, nRst, $30, $18, $30, smpsNoAttack
	dc.b $18, nC2
	smpsModSet	$01, $01, $00, $00
	smpsJump	woiship_Jump5

woiship_FM6:
	dc.b nRst, $0A
woiship_Loop13:
woiship_Jump6:
	smpsSetVol -(($05*4)+$10)&$7F
	smpsSetvoice	$04
	smpsPan	 panLeft, $00
	dc.b nA4, $18
	smpsPan	 panRight, $00
	dc.b nC5, $18
	smpsPan	 panLeft, $00
	dc.b nB4, $18
	smpsPan	 panRight, $00
	dc.b nE4, $0C, nAb4
	smpsPan	 panLeft, $00
	dc.b nA4, $18
	smpsPan	 panRight, $00
	dc.b nE4, $18
	smpsLoop	$00, $0A, woiship_Loop13
	smpsPan	 panLeft, $00
	dc.b nA4, $18
	smpsPan	 panRight, $00
	dc.b nC5, $18
	smpsPan	 panLeft, $00
	dc.b nB4, $18
	smpsPan	 panRight, $00
	dc.b nE4, $0C, nAb4
	smpsPan	 panRight, $00
	smpsSetVol -(($01*4)+$10)&$7F
	smpsSetvoice	$00
	smpsAlterNote	$05
	smpsModSet	$14, $01, $04, $05
	dc.b nA4, $30, smpsNoAttack, $17, nRst, $01, nB4, $17
	dc.b nRst, $01, nC5, $17, nRst, $01, nD5, $17
	dc.b nRst, $01, nE5, $0F, nRst, $01, nF5, $0F
	dc.b nRst, $01, nB5, $0F, nRst, $01, nA5, $2F
	dc.b nRst, $01, nG5, $2F, nRst, $01, nE5, $2F
	dc.b nRst, $01, nC5, $2F, nRst, $01, nE5, $30
	dc.b smpsNoAttack, $17, nRst, $01, nC5, $17, nRst, $01
	dc.b nA4, $30, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30
	dc.b smpsNoAttack, $30, smpsNoAttack, $2F, nRst, $01, nEb5, $17
	dc.b nRst, $01, nBb5, $2F, nRst, $01, nAb5, $17
	dc.b nRst, $01, nG5, $30, smpsNoAttack, $30, smpsNoAttack, $30
	dc.b smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30
	dc.b smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30
	dc.b smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $2F, nRst, $01
	smpsModSet	$01, $01, $00, $00
	smpsPan	 panCentre, $00
	smpsAlterNote	$00
	smpsJump	woiship_Jump6

woiship_PSG1:
woiship_Jump7:
	smpsSetVol $08^$7F
;	smpsPSGAlterVol	$FE
	smpsPSGvoice	sTone_2A
	dc.b nRst, $30, nRst, nRst, nRst

woiship_Loop14:
	dc.b nE4, $06, smpsNoAttack, nAb3
	smpsLoop	$00, $30, woiship_Loop14

woiship_Loop15:
	dc.b nAb3, $06, smpsNoAttack, nBb3
	smpsLoop	$00, $40, woiship_Loop15
	smpsSetVol $05^$7F
;	smpsPSGAlterVol	$FE

woiship_Loop16:
	dc.b nA2, $18, nE2
	smpsLoop	$00, $08, woiship_Loop16

woiship_Loop17:
	dc.b nA2, $18, nF2
	smpsLoop	$00, $08, woiship_Loop17

woiship_Loop18:
	dc.b nC3, $18, nEb3
	smpsLoop	$00, $08, woiship_Loop18
	smpsSetVol $06^$7F
;	smpsPSGAlterVol	$FE
	smpsPSGvoice	 sTone_28
	dc.b nRst, $30, nRst, $18, nB2, $0C, nG2, nA2
	dc.b $30, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack
	dc.b $30, smpsNoAttack, $30
	smpsJump	woiship_Jump7

woiship_PSG2:
woiship_Jump8:
	smpsSetVol $08^$7F
;	smpsPSGAlterVol	$FE
	smpsPSGvoice	 sTone_2A
	dc.b nRst, $30, nRst, nRst, nRst

woiship_Loop19:
	dc.b nC4, $06, smpsNoAttack, nE3
	smpsLoop	$00, $30, woiship_Loop19

woiship_Loop20:
	dc.b nF4, $06, smpsNoAttack, nFs3
	smpsLoop	$00, $40, woiship_Loop20
	smpsSetVol $05^$7F
;	smpsPSGAlterVol	$FE

woiship_Loop21:
	dc.b nF2, $18, nC2
	smpsLoop	$00, $08, woiship_Loop21

woiship_Loop22:
	dc.b nD2, $18, nC3
	smpsLoop	$00, $08, woiship_Loop22

woiship_Loop23:
	dc.b nAb2, $18, nC3
	smpsLoop	$00, $08, woiship_Loop23
	smpsSetVol $06^$7F
;	smpsPSGAlterVol	$FE
	smpsPSGvoice	 sTone_28
	dc.b nRst, $06, nRst, $30, nRst, $18, nB2, $0C
	dc.b nG2, nA2, $30, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack
	dc.b $30, smpsNoAttack, $30, smpsNoAttack, $2A
	smpsJump	woiship_Jump8

woiship_PSG3:
	smpsPSGvoice	 sTone_29

woiship_Jump9:
	smpsSetVol $09^$7F
	dc.b nRst, $1A
	smpsCall	woiship_Call1
	dc.b smpsNoAttack, $30, smpsNoAttack, $16
	smpsPSGAlterVol	$04
	dc.b nRst, $06
	smpsAlterPitch	$0C
	smpsCall	woiship_Call1
	dc.b smpsNoAttack, $30, smpsNoAttack, $2A
	smpsAlterPitch	$F4
	smpsPSGAlterVol	$FC
	smpsSetVol $07^$7F
	dc.b nRst, $05
	smpsAlterPitch	$E8
	smpsPan	 panLeft, $00
	dc.b nF5, $30, smpsNoAttack, $17, nRst, $01, nC5, $17
	dc.b nRst, $01, nF5, $17, nRst, $01, nG5, $17
	dc.b nRst, $01, nA5, $17, nRst, $01, nG5, $17
	dc.b nRst, $01, nF5, $30, smpsNoAttack, $30, smpsNoAttack, $17
	dc.b nRst, $01, nG5, $17, nRst, $01, nA5, $17
	dc.b nRst, $01, nF5, $17, nRst, $01, nD5, $30
	dc.b smpsNoAttack, $30, smpsNoAttack, $2F, nRst, $01
	smpsAlterPitch	$0C
	dc.b nG5, $17, nRst, $01, nF5, $17, nRst, $01
	dc.b nE5, $2F, nRst, $01, nD5, $2F, nRst, $01
	dc.b nC5, $2F, nRst, $01, nD5, $2F, nRst, $01
	dc.b nEb5, $30, smpsNoAttack, $30, smpsNoAttack, $30, nC5, $17
	dc.b nRst, $01, nG5, $2F, nRst, $01, nF5, $17
	dc.b nRst, $01, nEb5, $17, nRst, $01, nD5, $17
	dc.b nRst, $01, nC5, $2F, nRst, $01, nD5, $2F
	dc.b nRst, $01, nE5, $30, smpsNoAttack, $30, smpsNoAttack, $30
	dc.b smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30
	dc.b smpsNoAttack, $2B
	smpsPan	 panCentre, $00
	smpsAlterPitch	$0C
	smpsJump	woiship_Jump9
