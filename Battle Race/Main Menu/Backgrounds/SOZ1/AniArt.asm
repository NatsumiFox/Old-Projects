; ===========================================================================
; ---------------------------------------------------------------------------
; Animated Art - Sandopolis Zone Act 1
; ---------------------------------------------------------------------------

		swap	d2					; convert long-word VDP port alignment back to word...
		lsl.w	#$02,d2					; ...because the S3K DMA queue routine is a stupid and unoptimal...
		lsr.l	#$02,d2					; ...piece of shit...
		move.w	d2,d4					; keep a copy stored away

	; handle mountains moving

		subq.b	#1,1(a2)				; decrease counter
		bmi.s	.do					; branch if wont move yet
		rts
.do		move.b	#8-1,1(a2)				; reset timer

		moveq	#0,d1
		move.b	(a2),d1					; get frame
		addq.b	#1,(a2)					; increase to next position
		and.b	#$1F,(a2)				; keep in range

		move.l	d1,d3					; copy to d0
		and.w	#$18,d3					; get tile offset
		and.w	#7,d1					; get tile position
		lsl.w	#7,d1					; * $80

		move.w	d1,d0					; copy offset to d0
		add.w	d0,d0					; double offset
		add.w	d0,d1					; * $180
		add.l	#.mountain,d1				; add tile data offset to d1
		move.l	d1,-(sp)				; save this for later

		moveq	#0,d0
		move.w	d3,d0					; copy to d3
		lsr.w	#1,d3					; halve offset
		lea	word_281B8,a0				; get table to a1
		add.w	d3,a0					; offset by word

		lsl.w	#2,d0					; * 4
		add.l	d0,d1					; add to the tile offset
		add.w	d0,d0					; * 8
		add.l	d0,d1					; total tile pos * 12 (total actual * $60)

		move.w	(a0)+,d3				; load next size
		add.w	d3,d4					; add to position
		add.w	d3,d4					; twice!
		jsr	Add_To_DMA_Queue.w			; save for transfer later

		move.l	(sp)+,d1				; get tile data back to d1
		move.w	(a0)+,d3				; get size
		beq.s	.mtndone				; if 0, skip
		move.w	d4,d2					; copy address again
		add.w	d3,d4					; fix art offset
		add.w	d3,d4					;
		jsr	Add_To_DMA_Queue.w			; save for transfer later

.mtndone	moveq	#0,d1
		move.b	(a2),d1					; get frame
		lsl.w	#6,d1					; * $40
		move.w	d1,d0					; copy to d0
		add.w	d1,d1					; * $80
		add.w	d0,d1					; * $C0
		add.l	#.mountain2,d1				; add art offset to d1

		move.w	d4,d2					; copy VRAM address
		move.w	#$10*6,d3				; write 6 tiles
		jmp	Add_To_DMA_Queue.w			; save for transfer later

; ---------------------------------------------------------------------------
; Include data
; ---------------------------------------------------------------------------

.mountain	binclude "Main Menu\Backgrounds\SOZ1\Art Mountains.unc"
.mountain2	binclude "Main Menu\Backgrounds\SOZ1\Art Mountains2.unc"

; ===========================================================================
