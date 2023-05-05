
; ---------------------------------------------------------------
; Created by Techosoft-2-SMPS v.2.70
; 2014, Vladikcomper
; ---------------------------------------------------------------
em08:

; ---------------------------------------------------------------
; Music Header
; ---------------------------------------------------------------

	dc.w	em08_Voices-em08			; Voice bank offset
	dc.w	$8700			; Number of em08_FM/PSG channels
	dc.w	$0100			; Tempo modifier

	dc.w	$0008, $F200		; Disable DAC channel
	dc.w	em08_FM1-em08, $0051
	dc.w	em08_FM2-em08, $004D
	dc.w	em08_FM3-em08, $004F
	dc.w	em08_FM4-em08, $0054
	dc.w	em08_FM5-em08, $004A
	dc.w	em08_FM6-em08, $004C

; ---------------------------------------------------------------
; Music Tracks
; ---------------------------------------------------------------

em08_FM1:
	dc.b	$E6, $FA		; alter note volume (SMPS/TS)
	smpsFMvoice	$02
	smpsCall	em08_Pat_00
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
.Loop:
	smpsFMvoice	$05
	smpsCall	em08_Pat_08
	smpsCall	em08_Pat_08
	smpsFMvoice	$04
	dc.b	$E6, $05		; alter note volume (SMPS/TS)
	smpsCall	em08_Pat_0E
	smpsCall	em08_Pat_19
	dc.b	$E9, $0C		; alter note displacement (SMPS/TS)
	smpsCall	em08_Pat_0E
	smpsCall	em08_Pat_1A
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsJump	.Loop

; ---------------------------------------------------------------
em08_FM2:
	smpsFMvoice	$01
	smpsCall	em08_Pat_01
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsFMvoice	$0B
.Loop:
	dc.b	$E6, $0D		; alter note volume (SMPS/TS)
	smpsCall	em08_Pat_07
	smpsCall	em08_Pat_07
	smpsCall	em08_Pat_0F
	smpsJump	.Loop

; ---------------------------------------------------------------
em08_FM3:
	dc.b	$E6, $04		; alter note volume (SMPS/TS)
	smpsFMvoice	$03
	smpsCall	em08_Pat_06
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
.Loop:
	smpsFMvoice	$0A
	smpsCall	em08_Pat_0D
	smpsCall	em08_Pat_0D
	smpsFMvoice	$06
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	smpsCall	em08_Pat_1B
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsJump	.Loop

; ---------------------------------------------------------------
em08_FM4:
	smpsFMvoice	$00
	smpsCall	em08_Pat_05
	dc.b	$FA, $03		; setup portamento mode 3 (advanced SMPS only!)
	dc.b	$FB, $1E		; set portamento speed (SMPS/TS)
	dc.b	$E6, $06		; alter note volume (SMPS/TS)
	smpsPan		$C0, 0
.Loop:
	smpsCall	em08_Pat_0A
	smpsCall	em08_Pat_09
	smpsCall	em08_Pat_10
	smpsCall	em08_Pat_13
	smpsCall	em08_Pat_10
	smpsCall	em08_Pat_14
	smpsJump	.Loop

; ---------------------------------------------------------------
em08_FM5:
	smpsFMvoice	$02
	smpsCall	em08_Pat_04
	dc.b	$E1, $04		; set note shift (SMPS/TS)
;	dc.b	$E5, $0C		; unsupported coordination flag
em08_FM5_1
	smpsFMvoice	$0A
	smpsCall	em08_Pat_0C
	smpsCall	em08_Pat_0C
	smpsFMvoice	$06
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	smpsPan		$40, 0
	smpsCall	em08_Pat_11
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsPan		$C0, 0
	smpsJump	em08_FM5_1

; ---------------------------------------------------------------
em08_FM6:
	smpsFMvoice	$02
	smpsCall	em08_Pat_02
	dc.b	$E1, $04		; set note shift (SMPS/TS)
