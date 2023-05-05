; ===========================================================================
; ---------------------------------------------------------------------------
; Animated Art - Launch Base Zone 2
; ---------------------------------------------------------------------------

		swap	d2					; convert long-word VDP port alignment
		lsl.w	#$02,d2					; ''
		lsr.l	#$02,d2					; ''
		move.w	d2,d4					; store in d4

		bset.b	#$00,(a2)				; set first animate flag
		bne.s	ACLBZ2_AlreadyStarted			; if it's already ran once, branch

		; Flushing non-water wall art (for first frame) so the number
		; tiles don't show.
		move.l	#ACLBZ02_WaterT,d1			; set source art address
		move.w	d4,d2					; load VRAM address
		move.w	#($20*$06)/2,d3				; set size (6 tiles worth)
		jsr	Add_To_DMA_Queue.w			; save for transfer later
		move.l	#ACLBZ02_WaterB,d1			; set source art address
		move.w	d4,d2					; load VRAM address
		addi.w	#($20*$06),d2				; advance to bottom water tiles
		move.w	#($20*$06)/2,d3				; set size (6 tiles worth)
		jmp	Add_To_DMA_Queue.w			; save for transfer later

	; Doing the actual water correctly now...

ACLBZ2_AlreadyStarted:
		moveq	#$00,d0					; clear d0
		move.b	(EMM_ScrollSpeed+(((($1000-$0800)/$40)*4)+$01)).l,d0	; load scroll position
		addi.b	#$80-$10,d0				; rotate so that the rotation is inline with the pipes
		add.w	d0,d0					; multiply by size of word
		lea	(SineTable).l,a0			; load sinewave table
		moveq	#$00,d1
		move.w	(a0,d0.w),d1				; load position
		addq.w	#$08,d1					; make adjustment (for some reason it's half a pixel off...
		asr.w	#$03+1,d1				; divide to x20 (then half it for the distance between the FG and BG)
		bpl.s	ACLBZ2_Top				; if we're rendering the top, branch

ACLBZ2_Bottom:
		not.w	d1					; reverse direction to positive
		ext.l	d1					; extend long-word signed since it'll be used for addressing
		lsl.w	#$05,d1					; multiply by 20
		move.w	d1,d0					; store
		add.w	d1,d1					; multiply to x40
		add.w	d0,d1					; x60
		add.w	d1,d1					; xC0
		addi.l	#ACLBZ02_WaterB+($20*$06),d1		; add the starting address to it
		move.w	d4,d2					; load VDP address
		addi.w	#($20*$06),d2				; advance to bottom water tiles
		move.w	#($20*$06)/2,d3				; set size (6 tiles worth)
		jmp	Add_To_DMA_Queue.w			; save for transfer later

ACLBZ2_Top:
		bne.s	ACLBZ2_NoExact				; if we're not exactly at 00, branch
		move.l	d1,-(sp)				; because it's 00, both top and bottom need to be cleared
		bsr.s	ACLBZ2_Bottom				; ...so the bottom needs to be rendered using non-water frame...
		move.l	(sp)+,d1				; ''

ACLBZ2_NoExact:
		lsl.w	#$05,d1					; multiply by 20
		move.w	d1,d0					; store
		add.w	d1,d1					; multiply to x40
		add.w	d0,d1					; x60
		add.w	d1,d1					; xC0
		addi.l	#ACLBZ02_WaterT,d1			; add the starting address to it
		move.w	d4,d2					; set VDP address
		move.w	#($20*$06)/2,d3				; set size (6 tiles worth)
		jmp	Add_To_DMA_Queue.w			; save for transfer later

; ---------------------------------------------------------------------------
; Include data
; ---------------------------------------------------------------------------

ACLBZ02_WaterT:	binclude "Main Menu\Backgrounds\LBZ2\Art Ani Water Top.bin"
ACLBZ02_WaterB:	binclude "Main Menu\Backgrounds\LBZ2\Art Ani Water Bottom.bin"
		even

; ===========================================================================
