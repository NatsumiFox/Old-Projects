; ---------------------------------------------------------------------------
; Object - Boss (SLZ3)
; ---------------------------------------------------------------------------
SLZ3_Boss:					; XREF: Obj_Index
Obj7A:					; XREF: Obj_Index
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	Obj7A_Index(pc,d0.w),d1
		jmp	Obj7A_Index(pc,d1.w)
; ===========================================================================
Obj7A_Index:	dc.w Obj7A_Main-Obj7A_Index
		dc.w Obj7A_ShipMain-Obj7A_Index
		dc.w Obj7A_FaceMain-Obj7A_Index
		dc.w Obj7A_FlameMain-Obj7A_Index
		dc.w Obj7A_TubeMain-Obj7A_Index

Obj7A_ObjData:	dc.b 2,	0, 4		; routine number, animation, priority
		dc.b 4,	1, 4
		dc.b 6,	7, 4
		dc.b 8,	0, 3
; ===========================================================================

Obj7A_Main:				; XREF: Obj7A_Index
		move.w	#$2188,X_pos(a0)
		move.w	#$228,Y_Pos(a0)
		move.w	X_pos(a0),Off30(a0)
		move.w	Y_Pos(a0),Off38(a0)
		move.b	#$F,Coll(a0)
		move.b	#8,Coll2(a0)	; set number of	hits to	8
		lea	Obj7A_ObjData(pc),a2
		movea.l	a0,a1
		moveq	#3,d1
		bra.s	Obj7A_LoadBoss
; ===========================================================================

Obj7A_Loop:
		jsr	SingleObjLoad2
		bne.s	loc_1895C
		move.b	#$7A,0(a1)
		move.w	X_pos(a0),X_pos(a1)
		move.w	Y_Pos(a0),Y_Pos(a1)

Obj7A_LoadBoss:				; XREF: Obj7A_Main
		bclr	#0,Status(a0)
		clr.b	Routine2(a1)
		move.b	(a2)+,Routine(a1)
		move.b	(a2)+,Anim(a1)
		move.b	(a2)+,Priority(a1)
		move.l	#Map_Eggman,Mappings_Offset(a1)
		move.w	#$400,Art_Tile(a1)
		move.b	#4,Render_Flags(a1)
		move.b	#$20,X_Visible(a1)
		move.l	a0,Off34(a1)
		dbf	d1,Obj7A_Loop	; repeat sequence 3 more times

loc_1895C:
		lea	($FFFFD040).w,a1
		lea	$2A(a0),a2
		moveq	#$5E,d0
		moveq	#$3E,d1

loc_18968:
		cmp.b	(a1),d0
		bne.s	loc_18974
		tst.b	Subtype(a1)
		beq.s	loc_18974
		move.w	a1,(a2)+

loc_18974:
		adda.w	#$40,a1
		dbf	d1,loc_18968

Obj7A_ShipMain:				; XREF: Obj7A_Index
		moveq	#0,d0
		move.b	Routine2(a0),d0
		move.w	Obj7A_ShipIndex(pc,d0.w),d0
		jsr	Obj7A_ShipIndex(pc,d0.w)
		lea	(Ani_Eggman).l,a1
		jsr	AnimateSprite
		moveq	#3,d0
		and.b	Status(a0),d0
		andi.b	#$FC,Render_Flags(a0)
		or.b	d0,Render_Flags(a0)
		jmp	DisplaySprite
; ===========================================================================
Obj7A_ShipIndex:dc.w loc_189B8-Obj7A_ShipIndex
		dc.w loc_18A5E-Obj7A_ShipIndex
		dc.w Obj7A_MakeBall-Obj7A_ShipIndex
		dc.w loc_18B48-Obj7A_ShipIndex
		dc.w loc_18B80-Obj7A_ShipIndex
		dc.w loc_18BC6-Obj7A_ShipIndex
; ===========================================================================

loc_189B8:				; XREF: Obj7A_ShipIndex
		move.w	#-$100,X_Vel(a0)
		cmpi.w	#$2120,Off30(a0)
		bcc.s	loc_189CA
		addq.b	#2,Routine2(a0)

loc_189CA:
		bsr.w	BossMove
		move.b	Off3F(a0),d1
		addq.b	#2,Off3F(a0)
		jsr	(CalcSine).l
		asr.w	#6,d0
		add.w	Off38(a0),d0
		move.w	d0,Y_Pos(a0)
		move.w	Off30(a0),X_pos(a0)
		bra.s	loc_189FE
