sub_4F33C:
		cmpi.b	#6,Object_RAM+routine.w
		bhs.w	locret_50348
		move.w	Lvl_AutoScroll_Routine.w,d0
		movea.l	.offs(pc,d0.w),a0
		jmp	(a0)

; ---------------------------------------------------------------------------
.offs		dc.l locret_50348
		dc.l Boss_Wall_Auto
		dc.l Space_Auto
; ---------------------------------------------------------------------------

Space_Auto:
		move.w	Camera_X.w,d0
		addq.w	#4,d0
		cmp.w	AutoScroll_EndX.w,d0
		blo.s	.nosub
		move.w	AutoScroll_X_SubValue.w,d1
		sub.w	d1,Object_RAM+xpos.w
		sub.w	d1,Obj_player_2+xpos.w
		sub.w	d1,d0
		move.w	d0,d1
		andi.w	#$FFF0,d1
		subi.w	#$10,d1
		move.w	d1,Camera_X_Rounded.w

.nosub		move.w	d0,Camera_X.w
		move.w	d0,Camera_X_Copy.w
		move.w	d0,Camera_min_X.w
		move.w	d0,Camera_max_X.w
		addq.w	#4,Object_RAM+xpos.w
		addq.w	#4,Obj_player_2+xpos.w
		rts
; ---------------------------------------------------------------------------

Boss_Wall_Auto:
		move.w	Camera_X.w,d0
		addq.w	#4,d0
		cmp.w	AutoScroll_EndX.w,d0
		blo.s	loc_502FA
		move.w	AutoScroll_X_SubValue.w,d1
		sub.w	d1,Object_RAM+xpos.w
		sub.w	d1,Obj_player_2+xpos.w
		sub.w	d1,d0
		move.w	d0,d1
		andi.w	#$FFF0,d1
		subi.w	#$10,d1
		move.w	d1,Camera_X_Rounded.w

		; move objects
		move.w	AutoScroll_X_SubValue.w,d1
		moveq	#((Object_RAM_static-Object_RAM_free)/objsize)-1,d2
		lea	Object_RAM_free.w,a0

.loop		tst.l	(a0)
		beq.s	.x			; if object not loaded, branch
		sub.w	d1,xpos(a0)		; sub d1 from xpos
.x		lea	objsize(a0),a0		; next object
		dbf	d2,.loop

loc_502FA:
		move.w	d0,Camera_X.w
		move.w	d0,Camera_X_Copy.w
		move.w	d0,Camera_min_X.w
		move.w	d0,Camera_max_X.w
		move.w	d0,d1
		lea	Object_RAM.w,a1
		bsr.s	sub_50318
		move.w	d1,d0
		lea	Obj_player_2.w,a1

sub_50318:
		cmpi.b	#5,anim(a1)
		bne.s	loc_50324
		clr.b	anim(a1)

loc_50324:
		addi.w	#$18,d0
		cmp.w	xpos(a1),d0
		bls.s	loc_5033A
		move.w	d0,xpos(a1)
		move.w	#$400,inertia(a1)
		bra.s	locret_50348

loc_5033A:
		addi.w	#$C0,d0	; 'ˆ'
		cmp.w	xpos(a1),d0
		bhi.s	locret_50348
		move.w	d0,xpos(a1)

locret_50348:
		rts
; ---------------------------------------------------------------------------

ScrollManager:
		tst.b	Deform_Lock.w
		beq.s	.nolock				; branch if deform lock inst active
		rts

.nolock		clr.w	Camera_X_Pos_Diff.w
		clr.w	Camera_Y_Pos_Diff.w
		tst.b	Scroll_Lock.w
		bne.s	.screvents			; branch if scroll lock is active

		lea	Object_RAM.w,a0			; get player object to a0
		tst.b	Scroll_Force_Pos.w
		beq.s	.noforce			; branch if not forced camera positions
		clr.b	Scroll_Force_Pos.w		; dont force scroll position..?
		clr.w	Horiz_Scroll_Delay_Val.w
		lea	Scroll_Force_X_Pos-xpos.w,a0	; this will replace player's X and Y-pos

.noforce	lea	Camera_X.w,a1			; get camera x-position
		lea	Camera_min_X.w,a2		; get minimum x-boundary
		lea	Camera_X_Pos_Diff.w,a4		; get camera x difference
		lea	Horiz_Scroll_Delay_Val.w,a5	; get delay
		lea	Position_table.w,a6		; get position table
		bsr.w	ScrollHoriz			; scroll horizontally

		lea	Camera_Y.w,a1			; get camera y-position
		lea	Camera_min_X.w,a2		; get minimum x-boundary
		lea	Camera_Y_Pos_Diff.w,a4		; get camera y difference
		move.w	Distance_from_screen_top.w,d3	; get distance from screen top
		bsr.w	ScrollVerti			; scroll vertically

.screvents	bra.w	ScreenResize
; ---------------------------------------------------------------------------
; input:
; a0 = target player's address, (can also be pointer to forced data. See ScrollManager)
; a1 = Camera X-position
; a2 = Camera X minimum position
; a4 = Camera X pos diff
; a5 = horizontal scroll delay value
; a6 = Player position table
; ---------------------------------------------------------------------------
ScrollHoriz:
		move.w	(a1),d4				; get camera x-position to d4
		tst.b	Stop_Referenced_Objs.w
		bne.s	.rts
		move.w	(a5),d1				; get horizontal scroll value
		beq.s	.nodelay			; branch if 0
		subi.w	#$100,d1			; sub $100 from the delay
		move.w	d1,(a5)				; store it back

		moveq	#0,d1
		move.b	(a5),d1				; then get the upper word
		lsl.b	#2,d1				; shift twice to left (multiply by 4)
		addq.b	#4,d1				; and add 4 to it

		move.w	Sonic_Pos_Record_Index-Horiz_Scroll_Delay_Val(a5),d0; get record pos index
		sub.b	d1,d0				; súb the horiz scroll offset from the index
		move.w	(a6,d0.w),d0			; get a value from the record index
		andi.w	#$7FFF,d0			; clear 15th bit
		bra.s	.xgot				; d0 is our x-pos

.nodelay	move.w	xpos(a0),d0			; get normal x-position
.xgot		sub.w	(a1),d0				; sub camera x from x-pos

		subi.w	#288/2,d0			; sub the offset of player on right
		blt.s	.moveleft			; if we are further than this, scroll to player
		subi.w	#16,d0				; sub the width of the dead area from d0
		bge.s	.moveright			; if we arent as far as this, scroll to player
		clr.w	(a4)				; set camera x diff to 0
.rts		rts
; ---------------------------------------------------------------------------

.moveleft	cmpi.w	#-24,d0				; check if we should move 24 pixels
		bgt.s	.nomax				; if less than 24 pixels, branch
		move.w	#-24,d0				; else cap at 24 pixels
.nomax		add.w	(a1),d0				; add camera x-pos to pixel amount

		cmp.w	(a2),d0				; compare with camera minimum
		bgt.s	.common				; branch if greater than minimum
		move.w	(a2),d0				; set camera min as the camera pos
		bra.s	.common

.moveright	cmpi.w	#24,d0				; check if we should move 24 pixels
		blo.s	.nomax2				; if less than 24 pixels, branch
		move.w	#24,d0				; else cap at 24 pixels
