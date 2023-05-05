ICZ2_Header:
	sHeaderInit	; Z80 offset is $8000
	sHeaderPatch	ICZ1_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $14
	sHeaderDAC	ICZ2_DAC
	sHeaderFM	ICZ2_FM1, $00, $02
	sHeaderFM	ICZ2_FM2, $F4, $08
	sHeaderFM	ICZ2_FM3, $F4, $08
	sHeaderFM	ICZ2_FM4, $F4, $08
	sHeaderFM	ICZ2_FM5, $F4, $08
	sHeaderPSG	ICZ2_PSG1, $E8, $01, $00, VolEnv_06
	sHeaderPSG	ICZ2_PSG2, $E8, $02, $00, VolEnv_06
	sHeaderPSG	ICZ2_PSG3, $00, $01, $00, VolEnv_02

ICZ2_FM1:
	sPatFM		$00

ICZ2_Loop26:
ICZ2_Jump8:
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst
	sLoop		$01, $03, ICZ2_Loop26
	dc.b nC3, $0C, $18, $06, nC3, nBb2, $0C, $18
	dc.b $06, nBb2, nAb2, $0C, $18, $06, nAb2, nG2
	dc.b $0C, $18, $06, nG2, nC3, $0C, $18, $06
	dc.b nC3, nEb3, $0C, $18, $06, nEb3, nBb2, $0C
	dc.b $18, $06, nBb2, nBb2, $0C, $18, $06, nBb2

ICZ2_Loop27:
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst
	sLoop		$01, $02, ICZ2_Loop27

ICZ2_Loop28:
	dc.b nC3, $0C, $18, $06, nC3, nBb2, $0C, $18
	dc.b $06, nBb2, nAb2, $0C, $18, $06, nAb2, nG2
	dc.b $0C, $18, $06, nG2, nC3, $0C, $18, $06
	dc.b nC3, nEb3, $0C, $18, $06, nEb3, nBb2, $0C
	dc.b $18, $06, nBb2, nBb2, $0C, $18, $06, nBb2
	sLoop		$01, $02, ICZ2_Loop28

ICZ2_Loop29:
	dc.b nC3, $0C, $06, nC3, nC3, $0C, $06, nC3
	dc.b nAb2, $0C, $06, nAb2, nAb2, $0C, $06, nAb2
	dc.b nBb2, $0C, $06, nBb2, nBb2, nBb2, nBb2, nBb2
	dc.b nG2, $0C, $06, nG2, nG2, $0C, $06, nG2
	dc.b nC3, $0C, $06, nC3, nC3, $0C, $06, nC3
	dc.b nAb2, $0C, $06, nAb2, nAb2, $0C, $06, nAb2
	dc.b nBb2, $0C, $06, nBb2, nBb2, $0C, $06, nBb2
	dc.b nBb2, $0C, $06, nBb2, nBb2, $0C, $06, nBb2
	sLoop		$01, $04, ICZ2_Loop29

ICZ2_Loop30:
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst
	sLoop		$01, $02, ICZ2_Loop30
	sJump		ICZ2_Jump8

ICZ2_FM2:
ICZ2_Jump7:
	sPatFM		$01
	saTranspose	$0C
	ssModZ80	$01, $01, $03, $03

ICZ2_Loop23:
	dc.b nG4, $30, sHold, $30, sHold, nG4, nF4, nG4
	dc.b sHold, $30, nF4, sHold, $30
	sLoop		$01, $04, ICZ2_Loop23
	saTranspose	$F4
	sPatFM		$02
	dc.b nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5
	dc.b nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, sHold, $30, nRst, $30, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst
	sPatFM		$01
	saTranspose	$0C
	ssModZ80	$01, $01, $03, $03
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nG4, sHold, $30, sHold, nG4, nF4, nG4, sHold
	dc.b $30, nF4, sHold, $30
	saTranspose	$F4
	sPatFM		$02

ICZ2_Loop24:
	dc.b nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5
	dc.b nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, sHold, $30
	sLoop		$01, $04, ICZ2_Loop24

