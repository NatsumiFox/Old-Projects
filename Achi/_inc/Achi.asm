AchiTtlTimer =	2*60

BuildAchi:
		tst.w	Achi_VRAM.w		; check if VRAM is 0
		bne.s	Achi_Process		; if not, branch
		tst.b	Achievements.w		; check if anything here
		bne.s	@found			; branch if so
		rts

@found		move.w	#$1C0,Ach_Xpos.w	; reset xpos
		move.w	#$110,Achi_TgtX.w	; reset xpos
		move.w	#AchiTtlTimer,Ach_Timer.w; reset timer
		move.w	#$F000,Achi_VRAM.w	; set VRAM
		move.l	#AchiHead-32,Ach_TextAddr2.w; get achi text

		moveq	#0,d0
		move.b	Achievements.w,d0	; get ID
		add.w	d0,d0			; double ID
		lea	AchiArr-2(pc),a0	; get data
		add.w	d0,a0			; get to right offset
		add.w	(a0),a0			; add offset to get the actual data
		move.l	a0,Ach_TextAddr.w	; save archievement data

	; load end graphic
		move.l	#Unc_Achi_End,d1
		move.w	#vram_check,d2
		move.w	#4*16,d3
		jmp	QueueDMATransfer

Achi_Process:
	; check mode
		tst.w	Ach_Timer.w		; check if timer has expired
		beq.w	Achi_MoveBack		; if so, move back
		cmp.w	#$1C0,Achi_TgtX.w	; check if waiting
		beq.w	Achi_Timer		; if so, branch

	; DMA new art
		cmp.w	#$F000+(20*32*2),Achi_VRAM.w; check if DMA done
		bhs.s	@nodma			; if so, branch
		moveq	#0,d1
		move.l	Ach_TextAddr.w,a0	; get text data
		move.b	(a0)+,d1		; get tile
		move.l	a0,Ach_TextAddr.w	; save address back

		lsl.w	#5,d1			; *$20
		add.l	#Unc_Achi,d1		; add art offset
		move.w	Achi_VRAM.w,d2		; get VRAM offset
		add.w	#$20,d2			; goto next tile
		moveq	#$10,d3			; set size
		jsr	QueueDMATransfer	; DMA!

		move.l	Ach_TextAddr2.w,d1	; get achievement data
		add.w	#32,d1			; next tile
		move.l	d1,Ach_TextAddr2.w	; save new addr

		move.w	Achi_VRAM.w,d2		; get VRAM offset
		moveq	#$10,d3			; set size
		jsr	QueueDMATransfer	; DMA!
		add.w	#$40,Achi_VRAM.w	; advance VRAM pos

@nodma		subq.w	#6,Ach_Xpos.w		; move stuff
		move.w	Achi_TgtX.w,d0		; get target x
		cmp.w	Ach_Xpos.w,d0		; check current x
		ble.w	Achi_Render		; if does not need moving anymore, dont branch

@nox		move.w	Achi_TgtX.w,Ach_Xpos.w	; force x-pos
		move.w	#$1C0,Achi_TgtX.w	; set target x
		move.w	#vram_check,Achi_VRAM.w	; set new VRAM target
		move.l	#Unc_Achi_End,Ach_TextAddr2.w; set end piece
		bra.w	Achi_Render		; render
; ===========================================================================

Achi_Timer:
		subq.w	#1,Ach_Timer.w		; sub 1 from timer
		btst	#0,Ach_Timer+1.w	; check if even or odd delay
		bne.s	Achi_Render		; branch if odd
		move.w	Ach_Timer.w,d0		; get timer to d0
		cmp.w	#AchiTtlTimer-(10*2),d0	; check if check mark animation is done
		bge.s	@dma			; if not, dma
		cmp.w	#(5*2),d0		; check if we should do the out animation
		bge.s	Achi_Render		; if not, branch

@dma		move.l	Ach_TextAddr2.w,d1	; get achievement data
		add.w	#32*4,d1		; next tiles
		move.l	d1,Ach_TextAddr2.w	; save new addr

		move.w	Achi_VRAM.w,d2		; get VRAM offset
		moveq	#$10*4,d3		; set size
		jsr	QueueDMATransfer	; DMA!

		; timer automatically get checked against 0

Achi_Render:
		move.w	Ach_Xpos.w,d0		; get x-pos
		move.w	#$136,d1
		moveq	#0,d5
		moveq	#6-1,d4
		lea	Achi_Map(pc),a1		; load map
		jmp	DrawSpritePiece(pc)
; ===========================================================================

Achi_MoveBack:
		move.w	Achi_TgtX.w,d0		; get target x
		cmp.w	Ach_Xpos.w,d0		; check current x
		ble.s	@clear			; if does not need moving anymore, branch
		addq.w	#6,Ach_Xpos.w		; move stuff
		bra.s	Achi_Render

@clear		lea	Achievements.w,a0	; get achi to a0
		lea	1(a0),a1		; and get 1 byte over to a1
		move.b	(a1)+,(a0)+		; shift up
		move.b	(a1)+,(a0)+		; shift up
		move.b	(a1)+,(a0)+		; shift up
		clr.b	(a0)+			; clear last entry
		clr.w	Achi_VRAM.w		; clear VRAM
		rts

