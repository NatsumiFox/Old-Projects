FZ_Boss_ID:		equ $87
FZ_Boss_Pos_Left:	equ $1800
FZ_Boss_Pos_Right:	equ $1C00
FZ_Boss_Pos_Up:		equ $80
FZ_Boss_Pos_Down:	equ $2E0

FZ_Boss_SP_X:		equ FZ_Boss_Pos_Left+((FZ_Boss_Pos_Right-FZ_Boss_Pos_Left)/2)
FZ_Boss_SP_Y:		equ FZ_Boss_Pos_Up+$60
FZ_Boss_SP_Down:	equ FZ_Boss_Pos_Down+$30
FZ_Boss_Turrets:	equ Angle
FZ_Boss_Angle:		equ Inertia
FZ_Boss_TgtAngle:	equ Anim_Dur
FZ_Boss_Timer:		equ Anim_Restart
; ---------------------------------------------------------------------------
; Object - Boss (GHZ2)
; ---------------------------------------------------------------------------
FZ2_Boss_SetScreenBounds:
		move.w	$FFFFF700.w,d0		; get screen x
		bclr	#0,d0
		move.w	#FZ2_Boss_Pos_Left,d2	; get min x
		cmp.w	d2,d0			; check if screen is further?
		bgt.s	.skp			; if is, branch
		move.w	d0,d2			; get position to scroll to

.skp		move.w	d2,$FFFFF728.w

		move.w	#FZ2_Boss_Pos_ScrRight,d2; get max x
		cmp.w	d2,d0			; check if screen is further?
		blt.s	.skp2			; if is, branch
		move.w	d0,d2			; get position to scroll to

.skp2		move.w	d2,$FFFFF72A.w
		rts
; ===========================================================================
FZ_Boss:					; XREF: Obj_Index
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	FZ_Boss_Index(pc,d0.w),d1
		jmp	FZ_Boss_Index(pc,d1.w)
; ===========================================================================
FZ_Boss_Index:	dc.w FZ_Boss_Main-FZ_Boss_Index
		dc.w FZ_Boss_ShipMain-FZ_Boss_Index
		dc.w MZ2_Boss_FaceMain-FZ_Boss_Index
		dc.w GHZ2_Boss_FlameMain-FZ_Boss_Index
		dc.w FZ_Boss_ArrowFace-FZ_Boss_Index
	;	dc.w FZ_Boss_ArrowMain-FZ_Boss_Index

			; routine counter, animation
FZ_Boss_ObjData:	dc.b 2,	0	; the main ship
			dc.b 4,	1	; Eggman face
			dc.b 6,	7	; flame from the ship
			dc.b 8,	0	; FZ_Boss_ArrowFace
; ===========================================================================

FZ_Boss_Main:				; XREF: FZ_Boss_Index
		lea	FZ_Boss_ObjData(pc),a2	; get data array
		movea.l	a0,a1			; copy this object to a1
		moveq	#3,d1			; get length
		bra.s	FZ_Boss_LoadBoss	; start with current object
; ===========================================================================

FZ_Boss_Loop:
		jsr	SingleObjLoad2		; load next object
		bne.s	FZ_Boss_SkipLoad	; if all slots are full, end

FZ_Boss_LoadBoss:				; XREF: FZ_Boss_Main
		move.b	(a2)+,Routine(a1)	; get routine counter
		move.b	#FZ_Boss_ID,(a1)	; use current object
		move.w	X_pos(a0),X_pos(a1)	;
		move.w	Y_Pos(a0),Y_Pos(a1)	; copy positions
		move.l	#Map_Eggman,Mappings_Offset(a1); get mappings
		move.w	#$8400,Art_Tile(a1)	;
		move.b	#4,Render_Flags(a1)	;
		move.b	#$22,X_Visible(a1)	;
		move.b	#3,Priority(a1)		;
		move.b	(a2)+,Anim(a1)		; get animation
		move.l	a0,Off34(a1)		; save boss address
		dbf	d1,FZ_Boss_Loop		; repeat sequence 3 more times

