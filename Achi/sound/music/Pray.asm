Pray_Header:
	sHeaderInit
	sHeaderTempo	$81, $1B
	sHeaderCh	$05, $03
	sHeaderDAC	Pray_DAC1
	sHeaderDAC	Pray_DAC2
	sHeaderFM	Pray_FM1, $00, $0D
	sHeaderFM	Pray_FM4, $00, $0D
	sHeaderFM	Pray_FM3, $00, $0D
	sHeaderFM	Pray_FM2, $00, $0D
	sHeaderFM	Pray_FM5, $00, $15
	sHeaderPSG	Pray_PSG1, $E8, $05, $00, VolEnv_00
	sHeaderPSG	Pray_PSG2, $E8, $05, $00, VolEnv_00
	sHeaderPSG	Pray_PSG3, $1B, $01, $00, VolEnv_00

Pray_Patches:
	; Patch $00
	; $3B
	; $32, $41, $72, $31,	$DF, $9F, $5F, $9F
	; $04, $0C, $0E, $08,	$0F, $0B, $0D, $05
	; $07, $07, $07, $07,	$1C, $19, $27, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$03, $07, $04, $03
	spMultiple	$02, $02, $01, $01
	spRateScale	$03, $01, $02, $02
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$04, $0E, $0C, $08
	spSustainRt	$0F, $0D, $0B, $05
	spSustainLv	$00, $00, $00, $00
	spReleaseRt	$07, $07, $07, $07
	spTotalLv	$1C, $27, $19, $00

	; Patch $01
	; $29
	; $02, $06, $02, $01,	$09, $16, $10, $10
	; $0A, $02, $03, $03,	$05, $05, $05, $05
	; $35, $05, $05, $05,	$14, $15, $29, $89
	spAlgorithm	$01
	spFeedback	$05
	spDetune	$00, $00, $00, $00
	spMultiple	$02, $02, $06, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$09, $10, $16, $10
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0A, $03, $02, $03
	spSustainRt	$05, $05, $05, $05
	spSustainLv	$03, $00, $00, $00
	spReleaseRt	$05, $05, $05, $05
	spTotalLv	$14, $29, $15, $09

	; Patch $02
	; $24
	; $39, $51, $05, $01,	$5F, $9B, $9E, $9E
	; $0F, $07, $0F, $08,	$06, $0A, $0B, $0A
	; $18, $88, $F8, $F8,	$39, $8A, $39, $8A
	spAlgorithm	$04
	spFeedback	$04
	spDetune	$03, $00, $05, $00
	spMultiple	$09, $05, $01, $01
	spRateScale	$01, $02, $02, $02
	spAttackRt	$1F, $1E, $1B, $1E
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0F, $0F, $07, $08
	spSustainRt	$06, $0B, $0A, $0A
	spSustainLv	$01, $0F, $08, $0F
	spReleaseRt	$08, $08, $08, $08
	spTotalLv	$39, $39, $0A, $0A

	; Patch $03
	; $3A
	; $01, $02, $01, $01,	$50, $10, $0E, $52
	; $04, $1F, $1F, $1F,	$00, $00, $00, $00
	; $48, $08, $08, $09,	$1C, $45, $30, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $01, $02, $01
	spRateScale	$01, $00, $00, $01
	spAttackRt	$10, $0E, $10, $12
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$04, $1F, $1F, $1F
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$04, $00, $00, $00
	spReleaseRt	$08, $08, $08, $09
	spTotalLv	$1C, $30, $45, $00

	; Patch $04
	; $06
	; $78, $34, $32, $34,	$18, $3F, $3F, $5F
	; $0B, $11, $10, $0F,	$08, $0C, $0C, $0C
	; $36, $F6, $F6, $F6,	$08, $86, $86, $86
	spAlgorithm	$06
	spFeedback	$00
	spDetune	$07, $03, $03, $03
	spMultiple	$08, $02, $04, $04
	spRateScale	$00, $00, $00, $01
	spAttackRt	$18, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0B, $10, $11, $0F
	spSustainRt	$08, $0C, $0C, $0C
	spSustainLv	$03, $0F, $0F, $0F
	spReleaseRt	$06, $06, $06, $06
	spTotalLv	$08, $06, $06, $06

	; Patch $05
	; $07
	; $00, $01, $02, $04,	$54, $54, $54, $54
	; $00, $00, $00, $00,	$00, $00, $00, $00
	; $07, $07, $07, $07,	$89, $8B, $8C, $8D
	spAlgorithm	$07
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $02, $01, $04
	spRateScale	$01, $01, $01, $01
	spAttackRt	$14, $14, $14, $14
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$00, $00, $00, $00
	spReleaseRt	$07, $07, $07, $07
	spTotalLv	$09, $0C, $0B, $0D

	; Patch $06
	; $5C
	; $41, $75, $70, $39,	$08, $1F, $1F, $1F
	; $02, $02, $14, $03,	$0A, $08, $00, $07
	; $1F, $3F, $4F, $4F,	$03, $84, $04, $86
	spAlgorithm	$04
	spFeedback	$03
	spDetune	$04, $07, $07, $03
	spMultiple	$01, $00, $05, $09
	spRateScale	$00, $00, $00, $00
	spAttackRt	$08, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$02, $14, $02, $03
	spSustainRt	$0A, $00, $08, $07
	spSustainLv	$01, $04, $03, $04
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$03, $04, $04, $06

	; Patch $07
	; $7A
	; $71, $3D, $70, $72,	$1F, $1F, $1F, $1F
	; $09, $14, $16, $0C,	$01, $01, $0A, $02
	; $5A, $6A, $8A, $5A,	$02, $01, $00, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$07, $07, $03, $07
	spMultiple	$01, $00, $0D, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$09, $16, $14, $0C
	spSustainRt	$01, $0A, $01, $02
	spSustainLv	$05, $08, $06, $05
	spReleaseRt	$0A, $0A, $0A, $0A
	spTotalLv	$02, $00, $01, $00

	; Patch $08
	; $20
	; $00, $01, $13, $02,	$11, $10, $11, $1F
	; $00, $11, $00, $00,	$00, $00, $00, $09
	; $0F, $FF, $FF, $0F,	$1A, $10, $1A, $80
	spAlgorithm	$00
	spFeedback	$04
	spDetune	$00, $01, $00, $00
	spMultiple	$00, $03, $01, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$11, $11, $10, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $11, $00
	spSustainRt	$00, $00, $00, $09
	spSustainLv	$00, $0F, $0F, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1A, $1A, $10, $00

	; Patch $09
	; $31
	; $03, $3C, $07, $01,	$2F, $2F, $27, $2C
	; $06, $02, $00, $02,	$00, $00, $00, $00
	; $0A, $0A, $0A, $0A,	$10, $30, $29, $86
	spAlgorithm	$01
	spFeedback	$06
	spDetune	$00, $00, $03, $00
	spMultiple	$03, $07, $0C, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$0F, $07, $0F, $0C
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$06, $00, $02, $02
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$00, $00, $00, $00
	spReleaseRt	$0A, $0A, $0A, $0A
	spTotalLv	$10, $29, $30, $06

	; Patch $0A
	; $3B
	; $03, $3C, $05, $08,	$13, $24, $2F, $34
	; $06, $02, $0A, $08,	$00, $00, $00, $00
	; $0A, $0A, $19, $39,	$14, $31, $27, $87
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$00, $00, $03, $00
	spMultiple	$03, $05, $0C, $08
	spRateScale	$00, $00, $00, $00
	spAttackRt	$13, $0F, $04, $14
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$06, $0A, $02, $08
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$00, $01, $00, $03
	spReleaseRt	$0A, $09, $0A, $09
	spTotalLv	$14, $27, $31, $07

	; Patch $0B
	; $31
	; $71, $31, $21, $70,	$14, $13, $14, $13
	; $01, $07, $07, $04,	$0B, $0A, $07, $0A
	; $0B, $0C, $06, $0B,	$13, $08, $1E, $80
	spAlgorithm	$01
	spFeedback	$06
	spDetune	$07, $02, $03, $07
	spMultiple	$01, $01, $01, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$14, $14, $13, $13
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$01, $07, $07, $04
	spSustainRt	$0B, $07, $0A, $0A
	spSustainLv	$00, $00, $00, $00
	spReleaseRt	$0B, $06, $0C, $0B
	spTotalLv	$13, $1E, $08, $00

	; Patch $0C
	; $0C
	; $73, $3A, $49, $32,	$18, $1D, $1E, $1F
	; $0D, $14, $13, $18,	$0C, $0B, $05, $04
	; $0F, $0F, $0F, $0F,	$02, $86, $12, $86
	spAlgorithm	$04
	spFeedback	$01
	spDetune	$07, $04, $03, $03
	spMultiple	$03, $09, $0A, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$18, $1E, $1D, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0D, $13, $14, $18
	spSustainRt	$0C, $05, $0B, $04
	spSustainLv	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$02, $12, $06, $06

