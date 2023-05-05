; ===========================================================================
; ---------------------------------------------------------------------------
; Animated Art - Sky Sanctuary Zone Act 1
; ---------------------------------------------------------------------------

		swap	d2					; convert long-word VDP port alignment back to word...
		lsl.w	#$02,d2					; ...because the S3K DMA queue routine is a stupid and unoptimal...
		lsr.l	#$02,d2					; ...piece of shit...
		move.w	d2,d4					; keep a copy stored away

	; handle cloud rendering

		subq.b	#1,1(a2)				; decrease counter
		bgt.s	.noclouds				; branch if wont move yet
		moveq	#0,d1
		move.w	(a2),d1					; get frame
		addq.b	#4,(a2)					; increase to next position
		and.b	#$F,(a2)				; keep in range

		add.w	#$0110,2(a2)				; increase angle for next frame
		move.b	#12,1(a2)				; reset timer
		add.l	#.clouds,d1				; add art offset
		move.w	#$10*$20,d3				; write 32 tiles
		jmp	Add_To_DMA_Queue.w			; save for transfer later

.noclouds	moveq	#$00,d0					; clear d0
		move.b	2(a2),d0				; load angle
		add.w	#$0110,2(a2)				; increase angle for next frame
		add.w	d0,d0					; multiply by size of word

		lea	(SineTable).l,a0			; load sinewave table
		move.w	(a0,d0.w),d1				; load X sine
		asr.w	#1,d1					; get in range of -4 and 4
		add.w	#4*$20,d1				; range of 0 to 8
		and.l	#$E0,d1					; remove unnecessary bits
		cmp.b	EXTEND(a2),d1				; check if same frame
		beq.s	.rts					; if so, quit

		; we need to *0x15 this shit! =(
		move.w	d1,d0					; copy *1 to d0
		add.w	d0,d0					; *2
		add.w	d0,d0					; *4
		add.w	d0,d1					; total *5
		add.w	d0,d0					; *8
		add.w	d0,d0					; *10
		add.w	d0,d1					; *15
		add.l	#.plat,d1				; add art offset to d1

		move.w	d4,d2					; copy VRAM address to d2
		add.w	#$20*$20,d2				; offset $20 tiles
		move.w	#$10*$15,d3				; write 15 tiles
		jmp	Add_To_DMA_Queue.w			; save for transfer later
.rts		rts

; ---------------------------------------------------------------------------
; Include data
; ---------------------------------------------------------------------------

.clouds		binclude "Main Menu\Backgrounds\SSZ\Art Clouds.unc"
.plat		binclude "Main Menu\Backgrounds\SSZ\Art Platform.unc"

; ===========================================================================
