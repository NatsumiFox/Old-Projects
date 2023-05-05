ResTie_Header:
	sHeaderInit	; made by Egor
	sHeaderPatch	ResTie_Voices
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $06

	sHeaderDAC	ResTie_DAC
	sHeaderFM	ResTie_FM1,	$00, $12
	sHeaderFM	ResTie_FM2,	$00, $18
	sHeaderFM	ResTie_FM3,	$00, $18
	sHeaderFM	ResTie_FM4,	$00, $18
	sHeaderFM	ResTie_FM5,	$00, $1C
	sHeaderPSG	ResTie_PSG1,	$0C, $02, $00, VolEnv_03
	sHeaderPSG	ResTie_PSG2,	$0C, $02, $00, VolEnv_03
	sHeaderPSG	ResTie_PSG3,	$00, $05, $00, $00

ResTie_Voices:
; Voice $00
	dc.b $28
	dc.b $71, $00, $30, $01, 	$1F, $1F, $1D, $1F, 	$13, $13, $06, $05
	dc.b $03, $03, $02, $05, 	$4F, $4F, $2F, $3F, 	$0E, $14, $1E, $80

; Voice $01
	dc.b $3C
	dc.b $71, $72, $3F, $34, 	$8D, $52, $9F, $1F, 	$09, $00, $00, $0D
	dc.b $00, $00, $00, $00, 	$23, $08, $02, $F7, 	$15, $80, $1D, $87

; Voice $02
	dc.b $3D
	dc.b $01, $01, $01, $01, 	$94, $19, $19, $19, 	$0F, $0D, $0D, $0D
	dc.b $07, $04, $04, $04, 	$25, $1A, $1A, $1A, 	$15, $80, $80, $80

; Voice $03
	dc.b $07
	dc.b $73, $33, $33, $73, 	$0F, $14, $19, $1A, 	$0A, $0A, $0A, $0A
	dc.b $0A, $0A, $0A, $0A, 	$57, $57, $57, $57, 	$80, $80, $80, $80


	; Patch $04
	; $3E
	; $07, $01, $02, $01,	$1F, $1F, $1F, $1F
	; $0D, $06, $00, $00,	$08, $06, $00, $00
	; $15, $0A, $0A, $0A,	$1B, $80, $80, $80
	spAlgorithm	$06
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$07, $02, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$08, $00, $06, $00
	spSustainRt	$0D, $00, $06, $00
	spSustainLv	$01, $00, $00, $00
	spReleaseRt	$05, $0A, $0A, $0A
	spTotalLv	$1B, $00, $00, $00

; DAC Data
ResTie_DAC:
	sCall		ResTie_DAC_0
	dc.b dCrashCymbal, $47, dSnare, $03, $04, $03
	dc.b dElectricMidTom, $09, $09, dElectricLowTom
	sStop

ResTie_DAC_0:
	sPan		spCentre, $00
	dc.b dCrashCymbal, $07, dKick

ResTie_Loop00:
	dc.b dKick, $0D, dSnare, $07, dKick, $0D, $07, dSnare, $0E
	sLoop		$00, $03, ResTie_Loop00
	dc.b dCrashCymbal, $06, dElectricMidTom, $07, dSnare, dCrashCymbal, dElectricMidTom, $06
	dc.b dKick, $07
	sRet

; FM1 Data
ResTie_FM1:
	sPatFM		$00

ResTie_FM1_0:
	sPan		spCentre, $00

ResTie_Loop01:
	dc.b nD2, $0E, nD3, $06, nA2, $07
	sLoop		$00, $03, ResTie_Loop01
	dc.b nD2, $0E, nD3, $06, nD4, $07

ResTie_Loop02:
	dc.b nE2, $0E, nE3, $06, nB2, $07
	sLoop		$00, $03, ResTie_Loop02
	dc.b nE2, nD2, nCs2, $06, nB1, $07

ResTie_Loop03:
	dc.b nA1, $0E, nRst, $0D
	sLoop		$00, $03, ResTie_Loop03
	dc.b nA1, $07, nG1, nF1, $06, nD1, $07
	sStop

; FM2 Data
ResTie_FM2:
	sPatFM		$01
	sPan		spCentre, $00
	dc.b nRst, $36, nD6, $04, nRst, $03, nD6, nRst, $04, nD6, $28, nRst
	dc.b $0E, nB5, $03, nRst, nB5, $04, nRst, $03, nB5, $22, nRst, $07
	dc.b nB5, $03, nRst, nB5, $04, nRst, $03, nB5, $1B, nA5, $47, nRst
	dc.b $0A, nA5, $09, $09, $09
	sStop

; FM3 Data
ResTie_FM3:
	sPatFM		$02
	sPan		spCentre, $00
	dc.b nRst, $36, nFs5, $04, nRst, $03, nFs5, nRst, $04, nFs5, $28, nRst
	dc.b $0E, nAb5, $03, nRst, nAb5, $04, nRst, $03, nAb5, $22, nRst, $07
	dc.b nA5, $03, nRst, nA5, $04, nRst, $03, nA5, $1B, nE5, $47, nRst
	dc.b $0A, nE5, $09, $09, $09
	sStop

; FM4 Data
ResTie_FM4:
	sPatFM		$02
	sPan		spCentre, $00
	dc.b nRst, $36, nD5, $04, nRst, $03, nD5, nRst, $04, nD5, $28, nRst
	dc.b $0E, nD5, $03, nRst, nD5, $04, nRst, $03, nD5, $22, nRst, $07
	dc.b nD5, $03, nRst, nD5, $04, nRst, $03, nD5, $1B, nE5, $47, nRst
	dc.b $0A, nE5, $09, $09, $09
	sStop

; FM5 Data
ResTie_FM5:
	sPatFM		$02
	sPan		spCentre, $00
	dc.b nRst, $36, nD4, $04, nRst, $03, nD4, nRst, $04, nD4, $28, nRst
	dc.b $0E, nE4, $03, nRst, nE4, $04, nRst, $03, nE4, $22, nRst, $07
	dc.b nE4, $03, nRst, nE4, $04, nRst, $03, nE4, $1B, nA4, $47, nRst
	dc.b $0A, nA4, $09, $09, $09
	sStop

; PSG1 Data
ResTie_PSG1:
	dc.b nA1, $0E, $06, $07, $07, nRst, nA1, $6C, $06, nBb1, $07, nB1
	dc.b $36
	saVolPSG	$02
	dc.b nA1, $0E, nRst, $06
	saVolPSG	$03
	dc.b nA1, $0E, nRst, $07
	saVolPSG	$04
	dc.b nA1, $0D, nRst, $07, nA1, $0D
	sStop

; PSG2 Data
ResTie_PSG2:
	dc.b nB1, $0E, $06, $07, nA1, nRst, nD2, $28, nB1, $07, nC2, nCs2
	dc.b $06, nD2, $07, $29, $06, nEb2, $07, nE2, $2F, nRst, $07
	saVolPSG	$02
	dc.b nE2, $0E, nRst, $06
	saVolPSG	$03
	dc.b nE2, $0E, nRst, $07
	saVolPSG	$04
	dc.b nE2, $0D, nRst, $07, nE2, $0D
	sStop

; PSG3 Data
ResTie_PSG3:
	sNoisePSG	$E7
	dc.b nRst, $0E, nBb6

ResTie_Loop04:
	dc.b $0D, $0E, $0D
	sVolEnvPSG	VolEnv_04
	dc.b $0E
	sVolEnvPSG	VolEnv_01
	sLoop		$00, $03, ResTie_Loop04
	dc.b $0D, $0E, $0D
	sStop

