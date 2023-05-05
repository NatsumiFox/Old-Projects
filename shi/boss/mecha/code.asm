Mecha_Power =		subtype	; the amount of power mecha has. Some moves are limited by it. only a byte!!!
Mecha_Misc =		oboff2E	; used for various things
Mecha_Child1 =		oboff30	; the first child object this boss may have for various moves.
		rsreset
Mecha_M_Teleport	rs.b 1; Teleportation move
Mecha_M_BigFireBall	rs.b 1; Big fireball move
Mecha_M_AirDash		rs.b 1; Air Dash move
Mecha_M_MoveInAir	rs.b 1; Air Move Left or Right move
Mecha_M_FlyUp		rs.b 1; Fly back up
Mecha_M_Spindash	rs.b 1; Spindash move
Mecha_M_Run		rs.b 1; Running move
Mecha_M_Jump		rs.b 1; Jumping move

Mecha_Hits =		1
Mecha_TP_Gap =		$40
Mecha_TP_Dist =		$80
Mecha_FB_Yoff =		-46
Mecha_FB_Xoff =		20
Mecha_FB_Dist =		50
Mecha_FB_Dist2 =	100
Mecha_FB_MulSpd =	-$500
Mecha_MIA_MaxSpd =	$500
Mecha_MIA_Accel =	14
Mecha_MIA_Decel =	$20
Mecha_Dash_Speed =	$A00
Mecha_Dash_Decel =	$40
Mecha_DR_Range =	$60
Mecha_Run_Speed =	$600
Mecha_SP_Decel =	$22
Mecha_SP_Speed =	$700
Mecha_SP_Range =	-$20
Mecha_Jump_YSpeed =	-$500
Mecha_Jump_XSpeed =	$400
; ---------------------------------------------------------------------------
; The big fireball Mecha Sonic shoots.
; ---------------------------------------------------------------------------
Mecha_Blast_Dat:
		dc.b $80|5			; collision
		tribyte Mecha_Blast_FollowMecha	; object address
		dc.b $84, 0, 40, 40		; render, subtype, height, width
		dc.w priority4, $2463		; priority, tile
		dc.b $16			; frame
		tribyte Boss_Mecha_Misc		; mappings
; ---------------------------------------------------------------------------

Mecha_Blast:
		move.w	a0,a2			; copy a0 to a2
		lea	Mecha_Blast_Dat(pc),a1	; get the object data to a1
		move.b	(a1),collision(a2)	; set collision
		move.l	(a1)+,(a2)+		; set routine
		move.l	(a1)+,(a2)+		; set misc data
		move.l	(a1)+,(a2)+		; priority and art tile
		move.b	(a1),frame-12(a2)	; object frame
		move.l	(a1),(a2)		; mappings!
		clr.l	xvel(a0)		; clear velocity
		clr.w	respawn(a0)		; clear respawn

Mecha_Blast_FollowMecha:
		move.w	parent(a0),a1		; get parent
		move.w	ypos(a1),d0		; get ypos
		add.w	#Mecha_FB_Yoff,d0	; offset teh fireball
		move.w	d0,ypos(a0)		; set as our y-pos

		move.w	xpos(a1),d0		; get xpos
		add.w	#Mecha_FB_Xoff,d0	; add offset
		btst	#0,render(a1)		; check flip status
		bne.s	.noflip			; branch if not flipped
		sub.w	#Mecha_FB_Xoff*2,d0	; negate offset
.noflip		move.w	d0,xpos(a0)		; set as xpos

		pea	AddToCollResponseList.w	;
		pea	DrawSprite.w		;
		jmp	ObjectMove.w		; move the object
; ---------------------------------------------------------------------------

Mecha_Blast_Fly:
		pea	DispCollObjLoaded3.w	; return here. Display and add to coll response list
		jmp	ObjectMove.w		; move the object
; ---------------------------------------------------------------------------

Boss_Mecha:
	if debug=1
		st	Level_Lag_Crash.w
	endif
		st	Boss_Active_Flag.w
		jsr	Boss_LoadArea.w		; get boss screen are to RAM
		move.w	Camera_X.w,d0		; get camera x-pos
		move.w	d0,Camera_min_X.w	; set min x
		move.w	d0,Camera_max_X.w	; set max x
		add.w	#320-16-$50,d0		; add moon offset
		move.w	d0,xpos(a0)		; set xpos
		add.w	#16,d1			; center y to moon
		move.w	d1,ypos(a0)		; set ypos

		move.b	#15,routine(a0)	; <- blah blah
		move.w	#$2020,height(a0)	; set object size
		move.w	#$1C1C,yrad(a0)		; set object size
		move.b	#4,render(a0)
		move.l	#($ED<<24)|Boss_Mecha_Main,(a0)
		move.l	#($ED<<24)|Boss_Mecha_Map,mappings(a0)
		move.w	#$24EE,tile(a0)
		move.w	#priority7,priority(a0)

Boss_Mecha_Main:
		lea	Mecha_Routine(pc),a4	; get the variable to a4 for later
		tst.b	collision(a0)		; check if we were hit

Boss_Mecha_Main_2:
		bra.s	.next			; if no, branch

		move.l	#Boss_Mecha_Fall_2,(a4)	; set routine
		move.b	#$C0|4,collision(a0); set hit to special to avoid collisions but bugs too
		move.w	#-$400,yvel(a0)
		move.w	#$200,xvel(a0)

		move.w	oboff1C(a0),a1		; get Sonic
		tst.w	xvel(a1)
		bmi.s	.chkdefeat
		neg.w	xvel(a0)		; negate x-velocity

.chkdefeat	tst.b	status(a0)		; check if we ded
		bmi.w	Boss_Mecha_Defeat	; branch if deteat

.next
Mecha_Routine EQU *+2		; routine to run
		jsr	Boss_Mecha_Appear.l	; run code
		btst	#7,Mecha_Power(a0)
		beq.s	.positive

		; negative
		addq.b	#1,Mecha_Power(a0)	; increment power counter
		bmi.s	.disp			; if nonzero, display
		subq.b	#1,Mecha_Power(a0)	; set to $FF
		bra.s	.disp

.positive	addq.b	#1,Mecha_Power(a0)	; increment power counter
		bpl.s	.disp			; if nonzero, display
		subq.b	#1,Mecha_Power(a0)	; set to $7F

.disp		pea	Player_Check_Screen_Boundaries; checks bounds

Boss_Mecha_Draw:
		pea	AddToCollResponseList.w	; return here. Add to collision list

Boss_Mecha_Draw_2:
		pea	DrawSprite.w		; return here. Display object.

Mecha_MvRtn EQU *+2
		jmp	ObjectMove.w		; move the object

