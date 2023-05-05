; ---------------------------------------------------------------------------
; Object - Boss (GHZ3)
; ---------------------------------------------------------------------------
GHZ3_Boss:					; XREF: Obj_Index
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	GHZ3_Boss_Index(pc,d0.w),d1
		jmp	GHZ3_Boss_Index(pc,d1.w)
; ===========================================================================
GHZ3_Boss_Index:dc.w GHZ3_Boss_Main-GHZ3_Boss_Index
		dc.w GHZ3_Boss_ShipMain-GHZ3_Boss_Index
		dc.w GHZ3_Boss_FaceMain-GHZ3_Boss_Index
		dc.w GHZ3_Boss_FlameMain-GHZ3_Boss_Index

			; routine counter, animation
GHZ3_Boss_ObjData:	dc.b 2,	0	; the main ship
			dc.b 4,	1	; Eggman face
			dc.b 6,	7	; flame from the ship
; ===========================================================================

GHZ3_Boss_Main:				; XREF: GHZ3_Boss_Index
		lea	GHZ3_Boss_ObjData,a2	; get data array
		movea.l	a0,a1			; copy this object to a1
		moveq	#2,d1			; get length
		bra.s	GHZ3_Boss_LoadBoss	; start with current object
; ===========================================================================

GHZ3_Boss_Loop:
		jsr	SingleObjLoad2		; load next object
		bne.s	loc_17772		; if all slots are full, end

GHZ3_Boss_LoadBoss:				; XREF: GHZ3_Boss_Main
		move.b	(a2)+,Routine(a1)	; get routine counter
		move.b	#$3D,(a1)		; use current object
		move.w	X_pos(a0),X_pos(a1)	;
		move.w	Y_Pos(a0),Y_Pos(a1)	; copy positions
		move.l	#Map_Eggman,Mappings_Offset(a1); get mappings
		move.w	#$400,Art_Tile(a1)	;
		move.b	#4,Render_Flags(a1)	;
		move.b	#$20,X_Visible(a1)	;
		move.b	#3,Priority(a1)		;
		move.b	(a2)+,Anim(a1)		; get animation
		move.l	a0,Off34(a1)		; save boss address
		dbf	d1,GHZ3_Boss_Loop	; repeat sequence 2 more times

loc_17772:
		move.w	X_pos(a0),Boss_X(a0)	;
		move.w	Y_Pos(a0),Boss_Y(a0)	; copy positions to other memory
		move.b	#$F,Coll(a0)		; set to boss
		move.b	#8,Coll2(a0)		; set number of	hits to	8

GHZ3_Boss_ShipMain:				; XREF: GHZ3_Boss_Index
		moveq	#0,d0
		move.b	Routine2(a0),d0			; get secondary routine counter
		move.w	GHZ3_Boss_ShipIndex(pc,d0.w),d1
		jsr	GHZ3_Boss_ShipIndex(pc,d1.w)	; jump to the correct routine

		lea	Ani_Eggman,a1
		jsr	AnimateSprite			; animate object
		move.b	Status(a0),d0
		andi.b	#3,d0				; only maintain X and Y flip bits
		andi.b	#$FC,Render_Flags(a0)		; clear X and Y flip bits
		or.b	d0,Render_Flags(a0)		; if X and Y flip bits were set, copy to Render flags
		jmp	DisplaySprite			; display sprite
; ===========================================================================
GHZ3_Boss_ShipIndex:dc.w GHZ3_Boss_ShipStart-GHZ3_Boss_ShipIndex
		dc.w GHZ3_Boss_MakeBall-GHZ3_Boss_ShipIndex
		dc.w GHZ3_Boss_ShipMove-GHZ3_Boss_ShipIndex
		dc.w GHZ3_Boss_ChkFlip-GHZ3_Boss_ShipIndex
		dc.w GHZ3_Boss_Explode-GHZ3_Boss_ShipIndex
		dc.w GHZ3_Boss_BeforeEscape-GHZ3_Boss_ShipIndex
		dc.w GHZ3_Boss_Escape-GHZ3_Boss_ShipIndex
