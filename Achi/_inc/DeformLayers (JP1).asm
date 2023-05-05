; ---------------------------------------------------------------------------
; Background layer deformation subroutines
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


DeformLayers:
		tst.b	(f_nobgscroll).w
		beq.s	loc_628E
		rts
; ===========================================================================

loc_628E:
		clr.w	(v_bgscroll1).w
		clr.w	(v_bgscroll2).w
		clr.w	(v_bgscroll3).w
		clr.w	v_bgscroll4.w
		bsr.w	ScrollHoriz
		bsr.w	ScrollVertical
		bsr.w	DynamicLevelEvents
		move.w	(v_screenposy).w,(v_scrposy_dup).w
		move.w	(v_bgscreenposy).w,v_scrposxb_dup.w

Deform_GHZ:
		move.w	(v_scrshiftx).w,d4
		ext.l	d4
		asl.l	#5,d4
		move.l	d4,d1
		asl.l	#1,d4
		add.l	d1,d4
		moveq	#0,d6
		bsr.w	ScrollBlock5
		move.w	(v_scrshiftx).w,d4
		ext.l	d4
		asl.l	#7,d4
		moveq	#0,d6
		bsr.w	ScrollBlock4
		lea	(v_hscrolltablebuffer).w,a1
		move.w	(v_screenposy).w,d0
		andi.w	#$7FF,d0
		lsr.w	#5,d0
		neg.w	d0
		addi.w	#$20,d0
		bpl.s	loc_62F6
		moveq	#0,d0
loc_62F6:
		move.w	d0,d4
		move.w	d0,v_scrposxb_dup.w
		move.w	(v_screenposx).w,d0
		cmpi.b	#id_Title,v_gamemode.w
		bne.s	loc_630A
		moveq	#0,d0
loc_630A:
		neg.w	d0
		swap.w	d0
		lea	v_scrollingtbl.w,a2
		addi.l	#$10000,(a2)+
		addi.l	#$C000,(a2)+
		addi.l	#$8000,(a2)+
		move.w	v_scrollingtbl.w,d0
		add.w	(v_bg3screenposx).w,d0
		neg.w	d0
		move.w	#$1F,d1
		sub.w	d4,d1
		bcs.s	loc_633C
loc_6336:
		move.l	d0,(a1)+
		dbf	d1,loc_6336
loc_633C:
		move.w	v_scrollingtbl+4.w,d0
		add.w	(v_bg3screenposx).w,d0
		neg.w	d0
		move.w	#$F,d1
loc_634A:
		move.l	d0,(a1)+
		dbf	d1,loc_634A
		move.w	v_scrollingtbl+8.w,d0
		add.w	(v_bg3screenposx).w,d0
		neg.w	d0
		move.w	#$F,d1
loc_635E:
		move.l	d0,(a1)+
		dbf	d1,loc_635E
		move.w	#$2F,d1
		move.w	(v_bg3screenposx).w,d0
		neg.w	d0
loc_636E:
		move.l	d0,(a1)+
		dbf	d1,loc_636E
		move.w	#$27,d1
		move.w	(v_bg2screenposx).w,d0
		neg.w	d0
loc_637E:
		move.l	d0,(a1)+
		dbf	d1,loc_637E
		move.w	(v_bg2screenposx).w,d0
		move.w	(v_screenposx).w,d2
		sub.w	d0,d2
		ext.l	d2
		asl.l	#8,d2
		divs.w	#$68,d2
		ext.l	d2
		asl.l	#8,d2
		moveq	#0,d3
		move.w	d0,d3
		move.w	#$47,d1
		add.w	d4,d1
loc_63A4:
		move.w	d3,d0
		neg.w	d0
		move.l	d0,(a1)+
		swap.w	d3
		add.l	d2,d3
		swap.w	d3
		dbf	d1,loc_63A4
		rts

