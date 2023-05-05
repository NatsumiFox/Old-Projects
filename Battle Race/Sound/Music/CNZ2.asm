CNZ2_Header:
	sHeaderInit	; Z80 offset is $DDA9
	sHeaderPatch	CNZ1MG_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $44
	sHeaderDAC	CNZ2_DAC
	sHeaderFM	CNZ2_FM1, $00, $0C
	sHeaderFM	CNZ2_FM2, $00, $06
	sHeaderFM	CNZ2_FM3, $00, $07
	sHeaderFM	CNZ2_FM4, $00, $05
	sHeaderFM	CNZ2_FM5, $0C, $13
	sHeaderPSG	CNZ2_PSG1, $F4, $04, $00, VolEnv_00
	sHeaderPSG	CNZ2_PSG2, $F4, $04, $00, VolEnv_00
	sHeaderPSG	CNZ2_PSG3, $23, $02, $00, VolEnv_00

CNZ2_FM1:
CNZ2_Jump8:
	ssModZ80	$02, $01, $05, $04
	sPatFM		$03
	dc.b nRst, $60, sHold, $60, nRst, $60, nRst, $48
	sPatFM		$00
	ssModZ80	$0B, $01, $0C, $04
	dc.b nC5, $13, nB4, $05
	sPatFM		$00
	ssModZ80	$02, $01, $02, $04
	sCall		CNZ2_Call4
	ssModZ80	$11, $01, $15, $05
	dc.b nG4, $30, nRst, $18
	sPatFM		$03
	ssModZ80	$02, $01, $05, $04
	sCall		CNZ2_Call8
	dc.b nRst, $48
	sPatFM		$00
	ssModZ80	$0B, $01, $0C, $04
	dc.b nC5, $13, nB4, $05
	sPatFM		$00
	ssModZ80	$02, $01, $02, $04
	sCall		CNZ2_Call4
	ssModZ80	$11, $01, $15, $05
	dc.b nG4, $30, nRst, $18
	sPatFM		$03
	ssModZ80	$02, $01, $05, $04
	sCall		CNZ2_Call8
	dc.b nRst, $0C, nEb4, $05, nRst, $1F, nC4, $05
	dc.b nRst, $13, nRst, $60, nRst, nRst, nRst, $60
	dc.b nRst, $60, nRst, nRst, nRst, $60
	sPatFM		$00
	ssModZ80	$0B, $01, $0C, $04
	dc.b nC5, $13, nB4, $05
	sPatFM		$00
	ssModZ80	$02, $01, $02, $04
	sCall		CNZ2_Call4
	ssModZ80	$11, $01, $15, $05
	dc.b nG4, $30, nRst, $18, nRst, $60, nRst, $48
	dc.b nRst, $18
	sPatFM		$04
	ssModZ80	$02, $01, $05, $04
	dc.b nG5, $05, nRst, $07, nFs5, $05, nRst, $07
	dc.b nF5, nFs5, $05, nF5, $07, nE5, $05, nEb5
	dc.b nRst, $07, nD5, $05, nRst, $07, nCs5, nD5
	dc.b $05, nCs5, $07, nC5, $05, nB4, nRst, $07
	dc.b nBb4, $05, nRst, $07, nBb4, nB4, $05, nC5
	dc.b $07, nCs5, $05, nD5, $24, nRst, $05, nD5
	dc.b $07, nG5, $05, nRst, $07, nFs5, $05, nRst
	dc.b $07, nF5, nFs5, $05, nF5, $07, nE5, $05
	dc.b nEb5, nRst, $07, nD5, $05, nRst, $07, nCs5
	dc.b nD5, $05, nCs5, $07, nC5, $05, nB4, nRst
	dc.b $07, nBb4, $05, nRst, $07, nA4, nBb4, $05
	dc.b nA4, $07, nAb4, $05, nG4, $24, nRst, $05
	dc.b nD5, $07, nG5, nRst, $05, nFs5, $07, nRst
	dc.b $05, nF5, $07, nFs5, $05, nF5, $07, nE5
	dc.b $05, nEb5, $07, nRst, $05, nD5, $07, nRst
	dc.b $05, nCs5, $07, nD5, $05, nCs5, $07, nC5
	dc.b $05
	saTranspose	$F4
	sCall		CNZ1MG_Jam
	saTranspose	$0C
	sJump		CNZ2_Jump8

