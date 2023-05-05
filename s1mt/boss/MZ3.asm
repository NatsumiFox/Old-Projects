; ---------------------------------------------------------------------------
; Object - Boss (MZ3)
; ---------------------------------------------------------------------------
MZ3_Boss:					; XREF: Obj_Index
Obj73:						; XREF: Obj_Index
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	MZ3_Boss_Index(pc,d0.w),d1
		jmp	MZ3_Boss_Index(pc,d1.w)
; ===========================================================================
MZ3_Boss_Index:	dc.w MZ3_Boss_Main-MZ3_Boss_Index
		dc.w MZ3_Boss_ShipMain-MZ3_Boss_Index
		dc.w MZ3_Boss_FaceMain-MZ3_Boss_Index
		dc.w MZ3_Boss_FlameMain-MZ3_Boss_Index
		dc.w MZ3_Boss_TubeMain-MZ3_Boss_Index

MZ3_Boss_ObjData:	dc.b 2,	0, 4		; routine number, animation, priority
		dc.b 4,	1, 4
		dc.b 6,	7, 4
		dc.b 8,	0, 3
; ===========================================================================

MZ3_Boss_Main:				; XREF: MZ3_Boss_Index
		move.w	X_pos(a0),Off30(a0)
		move.w	Y_Pos(a0),Off38(a0)
		move.b	#$F,Coll(a0)
		move.b	#8,Coll2(a0)	; set number of	hits to	8
		lea	MZ3_Boss_ObjData(pc),a2
		movea.l	a0,a1
		moveq	#3,d1
		bra.s	MZ3_Boss_LoadBoss
; ===========================================================================

MZ3_Boss_Loop:
		jsr	SingleObjLoad2
		bne.s	MZ3_Boss_ShipMain
		move.b	#$73,0(a1)
		move.w	X_pos(a0),X_pos(a1)
		move.w	Y_Pos(a0),Y_Pos(a1)

MZ3_Boss_LoadBoss:				; XREF: MZ3_Boss_Main
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
		dbf	d1,MZ3_Boss_Loop	; repeat sequence 3 more times

MZ3_Boss_ShipMain:
		moveq	#0,d0
		move.b	Routine2(a0),d0
		move.w	MZ3_Boss_ShipIndex(pc,d0.w),d1
		jsr	MZ3_Boss_ShipIndex(pc,d1.w)
		lea	(Ani_Eggman).l,a1
		jsr	AnimateSprite
		moveq	#3,d0
		and.b	Status(a0),d0
		andi.b	#$FC,Render_Flags(a0)
		or.b	d0,Render_Flags(a0)
		jmp	DisplaySprite
; ===========================================================================
MZ3_Boss_ShipIndex:dc.w loc_18302-MZ3_Boss_ShipIndex
		dc.w loc_183AA-MZ3_Boss_ShipIndex
		dc.w loc_184F6-MZ3_Boss_ShipIndex
		dc.w loc_1852C-MZ3_Boss_ShipIndex
		dc.w loc_18582-MZ3_Boss_ShipIndex
; ===========================================================================

loc_18302:				; XREF: MZ3_Boss_ShipIndex
		move.b	Off3F(a0),d1
		addq.b	#2,Off3F(a0)
		jsr	(CalcSine).l
		asr.w	#2,d0
		move.w	d0,Y_Vel(a0)
		move.w	#-$100,X_Vel(a0)
		bsr.w	BossMove
		cmpi.w	#$1910,Off30(a0)
		bne.s	loc_18334
		addq.b	#2,Routine2(a0)
		clr.b	Subtype(a0)
		clr.l	X_Vel(a0)

loc_18334:
		jsr	(RandomNumber).l
		move.b	d0,Off34(a0)

loc_1833E:
		move.w	Off38(a0),Y_Pos(a0)
		move.w	Off30(a0),X_pos(a0)
		cmpi.b	#4,Routine2(a0)
		bcc.s	locret_18390
		tst.b	Status(a0)
		bmi.s	loc_18392
		tst.b	Coll(a0)
		bne.s	locret_18390
		tst.b	Off3E(a0)
		bne.s	loc_18374
		move.b	#$28,Off3E(a0)
		move.w	#$AC,d0
		jsr	(PlaySound).l ;	play boss damage sound

loc_18374:
		lea	($FFFFFB22).w,a1
		moveq	#0,d0
		tst.w	(a1)
		bne.s	loc_18382
		move.w	#$EEE,d0

