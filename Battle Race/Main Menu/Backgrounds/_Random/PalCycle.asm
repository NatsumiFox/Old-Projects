; ===========================================================================
; ---------------------------------------------------------------------------
; Palette Cycling - Random
; ---------------------------------------------------------------------------


		subq.b	#$01,$01(a2)				; decrease first delay timer
		bpl.s	PCRAN_NoLarge				; if still running, branch
		st.b	(EMM_UpdatePal).l			; set to update the palette
		move.b	#$04-1,$01(a2)				; reset delay time
		lea	$22(a1),a1				; advance to line 2 palette
		lea	(a1),a0					; copy to a0
		move.w	(a1)+,d0				; store first colour
		move.l	(a1)+,(a0)+				; copy colours backwards
		move.l	(a1)+,(a0)+				; ''
		move.l	(a1)+,(a0)+				; ''
		move.l	(a1)+,(a0)+				; ''
		move.l	(a1)+,(a0)+				; ''
		move.l	(a1)+,(a0)+				; ''
		move.l	(a1)+,(a0)+				; ''
		move.w	d0,(a0)					; save first colour as last
		rts						; return

PCRAN_NoLarge:
		subq.b	#$01,(a2)				; decrease first delay timer
		bpl.s	PCRAN_NoCycle				; if still running, branch
		move.b	#$07-1,(a2)				; reset delay time
		st.b	(EMM_UpdatePal).l			; set to update the palette
		lea	$18(a1),a1				; advance to line 1 palette
		lea	(a1),a0					; copy to a0
		move.w	(a1)+,d0				; store first colour
		move.l	(a1)+,(a0)+				; copy colours backwards
		move.w	(a1)+,(a0)+				; ''
		move.w	d0,(a0)+				; save first colour at last

PCRAN_NoCycle:
		rts						; return

; ===========================================================================