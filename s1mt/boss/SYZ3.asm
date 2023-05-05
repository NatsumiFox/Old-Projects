; ---------------------------------------------------------------------------
; Object - Boss (SYZ3)
; ---------------------------------------------------------------------------
SYZ3_Boss:					; XREF: Obj_Index
Obj75:					; XREF: Obj_Index
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	Obj75_Index(pc,d0.w),d1
		jmp	Obj75_Index(pc,d1.w)
; ===========================================================================
Obj75_Index:	dc.w Obj75_Main-Obj75_Index
		dc.w Obj75_ShipMain-Obj75_Index
		dc.w Obj75_FaceMain-Obj75_Index
		dc.w Obj75_FlameMain-Obj75_Index
		dc.w Obj75_SpikeMain-Obj75_Index

Obj75_ObjData:	dc.b 2,	0, 5		; routine number, animation, priority
		dc.b 4,	1, 5
		dc.b 6,	7, 5
		dc.b 8,	0, 5
; ===========================================================================

Obj75_Main:				; XREF: Obj75_Index
		move.w	#$2DB0,X_pos(a0)
		move.w	#$4DA,Y_Pos(a0)
		move.w	X_pos(a0),Off30(a0)
		move.w	Y_Pos(a0),Off38(a0)
		move.b	#$F,Coll(a0)
		move.b	#8,Coll2(a0)	; set number of	hits to	8
		lea	Obj75_ObjData(pc),a2
		movea.l	a0,a1
		moveq	#3,d1
		bra.s	Obj75_LoadBoss
; ===========================================================================

Obj75_Loop:
		jsr	SingleObjLoad2
		bne.s	Obj75_ShipMain
		move.b	#$75,(a1)
		move.w	X_pos(a0),X_pos(a1)
		move.w	Y_Pos(a0),Y_Pos(a1)

Obj75_LoadBoss:				; XREF: Obj75_Main
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
		dbf	d1,Obj75_Loop	; repeat sequence 3 more times

Obj75_ShipMain:				; XREF: Obj75_Index
		moveq	#0,d0
		move.b	Routine2(a0),d0
		move.w	Obj75_ShipIndex(pc,d0.w),d1
		jsr	Obj75_ShipIndex(pc,d1.w)
		lea	(Ani_Eggman).l,a1
		jsr	AnimateSprite
		moveq	#3,d0
		and.b	Status(a0),d0
		andi.b	#$FC,Render_Flags(a0)
		or.b	d0,Render_Flags(a0)
		jmp	DisplaySprite
; ===========================================================================
Obj75_ShipIndex:dc.w loc_191CC-Obj75_ShipIndex,	loc_19270-Obj75_ShipIndex
		dc.w loc_192EC-Obj75_ShipIndex,	loc_19474-Obj75_ShipIndex
		dc.w loc_194AC-Obj75_ShipIndex,	loc_194F2-Obj75_ShipIndex
; ===========================================================================

loc_191CC:				; XREF: Obj75_ShipIndex
		move.w	#-$100,X_Vel(a0)
		cmpi.w	#$2D38,Off30(a0)
		bcc.s	loc_191DE
		addq.b	#2,Routine2(a0)

loc_191DE:
		move.b	Off3F(a0),d1
		addq.b	#2,Off3F(a0)
		jsr	(CalcSine).l
		asr.w	#2,d0
		move.w	d0,Y_Vel(a0)

loc_191F2:
		bsr.w	BossMove
		move.w	Off38(a0),Y_Pos(a0)
		move.w	Off30(a0),X_pos(a0)

loc_19202:
		move.w	X_pos(a0),d0
		subi.w	#$2C00,d0
		lsr.w	#5,d0
		move.b	d0,Off34(a0)
		cmpi.b	#6,Routine2(a0)
		bcc.s	locret_19256
		tst.b	Status(a0)
		bmi.s	loc_19258
		tst.b	Coll(a0)
		bne.s	locret_19256
		tst.b	Off3E(a0)
		bne.s	loc_1923A
		move.b	#$20,Off3E(a0)
		move.w	#$AC,d0
		jsr	(PlaySound).l ;	play boss damage sound

