VINTSTACK:	REG d0-a1/a5-a6
V_INT:
	di
		move.w	#$2700,(sp)
		movem.l	VINTSTACK,-(sp)

		move.l	vdp_comm_port.w,a5
	dma68kToVDP PLANEMAP+($80*YOFF),PLANEVRAM+($80*YOFF),$2000-($80*YOFF*2),VRAM

		lea	BUTHELD.w,a0
		lea	$A10003.l,a1	; first	joypad port
		move.b	#0,(a1)
		nop
		nop
		move.b	(a1),d0
		lsl.b	#2,d0
		andi.b	#$C0,d0
		move.b	#$40,(a1)
		nop
		nop
		move.b	(a1),d1
		andi.b	#$3F,d1
		or.b	d1,d0
		not.b	d0
		move.b	(a0),d1
		eor.b	d0,d1
		move.b	d0,(a0)+
		and.b	d0,d1
		move.b	d1,(a0)+

		lea	PLANEMAP+($80*YOFF)+(XOFF*2).w,a5
		move.w	#28-1,d0
		moveq	#0,d1

.clrplane
	rept 40/2
		move.l	d1,(a5)+
	endr
		add.w	#(64-40)*2,a5
		dbf	d0,.clrplane

		lea	PLANEMAP.w,a5
		lea	OBJECTS+ART.w,a0
		lea	PLANEMAP.w,a6
		moveq	#OBJCNT-1,d7
		moveq	#0,d0
		moveq	#0,d5

.objloop	moveq	#0,d6
		move.w	(a0)+,a1	; art
		move.b	(a0)+,d0	; off
		add.w	d0,a1		; add off
		move.b	(a1)+,d5	; get width
		move.b	(a1)+,d6	; get height
		move.w	(a1),a1		; art data

		move.b	(a0)+,d4	; xpos
		andi.w	#$3F,d4		; keep in range
		add.w	d4,d4		; prepare for getplane
		move.b	(a0),d3		; ypos
		andi.w	#$3F,d3		; keep in range
		lsl.w	#7,d3		; prepare for getplane

.yloop		move.w	d5,d2		; copy width
		move.w	d4,d0		; copy xpos
		add.w	d3,d0		; add ypos
		lea	(a6,d0.w),a5	; get plane ptr

.xloop		moveq	#0,d0
		move.b	(a1)+,d0
		move.w	d0,d1
		andi.w	#$F,d0
		beq.s	.nul1
		move.w	d0,2(a5)

.nul1		lsr.b	#4,d1
		beq.s	.nul2
		move.w	d1,(a5)
.nul2		addq.w	#4,a5
		dbf	d2,.xloop

		add.w	#$80,d3		; add 1 to ypos
		dbf	d6,.yloop

		addq.w	#SIZE-YPOS+2,a0	; next obj
		dbf	d7,.objloop

		movem.l	(sp)+,VINTSTACK
		rte
