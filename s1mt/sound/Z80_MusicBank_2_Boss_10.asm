
; ---------------------------------------------------------------
; Created by Techosoft-2-SMPS v.2.70
; 2014, Vladikcomper
; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10:

; ---------------------------------------------------------------
; Music Header
; ---------------------------------------------------------------

	dc.w	Z80_MusicBank_2_Boss_10_Voices-Z80_MusicBank_2_Boss_10			; Voice bank offset
	dc.w	$8700			; Number of Z80_MusicBank_2_Boss_10_FM/PSG channels
	dc.w	$0100			; Tempo modifier

	dc.w	$0008, $F200		; Disable DAC channel
	dc.w	Z80_MusicBank_2_Boss_10_FM1-Z80_MusicBank_2_Boss_10, $0052
	dc.w	Z80_MusicBank_2_Boss_10_FM4-Z80_MusicBank_2_Boss_10, $004E
	dc.w	Z80_MusicBank_2_Boss_10_FM5-Z80_MusicBank_2_Boss_10, $004C	; 1
	dc.w	Z80_MusicBank_2_Boss_10_FM6-Z80_MusicBank_2_Boss_10, $004C	; 2
	dc.w	Z80_MusicBank_2_Boss_10_FM2-Z80_MusicBank_2_Boss_10, $0053	; 3
	dc.w	Z80_MusicBank_2_Boss_10_FM3-Z80_MusicBank_2_Boss_10, $004E

; ---------------------------------------------------------------
; Music Tracks
; ---------------------------------------------------------------

Z80_MusicBank_2_Boss_10_FM1:
	dc.b	$FA, $03		; setup portamento mode 3 (advanced SMPS only!)
	dc.b	$FB, $2D		; set portamento speed (SMPS/TS)
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_16
.Loop:
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_00
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_00
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_00
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_1B
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_00
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_00
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_1B
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_2B
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_15
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_00
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_00
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_00
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_2B
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_15
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_00
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_00
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_00
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_2B
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_24
	smpsJump	.Loop

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_FM2:
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_18
.Loop:
	smpsFMvoice	$01
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_01
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_04
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_02
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_03
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_01
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_04
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_02
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_03
	dc.b	$E9, $FF		; alter note displacement (SMPS/TS)
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_01
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_01
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_01
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_03
	dc.b	$E9, $04		; alter note displacement (SMPS/TS)
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_01
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_04
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_02
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_2A
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsJump	.Loop

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_FM3:
	smpsFMvoice	$00
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_17
.Loop:
	smpsFMvoice	$00
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_0D
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_0E
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_0F
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_10
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_0D
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_0E
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_0F
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_10
	dc.b	$E9, $FF		; alter note displacement (SMPS/TS)
	smpsFMvoice	$02
	dc.b	$E6, $05		; alter note volume (SMPS/TS)
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_20
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_26
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_2C
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsJump	.Loop

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_FM4:
	dc.b	$E1, $FC		; set note shift (SMPS/TS)
	smpsFMvoice	$05
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_17
Z80_MusicBank_2_Boss_10_FM4_1:
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_0D
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_0E
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_0F
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_10
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_0D
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_0E
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_0F
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_10
	dc.b	$E9, $FF		; alter note displacement (SMPS/TS)
	smpsPan		$40, 0
	dc.b	$E6, $06		; alter note volume (SMPS/TS)
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_1F
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_1F
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_1F
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_10
	dc.b	$E9, $04		; alter note displacement (SMPS/TS)
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_0D
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_0E
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_0F
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_10
	smpsPan		$C0, 0
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsJump	Z80_MusicBank_2_Boss_10_FM4_1

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_FM5:
	smpsFMvoice	$05
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_1A
	smpsPan		$80, 0
.Loop:
	smpsFMvoice	$05
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_11
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_12
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_13
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_14
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_11
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_12
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_13
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_14
	dc.b	$E9, $FF		; alter note displacement (SMPS/TS)
	smpsFMvoice	$02
	dc.b	$E6, $FC		; alter note volume (SMPS/TS)
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_22
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_20
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_26
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_29
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsJump	.Loop

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_FM6:
	dc.b	$E1, $FC		; set note shift (SMPS/TS)
	smpsFMvoice	$00
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_1A
	smpsPan		$40, 0
