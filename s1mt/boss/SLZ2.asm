SLZ2_Boss_ID:		equ $7E
SLZ2_Boss_Pos_Left:	equ $1F00
SLZ2_Boss_Pos_Right:	equ SLZ2_Boss_Pos_Left+320
SLZ2_Boss_Pos_Up:	equ $220
SLZ2_Boss_Pos_Down:	equ $238

SLZ2_Boss_SP_X:		equ SLZ2_Boss_Pos_Left+((SLZ2_Boss_Pos_Right-SLZ2_Boss_Pos_Left)/2)
SLZ2_Boss_SP_Y:		equ SLZ2_Boss_Pos_Up-$60
SLZ2_Boss_Finish_X:	equ SLZ2_Boss_Pos_Left+$140

SLZ2_Boss_AttackDelay	equ 1*60
SLZ2_Boss_UpSpd		equ $380
SLZ2_Boss_DownSpd	equ $480

SLZ2_Boss_UpY		equ SLZ2_Boss_Pos_Down
SLZ2_Boss_DownY		equ SLZ2_Boss_Pos_Down+$84
; ---------------------------------------------------------------------------
; Object - Boss (SYZ2)
; ---------------------------------------------------------------------------
SLZ2_Boss:					; XREF: Obj_Index
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	SLZ2_Boss_Index(pc,d0.w),d1
		jmp	SLZ2_Boss_Index(pc,d1.w)
; ===========================================================================
SLZ2_Boss_Index:
		dc.w SLZ2_Boss_Main-SLZ2_Boss_Index
		dc.w SLZ2_Boss_ShipMain-SLZ2_Boss_Index
		dc.w GHZ2_Boss_FaceMain-SLZ2_Boss_Index
		dc.w GHZ2_Boss_FlameMain-SLZ2_Boss_Index
		dc.w SLZ2_Boss_Bomb-SLZ2_Boss_Index
		dc.w SLZ2_Boss_Bomb-SLZ2_Boss_Index

			; routine counter, animation
SLZ2_Boss_ObjData:	dc.b 2,	0	; the main ship
			dc.b 4,	1	; Eggman face
			dc.b 6,	7	; flame from the ship
; ===========================================================================

SLZ2_Boss_Main:				; XREF: SLZ2_Boss_Index
		lea	SLZ2_Boss_ObjData,a2	; get data array
		movea.l	a0,a1			; copy this object to a1
		moveq	#2,d1			; get length
		bra.s	SLZ2_Boss_LoadBoss	; start with current object
; ===========================================================================

SLZ2_Boss_Loop:
		jsr	SingleObjLoad2		; load next object
		bne.s	SLZ2_Boss_SkipLoad	; if all slots are full, end

SLZ2_Boss_LoadBoss:				; XREF: SLZ2_Boss_Main
		move.b	(a2)+,Routine(a1)	; get routine counter
		move.b	#SLZ2_Boss_ID,(a1)	; use current object
		move.w	X_pos(a0),X_pos(a1)	;
		move.w	Y_Pos(a0),Y_Pos(a1)	; copy positions
		move.l	#Map_Eggman,Mappings_Offset(a1); get mappings
		move.w	#$400,Art_Tile(a1)	;
		move.b	#4,Render_Flags(a1)	;
		move.b	#$20,X_Visible(a1)	;
		move.b	#3,Priority(a1)		;
		move.b	(a2)+,Anim(a1)		; get animation
		move.l	a0,Off34(a1)		; save boss address
		dbf	d1,SLZ2_Boss_Loop	; repeat sequence 2 more times

SLZ2_Boss_SkipLoad:
		move.w	X_pos(a0),Boss_X(a0)	;
		move.w	Y_Pos(a0),Boss_Y(a0)	; copy positions to other memory
		move.b	#$F,Coll(a0)		; set to boss
		move.b	#8,Coll2(a0)		; set number of	hits to	8

SLZ2_Boss_ShipMain:				; XREF: SLZ2_Boss_Index
		moveq	#0,d0
		move.b	Routine2(a0),d0			; get secondary routine counter
		move.w	SLZ2_Boss_ShipIndex(pc,d0.w),d1
		jsr	SLZ2_Boss_ShipIndex(pc,d1.w)	; jump to the correct routine

		lea	Ani_Eggman,a1
		jsr	AnimateSprite			; animate object
		move.b	Status(a0),d0
		andi.b	#3,d0				; only maintain X and Y flip bits
		andi.b	#$FC,Render_Flags(a0)		; clear X and Y flip bits
		or.b	d0,Render_Flags(a0)		; if X and Y flip bits were set, copy to Render flags
		jmp	DisplaySprite			; display sprite
