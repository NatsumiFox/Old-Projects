; ---------------------------------------------------------------------------
; Object - Eggman (SBZ2)
; ---------------------------------------------------------------------------
SBZ2_Boss:					; XREF: Obj_Index
Obj82:					; XREF: Obj_Index
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	Obj82_Index(pc,d0.w),d1
		jmp	Obj82_Index(pc,d1.w)
; ===========================================================================
Obj82_Index:	dc.w Obj82_Main-Obj82_Index
		dc.w Obj82_Eggman-Obj82_Index
		dc.w Obj82_Switch-Obj82_Index

Obj82_ObjData:	dc.b 2,	0, 3		; routine number, animation, priority
		dc.b 4,	0, 3
; ===========================================================================

Obj82_Main:				; XREF: Obj82_Index
		lea	Obj82_ObjData(pc),a2
		move.w	#$2160,X_pos(a0)
		move.w	#$5A4,Y_Pos(a0)
		move.b	#$F,Coll(a0)
		move.b	#$10,Coll2(a0)
		bclr	#0,Status(a0)
		clr.b	Routine2(a0)
		move.b	(a2)+,Routine(a0)
		move.b	(a2)+,Anim(a0)
		move.b	(a2)+,Priority(a0)
		move.l	#Map_obj82,Mappings_Offset(a0)
		move.w	#$400,Art_Tile(a0)
		move.b	#4,Render_Flags(a0)
		bset	#7,Render_Flags(a0)
		move.b	#$20,X_Visible(a0)
		jsr	SingleObjLoad2
		bne.s	Obj82_Eggman
		move.l	a0,Off34(a1)
		move.b	#$82,(a1)	; load switch object
		move.w	#$2130,X_pos(a1)
		move.w	#$5BC,Y_Pos(a1)
		clr.b	Routine2(a0)
		move.b	(a2)+,Routine(a1)
		move.b	(a2)+,Anim(a1)
		move.b	(a2)+,Priority(a1)
		move.l	#Map_obj32,Mappings_Offset(a1)
		move.w	#$4A4,Art_Tile(a1)
		move.b	#4,Render_Flags(a1)
		bset	#7,Render_Flags(a1)
		move.b	#$10,X_Visible(a1)
		move.b	#0,Anim_Frame(a1)

Obj82_Eggman:				; XREF: Obj82_Index
		moveq	#0,d0
		move.b	Routine2(a0),d0
		move.w	Obj82_EggIndex(pc,d0.w),d1
		jsr	Obj82_EggIndex(pc,d1.w)
		lea	Ani_obj82(pc),a1
		jsr	AnimateSprite
		jmp	DisplaySprite
; ===========================================================================
Obj82_EggIndex:	dc.w Obj82_ChkSonic-Obj82_EggIndex
		dc.w Obj82_PreLeap-Obj82_EggIndex
		dc.w Obj82_Leap-Obj82_EggIndex
		dc.w Obj82_Flicker-Obj82_EggIndex
		dc.w Obj82_Run-Obj82_EggIndex
		dc.w Obj82_Run2-Obj82_EggIndex
		dc.w Obj82_Delete-Obj82_EggIndex
		dc.w Obj82_Delete2-Obj82_EggIndex
; ===========================================================================
Obj82_Delete:
		moveq	#$FFFFFFE4+5,d0
		buytest	Used_AltMusic
		bne.s	.play
		moveq	#$FFFFFF8D,d0

.play		jsr	PlayMusic

		moveq	#0,d0
		move.w	d0,Y_Pos(a0)
		move.w	#120,Inertia(a0)
		move.b	#2,$FFFFFE11.w
		move.b	d0,$FFFFF76C.w
		move.b	d0,($FFFFF742).w
		move.l	SBZ3List+4,$FFFFF72A.w
		move.b	d0,$FFFFFE30.w	; clear lamppost counter
		move.b	#$34,Ttlcard_RAM.w	; load title card object
		addq.b	#2,Routine2(a0)

		move.b	d0,Shield_Type ; remove shield
		clr.b	Shield_RAM+Inertia
		clr.b	Shield_RAM+Routine2; clear secondary routine counter to load object properly

		move.w	d0,($FFFFFE20).w ; reset number	of rings to zero
		move.b	#$80,($FFFFFE1D).w ; update ring counter
		move.b	d0,($FFFFFE1B).w
		move.l	d0,($FFFFFE22).w ; clear time
		move.b	#1,($FFFFFE1E).w ; update time counter