Pray_FM1:
	sComm		$00, bgm_Invincible
	sPan		spCentre, $00
;	saTempoPAL	$1B-$15
	;sNoteTimeIn	$00
	ssMod68k	$01, $01, $00, $00
	sNoteTimeOut	$03
	sPatFM		$04

Pray_Loop22:
	sCall		Pray_Call7
	sLoop		$00, $03, Pray_Loop22
	dc.b nG2, $0C, nG3, nE3, nC3, nBb3, nBb2, $08
	dc.b nEb4, $0C, nEb3, $04, nF4, $08, nF3, $04
	dc.b nRst, $30, nRst

Pray_Cond8:
	sNoteTimeOut	$03
	sPatFM		$04
	;sPanAni		$01, $02, $03, $06, $03

Pray_Jump8:
	sCall		Pray_Call7
	sJump		Pray_Jump8

Pray_FM2:
	sPan		spLeft, $00
	ssMod68k	$01, $01, $00, $00
	sPan		spCenter, $00
	sPatFM		$04
	sNoteTimeOut	$03

Pray_Loop20:
	sCall		Pray_Call5
	sLoop		$00, $03, Pray_Loop20
	dc.b nE3, $0C, nE4, nC4, nG3, nG4, $0C, nG3
	dc.b $08, nBb4, $0C, nBb3, $04, nC5, $08, nC4
	dc.b $04, nRst, $30, nRst

