AIZ2_Header:
	sHeaderInit	; Z80 offset is $9B6D
	sHeaderPatchUniv
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $15
	sHeaderDAC	AIZ2_DAC
	sHeaderFM	AIZ2_FM1, $18, $0F
	sHeaderFM	AIZ2_FM2, $0C, $13
	sHeaderFM	AIZ2_FM3, $0C, $13
	sHeaderFM	AIZ2_FM4, $0C, $13
	sHeaderFM	AIZ2_FM5, $0C, $13
	sHeaderPSG	AIZ2_PSG1, $F4, $04, $00, VolEnv_0C
	sHeaderPSG	AIZ2_PSG2, $F4, $04, $00, VolEnv_0C
	sHeaderPSG	AIZ2_PSG3, $00, $03, $00, VolEnv_0C

AIZ2_Call4:
	dc.b dKick, $0C, dKick, dSnare, dKick, $06, dSnare, $0C
	dc.b dSnare, $06, dKick, $0C, dSnare, dKick, dKick, dKick
	dc.b dSnare, dKick, $06, dSnare, $0C, dSnare, $06, dKick
	dc.b dSnare, dSnare, $0C, dKick, $06, dSnare
	sRet

AIZ2_Call5:
	dc.b dKick, $0C, dKick, dSnare, dKick, $06, dSnare, $0C
	dc.b dSnare, $06, dKick, $0C, dSnare, dKick
	sRet

AIZ2_DAC:
AIZ2_Loop27:
AIZ2_Jump9:
	sCall		AIZ2_Call4
	sLoop		$01, $03, AIZ2_Loop27
	sCall		AIZ2_Call5
	dc.b dKick, dKick, dSnare, dKick, $06, dSnare, $0C, dSnare
	dc.b $06, dKick, dSnare, dSnare, dSnare, dMidTom, $0C

AIZ2_Loop28:
	sCall		AIZ2_Call4
	sLoop		$01, $03, AIZ2_Loop28
	sCall		AIZ2_Call5
	dc.b dKick, $18, dKick, $15, dSnare, $02, dSnare, $01
	dc.b dSnare, $06, dSnare, $0C, dSnare, dSnare, $06, dSnare
	dc.b $0C

	sCall		AIZ2_DAC_Sec2
	sCall		AIZ2_Call5
	dc.b dKick, dKick, dSnare, dKick, $06, dSnare, $0C, dSnare
	dc.b $06, dKick, dSnare, dSnare, $0C, dKick, $06, dSnare
	sCall		AIZ2_Call5
	dc.b dKick, dKick, dSnare, dKick, $06, dSnare, $0C, dSnare
	dc.b $06, dKick, dSnare, dSnare, dSnare, dMidTom, $0C
	sCall		AIZ2_Call5
	dc.b dKick, dKick, dSnare, dKick, $06, dSnare, $0C, dSnare
	dc.b $06, dKick, dSnare, dSnare, $0C, dKick, $06, dSnare
	sCall		AIZ2_Call5
	dc.b dKick, dKick, dSnare, $06, dSnare, dKick, dSnare, $0C
	dc.b dSnare, $06, dKick, dSnare, dSnare, dSnare, dSnare, dSnare
	sCall		AIZ2_Call5
	dc.b dKick, dKick, dSnare, dKick, $06, dSnare, $0C, dSnare
	dc.b $06, dKick, dSnare, dSnare, $0C, dKick, $06, dSnare
	sCall		AIZ2_Call5
	dc.b dKick, dKick, dSnare, $06, dKick, $0C, dKick, $06
	dc.b dHighTom, dMidTom, $0C, dFloorTom, $06, dSnare, dSnare, dMidTom
	dc.b $0C
	sJump		AIZ2_Jump9

AIZ2_FM1:
AIZ2_Jump8:
	sCall		AIZ2_FM1_Part1
	sCall		AIZ2_FM1_Part1
	sCall		AIZ2_FM1_Part1
	sCall		AIZ2_FM1_Part2
	sCall		AIZ2_FM1_Part3
	sCall		AIZ2_FM1_Part4
	sJump		AIZ2_Jump8