; ===========================================================================

loc_189EE:
		bsr.w	BossMove
		move.w	Off38(a0),Y_Pos(a0)
		move.w	Off30(a0),X_pos(a0)

loc_189FE:
		cmpi.b	#6,Routine2(a0)
		bcc.s	locret_18A44
		tst.b	Status(a0)
		bmi.s	loc_18A46
		tst.b	Coll(a0)
		bne.s	locret_18A44
		tst.b	Off3E(a0)
		bne.s	loc_18A28
		move.b	#$20,Off3E(a0)
		move.w	#$AC,d0
		jsr	(PlaySound).l ;	play boss damage sound

loc_18A28:
		lea	($FFFFFB22).w,a1
		moveq	#0,d0
		tst.w	(a1)
		bne.s	loc_18A36
		move.w	#$EEE,d0

loc_18A36:
		move.w	d0,(a1)
		subq.b	#1,Off3E(a0)
		bne.s	locret_18A44
		move.b	#$F,Coll(a0)

locret_18A44:
		rts
; ===========================================================================

loc_18A46:
		moveq	#100,d0
		bsr.w	AddPoints
		move.b	#6,Routine2(a0)
		move.b	#$78,Off3C(a0)
		clr.w	X_Vel(a0)
		rts
; ===========================================================================

loc_18A5E:				; XREF: Obj7A_ShipIndex
		move.w	Off30(a0),d0
		move.w	#$200,X_Vel(a0)
		btst	#0,Status(a0)
		bne.s	loc_18A7C
		neg.w	X_Vel(a0)
		cmpi.w	#$2008,d0
		bgt.s	loc_18A88
		bra.s	loc_18A82
; ===========================================================================

loc_18A7C:
		cmpi.w	#$2138,d0
		blt.s	loc_18A88

loc_18A82:
		bchg	#0,Status(a0)

loc_18A88:
		move.w	X_pos(a0),d0
		moveq	#-1,d1
		moveq	#2,d2
		lea	$2A(a0),a2
		moveq	#$28,d4
		tst.w	X_Vel(a0)
		bpl.s	loc_18A9E
		neg.w	d4

loc_18A9E:
		move.w	(a2)+,d1
		movea.l	d1,a3
		btst	#3,Status(a3)
		bne.s	loc_18AB4
		move.w	X_pos(a3),d3
		add.w	d4,d3
		sub.w	d0,d3
		beq.s	loc_18AC0

loc_18AB4:
		dbf	d2,loc_18A9E

		move.b	d2,Subtype(a0)
		bra.w	loc_189CA
; ===========================================================================

loc_18AC0:
		move.b	d2,Subtype(a0)
		addq.b	#2,Routine2(a0)
		move.b	#$28,Off3C(a0)
		bra.w	loc_189CA
; ===========================================================================

Obj7A_MakeBall:				; XREF: Obj7A_ShipIndex
		cmpi.b	#$28,Off3C(a0)
		bne.s	loc_18B36
		moveq	#-1,d0
		move.b	Subtype(a0),d0
		ext.w	d0
		bmi.s	loc_18B40
		subq.w	#2,d0
		neg.w	d0
		add.w	d0,d0
		lea	$2A(a0),a1
		move.w	(a1,d0.w),d0
		movea.l	d0,a2
		lea	($FFFFD040).w,a1
		moveq	#$3E,d1

loc_18AFA:
		cmp.l	Off3C(a1),d0
		beq.s	loc_18B40
		adda.w	#$40,a1
		dbf	d1,loc_18AFA

		move.l	a0,-(sp)
		lea	(a2),a0
		jsr	SingleObjLoad2
		movea.l	(sp)+,a0
		bne.s	loc_18B40
		move.b	#$7B,(a1)	; load spiked ball object
		move.w	X_pos(a0),X_pos(a1)
		move.w	Y_Pos(a0),Y_Pos(a1)
		addi.w	#$20,Y_Pos(a1)
		move.b	Status(a2),Status(a1)
		move.l	a2,Off3C(a1)

loc_18B36:
		subq.b	#1,Off3C(a0)
		beq.s	loc_18B40
		bra.w	loc_189FE
; ===========================================================================

loc_18B40:
		subq.b	#2,Routine2(a0)
		bra.w	loc_189CA
; ===========================================================================

loc_18B48:				; XREF: Obj7A_ShipIndex
		subq.b	#1,Off3C(a0)
		bmi.s	loc_18B52
		bra.w	BossDefeated
