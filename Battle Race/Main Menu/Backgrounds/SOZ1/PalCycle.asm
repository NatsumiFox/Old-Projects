; ===========================================================================
; ---------------------------------------------------------------------------
; Palette Cycling - Sandopolis Zone Act 1
; ---------------------------------------------------------------------------

		subq.b	#$01,(a2)				; decrease first delay timer
		bpl.s	.rts					; if still running, branch
		move.b	#$05-1,(a2)				; reset delay time

		moveq	#$00,d0					; clear d0
		move.b	$01(a2),d0				; load palette entry position
		addq.b	#$08,$01(a2)				; increase for next time
		cmp.b	#$20,$01(a2)				; check if needs wrapping
		blo.s	.nowrap					; if not, branch
		clr.b	$01(a2)					; reset position

.nowrap		lea	(AnPal_PalSOZ1).l,a0			; load palette list (from "sonic3k.asm")
		adda.w	d0,a0					; advance to correct slot
		move.l	(a0)+,$38(a1)				; write 4 colours??
		move.l	(a0)+,$3C(a1)				;
		st.b	(EMM_UpdatePal).l			; set to update the palette
.rts		rts						; return

; ===========================================================================