CNZ2_Call8:
	dc.b nE5, $05, nRst, $07, nEb5, $05, nRst, $07
	dc.b nD5, nEb5, $05, nD5, $07, nCs5, $05, nC5
	dc.b nRst, $07, nB4, $05, nRst, $07, nBb4, $0C
	dc.b nA4, $05, nRst, $07
	sRet

CNZ2_Call4:
	dc.b nD5, $06, nRst, nC5, nRst, nB4, nRst, nC5
	dc.b nRst, nG4, nRst, nA4, $05, nRst, $07, nC5
	dc.b $0C, nB4, nG4, nRst
	sRet
	; Unused
	dc.b $C2, $07, $C1, $05, $C0, $80, $07, $BF
	dc.b $05, $80, $07, $BE, $BF, $05, $BE, $07
	dc.b $BD, $05, $F9

CNZ2_FM2:
CNZ2_Jump7:
	sPatFM		$01

CNZ2_Loop13:
	dc.b nC2, $0C, nRst, $18, nC2, $0C, nRst, $30
	sLoop		$00, $03, CNZ2_Loop13
	dc.b nRst, $60

CNZ2_Loop14:
	dc.b nC2, $0C, nRst, $18, nC2, $0C, nRst, $30
	sLoop		$00, $08, CNZ2_Loop14
	sCall		CNZ2_Call7
	dc.b nG2, $06, nRst, nG2, nRst, $2A, nG2, $1E
	dc.b nRst, $06, nRst, $60

CNZ2_Loop15:
	dc.b nC2, $0C, nRst, $18, nC2, $0C, nRst, $30
	sLoop		$00, $07, CNZ2_Loop15
	dc.b nC2, $0C, nRst, $18, nC2, $0C, nRst, nG1
	dc.b nA1, nB1

CNZ2_Loop16:
	sCall		CNZ2_Call7
	sLoop		$00, $02, CNZ2_Loop16
	dc.b nG2, $06, nRst, nG2, nRst, $2A, nG2, $1E
	dc.b nRst, $06
	sCall		CNZ1MG_Jam
	sJump		CNZ2_Jump7

CNZ2_Call7:
	dc.b nG2, $06, nRst, nG2, nRst, $2A, nG2, $1E
	dc.b nRst, $06, nG2, nRst, nG2, $2A, nRst, $06
	dc.b nG2, $0C, nF2, nFs2
	sRet

CNZ2_FM3:
CNZ2_Loop11:
CNZ2_Jump6:
	sPan		spLeft, $00
	sNoteTimeOut	$06
	sPatFM		$02
	dc.b nRst, $0C, nG4, $18, nG4, nG4, nG4, $0C
	sLoop		$00, $03, CNZ2_Loop11
	dc.b nRst, $60, nRst, $60, nRst, nRst
	sNoteTimeOut	$06
	sPatFM		$02
	dc.b nRst, $0C, nG4, $18, nG4, nG4, nG4, $0C
	dc.b nRst, $60, nRst, nRst, nRst
	sNoteTimeOut	$00
	sPatFM		$03
	sCall		CNZ2_Call3
	dc.b nRst, $0C, nD4, nRst, $07, nD4, $05, nRst
	dc.b $0C, nD4, $05, nRst, $07, nRst, $24, nRst
	dc.b $60, nRst, $60, nRst, nRst, nRst, nRst, nRst
	sNoteTimeOut	$06
	sPatFM		$02
	dc.b nRst, $0C, nG4, $18, nG4, nG4, nG4, $0C
	dc.b nRst, $0C, nG4, $18, nG4, nG4, nG4, $0C

CNZ2_Loop12:
	sNoteTimeOut	$00
	sPatFM		$03
	sCall		CNZ2_Call3
	sLoop		$00, $02, CNZ2_Loop12
	dc.b nRst, $0C, nD4, nRst, $07, nD4, $05, nRst
	dc.b $0C, nD4, $05, nRst, $07, nRst, $24
	sCall		CNZ1MG_Jam
	sJump		CNZ2_Jump6

