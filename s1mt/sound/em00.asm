
; ---------------------------------------------------------------
; Created by Techosoft-2-SMPS v.2.70
; 2014, Vladikcomper
; ------------------------------------------------------------
em00:

; ---------------------------------------------------------------
; Music Header
; ---------------------------------------------------------------

	dc.w	em00_Voices-em00			; Voice bank offset
	dc.w	$8700			; Number of em00_FM/PSG channels
	dc.w	$0100			; Tempo modifier

	dc.w	$0008, $F200		; Disable DAC channel
	dc.w	em00_FM5-em00, $004A
	dc.w	em00_FM6-em00, $004A
	dc.w	em00_FM1-em00, $0055
	dc.w	em00_FM2-em00, $0058
	dc.w	em00_FM3-em00, $004B
	dc.w	em00_FM4-em00, $0054

; ---------------------------------------------------------------
; Music Tracks
; ---------------------------------------------------------------

em00_FM1:
	smpsCall	em00_Pat_09
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_0A
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
.Loop:
	smpsCall	em00_Pat_0C
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_0D
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_0C
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_0E
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_0F
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_10
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_11
	smpsCall	em00_Pat_10
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_12
	smpsCall	em00_Pat_13
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_13
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsJump	.Loop

; ---------------------------------------------------------------
em00_FM2:
	smpsCall	em00_Pat_14
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_15
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_16
;	dc.b	$FB		; Invalid track control byte
.Loop:
	smpsCall	em00_Pat_18
	smpsCall	em00_Pat_18
	smpsCall	em00_Pat_18
	smpsCall	em00_Pat_18
	smpsCall	em00_Pat_18
	smpsCall	em00_Pat_18
	smpsCall	em00_Pat_18
	smpsCall	em00_Pat_19
	smpsCall	em00_Pat_1A
	smpsCall	em00_Pat_1A
	smpsCall	em00_Pat_1A
	smpsCall	em00_Pat_25
	smpsCall	em00_Pat_17
	smpsCall	em00_Pat_17
	smpsCall	em00_Pat_17
	smpsCall	em00_Pat_26
	smpsCall	em00_Pat_17
	smpsCall	em00_Pat_17
	smpsCall	em00_Pat_17
	smpsCall	em00_Pat_27
	smpsCall	em00_Pat_1B
	smpsCall	em00_Pat_1B
	smpsCall	em00_Pat_1B
	smpsCall	em00_Pat_1B
	smpsCall	em00_Pat_1B
	smpsCall	em00_Pat_1B
	smpsCall	em00_Pat_1B
	smpsCall	em00_Pat_28
	smpsJump	.Loop

; ---------------------------------------------------------------
em00_FM3:
	smpsCall	em00_Pat_1E
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_1E
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsFMvoice	$01
.Loop:
	smpsCall	em00_Pat_1F
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_20
	smpsCall	em00_Pat_1F
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_21
	smpsCall	em00_Pat_23
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_24
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_24
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_1D
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_1D
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsJump	.Loop

; ---------------------------------------------------------------
em00_FM4:
.Loop:
	smpsPan		$C0, 0
	smpsCall	em00_Pat_00
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_01
	smpsCall	em00_Pat_01
	smpsCall	em00_Pat_00
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_01
	smpsCall	em00_Pat_02
	smpsCall	em00_Pat_03
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_04
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_03
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_05
;	dc.b	$FB		; Invalid track control byte
	dc.b	$E6, $08		; alter note volume (SMPS/TS)
	smpsCall	em00_Pat_06
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsCall	em00_Pat_07
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_08
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsJump	em00_FM4

; ---------------------------------------------------------------
em00_FM5:
;	dc.b	$E5, $0C		; unsupported coordination flag
	dc.b	$E1, $02		; set note shift (SMPS/TS)
em00_FM5_1:
	smpsPan		$40, 0
	smpsCall	em00_Pat_00
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_01
	smpsCall	em00_Pat_01
	smpsCall	em00_Pat_00
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_01
	smpsCall	em00_Pat_02
	smpsCall	em00_Pat_03
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_04
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_03
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_05
;	dc.b	$FB		; Invalid track control byte
	dc.b	$E6, $08		; alter note volume (SMPS/TS)
	smpsCall	em00_Pat_06
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsCall	em00_Pat_07
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_08
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsJump	em00_FM5_1

