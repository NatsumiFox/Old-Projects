GHZ2_Boss_ID:		equ $29
GHZ2_Boss_Pos_Left:	equ $1F00
GHZ2_Boss_Pos_Right:	equ $20FF
GHZ2_Boss_Pos_Up:	equ $300
GHZ2_Boss_Pos_Down:	equ $3AC
GHZ2_Boss_SP_X:		equ GHZ2_Boss_Pos_Left+((GHZ2_Boss_Pos_Right-GHZ2_Boss_Pos_Left)/2)
GHZ2_Boss_SP_Y:		equ GHZ2_Boss_Pos_Up-$50
GHZ2_Boss_SP_SCR_X:	equ $1F60
GHZ2_Boss_Finish_X:	equ $210C

GHZ2_Boss_MainY:	equ GHZ2_Boss_Pos_Up+$20
GHZ2_Boss_LowY:		equ GHZ2_Boss_Pos_Down-$50
; ---------------------------------------------------------------------------
; Object - Boss (GHZ2)
; ---------------------------------------------------------------------------
GHZ2_Boss:					; XREF: Obj_Index
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	GHZ2_Boss_Index(pc,d0.w),d1
		jmp	GHZ2_Boss_Index(pc,d1.w)
; ===========================================================================
GHZ2_Boss_Index:dc.w GHZ2_Boss_Main-GHZ2_Boss_Index
		dc.w GHZ2_Boss_ShipMain-GHZ2_Boss_Index
		dc.w GHZ2_Boss_FaceMain-GHZ2_Boss_Index
		dc.w GHZ2_Boss_FlameMain-GHZ2_Boss_Index

			; routine counter, animation
GHZ2_Boss_ObjData:	dc.b 2,	0	; the main ship
			dc.b 4,	1	; Eggman face
			dc.b 6,	7	; flame from the ship
; ===========================================================================

GHZ2_Boss_Main:				; XREF: GHZ2_Boss_Index
		lea	GHZ2_Boss_ObjData,a2	; get data array
		movea.l	a0,a1			; copy this object to a1
		moveq	#2,d1			; get length
		bra.s	GHZ2_Boss_LoadBoss	; start with current object
; ===========================================================================

GHZ2_Boss_Loop:
		jsr	SingleObjLoad2		; load next object
		bne.s	GHZ2_Boss_SkipLoad	; if all slots are full, end

GHZ2_Boss_LoadBoss:				; XREF: GHZ2_Boss_Main
		move.b	(a2)+,Routine(a1)	; get routine counter
		move.b	#GHZ2_Boss_ID,(a1)	; use current object
		move.w	X_pos(a0),X_pos(a1)	;
		move.w	Y_Pos(a0),Y_Pos(a1)	; copy positions
		move.l	#Map_Eggman,Mappings_Offset(a1); get mappings
		move.w	#$400,Art_Tile(a1)	;
		move.b	#4,Render_Flags(a1)	;
		move.b	#$22,X_Visible(a1)	;
		move.b	#3,Priority(a1)		;
		move.b	(a2)+,Anim(a1)		; get animation
		move.l	a0,Off34(a1)		; save boss address
		dbf	d1,GHZ2_Boss_Loop	; repeat sequence 2 more times

GHZ2_Boss_SkipLoad:
		move.w	X_pos(a0),Boss_X(a0)	;
		move.w	Y_Pos(a0),Boss_Y(a0)	; copy positions to other memory
		move.b	#$F,Coll(a0)		; set to boss
		move.b	#8,Coll2(a0)		; set number of	hits to	8

GHZ2_Boss_ShipMain:				; XREF: GHZ2_Boss_Index
		moveq	#0,d0
		move.b	Routine2(a0),d0			; get secondary routine counter
		move.w	GHZ2_Boss_ShipIndex(pc,d0.w),d1
		jsr	GHZ2_Boss_ShipIndex(pc,d1.w)	; jump to the correct routine

		lea	Ani_Eggman,a1
		jsr	AnimateSprite			; animate object
		move.b	Status(a0),d0
		andi.b	#3,d0				; only maintain X and Y flip bits
		andi.b	#$FC,Render_Flags(a0)		; clear X and Y flip bits
		or.b	d0,Render_Flags(a0)		; if X and Y flip bits were set, copy to Render flags
		jmp	DisplaySprite			; display sprite
