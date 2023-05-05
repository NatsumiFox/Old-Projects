
; ---------------------------------------------------------------
; Created by Techosoft-2-SMPS v.2.70
; 2014, Vladikcomper
; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5:

; ---------------------------------------------------------------
; Music Header
; ---------------------------------------------------------------

	dc.w	Z80_MusicBank_2_Boss_5_Voices-Z80_MusicBank_2_Boss_5			; Voice bank offset
	dc.w	$8700			; Number of Z80_MusicBank_2_Boss_5_FM/PSG channels
	dc.w	$0100			; Tempo modifier

	dc.w	$0008, $F200		; Disable DAC channel
	dc.w	Z80_MusicBank_2_Boss_5_FM1-Z80_MusicBank_2_Boss_5, $0050
	dc.w	Z80_MusicBank_2_Boss_5_FM2-Z80_MusicBank_2_Boss_5, $0050
	dc.w	Z80_MusicBank_2_Boss_5_FM3-Z80_MusicBank_2_Boss_5, $004E
	dc.w	Z80_MusicBank_2_Boss_5_FM4-Z80_MusicBank_2_Boss_5, $0050
	dc.w	Z80_MusicBank_2_Boss_5_FM5-Z80_MusicBank_2_Boss_5, $0048
	dc.w	Z80_MusicBank_2_Boss_5_FM6-Z80_MusicBank_2_Boss_5, $0048

; ---------------------------------------------------------------
; Music Tracks
; ---------------------------------------------------------------

Z80_MusicBank_2_Boss_5_FM1:
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_11
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
Z80_MusicBank_2_Boss_5_FM1_1:
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_00
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_00
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsPan		$80, 0
	smpsFMvoice	$02
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_0E
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_0E
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsPan		$C0, 0
	smpsJump	Z80_MusicBank_2_Boss_5_FM1_1

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_FM2:
	dc.b	$FA, $03		; setup portamento mode 3 (advanced SMPS only!)
	dc.b	$FB, $0A		; set portamento speed (SMPS/TS)
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_15
.Loop:
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_05
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_06
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_09
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_10
	smpsJump	.Loop

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_FM3:
	dc.b	$E9, $18		; alter note displacement (SMPS/TS)
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_13
Z80_MusicBank_2_Boss_5_FM3_1:
	smpsPan		$80, 0
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_02
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_02
	smpsPan		$C0, 0
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_0A
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_0C
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	dc.b	$E9, $18		; alter note displacement (SMPS/TS)
	smpsJump	Z80_MusicBank_2_Boss_5_FM3_1

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_FM4:
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_14
.Loop:
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_03
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_03
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_0D
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_0D
	smpsJump	.Loop

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_FM5:
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_12
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
Z80_MusicBank_2_Boss_5_FM5_1:
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_01
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_01
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsPan		$40, 0
	smpsFMvoice	$02
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_0F
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_0F
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsPan		$C0, 0
	smpsJump	Z80_MusicBank_2_Boss_5_FM5_1

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_FM6:
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_13
	smpsPan		$40, 0
.Loop:
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_04
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_04
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_04
	smpsCall	Z80_MusicBank_2_Boss_5_Pat_04
	smpsJump	.Loop

; ---------------------------------------------------------------
; Z80_MusicBank_2_Boss_5_Pats
; ---------------------------------------------------------------

Z80_MusicBank_2_Boss_5_Pat_00:
	smpsFMvoice	$00
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AA, $10, $80, $02
	dc.b	$AC, $10, $80, $02
	dc.b	$AD, $0C, $E7
	dc.b	$AD, $2E, $80, $02
	dc.b	$AA, $10, $80, $02
	dc.b	$AC, $10, $80, $02
	dc.b	$AD, $0C, $E7
	dc.b	$AD, $2E, $80, $02
	dc.b	$AD, $10, $80, $02
	dc.b	$AF, $10, $80, $02
	dc.b	$B1, $0C, $E7
	dc.b	$B1, $2E, $80, $02
	dc.b	$AD, $10, $80, $02
	dc.b	$AF, $10, $80, $02
	dc.b	$B1, $0C, $E7
	dc.b	$B1, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_01:
	smpsFMvoice	$00
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $10, $80, $02
	dc.b	$A8, $10, $80, $02
	dc.b	$AA, $0C, $E7
	dc.b	$AA, $2E, $80, $02
	dc.b	$A6, $10, $80, $02
	dc.b	$A8, $10, $80, $02
	dc.b	$AA, $0C, $E7
	dc.b	$AA, $2E, $80, $02
	dc.b	$AA, $10, $80, $02
	dc.b	$AC, $10, $80, $02
	dc.b	$AD, $0C, $E7
	dc.b	$AD, $2E, $80, $02
	dc.b	$AA, $10, $80, $02
	dc.b	$AC, $10, $80, $02
	dc.b	$AD, $0C, $E7
	dc.b	$AD, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_02:
	smpsFMvoice	$01
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AA, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A5, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A5, $04, $80, $02
	dc.b	$A3, $04, $80, $02
	dc.b	$A5, $04, $80, $02
	dc.b	$A3, $04, $80, $02
	dc.b	$A1, $04, $80, $02
	dc.b	$A3, $04, $80, $02
	dc.b	$A1, $04, $80, $02
	dc.b	$A0, $04, $80, $02
	dc.b	$A1, $04, $80, $02
	smpsLoop	0, 2, .0
