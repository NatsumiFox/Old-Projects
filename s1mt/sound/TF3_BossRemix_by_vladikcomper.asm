
; ---------------------------------------------------------------
; Created by Techosoft-2-SMPS v.2.70
; 2014, Vladikcomper
; ---------------------------------------------------------------
TF3:

; ---------------------------------------------------------------
; Music Header
; ---------------------------------------------------------------

	dc.w	TF3_Voices-TF3			; Voice bank offset
	dc.w	$8700			; Number of TF3_FM/PSG channels
	dc.w	$0100			; Tempo modifier

	dc.w	$0008, $F200		; Disable DAC channel 
	dc.w	TF3_FM1-TF3, $0059+2
	dc.w	TF3_FM2-TF3, $0049+2
	dc.w	TF3_FM3-TF3, $005B+2
	dc.w	TF3_FM4-TF3, $004D+2
	dc.w	TF3_FM5-TF3, $0049+2
	dc.w	TF3_FM6-TF3, $004D+2

; ---------------------------------------------------------------
; Music Tracks
; ---------------------------------------------------------------

TF3_FM1:
	smpsFMvoice	$03
	smpsCall	TF3_Pattenr_00
	smpsCall	TF3_Pattenr_05
.Loop:
	smpsCall	TF3_Pattenr_07
	smpsCall	TF3_Pattenr_07
	smpsCall	TF3_Pattenr_09
	smpsCall	TF3_Pattenr_07
	smpsCall	TF3_Pattenr_07
	smpsCall	TF3_Pattenr_0B
	smpsCall	TF3_Pattenr_0D
	smpsCall	TF3_Pattenr_1F
	smpsCall	TF3_Pattenr_1F
	smpsCall	TF3_Pattenr_26
	smpsJump	.Loop

; ---------------------------------------------------------------
TF3_FM2:
	dc.b	$E1, $01		; set note shift (SMPS/TS)
	smpsFMvoice	$07
	smpsCall	TF3_Pattenr_01
	smpsCall	TF3_Pattenr_04
.Loop:
	smpsCall	TF3_Pattenr_08
	smpsCall	TF3_Pattenr_08
	smpsCall	TF3_Pattenr_0A
	smpsCall	TF3_Pattenr_08
	smpsCall	TF3_Pattenr_08
	smpsCall	TF3_Pattenr_0C
	smpsCall	TF3_Pattenr_2A
	smpsCall	TF3_Pattenr_08
	smpsCall	TF3_Pattenr_08
	smpsCall	TF3_Pattenr_2B
	smpsJump	.Loop

; ---------------------------------------------------------------
TF3_FM3:
	dc.b	$FA, $03		; setup portamento mode 3 (advanced SMPS only!)
	dc.b	$FB, $28		; set portamento speed (SMPS/TS)
	smpsFMvoice	$08
	smpsCall	TF3_Pattenr_02
	smpsCall	TF3_Pattenr_06
	dc.b	$E6, -$E

	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	smpsFMvoice	$01
.Loop:        
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
	smpsCall	TF3_Pattenr_14
	smpsCall	TF3_Pattenr_14
	smpsCall	TF3_Pattenr_1D
	smpsCall	TF3_Pattenr_14
	smpsCall	TF3_Pattenr_14
	smpsCall	TF3_Pattenr_1E
	smpsCall	TF3_Pattenr_2C
	smpsCall	TF3_Pattenr_2F
	smpsCall	TF3_Pattenr_30
	smpsJump	.Loop

; ---------------------------------------------------------------
TF3_FM4:
	dc.b	$FA, $00		; setup portamento mode 0 (advanced SMPS only!)
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	smpsFMvoice	$01
	smpsCall	TF3_Pattenr_12
	dc.b	$E6, $E

	dc.b	$FA, $03		; setup portamento mode 3 (advanced SMPS only!)
	dc.b	$FB, $28		; set portamento speed (SMPS/TS)
	smpsFMvoice	$08