.Loop:
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_11
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_12
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_13
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_14
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_11
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_12
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_13
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_14
	dc.b	$E9, $FF		; alter note displacement (SMPS/TS)
	dc.b	$E6, $06		; alter note volume (SMPS/TS)
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_11
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_11
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_11
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_14
	dc.b	$E9, $04		; alter note displacement (SMPS/TS)
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_11
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_12
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_13
	smpsCall	Z80_MusicBank_2_Boss_10_Pat_14
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsJump	.Loop

; ---------------------------------------------------------------
; Z80_MusicBank_2_Boss_10_Pats
; ---------------------------------------------------------------

Z80_MusicBank_2_Boss_10_Pat_00:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A8, $04, $80, $0C
	dc.b	$A8, $04, $80
	smpsFMvoice	$06
	dc.b	$B4, $01, $80, $0F
	smpsFMvoice	$08
	dc.b	$A8, $04, $80
	dc.b	$A8, $80
	dc.b	$A8, $80
	dc.b	$A8, $80
	smpsFMvoice	$06
	dc.b	$B4, $01, $80, $0F
	smpsFMvoice	$08
	dc.b	$A8, $04, $80
	smpsLoop	0, 2, .0
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_01:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$9C, $0E, $80, $02
	dc.b	$9C, $06, $80, $02
	dc.b	$9C, $06, $80, $02
	dc.b	$9C, $06, $80, $02
	dc.b	$9C, $06, $80, $02
	smpsLoop	0, 3, .0
	dc.b	$9C, $0E, $80, $02
	dc.b	$9C, $06, $80, $02
	dc.b	$98, $06, $80, $02
	dc.b	$9A, $06, $80, $02
	dc.b	$9C, $06, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_02:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$99, $0E, $80, $02
	dc.b	$99, $06, $80, $02
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AF, $08, $E7
	dc.b	$AB, $E7
	dc.b	$FC, $5F			; set note volume (advanced SMPS only!)
	dc.b	$A5, $06, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$99, $0E, $80, $02
	dc.b	$99, $06, $80, $02
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AD, $08, $E7
	dc.b	$AF, $E7
	dc.b	$FC, $5F			; set note volume (advanced SMPS only!)
	dc.b	$A5, $06, $80, $02
	smpsLoop	0, 2, .0
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_03:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A3, $0E, $80, $02
	dc.b	$9E, $06, $80, $02
	dc.b	$97, $06, $80, $02
	dc.b	$97, $06, $80, $02
	dc.b	$97, $06, $80, $02
	dc.b	$A3, $0E, $80, $02
	dc.b	$A3, $06, $80, $02
	dc.b	$97, $06, $80, $02
	dc.b	$97, $06, $80, $02
	dc.b	$97, $06, $80, $02
	dc.b	$A3, $0E, $80, $02
	dc.b	$9E, $06, $80, $02
	dc.b	$97, $06, $80, $02
	dc.b	$97, $06, $80, $02
	dc.b	$97, $06, $80, $02
	dc.b	$95, $06, $80, $02
	dc.b	$97, $06, $80, $02
	dc.b	$9B, $06, $80, $02
	dc.b	$9C, $06, $80, $02
	dc.b	$9E, $06, $80, $02
	dc.b	$A3, $06, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_04:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$9A, $0E, $80, $02
	dc.b	$9A, $06, $80, $02
	dc.b	$9A, $06, $80, $02
	dc.b	$9A, $06, $80, $02
	dc.b	$9A, $06, $80, $02
	smpsLoop	0, 3, .0
	dc.b	$9A, $0E, $80, $02
	dc.b	$9A, $06, $80, $02
	dc.b	$97, $06, $80, $02
	dc.b	$98, $06, $80, $02
	dc.b	$9A, $06, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_05:
	; This Z80_MusicBank_2_Boss_10_Pat is unused
	; This Z80_MusicBank_2_Boss_10_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_06:
	; This Z80_MusicBank_2_Boss_10_Pat is unused
	; This Z80_MusicBank_2_Boss_10_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_07:
	; This Z80_MusicBank_2_Boss_10_Pat is unused
	; This Z80_MusicBank_2_Boss_10_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_08:
	; This Z80_MusicBank_2_Boss_10_Pat is unused
	; This Z80_MusicBank_2_Boss_10_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_09:
	; This Z80_MusicBank_2_Boss_10_Pat is unused
	smpsFMvoice	$01
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$AF, $60, $E7
	dc.b	$AF, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_0A:
	; This Z80_MusicBank_2_Boss_10_Pat is unused
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$AD, $60, $E7
	dc.b	$AD, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_0B:
	; This Z80_MusicBank_2_Boss_10_Pat is unused
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$AA, $60, $E7
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$92, $5E, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_0C:
	; This Z80_MusicBank_2_Boss_10_Pat is unused
	; This Z80_MusicBank_2_Boss_10_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_0D:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A8, $0E, $80, $02
	dc.b	$A6, $06, $80, $02
	dc.b	$9C, $80, $06
	dc.b	$9C, $02, $80, $06
	dc.b	$9C, $02, $80, $06
	smpsLoop	0, 3, .0
	dc.b	$A8, $0E, $80, $02
	dc.b	$A8, $06, $80, $02
	dc.b	$A4, $06, $80, $02
	dc.b	$A6, $06, $80, $02
	dc.b	$A8, $06, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_0E:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A6, $0E, $80, $02
	dc.b	$A8, $06, $80, $02
	dc.b	$9A, $80, $06
	dc.b	$9A, $02, $80, $06
	dc.b	$9A, $02, $80, $06
	smpsLoop	0, 3, .0
	dc.b	$A6, $0E, $80, $02
	dc.b	$A6, $06, $80, $02
	dc.b	$A3, $06, $80, $02
	dc.b	$A4, $06, $80, $02
	dc.b	$A6, $06, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_0F:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A5, $0E, $80, $02
	dc.b	$AB, $06, $80, $02
	dc.b	$AF, $08, $E7
	dc.b	$AB, $E7
	dc.b	$A5, $06, $80, $02
	dc.b	$A5, $0E, $80, $02
	dc.b	$AD, $06, $80, $02
	dc.b	$AD, $08, $E7
	dc.b	$AF, $E7
	dc.b	$A5, $06, $80, $02
	smpsLoop	0, 2, .0
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_10:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$AA, $0E, $80, $02
	dc.b	$A4, $06, $80, $02
	dc.b	$97, $80, $06
	dc.b	$97, $02, $80, $06
	dc.b	$97, $02, $80, $06
	dc.b	$AF, $0E, $80, $02
	dc.b	$AA, $06, $80, $02
	dc.b	$97, $80, $06
	dc.b	$97, $02, $80, $06
	dc.b	$97, $02, $80, $06
	dc.b	$AA, $0E, $80, $02
	dc.b	$AD, $06, $80, $02
	dc.b	$97, $80, $06
	dc.b	$97, $02, $80, $06
	dc.b	$97, $80, $02
	dc.b	$A1, $04, $80
	dc.b	$A3, $80
	dc.b	$A7, $80
	dc.b	$A8, $80
	dc.b	$AA, $80
	dc.b	$AF, $06, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_11:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A3, $0E, $80, $02
	dc.b	$A1, $06, $80, $02
	dc.b	$9F, $01, $80, $07
	dc.b	$9F, $01, $80, $07
	dc.b	$9F, $01, $80, $07
	smpsLoop	0, 3, .0
	dc.b	$A8, $0E, $80, $02
	dc.b	$A8, $06, $80, $02
	dc.b	$A4, $06, $80, $02
	dc.b	$A6, $06, $80, $02
	dc.b	$A8, $06, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_12:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A1, $0E, $80, $02
	dc.b	$A3, $06, $80, $02
	dc.b	$9E, $01, $80, $07
	dc.b	$9E, $01, $80, $07
	dc.b	$9E, $01, $80, $07
	smpsLoop	0, 3, .0
	dc.b	$A6, $0E, $80, $02
	dc.b	$A6, $06, $80, $02
	dc.b	$A3, $06, $80, $02
	dc.b	$A4, $06, $80, $02
	dc.b	$A6, $06, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_13:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A8, $0E, $80, $02
	dc.b	$A8, $06, $80, $02
	dc.b	$AF, $08, $E7
	dc.b	$AB, $E7
	dc.b	$A8, $06, $80, $02
	dc.b	$A8, $0E, $80, $02
	dc.b	$A8, $06, $80, $02
	dc.b	$AD, $08, $E7
	dc.b	$AF, $E7
	dc.b	$A8, $06, $80, $02
	smpsLoop	0, 2, .0
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_14:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$AF, $0E, $80, $02
	dc.b	$AA, $06, $80, $02
	dc.b	$9B, $01, $80, $07
	dc.b	$9B, $01, $80, $07
	dc.b	$9B, $01, $80, $07
	dc.b	$A7, $0E, $80, $02
	dc.b	$A7, $06, $80, $02
	dc.b	$9B, $01, $80, $07
	dc.b	$9B, $01, $80, $07
	dc.b	$9B, $01, $80, $07
	dc.b	$AF, $0E, $80, $02
	dc.b	$AF, $06, $80, $02
	dc.b	$9B, $01, $80, $07
	dc.b	$9B, $01, $80, $07
	dc.b	$9B, $01, $80, $07
	dc.b	$A1, $80, $01
	dc.b	$A3, $07, $80, $01
	dc.b	$A7, $04, $80
	dc.b	$A8, $07, $80, $01
	dc.b	$AA, $07, $80, $01
	dc.b	$AF, $06, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_15:
	smpsFMvoice	$07
	smpsPan		$80, 0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B0, $01, $80, $0F
	dc.b	$B6, $01, $80, $07
	smpsPan		$40, 0
	dc.b	$AB, $01, $80, $0F
	dc.b	$AF, $01, $80, $07
	smpsPan		$C0, 0
	smpsFMvoice	$06
	dc.b	$B2, $01, $80, $03
	dc.b	$B2, $01, $80, $03
	dc.b	$B4, $01, $80, $07
	dc.b	$B4, $01, $80, $07
	dc.b	$B6, $01, $80, $07
	dc.b	$B6, $01, $80, $07
	dc.b	$B7, $01, $80, $07
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_16:
	dc.b	$FC, $01			; set note volume (advanced SMPS only!)
	dc.b	$B4, $01, $80, $5F
	dc.b	$B4, $01, $80, $2F
	smpsFMvoice	$08
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A8, $04, $80
	dc.b	$A8, $80
	dc.b	$A8, $80
	smpsFMvoice	$06
	dc.b	$B4, $01, $80, $17
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_17:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$9E, $60, $E7
	dc.b	$9E, $2E, $80, $02
	dc.b	$9F, $05, $80, $03
	dc.b	$9F, $05, $80, $03
	dc.b	$9F, $01, $80, $07
	dc.b	$A6, $01, $E7
	dc.b	$FB, $5A		; set portamento speed (SMPS/TS)
	dc.b	$97, $16, $80, $01
	dc.b	$FB, $01		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_18:
	dc.b	$FC, $01			; set note volume (advanced SMPS only!)
	dc.b	$90, $01, $80, $5F
	dc.b	$90, $01, $80, $2F
	smpsFMvoice	$01
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$9F, $06, $80, $02
	dc.b	$9F, $06, $80, $02
	dc.b	$9F, $06, $80, $02
	dc.b	$A6, $01, $E7
	dc.b	$FB, $50		; set portamento speed (SMPS/TS)
	dc.b	$97, $16, $80, $01
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_19:
	; This Z80_MusicBank_2_Boss_10_Pat is unused
	dc.b	$FC, $01			; set note volume (advanced SMPS only!)
	dc.b	$A3, $01, $80, $5F
	dc.b	$A3, $01, $80, $5F
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_1A:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$9C, $60, $E7
	dc.b	$9C, $2E, $80, $02
	dc.b	$9C, $05, $80, $03
	dc.b	$9C, $05, $80, $03
	dc.b	$9C, $01, $80, $07
	dc.b	$AB, $01, $E7
	dc.b	$FB, $50		; set portamento speed (SMPS/TS)
	dc.b	$93, $16, $80, $01
	dc.b	$FB, $01		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_1B:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A8, $04, $80
	dc.b	$A8, $80
	dc.b	$A8, $80
	smpsFMvoice	$06
	dc.b	$B4, $01, $80, $17
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_1C:
	; This Z80_MusicBank_2_Boss_10_Pat is unused
	; This Z80_MusicBank_2_Boss_10_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_1D:
	; This Z80_MusicBank_2_Boss_10_Pat is unused
	; This Z80_MusicBank_2_Boss_10_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_1E:
	; This Z80_MusicBank_2_Boss_10_Pat is unused
	; This Z80_MusicBank_2_Boss_10_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_1F:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$9C, $0E, $80, $02
	dc.b	$9A, $06, $80, $02
	dc.b	$9C, $80, $06
	dc.b	$9C, $02, $80, $06
	dc.b	$9C, $02, $80, $06
	smpsLoop	0, 3, .0
	dc.b	$A8, $0E, $80, $02
	dc.b	$A8, $06, $80, $02
	dc.b	$A4, $06, $80, $02
	dc.b	$A6, $06, $80, $02
	dc.b	$A8, $06, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_20:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$9C, $06, $80, $02
	dc.b	$9F, $06, $80, $02
	dc.b	$A3, $06, $80, $02
	dc.b	$A8, $06, $80, $02
	dc.b	$AA, $06, $80, $02
	dc.b	$A8, $06, $80, $02
	dc.b	$AB, $06, $80, $02
	dc.b	$AD, $06, $80, $02
	dc.b	$AF, $06, $80, $02
	dc.b	$B4, $06, $80, $02
	dc.b	$B7, $06, $80, $02
	dc.b	$BB, $06, $80, $02
	smpsLoop	0, 6, .0
