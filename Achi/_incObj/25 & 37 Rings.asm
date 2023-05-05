; ---------------------------------------------------------------------------
; Distances between rings (format: horizontal, vertical)
; ---------------------------------------------------------------------------
Ring_PosData:	dc.b $10, 0		; horizontal tight
		dc.b $18, 0		; horizontal normal
		dc.b $20, 0		; horizontal wide
		dc.b 0,	$10		; vertical tight
		dc.b 0,	$18		; vertical normal
		dc.b 0,	$20		; vertical wide
		dc.b $10, $10		; diagonal
		dc.b $18, $18
		dc.b $20, $20
		dc.b $F0, $10
		dc.b $E8, $18
		dc.b $E0, $20
		dc.b $10, 8
		dc.b $18, $10
		dc.b $F0, 8
		dc.b $E8, $10
; ===========================================================================

Rings:
Ring_Main:	; Routine 0
		lea	(v_objstate).w,a3
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		lea	2(a3,d0.w),a3
		move.b	(a3),d4
		move.b	obSubtype(a0),d1
		move.b	d1,d0
		andi.w	#7,d1
		cmpi.w	#7,d1
		bne.s	loc_9B80
		moveq	#6,d1

	loc_9B80:
		swap	d1
		move.w	#0,d1
		lsr.b	#4,d0
		add.w	d0,d0
		move.b	Ring_PosData(pc,d0.w),d5 ; load ring spacing data
		ext.w	d5
		move.b	Ring_PosData+1(pc,d0.w),d6
		ext.w	d6
		movea.l	a0,a1
		move.w	obX(a0),d2
		move.w	obY(a0),d3
		lsr.b	#1,d4
		bcs.s	loc_9C02
		bclr	#7,(a3)
		bra.s	loc_9BBA
; ===========================================================================

Ring_MakeRings:
		swap	d1
		lsr.b	#1,d4
		bcs.s	loc_9C02
		bclr	#7,(a3)
		bsr.w	FindFreeObj
	;	bpl.s	loc_9C0E

loc_9BBA:
		move.l	#Ring_Animate,(a1)	; load ring object
		move.w	d2,obX(a1)		; set x-axis position based on d2
		move.w	obX(a0),$32(a1)
		move.w	d3,obY(a1)		; set y-axis position based on d3
		move.l	#Map_Ring,obMap(a1)
		move.w	#$27B2,obGfx(a1)
		move.b	#4,obRender(a1)
	display		2, a1
		move.b	#$47,obColType(a1)
		move.b	#8,obActWid(a1)
		move.b	obRespawnNo(a0),obRespawnNo(a1)
		move.b	d1,$34(a1)

loc_9C02:
		addq.w	#1,d1
		add.w	d5,d2		; add ring spacing value to d2
		add.w	d6,d3		; add ring spacing value to d3
		swap	d1
		dbf	d1,Ring_MakeRings ; repeat for	number of rings

loc_9C0E:
		move.l	#Ring_Animate,(a0)
		btst	#0,(a3)
		bne.w	DeleteObject2

Ring_Animate:	; Routine 2
		move.b	(v_ani1_frame).w,obFrame(a0) ; set frame
		tst.b	obRoutine(a0)
		bne.s	Ring_Collect

		out_of_range.w	DeleteObject2,$32(a0)
		jsr	AddToCollList
	NEXT_OBJ
; ===========================================================================

Ring_Collect:	; Routine 4
		clr.b	obColType(a0)
		clr.b	obRoutine(a0)
	chdisplay	1, a0
		move.l	#Ring_Sparkle,(a0)

		bsr.s	CollectRing
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		move.b	$34(a0),d1
		bset	d1,2(a2,d0.w)

Ring_Sparkle:	; Routine 6
		lea	(Ani_Ring).l,a1
		bsr.w	AnimateSprite

		tst.b	obRoutine(a0)
		bne.w	DeleteObject2
	NEXT_OBJ
; ===========================================================================

CollectRing:
	ac	ac_Rings1,a6
		st.b	omactr.w		; set oma ctr
		addq.w	#1,(v_rings).w	; add 1 to rings
		ori.b	#1,(f_ringcount).w ; update the rings counter
		moveq	#sfx_RingRight,d0	; play ring sound

		cmpi.w	#10,(v_rings).w ; do you have < 10 rings?
		blo.w	@playsnd	; if yes, branch
	ac	ac_Rings10,a6

		cmpi.w	#100,(v_rings).w ; do you have < 100 rings?
		bcs.s	@playsnd	; if yes, branch
	ac	ac_Rings100,a6
		bset	#1,(v_lifecount).w ; update lives counter
		beq.s	@got100
		cmpi.w	#200,(v_rings).w ; do you have < 200 rings?
		bcs.s	@playsnd	; if yes, branch
		bset	#2,(v_lifecount).w ; update lives counter
		bne.s	@playsnd

	@got100:
		addq.b	#1,(v_lives).w	; add 1 to the number of lives you have
		addq.b	#1,(f_lifecount).w ; update the lives counter
		cmp.b	#42,v_lives.w	; check for the meaning
		bne.s	@nolife
	ac	ac_life,a6

