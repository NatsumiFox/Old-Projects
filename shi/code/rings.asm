
LoadRings:
		moveq	#0,d0
		move.b	Rings_Manager_Routine.w,d0
		move.w	.i(pc,d0.w),d0
		jmp	.i(pc,d0.w)

; ---------------------------------------------------------------------------
.i	dc.w .init-.i, LoadRings_Main-.i
; ---------------------------------------------------------------------------

.init		addq.b	#2,Rings_Manager_Routine.w	; next routine
		bsr.w	sub_EB1A

		movea.l	Ring_start_addr_ROM.w,a1
		lea	Ring_Status_Table.w,a2
		move.w	Camera_X.w,d4
		subq.w	#8,d4
		bhi.s	.0
		moveq	#1,d4
		bra.s	.0

.1		addq.w	#4,a1
		addq.w	#2,a2
.0		cmp.w	(a1),d4
		bhi.s	.1

		move.l	a1,Ring_start_addr_ROM.w
		move.w	a2,Ring_start_addr_RAM.w	; store address to RAM
		addi.w	#$150,d4
		bra.s	.2

.3		addq.w	#4,a1
.2		cmp.w	(a1),d4
		bhi.s	.3
		move.l	a1,Ring_end_addr_ROM.w		; store end address
		rts

; ---------------------------------------------------------------------------

LoadRings_Main:
		bsr.s	sub_E994
		movea.l	Ring_start_addr_ROM.w,a1
		movea.w	Ring_start_addr_RAM.w,a2
		move.w	Camera_X.w,d4
		subq.w	#8,d4
		bhi.s	.0
		moveq	#1,d4
		bra.s	.0

.1		addq.w	#4,a1
		addq.w	#2,a2
.0		cmp.w	(a1),d4
		bhi.s	.1
		bra.s	.2

.3		subq.w	#4,a1
		subq.w	#2,a2
.2		cmp.w	-4(a1),d4
		bls.s	.3

		move.l	a1,Ring_start_addr_ROM.w
		move.w	a2,Ring_start_addr_RAM.w
		movea.l	Ring_end_addr_ROM.w,a2
		addi.w	#$150,d4
		bra.s	.4

.5		addq.w	#4,a2
.4		cmp.w	(a2),d4
		bhi.s	.5
		bra.s	.6

.7		subq.w	#4,a2
.6		cmp.w	-4(a2),d4
		bls.s	.7
		move.l	a2,Ring_end_addr_ROM.w
		rts
; ---------------------------------------------------------------------------

sub_E994:
		lea	Ring_consumption_count.w,a2
		move.w	(a2)+,d1		; get ring count
		subq.w	#1,d1			; sub 1 from it
		blo.s	sub_E994_rts		; branch if lower than 0?

.loop		move.w	(a2)+,d0
		beq.s	.loop
		movea.w	d0,a1

		subq.b	#1,(a1)
		bne.s	.is0
		move.b	#6,(a1)
		addq.b	#1,1(a1)
		cmpi.b	#12,1(a1)
		bne.s	.is0
		move.w	#-1,(a1)
		clr.w	-2(a2)
		subq.w	#1,Ring_consumption_count.w

.is0		dbf	d1,.loop

sub_E994_rts:
		rts
; ---------------------------------------------------------------------------

TouchResponse_Rings:
		cmpi.b	#$5A,$34(a0)
		bhs.s	sub_E994_rts
		movea.l	Ring_start_addr_ROM.w,a1
		movea.l	Ring_end_addr_ROM.w,a2

		cmpa.l	a1,a2
		beq.s	sub_E994_rts		; if equals, stop trying to test rings
		movea.w	Ring_start_addr_RAM.w,a4
		btst	#5,$2B(a0)
		beq.s	.noattraction		; branch if Sonic does not have lightning shield

		move.w	$10(a0),d2		; get Sonic's X
		move.w	$14(a0),d3		; get Sonic's Y
		subi.w	#$40,d2			; sub 0x40 from X
		subi.w	#$40,d3			; sub 0x40 from Y

		move.w	#6,d1
		move.w	#$C,d6
		move.w	#$80,d4			; set width
		move.w	#$80,d5			; set height
		bra.s	.nextring
; ---------------------------------------------------------------------------

