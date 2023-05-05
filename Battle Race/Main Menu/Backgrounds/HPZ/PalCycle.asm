; ===========================================================================
; ---------------------------------------------------------------------------
; Palette Cycling - Hidden Palace Zone
; ---------------------------------------------------------------------------

		subq.b	#$01,(a2)				; decrease first delay timer
		bpl.s	.rts					; if still running, branch
		move.b	#7-1,(a2)				; reset delay time
		moveq	#$00,d0					; clear d0
		move.b	$01(a2),d0				; load palette entry position
		addq.b	#$04,$01(a2)				; increase for next time
		cmpi.b	#$28,$01(a2)				; has the position reached the end?
		blo.s	.noclr					; if not, branch
		clr.b	$01(a2)					; reset position

.noclr		lea	(AnPal_PalHPZ).l,a0			; load palette list (from "sonic3k.asm")
		move.w	(a0,d0.w),$3C(a1)			; write 1 colours
		st.b	(EMM_UpdatePal).l			; set to update the palette
.rts		rts						; return

; ===========================================================================
