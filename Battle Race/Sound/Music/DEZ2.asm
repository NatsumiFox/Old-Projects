DEZ2_Header:
	sHeaderInit	; Z80 offset is $C79F
	sHeaderPatch	DEZ1_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $00
	sHeaderDAC	DEZ2_DAC
	sHeaderFM	DEZ2_FM1, $00, $0F
	sHeaderFM	DEZ2_FM2, $00, $0C
	sHeaderFM	DEZ2_FM3, $00, $0F
	sHeaderFM	DEZ2_FM4, $00, $0F
	sHeaderFM	DEZ2_FM5, $00, $16
	sHeaderPSG	DEZ2_PSG1, $E8, $02, $00, VolEnv_00
	sHeaderPSG	DEZ2_PSG2, $E8, $02, $00, VolEnv_00
	sHeaderPSG	DEZ2_PSG3, $E8, $02, $00, VolEnv_00

DEZ2_FM15_1:
	ssModZ80	$0D, $01, $02, $06
	sPan		spCenter, $00
	sPatFM		$05

DEZ12_FM15_1:
	dc.b nRst, $18, nG4, $0B, nRst, $0D, nF4, $0B
	dc.b nRst, $25, nE4, $0C, nF4, nRst, nG4, nRst
	dc.b nF4, $24, nRst, $18, nG4, $0B, nRst, $0D
	dc.b nF4, $0B, nRst, $25, nE4, $0C, nF4, nRst
	dc.b nG4, nRst, nF4, nRst, nF4, $7F, sHold, nF4
	dc.b $29, nE4, $0B, nRst, $0D, nF4, $6C, nA4
	dc.b $06, nBb4, nA4, nRst, nG4, nA4, nG4, nRst
	dc.b nF4, nG4, nF4, nRst, nE4, nF4, nE4, nRst
	sLoop		$00, $02, DEZ12_FM15_1
	sRet

DEZ2_FM15_2:
	dc.b nAb3, $06, nBb3, nC4, nEb4
	sLoop		$00, $04, DEZ2_FM15_2

DEZ2_Loop17:
	dc.b nBb3, $06, nC4, nD4, nF4
	sLoop		$00, $04, DEZ2_Loop17
	sRet

DEZ2_FM15_3:
	dc.b nRst, $60

DEZ2_FM15_3_:
	dc.b nRst, $06, nBb4, $12, nA4, $06
	dc.b nRst, nG4, nRst, nBb4, nRst, nG4, nA4, nRst
	dc.b nBb4, $12
	sRet

DEZ2_FM15_4:
	dc.b nRst, $60

DEZ2_FM15_4_:
	dc.b nRst, $06, nBb4, $12, nA4, $06
	dc.b nRst, nG4, nRst, nBb4, nG4, nRst, nC5, nRst
	dc.b nBb4, nRst, nG4
	sRet

DEZ2_FM1:
DEZ2_Jump5:
	sCall		DEZ2_FM15_1
	sPatFM		$07
	sCall		DEZ2_FM15_2
	sCall		DEZ2_FM15_3
	sCall		DEZ2_FM15_2
	sCall		DEZ2_FM15_4
	sJump		DEZ2_Jump5

DEZ2_FM2_1:
	sPatFM		$01
	sPan		spCenter, $00

DEZ2_Loop13:
	dc.b nG1, $0C, nG1, nG1, nF2, $06, nG2, nG1
	dc.b $0C, nG1, nG1, $06, nD2, nG1, $0C, nG1
	dc.b nG1, nG1, nF2, $06, nG2, nG1, $0C, nG1
	dc.b nC2, $06, nD2, nG1, $0C, nG1, nG1, nG1
	dc.b nF2, $06, nG2, nG1, $0C, nG1, nC2, $06
	dc.b nD2, nG1, $0C, nG1, nG1, nG1, nF2, $06
	dc.b nG2, nG1, $0C, nG1, nC2, $06, nD2, nG1
	dc.b $0C, nBb1, nBb1, nBb1, nBb1, nBb1, nBb1, nBb1
	dc.b nAb1, $06, nBb1, nBb1, $0C, nBb1, nBb1, nBb1
	dc.b nBb1, nBb1, nBb1, nBb1, nBb1, nBb1, nBb1, nBb1
	dc.b nBb1, nBb1, nBb1, nAb1, $06, nBb1, nBb1, $0C
	dc.b nBb1, nBb1, nBb1, nBb1, nBb1, nBb1, nBb1
	sLoop		$00, $02, DEZ2_Loop13
	sRet

DEZ2_FM2:
DEZ2_Jump4:
	ssModZ80	$0D, $01, $02, $06
	sCall		DEZ2_FM2_1

DEZ2_Loop14:
	dc.b nAb1, $0C, nAb1, nAb1, $03, nRst, nAb2, nRst
	dc.b nAb1, nRst, nAb2, nRst, nAb1, $0C, nAb1, nAb1
	dc.b $03, nRst, nAb2, nRst, nAb1, nRst, nAb2, nRst
	dc.b nBb1, $0C, nBb1, nBb1, $03, nRst, nBb2, nRst
	dc.b nBb1, nRst, nBb2, nRst, nBb1, $0C, nBb1, nBb1
	dc.b $03, nRst, nBb2, nRst, nBb1, nRst, nBb2, nRst
	dc.b nC2, $06, nC2, $03, nRst, nBb2, $06, nC3
	dc.b $03, nRst, nF2, $06, nG2, $03, nRst, nC2
	dc.b nRst, nBb1, nRst, nC2, $06, nBb1, nC2, $03
	dc.b nRst, nC2, $06, nRst, nC2, nRst, nC2, nC2
	dc.b $0C, nC2, nRst, $48
	sLoop		$00, $02, DEZ2_Loop14
	sJump		DEZ2_Jump4