AIZ2_FM2:
AIZ2_Jump7:
	dc.b nRst, $0C
	sPatFM		$12
	saDetune	$03
	ssModZ80	$00, $01, $06, $06
	sPan		spRight, $00
	dc.b nG3, $06, nRst, $0C, nA3, $06, nRst, $0C
	dc.b nBb3, $06, nRst, $36
	sCall		AIZ2_FM2_Intro1

	sPatFM		$12
	ssModZ80	$00, $01, $06, $06
	sPan		spRight, $00
	dc.b nRst, $0C, nBb3, $06, nRst, $0C, nA3, $06
	dc.b nRst, $0C, nG3, $06, nRst, $2A
	sCall		AIZ2_FM2_Intro2

	sPatFM		$12
	ssModZ80	$00, $01, $06, $06
	sPan		spRight, $00
	dc.b nRst, $0C, nG3, $06, nRst, $0C, nA3, $06
	dc.b nRst, $0C, nBb3, $06, nRst, $36
	sCall		AIZ2_FM2_Intro1

	sPatFM		$12
	ssModZ80	$00, $01, $06, $06
	sPan		spRight, $00
	dc.b nRst, $0C, nBb3, $06, nRst, $0C, nA3, $06
	dc.b nRst, $0C, nG3, $06, nRst, $2A
	sCall		AIZ2_FM2_Intro3
	sCall		AIZ2_FM2_Sec1
	sCall		AIZ2_FM2_Sec2

	sPatFM		$06
	saDetune	$03
	ssModZ80	$0F, $01, $06, $06
	sPan		spCenter, $00
	dc.b nA3, $06, nBb3, $06, nC4, $06, nEb4, $06
	dc.b nD4, $06, nBb3, $06, nC4, $06
	sPatFM		$12
	saDetune	$03
	ssModZ80	$00, $01, $06, $06
	sPan		spRight, $00
	dc.b nRst, $0C, nAb3, $0B, nRst, $01, nC4, $0B
	dc.b nRst, $01, nG4, $0B, nRst, $01, nF4, $05
	dc.b nRst, $0D, nEb4, $05, nRst, $0D, nD4, $05
	dc.b nRst, $07

AIZ2_Loop18:
	dc.b nB3, $03, nRst, $01
	sLoop		$00, $09, AIZ2_Loop18
	dc.b nG3, $05, nRst, $07, nB3, $05, nRst, $0D
	dc.b nC4, $05, nRst, $0D, nD4, $05, nRst, $07

AIZ2_Loop19:
	dc.b nEb4, $03, nRst, $01
	sLoop		$00, $0C, AIZ2_Loop19

AIZ2_Loop20:
	dc.b nD4, $03, nRst, $01
	sLoop		$00, $0C, AIZ2_Loop20

AIZ2_Loop21:
	dc.b nC4, $03, nRst, $01
	sLoop		$00, $0C, AIZ2_Loop21

AIZ2_Loop22:
	dc.b nG3, $03, nRst, $01
	sLoop		$00, $0B, AIZ2_Loop22
	dc.b nG3, $03, nRst, $0D, nAb3, $0B, nRst, $01
	dc.b nC4, $0B, nRst, $01, nG4, $0B, nRst, $01
	dc.b nF4, $05, nRst, $0D, nEb4, $05, nRst, $0D
	dc.b nD4, $05, nRst, $07

AIZ2_Loop23:
	dc.b nB3, $03, nRst, $01
	sLoop		$00, $09, AIZ2_Loop23
	dc.b nG3, $05, nRst, $07, nB3, $05, nRst, $0D
	dc.b nC4, $05, nRst, $0D, nD4, $05, nRst, $07

AIZ2_Loop24:
	dc.b nEb4, $03, nRst, $01
	sLoop		$00, $09, AIZ2_Loop24
	dc.b nD4, $05, nRst, $01, nEb4, $05, nRst, $01

AIZ2_Loop25:
	dc.b nF4, $03, nRst, $01
	sLoop		$00, $09, AIZ2_Loop25
	dc.b nEb4, $05, nRst, $01, nF4, $05, nRst, $01