; ---------------------------------------------------------------------------
Boss_Mecha_Appear:
		subq.b	#1,routine(a0)
		bpl.s	Boss_Mecha_A_RTS
		; coding this bit later~
		move.w	#priority2,priority(a0)
		move.l	#($ED<<24)|Boss_Mecha_BeginAttack,(a4)
		move.b	#$80|30,Mecha_Power(a0)
		move.w	#(($80|4)<<8)|Mecha_Hits,collision(a0); set hit count and colls
		move.b	#$66,Boss_Mecha_Main_2-Mecha_Routine(a4); change bra to bne

		move.w	Boss_Left.w,Camera_min_X.w
		move.w	Boss_Right.w,Camera_max_X.w
		sub.w	#320,Camera_max_X.w
		move.w	Boss_Top.w,Camera_min_Y.w
		move.w	Boss_Bottom.w,Camera_max_Y.w
		sub.w	#224,Camera_max_Y.w

		; temp shit
		sub.w	#$40,xpos(a0)
		add.w	#$38,ypos(a0)
		move.w	ypos(a0),Boss_Mecha_FlyUp_3-Mecha_Routine(a4); set air y-level

Boss_Mecha_SetBeginAttack:
		move.l	#($ED<<24)|Boss_Mecha_BeginAttack,(a4)

Boss_Mecha_A_RTS:
		rts

; ---------------------------------------------------------------------------
; begins a semi-random attack
Boss_Mecha_BeginAttack:
		move.b	Mecha_Power(a0),d6	; get power level
		bclr	#7,d6
		bne.s	.air

		bclr	#7,Mecha_FlightActive-Mecha_Routine(a4); set to or $00
		move.l	#(60<<24)|Boss_Mecha_FlyUp,d5
		moveq	#90,d1
		bsr.s	Boss_Mecha_CheckMoveAccept; check if we should use this move

		move.l	#(45<<24)|Boss_Mecha_Spindash,d5
		moveq	#45,d1
		bsr.s	Boss_Mecha_CheckMoveAccept; check if we should use this move

		move.l	#(20<<24)|Boss_Mecha_Jump,d5
		moveq	#20,d1
		bsr.s	Boss_Mecha_CheckMoveAccept; check if we should use this move

		move.l	#(10<<24)|Boss_Mecha_Run,d5
		moveq	#10,d1
		bsr.s	Boss_Mecha_CheckMoveAccept

		addq.b	#4,Mecha_Power(a0)	; add some extra power
		move.b	Level_Frame_Timer+1.w,d0; get the level timer
		and.b	#$3F,d0			; get only some values
		bne.s	Boss_Mecha_CMA_RTS	; if not 0, branch
		add.b	#90-4,Mecha_Power(a0)	; add some extra power
		rts

.air		bset	#7,Mecha_FlightActive-Mecha_Routine(a4); set to or $80

		move.l	#(60<<24)|Boss_Mecha_BigFireBall,d5
		moveq	#60,d1
		bsr.s	Boss_Mecha_CheckMoveAccept; check if we should use this move

		move.l	#(45<<24)|Boss_Mecha_Teleport,d5
		moveq	#45,d1
		bsr.s	Boss_Mecha_CheckMoveAccept; check if we should use this move

		cmp.b	#20,d6			; check if we have this much power
		bls.s	.falltoground		; if less, lose power to levitate
		move.l	#(5<<24)|Boss_Mecha_AirDash,d5
		moveq	#10,d1
		bsr.s	Boss_Mecha_CheckMoveAccept; check if we should use this move

		move.l	#(0<<24)|Boss_Mecha_MoveInAir,d5
		moveq	#5,d1
		bsr.s	Boss_Mecha_CheckMoveAccept; check if we should use this move

.falltoground	move.l	#Boss_Mecha_Fall,(a4)
		rts
; ---------------------------------------------------------------------------
; check if we can use this move. If so, sets the new move up!
; input:
;	d4 - last move used
;	d5 - routine ID, plus high byte has value to sub from power level
;	d6 - current power level
; ---------------------------------------------------------------------------
Boss_Mecha_CheckMoveAccept:
		cmp.b	d1,d6		; check if power level is greater than d1
		bls.s	Boss_Mecha_CMA_RTS; if not, do not use this move

Boss_Mecha_CheckMoveAccept2:
		move.l	d5,a1		; get move address to a1
		move.w	-2(a1),d0	; get last move
Mecha_LastMove EQU *+2
		cmp.w	#0,d0		; check the move ID
		beq.s	Boss_Mecha_CMA_RTS; if equal, branch
		move.w	d0,Mecha_LastMove-Mecha_Routine(a4); set last move

		addq.w	#4,sp		; do not return to sender
		move.l	d5,d0		; copy d0
		rol.l	#8,d0		; get high byte to low byte
		sub.b	d0,d6		; sub high byte from power level
Mecha_FlightActive EQU *+3
		or.b	#$00,d6		; or the high bit
		move.b	d6,Mecha_Power(a0); set power level
		move.l	d5,(a4)		; set the routine

Boss_Mecha_CMA_RTS:
		rts

; ---------------------------------------------------------------------------
	dc.w Mecha_M_FlyUp
Boss_Mecha_FlyUp:
		move.b	#$80|4,collision(a0)		; make this hurt
		add.w	#Boss_Mecha_FlyUp_2-Boss_Mecha_FlyUp,2(a4); set routine
		bsr.s	Boss_Mecha_FlyUp_2		; move Sonic up a bit. Sneaky, eh?
		bset	#7,Mecha_Power(a0)		; set on air

Boss_Mecha_FlyUp_2:
		subq.w	#1,ypos(a0)			; move up

Boss_Mecha_FlyUp_3 EQU *+2
		cmp.w	#0,ypos(a0)			; check the desired height
		bhi.s	Boss_Mecha_FlyUp_4		; if not there, branch
		move.l	#Boss_Mecha_FireBallDelay_3,(a4)
		move.w	#7-1,Boss_Mecha_TP_Delay-Mecha_Routine(a4)

Boss_Mecha_FlyUp_4:
		rts

; ---------------------------------------------------------------------------
Boss_Mecha_Fall:
		move.l	#Boss_Mecha_FireBallDelay_2,Boss_Mecha_Fall_DelayType-Mecha_Routine(a4)
		asr.w	xvel(a0)			; slow speed
		asr.w	yvel(a0)			; ^

Boss_Mecha_Fall_2:
		move.w	#ObjectFall,Mecha_MvRtn-Mecha_Routine(a4); change to ObjectFall
		move.l	#Boss_Mecha_Fall_3,(a4)
		move.b	#$80,Mecha_Power(a0)		; set on air

Boss_Mecha_Fall_3:
		tst.w	yvel(a0)
		bmi.s	Boss_Mecha_Fall_RTS		; branch if moving up
		jsr	ObjChkFloorDist.w		; get the floor distance
		tst.w	d1
		beq.s	.stop
		bpl.s	Boss_Mecha_Fall_RTS

		add.w	d1,ypos(a0)			; add floor height to ypos
