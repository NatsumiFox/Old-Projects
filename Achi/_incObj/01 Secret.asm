SecretPoints:
		move.b	obSubtype(a0),d0	; get subtype
		bmi.s	@ok			; branch if positive
		btst	d0,HiddenBits.w		; check if collected
		bne.w	DeleteObject2		; if so, delete

@ok		move.l	#@check,(a0)
		move.b	#$47,obColType(a0)
		move.b	#$80,obRender(a0)	; HAX

@check		tst.b	obRoutine(a0)
		bne.s	@collect

		out_of_range.w	DeleteObject2
		jsr	AddToCollList
	NEXT_OBJ

@collect	move.b	obSubtype(a0),d0	; get subtype
		bpl.s	@nofan			; branch if positive
		move.l	a0,-(sp)
		jsr	FanFic
		move.l	(sp)+,a0
		jmp	DeleteObject2(pc)	; delete object

@nofan		bset	d0,HiddenBits.w		; set the coin bit
		move.b	HiddenBits.w,d1		; get bits
		moveq	#0,d2			; reset ctr
		moveq	#5-1,d0			; dbf ctr

.chk		btst	d0,d1			; check if bit be set yo
		sne	d3			; set d3 if bit set
		sub.b	d3,d2			; add 1 if bit set
		dbf	d0,.chk			; keep checkin'

		move.b	d2,mComm+7.w		; set 7th command byte to amount of hidden points collected
	; BORK	sfx	sfx_Hidd,0,0,0
	ac	ac_HidPt1,a6

		cmp.b	#$1F,HiddenBits.w	; check if all are collected
		bne.s	@jump			; if not, jump out of the window
		move.b	v_act.w,d0		; get act num
	ac2	ac_HidPts,a6

@jump		jsr	UpdateSRAM.w
		jmp	DeleteObject2(pc)