AIZ2_Loop26:
	dc.b nG4, $03, nRst, $01
	sLoop		$00, $15, AIZ2_Loop26
	dc.b nG4, $03, nRst, $2D, nF3, $05, nRst, $01
	dc.b nG3, $05, nRst, $01, nAb3, $05, nRst, $0D
	dc.b nBb3, $05, nRst, $0D, nC4, $05, nRst, $2B
	dc.b nG3, $05, nRst, $01, nAb3, $05, nRst, $01
	dc.b nBb3, $05, nRst, $0D, nC4, $05, nRst, $0D
	dc.b nD4, $05, nRst, $07, nAb2, $05, nRst, $01
	dc.b nC3, $05, nRst, $01, nEb3, $05, nRst, $01
	dc.b nAb3, $05, nRst, $01, nEb3, $05, nRst, $01
	dc.b nAb3, $05, nRst, $01, nC4, $05, nRst, $01
	dc.b nEb4, $05, nRst, $01, nC4, $05, nRst, $01
	dc.b nEb4, $05, nRst, $01, nAb4, $05, nRst, $01
	dc.b nC5, $05, nRst, $01, nAb4, $05, nRst, $01
	dc.b nC5, $05, nRst, $01, nEb5, $05, nRst, $01
	dc.b nAb5, $05, nRst, $01, nRst, $60
	sJump		AIZ2_Jump7

AIZ2_FM3:
AIZ2_Jump6:
	sPatFM		$12
	saDetune	$FE
	ssModZ80	$0F, $01, $06, $06
	sPan		spLeft, $00
	dc.b nRst, $0C, nEb3, $06, nRst, $0C, nF3, $06
	dc.b nRst, $0C, nG3, $06, nRst, $36
	sCall		AIZ2_FM3_Intro1

	sPatFM		$12
	saDetune	$FE
	ssModZ80	$0F, $01, $06, $06
	sPan		spLeft, $00
	dc.b nRst, $0C, nG3, $06, nRst, $0C, nF3, $06
	dc.b nRst, $0C, nEb3, $06, nRst, $2A
	sCall		AIZ2_FM3_Intro2

	sPatFM		$12
	saDetune	$FE
	ssModZ80	$0F, $01, $06, $06
	sPan		spLeft, $00
	dc.b nRst, $0C, nEb3, $06, nRst, $0C, nF3, $06
	dc.b nRst, $0C, nG3, $06, nRst, $36
	sCall		AIZ2_FM3_Intro1

	sPatFM		$12
	saDetune	$FE
	ssModZ80	$0F, $01, $06, $06
	sPan		spLeft, $00
	dc.b nRst, $0C, nG3, $06, nRst, $0C, nF3, $06
	dc.b nRst, $0C, nEb3, $06, nRst, $2A
	sCall		AIZ2_FM3_Intro3
	sCall		AIZ2_FM3_Sec1
	sCall		AIZ2_FM3_Sec2

	sPatFM		$12
	saDetune	$FE
	ssModZ80	$0F, $01, $06, $06
	sPan		spLeft, $00
	dc.b nRst, $0C, nAb3, $0B, nRst, $01, nC4, $0B
	dc.b nRst, $01, nG4, $0B, nRst, $01, nF4, $05
	dc.b nRst, $0D, nEb4, $05, nRst, $0D, nD4, $05
	dc.b nRst, $07

AIZ2_Loop9:
	dc.b nB3, $03, nRst, $01
	sLoop		$00, $09, AIZ2_Loop9
	dc.b nG3, $05, nRst, $07, nB3, $05, nRst, $0D
	dc.b nC4, $05, nRst, $0D, nD4, $05, nRst, $07

AIZ2_Loop10:
	dc.b nEb4, $03, nRst, $01
	sLoop		$00, $0C, AIZ2_Loop10

AIZ2_Loop11:
	dc.b nD4, $03, nRst, $01
	sLoop		$00, $0C, AIZ2_Loop11

AIZ2_Loop12:
	dc.b nC4, $03, nRst, $01
	sLoop		$00, $0C, AIZ2_Loop12

