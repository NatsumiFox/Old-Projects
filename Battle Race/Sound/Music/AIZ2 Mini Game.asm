; ===========================================================================
; ---------------------------------------------------------------------------
; Carnival Night Zone 1 Mini Game
; ---------------------------------------------------------------------------

AIZ2MG_Header:
	sHeaderInit
	sHeaderPatchUniv
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $15
	sHeaderDAC	AIZ2MG_DAC
	sHeaderFM	AIZ2MG_FM2, $0C, $13
	sHeaderFM	AIZ2MG_FM4, $0C, $13
	sHeaderFM	AIZ2MG_FM3, $0C, $13
	sHeaderFM	AIZ2MG_FM5, $0C, $13
	sHeaderFM	AIZ2MG_FM1, $18, $13
	sHeaderPSG	AIZ2MG_PSG1, $F4, $04, $00, VolEnv_0C
	sHeaderPSG	AIZ2MG_PSG2, $F4, $04, $00, VolEnv_0C
	sHeaderPSG	AIZ2MG_PSG3, $00, $03, $00, VolEnv_0C

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 1
; ---------------------------------------------------------------------------

AIZ2MG_FM1:
.loop	dc.b nRst, $60
	sLoop		$00, $07, .loop

	dc.b nRst, $3C
	sCall		AIZ2_FM1_Part3

.delay	dc.b nRst, $60
	sLoop		$00, $09, .delay
	sJump		AIZ2MG_FM1
; ---------------------------------------------------------------------------

AIZ2_FM1_Part1:
	sCall		AIZ2_FM1_Part12
	dc.b nC1
	sCall		AIZ2_FM1_Params2
	dc.b nC2, $03, nRst, $09
	sCall		AIZ2_FM1_Params1
	dc.b nA0, $0C
	sCall		AIZ2_FM1_Params2
	dc.b nA1, $03, nRst
	sCall		AIZ2_FM1_Params1
	dc.b nBb0, $0C, nF0, $06, nRst
	sCall		AIZ2_FM1_Params2
	dc.b nF1, $03, nRst, $09
	sCall		AIZ2_FM1_Params1
	dc.b nG0, $06
	sCall		AIZ2_FM1_Params2
	dc.b nG1, $0C
	sRet
; ---------------------------------------------------------------------------

AIZ2_FM1_Part2:
	sCall		AIZ2_FM1_Part12
	sCall		AIZ2_FM1_Params1
	dc.b nF0, $06
	sCall		AIZ2_FM1_Params2
	dc.b nF1, $03, nRst, $09
	sCall		AIZ2_FM1_Params1
	dc.b nF0, $0C
	sCall		AIZ2_FM1_Params2
	dc.b nF1, $03, nRst
	sCall		AIZ2_FM1_Params1
	dc.b nG0, $0C, nRst, $06
	sCall		AIZ2_FM1_Params2
	dc.b nG1
	sRet
; ---------------------------------------------------------------------------

AIZ2_FM1_Part12:
	sCall		AIZ2_FM1_Params1
	dc.b nC1, $0C
	sCall		AIZ2_FM1_Params2
	dc.b nC2, $03, nRst, $09
	sCall		AIZ2_FM1_Params1
	dc.b nA0, $0C
	sCall		AIZ2_FM1_Params2
	dc.b nA1, $03, nRst
	sCall		AIZ2_FM1_Params1
	dc.b nBb0, $0C, nBb0, $03, nRst, nA0, $0C, nBb0
	dc.b nG0
	sRet
; ---------------------------------------------------------------------------

AIZ2_FM1_Params1:
	sPatFM		$15
	saDetune	$00
	ssModZ80	$03, $01, $02, $05
	sRet
; ---------------------------------------------------------------------------

AIZ2_FM1_Params2:
	sPatFM		$14
	saDetune	$00
	ssModZ80	$02, $01, $01, $02
	sRet
; ---------------------------------------------------------------------------

