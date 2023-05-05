offtbl	macro offs
_offtbl = offset(\offs)
	endm

ote	macro offs
	dc.\0	\offs-_offtbl
	endm

fontptr	macro char
	rept narg
		ote.w Font_Char_\char
		shift
	endr
	endm

fontch	macro char
	rept narg
Font_Char_\char	incbin "dat/font/font/\char\.dat"
		even
		shift
	endr
	endm
; ===========================================================================

Vint_Fanfic:
		movem.l	d0-a6,-(sp)
		jsr	ReadController.w	; read controller input
	vdpcomm move.l,0,VSRAM,WRITE,4(a6)	; set VSRAM WRITE to 0
		move.w	-2.w,(a6)		; y-pos

		jsr	S1_SndDrv		; run sound driver
		movem.l	(sp)+,d0-a6
		rte
; ===========================================================================
	; write text to buffer
LoadNameList:
		lea	$FF0000.l,a1
		move.w	#24*14*32/4,d0
		moveq	#0,d1

.clr		move.l	d1,(a1)+
		dbf	d0,.clr

		moveq	#0/2,d0			; set x-position
		moveq	#2,d1			; set y-position
		move.w	#192/2,d6		; set width
		move.w	#112,d7			; set height
		lea	.text(pc),a0		; get text ptr to a0
		lea	$FF0000.l,a1		; get output buffer to a1
		jsr	WriteTextToBuffer(pc)	; slot text to output buffer

	; DMA art
		move.l	VDP_Control_Port.w,a5
	dma68kToVDP $FF0000,$4820,24*14*32,VRAM
		rts

.text	dc.b "SONIC THE HEDGEHOG", $0A
	dc.b "SONIC THE HEDGEHOG 2", $0A
	dc.b "SONIC THE HEDGEHOG 3", $0A
	dc.b "SONIC & KNUCKLES", $0A
	dc.b "SONIC 3 & KNUCKLES", $0A
	dc.b "SONIC 2 & KNUCKLES", $0A
	dc.b "BLUE SPHERES", $00
	even
; ===========================================================================

WriteFanficOnScreen:
		jsr	ClearScreen.w
		lea	S1_Z80Drv,a0
		jsr	S1_SndDrvLoad
		move.b	#FanDat-ROMdat,-4.w	; set main int
		move.l	#$380000,$FFFFFFC4.w

		moveq	#0,d0
		move.l	VDP_Control_Port.w,a5	; get VDP control port to a5
		move.l	VDP_Data_Port.w,a6	; get VDP data port to a6
	vdpcomm	move.l,$F800,VRAM,WRITE,(a5)	; clear sprites
		move.l	d0,(a6)
		move.l	d0,(a6)

	vdpcomm	move.l,0,CRAM,WRITE,(a5)	; write palette
		move.l	#$EEE,(a6)		; white for font
		move.l	#$0AAA0666,(a6)		; white for font
	rept $80/4-2
		move.l	d0,(a6)
	endr

	dmaFillVRAM 0,$0000,$4000,1

		lea	$FFFF8000.w,a1		; prepare buffer to read from
		moveq	#80-1,d0		; write 80 tiles
		moveq	#0,d1
.tileclrloop
	rept 32/4				; clear 32 bytes at once
		move.l	d1,(a1)+		; clear pixels
	endr
		dbf	d0,.tileclrloop		; write all the tiles

		lea	FanFicText,a0		; get fanfic text to a0
		lea	-4(a5),a6

		move.l	#$00010002,d0		; tiles 0 and 1
		move.l	#$00020002,d1		; add 2 tiles each pass
		moveq	#32-1,d2		; 32 vertical tiles
	vdpcomm move.l,$C000,VRAM,WRITE,d4	; set command for current cursor
		move.l	#$00800000,d3		; set the addition for next line

.vloop		move.l	d4,(a5)			; set VDP command
		add.l	d3,d4			; next line
	rept 40/2				; 40 tiles horizontally
		move.l	d0,(a6)			; write tiles
		add.l	d1,d0			; next tiles
	endr
		dbf	d2,.vloop		; keep looping til done
		stop	#$2300			; wait for v-int
		move.b	#$96,($FFFFF00A).w	; play music

		clr.w	-2.w			; reset y-pos
