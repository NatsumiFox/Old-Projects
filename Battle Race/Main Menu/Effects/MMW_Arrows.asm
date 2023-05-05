; ===========================================================================
; ---------------------------------------------------------------------------
; Swap effect - Arrows that come in and go out from the sides of the screen
; ---------------------------------------------------------------------------
MMWAR_Delay = $10
; ---------------------------------------------------------------------------

MMW_Arrows:
		move.l	#MMWAR_MoveIn,(EMM_SwapRout).l		; set next routine
		move.w	#-((($20+$00)+(MMWAR_Delay*0))*2),(a3)+	; Arrow 1 positions
		move.w	#((($00+$00)+(MMWAR_Delay*0))*2),(a3)+	; ''
		move.w	#-((($20+$14)+(MMWAR_Delay*1))*2),(a3)+	; Arrow 2 positions
		move.w	#((($00+$14)+(MMWAR_Delay*1))*2),(a3)+	; ''
		move.w	#-((($20+$00)+(MMWAR_Delay*2))*2),(a3)+	; Arrow 3 positions
		move.w	#((($00+$00)+(MMWAR_Delay*2))*2),(a3)+	; ''
		move.w	#-((($20+$14)+(MMWAR_Delay*3))*2),(a3)+	; Arrow 4 positions
		move.w	#((($00+$14)+(MMWAR_Delay*3))*2),(a3)+	; ''
		rts						; return

	; --- Moving the arrows in ---

MMWAR_MoveIn:
		movea.l	(EMM_WindowSlot).l,a1			; load window
		suba.w	#($20/2)*4,a1				; move up so all arrows are displaying equally to centre
		moveq	#$02-1,d0				; set number of sets (2 x 2 arrows (4 arrows))

MMWAI_NextArrow:

	; Arrow 1/3

		lea	(MMWAR_PosNorm).l,a0			; load position list
		adda.w	(a3),a0					; advance to correct position
		addq.w	#$04,(a3)+				; change position
	rept	$20
		move.w	(a0)+,(a1)+				; write X pos slot
		addq.w	#$02,a1					; skip Y pos slot
	endm
		lea	(MMWAR_PosRev).l,a0			; load position list
		adda.w	(a3),a0					; advance to correct position
		subq.w	#$04,(a3)+				; change position
	rept	$20
		move.w	(a0)+,(a1)+				; write X pos slot
		addq.w	#$02,a1					; skip Y pos slot
	endm

	; Arrow 2/4

		lea	(MMWAR_NegNorm).l,a0			; load position list
		move.w	(a3),d1					; load position to d1 (keeping a copy for later)
		adda.w	d1,a0					; advance to correct position
		addq.w	#$04,(a3)+				; change position
	rept	$20
		move.w	(a0)+,(a1)+				; write X pos slot
		addq.w	#$02,a1					; skip Y pos slot
	endm
		lea	(MMWAR_NegRev).l,a0			; load position list
		adda.w	(a3),a0					; advance to correct position
		subq.w	#$04,(a3)+				; change position
	rept	$20
		move.w	(a0)+,(a1)+				; write X pos slot
		addq.w	#$02,a1					; skip Y pos slot
	endm
		dbf	d0,MMWAI_NextArrow			; repeat for second set of arrows
		tst.w	d1					; have all arrows come on screen fully?
		bne.s	MMWAI_NoStop				; if not, branch
		move.l	#MMWAI_SwapSlot,(EMM_SwapRout).l	; set next routine

MMWAI_NoStop:
		rts						; return

	; --- Swapping the V-scroll slot background ---

MMWAI_SwapSlot:

		move.l	#$00800ECC,(Normal_palette+$14).w	; write the green and light grey colours that the arrows need...
		st.b	(EMM_UpdatePal).l			; set to update the palette
		st.b	(EMM_AllowSprite).l			; allow sprites into level select/options

		movea.l	(EMM_WindowSlot).l,a1			; load window
		suba.w	#($20/2)*4,a1				; move up so all arrows are displaying equally to centre
		lea	(EMM_VScroll).l,a0			; load V-scroll RAM
		move.w	(EMM_ScrollSlot).l,d0			; load scroll slot we're using
		addi.w	#$0100,d0				; advance to next slot
		move.w	d0,d1					; put in both words of the register
		swap	d0					; ''
		move.w	d1,d0					; ''
		move.l	#$91149200,d2				; prepare window fully open
		moveq	#($E0/04)-1,d1				; set number of scanlines to swap