Obj82_Delete2:
		subq.w	#1,Inertia(a0)
		bpl.s	.rts
		addq.b	#2,Ttlcard_RAM+Routine	; make title card move
		addq.b	#4,Ttlcard_RAM+$40+Routine
		addq.b	#4,Ttlcard_RAM+$80+Routine
		addq.b	#4,Ttlcard_RAM+$C0+routine

		jmp	DeleteObject
.rts		rts

Obj82_ChkSonic:				; XREF: Obj82_EggIndex
		move.w	X_pos(a0),d0
		sub.w	Object_RAM+X_Pos,d0
		cmpi.w	#128,d0		; is Sonic within 128 pixels of	Eggman?
		bcc.s	loc_19934	; if not, branch
		addq.b	#2,Routine2(a0)
		move.w	#180,Off3C(a0)	; set delay to 3 seconds
		move.b	#1,Anim(a0)

loc_19934:				; XREF: Obj82_EggIndex
		jmp	SpeedToPos
; ===========================================================================

Obj82_PreLeap:				; XREF: Obj82_EggIndex
		subq.w	#1,Off3C(a0)	; subtract 1 from time delay
		bne.s	loc_19954	; if time remains, branch
		addq.b	#2,Routine2(a0)
		move.b	#2,Anim(a0)
		addq.w	#4,Y_Pos(a0)
		move.w	#15,Off3C(a0)

loc_19954:
		bra.s	loc_19934
; ===========================================================================

Obj82_Leap:				; XREF: Obj82_EggIndex
		subq.w	#1,Off3C(a0)
		bgt.s	loc_199D0
		bne.s	loc_1996A
		move.w	#-$FC,X_Vel(a0)	; make Eggman leap
		move.w	#-$3C0,Y_Vel(a0)

loc_1996A:
		cmpi.w	#$2132,X_pos(a0)
		bgt.s	loc_19976
		clr.w	X_Vel(a0)

loc_19976:
		addi.w	#$24,Y_Vel(a0)
		tst.w	Y_Vel(a0)
		bmi.s	Obj82_FindBlocks
		cmpi.w	#$595,Y_Pos(a0)
		bcs.s	Obj82_FindBlocks
		move.w	#$5357,Subtype(a0)
		cmpi.w	#$59B,Y_Pos(a0)
		bcs.s	Obj82_FindBlocks
		move.w	#$59B,Y_Pos(a0)

		moveq	#$FFFFFF93+$30-$13,d0
		jsr	PlaySound	; play switch sound
		clr.w	Y_Vel(a0)
		addq.b	#2,Routine2(a0)
		move.b	#1,Anim(a0)
		move.l	#0,Inertia(a0)
		bsr	SBZ2_Boss_FetchMode
		bsr	SBZ2_Boss_LoadChunks

loc_199D0:
Obj82_FindBlocks
		bra.w	loc_19934

Obj82_Run:
		move.w	$FFFFFE04,d0
		andi.w	#7,d0
		bne.s	Obj82_Run2
		moveq	#$FFFFFF93+$30-$13,d0
		jsr	PlaySound	; play switch sound

Obj82_Run2:
		move.b	#4,anim(a0)
		bset	#0,Status(a0)
		move.w	#$200,X_Vel(a0)
		move.w	#$5A4,Y_Pos(a0)
		jsr	SpeedToPos
		bra.s	Obj82_Flicker

SBZ2_Boss_Fetchlist	dc.b 10, 10,  -1, -1,  8, 6,  6, 8,  4, 8, -1, -1, 3, 10, 2, 14,  1, 10, -1, -1

SBZ2_Boss_FetchMode:
		moveq	#0,d0
		move.b	X_Radius(a0),d0
		move.w	SBZ2_Boss_Fetchlist(pc,d0.w),Inertia(a0)
		addq.b	#2,X_Radius(a0)
		tst.b	Inertia(a0)
		bpl.s	SBZ2_Boss_FetchMode_rts
		addq.b	#2,Routine2(a0)
		lea	SBZ2_Boss_Dull(pc),a1
		bra	SBZ2_Boss_LoadChunks2

Obj82_Flicker:
		subq.b	#1,Inertia(a0)
		bpl.s	SBZ2_Boss_FetchMode_rts
		bsr	SBZ2_Boss_LoadChunks
		tst.b	Y_Radius(a0)
		bmi.s	.next
		move.b	#-1,Y_Radius(a0)
		rts

.next		move.b	#0,Y_Radius(a0)
		subq.b	#1,Inertia+1(a0)
		bmi.s	SBZ2_Boss_FetchMode