AIZ2_Loop13:
	dc.b nG3, $03, nRst, $01
	sLoop		$00, $0B, AIZ2_Loop13
	dc.b nG3, $03, nRst, $0D, nAb3, $0B, nRst, $01
	dc.b nC4, $0B, nRst, $01, nG4, $0B, nRst, $01
	dc.b nF4, $05, nRst, $0D, nEb4, $05, nRst, $0D
	dc.b nD4, $05, nRst, $07

AIZ2_Loop14:
	dc.b nB3, $03, nRst, $01
	sLoop		$00, $09, AIZ2_Loop14
	dc.b nG3, $05, nRst, $07, nB3, $05, nRst, $0D
	dc.b nC4, $05, nRst, $0D, nD4, $05, nRst, $07

AIZ2_Loop15:
	dc.b nEb4, $03, nRst, $01
	sLoop		$00, $09, AIZ2_Loop15
	dc.b nD4, $05, nRst, $01, nEb4, $05, nRst, $01

AIZ2_Loop16:
	dc.b nF4, $03, nRst, $01
	sLoop		$00, $09, AIZ2_Loop16
	dc.b nEb4, $05, nRst, $01, nF4, $05, nRst, $01

AIZ2_Loop17:
	dc.b nG4, $03, nRst, $01
	sLoop		$00, $15, AIZ2_Loop17
	dc.b nG4, $03, nRst, $2D, nD3, $05, nRst, $01
	dc.b nEb3, $05, nRst, $01, nF3, $05, nRst, $0D
	dc.b nG3, $05, nRst, $0D, nAb3, $05, nRst, $2B
	dc.b nEb3, $05, nRst, $01, nF3, $05, nRst, $01
	dc.b nG3, $05, nRst, $0D, nAb3, $05, nRst, $0D
	dc.b nBb3, $05, nRst, $07
	sPatFM		$10
	saDetune	$FD
	ssModZ80	$0F, $01, $06, $06
	sPan		spCenter, $00
	dc.b nC5, $23, nRst, $01, nC5, $05, nRst, $01
	dc.b nD5, $05, nRst, $01, nEb5, $11, nRst, $01
	dc.b nD5, $11, nRst, $01, nC5, $0B, nRst, $01
	dc.b nG5, $60
	sJump		AIZ2_Jump6

AIZ2_FM4:
AIZ2_Jump5:
	sCall		AIZ2_FM4_Intro
	dc.b nRst, $60
	sCall		AIZ2_FM4_Sec1

	sPatFM		$0F
	saDetune	$01
	ssModZ80	$0F, $01, $06, $06
	sPan		spLeft, $00
	sCall		AIZ2_Call3
	sCall		AIZ2_Call2
	dc.b nA4, $11, nRst, $01, nBb4, $11, nRst, $01
	dc.b nC5, $23, nRst, $19
	sPatFM		$1E
	saDetune	$01
	ssModZ80	$0F, $01, $06, $06
	sPan		spLeft, $00
	dc.b nEb3, $2F, nRst, $01, nC3, $2F, nRst, $01
	dc.b nG3, $0F, nRst, $01, nF3, $0F, nRst, $01
	dc.b nEb3, $0F, nRst, $01, nD3, $0F, nRst, $01
	dc.b nEb3, $0F, nRst, $01, nF3, $0F, nRst, $01
	dc.b nRst, $0C
	sPatFM		$1E
	saDetune	$01
	ssModZ80	$0F, $01, $06, $06
	sPan		spLeft, $00
	dc.b nG3, nBb3, $0B, nRst, $01, nEb4, $0B, nRst
	dc.b $01, nD4, $05, nRst, $0D, nBb3, $05, nRst
	dc.b $0D, nC4, $05, nRst, $07, nG3, $2F, nRst
	dc.b $01
	sPatFM		$06
	saDetune	$01
	ssModZ80	$0F, $01, $06, $06
	sPan		spLeft, $00
	dc.b nBb3, $05, nRst, $0D, nAb3, $05, nRst, $0D
	dc.b nG3, $05, nRst, $07
	sPatFM		$1E
	saDetune	$01
	ssModZ80	$0F, $01, $06, $06
	sPan		spLeft, $00
	dc.b nEb3, $2F, nRst, $01, nC3, $2F, nRst, $01
	dc.b nG3, $0F, nRst, $01, nF3, $0F, nRst, $01
	dc.b nEb3, $0F, nRst, $01, nD3, $0F, nRst, $01
	dc.b nEb3, $0F, nRst, $01, nF3, $0F, nRst, $01
	dc.b nG3, $0C
	sPatFM		$1E
	saDetune	$01
	ssModZ80	$0F, $01, $06, $06
	sPan		spLeft, $00
	dc.b nG3, nBb3, $0B, nRst, $01, nEb4, $0B, nRst
	dc.b $01, nD4, $05, nRst, $0D, nBb3, $05, nRst
	dc.b $0D, nC4, $05, nRst, $07, nG3, $2F, nRst
	dc.b $01
	sPatFM		$06
	saDetune	$01
	ssModZ80	$0F, $01, $06, $06
	sPan		spLeft, $00
	dc.b nBb3, $05, nRst, $0D, nAb3, $05, nRst, $0D
	dc.b nG3, $05, nRst, $07
	sPatFM		$06
	saDetune	$03
	ssModZ80	$0F, $01, $06, $06
	sPan		spCenter, $00
	dc.b nAb3, $1D, nRst, $07, nAb3, $06, nBb3, $06
	dc.b nC4, $11, nRst, $01, nBb3, $11, nRst, $01
	dc.b nAb3, $0B, nRst, $01, nBb3, $1D, nRst, $07
	dc.b nBb3, $06, nC4, $06, nD4, $11, nRst, $01
	dc.b nC4, $11, nRst, $01, nBb3, $0B, nRst, $01
	dc.b nC4, $2F, nRst, $01, nAb3, $2F, nRst, $01
	dc.b nEb4, $17, nRst, $01, nD4, $17, nRst, $01
	dc.b nEb4, $17, nRst, $01, nF4, $17, nRst, $01
	sJump		AIZ2_Jump5

