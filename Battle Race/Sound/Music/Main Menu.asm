; ===========================================================================
; ---------------------------------------------------------------------------
; Main Menu Theme
; ---------------------------------------------------------------------------

MAINMENU_Header:
		sHeaderInit
		sHeaderPatch	MAINMENU_Patches
		sHeaderCh	$06, $03
		sHeaderTempo	$01, $28
		sHeaderDAC	MAINMENU_DAC
		sHeaderFM	MAINMENU_FM1, $00, $08
		sHeaderFM	MAINMENU_FM2, $00, $1A
		sHeaderFM	MAINMENU_FM3, $FC, $1C
		sHeaderFM	MAINMENU_FM4, $F9, $16
		sHeaderFM	MAINMENU_FM5, $F5, $14
		sHeaderPSG	MAINMENU_PSG1, $0C, $03, $00, VolEnv_00
		sHeaderPSG	MAINMENU_PSG2, $0C, $03, $00, VolEnv_00
		sHeaderPSG	MAINMENU_PSG3, $00, $02, $00, VolEnv_00

; ===========================================================================
; ---------------------------------------------------------------------------
; DAC
; ---------------------------------------------------------------------------

MAINMENU_DAC:
		sCall	MMDAC_Beat01
		sCall	MMDAC_Beat01
		sCall	MMDAC_Beat01
		sCall	MMDAC_Beat01_End

MMDAC_Loop2:
		sCall	MMDAC_Beat02
		sCall	MMDAC_Beat02
		sCall	MMDAC_Beat02
		sCall	MMDAC_Beat02

		dc.b	$80,$60,$80,$60,$80,$60,$80,$60
		sCall	MMDAC_Beat01
		sCall	MMDAC_Beat01

MMDAC_Loop1:
		sCall	MMDAC_Beat02
		sLoop	$00,$0B,MMDAC_Loop1
		sCall	MMDAC_Beat02_End
		sJump	MMDAC_Loop2

	; --- Beat Loop 1 ---

MMDAC_Beat01:
		dc.b	$B7,$0C,$89
		sLoop	$00,$07,MMDAC_Beat01
		dc.b	$B7,$B7
		sRet


MMDAC_Beat01_End:
		dc.b	$B7,$0C,$89
		sLoop	$00,$04,MMDAC_Beat01_End
		dc.b	$80,$60
		sRet

	; --- Beat Loop 2 ---

MMDAC_Beat02:	dc.b	$B7,$0C,$89,$C8,$89
		dc.b	$B7,$0C,$89,$C8,$C7
		dc.b	$B7,$0C,$89,$C8,$89
		dc.b	$B7,$0C,$89,$C8,$B7
		sRet

MMDAC_Beat02_End:
		dc.b	$B7,$0C,$89,$C8,$89
		dc.b	$B7,$0C,$89,$C8,$C7
		dc.b	$80,$60
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 1
; ---------------------------------------------------------------------------

MAINMENU_FM1:
		sPatFM	$00
		ssModZ80 $10,$01,$F8,$FF

MMFM1_Loop3:
		sCall	MMFM1_Bass01
		sCall	MMFM1_Bass02
		sLoop	$00,$08,MAINMENU_FM1

		dc.b	$80,$60,$80,$60,$80,$60
		sCall	MMFM1_BassStart

MMFM1_Loop1:
		dc.b	$96,$0C,$96,$30,$80,$24
		sLoop	$00,$03,MMFM1_Loop1
		sCall	MMFM1_Bass01

MMFM1_Loop2:
		sCall	MMFM1_Bass01
		sCall	MMFM1_Bass02
		sLoop	$00,$08,MMFM1_Loop2
		sJump	MMFM1_Loop3

	; --- Base verse 1 ---

MMFM1_Bass01:
		dc.b	$96
MMFM1_BassStart:dc.b	$0C,$96,$18,$9C,$96,$A3,$0C
		sRet

	; --- Base verse 2 ---

MMFM1_Bass02:
		dc.b	$96,$0C,$96,$18,$9C,$96,$0C,$91,$18
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 2
; ---------------------------------------------------------------------------

MAINMENU_FM5:
MAINMENU_FM4:
MAINMENU_FM3:
MAINMENU_FM2:
		sPatFM	$01

MMFM2_Loop1:
		dc.b	$80,$60
		sLoop	$00,$10,MMFM2_Loop1