; ===========================================================================

GHZ3_Boss_ShipStart:			; XREF: GHZ3_Boss_ShipIndex
		move.w	#$100,Y_Vel(a0)		; move ship down
		bsr.w	BossMove		; run movement routines
		cmpi.w	#$338,Boss_Y(a0)	; if Y position is low enough
		bne.s	GHZ3_Boss_BossHover	; if not, skip
		move.w	#0,Y_Vel(a0)		; stop ship
		addq.b	#2,Routine2(a0)		; goto next routine

GHZ3_Boss_BossHover:
		move.b	Off3F(a0),d1		; get offset
		jsr	CalcSine		; get sine
		asr.w	#6,d0			; shifht right 6 bits
		add.w	Boss_Y(a0),d0		; add Boss Y-position
		move.w	d0,Y_Pos(a0)		; set to actual Y-position
		move.w	Boss_X(a0),X_pos(a0)	; copy Y-position to actual Y-position
		addq.b	#2,Off3F(a0)		; increment offset
		cmpi.b	#8,Routine2(a0)		; is secondary routine counter 8?
		bhs.s	GHZ3_Boss_NoFlash	; if higher or same, skip flashing

		tst.b	Status(a0)		;
		bmi.s	GHZ3_Boss_SetDefeat	; if no hits left, set defeated
		tst.b	Coll(a0)		; if colliding, dont flash
		bne.s	GHZ3_Boss_NoFlash	; else do
		tst.b	Off3E(a0)		; has timer ran out?
		bne.s	GHZ3_Boss_ShipFlash	; if hasnt, start flashing

		move.b	#$20,Off3E(a0)		; set number of	times for ship to flash
		move.w	#$AC,d0			;
		jsr	PlaySound		; play boss damage sound

GHZ3_Boss_ShipFlash:
		lea	$FFFFFB22,a1 		; load 2nd line, 2nd entry
		moveq	#0,d0			; move 0 (black) to d0
		tst.w	(a1)			; does the line currently have this entry?
		bne.s	loc_1783C		; if not, branch
		move.w	#$EEE,d0		; move 0EEE (white) to d0

loc_1783C:
		move.w	d0,(a1)			; load colour stored in	d0
		subq.b	#1,Off3E(a0)		; decrement timer
		bne.s	GHZ3_Boss_NoFlash	; if still not 0, branch
		move.b	#$F,Coll(a0)		; reset collision and stop flashing

GHZ3_Boss_NoFlash:
		rts
; ===========================================================================

GHZ3_Boss_SetDefeat:				; XREF: GHZ3_Boss_BossHover
		moveq	#100,d0		; 100 points
		bsr.w	AddPoints	; add points
		move.b	#8,Routine2(a0)	; set to defeated subroutine
		move.w	#$B3,Off3C(a0)	; explosion timer
		rts

; ---------------------------------------------------------------------------
; Defeated boss	subroutine
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


BossDefeated:
		move.b	$FFFFFE0F.w,d0		; get some universal counter
		andi.b	#7,d0			; check bits 0, 1, and 2
		bne.s	locret_178A2		; if nonzero, branch
		jsr	SingleObjLoad		; load an object
		bne.s	locret_178A2		; if slots are used, skip code

		move.b	#$3F,(a1)		; load explosion object
		move.w	X_pos(a0),X_pos(a1)	;
		move.w	Y_Pos(a0),Y_Pos(a1)	; copy positions to explosion
		move.w	#$8000,Art_Tile(a1)

		jsr	RandomNumber		; generate random number
		move.w	d0,d1			; copy d0 to d1 (pointless)
		moveq	#0,d1
		move.b	d0,d1			; copy d0 to d1
		lsr.b	#2,d1			; shift 2 bits right
		subi.w	#$20,d1			; offset results
		add.w	d1,X_pos(a1)		; add it to the X-position of explosion
		lsr.w	#8,d0			; get next byte to read from
		lsr.b	#3,d0			; shift 3 bits right
		add.w	d0,Y_Pos(a1)		; add it to the Y-position of explosion

