; ---------------------------------------------------------------------------
; Object - Boss (SBZ3 (FZ))
; ---------------------------------------------------------------------------
; ===========================================================================

SBZ3_Boss:					; XREF: Obj_Index
Obj85:					; XREF: Obj_Index
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	SBZ3_Boss_Index(pc,d0.w),d0
		jmp	SBZ3_Boss_Index(pc,d0.w)
; ===========================================================================
SBZ3_Boss_Index:dc.w SBZ3_Boss_Main-SBZ3_Boss_Index
		dc.w SBZ3_Boss_Eggman-SBZ3_Boss_Index
		dc.w SBZ3_Boss_Delete-SBZ3_Boss_Index
		dc.w SBZ3_Boss_Delete-SBZ3_Boss_Index
		dc.w SBZ3_Boss_Delete-SBZ3_Boss_Index
		dc.w SBZ3_Boss_Delete-SBZ3_Boss_Index
		dc.w SBZ3_Boss_Delete-SBZ3_Boss_Index

SBZ3_Boss_ObjData:
		dc.w $100, $100, $470	; X pos, Y pos,	VRAM setting
		dc.l Map_obj82		; mappings pointer
		dc.w $25B0, $590, $300
		dc.l Map_obj84
		dc.w $26E0, $596, $3A0
		dc.l Map_FZBoss
		dc.w $26E0, $596, $470
		dc.l Map_obj82
		dc.w $26E0, $596, $400
		dc.l Map_Eggman
		dc.w $26E0, $596, $400
		dc.l Map_Eggman

SBZ3_Boss_ObjData2:
		dc.b 2,	0, 4, $20, $19	; routine num, animation, sprite priority, width, height
		dc.b 4,	0, 1, $12, 8
		dc.b 6,	0, 3, 0, 0
		dc.b 8,	0, 3, 0, 0
		dc.b $A, 0, 3, $20, $20
		dc.b $C, 0, 3, 0, 0
; ===========================================================================

SBZ3_Boss_Main:				; XREF: SBZ3_Boss_Index
		move.w	#0,VScroll_RAM.w
		lea	SBZ3_Boss_ObjData(pc),a2
		lea	SBZ3_Boss_ObjData2(pc),a3
		movea.l	a0,a1
		moveq	#5,d1
		bra.s	SBZ3_Boss_LoadBoss
; ===========================================================================

SBZ3_Boss_Loop:
		jsr	SingleObjLoad2
		bne.s	loc_19E20

SBZ3_Boss_LoadBoss:				; XREF: SBZ3_Boss_Main
		move.b	#$85,(a1)
		move.w	(a2)+,X_pos(a1)
		move.w	(a2)+,Y_Pos(a1)
		move.w	(a2)+,Art_Tile(a1)
		move.l	(a2)+,Mappings_Offset(a1)
		move.b	(a3)+,Routine(a1)
		move.b	(a3)+,Anim(a1)
		move.b	(a3)+,Priority(a1)
		move.b	(a3)+,X_Radius(a1)
		move.b	(a3)+,Y_Radius(a1)
		move.b	#$20,X_Visible(a1)
		move.b	#4,Render_Flags(a1)
		bset	#7,Render_Flags(a0)
		move.l	a0,Off34(a1)
		dbf	d1,SBZ3_Boss_Loop

loc_19E20:
		lea	Off36(a0),a2
		jsr	SingleObjLoad
		bne.s	loc_19E5A
		move.b	#$86,(a1)	; load energy ball object
		move.w	a1,(a2)
		move.l	a0,Off34(a1)
		lea	Off38(a0),a2
		moveq	#0,d2
		moveq	#3,d1

loc_19E3E:
		jsr	SingleObjLoad2
		bne.s	loc_19E5A
		move.w	a1,(a2)+
		move.b	#$84,(a1)	; load crushing	cylinder object
		move.l	a0,Off34(a1)
		move.b	d2,Subtype(a1)
		addq.w	#2,d2
		dbf	d1,loc_19E3E

loc_19E5A:
		move.w	#0,Off34(a0)
		move.b	#8,Coll2(a0)	; set number of	hits to	8
		move.w	#-1,Off30(a0)
		st	BossMode.w

SBZ3_Boss_Eggman:				; XREF: SBZ3_Boss_Index
		moveq	#0,d0
		move.b	Off34(a0),d0
		move.w	off_19E80(pc,d0.w),d0
		jsr	off_19E80(pc,d0.w)
		jmp	DisplaySprite
; ===========================================================================
off_19E80:	dc.w loc_19E90-off_19E80, loc_19EA8-off_19E80
		dc.w loc_19FE6-off_19E80, loc_1A02A-off_19E80
		dc.w loc_1A074-off_19E80, loc_1A112-off_19E80
		dc.w loc_1A192-off_19E80, loc_1A1D4-off_19E80
; ===========================================================================

loc_19E90:				; XREF: off_19E80
		tst.l	($FFFFF680).w
		bne.s	loc_19EA2
		cmpi.w	#$2450,($FFFFF700).w
		bcs.s	loc_19EA2
		addq.b	#2,Off34(a0)

loc_19EA2:
		addq.l	#1,($FFFFF636).w
		rts
