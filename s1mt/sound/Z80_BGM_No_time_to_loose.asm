
; ---------------------------------------------------------------
; Created by Techosoft-2-SMPS v.2.70
; 2014, Vladikcomper
; ---------------------------------------------------------------
No_Time_To_Lose:
; ---------------------------------------------------------------
; Music Header
; ---------------------------------------------------------------

	dc.w	No_Time_To_Lose_Voices-No_Time_To_Lose			; Voice bank offset
	dc.w	$8700			; Number of No_Time_To_Lose_FM/PSG channels
	dc.w	$0100			; Tempo modifier

	dc.w	$0008, $F200		; Disable DAC channel
	dc.w	No_Time_To_Lose_FM1-No_Time_To_Lose, $004F
	dc.w	No_Time_To_Lose_FM2-No_Time_To_Lose, $004F
	dc.w	No_Time_To_Lose_FM3-No_Time_To_Lose, $004F
	dc.w	No_Time_To_Lose_FM4-No_Time_To_Lose, $0050
	dc.w	No_Time_To_Lose_FM5-No_Time_To_Lose, $0050
	dc.w	No_Time_To_Lose_FM6-No_Time_To_Lose, $0050

; ---------------------------------------------------------------
; Music Tracks
; ---------------------------------------------------------------

No_Time_To_Lose_FM1:
	dc.b	$FA, $00		; setup portamento mode 0 (advanced SMPS only!)
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
.Loop:
	smpsCall	Pattern_00
	smpsCall	Pattern_00
	smpsCall	Pattern_0C
	smpsCall	Pattern_11
	smpsCall	Pattern_1B
	smpsCall	Pattern_11
	smpsCall	Pattern_1B
	smpsCall	Pattern_24
	smpsCall	Pattern_25
	smpsCall	Pattern_24
	smpsCall	Pattern_3A
	smpsFMvoice	$05
	smpsCall	Pattern_2F
	smpsCall	Pattern_37
	smpsJump	.Loop

; ---------------------------------------------------------------
No_Time_To_Lose_FM2:
	dc.b	$FA, $00		; setup portamento mode 0 (advanced SMPS only!)
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
.Loop:
	smpsCall	Pattern_01
	smpsCall	Pattern_01
	smpsCall	Pattern_0D
	smpsCall	Pattern_16
	smpsCall	Pattern_1C
	smpsCall	Pattern_16
	smpsCall	Pattern_1C
	smpsCall	Pattern_27
	smpsCall	Pattern_28
	smpsCall	Pattern_27
	smpsCall	Pattern_3B
	smpsFMvoice	$05
	smpsCall	Pattern_31
	smpsCall	Pattern_30
	smpsJump	.Loop

; ---------------------------------------------------------------
No_Time_To_Lose_FM3:
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
.Loop:
	smpsCall	Pattern_0B
	smpsCall	Pattern_02
	smpsCall	Pattern_0E
	smpsCall	Pattern_1D
	smpsCall	Pattern_17
	smpsCall	Pattern_1D
	smpsCall	Pattern_2E
	smpsCall	Pattern_23
	smpsCall	Pattern_26
	smpsCall	Pattern_23
	smpsCall	Pattern_26
	smpsCall	Pattern_32
	smpsCall	Pattern_39
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	smpsJump	.Loop

; ---------------------------------------------------------------
No_Time_To_Lose_FM4:
	smpsPan		$80, 0
No_Time_To_Lose_FM4_Loop:
	smpsCall	Pattern_03
	smpsCall	Pattern_0A
	smpsCall	Pattern_10
	smpsCall	Pattern_1A
	smpsCall	Pattern_20
	smpsCall	Pattern_1A
	smpsCall	Pattern_33
	dc.b	$E6, $F8		; alter note volume (SMPS/TS)
	smpsCall	Pattern_29
	smpsCall	Pattern_2A
	smpsCall	Pattern_29
	smpsCall	Pattern_34
	smpsCall	Pattern_38
	smpsCall	Pattern_35
	dc.b	$E6, $00		; alter note volume (SMPS/TS)
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsPan		$80, 0
	smpsJump	No_Time_To_Lose_FM4_Loop