AIZ2_FM1_Part3:
	sCall		AIZ2_FM1_Params1
	dc.b nF1, $06, nEb1, nF1, nEb1, nD1, nBb0

	sCall		.x4
	sCall		.x5
	dc.b nG1, nBb1
	sCall		.x4
	sCall		.x5
	dc.b nG0, nBb0
	sCall		.x4
	sCall		.x5
	dc.b nG1, nBb1
	sCall		.x4
	dc.b nF1, nEb1

	dc.b nG0, $18, nD1, $12, nF1, $0C, nFs1, $03
	dc.b nRst, nG1, $0C, nG0, $18
	sRet

.x5	dc.b nG1, nEb1

.x4	dc.b nC1, $18, nEb1, $12, nF1, $0C, nEb1, $03
	dc.b nRst, nF1, $0C
	sRet
; ---------------------------------------------------------------------------

AIZ2_FM1_Part4:
.l0	sCall		.x3
	dc.b nF0, $18, $12, nG0, $0C, nF0, $03, nRst
	dc.b nG0, $0C, nBb0, nB0
	sLoop		$00, $03, .l0

	sCall		.x3
	dc.b nF0, $12, nF1, $03, nRst, $09, nF0, $06
	dc.b nG0, $18, nG1, $03, nRst, $09, nFs0, $0C
	dc.b nFs1, $03, nRst, $09

	sCall		.x1
	sCall		.x2
	sCall		.x1

	dc.b nC1, nC1, nEb1, nEb1, $06, nF1, $0C
	dc.b nEb1, $06, nF1, $0C, nG0, nFs0
	sCall		.x0

	dc.b nAb0, $18, $12, $0C, $03, nRst, nEb1, $0C
	dc.b nAb1, nAb0, nBb0, $18, $12, $0C, $03, nRst
	dc.b nD1, $0C, nEb1, nF1
	sRet

.x0	dc.b nF0, $18, $12, $0C, $03, nRst, nC1, $0C
	dc.b nF1, nF0, nG0, $18, $12, $0C, $03, nRst
	dc.b nD1, $0C, nG1, nG0
	sRet

.x1	sCall	.x0

.x2	dc.b nC1, nG0, nBb0, nG0, $06, nC1, $0C, $06
	dc.b nG0, $0C, nBb0, nG0
	sRet

.x3	dc.b nC1, $18, $12, nEb1, $0C, nC1, $03
	dc.b nRst, nEb1, $0C, nF1, nG1
	sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 2
; ---------------------------------------------------------------------------

AIZ2MG_FM2:
; --- intro section ----

	saTranspose	$0C
	sCall		AIZ2_FM4_Intro
	dc.b nRst, $3C
	saTranspose	-$0C

; --- section 1 ---

	sCall		AIZ2_FM2_Sec1

; --- section 2 ---

	sCall		AIZ2_FM2_Sec2

; --- delay ---

	dc.b nRst, $60, nRst, $2A
	sJump		AIZ2MG_FM2
; ---------------------------------------------------------------------------

AIZ2_FM4_Intro:
	sCall		AIZ2_FM4_Intro1
	sCall		AIZ2_FM4_Intro2
	sCall		AIZ2_FM4_Intro1
	sRet
; ---------------------------------------------------------------------------

AIZ2_FM4_Intro1:
	sPatFM		$16
	saDetune	$FF
	ssModZ80	$0A, $01, $06, $06
	sPan		spRight, $00
	dc.b nRst, $0C, nG3, nRst, $06, nG3, $0C, nRst
	dc.b $06, nG3, $0C, nRst, $06, nG3, $0C, nRst
	dc.b $06, nG3, $0C
	dc.b nRst, $6C
	dc.b nG3, $0C, nRst, $06, nG3, $0C, nRst, nA3
	dc.b $03, nRst, $09, nG3, $06, nRst, $0C, nF3
	sRet
; ---------------------------------------------------------------------------

AIZ2_FM4_Intro2:
	sPatFM		$17
	saDetune	$FE
	ssModZ80	$0F, $01, $06, $06
	sPan		spRight, $00
	dc.b nC4, $01, nRst, $05, nC4, $01, nRst, $05
	dc.b nC5, $01, nRst, $05, nC4, $01, nRst, $05
	dc.b nBb4, $01, nRst, $05, nC4, $01, nRst, $05
	dc.b nBb4, $01, nRst, $05, nC5, $01, nRst, $35
	sRet
