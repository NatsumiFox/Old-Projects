
; ---------------------------------------------------------------
; Created by Techosoft-2-SMPS v.2.70
; 2014, Vladikcomper
; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7:

; ---------------------------------------------------------------
; Music Header
; ---------------------------------------------------------------

	dc.w	Z80_MusicBank_1_Stage_7_Voices-Z80_MusicBank_1_Stage_7			; Voice bank offset
	dc.w	$8700			; Number of Z80_MusicBank_1_Stage_7_FM/PSG channels
	dc.w	$0100			; Tempo modifier

	dc.w	$0008, $F200		; Disable DAC channel
	dc.w	Z80_MusicBank_1_Stage_7_FM5-Z80_MusicBank_1_Stage_7, $0048
	dc.w	Z80_MusicBank_1_Stage_7_FM2-Z80_MusicBank_1_Stage_7, $0050
	dc.w	Z80_MusicBank_1_Stage_7_FM3-Z80_MusicBank_1_Stage_7, $0051
	dc.w	Z80_MusicBank_1_Stage_7_FM4-Z80_MusicBank_1_Stage_7, $004D
	dc.w	Z80_MusicBank_1_Stage_7_FM6-Z80_MusicBank_1_Stage_7, $004C
	dc.w	Z80_MusicBank_1_Stage_7_FM1-Z80_MusicBank_1_Stage_7, $0050

; ---------------------------------------------------------------
; Music Tracks
; ---------------------------------------------------------------

