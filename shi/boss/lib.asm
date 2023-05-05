; ---------------------------------------------------------------------------
; out:
;    d0 - Camera_min_X
;    d1 - Camera_min_Y
;    d2 - Camera_max_X
;    d3 - Camera_max_Y
; ---------------------------------------------------------------------------
Boss_LoadArea:
		move.w	Camera_min_X.w,d0
		move.w	d0,Boss_Left.w
		move.w	Camera_max_X.w,d2
		add.w	#320,d2
		move.w	d2,Boss_Right.w

		move.w	Camera_min_Y.w,d1
		move.w	d1,Boss_Top.w
		move.w	Camera_max_Y.w,d3
		add.w	#224,d3
		move.w	d3,Boss_Bottom.w
		rts
; ---------------------------------------------------------------------------
; in:
;    d0 - Camera_min_X
;    d1 - Camera_min_Y
;    d2 - Camera_max_X
;    d3 - Camera_max_Y
; out:
;    d0 - spawn x-pos
;    d1 . spawn y-pos
; ---------------------------------------------------------------------------
Boss_SetSpawn_ScrnMiddle:
		sub.w	d0,d2			; sub min x from max x
		lsr.w	#1,d2			; divide to half
		add.w	d2,d0			; add the offset to min x
		move.w	d0,xpos(a0)		; set xpos

		sub.w	d1,d3			; sub min y from max y
		lsr.w	#1,d3			; divide to half
		add.w	d3,d1			; add the offset to min y
		move.w	d1,ypos(a0)		; set ypos
		rts
; ---------------------------------------------------------------------------

ObjectDynPLC_Load:
		moveq	#0,d0
		move.b	frame(a0),d0
		cmp.b	dplcframe(a0),d0
		beq.s	locret_8506E
		move.b	d0,dplcframe(a0)
		move.w	tile(a0),d4
		andi.w	#$7FF,d4
		lsl.w	#5,d4
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		moveq	#0,d3

ObjectDynPLC_Loop:
		move.w	(a2)+,d3
		move.l	d3,d1
		andi.w	#$FFF0,d1
		add.w	d1,d1
		add.l	a3,d1
		move.w	d4,d2
		andi.w	#$F,d3
		addq.w	#1,d3
		lsl.w	#4,d3
		add.w	d3,d4
		add.w	d3,d4
		jsr	AddQueueDMA
		dbf	d5,ObjectDynPLC_Loop

locret_8506E:
		rts