; ---------------------------------------------------------------------------

AIZ2_FM2_Sec1:
	saDetune	$01

AIZ2_FM23_Sec1:
	sPatFM		$17
	ssModZ80	$0F, $01, $06, $06
	sPan		spCenter, $00

	sCall		.s0
	dc.b nG2, $3B, nRst, $3D
	sCall		.s0
	dc.b nC3, $3B, nRst, $3D
	sCall		.s0
	dc.b nG2, $3B, nRst, $3D
	sCall		.s0
	dc.b nC3, $3B, nRst, $01
	sRet

.s0	dc.b nEb2, $0B, nRst, $01, nG2, $0B, nRst, $01
	dc.b nEb3, $0B, nRst, $01, nD3, $05, nRst, $0D
	dc.b nBb2, $05, nRst, $0D
	sRet
; ---------------------------------------------------------------------------

AIZ2_FM2_Sec2:
	sPatFM		$17
	saDetune	$FE
	ssModZ80	$0F, $01, $06, $06
	sPan		spRight, $00
	dc.b nRst, $0C
	dc.b nA3, $06, nB3, nRst, nB3, nB3, nB3, nB3, nRst
	dc.b nC4, nB3, $1D, nRst, $0D

	sCall		.s0
	sCall		.s1
	dc.b nC3, $05, nRst, $1F
	sCall		.s0
	dc.b nA3, $05, nRst, $07
	dc.b nBb3, $05, nRst, $01
	dc.b nC4, $05, nRst, $1F
	sCall		.s0
	sCall		.s1
	dc.b nC3, $05, nRst, $1F

.s0	dc.b nBb3, $0B, nRst, $01
	dc.b nBb3, $0B, nRst, $0D
	dc.b nA3, $05, nRst, $0D
	dc.b nBb3, $05, nRst, $19
	dc.b nC3, $05, nRst, $01
	dc.b nG3, $05, nRst, $01
	dc.b nC4, $05, nRst, $01
	dc.b nBb3, $05, nRst, $07
	dc.b nBb3, $05, nRst, $07
	dc.b nA3, $05, nRst, $07
	sRet

.s1	dc.b nA3, $05, nRst, $07
	dc.b nF3, $05, nRst, $01
	sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 3
; ---------------------------------------------------------------------------

AIZ2MG_FM3:
; --- intro section ----

	saTranspose	$0C
	sCall		AIZ2_FM5_Intro
	dc.b nA3, $48
	saTranspose	-$0C

; --- section 1 ---

	sCall		AIZ2_FM3_Sec1

; --- section 2 ---

	sCall		AIZ2_FM3_Sec2

; --- delay ---

	dc.b nRst, $60
	sJump		AIZ2MG_FM3
; ---------------------------------------------------------------------------

AIZ2_FM5_Intro:
	sCall		AIZ2_FM5_Intro1
	dc.b nA3, $0C
	sCall		AIZ2_FM5_Intro2
	sCall		AIZ2_FM5_Intro1
	sRet
; ---------------------------------------------------------------------------

AIZ2_FM5_Intro1:
	sPatFM		$16
	saDetune	$02
	ssModZ80	$0A, $01, $06, $06
	sPan		spLeft, $00
	dc.b nC3, $0C, nBb3, nC3, $06, nBb3, $0C, nC3
	dc.b $06, nBb3, $0C, nC3, $06, nBb3, $0C, nC3
	dc.b $06, nBb3, $60, $0C
	dc.b nC3, $0C, nBb3, nC3, $06, nBb3, $0C, nC3, nC4
	dc.b $06, nC3, nBb3, $0C, nC3, $06
	sRet
; ---------------------------------------------------------------------------

AIZ2_FM5_Intro2:
	sPatFM		$17
	saDetune	$FE
	ssModZ80	$0F, $01, $06, $06
	sPan		spRight, $00
	dc.b nC4, $03, nRst, nC4, nRst, nC5, nRst, nC4
	dc.b nRst, nBb4, nRst, nC4, nRst, nBb4, nRst, nC5
	dc.b nRst, $33
	sRet