; ---------------------------------------------------------------
No_Time_To_Lose_FM5:
	dc.b	$FA, $03		; setup portamento mode 3 (advanced SMPS only!)
	dc.b	$FB, $0A		; set portamento speed (SMPS/TS)
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
.Loop:
	smpsCall	Pattern_05
	smpsCall	Pattern_08
	smpsCall	Pattern_0F
	smpsCall	Pattern_18
	smpsCall	Pattern_21
	smpsCall	Pattern_18
	smpsCall	Pattern_22
	smpsCall	Pattern_18
	smpsCall	Pattern_18
	smpsCall	Pattern_18
	smpsCall	Pattern_21
	smpsCall	Pattern_18
	smpsCall	Pattern_18
	smpsJump	.Loop

; ---------------------------------------------------------------
No_Time_To_Lose_FM6:
	smpsPan		$40, 0
	dc.b	$E6, $02		; alter note volume (SMPS/TS)
.Loop:
	smpsCall	Pattern_04
	smpsCall	Pattern_04
	smpsCall	Pattern_09
	smpsCall	Pattern_19
	smpsCall	Pattern_19
	smpsCall	Pattern_19
	smpsCall	Pattern_19
	smpsCall	Pattern_1E
	smpsCall	Pattern_1E
	smpsCall	Pattern_1E
	smpsCall	Pattern_1E
	smpsCall	Pattern_36
	smpsCall	Pattern_36
	smpsJump	.Loop

; ---------------------------------------------------------------
; Patterns
; ---------------------------------------------------------------

Pattern_00:
	smpsFMvoice	$04
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $16, $80, $02
	dc.b	$FB, $54		; set portamento speed (SMPS/TS)
	dc.b	$B8, $16, $80, $02
	dc.b	$BD, $0A, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B9, $2E, $80, $02
	dc.b	$B4, $2E, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$BD, $0A, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B9, $2E, $80, $02
	dc.b	$BB, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_01:
	smpsFMvoice	$04
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $16, $80, $02
	dc.b	$FB, $54		; set portamento speed (SMPS/TS)
	dc.b	$B4, $16, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B6, $2E, $80, $02
	dc.b	$B1, $2E, $80, $02
	dc.b	$B2, $16, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	dc.b	$B6, $2E, $80, $02
	dc.b	$B8, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_02:
	smpsFMvoice	$01
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9E, $0A, $80, $02
	dc.b	$AA, $0A, $80, $02
	dc.b	$9E, $46, $80, $02
	dc.b	$9C, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$9C, $46, $80, $02
	dc.b	$9A, $0A, $80, $02
	dc.b	$A6, $0A, $80, $02
	dc.b	$9A, $46, $80, $02
	dc.b	$99, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$B1, $0A, $80, $02
	dc.b	$9A, $0A, $80, $02
	dc.b	$A6, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$9C, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_03:
	smpsFMvoice	$00
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C2, $5E, $80, $02
	dc.b	$C0, $5E, $80, $02
	dc.b	$BE, $5E, $80, $02
	dc.b	$BD, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_04:
.0:
	smpsFMvoice	$03
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BE, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$BE, $46, $80, $02
	smpsLoop	0, 3, .0
	dc.b	$FC, $00			; set note volume (advanced SMPS only!)
	dc.b	$BE, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_05:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $01, $80, $0B
	dc.b	$A6, $01, $80, $0B
	dc.b	$A6, $01, $80, $2F
	smpsFMvoice	$07
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 3, .0
	smpsFMvoice	$08
	smpsPan		$80, 0
	dc.b	$BD, $01, $80, $02
	dc.b	$BD, $01, $80, $02
	dc.b	$BD, $01, $80, $02
	dc.b	$BD, $01, $80, $02
	dc.b	$BB, $01, $80, $05
	dc.b	$BB, $01, $80, $05
	dc.b	$BB, $01, $80, $05
	dc.b	$BB, $01, $80, $05
	smpsPan		$C0, 0
	dc.b	$FC, $5E			; set note volume (advanced SMPS only!)
	dc.b	$B9, $01, $80, $05
	dc.b	$B9, $01, $80, $05
	dc.b	$B9, $01, $80, $05
	smpsPan		$40, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B9, $01, $80, $05
	dc.b	$B1, $01, $80, $05
	dc.b	$B1, $01, $80, $05
	dc.b	$B1, $01, $80, $05
	dc.b	$B1, $01, $80, $05
	dc.b	$AF, $01, $80, $05
	dc.b	$AF, $01, $80, $05
	smpsPan		$C0, 0
	smpsReturn

