Knuckles_Header:
	sHeaderInit	; Z80 offset is $F5A3
	sHeaderPatch	Knuckles_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $10
	sHeaderDAC	Knuckles_DAC
	sHeaderFM	Knuckles_FM1, $0C, $11
	sHeaderFM	Knuckles_FM2, $FE, $00
	sHeaderFM	Knuckles_FM3, $0C, $17
	sHeaderFM	Knuckles_FM4, $F4, $0E
	sHeaderFM	Knuckles_FM5, $18, $10
	sHeaderPSG	Knuckles_PSG1, $F4, $05, $00, VolEnv_00
	sHeaderPSG	Knuckles_PSG2, $F4, $02, $00, VolEnv_00
	sHeaderPSG	Knuckles_PSG3, $00, $03, $00, VolEnv_00

Knuckles_FM1:
Knuckles_Jump5:
	sPatFM		$05

Knuckles_Jump6:
	dc.b nA3, $06, nG3, nG3, nG3, nG3, nE3, nE3
	dc.b nE3, nD3, nE3, nD3, nC3, nC3, nA2, nA2
	dc.b nA2, nRst, $0C, nE3, nE3, nD3, nC3, nA2
	dc.b nA2, nA2, nG2, nA2, nA2, nA2, nC3, nA2
	dc.b nA2, nA2, nRst, $0C, nE3, nE3, nD3, nC3
	dc.b nA2, nA2, nA2, nA3, nA3, nG3, nE3, nE3
	dc.b nA2, nRst, nA2, nRst, nE3, nE3, nD3, nC3
	dc.b nA2, nA2, nA2, nG2, nA2, nA2, nA2, nC3
	dc.b nA2, nA2, nA2, nRst, nE3, nE3, nD3, nC3
	dc.b nA2, nA2, nA2, nG2, nA2, nA3, nG3, nA3
	dc.b $06, nA1, $03, nB1, nC2, nD2, nE2, nF2
	dc.b nG2, nA2, nB2, nC3, nD3, nE3, nF3, nG3
	sJump		Knuckles_Jump6
	; Unused
	dc.b $F2

Knuckles_FM2:
	ssModZ80	$01, $01, $F0, $00

Knuckles_Jump7:
	dc.b nRst, $60
Knuckles_Loop2:
	sPatFM		$04
	dc.b nG3, $13, $05, nD3, $0C
	sPatFM		$07
	dc.b nRst
	sLoop		$00, $10, Knuckles_Loop2
	sJump		Knuckles_Jump7
	; Unused
	dc.b $F2

Knuckles_FM3:
	dc.b nRst, $0C
	saDetune	$FE
	sJump		Knuckles_Jump5
	; Unused
	dc.b $F2

Knuckles_FM4:
Knuckles_Jump4:
	sPatFM		$06
	sNoteTimeOut	$05
	dc.b nA5, $06, nG5, nG5, nG5, nG5, nE5, nE5
	dc.b nE5, nD5, nE5, nD5, nC5, nC5, nA4, nA4
	dc.b nA4, nRst, $60, nRst, nRst, nA5, $0C
	sNoteTimeOut	$0B
	dc.b $0C, nG5, nE5
	sNoteTimeOut	$15
	dc.b nE5, $18, nRst, nRst, $60, nRst, nRst
	sNoteTimeOut	$0C
	dc.b nRst, $18, nA5, $0C, nG5, nA5, nRst, $24
	sJump		Knuckles_Jump4
	; Unused
	dc.b $F2

Knuckles_FM5:
	saDetune	$FE
	saTranspose	$E8
	sJump		Knuckles_Jump4
	; Unused
	dc.b $EF, $03, $E1, $02, $F2

Knuckles_PSG1:
	sVolEnvPSG	VolEnv_0A
	dc.b nRst, $0B