.stop		clr.l	xvel(a0)			; clear y-velocity
		clr.b	Mecha_Power(a0)			; set on ground

		lea	Mecha_Routine(pc),a4		; it gets destryed by ObjChkFloorDist call.
Boss_Mecha_Fall_DelayType EQU *+2
		move.l	#Boss_Mecha_FireBallDelay_3,(a4); delay
		move.w	#ObjectMove,Mecha_MvRtn-Mecha_Routine(a4); change to ObjectFall
		move.w	#15-1,Boss_Mecha_TP_Delay-Mecha_Routine(a4)
		move.l	#Boss_Mecha_FireBallDelay_3,Boss_Mecha_Fall_DelayType-Mecha_Routine(a4)

Boss_Mecha_Fall_RTS:
		rts

; ---------------------------------------------------------------------------
; this routine makes the player Float (e.g. bop up and down slowly)
; ---------------------------------------------------------------------------
Boss_Mecha_Float:
		addq.b	#1,Boss_Mecha_Float_2-Mecha_Routine(a4); increment the offset
		and.b	#$7F,Boss_Mecha_Float_2+-Mecha_Routine(a4); keep in range boy
Boss_Mecha_Float_2 EQU *+1
		moveq	#-1,d0			; self modifying value
		move.b	Mecha_Ytbl(pc,d0.w),d0	; get entry from tbl
		ext.w	d0			; ext to word
		add.w	d0,Boss_Mecha_Float_3-Mecha_Routine(a4); add to yoff
		move.w	Boss_Mecha_FlyUp_3-Mecha_Routine(a4),ypos(a0); set ypos to default
Boss_Mecha_Float_3 EQU *+2
		add.w	#0,ypos(a0)		; finally add it to ypos
		rts

; ---------------------------------------------------------------------------
Mecha_Ytbl:	dc.b $00, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00
		dc.b $01, $00, $00, $01, $00, $00, $00, $01, $00, $00, $00, $01
		dc.b $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, -01, $00
		dc.b $00, $00, $00, $00, $00, $00, $00, $00, -01, $00, $00, $00
		dc.b -01, $00, $00, $00, -01, $00, $00, -01, $00, $00, -01, $00
		dc.b $00, -01, $00, $00, -01, $00, $00, $00, -01, -00, -01, -00
		dc.b -00, -01, -00, -00, -01, -00, -00, -01, -00, -00, -01, -00
		dc.b -00, -00, -00, -01, -00, -00, -00, -00, -00, -00, -00, -00
		dc.b -00, -01, $01, -00, -00, -00, -00, -00, -00, -00, -00, -00
		dc.b $01, -00, -00, -00, -00, $01, -00, -00, $01, -00, -00, $01
		dc.b -00, -00, $01, -00, -00, $01, $00, $01
; ---------------------------------------------------------------------------
; get the type from the array above hehe
Boss_Mecha_BigFireBall:
		jsr	CreateObject.w
		bne.s	Boss_Mecha_BFB_RTS		; if failed, branch
		move.l	#Mecha_Blast,(a1)		; create a blast object
		move.w	a1,Mecha_Child1(a0)		; set child
		move.w	a0,parent(a1)			; set this as parent
		move.w	#(3*60)-1,Mecha_Misc(a0)	; set time until we drop
		move.l	#Boss_Mecha_MoveInAir_2,(a4)
		move.w	#Boss_Mecha_BigFireBall_2-Boss_Mecha_MIA_Jump,Boss_Mecha_MIA_Jump-Mecha_Routine(a4)

Boss_Mecha_BFB_RTS:
		rts

; ---------------------------------------------------------------------------
	dc.w Mecha_M_Jump
Boss_Mecha_Jump:
		sf	Mecha_Power(a0)			; clear power
		move.b	#$80|6,collision(a0)		; make this hurt
		move.b	#1,frame(a0)			; set current frame
		clr.w	Mecha_Child1(a0)		; make sure no object is deleted
		move.w	#Mecha_Jump_XSpeed,xvel(a0)	; set jump velocity

		move.w	Object_RAM+xpos.w,d0		; get player xpos
		sub.w	xpos(a0),d0			; sub our xpos
		bpl.s	Boss_Mecha_Jump_		; if positive, go right
		neg.w	xvel(a0)			; go left

Boss_Mecha_Jump_:
		move.w	#Mecha_Jump_YSpeed,yvel(a0)	; set jump velocity
		move.w	#ObjectFall,Mecha_MvRtn-Mecha_Routine(a4); change to ObjectFall
		move.w	#Boss_Mecha_Jump_3-Boss_Mecha_MIA_Jump,Boss_Mecha_MIA_Jump-Mecha_Routine(a4)
		move.l	#Boss_Mecha_Jump_2,(a4)		; set routine

Boss_Mecha_Jump_2:
		tst.w	yvel(a0)
		bmi.s	Boss_Mecha_MoveInAir_3		; branch if moving up

		jsr	ObjChkFloorDist.w		; get the floor distance
		tst.w	d1
		beq.s	Boss_Mecha_Jump_5
		bpl.s	Boss_Mecha_MoveInAir_3

Boss_Mecha_Jump_4:
.stop		add.w	d1,ypos(a0)			; add floor height to ypos

Boss_Mecha_Jump_5:
		clr.w	yvel(a0)			; what about we stop moving YOU DAMM TWAT
		clr.b	frame(a0)			; set current frame

		lea	Mecha_Routine(pc),a4		; it gets destryed by ObjChkFloorDist call.
		move.w	#ObjectMove,Mecha_MvRtn-Mecha_Routine(a4); change to ObjectFall
		move.w	xvel(a0),Boss_Mecha_J_Ptrs_2-Mecha_Routine(a4); set the correct xvel
		lea	Boss_Mecha_J_Ptrs(pc),a1	; get correct ptrs

		tst.w	xvel(a0)			; test x-velocity
		spl	d4				; if positive, go right
		jmp	Boss_Mecha_RunDash_2(pc)	; slow down
; ---------------------------------------------------------------------------

Boss_Mecha_Jump_3:
		move.l	#.x,(a4)
.x		tst.w	yvel(a0)
		bmi.s	.rts				; branch if moving up

		jsr	ObjChkFloorDist.w		; get the floor distance
		tst.w	d1
		beq.s	Boss_Mecha_Jump_4
		bmi.s	Boss_Mecha_Jump_4
.rts		rts

; ---------------------------------------------------------------------------
Boss_Mecha_MoveInAir_End:
		add.b	#10,Mecha_Power(a0)	; add more power
		bmi.s	.nop
		st	Mecha_Power(a0)		; prevent overflow