CNZ2_Call3:
	dc.b nRst, $0C, nD4, nRst, $07, nD4, $05, nRst
	dc.b $0C, nD4, $05, nRst, $07, nRst, $24, nRst
	dc.b $0C, nG3, $0C, nRst, $07, nG3, $05, nRst
	dc.b $0C, nG3, $05, nRst, $2B
	sRet

CNZ2_FM4:
CNZ2_Loop9:
CNZ2_Jump5:
	sPan		spRight, $00
	sNoteTimeOut	$06
	sPatFM		$02
	dc.b nC4, $0C, nE4, nG3, nE4, nC4, nE4, nG3
	dc.b nE4
	sLoop		$00, $03, CNZ2_Loop9
	dc.b nRst, $60, nRst, $60, nRst, nRst
	sNoteTimeOut	$06
	sPatFM		$02
	dc.b nC4, $0C, nE4, nG3, nE4, nC4, nE4, nG3
	dc.b nE4, nRst, $60, nRst, nRst, nRst
	sNoteTimeOut	$00
	sPatFM		$03
	sCall		CNZ2_Call2
	dc.b nRst, $0C, nF3, nG2, $07, nF3, $05, nRst
	dc.b $07, nG2, $05, nF3, nRst, $13, nF3, $07
	dc.b nG3, $05, nF3, $07, nC3, $05, nRst, $60
	dc.b nRst, $60, nRst, nRst, nRst, nRst, nRst
	sNoteTimeOut	$06
	sPatFM		$02
	dc.b nC4, $0C, nE4, nG3, nE4, nC4, nE4, nG3
	dc.b nE4, nC4, $0C, nE4, nG3, nE4, nC4, nE4
	dc.b nG3, nE4

CNZ2_Loop10:
	sNoteTimeOut	$00
	sPatFM		$03
	sCall		CNZ2_Call2
	sLoop		$00, $02, CNZ2_Loop10
	dc.b nRst, $0C, nF3, nG2, $07, nF3, $05, nRst
	dc.b $07, nG2, $05, nF3, nRst, $13, nF3, $07
	dc.b nG3, $05, nF3, $07, nC3, $05
	sCall		CNZ1MG_Jam
	sJump		CNZ2_Jump5

CNZ2_Call2:
	dc.b nRst, $0C, nF3, nG2, $07, nF3, $05, nRst
	dc.b $07, nG2, $05, nF3, nRst, $13, nF3, $07
	dc.b nG3, $05, nF3, $07, nC3, $05, nC2, $05
	dc.b nRst, $13, nC3, $05, nRst, $07, nRst, nC3
	dc.b $05, nRst, $13, nG2, $05, nBb2, $07, nC3
	dc.b $05, nBb2, $07, nG2, $05
	sRet

CNZ2_FM5:
CNZ2_Jump4:
	sPatFM		$03
	dc.b nRst, $60, nRst, $60, nRst, $60, nRst, $02
	dc.b nRst, $48, nC5, $13, nB4, $03
	sPatFM		$00
	ssModZ80	$02, $01, $02, $04
	dc.b nRst, $02
	sCall		CNZ2_Call4
	ssModZ80	$11, $01, $15, $05
	dc.b nG4, $30, nRst, $16
	sPatFM		$03
	dc.b nC5, $06, nRst, nB4, nRst, nBb4, $07, nB4
	dc.b $05, nBb4, $07, nA4, $05, nAb4, $05, nRst
	dc.b $07, nG4, $05, nRst, $07, nFs4, $0C, nF4
	dc.b $05, nRst, $07, nRst, $48
	sPatFM		$00
	ssModZ80	$0B, $01, $0C, $04
	dc.b nRst, $02, nC5, $13, nB4, $05
	sPatFM		$00
	ssModZ80	$02, $01, $02, $04
	sCall		CNZ2_Call4
	ssModZ80	$11, $01, $15, $05
	dc.b nG4, $30, nRst, $16
	sPatFM		$03
	dc.b nC5, $05, nRst, $07, nB4, $05, nRst, $07
	dc.b nBb4, nB4, $05, nBb4, $07, nA4, $05, nAb4
	dc.b nRst, $07, nG4, $05, nRst, $07, nFs4, $0C
	dc.b nF4, $05, nRst, $07, nRst, $0C, nBb3, $05
	dc.b nRst, $07, nF3, nG3, $05, nF3, nRst, $07
	dc.b nG3, $05, nRst, $07, nF3, nG3, $05, nF3
	dc.b $07, nBb3, $05, nG3, nRst, $07
	sCall		CNZ2_Call5
	dc.b nRst, $0C, nA3, $0C, nRst, $07, nA3, $05
	dc.b nRst, $0C, nA3, $05, nRst, $2B, nRst, $60
	sPatFM		$00
	dc.b nRst, $60, nRst, nRst, nRst, $48
	sPatFM		$00
	ssModZ80	$0B, $01, $0C, $04
	dc.b nRst, $02, nC5, $13, nB4, $05
	sPatFM		$00
	ssModZ80	$02, $01, $02, $04
	sCall		CNZ2_Call4
	ssModZ80	$11, $01, $15, $05
	dc.b nG4, $30, nRst, $16
	sPatFM		$03
	dc.b nRst, $60, nRst