; ---------------------------------------------------------------
Pattern_06:
	; This pattern is unused
	smpsFMvoice	$00
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AA, $5E, $80, $02
	dc.b	$FB, $50		; set portamento speed (SMPS/TS)
	dc.b	$A8, $5E, $80, $02
	dc.b	$A6, $5E, $80, $02
	dc.b	$A5, $22, $80, $02
	dc.b	$A6, $22, $80, $02
	dc.b	$A8, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_07:
	; This pattern is unused
	smpsFMvoice	$00
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $5E, $80, $02
	dc.b	$FB, $50		; set portamento speed (SMPS/TS)
	dc.b	$A5, $5E, $80, $02
	dc.b	$A3, $5E, $80, $02
	dc.b	$A2, $22, $80, $02
	dc.b	$A3, $22, $80, $02
	dc.b	$A5, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_08:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $01, $80, $0B
	dc.b	$A6, $01, $80, $0B
	dc.b	$A6, $01, $80, $2F
	smpsFMvoice	$07
	dc.b	$B2, $01, $80, $17
	smpsLoop	0, 3, .0
	smpsFMvoice	$08
	dc.b	$BB, $01, $80, $05
	dc.b	$B9, $01, $80, $05
	dc.b	$B7, $01, $80, $05
	dc.b	$B5, $01, $80, $05
	dc.b	$BD, $01, $80, $05
	dc.b	$BB, $01, $80, $05
	dc.b	$B9, $01, $80, $05
	dc.b	$B7, $01, $80, $05
	dc.b	$BE, $01, $80, $05
	dc.b	$BD, $01, $80, $05
	dc.b	$B9, $01, $80, $05
	dc.b	$BB, $01, $80, $05
	dc.b	$C0, $01, $80, $05
	dc.b	$BE, $01, $80, $05
	dc.b	$BD, $01, $80, $05
	dc.b	$BB, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
Pattern_09:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BE, $0A, $80, $02
	dc.b	$BE, $0A, $80, $02
	smpsLoop	0, 16, .0
	smpsReturn

; ---------------------------------------------------------------
Pattern_0A:
	smpsFMvoice	$00
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$C2, $5E, $80, $02
	dc.b	$C0, $5E, $80, $02
	dc.b	$BE, $5E, $80, $02
	smpsPan		$C0, 0
	smpsFMvoice	$02
	dc.b	$8D, $03
	dc.b	$FB, $5E		; set portamento speed (SMPS/TS)
	dc.b	$D5, $5D
	smpsReturn

; ---------------------------------------------------------------
Pattern_0B:
	smpsFMvoice	$01
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9E, $0A, $80, $02
	dc.b	$AA, $0A, $80, $02
	dc.b	$9E, $46, $80, $02
	dc.b	$9C, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$9C, $46, $80, $02
	dc.b	$9A, $0A, $80, $02
	dc.b	$A6, $0A, $80, $02
	dc.b	$9A, $46, $80, $02
	dc.b	$99, $22, $80, $02
	dc.b	$9A, $22, $80, $02
	dc.b	$9C, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_0C:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $60, $E7
	dc.b	$B6, $E7
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$C2, $E7
	dc.b	$C2, $0C, $E7
	dc.b	$C2, $2E, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsFMvoice	$05
	dc.b	$B1, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_0D:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $60, $E7
	dc.b	$B2, $E7
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$BE, $E7
	dc.b	$BE, $0C, $E7
	dc.b	$BE, $2E, $80, $02
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsFMvoice	$05
	dc.b	$AD, $0A, $80, $02
	dc.b	$AF, $0A, $80, $02
	dc.b	$B1, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_0E:
.0:
	dc.b	$FC, $62			; set note volume (advanced SMPS only!)
	dc.b	$9E, $0A, $80, $02
	dc.b	$AA, $04, $80, $02
	smpsPan		$40, 0
	dc.b	$B6, $04, $80, $02
	smpsPan		$C0, 0
	dc.b	$A0, $0A, $80, $02
	dc.b	$AC, $0A, $80, $02
	dc.b	$A1, $0A, $80, $02
	dc.b	$AD, $04, $80, $02
	smpsPan		$80, 0
	dc.b	$B9, $04, $80, $02
	smpsPan		$C0, 0
	dc.b	$A3, $0A, $80, $02
	dc.b	$AF, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$B1, $04, $80, $02
	smpsPan		$40, 0
	dc.b	$BD, $04, $80, $02
	smpsPan		$C0, 0
	dc.b	$A6, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$B4, $04, $80, $02
	smpsPan		$80, 0
	dc.b	$C0, $04, $80, $02
	smpsPan		$C0, 0
	dc.b	$A5, $04, $80, $02
	dc.b	$B2, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$B6, $04, $80, $02
	smpsLoop	0, 2, Pattern_0E
	smpsReturn