;	dc.b	$E5, $0C		; unsupported coordination flag
em08_FM6_1
	smpsFMvoice	$05
	smpsCall	em08_Pat_08
	smpsCall	em08_Pat_08
	smpsFMvoice	$04
	dc.b	$E6, $05		; alter note volume (SMPS/TS)
	smpsPan		$80, 0
	smpsCall	em08_Pat_0E
	smpsCall	em08_Pat_19
	dc.b	$E9, $0C		; alter note displacement (SMPS/TS)
	smpsCall	em08_Pat_0E
	smpsCall	em08_Pat_1A
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsPan		$C0, 0
	smpsJump	em08_FM6_1

; ---------------------------------------------------------------
; em08_Pats
; ---------------------------------------------------------------

em08_Pat_00:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $2E, $80, $02
	dc.b	$A5, $2E, $80, $02
	dc.b	$A7, $2E, $80, $02
	dc.b	$A5, $2E, $80, $02
	dc.b	$A4, $16, $80, $02
	dc.b	$A5, $16, $80, $02
	dc.b	$A7, $16, $80, $02
	dc.b	$A5, $16, $80, $02
.0:
	dc.b	$A4, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$A7, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	smpsLoop	0, 2, .0
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_01:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$8C, $2E, $80, $02
	dc.b	$8D, $2E, $80, $02
	dc.b	$8F, $2E, $80, $02
	dc.b	$8D, $2E, $80, $02
	dc.b	$8C, $16, $80, $02
	dc.b	$8D, $16, $80, $02
	dc.b	$8F, $16, $80, $02
	dc.b	$8D, $16, $80, $02
.0:
	dc.b	$8C, $0A, $80, $02
	dc.b	$8D, $0A, $80, $02
	dc.b	$8F, $0A, $80, $02
	dc.b	$8D, $0A, $80, $02
	smpsLoop	0, 2, .0
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_02:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $2E, $80, $02
	dc.b	$AC, $2E, $80, $02
	dc.b	$AE, $2E, $80, $02
	dc.b	$AC, $2E, $80, $02
	dc.b	$AB, $16, $80, $02
	dc.b	$AC, $16, $80, $02
	dc.b	$AE, $16, $80, $02
	dc.b	$AC, $16, $80, $02
.0:
	dc.b	$AB, $0A, $80, $02
	dc.b	$AC, $0A, $80, $02
	dc.b	$AE, $0A, $80, $02
	dc.b	$AC, $0A, $80, $02
	smpsLoop	0, 2, .0
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_03:
	; This em08_Pat is unused
	; This em08_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_04:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $2E, $80, $02
	dc.b	$A9, $2E, $80, $02
	dc.b	$AB, $2E, $80, $02
	dc.b	$A9, $2E, $80, $02
	dc.b	$A8, $16, $80, $02
	dc.b	$A9, $16, $80, $02
	dc.b	$AB, $16, $80, $02
	dc.b	$A9, $16, $80, $02
.0:
	dc.b	$A8, $0A, $80, $02
	dc.b	$A9, $0A, $80, $02
	dc.b	$AB, $0A, $80, $02
	dc.b	$A9, $0A, $80, $02
	smpsLoop	0, 2, .0
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_05:
.0:
	smpsPan		$40, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $04, $80, $02
	smpsPan		$80, 0
	dc.b	$A4, $04, $80, $02
	smpsLoop	0, 4, em08_Pat_05
em08_Pat_05_1
	smpsPan		$40, 0
	dc.b	$A5, $04, $80, $02
	smpsPan		$80, 0
	dc.b	$A5, $04, $80, $02
	smpsLoop	0, 4, em08_Pat_05_1
em08_Pat_05_2
	smpsPan		$40, 0
	dc.b	$A7, $04, $80, $02
	smpsPan		$80, 0
	dc.b	$A7, $04, $80, $02
	smpsLoop	0, 4, em08_Pat_05_2
em08_Pat_05_3
	smpsPan		$40, 0
	dc.b	$A5, $04, $80, $02
	smpsPan		$80, 0
	dc.b	$A5, $04, $80, $02
	smpsLoop	0, 4, em08_Pat_05_3