; ---------------------------------------------------------------
em00_FM6:
;	dc.b	$E5, $06		; unsupported coordination flag
	dc.b	$E1, $FE		; set note shift (SMPS/TS)
em00_FM6_1:
	smpsPan		$80, 0
	smpsCall	em00_Pat_00
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_01
	smpsCall	em00_Pat_01
	smpsCall	em00_Pat_00
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_01
	smpsCall	em00_Pat_02
	smpsCall	em00_Pat_03
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_04
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_03
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_05
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_06
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_07
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsCall	em00_Pat_08
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
;	dc.b	$FB		; Invalid track control byte
	smpsJump	em00_FM6_1

; ---------------------------------------------------------------
; em00_Pats
; ---------------------------------------------------------------

em00_Pat_00:
	smpsFMvoice	$02
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
	dc.b	$FB, $32		; set portamento speed (SMPS/TS)
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $0A, $80, $02
	dc.b	$C0, $0A, $80, $02
	dc.b	$B9, $04, $80, $02
	dc.b	$C1, $0A, $80, $02
	dc.b	$B9, $04, $80, $02
	dc.b	$C3, $0A, $80, $02
	dc.b	$B9, $04, $80, $02
	dc.b	$C1, $0A, $80, $02
	dc.b	$B9, $04, $80, $02
	dc.b	$C0, $0A, $80, $02
	smpsLoop	0, 2, .0
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_01:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B7, $0A, $80, $02
	dc.b	$BE, $0A, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$C0, $0A, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$C1, $0A, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$C0, $0A, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$BE, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_02:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B7, $0A, $80, $02
	dc.b	$BE, $0A, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$C0, $0A, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$C1, $06, $E7
	dc.b	$C0, $E7
	dc.b	$BE, $04, $80, $02
	dc.b	$C3, $06, $E7
	dc.b	$C1, $E7
	dc.b	$C0, $04, $80, $02
	dc.b	$C7, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_03:
	smpsFMvoice	$03
;	dc.b	$F1			; unsupported coordination flag
;	dc.b	$E4, $18		; unsupported coordination flag
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C5, $3A, $80, $02
	dc.b	$C0, $0B, $80, $01
	dc.b	$C5, $05, $80, $01
	dc.b	$C7, $10, $80, $02
	dc.b	$CC, $10, $80, $02
	dc.b	$CA, $4C, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_04:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$CD, $10, $80, $02
	dc.b	$CC, $08, $80, $0A
	dc.b	$CD, $10, $80, $02
	dc.b	$CC, $08, $80, $0A
	dc.b	$CD, $06, $E7
	dc.b	$CC, $E7
	dc.b	$CA, $E7
	dc.b	$C8, $E7
	dc.b	$FB, $60		; set portamento speed (SMPS/TS)
	dc.b	$C7, $30, $E7
	dc.b	$CC, $2E, $80, $02
	dc.b	$FB, $32		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_05:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$CC, $10, $80, $02
	dc.b	$CA, $08, $80, $0A
	dc.b	$CC, $10, $80, $02
	dc.b	$CA, $08, $80, $0A
	dc.b	$CC, $06, $E7
	dc.b	$CA, $E7
	dc.b	$C8, $E7
	dc.b	$C7, $E7
	dc.b	$C5, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_06:
	smpsFMvoice	$00
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C7, $5E, $80, $02
	dc.b	$C8, $5E, $80, $02
	dc.b	$CA, $40, $80, $02
	dc.b	$CA, $06, $E7
	dc.b	$CF, $0A, $80, $02
	dc.b	$CD, $06, $80
	dc.b	$CD, $10, $80, $02
	dc.b	$CC, $4C, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_07:
	smpsFMvoice	$03
em00_Pat_07_0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$CD, $06, $E7
	dc.b	$CC, $E7
	dc.b	$CA, $E7
	dc.b	$C7, $05, $80, $01
	dc.b	$E6, $FB		; alter note volume (SMPS/TS)
	smpsPan		$80, 0
	smpsLoop	0, 2, em00_Pat_07_0
	smpsPan		$40, 0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$CD, $06, $E7
	dc.b	$CC, $05, $80, $01
	smpsPan		$C0, 0
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C7, $0B, $80, $01
	dc.b	$CA, $0B, $80, $01
	dc.b	$CD, $0B, $80, $01
