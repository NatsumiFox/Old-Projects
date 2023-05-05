Obj_Tails:
		lea	Player2_TopSpeed.w,a4
		lea	Distance_from_screen_top.w,a5
		lea	Obj_dust_2.w,a6

		cmpa.w	#Object_RAM&$FFFF,a0
		beq.s	.noclr
		moveq	#0,d0
		move.l	d0,a5		; do not allow p2 to move camera

.noclr		cmpi.w	#2,Player_Mode.w
		bne.s	loc_136AE
		tst.w	Debug_Routine.w
		beq.s	loc_136AE
		cmpi.b	#1,Debug_Placement_Flag.w
		beq.s	loc_136A8
		btst	#4,Ctrl_1_Press.w
		beq.s	loc_1368C
		move.w	#0,Debug_Routine.w

loc_1368C:
		addq.b	#1,$22(a0)
		cmpi.b	#-5,$22(a0)
		blo.s	loc_1369E
		move.b	#0,$22(a0)


; ---------------------------------------------------------------------------

loc_1369E:
		bsr.w	Tails_Load_PLC
		jmp	DrawSprite


; ---------------------------------------------------------------------------

loc_136A8:
		jmp	DebugMode


; ---------------------------------------------------------------------------

loc_136AE:
		moveq	#0,d0
		move.b	5(a0),d0
		move.w	off_136BC(pc,d0.w),d1
		jmp	off_136BC(pc,d1.w)


; ---------------------------------------------------------------------------

off_136BC:
		dc.w loc_136CA-off_136BC
		dc.w loc_137C4-off_136BC
		dc.w loc_1569C-off_136BC
		dc.w loc_1578E-off_136BC
		dc.w loc_157E0-off_136BC
		dc.w loc_157F4-off_136BC
		dc.w loc_15810-off_136BC


; ---------------------------------------------------------------------------

loc_136CA:
		addq.b	#2,5(a0)
		move.b	#$F,$1E(a0)
		move.b	#9,$1F(a0)
		move.b	#$F,$44(a0)
		move.b	#9,$45(a0)
		move.l	#Map_Tails,$C(a0)
		move.w	#$100,8(a0)
		move.b	#$18,7(a0)
		move.b	#$18,6(a0)
		move.b	#$84,4(a0)
		move.b	#1,$38(a0)
		move.w	#$600,(a4)
		move.w	#$C,2(a4)
		move.w	#$80,4(a4)
		cmpi.w	#2,Player_Mode.w
		bne.s	loc_1375E

		move.b	#$C,$46(a0)
		move.b	#$D,$47(a0)

loc_1375E:
		move.w	#$6A0,$A(a0)
		move.w	Object_RAM+topsolid.w,$46(a0)
		tst.w	Object_RAM+tile.w
		bpl.s	loc_13776
		ori.w	#$8000,$A(a0)

loc_13776:
		move.b	#0,$30(a0)
		move.b	#4,$31(a0)
		move.b	#0,Super_Tails_Flag.w
		move.b	#$1E,$2C(a0)
		move.w	#0,Player2_CPU_Control_Counter.w
		move.w	#0,Player2_CPU_Respawn.w
		move.l	#Obj_Tails_Tail,Obj_tails_tails.w
		move.w	a0,Obj_tails_tails+$30.w
		rts

loc_137C4:
		cmpi.w	#2,Player_Mode.w
		bne.s	loc_13808
		tst.w	Debug_Mode_Flag.w
		beq.s	loc_13808
		bclr	#6,Ctrl_1_Press.w
		beq.s	loc_137E0
		eori.b	#1,ReverseGravity_Flag.w

loc_137E0:
		btst	#4,Ctrl_1_Press.w
		beq.s	loc_13808
		move.w	#1,Debug_Routine.w
		clr.b	Control_Locked.w
		btst	#5,Ctrl_1_Held.w
		beq.s	locret_13806
		move.w	#2,Debug_Routine.w
		move.b	#0,$20(a0)


; ---------------------------------------------------------------------------

locret_13806:
		rts


; ---------------------------------------------------------------------------

loc_13808:
		cmpa.w	#Object_RAM,a0
		bne.s	loc_13830
		move.w	Ctrl_1_Held_Logical.w,Ctrl_2_Held_Logical.w
		tst.b	Control_Locked.w
		bne.s	loc_1384A
		move.w	Ctrl_1_Held.w,Ctrl_2_Held_Logical.w
		move.w	Ctrl_1_Held.w,Ctrl_1_Held_Logical.w
		cmpi.w	#$1A,Player2_CPU_Routine.w
		bhs.s	loc_13840
		bra.s	loc_1384A


; ---------------------------------------------------------------------------

loc_13830:
		tst.b	Control_Locked_P2.w
		beq.s	loc_1383A
		bpl.s	loc_13840
		bra.s	loc_1384A

loc_1383A:
		move.w	Ctrl_2_Held.w,Ctrl_2_Held_Logical.w

loc_13840:
		bsr.w	sub_139CC

loc_1384A:
		btst	#0,$2E(a0)
		beq.s	loc_13872
		move.b	#0,$2F(a0)
		tst.b	Player2_Carrying.w
		beq.s	loc_1388C
		lea	Object_RAM.w,a1
		clr.b	$2E(a1)
		bset	#1,$2A(a1)
		clr.w	Player2_Carrying.w
		bra.s	loc_1388C

loc_13872:
		movem.l	a4-a6,-(sp)
		moveq	#0,d0
		move.b	$2A(a0),d0
		andi.w	#6,d0
		move.w	off_138F6(pc,d0.w),d1
		jsr	off_138F6(pc,d1.w)
		movem.l	(sp)+,a4-a6

loc_1388C:
		cmpi.w	#-$100,Camera_min_Y.w
		bne.s	loc_1389C
		move.w	Screen_Y_wrap_value.w,d0
		and.w	d0,$14(a0)

loc_1389C:
		bsr.s	loc_138FE
		bsr.w	loc_11B26
		bsr.w	sub_10D66
		bsr.w	sub_14632
		move.b	Player_NextTilt.w,$3A(a0)
		move.b	Player_CurrentTilt.w,$3B(a0)
		tst.b	Player2_OnWater_Flag.w
		beq.s	loc_138C8
		tst.b	$20(a0)
		bne.s	loc_138C8
		move.b	$21(a0),$20(a0)

loc_138C8:
		btst	#1,$2E(a0)
		bne.s	loc_138E4
		bsr.w	Animate_Tails
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_138E0
		eori.b	#2,4(a0)

loc_138E0:
		bsr.w	Tails_Load_PLC

loc_138E4:
		move.b	$2E(a0),d0
		andi.b	#$A0,d0
		bne.s	locret_138F4
		jsr	TouchResponse_Normal


; ---------------------------------------------------------------------------

locret_138F4:
		rts


; ---------------------------------------------------------------------------

off_138F6:
		dc.w Tails_Stand_Path-off_138F6
		dc.w Tails_Stand_Freespace-off_138F6
		dc.w Tails_Spin_Path-off_138F6
		dc.w Tails_Spin_Freespace-off_138F6

loc_138FE:
		move.b	$34(a0),d0
		beq.s	loc_1390C
		subq.b	#1,$34(a0)
		lsr.b	#3,d0
		bhs.s	loc_13912

loc_1390C:
		jsr	DrawSprite

loc_13912:
		btst	#1,$2B(a0)
		beq.s	loc_1394E
		tst.b	$35(a0)
		beq.s	loc_1394E
		move.b	Level_Frame_Timer+1.w,d0
		andi.b	#7,d0
		bne.s	loc_1394E
		subq.b	#1,$35(a0)
		bne.s	loc_1394E
		tst.b	Boss_Active_Flag.w
		bne.s	loc_13948
		cmpi.b	#$C,$2C(a0)
		blo.s	loc_13948
		move.b	Current_Mus.w,d0
		jsr	PlayMusic

loc_13948:
		bclr	#1,$2B(a0)

loc_1394E:
		btst	#2,$2B(a0)
		beq.s	locret_139A6
		tst.b	$36(a0)
		beq.s	locret_139A6
		move.b	Level_Frame_Timer+1.w,d0
		andi.b	#7,d0
		bne.s	locret_139A6
		subq.b	#1,$36(a0)
		bne.s	locret_139A6
		move.w	#$600,(a4)
		move.w	#$C,2(a4)
		move.w	#$80,4(a4)
		tst.b	Super_Tails_Flag.w
		beq.s	loc_13998
		move.w	#$800,(a4)
		move.w	#$18,2(a4)
		move.w	#$C0,4(a4)


; ---------------------------------------------------------------------------

loc_13998:
		bclr	#2,$2B(a0)
		moveq	#0,d0
		jmp	PlayTempo


; ---------------------------------------------------------------------------

locret_139A6:
		rts


; ############### S U B	R O U T	I N E #######################################

loc_139A8:
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

sub_139CC:
		move.b	Ctrl_2_Held_Logical.w,d0
		andi.b	#$7F,d0
		beq.s	loc_139DC
		move.w	#$258,Player2_CPU_Control_Counter.w


; End of function sub_139CC
; ---------------------------------------------------------------------------

loc_139DC:
		lea	Object_RAM.w,a1
		move.w	Player2_CPU_Routine.w,d0
		move.w	off_139EC(pc,d0.w),d0
		jmp	off_139EC(pc,d0.w)
; ---------------------------------------------------------------------------

off_139EC:
		dc.w loc_13A10-off_139EC
		dc.w Tails_Catch_Up_Flying-off_139EC
		dc.w Tails_FlySwim_Unknown-off_139EC
		dc.w loc_13D4A-off_139EC
		dc.w loc_13F40-off_139EC
		dc.w locret_13FC0-off_139EC
		dc.w loc_13FC2-off_139EC
		dc.w loc_13FFA-off_139EC
		dc.w loc_1408A-off_139EC
		dc.w loc_140C6-off_139EC
		dc.w loc_140CE-off_139EC
		dc.w loc_14106-off_139EC
		dc.w loc_1414C-off_139EC
		dc.w loc_141F2-off_139EC
		dc.w loc_1421C-off_139EC
		dc.w loc_14254-off_139EC
		dc.w loc_1425C-off_139EC
		dc.w loc_14286-off_139EC


; ---------------------------------------------------------------------------

loc_13A10:
		move.w	#2,Player2_CPU_Routine.w
		move.w	#1,Player2_CPU_Respawn.w
		rts

Tails_Catch_Up_Flying:
		move.b	Ctrl_2_Held_Logical.w,d0
		andi.b	#$F0,d0
		bne.s	loc_13B50
		move.w	Level_Frame_Timer.w,d0
		andi.w	#$3F,d0
		bne.w	locret_13BF6
		tst.b	$2E(a1)
		bmi.w	locret_13BF6
		move.b	$2A(a1),d0
		andi.b	#$80,d0
		bne.w	locret_13BF6

loc_13B50:
		move.w	#4,Player2_CPU_Routine.w
		move.w	$10(a1),d0
		move.w	d0,$10(a0)
		move.w	d0,Player2_CPU_Target_XPos.w
		move.w	$14(a1),d0
		move.w	d0,Player2_CPU_Target_YPos.w
		subi.w	#$C0,d0
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_13B78
		addi.w	#$180,d0

loc_13B78:
		move.w	d0,$14(a0)
		ori.w	#$8000,$A(a0)
		move.w	#$100,8(a0)
		moveq	#0,d0
		move.w	d0,$18(a0)
		move.w	d0,$1A(a0)
		move.w	d0,$1C(a0)
		move.b	d0,$2D(a0)
		move.b	d0,$2F(a0)
		move.b	#2,$2A(a0)
		move.b	#$1E,$2C(a0)
		move.b	#-$7F,$2E(a0)
		move.b	d0,$30(a0)
		move.b	d0,$31(a0)
		move.w	d0,$32(a0)
		move.b	d0,$34(a0)
		move.b	d0,$35(a0)
		move.b	d0,$36(a0)
		move.b	d0,$37(a0)
		move.b	d0,$39(a0)
		move.w	d0,$3A(a0)
		move.b	d0,$3C(a0)
		move.b	d0,$3D(a0)
		move.b	d0,$3D(a0)
		move.w	d0,$3E(a0)
		move.b	d0,$40(a0)
		move.b	d0,$41(a0)
		move.b	#-$10,$25(a0)
		bsr.w	Tails_Set_Flying_Animation

locret_13BF6:
		rts


; ---------------------------------------------------------------------------

Tails_FlySwim_Unknown:
		tst.b	4(a0)
		bmi.s	loc_13C3A
		addq.w	#1,Player2_CPU_Respawn.w
		cmpi.w	#$12C,Player2_CPU_Respawn.w
		blo.s	loc_13C50
		move.w	#0,Player2_CPU_Respawn.w
		move.w	#2,Player2_CPU_Routine.w
		move.b	#-$7F,$2E(a0)
		move.b	#2,$2A(a0)
		move.w	#0,$10(a0)
		move.w	#0,$14(a0)
		move.b	#-$10,$25(a0)
		bsr.w	Tails_Set_Flying_Animation
		rts