; ---------------------------------------------------------------------------

AIZ2_FM3_Sec1:
	saDetune	-$02
	sJump		AIZ2_FM23_Sec1
; ---------------------------------------------------------------------------

AIZ2_FM3_Sec2:
	sPatFM		$17
	saDetune	$FE
	ssModZ80	$0F, $01, $06, $06
	sPan		spRight, $00
	dc.b nRst, $0C
	dc.b nCs4, $06, nD4, nRst, nD4, nD4, nD4, nD4
	dc.b nRst, nEb4, nD4, $1D, nRst, $0D
	sCall		.s0
	sCall		.s1
	sCall		.s1
	sCall		.s1
	dc.b nG3, $05, nRst, $4F
	dc.b nF3, $06, nG3, nA3, nC4, nBb3, nG3, nA3
	sRet

.s1	dc.b nG3, $05, nRst, $19
	dc.b nC5, $05, nRst, $07
	dc.b nA4, $05, nRst, $01
	dc.b nBb4, $05, nRst, $07
	dc.b nG4, $05, nRst, $07
	dc.b nC5, $05, nRst, $07
	dc.b nA4, $05, nRst, $01
	dc.b nBb4, $05, nRst, $07
	dc.b nG4, $05, nRst, $1F

.s0	dc.b nG3, $0B, nRst, $01
	dc.b nG3, $0B, nRst, $0D
	dc.b nF3, $05, nRst, $0D
	sRet
; ===========================================================================
; ---------------------------------------------------------------------------
; FM 4
; ---------------------------------------------------------------------------

AIZ2MG_FM4:
;	if 0=1
	dc.b nRst, $6C
	sCall		AIZ2_FM2_Intro1
	dc.b nRst, $60
	sCall		AIZ2_FM2_Intro2
	dc.b nRst, $6C
	sCall		AIZ2_FM2_Intro1
	dc.b nRst, $60
	sCall		AIZ2_FM2_Intro3
;	endif

	dc.b nRst, $24

; --- section 1 ---

	sCall		AIZ2_FM4_Sec1

; --- section 2 ---

	saDetune	$00
	sCall		AIZ2_FM45_Sec2

; --- delay ---

	dc.b nRst, $60, nRst
	sJump		AIZ2MG_FM4
; ---------------------------------------------------------------------------

AIZ2_FM2_Intro1:
	sPatFM		$06
	saDetune	$03
	ssModZ80	$0F, $01, $06, $06
	sPan		spCenter, $00
	dc.b nC4, $06, nRst, $12, nD3, $06, nC3, $06
	dc.b nRst, $30
	sRet
; ---------------------------------------------------------------------------

AIZ2_FM2_Intro2:
	dc.b nRst, $30
	sPatFM		$06
	saDetune	$03
	ssModZ80	$0F, $01, $06, $06
	sPan		spCenter, $00
	dc.b nF3, $06, nA3, $06, nF4, $06, nEb4, $1D, nRst, $01
	sRet
; ---------------------------------------------------------------------------

AIZ2_FM2_Intro3:
	sPatFM		$06
	saDetune	$03
	ssModZ80	$0F, $01, $06, $06
	sPan		spCenter, $00
	dc.b nA3, $06, nRst, $0C, nA3, $06, nRst, $0C
	dc.b nB3, $17, nRst, $01
	sRet
; ---------------------------------------------------------------------------

AIZ2_FM4_Sec1:
	saVolFM		$08
	sCall		.s0

	sPatFM		$17
	saDetune	$FE
	ssModZ80	$0F, $01, $06, $06
	sPan		spRight, $00
	dc.b nRst, nA4, $05, nRst, $01, nBb4, $05, nRst
	dc.b $07, nBb4, $02, nRst, $04, nBb4, $02, nRst
	dc.b $04, nBb4, $02, nRst, $04, nBb4, $02, nRst
	dc.b $0A, nC5, $05, nRst, $01, nBb4, $1D, nRst
	dc.b $01

	sCall		.s0
	saVolFM		-$08
	sRet