; ===========================================================================
GHZ2_Boss_ShipIndex:dc.w GHZ2_Boss_ShipStart-GHZ2_Boss_ShipIndex
		dc.w GHZ2_Boss_MakeBall-GHZ2_Boss_ShipIndex
		dc.w GHZ2_Boss_FindBall-GHZ2_Boss_ShipIndex
		dc.w GHZ2_Boss_FindSonic-GHZ2_Boss_ShipIndex
		dc.w GHZ2_Boss_FlyUp-GHZ2_Boss_ShipIndex
;		dc.w GHZ2_Boss_ChkFlip-GHZ2_Boss_ShipIndex
		dc.w GHZ2_Boss_Explode-GHZ2_Boss_ShipIndex
		dc.w GHZ2_Boss_BeforeEscape-GHZ2_Boss_ShipIndex
		dc.w GHZ2_Boss_Escape-GHZ2_Boss_ShipIndex
; ===========================================================================

GHZ2_Boss_ShipStart:			; XREF: GHZ2_Boss_ShipIndex
		move.w	#$100,Y_Vel(a0)		; move ship down
		bsr.w	BossMove		; run movement routines
		cmpi.w	#GHZ2_Boss_MainY,Boss_Y(a0); if Y position is low enough
		bne.s	GHZ2_Boss_BossHover	; if not, skip
		move.w	#0,Y_Vel(a0)		; stop ship
		addq.b	#2,Routine2(a0)		; goto next routine
		move.w	#-1,Off3C(a0)

GHZ2_Boss_BossHover:
		move.b	Off3F(a0),d1		; get offset
		jsr	CalcSine		; get sine
		asr.w	#6,d0			; shifht right 6 bits
		add.w	Boss_Y(a0),d0		; add Boss Y-position
		move.w	d0,Y_Pos(a0)		; set to actual Y-position
		move.w	Boss_X(a0),X_pos(a0)	; copy Y-position to actual Y-position
		addq.b	#2,Off3F(a0)		; increment offset
		cmpi.b	#8,Routine2(a0)		; is secondary routine counter 8?
		bhs.s	GHZ2_Boss_NoFlash	; if higher or same, skip flashing

		tst.b	Status(a0)		;
		bmi.s	GHZ2_Boss_SetDefeat	; if no hits left, set defeated
		tst.b	Coll(a0)		; if colliding, dont flash
		bne.s	GHZ2_Boss_NoFlash	; else do
		tst.b	Off3E(a0)		; has timer ran out?
		bne.s	GHZ2_Boss_ShipFlash	; if hasnt, start flashing

		move.b	#$20,Off3E(a0)		; set number of	times for ship to flash
		move.w	#$AC,d0			;
		jsr	PlaySound		; play boss damage sound

GHZ2_Boss_ShipFlash:
		lea	$FFFFFB22,a1 		; load 2nd line, 2nd entry
		moveq	#0,d0			; move 0 (black) to d0
		tst.w	(a1)			; does the line currently have this entry?
		bne.s	.set			; if not, branch
		move.w	#$EEE,d0		; move 0EEE (white) to d0

.set		move.w	d0,(a1)			; load colour stored in	d0
		subq.b	#1,Off3E(a0)		; decrement timer
		bne.s	GHZ2_Boss_NoFlash	; if still not 0, branch
		move.b	#$F,Coll(a0)		; reset collision and stop flashing

GHZ2_Boss_NoFlash:
		rts
; ===========================================================================

GHZ2_Boss_SetDefeat:				; XREF: GHZ2_Boss_BossHover
		moveq	#100,d0		; 100 points
		bsr.w	AddPoints	; add points
		move.b	#$A,Routine2(a0); set to defeated subroutine
		move.w	#$B3,Off3C(a0)	; explosion timer
		rts

; ===========================================================================
; I dont even
GHZ2_Boss_MakeBall:				; XREF: GHZ2_Boss_ShipIndex
		subq.w	#1,Off3C(a0)
		beq.s	.next
		bpl.s	.wait
		jsr	SingleObjLoad2
		bne.s	.skipLoad
		move.b	#$19,(a1)	; load swinging	ball object
		move.w	Boss_X(a0),X_pos(a1)
		move.w	Boss_Y(a0),Y_Pos(a1)
		move.l	a0,Off34(a1)

