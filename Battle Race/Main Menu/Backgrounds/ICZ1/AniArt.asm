; ===========================================================================
; ---------------------------------------------------------------------------
; Animated Art - Angel Island Zone 2
; ---------------------------------------------------------------------------

		swap	d2					; convert long-word VDP port alignment back to word...
		lsl.w	#$02,d2					; ''
		lsr.l	#$02,d2					; ''
		move.w	d2,d4					; keep a copy stored away
		move.w	(EMM_ScrollSpeed+SCROLL_0200_B).w,d1	; load scroll speed
		andi.l	#$20-1,d1				; keep within 20 frames
		cmp.b	(a2),d1					; had the frame changed?
		beq.s	ACICZ01_NoCrystals			; if not, branch
		move.b	d1,(a2)					; update the frame
		move.w	(a2),d1					; multiply by 100
		sf.b	d1					; clear lower byte
		add.w	d1,d1					; multiply to 200
		addi.l	#ACICZ01_Cryst,d1			; add the starting address to it
		move.w	d4,d2					; load VRAM address to d2
		addi.w	#$10*$20,d2				; advance to crystal art
		move.w	#($10*$20)/2,d3				; set size
		jsr	Add_To_DMA_Queue.w			; save for transfer later

ACICZ01_NoCrystals:
	move.l	(EMM_PosY_BG1).l,d5
	tst.b	(EMM_SlotID).l
	beq.s	ACICZ01_Slot02
	move.l	(EMM_PosY_BG2).l,d5

ACICZ01_Slot02:
	move.l	d5,d1
	asr.l	#$01,d1
	move.l	d1,d2
	asr.l	#$01,d2
	sub.l	d2,d1
	swap	d1
		andi.l	#$40-1,d1				; keep within 40 frames
		cmp.b	$01(a2),d1				; had the frame changed?
		beq.s	ACICZ01_NoCavityLargest			; if not, branch
		move.b	d1,$01(a2)				; update the frame
		lsl.w	#$08,d1					; multiply by 100
		addi.l	#ACICZ01_CavLas,d1			; add the starting address to it
		move.w	d4,d2					; load VRAM address to d2
		move.w	#($08*$20)/2,d3				; set size
		jsr	Add_To_DMA_Queue.w			; save for transfer later

ACICZ01_NoCavityLargest:
		addi.w	#($08*$20),d4				; advance to next VRAM address
	move.l	d5,d1
	asr.l	#$01,d1
	move.l	d1,d2
	asr.l	#$02,d2
	sub.l	d2,d1
	swap	d1
		andi.l	#$20-1,d1				; keep within 20 frames
		cmp.b	$02(a2),d1				; had the frame changed?
		beq.s	ACICZ01_NoCavityLarge			; if not, branch
		move.b	d1,$02(a2)				; update the frame
		lsl.w	#$07,d1					; multiply by 80
		addi.l	#ACICZ01_CavLar,d1			; add the starting address to it
		move.w	d4,d2					; load VRAM address to d2
		move.w	#($04*$20)/2,d3				; set size
		jsr	Add_To_DMA_Queue.w			; save for transfer later

ACICZ01_NoCavityLarge:
		addi.w	#($04*$20),d4				; advance to next VRAM address
	move.l	d5,d1
	asr.l	#$01,d1
	move.l	d1,d2
	asr.l	#$04,d2
	sub.l	d2,d1
	swap	d1
		andi.l	#$10-1,d1				; keep within 10 frames
		cmp.b	$03(a2),d1				; had the frame changed?
		beq.s	ACICZ01_NoCavityMedium			; if not, branch
		move.b	d1,$03(a2)				; update the frame
		lsl.w	#$06,d1					; multiply by 40
		addi.l	#ACICZ01_CavMed,d1			; add the starting address to it
		move.w	d4,d2					; load VRAM address to d2
		move.w	#($02*$20)/2,d3				; set size
		jsr	Add_To_DMA_Queue.w			; save for transfer later

ACICZ01_NoCavityMedium:
		addi.w	#($02*$20),d4				; advance to next VRAM address
	move.l	d5,d1
	move.l	d1,d2
	asr.l	#$01,d2
	sub.l	d2,d1
	swap	d1
		andi.l	#$08-1,d1				; keep within 8 frames
		lsl.w	#$05,d1					; multiply by 20
		addi.l	#ACICZ01_CavSml,d1			; add the starting address to it
		move.w	d4,d2					; load VRAM address to d2
		move.w	#($01*$20)/2,d3				; set size
		jsr	Add_To_DMA_Queue.w			; save for transfer later
		addi.w	#($01*$20),d4				; advance to next VRAM address
	move.l	d5,d1
	move.l	d1,d2
	asr.l	#$02,d2
	sub.l	d2,d1
	swap	d1
		andi.l	#$08-1,d1				; keep within 8 frames
		lsl.w	#$05,d1					; multiply by 20
		addi.l	#ACICZ01_CavSmr,d1			; add the starting address to it
		move.w	d4,d2					; load VRAM address to d2
		move.w	#($01*$20)/2,d3				; set size
		jmp	Add_To_DMA_Queue.w			; save for transfer later

; ---------------------------------------------------------------------------
; Include data
; ---------------------------------------------------------------------------

ACICZ01_Cryst:	binclude "Main Menu\Backgrounds\ICZ1\Art Ani Crystals.bin"
		even
ACICZ01_CavLas:	binclude "Main Menu\Backgrounds\ICZ1\Art Ani Cavity Largest.bin"
		even
ACICZ01_CavLar:	binclude "Main Menu\Backgrounds\ICZ1\Art Ani Cavity Large.bin"
		even
ACICZ01_CavMed:	binclude "Main Menu\Backgrounds\ICZ1\Art Ani Cavity Medium.bin"
		even
ACICZ01_CavSml:	binclude "Main Menu\Backgrounds\ICZ1\Art Ani Cavity Small.bin"
		even
ACICZ01_CavSmr:	binclude "Main Menu\Backgrounds\ICZ1\Art Ani Cavity Smaller.bin"
		even

; ===========================================================================
