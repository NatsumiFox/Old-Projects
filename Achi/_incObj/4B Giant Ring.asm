; ---------------------------------------------------------------------------
; Object 4B - giant ring for entry to special stage
; ---------------------------------------------------------------------------

GiantRing:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	GRing_Index(pc,d0.w),d1
		jsr	GRing_Index(pc,d1.w)
	NEXT_OBJ
; ===========================================================================
GRing_Index:	dc.w GRing_Main-GRing_Index
		dc.w GRing_Animate-GRing_Index
		dc.w GRing_Collect-GRing_Index
		dc.w GRing_Animate2-GRing_Index
		dc.w DeleteObject-GRing_Index
; ===========================================================================

GRing_Main:	; Routine 0
		move.l	#Map_GRing,obMap(a0)
		move.w	#$2400,obGfx(a0)
		ori.b	#4,obRender(a0)
		move.b	#$40,obActWid(a0)
	displayck	2, a0
		tst.b	obRender(a0)
		bpl.s	GRing_Animate
		cmpi.w	#50,(v_rings).w	; do you have at least 50 rings?
		blo.w	DeleteObject	; if not, branch
; ===========================================================================

GRing_Okay:
		addq.b	#2,obRoutine(a0)
		move.b	#$52,obColType(a0)
		move.w	#$C40,(v_gfxbigring).w	; Signal that Art_BigRing should be loaded ($C40 is the size of Art_BigRing)

GRing_Animate:	; Routine 2
		jsr	AddToCollList

GRing_Animate2:
		move.b	(v_ani1_frame).w,obFrame(a0)
		out_of_range	DeleteObject
		rts
; ===========================================================================

GRing_Collect:	; Routine 4
		addq.b	#2,obRoutine(a0)
		clr.b	obColType(a0)
		bsr.w	FindFreeObj
	;	bpl.w	GRing_PlaySnd
		move.l	#RingFlash,(a1) ; load giant ring flash object
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.l	a0,$3C(a1)
		move.w	(v_player+obX).w,d0
		cmp.w	obX(a0),d0	; has Sonic come from the left?
		bcs.s	GRing_PlaySnd	; if yes, branch
		bset	#0,obRender(a1)	; reverse flash	object

GRing_PlaySnd:
		sfx	sfx_BigRing,0,0,0	; play giant ring sound
		bra.s	GRing_Animate2