; ===========================================================================

loc_19EA8:				; XREF: off_19E80
		tst.w	Off30(a0)
		bpl.s	loc_19F10
		clr.w	Off30(a0)
		jsr	(RandomNumber).l
		andi.w	#$C,d0
		move.w	d0,d1
		addq.w	#2,d1
		tst.l	d0
		bpl.s	loc_19EC6
		exg	d1,d0

loc_19EC6:
		lea	word_19FD6(pc),a1
		move.w	(a1,d0.w),d0
		move.w	(a1,d1.w),d1
		move.w	d0,Off30(a0)
		moveq	#-1,d2
		move.w	Off38(a0,d0.w),d2
		movea.l	d2,a1
		move.b	#-1,$29(a1)
		move.w	#-1,Off30(a1)
		move.w	Off38(a0,d1.w),d2
		movea.l	d2,a1
		move.b	#1,$29(a1)
		move.w	#0,Off30(a1)
		move.w	#1,Off32(a0)
		sf	Off35(a0)
		move.w	#$B7,d0
		jsr	(PlaySound).l ;	play rumbling sound
		move.w	#-1,ShakeOffset_Mode.w		; screen shake

loc_19F10:
		tst.w	Off32(a0)
		bmi.w	loc_19FA6
		bclr	#0,Status(a0)
		move.w	Object_RAM+X_Pos,d0
		sub.w	X_pos(a0),d0
		bcs.s	loc_19F2E
		bset	#0,Status(a0)

loc_19F2E:
		move.w	#$2B,d1
		move.w	#$14,d2
		move.w	#$14,d3
		move.w	X_pos(a0),d4
		jsr	SolidObject
		tst.w	d4
		bgt.s	loc_19F50

loc_19F48:
		tst.b	Off35(a0)
		bne.s	loc_19F88
		bra.s	loc_19F96
; ===========================================================================

loc_19F50:
		addq.w	#7,($FFFFF636).w
		cmpi.b	#2,Object_RAM+Anim
		bne.s	loc_19F48
		move.w	#$300,d0
		btst	#0,Status(a0)
		bne.s	loc_19F6A
		neg.w	d0

loc_19F6A:
		move.w	d0,Object_RAM+X_Vel
		tst.b	Off35(a0)
		bne.s	loc_19F88
		subq.b	#1,Coll2(a0)
		move.b	#$64,Off35(a0)
		move.w	#$AC,d0
		jsr	(PlaySound).l ;	play boss damage sound
		jsr	LoadNextFZPalette

		move.b	Coll2(a0),d0
		tas	d0
		move.b	d0,BossLives.w	; livescnt

loc_19F88:
		subq.b	#1,Off35(a0)
		beq.s	loc_19F96
		move.b	#3,Anim(a0)
		bra.s	loc_19F9C
; ===========================================================================

loc_19F96:
		move.b	#1,Anim(a0)

loc_19F9C:
		lea	Ani_obj82(pc),a1
		jmp	AnimateSprite
; ===========================================================================

loc_19FA6:
		tst.b	Coll2(a0)
		beq.s	loc_19FBC
		bmi.s	loc_19FBC
		addq.b	#2,Off34(a0)
		move.w	#-1,Off30(a0)
		clr.w	Off32(a0)
		rts
; ===========================================================================

loc_19FBC:
		move.b	#6,Off34(a0)
		move.w	#$25C0,X_pos(a0)
		move.w	#$53C,Y_Pos(a0)
		move.b	#$14,Y_Radius(a0)
		rts
; ===========================================================================
word_19FD6:	dc.w 0,	2, 2, 4, 4, 6, 6, 0
; ===========================================================================

loc_19FE6:				; XREF: off_19E80
		moveq	#-1,d0
		move.w	Off36(a0),d0
		movea.l	d0,a1
		tst.w	Off30(a0)
		bpl.s	loc_1A000
		clr.w	Off30(a0)
		move.b	#-1,$29(a1)
		bsr.s	loc_1A020

loc_1A000:
		moveq	#$F,d0
		and.w	($FFFFFE0E).w,d0
		bne.s	loc_1A00A
		bsr.s	loc_1A020

loc_1A00A:
		tst.w	Off32(a0)
		beq.s	locret_1A01E
		subq.b	#2,Off34(a0)
		move.w	#-1,Off30(a0)
		clr.w	Off32(a0)

locret_1A01E:
		rts
; ===========================================================================

loc_1A020:
		move.w	#0,ShakeOffset_Mode.w		; screen shake
		move.w	#$B1,d0
		jmp	(PlaySound).l ;	play electricity sound
; ===========================================================================

loc_1A02A:				; XREF: off_19E80
		move.w	#2,VScroll_RAM+2.w
		move.w	#30,VScroll_RAM+4.w
		move.b	#$30,X_Radius(a0)
		bset	#0,Status(a0)
		jsr	SpeedToPos
		move.b	#6,Anim_Frame(a0)
		addi.w	#$10,Y_Vel(a0)
		cmpi.w	#$59C,Y_Pos(a0)
		bcs.s	loc_1A070
		move.w	#$59C,Y_Pos(a0)
		addq.b	#2,Off34(a0)
		move.b	#$20,X_Radius(a0)
		move.w	#$100,X_Vel(a0)
		move.w	#-$100,Y_Vel(a0)
		addq.b	#2,($FFFFF742).w