Pray_Cond7:
	;sPanAni		$01, $02, $01, $06, $03
	sPatFM		$04
	sNoteTimeOut	$03

Pray_Jump7:
	sCall		Pray_Call5
	sJump		Pray_Jump7

Pray_FM3:
	sPan		spCentre, $00
	ssMod68k	$01, $01, $00, $00
;	saVolFM		$04
	sPan		spCenter, $00
	sPatFM		$04
	sNoteTimeOut	$03

	sCall		Pray_Call1
	dc.b nC3, $0C, nC4, nG3, nE3, nEb4, $0C, nEb3
	dc.b $08, nG4, $0C, nG3, $04, nBb4, $08, nBb3
	dc.b $04, nC3, $0C, nC4, $08, nC3, $0C, nC4
	dc.b $04, nC3, $0C, nEb4, $08, nEb3, $0C, nEb5
	dc.b $04
	sNoteTimeOut	$00
	sPatFM		$05
	ssMod68k	$0F, $01, $07, $03
	sPan		spLeft, $00
	saTranspose	$0C
	sCall		Pray_Call2
	dc.b nC6, $30, sHold, $30, sHold, $30, sHold, $30
	dc.b sHold, $30, sHold, $30, nRst, $30, nRst
	saTranspose	$F4
	sPan		spCenter, $00
	ssMod68k	$01, $01, $00, $00

Pray_Cond6:
	saVolFM		$FC
	saTranspose	$F4

Pray_Loop15:
Pray_Jump6:
	sPatFM		$00
	sCall		Pray_Call9
	dc.b nBb2, nB2
	sLoop		$00, $03, Pray_Loop15
	sCall		Pray_Call9
	;sNoteTimeIn	$01
	dc.b nC3, $08, nF3, $04, nE3, $08, nC3, $04
	;sNoteTimeIn	$00
	sJump		Pray_Jump6

Pray_FM4:
	sPan		spCentre, $00
