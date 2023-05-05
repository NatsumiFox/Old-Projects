; ---------------------------------------------------------------------------
; Subroutine to find a free object space

; output:
;	a1 = free position in object RAM
;	pl = not found (n bit not set!)
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

FindNextFreeObj:
FindFreeObj:	; 130 cycles to load, 48 cycles to not load
		move.w	Free_Head.w,a1		; get next free obj addr
		cmp.w	#0,a1			; check if address is tail
		beq.s	@rts			; if is, then can not load
		move.w	prev(a1),Free_Head.w	; save next free slot back

		move.w	ObjPrev_Tail.w,a2	; get last object of ever
		move.w	a1,next(a2)		; set the next object to this
		move.w	a1,ObjPrev_Tail.w	; also set new tail
		move.w	#Obj_Tail,next(a1)	; set the next obj to run
		move.w	a2,prev(a1)		; set prev obj
@rts		rts