.nop		rts

; ---------------------------------------------------------------------------
	dc.w Mecha_M_MoveInAir
Boss_Mecha_MoveInAir:
		clr.w	Mecha_Child1(a0)	; make sure no object is deleted
		move.l	#Boss_Mecha_MoveInAir_2,(a4); do not add more
		move.w	#90-1,Mecha_Misc(a0); set time until we drop
		move.w	#Boss_Mecha_MoveInAir_End-Boss_Mecha_MIA_Jump,Boss_Mecha_MIA_Jump-Mecha_Routine(a4)

Boss_Mecha_MoveInAir_2:
		jsr	Boss_Mecha_Float(pc)

Boss_Mecha_MoveInAir_3:
		move.w	#Object_RAM,a1		; get player address
		move.w	#Mecha_MIA_MaxSpd,d6
		move.w	#Mecha_MIA_Accel,d5

.dist1	EQU *+2
		move.w	#Mecha_FB_Dist,d4
		move.w	xpos(a1),d0		; get xpos of player
		sub.w	xpos(a0),d0		; sub Sonic x from d0
		bne.s	.nostopped		; if nonzero, we are moving
		; we should try to stop now
.chkspeed	tst.w	xvel(a0)
		beq.w	.notmove		; branch if we are not moving
		bgt.s	.trystopr		; branch if we are moving forwards
; ---------------------------------------------------------------------------

.trystopl	add.w	#Mecha_MIA_Decel,xvel(a0); add deceleration to xvel
		blo.s	.clrspd			; if xvel is less than deceleration
		bra.w	.chkvel			; branch!
; ---------------------------------------------------------------------------

.trystopr	sub.w	#Mecha_MIA_Decel,xvel(a0); sub deceleration from xvel
		bhs.w	.chkvel			; if xvel is less than deceleration

.clrspd		clr.w	xvel(a0)		; zero xvel
		move.w	#Mecha_FB_Dist2,.dist1-Mecha_Routine(a4); set right distance
		move.w	#Mecha_FB_Dist2,.dist2-Mecha_Routine(a4); set left distance
		bra.s	.notmove		; branch!
; ---------------------------------------------------------------------------

.nostopped	blt.s	.mvback			; Sonic is left of us
	; Sonic is right of us
		bset	#0,render(a0)		; face right
		cmp.w	d4,d0			; check how far we are
		blt.s	.chkspeed		; if not far enough, try to stop
		tst.w	xvel(a0)		; check if moving to opposite direction
		bmi.s	.trystopl		; branch if so
		lea	loc_1149C,a1		; get running right code
		bra.s	.runningcode		; execute
; ---------------------------------------------------------------------------

.mvback		bclr	#0,render(a0)		; face left
		neg.w	d4			; negate dist
		cmp.w	d4,d0			; check how far we are
		bgt.s	.chkspeed		; if not far enough, try to stop
		lea	loc_11412,a1		; get running left code
		tst.w	xvel(a0)		; check if moving to opposite direction
		beq.s	.runningcode		; if exactly 0, still move
		bpl.s	.trystopr		; branch if so
; ---------------------------------------------------------------------------

.runningcode	move.w	anim(a0),d2		; store animation ID
		move.w	xvel(a0),d0		; get xvel not inertia
		jsr	(a1)			; run Sonic's running code
		move.w	inertia(a0),xvel(a0)	; put inertia to xvel
		move.w	d2,anim(a0)		; reset anim
		move.w	#Mecha_FB_Dist,.dist1-Mecha_Routine(a4); set right distance
		move.w	#Mecha_FB_Dist,.dist2-Mecha_Routine(a4); set left distance

		subq.w	#1,Mecha_Misc(a0)	; sub 1 from delay
		bpl.s	.chkvel			; if positive, branch
		move.l	#Boss_Mecha_Fall,(a4)	; make it fall
		pea	Boss_Mecha_MIA_J(pc)	; return here
		move.w	Mecha_Child1(a0),a1	; load fireball to a1
		jmp	DeleteObject_A1.w	; delete the fireball
; ---------------------------------------------------------------------------

.chkvel		tst.w	xvel(a0)
		bne.s	Boss_Mecha_FBD_RTS	; branch if we are moving

.notmove	move.w	xpos(a1),d0		; get xpos of player
.dist2	EQU *+2
		move.w	#Mecha_FB_Dist,d4
		btst	#0,render(a0)		; check flip status
		bne.s	.noflip			; branch if not flipped
		add.w	d4,d0			; add distance offset for later

.noflip		sub.w	xpos(a0),d0		; sub this xpos from d0
		cmp.w	d4,d0			; get the distance
		bhi.s	Boss_Mecha_FBD_RTS	; if not in range, branch
		jsr	Boss_Mecha_SetBeginAttack(pc); reset atk

Boss_Mecha_MIA_J:
Boss_Mecha_MIA_Jump EQU *+2
		jmp	*(pc)			; PC-relative jump
; ---------------------------------------------------------------------------

Boss_Mecha_BigFireBall_2:
		cmp.w	#Boss_Mecha_Fall&$FFFF,2(a4)
		beq.s	Boss_Mecha_FBD_RTS	; branch if was set to fall
		jsr	Boss_Mecha_MoveInAir_End(pc); add score

		move.l	#Boss_Mecha_FireBallDelay,(a4)
		move.w	#15-2,Boss_Mecha_TP_Delay-Mecha_Routine(a4); set timer
		move.w	Mecha_Child1(a0),a2	; get child
		move.l	#Mecha_Blast_Fly,(a2)	; set its address

		move.w	xpos(a2),d1
		move.w	ypos(a2),d2
		sub.w	xpos(a1),d1
		sub.w	ypos(a1),d2
		jsr	GetArcTan.w		; calculate angle
		jsr	GetSine.w		; calculate sine

		muls.w	#Mecha_FB_MulSpd,d1
		asr.l	#8,d1
		move.w	d1,xvel(a2)		; set final xvel of fireball

		muls.w	#Mecha_FB_MulSpd,d0
		asr.l	#8,d0
		move.w	d0,yvel(a2)		; set final yvel of fireball

Boss_Mecha_FBD_RTS:
		rts
; ---------------------------------------------------------------------------

Boss_Mecha_SP_Unroll:
		subq.w	#8,ypos(a0)			; move down for spindash
		clr.b	frame(a0)			; set frame to 0
		lea	Boss_Mecha_FireBallDelay_2(pc),a1; get the actual routine we want
		move.l	a1,(a4)				; set as the routine to run
		jmp	(a1)				; jumpp
; ---------------------------------------------------------------------------

Boss_Mecha_FireBallDelay:
		jsr	Boss_Mecha_Float(pc)