MMFM2_Loop2:
		dc.b	$B6,$60
		saDetune $FC
		dc.b	$B3
		saDetune $00
		dc.b	$B6,$48,$B8,$18
		saDetune $FC
		dc.b	$B3,$60
		saDetune $00
		sLoop	$00,$04,MMFM2_Loop2
		sJump	MMFM2_Loop1

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG  1 & 2
; ---------------------------------------------------------------------------

MAINMENU_PSG2:
		saDetune $01

MAINMENU_PSG1:
		sVolEnvPSG $05
		ssModZ80 $18,$01,$FC,$FF

MMPSG1_Loop1:
		sCall	MMPSG1_Beep
		sCall	MMPSG1_Beep
		dc.b	$80,$0C
		sCall	MMPSG1_Beep
		dc.b	$80,$0C
		sCall	MMPSG1_Beep
		dc.b	$80,$0C
		sCall	MMPSG1_Beep
		SLoop	$00,$08,MMPSG1_Loop1

MMPSG1_Loop2:
		sCall	MMPSG1_Skinny
		sCall	MMPSG1_SkinnyShort
		dc.b	$92,$06
		sCall	MMPSG1_SkinnyShort
		sCall	MMPSG1_Skinny
		sCall	MMPSG1_SkinnyShort
		dc.b	$92,$06
		dc.b	$92,$18
		sLoop	$00,$04,MMPSG1_Loop2


MMPSG1_Loop3:
		sCall	MMPSG1_Skinny
		sCall	MMPSG1_BumbleBee
		sLoop	$00,$10,MMPSG1_Loop3
		sJump	MMPSG1_Loop1

	; --- Beep with echo ---

MMPSG1_Beep:
		dc.b	$92,$04,$80,$02
		saVolPSG $06
		dc.b	$92,$04,$80,$02
		saVolPSG $FA
		sRet

	; --- Skinny Bumbu ---

MMPSG1_Skinny:
		dc.b	$96,$06,$94
		saVolPSG $06
		dc.b	$96
		saVolPSG $FA

MMPSG1_SkinnyShort:
		dc.b	$92
		saVolPSG $06
		dc.b	$94
		saVolPSG $FA
		dc.b	$94
		saVolPSG $06
		dc.b	$92
		saVolPSG $FA
		sRet

	; --- Bumble Bee ---

MMPSG1_BumbleBee:
		dc.b	$92
		saVolPSG $06
		dc.b	$94
		saVolPSG $FA
		dc.b	$8F
		saVolPSG $06
		dc.b	$92
		saVolPSG $FA

MMPSG1_Bee:
		dc.b	$92,$18
		saVolPSG $06
		dc.b	$92,$06
		saVolPSG $FA
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG  3
; ---------------------------------------------------------------------------

MAINMENU_PSG3:
		sNoisePSG $E7

MMPSG3_Loop2:
		sCall	MMPSG3_Loop
		sCall	MMPSG3_Loop
		sCall	MMPSG3_Loop
		sCall	MMPSG3_Loop
		sCall	MMPSG3_Loop
		sCall	MMPSG3_Loop
		sCall	MMPSG3_Loop
		dc.b	$80,$60

MMPSG3_Loop1:
		sCall	MMPSG3_Loop
		sLoop	$01,$20,MMPSG3_Loop1
		sJump	MMPSG3_Loop2

MMPSG3_Loop:
		sVolEnvPSG $02
		dc.b	nBb6,$06,$06
		sVolEnvPSG $05
		dc.b	$0A,$80,$02
		sLoop	$00,$04,MMPSG3_Loop
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; Instruments
; ---------------------------------------------------------------------------

MAINMENU_Patches:

	; 00 - Bass

	dc.b	$05
	dc.b	$21,$01,$01,$31, $1C,$1B,$1B,$1C, $06,$0C,$0C,$0C
	dc.b	$01,$01,$01,$01, $7F,$4F,$4C,$4F, $40,$80,$80,$80

	; 01 - Synth Chord

	dc.b	$06
	dc.b	$71,$71,$31,$31, $1F,$0F,$1F,$0F, $09,$0A,$08,$0A
	dc.b	$09,$06,$09,$06, $1F,$2F,$1F,$2F, $0F,$80,$80,$80

; ===========================================================================