.skipLoad	move.w	#$45,Off3C(a0)
		bra.s	.wait

.next		addq.b	#4,Routine2(a0)
.wait		bsr.w	GHZ2_Boss_BossHover
		bra.w	BossMove
; ===========================================================================
GHZ2_Boss_FlyUp:
		subq.w	#2,Boss_Y(a0)
		move.w	#0,Y_Vel(a0)
		move.w	#0,X_Vel(a0)
		subq.w	#1,Off3C(a0)		; decrement timer
		bpl.s	.keepSPD		; if negative, branch
		addq.w	#2,Boss_Y(a0)

		cmpi.w	#-6,Off3C(a0)
		bge.s	.keepSPD
		move.w	#$40,Y_Vel(a0)

		cmpi.w	#GHZ2_Boss_MainY,Boss_Y(a0)
		blt.s	.keepSPD
		move.w	#0,Y_Vel(a0)
		subq.b	#4,Routine2(a0)


.keepSPD	bsr.w	GHZ2_Boss_BossHover
		bra.w	BossMove

GHZ2_Boss_FindSonic:
		subq.w	#1,Off32(a0)
		bpl	GHZ2_Boss_FindSonic_draw

		bsr	GHZ2_Boss_NewTime

		move.w	#0,X_Vel(a0)
		bset	#0,Status(a0)
		move.w	#$100,d0

		move.w	Object_RAM+X_Pos.w,d1
		sub.w	Boss_X(a0),d1
		bpl.s	.pos

		neg.w	d0
		neg.w	d1
		bclr	#0,Status(a0)

.pos		cmp.w	#$70,d1
		ble.s	.o
		move.w	d0,X_vel(a0)
		bra.s	GHZ2_Boss_FindSonic_draw

.o		cmp.w	#$30,d1
		bge.s	.stop
		move.w	d0,X_vel(a0)

		jsr	RandomNumber
		bmi.s	GHZ2_Boss_FindSonic_draw

		neg.w	X_vel(a0)
		bchg	#0,Status(a0)
		bra.s	GHZ2_Boss_FindSonic_draw

.stop		move.w	#0,X_vel(a0)

GHZ2_Boss_FindSonic_draw:
		cmpi.w	#GHZ2_Boss_Pos_Left+$16,Boss_X(a0)
		bhs.s	.ChkRight
		move.w	#GHZ2_Boss_Pos_Left+$16,Boss_X(a0)
		move.w	#$100,X_vel(a0)
		bsr.s	GHZ2_Boss_NewTime
		bset	#0,Status(a0)

.ChkRight	cmpi.w	#GHZ2_Boss_Pos_Right-$16,Boss_X(a0)
		bls.s	.Display
		move.w	#GHZ2_Boss_Pos_Right-$16,Boss_X(a0)
		move.w	#-$100,X_vel(a0)
		bsr.s	GHZ2_Boss_NewTime
		bclr	#0,Status(a0)

.ChkSonic	move.w	Object_RAM+X_Pos.w,d1
		sub.w	Boss_X(a0),d1
		bpl.s	.pos
		neg.w	d1

.pos		cmp.w	#$70,d1
		bge.s	.Display
		cmp.w	#$30,d1
		ble.s	.Display
		move.w	#0,X_vel(a0)
		move.w	#0,Off32(a0)

.Display	bsr.w	GHZ2_Boss_BossHover
		bra.w	BossMove

GHZ2_Boss_NewTime:
		jsr	RandomNumber
		lsr.l	#8,d1
		move.w	d1,Off32(a0)
		andi.w	#$1E,Off32(a0)
		addi.w	#$40,Off32(a0)
		rts

GHZ2_Boss_FindBall:
		move.w	#0,X_Vel(a0)
		move.w	#0,Y_Vel(a0)
		bset	#0,Status(a0)
		move.w	#$300,d0

		move.w	Off32(a0),d1
		beq.s	GHZ2_Boss_FindBall_MoveUp
		sub.w	Boss_X(a0),d1
		andi.w	#$FFFC,d1
		beq.s	GHZ2_Boss_FindBall_MoveDown
		bpl.s	.pos

		neg.w	d0
		bclr	#0,Status(a0)

.pos		move.w	d0,X_Vel(a0)

GHZ2_Boss_FindBall_Common:
		bsr.w	GHZ2_Boss_BossHover
		bra.w	BossMove

