loc_187D8:
		jmp	DeleteObject_This

Obj_Sonic:
		lea	Player1_TopSpeed.w,a4		; get top speed flags ready
		lea	Distance_from_screen_top.w,a5	; get this thing.
		lea	Obj_dust.w,a6			; get dust object

		tst.w	Debug_Routine.w
		beq.s	ObjSonic_Normal			; branch if no debug mode
		cmpi.b	#1,Debug_Placement_Flag.w
		beq.s	.godebug			; branch if debug active

		; we are in frame cycling mode
		btst	#4,Ctrl_1_Press.w
		beq.s	.notB				; branch if B is not pressed
		move.w	#0,Debug_Routine.w		; exit debug mode

.notB		addq.b	#1,$22(a0)			; add 1 to map frame
		cmpi.b	#$FB,$22(a0)
		blo.s	.noreset			; branch if not reached the last one
		move.b	#0,$22(a0)			; set back to frame 0

.noreset	bsr.w	Sonic_LoadDPLC			; load frame graphics
		jmp	DrawSprite			; display sprite
.godebug	jmp	DebugMode			; go to debug mode
; ---------------------------------------------------------------------------

ObjSonic_Normal:
		moveq	#0,d0
		move.b	5(a0),d0
		move.w	.i(pc,d0.w),d1
		jmp	.i(pc,d1.w)

; ---------------------------------------------------------------------------
.i		dc.w .init-.i
		dc.w loc_10BBA-.i
		dc.w loc_122BE-.i
		dc.w loc_12390-.i
		dc.w loc_1257C-.i
		dc.w loc_12590-.i
		dc.w loc_125AC-.i
; ---------------------------------------------------------------------------

.init		addq.b	#2,5(a0)			; next routine
		move.b	#$13,$1E(a0)			; set height
		move.b	#9,$1F(a0)			; set width
		move.b	#$13,$44(a0)			; set default y-radius
		move.b	#9,$45(a0)			; set default x-radius
		move.l	#Map_Sonic,$C(a0)		; set mappings
		move.w	#$100,8(a0)			;
		move.b	#$18,7(a0)
		move.b	#$18,6(a0)
		move.b	#4,4(a0)
		move.b	#0,$38(a0)
		move.w	#$600,(a4)
		move.w	#$C,2(a4)
		move.w	#$80,4(a4)

		move.w	#$680,$A(a0)
		move.b	#$C,$46(a0)
		move.b	#$D,$47(a0)

		move.b	#0,$30(a0)
		move.b	#4,$31(a0)
		move.b	#0,Super_Flag.w
		move.b	#$1E,$2C(a0)
		subi.w	#$20,$10(a0)
		addi.w	#4,$14(a0)
		bsr.w	Reset_Player_Position_Array
		addi.w	#$20,$10(a0)
		subi.w	#4,$14(a0)
		rts
; ---------------------------------------------------------------------------

loc_10BBA:
		tst.w	Debug_Mode_Flag.w
		beq.s	loc_10BF0
		bclr	#6,Ctrl_1_Press.w
		beq.s	loc_10BCE
		eori.b	#1,ReverseGravity_Flag.w

loc_10BCE:
		btst	#4,Ctrl_1_Press.w
		beq.s	loc_10BF0
		move.w	#1,Debug_Routine.w
		clr.b	Control_Locked.w
		btst	#5,Ctrl_1_Held.w
		beq.s	locret_10BEE
		move.w	#2,Debug_Routine.w

locret_10BEE:
		rts
; ---------------------------------------------------------------------------

loc_10BF0:
		tst.b	Control_Locked.w
		bne.s	loc_10BFC
		move.w	Ctrl_1_Held.w,Ctrl_1_Held_Logical.w

loc_10BFC:
		btst	#0,Carried(a0)
		beq.s	loc_10C0C
		sf	jumpmove(a0)

		; reset scroll height
		cmpi.w	#$60,(a5)
		beq.s	.nomv
		bhs.s	.mvup

		addq.w	#4,(a5)
.mvup		subq.w	#2,(a5)
.nomv		bra.s	loc_10C26
; ---------------------------------------------------------------------------

loc_10C0C:
		movem.l	a4-a6,-(sp)
		moveq	#0,d0
		move.b	$2A(a0),d0
		andi.w	#6,d0
		move.w	off_10C90(pc,d0.w),d1
		jsr	off_10C90(pc,d1.w)
		movem.l	(sp)+,a4-a6

loc_10C26:
		cmpi.w	#-$100,Camera_min_Y.w
		bne.s	loc_10C36
		move.w	Screen_Y_wrap_value.w,d0
		and.w	d0,$14(a0)

loc_10C36:
		bsr.s	sub_10C98
		bsr.w	sub_11B30
		bsr.w	sub_10D66
		bsr.w	sub_10E26
		move.b	Player_NextTilt.w,$3A(a0)
		move.b	Player_CurrentTilt.w,$3B(a0)
		tst.b	Player1_OnWater_Flag.w
		beq.s	loc_10C62
		tst.b	$20(a0)
		bne.s	loc_10C62
		move.b	$21(a0),$20(a0)

loc_10C62:
		btst	#1,Carried(a0)
		bne.s	loc_10C7E		; branch if Sonic is carried
		bsr.w	Animate_Sonic
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_10C7A
		eori.b	#2,4(a0)

loc_10C7A:
		bsr.w	Sonic_LoadDPLC

loc_10C7E:
		move.b	Carried(a0),d0
		andi.b	#$A0,d0
		bne.s	locret_10C8E
		jsr	TouchResponse_Normal

locret_10C8E:
		rts

; ---------------------------------------------------------------------------
off_10C90:	dc.w Sonic_Stand_Path-off_10C90
		dc.w Sonic_Stand_Freespace-off_10C90
		dc.w Sonic_Spin_Path-off_10C90
		dc.w Sonic_Spin_Freespace-off_10C90
; ---------------------------------------------------------------------------

sub_10C98:
		move.b	$34(a0),d0
		beq.s	loc_10CA6
		subq.b	#1,$34(a0)
		lsr.b	#3,d0
		bhs.s	loc_10CAC

loc_10CA6:
		jsr	DrawSprite.w

loc_10CAC:
		btst	#1,$2B(a0)
		beq.s	loc_10CE8
		tst.b	$35(a0)
		beq.s	loc_10CE8
		move.b	Level_Frame_Timer+1.w,d0
		andi.b	#7,d0
		bne.s	loc_10CE8
		subq.b	#1,$35(a0)
		bne.s	loc_10CE8
		tst.b	Boss_Active_Flag.w
		bne.s	loc_10CE2
		cmpi.b	#$C,$2C(a0)
		blo.s	loc_10CE2
		move.b	Current_Mus.w,d0
		jsr	PlayMusic.w

loc_10CE2:
		bclr	#1,$2B(a0)

loc_10CE8:
		btst	#2,$2B(a0)
		beq.s	locret_10D40
		tst.b	$36(a0)
		beq.s	locret_10D40
		move.b	Level_Frame_Timer+1.w,d0
		andi.b	#7,d0
		bne.s	locret_10D40
		subq.b	#1,$36(a0)
		bne.s	locret_10D40
		move.w	#$600,(a4)
		move.w	#$C,2(a4)
		move.w	#$80,4(a4)
		tst.b	Super_Flag.w
		beq.s	loc_10D32
		move.w	#$A00,(a4)
		move.w	#$30,2(a4)
		move.w	#$100,4(a4)

loc_10D32:
		bclr	#2,$2B(a0)
		moveq	#0,d0
		jmp	PlayTempo.w

locret_10D40:
		rts
; ---------------------------------------------------------------------------

loc_10D42:
		lea	word_1E3C00,a1
		moveq	#0,d0
		move.b	$38(a0),d0
		lsl.w	#3,d0
		lea	(a1,d0.w),a1
		move.w	(a1)+,(a4)
		move.w	(a1)+,2(a4)
		move.w	(a1)+,4(a4)
		bclr	#2,$2B(a0)
		rts
; ---------------------------------------------------------------------------

sub_10D66:
		cmpa.w	#Object_RAM,a0
		bne.s	locret_10D9E
		move.w	Sonic_Pos_Record_Index.w,d0
		lea	Position_table.w,a1
		lea	(a1,d0.w),a1
		move.w	$10(a0),(a1)+
		move.w	$14(a0),(a1)+
		addq.b	#4,Sonic_Pos_Record_Index+1.w
		lea	Position_table_P2.w,a1
		lea	(a1,d0.w),a1
		move.w	Ctrl_1_Held_Logical.w,(a1)+
		move.b	$2A(a0),(a1)+
		move.b	$A(a0),(a1)+

locret_10D9E:
		rts
; ---------------------------------------------------------------------------

loc_10DA0:
		cmpa.w	#Object_RAM,a0
		bne.s	loc_10DC0
		move.w	Sonic_Pos_Record_Index.w,d0
		lea	Position_table.w,a1
		lea	(a1,d0.w),a1
		move.w	$10(a0),(a1)+
		move.w	$14(a0),(a1)+
		addq.b	#4,Sonic_Pos_Record_Index+1.w
		rts
; ---------------------------------------------------------------------------

loc_10DC0:
		move.w	Tails_Pos_Record_Index.w,d0
		lea	Position_table_P2.w,a1
		lea	(a1,d0.w),a1
		move.w	$10(a0),(a1)+
		move.w	$14(a0),(a1)+
		addq.b	#4,Tails_Pos_Record_Index+1.w
		rts
; ---------------------------------------------------------------------------

Reset_Player_Position_Array:
		cmpa.w	#Object_RAM,a0
		bne.s	loc_10E04
		lea	Position_table.w,a1
		lea	Position_table_P2.w,a2
		move.w	#$3F,d0

loc_10DEC:
		move.w	$10(a0),(a1)+
		move.w	$14(a0),(a1)+
		move.l	#0,(a2)+
		dbf	d0,loc_10DEC
		move.w	#0,Sonic_Pos_Record_Index.w

loc_10E04:
		rts
; ---------------------------------------------------------------------------

sub_10E26:
		tst.b	Water_Flag.w
		bne.s	loc_10E2E

locret_10E2C:
		rts
; ---------------------------------------------------------------------------

loc_10E2E:
		move.w	Water_Height_Default.w,d0
		cmp.w	$14(a0),d0
		bge.s	loc_10EA6
		bset	#6,$2A(a0)
		bne.s	locret_10E2C
		addq.b	#1,Water_Routine.w
		movea.l	a0,a1
		bsr.w	Player_ResetAirTimer
		move.l	#Obj_Air_CountDown,Object_RAM_static+$4A.w
		move.b	#$81,Object_RAM_static+$76.w
		move.l	a0,Object_RAM_static+$8A.w
		move.w	#$300,(a4)
		move.w	#6,2(a4)
		move.w	#$40,4(a4)
		tst.b	Super_Flag.w
		beq.s	loc_10E82
		move.w	#$500,(a4)
		move.w	#$18,2(a4)
		move.w	#$80,4(a4)

loc_10E82:
		tst.b	$2E(a0)
		bne.s	locret_10E2C
		asr	$18(a0)
		asr	$1A(a0)
		asr	$1A(a0)
		beq.s	locret_10E2C
		move.w	#$100,$20(a6)
		move.w	#$39,d0
		jmp	PlaySFX
; ---------------------------------------------------------------------------

loc_10EA6:
		bclr	#6,$2A(a0)
		beq.w	locret_10E2C
		addq.b	#1,Water_Routine.w
		movea.l	a0,a1
		bsr.w	Player_ResetAirTimer
		move.w	#$600,(a4)
		move.w	#$C,2(a4)
		move.w	#$80,4(a4)
		tst.b	Super_Flag.w
		beq.s	loc_10EE0
		move.w	#$A00,(a4)
		move.w	#$30,2(a4)
		move.w	#$100,4(a4)

loc_10EE0:
		cmpi.b	#4,5(a0)
		beq.s	loc_10EFC
		tst.b	$2E(a0)
		bne.s	loc_10EFC
		move.w	$1A(a0),d0
		cmpi.w	#-$400,d0
		blt.s	loc_10EFC
		asl	$1A(a0)

loc_10EFC:
		cmpi.b	#$1C,$20(a0)
		beq.w	locret_10E2C
		tst.w	$1A(a0)
		beq.w	locret_10E2C
		move.w	#$100,$20(a6)
		cmpi.w	#-$1000,$1A(a0)
		bgt.s	loc_10F22
		move.w	#-$1000,$1A(a0)

loc_10F22:
		move.w	#$39,d0
		jmp	PlaySFX
; ---------------------------------------------------------------------------

Sonic_Stand_Path:
		bsr.w	Player_Spindash
		bsr.w	Obj_Sonic_Jump
		bsr.w	sub_11DA6
		bsr.w	Sonic_MoveOnGround
		bsr.w	Player_Spin
		bsr.w	Player_Check_Screen_Boundaries
		jsr	ObjectRevMove
		jsr	Call_Player_AnglePos.w
		bsr.w	sub_11E2A
		tst.b	BG_Layer_Scroll_Timer2+2.w
		beq.s	locret_10F82
		jsr	sub_F846.w
		tst.w	d1
		bmi.w	KillPlayer2
		movem.l	a4-a6,-(sp)
		jsr	ChkWallDist_Left.w
		tst.w	d1
		bpl.s	loc_10F72
		sub.w	d1,$10(a0)

loc_10F72:
		jsr	CheckRightWallDist.w
		tst.w	d1
		bpl.s	loc_10F7E
		add.w	d1,$10(a0)

loc_10F7E:
		movem.l	(sp)+,a4-a6

locret_10F82:
		rts
; ---------------------------------------------------------------------------

Sonic_Stand_Freespace:
		bsr.w	sub_118BC
		bsr.w	sub_1164E
		bsr.w	Player_Check_Screen_Boundaries
		jsr	ObjectGravity
		btst	#6,$2A(a0)
		beq.s	loc_10FD6
		subi.w	#$28,$1A(a0)

loc_10FD6:
		bsr.w	sub_11E8C
		bra.w	sub_11EEC
; ---------------------------------------------------------------------------

Sonic_Spin_Path:
		tst.b	$3D(a0)
		bne.s	loc_10FEA
		bsr.w	Obj_Sonic_Jump

loc_10FEA:
		bsr.w	sub_11DEE
		bsr.w	sub_11508
		bsr.w	Player_Check_Screen_Boundaries
		jsr	ObjectRevMove
		jsr	Call_Player_AnglePos.w
		bsr.w	sub_11E2A
		tst.b	BG_Layer_Scroll_Timer2+2.w
		beq.s	locret_11034
		jsr	sub_F846.w
		tst.w	d1
		bmi.w	KillPlayer2
		movem.l	a4-a6,-(sp)
		jsr	ChkWallDist_Left.w
		tst.w	d1
		bpl.s	loc_11024
		sub.w	d1,$10(a0)

loc_11024:
		jsr	CheckRightWallDist.w
		tst.w	d1
		bpl.s	loc_11030
		add.w	d1,$10(a0)

loc_11030:
		movem.l	(sp)+,a4-a6

locret_11034:
		rts
; ---------------------------------------------------------------------------