FZ_Boss_SkipLoad:
		move.w	X_pos(a0),Boss_X(a0)	;
		move.w	Y_Pos(a0),Boss_Y(a0)	; copy positions to other memory
		move.b	#$F,Coll(a0)		; set to boss
		move.b	#6,Coll2(a0)		; set number of	hits to	8
		move.w	#0,FZ_Boss_TrackPos.w	; clear tracking offset
		st	BossMode.w		; we are in a boss :O
		clr.w	$FFFFF614.w
		sf	$FFFFFE1E.w		; stop time counter

		lea	FZ_Boss_Tracking.w,a1	; get tracking array
		move.w	#($400/4),d6		; get size of it
		move.w	Y_Pos(a0),d4		; move y position to d5
		move.w	d4,d5			; copy to low word
		swap	d4			; swap to high word
		move.w	X_Pos(a0),d4		; get x position

.clear		move.l	d4,(a1)+		; copy position to tracking array
		dbf	d6,.clear		; loop for d0 times

		lea	FZ_Boss_Turrets(a0),a2	; get turrets RAM
		moveq	#5-1,d6			; 5 objects

.load		jsr	SingleObjLoad2		; load next object
		bne.s	.rts			; if all slots are full, end
		move.b	#4,(a1)			; use current object
		move.w	d4,x_pos(a1)		;
		move.w	d5,y_pos(a1)		; copy positions
		move.w	a1,(a2)+		; get low word of address (aka the part that makes a difference)
		dbf	d6,.load		; loop for d6 times

.rts		moveq	#$FFFFFFE4+$D,d0	; music $11
		jmp	PlayMusicFade		; wait for a frame to ensure turret loads

FZ_Boss_ShipMain:				; XREF: FZ_Boss_Index
		moveq	#0,d0
		move.b	Routine2(a0),d0			; get secondary routine counter
		move.w	FZ_Boss_ShipIndex(pc,d0.w),d0
		jsr	FZ_Boss_ShipIndex(pc,d0.w)	; jump to the correct routine

	; track boss as if Sonic
		move.w	FZ_Boss_TrackPos.w,d0	; get position
		subq.w	#4,d0			; next pos
		and.w	#$3FC,d0		; keep in range of $400 bytes

		lea	FZ_Boss_Tracking.w,a1	; get array
		lea	(a1,d0.w),a1		; get target pos
		move.w	x_pos(a0),(a1)+		;
		move.w	y_pos(a0),(a1)		; copy positions to array
		move.w	d0,FZ_Boss_TrackPos.w	; save offset

		bsr.s	FZ_Boss_TurretFollow

		lea	Ani_Eggman,a1
		jsr	AnimateSprite			; animate object
		move.b	Status(a0),d0
		andi.b	#3,d0				; only maintain X and Y flip bits
		andi.b	#$FC,Render_Flags(a0)		; clear X and Y flip bits
		or.b	d0,Render_Flags(a0)		; if X and Y flip bits were set, copy to Render flags
		jmp	DisplaySprite			; display sprite
; ===========================================================================
FZ_Boss_ShipIndex:dc.w FZ_Boss_ShipStart-FZ_Boss_ShipIndex
		dc.w FZ_Boss_descend-FZ_Boss_ShipIndex
		dc.w FZ_Boss_Wave-FZ_Boss_ShipIndex

		dc.w FZ_Boss_Explode-FZ_Boss_ShipIndex
		dc.w FZ_Boss_Escape-FZ_Boss_ShipIndex
		dc.w FZ_Boss_Escape-FZ_Boss_ShipIndex
; ===========================================================================

FZ_Boss_TurretFollow:
		cmp.b	#4,Routine2(a0)
		slo	d4

		move.w	FZ_Boss_TrackPos.w,d5	; get tracking pos
		add.w	#12*4,d5		; add to offset the turret
		lea	FZ_Boss_Tracking.w,a3	; get tracking array
		lea	FZ_Boss_Turrets(a0),a2	; get turrets

		moveq	#5-1,d6			; loop for all of em
		move.b	Coll2(a0),d6		; get amount of hits left
		subq.b	#2,d6			; sub 2 (last hit and dbf)
		bmi.s	.rts			; if negative, dont break all of this

