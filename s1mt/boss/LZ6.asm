LZ6_Boss_ID:		equ $4A
LZ6_Boss_Pos_Left:	equ 0
LZ6_Boss_Pos_Right:	equ $1FFF
LZ6_Boss_Main_Y:	equ $360
LZ6_Boss_Cut_X:		equ $1000
LZ6_Boss_ScrollSpeed	equ 2
LZ6_Boss_SonMinSpeed:	equ $100
LZ6_Boss_Speed:		equ $420
LZ6_Boss_SpeedSlow:	equ $340

LZ6_Boss_Finish_X:	equ 0
LZ6_Boss_SP_X:		equ $160
LZ6_Boss_SP_Y:		equ $3E0
LZ6_Boss_BubbleDelay:	equ 15

LZ6_Water_UpY:		equ $280
LZ6_Water_DownY:	equ $414
; ---------------------------------------------------------------------------
; Object - Boss (MZ2)
; ---------------------------------------------------------------------------
LZ6_Boss:					; XREF: Obj_Index
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	LZ6_Boss_Index(pc,d0.w),d1
		jmp	LZ6_Boss_Index(pc,d1.w)
; ===========================================================================
LZ6_Boss_Index:	dc.w LZ6_Boss_Main-LZ6_Boss_Index
		dc.w LZ6_Boss_ShipMain-LZ6_Boss_Index
		dc.w LZ6_Boss_FaceMain-LZ6_Boss_Index
		dc.w GHZ2_Boss_FlameMain-LZ6_Boss_Index

			; routine counter, animation
LZ6_Boss_ObjData:	dc.b 2,	0	; the main ship
			dc.b 4,	1	; Eggman face
			dc.b 6,	7	; flame from the ship
; ===========================================================================

LZ6_Boss_Main:				; XREF: LZ6_Boss_Index
		lea	LZ6_Boss_ObjData,a2	; get data array
		movea.l	a0,a1			; copy this object to a1
		moveq	#2,d1			; get length
		bra.s	LZ6_Boss_LoadBoss	; start with current object
; ===========================================================================

LZ6_Boss_Loop:
		jsr	SingleObjLoad2		; load next object
		bne.s	LZ6_Boss_SkipLoad	; if all slots are full, end

LZ6_Boss_LoadBoss:				; XREF: LZ6_Boss_Main
		move.b	(a2)+,Routine(a1)	; get routine counter
		move.b	#LZ6_Boss_ID,(a1)	; use current object
		move.w	X_pos(a0),X_pos(a1)	;
		move.w	Y_Pos(a0),Y_Pos(a1)	; copy positions
		move.l	#Map_Eggman,Mappings_Offset(a1); get mappings
		move.w	#$8400,Art_Tile(a1)	;
		move.b	#5,Render_Flags(a1)	;
		move.b	#$22,X_Visible(a1)	;
		move.b	#3,Priority(a1)		;
		move.b	(a2)+,Anim(a1)		; get animation
		move.l	a0,Off34(a1)		; save boss address
		dbf	d1,LZ6_Boss_Loop	; repeat sequence 2 more times

LZ6_Boss_SkipLoad:
		move.w	X_pos(a0),Boss_X(a0)	;
		move.w	Y_Pos(a0),Boss_Y(a0)	; copy positions to other memory
		move.b	#$F,Coll(a0)		; set to boss
		move.b	#5,Coll2(a0)		; set number of	hits to	5
		bset	#0,Status(a0)
		move.l	a0,ShakeOffset.w

LZ6_Boss_ShipMain:				; XREF: LZ6_Boss_Index
		moveq	#0,d0
		move.b	Routine2(a0),d0			; get secondary routine counter
		move.w	LZ6_Boss_ShipIndex(pc,d0.w),d1
		jsr	LZ6_Boss_ShipIndex(pc,d1.w)	; jump to the correct routine

		lea	Ani_Eggman,a1
		jsr	AnimateSprite			; animate object
		move.b	Status(a0),d0
		andi.b	#3,d0				; only maintain X and Y flip bits
		andi.b	#$FC,Render_Flags(a0)		; clear X and Y flip bits
		or.b	d0,Render_Flags(a0)		; if X and Y flip bits were set, copy to Render flags
		jmp	DisplaySprite			; display sprite
