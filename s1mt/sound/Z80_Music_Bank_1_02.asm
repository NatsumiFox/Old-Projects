
; ---------------------------------------------------------------
; Created by Techosoft-2-SMPS v.2.70
; 2014, Vladikcomper
; ---------------------------------------------------------------
MB02:

; ---------------------------------------------------------------
; Music Header
; ---------------------------------------------------------------

	dc.w	Voices-MB02			; Voice bank offset
	dc.w	$8700			; Number of MB02_FM/PSG channels
	dc.w	$0100			; Tempo modifier

	dc.w	$0008, $F200		; Disable DAC channel
	dc.w	MB02_FM1-MB02, $004F
	dc.w	MB02_FM2-MB02, $0051
	dc.w	MB02_FM3-MB02, $004F
	dc.w	MB02_FM4-MB02, $0052
	dc.w	MB02_FM5-MB02, $004F
	dc.w	MB02_FM6-MB02, $004B

; ---------------------------------------------------------------
; Music Tracks
; ---------------------------------------------------------------

MB02_FM1:
	smpsFMvoice	$00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
;	dc.b	$F1			; unsupported coordination flag
.Loop:
	smpsFMvoice	$03
;	dc.b	$E4, $18		; unsupported coordination flag
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	smpsCall	MB02_Pattern0F
	smpsFMvoice	$05
	dc.b	$E6, $06		; alter note volume (SMPS/TS)
	smpsCall	MB02_Pattern1E
	smpsCall	MB02_Pattern1F
	smpsCall	MB02_Pattern21
	smpsCall	MB02_Pattern23
	smpsCall	MB02_Pattern22
	smpsCall	MB02_Pattern29
	smpsFMvoice	$08
;	dc.b	$E4, $00		; unsupported coordination flag
	smpsCall	MB02_Pattern2F
	smpsCall	MB02_Pattern30
	smpsCall	MB02_Pattern39
	dc.b	$E6, $FD		; alter note volume (SMPS/TS)
	smpsFMvoice	$09
;	dc.b	$F0			; unsupported coordination flag
	smpsCall	MB02_Pattern48
	smpsCall	MB02_Pattern48
	smpsCall	MB02_Pattern48
	smpsCall	MB02_Pattern48
	smpsFMvoice	$03
;	dc.b	$F1			; unsupported coordination flag
	smpsCall	MB02_Pattern4A
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsJump	.Loop

; ---------------------------------------------------------------
MB02_FM2:
	dc.b	$E6, $06		; alter note volume (SMPS/TS)
	smpsFMvoice	$02
	smpsCall	MB02_Pattern03
	smpsCall	MB02_Pattern04
	smpsCall	MB02_Pattern0B
	smpsCall	MB02_Pattern03
	smpsCall	MB02_Pattern04
	smpsCall	MB02_Pattern0B
	smpsCall	MB02_Pattern03
	smpsCall	MB02_Pattern04
	smpsCall	MB02_Pattern0A
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
.Loop:
	smpsCall	MB02_Pattern08
	smpsCall	MB02_Pattern09
	smpsCall	MB02_Pattern08
	smpsCall	MB02_Pattern09
	dc.b	$E6, $01		; alter note volume (SMPS/TS)
	smpsCall	MB02_Pattern17
	smpsCall	MB02_Pattern18
	smpsCall	MB02_Pattern19
	smpsCall	MB02_Pattern20
	smpsCall	MB02_Pattern17
	smpsCall	MB02_Pattern18
	smpsCall	MB02_Pattern19
	smpsCall	MB02_Pattern20
	smpsCall	MB02_Pattern17
	smpsCall	MB02_Pattern18
	smpsCall	MB02_Pattern19
	smpsCall	MB02_Pattern20
	smpsCall	MB02_Pattern17
	smpsCall	MB02_Pattern18
	smpsCall	MB02_Pattern19
	smpsCall	MB02_Pattern20
	smpsCall	MB02_Pattern17
	smpsCall	MB02_Pattern18
	smpsCall	MB02_Pattern19
	smpsCall	MB02_Pattern20
	smpsCall	MB02_Pattern17
	smpsCall	MB02_Pattern18
	smpsCall	MB02_Pattern19
	smpsCall	MB02_Pattern28
	dc.b	$E6, $FF		; alter note volume (SMPS/TS)
	smpsCall	MB02_Pattern2A
	smpsCall	MB02_Pattern4D
	smpsCall	MB02_Pattern2A
	smpsCall	MB02_Pattern4E
	smpsCall	MB02_Pattern3D
	smpsCall	MB02_Pattern3E
	smpsCall	MB02_Pattern3D
	smpsCall	MB02_Pattern3E
	smpsCall	MB02_Pattern3D
	smpsCall	MB02_Pattern3E
	smpsCall	MB02_Pattern3D
	smpsCall	MB02_Pattern3E
	smpsJump	.Loop

; ---------------------------------------------------------------
MB02_FM3:
	smpsFMvoice	$01
	smpsCall	MB02_Pattern05
	smpsCall	MB02_Pattern01
.Loop:
	smpsFMvoice	$04
	smpsCall	MB02_Pattern10
	smpsCall	MB02_Pattern10
	smpsFMvoice	$06
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern1B
	smpsCall	MB02_Pattern25
	smpsFMvoice	$07
	dc.b	$E6, $03		; alter note volume (SMPS/TS)
	smpsCall	MB02_Pattern2C
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	smpsFMvoice	$08
	smpsPan		$80, 0