locret_178A2:
		rts
; End of function BossDefeated

; ---------------------------------------------------------------------------
; Subroutine to	move a boss
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


BossMove:
		move.w  x_vel(a0),d0
		ext.l   d0
		lsl.l   #8,d0
		add.l   d0,Boss_X(a0)
		move.w  y_vel(a0),d0
		ext.l   d0
		lsl.l   #8,d0
		add.l   d0,Boss_Y(a0)
		rts
; End of function BossMove

; ===========================================================================
; I dont even
GHZ3_Boss_MakeBall:				; XREF: GHZ3_Boss_ShipIndex
		move.w	#-$100,X_Vel(a0)
		move.w	#-$40,Y_Vel(a0)
		bsr.w	BossMove
		cmpi.w	#$2A00,Boss_X(a0)
		bne.s	loc_17916
		move.w	#0,X_Vel(a0)
		move.w	#0,Y_Vel(a0)
		addq.b	#2,Routine2(a0)
		jsr	SingleObjLoad2
		bne.s	loc_17910
		move.b	#$48,0(a1)	; load swinging	ball object
		move.w	Boss_X(a0),X_pos(a1)
		move.w	Boss_Y(a0),Y_Pos(a1)
		move.l	a0,Off34(a1)

loc_17910:
		move.w	#$77,Off3C(a0)

loc_17916:
		bra.w	GHZ3_Boss_BossHover
; ===========================================================================
; still no?
GHZ3_Boss_ShipMove:				; XREF: GHZ3_Boss_ShipIndex
		subq.w	#1,Off3C(a0)
		bpl.s	GHZ3_Boss_Reverse
		addq.b	#2,Routine2(a0)
		move.w	#$3F,Off3C(a0)
		move.w	#$100,X_Vel(a0)	; move the ship	sideways
		cmpi.w	#$2A00,Boss_X(a0)
		bne.s	GHZ3_Boss_Reverse
		move.w	#$7F,Off3C(a0)
		move.w	#$40,X_Vel(a0)

GHZ3_Boss_Reverse:
		btst	#0,Status(a0)
		bne.s	loc_17950
		neg.w	X_Vel(a0)		; reverse direction of the ship

loc_17950:
		bra.w	GHZ3_Boss_BossHover
; ===========================================================================

GHZ3_Boss_ChkFlip:				; XREF: GHZ3_Boss_ShipIndex
		subq.w	#1,Off3C(a0)		; decrement counter
		bmi.s	GHZ3_Boss_Flip		; if negative, flip
		bsr.w	BossMove		; else move boss
		bra.w	GHZ3_Boss_BossHover	; and hover
; ===========================================================================

GHZ3_Boss_Flip:
		bchg	#0,Status(a0)		; flip
		move.w	#$3F,Off3C(a0)		; set new timer
		subq.b	#2,Routine2(a0)		; sub routine counter
		move.w	#0,X_Vel(a0)		; clear speed
		bra.w	GHZ3_Boss_BossHover	; hover
; ===========================================================================

GHZ3_Boss_Explode:				; XREF: GHZ3_Boss_ShipIndex
		subq.w	#1,Off3C(a0)		; decrement timer
		bmi.s	.defeated		; if negative, branch
		bra.w	BossDefeated		; generate explosions

.defeated	bset	#0,Status(a0)		; face right
		bclr	#7,Status(a0)		; set defeated
		clr.w	X_Vel(a0)		; clear speed
		addq.b	#2,Routine2(a0)		; next routine
		move.w	#-$26,Off3C(a0)		; set timer(?)
		tst.b	$FFFFF7A7.w		;
		bne.s	locret_179AA		;
		move.b	#1,$FFFFF7A7.w		; something to do with animals