; ===========================================================================
LZ6_Boss_ShipIndex:dc.w LZ6_Boss_ShipStart-LZ6_Boss_ShipIndex
		dc.w LZ6_Boss_RunFrom-LZ6_Boss_ShipIndex

		dc.w LZ6_Boss_Explode-LZ6_Boss_ShipIndex
		dc.w LZ6_Boss_BeforeEscape-LZ6_Boss_ShipIndex
; ===========================================================================

LZ6_Boss_ShipStart:
		cmpi.b	#5,Coll2(a0)		; still has 5 hits?
		beq.s	LZ6_Boss_BossHover	; if so, skip
		addq.b	#2,Routine2(a0)
		move.b	#4,$FFFFF742.w
		move.b	#-1,Hacky_Mode.w
		move.b	#0,subtype(a0)

		move.b	#1,($FFFFFE2E).w ; speed up the	BG music
		move.w	#20,Object_RAM+Off34.w ; time limit for the power-up
		move.w	#Speed_UW_Sho,$FFFFF760.w	; set max speed
		move.w	#ACC_UW_Sho,$FFFFF762.w	; set acceleration
		move.w	#DEC_UW_Sho,$FFFFF764.w	; set deceleration

LZ6_Boss_BossHover:
		move.b	Off3F(a0),d1		; get offset
		jsr	CalcSine		; get sine
		asr.w	#6,d0			; shift right 6 bits
		add.w	Boss_Y(a0),d0		; add Boss Y-position
		move.w	d0,Y_Pos(a0)		; set to actual Y-position
		move.w	Boss_X(a0),X_pos(a0)	; copy Y-position to actual Y-position
		addq.b	#2,Off3F(a0)		; increment offset
		cmpi.b	#4,Routine2(a0)		; is secondary routine counter 8?
		bhs.s	LZ6_Boss_NoFlash	; if higher or same, skip flashing

		tst.b	Status(a0)		;
		bmi.s	LZ6_Boss_SetDefeat	; if no hits left, set defeated
		tst.b	Coll(a0)		; if colliding, dont flash
		bne.s	LZ6_Boss_NoFlash	; else do
		tst.b	Off3E(a0)		; has timer ran out?
		bne.s	LZ6_Boss_ShipFlash	; if hasnt, start flashing

		move.w	#0,Object_RAM+X_vel.w
		move.w	#LZ6_Boss_BubbleDelay,Inertia(a0)
		move.b	#$20,Off3E(a0)		; set number of	times for ship to flash
		move.w	#$AC,d0			;
		jsr	PlaySound		; play boss damage sound

LZ6_Boss_ShipFlash:
		lea	Palette_UCurr+$22,a1 	; load 2nd line, 2nd entry
		moveq	#0,d0			; move 0 (black) to d0
		tst.w	(a1)			; does the line currently have this entry?
		bne.s	.set			; if not, branch
		move.w	#$EEE,d0		; move 0EEE (white) to d0

.set		move.w	d0,(a1)			; load colour stored in	d0
		subq.b	#1,Off3E(a0)		; decrement timer
		bne.s	LZ6_Boss_NoFlash	; if still not 0, branch
		move.b	#$F,Coll(a0)		; reset collision and stop flashing

LZ6_Boss_NoFlash:
		rts
; ===========================================================================

LZ6_Boss_SetDefeat:				; XREF: LZ6_Boss_BossHover
		moveq	#100,d0		; 100 points
		bsr.w	AddPoints	; add points
		move.b	#4,Routine2(a0); set to defeated subroutine
		move.w	#$B3,Off3C(a0)	; explosion timer
		addq.b	#2,$FFFFF742.w
		move.w	#0,Coll(a0)
		rts
; ===========================================================================
LZ6_Boss_RunFrom:
		tst.b	subtype(a0)
		beq.s	.chk
		bmi.s	.noSpeedUp
		moveq	#$FFFFFFE2,d0
		jsr	PlayMusic_Speed	; Speed	up the music
		move.b	#-1,subtype(a0)
		bra.s	.noSpeedUp

.chk		tst.b	$FFFFF60E.w
		bne.s	.noSpeedUp
		move.b	#1,subtype(a0)

.noSpeedUp	subq.w	#1,Inertia(a0)
		bne.w	.nobubble

		moveq	#-4,d3
		moveq	#2,d2