Boss_Mecha_FireBallDelay_2:
		move.b	#4,collision(a0)		; make this enemy

Boss_Mecha_FireBallDelay_3:
		subq.w	#1,Boss_Mecha_TP_Delay-Mecha_Routine(a4); sub delay
		bpl.s	Boss_Mecha_FBD_RTS		; if not over, branch
		clr.w	Boss_Mecha_TP_Delay-Mecha_Routine(a4); clear delay and set id
		move.b	#$80|4,collision(a0)		; make this hurt
		jmp	Boss_Mecha_SetBeginAttack(pc)	; reset atk

; ---------------------------------------------------------------------------
Boss_Mecha_TP_Delay:	dc.w Mecha_M_Teleport
Boss_Mecha_Teleport:
		moveq	#32-1,d2			; 32 tries to find a TP slot
		move.w	xpos(a0),d4			; get ypos; <- hold on wtf why ypos I am drunk m8 :D its actually xpos derp
		sub.w	#Mecha_TP_Dist,d4		; align for checks later!!!!

		move.w	Boss_Left.w,d0			; get left boundary
		move.w	Boss_Right.w,d6			; get right boundary
		move.w	d0,d5				; cpy
		sub.w	d0,d6				; so, ok, you faggot, this code basically gets the total amount of pixels a in a burp area, so shit
		sub.w	#Mecha_TP_Gap*2,d6		; also dem edgy stuff
		add.w	#Mecha_TP_Gap,d5		; yup me too!

.chknew		subq.w	#1,d2				; sub 1 from left tries
		bmi.w	Boss_Mecha_SetBeginAttack	; if negative finaly, chk new move

		jsr	RandomNumber.w			; random()!!!!!!!
		clr.w	d0				; clear low word
		swap	d0				; swap de words
		divu	d6,d0				; division by division
		swap	d0				; remainder
		add.w	d5,d0				; add total offsets
		move.w	d0,d1				; copy stuff!

		; ok look, we dont want to teleport near where we are, you asshole, so instead we check where we were
		sub.w	d4,d1				; sub xpos from newpos, aka d1 = xpos-new = xpos>newpos = negative offs
		cmp.w	#Mecha_TP_Dist*2,d1		; cheqúe if we are in range
		blo.s	.chknew				; in range, sir!
		move.w	d0,Boss_Mecha_TP_Pos-Mecha_Routine(a4); set our position for later on! Beep
		move.l	#Boss_Mecha_TP_MainAnim1,(a4)	; change routinerefårdlgksrpdgmn fdkhgbfdsjkh gdsuihfbdyuif
		move.w	#15-1,Boss_Mecha_TP_Delay-Mecha_Routine(a4); timmy

Boss_Mecha_TP_MainAnim1:
		subq.b	#1,Mecha_Power(a0)		; we dont want to be Duracell Bunny
		jsr	Boss_Mecha_Float(pc)
		subq.w	#1,Boss_Mecha_TP_Delay-Mecha_Routine(a4); sub delay olo.olölolo
		bpl.w	Boss_Mecha_A_RTS		; you dad is not over yet
Boss_Mecha_TP_Pos EQU *+2
		move.w	#$DEAD,xpos(a0)			; set dem xpos :D
		add.w	#Boss_Mecha_TP_MainAnim2-Boss_Mecha_TP_MainAnim1,2(a4); rut-ine
		move.w	#25-1,Boss_Mecha_TP_Delay-Mecha_Routine(a4); tommy

Boss_Mecha_TP_MainAnim2:
		move.b	#4,collision(a0)		; make this enemy
		jsr	Boss_Mecha_Float(pc)
		subq.w	#1,Boss_Mecha_TP_Delay-Mecha_Routine(a4); sub delay olo.olölolo
		bpl.s	Boss_Mecha_R_Rts		; you dad is not over yetchocl
		clr.w	Boss_Mecha_TP_Delay-Mecha_Routine(a4); clear delay and set id
		move.b	#$80|4,collision(a0)		; make this hurt
		jmp	Boss_Mecha_SetBeginAttack(pc)	; reset atk
; ---------------------------------------------------------------------------

Boss_Mecha_SP_Right:
		bsr.s	Boss_Mecha_SP_ChkJmp
		ble.w	Boss_Mecha_Jump_

Boss_Mecha_R_Right:
		move.w	Object_RAM+xpos.w,d0		; get player xpos
		sub.w	xpos(a0),d0			; sub our xpos
		cmp.w	#-(Mecha_DR_Range/2),d0		; check if in range
		ble.w	Boss_Mecha_AD_Right		; if not, slow down

Boss_Mecha_R_Rts:
		rts
; ---------------------------------------------------------------------------

Boss_Mecha_SP_Left:
		bsr.s	Boss_Mecha_SP_ChkJmp
		ble.w	Boss_Mecha_Jump_

Boss_Mecha_R_Left:
		move.w	Object_RAM+xpos.w,d0		; get player xpos
		sub.w	xpos(a0),d0			; sub our xpos
		cmp.w	#Mecha_DR_Range/2,d0		; check if in range
		bge.w	Boss_Mecha_AD_Left		; if not, slow down
		rts
; ---------------------------------------------------------------------------

Boss_Mecha_SP_ChkJmp:
		move.w	Object_RAM+ypos.w,d0		; get player ypos
		sub.w	ypos(a0),d0			; sub our ypos
		cmp.w	#Mecha_SP_Range,d0		; check if in range
		rts

; ---------------------------------------------------------------------------
Boss_Mecha_J_Ptrs:
	dc.w Boss_Mecha_AD_Right-Boss_Mecha_RunDash
	dc.w Mecha_Dash_Decel
Boss_Mecha_J_Ptrs_2:
	dc.w 0
	dc.w Boss_Mecha_AD_Left-Boss_Mecha_RunDash
	dc.l (Boss_Mecha_FireBallDelay_2&$FFFFFF)|($ED<<24)

Boss_Mecha_AD_Ptrs:
	dc.w Boss_Mecha_AD_Right-Boss_Mecha_RunDash
	dc.w Mecha_Dash_Decel, Mecha_Run_Speed
	dc.w Boss_Mecha_AD_Left-Boss_Mecha_RunDash
	dc.l (Boss_Mecha_FireBallDelay&$FFFFFF)|($ED<<24)

Boss_Mecha_R_Ptrs:
	dc.w Boss_Mecha_R_Right-Boss_Mecha_RunDash
	dc.w Mecha_Dash_Decel, Mecha_Run_Speed
	dc.w Boss_Mecha_R_Left-Boss_Mecha_RunDash
	dc.l (Boss_Mecha_FireBallDelay_3&$FFFFFF)|($ED<<24)

