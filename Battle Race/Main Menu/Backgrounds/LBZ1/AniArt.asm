; ===========================================================================
; ---------------------------------------------------------------------------
; Animated Art - Launch Base 1
; ---------------------------------------------------------------------------

		swap	d2					; convert long-word VDP port alignment back to word...
		lsl.w	#$02,d2					; ''
		lsr.l	#$02,d2					; ''
		move.w	d2,d4					; keep a copy stored away

	; --- Mountains in the background

	move.w	(EMM_ScrollSpeed).W,d0			; use scroll speed instead (due to timer/scroll differences)
	add.w	d0,d0					; multiply by x4 (x4000)
	add.w	d0,d0					; ''
	;	move.w	(a2),d0					; load position
		move.b	d0,d1					; get lowest 7 bits
		add.b	d1,d1					; ''
		bne.s	ACLBZ_NoUpdate				; if any are set, then the timer hasn't increased, so branch (save on CPU time)

		andi.l	#$00000F80,d0				; get within 20 frames
		move.l	d0,d1					; copy to d1 (store x80)
		add.w	d0,d0					; multiply to x100
		add.l	d0,d0					; multiply to x200
		add.l	d0,d1					; multiply to x280
		addi.l	#ACLBZ01_Mounts,d1			; advance to correct art start address
		addi.w	#($20*$01),d2				; increase VRAM animated art address
		move.w	#($20*$14)/2,d3				; set size
		jsr	Add_To_DMA_Queue.w			; save for transfer later

ACLBZ_NoUpdate:

	; --- Main small BG 2 section ---

		move.w	(a2),d0					; load position
		move.b	d0,d1					; check lowest 5 bits
		andi.b	#$1F,d1					; ''
		bne.s	ACLBZ01_NoFloor				; if any are set, then the timer hasn't increased, so branch (save on CPU time)
		andi.l	#$000001E0,d0				; get within 10 frames
		lsl.w	#$03,d0					; multiply to x100
		move.l	d0,d1					; copy to d1
		addi.l	#ACLBZ01_Floor,d1			; advance to correct art start address
		move.w	d4,d2					; reload VRAM address
		addi.w	#($20*$01)+($20*$14),d2			; increase VRAM address to the area where the animated tiles are
		move.w	#($20*$08)/2,d3				; set size
		jsr	Add_To_DMA_Queue.w			; save for transfer later

ACLBZ01_NoFloor:
		addq.w	#$0008,(a2)				; increase timer

	; --- Badnik ---


		lea	(EMM_ScrTimers1).l,a3			; load slot 1 scroll timers
		btst.b	#$00,(EMM_ScrollSlot).l			; are we in slot 1?
		bne.s	ACLBZ02_Slot1				; if so, branch
		lea	(EMM_ScrTimers2).l,a3			; load slot 2 scroll timers

ACLBZ02_Slot1:
		move.w	(a3),d0					; load scroll position
		not.b	d0					; reverse direction
		andi.l	#$00000007,d0				; get within 8 frames
		move.b	(a3),d1					; get direciton bit
		andi.b	#%00001000,d1				; ''
		add.b	d1,d0					; add direction bit
		cmp.b	$02(a2),d0				; has it changed?
		beq.s	ACLBZ01_NoChange			; if not, branch
		move.b	d0,$02(a2)				; update position
		move.w	$02(a2),d0				; multiply by x100
		add.w	d0,d0					; multiply to x400
		add.w	d0,d0					; ''
		move.l	d0,d1					; copy to d1
		addi.l	#ACLBZ01_Badnik,d1			; advance to correct art start address
		move.w	d4,d2					; reload VRAM address
		addi.w	#($20*$01)+($20*$14)+($20*$08),d2	; increase VRAM address to the area where the animated tiles are
		move.w	#($20*$20)/2,d3				; set size
		jmp	Add_To_DMA_Queue.w			; save for transfer later

ACLBZ01_NoChange:
		rts						; return

; ---------------------------------------------------------------------------
; Include data
; ---------------------------------------------------------------------------

ACLBZ01_Mounts:	binclude "Main Menu\Backgrounds\LBZ1\Art Ani Mountains.bin"
ACLBZ01_Floor:	binclude "Main Menu\Backgrounds\LBZ1\Art Ani Floor.bin"
ACLBZ01_Badnik:	binclude "Main Menu\Backgrounds\LBZ1\Art Ani Badnik.bin"
		even

; ===========================================================================