AIZ2_Call3:
	dc.b nRst, $54, nEb4, $05, nRst, $01, nF4, $05
	dc.b nRst, $01
	sRet

AIZ2_Call2:
	dc.b nG4, $05, nRst, $0D, nC4, $05, nRst, $0D
	dc.b nBb4, $11, nRst, $07, nBb4, $05, nRst, $07
	dc.b nBb4, $05, nRst, $07, nG4, $05, nRst, $07
	dc.b nA4, $05, nRst, $0D, nF4, $05, nRst, $0D
	dc.b nC4, $29, nRst, $07, nEb4, $05, nRst, $01
	dc.b nF4, $05, nRst, $01, nG4, $05, nRst, $0D
	dc.b nC4, $05, nRst, $0D, nBb4, $11, nRst, $07
	dc.b nBb4, $05, nRst, $07, nBb4, $05, nRst, $07
	dc.b nC5, $05, nRst, $07, nA4, $2F, nRst, $25
	dc.b nEb4, $05, nRst, $01, nF4, $05, nRst, $01
	dc.b nG4, $05, nRst, $0D, nC4, $05, nRst, $0D
	dc.b nBb4, $0B, nRst, $07, nBb4, $06, nBb4, $06
	dc.b nRst, $06, nBb4, $05, nRst, $07, nG4, $05
	dc.b nRst, $07, nA4, $05, nRst, $0D, nF4, $05
	dc.b nRst, $0D, nC4, $23, nRst, $0D, nEb4, $05
	dc.b nRst, $01, nF4, $05, nRst, $01, nG4, $05
	dc.b nRst, $0D, nC4, $05, nRst, $0D, nBb4, $11
	dc.b nRst, $07, nBb4, $05, nRst, $07, nBb4, $05
	dc.b nRst, $07, nC5, $05, nRst, $07
	sRet