.loop		add.w	#24*4,d5		; next position on the array
		and.w	#$3FC,d5		; keep in range

		moveq	#-1,d0			; prepare $FFFFxxxx to d0
		move.w	(a2)+,d0		; get position on RAM
		beq.s	.next			; if 0, skip

		movea.l	d0,a1			; get final object
		cmp.b	#4,(a1)			; is turret?
		beq.s	.skp			; if so, move
		move.w	#0,-2(a2)		; clear the position
		dbf	d6,.loop		; loop
		rts

.skp		lea	(a3,d5.w),a4		; get data pos
		move.w	(a4)+,x_pos(a1)		;
		move.w	(a4),y_pos(a1)		; save positions
		add.w	#$C,y_pos(a1)		; offset
		clr.l	x_vel(a1)		; dont fall
		st	Coll2(a1)
		st	Respawn(a1)
		move.b	d4,Subtype(a1)

.next		dbf	d6,.loop		; keep looping
.rts		rts

FZ_Boss_ShipStart:			; XREF: FZ_Boss_ShipIndex
		move.b	Coll2(a0),d0		; get hits left
		tas	d0			; set updaate bit
		move.b	d0,BossLives.w		; save to boss lives counter
		move.w	#0,y_vel(a0)		; clear velocity

		move.w	boss_x(a0),d0		; get boss x
		sub.w	Object_RAM+x_pos.w,d0	; sub sonic x
		spl	d1
		add.w	#$90,d0			; check min bound
		cmp.w	#$90*2,d0		; and max bound
		bhs.s	FZ_Boss_BossHover	; if not in bound, skip

		addq.b	#2,Routine2(a0)		; next routine (descend)
		move.b	#6,Coll2(a0)		; set hits again
		move.l	#Level_ow2,Layout_Data.w
		move.w	#FZ_Boss_Pos_Down-$50,$FFFFF726.w

FZ_Boss_descend:
		cmp.w	#FZ_Boss_SP_Down,boss_y(a0); is low enough?
		bge.s	FZ_Boss_next		; if is, branch
		move.w	#$280,y_vel(a0)		; descend

		moveq	#0,d2			; set forward angle
		moveq	#-$80,d3		; set backwards angle
		bset	#0,Status(a0)		; set flip
		move.w	boss_x(a0),d0		; get boss x
		sub.w	Object_RAM+x_pos.w,d0	; sub sonic x
		bmi.s	.setangle		; if not flip, branch
		bclr	#0,Status(a0)		; clear flip
		exg	d2,d3			; backwards to forwards

.setangle	move.b	d3,FZ_Boss_Angle(a0)	; set current angle
		bra.s	FZ_Boss_BossHover	; hover

FZ_Boss_next:
		addq.b	#2,Routine2(a0)		; next routine
		moveq	#6,d0			; prepare 6 hits
		move.b	d0,Coll2(a0)		; ensure 6 hits
		tas	d0			; set redraw bit
		move.b	d0,BossLives.w		; set boss lives
		bra.s	FZ_Boss_BossHover	; hover

FZ_Boss_Wave:
		bsr.w	FZ_Boss_WaveMove	; make wavy movement

FZ_Boss_BossHover:
		bsr.w	BossMove		; run movement routines
		move.b	Off3F(a0),d1		; get offset
		jsr	CalcSine		; get sine
		asr.w	#6,d0			; shifht right 6 bits
		add.w	Boss_Y(a0),d0		; add Boss Y-position
		move.w	d0,Y_Pos(a0)		; set to actual Y-position
		move.w	Boss_X(a0),X_pos(a0)	; copy Y-position to actual Y-position
		addq.b	#2,Off3F(a0)		; increment offset
		cmpi.b	#6,Routine2(a0)		; is secondary routine counter 8?
		bhs	FZ_Boss_NoFlash		; if higher or same, skip flashing

		tst.b	Status(a0)		;
		bmi	FZ_Boss_SetDefeat	; if no hits left, set defeated
		tst.b	Coll(a0)		; if colliding, dont flash
		bne.s	FZ_Boss_NoFlash		; else do
		tst.b	Off3E(a0)		; has timer ran out?
		bne.s	FZ_Boss_ShipFlash	; if hasnt, start flashing

		move.b	#$20,Off3E(a0)		; set number of	times for ship to flash
		move.w	#$AC,d0			;
		jsr	PlaySound		; play boss damage sound

		lea	FZ_Boss_Turrets(a0),a2	; get turrets
		move.w	#FZ_Boss_Pos_Left+$10,d1
		move.w	#FZ_Boss_Pos_Right-$10,d2
		move.w	#FZ_Boss_Pos_Right-$10,d3

		moveq	#5-1,d6			; loop for all of em
		move.b	Coll2(a0),d6		; get amount of hits left
		subq.b	#1,d6			; sub 1
		bmi.s	FZ_Boss_ShipFlash	; if negative, dont break all of this

