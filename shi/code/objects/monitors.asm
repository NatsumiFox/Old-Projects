mon_fallflag =	oboff3C

Obj_Monitor:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.i(pc,d0.w),d1
		jmp	.i(pc,d1.w)

; ---------------------------------------------------------------------------
.i		dc.w .init-.i
		dc.w .main-.i
		dc.w Obj_MonitorDestroy-.i
		dc.w Obj_MonitorAni-.i
		dc.w Obj_MonitorDisp-.i
; ---------------------------------------------------------------------------

.init		addq.b	#2,routine(a0)			; set to next routine
		move.b	#$F,yrad(a0)
		move.b	#$F,xrad(a0)
		move.l	#Map_Monitor,mappings(a0)
		move.w	#$564,tile(a0)
		ori.b	#4,render(a0)			; set to render in level
		move.w	#priority3,priority(a0)
		move.b	#$E,width(a0)
		move.b	#$10,height(a0)

		move.w	respawn(a0),d0			; get respawn index
		beq.s	.normal				; branch if null
		movea.w	d0,a2
		btst	#0,(a2)
		beq.s	.normal				; branch if not destroyed
		move.b	#$B,frame(a0)			; set to broken frame
		move.l	#ChkDispObjLoaded,(a0)		; only display this object
		rts

.normal		move.b	#$40|0,collision(a0)		; set collision type
		move.b	subtype(a0),anim(a0)		; subtype to anim ID

.main		bsr.s	Obj_MonitorFall
		move.w	#25,d1				; get monitors width
		move.w	#16,d2				; get monitors height
		move.w	d2,d3				; copy height
		addq.w	#1,d3				; add 1 to it
		move.w	xpos(a0),d4			; get current xpos
		lea	Object_RAM.w,a1			; main player
		moveq	#3,d6				; Sonic standing bit

		movem.l	d1-d4,-(sp)
		bsr.w	SolidObj_MonMain
		movem.l	(sp)+,d1-d4

		lea	Obj_player_2.w,a1		; sidekick
		moveq	#4,d6				; Tails standing bit
		jsr	SolidObj_MonSide(pc)

		jsr	AddToCollResponseList.w		; add to collision response list
		lea	Ani_Monitor(pc),a1
		jsr	AnimateSprite.w			; animate the object

Obj_MonitorDisp:
		jmp	ChkDispObjLoaded.w		; display the object and despawn if offscreen
; ---------------------------------------------------------------------------

Obj_MonitorAni:
		cmpi.b	#$B,frame(a0)			; is displaying monitor frame
		bne.s	.doani				; branch if not
		move.l	#Obj_MonitorDisp,(a0)		; only display

.doani		lea	Ani_Monitor(pc),a1
		jsr	AnimateSprite.w			; animate the object
		jmp	ChkDispObjLoaded.w		; display the object and despawn if offscreen
; ---------------------------------------------------------------------------

Obj_MonitorFall:
		tst.b	mon_fallflag(a0)
		beq.s	.rts				; branch if monitor should not fall
		btst	#1,render(a0)
		bne.s	.fallup				; branch if y-flipped

		jsr	ObjectFall.w			; make the object fall
		tst.w	yvel(a0)
		bmi.s	.rts				; if speed is negative, branch (moving up)
		jsr	ObjChkFloorDist.w		; get the floor distance
		tst.w	d1
		beq.s	.stop
		bpl.s	.rts

.stop		add.w	d1,ypos(a0)			; add floor height to ypos
		clr.w	yvel(a0)			; clear y-velocity
		clr.b	mon_fallflag(a0)		; make monitor not fall
		rts
; ---------------------------------------------------------------------------

.fallup		bsr.w	ObjectMove			; move object
		subi.w	#$38,yvel(a0)			; make it fall faster
		tst.w	yvel(a0)
		bpl.s	.rts				; branch if moving down

		jsr	ObjChkCeilingDist_Up.w		; get the ceiling distance
		tst.w	d1
		beq.s	.stop2
		bpl.s	.rts

.stop2		sub.w	d1,ypos(a0)			; sub floor height from ypos
		clr.w	yvel(a0)			; clear y-velocity
		clr.b	mon_fallflag(a0)		; make monitor not fall
.rts		rts
; ---------------------------------------------------------------------------

SolidObj_MonMain:
		btst	d6,status(a0)
		bne.s	SolidObj_MonOnTop		; branch if player is standing on this obj
		cmpi.b	#2,anim(a1)
		beq.s	.rts				; branch if rolling
		cmpi.b	#2,charnum(a1)
		bne.s	.0				; branch if not Knuckles
		cmpi.b	#1,jumpmove(a1)
		beq.s	.rts
		cmpi.b	#3,jumpmove(a1)
		bne.s	.0
