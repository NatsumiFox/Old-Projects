SegaScreen:
		jsr	Pal_FadeFrom
		jsr	ClearPLC
		jsr	ClearVRAM

		lea	($C00004).l,a6
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$8700,(a6)
		move.w	#$8B00,(a6)
		move.w	#$8C81,(a6)
	;	move.w	#$8154,(a6)

		clr.w	($FFFFFF38).w
		clr.w	($FFFFF634).w
		clr.w	($FFFFF662).w
		clr.w	($FFFFF660).w

		move	#$2700,sr
		move.w	($FFFFF60C).w,d0
		andi.b	#$BF,d0
		move.w	d0,($C00004).l
		
		jsr	ClearScreen
		lea	($FFFFAC00).w,a1
		moveq	#0,d0
		move.w	#$FF,d1

loc_3230_2:
		move.l	d0,(a1)+
		dbf	d1,loc_3230_2
		lea	(RAM_SpriteAddr).w,a1
		moveq	#0,d0
		move.w	#$7FF,d1

loc_3240_2:
		move.l	d0,(a1)+
		dbf	d1,loc_3240_2
		lea	($FFFFF700).w,a1
		moveq	#0,d0
		move.w	#$3F,d1	; '?'

loc_3250_2:
		move.l	d0,(a1)+
		dbf	d1,loc_3250_2
		lea	($FFFFEE00).w,a1
		moveq	#0,d0
		move.w	#$3F,d1	; '?'

loc_3260_2:
		move.l	d0,(a1)+
		dbf	d1,loc_3260_2
		lea	($FFFFFB80).w,a1
		moveq	#0,d0
		move.w	#$1F,d1

loc_3270_2:
		move.l	d0,(a1)+
		dbf	d1,loc_3270_2

		move.b	#Snd_Special_StopSng,d0
		jsr	PlaySound_Special
		jsr	Pal_FadeFrom

		lea	(Maps_SegaLogoClassic).l,a1
		move.l	#$459C0003,d0
		moveq	#11,d1
		moveq	#3,d2
		jsr	ShowVDPGraphics

		move.b	#$30,d0
		move.l	#$40200000,($C00004).l
		lea	(ArtUnc_SegaLogoClassic).l,a2
		jsr	LoadUncArt

		move.w	#$A,d0
		lea	(Pal_SegaLogoClassic),a1
		lea	($FFFFFB00),a2
		jsr	PalLoad

		move.w	#4,(SegaScr_PalCnt).w
		move.w	#-$A,($FFFFF632).w
		move.w	($FFFFF60C).w,d0
		ori.b	#$40,d0
		move.w	d0,($C00004).l

	;	btst	#6,($A10001).l		; Is NTSC?
	;	bne.w	SegaLogo_MD_2
		btst	#7,($A10001).l		; Is the console japanese (Mega Drive)?
		beq.w	SegaLogo_MD		; If yes branch

		move.l	#$45B00003,($C00004).l  ; Add
		move.l	#$00300031,($C00000).l  ;     TM
SegaLogo_MD:
		jsr	Pal_FadeTo
		move.b	#Snd_Special_SEGA,d0    ;Delete these lines to disable
		jsr	PlaySound_Special       ;the "SEGA" Sound

SegaLogo_Loop:
		move.b	#$10,($FFFFF62A).w
		add.w	#1,($FFFFFF38).w
		jsr	DelayProgram
		jsr	SegaScreen_PalCyc

		cmp.b	#JoyStart,(RAM_Control_1_Press).w
		beq	SegaLogo_GoTo_SegaScreen
		cmp.w	#$F0,($FFFFFF38).w
		bge.w	SegaLogo_GoTo_SegaScreen

		bra	SegaLogo_Loop

SegaLogo_GoTo_SegaScreen:
		move.b	#Snd_Special_StopSng,d0
		jsr	PlaySound_Special
		clr.b	(SegaScr_PalCnt).w
		clr.w	(SegaScr_Delay).w
		move.b	#ModeID_Title,(Game_Mode).w
		rts

;ASCII_NoNtsc: ;Unused
;		dc.b	"DEVELOPED FOR USE ONLY WITH", $FF
;		dc.b	"       NTSC GENESIS",$FF
;		dc.b	"     NTSC MEGA DRIVE  ",$FF
;		dc.b	"      PAL MEGA DRIVE  ",$FF
;		dc.b	"          SYSTEM",0
;		even

;=======================================================================================
SegaScr_PalCnt equ $FFFFF500
SegaScr_Delay equ $FFFFF502

SegaScreen_PalCyc:
		subq.w	#1,(SegaScr_Delay).w
		bpl.w	SegaScreen_Return
		move.w	#3,(SegaScr_Delay).w	;DELAY

		lea	(PalCyc_SegaLogoClassic),a0
		moveq	#0,d0
		move.w	(SegaScr_PalCnt).w,d0

		addq.w	#2,(SegaScr_PalCnt).w
		cmp.w	#$24,(SegaScr_PalCnt).w
		ble.w	SegaScreen_PalCycle_Run
	;	move.w	#0,(SegaScr_PalCnt).w
		rts

