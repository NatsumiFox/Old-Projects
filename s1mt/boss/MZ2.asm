MZ2_Boss_ID:		equ $4F
MZ2_Boss_Pos_Left:	equ $18C0
MZ2_Boss_Pos_Right:	equ $1A00
MZ2_Boss_Pos_Up:	equ $394
MZ2_Boss_Pos_Down:	equ $3A2
MZ2_Boss_DescY:		equ $200+$20

MZ2_Boss_SP_X:		equ $1960
MZ2_Boss_SP_Y:		equ $200-$50
MZ2_Boss_Finish_X:	equ MZ2_Boss_Pos_Left+$140

MZ2_Boss_PosBat_Up:	equ MZ2_Boss_Pos_Up+$20
MZ2_Boss_PosBat_Down:	equ MZ2_Boss_Pos_Up+$B0

; ---------------------------------------------------------------------------
; Object - Boss (MZ2)
; ---------------------------------------------------------------------------
MZ2_Boss:					; XREF: Obj_Index
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	MZ2_Boss_Index(pc,d0.w),d1
		jmp	MZ2_Boss_Index(pc,d1.w)
; ===========================================================================
MZ2_Boss_Index:	dc.w MZ2_Boss_Main-MZ2_Boss_Index
		dc.w MZ2_Boss_ShipMain-MZ2_Boss_Index
		dc.w MZ2_Boss_FaceMain-MZ2_Boss_Index
		dc.w GHZ2_Boss_FlameMain-MZ2_Boss_Index
		dc.w MZ2_Boss_Spikes-MZ2_Boss_Index
		dc.w MZ2_Boss_Bats-MZ2_Boss_Index

			; routine counter, animation
MZ2_Boss_ObjData:	dc.b 2,	0	; the main ship
			dc.b 4,	1	; Eggman face
			dc.b 6,	7	; flame from the ship
; ===========================================================================

MZ2_Boss_Main:				; XREF: MZ2_Boss_Index
		lea	MZ2_Boss_ObjData,a2	; get data array
		movea.l	a0,a1			; copy this object to a1
		moveq	#2,d1			; get length
		bra.s	MZ2_Boss_LoadBoss	; start with current object
; ===========================================================================

MZ2_Boss_Loop:
		jsr	SingleObjLoad2		; load next object
		bne.s	MZ2_Boss_SkipLoad	; if all slots are full, end

MZ2_Boss_LoadBoss:				; XREF: MZ2_Boss_Main
		move.b	(a2)+,Routine(a1)	; get routine counter
		move.b	#MZ2_Boss_ID,(a1)	; use current object
		move.w	X_pos(a0),X_pos(a1)	;
		move.w	Y_Pos(a0),Y_Pos(a1)	; copy positions
		move.l	#Map_Eggman,Mappings_Offset(a1); get mappings
		move.w	#$400,Art_Tile(a1)	;
		move.b	#4,Render_Flags(a1)	;
		move.b	#$20,X_Visible(a1)	;
		move.b	#3,Priority(a1)		;
		move.b	(a2)+,Anim(a1)		; get animation
		move.l	a0,Off34(a1)		; save boss address
		dbf	d1,MZ2_Boss_Loop	; repeat sequence 2 more timesF

MZ2_Boss_SkipLoad:
		move.w	X_pos(a0),Boss_X(a0)	;
		move.w	Y_Pos(a0),Boss_Y(a0)	; copy positions to other memory
		move.b	#$F,Coll(a0)		; set to boss
		move.b	#-1,Coll2(a0)		; set number of	hits to	8

MZ2_Boss_ShipMain:				; XREF: MZ2_Boss_Index
		moveq	#0,d0
		move.b	Routine2(a0),d0			; get secondary routine counter
		move.w	MZ2_Boss_ShipIndex(pc,d0.w),d1
		jsr	MZ2_Boss_ShipIndex(pc,d1.w)	; jump to the correct routine

		lea	Ani_Eggman,a1
		jsr	AnimateSprite			; animate object
		move.b	Status(a0),d0
		andi.b	#3,d0				; only maintain X and Y flip bits
		andi.b	#$FC,Render_Flags(a0)		; clear X and Y flip bits
		or.b	d0,Render_Flags(a0)		; if X and Y flip bits were set, copy to Render flags
		jmp	DisplaySprite			; display sprite
