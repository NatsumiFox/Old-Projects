CredE_Header:
	sHeaderInit	; made by Egor
	sHeaderPatch	CredE_Voices
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $7F

	sHeaderDAC	CredE_DAC
	sHeaderFM	CredE_FM1, $00, $10
	sHeaderFM	CredE_FM2, $00, $0C
	sHeaderFM	CredE_FM3, $00, $0E
	sHeaderFM	CredE_FM4, $00, $0C+6
	sHeaderFM	CredE_FM5, $00, $0E
	sHeaderPSG	CredE_PSG1, $0C, $07, $00, VolEnv_0D
	sHeaderPSG	CredE_PSG2, $0C, $09, $00, VolEnv_0D
	sHeaderPSG	CredE_PSG3, $00, $04, $00, VolEnv_02

CredE_Voices:
;	Voice $00
	dc.b $3C
	dc.b $02, $32, $31, $02, 	$53, $50, $53, $50, 	$0D, $08, $0D, $08
	dc.b $00, $00, $00, $00, 	$18, $18, $28, $18, 	$1A, $8C, $1B, $8C

;	Voice $01
	dc.b $3C
	dc.b $01, $00, $00, $00, 	$1F, $1F, $15, $1F, 	$11, $0D, $12, $05
	dc.b $07, $04, $09, $02, 	$55, $3A, $25, $1A, 	$1A, $80, $07, $80

;	Voice $02
	dc.b $3E
	dc.b $77, $71, $32, $31, 	$1F, $1F, $1F, $1F, 	$0D, $06, $00, $00
	dc.b $08, $06, $00, $00, 	$15, $06, $06, $06, 	$1B, $8F, $8F, $8F

;	Voice $03
	dc.b $3A
	dc.b $71, $0C, $33, $01, 	$5F, $5F, $5F, $5F, 	$04, $09, $04, $0A
	dc.b $00, $01, $03, $06, 	$15, $12, $16, $28, 	$25, $2F, $25, $82

;	Voice $04
	dc.b $3C
	dc.b $71, $72, $3F, $34, 	$8D, $52, $9F, $1F, 	$09, $00, $00, $0D
	dc.b $00, $00, $00, $00, 	$23, $08, $02, $F7, 	$15, $80, $1D, $87

; DAC Data
CredE_DAC:
	sPan		spCentre, $00
	dc.b dCrashCymbal, $18, dSnare, dDanceStyleKick, dSnare, dDanceStyleKick, dSnare, dDanceStyleKick, dSnare, $0C, dDanceStyleKick, dCrashCymbal
	dc.b $18, dSnare, dDanceStyleKick, dSnare, dDanceStyleKick, dSnare, dDanceStyleKick, dSnare, $0C, dDanceStyleKick, $06, dElectricMidTom
	dc.b $03, $03, dCrashCymbal, $18, dSnare, dDanceStyleKick, dSnare, dDanceStyleKick, dSnare, dDanceStyleKick, dSnare, dCrashCymbal
	dc.b dSnare, dDanceStyleKick, dSnare, dDanceStyleKick, dSnare, dDanceStyleKick, $0C, $0C, $0C, $0C, dCrashCymbal

CredE_Loop00:
	dc.b dDanceStyleKick
	sLoop		$00, $1F, CredE_Loop00
	dc.b dCrashCymbal

CredE_Loop01:
	dc.b dSnare, dDanceStyleKick
	sLoop		$00, $0B, CredE_Loop01

CredE_Loop02:
	dc.b dSnare, dSnare, dSnare, dSnare, dSnare, dSnare, $03
	sLoop		$00, $02, CredE_Loop02
	dc.b $40
	dc.b nRst, $2F
	sJump		CredE_DAC

; FM1 Data
CredE_FM1:
	sPatFM		$01
	sPan		spCentre, $00
	dc.b nG2, $30, nFs2, $24, nCs3, $01, nE3, $0B, nB2, $24, nA2, $01
	dc.b nFs2, $05, nA2, $2A, nF2, $01, nFs2, $0B, nG2, $30, nFs2, nB2
	dc.b $24, nD3, $01, nE3, $05, nFs3, $0C, nE3, $06, nB2, nA2, nFs2
	dc.b nE2, nF2, $01, nFs2, $0B, nG2, $30, nFs2, $24, nCs3, $01, nE3
	dc.b $0B, nB2, $24, nA2, $01, nFs2, $05, nA2, $2A, nF2, $01, nFs2
	dc.b $0B, nG2, $30, nFs2, nB2, nB2, $06, nRst, nB2, nRst, nB2, nRst
	dc.b nFs3, $02, nF3, $01, nE3, $02, nD3, $01, nC3, $02, nB2, $01
	dc.b nA2, $02, nG2, $01, $0C