em08_Pat_05_4
	smpsPan		$40, 0
	dc.b	$A4, $04, $80, $02
	smpsPan		$80, 0
	dc.b	$A4, $04, $80, $02
	smpsLoop	0, 2, em08_Pat_05_4
em08_Pat_05_5
	smpsPan		$40, 0
	dc.b	$A5, $04, $80, $02
	smpsPan		$80, 0
	dc.b	$A5, $04, $80, $02
	smpsLoop	0, 2, em08_Pat_05_5
em08_Pat_05_6
	smpsPan		$40, 0
	dc.b	$A7, $04, $80, $02
	smpsPan		$80, 0
	dc.b	$A7, $04, $80, $02
	smpsLoop	0, 2, em08_Pat_05_6
em08_Pat_05_7
	smpsPan		$40, 0
	dc.b	$A5, $04, $80, $02
	smpsPan		$80, 0
	dc.b	$A5, $04, $80, $02
	smpsLoop	0, 2, em08_Pat_05_7
em08_Pat_05_8
	smpsPan		$40, 0
	dc.b	$A4, $04, $80, $02
	smpsPan		$80, 0
	dc.b	$A4, $04, $80, $02
	smpsPan		$40, 0
	dc.b	$A5, $04, $80, $02
	smpsPan		$80, 0
	dc.b	$A5, $04, $80, $02
	smpsPan		$40, 0
	dc.b	$A7, $04, $80, $02
	smpsPan		$80, 0
	dc.b	$A7, $04, $80, $02
	smpsPan		$40, 0
	dc.b	$A5, $04, $80, $02
	smpsPan		$80, 0
	dc.b	$A5, $04, $80, $02
	smpsLoop	0, 2, em08_Pat_05_8
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_06:
	dc.b	$FA, $00		; setup portamento mode 0 (advanced SMPS only!)
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
;	dc.b	$F1			; unsupported coordination flag
;	dc.b	$E4, $00		; unsupported coordination flag
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$8C, $0C, $E7
	dc.b	$FB, $62		; set portamento speed (SMPS/TS)
	dc.b	$D4, $60, $E7
	dc.b	$D4, $E7
	dc.b	$D4, $E7
	dc.b	$D4, $52, $80, $02
;	dc.b	$F0			; unsupported coordination flag
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_07:
.0:
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $04, $80, $02
	dc.b	$A4, $0A, $80, $02
	smpsLoop	1, 4, .1
	dc.b	$A4, $0A, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$E9, $FF		; alter note displacement (SMPS/TS)
	smpsLoop	0, 4, .0
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_08:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $10, $80, $02
	dc.b	$A5, $10, $80, $02
	dc.b	$A6, $10, $80, $02
	dc.b	$A4, $10, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$E9, $FF		; alter note displacement (SMPS/TS)
	smpsLoop	0, 4, .0
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_09:
.0:
	smpsFMvoice	$09
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	smpsFMvoice	$08
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$09
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$08
	dc.b	$AB, $01, $80, $0B
	smpsLoop	0, 6, .0
	dc.b	$AB, $01, $80, $02
	dc.b	$AB, $01, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	smpsLoop	0, 2, .1
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $0B
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_0A:
.0:
.1:
	smpsFMvoice	$08
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$09
	dc.b	$AB, $01, $80, $0B
	smpsLoop	1, 2, .1
	smpsFMvoice	$08
	dc.b	$AB, $01, $80, $05
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	smpsFMvoice	$09
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$08
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$09
	dc.b	$AB, $01, $80, $0B
	smpsLoop	0, 3, .0