locret_179AA:
		rts
; ===========================================================================

GHZ3_Boss_BeforeEscape:				; XREF: GHZ3_Boss_ShipIndex
		addq.w	#1,Off3C(a0)		; increment timer
		beq.s	GHZ3_Boss_BE_StartGoUp	; if 0, start climbing upwards
		bpl.s	GHZ3_Boss_BE_GoUp	; if greater than 0, go upwards
		addi.w	#$18,Y_Vel(a0)		; apply gravity
		bra.s	GHZ3_Boss_BE_Move	; do main movement routines
; ===========================================================================

GHZ3_Boss_BE_StartGoUp:
		clr.w	Y_Vel(a0)		; clear Y-velocity
		bra.s	GHZ3_Boss_BE_Move	; do main movement routines
; ===========================================================================

GHZ3_Boss_BE_GoUp:
		cmpi.w	#$30,Off3C(a0)		; is timer $30?
		blo.s	.moveUp			; if less, move up
		beq.s	GHZ3_Boss_BE_PlayMusic	; is same, clear Y-velocity and play zone music
		cmpi.w	#$38,Off3C(a0)		; is timer $38?
		blo.s	GHZ3_Boss_BE_Move	; if less, branch
		addq.b	#2,Routine2(a0)		; increment routine
		bra.s	GHZ3_Boss_BE_Move	; do main movement routines
; ===========================================================================

.moveUp		subq.w	#8,Y_Vel(a0)		; move upwards

GHZ3_Boss_BE_Move:
		bsr.w	BossMove		; move the boss
		bra.w	GHZ3_Boss_BossHover	; hover
; ===========================================================================

GHZ3_Boss_BE_PlayMusic:
		pea	GHZ3_Boss_BE_Move(pc)	; go to movement routine after
		clr.w	Y_Vel(a0)		; clear Y-velocity

		moveq	#$FFFFFFE0,d0
		jmp	PlayMusic		; fade music out

; ===========================================================================

GHZ3_Boss_Escape:				; XREF: GHZ3_Boss_ShipIndex
		move.w	#$400,X_Vel(a0)		; set escape speed
		move.w	#-$40,Y_Vel(a0)		; go upwards

		cmpi.w	#$2AC0,$FFFFF72A.w	; if finished scrolling..
		beq.s	loc_17A10		; ...branch
		addq.w	#2,$FFFFF72A.w		; move level minimum horizontal position
		bra.s	GHZ3_Boss_BE_Move	; do main movement routines
; ===========================================================================

loc_17A10:
		tst.b	Render_Flags(a0)	; is on-screen?
		bpl.s	GHZ3_Boss_ShipDel	; if isnt, branch
		bra	GHZ3_Boss_BE_Move	; do main movment routines
; ===========================================================================

GHZ3_Boss_ShipDel:
		jmp	DeleteObject		; delete boss
; ===========================================================================

GHZ3_Boss_FaceMain:				; XREF: GHZ3_Boss_Index
		moveq	#0,d0
		moveq	#1,d1
		movea.l	Off34(a0),a1
		move.b	Routine2(a1),d0
		subq.b	#4,d0
		bne.s	loc_17A3E
		cmpi.w	#$2A00,Boss_X(a1)
		bne.s	loc_17A46
		moveq	#4,d1

loc_17A3E:
		subq.b	#6,d0
		bmi.s	loc_17A46
		moveq	#$A,d1
		bra.s	loc_17A5A
; ===========================================================================

loc_17A46:
		tst.b	Coll(a1)
		bne.s	loc_17A50
		moveq	#5,d1
		bra.s	loc_17A5A
; ===========================================================================

loc_17A50:
		cmpi.b	#4,Object_RAM+Routine
		blo.s	loc_17A5A
		moveq	#4,d1