loc_1923A:
		lea	($FFFFFB22).w,a1
		moveq	#0,d0
		tst.w	(a1)
		bne.s	loc_19248
		move.w	#$EEE,d0

loc_19248:
		move.w	d0,(a1)
		subq.b	#1,Off3E(a0)
		bne.s	locret_19256
		move.b	#$F,Coll(a0)

locret_19256:
		rts	
; ===========================================================================

loc_19258:				; XREF: loc_19202
		moveq	#100,d0
		bsr.w	AddPoints
		move.b	#6,Routine2(a0)
		move.w	#$B4,Off3C(a0)
		clr.w	X_Vel(a0)
		rts	
; ===========================================================================

loc_19270:				; XREF: Obj75_ShipIndex
		move.w	Off30(a0),d0
		move.w	#$140,X_Vel(a0)
		btst	#0,Status(a0)
		bne.s	loc_1928E
		neg.w	X_Vel(a0)
		cmpi.w	#$2C08,d0
		bgt.s	loc_1929E
		bra.s	loc_19294
; ===========================================================================

loc_1928E:
		cmpi.w	#$2D38,d0
		blt.s	loc_1929E

loc_19294:
		bchg	#0,Status(a0)
		clr.b	Off3D(a0)

loc_1929E:
		subi.w	#$2C10,d0
		andi.w	#$1F,d0
		subi.w	#$1F,d0
		bpl.s	loc_192AE
		neg.w	d0

loc_192AE:
		subq.w	#1,d0
		bgt.s	loc_192E8
		tst.b	Off3D(a0)
		bne.s	loc_192E8
		move.w	Object_RAM+X_Pos,d1
		subi.w	#$2C00,d1
		asr.w	#5,d1
		cmp.b	Off34(a0),d1
		bne.s	loc_192E8
		moveq	#0,d0
		move.b	Off34(a0),d0
		asl.w	#5,d0
		addi.w	#$2C10,d0
		move.w	d0,Off30(a0)
		bsr.w	Obj75_FindBlocks
		addq.b	#2,Routine2(a0)
		clr.w	Subtype(a0)
		clr.w	X_Vel(a0)

loc_192E8:
		bra.w	loc_191DE
; ===========================================================================

loc_192EC:				; XREF: Obj75_ShipIndex
		moveq	#0,d0
		move.b	Subtype(a0),d0
		move.w	off_192FA(pc,d0.w),d0
		jmp	off_192FA(pc,d0.w)
; ===========================================================================
off_192FA:	dc.w loc_19302-off_192FA
		dc.w loc_19348-off_192FA
		dc.w loc_1938E-off_192FA
		dc.w loc_193D0-off_192FA
; ===========================================================================

loc_19302:				; XREF: off_192FA
		move.w	#$180,Y_Vel(a0)
		move.w	Off38(a0),d0
		cmpi.w	#$556,d0
		bcs.s	loc_19344
		move.w	#$556,Off38(a0)
		clr.w	Off3C(a0)
		moveq	#-1,d0
		move.w	Off36(a0),d0
		beq.s	loc_1933C
		movea.l	d0,a1
		move.b	#-1,$29(a1)
		move.b	#-1,$29(a0)
		move.l	a0,Off34(a1)
		move.w	#$32,Off3C(a0)

loc_1933C:
		clr.w	Y_Vel(a0)
		addq.b	#2,Subtype(a0)

loc_19344:
		bra.w	loc_191F2
; ===========================================================================

loc_19348:				; XREF: off_192FA
		subq.w	#1,Off3C(a0)
		bpl.s	loc_19366
		addq.b	#2,Subtype(a0)
		move.w	#-$800,Y_Vel(a0)
		tst.w	Off36(a0)
		bne.s	loc_19362
		asr	Y_Vel(a0)

loc_19362:
		moveq	#0,d0
		bra.s	loc_1937C
; ===========================================================================

loc_19366:
		moveq	#0,d0
		cmpi.w	#$1E,Off3C(a0)
		bgt.s	loc_1937C
		moveq	#2,d0
		btst	#1,Off3D(a0)
		beq.s	loc_1937C
		neg.w	d0