.s0	sPatFM		$16
	saDetune	$FF
	ssModZ80	$0A, $01, $06, $06
	sPan		spRight, $00

	sCall		.s2
	dc.b nRst, nG3, nRst, $06, nG3, $0C
	sCall		.s1

.s2	dc.b nRst, $0C, nEb3, nRst, $06, nEb3, $0C

.s1	dc.b nRst, $06, nF3, $0C, nRst, $06, nF3, $0C
	dc.b nRst, $06, nF3, $0C
	sRet

AIZ2_FM45_Sec2:
	sPatFM		$0F
	ssModZ80	$0F, $01, $06, $06
	sPan		spLeft, $00
	dc.b nRst, $54, nEb4, $05, nRst, $01, nF4, $05
	dc.b nRst, $01

AIZ2_FM45PSG12_Sec2:
	sCall		.s0
	sCall		.s1
	dc.b nA4, $2F, nRst, $25
	sCall		.s3
	dc.b nG4, $05, nRst, $0D
	dc.b nC4, $05, nRst, $0D
	dc.b nBb4, $0B, nRst, $07
	dc.b nBb4, $06
	sCall		.s2
	sCall		.s1
	sRet

.s3	dc.b nEb4, $05, nRst, $01
	dc.b nF4, $05, nRst, $01
	sRet

.s1	dc.b nG4, $05, nRst, $07
	dc.b nA4, $05, nRst, $0D
	dc.b nF4, $05, nRst, $0D
	dc.b nC4, $29, nRst, $07
	sCall		.s3
	sCall		.s0
	dc.b nC5, $05, nRst, $07
	sRet

.s0	dc.b nG4, $05, nRst, $0D
	dc.b nC4, $05, nRst, $0D
	dc.b nBb4, $11, nRst, $07

.s2	dc.b nBb4, $05, nRst, $07
	dc.b nBb4, $05, nRst, $07
	sRet
; ===========================================================================
; ---------------------------------------------------------------------------
; FM 5
; ---------------------------------------------------------------------------

AIZ2MG_FM5:
;	if 0=1
	dc.b nRst, $6C
	sCall		AIZ2_FM3_Intro1
	dc.b nRst, $60
	sCall		AIZ2_FM3_Intro2
	dc.b nRst, $6C
	sCall		AIZ2_FM3_Intro1
	dc.b nRst, $60
	sCall		AIZ2_FM3_Intro3
;	endif

	dc.b nRst, $24

; --- section 1 ---

	sCall		AIZ2_FM5_Sec1

; --- section 2 ---

	saDetune	$01
	sCall		AIZ2_FM45_Sec2

; --- delay ---

	dc.b nRst, $60, nRst
	sJump		AIZ2MG_FM5
; ---------------------------------------------------------------------------

AIZ2_FM3_Intro1:
	sPatFM		$06
	saDetune	$FD
	ssModZ80	$0F, $01, $06, $06
	sPan		spCenter, $00
	dc.b nG3, $06, nRst, $12, nF2, $06, nG2, $06
	dc.b nRst, $30
	sRet
; ---------------------------------------------------------------------------

AIZ2_FM3_Intro2:
	dc.b nRst, $30
	sPatFM		$06
	saDetune	$FD
	ssModZ80	$0F, $01, $06, $06
	sPan		spCenter, $00
	dc.b nD3, $06, nF3, $06, nD4, $06, nC4, $1D, nRst, $01
	sRet
; ---------------------------------------------------------------------------

AIZ2_FM3_Intro3:
	sPatFM		$06
	saDetune	$FD
	ssModZ80	$0F, $01, $06, $06
	sPan		spCenter, $00
	dc.b nF3, $06, nRst, $0C, nF3, $06, nRst, $0C
	dc.b nG3, $17, nRst, $01
	sRet
; ---------------------------------------------------------------------------