Boss_Mecha_SD_Ptrs:
	dc.w Boss_Mecha_SP_Right-Boss_Mecha_RunDash
	dc.w Mecha_SP_Decel, Mecha_SP_Speed
	dc.w Boss_Mecha_SP_Left-Boss_Mecha_RunDash
	dc.l (Boss_Mecha_SP_Unroll&$FFFFFF)|($ED<<24)
; ---------------------------------------------------------------------------
	dc.w Mecha_M_Spindash
Boss_Mecha_Spindash:
		sf	Mecha_Power(a0)			; clear power
		lea	Boss_Mecha_SD_Ptrs(pc),a1	; get pointers for the routines
		bsr.s	Boss_Mecha_RunDash
		bne.s	.notmove			; if we did not successfully start it, branch

		move.b	#$80|6,collision(a0)		; make this hurt
		move.b	#1,frame(a0)			; set current frame
		addq.w	#8,ypos(a0)			; move down for spindash
.notmove	rts

; ---------------------------------------------------------------------------
	dc.w Mecha_M_Run
Boss_Mecha_Run:
		sf	Mecha_Power(a0)			; clear power
		move.b	#4,collision(a0)		; make this enemy
		lea	Boss_Mecha_R_Ptrs(pc),a1	; get pointers for the routines
		bra.s	Boss_Mecha_RunDash

; ---------------------------------------------------------------------------
	dc.w Mecha_M_AirDash
Boss_Mecha_AirDash:
		lea	Boss_Mecha_AD_Ptrs(pc),a1	; get pointers for the routines
; ---------------------------------------------------------------------------

Boss_Mecha_RunDash:
		move.w	Object_RAM+xpos.w,d0		; get player xpos
		sub.w	xpos(a0),d0			; sub our xpos
		shi	d4				; if positive, go right

		add.w	#Mecha_DR_Range,d0		; add range check
		cmp.w	#Mecha_DR_Range*2,d0		; check range
		blo.w	Boss_Mecha_SetBeginAttack	; if in range, use another move

Boss_Mecha_RunDash_2:
		movem.w	(a1),d0-d3			; get the speed
		tst.b	d4				; check our direction to move
		bmi.s	.toright			; if negative, branch

		bclr	#0,render(a0)			; face left
		neg.w	d2				; negate speed
		exg	d0,d3				; change to left routine
		bra.s	.common

.toright	bset	#0,render(a0)			; face left
.common		move.w	d2,xvel(a0)			; set speed
		lea	Boss_Mecha_RunDash(pc,d0.w),a2	; get pointer to the address
		move.l	a2,(a4)				; finally set routine

		move.l	8(a1),Boss_Mecha_DR_Delay_2-Mecha_Routine(a4); set the routine to run when done
		move.w	d1,Boss_Mecha_DR_Right_2-Mecha_Routine(a4); set right speed
		move.w	d1,Boss_Mecha_DR_Left_2-Mecha_Routine(a4); set left speed
		moveq	#0,d0

Boss_Mecha_RD_RTS:
		rts
; ---------------------------------------------------------------------------

Boss_Mecha_AD_Right:
Boss_Mecha_DR_Right_2 EQU *+2
		sub.w	#Mecha_Dash_Decel,xvel(a0)	; sub step
		bmi.s	Boss_Mecha_AD_Delay		; if negative, branch
		blo.s	Boss_Mecha_AD_Delay		; if not moving, branch
		rts

Boss_Mecha_AD_Left:
Boss_Mecha_DR_Left_2 EQU *+2
		add.w	#Mecha_Dash_Decel,xvel(a0)	; add step
		bpl.s	Boss_Mecha_AD_Delay		; if positive, branch
		bhs.s	Boss_Mecha_RD_RTS		; if still moving, branch

Boss_Mecha_AD_Delay:
		clr.w	xvel(a0)			; clear velocity
		move.w	#10-1,Boss_Mecha_TP_Delay-Mecha_Routine(a4); timing

Boss_Mecha_DR_Delay_2 EQU *+2
		move.l	#DeleteObject_This,(a4)		; delay
		rts

; ---------------------------------------------------------------------------
Boss_Mecha_TileAddr EQU		Chunk_Tbl2

Boss_Mecha_CopyTileData:
	dc.w (.end-Boss_Mecha_CopyTileData)/2-3
	dc.w Boss_Mecha_TileAddr+(32*0), Boss_Mecha_TileAddr+(32*5), Boss_Mecha_TileAddr+(32*11),Boss_Mecha_TileAddr+(32*16)
	dc.w Boss_Mecha_TileAddr+(32*0), Boss_Mecha_TileAddr+(32*6), Boss_Mecha_TileAddr+(32*12),Boss_Mecha_TileAddr+(32*17)
	dc.w Boss_Mecha_TileAddr+(32*0), Boss_Mecha_TileAddr+(32*7), Boss_Mecha_TileAddr+(32*13),Boss_Mecha_TileAddr+(32*16)
	dc.w Boss_Mecha_TileAddr+(32*0), Boss_Mecha_TileAddr+(32*7), Boss_Mecha_TileAddr+(32*13),Boss_Mecha_TileAddr+(32*17)

	dc.w Boss_Mecha_TileAddr+(32*20),Boss_Mecha_TileAddr+(32*21),Boss_Mecha_TileAddr+(32*21),Boss_Mecha_TileAddr+(32*21)
	dc.w Boss_Mecha_TileAddr+(32*20),Boss_Mecha_TileAddr+(32*21),Boss_Mecha_TileAddr+(32*21),Boss_Mecha_TileAddr+(32*21)
	dc.w Boss_Mecha_TileAddr+(32*20),Boss_Mecha_TileAddr+(32*21),Boss_Mecha_TileAddr+(32*21),Boss_Mecha_TileAddr+(32*21)
	dc.w Boss_Mecha_TileAddr+(32*20),Boss_Mecha_TileAddr+(32*21),Boss_Mecha_TileAddr+(32*21),Boss_Mecha_TileAddr+(32*21)

	dc.w Boss_Mecha_TileAddr+(32*1), Boss_Mecha_TileAddr+(32*2), Boss_Mecha_TileAddr+(32*8), Boss_Mecha_TileAddr+(32*14)
	dc.w Boss_Mecha_TileAddr+(32*1), Boss_Mecha_TileAddr+(32*3), Boss_Mecha_TileAddr+(32*9), Boss_Mecha_TileAddr+(32*15)
	dc.w Boss_Mecha_TileAddr+(32*1), Boss_Mecha_TileAddr+(32*4), Boss_Mecha_TileAddr+(32*10),Boss_Mecha_TileAddr+(32*15)
	dc.w Boss_Mecha_TileAddr+(32*1), Boss_Mecha_TileAddr+(32*4), Boss_Mecha_TileAddr+(32*10),Boss_Mecha_TileAddr+(32*14)+4
.end
; ---------------------------------------------------------------------------

