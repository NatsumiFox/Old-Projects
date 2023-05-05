; ===========================================================================
; ---------------------------------------------------------------------------
; Scroll Data - Lava Reef Zone Act 1
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
		lsr.w	#2,d1					; quarter sine pos
		add.w	#$40,d1					; offset by 1 chunk

		add.w	EMM_PosY_FG1-EMM_PosY_BG1(a3),d1	; add FG Y position
		move.w	d1,(a3)					; write BG Y position

		move.w	EMM_ScrollSpeed+SCROLL_1000_F.w,d0	; load FG scrolling speed
		swap	d0					; send position to upper word for FG
		move.w	EMM_ScrollSpeed+SCROLL_1000_F.w,d0	; load BG scrolling speed
		jmp	(WriteScroll-($100*2))			; write scroll data (100 scanlines)

; ===========================================================================
