SRAM =	$200000
	rsset SRAM
wInitStr	rs.b 64
wComm		rs.b 8
wLives		rs.b 1
wAct		rs.b 1
wAcData		rs.b (ACLEN/8)+1

UpdateSRAM:
		move.l	a0,-(sp)		; storeaway regs
		move.b	#1,$A130F1		; enable sram
		lea	wComm,a0		; get this shit
		move.l	mComm.w,(a0)+		; save comm bits
		move.l	mComm+4.w,(a0)+		; save comm bits 2
		move.b	v_lives.w,(a0)+		; copy lives
		move.b	v_act.w,(a0)+		; copy act

@len =	(ACLEN/8)+1
@pos =	0
	rept @len/4
		move.l	AchiBits+@pos.w,(a0)+	; copy data
@pos =		@pos+4
	endr

	if (@len&2)<>0
		move.w	AchiBits+@pos.w,(a0)+	; copy data
@pos =		@pos+2
	endif

	if (@len&1)<>0
		move.b	AchiBits+@pos.w,(a0)+	; copy data
	endif

		move.b	#0,$A130F1		; disable sram
		move.l	(sp)+,a0		; gets regs
		rts

LoadSRAM:
		move.b	#1,$A130F1		; enable sram
		lea	SRAM,a0			; get SRAM to a0
		lea	InitSRAM(pc),a1		; load init str

	rept 64/4
		cmpm.l	(a0)+,(a1)+		; check if strings match
		bne.w	ResetSRAM		; if no, reset
	endr

		move.l	(a0)+,mComm.w		; load comm bits
		move.l	(a0)+,mComm+4.w		; load comm bits 2
		move.b	(a0)+,v_lives.w		; load lives
		bgt.s	@correct		; check if Sonic has negative or 0 lives

@reset		move.b	#3,-1(a0)		; reset lives
		move.b	#3,v_lives.w		; ''
		clr.b	(a0)			; reset act

@correct	move.b	(a0),v_act.w		; load act
		cmp.b	#3,(a0)+		; check if valid
		bls.s	@actvalid		; if is, branch
		subq.w	#1,a0			; fix ptr
		bra.s	@reset			; reset shit

@actvalid

@len =	(ACLEN/8)+1
@pos =	0
	rept @len/4
		move.l	(a0)+,AchiBits+@pos.w	; load data
@pos =		@pos+4
	endr

	if (@len&2)<>0
		move.w	(a0)+,AchiBits+@pos.w	; load data
@pos =		@pos+2
	endif

	if (@len&1)<>0
		move.b	(a0)+,AchiBits+@pos.w	; load data
	endif
		move.b	#0,$A130F1		; disable sram
		rts

InitSRAM:	dc.b "oh no"

ResetStrSRAM:
		lea	SRAM,a0			; get SRAM to a0
		lea	InitSRAM(pc),a1		; load init str

	rept 64/4
		move.l	(a1)+,(a0)+		; copy string
	endr
		rts

ResetSRAM:
		bsr.s	ResetStrSRAM		; reset SRAM STR

		clr.l	(a0)+
		clr.l	(a0)+
		clr.l	mComm+4.w
		clr.l	mComm.w

		moveq	#0,d0
		move.w	#$0300,(a0)+		; save lives and act
		move.b	#3,v_lives.w		; save lives ctr
		move.b	d0,v_act.w		; clear act

@len =	(ACLEN/8)+1
@pos =	0
	rept @len/4
		move.l	d0,AchiBits+@pos.w	; clear data
		move.l	d0,(a0)+		; clear data
@pos =		@pos+4
	endr

	if (@len&2)<>0
		move.w	d0,AchiBits+@pos.w	; clear data
		move.w	d0,(a0)+		; clear data
@pos =		@pos+2
	endif

	if (@len&1)<>0
		move.b	d0,AchiBits+@pos.w	; clear data
		move.b	d0,(a0)+		; clear data
	endif
		move.b	d0,$A130F1		; disable sram
		rts