; ---------------------------------------------------------------------------
; Subroutine to	scroll the level horizontally as Sonic moves
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ScrollHoriz:
		move.w	(v_screenposx).w,d4 ; save old screen position
		bsr.s	MoveScreenHoriz
		move.w	(v_screenposx).w,d0
		andi.w	#$10,d0
		move.b	f_hcamredraw.w,d1
		eor.b	d1,d0
		bne.s	locret_65B0
		eori.b	#$10,f_hcamredraw.w
		move.w	(v_screenposx).w,d0
		sub.w	d4,d0		; compare new with old screen position
		bpl.s	SH_Forward

		bset	#2,(v_bgscroll1).w ; screen moves backward
		rts

	SH_Forward:
		bset	#3,(v_bgscroll1).w ; screen moves forward

locret_65B0:
		rts
; End of function ScrollHoriz


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


MoveScreenHoriz:
		move.w	(v_player+obX).w,d0
		sub.w	(v_screenposx).w,d0 ; Sonic's distance from left edge of screen
		subi.w	#144,d0		; is distance less than 144px?
		bcs.s	SH_BehindMid	; if yes, branch
		subi.w	#16,d0		; is distance more than 160px?
		bcc.s	SH_AheadOfMid	; if yes, branch
		clr.w	(v_scrshiftx).w
		rts
; ===========================================================================

SH_AheadOfMid:
		cmpi.w	#16,d0		; is Sonic within 16px of middle area?
		bcs.s	SH_Ahead16	; if yes, branch
		move.w	#16,d0		; set to 16 if greater

	SH_Ahead16:
		add.w	(v_screenposx).w,d0
		cmp.w	(v_limitright2).w,d0
		blt.s	SH_SetScreen
		move.w	(v_limitright2).w,d0

SH_SetScreen:
		move.w	d0,d1
		sub.w	(v_screenposx).w,d1
		asl.w	#8,d1
		move.w	d0,(v_screenposx).w ; set new screen position
		move.w	d1,(v_scrshiftx).w ; set distance for screen movement
		rts
; ===========================================================================

SH_BehindMid:
		add.w	(v_screenposx).w,d0
		cmp.w	(v_limitleft2).w,d0
		bgt.s	SH_SetScreen
		move.w	(v_limitleft2).w,d0
		bra.s	SH_SetScreen
; End of function MoveScreenHoriz

; ===========================================================================
		tst.w	d0
		bpl.s	loc_6610
		move.w	#-2,d0
		bra.s	SH_BehindMid

loc_6610:
		move.w	#2,d0
		bra.s	SH_AheadOfMid

; ---------------------------------------------------------------------------
; Subroutine to	scroll the level vertically as Sonic moves
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ScrollVertical:
		moveq	#0,d1
		move.w	(v_player+obY).w,d0
		sub.w	(v_screenposy).w,d0 ; Sonic's distance from top of screen
		btst	#2,(v_player+obStatus).w ; is Sonic rolling?
		beq.s	SV_NotRolling	; if not, branch
		subq.w	#5,d0

	SV_NotRolling:
		btst	#1,(v_player+obStatus).w ; is Sonic jumping?
		beq.s	loc_664A	; if not, branch

		addi.w	#32,d0
		sub.w	(v_lookshift).w,d0
		bcs.s	loc_6696
		subi.w	#64,d0
		bcc.s	loc_6696
		tst.b	(f_bgscrollvert).w
		bne.s	loc_66A8
		bra.s	loc_6656
; ===========================================================================

loc_664A:
		sub.w	(v_lookshift).w,d0
		bne.s	loc_665C
		tst.b	(f_bgscrollvert).w
		bne.s	loc_66A8

loc_6656:
		clr.w	v_scrshifty.w
		rts
; ===========================================================================

loc_665C:
		cmpi.w	#$60,(v_lookshift).w
		bne.s	loc_6684
		move.w	(v_player+obInertia).w,d1
		bpl.s	loc_666C
		neg.w	d1

loc_666C:
		cmpi.w	#$800,d1
		bcc.s	loc_6696
		move.w	#$600,d1
		cmpi.w	#6,d0
		bgt.s	loc_66F6
		cmpi.w	#-6,d0
		blt.s	loc_66C0
		bra.s	loc_66AEa
