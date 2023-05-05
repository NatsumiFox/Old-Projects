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
Font_Char_\char	incbin "font/\char\.bin"
		even
		shift
	endr
	endm

; ===========================================================================
; write variable width text to output buffer
; input:
;   d0 = x position to start writing data to / 2
;   d1 = y position to start writing data to
;   d6 = output buffer width / 2
;   d7 = output buffer height
;   a0 = input data
;   a1 = output data
;   a6 = hints data for rendering
; output:
;   cc;
;      zero = all letters were put into the buffer
;      negative = not all letters were put into the buffer
;      positive = an error occurred
; ===========================================================================
FONT_SPACE_WIDTH = 2/2		; the number of pixels between each letter horizontally (excluding width of each letter)
FONT_SPACE_HEIGHT = 2+8		; the number of pixels between each letter vertically
FONT_WHITESPACE_WIDTH = 4/2	; each whitespace is 4 pixels wide
FONT_TAB_WIDTH = FONT_WHITESPACE_WIDTH*4; each tab is 4x as wide as each space
	rsset 2
ERR_ILLEGAL_CHAR	rs.w 1	; illegal character in input error

WriteTextToBuffer:	; 24 cycles
		; initial setup
		move.w	-2(a6),d4
		lea	(a6,d4.w),a2
		move.w	d6,d2			; get buffer width to d2
		lsl.w	#3,d2			; multiply by 8

		; main loop	; 40 or 42 cycles
.loop		jsr	GetLetterPtr(pc)	; get pointer to next letter
		move.w	(a3)+,-(sp)		; push the width and height in stack
		bmi.s	.loop			; if width is negative, branch

		moveq	#0,d4
	; 28 or 30 cycles
.checkhoriz	move.b	(sp),d4			; get width from stack
		move.w	d6,d5			; copy buffer width to d5
		sub.w	d0,d5			; sub current x-position from d5
		cmp.w	d4,d5			; compare letter width from width left
		bgt.s	.validslotfound		; branch if the vertical slot is valid

	; 44 or 46 cycles
.checkverti	add.w	2(a6),d1		; add space height to letter offset
		moveq	#0,d0			; clear x-position
		move.b	1(sp),d4		; get height from stack
		move.w	d7,d5			; copy buffer height to d5
		sub.w	d1,d5			; sub current y-position from d5
		cmp.w	d4,d5			; compare letter height from height left
		bgt.s	.checkhoriz		; branch if the vertical slot is valid

	; 48 cycles
.validslotfound	moveq	#0,d3
		move.b	(sp),d3			; get width of the letter
		move.w	(sp)+,d5		; pop height and width of the letter
		and.w	#$7F,d5			; get only low byte (height)
		movem.w	d0-d1/d4,-(sp)		; push current x and y-position to stack

	; 14 or 40 cycles
		cmp.w	d7,d1			; compare y-position of cursor with the height of the plane
		blt.s	.heightok		; branch if there is no room left!
		addq.w	#4,sp			; pop junk from stack
		moveq	#-1,d5			; didn't fit all the letters in
		rts

	; 38 cycles
.heightok	jsr	GetOutputPtr(pc)	; get pointer to output data
		lea	(a4),a5			; store offset to a5
		movem.w	d0/d3,-(sp)		; push width of data and pixel offset

	; 22, 36 or 40 cycles
.rowloop	move.b	(a3)+,(a4)+		; write 2 pixels into the buffer
		dbf	d3,.rowcheck		; if we are not done looping, branch
		dbf	d5,.notdone		; if we are not done looping, branch

	; 50 cycles
		addq.w	#4,sp			; pop junk from stack
		movem.w	(sp)+,d0-d1/d4		; pop current x and y-position to stack
		add.w	d4,d0			; add letter width to x-pos
		add.w	(a6),d0			; add space width to x-pos
		jsr	FlushFont
		bra.w	.loop			; get next letter

	; 10 or 36 cycles
.rowcheck	dbf	d0,.rowloop		; if we are not in edge of a tile, branch
		add.w	#32-4,a4		; go to next tile instead
		moveq	#4-1,d0			; set to a full tile
		bra.s	.rowloop		; branch back to the main loop

	; 18 or 48 cycles
.notdone	addq.w	#1,d1			; increment y-position
		cmp.w	d7,d1			; compare y-position of cursor with the height of the plane
		blt.s	.heightok2		; branch if there is room left
		add.w	#10,sp			; pop junk from stack
		moveq	#-1,d5			; didn't fit all the letters in
		rts

	; 42 or 46 cycles