loc_13C3A:
		move.b	#-$10,$25(a0)
		ori.b	#2,$2A(a0)
		bsr.w	Tails_Set_Flying_Animation
		move.w	#0,Player2_CPU_Respawn.w

loc_13C50:
		lea	Position_table.w,a2
		move.w	#$10,d2
		lsl.b	#2,d2
		addq.b	#4,d2
		move.w	Sonic_Pos_Record_Index.w,d3
		sub.b	d2,d3
		move.w	(a2,d3.w),Player2_CPU_Target_XPos.w
		move.w	2(a2,d3.w),Player2_CPU_Target_YPos.w
		move.w	$10(a0),d0
		sub.w	Player2_CPU_Target_XPos.w,d0
		beq.s	loc_13CBE
		move.w	d0,d2
		bpl.s	loc_13C7E
		neg.w	d2

loc_13C7E:
		lsr.w	#4,d2
		cmpi.w	#$C,d2
		blo.s	loc_13C88
		moveq	#$C,d2

loc_13C88:
		move.b	$18(a1),d1
		bpl.s	loc_13C90
		neg.b	d1

loc_13C90:
		add.b	d1,d2
		addq.w	#1,d2
		tst.w	d0
		bmi.s	loc_13CAA
		bset	#0,$2A(a0)
		cmp.w	d0,d2
		blo.s	loc_13CA6
		move.w	d0,d2
		moveq	#0,d0


; ---------------------------------------------------------------------------

loc_13CA6:
		neg.w	d2
		bra.s	loc_13CBA

loc_13CAA:
		bclr	#0,$2A(a0)
		neg.w	d0
		cmp.w	d0,d2
		blo.s	loc_13CBA
		move.b	d0,d2
		moveq	#0,d0

loc_13CBA:
		add.w	d2,$10(a0)

loc_13CBE:
		moveq	#1,d2
		move.w	$14(a0),d1
		sub.w	Player2_CPU_Target_YPos.w,d1
		beq.s	loc_13CD2
		bmi.s	loc_13CCE
		neg.w	d2

loc_13CCE:
		add.w	d2,$14(a0)

loc_13CD2:
		lea	Position_table_P2.w,a2
		move.b	2(a2,d3.w),d2
		andi.b	#$80,d2
		bne.s	loc_13D42
		or.w	d0,d1
		bne.s	loc_13D42
		cmpi.b	#6,Object_RAM+routine.w
		bhs.s	loc_13D42
		move.w	#6,Player2_CPU_Routine.w
		move.b	#0,$2E(a0)
		move.b	#0,$20(a0)
		move.w	#0,$18(a0)
		move.w	#0,$1A(a0)
		move.w	#0,$1C(a0)
		andi.b	#$40,$2A(a0)
		ori.b	#2,$2A(a0)
		move.w	#0,$32(a0)
		andi.w	#$7FFF,$A(a0)
		tst.b	$A(a1)
		bpl.s	loc_13D34
		ori.w	#$8000,$A(a0)


; ---------------------------------------------------------------------------

loc_13D34:
		move.b	$46(a1),$46(a0)
		move.b	$47(a1),$47(a0)
		rts


; ---------------------------------------------------------------------------

loc_13D42:
		move.b	#-$7F,$2E(a0)
		rts


; ---------------------------------------------------------------------------

loc_13D4A:
		cmpi.b	#6,Object_RAM+routine.w
		blo.s	loc_13D78
		move.w	#4,Player2_CPU_Routine.w
		move.b	#0,$3D(a0)
		move.w	#0,$3E(a0)
		move.b	#-$7F,$2E(a0)
		move.b	#2,$2A(a0)
		move.b	#$20,$20(a0)
		rts

loc_13D78:
		bsr.w	sub_13EFC
		tst.w	Player2_CPU_Control_Counter.w
		bne.w	loc_13EBE
		tst.b	$2E(a0)
		bmi.w	loc_13EBE
		tst.b	$37(a1)
		bmi.w	loc_13EBE
		tst.w	$32(a0)
		beq.s	loc_13DA6
		tst.w	$1C(a0)
		bne.s	loc_13DA6
		move.w	#8,Player2_CPU_Routine.w

loc_13DA6:
		lea	Position_table.w,a2
		move.w	#$10,d1
		lsl.b	#2,d1
		addq.b	#4,d1
		move.w	Sonic_Pos_Record_Index.w,d0
		sub.b	d1,d0
		move.w	(a2,d0.w),d2
		btst	#3,$2A(a1)
		bne.s	loc_13DD0
		cmpi.w	#$400,$1C(a1)
		bge.s	loc_13DD0
		subi.w	#$20,d2

loc_13DD0:
		move.w	2(a2,d0.w),d3
		lea	Position_table_P2.w,a2
		move.w	(a2,d0.w),d1
		move.b	2(a2,d0.w),d4
		move.w	d1,d0
		btst	#5,$2A(a0)
		beq.s	loc_13DF2
		btst	#5,d4
		beq.w	loc_13E9C

loc_13DF2:
		sub.w	$10(a0),d2
		beq.s	loc_13E50
		bpl.s	loc_13E26
		neg.w	d2
		cmpi.w	#$30,d2
		blo.s	loc_13E0A
		andi.w	#$F3F3,d1
		ori.w	#$404,d1


; ---------------------------------------------------------------------------

loc_13E0A:
		tst.w	$1C(a0)
		beq.s	loc_13E64
		btst	#0,$2A(a0)
		beq.s	loc_13E64
		btst	#0,$2E(a0)
		bne.s	loc_13E64
		subq.w	#1,$10(a0)
		bra.s	loc_13E64

loc_13E26:
		cmpi.w	#$30,d2
		blo.s	loc_13E34
		andi.w	#$F3F3,d1
		ori.w	#$808,d1


; ---------------------------------------------------------------------------

loc_13E34:
		tst.w	$1C(a0)
		beq.s	loc_13E64
		btst	#0,$2A(a0)
		bne.s	loc_13E64
		btst	#0,$2E(a0)
		bne.s	loc_13E64
		addq.w	#1,$10(a0)
		bra.s	loc_13E64

loc_13E50:
		bclr	#0,$2A(a0)
		move.b	d4,d0
		andi.b	#1,d0
		beq.s	loc_13E64
		bset	#0,$2A(a0)

loc_13E64:
		tst.b	Player2_CPU_UnkFlag.w
		beq.s	loc_13E7C
		ori.w	#$7000,d1
		btst	#1,$2A(a0)
		bne.s	loc_13EB8
		move.b	#0,Player2_CPU_UnkFlag.w

loc_13E7C:
		move.w	Level_Frame_Timer.w,d0
		andi.w	#$FF,d0
		beq.s	loc_13E8C
		cmpi.w	#$40,d2
		bhs.s	loc_13EB8

loc_13E8C:
		sub.w	$14(a0),d3
		beq.s	loc_13EB8
		bpl.s	loc_13EB8
		neg.w	d3
		cmpi.w	#$20,d3
		blo.s	loc_13EB8

loc_13E9C:
		move.b	Level_Frame_Timer+1.w,d0
		andi.b	#$3F,d0
		bne.s	loc_13EB8
		cmpi.b	#8,$20(a0)
		beq.s	loc_13EB8
		ori.w	#$7070,d1
		move.b	#1,Player2_CPU_UnkFlag.w


; ---------------------------------------------------------------------------

loc_13EB8:
		move.w	d1,Ctrl_2_Held_Logical.w
		rts

loc_13EBE:
		tst.w	Player2_CPU_Control_Counter.w
		beq.s	locret_13EC8
		subq.w	#1,Player2_CPU_Control_Counter.w


; ############### S U B	R O U T	I N E #######################################

locret_13EC8:
		rts


; End of function sub_13ECA
; ############### S U B	R O U T	I N E #######################################

sub_13ECA:
		move.w	#0,Player2_CPU_Control_Counter.w
		move.w	#0,Player2_CPU_Respawn.w
		move.w	#2,Player2_CPU_Routine.w
		move.b	#-$7F,$2E(a0)
		move.b	#2,$2A(a0)
		move.w	#$7F00,$10(a0)
		move.w	#0,$14(a0)
		move.b	#0,$2F(a0)
		rts

sub_13EFC:
		tst.b	4(a0)
		bmi.s	loc_13F28
		btst	#3,$2A(a0)
		beq.s	loc_13F18
		moveq	#0,d0
		movea.w	$42(a0),a3
		move.w	Player2_CPU_Flag.w,d0
		cmp.w	(a3),d0
		bne.s	loc_13F24

loc_13F18:
		addq.w	#1,Player2_CPU_Respawn.w
		cmpi.w	#$12C,Player2_CPU_Respawn.w
		blo.s	loc_13F2E


; ---------------------------------------------------------------------------

loc_13F24:
		bra.w	sub_13ECA

loc_13F28:
		move.w	#0,Player2_CPU_Respawn.w

loc_13F2E:
		btst	#3,$2A(a0)
		beq.s	locret_13F3E
		movea.w	$42(a0),a3
		move.w	(a3),Player2_CPU_Flag.w


; End of function sub_13EFC
; ---------------------------------------------------------------------------

locret_13F3E:
		rts

loc_13F40:
		bsr.w	sub_13EFC
		tst.w	Player2_CPU_Control_Counter.w
		bne.w	locret_13FBE
		tst.w	$32(a0)
		bne.s	locret_13FBE
		tst.b	$3D(a0)
		bne.s	loc_13F94
		tst.w	$1C(a0)
		bne.s	locret_13FBE
		bclr	#0,$2A(a0)
		move.w	$10(a0),d0
		sub.w	$10(a1),d0
		blo.s	loc_13F74
		bset	#0,$2A(a0)


; ---------------------------------------------------------------------------

loc_13F74:
		move.w	#$202,Ctrl_2_Held_Logical.w
		move.b	Level_Frame_Timer+1.w,d0
		andi.b	#$7F,d0
		beq.s	loc_13FA4
		cmpi.b	#8,$20(a0)
		bne.s	locret_13FBE
		move.w	#$7272,Ctrl_2_Held_Logical.w
		rts

loc_13F94:
		move.w	#$202,Ctrl_2_Held_Logical.w
		move.b	Level_Frame_Timer+1.w,d0
		andi.b	#$7F,d0
		bne.s	loc_13FB2


; ---------------------------------------------------------------------------

loc_13FA4:
		move.w	#0,Ctrl_2_Held_Logical.w
		move.w	#6,Player2_CPU_Routine.w
		rts

loc_13FB2:
		andi.b	#$1F,d0
		bne.s	locret_13FBE
		ori.w	#$7070,Ctrl_2_Held_Logical.w


; ---------------------------------------------------------------------------

locret_13FBE:
		rts


; ---------------------------------------------------------------------------

locret_13FC0:
		rts

loc_13FC2:
		move.b	#1,$2F(a0)
		move.b	#-$10,$25(a0)
		move.b	#2,$2A(a0)
		move.w	#$100,$18(a0)
		move.w	#0,$1A(a0)
		move.w	#0,$1C(a0)
		lea	Object_RAM.w,a1
		bsr.w	sub_1459E
		move.b	#1,Player2_Carrying.w
		move.w	#$E,Player2_CPU_Routine.w

loc_13FFA:
		move.w	#0,Player2_CPU_Control_Counter.w
		move.w	#0,Ctrl_2_Held_Logical.w
		move.b	Level_Frame_Timer+1.w,d0
		andi.b	#$1F,d0
		bne.s	loc_14016
		ori.w	#$808,Ctrl_2_Held_Logical.w

loc_14016:
		lea	Player2_Carrying.w,a2
		lea	Object_RAM.w,a1
		btst	#1,$2A(a1)
		bne.s	loc_14082
		move.w	#6,Player2_CPU_Routine.w
		move.b	#0,$2E(a0)
		move.b	#0,$20(a0)
		move.w	#0,$18(a0)
		move.w	#0,$1A(a0)
		move.w	#0,$1C(a0)
		move.b	#2,$2A(a0)
		move.w	#0,$32(a0)
		andi.w	#$7FFF,$A(a0)
		tst.b	$A(a1)
		bpl.s	loc_14068
		ori.w	#-$8000,$A(a0)

loc_14068:
		move.b	$46(a1),$46(a0)
		move.b	$47(a1),$47(a0)
		cmpi.w	#1,Player_Mode.w
		bne.s	loc_14082
		move.w	#$10,Player2_CPU_Routine.w


; ---------------------------------------------------------------------------

loc_14082:
		move.w	Ctrl_1_Held.w,d0
		bra.w	Tails_Carry_Sonic

loc_1408A:
		move.w	#0,Player2_CPU_Control_Counter.w
		move.b	#-$10,$25(a0)
		move.w	#0,Ctrl_2_Held_Logical.w
		move.b	Level_Frame_Timer+1.w,d0
		andi.b	#$F,d0
		bne.s	loc_140AC
		ori.w	#$7878,Ctrl_2_Held_Logical.w

