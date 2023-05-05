Obj_MGZEB_SpawnB =	$3D300760

Obj_A1_1_MGZ2_Boss:
		btst	#5,OptionsBits.w		; NAT: Check if bosses are on
		bne.s	.enabled			; if are, branch
		lea	.screen(pc),a1			; else, lock screen
		jmp	Boss_Force_End_2		;

.screen		dc.w $3C80, $3C80, $6A0, $6A0

.enabled	move.b	#$81,BossHitMode.w		; NAT: Enable hit mode
		st	(Border_Bottom_Death).w			; no death at bottom boundary
		clr.w	BossHitsP1.w			; clear hits count
		move.l	#.ok,(a0)			; set new obj

.ok		moveq	#0,d0
		move.b	5(a0),d0
		move.w	off_6C332(pc,d0.w),d1
		jsr	off_6C332(pc,d1.w)
		bsr.w	MGZ2_SpecialCheckHit
		jmp	Draw_And_Touch_Sprite.w
; ---------------------------------------------------------------------------
off_6C332:	dc.w loc_6C354-off_6C332
		dc.w loc_6C3E6-off_6C332
		dc.w loc_6C416-off_6C332
		dc.w loc_6C43A-off_6C332
		dc.w loc_6C45A-off_6C332
		dc.w loc_6C3E6-off_6C332	; $10
		dc.w loc_6C4B2-off_6C332
		dc.w loc_6C4F2-off_6C332
		dc.w loc_6C514-off_6C332
		dc.w loc_6C3E6-off_6C332
		dc.w loc_6C546-off_6C332
		dc.w loc_6C3E6-off_6C332
		dc.w loc_6C514-off_6C332
		dc.w loc_6C5C4-off_6C332	; $20
		dc.w loc_6C5FE-off_6C332
		dc.w loc_6C4F2-off_6C332
		dc.w loc_6C514-off_6C332
; ---------------------------------------------------------------------------

loc_6C354:
		lea	ObjDat_MGZDrillBoss(pc),a1
		jsr	SetUp_ObjAttributes.w
		bset	#7,$A(a0)
		st	$46(a0)
		move.b	#8,$29(a0)
		move.b	#1,(Boss_flag).w
		move.b	#$1C,$1E(a0)
		move.w	#$C,$26(a0)
		moveq	#-$1F,d0
		jsr	Play_Sound.w
		move.w	#$78,$2E(a0)
		move.l	#loc_6C3EC,$34(a0)

		lea	PLC_MGZ_EndBoss(pc),a1
		jsr	Load_PLC_Raw.w		; NAT: Load this plc

		moveq	#$6D,d0
		jsr	Load_PLC.w
		lea	Pal_MGZEndBoss(pc),a1
		jsr	PalLoad_Line1.w
		lea	(Child1_MakeRoboShip3).l,a2
		jsr	CreateChild1_Normal.w
		bne.s	loc_6C3DC
		move.b	#9,$2C(a1)

loc_6C3DC:
		lea	ChildObjDat_6D7C0(pc),a2
		jmp	CreateChild1_Normal.w
; ---------------------------------------------------------------------------

PLC_MGZ_EndBoss:
		dc.w 2
		dc.l ArtKosM_MGZEndBoss
		dc.w $67E0
		dc.l ArtKosM_MGZFloatDevice
		dc.w $5A0*32
		dc.l ArtKosM_MGZEndBossDebris
		dc.w -$7440
; ---------------------------------------------------------------------------

loc_6C3EC:
		move.b	#4,5(a0)
		moveq	#Mus_Boss,d0
		move.b	d0,(Level_music+$1).w
		jsr	Play_Sound.w
		move.w	#$80,$1A(a0)
		move.w	#$BF,$2E(a0)
		move.l	#loc_6C422,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C416:
		jsr	MoveSprite2.w

loc_6C3E6:
		jmp	Obj_Wait.w
; ---------------------------------------------------------------------------

loc_6C422:
		move.b	#6,5(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_6C44C,$34(a0)
		jmp	Swing_Setup1.w
; ---------------------------------------------------------------------------

loc_6C43A:
		jsr	Swing_UpAndDown.w
		jsr	MoveSprite2.w

