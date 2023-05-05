; ===========================================================================
ObjTitle1:
		btst	#0,PLANEUPDATED.w
		bne.s	.out
		move.w	#ART_TITLE1,ART(a0)
		move.b	#XOFF+3,XPOS(a0)
		move.b	#YOFF+2,YPOS(a0)
		move.w	#.waitloop,(a0)

.waitloop	tst.b	BUTPRESS.w
		bpl.s	.rts
		move.w	#.fadeout,(a0)

.fadeout	addq.b	#1,XPOS(a0)
		cmp.b	#XOFF+40,XPOS(a0)
		bls.s	.rts

		jsr	DeleteObj.w
.out		move.w	#ObjPlayer,(a0)
		move.w	#ObjGround,SIZE(a0)
		bset	#0,PLANEUPDATED.w
.rts		rts

; ===========================================================================
ObjTitle2:
		move.w	#ART_TITLE2,ART(a0)
		move.b	#YOFF+2,YPOS(a0)
		move.w	#.waitloop,(a0)

.waitloop	move.b	OBJECTS+XPOS.w,d0
		add.b	#18,d0
		cmp.b	#XOFF+40,d0
		bhi.w	DeleteObj
		move.b	d0,XPOS(a0)
		rts

; ===========================================================================
ObjDiff:
		move.w	#ART_DIFF,ART(a0)
		move.b	#YOFF+16,YPOS(a0)
		move.b	#XOFF+9,XPOS(a0)
		move.w	#.waitloop,(a0)

.waitloop	cmp.b	#XOFF+3,OBJECTS+XPOS.w
		bne.w	DeleteObj
		rts

; ===========================================================================
ObjChoose:
		move.w	#ART_DIFFSEL,ART(a0)
		move.b	#YOFF+22,YPOS(a0)
		move.b	#XOFF+4,XPOS(a0)
		move.w	#.waitloop,(a0)

.waitloop	cmp.b	#XOFF+3,OBJECTS+XPOS.w
		bne.w	DeleteObj

		move.b	BUTPRESS.w,d0
		andi.w	#3,d0
		beq.s	.rts
		move.b	#YOFF+17,YPOS(a0)
		bset	#1,PLANEUPDATED.w
		bchg	#0,DAT1(a0)
		beq.s	.rts
		move.b	#YOFF+22,YPOS(a0)
		bclr	#1,PLANEUPDATED.w
.rts		rts

; ===========================================================================
ObjWin:
		move.w	#ART_END,ART(a0)
		move.b	#XOFF,XPOS(a0)
		move.b	#YOFF+1,YPOS(a0)
		clr.w	OBJECTS.w
		move.w	#ART_NUL,OBJECTS+ART.w
		rts

; ===========================================================================
ObjGround:
		move.w	#ART_GROUND,ART(a0)
		move.b	#XOFF,XPOS(a0)
		move.b	#YOFF+26,YPOS(a0)
		bset	#ST_SOLID,STAT(a0)
		move.w	#ObjRTS,(a0)
		rts

; ===========================================================================
ObjTile:
		move.b	ARG(a0),FRAME(a0)
		move.w	#ART_TILE,ART(a0)
		bset	#ST_SOLID,STAT(a0)
		jmp	CreateMovingObj.w

; ===========================================================================
ObjSpike:
		move.b	ARG(a0),FRAME(a0)
		move.w	#ART_SPIKE,ART(a0)
		bset	#ST_SOLID,STAT(a0)
		jsr	CreateMovingObj.w
		move.w	#.waithurt,(a0)

.waithurt	jsr	MovingObj.w
		btst	#ST_BOTTOM,STAT(a0)
		bne.s	.kill
		btst	#ST_STOOD,STAT(a0)
		beq.s	.rts
.kill		bset	#PL_DIE,OBJECTS+STAT.w
.rts		rts

; ===========================================================================
ObjSpring:
		move.b	ARG(a0),FRAME(a0)
		move.w	#ART_SPRING,ART(a0)
		bset	#ST_SOLID,STAT(a0)
		jsr	CreateMovingObj.w
		move.w	#.wait,(a0)

.wait		jsr	MovingObj.w
		tst.b	ARG(a0)
		bne.s	.ud
		btst	#ST_STOOD,STAT(a0)
		beq.s	.rts
		bclr	#ST_STOOD,OBJECTS+STAT.w
		move.w	#-$E0,PLAYERYVEL.w
		bclr	#ST_STOOD,STAT(a0)
.rts		rts

.ud		btst	#ST_BOTTOM,STAT(a0)
		beq.s	.rts
		move.w	#$D0,PLAYERYVEL.w
		bclr	#ST_BOTTOM,STAT(a0)
		rts

; ===========================================================================
ObjPlayer:
		move.w	#ART_PLAYER,ART(a0)
		move.b	#YOFF+24,YPOS(a0)
		move.w	#(YOFF+24)<<8,PLAYERYPOS.w
		move.b	#XOFF+2,XPOS(a0)
		move.w	#ObjPlayer_Main,(a0)

