Final_Theme_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	Final_Theme_Voices
	smpsHeaderChan	$06, $03
	smpsHeaderTempo	$01, $57
	smpsHeaderDAC	Final_Theme_DAC
	smpsHeaderFM	Final_Theme_FM1, $00, $0E
	smpsHeaderFM	Final_Theme_FM2, $00, $0C
	smpsHeaderFM	Final_Theme_FM3, $00, $0E
	smpsHeaderFM	Final_Theme_FM4, $00, $0E
	smpsHeaderFM	Final_Theme_FM5, $00, $12
	smpsHeaderPSG	Final_Theme_PSG1, $E8, $02, $00, $00
	smpsHeaderPSG	Final_Theme_PSG2, $E8, $03, $00, $00
	smpsHeaderPSG	Final_Theme_PSG3, $E8, $02, $00, $00

Final_Theme_FM1:
	smpsModSet	$0D, $01, $02, $06
	dc.b nRst, $30, nRst, $18, nRst, $30, nRst, $18
	dc.b nRst, $30, nRst, $18
	smpsSetvoice	$00
	dc.b nE4, $03, nF4, nG4, nA4, nF4, nG4, nA4
	dc.b nB4, nG4, nA4, nB4, nC5, nA4, nB4, nC5
	dc.b nD5, nB4, nC5, nD5, nE5, nC5, nD5, nE5
	dc.b nF5, nG5, $48, nRst, $30, nRst, $18, nRst
	dc.b $30, nRst, $18, nE4, $03, nF4, nG4, nA4
	dc.b nF4, nG4, nA4, nB4, nG4, nA4, nB4, nC5
	dc.b nA4, nB4, nC5, nD5, nB4, nC5, nD5, nE5
	dc.b nC5, nD5, nE5, nF5, nG5, $3C

Final_Theme_Loop6:
Final_Theme_Jump2:
	smpsSetvoice	$00
	dc.b nE5, $0C, nB4, nG5, nD5, nFs5, nCs5, nF4
	dc.b nF5
	smpsLoop	$00, $08, Final_Theme_Loop6
	dc.b nRst, $30, nRst

Final_Theme_Loop7:
	dc.b nE3, $02, nF3, nG3, nA3, nB3, nC4, nE4
	dc.b $0C, nE3, $02, nF3, nG3, nA3, nB3, nC4
	dc.b nE4, $0C, nRst, nD5, $03, nRst, nD5, nRst
	smpsLoop	$00, $03, Final_Theme_Loop7
	dc.b nE3, $02, nF3, nG3, nA3, nB3, nC4, nE4
	dc.b $0C, nE3, $02, nF3, nG3, nA3, nB3, nC4
	dc.b nE4, $0C, nRst, nRst, nRst, $24
	smpsSetvoice	$03
	dc.b nE4, $12, nB4, nA4, $0C, nD5, $12, nC5
	dc.b nB4, $0C, nC5, $12, nD5, nE5, $0C, nD5
	dc.b $12, nA4, $1E, nE4, $12, nB4, nA4, $0C
	dc.b nD5, $12, nE5, nFs5, $0C, nG5, $12, nA5
	dc.b nB5, $0C, nD6, $12, nA5, $1E, nRst, $30
	dc.b nRst
	smpsJump	Final_Theme_Jump2
	; Unused
	dc.b $F2

Final_Theme_FM2:
	smpsSetvoice	$01
	smpsModSet	$0D, $01, $02, $06

Final_Theme_Loop8:
	smpsPan	 panCentre, $00
	dc.b nE2, $63, nE2, $2D
	smpsLoop	$00, $04, Final_Theme_Loop8
	dc.b nE2, $3C

Final_Theme_Loop9:
Final_Theme_Jump3:
	dc.b nE2, $06, nE2, nB2, nE2, nE2, nD3, nE2
	dc.b nE2, nCs3, nE2, nB2, nE2, nA2, nE2, nE2
	dc.b nA2, nE2, nE2, nA2, nE2, nE2, nB2, nE2
	dc.b nE2, nD3, nE2, nE3, nE2, nD3, nE2, nCs3
	dc.b nE2, nE2, nE2, $03, nE2, nA2, $06, nE2
	dc.b nE2, nB2, nE2, nE2, nD3, nE2, nCs3, nE2
	dc.b nB2, nE2, nA2, nE2, nE2, nE2, nA2, nE2
	dc.b nE2, nB2, nE2, nE2, nD3, nE2, nE2, nCs3
	dc.b nE2, nE2, nB2, nD3
	smpsLoop	$00, $02, Final_Theme_Loop9
	dc.b nE2, $06, nA2, nB2, nE2, nE3, nA2, nB2
	dc.b nE3, nD2, nG2, nA2, nD2, nD3, nG2, nA2
	dc.b nD3