.nomax2		add.w	(a1),d0				; add camera x-pos to pixel amount

		cmp.w	Camera_max_X-Camera_min_X(a2),d0; compare with camera maximum
		blt.s	.common				; branch if less than maximum
		move.w	Camera_max_X-Camera_min_X(a2),d0; set camera max as the camera pos

.common		move.w	d0,d1				; copy camera pos
		sub.w	(a1),d1				; sub current camera x from d1
		asl.w	#8,d1				; multiply by 256
		move.w	d0,(a1)				; save the new camera x-pos
		move.w	d1,(a4)				; save the camera x diff
		rts
; ---------------------------------------------------------------------------
; input:
; d3 = offset of player from screen top in pixels
; a0 = target player's address, (can also be pointer to forced data. See ScrollManager)
; a1 = Camera Y-position
; a2 = Camera X minimum position
; a4 = Camera Y pos diff
; a5 = horizontal scroll delay value
; a6 = Player position table
; ---------------------------------------------------------------------------
ScrollVerti:
		moveq	#0,d1
		move.w	ypos(a0),d0			; get y-position
		sub.w	(a1),d0				; sub camera y-position from player y-pos
		cmpi.w	#-$100,(a2)
		bne.s	.noywrap			; branch if no vertical wrapping
		and.w	Screen_Y_wrap_value.w,d0	; wrap the y-pos

.noywrap	btst	#2,status(a0)
		beq.s	.noroll				; branch if not rolling
		subq.w	#5,d0				; sub 5 from the Y-pos

.noroll		move.w	d3,d1				; copy distance from screen top
		btst	#1,status(a0)
		beq.s	.notinair			; branch if on air
; this following code allows fairly large range from the middle to move while on air.
		addi.w	#32,d0				; add 32 to the y-pos
		sub.w	d1,d0				; sub player height on screen from y-pos
		blo.s	.scrollfast			; if above, branch
		subi.w	#64,d0				; sub 64 from y-pos
		bhs.s	.scrollfast			; if below, branch

		tst.b	Max_Y_Pos_Change_Flag.w
		bne.s	.0				; branch if something is moving the y-pos(?)
		bra.s	.nodiff				; do not move the screen
; ---------------------------------------------------------------------------

.notinair	sub.w	d1,d0				; sub player height on screen from y-pos
		bne.s	.moveground			; branch if not 0
		tst.b	Max_Y_Pos_Change_Flag.w
		bne.s	.0				; branch if something is moving the y-pos(?)

.nodiff		clr.w	(a4)				; set camera y diff to 0
		rts
; ---------------------------------------------------------------------------

.moveground	cmpi.w	#$60,d3
		bne.s	.nodefault			; branch if not default distance
		tst.b	Fast_V_scroll_flag.w
		bne.s	.scrollfast

		move.w	inertia(a0),d1			; get inertia
		bpl.s	.posinertia			; branch if positive
		neg.w	d1				; negate inertia

.posinertia	cmpi.w	#$800,d1			; is inertia $800?
		bhs.s	.scrollfast			; if is same or higher, branch
		move.w	#$600,d1			; set inertia

		cmpi.w	#6,d0				; is y-difference 6?
		bgt.s	.movedown			; if is more or same, branch
		cmpi.w	#-6,d0				; is y-difference -6?
		blt.s	.moveup				; if is less or same, branch
		bra.s	.movealittle
; ---------------------------------------------------------------------------

.nodefault	move.w	#$200,d1			; set inertia
		cmpi.w	#2,d0				; is y-difference 2?
		bgt.s	.movedown			; if is more or same, branch
		cmpi.w	#-2,d0				; is y-difference -2?
		blt.s	.moveup				; if is less or same, branch
		bra.s	.movealittle
; ---------------------------------------------------------------------------

.scrollfast	move.w	#$1800,d1			; set inertia
		cmpi.w	#24,d0				; is y-difference 24?
		bgt.s	.movedown			; if is more or same, branch
		cmpi.w	#-24,d0				; is y-difference -24?
		blt.s	.moveup				; if is less or same, branch
		bra.s	.movealittle
; ---------------------------------------------------------------------------

.0		moveq	#0,d0				; no y-difference
		move.b	d0,Max_Y_Pos_Change_Flag.w	; clear flag

.movealittle	moveq	#0,d1
		move.w	d0,d1				; get y-difference
		add.w	(a1),d1				; add camera Y-pos
		tst.w	d0
		bpl.s	.movedown2			; branch if moving down
		bra.s	.moveup2			; branch if moving up
; ---------------------------------------------------------------------------

.moveup		neg.w	d1				; negate inertia
		ext.l	d1				; extend to long
		asl.l	#8,d1				; shift right 8 times (multiply by 256)
		add.l	(a1),d1				; add camera x-pos to d1
		swap	d1				; swap high word to low word

.moveup2	cmp.w	Camera_min_Y-Camera_min_X(a2),d1; compare whatever with camera min Y
		bgt.s	.common				; branch if we arent beyond the upper value
		cmpi.w	#-$100,d1			; is d1 -$100 (y-wrap value)?
		bgt.s	.nowrap				; if greater than that, branch
		and.w	Screen_Y_wrap_value.w,d1	; wrap Y-position
		bra.s	.common

.nowrap		move.w	Camera_min_Y-Camera_min_X(a2),d1; limit to Camera minimum Y-pos
		bra.s	.common
; ---------------------------------------------------------------------------

.movedown	ext.l	d1				; extend to long
		asl.l	#8,d1				; shift right 8 times (multiply by 256)
		add.l	(a1),d1				; add camera x-pos to d1
		swap	d1				; swap high word to low word

.movedown2	cmp.w	Camera_max_Y-Camera_min_X(a2),d1; compare whatever with camera max Y
		blt.s	.common				; branch if we arent beyond the lower value
		move.w	Screen_Y_wrap_value.w,d3	; get the screen y-wrap value
		addq.w	#1,d3				; add 1 to it
		sub.w	d3,d1				; sub screen y-wrap from d1
		blo.s	.nowrap2			; I think it branches if no y-wrapping exists
							; dunno what value would be required
		sub.w	d3,(a1)				; sub d3 from the camera Y
		bra.s	.common

.nowrap2	move.w	Camera_max_Y-Camera_min_X(a2),d1; limit to Camera maximum Y-pos
; ---------------------------------------------------------------------------

.common		move.w	(a1),d4				; get camera y-pos to d4
		swap	d1				; swap y-pos?
		move.l	d1,d3				; copy the y-pos
		sub.l	(a1),d3				; sub current y-pos from new y-pos
		ror.l	#8,d3				; rotate by 8 bits
		move.w	d3,(a4)				; store camera Y-diff
		move.l	d1,(a1)				; store camera Y-pos
.rts		rts
; ---------------------------------------------------------------------------

Rez_FreeMove:
		clr.w	Camera_Min_X.w
		move.w	#$7FFE,Camera_Max_X.w
		clr.w	Camera_Min_Y.w
		move.w	#$FFE,Camera_Max_Y.w
		move.w	#$FFE,Camera_Target_Max_Y.w
		rts
; ---------------------------------------------------------------------------