.heightok2	move.w	2(sp),d3		; reset row loop counter
		move.w	(sp),d0			; reset tile offset
		addq.w	#4,a5			; go to next line
		lea	(a5),a4			; get the next row to a4
		dbf	d4,.rowloop		; if not edge of tile, loop

	; 36 cycles
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
;
; 250 cycles max
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

ch_null		addq.w	#4,sp			; do not return to sender
		moveq	#0,d5			; finished everything properly!
		rts

ch_clear	lea	(a1),a5			; copy a1 to this
		move.w	#(40*28)-1,d4		; get repeat count
.c	rept 32/4
		clr.l	(a5)+			; clear longword
	endr
		dbf	d4,.c			; clear til dont
		bra.s	GetLetterPtr		; get next letter

ch_flush	jsr	FlushFont		; flush data
		bra.s	GetLetterPtr		; get next letter

ch_initxy	moveq	#0,d0
		moveq	#0,d1			; clear x and y
		move.b	(a0)+,d0		; get x-position
		move.b	(a0)+,d1		; get x-position
		bra.s	GetLetterPtr		; get next letter

ch_wait		moveq	#0,d4
		move.b	(a0)+,d4		; get frame counter
.w		jsr	FlushFont		; flush data (arbitrary delay)
		dbf	d4,.w			; loop til done
		bra.s	GetLetterPtr		; get next letter

ch_xset		move.b	(a0)+,-1(sp)		; get the next byte to stack (this is unused at this point, safe to write)
		move.w	-2(sp),d0		; get that to d0
		move.b	(a0)+,d0		; then read the next byte
		bra.s	GetLetterPtr		; get next letter

ch_xadd		moveq	#0,d4			; clear d4
		move.b	(a0)+,d4		; get x-position
		add.w	d4,d0			; add x-offset to x-position
		bra.s	GetLetterPtr		; get next letter

ch_xsub		moveq	#0,d4			; clear d4
		move.b	(a0)+,d4		; get x-position
		sub.w	d4,d0			; sub x-offset from x-position
		bra.s	GetLetterPtr		; get next letter

ch_tab		add.w	6(a6),d0		; advance x-position

; ===========================================================================

GetLetterPtr:	; 12 cycles
		moveq	#0,d5
		move.b	(a0)+,d5		; get next character

GetLetterPtr2:	; 22 or 24 cycles
		add.w	d5,d5			; double character
		cmp.w	#'!'*2,d5		; check if this is space
		bhs.s	GetLetterPtr3		; branch if greater
		jmp	.asclst(pc,d5.w)	; run the code
; ===========================================================================
.asclst
	bra.s ch_null		; $00 - null
	bra.s ch_wait		; $01 - start of heading - Custom: Wait x flushes, where x is next byte
	bra.s ch_clear		; $02 - start of text - Custom: Clear the output buffer
	bra.s ch_flush		; $03 - end of text - Custom: Flush once
	bra.s ch_initxy		; $04 - end of transmission - Custom: initialize X and Y positions
	bra.s GetLetterPtr	; $05 - enquiry
	bra.s GetLetterPtr	; $06 - acknowledge
	bra.s GetLetterPtr	; $07 - bell
	bra.s GetLetterPtr	; $08 - backspace
	bra.s ch_tab		; $09 - horizontal tab

	; $0A - newline feed
		moveq	#0,d0			; clear x-position
		add.w	2(a6),d1		; go to next line
		bra.s	GetLetterPtr		; get next letter
	; eat
	; $0B - vertical tab
	; $0C - newpage feed
	; $0D - carriage return
	bra.s GetLetterPtr	; $0E - shift out
	bra.s GetLetterPtr	; $0F - shift in
	bra.s ch_xset		; $10 - data link escape - Custom: set x-position to the next 2 bytes
	bra.s ch_xadd		; $11 - device control 1 - Custom: add next byte to x-position. X-position overflow is not checked for.
	bra.s ch_xsub		; $12 - device control 2 - Custom: sub next byte from x-position. X-position underflow is not checked for.
	bra.s GetLetterPtr	; $13 - device control 3
	bra.s GetLetterPtr	; $14 - device control 4
	bra.s GetLetterPtr	; $15 - negative acknowledge
	bra.s GetLetterPtr	; $16 - synchronous idle
	bra.s GetLetterPtr	; $17 - end of trans. block
	bra.s GetLetterPtr	; $18 - cancel
	bra.s GetLetterPtr	; $19 - end of medium
	bra.s GetLetterPtr	; $1A - substitute
	bra.s GetLetterPtr	; $1B - escape
	bra.s GetLetterPtr	; $1C - file separator
	bra.s GetLetterPtr	; $1D - group separator
	bra.s GetLetterPtr	; $1E - record separator
	bra.s GetLetterPtr	; $1F - unit separator
	; $20 - space
