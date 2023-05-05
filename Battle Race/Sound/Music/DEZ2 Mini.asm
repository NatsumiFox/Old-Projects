DEZ2_Mini_Header:
	sHeaderInit	; Z80 offset is $C79F
	sHeaderPatch	DEZ1_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $30
	sHeaderDAC	DEZ2_Mini_DAC
	sHeaderFM	DEZ2_Mini_FM1, $00, $0F
	sHeaderFM	DEZ2_Mini_FM2, $00, $17
	sHeaderFM	DEZ2_Mini_FM3, $00, $1E
	sHeaderFM	DEZ2_Mini_FM5, $00, $20
	sHeaderFM	DEZ2_Mini_FM4, $00, $0F
	sHeaderPSG	DEZ2_Mini_PSG1, $00, $08, $00, VolEnv_00
	sHeaderPSG	DEZ2_Mini_PSG2, $00, $06, $00, VolEnv_00
	sHeaderPSG	DEZ2_Mini_PSG3, $00, $0F, $00, VolEnv_00
; ---------------------------------------------------------------------------
; DAC Track
; ---------------------------------------------------------------------------

DEZ2_Mini_DAC:
	; ----- PART 1 -----

	dc.b nRst, $60, $60
	dc.b dModLooseKick, $0C, $0C, nRst, $48
	dc.b dModLooseKick, $0C, $0C, nRst, $24, dModLooseKick, $0C, dSnare, $18

.loop	dc.b dModLooseKick, $0C, $0C, dSnare, $12, dModLooseKick, $0C, $06, $0C, dSnare, $18
	sLoop		$00, $09, .loop

	dc.b dModLooseKick, $0C, $06, $06, dSnare, $12, dModLooseKick, $0C, $06, $0C, dSnare, $18
	dc.b dModLooseKick, $06, $06, $06, $06, dSnare, $18
	dc.b dMetalCrashHit, $24, dScratch, $0C

	; ----- PART 2 -----

	ssTempo		$10		; faster tempo for next section

	dc.b nRst, $48, dSnareGo, $18

.loop2	dc.b dModLooseKick, $0C, dBassHey, dModLooseKick, $18, dSnareGo, dModLooseKick, $18
	dc.b $0C, $0C, dGo, $18, dSnareGo, dGo
	sLoop		$00, $03, .loop2

	dc.b dModLooseKick, $0C, dComeOn, $24, dSnareGo, $18, dSnareGo
	dc.b dModLooseKick, $0C, $0C, dGo, $18, dMetalCrashHit, $24, dScratch, $0C
	sLoop		$01, $02, .loop2

	; ----- PART 3 -----

	dc.b dModLooseKick, $0C, dBassHey, dModLooseKick, $18, dSnareGo, dModLooseKick, $18
	dc.b $0C, $0C, dGo, $18, dSnareGo, dGo, dMetalCrashHit, $60
	ssTempo		$30		; slower tempo for next section
	sJump		DEZ2_Mini_DAC
; ---------------------------------------------------------------------------
; Additional echo for FM2 at the start section, misc for others
; ---------------------------------------------------------------------------

DEZ2_Mini_FM3:
	; ----- PART 1 -----

	dc.b nRst, $06
.jump	sCall		DEZ2_Mini_FM235_1

	; ----- PART 2 -----

	dc.b nRst, $60
	ssVol		$1D
	sCall		DEZ2_Mini_FM13_1

	; ----- PART 3 -----

	dc.b nRst, $60, nRst
	ssVol		$1E
	sJump		.jump
; ---------------------------------------------------------------------------
; Echo track for FM 2
; ---------------------------------------------------------------------------

DEZ2_Mini_FM5:
	dc.b nRst, $0C

.jump	ssVol		$20
	sCall		DEZ2_Mini_FM235_1
	sCall		DEZ2_Mini_FM235_3
	sJump		.jump
; ---------------------------------------------------------------------------
; Main melody for all sections
; ---------------------------------------------------------------------------

DEZ2_Mini_FM2:
	ssVol		$17
	sCall		DEZ2_Mini_FM235_1
	sCall		DEZ2_Mini_FM235_3
	sJump		DEZ2_Mini_FM2
; ---------------------------------------------------------------------------

DEZ2_Mini_FM235_1:
	sPatFM		$08
	ssModZ80	$01, $01, $06, $02

