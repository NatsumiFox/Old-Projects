; ---------------------------------------------------------------------------
; Object 0D - signpost at the end of a level
; ---------------------------------------------------------------------------

Signpost:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Sign_Index(pc,d0.w),d1
		jsr	Sign_Index(pc,d1.w)
		lea	(Ani_Sign).l,a1
		bsr.w	AnimateSprite
		out_of_range	DeleteObject2
	NEXT_OBJ
; ===========================================================================
Sign_Index:	dc.w Sign_Main-Sign_Index
		dc.w Sign_Touch-Sign_Index
		dc.w Sign_Spin-Sign_Index
		dc.w Sign_SonicRun-Sign_Index
		dc.w Sign_Exit-Sign_Index

spintime:	equ $30		; time for signpost to spin
sparkletime:	equ $32		; time between sparkles
sparkle_id:	equ $34		; counter to keep track of sparkles
; ===========================================================================

Sign_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Sign,obMap(a0)
		move.w	#$680,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#$18,obActWid(a0)
	display		4, a0

Sign_Touch:	; Routine 2
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		bcs.s	@notouch
		cmpi.w	#$20,d0		; is Sonic within $20 pixels of	the signpost?
		bcc.s	@notouch	; if not, branch
		music	sfx_Signpost,0,0,0	; play signpost sound
		clr.b	(f_timecount).w	; stop time counter
		move.w	(v_limitright2).w,(v_limitleft2).w ; lock screen position
		addq.b	#2,obRoutine(a0)

	@notouch:
		rts
; ===========================================================================

Sign_Spin:	; Routine 4
		subq.w	#1,spintime(a0)	; subtract 1 from spin time
		bpl.s	@chksparkle	; if time remains, branch
		move.w	#60,spintime(a0) ; set spin cycle time to 1 second
		addq.b	#1,obAnim(a0)	; next spin cycle
		cmpi.b	#3,obAnim(a0)	; have 3 spin cycles completed?
		bne.s	@chksparkle	; if not, branch
		addq.b	#2,obRoutine(a0)

	@chksparkle:
		subq.w	#1,sparkletime(a0) ; subtract 1 from time delay
		bpl.s	@fail		; if time remains, branch
		move.w	#$B,sparkletime(a0) ; set time between sparkles to $B frames
		moveq	#0,d0
		move.b	sparkle_id(a0),d0 ; get sparkle id
		addq.b	#2,sparkle_id(a0) ; increment sparkle counter
		andi.b	#$E,sparkle_id(a0)
		lea	Sign_SparkPos(pc,d0.w),a2 ; load sparkle position data
		bsr.w	FindFreeObj
	;	bpl.s	@fail
		move.l	#Ring_Sparkle,(a1)	; load rings object
		move.b	(a2)+,d0
		ext.w	d0
		add.w	obX(a0),d0
		move.w	d0,obX(a1)
		move.b	(a2)+,d0
		ext.w	d0
		add.w	obY(a0),d0
		move.w	d0,obY(a1)
		move.l	#Map_Ring,obMap(a1)
		move.w	#$27B2,obGfx(a1)
		move.b	#4,obRender(a1)
	display		2, a1
		move.b	#8,obActWid(a1)

	@fail:
		rts
; ===========================================================================
Sign_SparkPos:	dc.b -$18,-$10		; x-position, y-position
		dc.b	8,   8
		dc.b -$10,   0
		dc.b  $18,  -8
		dc.b	0,  -8
		dc.b  $10,   0
		dc.b -$18,   8
		dc.b  $18, $10
; ===========================================================================

Sign_SonicRun:	; Routine 6
		tst.w	(v_debuguse).w	; is debug mode	on?
		bne.w	locret_ECEE	; if yes, branch
		btst	#1,(v_player+obStatus).w
		bne.s	loc_EC70
		move.b	#1,(f_lockctrl).w ; lock controls
		move.w	#btnR<<8,(v_jpadhold2).w ; make Sonic run to the right

	loc_EC70:
		cmp.l	#SonicPlayer,(v_player).w
		bne.s	loc_EC86
		move.w	(v_player+obX).w,d0
		move.w	(v_limitright2).w,d1
		addi.w	#$128,d1
		cmp.w	d1,d0
		bcs.w	locret_ECEE
	ac	ac_DoAct,a6

	loc_EC86:
		addq.b	#2,obRoutine(a0)

; ---------------------------------------------------------------------------
; Subroutine to	set up bonuses at the end of an	act
; ---------------------------------------------------------------------------

GotThroughAct:
		tst.b	$3F(a0)
		bne.w	locret_ECEE
		addq.b	#1,$3F(a0)
		move.w	(v_limitright2).w,(v_limitleft2).w
		clr.b	(v_invinc).w	; disable invincibility
		clr.b	(f_timecount).w	; stop time counter

		tst.b	omactr.w
		bne.s	@cocks
	ac	ac_Oma, a6

@cocks		bsr.w	FindFreeObj
		move.l	#GotThroughCard,(a1)	; set obj
		moveq	#plcid_TitleCard,d0
		jsr	(NewPLC).l	; load title card patterns

		moveq	#0,d3
		move.b	v_act.w,d3

		move.b	#1,(f_endactbonus).w
		moveq	#0,d0
		move.b	(v_timemin).w,d0
		mulu.w	#60,d0		; convert minutes to seconds
		moveq	#0,d1
		move.b	(v_timesec).w,d1

		cmp.l	#$93B16,v_time.w
		blt.s	@nofucks
	ac	ac_LastMin, a6
		bra.s	gta_nospd

@nofucks	tst.b	ckpt.w		; if died, rip
		bne.s	gta_nospd

		tst.w	d0
		bne.s	gta_nospd
		cmp.b	Tases(pc,d3.w),d1
		bgt.s	gta_notas
	ac	ac_tas, a6
		bra.s	gta_nospd
		move.w	$24(a6,d0.l),$26(a1,d2.w)

Tases:		dc.b 24, 18, 32, 29
SpeedRuns:	dc.b 26, 20, 35, 33

gta_notas:
		cmp.b	SpeedRuns(pc,d3.w),d1
		bgt.s	gta_nospd
	ac	ac_sprun, a6

gta_nospd:
		clr.b	ckpt.w		; clear flag
		add.w	d1,d0		; add up your time
		divu.w	#15,d0		; divide by 15
		moveq	#$14,d1
		cmp.w	d1,d0		; is time 5 minutes or higher?
		bcs.s	@hastimebonus	; if not, branch
		move.w	d1,d0		; use minimum time bonus (0)

	@hastimebonus:
		add.w	d0,d0
		move.w	TimeBonuses(pc,d0.w),(v_timebonus).w ; set time bonus
		move.w	(v_rings).w,d0	; load number of rings

		add.w	d3,d3
		cmp.w	#69,d0		; check if 69 rings
		bne.s	@not69		; if not, branch
	ac	ac_69, a6

@not69		cmp.w	MaxRings(pc,d3.w),d0
		blt.s	@nothing
	ac	ac_Ristar, a6

@nothing	mulu.w	#10,d0		; multiply by 10
		move.w	d0,(v_ringbonus).w ; set ring bonus
		sfx	Mus_Egor,0,0,0	; play "Sonic got through" music

locret_ECEE:
Sign_Exit:
		rts

; ===========================================================================
TimeBonuses:	dc.w 5000, 5000, 1000, 500, 400, 400, 300, 300,	200, 200
		dc.w 200, 200, 100, 100, 100, 100, 50, 50, 50, 50, 0
MaxRings:	dc.w 225, 169, 239, 167
; ===========================================================================
