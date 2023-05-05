; ===========================================================================
; ---------------------------------------------------------------------------
; Animated Art - Hydrocity Zone 2
; ---------------------------------------------------------------------------

		swap	d2					; convert long-word VDP port alignment back to word...
		lsl.w	#$02,d2					; ''
		lsr.l	#$02,d2					; ''
		move.w	d2,d4					; keep a copy stored away
		subq.b	#$01,(a2)				; increase timer
		move.w	(a2),d0					; load position
		tst.b	$01(a2)					; has the art updated fully once?
		beq.s	ACHCZ02_Update				; if not, branch to do that...
		btst.l	#$08,d0					; is this an odd frame?
		bne.s	ACHCZ02_NoMain				; if so, branch (save CPU time)

ACHCZ02_Update:

	; --- Main larger BG 1 section ---

		andi.l	#$00007E00,d0				; get within 40 frames
		move.l	d0,d1					; copy to d1 (store x200)
		add.w	d0,d0					; multiply to x400
		add.l	d0,d1					; multiply to x600
		addi.l	#ACHCZ02_BG1,d1				; advance to correct art start address
		move.w	#($20*$30)/2,d3				; set size
		jsr	Add_To_DMA_Queue.w			; save for transfer later

	; --- Main small BG 2 section ---

		move.w	(a2),d0					; load position
		andi.l	#$00003E00,d0				; get within 20 frames
		move.l	d0,d1					; copy to d1 (store x200)
		lsr.w	#$01,d1					; divide to x100
		add.w	d0,d1					; multiply to x300
		addi.l	#ACHCZ02_BG2+$80,d1			; advance to correct art start address
		move.w	d4,d2					; reload VRAM address
		addi.w	#($20*$30)+$80,d2			; increase VRAM address to the area where the animated tiles are
		move.w	#($20*$14)/2,d3				; set size
		jsr	Add_To_DMA_Queue.w			; save for transfer later

ACHCZ02_NoMain:

	; --- Main 4 tiles different scrolling BG 2 section ---

		move.w	(a2),d0					; load position
		move.w	d0,d1					; subtract 1/2 of the position to slow it down
		lsr.w	#$01,d1					; ''
		sub.w	d1,d0					; ''
		andi.l	#$00003E00,d0				; get within 20 frames
		move.l	d0,d1					; copy to d1 (store x200)
		lsr.w	#$01,d1					; divide to x100
		add.w	d0,d1					; multiply to x300
		addi.l	#ACHCZ02_BG2,d1				; advance to correct art start address
		move.w	d4,d2					; reload VRAM address
		addi.w	#($20*$30),d2				; increase VRAM address to the area where the animated tiles are
		move.w	#($20*$04)/2,d3				; set size
		jsr	Add_To_DMA_Queue.w			; save for transfer later

	; --- Behind cove BG 3 section ---

		move.w	(a2),d1					; load position
		lsr.w	#$03,d1					; slow it down
		tst.b	$01(a2)					; has the art updated fully once?
		beq.s	ACHCZ02_Update2				; if not, branch to do that
		tst.b	d1					; has it advanced a whole frame yet?
		bne.s	ACHCZ02_Return				; if not, branch (save CPU time)

ACHCZ02_Update2:
		sf.b	$01(a2)					; set as full updated once
		andi.l	#$00001F00,d1				; get within 20 frames
		addi.l	#ACHCZ02_BG3,d1				; advance to correct art start address
		move.w	d4,d2					; reload VRAM address
		addi.w	#($20*$30)+($20*$18),d2			; increase VRAM address to the area where the animated tiles are
		move.w	#($20*$08)/2,d3				; set size
		jmp	Add_To_DMA_Queue.w			; save for transfer later

ACHCZ02_Return:
		rts						; return

; ---------------------------------------------------------------------------
; Include data
; ---------------------------------------------------------------------------

ACHCZ02_BG1:	binclude "Main Menu\Backgrounds\HCZ2\Ani Art BG1.bin"
ACHCZ02_BG2:	binclude "Main Menu\Backgrounds\HCZ2\Ani Art BG2.bin"
ACHCZ02_BG3:	binclude "Main Menu\Backgrounds\HCZ2\Ani Art BG3.bin"
		even

; ===========================================================================
