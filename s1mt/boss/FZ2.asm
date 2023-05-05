FZ2_Boss_ID:		equ $88
FZ2_Boss_Pos_Left:	equ FZ_Boss_Pos_Left
FZ2_Boss_Pos_Right:	equ FZ_Boss_Pos_Right
FZ2_Boss_Pos_Up:	equ FZ_Boss_Pos_Up
FZ2_Boss_Pos_Down:	equ FZ_Boss_Pos_Down

FZ2_Boss_SP_X:		equ FZ2_Boss_Pos_Left+((FZ2_Boss_Pos_Right-FZ2_Boss_Pos_Left)/2)
FZ2_Boss_SP_Y:		equ FZ2_Boss_Pos_Up+$60
FZ2_Boss_SP_Down:	equ FZ2_Boss_Pos_Down-$30
FZ2_Boss_Pos_ScrDown	equ FZ2_Boss_Pos_Down-$58
FZ2_Boss_Pos_ScrRight:	equ $1AC0

FZ2_Boss_HitsAdd:	equ Anim_Dur
FZ2_Boss_HitsDelay:	equ SubType
FZ2_Boss_Mode:		equ Inertia+1
FZ2_Boss_canCatch:	equ Inertia
FZ2_Boss_FinalHit:	equ Off29

FZ2_Boss_Delay:		equ Anim_scriptNum
FZ2_Boss_Routine3:	equ Anim
FZ2_Boss_TgtAngle:	equ Anim_Restart
FZ2_Boss_AddYVel:	equ Angle
FZ2_Boss_setX:		equ Angle

FZ2_Boss_Angle:		equ Respawn
FZ2_Boss_AngleMax:	equ 12*4
FZ2_Boss_AngleMin:	equ 0
FZ2_Boss_AngleSlam:	equ 7*4
; ---------------------------------------------------------------------------
; Object - Boss (GHZ2)
; ---------------------------------------------------------------------------
FZ2_Boss_LockScreen:
		cmpi.w	#FZ2_Boss_Pos_Left+$30,$FFFFF728.w
		beq.s	.skp
		addq.w	#2,$FFFFF728.w
		addq.w	#2,$FFFFF700.w

.skp		cmpi.w	#FZ2_Boss_Pos_ScrRight,$FFFFF72A.w
		beq.s	.skp2
		subq.w	#2,$FFFFF72A.w
		subq.w	#2,$FFFFF700.w

.skp2		rts
; ===========================================================================

FZ2_Boss:
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	FZ2_Boss_Index(pc,d0.w),d1
		jmp	FZ2_Boss_Index(pc,d1.w)
; ===========================================================================
FZ2_Boss_Index:	dc.w FZ2_Boss_Main-FZ2_Boss_Index
		dc.w FZ2_Boss_ShipMain-FZ2_Boss_Index
		dc.w FZ2_Boss_Follow-FZ2_Boss_Index
		dc.w FZ2_Boss_Face-FZ2_Boss_Index
		dc.w FZ2_Boss_Fire-FZ2_Boss_Index
		dc.w FZ2_Boss_ArmBall-FZ2_Boss_Index
		dc.w FZ2_Boss_Arm-FZ2_Boss_Index
		dc.w FZ2_Boss_ArmMain-FZ2_Boss_Index
		dc.w FZ2_Boss_Spikes-FZ2_Boss_Index
		dc.w FZ2_Boss_EscapePod-FZ2_Boss_Index
		dc.w FZ2_Boss_EscapePod2-FZ2_Boss_Index

FZ2_Boss_ObjData:
	dc.l FZ2_Boss_Maps
	dc.w $2000|($8000/$20)
	dc.b 2,	4, 0, 0, 0, 0
	dc.l FZ2_Boss_Maps
	dc.w $2000|($8000/$20)
	dc.b 4,	6, 0, 1, -$F, -4
	dc.l FZ2_Boss_Maps2
	dc.w $75C0/$20
	dc.b 4,	5, 0, 8, -$E, $14
	dc.l FZ2_Boss_Maps2
	dc.w $75C0/$20
	dc.b 6,	5, 0, 0, -$E, -8
	dc.l FZ2_Boss_Maps
	dc.w ($8000/$20)
	dc.b 8,	5, 0, $C, $2C, 0
	dc.l FZ2_Boss_Maps
	dc.w $2000|($8000/$20)
	dc.b $A, 2, 0, 3, $C, $10
	dc.l ArtSonInform
	dc.w $2000|($8000/$20)
	dc.b $10, 0, 0, 3