AIZ2_FM5_Sec1:
	saVolFM		$08
	sCall		.s0
	dc.b nA3, $0C

	sPatFM		$17
	saDetune	$FE
	ssModZ80	$0F, $01, $06, $06
	sPan		spRight, $00
	dc.b sHold, $0C, nD4, $06, nEb4, $0C, nEb4, $03
	dc.b nRst, nEb4, nRst, nEb4, nRst, nEb4, $03, nRst
	dc.b $09, nF4, $03, nRst, $03, nEb4, $1E

	sCall		.s0
	dc.b nC3, $0C
	saVolFM		-$08
	sRet

.s0	sPatFM		$16
	saDetune	$02
	ssModZ80	$0A, $01, $06, $06
	sPan		spLeft, $00

	sCall		.s2
	dc.b nA3, $0C, nC3, nBb3, nC3, $06, nBb3, $0C
	sCall		.s1
	dc.b nA3, $0C
	sCall		.s2
	sRet

.s2	dc.b nC3, $0C, nG3, nC3, $06, nG3, $0C

.s1	dc.b nC3, $06, nA3, $0C, nC3, $06, nA3, $0C
	dc.b nC3, $06
	sRet
; ===========================================================================
; ---------------------------------------------------------------------------
; DAC
; ---------------------------------------------------------------------------

AIZ2MG_DAC:
; --- intro section ----

	dc.b dKick, $18, $18, $18, $18
	dc.b dKick, $0C, dSnare, dKick, dSnare
	dc.b $06, $06, $06, $12, $0C, $0C

.intro	sCall		AIZ2_Call4
	sLoop		$00, $02, .intro

	dc.b dKick, $0C, dKick, dSnare, dKick, $06, dSnare, $0C
	dc.b dSnare, $06, dKick, $0C, dSnare, dKick
	dc.b dKick, dKick, dSnare, dKick, $06, dSnare, $0C, dSnare
	dc.b $06

; --- drum connector

	dc.b dElectricHighTom, $04, $04, $04
	dc.b dElectricMidTom, dElectricMidTom, dElectricMidTom
	dc.b dElectricFloorTom, dElectricFloorTom, dElectricFloorTom

; --- section 1 (amen break) ---

.amen	dc.b dKick, $0C, $0C
	dc.b dSnare, $12
	dc.b dMuffledSnare, $0C, $06
	dc.b dKick
	dc.b dMuffledSnare, dSnare
	dc.b dKick, $0C
	dc.b dMuffledSnare, $06
	sLoop		$00, $02, .amen

	dc.b dKick, $0C, $0C
	dc.b dSnare, $12
	dc.b dMuffledSnare, $0C, $06
	dc.b dKick
	dc.b dMuffledSnare, dSnare
	dc.b dKick
	dc.b dMuffledSnare, $12

	dc.b dSnare, $06
	dc.b dKick, $0C
	dc.b dMuffledSnare, $12, dSnare, $0C, dMuffledSnare, $06
	dc.b dCrashCymbal, $18
	dc.b dMuffledSnare, $0C
	sLoop		$01, $02, .amen

; --- section 2 ---

	sCall		AIZ2_DAC_Sec2

; --- delay ---

	dc.b nRst, $60
	sJump		AIZ2MG_DAC

AIZ2_DAC_Sec2:
	sCall		AIZ2_Call4
	sLoop		$01, $03, AIZ2_DAC_Sec2

	sCall		AIZ2_Call5
	dc.b dKick, $06, dSnare, $0C, dSnare, $06, dMidTom, $0C
	dc.b dKick, $06, dSnare, $0C, dSnare, $06, dHighTom, $0C
	dc.b dSnare, $06, dSnare, dFloorTom, dSnare
	sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG 3
; ---------------------------------------------------------------------------

AIZ2MG_PSG3:
; --- intro section ----

	sNoisePSG	$E7
;	if 0=1
	dc.b nRst, $60, nRst, nRst, nRst

.intro	sVolEnvPSG	VolEnv_01
	dc.b nBb6, $06, nBb6
	sVolEnvPSG	VolEnv_04
	dc.b nBb6, $0C
	sLoop		$00, $0E, .intro

	dc.b nRst, $30
	saVolPSG	-$01

; --- section 1 (amen break) ---

