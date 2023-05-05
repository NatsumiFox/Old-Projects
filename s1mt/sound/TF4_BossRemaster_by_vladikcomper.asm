
; ---------------------------------------------------------------
; Created by Techosoft-2-SMPS v.2.0
; 2014, Vladikcomper
; ---------------------------------------------------------------
TF4:

TF4_Kick = $81
TF4_Snare = $82
TF4_SnareLo = $82

; ---------------------------------------------------------------
; Music Header
; ---------------------------------------------------------------

	dc.w	TF4_Voices-TF4			; Voice bank offset
	dc.w	$8600			; Number of TF4_FM/PSG channels
	dc.w	$0100			; Tempo modifier

	dc.w	TF4_DAC-TF4, $0000
	dc.w	TF4_FM2-TF4, $0053-1
	dc.w	TF4_FM3-TF4, $004E-1
	dc.w	TF4_FM4-TF4, $004E-1
	dc.w	TF4_FM5-TF4, $004C-1
	dc.w	TF4_FM6-TF4, $004C-1

; ---------------------------------------------------------------
; Music Tracks
; ---------------------------------------------------------------

TF4_DAC:
.Loop:	smpsCall	TF4_Pattern_02
	smpsCall	TF4_Pattern_02
	smpsCall	TF4_Pattern_17
	smpsCall	TF4_Pattern_0A
	smpsJump	.Loop

; ---------------------------------------------------------------
TF4_FM2:
	smpsFMvoice	$01
.Loop:	smpsCall	TF4_Pattern_00
	smpsCall	TF4_Pattern_0B
	smpsCall	TF4_Pattern_00
	smpsCall	TF4_Pattern_0B
	smpsCall	TF4_Pattern_00
	smpsCall	TF4_Pattern_00
	smpsCall	TF4_Pattern_0C
	smpsCall	TF4_Pattern_15
	smpsCall	TF4_Pattern_0E
	smpsJump	.Loop

; ---------------------------------------------------------------
TF4_FM3:
	dc.b	$FB, $01		; set portamento speed (SMPS/TS)
	smpsFMvoice	$00
.Loop:	smpsCall	TF4_Pattern_01
	smpsCall	TF4_Pattern_06
	smpsCall	TF4_Pattern_01
	smpsCall	TF4_Pattern_06
	smpsCall	TF4_Pattern_01
	smpsCall	TF4_Pattern_01
	smpsCall	TF4_Pattern_0F
	smpsCall	TF4_Pattern_13
	smpsCall	TF4_Pattern_14
	smpsCall	TF4_Pattern_13
	smpsCall	TF4_Pattern_18
	smpsJump	.Loop

; ---------------------------------------------------------------
TF4_FM4:
	dc.b	$FB, $01		; set portamento speed (SMPS/TS)
	dc.b	$E1, $FC		; set note shift (SMPS/TS)
	smpsFMvoice	$02
.Loop:	smpsCall	TF4_Pattern_01
	smpsCall	TF4_Pattern_06
	smpsCall	TF4_Pattern_01
	smpsCall	TF4_Pattern_06
	smpsCall	TF4_Pattern_01
	smpsCall	TF4_Pattern_01
	smpsCall	TF4_Pattern_0F
	smpsCall	TF4_Pattern_13
	smpsCall	TF4_Pattern_14
	smpsCall	TF4_Pattern_13
	smpsCall	TF4_Pattern_18
	smpsJump	.Loop

; ---------------------------------------------------------------
TF4_FM5:
	dc.b	$E1, $FC		; set note shift (SMPS/TS)
	smpsFMvoice	$00
.Loop:	smpsCall	TF4_Pattern_05
	smpsCall	TF4_Pattern_08
	smpsCall	TF4_Pattern_05
	smpsCall	TF4_Pattern_08
	smpsCall	TF4_Pattern_05
	smpsCall	TF4_Pattern_05
	smpsCall	TF4_Pattern_11
	smpsCall	TF4_Pattern_01
	smpsCall	TF4_Pattern_01
	smpsCall	TF4_Pattern_13
	smpsCall	TF4_Pattern_1D
	smpsJump	.Loop

