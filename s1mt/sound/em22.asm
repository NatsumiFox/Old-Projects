
; ---------------------------------------------------------------
; Created by Techosoft-2-SMPS v.2.70
; 2014, Vladikcomper
; ---------------------------------------------------------------
em22:

; ---------------------------------------------------------------
; Music Header
; ---------------------------------------------------------------

	dc.w	em22_Voices-em22			; Voice bank offset
	dc.w	$8700			; Number of em22_FM/PSG channels
	dc.w	$0100			; Tempo modifier

	dc.w	$0008, $F200		; Disable DAC channel
	dc.w	em22_FM1-em22, $005A
	dc.w	em22_FM2-em22, $0054
	dc.w	em22_FM3-em22, $0050
	dc.w	em22_FM4-em22, $0059
	dc.w	em22_FM5-em22, $004E
	dc.w	em22_FM6-em22, $004B

; ---------------------------------------------------------------
; Music Tracks
; ---------------------------------------------------------------

em22_FM1:
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
	dc.b	$FB, $60		; set portamento speed (SMPS/TS)
	smpsPan		$80, 0
	smpsFMvoice	$00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_00
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_0A
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_0A
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_0A
	smpsCall	em22_Pat_00
	smpsCall	em22_Pat_0A
	smpsFMvoice	$04
	dc.b	$E6, $F7		; alter note volume (SMPS/TS)
	smpsCall	em22_Pat_23
	smpsCall	em22_Pat_28
	smpsCall	em22_Pat_23
	smpsCall	em22_Pat_29
	smpsPan		$C0, 0
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsFMvoice	$00
	dc.b	$E6, $04		; alter note volume (SMPS/TS)
	smpsCall	em22_Pat_1F
	smpsCall	em22_Pat_22
	smpsStop

; ---------------------------------------------------------------
em22_FM2:
	smpsFMvoice	$01
	smpsCall	em22_Pat_01
	smpsCall	em22_Pat_02
	smpsCall	em22_Pat_03
	smpsCall	em22_Pat_01
	smpsCall	em22_Pat_01
	smpsCall	em22_Pat_02
	smpsCall	em22_Pat_03
	smpsCall	em22_Pat_05
	smpsCall	em22_Pat_01
	smpsCall	em22_Pat_02
	smpsCall	em22_Pat_03
	smpsCall	em22_Pat_01
	smpsCall	em22_Pat_01
	smpsCall	em22_Pat_02
	smpsCall	em22_Pat_03
	smpsCall	em22_Pat_05
	smpsCall	em22_Pat_07
	smpsCall	em22_Pat_08
	smpsCall	em22_Pat_07
	smpsCall	em22_Pat_09
	smpsCall	em22_Pat_07
	smpsCall	em22_Pat_08
	smpsCall	em22_Pat_07
	smpsCall	em22_Pat_09
	smpsCall	em22_Pat_12
	smpsCall	em22_Pat_24
	smpsCall	em22_Pat_12
	smpsCall	em22_Pat_25
	smpsCall	em22_Pat_37
	smpsStop

; ---------------------------------------------------------------
em22_FM3:
;	dc.b	$F1			; unsupported coordination flag
;	dc.b	$E4, $18		; unsupported coordination flag
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
	dc.b	$FB, $60		; set portamento speed (SMPS/TS)
	smpsFMvoice	$02
	smpsCall	em22_Pat_15
	smpsCall	em22_Pat_16
	smpsCall	em22_Pat_15
	smpsCall	em22_Pat_17
	smpsCall	em22_Pat_15
	smpsCall	em22_Pat_16
	smpsCall	em22_Pat_15
	smpsCall	em22_Pat_17
	dc.b	$E6, $06		; alter note volume (SMPS/TS)
	smpsCall	em22_Pat_18
	smpsCall	em22_Pat_19
	smpsCall	em22_Pat_18
	smpsCall	em22_Pat_19
	smpsFMvoice	$05
	dc.b	$E6, $03		; alter note volume (SMPS/TS)
	smpsCall	em22_Pat_2A
	smpsCall	em22_Pat_2C
	smpsStop