; ===========================================================================
MZ2_Boss_ShipIndex:dc.w MZ2_Boss_ShipStart-MZ2_Boss_ShipIndex
		dc.w MZ2_Boss_Correct-MZ2_Boss_ShipIndex
		dc.w MZ2_Boss_Destroy-MZ2_Boss_ShipIndex
		dc.w MZ2_Boss_Descend-MZ2_Boss_ShipIndex
		dc.w MZ2_Boss_Attacks-MZ2_Boss_ShipIndex

		dc.w MZ2_Boss_Explode-MZ2_Boss_ShipIndex
		dc.w MZ2_Boss_BeforeEscape-MZ2_Boss_ShipIndex
		dc.w MZ2_Boss_Escape-MZ2_Boss_ShipIndex
		dc.w MZ2_Boss_WaitGFX-MZ2_Boss_ShipIndex
; ===========================================================================
MZ2_Boss_Correct:
		move.w	Object_RAM+X_pos,d0
		cmpi.w	#MZ2_Boss_Pos_Left+$30,d0
		bgt.s	.skp
		move.w	#$800,$FFFFF602.w
		rts

.skp		cmpi.w	#MZ2_Boss_Pos_Right-$30,d0
		blt.s	.done
		move.w	#$400,$FFFFF602.w
		rts

.done 		move.b	#1,$FFFFF7C8.w
		move.w	#0,$FFFFF602.w
		move.b	#7,Object_RAM+Anim.w
		addq.b	#2,Routine2(a0)		; goto next routine
		rts

MZ2_Boss_WaitGFX:
		subq.b	#1,Off3C(a0)
		bpl.s	MZ2_Boss_WaitGFX_rts
		move.b	#6,Routine2(a0)
MZ2_Boss_WaitGFX_rts:
		rts

MZ2_Boss_ShipStart:
		cmpi.w	#MZ2_Boss_Pos_Up,Object_RAM+Y_Pos.w
		blt.s	.no
		move.b	#$1B,Object_RAM+Anim.w	; use Sonic's "sliding" animation
		move.b	#1,$FFFFF7CC.w
		cmpi.w	#MZ2_Boss_Pos_Up,($FFFFF72E).w
		beq.s	.noredraw
		move.b	#1,Dirty_Flag.w

.noredraw	move.w	#MZ2_Boss_Pos_Up,($FFFFF72E).w
		move.w	#MZ2_Boss_Pos_Up,($FFFFF726).w
		move.l	#Level_MZ2_Fall,Layout_Data.w

		cmpi.b	#$34,Ttlcard_RAM.w	; if title cards are on, prohibit
		beq	MZ2_Boss_WaitGFX_rts
		move.b	#15,Off3C(a0)
		move.b	#$10,Routine2(a0)
		moveq	#$E,d0
		jmp	LoadPLC2		; load boss patterns

.no		move.w	#$100,Y_Vel(a0)		; move ship down
		bsr.w	BossMove		; run movement routines
		cmpi.w	#MZ2_Boss_DescY,Boss_Y(a0); if Y position is low enough
		blt.s	MZ2_Boss_BossHover	; if not, skip
		move.w	#0,Y_Vel(a0)		; stop ship
		move.w	#MZ2_Boss_DescY,Boss_Y(a0)

		cmpi.w	#$2AA,Object_RAM+Y_Pos.w
		blt.s	MZ2_Boss_BossHover
		addq.b	#2,Routine2(a0)		; goto next routine
		move.w	#($1F*5)-1,Off3C(a0)	; shake timer

		move.b	#1,$FFFFF7CC.w
		move.w	#0,$FFFFF602.w
		move.l	#0,Spindash_HorizDelay.w
		move.b	#7,Object_RAM+Anim.w

		bset	#0,Object_RAM+Status.w
		move.w	Object_RAM+X_Pos.w,d0
		sub.w	Boss_X(a0),d0
		bpl.s	MZ2_Boss_BossHover
		bclr	#0,Object_RAM+Status.w

