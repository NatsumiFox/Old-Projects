; ===========================================================================
; ---------------------------------------------------------------------------
; Animated Art - Flying Battery Zone Act 1
; ---------------------------------------------------------------------------

		subq.b	#$01,1(a2)				; decrease delay timer
		bpl.s	.rts					; if still running, branch
		move.b	#1,1(a2)				; reset timer

		moveq	#0,d1
		move.w	(a2),d1					; get offset
		addq.b	#2,(a2)					; increase offset
		and.b	#$E,(a2)				; keep in range

.noreset	swap	d2					; convert long-word VDP port alignment back to word...
		lsl.w	#$02,d2					; ...because the S3K DMA queue routine is a stupid and unoptimal...
		lsr.l	#$02,d2					; ...piece of shit...

		add.l	#.mesh-1,d1				; add data offset to d1
		move.w	#$10*$10,d3				; set size ($10 tiles worth)
		jmp	Add_To_DMA_Queue.w			; save for transfer later
.rts		rts						; return

; ---------------------------------------------------------------------------
; Include data
; ---------------------------------------------------------------------------

.mesh		binclude "Main Menu\Backgrounds\FBZ1\Art Mesh.unc"

; ===========================================================================