MMWAS_NextSlot:
		move.l	d0,(a0)+				; fill entire V-scroll with next slot
		move.l	d0,(a0)+				; ''
		move.l	d0,(a0)+				; ''
		move.l	d0,(a0)+				; ''
		move.l	d2,(a1)+				; fill entire of window fully (because of double buffering window)
		move.l	d2,(a1)+				; ''
		move.l	d2,(a1)+				; ''
		move.l	d2,(a1)+				; ''
		dbf	d1,MMWAS_NextSlot			; repeat for all scanlines
		move.l	#MMWAR_MoveOut,(EMM_SwapRout).l		; set next routine
		move.w	#-((($20-$02)+(MMWAR_Delay*0))*2),(a3)+	; Arrow 1 positions
		move.w	#((($00-$02)+(MMWAR_Delay*0))*2),(a3)+	; ''
		move.w	#-((($20-$67)+(MMWAR_Delay*1))*2),(a3)+	; Arrow 2 positions
		move.w	#((($00-$67)+(MMWAR_Delay*1))*2),(a3)+	; ''
		move.w	#-((($20-$02)+(MMWAR_Delay*2))*2),(a3)+	; Arrow 3 positions
		move.w	#((($00-$02)+(MMWAR_Delay*2))*2),(a3)+	; ''
		move.w	#-((($20-$67)+(MMWAR_Delay*3))*2),(a3)+	; Arrow 4 positions
		move.w	#((($00-$67)+(MMWAR_Delay*3))*2),(a3)+	; ''
		rts						; return

	; --- Moving the arrows out ---

MMWAR_MoveOut:
		movea.l	(EMM_WindowSlot).l,a1			; load window
		suba.w	#($20/2)*4,a1				; move up so all arrows are displaying equally to centre
		moveq	#$02-1,d0				; set number of sets (2 x 2 arrows (4 arrows))

MMWAO_NextArrow:

	; Arrow 1/3

		lea	(MMWAR_NegRev).l,a0			; load position list
		adda.w	(a3),a0					; advance to correct position
		addq.w	#$04,(a3)+				; change position
	rept	$20
		move.w	(a0)+,(a1)+				; write X pos slot
		addq.w	#$02,a1					; skip Y pos slot
	endm
		lea	(MMWAR_NegNorm).l,a0			; load position list
		adda.w	(a3),a0					; advance to correct position
		subq.w	#$04,(a3)+				; change position
	rept	$20
		move.w	(a0)+,(a1)+				; write X pos slot
		addq.w	#$02,a1					; skip Y pos slot
	endm

	; Arrow 2/4

		lea	(MMWAR_PosNorm).l,a0			; load position list
		move.w	(a3),d1					; load position to d1 (keeping a copy for later)
		adda.w	d1,a0					; advance to correct position
		addq.w	#$04,(a3)+				; change position
	rept	$20
		move.w	(a0)+,(a1)+				; write X pos slot
		addq.w	#$02,a1					; skip Y pos slot
	endm
		lea	(MMWAR_PosRev).l,a0			; load position list
		adda.w	(a3),a0					; advance to correct position
		subq.w	#$04,(a3)+				; change position
	rept	$20
		move.w	(a0)+,(a1)+				; write X pos slot
		addq.w	#$02,a1					; skip Y pos slot
	endm
		dbf	d0,MMWAO_NextArrow			; repeat for second set of arrows
		cmpi.w	#$00F2,d1				; have all arrows gone out of the screen fully?
		bne.s	MMWAO_NoStop				; if not, branch
		move.l	#MMWBS_ResetWindow,(EMM_SwapRout).l	; set next swap routine (SEE MMW_BoxScale FOR CODE!)

MMWAO_NoStop:
		rts						; return

; ---------------------------------------------------------------------------
; Position array data
; ---------------------------------------------------------------------------

	rept	(MMWAR_Delay*(4-1))+$20
		dc.w	$9100
	endm

MMWAR_PosNorm:	dc.w	$9100,$9101,$9102,$9103,$9104,$9105,$9106,$9107
		dc.w	$9108,$9109,$910A,$910B,$910C,$910D,$910E,$910F
		dc.w	$9110,$9111,$9112,$9113,$9114

	rept	(MMWAR_Delay*(4-1))+$20
		dc.w	$9114
	endm

		dc.w	$9114,$9113,$9112,$9111,$9110,$910F,$910E,$910D
		dc.w	$910C,$910B,$910A,$9109,$9108,$9107,$9106,$9105
		dc.w	$9104,$9103,$9102,$9101

MMWAR_PosRev:	dc.w	$9100

	rept	(MMWAR_Delay*(4-1))+$20
		dc.w	$9100
	endm

	rept	(MMWAR_Delay*(4-1))+$20
		dc.w	$9180
	endm

MMWAR_NegRev:	dc.w	$9180,$9181,$9182,$9183,$9184,$9185,$9186,$9187
		dc.w	$9188,$9189,$918A,$918B,$918C,$918D,$918E,$918F
		dc.w	$9190,$9191,$9192,$9193,$9194

	rept	(MMWAR_Delay*(4-1))+$20
		dc.w	$9194
	endm

		dc.w	$9194,$9193,$9192,$9191,$9190,$918F,$918E,$918D
		dc.w	$918C,$918B,$918A,$9189,$9188,$9187,$9186,$9185
		dc.w	$9184,$9183,$9182,$9181

MMWAR_NegNorm:	dc.w	$9180

	rept	(MMWAR_Delay*(4-1))+$20
		dc.w	$9180
	endm

; ===========================================================================