loc_17A5A:
		move.b	d1,Anim(a0)
		subq.b	#2,d0
		bne.s	GHZ3_Boss_FaceDisp
		move.b	#6,Anim(a0)
		tst.b	Render_Flags(a0)
		bpl.s	GHZ3_Boss_FaceDel

GHZ3_Boss_FaceDisp:
		bra.s	GHZ3_Boss_Display
; ===========================================================================

GHZ3_Boss_FaceDel:
		jmp	DeleteObject
; ===========================================================================

GHZ3_Boss_FlameMain:			; XREF: GHZ3_Boss_Index
		move.b	#7,Anim(a0)
		movea.l	Off34(a0),a1
		cmpi.b	#$C,Routine2(a1)
		bne.s	loc_17A96
		move.b	#$B,Anim(a0)
		tst.b	Render_Flags(a0)
		bpl.s	GHZ3_Boss_FlameDel
		bra.s	GHZ3_Boss_FlameDisp
; ===========================================================================

loc_17A96:
		move.w	X_Vel(a1),d0
		beq.s	GHZ3_Boss_FlameDisp
		move.b	#8,Anim(a0)

GHZ3_Boss_FlameDisp:
		bra.s	GHZ3_Boss_Display
; ===========================================================================

GHZ3_Boss_FlameDel:
		jmp	DeleteObject
; ===========================================================================

GHZ3_Boss_Display:				; XREF: GHZ3_Boss_FaceDisp; GHZ3_Boss_FlameDisp
		movea.l	Off34(a0),a1
		move.w	X_pos(a1),X_pos(a0)
		move.w	Y_Pos(a1),Y_Pos(a0)
		move.b	Status(a1),Status(a0)
		lea	(Ani_Eggman).l,a1
		jsr	AnimateSprite
		move.b	Status(a0),d0
		andi.b	#3,d0
		andi.b	#$FC,Render_Flags(a0)
		or.b	d0,Render_Flags(a0)
		jmp	DisplaySprite

; ===========================================================================
; ---------------------------------------------------------------------------
; Object 48 - ball on a	chain that Eggman swings (GHZ)
; ---------------------------------------------------------------------------

Obj48:					; XREF: Obj_Index
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	Obj48_Index(pc,d0.w),d1
		jmp	Obj48_Index(pc,d1.w)
; ===========================================================================
Obj48_Index:	dc.w Obj48_Main-Obj48_Index
		dc.w Obj48_Base-Obj48_Index
		dc.w Obj48_Display2-Obj48_Index
		dc.w loc_17C68-Obj48_Index
		dc.w Obj48_ChkVanish-Obj48_Index
; ===========================================================================

Obj48_Main:				; XREF: Obj48_Index
		addq.b	#2,Routine(a0)
		move.w	#$4080,Angle(a0)
		move.w	#-$200,Off3E(a0)
		move.l	#Map_BossItems,Mappings_Offset(a0)
		move.w	#$46C,Art_Tile(a0)
		lea	Subtype(a0),a2
		move.b	#0,(a2)+
		moveq	#5,d1
		movea.l	a0,a1
		bra.s	loc_17B60
; ===========================================================================

Obj48_MakeLinks:
		jsr	SingleObjLoad2
		bne.s	Obj48_MakeBall
		move.w	X_pos(a0),X_pos(a1)
		move.w	Y_Pos(a0),Y_Pos(a1)
		move.b	(a0),(a1)	; load chain link object
		move.b	#6,Routine(a1)
		move.l	#Map_obj15,Mappings_Offset(a1)
		move.w	#$380,Art_Tile(a1)
		move.b	#1,Anim_Frame(a1)
		addq.b	#1,Subtype(a0)

loc_17B60:				; XREF: Obj48_Main
		move.w	a1,d5
		subi.w	#$D000,d5
		lsr.w	#6,d5
		andi.w	#$7F,d5
		move.b	d5,(a2)+
		move.b	#4,Render_Flags(a1)
		move.b	#8,X_Visible(a1)
		move.b	#6,Priority(a1)
		move.l	Off34(a0),Off34(a1)
		dbf	d1,Obj48_MakeLinks ; repeat sequence 5 more times