.2:
	smpsFMvoice	$08
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$09
	dc.b	$AB, $01, $80, $0B
	smpsLoop	0, 2, .2
	smpsFMvoice	$08
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_0B:
	; This em08_Pat is unused
	; This em08_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_0C:
	smpsPan		$80, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C3, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	smpsPan		$40, 0
	dc.b	$C3, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	smpsLoop	1, 2, em08_Pat_0C
	smpsPan		$C0, 0
	dc.b	$C3, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	dc.b	$C3, $04, $80, $02
	dc.b	$E9, $FF		; alter note displacement (SMPS/TS)
	smpsLoop	0, 4, em08_Pat_0C
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_0D:
.0:
.1:
	dc.b	$FC, $5D			; set note volume (advanced SMPS only!)
	dc.b	$C3, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	smpsLoop	1, 5, .1
	dc.b	$C3, $04, $80, $02
	dc.b	$E9, $FF		; alter note displacement (SMPS/TS)
	smpsLoop	0, 4, .0
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_0E:
.0:
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AD, $04, $80, $02
	dc.b	$AD, $04, $80, $08
	smpsLoop	1, 2, .1
	dc.b	$AB, $28, $80, $14
	smpsLoop	0, 3, .0
.2:
	dc.b	$AD, $04, $80, $02
	dc.b	$AD, $04, $80, $08
	smpsLoop	0, 2, .2
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_0F:
.0:
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A1, $04, $80, $02
	dc.b	$A1, $04, $80, $08
	smpsLoop	1, 2, .1
	dc.b	$9F, $16, $80, $02
	dc.b	$9F, $10, $80, $02
	dc.b	$9F, $10, $80, $02
	smpsLoop	0, 7, .0
.2:
	dc.b	$A1, $04, $80, $02
	dc.b	$A1, $04, $80, $08
	smpsLoop	0, 2, .2
.3:
	dc.b	$FC, $50			; set note volume (advanced SMPS only!)
	dc.b	$A1, $04, $80, $02
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	smpsLoop	0, 10, .3
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_10:
.0:
	smpsFMvoice	$09
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $0B
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$07
	smpsPan		$40, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B4, $01, $80, $02
	dc.b	$B4, $01, $80, $02
	dc.b	$B4, $01, $80, $05
	smpsPan		$C0, 0
	dc.b	$B0, $01, $80, $05
	dc.b	$B0, $01, $80, $05
	smpsPan		$80, 0
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	smpsPan		$C0, 0
	smpsFMvoice	$08
	dc.b	$FC, $56			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $80, $15
	smpsLoop	0, 3, em08_Pat_10
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_11:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $04, $80, $02
	dc.b	$A8, $04, $80, $08
	smpsLoop	1, 2, em08_Pat_11
	dc.b	$A6, $16, $80, $02
	dc.b	$E6, $0A		; alter note volume (SMPS/TS)
	smpsPan		$80, 0
	dc.b	$93, $04, $80, $0E
	smpsPan		$40, 0
	dc.b	$93, $04, $80, $0E
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsLoop	0, 7, em08_Pat_11
em08_Pat_11_2
	dc.b	$A8, $04, $80, $02
	dc.b	$A8, $04, $80, $08
	smpsLoop	0, 2, em08_Pat_11_2
	dc.b	$B4, $24, $E7
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
	dc.b	$FB, $60		; set portamento speed (SMPS/TS)
	dc.b	$A8, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_12:
	; This em08_Pat is unused
	; This em08_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_13:
	smpsFMvoice	$09
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $0B
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$08
	dc.b	$AB, $01, $80, $02
	dc.b	$AB, $01, $80, $02
.0:
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	smpsLoop	0, 2, .0
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_14:
	smpsFMvoice	$08
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $0B
	smpsLoop	0, 2, .0
