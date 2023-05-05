; ===========================================================================
; ---------------------------------------------------------------------------
; Animated Art - Mushroom Hill Zone Act 2
; ---------------------------------------------------------------------------

		swap	d2					; convert long-word VDP port alignment back to word...
		lsl.w	#$02,d2					; ...because the S3K DMA queue routine is a stupid and unoptimal...
		lsr.l	#$02,d2					; ...piece of shit...
		move.w	d2,d4					; copy VRAM to d4

		subq.b	#$01,EXTEND+1(a2)			; decrease delay timer
		bpl.s	.dmush1					; if still running, branch

		moveq	#0,d1
		move.b	EXTEND(a2),d1				; get offset
		addq.b	#1,EXTEND(a2)				; increase offset
		cmp.b	#12,EXTEND(a2)				; check against max
		blo.s	.noreset3				; if not above, branch
		clr.b	EXTEND(a2)				; clear offset

.noreset3	move.w	#$10*$2C,d3				; set size ($2C tiles worth)
		move.w	d4,d2					; load VRAM setting
		add.w	#$20*8,d2				; skip 8 tiles

		move.b	.m3delay(pc,d1.w),EXTEND+1(a2)		; reset delay
		add.b	d1,d1					; double offset
		move.w	.m3frame(pc,d1.w),d1			; load offset
		add.l	#.mush3,d1				; add data offset to d1
		jmp	Add_To_DMA_Queue.w			; save for transfer later

.m3delay	dc.b 5, 2, 3, 7, 2, 3, 5, 2, 3, 7, 2, 3
.m3frame	dc.w $20*$00, $20*$2C, $20*$58, $20*$84, $20*$58, $20*$2C, $20*$00, $20*$B0, $20*$DC, $20*$108, $20*$DC, $20*$B0

.dmush1		subq.b	#$01,1(a2)				; decrease delay timer
		bpl.s	.dmush2					; if still running, branch

		moveq	#0,d1
		move.b	(a2),d1					; get offset
		addq.b	#1,(a2)					; increase offset
		cmp.b	#12,(a2)				; check against max
		blo.s	.noreset				; if not above, branch
		clr.b	(a2)					; clear offset

.noreset	move.w	#$10*$04,d3				; set size (4 tiles worth)
		move.w	d4,d2					; load VRAM setting
		add.w	#$20*4,d2				; skip 4 tiles

		move.b	.m1delay(pc,d1.w),1(a2)			; reset delay
		add.b	d1,d1					; double offset
		move.w	.m1frame(pc,d1.w),d1			; load offset
		add.l	#.mush1,d1				; add data offset to d1
		jsr	Add_To_DMA_Queue.w			; save for transfer later

.dmush2		subq.b	#$01,3(a2)				; decrease delay timer
		bpl.s	.rts					; if still running, branch

		moveq	#0,d1
		move.b	2(a2),d1				; get offset
		addq.b	#1,2(a2)				; increase offset
		cmp.b	#20,2(a2)				; check against max
		blo.s	.noreset2				; if not above, branch
		clr.b	2(a2)					; clear offset

.noreset2	move.w	#$10*$04,d3				; set size (4 tiles worth)
		move.w	d4,d2					; load VRAM setting

		move.b	.m2delay(pc,d1.w),3(a2)			; reset delay
		add.b	d1,d1					; double offset
		move.w	.m2frame(pc,d1.w),d1			; load offset
		add.l	#.mush2,d1				; add data offset to d1
		jmp	Add_To_DMA_Queue.w			; save for transfer later
.rts		rts						; return

.m1delay	dc.b $1D, 0, 0, 0, 0, 0, 0, 1, $1D, 4, 4, 4
.m1frame	dc.w $20*$00, $20*$04, $20*$00, $20*$04, $20*$00, $20*$04, $20*$00, $20*$04
		dc.w $20*$08, $20*$0C, $20*$10, $20*$14

.m2delay	dc.b $18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, $31, 0, 0
.m2frame	dc.w $20*$00, $20*$04, $20*$00, $20*$04, $20*$08, $20*$04, $20*$08, $20*$0C
		dc.w $20*$08, $20*$0C, $20*$08, $20*$0C, $20*$10, $20*$0C, $20*$10, $20*$14
		dc.w $20*$10, $20*$14, $20*$00, $20*$14

; ---------------------------------------------------------------------------
; Include data
; ---------------------------------------------------------------------------

.mush1		binclude "Main Menu\Backgrounds\MHZ2\Art Mushrooms 1.unc"
.mush2		binclude "Main Menu\Backgrounds\MHZ2\Art Mushrooms 2.unc"
.mush3		binclude "Main Menu\Backgrounds\MHZ2\Art Large Mushroom.unc"

; ===========================================================================