Z80_MusicBank_1_Stage_7_FM1:
	dc.b	$E1, $03		; set note shift (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
;	dc.b	$F1			; unsupported coordination flag
	smpsPan		$40, 0
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_0B
.Loop:
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_48
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_4B
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_48
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_5C
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_4D
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_4F
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_4D
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_4F
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_51
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_53
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_51
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_62
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_55
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_57
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_55
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_57
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_59
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_5F
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_59
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_61
	smpsJump	.Loop

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_FM2:
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_0E
.Loop:
	dc.b	$E6, $03		; alter note volume (SMPS/TS)
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_02
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_07
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_02
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_12
	dc.b	$E9, $F4		; alter note displacement (SMPS/TS)
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_10
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_1A
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_10
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_1F
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_22
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_28
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_22
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_2F
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_2C
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_31
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_2C
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_36
	smpsFMvoice	$05
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_38
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_39
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_38
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_3F
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsJump	.Loop

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_FM3:
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	dc.b	$FA, $03		; setup portamento mode 3 (advanced SMPS only!)
	dc.b	$FB, $0A		; set portamento speed (SMPS/TS)
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_0D
.Loop:
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_06
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_06
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_06
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_15
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_17
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_1E
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_17
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_21
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_17
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_45
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_17
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_21
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_17
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_46
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_17
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_21
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_17
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_1E
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_17
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_47
	smpsJump	.Loop

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_FM4:
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_0B
.Loop:
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_04
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_0A
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_04
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_0A
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_1C
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_1C
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_1C
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_1C
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_1D
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_2A
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_1D
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_2A
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_1D
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_2A
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_1D
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_2A
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_3D
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_3D
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_3D
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_41
	smpsJump	.Loop

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_FM5:
	dc.b	$E1, $00		; set note shift (SMPS/TS)
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_0F
.Loop:
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_03
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_08
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_03
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_13
	dc.b	$E9, $F4		; alter note displacement (SMPS/TS)
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_11
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_1B
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_11
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_20
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_23
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_29
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_23
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_30
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_2D
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_32
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_2D
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_37
	smpsFMvoice	$05
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_3B
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_3C
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_3B
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_40
	dc.b	$E9, $00		; alter note displacement (SMPS/TS)
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsJump	.Loop

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_FM6:
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
	smpsPan		$80, 0
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_0C
.Loop:
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_05
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_05
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_05
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_14
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_18
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_18
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_18
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_18
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_18
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_18
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_18
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_18
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_18
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_18
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_18
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_18
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_18
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_18
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_18
	smpsCall	Z80_MusicBank_1_Stage_7_Pattern_18
	smpsJump	.Loop

; ---------------------------------------------------------------
; Z80_MusicBank_1_Stage_7_Patterns
; ---------------------------------------------------------------

Z80_MusicBank_1_Stage_7_Pattern_00:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	; This Z80_MusicBank_1_Stage_7_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_01:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	smpsFMvoice	$00
	dc.b	$E6, $03		; alter note volume (SMPS/TS)
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A5, $16, $80, $02
	dc.b	$AA, $16, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$AC, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$AD, $16, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$AC, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$AA, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$A8, $16, $80, $02
	dc.b	$A5, $16, $80, $02
	dc.b	$AA, $16, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$AC, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$AD, $16, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$AF, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$AD, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$AC, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_02:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AD, $5E, $80, $02
	dc.b	$AF, $22, $80, $02
	dc.b	$AD, $22, $80, $02
	dc.b	$AC, $16, $80, $02
	dc.b	$A8, $60, $E7
	dc.b	$A5, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_03:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AA, $5E, $80, $02
	dc.b	$AC, $22, $80, $02
	dc.b	$AA, $22, $80, $02
	dc.b	$A8, $16, $80, $02
	dc.b	$A5, $60, $E7
	dc.b	$A1, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_04:
	smpsFMvoice	$04
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9E, $0A, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$AA, $04, $80, $02
	smpsLoop	0, 8, .0
.1:
	dc.b	$99, $0A, $80, $02
	dc.b	$A5, $04, $80, $02
	dc.b	$A5, $04, $80, $02
	smpsLoop	0, 8, .1
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_05:
.0:
	smpsFMvoice	$01
.1:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $0A, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	smpsLoop	1, 6, .1
	smpsFMvoice	$02
	dc.b	$A8, $10, $80, $02
	dc.b	$A8, $10, $80, $02
	dc.b	$A8, $0A, $80, $02
	smpsLoop	0, 2, .0
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_06:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $0B
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	smpsFMvoice	$07
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 3, .0
	smpsFMvoice	$08
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $0B
	smpsFMvoice	$07
	dc.b	$B4, $01, $80, $0B
	dc.b	$B4, $01, $80, $0B
.1:
	smpsFMvoice	$08
	dc.b	$A8, $01, $80, $0B
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	smpsFMvoice	$07
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 3, .1
	smpsFMvoice	$08
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $0B
	dc.b	$B9, $01, $80, $05
	dc.b	$B7, $01, $80, $05
	dc.b	$B5, $01, $80, $05
	dc.b	$B4, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_07:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AD, $5E, $80, $02
	dc.b	$AF, $22, $80, $02
	dc.b	$AD, $22, $80, $02
	dc.b	$AC, $16, $80, $02
	dc.b	$A8, $22, $80, $02
	dc.b	$AF, $22, $80, $02
	dc.b	$AD, $16, $80, $02
	dc.b	$B1, $16, $80, $02
	dc.b	$AF, $16, $80, $02
	dc.b	$AD, $16, $80, $02
	dc.b	$AC, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_08:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AA, $5E, $80, $02
	dc.b	$AC, $22, $80, $02
	dc.b	$AA, $22, $80, $02
	dc.b	$A8, $16, $80, $02
	dc.b	$A5, $22, $80, $02
	dc.b	$AC, $22, $80, $02
	dc.b	$AA, $16, $80, $02
	dc.b	$AD, $16, $80, $02
	dc.b	$AC, $16, $80, $02
	dc.b	$AA, $16, $80, $02
	dc.b	$A8, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_09:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	dc.b	$FC, $63			; set note volume (advanced SMPS only!)
	dc.b	$A5, $16, $80, $02
	dc.b	$AA, $16, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$AC, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$AD, $16, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$AC, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$AA, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$A8, $16, $80, $02
	dc.b	$A5, $16, $80, $02
	dc.b	$AA, $16, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$AC, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$B1, $16, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$AF, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$AD, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$AC, $16, $80, $02
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_0A:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9E, $0A, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$AA, $04, $80, $02
	smpsLoop	0, 8, .0
.1:
	dc.b	$99, $0A, $80, $02
	dc.b	$A5, $04, $80, $02
	dc.b	$A5, $04, $80, $02
	smpsLoop	0, 4, .1
	dc.b	$A5, $0A, $80, $02
	dc.b	$B1, $04, $80, $02
	dc.b	$B1, $04, $80, $02
	dc.b	$A3, $0A, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$A1, $0A, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$AC, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_0B:
.0:
	dc.b	$FC, $01			; set note volume (advanced SMPS only!)
	dc.b	$A6, $01, $80, $5F
	smpsLoop	0, 1, .0
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_0C:
	smpsFMvoice	$03
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $2E, $80, $02
	dc.b	$A6, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_0D:
	smpsFMvoice	$08
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $17
	smpsLoop	0, 3, .0
	smpsFMvoice	$07
	dc.b	$B4, $01, $80, $0B
	dc.b	$B4, $01, $80, $0B
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_0E:
	smpsFMvoice	$05
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AA, $2E, $80, $02
	dc.b	$AC, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_0F:
	smpsFMvoice	$05
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $2E, $80, $02
	dc.b	$A8, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_10:
	smpsFMvoice	$06
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B9, $22, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B4, $0C, $E7
	dc.b	$B4, $2E, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$BB, $22, $80, $02
	dc.b	$BD, $16, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B9, $22, $80, $02
	dc.b	$B8, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_11:
	smpsFMvoice	$06
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B6, $22, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B1, $0C, $E7
	dc.b	$B1, $2E, $80, $02
	dc.b	$B1, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B8, $22, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B6, $22, $80, $02
	dc.b	$B4, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_12:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AD, $5E, $80, $02
	dc.b	$AF, $22, $80, $02
	dc.b	$AD, $22, $80, $02
	dc.b	$AC, $16, $80, $02
	dc.b	$A8, $22, $80, $02
	dc.b	$AD, $22, $80, $02
	dc.b	$AF, $16, $80, $02
	dc.b	$B1, $2E, $80, $02
	dc.b	$AF, $16, $80, $02
	dc.b	$AC, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_13:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AA, $5E, $80, $02
	dc.b	$AC, $22, $80, $02
	dc.b	$AA, $22, $80, $02
	dc.b	$A8, $16, $80, $02
	dc.b	$A5, $22, $80, $02
	dc.b	$AA, $22, $80, $02
	dc.b	$AC, $16, $80, $02
	dc.b	$AD, $2E, $80, $02
	dc.b	$AC, $16, $80, $02
	dc.b	$A8, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_14:
	smpsFMvoice	$01
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $0A, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	smpsLoop	0, 6, .0
	smpsFMvoice	$02
	dc.b	$A8, $10, $80, $02
	dc.b	$A8, $10, $80, $02
	dc.b	$A8, $0A, $80, $02
	smpsFMvoice	$01
.1:
	dc.b	$A6, $0A, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	smpsLoop	0, 6, .1
	smpsFMvoice	$02
.2:
	dc.b	$A8, $04, $80, $02
	smpsLoop	0, 8, .2
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_15:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $0B
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	smpsFMvoice	$07
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 3, .0
	smpsFMvoice	$08
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $0B
	smpsFMvoice	$07
	dc.b	$B4, $01, $80, $0B
	dc.b	$B4, $01, $80, $0B
.1:
	smpsFMvoice	$08
	dc.b	$A8, $01, $80, $0B
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	smpsFMvoice	$07
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 2, .1
.2:
	dc.b	$B2, $01, $80, $0B
	smpsLoop	0, 4, .2
	smpsFMvoice	$08
	dc.b	$BC, $01, $80, $02
	dc.b	$BC, $01, $80, $02
	dc.b	$BB, $01, $80, $02
	dc.b	$BB, $01, $80, $02
	dc.b	$B9, $01, $80, $05
	dc.b	$B9, $01, $80, $05
	dc.b	$B7, $01, $80, $05
	dc.b	$B7, $01, $80, $05
	dc.b	$B2, $01, $80, $05
	dc.b	$B2, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_16:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $5E, $80, $02
	dc.b	$B8, $5E, $80, $02
	dc.b	$B4, $60, $E7
	dc.b	$B1, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_17:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $17
	smpsFMvoice	$07
	dc.b	$B2, $01, $80, $17
	smpsFMvoice	$08
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $0B
	smpsFMvoice	$07
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 4, .0
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_18:
.0:
.1:
	smpsFMvoice	$01
.2:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BE, $04, $80, $02
	smpsLoop	2, 4, .2
	smpsLoop	1, 6, .1
.3:
	smpsFMvoice	$01
	dc.b	$BE, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	smpsFMvoice	$02
	dc.b	$BE, $0A, $80, $02
	smpsLoop	1, 2, .3
	smpsLoop	0, 2, .0
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_19:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $5E, $80, $02
	dc.b	$B8, $2E, $80, $02
	dc.b	$B4, $2E, $80, $02
	dc.b	$FB, $5E		; set portamento speed (SMPS/TS)
	dc.b	$BD, $5E, $80, $02
	dc.b	$BB, $2E, $80, $02
	dc.b	$B8, $2E, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_1A:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B9, $22, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B4, $0C, $E7
	dc.b	$B4, $2E, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$BD, $16, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B6, $22, $80, $02
	dc.b	$B8, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_1B:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B6, $22, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B1, $0C, $E7
	dc.b	$B1, $2E, $80, $02
	dc.b	$B1, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B2, $22, $80, $02
	dc.b	$B4, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_1C:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9E, $0A, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$AA, $04, $80, $02
	smpsLoop	0, 8, .0
.1:
	dc.b	$9C, $0A, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	smpsLoop	0, 4, .1
.2:
	dc.b	$99, $0A, $80, $02
	dc.b	$A5, $04, $80, $02
	dc.b	$A5, $04, $80, $02
	smpsLoop	0, 4, .2
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_1D:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9A, $0A, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	smpsLoop	0, 16, .0
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_1E:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $17
	smpsFMvoice	$07
	dc.b	$B2, $01, $80, $17
	smpsFMvoice	$08
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $0B
	smpsFMvoice	$07
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 3, .0
	smpsFMvoice	$08
	dc.b	$A8, $01, $80, $17
	smpsFMvoice	$07
	dc.b	$B2, $01, $80, $17
.1:
	dc.b	$B9, $01, $80, $0B
	smpsLoop	0, 4, .1
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_1F:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B9, $22, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B4, $0C, $E7
	dc.b	$B4, $2E, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$BD, $16, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B6, $22, $80, $02
	dc.b	$B4, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_20:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B6, $22, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B1, $0C, $E7
	dc.b	$B1, $2E, $80, $02
	dc.b	$B1, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B2, $22, $80, $02
	dc.b	$B1, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_21:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $17
	smpsFMvoice	$07
	dc.b	$B4, $01, $80, $17
	smpsFMvoice	$08
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $0B
	smpsFMvoice	$07
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 3, .0
	smpsFMvoice	$08
	dc.b	$A8, $01, $80, $17
	smpsFMvoice	$07
	dc.b	$B4, $01, $80, $17
	dc.b	$B9, $01, $80, $0B
	dc.b	$B9, $01, $80, $0B
.1:
	dc.b	$B9, $01, $80, $05
	smpsLoop	0, 4, .1
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_22:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $22, $80, $02
	dc.b	$B9, $22, $80, $02
	dc.b	$BD, $16, $80, $02
	dc.b	$C0, $22, $80, $02
	dc.b	$BE, $22, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$BD, $5E, $80, $02
	dc.b	$BB, $2E, $80, $02
	dc.b	$B8, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_23:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $22, $80, $02
	dc.b	$B6, $22, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$BD, $22, $80, $02
	dc.b	$BB, $22, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B9, $5E, $80, $02
	dc.b	$B8, $2E, $80, $02
	dc.b	$B4, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_24:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	; This Z80_MusicBank_1_Stage_7_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_25:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $5E, $80, $02
	dc.b	$C0, $5E, $80, $02
	dc.b	$BD, $5E, $80, $02
	dc.b	$BB, $2E, $80, $02
	dc.b	$B8, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_26:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $5E, $80, $02
	dc.b	$B8, $2E, $80, $02
	dc.b	$B4, $2E, $80, $02
	dc.b	$FB, $5E		; set portamento speed (SMPS/TS)
	dc.b	$BD, $5E, $80, $02
	dc.b	$BB, $2E, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$FB, $54		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_27:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $60, $E7
	dc.b	$B9, $2E, $80, $02
	dc.b	$BB, $2E, $80, $02
	dc.b	$B9, $60, $E7
	dc.b	$B2, $2E, $80, $02
	dc.b	$B1, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_28:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B8, $22, $80, $02
	dc.b	$B9, $22, $80, $02
	dc.b	$BB, $0C, $E7
	dc.b	$BB, $2E, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B4, $22, $80, $02
	dc.b	$B2, $22, $80, $02
	dc.b	$B1, $0C, $E7
	dc.b	$B1, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_29:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $0A, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B2, $16, $80, $02
	dc.b	$B4, $22, $80, $02
	dc.b	$B6, $22, $80, $02
	dc.b	$B8, $0C, $E7
	dc.b	$B8, $2E, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B2, $16, $80, $02
	dc.b	$B1, $22, $80, $02
	dc.b	$AF, $22, $80, $02
	dc.b	$AD, $0C, $E7
	dc.b	$AD, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_2A:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9E, $0A, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$AA, $04, $80, $02
	smpsLoop	0, 16, .0
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_2B:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	; This Z80_MusicBank_1_Stage_7_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_2C:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BE, $60, $E7
	dc.b	$BE, $0A, $80, $02
	dc.b	$BE, $0A, $80, $02
	dc.b	$C0, $0A, $80, $02
	dc.b	$BE, $0A, $80, $02
	dc.b	$BD, $0A, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$BB, $22, $80, $02
	dc.b	$BD, $0C, $E7
	dc.b	$BD, $30, $E7
	dc.b	$BD, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_2D:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BB, $60, $E7
	dc.b	$BB, $0A, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$BD, $0A, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B8, $22, $80, $02
	dc.b	$B9, $0C, $E7
	dc.b	$B9, $30, $E7
	dc.b	$B9, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_2E:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BE, $60, $E7
	dc.b	$BE, $5E, $80, $02
	dc.b	$BB, $22, $80, $02
	dc.b	$BD, $22, $80, $02
	dc.b	$BE, $16, $80, $02
	dc.b	$BB, $22, $80, $02
	dc.b	$BD, $0C, $E7
	dc.b	$BD, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_2F:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B8, $22, $80, $02
	dc.b	$B9, $22, $80, $02
	dc.b	$BB, $0C, $E7
	dc.b	$BB, $2E, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B4, $22, $80, $02
	dc.b	$FB, $5A		; set portamento speed (SMPS/TS)
	dc.b	$BE, $22, $80, $02
	dc.b	$BD, $0C, $E7
	dc.b	$BD, $2E, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_30:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $0A, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B2, $16, $80, $02
	dc.b	$B4, $22, $80, $02
	dc.b	$B6, $22, $80, $02
	dc.b	$B8, $0C, $E7
	dc.b	$B8, $2E, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B2, $16, $80, $02
	dc.b	$B1, $22, $80, $02
	dc.b	$FB, $5A		; set portamento speed (SMPS/TS)
	dc.b	$BB, $22, $80, $02
	dc.b	$B9, $0C, $E7
	dc.b	$B9, $2E, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_31:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BB, $60, $E7
	dc.b	$BB, $0A, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$BD, $0A, $80, $02
	dc.b	$BE, $0A, $80, $02
	dc.b	$BD, $0A, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$BB, $22, $80, $02
	dc.b	$B9, $0C, $E7
	dc.b	$B9, $30, $E7
	dc.b	$B9, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_32:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B8, $60, $E7
	dc.b	$B8, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B8, $22, $80, $02
	dc.b	$B6, $0C, $E7
	dc.b	$B6, $30, $E7
	dc.b	$B6, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_33:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BB, $5E, $80, $02
	dc.b	$BB, $5E, $80, $02
	dc.b	$B9, $5E, $80, $02
	dc.b	$BB, $22, $80, $02
	dc.b	$B9, $0C, $E7
	dc.b	$B9, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_34:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	; This Z80_MusicBank_1_Stage_7_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_35:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	; This Z80_MusicBank_1_Stage_7_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_36:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BB, $60, $E7
	dc.b	$BB, $0A, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$BD, $0A, $80, $02
	dc.b	$BE, $0A, $80, $02
	dc.b	$BD, $0A, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$BB, $22, $80, $02
	dc.b	$B9, $0C, $E7
	dc.b	$B9, $2E, $80, $02
	dc.b	$B8, $22, $80, $02
	dc.b	$B6, $0C, $E7
	dc.b	$B6, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_37:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B8, $60, $E7
	dc.b	$B8, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B8, $22, $80, $02
	dc.b	$B6, $0C, $E7
	dc.b	$B6, $2E, $80, $02
	dc.b	$B4, $22, $80, $02
	dc.b	$B2, $0C, $E7
	dc.b	$B2, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_38:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $0A, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B8, $2E, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$BD, $0A, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B8, $2E, $80, $02
	dc.b	$B9, $2E, $80, $02
	dc.b	$BB, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_39:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $0A, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B8, $2E, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$BD, $0A, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B8, $2E, $80, $02
	dc.b	$B9, $22, $80, $02
	dc.b	$BB, $22, $80, $02
	dc.b	$BD, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_3A:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $5E, $80, $02
	dc.b	$B8, $5E, $80, $02
	dc.b	$B9, $5E, $80, $02
	dc.b	$BB, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_3B:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $0A, $80, $02
	dc.b	$B1, $16, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B4, $2E, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B1, $16, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B4, $2E, $80, $02
	dc.b	$B6, $2E, $80, $02
	dc.b	$B8, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_3C:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $0A, $80, $02
	dc.b	$B1, $16, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B4, $2E, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B1, $16, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B4, $2E, $80, $02
	dc.b	$B6, $22, $80, $02
	dc.b	$B8, $22, $80, $02
	dc.b	$B9, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_3D:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9E, $0A, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$AA, $04, $80, $02
	smpsLoop	0, 16, .0
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_3E:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BB, $5E, $80, $02
	dc.b	$BB, $5E, $80, $02
	dc.b	$B9, $5E, $80, $02
	dc.b	$B8, $22, $80, $02
	dc.b	$B9, $0C, $E7
	dc.b	$B9, $01, $E7
	dc.b	$FB, $60		; set portamento speed (SMPS/TS)
	dc.b	$95, $2E, $80, $01
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_3F:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $0A, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B8, $2E, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$BD, $0A, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B8, $2E, $80, $02
	dc.b	$B6, $22, $80, $02
	dc.b	$B8, $22, $80, $02
	dc.b	$B9, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_40:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $0A, $80, $02
	dc.b	$B1, $16, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B4, $2E, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B1, $16, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B4, $2E, $80, $02
	dc.b	$B2, $22, $80, $02
	dc.b	$B4, $22, $80, $02
	dc.b	$B6, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_41:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9E, $0A, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$AA, $04, $80, $02
	smpsLoop	0, 12, .0
	dc.b	$9C, $0A, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$9E, $0A, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$A0, $0A, $80, $02
	dc.b	$AC, $04, $80, $02
	dc.b	$AC, $04, $80, $02
	dc.b	$A1, $0A, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$AD, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_42:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $5E, $80, $02
	dc.b	$B8, $5E, $80, $02
	dc.b	$B9, $5E, $80, $02
	dc.b	$B6, $22, $80, $02
	dc.b	$B8, $22, $80, $02
	dc.b	$B9, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_43:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	; This Z80_MusicBank_1_Stage_7_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_44:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $5E, $80, $02
	dc.b	$B8, $5E, $80, $02
	dc.b	$B9, $2E, $80, $02
	dc.b	$BD, $2E, $80, $02
	dc.b	$BB, $2E, $80, $02
	dc.b	$B8, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_45:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $17
	smpsFMvoice	$07
	dc.b	$B4, $01, $80, $17
	smpsFMvoice	$08
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $0B
	smpsFMvoice	$07
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 3, .0
	smpsFMvoice	$08
	dc.b	$A8, $01, $80, $17
	smpsFMvoice	$07
	dc.b	$B4, $01, $80, $17
	dc.b	$B9, $02, $80, $10
	dc.b	$B5, $02, $80, $10
	dc.b	$B2, $01, $80, $0B
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_46:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $17
	smpsFMvoice	$07
	dc.b	$B4, $01, $80, $17
	smpsFMvoice	$08
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $0B
	smpsFMvoice	$07
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 3, .0
	smpsFMvoice	$08
	dc.b	$A8, $01, $80, $0B
	smpsFMvoice	$07
	dc.b	$B4, $01, $80, $0B
	dc.b	$B4, $01, $80, $0B
	dc.b	$B4, $01, $80, $0B
	smpsFMvoice	$08
	dc.b	$B9, $01, $80, $05
	dc.b	$B7, $01, $80, $05
	dc.b	$B5, $01, $80, $05
	dc.b	$B4, $01, $80, $05
	dc.b	$B7, $01, $80, $05
	dc.b	$B5, $01, $80, $05
	dc.b	$B4, $01, $80, $05
	dc.b	$B2, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_47:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A8, $01, $80, $17
	smpsFMvoice	$07
	dc.b	$B4, $01, $80, $17
	smpsFMvoice	$08
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $05
	dc.b	$A8, $01, $80, $0B
	smpsFMvoice	$07
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 3, .0
.1:
	smpsFMvoice	$07
	dc.b	$B4, $01, $80, $0B
	smpsLoop	0, 4, .1
	dc.b	$B9, $01, $80, $0B
	dc.b	$A8, $01, $80, $05
	dc.b	$B7, $01, $80, $0B
	dc.b	$A8, $01, $80, $05
	dc.b	$B5, $01, $80, $0B
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_48:
	dc.b	$FB, $5A		; set portamento speed (SMPS/TS)
	smpsFMvoice	$00
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $60, $E7
	dc.b	$B9, $5E, $80, $02
	dc.b	$B1, $60, $E7
	dc.b	$B1, $2E, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B8, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_49:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	; This Z80_MusicBank_1_Stage_7_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_4A:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	; This Z80_MusicBank_1_Stage_7_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_4B:
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $5E, $80, $02
	dc.b	$B8, $22, $80, $02
	dc.b	$B9, $22, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$BD, $5E, $80, $02
	dc.b	$FB, $5A		; set portamento speed (SMPS/TS)
	dc.b	$BB, $2E, $80, $02
	dc.b	$B8, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_4C:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	; This Z80_MusicBank_1_Stage_7_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_4D:
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $16, $80, $02
	dc.b	$AD, $0C, $E7
	dc.b	$B9, $E7
	dc.b	$B9, $30, $E7
	dc.b	$B9, $46, $80, $02
	dc.b	$FB, $5E		; set portamento speed (SMPS/TS)
	dc.b	$95, $16, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$B1, $16, $80, $02
	dc.b	$A5, $0C, $E7
	dc.b	$B1, $E7
	dc.b	$B1, $30, $E7
	dc.b	$B1, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_4E:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	; This Z80_MusicBank_1_Stage_7_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_4F:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $16, $80, $02
	dc.b	$AD, $0C, $E7
	dc.b	$B9, $E7
	dc.b	$B9, $E7
	dc.b	$B9, $2E, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$BD, $16, $80, $02
	dc.b	$B1, $0C, $E7
	dc.b	$BD, $E7
	dc.b	$BD, $30, $E7
	dc.b	$BB, $2E, $80, $02
	dc.b	$B8, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_50:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	; This Z80_MusicBank_1_Stage_7_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_51:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $0A, $80, $02
	dc.b	$B6, $22, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B9, $16, $80, $02
	smpsLoop	0, 3, .0
	dc.b	$BD, $16, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$B9, $22, $80, $02
	dc.b	$B8, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_52:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	; This Z80_MusicBank_1_Stage_7_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_53:
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $16, $80, $02
	dc.b	$AD, $0C, $E7
	dc.b	$B9, $E7
	dc.b	$B9, $30, $E7
	dc.b	$B9, $5E, $80, $02
	smpsLoop	0, 2, .0
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_54:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	; This Z80_MusicBank_1_Stage_7_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_55:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BE, $22, $80, $02
	dc.b	$BD, $22, $80, $02
	dc.b	$BB, $16, $80, $02
	smpsLoop	0, 3, .0
	dc.b	$BE, $2E, $80, $02
	dc.b	$BD, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_56:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	; This Z80_MusicBank_1_Stage_7_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_57:
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BB, $22, $80, $02
	dc.b	$BD, $22, $80, $02
	dc.b	$BE, $16, $80, $02
	smpsLoop	0, 3, .0
	dc.b	$BB, $2E, $80, $02
	dc.b	$B9, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_58:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	; This Z80_MusicBank_1_Stage_7_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_59:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $22, $80, $02
	dc.b	$B8, $0C, $E7
	dc.b	$B8, $2E, $80, $02
	dc.b	$BD, $22, $80, $02
	dc.b	$BB, $22, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B9, $22, $80, $02
	dc.b	$B8, $0C, $E7
	dc.b	$B8, $2E, $80, $02
	dc.b	$B9, $22, $80, $02
	dc.b	$BB, $0C, $E7
	dc.b	$BB, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_5A:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	; This Z80_MusicBank_1_Stage_7_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_5B:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	; This Z80_MusicBank_1_Stage_7_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_5C:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $5E, $80, $02
	dc.b	$B8, $22, $80, $02
	dc.b	$B9, $22, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$BD, $5E, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	dc.b	$BB, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_5D:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	; This Z80_MusicBank_1_Stage_7_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_5E:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	; This Z80_MusicBank_1_Stage_7_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_5F:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $22, $80, $02
	dc.b	$B8, $0C, $E7
	dc.b	$B8, $2E, $80, $02
	dc.b	$BD, $22, $80, $02
	dc.b	$BB, $22, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B9, $22, $80, $02
	dc.b	$B8, $0C, $E7
	dc.b	$B8, $2E, $80, $02
	dc.b	$B9, $22, $80, $02
	dc.b	$BB, $22, $80, $02
	dc.b	$BD, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_60:
	; This Z80_MusicBank_1_Stage_7_Pattern is unused
	; This Z80_MusicBank_1_Stage_7_Pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_61:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $22, $80, $02
	dc.b	$B8, $0C, $E7
	dc.b	$B8, $2E, $80, $02
	dc.b	$BD, $22, $80, $02
	dc.b	$BB, $22, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B9, $22, $80, $02
	dc.b	$B8, $0C, $E7
	dc.b	$B8, $2E, $80, $02
	dc.b	$9E, $0A, $80, $02
	dc.b	$AA, $0A, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$A0, $0A, $80, $02
	dc.b	$AC, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$AD, $0A, $80, $02
	dc.b	$B9, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Z80_MusicBank_1_Stage_7_Pattern_62:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $16, $80, $02
	dc.b	$AD, $0C, $E7
	dc.b	$B9, $E7
	dc.b	$B9, $30, $E7
	dc.b	$B9, $5E, $80, $02
.0:
	dc.b	$BD, $16, $80, $02
	dc.b	$B1, $0C, $E7
	dc.b	$BD, $E7
	dc.b	$BD, $2E, $80, $02
	smpsLoop	0, 2, .0
	smpsReturn

; ---------------------------------------------------------------
; Z80_MusicBank_1_Stage_7_Voices
; ---------------------------------------------------------------

Z80_MusicBank_1_Stage_7_Voices:
	; Voice $00 (Z80_MusicBank_1_Stage_7_FM)
	dc.b	$F8, $52, $33, $21, $02, $18, $1C, $1C, $19, $00, $00, $00, $02, $00, $04, $04, $00, $24, $04, $04, $12, $1A, $15, $16, $00
	; Voice $01 (Z80_MusicBank_1_Stage_7_FM)
	dc.b	$FD, $07, $04, $0A, $0C, $1F, $1F, $1F, $1F, $8B, $93, $93, $93, $04, $04, $04, $04, $C6, $F6, $F6, $B6, $00, $00, $00, $00
	; Voice $02 (Z80_MusicBank_1_Stage_7_FM)
	dc.b	$FC, $0A, $0F, $0A, $0E, $1B, $1F, $17, $9F, $0B, $0E, $0A, $0D, $04, $04, $08, $04, $B6, $B6, $B6, $B6, $00, $00, $00, $00
	; Voice $03 (Z80_MusicBank_1_Stage_7_FM)
	dc.b	$FC, $36, $5F, $5B, $58, $17, $1F, $1F, $9B, $00, $0B, $07, $09, $08, $08, $06, $08, $44, $F4, $74, $B4, $00, $00, $00, $00
	; Voice $04 (Z80_MusicBank_1_Stage_7_FM)
	dc.b	$F8, $61, $08, $00, $30, $DF, $DF, $9F, $9F, $07, $0E, $0B, $86, $07, $06, $06, $08, $75, $55, $95, $F5, $14, $2B, $0B, $00
	; Voice $05 (Z80_MusicBank_1_Stage_7_FM)
	dc.b	$BB, $4C, $28, $76, $42, $1F, $1F, $1F, $9F, $03, $03, $03, $03, $01, $01, $01, $01, $32, $32, $32, $32, $21, $20, $23, $00
	; Voice $06 (Z80_MusicBank_1_Stage_7_FM)
	dc.b	$FB, $32, $76, $72, $32, $8D, $4F, $15, $52, $0A, $08, $07, $07, $06, $00, $00, $00, $03, $03, $03, $03, $15, $20, $26, $00
	; Voice $07 (Z80_MusicBank_1_Stage_7_FM)
	dc.b	$FE, $00, $00, $00, $00, $1F, $1F, $1F, $1F, $05, $00, $00, $00, $00, $0B, $15, $09, $06, $06, $34, $00, $00, $00, $00, $00
	; Voice $08 (Z80_MusicBank_1_Stage_7_FM)
	dc.b	$FE, $00, $00, $00, $00, $1F, $1F, $1F, $1F, $09, $09, $00, $00, $09, $06, $00, $00, $02, $4A, $02, $02, $00, $00, $00, $00