; ===========================================================================
FZ2_Boss_Spikes:
		movea.l	Off3C(a0),a1
		sf	Coll(a0)
		tst.b	Coll(a1)
		beq.s	.null
		move.b	#$28|$80,Coll(a0)

.null		move.w	x_pos(a1),d0
		add.w	#-4,d0
		move.w	d0,x_pos(a0)
		move.w	y_pos(a1),d0
		add.w	#-$1E,d0
		move.w	d0,y_pos(a0)
		move.b	Render_Flags(a1),Render_Flags(a0)

		cmp.b	#FZ2_Boss_ID,(a1)
		bne.s	.del
		rts

.del		jmp	DeleteObject

; ===========================================================================
FZ2_Boss_Main:
		lea	FZ2_Boss_ObjData(pc),a2	; get data array
		movea.l	a0,a1			; copy this object to a1
		moveq	#7-1,d1			; get length
		bra.s	FZ2_Boss_LoadBoss	; start with current object

FZ2_Boss_Loop:
		jsr	SingleObjLoad2		; load next object
		bne.s	FZ2_Boss_SkipLoad	; if all slots are full, end
		move.b	#FZ2_Boss_ID,(a1)	; use current object
		move.l	a0,Off3C(a1)		; save boss address

FZ2_Boss_LoadBoss:				; XREF: FZ2_Boss_Main
		move.l	(a2)+,Mappings_Offset(a1); get mappings
		move.w	(a2)+,Art_Tile(a1)	;
		move.b	#4,Render_Flags(a1)	;
		move.b	#$22,X_Visible(a1)	;
		move.b	(a2)+,Routine(a1)	; get routine counter
		move.b	(a2)+,Priority(a1)	; get priority
		move.b	(a2)+,Anim(a1)		; get animation
		move.b	(a2)+,Anim_Frame(a1)	; get mappings frame

		move.b	(a2)+,d0
		ext.w	d0
		move.w	d0,Off38(a1)
		move.b	(a2)+,d0
		ext.w	d0
		move.w	d0,Off3A(a1)
		dbf	d1,FZ2_Boss_Loop	; repeat sequence3 more times

FZ2_Boss_SkipLoad:
		move.w	X_pos(a0),Boss_X(a0)	;
		move.w	Y_Pos(a0),Boss_Y(a0)	; copy positions to other memory
		move.b	#$F,Coll(a0)		; set to boss
		move.b	#12,Coll2(a0)		; set number of	hits to	8
		st	BossMode.w		; we are in a boss :O
		move.b	#0,FZ2_Boss_HitsAdd(a0)
		move.b	#15,FZ2_Boss_HitsDelay(a0)	; more delay
		move.b	#2,FZ2_Boss_Mode(a0)
		move.b	#FZ2_Boss_AngleSlam,FZ2_Boss_Angle(a0)	; set to slamming angle

		lea	Pal_LBZboss,a1
		lea	Palette_NCurr+$20,a2
		moveq	#($20/4)-1,d0
		jsr	loc_pal
		addq.b	#2,$FFFFF742.w
		move.w	$FFFFF70C.w,PlaneBY_Stored.w
		move.w	#FZ2_Boss_Pos_ScrDown,$FFFFF72C.w

		moveq	#$FFFFFFE4+$06,d0	; music $06
		jsr	PlayMusic		; play eet

		cmpi.w	#FZ2_Boss_Pos_Right-8,Boss_X(a0)
		blo.s	.min
		move.w	#FZ2_Boss_Pos_Right-8,Boss_X(a0)

.min		cmpi.w	#FZ2_Boss_Pos_Left+$40,Boss_X(a0)
		bhi.s	FZ2_Boss_ShipMain
		move.w	#FZ2_Boss_Pos_Left+$40,Boss_X(a0)

FZ2_Boss_ShipMain:				; XREF: FZ2_Boss_Index
		moveq	#0,d0
		move.b	Routine2(a0),d0			; get secondary routine counter
		move.w	FZ2_Boss_ShipIndex(pc,d0.w),d0
		jsr	FZ2_Boss_ShipIndex(pc,d0.w)	; jump to the correct routine

		subq.b	#1,FZ2_Boss_HitsDelay(a0)	; is delay gone yet?
		bpl.s	.skp				; if not, branch
		move.b	FZ2_Boss_HitsAdd(a0),d0		; get normal hits
		cmp.b	Coll2(a0),d0			; check stored its
		bge.s	.skp				; if same or more, skip

		addq.b	#1,d0				; add 1 to stored hits
		move.b	d0,FZ2_Boss_HitsAdd(a0)		; store the hits count
		tas	d0				; set draw bit
		move.b	d0,BossLives.w			; set to stored lives
		move.b	#4,FZ2_Boss_HitsDelay(a0)	; more delay
		moveq	#$FFFFFFCD,d0
		jsr	PlaySound			; play "blip" sound