loc_1A070:
		bra.w	SBZ3_Boss_MoveCam
; ===========================================================================

loc_1A074:				; XREF: off_19E80
		bset	#0,Status(a0)
		move.b	#4,Anim(a0)
		jsr	SpeedToPos
		addi.w	#$10,Y_Vel(a0)
		cmpi.w	#$5A3,Y_Pos(a0)
		bcs.s	loc_1A09A
		move.w	#-$40,Y_Vel(a0)

loc_1A09A:
; ===========================================================================

loc_1A0B4:
		move.w	$FFFFF72A.w,d0
		add.w	#$F0,d0
		move.w	d0,X_pos(a0)
		move.w	#3,VScroll_RAM+2.w

loc_1A0F2:
		cmpi.w	#$2800-$10,X_pos(a0)
		bcs.s	loc_1A110
		move.w	#$2800-$10,X_pos(a0)
		move.b	#0,Anim(a0)
		subq.w	#1,VScroll_RAM+4.w
		bpl.s	loc_1A110

		move.w	#$C0,X_Vel(a0)
		move.w	#-$4C0,Y_Vel(a0)
		addq.b	#2,Off34(a0)
		move.b	#2,Anim(a0)

loc_1A110:
		bra.s	SBZ3_Boss_AnimateRun
; ===========================================================================

loc_1A112:				; XREF: off_19E80
		jsr	SpeedToPos
		addi.w	#$34,Y_Vel(a0)
		tst.w	Y_Vel(a0)
		bmi.s	loc_1A142
		cmpi.w	#$600,Y_Pos(a0)
		bcs.s	loc_1A142

SBZ3_Boss_Delete:
		jmp	DeleteObject

loc_1A142:

SBZ3_Boss_AnimateRun:
		lea	Ani_obj82(pc),a1
		jsr	AnimateSprite

SBZ3_Boss_MoveCam:
		cmpi.w	#$2700,($FFFFF72A).w
		bge.s	loc_1A172
		move.w	VScroll_RAM+2.w,d0
		add.w	d0,$FFFFF72A.w
		move.w	$FFFFF72A.w,$FFFFF728.w
		move.w	$FFFFF72A.w,$FFFFF700.w
		lsr.w	#1,d0
		add.w	d0,$FFFFF708.w

loc_1A172:
		cmpi.b	#$C,Off34(a0)
		bge.s	locret_1A190
		move.w	#$1B,d1
		move.w	#$70,d2
		move.w	#$71,d3
		move.w	X_pos(a0),d4
		jmp	SolidObject
; ===========================================================================

locret_1A190:
		rts
; ===========================================================================

loc_1A192:				; XREF: off_19E80
		move.l	#Map_Eggman,Mappings_Offset(a0)
		move.w	#$400,Art_Tile(a0)
		move.b	#0,Anim(a0)
		bset	#0,Status(a0)
		jsr	SpeedToPos
		cmpi.w	#$544,Y_Pos(a0)
		bcc.s	loc_1A1D0
		move.w	#$180,X_Vel(a0)
		move.w	#-$18,Y_Vel(a0)
		move.b	#$F,Coll(a0)
		addq.b	#2,Off34(a0)

	; spawn control object to make Sonic super
		cmpi.b	#7,Emeralds.w
		bne.s	loc_1A1D0
		jsr	SingleObjLoad		; load object
		bne.s	loc_1A1D0		; if none could be loaded, branch
		move.b	#$7F,(a1)
		move.l	a0,Off3C(a1)

loc_1A1D0:
		bra.w	SBZ3_Boss_AnimateRun
; ===========================================================================

loc_1A1D4:				; XREF: off_19E80
		bset	#0,Status(a0)
		jsr	SpeedToPos
		tst.w	Off30(a0)
		bne.s	loc_1A1FC
		tst.b	Coll(a0)
		bne.s	loc_1A216
		move.w	#$1E,Off30(a0)
		move.w	#$AC,d0
		jsr	(PlaySound).l ;	play boss damage sound

loc_1A1FC:
		subq.w	#1,Off30(a0)
		bne.s	loc_1A216
		tst.b	Status(a0)
		bmi.s	loc_1A216
	;	move.w	#-$60,Y_Vel(a0)
;		bra.s	loc_1A216
; ===========================================================================

loc_1A210:
		move.b	#$F,Coll(a0)

loc_1A216:
		move.w	$FFFFF700.w,d0
		addi.w	#320+$20,d0
		cmp.w	X_Pos(a0),d0
		bgt.s	loc_1A260

		bra.w	SBZ3_Boss_Delete
; ===========================================================================

loc_1A260:
		bra.w	SBZ3_Boss_AnimateRun
; ===========================================================================

loc_1A264:				; XREF: SBZ3_Boss_Index
		movea.l	Off34(a0),a1
		move.b	(a1),d0
		cmp.b	(a0),d0
		bne.w	SBZ3_Boss_Delete
		move.b	#7,Anim(a0)
		cmpi.b	#$C,Off34(a1)
		bge.s	loc_1A280
		bra.s	loc_1A2A6