loc_6C4F2:
		jmp	Obj_Wait.w
; ---------------------------------------------------------------------------

loc_6C44C:
		move.b	#8,5(a0)
		move.w	#3,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C45A:
		jsr	Swing_UpAndDown.w
		jsr	MoveSprite2.w
		subq.w	#1,$2E(a0)
		bpl.s	locret_6C47E
		move.w	#3,$2E(a0)
		subq.w	#2,$26(a0)
		cmpi.w	#4,$26(a0)
		bls.s	loc_6C480

locret_6C47E:
		rts
; ---------------------------------------------------------------------------

loc_6C480:
		move.b	#$A,5(a0)
		bset	#3,$38(a0)
		move.w	#$5F,$2E(a0)
		move.l	#loc_6C49C,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C49C:
		move.b	#$C,5(a0)
		move.w	#$400,$1A(a0)
		move.l	#loc_6C4BE,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C4B2:
		jsr	MoveSprite2.w
		jmp	ObjHitFloor_DoRoutine.w
; ---------------------------------------------------------------------------

loc_6C4BE:
		move.b	#$E,5(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_6C4F8,$34(a0)

		st	(ScrEvents_1).w
	;	st	(Border_Bottom_Death).w		; Not today haha
		moveq	#$61,d0
		jmp	Play_Sound_2.w
	;	move.w	#$12,(CPU_Routine).w	; NAT: LOL
; ---------------------------------------------------------------------------

loc_6C4F8:
		move.b	#$10,5(a0)
		move.w	#-$400,$1A(a0)
		move.w	#$17,$2E(a0)
		move.l	#loc_6C51A,$34(a0)

locret_6C4F0:
		rts
; ---------------------------------------------------------------------------

loc_6C514:
		jmp	Move_WaitNoFall.w
; ---------------------------------------------------------------------------

loc_6C51A:
		move.b	#$12,5(a0)
		bclr	#3,$38(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_6C538,$34(a0)
		jmp	Swing_Setup1.w
; ---------------------------------------------------------------------------

loc_6C538:
		move.b	#$14,5(a0)
		move.w	#3,$2E(a0)

	; NAT: Load floating devices for players
		jsr	Create_New_Sprite.w
		bne.s	.rts
		move.l	#Obj_MGZ2_FloatDev,(a1)
		move.w	#Player_1,parent(a1)
		move.w	#CTRL_1,parent2(a1)
		move.w	a1,a2			; copy to a2 for below

		jsr	Create_New_Sprite.w
		bne.s	.rts
		move.l	#Obj_MGZ2_FloatDev,(a1)
		move.w	#Player_2,parent(a1)
		move.w	#CTRL_2,parent2(a1)
		addq.b	#1,mapping_frame(a1)	; use different frame for tails

		move.w	a2,parent3(a1)
		move.w	a1,parent3(a2)
.rts		rts
; ---------------------------------------------------------------------------

	dc.b "Nazis aren't the scary thing. I am most afraid by the rise in "
	dc.b "communism among young adults and teens. We can't let them win."

loc_6C546:
		jsr	Swing_UpAndDown.w
		jsr	MoveSprite2.w
		subq.w	#1,$2E(a0)
		bpl.s	locret_6C564
		move.w	#3,$2E(a0)
		subq.w	#2,$26(a0)
		beq.s	loc_6C566

locret_6C564:
		rts
; ---------------------------------------------------------------------------

loc_6C566:
		move.b	#$16,5(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_6C57C,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C57C:
		move.b	#$18,5(a0)
		move.w	#-$400,$1A(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_6C598,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C598:
		move.b	#$1A,5(a0)
		clr.b	$46(a0)
		bset	#0,4(a0)
		move.w	#$3E80,$10(a0)
		move.w	#$700,$14(a0)
		move.w	#-$80,$18(a0)
		move.b	#6,$3A(a0)
		jmp	Swing_Setup1.w
; ---------------------------------------------------------------------------

loc_6C5C4:
		jsr	MoveSprite2.w
		btst	#6,$2A(a0)
		bne.s	loc_6C5E8
		move.w	Camera_X_Pos.w,d0
		add.w	#320/2,d0		; NAT: Piss
		cmp.w	$10(a0),d0
		bhs.s	loc_6C5E8
		jsr	Swing_UpAndDown.w
		jmp	MoveSprite2.w