; ===========================================================================
.space		add.w	4(a6),d0		; advance x-position
		bra.s	GetLetterPtr

GetLetterPtr3:	; 44 cycles
		move.w	(a2,d5.w),d5		; get offset from array
		lea	(a2,d5.w),a3		; get pointer to character data
		rts
; ===========================================================================
; Pointer table to data about each character.
; The offsets are relative to Font_Pointer_Table, and will point to start
; of each character data from the table itself.
; ===========================================================================

	dc.w Font_Pointer_Table-Font_Hints
Font_Hints:
	dc.w FONT_SPACE_WIDTH+1, FONT_SPACE_HEIGHT, FONT_WHITESPACE_WIDTH, FONT_TAB_WIDTH
Font_Pointer_Table = offset(*)-("!"*2)
	offtbl Font_Pointer_Table
	fontptr exclamation

	rept ","-'"'
		ote.w Font_Char_Null
	endr

	fontptr comma
	ote.w Font_Char_Null
	fontptr dot
	ote.w Font_Char_Null
	fontptr n0, n1, n2, n3, n4, n5, n6, n7, n8, n9

	rept "?"-":"
		ote.w Font_Char_Null
	endr

	fontptr	question
	ote.w Font_Char_Null

	; upper case
	fontptr uca, ucb, ucc, ucd, uce, ucf, ucg, uch, uci, ucj, uck, ucl, ucm, ucn, uco
	fontptr ucp, ucq, ucr, ucs, uct, ucu, ucv, ucw, ucx, ucy, ucz

	rept "a"-"["
		ote.w Font_Char_Null
	endr

	; lower case
	fontptr uca, ucb, ucc, ucd, uce, ucf, ucg, uch, uci, ucj, uck, ucl, ucm, ucn, uco
	fontptr ucp, ucq, ucr, ucs, uct, ucu, ucv, ucw, ucx, ucy, ucz

	dc.w Font_Pointer_TableBig-Font_HintsBig
Font_HintsBig:
	dc.w (FONT_SPACE_WIDTH*3)+1, FONT_SPACE_HEIGHT*4, FONT_WHITESPACE_WIDTH*4, FONT_TAB_WIDTH*4

Font_Pointer_TableBig = offset(*)-("!"*2)
	offtbl Font_Pointer_TableBig
	fontptr _exclamation

	rept ","-'"'
		ote.w Font_Char_Null
	endr

	fontptr _comma
	ote.w Font_Char_Null
	fontptr _dot
	ote.w Font_Char_Null
	fontptr _n0, _n1, _n2, _n3, _n4, _n5, _n6, _n7, _n8, _n9

	rept "?"-":"
		ote.w Font_Char_Null
	endr

	fontptr	_question
	ote.w Font_Char_Null

	; upper case
	fontptr _uca, _ucb, _ucc, _ucd, _uce, _ucf, _ucg, _uch, _uci, _ucj, _uck, _ucl, _ucm, _ucn, _uco
	fontptr _ucp, _ucq, _ucr, _ucs, _uct, _ucu, _ucv, _ucw, _ucx, _ucy, _ucz

	rept "a"-"["
		ote.w Font_Char_Null
	endr

	; lower case
	fontptr _uca, _ucb, _ucc, _ucd, _uce, _ucf, _ucg, _uch, _uci, _ucj, _uck, _ucl, _ucm, _ucn, _uco
	fontptr _ucp, _ucq, _ucr, _ucs, _uct, _ucu, _ucv, _ucw, _ucx, _ucy, _ucz

Font_Char_Bell:
Font_Char_Null:
	dc.w -1

	fontch comma, dot, question, exclamation
	fontch uca, ucb, ucc, ucd, uce, ucf, ucg, uch, uci, ucj, uck, ucl, ucm, ucn, uco
	fontch ucp, ucq, ucr, ucs, uct, ucu, ucv, ucw, ucx, ucy, ucz
	fontch n0, n1, n2, n3, n4, n5, n6, n7, n8, n9
	fontch _n0, _n1, _n2, _n3, _n4, _n5, _n6, _n7, _n8, _n9
	fontch _comma, _dot, _question, _exclamation
	fontch _uca, _ucb, _ucc, _ucd, _uce, _ucf, _ucg, _uch, _uci, _ucj, _uck, _ucl, _ucm, _ucn, _uco
	fontch _ucp, _ucq, _ucr, _ucs, _uct, _ucu, _ucv, _ucw, _ucx, _ucy, _ucz