R_SpawnFlyingObj:
		tst.b	Object_RAM+carried.w
		bne.s	.rts

		move.w	Camera_Y.w,d0
		move.w	d0,Camera_max_Y.w
		move.w	d0,Camera_target_max_Y.w
		sub.w	#64,d0
		move.w	d0,Camera_min_Y.w

		move.w	Camera_X.w,d0
		add.w	#128*4,d0
		and.w	#$3F80,d0
		move.w	d0,AutoScroll_X_SubValue.w
		move.w	#128*4,AutoScroll_X_SubValue.w

	;	move.w	#8,Lvl_AutoScroll_Routine.w
		add.w	#R_SpaceWaitBoss-R_SpawnFlyingObj,Dynamic_Resize_Routine.w

		jsr	CreateObject.w			; attempt to create new object
		bne.s	.rts				; if failed, branch
		move.l	#Obj_FlyingSonic,(a1)
		move.w	#Object_RAM,parent2(a1)		; set player 1 as parent
		move.w	#Ctrl_1_Held,parent3(a1)	; set player 1 held buttons

		cmp.l	#Obj_Tails,Obj_player_2.w	; check if p2 is playing
		bne.s	.rts				; if no, branch
		jsr	CreateObject.w			; attempt to create new object
		bne.s	.rts				; if failed, branch

		move.l	#Obj_FlyingSonic,(a1)
		move.w	#Obj_player_2,parent2(a1)	; set player 2 as parent
		move.w	#Ctrl_2_Held,parent3(a1)	; set player 2 held buttons
.rts		rts
; ---------------------------------------------------------------------------

ScreenResize:
		move.w	Dynamic_Resize_Routine.w,d1
		jsr	ResizeOffset(pc,d1.w)
		moveq	#2,d1				; set movement speed
		move.w	Camera_target_max_Y.w,d0	; get screen target lower boundary
		sub.w	Camera_max_Y.w,d0		; get screen lower current boundary
		beq.s	.rts				; if equals, branch
		bhs.s	.movedown			; if boundary is moving down, branch

		neg.w	d1				; negate movement
		move.w	Camera_Y.w,d0			; get camera Y-pos
		cmp.w	Camera_target_max_Y.w,d0	; compare with max Y-pos
		bls.s	.mvcamera			; branch if camera isn't near the target
		andi.w	#$FFFE,d0			; set to an even number
		move.w	d0,Camera_max_Y.w		; set camera max y-pos

.mvcamera	add.w	d1,Camera_max_Y.w		; add movement to speed to camera max Y
		move.b	#1,Max_Y_Pos_Change_Flag.w	; set max Y changing flag
.rts		rts
; ---------------------------------------------------------------------------

.movedown	move.w	Camera_Y.w,d0			; get camera Y-pos
		addi.w	#8,d0				; add 8 to it
		cmp.w	Camera_max_Y.w,d0		; compare with the max camera y-pos
		blo.s	.mvcamera2			; branch if camera isn't near the target

		btst	#1,Object_RAM+status.w
		beq.s	.mvcamera2			; branch if on air(?)
		add.w	d1,d1
		add.w	d1,d1				; quadruple movement speed

.mvcamera2	add.w	d1,Camera_max_Y.w		; add movement to speed to camera max Y
		move.b	#1,Max_Y_Pos_Change_Flag.w	; set max Y changing flag
		rts
; ---------------------------------------------------------------------------

ResizeOffset:	; set offset
		add.w	#CamLocks-ResizeOffset,Dynamic_Resize_Routine.w
		add.w	#camlocks1-CamLocks,Camera_LockOff.w
		rts
; ---------------------------------------------------------------------------

R_SpaceWaitBoss:
		rts
; ---------------------------------------------------------------------------

R_waitboss1end:
	if debug=1
		st	Level_Lag_Crash.w
	endif
		tst.w	Lvl_AutoScroll_Routine.w
		bne.s	R_rts
		move.w	#$7FFE,Camera_max_X.w
		sf	FreezePlaneA.w
		add.w	#CamLocks-R_waitboss1end,Dynamic_Resize_Routine.w
		add.w	#camlocks2-camlocks1,Camera_LockOff.w

R_rts:
		rts
; ---------------------------------------------------------------------------

R_waitboss2end:
		tst.w	ScreenShake_Flag.w
		beq.s	R_rts
	if debug=1
		sf	Level_Lag_Crash.w
	endif
		add.w	#R_rts-R_waitboss2end,Dynamic_Resize_Routine.w
		rts
; ---------------------------------------------------------------------------

R_boss2spawn:
		jsr	CreateObject.w			; attempt to create new object
		bne.s	R_rts				; if failed, branch
		move.l	#Boss_Mecha,(a1)
		add.w	#R_waitboss2end-R_boss2spawn,Dynamic_Resize_Routine.w

		; placeholder code
	if debug=1
		sf	Level_Lag_Crash.w	; ensure no crash
	endif
		lea	Boss_Mecha_Code,a0
	;	lea	Chunk_table,a1
	;	move.w	#filesize('boss/mecha/.bin')/4,d0
.load	;	move.l	(a0)+,(a1)+
	;	dbf	d0,.load
		bsr.s	GenericKosBoss

		lea	ArtKosM_Mecha,a1
		move.w	#$9DC0,d2
		jsr	Queue_Kos_Module
		lea	ArtKosM_MechaMisc,a1
		move.w	#$8C60,d2
		jmp	Queue_Kos_Module
; ---------------------------------------------------------------------------

R_boss1spawn:
		move.w	#4,Lvl_AutoScroll_Routine.w
		jsr	CreateObject.w			; attempt to create new object
		bne.s	R_rts				; if failed, branch
		move.l	#Boss_Wall,(a1)
		move.w	#FGUpdate_DrawTopRow-FGUpdate,FGUpdateOff.w
		add.w	#R_waitboss1end-R_boss1spawn,Dynamic_Resize_Routine.w
		move.w	#$310,Camera_min_Y.w

	if debug=1
		sf	Level_Lag_Crash.w
	endif
		lea	Boss_Wall_Code,a0

GenericKosBoss:
		lea	Chunk_table,a1
		jmp	KosDec

; ---------------------------------------------------------------------------
camlocks1:	dc.w $0486,$0400,AutoScroll_X_SubValue
		dc.w $04A6,$0960,AutoScroll_EndX
		dc.w $0560,$0310,0		; its a troll, and bugs and things
		dc.w $0580,R_boss1spawn-ResizeOffset,Dynamic_Resize_Routine
		dc.w -1

camlocks2:	dc.w $0A40,$0108,Camera_min_Y
		dc.w $0D00,$0310,Camera_max_Y
		dc.w $0D20,$0310,Camera_target_max_Y
		dc.w $0D40,$0108,Camera_target_max_Y
		dc.w $0F60,$1140,Camera_max_X
		dc.w $0FA0,$0F80,Camera_min_X
		dc.w $0FC0,R_boss2spawn-ResizeOffset,Dynamic_Resize_Routine
		dc.w -1
; ---------------------------------------------------------------------------

CamLocks:
		move.w	Camera_LockOff.w,d1	; get lock data offset
		lea	CamLocks(pc,d1.w),a1	; base offset on this routine
; ---------------------------------------------------------------------------
; format: XXXX, YYYY, address
; XXXX = target camera Y. if bit 15 is set, then move instantly
; YYYY = X-position to trigger this Camera Y from
; ---------------------------------------------------------------------------
CamY_FromArray:
		move.w	Camera_X.w,d0			; get camera x-pos