.loop	sCall		DEZ2_Mini_FM23_1
	sCall		DEZ2_Mini_FM23_2
	sLoop		$00, $06, .loop

	sCall		DEZ2_Mini_FM23_1
	sCall		DEZ2_Mini_FM235_2
	sJump		DEZ2_Mini_FM235_4

DEZ2_Mini_FM235_3:
	sPatFM		$02
	ssModZ80	$0D, $01, $02, $06
	saTranspose	-$08
	saVolFM		-$12

.loop2	sPan		spCenter
	dc.b nFs3, $06
	saVolFM		$05
	sPan		spRight
	dc.b $06
	saVolFM		-$05
	saTranspose	$01
	sLoop		$00, $08, .loop2

.loop	sCall		DEZ2_Mini_FM23_1
	sCall		DEZ2_Mini_FM23_2
	sLoop		$00, $08, .loop

	sCall		DEZ2_Mini_FM235_4
	sCall		DEZ2_Mini_FM235_2

	dc.b nRst, $60
	saVolFM		-$16
	sRet
; ---------------------------------------------------------------------------

DEZ2_Mini_FM235_2:
	sPan		spCenter
	dc.b nE3, $06
	saVolFM		$06
	sPan		spRight
	dc.b $06
	saVolFM		$FB
	sPan		spCenter
	dc.b nA2, $06
	saVolFM		$06
	sPan		spLeft
	dc.b $06
	saVolFM		$FB
	sPan		spRight
	dc.b nCs3, $0C
	saVolFM		$01
	sPan		spLeft
	dc.b nA2, $06
	saVolFM		$01
	sPan		spCenter
	dc.b nE3, $0C
	saVolFM		$01
	sPan		spRight
	dc.b nE3, $06
	saVolFM		$06
	sPan		spCenter
	dc.b $06
	saVolFM		$FB
	sPan		spRight
	dc.b nCs3, $06
	saVolFM		$01
	sPan		spLeft
	dc.b nCs3, $06
	saVolFM		$06
	dc.b $06
	sPan		spCenter
	saVolFM		$FB
	dc.b nA2, $06
	saVolFM		$06
	sPan		spLeft
	dc.b $04, nRst, $02
	saVolFM		$FB
	sRet
; ---------------------------------------------------------------------------

DEZ2_Mini_FM235_4:
	sPan		spCenter
	dc.b nFs3, $06
	saVolFM		$06
	sPan		spLeft
	dc.b $06
	saVolFM		$FB
	sPan		spRight
	dc.b nB2, $06
	saVolFM		$06
	sPan		spCenter
	dc.b $06
	saVolFM		$FB
	sPan		spRight
	dc.b nD3, $0C
	saVolFM		$01
	sPan		spLeft
	dc.b nB2, $06
	saVolFM		$01
	sPan		spLeft
	dc.b nFs3, $0C
	saVolFM		$01
	sPan		spRight
	dc.b nFs3, $06
	sPan		spCenter
	saVolFM		$06
	sPan		spRight
	dc.b $06
	saVolFM		$FB
	sPan		spLeft
	dc.b nB2, $06
	saVolFM		$01
	sPan		spCenter
	dc.b nD3, $06
	sPan		spLeft
	saVolFM		$06
	sPan		spCenter
	dc.b $06
	saVolFM		$FB
	sPan		spRight
	dc.b nB2, $06
	saVolFM		$06
	sPan		spLeft
	dc.b $06
	saVolFM		$FB
	sRet
; ---------------------------------------------------------------------------

DEZ2_Mini_FM23_1:
	sPan		spCenter
	dc.b nFs3, $06
	saVolFM		$05
	sPan		spLeft
	dc.b $06
	saVolFM		$FB
	sPan		spRight
	dc.b nB2, $06
	saVolFM		$05
	sPan		spCenter
	dc.b $06
	saVolFM		$FB
	sPan		spRight
	dc.b nD3, $0C
	sPan		spLeft
	dc.b nB2, $06
	sPan		spLeft
	dc.b nFs3, $0C
	sPan		spRight
	dc.b nFs3, $06
	sPan		spCenter
	saVolFM		$05
	sPan		spRight
	dc.b $06
	saVolFM		$FB
	sPan		spLeft
	dc.b nB2, $06
	sPan		spCenter
	dc.b nD3, $06
	sPan		spLeft
	saVolFM		$05
	sPan		spCenter
	dc.b $06
	saVolFM		$FB
	sPan		spRight
	dc.b nB2, $06
	saVolFM		$05
	sPan		spLeft
	dc.b $06
	saVolFM		$FB
	sRet