; ===========================================================================

loc_18B52:
		addq.b	#2,Routine2(a0)
		clr.w	Y_Vel(a0)
		bset	#0,Status(a0)
		bclr	#7,Status(a0)
		clr.w	X_Vel(a0)
		move.b	#-$18,Off3C(a0)
		tst.b	($FFFFF7A7).w
		bne.s	loc_18B7C
		move.b	#1,($FFFFF7A7).w

loc_18B7C:
		bra.w	loc_189FE
; ===========================================================================

loc_18B80:				; XREF: Obj7A_ShipIndex
		addq.b	#1,Off3C(a0)
		beq.s	loc_18B90
		bpl.s	loc_18B96
		addi.w	#$18,Y_Vel(a0)
		bra.s	loc_18BC2
; ===========================================================================

loc_18B90:
		clr.w	Y_Vel(a0)
		bra.s	loc_18BC2
; ===========================================================================

loc_18B96:
		cmpi.b	#$20,Off3C(a0)
		bcs.s	loc_18BAE
		beq.s	loc_18BB4
		cmpi.b	#$2A,Off3C(a0)
		bcs.s	loc_18BC2
		addq.b	#2,Routine2(a0)
		bra.s	loc_18BC2
; ===========================================================================

loc_18BAE:
		subq.w	#8,Y_Vel(a0)
		bra.s	loc_18BC2
; ===========================================================================

loc_18BB4:
		clr.w	Y_Vel(a0)
		moveq	#$FFFFFFE0,d0
		jsr	PlayMusic		; fade music out

loc_18BC2:
		bra.w	loc_189EE
; ===========================================================================

loc_18BC6:				; XREF: Obj7A_ShipIndex
		move.w	#$400,X_Vel(a0)
		move.w	#-$40,Y_Vel(a0)
		cmpi.w	#$2160,($FFFFF72A).w
		bcc.s	loc_18BE0
		addq.w	#2,($FFFFF72A).w
		bra.s	loc_18BE8
; ===========================================================================

loc_18BE0:
		tst.b	Render_Flags(a0)
		bpl.w	Obj7A_Delete

loc_18BE8:
		bsr.w	BossMove
		bra.w	loc_189CA
; ===========================================================================

Obj7A_FaceMain:				; XREF: Obj7A_Index
		moveq	#0,d0
		moveq	#1,d1
		movea.l	Off34(a0),a1
		move.b	Routine2(a1),d0
		cmpi.b	#6,d0
		bmi.s	loc_18C06
		moveq	#$A,d1
		bra.s	loc_18C1A
; ===========================================================================

loc_18C06:
		tst.b	Coll(a1)
		bne.s	loc_18C10
		moveq	#5,d1
		bra.s	loc_18C1A
; ===========================================================================

loc_18C10:
		cmpi.b	#4,Object_RAM+Routine
		bcs.s	loc_18C1A
		moveq	#4,d1

loc_18C1A:
		move.b	d1,Anim(a0)
		cmpi.b	#$A,d0
		bne.s	loc_18C32
		move.b	#6,Anim(a0)
		tst.b	Render_Flags(a0)
		bpl.w	Obj7A_Delete

loc_18C32:
		bra.s	loc_18C6C
; ===========================================================================

Obj7A_FlameMain:			; XREF: Obj7A_Index
		move.b	#8,Anim(a0)
		movea.l	Off34(a0),a1
		cmpi.b	#$A,Routine2(a1)
		bne.s	loc_18C56
		tst.b	Render_Flags(a0)
		bpl.w	Obj7A_Delete
		move.b	#$B,Anim(a0)
		bra.s	loc_18C6C
; ===========================================================================

loc_18C56:
		cmpi.b	#8,Routine2(a1)
		bgt.s	loc_18C6C
		cmpi.b	#4,Routine2(a1)
		blt.s	loc_18C6C
		move.b	#7,Anim(a0)

loc_18C6C:
		lea	(Ani_Eggman).l,a1
		jsr	AnimateSprite

loc_18C78:
		movea.l	Off34(a0),a1
		move.w	X_pos(a1),X_pos(a0)
		move.w	Y_Pos(a1),Y_Pos(a0)
		move.b	Status(a1),Status(a0)
		moveq	#3,d0
		and.b	Status(a0),d0
		andi.b	#-4,Render_Flags(a0)
		or.b	d0,Render_Flags(a0)
		jmp	DisplaySprite
; ===========================================================================

