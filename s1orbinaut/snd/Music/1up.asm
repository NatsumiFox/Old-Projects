music88_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	music88_Voices
	smpsHeaderChan	$06, $03
	smpsHeaderTempo	$02, $05
	smpsHeaderDAC	music88_DAC
	smpsHeaderFM	music88_FM1, $E8, $10
	smpsHeaderFM	music88_FM2, $E8, $10
	smpsHeaderFM	music88_FM3, $E8, $10
	smpsHeaderFM	music88_FM4, $E8, $10
	smpsHeaderFM	music88_FM5, $E8, $10
	smpsHeaderPSG	music88_PSG1, $D0, $06, $00, VolEnv_05
	smpsHeaderPSG	music88_PSG2, $DC, $06, $00, VolEnv_05
	smpsHeaderPSG	music88_PSG2, $DC, $00, $00, VolEnv_04

music88_FM4:
	smpsAlterNote	$03
	smpsPan	panRight, $00
	smpsJump	music88_Jump1

music88_FM1:
	smpsPan	panLeft, $00

music88_Jump1:
	smpsSetvoice	$00
	smpsNoteFill	$06
	dc.b nE7, $06, $03, $03, $06, $06
	smpsNoteFill	$00
	dc.b nFs7, $09, nD7, nCs7, $06, nE7, $18
	smpsStop

music88_FM2:
	smpsSetvoice	$01
	smpsNoteFill	$06
	dc.b nCs7, $06, $03, $03, $06, $06
	smpsNoteFill	$00
	dc.b nD7, $09, nB6, nA6, $06, nCs7, $18
	smpsStop

music88_FM5:
	smpsAlterNote	$03
	smpsPan	panRight, $00
	smpsJump	music88_Jump2

music88_FM3:
	smpsPan	panLeft, $00

music88_Jump2:
	smpsSetvoice	$02
	dc.b nA4, $0C, nRst, $06, nA4, nG4, nRst, $03
	dc.b nG4, $06, nRst, $03, nG4, $06, nA4, $18
	smpsStop

music88_PSG1:
	smpsNoteFill	$06
	dc.b nCs7, $06, $03, $03, $06, $06
	smpsNoteFill	$00
	dc.b nD7, $09, nB6, nA6, $06, nCs7, $18

music88_PSG2:
	smpsStop

music88_DAC:
	dc.b dHiTimpani, $12, $06, dVLowTimpani, $09, $09, $06, dHiTimpani
	dc.b $06, dLowTimpani, dHiTimpani, dLowTimpani, dHiTimpani, $0C
	smpsFade

music88_Voices:
	; Voice $00
	; $3A
	; $01, $07, $01, $01,	$8E, $8E, $8D, $53
	; $0E, $0E, $0E, $03,	$00, $00, $00, $00
	; $1F, $FF, $1F, $0F,	$18, $4E, $16, $80
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
	smpsVcTotalLevel	$00, $16, $4E, $18

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
	; $3A
	; $01, $07, $01, $01,	$8E, $8E, $8D, $53
	; $0E, $0E, $0E, $03,	$00, $00, $00, $07
	; $1F, $FF, $1F, $0F,	$18, $28, $27, $80
	smpsVcAlgorithm	$02
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$01, $01, $07, $01
	smpsVcRateScale	$01, $02, $02, $02
	smpsVcAttackRate	$13, $0D, $0E, $0E
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$03, $0E, $0E, $0E
	smpsVcDecayRate2	$07, $00, $00, $00
	smpsVcDecayLevel	$00, $01, $0F, $01
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $27, $28, $18