MZ2_Boss_BossHover:
		move.b	Off3F(a0),d1		; get offset
		jsr	CalcSine		; get sine
		asr.w	#6,d0			; shift right 6 bits
		add.w	Boss_Y(a0),d0		; add Boss Y-position
		move.w	d0,Y_Pos(a0)		; set to actual Y-position
		move.w	Boss_X(a0),X_pos(a0)	; copy Y-position to actual Y-position
		addq.b	#2,Off3F(a0)		; increment offset
		cmpi.b	#$A,Routine2(a0)	; is secondary routine counter 8?
		bhs.s	MZ2_Boss_NoFlash	; if higher or same, skip flashing

		tst.b	Status(a0)		;
		bmi.s	MZ2_Boss_SetDefeat	; if no hits left, set defeated
		tst.b	Coll(a0)		; if colliding, dont flash
		bne.s	MZ2_Boss_NoFlash	; else do
		tst.b	Off3E(a0)		; has timer ran out?
		bne.s	MZ2_Boss_ShipFlash	; if hasnt, start flashing

		move.b	#$20,Off3E(a0)		; set number of	times for ship to flash
		move.w	#$AC,d0			;
		jsr	PlaySound		; play boss damage sound

MZ2_Boss_ShipFlash:
		lea	$FFFFFB22,a1 		; load 2nd line, 2nd entry
		moveq	#0,d0			; move 0 (black) to d0
		tst.w	(a1)			; does the line currently have this entry?
		bne.s	.set			; if not, branch
		move.w	#$EEE,d0		; move 0EEE (white) to d0

.set		move.w	d0,(a1)			; load colour stored in	d0
		subq.b	#1,Off3E(a0)		; decrement timer
		bne.s	MZ2_Boss_NoFlash	; if still not 0, branch
		move.b	#$F,Coll(a0)		; reset collision and stop flashing

MZ2_Boss_NoFlash:
		rts
; ===========================================================================

MZ2_Boss_SetDefeat:				; XREF: MZ2_Boss_BossHover
		moveq	#100,d0		; 100 points
		bsr.w	AddPoints	; add points
		move.b	#$A,Routine2(a0); set to defeated subroutine
		move.w	#$B3,Off3C(a0)	; explosion timer

		lea	Object_RAM_Free-$40,a1 ; start address for object RAM
		move.w	#$5F,d0

.loop		lea	Next_Obj(a1),a1		; goto next object RAM slot
		cmpi.b	#MZ2_Boss_ID,(a1)
		bne.s	.next
		cmpi.b	#$A,Routine(a1)
		bne.s	.next
		move.b	#$3F,(a1)
		move.l	#0,Routine(a1)

.next		dbf	d0,.loop		; if the slot is not empty, repeat $5F times

		moveq	#5,d0
		jmp	LoadPLC
; ===========================================================================

MZ2_Boss_Attacks:
		bsr	BossMove
		subi.w	#1,Off3C(a0)
		bpl	MZ2_Boss_AttackUp
		move.l	#$80,X_Vel(a0)		; actually $80 to Y_Vel, but clears X_Vel

		cmpi.w	#-4,Off3C(a0)
		beq.s	MZ2_Boss_Spawn
		cmpi.w	#-95,Off3C(a0)
		bgt	MZ2_Boss_BossHover

		move.w	#5*60,Off3C(a0)
		bra	MZ2_Boss_BossHover

MZ2_Boss_Spawn:
		moveq	#2,d6
.loop		jsr	SingleObjLoad2		; load next object
		bne	MZ2_Boss_BossHover	; if all slots are full, end
		move.b	#MZ2_Boss_ID,(a1)	; set ID
		move.w	X_pos(a0),X_pos(a1)	;
		move.w	Y_Pos(a0),Y_Pos(a1)	; copy positions
		move.b	#$A,Routine(a1)
		dbf	d6,.loop
		bra	MZ2_Boss_BossHover

MZ2_Boss_AttackUp:
		subq.b	#1,Off3B(a0)
		bpl.s	.cont
		move.w	#0,X_Vel(a0)
		bset	#0,Status(a0)

		move.w	#$100,d1
		move.w	Object_RAM+X_Pos,d0
		sub.w	Boss_X(a0),d0
		bmi.s	.skip
		move.w	#-$100,d1
		bclr	#0,Status(a0)
		neg.w	d0

