ChaosEmerald_Header:
	sHeaderInit	; Z80 offset is $FE75
	sHeaderPatch	ChaosEmerald_Patches
	sHeaderCh	$07, $03
	sHeaderTempo	$01, $35
	sHeaderDAC	ChaosEmerald_DAC
	sHeaderFM	ChaosEmerald_FM1, $F4, $08
	sHeaderFM	ChaosEmerald_FM2, $F4, $08
	sHeaderFM	ChaosEmerald_FM3, $F4, $07
	sHeaderFM	ChaosEmerald_FM4, $F4, $16
	sHeaderFM	ChaosEmerald_FM5, $F4, $16
	sHeaderFM	ChaosEmerald_FM6, $F4, $16
	sHeaderPSG	ChaosEmerald_PSG1, $F4, $02, $00, VolEnv_04
	sHeaderPSG	ChaosEmerald_PSG2, $F4, $02, $00, VolEnv_05
	sHeaderPSG	ChaosEmerald_PSG3, $F4, $00, $00, VolEnv_04

ChaosEmerald_FM3:
	saDetune	$02

ChaosEmerald_FM1:
	sPatFM		$00
	dc.b nE5, $06, nG5, nC6, nE6, $0C, nC6, nG6
	dc.b $2A
	sStop

ChaosEmerald_FM2:
	sPatFM		$00
	dc.b nC5, $06, nE5, nG5, nC6, $0C, nA5, nD6
	dc.b $2A
	sStop

ChaosEmerald_FM4:
	sPatFM		$01
	dc.b nE5, $0C, nE5, $06, nG5, $06, nRst, nG5
	dc.b nRst, nC6, $2A
	sStop

ChaosEmerald_FM5:
	sPatFM		$01
	dc.b nC6, $0C, nC6, $06, nE6, $06, nRst, nE6
	dc.b nRst, nG6, $2A
	sStop

ChaosEmerald_FM6:
	sPatFM		$01
	dc.b nG5, $0C, nG5, $06, nC6, $06, nRst, nC6
	dc.b nRst, nE6, $2A
	sStop

ChaosEmerald_PSG2:
	dc.b nRst, $2D
ChaosEmerald_Loop1:
	dc.b nG5, $06, nF5, nE5, nD5
	saVolPSG	$03
	sLoop		$00, $04, ChaosEmerald_Loop1
	sStop

ChaosEmerald_PSG1:
	sFade		$01
	; Unused
	dc.b $80, $02, $80, $2D, $C4, $06, $C2, $C1
	dc.b $BF, $EC, $03, $F7, $00, $04, $02, $FF

ChaosEmerald_DAC:
ChaosEmerald_PSG3:
	sStop

ChaosEmerald_Patches:
	; Patch $00
	; $04
	; $35, $72, $54, $46,	$1F, $1F, $1F, $1F
	; $07, $0A, $07, $0D,	$00, $0B, $00, $0B
	; $1F, $0F, $1F, $0F,	$23, $14, $1D, $80
	spAlgorithm	$04
	spFeedback	$00
	spDetune	$03, $05, $07, $04
	spMultiple	$05, $04, $02, $06
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $0B, $0B
	spSustainRt	$07, $07, $0A, $0D
	spSustainLv	$01, $01, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$23, $1D, $14, $00

	; Patch $01
	; $3C
	; $31, $52, $50, $30,	$52, $53, $52, $53
	; $08, $00, $08, $00,	$04, $00, $04, $00
	; $10, $07, $10, $07,	$1A, $80, $16, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$03, $05, $05, $03
	spMultiple	$01, $00, $02, $00
	spRateScale	$01, $01, $01, $01
	spAttackRt	$12, $12, $13, $13
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$04, $04, $00, $00
	spSustainRt	$08, $08, $00, $00
	spSustainLv	$01, $01, $00, $00
	spReleaseRt	$00, $00, $07, $07
	spTotalLv	$1A, $16, $00, $00
