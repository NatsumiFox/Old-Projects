
; ---------------------------------------------------------------
; Created by Techosoft-2-SMPS v.2.70
; 2014, Vladikcomper
; ---------------------------------------------------------------
TF_st5:
; ---------------------------------------------------------------
; Music Header
; ---------------------------------------------------------------

	dc.w	TF_st5_Voices-TF_st5			; Voice bank offset
	dc.w	$8700			; Number of TF_st5_FM/PSG channels
	dc.w	$0100			; Tempo modifier

	dc.w	$0008, $F200		; Disable DAC channel
	dc.w	TF_st5_FM1-TF_st5, $0050
	dc.w	TF_st5_FM2-TF_st5, $0051
	dc.w	TF_st5_FM3-TF_st5, $004F
	dc.w	TF_st5_FM4-TF_st5, $0050
	dc.w	TF_st5_FM5-TF_st5, $004C
	dc.w	TF_st5_FM6-TF_st5, $0048

; ---------------------------------------------------------------
; Music Tracks
; ---------------------------------------------------------------

TF_st5_FM1:
	dc.b	$E1, $01		; set note shift (SMPS/TS)
	dc.b	$E9, $F4		; alter note displacement (SMPS/TS)
	dc.b	$E6, $FE		; alter note volume (SMPS/TS)
	smpsCall	TF_st5_Pat_04
	smpsCall	TF_st5_Pat_05
	dc.b	$FB, $54		; set portamento speed (SMPS/TS)
.Loop:
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsCall	TF_st5_Pat_0E
	smpsCall	TF_st5_Pat_13
	smpsCall	TF_st5_Pat_0E
	smpsCall	TF_st5_Pat_25
	smpsCall	TF_st5_Pat_1E
	smpsCall	TF_st5_Pat_21
	smpsCall	TF_st5_Pat_1E
	smpsCall	TF_st5_Pat_24
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$E9, $F4		; alter note displacement (SMPS/TS)
	dc.b	$E6, $FC		; alter note volume (SMPS/TS)
	smpsFMvoice	$02
	smpsCall	TF_st5_Pat_23
	smpsCall	TF_st5_Pat_31
	smpsCall	TF_st5_Pat_23
	smpsCall	TF_st5_Pat_2D
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsCall	TF_st5_Pat_39
	smpsCall	TF_st5_Pat_33
	smpsCall	TF_st5_Pat_32
	smpsCall	TF_st5_Pat_35
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$E9, $0C		; alter note displacement (SMPS/TS)
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	smpsCall	TF_st5_Pat_3A
	smpsCall	TF_st5_Pat_3B
	smpsCall	TF_st5_Pat_3A
	smpsCall	TF_st5_Pat_3B
	dc.b	$E9, $F4		; alter note displacement (SMPS/TS)
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsCall	TF_st5_Pat_4C
	smpsCall	TF_st5_Pat_51
	smpsCall	TF_st5_Pat_4C
	smpsCall	TF_st5_Pat_55
	smpsJump	.Loop

; ---------------------------------------------------------------
TF_st5_FM2:
	dc.b	$FA, $03		; setup portamento mode 3 (advanced SMPS only!)
	dc.b	$FB, $0A		; set portamento speed (SMPS/TS)
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	smpsCall	TF_st5_Pat_0B
	smpsCall	TF_st5_Pat_0C
.Loop:
	smpsCall	TF_st5_Pat_10
	smpsCall	TF_st5_Pat_17
	smpsCall	TF_st5_Pat_10
	smpsCall	TF_st5_Pat_19
	smpsCall	TF_st5_Pat_1F
	smpsCall	TF_st5_Pat_1F
	smpsCall	TF_st5_Pat_1F
	smpsCall	TF_st5_Pat_2C
	smpsCall	TF_st5_Pat_1F
	smpsCall	TF_st5_Pat_37
	smpsCall	TF_st5_Pat_1F
	smpsCall	TF_st5_Pat_2C
	smpsCall	TF_st5_Pat_1F
	smpsCall	TF_st5_Pat_1F
	smpsCall	TF_st5_Pat_1F
	smpsCall	TF_st5_Pat_46
	smpsCall	TF_st5_Pat_41
	smpsCall	TF_st5_Pat_3E
	smpsCall	TF_st5_Pat_41
	smpsCall	TF_st5_Pat_3E
	smpsCall	TF_st5_Pat_52
	smpsCall	TF_st5_Pat_52
	smpsCall	TF_st5_Pat_52
	smpsCall	TF_st5_Pat_56
	smpsJump	.Loop

; ---------------------------------------------------------------
TF_st5_FM3:
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsCall	TF_st5_Pat_0A
	smpsCall	TF_st5_Pat_09
TF_st5_FM3_1:
	smpsPan		$40, 0
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsCall	TF_st5_Pat_15
	smpsCall	TF_st5_Pat_16
	smpsCall	TF_st5_Pat_15
	smpsCall	TF_st5_Pat_2E
	dc.b	$E9, $F4		; alter note displacement (SMPS/TS)
	smpsCall	TF_st5_Pat_1B
	smpsCall	TF_st5_Pat_1D
	smpsCall	TF_st5_Pat_1B
	smpsCall	TF_st5_Pat_1D
	smpsCall	TF_st5_Pat_1B
	smpsCall	TF_st5_Pat_1D
	smpsCall	TF_st5_Pat_1B
	smpsCall	TF_st5_Pat_1D
	smpsCall	TF_st5_Pat_1B
	smpsCall	TF_st5_Pat_1D
	smpsCall	TF_st5_Pat_1B
	smpsCall	TF_st5_Pat_4B
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsFMvoice	$08
	smpsCall	TF_st5_Pat_29
	smpsCall	TF_st5_Pat_2B
	smpsCall	TF_st5_Pat_29
	smpsCall	TF_st5_Pat_2B
	smpsCall	TF_st5_Pat_1B
	smpsCall	TF_st5_Pat_1D
	smpsCall	TF_st5_Pat_1B
	smpsCall	TF_st5_Pat_44
	smpsJump	TF_st5_FM3_1

; ---------------------------------------------------------------
TF_st5_FM4:
	dc.b	$E6, $01		; alter note volume (SMPS/TS)
	smpsCall	TF_st5_Pat_02
	smpsCall	TF_st5_Pat_03