.1:
	dc.b	$AB, $01, $80, $05
	smpsLoop	0, 8, .1
	dc.b	$AB, $01, $80, $0B
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_15:
	; This em08_Pat is unused
	; This em08_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_16:
	; This em08_Pat is unused
	; This em08_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_17:
	; This em08_Pat is unused
	; This em08_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_18:
	; This em08_Pat is unused
	; This em08_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_19:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AF, $28, $80, $14
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_1A:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AD, $24, $E7
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
	dc.b	$FB, $60		; set portamento speed (SMPS/TS)
	dc.b	$A1, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em08_Pat_1B:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $04, $80, $02
	dc.b	$A8, $04, $80, $08
	smpsLoop	1, 2, em08_Pat_1B
	dc.b	$A6, $16, $80, $02
	dc.b	$E6, $0A		; alter note volume (SMPS/TS)
	smpsPan		$80, 0
	dc.b	$93, $04, $80, $0E
	smpsPan		$40, 0
	dc.b	$93, $04, $80, $0E
	smpsPan		$C0, 0
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsLoop	0, 7, em08_Pat_1B
em08_Pat_1B_2
	dc.b	$A8, $04, $80, $02
	dc.b	$A8, $04, $80, $08
	smpsLoop	0, 2, em08_Pat_1B_2
	dc.b	$B4, $24, $E7
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
	dc.b	$FB, $60		; set portamento speed (SMPS/TS)
	dc.b	$A8, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
; em08_Voices
; ---------------------------------------------------------------

em08_Voices:
	; Voice $00 (em08_FM)
	dc.b	$3C, $31, $31, $51, $51, $0B, $13, $1B, $1B, $10, $02, $08, $02, $03, $06, $04, $08, $61, $27, $44, $27, $14, $04, $14, $04
	; Voice $01 (em08_FM)
	dc.b	$28, $31, $01, $01, $01, $1F, $17, $1F, $1F, $06, $01, $02, $06, $01, $01, $01, $00, $10, $34, $10, $17, $14, $14, $0F, $00
	; Voice $02 (em08_FM)
	dc.b	$28, $32, $31, $51, $52, $13, $15, $13, $0F, $05, $01, $00, $02, $01, $01, $01, $01, $14, $17, $34, $17, $19, $19, $19, $00
	; Voice $03 (em08_FM)
	dc.b	$23, $00, $00, $00, $00, $17, $13, $1B, $1F, $04, $04, $13, $01, $04, $00, $09, $00, $41, $36, $41, $16, $10, $10, $10, $00
	; Voice $04 (em08_FM)
	dc.b	$3C, $31, $32, $50, $51, $1F, $1F, $1F, $1F, $03, $06, $09, $06, $02, $01, $05, $09, $16, $27, $26, $27, $18, $00, $18, $00
	; Voice $05 (em08_FM)
	dc.b	$3C, $32, $34, $51, $52, $1B, $12, $1F, $1F, $07, $00, $04, $03, $04, $07, $08, $07, $40, $07, $40, $07, $1A, $00, $16, $00
	; Voice $06 (em08_FM)
	dc.b	$3C, $33, $31, $51, $51, $1F, $1F, $1F, $1F, $03, $06, $09, $06, $02, $01, $05, $09, $16, $27, $26, $27, $18, $00, $18, $00
	; Voice $07 (em08_FM)
	dc.b	$3B, $0F, $0D, $07, $01, $1F, $1F, $1F, $1F, $04, $15, $1F, $0B, $0A, $0B, $00, $00, $43, $55, $FB, $B3, $00, $1C, $00, $00
	; Voice $08 (em08_FM)
	dc.b	$3C, $0F, $01, $01, $01, $1F, $1F, $1F, $1F, $1F, $00, $1F, $00, $0F, $00, $1F, $00, $15, $07, $F0, $05, $00, $00, $00, $00
	; Voice $09 (em08_FM)
	dc.b	$2D, $00, $00, $00, $00, $19, $19, $19, $19, $19, $00, $00, $00, $1F, $00, $00, $00, $FF, $05, $05, $05, $00, $05, $05, $05
	; Voice $0A (em08_FM)
	dc.b	$2C, $33, $31, $5F, $51, $DF, $9F, $9F, $5F, $02, $02, $02, $03, $02, $07, $02, $06, $69, $6E, $69, $78, $1C, $00, $1B, $00
	; Voice $0B (em08_FM)
	dc.b	$7B, $38, $04, $20, $70, $3F, $3E, $3F, $3F, $2F, $70, $6F, $6E, $27, $29, $29, $2A, $59, $24, $28, $07, $1E, $28, $10, $00