.1:
	dc.b	$AD, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A5, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A5, $04, $80, $02
	dc.b	$A3, $04, $80, $02
	dc.b	$A5, $04, $80, $02
	smpsLoop	0, 2, .1
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_03:
	smpsFMvoice	$07
.0:
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9E, $04, $80, $02
	dc.b	$AA, $0A, $80, $02
	smpsLoop	1, 4, .1
.2:
	dc.b	$AA, $04, $80, $02
	smpsLoop	1, 4, .2
	smpsLoop	0, 2, .0
.3:
.4:
	dc.b	$A1, $04, $80, $02
	dc.b	$AD, $0A, $80, $02
	smpsLoop	1, 4, .4
.5:
	dc.b	$AD, $04, $80, $02
	smpsLoop	1, 4, .5
	smpsLoop	0, 2, .3
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_04:
.0:
	smpsFMvoice	$05
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $0A, $80, $02
	smpsFMvoice	$04
	dc.b	$A6, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	smpsLoop	0, 16, .0
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_05:
.0:
	smpsFMvoice	$09
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $05
	smpsLoop	1, 4, .1
	smpsFMvoice	$08
	dc.b	$B2, $01, $80, $0B
	smpsFMvoice	$09
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	smpsLoop	0, 8, .0
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_06:
.0:
	smpsFMvoice	$09
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $05
	smpsLoop	1, 4, .1
	smpsFMvoice	$08
	dc.b	$B2, $01, $80, $0B
	smpsFMvoice	$09
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	smpsLoop	0, 7, .0
	smpsFMvoice	$09
.2:
	dc.b	$A8, $01, $80, $05
	smpsLoop	0, 4, .2
	smpsFMvoice	$08
	dc.b	$B9, $01, $80, $05
	dc.b	$B7, $01, $80, $05
	dc.b	$B5, $01, $80, $05
	dc.b	$B4, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_07:
	; This Z80_MusicBank_2_Boss_5_Pat is unused
	; This Z80_MusicBank_2_Boss_5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_08:
	; This Z80_MusicBank_2_Boss_5_Pat is unused
	; This Z80_MusicBank_2_Boss_5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_09:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B4, $02, $80, $10
	dc.b	$B4, $02, $80, $10
	dc.b	$B4, $01, $80, $0B
	smpsLoop	0, 8, .0
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_0A:
	smpsFMvoice	$03
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $5E, $80, $02
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$B8, $5E, $80, $02
	dc.b	$B9, $5E, $80, $02
	dc.b	$B8, $5E, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_0B:
	; This Z80_MusicBank_2_Boss_5_Pat is unused
	; This Z80_MusicBank_2_Boss_5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_0C:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $5E, $80, $02
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$B8, $5E, $80, $02
	dc.b	$B9, $5E, $80, $02
	dc.b	$BB, $5E, $80, $02
	dc.b	$FB, $54		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_0D:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9E, $04, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$B6, $04, $80, $02
	dc.b	$C2, $04, $80, $02
	smpsLoop	0, 8, .0
.1:
	dc.b	$A1, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$B9, $04, $80, $02
	dc.b	$C5, $04, $80, $02
	smpsLoop	0, 8, .1
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_0E:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AA, $0A, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$E6, $FE		; alter note volume (SMPS/TS)
	smpsLoop	0, 4, .0
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
.1:
	dc.b	$AC, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$E6, $FE		; alter note volume (SMPS/TS)
	smpsLoop	0, 4, .1
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
.2:
	dc.b	$AD, $0A, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$E6, $FE		; alter note volume (SMPS/TS)
	smpsLoop	0, 4, .2
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
.3:
	dc.b	$AC, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$E6, $FE		; alter note volume (SMPS/TS)
	smpsLoop	0, 4, .3
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_0F:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$E6, $FE		; alter note volume (SMPS/TS)
	smpsLoop	0, 4, .0
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
.1:
	dc.b	$A8, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$E6, $FE		; alter note volume (SMPS/TS)
	smpsLoop	0, 4, .1
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
.2:
	dc.b	$AA, $0A, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$E6, $FE		; alter note volume (SMPS/TS)
	smpsLoop	0, 4, .2
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
.3:
	dc.b	$A8, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$E6, $FE		; alter note volume (SMPS/TS)
	smpsLoop	0, 4, .3
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_10:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B4, $02, $80, $10
	dc.b	$B4, $02, $80, $10
	dc.b	$B4, $01, $80, $0B
	smpsLoop	0, 7, .0