loc_18382:
		move.w	d0,(a1)
		subq.b	#1,Off3E(a0)
		bne.s	locret_18390
		move.b	#$F,Coll(a0)

locret_18390:
		rts
; ===========================================================================

loc_18392:				; XREF: loc_1833E
		moveq	#100,d0
		bsr.w	AddPoints
		move.b	#4,Routine2(a0)
		move.w	#$B4,Off3C(a0)
		clr.w	X_Vel(a0)
		rts
; ===========================================================================

loc_183AA:				; XREF: MZ3_Boss_ShipIndex
		moveq	#0,d0
		move.b	Subtype(a0),d0
		move.w	off_183C2(pc,d0.w),d0
		jsr	off_183C2(pc,d0.w)
		andi.b	#6,Subtype(a0)
		bra.w	loc_1833E
; ===========================================================================
off_183C2:	dc.w loc_183CA-off_183C2
		dc.w MZ3_Boss_MakeLava2-off_183C2
		dc.w loc_183CA-off_183C2
		dc.w MZ3_Boss_MakeLava2-off_183C2
; ===========================================================================

loc_183CA:				; XREF: off_183C2
		tst.w	X_Vel(a0)
		bne.s	loc_183FE
		moveq	#$40,d0
		cmpi.w	#$22C,Off38(a0)
		beq.s	loc_183E6
		bcs.s	loc_183DE
		neg.w	d0

loc_183DE:
		move.w	d0,Y_Vel(a0)
		bra.w	BossMove
; ===========================================================================

loc_183E6:
		move.w	#$200,X_Vel(a0)
		move.w	#$100,Y_Vel(a0)
		btst	#0,Status(a0)
		bne.s	loc_183FE
		neg.w	X_Vel(a0)

loc_183FE:
		cmpi.b	#$18,Off3E(a0)
		bcc.s	MZ3_Boss_MakeLava
		bsr.w	BossMove
		subq.w	#4,Y_Vel(a0)

MZ3_Boss_MakeLava:
		subq.b	#1,Off34(a0)
		bcc.s	loc_1845C
		jsr	SingleObjLoad
		bne.s	loc_1844A
		move.b	#$14,0(a1)	; load lava ball object
		move.w	#$2E8,Y_Pos(a1)	; set Y	position
		jsr	(RandomNumber).l
		andi.l	#$FFFF,d0
		divu.w	#$50,d0
		swap	d0
		addi.w	#$1878,d0
		move.w	d0,X_pos(a1)
		lsr.b	#7,d1
		move.w	#$FF,Subtype(a1)

loc_1844A:
		jsr	(RandomNumber).l
		andi.b	#$1F,d0
		addi.b	#$40,d0
		move.b	d0,Off34(a0)

loc_1845C:
		btst	#0,Status(a0)
		beq.s	loc_18474
		cmpi.w	#$1910,Off30(a0)
		blt.s	locret_1849C
		move.w	#$1910,Off30(a0)
		bra.s	loc_18482
; ===========================================================================

loc_18474:
		cmpi.w	#$1830,Off30(a0)
		bgt.s	locret_1849C
		move.w	#$1830,Off30(a0)

loc_18482:
		clr.w	X_Vel(a0)
		move.w	#-$180,Y_Vel(a0)
		cmpi.w	#$22C,Off38(a0)
		bcc.s	loc_18498
		neg.w	Y_Vel(a0)

loc_18498:
		addq.b	#2,Subtype(a0)

locret_1849C:
		rts
; ===========================================================================

MZ3_Boss_MakeLava2:			; XREF: off_183C2
		bsr.w	BossMove
		move.w	Off38(a0),d0
		subi.w	#$22C,d0
		bgt.s	locret_184F4
		move.w	#$22C,d0
		tst.w	Y_Vel(a0)
		beq.s	loc_184EA
		clr.w	Y_Vel(a0)
		move.w	#$50,Off3C(a0)
		bchg	#0,Status(a0)
		jsr	SingleObjLoad
		bne.s	loc_184EA
		move.w	Off30(a0),X_pos(a1)
		move.w	Off38(a0),Y_Pos(a1)
		addi.w	#$18,Y_Pos(a1)
		move.b	#$74,(a1)	; load lava ball object
		move.b	#1,Subtype(a1)

loc_184EA:
		subq.w	#1,Off3C(a0)
		bne.s	locret_184F4
		addq.b	#2,Subtype(a0)

locret_184F4:
		rts
; ===========================================================================