CNZ2_Loop8:
	sCall		CNZ2_Call5
	sLoop		$00, $02, CNZ2_Loop8
	dc.b nRst, $0C, nA3, $0C, nRst, $07, nA3, $05
	dc.b nRst, $0C, nA3, $05, nRst, $2B
	sCall		CNZ1MG_Jam
	sJump		CNZ2_Jump4

CNZ2_Call5:
	dc.b nRst, $0C, nA3, $0C, nRst, $07, nA3, $05
	dc.b nRst, $3C, nRst, $0C, nF3, $0C, nRst, $07
	dc.b nF3, $05, nRst, $0C, nE3, $05, nRst, $2B
	sRet

CNZ2_PSG1:
CNZ2_Loop6:
CNZ2_Jump3:
	sNoteTimeOut	$06
	sVolEnvPSG	VolEnv_05
	sModEnv		ModEnv_02
	dc.b nRst, $0C, nG4, $18, nG4, nG4, nG4, $0C
	sLoop		$00, $03, CNZ2_Loop6
	dc.b nRst, $60, nRst, $60, nRst, nRst, nRst, $0C
	sNoteTimeOut	$06
	sVolEnvPSG	VolEnv_05
	dc.b nG4, $18, nG4, nG4, nG4, $0C, nRst, $60
	dc.b nRst, nRst, nRst
	sNoteTimeOut	$00
	sVolEnvPSG	VolEnv_04
	sCall		CNZ2_Call3
	dc.b nRst, $0C, nD4, nRst, $07, nD4, $05, nRst
	dc.b $0C, nD4, $05, nRst, $07, nRst, $24, nRst
	dc.b $60, nRst, $60, nRst, nRst, nRst, nRst, nRst
	sNoteTimeOut	$06
	sVolEnvPSG	VolEnv_05
	dc.b nRst, $0C, nG4, $18, nG4, nG4, nG4, $0C
	dc.b nRst, $0C, nG4, $18, nG4, nG4, nG4, $0C

CNZ2_Loop7:
	sNoteTimeOut	$00
	sVolEnvPSG	VolEnv_04
	sCall		CNZ2_Call3
	sLoop		$00, $02, CNZ2_Loop7
	dc.b nRst, $0C, nD4, nRst, $07, nD4, $05, nRst
	dc.b $0C, nD4, $05, nRst, $07, nRst, $24, nRst
	dc.b $60, nRst
	sJump		CNZ2_Jump3