; ===========================================================================

loc_1A280:
		tst.w	X_Vel(a1)
		beq.s	loc_1A28C
		move.b	#$B,Anim(a0)

loc_1A28C:
		lea	Ani_Eggman(pc),a1
		jsr	AnimateSprite

loc_1A296:
		movea.l	Off34(a0),a1
		move.w	X_pos(a1),X_pos(a0)
		move.w	Y_Pos(a1),Y_Pos(a0)

loc_1A2A6:
		movea.l	Off34(a0),a1
		move.b	Status(a1),Status(a0)
		moveq	#3,d0
		and.b	Status(a0),d0
		andi.b	#-4,Render_Flags(a0)
		or.b	d0,Render_Flags(a0)
		jmp	DisplaySprite
; ===========================================================================

loc_1A2C6:				; XREF: SBZ3_Boss_Index
		movea.l	Off34(a0),a1
		move.b	(a1),d0
		cmp.b	(a0),d0
		bne.w	SBZ3_Boss_Delete
		cmpi.l	#Map_Eggman,Mappings_Offset(a1)
		beq.s	loc_1A2E4
		move.b	#$A,Anim_Frame(a0)
		bra.s	loc_1A2A6
; ===========================================================================

loc_1A2E4:
		move.b	#1,Anim(a0)
		tst.b	Coll2(a1)
		ble.s	loc_1A312
		move.b	#6,Anim(a0)
		move.l	#Map_Eggman,Mappings_Offset(a0)
		move.w	#$400,Art_Tile(a0)
		lea	Ani_Eggman(pc),a1
		jsr	AnimateSprite
		bra.w	loc_1A296
; ===========================================================================

loc_1A312:
		tst.b	Render_Flags(a0)
		bpl.w	SBZ3_Boss_Delete
		bsr.w	BossDefeated
		move.b	#2,Priority(a0)
		move.b	#0,Anim(a0)
		move.l	#Map_Eggman2,Mappings_Offset(a0)
		move.w	#$3A0,Art_Tile(a0)
		lea	Ani_obj85(pc),a1
		jsr	AnimateSprite
		bra.w	loc_1A296
; ===========================================================================

loc_1A346:				; XREF: SBZ3_Boss_Index
		bset	#0,Status(a0)
		movea.l	Off34(a0),a1
		cmpi.l	#Map_Eggman,Mappings_Offset(a1)
		beq.s	loc_1A35E
		bra.w	loc_1A2A6
; ===========================================================================

loc_1A35E:
		move.w	X_pos(a1),X_pos(a0)
		move.w	Y_Pos(a1),Y_Pos(a0)
		tst.b	Anim_Dur(a0)
		bne.s	loc_1A376
		move.b	#$14,Anim_Dur(a0)

loc_1A376:
		subq.b	#1,Anim_Dur(a0)
		bgt.s	loc_1A38A
		addq.b	#1,Anim_Frame(a0)
		cmpi.b	#2,Anim_Frame(a0)
		bgt.w	SBZ3_Boss_Delete

loc_1A38A:
		bra.w	loc_1A296
; ===========================================================================

loc_1A38E:				; XREF: SBZ3_Boss_Index
		move.b	#$B,Anim_Frame(a0)
		move.w	Object_RAM+X_Pos,d0
		sub.w	X_pos(a0),d0
		bcs.s	loc_1A3A6
		tst.b	Render_Flags(a0)
		bpl.w	SBZ3_Boss_Delete

loc_1A3A6:
		jmp	DisplaySprite
; ===========================================================================

loc_1A3AC:				; XREF: SBZ3_Boss_Index
		move.b	#0,Anim_Frame(a0)
		bset	#0,Status(a0)
		movea.l	Off34(a0),a1
		cmpi.b	#$C,Off34(a1)
		bne.s	loc_1A3D0
		cmpi.l	#Map_Eggman,Mappings_Offset(a1)
		beq.w	SBZ3_Boss_Delete

loc_1A3D0:
		bra.w	loc_1A2A6
; ===========================================================================
Ani_obj85:
	include "_anim\obj85.asm"

Map_Eggman2:
	include "_maps\Eggman2.asm"

Map_FZBoss:
	include "_maps\FZ boss.asm"

; ===========================================================================

Obj84_Delete:
		jmp	DeleteObject

; ===========================================================================
; ---------------------------------------------------------------------------
; Object 84 - cylinder Eggman	hides in (FZ)
; ---------------------------------------------------------------------------

Obj84:					; XREF: Obj_Index
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	Obj84_Index(pc,d0.w),d0
		jmp	Obj84_Index(pc,d0.w)
; ===========================================================================
Obj84_Index:	dc.w Obj84_Main-Obj84_Index
		dc.w loc_1A4CE-Obj84_Index
		dc.w loc_1A57E-Obj84_Index

Obj84_PosData:	dc.w $24D0, $620
		dc.w $2550, $620
		dc.w $2490, $4C0
		dc.w $2510, $4C0
; ===========================================================================