loc_140AC:
		tst.b	4(a0)
		bmi.s	locret_140C4
		moveq	#0,d0
		move.l	d0,(a0)
		move.w	d0,$10(a0)
		move.w	d0,$14(a0)
		move.w	#$A,Player2_CPU_Routine.w


; ---------------------------------------------------------------------------

locret_140C4:
		rts


; ---------------------------------------------------------------------------

loc_140C6:
		move.w	#0,Ctrl_2_Held_Logical.w
		rts

loc_140CE:
		move.b	#1,$2F(a0)
		move.b	#-$10,$25(a0)
		move.b	#2,$2A(a0)
		move.w	#0,$18(a0)
		move.w	#0,$1A(a0)
		move.w	#0,$1C(a0)
		lea	Object_RAM.w,a1
		bsr.w	sub_1459E
		move.b	#1,Player2_Carrying.w
		move.w	#$16,Player2_CPU_Routine.w

loc_14106:
		move.w	#0,Player2_CPU_Control_Counter.w
		move.b	#-$10,$25(a0)
		move.w	#0,Ctrl_2_Held_Logical.w
		move.b	Level_Frame_Timer+1.w,d0
		andi.b	#7,d0
		bne.s	loc_14128
		ori.w	#$7070,Ctrl_2_Held_Logical.w

loc_14128:
		move.w	Camera_Y.w,d0
		addi.w	#$90,d0
		cmp.w	$14(a0),d0
		blo.s	loc_1413C
		move.w	#$18,Player2_CPU_Routine.w


; ---------------------------------------------------------------------------

loc_1413C:
		lea	Player2_Carrying.w,a2
		lea	Object_RAM.w,a1
		move.w	Ctrl_1_Held.w,d0
		bra.w	Tails_Carry_Sonic


; ---------------------------------------------------------------------------

loc_1414C:
		move.b	#-$10,$25(a0)
		tst.w	Player2_CPU_Control_Counter.w
		beq.s	loc_14164
		tst.b	Player2_Carrying.w
		bne.w	loc_141E2
		bra.w	loc_142E2


; ---------------------------------------------------------------------------

loc_14164:
		move.w	#0,Ctrl_2_Held_Logical.w
		tst.b	Player2_Carrying.w
		beq.w	loc_142E2
		clr.b	Unk_FAAC.w
		btst	#1,Ctrl_1_Held.w
		beq.s	loc_14198
		addq.b	#1,Player2_CPU_Last_Obj_interact.w
		cmpi.b	#-$40,Player2_CPU_Last_Obj_interact.w
		blo.s	loc_141D2
		move.b	#0,Player2_CPU_Last_Obj_interact.w
		ori.w	#$7070,Ctrl_2_Held_Logical.w
		bra.s	loc_141D2


; ---------------------------------------------------------------------------

loc_14198:
		btst	#0,Ctrl_1_Held.w
		beq.s	loc_141BA
		addq.b	#1,Player2_CPU_Last_Obj_interact.w
		cmpi.b	#$20,Player2_CPU_Last_Obj_interact.w
		blo.s	loc_141D2
		move.b	#0,Player2_CPU_Last_Obj_interact.w
		ori.w	#$7070,Ctrl_2_Held_Logical.w
		bra.s	loc_141D2

loc_141BA:
		addq.b	#1,Player2_CPU_Last_Obj_interact.w
		cmpi.b	#$58,Player2_CPU_Last_Obj_interact.w
		blo.s	loc_141D2
		move.b	#0,Player2_CPU_Last_Obj_interact.w
		ori.w	#$7070,Ctrl_2_Held_Logical.w

loc_141D2:
		move.b	Ctrl_1_Held.w,d0
		andi.b	#$C,d0
		or.b	Ctrl_2_Held_Logical.w,d0
		move.b	d0,Ctrl_2_Held_Logical.w


; ---------------------------------------------------------------------------

loc_141E2:
		lea	Player2_Carrying.w,a2
		lea	Object_RAM.w,a1
		move.w	Ctrl_1_Held.w,d0
		bra.w	Tails_Carry_Sonic

loc_141F2:
		move.b	#1,$2F(a0)
		move.b	#-$10,$25(a0)
		move.b	#2,$2A(a0)
		move.w	#0,$18(a0)
		move.w	#0,$1A(a0)
		move.w	#0,$1C(a0)
		move.w	#$1C,Player2_CPU_Routine.w

loc_1421C:
		move.w	#0,Player2_CPU_Control_Counter.w
		move.b	#-$10,$25(a0)
		move.w	#0,Ctrl_2_Held_Logical.w
		move.b	Level_Frame_Timer+1.w,d0
		andi.b	#7,d0
		bne.s	loc_1423E
		ori.w	#$7070,Ctrl_2_Held_Logical.w

loc_1423E:
		move.w	Camera_Y.w,d0
		addi.w	#$90,d0
		cmp.w	$14(a0),d0
		blo.s	locret_14252
		move.w	#$1E,Player2_CPU_Routine.w


; ---------------------------------------------------------------------------

locret_14252:
		rts


; ---------------------------------------------------------------------------

loc_14254:
		move.b	#-$10,$25(a0)
		rts

loc_1425C:
		move.b	#1,$2F(a0)
		move.b	#-$10,$25(a0)
		move.b	#2,$2A(a0)
		move.w	#$100,$18(a0)
		move.w	#0,$1A(a0)
		move.w	#0,$1C(a0)
		move.w	#$22,Player2_CPU_Routine.w

loc_14286:
		move.w	#0,Player2_CPU_Control_Counter.w
		move.w	#0,Ctrl_2_Held_Logical.w
		move.b	Level_Frame_Timer+1.w,d0
		andi.b	#$1F,d0
		bne.s	loc_142A2
		ori.w	#$808,Ctrl_2_Held_Logical.w

loc_142A2:
		btst	#1,$2A(a0)
		bne.s	locret_142E0
		move.w	#6,Player2_CPU_Routine.w
		move.b	#0,$2E(a0)
		move.b	#0,$20(a0)
		move.w	#0,$18(a0)
		move.w	#0,$1A(a0)
		move.w	#0,$1C(a0)
		move.b	#2,$2A(a0)
		move.w	#0,$32(a0)
		andi.w	#$7FFF,$A(a0)


; ---------------------------------------------------------------------------

locret_142E0:
		rts

loc_142E2:
		tst.b	Unk_FAAC.w
		bne.s	loc_14362
		lea	Object_RAM.w,a1
		tst.b	4(a1)
		bpl.s	loc_14330
		tst.w	Player2_CPU_Control_Counter.w
		bne.w	loc_143AA
		cmpi.w	#$300,$1A(a1)
		bge.s	loc_14330
		move.w	#0,$18(a0)
		move.w	#0,Ctrl_2_Held_Logical.w
		cmpi.w	#$200,$1A(a0)
		bge.s	loc_14328
		addq.b	#1,Player2_CPU_Last_Obj_interact.w
		cmpi.b	#$58,Player2_CPU_Last_Obj_interact.w
		blo.s	loc_1432E
		move.b	#0,Player2_CPU_Last_Obj_interact.w

loc_14328:
		ori.w	#$7070,Ctrl_2_Held_Logical.w

loc_1432E:
		bra.s	loc_143AA
; ---------------------------------------------------------------------------

loc_14330:
		st	Unk_FAAC.w
		move.w	$14(a1),d1
		sub.w	$14(a0),d1
		bpl.s	loc_14340
		neg.w	d1

loc_14340:
		lsr.w	#2,d1
		move.w	d1,d2
		lsr.w	#1,d2
		add.w	d2,d1
		move.w	d1,Previous_Min_X_Pos.w
		move.w	$10(a1),d1
		sub.w	$10(a0),d1
		bpl.s	loc_14358
		neg.w	d1


; ---------------------------------------------------------------------------

loc_14358:
		lsr.w	#2,d1
		move.w	d1,Previous_Max_X_Pos.w
		bra.w	loc_143AA

loc_14362:
		move.w	#0,Ctrl_2_Held_Logical.w
		lea	Object_RAM.w,a1
		move.w	$10(a0),d0
		move.w	$14(a0),d1
		subi.w	#$10,d1
		move.w	Previous_Max_X_Pos.w,d2
		bclr	#0,$2A(a0)
		cmp.w	$10(a1),d0
		blo.s	loc_14390
		bset	#0,$2A(a0)
		neg.w	d2

loc_14390:
		add.w	d2,$18(a0)
		cmp.w	$14(a1),d1
		bhs.s	loc_143AA
		move.w	Previous_Min_X_Pos.w,d2
		cmp.w	$14(a1),d1
		blo.s	loc_143A6
		neg.w	d2

loc_143A6:
		add.w	d2,$1A(a0)


; ############### S U B	R O U T	I N E #######################################

loc_143AA:
		lea	Player2_Carrying.w,a2
		lea	Object_RAM.w,a1
		move.w	Ctrl_1_Held.w,d0

Tails_Carry_Sonic:
		tst.b	(a2)
		beq.w	loc_14534		; branch if p1 is not being carried
		cmpi.b	#4,routine(a1)
		bhs.w	loc_14466		; branch if p1 is dead or hurt
		btst	#1,status(a1)		; branch if Sonic is not on air anymore
		beq.w	loc_1445A		; maybe done because of rising platforms
						; to make sure Sonic is not on it and still being carried
						; doesnt seem to be all too much useful othervise.
		move.w	Tails_PreviousFlying_X_Speed.w,d1
		cmp.w	xvel(a1),d1		; check if Sonic is not pushed against a wall
		bne.s	loc_1445A		; if he is, branch
		move.w	Tails_PreviousFlying_Y_Speed.w,d1
		cmp.w	yvel(a1),d1		; check if Sonic is sat on ground
		bne.s	loc_14460		; if he is, branch
		tst.b	Carried(a1)
		bmi.s	loc_1446A		; check if carry flag is negative
		andi.b	#$70,d0
		beq.w	loc_14474		; branch if A, B or C is not pressed

	; Sonic jumped out!
		clr.b	Carried(a1)		; clear carried flag of p1
		clr.b	(a2)			; clear carried flag
		move.b	#$12,1(a2)
		andi.w	#$0F00,d0		; get UDLR held
		beq.w	loc_14410		; if none are held, branch
		move.b	#$3C,1(a2)

loc_14410:
		btst	#$A,d0
		beq.s	loc_1441C
		move.w	#-$200,xvel(a1)

loc_1441C:
		btst	#$B,d0
		beq.s	loc_14428
		move.w	#$200,xvel(a1)

loc_14428:
		move.w	#-$380,yvel(a1)		; set player y-velocity
		move.b	#1,jumping(a1)		; set jumping flag
		move.b	#$E,yrad(a1)		;
		move.b	#7,xrad(a1)		; reset radius
		move.b	#2,anim(a1)		; set to jumping animation
		or.b	#6,status(a1)		; set on air and jumping or rolling bit
		bclr	#4,status(a1)		; clear jumping after rolling bit
		rts
; ---------------------------------------------------------------------------

loc_1445A:
		move.w	#-$100,yvel(a1)		; move up a bit

loc_14460:
		sf	jumping(a1)		; clear jumping flag

loc_14466:
		sf	Carried(a1)		; clear carried flag of p1
		sf	anim(a1)		; clear animation number (set to 0)

loc_1446A:
		clr.b	(a2)			; clear carried flag
		move.b	#$3C,1(a2)
		rts
; ---------------------------------------------------------------------------

loc_14474:
		andi.b	#$FC,render(a1)		; clear facing bits
		andi.b	#$FE,status(a1)		; clear facing left or right bit

		move.w	xpos(a0),xpos(a1)
		move.w	ypos(a0),ypos(a1)	; copy position of Tails
		addi.w	#28,ypos(a1)		; offset the player down
		tst.b	ReverseGravity_Flag.w
		beq.s	.norev			; if reverse gravity is not active, branch
		subi.w	#28*2,ypos(a1)		; offset up instead
		eori.b	#2,render(a1)		; put upsidedown

.norev		btst	#0,status(a0)		; check if Tails faces left
		beq.s	.noleft			; if not, branch
		bset	#0,render(a1)		;
		bset	#0,status(a1)		; face left

.noleft		subq.b	#1,anitime(a1)		; sub 1 from animation time
		bpl.s	.noChange		; if positive, branch
		move.b	#$C-1,anitime(a1)	; reset it
		moveq	#0,d1
		move.b	anioff(a1),d1		; get offset
		addq.b	#1,anioff(a1)		; add 1 to animation offs

		moveq	#0,d0
		move.b	byte_14522(pc,d1.w),d0	; get animation frame
		cmpi.b	#-1,d0			; check for end token
		bne.s	.notend			; if nou, branch
		sf	anioff(a1)		; reset offset
		move.b	byte_14522(pc),d0	; get first entry

