; ===========================================================================
; ---------------------------------------------------------------------------
; Scroll Data - Mushroom Hill Zone Act 1
; ---------------------------------------------------------------------------

		tst.b	1(a2)			; check if we have a delay
		bmi.s	.nodelay		; if not, skip
		subq.b	#1,1(a2)		; decrease delay ctr
		bpl.s	.rts			; if positive, do not end
		tst.b	(a2)			; check speed
		bne.s	.neg			; if not 0, negate

		st	(a2)			; set speed to $FF
.neg		neg.b	(a2)			; negate speed

.nodelay	moveq	#0,d2			; clear d0
		move.b	(a2),d0			; load speed to d0
		bpl.s	.back			; if going forwards, branch
		move.w	#-192,d2		; check for max pos

.back		move.w	2(a2),d1		; load position to d1
		cmp.w	d2,d1			; check if max pos
		bne.s	.move			; if not, branch
		move.b	#8-1,1(a2)		; load stop amount
.rts		rts

.move		ext.w	d0			; extend to word
		add.w	d0,2(a2)		; add speed to position

		move.w	d1,d0			; copy position to d0
		swap	d0			; get BG pos to d0.w
		lsr.w	#2,d1			; move bg at quarter speed
		move.w	d1,d0			; load bg pos
		jmp	(WriteScroll-($100*2))	; write scroll data (100 scanlines)

; ===========================================================================