;	saVolFM		$08
	;sPanAni		$00
	sNoteTimeOut	$03
	sPatFM		$04
	sPan		spLeft, $00
	saVolFM		$0C
	dc.b nRst, $09
	sCall		Pray_Call7
	sCall		Pray_Call7
	saVolFM		$F4
	sNoteTimeOut	$00
	sPan		spCenter, $00
	sPatFM		$03
	dc.b nRst, $03
	sCall		Pray_Call8
	dc.b nRst, $0C
	sCall		Pray_Call8

Pray_Cond5:
Pray_Jump5:
	sPatFM		$05
	dc.b nC4, $0C, nRst, $08, nG3, $04, nBb3, $08
	dc.b nD4, $04, nRst, $08, nC4, $04, nRst, $08
	dc.b nG3, $04, nRst, $08, nBb3, $04, nRst, $08
	dc.b nD4, $04, nF4, $0C, nE4, nRst, $08, nG3
	dc.b $04, nBb3, $08, nD4, $04, nRst, $08, nC4
	dc.b $04, nRst, $08, nG3, $04, nRst, $08, nBb3
	dc.b $04, nRst, $08, nD4, $04, nA4, $0C, nG4
	dc.b nRst, $08, nC4, $04, nE4, $08, nG4, $04
	dc.b nRst, $08, nF4, $04, nRst, $08, nD4, $04
	dc.b nRst, $08, nF4, $04, nRst, $08, nA4, $04
	dc.b nC5, $0C, nBb4, $30, sHold, $18
	sPatFM		$03
	ssMod68k	$09, $01, $05, $03
	saTranspose	$FB
	sCall		Pray_Call2
	saTranspose	$05
	dc.b nG5, $30, sHold, $17, nRst, $01
	;sNoteTimeIn	$01
	dc.b nE5, $08, nF5, $04, nG5, $08, nF5, $04
	;sNoteTimeIn	$00
	sNoteTimeOut	$00
	dc.b nBb5, $2F, nRst, $01, nA5, $05, nRst, $06
	saVolFM		$0A
	sPan		spRight, $00
	dc.b nA5, $05, nRst, $04
	saVolFM		$F6
	sPan		spCenter, $00
	dc.b nBb5, $05, nRst, $06
	saVolFM		$0A
	sPan		spRight, $00
	dc.b nBb5, $05
	saVolFM		$F6
	sPan		spCenter, $00
	dc.b nA5, $05, nRst, $06
	saVolFM		$0A
	sPan		spRight, $00
	dc.b nA5, $01
	saVolFM		$F6
	sPan		spCenter, $00
	dc.b nG5, $30, sHold, $30, sHold, $30, sHold, $30
	ssMod68k	$01, $01, $00, $00
	sJump		Pray_Jump5

Pray_FM5:
	sPan		spCenter, $00
	;sPanAni		$00
	sNoteTimeOut	$03
	sPatFM		$04
	sPan		spRight, $00
	dc.b nRst, $09
	sCall		Pray_Call5
	sCall		Pray_Call5
	sPan		spCenter, $00
	saVolFM		$F4
	sNoteTimeOut	$00
	sPatFM		$03
	dc.b nRst, $03
	sCall		Pray_Call6
	dc.b nRst, $0C
	sCall		Pray_Call6

