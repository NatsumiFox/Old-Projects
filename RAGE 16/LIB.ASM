; ===========================================================================
LoadObj:
		moveq	#OBJCNT-2,d0
		lea	OBJECTS+SIZE.w,a1

.load		tst.w	(a1)
		beq.s	.found
		add.w	#SIZE,a1
		dbf	d0,.load

		move.w	#0,a1
.found		rts

; ===========================================================================
DeleteObj:
		clr.w	(a0)
		move.w	#ART_NUL,ART(a0)
		clr.l	FRAME(a0)
		clr.w	STAT(a0)

ObjRTS:
		rts

; ===========================================================================
CreateMovingObj:
		move.w	#MovingObj,(a0)
		move.b	#XOFF+41,XPOS(a0)

MovingObj:
		btst	#7,PLANEUPDATED.w
		beq.s	ObjRTS
		subq.b	#1,XPOS(a0)

		move.w	a0,a1
		bsr.s	GetObjSize

		move.b	XPOS(a0),d0
		add.b	(a2),d0
		add.b	(a2)+,d0
		addq.b	#2,d0
		cmp.b	#XOFF,d0
		blt.s	DeleteObj
		rts

; ===========================================================================
GetObjSize:
		moveq	#0,d0
		move.w	ART(a1),a2	; art
		move.b	FRAME(a1),d0	; off
		add.w	d0,a2		; add off
		rts
; ===========================================================================
