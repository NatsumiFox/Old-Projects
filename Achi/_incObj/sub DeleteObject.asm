; ---------------------------------------------------------------------------
; Subroutine to	delete an object
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


DeleteObject2:	; delete object and call next object
		move.w	a0,a1			; copy a0 to a1
		move.w	next(a0),a0		; load object here already
		bsr.s	DeleteChild		; delete its and fix ptrs
		move.l	(a0),a1			; get its routine
		jmp	(a1)			; jump

DeleteObject:
		move.w	a0,a1			; copy a0 to a1

DeleteChild:				; child objects are already in (a1)
	undisplayck	a1			; remove from display lists

; old method: 116 cycles
;		move.w	prev(a1),a2
;		move.w	next(a1),next(a2)	; transfer next obj ptr
;		move.w	next(a1),a2
;		move.w	prev(a1),prev(a2)	; transfer prev obj ptr

;		move.w	Free_Head.w,prev(a1); get the head of the free list to next of this object
;		move.w	a1,Free_Head.w		; save as the new head

;		move.l	d1,(a1)			; clear routine
;		addq.w	#obX,a1			; skip to obx

; new method: 92 cycles

		addq.w	#prev,a1		; skip to prev ptr
		move.w	(a1)+,a2		; copy pointer to a2
		move.w	(a1),next(a2)		; copy next ptr over
		move.w	(a1)+,a2		; get next obj
		move.w	-4(a1),prev(a2)		; copy prev ptr

		move.w	Free_Head.w,-4(a1)	; get the head of the free list to next of this object
		move.w	a1,Free_Head.w		; save as the new head
		subq.w	#dnext,Free_Head.w	; fix free head
		moveq	#0,d1

	rept (size-dnext)/4
		move.l	d1,(a1)+		; clear single long
	endr

	if (size-dnext)&2
		move.w	d1,(a1)
	endif
		rts