.noattraction	move.w	$10(a0),d2		; get Sonic's X
		move.w	$14(a0),d3		; get Sonic's Y
		subi.w	#8,d2			; sub 8 from X
		moveq	#0,d5			; clear d5
		move.b	$1E(a0),d5		; get height
		subq.b	#3,d5			; sub 3 from height
		sub.w	d5,d3			; sub from height

		move.w	#6,d1
		move.w	#$C,d6
		move.w	#$10,d4			; set width
		add.w	d5,d5			; double height

.nextring	tst.w	(a4)
		bne.w	.chknext
		move.w	(a1),d0			; get X of ring
		sub.w	d1,d0			; offset it
		sub.w	d2,d0			; sub Sonic's X from ring offset X
		bhs.s	.higherx		; if higher than 0, branch
		add.w	d6,d0			; add ring width to d0
		blo.s	.chkY			; if less than 0, branch
		bra.w	.chknext

.higherx	cmp.w	d4,d0			; compare with width
		bhi.w	.chknext		; branch if higher, test failed

.chkY		move.w	2(a1),d0		; this is the same than X check, but for Y
		sub.w	d1,d0
		sub.w	d3,d0
		bhs.s	.highery
		add.w	d6,d0
		blo.s	.chkAttract
		bra.w	.chknext

.highery	cmp.w	d5,d0
		bhi.w	.chknext
.chkAttract	btst	#5,$2B(a0)
		bne.s	.AttractRing		; branch if we had lightning shield

.trygetRing	move.w	#$608,(a4)
		bsr.s	.GetRing
		lea	Ring_consumption_list.w,a3

.0		tst.w	(a3)+
		bne.s	.0
		move.w	a4,-(a3)
		addq.w	#1,Ring_consumption_count.w

.chknext	addq.w	#4,a1
		addq.w	#2,a4
		cmpa.l	a1,a2
		bne.w	.nextring
.rts		rts
; ---------------------------------------------------------------------------

.GetRing	subq.w	#1,Rings_To_Collect.w
		jmp	GiveRing
; ---------------------------------------------------------------------------

.AttractRing	movea.l	a1,a3
		jsr	CreateObject
		bne.w	.failed
		move.l	#Obj_AttractedRing,(a1)
		move.w	(a3),$10(a1)
		move.w	2(a3),$14(a1)
		move.w	a4,$30(a1)
		move.w	#-1,(a4)
		rts
; ---------------------------------------------------------------------------

.failed		movea.l	a3,a1
		bra.s	.trygetRing
; ---------------------------------------------------------------------------

sub_EB1A:
		moveq	#0,d0
	clearRAM Ring_Status_Table, Object_respawn_table-Ring_Status_Table
	clearRAM Ring_consumption_count, Water_Pal_FadeTo-Ring_consumption_count

		lea	('X'<<24)|ML_Rings,a1
		move.l	a1,Ring_start_addr_ROM.w

		addq.w	#4,a1
		moveq	#0,d5
		move.w	#511-1,d0

.chkRings	tst.l	(a1)+
		bmi.s	.notfound
		addq.w	#1,d5
		dbf	d0,.chkRings

.notfound	move.w	d5,Rings_To_Collect.w
		rts
; ---------------------------------------------------------------------------

BuildRings:
		movea.l	Ring_start_addr_ROM.w,a0
		move.l	Ring_end_addr_ROM.w,d2
		sub.l	a0,d2
		beq.s	.rts		; branch if no rings

		movea.w	Ring_start_addr_RAM.w,a4
		lea	Map_Ring+30(pc),a1
		move.w	4(a3),d4
		move.w	#$F0,d5

.loadRings	tst.w	(a4)+
		bmi.s	.nextRing
		move.w	2(a0),d1
		sub.w	d4,d1
		addq.w	#8,d1
		and.w	Screen_Y_wrap_value.w,d1
		cmp.w	d5,d1
		bhs.s	.nextRing

		addi.w	#$78,d1
		move.w	(a0),d0
		sub.w	(a3),d0
		addi.w	#$80,d0
		move.b	-1(a4),d6
		bne.s	.0
		move.b	Ring_Anim_Frame.w,d6

