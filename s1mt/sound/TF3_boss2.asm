
; ---------------------------------------------------------------
; Created by Techosoft-2-SMPS v.2.70
; 2014, Vladikcomper
; ---------------------------------------------------------------
TF3_boss2:

; ---------------------------------------------------------------
; Music Header
; ---------------------------------------------------------------

	dc.w	TF3_boss2_Voices-TF3_boss2			; Voice bank offset
	dc.w	$8700			; Number of TF3_boss2_FM/PSG channels
	dc.w	$0100			; Tempo modifier

	dc.w	$0008, $F200		; Disable DAC channel
	dc.w	TF3_boss2_FM1-TF3_boss2, $0052
	dc.w	TF3_boss2_FM2-TF3_boss2, $0054
	dc.w	TF3_boss2_FM3-TF3_boss2, $0054
	dc.w	TF3_boss2_FM4-TF3_boss2, $0052
	dc.w	TF3_boss2_FM5-TF3_boss2, $0048
	dc.w	TF3_boss2_FM6-TF3_boss2, $004C

; ---------------------------------------------------------------
; Music Tracks
; ---------------------------------------------------------------

TF3_boss2_FM1:
	dc.b	$FA, $00		; setup portamento mode 0 (advanced SMPS only!)
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsCall	TF3_boss2_Pat_17
.Loop:
	smpsCall	TF3_boss2_Pat_00
	smpsCall	TF3_boss2_Pat_06
	smpsCall	TF3_boss2_Pat_0A
	smpsCall	TF3_boss2_Pat_0B
	smpsCall	TF3_boss2_Pat_0D
	smpsCall	TF3_boss2_Pat_0D
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsJump	.Loop

; ---------------------------------------------------------------
TF3_boss2_FM2:
	smpsPan		$80, 0
	dc.b	$E6, $08		; alter note volume (SMPS/TS)
	dc.b	$E9, $E8		; alter note displacement (SMPS/TS)
	smpsCall	TF3_boss2_Pat_16
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
TF3_boss2_FM2_1:
	smpsCall	TF3_boss2_Pat_01
	smpsCall	TF3_boss2_Pat_01
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	dc.b	$E9, $F4		; alter note displacement (SMPS/TS)
	smpsCall	TF3_boss2_Pat_01
	smpsCall	TF3_boss2_Pat_01
	smpsCall	TF3_boss2_Pat_0E
	smpsCall	TF3_boss2_Pat_0E
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsPan		$80, 0
	dc.b	$E6, $08		; alter note volume (SMPS/TS)
	dc.b	$E9, $E8		; alter note displacement (SMPS/TS)
	smpsJump	TF3_boss2_FM2_1

; ---------------------------------------------------------------
TF3_boss2_FM3:
	dc.b	$FA, $03		; setup portamento mode 3 (advanced SMPS only!)
	dc.b	$FB, $0A		; set portamento speed (SMPS/TS)
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	smpsCall	TF3_boss2_Pat_19
.Loop:
	smpsCall	TF3_boss2_Pat_04
	smpsCall	TF3_boss2_Pat_07
	smpsCall	TF3_boss2_Pat_08
	smpsCall	TF3_boss2_Pat_08
	smpsCall	TF3_boss2_Pat_09
	smpsCall	TF3_boss2_Pat_11
	smpsJump	.Loop