;	dc.b	$F1			; unsupported coordination flag
;	dc.b	$E4, $00		; unsupported coordination flag
	smpsCall	MB02_Pattern3A
	smpsPan		$C0, 0
	smpsFMvoice	$09
;	dc.b	$F0			; unsupported coordination flag
	smpsCall	MB02_Pattern44
	smpsCall	MB02_Pattern45
	smpsCall	MB02_Pattern44
	smpsCall	MB02_Pattern45
	smpsCall	MB02_Pattern44
	smpsCall	MB02_Pattern45
	smpsCall	MB02_Pattern44
	smpsCall	MB02_Pattern45
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsJump	.Loop

; ---------------------------------------------------------------
MB02_FM4:
	dc.b	$FA, $03		; setup portamento mode 3 (advanced SMPS only!)
	dc.b	$FB, $1E		; set portamento speed (SMPS/TS)
	dc.b	$E6, $0A		; alter note volume (SMPS/TS)
	smpsCall	MB02_Pattern07
.Loop:
	smpsCall	MB02_Pattern0C
	smpsCall	MB02_Pattern0D
	smpsCall	MB02_Pattern0C
	smpsCall	MB02_Pattern0D
	smpsCall	MB02_Pattern0C
	smpsCall	MB02_Pattern0D
	smpsCall	MB02_Pattern0C
	smpsCall	MB02_Pattern0E
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern1A
	smpsCall	MB02_Pattern27
	smpsCall	MB02_Pattern2B
	smpsCall	MB02_Pattern2B
	smpsCall	MB02_Pattern2B
	smpsCall	MB02_Pattern2B
	smpsCall	MB02_Pattern2B
	smpsCall	MB02_Pattern2B
	smpsCall	MB02_Pattern2B
	smpsCall	MB02_Pattern31
	smpsCall	MB02_Pattern2B
	smpsCall	MB02_Pattern2B
	smpsCall	MB02_Pattern2B
	smpsCall	MB02_Pattern2B
	smpsCall	MB02_Pattern2B
	smpsCall	MB02_Pattern2B
	smpsCall	MB02_Pattern2B
	smpsCall	MB02_Pattern3C
	dc.b	$E6, $FB		; alter note volume (SMPS/TS)
	smpsCall	MB02_Pattern40
	smpsCall	MB02_Pattern40
	smpsCall	MB02_Pattern40
	smpsCall	MB02_Pattern40
	smpsCall	MB02_Pattern40
	smpsCall	MB02_Pattern40
	smpsCall	MB02_Pattern40
	smpsCall	MB02_Pattern3F
	dc.b	$E6, $05		; alter note volume (SMPS/TS)
	smpsJump	.Loop

; ---------------------------------------------------------------
MB02_FM5:
	smpsPan		$40, 0
	smpsFMvoice	$01
	smpsCall	MB02_Pattern05
	smpsCall	MB02_Pattern02
.Loop:
	smpsFMvoice	$04
	smpsCall	MB02_Pattern11
	smpsCall	MB02_Pattern11
	smpsFMvoice	$06
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern1C
	smpsCall	MB02_Pattern26
	smpsPan		$C0, 0
	smpsFMvoice	$07
	dc.b	$E6, $03		; alter note volume (SMPS/TS)
	smpsCall	MB02_Pattern2D
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	smpsFMvoice	$08
	smpsPan		$40, 0
;	dc.b	$F1			; unsupported coordination flag
;	dc.b	$E4, $00		; unsupported coordination flag
	smpsCall	MB02_Pattern3B
	smpsFMvoice	$09
;	dc.b	$F0			; unsupported coordination flag
	smpsCall	MB02_Pattern46
	smpsCall	MB02_Pattern46
	smpsCall	MB02_Pattern46
	smpsCall	MB02_Pattern46
	smpsCall	MB02_Pattern46
	smpsCall	MB02_Pattern46
	smpsCall	MB02_Pattern46
	smpsCall	MB02_Pattern46
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsJump	.Loop

; ---------------------------------------------------------------
MB02_FM6:
;	dc.b	$E5, $09		; unsupported coordination flag
	dc.b	$E1, $04		; set note shift (SMPS/TS)
	smpsPan		$80, 0
	smpsFMvoice	$00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
	smpsCall	MB02_Pattern00
;	dc.b	$F1			; unsupported coordination flag
.Loop:
	smpsFMvoice	$03
;	dc.b	$E4, $18		; unsupported coordination flag
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	smpsCall	MB02_Pattern0F
	smpsFMvoice	$05
	dc.b	$E6, $06		; alter note volume (SMPS/TS)
	smpsCall	MB02_Pattern1E
	smpsCall	MB02_Pattern1F
	smpsCall	MB02_Pattern21
	smpsCall	MB02_Pattern23
	smpsCall	MB02_Pattern22
	smpsCall	MB02_Pattern29
	smpsFMvoice	$08
	smpsPan		$C0, 0
;	dc.b	$E4, $00		; unsupported coordination flag
	smpsCall	MB02_Pattern2F
	smpsCall	MB02_Pattern30
	smpsCall	MB02_Pattern39
	smpsPan		$80, 0
	dc.b	$E6, $FD		; alter note volume (SMPS/TS)
	smpsFMvoice	$09