; ---------------------------------------------------------------
Pattern_0F:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $03, $80, $15
	smpsFMvoice	$07
	dc.b	$B2, $03, $80, $15
	smpsLoop	0, 7, .0
	smpsFMvoice	$08
	dc.b	$A6, $03, $80, $15
	smpsPan		$40, 0
	dc.b	$BD, $01, $80, $05
	smpsPan		$80, 0
	dc.b	$BB, $01, $80, $05
	smpsPan		$C0, 0
	dc.b	$B9, $01, $80, $05
	dc.b	$B7, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
Pattern_10:
	smpsFMvoice	$00
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
Pattern_10_1:
	smpsPan		$40, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AA, $04, $80, $02
	dc.b	$B6, $04, $80, $02
	smpsPan		$C0, 0
	dc.b	$AD, $04, $80, $02
	dc.b	$B9, $04, $80, $02
	smpsPan		$80, 0
	dc.b	$B1, $04, $80, $02
	dc.b	$BD, $04, $80, $02
	smpsPan		$C0, 0
	dc.b	$B6, $04, $80, $02
	dc.b	$C2, $04, $80, $02
	smpsLoop	0, 8, Pattern_10_1
	smpsReturn

; ---------------------------------------------------------------
Pattern_11:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $22, $80, $02
	dc.b	$B8, $22, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$BD, $5E, $80, $02
	dc.b	$B4, $22, $80, $02
	dc.b	$B6, $22, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B4, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_12:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Pattern_13:
	; This pattern is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AA, $60, $E7
	dc.b	$AA, $E7
	dc.b	$AA, $E7
	dc.b	$AA, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_14:
	; This pattern is unused
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $60, $E7
	dc.b	$A6, $E7
	dc.b	$A6, $E7
	dc.b	$A6, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_15:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Pattern_16:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $22, $80, $02
	dc.b	$B4, $22, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B9, $5E, $80, $02
	dc.b	$B1, $22, $80, $02
	dc.b	$B2, $22, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B2, $16, $80, $02
	dc.b	$B1, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_17:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9A, $0A, $80, $02
	dc.b	$A6, $0A, $80, $02
	smpsLoop	0, 4, .0
.1:
	dc.b	$A1, $0A, $80, $02
	dc.b	$AD, $0A, $80, $02
	smpsLoop	0, 4, .1
.2:
	dc.b	$99, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	smpsLoop	0, 4, .2
.3:
	dc.b	$A0, $0A, $80, $02
	dc.b	$AC, $0A, $80, $02
	smpsLoop	0, 4, .3
	smpsReturn

; ---------------------------------------------------------------
Pattern_18:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $03, $80, $15
	smpsFMvoice	$07
	dc.b	$B2, $03, $80, $15
	smpsLoop	0, 8, .0
	smpsReturn

; ---------------------------------------------------------------
Pattern_19:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BE, $0A, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	smpsLoop	0, 16, .0
	smpsReturn

; ---------------------------------------------------------------
Pattern_1A:
	smpsPan		$80, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $5E, $80, $02
	dc.b	$B8, $5E, $80, $02
	dc.b	$B9, $5E, $80, $02
	dc.b	$BB, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_1B:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $22, $80, $02
	dc.b	$B4, $22, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B9, $5E, $80, $02
	dc.b	$B1, $22, $80, $02
	dc.b	$B2, $22, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B8, $2E, $80, $02
	dc.b	$BB, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_1C:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AF, $22, $80, $02
	dc.b	$B1, $22, $80, $02
	dc.b	$B2, $16, $80, $02
	dc.b	$B6, $5E, $80, $02
	dc.b	$AD, $22, $80, $02
	dc.b	$AF, $22, $80, $02
	dc.b	$B1, $16, $80, $02
	dc.b	$B4, $2E, $80, $02
	dc.b	$B8, $2E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_1D:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9E, $0A, $80, $02
	dc.b	$AA, $0A, $80, $02
	smpsLoop	0, 4, .0
.1:
	dc.b	$A0, $0A, $80, $02
	dc.b	$AC, $0A, $80, $02
	smpsLoop	0, 4, .1
.2:
	dc.b	$A1, $0A, $80, $02
	dc.b	$AD, $0A, $80, $02
	smpsLoop	0, 4, .2
