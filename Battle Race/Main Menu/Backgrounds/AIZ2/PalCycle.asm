; ===========================================================================
; ---------------------------------------------------------------------------
; Palette Cycling - Angel Island Zone 2
; ---------------------------------------------------------------------------

		subq.b	#$01,(a2)				; decrease first delay timer
		bpl.s	PCAIZ02_22F6				; if still running, branch
		move.b	#$06-1,(a2)				; reset delay time
		moveq	#$00,d0					; clear d0
		move.b	$01(a2),d0				; load palette entry position
		addq.b	#$06,$01(a2)				; increase for next time
		cmpi.b	#$30,$01(a2)				; has the position reached the end?
		blo.s	PCAIZ02_22BC				; if not, branch
		sf.b	$01(a2)					; reset position

PCAIZ02_22BC:
		lea	(AnPal_PalAIZ2_2).l,a0			; load palette list (from "sonic3k.asm")
		adda.w	d0,a0					; advance to correct slot
		move.w	(a0)+,$2A(a1)				; grass
		move.w	(a0)+,$2E(a1)				; wood
		move.w	(a0)+,$32(a1)				; background trees
		st.b	(EMM_UpdatePal).l			; set to update the palette

PCAIZ02_22F6:
		subq.b	#$01,$02(a2)				; decrease second delay timer
		bpl.s	PCAIZ02_Return				; if still running, branch
		move.b	#$02-1,$02(a2)				; reset timer
		moveq	#$00,d0					; clear d0
		move.b	$03(a2),d0				; load position
		addq.b	#$02,$03(a2)				; increase for next time
		cmpi.b	#$34,$03(a2)				; has the position reached the end?
		blo.s	PCAIZ02_2318				; if not, branch
		sf.b	$03(a2)					; reset position

PCAIZ02_2318:
		lea	(AnPal_PalAIZ2_4).l,a0			; load palette list (from "sonic3k.asm")
		move.w	(a0,d0.w),$30(a1)			; background sky
		st.b	(EMM_UpdatePal).l			; set to update the palette

PCAIZ02_Return:
		rts						; return

; ===========================================================================