Obj7A_TubeMain:				; XREF: Obj7A_Index
		movea.l	Off34(a0),a1
		cmpi.b	#$A,Routine2(a1)
		bne.s	loc_18CB8
		tst.b	Render_Flags(a0)
		bpl.w	Obj7A_Delete

loc_18CB8:
		move.l	#Map_BossItems,Mappings_Offset(a0)
		move.w	#$246C,Art_Tile(a0)
		move.b	#3,Anim_Frame(a0)
		bra.s	loc_18C78
; ===========================================================================
; ---------------------------------------------------------------------------
; Object 7B - exploding	spikeys	that Eggman drops (SLZ)
; ---------------------------------------------------------------------------

Obj7B:					; XREF: Obj_Index
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	Obj7B_Index(pc,d0.w),d0
		jsr	Obj7B_Index(pc,d0.w)
		move.w	Off30(a0),d0
		andi.w	#$FF80,d0
		move.w	($FFFFF700).w,d1
		subi.w	#$80,d1
		andi.w	#$FF80,d1
		sub.w	d1,d0
		bmi.w	Obj7A_Delete
		cmpi.w	#$280,d0
		bhi.w	Obj7A_Delete
		jmp	DisplaySprite
; ===========================================================================
Obj7B_Index:	dc.w Obj7B_Main-Obj7B_Index
		dc.w Obj7B_Fall-Obj7B_Index
		dc.w loc_18DC6-Obj7B_Index
		dc.w loc_18EAA-Obj7B_Index
		dc.w Obj7B_Explode-Obj7B_Index
		dc.w Obj7B_MoveFrag-Obj7B_Index
; ===========================================================================

Obj7B_Main:				; XREF: Obj7B_Index
		move.l	#Map_obj5Ea,Mappings_Offset(a0)
		move.w	#$518,Art_Tile(a0)
		move.b	#1,Anim_Frame(a0)
		ori.b	#4,Render_Flags(a0)
		move.b	#4,Priority(a0)
		move.b	#$8B,Coll(a0)
		move.b	#$C,X_Visible(a0)
		movea.l	Off3C(a0),a1
		move.w	X_pos(a1),Off30(a0)
		move.w	Y_Pos(a1),Off34(a0)
		bset	#0,Status(a0)
		move.w	X_pos(a0),d0
		cmp.w	X_pos(a1),d0
		bgt.s	loc_18D68
		bclr	#0,Status(a0)
		move.b	#2,Off3A(a0)

loc_18D68:
		addq.b	#2,Routine(a0)

Obj7B_Fall:				; XREF: Obj7B_Index
		jsr	ObjectFall
		movea.l	Off3C(a0),a1
		lea	(word_19018).l,a2
		moveq	#0,d0
		move.b	Anim_Frame(a1),d0
		move.w	X_pos(a0),d1
		sub.w	Off30(a0),d1
		bcc.s	loc_18D8E
		addq.w	#2,d0

loc_18D8E:
		add.w	d0,d0
		move.w	Off34(a0),d1
		add.w	(a2,d0.w),d1
		cmp.w	Y_Pos(a0),d1
		bgt.s	locret_18DC4
		movea.l	Off3C(a0),a1
		moveq	#2,d1
		btst	#0,Status(a0)
		beq.s	loc_18DAE
		moveq	#0,d1

loc_18DAE:
		move.w	#$F0,Subtype(a0)
		move.b	#10,$1F(a0)	; set frame duration to	10 frames
		move.b	$1F(a0),Anim_Dur(a0)
		bra.w	loc_18FA2
; ===========================================================================

locret_18DC4:
		rts
; ===========================================================================

loc_18DC6:				; XREF: Obj7B_Index
		movea.l	Off3C(a0),a1
		moveq	#0,d0
		move.b	Off3A(a0),d0
		sub.b	Off3A(a1),d0
		beq.s	loc_18E2A
		bcc.s	loc_18DDA
		neg.b	d0

loc_18DDA:
		move.w	#-$818,d1
		move.w	#-$114,d2
		cmpi.b	#1,d0
		beq.s	loc_18E00
		move.w	#-$960,d1
		move.w	#-$F4,d2
		cmpi.w	#$9C0,Off38(a1)
		blt.s	loc_18E00
		move.w	#-$A20,d1
		move.w	#-$80,d2

loc_18E00:
		move.w	d1,Y_Vel(a0)
		move.w	d2,X_Vel(a0)
		move.w	X_pos(a0),d0
		sub.w	Off30(a0),d0
		bcc.s	loc_18E16
		neg.w	X_Vel(a0)

