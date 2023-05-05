; ===========================================================================
; ---------------------------------------------------------------------------
; Swap effect - zig-zag triangles
; ---------------------------------------------------------------------------
MMWT_TriSize =		$10
MMWT_ScrollInWait =	2
MMWT_ScrollWait =	20
MMWT_ScrollSpeed =	2
; ---------------------------------------------------------------------------

MMW_Triangle:
		move.l	#MMW_T_1,(EMM_SwapRout).l		; set next routine
		clr.w	2(a3)					; clear v-position
		move.w	#MMWT_ScrollInWait,(a3)			; set timer to x fr
		move.w	#$918F+MMWT_TriSize,4(a3)		; clear h-position

MMW_T_1:
		subq.w	#1,(a3)+				; sub 1 from timer
		bne.s	MMW_T_Scroll1_Off			; branch if timer is ok
		move.w	#MMWT_ScrollInWait,-2(a3)		; set timer to x fr
		subq.w	#1,2(a3)				; add 1 to the offset

		cmp.w	#$9193,2(a3)				; check if finished yet
		bne.s	MMW_T_Scroll1_Off			; if not, branch

		lea	MMW_T_2(pc),a0				; get next routine
		move.l	a0,(EMM_SwapRout).l			; set swap routine
		subq.w	#2,a3					; reset a3
		move.w	#MMWT_ScrollWait,(a3)			; set timer to x fr
		jmp	(a0)					; jump to it


MMW_T_Scroll1_Off:
		move.w	2(a3),d0				; get offset
		bra.s	MMW_T_Scroll1

MMW_T_2:
		subq.w	#1,(a3)+				; sub 1 from timer
		bne.s	.timerok				; branch if timer is ok

		lea	MMW_T_3(pc),a0				; get next routine
		move.l	a0,(EMM_SwapRout).l			; set swap routine
		subq.w	#2,a3					; reset a3

		move.w	#MMWT_ScrollInWait,(a3)			; set timer to x fr
		jmp	(a0)					; jump to it

.timerok	move.w	#$9193,d0				; prepare d0

MMW_T_Scroll1:
		move.w	(a3),d3					; load v-positi on
		addq.w	#8,d3					; increase v-pos
		bmi.s	.ok					; if still negative, branch
		move.w	#-(MMWT_TriSize*2*8),d3			; else reset it

.ok		move.w	d3,(a3)					; save ctr
		movea.l	(EMM_WindowSlot).l,a1			; get window pos
		add.w	d3,a1					; offset the buffer properly
		moveq	#($E0/(MMWT_TriSize*2))+1,d1

.loop	rept MMWT_TriSize/2
		subq.b	#1,d0
		move.w	d0,(a1)+
		addq.w	#$02,a1
		move.w	d0,(a1)+
		addq.w	#$02,a1
	endm

	rept MMWT_TriSize/2
		addq.b	#1,d0
		move.w	d0,(a1)+
		addq.w	#$02,a1
		move.w	d0,(a1)+
		addq.w	#$02,a1
	endm
		dbf	d1,.loop
		rts

MMW_T_3:
		subq.w	#1,(a3)+				; sub 1 from timer
		bne.w	MMW_T_Scroll1_Off			; branch if timer is ok
		move.w	#MMWT_ScrollInWait,-2(a3)		; set timer to x fr
		subq.w	#MMWT_ScrollSpeed,2(a3)			; add 1 to the offset

		cmp.w	#$917F,2(a3)				; check if finished yet
		bne.w	MMW_T_Scroll1_Off			; if not, branch
		move.l	#MMW_T_SwPl,(EMM_SwapRout).l		; set swap routine

MMW_T_LoadSlot2:
		lea	(EMM_VScroll).l,a0			; load V-scroll RAM
		move.w	(EMM_ScrollSlot).l,d0			; add plane slot position being used
		addi.w	#$0100,d0				; advance to next plane
		move.w	d0,d1					; copy to both words of d0
		swap	d0					; ''
		move.w	d1,d0					; ''
		moveq	#($E0/$04)-1,d2				; set number of scanlines to edit