AIZ2_FM5:
AIZ2_Jump4:
	sCall		AIZ2_FM5_Intro
	dc.b nA3, $60, $0C
	sCall		AIZ2_FM5_Sec1

	sPatFM		$0F
	saDetune	$00
	ssModZ80	$0F, $01, $06, $06
	sPan		spRight, $00
	sCall		AIZ2_Call3
	sCall		AIZ2_Call2
	saTranspose	$F4
	sPatFM		$1E
	saDetune	$FD
	ssModZ80	$0F, $01, $06, $06
	sPan		spRight, $00
	dc.b nC5, $0C, nA4, $06, nBb4, $0C, nG4, nC5
	dc.b $42, nAb4, $0C, nC5, nG5, nF5, $12, nEb5
	dc.b nD5, $0C, nB4, $24, nG4, $0C, nB4, $12
	dc.b nC5, nD5, $0C, nEb5, $30, nD5, nC5, nG4
	dc.b $3C, nAb4, $0C, nC5, nG5, nF5, $12, nEb5
	dc.b nD5, $0C, nB4, $24, nG4, $0C, nB4, $12
	dc.b nC5, nD5, $0C, nEb5, $24, nD5, $06, nEb5
	dc.b nF5, $24, nEb5, $06, nF5, nRst, $60, $60
	saTranspose	$0C
	sPatFM		$06
	saDetune	$FD
	ssModZ80	$0F, $01, $06, $06
	sPan		spCenter, $00
	dc.b nD3, $24, nD3, $06, nEb3, nF3, $12, nEb3
	dc.b nD3, $0C, nEb3, $30, nC3, nG3, $18, nF3
	dc.b nG3, nAb3
	sJump		AIZ2_Jump4

AIZ2_PSG1:
AIZ2_Jump3:
	sCall		AIZ2_PSG1_Intro		; data is in AIZ2 Mini Game.asm
	sCall		AIZ2_PSG1_Sec1
	saDetune	$00
	sCall		AIZ2_PSG12_Sec2

	saTranspose	$F4
	dc.b nRst, $60
	sVolEnvPSG	VolEnv_0A
	saDetune	$00
	ssModZ80	$0F, $01, $01, $06
	sNoteTimeOut	$03
	dc.b nEb5, $06, nC5, nAb4, nEb4, nC4, nAb3, nEb3
	dc.b nC3, nC5, nAb4, nEb4, nC4, nAb3, nEb3, nC3
	dc.b nAb2, nD5, nBb4, nF4, nD4, nBb3, nF3, nD3
	dc.b nBb2, nBb4, nF4, nD4, nBb3, nF3, nD3, nBb2
	sNoteTimeOut	$00
	dc.b nF2, $03, nRst, $60, nRst, nRst, $03
	sVolEnvPSG	VolEnv_0A
	saDetune	$00
	ssModZ80	$0F, $01, $01, $06
	sNoteTimeOut	$03
	dc.b nEb5, $06, nC5, nAb4, nEb4, nC4, nAb3, nEb3
	dc.b nC3, nC5, nAb4, nEb4, nC4, nAb3, nEb3, nC3
	dc.b nAb2, nD5, nBb4, nF4, nD4, nBb3, nF3, nD3
	dc.b nBb2, nBb4, nF4, nD4, nBb3, nF3, nD3, nBb2
	sNoteTimeOut	$00
	dc.b nF2, $03, nRst, $60, nRst, nRst, $03
	saVolFM		$FE
	sVolEnvPSG	VolEnv_0A
	saDetune	$00
	ssModZ80	$0F, $01, $01, $06
	dc.b nEb4, $0B, nRst, $07, nEb4, $06, nRst, $48
	dc.b nF4, $0B, nRst, $07, nF4, $06
	saVolFM		$02
	dc.b nRst, $48, nC4, $2F, nRst, $01, nAb3, $2F
	dc.b nRst, $01, nEb4, $17, nRst, $01, nD4, $17
	dc.b nRst, $01, nEb4, $17, nRst, $01, nF4, $17
	dc.b nRst, $01
	sJump		AIZ2_Jump3