.chknext	movem.w	(a1)+,d1/d2/a2			; get next data
		cmp.w	d1,d0				; compare against each other
		bhi.s	.chknext			; if targeted X didnt match with current X (not far enough), branch

		move.w	d2,(a2)				; and set as current camera Y
		rts
; ---------------------------------------------------------------------------
	if debug=1
Debug_RezTbl:
	dc.w CamLocks-ResizeOffset, CamLocks-ResizeOffset, Rez_FreeMove-ResizeOffset
Debug_CLKtbl:
	dc.w camlocks1-CamLocks, camlocks2-CamLocks, 0
	endif
; ---------------------------------------------------------------------------
LevelSetup:
		clr.b	BG_Layer_Scroll_Timer2+2.w
		bclr	#7,Knuckles_GlideStateFlag2.w
		clr.l	Plane_double_update.w
		clr.w	Lvl_AutoScroll_Routine.w
		clr.l	AutoScroll_X_SubValue.w
		clr.l	Dynamics_Routine.w
		clr.l	Update_Lvl_FG_Flag.w
		clr.w	ScreenShake_Flag.w
		clr.l	ScreenShake_Value.w
		clr.l	Secondary_Plane_Buffer.w
		clr.l	ScreenShake2_Flag.w

		move.w	#$FFF,Screen_Y_wrap_value.w
		move.w	#$7FF,Screen_Y_BG_wrap_value.w
		move.w	#$FF0,Camera_Y_pos_mask.w
		move.w	#$7C,Layout_row_index_mask.w
		move.w	Camera_X.w,Camera_X_Copy.w
		move.w	Camera_Y.w,Camera_Y_Copy.w

LevelSetup2:
		lea	Plane_buffer.w,a0
		lea	ML_Blocks,a2

		lea	Level_layout_main.w,a3
		move.w	#$C000,d7
		bsr.s	XZ1_FGDraw

		addq.w	#2,a3
		move.w	#$E000,d7
		bsr.s	XZ1_BGDraw

		move.w	Camera_Y_Copy.w,VScroll_Factor_FG.w
		move.w	Camera_BG_Y.w,VScroll_Factor_BG.w
		rts
; ---------------------------------------------------------------------------

XZ1_FGDraw:
		jsr	UpdateFGRoundedCameraValues(pc)
		jmp	ProcessCurrentScreenRows(pc)

XZ1_BGDraw:
		jsr	XZ1_BGScrollSpeed(pc)
		jsr	UpdateBGRoundedCameraValues(pc)
		moveq	#0,d1
		jsr	ProcessCurrentScreenRows(pc)
		lea	DGHZ_Act1(pc),a4		; load scroll data to use
		jmp	DeformScroll(pc)		; continue
; ---------------------------------------------------------------------------

ScreenEvents:
		move.w	Camera_X.w,Camera_X_Copy.w
		move.w	Camera_Y.w,Camera_Y_Copy.w
		jsr	sub_4F40C(pc)
		lea	Plane_buffer.w,a0
		lea	ML_Blocks,a2
		lea	Level_layout_main.w,a3

		move.w	#$C000,d7
		move.w	FGUpdateOff.w,d1	; get FG update offset
		jsr	FGUpdate(pc,d1.w)	; jump to FG update code

		addq.w	#2,a3
		move.w	#$E000,d7
		bsr.s	XZ1_BGEffects

		move.w	Camera_Y_Copy.w,VScroll_Factor_FG.w
		move.w	Camera_BG_Y.w,VScroll_Factor_BG.w
		rts
; ---------------------------------------------------------------------------

FGUpdate:
		jmp	SeRenderScroll(pc)

XZ1_BGEffects:
		jsr	XZ1_BGScrollSpeed(pc)
		lea	Camera_BG_Y.w,a6
		lea	Camera_BG_Y_Rounded.w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	SeRenderHzScroll(pc)
		lea	DGHZ_Act1(pc),a4	; load scroll data to use
		jmp	DeformScroll(pc)	; continue

FGUpdate_DrawTopRow:
		clr.w	FGUpdateOff.w		; clear offset
		move.w	Camera_Y.w,d0		; get camera y-pos
		sub.w	#16,d0			; sub 1 block from it
		move.w	Camera_X_Copy.w,d1	; get camera y-pos
		moveq	#32,d6			; 32 rows
		jmp	SeRenderHzRowsAt(pc)	; render single row
; ===========================================================================
; ---------------------------------------------------------------------------
; Horizontal Scrolling - Green Hill
; ---------------------------------------------------------------------------
XZ1_BGScrollSpeed:
		move.w	Camera_Y_Copy.w,d0
		asr.w	#1,d0
		and.w	Screen_Y_BG_wrap_value.w,d0		; keep in range
		move.w	d0,Camera_BG_Y.w
		lea	Scroll_Block_Buffer.w,a5		; load block buffer

	; --- Moon ---
		move.w	#-$0080,(a5)				; save speed 1 (No movement)
		moveq	#$00,d0					; clear d0
		move.b	Camera_X.w,d0				; get camera high byte only
		lsr.b	#2,d0					; shift 2 bits down (div by $400)
		sub.w	d0,(a5)+				; add to moon x-pos

	; --- Various speeds ---

		move.w	Camera_X.w,d0				; load X position
		neg.w	d0					; reverse direction
		swap	d0					; convert to long-word with quotient/dividend...
		asr.l	#$01,d0					; divide by x2
		move.l	d0,(a5)+				; save as speed 2
		asr.l	#$01,d0					; divide to x4
		move.l	d0,d1					; store in d1
		move.l	d0,(a5)+				; save as speed 3
		asr.l	#$01,d0					; divide to x8
		move.l	d1,d2					; store x4
		add.l	d0,d1					; get x3 speed
		move.l	d1,(a5)+				; save as speed 4
		asr.l	#$01,d0					; divide to x10
		move.l	d0,(a5)+				; save as speed 5
		sub.l	d0,d2					; get x6 speed
		move.l	d2,(a5)+				; save as speed 6

	; --- The arch ---

		move.w	#$00,d0					; clear d0
		move.w	Camera_X.w,d0				; load screen's X position
		addi.w	#$0010*$04,d0				; offset it to so the art lines up nicely to make sense...
		andi.w	#$003F*$04,d0				; keep in position/range (x4 due to division of 4 for initial speed loss, that's at the bottom)
		neg.w	d0					; reverse direction
		move.w	d0,d1					; copy and extend as long-word signed
		ext.l	d1					; ''
		asl.l	#$04,d1					; create dividend space
		divs.w	#48,d1					; divide by the number of scanlines to perform on
		swap	d1					; shift up to create 16-bit dividend
		clr.w	d1					; clear dividend
		asr.l	#$02+$06,d1				; divide by a fraction for gradual speed increase (plus a x4 for initial speed loss)
		asr.l	#$01,d1					; ''
		move.l	d1,d2					; create an even smaller fraction for the curve adjustment
		asr.l	#$04,d2					; ''
		swap	d0					; get default starting speed
		lea	48*2(a5),a5				; advance to end position first
		moveq	#48-$01,d4				; prepare scanline counter
		asr.l	#$02,d0					; divide by x4 for initial speed loss

DGHZ_Arch:
		move.l	d0,d3					; save only quotient of position
		swap	d3					; ''
		move.w	d3,-(a5)				; ''
		add.l	d1,d0					; adjust position
		add.l	d2,d1					; increase speed (cause curve)
		dbf	d4,DGHZ_Arch				; repeat for all arch scanlines
		rts
	; --- Finish ---