MMW_A_Load:
		move.l	d0,(a0)+				; set the entry of V-scroll to move directly to the plane
		move.l	d0,(a0)+				; ''
		move.l	d0,(a0)+				; ''
		move.l	d0,(a0)+				; ''
		dbf	d2,MMW_A_Load				; repeat until it's all set
		rts

MMW_T_SwPl:
		move.w	#MMWT_ScrollInWait,(a3)			; set timer to x fr
		move.w	#$9106+MMWT_TriSize,4(a3)		; clear h-position

		lea	MMW_T_4(pc),a0				; get next routine
		move.l	a0,(EMM_SwapRout).l			; set swap routine
		jmp	(a0)					; jump to it

MMW_T_4:
		subq.w	#1,(a3)+				; sub 1 from timer
		bne.s	MMW_T_Scroll2_Off			; branch if timer is ok
		move.w	#MMWT_ScrollInWait,-2(a3)		; set timer to x fr
		subq.w	#MMWT_ScrollSpeed,2(a3)			; add 1 to the offset

		cmp.w	#$9100,2(a3)				; check if finished yet
		bne.s	MMW_T_Scroll2_Off			; if not, branch

		lea	MMW_T_5(pc),a0				; get next routine
		move.l	a0,(EMM_SwapRout).l			; set swap routine
		subq.w	#2,a3					; reset a3

		move.w	#MMWT_ScrollWait,(a3)			; set timer to x fr
		jmp	(a0)					; jump to it

MMW_T_Scroll2_Off:
		move.w	2(a3),d0				; get offset
		bra.s	MMW_T_Scroll2

MMW_T_5:
		subq.w	#1,(a3)+				; sub 1 from timer
		bne.s	.timerok				; branch if timer is ok

		lea	MMW_T_6(pc),a0				; get next routine
		move.l	a0,(EMM_SwapRout).l			; set swap routine
		subq.w	#2,a3					; reset a3

		clr.w	(a3)					; reset timer
		move.w	#$9200,4(a3)				; clear h-position
		jmp	(a0)					; jump to it


.timerok	move.w	#$9100,d0				; prepare d0

MMW_T_Scroll2:
		move.w	(a3),d3					; load v-position
		addq.w	#8,d3					; increase v-pos
		bmi.s	.ok					; if still negative, branch
		move.w	#-(MMWT_TriSize*2*8),d3			; else reset it

.ok		move.w	d3,(a3)					; save ctr
		movea.l	(EMM_WindowSlot).l,a1			; get window pos

		add.w	d3,a1					; offset the buffer properly
		moveq	#($E0/(MMWT_TriSize*2))+1,d1

.loop	rept MMWT_TriSize/2
		addq.b	#1,d0
		move.w	d0,(a1)+
		addq.w	#$02,a1
		move.w	d0,(a1)+
		addq.w	#$02,a1
	endm

	rept MMWT_TriSize/2
		subq.b	#1,d0
		move.w	d0,(a1)+
		addq.w	#$02,a1
		move.w	d0,(a1)+
		addq.w	#$02,a1
	endm
		dbf	d1,.loop
		rts

MMW_T_6:
		subq.w	#1,(a3)+				; sub 1 from timer
		bpl.w	MMW_T_Scroll2_Off			; branch if timer is ok
		move.w	#MMWT_ScrollInWait,-2(a3)		; set timer to x fr
		subq.w	#1,2(a3)				; add 1 to the offset

		cmp.w	#$91F6,2(a3)				; check if finished yet
		bne.w	MMW_T_Scroll2_Off			; if not, branch
		move.l	#MMWBS_ResetWindow,(EMM_SwapRout).l	; set next swap routine (SEE MMW_BoxScale FOR CODE!)
		rts						; return

; ===========================================================================