DEZ2_FM3:
DEZ2_Jump3:
	sPatFM		$06
	ssModZ80	$0D, $01, $02, $06
	sPan		spRight, $00

DEZ2_Loop11:
	sPan		spRight, $00
	dc.b nG2, $06, nBb2, nG2, nE2, nRst, $30
	sPan		spLeft, $00
	dc.b nBb3, $06, nC4, nE4, nC4, nRst, $18
	sPan		spRight, $00
	dc.b nEb3, $06, nG3, nF3, nBb3, nRst, $30
	sPan		spLeft, $00
	dc.b nG2, $06, nBb2, nG2, nE2, nRst, $30
	sPan		spRight, $00
	dc.b nBb3, $06, nC4, nE4, nC4, nRst, $18
	sPan		spLeft, $00
	dc.b nEb3, $06, nG3, nF3, nBb3, nRst, $30, nRst
	dc.b $18
	sPan		spRight, $00
	dc.b nBb4, $06, nA4, nBb4, nBb4, nBb5, nA5, nBb5
	dc.b nBb5, nBb4, nA4, nBb4, nBb4, nRst, $18
	sPan		spLeft, $00
	dc.b nBb3, $06, nF3, nFs3, nD3, nEb3, nE3, nBb2
	dc.b nB2, nG2, nAb2, nE2, nFs2, nRst, $18
	sPan		spRight, $00
	dc.b nBb4, $06, nA4, nBb4, nBb4, nBb5, nA5, nBb5
	dc.b nBb5, nBb4, nA4, nBb4, nBb4, nRst, $18
	sPan		spLeft, $00
	dc.b nBb3, $06, nF3, nFs3, nD3, nEb3, nE3, nBb2
	dc.b nB2, nG2, nAb2, nE2, nFs2
	sLoop		$00, $02, DEZ2_Loop11

DEZ2_Loop12:
	dc.b nRst, $60
	sLoop		$00, $08, DEZ2_Loop12
	sJump		DEZ2_Jump3

DEZ12_FM4_1:
	dc.b nRst, $18, nE4, $0B, nRst, $0D, nD4, $0B
	dc.b nRst, $25, nC4, $0C, nD4, $0B, nRst, $0D
	dc.b nE4, $0B, nRst, $0D, nD4, $24, nRst, $18
	dc.b nE4, $0B, nRst, $0D, nD4, $0B, nRst, $25
	dc.b nC4, $0C, nD4, $0B, nRst, $0D, nE4, $0B
	dc.b nRst, $0D, nD4, $0B, nRst, $0D, nD4, $7F
	dc.b sHold, nD4, $29, nC4, $0B, nRst, $0D, nD4
	dc.b $6C, nA3, $06, nBb3, nA3, nRst, nG3, nA3
	dc.b nG3, nRst, nF3, nG3, nF3, nRst, nE3, nF3
	dc.b nE3, nRst
	sLoop		$00, $02, DEZ12_FM4_1
	sRet

DEZ2_FM4:
DEZ2_Jump2:
	ssModZ80	$0D, $01, $02, $06
	sPan		spLeft, $00
	sPatFM		$05
	sCall		DEZ12_FM4_1
	sPatFM		$07

DEZ2_Loop7:
	dc.b nAb2, $06, nBb2, nC3, nEb3
	sLoop		$00, $04, DEZ2_Loop7

DEZ2_Loop8:
	dc.b nBb2, $06, nC3, nD3, nF3
	sLoop		$00, $04, DEZ2_Loop8
	dc.b nRst, $60, nRst, $06, nG4, $12, nF4, $06
	dc.b nRst, nE4, nRst, nG4, nRst, nE4, nF4, $05
	dc.b nRst, $07, nG4, $12

DEZ2_Loop9:
	dc.b nAb2, $06, nBb2, nC3, nEb3
	sLoop		$00, $04, DEZ2_Loop9

DEZ2_Loop10:
	dc.b nBb2, $06, nC3, nD3, nF3
	sLoop		$00, $04, DEZ2_Loop10
	dc.b nRst, $60, nRst, $06, nG4, $12, nF4, $06
	dc.b nRst, nE4, nRst, nG4, nE4, nRst, nA4, nRst
	dc.b nG4, nRst, nE4
	sJump		DEZ2_Jump2

DEZ2_FM5:
	dc.b nRst, $10

DEZ2_Jump1:
	sCall		DEZ2_FM15_1
	sPatFM		$07
	sCall		DEZ2_FM15_2
	sCall		DEZ2_FM15_3
	sCall		DEZ2_FM15_2
	sCall		DEZ2_FM15_4
	sJump		DEZ2_Jump1

DEZ2_DAC:
DEZ2_Loop20:
DEZ2_Jump6:
	dc.b dKick, $18, dSnare, dKick, dSnare
	sLoop		$00, $17, DEZ2_Loop20
	dc.b dSnare, $0C, dSnare, nRst, $48
	sJump		DEZ2_Jump6

DEZ2_PSG1:
DEZ2_PSG2:
DEZ2_PSG3:
	sStop