; ---------------------------------------------------------------------------
; Scroll data
; ---------------------------------------------------------------------------

DGHZ_Act1:
		dc.w	(Scroll_Block_Buffer)&$FFFF,	 40	; Moon
		dc.w	(Scroll_Block_Buffer)&$FFFF,	 32	; Sky
		dc.w	(Scroll_Block_Buffer+$0E)&$FFFF, 40	; Bricks

DGHZ_LoopOff:
	rept	48
		dc.w	((Scroll_Block_Buffer+$16)&$FFFF)+((*-DGHZ_LoopOff)/$02), 1; Arches
	endr

		dc.w	(Scroll_Block_Buffer+$0A)&$FFFF, 8	; Thin brick bars
		dc.w	(Scroll_Block_Buffer+$02)&$FFFF, 32	; Thick block bricks
		dc.w	(Scroll_Block_Buffer+$0A)&$FFFF, 8	; Thin brick bars
		dc.w	(Scroll_Block_Buffer+$06)&$FFFF, 16	; Brief back walls
		dc.w	(Scroll_Block_Buffer+$0A)&$FFFF, 32	; Pylon beam (Animated in front of walls)
		dc.w	(Scroll_Block_Buffer+$06)&$FFFF, 192	; Walls & Electrical orb piston device thingy...
		dc.w	(Scroll_Block_Buffer+$0A)&$FFFF, 32	; Pylon beam
		dc.w	(Scroll_Block_Buffer+$06)&$FFFF, 8	; Thin brick bars
		dc.w	(Scroll_Block_Buffer+$12)&$FFFF, 144	; Pillar section
		dc.w	(Scroll_Block_Buffer+$06)&$FFFF, 8	; Thin brick bars
		dc.w	(Scroll_Block_Buffer+$0A)&$FFFF, 32	; Pylon beam
		dc.w	(Scroll_Block_Buffer+$06)&$FFFF, 8	; Thin brick bars
		dc.w	(Scroll_Block_Buffer+$02)&$FFFF, 512	; Thick block bricks
		dc.w	$0000
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Deform scanlines correctly using a list
; ---------------------------------------------------------------------------

DeformScroll:
		move.l	d2,-(sp)
		moveq	#-1,d2
		tst.b	FreezePlaneA.w
		bpl.s	.norm
		clr.w	d2
		swap 	d2

.norm		lea	Horiz_Scroll_Buffer.w,a6		; load H-scroll buffer
		move.w	#$00E0,d7				; prepare number of scanlines
		move.w	Camera_BG_Y.w,d6			; load Y position
		cmp.w	#$F80,Camera_Y.w			; check for magic value
		bhi.s	DS_MoonFix				; branch if we need t o fix moon
		sub.w	#128,d6
		move.l	Camera_X.w,d1				; prepare FG X position
		neg.l	d1					; reverse position

DS_FindStart:
		move.w	(a4)+,d0				; load scroll speed address
		beq.s	DS_Last					; if the list is finished, branch
		movea.w	d0,a5					; set scroll speed address
		sub.w	(a4)+,d6				; subtract size
		bpl.s	DS_FindStart				; if we haven't reached the start, branch
		neg.w	d6					; get remaining size
		sub.w	d6,d7					; subtract from total screen size
		bmi.s	DS_EndSection				; if the screen is finished, branch

DS_NextSection:
		subq.w	#$01,d6					; convert for dbf
		move.w	(a5),d1					; load X position
		and.l	d2,d1

DS_NextScanline:
		move.l	d1,(a6)+				; save scroll position
		dbf	d6,DS_NextScanline			; repeat for all scanlines
		move.w	(a4)+,d0				; load scroll speed address
		beq.s	DS_Last					; if the list is finished, branch
		movea.w	d0,a5					; set scroll speed address
		move.w	(a4)+,d6				; load size

DS_CheckSection:
		sub.w	d6,d7					; subtract from total screen size
		bpl.s	DS_NextSection				; if the screen is not finished, branch

DS_EndSection:
		add.w	d6,d7					; get remaining screen size and use that instead

DS_Last:
		subq.w	#$01,d7					; convert for dbf
		bmi.s	DS_Finish				; if finished, branch
		move.w	(a5),d1					; load X position
		and.l	d2,d1

DS_LastScanlines:
		move.l	d1,(a6)+				; save scroll position
		dbf	d7,DS_LastScanlines			; repeat for all scanlines

DS_Finish:
		move.l	(sp)+,d2
		rts						; return

DS_MoonFix:
		move.l	Camera_X.w,d1				; prepare FG X position
		neg.l	d1					; reverse position
		move.w	Scroll_Block_Buffer.w,d1		; get moon x-pos
		subq.b	#1,d7					; d7 was $E0 before, change it to $DF for dbf
		bra.s	DS_LastScanlines			; load scanlines
; ===========================================================================

PlaneBufferToVRAM:
		lea	VDP_data_port,a6		; get data port to a6
		lea	Plane_buffer.w,a0		; get plane buffer to a0
		bsr.s	.nextwrite			; run code once
		move.l	Secondary_Plane_Buffer.w,d0	; get secondary plane buffer
		beq.s	.rts				; branch if null
		movea.l	d0,a0				; put to a0

.nextwrite	move.w	(a0),d0				; get transfer offset
		beq.s	.endwrites			; if none left, branch
		clr.w	(a0)+				; clear the next word
		move.w	(a0)+,d1			; get transfer length
		bmi.s	.vertical			; if negative, its a vertical strip

		move.w	#$8F02,d2			; increment of 2
		move.w	#$80,d3				; value for next line
		bra.s	.common

.vertical	move.w	#$8F80,d2			; increment of $80 (size of horizontal line)
		moveq	#2,d3				; value for next line
		andi.w	#$7FFF,d1			; clear high bit of length

.common		move.w	d2,VDP_control_port-VDP_data_port(a6); set VDP increment
		move.w	d0,d2				; store VRAM address
		move.w	d1,d4				; store length
		bsr.s	WriteDataToVDPoffs		; transfer first line

		move.w	d2,d0				; get stored address
		add.w	d3,d0				; add line size to address
		move.w	d4,d1				; get stored length
		bsr.s	WriteDataToVDPoffs		; transfer second line
		bra.s	.nextwrite			; do next

.endwrites	move.w	#$8F02,VDP_control_port-VDP_data_port(a6); reset increment
.rts		rts
; ---------------------------------------------------------------------------

WriteDataToVDPoffs:
		swap	d0
		clr.w	d0		; clear high word
		swap	d0

		lsl.l	#2,d0		; shift left twice (2 highest bits to 2 lowest)
		lsr.w	#2,d0		; shift right twice to return rest of bits to their place
		ori.w	#$4000,d0	; set VRAM write mode
		swap	d0		; swap words
		move.l	d0,VDP_control_port-VDP_data_port(a6); set as the write mode

.write		move.l	(a0)+,(a6)	; write 2 words to VDP
		dbf	d1,.write	; keep writing til done
		rts
; ---------------------------------------------------------------------------

ReadDataFromVDPoffs:
		swap	d0
		clr.w	d0		; clear high word
		swap	d0

		lsl.l	#2,d0		; shift left twice (2 highest bits to 2 lowest)
		lsr.w	#2,d0		; shift right twice to return rest of bits to their place
		swap	d0		; swap words
		move.l	d0,VDP_control_port-VDP_data_port(a6); set as the write mode