; ---------------------------------------------------------------
TF4_FM6:
	dc.b	$FB, $01		; set portamento speed (SMPS/TS)
	smpsFMvoice	$02
.Loop:	smpsCall	TF4_Pattern_03
	smpsCall	TF4_Pattern_07
	smpsCall	TF4_Pattern_03
	smpsCall	TF4_Pattern_07
	smpsCall	TF4_Pattern_03
	smpsCall	TF4_Pattern_03
	smpsCall	TF4_Pattern_11
	smpsCall	TF4_Pattern_1B
	smpsCall	TF4_Pattern_1B
	smpsCall	TF4_Pattern_13
	smpsCall	TF4_Pattern_1E
	smpsJump	.Loop

; ---------------------------------------------------------------
; Patterns
; ---------------------------------------------------------------

TF4_Pattern_00:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$9C, $0A, $80, $02
	dc.b	$9C, $04, $80, $02
	dc.b	$9C, $04, $80, $02
	smpsLoop	0, 3, .0
	dc.b	$9C, $0A, $80, $02
	dc.b	$9A, $0A, $80, $02
.1:
	dc.b	$9C, $0A, $80, $02
	dc.b	$9C, $04, $80, $02
	dc.b	$9C, $04, $80, $02
	smpsLoop	0, 4, .1
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_01:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A8, $0B, $80, $01
	dc.b	$9C, $02, $80, $04
	dc.b	$9C, $80, $02
.0:
	dc.b	$9C, $0A, $80, $02
	dc.b	$9C, $80, $04
	dc.b	$9C, $80, $02
	smpsLoop	0, 2, .0
	dc.b	$9C, $0A, $80, $02
	dc.b	$A6, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$9C, $80, $04
	dc.b	$9C, $80, $02
.1:
	dc.b	$9C, $0A, $80, $02
	dc.b	$9C, $80, $04
	dc.b	$9C, $80, $02
	smpsLoop	0, 3, .1
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_02:
	dc.b	TF4_Snare, $01, $80, $17
	dc.b	TF4_Kick, $04, $80, $14
	dc.b	TF4_Kick, $04, $80, $14
	dc.b	TF4_Kick, $04, $80, $08
	dc.b	TF4_Snare, $01, $80, $0B
	dc.b	TF4_Snare, $01, $80, $0B
	dc.b	TF4_Kick, $04, $80, $08
	dc.b	TF4_Kick, $04, $80, $14
	dc.b	TF4_Kick, $04, $80, $14
	dc.b	TF4_Kick, $04, $80, $14
.0:
	dc.b	TF4_Snare, $01, $80, $0B
	dc.b	TF4_Kick, $03, $80
	dc.b	TF4_Kick, $80
	dc.b	TF4_Kick, $04, $80, $08
	smpsLoop	0, 2, .0
	dc.b	TF4_Snare, $01, $80, $0B
	dc.b	TF4_Kick, $04, $80, $08
.1:
	dc.b	TF4_Snare, $01, $80, $0B
	dc.b	TF4_Kick, $04, $80, $08
	dc.b	TF4_Kick, $04, $80, $08
	smpsLoop	0, 2, .1
	dc.b	TF4_Snare, $01, $80, $0B
	dc.b	TF4_Snare, $01, $80, $05
	dc.b	TF4_Snare, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_03:
	smpsPan		$C0, 0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A3, $0B, $80, $01
	smpsPan		$80, 0
	dc.b	$9C, $02, $80, $04
	dc.b	$9C, $80, $02
.0:
	dc.b	$9C, $0A, $80, $02
	dc.b	$9C, $80, $04
	dc.b	$9C, $80, $02
	smpsLoop	0, 2, .0
	dc.b	$9C, $0A, $80, $02
	smpsPan		$C0, 0
	dc.b	$A1, $0A, $80, $02
	dc.b	$A3, $0A, $80, $02
	smpsPan		$80, 0
	dc.b	$9C, $80, $04
	dc.b	$9C, $80, $02