Sonic_Spin_Freespace:
		bsr.w	sub_118BC
		bsr.w	sub_1164E
		bsr.w	Player_Check_Screen_Boundaries
		jsr	ObjectGravity
		btst	#6,$2A(a0)
		beq.s	loc_11056
		subi.w	#$28,$1A(a0)

loc_11056:
		bsr.w	sub_11E8C
		bra.w	sub_11EEC
; ---------------------------------------------------------------------------

Sonic_MoveOnGround:
		move.w	(a4),d6				; get player top speed
		move.w	2(a4),d5			; get player acceleration
		move.w	4(a4),d4			; get player deceleration
		tst.b	shistatus(a0)			; check shield status bits
		bmi.w	loc_11332			; branch if negative (infinite inertia set)
		tst.w	movelock(a0)			; check movement lock timer
		bne.w	loc_112EA			; if nonzero, ignore user input

		btst	#2,Ctrl_1_Held_Logical.w	; left dpad check
		beq.s	loc_11086			; if not held, branch
		bsr.w	Sonic_MoveLeft			; run code for left button
		; NOTE: since left and right buttons are physically impossible to be held together,
		; the next check will be false. Regen however fails to address this and allows both to be held.

loc_11086:
		btst	#3,Ctrl_1_Held_Logical.w	; right dpad check
		beq.s	loc_11092			; if not held, branch
		bsr.w	Sonic_MoveRight			; run code for right button

loc_11092:
		move.b	angle(a0),d0			; get collision angle
		addi.b	#$20,d0				; rotate it by 45 degrees
		andi.b	#$C0,d0				; leave only each increment of 90
		bne.w	loc_112EA			; if nonzero (-45 to 45), branch
		tst.w	inertia(a0)			; test inertia
		bne.w	loc_112EA			; if nonzero (player moving), branch

		bclr	#5,status(a0)			; clear pushing flag
		move.b	#5,anim(a0)			; set to standing animation
		btst	#3,status(a0)			; check standing on object flag
		beq.w	loc_11184			; if not set, branch
		movea.w	interact(a0),a1			; get the object Sonic is standing on
		tst.b	status(a1)			; test a flag (Probably onscreen flag of the object. Could check if the object still exists)
		bmi.w	loc_11276			; branch if set

		; the following code checks if Sonic needs to use his balancing animation when on edge of an object or platform
		moveq	#0,d1
		move.b	width(a1),d1			; get width of the platform
		move.w	d1,d2				; copy it to d2
		add.w	d2,d2				; double d2
		subq.w	#2,d2				; and sub 2 from it
		add.w	xpos(a0),d1			; add Sonic's X to d1
		sub.w	xpos(a1),d1			; sub platform X from d1
		; d1 essentially has the offset relative to platform's position.
		; If negative, Sonic is on edge of the platform, if greater than d2 he is on edge of platform
		tst.b	Super_Flag.w			; check if Sonic is super or hyper
		bne.w	loc_110F6			; branch if is
		cmpi.w	#2,d1				;
		blt.s	loc_11146			; branch if Sonic is only 2 pixels in the platform
		cmp.w	d2,d1				; checks the opposed side of the platform
		bge.s	loc_11108			; branch if out from that side too
		bra.w	loc_11276			; branch if Sonic is on the platform still
; ---------------------------------------------------------------------------

loc_110F6:
		cmpi.w	#2,d1				;
		blt.w	loc_11268			; branch if Sonic is only 2 pixels in the platform
		cmp.w	d2,d1				; checks the opposed side of the platform
		bge.w	loc_11258			; branch if out from that side too
		bra.w	loc_11276			; branch if Sonic is on the platform still
; ---------------------------------------------------------------------------
; we go here if Sonic is not super and is right from the platform
loc_11108:
		; this whole check is silly; same code will be ran anyway. It'd be just faster
		; to ouright declare Sonic will be facing a direction
		btst	#0,status(a0)			; check if Sonic is facing left or right
		bne.s	loc_11128			; branch if facing left
		move.b	#6,anim(a0)			; set to balancing animation 1
		addq.w	#6,d2				; increment the right offset by 6
		cmp.w	d2,d1				; check if Sonic is far enough now
		blt.w	loc_112EA			; if not anymore, branch
		move.b	#$C,anim(a0)			; else use balancing animation 2
		bra.w	loc_112EA			; branch
; ---------------------------------------------------------------------------

loc_11128:
		bclr	#0,status(a0)			; face right
		move.b	#6,anim(a0)			; set to balancing animation 1
		addq.w	#6,d2				; increment the right offset by 6
		cmp.w	d2,d1				; check if Sonic is far enough now
		blt.w	loc_112EA			; if not anymore, branch
		move.b	#$C,anim(a0)			; else use balancing animation 2
		bra.w	loc_112EA			; branch
; ---------------------------------------------------------------------------

loc_11146:
		; this whole check is silly; same code will be ran anyway. It'd be just faster
		; to ouright declare Sonic will be facing a direction
		btst	#0,status(a0)			; check if Sonic is facing left or right
		beq.s	loc_11166			; branch if facing right
		move.b	#6,anim(a0)			; set to balancing animation 1
		cmpi.w	#-4,d1				; check if Sonic is even further
		bge.w	loc_112EA			; if not, branch
		move.b	#$C,anim(a0)			; else use balancing animation 2
		bra.w	loc_112EA			; branch
; ---------------------------------------------------------------------------

loc_11166:
		bset	#0,status(a0)			; face left
		move.b	#6,anim(a0)			; set to balancing animation 1
		cmpi.w	#-4,d1				; check if Sonic is even further
		bge.w	loc_112EA			; if not, branch
		move.b	#$C,anim(a0)			; else use balancing animation 2
		bra.w	loc_112EA			; branch
; ---------------------------------------------------------------------------

loc_11184:
		; if not standing on an object, checks if player is on edge of ground
		move.w	xpos(a0),d3			; get current x-position
		jsr	Sonic_CheckFloorEdge.w		; get the height of the floor under Sonic
		cmpi.w	#$C,d1				; compare height with $C
		blt.w	loc_11276			; if height is less than $C, branch
		tst.b	Super_Flag.w			; check if Sonic is super or hyper
		bne.w	loc_11250			; branch if so
		cmpi.b	#3,tiltfront(a0)
		bne.s	loc_111F6			; this test has something to do with direction check

		; this whole check is silly; same code will be ran anyway. It'd be just faster
		; to ouright declare Sonic will be facing a direction
		btst	#0,status(a0)			; check if Sonic is facing left or right
		bne.s	loc_111CE			; branch if facing left
		move.b	#6,anim(a0)			; set to balancing animation 1
		move.w	xpos(a0),d3			; get x-position of player
		subq.w	#6,d3				; sub 6 from it
		jsr	Sonic_CheckFloorEdge.w		; get the height of the floor at x
		cmpi.w	#$C,d1				; compare height with $C
		blt.w	loc_112EA			; if height is less than $C, branch
		move.b	#$C,anim(a0)			; else use balancing animation 2
		bra.w	loc_112EA
; ---------------------------------------------------------------------------

loc_111CE:
		bclr	#0,status(a0)			; face right
		move.b	#6,anim(a0)			; set to balancing animation 1
		move.w	xpos(a0),d3			; get x-position of player
		subq.w	#6,d3				; sub 6 from it
		jsr	Sonic_CheckFloorEdge.w		; get the height of the floor at x
		cmpi.w	#$C,d1				; compare height with $C
		blt.w	loc_112EA			; if height is less than $C, branch
		move.b	#$C,anim(a0)			; else use balancing animation 2
		bra.w	loc_112EA
; ---------------------------------------------------------------------------

loc_111F6:
		cmpi.b	#3,tiltback(a0)
		bne.s	loc_11276			; no clue
		; this whole check is silly; same code will be ran anyway. It'd be just faster
		; to ouright declare Sonic will be facing a direction
		btst	#0,status(a0)			; check if Sonic is facing left or right
		beq.s	loc_11228			; branch if facing right
		move.b	#6,anim(a0)			; set to balancing animation 1
		move.w	xpos(a0),d3			; get x-position of player
		addq.w	#6,d3				; add 6 to it
		jsr	Sonic_CheckFloorEdge.w		; get the height of the floor at x
		cmpi.w	#$C,d1				; compare height with $C
		blt.w	loc_112EA			; if height is less than $C, branch
		move.b	#$C,anim(a0)			; else use balancing animation 2
		bra.w	loc_112EA
; ---------------------------------------------------------------------------

loc_11228:
		bset	#0,status(a0)			; face left
		move.b	#6,anim(a0)			; set to balancing animation 1
		move.w	xpos(a0),d3			; get x-position of player
		addq.w	#6,d3				; add 6 to it
		jsr	Sonic_CheckFloorEdge.w		; get the height of the floor at x
		cmpi.w	#$C,d1				; compare height with $C
		blt.w	loc_112EA			; if height is less than $C, branch
		move.b	#$C,anim(a0)			; else use balancing animation 2
		bra.w	loc_112EA
; ---------------------------------------------------------------------------

loc_11250:
		cmpi.b	#3,tiltfront(a0)
		bne.s	loc_11260			; no clue

loc_11258:
		bclr	#0,status(a0)			; face right
		bra.s	loc_1126E

loc_11260:
		cmpi.b	#3,tiltback(a0)
		bne.s	loc_11276			; no clue

loc_11268:
		bset	#0,status(a0)			; face left

loc_1126E:
		move.b	#6,anim(a0)			; set to balancing animation 1
		bra.s	loc_112EA
; ---------------------------------------------------------------------------

loc_11276:
		; we go here if tilt checks fail, checks if screen should move up or down
		btst	#1,Ctrl_1_Held_Logical.w	; check if down is pressed
		beq.s	loc_112B0			; if not, branch
		; there should probably be a check to make sure this doesnt happen when player is balancing
		move.b	#8,anim(a0)			; ducking animation
		addq.b	#1,scrolldelay(a0)		; add 1 to the scroll delay
		cmpi.b	#60,scrolldelay(a0)		; have 120 frames passed
		blo.s	loc_112F0			; if not, then branch
		move.b	#60,scrolldelay(a0)		; make sure there is no overflow

		tst.b	ReverseGravity_Flag.w		; check if reverse gravity is active
		bne.s	loc_112A6			; if is, branch
		cmpi.w	#8,(a5)				; check if Sonic is 8 pixels from top of screen (camera, no boundaries)
		beq.s	loc_112FC			; if so, branch
		subq.w	#2,(a5)				; sub 2 from the offset
		bra.s	loc_112FC
; ---------------------------------------------------------------------------

loc_112A6:
		cmpi.w	#216,(a5)			; check if Sonic is 216 pixels from top of screen (camera, no boundaries)
		beq.s	loc_112FC			; if so, branch
		addq.w	#2,(a5)				; add 2 to the offset
		bra.s	loc_112FC
; ---------------------------------------------------------------------------

loc_112B0:
		btst	#0,Ctrl_1_Held_Logical.w	; check if up is pressed
		beq.s	loc_112EA			; if not, branch
		; there should probably be a check to make sure this doesnt happen when player is balancing
		move.b	#7,anim(a0)			; looing up animation
		addq.b	#1,scrolldelay(a0)		; add 1 to the scroll delay
		cmpi.b	#60,scrolldelay(a0)		; have 120 frames passed
		blo.s	loc_112F0			; if not, then branch
		move.b	#60,scrolldelay(a0)		; make sure there is no overflow

		tst.b	ReverseGravity_Flag.w		; check if reverse gravity is active
		bne.s	loc_112E0			; if is, branch
		cmpi.w	#200,(a5)			; check if Sonic is 200 pixels from top of screen (camera, no boundaries)
		beq.s	loc_112FC			; if so, branch
		addq.w	#2,(a5)				; add 2 to the offset
		bra.s	loc_112FC
; ---------------------------------------------------------------------------

loc_112E0:
		cmpi.w	#24,(a5)			; check if Sonic is 24 pixels from top of screen (camera, no boundaries)
		beq.s	loc_112FC			; if so, branch
		subq.w	#2,(a5)				; sub 2 from the offset
		bra.s	loc_112FC
; ---------------------------------------------------------------------------

loc_112EA:
		; if not looking up or down
		move.b	#0,scrolldelay(a0)		; clear scroll delay

loc_112F0:
		cmpi.w	#96,(a5)			; check if camera is on its default offset
		beq.s	loc_112FC			; if so, branch
		bhs.s	loc_112FA			; if camera is above it, branch
		addq.w	#4,(a5)				; add 4 (4-2 = 2) from height

loc_112FA:
		subq.w	#2,(a5)				; sub 2 from height

loc_112FC:
		; and this is where all the code flows down to
		tst.b	Super_Flag.w			; check if Sonic is super or hyper
		beq.s	loc_11306			; branch if not super
		move.w	#$C,d5				; set acceleration(?)

loc_11306:
		move.b	Ctrl_1_Held_Logical.w,d0	; get held buttons
		andi.b	#$C,d0				; get only right and left
		bne.s	loc_11332			; if neither set, branch
		move.w	inertia(a0),d0			; get inertia
		beq.s	loc_11332			; if 0, branch
		bmi.s	loc_11326			; if negative, branch
		sub.w	d5,d0				; sub acceleration from inertia
		bhs.s	loc_11320			; if inertia is higher than acceleration
		move.w	#0,d0				; set inertia to 0

loc_11320:
		move.w	d0,inertia(a0)			; put d0 to inertia
		bra.s	loc_11332
; ---------------------------------------------------------------------------

loc_11326:
		add.w	d5,d0				; add acceleration to inertia
		bhs.s	loc_1132E			; if inertia is higher than acceleration
		move.w	#0,d0				; set inertia to 0

loc_1132E:
		move.w	d0,inertia(a0)			; put d0 to inertia

loc_11332:
		move.b	angle(a0),d0			; get player angle
		jsr	GetSine				; calculate sine and cosine
		muls.w	inertia(a0),d1			; multiply cosine with inertia
		asr.l	#8,d1				; shift right 8 bits (divide by 256)
		move.w	d1,xvel(a0)			; set x-velocity
		muls.w	inertia(a0),d0			; multiply sine with inertia
		asr.l	#8,d0				; shift right 8 bits (divide by 256)
		move.w	d0,yvel(a0)			; set y-velocity

loc_11350:
		btst	#6,carried(a0)
		bne.s	locret_113CE			; no clue
		move.b	angle(a0),d0			; get angle
		andi.b	#$3F,d0				; get each quadrant
		beq.s	loc_11370			; if 0, branch
		move.b	angle(a0),d0			; get angle again
		addi.b	#$40,d0				; add 90 degrees
		bmi.w	locret_113CE			; if negative (angle is 90-270 degrees)

loc_11370:
		move.b	#$40,d1				; put $40 (90 degrees) in d1
		tst.w	inertia(a0)			; test inertia
		beq.s	locret_113CE			; if 0, end
		bmi.s	loc_1137E			; if negative, branch
		neg.w	d1				; negate angle (-90 degrees)