loc_1937C:
		add.w	Off38(a0),d0
		move.w	d0,Y_Pos(a0)
		move.w	Off30(a0),X_pos(a0)
		bra.w	loc_19202
; ===========================================================================

loc_1938E:				; XREF: off_192FA
		move.w	#$4DA,d0
		tst.w	Off36(a0)
		beq.s	loc_1939C
		subi.w	#$18,d0

loc_1939C:
		cmp.w	Off38(a0),d0
		blt.s	loc_193BE
		move.w	#8,Off3C(a0)
		tst.w	Off36(a0)
		beq.s	loc_193B4
		move.w	#$2D,Off3C(a0)

loc_193B4:
		addq.b	#2,Subtype(a0)
		clr.w	Y_Vel(a0)
		bra.s	loc_193CC
; ===========================================================================

loc_193BE:
		cmpi.w	#-$40,Y_Vel(a0)
		bge.s	loc_193CC
		addi.w	#$C,Y_Vel(a0)

loc_193CC:
		bra.w	loc_191F2
; ===========================================================================

loc_193D0:				; XREF: off_192FA
		subq.w	#1,Off3C(a0)
		bgt.s	loc_19406
		bmi.s	loc_193EE
		moveq	#-1,d0
		move.w	Off36(a0),d0
		beq.s	loc_193E8
		movea.l	d0,a1
		move.b	#$A,$29(a1)

loc_193E8:
		clr.w	Off36(a0)
		bra.s	loc_19406
; ===========================================================================

loc_193EE:
		cmpi.w	#-$1E,Off3C(a0)
		bne.s	loc_19406
		clr.b	$29(a0)
		subq.b	#2,Routine2(a0)
		move.b	#-1,Off3D(a0)
		bra.s	loc_19446
; ===========================================================================

loc_19406:
		moveq	#1,d0
		tst.w	Off36(a0)
		beq.s	loc_19410
		moveq	#2,d0

loc_19410:
		cmpi.w	#$4DA,Off38(a0)
		beq.s	loc_19424
		blt.s	loc_1941C
		neg.w	d0

loc_1941C:
		tst.w	Off36(a0)
		add.w	d0,Off38(a0)

loc_19424:
		moveq	#0,d0
		tst.w	Off36(a0)
		beq.s	loc_19438
		moveq	#2,d0
		btst	#0,Off3D(a0)
		beq.s	loc_19438
		neg.w	d0

loc_19438:
		add.w	Off38(a0),d0
		move.w	d0,Y_Pos(a0)
		move.w	Off30(a0),X_pos(a0)

loc_19446:
		bra.w	loc_19202

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Obj75_FindBlocks:			; XREF: loc_192AE
		clr.w	Off36(a0)
		lea	($FFFFD040).w,a1
		moveq	#$3E,d0
		moveq	#$76,d1
		move.b	Off34(a0),d2

Obj75_FindLoop:
		cmp.b	(a1),d1		; is object a SYZ boss block?
		bne.s	loc_1946A	; if not, branch
		cmp.b	Subtype(a1),d2
		bne.s	loc_1946A
		move.w	a1,Off36(a0)
		bra.s	locret_19472
; ===========================================================================

loc_1946A:
		lea	Next_Obj(a1),a1	; next object RAM entry
		dbf	d0,Obj75_FindLoop

locret_19472:
		rts	
; End of function Obj75_FindBlocks

; ===========================================================================

loc_19474:				; XREF: Obj75_ShipIndex
		subq.w	#1,Off3C(a0)
		bmi.s	loc_1947E
		bra.w	BossDefeated
; ===========================================================================

loc_1947E:
		addq.b	#2,Routine2(a0)
		clr.w	Y_Vel(a0)
		bset	#0,Status(a0)
		bclr	#7,Status(a0)
		clr.w	X_Vel(a0)
		move.w	#-1,Off3C(a0)
		tst.b	($FFFFF7A7).w
		bne.s	loc_194A8
		move.b	#1,($FFFFF7A7).w

loc_194A8:
		bra.w	loc_19202