.notend		move.b	d0,frame(a1)		; set the frame
		move.l	a2,-(sp)
		jsr	Tails_Carry_LoadPLC	; load Sonic's DPLC
		movea.l	(sp)+,a2

.noChange	move.w	xvel(a0),Object_RAM+xvel.w; store x-velocity
		move.w	xvel(a0),Tails_PreviousFlying_X_Speed.w; ^
		move.w	yvel(a0),Object_RAM+yvel.w; store y-velocity
		move.w	yvel(a0),Tails_PreviousFlying_Y_Speed.w; ^

		movem.l	d0-a6,-(sp)
		lea	Object_RAM.w,a0
		bsr.w	sub_11EEC		; collide with ground what you
		movem.l	(sp)+,d0-a6
		rts

; ---------------------------------------------------------------------------
byte_14522:
	dc.b $91, $91, $90, $90, $90, $90
	dc.b $90, $90, $92, $92, $92, $92
	dc.b $92, $92, $91, $91, $FF
	even
; ---------------------------------------------------------------------------

loc_14534:
		tst.b	1(a2)		; check if no carry delay is over
		beq.s	.ok		; if is, branch
		subq.b	#1,1(a2)	; sub 1 from the delay
		bne.w	.rts		; if not 0, branch

.ok		tst.b	Carried(a1)
		bne.s	.rts		; branch if Sonic is already being carried
		cmpi.b	#4,routine(a1)
		bhs.s	.rts		; branch if player is dead or hurt
		tst.w	Debug_Routine.w
		bne.s	.rts		; branch if debug mode is active
		tst.b	spindash(a1)
		bne.s	.rts		; branch if player is spindashing

		move.w	xpos(a1),d0
		sub.w	xpos(a0),d0
		addi.w	#$10,d0
		cmpi.w	#$20,d0
		bhs.w	.rts		; branch is player is not near Tails

		move.w	ypos(a1),d1
		sub.w	ypos(a0),d1
		subi.w	#$20,d1
		tst.b	ReverseGravity_Flag.w
		beq.s	.norev		; branch if reverse gravity isnt active
		addi.w	#$50,d1

.norev		cmpi.w	#$10,d1
		bhs.w	.rts		; branch is player is not near Tails

		bsr.s	sub_1459E
		moveq	#$4A,d0
		jsr	PlaySFX
		move.b	#1,(a2)
.rts		rts
; ---------------------------------------------------------------------------

sub_1459E:
		move.w	xvel(a0),Tails_PreviousFlying_X_Speed.w
		move.w	xvel(a0),xvel(a1)
		move.w	yvel(a0),Tails_PreviousFlying_Y_Speed.w
		move.w	yvel(a0),yvel(a1)

		clr.w	inertia(a1)
		clr.w	angle(a1)
		move.w	xpos(a0),xpos(a1)
		move.w	ypos(a0),ypos(a1)	; copy position of Tails
		addi.w	#28,ypos(a1)		; offset the player down
		move.w	#$2200,anim(a1)
		sf	anitime(a1)
		sf	anioff(a1)
		move.b	#3,Carried(a1)		; set player be carried

		bset	#1,status(a1)		; set on air flag
		andi.b	#$FC,render(a1)
		andi.b	#$EE,status(a1)		; clear facing and jumping after rolling bit
		btst	#0,status(a0)		; check if Tails faces left
		beq.s	.noleft			; if not, branch
		bset	#0,render(a1)		;
		bset	#0,status(a1)		; face left

.noleft		tst.b	ReverseGravity_Flag.w
		beq.s	.rts			; if reverse gravity is not active, branch
		subi.w	#28*2,ypos(a1)		; offset up instead
		eori.b	#2,render(a1)		; put upsidedown
.rts		rts
; ---------------------------------------------------------------------------

sub_14632:
		tst.b	Water_Flag.w
		bne.s	loc_1463A

locret_14638:
		rts
; ---------------------------------------------------------------------------

loc_1463A:
		move.w	Water_Height_Default.w,d0
		cmp.w	ypos(a0),d0
		bge.s	loc_146BA
		bset	#6,$2A(a0)
		bne.s	locret_14638
		addq.b	#1,Water_Routine.w
		movea.l	a0,a1
		bsr.w	Player_ResetAirTimer
		move.l	#Obj_Air_CountDown,Object_RAM_static+$94.w
		move.b	#-$7F,Object_RAM_static+$C0.w
		move.l	a0,Object_RAM_static+$D4.w
		move.w	#$300,(a4)
		move.w	#6,2(a4)
		move.w	#$40,4(a4)
		tst.b	Super_Tails_Flag.w
		beq.s	loc_1468E
		move.w	#$400,(a4)
		move.w	#$C,2(a4)
		move.w	#$60,4(a4)

loc_1468E:
		cmpi.w	#4,Player2_CPU_Routine.w
		beq.s	loc_1469C
		tst.b	$2E(a0)
		bne.s	locret_14638


; ---------------------------------------------------------------------------

loc_1469C:
		asr	$18(a0)
		asr	$1A(a0)
		asr	$1A(a0)
		beq.s	locret_14638
		move.w	#$100,$20(a6)
		move.w	#$39,d0
		jmp	PlaySFX

loc_146BA:
		bclr	#6,$2A(a0)
		beq.w	locret_14638
		addq.b	#1,Water_Routine.w
		movea.l	a0,a1
		bsr.w	Player_ResetAirTimer
		move.w	#$600,(a4)
		move.w	#$C,2(a4)
		move.w	#$80,4(a4)
		tst.b	Super_Tails_Flag.w
		beq.s	loc_146F4
		move.w	#$800,(a4)
		move.w	#$18,2(a4)
		move.w	#$C0,4(a4)

loc_146F4:
		cmpi.b	#4,5(a0)
		beq.s	loc_14718
		cmpi.w	#4,Player2_CPU_Routine.w
		beq.s	loc_1470A
		tst.b	$2E(a0)
		bne.s	loc_14718

loc_1470A:
		move.w	$1A(a0),d0
		cmpi.w	#-$400,d0
		blt.s	loc_14718
		asl	$1A(a0)

loc_14718:
		cmpi.b	#$1C,$20(a0)
		beq.w	locret_14638
		tst.w	$1A(a0)
		beq.w	locret_14638
		move.w	#$100,$20(a6)
		cmpi.w	#-$1000,$1A(a0)
		bgt.s	loc_1473E
		move.w	#-$1000,$1A(a0)


; End of function sub_14632
; ---------------------------------------------------------------------------

loc_1473E:
		move.w	#$39,d0
		jmp	PlaySFX

Tails_Stand_Path:
		tst.b	Player2_Carrying.w
		beq.s	loc_14760
		lea	Object_RAM.w,a1
		clr.b	$2E(a1)
		bset	#1,$2A(a1)
		clr.w	Player2_Carrying.w

loc_14760:
		bsr.w	Tails_Spindash
		bsr.w	Obj_Tails_Jump
		bsr.w	sub_11DA6
		bsr.w	Tails_InputAcceleration_Path
		bsr.w	Tails_Spin
		bsr.w	Tails_Check_Screen_Boundaries
		jsr	ObjectRevMove
		jsr	Call_Player_AnglePos.w
		bsr.w	sub_11E2A
		tst.b	BG_Layer_Scroll_Timer2+2.w
		beq.s	locret_147B6
		jsr	sub_F846.w
		tst.w	d1
		bmi.w	KillPlayer2
		movem.l	a4-a6,-(sp)
		jsr	ChkWallDist_Left.w
		tst.w	d1
		bpl.s	loc_147A6
		sub.w	d1,$10(a0)

loc_147A6:
		jsr	CheckRightWallDist.w
		tst.w	d1
		bpl.s	loc_147B2
		add.w	d1,$10(a0)

loc_147B2:
		movem.l	(sp)+,a4-a6


; ---------------------------------------------------------------------------

locret_147B6:
		rts

Tails_Stand_Freespace:
		tst.b	$2F(a0)
		bne.s	Tails_FlyingSwimming
		bsr.w	Obj_Tails_JumpHeight
		bsr.w	Tails_InputAcceleration_Freespace
		bsr.w	Tails_Check_Screen_Boundaries
		jsr	ObjectGravity
		btst	#6,$2A(a0)
		beq.s	loc_147DE
		subi.w	#$28,$1A(a0)


; ---------------------------------------------------------------------------

loc_147DE:
		bsr.w	sub_11E8C
		bsr.w	sub_153C2
		rts

Tails_FlyingSwimming:
		bsr.w	Tails_Move_FlySwim
		bsr.w	Tails_InputAcceleration_Freespace
		bsr.w	Tails_Check_Screen_Boundaries
		jsr	ObjectRevMove
		bsr.w	sub_11E8C
		movem.l	a4-a6,-(sp)
		bsr.w	sub_153C2
		movem.l	(sp)+,a4-a6
		tst.w	Player_Mode.w
		bne.s	locret_14820
		lea	Player2_Carrying.w,a2
		lea	Object_RAM.w,a1
		move.w	Ctrl_1_Held.w,d0
		bsr.w	Tails_Carry_Sonic


; ############### S U B	R O U T	I N E #######################################

locret_14820:
		rts

Tails_Move_FlySwim:
		move.b	Level_Frame_Timer+1.w,d0
		andi.b	#1,d0
		beq.s	loc_14836
		tst.b	$25(a0)
		beq.s	loc_14836
		subq.b	#1,$25(a0)

loc_14836:
		cmpi.b	#1,$2F(a0)
		beq.s	loc_14860
		cmpi.w	#-$100,$1A(a0)
		blt.s	loc_14858
		subi.w	#$20,$1A(a0)
		addq.b	#1,$2F(a0)
		cmpi.b	#$20,$2F(a0)
		bne.s	loc_1485E

loc_14858:
		move.b	#1,$2F(a0)


; ---------------------------------------------------------------------------

loc_1485E:
		bra.s	loc_14892

loc_14860:
		move.b	Ctrl_2_Press_Logical.w,d0
		andi.b	#$70,d0
		beq.s	.chkStartC
		cmpi.w	#-$100,$1A(a0)
		blt.s	.chkStartC
		tst.b	$25(a0)
		beq.s	.chkStartC
		btst	#6,$2A(a0)
		beq.s	.chkStart6
		tst.b	Player2_Carrying.w
		bne.s	.chkStartC

.chkStart6:
		move.b	#2,$2F(a0)

.chkStartC:
		addi.w	#8,$1A(a0)


; End of function Tails_Move_FlySwim
; ############### S U B	R O U T	I N E #######################################

loc_14892:
		move.w	Camera_min_Y.w,d0
		addi.w	#$10,d0
		cmp.w	$14(a0),d0
		blt.s	Tails_Set_Flying_Animation
		tst.w	$1A(a0)
		bpl.s	Tails_Set_Flying_Animation
		move.w	#0,$1A(a0)

Tails_Set_Flying_Animation:
		btst	#6,$2A(a0)
		bne.s	loc_14914
		moveq	#$20,d0
		tst.w	$1A(a0)
		bpl.s	loc_148C4
		moveq	#$21,d0

loc_148C4:
		tst.b	Player2_Carrying.w
		beq.s	loc_148CC
		addq.b	#2,d0

loc_148CC:
		tst.b	$25(a0)
		bne.s	loc_148F4
		moveq	#$24,d0
		move.b	d0,$20(a0)
		tst.b	4(a0)
		bpl.s	locret_148F2
		move.b	Level_Frame_Timer+1.w,d0
		addq.b	#8,d0
		andi.b	#$F,d0
		bne.s	locret_148F2
		moveq	#-$45,d0
		jsr	PlaySFX


; ---------------------------------------------------------------------------

locret_148F2:
		rts

loc_148F4:
		move.b	d0,$20(a0)
		tst.b	4(a0)
		bpl.s	locret_14912
		move.b	Level_Frame_Timer+1.w,d0
		addq.b	#8,d0
		andi.b	#$F,d0
		bne.s	locret_14912
		moveq	#-$46,d0
		jsr	PlaySFX


; ---------------------------------------------------------------------------

locret_14912:
		rts

loc_14914:
		moveq	#$25,d0
		tst.w	$1A(a0)
		bpl.s	loc_1491E
		moveq	#$26,d0

loc_1491E:
		tst.b	Player2_Carrying.w
		beq.s	.unpause6
		moveq	#$27,d0

.unpause6:
		tst.b	$25(a0)
		bne.s	.unpauseE
		moveq	#$28,d0


; End of function Tails_Set_Flying_Animation
; ---------------------------------------------------------------------------

.unpauseE:
		move.b	d0,$20(a0)
		rts

Tails_Spin_Path:
		tst.b	Player2_Carrying.w
		beq.s	loc_1494C
		lea	Object_RAM.w,a1
		clr.b	$2E(a1)
		bset	#1,$2A(a1)
		clr.w	Player2_Carrying.w

loc_1494C:
		tst.b	$3D(a0)
		bne.s	loc_14956
		bsr.w	Obj_Tails_Jump