GHZ2_Boss_FindBall_MoveDown:
		cmpi.w	#GHZ2_Boss_LowY,Boss_Y(a0)
		bge.s	.rmv
		move.w	#$200,Y_vel(a0)
		bra.s	GHZ2_Boss_FindBall_Common

.rmv		move.w	#0,Off32(a0)
		bra.s	GHZ2_Boss_FindBall_Common

GHZ2_Boss_FindBall_MoveUp:
		cmpi.w	#GHZ2_Boss_MainY,Boss_Y(a0)
		bgt.s	.norm
		addq.b	#2,Routine2(a0)
		bra.s	GHZ2_Boss_FindBall_Common

.norm		move.w	#-$100,Y_vel(a0)
		bra.s	GHZ2_Boss_FindBall_Common

; ===========================================================================
GHZ2_Boss_Explode:				; XREF: GHZ2_Boss_ShipIndex
		subq.w	#1,Off3C(a0)		; decrement timer
		bmi.s	.defeated		; if negative, branch
		bra.w	BossDefeated		; generate explosions

.defeated	bset	#0,Status(a0)		; face right
		bclr	#7,Status(a0)		; set defeated
		clr.w	X_Vel(a0)		; clear speed
		addq.b	#2,Routine2(a0)		; next routine
		move.w	#-$26,Off3C(a0)		; set timer(?)
		tst.b	$FFFFF7A7.w		;
		bne.s	.rts			;
		move.b	#1,$FFFFF7A7.w		; something to do with animals

.rts		rts
; ===========================================================================

GHZ2_Boss_BeforeEscape:				; XREF: GHZ2_Boss_ShipIndex
		addq.w	#1,Off3C(a0)		; increment timer
		beq.s	GHZ2_Boss_BE_StartGoUp	; if 0, start climbing upwards
		bpl.s	GHZ2_Boss_BE_GoUp	; if greater than 0, go upwards
		addi.w	#$18,Y_Vel(a0)		; apply gravity
		bra.s	GHZ2_Boss_BE_Move	; do main movement routines
; ===========================================================================

GHZ2_Boss_BE_StartGoUp:
		clr.w	Y_Vel(a0)		; clear Y-velocity
		bra.s	GHZ2_Boss_BE_Move	; do main movement routines
; ===========================================================================

GHZ2_Boss_BE_GoUp:
		cmpi.w	#$30,Off3C(a0)		; is timer $30?
		blo.s	.moveUp			; if less, move up
		beq.s	GHZ2_Boss_BE_PlayMusic	; is same, clear Y-velocity and play zone music
		cmpi.w	#$38,Off3C(a0)		; is timer $38?
		blo.s	GHZ2_Boss_BE_Move	; if less, branch
		addq.b	#2,Routine2(a0)		; increment routine
		bra.s	GHZ2_Boss_BE_Move	; do main movement routines
; ===========================================================================

.moveUp		subq.w	#8,Y_Vel(a0)		; move upwards

GHZ2_Boss_BE_Move:
		bsr.w	BossMove		; move the boss
		bra.w	GHZ2_Boss_BossHover	; hover
; ===========================================================================

GHZ2_Boss_BE_PlayMusic:
		pea	GHZ2_Boss_BE_Move(pc)	; go to movement routine after
		clr.w	Y_Vel(a0)		; clear Y-velocity
		moveq	#$FFFFFFE0,d0
		jmp	PlayMusic		; fade music out

; ===========================================================================

GHZ2_Boss_Escape:				; XREF: GHZ2_Boss_ShipIndex
		move.w	#$400,X_Vel(a0)		; set escape speed
		move.w	#-$40,Y_Vel(a0)		; go upwards

		move.b	#8,$FFFFF742.w
		cmpi.w	#GHZ2_Boss_Finish_X,$FFFFF72A.w	; if finished scrolling..
		bge.s	.finish			; ...branch
		addq.w	#2,$FFFFF72A.w		; move level minimum horizontal position
		bra.s	GHZ2_Boss_BE_Move	; do main movement routines
; ===========================================================================

.finish		tst.b	Render_Flags(a0)	; is on-screen?
		bpl.s	GHZ2_Boss_ShipDel	; if isnt, branch
		bra	GHZ2_Boss_BE_Move	; do main movment routines
; ===========================================================================

