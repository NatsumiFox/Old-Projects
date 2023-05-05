
; ---------------------------------------------------------------
; Created by Techosoft-2-SMPS v.2.70
; 2014, Vladikcomper
; ---------------------------------------------------------------
TF4_Configuration:

; ---------------------------------------------------------------
; Music Header
; ---------------------------------------------------------------

	dc.w	TF4_Configuration_Voices-TF4_Configuration			; Voice bank offset
	dc.w	$8700			; Number of TF4_Configuration_FM/PSG channels
	dc.w	$0100			; Tempo modifier

	dc.w	$0008, $F200		; Disable DAC channel
	dc.w	TF4_Configuration_FM1-TF4_Configuration, $0054
	dc.w	TF4_Configuration_FM2-TF4_Configuration, $0058
	dc.w	TF4_Configuration_FM3-TF4_Configuration, $0056
	dc.w	TF4_Configuration_FM4-TF4_Configuration, $0058
	dc.w	TF4_Configuration_FM5-TF4_Configuration, $0055
	dc.w	TF4_Configuration_FM6-TF4_Configuration, $0053

; ---------------------------------------------------------------
; Music Tracks
; ---------------------------------------------------------------

TF4_Configuration_FM1:
	dc.b	$FA, $03		; setup portamento mode 3 (advanced SMPS only!)
	dc.b	$FB, $3C		; set portamento speed (SMPS/TS)
.Loop:
	smpsCall	TF4_Configuration_Pat_04
	smpsCall	TF4_Configuration_Pat_09
	smpsCall	TF4_Configuration_Pat_04
	smpsCall	TF4_Configuration_Pat_13
	smpsJump	.Loop

; ---------------------------------------------------------------
TF4_Configuration_FM2:
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
	dc.b	$FB, $5C		; set portamento speed (SMPS/TS)
;	dc.b	$F1			; unsupported coordination flag
;	dc.b	$E4, $0C		; unsupported coordination flag
.Loop:
	smpsCall	TF4_Configuration_Pat_00
	smpsCall	TF4_Configuration_Pat_00
	smpsCall	TF4_Configuration_Pat_0B
	smpsCall	TF4_Configuration_Pat_14
	dc.b	$FB, $5C		; set portamento speed (SMPS/TS)
	smpsJump	.Loop

; ---------------------------------------------------------------
TF4_Configuration_FM3:
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
	dc.b	$FB, $5C		; set portamento speed (SMPS/TS)
	smpsPan		$80, 0
;	dc.b	$F1			; unsupported coordination flag
;	dc.b	$E4, $0C		; unsupported coordination flag
.Loop:
	smpsCall	TF4_Configuration_Pat_01
	smpsCall	TF4_Configuration_Pat_01
	smpsCall	TF4_Configuration_Pat_00
	smpsCall	TF4_Configuration_Pat_15
	dc.b	$FB, $5C		; set portamento speed (SMPS/TS)
	smpsJump	.Loop

; ---------------------------------------------------------------
TF4_Configuration_FM4:
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
	dc.b	$FB, $5C		; set portamento speed (SMPS/TS)
	smpsPan		$40, 0
;	dc.b	$F1			; unsupported coordination flag
;	dc.b	$E4, $0C		; unsupported coordination flag
.Loop:
	smpsCall	TF4_Configuration_Pat_02
	smpsCall	TF4_Configuration_Pat_02
	smpsCall	TF4_Configuration_Pat_01
	smpsCall	TF4_Configuration_Pat_16
	dc.b	$FB, $5C		; set portamento speed (SMPS/TS)
	smpsJump	.Loop

; ---------------------------------------------------------------
TF4_Configuration_FM5:
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
.Loop:
	smpsCall	TF4_Configuration_Pat_0D
	smpsJump	.Loop

; ---------------------------------------------------------------
TF4_Configuration_FM6:
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
	smpsFMvoice	$00
.Loop:
	smpsCall	TF4_Configuration_Pat_05
	smpsJump	.Loop

; ---------------------------------------------------------------
; TF4_Configuration_Pats
; ---------------------------------------------------------------