; ===========================================================================
SLZ2_Boss_ShipIndex:
		dc.w SLZ2_Boss_ShipStart-SLZ2_Boss_ShipIndex
		dc.w SLZ2_Boss_ShipUp-SLZ2_Boss_ShipIndex
		dc.w SLZ2_Boss_PrepareAttack-SLZ2_Boss_ShipIndex
		dc.w SLZ2_Boss_Attack-SLZ2_Boss_ShipIndex

		dc.w SLZ2_Boss_Explode-SLZ2_Boss_ShipIndex
		dc.w SLZ2_Boss_BeforeEscape-SLZ2_Boss_ShipIndex
		dc.w SLZ2_Boss_Escape-SLZ2_Boss_ShipIndex
; ===========================================================================

SLZ2_Boss_ShipStart:
		move.w	#$100,Y_Vel(a0)		; move ship down
		bsr.w	BossMove		; run movement routines

		cmpi.w	#SLZ2_Boss_Pos_Down+$20,Boss_Y(a0)
		blt.s	SLZ2_Boss_BossHover
		addq.b	#2,Routine2(a0)
		bra	SLZ2_Boss_BossHover

SLZ2_Boss_ShipUp:
		move.w	#-$100,Y_Vel(a0)		; move ship down
		bsr.w	BossMove		; run movement routines

		cmpi.w	#SLZ2_Boss_SP_Y,Boss_Y(a0)
		bgt.s	SLZ2_Boss_BossHover
		addq.b	#2,Routine2(a0)
		move.w	#0,Y_Vel(a0)
		move.w	#SLZ2_Boss_AttackDelay,Off3C(a0)
		move.b	#8,Coll2(a0)		; set number of	hits to	8

SLZ2_Boss_BossHover:
		move.b	Off3F(a0),d1		; get offset
		jsr	CalcSine		; get sine
		asr.w	#6,d0			; shift right 6 bits
		add.w	Boss_Y(a0),d0		; add Boss Y-position
		move.w	d0,Y_Pos(a0)		; set to actual Y-position
		move.w	Boss_X(a0),X_pos(a0)	; copy Y-position to actual Y-position
		addq.b	#2,Off3F(a0)		; increment offset
		cmpi.b	#8,Routine2(a0)		; is secondary routine counter 8?
		bhs.s	SLZ2_Boss_NoFlash	; if higher or same, skip flashing

		tst.b	Status(a0)		;
		bmi.s	SLZ2_Boss_SetDefeat	; if no hits left, set defeated
		tst.b	Coll(a0)		; if colliding, dont flash
		bne.s	SLZ2_Boss_NoFlash	; else do
		tst.b	Off3E(a0)		; has timer ran out?
		bne.s	SLZ2_Boss_ShipFlash	; if hasnt, start flashing

		move.b	#$20,Off3E(a0)		; set number of	times for ship to flash
		move.w	#$AC,d0			;
		jsr	PlaySound		; play boss damage sound

SLZ2_Boss_ShipFlash:
		lea	$FFFFFB22,a1 		; load 2nd line, 2nd entry
		moveq	#0,d0			; move 0 (black) to d0
		tst.w	(a1)			; does the line currently have this entry?
		bne.s	.set			; if not, branch
		move.w	#$EEE,d0		; move 0EEE (white) to d0

.set		move.w	d0,(a1)			; load colour stored in	d0
		subq.b	#1,Off3E(a0)		; decrement timer
		bne.s	SLZ2_Boss_NoFlash	; if still not 0, branch
		move.b	#$F,Coll(a0)		; reset collision and stop flashing

SLZ2_Boss_NoFlash:
		rts
; ===========================================================================

SLZ2_Boss_SetDefeat:				; XREF: SLZ2_Boss_BossHover
		moveq	#100,d0		; 100 points
		bsr.w	AddPoints	; add points
		move.b	#8,Routine2(a0); set to defeated subroutine
		move.w	#(3*60)-1,Off3C(a0); explosion timer
		rts

; ===========================================================================
SLZ2_Boss_PrepareAttack:
		subq.w	#1,Off3C(a0)		; decrement timer
		bpl	SLZ2_Boss_BossHover	; if positive, branch

.new		jsr	RandomNumber		; get a random number
		lsr.w	#8,d0			; shift 8 bits right
		andi.w	#6,d0			; get only bits 1 and 2

		cmp.b	Off29(a0),d0
		beq.s	.new
		move.b	d0,Off29(a0)

		move.w	.act(pc,d0.w),d1
		jsr	.act(pc,d1.w)		; jump to the correct routine

		addq.b	#2,Routine2(a0)		; next routine
		move.b	#8,Subtype(a0)		; normal bombs

		andi.w	#%00011001,d2
		bne.s	.norm			; if is rare case
		move.b	#$A,Subtype(a0)		; then use splosions