.skip		move.b	#15,Off3B(a0)
		cmpi.w	#-$60,d0
		ble.s	.cont

		move.w	d1,X_Vel(a0)

.cont		move.w	#0,Y_Vel(a0)
		cmpi.w	#MZ2_Boss_Pos_Down+$10-6,Boss_Y(a0)
		blt	.more
		move.w	#-$100,Y_Vel(a0)
		move.w	#0,X_Vel(a0)

.more		cmpi.w	#MZ2_Boss_Pos_Left+$20,Boss_X(a0)
		bgt.s	.1
		move.w	#MZ2_Boss_Pos_Left+$22,Boss_X(a0)
		move.b	#100,Off3B(a0)
		neg.w	X_Vel(a0)
		bchg	#0,Status(a0)
		bra	MZ2_Boss_BossHover

.1		cmpi.w	#MZ2_Boss_Pos_Right-$20,Boss_X(a0)
		blt	MZ2_Boss_BossHover
		move.w	#MZ2_Boss_Pos_Right-$22,Boss_X(a0)
		move.b	#100,Off3B(a0)
		neg.w	X_Vel(a0)
		bchg	#0,Status(a0)
		bra	MZ2_Boss_BossHover

MZ2_Boss_Destroy:
		cmpi.w	#-($1F*7),Off3C(a0)
		blt.s	.skip
		move.w	Off3C(a0),d0		; get some universal counter
		andi.w	#$1F,d0			;
		bne.s	.skip

		jsr	SingleObjLoad2		; load next object
		bne.s	.skip			; if all slots are full, end
		move.b	#MZ2_Boss_ID,(a1)	; set ID
		move.w	X_pos(a0),X_pos(a1)	;
		move.w	Y_Pos(a0),Y_Pos(a1)	; copy positions
		move.b	#8,Routine(a1)

.skip		bsr.s	MZ2_Boss_Shake
		bsr.w	MZ2_Boss_BossHover
		bra.w	BossMove

MZ2_Boss_Shake:
		subq.w	#1,Off3C(a0)
		bmi.s	.negative

		cmpi.w	#($1F*3)-5,Off3C(a0)
		bne.s	.chk1
		move.w	#8,ShakeOffset_Mode.w
		rts

.chk1		cmpi.w	#($1F*2)-5,Off3C(a0)
		bne.s	.chk2
		move.w	#12,ShakeOffset_Mode.w
		rts

.chk2		cmpi.w	#($1F*1)-5,Off3C(a0)
		bne.s	.chk3
		move.w	#16,ShakeOffset_Mode.w
.chk3		rts

.negative	move.w	#-1,ShakeOffset_Mode.w

		cmpi.w	#-($1F*2),Off3C(a0)
		beq.s	.setScroll
		blt.s	.scroll

		move.w	#$202,d0
		sub.w	$FFFFF704.w,d0
		bpl.s	.skip
		move.w	#$200,$FFFFF704.w
.skip		rts

.setScroll	move.b	#$1C,Level_VBIRoutine.w		; set to per-cell VScroll VBlank routine
		jmp	GHZ2Boss_ResetScroll

.scroll		cmpi.w	#-($1F*9),Off3C(a0)
		beq.s	MZ2_Boss_Shake_Fall
		blt.s	.skip

		move.w	#MZ2_Boss_Pos_Down,d0
		sub.w	$FFFFF704.w,d0
		bpl.s	.skip2
		move.w	#MZ2_Boss_Pos_Down-2,$FFFFF704.w

.skip2		move.b	#6,Object_RAM+Anim.w
		move.w	Off3C(a0),d2
		add.w	#($1F*2),d2
		lsr.w	#4,d2

		move.w	d2,Object_RAM+Y_Pos.w
		sub.w	#$FFF-$2AC,Object_RAM+Y_Pos.w

		moveq	#($50/4)-1,d0		; set transfer lenght
		move.l	$FFFFF616.w,d1		; get... A thing? (Probably base vertical offset for displaying Plane A and B)
		lea	VScroll_RAM.w,a1	; get RAM where VScroll values are to be stored