.1:
	dc.b	$9C, $0A, $80, $02
	dc.b	$9C, $80, $04
	dc.b	$9C, $80, $02
	smpsLoop	0, 3, .1
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_04:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_05:
	smpsPan		$C0, 0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A8, $0B, $80, $01
	smpsPan		$40, 0
	dc.b	$9C, $02, $80, $04
	dc.b	$9C, $80, $02
.0:
	dc.b	$9C, $0A, $80, $02
	dc.b	$9C, $80, $04
	dc.b	$9C, $80, $02
	smpsLoop	0, 2, .0
	dc.b	$9C, $0A, $80, $02
	smpsPan		$C0, 0
	dc.b	$A6, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	smpsPan		$40, 0
	dc.b	$9C, $80, $04
	dc.b	$9C, $80, $02
.1:
	dc.b	$9C, $0A, $80, $02
	dc.b	$9C, $04, $80, $02
	dc.b	$9C, $04, $80, $02
	smpsLoop	0, 3, .1
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_06:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A8, $0A, $80, $02
	dc.b	$A3, $80, $04
	dc.b	$A1, $80, $02
	dc.b	$9C, $0B, $80, $01
	dc.b	$A6, $0A, $80, $02
	dc.b	$9F, $80, $04
	dc.b	$9E, $80, $02
	dc.b	$9C, $0A, $80, $02
	dc.b	$AA, $0B, $80, $01
	dc.b	$9C, $0B, $80, $01
	dc.b	$AB, $0A, $80, $02
	dc.b	$9C, $80, $04
	dc.b	$9C, $80, $02
	dc.b	$9C, $0B, $80, $01
	dc.b	$AD, $0A, $80, $02
	dc.b	$9C, $80, $04
	dc.b	$9C, $80, $02
	dc.b	$9C, $0A, $80, $02
	dc.b	$AF, $0B, $80, $01
	dc.b	$9C, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_07:
	smpsPan		$C0, 0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A4, $0A, $80, $02
	smpsPan		$80, 0
	dc.b	$A3, $80, $04
	dc.b	$A1, $80, $02
	dc.b	$9C, $0B, $80, $01
	smpsPan		$C0, 0
	dc.b	$A3, $0A, $80, $02
	smpsPan		$80, 0
	dc.b	$9F, $80, $04
	dc.b	$9E, $80, $02
	dc.b	$9C, $0A, $80, $02
	smpsPan		$C0, 0
	dc.b	$A6, $0B, $80, $01
	smpsPan		$80, 0
	dc.b	$9C, $0B, $80, $01
	smpsPan		$C0, 0
	dc.b	$AB, $0A, $80, $02
	smpsPan		$80, 0
	dc.b	$9C, $80, $04
	dc.b	$9C, $80, $02
	dc.b	$9C, $0B, $80, $01
	smpsPan		$C0, 0
	dc.b	$AA, $0A, $80, $02
	smpsPan		$80, 0
	dc.b	$9C, $80, $04
	dc.b	$9C, $80, $02
	dc.b	$9C, $0A, $80, $02
	smpsPan		$C0, 0
	dc.b	$AB, $0B, $80, $01
	smpsPan		$80, 0
	dc.b	$9C, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_08:
	smpsPan		$C0, 0
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A4, $0A, $80, $02
	smpsPan		$40, 0
	dc.b	$A3, $80, $04
	dc.b	$A1, $80, $02
	dc.b	$9C, $0B, $80, $01
	smpsPan		$C0, 0
	dc.b	$A3, $0A, $80, $02
	smpsPan		$40, 0
	dc.b	$9F, $80, $04
	dc.b	$9E, $80, $02
	dc.b	$9C, $0A, $80, $02
	smpsPan		$C0, 0
	dc.b	$A6, $0B, $80, $01
	smpsPan		$40, 0
	dc.b	$9C, $0B, $80, $01
	smpsPan		$C0, 0
	dc.b	$AB, $0A, $80, $02
	smpsPan		$40, 0
	dc.b	$9C, $80, $04
	dc.b	$9C, $80, $02
	dc.b	$9C, $0A, $80, $02
	smpsPan		$C0, 0
	dc.b	$AA, $0A, $80, $02
	smpsPan		$40, 0
	dc.b	$9C, $80, $04
	dc.b	$9C, $80, $02
	dc.b	$9C, $0A, $80, $02
	smpsPan		$C0, 0
	dc.b	$AB, $0B, $80, $01
	smpsPan		$40, 0
	dc.b	$9C, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_09:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_0A:
.0:
	dc.b	TF4_Kick, $01, $80, $0B
	dc.b	TF4_Kick, $01, $80, $05
	dc.b	TF4_Kick, $01, $80, $05
	dc.b	TF4_Snare, $01, $80, $0B
	dc.b	TF4_Kick, $01, $80, $05
	dc.b	TF4_Kick, $01, $80, $05
	smpsLoop	0, 4, .0
.1:
	dc.b	TF4_Snare, $01, $80, $0B
.2:
	dc.b	TF4_Kick, $04, $80, $02
	smpsLoop	1, 6, .2
	smpsLoop	0, 2, .1
.3:
	dc.b	TF4_Kick, $01, $80, $0B
	dc.b	TF4_Kick, $04, $80, $02
	dc.b	TF4_Kick, $04, $80, $02
	smpsLoop	0, 2, .3
	dc.b	TF4_Kick, $04, $80, $02
.4:
	dc.b	TF4_Snare, $01, $80, $05
	smpsLoop	0, 7, .4
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_0B:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$9C, $0A, $80, $02
	dc.b	$A3, $04, $80, $02
	dc.b	$A1, $04, $80, $02
	dc.b	$9C, $0A, $80, $02
	dc.b	$9A, $0A, $80, $02
	dc.b	$9F, $04, $80, $02
	dc.b	$9E, $04, $80, $02
	dc.b	$9C, $0A, $80, $02
	dc.b	$9E, $0A, $80, $02
	dc.b	$9C, $0A, $80, $02
	dc.b	$9F, $0A, $80, $02
	dc.b	$9C, $04, $80, $02
	dc.b	$9C, $04, $80, $02
	dc.b	$9C, $0A, $80, $02
	dc.b	$A1, $0A, $80, $02
	dc.b	$9C, $04, $80, $02
	dc.b	$9C, $04, $80, $02
	dc.b	$9C, $0A, $80, $02
	dc.b	$A3, $0A, $80, $02
	dc.b	$9C, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_0C:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A3, $0A, $80, $02
	dc.b	$A3, $04, $80, $02
	dc.b	$A3, $04, $80, $02
	smpsLoop	0, 4, .0
.1:
	dc.b	$9F, $0A, $80, $02
	dc.b	$9F, $04, $80, $02
	dc.b	$9F, $04, $80, $02
	smpsLoop	0, 2, .1
.2:
	dc.b	$9C, $0A, $80, $02
	dc.b	$9C, $04, $80, $02
	dc.b	$9C, $04, $80, $02
	smpsLoop	0, 2, .2
.3:
	dc.b	$A1, $0A, $80, $02
	dc.b	$A1, $04, $80, $02
	dc.b	$A1, $04, $80, $02
	smpsLoop	0, 4, .3
.4:
	dc.b	$9E, $0A, $80, $02
	dc.b	$9E, $04, $80, $02
	dc.b	$9E, $04, $80, $02
	smpsLoop	0, 2, .4
.5:
	dc.b	$9A, $0A, $80, $02
	dc.b	$9A, $04, $80, $02
	dc.b	$9A, $04, $80, $02
	smpsLoop	0, 2, .5
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_0D:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_0E:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$9C, $0A, $80, $02
	dc.b	$9C, $04, $80, $02
	dc.b	$9C, $04, $80, $02
	smpsLoop	0, 8, .0