.skp		move.b	Status(a0),d0
		andi.b	#3,d0				; only maintain X and Y flip bits
		andi.b	#$FC,Render_Flags(a0)		; clear X and Y flip bits
		or.b	d0,Render_Flags(a0)		; if X and Y flip bits were set, copy to Render flags

		tst.b	FZ2_Boss_FinalHit(a0)
		bpl.s	.disp			; else do
		sf	Coll(a0)
		bsr.w	BossDefeated		; generate explosions
		bchg	#7,Off2A(a0)
		beq.s	.disp
		rts

.disp		jmp	DisplaySprite			; display sprite

; ==========================================================================
FZ2_Boss_ShipIndex:
		dc.w FZ2_Boss_InitSlam-FZ2_Boss_ShipIndex
		dc.w FZ2_Boss_Slam-FZ2_Boss_ShipIndex
		dc.w FZ2_Boss_DelayFrames-FZ2_Boss_ShipIndex
		dc.w FZ2_Boss_MoveOffScr-FZ2_Boss_ShipIndex
		dc.w FZ2_Boss_DecideSide-FZ2_Boss_ShipIndex
		dc.w FZ2_Boss_MoveToRightSide-FZ2_Boss_ShipIndex
		dc.w FZ2_Boss_MoveToLeftSide-FZ2_Boss_ShipIndex
		dc.w FZ2_Boss_MidScreen-FZ2_Boss_ShipIndex
		dc.w FZ2_Boss_AttackRight-FZ2_Boss_ShipIndex	; $10
		dc.w FZ2_Boss_AttackLeft-FZ2_Boss_ShipIndex
		dc.w FZ2_Boss_SlamUp-FZ2_Boss_ShipIndex
		dc.w FZ2_Boss_SlamGetPos-FZ2_Boss_ShipIndex
		dc.w FZ2_Boss_Explode-FZ2_Boss_ShipIndex
		dc.w FZ2_Boss_Escape-FZ2_Boss_ShipIndex
		dc.w FZ2_Boss_ShipDel-FZ2_Boss_ShipIndex	; $1C

; ===========================================================================
FZ2_Boss_MoveOffScr:
		move.w	#-$200,y_vel(a0)
		subq.b	#2,Routine2(a0)
		move.b	#8,FZ2_Boss_Routine3(a0)
		move.b	#108,FZ2_Boss_Delay(a0)
		move.b	#0,FZ2_Boss_Angle(a0)
		move.w	#-$18,FZ2_Boss_AddYVel(a0)
		rts

; ===========================================================================
FZ2_Boss_SlamUp:
		move.l	#$FC00,x_vel(a0)
		move.w	$FFFFF704.w,d0
		sub.w	#$60,d0
		cmp.w	boss_y(a0),d0
		blt	FZ2_Boss_BossHover
		addq.b	#2,Routine2(a0)

		move.l	#$4000000,x_vel(a0)
		move.w	boss_x(a0),d0
		cmp.w	Object_RAM+x_pos.w,d0
		beq	FZ2_Boss_InitSmal_Do
		blt.s	.rts
		move.l	#-$4000000,x_vel(a0)

.rts		rts

FZ2_Boss_SlamGetPos:
		tst.w	x_vel(a0)
		bpl.s	.right

		move.w	boss_x(a0),d0
		cmp.w	Object_RAM+x_pos.w,d0
		bgt	FZ2_Boss_BossHover
		bra.s	FZ2_Boss_InitSmal_Do

.right		move.w	boss_x(a0),d0
		cmp.w	Object_RAM+x_pos.w,d0
		blt	FZ2_Boss_BossHover

FZ2_Boss_InitSmal_Do:
		sf	Routine2(a0)
		move.w	#0,x_vel(a0)
		sf	FZ2_Boss_Angle(a0)
		rts
; ===========================================================================
FZ2_Boss_DecideSide:
		jsr	RandomNumber
		andi.w	#%0011,d0
		moveq	#0,d1
		move.b	.index(pc,d0.w),d1
		jsr	.index(pc,d1.w)

		cmp.b	FZ2_Boss_Mode(a0),d0
		beq.s	FZ2_Boss_DecideSide
		move.b	d0,FZ2_Boss_Mode(a0)
		jmp	FZ2Boss_StopScroll

.index		dc.b .slam-.index, .rightedge-.index, .leftedge-.index, .slam-.index

.slam		move.b	#$14,Routine2(a0)
		moveq	#2,d0
		rts

.leftedge	moveq	#1,d1
		bra.s	.common

