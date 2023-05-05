RedCoins:
		move.b	obSubtype(a0),d0	; get subtype
		btst	d0,RedCoinBits.w	; check if collected
		bne.w	DeleteObject2		; if so, delete

		move.l	#@ani,(a0)		; load ring object
		move.w	obX(a0),$32(a0)
		move.l	#Map_Ring,obMap(a0)
		move.w	#$7B2,obGfx(a0)
		move.b	#4,obRender(a0)
	display		2, a0
		move.b	#$47,obColType(a0)
		move.b	#8,obActWid(a0)

@ani		move.b	(v_ani1_frame).w,obFrame(a0) ; set frame
		tst.b	obRoutine(a0)
		bne.s	@collect

		out_of_range.w	DeleteObject2
		jsr	AddToCollList
	NEXT_OBJ

@collect	clr.b	obColType(a0)
		clr.b	obRoutine(a0)
	chdisplay	1, a0
		move.l	#Ring_Sparkle,a1
		move.l	a1,(a0)

		move.b	obSubtype(a0),d0	; get subtype
		bset	d0,RedCoinBits.w	; set the coin bit
	; BORK	sfx	sfx_RedCoin,0,0,0

	ac	ac_RedCC,a6
		cmp.b	#$FF,RedCoinBits.w	; check if all are collected
		bne.s	@jump			; if not, jump out of the window
		move.b	v_act.w,d0		; get act num
	ac2	ac_RedCoins,a6

@jump		jsr	UpdateSRAM.w
		jmp	(a1)
