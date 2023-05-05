SYZ2_Boss_ID:		equ $10
SYZ2_Boss_Pos_Left:	equ $2900
SYZ2_Boss_Pos_Right:	equ SYZ2_Boss_Pos_Left+320
SYZ2_Boss_Pos_Up:	equ $538
SYZ2_Boss_Pos_Down:	equ $5E0

SYZ2_Boss_SP_X:		equ SYZ2_Boss_Pos_Left+((SYZ2_Boss_Pos_Right-SYZ2_Boss_Pos_Left)/2)
SYZ2_Boss_SP_Y:		equ SYZ2_Boss_Pos_Up-$60
SYZ2_Boss_Finish_X:	equ SYZ2_Boss_Pos_Left+$200
SYZ2_Boss_WaitTimer:	equ 5*60
SYZ2_Boss_StayPut:	equ 1*60
SYZ2_Boss_InitTimer:	equ 2*60

SYZ2_Boss_GroundPos:	equ SYZ2_Boss_Pos_Down
SYZ2_Boss_BlockData1:	equ 0
SYZ2_Boss_BlockData2:	equ 0
SYZ2_Boss_BlockData3:	equ 0
SYZ2_Boss_BlockData4:	equ 0
; ---------------------------------------------------------------------------
; Object - Boss (SYZ2)
; ---------------------------------------------------------------------------
SYZ2_Boss:					; XREF: Obj_Index
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	SYZ2_Boss_Index(pc,d0.w),d1
		jmp	SYZ2_Boss_Index(pc,d1.w)
; ===========================================================================
SYZ2_Boss_Index:
		dc.w SYZ2_Boss_Main-SYZ2_Boss_Index
		dc.w SYZ2_Boss_ShipMain-SYZ2_Boss_Index
		dc.w SYZ2_Boss_FaceMain-SYZ2_Boss_Index
		dc.w GHZ2_Boss_FlameMain-SYZ2_Boss_Index
		dc.w SYZ2_Boss_Blocks-SYZ2_Boss_Index
		dc.w SYZ2_Boss_Blocks-SYZ2_Boss_Index
		dc.w SYZ2_Boss_Frag-SYZ2_Boss_Index
		dc.w SYZ2_Boss_BlockSink-SYZ2_Boss_Index

			; routine counter, animation
SYZ2_Boss_ObjData:	dc.b 2,	0	; the main ship
			dc.b 4,	1	; Eggman face
			dc.b 6,	7	; flame from the ship
; ===========================================================================

SYZ2_Boss_Main:				; XREF: SYZ2_Boss_Index
		lea	SYZ2_Boss_ObjData,a2	; get data array
		movea.l	a0,a1			; copy this object to a1
		moveq	#2,d1			; get length
		bra.s	SYZ2_Boss_LoadBoss	; start with current object
; ===========================================================================

SYZ2_Boss_Loop:
		jsr	SingleObjLoad2		; load next object
		bne.s	SYZ2_Boss_SkipLoad	; if all slots are full, end

SYZ2_Boss_LoadBoss:				; XREF: SYZ2_Boss_Main
		move.b	(a2)+,Routine(a1)	; get routine counter
		move.b	#SYZ2_Boss_ID,(a1)	; use current object
		move.w	X_pos(a0),X_pos(a1)	;
		move.w	Y_Pos(a0),Y_Pos(a1)	; copy positions
		move.l	#Map_Eggman,Mappings_Offset(a1); get mappings
		move.w	#$400,Art_Tile(a1)	;
		move.b	#4,Render_Flags(a1)	;
		move.b	#$20,X_Visible(a1)	;
		move.b	#3,Priority(a1)		;
		move.b	(a2)+,Anim(a1)		; get animation
		move.l	a0,Off34(a1)		; save boss address
		dbf	d1,SYZ2_Boss_Loop	; repeat sequence 2 more times

SYZ2_Boss_SkipLoad:
		move.w	X_pos(a0),Boss_X(a0)	;
		move.w	Y_Pos(a0),Boss_Y(a0)	; copy positions to other memory
		move.b	#$F,Coll(a0)		; set to boss
		move.b	#8,Coll2(a0)		; set number of	hits to	8

