; ===========================================================================
; ---------------------------------------------------------------------------
; Palette Cycling - Death Egg Zone 2
; ---------------------------------------------------------------------------

		subq.b	#$01,$02(a2)				; decrease first delay timer
		bpl.s	.nolava					; if still running, branch
		move.b	#$0F-1,$02(a2)				; reset delay time

		moveq	#$00,d0					; clear d0
		move.b	$03(a2),d0				; load palette entry position
		addq.b	#$08,$03(a2)				; increase for next time
		cmpi.b	#$80,$03(a2)				; has the position reached the end?
		blo.s	.noclr					; if not, branch
		clr.b	$03(a2)					; reset position

.noclr		lea	(AnPal_PalLRZ12_1).l,a0			; load palette list (from "sonic3k.asm")
		adda.w	d0,a0					; advance to correct slot
		move.l	(a0)+,$18(a1)				; write 4 colours??
		move.l	(a0)+,$1C(a1)				;
		st.b	(EMM_UpdatePal).l			; set to update the palette

.nolava		subq.b	#$01,(a2)				; decrease first delay timer
		bpl.s	.rts					; if still running, branch
		move.b	#$0F-1,(a2)				; reset delay time
		moveq	#$00,d0					; clear d0
		move.b	$01(a2),d0				; load palette entry position
		addq.b	#$08,$01(a2)				; increase for next time

		lea	(AnPal_PalLRZ2_3).l,a0			; load palette list (from "sonic3k.asm")
		adda.w	d0,a0					; advance to correct slot
		move.l	(a0)+,$38(a1)				; write 4 colours??
		move.l	(a0)+,$3C(a1)				;
		st.b	(EMM_UpdatePal).l			; set to update the palette
.rts		rts						; return

; ===========================================================================
