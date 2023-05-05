Obj_FlyingSonic:
		move.l	#.normal,(a0)		; set object
		move.w	parent2(a0),a1		; get player address

		move.w	xpos(a1),xpos(a0)
		move.w	ypos(a1),ypos(a0)
		move.b	#1,carried(a1)
		clr.b	anim(a1)
		clr.b	status(a1)
		move.w	#$800,inertia(a1)
.rts		rts
; ---------------------------------------------------------------------------

.normal		movem.w	parent2(a0),a1-a2	; get player address and controls
		bsr.s	.getspeed
		bsr.w	Obj_FS_Move

		move.w	xpos(a0),xpos(a1)
		move.w	ypos(a0),ypos(a1)

		tst.b	Super_Flag.w
		bne.s	.rts
		move.b	#6,status(a1)			; set on air
		clr.b	carried(a1)
		move.w	d2,xvel(a1)
		move.w	d3,yvel(a1)
		move.w	Camera_Y.w,Camera_min_Y.w
		jmp	DeleteObject_This.w		; delete this object

.getspeed	moveq	#0,d2
		moveq	#0,d3
		moveq	#$40,d0
		move.w	xvel(a0),d2
		beq.s	loc_827CA
		bmi.s	loc_827C0
		neg.w	d0
		add.w	d0,d2
		bpl.s	loc_827C6
		bra.s	loc_827C4
; ---------------------------------------------------------------------------

loc_827C0:
		add.w	d0,d2
		bmi.s	loc_827C6

loc_827C4:
		moveq	#0,d2

loc_827C6:
		move.w	d2,xvel(a0)

loc_827CA:
		moveq	#$40,d0
		move.w	yvel(a0),d3
		beq.s	loc_827E8
		bmi.s	loc_827DE
		neg.w	d0
		add.w	d0,d3
		bpl.s	loc_827E4
		bra.s	loc_827E2
; ---------------------------------------------------------------------------

loc_827DE:
		add.w	d0,d3
		bmi.s	loc_827E4

loc_827E2:
		moveq	#0,d3

loc_827E4:
		move.w	d3,yvel(a0)

loc_827E8:
		tst.w	(a2)
		beq.s	loc_82828
		tst.b	Control_Locked.w
		bne.s	loc_82828
		move.b	(a2)+,d0
		move.b	(a2)+,d1
		andi.w	#$F,d0
		lsl.w	#2,d0
		andi.w	#$70,d1
		beq.s	loc_8281A
		movem.w	word_82872(pc,d0.w),d2-d3
		move.w	d2,xvel(a0)
		move.w	d3,yvel(a0)

loc_8281A:
		tst.w	d0
		beq.s	loc_82828
		movem.w	word_82832(pc,d0.w),d4-d5
		add.w	d4,d2
		add.w	d5,d3

loc_82828:
	;	move.w	d2,xvel(a1)
	;	move.w	d3,yvel(a1)
.rts		rts

; ---------------------------------------------------------------------------
word_82872:	dc.w  $600,	0
		dc.w	 0, -$600
		dc.w	 0,  $600
		dc.w	 0,	0
		dc.w -$600,	0
		dc.w -$43E, -$43E
		dc.w -$43E,  $43E
		dc.w	 0,	0
		dc.w  $600,	0
		dc.w  $43E, -$43E
		dc.w  $43E,  $43E
		dc.w	 0,	0
		dc.w	 0,	0
		dc.w	 0,	0
		dc.w	 0,	0
		dc.w	 0,	0

word_82832:	dc.w	 0,	0
		dc.w	 0, -$300
		dc.w	 0,  $300
		dc.w	 0,	0
		dc.w -$300,	0
		dc.w -$21F, -$21F
		dc.w -$21F,  $21F
		dc.w	 0,	0
		dc.w  $300,	0
		dc.w  $21F, -$21F
		dc.w  $21F,  $21F
		dc.w	 0,	0
		dc.w	 0,	0
		dc.w	 0,	0
		dc.w	 0,	0
		dc.w	 0,	0
; ---------------------------------------------------------------------------

Obj_FS_Move:
		move.l	xpos(a0),d0
		ext.l	d2
		lsl.l	#8,d2
		add.l	d2,d0
		move.l	d0,xpos(a0)

		move.l	ypos(a0),d0
		ext.l	d3
		lsl.l	#8,d3
		add.l	d3,d0
		move.l	d0,ypos(a0)

		move.w	Camera_X.w,d1
		move.w	xpos(a0),d0

		add.w	#16,d1
		cmp.w	d1,d0
		bgt.s	.f
		move.w	d1,xpos(a0)

.f		add.w	#((320/4)*3)-32,d1
		cmp.w	d1,d0
		blt.s	.chky
		move.w	d1,xpos(a0)

.chky		move.w	Camera_Y.w,d1
		move.w	ypos(a0),d0

		add.w	#16,d1
		cmp.w	d1,d0
		bgt.s	.d
		move.w	d1,ypos(a0)

.d		add.w	#240-36-16,d1
		cmp.w	d1,d0
		blt.s	.rts
		move.w	d1,ypos(a0)
.rts		rts
; ---------------------------------------------------------------------------