em00_Pat_07_1:
	dc.b	$CC, $06, $E7
	dc.b	$CA, $E7
	dc.b	$C8, $E7
	dc.b	$C5, $05, $80, $01
	dc.b	$E6, $FB		; alter note volume (SMPS/TS)
	smpsPan		$80, 0
	smpsLoop	0, 2, em00_Pat_07_1
	smpsPan		$40, 0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$CC, $06, $E7
	dc.b	$CA, $05, $80, $01
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsPan		$C0, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C5, $0B, $80, $01
	dc.b	$C8, $0B, $80, $01
	dc.b	$CC, $0B, $80, $01
em00_Pat_07_2:
	dc.b	$CA, $06, $E7
	dc.b	$C8, $E7
	dc.b	$C7, $E7
	dc.b	$C3, $05, $80, $01
	dc.b	$E6, $FB		; alter note volume (SMPS/TS)
	smpsPan		$80, 0
	smpsLoop	0, 2, em00_Pat_07_2
	smpsPan		$40, 0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$CA, $06, $E7
	dc.b	$C8, $05, $80, $01
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsPan		$C0, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C0, $0B, $80, $01
	dc.b	$C3, $0B, $80, $01
	dc.b	$C7, $0B, $80, $01
	dc.b	$C7, $10, $80, $02
	dc.b	$C8, $1C, $80, $02
	dc.b	$C8, $10, $80, $02
	dc.b	$CA, $10, $80, $02
	dc.b	$CC, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_08:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$CD, $06, $E7
	dc.b	$CC, $E7
	dc.b	$CA, $E7
	dc.b	$C7, $05, $80, $01
	dc.b	$E6, $FB		; alter note volume (SMPS/TS)
	smpsPan		$80, 0
	smpsLoop	0, 2, em00_Pat_08
	smpsPan		$40, 0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$CD, $06, $E7
	dc.b	$CC, $E7
	dc.b	$CA, $04, $80, $02
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsPan		$C0, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C1, $06, $E7
	dc.b	$CA, $E7
	dc.b	$CD, $11, $80, $01
em00_Pat_08_1
	dc.b	$CC, $06, $E7
	dc.b	$CA, $E7
	dc.b	$C8, $E7
	dc.b	$C5, $05, $80, $01
	dc.b	$E6, $FB		; alter note volume (SMPS/TS)
	smpsPan		$80, 0
	smpsLoop	0, 2, em00_Pat_08_1
	smpsPan		$40, 0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$CC, $06, $E7
	dc.b	$CA, $05, $80, $01
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsPan		$C0, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C0, $0C, $E7
	dc.b	$C8, $0B, $80, $01
	dc.b	$CC, $0B, $80, $01
em00_Pat_08_2
	dc.b	$CA, $06, $E7
	dc.b	$C8, $E7
	dc.b	$C7, $E7
	dc.b	$C3, $05, $80, $01
	dc.b	$E6, $FB		; alter note volume (SMPS/TS)
	smpsPan		$80, 0
	smpsLoop	0, 2, em00_Pat_08_2
	smpsPan		$40, 0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$CA, $06, $E7
	dc.b	$C8, $05, $80, $01
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsPan		$C0, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C0, $0C, $E7
	dc.b	$C3, $E7
	dc.b	$C7, $0B, $80, $01
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
	dc.b	$FB, $5C		; set portamento speed (SMPS/TS)
	dc.b	$FC, $61			; set note volume (advanced SMPS only!)
	dc.b	$C8, $2F, $80, $01
	dc.b	$FC, $62			; set note volume (advanced SMPS only!)
	dc.b	$C7, $24, $E7
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A3, $0A, $80, $02
	dc.b	$FB, $32		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_09:
	smpsFMvoice	$04
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A1, $0B, $80, $55
	dc.b	$A1, $0B, $80, $49
	dc.b	$A1, $0B, $80, $01
	dc.b	$9F, $0B, $80, $55
	dc.b	$9F, $0B, $80, $49
	dc.b	$9F, $0B, $80, $01
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_0A:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A1, $0C, $80
	smpsLoop	0, 7, .0
	dc.b	$A1, $01, $80, $05
	dc.b	$A1, $10, $80, $02
