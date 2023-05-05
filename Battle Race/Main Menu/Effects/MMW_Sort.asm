; ===========================================================================
; ---------------------------------------------------------------------------
; Swap effect - Sorting algorithm
; ---------------------------------------------------------------------------
MMWS_SortSpeed =	$02		; num of frames between next swap
MMWS_Size =		$0E		; size of each segment
MMWS_SegCt =		$E0/MMWS_Size	; num of segmentos
; ---------------------------------------------------------------------------

MMW_Sort:
		move.l	#MMWS_Show,EMM_SwapRout		; set next routine
		clr.l	(a3)				; clear some vars
		move.w	#-MMWS_Size*4,$1C(a3)		; important!!!
		st	$1C+3(a3)			; important!!!
		lea	$20(a3),a2			; get data ptr

		moveq	#MMWS_SegCt-1,d6		; set loop count
		moveq	#0,d5				; set max y-pos
		move.w	#MMWS_Size*4,d4			; reset height diff

.loop		jsr	Random_Number			; load random number
		and.l	#$FFF,d0			; whatever, just dont break div
		divu	#20,d0				; get a range in the
		swap	d0				; get the remainder

		move.w	d5,(a2)+			; save height
		move.b	d0,(a2)+			; save x-pos
		clr.b	(a2)+				; clear byte
		add.w	d4,d5				; add to y-pos
		dbf	d6,.loop			; do all entries

MMWS_Show:
		addq.w	#1,(a3)				; advance x-show by 2
		cmp.w	#20,(a3)			; check if max
		bgt.s	MMWS_RHS.sort			; if so, sort
		move.w	(a3),d5				; get the x-pos then
		bra.s	MMWS_RHS

MMWS_Exit:
		move.l	#MMWBS_ResetWindow,EMM_SwapRout	; set next swap routine (SEE MMW_BoxScale FOR CODE!)
		rts

MMWS_Hide:
		subq.w	#1,(a3)				; advance x-show by 2
		bmi.s	MMWS_Exit			; if negative, branch
		move.w	(a3),d5				; get the x-pos then

MMWS_RHS:
		movea.l	EMM_WindowSlot,a1		; load window buffer
		lea	$20(a3),a2			; get data ptr
		moveq	#MMWS_SegCt-1,d6		; set loop count

.loop		move.w	(a2)+,d0			; get height
		moveq	#0,d1				; clear high byte
		move.b	(a2)+,d1			; get x-pos
		clr.b	(a2)+				; mehhhh

		cmp.w	d5,d1				; check if more than (a3)
		ble.s	.more				; branch if not
		move.w	d5,d1				; else get (a3)

.more		lea	1(a1,d0.w),a3			; you da real ptr

	rept MMWS_Size
		move.b	d1,(a3)				; save the right black line
		addq.w	#4,a3				; and skip over worthless thrash data
	endm
		dbf	d6,.loop			; loop for all da mvp's
		rts

.sort		move.l	#MMWS_Sort,EMM_SwapRout		; set next routine
		move.l	#EMM_SwapRAM,a3			; get RAM slot backto a3
		clr.l	(a3)				; clear pointers

MMWS_Sort:
	; check if the current point is the next swap one
		moveq	#0,d0
		move.w	(a3),d0				; get the current offset
		lea	$20(a3,d0.w),a1			; get object to use
		move.b	2(a1),d1			; get width
		lea	$20(a3),a2			; get data to a2
		moveq	#MMWS_SegCt-1,d6		; set loop count

.check		cmp.b	2(a2),d1			; check if this is wider
		bge.s	.cnext				; if not, branch
		tst.b	3(a2)				; check if set already
		beq.s	.fail				; if not, branch

.cnext		addq.w	#4,a2				; goto next obj
		dbf	d6,.check			; else just loopdeloop

		moveq	#0,d0
		move.w	2(a3),d0			; get the offset of last line
		addq.w	#4,d0				; increment
		move.w	d0,(a3)+			; save as the new offset too
		move.w	d0,(a3)				; save as the min offset
		subq.w	#4,d0				; decrement

		st	3(a1)				; activate this one
		cmp.w	#MMWS_SegCt*4,d0		; check if last shite
		bhs.s	.hide				; branch if last shite... yea!

		move.w	$20-2-4(a3,d0.w),(a1)		; copy the height of last item
		add.w	#MMWS_Size*4,(a1)		; fix our size
		move.l	(a1),$10-2(a3)			; store data for a while

	; ok so, we need to physically reorder the whole damn list now. Fun!!!
.reorder	tst.b	-1(a1)				; check if this is active
		bne.s	.rdone				; if is, branch

		move.l	-(a1),4(a1)			; copy a long of the list
		add.w	#MMWS_Size*4,4(a1)		; align!
		bra.s	.reorder

.rdone		move.l	$10-2(a3),(a1)			; and finally store this bastard
		bra.s	.render

.hide		move.l	#MMWS_Hide,EMM_SwapRout		; set next routine
		move.w	#20,-2(a3)			; reset pos
		bra.s	.render				; render once more!

.fail		addq.w	#4,(a3)+			; go to next row

	; fucking hell that was awkward, but now we get to the fun part of rendering all of this
.render		moveq	#MMWS_SegCt-1,d6		; set loop count
		lea	$20-2(a3),a2			; get data to a2
		lea	EMM_VScroll,a0			; load V-scroll RAM to a0
		mulu	#MMWS_Size,d0			; multiply offset by segment size

		move.w	EMM_ScrollSlot,d5		; get scroll slot to d5
		swap	d5				; swap
		move.w	EMM_ScrollSlot,d5		; same for FG
		move.l	#$01000100,d4			; get slot 2 offset

.rloop		move.l	d5,d3				; copy slot
		tst.b	3(a2)				; check if loaded
		beq.s	.s1				; if so, render another way
		add.l	d4,d3				; goto slot 2

.s1		move.w	(a2),d1				; get slot offset
		lea	(a0,d1.w),a1			; get right data

	rept MMWS_Size
		move.l	d3,(a1)+			; write plane data
	endm

	;	moveq	#$80|3,d2			; write full plane
	;	cmp.w	(a2),d0				; check if we want to overwrite this one
	;	beq.s	.wr				; if is, branch
		move.b	2(a2),d2			; get data to write

.wr		movea.l	EMM_WindowSlot,a1		; load window buffer
		lea	1(a1,d1.w),a1			; get right data

	rept MMWS_Size
		move.b	d2,(a1)				; save the right black line
		addq.w	#4,a1				; and skip over worthless thrash data
	endm
		addq.w	#4,a2				; goto next obj
		dbf	d6,.rloop			; render em all
		rts