AIZ2_PSG2:
AIZ2_Jump2:
	sCall		AIZ2_PSG2_Intro		; data is in AIZ2 Mini Game.asm
	sCall		AIZ2_PSG2_Sec1
	saDetune	$FF
	sCall		AIZ2_PSG12_Sec2

	saTranspose	$F4
	dc.b nRst, $60
	sVolEnvPSG	VolEnv_0A
	saDetune	$FF
	ssModZ80	$0F, $01, $01, $06
	sNoteTimeOut	$03
	dc.b nEb5, $06, nC5, nAb4, nEb4, nC4, nAb3, nEb3
	dc.b nC3, nC5, nAb4, nEb4, nC4, nAb3, nEb3, nC3
	dc.b nAb2, nD5, nBb4, nF4, nD4, nBb3, nF3, nD3
	dc.b nBb2, nBb4, nF4, nD4, nBb3, nF3, nD3, nBb2
	sNoteTimeOut	$00
	dc.b nF2, $03, nRst, $60, nRst, nRst, $03
	sVolEnvPSG	VolEnv_0A
	saDetune	$FF
	ssModZ80	$0F, $01, $01, $06
	sNoteTimeOut	$03
	dc.b nEb5, $06, nC5, nAb4, nEb4, nC4, nAb3, nEb3
	dc.b nC3, nC5, nAb4, nEb4, nC4, nAb3, nEb3, nC3
	dc.b nAb2, nD5, nBb4, nF4, nD4, nBb3, nF3, nD3
	dc.b nBb2, nBb4, nF4, nD4, nBb3, nF3, nD3, nBb2
	sNoteTimeOut	$00
	dc.b nF2, $03, nRst, $60, nRst, nRst, $03
	saVolFM		$FE
	sVolEnvPSG	VolEnv_0A
	saDetune	$FF
	ssModZ80	$0F, $01, $01, $06
	dc.b nC4, $0B, nRst, $07, nC4, $02, nRst, $4C
	dc.b nD4, $0B, nRst, $07, nD4, $02
	saVolFM		$02
	dc.b nRst, $4C, nC4, $2F, nRst, $01, nAb3, $2F
	dc.b nRst, $01, nEb4, $17, nRst, $01, nD4, $17
	dc.b nRst, $01, nEb4, $17, nRst, $01, nF4, $17
	dc.b nRst, $01
	sJump		AIZ2_Jump2

AIZ2_PSG3:
	sVolEnvPSG	VolEnv_02
	sNoisePSG	$E7

AIZ2_Loop1:
AIZ2_Jump1:
	sVolEnvPSG	VolEnv_02
	dc.b nBb6, $06, nBb6
	sVolEnvPSG	VolEnv_05
	dc.b nBb6, $06, nRst, $06
	sLoop		$01, $1C, AIZ2_Loop1
	sVolEnvPSG	VolEnv_02
	dc.b nBb6, $0C
	sVolEnvPSG	VolEnv_01
	dc.b nBb6
	sVolEnvPSG	VolEnv_01
	dc.b nBb6
	sVolEnvPSG	VolEnv_02
	dc.b nBb6, $3C

AIZ2_Loop2:
	dc.b nBb6, $0C, nBb6, $06, nBb6, nBb6, $0C, nBb6
	dc.b $06, nBb6, nBb6, $0C, nBb6, $06, nBb6, nBb6
	dc.b $0C, nBb6, $06, nBb6, nBb6, nBb6, nBb6, $0C
	dc.b nBb6, $06, nBb6, nBb6, $0C, nBb6, nBb6, $06
	dc.b nBb6, nBb6, $0C, nBb6, $06, nBb6
	sLoop		$01, $03, AIZ2_Loop2
	dc.b nBb6, $0C, nBb6, $06, nBb6, nBb6, $0C, nBb6
	dc.b $06, nBb6, nBb6, $0C, nBb6, $06, nBb6, nBb6
	dc.b $0C, nBb6, $06, nBb6, $60, $06
	sCall		AIZ2_PSG3_Sec2

AIZ2_Loop4:
	dc.b nBb6, $06, nBb6, nBb6, $0C, nBb6, $06, nBb6
	dc.b nBb6, $0C, nBb6, $06, nBb6, nBb6, $0C, nBb6
	dc.b $06, nBb6, nBb6, $0C
	sLoop		$01, $0A, AIZ2_Loop4
	dc.b nBb6, $06, nBb6, nBb6, $0C, nBb6, $06, nBb6
	dc.b nBb6, $0C, nBb6, $06, nBb6, nBb6, $0C, nBb6
	dc.b $06, nBb6, nBb6, $60, $0C
	sJump		AIZ2_Jump1
