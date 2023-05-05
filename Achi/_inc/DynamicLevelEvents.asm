; ---------------------------------------------------------------------------
; Dynamic level events
; ---------------------------------------------------------------------------

DLE_GHZx:	dc.w DLE_GHZ1-DLE_GHZx
		dc.w DLE_GHZ2-DLE_GHZx
		dc.w DLE_GHZ3-DLE_GHZx
		dc.w DLE_GHZ4-DLE_GHZx
; ===========================================================================
DynamicLevelEvents:
		moveq	#0,d0
		move.b	(v_act).w,d0
		add.w	d0,d0
		move.w	DLE_GHZx(pc,d0.w),d0
		jsr	DLE_GHZx(pc,d0.w)

		moveq	#2,d1
		move.w	(v_limitbtm1).w,d0
		sub.w	(v_limitbtm2).w,d0 ; has lower level boundary changed recently?
		beq.s	DLE_NoChg	; if not, branch
		bcc.s	loc_6DAC

		neg.w	d1
		move.w	(v_screenposy).w,d0
		cmp.w	(v_limitbtm1).w,d0
		bls.s	loc_6DA0
		move.w	d0,(v_limitbtm2).w
		andi.w	#$FFFE,(v_limitbtm2).w

loc_6DA0:
		add.w	d1,(v_limitbtm2).w
		move.b	#1,(f_bgscrollvert).w

DLE_NoChg:
		rts
; ===========================================================================

loc_6DAC:
		move.w	(v_screenposy).w,d0
		addq.w	#8,d0
		cmp.w	(v_limitbtm2).w,d0
		bcs.s	loc_6DC4
		btst	#1,(v_player+obStatus).w
		beq.s	loc_6DC4
		add.w	d1,d1
		add.w	d1,d1

loc_6DC4:
		add.w	d1,(v_limitbtm2).w
		move.b	#1,(f_bgscrollvert).w
		rts
; ===========================================================================

DLE_GHZ1:
		cmp.w	#$380,v_player+ObY.w
		blt.s	@nope
		cmp.w	#$C00,v_screenposx.w
		bhs.s	@nope
		cmp.w	#$880,v_screenposx.w
		blo.s	@nope
		move.w	#$420,v_limitbtm1.w
		rts

@nope		move.w	#$300,(v_limitbtm1).w ; set lower y-boundary
		cmpi.w	#$1780,(v_screenposx).w ; has the camera reached $1780 on x-axis?
		bcs.s	locret_6E08	; if not, branch
		move.w	#$400,(v_limitbtm1).w ; set lower y-boundary

locret_6E08:
		rts
; ===========================================================================

DLE_GHZ2:
		cmp.b	#4,v_gamemode.w
		beq.s	DLE_GHZ3main
		cmp.w	#$4F0,v_player+ObX.w
		bgt.s	@nope
		cmp.w	#$3A0,v_player+ObY.w
		blt.s	@nope
		move.w	#$400,(v_limitbtm1).w
		move.w	#$40,(v_limitleft2).w
		rts

@nope		move.w	#$300,(v_limitbtm1).w
		cmp.w	#$500,v_player+ObX.w
		bgt.s	@nope2
		clr.w	v_limitleft2.w

@nope2		cmpi.w	#$ED0,(v_screenposx).w
		bcs.s	locret_6E3A
		move.w	#$200,(v_limitbtm1).w
		cmpi.w	#$1600,(v_screenposx).w
		bcs.s	locret_6E3A
		move.w	#$400,(v_limitbtm1).w
		cmpi.w	#$1D60,(v_screenposx).w
		bcs.s	locret_6E3A
		move.w	#$300,(v_limitbtm1).w

locret_6E3A:
		rts
; ===========================================================================

DLE_GHZ3:
		moveq	#0,d0
		move.b	(v_dle_routine).w,d0
		move.w	off_6E4A(pc,d0.w),d0
		jmp	off_6E4A(pc,d0.w)
