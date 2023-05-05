
; ===========================================================================
; ---------------------------------------------------------------------------
; Animated Art - Death Egg Zone 1
; ---------------------------------------------------------------------------

		swap	d2					; convert long-word VDP port alignment back to word...
		lsl.w	#$02,d2					; ...because the S3K DMA queue routine is a stupid and unoptimal...
		lsr.l	#$02,d2					; ...piece of shit...
		move.w	d2,d4					; keep a copy stored away

	; handle tazers

		moveq	#0,d1
		move.b	(a2),d1					; load art frame position
		bchg	#6,(a2)					; swap to next art
		and.w	#$40,d1					; keep in range
		addi.l	#.tazer,d1				; add the starting address to it

		move.w	d4,d2					; load VRAM address to d2
		add.w	#$20*20,d2				; skip 20 tiles
		move.w	#$10*$02,d3				; set size (2 tiles worth)
		jsr	Add_To_DMA_Queue.w			; save for transfer later
		bra.w	ArtCyc_DEZ02.motor

; ---------------------------------------------------------------------------
; Include data
; ---------------------------------------------------------------------------

.tazer		binclude "Main Menu\Backgrounds\DEZ1\Art Tazer.unc"

; ===========================================================================