.fill		move.l	d1,(a1)+		; fill with value
		add.w	d2,-4(a1)
		neg.w	d2
		dbf	d0,.fill		; loop until done

		move.b	$FFFFFE0F.w,d0		; get some universal counter
		andi.b	#3,d0			; check bits 0, 1, and 2
		bne.s	.rts			; if nonzero, branch

		jsr	SingleObjLoad		; load an object
		bne.s	.rts			; if slots are used, skip code

		move.b	#$3F,(a1)		; load explosion object
		move.w	X_pos(a0),X_pos(a1)	;
		move.w	#$200+210,Y_Pos(a1)	; copy positions to explosion

		jsr	RandomNumber		; generate random number
		lsr.l	#8,d1
		andi.w	#$17F,d1
		subi.w	#$17F/2,d1
		add.w	d1,X_pos(a1)		; add it to the X-position of explosion
.rts		rts

MZ2_Boss_Shake_Fall:
		move.l	#0,Object_RAM+X_Vel.w
		move.w	#0,Object_RAM+Inertia.w
		move.l	#0,Spindash_HorizDelay.w
		move.w	#0,ShakeOffset_Mode.w
		move.b	#$1B,Object_RAM+Anim.w	; use Sonic's "sliding" animation
		move.b	#0,$FFFFF7C8.w
		move.w	#MZ2_Boss_Pos_Up,($FFFFF72E).w
		move.w	#MZ2_Boss_Pos_Up,($FFFFF726).w
		addq.b	#2,Routine2(a0)
		addq.b	#2,($FFFFF742).w		; set to normal resize type
		move.l	#Level_MZ2_Fall,Layout_Data.w
		move.l	a0,-(sp)
		jsr	LoadTilesFromStart
		move.l	(sp)+,a0
		jmp	GHZ2Bos_StopScroll

MZ2_Boss_Descend:
		cmpi.w	#$44A-8,Object_RAM+Y_Pos.w
		blt.s	.fall
		cmpi.w	#MZ2_Boss_Pos_Down-$20,Boss_Y(a0)
		bgt.s	.no
		move.w	#MZ2_Boss_Pos_Down-$20,Boss_Y(a0)
		bra.s	.no

.fall		move.b	#$1B,Object_RAM+Anim.w	; use Sonic's "sliding" animation

.no		cmpi.w	#MZ2_Boss_Pos_Down+$10-6,Boss_Y(a0)
		blt.s	.move

		move.w	#0,Y_Vel(a0)
		addq.b	#2,Routine2(a0)
		move.w	#MZ2_Boss_Pos_Up,($FFFFF72C).w
		move.b	#0,$FFFFF7CC.w
		move.b	#8,Coll2(a0)		; set number of	hits to	8
		bsr.s	SetCheckPoint
		bra.s	.rt

.move		move.w	#$100,Y_Vel(a0)		; move ship down
.rt		bsr.w	MZ2_Boss_BossHover
		bra.w	BossMove

SetCheckPoint:
		jsr	Obj79_StoreInfo
		move.b	#$F,$FFFFFE30.w 		; lamppost number
		move.w	Object_RAM+X_Pos.w,$FFFFFE32.w	; x-position
		move.w	Object_RAM+Y_Pos.w,$FFFFFE34.w	; y-position
		subi.w	#$60,$FFFFFE34.w
		move.b	#0,$FFFFFE3C.w

		cmpi.w	#MZ2_Boss_Pos_Left+$30,$FFFFFE32.w
		bgt.s	.n
		move.w	#MZ2_Boss_Pos_Left+$30,$FFFFFE32.w

.n		cmpi.w	#MZ2_Boss_Pos_Right-$30,$FFFFFE32.w
		blt.s	.rts
		move.w	#MZ2_Boss_Pos_Right-$30,$FFFFFE32.w
.rts		rts
; ===========================================================================
MZ2_Boss_Explode:				; XREF: MZ2_Boss_ShipIndex
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

MZ2_Boss_BeforeEscape:				; XREF: MZ2_Boss_ShipIndex
		addq.w	#1,Off3C(a0)		; increment timer
		beq.s	MZ2_Boss_BE_StartGoUp	; if 0, start climbing upwards
		bpl.s	MZ2_Boss_BE_GoUp	; if greater than 0, go upwards
		addi.w	#$18,Y_Vel(a0)		; apply gravity
		bra.s	MZ2_Boss_BE_Move	; do main movement routines