; ===========================================================================
off_6E4A:	dc.w DLE_GHZ3main-off_6E4A
		dc.w DLE_GHZ3boss-off_6E4A
		dc.w DLE_GHZ3end-off_6E4A
; ===========================================================================

DLE_GHZ3main:
		move.w	#$300,(v_limitbtm1).w
		cmp.b	#4,v_gamemode.w
		beq.s	locret_6E96

		cmpi.w	#$380,(v_screenposx).w
		bcs.s	locret_6E96
		move.w	#$310,(v_limitbtm1).w
		cmpi.w	#$960,(v_screenposx).w
		bcs.s	locret_6E96
		cmpi.w	#$280,(v_screenposy).w
		bcs.s	loc_6E98
		move.w	#$400,(v_limitbtm1).w
		cmpi.w	#$1380,(v_screenposx).w
		bcc.s	loc_6E8E
		move.w	#$4C0,(v_limitbtm1).w
		move.w	#$4C0,(v_limitbtm2).w

loc_6E8E:
		cmp.w	#$3D0,v_player+ObY.w
		blt.s	@not
		cmp.w	#$1D40,v_player+ObX.w
		bge.s	@not
		cmp.w	#$1800,v_player+ObX.w
		ble.s	locret_6E96
		move.w	#$420,v_limitbtm1.w
		rts

@not		cmpi.w	#$1700,(v_screenposx).w
		bcc.s	loc_6E98

locret_6E96:
		rts
; ===========================================================================

loc_6E98:
		move.w	#$300,(v_limitbtm1).w
		addq.b	#2,(v_dle_routine).w
		rts
; ===========================================================================

DLE_GHZ3boss:
		cmpi.w	#$960,(v_screenposx).w
		bcc.s	loc_6EB0
		subq.b	#2,(v_dle_routine).w

loc_6EB0:
		cmpi.w	#$2960,(v_screenposx).w
		bcs.s	locret_6EE8
		bsr.w	FindFreeObj
	;	bpl.s	loc_6ED0
		move.l	#BossGreenHill,(a1) ; load GHZ boss	object
		move.w	#$2A60,obX(a1)
		move.w	#$280,obY(a1)

loc_6ED0:
		music	Mus_Egor,0,1,0	; play boss music
		move.b	#1,(f_lockscreen).w ; lock screen
		addq.b	#2,(v_dle_routine).w
		moveq	#plcid_Boss,d0
		bra.w	AddPLC		; load boss patterns
; ===========================================================================

DLE_GHZ3end:
		move.w	(v_screenposx).w,(v_limitleft2).w
locret_6EE8:
DLE_Ending:
		rts
; ===========================================================================

DLE_GHZ4:
		cmp.b	#4,v_gamemode.w
		beq.w	DLE_GHZ3main
		tst.b	v_dle_routine.w		; check if routine is 0
		bne.s	DLE_GHZ3end		; if not, branch

		move.w	#$520,(v_limitbtm1).w
		cmp.w	#$1400,(v_screenposx).w
		blo.s	locret_6EE8
		move.w	#$41C,(v_limitbtm1).w
		cmp.w	#$1D00,(v_screenposx).w
		blo.s	locret_6EE8
		move.w	#$300,(v_limitbtm1).w

		cmp.w	#$2200,(v_screenposx).w
		blo.s	locret_6EE8
		bsr.w	FindFreeObj
	;	bpl.s	loc_6ED0
		move.l	#BossShoe,(a1)		; load Shoe0nHead
		move.w	#ShoeRight+64,obX(a1)
		move.w	#ShoeTop+$40,obY(a1)

		music	Mus_Egor,0,1,0			; play boss music
		move.b	#1,(f_lockscreen).w	; not a lock screen
		addq.b	#4,(v_dle_routine).w
		moveq	#plcid_Shoe,d0
		bra.w	AddPLC			; load boss patterns