; ---------------------------------------------------------------------------

loc_6C5E8:
		move.b	#$1C,5(a0)
		move.w	#$200,$18(a0)
		move.l	#loc_6C614,$34(a0)
.rts		rts
; ---------------------------------------------------------------------------

loc_6C5FE:
		jsr	Swing_UpAndDown.w
		jsr	MoveSprite2.w
		cmpi.w	#$3E00,$10(a0)
		blo.s	loc_6C5E8.rts

loc_6C614:
		move.b	#$1E,5(a0)
		moveq	#$60,d0
		jsr	Play_Sound_2.w
		bclr	#3,$38(a0)
		bclr	#2,$38(a0)
		move.w	#$9F,$2E(a0)
		move.l	#loc_6C646,$34(a0)
		lea	ChildObjDat_6D836(pc),a2
		jmp	CreateChild1_Normal.w
; ---------------------------------------------------------------------------

loc_6C646:
		move.w	#$1F,$2E(a0)
		move.l	#loc_6C658,$34(a0)
		bra.w	loc_6D710
; ---------------------------------------------------------------------------

loc_6C658:
		bset	#3,$38(a0)
		move.w	#$9F,$2E(a0)
		move.l	#loc_6C66C,$34(a0)

loc_6C66C:
		move.b	#$20,5(a0)
		move.w	#$FF,$2E(a0)
		move.l	#loc_6C614,$34(a0)
		bset	#2,$38(a0)
.rts		rts
; ---------------------------------------------------------------------------
word_6C688:	dc.w	  0,  $128, $3C78, $3E78
		dc.w	$28,   $28, $3D78, $3D78
; ===========================================================================
; ---------------------------------------------------------------------------
; Object to act as Tails does in Sonic 3
; ---------------------------------------------------------------------------

Obj_MGZ2_FloatDev:
_speecinc =	$18		; amount of speed we can add per frame
_nospdrad =	$14		; radius for when we dont want to modify speed
_carrydist =	$12		; vertical distance from sprite centre for carrying player
_carryxoff =	$02		; horizontal offset for player when carrying
_automated =	shield_reaction	; decides whether to fly up or down

_flyhome =	subtype		; home position for fyling up and down
_flyhomevel =	collision_flags	; vertical velocity for moving home vertical pos
_flip =		angle		; provides accurate facing and position update for player
_flyupmaxy =	-$A0		; max vertical velocity when rising up
_flyupstepy =	-$08		; max vertical velocity step when rising up
_flydwnmaxy =	$80		; max vertical velocity when floating down
_flydwnstepy =	$08		; max vertical velocity step when floating down

_flyupminy =	$746		; min vertical position to fly up to by default
_flydwnmaxyp =	$12		; vertical offset for flying up and down
_jumpyvel =	-$300		; velocity when jumping up

_movupminy =	-$180		; minimum vertical speed when player controls device
_movdwnmaxy =	$1C0		; maximum vertical speed when player controls device

_movleminx =	-$280		; minimum horizontal speed when player controls device
_movlestepx =	-$12		; horizontal speed step when player controls device (left)
_movrimaxx =	$280		; maximum horizontal speed when player controls device
_movristepx =	$12		; horizontal speed step when player controls device (right)

		clr.w	art_tile(a0)
		move.l	#Map_FloatDevice,mappings(a0)
		ori.b	#4,render_flags(a0)
		move.w	#prio(3),priority(a0)
		move.w	#$1009,y_radius(a0)
		move.w	#$1009,height_pixels(a0)
		move.l	#.waitcarry,(a0)

		move.w	parent(a0),a1			; get player to a1
		bclr	#3,status(a1)			; clear standing on object bit
		move.w	$42(a1),a1			; get the object the player is on
		tst.l	(a1)				; check if player is on it
		beq.s	loc_6C66C.rts			; if not, branch
		jmp	Delete_Referenced_Sprite.w	; just fucken delete it
; ---------------------------------------------------------------------------

	; check for necessary flags
