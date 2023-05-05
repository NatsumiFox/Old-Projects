SSZMG_Header:
	sHeaderInit	; made by Natsumi and Markey
	sHeaderPatch	SSZ_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $04
	sHeaderDAC	SSZMG_DAC
	sHeaderFM	SSZMG_FM1, $E8, $0D
	sHeaderFM	SSZMG_FM2, $00, $15
	sHeaderFM	SSZMG_FM3, $00, $17
	sHeaderFM	SSZMG_FM4, $00, $1C
	sHeaderFM	SSZMG_FM5, $00, $17
	sHeaderPSG	SSZMG_PSG1, $F4, $05, $00, VolEnv_00
	sHeaderPSG	SSZMG_PSG2, $F4, $05, $00, VolEnv_00
	sHeaderPSG	SSZMG_PSG3, $00, $02, $00, VolEnv_00
; ---------------------------------------------------------------------------

SSZMG_DAC:
	sCall		SSZ_FM5PSG2_Delay
	dc.b nRst, $18
;	ssTempo		$60
	dc.b dKick, $0C, $0C
	dc.b dSnare, $06, $06, $06, $06

	sCall		SSZ_DAC_MainBeat1
	dc.b dSnare, $06, $06, $06, dKick
	sCall		SSZ_DAC_MainBeat1
	dc.b dHighTom, $06, dMidTom, dLowTom, dFloorTom

	ssTempo		$04
.loop	sCall		SSZ_DAC_0
	sLoop		$00, $04, .loop

	sPan		spCenter, $00
	dc.b dKick, $05, dKick, dKick, $0E, nRst, $0C, dMuffledSnare
	dc.b $05, dMuffledSnare, dMuffledSnare, $0E, dMuffledSnare, $0C, nRst, dKick
	dc.b $06, dKick, dKick, $0C, dKick, nRst, dMuffledSnare, $05
	dc.b dMuffledSnare, dMuffledSnare, $0E, dMuffledSnare, $0C, nRst, dKick, dKick
	dc.b $0C, dKick, nRst, dMuffledSnare, $05, dMuffledSnare, dMuffledSnare, $0E
	dc.b dKick, $06, dKick, dMuffledSnare, dMuffledSnare, dMuffledSnare, dMuffledSnare, nRst
	sStop

SSZ_DAC_MainBeat1:
	sCall		.beat
	dc.b dSnare, $18
	sCall		.beat
	dc.b dSnare, $06, dKick, $12
	sCall		.beat
	dc.b dSnare, $18

.beat	dc.b dKick, $18, dSnare, $12
	dc.b dKick, $06, $0C, $0C
	sRet
; ---------------------------------------------------------------------------

SSZMG_FM1:
	sPatFM		$00
	saDetune	$FE
	sCall		SSZ_FM1_Intro

	saDetune	$00
	ssVol		$12
	sPatFM		$06	; FM_CLSlapBass
	dc.b nRst, $18
;	dc.b nRst, $08

.loop	sCall		SSZ_FM_MainBass
	saTranspose	-$02
	sCall		SSZ_FM_MainBass
	saTranspose	$02
	sCall		SSZ_FM_MainBass
	saTranspose	-$02
	sCall		SSZ_FM_EndBass
	saTranspose	$02
	sLoop		$00, $02, .loop

	saTranspose	$18
	ssModZ80	$24, $01, $04, $08
	sPatFM		$01
	ssVol		$12
	sCall		SSZ_FM5_0
	dc.b nC6, $60, sHold, $60, sHold, $60
	sStop

SSZ_FM_MainBass:
	dc.b nA4, $18, $06, nRst, $1E
	dc.b nA4, $0C, nG4, $06, nA4, nRst, $0C	; $40
	sRet

SSZ_FM_EndBass:
	dc.b nA4, $18, $06, nRst, $0C
	dc.b nA4, $06, nE5, nRst
	dc.b nEb5, nRst, nCs5, nCs5, nA4, $0C
	sRet
; ---------------------------------------------------------------------------

SSZMG_FM4:
	sCall		SSZ_FM4_Intro
	dc.b nRst, $08
	sCall		SSZ_FM5_Intro
	sCall		SSZ_FM24_Intro0

	ssModZ80	$01, $02, $03, $08
	ssVol		$18
	sCall		SSZ_FM24_Sec0
	dc.b nE4, $10

	ssVol		$17
	sPatFM		$02
	sCall		SSZ_Call2
	sCall		SSZ_FM3_0
	dc.b nC3, $60, sHold, $60, sHold, $60
	sStop

SSZ_FM24_Intro0:
	dc.b nC5, $0C

.loop	saVolFM		$01
	dc.b sHold, $01
	sLoop		$00, $0C, .loop
	saVolFM		-$0C
	sRet