CNZ2_PSG2:
CNZ2_Loop4:
CNZ2_Jump2:
	sVolEnvPSG	VolEnv_12
	sModEnv		ModEnv_02
	sNoteTimeOut	$06
	dc.b nC4, $0C, nE4, nG3, nE4, nC4, nE4, nG3
	dc.b nE4
	sLoop		$00, $03, CNZ2_Loop4
	dc.b nRst, $60
	sVolEnvPSG	VolEnv_12
	dc.b nRst, $60, nRst, nRst
	sNoteTimeOut	$06
	dc.b nC4, $0C, nE4, nG3, nE4, nC4, nE4, nG3
	dc.b nE4, nRst, $60, nRst, nRst, nRst
	sNoteTimeOut	$00
	sVolEnvPSG	VolEnv_11
	dc.b nRst, $0C, nF3, nG2, $07, nF3, $05, nRst
	dc.b $07, nG2, $05, nF3, nRst, $13, nF3, $07
	dc.b nG3, $05, nF3, $07, nC3, $05, nC2, $05
	dc.b nRst, $13, nC3, $05, nRst, $07, nRst, nC3
	dc.b $05, nRst, $13, nG2, $05, nBb2, $07, nC3
	dc.b $05, nBb2, $07, nG2, $05, nRst, $0C, nF3
	dc.b nG2, $07, nF3, $05, nRst, $07, nG2, $05
	dc.b nF3, nRst, $13, nF3, $07, nG3, $05, nF3
	dc.b $07, nC3, $05, nRst, $60, nRst, $60, nRst
	dc.b nRst, nRst, nRst, $60, nRst
	sNoteTimeOut	$06
	sVolEnvPSG	VolEnv_12
	dc.b nC4, $0C, nE4, nG3, nE4, nC4, nE4, nG3
	dc.b nE4, nC4, $0C, nE4, nG3, nE4, nC4, nE4
	dc.b nG3, nE4

CNZ2_Loop5:
	sNoteTimeOut	$00
	sVolEnvPSG	VolEnv_11
	sCall		CNZ2_Call2
	sLoop		$00, $02, CNZ2_Loop5
	dc.b nRst, $0C, nF3, nG2, $07, nF3, $05, nRst
	dc.b $07, nG2, $05, nF3, nRst, $13, nF3, $07
	dc.b nG3, $05, nF3, $07, nC3, $05, nRst, $60
	dc.b nRst
	sJump		CNZ2_Jump2

CNZ2_PSG3:
	sVolEnvPSG	VolEnv_01
	sNoisePSG	$E7

CNZ2_Loop1:
CNZ2_Jump1:
	sCall		CNZ2_Call1
	sLoop		$00, $03, CNZ2_Loop1
	dc.b nC4, $0C, nRst, $54

CNZ2_Loop2:
	sCall		CNZ2_Call1
	sLoop		$00, $0B, CNZ2_Loop2
	dc.b nC4, $0C, nRst, $54

CNZ2_Loop3:
	sCall		CNZ2_Call1
	sLoop		$00, $0D, CNZ2_Loop3
	dc.b nC4, $0C, nRst, $54, nRst, $60
	sJump		CNZ2_Jump1

CNZ2_Call1:
	dc.b nC4, $08, $04, $04, nRst, $08
	saVolPSG	$FE
	dc.b nC4, $04
	saVolPSG	$02
	dc.b nRst, $08, nC4, $08, $04, nC4, nRst, $14
	saVolPSG	$FE
	dc.b nC4, $04
	saVolPSG	$02
	dc.b nRst, $14
	sRet

CNZ2_DAC:
CNZ2_Loop17:
CNZ2_Jump9:
	dc.b dPowerKick, $0C, dClick, dQuickGlassCrash, $24, dPowerKick, $0C, dQuickGlassCrash
	dc.b dQuickGlassCrash
	sLoop		$00, $03, CNZ2_Loop17
	dc.b dGlassCrashKick, $48, dQuietGlassCrash, $18

CNZ2_Loop18:
	dc.b dPowerKick, $0C, dClick, dQuickGlassCrash, $24, dPowerKick, $0C, dQuickGlassCrash
	dc.b dQuickGlassCrash
	sLoop		$00, $0B, CNZ2_Loop18
	dc.b dGlassCrashKick, $48, dQuietGlassCrash, $18

CNZ2_Loop19:
	dc.b dPowerKick, $0C, dClick, dQuickGlassCrash, $24, dPowerKick, $0C, dQuickGlassCrash
	dc.b dQuickGlassCrash
	sLoop		$00, $0D, CNZ2_Loop19
	dc.b dGlassCrashSnare, $60, dGlassCrash
	sJump		CNZ2_Jump9
	; Unused
	dc.b $F2