loc_1137E:
		move.b	angle(a0),d0			; get angle
		add.b	d1,d0				; add angle rotation (90 or -90 degrees)
		move.w	d0,-(sp)			; store it
		jsr	CalcRoomInFront.w		; if there is a wall nearby, get its width
		move.w	(sp)+,d0			; pop the angle
		tst.w	d1				; check if there was a wall
		bpl.s	locret_113CE			; if positive, no wall
		asl.w	#8,d1				; shift left 8 bits (multiply by 256)

		addi.b	#$20,d0				; add 45 degrees to angle
		andi.b	#$C0,d0				; get each 90 degree angle
		beq.s	loc_113F0			; if 0, branch
		cmpi.b	#$40,d0
		beq.s	loc_113D6			; if 90 degrees, branch
		cmpi.b	#$80,d0
		beq.s	loc_113D0			; if 180 degrees, branch

		; we go here if its 270 degrees
		add.w	d1,xvel(a0)			; add wall offset*256 to x-velocity (no clue why)
		move.w	#0,inertia(a0)			; clear inertia
		btst	#0,status(a0)			; check if Sonic is facing left or right
		bne.s	locret_113CE			; branch if facing left
		bset	#5,status(a0)			; set pushing bit

locret_113CE:
		rts
; ---------------------------------------------------------------------------

loc_113D0:
		sub.w	d1,yvel(a0)			; sub wall offset*256 from y-velocity (no clue why)
		rts
; ---------------------------------------------------------------------------

loc_113D6:
		sub.w	d1,xvel(a0)			; sub wall offset*256 from x-velocity (no clue why)
		move.w	#0,inertia(a0)			; clear inertia
		btst	#0,status(a0)			; check if Sonic is facing left or right
		beq.s	locret_113CE			; branch if facing right
		bset	#5,status(a0)			; set pushing bit
		rts
; ---------------------------------------------------------------------------

loc_113F0:
		add.w	d1,yvel(a0)			; add wall offset*256 to y-velocity (no clue why)

locret_113F4:
		rts
; ---------------------------------------------------------------------------

Sonic_MoveLeft:
		move.w	inertia(a0),d0			; get inertia
		beq.s	loc_113FE			; if 0, branch
		bpl.s	loc_11430			; if positive, branch

loc_113FE:
		bset	#0,status(a0)			; face left
		bne.s	loc_11412			; if was already, branch
		bclr	#5,status(a0)			; clear pushing bit
		st	anilast(a0)			; reset walking animation

loc_11412:
		sub.w	d5,d0				; sub acceleration from inertia
		move.w	d6,d1				; copy top speed to d1
		neg.w	d1				; negate to speed
		cmp.w	d1,d0				; compare inertia and top speed
		bgt.s	loc_11424			; if top speed is lower than inertia, branch
		add.w	d5,d0				; add acceleration to inertia
		cmp.w	d1,d0				; compare inertia and top speed
		ble.s	loc_11424			; if top speed is higher than inertia, branch
		move.w	d1,d0				; limit inertia to top speed

loc_11424:
		move.w	d0,inertia(a0)			; set inertia
		clr.b	anim(a0)			; set to walking animation
		rts
; ---------------------------------------------------------------------------

loc_11430:
		sub.w	d4,d0				; sub deceleration from inertia
		bhs.s	loc_11438			; if inertia is less than deceleration
		move.w	#-$80,d0			; set inertia to -$80

loc_11438:
		move.w	d0,inertia(a0)			; set inertia
		move.b	angle(a0),d0			; get angle
		addi.b	#$20,d0				; add 45 to angle
		andi.b	#$C0,d0				; get each 90 degree angle
		bne.s	locret_11480			; if not 0 (angle between -45 and 45 degrees), branch

		cmpi.w	#$400,d0			; check if inertia is $400
		blt.s	locret_11480			; if is less, branch
		tst.b	unk2D(a0)
		bmi.s	locret_11480			; no clue
		move.w	#$36,d0
		jsr	PlaySFX				; play stopping sfx
		move.b	#$D,anim(a0)			; set to stopping animation
		bclr	#0,status(a0)			; face right
		cmpi.b	#$C,airleft(a0)			; check how much air we have left
		blo.s	locret_11480			; if less than normal, branch (this is essentially underwater check, no clue why it doesnt check bit 6 of status)
		move.b	#6,routine(a6)			; create stopping dust
		move.b	#$15,frame(a6)			; set correct frame for it

locret_11480:
		rts
; ---------------------------------------------------------------------------

Sonic_MoveRight:
		move.w	inertia(a0),d0			; get inertia
		bmi.s	loc_114B6			; if negative, branch
		bclr	#0,status(a0)			; face right
		beq.s	loc_1149C			; if was already, branch
		bclr	#5,status(a0)			; clear pushing bit
		move.b	#1,anilast(a0)			; reset walking animation

loc_1149C:
		add.w	d5,d0				; add acceleration to inertia
		cmp.w	d6,d0				; compare inertia and top speed
		blt.s	loc_114AA			; if top speed is lower than inertia, branch
		sub.w	d5,d0				; sub acceleration from inertia
		cmp.w	d6,d0				; compare inertia and top speed
		bge.s	loc_114AA			; if top speed is higher than inertia, branch
		move.w	d6,d0				; limit inertia to top speed

loc_114AA:
		move.w	d0,inertia(a0)			; set inertia
		clr.b	anim(a0)			; set to walking animation
		rts
; ---------------------------------------------------------------------------

loc_114B6:
		add.w	d4,d0				; add deceleration to inertia
		bhs.s	loc_114BE			; if inertia is less than deceleration
		move.w	#$80,d0				; set inertia to $80

loc_114BE:
		move.w	d0,inertia(a0)			; set inertia
		move.b	angle(a0),d0			; get angle
		addi.b	#$20,d0				; add 45 to angle
		andi.b	#$C0,d0				; get each 90 degree angle
		bne.s	locret_11506			; if not 0 (angle between -45 and 45 degrees), branch

		cmpi.w	#-$400,d0			; check if inertia is -$400
		bgt.s	locret_11506			; if is more, branch
		tst.b	unk2D(a0)
		bmi.s	locret_11506			; no clue
		move.w	#$36,d0
		jsr	PlaySFX				; play stopping sfx
		move.b	#$D,anim(a0)			; set to stopping animation
		bset	#0,status(a0)			; face right
		cmpi.b	#$C,airleft(a0)			; check how much air we have left
		blo.s	locret_11506			; if less than normal, branch (this is essentially underwater check, no clue why it doesnt check bit 6 of status)
		move.b	#6,routine(a6)			; create stopping dust
		move.b	#$15,frame(a6)			; set correct frame for it

locret_11506:
		rts
; ---------------------------------------------------------------------------

sub_11508:
		move.w	(a4),d6
		asl.w	#1,d6
		move.w	2(a4),d5
		asr.w	#1,d5
		tst.b	Super_Flag.w
		beq.s	loc_1151C
		move.w	#6,d5

loc_1151C:
		move.w	#$20,d4
		tst.b	$3D(a0)
		bmi.w	loc_115C6
		tst.b	$2B(a0)
		bmi.w	loc_115C6
		tst.w	$32(a0)
		bne.s	loc_1154E
		btst	#2,Ctrl_1_Held_Logical.w
		beq.s	loc_11542
		bsr.w	sub_11608

loc_11542:
		btst	#3,Ctrl_1_Held_Logical.w
		beq.s	loc_1154E
		bsr.w	sub_1162C

loc_1154E:
		move.w	$1C(a0),d0
		beq.s	loc_11570
		bmi.s	loc_11564
		sub.w	d5,d0
		bhs.s	loc_1155E
		move.w	#0,d0


; ---------------------------------------------------------------------------

loc_1155E:
		move.w	d0,$1C(a0)
		bra.s	loc_11570

loc_11564:
		add.w	d5,d0
		bhs.s	loc_1156C
		move.w	#0,d0

loc_1156C:
		move.w	d0,$1C(a0)

loc_11570:
		move.w	$1C(a0),d0
		bpl.s	loc_11578
		neg.w	d0

loc_11578:
		cmpi.w	#$80,d0
		bhs.s	loc_115C6
		tst.b	$3D(a0)
		bne.s	loc_115B4
		bclr	#2,$2A(a0)
		move.b	$1E(a0),d0
		move.b	$44(a0),$1E(a0)
		move.b	$45(a0),$1F(a0)
		move.b	#5,$20(a0)
		sub.b	$44(a0),d0
		ext.w	d0
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_115AE
		neg.w	d0


; ---------------------------------------------------------------------------

loc_115AE:
		add.w	d0,$14(a0)
		bra.s	loc_115C6

loc_115B4:
		move.w	#$400,$1C(a0)
		btst	#0,$2A(a0)
		beq.s	loc_115C6
		neg.w	$1C(a0)

loc_115C6:
		cmpi.w	#$60,(a5)
		beq.s	loc_115D2
		bhs.s	loc_115D0
		addq.w	#4,(a5)

loc_115D0:
		subq.w	#2,(a5)

loc_115D2:
		move.b	$26(a0),d0
		jsr	GetSine
		muls.w	$1C(a0),d0
		asr.l	#8,d0
		move.w	d0,$1A(a0)
		muls.w	$1C(a0),d1
		asr.l	#8,d1
		cmpi.w	#$1000,d1
		ble.s	loc_115F6
		move.w	#$1000,d1

loc_115F6:
		cmpi.w	#-$1000,d1
		bge.s	loc_11600
		move.w	#-$1000,d1


; End of function sub_11508
; ############### S U B	R O U T	I N E #######################################

loc_11600:
		move.w	d1,$18(a0)
		bra.w	loc_11350

sub_11608:
		move.w	$1C(a0),d0
		beq.s	loc_11610
		bpl.s	loc_1161E


; ---------------------------------------------------------------------------

loc_11610:
		bset	#0,$2A(a0)
		move.b	#2,$20(a0)
		rts

loc_1161E:
		sub.w	d4,d0
		bhs.s	loc_11626
		move.w	#-$80,d0


; End of function sub_11608
; ############### S U B	R O U T	I N E #######################################

loc_11626:
		move.w	d0,$1C(a0)
		rts


; ---------------------------------------------------------------------------

sub_1162C:
		move.w	$1C(a0),d0
		bmi.s	loc_11640
		bclr	#0,$2A(a0)
		move.b	#2,$20(a0)
		rts

loc_11640:
		add.w	d4,d0
		bhs.s	loc_11648
		move.w	#$80,d0


; End of function sub_1162C
; ############### S U B	R O U T	I N E #######################################

loc_11648:
		move.w	d0,$1C(a0)
		rts

sub_1164E:
		move.w	(a4),d6
		move.w	2(a4),d5
		asl.w	#1,d5
		btst	#4,$2A(a0)
		bne.s	loc_116A2
		move.w	$18(a0),d0
		btst	#2,Ctrl_1_Held_Logical.w
		beq.s	loc_11682
		bset	#0,$2A(a0)
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	loc_11682
		add.w	d5,d0
		cmp.w	d1,d0
		ble.s	loc_11682
		move.w	d1,d0

loc_11682:
		btst	#3,Ctrl_1_Held_Logical.w
		beq.s	loc_1169E
		bclr	#0,$2A(a0)
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	loc_1169E
		sub.w	d5,d0
		cmp.w	d6,d0
		bge.s	loc_1169E
		move.w	d6,d0

loc_1169E:
		move.w	d0,$18(a0)

loc_116A2:
		cmpi.w	#$60,(a5)
		beq.s	loc_116AE
		bhs.s	loc_116AC
		addq.w	#4,(a5)

loc_116AC:
		subq.w	#2,(a5)

loc_116AE:
		cmpi.w	#-$400,$1A(a0)
		blo.s	locret_116DC
		move.w	$18(a0),d0
		move.w	d0,d1
		asr.w	#5,d1
		beq.s	locret_116DC
		bmi.s	loc_116D0
		sub.w	d1,d0
		bhs.s	loc_116CA
		move.w	#0,d0


; ---------------------------------------------------------------------------

loc_116CA:
		move.w	d0,$18(a0)
		rts

loc_116D0:
		sub.w	d1,d0
		blo.s	loc_116D8
		move.w	#0,d0

loc_116D8:
		move.w	d0,$18(a0)

locret_116DC:
		rts
; End of function sub_1164E
; ############### S U B	R O U T	I N E #######################################