.amen	sVolEnvPSG	VolEnv_02
	dc.b nBb6, $06, nBb6, nBb6, nBb6, nBb6
	sVolEnvPSG	VolEnv_05
	dc.b nBb6
	sVolEnvPSG	VolEnv_02
	dc.b nBb6
	sVolEnvPSG	VolEnv_05
	dc.b nBb6
	sVolEnvPSG	VolEnv_02
	dc.b nBb6, nBb6, nBb6, nBb6, nBb6
	sVolEnvPSG	VolEnv_05
	dc.b nBb6
	sVolEnvPSG	VolEnv_02
	dc.b nBb6, nBb6
	sLoop		$00, $08, .amen
	saVolPSG	$01

; --- section 2 ---

	sCall		AIZ2_PSG3_Sec2

; --- delay ---

	dc.b nRst, $60, nRst
	sJump		AIZ2MG_PSG3

AIZ2_PSG3_Sec2:
.loop	sCall		.s0
	sLoop		$00, $03, .loop
	dc.b nBb6, nBb6
	sCall		.s0
	dc.b nBb6, $0C, nBb6, nBb6, $06, nBb6
	sCall		.s0
	sLoop		$01, $04, .loop
	sRet

.s0	dc.b nBb6, $0C, nBb6, $06, nBb6
	sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG  1
; ---------------------------------------------------------------------------

AIZ2MG_PSG1:
; --- intro section ----

	saTranspose	$0C
	sCall		AIZ2_PSG1_Intro
	saTranspose	-$0C

; --- section 1 ---

	sCall		AIZ2_PSG1_Sec1

; --- section 2 ---

	saDetune	$00
	sCall		AIZ2_PSG12_Sec2
	saTranspose	-$0C

; --- delay ---

	dc.b nRst, $60, nRst
	sJump		AIZ2MG_PSG1
; ---------------------------------------------------------------------------

AIZ2_PSG1_Intro:
	sCall		.intro1
	sVolEnvPSG	VolEnv_0A
	ssModZ80	$0F, $01, $01, $06

	dc.b nC4, $03, nRst, $03, nC4, $03, nRst, $03
	dc.b nC5, $03, nRst, $03, nC4, $03, nRst, $03
	dc.b nBb4, $03, nRst, $03, nC4, $03, nRst, $03
	dc.b nBb4, $03, nRst, $03, nC5, $03, nRst, $33

.intro1	sVolEnvPSG	VolEnv_05
	ssModZ80	$0F, $01, $00, $06
	dc.b nRst, $0C, nG3

.iloop	dc.b nRst, $06, nG3, $0C
	sLoop		$00, $04, .iloop
	dc.b nRst, $60

	dc.b nRst, $0C, nG3, nRst, $06, nG3, $0C, nRst
	dc.b nA3, $06, nRst, $06, nG3, $06, nRst, $0C
	dc.b nF3
	sRet
; ---------------------------------------------------------------------------

AIZ2_PSG1_Sec1:
	dc.b nRst, $60
	sCall		AIZ2_PSG12_Sec1.s2
	sVolEnvPSG	VolEnv_0A
	saDetune	$00
	ssModZ80	$0F, $01, $01, $06
	dc.b nRst, nA4, $05, nRst, $01, nBb4, $05, nRst
	dc.b $07, nBb4, $06, nBb4, nBb4, nBb4, nRst, $06
	dc.b nC5, $05, nRst, $01, nBb4, $1E

	sCall		AIZ2_PSG12_Sec1
	sVolEnvPSG	VolEnv_0A
	saDetune	$00
	ssModZ80	$0F, $01, $01, $06
	dc.b nRst, $0C, nA3, $05, nRst, $01, nB3, $05
	dc.b nRst, $07, nB3, $06, nB3, nB3, nB3, nRst, $06
	dc.b nC4, $05, nRst, $01, nB3, $1E
	sRet
; ---------------------------------------------------------------------------

AIZ2_PSG12_Sec1:
	sVolEnvPSG	VolEnv_05
	saDetune	$FF
	ssModZ80	$0F, $01, $00, $06
	sCall		.s1
	dc.b nC3, $06, nA3, $0C, nC3, nBb3, nC3, $06
	dc.b nBb3, $0C
	sCall		.s0
	dc.b nC3, $06, nA3, $0C
	sCall		.s1
	dc.b nC3, $06, nC3, $0C
	sRet