loc_184F6:				; XREF: MZ3_Boss_ShipIndex
		subq.w	#1,Off3C(a0)
		bmi.s	loc_18500
		bra.w	BossDefeated
; ===========================================================================

loc_18500:
		bset	#0,Status(a0)
		bclr	#7,Status(a0)
		clr.w	X_Vel(a0)
		addq.b	#2,Routine2(a0)
		move.w	#-$26,Off3C(a0)
		tst.b	($FFFFF7A7).w
		bne.s	locret_1852A
		move.b	#1,($FFFFF7A7).w
		clr.w	Y_Vel(a0)

locret_1852A:
		rts
; ===========================================================================

loc_1852C:				; XREF: MZ3_Boss_ShipIndex
		addq.w	#1,Off3C(a0)
		beq.s	loc_18544
		bpl.s	loc_1854E
		cmpi.w	#$270,Off38(a0)
		bcc.s	loc_18544
		addi.w	#$18,Y_Vel(a0)
		bra.s	loc_1857A
; ===========================================================================

loc_18544:
		clr.w	Y_Vel(a0)
		clr.w	Off3C(a0)
		bra.s	loc_1857A
; ===========================================================================

loc_1854E:
		cmpi.w	#$30,Off3C(a0)
		bcs.s	loc_18566
		beq.s	loc_1856C
		cmpi.w	#$38,Off3C(a0)
		bcs.s	loc_1857A
		addq.b	#2,Routine2(a0)
		bra.s	loc_1857A
; ===========================================================================

loc_18566:
		subq.w	#8,Y_Vel(a0)
		bra.s	loc_1857A
; ===========================================================================

loc_1856C:
		clr.w	Y_Vel(a0)
		moveq	#$FFFFFFE0,d0
		jsr	PlayMusic		; fade music out

loc_1857A:
		bsr.w	BossMove
		bra.w	loc_1833E
; ===========================================================================

loc_18582:				; XREF: MZ3_Boss_ShipIndex
		move.w	#$500,X_Vel(a0)
		move.w	#-$40,Y_Vel(a0)
		cmpi.w	#$1960,($FFFFF72A).w
		bcc.s	loc_1859C
		addq.w	#2,($FFFFF72A).w
		bra.s	loc_185A2
; ===========================================================================

loc_1859C:
		tst.b	Render_Flags(a0)
		bpl.s	MZ3_Boss_ShipDel

loc_185A2:
		bsr.w	BossMove
		bra.w	loc_1833E
; ===========================================================================

MZ3_Boss_ShipDel:
		jmp	DeleteObject
; ===========================================================================

MZ3_Boss_FaceMain:				; XREF: MZ3_Boss_Index
		moveq	#0,d0
		moveq	#1,d1
		movea.l	Off34(a0),a1
		move.b	(a0),d0
		cmp.b	(a1),d0
		bne.w	MZ3_Boss_FlameDel

		move.b	Routine2(a1),d0
		subq.w	#2,d0
		bne.s	loc_185D2
		btst	#1,Subtype(a1)
		beq.s	loc_185DA
		tst.w	Y_Vel(a1)
		bne.s	loc_185DA
		moveq	#4,d1
		bra.s	loc_185EE
; ===========================================================================

loc_185D2:
		subq.b	#2,d0
		bmi.s	loc_185DA
		moveq	#$A,d1
		bra.s	loc_185EE
; ===========================================================================

loc_185DA:
		tst.b	Coll(a1)
		bne.s	loc_185E4
		moveq	#5,d1
		bra.s	loc_185EE
; ===========================================================================

loc_185E4:
		cmpi.b	#4,Object_RAM+Routine
		bcs.s	loc_185EE
		moveq	#4,d1

loc_185EE:
		move.b	d1,Anim(a0)
		subq.b	#4,d0
		bne.s	loc_18602
		move.b	#6,Anim(a0)
		tst.b	Render_Flags(a0)
		bpl.s	MZ3_Boss_FlameDel

loc_18602:
		bra.s	MZ3_Boss_Display
; ===========================================================================

MZ3_Boss_FlameMain:			; XREF: MZ3_Boss_Index
		move.b	#7,Anim(a0)
		movea.l	Off34(a0),a1
		move.b	(a0),d0
		cmp.b	(a1),d0
		bne.w	MZ3_Boss_FlameDel
		cmpi.b	#8,Routine2(a1)
		blt.s	loc_1862A
		move.b	#$B,Anim(a0)
		tst.b	Render_Flags(a0)
		bpl.s	MZ3_Boss_FlameDel
		bra.s	loc_18636
; ===========================================================================