.3:
	dc.b	$A3, $0A, $80, $02
	dc.b	$AF, $0A, $80, $02
	smpsLoop	0, 3, .3
	dc.b	$A0, $0A, $80, $02
	dc.b	$9C, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_1E:
.0:
	smpsPan		$40, 0
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BE, $0A, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	smpsPan		$80, 0
	dc.b	$BE, $0A, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	smpsLoop	0, 8, Pattern_1E
	smpsReturn

; ---------------------------------------------------------------
Pattern_1F:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Pattern_20:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $5E, $80, $02
	dc.b	$B9, $5E, $80, $02
	dc.b	$B1, $5E, $80, $02
	dc.b	$B8, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_21:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $03, $80, $15
	smpsFMvoice	$07
	dc.b	$B2, $03, $80, $15
	smpsLoop	0, 7, .0
	smpsFMvoice	$08
	dc.b	$A6, $03, $80, $15
	smpsPan		$40, 0
	dc.b	$B9, $01, $80, $05
	dc.b	$B9, $01, $80, $05
	smpsPan		$80, 0
	dc.b	$B6, $01, $80, $05
	dc.b	$B6, $01, $80, $05
	smpsPan		$C0, 0
	smpsReturn

; ---------------------------------------------------------------
Pattern_22:
.0:
	smpsFMvoice	$08
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$A6, $03, $80, $15
	smpsFMvoice	$07
	dc.b	$B2, $03, $80, $15
	smpsLoop	0, 6, .0
	smpsFMvoice	$08
	dc.b	$BD, $01, $80, $02
	dc.b	$BD, $01, $80, $02
	dc.b	$BD, $01, $80, $02
	dc.b	$BD, $01, $80, $02
	dc.b	$BB, $01, $80, $05
	dc.b	$BB, $01, $80, $05
	dc.b	$BB, $01, $80, $05
	dc.b	$BB, $01, $80, $05
	dc.b	$B9, $01, $80, $05
	dc.b	$B9, $01, $80, $05
	dc.b	$B8, $01, $80, $05
	dc.b	$B8, $01, $80, $05
	dc.b	$B6, $01, $80, $05
	dc.b	$B6, $01, $80, $05
	dc.b	$B1, $01, $80, $05
	dc.b	$B1, $01, $80, $05
	dc.b	$B1, $01, $80, $05
	dc.b	$B1, $01, $80, $05
	smpsReturn