SYZ2_Boss_ShipMain:				; XREF: SYZ2_Boss_Index
		moveq	#0,d0
		move.b	Routine2(a0),d0			; get secondary routine counter
		move.w	SYZ2_Boss_ShipIndex(pc,d0.w),d1
		jsr	SYZ2_Boss_ShipIndex(pc,d1.w)	; jump to the correct routine

		lea	Ani_Eggman,a1
		jsr	AnimateSprite			; animate object
		move.b	Status(a0),d0
		andi.b	#3,d0				; only maintain X and Y flip bits
		andi.b	#$FC,Render_Flags(a0)		; clear X and Y flip bits
		or.b	d0,Render_Flags(a0)		; if X and Y flip bits were set, copy to Render flags
		jmp	DisplaySprite			; display sprite
; ===========================================================================
SYZ2_Boss_ShipIndex:
		dc.w SYZ2_Boss_ShipStart-SYZ2_Boss_ShipIndex
		dc.w SYZ2_Boss_WaitThrow-SYZ2_Boss_ShipIndex

		dc.w SYZ2_Boss_Explode-SYZ2_Boss_ShipIndex
		dc.w SYZ2_Boss_BeforeEscape-SYZ2_Boss_ShipIndex
		dc.w SYZ2_Boss_Escape-SYZ2_Boss_ShipIndex
; ===========================================================================

SYZ2_Boss_ShipStart:
		cmpi.w	#SYZ2_Boss_Pos_Up,Boss_Y(a0)
		blt.s	.no
		addq.b	#2,Routine2(a0)
		move.w	#SYZ2_Boss_InitTimer,Off3C(a0)
		move.w	#0,Y_Vel(a0)
		bra.s	SYZ2_Boss_BossHover

.no		move.w	#$100,Y_Vel(a0)		; move ship down
		bsr.w	BossMove		; run movement routines

SYZ2_Boss_BossHover:
		move.b	Off3F(a0),d1		; get offset
		jsr	CalcSine		; get sine
		asr.w	#6,d0			; shift right 6 bits
		add.w	Boss_Y(a0),d0		; add Boss Y-position
		move.w	d0,Y_Pos(a0)		; set to actual Y-position
		move.w	Boss_X(a0),X_pos(a0)	; copy Y-position to actual Y-position
		addq.b	#2,Off3F(a0)		; increment offset
		cmpi.b	#6,Routine2(a0)		; is secondary routine counter 8?
		bhs.s	SYZ2_Boss_NoFlash	; if higher or same, skip flashing

		tst.b	Status(a0)		;
		bmi.s	SYZ2_Boss_SetDefeat	; if no hits left, set defeated
		tst.b	Coll(a0)		; if colliding, dont flash
		bne.s	SYZ2_Boss_NoFlash	; else do
		tst.b	Off3E(a0)		; has timer ran out?
		bne.s	SYZ2_Boss_ShipFlash	; if hasnt, start flashing

		move.b	#$20,Off3E(a0)		; set number of	times for ship to flash
		move.w	#$AC,d0			;
		jsr	PlaySound		; play boss damage sound

SYZ2_Boss_ShipFlash:
		lea	$FFFFFB22,a1 		; load 2nd line, 2nd entry
		moveq	#0,d0			; move 0 (black) to d0
		tst.w	(a1)			; does the line currently have this entry?
		bne.s	.set			; if not, branch
		move.w	#$EEE,d0		; move 0EEE (white) to d0

.set		move.w	d0,(a1)			; load colour stored in	d0
		subq.b	#1,Off3E(a0)		; decrement timer
		bne.s	SYZ2_Boss_NoFlash	; if still not 0, branch
		move.b	#$F,Coll(a0)		; reset collision and stop flashing

SYZ2_Boss_NoFlash:
		rts
; ===========================================================================

SYZ2_Boss_SetDefeat:				; XREF: SYZ2_Boss_BossHover
		moveq	#100,d0		; 100 points
		bsr.w	AddPoints	; add points
		move.b	#4,Routine2(a0); set to defeated subroutine
		move.w	#$B3,Off3C(a0)	; explosion timer
		rts

; ===========================================================================

SYZ2_Boss_WaitThrow:				; XREF: SYZ2_Boss_ShipIndex
		subq.w	#1,Off3C(a0)
		bmi.s	SYZ2_Boss_Throw

		move.w	#0,X_Vel(a0)
		bset	#0,Status(a0)
		move.w	#$100,d0

		move.w	Object_RAM+X_Pos.w,d1
		sub.w	Boss_X(a0),d1
		bpl.s	.pos

		neg.w	d0
		neg.w	d1
		bclr	#0,Status(a0)

.pos		cmpi.w	#$40,d1
		ble.s	SYZ2_Boss_Throw_common
		move.w	d0,X_vel(a0)

SYZ2_Boss_Throw_common:
		bsr.w	SYZ2_Boss_BossHover
		bra.w	BossMove