Obj84_Main:				; XREF: Obj84_Index
		lea	Obj84_PosData(pc),a1
		moveq	#0,d0
		move.b	Subtype(a0),d0
		add.w	d0,d0
		adda.w	d0,a1
		move.b	#4,Render_Flags(a0)
		bset	#7,Render_Flags(a0)
		bset	#4,Render_Flags(a0)
		move.w	#$300,Art_Tile(a0)
		move.l	#Map_obj84,Mappings_Offset(a0)
		move.w	(a1)+,X_pos(a0)
		move.w	(a1),Y_Pos(a0)
		move.w	(a1)+,Off38(a0)
		move.b	#$20,Y_Radius(a0)
		move.b	#$60,X_Radius(a0)
		move.b	#$20,X_Visible(a0)
		move.b	#$60,Y_Radius(a0)
		move.b	#3,Priority(a0)
		addq.b	#2,Routine(a0)

loc_1A4CE:				; XREF: Obj84_Index
		cmpi.b	#2,Subtype(a0)
		ble.s	loc_1A4DC
		bset	#1,Render_Flags(a0)

loc_1A4DC:
		clr.l	Off3C(a0)
		tst.b	$29(a0)
		beq.s	loc_1A4EA
		addq.b	#2,Routine(a0)

loc_1A4EA:
		move.l	Off3C(a0),d0
		move.l	Off38(a0),d1
		add.l	d0,d1
		swap	d1
		move.w	d1,Y_Pos(a0)
		cmpi.b	#4,Routine(a0)
		bne.s	loc_1A524
		tst.w	Off30(a0)
		bpl.s	loc_1A524
		moveq	#-$A,d0
		cmpi.b	#2,Subtype(a0)
		ble.s	loc_1A514
		moveq	#$E,d0

loc_1A514:
		add.w	d0,d1
		movea.l	Off34(a0),a1
		move.w	d1,Y_Pos(a1)
		move.w	X_pos(a0),X_pos(a1)

loc_1A524:
		move.w	#$2B,d1
		move.w	#$60,d2
		move.w	#$61,d3
		move.w	X_pos(a0),d4
		jsr	SolidObject
		moveq	#0,d0
		move.w	Off3C(a0),d1
		bpl.s	loc_1A550
		neg.w	d1
		subq.w	#8,d1
		bcs.s	loc_1A55C
		addq.b	#1,d0
		asr.w	#4,d1
		add.w	d1,d0
		bra.s	loc_1A55C
; ===========================================================================

loc_1A550:
		subi.w	#$27,d1
		bcs.s	loc_1A55C
		addq.b	#1,d0
		asr.w	#4,d1
		add.w	d1,d0

loc_1A55C:
		move.b	d0,Anim_Frame(a0)
		move.w	Object_RAM+X_Pos,d0
		sub.w	X_pos(a0),d0
		bmi.s	loc_1A578
		subi.w	#$140,d0
		bmi.s	loc_1A578
		tst.b	Render_Flags(a0)
		bpl.w	Obj84_Delete

loc_1A578:
		jmp	DisplaySprite
; ===========================================================================

loc_1A57E:				; XREF: Obj84_Index
		moveq	#0,d0
		move.b	Subtype(a0),d0
		move.w	off_1A590(pc,d0.w),d0
		jsr	off_1A590(pc,d0.w)
		bra.w	loc_1A4EA
; ===========================================================================
off_1A590:	dc.w loc_1A598-off_1A590
		dc.w loc_1A598-off_1A590
		dc.w loc_1A604-off_1A590
		dc.w loc_1A604-off_1A590
; ===========================================================================

loc_1A598:				; XREF: off_1A590
		tst.b	$29(a0)
		bne.s	loc_1A5D4
		movea.l	Off34(a0),a1
		tst.b	Coll2(a1)
		bne.s	loc_1A5B4
		bsr.w	BossDefeated
		subi.l	#$10000,Off3C(a0)

loc_1A5B4:
		addi.l	#$20000,Off3C(a0)
		bcc.s	locret_1A602
		clr.l	Off3C(a0)
		movea.l	Off34(a0),a1
		subq.w	#1,Off32(a1)
		clr.w	Off30(a1)
		subq.b	#2,Routine(a0)
		rts
; ===========================================================================

loc_1A5D4:
		cmpi.w	#-$10,Off3C(a0)
		bge.s	loc_1A5E4
		subi.l	#$28000,Off3C(a0)

loc_1A5E4:
		subi.l	#$8000,Off3C(a0)
		cmpi.w	#-$A0,Off3C(a0)
		bgt.s	locret_1A602
		clr.w	Off3E(a0)
		move.w	#-$A0,Off3C(a0)
		clr.b	$29(a0)

locret_1A602:
		rts
; ===========================================================================

loc_1A604:				; XREF: off_1A590
		bset	#1,Render_Flags(a0)
		tst.b	$29(a0)
		bne.s	loc_1A646
		movea.l	Off34(a0),a1
		tst.b	Coll2(a1)
		bne.s	loc_1A626
		bsr.w	BossDefeated
		addi.l	#$10000,Off3C(a0)

loc_1A626:
		subi.l	#$20000,Off3C(a0)
		bcc.s	locret_1A674
		clr.l	Off3C(a0)
		movea.l	Off34(a0),a1
		subq.w	#1,Off32(a1)
		clr.w	Off30(a1)
		subq.b	#2,Routine(a0)
		rts