loc_18E16:
		move.b	#1,Anim_Frame(a0)
		move.w	#$20,Subtype(a0)
		addq.b	#2,Routine(a0)
		bra.w	loc_18EAA
; ===========================================================================

loc_18E2A:				; XREF: loc_18DC6
		lea	(word_19018).l,a2
		moveq	#0,d0
		move.b	Anim_Frame(a1),d0
		move.w	#$28,d2
		move.w	X_pos(a0),d1
		sub.w	Off30(a0),d1
		bcc.s	loc_18E48
		neg.w	d2
		addq.w	#2,d0

loc_18E48:
		add.w	d0,d0
		move.w	Off34(a0),d1
		add.w	(a2,d0.w),d1
		move.w	d1,Y_Pos(a0)
		add.w	Off30(a0),d2
		move.w	d2,X_pos(a0)
		clr.w	Y_Pos2(a0)
		clr.w	X_Pos2(a0)
		subq.w	#1,Subtype(a0)
		bne.s	loc_18E7A
		move.w	#$20,Subtype(a0)
		move.b	#8,Routine(a0)
		rts
; ===========================================================================

loc_18E7A:
		cmpi.w	#$78,Subtype(a0)
		bne.s	loc_18E88
		move.b	#5,$1F(a0)

loc_18E88:
		cmpi.w	#$3C,Subtype(a0)
		bne.s	loc_18E96
		move.b	#2,$1F(a0)

loc_18E96:
		subq.b	#1,Anim_Dur(a0)
		bgt.s	locret_18EA8
		bchg	#0,Anim_Frame(a0)
		move.b	$1F(a0),Anim_Dur(a0)

locret_18EA8:
		rts
; ===========================================================================

loc_18EAA:				; XREF: Obj7B_Index
		lea	($FFFFD040).w,a1
		moveq	#$7A,d0
		moveq	#$40,d1
		moveq	#$3E,d2

loc_18EB4:
		cmp.b	(a1),d0
		beq.s	loc_18EC0
		adda.w	d1,a1
		dbf	d2,loc_18EB4

		bra.s	loc_18F38
; ===========================================================================

loc_18EC0:
		move.w	X_pos(a1),d0
		move.w	Y_Pos(a1),d1
		move.w	X_pos(a0),d2
		move.w	Y_Pos(a0),d3
		lea	byte_19022(pc),a2
		lea	byte_19026(pc),a3
		move.b	(a2)+,d4
		ext.w	d4
		add.w	d4,d0
		move.b	(a3)+,d4
		ext.w	d4
		add.w	d4,d2
		cmp.w	d0,d2
		bcs.s	loc_18F38
		move.b	(a2)+,d4
		ext.w	d4
		add.w	d4,d0
		move.b	(a3)+,d4
		ext.w	d4
		add.w	d4,d2
		cmp.w	d2,d0
		bcs.s	loc_18F38
		move.b	(a2)+,d4
		ext.w	d4
		add.w	d4,d1
		move.b	(a3)+,d4
		ext.w	d4
		add.w	d4,d3
		cmp.w	d1,d3
		bcs.s	loc_18F38
		move.b	(a2)+,d4
		ext.w	d4
		add.w	d4,d1
		move.b	(a3)+,d4
		ext.w	d4
		add.w	d4,d3
		cmp.w	d3,d1
		bcs.s	loc_18F38
		addq.b	#2,Routine(a0)
		clr.w	Subtype(a0)
		clr.b	Coll(a1)

		subq.b	#1,Coll2(a1)
		bne.s	loc_18F38
		bset	#7,Status(a1)
		clr.w	X_Vel(a0)
		clr.w	Y_Vel(a0)

loc_18F38:
		move.b	Coll2(a1),d0
		tas	d0
		move.b	d0,BossLives.w	; livescnt

		tst.w	Y_Vel(a0)
		bpl.s	loc_18F5C
		jsr	ObjectFall
		move.w	Off34(a0),d0
		subi.w	#$2F,d0
		cmp.w	Y_Pos(a0),d0
		bgt.s	loc_18F58
		jsr	ObjectFall

loc_18F58:
		bra.w	loc_18E7A
; ===========================================================================

loc_18F5C:
		jsr	ObjectFall
		movea.l	Off3C(a0),a1
		lea	(word_19018).l,a2
		moveq	#0,d0
		move.b	Anim_Frame(a1),d0
		move.w	X_pos(a0),d1
		sub.w	Off30(a0),d1
		bcc.s	loc_18F7E
		addq.w	#2,d0

