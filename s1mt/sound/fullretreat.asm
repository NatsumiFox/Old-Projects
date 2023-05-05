
; ---------------------------------------------------------------
; Created by Techosoft-2-SMPS v.2.70
; 2014, Vladikcomper
; ---------------------------------------------------------------
fullretreat:

; ---------------------------------------------------------------
; Music Header
; ---------------------------------------------------------------

	dc.w	fullretreat_Voices-fullretreat			; Voice bank offset
	dc.w	$8700			; Number of fullretreat_FM/PSG channels
	dc.w	$0100			; Tempo modifier

	dc.w	$0008, $F200		; Disable DAC channel
	dc.w	fullretreat_FM1-fullretreat, $0055
	dc.w	fullretreat_FM2-fullretreat, $0051
	dc.w	fullretreat_FM3-fullretreat, $0053
	dc.w	fullretreat_FM4-fullretreat, $004F
	dc.w	fullretreat_FM5-fullretreat, $0055
	dc.w	fullretreat_FM6-fullretreat, $0053

; ---------------------------------------------------------------
; Music Tracks
; ---------------------------------------------------------------

fullretreat_FM1:
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	smpsPan		$80, 0
	dc.b	$E9, $F4		; alter note displacement (SMPS/TS)
	smpsCall	fullretreat_Pattern_00
	smpsCall	fullretreat_Pattern_06
	smpsCall	fullretreat_Pattern_00
	smpsCall	fullretreat_Pattern_06
	smpsCall	fullretreat_Pattern_0C
	smpsCall	fullretreat_Pattern_15
	smpsCall	fullretreat_Pattern_0C
	smpsCall	fullretreat_Pattern_16
;	dc.b	$EC, $03		; set volume speed (SMPS/TS)
;	smpsCall	fullretreat_Pattern_18
	smpsJump	fullretreat_FM1

; ---------------------------------------------------------------
fullretreat_FM2:
	dc.b	$E1, $04		; set note shift (SMPS/TS)
;	dc.b	$E5, $18		; unsupported coordination flag
	dc.b	$E6, $FC		; alter note volume (SMPS/TS)
	smpsPan		$40, 0
	dc.b	$E9, $F4		; alter note displacement (SMPS/TS)
	smpsCall	fullretreat_Pattern_00
	smpsCall	fullretreat_Pattern_06
	smpsCall	fullretreat_Pattern_00
	smpsCall	fullretreat_Pattern_06
	smpsCall	fullretreat_Pattern_0C
	smpsCall	fullretreat_Pattern_15
	smpsCall	fullretreat_Pattern_0C
	smpsCall	fullretreat_Pattern_16
;	dc.b	$EC, $03		; set volume speed (SMPS/TS)
;	smpsCall	fullretreat_Pattern_18
	smpsJump	fullretreat_FM2

