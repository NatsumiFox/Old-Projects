Obj_Knuckles:
		lea	Player1_TopSpeed.w,a4
		lea	Distance_from_screen_top.w,a5
		lea	Obj_dust.w,a6
		tst.w	Debug_Routine.w
		beq.s	loc_1648E
		cmpi.b	#1,Debug_Placement_Flag.w
		beq.s	loc_16488
		btst	#4,Ctrl_1_Press.w
		beq.s	loc_1646C
		move.w	#0,Debug_Routine.w

loc_1646C:
		addq.b	#1,$22(a0)
		cmpi.b	#-5,$22(a0)
		blo.s	loc_1647E
		move.b	#0,$22(a0)


; ---------------------------------------------------------------------------

loc_1647E:
		bsr.w	Knuckles_Load_PLC
		jmp	DrawSprite


; ---------------------------------------------------------------------------

loc_16488:
		jmp	DebugMode


; ---------------------------------------------------------------------------

loc_1648E:
		moveq	#0,d0
		move.b	5(a0),d0
		move.w	off_1649C(pc,d0.w),d1
		jmp	off_1649C(pc,d1.w)


; ---------------------------------------------------------------------------

off_1649C:
		dc.w loc_164AA-off_1649C
		dc.w loc_1656C-off_1649C
		dc.w loc_17BB6-off_1649C
		dc.w loc_17C88-off_1649C
		dc.w loc_17CBA-off_1649C
		dc.w loc_17CCE-off_1649C
		dc.w loc_17CEA-off_1649C

loc_164AA:
		addq.b	#2,5(a0)
		move.b	#$13,$1E(a0)
		move.b	#9,$1F(a0)
		move.b	#$13,$44(a0)
		move.b	#9,$45(a0)
		move.l	#Map_Knuckles,$C(a0)
		move.w	#$100,8(a0)
		move.b	#$18,7(a0)
		move.b	#$18,6(a0)
		move.b	#4,4(a0)
		move.b	#2,$38(a0)
		move.w	#$600,(a4)
		move.w	#$C,2(a4)
		move.w	#$80,4(a4)

		move.w	#$680,$A(a0)
		move.b	#$C,$46(a0)
		move.b	#$D,$47(a0)

loc_16534:
		move.b	#0,$30(a0)
		move.b	#4,$31(a0)
		move.b	#0,Super_Flag.w
		move.b	#$1E,$2C(a0)
		subi.w	#$20,$10(a0)
		addi.w	#4,$14(a0)
		jsr	Reset_Player_Position_Array
		addi.w	#$20,$10(a0)
		subi.w	#4,$14(a0)
		rts

loc_1656C:
		tst.w	Debug_Mode_Flag.w
		beq.s	loc_165A2
		bclr	#6,Ctrl_1_Press.w
		beq.s	loc_16580
		eori.b	#1,ReverseGravity_Flag.w

loc_16580:
		btst	#4,Ctrl_1_Press.w
		beq.s	loc_165A2
		move.w	#1,Debug_Routine.w
		clr.b	Control_Locked.w
		btst	#5,Ctrl_1_Held.w
		beq.s	locret_165A0
		move.w	#2,Debug_Routine.w


; ---------------------------------------------------------------------------

locret_165A0:
		rts

loc_165A2:
		tst.b	Control_Locked.w
		bne.s	loc_165AE
		move.w	Ctrl_1_Held.w,Ctrl_1_Held_Logical.w


; ---------------------------------------------------------------------------

loc_165AE:
		btst	#0,$2E(a0)
		beq.s	loc_165BE
		move.b	#0,$2F(a0)
		bra.s	loc_165D8

loc_165BE:
		movem.l	a4-a6,-(sp)
		moveq	#0,d0
		move.b	$2A(a0),d0
		andi.w	#6,d0
		move.w	off_16642(pc,d0.w),d1
		jsr	off_16642(pc,d1.w)
		movem.l	(sp)+,a4-a6

loc_165D8:
		cmpi.w	#$FF00,Camera_min_Y.w
		bne.s	loc_165E8
		move.w	Screen_Y_wrap_value.w,d0
		and.w	d0,$14(a0)

loc_165E8:
		bsr.s	sub_1664A
		bsr.w	sub_11B30
		bsr.w	sub_10D66
		bsr.w	sub_166EE
		move.b	Player_NextTilt.w,$3A(a0)
		move.b	Player_CurrentTilt.w,$3B(a0)
		tst.b	Player1_OnWater_Flag.w
		beq.s	loc_16614
		tst.b	$20(a0)
		bne.s	loc_16614
		move.b	$21(a0),$20(a0)

loc_16614:
		btst	#1,$2E(a0)
		bne.s	loc_16630
		bsr.w	Animate_Knuckles
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_1662C
		eori.b	#2,4(a0)

loc_1662C:
		bsr.w	Knuckles_Load_PLC

loc_16630:
		move.b	$2E(a0),d0
		andi.b	#-$60,d0
		bne.s	locret_16640
		jsr	TouchResponse_Normal


; ---------------------------------------------------------------------------

locret_16640:
		rts


; ############### S U B	R O U T	I N E #######################################

off_16642:
		dc.w Knux_Stand_Path-off_16642
		dc.w Knux_Stand_Freespace-off_16642
		dc.w Knux_Spin_Path-off_16642
		dc.w Knux_Spin_Freespace-off_16642

sub_1664A:
		move.b	$34(a0),d0
		beq.s	loc_16658
		subq.b	#1,$34(a0)
		lsr.b	#3,d0
		bhs.s	loc_1665E

loc_16658:
		jsr	DrawSprite

loc_1665E:
		btst	#1,$2B(a0)
		beq.s	loc_1669A
		tst.b	$35(a0)
		beq.s	loc_1669A
		move.b	Level_Frame_Timer+1.w,d0
		andi.b	#7,d0
		bne.s	loc_1669A
		subq.b	#1,$35(a0)
		bne.s	loc_1669A
		tst.b	Boss_Active_Flag.w
		bne.s	loc_16694
		cmpi.b	#$C,$2C(a0)
		blo.s	loc_16694
		move.b	Current_Mus.w,d0
		jsr	PlayMusic

loc_16694:
		bclr	#1,$2B(a0)

loc_1669A:
		btst	#2,$2B(a0)
		beq.s	locret_166EC
		tst.b	$36(a0)
		beq.s	locret_166EC
		move.b	Level_Frame_Timer+1.w,d0
		andi.b	#7,d0
		bne.s	locret_166EC
		subq.b	#1,$36(a0)
		bne.s	locret_166EC
		move.w	#$600,(a4)
		move.w	#$C,2(a4)
		move.w	#$80,4(a4)
		tst.b	Super_Flag.w
		beq.s	loc_166DE
		move.w	#$800,(a4)
		move.w	#$18,2(a4)
		move.w	#$C0,4(a4)


; ---------------------------------------------------------------------------

loc_166DE:
		bclr	#2,$2B(a0)
		moveq	#0,d0
		jmp	PlayTempo


; End of function sub_1664A
; ############### S U B	R O U T	I N E #######################################

locret_166EC:
		rts

sub_166EE:
		tst.b	Water_Flag.w
		bne.s	loc_166F6


; ---------------------------------------------------------------------------

locret_166F4:
		rts

loc_166F6:
		move.w	Water_Height_Default.w,d0
		cmp.w	$14(a0),d0
		bge.s	loc_1676E
		bset	#6,$2A(a0)
		bne.s	locret_166F4
		addq.b	#1,Water_Routine.w
		movea.l	a0,a1
		jsr	player_resetairtimer
		move.l	#Obj_Air_CountDown,Object_RAM_static+$4A.w
		move.b	#-$7F,Object_RAM_static+$76.w
		move.l	a0,Object_RAM_static+$8A.w
		move.w	#$300,(a4)
		move.w	#6,2(a4)
		move.w	#$40,4(a4)
		tst.b	Super_Flag.w
		beq.s	loc_1674A
		move.w	#$400,(a4)
		move.w	#$C,2(a4)
		move.w	#$60,4(a4)


; ---------------------------------------------------------------------------

loc_1674A:
		tst.b	$2E(a0)
		bne.s	locret_166F4
		asr	$18(a0)
		asr	$1A(a0)
		asr	$1A(a0)
		beq.s	locret_166F4
		move.w	#$100,$20(a6)
		move.w	#$39,d0
		jmp	PlaySFX

loc_1676E:
		bclr	#6,$2A(a0)
		beq.w	locret_166F4
		addq.b	#1,Water_Routine.w
		movea.l	a0,a1
		jsr	player_resetairtimer
		move.w	#$600,(a4)
		move.w	#$C,2(a4)
		move.w	#$80,4(a4)
		tst.b	Super_Flag.w
		beq.s	loc_167A8
		move.w	#$800,(a4)
		move.w	#$18,2(a4)
		move.w	#$C0,4(a4)

