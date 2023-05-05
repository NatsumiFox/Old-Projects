
; ---------------------------------------------------------------
; Created by Techosoft-2-SMPS v.2.70
; 2014, Vladikcomper
; ---------------------------------------------------------------

; ---------------------------------------------------------------
; Music Header
; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger:
	dc.w	Z80_BGM_Jagd_flieger_Voices-Z80_BGM_Jagd_flieger			; Voice bank offset
	dc.w	$8700			; Number of Z80_BGM_Jagd_flieger_fm/PSG channels
	dc.w	$0100			; Tempo modifier

	dc.w	$0008, $F200		; Disable DAC channel
	dc.w	Z80_BGM_Jagd_flieger_fm1-Z80_BGM_Jagd_flieger, $0050
	dc.w	Z80_BGM_Jagd_flieger_fm2-Z80_BGM_Jagd_flieger, $0050
	dc.w	Z80_BGM_Jagd_flieger_fm3-Z80_BGM_Jagd_flieger, $0050
	dc.w	Z80_BGM_Jagd_flieger_fm4-Z80_BGM_Jagd_flieger, $0050
	dc.w	Z80_BGM_Jagd_flieger_fm5-Z80_BGM_Jagd_flieger, $0050
	dc.w	Z80_BGM_Jagd_flieger_fm6-Z80_BGM_Jagd_flieger, $004F

; ---------------------------------------------------------------
; Music Tracks
; ---------------------------------------------------------------

Z80_BGM_Jagd_flieger_fm1:
	dc.b	$FA, $03		; setup portamento mode 3 (advanced SMPS only!)
	dc.b	$FB, $14		; set portamento speed (SMPS/TS)
	smpsfmvoice	$04
	smpsCall	Z80_BGM_Jagd_flieger_pt00
	smpsCall	Z80_BGM_Jagd_flieger_pt01
	smpsCall	Z80_BGM_Jagd_flieger_pt19
	smpsCall	Z80_BGM_Jagd_flieger_pt01
	smpsCall	Z80_BGM_Jagd_flieger_pt0D
	smpsCall	Z80_BGM_Jagd_flieger_pt18
	smpsStop

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_fm2:
	dc.b	$FA, $03		; setup portamento mode 3 (advanced SMPS only!)
	dc.b	$FB, $14		; set portamento speed (SMPS/TS)
	smpsfmvoice	$04
	smpsCall	Z80_BGM_Jagd_flieger_pt1A
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsfmvoice	$00
	dc.b	$E6, $06		; alter note volume (SMPS/TS)
	smpsCall	Z80_BGM_Jagd_flieger_pt03
	smpsCall	Z80_BGM_Jagd_flieger_pt0F
	smpsCall	Z80_BGM_Jagd_flieger_pt03
	smpsCall	Z80_BGM_Jagd_flieger_pt14
	smpsCall	Z80_BGM_Jagd_flieger_pt26
	smpsStop

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_fm3:
	dc.b	$FA, $00		; setup portamento mode 0 (advanced SMPS only!)
	dc.b	$FB, $5B		; set portamento speed (SMPS/TS)
	smpsPan		$80, 0
	dc.b	$E9, $F4		; alter note displacement (SMPS/TS)
	smpsfmvoice	$01
	smpsCall	Z80_BGM_Jagd_flieger_pt27
	dc.b	$FB, $0A		; set portamento speed (SMPS/TS)
	smpsCall	Z80_BGM_Jagd_flieger_pt04
	smpsCall	Z80_BGM_Jagd_flieger_pt09
	dc.b	$E9, $0C		; alter note displacement (SMPS/TS)
	smpsCall	Z80_BGM_Jagd_flieger_pt04
	smpsCall	Z80_BGM_Jagd_flieger_pt0A
	smpsCall	Z80_BGM_Jagd_flieger_pt15
	smpsStop

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_fm4:
	dc.b	$FA, $00		; setup portamento mode 0 (advanced SMPS only!)
	dc.b	$FB, $5B		; set portamento speed (SMPS/TS)
	dc.b	$E1, $02		; set note shift (SMPS/TS)
	smpsPan		$C0, 0
	dc.b	$E9, $F4		; alter note displacement (SMPS/TS)
	smpsfmvoice	$01
	smpsCall	Z80_BGM_Jagd_flieger_pt28
	dc.b	$FB, $0A		; set portamento speed (SMPS/TS)
	smpsCall	Z80_BGM_Jagd_flieger_pt06
	smpsCall	Z80_BGM_Jagd_flieger_pt07
	dc.b	$E9, $0C		; alter note displacement (SMPS/TS)
	smpsCall	Z80_BGM_Jagd_flieger_pt06
	smpsCall	Z80_BGM_Jagd_flieger_pt10
	smpsCall	Z80_BGM_Jagd_flieger_pt16
	smpsStop

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_fm5:
	dc.b	$FA, $00		; setup portamento mode 0 (advanced SMPS only!)
	dc.b	$FB, $5B		; set portamento speed (SMPS/TS)
	smpsPan		$40, 0
	dc.b	$E9, $F4		; alter note displacement (SMPS/TS)
	smpsfmvoice	$01
	smpsCall	Z80_BGM_Jagd_flieger_pt29
	dc.b	$FB, $0A		; set portamento speed (SMPS/TS)
	smpsCall	Z80_BGM_Jagd_flieger_pt08
	smpsCall	Z80_BGM_Jagd_flieger_pt0C
	dc.b	$E9, $0C		; alter note displacement (SMPS/TS)
	smpsCall	Z80_BGM_Jagd_flieger_pt08
	smpsCall	Z80_BGM_Jagd_flieger_pt13
	smpsCall	Z80_BGM_Jagd_flieger_pt17
	smpsStop

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_fm6:
	dc.b	$FA, $00		; setup portamento mode 0 (advanced SMPS only!)
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
;	dc.b	$F1			; unsupported coordination flag
;	dc.b	$E4, $0C		; unsupported coordination flag
	smpsPan		$C0, 0
	smpsfmvoice	$02
	smpsCall	Z80_BGM_Jagd_flieger_pt02
	smpsCall	Z80_BGM_Jagd_flieger_pt02
	smpsCall	Z80_BGM_Jagd_flieger_pt1C
	smpsCall	Z80_BGM_Jagd_flieger_pt25
	smpsCall	Z80_BGM_Jagd_flieger_pt1B