;	dc.b	$F0			; unsupported coordination flag
	smpsCall	MB02_Pattern48
	smpsCall	MB02_Pattern48
	smpsCall	MB02_Pattern48
	smpsCall	MB02_Pattern48
	smpsFMvoice	$03
;	dc.b	$F1			; unsupported coordination flag
	smpsCall	MB02_Pattern4A
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsJump	.Loop

; ---------------------------------------------------------------
; Patterns
; ---------------------------------------------------------------

MB02_Pattern00:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B4, $0A, $80, $02
	dc.b	$BB, $10, $80, $02
	dc.b	$BC, $10, $80, $02
	dc.b	$BE, $0A, $80, $02
	dc.b	$BC, $0A, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B9, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern01:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BB, $60, $E7
	smpsLoop	0, 6, MB02_Pattern01
	dc.b	$BB, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern02:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $60, $E7
	smpsLoop	0, 6, MB02_Pattern02
	dc.b	$B2, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern03:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$A6, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern04:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $0A, $80, $02
	dc.b	$B0, $0A, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$B0, $0A, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$B0, $0A, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$B0, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern05:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$80, $60
	smpsLoop	0, 5, MB02_Pattern05
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern06:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern07:
	smpsFMvoice	$0D
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $17
	smpsLoop	0, 16, .0
.1:
	dc.b	$AB, $01, $80, $17
	smpsFMvoice	$0C
	dc.b	$AB, $01, $80, $17
	smpsFMvoice	$0D
	dc.b	$AB, $01, $80, $17
	dc.b	$AB, $01, $80, $17
	smpsLoop	0, 4, .1
.2:
	dc.b	$AB, $01, $80, $17
	smpsFMvoice	$0C
	dc.b	$AB, $01, $80, $17
	smpsFMvoice	$0D
	dc.b	$AB, $01, $80, $05
	smpsFMvoice	$0B
	dc.b	$B4, $01, $80, $11
	dc.b	$B4, $01, $80, $05
	smpsFMvoice	$0D
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	smpsLoop	0, 3, .2
	dc.b	$AB, $01, $80, $17
	smpsFMvoice	$0C
	dc.b	$AB, $01, $80, $17
	smpsFMvoice	$0D
	dc.b	$AB, $01, $80, $05
	smpsFMvoice	$0B
	dc.b	$B4, $01, $80, $05
	dc.b	$B4, $01, $80, $05
	dc.b	$B4, $01, $80, $05
	smpsPan		$80, 0
.3:
	dc.b	$AF, $01, $80, $05
	smpsLoop	0, 4, .3
	smpsPan		$C0, 0
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern08:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	smpsLoop	0, 6, .0
	dc.b	$A8, $0A, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$A8, $10, $80, $02
	dc.b	$A6, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern09:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $0A, $80, $02
	dc.b	$B0, $0A, $80, $02
	smpsLoop	0, 6, .0
	dc.b	$A4, $0A, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$A4, $10, $80, $02
	dc.b	$A6, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern0A:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A3, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$A4, $04, $80, $02
	dc.b	$B0, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern0B:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $0A, $80, $02
	dc.b	$A6, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern0C:
.0:
	smpsFMvoice	$0D
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$0A
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$0C
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$0A
	dc.b	$AB, $01, $80, $0B
	smpsLoop	0, 3, .0
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern0D:
	smpsFMvoice	$0D
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$0A
	dc.b	$AB, $01, $80, $05
	smpsFMvoice	$0D
	dc.b	$AB, $01, $80, $05
	smpsFMvoice	$0C
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$0D
	dc.b	$AB, $01, $80, $0B
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern0E:
	smpsFMvoice	$0B
	smpsPan		$40, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B7, $01, $80, $02
	dc.b	$B7, $01, $80, $02
	dc.b	$B7, $01, $80, $05
	smpsPan		$C0, 0
	dc.b	$B4, $01, $80, $05
	dc.b	$B4, $01, $80, $05
	dc.b	$AF, $01, $80, $05
	dc.b	$AF, $01, $80, $05
	smpsPan		$80, 0
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	smpsPan		$C0, 0
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern0F:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BB, $60, $E7
	dc.b	$BB, $52, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$B6, $04, $80, $02
;	dc.b	$E4, $63		; unsupported coordination flag
	dc.b	$B7, $54, $E7
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
	dc.b	$FB, $60		; set portamento speed (SMPS/TS)
	dc.b	$B0, $0C, $E7
	dc.b	$BC, $60, $E7
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$BB, $E7
	dc.b	$BB, $E7
	dc.b	$FB, $61		; set portamento speed (SMPS/TS)
	dc.b	$C7, $E7
	dc.b	$C7, $5E, $80, $02