.load		bsr.w	.gettext		; get the text we need to write up
		move.w	#29*8,d0		; this is the vertical offset
		bsr.s	.getypos		; get the current y-pos and translate to VRAM ptr
		bsr.s	.writetext		; then write it to VRAM
		add.w	#16,-2.w
		cmp.w	#8*28,-2.w		; check if we have written full screen
		bne.s	.load			; if no, branch

.mainloop	stop	#$2300			; wait for v-int
		btst	#1,$FFFFF604.w		; check if down is pressed
		beq.s	.chkup			; if not, branch
		bsr.w	.gettextdwn		; get the text we need to write up
		move.w	#29*8,d0		; this is the vertical offset
		bsr.s	.getypos		; get the current y-pos and translate to VRAM ptr
		bsr.s	.writetext		; then write it to VRAM
		moveq	#4,d0			; scroll up
		bsr.s	.scrolltext		; scroll the text slowly
		bra.s	.mainloop

.chkup		btst	#0,$FFFFF604.w		; check if up is pressed
		beq.s	.mainloop		; if not, branch
		bsr.w	.gettextup		; get the text we need to write up
		move.w	#30*8,d0		; this is the vertical offset
		bsr.s	.getypos		; get the current y-pos and translate to VRAM ptr
		bsr.s	.writetext		; then write it to VRAM
		moveq	#-4,d0			; scroll down
		bsr.s	.scrolltext		; scroll the text slowly
		bra.s	.mainloop

.scrolltext	add.w	d0,-2.w
	rept 4-1
		stop	#$2300			; wait for v-int
		add.w	d0,-2.w
	endr
		rts

.getypos	moveq	#0,d1			; clear d1
		move.w	-2.w,d1			; copy y-pos
		add.w	d0,d1			; add offset to load from
		andi.w	#$F0,d1			; keep in range of 32 tiles (in increments of 2 tiles)
		mulu.w	#(32*40)/8,d1		; multiple by $500/8 (size of each tile * 40 tiles horizontally)
		add.w	#$20,d1			; tile based on tile 1
		rts				; VRAM ptr is ready

.writetext	lsl.l	#2,d1			; shift 2 bits up (to separate the 2 high bits :v)
		lsr.w	#2,d1			; shift down 2 bits
		swap	d1			; shift words
	vdpcomm	ori.l,0,VRAM,WRITE,d1		; set VRAM WRITE to VRAM address

		lea	$FFFF8000.w,a1		; prepare buffer to read from
		moveq	#80-1,d0		; write 80 tiles
	di
		move.l	d1,4(a6)		; set command
		moveq	#0,d1

.tileloop
	rept 32/4				; write 32 bytes at once
		move.l	(a1),(a6)
		move.l	d1,(a1)+		; clear pixels
	endr
		dbf	d0,.tileloop		; write all the tiles
	ei
		subq.w	#1,a0			; fix the pointer of data
		rts

.1up		subq.w	#1,a0
.x1up		tst.b	-(a0)			; test last byte
		bne.s	.x1up			; loop til 0
		addq.w	#1,a0

		tst.b	(a0)			; case: $FF is end ptr
		bpl.s	.ok			; branch if not case
		addq.w	#4,sp			; pop 2 routines out
		move.l	a2,a0			; return old ptr
		addq.w	#8,sp
		bra.w	.mainloop		; we do not want to move no more

.gettextup	move.l	a0,a2			; copy to a2
		bsr.s	.1up			; get last line
		pea	(a0)			; save as 'current' address for scrolling

		moveq	#14-1,d0		; 28 vertical lines
.gtuloop	bsr.s	.1up			; go up in text
		dbf	d0,.gtuloop		; loop

		bsr.s	.gettext		; then render the text in
		move.l	(sp)+,a0		; return ptr
		addq.w	#1,a0