loc_18F7E:
		add.w	d0,d0
		move.w	Off34(a0),d1
		add.w	(a2,d0.w),d1
		cmp.w	Y_Pos(a0),d1
		bgt.s	loc_18F58
		movea.l	Off3C(a0),a1
		moveq	#2,d1
		tst.w	X_Vel(a0)
		bmi.s	loc_18F9C
		moveq	#0,d1

loc_18F9C:
		move.w	#0,Subtype(a0)

loc_18FA2:
		move.b	d1,Off3A(a1)
		move.b	d1,Off3A(a0)
		cmp.b	Anim_Frame(a1),d1
		beq.s	loc_19008
		bclr	#3,Status(a1)
		beq.s	loc_19008
		clr.b	Routine2(a1)
		move.b	#2,Routine(a1)
		lea	Object_RAM,a2
		move.w	Y_Vel(a0),Y_Vel(a2)
		neg.w	Y_Vel(a2)
		cmpi.b	#1,Anim_Frame(a1)
		bne.s	loc_18FDC
		asr	Y_Vel(a2)

loc_18FDC:
		bset	#1,Status(a2)
		bclr	#3,Status(a2)
		clr.b	Off3C(a2)
		move.l	a0,-(sp)
		lea	(a2),a0
		jsr	Obj01_ChkRoll
		movea.l	(sp)+,a0
		move.b	#2,Routine(a2)
		move.w	#$CC,d0
		jsr	(PlaySound).l ;	play "spring" sound

		sf	If_Spindash.w
		sf	PeelOut_Flag.w

loc_19008:
		clr.w	X_Vel(a0)
		clr.w	Y_Vel(a0)
		addq.b	#2,Routine(a0)
		bra.w	loc_18E7A
; ===========================================================================
word_19018:	dc.w $FFF8, $FFE4, $FFD1, $FFE4, $FFF8
		even
byte_19022:	dc.b $E8, $30, $E8, $30
		even
byte_19026:	dc.b 8,	$F0, 8,	$F0
		even
; ===========================================================================

Obj7B_Explode:				; XREF: Obj7B_Index
		move.b	#$3F,(a0)
		clr.b	Routine(a0)
		cmpi.w	#$20,Subtype(a0)
		beq.s	Obj7B_MakeFrag
		rts
; ===========================================================================

Obj7B_MakeFrag:
		move.w	Off34(a0),Y_Pos(a0)
		moveq	#3,d1
		lea	Obj7B_FragSpeed(pc),a2

Obj7B_Loop:
		jsr	SingleObjLoad
		bne.s	loc_1909A
		move.b	#$7B,(a1)	; load shrapnel	object
		move.b	#$A,Routine(a1)
		move.l	#Map_obj7B,Mappings_Offset(a1)
		move.b	#3,Priority(a1)
		move.w	#$518,Art_Tile(a1)
		move.w	X_pos(a0),X_pos(a1)
		move.w	Y_Pos(a0),Y_Pos(a1)
		move.w	(a2)+,X_Vel(a1)
		move.w	(a2)+,Y_Vel(a1)
		move.b	#$98,Coll(a1)
		ori.b	#4,Render_Flags(a1)
		bset	#7,Render_Flags(a1)
		move.b	#$C,X_Visible(a1)

loc_1909A:
		dbf	d1,Obj7B_Loop	; repeat sequence 3 more times

		rts
; ===========================================================================
Obj7B_FragSpeed:dc.w $FF00, $FCC0	; horizontal, vertical
		dc.w $FF60, $FDC0
		dc.w $100, $FCC0
		dc.w $A0, $FDC0
; ===========================================================================

Obj7B_MoveFrag:				; XREF: Obj7B_Index
		jsr	SpeedToPos
		move.w	X_pos(a0),Off30(a0)
		move.w	Y_Pos(a0),Off34(a0)
		addi.w	#$18,Y_Vel(a0)
		moveq	#4,d0
		and.w	($FFFFFE0E).w,d0
		lsr.w	#2,d0
		move.b	d0,Anim_Frame(a0)
		tst.b	Render_Flags(a0)
		bpl.w	Obj7A_Delete
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Sprite mappings - exploding spikeys that the SLZ boss	drops
; ---------------------------------------------------------------------------
Map_obj7B:
	include "_maps\obj7B.asm"