Final_Theme_Loop10:
	dc.b nC2, $06, nC3, nRst, $0C
	smpsLoop	$00, $0A, Final_Theme_Loop10
	dc.b nC2, $06, nC3, nRst, nD3, $42, nE2, $06
	dc.b nE2, nB2, nE2, nD3, nE2, nB2, nD3, nD2
	dc.b nD2, nA2, nD2, nD3, nC3, nB2, nA2, nC3
	dc.b nC3, nG2, nC3, nE3, nG2, nC3, nD3, nD2
	dc.b nD2, nA2, nD2, nD3, nA2, nG2, nD2, nE2
	dc.b nE2, nB2, nE2, nE3, nE2, nB2, nE2, nFs2
	dc.b nFs2, nFs3, nFs2, nCs3, nFs2, nFs3, nFs2, nG2
	dc.b nG2, nG3, nG2, nD3, nG2, nG3, nG2, nA2
	dc.b nA2, nE3, nA2, nA3, nE3, nA2, nA3, nRst
	dc.b $0C, nBb2, $48, nRst, $0C
	smpsJump	Final_Theme_Jump3
	; Unused
	dc.b $F2

Final_Theme_FM3:
	smpsSetvoice	$02
	smpsModSet	$0D, $01, $02, $06
	smpsPan	 panRight, $00

Final_Theme_Loop11:
	dc.b nG4, $48, nBb4, $1B, nA4, $2D
	smpsLoop	$00, $04, Final_Theme_Loop11
	dc.b nG4, $3C

Final_Theme_Loop12:
Final_Theme_Jump4:
	smpsSetvoice	$02
	dc.b nG4, $30, nBb4, $12, nA4, nA4, $0C
	smpsLoop	$00, $08, Final_Theme_Loop12
	dc.b nG4, $30, nFs4, $12, nD4, nFs4, $0C

Final_Theme_Loop13:
	dc.b nRst, $0C, nE4, nRst, nE4, nRst, nFs4, $03
	dc.b nRst, nFs4, nRst
	smpsLoop	$00, $03, Final_Theme_Loop13
	dc.b nRst, $0C, nE4, nRst, nE4, $06, nFs4, $2A
	dc.b nRst, $18
	smpsSetvoice	$04
	dc.b nG4, $30, nFs4, nE4, nFs4, nB4, nD5, nD5
	dc.b nFs5, nRst, $0C, nD5, $48, nRst, $0C
	smpsJump	Final_Theme_Jump4
	; Unused
	dc.b $F2

Final_Theme_FM4:
	smpsSetvoice	$02
	smpsModSet	$0D, $01, $02, $06
	smpsPan	 panLeft, $00

Final_Theme_Loop14:
	dc.b nD4, $48, nFs4, $1B, nF4, $2D
	smpsLoop	$00, $04, Final_Theme_Loop14
	dc.b nD4, $3C

Final_Theme_Loop15:
Final_Theme_Jump5:
	smpsSetvoice	$02
	dc.b nD4, $30, nFs4, $12, nF4, nF4, $0C
	smpsLoop	$00, $08, Final_Theme_Loop15
	dc.b nE4, $30, nD4, $12, nA3, nD4, $0C

Final_Theme_Loop16:
	dc.b nRst, $0C, nC4, nRst, nC4, nRst, nD4, $03
	dc.b nRst, nD4, nRst
	smpsLoop	$00, $03, Final_Theme_Loop16
	dc.b nRst, $0C, nC4, nRst, nC4, $03, nRst, nD4
	dc.b $2A, nRst, $18
	smpsSetvoice	$04
	dc.b nB4, $30, nA4, nG4, nA4, nE5, nFs5, nG5
	dc.b nA5, nRst, $0C, nE5, $48, nRst, $0C
	smpsJump	Final_Theme_Jump5
	; Unused
	dc.b $F2

Final_Theme_FM5:
	dc.b nRst, $09
	smpsModSet	$0D, $01, $02, $06
	dc.b nRst, $30, nRst, $18, nRst, $30, nRst, $18
	dc.b nRst, $30, nRst, $18
	smpsSetvoice	$00
	dc.b nE4, $03, nF4, nG4, nA4, nF4, nG4, nA4
	dc.b nB4, nG4, nA4, nB4, nC5, nA4, nB4, nC5
	dc.b nD5, nB4, nC5, nD5, nE5, nC5, nD5, nE5
	dc.b nF5, nG5, $48, nRst, $30, nRst, $18, nRst
	dc.b $30, nRst, $18, nE4, $03, nF4, nG4, nA4
	dc.b nF4, nG4, nA4, nB4, nG4, nA4, nB4, nC5
	dc.b nA4, nB4, nC5, nD5, nB4, nC5, nD5, nE5
	dc.b nC5, nD5, nE5, nF5, nG5, $3C