CredE_Loop0D:
	dc.b nRst, $06, nG2, $0C, nRst, $06, nG2, $0C, nRst, $06, nFs2, $0C
	dc.b nRst, $06, nFs2, $0C, nRst, $06, nG2, $03, nA2

CredE_Loop0C:
	dc.b nB2, $0C, nRst, $06
	sLoop		$00, $05, CredE_Loop0C
	dc.b nB2, $03, nA2, nG2, $0C
	sLoop		$01, $02, CredE_Loop0D
	dc.b nRst, $06, nG2, $0C, nRst, $06, nG2, $0C, nRst, $06, nFs2, $0C
	dc.b nRst, $06, nFs2, $0C, nRst, $06, nAb2, $03, nA2

CredE_Loop0E:
	dc.b nB2, $0C, nRst, $06
	sLoop		$00, $05, CredE_Loop0E
	dc.b nB2, $03, nA2

CredE_Loop0F:
	dc.b nG2, $0C, nRst, $06
	sLoop		$00, $03, CredE_Loop0F
	dc.b nFs2, $0C, nRst, $06, nFs2, $0C, nRst, $06, nAb2, $03, nA2

CredE_Loop10:
	dc.b nB2, $0C, nRst, $06
	sLoop		$00, $04, CredE_Loop10
	dc.b nB2, $02, nA2, $01, nG2, $02, nF2, $01, nE2, $02, nD2, $01
	dc.b nC2, $02, nB1, $01
	dc.b nRst, $60
	sJump		CredE_FM1

; FM2 Data
CredE_FM2:
	sPatFM		$02
	sPan		spCentre, $00
	dc.b nRst, $12, nFs4, $03, nRst, nFs4, nRst, nG4, nRst, nA4, $06, nD4
	dc.b $2A, nCs5, $01, nD5, $0B, nCs5, $12, nA4, nFs4, $06, nA4, $36
	dc.b nRst, $12, nFs4, $03, nRst, nFs4, nRst, nG4, nRst, nA4, $06, nD4
	dc.b $2A, nCs4, $06, nD4, $2A, nE4, $06, nFs4, $36, nRst, $12, nFs4
	dc.b $03, nRst, nFs4, nRst, nG4, nRst, nA4, $06, nD4, $2A, nD5, $0C
	dc.b nCs5, $12, nA4, nFs4, $06, nA4, $36, nRst, $12, nFs4, $03, nRst
	dc.b nFs4, nRst, nG4, nRst, nA4, $06, nD4, $2A, nCs4, $06, nD4, $2A
	dc.b nRst, $4E
	sPatFM		$04
	dc.b nFs4, $03, nRst, nFs4, nRst, nG4, nRst, nA4, $06, nD4, $12, nRst
	dc.b $18, nCs5, $01, nD5, $0B, nCs5, $0C, nA4, $03, nRst, nA4, $06
	dc.b nRst, nFs4, nRst, nAb4, $01, nA4, $11, nRst, $36, nD4, $03, nRst
	dc.b nD4, nRst, nE4, nRst, nFs4, $06, nA4, $12, nRst, $18, nG4, $06
	dc.b nFs4, nG4, nFs4, nD4, nB3, nRst, nE4, nA3, $0C, nRst, $42, nFs4
	dc.b $03, nRst, nFs4, nRst, nG4, nRst, nA4, $06, nD4, $12, nRst, $18
	dc.b nCs5, $01, nD5, $0B, nCs5, $0C, nA4, $03, nRst, nA4, $06, nRst
	dc.b nFs4, nRst, nAb4, $01, nA4, $11, nRst, $36, nFs4, $03, nRst, nG4
	dc.b nRst, nA4, nRst, nB4, $06, nD5, $12, nRst, $18, nB4, $06, nD5
	dc.b nE5, nD5, nB4, nD5, nRst, nB4, nA4, $18
	dc.b nRst, $78
	sJump		CredE_FM2