.0		lsl.w	#3,d6
		lea	(a1,d6.w),a2

		move.b	(a2)+,d3
		ext.w	d3
		add.w	d3,d1
		move.w	d1,(a6)+
		move.b	(a2)+,(a6)
		addq.w	#2,a6
		move.w	(a2)+,(a6)+
		add.w	(a2)+,d0
		move.w	d0,(a6)+
		subq.w	#1,d7

.nextRing	addq.w	#4,a0
		subq.w	#4,d2
		bne.s	.loadRings
.rts		rts

; ---------------------------------------------------------------------------
RingTile = 	($D800/32)|$2000
Map_Ring:	include "levels/common/rings/Map.asm"
Ani_Ring:	include "levels/common/rings/Ani Ring.asm"
; ---------------------------------------------------------------------------

Obj_Ring:
		moveq	#0,d0
		move.b	routine(a0),d0			; get routine counter
		move.w	.i(pc,d0.w),d1			; get routine offset
		jmp	.i(pc,d1.w)			; jump to this offset

; ---------------------------------------------------------------------------
.i		dc.w .init-.i
		dc.w .main-.i
		dc.w loc_1A572-.i
		dc.w loc_1A584-.i
		dc.w loc_1A592-.i
; ---------------------------------------------------------------------------

.init		addq.b	#2,routine(a0)			; next routine
		move.l	#Map_Ring,mappings(a0)
		clr.w	tile(a0)
		move.b	#4,render(a0)
		move.w	#priority2,priority(a0)
		move.b	#$40|1,collision(a0)		; set to ring collision
		move.b	#8,width(a0)

.main		move.b	Ring_Anim_Frame.w,frame(a0)	; set mappings frame
		bra.w	DispCollObjLoaded

loc_1A572:
		addq.b	#2,routine(a0)			; next routine
		sf	collision(a0)			; clear collision property
		move.w	#priority1,priority(a0)
		bsr.s	GiveRing			; give player a ring

loc_1A584:
		lea	Ani_Ring,a1
		bsr.w	AnimateSprite
		bra.w	DrawSprite

loc_1A592:
		bra.w	DeleteObject_This
; ---------------------------------------------------------------------------

GiveRing:
		addq.b	#1,Update_HUD_Rings.w
		cmpi.w	#999,Total_Rings_Collected.w
		bhs.s	GiveRing1P			; branch if max rings collected is met
		addq.w	#1,Total_Rings_Collected.w	; add 1 to collected rings

GiveRing1P:
		move.w	#$33,d0				; prepare ring sfx
		cmpi.w	#999,Ring_Count.w
		bhs.s	.ringsfx			; branch if more than or 999 rings
		addq.w	#1,Ring_Count.w			; add 1 to total ring count
.ringsfx	jmp	PlaySFX				; play ring sfx
; ---------------------------------------------------------------------------

Obj_LostRing:
		moveq	#0,d0
		move.b	routine(a0),d0			; get routine counter
		move.w	.i(pc,d0.w),d1			; get routine offset
		jmp	.i(pc,d1.w)			; jump to this offset

; ---------------------------------------------------------------------------
.i		dc.w Obj_LostRing_Init-.i
		dc.w Obj_LostRing_Main-.i
		dc.w Obj_LostRingRev_Collect-.i
		dc.w Obj_LostRingRev_CollectAni-.i
		dc.w Obj_LostRing_Delete-.i
; ---------------------------------------------------------------------------

Obj_LostRing_RevGrav:
		moveq	#0,d0
		move.b	routine(a0),d0			; get routine counter
		move.w	.i(pc,d0.w),d1			; get routine offset
		jmp	.i(pc,d1.w)			; jump to this offset

; ---------------------------------------------------------------------------
.i		dc.w Obj_LostRing_Init-.i
		dc.w Obj_LostRingRev_Main-.i
		dc.w Obj_LostRingRev_Collect-.i
		dc.w Obj_LostRingRev_CollectAni-.i
		dc.w Obj_LostRing_Delete-.i
; ---------------------------------------------------------------------------

Obj_LostRing_Init:
	if debug=1
		sf	Level_Lag_Crash.w
	endif

		move.l	#Obj_LostRing,d6		; get the main lost ring object
		tst.b	ReverseGravity_Flag.w
		beq.s	.norev				; if reverse gravity isn't active, branch
		move.l	#Obj_LostRing_RevGrav,d6	; get the reverse gravity lost ring object

