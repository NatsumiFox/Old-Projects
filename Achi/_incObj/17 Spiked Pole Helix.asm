; ---------------------------------------------------------------------------
; Object 17 - helix of spikes on a pole	(GHZ)
; ---------------------------------------------------------------------------

Helix:

hel_frame:	equ $3E		; start frame (different for each spike)

;		$29-38 are used for child object addresses
; ===========================================================================

Hel_Main:	; Routine 0
		move.l	#Hel_Action,(a0)
		move.l	#Map_Hel,obMap(a0)
		move.w	#$4398,obGfx(a0)
		move.b	#7,obStatus(a0)
		move.b	#4,obRender(a0)
	display		3, a0
		move.b	#8,obActWid(a0)
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		lea	obSubtype(a0),a3 ; move helix length to a2
		moveq	#0,d1
		move.b	(a3),d1		; move helix length to d1
		move.b	#0,(a3)+	; clear subtype
		move.w	d1,d0
		lsr.w	#1,d0
		lsl.w	#4,d0
		sub.w	d0,d3		; d3 is x-axis position of leftmost spike
		subq.b	#2,d1
		bcs.w	Hel_Action	; skip to action if length is only 1
		moveq	#0,d6

Hel_Build:
		bsr.w	FindFreeObj
	;	bpl.s	Hel_Action
		addq.b	#1,obSubtype(a0)
		moveq	#0,d5
		move.w	a1,d5
		subi.w	#v_objspace,d5
		divu	#size,d5
		move.b	d5,(a3)+	; copy child address to parent RAM
		move.l	#Hel_Display,(a1)
		move.w	d2,ObY(a1)
		move.w	d3,obX(a1)
		move.l	obMap(a0),obMap(a1)
		move.w	#$4398,obGfx(a1)
		move.b	#4,obRender(a1)
	display		3, a1
		move.b	#8,obActWid(a1)
		move.b	d6,hel_frame(a1)
		addq.b	#1,d6
		andi.b	#7,d6
		addi.w	#$10,d3
		cmp.w	obX(a0),d3	; is this spike in the centre?
		bne.s	Hel_NotCentre	; if not, branch

		move.b	d6,hel_frame(a0) ; set parent spike frame
		addq.b	#1,d6
		andi.b	#7,d6
		addi.w	#$10,d3		; skip to next spike
		addq.b	#1,obSubtype(a0)

	Hel_NotCentre:
		dbf	d1,Hel_Build ; repeat d1 times (helix length)

Hel_Action:	; Routine 2, 4
		bsr.s	Hel_RotateSpikes
		bra.w	Hel_ChkDel

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Hel_RotateSpikes:
		move.b	(v_ani0_frame).w,d0
		clr.b	obColType(a0) ; make object harmless
		add.b	hel_frame(a0),d0
		andi.b	#7,d0
		move.b	d0,obFrame(a0)	; change current frame
		bne.s	locret_7DA6
		move.b	#$84,obColType(a0) ; make object harmful
		jmp	AddToCollList
; ===========================================================================

Hel_ChkDel:
		out_of_range	Hel_DelAll
	NEXT_OBJ
locret_7DA6:
		rts
; ===========================================================================

Hel_DelAll:
		moveq	#0,d2
		lea	obSubtype(a0),a3 ; move helix length to a2
		move.b	(a3)+,d2	; move helix length to d2
		subq.b	#2,d2
		bcs.s	Hel_Delete

	Hel_DelLoop:
		moveq	#0,d0
		move.b	(a3)+,d0
		mulu	#size,d0
		addi.w	#v_objspace,d0
		movea.w	d0,a1		; get child address
		bsr.w	DeleteChild	; delete object
		dbf	d2,Hel_DelLoop ; repeat d2 times (helix length)

Hel_Delete:	; Routine 6
		bra.w	DeleteObject2
; ===========================================================================

Hel_Display:	; Routine 8
		bsr.w	Hel_RotateSpikes
	NEXT_OBJ