loc_1862A:
		tst.w	X_Vel(a1)
		beq.s	loc_18636
		move.b	#8,Anim(a0)

loc_18636:
		bra.s	MZ3_Boss_Display
; ===========================================================================

MZ3_Boss_FlameDel:				; XREF: MZ3_Boss_FlameMain
		jmp	DeleteObject
; ===========================================================================

MZ3_Boss_Display:
		lea	(Ani_Eggman).l,a1
		jsr	AnimateSprite

loc_1864A:
		movea.l	Off34(a0),a1
		move.b	(a0),d0
		cmp.b	(a1),d0
		bne.w	MZ3_Boss_FlameDel
		move.w	X_pos(a1),X_pos(a0)
		move.w	Y_Pos(a1),Y_Pos(a0)
		move.b	Status(a1),Status(a0)
		moveq	#3,d0
		and.b	Status(a0),d0
		andi.b	#-4,Render_Flags(a0)
		or.b	d0,Render_Flags(a0)
		jmp	DisplaySprite
; ===========================================================================

MZ3_Boss_TubeMain:				; XREF: MZ3_Boss_Index
		movea.l	Off34(a0),a1
		cmpi.b	#8,Routine2(a1)
		bne.s	loc_18688
		tst.b	Render_Flags(a0)
		bpl.s	MZ3_Boss_FlameDel

loc_18688:
		move.l	#Map_BossItems,Mappings_Offset(a0)
		move.w	#$246C,Art_Tile(a0)
		move.b	#4,Anim_Frame(a0)
		bra.s	loc_1864A
		
; ===========================================================================
; ---------------------------------------------------------------------------
; Object 74 - lava that	Eggman drops (MZ)
; ---------------------------------------------------------------------------

Obj74:					; XREF: Obj_Index
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	Obj74_Index(pc,d0.w),d0
		jsr	Obj74_Index(pc,d0.w)
.fire		jmp	DisplaySprite
; ===========================================================================
Obj74_Index:	dc.w Obj74_Main-Obj74_Index
		dc.w Obj74_Action-Obj74_Index
		dc.w loc_18886-Obj74_Index
		dc.w Obj74_Delete3-Obj74_Index
; ===========================================================================

Obj74_Main:				; XREF: Obj74_Index
		move.b	#8,Y_Radius(a0)
		move.b	#8,X_Radius(a0)
		move.l	#Map_obj14,Mappings_Offset(a0)
		move.w	#$345,Art_Tile(a0)
		move.b	#4,Render_Flags(a0)
		move.b	#5,Priority(a0)
		move.w	Y_Pos(a0),Off38(a0)
		addq.b	#2,Routine(a0)
		tst.b	Subtype(a0)
		bne.s	loc_1870A
		move.b	#8,X_Visible(a0)
	        move.b	#$8B,Coll(a0)
		addq.b	#2,Routine(a0)
		bra.w	loc_18886
; ===========================================================================

loc_1870A:
		move.b	#$1E,$29(a0)
		move.w	#$AE,d0
		jsr	(PlaySound).l ;	play lava sound

Obj74_Action:				; XREF: Obj74_Index
		moveq	#0,d0
		move.b	Routine2(a0),d0
		move.w	Obj74_Index2(pc,d0.w),d0
		jsr	Obj74_Index2(pc,d0.w)
		jsr	SpeedToPos
		lea	(Ani_obj14).l,a1
		jsr	AnimateSprite
		cmpi.w	#$2E8,Y_Pos(a0)
		bhi.s	Obj74_Delete
		rts	
; ===========================================================================

Obj74_Delete:
		jmp	DeleteObject
; ===========================================================================
Obj74_Index2:	dc.w Obj74_Drop-Obj74_Index2
		dc.w Obj74_MakeFlame-Obj74_Index2
		dc.w Obj74_Duplicate-Obj74_Index2
		dc.w Obj74_FallEdge-Obj74_Index2
; ===========================================================================

Obj74_Drop:				; XREF: Obj74_Index2
		bset	#1,Status(a0)
		subq.b	#1,$29(a0)
		bpl.s	locret_18780
		clr.b	Subtype(a0)
		addi.w	#$18,Y_Vel(a0)
		bclr	#1,Status(a0)
		bsr.w	ObjHitFloor
		tst.w	d1
		bpl.s	locret_18780
		addq.b	#2,Routine2(a0)

locret_18780:
		rts	
; ===========================================================================

