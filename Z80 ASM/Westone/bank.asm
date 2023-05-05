		dw	.00
		dw	.01
		dw	.02
		dw	.03
		dw	.04
		dw	.05
		dw	.06
		dw	.07
		dw	.08
		dw	.09
		dw	.0A
		dw	.0B
		dw	.0C
		dw	.0D
		dw	.0E
		dw	.0F
		dw	.10
		dw	.11
		dw	.12
		dw	.13
		dw	.14
		dw	.15
		dw	.16
		dw	.17
		dw	.18
		dw	.19
		dw	.1A
		dw	.1B
		dw	.1C
		dw	.1D
		dw	.1E
		dw	.1F
		dw	.20
		dw	.21
		dw	.22
		dw	.23
		dw	.24
		dw	.25
		dw	.26
		dw	.27
		dw	.28
		dw	.29
		dw	.2A
		dw	.2B
		dw	.2C
		dw	.2D
		dw	.2E
		dw	.2F
		dw	.30
		dw	.31
		dw	.32
		dw	.33
		dw	.34
		dw	.35
		dw	.36
		dw	.37
		dw	.38
		dw	.39
		dw	.3A
		dw	.3B
		dw	.3C
		dw	.3D
		dw	.3E
		dw	.3F
		dw	.40
		dw	.41
		dw	.42
		dw	.43
		dw	.44
		dw	.45
		dw	.46
		dw	.47
		dw	.48
		dw	.49
		dw	.4A
		dw	.4B
		dw	.4C
		dw	.4D
		dw	.4E
		dw	.4F
		dw	.50
		dw	.51
		dw	.52
		dw	.53
		dw	.54
		dw	.55
		dw	.56
		dw	.57

.18
		wHeaderSFX	$50
		wChSFX	$08, .18_00
		wChSFX	$09, .18_01
		dc.b	$FF

.18_00
		wSetType	$02
		wSetMask	$01

.18_01_00
		wTempoDiv	$10
		wSetVol		$10
		wSetPat		$01
		dc.b $C8, $3C
		wLoopGoEnd

.18_01
		wAddFreq	$0020
		wSetType	$02
		wSetMask	$02
		wSetTimerB	$02
		wStopRead
		wJump		.18_01_00

.19
		wHeaderSFX	$50
		wChSFX	$08, .19_00
		wChSFX	$09, .19_01
		dc.b	$FF

.19_00
		wSetType	$02
		wSetMask	$01

.19_01_00
		wTempoDiv	$10
		wSetVol		$10
		wSetPat		$01
		dc.b $C8, $3E
		wLoopGoEnd

.19_01
		wAddFreq	$0020
		wSetType	$02
		wSetMask	$02
		wSetTimerB	$02
		wStopRead
		wJump		.19_01_00

.1A
		wHeaderSFX	$50
		wChSFX	$08, .1A_00
		wChSFX	$09, .1A_01
		dc.b	$FF

.1A_00
		wSetType	$02
		wSetMask	$01

.1A_01_00
		wTempoDiv	$10
		wSetVol		$10
		wSetPat		$01
		dc.b $C8, $43
		wLoopGoEnd

.1A_01
		wAddFreq	$0020
		wSetType	$02
		wSetMask	$02
		wSetTimerB	$02
		wStopRead
		wJump		.1A_01_00

.1B
		wHeaderSFX	$50
		wChSFX	$08, .1B_00
		wChSFX	$09, .1B_01
		dc.b	$FF

.1B_00
		wSetType	$02
		wSetMask	$01

.1B_01_00
		wTempoDiv	$10
		wSetVol		$10
		wSetPat		$01
		dc.b $C8, $3E, $3C, $3E, $3C, $3E, $43, $3E
		wLoopGoEnd

.1B_01
		wAddFreq	$0020
		wSetType	$02
		wSetMask	$02
		wSetTimerB	$02
		wStopRead
		wJump		.1B_01_00

.1C
		wHeaderSFX	$50
		wChSFX	$08, .1C_00
		wChSFX	$09, .1C_01
		dc.b	$FF

.1C_00
		wSetType	$02
		wSetMask	$01

.1C_01_00
		wTempoDiv	$10
		wSetVol		$10
		wSetPat		$01
		dc.b $C8, $3C, $3E, $43, $3E, $43, $3C, $3E
		wLoopGoEnd

.1C_01
		wAddFreq	$0020
		wSetType	$02
		wSetMask	$02
		wSetTimerB	$02
		wStopRead
		wJump		.1C_01_00

.1D
		wHeaderSFX	$50
		wChSFX	$08, .1D_00
		wChSFX	$09, .1D_01
		dc.b	$FF

.1D_00
		wSetType	$02
		wSetMask	$01

.1D_01_00
		wTempoDiv	$10
		wSetVol		$10
		wSetPat		$01
		dc.b $C8, $3C, $43, $43, $3C, $3E, $3C, $3E
		wLoopGoEnd

.1D_01
		wAddFreq	$0020
		wSetType	$02
		wSetMask	$02
		wSetTimerB	$02
		wStopRead
		wJump		.1D_01_00

.1E
		wHeaderSFX	$10
		wChSFX	$09, .1E_00
		dc.b	$FF

.1E_00
		wSetPat		$06
		wTempoDiv	$0F
		wSetFreq	$0C00
		wSetVol		$00
		wSetType	$02
		wSetMask	$02
		wSetTimerB	$03
		dc.b $0C, $0E, $0D, $0C, $0E, $0D
		wSetTimerB	$06
		wFC
		dc.b $0C
		wFC
		dc.b $10
		wFC
		dc.b $13
		wFC
		dc.b $17, $1A
		wLoopGoEnd

.1F
		wHeaderSFX	$14
		wChSFX	$08, .1F_00
		dc.b	$FF

.1F_00
		wSetPat		$00
		wTempoDiv	$0F
		wSetFreq	$1C00
		wSetVol		$0A
		wSetType	$02
		wSetMask	$01
		wSetTimerB	$06
		dc.b $26
		wSetTimerB	$03
		dc.b $18
		wLoopBackInit	$04
		wSetTimerB	$03
		dc.b $18
		wFC
		dc.b $14, $24, $20
		wAddFreq	$0140
		wAddVol		$04
		wLoopBack
		wLoopGoEnd

.20
		wHeaderSFX	$10
		wChSFX	$09, .20_00
		dc.b	$FF

.20_00
		wSetPat		$0C
		wTempoDiv	$0F
		wSetFreq	$1F00
		wSetVol		$06
		wSetType	$02
		wSetMask	$02
		wLoopBackInit	$05
		wSetTimerB	$03
		wFC
		dc.b $00
		wFC
		dc.b $0C
		wFC
		dc.b $02
		wAddFreq	$0232
		wAddVol		$20
		wLoopBack
		wLoopGoEnd

.21
		wHeaderSFX	$14
		wChSFX	$07, .21_00
		dc.b	$FF

.21_00
		wSetType	$02
		wSetMask	$04
		wSetPat		$07
		wTempoDiv	$0F
		wSetFreq	$2580
		wSetVol		$00
		wSetTimerB	$0C
		wLoopBackInit	$03
		dc.b $10, $1C
		wAddFreq	$0000
		wAddVol		$0C
		wLoopBack
		wLoopGoEnd

.22
		wHeaderSFX	$20
		wChSFX	$07, .22_00
		dc.b	$FF

.22_00
		wSetType	$02
		wSetMask	$04
		wSetPat		$07
		wTempoDiv	$0F
		wSetFreq	$0980
		wSetVol		$00
		wSetTimerB	$05
		wLoopBackInit	$01
		dc.b $15, $0B
		wAddFreq	$FC00
		wAddVol		$08
		wLoopBack
		wSetFreq	$0980
		wSetVol		$00
		wLoopBackInit	$03
		dc.b $15, $15
		wAddFreq	$FC00
		wAddVol		$04
		wLoopBack
		wLoopGoEnd

.23
		wHeaderSFX	$20
		wChSFX	$07, .23_00
		dc.b	$FF

.23_00
		wSetType	$02
		wSetMask	$04
		wSetPat		$07
		wTempoDiv	$0F
		wSetFreq	$0980
		wSetVol		$00
		wSetTimerB	$05
		wLoopBackInit	$01
		dc.b $15, $0B
		wAddFreq	$FC00
		wAddVol		$08
		wLoopBack
		wSetFreq	$0800
		wSetVol		$00
		wSetPat		$01
		wSetTimerB	$03
		wLoopBackInit	$01
		wLoopBackInit	$07
		wFC
		dc.b $10
		wAddFreq	$0180
		wLoopBack
		wLoopBack
		wLoopGoEnd

.24
		wHeaderSFX	$20
		wChSFX	$09, .24_00
		dc.b	$FF

.24_00
		wSetType	$02
		wSetMask	$02
		wSetPat		$08
		wSetFreq	$4180
		wSetVol		$00
		wSetTimerB	$08
		wLoopBackInit	$04
		dc.b $10, $12
		wAddFreq	$EFFF
		wAddVol		$02
		wLoopBack
		wLoopGoEnd

.25
		wHeaderSFX	$70
		wChSFX	$06, .25_00
		dc.b	$FF

.26
		wHeaderSFX	$70
		wChSFX	$06, .26_00
		dc.b	$FF

.26_00
		wAddFreq	$3700
		wJump		.26_00_00

.25_00
		wAddFreq	$3000

.26_00_00
		wSetType	$00
		wSetMask	$10
		wSetPat		$0B
		wTempoDiv	$0F
		wSetVol		$00
		wSetTimerB	$0C
		wLoopBackInit	$03
		dc.b $10
		wAddVol		$18
		wLoopBack
		wSetTimerB	$10
		wLoopGoEnd

.27
		wHeaderSFX	$18
		wChSFX	$07, .27_00
		dc.b	$FF

.27_00
		wSetType	$02
		wSetMask	$06
		wSetPat		$09
		wTempoDiv	$0F
		wSetFreq	$3300
		wSetVol		$04
		wSetTimerB	$07
		wLoopBackInit	$06
		wFC
		dc.b $7F, $1C, $7C, $10
		wAddFreq	$FF00
		wLoopBack
		wLoopBackInit	$02
		wFC
		dc.b $7F, $1C, $7C, $10
		wAddFreq	$FF00
		wAddVol		$04
		wLoopBack
		wLoopGoEnd

.28
		wHeaderSFX	$18
		wChSFX	$07, .28_00
		dc.b	$FF

.28_00
		wSetType	$02
		wSetMask	$06
		wSetPat		$09
		wTempoDiv	$0F
		wSetFreq	$0C00
		wSetVol		$10
		wSetTimerB	$03
		dc.b $8F, $23
		wStopHw
		wStopRead
		dc.b $84, $18
		wSetTimerB	$03
		dc.b $78, $0C
		wLoopGoEnd

.29
		wHeaderSFX	$18
		wChSFX	$07, .29_00
		dc.b	$FF

.29_00
		wSetType	$02
		wSetMask	$06
		wSetPat		$00
		wTempoDiv	$0E
		wSetFreq	$1800
		wSetVol		$08
		wLoopBackInit	$02
		dc.b $C2, $84
		wAddFreq	$0020
		dc.b $24
		wAddFreq	$FFE0
		dc.b $7F
		wAddFreq	$0020
		dc.b $1F
		wAddFreq	$FFE0
		dc.b $73
		wAddFreq	$0020
		dc.b $13
		wAddFreq	$FFE0
		wStopHw
		wAddVol		$08
		wLoopBack
		wLoopGoEnd

.2A
		wHeaderSFX	$18
		wChSFX	$08, .2A_00
		dc.b	$FF

.2A_00
		wSetMask	$10
		wSetVol		$08
		wTempoDiv	$0E
		wSetFreq	$1000
		wSetPat		$13
		dc.b $C0, $10, $20
		wStopRead
		wStopRead
		wStopRead
		dc.b $17, $27
		wLoopBackInit	$03
		dc.b $C0, $07, $17, $C2
		wStopRead
		wAddVol		$18
		wLoopBack
		wLoopGoEnd

.2B
		wHeaderSFX	$20
		wChSFX	$06, .2B_00
		dc.b	$FF

.2B_00
		wSetType	$02
		wSetMask	$01
		wSetPat		$0A
		wTempoDiv	$0E
		dc.b $C0
		wSetFreq	$1800
		wSetVol		$0C
		wLoopBackInit	$02
		wFC
		dc.b $10
		wAddFreq	$0280
		wLoopBack
		wLoopBackInit	$04
		wFC
		dc.b $10
		wAddFreq	$FE80
		wLoopBack
		wLoopGoEnd

.2C
		wHeaderSFX	$50
		wChSFX	$06, .2C_00
		dc.b	$FF

.2C_00
		wSetMask	$10
		wSetVol		$00
		wTempoDiv	$0E
		wSetFreq	$1800
		wSetPat		$13
		dc.b $C0, $10, $12
		wStopRead
		wSetTimerB	$04
		dc.b $10
		wLoopBackInit	$03
		dc.b $C1, $17, $C2, $14
		wAddVol		$20
		dc.b $C1, $14
		wAddVol		$E4
		wAddFreq	$0400
		wLoopBack
		wLoopGoEnd

.2D
		wHeaderSFX	$52
		wChSFX	$07, .2D_00
		dc.b	$FF

.2D_00
		wSetType	$00
		wSetMask	$06
		wSetPat		$21
		wSetVol		$00
		wSetFreq	$F400
		dc.b $C5
		wTempoDiv	$10
		dc.b $A3, $48, $C4, $54, $53, $51, $C5, $AD
		dc.b $51, $AF, $53, $C3, $B1, $54, $AA, $4D
		dc.b $B3, $56, $AC, $4F, $B4, $58, $AD, $51
		dc.b $C5, $B4, $5B, $C4
		wStopRead
		wLoopGoEnd

.2E
		wHeaderSFX	$20
		wChSFX	$09, .2E_00
		dc.b	$FF

.2E_00
		wSetType	$02
		wSetMask	$02
		wSetVol		$00
		wSetFreq	$1500
		wTempoDiv	$10
		wSetPat		$0B
		wSetTimerB	$0D
		wLoopBackInit	$02
		dc.b $05, $0A
		wStopRead
		wAddFreq	$FCFF
		wAddVol		$04
		wLoopBack
		wLoopGoEnd

.2F
		wHeaderSFX	$22
		wChSFX	$08, .2F_00
		dc.b	$FF

.2F_00
.3F_00
		wSetType	$00
		wSetMask	$10
		wSetPat		$2C
		wTempoDiv	$0F
		wSetVol		$00
		wSetTimerB	$0C
		wLoopBackInit	$03
		dc.b $3A
		wAddVol		$0F
		wAddFreq	$F800
		wLoopBack
		wLoopGoEnd

.30
		wHeaderSFX	$10
		wChSFX	$09, .30_00
		dc.b	$FF

.30_00
		wSetMask	$02

.55_00_00
.55_00_05
.55_00_08
.55_00_0B
		wSetFreq	$4000

.46_00_00
.55_00_07
.55_00_02
.55_00_04
.55_00_0A
		wSetPat		$2D
		wSetVol		$00
		wSetTimerB	$08
		dc.b $30
		wLoopBackInit	$05
		wSetTimerB	$0A
		dc.b $30
		wAddVol		$12
		wLoopBack
		wLoopGoEnd

.31
		wHeaderSFX	$10
		wChSFX	$09, .31_00
		dc.b	$FF

.31_00
		wSetType	$02
		wSetMask	$02
		wSetPat		$0A
		wTempoDiv	$0F
		wSetFreq	$1400
		wSetVol		$00
		wLoopBackInit	$07
		wSetTimerB	$05
		dc.b $10
		wAddFreq	$FFE0
		wAddVol		$03
		wLoopBack
		wLoopGoEnd

.32
		wHeaderSFX	$40
		wChSFX	$06, .32_00
		dc.b	$FF

.32_00
		wSetMask	$20
		wSetPat		$17
		wTempoDiv	$0F
		wSetFreq	$1800
		wSetVol		$00
		wLoopBackInit	$07
		wLoopBackInit	$05
		wSetTimerB	$07
		dc.b $10
		wAddFreq	$FFE0
		wAddVol		$03
		wLoopBack
		wSetVol		$00
		wAddFreq	$0078
		wLoopBack
		wLoopGoEnd

.33
		wHeaderSFX	$18
		wChSFX	$08, .33_00
		dc.b	$FF

.33_00
		wSetType	$00
		wSetMask	$10
		wTempoDiv	$0F
		wSetFreq	$1C00
		wSetVol		$00
		wSetPat		$09
		wSetTimerB	$04
		wLoopBackInit	$07
		wFC
		dc.b $10
		wAddFreq	$02A0
		wLoopBack
		wSetTimerB	$03
		wLoopBackInit	$03
		wLoopBackInit	$04
		dc.b $10
		wFC
		wAddFreq	$0180
		wLoopBack
		wLoopBackInit	$04
		wFC
		dc.b $10
		wAddFreq	$FE80
		wLoopBack
		wAddVol		$14
		wLoopBack
		wLoopGoEnd

.34
		wHeaderSFX	$70
		wChSFX	$08, .34_00
		dc.b	$FF

.34_00
		wSetMask	$10
		wTempoDiv	$10
		wSetFreq	$0C00
		wSetPat		$13
		dc.b $C3, $20, $1B, $20, $1B, $20, $C6, $1B
		wLoopGoEnd

.35
		wHeaderSFX	$70
		wChSFX	$08, .35_00
		dc.b	$FF

.35_00
		wSetMask	$10
		wTempoDiv	$10
		wSetFreq	$2800
		wSetVol		$24
		wSetPat		$10
		wSetTimerB	$03
		wLoopBackInit	$07
		dc.b $10, $12
		wLoopBack
		wLoopGoEnd

.36
		wHeaderSFX	$30
		wChSFX	$06, .36_00
		dc.b	$FF

.36_00
		wSetType	$02
		wSetMask	$02
		wTempoDiv	$10
		wSetFreq	$0F00
		wSetPat		$07
		wSetTimerB	$03
		wLoopBackInit	$07
		dc.b $14, $45
		wAddVol		$04
		wLoopBack
		wLoopGoEnd

.37
		wHeaderSFX	$28
		wChSFX	$08, .37_00
		dc.b	$FF

.37_00
		wSetMask	$10
		wSetPat		$2C
		wTempoDiv	$0F
		dc.b $C1
		wSetFreq	$2C00
		wSetVol		$06
		wLoopBackInit	$04
		wFC
		dc.b $10
		wAddFreq	$FD00
		wLoopBack
		wLoopBackInit	$07
		wFC
		dc.b $10
		wAddFreq	$FD80
		wLoopBack
		wLoopGoEnd

.38
		wHeaderSFX	$28
		wChSFX	$08, .38_00
		dc.b	$FF

.38_00
		wSetMask	$30
		wSetPat		$2E
		wTempoDiv	$0F
		wSetVol		$06
		wSetTimerW	$0180
		dc.b $74
		wAddFreq	$0028
		dc.b $14
		wLoopGoEnd

.39
		wHeaderSFX	$14
		wChSFX	$08, .39_00
		dc.b	$FF

.39_00
		wSetMask	$10
		wSetVol		$04
		wSetFreq	$0C00
		wSetPat		$2F
		dc.b $C1, $18
		wStopRead
		dc.b $C2, $18
		wLoopBackInit	$03
		dc.b $C1, $18
		wStopRead
		wAddVol		$18
		wLoopBack
		wLoopGoEnd

.3A
		wHeaderSFX	$22
		wChSFX	$09, .3A_00
		dc.b	$FF

.3A_00
		wSetType	$02
		wSetMask	$02
		wSetFreq	$0000
		wSetVol		$00
		wSetPat		$04
		wLoopBackInit	$03
		dc.b $C0, $55, $44, $40
		wAddFreq	$F0FF
		wAddVol		$04
		wLoopBack
		wLoopGoEnd

.3B
		wHeaderSFX	$28
		wChSFX	$08, .3B_00
		dc.b	$FF

.3B_00
		wSetMask	$10
		wSetFreq	$0000
		wSetVol		$04
		wSetPat		$30
		dc.b $C1, $58, $C4, $50
		wLoopGoEnd

.3C
		wHeaderSFX	$48
		wChSFX	$08, .3C_00
		dc.b	$FF

.3C_00
		wSetMask	$10
		wSetFreq	$0000
		wSetVol		$00
		wSetPat		$31
		dc.b $CA, $50
		wLoopGoEnd

.3D
		wHeaderSFX	$40
		wChSFX	$09, .3D_00
		dc.b	$FF

.3D_00
		wSetType	$02
		wSetMask	$02
		wSetFreq	$2000
		wSetPat		$0D
		wTempoDiv	$10
		wSetVol		$08
		wLoopBackInit	$02
		wLoopBackInit	$07
		dc.b $C4, $10
		wAddFreq	$0240
		wAddVol		$01
		wLoopBack
		wLoopBack
		wLoopGoEnd

.3E
		wHeaderSFX	$40
		wChSFX	$09, .3E_00
		dc.b	$FF

.3E_00
		wSetType	$02
		wSetMask	$02
		wLoopGoEnd

.3F
		wHeaderSFX	$30
		wChSFX	$08, .3F_00
		wChSFX	$06, .3F_01
		dc.b	$FF

.3F_01
.42_00_00
		wSetType	$02
		wSetMask	$01
		wSetPat		$0B
		wTempoDiv	$10
		dc.b $C3, $24
		wLoopBackInit	$03
		dc.b $C1, $20, $11
		wAddVol		$08
		wLoopBack
		wLoopGoEnd

.40
		wHeaderSFX	$14
		wChSFX	$08, .40_00
		dc.b	$FF

.40_00
		wSetMask	$10
		wSetPat		$32
		wTempoDiv	$0F
		dc.b $CA, $32
		wLoopGoEnd

.41
		wHeaderSFX	$14
		wChSFX	$06, .41_00
		dc.b	$FF

.41_00
		wSetType	$02
		wSetMask	$05
		wTempoDiv	$10
		wSetFreq	$0C00
		wSetVol		$08
		wSetPat		$10
		wSetTimerW	$7000
		dc.b $70
		wAddFreq	$0042
		dc.b $10
		wLoopGoEnd

.42
		wHeaderSFX	$14
		wChSFX	$06, .42_00
		dc.b	$FF

.42_00
		wJump		.42_00_00

.43
		wHeaderSFX	$14
		wChSFX	$07, .43_00
		dc.b	$FF

.43_00
		wSetType	$02
		wSetMask	$04
		wTempoDiv	$10
		wSetFreq	$2000
		wSetVol		$08
		wSetPat		$0B
		wSetTimerB	$09
		dc.b $38, $42, $32
		wSetTimerB	$0C
		dc.b $23
		wLoopGoEnd

.44
		wHeaderSFX	$44
		wChSFX	$07, .44_00
		dc.b	$FF

.44_00
		wSetType	$02
		wSetMask	$06
		wTempoDiv	$10
		wLoopBackInit	$01
		wLoopBackInit	$07
		wSetFreq	$1800
		wLoopGo		$00, .44_00_00
		wSetFreq	$0C00
		wLoopGo		$00, .44_00_01
		wAddVol		$03
		wLoopBack
		wLoopBack
		wLoopGoEnd

.45_00_00
.44_00_00
.44_00_01
.45_00_01
		wSetPat		$04
		dc.b $C2, $70, $17
		wLoopGoEnd
		dc.b $FF

.45
		wHeaderSFX	$44
		wChSFX	$07, .45_00
		dc.b	$FF

.45_00
		wSetType	$02
		wSetMask	$06
		wTempoDiv	$10
		wLoopBackInit	$04
		wLoopBackInit	$07
		wSetFreq	$1800
		wLoopGo		$00, .45_00_00
		wSetFreq	$0C00
		wLoopGo		$00, .45_00_01
		wAddVol		$01
		wLoopBack
		wLoopBack
		wLoopGoEnd

.46
		wHeaderSFX	$12
		wChSFX	$08, .46_00
		dc.b	$FF

.46_00
		wSetMask	$10

.55_00_01
.55_00_06
.55_00_09
.55_00_03
		wSetFreq	$2F00
		wJump		.46_00_00

.47
		wHeaderSFX	$1C
		wChSFX	$07, .47_00
		dc.b	$FF

.47_00
		wSetMask	$10
		wTempoDiv	$10
		wSetFreq	$3400
		wSetVol		$0C
		wSetPat		$2C
		wLoopBackInit	$07
		wFC
		dc.b $C0, $20
		wAddVol		$FF
		wLoopBack
		wLoopBackInit	$07
		wFC
		dc.b $20
		wAddVol		$08
		wAddFreq	$0000
		wLoopBack
		wLoopGoEnd

.48
		wHeaderSFX	$1A
		wChSFX	$07, .48_00
		dc.b	$FF

.48_00
		wSetType	$02
		wSetMask	$06
		wTempoDiv	$0E
		wSetFreq	$1000
		wSetVol		$04
		wLoopBackInit	$02
		dc.b $C1, $7C
		wAddFreq	$0040
		dc.b $1C
		wAddFreq	$FFC0
		dc.b $70
		wAddFreq	$0040
		dc.b $10
		wAddFreq	$FFC0
		dc.b $68
		wAddFreq	$0040
		dc.b $08
		wAddFreq	$FFC0
		wStopHw
		wAddVol		$0C
		wLoopBack
		wLoopGoEnd

.49
		wHeaderSFX	$18
		wChSFX	$08, .49_00
		dc.b	$FF

.49_00
		wSetMask	$10
		wSetVol		$08
		wTempoDiv	$0F
		wSetFreq	$1000
		wSetPat		$13
		dc.b $C0, $14, $34
		wStopRead
		dc.b $1B, $27, $C0, $30, $20
		wStopRead
		wStopRead
		dc.b $C1, $30, $38, $24, $15, $34
		wLoopGoEnd

.4A
		wHeaderSFX	$10
		wChSFX	$09, .4A_00
		dc.b	$FF

.4A_00
		wSetPat		$0C
		wTempoDiv	$0F
		wSetFreq	$2580
		wSetVol		$08
		wSetType	$02
		wSetMask	$02
		wSetTimerB	$05
		wLoopBackInit	$05
		dc.b $32, $3F, $38, $28
		wAddVol		$10
		wLoopBack
		wLoopGoEnd

.4C
.4B
		wHeaderSFX	$14
		wChSFX	$09, .4B_00
		dc.b	$FF

.4C_00
.4B_00
		wSetType	$02
		wSetMask	$01
		wSetPat		$04
		wTempoDiv	$10
		dc.b $C3, $5F
		wLoopBackInit	$03
		dc.b $C1, $51, $53
		wAddVol		$08
		wAddFreq	$FCFF
		wLoopBack
		wLoopGoEnd

.4D
		wHeaderSFX	$20
		wChSFX	$09, .4D_00
		dc.b	$FF

.4D_00
		wSetType	$02
		wSetMask	$02
		wSetPat		$0C
		wSetVol		$00
		wTempoDiv	$10
		dc.b $C1, $50
		wLoopBackInit	$05
		dc.b $C1, $45, $53
		wAddVol		$08
		wAddFreq	$01FF
		wLoopBack
		wLoopGoEnd

.4E
		wHeaderSFX	$28
		wChSFX	$06, .4E_00
		dc.b	$FF

.4E_00
		wSetPat		$0C
		wTempoDiv	$0F
		wSetFreq	$2580
		wSetVol		$00
		wSetType	$02
		wSetMask	$01
		wSetTimerB	$08
		wLoopBackInit	$02
		dc.b $32, $30, $33, $08
		wAddVol		$18
		wLoopBack
		wLoopGoEnd

.4F
		wHeaderSFX	$14
		wChSFX	$07, .4F_00
		dc.b	$FF

.4F_00
		wSetType	$02
		wSetMask	$02
		wSetVol		$04
		wSetPat		$07
		wTempoDiv	$0D
		wLoopBackInit	$02
		dc.b $C0, $74, $34
		wStopRead
		dc.b $2A, $36
		wAddVol		$2C
		wLoopBack
		wLoopGoEnd

.50
		wHeaderSFX	$2C
		wChSFX	$06, .50_00
		dc.b	$FF

.50_00
		wSetType	$02
		wSetMask	$02
		wSetPat		$0D
		wTempoDiv	$0D
		wLoopBackInit	$02
		dc.b $C0, $31, $28
		wStopRead
		wStopRead
		dc.b $1E, $2A
		wAddVol		$18
		wLoopBack
		wLoopGoEnd

.51
		wHeaderSFX	$14
		wChSFX	$06, .51_00
		dc.b	$FF

.51_00
		wSetMask	$30
		dc.b $CA
		wSetPat		$1F
		dc.b $84, $28
		wLoopGoEnd

.52
		wHeaderSFX	$28
		wChSFX	$08, .52_00
		dc.b	$FF

.52_00
		wSetMask	$30
		wSetPat		$2E
		wTempoDiv	$0F
		wSetVol		$1C
		wSetTimerB	$25
		wLoopBackInit	$07
		wFC
		dc.b $7F
		wAddFreq	$0028
		dc.b $1F
		wAddFreq	$FFDC
		wAddVol		$0C
		wLoopBack
		wLoopGoEnd

.53
		wHeaderSFX	$78
		wChSFX	$06, .53_00
		wChSFX	$07, .53_01
		wChSFX	$08, .53_02
		dc.b	$FF

.53_00
		wSetPat		$24
		wSetMask	$30
		wSetVol		$00
		dc.b $C7
		wTempoDiv	$0D
		wAddVol		$1C
		dc.b $32, $9C, $3E, $37, $99, $3A, $32, $3E
		dc.b $C4, $99, $3B
		wLoopGoEnd

.53_01
		wSetPat		$1F
		wSetMask	$01
		wSetVol		$00
		dc.b $C3
		wTempoDiv	$0C
		wAddVol		$1C
		dc.b $52, $53, $54, $4F, $50, $51, $52, $4D
		dc.b $4E, $4F, $50, $4C, $4B, $4D, $4E, $48
		dc.b $3F, $40, $41, $3D, $3E, $3A, $3B, $3D
		dc.b $39, $38, $35, $CE
		wLoopGoEnd

.53_02
		wSetPat		$04
		wSetMask	$0E
		wSetVol		$00
		dc.b $C5
		wTempoDiv	$0D
		wAddVol		$1C
		dc.b $9E, $43, $9E, $42, $9E, $42, $9C, $41
		dc.b $9C, $41, $9B, $40, $9B, $40, $9A, $3F
		dc.b $97, $3E, $A3, $48, $94, $3B, $AA, $4F
		dc.b $94, $3B, $B1, $B6, $58, $C6
		wStopRead
		wLoopGoEnd

.55
		wHeaderMus	$88, $0300
		dw	.55_00
		dw	$0000

.55_00
.55_00_0C
		wSetMask	$01
		wLoopBackInit	$02
		wLoopGo		$00, .55_00_00
		dc.b $C3
		wStopRead
		wLoopBack
		wLoopGo		$00, .55_00_01
		dc.b $C5
		wStopRead
		wLoopGo		$01, .55_00_03
		dc.b $C4
		wStopRead
		wLoopGo		$00, .55_00_05
		wLoopGo		$00, .55_00_06
		dc.b $C4
		wStopRead
		wLoopGo		$01, .55_00_08
		dc.b $C6
		wStopRead
		wLoopGo		$00, .55_00_09
		wLoopGo		$00, .55_00_0B
		wJump		.55_00_0C

.56
		wHeaderSFX	$70
		wChSFX	$06, .56_00
		dc.b	$FF

.56_00
		wSetMask	$3F
		wSetPat		$27
		wSetVol		$02
		wTempoDiv	$0E
		dc.b $C2, $50, $54, $57
		wAddVol		$1C
		wLoopBackInit	$03
		dc.b $50, $54, $57
		wAddVol		$0E
		wLoopBack
		wLoopGoEnd

.57
		wHeaderSFX	$2C
		wChSFX	$06, .57_00
		dc.b	$FF

.57_00
		wSetType	$02
		wSetMask	$02
		wSetPat		$0E
		wTempoDiv	$0D
		wLoopBackInit	$03
		dc.b $C0, $27, $30
		wStopRead
		wStopRead
		dc.b $22, $18
		wAddVol		$08
		wLoopBack
		wLoopGoEnd

.01_00_01
.01_00_03
		wSetVol		$25
		dc.b $CA
		wTempoDiv	$0D
		wAddVol		$06
		dc.b $97
		wTempoDiv	$0B
		dc.b $40, $C8, $95, $3E, $A0, $37, $C9
		wTempoDiv	$0D
		wAddVol		$FB
		dc.b $99, $41, $C6
		wAddVol		$0F
		dc.b $97, $3F, $C8
		wTempoDiv	$0B
		wAddVol		$F1
		dc.b $97, $3E
		wAddVol		$0A
		dc.b $99, $3D, $CA
		wTempoDiv	$0D
		wAddVol		$FB
		dc.b $95, $3E, $C8, $97, $3C
		wAddVol		$05
		dc.b $A2, $39, $CA
		wAddVol		$FB
		dc.b $9D, $41
		wLoopGoEnd

.01_00_00
		wSetVol		$25
		dc.b $CA
		wTempoDiv	$0F
		wAddVol		$06
		dc.b $A0, $43, $C6
		wTempoDiv	$0D
		dc.b $9A, $41, $C4, $A1, $45, $A0, $43
		wStopRead
		dc.b $9C, $40
		wStopRead
		wAddVol		$14
		dc.b $9C, $40, $CA
		wTempoDiv	$0F
		wAddVol		$EC
		dc.b $A0, $43, $C6
		wTempoDiv	$0D
		dc.b $9A, $41, $C4, $A1, $45, $A0, $43
		wStopRead
		wAddVol		$0A
		dc.b $9D, $41, $9C, $40, $99, $3C
		wLoopGoEnd

.01_00_02
		wSetVol		$25
		dc.b $C8
		wTempoDiv	$0D
		wAddVol		$06
		dc.b $9E, $3A, $A0, $3A
		wLoopGoEnd

.01_00_04
		wSetVol		$25
		dc.b $C8
		wTempoDiv	$0D
		wAddVol		$01
		dc.b $9E, $3A
		wAddVol		$FB
		dc.b $A0, $3A
		wLoopGoEnd

.01_00_05
		wSetVol		$25
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$06
		dc.b $A0, $45, $3E, $3C
		wAddVol		$05
		dc.b $A0, $45, $3E, $3C
		wAddVol		$05
		dc.b $A0, $45, $3E
		wAddVol		$FB
		dc.b $A1, $45
		wAddVol		$FB
		dc.b $48
		wAddVol		$05
		dc.b $A1, $45, $C6
		wAddVol		$FB
		dc.b $9F, $43, $C4, $48
		wAddVol		$05
		dc.b $43
		wAddVol		$05
		dc.b $41
		wAddVol		$FB
		dc.b $A1, $45, $40, $A1, $45, $C6
		wAddVol		$FB
		dc.b $9E, $41, $C4
		wAddVol		$05
		dc.b $40
		wAddVol		$FB
		dc.b $41
		wAddVol		$FB
		dc.b $43
		wAddVol		$05
		dc.b $9E, $41, $40, $45, $C6
		wAddVol		$05
		dc.b $A0, $43, $C4
		wAddVol		$05
		dc.b $9E, $41, $9C, $40, $3C
		wAddVol		$F6
		dc.b $A0, $45, $3E, $3C
		wAddVol		$05
		dc.b $9F, $45, $3E, $3C
		wAddVol		$05
		dc.b $9E, $45, $3C
		wTempoDiv	$10
		wAddVol		$F6
		dc.b $9A
		wTempoDiv	$0D
		dc.b $35, $3D, $41, $C6
		wAddVol		$FB
		dc.b $9E, $43, $C4
		wAddVol		$05
		dc.b $41
		wAddVol		$05
		dc.b $40, $3E
		wAddVol		$05
		dc.b $99, $3C, $C7
		wAddVol		$F6
		dc.b $9C, $43, $C4
		wAddVol		$0A
		dc.b $98, $3A, $C7
		wAddVol		$F6
		dc.b $9C, $42, $C4
		wAddVol		$05
		dc.b $9D, $41
		wAddVol		$05
		dc.b $3C
		wAddVol		$FB
		dc.b $9D, $41, $C6
		wAddVol		$FB
		dc.b $A0, $43, $C4, $9D, $41, $9C, $40, $99
		dc.b $3C
		wLoopGoEnd

.01_00
		wSetType	$00
		wSetMask	$06
		wSetPat		$04
		wLoopGo		$00, .01_00_00

.01_00_06
		wLoopGo		$00, .01_00_01
		wLoopGo		$00, .01_00_02
		wLoopGo		$00, .01_00_03
		wLoopGo		$00, .01_00_04
		wLoopGo		$00, .01_00_05
		wJump		.01_00_06

.01_01_01
		wSetVol		$15
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$10
		dc.b $29, $30, $35, $CF, $3C, $C4, $2B, $32
		dc.b $35, $3C, $2D, $34, $35, $3C, $26, $2D
		dc.b $35, $CF
		wTempoDiv	$0D
		dc.b $3C, $C4
		wTempoDiv	$10
		dc.b $28, $2E, $35, $3C, $2D, $31, $35, $3C
		dc.b $2E, $32, $35, $CF, $3C, $C4, $2D, $34
		dc.b $35, $3C, $32, $34, $36, $3C, $2A, $31
		dc.b $36, $CF
		wAddVol		$FB
		dc.b $3C, $C4, $2B, $32, $35, $3C
		wAddVol		$FB
		dc.b $30, $34, $37, $3C
		wLoopGoEnd

.01_01_00
		wSetVol		$15
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$10
		dc.b $29, $30, $35, $CF, $3C, $C4, $2B, $32
		dc.b $35, $3C, $2D, $34, $35, $3C
		wLoopGoEnd

.01_01_02
		wSetVol		$15
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$10
		dc.b $2D, $34, $39, $3B, $3C, $39, $3B, $37
		dc.b $32, $35, $39, $35, $30, $33, $39, $35
		dc.b $2E, $32, $35, $C7, $32, $C4, $2E, $2D
		dc.b $2B, $32, $35, $C6, $30, $2E, $C4, $2B
		dc.b $29, $34, $35, $3C, $2C, $34, $37, $3C
		dc.b $2A, $35, $3A, $C6, $2B, $C4, $32, $35
		dc.b $37, $2D, $34, $37, $3C, $2C, $33, $36
		dc.b $3C, $2A, $31, $35, $C6, $30, $C4, $2E
		dc.b $34, $37
		wLoopGoEnd
	; Unused
		dc.b $F4, $15, $C4, $F1, $10, $F5, $10, $2A
		dc.b $31, $36, $CF, $3C, $FF

.01_01
		wSetType	$00
		wSetMask	$01
		wSetPat		$04
		wLoopGo		$01, .01_01_00

.01_01_03
		wLoopGo		$01, .01_01_01
		wLoopGo		$00, .01_01_02
		wJump		.01_01_03

.01_02_00
		wSetVol		$02
		wTempo		$68
		dc.b $01, $C4
		wStopRead
		wStopRead
		wTempo		$64
		dc.b $01
		wStopRead
		wStopRead
		wTempo		$62
		dc.b $01
		wStopRead
		wStopRead
		wTempo		$65
		dc.b $01
		wTempoDiv	$10
		wAddVol		$0B
		dc.b $48
		wTempo		$68
		dc.b $01, $4A
		wTempo		$77
		dc.b $01
		wLoopGoEnd

.01_02_03
.01_02_01
		wSetVol		$02
		dc.b $C8
		wTempoDiv	$10
		wAddVol		$10
		dc.b $45, $C4
		wStopRead
		wTempoDiv	$0D
		wAddVol		$0A
		dc.b $45
		wAddVol		$FB
		dc.b $45
		wAddVol		$FB
		dc.b $45
		wTempoDiv	$10
		dc.b $45, $C6, $43, $C7
		wAddVol		$05
		dc.b $41, $C4
		wAddVol		$F6
		dc.b $48, $4A, $C8
		wAddVol		$05
		dc.b $45, $C4
		wStopRead
		wTempoDiv	$0D
		wAddVol		$0A
		dc.b $45
		wAddVol		$FB
		dc.b $45
		wAddVol		$FB
		dc.b $45
		wTempoDiv	$10
		dc.b $45, $C6, $43, $41
		wTempoDiv	$0D
		wAddVol		$05
		dc.b $48, $C4
		wTempoDiv	$10
		dc.b $48, $C8
		wAddVol		$FB
		dc.b $46, $C4
		wStopRead
		wTempoDiv	$0D
		dc.b $46
		wTempoDiv	$10
		dc.b $46
		wTempoDiv	$0D
		wAddVol		$05
		dc.b $45
		wTempoDiv	$10
		wAddVol		$F6
		dc.b $46
		wAddVol		$0A
		dc.b $45
		wStopRead
		wAddVol		$FB
		dc.b $43
		wStopRead
		dc.b $C6
		wTempoDiv	$0D
		wAddVol		$FB
		dc.b $48, $C4
		wTempoDiv	$10
		wAddVol		$05
		dc.b $48, $C8, $46, $C4
		wStopRead
		dc.b $46
		wAddVol		$05
		dc.b $45
		wAddVol		$FB
		dc.b $46
		wLoopGoEnd

.01_02_02
		wSetVol		$02
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$1A
		dc.b $48, $48
		wAddVol		$FB
		dc.b $4A, $4A
		wAddVol		$FB
		dc.b $4C
		wStopRead
		wTempoDiv	$10
		wAddVol		$FB
		dc.b $48, $4A
		wLoopGoEnd

.01_02_04
		wSetVol		$02
		dc.b $C6
		wTempoDiv	$10
		wAddVol		$10
		dc.b $49, $C4, $48, $C7, $46, $C6
		wStopRead
		wLoopGoEnd

.01_02
		wSetType	$00
		wSetMask	$08
		wSetPat		$1C
		dc.b $CA
		wStopRead
		wStopRead
		wStopRead

.01_02_05
		wLoopGo		$00, .01_02_00
		wLoopGo		$00, .01_02_01
		wLoopGo		$00, .01_02_02
		wLoopGo		$00, .01_02_03
		wLoopGo		$00, .01_02_04
		dc.b $CA
		wLoopBackInit	$06
		wStopRead
		wLoopBack
		wJump		.01_02_05

.01_03_00
		wSetVol		$11
		dc.b $C9
		wStopRead
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$10
		dc.b $45
		wAddVol		$FB
		dc.b $46, $C8
		wAddVol		$FB
		dc.b $48, $40
		wAddVol		$05
		dc.b $41, $C4
		wStopRead
		wAddVol		$F6
		dc.b $41
		wAddVol		$05
		dc.b $40, $3E, $C6, $3A, $C4
		wStopRead
		wAddVol		$05
		dc.b $3A
		wStopRead
		wAddVol		$05
		dc.b $43
		wAddVol		$FB
		dc.b $45
		wAddVol		$FB
		dc.b $46
		wAddVol		$FB
		dc.b $4A
		wAddVol		$05
		dc.b $48, $45, $C7
		wAddVol		$05
		dc.b $48, $C4, $45
		wAddVol		$FB
		dc.b $46, $C8, $48, $4C, $C4
		wAddVol		$FB
		dc.b $4D
		wAddVol		$05
		dc.b $4C
		wStopRead
		wAddVol		$05
		dc.b $4A
		wStopRead
		wAddVol		$05
		dc.b $4A
		wAddVol		$FB
		dc.b $4C
		wAddVol		$FB
		dc.b $4D, $4F
		wAddVol		$0A
		dc.b $4A
		wAddVol		$FB
		dc.b $4C
		wAddVol		$FB
		dc.b $4D, $4F
		wAddVol		$0A
		dc.b $4A
		wAddVol		$FB
		dc.b $4C
		wAddVol		$FB
		dc.b $4D, $C5
		wAddVol		$FB
		dc.b $51, $C2
		wStopRead
		dc.b $C4
		wAddVol		$05
		dc.b $51, $C7
		wAddVol		$05
		dc.b $4F, $C6
		wStopRead
		wLoopGoEnd

.01_03
		wSetType	$00
		wSetMask	$08
		wSetPat		$01
		dc.b $CA
		wLoopBackInit	$03
		wStopRead
		wLoopBack

.01_03_01
		dc.b $CA
		wLoopBackInit	$03
		wStopRead
		wLoopBack
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		wStopRead
		wStopRead
		wStopRead
		wLoopGo		$00, .01_03_00
		wJump		.01_03_01

.01_04_01
.01_04_00
		wSetVol		$00
		dc.b $C4
		wAddVol		$12
		dc.b $60
		wAddVol		$14
		dc.b $01
		wStopRead
		dc.b $01
		wStopRead
		dc.b $01
		wStopRead
		dc.b $01, $01
		wAddVol		$EC
		dc.b $00
		wAddVol		$14
		dc.b $01
		wAddVol		$EC
		dc.b $05
		wAddVol		$14
		dc.b $01
		wAddVol		$EC
		dc.b $60
		wAddVol		$14
		dc.b $01
		wStopRead
		wAddVol		$EC
		dc.b $05
		wStopRead
		dc.b $60
		wAddVol		$14
		dc.b $01
		wStopRead
		dc.b $01
		wStopRead
		dc.b $01, $01
		wStopRead
		dc.b $01
		wAddVol		$EC
		dc.b $00
		wAddVol		$14
		dc.b $01, $05, $01
		wAddVol		$EC
		dc.b $60
		wAddVol		$14
		dc.b $01, $05
		wAddVol		$F6
		dc.b $05, $C2
		wAddVol		$F6
		dc.b $05
		wStopRead
		wLoopGoEnd

.01_04_02
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $60
		wAddVol		$14
		dc.b $01
		wStopRead
		wAddVol		$F6
		dc.b $0F
		wStopRead
		dc.b $C4
		wAddVol		$0A
		dc.b $61
		wAddVol		$EC
		dc.b $05
		wAddVol		$0A
		dc.b $0F, $C2
		wAddVol		$0A
		dc.b $01, $C5
		wStopRead
		dc.b $C6, $61
		wAddVol		$EC
		dc.b $05, $C4, $00, $C2
		wAddVol		$14
		dc.b $01
		wStopRead
		dc.b $C4
		wAddVol		$EC
		dc.b $05, $C2
		wAddVol		$14
		dc.b $01
		wStopRead
		wAddVol		$EC
		dc.b $60
		wAddVol		$14
		dc.b $01, $C5
		wStopRead
		dc.b $C6
		wAddVol		$EC
		dc.b $05
		wLoopGoEnd

.01_04_03
.01_04_05
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $60
		wAddVol		$14
		dc.b $01
		wStopRead
		dc.b $C4
		wAddVol		$F6
		dc.b $0F
		wAddVol		$0A
		dc.b $61
		wAddVol		$EC
		dc.b $05
		wAddVol		$0A
		dc.b $0F, $C2
		wAddVol		$0A
		dc.b $01
		wStopRead
		dc.b $01
		wStopRead
		dc.b $C4, $61
		wAddVol		$EC
		dc.b $05, $C2, $01
		wStopRead
		dc.b $C4, $00, $C2
		wAddVol		$14
		dc.b $01
		wStopRead
		dc.b $C4
		wAddVol		$EC
		dc.b $05, $C2
		wAddVol		$14
		dc.b $01
		wStopRead
		wAddVol		$EC
		dc.b $60
		wAddVol		$14
		dc.b $61
		wAddVol		$EC
		dc.b $05, $05, $C4, $05, $05, $05
		wLoopGoEnd

.01_04_04
.01_04_06
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $60
		wAddVol		$14
		dc.b $01
		wStopRead
		dc.b $0F
		wStopRead
		dc.b $C4, $61
		wAddVol		$EC
		dc.b $05
		wAddVol		$14
		dc.b $0F, $C2, $01
		wStopRead
		dc.b $C4, $0F, $61
		wAddVol		$EC
		dc.b $05
		wAddVol		$14
		dc.b $0F
		wAddVol		$EC
		dc.b $00
		wAddVol		$14
		dc.b $0F
		wAddVol		$EC
		dc.b $05
		wAddVol		$14
		dc.b $0F, $C2
		wAddVol		$EC
		dc.b $60
		wAddVol		$14
		dc.b $01
		wStopRead
		dc.b $C4, $0F
		wAddVol		$EC
		dc.b $05
		wAddVol		$14
		dc.b $0F
		wLoopGoEnd

.01_04
		wDrumChannel
		wLoopGo		$00, .01_04_00

.01_04_07
		wLoopGo		$00, .01_04_01
		wLoopGo		$00, .01_04_02
		wLoopGo		$00, .01_04_03
		wLoopGo		$02, .01_04_04
		wLoopGo		$00, .01_04_05
		wLoopGo		$03, .01_04_06
		wJump		.01_04_07

.01
		wHeaderMus	$88, $0177
		dw	.01_00
		dw	.01_01
		dw	.01_02
		dw	.01_03
		dw	.01_04
		dw	$0000

.02_00_02
.02_00_00
		wSetVol		$F8
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $29, $29, $28, $C8
		wStopRead
		dc.b $C4, $35, $29, $29, $28, $C6
		wStopRead
		dc.b $C4, $35, $29, $35
		wLoopGoEnd

.02_00_01
		wSetVol		$F8
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $28, $34, $28, $C8
		wStopRead
		dc.b $C4, $2F, $28, $34, $C6
		wStopRead
		dc.b $C0
		wTempoDiv	$10
		dc.b $36
		wSetTimerB	$1E
		dc.b $37, $C2
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $28, $2F
		wLoopGoEnd

.02_00_03
		wSetVol		$F8
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $28, $28, $C9
		wStopRead
		dc.b $C4
		wTempoDiv	$10
		dc.b $30, $C7, $2F, $C4, $2D
		wStopRead
		dc.b $2B
		wStopRead
		wLoopGoEnd

.02_00
		wSetType	$00
		wSetMask	$01
		wSetPat		$09
		dc.b $CA
		wLoopBackInit	$03
		wStopRead
		wLoopBack

.02_00_04
		dc.b $CA
		wLoopBackInit	$03
		wStopRead
		wLoopBack
		wLoopBackInit	$03
		wStopRead
		wLoopBack
		wLoopGo		$00, .02_00_00
		wLoopGo		$00, .02_00_01
		wLoopGo		$00, .02_00_02
		wLoopGo		$00, .02_00_03
		dc.b $CA
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		wJump		.02_00_04

.02_01_02
		wSetVol		$11
		dc.b $C4
		wTempoDiv	$0A
		wAddVol		$FC
		dc.b $43
		wStopRead
		wAddVol		$0F
		dc.b $43
		wStopRead
		wAddVol		$05
		dc.b $43
		wStopRead
		wAddVol		$F6
		dc.b $43
		wAddVol		$F6
		dc.b $43, $C6
		wStopRead
		dc.b $C4
		wAddVol		$0A
		dc.b $41
		wAddVol		$05
		dc.b $40, $C6
		wStopRead
		dc.b $C4
		wAddVol		$F1
		dc.b $43, $45, $C9
		wTempoDiv	$0B
		wAddVol		$0A
		dc.b $43, $C4
		wStopRead
		wTempoDiv	$0A
		wAddVol		$0A
		dc.b $3C
		wStopRead
		wAddVol		$EC
		dc.b $39, $38
		wAddVol		$05
		dc.b $39, $3C
		wAddVol		$05
		dc.b $39
		wAddVol		$FB
		dc.b $43
		wAddVol		$05
		dc.b $40, $C6
		wAddVol		$F6
		dc.b $41, $C7
		wStopRead
		dc.b $C4
		wAddVol		$0F
		dc.b $41
		wAddVol		$FB
		dc.b $45
		wAddVol		$FB
		dc.b $48, $C6
		wAddVol		$FB
		dc.b $4C, $C4
		wAddVol		$0A
		dc.b $4A, $C6, $48, $C4
		wStopRead
		dc.b $C6, $4A, $C8
		wTempoDiv	$0B
		wAddVol		$F6
		dc.b $47
		wStopRead
		wLoopGoEnd

.02_01_01
.02_01_00
		wSetVol		$11
		dc.b $C8
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$06
		dc.b $4C
		wAddVol		$0A
		dc.b $4D
		wAddVol		$0A
		dc.b $4F, $51
		wAddVol		$F4
		dc.b $4C
		wAddVol		$08
		dc.b $4D
		wAddVol		$0C
		dc.b $4F, $51
		wAddVol		$FC
		dc.b $4C
		wAddVol		$04
		dc.b $4D
		wAddVol		$04
		dc.b $4F, $51
		wLoopGoEnd

.02_01
		wSetType	$00
		wSetMask	$09
		wSetPat		$27
		dc.b $CA
		wLoopBackInit	$01
		wStopRead
		wLoopBack

.02_01_03
		wStopRead
		wStopRead
		wLoopGo		$00, .02_01_00
		dc.b $CA
		wStopRead
		wStopRead
		wLoopGo		$00, .02_01_01
		dc.b $CA
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		wStopRead
		wStopRead
		wLoopGo		$00, .02_01_02
		wJump		.02_01_03

.02_02_00
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$21
		dc.b $4C, $4D
		wAddVol		$FB
		dc.b $4F
		wAddVol		$FB
		dc.b $51, $CA
		wAddVol		$0A
		dc.b $4C, $C4, $4A, $C7, $48, $C4
		wAddVol		$F6
		dc.b $4F
		wSetTimerW	$0108
		wAddVol		$05
		dc.b $4A, $C6
		wAddVol		$FB
		dc.b $48
		wAddVol		$0A
		dc.b $47, $C4, $4C, $4D
		wAddVol		$FB
		dc.b $4F
		wAddVol		$FB
		dc.b $51
		wSetTimerB	$F0
		wAddVol		$0A
		dc.b $4C, $C6
		wAddVol		$F6
		dc.b $54, $C4, $53, $C6
		wStopRead
		wSetTimerW	$0138
		wAddVol		$0A
		dc.b $4F
		wLoopGoEnd

.02_02
		wSetType	$00
		wSetMask	$08
		wSetPat		$02
		dc.b $CA
		wLoopBackInit	$03
		wStopRead
		wLoopBack

.02_02_01
		wLoopGo		$01, .02_02_00
		dc.b $CA
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		wJump		.02_02_01
	; Unused
		dc.b $F4, $05, $C6, $FA, $C4, $F1, $10, $F5
	; Unused
		dc.b $21, $39, $35, $C8, $FA, $C6, $FA, $C4
	; Unused
		dc.b $40, $3C, $C6, $FA, $C4, $4C, $48, $FA
	; Unused
		dc.b $48, $FA, $43, $FA, $41, $FA, $40, $FA
		dc.b $37, $FA, $34, $FA, $30, $FA, $2F, $FF

.02_03_00
.02_03_06
.02_03_02
.02_03_08
.02_03_04
		wSetVol		$05
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$21
		dc.b $47
		wStopRead
		dc.b $4A, $45
		wStopRead
		dc.b $4A, $45, $4A
		wLoopGoEnd

.02_03_01
.02_03_07
.02_03_03
.02_03_05
.02_03_09
		wSetVol		$05
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$21
		dc.b $47
		wStopRead
		dc.b $4A, $43
		wStopRead
		dc.b $4A, $43, $4A
		wLoopGoEnd

.02_03
		wSetType	$00
		wSetMask	$06
		wSetPat		$1D
		dc.b $CA
		wLoopBackInit	$03
		wStopRead
		wLoopBack

.02_03_0A
		dc.b $CA
		wLoopBackInit	$03
		wStopRead
		wLoopBack
		wLoopGo		$01, .02_03_00
		wLoopGo		$01, .02_03_01
		wLoopGo		$01, .02_03_02
		wLoopGo		$01, .02_03_03
		wLoopGo		$01, .02_03_04
		wLoopGo		$01, .02_03_05
		wLoopGo		$01, .02_03_06
		wLoopGo		$01, .02_03_07
		wLoopGo		$01, .02_03_08
		wLoopGo		$01, .02_03_09
		wJump		.02_03_0A

.02_04_00
		wSetVol		$05
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$21
		wTempo		$DD
		dc.b $01, $29, $30, $3C, $39
		wTempo		$DA
		dc.b $01, $41, $3C, $45, $3C
		wTempo		$D7
		dc.b $01, $48, $41, $45, $41
		wTempo		$D4
		dc.b $01, $4D, $48, $54, $51
		wTempo		$D0
		dc.b $01, $53, $4C, $4F, $47
		wTempo		$D4
		dc.b $01, $4C, $45, $48, $43
		wTempo		$D7
		dc.b $01, $40, $3B, $3E, $37
		wTempo		$DA
		dc.b $01, $3B, $34, $37, $28
		wLoopGoEnd

.02_04
		wSetType	$00
		wSetMask	$16
		wSetPat		$1D

.02_04_01
		wLoopGo		$06, .02_04_00
		wJump		.02_04_01

.02_05_00
		wSetVol		$08
		dc.b $C4
		wAddVol		$12
		dc.b $00, $C7
		wStopRead
		dc.b $C4, $0C
		wStopRead
		dc.b $05, $00, $00, $C7
		wStopRead
		dc.b $C4, $0C, $0C, $05, $0C
		wLoopGoEnd

.02_05_01
		wSetVol		$08
		dc.b $C4
		wAddVol		$12
		dc.b $0C, $C6
		wStopRead
		dc.b $C4, $00, $C6
		wStopRead
		dc.b $C4, $0C
		wStopRead
		wStopRead
		dc.b $00, $C6
		wStopRead
		dc.b $C2, $60, $0D, $0D, $0D, $CE
		wStopRead
		wLoopGoEnd

.02_05
		wDrumChannel
		dc.b $CA
		wLoopBackInit	$03
		wStopRead
		wLoopBack

.02_05_02
		dc.b $CA
		wLoopBackInit	$03
		wStopRead
		wLoopBack
		wLoopBackInit	$03
		wStopRead
		wLoopBack
		wLoopGo		$02, .02_05_00
		wLoopGo		$00, .02_05_01
		dc.b $CA
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		wJump		.02_05_02

.02
		wHeaderMus	$88, $01DD
		dw	.02_00
		dw	.02_01
		dw	.02_02
		dw	.02_03
		dw	.02_04
		dw	.02_05
		dw	$0000

.03_00_00
.03_00_01
		wSetVol		$00
		wSetFreq	$F400
		dc.b $C6
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $8D, $39, $8C, $38, $88, $34, $8D, $39
		dc.b $8C, $38, $88, $34, $87, $33, $88, $34
		wLoopGoEnd

.03_00_02
		wSetVol		$00
		dc.b $C6
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $8D, $39, $8C, $38, $88, $34, $8D, $39
		dc.b $C4, $8F, $3B, $8C, $38, $8D, $39, $88
		dc.b $34, $C0
		wTempoDiv	$10
		dc.b $93, $3F, $94, $40
		wAddVol		$05
		dc.b $93, $3F, $94, $40
		wAddVol		$05
		dc.b $93, $3F
		wAddVol		$05
		dc.b $94, $40, $93, $3F
		wAddVol		$FB
		dc.b $94, $40, $93, $3F
		wAddVol		$FB
		dc.b $94, $40, $93, $3F
		wAddVol		$FB
		dc.b $94, $40, $93, $3F
		wAddVol		$FB
		dc.b $94, $40, $93, $3F
		wAddVol		$FB
		dc.b $94, $40
		wLoopGoEnd

.03_00_05
.03_00_03
		wSetVol		$00
		dc.b $C6
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $92, $3E, $91, $3D, $8D, $39, $92, $3E
		dc.b $91, $3D, $8D, $39, $8C, $38, $8D, $39
		wLoopGoEnd

.03_00_04
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$0A
		wAddVol		$17
		dc.b $8D, $39, $8C, $38, $A5, $4C, $A5, $4C
		dc.b $8D, $39, $8C, $38, $A7, $4D, $A7, $4D
		wLoopGoEnd

.03_00_06
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$0A
		wAddVol		$17
		dc.b $8F, $3B, $8E, $3A, $A7, $4E, $A7, $4E
		dc.b $8F, $3B, $8E, $3A, $A9, $4F, $A9, $4F
		wLoopGoEnd

.03_00_07
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$0A
		wAddVol		$17
		dc.b $8F, $3B, $8E, $3A, $A7, $4E, $A7, $4E
		dc.b $C2
		wTempoDiv	$0C
		dc.b $99, $40, $A5, $4A, $98, $3F, $A4, $49
		dc.b $97, $3E, $A3, $48, $96, $3D, $A2, $47
		wLoopGoEnd

.03_00
		wSetType	$00
		wSetMask	$01
		wSetPat		$23
		wLoopGo		$01, .03_00_00

.03_00_08
		wLoopGo		$02, .03_00_01
		wLoopGo		$00, .03_00_02
		wLoopGo		$00, .03_00_03
		wLoopGo		$01, .03_00_04
		wLoopGo		$00, .03_00_05
		wLoopGo		$00, .03_00_06
		wLoopGo		$00, .03_00_07
		wJump		.03_00_08

.03_01_00
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$17
		dc.b $40, $41, $44, $45, $CA, $40, $C4, $3E
		dc.b $C7, $3C, $CA, $44, $C8, $40, $C6, $48
		dc.b $4A, $C4, $4C, $4D, $50, $51
		wSetTimerB	$F0
		dc.b $4C, $C6, $54, $C4, $53
		wStopRead
		dc.b $50
		wSetTimerW	$0138
		dc.b $4C
		wLoopGoEnd

.03_01_02
.03_01_01
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$12
		dc.b $4A, $49, $4A, $C6, $4D, $C4, $4A, $4D
		dc.b $4A, $4F, $4D, $4F, $51, $C8, $4A
		wLoopGoEnd

.03_01_03
		wSetVol		$00
		dc.b $C8
		wStopRead
		dc.b $C2
		wTempoDiv	$10
		wAddVol		$17
		dc.b $54, $53, $52, $51, $50, $4F, $4E, $4D
		wLoopGoEnd

.03_01
		wSetType	$00
		wSetMask	$02
		wSetPat		$02
		dc.b $CA
		wLoopBackInit	$03
		wStopRead
		wLoopBack

.03_01_04
		wLoopGo		$00, .03_01_00
		wLoopGo		$00, .03_01_01
		dc.b $CA
		wStopRead
		wStopRead
		wLoopGo		$00, .03_01_02
		dc.b $CA
		wStopRead
		wLoopGo		$00, .03_01_03
		wJump		.03_01_04

.03_02_00
.03_02_01
		wSetVol		$14
		dc.b $C2
		wTempoDiv	$0C
		wAddVol		$17
		dc.b $34, $35, $38, $39, $3B, $3E, $40, $3B
		dc.b $39, $38, $41, $47, $4A, $4C, $4D, $50
		dc.b $51, $53, $54, $53, $51, $50, $4C, $48
		dc.b $47, $45, $44, $40, $3E, $3C, $3B, $38
		wLoopGoEnd

.03_02_04
.03_02_02
		wSetVol		$14
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$12
		dc.b $56
		wStopRead
		dc.b $56
		wStopRead
		dc.b $56
		wStopRead
		dc.b $56
		wStopRead
		wLoopGoEnd

.03_02_03
		wSetVol		$14
		dc.b $C2
		wTempoDiv	$10
		wAddVol		$12
		dc.b $A1, $45, $A2, $46, $A3, $47, $A4, $48
		dc.b $A5, $49, $A4, $48, $A3, $47, $A2, $46
		dc.b $C4, $A1, $45, $AC, $51, $A1, $45, $AC
		dc.b $51
		wLoopGoEnd

.03_02_05
		wSetVol		$14
		dc.b $C2
		wTempoDiv	$10
		wAddVol		$12
		dc.b $A3, $47, $A4, $48, $A5, $49, $A6, $4A
		dc.b $A7, $4B, $A6, $4A, $A5, $49, $A4, $48
		dc.b $C4, $A3, $47, $AE, $53, $A3, $47, $AE
		dc.b $53
		wLoopGoEnd

.03_02_06
		wSetVol		$14
		dc.b $C2
		wTempoDiv	$10
		wAddVol		$12
		dc.b $A3, $47, $A4, $48, $A5, $49, $A6, $4A
		dc.b $A7, $4B, $A6, $4A, $A5, $49, $A4, $48
		wTempoDiv	$0E
		wAddVol		$FD
		dc.b $47, $46, $45, $44
		wAddVol		$FA
		dc.b $43, $42
		wAddVol		$FD
		dc.b $41, $40
		wLoopGoEnd

.03_02
		wSetType	$00
		wSetMask	$1C
		wSetPat		$1D
		wLoopGo		$01, .03_02_00

.03_02_07
		wLoopGo		$03, .03_02_01
		wLoopGo		$01, .03_02_02
		wLoopGo		$01, .03_02_03
		wLoopGo		$01, .03_02_04
		wLoopGo		$00, .03_02_05
		wLoopGo		$00, .03_02_06
		wJump		.03_02_07

.03_03_00
.03_03_02
.03_03_01
		wSetVol		$0C
		dc.b $C6
		wAddVol		$06
		dc.b $00, $05, $00, $05
		wLoopGoEnd

.03_03_08
.03_03_03
		wSetVol		$0C
		dc.b $C4
		wAddVol		$06
		dc.b $00
		wStopRead
		dc.b $C2, $05
		wStopRead
		dc.b $05, $05, $0D, $0D, $0D, $0C, $0C
		wStopRead
		dc.b $05, $05
		wLoopGoEnd

.03_03_06
.03_03_04
		wSetVol		$0C
		dc.b $C4
		wAddVol		$06
		dc.b $00
		wStopRead
		dc.b $0D, $0C, $00
		wStopRead
		dc.b $05, $0C, $00
		wStopRead
		dc.b $0D, $0C, $C6
		wStopRead
		dc.b $C4, $05
		wStopRead
		wLoopGoEnd

.03_03_07
.03_03_05
		wSetVol		$0C
		dc.b $C4
		wAddVol		$06
		dc.b $00, $00, $05, $05, $00
		wStopRead
		dc.b $05
		wStopRead
		wLoopGoEnd

.03_03
		wDrumChannel
		wLoopGo		$03, .03_03_00

.03_03_09
		wLoopGo		$03, .03_03_01
		wLoopGo		$02, .03_03_02
		wLoopGo		$00, .03_03_03
		wLoopGo		$00, .03_03_04
		wLoopGo		$01, .03_03_05
		wLoopGo		$00, .03_03_06
		wLoopGo		$00, .03_03_07
		wLoopGo		$00, .03_03_08
		wJump		.03_03_09

.03
		wHeaderMus	$88, $01DD
		dw	.03_00
		dw	.03_01
		dw	.03_02
		dw	.03_03
		dw	$0000

.04_00_00
		wSetVol		$1A
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$FC
		dc.b $34, $34, $C6
		wStopRead
		dc.b $C4, $35, $35, $C6
		wStopRead
		dc.b $C4, $34, $34, $C7
		wStopRead
		dc.b $C6, $32, $C4, $32
		wLoopGoEnd

.04_00_01
		wSetVol		$1A
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$06
		dc.b $34, $2F, $34, $C6
		wStopRead
		dc.b $C4, $32, $2F, $32, $34, $2F, $34, $C6
		wStopRead
		dc.b $C4, $32, $C2
		wStopRead
		dc.b $C4, $32, $C2
		wStopRead
		wLoopGoEnd

.04_00_04
		wSetVol		$1A
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$06
		dc.b $32, $32, $C6
		wStopRead
		dc.b $C4, $32, $32, $3C, $3E, $32, $32, $C7
		wStopRead
		dc.b $C2
		wTempoDiv	$0C
		wAddVol		$F6
		dc.b $2F, $C4
		wStopRead
		wTempoDiv	$0D
		dc.b $2F, $C2
		wStopRead
		wLoopGoEnd

.04_00_03
		wSetVol		$1A
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$06
		dc.b $34, $34, $C6
		wStopRead
		dc.b $C4, $34, $34, $37, $39, $34, $34, $C7
		wStopRead
		dc.b $C2
		wTempoDiv	$0C
		dc.b $2F, $C4
		wStopRead
		dc.b $C5
		wTempoDiv	$0D
		dc.b $2F
		wLoopGoEnd

.04_00_02
		wSetVol		$1A
		dc.b $CA
		wTempoDiv	$10
		wAddVol		$FC
		dc.b $34, $34, $32, $CF, $32, $C4
		wTempoDiv	$0D
		dc.b $30, $32, $33
		wLoopGoEnd

.04_00
.04_00_05
		wSetType	$00
		wSetMask	$01
		wSetPat		$09
		wLoopGo		$01, .04_00_00
		wLoopGo		$01, .04_00_01
		wLoopGo		$00, .04_00_02
		wLoopGo		$00, .04_00_03
		wLoopGo		$00, .04_00_04
		wJump		.04_00_05

.04_01_00
		wSetVol		$0E
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$17
		dc.b $47, $4A, $48, $C6, $47, $C4, $4C, $4A
		dc.b $48, $C2, $47, $48, $47, $45, $C0, $46
		wSetTimerB	$42
		dc.b $47, $C4, $45, $41, $45, $47, $4A, $48
		dc.b $C6, $47, $C4, $4C, $4A, $48, $C8, $47
		wStopRead
		wLoopGoEnd

.04_01_01
		wSetVol		$0E
		dc.b $C6
		wStopRead
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$21
		dc.b $A3, $47, $4C, $A5, $4A, $A1, $45, $47
		dc.b $A0, $43
		wLoopGoEnd

.04_01_04
.04_01_02
		wSetVol		$0E
		dc.b $CF
		wTempoDiv	$10
		wAddVol		$17
		dc.b $4C, $C2, $4A, $4C, $C4, $4D, $4F, $CF
		dc.b $4C, $C2, $4A, $48, $C4, $47, $45
		wLoopGoEnd

.04_01_03
		wSetVol		$0E
		dc.b $CF
		wTempoDiv	$10
		wAddVol		$17
		dc.b $4A, $C2, $48, $4A, $C4, $4B, $4D, $CF
		dc.b $4A, $C4, $48, $4A, $4B
		wLoopGoEnd

.04_01_05
		wSetVol		$0E
		dc.b $CF
		wTempoDiv	$10
		wAddVol		$17
		dc.b $4A, $C2, $48, $4A, $C4, $4B, $4D, $C9
		dc.b $4A, $C4, $49, $48
		wLoopGoEnd

.04_01_06
.04_01
		wSetType	$00
		wSetMask	$06
		wSetFreq	$E800
		wSetPat		$0A
		wLoopGo		$00, .04_01_00
		dc.b $CA
		wStopRead
		wStopRead
		wStopRead
		wLoopGo		$00, .04_01_01
		wLoopGo		$00, .04_01_02
		wLoopGo		$00, .04_01_03
		wLoopGo		$00, .04_01_04
		wLoopGo		$00, .04_01_05
		wJump		.04_01_06

.04_02_00
		wSetVol		$11
		dc.b $C2
		wStopRead
		wTempoDiv	$09
		wAddVol		$17
		dc.b $53, $4D, $53, $56, $54, $53, $4A
		wStopRead
		dc.b $4C, $4D, $4A, $53, $51, $4A, $4C
		wStopRead
		dc.b $53, $4D, $53, $56, $54, $53, $4A
		wStopRead
		dc.b $53, $4D, $53, $56, $54, $53, $4A
		wLoopGoEnd

.04_02_01
		wSetVol		$11
		dc.b $C2
		wStopRead
		wTempoDiv	$0C
		wAddVol		$17
		dc.b $51, $4D, $53
		wStopRead
		dc.b $4A, $56, $C4
		wStopRead
		dc.b $C2
		wTempoDiv	$0D
		dc.b $53, $59
		wAddVol		$F6
		dc.b $5F
		wAddVol		$0A
		dc.b $53, $58
		wAddVol		$F6
		dc.b $5F
		wAddVol		$0A
		dc.b $53
		wStopRead
		wTempoDiv	$0C
		dc.b $51, $4D, $53
		wStopRead
		dc.b $4A, $56, $C4
		wStopRead
		dc.b $C2
		wAddVol		$F6
		dc.b $5F
		wAddVol		$0A
		dc.b $4D, $53, $59, $53, $4D
		wAddVol		$F6
		dc.b $5F
		wStopRead
		wAddVol		$0A
		dc.b $51, $4D, $53
		wStopRead
		dc.b $4A, $56, $C4
		wStopRead
		dc.b $C2
		wTempoDiv	$0D
		dc.b $53, $59
		wAddVol		$F6
		dc.b $5F
		wAddVol		$0A
		dc.b $53, $58
		wAddVol		$F6
		dc.b $5F
		wAddVol		$0A
		dc.b $53
		wStopRead
		wTempoDiv	$0C
		dc.b $51, $4D, $53, $C9
		wStopRead
		wLoopGoEnd

.04_02_02
		wSetVol		$11
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $4C, $C2
		wTempoDiv	$0C
		dc.b $4F, $53
		wStopRead
		dc.b $54, $53, $4F, $C4
		wTempoDiv	$0D
		dc.b $51, $C2
		wTempoDiv	$0C
		dc.b $4D, $C5
		wTempoDiv	$0D
		dc.b $51, $C4, $4D
		wLoopGoEnd

.04_02_03
		wSetVol		$11
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $4C, $C2
		wTempoDiv	$0C
		dc.b $4F, $53
		wStopRead
		dc.b $54, $53, $4F, $C4
		wTempoDiv	$0D
		wAddVol		$FB
		dc.b $5F, $C2
		wTempoDiv	$0C
		wAddVol		$05
		dc.b $4D, $C5
		wTempoDiv	$0D
		dc.b $53, $C4
		wAddVol		$FB
		dc.b $5F
		wLoopGoEnd

.04_02_04
.04_02
		wSetType	$00
		wSetMask	$08
		wSetFreq	$F400
		wSetPat		$26
		wLoopGo		$01, .04_02_00
		wLoopGo		$00, .04_02_01
		dc.b $CA
		wLoopBackInit	$03
		wStopRead
		wLoopBack
		wLoopGo		$02, .04_02_02
		wLoopGo		$00, .04_02_03
		wJump		.04_02_04

.04_03_01
		wSetVol		$04
		dc.b $CF
		wStopRead
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$17
		dc.b $44, $45, $46, $CF, $47, $C4, $45, $41
		dc.b $45, $C8, $47, $C4
		wStopRead
		dc.b $44, $45, $46, $CF, $47, $C0, $45, $46
		dc.b $C2, $47, $C4, $48, $4A, $C2, $47, $48
		dc.b $47, $C0, $45, $44, $45, $46
		wSetTimerB	$84
		dc.b $47
		wLoopGoEnd

.04_03_00
.04_03_02
		wSetVol		$04
		dc.b $CA
		wStopRead
		wLoopGoEnd

.04_03
.04_03_03
		wSetType	$00
		wSetMask	$06
		wSetPat		$02
		wLoopGo		$02, .04_03_00
		wLoopGo		$00, .04_03_01
		wLoopGo		$07, .04_03_02
		wJump		.04_03_03

.04_04_00
		wSetVol		$0D
		dc.b $C2
		wAddVol		$12
		dc.b $60, $08
		wStopRead
		dc.b $00, $C5
		wStopRead
		dc.b $C2, $6C, $12, $0D, $00, $12, $60, $12
		dc.b $C4
		wStopRead
		dc.b $C2, $08, $08
		wStopRead
		dc.b $60, $08
		wStopRead
		dc.b $00, $C5
		wStopRead
		dc.b $C2, $12, $12, $08, $08, $00
		wStopRead
		dc.b $0D, $0D, $60, $6C, $07, $6C, $07
		wLoopGoEnd

.04_04_01
		wSetVol		$0D
		dc.b $C2
		wAddVol		$12
		dc.b $60, $08
		wStopRead
		dc.b $00
		wStopRead
		dc.b $C4, $00, $C2, $6C, $12, $0D, $00, $12
		dc.b $60, $6C, $12, $0D, $00, $08, $6C, $08
		dc.b $0D, $60, $08
		wStopRead
		dc.b $00
		wStopRead
		dc.b $C4, $11, $C2, $12, $12, $08, $08, $60
		dc.b $0C, $0D
		wStopRead
		dc.b $00, $07, $07
		wLoopGoEnd

.04_04_03
		wSetVol		$0D
		dc.b $C2
		wAddVol		$12
		dc.b $60, $08
		wStopRead
		dc.b $00
		wStopRead
		dc.b $C4
		wAddVol		$F6
		dc.b $05, $C2
		wAddVol		$0A
		dc.b $6C, $12, $0D, $00, $12, $60, $12
		wStopRead
		wAddVol		$F6
		dc.b $05
		wAddVol		$0A
		dc.b $08, $C4
		wAddVol		$F6
		dc.b $65
		wAddVol		$0A
		dc.b $08, $C2, $60, $08
		wStopRead
		dc.b $00
		wStopRead
		dc.b $C4
		wAddVol		$F6
		dc.b $65
		wAddVol		$0A
		dc.b $0C, $C2, $12, $12, $08, $08, $00
		wStopRead
		dc.b $0D, $0D, $60, $6C, $07, $6C, $07
		wLoopGoEnd

.04_04_02
		wSetVol		$0D
		dc.b $C2
		wAddVol		$12
		dc.b $08, $CE
		wStopRead
		dc.b $C2, $12, $C4
		wStopRead
		dc.b $C2, $12, $12, $C4
		wStopRead
		dc.b $C2, $08, $08
		wStopRead
		dc.b $08, $CE
		wStopRead
		dc.b $C2, $12, $12, $08, $08, $C6
		wStopRead
		dc.b $C2, $07, $07
		wLoopGoEnd

.04_04
		wDrumChannel

.04_04_04
		wLoopGo		$01, .04_04_00
		wLoopGo		$01, .04_04_01
		wLoopGo		$00, .04_04_02
		wLoopGo		$02, .04_04_03
		wJump		.04_04_04

.04
		wHeaderMus	$88, $0155
		dw	.04_00
		dw	.04_01
		dw	.04_02
		dw	.04_03
		dw	.04_04
		dw	$0000

.00_00_00
.00_00_01
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$14
		dc.b $30
		wStopRead
		dc.b $33
		wStopRead
		dc.b $C5, $36, $C2, $33, $C4
		wStopRead
		dc.b $C6
		wAddVol		$FB
		dc.b $30, $C2
		wAddVol		$05
		dc.b $30
		wStopRead
		wAddVol		$FB
		dc.b $3A, $39, $3A
		wStopRead
		wAddVol		$05
		dc.b $37, $C4
		wStopRead
		dc.b $C5, $36, $C4, $33
		wLoopGoEnd

.00_00_02
		wSetVol		$00
		dc.b $C4
		wAddVol		$14
		dc.b $32
		wStopRead
		dc.b $33
		wStopRead
		dc.b $C5, $35, $C2, $33, $C4
		wStopRead
		dc.b $C6
		wAddVol		$FB
		dc.b $32, $C2
		wAddVol		$05
		dc.b $32
		wStopRead
		wAddVol		$FB
		dc.b $37, $35, $37
		wStopRead
		dc.b $C5
		wTempoDiv	$05
		wAddVol		$05
		dc.b $35
		wTempoDiv	$10
		dc.b $33, $C4, $35, $2B, $37, $36, $36, $33
		dc.b $33, $32, $30, $32, $2B, $2E, $31, $32
		dc.b $C7
		wStopRead
		wLoopGoEnd

.00_00_03
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$14
		dc.b $30, $30, $C9
		wStopRead
		dc.b $C4
		wStopRead
		wTempoDiv	$10
		dc.b $2B
		wStopRead
		dc.b $2B
		wStopRead
		dc.b $2B
		wStopRead
		dc.b $2B
		wLoopGoEnd

.00_00
		wSetType	$00
		wSetMask	$01
		wSetPat		$07
		wLoopGo		$01, .00_00_00

.00_00_04
		wLoopGo		$01, .00_00_01
		wLoopGo		$00, .00_00_02
		wLoopGo		$03, .00_00_03
		wJump		.00_00_04

.00_01_00
		wSetVol		$18
		wSetMask	$06
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$17
		dc.b $3C
		wStopRead
		dc.b $3F
		wStopRead
		dc.b $C5, $42, $C2, $3F, $C4
		wStopRead
		dc.b $C6
		wAddVol		$FB
		dc.b $3C, $C2
		wAddVol		$05
		dc.b $3C
		wStopRead
		wAddVol		$FB
		dc.b $46, $45, $46
		wStopRead
		wAddVol		$05
		dc.b $43, $C4
		wStopRead
		dc.b $C5, $42, $C4, $3F
		wLoopGoEnd

.00_01_01
		wSetVol		$18
		wSetMask	$06
		dc.b $CF
		wStopRead
		dc.b $C0
		wAddVol		$12
		dc.b $9F, $44
		wAddVol		$05
		dc.b $A0, $45
		wAddVol		$05
		dc.b $A1, $46
		wAddVol		$05
		dc.b $A2, $47, $C2
		wAddVol		$F1
		dc.b $A3, $48, $A6, $4B, $A1, $46, $9F, $43
		dc.b $CF
		wStopRead
		dc.b $C0, $9F, $44
		wAddVol		$05
		dc.b $A0, $45
		wAddVol		$05
		dc.b $A1, $46
		wAddVol		$05
		dc.b $A2, $47, $C2
		wAddVol		$F1
		dc.b $A3, $48, $A6, $4B, $C4
		wAddVol		$05
		dc.b $A1, $46
		wLoopGoEnd

.00_01_02
		wSetMask	$06
		wSetVol		$18
		dc.b $C4
		wStopRead
		wAddVol		$0D
		dc.b $9F, $43, $9E, $42, $9C, $3F, $C2
		wAddVol		$0A
		dc.b $9A, $3E, $99, $3D, $9A, $3E, $99, $3D
		dc.b $9A, $3E, $C5
		wStopRead
		wLoopGoEnd

.00_01_03
		wSetMask	$02
		wSetVol		$18
		dc.b $C4
		wTempoDiv	$05
		wAddVol		$17
		dc.b $3C, $3F, $43, $3F, $3C, $43, $3F, $3C
		dc.b $42, $3F, $3C, $42, $3F, $3C, $42, $3C
		dc.b $3C, $3F, $45, $3F, $3C, $45, $3F, $3C
		wLoopGoEnd

.00_01_04
		wSetMask	$02
		wSetVol		$18
		dc.b $C4
		wAddVol		$17
		dc.b $43, $3F, $3C, $43, $3F, $C2
		wTempoDiv	$10
		wAddVol		$F6
		wSetMask	$06
		dc.b $9E, $43, $9D, $42, $9A, $3F, $99, $3E
		dc.b $97, $3C, $92, $37
		wLoopGoEnd

.00_01_05
		wSetVol		$18
		dc.b $C4
		wAddVol		$17
		wSetMask	$06
		dc.b $93, $43, $9F, $46, $9F, $46, $92, $39
		dc.b $C2, $9E, $45, $9E, $45
		wStopRead
		dc.b $9E, $45, $C4, $9D, $44, $9C, $43
		wLoopGoEnd

.00_01_06
		wSetVol		$18
		dc.b $C4
		wStopRead
		wSetMask	$06
		wTempoDiv	$0D
		wAddVol		$0F
		dc.b $93, $3A, $93, $3A
		wTempoDiv	$10
		wAddVol		$24
		dc.b $93, $3A
		wStopRead
		wTempoDiv	$0D
		wAddVol		$DC
		dc.b $95, $3C, $95, $3C
		wTempoDiv	$10
		wAddVol		$24
		dc.b $95, $3C
		wLoopGoEnd

.00_01
		wSetType	$00
		wSetPat		$04
		wLoopGo		$01, .00_01_00

.00_01_07
		dc.b $CA
		wStopRead
		wStopRead
		wLoopGo		$00, .00_01_01
		dc.b $CA
		wStopRead
		wStopRead
		wStopRead
		wLoopGo		$00, .00_01_02
		wLoopGo		$00, .00_01_03
		wLoopGo		$00, .00_01_04
		wLoopGo		$02, .00_01_05
		wLoopGo		$00, .00_01_06
		wJump		.00_01_07

.00_02_03
.00_02_02
.00_02_04
.00_02_01
.00_02_00
		wSetMask	$01
		wSetVol		$00
		dc.b $C2
		wTempoDiv	$02
		wAddVol		$21
		dc.b $48, $54, $54, $54, $54
		wStopRead
		dc.b $54, $54, $C4
		wStopRead
		dc.b $C2, $54, $54, $54
		wStopRead
		dc.b $54, $54
		wLoopGoEnd

.00_02
		wSetType	$02
		wAddFreq	$F400
		wSetPat		$04
		dc.b $CA
		wStopRead
		wStopRead
		wLoopGo		$01, .00_02_00

.00_02_05
		wLoopGo		$05, .00_02_01
		wLoopGo		$00, .00_02_02
		dc.b $CA
		wStopRead
		wLoopGo		$00, .00_02_03
		dc.b $CA
		wStopRead
		wLoopGo		$00, .00_02_04
		dc.b $CA
		wLoopBackInit	$04
		wStopRead
		wLoopBack
		wJump		.00_02_05

.00_03_00
		wSetMask	$0C
		wSetVol		$28
		dc.b $C8
		wTempoDiv	$10
		dc.b $AB, $4F, $AA, $4E, $C6, $AB, $4F, $AA
		dc.b $4E, $AB, $4F, $AF, $52, $C2, $AB, $4F
		dc.b $AB, $4F, $AB, $4F, $C5
		wStopRead
		dc.b $C2, $AB, $4F, $AB, $4F, $AB, $4F
		wSetTimerB	$54
		wStopRead
		dc.b $C2, $AB, $4F, $AB, $4F, $AB, $4F, $C5
		wStopRead
		dc.b $C2, $AB, $4F, $AB, $4F, $AB, $4F
		wSetTimerB	$54
		wStopRead
		dc.b $C8, $AA, $4D, $A8, $4B, $C4, $A6, $4A
		wStopRead
		dc.b $A5, $48
		wStopRead
		dc.b $A6, $4A
		wStopRead
		dc.b $A8, $4B
		wStopRead
		dc.b $AB, $4F, $AA, $4E, $AB, $4F, $AD, $51
		dc.b $AE, $52, $AD, $51, $AE, $52, $B1, $54
		dc.b $B2, $56
		wSetMask	$08
		dc.b $4F, $4E, $4B, $C2, $4A, $49, $4A, $49
		dc.b $C6, $4A
		wLoopGoEnd

.00_03_01
		wSetVol		$28
		dc.b $C4
		wStopRead
		dc.b $C2
		wAddVol		$15
		wSetMask	$0C
		dc.b $A2, $43, $C5
		wStopRead
		dc.b $C2
		wAddVol		$F1
		dc.b $A2, $43, $C5
		wStopRead
		dc.b $C2
		wAddVol		$EC
		dc.b $A2, $43, $C5
		wStopRead
		dc.b $C2
		wAddVol		$F6
		dc.b $A2, $43
		wSetMask	$08
		wStopRead
		dc.b $C4
		wAddVol		$14
		dc.b $46, $48, $4F, $C7, $4E, $C4
		wAddVol		$0A
		dc.b $48, $CF
		wAddVol		$F6
		dc.b $4B, $C8, $4A
		wLoopGoEnd

.00_03_02
		wSetVol		$28
		dc.b $C4
		wStopRead
		wAddVol		$06
		wSetMask	$08
		dc.b $46, $45, $44, $43, $42, $41, $40, $C8
		wAddVol		$F6
		dc.b $48, $C4, $46, $45, $43, $CF, $4B, $C8
		dc.b $4D
		wLoopGoEnd

.00_03
		wSetType	$00
		wSetPat		$01
		dc.b $CA
		wLoopBackInit	$03
		wStopRead
		wLoopBack

.00_03_03
		wLoopGo		$00, .00_03_00
		dc.b $CA
		wStopRead
		wLoopGo		$00, .00_03_01
		dc.b $CA
		wStopRead
		wLoopGo		$00, .00_03_02
		wJump		.00_03_03

.00_04_01
.00_04_00
		wSetVol		$00
		dc.b $C6
		wTempoDiv	$10
		wAddVol		$17
		dc.b $3C, $43, $42, $C7, $46
		wSetTimerB	$A8
		wStopRead
		wLoopGoEnd

.00_04
		wSetType	$00
		dc.b $CA
		wLoopBackInit	$03
		wStopRead
		wLoopBack

.00_04_02
		dc.b $CA
		wLoopBackInit	$03
		wStopRead
		wLoopBack
		wLoopBackInit	$03
		wStopRead
		wLoopBack
		wSetMask	$0E
		wLoopGo		$00, .00_04_00
		dc.b $CA
		wStopRead
		wStopRead
		wLoopGo		$00, .00_04_01
		dc.b $CA
		wLoopBackInit	$01
		wStopRead
		wLoopBack
		wJump		.00_04_02

.00_05_00
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $60, $0D, $C5
		wStopRead
		dc.b $C4, $00
		wStopRead
		dc.b $0C, $C2
		wStopRead
		dc.b $00, $C4
		wStopRead
		dc.b $C2
		wAddVol		$F6
		dc.b $65
		wAddVol		$0A
		dc.b $0C
		wStopRead
		dc.b $C4
		wStopRead
		dc.b $C2, $0D
		wStopRead
		wAddVol		$F6
		dc.b $05, $C5
		wStopRead
		dc.b $C2
		wAddVol		$0A
		dc.b $0C, $0C, $0C
		wStopRead
		dc.b $0C, $C5
		wStopRead
		wLoopGoEnd

.00_05_01
		wSetVol		$00
		dc.b $C6
		wAddVol		$12
		dc.b $00, $C5, $0D, $C2, $00, $C6, $00, $C2
		wAddVol		$F6
		dc.b $05
		wStopRead
		dc.b $C4
		wAddVol		$0A
		dc.b $0C
		wStopRead
		dc.b $0C, $C6, $0C, $C2, $60, $0C, $0C, $C4
		dc.b $0C, $C2
		wAddVol		$F6
		dc.b $05, $C5
		wStopRead
		wLoopGoEnd

.00_05_02
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $00, $C5
		wStopRead
		dc.b $C2, $0D, $C4
		wStopRead
		dc.b $C2, $00, $00, $C5
		wStopRead
		dc.b $C2
		wAddVol		$F6
		dc.b $05
		wStopRead
		wAddVol		$0A
		dc.b $0C
		wStopRead
		dc.b $C4
		wStopRead
		dc.b $C2, $0C
		wStopRead
		dc.b $0E, $0E, $0D, $0D, $0C, $C5
		wStopRead
		dc.b $C2
		wAddVol		$F6
		dc.b $05, $C5
		wStopRead
		wLoopGoEnd

.00_05_03
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $60
		wAddVol		$0A
		dc.b $0F, $0F, $0F, $0F
		wAddVol		$F6
		dc.b $6D
		wAddVol		$0A
		dc.b $0F, $0F, $0F
		wAddVol		$F6
		dc.b $60
		wAddVol		$0A
		dc.b $0F
		wAddVol		$F6
		dc.b $60
		wAddVol		$0A
		dc.b $0F, $0F, $0F, $0F
		wAddVol		$EC
		dc.b $65
		wAddVol		$14
		dc.b $0F, $0F
		wAddVol		$F6
		dc.b $6C
		wAddVol		$0A
		dc.b $0F, $0F, $0F, $0F
		wAddVol		$F6
		dc.b $6C
		wAddVol		$0A
		dc.b $0F, $0F
		wAddVol		$F6
		dc.b $6C
		wAddVol		$0A
		dc.b $0F, $0F, $0F, $0F
		wAddVol		$F6
		dc.b $60, $6C
		wAddVol		$0A
		dc.b $0F
		wAddVol		$F6
		dc.b $6C
		wAddVol		$0A
		dc.b $0F
		wAddVol		$F6
		dc.b $6C
		wAddVol		$0A
		dc.b $0F, $0F
		wAddVol		$EC
		dc.b $65
		wAddVol		$14
		dc.b $0F, $0F, $0F, $0F
		wLoopGoEnd

.00_05
		wDrumChannel
		wLoopGo		$01, .00_05_00

.00_05_04
		wLoopGo		$02, .00_05_01
		wLoopGo		$00, .00_05_02
		wLoopGo		$03, .00_05_03
		wJump		.00_05_04

.00
		wHeaderMus	$88, $0200
		dw	.00_00
		dw	.00_01
		dw	.00_02
		dw	.00_03
		dw	.00_04
		dw	.00_05
		dw	$0000

.05_00_00
		wSetVol		$02
		dc.b $C0
		wTempoDiv	$10
		wAddVol		$12
		dc.b $3B
		wSetTimerB	$42
		dc.b $3C, $C0, $3B
		wSetTimerB	$2A
		dc.b $3C, $C4, $37, $39, $37, $C0, $3B
		wSetTimerB	$42
		dc.b $3C, $C0, $3B
		wSetTimerB	$2A
		dc.b $3C, $C7
		wAddVol		$FB
		dc.b $35
		wLoopGoEnd

.05_00_01
		wSetVol		$02
		dc.b $C0
		wTempoDiv	$10
		wAddVol		$12
		dc.b $3B
		wSetTimerB	$42
		dc.b $3C, $C0, $3B
		wSetTimerB	$2A
		dc.b $3C, $C4, $37, $39, $37, $C0, $3B
		wSetTimerB	$42
		dc.b $3C, $C0, $3B
		wSetTimerB	$2A
		dc.b $3C, $C4
		wAddVol		$FB
		dc.b $35, $34, $32
		wLoopGoEnd

.05_00_02
		wSetVol		$02
		wSetTimerB	$04
		wTempoDiv	$10
		wAddVol		$17
		dc.b $2F
		wSetTimerB	$44
		dc.b $30
		wSetTimerB	$04
		dc.b $2F
		wSetTimerB	$2C
		dc.b $30, $C4
		wStopRead
		wSetTimerB	$04
		dc.b $36
		wSetTimerB	$2C
		dc.b $37
		wSetTimerB	$04
		dc.b $2F
		wSetTimerB	$44
		dc.b $30
		wSetTimerB	$04
		dc.b $2F
		wSetTimerB	$2C
		dc.b $30, $C4, $37, $35, $34
		wSetTimerB	$04
		dc.b $31
		wSetTimerB	$44
		dc.b $32, $C6, $30, $C4, $2F, $C6, $2D
		wSetTimerB	$04
		dc.b $36
		wSetTimerB	$44
		dc.b $37
		wSetTimerB	$04
		dc.b $36
		wSetTimerB	$2C
		dc.b $37, $C4
		wStopRead
		wSetTimerB	$04
		dc.b $31
		wSetTimerB	$2C
		dc.b $32, $C7, $35, $C6, $30, $C4
		wStopRead
		dc.b $C6, $35
		wSetTimerB	$04
		dc.b $2F
		wSetTimerB	$44
		dc.b $30, $C4, $30
		wStopRead
		dc.b $34
		wSetTimerB	$04
		dc.b $36
		wSetTimerB	$14
		dc.b $37, $C4, $34, $C7, $32, $C4, $32, $C7
		dc.b $34, $C4, $34, $C7, $35, $C4, $35, $C6
		dc.b $37, $C4
		wAddVol		$FB
		dc.b $2B, $2C
		wLoopGoEnd

.05_00_03
		wSetVol		$02
		dc.b $C7
		wTempoDiv	$10
		wAddVol		$17
		dc.b $2D, $C4, $2D, $C7, $34, $C4, $2D, $C7
		dc.b $2B, $C4, $2B, $C6, $32, $2F, $C7, $2D
		dc.b $C4, $2D, $C7, $34, $C4, $2D, $C7, $2B
		dc.b $C4, $2B, $C6, $32, $34, $C7, $35, $C4
		dc.b $35, $C6, $34, $32, $C7, $30, $C4, $30
		dc.b $C6, $2B, $30, $C7, $32, $C4, $32, $C6
		dc.b $2D, $32, $C8
		wAddVol		$05
		dc.b $34, $32, $31, $2F
		wLoopGoEnd

.05_00_04
		wSetVol		$02
		dc.b $C7
		wTempoDiv	$10
		wAddVol		$17
		dc.b $2D, $C4, $2D
		wStopRead
		dc.b $2D, $2F, $31, $C7, $32, $C4, $32
		wStopRead
		dc.b $32, $31, $2F, $C7, $2D, $C4, $2D
		wStopRead
		dc.b $2F, $31, $32, $C7, $34, $C4, $28, $34
		dc.b $32, $31, $2F, $C7, $2D, $C4, $2D
		wStopRead
		dc.b $2D, $2F, $31, $C7, $32, $C4, $32
		wStopRead
		dc.b $32, $31, $2F, $C7, $2D, $C4, $34, $C6
		dc.b $2B, $2F, $C4
		wAddVol		$F6
		dc.b $2D, $C8
		wStopRead
		dc.b $C6
		wAddVol		$0A
		dc.b $2B, $C4
		wStopRead
		wLoopGoEnd

.05_00
		wSetType	$00
		wSetMask	$01
		wSetPat		$09
		wLoopGo		$02, .05_00_00
		wLoopGo		$00, .05_00_01

.05_00_05
		wLoopGo		$00, .05_00_02
		wLoopGo		$00, .05_00_03
		wLoopGo		$00, .05_00_04
		wJump		.05_00_05

.05_01_01
		wSetVol		$18
		dc.b $C6
		wTempoDiv	$0D
		wAddVol		$06
		dc.b $48, $C4, $48, $48, $C6, $4A, $C4, $48
		dc.b $4A, $C6, $4D, $C4, $4C, $4A, $C6, $4C
		dc.b $48, $C7, $45, $C4, $4C, $C7, $4A, $C4
		dc.b $48, $C7, $47, $C4, $4A, $43
		wStopRead
		dc.b $43, $43, $C6, $4A, $C4, $4A, $4C, $C6
		dc.b $4D, $C4, $4C, $4A, $C6, $4F, $4C, $4A
		dc.b $48, $C8, $4A, $4C, $4D, $4F
		wLoopGoEnd
	; Unused
		dc.b $F4, $18, $C4, $F1, $10, $F5, $06, $39
	; Unused
		dc.b $39, $40, $39, $40, $39, $40, $39, $FA
	; Unused
		dc.b $39, $40, $39, $42, $40, $3E, $40, $FA
		dc.b $39, $40, $39, $40, $39, $40, $39, $FF

.05_01_00
.05_01_02
		wSetVol		$18
		dc.b $C9
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$06
		dc.b $43, $43
		wLoopGoEnd

.05_01
		wSetType	$00
		wSetMask	$0E
		wSetPat		$00
		dc.b $CA
		wLoopBackInit	$06
		wStopRead
		wLoopBack
		wLoopGo		$00, .05_01_00

.05_01_03
		wLoopGo		$00, .05_01_01
		dc.b $CA
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		wLoopGo		$00, .05_01_02
		wJump		.05_01_03

.05_02_02
		wSetVol		$04
		dc.b $C9
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$21
		dc.b $40, $43
		wLoopGoEnd

.05_02_03
		wSetVol		$04
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$21
		dc.b $45
		wStopRead
		dc.b $C6, $48, $47, $48, $4A, $48, $47, $43
		wLoopGoEnd

.05_02_04
		wSetVol		$04
		dc.b $C4
		wStopRead
		wTempoDiv	$10
		wAddVol		$21
		dc.b $41, $40, $41
		wAddVol		$F6
		dc.b $40, $41
		wAddVol		$F6
		dc.b $40, $41
		wStopRead
		wAddVol		$14
		dc.b $40, $3E, $40
		wAddVol		$F6
		dc.b $3E, $40
		wAddVol		$F6
		dc.b $3E, $40
		wStopRead
		wAddVol		$14
		dc.b $41, $40, $41
		wAddVol		$F6
		dc.b $40, $41
		wAddVol		$F6
		dc.b $40, $41
		wAddVol		$0A
		dc.b $40
		wTempoDiv	$08
		wAddVol		$0A
		dc.b $47, $4C, $40, $47, $4C, $40, $47, $4C
		dc.b $40, $47, $4C, $40, $C7
		wStopRead
		wLoopGoEnd
	; Unused
		dc.b $F4, $04, $C4, $F1, $10, $F5, $17, $45
	; Unused
		dc.b $FA, $45, $49, $4A, $4C, $FA, $C6, $50
	; Unused
		dc.b $C4, $51, $50, $4C, $FA, $4C, $4A, $49
	; Unused
		dc.b $45, $FA, $45, $FA, $45, $44, $45, $40
		dc.b $FF

.05_02_05
.05_02_01
		wSetVol		$04
		dc.b $CA
		wStopRead
		wLoopGoEnd

.05_02
		wSetType	$00
		wSetMask	$08
		wSetPat		$1F
		wSetFreq	$0020
		wLoopGo		$00, .05_02_00

.05_02_06
		wSetFreq	$0000
		wSetPat		$21
		wLoopGo		$00, .05_02_01
		dc.b $CA
		wLoopBackInit	$05
		wStopRead
		wLoopBack
		wLoopGo		$00, .05_02_02
		wLoopGo		$01, .05_02_03
		wLoopGo		$00, .05_02_04
		dc.b $CA
		wLoopBackInit	$06
		wStopRead
		wLoopBack
		wLoopGo		$00, .05_02_05
		wJump		.05_02_06

.05_03_00
.05_02_00
		wSetVol		$0C
		wSetTimerW	$0120
		wTempoDiv	$10
		wAddVol		$21
		dc.b $4F, $C5
		wAddVol		$F6
		dc.b $4D
		wAddVol		$03
		dc.b $4C, $C4
		wAddVol		$02
		dc.b $4A
		wSetTimerW	$0120
		wAddVol		$05
		dc.b $4C, $C5, $48, $47, $C4, $45
		wSetTimerW	$0120
		dc.b $43, $C5
		wAddVol		$F6
		dc.b $41
		wAddVol		$03
		dc.b $40, $C4
		wAddVol		$02
		dc.b $3E, $CA
		wAddVol		$05
		dc.b $40
		wAddVol		$03
		wTempoDiv	$0A
		dc.b $CA, $43
		wLoopGoEnd

.05_03_02
		wSetVol		$04
		wSetPat		$1F
		dc.b $C8
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $51, $C6, $4C, $51, $4F, $4D, $4C, $4A
		dc.b $C8, $51, $C6, $4C, $51, $C8, $53, $4C
		dc.b $4D, $C6, $48, $51, $4F, $4C, $4A, $48
		dc.b $C8, $4A, $C7, $48, $C4, $4A
		wSetTimerW	$0120
		wTempoDiv	$10
		dc.b $4C, $C8
		wStopRead
		wLoopGoEnd

.05_03_01
		wSetVol		$04
		dc.b $CA
		wStopRead
		wLoopGoEnd

.05_03_03
		wSetVol		$04
		wSetPat		$27
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$1B
		dc.b $39
		wAddVol		$FC
		dc.b $39
		wAddVol		$04
		dc.b $40, $39, $40, $39, $40, $C6, $39, $C4
		dc.b $39
		wAddVol		$FC
		dc.b $40
		wAddVol		$04
		dc.b $39, $C0
		wAddVol		$FC
		dc.b $41, $C3
		wAddVol		$04
		dc.b $42, $C4, $40, $3E, $40
		wStopRead
		dc.b $39, $40, $39, $40, $39
		wAddVol		$FC
		dc.b $40, $39
		wStopRead
		dc.b $C6
		wAddVol		$FE
		dc.b $3B
		wStopRead
		dc.b $C0
		wAddVol		$02
		dc.b $3C, $C3
		wAddVol		$04
		dc.b $3D, $C4, $3B, $C6, $39, $C4, $39, $40
		dc.b $39, $40, $39, $40, $C6, $39, $C4, $39
		dc.b $40, $39, $C0
		wAddVol		$FC
		dc.b $41, $C3
		wAddVol		$04
		dc.b $42, $C4, $40, $3E, $40
		wStopRead
		dc.b $40, $40, $39, $C0
		wAddVol		$F7
		dc.b $3A, $C3
		wAddVol		$09
		dc.b $3B, $C4, $39, $C0
		wAddVol		$F7
		dc.b $3A
		wSetTimerB	$2A
		wAddVol		$09
		dc.b $3B, $C4, $39
		wSetTimerB	$A8
		wStopRead
		wLoopGoEnd

.05_03
		wSetType	$00
		wSetMask	$04
		wSetPat		$1F
		wLoopGo		$00, .05_03_00

.05_03_04
		wSetMask	$0C
		wLoopGo		$00, .05_03_01
		dc.b $CA
		wLoopBackInit	$06
		wStopRead
		wLoopBack
		wLoopGo		$00, .05_03_02
		wLoopGo		$00, .05_03_03
		wJump		.05_03_04

.05_04_00
		wSetVol		$04
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$17
		dc.b $30, $37, $39, $37, $3C, $37, $39, $37
		dc.b $30, $35, $39, $35, $41, $C2, $35, $C4
		dc.b $40, $C2, $35, $C4, $3C
		wLoopGoEnd

.05_04_02
		wSetVol		$04
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$1D
		dc.b $30, $37, $39, $C6, $40, $C4, $37, $39
		dc.b $C6, $40, $C4, $37, $39, $C6, $40, $C4
		dc.b $37, $39, $40, $32, $35, $39, $C6, $3E
		dc.b $C4, $39, $35, $C6, $3C, $C4, $39, $35
		dc.b $C6, $3B, $C4, $39, $3E, $37, $35, $37
		dc.b $39, $C6, $40, $C4, $35, $39, $C6, $40
		dc.b $C4, $37, $39, $C6, $40, $C4, $37, $39
		dc.b $40, $3E, $39, $35, $32, $40, $3B, $37
		dc.b $34, $41, $3C, $39, $35, $43, $3E, $3B
		dc.b $37
		wLoopGoEnd

.05_04_01
		wSetVol		$04
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$17
		dc.b $30, $37, $39, $37, $3C, $37, $39, $37
		dc.b $C2
		wAddVol		$0F
		dc.b $48, $41, $3C, $35
		wAddVol		$FB
		dc.b $48, $41, $3C, $35
		wAddVol		$FB
		dc.b $48, $41, $3C, $35
		wAddVol		$FB
		dc.b $48, $41, $3C, $35
		wLoopGoEnd

.05_04_03
		wSetVol		$04
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$1C
		dc.b $39, $40, $48, $40, $47, $45, $43, $40
		dc.b $37, $3E, $47, $3E, $45, $3E, $C0, $43
		dc.b $42, $C2, $43, $C4, $3E, $39, $40, $48
		dc.b $40, $47, $45, $43, $40, $37, $3E, $47
		dc.b $3E, $45, $3E, $32, $34, $35, $3C, $41
		dc.b $C8, $48, $C4
		wStopRead
		dc.b $34, $3C, $40, $C8, $47, $C4
		wStopRead
		dc.b $C0, $45, $C3, $48, $C4, $47, $43, $40
		dc.b $3E, $3C, $3B, $37, $40, $47, $44, $40
		dc.b $3E, $47, $44, $3E, $3D, $47, $44, $3D
		dc.b $3B, $47, $44, $3B
		wLoopGoEnd

.05_04_04
		wSetVol		$04
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$21
		dc.b $39, $40, $45, $40, $44, $40, $45, $40
		dc.b $39, $3E, $45, $3E, $44, $3E, $42, $3E
		wLoopGoEnd

.05_04_05
		wSetVol		$04
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$21
		dc.b $39, $40, $45, $40, $3E, $3B, $37, $3B
		dc.b $94, $39, $CF
		wStopRead
		dc.b $C6
		wTempoDiv	$0D
		dc.b $9E, $43
		wLoopGoEnd

.05_04
		wSetType	$00
		wSetMask	$02
		wSetPat		$27
		wLoopGo		$02, .05_04_00
		wLoopGo		$00, .05_04_01

.05_04_06
		wLoopGo		$00, .05_04_02
		wLoopGo		$00, .05_04_03
		wLoopGo		$02, .05_04_04
		wLoopGo		$00, .05_04_05
		wJump		.05_04_06

.05_05_01
		wSetVol		$04
		dc.b $C5
		wAddVol		$08
		dc.b $07, $C2, $12, $C4, $72, $09, $C2, $07
		wStopRead
		dc.b $12
		wStopRead
		wAddVol		$0A
		dc.b $6D, $09, $0D, $6C
		wAddVol		$F6
		dc.b $07, $07
		wAddVol		$0A
		dc.b $6C
		wAddVol		$F6
		dc.b $67, $09, $07
		wLoopGoEnd

.05_05_06
.05_05_02
.05_05_04
		wSetVol		$04
		dc.b $C5
		wAddVol		$12
		dc.b $60
		wAddVol		$F6
		dc.b $07, $C2, $12, $C4, $72, $09, $60, $07
		dc.b $12, $09, $C2, $65, $07, $07, $67, $09
		dc.b $07
		wLoopGoEnd

.05_05_03
.05_05_09
.05_05_07
		wSetVol		$04
		dc.b $C4
		wAddVol		$12
		dc.b $60
		wAddVol		$F6
		dc.b $07, $C2
		wStopRead
		dc.b $12, $C4, $65, $72, $09, $C2, $07
		wStopRead
		dc.b $C4, $60, $12, $09, $C2, $65, $07, $07
		dc.b $67, $09, $07, $C4
		wAddVol		$0A
		dc.b $60
		wAddVol		$F6
		dc.b $07, $C2
		wStopRead
		dc.b $12, $C4, $65, $72, $09, $C2, $07
		wStopRead
		dc.b $C4, $60, $12, $6D, $09, $C2, $6C, $07
		dc.b $07, $6C, $67, $09, $07
		wLoopGoEnd

.05_05_08
		wSetVol		$04
		dc.b $C2
		wAddVol		$12
		dc.b $60
		wAddVol		$F6
		dc.b $07, $C4
		wStopRead
		dc.b $C2, $12, $C4, $65, $09, $C2, $60, $07
		wStopRead
		dc.b $12
		wStopRead
		dc.b $C4, $09, $C2, $65, $07, $07
		wAddVol		$0A
		dc.b $60
		wAddVol		$F6
		dc.b $67, $09, $07
		wLoopGoEnd

.05_05_05
		wSetVol		$04
		dc.b $C5
		wAddVol		$12
		dc.b $60
		wAddVol		$F6
		dc.b $07, $C2, $12, $C4, $72, $09, $60, $07
		dc.b $12, $C2
		wAddVol		$0A
		dc.b $60, $6E, $09, $0E, $65, $6D
		wAddVol		$F6
		dc.b $07, $07, $6C, $67, $09, $07
		wLoopGoEnd

.05_05_00
		wSetVol		$04
		dc.b $C2
		wAddVol		$08
		dc.b $07, $C4
		wStopRead
		dc.b $C2, $12, $C4, $72, $09, $C2, $07
		wStopRead
		dc.b $12
		wStopRead
		dc.b $C4, $09, $C2, $07, $07, $67, $09, $07
		wLoopGoEnd

.05_05
		wDrumChannel
		wLoopGo		$06, .05_05_00
		wLoopGo		$00, .05_05_01

.05_05_0A
		wLoopGo		$05, .05_05_02
		wLoopGo		$00, .05_05_03
		wLoopGo		$02, .05_05_04
		wLoopGo		$00, .05_05_05
		wLoopGo		$02, .05_05_06
		wLoopGo		$00, .05_05_07
		wLoopGo		$05, .05_05_08
		wLoopGo		$00, .05_05_09
		wJump		.05_05_0A

.05
		wHeaderMus	$88, $01CC
		dw	.05_00
		dw	.05_01
		dw	.05_02
		dw	.05_03
		dw	.05_04
		dw	.05_05
		dw	$0000

.06_00_01
.06_00_06
		wSetVol		$07
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$10
		dc.b $28, $28, $34, $34, $28, $28, $34, $34
		wLoopGoEnd

.06_00_00
		wSetVol		$07
		dc.b $C6
		wTempoDiv	$10
		wAddVol		$10
		dc.b $34, $C4, $35, $38, $C6, $39, $C4, $38
		dc.b $35, $C9, $34, $C4, $35, $C2, $38, $35
		dc.b $C9, $34, $C4, $32, $C2, $30, $32, $CA
		dc.b $34
		wLoopGoEnd

.06_00_02
.06_00_05
		wSetVol		$07
		dc.b $C2
		wTempoDiv	$0C
		wAddVol		$10
		dc.b $3B, $35, $32, $30, $35, $32, $30, $2F
		dc.b $32, $30, $2F, $2D, $34
		wAddVol		$FB
		dc.b $34
		wAddVol		$FB
		dc.b $34
		wAddVol		$FB
		dc.b $34
		wLoopGoEnd

.06_00_03
		wSetVol		$07
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$10
		dc.b $28, $2C, $2D, $2F, $32, $2F, $32, $34
		dc.b $28, $2C, $2D, $34, $32, $2F
		wAddVol		$F6
		dc.b $2D, $2C
		wLoopGoEnd

.06_00_04
		wSetVol		$07
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$10
		dc.b $29, $29, $35, $35, $29, $29, $35, $35
		dc.b $28
		wSetTimerB	$A8
		wStopRead
		dc.b $C4, $2D, $2D, $39, $39, $2D, $2D, $39
		dc.b $39
		wLoopGoEnd

.06_00
		wSetType	$00
		wSetMask	$01
		wSetPat		$07
		wLoopGo		$00, .06_00_00

.06_00_07
		wLoopGo		$02, .06_00_01
		wLoopGo		$00, .06_00_02
		wLoopGo		$03, .06_00_03
		wLoopGo		$00, .06_00_04
		wLoopGo		$00, .06_00_05
		wLoopGo		$03, .06_00_06
		wJump		.06_00_07

.06_01_00
		wSetVol		$1B
		dc.b $C4
		wTempoDiv	$0A
		wAddVol		$06
		dc.b $A0, $48, $A0, $48, $40, $40, $A0, $44
		dc.b $A0, $44, $40, $40
		wLoopGoEnd

.06_01_06
.06_01_01
		wSetVol		$1B
		dc.b $C6
		wTempoDiv	$10
		wAddVol		$FC
		dc.b $40, $C4, $41, $44, $C6, $45, $C4, $44
		dc.b $41, $C9, $40, $C4, $41, $C2, $44, $41
		dc.b $C9, $40, $C4, $3E, $C2, $3C, $3E
		wLoopGoEnd

.06_01_03
		wSetVol		$1B
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$04
		dc.b $47, $48, $C2
		wTempoDiv	$0C
		dc.b $4B, $4C, $C4
		wTempoDiv	$0D
		dc.b $48, $4C, $4B, $48, $4B, $48, $47, $48
		dc.b $47, $C2
		wTempoDiv	$0C
		dc.b $48, $47, $45, $42, $C4
		wTempoDiv	$0D
		wAddVol		$EE
		dc.b $47, $47
		wLoopGoEnd

.06_01_04
		wSetVol		$1B
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$04
		dc.b $47, $48, $C2
		wTempoDiv	$0C
		dc.b $4B, $4C, $C4
		wTempoDiv	$0D
		dc.b $48, $4C, $4B, $48, $4B, $48, $47, $48
		dc.b $47, $C2
		wTempoDiv	$0C
		dc.b $48, $47, $45, $42, $C4
		wTempoDiv	$0D
		wAddVol		$F8
		dc.b $40, $3F
		wLoopGoEnd

.06_01_05
		wSetVol		$1B
		dc.b $C4
		wTempoDiv	$0A
		wAddVol		$10
		dc.b $A8, $4D, $A8, $4D
		wAddVol		$F6
		dc.b $A8, $4D, $A8, $4D
		wAddVol		$F6
		dc.b $A8, $4D
		wAddVol		$F6
		dc.b $A8, $4D, $A8, $4D, $A8, $4D
		wAddVol		$F3
		dc.b $A7, $4C
		wSetTimerB	$A8
		wStopRead
		dc.b $C4
		wAddVol		$2B
		dc.b $AD, $51, $AD, $51
		wAddVol		$F6
		dc.b $AD, $51, $AD, $51
		wAddVol		$F6
		dc.b $AD, $51, $AD, $51
		wAddVol		$F6
		dc.b $AD, $51, $AD, $51
		wAddVol		$F6
		dc.b $AC, $50
		wSetTimerB	$A8
		wStopRead
		wLoopGoEnd

.06_01_02
		wSetVol		$1B
		dc.b $C2
		wTempoDiv	$10
		wAddVol		$FC
		dc.b $4C, $47, $44, $41, $47, $44, $41, $40
		dc.b $44, $41, $40, $3E, $C0
		wAddVol		$05
		dc.b $40
		wAddVol		$05
		dc.b $41
		wAddVol		$FB
		dc.b $40
		wAddVol		$FB
		dc.b $41
		wAddVol		$FB
		dc.b $40
		wAddVol		$FB
		dc.b $41
		wAddVol		$FB
		dc.b $40
		wAddVol		$FB
		dc.b $41
		wLoopGoEnd

.06_01_07
		wSetVol		$1B
		dc.b $CA
		wTempoDiv	$10
		wAddVol		$FC
		dc.b $40
		wLoopGoEnd

.06_01
		wSetType	$00
		wSetMask	$0E
		wSetPat		$1F
		wLoopGo		$03, .06_01_00

.06_01_08
		wLoopGo		$00, .06_01_01
		wLoopGo		$00, .06_01_02
		dc.b $CA
		wStopRead
		wStopRead
		wLoopGo		$00, .06_01_03
		dc.b $CA
		wStopRead
		wStopRead
		wLoopGo		$00, .06_01_04
		wLoopGo		$00, .06_01_05
		wLoopGo		$00, .06_01_06
		wLoopGo		$00, .06_01_07
		wJump		.06_01_08

.06_02_07
.06_02_05
.06_02_00
.06_02_02
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$21
		dc.b $40, $44, $45, $47, $40, $44, $45, $47
		wLoopGoEnd
	; Unused
		dc.b $F4, $00, $C4, $F1, $0D, $F5, $21, $40
	; Unused
		dc.b $F5, $FB, $B8, $53, $F5, $FB, $40, $B3
	; Unused
		dc.b $50, $F5, $FB, $40, $AC, $50, $F5, $FB
		dc.b $40, $F5, $F6, $AC, $47, $FF

.06_02_03
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $4C, $4D, $C2
		wTempoDiv	$0C
		dc.b $50, $51, $C4
		wTempoDiv	$0D
		dc.b $4D, $51, $50, $4D, $50, $4D, $4C, $4D
		dc.b $4C, $C2
		wTempoDiv	$0C
		dc.b $4D, $4C, $4A, $47, $C4
		wTempoDiv	$0D
		wAddVol		$F1
		dc.b $4C, $4C
		wLoopGoEnd

.06_02_04
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$17
		dc.b $4C, $C0, $4D, $4D, $4D, $4D, $50, $50
		dc.b $51, $51, $4D, $4D, $C2
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $51, $50, $C0
		wTempoDiv	$10
		dc.b $4D, $4D, $4D, $4D, $C4
		wTempoDiv	$0D
		dc.b $50, $4D, $C0
		wTempoDiv	$10
		dc.b $4C, $4C, $4C, $4C, $C4
		wTempoDiv	$0D
		dc.b $4D, $4C, $C2
		wTempoDiv	$0C
		dc.b $4D, $C0
		wTempoDiv	$10
		dc.b $4C, $4C, $C2
		wTempoDiv	$0C
		dc.b $4A, $47, $C0
		wTempoDiv	$10
		wAddVol		$05
		dc.b $45, $45, $C2
		wStopRead
		dc.b $C0, $44, $44, $44, $44
		wLoopGoEnd

.06_02_01
.06_02_08
.06_02_06
		wSetVol		$00
		dc.b $C2
		wTempoDiv	$10
		wAddVol		$17
		dc.b $45, $44, $45, $51, $50, $4D, $4C, $4A
		dc.b $45, $44, $45, $4C, $4A, $47, $40, $40
		wLoopGoEnd

.06_02
		wSetType	$00
		wSetMask	$0E
		wSetPat		$26
		wSetFreq	$F400
		dc.b $CA
		wLoopBackInit	$03
		wStopRead
		wLoopBack

.06_02_09
		wLoopGo		$00, .06_02_00
		wLoopGo		$00, .06_02_01
		wLoopGo		$00, .06_02_02
		dc.b $CA
		wStopRead
		wLoopGo		$02, .06_02_03
		wLoopGo		$00, .06_02_04
		dc.b $CA
		wLoopBackInit	$03
		wStopRead
		wLoopBack
		wLoopGo		$00, .06_02_05
		wLoopGo		$00, .06_02_06
		wLoopGo		$00, .06_02_07
		wLoopGo		$00, .06_02_08
		wJump		.06_02_09

.06_03_01
		wSetVol		$1B
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$06
		dc.b $40
		wAddVol		$FB
		dc.b $B8, $53
		wAddVol		$FB
		dc.b $40, $B3, $50
		wAddVol		$FB
		dc.b $40
		wAddVol		$FB
		dc.b $AC, $50
		wAddVol		$FB
		dc.b $40, $AC, $47
		wLoopGoEnd

.06_03_02
		wSetVol		$1B
		dc.b $C9
		wTempoDiv	$10
		wAddVol		$FC
		dc.b $41, $C6, $40, $41, $C4, $40, $41, $C6
		dc.b $45, $C4, $44, $45
		wSetTimerB	$A8
		dc.b $47, $C2, $46, $45, $C8, $44, $40, $C9
		dc.b $3E, $C6, $40, $41, $45, $44, $41, $CF
		dc.b $40, $C2, $3F, $3E, $C4, $3D, $3C, $C7
		dc.b $3B, $C2, $3A, $39, $C6, $38, $34
		wLoopGoEnd

.06_03_03
		wSetVol		$1B
		dc.b $CA
		wStopRead
		dc.b $C2
		wTempoDiv	$10
		wAddVol		$FC
		dc.b $40, $41, $44, $47, $44, $47, $4A, $4D
		dc.b $47, $4A, $4D, $50, $C0
		wAddVol		$14
		dc.b $4B
		wAddVol		$FB
		dc.b $4C
		wAddVol		$FB
		dc.b $4B
		wAddVol		$FB
		dc.b $4C
		wAddVol		$FB
		dc.b $4B
		wAddVol		$05
		dc.b $4C
		wAddVol		$05
		dc.b $4B
		wAddVol		$05
		dc.b $4C, $CA
		wStopRead
		wLoopGoEnd

.06_03_04
		wSetVol		$1B
		dc.b $C2
		wTempoDiv	$10
		wAddVol		$FC
		dc.b $4C, $47, $44, $41, $47, $44, $41, $40
		dc.b $44, $41, $40, $3E, $C0
		wAddVol		$08
		dc.b $40
		wAddVol		$08
		dc.b $41
		wAddVol		$FB
		dc.b $40
		wAddVol		$FA
		dc.b $41
		wAddVol		$FA
		dc.b $40
		wAddVol		$FA
		dc.b $41
		wAddVol		$FA
		dc.b $40
		wAddVol		$F8
		dc.b $41
		wLoopGoEnd

.06_03_00
.06_03_05
		wSetVol		$1B
		dc.b $CA
		wStopRead
		wLoopGoEnd

.06_03
		wSetType	$00
		wSetMask	$0E
		dc.b $CA
		wLoopBackInit	$03
		wStopRead
		wLoopBack

.06_03_06
		wSetPat		$01
		wLoopGo		$02, .06_03_00
		wLoopGo		$00, .06_03_01
		wLoopGo		$00, .06_03_02
		wSetPat		$25
		wAddFreq	$F400
		wLoopGo		$00, .06_03_03
		wLoopGo		$00, .06_03_04
		wAddFreq	$0C00
		wLoopGo		$03, .06_03_05
		wJump		.06_03_06

.06_04_00
		wSetVol		$00
		dc.b $C9
		wStopRead
		dc.b $C2
		wAddVol		$12
		dc.b $0C, $0D, $0C
		wStopRead
		wLoopGoEnd

.06_04_01
.06_04_0B
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $0E, $C4
		wStopRead
		dc.b $C2, $0D
		wAddVol		$F6
		dc.b $05
		wStopRead
		wAddVol		$0A
		dc.b $00
		wStopRead
		dc.b $0C, $0C
		wStopRead
		dc.b $0D
		wAddVol		$F6
		dc.b $05
		wStopRead
		dc.b $05
		wStopRead
		wLoopGoEnd

.06_04_06
.06_04_02
.06_04_04
.06_04_08
		wSetVol		$00
		dc.b $C4
		wAddVol		$12
		dc.b $0C, $C2, $6C
		wAddVol		$0A
		dc.b $0F
		wAddVol		$F6
		dc.b $0D
		wStopRead
		dc.b $0C, $C4
		wAddVol		$0A
		dc.b $0F
		wStopRead
		dc.b $C2, $6F
		wAddVol		$F6
		dc.b $0D, $0D, $C4
		wStopRead
		wAddVol		$F6
		dc.b $65
		wAddVol		$14
		dc.b $0F
		wLoopGoEnd

.06_04_09
.06_04_07
.06_04_05
.06_04_03
		wSetVol		$00
		dc.b $C4
		wAddVol		$12
		dc.b $0C, $C2, $0C, $0D
		wSetTimerB	$54
		wStopRead
		dc.b $C2, $0D, $C4
		wAddVol		$F6
		dc.b $05, $C2, $05
		wStopRead
		wLoopGoEnd

.06_04_0A
		wSetVol		$00
		dc.b $C4
		wAddVol		$12
		dc.b $00, $00, $C6
		wStopRead
		dc.b $C4, $00, $00
		wStopRead
		dc.b $C2, $05, $05
		wAddVol		$F6
		dc.b $05, $C5
		wStopRead
		dc.b $C2
		wAddVol		$0A
		dc.b $0C, $0C, $C4
		wStopRead
		dc.b $C2, $0E
		wStopRead
		dc.b $0C
		wStopRead
		dc.b $0C, $0C, $C4
		wStopRead
		dc.b $00, $00, $C6
		wStopRead
		dc.b $C4, $00, $00
		wStopRead
		dc.b $C2, $05, $05
		wLoopGoEnd

.06_04
		wDrumChannel
		dc.b $CA
		wStopRead
		wStopRead
		wStopRead
		wLoopGo		$00, .06_04_00

.06_04_0C
		wLoopGo		$03, .06_04_01
		wLoopGo		$00, .06_04_02
		wLoopGo		$00, .06_04_03
		wLoopGo		$00, .06_04_04
		wLoopGo		$00, .06_04_05
		wLoopGo		$00, .06_04_06
		wLoopGo		$00, .06_04_07
		wLoopGo		$00, .06_04_08
		wLoopGo		$00, .06_04_09
		wLoopGo		$00, .06_04_0A
		wLoopGo		$04, .06_04_0B
		wJump		.06_04_0C

.06
		wHeaderMus	$88, $0199
		dw	.06_00
		dw	.06_01
		dw	.06_02
		dw	.06_03
		dw	.06_04
		dw	$0000

.07_00_00
.07_00_01
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$09
		wAddVol		$03
		dc.b $24, $24, $2A, $2B, $27, $27, $2A, $2B
		wLoopGoEnd

.07_00_02
		wSetVol		$00
		dc.b $C2
		wTempoDiv	$0C
		wAddVol		$03
		dc.b $28, $27
		wAddVol		$12
		dc.b $26, $25
		wAddVol		$FD
		dc.b $24
		wStopRead
		wAddVol		$FB
		dc.b $23, $22
		wAddVol		$FB
		dc.b $21
		wAddVol		$FB
		dc.b $20
		wAddVol		$FE
		dc.b $1F, $C5
		wStopRead
		dc.b $C4
		wAddVol		$FF
		dc.b $1F
		wLoopGoEnd
	; Unused
		dc.b $F4, $00, $C4, $F1, $09, $F5, $17, $32
		dc.b $32, $38, $3B, $36, $36, $3B, $3E, $FF

.07_00
.07_00_03
		wSetType	$00
		wSetMask	$01
		wSetPat		$23
		wLoopGo		$07, .07_00_00
		wLoopGo		$06, .07_00_01
		wLoopGo		$00, .07_00_02
		wJump		.07_00_03

.07_01_00
.07_01_01
		wSetVol		$00
		wSetTimerB	$A8
		wTempoDiv	$10
		wAddVol		$17
		dc.b $30, $C2, $2F, $2E
		wSetTimerB	$A8
		dc.b $2C, $C2, $27, $2A, $CA, $2B
		wLoopGoEnd

.07_01_04
.07_01_02
		wSetVol		$00
		dc.b $C8
		wAddVol		$0D
		dc.b $24, $2A, $C9, $2B, $C6, $2A
		wLoopGoEnd

.07_01_03
		wSetVol		$00
		dc.b $C5
		wAddVol		$0D
		dc.b $30, $2B, $C4, $30, $C5, $2E, $27, $C4
		dc.b $2E, $C5, $2D, $26, $C4, $2D, $C5, $2C
		dc.b $25, $C4, $2C
		wLoopGoEnd

.07_01_05
		wSetVol		$00
		dc.b $C5
		wAddVol		$0D
		dc.b $30, $2B, $C4, $30, $C5, $2E, $27, $C4
		dc.b $2E
		wSetPat		$23
		dc.b $C2
		wAddVol		$05
		dc.b $39, $37
		wAddVol		$FE
		dc.b $38, $37
		wAddVol		$FD
		dc.b $36
		wStopRead
		dc.b $35, $32
		wAddVol		$FE
		dc.b $33
		wAddVol		$FD
		dc.b $34
		wTempoDiv	$0C
		wAddVol		$FE
		dc.b $35, $C5
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$FD
		dc.b $37
		wTempoDiv	$10
		wLoopGoEnd

.07_01
.07_01_06
		wSetType	$00
		wSetMask	$0E
		wSetPat		$23
		wSetFreq	$0020
		wLoopGo		$00, .07_01_00
		dc.b $CA
		wStopRead
		wLoopGo		$00, .07_01_01
		dc.b $CA
		wStopRead
		wSetPat		$28
		wLoopGo		$00, .07_01_02
		wLoopGo		$00, .07_01_03
		wLoopGo		$00, .07_01_04
		wLoopGo		$00, .07_01_05
		wJump		.07_01_06

.07_02_00
.07_02_02
		wSetVol		$00
		wSetTimerB	$A8
		wTempoDiv	$10
		wAddVol		$17
		dc.b $3C, $C2, $3B, $3A
		wSetTimerB	$A8
		dc.b $38, $C2, $33, $36, $CA, $37
		wLoopGoEnd

.07_02_01
.07_02_03
		wSetVol		$00
		dc.b $C4
		wStopRead
		dc.b $C2
		wTempoDiv	$09
		wAddVol		$2B
		dc.b $A2
		wAddVol		$FE
		dc.b $43, $A2
		wAddVol		$FD
		dc.b $43, $A2
		wAddVol		$FE
		dc.b $43
		wStopRead
		wAddVol		$FD
		dc.b $A2, $43
		wAddVol		$FE
		dc.b $A2, $43
		wAddVol		$FD
		dc.b $A2, $43
		wStopRead
		wAddVol		$FE
		dc.b $A2, $43
		wAddVol		$FD
		dc.b $A2, $43
		wAddVol		$FE
		dc.b $A2, $43
		wStopRead
		wAddVol		$FD
		dc.b $A2
		wAddVol		$FB
		dc.b $43
		wAddVol		$FE
		dc.b $A2
		wAddVol		$0C
		dc.b $43
		wLoopGoEnd

.07_02_04
.07_02_06
		wSetVol		$00
		dc.b $C4
		wStopRead
		dc.b $C2
		wTempoDiv	$0D
		wAddVol		$2B
		dc.b $9F, $42
		wStopRead
		wAddVol		$FB
		dc.b $9F, $42
		wStopRead
		wAddVol		$FB
		dc.b $9F, $42
		wStopRead
		wAddVol		$FB
		dc.b $9F, $42
		wStopRead
		dc.b $C6
		wTempoDiv	$0D
		wAddVol		$F1
		dc.b $A0, $43, $C4
		wStopRead
		wLoopGoEnd

.07_02_05
		wSetVol		$00
		dc.b $C5
		wTempoDiv	$0C
		wAddVol		$17
		dc.b $A3, $48, $9C, $43, $C4, $A3, $48, $C5
		wAddVol		$04
		dc.b $A1, $46, $9A, $3F, $C4, $A1, $46, $C5
		wAddVol		$04
		dc.b $A0, $45, $99, $3E, $C4, $A0, $45, $C5
		wAddVol		$04
		dc.b $9F, $44, $98, $3D, $C4, $9F, $44
		wLoopGoEnd

.07_02_07
		wSetVol		$00
		dc.b $C5
		wTempoDiv	$0C
		wAddVol		$17
		dc.b $A3, $48, $9C, $43, $C4, $A3, $48, $C5
		dc.b $A1, $46, $9A, $3F, $C4, $A1, $46, $C2
		dc.b $A0, $45, $9E
		wAddVol		$FE
		dc.b $43, $9F, $44, $9E
		wAddVol		$FD
		dc.b $43, $9D, $42
		wStopRead
		wAddVol		$FE
		dc.b $9C, $41
		wAddVol		$FD
		dc.b $99, $3E
		wAddVol		$FE
		dc.b $9A, $3F
		wAddVol		$F8
		dc.b $9B, $40
		wAddVol		$FD
		dc.b $9C, $41, $C5
		wStopRead
		dc.b $C4, $A3, $3E
		wLoopGoEnd

.07_02_08
.07_02
		wSetType	$00
		wSetMask	$0E
		wSetPat		$23
		wLoopGo		$00, .07_02_00
		wLoopGo		$00, .07_02_01
		wLoopGo		$00, .07_02_02
		wLoopGo		$00, .07_02_03
		wLoopGo		$01, .07_02_04
		wLoopGo		$00, .07_02_05
		wLoopGo		$01, .07_02_06
		wLoopGo		$00, .07_02_07
		wJump		.07_02_08

.07_03_02
		wSetVol		$00
		dc.b $C8
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $37, $C4
		wStopRead
		dc.b $C2
		wTempoDiv	$10
		dc.b $4F, $4E, $4D
		wStopRead
		dc.b $4C, $4B, $C8, $48
		wStopRead
		dc.b $CF
		wStopRead
		dc.b $C2, $48, $4A, $4B, $4C, $4D, $4E, $C0
		wAddVol		$14
		dc.b $4E, $4F, $4E, $4F
		wAddVol		$FB
		dc.b $4E, $4F, $4E, $4F
		wAddVol		$FB
		dc.b $4E, $4F, $4E, $4F
		wAddVol		$FB
		dc.b $4E, $4F, $4E, $4F
		wAddVol		$FB
		dc.b $4E, $4F, $4E
		wAddVol		$FB
		dc.b $4F, $4E, $4F, $4E
		wAddVol		$FB
		dc.b $4F, $4E, $4F
		wAddVol		$FE
		dc.b $4E, $4F
		wAddVol		$FD
		dc.b $4E, $4F, $4E
		wAddVol		$FE
		dc.b $4F
		wLoopGoEnd

.07_03_00
		wSetVol		$00
		dc.b $C9
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $37, $C6
		wStopRead
		wLoopGoEnd

.07_03_03
.07_03_01
		dc.b $CA
		wStopRead
		wLoopGoEnd

.07_03_04
.07_03
		wSetType	$00
		wSetMask	$0E
		wSetPat		$1F
		wLoopGo		$00, .07_03_00
		wLoopGo		$02, .07_03_01
		wLoopGo		$00, .07_03_02
		wLoopGo		$07, .07_03_03
		wJump		.07_03_04

.07_04_06
.07_04_04
.07_04_00
.07_04_02
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $00
		wStopRead
		dc.b $00
		wAddVol		$0A
		dc.b $0F
		wAddVol		$F6
		dc.b $05
		wStopRead
		wAddVol		$0A
		dc.b $0F, $0F
		wAddVol		$F6
		dc.b $00, $00
		wAddVol		$0A
		dc.b $0F, $0F, $0F, $0F
		wAddVol		$EC
		dc.b $05
		wStopRead
		wLoopGoEnd

.07_04_05
.07_04_01
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $00
		wStopRead
		dc.b $00
		wAddVol		$0A
		dc.b $0F
		wAddVol		$EC
		dc.b $05
		wStopRead
		wAddVol		$14
		dc.b $0F, $0F
		wAddVol		$F6
		dc.b $00, $00
		wAddVol		$0A
		dc.b $0F
		wStopRead
		wAddVol		$EC
		dc.b $05
		wStopRead
		dc.b $05
		wStopRead
		wLoopGoEnd

.07_04_07
.07_04_03
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $00, $00
		wAddVol		$14
		dc.b $05, $05, $05
		wStopRead
		wAddVol		$F6
		dc.b $05, $05, $05
		wStopRead
		wAddVol		$F6
		dc.b $05, $05, $05
		wAddVol		$F6
		dc.b $05, $05, $05
		wLoopGoEnd

.07_04_0A
.07_04_08
		wSetVol		$00
		dc.b $C4
		wAddVol		$12
		dc.b $00, $C2, $00
		wAddVol		$0A
		dc.b $0F, $0F
		wStopRead
		dc.b $0F, $0F
		wAddVol		$F6
		dc.b $00
		wAddVol		$0A
		dc.b $0F
		wAddVol		$F6
		dc.b $00
		wAddVol		$0A
		dc.b $0F
		wAddVol		$EC
		dc.b $05
		wStopRead
		wAddVol		$14
		dc.b $0F, $0F, $C4
		wAddVol		$F6
		dc.b $00, $C2, $00
		wAddVol		$0A
		dc.b $0F, $0F
		wStopRead
		dc.b $0F, $0F
		wAddVol		$F6
		dc.b $00
		wAddVol		$0A
		dc.b $0F
		wAddVol		$F6
		dc.b $00
		wAddVol		$F6
		dc.b $05
		wAddVol		$14
		dc.b $0F, $0F
		wAddVol		$EC
		dc.b $05
		wAddVol		$14
		dc.b $0F
		wLoopGoEnd

.07_04_09
.07_04_0B
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $00
		wAddVol		$0A
		dc.b $0F, $0F
		wStopRead
		dc.b $0F, $0F
		wAddVol		$EC
		dc.b $05, $05
		wAddVol		$0A
		dc.b $00, $C4
		wStopRead
		dc.b $C2
		wAddVol		$F6
		dc.b $05, $C4
		wStopRead
		dc.b $C2, $05, $05
		wLoopGoEnd

.07_04_0C
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $00, $00, $0D, $0D, $0D
		wStopRead
		dc.b $0E, $0E, $0D, $0D
		wAddVol		$0A
		dc.b $11, $C5
		wStopRead
		dc.b $C2
		wAddVol		$F6
		dc.b $0C
		wStopRead
		wLoopGoEnd

.07_04
		wDrumChannel

.07_04_0D
		wLoopGo		$00, .07_04_00
		wLoopGo		$00, .07_04_01
		wLoopGo		$00, .07_04_02
		wLoopGo		$00, .07_04_03
		wLoopGo		$00, .07_04_04
		wLoopGo		$00, .07_04_05
		wLoopGo		$00, .07_04_06
		wLoopGo		$00, .07_04_07
		wLoopGo		$00, .07_04_08
		wLoopGo		$01, .07_04_09
		wLoopGo		$00, .07_04_0A
		wLoopGo		$00, .07_04_0B
		wLoopGo		$00, .07_04_0C
		wJump		.07_04_0D

.07
		wHeaderMus	$88, $01AA
		dw	.07_00
		dw	.07_01
		dw	.07_02
		dw	.07_03
		dw	.07_04
		dw	$0000

.08_00_01
		wSetVol		$00
		dc.b $CC
		wTempoDiv	$0F
		wAddVol		$0D
		dc.b $30, $2E, $2B, $C6
		wTempoDiv	$0D
		dc.b $31, $CC
		wTempoDiv	$0F
		dc.b $30, $2E, $2B, $C6
		wTempoDiv	$0D
		dc.b $34, $CC
		wTempoDiv	$0F
		dc.b $30, $30, $30, $C6
		wTempoDiv	$0D
		dc.b $2E, $CC
		wTempoDiv	$10
		dc.b $35, $35, $35, $CD, $34, $CC, $31
		wLoopGoEnd

.08_00_02
		wSetVol		$00
		dc.b $CC
		wTempoDiv	$0F
		wAddVol		$0D
		dc.b $30, $2E, $2B, $C6
		wTempoDiv	$0D
		dc.b $31, $CC
		wTempoDiv	$0F
		dc.b $30, $2E, $2B, $C6
		wTempoDiv	$0D
		dc.b $34, $C4
		wAddVol		$0A
		dc.b $30, $31, $C2
		wAddVol		$F6
		dc.b $2F, $30, $34, $2F, $C4
		wStopRead
		dc.b $32, $33, $34
		wLoopGoEnd

.08_00_03
.08_00_04
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$0D
		dc.b $35, $29, $2D, $30, $33, $32, $33, $30
		wLoopGoEnd

.08_00_05
		wSetVol		$00
		dc.b $CA
		wTempoDiv	$10
		dc.b $35, $C4
		wTempoDiv	$0D
		wAddVol		$0D
		dc.b $33, $32, $31, $30, $2E, $2D, $2C, $2B
		wLoopGoEnd

.08_00_00
		wSetVol		$00
		dc.b $C6
		wTempoDiv	$0D
		wAddVol		$0D
		dc.b $29, $30, $31, $2E, $30, $2E, $2C, $2B
		dc.b $2B, $29, $28, $25, $2B, $29, $28, $25
		wLoopGoEnd

.08_00_06
.08_00
		wSetType	$00
		wSetMask	$01
		wSetPat		$07
		wLoopGo		$01, .08_00_00
		wLoopGo		$02, .08_00_01
		wLoopGo		$00, .08_00_02
		wLoopGo		$07, .08_00_03
		wLoopGo		$05, .08_00_04
		wLoopGo		$00, .08_00_05
		wJump		.08_00_06

.08_01_01
.08_01_00
		wSetVol		$10
		dc.b $C4
		wTempoDiv	$0A
		wAddVol		$12
		dc.b $37, $3D, $48, $44, $37, $3D, $46, $43
		dc.b $37, $3D, $48, $44, $37, $C7
		wStopRead
		wLoopGoEnd

.08_01_02
		wSetVol		$10
		dc.b $C6
		wTempoDiv	$10
		wAddVol		$0D
		dc.b $54, $4F, $52
		wSetTimerB	$F0
		dc.b $58, $C6, $54, $4F, $52
		wSetTimerB	$F0
		dc.b $48
		wLoopGoEnd

.08_01_04
.08_01_03
.08_01_05
		wSetVol		$10
		dc.b $C4
		wTempoDiv	$0F
		wAddVol		$0F
		dc.b $41, $C6
		wStopRead
		dc.b $C4, $4D, $C6
		wStopRead
		dc.b $C4, $4B
		wStopRead
		wStopRead
		dc.b $4A, $C6
		wStopRead
		dc.b $C4, $48, $C2, $46, $45, $43, $41, $C4
		wStopRead
		dc.b $4D, $C6
		wStopRead
		dc.b $C4, $4B, $C8
		wStopRead
		wLoopGoEnd

.08_01_06
		wSetVol		$10
		dc.b $C4
		wTempoDiv	$0F
		wAddVol		$0F
		dc.b $41, $C6
		wStopRead
		dc.b $C4, $4D, $C6
		wStopRead
		dc.b $C4, $4B
		wStopRead
		wStopRead
		dc.b $4A, $C6
		wStopRead
		dc.b $C4, $48, $C2, $46, $45, $43, $41, $C4
		wStopRead
		dc.b $C7
		wTempoDiv	$0D
		wAddVol		$F9
		dc.b $52, $51, $4D, $4B, $C6, $4A, $48
		wLoopGoEnd

.08_01_07
.08_01
		wSetType	$00
		wSetMask	$08
		wSetPat		$0B
		wSetFreq	$F400
		dc.b $CA
		wStopRead
		wStopRead
		wLoopGo		$00, .08_01_00
		dc.b $CA
		wStopRead
		wStopRead
		wLoopGo		$00, .08_01_01
		wSetPat		$21
		wLoopGo		$01, .08_01_02
		wSetMask	$0C
		wLoopGo		$00, .08_01_03
		dc.b $CA
		wStopRead
		wLoopGo		$00, .08_01_04
		dc.b $CA
		wStopRead
		wLoopGo		$00, .08_01_05
		dc.b $CA
		wStopRead
		wLoopGo		$00, .08_01_06
		wJump		.08_01_07

.08_02_00
		wSetVol		$08
		dc.b $C4
		wTempoDiv	$0A
		wAddVol		$17
		dc.b $54, $4D, $4F, $50
		wStopRead
		dc.b $4F, $4D, $49, $48, $43, $46, $41, $44
		dc.b $3D, $3C, $3A, $CA
		wStopRead
		dc.b $CF
		wStopRead
		dc.b $C4, $46, $46
		wAddVol		$F6
		dc.b $46
		wLoopGoEnd
	; Unused
		dc.b $F4, $08, $C4, $F1, $0D, $F5, $17, $35
	; Unused
		dc.b $F1, $10, $35, $41, $35, $3F, $3E, $3C
	; Unused
		dc.b $C6, $F1, $0E, $35, $C4, $F1, $10, $35
	; Unused
		dc.b $41, $35, $3F, $3E, $3D, $3C, $C7, $3B
	; Unused
		dc.b $CF, $F1, $0E, $3C, $C7, $F1, $10, $3B
		dc.b $C8, $37, $C4, $FA, $FF

.08_02
.08_02_01
		wSetType	$00
		wSetMask	$08
		wSetPat		$00
		wLoopGo		$01, .08_02_00
		dc.b $CA
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		dc.b $CA
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		dc.b $CA
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		wJump		.08_02_01

.08_03_02
.08_03_00
		wSetVol		$14
		dc.b $C4
		wTempoDiv	$0A
		wAddVol		$19
		dc.b $89, $35, $A4, $48, $90, $3C, $A4, $48
		dc.b $91, $3D, $A4, $48, $8E, $3A, $A4, $48
		dc.b $90, $3C, $A0, $46, $8E, $3A, $A0, $46
		dc.b $8C, $38, $A0, $46, $8B, $37, $A0, $46
		dc.b $37, $A6, $49, $35, $A6, $49, $34, $A3
		dc.b $46, $31, $A3, $46
		wLoopGoEnd

.08_03_01
		wSetVol		$14
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$18
		dc.b $8B, $37, $A6, $49, $89, $35, $A6, $49
		dc.b $88, $34, $A3, $46, $A3, $46, $A3, $46
		wLoopGoEnd

.08_03_03
		wSetVol		$14
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$18
		dc.b $8B, $37, $A3, $A6, $49, $89, $35, $A3
		dc.b $A6, $49, $88, $34
		wAddVol		$F8
		dc.b $97, $3D, $98, $3E, $99, $3F
		wLoopGoEnd

.08_03_04
		wSetVol		$0C
		dc.b $CC
		wStopRead
		wTempoDiv	$0F
		wAddVol		$1A
		dc.b $A9, $4C, $47, $CD
		wTempoDiv	$10
		dc.b $4F, $CC, $A9, $4C, $C4
		wTempoDiv	$0A
		dc.b $47
		wSetTimerB	$38
		wStopRead
		dc.b $CC
		wTempoDiv	$0F
		dc.b $9C, $3D
		wSetTimerB	$50
		wStopRead
		dc.b $CC, $9C, $3D, $C6
		wStopRead
		dc.b $CC, $43, $41, $40, $97, $40, $43, $44
		dc.b $CD
		wTempoDiv	$10
		dc.b $4C, $CC, $4A, $43, $41, $C4
		wTempoDiv	$0A
		dc.b $40
		wStopRead
		dc.b $CC
		wTempoDiv	$0F
		dc.b $99, $3F
		wSetTimerB	$50
		wStopRead
		dc.b $CC, $99, $3F, $CD
		wStopRead
		dc.b $CC, $99, $3F
		wTempoDiv	$10
		wAddVol		$05
		dc.b $54, $4C, $54, $CD
		wStopRead
		dc.b $CC
		wAddVol		$FB
		dc.b $A5, $47, $CD, $4F, $CC, $A9, $4C, $C4
		wTempoDiv	$0A
		dc.b $47
		wSetTimerB	$38
		wStopRead
		dc.b $CC
		wTempoDiv	$0F
		dc.b $9C, $3D
		wSetTimerB	$50
		wStopRead
		dc.b $CC, $9C, $3D, $CD
		wStopRead
		dc.b $CC, $9C, $3D, $43, $41, $40, $97, $40
		dc.b $43, $44, $97, $40, $43, $44
		wStopRead
		dc.b $41, $C4
		wTempoDiv	$0A
		dc.b $40
		wStopRead
		dc.b $CC
		wTempoDiv	$0F
		dc.b $99, $3F
		wAddVol		$F6
		dc.b $97, $3C, $CB
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$F6
		dc.b $98, $3D, $C2, $8F, $34, $90, $35, $94
		dc.b $37, $8F, $35, $92, $38
		wStopRead
		dc.b $C4, $99, $3E, $C6, $9B, $40
		wLoopGoEnd

.08_03_05
.08_03_07
.08_03_06
		wSetVol		$0C
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$33
		dc.b $41, $46, $48
		wAddVol		$FB
		dc.b $4D, $41, $46, $48
		wAddVol		$EC
		dc.b $4D, $41, $46, $48
		wAddVol		$EC
		dc.b $4D, $41, $46, $48, $4D
		wLoopGoEnd

.08_03_08
		wSetVol		$0C
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$2E
		dc.b $41, $46
		wAddVol		$FB
		dc.b $48, $4D
		wAddVol		$FB
		dc.b $41, $46
		wAddVol		$FB
		dc.b $48, $4D
		wAddVol		$FB
		dc.b $9A, $3F, $99, $3E
		wAddVol		$FB
		dc.b $98, $3D, $97, $3C, $95, $3A
		wAddVol		$FB
		dc.b $94, $39, $93, $38
		wAddVol		$FB
		dc.b $92, $37
		wLoopGoEnd

.08_03_09
.08_03
		wSetType	$00
		wSetMask	$06
		wSetPat		$23
		wLoopGo		$00, .08_03_00
		wLoopGo		$00, .08_03_01
		wLoopGo		$00, .08_03_02
		wLoopGo		$00, .08_03_03
		wLoopGo		$00, .08_03_04
		dc.b $CA
		wStopRead
		wStopRead
		wLoopGo		$00, .08_03_05
		dc.b $CA
		wStopRead
		wStopRead
		wLoopGo		$00, .08_03_06
		dc.b $CA
		wStopRead
		wStopRead
		wLoopGo		$00, .08_03_07
		dc.b $CA
		wStopRead
		wStopRead
		wLoopGo		$00, .08_03_08
		wJump		.08_03_09

.08_04_00
.08_04_05
		wSetVol		$04
		dc.b $C4
		wAddVol		$12
		dc.b $60
		wAddVol		$0A
		dc.b $10
		wAddVol		$EC
		dc.b $05
		wAddVol		$0A
		dc.b $60
		wAddVol		$0A
		dc.b $10
		wAddVol		$EC
		dc.b $05
		wAddVol		$0A
		dc.b $60
		wAddVol		$0A
		dc.b $10
		wAddVol		$EC
		dc.b $05
		wAddVol		$0A
		dc.b $60
		wAddVol		$0A
		dc.b $10
		wAddVol		$EC
		dc.b $05
		wAddVol		$0A
		dc.b $60
		wAddVol		$0A
		dc.b $10
		wAddVol		$EC
		dc.b $05
		wAddVol		$0A
		dc.b $60
		wAddVol		$0A
		dc.b $10
		wAddVol		$EC
		dc.b $05
		wAddVol		$0A
		dc.b $60
		wAddVol		$0A
		dc.b $10, $C2
		wAddVol		$EC
		dc.b $05, $05, $C4
		wAddVol		$0A
		dc.b $60
		wAddVol		$0A
		dc.b $10
		wAddVol		$EC
		dc.b $05
		wLoopGoEnd

.08_04_01
.08_04_03
		wSetVol		$04
		dc.b $CC
		wAddVol		$12
		dc.b $00, $CD
		wStopRead
		dc.b $C6, $05, $CC, $00
		wStopRead
		dc.b $00, $C6, $11
		wLoopGoEnd

.08_04_02
		wSetVol		$04
		dc.b $CC
		wAddVol		$12
		dc.b $00, $CD
		wStopRead
		dc.b $C6, $05, $CC, $60, $0E, $0E, $60, $0D
		dc.b $65, $0D, $0C, $0C
		wLoopGoEnd

.08_04_04
		wSetVol		$04
		dc.b $C2
		wAddVol		$12
		dc.b $00, $05, $C4, $05, $C2, $0D, $0D, $0C
		dc.b $0C, $11
		wStopRead
		dc.b $05
		wStopRead
		dc.b $05, $C5
		wStopRead
		wLoopGoEnd

.08_04_06
		wSetVol		$04
		dc.b $C4
		wAddVol		$12
		dc.b $60
		wAddVol		$F6
		dc.b $05
		wSetTimerB	$A8
		wStopRead
		dc.b $C6
		wStopRead
		dc.b $C2, $05, $05, $05
		wStopRead
		dc.b $05, $05, $05
		wStopRead
		dc.b $05
		wStopRead
		dc.b $05
		wStopRead
		wLoopGoEnd

.08_04
		wDrumChannel

.08_04_07
		wLoopGo		$03, .08_04_00
		wLoopGo		$02, .08_04_01
		wLoopGo		$00, .08_04_02
		wLoopGo		$02, .08_04_03
		wLoopGo		$00, .08_04_04
		wLoopGo		$06, .08_04_05
		wLoopGo		$00, .08_04_06
		wJump		.08_04_07

.08
		wHeaderMus	$88, $0266
		dw	.08_00
		dw	.08_01
		dw	.08_02
		dw	.08_03
		dw	.08_04
		dw	$0000

.17_00_00
		wSetVol		$00
		dc.b $C2
		wTempoDiv	$0C
		wAddVol		$0D
		dc.b $2B, $2B, $2B
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $37, $C2
		wTempoDiv	$0C
		dc.b $2B, $2B
		wStopRead
		dc.b $2B, $2B
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $37, $C2
		wTempoDiv	$0C
		dc.b $2B
		wStopRead
		dc.b $29, $29, $29
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $35, $C2
		wTempoDiv	$0C
		dc.b $29, $29, $C6
		wStopRead
		dc.b $C2, $30, $32, $30, $32, $27, $27, $27
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $33, $C2
		wTempoDiv	$0C
		dc.b $27, $27
		wStopRead
		dc.b $27, $27
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $33, $C2
		wTempoDiv	$0C
		dc.b $27
		wStopRead
		dc.b $29, $29, $29
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $35, $C2
		wTempoDiv	$0C
		dc.b $29, $29, $C4
		wStopRead
		wTempoDiv	$0D
		wAddVol		$0A
		dc.b $32, $32, $32, $C2
		wTempoDiv	$0C
		wAddVol		$F6
		dc.b $2B, $2B, $2B
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $37, $C2
		wTempoDiv	$0C
		dc.b $2B, $2B
		wStopRead
		dc.b $2B, $2B
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $37, $C2
		wTempoDiv	$0C
		dc.b $2B
		wStopRead
		dc.b $29, $29, $29
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $35, $C2
		wTempoDiv	$0C
		dc.b $29, $29, $C6
		wStopRead
		dc.b $C2, $30, $32, $30, $32, $27, $27, $27
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $33, $C2
		wTempoDiv	$0C
		dc.b $27, $27
		wStopRead
		dc.b $27, $27
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $33, $C2
		wTempoDiv	$0C
		dc.b $27
		wStopRead
		dc.b $29, $29, $29
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $35, $C2
		wTempoDiv	$0C
		dc.b $29, $29, $C6
		wTempoDiv	$0D
		wAddVol		$0A
		dc.b $27, $C4, $29
		wFC
		wAddVol		$F6
		dc.b $2E
		wLoopGoEnd

.17_00_01
		wSetVol		$00
		dc.b $C6
		wTempoDiv	$0D
		wAddVol		$0D
		dc.b $2E, $C4, $2E, $C2
		wTempoDiv	$0C
		dc.b $32, $32, $C4
		wTempoDiv	$0D
		dc.b $2B, $2D, $2E, $C7, $27, $C4, $27, $C6
		wStopRead
		dc.b $C4, $29, $2B, $C7, $2C, $C4, $2C, $C2
		wTempoDiv	$0C
		dc.b $30, $30, $C4
		wTempoDiv	$0D
		dc.b $29, $2B, $2C, $C7, $32, $C4, $32, $C6
		wStopRead
		dc.b $C4, $30, $2E, $2D, $C2
		wTempoDiv	$0C
		dc.b $2B, $2B, $2B
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $37, $C2
		wTempoDiv	$0C
		dc.b $2B, $2B
		wStopRead
		dc.b $2B, $2B
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $37, $C2
		wTempoDiv	$0C
		dc.b $2B
		wStopRead
		dc.b $29, $29, $29
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $35, $C2
		wTempoDiv	$0C
		dc.b $29, $29, $C6
		wStopRead
		dc.b $C2, $30, $32, $30, $32, $27, $27, $27
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $33, $C2
		wTempoDiv	$0C
		dc.b $27, $27
		wStopRead
		dc.b $27, $27
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $33, $C2
		wTempoDiv	$0C
		dc.b $27
		wStopRead
		dc.b $32, $32
		wStopRead
		dc.b $3E, $3E
		wStopRead
		dc.b $3C, $3C
		wStopRead
		dc.b $30, $30
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $2E, $2D
		wLoopGoEnd

.17_00_03
		wSetVol		$00
		dc.b $C5
		wTempoDiv	$0C
		wAddVol		$17
		dc.b $2B, $C2, $2B, $C4
		wTempoDiv	$0D
		dc.b $37, $2B, $C2
		wTempoDiv	$0C
		dc.b $2B, $2B, $C4
		wStopRead
		wTempoDiv	$0D
		dc.b $37, $2B, $C5
		wTempoDiv	$0C
		dc.b $29, $C2, $29, $C4
		wTempoDiv	$0D
		dc.b $35, $29, $C2
		wTempoDiv	$0C
		dc.b $29, $C5
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $2E, $C7, $30, $C4, $2E, $C7, $30, $C6
		dc.b $30, $C2
		wTempoDiv	$0C
		wAddVol		$F6
		dc.b $32, $32
		wStopRead
		dc.b $3E, $3E
		wStopRead
		dc.b $3C, $3C
		wStopRead
		dc.b $30, $30
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $2E, $2D
		wLoopGoEnd

.17_00_02
		wSetVol		$00
		dc.b $C2
		wTempoDiv	$0C
		wAddVol		$0D
		dc.b $2B, $2B, $2B
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $37, $C2
		wTempoDiv	$0C
		dc.b $2B, $2B
		wStopRead
		dc.b $2B, $2B
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $37, $C2
		wTempoDiv	$0C
		dc.b $2B
		wStopRead
		dc.b $29, $29, $29
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $35, $C2
		wTempoDiv	$0C
		dc.b $29, $29, $C6
		wStopRead
		dc.b $C2, $30, $32, $30, $32, $27, $27, $27
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $33, $C2
		wTempoDiv	$0C
		dc.b $27, $27
		wStopRead
		dc.b $27, $27
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $33, $C2
		wTempoDiv	$0C
		dc.b $27
		wStopRead
		dc.b $29, $29, $29
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $35, $C2
		wTempoDiv	$0C
		dc.b $29, $29, $C4
		wStopRead
		wTempoDiv	$0D
		wAddVol		$0A
		dc.b $32, $32, $32, $C2
		wTempoDiv	$0C
		wAddVol		$F6
		dc.b $2B, $2B, $2B
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $37, $C2
		wTempoDiv	$0C
		dc.b $2B, $2B
		wStopRead
		dc.b $2B, $2B
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $37, $C2
		wTempoDiv	$0C
		dc.b $2B
		wStopRead
		dc.b $29, $29, $29
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $35, $C2
		wTempoDiv	$0C
		dc.b $29, $29, $C6
		wStopRead
		dc.b $C2, $30, $32, $30, $32, $29, $29, $29
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $35, $C2
		wTempoDiv	$0C
		dc.b $29, $29
		wStopRead
		dc.b $2E, $2E
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $35, $C2
		wTempoDiv	$0C
		dc.b $2E
		wStopRead
		dc.b $30, $30
		wStopRead
		dc.b $3C, $3C
		wStopRead
		dc.b $3A, $3A
		wStopRead
		dc.b $2E, $2E
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $2C, $2B
		wLoopGoEnd

.17_00
.17_00_04
		wSetMask	$01
		wSetPat		$09
		wLoopGo		$00, .17_00_00
		wLoopGo		$00, .17_00_01
		wLoopGo		$00, .17_00_02
		wLoopGo		$01, .17_00_03
		wJump		.17_00_04

.17_01_00
		wSetVol		$00
		dc.b $CA
		wTempoDiv	$10
		wAddVol		$2B
		dc.b $9E, $43, $A1, $45, $9F, $46, $CF, $A1
		dc.b $48, $C2
		wAddVol		$E2
		dc.b $9E, $45
		wStopRead
		dc.b $9E, $45
		wStopRead
		dc.b $9E, $45
		wStopRead
		dc.b $CA
		wAddVol		$1E
		dc.b $9E, $43, $A1, $45, $9F, $46, $C8, $A1
		dc.b $48, $C6
		wAddVol		$EC
		dc.b $9F, $43, $C4
		wAddVol		$0A
		dc.b $A1, $45, $CA, $A1, $46
		wAddVol		$0A
		dc.b $9F, $46, $A4, $48
		wSetTimerB	$D8
		dc.b $A5, $4A, $C7, $9E, $43, $CF, $A3, $4A
		dc.b $C7, $A1, $45, $CF, $A5, $4A, $C7, $9F
		dc.b $43, $CF, $A3, $4A, $C8
		wAddVol		$F6
		dc.b $A5, $4A, $9E, $45
		wLoopGoEnd

.17_01_01
		wSetVol		$00
		dc.b $CA
		wTempoDiv	$10
		wAddVol		$2B
		dc.b $9E, $43, $A1, $45, $9F, $46, $CF, $A1
		dc.b $48, $C2
		wAddVol		$E2
		dc.b $9E, $45
		wStopRead
		dc.b $9E, $45
		wStopRead
		dc.b $9E, $45
		wStopRead
		dc.b $CA
		wAddVol		$1E
		dc.b $9E, $43, $A1, $45, $C8, $A1, $44, $A1
		dc.b $46, $CA
		wTempoDiv	$08
		dc.b $A8, $40
		wLoopGoEnd

.17_01_02
		wSetVol		$00
		dc.b $CF
		wTempoDiv	$10
		wAddVol		$21
		dc.b $A3, $4A, $C2, $A3, $4A
		wStopRead
		wAddVol		$0A
		dc.b $A3, $4A
		wStopRead
		dc.b $A3, $4A
		wStopRead
		dc.b $C7, $A1, $48, $C4, $A1, $48, $C6, $A1
		dc.b $48, $C4
		wAddVol		$EC
		dc.b $A1, $46, $C7
		wAddVol		$0A
		dc.b $A3, $48, $C4, $A1, $46, $C7
		wAddVol		$0A
		dc.b $A3, $48, $C6, $A3, $4B, $CA
		wAddVol		$F6
		dc.b $A5, $4A, $CF, $A3, $4A, $C2
		wAddVol		$0A
		dc.b $A3, $4A
		wStopRead
		dc.b $A3, $4A
		wStopRead
		dc.b $A3, $4A
		wStopRead
		dc.b $C7, $A1, $48, $C4, $A1, $48, $C6, $A1
		dc.b $48, $C4
		wAddVol		$F6
		dc.b $A1, $46, $C7
		wAddVol		$F6
		dc.b $A3, $48, $C4
		wAddVol		$0A
		dc.b $A1, $46, $C7
		wAddVol		$0A
		dc.b $A3, $48, $C6, $A3, $4B, $CA
		wAddVol		$F6
		dc.b $A5, $4A
		wLoopGoEnd

.17_01_03
.17_01
		wSetMask	$18
		wSetPat		$0A
		wLoopGo		$00, .17_01_00
		wLoopGo		$00, .17_01_01
		wLoopGo		$00, .17_01_02
		wJump		.17_01_03

.17_02_00
		wSetVol		$06
		dc.b $C2
		wTempoDiv	$10
		wAddVol		$17
		dc.b $52, $51, $4F
		wStopRead
		dc.b $52, $51, $C6, $4F, $C4, $52, $52, $54
		dc.b $C2, $52, $51, $4F
		wStopRead
		dc.b $52, $51, $C6, $4F, $C0, $4D, $4E, $C2
		dc.b $4F, $C0, $4D, $4E, $C2, $4F, $C4, $4D
		dc.b $C2, $4B, $4D, $4E, $4F, $50, $51, $52
		dc.b $54, $C0, $55
		wSetTimerB	$2A
		dc.b $56, $C0, $55
		wSetTimerB	$2A
		dc.b $56, $CF, $54, $C6, $52, $C4, $51, $C2
		dc.b $52, $51, $4F
		wStopRead
		dc.b $52, $51, $C6, $4F, $C4, $52, $52, $54
		dc.b $C2, $52, $51, $4F
		wStopRead
		dc.b $52, $51, $C6, $4F, $C0, $4D, $4E, $C2
		dc.b $4F, $C0, $4D, $4E, $C2, $4F, $C4, $4D
		dc.b $C2, $4B, $4D, $4E, $4F, $50, $51, $52
		dc.b $54, $C0, $55
		wSetTimerB	$2A
		dc.b $56, $C0, $55
		wSetTimerB	$2A
		dc.b $56, $C8, $54, $C6, $52, $C4, $54, $CF
		dc.b $56, $C4, $52, $51, $4D, $C7, $4F, $C4
		dc.b $4F, $4B, $4F
		wStopRead
		dc.b $56, $C9, $54, $C0, $57, $58, $C5, $59
		dc.b $CF, $56, $C4, $56, $54, $52, $51, $C2
		dc.b $52, $C4, $52, $C2, $4F, $C4, $4F, $C2
		dc.b $52, $C5, $52, $C4, $51, $4F, $4D, $4A
		dc.b $C2, $4D, $4A, $4D, $C5, $4A, $C4, $4D
		dc.b $C2, $51, $4D, $51, $C5, $4D, $C2, $52
		dc.b $C4, $52, $C2, $4F, $C4, $4F, $C2, $52
		dc.b $C5, $52, $C4, $52, $51, $4F, $C0, $51
		dc.b $53, $55
		wSetTimerB	$4E
		dc.b $56, $C8, $51
		wLoopGoEnd

.17_02_02
		wSetVol		$06
		dc.b $CF
		wTempoDiv	$10
		wAddVol		$17
		dc.b $4F, $C4, $4F, $51, $52, $C7, $56, $C2
		dc.b $54, $52, $C6, $51, $C4, $56, $C7, $54
		dc.b $C4, $56, $C7, $54, $C6, $51, $CA, $56
		dc.b $CF, $4F, $C4, $4F, $51, $52, $C7, $56
		dc.b $C2, $54, $52, $C6, $51, $C4, $56, $C7
		dc.b $54, $C4, $52, $C7, $54, $C6, $57, $CA
		dc.b $56
		wLoopGoEnd

.17_02_01
		wSetVol		$06
		dc.b $C2
		wTempoDiv	$0C
		wAddVol		$17
		dc.b $52, $51, $4F, $52, $51, $4F, $52, $51
		dc.b $4F, $52, $51, $4F, $C4
		wTempoDiv	$0D
		dc.b $54, $56, $C2
		wTempoDiv	$0C
		dc.b $52, $51, $4F, $52, $51, $4F, $52, $51
		dc.b $C4
		wTempoDiv	$10
		dc.b $4D, $C7
		wStopRead
		dc.b $C4, $57, $57, $56, $54, $C2, $52, $51
		dc.b $4F, $C4, $4D, $C2, $4B, $C4, $4A, $C2
		dc.b $4A, $4D, $4A, $4D, $49, $4C, $48, $4B
		dc.b $4F, $C5
		wStopRead
		dc.b $C0, $4F, $51, $C2, $52, $C4, $51, $C2
		wTempoDiv	$0C
		dc.b $52, $51, $4F, $52, $51, $4F, $52, $51
		dc.b $4F, $52, $51, $4F, $C4
		wTempoDiv	$0D
		dc.b $54, $C2
		wTempoDiv	$10
		dc.b $56
		wStopRead
		wTempoDiv	$0C
		dc.b $52, $51, $4F, $52, $51, $4F, $52, $51
		wTempoDiv	$10
		dc.b $4D
		wSetTimerB	$54
		wStopRead
		dc.b $C4, $57, $57, $56, $54, $C2, $52, $50
		dc.b $4F, $4D, $C4
		wTempoDiv	$09
		dc.b $4D
		wTempoDiv	$10
		dc.b $4E, $CF, $4F, $C4, $4D, $4D, $4E
		wLoopGoEnd

.17_02
.17_02_03
		wSetMask	$06
		wSetPat		$0A
		wSetFreq	$E800
		wLoopGo		$00, .17_02_00
		wLoopGo		$00, .17_02_01
		wLoopGo		$00, .17_02_02
		wJump		.17_02_03

.17_03_00
.17_03_0A
.17_03_02
.17_03_04
.17_03_08
.17_03_06
.17_03_0C
		wSetVol		$00
		dc.b $C4
		wAddVol		$12
		dc.b $00, $05, $00, $05, $00, $05, $00, $05
		wLoopGoEnd

.17_03_01
.17_03_05
.17_03_07
.17_03_0D
.17_03_0B
		wSetVol		$00
		dc.b $C4
		wAddVol		$12
		dc.b $00, $05, $00, $C2, $05, $0D, $0C, $0C
		dc.b $C4, $05, $05, $05
		wLoopGoEnd

.17_03_03
.17_03_09
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $00
		wStopRead
		dc.b $05
		wStopRead
		dc.b $00
		wStopRead
		dc.b $05
		wStopRead
		dc.b $0E, $0E, $0D, $0D, $0C, $0C, $0C, $0C
		wLoopGoEnd

.17_03
		wDrumChannel

.17_03_0E
		wLoopGo		$02, .17_03_00
		wLoopGo		$00, .17_03_01
		wLoopGo		$06, .17_03_02
		wLoopGo		$00, .17_03_03
		wLoopGo		$02, .17_03_04
		wLoopGo		$00, .17_03_05
		wLoopGo		$02, .17_03_06
		wLoopGo		$00, .17_03_07
		wLoopGo		$02, .17_03_08
		wLoopGo		$00, .17_03_09
		wLoopGo		$02, .17_03_0A
		wLoopGo		$00, .17_03_0B
		wLoopGo		$02, .17_03_0C
		wLoopGo		$00, .17_03_0D
		wJump		.17_03_0E

.17
		wHeaderMus	$88, $01CC
		dw	.17_00
		dw	.17_01
		dw	.17_02
		dw	.17_03
		dw	$0000

.09_00_00
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$0A
		dc.b $2B, $2B, $29, $29, $C8
		wStopRead
		dc.b $C4, $2B, $2B, $2E, $2E, $C8
		wStopRead
		wLoopGoEnd

.09_00
.09_00_01
		wSetType	$00
		wSetMask	$01
		wSetPat		$07
		wLoopGo		$07, .09_00_00
		wJump		.09_00_01

.09_01_00
		wSetVol		$0A
		dc.b $C4
		wStopRead
		dc.b $C2
		wTempoDiv	$09
		wAddVol		$1A
		dc.b $40
		wStopRead
		wAddVol		$EC
		dc.b $47
		wAddVol		$0A
		dc.b $45, $C4
		wStopRead
		dc.b $C2
		wAddVol		$0A
		dc.b $41, $41, $C5
		wStopRead
		dc.b $C2, $4A, $C4
		wStopRead
		dc.b $C2, $40, $CE
		wStopRead
		dc.b $C2, $41
		wAddVol		$EC
		dc.b $40
		wStopRead
		wAddVol		$14
		dc.b $43, $C7
		wStopRead
		dc.b $C2
		wStopRead
		dc.b $C0
		wAddVol		$0F
		dc.b $45
		wStopRead
		wAddVol		$F6
		dc.b $47
		wAddVol		$F1
		dc.b $45
		wAddVol		$F6
		dc.b $47
		wAddVol		$F6
		dc.b $45, $CE
		wStopRead
		dc.b $C0
		wAddVol		$2D
		dc.b $43
		wStopRead
		wAddVol		$F6
		dc.b $45
		wAddVol		$F1
		dc.b $43
		wAddVol		$F6
		dc.b $45
		wAddVol		$F6
		dc.b $43, $C6
		wStopRead
		dc.b $C0
		wAddVol		$14
		dc.b $41
		wAddVol		$0A
		dc.b $40
		wAddVol		$0F
		dc.b $41
		wStopRead
		wAddVol		$F1
		dc.b $45, $C3
		wStopRead
		dc.b $C0, $41, $40, $C2
		wStopRead
		dc.b $C0, $40
		wAddVol		$F6
		dc.b $45
		wAddVol		$F6
		dc.b $47
		wStopRead
		wAddVol		$14
		dc.b $41
		wSetTimerB	$5A
		wStopRead
		wLoopGoEnd

.09_01_01
.09_01
		wSetType	$00
		wSetMask	$02
		wSetFreq	$F4F0
		wSetPat		$26
		dc.b $CA
		wLoopBackInit	$03
		wStopRead
		wLoopBack
		wLoopGo		$02, .09_01_00
		wJump		.09_01_01

.09_02_01
.09_02_00
		wSetVol		$08
		dc.b $C4
		wAddVol		$08
		dc.b $6D
		wAddVol		$04
		dc.b $0A
		wAddVol		$0A
		dc.b $6C
		wAddVol		$F6
		dc.b $09
		wAddVol		$14
		dc.b $6C
		wAddVol		$EC
		dc.b $0A, $C2
		wAddVol		$1E
		dc.b $6C
		wAddVol		$EC
		dc.b $12
		wAddVol		$0A
		dc.b $07, $C4
		wAddVol		$E2
		dc.b $6D
		wAddVol		$1E
		dc.b $07, $C2
		wAddVol		$F6
		dc.b $6C, $12
		wAddVol		$0A
		dc.b $08, $C4, $6C
		wAddVol		$F6
		dc.b $12
		wAddVol		$14
		dc.b $0C
		wLoopGoEnd

.09_02
		wDrumChannel

.09_02_02
		wLoopGo		$07, .09_02_00
		wLoopGo		$07, .09_02_01
		wJump		.09_02_02

.09
		wHeaderMus	$88, $0199
		dw	.09_00
		dw	.09_01
		dw	.09_02
		dw	$0000

.0A_00_01
.0A_00_02
		wSetVol		$14
		dc.b $C4
		wTempoDiv	$08
		wAddVol		$10
		dc.b $30, $3C, $3C, $36, $3C, $3C
		wLoopGoEnd

.0A_00_05
		wSetVol		$14
		dc.b $C4
		wAddVol		$10
		dc.b $49, $43, $44, $46, $45, $44, $46, $45
		dc.b $44, $46, $45, $44
		wLoopGoEnd

.0A_00_06
		wSetVol		$14
		dc.b $C4
		wAddVol		$10
		dc.b $48, $43, $45, $46, $45, $43, $48, $43
		dc.b $45, $46, $45, $43, $4B, $43, $44, $46
		dc.b $44, $43
		wAddVol		$F6
		dc.b $4A, $CF
		wStopRead
		wLoopGoEnd

.0A_00_00
		wSetVol		$14
		dc.b $C7
		wStopRead
		wLoopGoEnd

.0A_00_04
.0A_00_03
		dc.b $C9
		wStopRead
		wLoopGoEnd

.0A_00
		wSetMask	$30
		wSetPat		$1C
		wLoopGo		$00, .0A_00_00

.0A_00_07
		wLoopGo		$07, .0A_00_01
		wLoopGo		$05, .0A_00_02
		wLoopGo		$07, .0A_00_03
		wLoopGo		$01, .0A_00_04
		wLoopGo		$01, .0A_00_05
		wLoopGo		$00, .0A_00_06
		wJump		.0A_00_07

.0A_01_00
		wSetVol		$14
		dc.b $C6
		wTempoDiv	$0D
		wAddVol		$06
		dc.b $43, $C4
		wTempoDiv	$10
		dc.b $43
		wLoopGoEnd

.0A_01_01
		wSetVol		$14
		dc.b $C7
		wTempoDiv	$0D
		wAddVol		$06
		dc.b $48, $C6, $48, $C4
		wTempoDiv	$10
		dc.b $48, $C7, $4A, $C6, $48, $C4, $4A, $C7
		dc.b $4D, $C6, $4C, $C4, $4A, $C7, $4C, $48
		wSetTimerB	$D8
		dc.b $46, $C6, $45, $C4, $44, $CA, $43, $C4
		wStopRead
		dc.b $C7, $43
		wTempoDiv	$0D
		dc.b $4A, $C6, $4A, $C4
		wTempoDiv	$10
		dc.b $4A, $C7, $4D, $C6, $4C, $C4, $4A, $C7
		dc.b $4F, $4C, $4A, $48
		wSetTimerB	$D8
		dc.b $46, $C6, $43, $C4, $4A, $C9, $48, $C4
		dc.b $46, $45, $44, $43, $42, $41
		wLoopGoEnd

.0A_01_02
		wSetVol		$14
		dc.b $C9
		wAddVol		$06
		dc.b $41, $C7, $3C, $41, $3F, $3E, $3D, $3C
		dc.b $C4, $36, $37, $38, $39, $3A, $3B, $C9
		dc.b $3C, $C4, $42, $43, $44, $45, $46, $47
		dc.b $C9, $48
		wLoopGoEnd

.0A_01_03
		wSetVol		$14
		dc.b $C9
		wAddVol		$06
		dc.b $3D, $C7, $38, $41, $3F, $3D, $3C, $3A
		dc.b $C9, $A1, $3C, $A0, $3C, $9F, $3A, $C4
		wTempoDiv	$0D
		dc.b $9B, $3E, $C6
		wStopRead
		dc.b $43, $C4
		wTempoDiv	$10
		dc.b $43
		wLoopGoEnd

.0A_01
		wSetMask	$0E
		wSetPat		$29
		wLoopGo		$00, .0A_01_00

.0A_01_04
		wLoopGo		$00, .0A_01_01
		wLoopGo		$00, .0A_01_02
		wLoopGo		$00, .0A_01_03
		wJump		.0A_01_04

.0A_02_03
.0A_02_01
		wSetVol		$1A
		dc.b $C7
		wTempoDiv	$10
		wAddVol		$06
		dc.b $24, $30, $2E, $C4, $2B, $2C, $2D
		wLoopGoEnd

.0A_02_02
		wSetVol		$1A
		dc.b $C7
		wTempoDiv	$10
		wAddVol		$06
		dc.b $24, $C4, $2E, $2D, $2C, $C7, $2B, $C4
		wTempoDiv	$0D
		dc.b $2A, $2A, $2A
		wLoopGoEnd

.0A_02_04
		wSetVol		$1A
		dc.b $C7
		wTempoDiv	$10
		wAddVol		$06
		dc.b $24, $C4, $2E, $2D, $2C, $3A, $39, $38
		wTempoDiv	$0D
		dc.b $22, $22, $22
		wLoopGoEnd
	; Unused
		dc.b $F4, $1A, $C7, $F1, $10, $F5, $06, $26
		dc.b $32, $30, $C4, $2D, $2E, $2F, $FF

.0A_02_05
		wSetVol		$1A
		dc.b $C7
		wTempoDiv	$0D
		wAddVol		$06
		dc.b $24, $22, $27, $26
		wLoopGoEnd

.0A_02_06
		wSetVol		$1A
		dc.b $C7
		wTempoDiv	$0D
		wAddVol		$06
		dc.b $29, $C4, $33, $32, $31, $C7, $30, $C4
		dc.b $24, $24, $24
		wLoopGoEnd

.0A_02_07
		wSetVol		$1A
		dc.b $C7
		wTempoDiv	$0D
		wAddVol		$06
		dc.b $25, $C4, $31, $30, $2E, $C7, $2C, $C4
		dc.b $20, $20, $20
		wLoopGoEnd

.0A_02_08
		wSetVol		$1A
		dc.b $C7
		wTempoDiv	$0D
		wAddVol		$06
		dc.b $24, $C4, $1C, $1D, $1F, $C7, $24, $C4
		dc.b $1C, $1D, $1F, $C7, $20, $C4, $27, $26
		dc.b $24, $C7, $1F
		wStopRead
		wLoopGoEnd

.0A_02_00
		wSetVol		$1A
		dc.b $C7
		wStopRead
		wLoopGoEnd

.0A_02
		wSetMask	$01
		wSetPat		$29
		wLoopGo		$00, .0A_02_00

.0A_02_09
		wLoopGo		$01, .0A_02_01
		wLoopGo		$01, .0A_02_02
		wLoopGo		$01, .0A_02_03
		wLoopGo		$00, .0A_02_04
		wLoopGo		$00, .0A_02_05
		wLoopGo		$03, .0A_02_06
		wLoopGo		$01, .0A_02_07
		wLoopGo		$00, .0A_02_08
		wJump		.0A_02_09

.0A_03_04
		wSetVol		$14
		dc.b $C7
		wTempoDiv	$10
		wAddVol		$06
		dc.b $3C, $C4, $3A, $39, $38, $C7, $37, $3C
		dc.b $C4, $3A, $39, $3A, $39, $38, $39, $38
		dc.b $37, $38, $37, $36, $37, $33, $34, $35
		dc.b $36, $37, $38, $C9, $39, $C4, $3F, $40
		dc.b $41, $42, $43, $44, $C9, $45
		wLoopGoEnd

.0A_03_03
		wSetVol		$14
		dc.b $C7
		wTempoDiv	$0D
		wAddVol		$06
		dc.b $90
		wTempoDiv	$10
		dc.b $37, $C4
		wTempoDiv	$0D
		dc.b $8E
		wTempoDiv	$10
		dc.b $35
		wTempoDiv	$0D
		dc.b $8E
		wTempoDiv	$10
		dc.b $35
		wTempoDiv	$0D
		dc.b $8E
		wTempoDiv	$10
		dc.b $35, $C7
		wTempoDiv	$0D
		dc.b $93
		wTempoDiv	$10
		dc.b $3A, $C4, $39, $38, $37
		wLoopGoEnd

.0A_03_00
		dc.b $C7
		wStopRead
		wLoopGoEnd

.0A_03_02
.0A_03_01
.0A_03_05
		dc.b $C9
		wStopRead
		wLoopGoEnd

.0A_03
		wSetMask	$30
		wSetPat		$29
		wLoopGo		$00, .0A_03_00

.0A_03_06
		wLoopGo		$07, .0A_03_01
		wLoopGo		$05, .0A_03_02
		wLoopGo		$00, .0A_03_03
		wLoopGo		$00, .0A_03_04
		wLoopGo		$07, .0A_03_05
		wJump		.0A_03_06

.0A
		wHeaderMus	$88, $0200
		dw	.0A_00
		dw	.0A_01
		dw	.0A_02
		dw	.0A_03
		dw	$0000

.0B_00_01
		wSetVol		$F0
		dc.b $CA
		wTempoDiv	$10
		wAddVol		$21
		dc.b $30, $32, $C9, $34, $C6, $37, $C9, $39
		dc.b $C6, $37, $CA, $35
		wSetTimerB	$A8
		dc.b $34, $C2, $35, $34, $CA, $32, $C9, $2B
		dc.b $C6, $2F
		wLoopGoEnd

.0B_00_02
		wSetVol		$F0
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$21
		dc.b $30
		wAddVol		$05
		dc.b $37, $3C, $3E
		wStopRead
		dc.b $C6, $40, $C4
		wAddVol		$FB
		dc.b $32, $29, $C2, $41, $C5
		wStopRead
		dc.b $C4, $2D, $2B, $C2
		wAddVol		$0A
		dc.b $40, $C5
		wStopRead
		dc.b $C2, $3E
		wStopRead
		dc.b $C4
		wAddVol		$F6
		dc.b $30
		wAddVol		$0A
		dc.b $37, $3C, $3E
		wStopRead
		dc.b $C6, $40, $C4
		wAddVol		$F6
		dc.b $32, $29, $C2, $41, $C5
		wStopRead
		dc.b $C4, $2D, $2B, $C2, $3E, $C5
		wStopRead
		dc.b $C2
		wAddVol		$0A
		dc.b $37
		wStopRead
		dc.b $C4
		wAddVol		$F6
		dc.b $28
		wAddVol		$0A
		dc.b $37, $3B, $3E
		wStopRead
		dc.b $C6, $40, $C4
		wAddVol		$F6
		dc.b $32, $29, $C2, $41, $C5
		wStopRead
		dc.b $C4, $2D, $2B, $C2
		wAddVol		$0A
		dc.b $2F, $C5
		wStopRead
		dc.b $C6
		wAddVol		$F6
		dc.b $30, $C4
		wAddVol		$05
		dc.b $37, $34, $32, $C6
		wAddVol		$FB
		dc.b $30, $2B
		wLoopGoEnd

.0B_00_00
		wSetVol		$F0
		dc.b $C4
		wStopRead
		wLoopGoEnd

.0B_00
		wSetMask	$01
		wSetPat		$07
		wLoopGo		$00, .0B_00_00

.0B_00_03
		wLoopGo		$00, .0B_00_01
		wLoopGo		$00, .0B_00_02
		wJump		.0B_00_03

.0B_01_03
.0B_01_01
		wSetVol		$20
		dc.b $C2
		wTempoDiv	$08
		wAddVol		$09
		dc.b $3C, $37, $3C, $37, $3E, $37, $43, $37
		dc.b $3C, $37, $3C, $37, $3E, $37, $43, $37
		wLoopGoEnd

.0B_01_06
.0B_01_04
.0B_01_02
		wSetVol		$20
		dc.b $C2
		wTempoDiv	$08
		wAddVol		$09
		dc.b $3E, $35, $3C, $35, $3E, $35, $43, $35
		dc.b $3E, $35, $3C, $35, $3E, $35, $43, $35
		wLoopGoEnd

.0B_01_05
.0B_01_07
		wSetVol		$20
		dc.b $C2
		wTempoDiv	$08
		wAddVol		$09
		dc.b $40, $37, $3E, $37, $40, $37, $3E, $37
		dc.b $40, $37, $3E, $37, $40, $37, $3E, $37
		wLoopGoEnd

.0B_01_08
		wSetVol		$20
		dc.b $CA
		wStopRead
		wLoopGoEnd

.0B_01_00
		wSetVol		$20
		dc.b $C4
		wStopRead
		wLoopGoEnd

.0B_01
		wSetMask	$0C
		wSetPat		$26
		wSetFreq	$0C00
		wLoopGo		$00, .0B_01_00

.0B_01_09
		wLoopGo		$00, .0B_01_01
		wLoopGo		$00, .0B_01_02
		wLoopGo		$01, .0B_01_03
		wLoopGo		$00, .0B_01_04
		wLoopGo		$00, .0B_01_05
		wLoopGo		$00, .0B_01_06
		wLoopGo		$00, .0B_01_07
		wLoopGo		$06, .0B_01_08
		wJump		.0B_01_09

.0B_02_00
		wSetVol		$24
		dc.b $C2
		wTempoDiv	$0C
		wAddVol		$FC
		dc.b $3C, $3E
		wLoopGoEnd

.0B_02_01
		wSetVol		$24
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$FC
		dc.b $40, $C6, $43, $C8, $40, $C2
		wTempoDiv	$0C
		dc.b $3C, $3E, $C4
		wTempoDiv	$0D
		dc.b $40, $C6, $43, $C8, $40, $C2
		wTempoDiv	$0C
		dc.b $3C, $3E, $C4
		wTempoDiv	$0D
		dc.b $40, $43, $43, $48, $CD
		wTempoDiv	$10
		dc.b $47, $45, $43
		wSetTimerB	$A8
		wTempoDiv	$0D
		dc.b $40, $C2
		wTempoDiv	$0C
		dc.b $3E, $40, $C4
		wTempoDiv	$0D
		dc.b $41, $C6, $43, $C8, $3C, $C2
		wTempoDiv	$0C
		dc.b $3E, $40, $C4
		wTempoDiv	$0D
		dc.b $41, $C6, $43, $C8, $3B, $C2
		wTempoDiv	$0C
		dc.b $41, $40, $C7
		wTempoDiv	$0D
		wAddVol		$0A
		dc.b $3E, $C4, $40, $41, $43, $45, $48, $C7
		wTempoDiv	$10
		dc.b $47, $C0
		wStopRead
		dc.b $46, $45, $44, $C7
		wTempoDiv	$0D
		wAddVol		$F6
		dc.b $43, $C4
		wStopRead
		wLoopGoEnd

.0B_02_03
		wSetVol		$24
		wSetTimerB	$A8
		wStopRead
		dc.b $C2
		wTempoDiv	$10
		wAddVol		$06
		dc.b $3C, $3E
		wLoopGoEnd

.0B_02_02
		wSetVol		$24
		dc.b $CA
		wStopRead
		wLoopGoEnd

.0B_02
		wSetMask	$02
		wSetPat		$29
		wModOn		$0A
		wLoopGo		$00, .0B_02_00

.0B_02_04
		wLoopGo		$00, .0B_02_01
		wLoopGo		$05, .0B_02_02
		wLoopGo		$00, .0B_02_03
		wJump		.0B_02_04

.0B_03_02
		wSetVol		$0E
		dc.b $C7
		wStopRead
		dc.b $C4
		wTempoDiv	$06
		wAddVol		$21
		dc.b $AC, $4F
		wStopRead
		dc.b $AA, $4D
		wStopRead
		dc.b $A8, $4C, $C7
		wStopRead
		dc.b $C4, $B1, $54, $AF, $53, $C2
		wStopRead
		wTempoDiv	$0C
		dc.b $AD, $51, $C4
		wStopRead
		wTempoDiv	$06
		dc.b $AC, $4F, $C7
		wStopRead
		dc.b $C4
		wTempoDiv	$05
		dc.b $A5, $48, $A7, $4A, $A8, $4C, $AA, $4D
		dc.b $AC, $4F, $C7
		wStopRead
		dc.b $C4
		wTempoDiv	$06
		dc.b $B1, $54, $AF, $53, $C2
		wStopRead
		wTempoDiv	$0C
		dc.b $AD, $51, $C4
		wStopRead
		wTempoDiv	$06
		dc.b $AC, $4F, $C8
		wStopRead
		dc.b $C4, $AA, $4D, $C2
		wStopRead
		dc.b $C4, $A8, $4C, $C5
		wStopRead
		dc.b $C4
		wStopRead
		dc.b $A1, $45, $C7
		wStopRead
		dc.b $C4, $A3, $47
		wStopRead
		dc.b $A3, $48
		wLoopGoEnd

.0B_03_01
.0B_03_03
		wSetVol		$0E
		dc.b $CA
		wStopRead
		wLoopGoEnd

.0B_03_00
		wSetVol		$0E
		dc.b $C4
		wStopRead
		wLoopGoEnd

.0B_03
		wSetMask	$0A
		wSetPat		$0B
		wSetFreq	$F400
		wLoopGo		$00, .0B_03_00

.0B_03_04
		wLoopGo		$07, .0B_03_01
		wLoopGo		$00, .0B_03_02
		wLoopGo		$00, .0B_03_03
		wJump		.0B_03_04

.0B_04_02
		wSetVol		$00
		dc.b $CF
		wStopRead
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$21
		dc.b $3C, $3B, $39, $C9, $37, $C4, $32, $34
		dc.b $C6, $35, $C4, $37, $39
		wStopRead
		wAddVol		$F6
		dc.b $3C
		wStopRead
		dc.b $C6
		wAddVol		$F6
		dc.b $3B, $C4
		wAddVol		$14
		dc.b $37, $C8
		wStopRead
		dc.b $C4
		wAddVol		$0A
		dc.b $32
		wAddVol		$F6
		dc.b $34, $C6, $35, $C4
		wAddVol		$F6
		dc.b $37, $C2
		wAddVol		$0A
		dc.b $34, $C5
		wStopRead
		dc.b $C2, $32, $C5
		wStopRead
		dc.b $C7
		wAddVol		$F6
		dc.b $3B, $C4
		wAddVol		$0A
		dc.b $37, $C7
		wStopRead
		dc.b $C4, $32, $34, $C6, $35, $C4, $37, $34
		wStopRead
		wAddVol		$FB
		dc.b $32
		wStopRead
		dc.b $CF
		wAddVol		$FB
		dc.b $30, $C8
		wStopRead
		wLoopGoEnd

.0B_04_01
		wSetVol		$00
		dc.b $CA
		wStopRead
		wLoopGoEnd

.0B_04_00
		wSetVol		$00
		dc.b $C4
		wStopRead
		wLoopGoEnd

.0B_04
		wSetMask	$04
		wSetPat		$00
		wLoopGo		$00, .0B_04_00

.0B_04_03
		wLoopGo		$06, .0B_04_01
		wLoopGo		$00, .0B_04_02
		wJump		.0B_04_03

.0B_05_01
.0B_05_05
.0B_05_07
.0B_05_03
		wSetVol		$00
		dc.b $C6
		wAddVol		$1C
		dc.b $0F, $0F, $0F
		wAddVol		$F6
		dc.b $71
		wAddVol		$0A
		dc.b $0F
		wLoopGoEnd

.0B_05_08
.0B_05_02
		wSetVol		$00
		dc.b $C6
		wAddVol		$1C
		dc.b $0F, $C4, $0F
		wAddVol		$0A
		dc.b $0D, $0D
		wStopRead
		wAddVol		$F6
		dc.b $0C, $C2
		wAddVol		$F6
		dc.b $0C
		wAddVol		$F6
		dc.b $0C
		wLoopGoEnd

.0B_05_04
.0B_05_06
		wSetVol		$00
		dc.b $C6
		wAddVol		$1C
		dc.b $0F, $C2
		wAddVol		$F6
		dc.b $71
		wAddVol		$0A
		dc.b $0F, $C5
		wStopRead
		dc.b $C6, $0F
		wAddVol		$F6
		dc.b $71
		wAddVol		$0A
		dc.b $0F
		wLoopGoEnd

.0B_05_00
		wSetVol		$00
		dc.b $C4
		wStopRead
		wLoopGoEnd

.0B_05
		wDrumChannel
		wLoopGo		$00, .0B_05_00

.0B_05_09
		wLoopGo		$06, .0B_05_01
		wLoopGo		$00, .0B_05_02
		wLoopGo		$00, .0B_05_03
		wLoopGo		$00, .0B_05_04
		wLoopGo		$00, .0B_05_05
		wLoopGo		$00, .0B_05_06
		wLoopGo		$01, .0B_05_07
		wLoopGo		$00, .0B_05_08
		wJump		.0B_05_09

.0B
		wHeaderMus	$88, $0134
		dw	.0B_00
		dw	.0B_01
		dw	.0B_02
		dw	.0B_03
		dw	.0B_04
		dw	.0B_05
		dw	$0000

.0C_00_02
.0C_00_07
		wSetVol		$FC
		dc.b $C6
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $30, $2B, $30, $2B
		wLoopGoEnd

.0C_00_06
.0C_00_09
.0C_00_04
		wSetVol		$FC
		dc.b $C6
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $32, $2D, $32, $2D, $2B, $32, $C4, $37
		dc.b $37, $35, $32
		wLoopGoEnd

.0C_00_05
.0C_00_0A
		wSetVol		$FC
		dc.b $C6
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $29, $30, $29, $30, $C4, $30, $3C, $30
		dc.b $3B, $30, $39, $C2
		wTempoDiv	$0C
		dc.b $37, $37, $C4
		wTempoDiv	$0D
		dc.b $37
		wLoopGoEnd

.0C_00_0C
.0C_00_01
.0C_00_11
		wSetVol		$FC
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$0D
		dc.b $30, $30, $C2
		wStopRead
		wTempoDiv	$0C
		dc.b $30
		wStopRead
		dc.b $30, $C4
		wTempoDiv	$0D
		dc.b $30
		wStopRead
		dc.b $C0
		wTempoDiv	$10
		wAddVol		$0A
		dc.b $36
		wSetTimerB	$2A
		dc.b $37
		wLoopGoEnd

.0C_00_03
.0C_00_08
		wSetVol		$FC
		dc.b $C6
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $30, $2B, $30, $C0
		wTempoDiv	$10
		dc.b $36
		wSetTimerB	$2A
		dc.b $37
		wLoopGoEnd

.0C_00_0B
		wSetVol		$FC
		dc.b $C6
		wTempoDiv	$10
		wAddVol		$17
		dc.b $29, $30, $C4, $2B
		wStopRead
		dc.b $C0, $31
		wSetTimerB	$2A
		dc.b $32
		wLoopGoEnd

.0C_00_0D
		wSetVol		$FC
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $29
		wStopRead
		dc.b $30
		wStopRead
		dc.b $C2
		wTempoDiv	$0C
		dc.b $35, $35, $35, $C4
		wTempoDiv	$0D
		dc.b $35, $C2
		wTempoDiv	$0C
		dc.b $34, $C4
		wTempoDiv	$0D
		dc.b $32, $30
		wStopRead
		dc.b $2B
		wStopRead
		dc.b $C2
		wTempoDiv	$0C
		dc.b $30, $30, $30, $30
		wStopRead
		dc.b $2E, $C4
		wTempoDiv	$0D
		dc.b $2D
		wLoopGoEnd

.0C_00_0E
		wSetVol		$FC
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $2B
		wStopRead
		dc.b $32
		wStopRead
		dc.b $C2
		wTempoDiv	$0C
		dc.b $37, $37, $37, $C4
		wTempoDiv	$0D
		dc.b $37, $C2
		wTempoDiv	$0C
		dc.b $35, $C4
		wTempoDiv	$0D
		dc.b $32, $30
		wStopRead
		dc.b $2B
		wStopRead
		dc.b $C2
		wTempoDiv	$0C
		dc.b $30, $30, $30, $30
		wStopRead
		dc.b $32, $C4
		wTempoDiv	$0D
		dc.b $34, $32
		wStopRead
		dc.b $2D
		wStopRead
		dc.b $C2
		wTempoDiv	$0C
		dc.b $32, $32, $32, $C4
		wTempoDiv	$0D
		dc.b $32, $C2
		wTempoDiv	$0C
		dc.b $34, $C4
		wTempoDiv	$0D
		dc.b $35, $2B
		wStopRead
		dc.b $32
		wStopRead
		dc.b $C2
		wTempoDiv	$0C
		dc.b $37, $37, $37, $C4
		wTempoDiv	$0D
		dc.b $37, $C2
		wTempoDiv	$0C
		dc.b $35, $C4
		wTempoDiv	$0D
		dc.b $32
		wLoopGoEnd

.0C_00_0F
		wSetVol		$FC
		dc.b $C2
		wTempoDiv	$0C
		wAddVol		$17
		dc.b $30, $30, $C6
		wStopRead
		dc.b $C2, $34, $34, $2B, $2B, $C7
		wStopRead
		dc.b $C2, $32, $32, $C6
		wStopRead
		dc.b $C2, $30, $30, $2D, $2D, $C7
		wStopRead
		dc.b $C2, $30, $30, $C6
		wStopRead
		dc.b $C2, $34, $34, $2B, $2B, $C4
		wTempoDiv	$0D
		dc.b $37
		wStopRead
		dc.b $37, $C2
		wTempoDiv	$0C
		dc.b $2B, $2B, $C6
		wStopRead
		dc.b $C2, $32, $32, $37, $37
		wStopRead
		dc.b $37, $35, $34, $C4
		wTempoDiv	$0D
		dc.b $32
		wLoopGoEnd

.0C_00_00
.0C_00_10
		wSetVol		$FC
		dc.b $C6
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $30, $2B, $30, $37, $32, $2D, $32, $39
		dc.b $C5, $35, $30, $C4, $35, $C5, $37, $32
		dc.b $C4, $37
		wLoopGoEnd

.0C_00
		wSetType	$00
		wSetMask	$01
		wSetPat		$09
		wLoopGo		$00, .0C_00_00
		wLoopGo		$00, .0C_00_01

.0C_00_12
		wLoopGo		$00, .0C_00_02
		wLoopGo		$00, .0C_00_03
		wLoopGo		$00, .0C_00_04
		wLoopGo		$00, .0C_00_05
		wLoopGo		$00, .0C_00_06
		wLoopGo		$00, .0C_00_07
		wLoopGo		$00, .0C_00_08
		wLoopGo		$00, .0C_00_09
		wLoopGo		$00, .0C_00_0A
		wLoopGo		$00, .0C_00_0B
		wLoopGo		$00, .0C_00_0C
		wLoopGo		$01, .0C_00_0D
		wLoopGo		$00, .0C_00_0E
		wLoopGo		$00, .0C_00_0F
		wLoopGo		$00, .0C_00_10
		wLoopGo		$00, .0C_00_11
		wJump		.0C_00_12

.0C_01_0A
.0C_01_04
		wSetVol		$2C
		dc.b $C4
		wTempoDiv	$0A
		wAddVol		$F7
		dc.b $9C, $40, $9C, $40, $C2
		wTempoDiv	$09
		dc.b $9B, $40, $9B, $40
		wStopRead
		dc.b $99, $40
		wStopRead
		dc.b $99, $40
		wStopRead
		dc.b $9B, $40, $C4
		wTempoDiv	$0A
		dc.b $9B, $40
		wStopRead
		wLoopGoEnd

.0C_01_08
		wSetVol		$2C
		dc.b $C4
		wTempoDiv	$0A
		wAddVol		$F7
		dc.b $9E, $41, $9E, $41, $C2
		wTempoDiv	$09
		dc.b $9C, $41, $9C, $41
		wStopRead
		dc.b $9B, $41
		wStopRead
		dc.b $9B, $41
		wStopRead
		dc.b $9C, $41, $C4
		wTempoDiv	$0A
		dc.b $9C, $41, $99, $41, $9E, $41, $9E, $41
		dc.b $C2
		wTempoDiv	$09
		dc.b $9C, $41, $9C, $41
		wStopRead
		dc.b $9B, $41
		wStopRead
		wTempoDiv	$10
		dc.b $9B, $41
		wTempoDiv	$0C
		wAddVol		$FB
		dc.b $AC, $4F, $AD, $51, $AF, $53, $B1, $54
		dc.b $AF, $53, $AD, $51
		wLoopGoEnd

.0C_01_0D
.0C_01_07
		wSetVol		$2C
		dc.b $C4
		wTempoDiv	$0A
		wAddVol		$F7
		dc.b $99, $41, $99, $41, $C2
		wTempoDiv	$09
		dc.b $A0, $39, $A0, $39
		wStopRead
		dc.b $9E, $39
		wStopRead
		dc.b $9E, $39
		wStopRead
		dc.b $A0, $39, $C4
		wTempoDiv	$0A
		dc.b $A0, $39, $9C, $39, $A0, $43, $C2
		wTempoDiv	$09
		dc.b $37, $C4
		wTempoDiv	$0A
		dc.b $9E, $41, $C2
		wStopRead
		wTempoDiv	$09
		dc.b $37, $37, $C4
		wTempoDiv	$0A
		dc.b $9C, $40, $C2
		wTempoDiv	$09
		dc.b $37, $C4
		wTempoDiv	$0D
		dc.b $9B, $3E, $C5
		wStopRead
		wLoopGoEnd

.0C_01_1D
.0C_01_02
		wSetVol		$2C
		dc.b $C4
		wTempoDiv	$0A
		wAddVol		$F7
		dc.b $9C, $40, $9C, $40, $C2
		wStopRead
		wTempoDiv	$09
		dc.b $9C, $40
		wStopRead
		dc.b $9C, $40, $C4
		wTempoDiv	$0A
		dc.b $9C, $40, $C7
		wStopRead
		wLoopGoEnd

.0C_01_09
.0C_01_03
.0C_01_1B
.0C_01_19
.0C_01_00
.0C_01_17
		wSetVol		$2C
		dc.b $C4
		wTempoDiv	$0A
		wAddVol		$F7
		dc.b $9C, $40, $9C, $40, $C2
		wTempoDiv	$09
		dc.b $9B, $40, $9B, $40
		wStopRead
		dc.b $99, $40
		wStopRead
		dc.b $99, $40
		wStopRead
		dc.b $9B, $40, $C4
		wTempoDiv	$0A
		dc.b $9B, $40, $97, $40
		wLoopGoEnd

.0C_01_0E
		wSetVol		$2C
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$F7
		dc.b $95, $3C, $95, $3C, $C2
		wStopRead
		wTempoDiv	$0C
		dc.b $95, $3C
		wStopRead
		dc.b $95, $3C, $C4
		wTempoDiv	$0D
		dc.b $97, $3E
		wStopRead
		dc.b $9C, $40
		wStopRead
		wTempoDiv	$0A
		dc.b $9C, $37, $9C, $37, $C2
		wStopRead
		wTempoDiv	$09
		dc.b $9C, $37
		wStopRead
		dc.b $9C, $37, $C4
		wTempoDiv	$0A
		dc.b $9C, $37, $C2
		wTempoDiv	$0C
		dc.b $AC, $4F, $AA, $4D, $A8, $4C, $A6, $4A
		dc.b $A5, $48, $A3, $46
		wLoopGoEnd

.0C_01_0F
.0C_01_11
.0C_01_15
		wSetVol		$2C
		dc.b $C4
		wTempoDiv	$08
		wAddVol		$ED
		dc.b $45, $48, $4D, $C2, $45, $48
		wStopRead
		dc.b $4D
		wStopRead
		dc.b $45, $C4, $48, $4D
		wLoopGoEnd

.0C_01_10
.0C_01_14
		wSetVol		$2C
		dc.b $C4
		wTempoDiv	$08
		wAddVol		$ED
		dc.b $43, $48, $4C, $C2, $43, $48
		wStopRead
		dc.b $4C, $48
		wStopRead
		dc.b $4C, $4C, $C4, $43
		wLoopGoEnd

.0C_01_0C
.0C_01_06
		wSetVol		$2C
		dc.b $C4
		wTempoDiv	$0A
		wAddVol		$F7
		dc.b $9E, $41, $9E, $41, $C2
		wTempoDiv	$09
		dc.b $9C, $41, $9C, $41
		wStopRead
		dc.b $9B, $41
		wStopRead
		dc.b $9B, $41
		wStopRead
		wTempoDiv	$0C
		dc.b $9B, $41, $C6
		wTempoDiv	$0D
		dc.b $9C, $41
		wLoopGoEnd

.0C_01_13
		wSetVol		$2C
		dc.b $C4
		wTempoDiv	$08
		wAddVol		$ED
		dc.b $43, $47, $4A, $C2, $43, $47
		wStopRead
		dc.b $4A
		wStopRead
		dc.b $43, $C4
		wTempoDiv	$03
		dc.b $47
		wTempoDiv	$08
		dc.b $4D
		wLoopGoEnd

.0C_01_16
		wSetVol		$2C
		dc.b $C4
		wTempoDiv	$08
		wAddVol		$F7
		dc.b $43, $4A, $4F, $C2, $4A, $C4, $47, $C2
		dc.b $43, $C4, $47, $4A, $43
		wLoopGoEnd

.0C_01_0B
.0C_01_05
.0C_01_01
.0C_01_18
.0C_01_1C
		wSetVol		$2C
		dc.b $C4
		wTempoDiv	$0A
		wAddVol		$F7
		dc.b $9E, $41, $9E, $41, $C2
		wTempoDiv	$09
		dc.b $9C, $41, $9C, $41
		wStopRead
		dc.b $9B, $41
		wStopRead
		dc.b $9B, $41
		wStopRead
		dc.b $9C, $41, $C4
		wTempoDiv	$0A
		dc.b $9C, $41, $99, $41
		wLoopGoEnd

.0C_01_1A
		wSetVol		$2C
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$F7
		dc.b $9E, $43, $C2
		wTempoDiv	$0C
		dc.b $9E, $43, $9C, $43
		wStopRead
		dc.b $9C, $43
		wStopRead
		dc.b $9B, $43, $C4
		wStopRead
		dc.b $C2
		wAddVol		$F6
		dc.b $AC, $4F, $AD, $51, $AF, $53, $B1, $54
		dc.b $AF, $53, $AD, $51
		wLoopGoEnd

.0C_01_12
		wSetVol		$2C
		dc.b $C4
		wStopRead
		wTempoDiv	$08
		wAddVol		$ED
		dc.b $4D, $4C, $4A, $48, $47, $45, $43
		wLoopGoEnd

.0C_01
		wSetMask	$0C
		wSetPat		$03
		wLoopGo		$00, .0C_01_00
		wLoopGo		$01, .0C_01_01
		wLoopGo		$00, .0C_01_02

.0C_01_1E
		wLoopGo		$00, .0C_01_03
		wLoopGo		$00, .0C_01_04
		wLoopGo		$00, .0C_01_05
		wLoopGo		$00, .0C_01_06
		wLoopGo		$00, .0C_01_07
		wLoopGo		$00, .0C_01_08
		wLoopGo		$00, .0C_01_09
		wLoopGo		$00, .0C_01_0A
		wLoopGo		$00, .0C_01_0B
		wLoopGo		$00, .0C_01_0C
		wLoopGo		$00, .0C_01_0D
		wLoopGo		$00, .0C_01_0E
		wLoopGo		$00, .0C_01_0F
		wLoopGo		$00, .0C_01_10
		wLoopGo		$00, .0C_01_11
		wLoopGo		$00, .0C_01_12
		wLoopGo		$00, .0C_01_13
		wLoopGo		$00, .0C_01_14
		wLoopGo		$00, .0C_01_15
		wLoopGo		$00, .0C_01_16
		wLoopGo		$00, .0C_01_17
		wLoopGo		$00, .0C_01_18
		wLoopGo		$00, .0C_01_19
		wLoopGo		$00, .0C_01_1A
		wLoopGo		$00, .0C_01_1B
		wLoopGo		$01, .0C_01_1C
		wLoopGo		$00, .0C_01_1D
		wJump		.0C_01_1E

.0C_02_00
		wSetVol		$0C
		dc.b $C9
		wStopRead
		dc.b $C5
		wTempoDiv	$10
		wAddVol		$0D
		dc.b $43, $C2
		wStopRead
		wLoopGoEnd

.0C_02_03
.0C_02_01
		wSetVol		$0C
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$0D
		dc.b $48, $C2
		wStopRead
		dc.b $48, $C7
		wStopRead
		dc.b $C2, $43
		wStopRead
		dc.b $48
		wStopRead
		dc.b $4A
		wStopRead
		dc.b $C4, $4C, $C2, $4D, $4C
		wStopRead
		dc.b $4C, $4A
		wStopRead
		dc.b $4A
		wStopRead
		dc.b $4A, $48
		wStopRead
		dc.b $48, $C4, $47, $C7, $45, $C4, $4C, $C7
		dc.b $4A, $C4, $48, $47, $C2, $48, $47
		wStopRead
		dc.b $47, $C4, $45, $43
		wStopRead
		dc.b $C5, $43, $C2
		wStopRead
		dc.b $C4, $4A, $C2
		wStopRead
		dc.b $4A, $C7
		wStopRead
		dc.b $C2, $4A
		wStopRead
		dc.b $4C
		wStopRead
		dc.b $4D
		wStopRead
		dc.b $C4, $4F, $C2, $43, $C4, $4C, $C2, $4A
		dc.b $4C
		wStopRead
		dc.b $C4, $4A, $C2, $43, $C4, $4A, $C2, $43
		dc.b $48, $47
		wLoopGoEnd

.0C_02_02
		wSetVol		$0C
		dc.b $C5
		wTempoDiv	$10
		wAddVol		$0D
		dc.b $45, $47, $C4, $48, $C5, $4A, $4C, $C4
		dc.b $48, $C7, $4A, $C4
		wStopRead
		dc.b $C8
		wAddVol		$0A
		dc.b $43
		wLoopGoEnd

.0C_02_04
		wSetVol		$0C
		dc.b $C5
		wTempoDiv	$10
		wAddVol		$0D
		dc.b $45, $48, $C4, $4C, $4A
		wStopRead
		dc.b $C6, $4C, $C2, $48
		wStopRead
		dc.b $48, $C4
		wStopRead
		dc.b $C2, $48
		wStopRead
		dc.b $48, $48
		wSetTimerB	$54
		wStopRead
		wLoopGoEnd

.0C_02_05
		wSetVol		$0C
		dc.b $C5
		wTempoDiv	$10
		wAddVol		$0D
		dc.b $51, $C4, $4D, $C2
		wStopRead
		dc.b $C4, $48, $C2
		wStopRead
		dc.b $45
		wStopRead
		dc.b $45, $C4, $4D, $51, $C5, $4F, $C4, $4C
		dc.b $C2
		wStopRead
		dc.b $C4, $48, $C6
		wStopRead
		dc.b $47, $C5, $51, $C4, $4D, $C2
		wStopRead
		dc.b $C4, $48, $C2
		wStopRead
		dc.b $45
		wStopRead
		dc.b $45, $C4, $4D, $51, $C8, $4F
		wStopRead
		dc.b $C5, $4D, $C4, $4A, $C2
		wStopRead
		dc.b $C4, $47, $C2
		wStopRead
		dc.b $43
		wStopRead
		dc.b $43, $C4, $4A, $4D, $C5, $4C, $C2, $4F
		dc.b $C4
		wStopRead
		dc.b $48, $C6
		wStopRead
		dc.b $47, $C5, $45, $47, $C4, $48, $C2, $4A
		wStopRead
		dc.b $C4, $45, $47, $48, $C7, $4A, $C2, $47
		dc.b $45, $C4, $43
		wStopRead
		dc.b $C6, $43
		wLoopGoEnd

.0C_02_08
.0C_02_06
		wSetVol		$0C
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$03
		dc.b $48, $C2
		wTempoDiv	$0C
		dc.b $48, $48
		wStopRead
		wTempoDiv	$10
		wAddVol		$14
		dc.b $48, $C8, $4C, $C4
		wAddVol		$EC
		dc.b $43
		wTempoDiv	$0D
		dc.b $4A, $C2
		wTempoDiv	$0C
		dc.b $4A, $4A
		wStopRead
		wTempoDiv	$10
		dc.b $4A, $C8, $4D, $C2, $4C, $4D
		wLoopGoEnd

.0C_02_07
		wSetVol		$0C
		dc.b $C2
		wTempoDiv	$10
		wAddVol		$0D
		dc.b $4F
		wStopRead
		wAddVol		$F6
		dc.b $4C, $C4, $4D, $C2, $4A
		wAddVol		$0A
		dc.b $4C
		wStopRead
		wAddVol		$F6
		dc.b $48, $C4, $4A, $C2, $47, $48
		wStopRead
		dc.b $45
		wStopRead
		dc.b $47
		wStopRead
		dc.b $47, $48
		wStopRead
		dc.b $48, $C7
		wAddVol		$0A
		dc.b $4A, $C6, $43
		wLoopGoEnd

.0C_02_09
		wSetVol		$0C
		dc.b $C2
		wTempoDiv	$10
		wAddVol		$0D
		dc.b $4F
		wStopRead
		wAddVol		$F6
		dc.b $4C, $C4, $4D, $C2
		wStopRead
		dc.b $4A
		wAddVol		$0A
		dc.b $4C
		wStopRead
		wAddVol		$F6
		dc.b $48
		wAddVol		$0A
		dc.b $4A
		wStopRead
		dc.b $4A
		wStopRead
		dc.b $C4, $4C, $C2, $48
		wStopRead
		dc.b $48, $C4
		wStopRead
		dc.b $C2, $48
		wStopRead
		dc.b $48, $48, $C5
		wStopRead
		dc.b $43, $C2
		wStopRead
		wLoopGoEnd

.0C_02
		wSetMask	$02
		wSetPat		$29
		dc.b $CA
		wStopRead
		wStopRead
		wStopRead
		wLoopGo		$00, .0C_02_00

.0C_02_0A
		wLoopGo		$00, .0C_02_01
		wLoopGo		$00, .0C_02_02
		wLoopGo		$00, .0C_02_03
		wLoopGo		$00, .0C_02_04
		wSetPat		$02
		wLoopGo		$00, .0C_02_05
		wSetPat		$29
		wLoopGo		$00, .0C_02_06
		wLoopGo		$00, .0C_02_07
		wLoopGo		$00, .0C_02_08
		wLoopGo		$00, .0C_02_09
		wJump		.0C_02_0A

.0C_03_0E
.0C_03_10
.0C_03_00
.0C_03_06
.0C_03_02
.0C_03_04
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $60, $0B, $08, $0B, $08, $65, $08, $0A
		dc.b $0A, $07, $60, $07, $C4, $0B, $C2, $0B
		dc.b $C4, $65, $0A, $C2, $07, $07
		wLoopGoEnd

.0C_03_05
.0C_03_01
.0C_03_07
.0C_03_0B
.0C_03_11
.0C_03_03
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $60, $0B, $08, $0B, $08, $0D, $0D, $0C
		dc.b $07, $60, $07, $C4, $14, $C2, $14, $C4
		dc.b $14, $15
		wLoopGoEnd

.0C_03_0A
.0C_03_08
.0C_03_0C
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $60, $0B, $08, $65, $0B, $08, $60, $08
		dc.b $0A, $65, $0A, $07, $60, $07, $0B, $05
		dc.b $0B, $60, $0A
		wStopRead
		dc.b $65, $07, $07
		wLoopGoEnd

.0C_03_0F
.0C_03_0D
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $60, $0B, $08, $0B, $08, $0D, $0D, $0C
		dc.b $07, $60, $07
		wAddVol		$F6
		dc.b $13
		wStopRead
		dc.b $13, $13
		wStopRead
		dc.b $13
		wAddVol		$0A
		dc.b $07
		wLoopGoEnd

.0C_03_09
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $60, $0B, $08, $65, $0B, $08, $60, $08
		dc.b $0A, $65, $0A, $07, $60, $07
		wAddVol		$FB
		dc.b $13
		wAddVol		$05
		dc.b $05
		wAddVol		$F6
		dc.b $13
		wAddVol		$0A
		dc.b $60
		wAddVol		$F6
		dc.b $13
		wStopRead
		wAddVol		$0A
		dc.b $65
		wAddVol		$F6
		dc.b $13
		wAddVol		$0A
		dc.b $07
		wLoopGoEnd

.0C_03
		wDrumChannel
		wLoopGo		$02, .0C_03_00
		wLoopGo		$00, .0C_03_01

.0C_03_12
		wLoopGo		$02, .0C_03_02
		wLoopGo		$00, .0C_03_03
		wLoopGo		$02, .0C_03_04
		wLoopGo		$00, .0C_03_05
		wLoopGo		$06, .0C_03_06
		wLoopGo		$00, .0C_03_07
		wLoopGo		$00, .0C_03_08
		wLoopGo		$00, .0C_03_09
		wLoopGo		$02, .0C_03_0A
		wLoopGo		$00, .0C_03_0B
		wLoopGo		$00, .0C_03_0C
		wLoopGo		$00, .0C_03_0D
		wLoopGo		$02, .0C_03_0E
		wLoopGo		$00, .0C_03_0F
		wLoopGo		$02, .0C_03_10
		wLoopGo		$00, .0C_03_11
		wJump		.0C_03_12

.0C
		wHeaderMus	$88, $01AA
		dw	.0C_00
		dw	.0C_01
		dw	.0C_02
		dw	.0C_03
		dw	$0000

.0D_00_00
.0D_00_01
		wSetVol		$10
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$FC
		dc.b $28, $30, $28, $2F, $28, $2D, $28, $2B
		dc.b $28, $2B, $28, $2D, $28, $2F, $28, $2D
		wLoopGoEnd
	; Unused
		dc.b $F4, $10, $C4, $F1, $0D, $F5, $FC, $28
	; Unused
		dc.b $30, $28, $2F, $28, $2D, $28, $2B, $28
		dc.b $2B, $28, $2D, $28, $2F, $28, $2D, $FF

.0D_00_02
		wSetVol		$10
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$FC
		dc.b $26, $2F, $26, $2D, $26, $2B, $26, $2A
		dc.b $26, $28, $26, $2A, $26, $2B, $26, $28
		wLoopGoEnd

.0D_00_03
		wSetVol		$10
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$FC
		dc.b $26, $2F, $26, $2D, $26, $2B, $26, $2A
		wLoopGoEnd

.0D_00_05
.0D_00_07
		wSetVol		$10
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$FC
		dc.b $2F, $2D, $2B, $2A, $2F, $36, $2F, $34
		dc.b $2F, $2D, $2B, $29, $2F, $3B, $2F, $3B
		wLoopGoEnd

.0D_00_08
.0D_00_06
		wSetVol		$10
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$FC
		dc.b $2B, $2D, $2B, $2F, $2B, $2D, $2B, $2F
		dc.b $2A, $2B, $2A, $2D, $2A, $2B, $2A, $2B
		wLoopGoEnd

.0D_00_09
.0D_00_04
		wSetVol		$10
		dc.b $CD
		wTempoDiv	$10
		wAddVol		$FC
		dc.b $2D, $2B, $2D, $34, $32, $30
		wLoopGoEnd

.0D_00
		wSetType	$00
		wSetMask	$01
		wSetPat		$08
		wLoopGo		$00, .0D_00_00

.0D_00_0A
		wLoopGo		$05, .0D_00_01
		wLoopGo		$00, .0D_00_02
		wLoopGo		$00, .0D_00_03
		wLoopGo		$00, .0D_00_04
		wLoopGo		$02, .0D_00_05
		wLoopGo		$00, .0D_00_06
		wLoopGo		$02, .0D_00_07
		wLoopGo		$00, .0D_00_08
		dc.b $CA
		wStopRead
		wStopRead
		wStopRead
		wLoopGo		$00, .0D_00_09
		wJump		.0D_00_0A

.0D_01_01
		wSetVol		$03
		dc.b $C9
		wTempoDiv	$10
		wAddVol		$17
		dc.b $47, $C6, $45, $C9, $4A, $C6, $48, $C7
		dc.b $47, $43, $45, $41, $C6, $43, $41, $CA
		dc.b $40
		wLoopGoEnd

.0D_01_02
		wSetVol		$03
		dc.b $C4
		wStopRead
		dc.b $C2
		wTempoDiv	$10
		wAddVol		$2B
		dc.b $B3, $58, $C5
		wStopRead
		dc.b $C2
		wAddVol		$F1
		dc.b $B1, $56, $C5
		wStopRead
		dc.b $C2
		wAddVol		$F1
		dc.b $AF, $54, $C5
		wStopRead
		dc.b $C2
		wAddVol		$0A
		dc.b $AD, $53
		wStopRead
		wLoopGoEnd

.0D_01_00
		wSetVol		$03
		dc.b $C9
		wStopRead
		dc.b $C6
		wTempoDiv	$10
		wAddVol		$17
		dc.b $40
		wLoopGoEnd

.0D_01_09
.0D_01_06
		wSetVol		$03
		dc.b $CD
		wTempoDiv	$10
		wAddVol		$2B
		dc.b $AC, $51
		wAddVol		$F6
		dc.b $AB, $4F
		wAddVol		$F6
		dc.b $AA, $4E
		wAddVol		$F6
		dc.b $A8, $4C
		wAddVol		$0A
		dc.b $A6, $4A
		wAddVol		$0A
		dc.b $A5, $49
		wLoopGoEnd

.0D_01_04
		wSetVol		$03
		dc.b $C9
		wTempoDiv	$10
		wAddVol		$17
		dc.b $47, $C6, $45, $C9, $4A, $C6, $48, $C7
		dc.b $47, $4C, $47, $43, $C6, $45, $43, $CA
		dc.b $42
		wLoopGoEnd

.0D_01_05
		wSetVol		$03
		dc.b $C4
		wStopRead
		dc.b $C2
		wTempoDiv	$10
		wAddVol		$2B
		dc.b $A3, $48, $C5
		wStopRead
		dc.b $C2
		wAddVol		$F1
		dc.b $A5, $4A, $C5
		wStopRead
		dc.b $C2
		wAddVol		$F1
		dc.b $A7, $4C, $C5
		wStopRead
		dc.b $C2
		wAddVol		$0A
		dc.b $A8, $4E
		wStopRead
		wLoopGoEnd

.0D_01_07
		wSetVol		$03
		dc.b $CA
		wTempoDiv	$10
		wAddVol		$26
		dc.b $47, $46, $4A, $CF, $49, $C2
		wAddVol		$E7
		dc.b $A9, $4E
		wStopRead
		dc.b $C4
		wAddVol		$14
		dc.b $49, $C2
		wAddVol		$EC
		dc.b $A8, $4D
		wStopRead
		dc.b $CA
		wAddVol		$19
		dc.b $47, $CF, $46, $C2
		wAddVol		$E7
		dc.b $A6, $4A
		wAddVol		$14
		dc.b $46
		wAddVol		$EC
		dc.b $A6, $4A
		wAddVol		$14
		dc.b $46
		wAddVol		$EC
		dc.b $A5, $49
		wAddVol		$14
		dc.b $46, $C6
		wAddVol		$F6
		dc.b $9E, $43
		wAddVol		$05
		dc.b $9D, $42
		wAddVol		$05
		dc.b $9C, $41, $9B, $40
		wAddVol		$F6
		dc.b $AA, $4F
		wAddVol		$05
		dc.b $A9, $4E
		wAddVol		$05
		dc.b $A8, $4D, $A5, $4A
		wLoopGoEnd

.0D_01_03
		wSetVol		$03
		dc.b $C4
		wStopRead
		dc.b $C2
		wTempoDiv	$10
		wAddVol		$2B
		dc.b $B3, $58, $C5
		wStopRead
		dc.b $C2
		wAddVol		$F1
		dc.b $B1, $56, $C5
		wStopRead
		dc.b $C2
		wAddVol		$F1
		dc.b $AF, $54
		wStopRead
		dc.b $C4
		wAddVol		$0A
		dc.b $C6, $40
		wLoopGoEnd

.0D_01_08
		wSetVol		$03
		wSetTimerW	$0138
		wTempoDiv	$10
		wAddVol		$21
		dc.b $A7, $4C, $C4
		wTempoDiv	$0D
		wAddVol		$EC
		dc.b $A8, $4D
		wStopRead
		wSetTimerB	$D8
		wTempoDiv	$10
		wAddVol		$14
		dc.b $A7, $4C
		wLoopGoEnd

.0D_01
		wSetType	$00
		wSetMask	$0E
		wSetFreq	$F400
		wSetPat		$0A
		dc.b $CA
		wStopRead
		wModOn		$10
		wLoopGo		$00, .0D_01_00

.0D_01_0A
		wModOn		$10
		wLoopGo		$00, .0D_01_01
		wModOff
		wLoopGo		$00, .0D_01_02
		dc.b $CA
		wStopRead
		wLoopGo		$00, .0D_01_03
		wModOn		$10
		wLoopGo		$00, .0D_01_04
		wModOff
		wLoopGo		$00, .0D_01_05
		dc.b $CA
		wStopRead
		wLoopGo		$00, .0D_01_06
		wLoopGo		$01, .0D_01_07
		wLoopGo		$00, .0D_01_08
		wLoopGo		$00, .0D_01_09
		wJump		.0D_01_0A

.0D_02_1C
.0D_02_1A
.0D_02_04
.0D_02_0A
.0D_02_0C
.0D_02_02
.0D_02_00
		wSetVol		$02
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$26
		dc.b $45, $40, $43, $45, $40, $43, $45, $40
		wLoopGoEnd

.0D_02_01
.0D_02_03
.0D_02_1B
.0D_02_07
.0D_02_0B
		wSetVol		$02
		dc.b $C4
		wStopRead
		wTempoDiv	$0D
		wAddVol		$26
		dc.b $40, $43, $40, $45, $40, $45, $47
		wLoopGoEnd

.0D_02_05
.0D_02_1D
.0D_02_09
.0D_02_0D
		wSetVol		$02
		dc.b $C4
		wStopRead
		wTempoDiv	$0D
		wAddVol		$26
		dc.b $40, $45, $40, $C2
		wTempoDiv	$0C
		dc.b $47, $45, $43, $3E
		wAddVol		$F6
		dc.b $3C, $3E, $40, $41
		wLoopGoEnd

.0D_02_08
.0D_02_06
		wSetVol		$02
		dc.b $C4
		wStopRead
		wTempoDiv	$10
		wAddVol		$17
		dc.b $B3, $58, $B6, $5B, $B9, $5F, $B6, $5B
		dc.b $B8, $5D, $C2, $58, $56, $51, $4D
		wLoopGoEnd

.0D_02_0E
.0D_02_10
		wSetVol		$02
		dc.b $C4
		wStopRead
		wTempoDiv	$10
		wAddVol		$17
		dc.b $B1, $56, $B4, $5A, $B8, $5D, $B4, $5A
		dc.b $B6, $5B, $C2, $56, $54, $4F, $4E
		wLoopGoEnd

.0D_02_0F
		wSetVol		$02
		dc.b $C4
		wStopRead
		wTempoDiv	$0D
		wAddVol		$26
		dc.b $3E, $42, $3E, $43, $3E, $45, $47
		wLoopGoEnd

.0D_02_14
.0D_02_16
.0D_02_12
.0D_02_18
		wSetVol		$FA
		dc.b $C4
		wTempoDiv	$08
		wAddVol		$1E
		dc.b $4E, $47, $49, $4A, $4E, $47, $49, $4A
		dc.b $4E, $46, $49, $4A, $4E, $46, $49, $4A
		wLoopGoEnd

.0D_02_13
.0D_02_17
		wSetVol		$FA
		dc.b $C4
		wTempoDiv	$08
		wAddVol		$1E
		dc.b $4C, $45, $47, $49, $4C, $45, $47, $49
		dc.b $4C, $45, $46, $49, $4C, $45, $46, $49
		wLoopGoEnd

.0D_02_15
.0D_02_19
		wSetVol		$02
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$1E
		dc.b $4A, $49, $4A, $48, $4E, $4A, $43, $42
		wLoopGoEnd

.0D_02_11
		wSetVol		$02
		dc.b $CD
		wTempoDiv	$10
		wAddVol		$26
		dc.b $51, $50, $4A, $56, $50, $4A
		wLoopGoEnd

.0D_02
		wSetType	$00
		wSetMask	$0E
		wSetPat		$26
		wLoopGo		$00, .0D_02_00
		wLoopGo		$00, .0D_02_01

.0D_02_1E
		wLoopGo		$00, .0D_02_02
		wLoopGo		$00, .0D_02_03
		wLoopGo		$00, .0D_02_04
		wLoopGo		$00, .0D_02_05
		wLoopGo		$00, .0D_02_06
		wLoopGo		$00, .0D_02_07
		wLoopGo		$00, .0D_02_08
		wLoopGo		$00, .0D_02_09
		wLoopGo		$00, .0D_02_0A
		wLoopGo		$00, .0D_02_0B
		wLoopGo		$00, .0D_02_0C
		wLoopGo		$00, .0D_02_0D
		wLoopGo		$00, .0D_02_0E
		wLoopGo		$00, .0D_02_0F
		wLoopGo		$00, .0D_02_10
		wLoopGo		$00, .0D_02_11
		wSetPat		$1C
		wLoopGo		$00, .0D_02_12
		wLoopGo		$00, .0D_02_13
		wLoopGo		$00, .0D_02_14
		wLoopGo		$01, .0D_02_15
		wLoopGo		$00, .0D_02_16
		wLoopGo		$00, .0D_02_17
		wLoopGo		$00, .0D_02_18
		wLoopGo		$01, .0D_02_19
		wSetPat		$26
		wLoopGo		$00, .0D_02_1A
		wLoopGo		$00, .0D_02_1B
		wLoopGo		$00, .0D_02_1C
		wLoopGo		$00, .0D_02_1D
		wJump		.0D_02_1E

.0D_03_0D
.0D_03_07
.0D_03_05
.0D_03_00
.0D_03_01
.0D_03_03
		wSetVol		$04
		dc.b $C2
		wAddVol		$12
		dc.b $60, $0F, $C5
		wStopRead
		dc.b $C4, $05, $0D, $C6, $0C, $C2, $60, $05
		wStopRead
		dc.b $0F
		wStopRead
		wLoopGoEnd

.0D_03_0E
.0D_03_08
		wSetVol		$04
		dc.b $CC
		wAddVol		$12
		dc.b $05
		wStopRead
		dc.b $05, $05
		wAddVol		$F6
		dc.b $0D, $0C, $05
		wStopRead
		dc.b $05, $05, $11
		wStopRead
		wLoopGoEnd

.0D_03_04
		wSetVol		$04
		dc.b $C2
		wAddVol		$12
		dc.b $00, $C5
		wStopRead
		dc.b $C2, $05
		wStopRead
		wAddVol		$F6
		dc.b $0D
		wStopRead
		dc.b $0C, $0D, $0C
		wStopRead
		wAddVol		$0A
		dc.b $05, $05
		wAddVol		$F6
		dc.b $05
		wStopRead
		wLoopGoEnd

.0D_03_0C
.0D_03_06
.0D_03_02
.0D_03_0A
		wSetVol		$04
		dc.b $C2
		wAddVol		$12
		dc.b $60
		wAddVol		$14
		dc.b $0F
		wStopRead
		dc.b $65, $0F, $65, $0F
		wAddVol		$EC
		dc.b $00
		wStopRead
		wAddVol		$0A
		dc.b $65
		wAddVol		$F6
		dc.b $6D
		wAddVol		$14
		dc.b $10
		wAddVol		$F6
		dc.b $05
		wAddVol		$F6
		dc.b $6C
		wAddVol		$14
		dc.b $0F
		wStopRead
		wAddVol		$EC
		dc.b $05, $05, $60, $05, $05
		wAddVol		$F6
		dc.b $05
		wStopRead
		wLoopGoEnd

.0D_03_0B
.0D_03_09
		wSetVol		$04
		dc.b $C2
		wAddVol		$12
		dc.b $60
		wAddVol		$14
		dc.b $0F
		wStopRead
		dc.b $0F, $0F
		wAddVol		$EC
		dc.b $65
		wAddVol		$14
		dc.b $10
		wStopRead
		dc.b $6F
		wAddVol		$EC
		dc.b $0D
		wAddVol		$14
		dc.b $0F
		wAddVol		$EC
		dc.b $6C
		wAddVol		$14
		dc.b $0F
		wStopRead
		wAddVol		$EC
		dc.b $60
		wAddVol		$14
		dc.b $10
		wStopRead
		wAddVol		$EC
		dc.b $71
		wAddVol		$14
		dc.b $0F
		wStopRead
		dc.b $0F
		wStopRead
		wLoopGoEnd

.0D_03
		wDrumChannel
		wLoopGo		$01, .0D_03_00

.0D_03_0F
		wLoopGo		$04, .0D_03_01
		wLoopGo		$00, .0D_03_02
		wLoopGo		$03, .0D_03_03
		wLoopGo		$00, .0D_03_04
		wLoopGo		$01, .0D_03_05
		wLoopGo		$00, .0D_03_06
		wLoopGo		$00, .0D_03_07
		wLoopGo		$00, .0D_03_08
		wLoopGo		$05, .0D_03_09
		wLoopGo		$01, .0D_03_0A
		wLoopGo		$06, .0D_03_0B
		wLoopGo		$00, .0D_03_0C
		wLoopGo		$02, .0D_03_0D
		wLoopGo		$00, .0D_03_0E
		wJump		.0D_03_0F

.0D
		wHeaderMus	$88, $0211
		dw	.0D_00
		dw	.0D_01
		dw	.0D_02
		dw	.0D_03
		dw	$0000

.0E_00_01
		wSetVol		$F8
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $2D, $C6
		wStopRead
		dc.b $C4, $2D, $2D, $C6
		wStopRead
		dc.b $C4, $2D
		wStopRead
		dc.b $2D
		wStopRead
		dc.b $2D, $2D, $C7
		wStopRead
		dc.b $C4, $2B, $C6
		wStopRead
		dc.b $C4, $2B, $2B, $C6
		wStopRead
		dc.b $C4, $2B
		wStopRead
		dc.b $2B
		wStopRead
		dc.b $2B, $2B
		wStopRead
		dc.b $C2, $32, $30, $2F, $2E
		wLoopGoEnd

.0E_00_07
.0E_00_02
		wSetVol		$F8
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $28, $28, $2F, $2F, $28, $2F, $30, $C7
		dc.b $32, $C6, $32, $32, $32, $C4, $28, $28
		dc.b $2F, $2F, $28, $2F, $30, $C7, $2D, $C6
		dc.b $2D, $2D, $2D, $C4, $28, $28, $2F, $2F
		dc.b $28, $2F, $30, $C7, $32, $C6, $32, $32
		dc.b $32, $C4, $28, $28, $2F, $2F, $28, $2F
		dc.b $30, $C7, $2D, $C6, $2D, $2D, $C2, $32
		dc.b $30, $2F, $2E
		wLoopGoEnd

.0E_00_00
		wSetVol		$F8
		dc.b $C2
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $39, $37, $35, $34, $32, $30, $2F, $2E
		wLoopGoEnd

.0E_00_05
.0E_00_03
		wSetVol		$F8
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $2D, $2B, $39, $34, $2D, $2B, $39, $34
		wLoopGoEnd

.0E_00_04
.0E_00_06
		wSetVol		$F8
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $2D, $2B, $39, $C2
		wTempoDiv	$10
		dc.b $3E, $40
		wStopRead
		dc.b $3C, $3B, $C4
		wTempoDiv	$0D
		dc.b $30, $C2, $32
		wAddVol		$0A
		dc.b $40
		wAddVol		$EC
		dc.b $2B
		wLoopGoEnd

.0E_00
		wSetType	$00
		wSetMask	$01
		wSetPat		$09
		wLoopGo		$00, .0E_00_00

.0E_00_08
		wLoopGo		$01, .0E_00_01
		wLoopGo		$00, .0E_00_02
		wLoopGo		$02, .0E_00_03
		wLoopGo		$00, .0E_00_04
		wLoopGo		$02, .0E_00_05
		wLoopGo		$00, .0E_00_06
		wLoopGo		$00, .0E_00_07
		wJump		.0E_00_08

.0E_01_03
.0E_01_05
		wSetVol		$00
		dc.b $C2
		wTempoDiv	$0D
		wAddVol		$21
		dc.b $39, $3B, $3C, $39, $3B, $40, $3B, $39
		dc.b $43, $3B, $40, $3B, $3E, $3B, $3C, $3B
		wLoopGoEnd

.0E_01_04
.0E_01_06
		wSetVol		$00
		dc.b $C2
		wTempoDiv	$0D
		wAddVol		$21
		dc.b $3C, $40, $45, $40, $43, $48, $4E, $43
		dc.b $4C, $48, $43, $40, $3E, $3C, $4C, $47
		wLoopGoEnd

.0E_01_00
		dc.b $C8
		wStopRead
		wLoopGoEnd

.0E_01_02
.0E_01_07
.0E_01_01
		dc.b $CA
		wStopRead
		wLoopGoEnd

.0E_01
		wSetType	$00
		wSetMask	$12
		wSetPat		$26
		wLoopGo		$00, .0E_01_00

.0E_01_08
		wLoopGo		$07, .0E_01_01
		wLoopGo		$07, .0E_01_02
		wLoopGo		$02, .0E_01_03
		wLoopGo		$00, .0E_01_04
		wLoopGo		$02, .0E_01_05
		wLoopGo		$00, .0E_01_06
		wLoopGo		$07, .0E_01_07
		wJump		.0E_01_08

.0E_02_01
		wSetVol		$08
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$2B
		dc.b $99, $40, $A5, $4A, $A6, $4B, $A7, $4C
		wAddVol		$F6
		dc.b $99, $40, $A5, $4A, $A6, $4B, $A7, $4C
		wAddVol		$F6
		dc.b $99, $40, $A5, $4A, $A6, $4B, $A7, $4C
		dc.b $99, $40
		wAddVol		$F6
		dc.b $A5, $4A, $A6, $4B, $A7, $4C
		wLoopBackInit	$02
		wAddVol		$05
		dc.b $A5, $4A, $A3, $48
		wLoopBack
		wAddVol		$05
		dc.b $99, $3E, $99, $3E
		wAddVol		$F6
		dc.b $A5, $4A, $A3, $48, $A5, $4A, $A3, $48
		wAddVol		$05
		dc.b $A5, $4A, $A3, $48, $C2
		wAddVol		$FB
		dc.b $A0, $47, $9E, $45
		wAddVol		$FB
		dc.b $9C, $43
		wAddVol		$FB
		dc.b $9B, $41
		wLoopGoEnd

.0E_02_02
.0E_02_05
		wSetVol		$08
		dc.b $CF
		wTempoDiv	$0F
		wAddVol		$17
		dc.b $9B, $40, $C4
		wTempoDiv	$0D
		dc.b $9B, $40, $9C, $41
		wSetTimerB	$A8
		dc.b $9E, $43, $C2, $B4, $59, $B4, $59, $C4
		dc.b $B4, $59, $CF
		wTempoDiv	$0F
		dc.b $9B, $40, $C4
		wTempoDiv	$0D
		dc.b $9B, $40, $9A, $3F
		wSetTimerB	$A8
		dc.b $99, $3E, $C4, $A3, $48, $A5, $4A, $CF
		wTempoDiv	$0F
		dc.b $A7, $4C, $C4
		wTempoDiv	$0D
		dc.b $A7, $4C, $A8, $4D
		wSetTimerB	$A8
		dc.b $AA, $4F, $C2, $B4, $59, $B4, $59, $C4
		dc.b $B4, $59, $CF
		wTempoDiv	$0F
		dc.b $A7, $4C, $C4
		wTempoDiv	$0D
		dc.b $A7, $4C, $A6, $4B, $C7, $A5, $4A, $C6
		dc.b $A3, $48, $A1, $47, $C2, $9E, $43, $9C
		dc.b $41, $9B, $40, $9A, $3F
		wLoopGoEnd

.0E_02_00
		wSetVol		$08
		dc.b $C2
		wTempoDiv	$0D
		wAddVol		$21
		dc.b $A7, $4D, $A5, $4C
		wAddVol		$FB
		dc.b $A3, $4A, $A1, $48
		wAddVol		$FB
		dc.b $A0, $47
		wAddVol		$FB
		dc.b $9E, $45
		wAddVol		$FB
		dc.b $9C, $43
		wAddVol		$FB
		dc.b $9B, $41
		wLoopGoEnd

.0E_02_03
		wSetVol		$08
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$30
		dc.b $AC, $51, $9E, $43
		wAddVol		$FB
		dc.b $A0, $45, $AB, $50, $AA, $4F
		wAddVol		$FB
		dc.b $9E, $43, $A8, $4D
		wAddVol		$FB
		dc.b $A7, $4C
		wAddVol		$FB
		dc.b $9C, $41
		wAddVol		$FB
		dc.b $A3, $48, $A4, $4A
		wAddVol		$FB
		dc.b $A7, $4C, $A5, $4A
		wAddVol		$FB
		dc.b $A4, $49
		wAddVol		$FB
		dc.b $A3, $48
		wAddVol		$FB
		dc.b $A0, $45
		wLoopGoEnd

.0E_02_04
		wSetVol		$08
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$30
		dc.b $AC, $51, $9E, $43
		wAddVol		$FB
		dc.b $A0, $45, $AB, $50, $AA, $4F
		wAddVol		$FB
		dc.b $9E, $43, $A8, $4D
		wAddVol		$FB
		dc.b $A7, $4C
		wAddVol		$FB
		dc.b $9C, $41, $48, $A4, $4A
		wAddVol		$FB
		dc.b $A5, $4A, $C2, $A7, $4D, $A5, $4C, $A3
		dc.b $4A, $A1, $48, $A0, $47, $9E, $45, $9C
		dc.b $43, $9B, $41
		wLoopGoEnd

.0E_02
		wSetType	$00
		wSetMask	$0C
		wSetPat		$0A
		wLoopGo		$00, .0E_02_00

.0E_02_06
		wLoopGo		$01, .0E_02_01
		wLoopGo		$00, .0E_02_02
		dc.b $CA
		wStopRead
		wStopRead
		wLoopGo		$00, .0E_02_03
		dc.b $CA
		wStopRead
		wStopRead
		wLoopGo		$00, .0E_02_04
		wLoopGo		$00, .0E_02_05
		wJump		.0E_02_06

.0E_03_03
.0E_03_05
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$30
		dc.b $AA, $51, $B8, $5D, $B6, $5C
		wAddVol		$FB
		dc.b $AA, $51
		wStopRead
		wAddVol		$FB
		dc.b $AA, $4F, $A9, $4E
		wAddVol		$FB
		dc.b $A8, $4D, $AF, $56
		wAddVol		$FB
		dc.b $A3, $4A, $A5, $4C
		wAddVol		$FB
		dc.b $A7, $4D, $A8, $4F
		wAddVol		$FB
		dc.b $B1, $58
		wAddVol		$FB
		dc.b $AA, $51
		wAddVol		$FB
		dc.b $B4, $5B
		wLoopGoEnd

.0E_03_00
		wSetVol		$00
		dc.b $C8
		wStopRead
		wLoopGoEnd

.0E_03_01
.0E_03_02
.0E_03_07
.0E_03_04
.0E_03_06
		wSetVol		$00
		dc.b $CA
		wStopRead
		wLoopGoEnd

.0E_03
		wSetType	$00
		wSetMask	$0E
		wSetPat		$1C
		wLoopGo		$00, .0E_03_00

.0E_03_08
		wLoopGo		$07, .0E_03_01
		wLoopGo		$07, .0E_03_02
		wLoopGo		$00, .0E_03_03
		wLoopGo		$01, .0E_03_04
		wLoopGo		$00, .0E_03_05
		wLoopGo		$07, .0E_03_06
		wLoopGo		$01, .0E_03_07
		wJump		.0E_03_08

.0E_04_03
.0E_04_01
		wSetVol		$05
		dc.b $C2
		wAddVol		$1C
		dc.b $0D
		wStopRead
		dc.b $0C
		wStopRead
		wAddVol		$F6
		dc.b $05
		wStopRead
		wAddVol		$0A
		dc.b $0D
		wStopRead
		dc.b $0D
		wStopRead
		dc.b $0C, $0C
		wAddVol		$F6
		dc.b $05
		wStopRead
		wAddVol		$0A
		dc.b $0D
		wStopRead
		dc.b $C4
		wStopRead
		dc.b $C2, $0D
		wStopRead
		wAddVol		$F6
		dc.b $05
		wStopRead
		wAddVol		$0A
		dc.b $0D, $0C, $C4, $0D, $C2, $0C
		wStopRead
		wAddVol		$F6
		dc.b $11
		wAddVol		$0A
		dc.b $0C, $C4
		wAddVol		$0A
		dc.b $00
		wLoopGoEnd

.0E_04_02
.0E_04_04
		wSetVol		$05
		dc.b $C2
		wAddVol		$1C
		dc.b $0D
		wStopRead
		dc.b $0C
		wStopRead
		dc.b $C4
		wAddVol		$F6
		dc.b $05, $C2
		wAddVol		$0A
		dc.b $0D
		wStopRead
		dc.b $0D
		wStopRead
		dc.b $0C, $0C, $C4
		wAddVol		$F6
		dc.b $05, $C2
		wAddVol		$0A
		dc.b $0D
		wStopRead
		dc.b $C4
		wStopRead
		dc.b $0D
		wAddVol		$F6
		dc.b $05
		wAddVol		$0A
		dc.b $0D, $0D
		wStopRead
		dc.b $C2
		wAddVol		$F6
		dc.b $11, $11, $11, $11
		wLoopGoEnd

.0E_04_05
.0E_04_0B
		wSetVol		$05
		dc.b $C2
		wAddVol		$1C
		dc.b $00
		wStopRead
		dc.b $00
		wStopRead
		wAddVol		$F6
		dc.b $05
		wStopRead
		wAddVol		$0A
		dc.b $0D
		wStopRead
		dc.b $0C
		wStopRead
		wAddVol		$F6
		dc.b $05, $05, $05
		wStopRead
		dc.b $05
		wStopRead
		wAddVol		$0A
		dc.b $0C
		wStopRead
		dc.b $0C
		wStopRead
		wAddVol		$F6
		dc.b $05
		wStopRead
		wAddVol		$0A
		dc.b $0C
		wStopRead
		wAddVol		$F6
		dc.b $05, $05
		wAddVol		$0A
		dc.b $0C, $0C
		wAddVol		$F6
		dc.b $05
		wStopRead
		dc.b $05, $05
		wLoopGoEnd

.0E_04_06
.0E_04_0C
		wSetVol		$05
		dc.b $C2
		wAddVol		$1C
		dc.b $00
		wStopRead
		dc.b $00
		wStopRead
		wAddVol		$F6
		dc.b $05
		wStopRead
		wAddVol		$0A
		dc.b $0D
		wStopRead
		dc.b $0C
		wStopRead
		wAddVol		$F6
		dc.b $05, $05, $05
		wStopRead
		dc.b $05
		wStopRead
		wAddVol		$0A
		dc.b $65, $0C
		wStopRead
		dc.b $65, $0C, $65, $0C, $05
		wAddVol		$F6
		dc.b $05, $05, $05, $05
		wStopRead
		dc.b $65
		wAddVol		$0A
		dc.b $0C
		wAddVol		$F6
		dc.b $65
		wAddVol		$0A
		dc.b $0C
		wAddVol		$EC
		dc.b $65
		wAddVol		$0A
		dc.b $0E
		wAddVol		$F6
		dc.b $05, $65
		wAddVol		$0A
		dc.b $0D
		wAddVol		$F6
		dc.b $05
		wLoopGoEnd

.0E_04_09
.0E_04_07
		wSetVol		$05
		dc.b $C2
		wAddVol		$12
		dc.b $00
		wStopRead
		dc.b $05
		wStopRead
		dc.b $00
		wStopRead
		dc.b $05
		wStopRead
		dc.b $00, $00, $05
		wStopRead
		dc.b $00
		wStopRead
		dc.b $05
		wStopRead
		wLoopGoEnd

.0E_04_08
.0E_04_0A
		wSetVol		$05
		dc.b $C2
		wAddVol		$12
		dc.b $00
		wStopRead
		dc.b $05
		wStopRead
		dc.b $05, $C4
		wStopRead
		dc.b $C2, $05, $60, $05, $60, $05, $C4
		wStopRead
		dc.b $C2, $60, $05
		wStopRead
		dc.b $05
		wStopRead
		wLoopGoEnd

.0E_04_00
		wSetVol		$05
		dc.b $C8
		wStopRead
		wLoopGoEnd

.0E_04
		wDrumChannel
		wLoopGo		$00, .0E_04_00

.0E_04_0D
		wLoopGo		$00, .0E_04_01
		wLoopGo		$00, .0E_04_02
		wLoopGo		$00, .0E_04_03
		wLoopGo		$00, .0E_04_04
		wLoopGo		$02, .0E_04_05
		wLoopGo		$00, .0E_04_06
		wLoopGo		$02, .0E_04_07
		wLoopGo		$00, .0E_04_08
		wLoopGo		$02, .0E_04_09
		wLoopGo		$00, .0E_04_0A
		wLoopGo		$02, .0E_04_0B
		wLoopGo		$00, .0E_04_0C
		wJump		.0E_04_0D

.0E
		wHeaderMus	$88, $0246
		dw	.0E_00
		dw	.0E_01
		dw	.0E_02
		dw	.0E_03
		dw	.0E_04
		dw	$0000

.10_00_00
		wSetVol		$FE
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$0D
		dc.b $2B, $2D, $2E, $2B, $2D, $2E, $2B, $2D
		wLoopGoEnd

.10_00_01
		wSetVol		$FE
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$0D
		dc.b $30, $31, $30, $31, $30, $C2, $31, $C4
		dc.b $30, $C2, $30, $C4, $31
		wLoopGoEnd

.10_00_02
		wSetVol		$FE
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$03
		dc.b $30, $30, $C9
		wStopRead
		wLoopGoEnd

.10_00
		wSetMask	$01
		wSetPat		$06
		dc.b $CA
		wStopRead

.10_00_03
		wLoopGo		$07, .10_00_00
		wLoopGo		$06, .10_00_01
		wLoopGo		$00, .10_00_02
		wJump		.10_00_03

.10_01_00
		wSetVol		$04
		dc.b $C4
		wTempoDiv	$0A
		wAddVol		$21
		dc.b $4F, $51, $52, $4F, $55, $56, $4F, $59
		dc.b $5B, $55, $59, $C2, $58, $55, $C4, $58
		dc.b $52, $56, $51
		wLoopGoEnd

.10_01_01
.10_01_03
		wSetVol		$00
		dc.b $C2
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $AF, $52
		wStopRead
		dc.b $AF, $52
		wSetTimerB	$54
		wStopRead
		dc.b $C2, $AF, $52
		wStopRead
		dc.b $AF, $52, $C5, $B2, $56, $C2, $AE, $51
		wStopRead
		dc.b $AE, $51
		wSetTimerB	$54
		wStopRead
		dc.b $C2, $AE, $51
		wStopRead
		dc.b $AE, $51, $C5, $B1, $56, $C2, $AD, $50
		wStopRead
		dc.b $AD, $50
		wSetTimerB	$54
		wStopRead
		dc.b $C2, $AD, $50
		wStopRead
		dc.b $AD, $50, $C5, $B0, $54
		wLoopGoEnd

.10_01_02
		wSetVol		$00
		dc.b $C2
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $AC, $4F
		wStopRead
		dc.b $AC, $4F
		wSetTimerB	$9C
		wStopRead
		wLoopGoEnd

.10_01_04
		wSetVol		$00
		dc.b $C2
		wTempoDiv	$0C
		wAddVol		$08
		dc.b $AC, $4F
		wStopRead
		dc.b $AC, $4F
		wSetTimerB	$9C
		wStopRead
		wLoopGoEnd

.10_01
		wSetMask	$0E
		wAddFreq	$F400
		dc.b $CA
		wStopRead

.10_01_05
		wSetPat		$1D
		wLoopGo		$03, .10_01_00
		wSetPat		$1F
		wLoopGo		$00, .10_01_01
		wLoopGo		$00, .10_01_02
		wLoopGo		$00, .10_01_03
		wLoopGo		$00, .10_01_04
		wJump		.10_01_05

.10_02_00
		wSetVol		$08
		dc.b $C2
		wTempoDiv	$10
		wAddVol		$17
		dc.b $57, $56, $55, $54, $B2, $57, $B1, $56
		dc.b $AF, $55, $AE, $54, $AD, $52, $AC, $51
		dc.b $AB, $4F, $AA, $4E, $A8, $4D, $A6, $4C
		dc.b $A5, $4B, $A3, $4A
		wLoopGoEnd

.10_02_01
.10_02_03
		wSetVol		$08
		wSetTimerB	$9C
		wTempoDiv	$10
		wAddVol		$17
		dc.b $AA, $4D, $C2
		wStopRead
		dc.b $C4, $AA, $4D
		wSetTimerB	$9C
		dc.b $A9, $4C, $C2
		wStopRead
		dc.b $C4, $A9, $4C
		wSetTimerB	$9C
		dc.b $A8, $4B, $C2
		wStopRead
		dc.b $C4, $A8, $4B
		wLoopGoEnd

.10_02_02
		wSetVol		$08
		dc.b $C5
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $A7, $4A, $C2, $A7, $4A, $A7, $4A
		wStopRead
		dc.b $AF, $52
		wStopRead
		dc.b $A7, $4A
		wStopRead
		dc.b $AD, $51
		wStopRead
		dc.b $A7, $4A
		wStopRead
		dc.b $A8, $4C
		wStopRead
		wLoopGoEnd

.10_02_04
		wSetVol		$08
		dc.b $C5
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $A7, $4A, $C2, $A7, $4A, $A7, $4A
		wStopRead
		dc.b $5B, $59, $58, $57, $56, $55, $53, $4F
		dc.b $4D, $4A
		wLoopGoEnd

.10_02_07
.10_02_0B
.10_02_05
.10_02_09
		wSetVol		$08
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$21
		dc.b $3C, $43, $48, $49, $42, $43, $48, $49
		wLoopGoEnd

.10_02_06
.10_02_0A
		wSetVol		$08
		wAddFreq	$0C00
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$21
		dc.b $35
		wTempoDiv	$08
		dc.b $41, $48, $4D, $3C, $48, $4D, $54
		wAddFreq	$F400
		wLoopGoEnd

.10_02_08
		wSetVol		$08
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$21
		dc.b $41
		wTempoDiv	$08
		dc.b $4D, $54, $59, $41, $4D, $48, $41
		wLoopGoEnd

.10_02_0C
		wSetVol		$08
		dc.b $C4
		wTempoDiv	$08
		wAddVol		$21
		dc.b $43, $43, $C9
		wStopRead
		wLoopGoEnd

.10_02
		wSetMask	$0E
		wSetPat		$0A
		wAddFreq	$F400
		wLoopGo		$00, .10_02_00

.10_02_0D
		wSetPat		$0A
		wLoopGo		$00, .10_02_01
		wLoopGo		$00, .10_02_02
		wLoopGo		$00, .10_02_03
		wLoopGo		$00, .10_02_04
		wSetPat		$21
		wLoopGo		$00, .10_02_05
		wLoopGo		$00, .10_02_06
		wLoopGo		$00, .10_02_07
		wLoopGo		$00, .10_02_08
		wLoopGo		$00, .10_02_09
		wLoopGo		$00, .10_02_0A
		wLoopGo		$00, .10_02_0B
		wLoopGo		$00, .10_02_0C
		wJump		.10_02_0D

.10_03_02
.10_03_00
		wSetVol		$00
		dc.b $C4
		wAddVol		$12
		dc.b $00, $C2, $05
		wStopRead
		dc.b $00
		wStopRead
		dc.b $05
		wStopRead
		dc.b $00
		wStopRead
		dc.b $05, $C5
		wStopRead
		dc.b $C2, $05
		wStopRead
		wLoopGoEnd

.10_03_01
		wSetVol		$00
		dc.b $C4
		wAddVol		$12
		dc.b $00
		wStopRead
		dc.b $05, $C2
		wAddVol		$0A
		dc.b $0E, $0E, $0D, $0D, $0D, $0D, $0C, $0C
		dc.b $0C, $0C
		wLoopGoEnd

.10_03_03
		wSetVol		$00
		dc.b $C2
		wAddVol		$08
		dc.b $05
		wStopRead
		dc.b $05
		wStopRead
		dc.b $0D, $0C
		wAddVol		$0A
		dc.b $05
		wStopRead
		dc.b $05
		wStopRead
		dc.b $05, $05
		wAddVol		$14
		dc.b $05
		wAddVol		$F6
		dc.b $05
		wAddVol		$F6
		dc.b $05
		wAddVol		$F6
		dc.b $05
		wLoopGoEnd

.10_03
		wDrumChannel
		dc.b $CA
		wStopRead

.10_03_04
		wLoopGo		$06, .10_03_00
		wLoopGo		$00, .10_03_01
		wLoopGo		$06, .10_03_02
		wLoopGo		$00, .10_03_03
		wJump		.10_03_04

.10
		wHeaderMus	$88, $021C
		dw	.10_00
		dw	.10_01
		dw	.10_02
		dw	.10_03
		dw	$0000

.0F_00_01
		wSetVol		$F8
		dc.b $C7
		wTempoDiv	$04
		wAddVol		$17
		dc.b $2B, $C4
		wTempoDiv	$0D
		dc.b $2B, $C7
		wStopRead
		dc.b $C4, $2B, $2A, $C6
		wStopRead
		dc.b $C4, $2A, $C7
		wStopRead
		dc.b $C4, $2A, $29, $C6
		wStopRead
		dc.b $C4, $29, $C7
		wStopRead
		dc.b $C4, $29, $28, $C6
		wStopRead
		dc.b $C4, $28
		wStopRead
		dc.b $C2, $26, $28, $C4, $2B, $2D, $30, $C6
		wStopRead
		dc.b $C2, $30, $28
		wStopRead
		dc.b $28, $2B
		wStopRead
		dc.b $C4, $30, $28, $2B, $C6
		wStopRead
		dc.b $C4, $2B, $C7
		wStopRead
		dc.b $C4, $2B, $2D, $C6
		wStopRead
		dc.b $C4, $2D
		wStopRead
		dc.b $34
		wStopRead
		dc.b $2D, $32
		wStopRead
		dc.b $30
		wStopRead
		dc.b $2F
		wStopRead
		dc.b $2D
		wStopRead
		dc.b $C7
		wTempoDiv	$04
		dc.b $2B, $C4
		wTempoDiv	$0D
		dc.b $2B, $C7
		wStopRead
		dc.b $C4, $2B, $2A, $C6
		wStopRead
		dc.b $C4, $2A, $C7
		wStopRead
		dc.b $C4, $2A, $29, $C6
		wStopRead
		dc.b $C4, $29, $C7
		wStopRead
		dc.b $C4, $29, $28, $C6
		wStopRead
		dc.b $C4, $28
		wStopRead
		dc.b $C2, $26, $28, $C4, $2B, $2D, $30, $C6
		wStopRead
		dc.b $C2, $30, $28
		wStopRead
		dc.b $28, $2B
		wStopRead
		dc.b $C4, $30, $28, $2B, $C6
		wStopRead
		dc.b $C4, $2B, $C7
		wStopRead
		dc.b $C4, $2B, $2D, $C6
		wStopRead
		dc.b $C4, $2D, $C7
		wStopRead
		dc.b $C4, $2D, $2B, $C6
		wStopRead
		dc.b $C4, $2B, $C7
		wStopRead
		dc.b $C4, $2B
		wLoopGoEnd

.0F_00_00
		dc.b $C6
		wStopRead
		wLoopGoEnd

.0F_00
		wSetType	$00
		wSetMask	$01
		wSetPat		$07
		wSetFreq	$0C00
		wLoopGo		$00, .0F_00_00

.0F_00_02
		wLoopGo		$00, .0F_00_01
		wJump		.0F_00_02

.0F_01_00
		wSetVol		$08
		dc.b $C2
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $3E, $40, $41, $42
		wLoopGoEnd

.0F_01_01
		wSetVol		$08
		dc.b $C7
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $43, $C4, $47, $48, $47, $45, $43, $C7
		dc.b $45, $C4, $3E, $C6, $3E, $C2, $3E, $40
		dc.b $41, $42, $C7, $43, $C4, $47, $48, $47
		dc.b $45, $43, $C9, $4A, $C4, $48, $4A, $4C
		dc.b $4C, $4C, $4C, $4C, $4A, $48, $C7, $4A
		dc.b $C4, $4C, $C7, $47, $C4, $45, $47, $49
		dc.b $49, $49, $49, $49, $4A, $4C, $45, $C9
		dc.b $4A, $C2, $3E, $40, $41, $42, $C7, $43
		dc.b $C4, $47, $48, $47, $45, $43, $C7, $45
		dc.b $C4, $3E, $C6, $3E, $C2, $3E, $40, $41
		dc.b $42, $C7, $43, $C4, $47, $48, $47, $45
		dc.b $43, $C9, $4A, $C4, $48, $4A, $4C, $4C
		dc.b $4C, $4C, $4C, $4A, $48, $C7, $4A, $C4
		dc.b $4C, $C7, $47, $C4, $45, $47, $48, $48
		dc.b $48, $48, $48, $47, $45
		wSetTimerB	$A8
		wTempoDiv	$10
		wAddVol		$05
		dc.b $43, $C2
		wTempoDiv	$0D
		wAddVol		$FB
		dc.b $3E, $40, $41, $42
		wLoopGoEnd

.0F_01
		wSetType	$00
		wSetMask	$0A
		wSetPat		$29
		wLoopGo		$00, .0F_01_00

.0F_01_02
		wLoopGo		$00, .0F_01_01
		wJump		.0F_01_02

.0F_02_01
.0F_02_03
		wSetVol		$FA
		dc.b $CA
		wTempoDiv	$10
		wAddVol		$21
		dc.b $53, $C8, $58, $56, $CA, $4F, $C7, $56
		dc.b $C4, $54, $C8, $54, $CA, $58, $C8, $56
		dc.b $53
		wLoopGoEnd

.0F_02_02
		wSetVol		$FA
		dc.b $CA
		wAddVol		$21
		dc.b $51, $C8, $56, $54
		wLoopGoEnd

.0F_02_04
		wSetVol		$FA
		dc.b $CA
		wAddVol		$21
		dc.b $51, $4F
		wLoopGoEnd

.0F_02_00
		dc.b $C6
		wStopRead
		wLoopGoEnd

.0F_02
		wSetType	$00
		wSetMask	$04
		wSetPat		$20
		wLoopGo		$00, .0F_02_00

.0F_02_05
		wLoopGo		$00, .0F_02_01
		wLoopGo		$00, .0F_02_02
		wLoopGo		$00, .0F_02_03
		wLoopGo		$00, .0F_02_04
		wJump		.0F_02_05

.0F_03_01
.0F_03_02
		wSetVol		$04
		dc.b $C4
		wAddVol		$12
		dc.b $60, $0F, $10, $0F, $60, $0F, $0F, $0F
		dc.b $05, $60, $0F
		wLoopGoEnd

.0F_03_00
		wSetVol		$04
		dc.b $C6
		wStopRead
		wLoopGoEnd

.0F_03
		wDrumChannel
		wLoopGo		$00, .0F_03_00

.0F_03_03
		wLoopGo		$07, .0F_03_01
		wLoopGo		$07, .0F_03_02
		wJump		.0F_03_03

.0F
		wHeaderMus	$88, $01AA
		dw	.0F_00
		dw	.0F_01
		dw	.0F_02
		dw	.0F_03
		dw	$0000

.11_00_00
		wSetVol		$00
		dc.b $C2
		wTempoDiv	$0C
		wAddVol		$0D
		dc.b $33, $33, $3F
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $32, $C2, $3E
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $30, $C2, $3C
		wStopRead
		dc.b $C4, $2E, $C2, $3A
		wStopRead
		dc.b $33, $33, $3F
		wStopRead
		dc.b $C4, $32, $C2, $3E
		wStopRead
		dc.b $C4, $30, $C2, $3C
		wStopRead
		dc.b $C4, $2E, $C2, $3A
		wStopRead
		dc.b $C4, $32, $C2, $3E
		wStopRead
		dc.b $C4, $30, $C2, $3C
		wStopRead
		dc.b $C4, $2E, $C2, $3A
		wStopRead
		dc.b $C4, $2D, $C2, $39
		wStopRead
		dc.b $C4, $2B, $C2, $37, $37, $C4, $2D, $C2
		dc.b $39, $39, $C4, $2E, $C2, $3A, $3A, $C4
		dc.b $30, $C2, $3C, $3C, $33, $33, $3F
		wStopRead
		dc.b $C4, $32, $C2, $3E
		wStopRead
		dc.b $C4, $30, $C2, $3C
		wStopRead
		dc.b $C4, $2E, $C2, $3A
		wStopRead
		dc.b $33, $33, $3F
		wStopRead
		dc.b $C4, $32, $C2, $3E
		wStopRead
		dc.b $C4, $30, $C2, $3C
		wStopRead
		dc.b $C4, $2E, $C2, $3A
		wStopRead
		dc.b $C4, $32, $C2, $3E
		wStopRead
		dc.b $C4, $30, $C2, $3C
		wStopRead
		dc.b $C4, $2E, $C2, $3A
		wStopRead
		dc.b $C4, $2D, $C2, $39
		wStopRead
		wLoopGoEnd

.11_00_01
		wSetVol		$00
		dc.b $C0
		wTempoDiv	$0B
		wAddVol		$0D
		dc.b $2B, $29, $28, $26, $C4
		wStopRead
		dc.b $C0, $2E, $2D, $2B, $29, $C6
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $26, $28, $29
		wLoopGoEnd

.11_00_04
.11_00_02
.11_00_0A
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$0D
		dc.b $2B, $C2
		wStopRead
		dc.b $C4, $29, $C2
		wStopRead
		dc.b $C4, $2B
		wStopRead
		dc.b $2E, $30, $32
		wLoopGoEnd

.11_00_03
.11_00_0B
.11_00_05
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$0D
		dc.b $2B, $C2
		wStopRead
		dc.b $C4, $29, $C2
		wStopRead
		dc.b $C4, $27
		wStopRead
		dc.b $2E, $30, $32
		wLoopGoEnd

.11_00_08
.11_00_06
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$0D
		dc.b $33, $33, $33, $33, $33, $33, $33, $33
		dc.b $32, $32, $32, $32, $32, $32, $32, $32
		wLoopGoEnd

.11_00_07
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$0D
		dc.b $2E, $2E, $2E, $2E, $2E, $2E, $2E, $2E
		dc.b $30, $30, $30, $30, $30, $3C, $30, $3C
		wLoopGoEnd

.11_00_09
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$0D
		dc.b $2B, $2B, $2B, $2B, $2D, $2D, $2D, $2D
		dc.b $2E, $2E, $2E, $2E, $30, $30, $32, $32
		wLoopGoEnd

.11_00_0C
		wSetVol		$00
		wSetTimerW	$0180
		wTempoDiv	$10
		wAddVol		$0A
		dc.b $33, $CA, $32, $C4
		wTempoDiv	$0D
		dc.b $2B, $37, $2D, $39, $2E, $3A, $2F, $3B
		wLoopGoEnd

.11_00_0D
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$0D
		dc.b $30, $C2
		wStopRead
		dc.b $C4, $2E, $C2
		wStopRead
		dc.b $C4, $30
		wStopRead
		dc.b $2B, $2E, $37
		wAddVol		$0A
		dc.b $32, $C2
		wStopRead
		dc.b $C4, $30, $C2
		wStopRead
		dc.b $C4, $32
		wStopRead
		dc.b $2E, $2D, $2B, $33, $C2
		wStopRead
		dc.b $C4, $32, $C2
		wStopRead
		dc.b $C4, $30
		wStopRead
		dc.b $2D, $2E, $30, $C5, $32, $30, $C4, $2E
		dc.b $C5, $2D, $2B, $C4, $29
		wLoopGoEnd

.11_00
		wSetMask	$01
		wSetPat		$09
		wLoopGo		$00, .11_00_00
		wLoopGo		$00, .11_00_01

.11_00_0E
		wLoopGo		$02, .11_00_02
		wLoopGo		$00, .11_00_03
		wLoopGo		$02, .11_00_04
		wLoopGo		$00, .11_00_05
		wLoopGo		$00, .11_00_06
		wLoopGo		$00, .11_00_07
		wLoopGo		$00, .11_00_08
		wLoopGo		$00, .11_00_09
		wLoopGo		$02, .11_00_0A
		wLoopGo		$00, .11_00_0B
		wLoopGo		$00, .11_00_0C
		wLoopGo		$00, .11_00_0D
		wJump		.11_00_0E

.11_01_00
		wSetVol		$10
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$0A
		dc.b $A6, $4A, $C2
		wTempoDiv	$0C
		dc.b $A3, $48, $A3, $46, $A3
		wTempoDiv	$10
		dc.b $48
		wStopRead
		wTempoDiv	$0C
		dc.b $9F, $43, $C5
		wStopRead
		dc.b $C2, $9F, $43, $9E, $41, $9F, $43, $A1
		dc.b $45, $A3, $46, $A5, $48, $9E, $41, $9F
		dc.b $43
		wStopRead
		dc.b $9E, $41, $9F, $43
		wStopRead
		dc.b $9F, $43, $A1, $45
		wStopRead
		dc.b $9F, $48, $A1, $4A
		wStopRead
		dc.b $A1
		wTempoDiv	$10
		dc.b $4A
		wStopRead
		wTempoDiv	$0C
		dc.b $A5, $4D
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $A5, $4D, $C2
		wTempoDiv	$0C
		dc.b $A5, $4D
		wStopRead
		dc.b $A1, $4A, $9F, $48
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $A1, $4A, $C2
		wTempoDiv	$0C
		dc.b $A1, $4A, $9F, $48
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $9E, $41, $9F, $43, $AA, $4F
		wStopRead
		dc.b $A8, $4D
		wStopRead
		dc.b $A8, $4B
		wStopRead
		dc.b $C6, $A6, $4A, $C4, $A6, $4A, $C2
		wTempoDiv	$0C
		dc.b $A3, $48, $A3, $46, $A3
		wTempoDiv	$10
		dc.b $48
		wStopRead
		wTempoDiv	$0C
		dc.b $9F, $43, $C5
		wStopRead
		dc.b $C2, $9F, $43, $9E, $41, $9F, $43, $A1
		dc.b $45, $A3, $46, $A5, $48, $9E, $41, $9F
		dc.b $43
		wStopRead
		dc.b $9E, $41, $9F, $43
		wStopRead
		dc.b $9F, $43, $A1, $45
		wStopRead
		dc.b $9F, $48, $A1, $4A
		wStopRead
		dc.b $A1
		wTempoDiv	$10
		dc.b $4A
		wStopRead
		wTempoDiv	$0C
		dc.b $A5, $4D
		wStopRead
		wTempo		$A0
		dc.b $01, $C4
		wTempoDiv	$0D
		dc.b $A5, $4D, $C2
		wTempoDiv	$0C
		dc.b $A5, $4D
		wStopRead
		dc.b $A1, $4A, $9F, $48
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $A1, $4A, $C2
		wTempoDiv	$0C
		dc.b $A1, $4A, $9F, $48
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $9E, $41, $9F, $43
		wTempo		$A8
		dc.b $01, $C0
		wTempoDiv	$10
		dc.b $A3, $46, $A1, $45, $9F, $43, $9E, $41
		wTempo		$B0
		dc.b $01, $9F, $43, $C3
		wStopRead
		dc.b $C0, $A5, $48, $A3, $46
		wTempo		$C0
		dc.b $01, $A1, $45, $9F, $43, $9E, $41
		wSetTimerB	$72
		wStopRead
		wTempo		$ED
		dc.b $01
		wLoopGoEnd

.11_01_01
		wSetVol		$10
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$10
		dc.b $9F, $46, $3E, $9F, $46, $3E
		wAddVol		$FB
		dc.b $9F, $46, $3E, $9F, $46, $3E
		wAddVol		$FB
		dc.b $9F, $46, $3E
		wAddVol		$05
		dc.b $9F, $46, $3E
		wAddVol		$05
		dc.b $9F, $46, $3E, $9F, $46, $3E, $9E, $45
		dc.b $3C, $9E, $45, $3C
		wAddVol		$FB
		dc.b $9E, $45, $3C
		wTempo		$DC
		dc.b $01
		wAddVol		$FB
		dc.b $9E, $45, $3C
		wTempo		$D0
		dc.b $01, $2B, $97, $3A
		wTempo		$CC
		dc.b $01
		wAddVol		$FB
		dc.b $2D, $97, $3A
		wTempo		$D0
		dc.b $01
		wAddVol		$FB
		dc.b $2E, $97, $3A
		wTempo		$D4
		dc.b $01
		wAddVol		$FB
		dc.b $2F, $97, $3A
		wTempo		$ED
		dc.b $01
		wLoopGoEnd

.11_01
		wSetMask	$0E
		wSetPat		$21
		wAddFreq	$0000
		wTempo		$84
		dc.b $01
		wLoopGo		$00, .11_01_00

.11_01_02
		dc.b $CA
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		wLoopBackInit	$03
		wStopRead
		wLoopBack
		wLoopGo		$00, .11_01_01
		wLoopBackInit	$03
		dc.b $CA
		wStopRead
		wLoopBack
		wJump		.11_01_02

.11_02_06
.11_02_01
.11_02_03
		wSetVol		$1B
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$FC
		dc.b $43, $46, $4B, $C6, $4A, $C4, $43, $46
		wSetTimerB	$D8
		dc.b $48, $C4
		wStopRead
		dc.b $46, $43, $46, $41, $46, $3F, $46
		wLoopGoEnd

.11_02_08
		wSetVol		$1B
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$FC
		dc.b $48, $C2
		wTempoDiv	$0C
		dc.b $4A
		wSetTimerB	$9C
		wTempoDiv	$0D
		dc.b $4B, $C4, $4A, $C2
		wTempoDiv	$0C
		dc.b $4B
		wSetTimerB	$9C
		wTempoDiv	$0D
		dc.b $4D, $C4, $4B, $C2
		wTempoDiv	$0C
		dc.b $4D, $C5, $4F, $C2, $4B, $4D, $4F
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $46, $4B, $4F, $C2
		wTempoDiv	$0C
		dc.b $51, $52, $51, $4F, $C4
		wTempoDiv	$0D
		dc.b $51, $4F, $4E, $4A, $48, $46
		wLoopGoEnd

.11_02_07
.11_02_02
		wSetVol		$1B
		dc.b $C8
		wTempoDiv	$0D
		wAddVol		$FC
		dc.b $43, $C0
		wTempoDiv	$0B
		wAddVol		$F6
		dc.b $35, $C3
		wTempoDiv	$10
		dc.b $37, $C4
		wTempoDiv	$0D
		wAddVol		$0A
		dc.b $43, $C0
		wTempoDiv	$0B
		wAddVol		$F6
		dc.b $35, $C3
		wTempoDiv	$10
		dc.b $37, $C4
		wTempoDiv	$0D
		wAddVol		$0A
		dc.b $43
		wLoopGoEnd

.11_02_04
		wSetVol		$1B
		dc.b $C8
		wTempoDiv	$0D
		wAddVol		$FC
		dc.b $43, $C4
		wStopRead
		dc.b $43, $41, $3E
		wLoopGoEnd

.11_02_00
		wSetVol		$1B
		dc.b $CF
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$F2
		dc.b $3E, $40, $41
		wLoopGoEnd

.11_02_05
		wSetVol		$1B
		dc.b $C4
		wStopRead
		wTempoDiv	$0D
		wAddVol		$FC
		dc.b $43, $49, $43, $46, $C6, $48, $C4, $49
		dc.b $48, $4A, $4D, $C6, $4A, $C2
		wTempoDiv	$0C
		dc.b $4A, $48, $46, $48, $43, $46, $C4
		wStopRead
		wTempoDiv	$0D
		dc.b $43, $46, $43, $45, $C6, $41, $C4, $48
		dc.b $C7, $4A, $C2
		wTempoDiv	$0C
		dc.b $48, $46, $C6
		wTempoDiv	$0D
		dc.b $43
		wStopRead
		dc.b $C4
		wStopRead
		dc.b $4F, $C6, $4F, $C4, $49, $48, $C2
		wTempoDiv	$0C
		dc.b $45, $46, $C4
		wTempoDiv	$0D
		dc.b $43, $4A, $C6, $4D, $C2
		wTempoDiv	$0C
		dc.b $48, $46, $C6
		wTempoDiv	$0D
		dc.b $48, $C4
		wTempoDiv	$10
		dc.b $4A, $C2
		wTempoDiv	$0C
		dc.b $46, $43, $C4
		wTempoDiv	$0D
		dc.b $46, $43, $45, $46, $C6, $48, $C4, $4B
		dc.b $48, $4D, $C6, $4A, $C2
		wTempoDiv	$0C
		dc.b $46, $48, $C4
		wTempoDiv	$0D
		dc.b $4A, $56, $4A, $56
		wLoopGoEnd

.11_02
		wSetMask	$0E
		wSetPat		$25
		wAddFreq	$F400
		dc.b $CA
		wLoopBackInit	$06
		wStopRead
		wLoopBack
		wLoopGo		$00, .11_02_00

.11_02_09
		wSetPat		$25
		wLoopGo		$00, .11_02_01
		wLoopGo		$00, .11_02_02
		wLoopGo		$00, .11_02_03
		wLoopGo		$00, .11_02_04
		wLoopGo		$00, .11_02_05
		wLoopGo		$00, .11_02_06
		wLoopGo		$00, .11_02_07
		dc.b $CA
		wLoopBackInit	$03
		wStopRead
		wLoopBack
		wSetPat		$0A
		wLoopGo		$00, .11_02_08
		wJump		.11_02_09

.11_03_00
		wSetVol		$1F
		dc.b $CF
		wStopRead
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$F2
		dc.b $99, $3E, $9B, $40, $9C, $41
		wLoopGoEnd

.11_03_0F
.11_03_0D
.11_03_01
.11_03_03
.11_03_07
.11_03_05
		wSetVol		$1F
		dc.b $C5
		wTempoDiv	$10
		wAddVol		$06
		dc.b $9E, $43, $C4, $9C, $41, $C2
		wStopRead
		dc.b $9E, $43, $C5
		wStopRead
		dc.b $C4, $46, $45, $41
		wLoopGoEnd

.11_03_02
.11_03_0E
.11_03_06
		wSetVol		$1F
		dc.b $C5
		wTempoDiv	$10
		wAddVol		$06
		dc.b $9E, $43, $C4, $9C, $41, $C2
		wStopRead
		dc.b $9E, $43
		wStopRead
		wAddVol		$F6
		dc.b $32, $37, $32, $39, $32, $3A, $32, $3C
		wLoopGoEnd

.11_03_10
.11_03_04
		wSetVol		$1F
		dc.b $C5
		wTempoDiv	$10
		wAddVol		$06
		dc.b $9E, $43, $C4, $9C, $41, $C2
		wStopRead
		dc.b $9A, $3F
		wStopRead
		dc.b $C6, $99, $3E, $97, $3C
		wLoopGoEnd

.11_03_08
		wSetVol		$1F
		dc.b $C5
		wTempoDiv	$10
		wAddVol		$06
		dc.b $9E, $43, $C4, $9C, $41, $C2
		wStopRead
		dc.b $9A, $3F
		wStopRead
		dc.b $C4, $99, $3E
		wAddVol		$F6
		dc.b $AF, $52, $AD, $51, $AA, $4D
		wLoopGoEnd

.11_03_0B
.11_03_09
		wSetVol		$1F
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$FC
		dc.b $3F, $37, $3A, $3C
		wStopRead
		dc.b $C6, $3F, $C2
		wTempoDiv	$0C
		dc.b $39, $3C, $C4
		wTempoDiv	$0D
		dc.b $3E, $35, $3A, $39
		wStopRead
		dc.b $C6, $37, $C4, $35
		wLoopGoEnd

.11_03_0A
		wSetVol		$1F
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$FC
		dc.b $3A, $35, $37, $3A
		wStopRead
		dc.b $35, $37, $3A, $3C, $37, $39, $3C
		wStopRead
		wTempoDiv	$10
		dc.b $3A, $39, $35
		wLoopGoEnd

.11_03_0C
		wSetVol		$1F
		dc.b $C8
		wTempoDiv	$10
		wAddVol		$FC
		dc.b $37, $39, $3A, $C6, $97, $3C, $99, $3E
		wLoopGoEnd

.11_03_11
		wSetVol		$1F
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$F6
		dc.b $4A, $C2, $48, $46, $C4, $48, $C2, $43
		dc.b $C5
		wStopRead
		dc.b $C2, $43, $41, $43, $45, $46, $48, $41
		dc.b $43
		wStopRead
		dc.b $41, $43
		wStopRead
		dc.b $43, $45
		wStopRead
		dc.b $48, $4A
		wStopRead
		dc.b $C4, $4A, $C2, $4D
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $4D, $C2, $4D
		wStopRead
		wTempoDiv	$10
		dc.b $4A, $48
		wStopRead
		dc.b $C4
		wTempoDiv	$0D
		dc.b $4A, $C2, $4A
		wTempoDiv	$10
		dc.b $48
		wStopRead
		dc.b $C4, $41, $43, $C6, $4F, $4D, $4B, $4A
		wLoopGoEnd

.11_03_12
		wSetVol		$1F
		dc.b $C5
		wTempoDiv	$10
		wAddVol		$06
		dc.b $A3, $3C, $A6, $3F, $C2, $A3, $3C, $C5
		wStopRead
		dc.b $C4, $3A, $39, $35, $C5, $A5, $3E, $A8
		dc.b $41, $C2, $A5, $3E, $C5
		wStopRead
		dc.b $C4, $3A, $39, $35, $C5, $9F, $46, $9E
		dc.b $45, $C6, $9C, $43, $C4, $9A, $3F, $99
		dc.b $3E, $97, $3C, $C5, $92, $3E, $92, $43
		dc.b $C4, $92, $4A, $C5, $92, $45, $92, $42
		dc.b $C4, $92, $3E
		wLoopGoEnd

.11_03
		wSetMask	$0E
		dc.b $CA
		wLoopBackInit	$06
		wStopRead
		wLoopBack
		wSetPat		$0A
		wAddFreq	$F400
		wLoopGo		$00, .11_03_00

.11_03_13
		wLoopGo		$00, .11_03_01
		wLoopGo		$00, .11_03_02
		wLoopGo		$00, .11_03_03
		wLoopGo		$00, .11_03_04
		wLoopGo		$00, .11_03_05
		wLoopGo		$00, .11_03_06
		wLoopGo		$00, .11_03_07
		wLoopGo		$00, .11_03_08
		wLoopGo		$00, .11_03_09
		wLoopGo		$00, .11_03_0A
		wLoopGo		$00, .11_03_0B
		wLoopGo		$00, .11_03_0C
		wLoopGo		$00, .11_03_0D
		wLoopGo		$00, .11_03_0E
		wLoopGo		$00, .11_03_0F
		wLoopGo		$00, .11_03_10
		wLoopGo		$00, .11_03_11
		wLoopGo		$00, .11_03_12
		wJump		.11_03_13

.11_04_06
		wSetVol		$00
		dc.b $C4
		wAddVol		$0C
		dc.b $60
		wAddVol		$14
		dc.b $0F, $C2, $10
		wStopRead
		wAddVol		$EC
		dc.b $60
		wAddVol		$14
		dc.b $0F
		wStopRead
		dc.b $0F, $0F
		wAddVol		$EC
		dc.b $60
		wAddVol		$14
		dc.b $0F
		wStopRead
		dc.b $0F
		wStopRead
		wAddVol		$E2
		dc.b $65
		wAddVol		$1E
		dc.b $0F
		wStopRead
		dc.b $0F
		wStopRead
		wLoopGoEnd

.11_04_01
		wSetVol		$00
		dc.b $C0
		wAddVol		$0C
		dc.b $05, $05, $05, $05, $C4
		wStopRead
		dc.b $C0, $05, $05, $05, $05, $C6
		wStopRead
		dc.b $C2
		wAddVol		$F6
		dc.b $05, $05, $05
		wStopRead
		dc.b $05, $05
		wLoopGoEnd

.11_04_00
.11_04_02
.11_04_03
.11_04_04
.11_04_0A
.11_04_08
		wSetVol		$00
		dc.b $C4
		wAddVol		$0C
		dc.b $00, $05, $C2, $00, $00, $05
		wStopRead
		dc.b $C4, $00, $C2, $05
		wStopRead
		dc.b $00
		wStopRead
		dc.b $05
		wStopRead
		wLoopGoEnd

.11_04_07
.11_04_0B
.11_04_09
.11_04_05
		wSetVol		$00
		dc.b $C4
		wAddVol		$0C
		dc.b $00, $05, $C2, $00, $00, $05
		wStopRead
		dc.b $C4, $00, $C2, $05, $05, $60, $05, $05
		dc.b $05, $05
		wLoopGoEnd

.11_04
		wDrumChannel
		wLoopGo		$06, .11_04_00
		wLoopGo		$00, .11_04_01

.11_04_0C
		wLoopGo		$07, .11_04_02
		wLoopGo		$07, .11_04_03
		wLoopGo		$02, .11_04_04
		wLoopGo		$00, .11_04_05
		wLoopGo		$02, .11_04_06
		wLoopGo		$00, .11_04_07
		wLoopGo		$00, .11_04_08
		wLoopGo		$00, .11_04_09
		wLoopGo		$00, .11_04_0A
		wLoopGo		$00, .11_04_0B
		wJump		.11_04_0C

.11
		wHeaderMus	$88, $019C
		dw	.11_00
		dw	.11_01
		dw	.11_02
		dw	.11_03
		dw	.11_04
		dw	$0000

.12_00_00
		wSetVol		$F8
		wSetTimerW	$0180
		wTempoDiv	$10
		wAddVol		$0D
		dc.b $32, $30
		wLoopGoEnd

.12_00_01
		wSetVol		$F8
		dc.b $C8
		wAddVol		$17
		dc.b $2E, $CA, $2D, $C8, $2E, $CA, $2D, $C8
		dc.b $32, $32, $CA, $33, $C8, $32, $31, $C2
		wAddVol		$0A
		dc.b $2D, $2E, $2D, $2E, $2D, $2E, $2D, $2E
		wAddVol		$FB
		dc.b $2D, $2E, $2D, $2E, $2D, $2E, $2D, $2E
		wLoopGoEnd

.12_00_02
		wSetVol		$F8
		dc.b $C2
		wAddVol		$17
		dc.b $2D, $2E, $2D, $2E, $2D
		wAddVol		$FB
		dc.b $2E, $2D, $2E, $2D, $2E
		wAddVol		$FB
		dc.b $2D, $2E, $2D, $2E, $2D, $2E
		wLoopGoEnd

.12_00_03
.12_00
		wSetMask	$01
		wSetPat		$29
		wSetFreq	$F400
		wLoopGo		$03, .12_00_00
		wLoopGo		$01, .12_00_01
		wLoopGo		$00, .12_00_02
		wJump		.12_00_03

.12_01_00
		wSetVol		$04
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$2B
		dc.b $59, $56, $58, $54, $56, $53, $54, $51
		dc.b $53, $4F, $51, $4D, $4F, $4C, $4D, $4A
		wLoopGoEnd

.12_01_01
.12_01_02
		wSetVol		$04
		dc.b $CA
		wStopRead
		wLoopGoEnd

.12_01_03
.12_01
		wSetMask	$3E
		wSetPat		$21
		wLoopGo		$07, .12_01_00
		wLoopGo		$07, .12_01_01
		wLoopGo		$06, .12_01_02
		wJump		.12_01_03

.12_02_00
		wSetVol		$04
		wSetTimerB	$F0
		wTempoDiv	$10
		wAddVol		$17
		dc.b $4A, $C6, $45, $4A, $4D
		wSetTimerB	$F0
		dc.b $4C, $C6, $48, $53, $54
		wSetTimerW	$01E0
		dc.b $51, $C6, $9C, $40, $9E, $41, $C8, $A0
		dc.b $43, $A1, $45
		wLoopGoEnd

.12_02_01
		wSetVol		$04
		wSetTimerB	$F0
		wAddVol		$17
		dc.b $4A, $C6, $45, $4A, $4D
		wSetTimerB	$F0
		dc.b $4C, $C6, $4A, $48, $4A, $C8, $45, $C6
		dc.b $A1, $45, $A3, $47, $C8, $A5, $48, $C9
		wAddVol		$0A
		dc.b $A7, $4A, $C6
		wStopRead
		wAddVol		$0A
		dc.b $AD, $51
		wAddVol		$F6
		dc.b $AF, $53, $C8
		wAddVol		$F6
		dc.b $B1, $54
		wAddVol		$0A
		dc.b $B3, $56
		wLoopGoEnd

.12_02_02
		wSetVol		$04
		dc.b $C8
		wAddVol		$21
		dc.b $AD, $52, $AC, $51, $A6, $4C, $AD, $52
		dc.b $AC, $51, $A6, $4C
		wStopRead
		dc.b $C6
		wAddVol		$F6
		dc.b $A0, $43, $A1, $45, $C8
		wAddVol		$0A
		dc.b $A3, $46, $A1, $45, $A5, $4A, $A4, $49
		dc.b $CA, $A1, $45
		wLoopGoEnd

.12_02_03
		wSetVol		$04
		dc.b $C8
		wStopRead
		dc.b $C6
		wAddVol		$21
		dc.b $48, $49
		wLoopGoEnd

.12_02
		wSetMask	$3E
		wSetPat		$21
		wAddFreq	$F400

.12_02_04
		wLoopGo		$00, .12_02_00
		wLoopGo		$00, .12_02_01
		wLoopGo		$01, .12_02_02
		wLoopGo		$00, .12_02_03
		wJump		.12_02_04

.12
		wHeaderMus	$88, $0230
		dw	.12_00
		dw	.12_01
		dw	.12_02
		dw	$0000

.13_00_00
		wSetVol		$F4
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$17
		dc.b $2B, $37, $2B, $39, $2B, $37, $2B, $35
		dc.b $29, $34, $28, $32, $26, $30, $24, $2B
		dc.b $CA, $30
		wLoopGoEnd

.13_00
		wSetMask	$01
		wSetPat		$07
		wLoopGo		$00, .13_00_00
		wLoopGoEnd

.13_01_00
		wSetVol		$08
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$12
		dc.b $43, $41, $40, $C6, $3E, $C4, $40, $C6
		dc.b $41, $C4, $4F, $4D, $4C, $C6, $4A, $C4
		dc.b $4C, $C6, $4D, $CA, $A3, $48
		wLoopGoEnd

.13_01
		wSetMask	$3E
		wSetPat		$21
		wLoopGo		$00, .13_01_00
		wLoopGoEnd

.13_02_00
		wSetVol		$00
		dc.b $C2
		wTempoDiv	$10
		wAddVol		$17
		dc.b $59, $56, $53, $4F, $58, $54, $51, $4D
		dc.b $56, $53, $4F, $4C, $54, $51, $4D, $4A
		dc.b $53, $4F, $4C, $48, $51, $4D, $4A, $47
		dc.b $4F, $4C, $48, $45, $4D, $4A, $47, $43
		dc.b $CA, $A0, $A3, $48
		wLoopGoEnd

.13_02
		wSetMask	$3E
		wSetPat		$1D
		wLoopGo		$00, .13_02_00
		wLoopGoEnd

.13
		wHeaderMus	$88, $0210
		dw	.13_00
		dw	.13_01
		dw	.13_02
		dw	$0000

.14_00_00
		wSetVol		$FD
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$0D
		dc.b $2D, $2D
		wStopRead
		dc.b $C7
		wStopRead
		wStopRead
		wLoopGoEnd

.14_00_01
		wSetVol		$FD
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$0D
		dc.b $2D, $2D
		wStopRead
		dc.b $C7
		wStopRead
		dc.b $C4
		wAddVol		$0A
		dc.b $2B
		wStopRead
		dc.b $2B
		wLoopGoEnd

.14_00
.14_00_02
		wSetMask	$01
		wSetPat		$07
		wLoopGo		$06, .14_00_00
		wLoopGo		$00, .14_00_01
		wJump		.14_00_02

.14_01_00
		wSetVol		$25
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$F2
		dc.b $3B, $3C, $41, $40, $3C, $3B, $3C, $41
		dc.b $3C
		wLoopGoEnd

.14_01
.14_01_01
		wSetMask	$0E
		wSetPat		$26
		wLoopGo		$07, .14_01_00
		wJump		.14_01_01

.14_02_00
		wSetVol		$10
		wSetTimerW	$01B0
		wTempoDiv	$10
		wAddVol		$17
		dc.b $A7, $4C, $A8, $4D, $AA, $4F
		wSetTimerB	$F0
		dc.b $A8, $4D, $C6
		wStopRead
		dc.b $C7
		wStopRead
		dc.b $C4, $A7, $4C
		wStopRead
		dc.b $A5, $4A
		wSetTimerW	$0360
		wTempoDiv	$10
		dc.b $A7, $4C
		wSetTimerW	$01B0
		wSetPat		$31
		wTempoDiv	$04
		dc.b $AA, $4F, $AA, $4F
		wSetPat		$0A
		wTempoDiv	$10
		wLoopGoEnd

.14_02
.14_02_01
		wSetMask	$0E
		wSetFreq	$F400
		wSetPat		$0A
		wLoopGo		$00, .14_02_00
		wJump		.14_02_01

.14_03_00
		wSetVol		$FC
		dc.b $C4
		wAddVol		$12
		dc.b $60
		wAddVol		$0A
		dc.b $0F
		wStopRead
		wAddVol		$F6
		dc.b $60, $65
		wAddVol		$0A
		dc.b $0F
		wAddVol		$F6
		dc.b $00, $60
		wAddVol		$0A
		dc.b $10
		wAddVol		$F6
		dc.b $65
		wAddVol		$0A
		dc.b $0F, $0F
		wAddVol		$F6
		dc.b $05
		wAddVol		$0A
		dc.b $0F
		wLoopGoEnd

.14_03_01
		wSetVol		$FC
		dc.b $C4
		wAddVol		$12
		dc.b $00
		wStopRead
		dc.b $05, $C2, $00, $0D, $0D, $0C, $0C, $0C
		dc.b $C4, $05
		wStopRead
		dc.b $C2, $11
		wStopRead
		wLoopGoEnd

.14_03
		wDrumChannel

.14_03_02
		wLoopGo		$06, .14_03_00
		wLoopGo		$00, .14_03_01
		wJump		.14_03_02

.14
		wHeaderMus	$88, $0265
		dw	.14_00
		dw	.14_01
		dw	.14_02
		dw	.14_03
		dw	$0000

.15_00_00
.15_01_00
		wSetVol		$08
		dc.b $C2
		wTempoDiv	$09
		wAddVol		$21
		dc.b $5D, $58, $54, $4D, $5B, $56, $53, $4D
		dc.b $5D, $58, $54, $4F, $5B, $56, $53, $4F
		wLoopGoEnd

.15_00
.15_00_01
		wSetMask	$11
		wSetPat		$2D
		wLoopGo		$07, .15_00_00
		wJump		.15_00_01

.15_01
		wSetMask	$22
		wSetPat		$1C
		wAddFreq	$0020
		wSetTimerB	$04
		wStopRead

.15_01_01
		wLoopGo		$07, .15_01_00
		wJump		.15_01_01

.15_02
.15_02_00
		wSetMask	$0C
		wSetPat		$31
		wSetVol		$18
		wTempoDiv	$0E
		wLoopBackInit	$04
		dc.b $CA
		wStopRead
		wStopHw
		wLoopBack
		dc.b $CA, $B8, $5C
		wStopRead
		wStopRead
		wStopHw
		wJump		.15_02_00

.15
		wHeaderMus	$88, $0200
		dw	.15_00
		dw	.15_01
		dw	.15_02
		dw	$0000

.16_00_00
		wSetVol		$F5
		dc.b $C7
		wTempoDiv	$10
		wAddVol		$17
		dc.b $30, $C4, $30, $C7
		wStopRead
		dc.b $C4, $29
		wStopRead
		dc.b $35
		wStopRead
		dc.b $29, $2B
		wStopRead
		dc.b $37
		wStopRead
		wLoopGoEnd

.16_00_01
.16_00_16
.16_00_03
.16_00_14
		wSetVol		$F5
		dc.b $C7
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $30, $C4, $30, $C7
		wStopRead
		dc.b $C4, $30, $C7, $2F, $C4, $2F, $C7
		wStopRead
		dc.b $C4, $2F, $C7, $2D, $C4, $2D, $C7
		wStopRead
		dc.b $C4, $2D, $C7, $2B, $C4, $2B, $C7
		wStopRead
		dc.b $C4, $2B, $29, $C6
		wStopRead
		dc.b $C4, $29, $C7
		wStopRead
		dc.b $C4, $29, $C7, $28, $C4, $28, $C7
		wStopRead
		dc.b $C4, $28
		wLoopGoEnd

.16_00_15
.16_00_02
.16_00_17
		wSetVol		$F5
		dc.b $C6
		wTempoDiv	$10
		wAddVol		$17
		dc.b $26, $C4, $28
		wTempoDiv	$0D
		dc.b $29, $C6
		wStopRead
		dc.b $C4, $29, $C7
		wTempoDiv	$0E
		dc.b $2B, $C4
		wStopRead
		dc.b $C7
		wTempoDiv	$0D
		dc.b $2B, $C6, $2F
		wLoopGoEnd

.16_00_04
		wSetVol		$F5
		dc.b $C7
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $29, $C4, $29
		wStopRead
		dc.b $2B
		wStopRead
		dc.b $C7, $28, $C4
		wStopRead
		dc.b $28
		wStopRead
		dc.b $2F, $30, $32
		wLoopGoEnd

.16_00_07
.16_00_05
.16_00_0D
.16_00_0F
		wSetVol		$F5
		dc.b $C7
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $29, $C4, $29, $C8, $29
		wLoopGoEnd

.16_00_06
.16_00_0E
		wSetVol		$F5
		dc.b $C7
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $28, $C4, $28, $C8, $28
		wLoopGoEnd

.16_00_0A
.16_00_08
.16_00_10
		wSetVol		$F5
		dc.b $C7
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $2B, $C4, $2B, $C6, $2B, $2C
		wLoopGoEnd

.16_00_0B
.16_00_11
.16_00_09
		wSetVol		$F5
		dc.b $C7
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $2D, $C4, $2D, $C8, $2D
		wLoopGoEnd

.16_00_12
.16_00_0C
		wSetVol		$F5
		dc.b $C7
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $2B, $C4, $2B, $C8, $2B
		wLoopGoEnd

.16_00_13
		wSetVol		$F5
		dc.b $C7
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $26, $C4, $26, $C8, $26, $C7, $2B, $C4
		dc.b $2B, $C8, $2B
		wLoopGoEnd

.16_00_18
		wSetVol		$F5
		dc.b $C4
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $30, $30, $C9
		wStopRead
		dc.b $C4
		wStopRead
		wTempoDiv	$10
		wAddVol		$F6
		dc.b $2B
		wStopRead
		dc.b $2B
		wStopRead
		dc.b $2B
		wStopRead
		dc.b $2B
		wLoopGoEnd

.16_00
		wSetMask	$01
		wSetPat		$07
		wLoopGo		$03, .16_00_00
		wLoopGo		$00, .16_00_01
		wLoopGo		$00, .16_00_02
		wLoopGo		$00, .16_00_03
		wLoopGo		$00, .16_00_04
		wLoopGo		$00, .16_00_05
		wLoopGo		$00, .16_00_06
		wLoopGo		$00, .16_00_07
		wLoopGo		$00, .16_00_08
		wLoopGo		$00, .16_00_09
		wLoopGo		$00, .16_00_0A
		wLoopGo		$00, .16_00_0B
		wLoopGo		$00, .16_00_0C
		wLoopGo		$00, .16_00_0D
		wLoopGo		$00, .16_00_0E
		wLoopGo		$00, .16_00_0F
		wLoopGo		$00, .16_00_10
		wLoopGo		$00, .16_00_11
		wLoopGo		$00, .16_00_12
		wLoopGo		$00, .16_00_13
		wLoopGo		$00, .16_00_14
		wLoopGo		$00, .16_00_15
		wLoopGo		$00, .16_00_16
		wLoopGo		$00, .16_00_17
		wTempo		$00
		dc.b $02
		wLoopGo		$03, .16_00_18
		dc.b $C6, $2B
		wLoopGoEnd

.16_01_00
		wSetVol		$05
		dc.b $C4
		wTempoDiv	$0A
		wAddVol		$21
		dc.b $3C, $43, $48, $3C, $47, $48, $3C, $43
		dc.b $3C, $47, $48, $3C, $47, $48, $3C, $43
		dc.b $3C, $43, $48, $3C, $47, $48, $3C, $43
		wAddVol		$F6
		dc.b $3C, $A1, $45, $A1, $45, $3C, $3E, $A3
		dc.b $47, $A3, $47, $3E
		wLoopGoEnd

.16_01_03
.16_01_07
.16_01_05
.16_01_01
		wSetVol		$05
		dc.b $C4
		wTempoDiv	$0A
		wAddVol		$21
		dc.b $9B, $40, $9C, $41, $9E, $43, $A0, $45
		wStopRead
		dc.b $40, $3E, $40, $99, $3E, $9B, $40, $9E
		dc.b $43, $9B, $3E
		wStopRead
		dc.b $C2
		wTempoDiv	$10
		dc.b $3C
		wTempoDiv	$09
		wAddVol		$0A
		dc.b $3B, $C4
		wTempoDiv	$0A
		wAddVol		$F6
		dc.b $3C, $37, $99, $3C, $9B, $3E, $9C, $40
		dc.b $9C, $40
		wStopRead
		dc.b $45, $40, $3C, $9B, $3E, $9C, $40, $9E
		dc.b $43, $9B, $3E
		wStopRead
		dc.b $3E, $3C, $3B, $99, $35, $37, $39, $C6
		dc.b $99, $3C, $C4, $3B, $39, $37, $97, $40
		dc.b $3E, $3C, $C6, $97, $3B, $C4, $39, $37
		dc.b $39
		wLoopGoEnd

.16_01_02
.16_01_08
.16_01_06
		wSetVol		$05
		dc.b $C6
		wTempoDiv	$0A
		wAddVol		$0D
		dc.b $95, $39, $C4, $97, $3B, $99, $3C
		wStopRead
		dc.b $9B, $3E
		wStopRead
		dc.b $9C, $40
		wStopRead
		dc.b $9E, $41, $9C, $40, $9B, $3E
		wStopRead
		dc.b $99, $3C, $97, $3B
		wStopRead
		wLoopGoEnd

.16_01_04
		wSetVol		$05
		dc.b $C6
		wTempoDiv	$0A
		wAddVol		$0D
		dc.b $9E, $41, $C4, $9C, $40, $C6, $9B, $3E
		dc.b $C4
		wStopRead
		dc.b $99, $3C, $9B, $40, $C7
		wStopRead
		dc.b $C4, $94, $38
		wStopRead
		dc.b $98, $3B, $9B, $3E, $9B, $40
		wLoopGoEnd
	; Unused
		dc.b $F4, $05, $C4, $F1, $0A, $F5, $21, $9A
	; Unused
		dc.b $3F, $43, $3F, $3C, $98, $3E, $3F, $98
	; Unused
		dc.b $3E, $37, $FF, $F4, $05, $C4, $F1, $0A
	; Unused
		dc.b $F5, $21, $99, $3E, $43, $3E, $3B, $97
		dc.b $3D, $3E, $97, $3D, $36, $FF

.16_01_09
		wSetVol		$05
		dc.b $C4
		wTempoDiv	$05
		wAddVol		$17
		dc.b $3C, $3F, $43, $3F, $3C, $43, $3F, $3C
		dc.b $42, $3F, $3C, $42, $3F, $3C, $42, $3C
		dc.b $3C, $3F, $45, $3F, $3C, $45, $3F, $3C
		wLoopGoEnd

.16_01_0A
		wSetVol		$05
		dc.b $C4
		wTempoDiv	$05
		wAddVol		$17
		dc.b $43, $3F, $3C, $43, $3F, $C2
		wTempoDiv	$10
		wAddVol		$F6
		dc.b $9E, $43, $9D, $42, $9A, $3F, $99, $3E
		dc.b $97, $3C, $92, $37
		wLoopGoEnd

.16_01_0B
		wSetVol		$05
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$17
		dc.b $93, $43, $9F, $46, $9F, $46, $92, $39
		dc.b $C2, $9E, $45, $9E, $45
		wStopRead
		dc.b $9E, $45, $C4, $9D, $44, $9C, $43
		wLoopGoEnd

.16_01_0C
		wSetVol		$05
		dc.b $C4
		wStopRead
		wTempoDiv	$0D
		wAddVol		$17
		dc.b $95, $3F, $93, $3E, $92, $3C, $C2, $9C
		dc.b $43, $9A, $41, $95, $3C, $99, $3F
		wAddVol		$F6
		dc.b $93, $3A, $92, $39, $C7, $90, $37
		wLoopGoEnd

.16_01
		wSetMask	$0C
		wSetPat		$27
		wLoopGo		$01, .16_01_00
		wLoopGo		$00, .16_01_01
		wLoopGo		$00, .16_01_02
		wLoopGo		$00, .16_01_03
		wLoopGo		$00, .16_01_04
		dc.b $CA
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		wLoopGo		$00, .16_01_05
		wLoopGo		$00, .16_01_06
		wLoopGo		$00, .16_01_07
		wLoopGo		$00, .16_01_08
		wLoopGo		$00, .16_01_09
		wLoopGo		$00, .16_01_0A
		wLoopGo		$02, .16_01_0B
		wLoopGo		$00, .16_01_0C
		wLoopGoEnd

.16_02_00
.16_02_01
		wSetVol		$18
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$F6
		dc.b $A8, $4C, $AA, $4D, $A8, $4C, $C6, $A7
		dc.b $4A, $A5, $48, $A1, $45, $A8, $4C, $A7
		dc.b $4A, $C4, $48, $4A, $48, $C5, $A8, $4C
		dc.b $A3, $48, $CF, $A0, $43
		wLoopGoEnd

.16_02_07
.16_02_02
.16_02_06
.16_02_04
		wSetVol		$18
		dc.b $C8
		wStopRead
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$F2
		dc.b $40, $41
		wTempoDiv	$0D
		dc.b $43, $C8
		wTempoDiv	$10
		dc.b $43, $C6, $45, $C4, $43, $41, $CF, $40
		dc.b $C4, $3C, $3E
		wTempoDiv	$0D
		dc.b $40, $C7
		wTempoDiv	$0F
		dc.b $40, $C4
		wTempoDiv	$10
		dc.b $41, $C6, $40, $C4, $3E, $3C, $3E, $C9
		dc.b $39, $C4, $3E
		wSetTimerB	$A8
		dc.b $3C, $C4, $37, $37
		wLoopGoEnd

.16_02_03
		wSetVol		$18
		dc.b $C6
		wTempoDiv	$10
		wAddVol		$F2
		dc.b $39, $C4, $3B, $C6, $3C, $C4
		wStopRead
		dc.b $3E, $C8, $40, $CF, $3E
		wLoopGoEnd

.16_02_05
		wSetVol		$18
		dc.b $C6
		wTempoDiv	$10
		wAddVol		$F2
		dc.b $41, $C4, $40, $C6, $41, $43
		wSetTimerB	$D8
		dc.b $40
		wLoopGoEnd

.16_03_08
.16_02_08
		wSetVol		$18
		dc.b $C6
		wTempoDiv	$10
		wAddVol		$F2
		dc.b $41, $C4, $40, $3E
		wStopRead
		dc.b $3C
		wStopRead
		dc.b $40
		wStopRead
		wTempoDiv	$0D
		dc.b $3E, $C8, $3E, $C6
		wTempoDiv	$10
		dc.b $3B
		wLoopGoEnd

.16_02_0A
.16_02_09
		wSetVol		$18
		wTempoDiv	$10
		wAddVol		$F2
		dc.b $C6, $3C, $43, $42, $C7, $46
		wSetTimerB	$A8
		wStopRead
		wLoopGoEnd

.16_02
		wSetType	$02
		wSetMask	$07
		wSetFreq	$E800
		wSetPat		$02
		wLoopGo		$00, .16_02_00
		dc.b $CA
		wStopRead
		wLoopGo		$00, .16_02_01
		dc.b $CA
		wStopRead
		wLoopGo		$00, .16_02_02
		wLoopGo		$00, .16_02_03
		wLoopGo		$00, .16_02_04
		wLoopGo		$00, .16_02_05
		dc.b $CA
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		wLoopGo		$00, .16_02_06
		dc.b $CA
		wStopRead
		wStopRead
		wLoopGo		$00, .16_02_07
		wLoopGo		$00, .16_02_08
		wLoopGo		$00, .16_02_09
		dc.b $CA
		wStopRead
		wStopRead
		wLoopGo		$00, .16_02_0A
		wLoopGoEnd

.16_03_00
.16_03_06
.16_03_07
		wSetVol		$05
		dc.b $C8
		wStopRead
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$1E
		dc.b $40, $41
		wTempoDiv	$0D
		dc.b $43, $C8
		wTempoDiv	$10
		dc.b $43, $C6, $45, $C4, $43, $41, $CF, $40
		dc.b $C4, $3C, $3E
		wTempoDiv	$0D
		dc.b $40, $C7
		wTempoDiv	$0F
		dc.b $40, $C4
		wTempoDiv	$10
		dc.b $41, $C6, $40, $C4, $3E, $3C, $3E, $C9
		dc.b $39, $C4, $3E
		wSetTimerB	$A8
		dc.b $3C, $C4, $37, $37
		wLoopGoEnd

.16_03_01
		wSetVol		$05
		dc.b $C6
		wTempoDiv	$10
		wAddVol		$1C
		dc.b $41, $C4, $40, $C6, $41, $43
		wSetTimerB	$D8
		dc.b $40
		wLoopGoEnd

.16_03_04
.16_03_02
		wSetVol		$05
		dc.b $C8
		wStopRead
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$12
		dc.b $45, $47, $48, $C8, $47, $C6, $43, $40
		dc.b $CF, $45, $C4, $45, $47, $48, $C7, $4A
		dc.b $C4, $48, $C7, $47, $C6, $43, $C7, $45
		dc.b $C4
		wStopRead
		dc.b $45, $C7, $4C, $4A, $C2, $49, $48, $C8
		dc.b $47
		wLoopGoEnd

.16_03_03
		wSetVol		$05
		dc.b $C7
		wTempoDiv	$10
		wAddVol		$12
		dc.b $45, $C4
		wStopRead
		dc.b $45, $C7, $4C, $C8, $4A, $43
		wLoopGoEnd

.16_03_05
		wSetVol		$05
		dc.b $C6
		wTempoDiv	$10
		wAddVol		$12
		dc.b $45
		wStopRead
		dc.b $C4, $45, $C7, $48, $C8, $47, $4A
		wLoopGoEnd

.16_03_09
		wSetVol		$05
		dc.b $C4
		wStopRead
		dc.b $C2
		wTempoDiv	$10
		wAddVol		$30
		dc.b $A2, $43, $C5
		wStopRead
		dc.b $C2
		wAddVol		$F1
		dc.b $A2, $43, $C5
		wStopRead
		dc.b $C2
		wAddVol		$EC
		dc.b $A2, $43, $C5
		wStopRead
		dc.b $C2
		wAddVol		$F6
		dc.b $A2, $43
		wStopRead
		dc.b $C4
		wAddVol		$14
		dc.b $46, $48, $4F, $C7, $4E, $C4
		wAddVol		$0A
		dc.b $48, $CF
		wAddVol		$F6
		dc.b $4B, $C8, $4A
		wLoopGoEnd

.16_03_0A
		wSetVol		$05
		dc.b $C4
		wStopRead
		wTempoDiv	$10
		wAddVol		$1E
		dc.b $46, $45, $44, $43, $42, $41, $40, $C8
		wAddVol		$F6
		dc.b $48, $C4, $46, $45, $43, $CF, $4B, $C2
		wAddVol		$F8
		wTempoDiv	$0C
		dc.b $A8, $4D, $A7, $4C, $A6, $4B, $A5, $4A
		dc.b $A4, $49, $A3, $48, $A2, $47, $C6, $A1
		dc.b $46
		wLoopGoEnd

.16_03
		wSetMask	$0E
		wSetPat		$21
		wSetFreq	$0C00
		dc.b $CA
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		wLoopGo		$00, .16_03_00
		wLoopGo		$00, .16_03_01
		wLoopGo		$00, .16_03_02
		wLoopGo		$00, .16_03_03
		wLoopGo		$00, .16_03_04
		wLoopGo		$00, .16_03_05
		wSetFreq	$0000
		wLoopGo		$00, .16_03_06
		dc.b $CA
		wStopRead
		wStopRead
		wSetFreq	$0C00
		wLoopGo		$00, .16_03_07
		wLoopGo		$00, .16_03_08
		dc.b $C6, $3C, $43, $42, $46
		wSetPat		$01
		wSetFreq	$0000
		wLoopGo		$00, .16_03_09
		wSetPat		$21
		dc.b $C6, $3C, $43, $42, $46
		wSetPat		$01
		wLoopGo		$00, .16_03_0A
		wLoopGoEnd

.16_04_0E
.16_04_08
.16_04_00
.16_04_0A
.16_04_02
		wSetVol		$10
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$17
		dc.b $99, $40, $95, $3E, $99, $40, $95, $3E
		dc.b $99, $40, $95, $3E, $99, $40, $95, $3C
		wLoopGoEnd

.16_04_01
.16_04_05
.16_04_0F
.16_04_07
.16_04_0D
.16_04_09
.16_04_0B
.16_04_03
		wSetVol		$10
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$17
		dc.b $97, $3E, $94, $3B, $97, $3E, $94, $3B
		dc.b $97, $3E, $94, $3B, $97, $3E, $94, $3B
		wLoopGoEnd

.16_04_0C
.16_04_06
.16_04_04
		wSetVol		$10
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$17
		dc.b $9B, $40, $99, $3E, $9B, $40, $99, $3E
		dc.b $9B, $40, $99, $3E, $9B, $40, $94, $3C
		wLoopGoEnd

.16_04
		wSetType	$02
		wSetMask	$07
		wSetFreq	$E800
		wSetPat		$03
		dc.b $CA
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		wLoopBackInit	$07
		wStopRead
		wLoopBack
		wLoopGo		$00, .16_04_00
		wLoopGo		$00, .16_04_01
		wLoopGo		$00, .16_04_02
		wLoopGo		$00, .16_04_03
		wLoopGo		$00, .16_04_04
		wLoopGo		$00, .16_04_05
		wLoopGo		$00, .16_04_06
		wLoopGo		$00, .16_04_07
		wLoopGo		$00, .16_04_08
		wLoopGo		$00, .16_04_09
		wLoopGo		$00, .16_04_0A
		wLoopGo		$00, .16_04_0B
		wLoopGo		$00, .16_04_0C
		wLoopGo		$00, .16_04_0D
		wLoopGo		$00, .16_04_0E
		wLoopGo		$00, .16_04_0F
		wLoopGoEnd

.16_05_06
.16_05_04
.16_05_00
.16_05_0A
.16_05_02
.16_05_12
.16_05_0C
.16_05_10
.16_05_0E
.16_05_08
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $60, $0F
		wStopRead
		dc.b $0F
		wStopRead
		dc.b $65, $0F
		wStopRead
		dc.b $C4, $60, $10, $60, $0F, $C2, $0F
		wStopRead
		dc.b $65, $0F
		wStopRead
		dc.b $0F
		wStopRead
		wLoopGoEnd

.16_05_07
.16_05_0D
.16_05_11
.16_05_0B
.16_05_01
.16_05_09
.16_05_03
.16_05_13
.16_05_05
.16_05_0F
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $60, $0F
		wStopRead
		dc.b $6C, $0F
		wStopRead
		dc.b $65, $0F, $0F, $60, $10
		wStopRead
		dc.b $60, $0F
		wStopRead
		dc.b $05, $05, $0D, $0C, $11
		wStopRead
		wLoopGoEnd

.16_05_14
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $60
		wAddVol		$0A
		dc.b $0F, $0F, $0F, $0F
		wAddVol		$F6
		dc.b $6D
		wAddVol		$0A
		dc.b $0F, $0F, $0F
		wAddVol		$F6
		dc.b $60
		wAddVol		$0A
		dc.b $0F
		wAddVol		$F6
		dc.b $60
		wAddVol		$0A
		dc.b $0F, $0F, $0F, $0F
		wAddVol		$EC
		dc.b $65
		wAddVol		$14
		dc.b $0F, $0F
		wAddVol		$F6
		dc.b $6C
		wAddVol		$0A
		dc.b $0F, $0F, $0F, $0F
		wAddVol		$F6
		dc.b $6C
		wAddVol		$0A
		dc.b $0F, $0F
		wAddVol		$F6
		dc.b $6C
		wAddVol		$0A
		dc.b $0F, $0F, $0F, $0F
		wAddVol		$F6
		dc.b $60, $6C
		wAddVol		$0A
		dc.b $0F
		wAddVol		$F6
		dc.b $6C
		wAddVol		$0A
		dc.b $0F
		wAddVol		$F6
		dc.b $6C
		wAddVol		$0A
		dc.b $0F, $0F
		wAddVol		$EC
		dc.b $65
		wAddVol		$14
		dc.b $0F, $0F, $0F, $0F
		wLoopGoEnd

.16_05_15
		wSetVol		$00
		dc.b $C2
		wAddVol		$12
		dc.b $60
		wAddVol		$0A
		dc.b $0F, $0F, $0F, $0F
		wAddVol		$F6
		dc.b $6D
		wAddVol		$0A
		dc.b $0F, $0F, $0F
		wAddVol		$F6
		dc.b $60
		wAddVol		$0A
		dc.b $0F
		wAddVol		$F6
		dc.b $60
		wAddVol		$0A
		dc.b $0F, $0F, $0F, $0F
		wAddVol		$EC
		dc.b $65
		wAddVol		$14
		dc.b $0F, $0F
		wAddVol		$F6
		dc.b $6C
		wAddVol		$0A
		dc.b $0F, $0F, $0F, $0F
		wAddVol		$F6
		dc.b $6C
		wAddVol		$0A
		dc.b $0F, $0F
		wAddVol		$F6
		dc.b $6C
		wAddVol		$0A
		dc.b $0F, $0F, $0F, $0F
		wAddVol		$F6
		dc.b $60, $6C
		wAddVol		$0A
		dc.b $0F
		wAddVol		$F6
		dc.b $6C
		wAddVol		$0A
		dc.b $0F
		wAddVol		$F6
		dc.b $6C
		wAddVol		$0A
		dc.b $0F
		wAddVol		$F6
		dc.b $6C, $6D
		wAddVol		$0A
		dc.b $0F
		wAddVol		$0A
		dc.b $65
		wAddVol		$F6
		dc.b $0F, $65, $0F
		wAddVol		$F6
		dc.b $65
		wAddVol		$0A
		dc.b $0F
		wAddVol		$EC
		dc.b $65
		wAddVol		$14
		dc.b $0F
		wLoopGoEnd

.16_05
		wDrumChannel
		wLoopGo		$02, .16_05_00
		wLoopGo		$00, .16_05_01
		wLoopGo		$02, .16_05_02
		wLoopGo		$00, .16_05_03
		wLoopGo		$06, .16_05_04
		wLoopGo		$00, .16_05_05
		wLoopGo		$06, .16_05_06
		wLoopGo		$00, .16_05_07
		wLoopGo		$02, .16_05_08
		wLoopGo		$00, .16_05_09
		wLoopGo		$02, .16_05_0A
		wLoopGo		$00, .16_05_0B
		wLoopGo		$02, .16_05_0C
		wLoopGo		$00, .16_05_0D
		wLoopGo		$02, .16_05_0E
		wLoopGo		$00, .16_05_0F
		wLoopGo		$06, .16_05_10
		wLoopGo		$00, .16_05_11
		wLoopGo		$06, .16_05_12
		wLoopGo		$00, .16_05_13
		wLoopGo		$02, .16_05_14
		wLoopGo		$00, .16_05_15
		wLoopGoEnd

.16
		wHeaderMus	$88, $01C0
		dw	.16_00
		dw	.16_01
		dw	.16_02
		dw	.16_03
		dw	.16_04
		dw	.16_05
		dw	$0000

.54_00_00
		wSetVol		$00
		dc.b $C6
		wStopRead
		wLoopGoEnd

.54_00_01
		wSetVol		$00
		dc.b $C7
		wTempoDiv	$10
		wAddVol		$17
		dc.b $35, $C8, $34, $32, $30, $C4
		wStopRead
		wLoopGoEnd

.54_00
		wSetMask	$01
		wSetPat		$23
		wLoopGo		$00, .54_00_00
		wLoopGo		$00, .54_00_01
		wLoopGoEnd

.54_01_00
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$0E
		wAddVol		$17
		dc.b $45, $47
		wLoopGoEnd

.54_01_01
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$0E
		wAddVol		$17
		dc.b $48, $45, $47, $C6, $43, $45, $41, $43
		dc.b $40, $C7
		wStopRead
		wLoopGoEnd

.54_01
		wSetMask	$06
		wSetPat		$23
		wLoopGo		$00, .54_01_00
		wLoopGo		$00, .54_01_01
		wLoopGoEnd

.54_02_01
		wSetVol		$00
		dc.b $C4
		wTempoDiv	$10
		wAddVol		$21
		dc.b $99, $40, $35, $99, $40, $C6, $97, $3E
		dc.b $C4, $34, $97, $3E, $C6, $95, $3C, $C4
		dc.b $32, $95, $3C, $C8
		wAddVol		$F6
		dc.b $94, $3B, $C4
		wStopRead
		wLoopGoEnd

.54_02_00
		wSetVol		$00
		dc.b $C6
		wStopRead
		wLoopGoEnd

.54_02
		wSetMask	$38
		wSetPat		$23
		wLoopGo		$00, .54_02_00
		wLoopGo		$00, .54_02_01
		wLoopGoEnd

.54_03
		wSetType	$02
		dc.b $C4
		wStopRead
		wTempo		$A0
		dc.b $01
		wStopRead
		wStopRead
		wTempo		$90
		dc.b $01
		wStopRead
		wStopRead
		wTempo		$80
		dc.b $01
		wStopRead
		wStopRead
		wTempo		$70
		dc.b $01
		wStopRead
		wStopRead
		wTempo		$68
		dc.b $01
		wStopRead
		wStopRead
		wTempo		$5C
		dc.b $01
		wStopRead
		wStopRead
		wTempo		$48
		dc.b $01
		wStopRead
		wStopRead
		wTempo		$40
		dc.b $01
		wStopRead
		wStopRead
		wTempo		$60
		dc.b $01
		wStopRead
		wStopRead
		wLoopGoEnd

.54
		wHeaderMus	$88, $0178
		dw	.54_00
		dw	.54_01
		dw	.54_02
		dw	.54_03
		dw	$0000
