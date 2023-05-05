LBZ1_Header:
	sHeaderInit	; Z80 offset is $9345
	sHeaderPatch	LBZ2_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $2F
	sHeaderDAC	LBZ1_DAC
	sHeaderFM	LBZ1_FM1, $00, $0C
	sHeaderFM	LBZ1_FM2, $0C, $08
	sHeaderFM	LBZ1_FM3, $00, $0C
	sHeaderFM	LBZ1_FM4, $00, $0C
	sHeaderFM	LBZ1_FM5, $0C, $0C
	sHeaderPSG	LBZ1_PSG1, $F4, $02, $00, VolEnv_00
	sHeaderPSG	LBZ1_PSG2, $F4, $04, $00, VolEnv_00
	sHeaderPSG	LBZ2_PSG3, $00, $02, $00, VolEnv_00

LBZ1_FM1:
	sPatFM		$02
	dc.b nRst, $60, nRst, nRst, nRst

LBZ1_Jump7:
	dc.b nRst, $60, nRst, nRst, nRst
LBZ1_Loop11:
	sCall		LBZ1_Call8
	sLoop		$00, $02, LBZ1_Loop11
	dc.b nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst

LBZ1_Loop12:
	sCall		LBZ1_Call8
	sLoop		$00, $02, LBZ1_Loop12
	dc.b nRst, $0C, nC5, nRst, $48
	sJump		LBZ1_Jump7

LBZ1_Call8:
	sPatFM		$02
	dc.b nRst, $06, nEb4, $04, nRst, $0E, nEb4, $12
	dc.b nEb4, $06, nRst, $18, nC4, $06, nBb3, nG3
	dc.b nF3, nRst, $18, nEb4, $12, nEb4, $06, nRst
	dc.b $18
	sPatFM		$03
	ssModZ80	$01, $01, $03, $05
	dc.b nEb5
	ssModZ80	$01, $01, $01, $04
	sPatFM		$02
	dc.b nRst, $06, nEb4, $04, nRst, $0E, nEb4, $12
	dc.b nEb4, $06, nRst, $18, nC4, $06, nBb3, nG3
	dc.b nF3
	ssModZ80	$01, $01, $01, $04
	dc.b nRst, $18, nEb4, $12, nEb4, $06, nRst, $18
	sPatFM		$03
	saVolFM		$05
	ssModZ80	$06, $01, $12, $01
	dc.b nEb5, $0C
	ssModZ80	$01, $01, $01, $04
	saVolFM		$FB
	dc.b nEb5, $0C
	sRet

LBZ1_FM2:
LBZ1_Loop8:
	sPatFM		$00
	sCall		LBZ1_Call5
	sLoop		$00, $04, LBZ1_Loop8

LBZ1_Loop9:
LBZ1_Jump6:
	sCall		LBZ1_Call5
	sLoop		$00, $03, LBZ1_Loop9
	dc.b nRst, $42, nD2, $06, nG2, $0C, nD2
	sCall		LBZ1_Call6
	sCall		LBZ1_Call7
	sCall		LBZ1_Call6
	sCall		LBZ1_Call6

LBZ1_Loop10:
	sCall		LBZ1_Call5
	sLoop		$00, $08, LBZ1_Loop10
	sCall		LBZ1_Call6
	sCall		LBZ1_Call7
	sCall		LBZ1_Call6
	sCall		LBZ1_Call6
	dc.b nC2, nC1, nC3, nRst, $4E
	sJump		LBZ1_Jump6

LBZ1_Call5:
	dc.b nG1, $12, nD2, nA2, $1E, nD2, $06, nG2
	dc.b $0C, nD2
	sRet

LBZ1_Call6:
	dc.b nC2, $06, nRst, nC2, $0C, nBb1, $12, nA1
	dc.b $06, nRst, $2A, nA1, $06, nF1, nRst, nF1
	dc.b $0C, nFs1, $12, nG1, $06, nRst, $18, nD2
	dc.b $0C, nG2, $06, nD2
	sRet