Pray_Cond4:
Pray_Jump4:
	sPatFM		$05
	dc.b nRst, $09
	saVolFM		$0A
	sPan		spLeft, $00
	dc.b nC4, $0C, nRst, $08, nG3, $04, nBb3, $08
	dc.b nD4, $04, nRst, $08, nC4, $04, nRst, $08
	dc.b nG3, $04, nRst, $08, nBb3, $04, nRst, $03
	saVolFM		$F6
	sPan		spCenter, $00
	dc.b nD4, $0C, nC4, nRst, $08, nRst, $09
	saVolFM		$0A
	sPan		spLeft, $00
	dc.b nG3, $04, nBb3, $08, nD4, $04, nRst, $08
	dc.b nC4, $04, nRst, $08, nG3, $04, nRst, $08
	dc.b nBb3, $04, nRst, $03
	saVolFM		$F6
	sPan		spCenter, $00
	dc.b nF4, $0C, nE4, nRst, $08, nRst, $09
	saVolFM		$0A
	sPan		spLeft, $00
	dc.b nC4, $04, nE4, $08, nG4, $04, nRst, $08
	dc.b nF4, $04, nRst, $08, nD4, $04, nRst, $08
	dc.b nF4, $04, nRst, $03
	saVolFM		$F6
	sPan		spCenter, $00
	dc.b nA4, $0C, nG4, $30, sHold, $18, nRst, $07
	saVolFM		$0A
	sPan		spRight, $00
	sPatFM		$03
	saTranspose	$FB
	sCall		Pray_Call2
	saTranspose	$05
	dc.b nG5, $30, sHold, $17, nRst, $01
	;sNoteTimeIn	$01
	dc.b nE5, $08, nF5, $04, nG5, $05
	;sNoteTimeIn	$00
	saVolFM		$F6
	sPan		spCenter, $00
	sNoteTimeOut	$00
	dc.b nF5, $2F, nRst, $01, nF5, $05, nRst, $06
	saVolFM		$0A
	sPan		spRight, $00
	dc.b nF5, $05, nRst, $04
	saVolFM		$F6
	sPan		spCenter, $00
	dc.b nG5, $05, nRst, $06
	saVolFM		$0A
	sPan		spRight, $00
	dc.b nG5, $05
	saVolFM		$F6
	sPan		spCenter, $00
	dc.b nF5, $05, nRst, $06
	saVolFM		$0A
	sPan		spRight, $00
	dc.b nF5, $01
	saVolFM		$F6
	sPan		spCenter, $00
	dc.b nE5, $30, sHold, $30, sHold, $30, sHold, $30
	sJump		Pray_Jump4

Pray_PSG1:
	dc.b nRst, $7F, $7F, $69
	ssMod68k	$0B, $01, $03, $02
	saTranspose	$F4
	sVoice		VolEnv_0F
	sCall		Pray_Call2
	saTranspose	$0C
	dc.b nC5, $30, sHold, $30, sHold, $30, sHold, $30
	dc.b sHold, $30, sHold, $30, nRst, $30, nRst

Pray_Cond3:
	ssMod68k	$0D, $01, $03, $02
	saTranspose	$F4
	saVolPSG	$FF
	sVoice		VolEnv_12

Pray_Jump3:
	dc.b nC4, $30, sHold, $30, nBb3, nF4, nE4, $24
	dc.b nF4, $0C, nG4, $14, nG4, $04, nRst, $0C
	dc.b nA4, sHold, nBb4, $30, sHold, $30, nC5, sHold
	dc.b $30, nBb4, nA4, $08, nRst, $0C, nBb4, $08
	dc.b nRst, nA4, nRst, $04, nC5, $30, sHold, $30
	dc.b sHold, $30, sHold, $30
	sJump		Pray_Jump3

Pray_PSG2:
	saTranspose	$0C
	dc.b nRst, $7F, $7F, $7F, $02
	sVoice		VolEnv_02
	sCall		Pray_Call1
	dc.b nC3, $0C, nC4, nG3, nE3, nEb4, $0C, nEb3
	dc.b $08, nG4, $0C, nG3, $04, nBb4, $08, nBb3
	dc.b $04, nRst, $30, nRst, $30
	saTranspose	$F4
	saVolPSG	$02

Pray_Cond2:
	saVolPSG	$FF
	ssMod68k	$0E, $01, $02, $02
	saTranspose	$F4
	sVoice		VolEnv_12

Pray_Jump2:
	dc.b nG3, $30, sHold, $30, nF3, $30, nD4, nC4
	dc.b $24, nD4, $0C, nE4, $14, nE4, $04, nRst
	dc.b $0C, nF4, $0C, sHold, nF4, $30, sHold, $30
	dc.b nE4, sHold, $30, nF4, nF4, $08, nRst, $0C
	dc.b nF4, $08, nRst, $08, nF4, nRst, $04, nE4
	dc.b $30, sHold, $30, sHold, $30, sHold, $30
	sJump		Pray_Jump2

Pray_PSG3:
	sNoisePSG	$E7
	ssMod68k	$01, $01, $00, $00
	dc.b nRst, $7F, $7F, $7F, $02