.rightedge	moveq	#0,d1
.common		move.b	FZ2_Boss_Mode(a0),d0
		move.b	.modes(pc,d0.w),d0
		bpl.s	.end
		move.w	d1,d0

.end		move.b	.routines(pc,d0.w),Routine2(a0)
		rts

.routines	dc.b $C, $A
.modes		dc.b 1, 0, -1, 0

; ===========================================================================
FZ2_Boss_InitSlam:
		cmpi.w	#FZ2_Boss_Pos_Left+$60,Boss_X(a0)
		bhi.s	.slam
		move.w	#FZ2_Boss_Pos_Left+$60,Boss_X(a0)

.slam		addq.b	#2,Routine2(a0)
		moveq	#10,d0
		sub.b	Coll2(a0),d0
		lsl.w	#8,d0
		move.w	d0,y_vel(a0)

FZ2_Boss_Slam:
		bsr.w	FZ2_Boss_LockScreen
		add.w	#$38,Y_Vel(a0)
		cmp.w	#FZ2_Boss_Pos_ScrDown+$70,Boss_Y(a0)
		blt.s	.k
		move.w	#FZ2_Boss_Pos_ScrDown+$70,Boss_Y(a0)
		addq.b	#2,Routine2(a0)
		move.b	#6,FZ2_Boss_Routine3(a0)
		move.b	#15,FZ2_Boss_Delay(a0)
		move.w	#0,y_vel(a0)
		move.b	FZ2_Boss_Angle(a0),FZ2_Boss_Angle(a0)
		move.w	#0,FZ2_Boss_AddYVel(a0)

		move.w	Boss_X(a0),d5
		moveq	#$40,d4
		btst	#0,Status(a0)
		bne.s	.noflip
		moveq	#-$40,d4

.noflip		add.w	d5,d4
		cmp.w	d4,d5
		bge.s	.noexg
		exg	d4,d5

.noexg		jsr	FZ2Boss_StartScroll

		tst.b	FZ2_Boss_FinalHit(a0)
		bpl.s	.chkangle
		move.b	#$1A,Routine2(a0)

.chkangle	tst.b	FZ2_Boss_Angle(a0)
		bpl.s	.k

		move.l	a0,-(sp)
		lea	Object_RAM.w,a0
		jsr	HurtSonic
		move.l	(sp)+,a0

.k		bset	#0,Status(a0)
		move.w	Boss_X(a0),d0
		sub.w	Object_RAM+x_pos.w,d0
		bmi	FZ2_Boss_BossHover
		bclr	#0,Status(a0)
		bra	FZ2_Boss_BossHover

; ===========================================================================
FZ2_Boss_MoveToRightSide:
		move.l	#$4000000,x_vel(a0)

		move.w	$FFFFF700.w,d0
		add.w	#320+$40,d0
		cmp.w	boss_x(a0),d0
		bgt	FZ2_Boss_BossHover

		move.b	#$E,Routine2(a0)
		move.b	#$12,FZ2_Boss_Routine3(a0)
		bclr	#0,Status(a0)
		move.w	#$100,FZ2_Boss_setX(a0)
		rts

FZ2_Boss_MoveToLeftSide:
		move.l	#-$4000000,x_vel(a0)

		move.w	$FFFFF700.w,d0
		sub.w	#$40,d0
		cmp.w	boss_x(a0),d0
		blt	FZ2_Boss_BossHover

		move.b	#$E,Routine2(a0)
		move.b	#$10,FZ2_Boss_Routine3(a0)
		bset	#0,Status(a0)
		move.w	#-$100,FZ2_Boss_setX(a0)
		rts

; ===========================================================================
FZ2_Boss_AttackRight:
		move.w	#$300,x_vel(a0)
		move.w	#$80,y_vel(a0)
		move.w	boss_x(a0),d0
		add.w	#$18,d0
		bsr	FZ_Boss_CatchSonic

		tst.b	FZ2_Boss_canCatch(a0)
		bmi.s	.chky
		move.w	$FFFFF700.w,d0
		add.w	#320+$40,d0
		cmp.w	boss_x(a0),d0
		bgt.s	.rts
		move.b	#6,Routine2(a0)
		sf	FZ2_Boss_Angle(a0)
.rts		rts

.chky		move.w	boss_x(a0),d0
		sub.w	#FZ2_Boss_Pos_Right,d0
		cmp.w	#-$60,d0
		ble.s	FZ2_Boss_Attack_ChkY
		move.w	#FZ2_Boss_Pos_Right-$60,boss_x(a0)
		bra.s	FZ2_Boss_Attack_ChkY

