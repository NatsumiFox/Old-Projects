; ===========================================================================
; ---------------------------------------------------------------------------
; Palette Cycling - Hydrocity Zone 1
; ---------------------------------------------------------------------------

		subq.b	#$01,(a2)				; decrease delay timer
		bpl.s	PCHCZ01_Return				; if still running, branch
		move.b	#$08-1,(a2)				; reset delay timer
		lea	$18(a1),a1				; advance to water palette
		lea	(a1),a2					; copy palette address
		move.w	(a2)+,d0				; load first colour
		move.w	(a2)+,(a1)+				; move colours back
		move.w	(a2)+,(a1)+				; ''
		move.w	(a2)+,(a1)+				; ''
		move.w	d0,(a1)+				; save first colour as last
		st.b	(EMM_UpdatePal).l			; set to update the palette

PCHCZ01_Return:
		rts						; return

; ===========================================================================