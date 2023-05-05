Credits:
		move.l	#Kos_Credits,FanficShit.w
		move.w	#($118/4)-29,FanficShit+4.w
		bra.s	CommonShit

FanFic:
		move.l	#Kos_Fanfic,FanficShit.w
		move.w	#($880/4)-29,FanficShit+4.w

CommonShit:
		jsr	TileOut			; tile out display
	di
		move.l	v_scrposy_dup.w,-(sp)	; push screen pos dupe
		lea	vdp_control_port,a6
		lea	-4(a6),a5
		lea	Font1,a0
		jsr	FF_1to4(pc)

	writeVRAM_ a6,$FF0000,$0000,$0C00,VRAM
		jsr	FF_1to4(pc)
	writeVRAM_ a6,$FF0000,$2000,$0C00,VRAM

		moveq	#0,d0
	vdpcomm	move.l,vram_hscroll,VRAM,WRITE,(a6)
		move.l	d0,(a5)
	vdpcomm	move.l,vram_sprites,VRAM,WRITE,(a6)
		move.l	d0,(a5)
	vdpcomm	move.l,0,CRAM,WRITE,(a6)
		move.l	#$0EEE0000,(a5)	; white

	vdpcomm	move.l,$60*32,VRAM,WRITE,(a6)
		move.w	#$2000/4-1,d1

	rept 32/4
		move.l	d0,(a5)
	endr

	vdpcomm	move.l,$E000,VRAM,WRITE,(a6)
		move.w	#$1000/4-1,d1
		move.l	#$00600060,d0

@clear		move.l	d0,(a5)
		dbf	d1,@clear
		move.l	#$8B008700,(a6)		; set hscroll to 1 long and bg color

		lea	$FF0000,a1
		move.l	FanficShit.w,a0
		jsr	KosDec
		lea	-4(a6),a5

		moveq	#29-1,d7		; do 29 lines
		moveq	#0,d6			; clear y-pos

@draw		bsr.w	FanfDrawLine		; draw this line
		addq.w	#8,d6			; next line
		dbf	d7,@draw		; draw all lines

@waitl		move.w	4(a6),d0		; check line
		cmp.w	#206<<8,d0		; check if correct line
		blo.s	@waitl			; if no, branch
		cmp.w	#210<<8,d0		; check if correct line
		bhi.s	@waitl			; if no, branch

		moveq	#0,d7
		move.l	d7,v_scrposy_dup.w	; save new screen dup
		jsr	TileIn			; tile in display

@main		move.b	#$18,(v_vbla_routine).w	; delay
		jsr	WaitForVBla

		btst	#0,v_jpadhold1.w	; check if up is pressed
		beq.s	@noup			; if not, branch
		tst.w	d7			; check if y-pos = 0
		beq.s	@noup			; if so, skip

		move.w	d7,d6			; copy pos
		lsr.w	#3,d6			; get tile offset
		subq.w	#6,d7			; update y-pos
		move.w	d7,v_scrposy_dup.w	; save new screen dup

		move.w	d7,d0			; copy to d0
		lsr.w	#3,d0			; get tile offset
		cmp.w	d0,d6			; check if tile changed
		beq.s	@noup			; if not, branch

		move.w	d7,d6			; copy d7 to d6
		subq.w	#8,d6			; render 1 tile above
		bsr.w	FanfDrawLine		; draw this line

@noup		btst	#1,v_jpadhold1.w	; check if up is pressed
		beq.s	@nodwn			; if not, branch
		move.w	d7,d6			; copy y-pos
		lsr.w	#3,d6			; divide by a tile
		cmp.w	FanficShit+4.w,d6	; check if we can move down
		bhi.s	@nodwn

		addq.w	#6,d7			; update y-pos
		move.w	d7,v_scrposy_dup.w	; save new screen dup

		move.w	d7,d0			; copy to d0
		lsr.w	#3,d0			; get tile offset
		cmp.w	d0,d6			; check if tile changed
		beq.s	@nodwn			; if not, branch

		move.w	d7,d6			; copy d7 to d6
		add.w	#28*8,d6		; advance to bottom of screen
		bsr.w	FanfDrawLine		; draw this line