TF4_Configuration_Pat_00:
	smpsFMvoice	$01
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$C3, $16, $80, $02
	dc.b	$C3, $16, $80, $02
	dc.b	$C3, $0A, $80, $02
	dc.b	$C8, $0C, $E7
	dc.b	$CF, $0A, $80, $02
	dc.b	$CD, $16, $80, $02
	dc.b	$CD, $0A, $80, $02
	dc.b	$CD, $0A, $80, $02
	dc.b	$C8, $0A, $80, $02
	dc.b	$CD, $16, $80, $02
	dc.b	$CF, $16, $80, $02
	dc.b	$C3, $16, $80, $02
	dc.b	$C3, $16, $80, $02
	dc.b	$C3, $0C, $E7
	dc.b	$C8, $E7
	dc.b	$CF, $0A, $80, $02
	dc.b	$CD, $60, $E7
	dc.b	$CD, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_01:
	smpsFMvoice	$01
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$C0, $16, $80, $02
	dc.b	$C0, $16, $80, $02
	dc.b	$C0, $0C, $E7
	dc.b	$C5, $E7
	dc.b	$CC, $0A, $80, $02
	dc.b	$CA, $16, $80, $02
	dc.b	$CA, $0A, $80, $02
	dc.b	$CA, $0A, $80, $02
	dc.b	$C5, $0A, $80, $02
	dc.b	$CA, $16, $80, $02
	dc.b	$CC, $16, $80, $02
	dc.b	$C0, $16, $80, $02
	dc.b	$C0, $16, $80, $02
	dc.b	$C0, $0C, $E7
	dc.b	$C5, $E7
	dc.b	$CC, $0A, $80, $02
	dc.b	$CA, $60, $E7
	dc.b	$CA, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_02:
	smpsFMvoice	$01
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$BC, $16, $80, $02
	dc.b	$BC, $16, $80, $02
	dc.b	$BC, $0C, $E7
	dc.b	$C1, $E7
	dc.b	$C8, $0A, $80, $02
	dc.b	$C6, $16, $80, $02
	dc.b	$C6, $0A, $80, $02
	dc.b	$C6, $0A, $80, $02
	dc.b	$C1, $0A, $80, $02
	dc.b	$C6, $16, $80, $02
	dc.b	$C8, $16, $80, $02
	dc.b	$BC, $16, $80, $02
	dc.b	$BC, $16, $80, $02
	dc.b	$BC, $0C, $E7
	dc.b	$C1, $E7
	dc.b	$C8, $0A, $80, $02
	dc.b	$C6, $60, $E7
	dc.b	$C6, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_03:
	; This TF4_Configuration_Pat is unused
	; This TF4_Configuration_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_04:
.0:
	smpsFMvoice	$04
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A6, $03, $80, $15
	smpsFMvoice	$03
	dc.b	$A6, $03, $80, $15
	smpsLoop	0, 7, .0
	smpsFMvoice	$04
	dc.b	$A6, $03, $80, $09
	dc.b	$A6, $03, $80, $09
	smpsFMvoice	$03
	dc.b	$A6, $03, $80, $15
.1:
	smpsFMvoice	$04
	dc.b	$A6, $03, $80, $15
	smpsFMvoice	$03
	dc.b	$A6, $03, $80, $15
	smpsLoop	0, 6, .1
	smpsFMvoice	$04
	dc.b	$A6, $03, $80, $09
	smpsFMvoice	$03
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_05:
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
	dc.b	$FB, $5C		; set portamento speed (SMPS/TS)
.0:
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AB, $5E, $80, $02
	dc.b	$B7, $5E, $80, $02
	smpsLoop	0, 4, .0
.1:
	dc.b	$AE, $5E, $80, $02
	dc.b	$BA, $5E, $80, $02
	smpsLoop	0, 3, .1
	dc.b	$AE, $5E, $80, $02
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$BA, $0C, $E7
	dc.b	$AE, $52, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_06:
	; This TF4_Configuration_Pat is unused
	; This TF4_Configuration_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_07:
	; This TF4_Configuration_Pat is unused
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B7, $16, $80, $02
	smpsLoop	0, 32, .0
.1:
	dc.b	$BA, $16, $80, $02
	smpsLoop	0, 32, .1
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_08:
	; This TF4_Configuration_Pat is unused
	; This TF4_Configuration_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_09:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A6, $03, $80, $09
	smpsLoop	0, 7, .0
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_0A:
	; This TF4_Configuration_Pat is unused
	; This TF4_Configuration_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_0B:
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$C6, $16, $80, $02
	dc.b	$C6, $16, $80, $02
	dc.b	$C6, $0A, $80, $02
	dc.b	$CB, $0C, $E7
	dc.b	$D2, $0A, $80, $02
	dc.b	$D0, $16, $80, $02
	dc.b	$D0, $0A, $80, $02
	dc.b	$D0, $0A, $80, $02
	dc.b	$CB, $0A, $80, $02
	dc.b	$D0, $16, $80, $02
	dc.b	$D2, $16, $80, $02
	dc.b	$C6, $16, $80, $02
	dc.b	$C6, $16, $80, $02
	dc.b	$C6, $0C, $E7
	dc.b	$CB, $E7
	dc.b	$D2, $0A, $80, $02
	dc.b	$D0, $60, $E7
	dc.b	$D0, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_0C:
	; This TF4_Configuration_Pat is unused
	; This TF4_Configuration_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_0D:
	smpsFMvoice	$02
.0:
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$93, $0A, $80, $02
	dc.b	$93, $0A, $80, $02
	dc.b	$9F, $0A, $80, $02
	dc.b	$9F, $0A, $80, $02
	smpsLoop	0, 16, .0
