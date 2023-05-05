; ---------------------------------------------------------------------------
; Object 1A - GHZ collapsing ledge
; ---------------------------------------------------------------------------

CollapseLedge:
ledge_timedelay:	equ $38		; time between touching the ledge and it collapsing
ledge_collapse_flag:	equ $3A		; collapse flag
; ===========================================================================

Ledge_Main:	; Routine 0
		move.l	#Ledge_Touch,(a0)
		move.l	#Map_Ledge,obMap(a0)
		move.w	#$4000,obGfx(a0)
		ori.b	#4,obRender(a0)

	display		4, a0
		move.b	#7,ledge_timedelay(a0) ; set time delay for collapse
		move.b	#$64,obActWid(a0)

		move.b	obSubtype(a0),obFrame(a0)
		move.b	#$38,obHeight(a0)
		bset	#4,obRender(a0)

Ledge_Touch:	; Routine 2
		tst.b	obRoutine(a0)		; check routine
		bne.s	Ledge_Collapse
		tst.b	ledge_collapse_flag(a0)	; is ledge collapsing?
		beq.s	@slope		; if not, branch
		tst.b	ledge_timedelay(a0)	; has time reached zero?
		beq.w	Ledge_Fragment	; if yes, branch
		subq.b	#1,ledge_timedelay(a0) ; subtract 1 from time

	@slope:
		move.w	#$30,d1
		lea	(Ledge_SlopeData).l,a2
		bsr.w	SlopeObject
		bsr.w	RememberState
	NEXT_OBJ
; ===========================================================================

Ledge_Collapse:	; Routine 4
		move.l	#@rout,(a0)

@rout		tst.b	ledge_timedelay(a0)
		beq.w	loc_847A
		move.b	#1,ledge_collapse_flag(a0)	; set collapse flag
		subq.b	#1,ledge_timedelay(a0)

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Ledge_WalkOff:	; Routine $A
		move.w	#$30,d1
		bsr.w	ExitPlatform
		move.w	#$30,d1
		lea	(Ledge_SlopeData).l,a2
		move.w	obX(a0),d2
		bsr.w	SlopeObject2
		bsr.w	RememberState
	NEXT_OBJ
; ===========================================================================

Ledge_Display:	; Routine 6
		tst.b	ledge_timedelay(a0)	; has time delay reached zero?
		beq.s	Ledge_TimeZero	; if yes, branch
		tst.b	ledge_collapse_flag(a0)	; is ledge collapsing?
		bne.s	loc_82D0	; if yes, branch
		subq.b	#1,ledge_timedelay(a0) ; subtract 1 from time
	NEXT_OBJ
; ===========================================================================

loc_82D0:
		subq.b	#1,ledge_timedelay(a0)
		lea	(v_player).w,a1
		btst	#3,obStatus(a1)
		beq.s	loc_82FC
		tst.b	ledge_timedelay(a0)
		bne.s	locret_8308

		bclr	#3,obStatus(a1)
		bclr	#5,obStatus(a1)
		move.b	#1,obNextAni(a1)

loc_82FC:
		move.b	#0,ledge_collapse_flag(a0)
		move.l	#Ledge_Display,(a0)

locret_8308:
		bra.w	Ledge_WalkOff
; ===========================================================================

Ledge_TimeZero:
		move.l	#@rout,(a0)

@rout		bsr.w	ObjectFall
		tst.b	obRender(a0)
		bpl.w	DeleteObject2
	NEXT_OBJ
