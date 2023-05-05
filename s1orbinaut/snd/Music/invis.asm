music87_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	music87_Voices
	smpsHeaderChan	$06, $03
	smpsHeaderTempo	$01, $08
	smpsHeaderDAC	music87_DAC
	smpsHeaderFM	music87_FM1, $F4, $11
	smpsHeaderFM	music87_FM2, $F4, $07
	smpsHeaderFM	music87_FM3, $E8, $0F
	smpsHeaderFM	music87_FM4, $E8, $0F
	smpsHeaderFM	music87_FM5, $F4, $11
	smpsHeaderPSG	music87_PSG1, $D0, $05, $00, VolEnv_05
	smpsHeaderPSG	music87_PSG1, $DC, $05, $00, VolEnv_05
	smpsHeaderPSG	music87_PSG2, $00, $03, $00, VolEnv_04

music87_FM5:
	smpsAlterNote	$03

music87_FM1:
	smpsSetvoice	$00
	dc.b nRst, $30

music87_Jump2:
	dc.b nRst, $0C, nCs6, $15, nRst, $03, nCs6, $06
	dc.b nRst, nD6, $0F, nRst, $03, nB5, $18, nRst
	dc.b $06, nCs6, $06, nRst, nCs6, nRst, nCs6, nRst
	dc.b nA5, nRst, nG5, $0F, nRst, $03, nB5, $18
	dc.b nRst, $06, nRst, $0C, nCs6, $15, nRst, $03
	dc.b nCs6, $06, nRst, nD6, $0F, nRst, $03, nB5
	dc.b $18, nRst, $06, nCs6, $06, nRst, nCs6, nRst
	dc.b nCs6, nRst, nA5, nRst, nG5, $0F, nRst, $03
	dc.b nB5, $18, nRst, $06
	smpsFMAlterVol	$FD
	dc.b nRst, $30, nRst, nA5, $04, nB5, nCs6, nD6
	dc.b nE6, nFs6, nB5, nCs6, nEb6, nE6, nFs6, nAb6
	dc.b nCs6, nEb6, nF6, nFs6, nAb6, nBb6, nF6, nFs6
	dc.b nAb6, nBb6, nC7, nCs7
	smpsFMAlterVol	$03
	smpsJump	music87_Jump2

music87_FM2:
	smpsSetvoice	$01
	dc.b nRst, $30

music87_Loop2:
music87_Jump3:
	dc.b nA3, $06, nRst, nA3, nRst, nE3, nRst, nE3
	dc.b nRst, nG3, $12, nFs3, $0C, nG3, $06, nFs3
	dc.b $0C, nA3, $06, nRst, nA3, nRst, nE3, nRst
	dc.b nE3, nRst, nD4, $12, nCs4, $0C, nD4, $06
	dc.b nCs4, $0C
	smpsLoop	$00, $02, music87_Loop2

music87_Loop3:
	dc.b nB2, $06, nG2, $12, nA2, $06, nRst, nB2
	dc.b nRst
	smpsLoop	$00, $02, music87_Loop3
	dc.b nA2, $0C, nB2, nCs3, nEb3, nB2, $06, nCs3
	dc.b nEb3, nF3, nCs3, nEb3, nF3, nFs3
	smpsJump	music87_Jump3

music87_FM3:
	smpsSetvoice	$00
	dc.b nRst, $30

music87_Loop4:
music87_Jump4:
	dc.b nE6, $06, nRst, nE6, nRst, nCs6, nRst, nCs6
	dc.b nRst, nD6, $12, nD6, $1E, nE6, $06, nRst
	dc.b nE6, nRst, nCs6, nRst, nCs6, nRst, nG6, $12
	dc.b nG6, $1E
	smpsLoop	$00, $02, music87_Loop4

music87_Loop5:
	dc.b nRst, $06, nG5, $12, nA5, $06, nRst, $12
	smpsLoop	$00, $04, music87_Loop5
	smpsJump	music87_Jump4

music87_FM4:
	smpsSetvoice	$00
	dc.b nRst, $30

music87_Loop6:
music87_Jump5:
	dc.b nCs6, $06, nRst, nCs6, nRst, nA5, nRst, nA5
	dc.b nRst, nB5, $12, nB5, $1E, nCs6, $06, nRst
	dc.b nCs6, nRst, nA5, nRst, nA5, nRst, nD6, $12
	dc.b nD6, $1E
	smpsLoop	$00, $02, music87_Loop6

music87_Loop7:
	dc.b nRst, $06, nB5, $12, nCs6, $06, nRst, $12
	smpsLoop	$00, $04, music87_Loop7
	smpsJump	music87_Jump5

music87_PSG1:
	smpsStop

music87_PSG2:
	smpsPSGform	$E7
	dc.b nRst, $30

music87_Jump6:
	smpsNoteFill	$03
	dc.b nA5, $0C
	smpsNoteFill	$0C
	dc.b $0C
	smpsNoteFill	$03
	dc.b $0C
	smpsNoteFill	$0C
	dc.b $0C
	smpsJump	music87_Jump6

music87_DAC:
	dc.b dSnare, $06, dSnare, dSnare, dSnare, dSnare, $02, dSnare
	dc.b $04, dKick, $12
music87_Loop1:
music87_Jump1:
	dc.b dKick, $0C, dSnare, dKick, dSnare, dKick, $0C, dSnare
	dc.b dKick, dSnare, dKick, $0C, dSnare, dKick, dSnare, dKick
	dc.b $0C, dSnare, dKick, $04, nRst, dSnare, dSnare, $0C
	smpsLoop	$00, $02, music87_Loop1
	dc.b dKick, $06, dSnare, $12, dKick, $0C, dSnare, dSnare
	dc.b $06, dKick, $12, dKick, $0C, dSnare, dSnare, $06
	dc.b dKick, $12, dKick, $0C, dSnare, dSnare, $04, dSnare
	dc.b dSnare, dSnare, dSnare, dSnare, dSnare, dSnare, dSnare, dSnare
	dc.b dSnare, dSnare
	smpsJump	music87_Jump1
	; Unused
	dc.b $F2

music87_Voices:
	; Voice $00
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
