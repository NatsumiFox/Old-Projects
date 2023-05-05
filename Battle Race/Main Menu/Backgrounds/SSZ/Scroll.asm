; ===========================================================================
; ---------------------------------------------------------------------------
; Scroll Data - Hidden Palace Zone
; ---------------------------------------------------------------------------

		lea	(EMM_PosY_BG1).l,a3			; load slot 1 Y positions
		tst.b	EMM_SlotID				; check if we are using slot 1
		beq.s	.slot1					; if so, branch
		lea	(EMM_PosY_BG2).l,a3			; load slot 2 Y positions

.slot1		moveq	#$00,d0					; clear d0
		move.b	(a2),d0					; load angle
		add.w	#$0080,(a2)				; increase angle for next frame
		add.w	d0,d0					; multiply by size of word

		lea	(SineTable+$80).l,a0			; load sinewave table
		move.w	(a0,d0.w),d1				; load Y sine
		asr.w	#3,d1					; 1/8 sine pos (the position is -$20 to $20)
		add.w	EMM_PosY_FG1-EMM_PosY_BG1(a3),d1	; add FG Y position
		sub.w	#$18,d1					; offset position
		move.w	d1,(a3)					; write BG Y position

		move.w	EMM_ScrollSpeed+SCROLL_1000_B.w,d1	; load FG scrolling speed
		move.w	d1,d0					; copy to d1
		swap	d0					; send position to upper word for FG
		sub.w	#$74,d1					; offset scrolling position
		move.w	d1,d0					; load BG scrolling speed
		jmp	(WriteScroll-($100*2))			; write scroll data (100 scanlines)

; ===========================================================================