loc_167A8:
		cmpi.b	#4,5(a0)
		beq.s	loc_167C4
		tst.b	$2E(a0)
		bne.s	loc_167C4
		move.w	$1A(a0),d0
		cmpi.w	#-$400,d0
		blt.s	loc_167C4
		asl	$1A(a0)

loc_167C4:
		cmpi.b	#$1C,$20(a0)
		beq.w	locret_166F4
		tst.w	$1A(a0)
		beq.w	locret_166F4
		move.w	#$100,$20(a6)
		cmpi.w	#-$1000,$1A(a0)
		bgt.s	loc_167EA
		move.w	#-$1000,$1A(a0)


; End of function sub_166EE
; ---------------------------------------------------------------------------

loc_167EA:
		move.w	#$39,d0
		jmp	PlaySFX

Knux_Stand_Path:
		bsr.w	Player_Spindash
		bsr.w	Obj_Knux_Jump
		bsr.w	sub_11DA6
		bsr.w	Knux_InputAcceleration_Path
		bsr.w	Player_Spin
		bsr.w	Player_Check_Screen_Boundaries
		jsr	ObjectRevMove
		jsr	Call_Player_AnglePos.w
		bsr.w	sub_11E2A
		tst.b	BG_Layer_Scroll_Timer2+2.w
		beq.s	locret_1684A
		jsr	sub_F846.w
		tst.w	d1
		bmi.w	KillPlayer2
		movem.l	a4-a6,-(sp)
		jsr	ChkWallDist_Left.w
		tst.w	d1
		bpl.s	loc_1683A
		sub.w	d1,$10(a0)

loc_1683A:
		jsr	CheckRightWallDist.w
		tst.w	d1
		bpl.s	loc_16846
		add.w	d1,$10(a0)

loc_16846:
		movem.l	(sp)+,a4-a6


; ---------------------------------------------------------------------------

locret_1684A:
		rts

Knux_Stand_Freespace:
		tst.b	$2F(a0)
		bne.s	loc_1687C
		bsr.w	Obj_Knux_JumpHeight
		bsr.w	sub_17680
		bsr.w	Player_Check_Screen_Boundaries
		jsr	ObjectGravity
		btst	#6,$2A(a0)
		beq.s	loc_16872
		subi.w	#$28,$1A(a0)


; ---------------------------------------------------------------------------

loc_16872:
		bsr.w	sub_11E8C
		bsr.w	sub_11EEC
		rts

loc_1687C:
		bsr.w	sub_16FF6
		bsr.w	Player_Check_Screen_Boundaries
		jsr	ObjectRevMove
		bsr.w	sub_16890


; ############### S U B	R O U T	I N E #######################################

locret_1688E:
		rts

sub_16890:
		move.b	$2F(a0),d0
		beq.s	locret_1688E
		cmpi.b	#2,d0
		beq.w	loc_16A8E
		cmpi.b	#3,d0
		beq.w	loc_16B06
		cmpi.b	#4,d0
		beq.w	loc_16BB6
		cmpi.b	#5,d0
		beq.w	loc_16F6C
		bsr.w	sub_1793E
		btst	#1,Knuckles_GlideStateFlag.w
		beq.s	loc_1690E
		btst	#5,Knuckles_GlideStateFlag.w
		bne.w	loc_1696C
		move.b	Ctrl_1_Held_Logical.w,d0
		andi.b	#$70,d0
		bne.s	loc_1690A
		move.b	#2,$2F(a0)
		move.b	#$21,$20(a0)
		bclr	#0,$2A(a0)
		tst.w	$18(a0)
		bpl.s	loc_168F4
		bset	#0,$2A(a0)


; ---------------------------------------------------------------------------

loc_168F4:
		asr	$18(a0)
		asr	$18(a0)
		move.b	$44(a0),$1E(a0)
		move.b	$45(a0),$1F(a0)
		rts


; ---------------------------------------------------------------------------

loc_1690A:
		bra.w	sub_16FA8

loc_1690E:
		bclr	#0,$2A(a0)
		tst.w	$18(a0)
		bpl.s	loc_16920
		bset	#0,$2A(a0)


; ---------------------------------------------------------------------------