.loop		moveq	#-1,d0			; prepare $FFFFxxxx to d0
		move.w	(a2)+,d0		; get position on RAM
		beq.s	.next			; if 0, skip
		movea.l	d0,a1			; get final object

		cmp.w	x_pos(a1),d1
		blt.s	.checkx
		move.w	d1,x_pos(a1)

.checkx		cmp.w	x_pos(a1),d2
		bgt.s	.checky
		move.w	d2,x_pos(a1)

.checky		cmp.w	y_pos(a1),d3		; is at the very bottom?
		bgt.s	.next			; if not, skip
		move.w	d3,y_pos(a1)		; cap the bottom area boss can go to

.next		dbf	d6,.loop		; keep looping

FZ_Boss_ShipFlash:
		lea	$FFFFFB22.w,a1 		; load 2nd line, 2nd entry
		moveq	#0,d0			; move 0 (black) to d0
		tst.w	(a1)			; does the line currently have this entry?
		bne.s	.set			; if not, branch
		move.w	#$EEE,d0		; move 0EEE (white) to d0

.set		move.w	d0,(a1)			; load colour stored in	d0
		subq.b	#1,Off3E(a0)		; decrement timer
		bne.s	FZ_Boss_NoFlash		; if still not 0, branch
		move.b	#$F,Coll(a0)		; reset collision and stop flashing
		move.w	#0,(a1)			; load colour stored in	d0

FZ_Boss_NoFlash:
		rts

; ===========================================================================
FZ_Boss_SetDefeat:				; XREF: FZ_Boss_BossHover
		moveq	#100,d0		; 100 points
		bsr.w	AddPoints	; add points
		move.b	#6,Routine2(a0); set to defeated subroutine
		move.w	#$B3,Off3C(a0)	; explosion timer
		move.w	#FZ2_Boss_Pos_ScrDown,$FFFFF726.w

		bra.w	FZ2_Boss_SetScreenBounds

; ===========================================================================
FZ_Boss_WaveMove:
		tst.b	Coll(a0)		; is the boss hurt?
		bne.s	.normal			; if not, target Sonic

		moveq	#$7F,d0			; set distance away from Sonic
		btst	#0,Status(a0)		; is flipped?
		bne.s	.notflip		; if not, branch
		neg.w	d0			; go to other direction

.notflip	move.w	Object_RAM+x_pos.w,d1	; get xpos
		move.w	Object_RAM+y_pos.w,d2	; and Sonic's ypos
		add.w	d0,d1			; add distance
		sub.w	#$A0,d2			; add distance

		bset	#0,Status(a0)		; set flip
		move.w	#$480,d5		;
		move.w	#$380,d6		; set away speeds
		bra.s	.doangle		; common

.normal		bset	#0,Status(a0)		; set flip
		move.w	#$380,d5		;
		move.w	#$180,d6		; set towards speeds

		move.w	Object_RAM+x_pos.w,d1	; get xpos
		move.w	Object_RAM+y_pos.w,d2	; and Sonic's ypos
		sub.w	#$58,d2			; add distance

.doangle	sub.w	boss_x(a0),d1		; sub bosses pos
		sub.w	boss_y(a0),d2		; sub bosses pos
		jsr	CalcAngle		; get target angle

		move.b	FZ_Boss_Angle(a0),d0	; get current angle
		exg	d1,d0			; swap d0 with d1
		move.w	#$100,d2		; set increment

		sub.b	d1,d0			; compare
		bpl.s	.notneg			; if positive, branch
		neg.w	d2			; positive to negative