GHZ2_Boss_ShipDel:
		jmp	DeleteObject		; delete boss

GHZ2_Boss_Ball_MaxSPD:	equ $620
GHZ2_Boss_Ball: 
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	.i(pc,d0.w),d1
		jmp	.i(pc,d1.w)
; ===========================================================================
.i		dc.w GHZ2_Boss_Ball_Main-.i
		dc.w Obj48_Base-.i
		dc.w GHZ2_Boss_Ball_Move-.i
		dc.w GHZ2_Boss_Ball_SlowDown-.i
		dc.w GHZ2_Boss_Ball_Pick-.i
		dc.w loc_17C68-.i
		dc.w Obj48_ChkVanish-.i
		dc.w GHZ2_Boss_Ball_Fly-.i

GHZ2_Boss_Ball_Main:				; XREF: GHZ2_Boss_Ball_Index
		addq.b	#2,Routine(a0)
		move.w	#$4080,Angle(a0)
		move.w	#0,Off3E(a0)
		move.l	#Map_BossItems,Mappings_Offset(a0)
		move.w	#$46C,Art_Tile(a0)
		lea	Subtype(a0),a2
		move.b	#0,(a2)+
		moveq	#3,d1
		movea.l	a0,a1
		bra.s	GHZ2_Boss_Ball_MakeFirst
; ===========================================================================

GHZ2_Boss_Ball_MakeLinks:
		jsr	SingleObjLoad2
		bne.s	GHZ2_Boss_Ball_MakeBall
		move.w	X_pos(a0),X_pos(a1)
		move.w	Y_Pos(a0),Y_Pos(a1)
		move.b	(a0),(a1)	; load chain link object
		move.b	#$A,Routine(a1)
		move.l	#Map_obj15,Mappings_Offset(a1)
		move.w	#$380,Art_Tile(a1)
		move.b	#1,Anim_Frame(a1)
		addq.b	#1,Subtype(a0)

GHZ2_Boss_Ball_MakeFirst:				; XREF: GHZ2_Boss_Ball_Main
		move.w	a1,d5
		subi.w	#$D000,d5
		lsr.w	#6,d5
		andi.w	#$7F,d5
		move.b	d5,(a2)+
		move.b	#4,Render_Flags(a1)
		move.b	#8,X_Visible(a1)
		move.b	#6,Priority(a1)
		move.l	Off34(a0),Off34(a1)
		dbf	d1,GHZ2_Boss_Ball_MakeLinks ; repeat sequence 5 more times

GHZ2_Boss_Ball_MakeBall:
		move.b	#$C,Routine(a1)
		move.l	#Map_obj48,Mappings_Offset(a1)	; load different mappings for final link
		move.w	#$43AA,Art_Tile(a1)		; use different	graphics
		move.b	#1,Anim_Frame(a1)
		move.b	#5,Priority(a1)
		move.b	#$81,Coll(a1)			; make object hurt Sonic
		move.b	#$16,Y_Radius(a1)
		move.b	#$18,X_Visible(a1)
		rts

GHZ2_Boss_Ball_Move:
		pea	DisplaySprite		; display the sprite lastly
		bsr.w	sub_17C2A

; GHZ2_Boss_Ball_ThrowBall
		move.w	Off3E(a0),d0
		bpl.s	.cont
		neg.w	d0

.cont		cmp.w	#GHZ2_Boss_Ball_MaxSPD-$100,d0
		blt.s	GHZ2_Boss_Ball_Swing

		move.w	Object_RAM+X_Pos.w,d0
		sub.w	Boss_X(a1),d0
		bpl.s	.pos
		neg.w	d0

.pos		cmp.w	#$80,d0
		bgt.s	GHZ2_Boss_Ball_Swing
		cmp.w	#$30,d0
		blt.s	GHZ2_Boss_Ball_Swing

		moveq	#0,d1
		move.b	Angle(a0),d1
		cmpi.w	#$40-8,d1
		bls.s	GHZ2_Boss_Ball_Swing
		cmpi.w	#$40+8,d1
		bhs.s	GHZ2_Boss_Ball_Swing
		add.w	#$40,d1

		addq.b	#2,Routine2(a1)
		move.w	#6,Off3C(a1)
		moveq	#0,d4
		move.b	Off2C(a0),d4
		lsl.w	#6,d4
		addi.l	#$FFD000,d4
		movea.l	d4,a1
		addq.b	#2,Routine(a1)
		move.b	#0,Routine2(a1)
		addq.b	#2,Routine(a0)