.rts		rts
.0		jmp	SolidObj2_ChkColls.w
; ---------------------------------------------------------------------------

SolidObj_MonSide:
		btst	d6,status(a0)
		bne.s	SolidObj_MonOnTop		; branch if player is standing on this obj
		jmp	SolidObj2_ChkColls.w
; ---------------------------------------------------------------------------
; input:
; d1 = monitor's width
; d2 = monitor's height
; d3 = monitor's height(?)
; d4 = x-pos of monitor
; d6 = Player standing on object bit
; a1 = Player address
; ---------------------------------------------------------------------------
SolidObj_MonOnTop:
		move.w	d1,d2				; copy monitors width
		add.w	d2,d2				; double width
		btst	#1,status(a1)
		bne.s	.notonmon			; branch if Player is on air

		move.w	xpos(a1),d0			; get xpos of the Player
		sub.w	xpos(a0),d0			; sub xpos of the monitor
		add.w	d1,d0				; add width to d0
		bmi.s	.notonmon			; if negative, we are beyond left edge
		cmp.w	d2,d0				; compare with 2x width
		blo.s	.isstanding			; branch if we are not beyond right edge

.notonmon	bclr	#3,status(a1)			; clear standing on object for Player
		bset	#1,status(a1)			; make player be in air
		bclr	d6,status(a0)			; clear player standing on this object
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

.isstanding	move.w	d4,d2				; copy xpos to d2
		jsr	MvPlayerOnPtfm(pc)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

Obj_MonitorDestroy:
		move.b	status(a0),d0			; get status bit fields
		andi.b	#$78,d0				; get only pushing and standing bits
		beq.s	.spawnico			; if none are set, branch

		move.b	d0,d1				; copy it
		andi.b	#$28,d1				; check if it was main player
		beq.s	.notmain			; if not, branch
		andi.b	#$D7,Object_RAM+status.w	; clear pushing and standing on object flags
		ori.b	#2,Object_RAM+status.w		; set in air bits

.notmain	andi.b	#$50,d0				; check if it was sidekick
		beq.s	.spawnico			; if not, branch
		andi.b	#$D7,Obj_player_2+status.w	; clear pushing and standing on object flags
		ori.b	#2,Obj_player_2+status.w	; set in air bits

.spawnico	andi.b	#3,status(a0)			; keep only
		clr.b	collision(a0)			; clear collision
		jsr	CreateObjectAfter.w		; attempt to create new object
		bne.s	.spawnexplo			; if failed, branch

		move.l	#Obj_MonContents,(a1)		; create monitor contents
		move.w	xpos(a0),xpos(a1)		; copy xpos
		move.w	ypos(a0),ypos(a1)		; copy ypos
		move.b	anim(a0),anim(a1)		; copy animation number
		move.b	render(a0),render(a1)		; copy render flags
		move.b	status(a0),status(a1)		; copy status bitfield
		move.w	parent(a0),parent(a1)		; copy parent(?)

.spawnexplo	jsr	CreateObjectAfter.w		; attempt to create new object
		bne.s	.break				; if failed, branch
		move.l	#Obj_Explosion,(a1)		; create explosion objecg
		addq.b	#2,routine(a1)			; next routine
		move.w	xpos(a0),xpos(a1)		; copy xpos
		move.w	ypos(a0),ypos(a1)		; copy ypos

.break		move.w	respawn(a0),d0			; get respawn index
		beq.s	.norespawn			; if null, branch
		movea.w	d0,a2				; get it to a2
		bset	#0,(a2)				; set as destroyed

.norespawn	cmp.b	#3,anim(a0)
		bne.s	.dis
	; spawn 3 rings
		moveq	#3-1,d2
		lea	Monitor_RingTbl(pc),a2
		move.w	xpos(a0),d5			; copy x-position
		move.w	ypos(a0),d6			; copy y-position
		move.l	#Map_Ring,d3			; get ring mappings
		st	SpillRing_Anim_Counter.w	; reset animation counter

		move.l	#Obj_AttractedRing,d4
		btst	#5,Object_RAM+shistatus.w
		bne.s	.spa				; branch if we have lightning shield
		move.l	#Obj_LostRing,d4
		tst.w	ReverseGravity_Flag.w
		beq.s	.spa				; branch if reverse gravity isnt active
		move.l	#Obj_LostRing_RevGrav,d4

.spa		jsr	CreateObjectAfter.w
		bne.s	.dis
		move.l	d4,(a1)				; set object ID
		move.l	d3,mappings(a1)			; set mappings
		move.w	#$8402,render(a1)		; set stuff
		move.w	#priority3,priority(a1)		; set priority
		move.w	#$808,yrad(a1)			; set radius
		move.w	d5,xpos(a1)			; copy x-position
		move.w	d6,ypos(a1)			; copy y-position
		move.b	#$40|1,collision(a1)		; set collision index
		move.b	#8,width(a1)			; set object width
		move.l	(a2)+,xvel(a1)			; set velocity
		dbf	d2,.spa