Pray_Loop4:
	sVoice		VolEnv_13
	dc.b nFs3, $08, $04
	sVoice		VolEnv_10
	dc.b nFs3, $08
	sVoice		VolEnv_13
	dc.b nFs3, $04
	sLoop		$00, $03, Pray_Loop4
	sVoice		VolEnv_13
	dc.b nFs3, $08, $04
	sVoice		VolEnv_10
	dc.b nFs3, $08, $04
	sLoop		$01, $03, Pray_Loop4
	dc.b nRst, $30, nRst

Pray_Cond1:
Pray_Loop1:
Pray_Jump1:
	sVoice		VolEnv_13
	dc.b nFs3, $08, $04
	sVoice		VolEnv_10
	dc.b nFs3, $08
	sVoice		VolEnv_13
	dc.b nFs3, $04
	sLoop		$00, $16, Pray_Loop1
	sVoice		VolEnv_10
	dc.b nFs3, $14, $10, $0C
	sVoice		VolEnv_13

Pray_Loop2:
	dc.b nFs3, $08, $04
	sVoice		VolEnv_10
	dc.b nFs3, $08
	sVoice		VolEnv_13
	dc.b nFs3, $04
	sLoop		$00, $08, Pray_Loop2
	sJump		Pray_Jump1

; 81 - kick
; 84 - low kick
; 87 - high pitch weird sound
; 88 - lower volume similar to 87
; 97 - Tom-like
; 99 - Tom
; 9A - Tom but higher
; 9B - and higher
; 9C - Ristar wow
; 9D - Ristar sound
; 9F - Ristar laughs
; A1 - Ristar sound

d9C = nrst
d9D = nrst
d9F = nrst
dA1 = nrst
d97 = dSnare
d87 = dClap
d88 = dClap

Pray_DAC1:
	dc.b nRst, $7F, $7F, $7F, $7F, $7F, $7F, $06; E3D

Pray_Cond10:
Pray_Loop25:
Pray_Jump10:
	dc.b nRst, $18, d97, nRst, d97
	sLoop		$00, $03, Pray_Loop25
	dc.b nRst, $18, d97, $14, d88, $0C, d97, $10
	dc.b $08, dHiTom, $04, dTom, $08, dLowTom, $04, nRst
	dc.b $18, d97, nRst, d97, nRst, d97, $14, d88
	dc.b $0C, d97, $10, $04, dHiTom, dTom, dLowTom, dLowTom
	dc.b dLowTom, nRst, $18, d97, nRst, d97, nRst, d97
	dc.b $14, d88, $0C, d97, $10, $08, dHiTom, $04
	dc.b dTom, $08, dLowTom, $04
	sJump		Pray_Jump10

Pray_DAC2:
	dc.b nRst, $7F, $7F, $7F, $03

Pray_Loop24:
	dc.b dKick, $18, dKick, dKick, dKick
	sLoop		$00, $03, Pray_Loop24
	dc.b d9F, $27, d88, $03, d88, d88, d87, $0C
	dc.b d87, $08, d87, $04, nRst, $08, d88, $04
	dc.b d87, $0C; 300
; (3*0x7F)+3+(4*3*0x18)+0x27+0x3+0x3+0x3+0xc+0x8+0x4+0x8+0x4+0xc
Pray_Cond9:
Pray_Loop23:
Pray_Jump9:
	dc.b dKick, $18, dKick, $14, dKick, $04, dKick, $0C
	dc.b dKick, dKick, dKick
	sLoop		$00, $07, Pray_Loop23
	dc.b dKick, $18, dKick, $14, dKick, $04, dKick, $0C
	dc.b dKick, dKick, d9D, $0C
	sJump		Pray_Jump9

Pray_Call2:
	dc.b nC5, $0F, nD5, $01, nE5, $02, nF5, $01
	dc.b nG5, $02, nA5, $01, nBb5, $02
	sRet