Final_Theme_Loop17:
Final_Theme_Jump6:
	smpsSetvoice	$00
	dc.b nE5, $0C, nB4, nG5, nD5, nFs5, nCs5, nF4
	dc.b nF5
	smpsLoop	$00, $08, Final_Theme_Loop17
	dc.b nRst, $30, nRst

Final_Theme_Loop18:
	dc.b nE3, $02, nF3, nG3, nA3, nB3, nC4, nE4
	dc.b $0C, nE3, $02, nF3, nG3, nA3, nB3, nC4
	dc.b nE4, $0C, nRst, nD5, $03, nRst, nD5, nRst
	smpsLoop	$00, $03, Final_Theme_Loop18
	dc.b nE3, $02, nF3, nG3, nA3, nB3, nC4, nE4
	dc.b $0C, nE3, $02, nF3, nG3, nA3, nB3, nC4
	dc.b nE4, $0C, nRst, $0D, nRst, $0C, nRst, $24
	smpsSetvoice	$03
	dc.b nE4, $12, nB4, nA4, $0C, nD5, $12, nC5
	dc.b nB4, $0C, nC5, $12, nD5, nE5, $0C, nD5
	dc.b $12, nA4, $1E, nE4, $12, nB4, nA4, $0C
	dc.b nD5, $12, nE5, nFs5, $0C, nG5, $12, nA5
	dc.b nB5, $0C, nD6, $12, nA5, $1E, nRst, $30
	dc.b nRst
	smpsJump	Final_Theme_Jump6
	; Unused
	dc.b $F2

Final_Theme_DAC:
Final_Theme_Loop1:
	dc.b nRst, $30, nRst, $18
	smpsLoop	$00, $04, Final_Theme_Loop1

Final_Theme_Loop2:
	dc.b dKickS3, $24, dSnareS3, $1B, dKickS3, $09
	smpsLoop	$00, $03, Final_Theme_Loop2
	dc.b dKickS3, $1B, dKickS3, $09, dSnareS3, dKickS3, dSnareS3, dSnareS3
	dc.b nRst, $24, dSnareS3, $03, dSnareS3, dSnareS3, dSnareS3, dKickS3
	dc.b $06, dSnareS3

Final_Theme_Loop3:
Final_Theme_Jump1:
	dc.b dKickS3, $0C, dSnareS3, dKickS3, $06, dKickS3, dSnareS3, $0C
	dc.b dKickS3, dSnareS3, $06, dKickS3, $0C, dKickS3, $06, dSnareS3
	dc.b $0C
	smpsLoop	$00, $08, Final_Theme_Loop3
	dc.b dKickS3, $0C, dSnareS3, $06, dKickS3, dKickS3, dSnareS3, dKickS3
	dc.b dSnareS3, dKickS3, dKickS3, dSnareS3, dKickS3, dKickS3, dSnareS3, dSnareS3
	dc.b dSnareS3, $03, dSnareS3

Final_Theme_Loop4:
	dc.b dKickS3, $06, dKickS3, dSnareS3, $0C, dKickS3, $06, dKickS3
	dc.b dSnareS3, $0C, dKickS3, $06, dKickS3, dSnareS3, dSnareS3
	smpsLoop	$00, $03, Final_Theme_Loop4
	dc.b dKickS3, $06, dKickS3, dSnareS3, $0C, dKickS3, $06, dKickS3
	dc.b dSnareS3, $0C, dKickS3, $06, dKickS3, dKickS3, dSnareS3, nRst
	dc.b $0C, nRst, $06, dKickS3, dSnareS3, $0C

Final_Theme_Loop5:
	dc.b dKickS3, $0C, dSnareS3, dKickS3, $06, dKickS3, dSnareS3, $0C
	dc.b dKickS3, dSnareS3, $06, dKickS3, $0C, dKickS3, $06, dSnareS3
	dc.b $0C
	smpsLoop	$00, $04, Final_Theme_Loop5
	dc.b dKickS3, $06, dKickS3, dSnareS3, $24, nRst, dSnareS3, $0C
	smpsJump	Final_Theme_Jump1
	; Unused
	dc.b $F2

Final_Theme_PSG1:
	smpsModSet	$0D, $01, $02, $06

Final_Theme_Loop19:
	dc.b nB3, $48, nCs4, $1B, nC4, $2D
	smpsLoop	$00, $04, Final_Theme_Loop19
	dc.b nB3, $3C

Final_Theme_Loop20:
Final_Theme_Jump7:
	dc.b nB3, $30, nCs4, $12, nC4, nC4, $0C
	smpsLoop	$00, $08, Final_Theme_Loop20
	dc.b nC4, $30