.notneg		add.w	d2,FZ_Boss_Angle(a0)	; add to current angle
		jsr	CalcSine		; get sine
		muls.w	d5,d1			; mult sine
		asr.l	#8,d1			; keep in reasonable range
		move.w	d1,X_Vel(a0)		; towards sonic
		bpl.s	.n			; is positive?
		bclr	#0,Status(a0)		; if not flip boss

.n		muls.w	d6,d0			; mult cosine
		asr.l	#8,d0			; keep in reasonable range
		move.w	d0,Y_Vel(a0)		; towards sonic
		rts

; ===========================================================================
FZ_Boss_Explode:				; XREF: FZ_Boss_ShipIndex
		subq.w	#1,Off3C(a0)		; decrement timer
		bmi.s	.defeated		; if negative, branch
		bra.w	BossDefeated		; generate explosions

.defeated	bset	#0,Status(a0)		; face right
		bclr	#7,Status(a0)		; set defeated
		clr.w	X_Vel(a0)		; clear speed
		addq.b	#4,Routine2(a0)		; next routine
		move.w	#-$26,Off3C(a0)		; set timer(?)
		tst.b	$FFFFF7A7.w		;
		bne.s	.rts			;
		move.b	#1,$FFFFF7A7.w		; something to do with animals

.rts		rts
; ===========================================================================

FZ_Boss_Escape:				; XREF: FZ_Boss_ShipIndex
		bsr.w	FZ2_Boss_LockScreen
		move.w	#-$400,Y_Vel(a0)	; set escape speed
		move.w	#0,x_Vel(a0)		; go upwards

		cmpi.w	#FZ_Boss_Pos_Up+$40,y_pos(a0)
		bge.w	FZ_Boss_BossHover
; ===========================================================================

.finish
; ===========================================================================

FZ_Boss_ShipDel:
		move.w	x_pos(a0),d5
		move.w	y_pos(a0),d6
		jsr	DeleteObject		; delete boss
		move.b	#FZ2_Boss_ID,(a0)
		move.w	d5,x_pos(a0)
		move.w	d6,y_pos(a0)
		rts

; ===========================================================================
FZ_ArrowMaps:	dc.b -12, $A, 0, 0, -12
		even
; ===========================================================================
FZ_Boss_ArrowFace:
		moveq	#0,d0
		move.b	Routine2(a0),d0
		jmp	.i(pc,d0)
; ===========================================================================
.arrow_:	bra.w .arrow
.i		bra.s .init
		bra.s .draw
		bra.s .arrow_

.init		move.l	#FZ_ArrowMaps,Mappings_Offset(a0); get mappings
		move.w	#($D000/$20)|$8000,Art_Tile(a0)	;
		move.b	#$24,Render_Flags(a0)	;
		move.b	#7,Priority(a0)		;
		addq.b	#2,Routine2(a0)

		jsr	SingleObjLoad2
		bne.s	.draw		; if all slots are full, end

		move.b	(a0),(a1)
		move.l	a1,Off38(a0)
		move.b	#4,Routine2(a1)
		move.b	Routine(a0),Routine(a1)
		move.w	#($D120/$20)|$8000,Art_Tile(a1)	;
		move.b	#$24,Render_Flags(a1)	;
		move.b	#6,Priority(a1)		;
		move.l	Mappings_Offset(a0),Mappings_Offset(a1)