.1:
	dc.b	$B4, $01, $80, $05
	smpsLoop	0, 8, .1
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_11:
	smpsFMvoice	$00
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$86, $01, $E7
	dc.b	$FB, $62		; set portamento speed (SMPS/TS)
	dc.b	$C2, $5F, $E7
	dc.b	$C2, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_12:
	smpsFMvoice	$00
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$82, $01, $E7
	dc.b	$FB, $62		; set portamento speed (SMPS/TS)
	dc.b	$BE, $5F, $E7
	dc.b	$BE, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_13:
	dc.b	$FC, $00			; set note volume (advanced SMPS only!)
	dc.b	$80, $60
	dc.b	$80, $60
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_14:
.0:
	smpsFMvoice	$06
	dc.b	$FC, $5E			; set note volume (advanced SMPS only!)
	dc.b	$BE, $10, $80, $02
	smpsFMvoice	$05
	dc.b	$BE, $10, $80, $02
	dc.b	$BE, $0A, $80, $02
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_5_Pat_15:
	smpsFMvoice	$09
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $17
	smpsLoop	0, 7, .0
.1:
	dc.b	$A8, $01, $80, $05
	smpsLoop	0, 4, .1
	smpsReturn

; ---------------------------------------------------------------
; Z80_MusicBank_2_Boss_5_Voices
; ---------------------------------------------------------------

Z80_MusicBank_2_Boss_5_Voices:
	; Voice $00 (Z80_MusicBank_2_Boss_5_FM)
	dc.b	$F8, $52, $33, $21, $02, $18, $1C, $1C, $19, $00, $00, $00, $02, $00, $04, $04, $00, $24, $04, $04, $12, $1A, $15, $16, $00
	; Voice $01 (Z80_MusicBank_2_Boss_5_FM)
	dc.b	$C2, $1C, $76, $43, $21, $18, $14, $1D, $12, $02, $00, $02, $08, $00, $04, $04, $02, $33, $14, $14, $83, $25, $1D, $21, $00
	; Voice $02 (Z80_MusicBank_2_Boss_5_FM)
	dc.b	$F8, $72, $31, $10, $52, $10, $0D, $19, $14, $01, $05, $01, $80, $02, $01, $00, $00, $10, $22, $15, $04, $1A, $14, $13, $00
	; Voice $03 (Z80_MusicBank_2_Boss_5_FM)
	dc.b	$C0, $54, $54, $34, $32, $9F, $5F, $1F, $5F, $02, $00, $00, $00, $06, $00, $00, $00, $05, $33, $32, $02, $19, $1C, $18, $00
	; Voice $04 (Z80_MusicBank_2_Boss_5_FM)
	dc.b	$FD, $07, $04, $0A, $0C, $1F, $1F, $1F, $1F, $8B, $93, $93, $93, $04, $04, $04, $04, $C6, $F6, $F6, $B6, $00, $00, $00, $00
	; Voice $05 (Z80_MusicBank_2_Boss_5_FM)
	dc.b	$FC, $0A, $0F, $0A, $0E, $1B, $1F, $17, $9F, $0B, $0E, $0A, $0D, $04, $04, $08, $04, $B6, $B6, $B6, $B6, $00, $00, $00, $00
	; Voice $06 (Z80_MusicBank_2_Boss_5_FM)
	dc.b	$FC, $36, $5F, $5B, $58, $17, $1F, $1F, $9B, $00, $0B, $07, $09, $08, $08, $06, $08, $44, $F4, $74, $B4, $00, $00, $00, $00
	; Voice $07 (Z80_MusicBank_2_Boss_5_FM)
	dc.b	$F8, $61, $08, $00, $30, $DF, $DF, $9F, $9F, $07, $0E, $0B, $86, $07, $06, $06, $08, $75, $55, $95, $F5, $14, $2B, $0B, $00
	; Voice $08 (Z80_MusicBank_2_Boss_5_FM)
	dc.b	$FE, $00, $00, $00, $00, $1F, $1F, $1F, $1F, $05, $00, $00, $00, $00, $0B, $15, $09, $06, $06, $34, $00, $00, $00, $00, $00
	; Voice $09 (Z80_MusicBank_2_Boss_5_FM)
	dc.b	$FE, $00, $00, $00, $00, $1F, $1F, $1F, $1F, $09, $09, $00, $00, $09, $06, $00, $00, $02, $4A, $02, $02, $00, $00, $00, $00