FZ2_Boss_AttackLeft:
		move.w	#-$300,x_vel(a0)
		move.w	#$80,y_vel(a0)
		move.w	boss_x(a0),d0
		add.w	#-$48,d0
		bsr.s	FZ_Boss_CatchSonic

		tst.b	FZ2_Boss_canCatch(a0)
		bmi.s	.chky
		move.w	$FFFFF700.w,d0
		sub.w	#$40,d0
		cmp.w	boss_x(a0),d0
		blt.s	.rts
		move.b	#6,Routine2(a0)
		sf	FZ2_Boss_Angle(a0)
.rts		rts

.chky		move.w	boss_x(a0),d0
		sub.w	#FZ2_Boss_Pos_Left,d0
		cmp.w	#$60,d0
		bge.s	FZ2_Boss_Attack_ChkY
		move.w	#FZ2_Boss_Pos_Left+$60,boss_x(a0)

FZ2_Boss_Attack_ChkY:
		move.w	boss_y(a0),d0
		sub.w	$FFFFF704.w,d0
		cmp.w	#-$40,d0
		bgt.s	.rts
		sf	Routine2(a0)
		move.b	#FZ2_Boss_AngleSlam|$80,FZ2_Boss_Angle(a0)	; set to slamming angle
		move.w	#0,x_vel(a0)
.rts		rts

FZ_Boss_CatchSonic:
		move.b	FZ2_Boss_Angle(a0),d0
		and.b	#$3C,d0
		cmp.b	#FZ2_Boss_AngleMax,d0
		bne.s	.noup
		move.w	#-$200,Y_Vel(a0)

.noup		tst.b	FZ2_Boss_canCatch(a0)
		bpl.s	.chkabove
		or.b	#$80,FZ2_Boss_Angle(a0)
		bra	.raise

.chkabove	btst	#6,FZ2_Boss_canCatch(a0)
		beq.s	FZ2_Boss_BossHover

.raise		move.b	FZ2_Boss_Angle(a0),d0
		and.b	#$3C,d0
		cmp.b	#FZ2_Boss_AngleMax,d0
		bge.s	FZ2_Boss_BossHover
		addq.b	#4,FZ2_Boss_Angle(a0)
		bra.s	FZ2_Boss_BossHover
; ===========================================================================
FZ2_Boss_MidScreen:
		move.w	FZ2_Boss_setX(a0),d0
		add.w	Object_RAM+x_pos.w,d0
		move.w	d0,Boss_X(a0)

		move.l	#$400,x_vel(a0)
		move.w	$FFFFF704.w,d0
		add.w	#(224/2)-$20,d0
		cmp.w	boss_y(a0),d0
		bgt	FZ2_Boss_BossHover
		move.b	FZ2_Boss_Routine3(a0),Routine2(a0)
		sf	FZ2_Boss_canCatch(a0)
		rts

FZ2_Boss_DelayFrames:
		subq.b	#1,FZ2_Boss_Delay(a0)
		bne.s	.angle
		move.b	FZ2_Boss_Routine3(a0),Routine2(a0)

.angle		moveq	#1,d0
		move.b	FZ2_Boss_Angle(a0),d1
		cmp.b	FZ2_Boss_TgtAngle(a0),d1
		beq.s	FZ2_Boss_BossHover
		blt.s	.add
		moveq	#-1,d0

.add		add.b	d0,FZ2_Boss_Angle(a0)
		move.w	FZ2_Boss_AddYVel(a0),d0
		add.w	d0,Y_Vel(a0)

; ===========================================================================
FZ2_Boss_BossHover:
		bsr.w	BossMove		; run movement routines
		move.b	Off3F(a0),d1		; get offset
		jsr	CalcSine		; get sine
		asr.w	#6,d0			; shifht right 6 bits
		add.w	Boss_Y(a0),d0		; add Boss Y-position
		move.w	d0,Y_Pos(a0)		; set to actual Y-position
		move.w	Boss_X(a0),X_pos(a0)	; copy Y-position to actual Y-position
		addq.b	#2,Off3F(a0)		; increment offset

		tst.b	FZ2_Boss_FinalHit(a0)
		bmi.s	FZ2_Boss_NoFlash
		tst.b	Status(a0)		;
		bmi.s	FZ2_Boss_SetDefeat	; if no hits left, set defeated

		tst.b	Coll(a0)		; if colliding, dont flash
		bne.s	FZ2_Boss_NoFlash	; else do
		tst.b	Off3E(a0)		; has timer ran out?
		bne.s	FZ2_Boss_ShipFlash	; if hasnt, start flashing

		move.b	#$60,Off3E(a0)		; set number of	times for ship to flash
		move.w	#$AC,d0			;
		jsr	PlaySound		; play boss damage sound

