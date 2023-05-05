; ===========================================================================
; ---------------------------------------------------------------------------
; Palette Cycling - Carnival Night 1
; ---------------------------------------------------------------------------

		st.b	(EMM_UpdatePal).l			; set to update the palette

	; --- Gold cycling ---

		subq.b	#$01,(a2)				; decrease delay timer
		bpl.s	PCCNZ01_NoRunGold			; if still running, branch
		move.b	#$04-1,(a2)				; reset to 3 frames
		moveq	#$00,d0					; clear d0
		move.b	$01(a2),d0				; load position
		addq.b	#$06,d0					; increase position to next entry
		cmpi.b	#$06*$10,d0				; have we reached the end?
		blo.s	PCCNZ01_NoWrapGold			; if not, branch
		moveq	#$00,d0					; wrap back to 0

PCCNZ01_NoWrapGold:
		move.b	d0,$01(a2)				; update
		lea	(AnPal_PalCNZ_1).l,a0			; load GOLD palette cycling...
		move.l	$00(a0,d0.w),$3A(a1)			; ''
		move.w	$04(a0,d0.w),$3E(a1)			; ''

PCCNZ01_NoRunGold:

	; --- Gradual flickering ---

		moveq	#$00,d0					; clear d0
		move.b	$02(a2),d0				; load timer
		addq.b	#$06,d0					; increase by 6
		cmpi.b	#$06*$1E,d0				; have we reached the end?
		bcs.s	PCCNZ01_NoWrapGrad			; if not, branch
		moveq	#$00,d0					; wrap back to 0

PCCNZ01_NoWrapGrad:
		move.b	d0,$02(a2)				; update
		addq.b	#$02,d0					; skip first colour (due to palette limitations)
		lea	(AnPal_PalCNZ_3).l,a0			; load gradual flicker palette cycling...
		move.l	(a0,d0.w),$34(a1)			; ''

	; --- Quick flickering ---

		addq.b	#$01,$03(a2)				; increase counter/position
		move.b	$03(a2),d0				; load position
		andi.w	#$003C,d0				; wrap it
		lea	(AnPal_PalCNZ_5).l,a0			; load quick flicker palette cycling...
		move.w	(a0,d0.w),$38(a1)			; '
		rts						; return

; ===========================================================================