@nodwn		tst.b	v_jpadpress1.w		; check if start is pressed
		bpl.s	@main			; if not, branch

		jsr	TileOut			; tile out display
		move.l	(sp)+,v_scrposy_dup.w	; pop screen pos dupe
		move.l	#$8B038720,(a6)		; set hscroll to 1 long and bg color

	; decompress the GHZ art
		lea	Nem_GHZ_1st,a1
		moveq	#0,d2
		jsr	QueueKosM

@wait		move.b	#$16,(v_vbla_routine).w
		jsr	ProcKos
		jsr	WaitForVBla
		jsr	ProcKosM

		tst.b	KosMmodNum.w		; check if we are loading
		bne.s	@wait			; if are, branch

	di
		cmp.b	#4,v_gamemode.w		; check if title
		beq.s	@ttl
		lea	(Blk256_GHZ).l,a0 ; load GHZ 256x256 mappings
		lea	(v_256x256).l,a1
		jsr	KosDec
		jsr	LoadTilesFromStart
		bra.s	@ct

@ttl		moveq	#0,d0
		move.w	#$1000/4-1,d1
		lea	vdp_control_port,a6
		lea	-4(a6),a5
	vdpcomm	move.l,$C000,VRAM,WRITE,(a6)	; write maps

@lnloop		move.l	d0,(a5)			; write tile1
		dbf	d1,@lnloop		; loop fro all tiles

		lea	(vdp_control_port).l,a5
		lea	(vdp_data_port).l,a6
		lea	(v_bgscreenposx).w,a3
		lea	(v_lvllayout+$40).w,a4
		move.w	#$6000,d2
		jsr	DrawChunks

		lea	($FF0000).l,a1
		lea	(Eni_Title).l,a0 ; load	title screen mappings
		move.w	#0,d0
		jsr	EniDec

		copyTilemap	$FF0000,$C206,$21,$15,0

@ct		move.b	#$16,(v_vbla_routine).w
		jsr	WaitForVBla
		jmp	TileIn			; tile in display
; ===========================================================================

FanfDrawLine:
		move.w	d6,d4			; copy y-pos
		lsr.w	#1+3,d4			; halve and divide by 8
		mulu	#38,d4			; 40 bytes per line
		moveq	#-1,d5			; prepare FFFFxxxx
		move.w	d4,d5			; get total RAM addr
		move.l	d5,a0			; <- a0 contains text data now

		moveq	#0,d0			; clear text data
		btst	#3,d6			; check if doing odd line
		beq.s	@even			; if no, branch
		bset	#8,d0			; else add $100

@even		move.w	d6,d1			; get y-pos
		and.w	#$1F*8,d1		; get index on the plane
		lsl.w	#4,d1			; 64x vertical offset
		or.w	#$4000,d1		; VRAM WRITE
		swap	d1			; swap words
		move.w	#3,d1			; $C000 + VRAM WRITE
		move.l	d1,(a6)			; set VRAM WRITE mode

		move.w	#$5F,(a5)		; clear
		moveq	#38-1,d1		; set loop counter

@map		move.b	(a0)+,d0		; get next tile
		move.w	d0,(a5)			; write to plane
		dbf	d1,@map			; loop

		move.w	#$5F,(a5)		; clear
		rts
; ===========================================================================

FF_1to4:
		lea	$FF0000,a1	; get RAM to a1
		move.w	#768-1,d0	; get rept ct

@loop		moveq	#0,d1
		move.b	(a0)+,d1	; get next byte
		move.w	d1,d2		; copy to d2

		lsr.b	#4,d2		; shift right d2
		add.w	d2,d2		; double for lut
		move.w	@lut(pc,d2.w),(a1)+; save word value from lut

		and.w	#$F,d1		; get 4 bits only
		add.w	d1,d1		; double d1
		move.w	@lut(pc,d1.w),(a1)+; save word value from lut
		dbf	d0,@loop	; keep a-looping
		rts

@v =	0
@lut	rept $10
		dc.w ((@v&8)<<9)|((@v&4)<<6)|((@v&2)<<3)|(@v&1)
@v =		@v+1
	endr
; ===========================================================================