.1:
	dc.b	$A3, $06, $80, $02
	dc.b	$9B, $06, $80, $02
	dc.b	$A3, $06, $80, $02
	dc.b	$AF, $06, $80, $02
	dc.b	$AA, $06, $80, $02
	dc.b	$A7, $06, $80, $02
	dc.b	$AB, $06, $80, $02
	dc.b	$AA, $08, $E7
	dc.b	$AF, $06, $80, $02
	dc.b	$BB, $06, $80, $02
	dc.b	$B7, $06, $80, $02
	dc.b	$BF, $06, $80, $02
	smpsLoop	0, 2, .1
	dc.b	$E9, $04		; alter note displacement (SMPS/TS)
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_21:
	; This Z80_MusicBank_2_Boss_10_Pat is unused
	; This Z80_MusicBank_2_Boss_10_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_22:
	dc.b	$FC, $01			; set note volume (advanced SMPS only!)
	dc.b	$BB, $01, $80, $17
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_23:
	; This Z80_MusicBank_2_Boss_10_Pat is unused
	; This Z80_MusicBank_2_Boss_10_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_24:
	smpsFMvoice	$06
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B2, $01, $80, $03
	dc.b	$B2, $01, $80, $03
	dc.b	$B4, $01, $80, $07
	dc.b	$B4, $01, $80, $07
	dc.b	$B6, $01, $80, $07
	dc.b	$B6, $01, $80, $07