Obj74_MakeFlame:			; XREF: Obj74_Index2
		move.b	#0,Coll(a0)
	        cmpi.b	#4,Shield_RAM+Inertia.w
	        beq	.fire
	        move.b	#$8B,Coll(a0)

.fire		subq.w	#2,Y_Pos(a0)
		bset	#7,Art_Tile(a0)
		move.w	#$A0,X_Vel(a0)
		clr.w	Y_Vel(a0)
		move.w	X_pos(a0),Off30(a0)
		move.w	Y_Pos(a0),Off38(a0)
		move.b	#3,$29(a0)
		jsr	SingleObjLoad2
		bne.s	loc_187CA
		lea	(a1),a3
		lea	(a0),a2
		moveq	#3,d0

Obj74_Loop:
		move.l	(a2)+,(a3)+
		move.l	(a2)+,(a3)+
		move.l	(a2)+,(a3)+
		move.l	(a2)+,(a3)+
		dbf	d0,Obj74_Loop

		neg.w	X_Vel(a1)
		addq.b	#2,Routine2(a1)

loc_187CA:
		addq.b	#2,Routine2(a0)
		rts	

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Obj74_Duplicate2:			; XREF: Obj74_Duplicate
		jsr	SingleObjLoad2
		bne.s	locret_187EE
		move.w	X_pos(a0),X_pos(a1)
		move.w	Y_Pos(a0),Y_Pos(a1)
		move.b	#$74,(a1)
		move.w	#$67,Subtype(a1)

locret_187EE:
		rts	
; End of function Obj74_Duplicate2

; ===========================================================================

Obj74_Duplicate:			; XREF: Obj74_Index2
		bsr.w	ObjHitFloor
		tst.w	d1
		bpl.s	loc_18826
		move.w	X_pos(a0),d0
		cmpi.w	#$1940,d0
		bgt.s	loc_1882C
		move.w	Off30(a0),d1
		cmp.w	d0,d1
		beq.s	loc_1881E
		andi.w	#$10,d0
		andi.w	#$10,d1
		cmp.w	d0,d1
		beq.s	loc_1881E
		bsr.s	Obj74_Duplicate2
		move.w	X_pos(a0),Off32(a0)

loc_1881E:
		move.w	X_pos(a0),Off30(a0)
		rts	
; ===========================================================================

loc_18826:
		addq.b	#2,Routine2(a0)
		rts	
; ===========================================================================

loc_1882C:
		addq.b	#2,Routine(a0)
		rts	
; ===========================================================================

Obj74_FallEdge:				; XREF: Obj74_Index2
		move.b	#0,Coll(a0)
	        cmpi.b	#4,Shield_RAM+Inertia.w
	        beq	.fire
	        move.b	#$8B,Coll(a0)

.fire		bclr	#1,Status(a0)
		addi.w	#$24,Y_Vel(a0)	; make flame fall
		move.w	X_pos(a0),d0
		sub.w	Off32(a0),d0
		bpl.s	loc_1884A
		neg.w	d0

loc_1884A:
		cmpi.w	#$12,d0
		bne.s	loc_18856
		bclr	#7,Art_Tile(a0)

loc_18856:
		bsr.w	ObjHitFloor
		tst.w	d1
		bpl.s	locret_1887E
		subq.b	#1,$29(a0)
		beq.s	Obj74_Delete2
		clr.w	Y_Vel(a0)
		move.w	Off32(a0),X_pos(a0)
		move.w	Off38(a0),Y_Pos(a0)
		bset	#7,Art_Tile(a0)
		subq.b	#2,Routine2(a0)

locret_1887E:
		rts	
; ===========================================================================

Obj74_Delete2:
		jmp	DeleteObject
; ===========================================================================

loc_18886:				; XREF: Obj74_Index
		move.b	#0,Coll(a0)
	        cmpi.b	#4,Shield_RAM+Inertia.w
	        beq	.fire
	        cmpi.b	#1,Anim(a0)
	        beq.s	.fire
	        move.b	#$8B,Coll(a0)

.fire		bset	#7,Art_Tile(a0)
		subq.b	#1,$29(a0)
		bne.s	Obj74_Animate
		move.b	#1,Anim(a0)
		subq.w	#4,Y_Pos(a0)
		clr.b	Coll(a0)

Obj74_Animate:
		lea	(Ani_obj14).l,a1
		jmp	AnimateSprite
; ===========================================================================

Obj74_Delete3:				; XREF: Obj74_Index
		jmp	DeleteObject
; ===========================================================================

Obj7A_Delete:
		jmp	DeleteObject		