LBZ1_Call7:
	dc.b nC2, nRst, nC2, $0C, nBb1, $12, nA1, $06
	dc.b nRst, $2A, nA1, $06, nF1, nRst, nF1, $0C
	dc.b nFs1, $12, nG1, $06, nRst, $18, nD2
	sRet

LBZ1_FM3:
	sPatFM		$03
	dc.b nRst, $60, nRst, nRst, nRst

LBZ1_Jump5:
	dc.b nRst, $60, nRst, nRst, nRst
LBZ1_Loop6:
	sCall		LBZ1_Call4
	sLoop		$00, $02, LBZ1_Loop6
	saVolFM		$06

LBZ1_Loop7:
	ssModZ80	$01, $01, $01, $06
	sPatFM		$01
	dc.b nF4, $48, nE4, $18, nD4, $5A, nRst, $06
	dc.b nF4, $48, nG4, $18, nD4, $5A, nRst, $06
	sLoop		$00, $02, LBZ1_Loop7
	dc.b nBb4, $60, sHold, $30, nC5, $30, nG4, $60
	dc.b sHold, $5A, nRst, $06, nBb4, $60, nBb4, $30
	dc.b nF4, nC4, $60, sHold, $5A, nRst, $06
	saVolFM		$FA
	sPatFM		$03
	dc.b nRst, $0C, nC4, $0C, nRst, $48
	sJump		LBZ1_Jump5

LBZ1_Call4:
	dc.b nRst, $60, nRst, $48
	ssModZ80	$01, $01, $03, $05
	dc.b nC5, $18
	ssModZ80	$01, $01, $01, $04
	dc.b nRst, $60, nRst, $48
	saVolFM		$03
	ssModZ80	$06, $01, $12, $01
	dc.b nC5, $0C
	ssModZ80	$01, $01, $01, $04
	dc.b nC5, $0C
	saVolFM		$FD
	sRet

LBZ1_FM4:
	sPatFM		$03
	dc.b nRst, $60, nRst, nRst, nRst

LBZ1_Jump4:
	dc.b nRst, $60, nRst, nRst, nRst
LBZ1_Loop4:
	sCall		LBZ1_Call3
	sLoop		$00, $02, LBZ1_Loop4
	saVolFM		$09

LBZ1_Loop5:
	ssModZ80	$01, $01, $01, $06
	sPatFM		$01
	dc.b nRst, $05, nF4, $48, nE4, $18, nD4, $5A
	dc.b nRst, $06, nF4, $48, nG4, $18, nD4, $55
	dc.b nRst, $06
	sLoop		$00, $02, LBZ1_Loop5
	dc.b nRst, $05, nBb4, $60, sHold, $30, nC5, $30
	dc.b nG4, $60, sHold, $5A, nRst, $06, nBb4, $60
	dc.b nBb4, $30, nF4, nC4, $60, sHold, $55, nRst
	dc.b $06
	saVolFM		$F7
	sPatFM		$03
	dc.b nRst, $0C, nC4, $0C, nRst, $48
	sJump		LBZ1_Jump4

LBZ1_Call3:
	dc.b nRst, $60, nRst, $48
	ssModZ80	$01, $01, $03, $05
	dc.b nBb4, $18
	ssModZ80	$01, $01, $01, $04
	dc.b nRst, $60, nRst, $48
	ssModZ80	$06, $01, $12, $01
	dc.b nBb4, $0C
	ssModZ80	$01, $01, $01, $04
	dc.b nBb4, $0C
	sRet

LBZ1_FM5:
	sPatFM		$02
	dc.b nRst, $60, nRst, nRst, nRst

LBZ1_Jump3:
	dc.b nRst, $60, nRst, nRst, nRst
LBZ1_Loop2:
	sCall		LBZ1_Call2
	sLoop		$00, $02, LBZ1_Loop2
	dc.b nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst

LBZ1_Loop3:
	sCall		LBZ1_Call2
	sLoop		$00, $02, LBZ1_Loop3
	dc.b nRst, $0C, nC4, nRst, $48
	sJump		LBZ1_Jump3