.norev		movea.l	a0,a1				; copy this object to a1
		moveq	#0,d5
		move.w	Ring_Count.w,d5			; get number of rings

		moveq	#16,d0				; get max ring count
		cmp.w	d0,d5
		blo.s	.nomax				; if current ring count is less, branch
		move.w	d0,d5				; get max ring count

.nomax		subq.w	#1,d5				; sub 1 (for dbf)
		move.w	#$288,d4			; set initial angle
		st	SpillRing_Anim_Counter.w	; reset animation counter
		bra.s	.createfirst			; create first ring
; ---------------------------------------------------------------------------

.createnext	jsr	CreateObjectAfter.w		; create object after this one
		bne.w	.skipload			; if could not, branch
.createfirst	move.l	d6,(a1)				; store desired object
		addq.b	#2,routine(a1)			; get next routine

		move.w	#$808,yrad(a1)			; set radius
		move.w	xpos(a0),xpos(a1)		; copy x-position
		move.w	ypos(a0),ypos(a1)		; copy y-position
		move.l	#Map_Ring,mappings(a1)		; set ring mappings
		clr.w	tile(a1)
		move.b	#$84,render(a1)			; set render flags
		move.w	#priority3,priority(a1)		; set priority
		move.b	#$40|1,collision(a1)		; set collision index
		move.b	#8,width(a1)			; set object width

		tst.w	d4
		bmi.s	.noreset			; banch if negative angle
		move.w	d4,d0				; copy angle to d0
		jsr	GetSine				; calc sine and cosine

		move.w	d4,d2				; copy angle
		lsr.w	#8,d2				; shift right 8 bits
		asl.w	d2,d0				; shift left d2 times
		asl.w	d2,d1				; shift left d2 times
		move.w	d0,d2				; copy d0 answer to d2
		move.w	d1,d3				; copy d1 answer to d3

		addi.b	#$10,d4				; add 16 to angle
		bhs.s	.noreset			; branch if angle > 0
		subi.w	#$80,d4				; sub 128 from angle
		bhs.s	.noreset			; branch if angle > 0
		move.w	#$288,d4			; reset angle

.noreset	move.w	d2,xvel(a1)			; set x-velocity
		move.w	d3,yvel(a1)			; set y-velocity
		neg.w	d2				; negate x-velocity
		neg.w	d4				; negate angle
		dbf	d5,.createnext			; keep looping until done

.skipload	moveq	#$FFFFFFB9,d0
		jsr	PlaySFX				; play ring loss sound effect
		move.w	#0,Ring_Count.w			; clear ring count
		move.b	#$80,Update_HUD_Rings.w		; update the HUD ring count
		move.b	#0,Get_Extra_Life_Flag.w	; clear extra life flag?

	if debug=1
		st	Level_Lag_Crash.w
	endif

		tst.b	ReverseGravity_Flag.w
		bne.w	Obj_LostRingRev_Main		; branch if reverse gravity

Obj_LostRing_Main:
		move.b	SpillRing_Anim_Frame.w,frame(a0); get correct mappings frame
		bsr.w	ObjectMove			; move this object
		addi.w	#$18,yvel(a0)			; apply gravity
		bmi.s	.render				; branch if negative
		tst.b	render(a0)
		bpl.s	.skipfloor			; if offscreen, let fall off?

		jsr	RingChkFloorDist		; get floor distance
		tst.w	d1
		bpl.s	.skipfloor			; if d1 is positive, skip
		add.w	d1,ypos(a0)			; add d1 to ypos
		move.w	yvel(a0),d0			; get y-velocity
		asr.w	#2,d0				; shift right twice
		sub.w	d0,yvel(a0)			; sub that from velocity (slow down)
		neg.w	yvel(a0)			; negate

.skipfloor	tst.b	SpillRing_Anim_Counter.w
		beq.s	Obj_LostRing_Delete		; if spill timer is 0, delete object
		move.w	Camera_max_Y.w,d0		; get y-boundary of level
		addi.w	#224,d0				; add screen height to it
		cmp.w	ypos(a0),d0			; compare with current y-position
		blo.s	Obj_LostRing_Delete		; if below, get rid of the ring