; ===========================================================================

loc_6684:
		move.w	#$200,d1
		cmpi.w	#2,d0
		bgt.s	loc_66F6
		cmpi.w	#-2,d0
		blt.s	loc_66C0
		bra.s	loc_66AEa
; ===========================================================================

loc_6696:
		move.w	#$1000,d1
		cmpi.w	#$10,d0
		bgt.s	loc_66F6
		cmpi.w	#-$10,d0
		blt.s	loc_66C0
		bra.s	loc_66AEa
; ===========================================================================

loc_66A8:
		moveq	#0,d0
		move.b	d0,(f_bgscrollvert).w

loc_66AEa:
		moveq	#0,d1
		move.w	d0,d1
		add.w	(v_screenposy).w,d1
		tst.w	d0
		bpl.w	loc_6700
		bra.w	loc_66CC
; ===========================================================================

loc_66C0:
		neg.w	d1
		ext.l	d1
		asl.l	#8,d1
		add.l	(v_screenposy).w,d1
		swap	d1

loc_66CC:
		cmp.w	(v_limittop2).w,d1
		bgt.s	loc_6724
		cmpi.w	#-$100,d1
		bgt.s	loc_66F0
		andi.w	#$7FF,d1
		andi.w	#$7FF,(v_player+obY).w
		andi.w	#$7FF,(v_screenposy).w
		andi.w	#$3FF,(v_bgscreenposy).w
		bra.s	loc_6724
; ===========================================================================

loc_66F0:
		move.w	(v_limittop2).w,d1
		bra.s	loc_6724
; ===========================================================================

loc_66F6:
		ext.l	d1
		asl.l	#8,d1
		add.l	(v_screenposy).w,d1
		swap	d1

loc_6700:
		cmp.w	(v_limitbtm2).w,d1
		blt.s	loc_6724
		subi.w	#$800,d1
		bcs.s	loc_6720
		andi.w	#$7FF,(v_player+obY).w
		subi.w	#$800,(v_screenposy).w
		andi.w	#$3FF,(v_bgscreenposy).w
		bra.s	loc_6724
; ===========================================================================

loc_6720:
		move.w	(v_limitbtm2).w,d1

loc_6724:
		move.w	(v_screenposy).w,d4
		swap	d1
		move.l	d1,d3
		sub.l	(v_screenposy).w,d3
		ror.l	#8,d3
		move.w	d3,v_scrshifty.w
		move.l	d1,(v_screenposy).w
		move.w	(v_screenposy).w,d0
		andi.w	#$10,d0
		move.b	f_vcamredraw.w,d1
		eor.b	d1,d0
		bne.s	locret_6766
		eori.b	#$10,f_vcamredraw.w
		move.w	(v_screenposy).w,d0
		sub.w	d4,d0
		bpl.s	loc_6760
		bset	#0,(v_bgscroll1).w
		rts
; ===========================================================================

loc_6760:
		bset	#1,(v_bgscroll1).w

locret_6766:
		rts
; End of function ScrollVertical


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ScrollBlock1:
		move.l	(v_bgscreenposx).w,d2
		move.l	d2,d0
		add.l	d4,d0
		move.l	d0,(v_bgscreenposx).w
		move.l	d0,d1
		swap.w	d1
		andi.w	#$10,d1
		move.b	f_p1h_cambound.w,d3
		eor.b	d3,d1
		bne.s	loc_6AF8
		eori.b	#$10,f_p1h_cambound.w
		sub.l	d2,d0
		bpl.s	loc_6AF2
		bset	#2,(v_bgscroll2).w
		bra.s	loc_6AF8
loc_6AF2:
		bset	#3,(v_bgscroll2).w
loc_6AF8:
		move.l	(v_bgscreenposy).w,d3
		move.l	d3,d0
		add.l	d5,d0
		move.l	d0,(v_bgscreenposy).w
		move.l	d0,d1
		swap.w	d1
		andi.w	#$10,d1
		move.b	f_p1v_cambound.w,d2
		eor.b	d2,d1
		bne.s	loc_6B2C
		eori.b	#$10,f_p1v_cambound.w
		sub.l	d3,d0
		bpl.s	loc_6B26
		bset	#0,(v_bgscroll2).w
		rts