Player_Check_Screen_Boundaries:
		move.l	xpos(a0),d1
		move.w	xvel(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d1
		swap	d1
		move.w	Camera_min_X.w,d0
		addi.w	#$10,d0
		cmp.w	d1,d0
		bhi.s	loc_11732
		move.w	Camera_max_X.w,d0
		addi.w	#$128,d0
		cmp.w	d1,d0
		blo.s	loc_11732

loc_11706:
		tst.b	BG_Layer_Scroll_Timer2+3.w
		bne.s	locret_11720
		tst.b	ReverseGravity_Flag.w
		bne.s	loc_11722
		move.w	Camera_max_Y.w,d0
		addi.w	#$E0,d0
		cmp.w	ypos(a0),d0
		blt.s	loc_1172C

locret_11720:
		rts
; ---------------------------------------------------------------------------

loc_11722:
		move.w	Camera_min_Y.w,d0
		cmp.w	ypos(a0),d0
		blt.s	locret_11720

loc_1172C:
		addq.w	#4,sp		; do not return to sender
		jmp	KillPlayer2
; ---------------------------------------------------------------------------

loc_11732:
		move.w	d0,xpos(a0)
		clr.w	xpos+2(a0)
		clr.w	xvel(a0)
		clr.w	inertia(a0)
		bra.s	loc_11706
; ---------------------------------------------------------------------------

Player_Spin:
		tst.b	shistatus(a0)
		bmi.s	locret_1177E
		move.b	Ctrl_1_Held_Logical.w,d0
		andi.b	#$C,d0
		bne.s	locret_1177E
		btst	#1,Ctrl_1_Held_Logical.w
		beq.s	loc_11780
		move.w	inertia(a0),d0
		bpl.s	loc_1176A
		neg.w	d0

loc_1176A:
		cmpi.w	#$100,d0
		bhs.s	loc_11790
		btst	#3,$2A(a0)
		bne.s	locret_1177E
		cmp.b	#6,anim(a0)
		beq.s	locret_1177E
		cmp.b	#$C,anim(a0)
		beq.s	locret_1177E
		move.b	#8,$20(a0)

locret_1177E:
		rts
; ---------------------------------------------------------------------------

loc_11780:
		cmpi.b	#8,$20(a0)
		bne.s	locret_1177E
		clr.b	$20(a0)
		rts
; ---------------------------------------------------------------------------

loc_11790:
		btst	#2,$2A(a0)
		bne.s	locret_1177E

loc_1179A:
		bset	#2,$2A(a0)
		move.w	#$E07,$1E(a0)
		move.b	#2,$20(a0)
		addq.w	#5,$14(a0)
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_117C2
		subi.w	#$A,$14(a0)

loc_117C2:
		move.w	#$3C,d0
		jsr	PlaySFX.w
		tst.w	$1C(a0)
		bne.s	locret_117D8
		move.w	#$200,$1C(a0)

locret_117D8:
		rts
; ---------------------------------------------------------------------------

Obj_Sonic_Jump:
		move.b	Ctrl_1_Press_Logical.w,d0
		andi.b	#$70,d0
		beq.w	locret_118B2
		moveq	#0,d0
		move.b	$26(a0),d0
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_117FC
		addi.b	#$40,d0
		neg.b	d0
		subi.b	#$40,d0

loc_117FC:
		addi.b	#-$80,d0
		movem.l	a4-a6,-(sp)
		jsr	CalcRoomOverHead.w
		movem.l	(sp)+,a4-a6
		cmpi.w	#6,d1
		blt.w	locret_118B2
		move.w	#$680,d2
		tst.b	Super_Flag.w
		beq.s	loc_11822
		move.w	#$800,d2

loc_11822:
		btst	#6,$2A(a0)
		beq.s	loc_1182E
		move.w	#$380,d2

loc_1182E:
		moveq	#0,d0
		move.b	$26(a0),d0
		subi.b	#$40,d0
		jsr	GetSine
		muls.w	d2,d1
		asr.l	#8,d1
		add.w	d1,$18(a0)
		muls.w	d2,d0
		asr.l	#8,d0
		add.w	d0,$1A(a0)
		bset	#1,$2A(a0)
		bclr	#5,$2A(a0)
		addq.l	#4,sp
		move.b	#1,$40(a0)
		clr.b	$3C(a0)
		move.w	#$62,d0
		jsr	PlaySFX
		move.b	$44(a0),$1E(a0)
		move.b	$45(a0),$1F(a0)
		btst	#2,$2A(a0)
		bne.s	loc_118B4
		move.b	#$E,$1E(a0)
		move.b	#7,$1F(a0)
		move.b	#2,$20(a0)
		bset	#2,$2A(a0)
		move.b	$1E(a0),d0
		sub.b	$44(a0),d0
		ext.w	d0
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_118AE
		neg.w	d0

loc_118AE:
		sub.w	d0,$14(a0)


; ---------------------------------------------------------------------------

locret_118B2:
		rts


; End of function Obj_Sonic_Jump
; ############### S U B	R O U T	I N E #######################################

loc_118B4:
		bset	#4,$2A(a0)
		rts

sub_118BC:
		tst.b	$40(a0)
		beq.s	loc_118EA
		move.w	#-$400,d1
		btst	#6,$2A(a0)
		beq.s	loc_118D2
		move.w	#-$200,d1

loc_118D2:
		cmp.w	$1A(a0),d1
		ble.w	loc_11900
		move.b	Ctrl_1_Held_Logical.w,d0
		andi.b	#$70,d0
		bne.s	locret_118E8
		move.w	d1,$1A(a0)


; ---------------------------------------------------------------------------

locret_118E8:
		rts

loc_118EA:
		cmpi.w	#$FC0,$1A(a0)
		ble.s	locret_118FE
		move.w	#$FC0,$1A(a0)

locret_118FE:
		rts


; ---------------------------------------------------------------------------

loc_11900:
		tst.b	$2F(a0)
		bne.w	locret_11A14
		move.b	Ctrl_1_Press_Logical.w,d0
		andi.b	#$70,d0
		beq.w	locret_11A14
		bclr	#4,$2A(a0)
		tst.b	Super_Flag.w
		beq.s	loc_1192C
		bmi.w	loc_11A96
		move.b	#1,$2F(a0)
		rts

loc_1192C:
		btst	#1,$2B(a0)
		bne.w	locret_11A14
		btst	#4,$2B(a0)
		beq.s	loc_1197A
		move.b	#1,Obj_shield+$20.w
		move.b	#1,$2F(a0)
		move.w	#$800,d0
		btst	#0,$2A(a0)
		beq.s	loc_11958
		neg.w	d0


; ---------------------------------------------------------------------------

loc_11958:
		move.w	d0,$18(a0)
		move.w	d0,$1C(a0)
		move.w	#0,$1A(a0)
		move.w	#$2000,Horiz_Scroll_Delay_Val.w
		bsr.w	Reset_Player_Position_Array
		move.w	#$43,d0
		jmp	PlaySFX


; ---------------------------------------------------------------------------

loc_1197A:
		btst	#5,$2B(a0)
		beq.s	loc_119A2
		move.b	#1,Obj_shield+$20.w
		move.b	#1,$2F(a0)
		move.w	#-$580,$1A(a0)
		clr.b	$40(a0)
		move.w	#$45,d0
		jmp	PlaySFX


; ---------------------------------------------------------------------------

loc_119A2:
		btst	#6,$2B(a0)
		beq.s	loc_119D2
		move.b	#1,Obj_shield+$20.w
		move.b	#1,$2F(a0)
		move.w	#0,$18(a0)
		move.w	#0,$1C(a0)
		move.w	#$800,$1A(a0)
		move.w	#$44,d0
		jmp	PlaySFX

loc_119D2:
		btst	#0,$2B(a0)
		bne.s	locret_11A14
		move.b	#1,Obj_shield+$20.w
		move.b	#1,$2F(a0)
		move.w	#$42,d0
		jmp	PlaySFX

locret_11A14:
		rts
; ---------------------------------------------------------------------------

loc_11A96:
		bsr.w	HyperTouchResponse
		move.w	#$2000,Horiz_Scroll_Delay_Val.w
		bsr.w	Reset_Player_Position_Array
		move.b	#1,Obj_shield+$20.w
		move.b	#1,$2F(a0)
		moveq	#-$4A,d0
		jsr	PlaySFX
		move.b	Ctrl_1_Held_Logical.w,d0
		andi.w	#$F,d0
		beq.s	loc_11AE0
		cmpi.b	#$B,d0
		bhs.s	loc_11AE0
		lsl.w	#2,d0
		lea	loc_11AF6+4(pc,d0.w),a1
		move.w	(a1)+,d0
		move.w	d0,$18(a0)
		move.w	d0,$1C(a0)
		move.w	(a1)+,d0
		move.w	d0,$1A(a0)
		rts

loc_11AE0:
		move.w	#$800,d0
		btst	#0,$2A(a0)
		beq.s	loc_11AEE
		neg.w	d0

loc_11AEE:
		move.w	d0,$18(a0)
		move.w	d0,$1C(a0)


; End of function sub_118BC
; ---------------------------------------------------------------------------


; ---------------------------------------------------------------------------

loc_11AF6:
		move.w	#0,$1A(a0)
		rts
		dc.w	  0, $F800
		dc.w	  0,  $800
		dc.w	  0,	 0
		dc.w  $F800,	 0
		dc.w  $F800, $F800
		dc.w  $F800,  $800
		dc.w	  0,	 0
		dc.w   $800,	 0
		dc.w   $800, $F800
		dc.w   $800,  $800


; ############### S U B	R O U T	I N E #######################################

loc_11B26:
		tst.b	Super_Tails_Flag.w
		beq.w	locret_11BDC
		bra.s	loc_11B38

sub_11B30:
		tst.b	Super_Flag.w
		beq.w	locret_11BDC

loc_11B38:
		subq.w	#1,Super_SecondCounter.w
		bpl.w	locret_11BDC
		move.w	#$3C,Super_SecondCounter.w
		tst.w	Ring_Count.w
		beq.s	loc_11B7C
		ori.b	#1,Update_HUD_Rings.w
		cmpi.w	#1,Ring_Count.w
		beq.s	loc_11B70
		cmpi.w	#$A,Ring_Count.w
		beq.s	loc_11B70
		cmpi.w	#$64,Ring_Count.w
		bne.s	loc_11B76

loc_11B70:
		ori.b	#$80,Update_HUD_Rings.w

loc_11B76:
		subq.w	#1,Ring_Count.w
		bne.w	locret_11BDC

loc_11B7C:
		move.b	#2,Super_PalCycle_Flag.w
		move.w	#$1E,Super_PalCycle_Frame.w
		sf	Super_Flag.w
		sf	Super_Tails_Flag.w
		st	Player1_Current_Frame.w
		tst.b	charnum(a0)
		bne.s	loc_11BA8
		move.l	#Map_Sonic,$C(a0)

loc_11BA8:
		; this will give Sonic correct shield
		move.b	shistatus(a0),d0
		and.b	#$70,d0		; get only shields
		bne.s	.chkFire	; branch if we have none
		move.l	#Obj_Insta_Shield,Obj_shield.w	; set shield type to insta shield
		move.w	a0,Obj_shield+parent.w		; set parent object
		bra.s	.none

.chkFire	btst	#4,d0		; fire check
		beq.s	.chklight
		move.l	#Obj_Fire_Shield,Obj_shield.w	; set shield type to fire shield
		move.w	a0,Obj_shield+parent.w		; set parent object

.chklight	btst	#5,d0		; lightning check
		beq.s	.chkBubble
		move.l	#Obj_Lightning_Shield,Obj_shield.w; set shield type to lightning shield
		move.w	a0,Obj_shield+parent.w		; set parent object

.chkBubble	btst	#6,d0		; bubble check
		beq.s	.none
		move.l	#Obj_Bubble_Shield,Obj_shield.w	; set shield type to bubble shield
		move.w	a0,Obj_shield+parent.w		; set parent object

.none		move.b	#1,$21(a0)
		move.b	#1,$35(a0)
		move.w	#$600,(a4)
		move.w	#$C,2(a4)
		move.w	#$80,4(a4)
		btst	#6,$2A(a0)
		beq.s	locret_11BDC
		move.w	#$300,(a4)
		move.w	#6,2(a4)
		move.w	#$40,4(a4)


; End of function sub_11B30
; ############### S U B	R O U T	I N E #######################################

locret_11BDC:
		rts

Player_Spindash:
		tst.b	$3D(a0)
		bne.s	loc_11C5E
		cmpi.b	#8,$20(a0)
		bne.s	locret_11C5C
		move.b	Ctrl_1_Press_Logical.w,d0
		andi.b	#$70,d0
		beq.w	locret_11C5C
		move.b	#9,$20(a0)
		move.w	#$FFAB,d0
		jsr	PlaySFX
		addq.l	#4,sp
		move.b	#1,$3D(a0)
		move.w	#0,$3E(a0)
		cmpi.b	#$C,$2C(a0)
		blo.s	loc_11C24
		move.b	#2,$20(a6)

loc_11C24:
		bsr.w	Player_Check_Screen_Boundaries
		jsr	Call_Player_AnglePos.w
		tst.b	BG_Layer_Scroll_Timer2+2.w
		beq.s	locret_11C5C
		jsr	sub_F846.w
		tst.w	d1
		bmi.w	KillPlayer2
		movem.l	a4-a6,-(sp)
		jsr	ChkWallDist_Left.w
		tst.w	d1
		bpl.s	loc_11C4C
		sub.w	d1,$10(a0)

loc_11C4C:
		jsr	CheckRightWallDist.w
		tst.w	d1
		bpl.s	loc_11C58
		add.w	d1,$10(a0)

loc_11C58:
		movem.l	(sp)+,a4-a6


; ---------------------------------------------------------------------------

locret_11C5C:
		rts

loc_11C5E:
		move.b	Ctrl_1_Held_Logical.w,d0
		btst	#1,d0
		bne.w	loc_11D16
		move.b	#$E,$1E(a0)
		move.b	#7,$1F(a0)
		move.b	#2,$20(a0)
		addq.w	#5,$14(a0)
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_11C8C
		subi.w	#$A,$14(a0)

loc_11C8C:
		move.b	#0,$3D(a0)
		moveq	#0,d0
		move.b	$3E(a0),d0
		add.w	d0,d0
		move.w	word_11CF2(pc,d0.w),$1C(a0)
		tst.b	Super_Flag.w
		beq.s	loc_11CAC
		move.w	word_11D04(pc,d0.w),$1C(a0)

loc_11CAC:
		move.w	$1C(a0),d0
		subi.w	#$800,d0
		add.w	d0,d0
		andi.w	#$1F00,d0
		neg.w	d0
		addi.w	#$2000,d0
		lea	Horiz_Scroll_Delay_Val.w,a1

loc_11CCE:
		move.w	d0,(a1)
		btst	#0,$2A(a0)
		beq.s	loc_11CDC
		neg.w	$1C(a0)


; ---------------------------------------------------------------------------

loc_11CDC:
		bset	#2,$2A(a0)
		move.b	#0,$20(a6)
		moveq	#-$4A,d0
		jsr	PlaySFX
		bra.s	loc_11D5E

word_11CF2:
		dc.w $800
		dc.w $880
		dc.w $900
		dc.w $980
		dc.w $A00
		dc.w $A80
		dc.w $B00
		dc.w $B80
		dc.w $C00


; ---------------------------------------------------------------------------

word_11D04:
		dc.w $B00
		dc.w $B80
		dc.w $C00
		dc.w $C80
		dc.w $D00
		dc.w $D80
		dc.w $E00
		dc.w $E80
		dc.w $F00

loc_11D16:
		tst.w	$3E(a0)
		beq.s	loc_11D2E
		move.w	$3E(a0),d0
		lsr.w	#5,d0
		sub.w	d0,$3E(a0)
		bhs.s	loc_11D2E
		move.w	#0,$3E(a0)

loc_11D2E:
		move.b	Ctrl_1_Press_Logical.w,d0
		andi.b	#$70,d0
		beq.w	loc_11D5E
		move.w	#$900,$20(a0)
		move.w	#$FFAB,d0
		jsr	PlaySFX
		addi.w	#$200,$3E(a0)
		cmpi.w	#$800,$3E(a0)
		blo.s	loc_11D5E
		move.w	#$800,$3E(a0)

loc_11D5E:
		addq.l	#4,sp
		cmpi.w	#$60,(a5)
		beq.s	loc_11D6C
		bhs.s	loc_11D6A
		addq.w	#4,(a5)

loc_11D6A:
		subq.w	#2,(a5)

loc_11D6C:
		bsr.w	Player_Check_Screen_Boundaries
		jsr	Call_Player_AnglePos.w
		tst.b	BG_Layer_Scroll_Timer2+2.w
		beq.s	locret_11DA4
		jsr	sub_F846.w
		tst.w	d1
		bmi.w	KillPlayer2
		movem.l	a4-a6,-(sp)
		jsr	ChkWallDist_Left.w
		tst.w	d1
		bpl.s	loc_11D94
		sub.w	d1,$10(a0)

loc_11D94:
		jsr	CheckRightWallDist.w
		tst.w	d1
		bpl.s	loc_11DA0
		add.w	d1,$10(a0)

loc_11DA0:
		movem.l	(sp)+,a4-a6


; End of function Player_Spindash
; ############### S U B	R O U T	I N E #######################################

locret_11DA4:
		rts

sub_11DA6:
		move.b	$26(a0),d0
		addi.b	#$60,d0
		cmpi.b	#$C0,d0
		bhs.s	locret_11DDA
		move.b	$26(a0),d0
		jsr	GetSine
		muls.w	#$20,d0
		asr.l	#8,d0
		tst.w	$1C(a0)
		beq.s	loc_11DDC
		bmi.s	loc_11DD6
		tst.w	d0
		beq.s	locret_11DD4
		add.w	d0,$1C(a0)


; ---------------------------------------------------------------------------

locret_11DD4:
		rts

loc_11DD6:
		add.w	d0,$1C(a0)


; ---------------------------------------------------------------------------

locret_11DDA:
		rts

loc_11DDC:
		move.w	d0,d1
		bpl.s	loc_11DE2
		neg.w	d1


; End of function sub_11DA6
; ############### S U B	R O U T	I N E #######################################

loc_11DE2:
		cmpi.w	#$D,d1
		blo.s	locret_11DDA
		add.w	d0,$1C(a0)
		rts

sub_11DEE:
		move.b	$26(a0),d0
		addi.b	#$60,d0
		cmpi.b	#$C0,d0
		bhs.s	locret_11E28
		move.b	$26(a0),d0
		jsr	GetSine
		muls.w	#$50,d0
		asr.l	#8,d0
		tst.w	$1C(a0)
		bmi.s	loc_11E1E
		tst.w	d0
		bpl.s	loc_11E18
		asr.l	#2,d0


; ---------------------------------------------------------------------------

loc_11E18:
		add.w	d0,$1C(a0)
		rts

loc_11E1E:
		tst.w	d0
		bmi.s	loc_11E24
		asr.l	#2,d0

loc_11E24:
		add.w	d0,$1C(a0)


; End of function sub_11DEE
; ############### S U B	R O U T	I N E #######################################

locret_11E28:
		rts

sub_11E2A:
		nop
		tst.b	$3C(a0)
		bne.s	locret_11E6E
		tst.w	$32(a0)
		bne.s	loc_11E86
		move.b	$26(a0),d0
		addi.b	#$18,d0
		cmpi.b	#$30,d0
		blo.s	locret_11E6E
		move.w	$1C(a0),d0
		bpl.s	loc_11E4E
		neg.w	d0

loc_11E4E:
		cmpi.w	#$280,d0
		bhs.s	locret_11E6E
		move.w	#$1E,$32(a0)
		move.b	$26(a0),d0
		addi.b	#$30,d0
		cmpi.b	#$60,d0
		blo.s	loc_11E70
		bset	#1,$2A(a0)


; ---------------------------------------------------------------------------

locret_11E6E:
		rts


; ---------------------------------------------------------------------------

loc_11E70:
		cmpi.b	#$30,d0
		blo.s	loc_11E7E
		addi.w	#$80,$1C(a0)
		rts


; ---------------------------------------------------------------------------

loc_11E7E:
		subi.w	#$80,$1C(a0)
		rts


; End of function sub_11E2A
; ############### S U B	R O U T	I N E #######################################

loc_11E86:
		subq.w	#1,$32(a0)
		rts

sub_11E8C:
		move.b	$26(a0),d0
		beq.s	loc_11EA6
		bpl.s	loc_11E9C
		addq.b	#2,d0
		bhs.s	loc_11E9A
		moveq	#0,d0


; ---------------------------------------------------------------------------

loc_11E9A:
		bra.s	loc_11EA2

loc_11E9C:
		subq.b	#2,d0
		bhs.s	loc_11EA2
		moveq	#0,d0

loc_11EA2:
		move.b	d0,$26(a0)

loc_11EA6:
		move.b	$27(a0),d0
		beq.s	locret_11EEA
		tst.w	$1C(a0)
		bmi.s	loc_11ECA

loc_11EB2:
		move.b	$31(a0),d1
		add.b	d1,d0
		bhs.s	loc_11EC8
		subq.b	#1,$30(a0)
		bhs.s	loc_11EC8
		move.b	#0,$30(a0)
		moveq	#0,d0


; ---------------------------------------------------------------------------

loc_11EC8:
		bra.s	loc_11EE6

loc_11ECA:
		tst.b	$2D(a0)
		bmi.s	loc_11EB2
		move.b	$31(a0),d1
		sub.b	d1,d0
		bhs.s	loc_11EE6
		subq.b	#1,$30(a0)
		bhs.s	loc_11EE6
		move.b	#0,$30(a0)
		moveq	#0,d0

loc_11EE6:
		move.b	d0,$27(a0)


; End of function sub_11E8C
; ############### S U B	R O U T	I N E #######################################

locret_11EEA:
		rts

sub_11EEC:
		move.l	Primary_Collision.w,Current_Collision.w
		cmpi.b	#$C,$46(a0)
		beq.s	loc_11F00
		move.l	Secondary_Collision.w,Current_Collision.w

loc_11F00:
		move.b	$47(a0),d5
		move.w	$18(a0),d1
		move.w	$1A(a0),d2
		jsr	GetArcTan
		subi.b	#$20,d0
		andi.b	#$C0,d0
		cmpi.b	#$40,d0
		beq.w	loc_12012
		cmpi.b	#$80,d0
		beq.w	loc_1209E
		cmpi.b	#$C0,d0
		beq.w	loc_12102
		jsr	ChkWallDist_Left.w
		tst.w	d1
		bpl.s	loc_11F44
		sub.w	d1,$10(a0)
		move.w	#0,$18(a0)

loc_11F44:
		jsr	CheckRightWallDist.w
		tst.w	d1
		bpl.s	loc_11F56
		add.w	d1,$10(a0)
		move.w	#0,$18(a0)

loc_11F56:
		jsr	sub_11FD6.w
		tst.w	d1
		bpl.s	locret_11FD4
		move.b	$1A(a0),d2
		addq.b	#8,d2
		neg.b	d2
		cmp.b	d2,d1
		bge.s	loc_11F6E
		cmp.b	d2,d0
		blt.s	locret_11FD4

loc_11F6E:
		move.b	d3,$26(a0)
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_11F7A
		neg.w	d1


; ---------------------------------------------------------------------------

loc_11F7A:
		add.w	d1,$14(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	loc_11FAE
		move.b	d3,d0
		addi.b	#$10,d0
		andi.b	#$20,d0
		beq.s	loc_11F9C
		asr	$1A(a0)
		bra.s	loc_11FC2


; ---------------------------------------------------------------------------

loc_11F9C:
		move.w	#0,$1A(a0)
		move.w	$18(a0),$1C(a0)
		bsr.w	Player_ResetOnFloor_Spdash
		rts

loc_11FAE:
		move.w	#0,$18(a0)
		cmpi.w	#$FC0,$1A(a0)
		ble.s	loc_11FC2
		move.w	#$FC0,$1A(a0)

loc_11FC2:
		bsr.w	Player_ResetOnFloor_Spdash
		move.w	$1A(a0),$1C(a0)
		tst.b	d3
		bpl.s	locret_11FD4
		neg.w	$1C(a0)

locret_11FD4:
		rts
; ---------------------------------------------------------------------------

loc_12012:
		jsr	ChkWallDist_Left.w
		tst.w	d1
		bpl.s	loc_1202A
		sub.w	d1,$10(a0)
		move.w	#0,$18(a0)
		move.w	$1A(a0),$1C(a0)

loc_1202A:
		jsr	sub_11FEE.w
		tst.w	d1
		bpl.s	loc_12068
		neg.w	d1
		cmpi.w	#$14,d1
		bhs.s	loc_12054
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_12042
		neg.w	d1

loc_12042:
		add.w	d1,$14(a0)
		tst.w	$1A(a0)
		bpl.s	locret_12052
		move.w	#0,$1A(a0)

locret_12052:
		rts
; ---------------------------------------------------------------------------

loc_12054:
		jsr	CheckRightWallDist.w
		tst.w	d1
		bpl.s	locret_12066
		add.w	d1,$10(a0)
		move.w	#0,$18(a0)


; ---------------------------------------------------------------------------

locret_12066:
		rts

loc_12068:
		tst.b	Player1_OnWater_Flag.w
		bne.s	loc_12074
		tst.w	$1A(a0)
		bmi.s	locret_1209C

loc_12074:
		jsr	sub_11FD6.w
		tst.w	d1
		bpl.s	locret_1209C
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_12084
		neg.w	d1

loc_12084:
		add.w	d1,$14(a0)
		move.b	d3,$26(a0)
		move.w	#0,$1A(a0)
		move.w	$18(a0),$1C(a0)
		bsr.w	Player_ResetOnFloor_Spdash


; ---------------------------------------------------------------------------

locret_1209C:
		rts

loc_1209E:
		jsr	ChkWallDist_Left.w
		tst.w	d1
		bpl.s	loc_120B0
		sub.w	d1,$10(a0)
		move.w	#0,$18(a0)

loc_120B0:
		jsr	CheckRightWallDist.w
		tst.w	d1
		bpl.s	loc_120C2
		add.w	d1,$10(a0)
		move.w	#0,$18(a0)

loc_120C2:
		jsr	sub_11FEE.w
		tst.w	d1
		bpl.s	locret_12100
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_120D2
		neg.w	d1


; ---------------------------------------------------------------------------

loc_120D2:
		sub.w	d1,$14(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	loc_120EA
		move.w	#0,$1A(a0)
		rts

loc_120EA:
		move.b	d3,$26(a0)
		bsr.w	Player_ResetOnFloor_Spdash
		move.w	$1A(a0),$1C(a0)
		tst.b	d3
		bpl.s	locret_12100
		neg.w	$1C(a0)


; ---------------------------------------------------------------------------

locret_12100:
		rts

loc_12102:
		jsr	CheckRightWallDist.w
		tst.w	d1
		bpl.s	loc_1211A
		add.w	d1,$10(a0)
		move.w	#0,$18(a0)
		move.w	$1A(a0),$1C(a0)

loc_1211A:
		jsr	sub_11FEE.w
		tst.w	d1
		bpl.s	loc_1213C
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_1212A
		neg.w	d1

loc_1212A:
		sub.w	d1,$14(a0)
		tst.w	$1A(a0)
		bpl.s	locret_1213A
		move.w	#0,$1A(a0)


; ---------------------------------------------------------------------------

locret_1213A:
		rts

loc_1213C:
		tst.b	Player1_OnWater_Flag.w
		bne.s	loc_12148
		tst.w	$1A(a0)
		bmi.s	locret_12170

loc_12148:
		jsr	sub_11FD6.w
		tst.w	d1
		bpl.s	locret_12170
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_12158
		neg.w	d1

loc_12158:
		add.w	d1,$14(a0)
		move.b	d3,$26(a0)
		move.w	#0,$1A(a0)
		move.w	$18(a0),$1C(a0)
		bsr.w	Player_ResetOnFloor_Spdash


; ############### S U B	R O U T	I N E #######################################

locret_12170:
		rts
; ---------------------------------------------------------------------------

Player_ResetOnFloor_Spdash:
		tst.b	spindash(a0)
		bne.s	Player_ResetOnFloor_Com		; branch if spindashing
		move.b	#0,anim(a0)			; set to walking animation

Player_ResetOnFloor:
		cmpi.b	#1,charnum(a0)
		beq.w	Tails_ResetOnFloor		; branch if this is Tails
		cmpi.b	#2,charnum(a0)
		beq.w	Knux_ResetOnFloor		; branch if this is Knuckles

		move.b	yrad(a0),d0			; get y-radius
		move.b	yraddef(a0),yrad(a0)		; set to default y-radius
		move.b	xraddef(a0),xrad(a0)		; set to default x-radius
		btst	#2,status(a0)
		beq.s	Player_ResetOnFloor_Com		; branch if not jumping/rolling

		bclr	#2,status(a0)			; clear jumping/rolling bit (could have done this instead of btst)
		move.b	#0,anim(a0)			; set to walking animation
		sub.b	yraddef(a0),d0			; sub default y-radius from y-radius
		ext.w	d0				; extend to word
		tst.b	ReverseGravity_Flag.w
		beq.s	.norev				; branch if reverse gravity isn't active
		neg.w	d0				; negate offset
.norev		move.w	d0,-(sp)			; store offset

		move.b	angle(a0),d0			; get angle
		addi.b	#$40,d0				; rotate 90 degrees
		bpl.s	.fixypos			; if positive (-90 to 90 degrees)
		neg.w	(sp)				; negate offset
.fixypos	move.w	(sp)+,d0			; get the offset now
		add.w	d0,ypos(a0)			; add to y-pos

Player_ResetOnFloor_Com:
		bclr	#1,status(a0)			; clear in air bit
		bclr	#5,status(a0)			; clear pushing bit
		bclr	#4,status(a0)			; clear rolljump bit
; those last 3 instructions could be replaced by 'andi.b #$CD,status(a0)'

		move.b	#0,jumping(a0)			; clear jumping flag
		move.w	#0,MidAir_Bonus_Counter.w	; clear midair bonus counter
		move.b	#0,angle2(a0)			; clear secondary angle
		move.b	#0,unk2D(a0)
		move.b	#0,unk30(a0)
		move.b	#0,scrolldelay(a0)		; clear scrolling delay

		tst.b	jumpmove(a0)
		beq.s	.rts				; branch if no jump move is active
		tst.b	charnum(a0)
		bne.s	.stopjmpmove			; branch if not Sonic (not needed)
		tst.b	Super_Flag.w
		bne.s	.stopjmpmove			; branch if super
		btst	#6,shistatus(a0)
		beq.s	.stopjmpmove			; branch if player does not have bubble shield
		bsr.s	BubbleShield_Bounce		; bounce from floor or object

.stopjmpmove	move.b	#0,jumpmove(a0)
.rts		rts
; ---------------------------------------------------------------------------

BubbleShield_Bounce:
		movem.l	d1-d2,-(sp)			; store variables
		move.w	#$780,d2			; set on air speed
		btst	#6,status(a0)
		beq.s	.speedgot			; branch if not in water
		move.w	#$400,d2			; set on water speed

.speedgot	moveq	#0,d0
		move.b	angle(a0),d0			; get angle
		subi.b	#$40,d0				; sub 90 degrees from it

		jsr	GetSine				; calculate sine
		muls.w	d2,d1				; multiply cosine with speed
		asr.l	#8,d1				; shift right 8 times
		add.w	d1,xvel(a0)			; set x-velocity

		muls.w	d2,d0				; multiply sine with speed
		asr.l	#8,d0				; shift right 8 times
		add.w	d0,yvel(a0)			; set y-velocity
		movem.l	(sp)+,d1-d2			; pop variables

		bset	#1,status(a0)			; set in air bit
		bclr	#5,status(a0)			; clear pushing bit (unnecessary)
		move.b	#1,jumping(a0)			; set jumping flag
		clr.b	unk3C(a0)
		move.b	#$E,yrad(a0)			; set y-radius
		move.b	#7,xrad(a0)			; set x-radius
		move.b	#2,anim(a0)			; set to rolling animation
		bset	#2,status(a0)			; set jumping/rolling bit

		move.b	yrad(a0),d0			; get y-radius of object (this is $E, why not get it?)
		sub.b	yraddef(a0),d0			; sub default y-radius of player
		ext.w	d0				; extend to word
		tst.b	ReverseGravity_Flag.w
		beq.s	.norev				; branch if reverse gravity isn't active
		neg.w	d0				; negate offset
.norev		sub.w	d0,ypos(a0)			; sub from y-pos

		move.b	#2,Obj_shield+anim.w		; set shield animation
		move.w	#$44,d0
		jmp	PlaySFX				; play bouncing sfx
; ---------------------------------------------------------------------------

loc_122BE:
		tst.w	Debug_Mode_Flag.w
		beq.s	loc_122D8
		btst	#4,Ctrl_1_Press.w
		beq.s	loc_122D8
		move.w	#1,Debug_Routine.w
		clr.b	Control_Locked.w
		rts

loc_122D8:
		jsr	ObjectRevMove
		addi.w	#$30,$1A(a0)
		btst	#6,$2A(a0)
		beq.s	loc_122F2
		subi.w	#$20,$1A(a0)

loc_122F2:
		cmpi.w	#-$100,Camera_min_Y.w
		bne.s	loc_12302
		move.w	Screen_Y_wrap_value.w,d0
		and.w	d0,$14(a0)


; ############### S U B	R O U T	I N E #######################################

loc_12302:
		bsr.w	sub_12318
		bsr.w	Player_Check_Screen_Boundaries
		bsr.w	sub_10D66
		bsr.w	sub_125E0
		jmp	DrawSprite


; ---------------------------------------------------------------------------

sub_12318:
		tst.b	BG_Layer_Scroll_Timer2+3.w
		bne.s	loc_12344
		tst.b	ReverseGravity_Flag.w
		bne.s	loc_12336
		move.w	Camera_max_Y.w,d0
		addi.w	#$E0,d0
		cmp.w	$14(a0),d0
		blt.w	loc_1238A
		bra.s	loc_12344


; ---------------------------------------------------------------------------

loc_12336:
		move.w	Camera_min_Y.w,d0
		cmp.w	$14(a0),d0
		blt.s	loc_12344
		bra.w	loc_1238A

loc_12344:
		movem.l	a4-a6,-(sp)
		bsr.w	sub_11EEC
		movem.l	(sp)+,a4-a6
		btst	#1,$2A(a0)
		bne.s	locret_12388
		moveq	#0,d0
		move.w	d0,$1A(a0)
		move.w	d0,$18(a0)
		move.w	d0,$1C(a0)
		move.b	d0,$2E(a0)
		move.b	#0,$20(a0)
		move.w	#$100,8(a0)
		move.b	#2,5(a0)
		move.b	#$78,$34(a0)
		move.b	#0,$3D(a0)


; ---------------------------------------------------------------------------

locret_12388:
		rts


; End of function sub_12318
; ---------------------------------------------------------------------------

loc_1238A:
		jmp	KillPlayer2


; ---------------------------------------------------------------------------

loc_12390:
		tst.w	Debug_Mode_Flag.w
		beq.s	loc_123AA
		btst	#4,Ctrl_1_Press.w
		beq.s	loc_123AA
		move.w	#1,Debug_Routine.w
		clr.b	Control_Locked.w
		rts


; ############### S U B	R O U T	I N E #######################################

loc_123AA:
		bsr.s	sub_123C2
		jsr	ObjectGravity
		bsr.w	sub_10D66
		bsr.w	sub_125E0
		jmp	DrawSprite
; ---------------------------------------------------------------------------

sub_123C2:
		move.w	Camera_Y.w,d0
		cmpa.w	#Object_RAM,a0
		bne.s	loc_123DE
		move.b	#1,Scroll_Lock.w

loc_123DE:
		move.b	#0,$3D(a0)
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_123FA
		subi.w	#$10,d0
		cmp.w	$14(a0),d0
		bge.s	loc_12410

locret_124C6:
		rts
; ---------------------------------------------------------------------------

loc_123FA:
		addi.w	#$100,d0

loc_12408:
		cmp.w	$14(a0),d0
		bge.s	locret_124C6

loc_12410:
		cmpi.b	#1,charnum(a0)
		bne.s	loc_12432
		cmpi.w	#2,Player_Mode.w
		beq.s	loc_12432
		move.b	#2,routine(a0)
		bra.w	sub_13ECA

loc_12432:
		move.b	#8,routine(a0)
		move.w	#$3C,$3E(a0)
		rts
; ---------------------------------------------------------------------------

loc_124C8:
		move.b	#2,routine(a0)
		clr.b	Scroll_Lock.w
		clr.w	Ring_Count.w
		clr.b	Get_Extra_Life_Flag.w

loc_1252A:
		clr.b	$2E(a0)
		move.b	#5,$20(a0)
		clr.l	$18(a0)
		clr.w	$1C(a0)
		move.b	#2,$2A(a0)
		clr.w	$32(a0)
		clr.w	$3E(a0)
		clr.b	$36(a0)
		lea	word_1E3C00,a1
		moveq	#0,d0
		move.b	charnum(a0),d0
		lsl.w	#3,d0
		lea	(a1,d0.w),a1
		move.w	(a1)+,(a4)
		move.w	(a1)+,2(a4)
		move.w	(a1)+,4(a4)
		rts
; ---------------------------------------------------------------------------

loc_1257C:
		tst.w	$3E(a0)
		beq.s	locret_1258E
		subq.w	#1,$3E(a0)
		bne.s	locret_1258E
		jsr	LoadFadeInOutCode

locret_1258E:
		rts
; ---------------------------------------------------------------------------

loc_12590:
		tst.w	Camera_X_Pos_Diff.w
		bne.s	loc_125A2
		tst.w	Camera_Y_Pos_Diff.w
		bne.s	loc_125A2
		move.b	#2,5(a0)


; ---------------------------------------------------------------------------

loc_125A2:
		bsr.w	sub_125E0
		jmp	DrawSprite


; ---------------------------------------------------------------------------

loc_125AC:
		tst.w	Debug_Mode_Flag.w
		beq.s	loc_125C6
		btst	#4,Ctrl_1_Press.w
		beq.s	loc_125C6
		move.w	#1,Debug_Routine.w
		clr.b	Control_Locked.w
		rts


; ############### S U B	R O U T	I N E #######################################

loc_125C6:
		jsr	ObjectRevMove
		addi.w	#$10,$1A(a0)
		bsr.w	sub_10D66
		bsr.w	sub_125E0
		jmp	DrawSprite

sub_125E0:
		bsr.s	Animate_Sonic
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_125F4
		eori.b	#2,4(a0)


; ---------------------------------------------------------------------------

loc_125F4:
		bra.w	Sonic_LoadDPLC

Animate_Sonic:
		lea	AniSonic,a1
		tst.b	Super_Flag.w
		beq.s	loc_12612
		lea	AniSuperSonic,a1

loc_12612:
		moveq	#0,d0
		move.b	$20(a0),d0
		cmp.b	$21(a0),d0
		beq.s	loc_12634
		move.b	d0,$21(a0)
		move.b	#0,$23(a0)
		move.b	#0,$24(a0)
		bclr	#5,$2A(a0)

loc_12634:
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),d0
		bmi.s	loc_126A4
		move.b	$2A(a0),d1
		andi.b	#1,d1
		andi.b	#-4,4(a0)
		or.b	d1,4(a0)
		subq.b	#1,$24(a0)
		bpl.s	locret_12672
		move.b	d0,$24(a0)

loc_1265A:
		moveq	#0,d1
		move.b	$23(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-4,d0
		bhs.s	loc_12674

loc_1266A:
		move.b	d0,$22(a0)
		addq.b	#1,$23(a0)


; ---------------------------------------------------------------------------

locret_12672:
		rts


; ---------------------------------------------------------------------------

loc_12674:
		addq.b	#1,d0
		bne.s	loc_12684
		move.b	#0,$23(a0)
		move.b	1(a1),d0
		bra.s	loc_1266A


; ---------------------------------------------------------------------------

loc_12684:
		addq.b	#1,d0
		bne.s	loc_12698
		move.b	2(a1,d1.w),d0
		sub.b	d0,$23(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	loc_1266A

loc_12698:
		addq.b	#1,d0
		bne.s	locret_126A2
		move.b	2(a1,d1.w),$20(a0)


; ---------------------------------------------------------------------------

locret_126A2:
		rts

loc_126A4:
		addq.b	#1,d0
		bne.w	loc_12A2A
		moveq	#0,d0
		tst.b	$2D(a0)
		bmi.w	loc_127C0
		move.b	$27(a0),d0
		bne.w	loc_127C0
		moveq	#0,d1
		move.b	$26(a0),d0
		bmi.s	loc_126C8
		beq.s	loc_126C8
		subq.b	#1,d0

loc_126C8:
		move.b	$2A(a0),d2
		andi.b	#1,d2
		bne.s	loc_126D4
		not.b	d0

loc_126D4:
		addi.b	#$10,d0
		bpl.s	loc_126DC
		moveq	#3,d1

loc_126DC:
		andi.b	#-4,4(a0)
		eor.b	d1,d2
		or.b	d2,4(a0)
		btst	#5,$2A(a0)
		bne.w	loc_12A72
		lsr.b	#4,d0
		andi.b	#6,d0
		move.w	$1C(a0),d2
		bpl.s	loc_12700
		neg.w	d2

loc_12700:
		tst.b	$2B(a0)
		bpl.w	loc_1270A
		add.w	d2,d2

loc_1270A:
		tst.b	Super_Flag.w
		bne.s	loc_12766
		lea	byte_12AF8,a1
		cmpi.w	#$600,d2
		bhs.s	loc_12724
		lea	byte_12AEE,a1
		add.b	d0,d0

loc_12724:
		add.b	d0,d0
		move.b	d0,d3
		moveq	#0,d1
		move.b	$23(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	loc_12742
		move.b	#0,$23(a0)
		move.b	1(a1),d0

loc_12742:
		move.b	d0,$22(a0)
		add.b	d3,$22(a0)
		subq.b	#1,$24(a0)
		bpl.s	locret_12764
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	loc_1275A
		moveq	#0,d2

loc_1275A:
		lsr.w	#8,d2
		move.b	d2,$24(a0)
		addq.b	#1,$23(a0)


; ---------------------------------------------------------------------------

locret_12764:
		rts


; ---------------------------------------------------------------------------

loc_12766:
		lea	byte_12C84,a1
		cmpi.w	#$800,d2
		bhs.s	loc_1277E
		lea	byte_12C7A,a1
		add.b	d0,d0
		add.b	d0,d0
		bra.s	loc_12780

loc_1277E:
		add.b	d0,d0

loc_12780:
		move.b	d0,d3
		moveq	#0,d1
		move.b	$23(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	loc_1279C
		move.b	#0,$23(a0)
		move.b	1(a1),d0

loc_1279C:
		move.b	d0,$22(a0)
		add.b	d3,$22(a0)
		subq.b	#1,$24(a0)
		bpl.s	locret_127BE
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	loc_127B4
		moveq	#0,d2

loc_127B4:
		lsr.w	#8,d2
		move.b	d2,$24(a0)
		addq.b	#1,$23(a0)


; ---------------------------------------------------------------------------

locret_127BE:
		rts


; ---------------------------------------------------------------------------

loc_127C0:
		move.b	$2D(a0),d1
		andi.w	#$7F,d1
		bne.w	loc_12872
		move.b	$27(a0),d0
		moveq	#0,d1
		move.b	$2A(a0),d2
		andi.b	#1,d2
		bne.s	loc_1281E
		andi.b	#-4,4(a0)
		tst.b	$2D(a0)
		bpl.s	loc_12806
		ori.b	#2,4(a0)
		neg.b	d0
		addi.b	#$8F,d0
		bra.s	loc_1280A

loc_12806:
		addi.b	#$B,d0


; ---------------------------------------------------------------------------

loc_1280A:
		divu.w	#$16,d0
		addi.b	#$31,d0
		move.b	d0,$22(a0)
		move.b	#0,$24(a0)
		rts

loc_1281E:
		andi.b	#-4,4(a0)

loc_1284E:
		ori.b	#3,4(a0)
		neg.b	d0
		addi.b	#$8F,d0


; ---------------------------------------------------------------------------

loc_1285A:
		divu.w	#$16,d0
		addi.b	#$31,d0
		move.b	d0,$22(a0)
		move.b	#0,$24(a0)
		rts


; ---------------------------------------------------------------------------

byte_1286E:
		dc.b 0
		dc.b $3D
		dc.b $49
		dc.b $49


; ---------------------------------------------------------------------------

loc_12872:
		move.b	byte_1286E(pc,d1.w),d3
		cmpi.b	#1,d1
		bne.s	loc_128CA
		move.b	$27(a0),d0
		moveq	#0,d1
		move.b	$2A(a0),d2
		andi.b	#1,d2
		bne.s	loc_128A8
		andi.b	#-4,4(a0)
		addi.b	#-8,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,$22(a0)
		move.b	#0,$24(a0)
		rts


; ---------------------------------------------------------------------------

loc_128A8:
		andi.b	#-4,4(a0)
		ori.b	#1,4(a0)
		addi.b	#-8,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,$22(a0)
		move.b	#0,$24(a0)
		rts


; ---------------------------------------------------------------------------

loc_128CA:
		cmpi.b	#2,d1
		bne.s	loc_12920
		move.b	$27(a0),d0
		moveq	#0,d1
		move.b	$2A(a0),d2
		andi.b	#1,d2
		bne.s	loc_128FC
		andi.b	#-4,4(a0)
		addi.b	#$B,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,$22(a0)
		move.b	#0,$24(a0)
		rts


; ---------------------------------------------------------------------------

loc_128FC:
		andi.b	#-4,4(a0)
		ori.b	#3,4(a0)
		neg.b	d0
		addi.b	#$8F,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,$22(a0)
		move.b	#0,$24(a0)
		rts


; ---------------------------------------------------------------------------

loc_12920:
		cmpi.b	#3,d1
		bne.s	loc_1297C
		move.b	$27(a0),d0
		moveq	#0,d1
		move.b	$2A(a0),d2
		andi.b	#1,d2
		bne.s	loc_1295A
		andi.b	#-4,4(a0)
		ori.b	#2,4(a0)
		neg.b	d0
		addi.b	#$8F,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,$22(a0)
		move.b	#0,$24(a0)
		rts


; ---------------------------------------------------------------------------

loc_1295A:
		andi.b	#-4,4(a0)
		ori.b	#1,4(a0)
		addi.b	#$B,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,$22(a0)
		move.b	#0,$24(a0)
		rts


; ---------------------------------------------------------------------------

loc_1297C:
		cmpi.b	#4,d1
		bne.s	loc_129F6
		move.b	$27(a0),d0
		moveq	#0,d1
		move.b	$2A(a0),d2
		andi.b	#1,d2
		bne.s	loc_129BC
		andi.b	#-4,4(a0)
		tst.b	$2D(a0)
		bpl.s	loc_129A4
		addi.b	#$B,d0
		bra.s	loc_129A8

loc_129A4:
		addi.b	#$B,d0


; ---------------------------------------------------------------------------

loc_129A8:
		divu.w	#$16,d0
		addi.b	#$31,d0
		move.b	d0,$22(a0)
		move.b	#0,$24(a0)
		rts


; ---------------------------------------------------------------------------

loc_129BC:
		andi.b	#-4,4(a0)
		tst.b	$2D(a0)
		bpl.s	loc_129D6
		ori.b	#3,4(a0)
		neg.b	d0
		addi.b	#$8F,d0
		bra.s	loc_129E2

loc_129D6:
		ori.b	#3,4(a0)
		neg.b	d0
		addi.b	#$8F,d0


; ---------------------------------------------------------------------------

loc_129E2:
		divu.w	#$16,d0
		addi.b	#$31,d0
		move.b	d0,$22(a0)
		move.b	#0,$24(a0)
		rts

loc_129F6:
		move.b	$27(a0),d0
		andi.b	#-4,4(a0)
		moveq	#0,d1
		move.b	$2A(a0),d2
		andi.b	#1,d2
		beq.s	loc_12A12
		ori.b	#1,4(a0)


; ---------------------------------------------------------------------------

loc_12A12:
		addi.b	#$B,d0
		divu.w	#$16,d0
		addi.b	#$31,d0
		move.b	d0,$22(a0)
		move.b	#0,$24(a0)
		rts

loc_12A2A:
		move.b	$2A(a0),d1
		andi.b	#1,d1
		andi.b	#-4,4(a0)
		or.b	d1,4(a0)
		subq.b	#1,$24(a0)
		bpl.w	locret_12672
		move.w	$1C(a0),d2
		bpl.s	loc_12A4C
		neg.w	d2

loc_12A4C:
		lea	byte_12B0C,a1
		cmpi.w	#$600,d2
		bhs.s	loc_12A5E
		lea	byte_12B02,a1

loc_12A5E:
		neg.w	d2
		addi.w	#$400,d2
		bpl.s	loc_12A68
		moveq	#0,d2


; ---------------------------------------------------------------------------

loc_12A68:
		lsr.w	#8,d2
		move.b	d2,$24(a0)
		bra.w	loc_1265A

loc_12A72:
		subq.b	#1,$24(a0)
		bpl.w	locret_12672
		move.w	$1C(a0),d2
		bmi.s	loc_12A82
		neg.w	d2

loc_12A82:
		addi.w	#$800,d2
		bpl.s	loc_12A8A
		moveq	#0,d2

loc_12A8A:
		lsr.w	#6,d2
		move.b	d2,$24(a0)
		lea	byte_12B16,a1
		tst.b	Super_Flag.w
		beq.s	loc_12AA2
		lea	byte_12C8E,a1


; End of function Animate_Sonic

loc_12AA2:
		bra.w	loc_1265A

; ---------------------------------------------------------------------------
AniSonic:	include "levels/Players/Sonic/Ani Main.asm"
AniSuperSonic:	include "levels/Players/Sonic/Ani Super.asm"
; ---------------------------------------------------------------------------

Sonic_LoadDPLC:
		moveq	#0,d0
		move.b	$22(a0),d0

Sonic_LoadDPLC2:
		cmp.b	Player1_Current_Frame.w,d0
		beq.s	locret_12D20
		move.b	d0,Player1_Current_Frame.w
		lea	DPLC_Sonic,a2
		tst.b	Super_Flag.w
		beq.s	loc_12CD6
		lea	DPLC_SuperSonic,a2

loc_12CD6:
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_12D20
		move.w	#$D000,d4
		move.l	#Art_Sonic,d6
		cmpi.w	#$1B4,d0
		blo.s	loc_12CF8
		move.l	#Art_Sonic_Extra,d6

loc_12CF8:
		moveq	#0,d1
		move.w	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		add.l	d6,d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	AddQueueDMA
		dbf	d5,loc_12CF8


; End of function Sonic_LoadDPLC
; ############### S U B	R O U T	I N E #######################################

locret_12D20:
		rts


; End of function Tails_Carry_LoadPLC
; ############### S U B	R O U T	I N E #######################################

Tails_Carry_LoadPLC:
		tst.b	$38(a1)
		beq.s	Sonic_LoadDPLC2
		cmpi.b	#1,$38(a1)
		beq.w	Tails_Load_PLC2
		bra.w	Knuckles_Load_PLC2

loc_2D5C6:

loc_2D5CE:
		move.w	#$50,$10(a0)
		btst	#0,$22(a0)
		beq.s	loc_2D5F2
		move.w	#$1F0,$10(a0)

loc_2D5F2:
		move.w	#$F0,$14(a0)
		move.l	#Map_2EDD0,$C(a0)
		move.w	#-$7864,$A(a0)
		move.w	#0,8(a0)
		move.l	#loc_2D612,(a0)

loc_2D612:
		moveq	#$10,d1
		cmpi.w	#$120,$10(a0)
		beq.s	loc_2D62A
		blo.s	loc_2D620
		neg.w	d1


; ---------------------------------------------------------------------------

loc_2D620:
		add.w	d1,$10(a0)
		jmp	DrawSprite


; ---------------------------------------------------------------------------

loc_2D62A:
		move.w	#$1E0,$24(a0)
		move.l	#loc_2D638,(a0)
		rts

loc_2D638:
		clr.w	Coll_response_list.w
		btst	#0,$22(a0)
		bne.w	loc_2D68A
		move.b	Ctrl_1_Press.w,d0
		or.b	Ctrl_2_Press.w,d0
		andi.b	#-$10,d0
		bne.s	loc_2D666
		tst.w	$24(a0)
		beq.s	loc_2D666
		subq.w	#1,$24(a0)
		jmp	DrawSprite


; ---------------------------------------------------------------------------

loc_2D666:
		jsr	LoadFadeInOutCode

loc_2D68A:
		jmp	DrawSprite

TouchResponse_Normal:
		jsr	TouchResponse_Rings
		bsr.w	ShieldTouchResponse

		tst.b	charnum(a0)
		bne.s	.NoInsta		; branch if not Sonic
		move.b	shistatus(a0),d0	; get secondary status bitfield
		andi.b	#$73,d0			; filter out speedshoes and infinite inertia flags
		bne.s	.NoInsta		; if you dont have shields or invinciblity, branch
		cmpi.b	#1,jumpmove(a0)
		bne.s	.NoInsta		; branch if this isnt shield move
		move.b	shistatus(a0),d0
		move.w	d0,-(sp)		; store secondary status bitfield
		bset	#1,shistatus(a0)	; set invinciblity flag

		move.w	xpos(a0),d2		; get xpos
		move.w	ypos(a0),d3		; get ypos
		subi.w	#$18,d2			; sub $18 pixels from xpos
		subi.w	#$18,d3			; sub $18 pixels from xpos
		move.w	#$30,d4			; $30 pixels width
		move.w	#$30,d5			; $30 pixels height

		bsr.s	TouchResponse_Common
		move.w	(sp)+,d0		; get stored secondary status bitfield
		btst	#1,d0			; was invinciblity bit set?
		bne.s	.invis			; if was, branch
		bclr	#1,shistatus(a0)	; else clear it

.invis		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------

.NoInsta	move.w	xpos(a0),d2		; get xpos
		move.w	ypos(a0),d3		; get ypos
		subi.w	#8,d2			; sub width from xpos

		moveq	#0,d5
		move.b	yrad(a0),d5		; get players height
		subq.b	#3,d5			; sub 3 from the height
		sub.w	d5,d3			; sub height from ypos
		move.w	#$10,d4			; get collision width
		add.w	d5,d5			; double collision height

TouchResponse_Common:
		lea	Coll_response_list.w,a4
		move.w	(a4)+,d6		; get number of objects to collide with
		beq.s	.rts			; branch if 0

.objloop	movea.w	(a4)+,a1		; get next object's address
		move.b	collision(a1),d0	; get collision flag
		bne.s	.objfound		; branch if some exist.

.nextobj	subq.w	#2,d6			; move to next object
		bne.s	.objloop		; branch if there are more of them
		moveq	#0,d0
.rts		rts
; ---------------------------------------------------------------------------

.objfound	andi.w	#$3F,d0			; get collision ID only
		add.w	d0,d0			; double it
		lea	Touch_Sizes(pc,d0.w),a2	; get collision size from list

		; proceeds to check if we touch horizontally
		moveq	#0,d1
		move.b	(a2)+,d1		; get collision width for object
		move.w	xpos(a1),d0		; get x-position of object
		sub.w	d1,d0			; sub obj width from obj x
		sub.w	d2,d0			; sub player x from obj x
		bhs.s	.isleft			; if left from object, branch

		add.w	d1,d1			; double collision width
		add.w	d1,d0			; add width to obj x
		blo.s	.chky			; if less than 0, branch (you are left from the right boundary of object)
		bra.s	.nextobj

.isleft		cmp.w	d4,d0
		bhi.s	.nextobj

		; proceeds to check if we touch vertically
.chky		moveq	#0,d1
		move.b	(a2)+,d1		; get collision height for object
		move.w	ypos(a1),d0		; get y-position of object
		sub.w	d1,d0			; sub obj height from obj y
		sub.w	d3,d0			; sub player y from obj y
		bhs.s	.chkup			; if above of the object, branch

		add.w	d1,d1			; double collision height
		add.w	d1,d0			; add height to obj y
		blo.w	TouchResponse_ChkDone	; if less than 0, branch (you are above of the bottom boundary of object)
		bra.s	.nextobj

.chkup		cmp.w	d5,d0
		bhi.s	.nextobj
		bra.s	TouchResponse_ChkDone

; ---------------------------------------------------------------------------
; collision sizes (width,height)
Touch_Sizes:	dc.b $10,$10	; 0
		dc.b   6,  6	; 1
		dc.b $20,$20	; 2
		dc.b   8,  8	; 3
		dc.b  14, 32	; 4
		dc.b  20, 20	; 5
		dc.b  14, 14	; 6
; ---------------------------------------------------------------------------

TouchResponse_ChkDone:
		move.b	collision(a1),d1	; get objects collision flags
		andi.b	#$C0,d1			; get its type
		beq.w	Touch_Enemy		; if 00, its enemy
		cmpi.b	#$C0,d1
		beq.w	Touch_Special		; if 11, its special collision
		tst.b	d1
		bmi.w	Touch_ChkHurt		; if 10, its harmful

		; if 01,
		move.b	collision(a1),d0	; get collision again
		andi.b	#$3F,d0			; get only collision type
		beq.s	Touch_Monitors		; if so, its monitor

		cmpi.b	#90,Object_RAM+invultime.w
		bhs.w	.rts			; branch if there is more than 90 frames to go
		move.b	#4,routine(a1)		; set routine to 4
.rts		rts
; ---------------------------------------------------------------------------

Touch_Monitors:
		move.w	yvel(a0),d0		; get Y-velocity
		tst.b	ReverseGravity_Flag.w
		beq.s	.norevgravity		; branch if reverse gravity isnt active
		neg.w	d0			; reverse Y-velocity

.norevgravity	btst	#1,render(a1)
		bne.s	.upsideup		; branch if the monitor is not upside down
		tst.w	d0			; test Y-velocity
		bpl.s	.chkdestroy		; if moving down, branch

		move.w	ypos(a0),d0		; get players y-pos
		subi.w	#$10,d0			; sub $10 from it
		cmp.w	ypos(a1),d0		; compare to obj y-pos
		bhs.s	.makefall		; if touching, branch
		rts

.upsideup	tst.w	d0			; test Y-velocity
		beq.s	.chkdestroy		; if not moving, branch
		bmi.s	.chkdestroy		; if moving up, branch too

		move.w	ypos(a0),d0		; get players y-pos
		addi.w	#$10,d0			; sub $10 from it
		cmp.w	ypos(a1),d0		; compare to obj y-pos
		bhs.s	.rts			; branch if touching

.makefall	neg.w	yvel(a0)		; negate player y-speed
		move.w	#-$180,yvel(a1)
		tst.b	mon_fallflag(a1)
		bne.s	.rts
		move.b	#4,mon_fallflag(a1)	; set monitor to fall
		rts

.chkdestroy	cmpa.w	#Object_RAM&$FFFF,a0
		bne.s	.rts			; branch if this is the main player

.destroy	cmpi.b	#2,anim(a0)
		beq.s	.dodestroy		; branch if rolling
		cmpi.b	#2,charnum(a0)
		bne.s	.rts			; branch if not Knuckles
		cmpi.b	#1,jumpmove(a0)
		beq.s	.dodestroy		; branch if gliding
		cmpi.b	#3,jumpmove(a0)
		bne.s	.rts			; branch if not sliding

.dodestroy	neg.w	yvel(a0)		; negate Y-velocity
		move.b	#4,routine(a1)		; set routine
		move.w	a0,parent(a1)		; set object destroying this monitor
.rts		rts
; ---------------------------------------------------------------------------

Touch_Enemy:
		btst	#1,shistatus(a0)
		bne.s	.chkhurtenemy		; branch if invincible
		cmpi.b	#9,anim(a0)
		beq.s	.chkhurtenemy		; if spindash animation, branch
		cmpi.b	#2,anim(a0)
		beq.s	.chkhurtenemy		; if spin animation, branch

		cmpi.b	#2,charnum(a0)
		bne.s	.notknux		; branch if not Knuckles
		cmpi.b	#1,jumpmove(a0)
		beq.s	.chkhurtenemy		; branch if gliding
		cmpi.b	#3,jumpmove(a0)
		beq.s	.chkhurtenemy		; branch if sliding
		bra.w	Touch_ChkHurt

.notknux	cmpi.b	#1,charnum(a0)
		bne.w	Touch_ChkHurt		; branch if not tails
		tst.b	jumpmove(a0)
		beq.w	Touch_ChkHurt		; branch if not flying
		btst	#6,status(a0)
		bne.w	Touch_ChkHurt		; if underwater, branch

		move.w	xpos(a0),d1		; get xpos of player
		move.w	ypos(a0),d2		; get ypos of player
		sub.w	xpos(a1),d1		; sub xpos of obj from d1
		sub.w	ypos(a1),d2		; sub ypos of obj from d2
		jsr	GetArcTan		; get angle
		subi.b	#$20,d0			; sub 45 degrees from angle
		cmpi.b	#$40,d0			; if angle is between -45 and 45
		bhs.w	Touch_ChkHurt		; but if not, get hurt!

.chkhurtenemy	tst.b	collhits(a1)
		beq.s	Touch_EnemyNormal	; branch if no boss hits

		neg.w	xvel(a0)		; negate x-speed
		neg.w	yvel(a0)		; negate y-speed
		neg.w	inertia(a0)		; negate inertia
		move.b	collision(a1),oboff25(a1); store collision response

		move.w	a0,oboff1C(a1)		; save player ID to $1C
		clr.b	collision(a1)		; clear collision response
		subq.b	#1,collhits(a1)		; sub 1 from hit count
		bne.s	.notded			; if not 0, branch
		bset	#7,status(a1)		; set defeated bit

.notded		cmpi.b	#2,charnum(a0)
		bne.s	.rts			; if not Knuckles, branch
		cmpi.b	#1,jumpmove(a0)
		bne.s	.rts			; if not gliding, branch

		move.b	#2,jumpmove(a0)		; stop gliding
		move.b	#$21,anim(a0)		; set animation

		bclr	#0,status(a0)		; face left
		tst.w	xvel(a0)
		bmi.s	.notright		; if moving left, branch
		bset	#0,status(a0)		; face right

.notright	move.w	yraddef(a0),yrad(a0)	; reset radius
.rts		rts
; ---------------------------------------------------------------------------

Touch_EnemyNormal:
		btst	#2,status(a1)
		beq.s	.noRSS			; branch if Remember Sprite State flag isnt set
		move.b	rssbit(a1),d0		; get bit to use
		movea.w	rssaddr(a1),a2		; get the RSS bits
		bclr	d0,(a2)			; clear the correct bit

.noRSS		bset	#7,status(a1)		; set destroyed bit
		moveq	#0,d0
		move.w	MidAir_Bonus_Counter.w,d0; get destroyed enemies while on air flag
		addq.w	#2,MidAir_Bonus_Counter.w; add to destroyed enemies while on air flag

		cmpi.w	#6,d0
		blo.s	.nomax			; branch if less than 6 enemies
		moveq	#6,d0			; set 6 enemies

.nomax		move.w	d0,oboff3E(a1)		; store the counter
		move.w	EnemyPoints(pc,d0.w),d0	; get amount of points avarded

		cmpi.w	#32,MidAir_Bonus_Counter.w
		blo.s	.no10k
		move.w	#1000,d0		; 10000 points
		move.w	#10,oboff3E(a1)		; set hit count

.no10k		movea.w	a0,a3
		jsr	HUD_AddScore		; add points to hud

		move.l	#Obj_Explosion,(a1)	; change enemy to an explosion
		clr.b	routine(a1)

		tst.w	yvel(a0)
		bmi.s	.bouncedown		; if y-vel is negative
		move.w	ypos(a0),d0		; get y-position
		cmp.w	ypos(a1),d0		; compare that with obj y-pos
		bhs.s	.bounceup		; if above, bounce up
		neg.w	yvel(a0)			; negate y-speeed
		rts

.bouncedown	addi.w	#$100,yvel(a0)
		rts

.bounceup	subi.w	#$100,yvel(a0)
		rts

; ---------------------------------------------------------------------------
EnemyPoints:	dc.w 10, 20, 50, 100
; ---------------------------------------------------------------------------

Touch_ChkHurt:
		move.b	shistatus(a0),d0	; get secondary status bitfield
		andi.b	#$73,d0			; filter out såeedshoes and infinite inertia flags
		beq.s	Touch_ChkMoves		; if no powerups, branch
		and.b	shireact(a1),d0		; and the immune shields
		bne.s	Touch_NoHurt		; if you have one of them, branch
		btst	#0,shistatus(a0)
		bne.s	Touch_HasShield		; branch if player has a shield

Touch_ChkInvis:
		btst	#1,shistatus(a0)
		beq.s	HurtPlayer		; branch if player isn't invincible

Touch_NoHurt:
		moveq	#-1,d0
		rts

Touch_ChkMoves:
		cmpi.b	#1,jumpmove(a0)
		bne.s	Touch_ChkInvis		; branch if player isnt flying or gliding

Touch_HasShield:
		move.b	shireact(a1),d0
		andi.b	#8,d0
		beq.s	Touch_ChkInvis		; branch if object should be bounced off

Touch_BounceProjectile:
		move.w	xpos(a0),d1		; get xpos of player
		move.w	ypos(a0),d2		; get ypos of player
		sub.w	xpos(a1),d1		; sub xpos of obj from d1
		sub.w	ypos(a1),d2		; sub ypos of obj from d2
		jsr	GetArcTan.w		; get angle
		jsr	GetSine.w		; get sine and cosine

		muls.w	#-$800,d1
		asr.l	#8,d1
		move.w	d1,xvel(a1)		; set xspeed

		muls.w	#-$800,d0
		asr.l	#8,d0
		move.w	d0,yvel(a1)		; set yspeed

		clr.b	collision(a1)		; clear collision
		bra.s	Touch_NoHurt		; quit
; ---------------------------------------------------------------------------

HurtPlayer:
		tst.b	invultime(a0)
		bne.s	Touch_NoHurt		; branch if invulnerable
		movea.l	a1,a2

HurtPlayer2:
		btst	#0,shistatus(a0)
		bne.s	.hasShield		; branch if player has a shield
		tst.b	unk37(a0)
		bmi.s	.skpShield		; branch if fake shield flag is set
		cmpa.w	#Object_RAM&$FFFF,a0
		bne.s	.skpShield		; if main player, branch

		tst.w	Ring_Count.w
		beq.w	KillPlayer		; if ring count = 0, branch
		jsr	CreateObject		; try to create new object
		bne.s	.hasShield		; branch if could not create object

		move.l	#Obj_LostRing,(a1)	; set object ID
		move.w	xpos(a0),xpos(a1)	; set xpos
		move.w	ypos(a0),ypos(a1)	; set ypos
		move.w	Ring_Count.w,oboff3E(a1); set parent
.hasShield	andi.b	#$8E,shistatus(a0)	; remove all shields

.skpShield	move.b	#4,routine(a0)		; set routine counter
		jsr	Player_ResetOnFloor	; reset variables to touch the floor
		bset	#1,status(a0)		; set on air flag

		move.w	#-$400,yvel(a0)
		move.w	#-$200,xvel(a0)
		btst	#6,status(a0)
		beq.s	.notunderwater		; branch if not underwater
		move.w	#-$200,yvel(a0)
		move.w	#-$100,xvel(a0)

.notunderwater	move.w	xpos(a0),d0
		cmp.w	xpos(a2),d0
		blo.s	.noneg
		neg.w	xvel(a0)		; negate x-velocity

.noneg		clr.w	inertia(a0)		; clear inertia
		move.b	#$1A,anim(a0)		; set anim ID
		move.b	#120,invultime(a0)	; set invulnerability time

		moveq	#$35,d0			; set hurt sound ID
		cmpi.l	#Obj_Spikes,(a2)
		blo.s	.playsound
		cmpi.l	#TryHurtPlayer,(a2)
		bhs.s	.playsound
		moveq	#$37,d0			; set spike sound

.playsound	jsr	PlaySFX			; play SFX
		moveq	#-1,d0
		rts
; ---------------------------------------------------------------------------

KillPlayer:
		moveq	#$35,d0			; set hurt sound ID
		cmpi.l	#Obj_Spikes,(a2)
		blo.s	.soundset
		cmpi.l	#TryHurtPlayer,(a2)
		bhs.s	.soundset
		moveq	#$37,d0			; set spike sound
.soundset	bra.s	KillPlayer_Common

KillPlayer2:
		tst.w	Debug_Routine.w
		bne.s	KillPlayer_Debug	; if debug mode is on, no kill
		moveq	#$35,d0			; set hurt sound ID

KillPlayer_Common:
		clr.b	shireact(a0)		; remove shields and special modes
		clr.b	unk37(a0)		; clear some bitfield
		move.b	#6,routine(a0)		; set to death routine

		move.w	d0,-(sp)
		jsr	Player_ResetOnFloor	; reset variables to touch the floor
		move.w	(sp)+,d0

		bset	#1,status(a0)		; set in air bit
		move.w	#-$700,yvel(a0)		; set y-speed
		clr.w	xvel(a0)		; clear x-speed
		clr.w	inertia(a0)		; clear inertia
		move.b	#$18,anim(a0)		; set animation ID
		move.w	tile(a0),Debug_Saved_VRAM.w; store art tile
		bset	#7,tile(a0)		; set high plane
		jsr	PlaySFX			; play SFX

		move.b	Current_Mus.w,d0
		cmp.b	Last_Mus.w,d0
		beq.s	KillPlayer_Debug
		move.l	#Obj_FadeToMusic,Obj_dust.w; fade into zone music
		move.b	Current_Mus.w,Obj_dust+fademus_id.w; set to play zone music

KillPlayer_Debug:
		moveq	#-1,d0
		rts
; ---------------------------------------------------------------------------

Touch_Special:
		move.b	collision(a1),d1	; get collision
		andi.b	#$3F,d1			; get ID only

		cmpi.b	#2,d1
		beq.s	loc_103FA
		cmpi.b	#3,d1
		beq.s	loc_103FA
		rts
; ---------------------------------------------------------------------------

loc_103FA:
		cmpa.w	#Object_RAM&$FFFF,a0	; check for main player
		beq.s	.ismain			; if main player, add only once
		addq.b	#1,collhits(a1)		; add 1 to collision
.ismain		addq.b	#1,collhits(a1)		; add 1 to collision
		rts
; ---------------------------------------------------------------------------

ShieldTouchResponse:
		move.b	$2B(a0),d0		; get shield mode
		andi.b	#$71,d0
		beq.s	.rts			; branch if no shield are had

		move.w	$10(a0),d2		; get xpos
		move.w	$14(a0),d3		; get ypos
		subi.w	#$18,d2			; sub $18 from x-pos
		subi.w	#$18,d3			; sub $18 from y-pos
		move.w	#$30,d4			; set collision width
		move.w	#$30,d5			; set collision height

		lea	Coll_response_list.w,a4
		move.w	(a4)+,d6		; get entry amount
		beq.s	.rts			; if none, branch

.chkobj		movea.w	(a4)+,a1		; get address of the object
		move.b	$28(a1),d0		; get collision flags
		andi.b	#$C0,d0			; keep only collision type
		cmpi.b	#$80,d0
		beq.s	.chkwidth		; if 11 (harmful), branch

.nextobj	subq.w	#2,d6			; get next object
		bne.s	.chkobj			; check if
.rts		rts
; ---------------------------------------------------------------------------

.chkwidth	move.b	$28(a1),d0		; get collision num
		andi.w	#$3F,d0			; get collision ID only
		beq.s	.nextobj		; if null, branch

		add.w	d0,d0			; double it
		lea	Touch_Sizes,a2		; get touch sizes
		lea	(a2,d0.w),a2		; get collision size from list

		; proceeds to check if we touch horizontally
		moveq	#0,d1
		move.b	(a2)+,d1		; get collision width for object
		move.w	$10(a1),d0		; get x-position of object
		sub.w	d1,d0			; sub obj width from obj x
		sub.w	d2,d0			; sub player x from obj x
		bhs.s	.isleft			; if left from object, branch

		add.w	d1,d1			; double collision width
		add.w	d1,d0			; add width to obj x
		blo.s	.chky			; if less than 0, branch (you are left from the right boundary of object)
		bra.s	.nextobj

.isleft		cmp.w	d4,d0
		bhi.s	.nextobj

		; proceeds to check if we touch vertically
.chky		moveq	#0,d1
		move.b	(a2)+,d1		; get collision height for object
		move.w	$14(a1),d0		; get y-position of object
		sub.w	d1,d0			; sub obj height from obj y
		sub.w	d3,d0			; sub player y from obj y
		bhs.s	.chkup			; if above of the object, branch

		add.w	d1,d1			; double collision height
		add.w	d1,d0			; add height to obj y
		blo.w	.chkdone
		bra.s	.nextobj

.chkup		cmp.w	d5,d0
		bhi.s	.nextobj

.chkdone	move.b	$2B(a1),d0
		andi.b	#8,d0
		beq.s	.nextobj		; branch if object should not be bounced off

		move.w	$10(a0),d1		; get xpos of player
		move.w	$14(a0),d2		; get ypos of player
		sub.w	$10(a1),d1		; sub xpos of obj from d1
		sub.w	$14(a1),d2		; sub ypos of obj from d2
		jsr	GetArcTan		; get angle
		jsr	GetSine			; get sine and cosine

		muls.w	#-$800,d1
		asr.l	#8,d1
		move.w	d1,$18(a1)		; set xspeed

		muls.w	#-$800,d0
		asr.l	#8,d0
		move.w	d0,$1A(a1)		; set yspeed
		clr.b	$28(a1)			; clear collision
		rts
; ---------------------------------------------------------------------------

HyperTouchResponse:
		movem.l	a2-a4,-(sp)
		lea	Coll_response_list.w,a4
		move.w	(a4)+,d6		; get entry amount
		beq.s	.noobjs			; if none, branch

.doobj		movea.w	(a4)+,a1		; get address of the object
		move.b	$28(a1),d0		; get collision flags
		beq.s	.nextobj		; if no collision, check next
		bsr.s	.destroy		; destroy this enemy

.nextobj	subq.w	#2,d6			; get next object
		bne.s	.doobj			; check it
		moveq	#0,d0

.noobjs		movem.l	(sp)+,a2-a4
		rts
; ---------------------------------------------------------------------------

.destroy	tst.b	4(a1)
		bpl.s	.rts			; if offscreen, branch
		andi.b	#$C0,d0
		beq.s	.enemy			; branch if enemy

		cmpi.b	#$C0,d0
		beq.w	HyperTouch_Special	; branch if special
		tst.b	d0
		bmi.s	HyperTouch_Harmful	; branch if harmful
.rts		rts
; ---------------------------------------------------------------------------

.enemy		tst.b	$29(a1)
		beq.s	HyperTouch_DestroyEnemy	; branch if not "special enemy"
		rts

HyperTouch_DestroyEnemy:
		btst	#2,$2A(a1)
		beq.s	.noRSS			; branch if Remember Sprite State flag isnt set
		move.b	$3B(a1),d0		; get bit to use
		movea.w	$3C(a1),a2		; get the RSS bits
		bclr	d0,(a2)			; clear the correct bit

.noRSS		bset	#7,$2A(a1)		; set destroyed bit
		moveq	#0,d0
		move.w	MidAir_Bonus_Counter.w,d0; get destroyed enemies while on air flag
		addq.w	#2,MidAir_Bonus_Counter.w; add to destroyed enemies while on air flag

		cmpi.w	#6,d0
		blo.s	.nomax			; branch if less than 6 enemies
		moveq	#6,d0			; set 6 enemies

.nomax		move.w	d0,$3E(a1)		; store the counter
		move.w	EnemyPoints2(pc,d0.w),d0; get amount of points avarded

		cmpi.w	#32,MidAir_Bonus_Counter.w
		blo.s	.no10k
		move.w	#1000,d0		; 10000 points
		move.w	#10,$3E(a1)		; set hit count

.no10k		movea.w	a0,a3
		jsr	HUD_AddScore		; add points to hud
		move.l	#Obj_Explosion,(a1)	; change enemy to an explosion
		move.b	#0,5(a1)
		rts

; ---------------------------------------------------------------------------
EnemyPoints2:	dc.w 10, 20, 50, 100
; ---------------------------------------------------------------------------

HyperTouch_Harmful:
		move.b	$2B(a1),d0
		andi.b	#8,d0
		bne.w	Touch_BounceProjectile
		rts
; ---------------------------------------------------------------------------

HyperTouch_Special:
		ori.b	#3,$29(a1)
		cmpi.w	#3,Player_Mode.w
		bne.s	.notKnuckles			; branch if not knuckles
		move.w	$10(a1),Obj_player_2+$10.w	; no clue what this is needed for
		move.w	$14(a1),Obj_player_2+$14.w	; but this just copies x and y pos to p2 x and y pos

.notKnuckles	move.b	#2,Obj_player_2+$20.w		; make sidekick roll
		bset	#1,Obj_player_2+$2A.w		; and put him in air
		rts
; ---------------------------------------------------------------------------

Map_2EDD0:
		dc.w word_2EDD8-Map_2EDD0
		dc.w word_2EDE6-Map_2EDD0
		dc.w word_2EDF4-Map_2EDD0
		dc.w word_2EE02-Map_2EDD0

word_2EDD8:
		dc.w 2
		dc.b  $F8,  $D,	  0,   0, $FF, $B8
		dc.b  $F8,  $D,	  0,   8, $FF, $D8

word_2EDE6:
		dc.w 2
		dc.b  $F8,  $D,	  0, $14,   0,	 8
		dc.b  $F8,  $D,	  0,  $C,   0, $28

word_2EDF4:
		dc.w 2
		dc.b  $F8,   9,	  0, $1C, $FF, $C4
		dc.b  $F8,  $D,	  0,   8, $FF, $DC

word_2EE02:
		dc.w 2
		dc.b  $F8,  $D,	  0, $14,   0,	$C
		dc.b  $F8,  $D,	  0,  $C,   0, $2C