Achi_Map:
	dc.w $5, $8000|(vram_check/32), $0000
	dc.w $D, $8780, $0010
	dc.w $D, $8788, $0030
	dc.w $D, $8790, $0050
	dc.w $D, $8798, $0070
	dc.w $D, $87A0, $0090
; ===========================================================================
acht	macro text
	if strlen(\text)>20
		inform 2,"STR len was %d!", strlen(\text)
	endif

	achs \text
	dcb.b 20-strlen(\text), $0C
    endm

achs	macro txt
ct =	0
	rept narg
lc =	0
	rept strlen(\txt)
cc 	substr lc+1,lc+1,\txt
arg =	'\cc'
		achc arg
lc =	lc+1
ct =	ct+1
	endr
	shift
	endr
    endm

achc	macro c
	if \c=' '
		dc.b $0C
	elseif \c='['
		dc.b $0A
	elseif \c=']'
		dc.b $0B
	elseif \c=','
		dc.b $41
	elseif \c='.'
		dc.b $42
	elseif \c='-'
		dc.b $43
	elseif \c='_'
		dc.b $44
	elseif \c='='
		dc.b $45
	elseif \c='"'
		dc.b $46
	elseif \c='?'
		dc.b $47
	elseif \c='!'
		dc.b $48
	elseif \c="'"
		dc.b $49
	elseif \c='*'
		dc.b $4A

	elseif (\c>='0')&(\c<='9')
		dc.b \c-'0'

	elseif (\c>='A')&(\c<='Z')
		dc.b \c-'A'+$D

	elseif (\c>='a')&(\c<='z')
		dc.b \c-'a'+$27
	endif
    endm
; ===========================================================================

AchiArr:	dc.w @ree1-AchiArr, @ree2-AchiArr-2, @ree3-AchiArr-4, @ree4-AchiArr-6
		dc.w @hid1-AchiArr-8, @hid2-AchiArr-10, @hid3-AchiArr-12, @hid4-AchiArr-14
		dc.w @invin-AchiArr-16, @ristar-AchiArr-18, @featur-AchiArr-20, @oma-AchiArr-22
		dc.w @sprun-AchiArr-24, @tas-AchiArr-26, @lms-AchiArr-28, @easteg-AchiArr-30
		dc.w @sfr-AchiArr-32, @afk-AchiArr-34, @l42-AchiArr-36, @wrap-AchiArr-38
		dc.w @move-AchiArr-40, @cmd-AchiArr-42, @cmu-AchiArr-44, @jump-AchiArr-46
		dc.w @enemy-AchiArr-48, @wair-AchiArr-50, @act-AchiArr-52, @kenemy-AchiArr-54
		dc.w @roll-AchiArr-56, @rings1-AchiArr-58, @ring10-AchiArr-60, @rin100-AchiArr-62
		dc.w @hidpt-AchiArr-64, @rr1-AchiArr-66, @bgring-AchiArr-68, @seact-AchiArr-70
		dc.w @boss-AchiArr-72, @r69-AchiArr-74, @bosss-AchiArr-76, @death-AchiArr-78
		dc.w @gmov-AchiArr-80, @speed-AchiArr-82, @invins-AchiArr-84, @airtim-AchiArr-86
	;	dc.w @pause-AchiArr-88;, @speed-AchiArr-90, @invins-AchiArr-92, @airtim-AchiArr-94

	opt m+
@ree1	acht "Red Coins, Act 1"
@ree2	acht "Red Coins, Act 2"
@ree3	acht "Red Coins, Act 3"
@ree4	acht "Red Coins, Act 4"
@hid1	acht "Hidden Points, Act 1"
@hid2	acht "Hidden Points, Act 2"
@hid3	acht "Hidden Points, Act 3"
@hid4	acht "Hidden Points, Act 4"
@cmd	acht "Moved camera down!"
@cmu	acht "Moved camera up!"
@l42	acht "42 = Meaning of life"
@seact	acht "Found secret act!"
@bosss	acht "Beat the secret boss"
@gmov	acht "You slippin' fool!"
@death	acht "Don't make lemonade!"
@invins	acht ""
@speed	acht "Fastest thing alive."
@airtim	acht "Airtime Anonymous"
@bgring	acht "WHERE DID SONIC GO?!"
@rings1	acht "You collected a ring"
@ring10	acht "You've got 10 rings"
@rin100	acht "You've got 100 rings"
@hidpt	acht "Found a hidden point"
@rr1	acht "Found a red ring!"
@ristar	acht "You're the Ring Star"
@r69	acht "olololol it's 69!!!1"
@sprun	acht "Speedrun strats"
@featur	acht "Owned by the feature"
@oma	acht "Master of Omachao"
@tas	acht "You're dirty cheater"
@lms	acht "Last second"
@easteg	acht "Literal Easter Egg"
@wrap	acht "Slow screen scroller"
@afk	acht "Away from keyboard"
@invin	acht "When ones not enough"
@boss	acht "Beat the boss"
@sfr	acht "Gotta try all things"
@roll	acht '"""Spin attack"""'
@enemy	acht "Ouch, that hurts!"
@wair	acht "Walking on air!"
@act	acht "Sonic went left"
@kenemy	acht "That's how you do it"
@move	acht "Succesfully advanced"
@jump	acht "Jump mode activated!"
	even
	opt m-
AchiHead:	incbin "artunc/achi text.unc"