loc_6B26:
		bset	#1,(v_bgscroll2).w
loc_6B2C:
		rts
; End of function ScrollBlock1

Bg_Scroll_Y:
		move.l	(v_bgscreenposy).w,d3
		move.l	d3,d0
		add.l	d5,d0
		move.l	d0,(v_bgscreenposy).w
		move.l	d0,d1
		swap.w	d1
		andi.w	#$10,d1
		move.b	f_p1v_cambound.w,d2
		eor.b	d2,d1
		bne.s	Exit_Bg_Scroll_Y
		eori.b	#$10,f_p1v_cambound.w
		sub.l	d3,d0
		bpl.s	loc_6B5C
		bset	#4,(v_bgscroll2).w
		rts
loc_6B5C:
		bset	#5,(v_bgscroll2).w
Exit_Bg_Scroll_Y:
		rts


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ScrollBlock2:
		move.w	(v_bgscreenposy).w,d3
		move.w	d0,(v_bgscreenposy).w
		move.w	d0,d1
		andi.w	#$10,d1
		move.b	f_p1v_cambound.w,d2
		eor.b	d2,d1
		bne.s	Exit_Scroll_Block2
		eori.b	#$10,f_p1v_cambound.w
		sub.w	d3,d0
		bpl.s	loc_6B8C
		bset	#0,(v_bgscroll2).w
		rts
loc_6B8C:
		bset	#1,(v_bgscroll2).w
Exit_Scroll_Block2:
		rts
; End of function ScrollBlock2


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ScrollBlock3:
		move.l	(v_bgscreenposx).w,d2
		move.l	d2,d0
		add.l	d4,d0
		move.l	d0,(v_bgscreenposx).w
		move.l	d0,d1
		swap.w	d1
		andi.w	#$10,d1
		move.b	f_p1h_cambound.w,d3
		eor.b	d3,d1
		bne.s	Exit_Scroll_Block3
		eori.b	#$10,f_p1h_cambound.w
		sub.l	d2,d0
		bpl.s	loc_6BC0
		bset	d6,(v_bgscroll2).w
		bra.s	Exit_Scroll_Block3
loc_6BC0:
		addq.b	#1,d6
		bset	d6,(v_bgscroll2).w
Exit_Scroll_Block3:
		rts
; End of function ScrollBlock3


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ScrollBlock4:
		move.l	(v_bg2screenposx).w,d2
		move.l	d2,d0
		add.l	d4,d0
		move.l	d0,(v_bg2screenposx).w
		move.l	d0,d1
		swap.w	d1
		andi.w	#$10,d1
		move.b	f_p2h_cambound.w,d3
		eor.b	d3,d1
		bne.s	Exit_Scroll_Block4
		eori.b	#$10,f_p2h_cambound.w
		sub.l	d2,d0
		bpl.s	loc_6BF4
		bset	d6,(v_bgscroll3).w
		bra.s	Exit_Scroll_Block4
loc_6BF4:
		addq.b	#1,d6
		bset	d6,(v_bgscroll3).w
Exit_Scroll_Block4:
		rts
;-------------------------------------------------------------------------------
ScrollBlock5:
		move.l	(v_bg3screenposx).w,d2
		move.l	d2,d0
		add.l	d4,d0
		move.l	d0,(v_bg3screenposx).w
		move.l	d0,d1
		swap.w	d1
		andi.w	#$10,d1
		move.b	f_p3h_cambound.w,d3
		eor.b	d3,d1
		bne.s	loc_6C2E
		eori.b	#$10,f_p3h_cambound.w
		sub.l	d2,d0
		bpl.s	loc_6C28
		bset	d6,v_bgscroll4.w
		bra.s	loc_6C2E
loc_6C28:
		addq.b	#1,d6
		bset	d6,v_bgscroll4.w
loc_6C2E:
		rts