.render		jsr	AddToCollResponseList.w		; make this object collidable
		bra.w	DrawSprite			; render this sprite
; --------------------------------------------------------------------------

Obj_LostRingRev_Collect:
		addq.b	#2,routine(a0)			; go to animation routine
		sf	collision(a0)			; set to have no collision
		move.w	#priority1,priority(a0)		; set priority
		bsr.w	GiveRing			; give Sonic a ring

Obj_LostRingRev_CollectAni:
		lea	Ani_Ring,a1			; get ring animation
		bsr.w	AnimateSprite			; animate it
		bra.w	DrawSprite			; and finally display

Obj_LostRing_Delete:
		bra.w	DeleteObject_This
; --------------------------------------------------------------------------

Obj_LostRingRev_Main:
		move.b	SpillRing_Anim_Frame.w,frame(a0); get correct mappings frame
		bsr.w	ObjectRevMove			; move this object
		addi.w	#$18,yvel(a0)			; apply gravity
		bmi.s	.render				; branch if negative

		tst.b	render(a0)
		bpl.s	.skipfloor			; if offscreen, let fall off?

		jsr	RingRevChkFloorDist		; get floor distance
		tst.w	d1
		bpl.s	.skipfloor			; if d1 is positive, skip
		sub.w	d1,ypos(a0)			; sub d1 from ypos
		move.w	yvel(a0),d0			; get y-velocity
		asr.w	#2,d0				; shift right twice
		sub.w	d0,yvel(a0)			; sub that from velocity (slow down)
		neg.w	yvel(a0)			; negate

.skipfloor	tst.b	SpillRing_Anim_Counter.w
		beq.s	Obj_LostRing_Delete		; if spill timer is 0, delete object
		move.w	Camera_max_Y.w,d0		; get y-boundary of level
		addi.w	#224,d0				; add screen height to it
		cmp.w	ypos(a0),d0			; compare with current y-position
		blo.s	Obj_LostRing_Delete		; if below, get rid of the ring

.render		jsr	AddToCollResponseList.w		; make this object collidable
		bra.w	DrawSprite			; render this sprite
; --------------------------------------------------------------------------

Obj_AttractedRing:
		move.l	#Map_Ring,mappings(a0)		; set ring mappings
		clr.w	tile(a0)
		move.b	#4,render(a0)			; set render flags
		move.w	#priority2,priority(a0)		; set priority
		move.b	#$40|1,collision(a0)		; set collision index
		move.b	#8,width(a0)			; set object width
		move.b	#8,height(a0)			; set object height
		move.b	#8,yrad(a0)			; set x-radius
		move.b	#8,xrad(a0)			; set y-radius
		clr.b	routine(a0)			; clear routine
		move.l	#.main,(a0)			; set this objects address

.main		tst.b	routine(a0)
		bne.s	AttractedRing_GiveRing		; if routine is not 0, then we make Sonic collect this ring
		bsr.w	AttractedRing_Move		; move the ring around
		btst	#5,Object_RAM+shistatus.w
		bne.s	.noshield			; branch if we have lightning shield

		move.l	#Obj_LostRing,(a0)		; make this ring lost
		move.b	#2,routine(a0)			; set routine num
		sf	SpillRing_Anim_Counter.w	; reset animation counter

.noshield	subq.b	#1,anitime(a0)			; sub 1 from the timer
		bpl.s	.noani				; branch if timer is left
		move.b	#3,anitime(a0)			; set animation timer
		addq.b	#1,frame(a0)			; get next ring frame
		andi.b	#3,frame(a0)			; keep in range

.noani		jsr	AddToCollResponseList.w		; make this object collidable
		bra.w	DrawSprite			; render this sprite
; ---------------------------------------------------------------------------

AttractedRing_GiveRing:
		sf	collision(a0)			; make this not collide
		move.w	#priority1,priority(a0)		; set priority
		subq.w	#1,Rings_To_Collect.w		; sub 1 from all rings in level
		bsr.w	GiveRing			; give single ring
		move.l	#.waitkill,(a0)			; set new object
		sf	routine(a0)			; clear routine counter

.waitkill	tst.b	routine(a0)
		bne.s	.del				; if routine counter isnt 0, delete
		lea	Ani_Ring,a1			; get animation
		bsr.w	AnimateSprite			; animate the sprite

		bra.w	DrawSprite			; render this sprite