; FM3 Data
CredE_FM3:
	sPatFM		$00
	sPan		spLeft, $00
	dc.b nFs4, $30, nE4, nA4, $54, nE4, $0C, nFs4, $30, nE4, nA4, nD5
	dc.b $24, nE4, $0C, nFs4, $30, nE4, nA4, $54, $0C, nFs4, $30, nE4
	dc.b nA4
	sPatFM		$03
	dc.b $06, nRst, nA4, nRst, nA4, nRst, nA4, nRst

CredE_Loop0A:
	dc.b nFs4, nRst, $03, nFs4, nRst, $06
	sLoop		$00, $03, CredE_Loop0A
	dc.b nE4, nRst, $03, nE4, nRst, $06, nE4, nRst, $03, nE4, $06, nRst
	dc.b $03
	saVolFM		$FF
	dc.b nFs4, nG4
	saVolFM		$01

CredE_Loop0B:
	dc.b nA4, $06, nRst, $03, nA4, nRst, $06
	sLoop		$00, $05, CredE_Loop0B
	dc.b nA4
	sLoop		$01, $04, CredE_Loop0A
	dc.b nRst, $03
	saVolFM		$05
	dc.b nA4, $06, nRst, $03
	saVolFM		$07
	dc.b nA4, $06, nRst, $03
	saVolFM		$0B
	dc.b nA4, $06, nRst, $03
	saVolFM		$16
	dc.b nA4, $06
	dc.b nRst, $30
	saVolFM		-$2D
	sJump		CredE_FM3

; FM4 Data
CredE_FM4:
	dc.b nRst, $04
	saDetune	-$06
	sJump		CredE_FM2

; FM5 Data
CredE_FM5:
	sPatFM		$00
	sPan		spRight, $00

CredE_Loop03:
	dc.b nD4, $30, nCs4, nFs4, $54, nCs4, $0C
	sLoop		$00, $03, CredE_Loop03
	dc.b nD4, $30, nCs4, nFs4
	sPatFM		$03

CredE_Loop04:
	dc.b nD4, $06, nRst
	sLoop		$00, $04, CredE_Loop04

CredE_Loop05:
	dc.b nD4, nRst, $03, nD4, nRst, $06
	sLoop		$00, $03, CredE_Loop05
	dc.b nCs4, nRst, $03, nCs4, nRst, $06, nCs4, nRst, $03, nCs4, $06, nRst
	dc.b $03
	saVolFM		$FF
	dc.b nD4, nF4
	saVolFM		$01

CredE_Loop06:
	dc.b nFs4, $06, nRst, $03, nFs4, nRst, $06
	sLoop		$00, $05, CredE_Loop06
	dc.b nFs4
	sLoop		$01, $03, CredE_Loop05

CredE_Loop07:
	dc.b nD4, nRst, $03, nD4, nRst, $06
	sLoop		$00, $03, CredE_Loop07
	dc.b nCs4, nRst, $03, nCs4, nRst, $06, nCs4, nRst, $03, nCs4, $06, nRst
	dc.b $03
	saVolFM		$FF
	dc.b nD4, nF4
	saVolFM		$01

CredE_Loop08:
	dc.b nG4, $06, nRst, $03, nG4, nRst, $06
	sLoop		$00, $03, CredE_Loop08

CredE_Loop09:
	dc.b nFs4, nRst, $03, nFs4, nRst, $06
	sLoop		$00, $02, CredE_Loop09
	dc.b nFs4, nRst, $03
	saVolFM		$05
	dc.b nFs4, $06, nRst, $03
	saVolFM		$07
	dc.b nFs4, $06, nRst, $03
	saVolFM		$0B
	dc.b nFs4, $06, nRst, $03
	saVolFM		$16
	dc.b nFs4, $06
	dc.b nRst, $30
	saVolFM		-$2D
	sJump		CredE_FM5

; PSG1 Data
CredE_PSG1:
	dc.b nB0, $30, nA0, nB0, $48
	saVolPSG	$FC
	dc.b nD2, $06, nCs2, nA1, nFs1
	saVolPSG	$04
	dc.b nD2, nCs2, nA1
	saVolPSG	$FF
	dc.b nFs1
	saVolPSG	$03
	dc.b nD2, nCs2, nA1
	saVolPSG	$01
	dc.b nFs1
	saVolPSG	$FD
	dc.b nA0, $30, nB0, $54, nBb0, $0B, nRst, $01, nB0, $30, nA0, nB0
	dc.b $48
	saVolPSG	$FC
	dc.b nD2, $06, nCs2, nA1, nFs1
	saVolPSG	$04
	dc.b nD2, nCs2, nA1, nFs1
	saVolPSG	$02
	dc.b nD2, nCs2, nA1
	saVolPSG	$01
	dc.b nFs1
	saVolPSG	$FD
	dc.b nA0, $30, nB0
	saVolPSG	$FC