.read		move.l	(a6),(a0)+	; read 2 words from VDP
		dbf	d1,.read	; keep reading til done
		rts
; ---------------------------------------------------------------------------

sub_4E7DA:
		lea	VDP_data_port,a6		; get data port to a6
		lea	Plane_buffer.w,a0		; get plane buffer to a0

.nextwrite	move.w	(a0),d0				; get transfer offset
		beq.s	.rts				; if none left, branch
		clr.w	(a0)+				; clear the next word
		move.w	(a0)+,d1			; get transfer length

		move.w	d0,d2				; store VRAM address
		move.w	d1,d4				; store length
		bsr.s	WriteDataToVDPoffs			; transfer first line

		move.w	d2,d0				; get stored address
		add.w	Plane_Buffer_Pos_OnScr.w,d0	; add line size to address
		move.w	d4,d1				; get stored length
		bsr.s	WriteDataToVDPoffs			; transfer second line
		bra.s	.nextwrite			; do next
.rts		rts
; ---------------------------------------------------------------------------

SpecialFXcode:
		lea	VDP_data_port,a6
		move.w	SpecialFX_Routine.w,d0
		jmp	.offs(pc,d0.w)

; ---------------------------------------------------------------------------
.offs		rts			; $00
		nop			; $02
		bra.w	.vscrollEnable	; $04
		bra.w	.vscrollMain	; $08
		bra.w	.vscrollDisable	; $0C
; ---------------------------------------------------------------------------

.vscrollEnable	move.w	#$8B07,VDP_control_port-VDP_data_port(a6); enable vertical scrolling
		addq.w	#4,SpecialFX_Routine.w			; increment to next routine

.vscrollMain	lea	Verti_Scroll_Buffer.w,a0
		move.l	#$40000010,VDP_control_port-VDP_data_port(a6); set to VSRAM write

		moveq	#(80/4)-1,d0		; write 80 bytes (size of VSRAM)
.writeVscroll	move.l	(a0)+,(a6)		; write next 2 words
		dbf	d0,.writeVscroll	; loop til done
		rts
; ---------------------------------------------------------------------------

.vscrollDisable	move.w	#$8B03,VDP_control_port-VDP_data_port(a6); disable vertical scrolling
		clr.w	SpecialFX_Routine.w			; clear the routine counter
		rts
; ---------------------------------------------------------------------------

ScreenShake:
		move.w	ScreenShake_Value.w,ScreenShake_Value_prev.w; store value for last frame
		moveq	#0,d1
		cmpi.b	#6,Object_RAM+routine.w
		bhs.s	.common					; branch if player is dead
		move.w	ScreenShake_Flag.w,d0			; get shake settings
		beq.s	.common					; if 0, branch
		bmi.s	.constant				; if negative, not timed

		subq.w	#1,d0					; sub 1 from delay
		move.w	d0,ScreenShake_Flag.w			; store delay
		move.b	ScrShake_Timed(pc,d0.w),d1		; get timed screenshake value
		ext.w	d1					; extend to word
		bra.s	.common

.constant	move.w	Level_Frame_Timer.w,d0			; get level timer
		andi.w	#$3F,d0					; limit the offset
		move.b	ScrShake_Normal(pc,d0.w),d1		; get next value to d1

.common		move.w	d1,ScreenShake_Value.w			; set d1 as the offset
		rts
; ---------------------------------------------------------------------------

sub_4F40C:
		move.w	ScreenShake2_Flag.w,d0			; get shake settings
		beq.s	.rts					; if 0, branch
		subq.w	#1,d0					; sub 1 from delay
		move.w	d0,ScreenShake2_Flag.w			; store delay

		move.b	ScrShake_Timed(pc,d0.w),d0		; get timed screenshake value
		ext.w	d0					; extend to word
		add.w	d0,Camera_X_Copy.w			; add to camera x copy
.rts		rts

; ---------------------------------------------------------------------------
ScrShake_Timed:	dc.b 1, -1, 1, -1, 2, -2, 2, -2, 3, -3
		dc.b 3, -3, 4, -4, 4, -4, 5, -5, 5, -5

ScrShake_Normal:dc.b  1,  2,  1,  3,  1,  2,  2,  1,  2,  3,  1,  2,  1,  2,  0,  0
		dc.b  2,  0,  3,  2,  2,  3,  2,  2,  1,  3,  0,  0,  1,  0,  1,  3
		dc.b  1,  2,  1,  3,  1,  2,  2,  1,  2,  3,  1,  2,  1,  2,  0,  0
		dc.b  2,  0,  3,  2,  2,  3,  2,  2,  1,  3,  0,  0,  1,  0,  1,  3

		dc.w  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0
		dc.w  0,  0,  0,  0,  0,  0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
		dc.w -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,  0,  0,  0,  0
		dc.w  0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
		dc.w  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0
		dc.w  0,  0,  0,  0,  0,  0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
		dc.w -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,  0,  0,  0,  0
		dc.w  0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
		dc.w  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0
		dc.w  0,  0,  0,  0,  0,  0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
		dc.w -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,  0,  0,  0,  0
		dc.w  0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
		dc.w  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0
		dc.w  0,  0,  0,  0,  0,  0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
		dc.w -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,  0,  0,  0,  0
		dc.w  0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
		dc.w  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0
		dc.w  0,  0,  0,  0,  0,  0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
		dc.w  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1,  1,  1
		dc.w  1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1
		dc.w  1,  1,  1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1
		dc.w  1,  1,  1,  1,  1,  0, -1, -2, -2, -1,  0,  2,  2,  2,  2,  0
		dc.w  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1,  1,  1
		dc.w  1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1

word_4F778:	dc.w  1,  1,  1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0
		dc.w  0,  1,  1,  1,  1,  1,  1,  0, -1, -2, -2, -1,  0,  2
		dc.w  2,  2,  2,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0
		dc.w  0,  1,  1,  1,  1,  1,  1,  0,  0,  0, -1, -1, -1, -1
		dc.w -1, -1,  0,  0,  0,  1,  1,  1,  1,  1,  1,  0,  0

word_4F802:	dc.w  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1,  1
		dc.w  1,  1,  0, -1, -2, -2, -1,  0,  2,  2,  2,  2,  0,  0
		dc.w  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1,  1
		dc.w  1,  1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0
		dc.w  1,  1,  1

word_4F878:	dc.w  1,  1,  1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0
		dc.w  0,  1,  1,  1,  1,  1,  1,  0, -1, -2, -2, -1,  0,  2
		dc.w  2,  2,  2,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0
		dc.w  0,  1,  1,  1,  1,  1,  1,  0,  0,  0, -1, -1, -1, -1
		dc.w -1, -1,  0,  0,  0,  1,  1,  1
; ---------------------------------------------------------------------------
; Subroutine to check if we need to update the scrollplane when
; moving vertically.
; ---------------------------------------------------------------------------
SeRenderHzScroll:
		move.w	(a6),d0
		and.w	Camera_Y_pos_mask.w,d0
		move.w	(a5),d2
		move.w	d0,(a5)
		move.w	d2,d3
		sub.w	d0,d2
		beq.w	locret_4EC46
		tst.b	d2
		bpl.s	loc_4EAFA
		neg.w	d2
		move.w	d3,d0
		addi.w	#$F0,d0
		and.w	Camera_Y_pos_mask.w,d0