; ===========================================================================

loc_1A646:
		cmpi.w	#$10,Off3C(a0)
		blt.s	loc_1A656
		addi.l	#$28000,Off3C(a0)

loc_1A656:
		addi.l	#$8000,Off3C(a0)
		cmpi.w	#$A0,Off3C(a0)
		blt.s	locret_1A674
		clr.w	Off3E(a0)
		move.w	#$A0,Off3C(a0)
		clr.b	$29(a0)

locret_1A674:
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Sprite mappings - cylinders Eggman hides in (FZ)
; ---------------------------------------------------------------------------
Map_obj84:
	include "_maps\obj84.asm"

; ===========================================================================
; ---------------------------------------------------------------------------
; Object 86 - energy balls (FZ)
; ---------------------------------------------------------------------------

Obj86:					; XREF: Obj_Index
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	Obj86_Index(pc,d0.w),d0
		jmp	Obj86_Index(pc,d0.w)
; ===========================================================================
Obj86_Index:	dc.w Obj86_Main-Obj86_Index
		dc.w Obj86_Generator-Obj86_Index
		dc.w Obj86_MakeBalls-Obj86_Index
		dc.w loc_1A962-Obj86_Index
		dc.w loc_1A982-Obj86_Index
; ===========================================================================

Obj86_Main:				; XREF: Obj86_Index
		move.w	#$2588,X_pos(a0)
		move.w	#$53C,Y_Pos(a0)
		move.w	#$300,Art_Tile(a0)
		move.l	#Map_obj86,Mappings_Offset(a0)
		move.b	#0,Anim(a0)
		move.b	#3,Priority(a0)
		move.b	#8,X_Radius(a0)
		move.b	#8,Y_Radius(a0)
		move.b	#4,Render_Flags(a0)
		bset	#7,Render_Flags(a0)
		addq.b	#2,Routine(a0)

Obj86_Generator:			; XREF: Obj86_Index
		movea.l	Off34(a0),a1
		cmpi.b	#6,Off34(a1)
		bne.s	loc_1A850
		move.b	#$3F,(a0)
		move.b	#0,Routine(a0)
		jmp	DisplaySprite
; ===========================================================================

loc_1A850:
		move.b	#0,Anim(a0)
		tst.b	$29(a0)
		beq.s	loc_1A86C
		addq.b	#2,Routine(a0)
		move.b	#1,Anim(a0)
		move.b	#$3E,Subtype(a0)

loc_1A86C:
		move.w	#$13,d1
		move.w	#8,d2
		move.w	#$11,d3
		move.w	X_pos(a0),d4
		jsr	SolidObject
		move.w	Object_RAM+X_Pos,d0
		sub.w	X_pos(a0),d0
		bmi.s	loc_1A89A
		subi.w	#$140,d0
		bmi.s	loc_1A89A
		tst.b	Render_Flags(a0)
		bpl.w	Obj84_Delete

loc_1A89A:
		lea	Ani_obj86(pc),a1
		jsr	AnimateSprite
		jmp	DisplaySprite
; ===========================================================================

Obj86_MakeBalls:			; XREF: Obj86_Index
		tst.b	$29(a0)
		beq.w	loc_1A954
		clr.b	$29(a0)
		add.w	Off30(a0),d0
		andi.w	#$1E,d0
		adda.w	d0,a2
		addq.w	#4,Off30(a0)
		clr.w	Off32(a0)
		moveq	#3,d2

Obj86_Loop:
		jsr	SingleObjLoad2
		bne.w	loc_1A954
		move.b	#$86,(a1)
		move.w	X_pos(a0),X_pos(a1)
		move.w	#$53C,Y_Pos(a1)
		move.b	#8,Routine(a1)
		move.w	#$2300,Art_Tile(a1)
		move.l	#Map_obj86a,Mappings_Offset(a1)
		move.b	#$C,Y_Radius(a1)
		move.b	#$C,X_Radius(a1)
		move.b	#0,Coll(a1)
		move.b	#3,Priority(a1)
		move.w	#$3E,Subtype(a1)
		move.b	#4,Render_Flags(a1)
		bset	#7,Render_Flags(a1)
		move.l	a0,Off34(a1)
		jsr	(RandomNumber).l
		move.w	Off32(a0),d1
		muls.w	#-$4F,d1
		addi.w	#$2578,d1
		andi.w	#$1F,d0
		subi.w	#$10,d0
		add.w	d1,d0
		move.w	d0,Off30(a1)
		addq.w	#1,Off32(a0)
		move.w	Off32(a0),Off38(a0)
		dbf	d2,Obj86_Loop	; repeat sequence 3 more times

loc_1A954:
		tst.w	Off32(a0)
		bne.s	loc_1A95E
		addq.b	#2,Routine(a0)

loc_1A95E:
		bra.w	loc_1A86C
; ===========================================================================

loc_1A962:				; XREF: Obj86_Index
		move.b	#2,Anim(a0)
		tst.w	Off38(a0)
		bne.s	loc_1A97E
		move.b	#2,Routine(a0)
		movea.l	Off34(a0),a1
		move.w	#-1,Off32(a1)