.del		bra.w	DeleteObject_This		; delete this object
; ---------------------------------------------------------------------------

AttractedRing_Move:
		move.w	#$30,d1				; set speed to move on
		move.w	Object_RAM+xpos.w,d0		; get x-position of player
		cmp.w	xpos(a0),d0			; compare with rings xpos
		bhs.s	.forwards			; if higher, branch
		neg.w	d1				; negate sped

		tst.w	xvel(a0)
		bmi.s	.xspeedgot			; brach if going towards player
		add.w	d1,d1
		add.w	d1,d1				; quadruple speed
		bra.s	.xspeedgot

.forwards	tst.w	xvel(a0)
		bpl.s	.xspeedgot			; brach if going towards player
		add.w	d1,d1
		add.w	d1,d1				; quadruple speed
.xspeedgot	add.w	d1,xvel(a0)			; add speed

		move.w	#$30,d1				; set speed to move on
		move.w	Object_RAM+ypos.w,d0		; get y-position of player
		cmp.w	ypos(a0),d0			; compare with rings ypos
		bhs.s	.downwards			; if higher, branch
		neg.w	d1				; negate sped

		tst.w	yvel(a0)
		bmi.s	.yspeedgot			; brach if going towards player
		add.w	d1,d1
		add.w	d1,d1				; quadruple speed
		bra.s	.yspeedgot

.downwards	tst.w	yvel(a0)
		bpl.s	.yspeedgot			; brach if going towards player
		add.w	d1,d1
		add.w	d1,d1				; quadruple speed

.yspeedgot	add.w	d1,yvel(a0)			; add speed
		jmp	ObjectMove			; move
; ---------------------------------------------------------------------------
loc_1A9EE:
		moveq	#0,d0
		move.b	routine(a0),d0			; get routine counter
		move.w	.i(pc,d0.w),d1			; get routine offset
		jmp	.i(pc,d1.w)			; jump to this offset

; ---------------------------------------------------------------------------
.i		dc.w .main-.i
		dc.w .draw-.i
		dc.w .del-.i
; ---------------------------------------------------------------------------

.main		moveq	#0,d1
		move.w	oboff3C(a0),d1
		swap	d1
		move.l	oboff34(a0),d0
		sub.l	d1,d0
		asr.l	#4,d0
		sub.l	d0,oboff34(a0)
		move.w	oboff34(a0),xpos(a0)

		moveq	#0,d1
		move.w	oboff3E(a0),d1
		swap	d1
		move.l	oboff38(a0),d0
		sub.l	d1,d0
		asr.l	#4,d0
		sub.l	d0,oboff38(a0)
		move.w	oboff38(a0),ypos(a0)

		lea	Ani_Ring+2(pc),a1		; get animation
		bsr.w	AnimateSprite			; animate the sprite
		subq.w	#1,oboff40(a0)
		bne.w	DrawSprite			; if false, render this sprite

		movea.l	oboff2E(a0),a1
		subq.w	#1,(a1)
		bsr.w	GiveRing			; give player a ring
		addi.b	#2,routine(a0)			; increment to next routine

.draw		lea	Ani_Ring(pc),a1			; get animation
		bsr.w	AnimateSprite			; animate the sprite
		bra.w	DrawSprite			; render this sprite
.del		bra.w	DeleteObject_This		; delete this object

; ---------------------------------------------------------------------------

ChangeRingFrame:
		subq.b	#1,Ring_Anim_Counter.w
		bpl.s	.nochange
		move.b	#4-1,Ring_Anim_Counter.w
		addq.b	#1,Ring_Anim_Frame.w
		andi.b	#7,Ring_Anim_Frame.w

.nochange	tst.b	SpillRing_Anim_Counter.w
		beq.s	.nospillring
		moveq	#0,d0
		move.b	SpillRing_Anim_Counter.w,d0
		add.w	SpillRing_Anim_Accum.w,d0
		move.w	d0,SpillRing_Anim_Accum.w

		rol.w	#7,d0
		andi.w	#7,d0
		move.b	d0,SpillRing_Anim_Frame.w
		subq.b	#1,SpillRing_Anim_Counter.w

.nospillring	rts
; ---------------------------------------------------------------------------