TF_st5_FM4_1:
	smpsPan		$C0, 0
	smpsCall	TF_st5_Pat_02
	smpsCall	TF_st5_Pat_03
	smpsCall	TF_st5_Pat_02
	smpsCall	TF_st5_Pat_03
	smpsCall	TF_st5_Pat_02
	smpsCall	TF_st5_Pat_03
	smpsCall	TF_st5_Pat_02
	smpsCall	TF_st5_Pat_03
	smpsCall	TF_st5_Pat_02
	smpsCall	TF_st5_Pat_03
	smpsCall	TF_st5_Pat_02
	smpsCall	TF_st5_Pat_03
	smpsCall	TF_st5_Pat_02
	smpsCall	TF_st5_Pat_03
	smpsCall	TF_st5_Pat_02
	smpsCall	TF_st5_Pat_49
	smpsCall	TF_st5_Pat_27
	smpsCall	TF_st5_Pat_3C
	smpsCall	TF_st5_Pat_27
	smpsCall	TF_st5_Pat_4F
	smpsCall	TF_st5_Pat_02
	smpsCall	TF_st5_Pat_03
	smpsCall	TF_st5_Pat_02
	smpsCall	TF_st5_Pat_03
	smpsJump	TF_st5_FM4_1

; ---------------------------------------------------------------
TF_st5_FM5:
	dc.b	$E1, $04		; set note shift (SMPS/TS)
	dc.b	$E9, $F4		; alter note displacement (SMPS/TS)
	dc.b	$E6, $FA		; alter note volume (SMPS/TS)
	smpsCall	TF_st5_Pat_06
	smpsCall	TF_st5_Pat_07
	dc.b	$FB, $54		; set portamento speed (SMPS/TS)
.Loop:
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsCall	TF_st5_Pat_12
	smpsCall	TF_st5_Pat_14
	smpsCall	TF_st5_Pat_12
	smpsCall	TF_st5_Pat_14
	dc.b	$E9, $F4		; alter note displacement (SMPS/TS)
	smpsCall	TF_st5_Pat_1A
	smpsCall	TF_st5_Pat_1C
	smpsCall	TF_st5_Pat_1A
	smpsCall	TF_st5_Pat_1C
	smpsCall	TF_st5_Pat_1A
	smpsCall	TF_st5_Pat_1C
	smpsCall	TF_st5_Pat_1A
	smpsCall	TF_st5_Pat_1C
	smpsCall	TF_st5_Pat_1A
	smpsCall	TF_st5_Pat_1C
	smpsCall	TF_st5_Pat_1A
	smpsCall	TF_st5_Pat_4A
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsFMvoice	$08
	smpsCall	TF_st5_Pat_28
	smpsCall	TF_st5_Pat_2A
	smpsCall	TF_st5_Pat_28
	smpsCall	TF_st5_Pat_2A
	smpsCall	TF_st5_Pat_1A
	smpsCall	TF_st5_Pat_1C
	smpsCall	TF_st5_Pat_1A
	smpsCall	TF_st5_Pat_42
	smpsJump	.Loop

; ---------------------------------------------------------------
TF_st5_FM6:
	dc.b	$E1, $08		; set note shift (SMPS/TS)
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	smpsPan		$80, 0
	smpsCall	TF_st5_Pat_08
	smpsCall	TF_st5_Pat_0D
.Loop:
	smpsCall	TF_st5_Pat_0F
	smpsCall	TF_st5_Pat_18
	smpsCall	TF_st5_Pat_0F
	smpsCall	TF_st5_Pat_18
	smpsCall	TF_st5_Pat_20
	smpsCall	TF_st5_Pat_20
	smpsCall	TF_st5_Pat_20
	smpsCall	TF_st5_Pat_20
	smpsCall	TF_st5_Pat_30
	smpsCall	TF_st5_Pat_38
	smpsCall	TF_st5_Pat_30
	smpsCall	TF_st5_Pat_30
	smpsCall	TF_st5_Pat_20
	smpsCall	TF_st5_Pat_20
	smpsCall	TF_st5_Pat_20
	smpsCall	TF_st5_Pat_3F
	smpsCall	TF_st5_Pat_3D
	smpsCall	TF_st5_Pat_3D
	smpsCall	TF_st5_Pat_3D
	smpsCall	TF_st5_Pat_3D
	smpsCall	TF_st5_Pat_20
	smpsCall	TF_st5_Pat_20
	smpsCall	TF_st5_Pat_20
	smpsCall	TF_st5_Pat_20
	smpsJump	.Loop

; ---------------------------------------------------------------
; TF_st5_Pats
; ---------------------------------------------------------------

TF_st5_Pat_00:
	; This TF_st5_Pat is unused
	; This TF_st5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_01:
	; This TF_st5_Pat is unused
	; This TF_st5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_02:
	smpsFMvoice	$06
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A1, $10, $80, $02
	dc.b	$A1, $0A, $80, $02
	dc.b	$A1, $04, $80, $02
	dc.b	$A3, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A3, $0A, $80, $02
	dc.b	$A1, $0A, $80, $02
	dc.b	$9F, $04, $80, $02
	dc.b	$A1, $10, $80, $02
	smpsLoop	0, 2, .0
.1:
	dc.b	$9F, $10, $80, $02
	dc.b	$9F, $0A, $80, $02
	dc.b	$9F, $04, $80, $02
	dc.b	$A1, $04, $80, $02
	dc.b	$A3, $04, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$A3, $0A, $80, $02
	dc.b	$A1, $04, $80, $02
	dc.b	$9F, $10, $80, $02
	smpsLoop	0, 2, .1
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_03:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9D, $10, $80, $02
	dc.b	$9D, $0A, $80, $02
	dc.b	$9D, $04, $80, $02
	dc.b	$9F, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A3, $0A, $80, $02
	dc.b	$A1, $0A, $80, $02
	dc.b	$9F, $04, $80, $02
	dc.b	$9D, $10, $80, $02
	smpsLoop	0, 2, .0