loc_4EAFA:
		andi.w	#$30,d2
		cmpi.w	#$10,d2
		sne	Plane_double_update.w
		movem.w	d1/d6,-(sp)
		bsr.s	SeRenderHzRowsAt
		movem.w	(sp)+,d1/d6
		tst.b	Plane_double_update.w
		beq.w	locret_4EC46
		addi.w	#$10,d0
		and.w	Camera_Y_pos_mask.w,d0
		bra.s	SeRenderHzRowsAt
; ---------------------------------------------------------------------------

sub_4EB22:
		move.w	(a6),d0
		and.w	Camera_Y_pos_mask.w,d0
		move.w	(a5),d2
		move.w	d0,(a5)
		move.w	d2,d3
		sub.w	d0,d2
		beq.w	locret_4EC46
		tst.b	d2
		bpl.s	loc_4EB46
		neg.w	d2
		move.w	d3,d0
		addi.w	#$F0,d0
		and.w	Camera_Y_pos_mask.w,d0
		swap	d1

loc_4EB46:
		andi.w	#$30,d2
		cmpi.w	#$10,d2
		sne	Plane_double_update.w
		movem.w	d1/d6,-(sp)
		bsr.s	SeRenderHzRowsAt
		movem.w	(sp)+,d1/d6
		tst.b	Plane_double_update.w
		beq.w	locret_4EC46
		addi.w	#$10,d0
		and.w	Camera_Y_pos_mask.w,d0
; ---------------------------------------------------------------------------
; Subroutine to calculate which blocks need to be updated in the
; scrollplane for horizontal scrolling
;
; input:
;   d0 = Camera Y FG
;   d1 = Camera X FG copy
;   d7 = $C000 for Plane A or $E000 for Plane B
;   d6 = Number of columns
;   a0 = Plane Buffer
;   a2 = Block Buffer
;   a3 = Layout header (offset for FG or BG chunks)
;   a5 = Camera Y FG rounded
;   a6 = Camera Y FG copy
; ---------------------------------------------------------------------------
SeRenderHzRowsAt:
		asr.w	#4,d1
		move.w	d1,d2
		move.w	d1,d4
		asr.w	#3,d1
		add.w	d2,d2
		move.w	d2,d3
		andi.w	#$E,d2
		add.w	d3,d3
		andi.w	#$7C,d3
		andi.w	#$1F,d4
		moveq	#$20,d5
		sub.w	d4,d5
		move.w	d5,d4
		sub.w	d6,d5
		bmi.s	loc_4EBB2
		move.w	d0,d5
		andi.w	#$F0,d5
		lsl.w	#4,d5
		add.w	d7,d5
		add.w	d3,d5
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0
		jsr	SeGetHzBlockAddr(pc)
		bra.s	SeRenderHzRows
; ---------------------------------------------------------------------------

loc_4EBB2:
		neg.w	d5
		move.w	d5,-(sp)
		move.w	d0,d5
		andi.w	#$F0,d5
		lsl.w	#4,d5
		add.w	d7,d5
		add.w	d3,d5
		move.w	d5,(a0)+
		move.w	d4,d6
		subq.w	#1,d6
		move.w	d6,(a0)+
		lea	(a0),a1
		add.w	d4,d4
		add.w	d4,d4
		adda.w	d4,a0
		bsr.s	SeGetHzBlockAddr
		bsr.s	SeRenderHzRows
		move.w	(sp)+,d6
		move.w	d0,d5
		andi.w	#$F0,d5
		lsl.w	#4,d5
		add.w	d7,d5
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0
; ---------------------------------------------------------------------------
; Subroutine to calculate horizontal blocks to be updated in the
; scrollplane
;
; input:
;   d1 = row index offset
;   d2 = offset in the row of blocks
;   d6 = number of blocks to load
;   a0 = offset in Plane Buffer where to load lower tiles to
;   a1 = offset in Plane Buffer where to load upper tiles to
;   a5 = initial address of block data in chunk
; ---------------------------------------------------------------------------
SeRenderHzRows:
		move.w	(a5,d2.w),d3
		move.w	d3,d4
		andi.w	#$3FF,d3
		lsl.w	#3,d3
		move.l	(a2,d3.w),d5
		move.l	4(a2,d3.w),d3
		btst	#$B,d4
		beq.s	loc_4EC1A
		eori.l	#$10001000,d5
		eori.l	#$10001000,d3
		exg	d3,d5

loc_4EC1A:
		btst	#$A,d4
		beq.s	loc_4EC30
		eori.l	#$8000800,d5
		eori.l	#$8000800,d3
		swap	d5
		swap	d3

loc_4EC30:
		move.l	d5,(a1)+
		move.l	d3,(a0)+
		addq.w	#2,d2
		andi.w	#$E,d2
		bne.s	loc_4EC40
		addq.w	#1,d1
		bsr.s	SeGetHzBlockAddr2

loc_4EC40:
		dbf	d6,SeRenderHzRows
		clr.w	(a0)

locret_4EC46:
		rts
; ---------------------------------------------------------------------------
; input:
;   d0 = Camera Y FG
;   d1 = Row index offset
;   a3 = Layout header (offset for FG or BG chunks)
;
; output:
;   a5 = Address of a horizontal row of blocks inside the chunk,
;        based on the position of the camera and its direction of
;        movement
; ---------------------------------------------------------------------------
SeGetHzBlockAddr:
		move.w	d0,d3
		asr.w	#5,d3
		and.w	Layout_row_index_mask.w,d3
		movea.w	(a3,d3.w),a4
		add.w	#Level_layout_header-$FFFF8000,a4

SeGetHzBlockAddr2:
	; Changed to accomodate direct chunks
		moveq	#0,d3
		move.b	(a4,d1.w),d3
		lsl.w	#7,d3
		move.w	d0,d4
		andi.w	#$70,d4
		add.w	d4,d3
		add.l	#ML_Chunks,d3
		movea.l	d3,a5
		rts
; ---------------------------------------------------------------------------

SeRenderScroll:
		lea	Camera_X_Copy.w,a6
		lea	Camera_X_Rounded.w,a5
		move.w	Camera_Y_Copy.w,d1
		moveq	#$F,d6
		jsr	SeRenderVtScroll(pc)
		lea	Camera_Y_Copy.w,a6
		lea	Camera_Y_Rounded.w,a5
		move.w	Camera_X_Copy.w,d1
		moveq	#$15,d6
		jmp	SeRenderHzScroll(pc)

UpdateBGRoundedCameraValues:
		move.w	Camera_BG_X.w,d0
		move.w	d0,d1
		andi.w	#-$10,d0
		move.w	d0,d2
		move.w	d0,Camera_BG_X_Rounded.w
		move.w	Camera_BG_Y.w,d0
		and.w	Camera_Y_pos_mask.w,d0
		move.w	d0,Camera_BG_Y_Rounded.w
		rts
; ---------------------------------------------------------------------------

UpdateFGRoundedCameraValues:
		move.w	Camera_X_Copy.w,d0
		move.w	d0,d1
		andi.w	#-$10,d0
		move.w	d0,Camera_X_Rounded.w
		move.w	Camera_Y_Copy.w,d0
		and.w	Camera_Y_pos_mask.w,d0
		move.w	d0,Camera_Y_Rounded.w
		rts