loc_14956:
		bsr.w	sub_11DEE
		bsr.w	sub_14D32
		bsr.w	Tails_Check_Screen_Boundaries
		jsr	ObjectRevMove
		jsr	Call_Player_AnglePos.w
		bsr.w	sub_11E2A
		tst.b	BG_Layer_Scroll_Timer2+2.w
		beq.s	locret_149A0
		jsr	sub_F846.w
		tst.w	d1
		bmi.w	KillPlayer2
		movem.l	a4-a6,-(sp)
		jsr	ChkWallDist_Left.w
		tst.w	d1
		bpl.s	loc_14990
		sub.w	d1,$10(a0)

loc_14990:
		jsr	CheckRightWallDist.w
		tst.w	d1
		bpl.s	loc_1499C
		add.w	d1,$10(a0)

loc_1499C:
		movem.l	(sp)+,a4-a6


; ---------------------------------------------------------------------------

locret_149A0:
		rts

Tails_Spin_Freespace:
		tst.b	Player2_Carrying.w
		beq.s	loc_149BA
		lea	Object_RAM.w,a1
		clr.b	$2E(a1)
		bset	#1,$2A(a1)
		clr.w	Player2_Carrying.w

loc_149BA:
		bsr.w	Obj_Tails_JumpHeight
		bsr.w	Tails_InputAcceleration_Freespace
		bsr.w	Tails_Check_Screen_Boundaries
		jsr	ObjectGravity
		btst	#6,$2A(a0)
		beq.s	loc_149DA
		subi.w	#$28,$1A(a0)


; ############### S U B	R O U T	I N E #######################################

loc_149DA:
		bsr.w	sub_11E8C
		bsr.w	sub_153C2
		rts

Tails_InputAcceleration_Path:
		move.w	(a4),d6
		move.w	2(a4),d5
		move.w	4(a4),d4
		tst.b	$2B(a0)
		bmi.w	loc_14B5C
		tst.w	$32(a0)
		bne.w	loc_14B14
		btst	#2,Ctrl_2_Held_Logical.w
		beq.s	loc_14A0A
		bsr.w	sub_14C20

loc_14A0A:
		btst	#3,Ctrl_2_Held_Logical.w
		beq.s	loc_14A16
		bsr.w	sub_14CAC


; ---------------------------------------------------------------------------

