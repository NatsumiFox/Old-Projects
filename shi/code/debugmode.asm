DebugMode:
		moveq	#0,d0
		move.b	Debug_Routine.w,d0
		move.w	off_92A1C(pc,d0.w),d1
		jmp	off_92A1C(pc,d1.w)

; ---------------------------------------------------------------------------
off_92A1C:	dc.w loc_92A20-off_92A1C
		dc.w loc_92AB0-off_92A1C
; ---------------------------------------------------------------------------

loc_92A20:
		addq.b	#2,Debug_Routine.w
		move.l	$C(a0),Debug_Saved_Mapping.w
		cmpi.b	#6,5(a0)
		bhs.s	loc_92A38
		move.w	$A(a0),Debug_Saved_VRAM.w

loc_92A38:
		move.w	Screen_Y_wrap_value.w,d0
		and.w	d0,Object_RAM+ypos.w
		and.w	d0,Camera_Y.w
		clr.b	Scroll_Lock.w
		clr.w	Player1_OnWater_Flag.w
		bclr	#6,$2A(a0)
		beq.s	loc_92A6E
		movea.l	a0,a1
		jsr	Player_ResetAirTimer
		move.w	#$600,Player1_TopSpeed.w
		move.w	#$C,Player1_Acceleration.w
		move.w	#$80,Player1_Deceleration.w

loc_92A6E:
		move.b	#0,$22(a0)
		move.b	#0,$20(a0)
		lea	DebugOffs(pc),a2
		move.w	(a2)+,d6
		cmp.b	Current_Debug_Obj.w,d6
		bhi.s	loc_92AA0
		move.b	#0,Current_Debug_Obj.w

loc_92AA0:
		bsr.w	sub_92C88
		move.b	#$C,Debug_Placement_Flag+1.w
		move.b	#1,Debug_Placement_Flag+2.w


; ############### S U B	R O U T	I N E #######################################

loc_92AB0:
		lea	DebugOffs(pc),a2
		move.w	(a2)+,d6
		bsr.w	sub_92AD4
		jmp	DrawSprite


; ---------------------------------------------------------------------------

sub_92AD4:
		moveq	#0,d4
		move.w	#1,d1
		move.b	Ctrl_1_Press.w,d4
		andi.w	#$F,d4
		bne.s	loc_92B16
		move.b	Ctrl_1_Held.w,d0
		andi.w	#$F,d0
		bne.s	loc_92AFE
		move.b	#$C,Debug_Placement_Flag+1.w
		move.b	#$F,Debug_Placement_Flag+2.w
		bra.w	loc_92B7A

loc_92AFE:
		subq.b	#1,Debug_Placement_Flag+1.w
		bne.s	loc_92B1A
		move.b	#1,Debug_Placement_Flag+1.w
		addq.b	#1,Debug_Placement_Flag+2.w
		bne.s	loc_92B16
		move.b	#-1,Debug_Placement_Flag+2.w

loc_92B16:
		move.b	Ctrl_1_Held.w,d4

loc_92B1A:
		moveq	#0,d1
		move.b	Debug_Placement_Flag+2.w,d1
		addq.w	#1,d1
		swap	d1
		asr.l	#4,d1
		move.l	$14(a0),d2
		move.l	$10(a0),d3
		btst	#0,d4
		beq.s	loc_92B44
		sub.l	d1,d2
		moveq	#0,d0
		move.w	Camera_min_Y.w,d0
		swap	d0
		cmp.l	d0,d2
		bge.s	loc_92B44
		move.l	d0,d2

loc_92B44:
		btst	#1,d4
		beq.s	loc_92B5E
		add.l	d1,d2
		moveq	#0,d0
		move.w	Camera_target_max_Y.w,d0
		addi.w	#$DF,d0
		swap	d0
		cmp.l	d0,d2
		blt.s	loc_92B5E
		move.l	d0,d2

loc_92B5E:
		btst	#2,d4
		beq.s	loc_92B6A
		sub.l	d1,d3
		bhs.s	loc_92B6A
		moveq	#0,d3

loc_92B6A:
		btst	#3,d4
		beq.s	loc_92B72
		add.l	d1,d3

loc_92B72:
		move.l	d2,$14(a0)
		move.l	d3,$10(a0)