.1:
	dc.b	$9F, $0C, $80
	smpsLoop	0, 7, .1
	dc.b	$9F, $01, $80, $05
	dc.b	$9F, $10, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_0B:
	; This em00_Pat is unused
	; This em00_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_0C:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A1, $10, $80, $02
	dc.b	$A8, $04, $80, $0E
	dc.b	$AD, $16, $80, $02
	dc.b	$A1, $0A, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$AD, $10, $80, $02
	dc.b	$E9, $FE		; alter note displacement (SMPS/TS)
	smpsLoop	0, 2, .0
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_0D:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9D, $10, $80, $02
	dc.b	$A4, $04, $80, $0E
	dc.b	$A9, $16, $80, $02
	dc.b	$9D, $0A, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A9, $10, $80, $02
	dc.b	$E9, $FF		; alter note displacement (SMPS/TS)
	smpsLoop	0, 2, .0
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_0E:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9D, $10, $80, $02
	dc.b	$A4, $04, $80, $0E
	dc.b	$A9, $0A, $80, $02
	dc.b	$9F, $10, $80, $02
	dc.b	$A6, $04, $80, $0E
	dc.b	$AB, $0A, $80, $02
	dc.b	$A1, $10, $80, $02
	dc.b	$A8, $04, $80, $0E
	dc.b	$AD, $16, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$9F, $04, $80, $02
	dc.b	$A1, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_0F:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9F, $10, $80, $02
	dc.b	$A6, $04, $80, $0E
	dc.b	$AB, $16, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$9F, $0A, $80, $02
	dc.b	$AB, $0A, $80, $02
	dc.b	$E9, $FE		; alter note displacement (SMPS/TS)
	smpsLoop	0, 2, .0
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	dc.b	$9F, $10, $80, $02
	dc.b	$A6, $04, $80, $0E
	dc.b	$AB, $16, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$9D, $04, $80, $02
	dc.b	$9F, $04, $80, $02
	dc.b	$A1, $10, $80, $02
	dc.b	$A8, $04, $80, $0E
	dc.b	$AD, $16, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$A1, $04, $80, $08
	dc.b	$AD, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_10:
