; ===========================================================================
; ---------------------------------------------------------------------------
; Palette Cycling - Death Egg Zone 1
; ---------------------------------------------------------------------------

		st.b	(EMM_UpdatePal).l			; set to update the palette
		moveq	#$00,d0					; clear d0
		move.b	$02(a2),d0				; load palette entry position
		bchg	#3,$02(a2)				; increase for next time

		lea	.tazer(pc,d0.w),a0			; load palette list
		move.l	(a0)+,$18(a1)				; write 4 colours
		move.l	(a0)+,$1C(a1)				;

	; continue to DEZ2
		lea	.newcycle(pc),a0			; load new cycle
		bra.s	PalCyc_DEZ02+6

.tazer		dc.w $0EE, $06E, $00E, $224
		dc.w $EEE, $EC0, $A80, $860

.newcycle	dc.w $68A, $468, $246, $024, 0
		dc.w $68C, $46A, $468, $026, 0
		dc.w $8AC, $68A, $468, $246, 0
		dc.w $68C, $46A, $468, $026, 0
; ===========================================================================