.ok		rts

.gettextdwn	tst.b	(a0)			; check if this is the end
		bpl.s	.gettext		; if not, render
		addq.w	#8,sp			; go back johnny
		bra.w	.mainloop		; we do not want to move no more

.gettext	moveq	#0/2,d0			; set x-position
		moveq	#0,d1			; set y-position
		move.w	#320/2,d6		; set width
		move.w	#16,d7			; set height
		lea	$FFFF8000.w,a1		; get output buffer to a1
; ===========================================================================
; write variable width text to output buffer
; input:
;   d0 = x position to start writing data to / 2
;   d1 = y position to start writing data to
;   d6 = output buffer width / 2
;   d7 = output buffer height
;   a0 = input data
;   a1 = output data
; output:
;   cc;
;      !N, Z = all letters were put into the buffer
;       N,!Z = not all letters were put into the buffer
;      !N,!Z = an error occurred
; ===========================================================================
FONT_SPACE_WIDTH = 2/2		; the number of pixels between each letter horizontally (excluding width of each letter)
FONT_SPACE_HEIGHT = 16		; the number of pixels between each letter vertically
FONT_WHITESPACE_WIDTH = 6/2	; each whitespace is 4 pixels wide
FONT_TAB_WIDTH = FONT_WHITESPACE_WIDTH*4; each tab is 4x as wide as each space
	rsset 2
ERR_ILLEGAL_CHAR	rs.w 1	; illegal character in input error

WriteTextToBuffer:
	; initial setup
		lea	Font_Pointer_Table(pc),a2
		move.w	d6,d2			; get buffer width to d2
		lsl.w	#3,d2			; multiply by 8

	; main loop
.loop		jsr	GetLetterPtr(pc)	; get pointer to next letter
		move.w	(a3)+,-(sp)		; push the width and height in stack
		bmi.s	.loop			; if width is negative, branch

		moveq	#0,d4
.checkhoriz	move.b	(sp),d4			; get width from stack
		move.w	d6,d5			; copy buffer width to d5
		sub.w	d0,d5			; sub current x-position from d5
		cmp.w	d4,d5			; compare letter width from width left
		bgt.s	.validslotfound		; branch if the vertical slot is valid

.checkverti	add.w	#FONT_SPACE_HEIGHT,d1	; add space height to letter offset
		moveq	#0,d0			; clear x-position
		move.b	1(sp),d4		; get height from stack
		move.w	d7,d5			; copy buffer height to d5
		sub.w	d1,d5			; sub current y-position from d5
		cmp.w	d4,d5			; compare letter height from height left
		bgt.s	.checkhoriz		; branch if the vertical slot is valid

.validslotfound	moveq	#0,d3
		move.b	(sp),d3			; get width of the letter
		move.w	(sp)+,d5		; pop height and width of the letter
		and.w	#$7F,d5			; get only low byte (height)
		movem.w	d0-d1/d4,-(sp)		; push current x and y-position to stack

		cmp.w	d7,d1			; compare y-position of cursor with the height of the plane
		blt.s	.heightok		; branch if there is no room left!
		addq.w	#6,sp			; pop junk from stack
		moveq	#-1,d5			; didn't fit all the letters in
		rts

.heightok	jsr	GetOutputPtr(pc)	; get pointer to output data
		lea	(a4),a5			; store offset to a5
		movem.w	d0/d3,-(sp)		; push width of data and pixel offset

.rowloop	move.b	(a3)+,(a4)+		; write 2 pixels into the buffer
		dbf	d3,.rowcheck		; if we are not done looping, branch
		dbf	d5,.notdone		; if we are not done looping, branch

		addq.w	#4,sp			; pop junk from stack
		movem.w	(sp)+,d0-d1/d4		; pop current x and y-position to stack
		add.w	d4,d0			; add letter width to x-pos
		addq.w	#FONT_SPACE_WIDTH+1,d0	; add space width to x-pos
		bra.w	.loop			; get next letter