CredE_Loop1C:
	dc.b nD2, $01, nB1, nA1, nFs1, nE1, nD1, nRst, $06
	sLoop		$00, $03, CredE_Loop1C
	dc.b nC1, $01, nG1, nAb1, nCs1, nAb1, nA1, nD1, nA1, nBb1, nEb1, nBb1
	dc.b nB1
	saVolPSG	$04

CredE_Loop1D:
	dc.b nB0, $06, nRst, $03, nB0, nRst, $06
	sLoop		$00, $03, CredE_Loop1D
	dc.b nA0, nRst, $03, nA0, nRst, $06, nA0, nRst, $03, nA0, $06, nRst
	dc.b $03, nB0, nC1

CredE_Loop1E:
	dc.b nD1, $06, nRst, $03, nD1, nRst, $06
	sLoop		$00, $04, CredE_Loop1E
	saVolPSG	$FC
	dc.b nD2, nCs2, nA1, nFs1
	saVolPSG	$04
	dc.b nD2, nCs2, nA1, nFs1
	saVolPSG	$02
	dc.b nD2, nCs2, nA1, nFs1, nRst
	saVolPSG	$FE
	dc.b nA0, nRst, $03, nA0, nRst, $06, nA0, nRst, $03, nA0, $06, nRst
	dc.b $03, nB0, nC1

CredE_Loop1F:
	dc.b nD1, $06, nRst, $03, nD1, nRst, $06
	sLoop		$00, $02, CredE_Loop1F
	dc.b nD1, nRst, $03, nD1
	saVolPSG	$FC

CredE_Loop20:
	dc.b nA2, $01, nG1, nA2, nG1, nRst, $08
	sLoop		$00, $03, CredE_Loop20
	dc.b nG1, $01, nG3, nRst, $04, nD1, $01, nD3, nRst, $04
	saVolPSG	$04

CredE_Loop21:
	dc.b nB0, $06, nRst, $03, nB0, nRst, $06
	sLoop		$00, $03, CredE_Loop21
	dc.b nA0, nRst, $03, nA0, nRst, $06, nA0, nRst, $03, nA0, $06, nRst
	dc.b $03, nB0, nC1

CredE_Loop22:
	dc.b nD1, $06, nRst, $03, nD1, nRst, $06
	sLoop		$00, $04, CredE_Loop22
	saVolPSG	$FC
	dc.b nD2, nCs2, nA1, nFs1
	saVolPSG	$04
	dc.b nD2, nCs2, nA1, nFs1
	saVolPSG	$02
	dc.b nD2, nCs2, nA1, nFs1, nRst
	saVolPSG	$FE
	dc.b nA0, nRst, $03, nA0, nRst, $06, nA0, nRst, $03, nA0, $06, nRst
	dc.b $03, nB0, nC1

CredE_Loop23:
	dc.b nD1, $06, nRst, $03, nD1, nRst, $06
	sLoop		$00, $05, CredE_Loop23
	dc.b nD1

CredE_Loop24:
	dc.b nRst, $03
	saVolPSG	$02
	dc.b nD1, $06
	sLoop		$00, $02, CredE_Loop24
	dc.b nRst, $03
	saVolPSG	$04
	dc.b nD1, $06, nRst, $09
	dc.b nRst, $30
	saVolPSG	-$08
	sJump		CredE_PSG1

; PSG2 Data
CredE_PSG2:
	saDetune	$01
	dc.b nRst, $02
	sJump		CredE_PSG1

; PSG3 Data
CredE_PSG3:
	sNoisePSG	 $E7
	dc.b nBb6

CredE_Loop11:
	dc.b $06
	sVolEnvPSG	VolEnv_01
	saVolPSG	$04
	dc.b $06
	sVolEnvPSG	VolEnv_02
	saVolPSG	$FC
	sLoop		$00, $3C, CredE_Loop11
	dc.b $0C, $0C, $0C, $0C
	sVolEnvPSG	VolEnv_08

CredE_Loop12:
	dc.b $0C
	sLoop		$00, $3F, CredE_Loop12
	dc.b $30
	dc.b nRst, $30
	sJump		CredE_PSG3