.waitcarry	move.w	parent(a0),a1			; get player to a1
		tst.b	(End_Of_Level_Flag).w			; check if defeated
		bmi.s	.dexplode			; branch if yes
		btst	#1,status(a0)			; check if we are holding the player
		bne.w	.carryinit			; if so, go back to carry routine

	; follow player around
		move.w	#_speecinc,d0			; prepare speed inc
		move.w	x_pos(a1),d1			; get parent x-pos to d1
		sub.w	x_pos(a0),d1			; sub this x-pos from d1
		add.w	#_nospdrad,d1			; add deadzone radius to d1

		cmp.w	#_nospdrad*2,d1			; check if we are in deadzone
		blo.s	.nox				; if so, do not modify x
		bgt.s	.addx				; if negative distance, just add x
		neg.w	d0				; negative speed inc
.addx		add.w	d0,x_vel(a0)			; add to x-velocity

.nox		move.w	#_speecinc,d0			; prepare speed inc
		move.w	y_pos(a1),d1			; get parent y-pos to d1
		sub.w	y_pos(a0),d1			; sub this y-pos from d1
		add.w	#_nospdrad,d1			; add deadzone radius to d1

		cmp.w	#_nospdrad*2,d1			; check if we are in deadzone
		blo.s	.noy				; if so, do not modify x
		bgt.s	.addy				; if negative distance, just add x
		neg.w	d0				; negative speed inc
.addy		add.w	d0,y_vel(a0)			; add to x-velocity

	; check if we can init carry
.noy		tst.b	4(a0)				; check if we cant display
		bmi.s	.move				; if we can, keep moving
		tst.b	4(a1)				; check if parent is not displayed
		bpl.s	.carrytp			; if they aren't, then tp to them and init carry

.move		jsr	MoveSprite2.w			; handle movement
.disp		jmp	Draw_Sprite			; display

	; at end-of-level, this object will become an explosion
.dexplode	bsr.s	.disp				; display first
.explode	move.l	#Obj_Explosion,(a0)		; turn this into an explosion
		move.b	#6,5(a0)
		clr.b	(Border_Bottom_Death).w			; NAT: yes death at bottom boundary

		move.w	parent(a0),a1			; get player to a1
		cmp.w	#$778,y_pos(a1)			; chehck if player is near ground
		blt.s	.nosnap				; if above, branch
		move.w	#$778,y_pos(a1)			; teleport player upwards
.nosnap		rts
; ---------------------------------------------------------------------------

	; teleport to player
.carrytp	move.w	x_pos(a1),x_pos(a0)		; set x-pos
		move.w	#$7B0,y_pos(a0)			; set y-pos
		sub.w	#_carrydist,y_pos(a0)		; offset y-pos
		clr.l	x_vel(a0)			; clear x and y velocity
		bclr	#3,status(a1)			; clear obj stand bit

	; initialize carry state
.carryinit	move.l	#.carry,(a0)			; init carry
		bset	#1,status(a0)			; carry player
		move.b	#$01,object_control(a1)		; give control of player to us
		move.b	#$14,anim(a1)			; use hang animation

		moveq	#$4A,d0				; get grabbing sfx
		jsr	Play_Sound_2.w			; play it
		st	_automated(a0)			; set automate flag to fly up
		move.w	#_flyupminy,_flyhome(a0)	; set home address
		clr.w	_flyhomevel(a0)			; clear velocity

		cmp.b	#4,routine(a1)			; check if player is dead or hurt
		blo.s	.carry				; branch if not
		clr.b	routine(a1)			; set to reset routine
; ---------------------------------------------------------------------------

	; check for necessary flags
.carry		move.w	parent(a0),a1			; get parent to a1
		tst.b	(End_Of_Level_Flag).w			; check if defeated
		bpl.s	.nodefeat2			; branch if not
		bsr.w	.processjump			; get player off of it
		bra.w	.explode

.nodefeat2	btst	#1,status(a0)			; check if we are holding the player
		beq.w	.waitcarry			; if no, go init
		cmp.b	#4,routine(a1)			; check if player is death
		bhs.w	.prochurt			; if so, let it goo
; ---------------------------------------------------------------------------

	; code for flying around home y-pos
		move.w	_flyhome(a0),d0			; get home address to d0
		tst.b	_automated(a0)			; check automate flag
		bpl.s	.waitdwn			; if letting to fall again, branch

		cmp.w	#_flyupmaxy,y_vel(a0)		; check if we have max y-vel
		ble.s	.nospd				; if yes, skip
		add.w	#_flyupstepy,y_vel(a0)		; increase velocity