.bubbles	jsr	SingleObjLoad		; load next object
		bne.w	.nobubble		; if all slots are full, end
		move.b	#$64,(a1)		; load bubble object
		move.w	Boss_X(a0),X_pos(a1)
		move.w	Boss_Y(a0),Y_Pos(a1)
		sub.w	d3,Y_Pos(a1)
		sub.w	d3,Y_Pos(a1)
		addi.w	#$10,X_Pos(a1)
		addq.b	#2,Routine(a1)
		move.l	#Map_obj64,Mappings_Offset(a1)
		move.w	#$8348,Art_Tile(a1)
		move.b	#$84,Render_Flags(a1)
		move.b	#$10,X_Visible(a1)
		move.b	#1,Priority(a1)
		move.w	X_pos(a1),Off30(a1)
		jsr	RandomNumber
		move.b	d0,Angle(a0)

		move.l	d3,d1
		jsr	CalcSine
		muls.w	#-$400,d0
		asr.l	#8,d0
		addi.w	#-$88,d0
		move.w	d0,Y_Vel(a1)	; bounce Sonic away

		move.b	#2,Subtype(a1)
		move.l	#$06050202,Anim_Frame(a1)
		move.b	#$0E,Anim_Dur(a1)

		addq.w	#4,d3
		dbf	d2,.bubbles

.nobubble	move.w	#20,Object_RAM+Off34.w ; time limit for the power-up
		move.w	#-$100,Y_Vel(a0)
		cmpi.w	#LZ6_Boss_Main_Y,Boss_Y(a0)
		bge.s	.skip
		move.w	#0,Y_Vel(a0)

.skip		cmpi.w	#LZ6_Boss_Pos_Right-$10,Boss_X(a0)
		bgt.s	.n2
		cmpi.w	#LZ6_Boss_Pos_Right-$10,$FFFFF728.w
		bgt.s	.n2

		move.w	$FFFFF728.w,d0
		addi.w	#$60,d0
		cmp.w	Boss_X(a0),d0
		bls.s	.n
		move.w	d0,Boss_X(a0)

.n		move.w	$FFFFF728.w,d0
		addi.w	#$1A0,d0
		cmp.w	Boss_X(a0),d0
		bhi.s	.n2
		move.w	d0,Boss_X(a0)

.n2		move.w	#LZ6_Boss_Speed,X_Vel(a0)
		cmpi.w	#$C,($FFFFFE14).w
		bhi.s	.fast
		move.w	#LZ6_Boss_SpeedSlow,X_Vel(a0)

.fast		bsr.w	BossMove
		bra	LZ6_Boss_BossHover

; ===========================================================================
LZ6_Boss_Explode:				; XREF: LZ6_Boss_ShipIndex
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

LZ6_Boss_BeforeEscape:				; XREF: LZ6_Boss_ShipIndex
		addi.w	#$18,Y_Vel(a0)		; apply gravity
		cmpi.w	#LZ6_Water_DownY,Boss_Y(a0)
		bge.s	LZ6_Boss_ShipDel

		bsr.w	BossMove		; move the boss
		bra.w	LZ6_Boss_BossHover	; hover

LZ6_Boss_ShipDel:
		moveq	#$FFFFFFE0,d0
		jsr	PlayMusic		; fade music out
		move.b	#$D,(a0)
		move.w	#0,Routine(a0)
		subi.w	#224-$C0+$10,Y_Pos(a0)
		move.w	Object_RAM+X_Pos,X_Pos(a0)
		rts


LZ6_Boss_FaceMain:
		moveq	#0,d0
		moveq	#0,d1
		movea.l	Off34(a0),a1
		move.b	(a0),d0
		cmp.b	(a1),d0
		bne.w	GHZ3_Boss_FaceDel

		move.b	Routine2(a1),d0
		move.b	.list(pc,d0.w),d1

; ===========================================================================

.notDed		tst.b	Coll(a1)
		bne.s	.notHurt
		moveq	#5,d1
		bra.s	LZ6_Boss_FaceDo
.list		dc.b 1, $A, 6, 5
		even
; ===========================================================================

.notHurt	cmpi.b	#4,Object_RAM+Routine.w
		blo.s	LZ6_Boss_FaceDo
.hurt		moveq	#4,d1

LZ6_Boss_FaceDo:
		move.b	d1,Anim(a0)

LZ6_Boss_FaceDisp:
		bra.w	GHZ3_Boss_Display