; ---------------------------------------------------------------------------

DEZ2_Mini_FM23_2:
	sPan		spCenter
	dc.b nE3, $06
	saVolFM		$05
	sPan		spRight
	dc.b $06
	saVolFM		$FB
	sPan		spCenter
	dc.b nA2, $06
	saVolFM		$05
	sPan		spLeft
	dc.b $06
	saVolFM		$FB
	sPan		spRight
	dc.b nCs3, $0C
	sPan		spLeft
	dc.b nA2, $06
	sPan		spCenter
	dc.b nE3, $0C
	sPan		spRight
	dc.b nE3, $06
	saVolFM		$05
	sPan		spCenter
	dc.b $06
	saVolFM		$FB
	sPan		spRight
	dc.b nCs3, $06
	sPan		spLeft
	dc.b nCs3, $06
	saVolFM		$05
	dc.b $06
	sPan		spCenter
	saVolFM		$FB
	dc.b nA2, $06
	saVolFM		$05
	sPan		spLeft
	dc.b $04, nRst, $02
	saVolFM		$FB
	sRet
; ---------------------------------------------------------------------------
; Used for first section for "snow" effect
; ---------------------------------------------------------------------------

DEZ2_Mini_PSG1:
	ssModZ80	$03, $03, $01, $02
	saDetune	$02

DEZ2_Mini_PSG2:
	; ----- PART 1 -----

	sVolEnvPSG	VolEnv_04

.loop	sCall		DEZ2_Mini_PSG2_1
	sCall		DEZ2_Mini_PSG2_2
	sLoop		$00, $06, .loop
	sCall		DEZ2_Mini_PSG2_1

	sCall		DEZ2_Mini_PSG2_4
	sCall		DEZ2_Mini_PSG2_3
	saVolPSG	-$06

	; ----- PART 2 -----

	sVolEnvPSG	VolEnv_09
	saTranspose	-$0C-$08

.loop2	dc.b nCs4, $06, nB3
	saTranspose	$01
	sLoop		$00, $08, .loop2

.loop5	sCall		DEZ2_Mini_PSG2_1
	sCall		DEZ2_Mini_PSG2_2
	sLoop		$00, $08, .loop5

	; ----- PART 3 -----

	sCall		DEZ2_Mini_PSG2_3
	sCall		DEZ2_Mini_PSG2_4

	saTranspose	$0C
	dc.b nRst, $60
	saVolPSG	-$0A
	sJump		DEZ2_Mini_PSG2

DEZ2_Mini_PSG2_1:
	dc.b nCs4, $06, nFs4, nD4, nB4
	sLoop		$01, $04, DEZ2_Mini_PSG2_1
	sRet

DEZ2_Mini_PSG2_2:
	dc.b nB3, $06, nE4, nCs4, nA4
	sLoop		$01, $04, DEZ2_Mini_PSG2_2
	sRet

DEZ2_Mini_PSG2_3:
	saVolPSG	$01
	dc.b nCs4, $06, nFs4, nD4, nB4
	sLoop		$01, $04, DEZ2_Mini_PSG2_3
	sRet

DEZ2_Mini_PSG2_4:
	saVolPSG	$01
	dc.b nB3, $06, nE4, nCs4, nA4
	sLoop		$01, $04, DEZ2_Mini_PSG2_4
	sRet
; ---------------------------------------------------------------------------
; Used for the second section
; ---------------------------------------------------------------------------

DEZ2_Mini_PSG3:
	; ----- PART 1 -----

	dc.b nRst, $60
	sLoop		$00, $0E, DEZ2_Mini_PSG3

	sNoisePSG	$E7
	dc.b nRst, $30
	ssModZ80	$01, $06, $01, $0C
	ssDetune	$04

	dc.b nBb6, $06, sHold
	sCall		DEZ2_Mini_PSG3_FdIn