SYZ2_Boss_Throw:
		move.w	#0,X_Vel(a0)
		cmpi.w	#SYZ2_Boss_StayPut,Off3C(a0)
		bge.s	SYZ2_Boss_Throw_common

		move.w	#SYZ2_Boss_WaitTimer,Off3C(a0)
		jsr	SingleObjLoad2		; load next object
		bne.s	SYZ2_Boss_Throw_common	; if all slots are full, end

		move.b	#SYZ2_Boss_ID,(a1)	; set ID
		move.w	X_pos(a0),X_pos(a1)	;
		move.w	Y_Pos(a0),Y_Pos(a1)	; copy positions
		move.b	#$A,Routine(a1)

		lea	Object_RAM,a2
		move.w	X_pos(a0),d1
		move.w	Y_Pos(a0),d2
		sub.w	X_pos(a2),d1
		sub.w	Y_Pos(a2),d2
		jsr	(CalcAngle).l
		jsr	(CalcSine).l
		muls.w	#-$580,d1
		asr.l	#8,d1
		move.w	d1,X_Vel(a1)	; bounce Sonic away
		muls.w	#-$200,d0
		asr.l	#8,d0
		move.w	d0,Y_Vel(a1)	; bounce Sonic away

		bsr.w	SYZ2_Boss_BossHover
		bra.w	BossMove

; ===========================================================================
SYZ2_Boss_Explode:				; XREF: SYZ2_Boss_ShipIndex
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

SYZ2_Boss_BeforeEscape:				; XREF: SYZ2_Boss_ShipIndex
		addq.w	#1,Off3C(a0)		; increment timer
		beq.s	SYZ2_Boss_BE_StartGoUp	; if 0, start climbing upwards
		bpl.s	SYZ2_Boss_BE_GoUp	; if greater than 0, go upwards
		addi.w	#$18,Y_Vel(a0)		; apply gravity
		bra.s	SYZ2_Boss_BE_Move	; do main movement routines
; ===========================================================================

SYZ2_Boss_BE_StartGoUp:
		clr.w	Y_Vel(a0)		; clear Y-velocity
		bra.s	SYZ2_Boss_BE_Move	; do main movement routines
; ===========================================================================

SYZ2_Boss_BE_GoUp:
		cmpi.w	#$30,Off3C(a0)		; is timer $30?
		blo.s	.moveUp			; if less, move up
		beq.s	SYZ2_Boss_BE_PlayMusic	; is same, clear Y-velocity and play zone music
		cmpi.w	#$38,Off3C(a0)		; is timer $38?
		blo.s	SYZ2_Boss_BE_Move	; if less, branch
		addq.b	#2,Routine2(a0)		; increment routine
		bra.s	SYZ2_Boss_BE_Move	; do main movement routines
; ===========================================================================

.moveUp		subq.w	#8,Y_Vel(a0)		; move upwards

SYZ2_Boss_BE_Move:
		bsr.w	BossMove		; move the boss
		bra.w	SYZ2_Boss_BossHover	; hover
; ===========================================================================

SYZ2_Boss_BE_PlayMusic:
		pea	SYZ2_Boss_BE_Move(pc)	; go to movement routine after
		clr.w	Y_Vel(a0)		; clear Y-velocity
		moveq	#$FFFFFFE0,d0
		jmp	PlayMusic		; fade music out

; ===========================================================================

SYZ2_Boss_Escape:				; XREF: SYZ2_Boss_ShipIndex
		move.w	#$400,X_Vel(a0)		; set escape speed
		move.w	#-$40,Y_Vel(a0)		; go upwards

		cmpi.w	#SYZ2_Boss_Finish_X,$FFFFF72A.w	; if finished scrolling..
		bge.s	.finish			; ...branch
		addq.w	#2,$FFFFF72A.w		; move level minimum horizontal position
		bra.s	SYZ2_Boss_BE_Move	; do main movement routines
; ===========================================================================

.finish		tst.b	Render_Flags(a0)	; is on-screen?
		bpl.s	SYZ2_Boss_ShipDel	; if isnt, branch
		bra	SYZ2_Boss_BE_Move	; do main movment routines
; ===========================================================================

SYZ2_Boss_ShipDel:
		jmp	DeleteObject		; delete boss


SYZ2_Boss_Blocks:
		moveq	#0,d0
		move.b	SubType(a0),d0
		move.w	.I(pc,d0.w),d1
		jmp	.I(pc,d1.w)