LBZ1_Call2:
	sPatFM		$02
	dc.b nRst, $06, nBb3, $04, nRst, $0E, nBb3, $12
	dc.b nBb3, $06, nRst, $18, nRst, $30, nBb3, $12
	dc.b nBb3, $06, nRst, $18
	sPatFM		$03
	ssModZ80	$01, $01, $03, $05
	dc.b nG4
	ssModZ80	$01, $01, $01, $04
	sPatFM		$02
	dc.b nRst, $06, nBb3, $04, nRst, $0E, nBb3, $12
	dc.b nBb3, $06, nRst, $18, nRst, $30, nBb3, $12
	dc.b nBb3, $06, nRst, $18
	sPatFM		$03
	saVolFM		$05
	ssModZ80	$06, $01, $12, $01
	dc.b nG4, $0C
	ssModZ80	$01, $01, $01, $04
	saVolFM		$FB
	dc.b nG4, $0C
	sRet

LBZ1_PSG1:
LBZ1_Jump1:
	sNoteTimeOut	$05
	sVolEnvPSG	VolEnv_11
	dc.b nRst, $60, nRst, nRst
	sCall		LBZ1_Call1

LBZ1_Jump2:
	sCall		LBZ1_Call1
	dc.b nF5, $06, nRst, nG5, nRst, nD5, nRst, nF5
	dc.b nF5, nRst, nF5, nG5, nRst, $1E, nRst, $60
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst

LBZ1_Loop1:
	sCall		LBZ1_Call1
	sLoop		$00, $04, LBZ1_Loop1
	dc.b nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst
	sJump		LBZ1_Jump2

LBZ1_Call1:
	dc.b nF5, $06, nRst, nG5, nRst, nD5, nRst, nF5
	dc.b nF5, nRst, nF5, nG5, nRst, nD5, nRst, nF5
	dc.b nRst, $66
	sRet

LBZ1_PSG2:
	dc.b nRst, $01
	sModEnv		ModEnv_01
	sJump		LBZ1_Jump1

LBZ1_DAC:
	dc.b dModLooseKick, $12, nRst, dModLooseKick, $3C
LBZ1_Loop13:
	dc.b dModLooseKick, $06, dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum, nRst, dModLooseKick
	dc.b dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum, dPowerTom, dPowerTom, $18
	sLoop		$00, $02, LBZ1_Loop13
	dc.b dModLooseKick, $0C, dHiWoodBlock, $06, dModLooseKick, dLowWoodBlock, dLowWoodBlock, dModLooseKick
	dc.b dHiWoodBlock, nRst, dHiWoodBlock, dLowWoodBlock, dLowWoodBlock, dLowWoodBlock, dLowWoodBlock, dLowWoodBlock
	dc.b dLowWoodBlock

LBZ1_Jump8:
	sCall		LBZ1_Call9
	dc.b dModLooseKick, $06, dHiHitDrum, nRst, dModLooseKick, dSnareGo, nRst, dModLooseKick
	dc.b dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum, dSnareGo, dSnareGo, nRst, dLowWoodBlock
	dc.b dLowWoodBlock
	sCall		LBZ1_Call9
	dc.b dModLooseKick, $06, nRst, dHiWoodBlock, nRst, dLowWoodBlock, dLowWoodBlock, dLowWoodBlock
	dc.b dHiWoodBlock, nRst, nRst, $2A, dModLooseKick, $0C, dModLooseKick, dSnareGo
	dc.b $12, dModLooseKick, $1E, dMetalCrashHit, $18
	sCall		LBZ1_Call10

LBZ1_Loop14:
	dc.b dModLooseKick, $0C, dModLooseKick, dSnareGo, $12, dModLooseKick, $1E, dSnareGo
	dc.b $24
	sCall		LBZ1_Call11
	sLoop		$00, $02, LBZ1_Loop14
	dc.b dModLooseKick, $0C, dModLooseKick, dSnareGo, $12, dModLooseKick, $1E, dSnareGo
	dc.b $18, nRst, $36, dQuietGlassCrash, $12, dMetalCrashHit, $0B, dMetalCrashHit
	dc.b $0D

