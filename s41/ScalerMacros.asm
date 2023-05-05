; ===========================================================================
; Hyper fast upscaling code generator!
; Probably the fastest (and largest!!!) tile upscaling code to date!
; Had to be done because "Blast processing"! And "Genesis does what Nintendon't!"
;
; Generated with gen_scalers programmed by FlameWing
; ===========================================================================
; Scale factors are multiplied by 1000. Fo a scale factor of 1000 corresponds to
; the original image, a scale factor of 500 is half-size, a scale factor of 2000
; is 2x the size of the original, and so on.
; ===========================================================================
; Output range:
; 	wx	Width of output (scaled) image
; 	cx	Origin ("center") of output (scaled) image
; The following values are for drawing half-lines.
wx = 96
; For drawing a full line centered on the middle of the screen:
;wx := 320
;cx := 160
; ===========================================================================
; Input range:
; 	wy	Width of input (unscaled) image
; 	cy	Origin ("center") of input (unscaled) image
; The following values are for drawing half-lines.
wy = 96
; For scaling a 160-pixel wide image, centered in the middle
;wy := 160
;cy := 80
; ===========================================================================
; Register usage:
; 	a0	Input buffer
; 	a1	Output buffer
; 	a2	High nibble to low nibble LUT
; 	a3	Low nibble to high nibble LUT
; 	a4	High nibble to both nibbles LUT
; 	a5	Low nibble to both nibbles LUT
; 	a6	Target scaler
; 	d0	Cached byte from input (assumes bits 8-31 clear)
; 	d1	Temporary buffer before write to a1
; 	d2	Scratch register
; 	d3	Temporary cache from either a4 or a5
; 	d5	Number of vertical tiles-1 (loop counter)
; 	d6	Number of lines per tile-1 (loop counter)

ScaleLockAddr:
	dc.w SelectedROM, LockonROMid

ImageOffsetData:
	dc.w FrameOffs+12, FrameOffs, FrameOffs+4, FrameOffs+8
	dc.w FrameOffs+12, FrameOffs, FrameOffs+4

; list of buffer addresses to use
ImageAddrData:
	dc.l ScaleBuf, ScaleBuf+$1200, ScaleBuf+$2400, ScaleBuf+$3600
	dc.l ScaleBuf, ScaleBuf+$1200, ScaleBuf+$2400

Scale_Image:
	moveq	#0,d0			; clear upper word
	move.b	ChangingLockROM.w,d0	; whether changing lock-on ROM
	move.w	ScaleLockAddr(pc,d0.w),a0; get the address to change to
	move.w	PlaneAY.w,d0		; get Plane A y-pos

	cmp.b	#1,MenuState.w		; check if moving up
	bne.s	.noshift		; if yes, branch
	subq.w	#8,d0			; go to last tile; this is done to fix graphical bug

.noshift move.l	d0,d1
	divu	#12*8*4,d0		; get the offset in these frames
	clr.w	d0			; clear the upper word for the next divu instruction
	swap	d0			; we want to do modulo
	divu	#12*8,d0		; now get the frame we are on
	move.b	d0,(a0)			; set selected ROM

.nofix	cmpa.w	#LockonROMid,a0		; check if its the lock-on ROM addr
	bne.s	.nofix2			; if not, branch
	addq.b	#1,(a0)			; go to next ROM
	andi.b	#3,(a0)			; keep in range
	subq.b	#1,(a0)			; sub 1 from it again

.nofix2	add.w	d0,d0			; 2 possible entries, in increments of 2
	lea	ImageOffsetData(pc,d0.w),a0; get offs
	move.l	a0,-(sp)		; store in stack
	move.w	(a0),a0			; get the address to read from
	move.l	(a0),a0			; get the slice address

	add.w	d0,d0			; 4 possible entries, in increments of 4
	lea	ImageAddrData(pc,d0.w),a1; get address table to a1
	move.l	a1,-(sp)		; store in stack
	move.l	(a1),a1			; then get the actual address

	divu	#12*8,d1		; get the position in the first icon
	swap	d1			; we want to do modulo
	lsr.w	#2,d1			; go in increments of 8
	and.w	#$FE,d1			; round
	neg.w	d1			; negate the value
	add.w	#$16,d1			; then add the max value

	lea	ScaleList(pc),a2
	lea	(a2,d1.w),a2		; get the scale list to a2
	move.l	a2,-(sp)		; store in stack
	move.w	(a2),d4			; scale factor index

	lea	HighNibble2Low_LUT(pc),a2; LUT
	lea	LowNibble2High_LUT(pc),a3; LUT
	lea	HighNibble2Both_LUT(pc),a4; LUT
	lea	LowNibble2Both_LUT(pc),a5; LUT
	bsr.w	.n

	add.w	#12*2,2(sp)		; add 2 to the scale list address
	addq.w	#4,6(sp)		; add 4 to the scale buffer address
	addq.w	#2,10(sp)		; add 2 to the image address offset
	move.l	8(sp),a0		;
	move.w	(a0),a0			; get the address to read from
	move.l	(a0),a0			; get the slice address
	move.l	(sp),a1			; get the scale list address from sp
	move.w	(a1),d4			; scale factor index
	move.l	4(sp),a1		; get the buffer address from sp
	move.l	(a1),a1			; then get the actual address
	bsr.w	.n

	add.w	#12*2,2(sp)		; add 2 to the scale list address
	addq.w	#4,6(sp)		; add 4 to the scale buffer address
	addq.w	#2,10(sp)		; add 2 to the image address offset
	move.l	8(sp),a0		;
	move.w	(a0),a0			; get the address to read from
	move.l	(a0),a0			; get the slice address
	move.l	(sp),a1			; get the scale list address from sp
	move.w	(a1),d4			; scale factor index
	move.l	4(sp),a1		; get the buffer address from sp
	move.l	(a1),a1			; then get the actual address
	bsr.s	.n

	move.l	(sp)+,a1		; get the scale list address from sp
	move.w	(12*2)(a1),d4		; scale factor index
	move.l	(sp)+,a1		; get the buffer address from sp
	move.l	4(a1),a1		; then get the actual address
	move.l	(sp)+,a0		; get the scale image address from sp
	move.w	2(a0),a0		; get the address to read from
	move.l	(a0),a0			; get the slice address
	bra.s	.n