;	dc.b	$E4, $18		; unsupported coordination flag
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern10:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A3, $5E, $80, $02
	dc.b	$A3, $2E, $80, $02
	dc.b	$A1, $2E, $80, $02
	dc.b	$9F, $5E, $80, $02
	dc.b	$9F, $2E, $80, $02
	dc.b	$A4, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern11:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9F, $5E, $80, $02
	dc.b	$9F, $2E, $80, $02
	dc.b	$9E, $2E, $80, $02
	dc.b	$9C, $5E, $80, $02
	dc.b	$9C, $2E, $80, $02
	dc.b	$A1, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern12:
	; This pattern is unused
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $60, $E7
	smpsLoop	0, 6, .0
	dc.b	$A8, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern13:
	; This pattern is unused
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $60, $E7
	smpsLoop	0, 6, .0
	dc.b	$AB, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern14:
	; This pattern is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $5E, $80, $02
	dc.b	$A8, $2E, $80, $02
	dc.b	$A6, $2E, $80, $02
	dc.b	$A4, $5E, $80, $02
	dc.b	$A4, $2E, $80, $02
	dc.b	$A8, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern15:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern16:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern17:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	smpsLoop	0, 3, .0
	dc.b	$A8, $0A, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$A6, $06, $E7
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern18:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	smpsLoop	0, 3, .0
	dc.b	$A6, $0A, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$A4, $06, $E7
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern19:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $0A, $80, $02
	dc.b	$B0, $0A, $80, $02
	smpsLoop	0, 3, .0
	dc.b	$A4, $0A, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$A3, $06, $E7
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern1A:
	smpsFMvoice	$0D
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $11
	dc.b	$AB, $01, $80, $05
	smpsFMvoice	$0C
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$0D
	dc.b	$AB, $01, $80, $0B
	dc.b	$AB, $01, $80, $0B
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$0C
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$0D
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern1B:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AF, $04, $80, $08
	dc.b	$AF, $04, $80, $08
	dc.b	$AF, $04, $80, $0E
	dc.b	$AF, $04, $80, $08
	dc.b	$AF, $04, $80, $02
	dc.b	$AF, $04, $80, $08
	dc.b	$AF, $04, $80, $14
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern1C:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AA, $04, $80, $08
	dc.b	$AB, $04, $80, $08
	dc.b	$AB, $04, $80, $0E
	dc.b	$AD, $04, $80, $08
	dc.b	$AB, $04, $80, $02
	dc.b	$AB, $04, $80, $08
	dc.b	$AB, $04, $80, $14
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern1D:
	; This pattern is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $04, $80, $08
	dc.b	$A8, $04, $80, $08
	dc.b	$A8, $04, $80, $0E
	dc.b	$A8, $04, $80, $08
	dc.b	$A8, $04, $80, $02
	dc.b	$A8, $04, $80, $08
	dc.b	$A8, $04, $80, $14
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern1E:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B4, $46, $80, $02
	dc.b	$B7, $0A, $80, $0E
	dc.b	$B4, $2E, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B7, $0A, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B0, $10, $80, $02
	dc.b	$B2, $10, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B2, $10, $80, $02
	dc.b	$B4, $10, $80, $02
	dc.b	$B7, $0A, $80, $02
	dc.b	$B6, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern1F:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B7, $04, $80, $02
	dc.b	$B6, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	smpsLoop	0, 4, .0
.1:
	dc.b	$B9, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$B6, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	smpsLoop	0, 4, .1
	dc.b	$B7, $04, $80, $02
	dc.b	$B6, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$B2, $10, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B7, $06, $E7
	dc.b	$B9, $0A, $80, $02
	dc.b	$BC, $18, $E7
	dc.b	$BB, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern20:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A3, $0A, $80, $02
	dc.b	$AF, $0A, $80, $02
	smpsLoop	0, 3, .0
	dc.b	$A6, $0A, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$A6, $06, $E7
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern21:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$80, $18
	dc.b	$BB, $46, $80, $1A
	dc.b	$BE, $46, $80, $1A
	dc.b	$C0, $2E, $80, $02
	dc.b	$C2, $04, $80, $02
	dc.b	$C0, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$BC, $06, $E7
	dc.b	$C2, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern22:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$CC, $46, $80, $02
	dc.b	$CA, $0A, $80, $02
	dc.b	$CC, $0A, $80, $02
	dc.b	$CF, $2E, $80, $02
	dc.b	$CA, $2E, $80, $02
	dc.b	$CC, $46, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$CA, $04, $80, $02
	dc.b	$C8, $04, $80, $02
	dc.b	$C5, $06, $E7
	dc.b	$C7, $46, $80, $02
	dc.b	$C7, $04, $80, $02
	dc.b	$C5, $04, $80, $02
	dc.b	$C3, $04, $80, $02