; ===========================================================================

MZ2_Boss_BE_StartGoUp:
		clr.w	Y_Vel(a0)		; clear Y-velocity
		bra.s	MZ2_Boss_BE_Move	; do main movement routines
; ===========================================================================

MZ2_Boss_BE_GoUp:
		cmpi.w	#$30,Off3C(a0)		; is timer $30?
		blo.s	.moveUp			; if less, move up
		beq.s	MZ2_Boss_BE_PlayMusic	; is same, clear Y-velocity and play zone music
		cmpi.w	#$38,Off3C(a0)		; is timer $38?
		blo.s	MZ2_Boss_BE_Move	; if less, branch
		addq.b	#2,Routine2(a0)		; increment routine
		bra.s	MZ2_Boss_BE_Move	; do main movement routines
; ===========================================================================

.moveUp		subq.w	#8,Y_Vel(a0)		; move upwards

MZ2_Boss_BE_Move:
		bsr.w	BossMove		; move the boss
		bra.w	MZ2_Boss_BossHover	; hover
; ===========================================================================

MZ2_Boss_BE_PlayMusic:
		pea	MZ2_Boss_BE_Move(pc)	; go to movement routine after
		clr.w	Y_Vel(a0)		; clear Y-velocity
		moveq	#$FFFFFFE0,d0
		jmp	PlayMusic		; fade music out

; ===========================================================================

MZ2_Boss_Escape:				; XREF: MZ2_Boss_ShipIndex
		move.w	#$300,X_Vel(a0)		; set escape speed
		move.w	#0,Y_Vel(a0)		; go upwards
		bset	#0,status(a0)

		move.b	#4,$FFFFF742.w
		cmpi.w	#MZ2_Boss_Finish_X,$FFFFF72A.w	; if finished scrolling..
		bge.s	.finish			; ...branch
		addq.w	#2,$FFFFF72A.w		; move level minimum horizontal position
		bra.s	MZ2_Boss_BE_Move	; do main movement routines
; ===========================================================================

.finish		tst.b	Render_Flags(a0)	; is on-screen?
		bpl.s	MZ2_Boss_ShipDel	; if isnt, branch
		bra	MZ2_Boss_BE_Move	; do main movment routines
; ===========================================================================

MZ2_Boss_ShipDel:
		jmp	DeleteObject		; delete boss

MZ2_Boss_Spikes:
		moveq	#0,d0
		move.b	Routine2(a0),d0
		move.w	.I(pc,d0.w),d1
		jmp	.I(pc,d1.w)
; ===========================================================================
.I		dc.w .Main-.I
		dc.w MZ2_Boss_Spikes_Fall-.I
; ===========================================================================
.Main		addq.b	#2,Routine2(a0)
		move.l	#Map_obj36,Mappings_Offset(a0)
		move.w	#$51B,Art_Tile(a0)
		ori.b	#6,Render_Flags(a0)
		move.b	#4,Priority(a0)

		move.b	#2,Anim_Frame(a0)
		move.b	#4,X_Visible(a0)

MZ2_Boss_Spikes_Fall:
		jsr	ObjectFall
		jsr	ObjHitFloor
		tst.w	d1
		bpl.s	.disp

		move.w	#0,Y_Vel(a0)
		move.b	#$3F,(a0)
		move.b	#0,Routine(a0)
		rts

.disp		jmp	DisplaySprite

; ===========================================================================
MZ_Boss_Bats_ModeFly:
		illegal
		bra.s	MZ_Boss_Bats_ModeFly

MZ2_Boss_Bats:
		moveq	#0,d0
		move.b	Off2A(a0),d0
		move.w	MZ2_Boss_Bats_Index(pc,d0.w),d1
		jmp	MZ2_Boss_Bats_Index(pc,d1.w)
; ===========================================================================
MZ2_Boss_Bats_Index:	dc.w .Main-MZ2_Boss_Bats_Index
			dc.w MZ2_Boss_Bats_Action-MZ2_Boss_Bats_Index