ICZ2_Loop25:
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst
	sLoop		$01, $02, ICZ2_Loop25
	sJump		ICZ2_Jump7

ICZ2_FM3:
ICZ2_Loop19:
ICZ2_Jump6:
	sCall		ICZ2_Call2
	dc.b nAb3, $30, nG3, nRst, nRst, nRst, nRst
	sLoop		$01, $04, ICZ2_Loop19

ICZ2_Loop20:
	sCall		ICZ2_Call2
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst
	sLoop		$01, $02, ICZ2_Loop20
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst
	sCall		ICZ2_Call2
	dc.b nRst, $30, nRst, nAb3, $30, nG3, nRst, nRst
	dc.b nRst, nRst

ICZ2_Loop21:
	sCall		ICZ2_Call2
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst
	sLoop		$01, $04, ICZ2_Loop21

ICZ2_Loop22:
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst
	sLoop		$00, $02, ICZ2_Loop22
	sJump		ICZ2_Jump6

ICZ2_Call2:
	sPatFM		$04
	ssModZ80	$01, $01, $A1, $FF
	sPan		spLeft, $00
	dc.b nG6, $09, nRst, $27, nRst, $06
	sPatFM		$05
	saVolFM		$2C
	sPan		spRight, $00

ICZ2_Loop18:
	dc.b nBb2, $01
	saVolFM		$FD
	sLoop		$00, $12, ICZ2_Loop18
	saVolFM		$0A
	dc.b nRst, $18
	sPatFM		$01
	ssModZ80	$01, $01, $03, $03
	sPan		spCenter, $00
	sRet

ICZ2_FM4:
ICZ2_Jump5:
	sPatFM		$01
	saTranspose	$0C
	ssModZ80	$01, $01, $03, $03

ICZ2_Loop14:
	dc.b nC4, $30, nBb3, nC4, nBb3, nC4, nBb3, sHold
	dc.b nBb3, sHold, $30
	sLoop		$01, $04, ICZ2_Loop14
	saTranspose	$F4
	sPatFM		$03
	sPan		spRight, $00

ICZ2_Loop15:
	dc.b nBb4, $06, nC4, nG4, nC5, nG4, nC4, nG4
	dc.b nC5, nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4
	dc.b nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b nD5, nBb4, nD4, nBb4, nG4, nBb4, nD4, nBb4
	dc.b nG4
	sLoop		$01, $03, ICZ2_Loop15
	dc.b nBb4, $06, nC4, nG4, nC5, nG4, nC4, nG4
	dc.b nC5, nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4
	dc.b nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b nD5, nBb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b nD5
	sPan		spCenter, $00
	sPatFM		$01
	saTranspose	$0C
	ssModZ80	$01, $01, $03, $03
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nC4, nBb3, nC4, nBb3, nC4, nBb3, sHold
	dc.b nBb3, sHold, $30
	saTranspose	$F4
	sPatFM		$03

ICZ2_Loop17:
	sPan		spRight, $00

ICZ2_Loop16:
	dc.b nBb4, $06, nC4, nG4, nC5, nG4, nC4, nG4
	dc.b nC5, nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4
	dc.b nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b nD5, nBb4, nD4, nBb4, nG4, nBb4, nD4, nBb4
	dc.b nG4
	sLoop		$02, $03, ICZ2_Loop16
	dc.b nBb4, $06, nC4, nG4, nC5, nG4, nC4, nG4
	dc.b nC5, nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4
	dc.b nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b nD5, nBb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b nD5
	sPan		spCenter, $00
	sLoop		$01, $03, ICZ2_Loop17
	sJump		ICZ2_Jump5

ICZ2_FM5:
ICZ2_Jump4:
	sPatFM		$01
	saTranspose	$0C
	ssModZ80	$01, $01, $03, $03

ICZ2_Loop11:
	dc.b nEb4, $30, sHold, $30, sHold, nEb4, nD4, nEb4
	dc.b sHold, $30, nD4, sHold, $30
	sLoop		$01, $04, ICZ2_Loop11
	saTranspose	$F4
	sPatFM		$03