FZ2_Boss_ShipFlash:
		lea	$FFFFFB20+(14*2).w,a1	; load 2nd line, 2nd entry
		moveq	#0,d0			; move 0 (black) to d0
		tst.w	(a1)			; does the line currently have this entry?
		bne.s	.set			; if not, branch
		move.w	#$EEE,d0		; move 0EEE (white) to d0

.set		move.w	d0,(a1)			; load colour stored in	d0
		subq.b	#1,Off3E(a0)		; decrement timer
		bne.s	FZ2_Boss_NoFlash	; if still not 0, branch
		move.b	#$F,Coll(a0)		; reset collision and stop flashing

FZ2_Boss_NoFlash:
		rts

; ===========================================================================
FZ2_Boss_SetDefeat:				; XREF: FZ2_Boss_BossHover
		moveq	#100,d0			; 100 points
		bsr.w	AddPoints		; add points
		move.b	#$18,Routine2(a0)	; set to defeated subroutine
		move.w	#$B3,Off3C(a0)		; explosion timer
		st	FZ2_Boss_FinalHit(a0)
		sf	$FFFFFE1E.w
		rts

; ===========================================================================
FZ2_Boss_Explode:				; XREF: FZ2_Boss_ShipIndex
		subq.w	#1,Off3C(a0)		; decrement timer
		bpl.s	.rts			; if negative, branch

.defeated	bclr	#7,Status(a0)		; set defeated
		clr.w	X_Vel(a0)		; clear speed
		move.b	#4,Routine2(a0)
		move.b	#$14,FZ2_Boss_Routine3(a0)
		move.b	#30,FZ2_Boss_Delay(a0)
		move.w	#0,FZ2_Boss_AddYVel(a0)
		tst.b	$FFFFF7A7.w		;
		bne.s	.rts			;
		move.b	#1,$FFFFF7A7.w		; something to do with animals

.rts		rts

; ===========================================================================
FZ2_Boss_Escape:				; XREF: FZ2_Boss_ShipIndex
		move.b	#$16,$FFFFF742.w
		add.w	#$20,$FFFFF726.w
		move.w	#0,FZ2_Boss_VScroll.w
		move.b	#4,Routine2(a0)
		move.b	#$1C,FZ2_Boss_Routine3(a0)
		move.b	#60*3,FZ2_Boss_Delay(a0)
		rts

FZ2_Boss_ShipDel:
		jsr	SingleObjLoad2		; load next object
		bne.s	.del			; if all slots are full, end

		move.b	(a0),(a1)
		move.l	#FZ2_Boss_Maps2,Mappings_Offset(a1)
		move.w	#$75C0/$20,Art_Tile(a1)
		move.b	#$12,Routine(a1)
		move.w	X_pos(a0),X_pos(a1)	;
		move.w	Y_Pos(a0),Y_Pos(a1)	; copy positions
		add.w	#-$E,X_pos(a1)
		add.w	#$14,Y_pos(a1)
		move.b	#5,Anim_Frame(a1)
		move.w	#60*2,Off2A(a1)
		move.b	#5,Render_Flags(a1)
		move.b	#5,Priority(a1)

.del		jmp	DeleteObject		; delete boss

; ===========================================================================
FZ2_Boss_EscapePod:
		addq.b	#2,Routine(a0)
		jsr	SingleObjLoad2		; load next object
		bne.s	FZ2_Boss_EscapePod2	; if all slots are full, end
		move.l	a0,Off3C(a1)		; save boss address

		move.b	(a0),(a1)
		move.l	#FZ2_Boss_Maps2,Mappings_Offset(a1)
		move.w	#$75C0/$20,Art_Tile(a1)
		move.b	#4,Routine(a1)
		move.w	#0,Off38(a1)
		move.w	#-$1C,Off3A(a1)
		move.b	#3,Anim_Frame(a1)
		move.b	Priority(a0),Priority(a1)

FZ2_Boss_EscapePod2:
		bsr.w	BossDefeated
		subq.w	#1,Off2A(a0)
		bpl.s	.disp
		add.w	#2,x_pos(a0)

		move.w	$FFFFF700.w,d0
		add.w	#320+$20,d0
		cmp.w	x_pos(a0),d0
		bgt.s	.disp

		addq.b	#2,$FFFFF742.w
		moveq	#$FFFFFFE0,d0		; music $06
		jsr	PlayMusic		; play eet
		jmp	DeleteObject

.disp		move.w	$FFFFF700.w,d0
		move.w	d0,$FFFFF728.w
		move.w	d0,$FFFFF72A.w
		jmp	DisplaySprite

