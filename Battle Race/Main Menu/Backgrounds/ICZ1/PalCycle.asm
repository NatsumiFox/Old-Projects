; ===========================================================================
; ---------------------------------------------------------------------------
; Palette Cycling - Ice Cap Zone 1
; ---------------------------------------------------------------------------

	; --- Background crystals ---

		subq.b	#$01,(a2)				; decrease first delay timer
		bpl.s	PCICZ01_B				; if still running, branch
		move.b	#$0A-1,(a2)				; reset delay time
		moveq	#$00,d0					; clear d0
		move.b	$01(a2),d0				; load palette entry position
		addq.b	#$04,$01(a2)				; increase for next time
		cmpi.b	#$48,$01(a2)				; has the position reached the end?
		blo.s	PCICZ01_A				; if not, branch
		sf.b	$01(a2)					; reset position

PCICZ01_A:
		lea	(AnPal_PalICZ_2).l,a0			; load palette list (from "sonic3k.asm")
		adda.w	d0,a0					; advance to correct slot
		move.l	(a0)+,$34(a1)				; dump background crystals palette
		st.b	(EMM_UpdatePal).l			; set to update the palette

PCICZ01_B:

	; --- Foreground crystals ---

		subq.b	#$01,$02(a2)				; decrease first delay timer
		bpl.s	PCICZ01_D				; if still running, branch
		move.b	#$06-1,$02(a2)				; reset delay time
		moveq	#$00,d0					; clear d0
		move.b	$03(a2),d0				; load palette entry position
		addq.b	#$04,$03(a2)				; increase for next time
		cmpi.b	#$40,$03(a2)				; has the position reached the end?
		blo.s	PCICZ01_C				; if not, branch
		sf.b	$03(a2)					; reset position

PCICZ01_C:
		lea	(AnPal_PalICZ_1).l,a0			; load palette list (from "sonic3k.asm")
		adda.w	d0,a0					; advance to correct slot
		move.l	(a0)+,$38(a1)				; dump foreground crystals palette
		st.b	(EMM_UpdatePal).l			; set to update the palette

	; --- Water sparkle colours ---
	; I don't have enough RAM counter space, so
	; this hacky way of using "foreground crystals"
	; palette position will have to do...

		lea	(AnPal_PalICZ_3).l,a0			; load palette list (from "sonic3k.asm")
		move.b	$03(a2),d0				; use foreground's position
		cmpi.w	#$0018,d0				; ensure it's wrapped within 18...
		blo.s	PCICZ01_NoWrap				; ''

PCICZ01_Wrap:
		subi.w	#$0018,d0				; ''
		cmpi.w	#$0018,d0				; ''
		bhs.s	PCICZ01_Wrap				; ''

PCICZ01_NoWrap:
		adda.w	d0,a0					; advance to correct slot
		move.l	(a0)+,$3C(a1)				; dump water sparkles

PCICZ01_D:
		rts						; return

; ===========================================================================