; ---------------------------------------------------------------
TF3_boss2_FM4:
	smpsPan		$C0, 0
	dc.b	$E6, $04		; alter note volume (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsCall	TF3_boss2_Pat_18
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
TF3_boss2_FM4_1:
	smpsCall	TF3_boss2_Pat_03
	smpsCall	TF3_boss2_Pat_03
	smpsCall	TF3_boss2_Pat_03
	smpsCall	TF3_boss2_Pat_03
	smpsCall	TF3_boss2_Pat_03
	smpsCall	TF3_boss2_Pat_03
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsPan		$C0, 0
	dc.b	$E6, $04		; alter note volume (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsJump	TF3_boss2_FM4_1

; ---------------------------------------------------------------
TF3_boss2_FM5:
	smpsPan		$80, 0
	dc.b	$E6, $08		; alter note volume (SMPS/TS)
	dc.b	$E9, $F4		; alter note displacement (SMPS/TS)
	smpsCall	TF3_boss2_Pat_15
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
TF3_boss2_FM5_1:
	smpsCall	TF3_boss2_Pat_02
	smpsCall	TF3_boss2_Pat_02
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsCall	TF3_boss2_Pat_02
	smpsCall	TF3_boss2_Pat_02
	smpsCall	TF3_boss2_Pat_0F
	smpsCall	TF3_boss2_Pat_0F
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsPan		$80, 0
	dc.b	$E6, $08		; alter note volume (SMPS/TS)
	dc.b	$E9, $F4		; alter note displacement (SMPS/TS)
	smpsJump	TF3_boss2_FM5_1

; ---------------------------------------------------------------
TF3_boss2_FM6:
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	smpsPan		$40, 0
	smpsCall	TF3_boss2_Pat_15
.Loop:
	smpsCall	TF3_boss2_Pat_05
	smpsCall	TF3_boss2_Pat_05
	smpsCall	TF3_boss2_Pat_05
	smpsCall	TF3_boss2_Pat_05
	smpsCall	TF3_boss2_Pat_0C
	smpsCall	TF3_boss2_Pat_0C
	smpsJump	.Loop

; ---------------------------------------------------------------
; TF3_boss2_Pats
; ---------------------------------------------------------------

TF3_boss2_Pat_00:
	smpsFMvoice	$00
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$C4, $60, $E7
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$C4, $E7
	dc.b	$C5, $E7
	dc.b	$C5, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_01:
	smpsFMvoice	$05
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AC, $5E, $80, $02
	dc.b	$AD, $2E, $80, $02
	dc.b	$AF, $16, $80, $02
	dc.b	$AD, $16, $80, $02
	dc.b	$AC, $5E, $80, $02
	dc.b	$AA, $2E, $80, $02
	dc.b	$A8, $16, $80, $02
	dc.b	$AA, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_02:
	smpsFMvoice	$05
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$A5, $60, $E7
	dc.b	$A5, $5E, $80, $02
	dc.b	$A5, $60, $E7
	dc.b	$A5, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_03:
	smpsFMvoice	$01
.0:
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$A5, $0A, $80, $02
	dc.b	$AC, $0A, $80, $02
	smpsLoop	0, 5, .0
	dc.b	$A5, $0A, $80, $02
	dc.b	$AD, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$AF, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$AD, $0A, $80, $02
.1:
	dc.b	$A5, $0A, $80, $02
	dc.b	$AC, $0A, $80, $02
	smpsLoop	0, 5, .1
	dc.b	$A5, $0A, $80, $02
	dc.b	$AA, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$AA, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_04:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $01, $80, $0B
	dc.b	$A6, $01, $80, $0B
	dc.b	$A6, $01, $80, $05
	dc.b	$A6, $01, $80, $05
	dc.b	$A6, $01, $80, $0B
	smpsLoop	0, 8, .0
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_05:
	smpsFMvoice	$03
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BE, $0A, $80, $02
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$A6, $04, $80, $02
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $01, $80, $02
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$A6, $01, $80, $02
	smpsLoop	0, 16, .0
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_06:
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$C4, $60, $E7
	dc.b	$C4, $E7
	dc.b	$D1, $E7
	dc.b	$D1, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_07:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $01, $80, $0B
	dc.b	$A6, $01, $80, $0B
	dc.b	$A6, $01, $80, $05
	dc.b	$A6, $01, $80, $05
	dc.b	$A6, $01, $80, $0B
	smpsLoop	0, 7, .0
	smpsFMvoice	$08
	dc.b	$A6, $01, $80, $0B
	dc.b	$A6, $01, $80, $0B
	smpsFMvoice	$07
.1:
	dc.b	$B2, $01, $80, $05
	smpsLoop	0, 4, .1
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_08:
.0:
	smpsFMvoice	$08
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $05
	smpsLoop	1, 4, .1
	smpsFMvoice	$07
	dc.b	$B2, $01, $80, $0B
	smpsFMvoice	$08
	dc.b	$A8, $01, $80, $0B
	smpsLoop	0, 8, .0
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_09:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $2F
	dc.b	$A8, $01, $80, $2F
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_0A:
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$80, $0C, $E7
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$D4, $54, $E7
	dc.b	$D4, $60, $E7
	dc.b	$D4, $E7
	dc.b	$D4, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_0B:
	smpsFMvoice	$06
.0:
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$82, $16, $80, $02
	smpsLoop	1, 4, .1
	dc.b	$82, $5E, $80, $02
	smpsLoop	0, 2, .0
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_0C:
	smpsFMvoice	$04
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $5E, $80, $02
	dc.b	$A6, $5E, $80, $02
	dc.b	$A6, $5E, $80, $02
	dc.b	$A6, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_0D:
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$C4, $5E, $80, $02
	dc.b	$FB, $62		; set portamento speed (SMPS/TS)
	dc.b	$C5, $2E, $80, $02
	dc.b	$C7, $16, $80, $02
	dc.b	$C5, $16, $80, $02
	dc.b	$C4, $5E, $80, $02
	dc.b	$C2, $2E, $80, $02
	dc.b	$C0, $16, $80, $02
	dc.b	$C2, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_0E:
.0:
	smpsPan		$80, 0
	dc.b	$FC, $62			; set note volume (advanced SMPS only!)
	dc.b	$AC, $0A, $80, $02
	smpsPan		$40, 0
	dc.b	$AC, $0A, $80, $02
	dc.b	$E6, $FC		; alter note volume (SMPS/TS)
	smpsLoop	0, 8, TF3_boss2_Pat_0E
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
TF3_boss2_Pat_0E_1:
	smpsPan		$80, 0
	dc.b	$AD, $0A, $80, $02
	smpsPan		$40, 0
	dc.b	$AD, $0A, $80, $02
	dc.b	$E6, $FC		; alter note volume (SMPS/TS)
	smpsLoop	0, 8, TF3_boss2_Pat_0E_1
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_0F:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A5, $60, $E7
	dc.b	$A5, $E7
	dc.b	$A6, $E7
	dc.b	$A6, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_10:
	; This TF3_boss2_Pat is unused
	; This TF3_boss2_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_11:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $2F
	dc.b	$A8, $01, $80, $2F
	smpsLoop	0, 3, .0
	dc.b	$A8, $01, $80, $2F
	dc.b	$A8, $01, $80, $17
.1:
	dc.b	$A8, $01, $80, $05
	smpsLoop	0, 4, .1
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_12:
	; This TF3_boss2_Pat is unused
	; This TF3_boss2_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_13:
	; This TF3_boss2_Pat is unused
.0:
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B1, $0A, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$BD, $0A, $80, $02
	smpsLoop	0, 8, .0
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_14:
	; This TF3_boss2_Pat is unused
.0:
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B8, $0A, $80, $02
	dc.b	$B9, $0A, $80, $02
	smpsLoop	0, 8, .0
.1:
	dc.b	$BB, $0A, $80, $02
	dc.b	$BC, $0A, $80, $02
	smpsLoop	0, 8, .1
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_15:
	dc.b	$FC, $00			; set note volume (advanced SMPS only!)
	dc.b	$AD, $60, $E7
	dc.b	$AD, $E7
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_16:
	smpsFMvoice	$02
.0:
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$A6, $01, $E7
	dc.b	$FB, $62		; set portamento speed (SMPS/TS)
	dc.b	$B2, $2E, $80, $01
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_17:
	smpsFMvoice	$02
.0:
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$96, $01, $E7
	dc.b	$FB, $62		; set portamento speed (SMPS/TS)
	dc.b	$A2, $2E, $80, $01
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_18:
	smpsFMvoice	$02
.0:
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$9F, $01, $E7
	dc.b	$FB, $62		; set portamento speed (SMPS/TS)
	dc.b	$AB, $2E, $80, $01
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
TF3_boss2_Pat_19:
	dc.b	$FC, $01			; set note volume (advanced SMPS only!)
	dc.b	$9F, $01, $80, $5F
	dc.b	$9F, $46, $80, $02
	smpsFMvoice	$07
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $01, $80, $05
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
; TF3_boss2_Voices
; ---------------------------------------------------------------

TF3_boss2_Voices:
	; Voice $00 (TF3_boss2_FM)
	dc.b	$F8, $52, $36, $21, $04, $18, $1C, $1C, $19, $00, $00, $00, $06, $00, $00, $00, $00, $02, $02, $02, $62, $16, $28, $16, $00
	; Voice $01 (TF3_boss2_FM)
	dc.b	$FD, $62, $00, $54, $33, $DF, $DF, $9F, $9F, $07, $06, $09, $86, $07, $06, $06, $08, $70, $51, $10, $F0, $14, $04, $00, $00
	; Voice $02 (TF3_boss2_FM)
	dc.b	$C2, $1C, $76, $43, $21, $18, $14, $1D, $12, $02, $00, $02, $08, $00, $04, $04, $02, $33, $14, $14, $83, $25, $1D, $21, $00
	; Voice $03 (TF3_boss2_FM)
	dc.b	$FD, $07, $04, $0A, $0C, $1F, $1F, $1F, $1F, $8B, $93, $93, $93, $04, $04, $04, $04, $C6, $F6, $F6, $B6, $00, $00, $00, $00
	; Voice $04 (TF3_boss2_FM)
	dc.b	$FC, $36, $5F, $5B, $58, $17, $1F, $1F, $9B, $00, $0B, $07, $09, $08, $08, $06, $08, $44, $F4, $74, $B4, $00, $00, $00, $00
	; Voice $05 (TF3_boss2_FM)
	dc.b	$FB, $32, $76, $72, $32, $8D, $4F, $15, $52, $0A, $08, $07, $07, $06, $00, $00, $00, $03, $03, $03, $03, $15, $20, $26, $00
	; Voice $06 (TF3_boss2_FM)
	dc.b	$FA, $51, $20, $50, $10, $1F, $1F, $1F, $1F, $86, $8B, $86, $80, $01, $01, $01, $02, $12, $02, $21, $12, $14, $17, $00, $00
	; Voice $07 (TF3_boss2_FM)
	dc.b	$FE, $00, $00, $00, $00, $1F, $1F, $1F, $1F, $05, $00, $00, $00, $00, $0B, $15, $09, $06, $06, $34, $00, $00, $00, $00, $00
	; Voice $08 (TF3_boss2_FM)
	dc.b	$FE, $00, $00, $00, $00, $1F, $1F, $1F, $1F, $09, $09, $00, $00, $09, $06, $00, $00, $02, $4A, $02, $02, $00, $00, $00, $00