.1:
	dc.b	$96, $0A, $80, $02
	dc.b	$96, $0A, $80, $02
	dc.b	$A2, $0A, $80, $02
	dc.b	$A2, $0A, $80, $02
	smpsLoop	0, 14, .1
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9F, $0C, $E7
	dc.b	$93, $52, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_0E:
	; This TF4_Configuration_Pat is unused
	; This TF4_Configuration_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_0F:
	; This TF4_Configuration_Pat is unused
	; This TF4_Configuration_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_10:
	; This TF4_Configuration_Pat is unused
	; This TF4_Configuration_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_11:
	; This TF4_Configuration_Pat is unused
	; This TF4_Configuration_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_12:
	; This TF4_Configuration_Pat is unused
	; This TF4_Configuration_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_13:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A6, $03, $80, $15
	dc.b	$A6, $03, $80, $15
	dc.b	$A6, $03, $80, $09
	dc.b	$A6, $03, $80, $09
	dc.b	$A6, $03, $80, $09
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_14:
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$C6, $16, $80, $02
	dc.b	$C6, $16, $80, $02
	dc.b	$C6, $0A, $80, $02
	dc.b	$CB, $0C, $E7
	dc.b	$D2, $0A, $80, $02
	dc.b	$D0, $16, $80, $02
	dc.b	$D0, $0A, $80, $02
	dc.b	$D0, $0A, $80, $02
	dc.b	$CB, $0A, $80, $02
	dc.b	$D0, $16, $80, $02
	dc.b	$D2, $16, $80, $02
	dc.b	$C6, $16, $80, $02
	dc.b	$C6, $16, $80, $02
	dc.b	$C6, $0C, $E7
	dc.b	$CB, $E7
	dc.b	$D2, $16, $80, $02
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$D1, $0C, $E7
	dc.b	$C5, $E7
	dc.b	$C5, $46, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_15:
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$C3, $16, $80, $02
	dc.b	$C3, $16, $80, $02
	dc.b	$C3, $0C, $E7
	dc.b	$C8, $E7
	dc.b	$CF, $0A, $80, $02
	dc.b	$CD, $16, $80, $02
	dc.b	$CD, $0A, $80, $02
	dc.b	$CD, $0A, $80, $02
	dc.b	$C8, $0A, $80, $02
	dc.b	$CD, $16, $80, $02
	dc.b	$CF, $16, $80, $02
	dc.b	$C3, $16, $80, $02
	dc.b	$C3, $16, $80, $02
	dc.b	$C3, $0C, $E7
	dc.b	$C8, $E7
	dc.b	$CF, $16, $80, $02
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$CD, $0C, $E7
	dc.b	$C1, $E7
	dc.b	$C1, $46, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF4_Configuration_Pat_16:
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$C0, $16, $80, $02
	dc.b	$C0, $16, $80, $02
	dc.b	$C0, $0C, $E7
	dc.b	$C5, $E7
	dc.b	$CC, $0A, $80, $02
	dc.b	$CA, $16, $80, $02
	dc.b	$CA, $0A, $80, $02
	dc.b	$CA, $0A, $80, $02
	dc.b	$C5, $0A, $80, $02
	dc.b	$CA, $16, $80, $02
	dc.b	$CC, $16, $80, $02
	dc.b	$C0, $16, $80, $02
	dc.b	$C0, $16, $80, $02
	dc.b	$C0, $0C, $E7
	dc.b	$C5, $E7
	dc.b	$CC, $16, $80, $02
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$CC, $0C, $E7
	dc.b	$C0, $E7
	dc.b	$C0, $46, $80, $02
	smpsReturn

; ---------------------------------------------------------------
; TF4_Configuration_Voices
; ---------------------------------------------------------------

TF4_Configuration_Voices:
	; Voice $00 (TF4_Configuration_FM)
	dc.b	$F3, $30, $32, $50, $52, $1F, $1F, $1F, $1F, $0C, $02, $0C, $00, $04, $04, $04, $02, $13, $73, $03, $34, $12, $14, $14, $00
	; Voice $01 (TF4_Configuration_FM)
	dc.b	$F9, $33, $71, $10, $30, $10, $10, $10, $10, $0A, $08, $08, $00, $02, $02, $02, $00, $22, $22, $22, $02, $1D, $18, $1B, $00
	; Voice $02 (TF4_Configuration_FM)
	dc.b	$F8, $31, $01, $01, $02, $9C, $99, $9F, $18, $0A, $0A, $0C, $06, $08, $08, $08, $00, $44, $34, $34, $54, $1F, $28, $10, $00
	; Voice $03 (TF4_Configuration_FM)
	dc.b	$FE, $11, $71, $01, $31, $1F, $1F, $1F, $1F, $15, $0E, $0F, $0F, $00, $0B, $15, $0D, $06, $76, $75, $75, $00, $00, $00, $00
	; Voice $04 (TF4_Configuration_FM)
	dc.b	$FE, $00, $00, $00, $00, $9F, $1F, $1F, $1F, $1F, $1F, $0B, $0B, $11, $0F, $08, $08, $0C, $0C, $76, $76, $00, $00, $00, $00