;	dc.b	$E4, $63		; unsupported coordination flag
	dc.b	$BE, $06, $E7
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern23:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C3, $10, $80, $02
	dc.b	$C2, $10, $80, $02
	dc.b	$C0, $0A, $80, $02
	dc.b	$C3, $0A, $80, $02
	dc.b	$C2, $0A, $80, $02
	dc.b	$C0, $16, $80, $02
	dc.b	$C5, $10, $80, $02
	dc.b	$C3, $10, $80, $02
	dc.b	$C2, $0A, $80, $02
	dc.b	$C3, $0A, $80, $02
	dc.b	$C2, $0A, $80, $02
	dc.b	$BE, $0A, $80, $0E
	dc.b	$BC, $16, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$BE, $03, $E7
	dc.b	$C0, $02, $80, $01
	dc.b	$C2, $02, $80, $01
	dc.b	$C3, $02, $80, $01
	dc.b	$C5, $0A, $80, $02
	dc.b	$C3, $16, $80, $02
	dc.b	$C3, $03, $E7
	dc.b	$C5, $02, $80, $01
	dc.b	$C7, $02, $80, $01
	dc.b	$C8, $06, $E7
	dc.b	$FB, $62		; set portamento speed (SMPS/TS)
	dc.b	$C7, $09, $E7
	dc.b	$CA, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern24:
	; This pattern is unused
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $0A, $80, $0E
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern25:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AD, $0A, $80, $0E
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern26:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AA, $0A, $80, $0E
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern27:
	smpsFMvoice	$0C
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $17
	smpsFMvoice	$0D
	dc.b	$AB, $01, $80, $17
	dc.b	$AB, $01, $80, $17
	dc.b	$AB, $01, $80, $17
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern28:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $0A, $80, $0E
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern29:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C0, $60, $E7
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$CC, $5E, $80, $02
;	dc.b	$E4, $18		; unsupported coordination flag
	dc.b	$C0, $5E, $80, $02
	dc.b	$BE, $0A, $80, $0E
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$BE, $0A, $80, $0E
	dc.b	$FC, $54			; set note volume (advanced SMPS only!)
	dc.b	$BE, $0A, $80, $0E
	dc.b	$FC, $4E			; set note volume (advanced SMPS only!)
	dc.b	$BE, $0A, $80, $0E
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern2A:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $46, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$AA, $46, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$AA, $0A, $80, $02
	dc.b	$AB, $46, $80, $02
	dc.b	$B7, $0A, $80, $02
	dc.b	$AB, $0A, $80, $02
	dc.b	$A6, $46, $80, $02
	dc.b	$A6, $0A, $80, $02
	dc.b	$A6, $0A, $80, $02
	dc.b	$A4, $46, $80, $02
	dc.b	$B0, $0A, $80, $02
	dc.b	$A4, $0A, $80, $02
	dc.b	$A6, $46, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$A6, $0A, $80, $02
	dc.b	$A8, $46, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern2B:
	smpsFMvoice	$0D
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$0A
	dc.b	$AB, $0A, $80, $02
	smpsFMvoice	$0B
	smpsPan		$80, 0
	dc.b	$AF, $01, $80, $0B
	smpsPan		$C0, 0
	smpsFMvoice	$0A
	dc.b	$AB, $0A, $80, $02
	dc.b	$AB, $01, $80, $0B
	dc.b	$AB, $0A, $80, $02
	smpsFMvoice	$0C
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$0D
	dc.b	$AB, $01, $80, $0B
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern2C:
	smpsPan		$80, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BB, $10, $80, $02
	smpsPan		$C0, 0
	dc.b	$BB, $10, $80, $02
	smpsPan		$40, 0
	dc.b	$BB, $2E, $80, $02
	smpsPan		$C0, 0
	dc.b	$BB, $04, $80, $02
	dc.b	$BB, $04, $80, $02
.0:
	smpsPan		$80, 0
	dc.b	$BE, $10, $80, $02
	smpsPan		$C0, 0
	dc.b	$BE, $10, $80, $02
	smpsPan		$40, 0
	dc.b	$BE, $2E, $80, $02
	smpsPan		$C0, 0
	dc.b	$BE, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	smpsLoop	0, 2, .0
.1:
	smpsPan		$80, 0
	dc.b	$B9, $10, $80, $02
	smpsPan		$C0, 0
	dc.b	$B9, $10, $80, $02
	smpsPan		$40, 0
	dc.b	$B9, $2E, $80, $02
	smpsPan		$C0, 0
	dc.b	$B9, $04, $80, $02
	dc.b	$B9, $04, $80, $02
	dc.b	$E9, $02		; alter note displacement (SMPS/TS)
	smpsLoop	0, 2, .1
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsPan		$80, 0
	dc.b	$B9, $10, $80, $02
	smpsPan		$C0, 0
	dc.b	$B9, $10, $80, $02
	smpsPan		$40, 0
	dc.b	$B9, $2E, $80, $02
	smpsPan		$C0, 0
	dc.b	$B9, $04, $80, $02
	dc.b	$B9, $04, $80, $02
.2:
	smpsPan		$80, 0
	dc.b	$BB, $10, $80, $02
	smpsPan		$C0, 0
	dc.b	$BB, $10, $80, $02
	smpsPan		$40, 0
	dc.b	$BB, $2E, $80, $02
	smpsPan		$C0, 0
	dc.b	$BB, $04, $80, $02
	dc.b	$BB, $04, $80, $02
	smpsLoop	0, 2, .2
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern2D:
.0:
	smpsPan		$80, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B7, $10, $80, $02
	smpsPan		$C0, 0
	dc.b	$B7, $10, $80, $02
	smpsPan		$40, 0
	dc.b	$B7, $2E, $80, $02
	smpsPan		$C0, 0
	dc.b	$B7, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$E9, $02		; alter note displacement (SMPS/TS)
	smpsLoop	0, 3, .0
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
.1:
	smpsPan		$80, 0
	dc.b	$B6, $10, $80, $02
	smpsPan		$C0, 0
	dc.b	$B6, $10, $80, $02
	smpsPan		$40, 0
	dc.b	$B6, $2E, $80, $02
	smpsPan		$C0, 0
	dc.b	$B6, $04, $80, $02
	dc.b	$B6, $04, $80, $02
	dc.b	$E9, $FE		; alter note displacement (SMPS/TS)
	smpsLoop	0, 2, .1
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsPan		$80, 0
	dc.b	$B6, $10, $80, $02
	smpsPan		$C0, 0
	dc.b	$B6, $10, $80, $02
	smpsPan		$40, 0
	dc.b	$B6, $2E, $80, $02
	smpsPan		$C0, 0
	dc.b	$B6, $04, $80, $02
	dc.b	$B6, $04, $80, $02