; ===========================================================================
.Main		addq.b	#2,Off2A(a0)
		move.l	#Map_obj55,Mappings_Offset(a0)
		move.w	#$84B8,Art_Tile(a0)
		move.b	#4,Render_Flags(a0)
		move.b	#$C,Y_Radius(a0)
		move.b	#4,Priority(a0)
		move.b	#$B,Coll(a0)
		move.b	#$10,X_Visible(a0)
		move.b	#2,SubType(a0)
		move.w	#60*2,Angle(a0)

MZ2_Boss_Bats_Action:
		moveq	#0,d0
		move.b	Routine2(a0),d0
		move.w	.I2(pc,d0.w),d1
		jsr	.I2(pc,d1.w)
		bsr.s	MZ2_Boss_Bats_CheckArea
		jsr	SpeedToPos
		lea	(Ani_obj55).l,a1
		jsr	AnimateSprite
		jmp	DisplaySprite
; ===========================================================================
.I2		dc.w MZ2_Boss_Bats_Wait-.I2
		dc.w MZ2_Boss_Bats_FlyAround-.I2
		dc.w MZ2_Boss_Bats_Attack-.I2
		dc.w MZ2_Boss_Bats_Escape-.I2
; ===========================================================================
MZ2_Boss_Bats_stop:
		move.l	#0,X_Vel(a0)
		move.w	#0,Angle(a0)
		rts

MZ2_Boss_Bats_CheckArea:
		cmpi.w	#MZ2_Boss_Pos_Left+$10,X_Pos(a0)
		bgt.s	.1
		bset	#0,Off29(a0)
		move.w	#MZ2_Boss_Pos_Left+$12,X_Pos(a0)
		bra.s	MZ2_Boss_Bats_stop

.1		cmpi.w	#MZ2_Boss_Pos_Right-$10,X_Pos(a0)
		blt.s	.2
		bset	#1,Off29(a0)
		move.w	#MZ2_Boss_Pos_Right-$12,X_Pos(a0)
		bra.s	MZ2_Boss_Bats_stop

.2		cmpi.w	#MZ2_Boss_PosBat_Up,Y_Pos(a0)
		bgt.s	.3
		bset	#2,Off29(a0)
		move.w	#MZ2_Boss_PosBat_Up+2,Y_Pos(a0)
		bra.s	MZ2_Boss_Bats_stop

.3		cmpi.w	#MZ2_Boss_PosBat_Down,Y_Pos(a0)
		blt.s	MZ2_Boss_Bats_rts
		bset	#3,Off29(a0)
		move.w	#MZ2_Boss_PosBat_Down-2,Y_Pos(a0)
		bra.s	MZ2_Boss_Bats_stop

MZ2_Boss_Bats_Wait:
		move.l	#0,X_Vel(a0)
		move.b	#2,Anim(a0)

		subq.w	#1,Angle(a0)
		bpl.s	MZ2_Boss_Bats_rts
		move.b	SubType(a0),Routine2(a0)
		move.w	#0,Angle(a0)

MZ2_Boss_Bats_rts:
		rts

MZ2_Boss_Bats_OtherMode:
		lsr.w	#8,d1
		andi.w	#6,d1
		move.w	.I3(pc,d1.w),d1
		jmp	.I3(pc,d1.w)
; ===========================================================================
.I3		dc.w MZ_Boss_Bats_ModeFly-.I3
		dc.w MZ_Boss_Bats_ModeAttack-.I3
		dc.w MZ_Boss_Bats_ModeEscape-.I3
		dc.w MZ_Boss_Bats_ModeAttack-.I3
; ===========================================================================

MZ2_Boss_Bats_FlyAround:
		lea	Object_RAM.w,a1
		move.w	Y_Pos(a1),d0
		sub.w	Y_Pos(a0),d0
		cmpi.w	#-$30,d0
		ble	MZ_Boss_Bats_ModeEscape

		subq.w	#1,Angle(a0)
		bpl.s	MZ2_Boss_Bats_rts
		jsr	RandomNumber

		move.b	#2,Anim(a0)
		btst	#$11,d0
		bne.s	.nope

		move.w	d0,d1
		andi.w	#$600,d1
		bne.s	MZ2_Boss_Bats_OtherMode