.1:
	dc.b	$9C, $10, $80, $02
	dc.b	$9C, $0A, $80, $02
	dc.b	$9C, $04, $80, $02
	dc.b	$9D, $04, $80, $02
	dc.b	$A1, $04, $80, $02
	smpsLoop	0, 2, .1
	dc.b	$9C, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$9C, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$9C, $04, $80, $02
	dc.b	$9D, $04, $80, $02
	dc.b	$A1, $04, $80, $02
	dc.b	$9C, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$A1, $04, $80, $02
	dc.b	$9F, $04, $80, $02
	dc.b	$9D, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_04:
	smpsFMvoice	$08
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AD, $60, $E7
	dc.b	$AD, $2E, $80, $02
	dc.b	$B4, $2E, $80, $02
	dc.b	$AF, $5E, $80, $02
	dc.b	$B0, $22, $80, $02
	dc.b	$AF, $22, $80, $02
	dc.b	$AB, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_05:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A9, $60, $E7
	dc.b	$A9, $2E, $80, $02
	dc.b	$AD, $16, $80, $02
	dc.b	$B0, $16, $80, $02
	dc.b	$B4, $5E, $80, $02
	dc.b	$B2, $22, $80, $02
	dc.b	$B0, $22, $80, $02
	dc.b	$AF, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_06:
	smpsFMvoice	$08
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$80, $0C
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AD, $60, $E7
	dc.b	$AD, $2E, $80, $02
	dc.b	$B4, $2E, $80, $02
	dc.b	$AF, $5E, $80, $02
	dc.b	$B0, $22, $80, $02
	dc.b	$AF, $22, $80, $02
	dc.b	$AB, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_07:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A9, $60, $E7
	dc.b	$A9, $2E, $80, $02
	dc.b	$AD, $16, $80, $02
	dc.b	$B0, $16, $80, $02
	dc.b	$B4, $5E, $80, $02
	dc.b	$B2, $22, $80, $02
	dc.b	$B0, $22, $80, $02
	dc.b	$AF, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_08:
.0:
	dc.b	$FC, $00			; set note volume (advanced SMPS only!)
	dc.b	$80, $60
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_09:
	dc.b	$FC, $00			; set note volume (advanced SMPS only!)
	dc.b	$A9, $5E, $80, $02
	dc.b	$A9, $5E, $80, $02
	dc.b	$A9, $5E, $80, $02
	smpsFMvoice	$00
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9A, $01, $E7
	dc.b	$FB, $60		; set portamento speed (SMPS/TS)
	dc.b	$CA, $5E, $80, $01
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_0A:
	smpsPan		$80, 0
	smpsFMvoice	$05
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BE, $5E, $80, $02
	smpsLoop	0, 4, .0
	smpsPan		$C0, 0
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_0B:
	smpsFMvoice	$0B
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $2F
	smpsLoop	0, 8, .0
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_0C:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $2F
	smpsLoop	0, 6, .0
.1:
	dc.b	$B5, $01, $80, $05
	dc.b	$B4, $01, $80, $05
	dc.b	$B0, $01, $80, $05
	smpsLoop	0, 4, .1
	dc.b	$B9, $01, $80, $02
	dc.b	$B9, $01, $80, $02
	dc.b	$B7, $01, $80, $05
	dc.b	$B5, $01, $80, $05
	dc.b	$B4, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_0D:
	smpsFMvoice	$05
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BE, $5E, $80, $02
	smpsLoop	0, 2, .0
	dc.b	$BE, $2E, $80, $02
	dc.b	$BE, $2E, $80, $02
.1:
	dc.b	$BE, $04, $80, $02
	dc.b	$BE, $0A, $80, $02
	smpsLoop	0, 4, .1
	smpsFMvoice	$04
.2:
	dc.b	$B2, $04, $80, $02
	smpsLoop	0, 4, .2
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_0E:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AD, $60, $E7
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$AD, $2E, $80, $02
	dc.b	$B4, $2E, $80, $02
	dc.b	$AF, $5E, $80, $02
	dc.b	$B0, $22, $80, $02
	dc.b	$AF, $22, $80, $02
	dc.b	$AB, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_0F:
.0:
	smpsFMvoice	$03
	smpsPan		$80, 0
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $04, $80, $02
	smpsLoop	1, 8, .1
	smpsPan		$40, 0
	smpsFMvoice	$04
	dc.b	$B2, $10, $80, $02
	dc.b	$B2, $10, $80, $02
	dc.b	$B2, $0A, $80, $02
	smpsFMvoice	$03
TF_st5_Pat_0F_2:
	smpsPan		$40, 0
	smpsFMvoice	$03
	dc.b	$A6, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	smpsPan		$80, 0
	smpsFMvoice	$04
	dc.b	$B2, $0A, $80, $02
	smpsLoop	1, 2, TF_st5_Pat_0F_2
	smpsFMvoice	$03
	smpsPan		$80, 0
.3:
	dc.b	$A6, $04, $80, $02
	smpsLoop	1, 4, .3
	smpsPan		$80, 0
	smpsFMvoice	$03
	dc.b	$A6, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	smpsPan		$40, 0
	smpsFMvoice	$04
	dc.b	$B2, $0A, $80, $02
	smpsLoop	0, 2, TF_st5_Pat_0F
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_10:
.0:
	smpsFMvoice	$0B
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $0B
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $17
	smpsFMvoice	$0B
.1:
	dc.b	$A8, $01, $80, $05
	smpsLoop	1, 4, .1
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_11:
	; This TF_st5_Pat is unused
	; This TF_st5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_12:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A9, $60, $E7
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$A9, $2E, $80, $02
	dc.b	$B0, $2E, $80, $02
	dc.b	$AB, $5E, $80, $02
	dc.b	$AD, $22, $80, $02
	dc.b	$AB, $22, $80, $02
	dc.b	$A8, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_13:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A9, $60, $E7
	dc.b	$A9, $2E, $80, $02
	dc.b	$AD, $16, $80, $02
	dc.b	$B0, $16, $80, $02
	dc.b	$B4, $5E, $80, $02
	dc.b	$B2, $22, $80, $02
	dc.b	$B0, $22, $80, $02
	dc.b	$AF, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_14:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $60, $E7
	dc.b	$A6, $2E, $80, $02
	dc.b	$A9, $16, $80, $02
	dc.b	$AD, $16, $80, $02
	dc.b	$B0, $5E, $80, $02
	dc.b	$AF, $22, $80, $02
	dc.b	$AD, $22, $80, $02
	dc.b	$AB, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_15:
	smpsFMvoice	$09
.0:
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A1, $01, $80, $05
	dc.b	$AD, $04, $80, $02
	dc.b	$B9, $04, $80, $02
	smpsLoop	1, 4, .1
	dc.b	$AD, $0A, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	smpsLoop	0, 2, .0
.2:
.3:
	dc.b	$9F, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	smpsLoop	1, 4, .3
	dc.b	$AB, $0A, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	smpsLoop	0, 2, .2
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_16:
.0:
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9D, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$B5, $04, $80, $02
	smpsLoop	1, 4, .1
	dc.b	$A9, $0A, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	smpsLoop	0, 2, .0