loc_1A97E:
		bra.w	loc_1A86C
; ===========================================================================

loc_1A982:				; XREF: Obj86_Index
		moveq	#0,d0
		move.b	Routine2(a0),d0
		move.w	Obj86_Index2(pc,d0.w),d0
		jsr	Obj86_Index2(pc,d0.w)
		lea	Ani_obj86a(pc),a1
		jsr	AnimateSprite
		jmp	DisplaySprite
; ===========================================================================
Obj86_Index2:	dc.w loc_1A9A6-Obj86_Index2
		dc.w loc_1A9C0-Obj86_Index2
		dc.w loc_1AA1E-Obj86_Index2
; ===========================================================================

loc_1A9A6:				; XREF: Obj86_Index2
		move.w	Off30(a0),d0
		sub.w	X_pos(a0),d0
		asl.w	#4,d0
		move.w	d0,X_Vel(a0)
		move.w	#$B4,Subtype(a0)
		addq.b	#2,Routine2(a0)
		rts
; ===========================================================================

loc_1A9C0:				; XREF: Obj86_Index2
		tst.w	X_Vel(a0)
		beq.s	loc_1A9E6
		jsr	SpeedToPos
		move.w	X_pos(a0),d0
		sub.w	Off30(a0),d0
		bcc.s	loc_1A9E6
		clr.w	X_Vel(a0)
		add.w	d0,X_pos(a0)
		movea.l	Off34(a0),a1
		subq.w	#1,Off32(a1)

loc_1A9E6:
		move.b	#0,Anim(a0)
		subq.w	#1,Subtype(a0)
		bne.s	locret_1AA1C
		addq.b	#2,Routine2(a0)
		move.b	#1,Anim(a0)
		move.b	#$9A,Coll(a0)
		move.w	#$B4,Subtype(a0)
		moveq	#0,d0
		move.w	Object_RAM+X_Pos,d0
		sub.w	X_pos(a0),d0
		move.w	d0,X_Vel(a0)
		move.w	#$140,Y_Vel(a0)

locret_1AA1C:
		rts
; ===========================================================================

loc_1AA1E:				; XREF: Obj86_Index2
		jsr	SpeedToPos
		cmpi.w	#$5E0,Y_Pos(a0)
		bcc.s	loc_1AA34
		subq.w	#1,Subtype(a0)
		beq.s	loc_1AA34
		rts
; ===========================================================================

loc_1AA34:
		movea.l	Off34(a0),a1
		subq.w	#1,Off38(a1)
		bra.w	Obj84_Delete
; ===========================================================================
Ani_obj86:
	include "_anim\obj86.asm"

; ---------------------------------------------------------------------------
; Sprite mappings - energy ball	launcher (FZ)
; ---------------------------------------------------------------------------
Map_obj86:
	include "_maps\obj86.asm"

Ani_obj86a:
	include "_anim\obj86a.asm"

; ---------------------------------------------------------------------------
; Sprite mappings - energy balls (FZ)
; ---------------------------------------------------------------------------
Map_obj86a:
	include "_maps\obj86a.asm"

FZ_ToSuper_SonicX	equ $27E0

; ===========================================================================
FZ_ToSuper:
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	.I(pc,d0.w),d0
		jmp	.I(pc,d0.w)
; ===========================================================================
.I		dc.w .ChkSonic-.I
		dc.w .ChkFadeOut-.I
		dc.w .SpawnEmeralds-.I
		dc.w ToSuper_MoveEmeralds-.I
		dc.w ToSuper_Transform-.I
		dc.w ToSuper_White-.I
		dc.w ToSuper_LoadLevel-.I
		dc.w ToSuper_Finish-.I
; ===========================================================================
.ChkSonic	lea	Object_RAM.w,a1
		cmpi.w	#FZ_ToSuper_SonicX,X_Pos(a1)
		blt.s	.rts
		move.b	#1,$FFFFF7CC.w	; lock joypad
		sf	$FFFFF602.w	; clear held buttons
		move.w	#0,X_Vel(a1)
		move.w	#0,Inertia(a1)	; stop Sonic

		move.l	Off3C(a0),a2
		cmpi.b	#$85,(a2)
		beq.s	.rts
		addq.b	#2,Routine(a0)
		addq.b	#2,$FFFFF742.w

		move.b	#(16*2),$FFFFF626.w	; set to fade out after line 0
		move.b	#16*3,$FFFFF627.w	; set to fade out line 1-3
		move.b	#7,Routine2(a0)		; repeat 7 times
		move.b	#4,Subtype(a0)		; delay 4 frames

.rts		rts

; ===========================================================================
.ChkFadeOut	subq.b	#1,Subtype(a0)
		bpl.s	.rts
		move.b	#4,Subtype(a0)		; delay 4 frames

		move.l	a0,-(sp)
		jsr	Pal_FadeOut		; fade out gradually
		move.l	(sp)+,a0

		subq.b	#1,Routine2(a0)
		bpl.s	.rts
		addq.b	#2,Routine(a0)		; next routine

		moveq	#(7*4)+Misc_PLC,d0
		jmp	LoadPLC