.1:
	dc.b	$9A, $0A, $80, $02
	dc.b	$9A, $04, $80, $02
	dc.b	$9A, $04, $80, $02
	smpsLoop	0, 8, .1
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_0F:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $E7
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$AA, $5E, $80, $01
	dc.b	$FB, $01		; set portamento speed (SMPS/TS)
	dc.b	$AB, $0A, $80, $02
	dc.b	$9C, $80, $04
	dc.b	$9C, $80, $02
	dc.b	$A6, $0A, $80, $02
	dc.b	$9C, $80, $04
	dc.b	$9C, $80, $02
	dc.b	$A8, $08, $80, $04
	dc.b	$A3, $06, $E7
	dc.b	$AD, $04, $80, $02
	dc.b	$9F, $0A, $80, $02
	dc.b	$9C, $06, $E7
	dc.b	$A6, $04, $80, $02
	dc.b	$AB, $01, $E7
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$AD, $5E, $80, $01
	dc.b	$FB, $01		; set portamento speed (SMPS/TS)
	dc.b	$AD, $E7
	dc.b	$FB, $5A		; set portamento speed (SMPS/TS)
	dc.b	$AF, $2E, $80, $01
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$B2, $2E, $80, $02
	dc.b	$FB, $01		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_10:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_11:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$AA, $5E, $80, $02
.0:
	dc.b	$A6, $0A, $80, $02
	dc.b	$A6, $80, $04
	dc.b	$A6, $80, $02
	smpsLoop	0, 2, .0
.1:
	dc.b	$A3, $0A, $80, $02
	dc.b	$A3, $80, $04
	dc.b	$A3, $80, $02
	smpsLoop	0, 2, .1
	dc.b	$A8, $5E, $80, $02
.2:
	dc.b	$A7, $0A, $80, $02
	dc.b	$A7, $80, $04
	dc.b	$A7, $80, $02
	smpsLoop	0, 2, .2
.3:
	dc.b	$AD, $0A, $80, $02
	dc.b	$AD, $80, $04
	dc.b	$AD, $80, $02
	smpsLoop	0, 2, .3
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_12:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_13:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A6, $0B, $80, $01
	dc.b	$9C, $02, $80, $04
	dc.b	$9C, $80, $02
	dc.b	$9C, $0B, $80, $01
	dc.b	$9C, $02, $80, $04
	dc.b	$9C, $80, $02
	dc.b	$A8, $0B, $80, $01
	dc.b	$9C, $04, $80, $02
	dc.b	$9C, $04, $80, $02
	dc.b	$9C, $0B, $80, $01
	dc.b	$9C, $02, $80, $04
	dc.b	$9C, $80, $02
	smpsLoop	0, 2, .0
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_14:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A6, $0B, $80, $01
	dc.b	$9C, $02, $80, $04
	dc.b	$9C, $80, $02
	dc.b	$9C, $0B, $80, $01
	dc.b	$9C, $02, $80, $04
	dc.b	$9C, $80, $02
	dc.b	$A8, $0B, $80, $01
	dc.b	$9C, $04, $80, $02
	dc.b	$9C, $04, $80, $02
	dc.b	$9C, $0B, $80, $01
	dc.b	$9C, $02, $80, $04
	dc.b	$9C, $80, $02
	dc.b	$A6, $0B, $80, $01
	dc.b	$9C, $02, $80, $04
	dc.b	$9C, $80, $02
	dc.b	$9C, $0B, $80, $01
	dc.b	$9C, $02, $80, $04
	dc.b	$9C, $80, $02
	dc.b	$A8, $0B, $80, $01
	dc.b	$AF, $22, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_15:
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$9C, $0A, $80, $02
	dc.b	$9C, $04, $80, $02
	dc.b	$9C, $04, $80, $02
	smpsLoop	0, 14, .0
	dc.b	$9C, $0A, $80, $02
	dc.b	$A3, $22, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_16:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_17:
.0:
	dc.b	TF4_Kick, $01, $80, $0B
	dc.b	TF4_Kick, $01, $80, $05
	dc.b	TF4_Kick, $01, $80, $05
	dc.b	TF4_Snare, $01, $80, $0B
	dc.b	TF4_Kick, $01, $80, $05
	dc.b	TF4_Kick, $01, $80, $05
	smpsLoop	0, 23, .0
	dc.b	TF4_SnareLo, $01, $80, $0B
	dc.b	TF4_Snare, $01, $80, $17
	dc.b	TF4_Kick, $01, $80, $05
	dc.b	TF4_Kick, $01, $80, $05
	smpsReturn


; ---------------------------------------------------------------
TF4_Pattern_18:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A6, $2E, $80, $02
	dc.b	$A6, $2E, $80, $02
	dc.b	$A6, $16, $80, $02
	dc.b	$A6, $16, $80, $02
.0:
	dc.b	$9A, $04, $80, $02
	smpsLoop	0, 8, .0
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_19:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_1A:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_1B:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A3, $0B, $80, $01
	dc.b	$9C, $02, $80, $04
	dc.b	$9C, $80, $02
.0:
	dc.b	$9C, $0A, $80, $02
	dc.b	$9C, $80, $04
	dc.b	$9C, $80, $02
	smpsLoop	0, 2, .0
	dc.b	$9C, $0A, $80, $02
	dc.b	$A1, $0A, $80, $02
	dc.b	$A3, $0A, $80, $02
	dc.b	$9C, $80, $04
	dc.b	$9C, $80, $02
.1:
	dc.b	$9C, $0A, $80, $02
	dc.b	$9C, $80, $04
	dc.b	$9C, $80, $02
	smpsLoop	0, 3, .1
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_1C:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_1D:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A1, $2E, $80, $02
	dc.b	$A1, $2E, $80, $02
	dc.b	$A1, $16, $80, $02
	dc.b	$A1, $16, $80, $02
.0:
	dc.b	$A1, $04, $80, $02
	smpsLoop	0, 8, .0
	smpsReturn

; ---------------------------------------------------------------
TF4_Pattern_1E:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$9E, $2E, $80, $02
	dc.b	$9E, $2E, $80, $02
	dc.b	$9E, $16, $80, $02
	dc.b	$9E, $16, $80, $02
.0:
	dc.b	$A1, $04, $80, $02
	smpsLoop	0, 8, .0
	smpsReturn

; ---------------------------------------------------------------
; TF4_Voices
; ---------------------------------------------------------------

TF4_Voices:
	; Voice $00 (TF4_FM)
	dc.b	$F8, $53, $51, $51, $51, $DF, $DF, $1F, $1F, $07, $0E, $07, $84, $04, $03, $03, $08, $F7, $31, $71, $61, $1B, $11, $10, $00
	; Voice $01 (TF4_FM)
	dc.b	$EB, $3E, $51, $50, $50, $DF, $DF, $1B, $1F, $07, $0E, $07, $04, $07, $01, $01, $01, $54, $55, $F6, $72, $1F, $1C, $17, $00
	; Voice $02 (TF4_FM)
	dc.b	$E8, $33, $53, $70, $30, $DF, $DC, $1F, $1F, $14, $05, $01, $81, $00, $01, $00, $1D, $11, $21, $10, $F8, $0E, $1B, $12, $00
	; Voice $03 (TF4_FM)
	dc.b	$FE, $3F, $50, $30, $50, $1F, $1F, $1F, $1D, $01, $00, $00, $01, $02, $00, $15, $0B, $02, $07, $F1, $11, $00, $00, $00, $00
	; Voice $04 (TF4_FM)
	dc.b	$EC, $00, $00, $00, $00, $18, $1A, $1A, $1A, $1A, $00, $17, $00, $1F, $00, $1F, $00, $FF, $05, $FF, $05, $00, $00, $14, $00