; can throw the ball
		jsr	CalcSine
		move.w	Off3E(a0),d2
		asr.w	#1,d2
		muls.w	d2,d1
		asr.l	#8,d1
		move.w	d1,X_Vel(a1)	; bounce Sonic away
		muls.w	d2,d0
		asr.l	#8,d0
		move.w	d0,Y_Vel(a1)	; bounce Sonic away
		asr	Off3E(a0)
		asr	Off3E(a0)
		rts

GHZ2_Boss_Ball_Swing:
		btst	#0,Status(a0)
		bne.s	.SwingBack

		move.w	Off3E(a0),d0
		add.w	#$C,d0
		bpl.s	.1
		addq.w	#8,d0

.1		move.w	d0,Off3E(a0)
		add.w	d0,Angle(a0)

		cmpi.w	#GHZ2_Boss_Ball_MaxSPD,d0
		blt.s	GHZ2_Boss_Ball_SwingDo
		move.w	#GHZ2_Boss_Ball_MaxSPD,Off3E(a0)
		bra.s	GHZ2_Boss_Ball_SwingDo
; ===========================================================================

.SwingBack	move.w	Off3E(a0),d0
		sub.w	#$C,d0
		bmi.s	.2
		subq.w	#8,d0

.2
		move.w	d0,Off3E(a0)
		add.w	d0,Angle(a0)

		cmpi.w	#-GHZ2_Boss_Ball_MaxSPD,d0
		bgt.s	GHZ2_Boss_Ball_SwingDo
		move.w	#-GHZ2_Boss_Ball_MaxSPD,Off3E(a0)

GHZ2_Boss_Ball_SwingDo:
		move.b	Angle(a0),d1
		jmp	Obj15_Move2

GHZ2_Boss_Ball_Fly:
		jsr	ObjectFall
		jsr	ObjHitFloor
		tst.w	d1
		bpl.s	.disp
		add.w	d1,Y_Pos(a0)
		neg.w	Y_Vel(a0)
		asr	Y_Vel(a0)
		asr	X_Vel(a0)

		cmpi.w	#-$A0,Y_Vel(a0)
		bgt.s	.DontSpawn
		moveq	#$FFFFFFBD,d0
		jsr	PlaySound 	; play stomping sound

		tst.b	Routine2(a0)
		bmi.s	.DontSpawn
		moveq	#0,d0
		move.w	X_pos(a0),d1
		jsr	GHZ2Boss_StartScroll
		move.b	#-1,Routine2(a0)

.DontSpawn	cmpi.w	#-$40,Y_Vel(a0)
		ble.s	.disp
		move.l	#0,X_Vel(a0)
		move.l	#0,Y_Vel(a0)

.disp		cmpi.w	#GHZ2_Boss_Pos_Left+$16,X_Pos(a0)
		bhs.s	.ChkRight
		move.w	#GHZ2_Boss_Pos_Left+$16,X_Pos(a0)
		move.w	#0,X_vel(a0)

.ChkRight	cmpi.w	#GHZ2_Boss_Pos_Right-$16,X_Pos(a0)
		bls.s	.Display
		move.w	#GHZ2_Boss_Pos_Right-$16,X_Pos(a0)
		move.w	#0,X_vel(a0)

.Display	bra	Obj48_ChkVanish

GHZ2_Boss_Ball_SlowDown:
		pea	DisplaySprite		; display the sprite lastly
		bsr.w	sub_17C2A

		moveq	#0,d4
		move.b	Off2C(a0),d4
		lsl.w	#6,d4
		addi.l	#$FFD000,d4
		movea.l	d4,a2
		move.w	X_pos(a2),Off32(a1)

		cmpi.w	#-$10,Off3E(a0)
		blt.s	.Swing
		cmpi.w	#$10,Off3E(a0)
		bgt.s	.Swing
		cmpi.b	#$40-4,Angle(a0)
		blt.s	.Swing
		cmpi.b	#$40+4,Angle(a0)
		bgt.s	.Swing

		addq.b	#2,Routine(a0)
		move.w	#$4080,Angle(a0)
		move.w	#0,Off3E(a0)
		move.b	Angle(a0),d1
		jmp	Obj15_Move3