LBZ1_Loop15:
	dc.b dModLooseKick, $06, dHiHitDrum, nRst, dModLooseKick, dSnareGo, nRst, dModLooseKick
	dc.b dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum, dPowerTom, dSnareGo, nRst, dLowWoodBlock
	dc.b dLowWoodBlock, dModLooseKick, nRst, dHiWoodBlock, dModLooseKick, dSnareGo, nRst, dModLooseKick
	dc.b dHiWoodBlock, nRst, dHiWoodBlock, dLowWoodBlock, dSnareGo, dSnareGo, nRst, dLowWoodBlock
	dc.b dLowWoodBlock
	sLoop		$00, $03, LBZ1_Loop15
	dc.b dModLooseKick, $06, dHiHitDrum, nRst, dModLooseKick, dSnareGo, nRst, dModLooseKick
	dc.b dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum, dPowerTom, dSnareGo, nRst, dLowWoodBlock
	dc.b dLowWoodBlock, dModLooseKick, nRst, dHiWoodBlock, dModLooseKick, dSnareGo, nRst, dModLooseKick
	dc.b dHiWoodBlock, nRst, dSnareGo, nRst, dSnareGo, dSnareGo, nRst, dSnareGo
	dc.b nRst, dModLooseKick, $06, nRst, dModLooseKick, nRst, dSnareGo, nRst
	dc.b nRst, dModLooseKick, nRst, nRst, dGo, nRst, dSnareGo, nRst
	dc.b dGo, nRst, dModLooseKick, nRst, dGo, nRst, dSnareGo, nRst
	dc.b dGo, dModLooseKick, dModLooseKick, nRst, dGo, dSnareGo, dSnareGo, nRst
	dc.b dGo, nRst

LBZ1_Loop16:
	dc.b dModLooseKick, $06, nRst, dGo, nRst, dSnareGo, nRst, dGo
	dc.b dModLooseKick, dModLooseKick, nRst, dGo, nRst, dSnareGo, nRst, dGo
	dc.b dModLooseKick, dModLooseKick, nRst, dGo, nRst, dSnareGo, nRst, dGo
	dc.b dModLooseKick, dModLooseKick, nRst, dGo, dSnareGo, dSnareGo, nRst, dGo
	dc.b nRst
	sLoop		$00, $02, LBZ1_Loop16
	dc.b dModLooseKick, $06, nRst, dGo, nRst, dSnareGo, nRst, dGo
	dc.b dModLooseKick, dModLooseKick, nRst, dGo, nRst, dSnareGo, nRst, dGo
	dc.b dModLooseKick, dModLooseKick, nRst, dGo, nRst, dSnareGo, nRst, dGo
	dc.b dModLooseKick, dModLooseKick, dSnareGo, dGo, dSnareGo, dSnareGo, nRst, dSnareGo
	dc.b nRst, dModLooseKick, dModLooseKick, dSnareGo, $54
	sJump		LBZ1_Jump8

LBZ1_Call9:
	dc.b dModLooseKick, $06, dHiHitDrum, nRst, dHiHitDrum, dSnareGo, nRst, dModLooseKick
	dc.b dHiHitDrum, nRst, dHiHitDrum, dLowHitDrum, dPowerTom, dSnareGo, nRst, dLowWoodBlock
	dc.b dLowWoodBlock
	sRet

LBZ1_Call10:
	dc.b dModLooseKick, $18, dSnareGo, $0C, dScratch, dPowerTom, $12, dSnareGo
	dc.b $06, dSnareGo, $0C, dScratch
	sRet

LBZ1_Call11:
	dc.b dModLooseKick, $0C, dSnareGo, $12, dModLooseKick, $06, dPowerTom, $12
	dc.b dSnareGo, $06, dSnareGo, $18
	sRet