@nolife		moveq	#Mus_Egor,d0 ; play extra life music

	@playsnd:
		jsr	(PlaySound_Special).l
		jmp	UpdateSRAM.w

; ===========================================================================
; ---------------------------------------------------------------------------
; Object 37 - rings flying out of Sonic	when he's hit
; ---------------------------------------------------------------------------

RingLoss:
RLoss_Count:	; Routine 0
		movea.l	a0,a1
		moveq	#0,d5
		move.w	(v_rings).w,d5	; check number of rings you have
		moveq	#32,d0
		cmp.w	d0,d5		; do you have 32 or more?
		bcs.s	@belowmax	; if not, branch
		move.w	d0,d5		; if yes, set d5 to 32

	@belowmax:
		subq.w	#1,d5
		move.w	#$288,d4
		moveq	#0,d7		; clear counter
		bra.s	@makerings
; ===========================================================================

	@loop:
		bsr.w	FindFreeObj
	;	bpl.w	@resetcounter

@makerings:
		move.l	#RLoss_Bounce,(a1) ; load bouncing ring object
		move.b	#8,obHeight(a1)
		move.b	#8,obWidth(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.l	#Map_Ring,obMap(a1)
		move.w	#$27B2,obGfx(a1)
		move.b	#4,obRender(a1)

	display		3, a1
		move.b	#$47,obColType(a1)
		move.b	#8,obActWid(a1)
		move.b	#-1,(v_ani3_time).w

		tst.w	d4
		bmi.s	@loc_9D62
		move.w	d4,d0
		bsr.w	CalcSine
		move.w	d4,d2
		lsr.w	#8,d2
		asl.w	d2,d0
		asl.w	d2,d1
		move.w	d0,d2
		move.w	d1,d3
		addi.b	#$10,d4
		bcc.s	@loc_9D62
		subi.w	#$80,d4
		bcc.s	@loc_9D62
		move.w	#$288,d4

	@loc_9D62:
		move.w	d2,obVelX(a1)
		move.w	d3,obVelY(a1)
		neg.w	d2
		neg.w	d4

		addq.b	#1,d7		; increase counter
		move.b	d7,(a1)		; shhh, don't mind me
		dbf	d5,@loop	; repeat for number of rings (max 31)

@resetcounter:
		clr.w	(v_rings).w	; reset number of rings to zero
		move.b	#$80,(f_ringcount).w ; update ring counter
		clr.b	v_lifecount.w
		sfx	sfx_RingLoss,0,0,0	; play ring loss sound

RLoss_Bounce:	; Routine 2
		tst.b	obRoutine(a0)
		bne.s	RLoss_Collect

		move.b	(v_ani3_frame).w,obFrame(a0)
		bsr.w	SpeedToPos
		addi.w	#$18,obVelY(a0)
		bmi.s	@chkdel
		move.b	(v_vbla_byte).w,d0
		add.b	(a1),d0
		andi.b	#3,d0
		bne.s	@chkdel

		jsr	ObjFloorDist(pc)
		tst.w	d1
		bpl.s	@chkdel
		add.w	d1,obY(a0)
		move.w	obVelY(a0),d0
		asr.w	#2,d0
		sub.w	d0,obVelY(a0)
		neg.w	obVelY(a0)

@chkdel		tst.b	v_ani3_time.w
		beq.w	DeleteObject2
		move.w	(v_limitbtm2).w,d0
		addi.w	#$E0,d0
		cmp.w	obY(a0),d0	; has object moved below level boundary?
		bcs.w	DeleteObject2	; if yes, branch

		jsr	AddToCollList
	NEXT_OBJ
; ===========================================================================

RLoss_Collect:	; Routine 4
		clr.b	obRoutine(a0)
		clr.b	obColType(a0)
	chdisplay	1, a0
		bsr.w	CollectRing
		move.l	#RLoss_Sparkle,(a0)

RLoss_Sparkle:	; Routine 6
		lea	(Ani_Ring).l,a1
		bsr.w	AnimateSprite
		tst.b	obRoutine(a0)
		bne.w	DeleteObject2
	NEXT_OBJ