SBZ2_Boss_FetchMode_rts:
		rts

SBZ2_Boss_LoadChunks:
		lea	SBZ2_Boss_Normal(pc),a1
		tst.b	Y_Radius(a0)
		bmi.s	SBZ2_Boss_LoadChunks2

		cmpi.b	#4,Gliding_Main.w
		bne.s	.skip
		move.b	Object_RAM+Anim.w,d0
		jsr	K_Glide_HitObj
.skip		lea	SBZ2_Boss_Empty(pc),a1

SBZ2_Boss_LoadChunks2:
		lea	$FF0000+($E7*$80)+(16*2),a2
		moveq	#10-1,d0

.loop		move.w	(a1)+,(a2)
		lea	8*2(a2),a2
		dbf	d0,.loop
		move.b	#1,Dirty_Flag.w
		rts

SBZ2_Boss_Normal:
		dc.w $210+$F000, $211+$F000, $212+$F000, $213+$F000, $211+$F000, $212+$F000, $213+$F000, $211+$F000, $212+$F000, $214+$F000

SBZ2_Boss_Empty:
		dcb.w 10-1, $F25A

SBZ2_Boss_Dull:
		dcb.w 10-1, 0
; ===========================================================================

Obj82_Switch:				; XREF: Obj82_Index
		moveq	#0,d0
		move.b	Routine2(a0),d0
		move.w	Obj82_SwIndex(pc,d0.w),d0
		jmp	Obj82_SwIndex(pc,d0.w)
; ===========================================================================
Obj82_SwIndex:	dc.w loc_199E6-Obj82_SwIndex
		dc.w Obj82_SwDisplay-Obj82_SwIndex
		dc.w Obj82_Barrier-Obj82_SwIndex
; ===========================================================================

loc_199E6:				; XREF: Obj82_SwIndex
		movea.l	Off34(a0),a1
		cmpi.w	#$5357,Subtype(a1)
		bne.s	Obj82_SwDisplay
		move.b	#1,Anim_Frame(a0)
		addq.b	#2,Routine2(a0)
		bra.s	Obj82_SwDisplay

Obj82_Barrier:
		movea.l	Off34(a0),a1
		move.b	Inertia(a1),d0
		btst	d0,$FFFFFE04+1.w
		bne.s	Obj82_SwDisplay
		rts

Obj82_SwDisplay:			; XREF: Obj82_SwIndex
		jmp	DisplaySprite
; ===========================================================================
Ani_obj82:
	include "_anim\obj82.asm"

; ---------------------------------------------------------------------------
; Sprite mappings - Eggman (SBZ2)
; ---------------------------------------------------------------------------
Map_obj82:
	include "_maps\obj82.asm"

; ===========================================================================
; ---------------------------------------------------------------------------
; Object 83 - blocks that disintegrate Eggman	presses	a switch (SBZ2)
; ---------------------------------------------------------------------------

Obj83:					; XREF: Obj_Index
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	Obj83_Index(pc,d0.w),d1
		jmp	Obj83_Index(pc,d1.w)
; ===========================================================================
Obj83_Index:	dc.w Obj83_Main-Obj83_Index
		dc.w Obj83_ChkBreak-Obj83_Index
		dc.w loc_19C36-Obj83_Index
		dc.w loc_19C62-Obj83_Index
		dc.w loc_19C72-Obj83_Index
		dc.w loc_19C80-Obj83_Index
; ===========================================================================

Obj83_Main:				; XREF: Obj83_Index
		move.w	#$2080,X_pos(a0)
		move.w	#$5D0,Y_Pos(a0)
		move.b	#$80,X_Visible(a0)
		move.b	#$10,Y_Radius(a0)
		move.b	#4,Render_Flags(a0)
		bset	#7,Render_Flags(a0)
		moveq	#0,d4
		move.w	#$2010,d5
		moveq	#7,d6
		lea	Off30(a0),a2

Obj83_MakeBlock:
		jsr	SingleObjLoad
		bne.s	Obj83_ExitMake
		move.w	a1,(a2)+
		move.b	#$83,(a1)	; load block object
		move.l	#Map_obj83,Mappings_Offset(a1)
		move.w	#$4518,Art_Tile(a1)
		move.b	#4,Render_Flags(a1)
		move.b	#$10,X_Visible(a1)
		move.b	#$10,Y_Radius(a1)
		move.b	#3,Priority(a1)
		move.w	d5,X_pos(a1)	; set X	position
		move.w	#$5D0,Y_Pos(a1)
		addi.w	#$20,d5		; add $20 for next X position
		move.b	#8,Routine(a1)
		dbf	d6,Obj83_MakeBlock ; repeat sequence 7 more times