Knuckles_Jump3:
	dc.b nRst, $60, nA3, $0C
	sNoteTimeOut	$05
	dc.b $06, $06
	sNoteTimeOut	$00
	dc.b $0C, $0C, nC4, $24, nA3, $0C, nC4, nD4
	dc.b nBb3, $01, sHold, nA3, $23, $06, $06, $06
	dc.b nRst, nA3, $0C, nAb3, $02, sHold, nG3, $0A
	dc.b nE3, $0C, nE3, $24, nC3, $0C, nD3, nE3
	dc.b nE3, $02, sHold, nD3, $0A, nC3, $0C, nA2
	dc.b $48, nA3, $0C
	sNoteTimeOut	$05
	dc.b $06, $06, $06, $06, $06, $06
	sNoteTimeOut	$00
	dc.b nC4, $24, nA3, $0C, nC4, nD4, nA3, $24
	sNoteTimeOut	$05
	dc.b $06, $06, $06, $06
	sNoteTimeOut	$00
	dc.b $0C, nE4, nD4, sHold, nD4, nC4, nC4, $01
	dc.b sHold, nCs4, sHold, nD4, sHold, nC4, $09, nA3
	dc.b $0C, nA3, nG3, nA3, nRst, nA4, nG4, nA4
	dc.b nRst, nRst, nRst
	sJump		Knuckles_Jump3
	; Unused
	dc.b $F2

Knuckles_PSG2:
	sVolEnvPSG	VolEnv_0A
	saDetune	$FF

Knuckles_Jump2:
	dc.b nRst, $60, nA3, $0C
	sNoteTimeOut	$05
	dc.b $06, $06
	sNoteTimeOut	$00
	dc.b $0C, $0C, nC4, $24, nA3, $0C, nC4, nD4
	dc.b nBb3, $01, sHold, nA3, $23, $06, $06, $06
	dc.b nRst, nA3, $0C, nAb3, $02, sHold, nG3, $0A
	dc.b nE3, $0C, nE3, $24, nC3, $0C, nD3, nE3
	dc.b nE3, $02, sHold, nD3, $0A, nC3, $0C, nA2
	dc.b $48, nA3, $0C
	sNoteTimeOut	$05
	dc.b $06, $06, $06, $06, $06, $06
	sNoteTimeOut	$00
	dc.b nC4, $24, nA3, $0C, nC4, nD4, nA3, $24
	sNoteTimeOut	$05
	dc.b $06, $06, $06, $06
	sNoteTimeOut	$00
	dc.b $0C
	saDetune	$00
	dc.b nE4
	saDetune	$FF
	dc.b nD4, sHold, nD4, nC4, nC4, $01, sHold, nCs4
	dc.b sHold, nD4, sHold, nC4, $09, nA3, $0C, nA3
	dc.b nG3, nA3, nRst, nA4, nG4, nA4, nRst, nRst
	dc.b nRst
	sJump		Knuckles_Jump2
	; Unused
	dc.b $F2

Knuckles_PSG3:
	sNoisePSG	$E7

Knuckles_Jump1:
	sVolEnvPSG	VolEnv_26
	dc.b nB6, $60
	sVolEnvPSG	VolEnv_01

Knuckles_Loop1:
	dc.b nB6, $06, nRst, nB6, nRst, nB6, nRst, nB6
	dc.b nRst, nB6, nRst, nB6, nRst, nB6, nRst, nB6
	dc.b nRst
	sLoop		$00, $08, Knuckles_Loop1
	sJump		Knuckles_Jump1
	; Unused
	dc.b $F2

Knuckles_DAC:
Knuckles_Jump8:
	dc.b dCrashCymbal, $3C, dEchoedClapHit, $06, dEchoedClapHit, nRst, dEchoedClapHit, dEchoedClapHit
	dc.b nRst
Knuckles_Loop3:
	dc.b dLooserSnare, $18, dElectricFloorTom, dElectricFloorTom, $0C, dEchoedClapHit, $06, dEchoedClapHit
	dc.b dElectricFloorTom, dEchoedClapHit, dEchoedClapHit, nRst
	sLoop		$00, $08, Knuckles_Loop3
	sJump		Knuckles_Jump8
	; Unused
	dc.b $F2