.Swing		move.b	Angle(a0),d0
		sub.b	#$40,d0
		bpl.s	.SwingBack

		move.w	Off3E(a0),d0
		add.w	#8,d0
		bpl.s	.1
		add.w	#$A,d0
.1		move.w	d0,Off3E(a0)
		add.w	d0,Angle(a0)

;		cmpi.w	#$300,Off3E(a0)
;		blt.s	GHZ2_Boss_Ball_SwingDo2
;		move.w	#$300,Off3E(a0)
		bra.s	GHZ2_Boss_Ball_SwingDo2
; ===========================================================================

.SwingBack	move.w	Off3E(a0),d0
		sub.w	#8,d0
		bmi.s	.2
		sub.w	#$A,d0

.2		move.w	d0,Off3E(a0)
		add.w	d0,Angle(a0)

;		cmpi.w	#-$300,Off3E(a0)
;		bgt.s	GHZ2_Boss_Ball_SwingDo2
;		move.w	#-$300,Off3E(a0)

GHZ2_Boss_Ball_SwingDo2:
		move.b	Angle(a0),d1
		jmp	Obj15_Move3

GHZ2_Boss_Ball_Pick:
		bsr.w	sub_17C2A

		tst.b	Off3E(a0)
		bne.s	GHZ2_Boss_Ball_Picked
		cmpi.w	#GHZ2_Boss_LowY,Boss_Y(a1)
		blt.s	.no
		move.b	#1,Off3E(a0)
		moveq	#$FFFFFFBA,d0
		jsr	PlaySound 	; play picking sound

		moveq	#0,d4
		move.b	Off2C(a0),d4
		lsl.w	#6,d4
		addi.l	#$FFD000,d4
		movea.l	d4,a2
		subq.b	#2,Routine(a2)

.no		moveq	#$40,d1
		jsr	Obj15_Move3
		jmp	DisplaySprite

GHZ2_Boss_Ball_Picked:
		cmpi.w	#GHZ2_Boss_MainY,Boss_Y(a1)
		bgt.s	.dsp
		subq.b	#4,Routine(a0)

.dsp		moveq	#$40,d1
		jsr	Obj15_Move2
		jmp	DisplaySprite

GHZ2_Boss_FaceMain:
		moveq	#0,d0
		moveq	#1,d1
		movea.l	Off34(a0),a1
		move.b	(a0),d0
		cmp.b	(a1),d0
		bne.w	GHZ3_Boss_FaceDel
		move.b	Routine2(a1),d0
;		subq.b	#4,d0
;		bne.s	loc2_17A3E
;		cmpi.w	#$2A00,Boss_X(a1)
;		bne.s	loc2_17A46
;		moveq	#4,d1

loc2_17A3E:
		sub.b	#$C,d0
		bmi.s	loc2_17A46
		moveq	#$A,d1
		bra.s	loc2_17A5A
; ===========================================================================

loc2_17A46:
		tst.b	Coll(a1)
		bne.s	loc2_17A50
		moveq	#5,d1
		bra.s	loc2_17A5A
; ===========================================================================

loc2_17A50:
		cmpi.b	#4,Object_RAM+Routine.w
		blo.s	loc2_17A5A
		moveq	#4,d1

loc2_17A5A:
		move.b	d1,Anim(a0)
		subq.b	#2,d0
		bne.w	GHZ2_Boss_FaceDisp
		move.b	#6,Anim(a0)

GHZ2_Boss_FaceDisp:
		bra.w	GHZ3_Boss_Display

GHZ2_Boss_FlameMain:			; XREF: GHZ2_Boss_Index
		move.b	#7,Anim(a0)
		movea.l	Off34(a0),a1
		move.b	(a0),d0
		cmp.b	(a1),d0
		bne.w	GHZ3_Boss_FaceDel
		cmpi.b	#$E,Routine2(a1)
		bne.s	loc2_17A96
		move.b	#$B,Anim(a0)
		bra.s	GHZ2_Boss_FlameDisp
; ===========================================================================

loc2_17A96:
		move.w	X_Vel(a1),d0
		beq.s	GHZ2_Boss_FlameDisp
		move.b	#8,Anim(a0)

GHZ2_Boss_FlameDisp:
		bra.w	GHZ3_Boss_Display