.Loop:
	smpsCall	TF3_Pattenr_0E
	smpsCall	TF3_Pattenr_0E
	smpsCall	TF3_Pattenr_0F
	smpsCall	TF3_Pattenr_0E
	smpsCall	TF3_Pattenr_0E
	smpsCall	TF3_Pattenr_10
	smpsCall	TF3_Pattenr_22
	smpsCall	TF3_Pattenr_24
	smpsCall	TF3_Pattenr_24
	smpsCall	TF3_Pattenr_25
	smpsJump	.Loop

; ---------------------------------------------------------------
TF3_FM5:
	dc.b	$E1, $FF		; set note shift (SMPS/TS)
	smpsFMvoice	$00
	smpsCall	TF3_Pattenr_01
	smpsCall	TF3_Pattenr_04
.Loop:
	smpsCall	TF3_Pattenr_08
	smpsCall	TF3_Pattenr_08
	smpsCall	TF3_Pattenr_0A
	smpsCall	TF3_Pattenr_08
	smpsCall	TF3_Pattenr_08
	smpsCall	TF3_Pattenr_0C
	smpsCall	TF3_Pattenr_2A
	smpsCall	TF3_Pattenr_08
	smpsCall	TF3_Pattenr_08
	smpsCall	TF3_Pattenr_2B
	smpsJump	.Loop

; ---------------------------------------------------------------
TF3_FM6:
	dc.b	$FA, $00		; setup portamento mode 0 (advanced SMPS only!)
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	smpsFMvoice	$01
	smpsCall	TF3_Pattenr_13
.Loop:
	dc.b	$E6, $FC		; alter note volume (SMPS/TS)
	dc.b	$E1, $04		; set note shift (SMPS/TS)
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
	smpsCall	TF3_Pattenr_14
	smpsCall	TF3_Pattenr_14
	smpsCall	TF3_Pattenr_1D
	smpsCall	TF3_Pattenr_14
	smpsCall	TF3_Pattenr_14
	smpsCall	TF3_Pattenr_1E
	smpsCall	TF3_Pattenr_2C
	smpsCall	TF3_Pattenr_2E
	smpsCall	TF3_Pattenr_32
	smpsJump	.Loop

; ---------------------------------------------------------------
; TF3_Pattenrs
; ---------------------------------------------------------------

TF3_Pattenr_00:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $0A, $80, $02
	dc.b	$B0, $0A, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$B0, $0A, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$B0, $0A, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$B0, $0A, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$B0, $0A, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$B0, $0A, $80, $02
	dc.b	$A2, $0A, $80, $02
	dc.b	$AE, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_01:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $16, $80, $02
	dc.b	$A7, $0A, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A9, $0A, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$AB, $16, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$A4, $16, $80, $02
	dc.b	$A7, $0A, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A9, $0A, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$AB, $0A, $80, $02
	dc.b	$A2, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_02:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A1, $01, $80, $05
	dc.b	$95, $01, $80, $05
	dc.b	$95, $01, $80, $05
	dc.b	$95, $01, $80, $05
	dc.b	$AD, $01, $80, $05
	dc.b	$95, $01, $80, $05
	dc.b	$95, $01, $80, $05
	dc.b	$95, $01, $80, $05
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_03:
	; This TF3_Pattenr is unused
	; This TF3_Pattenr is undefined
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_04:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $16, $80, $02
	dc.b	$A7, $0A, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A9, $0A, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$AB, $16, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$A4, $16, $80, $02
	dc.b	$A7, $0A, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$B0, $0A, $80, $02
	dc.b	$AE, $0A, $80, $02
	dc.b	$AB, $0A, $80, $02
	dc.b	$A9, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_05:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $0A, $80, $02
	dc.b	$B0, $0A, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$B0, $0A, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$B0, $0A, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$B0, $0A, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$B0, $0A, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$B0, $0A, $80, $02
	dc.b	$AE, $0A, $80, $02
	dc.b	$AB, $0A, $80, $02
	dc.b	$A9, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_06:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A1, $01, $80, $05
	dc.b	$95, $01, $80, $05
	dc.b	$95, $01, $80, $05
	dc.b	$95, $01, $80, $05
	dc.b	$AD, $01, $80, $05
	dc.b	$95, $01, $80, $05
	dc.b	$95, $01, $80, $05
	dc.b	$95, $01, $80, $05
	smpsLoop	0, 3, .0
	dc.b	$A1, $01, $80, $05