; ---------------------------------------------------------------
fullretreat_FM3:
	dc.b	$E1, $02		; set note shift (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsPan		$40, 0
	dc.b	$E9, $18		; alter note displacement (SMPS/TS)
	smpsCall	fullretreat_Pattern_01
	smpsCall	fullretreat_Pattern_07
	smpsCall	fullretreat_Pattern_01
	smpsCall	fullretreat_Pattern_07
	smpsCall	fullretreat_Pattern_01
	smpsCall	fullretreat_Pattern_07
	smpsCall	fullretreat_Pattern_01
	smpsCall	fullretreat_Pattern_07
;	dc.b	$EC, $03		; set volume speed (SMPS/TS)
;	smpsCall	fullretreat_Pattern_0B
	smpsJump	fullretreat_FM3

; ---------------------------------------------------------------
fullretreat_FM4:
	dc.b	$E1, $06		; set note shift (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
;	dc.b	$E5, $0C		; unsupported coordination flag
	dc.b	$E6, $FC		; alter note volume (SMPS/TS)
	smpsPan		$80, 0
	dc.b	$E9, $18		; alter note displacement (SMPS/TS)
	smpsCall	fullretreat_Pattern_01
	smpsCall	fullretreat_Pattern_07
	smpsCall	fullretreat_Pattern_01
	smpsCall	fullretreat_Pattern_07
	smpsCall	fullretreat_Pattern_01
	smpsCall	fullretreat_Pattern_07
	smpsCall	fullretreat_Pattern_01
	smpsCall	fullretreat_Pattern_07
;	dc.b	$EC, $03		; set volume speed (SMPS/TS)
;	smpsCall	fullretreat_Pattern_0B
	smpsJump	fullretreat_FM4

; ---------------------------------------------------------------
fullretreat_FM5:
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	dc.b	$E6, $E2		; alter note volume (SMPS/TS)
;	dc.b	$EC, $05		; set volume speed (SMPS/TS)
	dc.b	$E6, $1E		; alter note volume (SMPS/TS)
	smpsCall	fullretreat_Pattern_03
	smpsCall	fullretreat_Pattern_08
	smpsCall	fullretreat_Pattern_03
	smpsCall	fullretreat_Pattern_08
	smpsCall	fullretreat_Pattern_03
	smpsCall	fullretreat_Pattern_08
	smpsCall	fullretreat_Pattern_03
	smpsCall	fullretreat_Pattern_08
;	dc.b	$EC, $05		; set volume speed (SMPS/TS)
;	smpsCall	fullretreat_Pattern_0E
	smpsJump	fullretreat_FM5

; ---------------------------------------------------------------
fullretreat_FM6:
	dc.b	$FA, $03		; setup portamento mode 3 (advanced SMPS only!)
	dc.b	$FB, $0A		; set portamento speed (SMPS/TS)
	smpsCall	fullretreat_Pattern_04
	smpsCall	fullretreat_Pattern_09
	smpsCall	fullretreat_Pattern_0F
	smpsCall	fullretreat_Pattern_11
	smpsCall	fullretreat_Pattern_0F
	smpsCall	fullretreat_Pattern_1B
	smpsCall	fullretreat_Pattern_0F
	smpsCall	fullretreat_Pattern_1A
;	dc.b	$EC, $07		; set volume speed (SMPS/TS)
;	smpsCall	fullretreat_Pattern_19
	smpsJump	fullretreat_FM6

; ---------------------------------------------------------------
; fullretreat_Patterns
; ---------------------------------------------------------------

fullretreat_Pattern_00:
	smpsFMvoice	$01
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A1, $01, $80, $02
	dc.b	$A2, $01, $80, $02
	dc.b	$A4, $01, $80, $02
	dc.b	$A6, $01, $80, $02
	dc.b	$AD, $52, $80, $02
	dc.b	$AB, $5E, $80, $02
	dc.b	$A9, $5E, $80, $02
	dc.b	$A8, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_01:
	smpsFMvoice	$04
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $16, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$B2, $16, $80, $02
	dc.b	$B7, $16, $80, $02
	dc.b	$B2, $16, $80, $02
	dc.b	$B5, $16, $80, $02
	dc.b	$B2, $16, $80, $02
	dc.b	$B4, $16, $80, $02
	smpsLoop	0, 2, .0
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_02:
	; This fullretreat_Pattern is unused
	; This fullretreat_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_03:
	smpsFMvoice	$02
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9A, $60, $E7
	dc.b	$9A, $E7
	dc.b	$9A, $E7
	dc.b	$9A, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_04:
	smpsFMvoice	$00
	smpsPan		$40, 0
fullretreat_Pattern_04_1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9A, $0C, $E7
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$9A, $E7
	smpsLoop	1, 7, fullretreat_Pattern_04_1
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9A, $E7
	dc.b	$FC, $5E			; set note volume (advanced SMPS only!)
	dc.b	$9A, $0A, $80, $02
	smpsPan		$80, 0
	smpsLoop	0, 2, fullretreat_Pattern_04_1
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_05:
	; This fullretreat_Pattern is unused
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsFMvoice	$00
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B7, $0A, $80, $02
	dc.b	$E6, $FB		; alter note volume (SMPS/TS)
	dc.b	$B9, $0A, $80, $02
	smpsLoop	0, 8, .0
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
.1:
	dc.b	$B5, $0A, $80, $02
	dc.b	$E6, $FB		; alter note volume (SMPS/TS)
	dc.b	$B7, $0A, $80, $02
	smpsLoop	0, 8, .1
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_06:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9F, $01, $80, $02
	dc.b	$A1, $01, $80, $02
	dc.b	$A2, $01, $80, $02
	dc.b	$A4, $01, $80, $02
	dc.b	$AB, $52, $80, $02
	dc.b	$A9, $5E, $80, $02
	dc.b	$A8, $5E, $80, $02
	dc.b	$A6, $60, $E7
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_07:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B0, $16, $80, $02
	dc.b	$B7, $16, $80, $02
	dc.b	$B0, $16, $80, $02
	dc.b	$B5, $16, $80, $02
	dc.b	$B0, $16, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B0, $16, $80, $02
	dc.b	$B2, $16, $80, $02
	smpsLoop	0, 2, .0
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_08:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$98, $60, $E7
	dc.b	$98, $E7
	dc.b	$98, $E7
	dc.b	$98, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_09:
	smpsPan		$40, 0
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9A, $0C, $E7
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$9A, $E7
	smpsLoop	0, 7, .0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9A, $E7
	dc.b	$FC, $5E			; set note volume (advanced SMPS only!)
	dc.b	$9A, $0A, $80, $02
	smpsPan		$80, 0
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $0C, $E7
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B2, $E7
	smpsLoop	0, 5, .1
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $E7
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B2, $0A, $80, $02
	smpsPan		$C0, 0
	smpsFMvoice	$06
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $01, $80, $05
	dc.b	$B5, $01, $80, $05
	dc.b	$B2, $01, $80, $05
	dc.b	$B0, $01, $80, $05
	dc.b	$B5, $01, $80, $05
	dc.b	$B5, $01, $80, $05
	dc.b	$B5, $01, $80, $05
	dc.b	$B5, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_0A:
	; This fullretreat_Pattern is unused
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B5, $0A, $80, $02
	dc.b	$E6, $FB		; alter note volume (SMPS/TS)
	dc.b	$B7, $0A, $80, $02
	smpsLoop	0, 8, .0
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
.1:
	dc.b	$B4, $0A, $80, $02
	dc.b	$E6, $FB		; alter note volume (SMPS/TS)
	dc.b	$B5, $0A, $80, $02
	smpsLoop	0, 8, .1
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_0B:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B4, $06, $80, $02
	dc.b	$B2, $06, $80, $02
	dc.b	$B0, $06, $80, $02
	dc.b	$E6, $BA		; alter note volume (SMPS/TS)
	dc.b	$B2, $60, $E7
	dc.b	$B2, $46, $80, $02
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_0C:
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsFMvoice	$03
	dc.b	$FC, $62			; set note volume (advanced SMPS only!)
	dc.b	$AD, $01, $80, $02
	dc.b	$FB, $5E		; set portamento speed (SMPS/TS)
	dc.b	$AE, $01, $80, $02
	dc.b	$B0, $01, $80, $02
	dc.b	$B2, $01, $80, $02
	dc.b	$B9, $52, $80, $02
	dc.b	$B7, $46, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$BA, $0A, $80, $02
	dc.b	$B9, $5E, $80, $02
	dc.b	$BA, $2E, $80, $02
	dc.b	$BC, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_0D:
	; This fullretreat_Pattern is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$80, $60
	dc.b	$80, $60
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_0E:
	dc.b	$E6, $BA		; alter note volume (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9A, $60, $E7
	dc.b	$9A, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_0F:
.0:
	smpsFMvoice	$06
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $01, $80, $23
	dc.b	$A6, $01, $80, $05
	dc.b	$A6, $01, $80, $05
	smpsFMvoice	$05
	dc.b	$B2, $01, $80, $2F
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_10:
	; This fullretreat_Pattern is unused
	; This fullretreat_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_11:
.0:
	smpsFMvoice	$06
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $01, $80, $23
	dc.b	$A6, $01, $80, $05
	dc.b	$A6, $01, $80, $05
	smpsFMvoice	$05
	dc.b	$B2, $01, $80, $2F
	smpsLoop	0, 3, .0
	smpsFMvoice	$06
	dc.b	$A6, $01, $80, $23
	dc.b	$A6, $01, $80, $05
	dc.b	$A6, $01, $80, $05
	dc.b	$B9, $01, $80, $02
	dc.b	$B9, $01, $80, $02
	dc.b	$B9, $01, $80, $02
	dc.b	$B9, $01, $80, $02
	dc.b	$B7, $01, $80, $05
	dc.b	$B7, $01, $80, $05
	dc.b	$B7, $01, $80, $05
	dc.b	$B7, $01, $80, $05
	dc.b	$B2, $01, $80, $05
	dc.b	$B2, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_12:
	; This fullretreat_Pattern is unused
	; This fullretreat_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_13:
	; This fullretreat_Pattern is unused
	; This fullretreat_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_14:
	; This fullretreat_Pattern is unused
	; This fullretreat_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_15:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B7, $5E, $80, $02
	dc.b	$B5, $46, $80, $02
	dc.b	$B7, $0A, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B7, $2E, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$BA, $16, $80, $02
	dc.b	$B9, $2E, $80, $02
	dc.b	$B7, $2E, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_16:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B7, $5E, $80, $02
	dc.b	$B5, $52, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$B5, $04, $80, $02
	dc.b	$B7, $2E, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$BA, $16, $80, $02
;	dc.b	$EA, $F6		; unsupported coordination flag
	dc.b	$B9, $16, $80, $02
;	dc.b	$EA, $F6		; unsupported coordination flag
	dc.b	$B7, $16, $80, $02
;	dc.b	$EA, $FB		; unsupported coordination flag
	dc.b	$B4, $16, $80, $02
;	dc.b	$EA, $FB		; unsupported coordination flag
	dc.b	$B0, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_17:
	; This fullretreat_Pattern is unused
	; This fullretreat_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_18:
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B0, $06, $80, $02
	dc.b	$B2, $06, $80, $02
	dc.b	$B4, $06, $80, $02
	dc.b	$E6, $BA		; alter note volume (SMPS/TS)
	dc.b	$FB, $5E		; set portamento speed (SMPS/TS)
	dc.b	$BE, $60, $E7
	dc.b	$BE, $18, $E7
	dc.b	$BE, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_19:
	dc.b	$E6, $BA		; alter note volume (SMPS/TS)
	smpsFMvoice	$00
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$98, $60, $E7
	dc.b	$98, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_1A:
.0:
	smpsFMvoice	$06
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $01, $80, $23
	dc.b	$A6, $01, $80, $05
	dc.b	$A6, $01, $80, $05
	smpsFMvoice	$05
	dc.b	$B2, $01, $80, $2F
	smpsLoop	0, 3, .0
	smpsFMvoice	$06
	dc.b	$A6, $01, $80, $23
	dc.b	$A6, $01, $80, $05
	dc.b	$A6, $01, $80, $05
	dc.b	$FB, $01		; set portamento speed (SMPS/TS)
.1:
	dc.b	$BC, $01, $80, $02
	dc.b	$B9, $01, $80, $02
	dc.b	$B7, $01, $80, $02
	dc.b	$B5, $01, $80, $02
	smpsLoop	0, 2, .1
.2:
	dc.b	$B7, $01, $80, $05
	smpsLoop	0, 2, .2
	dc.b	$B2, $01, $80, $05
	dc.b	$B2, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
fullretreat_Pattern_1B:
.0:
	smpsFMvoice	$06
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $01, $80, $23
	dc.b	$A6, $01, $80, $05
	dc.b	$A6, $01, $80, $05
	smpsFMvoice	$05
	dc.b	$B2, $01, $80, $2F
	smpsLoop	0, 3, .0
	smpsFMvoice	$06
	dc.b	$A6, $01, $80, $23
	dc.b	$A6, $01, $80, $05
	dc.b	$A6, $01, $80, $05
	smpsFMvoice	$05
	dc.b	$B9, $01, $80, $0B
	dc.b	$B9, $01, $80, $0B
	smpsFMvoice	$06
	dc.b	$B9, $01, $80, $05
	dc.b	$B5, $01, $80, $05
	dc.b	$B4, $01, $80, $05
	dc.b	$B2, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
; fullretreat_Voices
; ---------------------------------------------------------------

fullretreat_Voices:
	; Voice $00 (fullretreat_FM)
	dc.b	$FD, $0F, $00, $0F, $0F, $1F, $1F, $1F, $1F, $81, $88, $93, $8F, $00, $04, $00, $00, $03, $97, $B7, $F7, $00, $00, $00, $00
	; Voice $01 (fullretreat_FM)
	dc.b	$F2, $31, $21, $51, $21, $1F, $1F, $1F, $1F, $01, $04, $04, $82, $00, $00, $00, $00, $03, $05, $05, $07, $16, $16, $1D, $05
	; Voice $02 (fullretreat_FM)
	dc.b	$F3, $31, $21, $51, $21, $1F, $1F, $1F, $1F, $01, $04, $04, $82, $00, $00, $00, $00, $03, $05, $05, $07, $13, $18, $1B, $05
	; Voice $03 (fullretreat_FM)
	dc.b	$FC, $51, $21, $33, $61, $5F, $59, $5F, $59, $00, $07, $00, $87, $08, $07, $08, $06, $40, $33, $40, $33, $1E, $00, $1E, $00
	; Voice $04 (fullretreat_FM)
	dc.b	$FD, $51, $20, $30, $60, $1F, $1B, $1B, $1B, $88, $87, $86, $85, $08, $00, $00, $02, $41, $38, $38, $38, $2F, $08, $08, $08
	; Voice $05 (fullretreat_FM)
	dc.b	$FE, $10, $70, $00, $30, $1F, $1F, $1F, $1F, $05, $00, $00, $00, $00, $0B, $15, $09, $06, $06, $34, $00, $00, $00, $00, $00
	; Voice $06 (fullretreat_FM)
	dc.b	$FE, $00, $00, $00, $00, $1F, $1F, $1F, $1F, $09, $09, $00, $00, $09, $06, $00, $00, $02, $4A, $02, $02, $00, $00, $00, $00