; ===========================================================================

loc_194AC:				; XREF: Obj75_ShipIndex
		addq.w	#1,Off3C(a0)
		beq.s	loc_194BC
		bpl.s	loc_194C2
		addi.w	#$18,Y_Vel(a0)
		bra.s	loc_194EE
; ===========================================================================

loc_194BC:
		clr.w	Y_Vel(a0)
		bra.s	loc_194EE
; ===========================================================================

loc_194C2:
		cmpi.w	#$20,Off3C(a0)
		bcs.s	loc_194DA
		beq.s	loc_194E0
		cmpi.w	#$2A,Off3C(a0)
		bcs.s	loc_194EE
		addq.b	#2,Routine2(a0)
		bra.s	loc_194EE
; ===========================================================================

loc_194DA:
		subq.w	#8,Y_Vel(a0)
		bra.s	loc_194EE
; ===========================================================================

loc_194E0:
		clr.w	Y_Vel(a0)
		moveq	#$FFFFFFE0,d0
		jsr	PlayMusic		; fade music out

loc_194EE:
		bra.w	loc_191F2
; ===========================================================================

loc_194F2:				; XREF: Obj75_ShipIndex
		move.w	#$400,X_Vel(a0)
		move.w	#-$40,Y_Vel(a0)
		cmpi.w	#$2D40,($FFFFF72A).w
		bcc.s	loc_1950C
		addq.w	#2,($FFFFF72A).w
		bra.s	loc_19512
; ===========================================================================

loc_1950C:
		tst.b	Render_Flags(a0)
		bpl.s	Obj75_ShipDelete

loc_19512:
		bsr.w	BossMove
		bra.w	loc_191DE
; ===========================================================================

Obj75_ShipDelete:
		jmp	DeleteObject
; ===========================================================================

Obj75_FaceMain:				; XREF: Obj75_Index
		moveq	#1,d1
		movea.l	Off34(a0),a1
		moveq	#0,d0
		move.b	Routine2(a1),d0
		move.w	off_19546(pc,d0.w),d0
		jsr	off_19546(pc,d0.w)
		move.b	d1,Anim(a0)
		move.b	(a0),d0
		cmp.b	(a1),d0
		bne.s	Obj75_FaceDelete
		bra.s	loc_195BE
; ===========================================================================

Obj75_FaceDelete:
		jmp	DeleteObject
; ===========================================================================
off_19546:	dc.w loc_19574-off_19546, loc_19574-off_19546
		dc.w loc_1955A-off_19546, loc_19552-off_19546
		dc.w loc_19552-off_19546, loc_19556-off_19546
; ===========================================================================

loc_19552:				; XREF: off_19546
		moveq	#$A,d1
		rts	
; ===========================================================================

loc_19556:				; XREF: off_19546
		moveq	#6,d1
		rts	
; ===========================================================================

loc_1955A:				; XREF: off_19546
		moveq	#0,d0
		move.b	Subtype(a1),d0
		move.w	off_19568(pc,d0.w),d0
		jmp	off_19568(pc,d0.w)
; ===========================================================================
off_19568:	dc.w loc_19570-off_19568, loc_19572-off_19568
		dc.w loc_19570-off_19568, loc_19570-off_19568
; ===========================================================================

loc_19570:				; XREF: off_19568
		bra.s	loc_19574
; ===========================================================================

loc_19572:				; XREF: off_19568
		moveq	#6,d1

loc_19574:				; XREF: off_19546
		tst.b	Coll(a1)
		bne.s	loc_1957E
		moveq	#5,d1
		rts	
; ===========================================================================

loc_1957E:
		cmpi.b	#4,Object_RAM+Routine
		bcs.s	locret_19588
		moveq	#4,d1

locret_19588:
		rts	
; ===========================================================================

Obj75_FlameMain:			; XREF: Obj75_Index
		move.b	#7,Anim(a0)
		movea.l	Off34(a0),a1
		cmpi.b	#$A,Routine2(a1)
		bne.s	loc_195AA
		move.b	#$B,Anim(a0)
		tst.b	Render_Flags(a0)
		bpl.s	Obj75_FlameDelete
		bra.s	loc_195B6