.1:
	dc.b	$AD, $01, $80, $05
	smpsLoop	0, 7, .1
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_07:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $04, $80, $02
	dc.b	$B0, $04, $80, $02
	smpsLoop	0, 4, .0
.1:
	dc.b	$A2, $04, $80, $02
	dc.b	$AE, $04, $80, $02
	smpsLoop	0, 4, .1
.2:
	dc.b	$A0, $04, $80, $02
	dc.b	$AC, $04, $80, $02
	smpsLoop	0, 4, .2
.3:
	dc.b	$9F, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	smpsLoop	0, 4, .3
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_08:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $2E, $80, $02
	dc.b	$A2, $2E, $80, $02
	dc.b	$A0, $2E, $80, $02
	dc.b	$9F, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_09:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9D, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	smpsLoop	0, 8, .0
.1:
	dc.b	$9F, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	smpsLoop	0, 8, .1
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_0A:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9D, $5E, $80, $02
	dc.b	$9F, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_0B:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9D, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	smpsLoop	0, 4, .0
.1:
	dc.b	$9F, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	smpsLoop	0, 4, .1
.2:
	dc.b	$98, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	smpsLoop	0, 8, .2
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_0C:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9D, $2E, $80, $02
	dc.b	$9F, $2E, $80, $02
	dc.b	$98, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_0D:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A2, $04, $80, $02
	dc.b	$A2, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$A2, $04, $80, $02
	dc.b	$A7, $04, $80, $02
	dc.b	$A2, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A2, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A2, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A2, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$A2, $04, $80, $02
	dc.b	$AE, $04, $80, $02
	dc.b	$A2, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A7, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A7, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$AC, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A7, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$AC, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A7, $04, $80, $02
	dc.b	$A7, $04, $80, $02
	dc.b	$AE, $04, $80, $02
	dc.b	$A7, $04, $80, $02
	dc.b	$AC, $04, $80, $02
	dc.b	$A7, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$A7, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$AE, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$AC, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_0E:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A1, $01, $80, $05
	dc.b	$95, $01, $80, $05
	dc.b	$AD, $01, $80, $05
	dc.b	$95, $01, $80, $05
	smpsLoop	0, 8, .0
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_0F:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A1, $01, $80, $05
	dc.b	$95, $01, $80, $05
	dc.b	$AD, $01, $80, $05
	dc.b	$95, $01, $80, $05
	smpsLoop	0, 7, .0
.1:
	dc.b	$AD, $01, $80, $05
	dc.b	$95, $01, $80, $05
	smpsLoop	0, 2, .1
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_10:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A1, $01, $80, $05
	dc.b	$95, $01, $80, $05
	dc.b	$AD, $01, $80, $05
	dc.b	$95, $01, $80, $05
	smpsLoop	0, 6, .0
	smpsPan		$80, 0
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B0, $01, $80, $03
	dc.b	$B0, $01, $80, $03
	dc.b	$B0, $01, $80, $03
	smpsPan		$C0, 0
	dc.b	$FC, $5C			; set note volume (advanced SMPS only!)
	dc.b	$AF, $01, $80, $05
	dc.b	$AF, $01, $80, $05
	smpsPan		$40, 0
	dc.b	$FC, $5E			; set note volume (advanced SMPS only!)
	dc.b	$AD, $01, $80, $03
	dc.b	$AD, $01, $80, $03
	dc.b	$AD, $01, $80, $03
	smpsPan		$C0, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $0B
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_11:
	; This TF3_Pattenr is unused
	; This TF3_Pattenr is undefined
	smpsReturn