; ---------------------------------------------------------------
em22_FM4:
	dc.b	$FA, $03		; setup portamento mode 3 (advanced SMPS only!)
	dc.b	$FB, $1E		; set portamento speed (SMPS/TS)
	smpsCall	em22_Pat_0B
	smpsCall	em22_Pat_0C
	smpsCall	em22_Pat_0B
	smpsCall	em22_Pat_0D
	smpsCall	em22_Pat_0B
	smpsCall	em22_Pat_0C
	smpsCall	em22_Pat_0B
	smpsCall	em22_Pat_3D
	smpsCall	em22_Pat_0B
	smpsCall	em22_Pat_0C
	smpsCall	em22_Pat_0B
	smpsCall	em22_Pat_0D
	smpsCall	em22_Pat_0B
	smpsCall	em22_Pat_0C
	smpsCall	em22_Pat_0B
	smpsCall	em22_Pat_0E
	smpsCall	em22_Pat_0F
	smpsCall	em22_Pat_10
	smpsCall	em22_Pat_0F
	smpsCall	em22_Pat_10
	smpsCall	em22_Pat_0F
	smpsCall	em22_Pat_10
	smpsCall	em22_Pat_0F
	smpsCall	em22_Pat_11
	smpsCall	em22_Pat_13
	smpsCall	em22_Pat_13
	smpsCall	em22_Pat_14
;	dc.b	$E5, $0C		; unsupported coordination flag
	dc.b	$E1, $04		; set note shift (SMPS/TS)
	smpsPan		$C0, 0
	dc.b	$E6, $F6		; alter note volume (SMPS/TS)
	smpsFMvoice	$01
	smpsCall	em22_Pat_3F
	smpsStop

; ---------------------------------------------------------------
em22_FM5:
	smpsPan		$C0, 0
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
	dc.b	$FB, $60		; set portamento speed (SMPS/TS)
	smpsFMvoice	$03
	smpsCall	em22_Pat_1D
	smpsCall	em22_Pat_1D
	smpsFMvoice	$02
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
;	dc.b	$F1			; unsupported coordination flag
;	dc.b	$E4, $0C		; unsupported coordination flag
	smpsCall	em22_Pat_1A
	smpsCall	em22_Pat_1C
	smpsCall	em22_Pat_1A
	smpsCall	em22_Pat_1B
;	dc.b	$F0			; unsupported coordination flag
	smpsFMvoice	$04
	dc.b	$E6, $FB		; alter note volume (SMPS/TS)
	smpsCall	em22_Pat_1E
	smpsCall	em22_Pat_20
	smpsCall	em22_Pat_1E
	smpsCall	em22_Pat_20
	smpsCall	em22_Pat_1E
	smpsCall	em22_Pat_20
	smpsCall	em22_Pat_1E
	smpsCall	em22_Pat_20
	dc.b	$E6, $08		; alter note volume (SMPS/TS)
	smpsCall	em22_Pat_21
	smpsCall	em22_Pat_26
	smpsCall	em22_Pat_21
	smpsCall	em22_Pat_27
;	dc.b	$E5, $06		; unsupported coordination flag
	dc.b	$E1, $04		; set note shift (SMPS/TS)
	smpsPan		$80, 0
	smpsFMvoice	$00
	dc.b	$E6, $04		; alter note volume (SMPS/TS)
	smpsCall	em22_Pat_1F
	smpsCall	em22_Pat_3E
	smpsStop

; ---------------------------------------------------------------
em22_FM6:
;	dc.b	$F1			; unsupported coordination flag
	smpsPan		$40, 0
;	dc.b	$E4, $18		; unsupported coordination flag
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
	dc.b	$FB, $60		; set portamento speed (SMPS/TS)
