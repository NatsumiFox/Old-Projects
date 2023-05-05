; ---------------------------------------------------------------------------
; Object 3A - "SONIC GOT THROUGH" title	card
; ---------------------------------------------------------------------------

GotThroughCard:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Got_Index(pc,d0.w),d1
		jsr	Got_Index(pc,d1.w)
	NEXT_OBJ
; ===========================================================================
Got_Index:	dc.w Got_ChkPLC-Got_Index
		dc.w Got_Move-Got_Index
		dc.w Got_Wait-Got_Index
		dc.w Got_TimeBonus-Got_Index
		dc.w Got_Wait-Got_Index
		dc.w Got_NextLevel-Got_Index
		dc.w Got_Wait-Got_Index
		dc.w Got_Move2-Got_Index
		dc.w loc_C766-Got_Index

got_mainX:	equ $30		; position for card to display on
got_finalX:	equ $32		; position for card to finish on
; ===========================================================================

Got_ChkPLC:	; Routine 0
		tst.b	(KosMmodNum).w ; are the pattern load cues empty?
		beq.s	Got_Main	; if yes, branch
		rts
; ===========================================================================

Got_Main:
		movea.w	a0,a1
		lea	(Got_Config).l,a4
		moveq	#6,d1
		bra.s	Got_Loop2

Got_Loop:
		jsr	FindFreeObj
		move.l	#GotThroughCard,(a1)

Got_Loop2:
		move.w	(a4),obX(a1)	; load start x-position
		move.w	(a4)+,got_finalX(a1) ; load finish x-position (same as start)
		move.w	(a4)+,got_mainX(a1) ; load main x-position
		move.w	(a4)+,obY(a1) ; load y-position
		move.b	(a4)+,obRoutine(a1)
		move.b	(a4)+,d0
		cmpi.b	#6,d0
		bne.s	loc_C5CA
		add.b	(v_act).w,d0	; add act number to frame number

	loc_C5CA:
		move.b	d0,obFrame(a1)
		move.l	#Map_Got,obMap(a1)
		move.w	#$8580,obGfx(a1)
		clr.b	obRender(a1)
		dbf	d1,Got_Loop		; repeat 6 times

Got_Move:	; Routine 2
		moveq	#$10,d1		; set horizontal speed
		move.w	got_mainX(a0),d0
		cmp.w	obX(a0),d0	; has item reached its target position?
		beq.s	loc_C61A	; if yes, branch
		bge.s	Got_ChgPos
		neg.w	d1

Got_ChgPos:
		add.w	d1,obX(a0)	; change item's position

loc_C5FE:
	undisplayck	a0
		move.w	obX(a0),d0
		bmi.s	@nodp
		cmpi.w	#$200,d0	; has item moved beyond	$200 on	x-axis?
		bcc.s	@nodp		; if yes, branch
	displayck	0, a0

@nodp

locret_C60E:
		rts
; ===========================================================================

loc_C610:
		move.b	#$E,obRoutine(a0)
		bra.w	Got_Move2
; ===========================================================================

loc_C61A:
	;	cmpi.b	#$E,($FFFFD724).w
	;	beq.s	loc_C610
		cmpi.b	#4,obFrame(a0)
		bne.s	loc_C5FE
		addq.b	#2,obRoutine(a0)
		move.w	#180,obTimeFrame(a0) ; set time delay to 3 seconds

Got_Wait:	; Routine 4, 8, $C
		subq.w	#1,obTimeFrame(a0) ; subtract 1 from time delay
		bne.s	Got_Display
		addq.b	#2,obRoutine(a0)

Got_Display:
		rts
; ===========================================================================

Got_TimeBonus:	; Routine 6
		move.b	#1,(f_endactbonus).w ; set time/ring bonus update flag
		moveq	#0,d0
		tst.w	(v_timebonus).w	; is time bonus	= zero?
		beq.s	Got_RingBonus	; if yes, branch
		addi.w	#10,d0		; add 10 to score
		subi.w	#10,(v_timebonus).w ; subtract 10 from time bonus

Got_RingBonus:
		tst.w	(v_ringbonus).w	; is ring bonus	= zero?
		beq.s	Got_ChkBonus	; if yes, branch
		addi.w	#10,d0		; add 10 to score
		subi.w	#10,(v_ringbonus).w ; subtract 10 from ring bonus

Got_ChkBonus:
		tst.w	d0		; is there any bonus?
		bne.s	Got_AddBonus	; if yes, branch
		sfx	sfx_Register,0,0,0	; play "ker-ching" sound
		addq.b	#2,obRoutine(a0)
		move.w	#180,obTimeFrame(a0) ; set time delay to 3 seconds

locret_C692:
		rts
; ===========================================================================

Got_AddBonus:
		jsr	(AddPoints).l
		move.b	(v_vbla_byte).w,d0
		andi.b	#3,d0
		bne.s	locret_C692
		sfx	sfx_Switch,1,0,0	; play "blip" sound
; ===========================================================================

Got_NextLevel:	; Routine $A
		move.w	v_zone.w,d1
		move.b	LevelOrder(pc,d1.w),(v_act).w	; set level number

		clr.b	(v_lastlamp).w	; clear	lamppost counter
		st	(f_restart).w	; restart level

Got_Display2:
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Level	order array
; ---------------------------------------------------------------------------
LevelOrder:	dc.b 1, 2, 0, 0
; ===========================================================================

Got_Move2:	; Routine $E
		moveq	#$20,d1		; set horizontal speed
		move.w	got_finalX(a0),d0
		cmp.w	obX(a0),d0	; has item reached its finish position?
		beq.w	DeleteObject	; if yes, branch
		bge.s	Got_ChgPos2
		neg.w	d1

Got_ChgPos2:
		add.w	d1,obX(a0)	; change item's position
	undisplayck	a0
		move.w	obX(a0),d0
		bmi.s	@nodp
		cmpi.w	#$200,d0	; has item moved beyond	$200 on	x-axis?
		bcc.s	@nodp		; if yes, branch
	displayck	0, a0

@nodp

loc_C766:
Got_SBZ2:
locret_C748:
		rts
; ===========================================================================
		;    x-start,	x-main,	y-main,
		;				routine, frame number

Got_Config:	dc.w 4,		$124,	$BC			; "SONIC HAS"
		dc.b 				2,	0

		dc.w -$120,	$120,	$D0			; "PASSED"
		dc.b 				2,	1

		dc.w $40C,	$14C,	$D6			; "ACT" 1/2/3
		dc.b 				2,	6

		dc.w $520,	$120,	$EC			; score
		dc.b 				2,	2

		dc.w $540,	$120,	$FC			; time bonus
		dc.b 				2,	3

		dc.w $560,	$120,	$10C			; ring bonus
		dc.b 				2,	4

		dc.w $20C,	$14C,	$CC			; oval
		dc.b 				2,	5
