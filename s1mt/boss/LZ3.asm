; ---------------------------------------------------------------------------
; Object - Boss (LZ3)
; ---------------------------------------------------------------------------
LZ3_Boss:					; XREF: Obj_Index
Obj77:					; XREF: Obj_Index
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	Obj77_Index(pc,d0.w),d1
		jmp	Obj77_Index(pc,d1.w)
; ===========================================================================
Obj77_Index:	dc.w Obj77_Main-Obj77_Index
		dc.w Obj77_ShipMain-Obj77_Index
		dc.w Obj77_FaceMain-Obj77_Index
		dc.w Obj77_FlameMain-Obj77_Index

Obj77_ObjData:	dc.b 2,	0		; routine number, animation
		dc.b 4,	1
		dc.b 6,	7
; ===========================================================================

Obj77_Main:				; XREF: Obj77_Index
		move.w	#$1E10,X_pos(a0)
		move.w	#$5C0,Y_Pos(a0)
		move.w	X_pos(a0),Off30(a0)
		move.w	Y_Pos(a0),Off38(a0)
		move.b	#$F,Coll(a0)
		move.b	#8,Coll2(a0)	; set number of	hits to	8
		move.b	#4,Priority(a0)
		lea	Obj77_ObjData(pc),a2
		movea.l	a0,a1
		moveq	#2,d1
		bra.s	Obj77_LoadBoss
; ===========================================================================

Obj77_Loop:
		jsr	SingleObjLoad2
		bne.s	Obj77_ShipMain
		move.b	#$77,0(a1)
		move.w	X_pos(a0),X_pos(a1)
		move.w	Y_Pos(a0),Y_Pos(a1)

Obj77_LoadBoss:				; XREF: Obj77_Main
		bclr	#0,Status(a0)
		clr.b	Routine2(a1)
		move.b	(a2)+,Routine(a1)
		move.b	(a2)+,Anim(a1)
		move.b	Priority(a0),Priority(a1)
		move.l	#Map_Eggman,Mappings_Offset(a1)
		move.w	#$400,Art_Tile(a1)
		move.b	#4,Render_Flags(a1)
		move.b	#$20,X_Visible(a1)
		move.l	a0,Off34(a1)
		dbf	d1,Obj77_Loop

Obj77_ShipMain:
		lea	Object_RAM,a1
		moveq	#0,d0
		move.b	Routine2(a0),d0
		move.w	Obj77_ShipIndex(pc,d0.w),d1
		jsr	Obj77_ShipIndex(pc,d1.w)
		lea	(Ani_Eggman).l,a1
		jsr	AnimateSprite
		moveq	#3,d0
		and.b	Status(a0),d0
		andi.b	#$FC,Render_Flags(a0)
		or.b	d0,Render_Flags(a0)
		jmp	DisplaySprite
; ===========================================================================
Obj77_ShipIndex:dc.w loc_17F1E-Obj77_ShipIndex,	loc_17FA0-Obj77_ShipIndex
		dc.w loc_17FE0-Obj77_ShipIndex,	loc_1801E-Obj77_ShipIndex
		dc.w loc_180BC-Obj77_ShipIndex,	loc_180F6-Obj77_ShipIndex
		dc.w loc_1812A-Obj77_ShipIndex,	loc_18152-Obj77_ShipIndex
; ===========================================================================

loc_17F1E:				; XREF: Obj77_ShipIndex
		move.w	X_pos(a1),d0
		cmpi.w	#$1DA0,d0
		bcs.s	loc_17F38
		move.w	#-$180,Y_Vel(a0)
		move.w	#$60,X_Vel(a0)
		addq.b	#2,Routine2(a0)

loc_17F38:
		bsr.w	BossMove
		move.w	Off38(a0),Y_Pos(a0)
		move.w	Off30(a0),X_pos(a0)

loc_17F48:
		tst.b	Off3D(a0)
		bne.s	loc_17F8E
		tst.b	Status(a0)
		bmi.s	loc_17F92
		tst.b	Coll(a0)
		bne.s	locret_17F8C
		tst.b	Off3E(a0)
		bne.s	loc_17F70
		move.b	#$20,Off3E(a0)
		move.w	#$AC,d0
		jsr	(PlaySound).l

loc_17F70:
		lea	($FFFFFB22).w,a1
		moveq	#0,d0
		tst.w	(a1)
		bne.s	loc_17F7E
		move.w	#$EEE,d0