.2:
.3:
	dc.b	$9C, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	smpsLoop	1, 4, .3
	dc.b	$A8, $0A, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	smpsLoop	0, 2, .2
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_17:
.0:
	smpsFMvoice	$0B
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $0B
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $17
	smpsFMvoice	$0B
.1:
	dc.b	$A8, $01, $80, $05
	smpsLoop	1, 4, .1
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 3, .0
	smpsFMvoice	$0B
.2:
	dc.b	$B9, $01, $80, $05
	dc.b	$B7, $01, $80, $05
	dc.b	$B5, $01, $80, $05
	smpsLoop	0, 4, .2
	dc.b	$B9, $01, $80, $02
	dc.b	$B9, $01, $80, $02
	dc.b	$B7, $01, $80, $05
	dc.b	$B5, $01, $80, $05
	dc.b	$B4, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_18:
	smpsFMvoice	$03
	smpsPan		$80, 0
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $04, $80, $02
	smpsLoop	0, 8, .0
	smpsPan		$40, 0
	smpsFMvoice	$04
	dc.b	$B2, $10, $80, $02
	dc.b	$B2, $10, $80, $02
	dc.b	$B2, $0A, $80, $02
	smpsFMvoice	$03
TF_st5_Pat_18_1:
	smpsFMvoice	$03
	smpsPan		$80, 0
	dc.b	$A6, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	smpsPan		$40, 0
	smpsFMvoice	$04
	dc.b	$B2, $0A, $80, $02
	smpsLoop	0, 2, TF_st5_Pat_18_1
	smpsPan		$80, 0
	smpsFMvoice	$03
.2:
	dc.b	$A6, $04, $80, $02
	smpsLoop	0, 4, .2
	smpsFMvoice	$03
	dc.b	$A6, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	smpsPan		$40, 0
	smpsFMvoice	$04
	dc.b	$B2, $0A, $80, $02
	smpsFMvoice	$03
	smpsPan		$80, 0
.3:
	dc.b	$A6, $04, $80, $02
	smpsLoop	0, 8, .3
	smpsPan		$40, 0
	smpsFMvoice	$04
	dc.b	$B2, $10, $80, $02
	dc.b	$B2, $10, $80, $02
	dc.b	$B2, $0A, $80, $02
	smpsFMvoice	$03
TF_st5_Pat_18_4:
	smpsPan		$80, 0
	smpsFMvoice	$03
	dc.b	$A6, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	smpsPan		$40, 0
	smpsFMvoice	$04
	dc.b	$B2, $0A, $80, $02
	smpsLoop	0, 2, TF_st5_Pat_18_4
	smpsFMvoice	$04
	dc.b	$B2, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_19:
.0:
	smpsFMvoice	$0B
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $0B
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $17
	smpsFMvoice	$0B