.0:
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A3, $0A, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$A3, $0A, $80, $02
	dc.b	$AF, $0A, $80, $02
	smpsLoop	1, 2, .1
	dc.b	$E9, $FE		; alter note displacement (SMPS/TS)
	smpsLoop	0, 3, .0
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_11:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A1, $0A, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$A1, $0A, $80, $02
	dc.b	$AD, $0A, $80, $02
	smpsLoop	0, 2, .0
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_12:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9D, $0A, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$9D, $0A, $80, $02
	dc.b	$A9, $0A, $80, $02
	dc.b	$E9, $02		; alter note displacement (SMPS/TS)
	smpsLoop	0, 2, .0
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_13:
.0:
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A1, $0A, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$A1, $0A, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	smpsLoop	1, 4, .1
	dc.b	$E9, $FE		; alter note displacement (SMPS/TS)
	smpsLoop	0, 2, .0
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_14:
	dc.b	$FA, $03		; setup portamento mode 3 (advanced SMPS only!)
	dc.b	$FB, $1E		; set portamento speed (SMPS/TS)
	smpsFMvoice	$08
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $5E
	dc.b	$95, $02, $80, $52
	smpsFMvoice	$07
	dc.b	$A1, $02, $80, $0A
	smpsFMvoice	$08
	dc.b	$95, $02, $80, $5E
	dc.b	$95, $02, $80, $2E
	dc.b	$95, $02, $80, $0A
	smpsFMvoice	$07
	dc.b	$95, $02, $80
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$95, $80
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$95, $80
	smpsFMvoice	$08
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $80, $04
	smpsFMvoice	$07
	dc.b	$95, $02, $80, $0A
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_15:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $16
	smpsFMvoice	$07
	dc.b	$95, $02, $80, $16
	smpsLoop	0, 3, .0
	smpsFMvoice	$08
	dc.b	$95, $02, $80, $0A
	smpsFMvoice	$07
	dc.b	$95, $02, $80, $0A
	smpsFMvoice	$08
	dc.b	$95, $02, $80, $04
	smpsFMvoice	$07
	dc.b	$95, $02, $80, $0A
	dc.b	$95, $02, $80, $04
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_16:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $0A
	smpsFMvoice	$07
	dc.b	$95, $02, $80, $0A
	smpsLoop	0, 7, .0
	smpsFMvoice	$08
	dc.b	$95, $02, $80, $04
	smpsFMvoice	$07
	dc.b	$95, $02, $80, $10
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_17:
	smpsFMvoice	$08
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	dc.b	$FC, $56			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	smpsFMvoice	$07
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	smpsFMvoice	$08
	dc.b	$FC, $56			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	smpsFMvoice	$07
	dc.b	$95, $02, $80, $0A
	smpsFMvoice	$08
	dc.b	$FC, $56			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	dc.b	$FC, $56			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	smpsFMvoice	$07
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	smpsFMvoice	$08
	dc.b	$FC, $56			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $0A
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	smpsFMvoice	$07
	dc.b	$95, $01, $80, $0B
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_18:
	smpsFMvoice	$08
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $10
	smpsFMvoice	$07
	dc.b	$90, $02, $80, $10
	smpsFMvoice	$08
	dc.b	$95, $02, $80, $16
	dc.b	$95, $02, $80, $0A
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$90, $02, $80, $04
	smpsFMvoice	$07
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $10
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_19:
	smpsFMvoice	$08
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $10
	smpsFMvoice	$07
	dc.b	$90, $02, $80, $10
	smpsFMvoice	$08
	dc.b	$95, $02, $80, $16
	smpsFMvoice	$06
	smpsPan		$40, 0
	dc.b	$AD, $01, $80, $03
	dc.b	$AD, $01, $80, $03
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AD, $01, $80, $03
	smpsPan		$C0, 0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A4, $01, $80, $05
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $01, $80, $05
	smpsPan		$80, 0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$9F, $01, $80, $05
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9F, $01, $80, $05
	smpsPan		$C0, 0
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_1A:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $0A
	smpsFMvoice	$05
	smpsPan		$40, 0
	dc.b	$D4, $0B, $80, $01
	smpsPan		$C0, 0
	smpsLoop	0, 3, em00_Pat_1A
	smpsFMvoice	$08
	dc.b	$95, $02, $80, $0A
	smpsFMvoice	$06
	smpsPan		$80, 0
	dc.b	$A1, $02, $80, $0A
	smpsPan		$C0, 0
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_1B:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $0A
	smpsFMvoice	$07
	dc.b	$95, $02, $80, $0A
	smpsLoop	0, 3, .0
	smpsFMvoice	$08
	dc.b	$95, $02, $80, $04
	smpsFMvoice	$07
	dc.b	$95, $02, $80, $0A
	dc.b	$FC, $5E			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_1C:
	; This em00_Pat is unused
	; This em00_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_1D:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $0A, $80, $02
	dc.b	$BC, $0A, $80, $02
	dc.b	$B9, $04, $80, $02
	dc.b	$BE, $0A, $80, $02
	dc.b	$B9, $04, $80, $02
	dc.b	$C0, $0A, $80, $02
	dc.b	$B9, $04, $80, $02
	dc.b	$BE, $0A, $80, $02
	dc.b	$B9, $04, $80, $02
	dc.b	$BC, $0A, $80, $02
	smpsLoop	0, 2, .0
	dc.b	$B7, $0A, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$BC, $0A, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$BE, $0A, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$BC, $0A, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B7, $0A, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$BC, $0A, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	dc.b	$BB, $04, $80, $02
	dc.b	$C0, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	dc.b	$C3, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_1E:
	smpsFMvoice	$02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B4, $0B, $80, $55
	dc.b	$B4, $0B, $80, $49
	dc.b	$B4, $0B, $80, $01
	dc.b	$B2, $0B, $80, $55
	dc.b	$B2, $0B, $80, $49
	dc.b	$B2, $0B, $80, $01
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_1F:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $0B, $80, $01
	dc.b	$B4, $04, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$BC, $0A, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$BE, $0A, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$C0, $04, $80, $08
	dc.b	$C1, $04, $80, $08
	dc.b	$B7, $0B, $80, $01
	dc.b	$B2, $04, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$BC, $0A, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$BE, $04, $80, $08
	dc.b	$C0, $04, $80, $08
	dc.b	$B5, $0B, $80, $01
	dc.b	$B0, $04, $80, $02
	dc.b	$B7, $0A, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$BC, $04, $80, $08
	dc.b	$BE, $04, $80, $08
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_20:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B4, $0B, $80, $01
	dc.b	$AF, $04, $80, $02
	dc.b	$B5, $0A, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$B7, $0A, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$BB, $04, $80, $08
	dc.b	$BC, $04, $80, $08
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_21:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $0B, $80, $01
	dc.b	$B4, $04, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$BC, $0A, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$BE, $0A, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$C0, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	dc.b	$BB, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_22:
	; This em00_Pat is unused
	; This em00_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_23:
	smpsPan		$80, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $10, $80, $02
	dc.b	$AF, $10, $80, $02
	dc.b	$B2, $06, $E7