.nospd		cmp.w	y_pos(a0),d0			; check if we have reached the gap
		blt.s	.controlcheck			; if not, just move
		neg.b	_automated(a0)			; go down instead
		bra.s	.controlcheck

.waitdwn	cmp.w	#_flydwnmaxy,y_vel(a0)		; check if we have max y-vel
		bgt.s	.nospd2				; if yes, skip
		add.w	#_flydwnstepy,y_vel(a0)		; increase velocity

.nospd2		add.w	#_flydwnmaxyp,d0		; add vertical offset to d0
		cmp.w	y_pos(a0),d0			; check if we have reached the gap
		bgt.s	.controlcheck			; if not, just move
		neg.b	_automated(a0)			; go down instead
; ---------------------------------------------------------------------------

	; get vertical velocity from controller and check for jump
.controlcheck	move.w	parent2(a0),a2			; get controller data to a2
		move.b	(a2)+,d0			; get held buttons
		move.b	(a2)+,d1			; get pressed buttons
		and.b	#$70,d1				; check ABC
		bne.s	.processjump			; if yes, JUMP

		move.w	d0,d1				; copy to d1
		and.w	#3,d1				; get only up and down
		add.w	d1,d1				; double offset
		move.w	.yspeed(pc,d1.w),_flyhomevel(a0); load target speed
; ---------------------------------------------------------------------------

	; calculate horizontal velocity
		and.w	#$C,d0				; get only left and right
		lsr.w	#1,d0				; halve offset
		move.w	.xspeed(pc,d0.w),d0		; get speed to d0
		beq.s	.ctrldone			; if 0, branch
		bmi.s	.chkminxgap			; if negative, branch

		bclr	#0,status(a1)			; face left
		cmp.w	#_movrimaxx,x_vel(a0)		; check if we have max x-vel
		bgt.s	.ctrldone			; if yes, skip
		add.w	d0,x_vel(a0)			; increase velocity
		bra.s	.ctrldone

.yspeed		dc.w 0, _movupminy, _movdwnmaxy, 0
.xspeed		dc.w 0, _movlestepx, _movristepx, 0
; ---------------------------------------------------------------------------

	; if player jumped, process the jump
.processjump	move.w	#_jumpyvel,y_vel(a1)		; set vertical velocity of player
		clr.w	x_vel(a1)			; clear their x-velocity
		bset	#1,status(a1)			; set in air flag
		move.b	#2,anim(a1)			; set juimp animation
.prochurt	clr.b	object_control(a1)		; stop object control

		move.l	#.waitcarry,(a0)		; set waitcarry routine
		bclr	#1,status(a0)			; no hold anymore
		moveq	#$62,d0				; get juping sfx
		jsr	Play_Sound_2.w			; play it
		bra.w	.move

	; calculate backwards horizontal velocity
.chkminxgap	bset	#0,status(a1)			; face right
		cmp.w	#_movleminx,x_vel(a0)		; check if we have max x-vel
		ble.s	.ctrldone			; if yes, skip
		add.w	d0,x_vel(a0)			; increase velocity
; ---------------------------------------------------------------------------

	; calculate speed in a special way
.ctrldone	move.w	x_vel(a0),d0			; load horizontal speed
		ext.l	d0
		lsl.l	#8,d0				; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,x_pos(a0)			; add to x-axis position

		move.w	_flyhomevel(a0),d0		; load vertical speed
		add.w	y_vel(a0),d0			; add real y-vel
		ext.l	d0
		lsl.l	#8,d0				; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,y_pos(a0)			; add to y-home position

		move.w	_flyhomevel(a0),d0		; load vertical speed
		ext.l	d0
		lsl.l	#8,d0				; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,_flyhome(a0)			; add to y-home position
; ---------------------------------------------------------------------------

	; check for collision with left bound
		move.w	Camera_min_X_pos.w,d0		; check camera min pos
		add.w	#$10,d0				;
		cmp.w	x_pos(a0),d0			; check if we are too far
		blt.s	.nocollidele			; branch if not
		move.w	d0,x_pos(a0)			; clip inbounds
		clr.w	x_vel(a0)			; clear vel

	; check for collision with right bound