.htbl	dc.l $FFFFFFFF, $1F943, $2F286, $3EBCA, $5E50D
	dc.l    $6DE50, $7D794, $8D0D7, $ACA1A, $BC35E
	dc.l    $CBCA1, $DB5E5, $FAF28,$10A86B,$11A1AF
	dc.l   $129AF2,$149435,$158D79,$1686BC,$178000

.n	pea	(a0)			; store a0 to pop it later
	moveq	#12-1,d5		; Number of tiles to scale-1
	moveq	#8-1,d6			; Number of lines per tile-1

	move.l	.htbl(pc,d4.w),d2	; get desired height
	move.l	d2,d3			; copy d2 to d3
	swap	d3			; get the blank size instead
	tst.w	d3			; test it
	bmi.s	.ok			; if negative, skip
	lea	Scalers.w,a6		; the code to run

.zrun	bsr.s	.run_code		; run the code for d3 scanlines
	dbf	d3,.zrun		; ^

; calculate what lines to render
; d1 = current delta
; d2 = delta increment
.ok	move.l	(sp)+,a0
	movea.w	Scalers_Table+2(pc,d4.w),a6; get the proper scaler code
	moveq	#0,d0			; clear cache byte
	moveq	#-1,d1			; clear delta
	moveq	#96-1,d4		; number of scanlines to draw

.delta	add.w	d2,d1			; add delta in
	bcs.s	.noskip			; if carry is set, do not skip a pixel
	add.w	#wy/2,a0		; skip a line
	subq.w	#1,d4			; sub 1 from scanlines left
	bmi.s	.dend			; if negative, end executing the code

.noskip	bsr.s	.run_code		; draw next scanline
	dbf	d4,.delta		; keep looping til all of the input is drawn

.dend	lea	Scalers.w,a6		; the code to run
.xrun	bsr.s	.run_code		; run the code for d3 scanlines
	bra.s	.xrun			; run til all scanlines have been completed

.run_code
	movem.l	d1-d3/a0-a1,-(sp)	; Save pointer to current line of input image
	jsr	(a6)			; Scale line
	movem.l	(sp)+,d1-d3/a0-a1	; Fetch pointer to current line of input image

	lea	wy/2(a0),a0		; Move to next line of input image
	addq.w	#4,a1			; Move to next line of output image
	dbra	d6,.end
	moveq	#8-1,d6			; Number of lines per tile-1
	lea	(wx*8/2)-32(a1),a1	; Move to correct output tile
	dbra	d5,.end
	addq.w	#4,sp			; do not return to caller

.end	rts
; ===========================================================================

Scalers_Table:
	incbin "dat/scaler/offs.dat"

; list of scale factors to use when scaling the menu. 32 entries
ScaleList:
	dc.w $4C, $48, $44, $40
	dc.w $3C, $38, $34, $30
	dc.w $2C, $28, $24, $20
	dc.w $1C, $18, $14, $10
	dc.w $0C, $08, $04, $00

	dc.w $00, $04, $08, $0C
	dc.w $10, $14, $18, $1C
	dc.w $20, $24, $28, $2C
	dc.w $30, $34, $38, $3C
	dc.w $40, $44, $48, $4C

	nolist
; ===========================================================================
; Generates a 256-byte lookup table that can be used to convert $00XY to $000X.
HighNibble2Low_LUT:
.c = 0
	rept 256
		dc.b	(.c>>4)&$0F
.c = .c+1
	endr
; ===========================================================================
; Generates a 256-byte lookup table that can be used to convert $00XY to $00Y0.
LowNibble2High_LUT:
.c = 0
	rept 256
		dc.b	(.c<<4)&$F0
.c = .c+1
	endr
; ===========================================================================
; Generates a 256-byte lookup table that can be used to convert $00XY to $00XX.
HighNibble2Both_LUT:
.c = 0
	rept 256
		dc.b	((.c>>4)&$0F)|(.c&$F0)
.c = .c+1
	endr
; ===========================================================================
; Generates a 256-byte lookup table that can be used to convert $00XY to $00YY.
LowNibble2Both_LUT:
.c = 0
	rept 256
		dc.b	((.c<<4)&$F0)|(.c&$0F)
.c = .c+1
	endr
; ===========================================================================
	list