.dis		move.b	#$A,anim(a0)			; set animation to breaking ani
		move.l	#Obj_MonitorAni,(a0)		; animate the monitor
		jmp	DrawSprite.w			; display the sprite

; ---------------------------------------------------------------------------
Monitor_RingTbl:
	dc.w $0000, -$380
	dc.w $0180, -$300
	dc.w -$180, -$300
; ---------------------------------------------------------------------------

Obj_MonContents:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.i(pc,d0.w),d1
		jmp	.i(pc,d1.w)

; ---------------------------------------------------------------------------
.i		dc.w .init-.i
		dc.w .main-.i
		dc.w Obj_MonCont_WaitDel-.i
; ---------------------------------------------------------------------------

.init		addq.b	#2,routine(a0)			; next routine
		move.w	#$8564,tile(a0)
		ori.b	#$24,render(a0)			; set to render in level and direct mappings mode
		move.w	#priority3,priority(a0)
		move.b	#8,width(a0)
		move.w	#-$300,yvel(a0)			; move up
		btst	#1,render(a0)
		beq.s	.noyflip			; branch if not y-flipped
		neg.w	yvel(a0)			; move down

.noyflip	moveq	#0,d0
		move.b	anim(a0),d0			; get anim number
		addq.b	#1,d0				; add 1
		move.b	d0,frame(a0)			; set to map frame

		movea.l	#Map_Monitor,a1			; get monitor maps
		add.b	d0,d0				; double d0
		adda.w	(a1,d0.w),a1			; get the address of the map frame
		addq.w	#2,a1				; add 2 to it (skips piece amount)
		move.l	a1,mappings(a0)			; set as the mappings

.main		jsr	DrawSprite.w
; ---------------------------------------------------------------------------

sub_1D820:
		btst	#1,render(a0)
		bne.s	.fallup				; branch if we should fall up
		tst.w	yvel(a0)
		bpl.s	.getcontents			; if we are moving up, remove the contents
		jsr	ObjectMove.w			; move object
		addi.w	#$18,yvel(a0)			; fall down
		rts

.fallup		tst.w	yvel(a0)
		bmi.w	.getcontents			; if we are moving down, remove the contents
		jsr	ObjectMove.w			; move object
		subi.w	#$18,yvel(a0)			; fall up
		rts
; ---------------------------------------------------------------------------

.getcontents	addq.b	#2,routine(a0)			; get next routine
		move.w	#30-1,anitime(a0)		; set wait timer
		movea.w	parent(a0),a1			; get parent

		lea	Monitors_Broken.w,a2
		moveq	#0,d0
		move.b	anim(a0),d0			; get animation ID
		add.w	d0,d0				; double it
		move.w	.i(pc,d0.w),d0
		jmp	.i(pc,d0.w)			; use it to jump to appropriate code

; ---------------------------------------------------------------------------
.i		dc.w .eggman-.i
		dc.w .1up-.i
		dc.w .eggman-.i
		dc.w .rings-.i
		dc.w .sneakers-.i
		dc.w .fire-.i
		dc.w .lightning-.i
		dc.w .bubble-.i
		dc.w .invis-.i
		dc.w Monitor_Give_SuperSonic-.i
; ---------------------------------------------------------------------------

.eggman		addq.w	#1,(a2)
		jmp	TryHurtPlayer			; try to hurt the player
; ---------------------------------------------------------------------------

.1up		rts
; ---------------------------------------------------------------------------

.rings		addq.w	#1,(a2)

		lea	Ring_Count.w,a2			; get ring count
		lea	Update_HUD_Rings.w,a3		;
		lea	Get_Extra_Life_Flag.w,a4	; extra life flags
		lea	Total_Rings_Collected.w,a5	; total collected rings

		addi.w	#10,(a5)			; add 10 rings
		cmpi.w	#999,(a5)
		blo.s	.nomax1				; if less than 999 rings, branch
		move.w	#999,(a5)			; cap to 999

.nomax1		addi.w	#10,(a2)			; add 10 rings
		cmpi.w	#999,(a2)
		blo.s	.nomax2				; if less than 999 rings, branch
		move.w	#999,(a2)			; cap to 999

.nomax2		ori.b	#1,(a3)				; update ring count
		moveq	#$33,d0
		jmp	PlayMusic			; play ring SFX
; ---------------------------------------------------------------------------

