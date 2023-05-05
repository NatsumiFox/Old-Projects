; ===========================================================================
; ---------------------------------------------------------------------------
; Animated Art - Options
; ---------------------------------------------------------------------------

		swap	d2					; convert long-word VDP port alignment back to word...
		lsl.w	#$02,d2					; ...because the S3K DMA queue routine is a stupid and unoptimal...
		lsr.l	#$02,d2					; ...piece of shit...

		moveq	#$00,d1
		move.w	(a2),d1
		addq.w	#$04,(a2)
	btst.l	#$02,d1
	bne.s	ACOPTIO_Hold
		lsl.w	#$07,d1
		andi.w	#$FC00,d1
		addi.l	#ACOPTIO_Bars,d1			; add the starting address to it

	move.w	d2,-(sp)
		move.w	#($20*$20)/2,d3				; set size
		jsr	Add_To_DMA_Queue.w			; save for transfer later
	move.w	(sp)+,d2

ACOPTIO_Hold:
		moveq	#$00,d1
		move.b	$02(a2),d1
		cmpi.w	#$08,d1
		blo.s	ACOPTIO_OK
		moveq	#$00,d1
		move.w	d1,$02(a2)

ACOPTIO_OK:
		addi.w	#$0100,$02(a2)
		mulu.w	#$24*$20,d1
		addi.l	#ACOPTIO_Cogs,d1			; add the starting address to it

		addi.w	#$0400,d2				; increase VRAM address to the area where the animated tiles are
		move.w	#($24*$20)/2,d3				; set size
		jmp	Add_To_DMA_Queue.w			; save for transfer later

; ---------------------------------------------------------------------------
; Include data
; ---------------------------------------------------------------------------

ACOPTIO_Bars:	binclude "Main Menu\Backgrounds\_Options\Art Ani Bars.bin"
		even
ACOPTIO_Cogs:	binclude "Main Menu\Backgrounds\_Options\Art Ani Cogs.bin"
		even

; ===========================================================================