SegaScreen_PalCycle_Run:
		lea	(a0,d0.w),a1		
		lea	($FFFFFB16),a2
		move.w	(a1)+,-(a2)
		move.w	(a1)+,-(a2)
		move.w	(a1)+,-(a2)
		move.w	(a1)+,-(a2)
		move.w	(a1)+,-(a2)
		move.w	(a1)+,-(a2)
		move.w	(a1)+,-(a2)
		move.w	(a1)+,-(a2)
		move.w	(a1)+,-(a2)
		rts

SegaScreen_Return:
		rts

;===================================================================================

SEGALogo_Delay: ;Unused
		move.l	#$fff,d7
SEGALogo_Delay2:
		nop			;LAG
		dbra    d7,SEGALogo_Delay2
		dbra    d6,SEGALogo_Delay
		rts

;===================================================================================
ArtUnc_SegaLogoClassic:
		incbin	"Modes\SegaScreen\GFX.bin"
		even
	
Maps_SegaLogoClassic:
		dc.w $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, 0
		dc.w $0C, $0D, $0E, $0F, $10, $11, $12, $13, $14, $15, $16, $17
		dc.w $18, $19, $1A, $1B, $1C, $1D, $1E, $1F, $20, $21, $22, $23
		dc.w $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F
		even

Pal_SegaLogoClassic:
		incbin	"Modes\SegaScreen\PAL.bin"
		even


PalCyc_SegaLogoClassic:
		incbin	"Modes\SegaScreen\ANIPAL.bin"
		even

;====================================================================================
ClearVRAM:
		lea	($C00000).l,a1
		move.l	#$40000000,($C00004).l
		moveq	#0,d1
		move.w	#$7FF, d0

ClearVRAM_Loop:
		move.l	d1,(a1)
		move.l	d1,(a1)
		move.l	d1,(a1)
		move.l	d1,(a1)
		move.l	d1,(a1)
		move.l	d1,(a1)
		move.l	d1,(a1)
		move.l	d1,(a1)
		dbf	d0, ClearVRAM_Loop
		rts
;====================================================================================
LoadUncArt:
		lea	($C00000), a1		;Mover VDP Control a "a1"

LoadArt_Loop:
		move.l	(a2)+, (a1)		;$xxxxxxxx	<- linea a procesar
		move.l	(a2)+, (a1)
		move.l	(a2)+, (a1)
		move.l	(a2)+, (a1)
		move.l	(a2)+, (a1)
		move.l	(a2)+, (a1)
		move.l	(a2)+, (a1)
		move.l	(a2)+, (a1)
		dbf	d0, LoadArt_Loop	;Repetir los pasos del d0
		rts
;====================================================================================
PalLoad:
		adda.w	#$80,a2
PalLoad_Loop:
		move.w	(a1)+,(a2)+
		dbf	d0,PalLoad_Loop
		rts
;====================================================================================

; ---------------------------------------------------------------------------
; LoadASCII
; ---------------------------------------------------------------------------
LoadASCII:
		move.l	d5,($C00004).l
LoadText_Loop:
		moveq	#0,d1
		move.b	(a1)+,d1
		bmi.w	LoadASCII_AddSpace	; if a1 = $FF, branch
		bne.w	LoadASCII_Print
		rts
LoadASCII_Print:
		move.w	d1,($C00000)		;"print" la letra
		bra.w	LoadText_Loop
LoadASCII_AddSpace:
		add.l	#$800000,d5		;Espacio
		bra.w	LoadASCII
;====================================================================================

LoadASCII_2:
		move.l	d5,($C00004).l
LoadText_2_Loop:
		moveq	#0,d1
		move.b	(a1)+,d1
		bmi.w	LoadASCII_2_AddSpace	; if a1 = $FF, branch
		bne.w	LoadASCII_2_Print
		rts
LoadASCII_2_Print:
		add.w	d3,d1			;VRAM Address
		move.w	d1,($C00000)		;"print" la letra
		bra.w	LoadText_2_Loop
LoadASCII_2_AddSpace:
		add.l	#$800000,d5		;Espacio
		bra.w	LoadASCII_2
;====================================================================================
;d4 = text length

LoadASCII_3:
		move.l	d5,($C00004).l
LoadText_3_Loop:
		moveq	#0,d1
		move.b	(a1)+,d1
		bmi.w	LoadASCII_2_AddSpace	; if a1 = $FF, branch

LoadText_3_Print_Loop:
		add.w	d3,d1			;VRAM Address
		move.w	d1,($C00000)		;"print" la letra
		dbf	d4,LoadText_3_Print_Loop
		rts

LoadASCII_3_AddSpace:
		add.l	#$800000,d5		;Espacio
		bra.w	LoadASCII_2
;====================================================================================
		dc.b	"GF64" ; Watermark, don't delete this please...