loc_16920:
		move.b	$26(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	loc_1693E
		move.w	$1C(a0),$18(a0)
		move.w	#0,$1A(a0)
		bra.w	Knux_ResetOnFloor

loc_1693E:
		move.b	#3,$2F(a0)
		move.b	#-$34,$22(a0)
		move.b	#$7F,$24(a0)
		move.b	#0,$23(a0)
		cmpi.b	#$C,$2C(a0)
		blo.s	locret_1696A
		move.b	#6,5(a6)
		move.b	#$15,$22(a6)


; ---------------------------------------------------------------------------

locret_1696A:
		rts


; ---------------------------------------------------------------------------

loc_1696C:
		tst.b	Knuckles_GlideStateFlag2.w
		bmi.w	loc_16A6E
		move.b	$47(a0),d5
		move.b	$25(a0),d0
		addi.b	#$40,d0
		bpl.s	loc_16996
		bset	#0,$2A(a0)
		jsr	CheckCeilingDist_Left.w
		or.w	d0,d1
		bne.s	loc_16A00
		addq.w	#1,$10(a0)
		bra.s	loc_169A6

loc_16996:
		bclr	#0,$2A(a0)
		jsr	CheckCeilingDist_Right.w
		or.w	d0,d1
		bne.w	loc_16A58

loc_169A6:
		moveq	#$4A,d0
		tst.b	Super_Flag.w
		bpl.s	loc_169C2
		cmpi.w	#$480,$1C(a0)
		blo.s	loc_169C2
		move.w	#$14,ScreenShake2_Flag.w
		bsr.w	HyperTouchResponse
		moveq	#$49,d0


; ---------------------------------------------------------------------------

loc_169C2:
		jsr	PlaySFX
		move.w	#0,$1C(a0)
		move.w	#0,$18(a0)
		move.w	#0,$1A(a0)
		move.b	#4,$2F(a0)
		move.b	#-$49,$22(a0)
		move.b	#$7F,$24(a0)
		move.b	#0,$23(a0)
		move.b	#3,$25(a0)
		move.w	$10(a0),$12(a0)
		rts

loc_16A00:
		move.w	$10(a0),d3
		move.b	$1E(a0),d0
		ext.w	d0
		sub.w	d0,d3
		subq.w	#1,d3
		tst.b	ReverseGravity_Flag.w
		bne.s	loc_16A34


; ---------------------------------------------------------------------------

loc_16A14:
		move.w	$14(a0),d2
		subi.w	#$B,d2
		jsr	ChkFloorEdge_Part3
		tst.w	d1
		bmi.s	loc_16A6E
		cmpi.w	#$C,d1
		bhs.s	loc_16A6E
		add.w	d1,$14(a0)
		bra.w	loc_169A6


; ---------------------------------------------------------------------------

loc_16A34:
		move.w	$14(a0),d2
		addi.w	#$B,d2
		eori.w	#$F,d2
		jsr	ChkFloorEdge2_RevGravity
		tst.w	d1
		bmi.s	loc_16A6E
		cmpi.w	#$C,d1
		bhs.s	loc_16A6E
		sub.w	d1,$14(a0)
		bra.w	loc_169A6


; ---------------------------------------------------------------------------

loc_16A58:
		move.w	$10(a0),d3
		move.b	$1E(a0),d0
		ext.w	d0
		add.w	d0,d3
		addq.w	#1,d3
		tst.b	ReverseGravity_Flag.w
		bne.s	loc_16A34
		bra.s	loc_16A14


; ---------------------------------------------------------------------------

loc_16A6E:
		move.b	#2,$2F(a0)
		move.b	#$21,$20(a0)
		move.b	$44(a0),$1E(a0)
		move.b	$45(a0),$1F(a0)
		bset	#1,Knuckles_GlideStateFlag.w
		rts

loc_16A8E:
		bsr.w	sub_17680
		addi.w	#$38,$1A(a0)
		btst	#6,$2A(a0)
		beq.s	loc_16AA6
		subi.w	#$28,$1A(a0)

loc_16AA6:
		bsr.w	sub_1793E
		btst	#1,Knuckles_GlideStateFlag.w
		bne.s	locret_16B04
		move.w	#0,$1C(a0)
		move.w	#0,$18(a0)
		move.w	#0,$1A(a0)
		move.b	$1E(a0),d0
		sub.b	$44(a0),d0
		ext.w	d0
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_16AD6
		neg.w	d0


; ---------------------------------------------------------------------------

loc_16AD6:
		add.w	d0,$14(a0)
		moveq	#$4C,d0
		jsr	PlaySFX
		move.b	$26(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	loc_16AF4
		bra.w	Knux_ResetOnFloor

loc_16AF4:
		bsr.w	Knux_ResetOnFloor
		move.w	#$F,$32(a0)
		move.b	#$23,$20(a0)


; ---------------------------------------------------------------------------

locret_16B04:
		rts


; ---------------------------------------------------------------------------

loc_16B06:
		move.b	Ctrl_1_Held_Logical.w,d0
		andi.b	#$70,d0
		beq.s	loc_16B2A
		tst.w	$18(a0)
		bpl.s	loc_16B22
		addi.w	#$20,$18(a0)
		bmi.s	loc_16B20
		bra.s	loc_16B2A


; ---------------------------------------------------------------------------

loc_16B20:
		bra.s	loc_16B64

loc_16B22:
		subi.w	#$20,$18(a0)
		bpl.s	loc_16B64

loc_16B2A:
		move.w	#0,$1C(a0)
		move.w	#0,$18(a0)
		move.w	#0,$1A(a0)
		move.b	$1E(a0),d0
		sub.b	$44(a0),d0
		ext.w	d0
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_16B4E
		neg.w	d0


; ---------------------------------------------------------------------------

loc_16B4E:
		add.w	d0,$14(a0)
		bsr.w	Knux_ResetOnFloor
		move.w	#$F,$32(a0)
		move.b	#$22,$20(a0)
		rts

loc_16B64:
		bsr.w	sub_1793E
		jsr	sub_11FD6.w
		cmpi.w	#$E,d1
		bge.s	loc_16B96
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_16B7A
		neg.w	d1

loc_16B7A:
		add.w	d1,$14(a0)
		move.b	d3,$26(a0)
		move.b	Level_Frame_Timer+1.w,d0
		andi.b	#7,d0
		bne.s	locret_16B94
		moveq	#$7E,d0
		jsr	PlaySFX


; ---------------------------------------------------------------------------

locret_16B94:
		rts


; ---------------------------------------------------------------------------

loc_16B96:
		move.b	#2,$2F(a0)
		move.b	#$21,$20(a0)
		move.b	$44(a0),$1E(a0)
		move.b	$45(a0),$1F(a0)
		bset	#1,Knuckles_GlideStateFlag.w
		rts

loc_16BB6:
		tst.b	Knuckles_GlideStateFlag2.w
		bmi.w	loc_16ED2
		move.w	$10(a0),d0
		cmp.w	$12(a0),d0
		bne.w	loc_16ED2
		btst	#3,$2A(a0)
		bne.w	loc_16ED2
		move.w	#0,$1C(a0)
		move.w	#0,$18(a0)
		move.w	#0,$1A(a0)
		move.l	Primary_Collision.w,Current_Collision.w
		cmpi.b	#$D,$47(a0)
		beq.s	loc_16BFA
		move.l	Secondary_Collision.w,Current_Collision.w


; ---------------------------------------------------------------------------

loc_16BFA:
		move.b	$47(a0),d5
		moveq	#0,d1
		btst	#0,Ctrl_1_Held_Logical.w
		beq.w	loc_16D10
		tst.b	ReverseGravity_Flag.w
		bne.w	loc_16DA8
		move.w	$14(a0),d2
		subi.w	#$B,d2
		bsr.w	sub_16F4E
		cmpi.w	#4,d1
		bge.w	loc_16EBA
		tst.w	d1
		bne.w	loc_16E60
		move.b	$47(a0),d5
		move.w	$14(a0),d2
		subq.w	#8,d2
		move.w	$10(a0),d3
		jsr	sub_FBEE.w
		tst.w	d1
		bpl.s	loc_16C4C
		sub.w	d1,$14(a0)
		moveq	#1,d1
		bra.w	loc_16E10

loc_16C4C:
		subq.w	#1,$14(a0)
		tst.b	Super_Flag.w
		beq.s	loc_16C5A
		subq.w	#1,$14(a0)


; ---------------------------------------------------------------------------

loc_16C5A:
		moveq	#1,d1
		move.w	Camera_min_Y.w,d0
		cmpi.w	#-$100,d0
		beq.w	loc_16E10
		addi.w	#$10,d0
		cmp.w	$14(a0),d0
		ble.w	loc_16E10
		move.w	d0,$14(a0)
		bra.w	loc_16E10

loc_16C7C:
		cmpi.b	#$BD,$22(a0)
		bne.s	loc_16C9E
		move.b	#$B7,$22(a0)
		subq.w	#3,$14(a0)
		subq.w	#3,$10(a0)
		btst	#0,$2A(a0)
		beq.s	loc_16C9E
		addq.w	#6,$10(a0)


; ---------------------------------------------------------------------------

loc_16C9E:
		move.w	$14(a0),d2
		subi.w	#$B,d2
		bsr.w	sub_16F4E
		tst.w	d1
		bne.w	loc_16ED2
		move.b	$46(a0),d5
		move.w	$14(a0),d2
		subi.w	#9,d2
		move.w	$10(a0),d3
		jsr	sub_FBEE.w
		tst.w	d1
		bpl.s	loc_16CFC
		sub.w	d1,$14(a0)
		move.b	Player_NextTilt.w,d0
		addi.b	#$40,d0
		neg.b	d0
		subi.b	#$40,d0
		move.b	d0,$26(a0)
		move.w	#0,$1C(a0)
		move.w	#0,$18(a0)
		move.w	#0,$1A(a0)
		bsr.w	Knux_ResetOnFloor
		move.b	#5,$20(a0)
		rts

loc_16CFC:
		subq.w	#1,$14(a0)
		tst.b	Super_Flag.w
		beq.s	loc_16D0A
		subq.w	#1,$14(a0)


; ---------------------------------------------------------------------------

loc_16D0A:
		moveq	#-1,d1
		bra.w	loc_16E10

loc_16D10:
		btst	#1,Ctrl_1_Held_Logical.w
		beq.w	loc_16E10
		tst.b	ReverseGravity_Flag.w
		bne.w	loc_16C7C
		cmpi.b	#$BD,$22(a0)
		bne.s	loc_16D44
		move.b	#$B7,$22(a0)
		addq.w	#3,$14(a0)
		subq.w	#3,$10(a0)
		btst	#0,$2A(a0)
		beq.s	loc_16D44
		addq.w	#6,$10(a0)

loc_16D44:
		move.w	$14(a0),d2
		addi.w	#$B,d2
		bsr.w	sub_16F4E
		tst.w	d1
		bne.w	loc_16ED2
		move.b	$46(a0),d5
		move.w	$14(a0),d2
		addi.w	#9,d2
		move.w	$10(a0),d3
		jsr	sub_F828.w
		tst.w	d1
		bpl.s	loc_16D96


; ---------------------------------------------------------------------------

loc_16D6E:
		add.w	d1,$14(a0)
		move.b	Player_NextTilt.w,$26(a0)
		move.w	#0,$1C(a0)
		move.w	#0,$18(a0)
		move.w	#0,$1A(a0)
		bsr.w	Knux_ResetOnFloor
		move.b	#5,$20(a0)
		rts

loc_16D96:
		addq.w	#1,$14(a0)
		tst.b	Super_Flag.w
		beq.s	loc_16DA4
		addq.w	#1,$14(a0)


; ---------------------------------------------------------------------------

loc_16DA4:
		moveq	#-1,d1
		bra.s	loc_16E10


; ---------------------------------------------------------------------------

loc_16DA8:
		move.w	$14(a0),d2
		addi.w	#$B,d2
		bsr.w	sub_16F4E
		cmpi.w	#4,d1
		bge.w	loc_16EBA
		tst.w	d1
		bne.w	loc_16E60
		move.b	$47(a0),d5
		move.w	$14(a0),d2
		addq.w	#8,d2
		move.w	$10(a0),d3
		jsr	sub_F828.w
		tst.w	d1
		bpl.s	loc_16DE2
		add.w	d1,$14(a0)
		moveq	#1,d1
		bra.w	loc_16E10

loc_16DE2:
		addq.w	#1,$14(a0)
		tst.b	Super_Flag.w
		beq.s	loc_16DF0
		addq.w	#1,$14(a0)

loc_16DF0:
		moveq	#1,d1
		cmpi.w	#-$100,Camera_min_Y.w
		beq.w	loc_16E10
		move.w	Camera_max_Y.w,d0
		addi.w	#$D0,d0
		cmp.w	$14(a0),d0
		bge.w	loc_16E10
		move.w	d0,$14(a0)

loc_16E10:
		move.b	Ctrl_1_Held_Logical.w,d0
		andi.b	#3,d0
		bne.s	loc_16E34
		move.b	$46(a0),d5
		move.w	$14(a0),d2
		addi.w	#9,d2
		move.w	$10(a0),d3
		jsr	sub_F828.w
		tst.w	d1
		bmi.w	loc_16D6E

loc_16E34:
		tst.w	d1
		beq.s	loc_16E60
		subq.b	#1,$25(a0)
		bpl.s	loc_16E60
		move.b	#3,$25(a0)
		add.b	$22(a0),d1
		cmpi.b	#$B7,d1
		bhs.s	loc_16E52
		move.b	#$BC,d1

loc_16E52:
		cmpi.b	#$BC,d1
		bls.s	loc_16E5C
		move.b	#$B7,d1

loc_16E5C:
		move.b	d1,$22(a0)

loc_16E60:
		move.b	#$20,$24(a0)
		move.b	#0,$23(a0)
		move.w	Ctrl_1_Held_Logical.w,d0
		andi.w	#$70,d0
		beq.s	locret_16EB8
		move.w	#-$380,$1A(a0)
		move.w	#$400,$18(a0)
		bchg	#0,$2A(a0)
		bne.s	loc_16E8E
		neg.w	$18(a0)

loc_16E8E:
		bset	#1,$2A(a0)
		move.b	#1,$40(a0)
		move.b	#$E,$1E(a0)
		move.b	#7,$1F(a0)
		move.b	#2,$20(a0)
		bset	#2,$2A(a0)
		move.b	#0,$2F(a0)


; ---------------------------------------------------------------------------

locret_16EB8:
		rts

loc_16EBA:
		move.b	#5,$2F(a0)
		cmpi.b	#-$43,$22(a0)
		beq.s	locret_16ED0
		move.b	#0,$25(a0)
		bsr.s	sub_16EFE


; ---------------------------------------------------------------------------

locret_16ED0:
		rts


; End of function sub_16890
; ############### S U B	R O U T	I N E #######################################

loc_16ED2:
		move.b	#2,$2F(a0)
		move.w	#$2121,$20(a0)
		move.b	#$CB,$22(a0)
		move.b	#7,$24(a0)
		move.b	#1,$23(a0)
		move.b	$44(a0),$1E(a0)
		move.b	$45(a0),$1F(a0)
		rts

sub_16EFE:
		moveq	#0,d0
		move.b	$25(a0),d0
		lea	byte_16F3E(pc,d0.w),a1
		move.b	(a1)+,$22(a0)
		move.b	(a1)+,d0
		ext.w	d0
		btst	#0,$2A(a0)
		beq.s	loc_16F1A
		neg.w	d0

loc_16F1A:
		add.w	d0,$10(a0)
		move.b	(a1)+,d1
		ext.w	d1
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_16F2A
		neg.w	d1


; End of function sub_16EFE
; ---------------------------------------------------------------------------

loc_16F2A:
		add.w	d1,$14(a0)
		move.b	(a1)+,$24(a0)
		addq.b	#4,$25(a0)
		move.b	#0,$23(a0)
		rts


; ############### S U B	R O U T	I N E #######################################

byte_16F3E:
		dc.b  $BD,   3,	$FD,   6, $BE,	 8, $F6,   6, $BF, $F8,	$F4,   6, $D2,	 8, $FB,   6


; ---------------------------------------------------------------------------

sub_16F4E:
		move.b	$47(a0),d5
		btst	#0,$2A(a0)
		bne.s	loc_16F62
		move.w	$10(a0),d3
		jmp	ChkWallDist2_Right.w


; End of function sub_16F4E
; ---------------------------------------------------------------------------

loc_16F62:
		move.w	$10(a0),d3
		subq.w	#1,d3
		jmp	ChkWallDist2_Left.w

loc_16F6C:
		tst.b	$24(a0)
		bne.s	locret_16FA6
		bsr.w	sub_16EFE
		cmpi.b	#$10,$25(a0)
		bne.s	locret_16FA6
		move.w	#0,$1C(a0)
		move.w	#0,$18(a0)
		move.w	#0,$1A(a0)
		btst	#0,$2A(a0)
		beq.s	loc_16F9C
		subq.w	#1,$10(a0)

loc_16F9C:
		bsr.w	Knux_ResetOnFloor
		move.b	#5,$20(a0)


; ############### S U B	R O U T	I N E #######################################

locret_16FA6:
		rts

sub_16FA8:
		move.b	#$20,$24(a0)
		move.b	#0,$23(a0)
		move.w	#$2020,$20(a0)
		bclr	#5,$2A(a0)
		bclr	#0,$2A(a0)
		moveq	#0,d0
		move.b	$25(a0),d0
		addi.b	#$10,d0
		lsr.w	#5,d0
		move.b	byte_16FEE(pc,d0.w),d1
		move.b	d1,$22(a0)
		cmpi.b	#$C4,d1
		bne.s	locret_16FEC
		bset	#0,$2A(a0)
		move.b	#$C0,$22(a0)


; End of function sub_16FA8
; ---------------------------------------------------------------------------

locret_16FEC:
		rts


; ############### S U B	R O U T	I N E #######################################

byte_16FEE:
		dc.b $C0
		dc.b $C1
		dc.b $C2
		dc.b $C3
		dc.b $C4
		dc.b $C3
		dc.b $C2
		dc.b $C1


; ---------------------------------------------------------------------------

sub_16FF6:
		cmpi.b	#1,$2F(a0)
		bne.w	loc_170B4
		move.w	$1C(a0),d0
		cmpi.w	#$400,d0
		bhs.s	loc_1700E
		addq.w	#8,d0
		bra.s	loc_17028

loc_1700E:
		cmpi.w	#$1800,d0
		bhs.s	loc_17028
		move.b	$25(a0),d1
		andi.b	#$7F,d1
		bne.s	loc_17028
		addq.w	#4,d0
		tst.b	Super_Flag.w
		beq.s	loc_17028
		addq.w	#8,d0

loc_17028:
		move.w	d0,$1C(a0)
		move.b	$25(a0),d0
		btst	#2,Ctrl_1_Held_Logical.w
		beq.s	loc_17048
		cmpi.b	#$80,d0
		beq.s	loc_17048
		tst.b	d0
		bpl.s	loc_17044
		neg.b	d0


; ---------------------------------------------------------------------------

loc_17044:
		addq.b	#2,d0
		bra.s	loc_17066

loc_17048:
		btst	#3,Ctrl_1_Held_Logical.w
		beq.s	loc_1705C
		tst.b	d0
		beq.s	loc_1705C
		bmi.s	loc_17058
		neg.b	d0


; ---------------------------------------------------------------------------

loc_17058:
		addq.b	#2,d0
		bra.s	loc_17066

loc_1705C:
		move.b	d0,d1
		andi.b	#$7F,d1
		beq.s	loc_17066
		addq.b	#2,d0

loc_17066:
		move.b	d0,$25(a0)
		move.b	$25(a0),d0


; ---------------------------------------------------------------------------

loc_1706E:
		jsr	GetSine
		muls.w	$1C(a0),d1
		asr.l	#8,d1
		move.w	d1,$18(a0)
		cmpi.w	#$80,$1A(a0)
		blt.s	loc_1708E
		subi.w	#$20,$1A(a0)
		bra.s	loc_17094

loc_1708E:
		addi.w	#$20,$1A(a0)

loc_17094:
		move.w	Camera_min_Y.w,d0
		cmpi.w	#-$100,d0
		beq.w	loc_170B4
		addi.w	#$10,d0
		cmp.w	$14(a0),d0
		ble.w	loc_170B4
		asr	$18(a0)
		asr	$1C(a0)

loc_170B4:
		cmpi.w	#$60,(a5)
		beq.s	locret_170C0
		bhs.s	loc_170BE
		addq.w	#4,(a5)

loc_170BE:
		subq.w	#2,(a5)


; End of function sub_16FF6
; ---------------------------------------------------------------------------

locret_170C0:
		rts

Knux_Spin_Path:
		tst.b	$3D(a0)
		bne.s	loc_170CC
		bsr.w	Obj_Knux_Jump

loc_170CC:
		bsr.w	sub_11DEE
		bsr.w	sub_1753A
		bsr.w	Player_Check_Screen_Boundaries
		jsr	ObjectRevMove
		jsr	Call_Player_AnglePos.w
		bsr.w	sub_11E2A
		tst.b	BG_Layer_Scroll_Timer2+2.w
		beq.s	locret_17116
		jsr	sub_F846.w
		tst.w	d1
		bmi.w	KillPlayer2
		movem.l	a4-a6,-(sp)
		jsr	ChkWallDist_Left.w
		tst.w	d1
		bpl.s	loc_17106
		sub.w	d1,$10(a0)

loc_17106:
		jsr	CheckRightWallDist.w
		tst.w	d1
		bpl.s	loc_17112
		add.w	d1,$10(a0)

loc_17112:
		movem.l	(sp)+,a4-a6


; ---------------------------------------------------------------------------

locret_17116:
		rts

Knux_Spin_Freespace:
		bsr.w	Obj_Knux_JumpHeight
		bsr.w	sub_17680
		bsr.w	Player_Check_Screen_Boundaries
		jsr	ObjectGravity
		btst	#6,$2A(a0)
		beq.s	loc_17138
		subi.w	#$28,$1A(a0)


; ############### S U B	R O U T	I N E #######################################

loc_17138:
		bsr.w	sub_11E8C
		bsr.w	sub_11EEC
		rts

Knux_InputAcceleration_Path:
		move.w	(a4),d6
		move.w	2(a4),d5
		move.w	4(a4),d4
		tst.b	$2B(a0)
		bmi.w	loc_17364
		tst.w	$32(a0)
		bne.w	loc_1731C
		btst	#2,Ctrl_1_Held_Logical.w
		beq.s	loc_17168
		bsr.w	sub_17428

loc_17168:
		btst	#3,Ctrl_1_Held_Logical.w
		beq.s	loc_17174
		bsr.w	sub_174B4


; ---------------------------------------------------------------------------

loc_17174:
		move.b	$26(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.w	loc_1731C
		tst.w	$1C(a0)
		bne.w	loc_1731C
		bclr	#5,$2A(a0)
		move.b	#5,$20(a0)
		btst	#3,$2A(a0)
		beq.w	loc_1722C
		movea.w	$42(a0),a1
		tst.b	$2A(a1)
		bmi.w	loc_172A8
		moveq	#0,d1
		move.b	7(a1),d1
		move.w	d1,d2
		add.w	d2,d2
		subq.w	#2,d2
		add.w	$10(a0),d1
		sub.w	$10(a1),d1
		cmpi.w	#2,d1
		blt.s	loc_171FE
		cmp.w	d2,d1
		bge.s	loc_171D0
		bra.w	loc_172A8


; ---------------------------------------------------------------------------

loc_171D0:
		btst	#0,$2A(a0)
		bne.s	loc_171E2
		move.b	#6,$20(a0)
		bra.w	loc_1731C


; ---------------------------------------------------------------------------

loc_171E2:
		bclr	#0,$2A(a0)
		move.b	#0,$24(a0)
		move.b	#4,$23(a0)
		move.w	#$606,$20(a0)
		bra.w	loc_1731C


; ---------------------------------------------------------------------------

loc_171FE:
		btst	#0,$2A(a0)
		beq.s	loc_17210
		move.b	#6,$20(a0)
		bra.w	loc_1731C


; ---------------------------------------------------------------------------

loc_17210:
		bset	#0,$2A(a0)
		move.b	#0,$24(a0)
		move.b	#4,$23(a0)
		move.w	#$606,$20(a0)
		bra.w	loc_1731C


; ---------------------------------------------------------------------------

loc_1722C:
		move.w	$10(a0),d3
		jsr	Sonic_CheckFloorEdge.w
		cmpi.w	#$C,d1
		blt.w	loc_172A8
		cmpi.b	#3,$3A(a0)
		bne.s	loc_17272
		btst	#0,$2A(a0)
		bne.s	loc_17256
		move.b	#6,$20(a0)
		bra.w	loc_1731C


; ---------------------------------------------------------------------------

loc_17256:
		bclr	#0,$2A(a0)
		move.b	#0,$24(a0)
		move.b	#4,$23(a0)
		move.w	#$606,$20(a0)
		bra.w	loc_1731C


; ---------------------------------------------------------------------------

loc_17272:
		cmpi.b	#3,$3B(a0)
		bne.s	loc_172A8
		btst	#0,$2A(a0)
		beq.s	loc_1728C
		move.b	#6,$20(a0)
		bra.w	loc_1731C


; ---------------------------------------------------------------------------

loc_1728C:
		bset	#0,$2A(a0)
		move.b	#0,$24(a0)
		move.b	#4,$23(a0)
		move.w	#$606,$20(a0)
		bra.w	loc_1731C


; ---------------------------------------------------------------------------

loc_172A8:
		btst	#1,Ctrl_1_Held_Logical.w
		beq.s	loc_172E2
		move.b	#8,$20(a0)
		addq.b	#1,$39(a0)
		cmpi.b	#$78,$39(a0)
		blo.s	loc_17322
		move.b	#$78,$39(a0)
		tst.b	ReverseGravity_Flag.w
		bne.s	loc_172D8
		cmpi.w	#8,(a5)
		beq.s	loc_1732E
		subq.w	#2,(a5)
		bra.s	loc_1732E


; ---------------------------------------------------------------------------

loc_172D8:
		cmpi.w	#$D8,(a5)
		beq.s	loc_1732E
		addq.w	#2,(a5)
		bra.s	loc_1732E


; ---------------------------------------------------------------------------

loc_172E2:
		btst	#0,Ctrl_1_Held_Logical.w
		beq.s	loc_1731C
		move.b	#7,$20(a0)
		addq.b	#1,$39(a0)
		cmpi.b	#$78,$39(a0)
		blo.s	loc_17322
		move.b	#$78,$39(a0)
		tst.b	ReverseGravity_Flag.w
		bne.s	loc_17312
		cmpi.w	#$C8,(a5)
		beq.s	loc_1732E
		addq.w	#2,(a5)
		bra.s	loc_1732E


; ---------------------------------------------------------------------------

loc_17312:
		cmpi.w	#$18,(a5)
		beq.s	loc_1732E
		subq.w	#2,(a5)
		bra.s	loc_1732E

loc_1731C:
		move.b	#0,$39(a0)

loc_17322:
		cmpi.w	#$60,(a5)
		beq.s	loc_1732E
		bhs.s	loc_1732C
		addq.w	#4,(a5)

loc_1732C:
		subq.w	#2,(a5)

loc_1732E:
		tst.b	Super_Flag.w
		beq.s	loc_17338
		move.w	#$C,d5

loc_17338:
		move.b	Ctrl_1_Held_Logical.w,d0
		andi.b	#$C,d0
		bne.s	loc_17364
		move.w	$1C(a0),d0
		beq.s	loc_17364
		bmi.s	loc_17358
		sub.w	d5,d0
		bhs.s	loc_17352
		move.w	#0,d0


; ---------------------------------------------------------------------------

loc_17352:
		move.w	d0,$1C(a0)
		bra.s	loc_17364

loc_17358:
		add.w	d5,d0
		bhs.s	loc_17360
		move.w	#0,d0

loc_17360:
		move.w	d0,$1C(a0)

loc_17364:
		move.b	$26(a0),d0
		jsr	GetSine
		muls.w	$1C(a0),d1
		asr.l	#8,d1
		move.w	d1,$18(a0)
		muls.w	$1C(a0),d0
		asr.l	#8,d0
		move.w	d0,$1A(a0)

loc_17382:
		btst	#6,$2E(a0)
		bne.w	locret_17426
		move.b	$26(a0),d0
		andi.b	#$3F,d0
		beq.s	loc_173A2
		move.b	$26(a0),d0
		addi.b	#$40,d0
		bmi.w	locret_17426

loc_173A2:
		move.b	#$40,d1
		tst.w	$1C(a0)
		beq.s	locret_17426
		bmi.s	loc_173B0
		neg.w	d1

loc_173B0:
		move.b	$26(a0),d0
		add.b	d1,d0
		move.w	d0,-(sp)
		jsr	CalcRoomInFront.w
		move.w	(sp)+,d0
		tst.w	d1
		bpl.s	locret_17426
		asl.w	#8,d1

		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	loc_17422
		cmpi.b	#$40,d0
		beq.s	loc_17408
		cmpi.b	#$80,d0
		beq.s	loc_17402
		add.w	d1,$18(a0)
		move.w	#0,$1C(a0)
		btst	#0,$2A(a0)
		bne.s	locret_17400
		bset	#5,$2A(a0)


; ---------------------------------------------------------------------------

locret_17400:
		rts


; ---------------------------------------------------------------------------

loc_17402:
		sub.w	d1,$1A(a0)
		rts


; ---------------------------------------------------------------------------

loc_17408:
		sub.w	d1,$18(a0)
		move.w	#0,$1C(a0)
		btst	#0,$2A(a0)
		beq.s	locret_17400
		bset	#5,$2A(a0)
		rts

loc_17422:
		add.w	d1,$1A(a0)


; End of function Knux_InputAcceleration_Path
; ############### S U B	R O U T	I N E #######################################

locret_17426:
		rts

sub_17428:
		move.w	$1C(a0),d0
		beq.s	loc_17430
		bpl.s	loc_17462

loc_17430:
		bset	#0,$2A(a0)
		bne.s	loc_17444
		bclr	#5,$2A(a0)
		move.b	#1,$21(a0)

loc_17444:
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	loc_17456
		add.w	d5,d0
		cmp.w	d1,d0
		ble.s	loc_17456
		move.w	d1,d0


; ---------------------------------------------------------------------------

loc_17456:
		move.w	d0,$1C(a0)
		move.b	#0,$20(a0)
		rts

loc_17462:
		sub.w	d4,d0
		bhs.s	loc_1746A
		move.w	#-$80,d0

loc_1746A:
		move.w	d0,$1C(a0)
		move.b	$26(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_174B2
		cmpi.w	#$400,d0
		blt.s	locret_174B2
		tst.b	$2D(a0)
		bmi.s	locret_174B2
		move.w	#$36,d0
		jsr	PlaySFX
		move.b	#$D,$20(a0)
		bclr	#0,$2A(a0)
		cmpi.b	#$C,$2C(a0)
		blo.s	locret_174B2
		move.b	#6,5(a6)
		move.b	#$15,$22(a6)


; End of function sub_17428
; ############### S U B	R O U T	I N E #######################################

locret_174B2:
		rts

sub_174B4:
		move.w	$1C(a0),d0
		bmi.s	loc_174E8
		bclr	#0,$2A(a0)
		beq.s	loc_174CE
		bclr	#5,$2A(a0)
		move.b	#1,$21(a0)

loc_174CE:
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	loc_174DC
		sub.w	d5,d0
		cmp.w	d6,d0
		bge.s	loc_174DC
		move.w	d6,d0


; ---------------------------------------------------------------------------

loc_174DC:
		move.w	d0,$1C(a0)
		move.b	#0,$20(a0)
		rts

loc_174E8:
		add.w	d4,d0
		bhs.s	loc_174F0
		move.w	#$80,d0

loc_174F0:
		move.w	d0,$1C(a0)
		move.b	$26(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_17538
		cmpi.w	#$FC00,d0
		bgt.s	locret_17538
		tst.b	$2D(a0)
		bmi.s	locret_17538
		move.w	#$36,d0
		jsr	PlaySFX
		move.b	#$D,$20(a0)
		bset	#0,$2A(a0)
		cmpi.b	#$C,$2C(a0)
		blo.s	locret_17538
		move.b	#6,5(a6)
		move.b	#$15,$22(a6)


; End of function sub_174B4
; ############### S U B	R O U T	I N E #######################################

locret_17538:
		rts

sub_1753A:
		move.w	(a4),d6
		asl.w	#1,d6
		move.w	2(a4),d5
		asr.w	#1,d5
		tst.b	Super_Flag.w
		beq.s	loc_1754E
		move.w	#6,d5

loc_1754E:
		move.w	#$20,d4
		tst.b	$3D(a0)
		bmi.w	loc_175F8
		tst.b	$2B(a0)
		bmi.w	loc_175F8
		tst.w	$32(a0)
		bne.s	loc_17580
		btst	#2,Ctrl_1_Held_Logical.w
		beq.s	loc_17574
		bsr.w	sub_1763A

loc_17574:
		btst	#3,Ctrl_1_Held_Logical.w
		beq.s	loc_17580
		bsr.w	sub_1765E

loc_17580:
		move.w	$1C(a0),d0
		beq.s	loc_175A2
		bmi.s	loc_17596
		sub.w	d5,d0
		bhs.s	loc_17590
		move.w	#0,d0


; ---------------------------------------------------------------------------

loc_17590:
		move.w	d0,$1C(a0)
		bra.s	loc_175A2

loc_17596:
		add.w	d5,d0
		bhs.s	loc_1759E
		move.w	#0,d0

loc_1759E:
		move.w	d0,$1C(a0)

loc_175A2:
		move.w	$1C(a0),d0
		bpl.s	loc_175AA
		neg.w	d0

loc_175AA:
		cmpi.w	#$80,d0
		bhs.s	loc_175F8
		tst.b	$3D(a0)
		bne.s	loc_175E6
		bclr	#2,$2A(a0)
		move.b	$1E(a0),d0
		move.b	$44(a0),$1E(a0)
		move.b	$45(a0),$1F(a0)
		move.b	#5,$20(a0)
		sub.b	$44(a0),d0
		ext.w	d0
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_175E0
		neg.w	d0


; ---------------------------------------------------------------------------

loc_175E0:
		add.w	d0,$14(a0)
		bra.s	loc_175F8

loc_175E6:
		move.w	#$400,$1C(a0)
		btst	#0,$2A(a0)
		beq.s	loc_175F8
		neg.w	$1C(a0)

loc_175F8:
		cmpi.w	#$60,(a5)
		beq.s	loc_17604
		bhs.s	loc_17602
		addq.w	#4,(a5)

loc_17602:
		subq.w	#2,(a5)

loc_17604:
		move.b	$26(a0),d0
		jsr	GetSine
		muls.w	$1C(a0),d0
		asr.l	#8,d0
		move.w	d0,$1A(a0)
		muls.w	$1C(a0),d1
		asr.l	#8,d1
		cmpi.w	#$1000,d1
		ble.s	loc_17628
		move.w	#$1000,d1

loc_17628:
		cmpi.w	#-$1000,d1
		bge.s	loc_17632
		move.w	#-$1000,d1


; End of function sub_1753A
; ############### S U B	R O U T	I N E #######################################

loc_17632:
		move.w	d1,$18(a0)
		bra.w	loc_17382

sub_1763A:
		move.w	$1C(a0),d0
		beq.s	loc_17642
		bpl.s	loc_17650


; ---------------------------------------------------------------------------

loc_17642:
		bset	#0,$2A(a0)
		move.b	#2,$20(a0)
		rts

loc_17650:
		sub.w	d4,d0
		bhs.s	loc_17658
		move.w	#-$80,d0


; End of function sub_1763A
; ############### S U B	R O U T	I N E #######################################

loc_17658:
		move.w	d0,$1C(a0)
		rts


; ---------------------------------------------------------------------------

sub_1765E:
		move.w	$1C(a0),d0
		bmi.s	loc_17672
		bclr	#0,$2A(a0)
		move.b	#2,$20(a0)
		rts

loc_17672:
		add.w	d4,d0
		bhs.s	loc_1767A
		move.w	#$80,d0


; End of function sub_1765E
; ############### S U B	R O U T	I N E #######################################

loc_1767A:
		move.w	d0,$1C(a0)
		rts

sub_17680:
		move.w	(a4),d6
		move.w	2(a4),d5
		asl.w	#1,d5
		btst	#4,$2A(a0)
		bne.s	loc_176D4
		move.w	$18(a0),d0
		btst	#2,Ctrl_1_Held_Logical.w
		beq.s	loc_176B4
		bset	#0,$2A(a0)
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	loc_176B4
		add.w	d5,d0
		cmp.w	d1,d0
		ble.s	loc_176B4
		move.w	d1,d0

loc_176B4:
		btst	#3,Ctrl_1_Held_Logical.w
		beq.s	loc_176D0
		bclr	#0,$2A(a0)
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	loc_176D0
		sub.w	d5,d0
		cmp.w	d6,d0
		bge.s	loc_176D0
		move.w	d6,d0

loc_176D0:
		move.w	d0,$18(a0)

loc_176D4:
		cmpi.w	#$60,(a5)
		beq.s	loc_176E0
		bhs.s	loc_176DE
		addq.w	#4,(a5)

loc_176DE:
		subq.w	#2,(a5)

loc_176E0:
		cmpi.w	#-$400,$1A(a0)
		blo.s	locret_1770E
		move.w	$18(a0),d0
		move.w	d0,d1
		asr.w	#5,d1
		beq.s	locret_1770E
		bmi.s	loc_17702
		sub.w	d1,d0
		bhs.s	loc_176FC
		move.w	#0,d0


; ---------------------------------------------------------------------------

loc_176FC:
		move.w	d0,$18(a0)
		rts

loc_17702:
		sub.w	d1,d0
		blo.s	loc_1770A
		move.w	#0,d0

loc_1770A:
		move.w	d0,$18(a0)


; End of function sub_17680
; ############### S U B	R O U T	I N E #######################################

locret_1770E:
		rts

Obj_Knux_Jump:
		move.b	Ctrl_1_Press_Logical.w,d0
		andi.b	#$70,d0
		beq.w	locret_177E0
		moveq	#0,d0
		move.b	$26(a0),d0
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_17732
		addi.b	#$40,d0
		neg.b	d0
		subi.b	#$40,d0

loc_17732:
		addi.b	#-$80,d0
		movem.l	a4-a6,-(sp)
		jsr	CalcRoomOverHead
		movem.l	(sp)+,a4-a6
		cmpi.w	#6,d1
		blt.w	locret_177E0
		move.w	#$600,d2
		btst	#6,$2A(a0)
		beq.s	loc_1775C
		move.w	#$300,d2

loc_1775C:
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
		bne.s	loc_177E2
		move.b	#$E,$1E(a0)
		move.b	#7,$1F(a0)
		move.b	#2,$20(a0)
		bset	#2,$2A(a0)
		move.b	$1E(a0),d0
		sub.b	$44(a0),d0
		ext.w	d0
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_177DC
		neg.w	d0

loc_177DC:
		sub.w	d0,$14(a0)


; ---------------------------------------------------------------------------

locret_177E0:
		rts


; End of function Obj_Knux_Jump
; ############### S U B	R O U T	I N E #######################################

loc_177E2:
		bset	#4,$2A(a0)
		rts

Obj_Knux_JumpHeight:
		tst.b	$40(a0)
		beq.s	loc_17818
		move.w	#-$400,d1
		btst	#6,$2A(a0)
		beq.s	loc_17800
		move.w	#-$200,d1

loc_17800:
		cmp.w	$1A(a0),d1
		ble.w	Knux_Test_For_Glide
		move.b	Ctrl_1_Held_Logical.w,d0
		andi.b	#$70,d0
		bne.s	locret_17816
		move.w	d1,$1A(a0)


; ---------------------------------------------------------------------------

locret_17816:
		rts

loc_17818:
		tst.b	$3D(a0)
		bne.s	locret_1782C
		cmpi.w	#-$FC0,$1A(a0)
		bge.s	locret_1782C
		move.w	#-$FC0,$1A(a0)


; ---------------------------------------------------------------------------

locret_1782C:
		rts

Knux_Test_For_Glide:
		tst.b	$2F(a0)
		bne.w	locret_178CC
		move.b	Ctrl_1_Press_Logical.w,d0
		andi.b	#$70,d0
		beq.w	locret_178CC
		bclr	#2,$2A(a0)
		move.b	#$A,$1E(a0)
		move.b	#$A,$1F(a0)
		bclr	#4,$2A(a0)
		move.b	#1,$2F(a0)
		addi.w	#$200,$1A(a0)
		bpl.s	loc_17898
		move.w	#0,$1A(a0)

loc_17898:
		moveq	#0,d1
		move.w	#$400,d0
		move.w	d0,$1C(a0)
		btst	#0,$2A(a0)
		beq.s	loc_178AE
		neg.w	d0
		moveq	#-$80,d1

loc_178AE:
		move.w	d0,$18(a0)
		move.b	d1,$25(a0)
		move.w	#0,$26(a0)
		move.b	#0,Knuckles_GlideStateFlag.w
		bset	#1,Knuckles_GlideStateFlag.w
		bsr.w	sub_16FA8

locret_178CC:
		rts

loc_17912:
		move.w	#$800,(a4)
		move.w	#$18,2(a4)
		move.w	#$C0,4(a4)
		move.b	#0,$35(a0)
		bset	#1,$2B(a0)
		moveq	#-$61,d0
		jsr	PlaySFX
		moveq	#$2C,d0
		jmp	PlayMusic

sub_1793E:
		move.l	Primary_Collision.w,Current_Collision.w
		cmpi.b	#$C,$46(a0)
		beq.s	loc_17952
		move.l	Secondary_Collision.w,Current_Collision.w

loc_17952:
		move.b	$47(a0),d5
		move.w	$18(a0),d1
		move.w	$1A(a0),d2
		jsr	GetArcTan
		subi.b	#$20,d0
		andi.b	#$C0,d0
		cmpi.b	#$40,d0
		beq.w	loc_179DA
		cmpi.b	#$80,d0
		beq.w	loc_17A62
		cmpi.b	#$C0,d0
		beq.w	loc_17AB0
		jsr	ChkWallDist_Left.w
		tst.w	d1
		bpl.s	loc_1799C
		sub.w	d1,$10(a0)
		move.w	#0,$18(a0)
		bset	#5,Knuckles_GlideStateFlag.w

loc_1799C:
		jsr	CheckRightWallDist.w
		tst.w	d1
		bpl.s	loc_179B4
		add.w	d1,$10(a0)
		move.w	#0,$18(a0)
		bset	#5,Knuckles_GlideStateFlag.w

loc_179B4:
		jsr	sub_11FD6.w
		tst.w	d1
		bpl.s	locret_179D8
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_179C4
		neg.w	d1

loc_179C4:
		add.w	d1,$14(a0)
		move.b	d3,$26(a0)
		move.w	#0,$1A(a0)
		bclr	#1,Knuckles_GlideStateFlag.w


; ---------------------------------------------------------------------------

locret_179D8:
		rts

loc_179DA:
		jsr	ChkWallDist_Left.w
		tst.w	d1
		bpl.s	loc_179F2
		sub.w	d1,$10(a0)
		move.w	#0,$18(a0)
		bset	#5,Knuckles_GlideStateFlag.w

loc_179F2:
		jsr	sub_11FEE.w
		tst.w	d1
		bpl.s	loc_17A36
		neg.w	d1
		cmpi.w	#$14,d1
		bhs.s	loc_17A1C
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_17A0A
		neg.w	d1

loc_17A0A:
		add.w	d1,$14(a0)
		tst.w	$1A(a0)
		bpl.s	locret_17A1A
		move.w	#0,$1A(a0)


; ---------------------------------------------------------------------------

locret_17A1A:
		rts

loc_17A1C:
		jsr	CheckRightWallDist.w
		tst.w	d1
		bpl.s	locret_17A34
		add.w	d1,$10(a0)
		move.w	#0,$18(a0)
		bset	#5,Knuckles_GlideStateFlag.w


; ---------------------------------------------------------------------------

locret_17A34:
		rts

loc_17A36:
		tst.w	$1A(a0)
		bmi.s	locret_17A60
		jsr	sub_11FD6.w
		tst.w	d1
		bpl.s	locret_17A60
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_17A4C
		neg.w	d1

loc_17A4C:
		add.w	d1,$14(a0)
		move.b	d3,$26(a0)
		move.w	#0,$1A(a0)
		bclr	#1,Knuckles_GlideStateFlag.w


; ---------------------------------------------------------------------------

locret_17A60:
		rts

loc_17A62:
		jsr	ChkWallDist_Left.w
		tst.w	d1
		bpl.s	loc_17A7A
		sub.w	d1,$10(a0)
		move.w	#0,$18(a0)
		bset	#5,Knuckles_GlideStateFlag.w

loc_17A7A:
		jsr	CheckRightWallDist
		tst.w	d1
		bpl.s	loc_17A94
		add.w	d1,$10(a0)
		move.w	#0,$18(a0)
		bset	#5,Knuckles_GlideStateFlag.w

loc_17A94:
		jsr	sub_11FEE.w
		tst.w	d1
		bpl.s	locret_17AAE
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_17AA4
		neg.w	d1

loc_17AA4:
		sub.w	d1,$14(a0)
		move.w	#0,$1A(a0)


; ---------------------------------------------------------------------------

locret_17AAE:
		rts

loc_17AB0:
		jsr	CheckRightWallDist
		tst.w	d1
		bpl.s	loc_17ACA
		add.w	d1,$10(a0)
		move.w	#0,$18(a0)
		bset	#5,Knuckles_GlideStateFlag.w

loc_17ACA:
		jsr	sub_11FEE.w
		tst.w	d1
		bpl.s	loc_17AEC
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_17ADA
		neg.w	d1

loc_17ADA:
		sub.w	d1,$14(a0)
		tst.w	$1A(a0)
		bpl.s	locret_17AEA
		move.w	#0,$1A(a0)


; ---------------------------------------------------------------------------

locret_17AEA:
		rts

loc_17AEC:
		tst.w	$1A(a0)
		bmi.s	Knux_ResetOnFloor_Spdash
		jsr	sub_11FD6.w
		tst.w	d1
		bpl.s	Knux_ResetOnFloor_Spdash
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_17B02
		neg.w	d1

loc_17B02:
		add.w	d1,$14(a0)
		move.b	d3,$26(a0)
		move.w	#0,$1A(a0)
		bclr	#1,Knuckles_GlideStateFlag.w
; ---------------------------------------------------------------------------

Knux_ResetOnFloor_Spdash:
		rts
; ---------------------------------------------------------------------------
; deprecated
		tst.b	spindash(a0)
		bne.s	Knux_ResetOnFloor_Com		; branch if spindashing
		move.b	#0,anim(a0)			; set to walking animation

Knux_ResetOnFloor:
		move.b	yrad(a0),d0			; get y-radius
		move.b	yraddef(a0),yrad(a0)		; set to default y-radius
		move.b	xraddef(a0),xrad(a0)		; set to default x-radius
		btst	#2,status(a0)
		beq.s	Knux_ResetOnFloor_Com		; branch if not jumping/rolling

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

Knux_ResetOnFloor_Com:
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
		move.b	#0,jumpmove(a0)			; clear jumpmove flag

		cmpi.b	#$20,anim(a0)
		blo.s	.rts				; branch if anim ID is less than $20
		move.b	#0,anim(a0)			; set to walking animation
.rts		rts
; ---------------------------------------------------------------------------

loc_17BB6:
		tst.w	Debug_Mode_Flag.w
		beq.s	loc_17BD0
		btst	#4,Ctrl_1_Press.w
		beq.s	loc_17BD0
		move.w	#1,Debug_Routine.w
		clr.b	Control_Locked.w
		rts

loc_17BD0:
		jsr	ObjectRevMove
		addi.w	#$30,$1A(a0)
		btst	#6,$2A(a0)
		beq.s	loc_17BEA
		subi.w	#$20,$1A(a0)

loc_17BEA:
		cmpi.w	#-$100,Camera_min_Y.w
		bne.s	loc_17BFA
		move.w	Screen_Y_wrap_value.w,d0
		and.w	d0,$14(a0)


; ############### S U B	R O U T	I N E #######################################

loc_17BFA:
		bsr.w	sub_17C10
		bsr.w	Player_Check_Screen_Boundaries
		bsr.w	sub_10D66
		bsr.w	sub_17D1E
		jmp	DrawSprite


; ---------------------------------------------------------------------------

sub_17C10:
		tst.b	BG_Layer_Scroll_Timer2+3.w
		bne.s	loc_17C3C
		tst.b	ReverseGravity_Flag.w
		bne.s	loc_17C2E
		move.w	Camera_max_Y.w,d0
		addi.w	#$E0,d0
		cmp.w	$14(a0),d0
		blt.w	loc_17C82
		bra.s	loc_17C3C


; ---------------------------------------------------------------------------

loc_17C2E:
		move.w	Camera_min_Y.w,d0
		cmp.w	$14(a0),d0
		blt.s	loc_17C3C
		bra.w	loc_17C82

loc_17C3C:
		movem.l	a4-a6,-(sp)
		bsr.w	sub_11EEC
		movem.l	(sp)+,a4-a6
		btst	#1,$2A(a0)
		bne.s	locret_17C80
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

locret_17C80:
		rts


; End of function sub_17C10
; ---------------------------------------------------------------------------

loc_17C82:
		jmp	KillPlayer2


; ---------------------------------------------------------------------------

loc_17C88:
		tst.w	Debug_Mode_Flag.w
		beq.s	loc_17CA2
		btst	#4,Ctrl_1_Press.w
		beq.s	loc_17CA2
		move.w	#1,Debug_Routine.w
		clr.b	Control_Locked.w
		rts


; ---------------------------------------------------------------------------

loc_17CA2:
		bsr.w	sub_123C2
		jsr	ObjectGravity
		bsr.w	sub_10D66
		bsr.w	sub_17D1E
		jmp	DrawSprite

loc_17CBA:
		tst.w	$3E(a0)
		beq.s	locret_17CCC
		subq.w	#1,$3E(a0)
		bne.s	locret_17CCC
		st	Level_Restart_Flag.w


; ---------------------------------------------------------------------------

locret_17CCC:
		rts

loc_17CCE:
		tst.w	Camera_X_Pos_Diff.w
		bne.s	loc_17CE0
		tst.w	Camera_Y_Pos_Diff.w
		bne.s	loc_17CE0
		move.b	#2,5(a0)


; ---------------------------------------------------------------------------

loc_17CE0:
		bsr.w	sub_17D1E
		jmp	DrawSprite


; ---------------------------------------------------------------------------

loc_17CEA:
		tst.w	Debug_Mode_Flag.w
		beq.s	loc_17D04
		btst	#4,Ctrl_1_Press.w
		beq.s	loc_17D04
		move.w	#1,Debug_Routine.w
		clr.b	Control_Locked.w
		rts


; ############### S U B	R O U T	I N E #######################################

loc_17D04:
		jsr	ObjectRevMove
		addi.w	#$10,$1A(a0)
		bsr.w	sub_10D66
		bsr.w	sub_17D1E
		jmp	DrawSprite

sub_17D1E:
		bsr.s	Animate_Knuckles
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_17D2C
		eori.b	#2,4(a0)


; End of function sub_17D1E
; ############### S U B	R O U T	I N E #######################################

loc_17D2C:
		bra.w	Knuckles_Load_PLC

Animate_Knuckles:
		lea	AniKnuckles,a1
		moveq	#0,d0
		move.b	$20(a0),d0
		cmp.b	$21(a0),d0
		beq.s	loc_17D58
		move.b	d0,$21(a0)
		move.b	#0,$23(a0)
		move.b	#0,$24(a0)
		bclr	#5,$2A(a0)

loc_17D58:
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),d0
		bmi.s	loc_17DC8
		move.b	$2A(a0),d1
		andi.b	#1,d1
		andi.b	#-4,4(a0)
		or.b	d1,4(a0)
		subq.b	#1,$24(a0)
		bpl.s	locret_17D96
		move.b	d0,$24(a0)

loc_17D7E:
		moveq	#0,d1
		move.b	$23(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-4,d0
		bhs.s	loc_17D98

loc_17D8E:
		move.b	d0,$22(a0)
		addq.b	#1,$23(a0)


; ---------------------------------------------------------------------------

locret_17D96:
		rts


; ---------------------------------------------------------------------------

loc_17D98:
		addq.b	#1,d0
		bne.s	loc_17DA8
		move.b	#0,$23(a0)
		move.b	1(a1),d0
		bra.s	loc_17D8E


; ---------------------------------------------------------------------------

loc_17DA8:
		addq.b	#1,d0
		bne.s	loc_17DBC
		move.b	2(a1,d1.w),d0
		sub.b	d0,$23(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	loc_17D8E

loc_17DBC:
		addq.b	#1,d0
		bne.s	locret_17DC6
		move.b	2(a1,d1.w),$20(a0)


; ---------------------------------------------------------------------------

locret_17DC6:
		rts

loc_17DC8:
		addq.b	#1,d0
		bne.w	loc_17E84
		moveq	#0,d0
		tst.b	$2D(a0)
		bmi.w	loc_127C0
		move.b	$27(a0),d0
		bne.w	loc_127C0
		moveq	#0,d1
		move.b	$26(a0),d0
		bmi.s	loc_17DEC
		beq.s	loc_17DEC
		subq.b	#1,d0

loc_17DEC:
		move.b	$2A(a0),d2
		andi.b	#1,d2
		bne.s	loc_17DF8
		not.b	d0

loc_17DF8:
		addi.b	#$10,d0
		bpl.s	loc_17E00
		moveq	#3,d1

loc_17E00:
		andi.b	#-4,4(a0)
		eor.b	d1,d2
		or.b	d2,4(a0)
		btst	#5,$2A(a0)
		bne.w	loc_17ECC
		lsr.b	#4,d0
		andi.b	#6,d0
		move.w	$1C(a0),d2
		bpl.s	loc_17E24
		neg.w	d2

loc_17E24:
		tst.b	$2B(a0)
		bpl.w	loc_17E2E
		add.w	d2,d2

loc_17E2E:
		lea	byte_17F48,a1
		cmpi.w	#$600,d2
		bhs.s	loc_17E42
		lea	byte_17F3E,a1
		add.b	d0,d0

loc_17E42:
		add.b	d0,d0
		move.b	d0,d3
		moveq	#0,d1
		move.b	$23(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	loc_17E60
		move.b	#0,$23(a0)
		move.b	1(a1),d0

loc_17E60:
		move.b	d0,$22(a0)
		add.b	d3,$22(a0)
		subq.b	#1,$24(a0)
		bpl.s	locret_17E82
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	loc_17E78
		moveq	#0,d2

loc_17E78:
		lsr.w	#8,d2
		move.b	d2,$24(a0)
		addq.b	#1,$23(a0)


; ---------------------------------------------------------------------------

locret_17E82:
		rts

loc_17E84:
		move.b	$2A(a0),d1
		andi.b	#1,d1
		andi.b	#-4,4(a0)
		or.b	d1,4(a0)
		subq.b	#1,$24(a0)
		bpl.w	locret_17D96
		move.w	$1C(a0),d2
		bpl.s	loc_17EA6
		neg.w	d2

loc_17EA6:
		lea	byte_17F5C,a1
		cmpi.w	#$600,d2
		bhs.s	loc_17EB8
		lea	byte_17F52,a1

loc_17EB8:
		neg.w	d2
		addi.w	#$400,d2
		bpl.s	loc_17EC2
		moveq	#0,d2


; ---------------------------------------------------------------------------

loc_17EC2:
		lsr.w	#8,d2
		move.b	d2,$24(a0)
		bra.w	loc_17D7E

loc_17ECC:
		subq.b	#1,$24(a0)
		bpl.w	locret_17D96
		move.w	$1C(a0),d2
		bmi.s	loc_17EDC
		neg.w	d2

loc_17EDC:
		addi.w	#$800,d2
		bpl.s	loc_17EE4
		moveq	#0,d2


; End of function Animate_Knuckles
; ---------------------------------------------------------------------------

loc_17EE4:
		lsr.w	#8,d2
		move.b	d2,$24(a0)
		lea	byte_17F66,a1
		bra.w	loc_17D7E

; ---------------------------------------------------------------------------
AniKnuckles:	include "levels/Players/Knuckles/Ani.asm"
; ---------------------------------------------------------------------------

Knuckles_Load_PLC:
		moveq	#0,d0
		move.b	$22(a0),d0

Knuckles_Load_PLC2:
		cmp.b	Player1_Current_Frame.w,d0
		beq.s	locret_18162
		move.b	d0,Player1_Current_Frame.w
		move.w	#$D000,d4

loc_18122:
		lea	DPLC_Knuckles,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_18162
		move.l	#Art_Knuckles,d6

loc_1813A:
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
		dbf	d5,loc_1813A


; End of function Knuckles_Load_PLC
; ---------------------------------------------------------------------------

locret_18162:
		rts


; ---------------------------------------------------------------------------