.1:
	dc.b	$A8, $01, $80, $05
	smpsLoop	1, 4, .1
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 3, .0
.2:
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $05
	smpsLoop	0, 8, .2
	smpsFMvoice	$0B
	dc.b	$BE, $01, $80, $02
	dc.b	$BE, $01, $80, $02
	dc.b	$BB, $01, $80, $02
	dc.b	$BB, $01, $80, $02
	dc.b	$B9, $01, $80, $05
	dc.b	$B9, $01, $80, $05
	dc.b	$B5, $01, $80, $05
	dc.b	$B5, $01, $80, $05
	dc.b	$B2, $01, $80, $05
	dc.b	$B2, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_1A:
	smpsFMvoice	$07
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B5, $01, $80, $02
	dc.b	$B7, $01, $80, $02
	dc.b	$B9, $06, $E7
	dc.b	$B9, $54, $E7
	dc.b	$B9, $5E, $80, $02
	dc.b	$B4, $01, $80, $02
	dc.b	$B5, $01, $80, $02
	dc.b	$B7, $06, $E7
	dc.b	$B7, $54, $E7
	dc.b	$B7, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_1B:
	smpsFMvoice	$07
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $01, $80, $02
	dc.b	$B4, $01, $80, $02
	dc.b	$B5, $06, $E7
	dc.b	$B5, $54, $E7
	dc.b	$B5, $5E, $80, $02
	dc.b	$B0, $01, $80, $02
	dc.b	$B2, $01, $80, $02
	dc.b	$B4, $06, $E7
	dc.b	$B4, $54, $E7
	dc.b	$B4, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_1C:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $01, $80, $02
	dc.b	$B4, $01, $80, $02
	dc.b	$B5, $06, $E7
	dc.b	$B5, $54, $E7
	dc.b	$B5, $5E, $80, $02
	dc.b	$B0, $01, $80, $02
	dc.b	$B2, $01, $80, $02
	dc.b	$B4, $06, $E7
	dc.b	$B4, $54, $E7
	dc.b	$B4, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_1D:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AF, $01, $80, $02
	dc.b	$B0, $01, $80, $02
	dc.b	$B2, $06, $E7
	dc.b	$B2, $54, $E7
	dc.b	$B2, $5E, $80, $02
	dc.b	$AD, $01, $80, $02
	dc.b	$AF, $01, $80, $02
	dc.b	$B0, $06, $E7
	dc.b	$B0, $54, $E7
	dc.b	$B0, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_1E:
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$FC, $00			; set note volume (advanced SMPS only!)
	dc.b	$AD, $01, $80, $17
	dc.b	$FB, $54		; set portamento speed (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $46, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$BC, $22, $80, $02
	dc.b	$C0, $0C, $E7
	dc.b	$C0, $2E, $80, $02
	dc.b	$BE, $2E, $80, $02
	dc.b	$BC, $2E, $80, $02
	dc.b	$BB, $22, $80, $02
	dc.b	$B7, $0C, $E7
	dc.b	$B7, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_1F:
.0:
	smpsFMvoice	$0B
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $0B
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $17
	smpsFMvoice	$0B
.1:
	dc.b	$A8, $01, $80, $05
	smpsLoop	1, 4, .1
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_20:
.0:
	smpsFMvoice	$03
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $04, $80, $02
	dc.b	$A6, $0A, $80, $02
	dc.b	$A6, $04, $80, $02
	smpsLoop	1, 7, .1
	smpsFMvoice	$04
	dc.b	$B2, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$B2, $01, $80, $0B
	smpsLoop	0, 2, .0
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_21:
	dc.b	$FC, $00			; set note volume (advanced SMPS only!)
	dc.b	$A9, $01, $80, $17
	dc.b	$FB, $54		; set portamento speed (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B5, $46, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$B7, $22, $80, $02
	dc.b	$B9, $22, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$BC, $0A, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$BC, $0A, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B9, $22, $80, $02
	dc.b	$BE, $16, $80, $02
	dc.b	$BC, $16, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B7, $10, $80, $02
	dc.b	$FB, $62		; set portamento speed (SMPS/TS)
	dc.b	$93, $10, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_22:
	; This TF_st5_Pat is unused
	; This TF_st5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_23:
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
.0:
.1:
	dc.b	$FC, $5E			; set note volume (advanced SMPS only!)
	dc.b	$B9, $01, $80, $05
	dc.b	$B9, $01, $80, $0B
	smpsLoop	1, 4, .1
.2:
	dc.b	$B9, $01, $80, $05
	smpsLoop	1, 4, .2
	smpsLoop	0, 2, .0
.3:
.4:
	dc.b	$B7, $01, $80, $05
	dc.b	$B7, $01, $80, $0B
	smpsLoop	1, 4, .4
.5:
	dc.b	$B7, $04, $80, $02
	smpsLoop	1, 4, .5
	smpsLoop	0, 2, .3
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_24:
	dc.b	$FC, $00			; set note volume (advanced SMPS only!)
	dc.b	$A9, $01, $80, $17
	dc.b	$FB, $54		; set portamento speed (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B5, $46, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$B7, $22, $80, $02
	dc.b	$B9, $22, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$BC, $5E, $80, $02
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$BE, $2E, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$CF, $01, $E7
	dc.b	$FB, $5E		; set portamento speed (SMPS/TS)
	dc.b	$93, $2E, $80, $01
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_25:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A9, $60, $E7
	dc.b	$A9, $2E, $80, $02
	dc.b	$AD, $16, $80, $02
	dc.b	$B0, $16, $80, $02
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	smpsFMvoice	$01
;	dc.b	$F1			; unsupported coordination flag
	dc.b	$90, $01, $E7
	dc.b	$FB, $3C		; set portamento speed (SMPS/TS)
	dc.b	$C0, $5E, $80, $01
	dc.b	$BE, $22, $80, $02
	dc.b	$BC, $22, $80, $02
	dc.b	$BB, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_26:
	; This TF_st5_Pat is unused
	; This TF_st5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_27:
.0:
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A1, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$A1, $04, $80, $02
	smpsLoop	1, 4, .1
	dc.b	$A1, $04, $80, $02
	dc.b	$A1, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$A1, $04, $80, $02
	smpsLoop	0, 2, .0
.2:
.3:
	dc.b	$9F, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$9F, $04, $80, $02
	smpsLoop	1, 4, .3
	dc.b	$9F, $04, $80, $02
	dc.b	$9F, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$9F, $04, $80, $02
	smpsLoop	0, 2, .2
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_28:
.0:
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $01, $80, $05
	dc.b	$B9, $0A, $80, $02
	smpsLoop	1, 4, .1
	dc.b	$B9, $04, $80, $02
	dc.b	$B9, $04, $80, $02
	dc.b	$B9, $0A, $80, $02
	smpsLoop	0, 2, .0
.2:
.3:
	dc.b	$B7, $04, $80, $02
	dc.b	$B7, $0A, $80, $02
	smpsLoop	1, 4, .3
	dc.b	$B7, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$B7, $0A, $80, $02
	smpsLoop	0, 2, .2
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_29:
.0:
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B5, $01, $80, $05
	dc.b	$B5, $01, $80, $0B
	smpsLoop	1, 4, .1
	dc.b	$B5, $0A, $80, $02
	dc.b	$B5, $0A, $80, $02
	smpsLoop	0, 2, .0
.2:
.3:
	dc.b	$B4, $01, $80, $05
	dc.b	$B4, $01, $80, $0B
	smpsLoop	1, 4, .3
	dc.b	$B4, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	smpsLoop	0, 2, .2
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_2A:
.0:
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B5, $04, $80, $02
	dc.b	$B5, $0A, $80, $02
	smpsLoop	1, 4, .1
	dc.b	$B5, $04, $80, $02
	dc.b	$B5, $04, $80, $02
	dc.b	$B5, $0A, $80, $02
	smpsLoop	0, 2, .0
.2:
.3:
	dc.b	$B4, $04, $80, $02
	dc.b	$B4, $0A, $80, $02
	smpsLoop	1, 4, .3
	dc.b	$B4, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$B4, $0A, $80, $02
	smpsLoop	0, 2, .2
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_2B:
.0:
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $01, $80, $05
	dc.b	$B2, $01, $80, $0B
	smpsLoop	1, 4, .1
	dc.b	$B2, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	smpsLoop	0, 2, .0
.2:
.3:
	dc.b	$B0, $01, $80, $05
	dc.b	$B0, $01, $80, $0B
	smpsLoop	1, 4, .3
	dc.b	$B0, $0A, $80, $02
	dc.b	$B0, $0A, $80, $02
	smpsLoop	0, 2, .2
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_2C:
.0:
	smpsFMvoice	$0B
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $0B
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $17
	smpsFMvoice	$0B
.1:
	dc.b	$A8, $01, $80, $05
	smpsLoop	1, 4, .1
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 3, .0
	smpsFMvoice	$0B
	dc.b	$A8, $01, $80, $0B
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	smpsFMvoice	$0A
	dc.b	$B4, $01, $80, $17
.2:
	dc.b	$B9, $01, $80, $05
	smpsLoop	0, 8, .2
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_2D:
.0:
.1:
	dc.b	$FC, $5E			; set note volume (advanced SMPS only!)
	dc.b	$B5, $01, $80, $05
	dc.b	$B5, $01, $80, $0B
	smpsLoop	1, 4, .1
.2:
	dc.b	$B5, $01, $80, $05
	smpsLoop	1, 4, .2
	smpsLoop	0, 2, .0
.3:
	dc.b	$B7, $01, $80, $05
	dc.b	$B7, $01, $80, $0B
	smpsLoop	0, 4, .3
.4:
	dc.b	$B7, $01, $80, $05
	smpsLoop	0, 4, .4
.5:
	dc.b	$B7, $01, $80, $05
	dc.b	$B7, $01, $80, $0B
	smpsLoop	0, 4, .5
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B5, $0A, $80, $02
	dc.b	$B7, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_2E:
.0:
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9D, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$B5, $04, $80, $02
	smpsLoop	1, 4, .1
	dc.b	$A9, $0A, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	smpsLoop	0, 2, .0
.2:
	dc.b	$9C, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	smpsLoop	0, 4, .2
	dc.b	$A8, $0A, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	smpsFMvoice	$00
	dc.b	$95, $01, $E7
	dc.b	$FB, $5F		; set portamento speed (SMPS/TS)
	dc.b	$D1, $5E, $80, $01
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_2F:
	; This TF_st5_Pat is unused
	; This TF_st5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_30:
.0:
	smpsFMvoice	$04
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	smpsLoop	0, 16, .0
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_31:
.0:
.1:
	dc.b	$FC, $5E			; set note volume (advanced SMPS only!)
	dc.b	$B5, $01, $80, $05
	dc.b	$B5, $01, $80, $0B
	smpsLoop	1, 4, .1
.2:
	dc.b	$B5, $01, $80, $05
	smpsLoop	1, 4, .2
	smpsLoop	0, 2, .0
.3:
.4:
	dc.b	$B4, $01, $80, $05
	dc.b	$B4, $01, $80, $0B
	smpsLoop	1, 4, .4
.5:
	dc.b	$B4, $04, $80, $02
	smpsLoop	1, 4, .5
	smpsLoop	0, 2, .3
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_32:
	dc.b	$FC, $01			; set note volume (advanced SMPS only!)
	dc.b	$AD, $16, $80, $02
	dc.b	$FB, $5A		; set portamento speed (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $46, $80, $02
	dc.b	$BB, $2E, $80, $02
	dc.b	$B7, $2E, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$BE, $16, $80, $02
	dc.b	$BC, $0C, $E7
	dc.b	$BC, $2E, $80, $02
	dc.b	$BE, $2E, $80, $02
	dc.b	$C0, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_33:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B5, $5E, $80, $02
	dc.b	$B7, $22, $80, $02
	dc.b	$B9, $0C, $E7
	dc.b	$B9, $16, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$B4, $5E, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$BE, $2E, $80, $02
	dc.b	$BC, $16, $80, $02
	dc.b	$BB, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_34:
	; This TF_st5_Pat is unused
	; This TF_st5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_35:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C1, $60, $E7
	dc.b	$C1, $01, $E7
	dc.b	$C1, $2E, $80, $01
	dc.b	$BE, $10, $80, $02
	dc.b	$C0, $10, $80, $02
	dc.b	$C1, $0A, $80, $02
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$C3, $60, $E7
	dc.b	$C7, $5E, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_36:
	; This TF_st5_Pat is unused
	; This TF_st5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_37:
.0:
	smpsFMvoice	$0B
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $0B
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $17
	smpsFMvoice	$0B
.1:
	dc.b	$A8, $01, $80, $05
	smpsLoop	1, 4, .1
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 3, .0
.2:
	smpsFMvoice	$0B
	dc.b	$A8, $01, $80, $05
	smpsFMvoice	$0A
	dc.b	$B4, $01, $80, $0B
	smpsLoop	0, 4, .2
	smpsFMvoice	$0B
	dc.b	$B9, $01, $80, $05
	dc.b	$B7, $01, $80, $05
	dc.b	$B5, $01, $80, $05
	dc.b	$B4, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_38:
.0:
	smpsFMvoice	$04
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	smpsLoop	0, 12, .0
	smpsFMvoice	$04
.1:
	dc.b	$BE, $04, $80, $02
	smpsLoop	0, 8, .1
	dc.b	$B2, $10, $80, $02
	dc.b	$B2, $10, $80, $02
	dc.b	$B2, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_39:
	dc.b	$FC, $01			; set note volume (advanced SMPS only!)
	dc.b	$AD, $16, $80, $02
	dc.b	$FB, $5A		; set portamento speed (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $46, $80, $02
	dc.b	$BB, $2E, $80, $02
	dc.b	$B7, $2E, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$BE, $16, $80, $02
	dc.b	$BC, $0C, $E7
	dc.b	$BC, $2E, $80, $02
	dc.b	$B7, $2E, $80, $02
	dc.b	$B4, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_3A:
	smpsFMvoice	$01
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $10, $80, $02
	dc.b	$FB, $54		; set portamento speed (SMPS/TS)
	dc.b	$BB, $10, $80, $02
	dc.b	$BC, $0A, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B7, $16, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B9, $10, $80, $02
	dc.b	$B7, $10, $80, $02
	dc.b	$B5, $0A, $80, $02
	dc.b	$BE, $10, $80, $02
	dc.b	$BC, $10, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B9, $10, $80, $02
	dc.b	$BB, $10, $80, $02
	dc.b	$BC, $0A, $80, $02
	dc.b	$C0, $10, $80, $02
	dc.b	$BE, $10, $80, $02
	dc.b	$BC, $0A, $80, $02
	dc.b	$BE, $10, $80, $02
	dc.b	$BC, $10, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$BC, $10, $80, $02
	dc.b	$BB, $10, $80, $02
	dc.b	$B7, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_3B:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B5, $10, $80, $02
	dc.b	$B7, $10, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B7, $2E, $80, $02
	dc.b	$B7, $10, $80, $02
	dc.b	$B9, $10, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$BC, $2E, $80, $02
	dc.b	$C0, $10, $80, $02
	dc.b	$C1, $10, $80, $02
	dc.b	$C0, $0A, $80, $02
	dc.b	$BE, $10, $80, $02
	dc.b	$BC, $10, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$BE, $0A, $80, $02
	dc.b	$C0, $16, $80, $02
	dc.b	$BE, $0A, $80, $02
	dc.b	$BC, $10, $80, $02
	dc.b	$BB, $10, $80, $02
	dc.b	$B7, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_3C:
.0:
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9D, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$9D, $04, $80, $02
	smpsLoop	1, 4, .1
	dc.b	$9D, $04, $80, $02
	dc.b	$9D, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$9D, $04, $80, $02
	smpsLoop	0, 2, .0
.2:
.3:
	dc.b	$9C, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	smpsLoop	1, 4, .3
	dc.b	$9C, $04, $80, $02
	dc.b	$9C, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$9C, $04, $80, $02
	smpsLoop	0, 2, .2
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_3D:
.0:
	smpsFMvoice	$05
	smpsPan		$40, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $10, $80, $02
	smpsPan		$80, 0
	dc.b	$B9, $10, $80, $02
	smpsPan		$C0, 0
	dc.b	$B9, $0C, $E7
	smpsFMvoice	$03
	smpsPan		$80, 0
.1:
	dc.b	$B2, $04, $80, $02
	smpsLoop	1, 8, .1
	smpsPan		$40, 0
.2:
	smpsFMvoice	$03
	dc.b	$B2, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	smpsFMvoice	$04
	dc.b	$B2, $0A, $80, $02
	smpsLoop	1, 4, .2
	smpsLoop	0, 2, TF_st5_Pat_3D
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_3E:
.0:
	smpsFMvoice	$0A
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $01, $80, $11
	dc.b	$B9, $01, $80, $11
	dc.b	$B9, $01, $80, $17
	smpsFMvoice	$0B
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 3, .0
	smpsFMvoice	$0B
.1:
	dc.b	$B9, $01, $80, $05
	dc.b	$B7, $01, $80, $05
	dc.b	$B5, $01, $80, $05
	dc.b	$B4, $01, $80, $05
	smpsLoop	0, 2, .1
	smpsFMvoice	$0A
	dc.b	$BE, $01, $80, $11
	dc.b	$BC, $01, $80, $11
	dc.b	$B9, $01, $80, $0B
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_3F:
	smpsFMvoice	$03
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $04, $80, $02
	dc.b	$A6, $0A, $80, $02
	dc.b	$A6, $04, $80, $02
	smpsLoop	0, 7, .0
	smpsFMvoice	$04
	dc.b	$B2, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$B2, $01, $80, $0B
	smpsFMvoice	$03
.1:
	dc.b	$A6, $04, $80, $02
	dc.b	$A6, $0A, $80, $02
	dc.b	$A6, $04, $80, $02
	smpsLoop	0, 6, .1
	smpsFMvoice	$04
.2:
	dc.b	$B2, $04, $80, $02
	smpsLoop	0, 8, .2
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_40:
	; This TF_st5_Pat is unused
	; This TF_st5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_41:
.0:
	smpsFMvoice	$0A
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $01, $80, $11
	dc.b	$B9, $01, $80, $11
	dc.b	$B9, $01, $80, $17
	smpsFMvoice	$0B
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_42:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $01, $80, $02
	dc.b	$B4, $01, $80, $02
	dc.b	$B5, $06, $E7
	dc.b	$B5, $54, $E7
	dc.b	$B5, $5E, $80, $02
	dc.b	$B0, $01, $80, $02
	dc.b	$B2, $01, $80, $02
	dc.b	$B4, $06, $E7
	dc.b	$B4, $52, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsFMvoice	$08
	dc.b	$FC, $61			; set note volume (advanced SMPS only!)
	dc.b	$A8, $2E, $80, $02
	dc.b	$A9, $16, $80, $02
	dc.b	$AB, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_43:
	; This TF_st5_Pat is unused
	; This TF_st5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_44:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AF, $01, $80, $02
	dc.b	$B0, $01, $80, $02
	dc.b	$B2, $06, $E7
	dc.b	$B2, $54, $E7
	dc.b	$B2, $5E, $80, $02
	dc.b	$AD, $01, $80, $02
	dc.b	$AF, $01, $80, $02
	dc.b	$B0, $06, $E7
	dc.b	$B0, $52, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsFMvoice	$08
	dc.b	$FC, $61			; set note volume (advanced SMPS only!)
	dc.b	$A4, $2E, $80, $02
	dc.b	$A6, $16, $80, $02
	dc.b	$A8, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_45:
	; This TF_st5_Pat is unused
	; This TF_st5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_46:
.0:
	smpsFMvoice	$0B
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $0B
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $17
	smpsFMvoice	$0B
.1:
	dc.b	$A8, $01, $80, $05
	smpsLoop	1, 4, .1
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 3, .0
	smpsFMvoice	$0B
.2:
	dc.b	$B9, $01, $80, $05
	smpsLoop	0, 8, .2
	dc.b	$BE, $01, $80, $02
	dc.b	$BE, $01, $80, $02
	dc.b	$BE, $01, $80, $02
	dc.b	$BE, $01, $80, $02
	dc.b	$BC, $01, $80, $05
	dc.b	$BC, $01, $80, $05
	dc.b	$B9, $01, $80, $05
	dc.b	$B9, $01, $80, $05
	dc.b	$B5, $01, $80, $05
	dc.b	$B5, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_47:
	; This TF_st5_Pat is unused
	; This TF_st5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_48:
	; This TF_st5_Pat is unused
	; This TF_st5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_49:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9D, $10, $80, $02
	dc.b	$9D, $0A, $80, $02
	dc.b	$9D, $04, $80, $02
	dc.b	$9F, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A3, $0A, $80, $02
	dc.b	$A1, $0A, $80, $02
	dc.b	$9F, $04, $80, $02
	dc.b	$9D, $10, $80, $02
	smpsLoop	0, 2, .0
.1:
	dc.b	$9C, $10, $80, $02
	dc.b	$9C, $0A, $80, $02
	dc.b	$9C, $04, $80, $02
	dc.b	$9D, $04, $80, $02
	dc.b	$A1, $04, $80, $02
	smpsLoop	0, 2, .1
.2:
	dc.b	$9C, $04, $80, $02
	dc.b	$9C, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	smpsLoop	0, 2, .2
	dc.b	$A6, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$B5, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_4A:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $01, $80, $02
	dc.b	$B4, $01, $80, $02
	dc.b	$B5, $06, $E7
	dc.b	$B5, $54, $E7
	dc.b	$B5, $5E, $80, $02
	dc.b	$B0, $01, $80, $02
	dc.b	$B2, $01, $80, $02
	dc.b	$B4, $06, $E7
	dc.b	$B4, $52, $80, $02
	smpsFMvoice	$01
	dc.b	$95, $01, $E7
	dc.b	$FB, $60		; set portamento speed (SMPS/TS)
	dc.b	$C5, $5E, $80, $01
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_4B:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AF, $01, $80, $02
	dc.b	$B0, $01, $80, $02
	dc.b	$B2, $06, $E7
	dc.b	$B2, $54, $E7
	dc.b	$B2, $5E, $80, $02
	dc.b	$AD, $01, $80, $02
	dc.b	$AF, $01, $80, $02
	dc.b	$B0, $06, $E7
	dc.b	$B0, $52, $80, $02
	smpsFMvoice	$01
	dc.b	$91, $01, $E7
	dc.b	$FB, $60		; set portamento speed (SMPS/TS)
	dc.b	$C1, $5E, $80, $01
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_4C:
	smpsFMvoice	$02
	dc.b	$FC, $01			; set note volume (advanced SMPS only!)
	dc.b	$80, $18
	dc.b	$FB, $54		; set portamento speed (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $46, $80, $02
	dc.b	$BB, $2E, $80, $02
	dc.b	$B7, $2E, $80, $02
	dc.b	$BB, $46, $80, $02
	dc.b	$BE, $0A, $80, $02
	dc.b	$BC, $52, $80, $02
	dc.b	$BE, $0A, $80, $02
	dc.b	$C0, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_4D:
	; This TF_st5_Pat is unused
	; This TF_st5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_4E:
	; This TF_st5_Pat is unused
	; This TF_st5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_4F:
.0:
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9D, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$9D, $04, $80, $02
	smpsLoop	1, 4, .1
	dc.b	$9D, $04, $80, $02
	dc.b	$9D, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$9D, $04, $80, $02
	smpsLoop	0, 2, .0
.2:
	dc.b	$9C, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	smpsLoop	0, 4, .2
	dc.b	$9C, $04, $80, $02
	dc.b	$9C, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$9C, $04, $80, $02
.3:
	dc.b	$9C, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	smpsLoop	0, 4, .3
	dc.b	$A6, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_50:
	; This TF_st5_Pat is unused
	; This TF_st5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_51:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C1, $5E, $80, $02
	dc.b	$C1, $5E, $80, $02
	dc.b	$C0, $60, $E7
	dc.b	$C0, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_52:
.0:
	smpsFMvoice	$0B
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $0B
	dc.b	$A8, $01, $80, $0B
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $17
	smpsFMvoice	$0B
	dc.b	$A8, $01, $80, $0B
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_53:
	; This TF_st5_Pat is unused
	; This TF_st5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_54:
	; This TF_st5_Pat is unused
	; This TF_st5_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_55:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C1, $60, $E7
	dc.b	$C1, $2E, $80, $02
	dc.b	$BE, $10, $80, $02
	dc.b	$C0, $10, $80, $02
	dc.b	$C1, $0A, $80, $02
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$C3, $5E, $80, $02
	dc.b	$C7, $48, $E7
	dc.b	$FC, $5C			; set note volume (advanced SMPS only!)
	dc.b	$C7, $06, $E7
	dc.b	$FC, $58			; set note volume (advanced SMPS only!)
	dc.b	$C7, $E7
	dc.b	$FC, $56			; set note volume (advanced SMPS only!)
	dc.b	$C7, $E7
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$C7, $04, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsFMvoice	$08
	smpsReturn

; ---------------------------------------------------------------
TF_st5_Pat_56:
.0:
	smpsFMvoice	$0B
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $0B
	dc.b	$A8, $01, $80, $0B
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $17
	smpsFMvoice	$0B
	dc.b	$A8, $01, $80, $0B
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	smpsFMvoice	$0A
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 3, .0
.1:
	dc.b	$B9, $01, $80, $05
	dc.b	$B9, $01, $80, $0B
	smpsLoop	0, 4, .1
.2:
	dc.b	$B9, $01, $80, $05
	smpsLoop	0, 4, .2
	smpsReturn

; ---------------------------------------------------------------
; TF_st5_Voices
; ---------------------------------------------------------------

TF_st5_Voices:
	; Voice $00 (TF_st5_FM)
	dc.b	$F8, $52, $36, $21, $04, $18, $1C, $1C, $19, $00, $00, $00, $06, $00, $00, $00, $00, $02, $02, $02, $62, $16, $28, $16, $00
	; Voice $01 (TF_st5_FM)
	dc.b	$F8, $52, $33, $21, $02, $18, $1C, $1C, $19, $00, $00, $00, $02, $00, $04, $04, $00, $24, $04, $04, $12, $1A, $15, $16, $00
	; Voice $02 (TF_st5_FM)
	dc.b	$C0, $54, $54, $34, $32, $9F, $5F, $1F, $5F, $02, $00, $00, $00, $06, $00, $00, $00, $05, $33, $32, $02, $19, $1C, $18, $00
	; Voice $03 (TF_st5_FM)
	dc.b	$FD, $07, $04, $0A, $0C, $1F, $1F, $1F, $1F, $8B, $93, $93, $93, $04, $04, $04, $04, $C6, $F6, $F6, $B6, $00, $00, $00, $00
	; Voice $04 (TF_st5_FM)
	dc.b	$FC, $0A, $0F, $0A, $0E, $1B, $1F, $17, $9F, $0B, $0E, $0A, $0D, $04, $04, $08, $04, $B6, $B6, $B6, $B6, $00, $00, $00, $00
	; Voice $05 (TF_st5_FM)
	dc.b	$FC, $36, $5F, $5B, $58, $17, $1F, $1F, $9B, $00, $0B, $07, $09, $08, $08, $06, $08, $44, $F4, $74, $B4, $00, $00, $00, $00
	; Voice $06 (TF_st5_FM)
	dc.b	$F8, $61, $08, $00, $30, $DF, $DF, $9F, $9F, $07, $0E, $0B, $86, $07, $06, $06, $08, $75, $55, $95, $F5, $14, $2B, $0B, $00
	; Voice $07 (TF_st5_FM)
	dc.b	$BB, $4C, $28, $76, $42, $1F, $1F, $1F, $9F, $03, $03, $03, $03, $01, $01, $01, $01, $32, $32, $32, $32, $21, $20, $23, $00
	; Voice $08 (TF_st5_FM)
	dc.b	$FB, $32, $76, $72, $32, $8D, $4F, $15, $52, $0A, $08, $07, $07, $06, $00, $00, $00, $03, $03, $03, $03, $15, $20, $26, $00
	; Voice $09 (TF_st5_FM)
	dc.b	$C6, $7A, $18, $18, $72, $9F, $5F, $1F, $5F, $0A, $0C, $8B, $8C, $02, $00, $00, $00, $93, $93, $A3, $A4, $1C, $0A, $0A, $0A
	; Voice $0A (TF_st5_FM)
	dc.b	$FE, $00, $00, $00, $00, $1F, $1F, $1F, $1F, $05, $00, $00, $00, $00, $0B, $15, $09, $06, $06, $34, $00, $00, $00, $00, $00
	; Voice $0B (TF_st5_FM)
	dc.b	$FE, $00, $00, $00, $00, $1F, $1F, $1F, $1F, $09, $09, $00, $00, $09, $06, $00, $00, $02, $4A, $02, $02, $00, $00, $00, $00