; ---------------------------------------------------------------
Pattern_23:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9E, $0A, $80, $02
	dc.b	$AA, $0A, $80, $02
	dc.b	$9E, $0A, $80, $02
	dc.b	$AC, $0A, $80, $02
	dc.b	$9E, $0A, $80, $02
	dc.b	$AD, $0A, $80, $02
	dc.b	$9E, $0A, $80, $02
	dc.b	$AF, $0A, $80, $02
	dc.b	$A5, $16, $80, $02
	dc.b	$AF, $0A, $80, $02
	dc.b	$A1, $16, $80, $02
	dc.b	$AD, $0A, $80, $02
	dc.b	$9C, $0A, $80, $02
	dc.b	$AA, $0A, $80, $02
	dc.b	$9C, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$9C, $0A, $80, $02
	dc.b	$AA, $0A, $80, $02
	dc.b	$9C, $0A, $80, $02
	dc.b	$AC, $0A, $80, $02
	dc.b	$9C, $0A, $80, $02
	dc.b	$AD, $0A, $80, $02
	dc.b	$A3, $16, $80, $02
	dc.b	$AD, $0A, $80, $02
	dc.b	$A0, $16, $80, $02
	dc.b	$AC, $0A, $80, $02
	dc.b	$9E, $0A, $80, $02
	dc.b	$9C, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_24:
	smpsFMvoice	$04
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B6, $16, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$BD, $0A, $80, $02
	dc.b	$B1, $0C, $E7
	dc.b	$B1, $5E, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$BB, $0A, $80, $02
	dc.b	$AF, $0C, $E7
	dc.b	$AF, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_25:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $16, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$AD, $0C, $E7
	dc.b	$AD, $5E, $80, $02
	dc.b	$B1, $16, $80, $02
	dc.b	$B2, $16, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$BD, $16, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$B8, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_26:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9A, $0A, $80, $02
	dc.b	$A6, $0A, $80, $02
	dc.b	$9A, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$9A, $0A, $80, $02
	dc.b	$AA, $0A, $80, $02
	dc.b	$9A, $0A, $80, $02
	dc.b	$AC, $0A, $80, $02
	dc.b	$AD, $16, $80, $02
	dc.b	$AC, $0A, $80, $02
	dc.b	$AD, $16, $80, $02
	dc.b	$AA, $0A, $80, $02
	dc.b	$9A, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$99, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$99, $0A, $80, $02
	dc.b	$A6, $0A, $80, $02
	dc.b	$99, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$99, $0A, $80, $02
	dc.b	$AA, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$B1, $04, $80, $02
	dc.b	$B1, $04, $80, $02
	dc.b	$A3, $0A, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$AF, $04, $80, $02
	dc.b	$A1, $0A, $80, $02
	dc.b	$AD, $04, $80, $02
	dc.b	$B9, $04, $80, $02
	dc.b	$A0, $0A, $80, $02
	dc.b	$9C, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_27:
	smpsFMvoice	$04
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $16, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$AD, $0C, $E7
	dc.b	$AD, $5E, $80, $02
	dc.b	$B1, $16, $80, $02
	dc.b	$B2, $16, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B8, $0A, $80, $02
	dc.b	$AC, $0C, $E7
	dc.b	$AC, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_28:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AF, $16, $80, $02
	dc.b	$B1, $16, $80, $02
	dc.b	$B2, $16, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$AA, $0C, $E7
	dc.b	$AA, $5E, $80, $02
	dc.b	$AD, $16, $80, $02
	dc.b	$AF, $16, $80, $02
	dc.b	$B1, $16, $80, $02
	dc.b	$B2, $16, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B4, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_29:
	smpsFMvoice	$06
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$CE, $5E, $80, $02
	dc.b	$FB, $54		; set portamento speed (SMPS/TS)
	dc.b	$D5, $04, $80, $02
	dc.b	$D3, $04, $80, $02
	dc.b	$D1, $04, $80, $02
	dc.b	$D0, $04, $80, $02
	dc.b	$D3, $04, $80, $02
	dc.b	$D1, $04, $80, $02
	dc.b	$D0, $04, $80, $02
	dc.b	$CE, $04, $80, $02
	dc.b	$D1, $04, $80, $02
	dc.b	$D0, $04, $80, $02
	dc.b	$CE, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$D0, $04, $80, $02
	dc.b	$CE, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$CA, $04, $80, $02
	dc.b	$CC, $5E, $80, $02
	dc.b	$D3, $04, $80, $02
	dc.b	$D1, $04, $80, $02
	dc.b	$D0, $04, $80, $02
	dc.b	$CE, $04, $80, $02
	dc.b	$D1, $04, $80, $02
	dc.b	$D0, $04, $80, $02
	dc.b	$CE, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$D0, $04, $80, $02
	dc.b	$CE, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$CA, $04, $80, $02
	dc.b	$CE, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$CA, $04, $80, $02
	dc.b	$C9, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_2A:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$CA, $5E, $80, $02
	dc.b	$D0, $04, $80, $02
	dc.b	$CE, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$CA, $04, $80, $02
	dc.b	$CE, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$CA, $04, $80, $02
	dc.b	$C9, $04, $80, $02
	dc.b	$C7, $04, $80, $02
	dc.b	$C9, $04, $80, $02
	dc.b	$CA, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$C9, $04, $80, $02
	dc.b	$CA, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$CE, $04, $80, $02
	dc.b	$C9, $5E, $80, $02
	dc.b	$D5, $04, $80, $02
	dc.b	$D3, $04, $80, $02
	dc.b	$D1, $04, $80, $02
	dc.b	$D0, $04, $80, $02
	dc.b	$CE, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$CA, $04, $80, $02
	dc.b	$C9, $04, $80, $02
	dc.b	$D5, $04, $80, $02
	dc.b	$D3, $04, $80, $02
	dc.b	$D1, $04, $80, $02
	dc.b	$D0, $04, $80, $02
	dc.b	$CE, $0A, $80, $02
	dc.b	$CC, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_2B:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Pattern_2C:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Pattern_2D:
	; This pattern is unused
	; This pattern is undefined
	smpsReturn

; ---------------------------------------------------------------
Pattern_2E:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9A, $0A, $80, $02
	dc.b	$A6, $0A, $80, $02
	smpsLoop	0, 4, .0
.1:
	dc.b	$A1, $0A, $80, $02
	dc.b	$AD, $0A, $80, $02
	smpsLoop	0, 4, .1