; ===========================================================================
FZ2_Boss_ObjData2:
	dc.b $E, 1, 0, 0, 0, 0
	dc.b $C, 0, 0, 7, -$2A, 0
	dc.b $C, 4, 2, $B, -$44, 0
; ===========================================================================

FZ2_Boss_ArmBall:
		lea	FZ2_Boss_ObjData2(pc),a2; get data array
		moveq	#3-1,d1			; get length
		jsr	SingleObjLoad2		; load next object
		bne.w	.skip			; if all slots are full, end
		movea.l	a1,a3			; copy to a2

		move.l	a0,Off3C(a1)		; save boss address
		move.l	#.offsets,Off34(a0)
		move.l	#.offsets2,Off34(a1)
		move.b	#2,Anim_Frame(a1)
		move.b	#$27|$80,Coll2(a1)
		move.b	#$17|$80,Coll2(a0)
		bra.w	.continue

.offsets	dc.w  $C,$E,    $B,$E,    9,$F,     7,$F,    5,$10,    4,$10,    2,$11,    0,$12,   -2,$11,  -3,$11,  -5,$10, -7,$10,  -9,$F, -$A,$F, -$C,$E
.offsets2	dc.w -$D,$17, -$E,$16, -$F,$15, -$10,$15, -$12,$14, -$13,$13, -$14,$12, -$14,$11, -$15,$10, -$15,$F, -$16,$C, -$18,9, -$1A,6, -$1B,3, -$1C,0

.loop		jsr	SingleObjLoad2		; load next object
		bne.s	.skip			; if all slots are full, end
		move.l	a3,Off3C(a1)		; save boss address

.continue	move.b	#FZ2_Boss_ID,(a1)	; use current object
		move.l	Mappings_Offset(a0),Mappings_Offset(a1); get mappings
		move.w	Art_Tile(a0),Art_Tile(a1);
		move.b	#4,Render_Flags(a1)	;
		move.b	#$22,X_Visible(a1)	;
		move.b	(a2)+,Routine(a1)	; get routine counter
		move.b	(a2)+,Priority(a1)	; get priority
		move.b	(a2)+,Anim(a1)		; get animation
		move.b	(a2)+,Respawn(a1)	; get mappings frame

		move.b	(a2)+,d0
		ext.w	d0
		move.w	d0,Off38(a1)
		move.b	(a2)+,d0
		ext.w	d0
		move.w	d0,Off3A(a1)
		dbf	d1,.loop		; repeat sequence3 more times

.skip		move.b	#$E,Routine(a0)

FZ2_Boss_ArmMain:
		bsr	FZ2_Boss_Follow
		movea.l	Off3C(a0),a1
		sf	Coll(a0)
		tst.b	Coll(a1)
		beq.s	.null
		move.b	Coll2(a0),Coll(a0)

.null		move.b	FZ2_Boss_Angle(a1),d1
		move.b	d1,FZ2_Boss_Angle(a0)
		and.w	#$3C,d1

		movea.l	Off34(a0),a2
		move.w	2(a2,d1.w),d0
		add.w	d0,Y_Pos(a0)

		move.w	(a2,d1.w),d0
		btst	#0,Render_Flags(a0)
		beq.s	.no
		neg.w	d0

.no		add.w	d0,X_Pos(a0)
		cmp.b	#$27|$80,Coll2(a0)
		bne.s	.dis
		btst	#7,FZ2_Boss_Angle(a0)
		beq.s	.chksanic

		move.w	x_pos(a0),Object_RAM+x_pos.w
		move.w	y_pos(a0),Object_RAM+y_pos.w
		move.b	#2,Object_RAM+Anim.w
		add.w	#$3E,Object_RAM+x_pos.w
		btst	#0,Render_Flags(a0)
		bne.s	.dis
		sub.w	#$3E*2,Object_RAM+x_pos.w

.dis		rts				; display sprite

.chksanic	movea.l	Off3C(a1),a2
		move.w	y_pos(a0),d0
		sub.w	Object_RAM+y_pos.w,d0
		sub.w	#$10,d0
		cmp.w	#$50,d0
		bhi	.chksanic2

		move.w	x_pos(a0),d0
		sub.w	Object_RAM+x_pos.w,d0
		move.w	#$80,d1
		btst	#0,Render_Flags(a0)
		bne.s	.noneg
		moveq	#-$50,d1

.noneg		add.w	d1,d0
		cmp.w	#$30,d0
		bhi.s	.chksanic2
		bset	#6,FZ2_Boss_canCatch(a2)