loc_17F7E:
		move.w	d0,(a1)
		subq.b	#1,Off3E(a0)
		bne.s	locret_17F8C
		move.b	#$F,Coll(a0)

locret_17F8C:
		rts	
; ===========================================================================

loc_17F8E:				; XREF: loc_17F48
		bra.w	BossDefeated
; ===========================================================================

loc_17F92:				; XREF: loc_17F48
		moveq	#100,d0
		bsr.w	AddPoints
		move.b	#-1,Off3D(a0)
		rts	
; ===========================================================================

loc_17FA0:				; XREF: Obj77_ShipIndex
		moveq	#-2,d0
		cmpi.w	#$1E48,Off30(a0)
		bcs.s	loc_17FB6
		move.w	#$1E48,Off30(a0)
		clr.w	X_Vel(a0)
		addq.w	#1,d0

loc_17FB6:
		cmpi.w	#$500,Off38(a0)
		bgt.s	loc_17FCA
		move.w	#$500,Off38(a0)
		clr.w	Y_Vel(a0)
		addq.w	#1,d0

loc_17FCA:
		bne.s	loc_17FDC
		move.w	#$140,X_Vel(a0)
		move.w	#-$200,Y_Vel(a0)
		addq.b	#2,Routine2(a0)

loc_17FDC:
		bra.w	loc_17F38
; ===========================================================================

loc_17FE0:				; XREF: Obj77_ShipIndex
		moveq	#-2,d0
		cmpi.w	#$1E70,Off30(a0)
		bcs.s	loc_17FF6
		move.w	#$1E70,Off30(a0)
		clr.w	X_Vel(a0)
		addq.w	#1,d0

loc_17FF6:
		cmpi.w	#$4C0,Off38(a0)
		bgt.s	loc_1800A
		move.w	#$4C0,Off38(a0)
		clr.w	Y_Vel(a0)
		addq.w	#1,d0

loc_1800A:
		bne.s	loc_1801A
		move.w	#-$180,Y_Vel(a0)
		addq.b	#2,Routine2(a0)
		clr.b	Off3F(a0)

loc_1801A:
		bra.w	loc_17F38
; ===========================================================================

loc_1801E:				; XREF: Obj77_ShipIndex
		cmpi.w	#$100,Off38(a0)
		bgt.s	loc_1804E
		move.w	#$100,Off38(a0)
		move.w	#$140,X_Vel(a0)
		move.w	#-$80,Y_Vel(a0)
		tst.b	Off3D(a0)
		beq.s	loc_18046
		asl	X_Vel(a0)
		asl	Y_Vel(a0)

loc_18046:
		addq.b	#2,Routine2(a0)
		bra.w	loc_17F38
; ===========================================================================

loc_1804E:
		bset	#0,Status(a0)
		addq.b	#2,Off3F(a0)
		move.b	Off3F(a0),d1
		jsr	(CalcSine).l
		tst.w	d1
		bpl.s	loc_1806C
		bclr	#0,Status(a0)

loc_1806C:
		asr.w	#4,d0
		swap	d0
		clr.w	d0
		add.l	Off30(a0),d0
		swap	d0
		move.w	d0,X_pos(a0)
		move.w	Y_Vel(a0),d0
		move.w	Object_RAM+Y_Pos,d1
		sub.w	Y_Pos(a0),d1
		bcs.s	loc_180A2
		subi.w	#$48,d1
		bcs.s	loc_180A2
		asr.w	#1,d0
		subi.w	#$28,d1
		bcs.s	loc_180A2
		asr.w	#1,d0
		subi.w	#$28,d1
		bcs.s	loc_180A2
		moveq	#0,d0

loc_180A2:
		ext.l	d0
		asl.l	#8,d0
		tst.b	Off3D(a0)
		beq.s	loc_180AE
		add.l	d0,d0

loc_180AE:
		add.l	d0,Off38(a0)
		move.w	Off38(a0),Y_Pos(a0)
		bra.w	loc_17F48
; ===========================================================================

loc_180BC:				; XREF: Obj77_ShipIndex
		moveq	#-2,d0
		cmpi.w	#$1F4C,Off30(a0)
		bcs.s	loc_180D2
		move.w	#$1F4C,Off30(a0)
		clr.w	X_Vel(a0)
		addq.w	#1,d0

loc_180D2:
		cmpi.w	#$C0,Off38(a0)
		bgt.s	loc_180E6
		move.w	#$C0,Off38(a0)
		clr.w	Y_Vel(a0)
		addq.w	#1,d0