.0:
	dc.b	$FC, $5D			; set note volume (advanced SMPS only!)
	dc.b	$B4, $03, $E7
	dc.b	$B2, $02, $80, $01
	smpsLoop	0, 3, .0
	smpsPan		$C0, 0
	dc.b	$B7, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$AF, $0A, $80, $02
	smpsPan		$40, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A9, $10, $80, $02
	dc.b	$AD, $10, $80, $02
	dc.b	$B0, $16, $80, $02
	smpsPan		$C0, 0
	dc.b	$FC, $5D			; set note volume (advanced SMPS only!)
	dc.b	$B5, $04, $E7
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B7, $E7
	dc.b	$B5, $03, $80, $01
	dc.b	$FC, $5D			; set note volume (advanced SMPS only!)
	dc.b	$B0, $04, $E7
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B2, $E7
	dc.b	$B0, $03, $80, $01
	dc.b	$FC, $5D			; set note volume (advanced SMPS only!)
	dc.b	$AD, $04, $E7
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AF, $E7
	dc.b	$AD, $03, $80, $01
	smpsPan		$80, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $10, $80, $02
	dc.b	$AF, $10, $80, $02
	dc.b	$B2, $06, $E7
.1:
	dc.b	$FC, $5D			; set note volume (advanced SMPS only!)
	dc.b	$B4, $03, $E7
	dc.b	$B2, $02, $80, $01
	smpsLoop	0, 3, .1
	smpsPan		$C0, 0
	dc.b	$AF, $0A, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$B7, $10, $80, $02
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $10, $80, $02
	dc.b	$B0, $08, $80, $0A
	dc.b	$B4, $10, $80, $02
	dc.b	$AD, $08, $80, $0A
	dc.b	$B2, $04, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$AF, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_24:
.0:
	smpsPan		$40, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BB, $04, $80, $02
	smpsPan		$C0, 0
	dc.b	$B5, $04, $80, $02
	smpsPan		$80, 0
	dc.b	$AF, $04, $80, $02
	smpsLoop	0, 5, em00_Pat_24
	smpsPan		$C0, 0
	dc.b	$B5, $04, $80, $02