.norm		bra	SLZ2_Boss_BossHover

.act		dc.w .leftup-.act, .rightdown-.act, .leftdown-.act, .rightup-.act

.leftup		bset	#0,Status(a0)
		move.w	#SLZ2_Boss_UpSpd,X_Vel(a0)
		move.w	#SLZ2_Boss_UpY,Boss_Y(a0)
		move.w	#SLZ2_Boss_Pos_Left-$3C,Boss_X(a0)
		rts

.leftdown	bset	#0,Status(a0)
		move.w	#SLZ2_Boss_DownSpd,X_Vel(a0)
		move.w	#SLZ2_Boss_DownY,Boss_Y(a0)
		move.w	#SLZ2_Boss_Pos_Left-$3C,Boss_X(a0)
		addq.w	#2,Boss_X(a0)
		rts

.rightup	bclr	#0,Status(a0)
		move.w	#-SLZ2_Boss_UpSpd,X_Vel(a0)
		move.w	#SLZ2_Boss_UpY,Boss_Y(a0)
		move.w	#SLZ2_Boss_Pos_Right+$3C,Boss_X(a0)
		subq.w	#2,Boss_X(a0)
		rts

.rightdown	bclr	#0,Status(a0)
		move.w	#-SLZ2_Boss_DownSpd,X_Vel(a0)
		move.w	#SLZ2_Boss_DownY,Boss_Y(a0)
		move.w	#SLZ2_Boss_Pos_Right+$3C,Boss_X(a0)
		subq.w	#2,Boss_X(a0)
		rts

SLZ2_Boss_Attack:
		btst	#0,Status(a0)
		bne.s	.left
		
		cmpi.w	#SLZ2_Boss_Pos_Left-$40,Boss_X(a0)
		bgt.s	.norm
		subq.b	#2,Routine2(a0)
		move.w	#SLZ2_Boss_AttackDelay,Off3C(a0)
		bra	SLZ2_Boss_BossHover
		
.left		cmpi.w	#SLZ2_Boss_Pos_Right+$40,Boss_X(a0)
		blt.s	.norm
		subq.b	#2,Routine2(a0)
		move.w	#SLZ2_Boss_AttackDelay,Off3C(a0)
		bra	SLZ2_Boss_BossHover

.norm		bsr	BossMove

		cmpi.w	#SLZ2_Boss_UpY,Boss_Y(a0)
		bne.s	.dwn
		move.w	$FFFFFE04.w,d0
		andi.w	#$F,d0
		bne.s	.skip
		
		cmpi.b	#$A,subtype(a0)
		bne.s	.k
		move.w	$FFFFFE04.w,d0
		andi.w	#$1F,d0
		bne.s	.skip

.k		jsr	SingleObjLoad		; load next object
		bne.s	.skip			; if all slots are full, end
		move.b	#SLZ2_Boss_ID,(a1)
		move.w	Boss_X(a0),X_pos(a1)	;
		move.w	Boss_Y(a0),Y_Pos(a1)	; copy positions
		move.b	Subtype(a0),Routine(a1)	; copy positions
.skip		bra	SLZ2_Boss_BossHover

.dwn		move.w	Object_RAM+X_Pos.w,d0
		sub.w	Boss_X(a0),d0

		btst	#0,Status(a0)
		bne.s	.left2
		neg.w	d0

.left2		cmpi.w	#$58,d0
		bgt.s	.skip
		tst.w	d0
		bmi.s	.skip

		move.w	Object_RAM+Y_Pos.w,d0
		sub.w	Boss_Y(a0),d0
		cmpi.w	#$30,d0
		bgt.s	.skip

		move.w	$FFFFFE04.w,d0
		andi.w	#7,d0
		bne.s	.skip
		
		jsr	SingleObjLoad		; load next object
		bne.s	.skip			; if all slots are full, end
		move.b	#SLZ2_Boss_ID,(a1)
		move.w	Boss_X(a0),X_pos(a1)	;
		move.w	Boss_Y(a0),Y_Pos(a1)	; copy positions
		move.b	Subtype(a0),Routine(a1)	; copy positions
		move.w	#$38,Y_Vel(a1)
		move.w	X_Vel(a0),X_Vel(a1)	; copy X_Vel
		asl	X_Vel(a1)
		bra	SLZ2_Boss_BossHover

; ===========================================================================
SLZ2_Boss_Explode:				; XREF: SLZ2_Boss_ShipIndex
		subq.w	#1,Off3C(a0)		; decrement timer
		bmi.s	.defeated		; if negative, branch
		bra.w	BossDefeated		; generate explosions