.chksanic2	move.w	y_pos(a0),d0
		sub.w	Object_RAM+y_pos.w,d0
		add.w	#$10,d0
		cmp.w	#$20,d0
		bhi	.dis2

		move.w	x_pos(a0),d0
		sub.w	Object_RAM+x_pos.w,d0
		moveq	#$54,d1
		btst	#0,Render_Flags(a0)
		bne.s	.noneg2
		moveq	#-$34,d1

.noneg2		add.w	d1,d0
		cmp.w	#$20,d0
		slo	FZ2_Boss_canCatch(a2)
.dis2		rts
; ===========================================================================
FZ2_Boss_Arm:
		bclr	#0,Anim(a0)
		movea.l	Off3C(a0),a1
		btst	#7,FZ2_Boss_Angle(a1)
		beq.s	.ani

		move.b	Respawn(a0),d0
		cmp.b	Anim_Frame(a0),d0
		bne.s	.ani
		bset	#0,Anim(a0)

.ani		lea	FZ2_Boss_Ani(pc),a1
		bra.s	FZ2_Boss_Animate

FZ2_Boss_Face:
		movea.l	Off3C(a0),a1
		bclr	#0,Anim(a0)
		tst.b	Coll(a1)
		bne.s	.ani
		bset	#0,Anim(a0)

.ani		lea	FZ2_Boss_Ani2(pc),a1

FZ2_Boss_Animate:
		jsr	AnimateSprite

FZ2_Boss_Follow:
		movea.l	Off3C(a0),a1
		move.b	Render_Flags(a1),Render_Flags(a0)
		move.w	X_pos(a1),X_pos(a0)	;
		move.w	Y_Pos(a1),Y_Pos(a0)	; copy positions
		move.w	Off3A(a0),d0
		add.w	d0,Y_Pos(a0)

		move.w	Off38(a0),d0
		btst	#0,Render_Flags(a0)
		beq.s	.no
		neg.w	d0

.no		add.w	d0,X_Pos(a0)

		move.b	FZ2_Boss_FinalHit(a1),FZ2_Boss_FinalHit(a0)
		bpl.s	.dis
		bchg	#7,Off2A(a0)
		beq.s	.dis
		rts

.dis		cmp.b	#FZ2_Boss_ID,(a1)
		bne.s	.del
		jmp	DisplaySprite

.del		jmp	DeleteObject

FZ2_Boss_Fire:
		bchg	#7,Status(a0)
		beq.s	FZ2_Boss_Follow
		rts
; ===========================================================================
FZ2_Boss_Maps:	include "boss/LBZmaps.asm"
		even

FZ2_Boss_Maps2:	include "boss/LBZface.asm"
		even

FZ2_Boss_Ani2:	dc.w FZ2_Boss_Ani2_0-FZ2_Boss_Ani2, FZ2_Boss_Ani2_1-FZ2_Boss_Ani2, FZ2_Boss_Ani2_2-FZ2_Boss_Ani2, FZ2_Boss_Ani2_3-FZ2_Boss_Ani2
FZ2_Boss_Ani:	dc.w .0-FZ2_Boss_Ani, .1-FZ2_Boss_Ani, .2-FZ2_Boss_Ani, .3-FZ2_Boss_Ani

.0	dc.b 10, 4, 5, 6, 7, $FF
.1	dc.b $3F, 7, $FF
.2	dc.b 10, 8, 9, $A, $B, $FF
.3	dc.b $3F, $B, $FF

FZ2_Boss_Ani2_0:	dc.b 2, 0, 1, $FF
FZ2_Boss_Ani2_1:	dc.b $3F, 2, $FF
FZ2_Boss_Ani2_2:	dc.b $3F, 3, $FF
FZ2_Boss_Ani2_3:	dc.b $3F, 7, $FF
		even
; ===========================================================================

FZ2_Boss_Map_FallingTiles:
		dc.w .1-FZ2_Boss_Map_FallingTiles
		dcb.w 3, .0-FZ2_Boss_Map_FallingTiles

.1		dc.b 4
		dc.b 0, 0, 0, 9, 0
		dc.b 0, 0, 0, 9, 8
		dc.b 8, 0, 0, $B, 0
		dc.b 8, 0, 0, $B, 8

.0		dc.b 4
		dc.b 0, 0, 0, $14, 0
		dc.b 8, 0, 0, $14, 0
		dc.b 0, 0, 0, $14, 8
		dc.b 8, 0, 0, $14, 8
		even
; ===========================================================================
FZ_Boss_FallingTiles:
		jsr	ObjectFall

		move.w	$FFFFF704.w,d0
		add.w	#244+$10,d0
		cmp.w	Y_pos(a0),d0
		blt.s	.del

		jmp	DisplaySprite
.del		jmp	DeleteObject