.loop2	dc.b sHold, nBb6, $03, sHold, nRst
	sLoop		$00, $08, .loop2

	sModEnv		ModEnv_09
	ssDetune	$00
	dc.b nBb6, $06, sHold
	sCall		DEZ2_Mini_PSG3_FdOut

	; ----- PART 2 -----

	dc.b nRst, $60, nRst, nRst
	sCall		DEZ2_Mini_PSG3_FdInOut
	dc.b nRst, $60, nRst, nRst

	dc.b nRst, $60, nRst, nRst
	sCall		DEZ2_Mini_PSG3_FdInOut
	dc.b nRst, $60, nRst

	; ----- PART 3 -----

	sCall		DEZ2_Mini_PSG3_FdInOut
	dc.b nRst, $60
	sJump		DEZ2_Mini_PSG3

DEZ2_Mini_PSG3_FdIn:
	dc.b nBb6, $06, sHold
	saVolPSG	-$01
	sLoop		$00, $0F, DEZ2_Mini_PSG3_FdIn
	sRet

DEZ2_Mini_PSG3_FdInOut:
	sCall		DEZ2_Mini_PSG3_FdIn
	dc.b nBb6, $0C, sHold

DEZ2_Mini_PSG3_FdOut:
	saVolPSG	$01
	dc.b nBb6, $06, sHold
	sLoop		$00, $0F, DEZ2_Mini_PSG3_FdOut
	sRet
; ---------------------------------------------------------------------------
; Echo track for FM1 for first section, misc for others
; ---------------------------------------------------------------------------

DEZ2_Mini_FM4:
	; ----- PART 1 -----

	sPatFM		$07
	ssModZ80	$02, $02, -$01, $09

	dc.b nRst, $60, nRst, nRst
	saTranspose	-$03

.loop	dc.b nRst, $66, nG4, $12, nF4, $06
	dc.b nRst, nE4, nRst, nG4, nRst, nE4, nF4, nRst
	dc.b nG4, $12

	dc.b nRst, $66, nG4, $12, nF4, $06
	dc.b nRst, nE4, nRst, nG4, nE4, nRst, nA4, nRst
	dc.b nG4, nRst, nE4
	sLoop		$00, $03, .loop
	saTranspose	$03

	; ----- PART 2 & 3 -----

.loop2	dc.b nRst, $60
	sLoop		$00, $14, .loop2
	sJump		DEZ2_Mini_FM4
; ---------------------------------------------------------------------------
; DEZ sounds on first section, base line for others
; ---------------------------------------------------------------------------

DEZ2_Mini_FM1:
	; ----- PART 1 -----

	sPatFM		$07
	ssModZ80	$01, $02, $01, $09

	dc.b nRst, $60, nRst, nRst
	saTranspose	-$03

.loop	dc.b nRst, $66, nBb4, $12, nA4, $06
	dc.b nRst, nG4, nRst, nBb4, nRst, nG4, nA4, nRst
	dc.b nBb4, $12

	dc.b nRst, $66, nBb4, $12, nA4, $06
	dc.b nRst, nG4, nRst, nBb4, nG4, nRst, nC5, nRst
	dc.b nBb4, nRst, nG4
	sLoop		$00, $03, .loop
	saTranspose	$03

	; ----- PART 2 -----

	dc.b nRst, $60
	ssVol		$16
	sCall		DEZ2_Mini_FM13_1

	; ----- PART 3 -----

	dc.b nRst, $60, nRst
	ssVol		$0F
	sJump		DEZ2_Mini_FM1

DEZ2_Mini_FM13_1:
	sPatFM		$04
	sModOff
	saTranspose	$08
	ssTickMulCh	$02

	sCall		DEZ2_Mini_FM13_2
	sCall		DEZ2_FM15_3_
	sCall		DEZ2_Mini_FM13_2
	sCall		DEZ2_FM15_4_

.loop	dc.b nRst
	saVolFM		$08
	dc.b nG4
	sLoop		$00, $04, .loop

	saTranspose	-$08
	ssTickMulCh	$01
	sRet

DEZ2_Mini_FM13_2:
	saTranspose	-$0C
	sCall		.p1
	sCall		.p2
	sCall		.p1
	sCall		.p2

.p3	dc.b nRst
	saVolFM		$04
	dc.b nF4
	sLoop		$00, $08, .p3

	saVolFM		-$04*$08
	saTranspose	$0C
	sRet

.p2	dc.b nBb3, $06, nC4, nD4, nF4
	sLoop		$00, $02, .p2
	sRet

.p1	dc.b nAb3, $06, nBb3, nC4, nEb4
	sLoop		$00, $02, .p1
	sRet