.sneakers	addq.w	#1,(a2)
		bset	#2,shistatus(a1)		; set speed shoes flag
		move.b	#150,speedtime(a1)		; set speed shoes timer
		move.w	#$C00,Player1_TopSpeed.w
		move.w	#$18,Player1_Acceleration.w
		move.w	#$80,Player1_Deceleration.w

.playtempo	moveq	#8,d0
		jmp	PlayTempo			; play tempo
; ---------------------------------------------------------------------------

.fire		addq.w	#1,(a2)
		andi.b	#$8E,shistatus(a1)		; clear shields flags
		or.b	#$11,shistatus(a1)		; activate fire shield
		moveq	#$3E,d0

		tst.b	Super_Flag.w
		bne.s	.play
		move.l	#Obj_Fire_Shield,Obj_shield.w	; set shield type to fire shield
		move.w	a1,Obj_shield+parent.w		; set parent object

.play		jmp	PlayMusic.w			; play shield got sfx
; ---------------------------------------------------------------------------

.lightning	addq.w	#1,(a2)
		andi.b	#$8E,shistatus(a1)		; clear shields flags
		or.b	#$21,shistatus(a1)		; activate lightning shield
		moveq	#$41,d0

		tst.b	Super_Flag.w
		bne.s	.play
		move.l	#Obj_Lightning_Shield,Obj_shield.w; set shield type to lightning shield
		move.w	a1,Obj_shield+parent.w		; set parent object
		bra.s	.play
; ---------------------------------------------------------------------------

.bubble		addq.w	#1,(a2)
		andi.b	#$8E,shistatus(a1)		; clear shields flags
		or.b	#$41,shistatus(a1)		; activate bubble shield
		moveq	#$3F,d0

		tst.b	Super_Flag.w
		bne.s	.play
		move.l	#Obj_Bubble_Shield,Obj_shield.w	; set shield type to bubble shield
		move.w	a1,Obj_shield+parent.w		; set parent object
		bra.s	.play
; ---------------------------------------------------------------------------

.invis		rts

; ---------------------------------------------------------------------------

Monitor_Give_SuperSonic:
		addq.w	#1,(a2)
		addi.w	#50,Ring_Count.w			; increase ring count

Monitor_Give_SuperSonic_2:
		move.b	#1,Super_PalCycle_Flag.w
		move.b	#$F,Super_PalCycle_Timer.w
		move.b	#1,Super_Flag.w
		move.w	#60,Super_SecondCounter.w
		move.w	#$800,Player1_TopSpeed.w
		move.w	#$18,Player1_Acceleration.w
		move.w	#$C0,Player1_Deceleration.w
		move.b	#$1F,Object_RAM+anim.w

		cmpi.w	#2,Player_Mode.w
		bne.s	.notTailsAlone				; branch if not Tails
		clr.b	Super_Flag.w				; clear super sonic flag
		move.b	#1,Super_Tails_Flag.w			; set super tails flag
		move.b	#$29,Object_RAM+anim.w
		move.w	#$800,Player2_TopSpeed.w
		move.w	#$18,Player2_Acceleration.w
		move.w	#$C0,Player2_Deceleration.w
		move.l	#Obj_HyperTails_Birds,Obj_shield.w
		bra.s	.common
; ---------------------------------------------------------------------------

.notTailsAlone	bhs.s	.KnuxAlone				; branch if Knuckles alone
; Sonic alone or Sonic & Tails
		move.l	#Map_SuperSonic,Object_RAM+mappings.w	; set super mappings
		st	Super_Flag.w				; set to hyper(?)
		move.w	#$A00,Player1_TopSpeed.w
		move.w	#$30,Player1_Acceleration.w
		move.w	#$100,Player1_Deceleration.w
		move.l	#Obj_HyperSonic_19348,Obj_shield.w
		move.l	#Obj_HyperSonicKnux_Trail,Obj_super_stars.w
		bra.s	.common

.KnuxAlone	move.l	#Obj_HyperSonicKnux_Trail,Obj_super_stars.w
		st	Super_Flag.w				; set to hyper(?)
.common		move.b	#$81,Object_RAM+Carried.w
		clr.b	Object_RAM+invistime.w			; clear invinciblity time
		bset	#1,shistatus(a1)			; set invinciblity status

		_moveq	$9F,d0
		jsr	PlaySFX.w
		moveq	#Mus_Super,d0
		jmp	PlayMusic.w
; ---------------------------------------------------------------------------

Obj_MonCont_WaitDel:
		subq.w	#1,anitime(a0)				; sub 1 from timer
		bmi.w	DeleteObject_This			; if negative, delete
		jmp	DrawSprite.w				; else display

; ---------------------------------------------------------------------------
Ani_Monitor:	include "levels/common/Monitors/ani.asm"
Map_Monitor:	include "levels/common/Monitors/map.asm"
; ---------------------------------------------------------------------------