; ===========================================================================

loc_195AA:
		tst.w	X_Vel(a1)
		beq.s	loc_195B6
		move.b	#8,Anim(a0)

loc_195B6:
		bra.s	loc_195BE
; ===========================================================================

Obj75_FlameDelete:
		jmp	DeleteObject
; ===========================================================================

loc_195BE:
		lea	(Ani_Eggman).l,a1
		jsr	AnimateSprite
		movea.l	Off34(a0),a1
		move.w	X_pos(a1),X_pos(a0)
		move.w	Y_Pos(a1),Y_Pos(a0)

loc_195DA:
		move.b	Status(a1),Status(a0)
		moveq	#3,d0
		and.b	Status(a0),d0
		andi.b	#$FC,Render_Flags(a0)
		or.b	d0,Render_Flags(a0)
		jmp	DisplaySprite
; ===========================================================================

Obj75_SpikeMain:			; XREF: Obj75_Index
		move.l	#Map_BossItems,Mappings_Offset(a0)
		move.w	#$246C,Art_Tile(a0)
		move.b	#5,Anim_Frame(a0)
		movea.l	Off34(a0),a1
		cmpi.b	#$A,Routine2(a1)
		bne.s	loc_1961C
		tst.b	Render_Flags(a0)
		bpl.s	Obj75_SpikeDelete

loc_1961C:
		move.w	X_pos(a1),X_pos(a0)
		move.w	Y_Pos(a1),Y_Pos(a0)
		move.w	Off3C(a0),d0
		cmpi.b	#4,Routine2(a1)
		bne.s	loc_19652
		cmpi.b	#6,Subtype(a1)
		beq.s	loc_1964C
		tst.b	Subtype(a1)
		bne.s	loc_19658
		cmpi.w	#$94,d0
		bge.s	loc_19658
		addq.w	#7,d0
		bra.s	loc_19658
; ===========================================================================

loc_1964C:
		tst.w	Off3C(a1)
		bpl.s	loc_19658

loc_19652:
		tst.w	d0
		ble.s	loc_19658
		subq.w	#5,d0

loc_19658:
		move.w	d0,Off3C(a0)
		asr.w	#2,d0
		add.w	d0,Y_Pos(a0)
		move.b	#8,X_Visible(a0)
		move.b	#$C,Y_Radius(a0)
		clr.b	Coll(a0)
		movea.l	Off34(a0),a1
		tst.b	Coll(a1)
		beq.s	loc_19688
		tst.b	$29(a1)
		bne.s	loc_19688
		move.b	#$84,Coll(a0)

loc_19688:
		bra.w	loc_195DA
; ===========================================================================

Obj75_SpikeDelete:
		jmp	DeleteObject
; ===========================================================================
; ---------------------------------------------------------------------------
; Object 76 - blocks that Eggman picks up (SYZ)
; ---------------------------------------------------------------------------

Obj76:					; XREF: Obj_Index
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	Obj76_Index(pc,d0.w),d1
		jmp	Obj76_Index(pc,d1.w)
; ===========================================================================
Obj76_Index:	dc.w Obj76_Main-Obj76_Index
		dc.w Obj76_Action-Obj76_Index
		dc.w loc_19762-Obj76_Index
; ===========================================================================

Obj76_Main:				; XREF: Obj76_Index
		moveq	#0,d4
		move.w	#$2C10,d5
		moveq	#9,d6
		lea	(a0),a1
		bra.s	Obj76_MakeBlock
; ===========================================================================

Obj76_Loop:
		jsr	SingleObjLoad
		bne.s	Obj76_ExitLoop

Obj76_MakeBlock:			; XREF: Obj76_Main
		move.b	#$76,(a1)
		move.l	#Map_obj76,Mappings_Offset(a1)
		move.w	#$4000,Art_Tile(a1)
		move.b	#4,Render_Flags(a1)
		move.b	#$10,X_Visible(a1)
		move.b	#$10,Y_Radius(a1)
		move.b	#3,Priority(a1)
		move.w	d5,X_pos(a1)	; set x-position
		move.w	#$582,Y_Pos(a1)
		move.w	d4,Subtype(a1)
		addi.w	#$101,d4
		addi.w	#$20,d5		; add $20 to next x-position
		addq.b	#2,Routine(a1)
		dbf	d6,Obj76_Loop	; repeat sequence 9 more times