.2:
	smpsPan		$80, 0
	dc.b	$B7, $10, $80, $02
	smpsPan		$C0, 0
	dc.b	$B7, $10, $80, $02
	smpsPan		$40, 0
	dc.b	$B7, $2E, $80, $02
	smpsPan		$C0, 0
	dc.b	$B7, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$E9, $FF		; alter note displacement (SMPS/TS)
	smpsLoop	0, 2, .2
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern2E:
	; This pattern is unused
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $04, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	smpsLoop	0, 4, .0
.1:
	dc.b	$AA, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	smpsLoop	0, 4, .1
.2:
	dc.b	$AB, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	smpsLoop	0, 4, .2
.3:
	dc.b	$AA, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	smpsLoop	0, 4, .3
.4:
	dc.b	$A8, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$B0, $04, $80, $02
	smpsLoop	0, 4, .4
.5:
	dc.b	$A6, $04, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	smpsLoop	0, 4, .5
.6:
	dc.b	$A8, $04, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	smpsLoop	0, 4, .6
.7:
	dc.b	$A3, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$B6, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$E9, $0C		; alter note displacement (SMPS/TS)
	smpsLoop	0, 2, .7
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern2F:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B4, $16, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B7, $0A, $80, $02
	dc.b	$BB, $22, $80, $02
	dc.b	$BE, $46, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$BB, $2E, $80, $02
	dc.b	$C3, $2E, $80, $02
	dc.b	$C2, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern30:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C3, $0A, $80, $02
	dc.b	$C2, $0A, $80, $02
	dc.b	$C0, $0A, $80, $02
	dc.b	$BE, $0A, $80, $02
	dc.b	$C0, $2E, $80, $02
	dc.b	$C2, $0A, $80, $02
	dc.b	$C3, $0A, $80, $02
	dc.b	$C2, $0A, $80, $02
	dc.b	$C0, $0A, $80, $02
	dc.b	$BE, $2E, $80, $02
	dc.b	$C0, $10, $80, $02
	dc.b	$C2, $10, $80, $02
	dc.b	$C3, $0A, $80, $02
	dc.b	$C2, $0A, $80, $02
	dc.b	$C0, $16, $80, $02
	dc.b	$BB, $06, $E7
	dc.b	$FB, $62		; set portamento speed (SMPS/TS)
	dc.b	$BC, $E7
	dc.b	$BB, $5E, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern31:
	smpsFMvoice	$0D
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$0A
	dc.b	$AB, $0A, $80, $02
	smpsFMvoice	$0B
	smpsPan		$80, 0
	dc.b	$AF, $01, $80, $0B
	smpsPan		$C0, 0
	smpsFMvoice	$0A
	dc.b	$AB, $0A, $80, $02
	smpsFMvoice	$0B
	smpsPan		$40, 0
	dc.b	$B7, $01, $80, $0B
	smpsPan		$C0, 0
	dc.b	$B4, $01, $80, $0B
	smpsFMvoice	$0C
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$0B
	smpsPan		$80, 0
	dc.b	$AF, $01, $80, $0B
	smpsPan		$C0, 0
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern32:
	; This pattern is unused
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$E9, $0C		; alter note displacement (SMPS/TS)
	smpsLoop	0, 3, .0
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	dc.b	$C3, $04, $80, $02
	dc.b	$C0, $04, $80, $02
	dc.b	$BB, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern33:
	; This pattern is unused
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AA, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$E9, $0C		; alter note displacement (SMPS/TS)
	smpsLoop	0, 3, .0
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	dc.b	$C5, $04, $80, $02
	dc.b	$C2, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$B9, $04, $80, $02
	dc.b	$B6, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern34:
	; This pattern is unused
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$E9, $0C		; alter note displacement (SMPS/TS)
	smpsLoop	0, 3, .0
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	dc.b	$C7, $04, $80, $02
	dc.b	$C3, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$BB, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern35:
	; This pattern is unused
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$E9, $0C		; alter note displacement (SMPS/TS)
	smpsLoop	0, 3, .0
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	dc.b	$C0, $04, $80, $02
	dc.b	$BC, $04, $80, $02
	dc.b	$B7, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$B0, $04, $80, $02
	dc.b	$AB, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern36:
	; This pattern is unused
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A7, $04, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$E9, $0C		; alter note displacement (SMPS/TS)
	smpsLoop	0, 4, .0
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern37:
	; This pattern is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$80, $0C
	dc.b	$E1, $04		; set note shift (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern38:
	; This pattern is unused
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A7, $04, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$E9, $0C		; alter note displacement (SMPS/TS)
	smpsLoop	0, 3, .0
	dc.b	$A7, $04, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern39:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C0, $5E, $80, $02
	dc.b	$C2, $2E, $80, $02
	dc.b	$BE, $2E, $80, $02
	dc.b	$BB, $22, $80, $02
	dc.b	$BC, $22, $80, $02
	dc.b	$BE, $22, $80, $02
	dc.b	$C0, $22, $80, $02
	dc.b	$C2, $16, $80, $02
	dc.b	$C5, $18, $E7
	dc.b	$FB, $62		; set portamento speed (SMPS/TS)
	dc.b	$C3, $5E, $80, $02
	dc.b	$C2, $5E, $80, $02
	dc.b	$C0, $46, $80, $02
	dc.b	$C1, $04, $80, $02
	dc.b	$C2, $05, $80, $01
	dc.b	$C1, $05, $80, $01
	dc.b	$C0, $05, $80, $01
	dc.b	$BF, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern3A:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BB, $5E, $80, $02
	dc.b	$BE, $2E, $80, $02
	dc.b	$B9, $2E, $80, $02
	dc.b	$B7, $22, $80, $02
	dc.b	$B9, $22, $80, $02
	dc.b	$BB, $22, $80, $02
	dc.b	$BC, $22, $80, $02
	dc.b	$BE, $16, $80, $02
	dc.b	$C2, $18, $E7
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
	dc.b	$FB, $62		; set portamento speed (SMPS/TS)
	dc.b	$C0, $5E, $80, $02
	dc.b	$BE, $5E, $80, $02
	dc.b	$BB, $5E, $80, $02
	dc.b	$B9, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern3B:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B7, $5E, $80, $02
	dc.b	$B9, $2E, $80, $02
	dc.b	$B6, $2E, $80, $02
	dc.b	$B2, $22, $80, $02
	dc.b	$B4, $22, $80, $02
	dc.b	$B6, $22, $80, $02
	dc.b	$B7, $22, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$BB, $18, $E7
	dc.b	$FA, $01		; setup portamento mode 1 (advanced SMPS only!)
	dc.b	$FB, $62		; set portamento speed (SMPS/TS)
	dc.b	$BC, $5E, $80, $02
	dc.b	$B9, $5E, $80, $02
	dc.b	$B7, $60, $E7
	dc.b	$B6, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern3C:
	smpsFMvoice	$0A
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $0B
.0:
	smpsFMvoice	$0D
	dc.b	$AB, $01, $80, $0B
	smpsFMvoice	$0C
	dc.b	$AB, $01, $80, $05
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	smpsLoop	0, 2, .0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $0B
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern3D:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $16, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$A8, $06, $80, $02
	dc.b	$A8, $06, $80, $02
	dc.b	$A8, $06, $80, $02
	smpsLoop	0, 3, .0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $06, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$A8, $06, $80, $02
	dc.b	$A8, $06, $80, $02
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $06, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$A8, $06, $80, $02
	dc.b	$A6, $06, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern3E:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $16, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$A4, $06, $80, $02
	dc.b	$A4, $06, $80, $02
	dc.b	$A4, $06, $80, $02
	smpsLoop	0, 3, .0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $06, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$A4, $06, $80, $02
	dc.b	$A4, $06, $80, $02
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A4, $06, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$A4, $06, $80, $02
	dc.b	$A6, $06, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern3F:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $17
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $07
	dc.b	$AB, $01, $80, $07
	dc.b	$AB, $01, $80, $07
	smpsLoop	0, 2, .0
	smpsFMvoice	$0D
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $07
	smpsFMvoice	$0C
.1:
	dc.b	$AB, $01, $80, $07
	smpsLoop	0, 4, .1
	dc.b	$AB, $01, $80, $06
	smpsFMvoice	$0B
	smpsPan		$40, 0
	dc.b	$B7, $01, $80, $03
	dc.b	$B7, $01, $80, $02
	dc.b	$B7, $01, $80, $05
	smpsPan		$C0, 0
	dc.b	$B4, $01, $80, $05
	dc.b	$B4, $01, $80, $05
	dc.b	$AF, $01, $80, $05
	dc.b	$AF, $01, $80, $05
	smpsPan		$80, 0
	dc.b	$AB, $01, $80, $05
	dc.b	$AB, $01, $80, $05
	smpsPan		$C0, 0
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern40:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $17
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $07
	dc.b	$AB, $01, $80, $07
	dc.b	$AB, $01, $80, $07
	smpsLoop	0, 3, .0
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $07
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AB, $01, $80, $07
	dc.b	$AB, $01, $80, $07
	smpsLoop	0, 2, .1
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern41:
	; This pattern is unused
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$80, $60
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern42:
	; This pattern is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B4, $60, $E7
	dc.b	$B4, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern43:
	; This pattern is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AF, $60, $E7
	dc.b	$AF, $5E, $80, $02
	dc.b	$B0, $60, $E7
	dc.b	$B0, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern44:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AF, $16, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AF, $06, $80, $02
	dc.b	$AF, $06, $80, $02
	dc.b	$AF, $06, $80, $02
	smpsLoop	0, 3, .0
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AF, $06, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$AF, $06, $80, $02
	dc.b	$AF, $06, $80, $02
	smpsLoop	0, 2, .1
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern45:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B0, $16, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B0, $06, $80, $02
	dc.b	$B0, $06, $80, $02
	dc.b	$B0, $06, $80, $02
	smpsLoop	0, 3, .0
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B0, $06, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B0, $06, $80, $02
	dc.b	$B0, $06, $80, $02
	smpsLoop	0, 2, .1
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern46:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B7, $16, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B7, $06, $80, $02
	dc.b	$B7, $06, $80, $02
	dc.b	$B7, $06, $80, $02
	smpsLoop	0, 3, .0
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B7, $06, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B7, $06, $80, $02
	dc.b	$B7, $06, $80, $02
	smpsLoop	0, 2, .1
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern47:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern48:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B4, $16, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B4, $06, $80, $02
	dc.b	$B4, $06, $80, $02
	dc.b	$B4, $06, $80, $02
	smpsLoop	0, 3, .0
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B4, $06, $80, $02
	dc.b	$FC, $5A			; set note volume (advanced SMPS only!)
	dc.b	$B4, $06, $80, $02
	dc.b	$B4, $06, $80, $02
	smpsLoop	0, 2, .1
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern49:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern4A:
;	dc.b	$E4, $63		; unsupported coordination flag
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B4, $60, $E7
	smpsLoop	0, 7, .0
	dc.b	$B4, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern4B:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern4C:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern4D:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A3, $2E, $80, $02
	dc.b	$A3, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$B4, $04, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$B6, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
MB02_Pattern4E:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A7, $46, $80, $02
	dc.b	$A3, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$A7, $04, $80, $02
	dc.b	$B3, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
; Voices
; ---------------------------------------------------------------

Voices:
	; Voice $00 (MB02_FM)
	dc.b	$24, $31, $31, $50, $51, $17, $1B, $17, $1B, $07, $03, $07, $07, $04, $00, $00, $00, $27, $07, $0B, $07, $10, $00, $10, $00
	; Voice $01 (MB02_FM)
	dc.b	$3B, $31, $51, $31, $51, $07, $07, $07, $07, $00, $00, $00, $00, $00, $00, $00, $00, $07, $07, $07, $07, $24, $24, $18, $00
	; Voice $02 (MB02_FM)
	dc.b	$3B, $38, $02, $50, $00, $1F, $1F, $1F, $1F, $0F, $0F, $0F, $0F, $08, $08, $08, $08, $27, $27, $27, $07, $21, $28, $10, $00
	; Voice $03 (MB02_FM)
	dc.b	$2C, $31, $31, $51, $51, $0F, $13, $13, $13, $03, $03, $03, $03, $00, $00, $00, $00, $17, $07, $07, $07, $20, $00, $18, $00
	; Voice $04 (MB02_FM)
	dc.b	$3C, $34, $34, $5C, $54, $13, $1F, $1F, $1F, $0B, $03, $07, $07, $04, $04, $04, $00, $37, $07, $47, $07, $18, $00, $20, $00
	; Voice $05 (MB02_FM)
	dc.b	$28, $30, $01, $01, $01, $1B, $1F, $1F, $1F, $00, $00, $05, $03, $01, $00, $01, $00, $10, $00, $10, $17, $12, $12, $18, $00
	; Voice $06 (MB02_FM)
	dc.b	$3C, $34, $38, $52, $52, $0F, $1F, $13, $1F, $07, $03, $03, $00, $04, $04, $00, $00, $37, $07, $07, $00, $1E, $00, $14, $00
	; Voice $07 (MB02_FM)
	dc.b	$38, $37, $36, $31, $33, $1F, $1F, $1F, $1F, $0F, $0F, $0F, $0F, $0C, $0C, $0C, $0C, $0A, $0A, $0A, $0A, $1E, $1E, $1E, $00
	; Voice $08 (MB02_FM)
	dc.b	$12, $04, $02, $31, $54, $13, $13, $1F, $1B, $02, $02, $04, $04, $1D, $0E, $03, $03, $62, $23, $25, $26, $24, $16, $22, $00
	; Voice $09 (MB02_FM)
	dc.b	$3A, $31, $03, $01, $02, $93, $8F, $93, $9B, $07, $07, $07, $03, $04, $04, $04, $04, $17, $27, $17, $07, $1C, $20, $24, $00
	; Voice $0A (MB02_FM)
	dc.b	$38, $00, $00, $00, $0E, $1F, $1F, $1F, $1F, $00, $00, $00, $13, $00, $00, $00, $0C, $00, $00, $00, $5A, $00, $00, $00, $00
	; Voice $0B (MB02_FM)
	dc.b	$FE, $01, $01, $01, $01, $1F, $1F, $1F, $1F, $09, $09, $00, $00, $09, $06, $00, $00, $02, $46, $05, $05, $00, $0C, $00, $00
	; Voice $0C (MB02_FM)
	dc.b	$FC, $02, $01, $00, $01, $1F, $1F, $1F, $1F, $00, $00, $19, $00, $00, $00, $0C, $00, $05, $06, $B5, $05, $00, $00, $00, $00
	; Voice $0D (MB02_FM)
	dc.b	$33, $00, $00, $00, $00, $19, $19, $19, $19, $1A, $19, $19, $00, $19, $19, $19, $00, $FC, $F7, $FB, $05, $00, $00, $00, $00