.defeated	bset	#0,Status(a0)		; face right
		bclr	#7,Status(a0)		; set defeated
		clr.w	X_Vel(a0)		; clear speed
		addq.b	#2,Routine2(a0)		; next routine
		move.w	#-$26,Off3C(a0)		; set timer(?)
		tst.b	$FFFFF7A7.w		;
		bne.s	.rts			;
		move.b	#1,$FFFFF7A7.w		; something to do with animals

.rts		rts
; ===========================================================================

SLZ2_Boss_BeforeEscape:				; XREF: SLZ2_Boss_ShipIndex
		addq.w	#1,Off3C(a0)		; increment timer
		beq.s	SLZ2_Boss_BE_StartGoUp	; if 0, start climbing upwards
		bpl.s	SLZ2_Boss_BE_GoUp	; if greater than 0, go upwards
		addi.w	#$18,Y_Vel(a0)		; apply gravity
		bra.s	SLZ2_Boss_BE_Move	; do main movement routines
; ===========================================================================

SLZ2_Boss_BE_StartGoUp:
		clr.w	Y_Vel(a0)		; clear Y-velocity
		bra.s	SLZ2_Boss_BE_Move	; do main movement routines
; ===========================================================================

SLZ2_Boss_BE_GoUp:
		cmpi.w	#$30,Off3C(a0)		; is timer $30?
		blo.s	.moveUp			; if less, move up
		beq.s	SLZ2_Boss_BE_PlayMusic	; is same, clear Y-velocity and play zone music
		cmpi.w	#$38,Off3C(a0)		; is timer $38?
		blo.s	SLZ2_Boss_BE_Move	; if less, branch
		addq.b	#2,Routine2(a0)		; increment routine
		bra.s	SLZ2_Boss_BE_Move	; do main movement routines
; ===========================================================================

.moveUp		subq.w	#8,Y_Vel(a0)		; move upwards

SLZ2_Boss_BE_Move:
		bsr.w	BossMove		; move the boss
		bra.w	SLZ2_Boss_BossHover	; hover
; ===========================================================================

SLZ2_Boss_BE_PlayMusic:
		pea	SLZ2_Boss_BE_Move(pc)	; go to movement routine after
		clr.w	Y_Vel(a0)		; clear Y-velocity
		moveq	#$FFFFFFE0,d0
		jmp	PlayMusic		; fade music out

; ===========================================================================

SLZ2_Boss_Escape:				; XREF: SLZ2_Boss_ShipIndex
		move.w	#$400,X_Vel(a0)		; set escape speed
		move.w	#-$40,Y_Vel(a0)		; go upwards

		cmpi.w	#SLZ2_Boss_Finish_X,$FFFFF72A.w	; if finished scrolling..
		bge.s	.finish			; ...branch
		addq.w	#2,$FFFFF72A.w		; move level minimum horizontal position
		bra.s	SLZ2_Boss_BE_Move	; do main movement routines
; ===========================================================================

.finish		tst.b	Render_Flags(a0)	; is on-screen?
		bpl.s	SLZ2_Boss_ShipDel	; if isnt, branch
		bra	SLZ2_Boss_BE_Move	; do main movment routines
; ===========================================================================

SLZ2_Boss_ShipDel:
		jmp	DeleteObject		; delete boss

; ===========================================================================
SLZ2_Boss_Bomb:
		moveq	#0,d0
		move.b	Routine2(a0),d0
		move.w	.I(pc,d0.w),d0
		jsr	.I(pc,d0.w)
		jmp	DisplaySprite
		
.I		dc.w .Main-.I,.Fall-.I

.Main		move.l	#Map_obj5Ea,Mappings_Offset(a0)
		move.w	#$518,Art_Tile(a0)
		move.b	#1,Anim_Frame(a0)
		ori.b	#4,Render_Flags(a0)
		move.b	#4,Priority(a0)
		move.b	#$8B,Coll(a0)
		move.b	#$C,X_Visible(a0)
		addq.b	#2,Routine2(a0)

.Fall		jsr	ObjectFall

		jsr	ObjHitFloor
		tst.w	d1
		bpl.s	.skip2
		add.w	d1,Y_Pos(a0)

		cmpi.b	#$A,Routine(a0)
		bne.s	.skip
		moveq	#3,d1
		lea	Obj7B_FragSpeed(pc),a2

.Loop		jsr	SingleObjLoad
		bne.s	.no
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

.no		dbf	d1,.Loop	; repeat sequence 3 more times
.skip		move.b	#$3F,(a0)
		sf	Routine(a0)
.skip2		rts
