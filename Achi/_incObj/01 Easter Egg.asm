LiteralEasterEgg:
		move.l	#@check,(a0)
		move.l	#@map,obMap(a0)
		move.w	#$D000/32,obGfx(a0)
		move.b	#4,obRender(a0)
	display		2, a0

		move.b	#8,obActWid(a0)
		clr.b	$3F(a0)			; art not loaded
		move.w	obY(a0),$3C(a0)		; copy ypos

@check		tst.b	obRender(a0)		; check if visible
		bpl.s	@display		; if no, branch
		move.l	#@display,(a0)
	ac	ac_EasterEgg, a1
		jsr	UpdateSRAM.w

@display	out_of_range.w	@delete
		tst.b	obRender(a0)		; check if visible
		bpl.s	@checkunload		; if no, branch

		move.b	$3E(a0),d0
		jsr	CalcSine
		asr.w	#6,d0
		add.w	$3C(a0),d0
		move.w	d0,obY(a0)
		addq.b	#2,$3E(a0)

		tst.b	$3F(a0)			; check if loaded
		bne.s	@di			; if not, branch

		st	$3F(a0)			; set as loaded
		move.l	#Unc_Egg,d1
		move.w	#$D000,d2
		move.w	#filesize("artunc\egg.unc")/2,d3
		jsr	QueueDMATransfer
		bra.s	@di

@checkunload	tst.b	$3F(a0)			; check if loaded
		beq.s	@di			; if is, branch
		cmp.w	#$300,v_screenposy.w	; check if camera y-pos is low enuf
		bgt.s	@di			; if no, skip
		sf	$3F(a0)			; set as unloaded
		moveq	#plcid_Main2,d0
		jsr	AddPLC			; load monitor patterns

@di	NEXT_OBJ

@delete		moveq	#plcid_Main2,d0
		jsr	AddPLC			; load monitor patterns
		jmp	DeleteObject2		; delete

@map	include "_maps/egg.asm"