; ===========================================================================
.I		dc.w SYZ2_Boss_Blocks_Init-.I
		dc.w .Fall-.I
		dc.w SYZ2_Boss_Blocks_Display-.I
		dc.w SYZ2_Boss_Blocks_Wait-.I

.Fall		jsr	ObjectFall

		jsr	ObjHitFloor
		tst.w	d1
		bpl.w	SYZ2_Boss_Blocks_Display2
		addq.b	#2,SubType(a0)

		move.w	#SYZ2_Boss_GroundPos-$10,Y_Pos(a0)
		move.l	#0,X_Vel(a0)
		move.b	#0,Coll(a0)
		move.w	#$12,ShakeOffset_Mode.w

		moveq	#$FFFFFFBD,d0
		jsr	PlaySound
		bra.s	SYZ2_Boss_Blocks_Display2

SYZ2_Boss_Blocks_Display:
		move.w	#$1B,d1
		move.w	#$10,d2
		move.w	#$11,d3
		move.w	X_pos(a0),d4
		jsr	SolidObject

		subq.w	#1,Off32(a0)
		bpl.s	SYZ2_Boss_Blocks_Display2
		move.b	#1,Anim_Frame(a0)
		bset	#1,Object_RAM+Status.w
		bclr	#3,Object_RAM+Status.w

		addq.b	#2,SubType(a0)
		move.w	#0,X_Pos2(a0)		; make sure this fragment is in synch
		move.w	#0,Y_Pos2(a0)		; ^
		move.w	#-1,ShakeOffset_Mode.w

		jsr	SingleObjLoad		; load object
		bne	SYZ2_Boss_Blocks_Display2; if none could be loaded, branch
		move.b	#$3F,(a1)		; load "explosion from a destroyed enemy"
		move.w	X_Pos(a0),X_Pos(a1)	; set position
		move.w	Y_Pos(a0),Y_Pos(a1)	; ^

		move.w	X_Pos(a0),d3
		bsr	SYZ2_Boss_ToLava

SYZ2_Boss_Blocks_Display2:
		cmpi.w	#SYZ2_Boss_GroundPos+$50,Y_Pos(a0)
		bge.s	.del
		jmp	DisplaySprite

.del		jmp	DeleteObject

SYZ2_Boss_Blocks_Wait:
		addq.w	#1,Off32(a0)
		bmi.s	SYZ2_Boss_Blocks_Display2

		lea	SYZ2_Boss_Blocks_Speeds,a4 ; load broken fragment speed data
		moveq	#7,d1		; set number of	fragments to 8
		move.w	#$38,d2
		move.b	#$C,d0
		jsr	SmashObject

SYZ2_Boss_Frag:
		jsr	ObjectMove
		addi.w	#$38,Y_Vel(a0)
		tst.b	Render_Flags(a0)
		bmi.s	SYZ2_Boss_Blocks_Display2
		jmp	DeleteObject

SYZ2_Boss_Blocks_Speeds:
		dc.w -$200, -$280	; x-speed, y-speed
		dc.w -$200, -$200
		dc.w -$100, -$180
		dc.w -$100, -$100
		dc.w $200, -$280
		dc.w $200, -$200
		dc.w $100, -$180
		dc.w $100, -$100

SYZ2_Boss_FaceMain:
		moveq	#0,d0
		moveq	#1,d1
		movea.l	Off34(a0),a1
		move.b	(a0),d0
		cmp.b	(a1),d0
		bne.w	GHZ3_Boss_FaceDel
		cmpi.w	#-1,ShakeOffset_Mode.w
		beq.s	.hurt

		move.b	Routine2(a1),d0
		sub.b	#2,d0
		bmi.s	.hurt
		sub.b	#8-4,d0
		bmi.s	.notDed
		moveq	#$A,d1
		bra.s	SYZ2_Boss_FaceDo
; ===========================================================================

.notDed		tst.b	Coll(a1)
		bne.s	.notHurt
		moveq	#5,d1
		bra.s	SYZ2_Boss_FaceDo
; ===========================================================================

.notHurt	cmpi.b	#4,Object_RAM+Routine.w
		blo.s	SYZ2_Boss_FaceDo
.hurt		moveq	#4,d1

SYZ2_Boss_FaceDo:
		move.b	d1,Anim(a0)
		subq.b	#2,d0
		bne.w	GHZ2_Boss_FaceDisp
		move.b	#6,Anim(a0)

SYZ2_Boss_FaceDisp:
		bra.w	GHZ3_Boss_Display