.draw		lea	Object_RAM+x_pos,a1	; get Sonic to a1
		movea.l	Off34(a0),a2		; get boss to a2
		movea.l	Off38(a0),a3		; get arrow graphic to a3

		move.w	X_pos(a2),d1		; get x position of boss
		sub.w	(a1),d1			; sub x position of sonic
		move.w	Y_Pos(a2),d2		; get y position of boss
		sub.w	Y_Pos-X_pos(a1),d2	; sub y position of sonic

		jsr	CalcAngle		; get angle
		move.w	d1,Off3E(a3)		; store angle
		jsr	CalcSine		; get sine and cosine

		asr.w	#2,d0
		asr.w	#2,d1			; only allow certain length offset
		move.w	X_pos(a2),d2		; get eggman x position
		move.w	Y_Pos(a2),d3		; for y ^
		sub.w	d1,d2			; sub the offset
		sub.w	d0,d3			; ^
		move.w	d2,x_pos(a0)
		move.w	d3,y_pos(a0)		; save positions to this object

		move.w	$FFFFF700.w,d0		; get Plane A x-pos
		add.w	#$20,d0			; min test pos
		cmp.w	d0,d2
		bgt.s	.checkmax
		move.w	d0,x_pos(a0)		; set new X-pos

.checkmax	add.w	#320-$40,d0		; max test pos
		cmp.w	d0,d2
		blt.s	.checkY
		move.w	d0,x_pos(a0)		; set new X-pos

.checkY		move.w	$FFFFF704.w,d0		; get Plane A y-pos
		add.w	#$18,d0			; min test pos
		cmp.w	d0,d3
		bgt.s	.checkmaxy
		move.w	d0,y_pos(a0)		; set new Y-pos

.checkmaxy	add.w	#224-$30,d0		; max test pos
		cmp.w	d0,d3
		blt.s	.copy
		move.w	d0,y_pos(a0)		; set new Y-pos


.copy		move.w	x_pos(a0),x_pos(a3)
		move.w	y_pos(a0),y_pos(a3)	; copy positions to arrow object

		tst.b	(a2)
		beq.s	.del
		jmp	DisplaySprite		; display grahics

.del		jsr	DeleteObject
		movea.l	a3,a1
		jmp	DeleteObject2

; routine for handling arrow
.arrow		move.b	#$24,Render_Flags(a0)	; reset render flags

		moveq	#-$40,d0
		moveq	#2,d1
		and.b	off3F(a0),d0
		rol.b	#2,d0
		eor.b	d1,d0
		or.b	d0,Render_Flags(a0)

		moveq	#0,d1			; clrear d1
		move.b	off3F(a0),d1		; get angle again

		btst	#1,d0			; test Y flip flag
		bne.s	.n			; if not set, branch
		bchg	#0,Render_Flags(a0)	; switch X flip flag

.n		btst	#0,d0			; test X flip flag (stored)
		beq.s	.s			; if set, branch
		neg.b	d1			; negate angle

.s		andi.b	#$3F,d1			; only allow for $3F angles (as of mirroring)
	;	divu.w	#6,d1			; divide by 6 (for 11 frames)
		mulu.w	#$2AAB,d1
		swap	d1			; FlameWing magic

		moveq	#$F,d2
        	and.l	d2,d1
		add.w	d1,d1
		move.w	d1,-(sp)
		move.w	.multiplesof288(pc,d1.w),d1

		addi.l	#Unc_arrowgfx,d1	; add the art graphics to offset
		move.w	#$D120,d2		; art offset
		move.w	#9*32,d3		; 9 tiles to load
		jsr	QueueDMATransfer	; queue the art load

		move.w	(sp)+,d1		; get the saved offset
		move.b	.offsetList+1(pc,d1.w),d2; get new y-off
		move.b	.offsetList(pc,d1.w),d1	; get new x-off
		ext.w	d1			; extend to word
		ext.w	d2			; ^

		btst	#0,Render_Flags(a0)	; check for x-flip
		beq.s	.chkY			; if set, branch
		neg.w	d1			; negate x-off

.chkY		btst	#1,Render_Flags(a0)	; check for y-flip
		bne.s	.set			; if not set, branch
		neg.w	d2			; negate y-off

.set		add.w	d1,X_pos(a0)		;
		add.w	d2,Y_pos(a0)		; add offsets to pos
		jmp	DisplaySprite		; display

.multiplesof288	dc.w 288*0, 288*1, 288*2, 288*3, 288*4, 288*5, 288*6, 288*7, 288*8, 288*9, 288*10, 288*11

.offsetList:	dc.w $0C00, $0C01, $0D03, $0A05, $0906, $0707, $0707, $050A, $030B, $010C, $000D
