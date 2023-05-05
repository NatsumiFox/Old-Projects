; ===========================================================================
; ---------------------------------------------------------------------------
; Background Events - The Setup
; ---------------------------------------------------------------------------

OAZ2_BackgroundInit:
		movem.l	d0-a6,-(sp)				; store registers
		lea	($FFFF7F80).l,a1			; load block buffer
		moveq	#($80/4)-1,d1				; set size to clear
		moveq	#$00,d0					; clear d0

OAZ2_BI_ClearHScroll:
		move.l	d0,(a1)+				; clear block buffer
		dbf	d1,OAZ2_BI_ClearHScroll			; repeat until cleared
		jsr	OAZ2_Scroll				; run level's scrolling
		movem.l	(sp)+,d0-a6				; restore registers
		jsr	Reset_TileOffsetPositionEff		; setup X and Y xor positions
		moveq	#$00,d1					; X draw position?
		jmp	Refresh_PlaneFull			; render the entire screen

; ===========================================================================
; ---------------------------------------------------------------------------
; Background Events - The actual scrolling
; ---------------------------------------------------------------------------

OAZ2_BackgroundEvent:
		movem.l	d0-a6,-(sp)				; store registers
		jsr	OAZ2_Scroll				; run level's scrolling
		movem.l	(sp)+,d0-a6				; restore registers
		lea	(Camera_Y_pos_BG_copy).w,a6		; load Y position RAM data
		lea	(Camera_Y_pos_BG_rounded).w,a5		; load Y XOR RAM data
		moveq	#$00,d1					; X draw position?
		moveq	#$20,d6					; set number of blocks to draw in the row (whole row)
		jmp	Draw_TileRow				; draw only horizontal rows if moved by XOR amount

; ---------------------------------------------------------------------------
; 
; ---------------------------------------------------------------------------

OAZ2_Scroll:
		move.w	(Camera_Y_pos_copy).w,d0		; load Y position
		asr.w	#2,d0					; divide by 4 (slow it down)
		move.w	d0,(Camera_Y_pos_BG_copy).w		; set as BG Y position

		lea	($FFFF7F80).l,a1			; load block buffer
		clr.w	(a1)+					; clear speed 1
		moveq	#$00,d0					; clear d0
		move.w	(Camera_X_pos_copy).w,d0		; load X position
		neg.w	d0					; reverse direction
		swap	d0					; send to upper word
		asr.l	#$03,d0					; divide by 8
		move.l	d0,d1					; copy to d1
		asr.l	#$01,d1					; make 0.1
		move.l	d1,(a1)+				; ''
		move.l	d1,d2					; make 0.18
		asr.l	#$01,d2					; ''
		add.l	d2,d1					; ''
		move.l	d1,(a1)+				; ''
		move.l	d0,(a1)+				; make 0.2

		move.l	d0,d1					; make 0.3
		asr.l	#$01,d1					; ''
		add.l	d1,d0					; ''
		move.l	d0,(a1)+				; ''

		move.l	d0,d1					; make 0.3
		asr.l	#$02,d1					; ''
		add.l	d1,d0					; ''
		move.l	d0,($FFFF7F80+$20).l			; ''

		move.w	(Camera_X_pos_copy).w,d0		; make 0.8 (Other building speeds are dealt with via animation)
		neg.w	d0					; ''
		asr.w	#$01,d0					; ''
		move.w	d0,(a1)+				; ''

		move.w	(a1),d0					; load train current position
		andi.w	#$01FF,d0				; keep in range
		bne.s	OAZ2_Sc_NoTrainHalt			; if it hasn't reached end, branch
		subq.w	#$01,$02(a1)				; decrease timer
		beq.s	OAZ2_Sc_TrainStart			; if finished, branch
		bpl.s	OAZ2_Sc_TrainHalt			; if still running, branch
		move.w	#$0300,$02(a1)				; reset timer
		bra.s	OAZ2_Sc_TrainHalt			; continue

OAZ2_Sc_TrainStart:
		not.b	$04(a1)					; reverse direction

OAZ2_Sc_NoTrainHalt:
		subq.w	#$08,d0					; move train left
		tst.b	$04(a1)					; check direction
		beq.s	OAZ2_Sc_TrainHalt			; if it's moving left, branch
		addi.w	#$08*$02,d0				; move train right

OAZ2_Sc_TrainHalt:
		move.w	d0,(a1)+				; update train position
		addq.w	#$04,a1					; skip train delay timer and direction flag
		move.w	d0,(a1)+				; save train scroll position

		moveq	#$00,d0					; make 0.C
		move.w	(Camera_X_pos_copy).w,d0		; ''
		neg.w	d0					; ''
		swap	d0					; ''
		asr.l	#$01,d0					; ''
		move.l	d0,d1					; ''
		asr.l	#$01,d1					; ''
		add.l	d1,d0					; ''
		swap	d0					; ''
		move.w	d0,(a1)+				; ''

		move.w	(Camera_X_pos_copy).w,d0		; make 0.E
		neg.w	d0					; ''
		swap	d0					; ''
		asr.l	#$01,d0					; ''
		move.l	d0,d1					; ''
		asr.l	#$01,d1					; ''
		add.l	d1,d0					; ''
		asr.l	#$01,d1					; ''
		add.l	d1,d0					; ''
		swap	d0					; ''
		move.w	d0,(a1)+				; ''

		lea	OAZ2_List(pc),a0			; load scroll list to use
		move.w	#$00E0,d7				; prepare number of scanlines
		jmp	DeformScroll				; render list to scroll table

; ---------------------------------------------------------------------------
; Scroll data
; ---------------------------------------------------------------------------

OAZ2_List:	dc.w	$7F80+$00,	136			; sky with planet
		dc.w	$7F80+$02,	2			; very top city depth
		dc.w	$7F80+$06,	2			; very top city depth
		dc.w	$7F80+$0E,	4			; ''
		dc.w	$7F80+$12,	64			; top, mid and bottom animated city sections
		dc.w	$7F80+$1A,	8			; train
		dc.w	$7F80+$1C,	$38			; bridge
		dc.w	$7F80+$1E,	216			; buildings
		dc.w	$7F80+$1C,	8			; ceiling top
		dc.w	$7F80+$12,	32			; ceiling middle
		dc.w	$7F80+$20,	200			; ''

		dc.w	$0000					; end of list

; ===========================================================================