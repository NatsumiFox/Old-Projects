; ===========================================================================
; ---------------------------------------------------------------------------
; Scroll Data - Flying Battery Zone Act 1
; ---------------------------------------------------------------------------

FBZ1_speed	macro addr
		move.w	EMM_ScrollSpeed+addr.w,d0		; load bg speed
    endm

		lea	(EMM_PosY_BG1).l,a3			; load slot 1 Y positions
		tst.b	EMM_SlotID				; check if we are using slot 1
		beq.s	.slot1					; if so, branch
		lea	(EMM_PosY_BG2).l,a3			; load slot 2 Y positions

.slot1		moveq	#$00,d0					; clear d0
		move.b	(a2),d0					; load angle
		add.w	#$00B0,(a2)				; increase angle for next frame
		add.w	d0,d0					; multiply by size of word

		lea	(SineTable+$80).l,a0			; load sinewave table
		move.w	(a0,d0.w),d1				; load Y sine
		asr.w	#5,d1					; sine pos / $20
		add.w	#$16,d1					; add offset
		move.w	d1,(a3)					; write BG Y position

		move.w	EMM_ScrollSpeed+SCROLL_1000_F.w,d0	; load FG scrolling speed
		swap	d0

	FBZ1_speed	SCROLL_0900_F
		jsr	(WriteScroll-($30*2))			; write scroll data
	FBZ1_speed	SCROLL_0300_F
		jsr	(WriteScroll-($20*2))			; write scroll data
	FBZ1_speed	SCROLL_0700_F
		jsr	(WriteScroll-($30*2))			; write scroll data
	FBZ1_speed	SCROLL_0500_F
		jsr	(WriteScroll-($10*2))			; write scroll data
	FBZ1_speed	SCROLL_0800_F
		jsr	(WriteScroll-($10*2))			; write scroll data
	FBZ1_speed	SCROLL_0400_F
		jsr	(WriteScroll-($10*2))			; write scroll data
	FBZ1_speed	SCROLL_0600_F
		jsr	(WriteScroll-($10*2))			; write scroll data
	FBZ1_speed	SCROLL_0200_F
		jsr	(WriteScroll-($10*2))			; write scroll data
	FBZ1_speed	SCROLL_0A00_F
		jmp	(WriteScroll-($30*2))			; write scroll data

; ===========================================================================
