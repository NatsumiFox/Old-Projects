; ===========================================================================
; ---------------------------------------------------------------------------
; Animated Art - Death Egg Zone 2
; ---------------------------------------------------------------------------

		swap	d2					; convert long-word VDP port alignment back to word...
		lsl.w	#$02,d2					; ...because the S3K DMA queue routine is a stupid and unoptimal...
		lsr.l	#$02,d2					; ...piece of shit...
		move.w	d2,d4					; keep a copy stored away

	; handle motors rumbling

.motor		subq.b	#1,$01(a2)				; decrease delay timer
		bgt.s	.nomotors				; if still running, branch
		move.b	#2,$01(a2)				; reset timer

		moveq	#$00,d1					; clear d1
		move.w	(a2),d1					; load art frame position
		and.w	#$100,d1				; clear extra bits
		addi.l	#.motors,d1				; add the starting address to it
		bchg	#0,(a2)					; update frame position

		move.w	d4,d2					; load VRAM address to d2
		add.w	#$20,d2					; skip 1 tile
		move.w	#$10*$08,d3				; set size (8 tiles worth)
		jsr	Add_To_DMA_Queue.w			; save for transfer later

	; handle spinning wheel

.nomotors	subq.b	#$01,EXTEND+2(a2)			; decrease delay timer
		bpl.s	.nospin					; if still running, branch
		move.b	#5-1,EXTEND+2(a2)			; reset timer

		moveq	#$00,d1					; clear d1
		move.b	EXTEND+3(a2),d1				; load art frame position
		move.b	d1,d0					; copy to d0
		add.w	d1,d1					; double offset
		addi.l	#.spin,d1				; add the starting address to it

		add.b	#$30,d0					; go to next tile
		cmp.b	#$90,d0					; check if after last frame
		blo.s	.nowrapspin				; branch if not
		moveq	#0,d0					; reset frame
.nowrapspin	move.b	d0,EXTEND+3(a2)				; set offset

		move.w	d4,d2					; load VRAM address to d2
		add.w	#$20*15,d2				; skip 15 tiles
		move.w	#$10*$03,d3				; set size (3 tiles worth)
		jsr	Add_To_DMA_Queue.w			; save for transfer later

	; handle pistons

.nospin		subq.b	#$01,2(a2)				; decrease delay timer
		bpl.s	.nopiston				; if still running, branch
		move.b	#5-1,2(a2)				; reset timer

		moveq	#0,d1
		move.b	3(a2),d1				; get offset
		and.w	#6,d1					; keep it in range
		addq.b	#2,3(a2)				; increase offset

		move.w	d4,d2					; load VRAM address to d2
		add.w	#$20*18,d2				; skip 18 tiles
		move.w	#$10*$02,d3				; set size (2 tiles worth)
		move.w	.psoff(pc,d1.w),d1			; load offset to d1
		addi.l	#.piston,d1				; add the starting address to it
		jsr	Add_To_DMA_Queue.w			; save for transfer later

	; handle wheels turning

.nopiston	subq.b	#$01,EXTEND(a2)				; decrease delay timer
		bpl.s	.rts					; if still running, branch

		moveq	#0,d1
		move.b	EXTEND+1(a2),d1				; get offset
		and.w	#3,d1					; keep it in range
		addq.b	#1,EXTEND+1(a2)				; increase offset

		move.b	.whdelay(pc,d1.w),EXTEND(a2)		; read next delay from table
		add.w	d1,d1					; double offset
		move.w	.whoff(pc,d1.w),d1			; load offset to d1
		addi.l	#.wheel,d1				; add the starting address to it

		move.w	d4,d2					; load VRAM address to d2
		add.w	#$20*9,d2				; skip 9 tiles
		move.w	#$10*$06,d3				; set size (6 tiles worth)
		jmp	Add_To_DMA_Queue.w			; save for transfer later
.rts		rts						; return

.psoff		dc.w $20*0, $20*2, $20*4, $20*2
.whdelay	dc.b 9, 4, 9, 4
.whoff		dc.w $20*0, $20*6, $20*12, $20*6

; ---------------------------------------------------------------------------
; Include data
; ---------------------------------------------------------------------------

.motors		binclude "Main Menu\Backgrounds\DEZ2\Art Motors.unc"
.wheel		binclude "Main Menu\Backgrounds\DEZ2\Art Wheel.unc"
.spin		binclude "Main Menu\Backgrounds\DEZ2\Art Spin.unc"
.piston		binclude "Main Menu\Backgrounds\DEZ2\Art Piston.unc"

; ===========================================================================