;	011#010110#010110#010110#010110
; ---------------------------------------------------------------
TF3_Pattenr_12:
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$E2, $FF			; set frequency fuck bits (SMPS/TS)
	dc.b	$A4, $60, $E7
	dc.b	$A7, $E7
	dc.b	$AB, $E7
	dc.b	$B0, $5E, $80, $02
	dc.b	$E2, $00			; set frequency fuck bits (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_13:
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$E2, $FF			; set frequency fuck bits (SMPS/TS)
	dc.b	$AB, $60, $E7
	dc.b	$B0, $E7
	dc.b	$B3, $E7
	dc.b	$B7, $E7
	dc.b	$B7, $01, $80, $02
	dc.b	$E2, $00			; set frequency fuck bits (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_14:
	smpsFMvoice	$05
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$A7, $04, $80, $02
	dc.b	$A7, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A2, $04, $80, $02
	dc.b	$A2, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	smpsLoop	0, 2, .0
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_15:
	; This TF3_Pattenr is unused
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B0, $04, $80, $02
	smpsLoop	0, 8, .0
.1:
	dc.b	$AF, $04, $80, $02
	smpsLoop	0, 8, .1
.2:
	dc.b	$AE, $04, $80, $02
	smpsLoop	0, 8, .2
.3:
	dc.b	$AD, $04, $80, $02
	smpsLoop	0, 8, .3
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_16:
	; This TF3_Pattenr is unused
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B7, $04, $80, $02
	smpsLoop	0, 8, .0
.1:
	dc.b	$B6, $04, $80, $02
	smpsLoop	0, 8, .1
.2:
	dc.b	$B5, $04, $80, $02
	smpsLoop	0, 8, .2
.3:
	dc.b	$B4, $04, $80, $02
	smpsLoop	0, 8, .3
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_17:
	; This TF3_Pattenr is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B3, $2E, $80, $02
	dc.b	$B2, $2E, $80, $02
	dc.b	$B0, $2E, $80, $02
	dc.b	$AE, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_18:
	; This TF3_Pattenr is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B7, $2E, $80, $02
	dc.b	$B5, $2E, $80, $02
	dc.b	$B3, $2E, $80, $02
	dc.b	$B2, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_19:
	; This TF3_Pattenr is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AC, $5E, $80, $02
	dc.b	$AF, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_1A:
	; This TF3_Pattenr is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B0, $5E, $80, $02
	dc.b	$B2, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_1B:
	; This TF3_Pattenr is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B0, $2E, $80, $02
	dc.b	$B2, $2E, $80, $02
	dc.b	$AB, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_1C:
	; This TF3_Pattenr is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AC, $2E, $80, $02
	dc.b	$AF, $2E, $80, $02
	dc.b	$A7, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_1D:
	smpsFMvoice	$06
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B5, $04, $80, $02
	dc.b	$B8, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	smpsLoop	0, 5, .0
	dc.b	$C1, $04, $80, $02
.1:
	dc.b	$B5, $04, $80, $02
	dc.b	$BB, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	smpsLoop	0, 5, .1
	dc.b	$C3, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_1E:
	smpsFMvoice	$06
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B5, $04, $80, $02
	dc.b	$B8, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	smpsLoop	0, 2, .0
	dc.b	$C1, $04, $80, $02
	dc.b	$C4, $04, $80, $02
.1:
	dc.b	$B5, $04, $80, $02
	dc.b	$BB, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	smpsLoop	0, 2, .1
	dc.b	$C3, $04, $80, $02
	dc.b	$C7, $04, $80, $02
.2:
	dc.b	$C8, $04, $80, $02
	dc.b	$CB, $04, $80, $02
	dc.b	$CF, $04, $80, $02
	smpsLoop	0, 5, .2
	dc.b	$D4, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_1F:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$B0, $04, $80, $02
.0:
	dc.b	$A4, $04, $80, $02
	smpsLoop	0, 7, .0
	dc.b	$AE, $04, $80, $02
.1:
	dc.b	$A4, $04, $80, $02
	smpsLoop	0, 7, .1
	dc.b	$AC, $04, $80, $02
.2:
	dc.b	$A4, $04, $80, $02
	smpsLoop	0, 7, .2
	dc.b	$AB, $04, $80, $02
.3:
	dc.b	$A4, $04, $80, $02
	smpsLoop	0, 5, .3
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_20:
	; This TF3_Pattenr is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $5E, $80, $02
	dc.b	$B3, $5E, $80, $02
	dc.b	$B5, $5E, $80, $02
	dc.b	$B7, $2E, $80, $02
	dc.b	$B8, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_21:
	; This TF3_Pattenr is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B5, $5E, $80, $02
	dc.b	$B7, $5E, $80, $02
	dc.b	$B8, $5E, $80, $02
	dc.b	$BA, $2E, $80, $02
	dc.b	$BC, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_22:
.0:
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A1, $01, $80, $05
	dc.b	$95, $01, $80, $05
	dc.b	$AD, $01, $80, $05
	dc.b	$95, $01, $80, $05
	smpsLoop	1, 3, .1
	dc.b	$AD, $01, $80, $05
	dc.b	$AD, $01, $80, $05
	dc.b	$AD, $01, $80, $05
	dc.b	$AD, $01, $80, $05
	smpsLoop	0, 3, .0
.2:
	dc.b	$A1, $01, $80, $05
	dc.b	$95, $01, $80, $05
	dc.b	$AD, $01, $80, $05
	dc.b	$95, $01, $80, $05
	smpsLoop	0, 2, .2
	smpsPan		$80, 0
.3:
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B0, $01, $80, $05
	smpsLoop	0, 4, .3
	smpsPan		$40, 0
.4:
	dc.b	$AD, $01, $80, $05
	smpsLoop	0, 4, .4
	smpsPan		$C0, 0
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_23:
	; This TF3_Pattenr is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B3, $2E, $80, $02
	dc.b	$B2, $2E, $80, $02
	dc.b	$B0, $2E, $80, $02
	dc.b	$AF, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_24:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A1, $01, $80, $05
	dc.b	$95, $01, $80, $05
	dc.b	$AD, $01, $80, $05
	dc.b	$95, $01, $80, $05
	smpsLoop	0, 7, .0
	dc.b	$A1, $01, $80, $05
	dc.b	$AD, $01, $80, $05
	dc.b	$A1, $01, $80, $05
	dc.b	$AD, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_25:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A1, $01, $80, $05
	dc.b	$95, $01, $80, $05
	dc.b	$AD, $01, $80, $05
	dc.b	$95, $01, $80, $05
	smpsLoop	0, 4, .0
.1:
	dc.b	$AD, $01, $80, $05
	smpsLoop	0, 8, .1
	smpsPan		$80, 0
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B0, $01, $80, $05
	dc.b	$B0, $01, $80, $05
	smpsPan		$C0, 0
	dc.b	$FC, $5C			; set note volume (advanced SMPS only!)
	dc.b	$AF, $01, $80, $05
	dc.b	$AF, $01, $80, $05
	smpsPan		$40, 0
	dc.b	$FC, $5E			; set note volume (advanced SMPS only!)
	dc.b	$AD, $01, $80, $05
	dc.b	$AD, $01, $80, $05
	smpsPan		$C0, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_26:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$B0, $04, $80, $02
.1:
	dc.b	$A4, $04, $80, $02
	smpsLoop	1, 5, .1
	smpsLoop	0, 3, .0
	dc.b	$A4, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$AE, $04, $80, $02
	dc.b	$AC, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$A9, $04, $80, $02
	dc.b	$A7, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_27:
	; This TF3_Pattenr is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B3, $2E, $80, $02
	dc.b	$B7, $2E, $80, $02
	dc.b	$BC, $2E, $80, $02
	dc.b	$BF, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_28:
	; This TF3_Pattenr is unused
	; This TF3_Pattenr is undefined
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_29:
	; This TF3_Pattenr is unused
	; This TF3_Pattenr is undefined
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_2A:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A2, $5E, $80, $02
	dc.b	$A4, $5E, $80, $02
	dc.b	$A6, $5E, $80, $02
	dc.b	$A7, $2E, $80, $02
	dc.b	$A9, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_2B:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $2E, $80, $02
	dc.b	$A7, $2E, $80, $02
	dc.b	$A4, $2E, $80, $02
	dc.b	$A2, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_2C:
	smpsFMvoice	$04
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B5, $10, $80, $02
	dc.b	$B7, $10, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$BA, $10, $80, $02
	dc.b	$B8, $10, $80, $02
	dc.b	$B5, $0A, $80, $02
	dc.b	$B7, $10, $80, $02
	dc.b	$B8, $10, $80, $02
	dc.b	$BA, $0A, $80, $02
	dc.b	$BC, $10, $80, $02
	dc.b	$BA, $10, $80, $02
	dc.b	$B7, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_2D:
	; This TF3_Pattenr is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B7, $2E, $80, $02
	dc.b	$BC, $2E, $80, $02
	dc.b	$BF, $2E, $80, $02
	dc.b	$C3, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_2E:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B8, $10, $80, $02
	dc.b	$BA, $10, $80, $02
	dc.b	$BC, $0A, $80, $02
	dc.b	$BE, $10, $80, $02
	dc.b	$BF, $10, $80, $02
	dc.b	$BE, $0A, $80, $02
	dc.b	$BF, $2E, $80, $02
	dc.b	$C1, $2A, $80, $03
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_2F:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B8, $10, $80, $02
	dc.b	$BA, $10, $80, $02
	dc.b	$BC, $0A, $80, $02
	dc.b	$BE, $10, $80, $02
	dc.b	$BF, $10, $80, $02
	dc.b	$BE, $0A, $80, $02
	dc.b	$BF, $2E, $80, $02
	dc.b	$C1, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_30:
	smpsFMvoice	$02
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B0, $04, $80, $02
	dc.b	$B3, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	smpsLoop	0, 2, .0
	dc.b	$B0, $04, $80, $02
	dc.b	$B3, $04, $80, $02
.1:
	dc.b	$AE, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$B5, $04, $80, $02
	smpsLoop	0, 2, .1
	dc.b	$AE, $04, $80, $02
	dc.b	$B2, $04, $80, $02
.2:
	dc.b	$AC, $04, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$B3, $04, $80, $02
	smpsLoop	0, 2, .2
	dc.b	$AC, $04, $80, $02
	dc.b	$B0, $04, $80, $02
.3:
	dc.b	$AB, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	smpsLoop	0, 2, .3
	dc.b	$AB, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$B3, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	dc.b	$BF, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$B3, $04, $80, $02
	dc.b	$AE, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$B5, $04, $80, $02
	dc.b	$BA, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$BA, $04, $80, $02
	dc.b	$B5, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$AC, $04, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$B3, $04, $80, $02
	dc.b	$B8, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	dc.b	$B8, $04, $80, $02
	dc.b	$B3, $04, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$B5, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$BB, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$C1, $04, $80, $02
.4:
	dc.b	$B0, $04, $80, $02
	dc.b	$B3, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	smpsLoop	0, 5, .4
	dc.b	$BA, $04, $80, $02
	dc.b	$BC, $30, $E7
	dc.b	$BA, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_31:
	; This TF3_Pattenr is unused
	; This TF3_Pattenr is undefined
	smpsReturn

; ---------------------------------------------------------------
TF3_Pattenr_32:
	smpsFMvoice	$02
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
.0:
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$B3, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	smpsLoop	0, 2, .0
	dc.b	$B3, $04, $80, $02
	dc.b	$B7, $04, $80, $02
.1:
	dc.b	$B2, $04, $80, $02
	dc.b	$B5, $04, $80, $02
	dc.b	$BA, $04, $80, $02
	smpsLoop	0, 2, .1
	dc.b	$B2, $04, $80, $02
	dc.b	$B5, $04, $80, $02
.2:
	dc.b	$B0, $04, $80, $02
	dc.b	$B3, $04, $80, $02
	dc.b	$B8, $04, $80, $02
	smpsLoop	0, 2, .2
	dc.b	$B0, $04, $80, $02
	dc.b	$B3, $04, $80, $02
.3:
	dc.b	$AF, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	smpsLoop	0, 2, .3
	dc.b	$AF, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$B3, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	dc.b	$BF, $04, $80, $02
	dc.b	$C3, $04, $80, $02
	dc.b	$BF, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$B5, $04, $80, $02
	dc.b	$BA, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$C1, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$BA, $04, $80, $02
	dc.b	$B5, $04, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$B3, $04, $80, $02
	dc.b	$B8, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	dc.b	$BF, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	dc.b	$B8, $04, $80, $02
	dc.b	$B3, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$B5, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$BB, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$C3, $04, $80, $02
	dc.b	$C7, $04, $80, $02
.4:
	dc.b	$B3, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	smpsLoop	0, 5, .4
	dc.b	$BF, $04, $80, $02
	dc.b	$BF, $30, $E7
	dc.b	$BE, $33
	smpsReturn

; ---------------------------------------------------------------
; TF3_Voices
; ---------------------------------------------------------------

TF3_Voices:
	; Voice $00 (TF3_FM)
	dc.b	$28, $03, $0F, $17, $51, $1F, $12, $1F, $1F, $04, $01, $04, $0C, $01, $01, $01, $00, $10, $19, $10, $17, $0A, $17, $1B, $00
	; Voice $01 (TF3_FM)
	dc.b	$2C, $32, $32, $51, $52, $1F, $12, $1F, $1F, $07, $00, $07, $00, $00, $00, $00, $00, $10, $06, $00, $06, $1E, $00, $0D, $01
	; Voice $02 (TF3_FM)
	dc.b	$18, $01, $01, $51, $31, $1F, $1F, $1F, $1F, $02, $03, $04, $04, $01, $02, $03, $03, $20, $20, $20, $26, $16, $20, $14, $00
	; Voice $03 (TF3_FM)
	dc.b	$3A, $00, $0F, $00, $01, $1F, $97, $1F, $1F, $0F, $12, $05, $0D, $08, $08, $07, $07, $26, $46, $16, $56, $21, $14, $28, $00
	; Voice $04 (TF3_FM)
	dc.b	$20, $01, $01, $51, $31, $1F, $1F, $1F, $1F, $0A, $03, $04, $04, $01, $02, $03, $03, $20, $20, $20, $28, $1E, $26, $10, $00
	; Voice $05 (TF3_FM)
	dc.b	$2C, $32, $32, $52, $54, $1F, $1F, $1F, $1F, $0F, $07, $0B, $07, $04, $04, $04, $04, $A7, $F7, $B7, $F7, $0F, $00, $09, $00
	; Voice $06 (TF3_FM)
	dc.b	$36, $5A, $32, $71, $10, $1F, $1F, $59, $1C, $10, $0A, $04, $04, $07, $00, $02, $02, $A5, $57, $55, $55, $1E, $00, $00, $00
	; Voice $07 (TF3_FM)
	dc.b	$28, $03, $0F, $31, $35, $1F, $12, $1F, $1F, $02, $03, $02, $0E, $01, $01, $01, $01, $10, $19, $10, $18, $06, $17, $1C, $00
	; Voice $08 (TF3_FM)
	dc.b	$3E, $0F, $02, $01, $01, $1F, $1F, $1F, $1F, $00, $11, $0F, $0F, $00, $0F, $0E, $0E, $00, $19, $58, $58, $00, $00, $00, $00