; ---------------------------------------------------------------------------

SSZMG_FM2:
	sCall		SSZ_FM5_Intro
	sCall		SSZ_FM24_Intro0
	ssVol		$12
	sCall		SSZ_FM24_Sec0
	dc.b nE4, $18

	sPatFM		$00
	saDetune	$FE
	saTranspose	-$18
	ssVol		$0B
	sCall		SSZ_FM1_1
	sCall		SSZ_FM1_0
	dc.b nC3, $60, sHold, $60, sHold, $60
	sStop

SSZ_FM24_Sec0:
	sPatFM		$04	; FM_CLStatPiano
	dc.b nCs4, $06, nD4, nEb4, nE4, nF4, nFs4, nG4, nAb4

	dc.b nA4, $60, nG4, $48, nFs4, $18, nE4, $30
	dc.b nCs4, $18, nE4, nD4, $30, nB3
	dc.b nA4, $60, nG4, $30, nFs4, $18, nG4, nFs4, $48
	dc.b nD4, $18, nE4, $60

.loop	saVolFM		$04
	dc.b nE4, $18
	sLoop		$00, $0F, .loop
	saVolFM		$04
	sRet
; ---------------------------------------------------------------------------

SSZMG_FM3:
	sCall		SSZ_FM3_Intro
	dc.b nE5, $06
	ssVol		$18
	sPatFM		$05	; FM_CLSynPiano
	dc.b nRst, $30

.loop	dc.b nFs1, $30, nG1, $30, $60, nFs1, $30, $30, nE1, $60
	sLoop		$00, $02, .loop

	dc.b nRst, $0E
	ssModZ80	$24, $01, $04, $07
	saDetune	$02
	sPatFM		$01
	ssVol		$19
	sCall		SSZ_FM5_0
	dc.b nC6, $60, sHold, $60, sHold, $60
	sStop
; ---------------------------------------------------------------------------

SSZMG_FM5:
	sCall		SSZ_FM5PSG2_Delay
	ssVol		$18
	sPatFM		$05	; FM_CLSynPiano
	dc.b nRst, $48

.loop	dc.b nA1, $60, $30, nB1, $30, $60, nA1, $60
	sLoop		$00, $02, .loop

	ssVol		$17
	sCall		SSZ_FM2_0
	dc.b nC4, $60, sHold, $60, sHold, $60
	sStop
; ---------------------------------------------------------------------------

SSZMG_PSG1:
	sCall		SSZ_PSG1_Intro
	sCall		SSZ_PSG12_Sec0

	sVolEnvPSG	VolEnv_04
	sModOff
	saVolPSG	-$04

.loop	dc.b nC5, $06, nC4, nC5, nC4
	saVolPSG	-$01
	dc.b nC5, nC4, nC5, nC4
	saVolPSG	-$01
	dc.b nC6, nC4, nC6, nC4
	saVolPSG	-$01
	dc.b nC5, nC4, nC5, nC4
	saVolPSG	-$01
	sLoop		$00, $02, .loop

.loop2	sCall		SSZ_Call1
	sLoop		$00, $07, .loop2
	sStop

SSZ_PSG12_Sec0:
	saTranspose	$18
	ssModZ80	$01, $02, $02, $04
	sVolEnvPSG	$26
;	saVolPSG	$02
	sJump		.inilp

.loop	dc.b nCs1, $60, nB0, nCs1
	dc.b nD1, $30

.inilp	dc.b nFs1, $18, nE1
	sLoop		$00, $03, .loop

.loop2	saVolPSG		$01
	dc.b nCs1, $18
	sLoop		$00, $0C, .loop2
	saTranspose	-$18
	sRet
; ---------------------------------------------------------------------------

SSZMG_PSG2:
	sCall		SSZ_FM5PSG2_Delay
	saVolPSG	$03
	saDetune	-$04
	dc.b nRst, $1E
	sCall		SSZ_PSG12_Sec0

	dc.b nRst, $58
.loop	dc.b nRst, $60
	sLoop		$00, $0F, .loop
	sStop
; ---------------------------------------------------------------------------

SSZMG_PSG3:
	sCall		SSZ_PSG3_0
	sLoop		$00, $0D, SSZMG_PSG3

	sNoisePSG	$E4
	saVolPSG	-$02

.loop	sVolEnvPSG	VolEnv_01
	dc.b nA6, $06, $06, $06, $06

	sVolEnvPSG	VolEnv_04
	dc.b nA6, $06, nRst, nA6, nRst
	sLoop		$00, $11, .loop

.loop2	sCall		SSZ_PSG3_0
	sLoop		$00, $4C, .loop2
	sStop
; ---------------------------------------------------------------------------