; ---------------------------------------------------------------------------

loc_92B7A:
		btst	#6,Ctrl_1_Held.w
		beq.s	loc_92BB2
		btst	#5,Ctrl_1_Press.w
		beq.s	loc_92B96
		subq.b	#1,Current_Debug_Obj.w
		bhs.s	loc_92BAE
		add.b	d6,Current_Debug_Obj.w
		bra.s	loc_92BAE

loc_92B96:
		btst	#6,Ctrl_1_Press.w
		beq.s	loc_92BB2
		addq.b	#1,Current_Debug_Obj.w
		cmp.b	Current_Debug_Obj.w,d6
		bhi.s	loc_92BAE
		move.b	#0,Current_Debug_Obj.w


; ---------------------------------------------------------------------------

loc_92BAE:
		bra.w	sub_92C88

loc_92BB2:
		btst	#5,Ctrl_1_Press.w
		beq.s	loc_92C0C
		jsr	CreateObject
		bne.s	loc_92C0C
		move.w	xpos(a0),xpos(a1)
		move.w	ypos(a0),ypos(a1)
		move.b	render(a0),render(a1)
		move.b	render(a0),status(a1)
		andi.b	#$7F,status(a1)
		moveq	#0,d0
		move.b	Current_Debug_Obj.w,d0
		add.w	d0,d0
		move.w	d0,d1
		lsl.w	#2,d0
		add.w	d1,d0
		move.b	4(a2,d0.w),subtype(a1)
		move.l	(a2,d0.w),(a1)
	;	cmpi.l	#Obj_Monitor,(a1)
	;	bne.s	locret_92C0A
	;	move.b	#9,subtype(a1)


; ---------------------------------------------------------------------------

locret_92C0A:
		rts

loc_92C0C:
		btst	#4,Ctrl_1_Press.w
		beq.s	locret_92C52
		moveq	#0,d0
		move.w	d0,Debug_Routine.w
		move	#$2700,sr
		jsr	HUD_DrawInit
		move.b	#-$80,Update_HUD_Rings.w
		move	#$2300,sr
		lea	Object_RAM.w,a1
		move.l	Debug_Saved_Mapping.w,$C(a1)
		move.w	Debug_Saved_VRAM.w,$A(a1)
		bsr.s	sub_92C54
		move.b	#$13,$1E(a1)
		move.b	#9,$1F(a1)


; End of function sub_92AD4
; ############### S U B	R O U T	I N E #######################################

locret_92C52:
		rts


; End of function sub_92C54
; ############### S U B	R O U T	I N E #######################################

sub_92C54:
		move.b	d0,$20(a1)
		move.w	d0,$12(a1)
		move.w	d0,$16(a1)
		move.b	d0,$2E(a1)
		move.b	d0,$3D(a1)
		move.w	d0,$18(a1)
		move.w	d0,$1A(a1)
		move.w	d0,$1C(a1)
		andi.b	#1,$2A(a1)
		ori.b	#2,$2A(a1)
		move.b	#2,5(a1)
		rts


; End of function sub_92C88
; ---------------------------------------------------------------------------

sub_92C88:
		moveq	#0,d0
		move.b	Current_Debug_Obj.w,d0
		add.w	d0,d0
		move.w	d0,d1
		lsl.w	#2,d0
		add.w	d1,d0
		move.l	4(a2,d0.w),mappings(a0)
		move.w	8(a2,d0.w),tile(a0)
		move.b	(a2,d0.w),frame(a0)
		rts

dbitem	macro obj, map, tile, frame, sub
	dc.l (\frame<<24)|\obj
	dc.l (\sub<<24)|\map
	dc.w \tile
    endm

DebugOffs:
		dc.w 7
		dbitem Obj_Ring, Map_Ring, 0, 0, 0
		dbitem Obj_Monitor, Map_Monitor, $564,10, 9; super
		dbitem Obj_Monitor, Map_Monitor, $564, 4, 3; ring
		dbitem Obj_Monitor, Map_Monitor, $564, 5, 4; sneaker
		dbitem Obj_Monitor, Map_Monitor, $564, 6, 5; fire
		dbitem Obj_Monitor, Map_Monitor, $564, 7, 6; light
		dbitem Obj_Monitor, Map_Monitor, $564, 8, 7; bubble