SYZ2_Boss_Blocks_Init:				; XREF: Obj46_Index
		addq.b	#2,SubType(a0)
		move.b	#$F,Y_Radius(a0)
		move.b	#$F,X_Radius(a0)
		move.l	#SYZ2_Boss_Blocks_Mappings,Mappings_Offset(a0)
		move.w	#$4001,Art_Tile(a0)
		move.b	#4,Render_Flags(a0)
		move.b	#7,Priority(a0)
		move.b	#$10,X_Visible(a0)
		move.w	Y_Pos(a0),Off30(a0)
		move.w	#60+60+30,Off32(a0)
		move.b	#$25|$80,Coll(a0)
		rts
; ===========================================================================
; Subroutine to transform blocks under position to lava and generate
; a falling block to give smooth transformation
; in: d3 = x-position of block
; ===========================================================================
SYZ2_Boss_ToLava:
		move.w	#SYZ2_Boss_GroundPos,d2	; Y-position of block

		btst	#3,d3			; check if bit 4 is set (to shift to next block instead if over half-way of it
		bne.s	.noAdd			; if not set, branch
		subi.w	#16,d3			; shift to next block

.noAdd		andi.w	#$FFF0,d3		; fix to per-block position

		move.l	#SYZ2_Boss_BlockData1,d0	; store block-replacement data
		move.l	#SYZ2_Boss_BlockData3,d1	; temporarely on registers d1 and d0
		btst	#4,d3
		bne.s	.notOdd

		move.l	#SYZ2_Boss_BlockData2,d0	; if we are on an odd block
		move.l	#SYZ2_Boss_BlockData4,d1	; then store this information, to keep lava in synch


.notOdd		move.w	d0,-(sp)
		move.w	d1,-(sp)		; store first blocks to stack
		move.w	d3,-(sp)		; store x-pos
		move.w	d2,-(sp)		; store y-pos

		swap	d0
		swap	d1			; swap seconds blocks to front
		move.w	d0,-(sp)
		move.w	d1,-(sp)		; store second blocks to stack
		jsr	Floor_ChkTile		; get the address of the block on set x and y-positions

		move.w	(sp)+,(a1)		; then get first block data from stack
		lea	8*2(a1),a1		; get next row
		move.w	(sp)+,(a1)		; get second block data from stack

		move.w	(sp)+,d2
		move.w	(sp)+,d3		; get x and y-poses from stack
		addi.w	#16,d3			; get next block pos
		jsr	Floor_ChkTile		; get the address of the block on set x and y-positions

		move.w	(sp)+,(a1)		; then get first block data from stack
		lea	8*2(a1),a1		; get next row
		move.w	(sp)+,(a1)		; get second block data from stack

		move.l	a0,-(sp)		; store original object to a0
		jsr	SingleObjLoad		; try to load new object
		bne.s	.no			; if failed, skip

		move.b	#SYZ2_Boss_ID,(a1)	; set ID
		move.w	d3,X_pos(a1)		;
		addi.w	#16,d2			; make block spawn inside where it was removed from
		move.w	d2,Y_Pos(a1)		; copy positions
		move.b	#$E,Routine(a1)		; sinking block

		move.l	a1,a0			; copy object from a1 to a0
		bsr	SYZ2_Boss_Blocks_Init	; init object

		bset	#7,Art_Tile(a0)		; set in front of the terrain
		move.b	#0,Coll(a0)		; clear collision
		jsr	DisplaySprite2		; display the sprite

.no		move.b	#1,Dirty_flag.w		; reload the screen
		move.l	(sp)+,a0		; get correct object from stack
		rts

SYZ2_Boss_BlockSink:
		move.w	#SYZ2_Boss_Pos_Down,d0
		sub.w	$FFFFF704.w,d0
		bpl.s	.skip
		move.w	#SYZ2_Boss_Pos_Down-2,$FFFFF704.w

.skip		cmpi.w	#SYZ2_Boss_GroundPos+$50,Y_Pos(a0)
		bge.s	.del

		jsr	ObjectMove
		addq.w	#4,Y_Vel(a0)
		move.w	#$1B,d1
		move.w	#$10,d2
		move.w	#$11,d3
		move.w	X_pos(a0),d4

		jsr	SolidObject
		jmp	DisplaySprite

.del		move.w	#0,ShakeOffset_Mode.w	; stop screen shake
		jmp	DeleteObject

SYZ2_Boss_Blocks_Mappings:
		include "_maps/Syz2Boss_Blocks.asm"

SYZ2_Boss_Blocks_Art:
		incbin "artnem/SYZ2_Boss_Blocks.bin"
		even