.nope		andi.w	#$1FF,d0
		addi.w	#$200,d0
		move.w	d0,X_Vel(a0)
		move.w	#0,Y_Vel(a0)

		bclr	#1,Off29(a0)
		bne.s	.rev
		bset	#0,Status(a0)
		bclr	#0,Off29(a0)
		bne.s	.noFlip

		btst	#$10,d0
		bne.s	.noFlip
.rev		bclr	#0,Status(a0)
		neg.w	X_Vel(a0)

.noFlip		lsr.w	#8,d0
		lsr.w	#2,d0
		andi.w	#$3F,d0
		addi.w	#$20,d0
		move.w	d0,Angle(a0)
.rts		rts

MZ_Boss_Bats_ModeAttack:
		move.b	#0,Routine2(a0)
		move.b	#4,SubType(a0)
		move.w	#7,Angle(a0)
		rts

MZ2_Boss_Bats_Attack:
		subq.w	#1,Angle(a0)
		bpl.s	.chks

		lea	Object_RAM.w,a1
		move.w	Y_Pos(a1),d0
		sub.w	Y_Pos(a0),d0
		cmpi.w	#$30,d0
		ble.s	.chkAbove
		move.b	#1,Anim(a0)
		move.w	#$60,Inertia(a0)
		move.w	#8,Angle(a0)
		move.b	#1,Anim(a0)
		rts

.chkAbove	cmpi.w	#-$30,d0
		ble.s	MZ_Boss_Bats_ModeEscape

		; not below or above
		move.w	#60,Angle(a0)
		move.b	#2,Anim(a0)
		move.b	#2,Routine2(a0)
		rts

.chks		move.w	Inertia(a0),d0
		add.w	d0,Y_Vel(a0)
		rts

MZ_Boss_Bats_ModeEscape:
		move.b	#6,Routine2(a0)
		move.w	#0,Angle(a0)
		rts

MZ2_Boss_Bats_Escape:
		subq.w	#1,Angle(a0)
		bpl.s	.chks

		jsr	RandomNumber
		btst	#3,d0
		bne.s	.FlyAround

		bset	#0,Status(a0)
		move.w	X_pos(a0),d1
		move.w	Y_Pos(a0),d2
		sub.w	X_pos(a1),d1
		bpl.s	.noTurn
		bclr	#0,Status(a0)

.noTurn		sub.w	Y_Pos(a1),d2
		jsr	CalcAngle
		jsr	CalcSine
		muls.w	#$200,d1
		asr.l	#8,d1
		move.w	d1,X_Vel(a0)
		muls.w	#$200,d0
		asr.l	#8,d0
		move.w	d0,Y_Vel(a0)
		move.w	#30,Angle(a0)
		move.b	#2,Anim(a0)
		rts

.chks		subi.w	#$18,Y_Vel(a0)
		rts

.FlyAround	move.b	#2,Routine2(a0)
		move.w	#0,Angle(a0)
		rts

MZ2_Boss_FaceMain:
		moveq	#0,d0
		moveq	#1,d1
		movea.l	Off34(a0),a1
		move.b	(a0),d0
		cmp.b	(a1),d0
		bne.w	GHZ3_Boss_FaceDel

		move.b	Routine2(a1),d0
		sub.b	#4,d0
		bmi.s	.hurt
		sub.b	#$A-4,d0
		bmi.s	.notDed
		moveq	#$A,d1
		bra.s	MZ2_Boss_FaceDo
; ===========================================================================

.notDed		tst.b	Coll(a1)
		bne.s	.notHurt
		moveq	#5,d1
		bra.s	MZ2_Boss_FaceDo
; ===========================================================================

.notHurt	cmpi.b	#4,Object_RAM+Routine.w
		blo.s	MZ2_Boss_FaceDo
.hurt		moveq	#4,d1

MZ2_Boss_FaceDo:
		move.b	d1,Anim(a0)
		subq.b	#2,d0
		bne.w	GHZ2_Boss_FaceDisp
		move.b	#6,Anim(a0)

MZ2_Boss_FaceDisp:
		bra.w	GHZ3_Boss_Display