.rowcheck	dbf	d0,.rowloop		; if we are not in edge of a tile, branch
		add.w	#32-4,a4		; go to next tile instead
		moveq	#4-1,d0			; set to a full tile
		bra.s	.rowloop		; branch back to the main loop

.notdone	addq.w	#1,d1			; increment y-position
		cmp.w	d7,d1			; compare y-position of cursor with the height of the plane
		blt.s	.heightok2		; branch if there is room left
		add.w	#10,sp			; pop junk from stack
		moveq	#-1,d5			; didn't fit all the letters in
		rts

.heightok2	move.w	2(sp),d3		; reset row loop counter
		move.w	(sp),d0			; reset tile offset
		addq.w	#4,a5			; go to next line
		lea	(a5),a4			; get the next row to a4
		dbf	d4,.rowloop		; if not edge of tile, loop

		add.w	d2,a5			; go to next row of tiles
		sub.w	#32,a5			; go to last tile too
		lea	(a5),a4			; get the next tile to a4
		moveq	#8-1,d4			; set to a full tile
		bra.s	.rowloop		; keep looping, johnny
; ===========================================================================
; get pointer to position to write in the output buffer
; input:
;   d0 = x position to start writing data to / 2
;   d1 = y position to start writing data to
;   d6 = output buffer width / 2
;   a1 = output data
; output:
;   d0 = offset of current pixel in tile - 1
;   d4 = offset of current row in tile - 1
;   a2 = pointer to output buffer data
; ===========================================================================
GetOutputPtr:
		move.w	d6,-(sp)		; push output buffer width and height
		move.w	d1,d4			; copy y-position of the cursor
		and.w	#$7F8,d4		; round to tile bounds
		lsr.w	#3,d4			; divide by tile width (aka 8) (we do this because the next instruction will then account for it!)
		mulu.w	d2,d4			; multiply the offset by the width of the tile buffer

		move.w	d0,d6			; copy x-position of the cursor
		and.w	#$3FC,d6		; round to tile bounds
		lsl.w	#3,d6			; multiply tile size by 8
		add.w	d6,d4			; add horizontal tile to vertical tile

		move.w	d1,d6			; copy x-position of the cursor
		and.w	#7,d6			; keep in range of column of pixels
		move.w	d6,-(sp)		; push it for now
		lsl.w	#2,d6			; multiply offset by 4
		add.w	d6,d4			; add this offset too

		and.w	#3,d0			; keep in x-position range of row of pixels
		add.w	d0,d4			; add this offset too
		lea	(a1,d4.w),a4		; get pointer to output buffer

		moveq	#4,d4			; prepare tile width
		sub.w	d0,d4			; sub offset from tile width
		subq.w	#1,d4			; sub 1 from tile offset
		exg	d4,d0			; swap registers

		move.w	(sp)+,d6		; pop current row in tile
		moveq	#8,d4			; prepare tile height
		sub.w	d6,d4			; sub offset from it
		subq.w	#1,d4			; sub 1 from row offset

		move.w	(sp)+,d6		; pop output buffer width and height
		rts
; ===========================================================================
; get pointer to letter data
; input:
;   d5 = character
;   a2 = Font_Pointer_Table
; output:
;   a3 = pointer to character data
; ===========================================================================

GetLetterPtr:
		moveq	#0,d5
		move.b	(a0)+,d5		; get next character

GetLetterPtr2:
		add.w	d5,d5			; double character
		cmp.w	#'!'*2,d5		; check if this is space
		bhs.s	GetLetterPtr3		; branch if greater
		jmp	.asclst(pc,d5.w)	; run the code