.s1	dc.b nC3, $0C, nG3, nC3, $06, nG3, $0C

.s0	dc.b nC3, $06, nA3, $0C, nC3, $06, nA3, $0C
	sRet

.s2	sVolEnvPSG	VolEnv_05
	saDetune	$00
	ssModZ80	$0F, $01, $00, $06

	sCall		.s4
	dc.b nRst, nG3, nRst, $06, nG3, $0C
	sCall		.s3

.s4	dc.b nRst, $0C, nEb3, nRst, $06, nEb3, $0C

.s3	dc.b nRst, $06, nF3, $0C, nRst, $06, nF3, $0C
	dc.b nRst, $06, nF3, $0C
	sRet
; ---------------------------------------------------------------------------

AIZ2_PSG12_Sec2:
	sVolEnvPSG	VolEnv_05
	ssModZ80	$0F, $01, $00, $06
	saTranspose	$0C
	sJump		AIZ2_FM45PSG12_Sec2
; ===========================================================================
; ---------------------------------------------------------------------------
; PSG  2
; ---------------------------------------------------------------------------

AIZ2MG_PSG2:
; --- intro section ----

	saTranspose	$0C
	sCall		AIZ2_PSG2_Intro
	saTranspose	-$0C

; --- section 1 ---

	sCall		AIZ2_PSG2_Sec1

; --- section 2 ---

	saDetune	$FF
	sCall		AIZ2_PSG12_Sec2
	saTranspose	-$0C

; --- delay ---

	dc.b nRst, $60, nRst
	sJump		AIZ2MG_PSG2
; ---------------------------------------------------------------------------

AIZ2_PSG2_Intro:
	sCall		.intro1
	sVolEnvPSG	VolEnv_0A
	ssModZ80	$0F, $01, $01, $06

	sNoteTimeOut	$03
	dc.b nC4, $06, nC4, nC5, nC4, nBb4, nC4, nBb4
	dc.b nC5, $03

	sNoteTimeOut	$00
	dc.b nRst, $33

.intro1	saDetune	$FF
	sVolEnvPSG	VolEnv_05
	ssModZ80	$0F, $01, $00, $06
	dc.b nC3, $0C, nBb3

.iloop	dc.b nC3, $06, nBb3, $0C
	sLoop		$00, $04, .iloop
	dc.b nRst, $60

	dc.b nC3, $0C, nBb3, nC3, $06, nBb3, $0C, nC3
	dc.b $06, nRst, nC4, $06, nC3, $06, nBb3, nRst
	dc.b nC3, nA3, $0C
	sRet
; ---------------------------------------------------------------------------

AIZ2_PSG2_Sec1:
	dc.b nRst, $60
	sCall		.s2
	sCall		.s3
	dc.b nF4, $05, nRst, $01, nEb4, $1E
	sCall		AIZ2_PSG12_Sec1

	saTranspose	-$01
	sCall		.s3
	saTranspose	$01
	dc.b nEb4, $05, nRst, $01, nD4, $1E
	sRet

.s2	sVolEnvPSG	VolEnv_05
	saDetune	$FF
	ssModZ80	$0F, $01, $00, $06

	sCall		.s1
	dc.b nC3, nBb3, nC3, $06, nBb3, $0C
	sCall		.s0

.s1	dc.b nC3, $0C, nG3, nC3, $06, nG3, $0C

.s0	dc.b nC3, $06, nA3, $0C, nC3, $06, nA3, $0C
	dc.b nC3, $06, nA3, $0C
	sRet

.s3	sVolEnvPSG	VolEnv_0A
	saDetune	$FF
	ssModZ80	$0F, $01, $01, $06
	dc.b nRst, $0C, nD4, $05, nRst, $01, nEb4, $05
	dc.b nRst, $07, nEb4, $02, nRst, $04, nEb4, $02
	dc.b nRst, $04, nEb4, $02, nRst, $04, nEb4, $02
	dc.b nRst, $0A
	sRet
; ---------------------------------------------------------------------------