loc_14A16:
		move.b	$26(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.w	loc_14B14
		tst.w	$1C(a0)
		bne.w	loc_14B14
		bclr	#5,$2A(a0)
		move.b	#5,$20(a0)
		btst	#3,$2A(a0)
		beq.s	loc_14A6C
		movea.w	$42(a0),a1
		tst.b	$2A(a1)
		bmi.s	loc_14AA0
		moveq	#0,d1
		move.b	7(a1),d1
		move.w	d1,d2
		add.w	d2,d2
		subq.w	#4,d2
		add.w	$10(a0),d1
		sub.w	$10(a1),d1
		cmpi.w	#4,d1
		blt.s	loc_14A92
		cmp.w	d2,d1
		bge.s	loc_14A82
		bra.s	loc_14AA0

loc_14A6C:
		move.w	$10(a0),d3
		jsr	Sonic_CheckFloorEdge.w
		cmpi.w	#$C,d1
		blt.s	loc_14AA0
		cmpi.b	#3,$3A(a0)
		bne.s	loc_14A8A


; ---------------------------------------------------------------------------

loc_14A82:
		bclr	#0,$2A(a0)
		bra.s	loc_14A98

loc_14A8A:
		cmpi.b	#3,$3B(a0)
		bne.s	loc_14AA0

loc_14A92:
		bset	#0,$2A(a0)


; ---------------------------------------------------------------------------

loc_14A98:
		move.b	#6,$20(a0)
		bra.s	loc_14B14


; ---------------------------------------------------------------------------

loc_14AA0:
		btst	#1,Ctrl_2_Held_Logical.w
		beq.s	loc_14ADA
		move.b	#8,$20(a0)
		addq.b	#1,$39(a0)
		cmpi.b	#60,$39(a0)
		blo.s	loc_14B1A
		move.b	#60,$39(a0)
		tst.b	ReverseGravity_Flag.w
		bne.s	loc_14AD0
		cmpi.w	#8,(a5)
		beq.s	loc_14B26
		subq.w	#2,(a5)
		bra.s	loc_14B26


; ---------------------------------------------------------------------------

loc_14AD0:
		cmpi.w	#$D8,(a5)
		beq.s	loc_14B26
		addq.w	#2,(a5)
		bra.s	loc_14B26


; ---------------------------------------------------------------------------

loc_14ADA:
		btst	#0,Ctrl_2_Held_Logical.w
		beq.s	loc_14B14
		move.b	#7,$20(a0)
		addq.b	#1,$39(a0)
		cmpi.b	#60,$39(a0)
		blo.s	loc_14B1A
		move.b	#60,$39(a0)
		tst.b	ReverseGravity_Flag.w
		bne.s	loc_14B0A
		cmpi.w	#$C8,(a5)
		beq.s	loc_14B26
		addq.w	#2,(a5)
		bra.s	loc_14B26


; ---------------------------------------------------------------------------

loc_14B0A:
		cmpi.w	#$18,(a5)
		beq.s	loc_14B26
		subq.w	#2,(a5)
		bra.s	loc_14B26

loc_14B14:
		move.b	#0,$39(a0)

loc_14B1A:
		cmpi.w	#$60,(a5)
		beq.s	loc_14B26
		bhs.s	loc_14B24
		addq.w	#4,(a5)

loc_14B24:
		subq.w	#2,(a5)

loc_14B26:
		tst.b	Super_Tails_Flag.w
		beq.s	loc_14B30
		move.w	#$C,d5

loc_14B30:
		move.b	Ctrl_2_Held_Logical.w,d0
		andi.b	#$C,d0
		bne.s	loc_14B5C
		move.w	$1C(a0),d0
		beq.s	loc_14B5C
		bmi.s	loc_14B50
		sub.w	d5,d0
		bhs.s	loc_14B4A
		move.w	#0,d0


; ---------------------------------------------------------------------------

loc_14B4A:
		move.w	d0,$1C(a0)
		bra.s	loc_14B5C

loc_14B50:
		add.w	d5,d0
		bhs.s	loc_14B58
		move.w	#0,d0

loc_14B58:
		move.w	d0,$1C(a0)

loc_14B5C:
		move.b	$26(a0),d0
		jsr	GetSine
		muls.w	$1C(a0),d1
		asr.l	#8,d1
		move.w	d1,$18(a0)
		muls.w	$1C(a0),d0
		asr.l	#8,d0
		move.w	d0,$1A(a0)

loc_14B7A:
		btst	#6,$2E(a0)
		bne.w	locret_14C1E
		move.b	$26(a0),d0
		andi.b	#$3F,d0
		beq.s	loc_14B9A
		move.b	$26(a0),d0
		addi.b	#$40,d0
		bmi.w	locret_14C1E

loc_14B9A:
		move.b	#$40,d1
		tst.w	$1C(a0)
		beq.s	locret_14C1E
		bmi.s	loc_14BA8
		neg.w	d1

loc_14BA8:
		move.b	$26(a0),d0
		add.b	d1,d0
		move.w	d0,-(sp)
		jsr	CalcRoomInFront.w
		move.w	(sp)+,d0
		tst.w	d1
		bpl.s	locret_14C1E
		asl.w	#8,d1

		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	loc_14C1A
		cmpi.b	#$40,d0
		beq.s	loc_14C00
		cmpi.b	#$80,d0
		beq.s	loc_14BFA
		add.w	d1,$18(a0)
		move.w	#0,$1C(a0)
		btst	#0,$2A(a0)
		bne.s	locret_14BF8
		bset	#5,$2A(a0)


; ---------------------------------------------------------------------------

locret_14BF8:
		rts


; ---------------------------------------------------------------------------

loc_14BFA:
		sub.w	d1,$1A(a0)
		rts


; ---------------------------------------------------------------------------

loc_14C00:
		sub.w	d1,$18(a0)
		move.w	#0,$1C(a0)
		btst	#0,$2A(a0)
		beq.s	locret_14BF8
		bset	#5,$2A(a0)
		rts

loc_14C1A:
		add.w	d1,$1A(a0)


; End of function Tails_InputAcceleration_Path
; ############### S U B	R O U T	I N E #######################################

locret_14C1E:
		rts

sub_14C20:
		move.w	$1C(a0),d0
		beq.s	loc_14C28
		bpl.s	loc_14C5A

loc_14C28:
		bset	#0,$2A(a0)
		bne.s	loc_14C3C
		bclr	#5,$2A(a0)
		move.b	#1,$21(a0)

loc_14C3C:
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	loc_14C4E
		add.w	d5,d0
		cmp.w	d1,d0
		ble.s	loc_14C4E
		move.w	d1,d0


; ---------------------------------------------------------------------------

loc_14C4E:
		move.w	d0,$1C(a0)
		move.b	#0,$20(a0)
		rts

loc_14C5A:
		sub.w	d4,d0
		bhs.s	loc_14C62
		move.w	#-$80,d0

loc_14C62:
		move.w	d0,$1C(a0)
		move.b	$26(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_14CAA
		cmpi.w	#$400,d0
		blt.s	locret_14CAA
		tst.b	$2D(a0)
		bmi.s	locret_14CAA
		move.w	#$36,d0
		jsr	PlaySFX
		move.b	#$D,$20(a0)
		bclr	#0,$2A(a0)
		cmpi.b	#$C,$2C(a0)
		blo.s	locret_14CAA
		move.b	#6,5(a6)
		move.b	#$15,$22(a6)


; End of function sub_14C20
; ############### S U B	R O U T	I N E #######################################

locret_14CAA:
		rts

sub_14CAC:
		move.w	$1C(a0),d0
		bmi.s	loc_14CE0
		bclr	#0,$2A(a0)
		beq.s	loc_14CC6
		bclr	#5,$2A(a0)
		move.b	#1,$21(a0)

loc_14CC6:
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	loc_14CD4
		sub.w	d5,d0
		cmp.w	d6,d0
		bge.s	loc_14CD4
		move.w	d6,d0


; ---------------------------------------------------------------------------

loc_14CD4:
		move.w	d0,$1C(a0)
		move.b	#0,$20(a0)
		rts

loc_14CE0:
		add.w	d4,d0
		bhs.s	loc_14CE8
		move.w	#$80,d0

loc_14CE8:
		move.w	d0,$1C(a0)
		move.b	$26(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_14D30
		cmpi.w	#-$400,d0
		bgt.s	locret_14D30
		tst.b	$2D(a0)
		bmi.s	locret_14D30
		move.w	#$36,d0
		jsr	PlaySFX
		move.b	#$D,$20(a0)
		bset	#0,$2A(a0)
		cmpi.b	#$C,$2C(a0)
		blo.s	locret_14D30
		move.b	#6,5(a6)
		move.b	#$15,$22(a6)


; End of function sub_14CAC
; ############### S U B	R O U T	I N E #######################################

locret_14D30:
		rts

sub_14D32:
		move.w	(a4),d6
		asl.w	#1,d6
		move.w	2(a4),d5
		asr.w	#1,d5
		tst.b	Super_Tails_Flag.w
		beq.s	loc_14D46
		move.w	#6,d5

loc_14D46:
		move.w	#$20,d4
		tst.b	$3D(a0)
		bmi.w	loc_14DF0
		tst.b	$2B(a0)
		bmi.w	loc_14DF0
		tst.w	$32(a0)
		bne.s	loc_14D78
		btst	#2,Ctrl_2_Held_Logical.w
		beq.s	loc_14D6C
		bsr.w	sub_14E32

loc_14D6C:
		btst	#3,Ctrl_2_Held_Logical.w
		beq.s	loc_14D78
		bsr.w	sub_14E56

loc_14D78:
		move.w	$1C(a0),d0
		beq.s	loc_14D9A
		bmi.s	loc_14D8E
		sub.w	d5,d0
		bhs.s	loc_14D88
		move.w	#0,d0


; ---------------------------------------------------------------------------

loc_14D88:
		move.w	d0,$1C(a0)
		bra.s	loc_14D9A

loc_14D8E:
		add.w	d5,d0
		bhs.s	loc_14D96
		move.w	#0,d0

loc_14D96:
		move.w	d0,$1C(a0)

loc_14D9A:
		move.w	$1C(a0),d0
		bpl.s	loc_14DA2
		neg.w	d0

loc_14DA2:
		cmpi.w	#$80,d0
		bhs.s	loc_14DF0
		tst.b	$3D(a0)
		bne.s	loc_14DDE
		bclr	#2,$2A(a0)
		move.b	$1E(a0),d0
		move.b	$44(a0),$1E(a0)
		move.b	$45(a0),$1F(a0)
		move.b	#5,$20(a0)
		sub.b	$44(a0),d0
		ext.w	d0
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_14DD8
		neg.w	d0


; ---------------------------------------------------------------------------

loc_14DD8:
		add.w	d0,$14(a0)
		bra.s	loc_14DF0

loc_14DDE:
		move.w	#$400,$1C(a0)
		btst	#0,$2A(a0)
		beq.s	loc_14DF0
		neg.w	$1C(a0)

loc_14DF0:
		cmpi.w	#$60,(a5)
		beq.s	loc_14DFC
		bhs.s	loc_14DFA
		addq.w	#4,(a5)

loc_14DFA:
		subq.w	#2,(a5)

loc_14DFC:
		move.b	$26(a0),d0
		jsr	GetSine
		muls.w	$1C(a0),d0
		asr.l	#8,d0
		move.w	d0,$1A(a0)
		muls.w	$1C(a0),d1
		asr.l	#8,d1
		cmpi.w	#$1000,d1
		ble.s	loc_14E20
		move.w	#$1000,d1

loc_14E20:
		cmpi.w	#-$1000,d1
		bge.s	loc_14E2A
		move.w	#-$1000,d1


; End of function sub_14D32
; ############### S U B	R O U T	I N E #######################################

loc_14E2A:
		move.w	d1,$18(a0)
		bra.w	loc_14B7A

sub_14E32:
		move.w	$1C(a0),d0
		beq.s	loc_14E3A
		bpl.s	loc_14E48


; ---------------------------------------------------------------------------

loc_14E3A:
		bset	#0,$2A(a0)
		move.b	#2,$20(a0)
		rts

loc_14E48:
		sub.w	d4,d0
		bhs.s	loc_14E50
		move.w	#-$80,d0


; End of function sub_14E32
; ############### S U B	R O U T	I N E #######################################

loc_14E50:
		move.w	d0,$1C(a0)
		rts


; ---------------------------------------------------------------------------

sub_14E56:
		move.w	$1C(a0),d0
		bmi.s	loc_14E6A
		bclr	#0,$2A(a0)
		move.b	#2,$20(a0)
		rts

loc_14E6A:
		add.w	d4,d0
		bhs.s	loc_14E72
		move.w	#$80,d0


; End of function sub_14E56
; ############### S U B	R O U T	I N E #######################################

loc_14E72:
		move.w	d0,$1C(a0)
		rts

Tails_InputAcceleration_Freespace:
		move.w	(a4),d6
		move.w	2(a4),d5
		asl.w	#1,d5
		btst	#4,$2A(a0)
		bne.s	loc_14ECC
		move.w	$18(a0),d0
		btst	#2,Ctrl_2_Held_Logical.w
		beq.s	loc_14EAC
		bset	#0,$2A(a0)
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	loc_14EAC
		add.w	d5,d0
		cmp.w	d1,d0
		ble.s	loc_14EAC
		move.w	d1,d0

loc_14EAC:
		btst	#3,Ctrl_2_Held_Logical.w
		beq.s	loc_14EC8
		bclr	#0,$2A(a0)
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	loc_14EC8
		sub.w	d5,d0
		cmp.w	d6,d0
		bge.s	loc_14EC8
		move.w	d6,d0

loc_14EC8:
		move.w	d0,$18(a0)

loc_14ECC:
		cmpi.w	#$60,(a5)
		beq.s	loc_14ED8
		bhs.s	loc_14ED6
		addq.w	#4,(a5)

loc_14ED6:
		subq.w	#2,(a5)

loc_14ED8:
		cmpi.w	#-$400,$1A(a0)
		blo.s	locret_14F06
		move.w	$18(a0),d0
		move.w	d0,d1
		asr.w	#5,d1
		beq.s	locret_14F06
		bmi.s	loc_14EFA
		sub.w	d1,d0
		bhs.s	loc_14EF4
		move.w	#0,d0


; ---------------------------------------------------------------------------

loc_14EF4:
		move.w	d0,$18(a0)
		rts

loc_14EFA:
		sub.w	d1,d0
		blo.s	loc_14F02
		move.w	#0,d0

loc_14F02:
		move.w	d0,$18(a0)


; End of function Tails_InputAcceleration_Freespace
; ############### S U B	R O U T	I N E #######################################

locret_14F06:
		rts

Tails_Check_Screen_Boundaries:
		move.l	$10(a0),d1
		move.w	$18(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d1
		swap	d1
		move.w	Camera_min_X.w,d0
		addi.w	#$10,d0
		cmp.w	d1,d0
		bhi.s	loc_14F5C
		move.w	Camera_max_X.w,d0
		addi.w	#$128,d0
		cmp.w	d1,d0
		blo.s	loc_14F5C

loc_14F30:
		tst.b	BG_Layer_Scroll_Timer2+3.w
		bne.s	locret_14F4A
		tst.b	ReverseGravity_Flag.w
		bne.s	loc_14F4C
		move.w	Camera_max_Y.w,d0
		addi.w	#$E0,d0
		cmp.w	$14(a0),d0
		blt.s	loc_14F56


; ---------------------------------------------------------------------------

locret_14F4A:
		rts

loc_14F4C:
		move.w	Camera_min_Y.w,d0
		cmp.w	$14(a0),d0
		blt.s	locret_14F4A


; ---------------------------------------------------------------------------

loc_14F56:
		jmp	KillPlayer2


; End of function Tails_Check_Screen_Boundaries
; ############### S U B	R O U T	I N E #######################################

loc_14F5C:
		move.w	d0,$10(a0)
		move.w	#0,$12(a0)
		move.w	#0,$18(a0)
		move.w	#0,$1C(a0)
		bra.s	loc_14F30

Tails_Spin:
		tst.b	$2B(a0)
		bmi.s	locret_14FA8
		move.b	Ctrl_2_Held_Logical.w,d0
		andi.b	#$C,d0
		bne.s	locret_14FA8
		btst	#1,Ctrl_2_Held_Logical.w
		beq.s	loc_14FAA
		move.w	$1C(a0),d0
		bpl.s	loc_14F94
		neg.w	d0

loc_14F94:
		cmpi.w	#$100,d0
		bhs.s	loc_14FBA
		btst	#3,$2A(a0)
		bne.s	locret_14FA8
		cmp.b	#6,anim(a0)
		beq.s	locret_14FA8
		cmp.b	#$C,anim(a0)
		beq.s	locret_14FA8
		move.b	#8,$20(a0)


; ---------------------------------------------------------------------------

locret_14FA8:
		rts


; ---------------------------------------------------------------------------

loc_14FAA:
		cmpi.b	#8,$20(a0)
		bne.s	locret_14FA8
		move.b	#0,$20(a0)
		rts


; ---------------------------------------------------------------------------

loc_14FBA:
		btst	#2,$2A(a0)
		beq.s	loc_14FC4
		rts

loc_14FC4:
		bset	#2,$2A(a0)
		move.b	#$E,$1E(a0)
		move.b	#7,$1F(a0)
		move.b	#2,$20(a0)
		addq.w	#1,$14(a0)
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_14FEA
		subq.w	#2,$14(a0)

loc_14FEA:
		move.w	#$3C,d0
		jsr	PlaySFX
		tst.w	$1C(a0)
		bne.s	locret_15000
		move.w	#$200,$1C(a0)


; End of function Tails_Spin
; ############### S U B	R O U T	I N E #######################################

locret_15000:
		rts

Obj_Tails_Jump:
		move.b	Ctrl_2_Press_Logical.w,d0
		andi.b	#$70,d0
		beq.w	locret_150D0
		moveq	#0,d0
		move.b	$26(a0),d0
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_15024
		addi.b	#$40,d0
		neg.b	d0
		subi.b	#$40,d0

loc_15024:
		addi.b	#$80,d0
		movem.l	a4-a6,-(sp)
		jsr	CalcRoomOverHead.w
		movem.l	(sp)+,a4-a6
		cmpi.w	#6,d1
		blt.w	locret_150D0
		move.w	#$680,d2
		btst	#6,$2A(a0)
		beq.s	loc_1504C
		move.w	#$380,d2

loc_1504C:
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
		bne.s	loc_150D2
		move.b	#$E,$1E(a0)
		move.b	#7,$1F(a0)
		move.b	#2,$20(a0)
		bset	#2,$2A(a0)
		move.b	$1E(a0),d0
		sub.b	$44(a0),d0
		ext.w	d0
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_150CC
		neg.w	d0

loc_150CC:
		sub.w	d0,$14(a0)


; ---------------------------------------------------------------------------

locret_150D0:
		rts


; End of function Obj_Tails_Jump
; ############### S U B	R O U T	I N E #######################################

loc_150D2:
		bset	#4,$2A(a0)
		rts

Obj_Tails_JumpHeight:
		tst.b	$40(a0)
		beq.s	loc_15106
		move.w	#-$400,d1
		btst	#6,$2A(a0)
		beq.s	loc_150F0
		move.w	#-$200,d1

loc_150F0:
		cmp.w	$1A(a0),d1
		ble.s	Tails_Test_For_Flight
		move.b	Ctrl_2_Held_Logical.w,d0
		andi.b	#$70,d0
		bne.s	locret_15104
		move.w	d1,$1A(a0)


; ---------------------------------------------------------------------------

locret_15104:
		rts

loc_15106:
		tst.b	$3D(a0)
		bne.s	locret_1511A
		cmpi.w	#-$FC0,$1A(a0)
		bge.s	locret_1511A
		move.w	#-$FC0,$1A(a0)


; ---------------------------------------------------------------------------

locret_1511A:
		rts


; ---------------------------------------------------------------------------

Tails_Test_For_Flight:
		tst.b	$2F(a0)
		bne.w	locret_151A2
		move.b	Ctrl_2_Press_Logical.w,d0
		andi.b	#$70,d0
		beq.w	locret_151A2
		cmpi.w	#2,Player_Mode.w
		beq.s	loc_1515C

loc_15156:
		tst.w	Player2_CPU_Control_Counter.w
		beq.s	locret_151A2

loc_1515C:
		btst	#2,$2A(a0)
		beq.s	loc_1518C
		bclr	#2,$2A(a0)
		move.b	$1E(a0),d1
		move.b	$44(a0),$1E(a0)
		move.b	$45(a0),$1F(a0)
		sub.b	$44(a0),d1
		ext.w	d1
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_15188
		neg.w	d0

loc_15188:
		add.w	d1,$14(a0)

loc_1518C:
		bclr	#4,$2A(a0)
		move.b	#1,$2F(a0)
		move.b	#-$10,$25(a0)
		bsr.w	Tails_Set_Flying_Animation


; ---------------------------------------------------------------------------

locret_151A2:
		rts

Tails_Spindash:
		tst.b	$3D(a0)
		bne.s	loc_1527C
		cmpi.b	#8,$20(a0)
		bne.s	locret_1527A
		move.b	Ctrl_2_Press_Logical.w,d0
		andi.b	#$70,d0
		beq.w	locret_1527A
		move.b	#9,$20(a0)
		move.w	#-$55,d0
		jsr	PlaySFX
		addq.l	#4,sp
		move.b	#1,$3D(a0)
		move.w	#0,$3E(a0)
		cmpi.b	#$C,$2C(a0)
		blo.s	loc_15242
		move.b	#2,$20(a6)

loc_15242:
		bsr.w	Tails_Check_Screen_Boundaries
		jsr	Call_Player_AnglePos.w
		tst.b	BG_Layer_Scroll_Timer2+2.w
		beq.s	locret_1527A
		jsr	sub_F846.w
		tst.w	d1
		bmi.w	KillPlayer2
		movem.l	a4-a6,-(sp)
		jsr	ChkWallDist_Left.w
		tst.w	d1
		bpl.s	loc_1526A
		sub.w	d1,$10(a0)

loc_1526A:
		jsr	CheckRightWallDist.w
		tst.w	d1
		bpl.s	loc_15276
		add.w	d1,$10(a0)

loc_15276:
		movem.l	(sp)+,a4-a6


; ---------------------------------------------------------------------------

locret_1527A:
		rts

loc_1527C:
		move.b	Ctrl_2_Held_Logical.w,d0
		btst	#1,d0
		bne.w	loc_15332
		move.b	#$E,$1E(a0)
		move.b	#7,$1F(a0)
		move.b	#2,$20(a0)
		addq.w	#1,$14(a0)
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_152A8
		subq.w	#2,$14(a0)

loc_152A8:
		move.b	#0,$3D(a0)
		moveq	#0,d0
		move.b	$3E(a0),d0
		add.w	d0,d0
		move.w	word_1530E(pc,d0.w),$1C(a0)
		tst.b	Super_Tails_Flag.w
		beq.s	loc_152C8
		move.w	word_15320(pc,d0.w),$1C(a0)

loc_152C8:
		move.w	$1C(a0),d0
		subi.w	#$800,d0
		add.w	d0,d0
		andi.w	#$1F00,d0
		neg.w	d0
		addi.w	#$2000,d0
		cmpa.w	#Object_RAM&$FFFF,a0
		bne.s	.nodelay
		lea	Horiz_Scroll_Delay_Val.w,a1
		move.w	d0,(a1)
.nodelay	btst	#0,$2A(a0)
		beq.s	loc_152F8
		neg.w	$1C(a0)


; ---------------------------------------------------------------------------

loc_152F8:
		bset	#2,$2A(a0)
		move.b	#0,$20(a6)
		moveq	#-$4A,d0
		jsr	PlaySFX
		bra.s	loc_1537A

word_1530E:
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

word_15320:
		dc.w $A00
		dc.w $A80
		dc.w $B00
		dc.w $B80
		dc.w $C00
		dc.w $C80
		dc.w $D00
		dc.w $D80
		dc.w $E00

loc_15332:
		tst.w	$3E(a0)
		beq.s	loc_1534A
		move.w	$3E(a0),d0
		lsr.w	#5,d0
		sub.w	d0,$3E(a0)
		bhs.s	loc_1534A
		move.w	#0,$3E(a0)

loc_1534A:
		move.b	Ctrl_2_Press_Logical.w,d0
		andi.b	#$70,d0
		beq.w	loc_1537A
		move.w	#$900,$20(a0)
		move.w	#$FFAB,d0
		jsr	PlaySFX
		addi.w	#$200,$3E(a0)
		cmpi.w	#$800,$3E(a0)
		blo.s	loc_1537A
		move.w	#$800,$3E(a0)

loc_1537A:
		addq.l	#4,sp
		cmpi.w	#$60,(a5)
		beq.s	loc_15388
		bhs.s	loc_15386
		addq.w	#4,(a5)

loc_15386:
		subq.w	#2,(a5)

loc_15388:
		bsr.w	Tails_Check_Screen_Boundaries
		jsr	Call_Player_AnglePos.w
		tst.b	BG_Layer_Scroll_Timer2+2.w
		beq.s	locret_153C0
		jsr	sub_F846.w
		tst.w	d1
		bmi.w	KillPlayer2
		movem.l	a4-a6,-(sp)
		jsr	ChkWallDist_Left.w
		tst.w	d1
		bpl.s	loc_153B0
		sub.w	d1,$10(a0)

loc_153B0:
		jsr	CheckRightWallDist.w
		tst.w	d1
		bpl.s	loc_153BC
		add.w	d1,$10(a0)

loc_153BC:
		movem.l	(sp)+,a4-a6


; End of function Tails_Spindash
; ############### S U B	R O U T	I N E #######################################

locret_153C0:
		rts

sub_153C2:
		move.l	Primary_Collision.w,Current_Collision.w
		cmpi.b	#$C,$46(a0)
		beq.s	loc_153D6
		move.l	Secondary_Collision.w,Current_Collision.w

loc_153D6:
		move.b	$47(a0),d5
		move.w	$18(a0),d1
		move.w	$1A(a0),d2
		jsr	GetArcTan
		subi.b	#$20,d0
		andi.b	#$C0,d0
		cmpi.b	#$40,d0
		beq.w	loc_154AC
		cmpi.b	#$80,d0
		beq.w	loc_15538
		cmpi.b	#$C0,d0
		beq.w	loc_1559C
		jsr	ChkWallDist_Left.w
		tst.w	d1
		bpl.s	loc_1541A
		sub.w	d1,$10(a0)
		move.w	#0,$18(a0)

loc_1541A:
		jsr	CheckRightWallDist.w
		tst.w	d1
		bpl.s	loc_1542C
		add.w	d1,$10(a0)
		move.w	#0,$18(a0)

loc_1542C:
		jsr	sub_11FD6.w
		tst.w	d1
		bpl.s	locret_154AA
		move.b	$1A(a0),d2
		addq.b	#8,d2
		neg.b	d2
		cmp.b	d2,d1
		bge.s	loc_15444
		cmp.b	d2,d0
		blt.s	locret_154AA

loc_15444:
		move.b	d3,$26(a0)
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_15450
		neg.w	d1


; ---------------------------------------------------------------------------

loc_15450:
		add.w	d1,$14(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	loc_15484
		move.b	d3,d0
		addi.b	#$10,d0
		andi.b	#$20,d0
		beq.s	loc_15472
		asr	$1A(a0)
		bra.s	loc_15498


; ---------------------------------------------------------------------------

loc_15472:
		move.w	#0,$1A(a0)
		move.w	$18(a0),$1C(a0)
		bsr.w	Tails_ResetOnFloor_Spdash
		rts

loc_15484:
		move.w	#0,$18(a0)
		cmpi.w	#$FC0,$1A(a0)
		ble.s	loc_15498
		move.w	#$FC0,$1A(a0)

loc_15498:
		bsr.w	Tails_ResetOnFloor_Spdash
		move.w	$1A(a0),$1C(a0)
		tst.b	d3
		bpl.s	locret_154AA
		neg.w	$1C(a0)


; ---------------------------------------------------------------------------

locret_154AA:
		rts

loc_154AC:
		jsr	ChkWallDist_Left.w
		tst.w	d1
		bpl.s	loc_154C4
		sub.w	d1,$10(a0)
		move.w	#0,$18(a0)
		move.w	$1A(a0),$1C(a0)

loc_154C4:
		jsr	sub_11FEE.w
		tst.w	d1
		bpl.s	loc_15502
		neg.w	d1
		cmpi.w	#$14,d1
		bhs.s	loc_154EE
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_154DC
		neg.w	d1

loc_154DC:
		add.w	d1,$14(a0)
		tst.w	$1A(a0)
		bpl.s	locret_154EC
		move.w	#0,$1A(a0)


; ---------------------------------------------------------------------------

locret_154EC:
		rts

loc_154EE:
		jsr	CheckRightWallDist.w
		tst.w	d1
		bpl.s	locret_15500
		add.w	d1,$10(a0)
		move.w	#0,$18(a0)


; ---------------------------------------------------------------------------

locret_15500:
		rts

loc_15502:
		tst.b	Player2_OnWater_Flag.w
		bne.s	loc_1550E
		tst.w	$1A(a0)
		bmi.s	locret_15536

loc_1550E:
		jsr	sub_11FD6.w
		tst.w	d1
		bpl.s	locret_15536
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_1551E
		neg.w	d1

loc_1551E:
		add.w	d1,$14(a0)
		move.b	d3,$26(a0)
		move.w	#0,$1A(a0)
		move.w	$18(a0),$1C(a0)
		bsr.w	Tails_ResetOnFloor_Spdash


; ---------------------------------------------------------------------------

locret_15536:
		rts

loc_15538:
		jsr	ChkWallDist_Left.w
		tst.w	d1
		bpl.s	loc_1554A
		sub.w	d1,$10(a0)
		move.w	#0,$18(a0)

loc_1554A:
		jsr	CheckRightWallDist.w
		tst.w	d1
		bpl.s	loc_1555C
		add.w	d1,$10(a0)
		move.w	#0,$18(a0)

loc_1555C:
		jsr	sub_11FEE.w
		tst.w	d1
		bpl.s	locret_1559A
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_1556C
		neg.w	d1


; ---------------------------------------------------------------------------

loc_1556C:
		sub.w	d1,$14(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	loc_15584
		move.w	#0,$1A(a0)
		rts

loc_15584:
		move.b	d3,$26(a0)
		bsr.w	Tails_ResetOnFloor_Spdash
		move.w	$1A(a0),$1C(a0)
		tst.b	d3
		bpl.s	locret_1559A
		neg.w	$1C(a0)


; ---------------------------------------------------------------------------

locret_1559A:
		rts

loc_1559C:
		jsr	CheckRightWallDist.w
		tst.w	d1
		bpl.s	loc_155B4
		add.w	d1,$10(a0)
		move.w	#0,$18(a0)
		move.w	$1A(a0),$1C(a0)

loc_155B4:
		jsr	sub_11FEE.w
		tst.w	d1
		bpl.s	loc_155D6
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_155C4
		neg.w	d1

loc_155C4:
		sub.w	d1,$14(a0)
		tst.w	$1A(a0)
		bpl.s	locret_155D4
		move.w	#0,$1A(a0)

locret_155D4:
		rts
; ---------------------------------------------------------------------------

loc_155D6:
		tst.b	Player2_OnWater_Flag.w
		bne.s	loc_155E2
		tst.w	$1A(a0)
		bmi.s	locret_1560A

loc_155E2:
		jsr	sub_11FD6.w
		tst.w	d1
		bpl.s	locret_1560A
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_155F2
		neg.w	d1

loc_155F2:
		add.w	d1,$14(a0)
		move.b	d3,$26(a0)
		move.w	#0,$1A(a0)
		move.w	$18(a0),$1C(a0)
		bsr.w	Tails_ResetOnFloor_Spdash

locret_1560A:
		rts
; ---------------------------------------------------------------------------

Tails_ResetOnFloor_Spdash:
		tst.b	spindash(a0)
		bne.s	Tails_ResetOnFloor_Com		; branch if spindashing
		move.b	#0,anim(a0)			; set to walking animation

Tails_ResetOnFloor:
		move.b	yrad(a0),d0			; get y-radius
		move.b	yraddef(a0),yrad(a0)		; set to default y-radius
		move.b	xraddef(a0),xrad(a0)		; set to default x-radius
		btst	#2,status(a0)
		beq.s	Tails_ResetOnFloor_Com		; branch if not jumping/rolling

		bclr	#2,status(a0)			; clear jumping/rolling bit (could have done this instead of btst)
		move.b	#0,anim(a0)			; set to walking animation
		sub.b	yraddef(a0),d0			; sub default y-radius from y-radius
		ext.w	d0				; extend to word
		tst.b	ReverseGravity_Flag.w
		beq.s	.norev				; branch if reverse gravity isn't active
		neg.w	d0				; negate offset
.norev		move.w	d0,-(sp)			; store offset

		move.b	angle(a0),d0			; get angle
		addi.b	#$40,d0				; ad 90 degrees to it
		bpl.s	.fixypos			; if positive (-90 to 90 degrees)
		neg.w	(sp)				; negate offset
.fixypos	move.w	(sp)+,d0			; get the offset now
		add.w	d0,ypos(a0)			; add to y-pos

Tails_ResetOnFloor_Com:
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
		rts
; ---------------------------------------------------------------------------

loc_1569C:
		cmpi.w	#2,Player_Mode.w
		bne.s	loc_156BE
		tst.w	Debug_Mode_Flag.w
		beq.s	loc_156BE
		btst	#4,Ctrl_1_Press.w
		beq.s	loc_156BE
		move.w	#1,Debug_Routine.w
		clr.b	Control_Locked.w
		rts

loc_156BE:
		tst.b	Player2_Carrying.w
		beq.s	loc_156D6
		lea	Object_RAM.w,a1
		clr.b	$2E(a1)
		bset	#1,$2A(a1)
		clr.w	Player2_Carrying.w

loc_156D6:
		jsr	ObjectRevMove
		addi.w	#$30,$1A(a0)
		btst	#6,$2A(a0)
		beq.s	loc_156F0
		subi.w	#$20,$1A(a0)

loc_156F0:
		cmpi.w	#-$100,Camera_min_Y.w
		bne.s	loc_15700
		move.w	Screen_Y_wrap_value.w,d0
		and.w	d0,$14(a0)


; ############### S U B	R O U T	I N E #######################################

loc_15700:
		bsr.w	sub_15716
		bsr.w	Tails_Check_Screen_Boundaries
		bsr.w	sub_10D66
		bsr.w	sub_15842
		jmp	DrawSprite


; ---------------------------------------------------------------------------

sub_15716:
		tst.b	BG_Layer_Scroll_Timer2+3.w
		bne.s	loc_15742
		tst.b	ReverseGravity_Flag.w
		bne.s	loc_15734
		move.w	Camera_max_Y.w,d0
		addi.w	#$E0,d0
		cmp.w	$14(a0),d0
		blt.w	loc_15788
		bra.s	loc_15742


; ---------------------------------------------------------------------------

loc_15734:
		move.w	Camera_min_Y.w,d0
		cmp.w	$14(a0),d0
		blt.s	loc_15742
		bra.w	loc_15788

loc_15742:
		movem.l	a4-a6,-(sp)
		bsr.w	sub_153C2
		movem.l	(sp)+,a4-a6
		btst	#1,$2A(a0)
		bne.s	locret_15786
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

locret_15786:
		rts


; End of function sub_15716
; ---------------------------------------------------------------------------

loc_15788:
		jmp	KillPlayer2


; ---------------------------------------------------------------------------

loc_1578E:
		cmpi.w	#2,Player_Mode.w
		bne.s	loc_157B0
		tst.w	Debug_Mode_Flag.w
		beq.s	loc_157B0
		btst	#4,Ctrl_1_Press.w
		beq.s	loc_157B0
		move.w	#1,Debug_Routine.w
		clr.b	Control_Locked.w
		rts

loc_157B0:
		tst.b	Player2_Carrying.w
		beq.s	loc_157C8
		lea	Object_RAM.w,a1
		clr.b	$2E(a1)
		bset	#1,$2A(a1)
		clr.w	Player2_Carrying.w


; ---------------------------------------------------------------------------

loc_157C8:
		bsr.w	sub_123C2
		jsr	ObjectGravity
		bsr.w	sub_10D66
		bsr.w	sub_15842
		jmp	DrawSprite

loc_157E0:
		tst.w	$3E(a0)
		beq.s	locret_157F2
		subq.w	#1,$3E(a0)
		bne.s	locret_157F2
		st	Level_Restart_Flag.w


; ---------------------------------------------------------------------------

locret_157F2:
		rts

loc_157F4:
		tst.w	Camera_X_Pos_Diff.w
		bne.s	loc_15806
		tst.w	Camera_Y_Pos_Diff.w
		bne.s	loc_15806
		move.b	#2,5(a0)


; ---------------------------------------------------------------------------

loc_15806:
		bsr.w	sub_15842
		jmp	DrawSprite

loc_15810:
		tst.b	Player2_Carrying.w
		beq.s	loc_15828
		lea	Object_RAM.w,a1
		clr.b	$2E(a1)
		bset	#1,$2A(a1)
		clr.w	Player2_Carrying.w


; ############### S U B	R O U T	I N E #######################################

loc_15828:
		jsr	ObjectRevMove
		addi.w	#$10,$1A(a0)
		bsr.w	sub_10D66
		bsr.w	sub_15842
		jmp	DrawSprite

sub_15842:
		bsr.s	Animate_Tails
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_15856
		eori.b	#2,4(a0)


; ---------------------------------------------------------------------------

loc_15856:
		bra.w	Tails_Load_PLC


Animate_Tails:
		lea	AniTails,a1

loc_15868:
		moveq	#0,d0
		move.b	$20(a0),d0
		cmp.b	$21(a0),d0
		beq.s	loc_1588A
		move.b	d0,$21(a0)
		move.b	#0,$23(a0)
		move.b	#0,$24(a0)
		bclr	#5,$2A(a0)


; End of function Animate_Tails
; ############### S U B	R O U T	I N E #######################################

loc_1588A:
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),d0
		bmi.s	loc_158FA
		move.b	$2A(a0),d1
		andi.b	#1,d1
		andi.b	#-4,4(a0)
		or.b	d1,4(a0)
		subq.b	#1,$24(a0)
		bpl.s	locret_158C8
		move.b	d0,$24(a0)

sub_158B0:
		moveq	#0,d1
		move.b	$23(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-4,d0
		bhs.s	loc_158CA

loc_158C0:
		move.b	d0,$22(a0)
		addq.b	#1,$23(a0)


; ---------------------------------------------------------------------------

locret_158C8:
		rts


; ---------------------------------------------------------------------------

loc_158CA:
		addq.b	#1,d0
		bne.s	loc_158DA
		move.b	#0,$23(a0)
		move.b	1(a1),d0
		bra.s	loc_158C0


; ---------------------------------------------------------------------------

loc_158DA:
		addq.b	#1,d0
		bne.s	loc_158EE
		move.b	2(a1,d1.w),d0
		sub.b	d0,$23(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	loc_158C0

loc_158EE:
		addq.b	#1,d0
		bne.s	locret_158F8
		move.b	2(a1,d1.w),$20(a0)


; End of function sub_158B0
; ---------------------------------------------------------------------------

locret_158F8:
		rts

loc_158FA:
		addq.b	#1,d0
		bne.w	loc_159C8
		moveq	#0,d0
		tst.b	$2D(a0)
		bmi.w	loc_127C0
		move.b	$27(a0),d0
		bne.w	loc_127C0
		moveq	#0,d1
		move.b	$26(a0),d0
		bmi.s	loc_1591E
		beq.s	loc_1591E
		subq.b	#1,d0

loc_1591E:
		move.b	$2A(a0),d2
		andi.b	#1,d2
		bne.s	loc_1592A
		not.b	d0

loc_1592A:
		addi.b	#$10,d0
		bpl.s	loc_15932
		moveq	#3,d1

loc_15932:
		andi.b	#-4,4(a0)
		eor.b	d1,d2
		or.b	d2,4(a0)
		btst	#5,$2A(a0)
		bne.w	loc_15A14
		lsr.b	#4,d0
		andi.b	#6,d0
		move.w	$1C(a0),d2
		bpl.s	loc_15956
		neg.w	d2

loc_15956:
		tst.b	$2B(a0)
		bpl.w	loc_15960
		add.w	d2,d2

loc_15960:
		move.b	d0,d3
		add.b	d3,d3
		add.b	d3,d3
		lea	AniTails00,a1
		cmpi.w	#$600,d2
		blo.s	loc_1598A
		lea	AniTails01,a1
		move.b	d0,d3
		add.b	d3,d3
		cmpi.w	#$700,d2
		blo.s	loc_1598A
		lea	AniTails1F,a1
		move.b	d0,d3

loc_1598A:
		moveq	#0,d1
		move.b	$23(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	loc_159A4
		move.b	#0,$23(a0)
		move.b	1(a1),d0

loc_159A4:
		move.b	d0,$22(a0)
		add.b	d3,$22(a0)
		subq.b	#1,$24(a0)
		bpl.s	locret_159C6
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	loc_159BC
		moveq	#0,d2

loc_159BC:
		lsr.w	#8,d2
		move.b	d2,$24(a0)
		addq.b	#1,$23(a0)


; ---------------------------------------------------------------------------

locret_159C6:
		rts

loc_159C8:
		addq.b	#1,d0
		bne.s	loc_15A3C
		move.b	$2A(a0),d1
		andi.b	#1,d1
		andi.b	#-4,4(a0)
		or.b	d1,4(a0)
		subq.b	#1,$24(a0)
		bpl.w	locret_158C8
		move.w	$1C(a0),d2
		bpl.s	loc_159EE
		neg.w	d2

loc_159EE:
		lea	AniTails03,a1
		cmpi.w	#$600,d2
		bhs.s	loc_15A00
		lea	AniTails02,a1

loc_15A00:
		neg.w	d2
		addi.w	#$400,d2
		bpl.s	loc_15A0A
		moveq	#0,d2


; ---------------------------------------------------------------------------

loc_15A0A:
		lsr.w	#8,d2
		move.b	d2,$24(a0)
		bra.w	sub_158B0

loc_15A14:
		subq.b	#1,$24(a0)
		bpl.w	locret_158C8
		move.w	$1C(a0),d2
		bmi.s	loc_15A24
		neg.w	d2

loc_15A24:
		addi.w	#$800,d2
		bpl.s	loc_15A2C
		moveq	#0,d2


; ---------------------------------------------------------------------------

loc_15A2C:
		lsr.w	#6,d2
		move.b	d2,$24(a0)
		lea	AniTails04,a1
		bra.w	sub_158B0

loc_15A3C:
		subq.b	#1,$24(a0)
		bpl.w	locret_158C8
		move.w	$18(a2),d1
		move.w	$1A(a2),d2
		jsr	GetArcTan

		moveq	#0,d1
		move.b	$2A(a0),d2
		andi.b	#1,d2
		bne.s	loc_15A6E
		not.b	d0
		bra.s	loc_15A72

loc_15A6E:
		addi.b	#$80,d0

loc_15A72:
		addi.b	#$10,d0
		bpl.s	loc_15A7A
		moveq	#3,d1

loc_15A7A:
		andi.b	#-4,4(a0)
		eor.b	d1,d2
		or.b	d2,4(a0)
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_15A92
		eori.b	#2,4(a0)


; ---------------------------------------------------------------------------

loc_15A92:
		lsr.b	#3,d0
		andi.b	#$C,d0
		move.b	d0,d3
		lea	AniTails_Tail03,a1
		move.b	#3,$24(a0)
		bsr.w	sub_158B0
		add.b	d3,$22(a0)
		rts

; ---------------------------------------------------------------------------
AniTails:	include "levels/Players/Tails/Ani.asm"
; ---------------------------------------------------------------------------

Tails_Tail_Load_PLC:
		moveq	#0,d0
		move.b	$22(a0),d0
		cmp.b	TailsTails_Current_Frame.w,d0
		beq.w	locret_15CCE
		move.b	d0,TailsTails_Current_Frame.w
		lea	DPLC_Tails_Tail,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_15CCE
		move.w	#-$2A00,d4
		move.l	#Art_Tails_Tail,d6
		bra.s	loc_15CA6

Tails_Load_PLC:
		moveq	#0,d0
		move.b	$22(a0),d0

Tails_Load_PLC2:
		cmp.b	Player2_Current_Frame.w,d0
		beq.s	locret_15CCE
		move.b	d0,Player2_Current_Frame.w
		lea	DPLC_Tails,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_15CCE
		move.w	#$D400,d4
		move.l	#Art_Tails,d6
		cmpi.w	#$1A2,d0
		blo.s	loc_15CA6
		move.l	#Art_Tails_Extra,d6

loc_15CA6:
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
		dbf	d5,loc_15CA6


; End of function Tails_Load_PLC
; ############### S U B	R O U T	I N E #######################################

locret_15CCE:
		rts

Obj_Tails_Tail:
		move.l	#Map_Tails_Tail,$C(a0)
		move.w	#$6B0,$A(a0)
		move.w	#$100,8(a0)
		move.b	#$18,7(a0)
		move.b	#$18,6(a0)
		move.b	#4,4(a0)
		move.l	#loc_160D2,(a0)

loc_160D2:
		movea.w	$30(a0),a2
		move.b	$26(a2),$26(a0)
		move.b	$2A(a2),$2A(a0)
		move.w	$10(a2),$10(a0)
		move.w	$14(a2),$14(a0)
		move.w	8(a2),8(a0)
		andi.w	#$7FFF,$A(a0)
		tst.w	$A(a2)
		bpl.s	loc_16106
		ori.w	#$8000,$A(a0)

loc_16106:
		moveq	#0,d0
		move.b	$20(a2),d0
		btst	#5,$2A(a2)
		beq.s	loc_1612C
		tst.b	Player2_OnWater_Flag.w
		bne.s	loc_1612C
		cmpi.b	#$A9,$22(a2)
		blo.s	loc_1612C
		cmpi.b	#$AC,$22(a2)
		bhi.s	loc_1612C
		moveq	#4,d0

loc_1612C:
		cmp.b	$34(a0),d0
		beq.s	loc_1613C
		move.b	d0,$34(a0)
		move.b	byte_16164(pc,d0.w),$20(a0)

loc_1613C:
		lea	AniTails_Tail,a1
		bsr.w	loc_15868
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_1615A
		cmpi.b	#3,$20(a0)
		beq.s	loc_1615A
		eori.b	#2,4(a0)


; ---------------------------------------------------------------------------

loc_1615A:
		bsr.w	Tails_Tail_Load_PLC
		jmp	DrawSprite

byte_16164:
		dc.b 0,   0,	  3,   3,   9,	 1,   0,   2,	1,   7,	  0,   0,   0,	 8,   0,   0
		dc.b 	0,   0,	  0,   0,  $A,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0
		dc.b   $B,  $C,	 $B,  $C,  $B,	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0,   0
		dc.b 	0,   0

AniTails_Tail:
		dc.w AniTails_Tail00-AniTails_Tail
		dc.w AniTails_Tail01-AniTails_Tail
		dc.w AniTails_Tail02-AniTails_Tail
		dc.w AniTails_Tail03-AniTails_Tail
		dc.w AniTails_Tail04-AniTails_Tail
		dc.w AniTails_Tail05-AniTails_Tail
		dc.w AniTails_Tail06-AniTails_Tail
		dc.w AniTails_Tail07-AniTails_Tail
		dc.w AniTails_Tail08-AniTails_Tail
		dc.w AniTails_Tail09-AniTails_Tail
		dc.w AniTails_Tail0A-AniTails_Tail
		dc.w AniTails_Tail0B-AniTails_Tail
		dc.w AniTails_Tail0C-AniTails_Tail

AniTails_Tail00:
		dc.b  $20,   0,	$FF

AniTails_Tail01:
		dc.b	7, $22,	$23, $24, $25, $26, $FF

AniTails_Tail02:
		dc.b	3, $22,	$23, $24, $25, $26, $FD,   1

AniTails_Tail03:
		dc.b  $FC,   5,	  6,   7,   8, $FF

AniTails_Tail04:
		dc.b	3,   9,	 $A,  $B,  $C, $FF

AniTails_Tail05:
		dc.b	3,  $D,	 $E,  $F, $10, $FF

AniTails_Tail06:
		dc.b	3, $11,	$12, $13, $14, $FF

AniTails_Tail07:
		dc.b	2,   1,	  2,   3,   4, $FF

AniTails_Tail08:
		dc.b	2, $1A,	$1B, $1C, $1D, $FF

AniTails_Tail09:
		dc.b	9, $1E,	$1F, $20, $21, $FF

AniTails_Tail0A:
		dc.b	9, $29,	$2A, $2B, $2C, $FF

AniTails_Tail0B:
		dc.b	1, $27,	$28, $FF


; ---------------------------------------------------------------------------

AniTails_Tail0C:
		dc.b	0, $27,	$28, $FF