;	dc.b	$FB		; Invalid track control byte
	smpsStop

; ---------------------------------------------------------------
; Patterns
; ---------------------------------------------------------------

Z80_BGM_Jagd_flieger_pt00:
	smpsPan		$80, 0
	dc.b	$E6, $06		; alter note volume (SMPS/TS)
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$BC, $01, $80, $02
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BC, $01, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$BC, $01, $80, $02
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BC, $01, $80, $02
	dc.b	$BB, $01, $80, $05
	dc.b	$FC, $5D			; set note volume (advanced SMPS only!)
	dc.b	$B9, $01, $80, $05
	dc.b	$FC, $56			; set note volume (advanced SMPS only!)
	dc.b	$B7, $01, $80, $05
	dc.b	$FC, $53			; set note volume (advanced SMPS only!)
	dc.b	$B5, $01, $80, $05
	dc.b	$FC, $4C			; set note volume (advanced SMPS only!)
	dc.b	$B4, $01, $80, $05
	dc.b	$B2, $01, $80, $05
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C3, $01, $80, $05
	dc.b	$C0, $01, $80, $0B
	dc.b	$FC, $56			; set note volume (advanced SMPS only!)
	dc.b	$BC, $01, $80, $0B
	dc.b	$B7, $01, $80, $05
	dc.b	$FC, $4C			; set note volume (advanced SMPS only!)
	dc.b	$B2, $01, $80, $0B
	smpsPan		$C0, 0
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt01:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A8, $02, $80, $04
	dc.b	$FC, $5D			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $05
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $05
	smpsLoop	0, 4, .0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $02
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $02
	dc.b	$A8, $01, $80, $02
	dc.b	$FC, $5D			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $05
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt02:
	dc.b	$FC, $00			; set note volume (advanced SMPS only!)
	dc.b	$B9, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt03:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$AD, $04, $80, $0E
	dc.b	$AB, $04, $80, $0E
	dc.b	$AD, $04, $80, $20
	dc.b	$A9, $04, $80, $08
	dc.b	$AB, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt04:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$C5, $04, $80, $02
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$B9, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$C3, $04, $80, $02
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$B7, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$C5, $04, $80, $02
	dc.b	$FB, $5A		; set portamento speed (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$C5, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$FB, $0A		; set portamento speed (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C1, $04, $80, $02
	dc.b	$C1, $04, $80, $08
	dc.b	$C3, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt05:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt06:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$C8, $04, $80, $02
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$BC, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$C7, $04, $80, $02
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$BB, $04, $80, $02
	dc.b	$BB, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$C8, $04, $80, $02
	dc.b	$FB, $5A		; set portamento speed (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$C8, $04, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$FB, $0A		; set portamento speed (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C5, $04, $80, $02
	dc.b	$C5, $04, $80, $08
	dc.b	$C7, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt07:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$C8, $04, $80, $02
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$BC, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$C7, $04, $80, $02
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$BB, $04, $80, $02
	dc.b	$BB, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$C8, $04, $80, $02
	dc.b	$FB, $5E		; set portamento speed (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$C8, $04, $80, $02
	dc.b	$C8, $04, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$B0, $04, $80, $02
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BC, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B0, $04, $80, $02
	dc.b	$C8, $04, $80, $02
	dc.b	$FB, $0A		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt08:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$CC, $04, $80, $02
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$C0, $04, $80, $02
	dc.b	$C0, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$CA, $04, $80, $02
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$BE, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$CC, $04, $80, $02
	dc.b	$FB, $5A		; set portamento speed (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$CC, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$FB, $0A		; set portamento speed (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C8, $04, $80, $02
	dc.b	$C8, $04, $80, $08
	dc.b	$CA, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt09:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$C5, $04, $80, $02
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$B9, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$C3, $04, $80, $02
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$B7, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$C5, $04, $80, $02
	dc.b	$FB, $5E		; set portamento speed (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$C5, $04, $80, $02
	dc.b	$C5, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$AD, $04, $80, $02
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$AD, $04, $80, $02
	dc.b	$C5, $04, $80, $02
	dc.b	$FB, $0A		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt0A:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C0, $04, $80, $02
	dc.b	$FB, $5F		; set portamento speed (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$C0, $04, $80, $02
	dc.b	$C0, $04, $80, $02
	dc.b	$C0, $04, $80, $02
	dc.b	$C0, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B5, $04, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$A9, $04, $80, $02
	dc.b	$B5, $04, $80, $02
	dc.b	$C1, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B7, $04, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AB, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$C3, $04, $80, $02
	dc.b	$FB, $0A		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt0B:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt0C:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$CC, $04, $80, $02
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$C0, $04, $80, $02
	dc.b	$C0, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$CA, $04, $80, $02
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$BE, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$CC, $04, $80, $02
	dc.b	$FB, $5E		; set portamento speed (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$CC, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$B4, $04, $80, $02
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C0, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B4, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$FB, $0A		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt0D:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $05
	dc.b	$FC, $5D			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $05
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $01, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$A6, $01, $80, $02
	dc.b	$A6, $01, $80, $02
	dc.b	$A6, $01, $80, $02
	smpsLoop	0, 2, .0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $05
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $05
	smpsPan		$80, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B4, $01, $80, $0B
	smpsPan		$C0, 0
	dc.b	$FC, $5D			; set note volume (advanced SMPS only!)
	dc.b	$B0, $01, $80, $0B
	smpsPan		$40, 0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$AD, $01, $80, $0B
	smpsPan		$C0, 0
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt0E:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt0F:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$AD, $04, $80, $0E
	dc.b	$AB, $04, $80, $0E
	dc.b	$AD, $22, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$B9, $04, $80, $08
	dc.b	$AD, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt10:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C3, $04, $80, $02
	dc.b	$FB, $5F		; set portamento speed (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$C3, $04, $80, $02
	dc.b	$C3, $04, $80, $02
	dc.b	$C3, $04, $80, $02
	dc.b	$C3, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AD, $04, $80, $02
	dc.b	$B9, $04, $80, $02
	dc.b	$C5, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$BB, $04, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AF, $04, $80, $02
	dc.b	$BB, $04, $80, $02
	dc.b	$C7, $04, $80, $02
	dc.b	$FB, $0A		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt11:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt12:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt13:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C7, $04, $80, $02
	dc.b	$FB, $5F		; set portamento speed (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$C7, $04, $80, $02
	dc.b	$C7, $04, $80, $02
	dc.b	$C7, $04, $80, $02
	dc.b	$C7, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$BC, $04, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B0, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	dc.b	$C8, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$BE, $04, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B2, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$CA, $04, $80, $02
	dc.b	$FB, $0A		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt14:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A8, $2E, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$B5, $03, $80, $09
	dc.b	$A9, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$B7, $03, $80, $09
	dc.b	$AB, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt15:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$D1, $04, $80, $02
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$C5, $04, $80, $02
	dc.b	$C5, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$CF, $04, $80, $02
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$C3, $04, $80, $02
	dc.b	$C3, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$D1, $06, $E7
	dc.b	$FB, $5C		; set portamento speed (SMPS/TS)
	dc.b	$DD, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt16:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$D4, $04, $80, $02
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$C8, $04, $80, $02
	dc.b	$C8, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$D3, $04, $80, $02
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$C7, $04, $80, $02
	dc.b	$C7, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$C8, $06, $E7
	dc.b	$FB, $5C		; set portamento speed (SMPS/TS)
	dc.b	$D4, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt17:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$D8, $04, $80, $02
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$CC, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$D6, $04, $80, $02
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$CA, $04, $80, $02
	dc.b	$CA, $04, $80, $02
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$CC, $06, $E7
	dc.b	$FB, $5C		; set portamento speed (SMPS/TS)
	dc.b	$D8, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt18:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A8, $02, $80, $04
	dc.b	$FC, $5D			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $05
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $05
	smpsLoop	0, 2, .0
	smpsfmvoice	$03
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A8, $06, $80, $2A
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt19:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A8, $02, $80, $04
	dc.b	$FC, $5D			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $05
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $05
	smpsLoop	0, 3, .0
	smpsPan		$80, 0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$C3, $01, $80, $02
	dc.b	$C1, $01, $80, $02
	smpsPan		$C0, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C0, $01, $80, $05
	dc.b	$BE, $01, $80, $0B
	smpsPan		$40, 0
	dc.b	$BC, $01, $80, $05
	dc.b	$B7, $01, $80, $0B
	smpsPan		$C0, 0
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt1A:
	smpsPan		$40, 0
	dc.b	$E6, $06		; alter note volume (SMPS/TS)
	dc.b	$FC, $4F			; set note volume (advanced SMPS only!)
	dc.b	$BC, $01, $80, $02
	dc.b	$FC, $4C			; set note volume (advanced SMPS only!)
	dc.b	$BC, $01, $80, $02
	dc.b	$FC, $58			; set note volume (advanced SMPS only!)
	dc.b	$BC, $01, $80, $02
	dc.b	$FC, $53			; set note volume (advanced SMPS only!)
	dc.b	$BC, $01, $80, $02
	dc.b	$BB, $01, $80, $05
	dc.b	$FC, $50			; set note volume (advanced SMPS only!)
	dc.b	$B9, $01, $80, $05
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B7, $01, $80, $05
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B5, $01, $80, $05
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B4, $01, $80, $05
	dc.b	$B2, $01, $80, $05
	dc.b	$FC, $4C			; set note volume (advanced SMPS only!)
	dc.b	$C3, $01, $80, $05
	dc.b	$FC, $51			; set note volume (advanced SMPS only!)
	dc.b	$C0, $01, $80, $0B
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$BC, $01, $80, $0B
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B7, $01, $80, $05
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B2, $01, $80, $0B
	smpsPan		$C0, 0
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt1B:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$D1, $04, $80, $02
	dc.b	$FB, $56		; set portamento speed (SMPS/TS)
	dc.b	$D3, $04, $80, $02
	dc.b	$D4, $04, $80, $02
	dc.b	$D3, $04, $80, $02
	dc.b	$D4, $04, $80, $02
	dc.b	$D6, $04, $80, $02
	dc.b	$D8, $04, $80, $02
	dc.b	$D6, $04, $80, $02
	dc.b	$D8, $04, $80, $02
	dc.b	$D9, $04, $80, $02
	dc.b	$DB, $04, $80, $02
	dc.b	$D9, $04, $80, $02
	dc.b	$DB, $04, $80, $02
	dc.b	$DD, $04, $80, $02
	dc.b	$DF, $04, $80, $02
	dc.b	$DB, $04, $80, $02
	dc.b	$DD, $48, $80, $18
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt1C:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$80, $48
	dc.b	$CC, $04, $80, $02
	dc.b	$CD, $04, $80, $02
	dc.b	$D1, $04, $80, $02
	dc.b	$D4, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt1D:
	; This pattern is unused
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$B9, $80, $04
	dc.b	$B9, $02, $80, $04
	dc.b	$B7, $80, $02
	dc.b	$B7, $80, $04
	dc.b	$B7, $02, $80, $04
	dc.b	$B9, $80, $02
	dc.b	$B9, $80, $04
	dc.b	$B9, $02, $80, $04
	dc.b	$B9, $02, $80, $04
	dc.b	$B9, $02, $80, $04
	dc.b	$B9, $02, $80, $04
	dc.b	$B5, $80, $08
	dc.b	$B7, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt1E:
	; This pattern is unused
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$B9, $80, $04
	dc.b	$B9, $02, $80, $04
	dc.b	$B7, $80, $02
	dc.b	$B7, $80, $04
	dc.b	$B7, $02, $80, $04
.0:
	dc.b	$B9, $02, $80, $04
	smpsLoop	0, 10, .0
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt1F:
	; This pattern is unused
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B4, $04, $80, $02
	smpsLoop	0, 8, .0
	dc.b	$B5, $04, $80, $02
	dc.b	$B5, $80, $04
	dc.b	$B5, $02, $80, $04
	dc.b	$B5, $02, $80, $04
	dc.b	$B7, $80, $02
	dc.b	$B7, $80, $04
	dc.b	$B7, $02, $80, $04
	dc.b	$B7, $02, $80, $04
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt20:
	; This pattern is unused
	dc.b	$E6, $06		; alter note volume (SMPS/TS)
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$B9, $80, $04
	dc.b	$B9, $02, $80, $04
	dc.b	$B7, $80, $02
	dc.b	$B7, $80, $04
	dc.b	$B7, $02, $80, $04
	dc.b	$B9, $18, $80, $24
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt21:
	; This pattern is unused
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$C0, $04, $80, $02
	dc.b	$C0, $80, $04
	dc.b	$C0, $02, $80, $04
	dc.b	$BE, $80, $02
	dc.b	$BE, $80, $04
	dc.b	$BE, $02, $80, $04
	dc.b	$C0, $80, $02
	dc.b	$C0, $80, $04
	dc.b	$C0, $02, $80, $04
	dc.b	$C0, $02, $80, $04
	dc.b	$C0, $02, $80, $04
	dc.b	$C0, $02, $80, $04
	dc.b	$BC, $80, $08
	dc.b	$BE, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt22:
	; This pattern is unused
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$C0, $04, $80, $02
	dc.b	$C0, $80, $04
	dc.b	$C0, $02, $80, $04
	dc.b	$BE, $80, $02
	dc.b	$BE, $80, $04
	dc.b	$BE, $02, $80, $04
.0:
	dc.b	$C0, $80, $02
	smpsLoop	0, 10, .0
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt23:
	; This pattern is unused
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$BB, $04, $80, $02
	smpsLoop	0, 8, .0
	dc.b	$BC, $04, $80, $02
	dc.b	$BC, $80, $04
	dc.b	$BC, $02, $80, $04
	dc.b	$BC, $02, $80, $04
	dc.b	$BE, $80, $02
	dc.b	$BE, $80, $04
	dc.b	$BE, $02, $80, $04
	dc.b	$BE, $02, $80, $04
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt24:
	; This pattern is unused
	dc.b	$E6, $06		; alter note volume (SMPS/TS)
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$C0, $04, $80, $02
	dc.b	$C0, $80, $04
	dc.b	$C0, $02, $80, $04
	dc.b	$BE, $80, $02
	dc.b	$BE, $80, $04
	dc.b	$BE, $02, $80, $04
	dc.b	$C0, $18, $80, $24
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt25:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$D1, $04, $80, $02
	dc.b	$CF, $04, $80, $02
	dc.b	$CD, $04, $80, $02
	dc.b	$CF, $04, $80, $02
	dc.b	$CD, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$CD, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$CA, $04, $80, $02
	dc.b	$C8, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$CD, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$D3, $04, $80, $02
	dc.b	$D1, $04, $80, $02
	dc.b	$CF, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt26:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$AD, $04, $80, $0E
	dc.b	$AB, $04, $80, $0E
	dc.b	$AD, $18, $E7
	dc.b	$FB, $60		; set portamento speed (SMPS/TS)
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
	dc.b	$A1, $22, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt27:
	dc.b	$FC, $00			; set note volume (advanced SMPS only!)
	dc.b	$95, $2E, $80, $02
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C5, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt28:
	dc.b	$FC, $00			; set note volume (advanced SMPS only!)
	dc.b	$98, $2E, $80, $02
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C8, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_BGM_Jagd_flieger_pt29:
	dc.b	$FC, $00			; set note volume (advanced SMPS only!)
	dc.b	$9C, $2E, $80, $02
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$CC, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
; Voices
; ---------------------------------------------------------------

Z80_BGM_Jagd_flieger_Voices:
	; Voice $00 (Z80_BGM_Jagd_flieger_fm)
	dc.b	$C0, $66, $05, $00, $30, $DF, $DF, $9F, $9F, $07, $06, $09, $86, $07, $06, $06, $08, $25, $15, $15, $F5, $1C, $2D, $10, $00
	; Voice $01 (Z80_BGM_Jagd_flieger_fm)
	dc.b	$C0, $68, $04, $00, $31, $DF, $DF, $9F, $9F, $06, $0A, $07, $86, $02, $01, $01, $04, $23, $33, $13, $15, $24, $22, $0E, $00
	; Voice $02 (Z80_BGM_Jagd_flieger_fm)
	dc.b	$F5, $70, $70, $70, $70, $16, $1A, $1B, $1C, $05, $0C, $0C, $0C, $01, $00, $00, $00, $34, $29, $1F, $1F, $15, $02, $02, $02
	; Voice $03 (Z80_BGM_Jagd_flieger_fm)
	dc.b	$FD, $18, $70, $00, $30, $1F, $1F, $1F, $1F, $05, $0E, $10, $0F, $00, $0A, $0A, $0A, $00, $45, $35, $45, $0C, $00, $00, $00
	; Voice $04 (Z80_BGM_Jagd_flieger_fm)
	dc.b	$FE, $00, $00, $00, $00, $1F, $1F, $1F, $1F, $09, $09, $00, $00, $09, $06, $00, $00, $02, $4A, $02, $02, $00, $00, $00, $00
