; ===========================================================================
; ---------------------------------------------------------------------------
; Palette Cycling - Death Egg Zone 2
; ---------------------------------------------------------------------------

		lea	(AnPal_PalDEZ12_2).l,a0			; load palette list (from "sonic3k.asm")
		subq.b	#$01,(a2)				; decrease first delay timer
		bpl.s	.rts					; if still running, branch
		move.b	#$13-1,(a2)				; reset delay time
		moveq	#$00,d0					; clear d0
		move.b	$01(a2),d0				; load palette entry position
		add.b	#$0A,$01(a2)				; increase for next time
		cmpi.b	#$28,$01(a2)				; has the position reached the end?
		blo.s	.noclr					; if not, branch
		clr.b	$01(a2)					; reset position

.noclr		adda.w	d0,a0					; advance to correct slot
		move.l	(a0)+,$38(a1)				; write 4 colours??
		move.l	(a0)+,$3C(a1)				;
		st.b	(EMM_UpdatePal).l			; set to update the palette
.rts		rts						; return

; ===========================================================================