Obj76_ExitLoop:
		rts	
; ===========================================================================

Obj76_Action:				; XREF: Obj76_Index
		move.b	$29(a0),d0
		cmp.b	Subtype(a0),d0
		beq.s	Obj76_Solid
		tst.b	d0
		bmi.s	loc_19718

loc_19712:
		bsr.w	Obj76_Break
		bra.s	Obj76_Display
; ===========================================================================

loc_19718:
		movea.l	Off34(a0),a1
		tst.b	Coll2(a1)
		beq.s	loc_19712
		move.w	X_pos(a1),X_pos(a0)
		move.w	Y_Pos(a1),Y_Pos(a0)
		addi.w	#$2C,Y_Pos(a0)
		cmpa.w	a0,a1
		bcs.s	Obj76_Display
		move.w	Y_Vel(a1),d0
		ext.l	d0
		asr.l	#8,d0
		add.w	d0,Y_Pos(a0)
		bra.s	Obj76_Display
; ===========================================================================

Obj76_Solid:				; XREF: Obj76_Action
		move.w	#$1B,d1
		move.w	#$10,d2
		move.w	#$11,d3
		move.w	X_pos(a0),d4
		jsr	SolidObject

Obj76_Display:				; XREF: Obj76_Action
		jmp	DisplaySprite
; ===========================================================================

loc_19762:				; XREF: Obj76_Index
		tst.b	Render_Flags(a0)
		bpl.s	Obj76_Delete
		jsr	ObjectFall
		jmp	DisplaySprite
; ===========================================================================

Obj76_Delete:
		jmp	DeleteObject

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Obj76_Break:				; XREF: Obj76_Action
		lea	Obj76_FragSpeed(pc),a4
		lea	Obj76_FragPos(pc),a5
		moveq	#1,d4
		moveq	#3,d1
		moveq	#$38,d2
		addq.b	#2,Routine(a0)
		move.b	#8,X_Visible(a0)
		move.b	#8,Y_Radius(a0)
		lea	(a0),a1
		bra.s	Obj76_MakeFrag
; ===========================================================================

Obj76_LoopFrag:
		jsr	SingleObjLoad2
		bne.s	loc_197D4

Obj76_MakeFrag:
		lea	(a0),a2
		lea	(a1),a3
		moveq	#3,d3

loc_197AA:
		move.l	(a2)+,(a3)+
		move.l	(a2)+,(a3)+
		move.l	(a2)+,(a3)+
		move.l	(a2)+,(a3)+
		dbf	d3,loc_197AA

		move.w	(a4)+,X_Vel(a1)
		move.w	(a4)+,Y_Vel(a1)
		move.w	(a5)+,d3
		add.w	d3,X_pos(a1)
		move.w	(a5)+,d3
		add.w	d3,Y_Pos(a1)
		move.b	d4,Anim_Frame(a1)
		addq.w	#1,d4
		dbf	d1,Obj76_LoopFrag ; repeat sequence 3 more times

loc_197D4:
		move.w	#$CB,d0
		jmp	(PlaySound).l ;	play smashing sound
; End of function Obj76_Break

; ===========================================================================
Obj76_FragSpeed:dc.w $FE80, $FE00
		dc.w $180, $FE00
		dc.w $FF00, $FF00
		dc.w $100, $FF00
Obj76_FragPos:	dc.w $FFF8, $FFF8
		dc.w $10, 0
		dc.w 0,	$10
		dc.w $10, $10
; ---------------------------------------------------------------------------
; Sprite mappings - blocks that	Eggman picks up (SYZ)
; ---------------------------------------------------------------------------
Map_obj76:
	include "_maps\obj76.asm"

; ===========================================================================

loc_1982C:				; XREF: loc_19C62; loc_19C80
		jmp	DeleteObject