Pray_Call8:
	sPan		spRight, $00
	dc.b nG4, $04, nRst, $07
	sPan		spCenter, $00
	saVolFM		$0C
	dc.b nG4, $04, nRst, $05
	saVolFM		$F4
	sPan		spRight, $00
	dc.b nA4, $04, nRst, $07
	sPan		spCenter, $00
	saVolFM		$0C
	dc.b nA4, $04, nRst, $01
	saVolFM		$F4
	sPan		spRight, $00
	dc.b nBb4, $04, nRst, $07
	sPan		spCenter, $00
	saVolFM		$0C
	dc.b nBb4, $04, nRst, $05
	saVolFM		$F4
	sPan		spRight, $00
	dc.b nA4, $0B, nRst, $01, nBb4, $03, nRst, $01
	dc.b nA4, $04, nRst, $07
	sPan		spCenter, $00
	saVolFM		$0C
	dc.b nA4, $04, nRst, $30, nRst, $2D
	saVolFM		$F4
	sRet

Pray_Call6:
	sPan		spRight, $00
	dc.b nE4, $04, nRst, $07
	sPan		spCenter, $00
	saVolFM		$0C
	dc.b nE4, $04, nRst, $05
	saVolFM		$F4
	sPan		spRight, $00
	dc.b nF4, $04, nRst, $07
	sPan		spCenter, $00
	saVolFM		$0C
	dc.b nF4, $04, nRst, $01
	saVolFM		$F4
	sPan		spRight, $00
	dc.b nG4, $04, nRst, $07
	sPan		spCenter, $00
	saVolFM		$0C
	dc.b nG4, $04, nRst, $05
	saVolFM		$F4
	sPan		spRight, $00
	dc.b nF4, $0B, nRst, $01, nG4, $03, nRst, $01
	dc.b nF4, $04, nRst, $07
	sPan		spCenter, $00
	saVolFM		$0C
	dc.b nF4, $04, nRst, $30, nRst, $2D
	saVolFM		$F4
	sRet

Pray_Call9:
	sNoteTimeOut	$06
	dc.b nC3, $0C, nC3, nC3, nC3, $08
	sNoteTimeOut	$03
	dc.b nC3, $04, nRst, $08, nC3, $04
	sNoteTimeOut	$0B
	dc.b nC3, $0C
	sRet

Pray_Call10:
	saVolFM		$18
	dc.b nC5, $06

Pray_Loop16:
	saVolFM		$FE
	dc.b sHold, $06
	sLoop		$00, $0C, Pray_Loop16
	dc.b sHold, $12
	sRet

Pray_Call11:
	saVolFM		$1E
	dc.b nC5, $03

Pray_Loop17:
	saVolFM		$FD
	dc.b sHold, $03
	sLoop		$00, $0C, Pray_Loop17
	dc.b sHold, $09
	sRet

Pray_Call3:
	dc.b nC3, $08, nBb3, nC4, nF4, nBb4, nC5, nF5
	dc.b nBb5, nC6, nF6, nBb6, nC7
	sRet

Pray_Call4:
	dc.b nC3, $04, nBb3, nC4, nF4, nBb4, nC5, nF5
	dc.b nBb5, nC6, nF6, nBb6, nC7
	sRet

Pray_Call7:
	dc.b nG2, $0C, nG3, nE3, nC3, nBb3, $0C, nBb2
	dc.b $08, nEb4, $0C, nEb3, $04, nF4, $08, nF3
	dc.b $04, nG2, $0C, nG3, $08, nG2, $0C, nG3
	dc.b $04, nG2, $0C, nBb3, $08, nBb2, $0C, nBb4
	dc.b $04, nBb3, $0C, nBb3, $08, nBb2, $04
	sRet

Pray_Call5:
	dc.b nE3, $0C, nE4, nC4, nG3, nG4, $0C, nG3
	dc.b $08, nBb4, $0C, nBb3, $04, nC5, $08, nC4
	dc.b $04, nE3, $0C, nE4, $08, nE3, $0C, nE4
	dc.b $04, nE3, $0C, nF4, $08, nF3, $0C, nF5
	dc.b $04, nF4, $0C, $08, nF3, $04
	sRet

Pray_Call1:
	dc.b nC3, $0C, nC4, nG3, nE3, nEb4, $0C, nEb3
	dc.b $08, nG4, $0C, nG3, $04, nBb4, $08, nBb3
	dc.b $04, nC3, $0C, nC4, $08, nC3, $0C, nC4
	dc.b $04, nC3, $0C, nEb4, $08, nEb3, $0C, nEb5
	dc.b $04, nEb4, $0C, $08, nEb3, $04
	sRet