Obj48_MakeBall:
		move.b	#8,Routine(a1)
		move.l	#Map_obj48,Mappings_Offset(a1) ; load	different mappings for final link
		move.w	#$43AA,Art_Tile(a1)	; use different	graphics
		move.b	#1,Anim_Frame(a1)
		move.b	#5,Priority(a1)
		move.b	#$81,Coll(a1)	; make object hurt Sonic
		rts
; ===========================================================================

Obj48_PosData:	dc.b 0,	$10, $20, $30, $40, $60	; y-position data for links and	giant ball

; ===========================================================================

Obj48_Base:				; XREF: Obj48_Index
		lea	(Obj48_PosData).l,a3
		lea	Subtype(a0),a2
		moveq	#0,d6
		move.b	(a2)+,d6

loc_17BC6:
		moveq	#0,d4
		move.b	(a2)+,d4
		lsl.w	#6,d4
		addi.l	#$FFD000,d4
		movea.l	d4,a1
		move.b	(a3)+,d0
		cmp.b	Off3C(a1),d0
		beq.s	loc_17BE0
		addq.b	#1,Off3C(a1)

loc_17BE0:
		dbf	d6,loc_17BC6

		cmp.b	Off3C(a1),d0
		bne.s	loc_17BFA
		movea.l	Off34(a0),a1
		cmpi.b	#6,Routine2(a1)
		bne.s	loc_17BFA
		addq.b	#2,Routine(a0)

loc_17BFA:
		cmpi.w	#$20,Off32(a0)
		beq.s	Obj48_Display
		addq.w	#1,Off32(a0)

Obj48_Display:
		bsr.w	sub_17C2A
		move.b	Angle(a0),d1
		jsr	(Obj15_Move2).l
		jmp	DisplaySprite
; ===========================================================================

Obj48_Display2:				; XREF: Obj48_Index
		bsr.w	sub_17C2A
		jsr	(Obj48_Move).l
		jmp	DisplaySprite

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_17C2A:				; XREF: Obj48_Display; Obj48_Display2
		movea.l	Off34(a0),a1
		addi.b	#$20,Anim_scriptNum(a0)
		bhs.s	loc_17C3C
		bchg	#0,Anim_Frame(a0)

loc_17C3C:
		move.w	X_pos(a1),Off3A(a0)
		move.w	Y_Pos(a1),d0
		add.w	Off32(a0),d0
		move.w	d0,Boss_Y(a0)
		move.b	Status(a1),Status(a0)
		tst.b	Status(a1)
		bpl.s	locret_17C66
		move.b	#$3F,(a0)
		move.b	#0,Routine(a0)

locret_17C66:
		rts
; End of function sub_17C2A

; ===========================================================================

loc_17C68:				; XREF: Obj48_Index
		movea.l	Off34(a0),a1
		tst.b	Status(a1)
		bpl.s	Obj48_Display3
		move.b	#$3F,(a0)
		move.b	#0,Routine(a0)

Obj48_Display3:
		jmp	DisplaySprite
; ===========================================================================

Obj48_ChkVanish:			; XREF: Obj48_Index
		bchg	#0,Anim_Frame(a0)
		movea.l	Off34(a0),a1
		tst.b	Status(a1)
		bpl.s	Obj48_Display4
		move.b	#0,Coll(a0)
		bsr.w	BossDefeated
		subq.b	#1,Off3C(a0)
		bpl.s	Obj48_Display4
		move.b	#$3F,(a0)
		move.b	#0,Routine(a0)

Obj48_Display4:
		jmp	DisplaySprite

; ===========================================================================
; ---------------------------------------------------------------------------
; Sprite mappings - swinging ball on a chain from GHZ boss
; ---------------------------------------------------------------------------
Map_obj48:
	include "_maps\obj48.asm"