.0:
	dc.b	$B7, $01, $80, $07
	smpsLoop	0, 7, .0
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_25:
	; This Z80_MusicBank_2_Boss_10_Pat is unused
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$AA, $60, $E7
	dc.b	$AA, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_26:
	smpsFMvoice	$04
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $06, $80, $02
	dc.b	$AB, $06, $80, $02
	dc.b	$AF, $06, $80, $02
	dc.b	$BB, $08, $E7
	dc.b	$B6, $06, $80, $02
	dc.b	$B4, $06, $80, $02
	dc.b	$AF, $06, $80, $02
	dc.b	$AB, $06, $80, $02
	dc.b	$A8, $06, $80, $02
	dc.b	$B9, $08, $E7
	dc.b	$B7, $06, $80, $02
	dc.b	$B4, $06, $80, $02
	smpsLoop	0, 6, .0
	dc.b	$9C, $06, $80, $02
	dc.b	$9F, $06, $80, $02
	dc.b	$A3, $06, $80, $02
	dc.b	$A3, $08, $E7
	dc.b	$9E, $06, $80, $02
	dc.b	$A8, $06, $80, $02
	dc.b	$AF, $06, $80, $02
	dc.b	$AB, $06, $80, $02
	dc.b	$A8, $06, $80, $02
	dc.b	$AD, $08, $E7
	dc.b	$B7, $06, $80, $02
	dc.b	$B4, $06, $80, $02
	smpsFMvoice	$03
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_27:
	; This Z80_MusicBank_2_Boss_10_Pat is unused
	; This Z80_MusicBank_2_Boss_10_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_28:
	; This Z80_MusicBank_2_Boss_10_Pat is unused
	; This Z80_MusicBank_2_Boss_10_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_29:
	dc.b	$FC, $55			; set note volume (advanced SMPS only!)
	dc.b	$D3, $01, $E7
	dc.b	$FB, $62		; set portamento speed (SMPS/TS)
	dc.b	$97, $46, $80, $01
	dc.b	$FB, $01		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_2A:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9C, $06, $80, $02
	dc.b	$9F, $06, $80, $02
	dc.b	$A3, $06, $80, $02
	dc.b	$A3, $08, $E7
	dc.b	$9E, $06, $80, $02
	dc.b	$A8, $06, $80, $02
	dc.b	$AF, $06, $80, $02
	dc.b	$AB, $06, $80, $02
	dc.b	$A8, $06, $80, $02
	dc.b	$AD, $08, $E7
	dc.b	$B7, $06, $80, $02
	dc.b	$B4, $06, $80, $02
	smpsFMvoice	$03
	dc.b	$CB, $01, $E7
	dc.b	$FB, $62		; set portamento speed (SMPS/TS)
	dc.b	$8F, $5E, $80, $01
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_2B:
	smpsFMvoice	$06
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B4, $01, $80, $0F
	dc.b	$B4, $01, $80, $07
	smpsFMvoice	$07
	smpsPan		$80, 0
	dc.b	$B4, $01, $80, $07
	dc.b	$B4, $01, $80, $07
	dc.b	$B4, $01, $80, $07
	smpsFMvoice	$06
	smpsPan		$C0, 0
	dc.b	$B4, $01, $80, $0F
	dc.b	$B4, $01, $80, $07
	smpsFMvoice	$08
	dc.b	$A8, $04, $80
	dc.b	$A8, $80
	dc.b	$A8, $80
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_2_Boss_10_Pat_2C:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$D3, $01, $E7
	dc.b	$FB, $62		; set portamento speed (SMPS/TS)
	dc.b	$97, $5E, $80, $01
	dc.b	$FB, $01		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