;	dc.b	$E5, $0C		; unsupported coordination flag
	dc.b	$E1, $04		; set note shift (SMPS/TS)
	smpsFMvoice	$02
	smpsCall	em22_Pat_15
	smpsCall	em22_Pat_16
	smpsCall	em22_Pat_15
	smpsCall	em22_Pat_17
	smpsCall	em22_Pat_15
	smpsCall	em22_Pat_16
	smpsCall	em22_Pat_15
	smpsCall	em22_Pat_17
	dc.b	$E6, $06		; alter note volume (SMPS/TS)
	smpsCall	em22_Pat_18
	smpsCall	em22_Pat_19
	smpsCall	em22_Pat_18
	smpsCall	em22_Pat_19
	smpsFMvoice	$05
	dc.b	$E6, $03		; alter note volume (SMPS/TS)
	smpsCall	em22_Pat_2A
	smpsCall	em22_Pat_39
	smpsStop

; ---------------------------------------------------------------
; em22_Pats
; ---------------------------------------------------------------

em22_Pat_00:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $04, $80, $02
	dc.b	$E1, $06		; set note shift (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B2, $04, $80, $02
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$E1, $06		; set note shift (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B7, $04, $80, $02
	dc.b	$E1, $06		; set note shift (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B7, $04, $80, $02
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$E1, $06		; set note shift (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B5, $04, $80, $02
	dc.b	$E1, $06		; set note shift (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B5, $04, $80, $02
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$E1, $06		; set note shift (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B4, $04, $80, $02
	dc.b	$E1, $06		; set note shift (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B4, $04, $80, $02
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$E1, $06		; set note shift (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_01:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9A, $0A, $80, $02
	dc.b	$9A, $54, $E7
	dc.b	$9A, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_02:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$96, $0A, $80, $02
	dc.b	$96, $54, $E7
	dc.b	$96, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_03:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$98, $0A, $80, $02
	dc.b	$98, $54, $E7
	dc.b	$98, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_04:
	; This em22_Pat is unused
	; This em22_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_05:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9A, $0A, $80, $02
	dc.b	$9A, $60, $E7
	dc.b	$9A, $2E, $80, $02
	dc.b	$9A, $0A, $80, $02
	dc.b	$98, $0A, $80, $02
	dc.b	$96, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_06:
	; This em22_Pat is unused
	; This em22_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_07:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$95, $04, $80, $08
	dc.b	$95, $04, $80, $02
	dc.b	$95, $04, $80, $02
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_08:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$96, $04, $80, $08
	dc.b	$96, $04, $80, $02
	dc.b	$96, $04, $80, $02
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_09:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9A, $04, $80, $08
	dc.b	$9A, $04, $80, $02
	dc.b	$9A, $04, $80, $02
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_0A:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $04, $80, $02
	dc.b	$E1, $06		; set note shift (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B2, $04, $80, $02
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$E1, $06		; set note shift (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B1, $04, $80, $02
	dc.b	$E1, $06		; set note shift (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B1, $04, $80, $02
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$E1, $06		; set note shift (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $04, $80, $02
	dc.b	$E1, $06		; set note shift (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B2, $04, $80, $02
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$E1, $06		; set note shift (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B4, $04, $80, $02
	dc.b	$E1, $06		; set note shift (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B4, $04, $80, $02
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$E1, $06		; set note shift (SMPS/TS)
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B9, $04, $80, $02
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_0B:
	smpsFMvoice	$0A
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $0B
	dc.b	$AB, $01, $80, $23
	smpsFMvoice	$09
	dc.b	$AB, $01, $80, $5F
	dc.b	$AB, $01, $80, $2F
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_0C:
	smpsFMvoice	$0A
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $0B
	dc.b	$AB, $01, $80, $23
	smpsFMvoice	$09
	dc.b	$AB, $01, $80, $5F
	smpsFMvoice	$08
	smpsPan		$80, 0
	dc.b	$AB, $01, $80, $2F
	smpsPan		$C0, 0
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_0D:
	smpsFMvoice	$0A
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $0B
	dc.b	$AB, $01, $80, $23
	smpsFMvoice	$09
	dc.b	$AB, $01, $80, $5F
	smpsFMvoice	$08
	smpsPan		$40, 0
	dc.b	$B4, $01, $80, $0B
	dc.b	$B4, $01, $80, $23
	smpsPan		$C0, 0
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_0E:
	smpsFMvoice	$0A
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $0B
	dc.b	$AB, $01, $80, $23
	smpsFMvoice	$09
	dc.b	$AB, $01, $80, $2F
	smpsFMvoice	$0A
	dc.b	$AB, $01, $80, $17
	smpsFMvoice	$09
	dc.b	$AB, $01, $80, $17
	smpsFMvoice	$0A
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$09
	dc.b	$AB, $01, $80, $0B
	dc.b	$AB, $01, $80, $0B
	dc.b	$AB, $01, $80, $0B
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_0F:
.0:
	smpsFMvoice	$0A
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$07
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	smpsFMvoice	$09
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$07
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	smpsLoop	0, 3, .0
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_10:
	smpsFMvoice	$0A
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $0B
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	smpsFMvoice	$09
	dc.b	$AB, $01, $80, $0B
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_11:
	smpsFMvoice	$08
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
	smpsFMvoice	$09
	smpsPan		$C0, 0
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_12:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9A, $2E, $80, $02
	dc.b	$9A, $0A, $80, $02
	dc.b	$98, $16, $80, $02
	dc.b	$96, $46, $80, $02
	dc.b	$96, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_13:
	smpsFMvoice	$0A
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $17
	smpsFMvoice	$09
	dc.b	$AB, $01, $80, $17
	dc.b	$AB, $01, $80, $0B
	dc.b	$AB, $01, $80, $17
	smpsFMvoice	$0A
	dc.b	$AB, $01, $80, $17
	smpsFMvoice	$09
	dc.b	$AB, $01, $80, $0B
	dc.b	$AB, $01, $80, $17
	smpsFMvoice	$0A
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$08
	smpsPan		$40, 0
	dc.b	$B4, $01, $80, $0B
	smpsPan		$80, 0
	dc.b	$AB, $01, $80, $17
	smpsPan		$C0, 0
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_14:
	smpsPan		$40, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B4, $01, $80, $05
	dc.b	$B4, $01, $80, $05
	dc.b	$B4, $01, $80, $0B
	smpsPan		$C0, 0
	dc.b	$B0, $01, $80, $05
	dc.b	$B0, $01, $80, $05
	dc.b	$B0, $01, $80, $0B
	smpsPan		$80, 0
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $0B
	smpsPan		$C0, 0
	smpsFMvoice	$09
.0:
	dc.b	$AB, $01, $80, $05
	smpsLoop	0, 4, .0
	smpsFMvoice	$06
em22_Pat_14_1
	smpsPan		$40, 0
	dc.b	$B4, $01, $80, $05
	dc.b	$B4, $01, $80, $05
	smpsPan		$C0, 0
	dc.b	$B0, $01, $80, $05
	dc.b	$B0, $01, $80, $05
	smpsLoop	0, 2, em22_Pat_14_1
	smpsPan		$40, 0
	dc.b	$B4, $01, $80, $02
	dc.b	$B4, $01, $80, $02
	dc.b	$B4, $01, $80, $05
	smpsPan		$C0, 0
	dc.b	$B0, $01, $80, $05
	dc.b	$B0, $01, $80, $05
	smpsPan		$80, 0
.2:
	dc.b	$AB, $01, $80, $05
	smpsLoop	0, 4, .2
	smpsPan		$C0, 0
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_15:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $5E, $80, $02
	dc.b	$B4, $2E, $80, $02
	dc.b	$B5, $2E, $80, $02
	dc.b	$B5, $5E, $80, $02
	dc.b	$B2, $5E, $80, $02
	dc.b	$B0, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_16:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $2E, $80, $02
	dc.b	$B0, $2E, $80, $02
	dc.b	$AE, $60, $E7
	dc.b	$AD, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_17:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $2E, $80, $02
	dc.b	$B4, $2E, $80, $02
	dc.b	$B2, $60, $E7
	dc.b	$B2, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_18:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B1, $0A, $80, $0E
	dc.b	$B1, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$AD, $16, $80, $02
	dc.b	$AE, $0A, $80, $02
	dc.b	$AD, $0A, $80, $02
	dc.b	$AB, $0A, $80, $02
	dc.b	$AD, $0A, $80, $02
	dc.b	$AB, $0A, $80, $02
	dc.b	$A9, $0A, $80, $02
	dc.b	$AB, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_19:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B1, $0A, $80, $0E
	dc.b	$B1, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$AD, $16, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B1, $0A, $80, $02
	dc.b	$B2, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_1A:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B5, $5E, $80, $02
	dc.b	$B7, $2E, $80, $02
	dc.b	$B9, $2E, $80, $02
	dc.b	$B9, $5E, $80, $02
	dc.b	$B5, $5E, $80, $02
	dc.b	$B4, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_1B:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B5, $2E, $80, $02
	dc.b	$B7, $2E, $80, $02
	dc.b	$B5, $60, $E7
	dc.b	$B5, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_1C:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B0, $2E, $80, $02
	dc.b	$B4, $2E, $80, $02
	dc.b	$B2, $60, $E7
	dc.b	$B2, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_1D:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AD, $60, $E7
	dc.b	$AD, $5E, $80, $02
	dc.b	$AE, $60, $E7
	dc.b	$AE, $5E, $80, $02
	dc.b	$B0, $60, $E7
	dc.b	$B0, $5E, $80, $02
	dc.b	$B2, $60, $E7
	dc.b	$B2, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_1E:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B1, $04, $80, $08
	dc.b	$B1, $04, $80, $02
	dc.b	$B1, $04, $80, $02
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_1F:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $0A, $80, $02
;	dc.b	$EA, $FB		; unsupported coordination flag
	dc.b	$B9, $0A, $80, $02
;	dc.b	$EA, $FB		; unsupported coordination flag
	dc.b	$B7, $0A, $80, $02
;	dc.b	$EA, $FB		; unsupported coordination flag
	dc.b	$B9, $0A, $80, $02
;	dc.b	$EA, $FB		; unsupported coordination flag
	dc.b	$B5, $0A, $80, $02
;	dc.b	$EA, $FB		; unsupported coordination flag
	dc.b	$B9, $0A, $80, $02
;	dc.b	$EA, $FB		; unsupported coordination flag
	dc.b	$B4, $0A, $80, $02
;	dc.b	$EA, $FB		; unsupported coordination flag
	dc.b	$B9, $0A, $80, $02
;	dc.b	$EA, $FB		; unsupported coordination flag
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_20:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $04, $80, $08
	dc.b	$B2, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_21:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B5, $2E, $80, $02
	dc.b	$B5, $0A, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B2, $46, $80, $02
	dc.b	$B2, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_22:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_23:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $2E, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B7, $16, $80, $02
	dc.b	$B5, $46, $80, $02
	dc.b	$B5, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_24:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$98, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_25:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$98, $0A, $80, $02
	dc.b	$96, $0A, $80, $02
	dc.b	$95, $60, $E7
	dc.b	$95, $46, $80, $02
	dc.b	$99, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_26:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B4, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_27:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B4, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B0, $60, $E7
	dc.b	$B1, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_28:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B7, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_29:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B7, $0A, $80, $02
	dc.b	$B5, $0A, $80, $02
	dc.b	$B4, $60, $E7
	dc.b	$B4, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_2A:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $0A, $80, $02
	dc.b	$B5, $0A, $80, $02
	dc.b	$BE, $22, $80, $02
	dc.b	$C0, $16, $80, $02
	dc.b	$C0, $06, $E7
	dc.b	$C1, $28, $80, $02
	dc.b	$C1, $06, $E7
	dc.b	$C1, $1C, $80, $02
	dc.b	$C1, $04, $80, $02
	dc.b	$C3, $04, $80, $02
	dc.b	$C1, $04, $80, $02
	dc.b	$C0, $04, $80, $02
	dc.b	$C1, $2E, $80, $02
	dc.b	$BE, $06, $80, $02
	dc.b	$C0, $06, $80, $02
	dc.b	$C1, $06, $80, $02
	dc.b	$C1, $06, $80, $02
	dc.b	$C3, $06, $80, $02
	dc.b	$C5, $06, $80, $02
;	dc.b	$F0			; unsupported coordination flag
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$C6, $24, $E7
	dc.b	$BA, $3A, $80, $02
;	dc.b	$F1			; unsupported coordination flag
	dc.b	$FB, $60		; set portamento speed (SMPS/TS)
	dc.b	$C5, $06, $E7
	dc.b	$C8, $58, $80, $02
	dc.b	$C5, $06, $E7
	dc.b	$C9, $58, $80, $02
	dc.b	$CA, $60, $E7
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_2B:
	; This em22_Pat is unused
	; This em22_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_2C:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$CA, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_2D:
	; This em22_Pat is unused
	; This em22_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_2E:
	; This em22_Pat is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A9, $60, $E7
	dc.b	$A9, $5E, $80, $02
	dc.b	$A9, $60, $E7
	dc.b	$A9, $5E, $80, $02
	dc.b	$AB, $60, $E7
	dc.b	$AB, $5E, $80, $02
	dc.b	$AD, $60, $E7
	dc.b	$AD, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_2F:
	; This em22_Pat is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $60, $E7
	dc.b	$A6, $5E, $80, $02
	dc.b	$A6, $60, $E7
	dc.b	$A6, $5E, $80, $02
	dc.b	$A8, $60, $E7
	dc.b	$A8, $5E, $80, $02
	dc.b	$A9, $60, $E7
	dc.b	$A9, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_30:
	; This em22_Pat is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AD, $0A, $80, $0E
	dc.b	$AD, $0A, $80, $02
	dc.b	$AE, $0A, $80, $02
	dc.b	$B1, $16, $80, $02
	dc.b	$A8, $16, $80, $02
	dc.b	$A9, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$A6, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$A6, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$A6, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_31:
	; This em22_Pat is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AD, $0A, $80, $0E
	dc.b	$AD, $0A, $80, $02
	dc.b	$AE, $0A, $80, $02
	dc.b	$B1, $16, $80, $02
	dc.b	$A8, $16, $80, $02
	dc.b	$AD, $0A, $80, $02
	dc.b	$B1, $0A, $80, $02
	dc.b	$AD, $0A, $80, $02
	dc.b	$AB, $0A, $80, $02
	dc.b	$AD, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_32:
	; This em22_Pat is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $0A, $80, $0E
	dc.b	$A8, $0A, $80, $02
	dc.b	$A9, $0A, $80, $02
	dc.b	$AD, $16, $80, $02
	dc.b	$A5, $16, $80, $02
	dc.b	$A6, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$A2, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$A2, $0A, $80, $02
	dc.b	$A1, $0A, $80, $02
	dc.b	$A2, $0A, $80, $02
	dc.b	$A1, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_33:
	; This em22_Pat is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $0A, $80, $0E
	dc.b	$A8, $0A, $80, $02
	dc.b	$A9, $0A, $80, $02
	dc.b	$AD, $16, $80, $02
	dc.b	$A5, $16, $80, $02
	dc.b	$A9, $0A, $80, $02
	dc.b	$AB, $0A, $80, $02
	dc.b	$A9, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$A9, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_34:
	; This em22_Pat is unused
	; This em22_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_35:
	; This em22_Pat is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $60, $E7
	dc.b	$B2, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_36:
	; This em22_Pat is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B5, $60, $E7
	dc.b	$B5, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_37:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9A, $60, $E7
	dc.b	$9A, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_38:
	; This em22_Pat is unused
	; This em22_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_39:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$CA, $52, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_3A:
	; This em22_Pat is unused
	; This em22_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_3B:
	; This em22_Pat is unused
	; This em22_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_3C:
	; This em22_Pat is unused
	; This em22_Pat is undefined
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_3D:
	smpsFMvoice	$0A
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $0B
	dc.b	$AB, $01, $80, $23
	smpsFMvoice	$09
	dc.b	$AB, $01, $80, $5F
	smpsFMvoice	$08
	smpsPan		$40, 0
	dc.b	$B4, $01, $80, $0B
	dc.b	$B4, $01, $80, $0B
	smpsPan		$C0, 0
	dc.b	$B0, $01, $80, $0B
	smpsPan		$80, 0
	dc.b	$AB, $01, $80, $0B
	smpsPan		$C0, 0
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_3E:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $52, $80, $02
	smpsReturn

; ---------------------------------------------------------------
em22_Pat_3F:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9A, $60, $E7
	dc.b	$9A, $52, $80, $02
	smpsReturn

; ---------------------------------------------------------------
; em22_Voices
; ---------------------------------------------------------------

em22_Voices:
	; Voice $00 (em22_FM)
	dc.b	$33, $3A, $57, $04, $01, $5F, $5F, $5F, $5F, $0B, $07, $0B, $0F, $04, $08, $08, $04, $47, $83, $83, $43, $20, $18, $1C, $00
	; Voice $01 (em22_FM)
	dc.b	$3A, $35, $01, $02, $01, $1B, $1B, $1B, $1F, $03, $07, $07, $07, $04, $04, $04, $06, $27, $47, $27, $27, $1C, $1C, $18, $00
	; Voice $02 (em22_FM)
	dc.b	$2A, $32, $52, $32, $32, $17, $1B, $17, $0B, $00, $03, $04, $00, $00, $04, $04, $04, $43, $35, $44, $25, $20, $1C, $20, $00
	; Voice $03 (em22_FM)
	dc.b	$3F, $30, $54, $51, $32, $1B, $1B, $1B, $1B, $0B, $0B, $0B, $0B, $01, $01, $01, $01, $17, $17, $17, $17, $02, $10, $04, $08
	; Voice $04 (em22_FM)
	dc.b	$3A, $31, $54, $01, $01, $0F, $17, $13, $17, $0F, $07, $0F, $02, $04, $04, $04, $09, $14, $24, $24, $14, $18, $20, $1C, $00
	; Voice $05 (em22_FM)
	dc.b	$38, $30, $00, $00, $00, $1F, $1F, $1B, $1F, $03, $03, $07, $04, $04, $04, $01, $04, $47, $43, $17, $27, $1C, $05, $18, $00
	; Voice $06 (em22_FM)
	dc.b	$3D, $06, $00, $00, $00, $1F, $1F, $1F, $1F, $1F, $00, $00, $00, $1F, $00, $00, $00, $FF, $06, $06, $06, $00, $01, $01, $01
	; Voice $07 (em22_FM)
	dc.b	$38, $00, $00, $00, $0E, $1F, $1F, $1F, $1F, $00, $00, $00, $13, $00, $00, $00, $0C, $00, $00, $00, $5A, $00, $00, $00, $00
	; Voice $08 (em22_FM)
	dc.b	$3E, $3F, $32, $51, $31, $17, $1B, $1F, $1F, $0C, $11, $00, $00, $08, $1F, $00, $00, $21, $D6, $05, $05, $00, $00, $00, $00
	; Voice $09 (em22_FM)
	dc.b	$3C, $02, $02, $01, $01, $1F, $1F, $1F, $1F, $00, $00, $18, $00, $00, $00, $00, $00, $04, $06, $CC, $05, $00, $00, $00, $00
	; Voice $0A (em22_FM)
	dc.b	$2D, $00, $00, $00, $00, $19, $19, $19, $19, $1A, $00, $00, $00, $19, $00, $00, $00, $FA, $05, $05, $05, $00, $03, $03, $03