ICZ2_Loop12:
	sCall		ICZ2_Call1
	sLoop		$01, $02, ICZ2_Loop12
	sPatFM		$01
	saTranspose	$0C
	ssModZ80	$01, $01, $03, $03
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nEb4, sHold, $30, sHold, nEb4, nD4, nEb4
	dc.b sHold, $30, nD4, sHold, $30
	saTranspose	$F4
	sPatFM		$03

ICZ2_Loop13:
	sCall		ICZ2_Call1
	sLoop		$01, $06, ICZ2_Loop13
	sJump		ICZ2_Jump4

ICZ2_Call1:
	dc.b nC4, $06, nG4, nC5, nG4, nC4, nG4, nC5
	dc.b nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4, nC5
	dc.b nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b nBb4, nD4, nBb4, nG4, nBb4, nD4, nBb4, nG4
	dc.b nBb4, nC4, nG4, nC5, nG4, nC4, nG4, nC5
	dc.b nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4, nC5
	dc.b nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b nBb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b nBb4
	sRet

ICZ2_PSG1:
ICZ2_Jump3:
	sVolEnvPSG	VolEnv_02
	saTranspose	$18
	sNoteTimeOut	$09

ICZ2_Loop7:
	dc.b nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4
	dc.b $2A
	sLoop		$01, $10, ICZ2_Loop7
	saTranspose	$E8
	sNoteTimeOut	$00
	sVolEnvPSG	VolEnv_16
	dc.b nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5
	dc.b nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, sHold, $30
	sVolEnvPSG	VolEnv_02
	saTranspose	$18
	sNoteTimeOut	$09

ICZ2_Loop8:
	dc.b nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4
	dc.b $2A
	sLoop		$01, $0B, ICZ2_Loop8
	dc.b nRst, $30, nRst
	saTranspose	$E8
	sNoteTimeOut	$00
	sVolEnvPSG	VolEnv_16

ICZ2_Loop9:
	dc.b nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5
	dc.b nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, sHold, $30
	sLoop		$01, $04, ICZ2_Loop9
	sVolEnvPSG	VolEnv_02
	saTranspose	$18
	sNoteTimeOut	$09

ICZ2_Loop10:
	dc.b nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4
	dc.b $2A
	sLoop		$01, $04, ICZ2_Loop10
	saTranspose	$E8
	sNoteTimeOut	$00
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst
	sJump		ICZ2_Jump3

ICZ2_PSG2:
ICZ2_Jump2:
	sVolEnvPSG	VolEnv_01
	saTranspose	$18
	sNoteTimeOut	$09
	ssModZ80	$01, $01, $01, $02

ICZ2_Loop3:
	dc.b nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4
	dc.b $2A
	sLoop		$01, $10, ICZ2_Loop3
	saTranspose	$E8
	sNoteTimeOut	$00
	sVolEnvPSG	VolEnv_16
	saVolPSG	$02
	ssModZ80	$01, $01, $01, $03
	dc.b nRst, $18, nC5, $18, nC6, nBb5, $30, nD5
	dc.b $12, nEb5, nF5, $0C, nBb4, $30, nC5, $18
	dc.b nC6, nBb5, $30, nD5, sHold, $18
	saVolPSG	$FE
	sVolEnvPSG	VolEnv_01
	saTranspose	$18
	sNoteTimeOut	$09
	ssModZ80	$01, $01, $01, $02

ICZ2_Loop4:
	dc.b nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4
	dc.b $2A
	sLoop		$01, $0B, ICZ2_Loop4
	dc.b nRst, $30, nRst
	saTranspose	$E8
	sNoteTimeOut	$00
	sVolEnvPSG	VolEnv_16
	saVolPSG	$02
	ssModZ80	$01, $01, $01, $03
	dc.b nRst, $18

ICZ2_Loop5:
	dc.b nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5
	dc.b nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, sHold, $30
	sLoop		$01, $03, ICZ2_Loop5
	dc.b nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5
	dc.b nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, sHold, $18
	saVolPSG	$FE
	sVolEnvPSG	VolEnv_02
	saTranspose	$18
	sNoteTimeOut	$09
	ssModZ80	$01, $01, $01, $02