ProcessCurrentScreenRows:
		moveq	#$F,d2
loc_4ECD0:
		movem.l	d0-d2/a0,-(sp)
		moveq	#$20,d6
		jsr	SeRenderHzRowsAt(pc)
		jsr	PlaneBufferToVRAM(pc)
		movem.l	(sp)+,d0-d2/a0
		addi.w	#$10,d0
		dbf	d2,loc_4ECD0
		rts

sub_4F072:
		lea	Horiz_Scroll_Buffer.w,a1
		move.w	Camera_X_Copy.w,d0
		neg.w	d0
		swap	d0
		move.w	Camera_BG_X.w,d0
		neg.w	d0
		moveq	#$37,d1


; End of function sub_4F072
; ############### S U B	R O U T	I N E #######################################

loc_4F086:
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		dbf	d1,loc_4F086

locret_4EAB6:
		rts
; ---------------------------------------------------------------------------
; input:
;   d1 = Camera Y FG copy
;   d7 = $C000 for Plane A or $E000 for Plane B
;   d6 = Number of columns
;   a0 = Plane Buffer
;   a2 = Block Buffer
;   a3 = Layout header (offset for FG or BG chunks)
;   a5 = Camera X FG rounded
;   a6 = Camera X FG copy
; ---------------------------------------------------------------------------
SeRenderVtScroll:
		move.w	(a6),d0
		andi.w	#-$10,d0
		move.w	(a5),d2
		move.w	d0,(a5)
		move.w	d2,d3
		sub.w	d0,d2
		beq.S	locret_4EAB6
		tst.b	d2
		bpl.s	loc_4E948
		neg.w	d2
		move.w	d3,d0
		addi.w	#$150,d0

loc_4E948:
		andi.w	#$30,d2
		cmpi.w	#$10,d2
		sne	Plane_double_update.w
		movem.w	d1/d6,-(sp)
		bsr.s	SeRenderVtRowsAt
		movem.w	(sp)+,d1/d6
		tst.b	Plane_double_update.w
		beq.S	locret_4EAB6
		addi.w	#$10,d0
		bra.s	SeRenderVtRowsAt
; ---------------------------------------------------------------------------

sub_4E96C:
		move.w	(a6),d0
		andi.w	#-$10,d0
		move.w	(a5),d2
		move.w	d0,(a5)
		move.w	d2,d3
		sub.w	d0,d2
		beq.w	locret_4EAB6
		tst.b	d2
		bpl.s	loc_4E98C
		neg.w	d2
		move.w	d3,d0
		addi.w	#$150,d0
		swap	d1

loc_4E98C:
		andi.w	#$30,d2
		cmpi.w	#$10,d2
		sne	Plane_double_update.w
		movem.w	d1/d6,-(sp)
		bsr.s	SeRenderVtRowsAt
		movem.w	(sp)+,d1/d6
		tst.b	Plane_double_update.w
		beq.w	locret_4EAB6
		addi.w	#$10,d0

; ---------------------------------------------------------------------------
; input:
;   d0 = Camera X FG
;   d1 = Camera Y FG copy
;   d7 = $C000 for Plane A or $E000 for Plane B
;   d6 = Number of columns
;   a0 = Plane Buffer
;   a2 = Block Buffer
;   a3 = Layout header (offset for FG or BG chunks)
;   a5 = Camera X FG rounded
;   a6 = Camera X FG copy
; ---------------------------------------------------------------------------
SeRenderVtRowsAt:
		move.w	d1,d2
		andi.w	#$70,d2
		move.w	d1,d3
		lsl.w	#4,d3
		andi.w	#$F00,d3
		asr.w	#4,d1
		move.w	d1,d4
		asr.w	#1,d1
		and.w	Layout_row_index_mask.w,d1
		andi.w	#$F,d4
		moveq	#$10,d5
		sub.w	d4,d5
		move.w	d5,d4
		sub.w	d6,d5
		bmi.s	loc_4E9FC
		move.w	d0,d5
		asr.w	#2,d5
		andi.w	#$7C,d5
		add.w	d7,d5
		add.w	d3,d5
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		bset	#7,-2(a0)
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0
		jsr	SeGetVtBlockAddr(pc)
		bra.s	SeRenderVtRows
; ---------------------------------------------------------------------------

loc_4E9FC:
		neg.w	d5
		move.w	d5,-(sp)
		move.w	d0,d5
		asr.w	#2,d5
		andi.w	#$7C,d5
		add.w	d7,d5
		add.w	d3,d5
		move.w	d5,(a0)+
		move.w	d4,d6
		subq.w	#1,d6
		move.w	d6,(a0)+
		bset	#7,-2(a0)
		lea	(a0),a1
		add.w	d4,d4
		add.w	d4,d4
		adda.w	d4,a0
		jsr	SeGetVtBlockAddr(pc)
		bsr.s	SeRenderVtRows
		move.w	(sp)+,d6
		move.w	d0,d5
		asr.w	#2,d5
		andi.w	#$7C,d5
		add.w	d7,d5
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		bset	#7,-2(a0)
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0
; ---------------------------------------------------------------------------
; Subroutine to calculate vertical blocks to be updated in the
; scrollplane
;
; input:
;   d1 = row index offset
;   d2 = offset in the row of blocks
;   d6 = number of blocks to load
;   a0 = offset in Plane Buffer where to load lower tiles to
;   a1 = offset in Plane Buffer where to load upper tiles to
;   a5 = initial address of block data in chunk
; ---------------------------------------------------------------------------
SeRenderVtRows:
		swap	d7
loc_4EA4C:
		move.w	(a5,d2.w),d7
		move.w	d7,d4
		andi.w	#$3FF,d7
		lsl.w	#3,d7
		move.w	(a2,d7.w),d5
		swap	d5
		move.w	4(a2,d7.w),d5
		move.w	2(a2,d7.w),d3
		swap	d3
		move.w	6(a2,d7.w),d3
		btst	#$B,d4
		beq.s	loc_4EA84
		eori.l	#$10001000,d5
		eori.l	#$10001000,d3
		swap	d5
		swap	d3

loc_4EA84:
		btst	#$A,d4
		beq.s	loc_4EA98
		eori.l	#$8000800,d5
		eori.l	#$8000800,d3
		exg	d3,d5

loc_4EA98:
		move.l	d5,(a1)+
		move.l	d3,(a0)+
		addi.w	#$10,d2
		andi.w	#$70,d2
		bne.s	loc_4EAAE
		addq.w	#4,d1
		and.w	Layout_row_index_mask.w,d1
		bsr.s	SeGetVtBlockAddr

loc_4EAAE:
		dbf	d6,loc_4EA4C
		swap	d7
		clr.w	(a0)
		rts
; ---------------------------------------------------------------------------

SeGetVtBlockAddr:
	; Changed to accomodate direct chunks
		movea.w	(a3,d1.w),a4
		move.w	d0,d3
		asr.w	#7,d3
		add.w	#Level_layout_header-$FFFF8000,d3
		adda.w	d3,a4
		moveq	#0,d3
		move.b	(a4),d3
		lsl.w	#7,d3
		move.w	d0,d4
		asr.w	#3,d4
		andi.w	#$E,d4
		add.w	d4,d3
		add.l	#ML_Chunks,d3
		movea.l	d3,a5
		rts
; ---------------------------------------------------------------------------