Knuckles_Patches:
	; Patch $00
	; $01
	; $02, $00, $00, $00,	$1F, $1F, $1F, $1F
	; $10, $18, $18, $10,	$0E, $00, $00, $08
	; $FF, $FF, $FF, $0F,	$12, $10, $10, $80
	spAlgorithm	$01
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$02, $00, $00, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0E, $00, $00, $08
	spSustainRt	$10, $18, $18, $10
	spSustainLv	$0F, $0F, $0F, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$12, $10, $10, $00

	; Patch $01
	; $05
	; $00, $00, $00, $00,	$1F, $1F, $1F, $1F
	; $12, $0C, $0C, $0C,	$12, $18, $1F, $1F
	; $1F, $1F, $1F, $1F,	$07, $86, $86, $86
	spAlgorithm	$05
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $00, $00, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$12, $1F, $18, $1F
	spSustainRt	$12, $0C, $0C, $0C
	spSustainLv	$01, $01, $01, $01
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$07, $06, $06, $06

	; Patch $02
	; $3C
	; $00, $00, $F0, $F1,	$1F, $1F, $17, $1F
	; $1F, $1F, $14, $1F,	$09, $11, $3A, $1D
	; $02, $0F, $9F, $7F,	$03, $80, $02, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$00, $0F, $00, $0F
	spMultiple	$00, $00, $00, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $17, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$09, $3A, $11, $1D
	spSustainRt	$1F, $14, $1F, $1F
	spSustainLv	$00, $09, $00, $07
	spReleaseRt	$02, $0F, $0F, $0F
	spTotalLv	$03, $02, $00, $00

	; Patch $03
	; $3C
	; $22, $00, $01, $10,	$12, $13, $12, $12
	; $00, $00, $00, $10,	$00, $00, $00, $00
	; $0F, $0F, $0F, $3F,	$23, $90, $1E, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$02, $00, $00, $01
	spMultiple	$02, $01, $00, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$12, $12, $13, $12
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$00, $00, $00, $10
	spSustainLv	$00, $00, $00, $03
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$23, $1E, $10, $00

	; Patch $04
	; $00
	; $00, $03, $02, $00,	$D9, $DF, $1F, $1F
	; $12, $11, $14, $0C,	$0A, $00, $0A, $02
	; $FF, $FF, $FF, $FF,	$22, $07, $27, $85
	spAlgorithm	$00
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $02, $03, $00
	spRateScale	$03, $00, $03, $00
	spAttackRt	$19, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0A, $0A, $00, $02
	spSustainRt	$12, $14, $11, $0C
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$22, $27, $07, $05

	; Patch $05
	; $3C
	; $36, $31, $76, $72,	$94, $9F, $96, $9F
	; $12, $00, $14, $0F,	$04, $0A, $04, $0D
	; $2F, $0F, $4F, $2F,	$33, $80, $1A, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$03, $07, $03, $07
	spMultiple	$06, $06, $01, $02
	spRateScale	$02, $02, $02, $02
	spAttackRt	$14, $16, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$04, $04, $0A, $0D
	spSustainRt	$12, $14, $00, $0F
	spSustainLv	$02, $04, $00, $02
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$33, $1A, $00, $00

	; Patch $06
	; $3A
	; $01, $07, $31, $71,	$8E, $8E, $8D, $53
	; $0E, $0E, $0E, $03,	$00, $00, $00, $07
	; $1F, $FF, $1F, $0F,	$18, $28, $27, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$00, $03, $00, $07
	spMultiple	$01, $01, $07, $01
	spRateScale	$02, $02, $02, $01
	spAttackRt	$0E, $0D, $0E, $13
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $07
	spSustainRt	$0E, $0E, $0E, $03
	spSustainLv	$01, $01, $0F, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$18, $27, $28, $00

	; Patch $07
	; $01
	; $DF, $09, $03, $09,	$10, $1F, $1F, $1F
	; $09, $00, $00, $0E,	$00, $00, $00, $13
	; $15, $05, $05, $3A,	$0C, $08, $0C, $80
	spAlgorithm	$01
	spFeedback	$00
	spDetune	$0D, $00, $00, $00
	spMultiple	$0F, $03, $09, $09
	spRateScale	$00, $00, $00, $00
	spAttackRt	$10, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $13
	spSustainRt	$09, $00, $00, $0E
	spSustainLv	$01, $00, $00, $03
	spReleaseRt	$05, $05, $05, $0A
	spTotalLv	$0C, $0C, $08, $00