; Z80_MusicBank_2_Boss_10_Voices
; ---------------------------------------------------------------

Z80_MusicBank_2_Boss_10_Voices:
	; Voice $00 (Z80_MusicBank_2_Boss_10_FM)
	dc.b	$F8, $53, $51, $51, $51, $DF, $DF, $1F, $1F, $07, $0E, $07, $84, $04, $03, $03, $08, $F7, $31, $71, $61, $1B, $11, $10, $00
	; Voice $01 (Z80_MusicBank_2_Boss_10_FM)
	dc.b	$EB, $3F, $5F, $50, $51, $DF, $DF, $1B, $1F, $0D, $0C, $0D, $04, $07, $01, $01, $01, $24, $35, $36, $16, $1E, $20, $0A, $00
	; Voice $02 (Z80_MusicBank_2_Boss_10_FM)
	dc.b	$BB, $58, $25, $71, $51, $1F, $1F, $1F, $9F, $02, $02, $02, $05, $01, $01, $01, $01, $12, $12, $12, $62, $1C, $22, $27, $00
	; Voice $03 (Z80_MusicBank_2_Boss_10_FM)
	dc.b	$FD, $32, $70, $73, $32, $0D, $0F, $15, $12, $19, $08, $02, $07, $02, $00, $00, $00, $03, $03, $01, $03, $0F, $01, $00, $00
	; Voice $04 (Z80_MusicBank_2_Boss_10_FM)
	dc.b	$F5, $51, $31, $11, $61, $1F, $19, $1F, $1F, $04, $01, $01, $81, $00, $00, $00, $00, $34, $23, $23, $22, $12, $00, $03, $03
	; Voice $05 (Z80_MusicBank_2_Boss_10_FM)
	dc.b	$E8, $33, $53, $70, $30, $DF, $DC, $1F, $1F, $14, $05, $01, $81, $00, $01, $00, $1D, $11, $21, $10, $F8, $0E, $1B, $12, $00
	; Voice $06 (Z80_MusicBank_2_Boss_10_FM)
	dc.b	$FE, $0F, $00, $30, $50, $1F, $1F, $1F, $1D, $12, $16, $00, $01, $02, $00, $0F, $0E, $00, $07, $33, $11, $00, $00, $00, $00
	; Voice $07 (Z80_MusicBank_2_Boss_10_FM)
	dc.b	$FE, $31, $5F, $30, $30, $5F, $DF, $1F, $1F, $00, $1F, $00, $00, $00, $00, $00, $00, $00, $05, $00, $00, $00, $00, $00, $00
	; Voice $08 (Z80_MusicBank_2_Boss_10_FM)
	dc.b	$EC, $00, $00, $00, $00, $18, $1A, $1A, $1A, $1A, $00, $17, $00, $1F, $00, $1F, $00, $FF, $06, $FF, $06, $00, $00, $0C, $00