Boss_Mecha_Defeat:
		lea	Boss_Mecha_TileAddr.w,a1	; get address
		lea	VDP_data_port,a6		; get data port
	vdpComm	move.l, 32*$93, VRAM, READ, 4(a6)	; read from VDP
		moveq	#22-1,d0			; set lenght

.load	rept 32/4
		move.l	(a6),(a1)+			; copy 4 bytes of the tile
	endr
		dbf	d0,.load			; loop til done

		move.l	#Boss_Mecha_Defeat_2,(a0)	; set defeat routine
		move.w	#ObjectFall,Mecha_MvRtn		; change to ObjectFall
		move.b	#24,height(a0)			; set object size
		move.b	#20,yrad(a0)			; set object size

Boss_Mecha_Defeat_2:
		jsr	ObjChkFloorDist.w		; get the floor distance
		tst.w	d1
		beq.s	.stop
		bpl.w	Boss_Mecha_Draw

.stop		add.w	d1,ypos(a0)			; add floor height to ypos
		clr.l	xvel(a0)			; what about we stop moving YOU DAMM TWAT
		move.w	#ObjectMove,Mecha_MvRtn		; change to ObjectMove
		add.w	#Boss_Mecha_Defeat_3-Boss_Mecha_Defeat_2,2(a0)
		move.w	#60*2,Mecha_Misc(a0)		; timerrr

Boss_Mecha_Defeat_3:
		subq.w	#1,Mecha_Misc(a0)		; sub 1 from the delay
		bpl.w	Boss_Mecha_Draw_2		; if not end, branch
		add.w	#Boss_Mecha_Defeat_4-Boss_Mecha_Defeat_3,2(a0)
		subq.w	#8,ypos(a0)			; sub 8px from y-pos
		move.w	#$200,xvel(a0)			; walk forwards
		bset	#0,render(a0)			; face or whatever
		move.w	Camera_X.w,Camera_Min_X.w	; copy camera x to min x

		lea	$FFFF4000,a2			; get final pointer
		lea	Boss_Mecha_CopyTileData(pc),a1	; get the data pointer
		move.w	(a1)+,d0			; get amount of data

.loadtiles	move.w	(a1)+,a3			; get pointer to the art data
	rept 32/4
		move.l	(a3)+,(a2)+			; copy 4 bytes of the tile
	endr
		dbf	d0,.loadtiles			; load all the tiles!

	; last tile must be x-flipped!
		move.w	(a1)+,a1			; get pointer to the art data
		moveq	#8-1,d0				; 8 rows

.load	rept 4
		move.b	-(a1),d1			; get 2 pixels
		ror.b	#4,d1				; swap nybbles
		move.b	d1,(a2)+			; save 2 pixels
	endr

		lea	8(a1),a1			; get next row
		dbf	d0,.load			; loop til done

		move.l	#$FFFF4000,d1
		move.w	#$3C0*32,d2
		move.w	#(48*32)/2,d3
		jmp	AddQueueDMA
; ---------------------------------------------------------------------------

Boss_Mecha_Defeat_4:
		bsr.s	Boss_Mecha_MvCamera		; amke camera follow us
		move.w	Boss_Right.w,d0			; get right bound
		add.w	#$40,d0				; add to it
		cmp.w	xpos(a0),d0			; compare to xpos
		bhi.w	Boss_Mecha_Draw_2		; if not further, draw only

		move.w	Camera_max_X.w,d0		; get camera max x
		cmp.w	Camera_min_X.w,d0		; check if this is finished
		bhi.w	Boss_Mecha_Draw_2		; if not there yet, branch

		add.w	#Boss_Mecha_Defeat_5-Boss_Mecha_Defeat_4,2(a0)
		move.w	Camera_max_X.w,d0		; get camera max x
		add.w	#64,d0				; add offset
		move.w	d0,Camera_target_max_x.w	; set position

		add.w	#320-24,d0			; add offsets
		move.w	d0,xpos(a0)			; set xpos
		clr.l	xvel(a0)			; clear velocity
		bclr	#0,render(a0)			; face Sanic
		move.w	#$101,Control_Locked.w		; lock all controls
; ---------------------------------------------------------------------------

Boss_Mecha_MvCamera:
		move.w	xpos(a0),d0			; get xpos of the
		sub.w	#(320/4)*3,d0			; 3/4ths to the end of the screen
		cmp.w	Camera_Min_X.w,d0		; check if we are behind the actual border
		blo.s	.rts				; branch if we are

		sub.w	Camera_Min_X.w,d0		; sub the camera min x from camera position
		bmi.s	.rts				; branch if we try to move backwards
		cmp.w	#4,d0				; check max speed
		ble.s	.fine				; branch if not moving too fast
		moveq	#4,d0				; force max speed

.fine		add.w	d0,Camera_Min_X.w		; add to camera min x
		move.w	Camera_Min_X.w,d0		; get camera min x-pos
		cmp.w	Camera_X.w,d0			; compare with the camera x
		blo.s	.x				; branch if we are not going further it
		move.w	d0,Camera_X.w			; force it

.x		move.w	Camera_Max_X.w,d0		; get the camera max x
		cmp.w	Camera_Min_X.w,d0		; compare with the minimum x
		bhi.s	.rts				; branch if we are not going further it
		move.w	d0,Camera_Min_X.w		; force it
.rts		rts
; ---------------------------------------------------------------------------

Boss_Mecha_Defeat_5:
		addq.w	#2,Camera_max_X.w		; move camera forwards
		move.w	Camera_Max_X.w,Camera_Min_X.w	; copy camera max to camera min
		move.w	Camera_Max_X.w,Camera_X.w	; copy camera max to camera x

		move.w	Camera_target_max_x.w,d0	; get the camera x
		cmp.w	Camera_max_X.w,d0		; check if this is finished
		bhi.w	Boss_Mecha_Draw_2		; of not there yet, branch
		add.w	#Boss_Mecha_Defeat_5_1-Boss_Mecha_Defeat_5,2(a0)

Boss_Mecha_Defeat_5_1:
		btst	#1,Object_RAM+status.w		; cehck in air status for p1
		bne.w	Boss_Mecha_Draw_2		; if in air, branch

		cmp.l	#Obj_Tails,Obj_player_2.w	; check if p2 is playing
		bne.s	.ok				; if no, branch
		btst	#1,Obj_player_2+status.w	; cehck in air status for p2
		bne.w	Boss_Mecha_Draw_2		; if in air, branch

