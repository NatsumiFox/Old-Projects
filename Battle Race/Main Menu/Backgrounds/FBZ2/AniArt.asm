; ===========================================================================
; ---------------------------------------------------------------------------
; Animated Art - Flying Battery Zone Act 2
; ---------------------------------------------------------------------------

		subq.b	#$01,1(a2)				; decrease delay timer
		bgt.s	.rts					; if still running, branch
		moveq	#0,d1
		move.w	(a2),d1					; get offset

		addq.b	#1,(a2)					; increase offset
		cmp.b	#3,(a2)					; check for range
		blo.s	.noreset				; branch if not over
		clr.b	(a2)					; reset position

.noreset	move.b	#7,1(a2)				; reset timer
		swap	d2					; convert long-word VDP port alignment back to word...
		lsl.w	#$02,d2					; ...because the S3K DMA queue routine is a stupid and unoptimal...
		lsr.l	#$02,d2					; ...piece of shit...
		add.w	#$20*$7D,d2				; skip 3 tiles

		add.l	#.pillar,d1				; add data offset to d1
		move.w	#$10*$08,d3				; set size (8 tiles worth)
		jmp	Add_To_DMA_Queue.w			; save for transfer later
.rts		rts						; return

; ---------------------------------------------------------------------------
; Include data
; ---------------------------------------------------------------------------

.pillar		binclude "Main Menu\Backgrounds\FBZ2\Art Pillar.unc"

; ===========================================================================
