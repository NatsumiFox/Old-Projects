_1UP_Header:
	sHeaderInit	; Z80 offset is $FD4B
	sHeaderPatch	_1UP_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $20
	sHeaderDAC	_1UP_DAC
	sHeaderFM	_1UP_FM1, $0C, $08
	sHeaderFM	_1UP_FM2, $0C, $19
	sHeaderFM	_1UP_FM3, $00, $0D
	sHeaderFM	_1UP_FM4, $0C, $1B
	sHeaderFM	_1UP_FM5, $0C, $12
	sHeaderPSG	_1UP_PSG1, $00, $03, $00, VolEnv_00
	sHeaderPSG	_1UP_PSG2, $00, $03, $00, VolEnv_00
	sHeaderPSG	_1UP_PSG3, $00, $03, $00, VolEnv_00

_1UP_FM1:
_1UP_Jump1:
	sPatFM		$01
	dc.b nA4, $18, nFs4, $06, nRst, nE4, nRst, nB4
	dc.b $0C, nE4, $06, nRst, nB4, $0C, nD5, nCs5
	dc.b $30
	sStop

_1UP_FM2:
	sPatFM		$03
	dc.b nE4, $18, nCs4, $06, nRst, nA3, nRst, nAb4
	dc.b $0C, nB3, $06, nRst, nAb4, $0C, nB4
	sPatFM		$02
	dc.b nRst, $0C, nA3, $08, nCs4, nE4, nFs4, nAb4
	sStop

_1UP_FM3:
	sPatFM		$00
	sNoteTimeOut	$06
	dc.b nA2, $0C, $06, $06, nFs2, $0C, nE2, nA2
	dc.b $18, nB2, nA2, $0C, nE2, nA2, nE2, nA2
	dc.b $30
	sStop

_1UP_FM4:
	sPatFM		$02
	dc.b nRst, $60, nA4, $10, nB3, $08, nD4, nF4
	dc.b nG4, nA4, $18
	sStop

_1UP_FM5:
	saDetune	$02
	dc.b nRst, $0A
	sJump		_1UP_Jump1
	; Unused
	dc.b $F2

_1UP_PSG1:
	sVolEnvPSG	VolEnv_0A
	dc.b nA3, $30, nB3, nCs4, $30
	sStop

_1UP_PSG2:
	sVolEnvPSG	VolEnv_0A
	dc.b nE3, $30, nAb3, nA3, $30
	sStop

_1UP_PSG3:
	sVolEnvPSG	VolEnv_0A
	dc.b nCs3, $30, nE3, nE3, $30
	sStop

_1UP_DAC:
	dc.b dCrashCymbal, $0C, nRst, $06, dKick, dMuffledSnare, $03, dMuffledSnare
	dc.b dMuffledSnare, dMuffledSnare, dMuffledSnare, $0C, dCrashCymbal, $0C, dMuffledSnare, $06
	dc.b dMuffledSnare, dMuffledSnare, $03, dMuffledSnare, dMuffledSnare, dMuffledSnare, dMuffledSnare, $0C
	dc.b dHiTimpani, $0C, dLowTimpani, dHiTimpani, dLowTimpani, dHiTimpani, $30
	sFade		$FF
	; Unused
	dc.b $F2

_1UP_Patches:
	; Patch $00
	; $3B
	; $0D, $01, $00, $00,	$9F, $1F, $1F, $1F
	; $0E, $0D, $09, $09,	$00, $00, $00, $00
	; $DF, $DF, $DF, $DF,	$33, $15, $17, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$0D, $00, $01, $00
	spRateScale	$02, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spSustainRt	$0E, $09, $0D, $09
	spSustainLv	$0D, $0D, $0D, $0D
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$33, $17, $15, $00

	; Patch $01
	; $3A
	; $01, $07, $01, $01,	$8E, $8E, $8D, $53
	; $0E, $0E, $0E, $03,	$00, $00, $00, $07
	; $1F, $FF, $1F, $0F,	$18, $28, $27, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $01, $07, $01
	spRateScale	$02, $02, $02, $01
	spAttackRt	$0E, $0D, $0E, $13
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $07
	spSustainRt	$0E, $0E, $0E, $03
	spSustainLv	$01, $01, $0F, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$18, $27, $28, $00

	; Patch $02
	; $04
	; $17, $03, $06, $74,	$5F, $5F, $5F, $5F
	; $00, $08, $00, $00,	$00, $00, $00, $0A
	; $0F, $FF, $0F, $0F,	$1C, $88, $23, $88
	spAlgorithm	$04
	spFeedback	$00
	spDetune	$01, $00, $00, $07
	spMultiple	$07, $06, $03, $04
	spRateScale	$01, $01, $01, $01
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $0A
	spSustainRt	$00, $00, $08, $00
	spSustainLv	$00, $00, $0F, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1C, $23, $08, $08

	; Patch $03
	; $3D
	; $01, $01, $01, $01,	$94, $19, $19, $19
	; $0F, $0D, $0D, $0D,	$07, $04, $04, $04
	; $25, $1A, $1A, $1A,	$15, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $01, $01, $01
	spRateScale	$02, $00, $00, $00
	spAttackRt	$14, $19, $19, $19
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$07, $04, $04, $04
	spSustainRt	$0F, $0D, $0D, $0D
	spSustainLv	$02, $01, $01, $01
	spReleaseRt	$05, $0A, $0A, $0A
	spTotalLv	$15, $00, $00, $00