.ok		add.w	#Boss_Mecha_Defeat_5_2-Boss_Mecha_Defeat_5_1,2(a0)
		jsr	CreateObjectAfter.w		; attempt to create another object
		bne.w	Boss_Mecha_Draw_2		; if failed, branch
		move.w	a1,Mecha_Misc(a0)		; set object
		move.l	#Boss_Mecha_GroundCode,(a1)	; set routine
		move.l	#Mecha_Boss_Ground,mappings(a1)	; set mappings

		move.b	#$C4,render(a1)			; set render type
		move.w	Camera_X.w,xpos(a1)		; x-pos
		move.w	#5-1,childnum(a1)		; set the number of child sprites
		move.w	#(128<<8)|64,height(a1)		; set width and height
		bra.w	Boss_Mecha_Draw_2
; ---------------------------------------------------------------------------

Boss_Mecha_Defeat_5_2:
		add.w	#Boss_Mecha_Defeat_6-Boss_Mecha_Defeat_5_2,2(a0)
		st	ScreenShake_Flag.w		; set to constant screen shake
		move.b	#$A1,Object_RAM+carried.w	; tell the player to not collide with objects nor to use moves
		move.b	#$A1,Obj_player_2+carried.w	; tell the player to not collide with objects nor to use moves

		st	Fast_V_scroll_flag.w
		move.w	#-$100,Camera_min_Y.w		; vertical wrapping enabled
		move.w	#$1000,Camera_max_y.w		; set max camera pos
		move.w	#$1000,Camera_target_max_Y.w	; ^

		move.w	Camera_Y.w,d0			; force to current y-position
		add.w	Distance_from_screen_top.w,d0
		move.w	d0,Scroll_Force_Y_Pos.w
		move.w	Camera_X.w,Scroll_Force_X_Pos.w	; force to current x-position

		move.w	ypos(a0),d0			; get our ypos
		move.w	xpos(a0),d1			; get our xpos
		movem.w	d0-d1,-(sp)			; store to stack

		jsr	GetChunkPosFG.w			; get the chunk address
		clr.b	-(a1)				; clear first chunk
		clr.b	-(a1)				; clear next chunk just to be sure

		movem.w	(sp)+,d0-d1			; pop positions from stack
		sub.w	#128*3,d0			; get the chunk above
		jsr	GetChunkPosFG.w			; get the chunk address
		clr.b	-(a1)				; clear first chunk
		clr.b	-(a1)				; clear next chunk just to be sure

Boss_Mecha_Defeat_6:
		st	Scroll_Force_Pos.w		; force scrolling position
Boss_Mecha_Defeat_6_1 EQU *+1
		moveq	#5,d0
		move.b	d0,Object_RAM+anim.w		; set to waiting animation
		move.b	d0,Obj_player_2+anim.w		; set to waiting animation

		cmp.b	#5,d0
		beq.s	.nope				; branch if animation is 5
		tst.b	Scroll_Force_Pos.w
		bpl.s	.nope				; branch if not set

		move.w	Object_RAM+ypos.w,d2		; get camera y-pos
		cmp.w	Scroll_Force_Y_Pos.w,d2		; check if we are past the force scroll pos
		bgt.s	.nope				; branch if not
		addq.b	#1,Boss_Mecha_Defeat_6		; clear this flag

.nope		moveq	#8,d0
		sub.w	d0,Object_RAM+ypos.w
		sub.w	d0,Obj_player_2+ypos.w		; move players along
Boss_Mecha_Defeat_6_2 EQU *+2
		sub.w	#8,Scroll_Force_Y_Pos.w		; sub camera y-pos

		move.w	Scroll_Force_Y_Pos.w,d0
		bpl.s	.skip
		move.w	Screen_Y_wrap_value.w,d1	; screen wrap value
		and.w	d1,Camera_Y.w
		and.w	d1,Scroll_Force_Y_Pos.w		; keep in range

.skip		jsr	ScreenShake			; do screen shaking
		cmp.w	#$C04,Camera_Y.w		; check if we are on this specific y-value
		bne.w	Boss_Mecha_Draw_2		; if not, branch

.k		add.w	#Boss_Mecha_Defeat_7-Boss_Mecha_Defeat_6,2(a0)
		move.w	#R_SpawnFlyingObj-ResizeOffset,Dynamic_Resize_Routine.w
		clr.w	Control_Locked.w		; unlock all controls
		sf	ScreenShake_Flag.w		; stop screen shake
		jsr	Monitor_Give_SuperSonic_2	; transfrom into super player

Boss_Mecha_Defeat_7:	; we've entered space, Johnny
		cmp.w	#50,Ring_Count.w		; check if we already have 50 rings
		bhs.s	Boss_Mecha_Del			; if so, use next routine
		addq.w	#1,Ring_Count.w			; increase ring count
		move.b	#1,Update_HUD_Rings.w		; update HUD
		rts

Boss_Mecha_Del:
		jmp	DeleteObject_This.w		; delete this object
; ---------------------------------------------------------------------------

Boss_Mecha_GroundCode:
		move.w	xpos(a0),d1			; get ypos
		move.w	Object_RAM+ypos.w,d2		; get y-pos
		move.w	d2,ypos(a0)			; set the y-pos of this object
		move.w	childnum(a0),d0			; get number of children
		lea	childdata(a0),a1		; get to the child data

.dataloop	move.w	d1,child_x(a1)			; set the the x-position of the child
		move.w	d2,child_y(a1)			; set ypos
		add.w	#64,d1				; increment x-pos
		lea	child_sz(a1),a1			; next child sprite
		dbf	d0,.dataloop			; loop til done

		cmp.w	#$D90,Camera_Y.w		; check if we are on this specific y-value
		bne.s	.display			; if not, display only
		move.b	#$1B,Boss_Mecha_Defeat_6_1	; set to hurting animation
		subq.w	#2,Boss_Mecha_Defeat_6_2	; move faster up
		move.l	#DrawSprite,(a0)		; dont move anymore
.display	jmp	DrawSprite.w
; ---------------------------------------------------------------------------

Boss_Mecha_Misc:include "boss/mecha/misc.asm"
Boss_Mecha_Map:	include "boss/mecha/mecha.asm"
;RawAni_MechaSonicItems_BlastsFullyCharged:dc.b	 0,  0
	;	dc.b  $D,$16		; 2
	;	dc.b   0, $D		; 4
	;	dc.b  $C,$16		; 6
	;	dc.b   0, $D		; 8
	;	dc.b $16,  0		; 10
	;	dc.b  $D,$19		; 12
	;	dc.b $16,$FC		; 14
Mecha_Boss_Ground:
		dc.w 2, (.end-.start)/6
.xoff = $00
.yiff = $14
.start
		dc.b .yiff, $F
		dc.w $C3C0, .xoff
		dc.b .yiff, $F
		dc.w $C3C0+32, .xoff+32
		dc.b .yiff+32, $F
		dc.w $C3C0+16, .xoff
		dc.b .yiff+32, $F
		dc.w $C3C0+16, .xoff+32
.end
; ---------------------------------------------------------------------------