loc_180E6:
		bne.s	loc_180F2
		addq.b	#2,Routine2(a0)
		bclr	#0,Status(a0)

loc_180F2:
		bra.w	loc_17F38
; ===========================================================================

loc_180F6:				; XREF: Obj77_ShipIndex
		tst.b	Off3D(a0)
		bne.s	loc_18112
		cmpi.w	#$1EC8,X_pos(a1)
		blt.s	loc_18126
		cmpi.w	#$F0,Y_Pos(a1)
		bgt.s	loc_18126
		move.b	#$32,Off3C(a0)

loc_18112:
		moveq	#$FFFFFFE0,d0
		jsr	PlayMusic		; fade music out
		bset	#0,Status(a0)
		addq.b	#2,Routine2(a0)

loc_18126:
		bra.w	loc_17F38
; ===========================================================================

loc_1812A:				; XREF: Obj77_ShipIndex
		tst.b	Off3D(a0)
		bne.s	loc_18136
		subq.b	#1,Off3C(a0)
		bne.s	loc_1814E

loc_18136:
		clr.b	Off3C(a0)
		move.w	#$400,X_Vel(a0)
		move.w	#-$40,Y_Vel(a0)
		clr.b	Off3D(a0)
		addq.b	#2,Routine2(a0)

loc_1814E:
		bra.w	loc_17F38
; ===========================================================================

loc_18152:				; XREF: Obj77_ShipIndex
		cmpi.w	#$2030,($FFFFF72A).w
		bcc.s	loc_18160
		addq.w	#2,($FFFFF72A).w
		bra.s	loc_18166
; ===========================================================================

loc_18160:
		tst.b	Render_Flags(a0)
		bpl.s	Obj77_ShipDel

loc_18166:
		bra.w	loc_17F38
; ===========================================================================

Obj77_ShipDel:
		addq.b	#2,($FFFFF742).w
		jmp	DeleteObject
; ===========================================================================

Obj77_FaceMain:				; XREF: Obj77_Index
		movea.l	Off34(a0),a1
		move.b	(a1),d0
		cmp.b	(a0),d0
		bne.s	Obj77_FaceDel
		moveq	#0,d0
		move.b	Routine2(a1),d0
		moveq	#1,d1
		tst.b	Off3D(a0)
		beq.s	loc_1818C
		moveq	#$A,d1
		bra.s	loc_181A0
; ===========================================================================

loc_1818C:
		tst.b	Coll(a1)
		bne.s	loc_18196
		moveq	#5,d1
		bra.s	loc_181A0
; ===========================================================================

loc_18196:
		cmpi.b	#4,Object_RAM+Routine
		bcs.s	loc_181A0
		moveq	#4,d1

loc_181A0:
		move.b	d1,Anim(a0)
		cmpi.b	#$E,d0
		bne.s	loc_181B6
		move.b	#6,Anim(a0)
		tst.b	Render_Flags(a0)
		bpl.s	Obj77_FaceDel

loc_181B6:
		bra.s	Obj77_Display
; ===========================================================================

Obj77_FaceDel:
		jmp	DeleteObject
; ===========================================================================

Obj77_FlameMain:			; XREF: Obj77_Index
		move.b	#7,Anim(a0)
		movea.l	Off34(a0),a1
		move.b	(a1),d0
		cmp.b	(a0),d0
		bne.s	Obj77_FlameDel
		cmpi.b	#$E,Routine2(a1)
		bne.s	loc_181F0
		move.b	#$B,Anim(a0)
		tst.b	Render_Flags(a0)
		bpl.s	Obj77_FlameDel
		bra.s	loc_181F0
; ===========================================================================
		tst.w	X_Vel(a1)
		beq.s	loc_181F0
		move.b	#8,Anim(a0)

loc_181F0:
		bra.s	Obj77_Display
; ===========================================================================

Obj77_FlameDel:				; XREF: Obj77_FlameMain
		jmp	DeleteObject
; ===========================================================================

Obj77_Display:
		lea	(Ani_Eggman).l,a1
		jsr	AnimateSprite
		movea.l	Off34(a0),a1
		move.w	X_pos(a1),X_pos(a0)
		move.w	Y_Pos(a1),Y_Pos(a0)
		move.b	Status(a1),Status(a0)
		moveq	#3,d0
		and.b	Status(a0),d0
		andi.b	#-4,Render_Flags(a0)
		or.b	d0,Render_Flags(a0)
		jmp	DisplaySprite