Final_Theme_Loop21:
	dc.b nRst, $30
	smpsLoop	$00, $07, Final_Theme_Loop21
	dc.b nRst, $24, nRst, $0C, nE5, $03, nRst, $09
	dc.b nD5, $03, nRst, nE5, nRst, $09, nD5, $03
	dc.b nRst, nRst, $06, nA4, $03, nRst, $27, nRst
	dc.b $0C, nE5, $03, nRst, $09, nD5, $03, nRst
	dc.b nE5, nRst, $09, nFs5, $03, nRst, nRst, $06
	dc.b nA4, $03, nRst, $27

Final_Theme_Loop22:
	dc.b nRst, $30
	smpsLoop	$00, $06, Final_Theme_Loop22
	smpsJump	Final_Theme_Jump7
	; Unused
	dc.b $F2

Final_Theme_PSG2:
	smpsModSet	$0D, $01, $02, $06

Final_Theme_Loop23:
	dc.b nRst, $30, nRst, $18
	smpsLoop	$00, $08, Final_Theme_Loop23
	dc.b nRst, $3C

Final_Theme_Loop24:
Final_Theme_Jump8:
	dc.b nRst, $30
	smpsLoop	$00, $08, Final_Theme_Loop24

Final_Theme_Loop25:
	dc.b nE4, $06, nB4, nE5, nG4, nG5, nFs5, nD5
	dc.b nB4, nRst, $30
	smpsLoop	$00, $02, Final_Theme_Loop25

Final_Theme_Loop26:
	dc.b nE4, $06, nB4, nE5, nG4, nG5, nFs5, nD5
	dc.b nB4, nE4, nCs5, nFs5, nCs5, nE4, nC5, nF5
	dc.b nC5
	smpsLoop	$00, $02, Final_Theme_Loop26
	dc.b nE4, $06, nB4, nE5, nG4, nG5, nFs5, nD5
	dc.b nB4, nD4, nA4, nD5, nFs4, nFs5, nE5, nD5
	dc.b nA4

Final_Theme_Loop27:
	dc.b nC4, $06, nG4, nE5, nD5, nG5, nFs5, nD5
	dc.b nG4, nC4, nG4, nE5, nD5
	smpsLoop	$00, $03, Final_Theme_Loop27
	dc.b nC4, $06, nG4, nE5, nD5, nG5, nFs5, nD5
	dc.b nA5, nG5, nFs5, nD5, nA4, nG4, nFs4, nD4
	dc.b nRst, $12, nRst, $0C, nG5, $06, nRst, nFs5
	dc.b nG5, nRst, nFs5, nRst, nD5, nRst, nE4, nE5
	dc.b nD5, nB4, nD5, nRst, $0C, nG5, $06, nRst
	dc.b nFs5, nG5, nRst, nA5, nRst, nD5, nRst, nE4
	dc.b nD5, nB4, nA4, nG4, nB4, $03, nRst, nD5
	dc.b nRst, nG5, nRst, nD5, nRst, $09, nB4, $03
	dc.b nRst, $09, nD5, $03, nRst, nA4, nRst, nD5
	dc.b nRst, nFs5, nRst, nD5, nRst, $09, nA4, $03
	dc.b nRst, $09, nD5, $03, nRst, nG5, nRst, nD5
	dc.b nRst, nC5, nRst, nG5, nRst, $09, nA5, $03
	dc.b nRst, $09, nG5, $03, nRst, nA4, nRst, nD5
	dc.b nRst, nFs5, nRst, nG5, nRst, nFs5, nRst, nE5
	dc.b nRst, nD5, nRst, nA4, nRst, nRst, $30, nRst
	smpsJump	Final_Theme_Jump8
	; Unused
	dc.b $F2, $F2

Final_Theme_PSG3:
	smpsStop

Final_Theme_Voices:
	dc.b $2A, $44, $42, $74, $41, $0F, $14, $53, $14, $04, $06, $06, $03, $00, $0F, $00, $00, $1F, $3F, $5F, $1F, $16, $10, $26, $86
	dc.b $2D, $71, $00, $42, $22, $18, $1F, $18, $1A, $03, $0D, $01, $01, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $10, $84, $87, $87
	dc.b $35, $71, $24, $10, $71, $1E, $1F, $1F, $1F, $08, $05, $08, $09, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $10, $8A, $85, $86
	dc.b $2C, $43, $01, $21, $71, $0E, $11, $12, $17, $00, $00, $00, $00, $08, $00, $09, $00, $89, $F8, $F9, $F8, $17, $8C, $0C, $87
	dc.b $3D, $31, $50, $21, $41, $0D, $13, $13, $14, $03, $01, $06, $05, $05, $01, $05, $01, $FF, $FF, $FF, $FF, $1D, $87, $85, $84