ObjPlayer_Main:
	; collision check
		lea	OBJECTS+SIZE.w,a1
		moveq	#OBJCNT-2,d6
		bclr	#ST_STOOD,STAT(a0)

.objloop	jsr	GetObjSize.w
	; check left
		move.b	XPOS(a0),d0
		addq.b	#3,d0
		sub.b	XPOS(a1),d0
		bmi.s	.nocoll

		move.b	XPOS(a1),d0
		add.b	(a2),d0
		add.b	(a2)+,d0
		sub.b	XPOS(a0),d0
		bmi.s	.nocoll

		move.b	YPOS(a0),d0
		addq.b	#2,d0
		sub.b	YPOS(a1),d0
		bne.s	.notontop

		tst.w	PLAYERYVEL.w
		bmi.s	.nocoll
		bset	#ST_STOOD,STAT(a0)
		bset	#ST_STOOD,STAT(a1)
		move.w	a1,STOODONOBJ.w
		clr.w	PLAYERYVEL.w

.notontop	bgt.s	.destroy
.nocoll		add.w	#SIZE,a1
		dbf	d6,.objloop

		btst	#PL_DIE,STAT(a0)
		bne.s	.destroy_
		btst	#ST_STOOD,STAT(a0)
		bne.s	.nofall

		move.w	PLAYERYVEL.w,d0
		add.w	#GRAVITY,d0
		bpl.s	.k

		move.b	BUTHELD.w,d1
		andi.b	#$70,d1
		beq.s	.k
		subq.w	#1,d0
.k		cmp.w	#$100,d0
		ble.s	.ok
		move.w	#$100,d0

.ok		add.w	d0,PLAYERYPOS.w
		move.w	d0,PLAYERYVEL.w
		move.b	PLAYERYPOS.w,YPOS(a0)
		rts

.nofall		move.b	BUTPRESS.w,d0
		andi.b	#$70,d0
		beq.s	.rts
		move.w	#-$C0,PLAYERYVEL.w
		bclr	#ST_STOOD,STAT(a0)
.rts		rts

.destroy	move.b	YPOS(a1),d0
		add.b	(a2),d0
		addq.b	#1,d0
		sub.b	YPOS(a0),d0
		bne.s	.notbottom

		tst.w	PLAYERYVEL.w
		bpl.s	.nocoll
		clr.w	PLAYERYVEL.w
		bset	#ST_BOTTOM,STAT(a1)
		bra.s	.nocoll

.notbottom	bmi.w	.nocoll
.destroy_	bclr	#7,PLANEUPDATED.w
		addq.b	#1,YPOS(a0)
		move.w	#-$C0,PLAYERYVEL.w
	;	move.w	PLANEX.w,PLANEXCHKPT.w

		jsr	LoadObj.w
		move.w	#DestroySparkMaster,(a1)
		clr.b	ARG(a1)
		move.b	XPOS(a0),XPOS(a1)
		move.b	YPOS(a0),YPOS(a1)
		subq.b	#1,YPOS(a1)

		jsr	LoadObj.w
		move.w	#DestroySpark,(a1)
		move.b	#1,ARG(a1)
		move.b	XPOS(a0),XPOS(a1)
		move.b	YPOS(a0),YPOS(a1)

		jsr	LoadObj.w
		move.w	#DestroySpark,(a1)
		move.b	#-1,ARG(a1)
		move.b	XPOS(a0),XPOS(a1)
		move.b	YPOS(a0),YPOS(a1)

		btst	#1,PLANEUPDATED.w
		beq.s	.del		; branch if hard
		move.w	PLANEX.w,d0
		cmp.w	PlanePoses.w,d0
		blo.s	.del
		move.w	PlanePoses.w,PLANEXCHKPT.w

		cmp.w	PlanePoses+2.w,d0
		blo.s	.del
		move.w	PlanePoses+2.w,PLANEXCHKPT.w

		cmp.w	PlanePoses+4.w,d0
		blo.s	.del
		move.w	PlanePoses+4.w,PLANEXCHKPT.w

.del		jmp	DeleteObj.w
; ===========================================================================

DestroySparkMaster:
		move.w	PLAYERYVEL.w,d0
		add.w	#GRAVITYL,d0
		add.w	d0,PLAYERYPOS.w
		move.w	d0,PLAYERYVEL.w
		move.b	PLAYERYPOS.w,YPOS(a0)
		subq.b	#1,YPOS(a0)

		cmp.b	#YOFF+28,YPOS(a0)
		ble.s	DestroySpark_
		jmp	GameProgram.w

DestroySpark:
		move.b	PLAYERYPOS.w,YPOS(a0)

DestroySpark_:
		move.w	#ART_PLAYERDEST,ART(a0)
		subq.b	#1,STAT(a0)
		bpl.s	.ok
		move.b	#10,STAT(a0)
		move.b	ARG(a0),d0
		add.b	d0,XPOS(a0)
.ok		rts
; ===========================================================================
