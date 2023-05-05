; ===========================================================================
; ---------------------------------------------------------------------------
; Scroll Data - Sandopolis Zone Act 1
; ---------------------------------------------------------------------------

SOZ1_lines	macro ct
	rept ct
		move.l	d0,d3					; copy value to d3
		add.w	(a2),d3					; add offset to plane
		swap	d3					; get BG
		add.w	(a2)+,d3				; add offset to plane
		move.l	d3,(a1)+				; write scroll pos
	endm
    endm

SOZ1_speed	macro addr
		swap	d0					; load BG part
		move.w	EMM_ScrollSpeed+addr.w,d0		; load bg speed
		swap	d0
    endm

		move.b	(a2),d0					; FG delay timer
		addq.b	#$01,(a2)				; increase timer
		asr.w	#1,d0					; halve offset
		and.w	#$3E,d0					; keep in range
		lea	word_5077E,a2				; get data array to a2
		add.w	d0,a2					; offset by loaded value

		move.w	EMM_ScrollSpeed+SCROLL_1000_F.w,d0	; load full speed scroll pos
	SOZ1_speed	SCROLL_0200_F				; set new BG speed

		moveq	#4-1,d2					; get loop count
.loop0	SOZ1_lines	$90/4					; write many lines at once
		dbf	d2,.loop0				; loop for number of times

	SOZ1_speed	SCROLL_0280_F				; set new BG speed
		bsr.w	.write8					; write 8 lines
	SOZ1_speed	SCROLL_0300_F				; set new BG speed
		bsr.w	.write8					; write 8 lines
	SOZ1_speed	SCROLL_0380_F				; set new BG speed
		bsr.w	.write8					; write 8 lines
	SOZ1_speed	SCROLL_0400_F				; set new BG speed
		bsr.w	.write8					; write 8 lines
	SOZ1_speed	SCROLL_0480_F				; set new BG speed
		bsr.w	.write8					; write 8 lines

	SOZ1_speed	SCROLL_0500_F				; set new BG speed
		bsr.s	.writ18					; write $18 lines
		bsr.w	.write8					; write 8 lines

.writ18	SOZ1_lines	$18
.write8	SOZ1_lines	$08
		rts

		; Scanlines, FG Speed, BG Speed

;		SCRL    $90, F,$1000, F,$0200
;		SCRL    $08, F,$1000, F,$0280
;		SCRL    $08, F,$1000, F,$0300
;		SCRL    $08, F,$1000, F,$0400
;		SCRL    $08, F,$1000, F,$0480
;		SCRL    $08, F,$1000, F,$0500
;		SCRL    $48, F,$1000, F,$0580

; ===========================================================================
