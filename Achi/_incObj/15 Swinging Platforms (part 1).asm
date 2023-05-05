; ---------------------------------------------------------------------------
; Object 15 - swinging platforms (GHZ, MZ, SLZ)
;	    - spiked ball on a chain (SBZ)
; ---------------------------------------------------------------------------

SwingingPlatform:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Swing_Index(pc,d0.w),d1
		jsr	Swing_Index(pc,d1.w)
	NEXT_OBJ
; ===========================================================================
Swing_Index:	dc.w Swing_Main-Swing_Index, Swing_SetSolid-Swing_Index
		dc.w Swing_Action2-Swing_Index,	DeleteObject-Swing_Index
		dc.w DeleteObject-Swing_Index, locret_75F2-Swing_Index
		dc.w Swing_Action-Swing_Index

swing_origX:	equ $3A		; original x-axis position
swing_origY:	equ $38		; original y-axis position
; ===========================================================================

Swing_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Swing_GHZ,obMap(a0) ; GHZ and MZ specific code
		move.w	#$4380,obGfx(a0)
		move.b	#4,obRender(a0)
	display		3, a0

		move.b	#$18,obActWid(a0)
		move.b	#8,obHeight(a0)
		move.w	obY(a0),swing_origY(a0)
		move.w	obX(a0),swing_origX(a0)

@length:
		move.l	(a0),d4
		moveq	#0,d1
		lea	obSubtype(a0),a3 ; move chain length to a2
		move.b	(a3),d1		; move a2 to d1
		move.w	d1,-(sp)
		andi.w	#$F,d1
		move.b	#0,(a3)+
		move.w	d1,d3
		lsl.w	#4,d3
		addq.b	#8,d3
		move.b	d3,$3C(a0)
		subq.b	#8,d3
		tst.b	obFrame(a0)
		beq.s	@makechain
		addq.b	#8,d3
		subq.w	#1,d1

@makechain:
		bsr.w	FindFreeObj
	;	bpl.s	@fail
		addq.b	#1,obSubtype(a0)

		moveq	#0,d5
		move.w	a1,d5
		subi.w	#v_objspace,d5
		divu	#size,d5
		move.b	d5,(a3)+
		move.b	#$A,obRoutine(a1) ; goto Swing_Display next
		move.l	d4,(a1)	; load swinging	object

		move.l	obMap(a0),obMap(a1)
		move.w	obGfx(a0),obGfx(a1)
		bclr	#6,obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#8,obActWid(a1)
		move.b	#1,obFrame(a1)

		move.b	d3,$3C(a1)
		subi.b	#$10,d3
		bcc.s	@notanchor

	display		3, a1
		move.b	#2,obFrame(a1)
		bset	#6,obGfx(a1)
		dbf	d1,@makechain ; repeat d1 times (chain length)
		bra.s	@fail

@notanchor:
	display		4, a1
		dbf	d1,@makechain ; repeat d1 times (chain length)

@fail:
		moveq	#0,d5
		move.w	a0,d5
		subi.w	#v_objspace,d5
		divu	#size,d5
		move.b	d5,(a3)+
		move.w	#$4080,obAngle(a0)
		move.w	#-$200,$3E(a0)
		move.w	(sp)+,d1
		btst	#4,d1		; is object type $1X ?
		beq.s	@not1X	; if not, branch

		move.l	#Map_GBall,obMap(a0) ; use GHZ ball mappings
		move.w	#$43AA,obGfx(a0)
		move.b	#1,obFrame(a0)
	chdisplay	2, a0
		move.b	#$81,obColType(a0) ; make object hurt when touched

	@not1X:

Swing_SetSolid:	; Routine 2
		moveq	#0,d1
		move.b	obActWid(a0),d1
		moveq	#0,d3
		move.b	obHeight(a0),d3
		bsr.w	Swing_Solid

Swing_Action:	; Routine $C
		bsr.w	Swing_Move
		bra.w	Swing_ChkDel
; ===========================================================================

Swing_Action2:	; Routine 4
		moveq	#0,d1
		move.b	obActWid(a0),d1
		bsr.w	ExitPlatform
		move.w	obX(a0),-(sp)
		bsr.w	Swing_Move
		move.w	(sp)+,d2
		moveq	#0,d3
		move.b	obHeight(a0),d3
		addq.b	#1,d3
		bsr.w	MvSonicOnPtfm
		bra.w	Swing_ChkDel