; ===========================================================================
.asclst
.invalidletter
	addq.w	#1,a0		; skip over this NUL
	addq.w	#4,sp		; do not return to sender
	moveq	#0,d5		; finished everything properly!
	rts
	moveq	#0,d0		; $04
	move.b	(a0)+,d0	; set x-pos
	bra.s	GetLetterPtr	; get next letter
	bra.s .invalidletter	; $07 - bell
	bra.s .invalidletter	; $08 - backspace
	bra.s .invalidletter	; $09 - horizontal tab
	moveq	#0,d0		; clear x-position
	add.w	#FONT_SPACE_HEIGHT,d1; go to next line
	bra.s	GetLetterPtr	; get next letter
	bra.s .invalidletter	; $0E - shift out - Custom: set x-position to the next 2 bytes
	bra.s .invalidletter	; $0F - shift in - Custom: set Y-position to the next 2 bytes
	bra.s .invalidletter	; $10 - data link escape - Custom: initialize X and Y positions. 1 byte for x and 1 byte for y
	bra.s .invalidletter	; $11 - device control 1 - Custom: add next byte to x-position. X-position overflow is not checked for.
	bra.s .invalidletter	; $12 - device control 2 - Custom: sub next byte from x-position. X-position underflow is not checked for.
	bra.s .invalidletter	; $13 - device control 3 - Custom: add next sign-extended byte from y-position. Underflow and overflow are not checked for.
	bra.s .invalidletter	; $14 - device control 4
	bra.s .invalidletter	; $15 - negative acknowledge
	bra.s .invalidletter	; $16 - synchronous idle
	bra.s .invalidletter	; $17 - end of trans. block
	bra.s .invalidletter	; $18 - cancel
	bra.s .invalidletter	; $19 - end of medium
	bra.s .invalidletter	; $1A - substitute
	bra.s .invalidletter	; $1B - escape
	bra.s .invalidletter	; $1C - file separator
	bra.s .invalidletter	; $1D - group separator
	bra.s .invalidletter	; $1E - record separator
	bra.s .invalidletter	; $1F - unit separator
	addq.w	#FONT_WHITESPACE_WIDTH,d0; go to next line
	bra.s	GetLetterPtr		; get next letter
; ===========================================================================

GetLetterPtr3:
		move.w	(a2,d5.w),d5		; get offset from array
		lea	(a2,d5.w),a3		; get pointer to character data
		rts
; ===========================================================================
; Pointer table to data about each character.
; The offsets are relative to Font_Pointer_Table, and will point to start
; of each character data from the table itself.
; ===========================================================================
	nolist
Font_Pointer_Table = offset(*)-("!"*2)
	offtbl Font_Pointer_Table
	fontptr exclam
	fontptr quote

	rept "&"-"#"
		ote.w Font_Char_Null
	endr

	fontptr amper
	fontptr apost

	rept ","-"("
		ote.w Font_Char_Null
	endr

	fontptr comma
	fontptr hyphen
	fontptr dot
	ote.w Font_Char_Null
	fontptr n0, n1, n2, n3, n4, n5, n6, n7, n8, n9

	fontptr colon
	fontptr semicolon
	ote.w Font_Char_Null
	fontptr equals
	ote.w Font_Char_Null
	fontptr	question
	fontptr	at

	; upper case
	fontptr uca, ucb, ucc, ucd, uce, ucf, ucg, uch, uci, ucj, uck, ucl, ucm, ucn, uco
	fontptr ucp, ucq, ucr, ucs, uct, ucu, ucv, ucw, ucx, ucy, ucz

	rept "a"-"["
		ote.w Font_Char_Null
	endr

	; lower case
	fontptr uca, ucb, ucc, ucd, uce, ucf, ucg, uch, uci, ucj, uck, ucl, ucm, ucn, uco
	fontptr ucp, ucq, ucr, ucs, uct, ucu, ucv, ucw, ucx, ucy, ucz

Font_Char_Bell:
Font_Char_Null:
	dc.w -1

; font taken from https://github.com/idispatch/raster-fonts
	fontch comma, dot, question, exclam, quote, amper, apost, hyphen
	fontch colon, semicolon, equals, at
	fontch uca, ucb, ucc, ucd, uce, ucf, ucg, uch, uci, ucj, uck, ucl, ucm, ucn, uco
	fontch ucp, ucq, ucr, ucs, uct, ucu, ucv, ucw, ucx, ucy, ucz
	fontch n0, n1, n2, n3, n4, n5, n6, n7, n8, n9
	list