; ===========================================================================
.data		dc.b 0, 36, 73, 109, 146, 183, 220
	;	dc.b ((256)/7)*1, ((256)/7)*2, ((256)/7)*3, ((256)/7)*4, ((256)/7)*5, ((256)/7)*6, ((256)/7)*7
		even

.SpawnEmeralds	moveq	#7-1,d6
		moveq	#0,d0
		moveq	#0,d1
		lea	Subtype(a0),a4
		move.b	d6,(a4)+
		lea	.data(pc),a3

.next		jsr	SingleObjLoad2
		bne.s	.end
		move.b	#$81,(a1)		; load emerald
		move.b	(a3)+,Off2C(a1)
		move.b	d0,Off2D(a1)
		move.w	d0,Off3C(a1)
		move.w	d0,Off2A(a1)
		move.b	d1,Status(a1)
		bchg	#6,d1

		move.w	a1,d5
		subi.w	#-$3000,d5
		lsr.w	#6,d5
		andi.w	#$7F,d5
		move.b	d5,(a4)+
		dbf	d6,.next

.end		addq.b	#2,Routine(a0)		; next routine
		move.w	Object_RAM+Y_Pos.w,Off38(a0)
		move.w	Object_RAM+X_Pos.w,Off3A(a0)
		st	$FFFFF7C8.w		; make sonic float on air
		move.w	#6*60,Angle(a0)		; timer
		rts
; ===========================================================================

ToSuper_MoveEmeralds:
		subq.w	#1,Angle(a0)
		bmi.s	.next2
		subi.l	#$2000,Object_RAM+Y_Pos.w
		move.w	Object_RAM+Y_Pos.w,Off38(a0)
		move.w	Object_RAM+X_Pos.w,Off3A(a0)
		jmp	Obj15_Move4

.next2		addq.b	#2,Routine(a0)		; next routine
		rts
; ===========================================================================
ToSuper_Transform:
		addq.b	#2,Routine(a0)		; next routine
		move.b	#0,$FFFFF626.w		; set to fade out after line 0
		move.b	#16*4,$FFFFF627.w	; set to fade out line 1-3
		move.b	#$15,Routine2(a0)	; repeat 7 times

ToSuper_Transform_rts:
		rts
; ===========================================================================
ToSuper_White:
		move.l	a0,-(sp)
		jsr	Pal_ToWhite		; fade out gradually
		move.l	(sp)+,a0
		jsr	Obj15_Move4

		subq.b	#1,Routine2(a0)
		bpl.s	ToSuper_Transform_rts
		addq.b	#2,Routine(a0)		; next routine
		move.w	#$700,$FFFFFE10.w	; set zone id
		move.b	#0,$FFFFF76C.w		; reset objposloader
		jmp	Obj15_DelAll		; delete emeralds
; ===========================================================================
ToSuper_LoadLevel:
		move.l	d7,-(sp)
		move.l	a0,-(sp)
		move.b	#8,VBlank_Routine.w
		jsr	DelayProgram
		lea	$FFFFFB80,a2	; target pallet
		lea	$FFFFFA00,a3	; target underwater pallet
		jsr	LoadPlayerPallets; load pallets

		jsr	LevelSizeLoad
		jsr	MainLoadBlockLoad
		jsr	ClearScreen
		st	Dirty_Flag.w

		move.l	#$01048780,Object_RAM.w	; fix the corrupted data
		move.b	#8,VBlank_Routine.w
		jsr	DelayProgram
		jsr	Pal_FadeFromTo
		move.l	(sp)+,a0
		move.l	(sp)+,d7
		addq.b	#2,Routine(a0)		; next routine
		rts

ToSuper_Finish:
		sf	$FFFFF7C8.w		; clear floating flag
		sf	$FFFFF7CC.w		; unlock joypad
		rts
; ===========================================================================
FZ_Emeralds:
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	.I(pc,d0.w),d0
		jsr	.I(pc,d0.w)
;		bchg	#6,Status(a0)
;		beq.s	.rts
		jmp	DisplaySprite
; ===========================================================================
.I	dc.w .Main-.I
	dc.w .Move-.I
	dc.w .Rot-.I
; ===========================================================================
.Main		addq.b	#2,Routine(a0)
		move.l	#Map_obj25,Mappings_Offset(a0)	; load mappings
		move.w	#$87B2,Art_Tile(a0)		; load right art
		move.b	#4,Render_Flags(a0)	; setup objects render flags
		move.b	#4,Priority(a0)		; setup priority
		move.b	#8,X_Visible(a0)	; setup how wide this object is

.Move		move.b	Off2C(a0),Angle(a0)
		addi.w	#40,Off3C(a0)
		addi.w	#4,Off2A(a0)
		move.w	Off2A(a0),d0
		add.w	d0,Off2C(a0)

		cmpi.b	#$30,Off3C(a0)
		blt.s	.rts
		addq.b	#2,Routine(a0)
		move.b	#$30,Off3C(a0)

.rts		rts
; ===========================================================================
.Rot		move.b	Off2C(a0),Angle(a0)
		move.w	Off2A(a0),d0
		add.w	d0,Off2C(a0)
		rts