em00_Pat_24_12:
	smpsPan		$40, 0
	dc.b	$B9, $04, $80, $02
	smpsPan		$C0, 0
	dc.b	$B4, $04, $80, $02
	smpsPan		$80, 0
	dc.b	$AD, $04, $80, $02
	smpsLoop	1, 5, em00_Pat_24_12
	smpsPan		$C0, 0
	dc.b	$B4, $04, $80, $02
	dc.b	$E9, $FE		; alter note displacement (SMPS/TS)
	smpsLoop	0, 2, em00_Pat_24_12
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
em00_Pat_24_3
	smpsPan		$40, 0
	dc.b	$B9, $04, $80, $02
	smpsPan		$C0, 0
	dc.b	$B4, $04, $80, $02
	smpsPan		$80, 0
	dc.b	$AD, $04, $80, $02
	smpsLoop	0, 5, em00_Pat_24_3
	smpsPan		$C0, 0
	dc.b	$B4, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_25:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $0A
	smpsFMvoice	$05
	smpsPan		$40, 0
	dc.b	$D4, $0B, $80, $01
	smpsPan		$C0, 0
	smpsLoop	0, 2, em00_Pat_25
	smpsFMvoice	$08
	dc.b	$95, $02, $80, $0A
	smpsFMvoice	$06
	smpsPan		$40, 0
	dc.b	$AD, $02, $80, $04
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AD, $02, $80, $04
	smpsPan		$C0, 0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$98, $02, $80, $0A
	smpsPan		$80, 0
	dc.b	$A1, $02, $80, $0A
	smpsPan		$C0, 0
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_26:
	smpsFMvoice	$08
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	dc.b	$FC, $56			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	smpsFMvoice	$07
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	smpsFMvoice	$08
	dc.b	$FC, $56			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	smpsFMvoice	$07
	dc.b	$95, $02, $80, $0A
	smpsFMvoice	$08
	dc.b	$FC, $56			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	dc.b	$FC, $56			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	smpsFMvoice	$06
	smpsPan		$40, 0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A4, $02, $80, $0A
	smpsPan		$80, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9F, $02, $80, $0A
	smpsPan		$C0, 0
	smpsFMvoice	$07
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $0A
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_27:
	smpsFMvoice	$08
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	dc.b	$FC, $56			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	smpsFMvoice	$07
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	smpsFMvoice	$08
	dc.b	$FC, $56			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	smpsFMvoice	$07
	dc.b	$95, $02, $80, $0A
	smpsFMvoice	$08
	dc.b	$FC, $56			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	smpsFMvoice	$06
	smpsPan		$40, 0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$AD, $01, $80, $05
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AD, $01, $80, $05
	smpsPan		$C0, 0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A4, $01, $80, $05
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $01, $80, $05
	smpsPan		$80, 0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$9F, $01, $80, $05
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9F, $01, $80, $05
	smpsPan		$C0, 0
	smpsFMvoice	$07
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $01, $80, $0B
	smpsReturn

; ---------------------------------------------------------------
em00_Pat_28:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $0A
	smpsFMvoice	$07
	dc.b	$95, $02, $80, $0A
	smpsLoop	0, 3, .0
	smpsFMvoice	$07
	dc.b	$95, $02, $80, $04
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$95, $01, $80, $05
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$95, $02, $80, $04
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$95, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
; em00_Voices
; ---------------------------------------------------------------

em00_Voices:
	; Voice $00 (em00_FM)
	dc.b	$EC, $3A, $24, $0A, $00, $99, $9F, $DA, $5F, $94, $0A, $87, $88, $40, $02, $01, $02, $76, $28, $46, $28, $17, $08, $1F, $00
	; Voice $01 (em00_FM)
	dc.b	$C4, $74, $02, $73, $01, $DF, $5F, $1F, $1F, $04, $88, $04, $88, $00, $01, $00, $01, $02, $F8, $02, $F8, $07, $00, $06, $00
	; Voice $02 (em00_FM)
	dc.b	$FB, $11, $21, $00, $71, $5F, $4F, $0E, $17, $05, $0E, $16, $00, $01, $00, $00, $00, $03, $28, $08, $09, $1F, $12, $20, $00
	; Voice $03 (em00_FM)
	dc.b	$FB, $11, $20, $00, $71, $5F, $5F, $1F, $1F, $05, $06, $18, $00, $01, $00, $00, $00, $03, $28, $08, $09, $21, $11, $10, $04
	; Voice $04 (em00_FM)
	dc.b	$FB, $11, $21, $00, $71, $5F, $51, $1F, $1F, $05, $18, $18, $00, $01, $08, $00, $00, $32, $06, $04, $05, $1D, $10, $20, $00
	; Voice $05 (em00_FM)
	dc.b	$FB, $67, $57, $37, $00, $1E, $1E, $1F, $1F, $04, $06, $0C, $11, $40, $80, $84, $11, $F2, $F1, $24, $46, $18, $17, $0C, $00
	; Voice $06 (em00_FM)
	dc.b	$F2, $02, $01, $31, $01, $58, $5A, $5F, $9A, $14, $0C, $0A, $8B, $00, $80, $40, $00, $FA, $F6, $F4, $F5, $15, $17, $25, $00
	; Voice $07 (em00_FM)
	dc.b	$3C, $0F, $02, $04, $03, $1B, $1F, $1C, $18, $00, $00, $19, $00, $00, $00, $00, $00, $03, $07, $F4, $05, $00, $07, $00, $04
	; Voice $08 (em00_FM)
	dc.b	$2D, $00, $32, $02, $52, $1F, $1C, $1C, $1C, $17, $00, $00, $00, $00, $00, $00, $00, $FF, $07, $07, $07, $00, $03, $03, $03