.nocollidele	move.w	Camera_max_X_pos.w,d0		; check camera max pos
		add.w	#320-$10,d0			;
		cmp.w	x_pos(a0),d0			; check if we are too far
		bgt.s	.nocollideri			; branch if not
		move.w	d0,x_pos(a0)			; clip inbounds
		clr.w	x_vel(a0)			; clear vel

	; check for collision with top bound
.nocollideri	move.w	Camera_min_Y_pos.w,d0		; check camera min pos
		add.w	#(_flydwnmaxyp/2)-8,d0		; offset for some room
		cmp.w	_flyhome(a0),d0			; check if we are too far
		blt.s	.nocollidetop			; branch if not
		move.w	d0,_flyhome(a0)			; clip inbounds
		clr.w	_flyhomevel(a0)			; clear vel

		cmp.w	y_pos(a0),d0			; check if we are too far
		blt.s	.nocollidetop			; branch if not
		move.w	d0,y_pos(a0)			; clip inbounds

	; check for collision with bottom bound
.nocollidetop	move.w	Camera_max_Y_pos.w,d0		; check camera min pos
		add.w	#224-$0A,d0			; offset for some room
		cmp.w	_flyhome(a0),d0			; check if we are too far
		bgt.s	.nocollidebot			; branch if not
		move.w	d0,_flyhome(a0)			; clip inbounds
		clr.w	_flyhomevel(a0)			; clear vel

		cmp.w	y_pos(a0),d0			; check if we are too far
		bgt.s	.nocollidebot			; branch if not
		move.w	d0,y_pos(a0)			; clip inbounds
; ---------------------------------------------------------------------------

	; check for collision between the 2 devices
.nocollidebot;	move.w	parent3(a0),a2			; get the other device to a2
	;	move.w	x_pos(a0),d0			; get x-pos of this to d0
	;	sub.w	x_pos(a2),d0			; sub other device x-pos from d0
	;	add.w	#$18,d0				; add to x-distance
	;	cmp.w	#$18*2,d0			; check if we are in area
	;	bhs.s	.nocollideother			; branch if no collision happens

	;	move.w	y_pos(a0),d0			; get y-pos of this to d0
	;	subq.w	#6,d0				; align to the propeller
	;	sub.w	y_pos(a2),d0			; sub other device y-pos from d0
	;	cmp.w	#_carrydist+$18,d0		; check if we collide with other player
	;	bhs.s	.nocollideother			; branch if no collision happens

	;	move.w	parent(a2),a3			; get object to a3
	;	bclr	#1,status(a2)			; no hold anymore
	;	clr.b	object_control(a3)		; stop object control

	;	move.w	a0,a2				; copy this object to a2
	;	move.w	a3,a0				; copy other player to a0
	;	jsr	HurtCharacter			; hurt player
	;	move.w	a2,a0				; copy object back
; ---------------------------------------------------------------------------

	; wrap up code execution
.nocollideother	move.w	x_pos(a0),x_pos(a1)		; copy x-pos
		move.w	y_pos(a0),y_pos(a1)		; copy y-pos
		add.w	#_carrydist,y_pos(a1)		; align with carrypos

		addq.w	#_carryxoff,x_pos(a1)		; offset x-pos
		btst	#0,_flip(a0)			; check if facing left instead
		beq.s	.noleft				; if not, branch
		subq.w	#_carryxoff*2,x_pos(a1)		; offset the other way

.noleft		move.b	status(a1),_flip(a0)		; copy status from player. Makes sure it updates 1 frame late
		jmp	Obj_Shield_Display		; display (interlace)
; ---------------------------------------------------------------------------

Map_FloatDevice:
	dc.w .sonic-Map_FloatDevice, .tails-Map_FloatDevice

.tails	dc.w 2		; Tails
	dc.w $F409, $5A0, $FFF4
	dc.w $EC0C, AT_PR, $FFF0

.sonic	dc.w 2		; Sonic
	dc.w $F40D, $5A6, $FFF0
	dc.w $EC0C, AT_PR, $FFF0