Obj83_ExitMake:
		addq.b	#2,Routine(a0)
		rts
; ===========================================================================

Obj83_ChkBreak:				; XREF: Obj83_Index
		cmpi.w	#$474F,Subtype(a0)	; is object set	to disintegrate?
		bne.s	Obj83_Solid	; if not, branch
		clr.b	Anim_Frame(a0)
		addq.b	#2,Routine(a0)	; next subroutine

Obj83_Solid:
		moveq	#0,d0
		move.b	Anim_Frame(a0),d0
		neg.b	d0
		ext.w	d0
		addq.w	#8,d0
		asl.w	#4,d0
		move.w	#$2100,d4
		sub.w	d0,d4
		move.b	d0,X_Visible(a0)
		move.w	d4,X_pos(a0)
		moveq	#$B,d1
		add.w	d0,d1
		moveq	#$10,d2
		moveq	#$11,d3
		jmp	SolidObject
; ===========================================================================

loc_19C36:				; XREF: Obj83_Index
		subi.b	#$E,Anim_Dur(a0)
		bcc.s	Obj83_Solid2
		moveq	#-1,d0
		move.b	Anim_Frame(a0),d0
		ext.w	d0
		add.w	d0,d0
		move.w	Off30(a0,d0.w),d0
		movea.l	d0,a1
		move.w	#$474F,Subtype(a1)
		addq.b	#1,Anim_Frame(a0)
		cmpi.b	#8,Anim_Frame(a0)
		beq.s	loc_19C62

Obj83_Solid2:
		bra.s	Obj83_Solid
; ===========================================================================

loc_19C62:				; XREF: Obj83_Index
		bclr	#3,Status(a0)
		bclr	#3,Object_RAM+Status
		bra.w	loc_1982C
; ===========================================================================

loc_19C72:				; XREF: Obj83_Index
		cmpi.w	#$474F,Subtype(a0)	; is object set	to disintegrate?
		beq.s	Obj83_Break	; if yes, branch
		jmp	DisplaySprite
; ===========================================================================

loc_19C80:				; XREF: Obj83_Index
		tst.b	Render_Flags(a0)
		bpl.w	loc_1982C
		jsr	ObjectFall
		jmp	DisplaySprite
; ===========================================================================

Obj83_Break:				; XREF: loc_19C72
		lea	Obj83_FragSpeed(pc),a4
		lea	Obj83_FragPos(pc),a5
		moveq	#1,d4
		moveq	#3,d1
		moveq	#$38,d2
		addq.b	#2,Routine(a0)
		move.b	#8,X_Visible(a0)
		move.b	#8,Y_Radius(a0)
		lea	(a0),a1
		bra.s	Obj83_MakeFrag
; ===========================================================================

Obj83_LoopFrag:
		jsr	SingleObjLoad2
		bne.s	Obj83_BreakSnd

Obj83_MakeFrag:				; XREF: Obj83_Break
		lea	(a0),a2
		lea	(a1),a3
		moveq	#3,d3

loc_19CC4:
		move.l	(a2)+,(a3)+
		move.l	(a2)+,(a3)+
		move.l	(a2)+,(a3)+
		move.l	(a2)+,(a3)+
		dbf	d3,loc_19CC4

		move.w	(a4)+,Y_Vel(a1)
		move.w	(a5)+,d3
		add.w	d3,X_pos(a1)
		move.w	(a5)+,d3
		add.w	d3,Y_Pos(a1)
		move.b	d4,Anim_Frame(a1)
		addq.w	#1,d4
		dbf	d1,Obj83_LoopFrag ; repeat sequence 3 more times

Obj83_BreakSnd:
		move.w	#$CB,d0
		jsr	(PlaySound).l ;	play smashing sound
		jmp	DisplaySprite
; ===========================================================================
Obj83_FragSpeed:dc.w $80, 0
		dc.w $120, $C0
Obj83_FragPos:	dc.w $FFF8, $FFF8
		dc.w $10, 0
		dc.w 0,	$10
		dc.w $10, $10
; ---------------------------------------------------------------------------
; Sprite mappings - blocks that	disintegrate when Eggman presses a switch
; ---------------------------------------------------------------------------
Map_obj83:
	include "_maps\obj83.asm"