ICZ2_Loop6:
	dc.b nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4
	dc.b $2A
	sLoop		$01, $04, ICZ2_Loop6
	saTranspose	$E8
	sNoteTimeOut	$00
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst
	sJump		ICZ2_Jump2

ICZ2_PSG3:
ICZ2_Jump1:
	sNoisePSG	$E7
	sVolEnvPSG	VolEnv_02

ICZ2_Loop1:
	dc.b nRst, $0C, nB6, $18, nB6, nB6, nB6, $0C
	sLoop		$01, $1F, ICZ2_Loop1
	dc.b nRst, $0C, nB6, $18, nB6, nRst, $24

ICZ2_Loop2:
	dc.b nRst, $0C, nB6, $18, nB6, nB6, nB6, $0C
	sLoop		$01, $14, ICZ2_Loop2
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst
	sJump		ICZ2_Jump1

ICZ2_DAC:
ICZ2_Jump9:
	dc.b nRst, $30, nRst, $0C, dReverseFadingWind, $24, nRst, $30
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, $30, nRst
	dc.b $0C, dReverseFadingWind, $24, nRst, $30, nRst, nRst, nRst
	dc.b nRst, dQuickHit, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $0C
	dc.b dQuickHit, $06, dQuickHit
ICZ2_Loop31:
	dc.b dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $0C, dQuickHit, $06
	dc.b dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit
	dc.b dQuickHit, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, $18
	dc.b dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dQuickHit, $06
	dc.b dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick
	dc.b dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $0C, dQuickHit
	dc.b $06, dQuickHit
	sLoop		$01, $02, ICZ2_Loop31
	dc.b dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C
	dc.b dReverseFadingWind, dLooseSnareNoise, $18, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $0C
	dc.b dQuickHit, $06, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, $06, nRst
	dc.b $12, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, dQuickHit
	dc.b dQuickHit, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit
	dc.b dQuickHit, dQuickHit, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick
	dc.b $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dReverseFadingWind
	dc.b dLooseSnareNoise, $18, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $0C, dQuickHit
	dc.b $06, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12
	dc.b dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit
	dc.b dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $0C, dQuickHit
	dc.b $06, dQuickHit

ICZ2_Loop32:
	dc.b dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit
	dc.b dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick
	dc.b $06, nRst, $12, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit
	dc.b dDanceStyleKick, dQuickHit, dQuickHit, dQuickHit
	sLoop		$01, $03, ICZ2_Loop32
	dc.b dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit
	dc.b dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick
	dc.b dDanceStyleKick, $0C, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $18, dDanceStyleKick
	dc.b $06, nRst, $12, dDanceStyleKick, $0C, dReverseFadingWind, dLooseSnareNoise, $18
	dc.b dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit
	dc.b dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C
	dc.b dQuickHit, $06, dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick
	dc.b $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick
	dc.b $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, $06
	dc.b nRst, $12, dDanceStyleKick, $0C, dReverseFadingWind, dLooseSnareNoise, $18, dDanceStyleKick
	dc.b dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick
	dc.b $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dQuickHit
	dc.b $06, dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $18
	dc.b dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, nRst
	dc.b $30, nRst, $0C, dReverseFadingWind, dLooseSnareNoise, $18, nRst, $30
	dc.b nRst, nRst, nRst, nRst, dDanceStyleKick, $06, dQuickHit, dQuickHit
	dc.b dQuickHit, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, $18
	dc.b dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dReverseFadingWind, dLooseSnareNoise
	dc.b $18, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $0C, dQuickHit, $06
	dc.b dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick
	dc.b $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit, dQuickHit
	dc.b dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $0C, dQuickHit, $06
	dc.b dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick
	dc.b $0C, dReverseFadingWind, dLooseSnareNoise, $18, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick
	dc.b $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, $06
	dc.b nRst, $12, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick
	dc.b dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06
	dc.b dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst
	sJump		ICZ2_Jump9