.2:
	dc.b	$99, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	smpsLoop	0, 4, .2
	dc.b	$FC, $62			; set note volume (advanced SMPS only!)
	dc.b	$A3, $0A, $80, $02
	dc.b	$AF, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$B1, $0A, $80, $02
	dc.b	$A6, $0A, $80, $02
	dc.b	$B2, $0A, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$B4, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_2F:
	dc.b	$FC, $5E			; set note volume (advanced SMPS only!)
	dc.b	$B6, $16, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$BD, $16, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$BD, $16, $80, $02
	dc.b	$BE, $16, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$BD, $16, $80, $02
	dc.b	$BE, $16, $80, $02
	dc.b	$C0, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_30:
	dc.b	$FB, $5E		; set portamento speed (SMPS/TS)
	dc.b	$FC, $5E			; set note volume (advanced SMPS only!)
	dc.b	$BE, $60, $E7
	dc.b	$BE, $E7
	dc.b	$B2, $E7
	dc.b	$B2, $01, $80, $17
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsFMvoice	$04
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AD, $16, $80, $02
	dc.b	$AF, $16, $80, $02
	dc.b	$B1, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_31:
	dc.b	$FC, $5E			; set note volume (advanced SMPS only!)
	dc.b	$B2, $5E, $80, $02
	dc.b	$B4, $5E, $80, $02
	dc.b	$B6, $5E, $80, $02
	dc.b	$B8, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_32:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9E, $0A, $80, $02
	dc.b	$AA, $0A, $80, $02
	smpsLoop	0, 14, .0
	dc.b	$A6, $0A, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A6, $04, $80, $02
	dc.b	$A8, $0A, $80, $02
	dc.b	$A8, $04, $80, $02
	dc.b	$A8, $04, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_33:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $5E, $80, $02
	dc.b	$B9, $5E, $80, $02
	dc.b	$B1, $5E, $80, $02
	smpsPan		$C0, 0
	smpsFMvoice	$06
	dc.b	$FC, $5C			; set note volume (advanced SMPS only!)
	dc.b	$92, $01, $80, $02
	dc.b	$FB, $5F		; set portamento speed (SMPS/TS)
	dc.b	$CE, $5C, $80, $01
	smpsReturn

; ---------------------------------------------------------------
Pattern_34:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$CA, $5E, $80, $02
	dc.b	$D0, $04, $80, $02
	dc.b	$CE, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$CA, $04, $80, $02
	dc.b	$CE, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$CA, $04, $80, $02
	dc.b	$C9, $04, $80, $02
	dc.b	$C7, $04, $80, $02
	dc.b	$C9, $04, $80, $02
	dc.b	$CA, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$C9, $04, $80, $02
	dc.b	$CA, $04, $80, $02
	dc.b	$CC, $04, $80, $02
	dc.b	$CE, $04, $80, $02
	dc.b	$C9, $5E, $80, $02
	dc.b	$D5, $16, $80, $02
	dc.b	$D3, $16, $80, $02
	dc.b	$D1, $16, $80, $02
	dc.b	$CC, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_35:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$CE, $60, $E7
	dc.b	$CE, $5E, $80, $02
	dc.b	$9E, $03, $E7
	dc.b	$FB, $63		; set portamento speed (SMPS/TS)
	dc.b	$CE, $5C, $80, $01
	dc.b	$CE, $80, $02
	dc.b	$FB, $5A		; set portamento speed (SMPS/TS)
	dc.b	$AA, $01, $80, $5C
	smpsReturn

; ---------------------------------------------------------------
Pattern_36:
	smpsPan		$40, 0
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$BE, $0A, $80, $02
	dc.b	$BE, $04, $80, $02
	dc.b	$BE, $04, $80, $02
	smpsLoop	0, 16, .0
	smpsReturn

; ---------------------------------------------------------------
Pattern_37:
	dc.b	$FB, $5E		; set portamento speed (SMPS/TS)
	dc.b	$FC, $5E			; set note volume (advanced SMPS only!)
	dc.b	$C2, $60, $E7
	dc.b	$C2, $5E, $80, $02
	dc.b	$B6, $60, $E7
	dc.b	$B6, $01, $80, $17
	dc.b	$FB, $00		; set portamento speed (SMPS/TS)
	smpsFMvoice	$04
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B1, $16, $80, $02
	dc.b	$B2, $16, $80, $02
	dc.b	$B4, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_38:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$CE, $5E, $80, $02
	dc.b	$D0, $5E, $80, $02
	dc.b	$D1, $5E, $80, $02
	dc.b	$D3, $5E, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_39:
.0:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$9E, $0A, $80, $02
	dc.b	$AA, $04, $80, $02
	dc.b	$AA, $04, $80, $02
	smpsLoop	0, 13, .0
	dc.b	$99, $0A, $80, $02
	dc.b	$A5, $0A, $80, $02
	dc.b	$9A, $0A, $80, $02
	dc.b	$A6, $0A, $80, $02
	dc.b	$9C, $0A, $80, $02
	dc.b	$FC, $5E			; set note volume (advanced SMPS only!)
	dc.b	$A8, $0A, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_3A:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$B2, $16, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B9, $0A, $80, $02
	dc.b	$AD, $0C, $E7
	dc.b	$AD, $5E, $80, $02
	dc.b	$B1, $16, $80, $02
	dc.b	$B2, $16, $80, $02
	dc.b	$B4, $16, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$BD, $16, $80, $02
	dc.b	$BB, $16, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$B4, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
Pattern_3B:
	dc.b	$FC, $60			; set note volume (advanced SMPS only!)
	dc.b	$AF, $16, $80, $02
	dc.b	$B1, $16, $80, $02
	dc.b	$B2, $16, $80, $02
	dc.b	$B6, $0A, $80, $02
	dc.b	$AA, $0C, $E7
	dc.b	$AA, $5E, $80, $02
	dc.b	$AD, $16, $80, $02
	dc.b	$AF, $16, $80, $02
	dc.b	$B1, $16, $80, $02
	dc.b	$B2, $16, $80, $02
	dc.b	$B9, $16, $80, $02
	dc.b	$B8, $16, $80, $02
	dc.b	$B6, $16, $80, $02
	dc.b	$B1, $16, $80, $02
	smpsReturn

; ---------------------------------------------------------------
; Voices
; ---------------------------------------------------------------

No_Time_To_Lose_Voices:
	; Voice $00 (No_Time_To_Lose_FM)
	dc.b	$F8, $52, $33, $21, $02, $18, $1C, $1C, $19, $03, $00, $00, $0E, $00, $04, $04, $02, $22, $04, $04, $18, $19, $10, $17, $00
	; Voice $01 (No_Time_To_Lose_FM)
	dc.b	$C0, $66, $05, $00, $31, $DF, $DF, $9F, $9F, $07, $06, $09, $86, $07, $06, $06, $08, $25, $15, $15, $F5, $1C, $2D, $14, $00
	; Voice $02 (No_Time_To_Lose_FM)
	dc.b	$F8, $72, $31, $10, $52, $10, $0D, $19, $14, $01, $05, $01, $80, $02, $01, $00, $00, $10, $22, $15, $04, $1A, $14, $13, $00
	; Voice $03 (No_Time_To_Lose_FM)
	dc.b	$FD, $0F, $00, $0F, $0F, $1F, $1F, $1F, $1F, $8A, $90, $9F, $93, $00, $04, $00, $00, $48, $F0, $B8, $F0, $00, $00, $00, $00
	; Voice $04 (No_Time_To_Lose_FM)
	dc.b	$F2, $31, $21, $51, $21, $1F, $1F, $1F, $1F, $01, $04, $04, $82, $00, $00, $00, $00, $03, $05, $05, $07, $16, $16, $1D, $05
	; Voice $05 (No_Time_To_Lose_FM)
	dc.b	$FA, $32, $76, $72, $32, $8D, $4F, $15, $52, $0A, $08, $07, $07, $06, $00, $00, $00, $03, $03, $03, $03, $19, $20, $2A, $00
	; Voice $06 (No_Time_To_Lose_FM)
	dc.b	$F5, $70, $70, $70, $70, $1F, $1F, $1F, $1F, $05, $00, $00, $00, $00, $00, $00, $00, $34, $04, $04, $04, $14, $02, $02, $02
	; Voice $07 (No_Time_To_Lose_FM)
	dc.b	$FE, $10, $70, $00, $30, $1F, $1F, $1F, $1F, $05, $00, $00, $00, $00, $0B, $15, $09, $06, $06, $34, $00, $00, $00, $00, $00
	; Voice $08 (No_Time_To_Lose_FM)
	dc.b	$FE, $00, $00, $00, $00, $1F, $1F, $1F, $1F, $09, $09, $00, $00, $09, $06, $00, $00, $02, $4A, $02, $02, $00, $00, $00, $00
