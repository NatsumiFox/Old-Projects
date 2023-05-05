	include "lang.asm"

VDP_Data_Port		equ $C00000
VDP_Control_Port	equ $C00004
VDP_Counter		equ $C00008

fillVRAM macro value,length,loc
	move.l	#$8F019780,(a3)
	move.l	#$94009300|(((\length-1)&$FF00)<<8)|((\length-1)&$FF),(a3)
	move.l	#$40000080|((\loc&$3FFF)<<16)|((\loc&$C000)>>14),(a3)
	move.w	#\value<<8,(a4)

.fillv	move.w	(a3),d7
	btst	#1,d7
	bne.s	.fillv
	move.w	#$8F02,(a3)
    endm

; macro to issue DMA's
dma macro	source,dest,length,type
	move.l	#(($9400|((((length)>>1)&$FF00)>>8))<<16)|($9300|(((length)>>1)&$FF)),(a3)
	move.l	#(($9600|((((source)>>1)&$FF00)>>8))<<16)|($9500|(((source)>>1)&$FF)),(a3)
	move.l	#(($9700|(((((source)>>1)&$7F0000)>>16)&$7F))<<16)|((((dest)&$3FFF)|((type&1)<<15)|$4000)),(a3)
	move.w	#$80|(((dest)&$C000)>>14)|((type&2)<<3),(a3)
    endm

; values for the type argument
VRAM =	$0
CRAM =	$1
VSRAM =	$2

; reads ASCII strings and passes them to character generator
asc		macro
ct =	0
	rept narg
lc =	0
	rept strlen(\1)
cc 	substr lc+1,lc+1,\1
arg =	'\cc'
		char arg
lc =	lc+1
ct =	ct+1
	endr
	shift
	endr
    endm

; translates ASCII character to proper hex value
char		macro c
	if c=' '
		dc.w 0
	elseif c='Y'
		dc.w $3F
	elseif c='Z'
		dc.w $40
	elseif c='.'
		dc.w $59
	elseif c=','
		dc.w $5A
	elseif c='!'
		dc.w $5B
	elseif c='?'
		dc.w $5C
	elseif (c>='0')&(c<='9')
		dc.w \c
	else
		dc.w \c-7
	endif
    endm

align macro
	if narg>=2
		cnop \2,\1
	else
		cnop 0,\1
	endif
	endm
; ===========================================================================

StartOfRom:	org 0
Vectors:	dc.l 0, EntryPoint, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, vint, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
Console:	dc.b 'SEGA MEGA DRIVE ' ; Hardware system ID
Date:		dc.b '(C)NATSUMI      ' ; Release date
Title_Local:	dc.b 'BROKEN IM 0 BEHAVIOUR ON VERY OLD MEGA DRIVES   ' ; Domestic name
Title_Int:	dc.b 'BROKEN IM 0 BEHAVIOUR ON VERY OLD MEGA DRIVES   '  ; International name
Serial:		dc.b '              '   ; Serial/version number
		dc.b "  "
		dc.b 'J               ' ; I/O support
RomStartLoc:	dc.l StartOfRom		; ROM start
RomEndLoc:	dc.l EndOfRom-1		; ROM end
RamStartLoc:	dc.l $FF0000		; RAM start
RamEndLoc:	dc.l $FFFFFF		; RAM end
ErrorTrap:	bra.w	*
		dc.l $20202020		; SRAM start
		dc.l $20202020		; SRAM end
Notes:		dc.b '                                                    '
		dc.b 'JUE             ' ; Region
; ===========================================================================
VDPregs:	dc.w $8004, $8174, $8230, $8338
		dc.w $8407, $8570, $8600, $8700
		dc.w $8800, $8900, $8AFF, $8B00
		dc.w $8C81, $8D3F, $8E00, $8F02
		dc.w $9001, $9100, $9200, $9300
		dc.w $9400, $9500, $9600, $9700
; ===========================================================================
Font_GFX:
	dc.l $00000000, $00000000, $00666600, $06600660, $66606660, $66660660, $66006600, $06666000	; 0
	dc.l $00000000, $00000000, $00066600, $00606600, $00006600, $00066000, $00066000, $06666600	; 1
	dc.l $00000000, $00000000, $00666000, $06006600, $00006600, $00066000, $00660000, $06666600	; 2
	dc.l $00000000, $00000000, $06666600, $00006600, $00066000, $00006600, $06006600, $06666000	; 3
	dc.l $00000000, $00000000, $00066600, $00606600, $06006000, $66666660, $00066000, $00666000	;
	dc.l $00000000, $00000000, $00666600, $00600000, $00666600, $00000660, $06006660, $00666600	;
	dc.l $00000000, $00000000, $00066600, $00660000, $06666000, $66006600, $66006600, $66666000
	dc.l $00000000, $00000000, $06666600, $06006600, $00066000, $00660000, $06600000, $66600000	; 6
	dc.l $00000000, $00000000, $00666600, $06600660, $00666600, $06666000, $66006600, $06666000
	dc.l $00000000, $00000000, $00666600, $06600660, $06600660, $00666600, $00006600, $06666000
	dc.l $00000000, $00000000, $00006660, $00060660, $00600660, $00666660, $06600660, $66000660
	dc.l $00000000, $00000000, $00666600, $00600660, $06666600, $06666000, $66006600, $66666000
	dc.l $00000000, $00000000, $00666600, $06600660, $06600000, $66000000, $66006600, $66666000
	dc.l $00000000, $00000000, $00666600, $00660660, $06600660, $06600660, $66006600, $66666000
	dc.l $00000000, $00000000, $00666660, $00660000, $06600000, $06666000, $66000000, $66666600
	dc.l $00000000, $00000000, $00666660, $06660000, $06600000, $06666600, $66600000, $66600000
	dc.l $00000000, $00000000, $00666600, $06660060, $06600000, $66006660, $66006600, $66666600
	dc.l $00000000, $00000000, $00660060, $00660660, $06600660, $06666600, $66006600, $66006600
	dc.l $00000000, $00000000, $00066000, $00066000, $00660000, $00660000, $06600000, $06600000
	dc.l $00000000, $00000000, $00000660, $00000660, $06006600, $66006600, $66666000, $06660000
	dc.l $00000000, $00000000, $00660060, $00660660, $06606600, $06666000, $66006600, $66000660
	dc.l $00000000, $00000000, $00066000, $00660000, $06600000, $06600000, $66000000, $66666600
	dc.l $00000000, $00000000, $00660060, $00660660, $00666660, $06060660, $06000660, $66000660
	dc.l $00000000, $00000000, $00660060, $00660060, $00666060, $06066600, $06006600, $66006600
	dc.l $00000000, $00000000, $00666600, $06600660, $66606660, $66606660, $66006600, $06666000
	dc.l $00000000, $00000000, $00666600, $00660060, $06600660, $06666600, $66600000, $66000000
	dc.l $00000000, $00000000, $00666600, $06600660, $66000660, $66666660, $66006600, $66666660
	dc.l $00000000, $00000000, $00666600, $00660060, $06600660, $06666600, $66006600, $66006660
	dc.l $00000000, $00000000, $00666660, $06600660, $06660000, $00666600, $66006660, $66666600
	dc.l $00000000, $00000000, $06666660, $00066000, $00066000, $00660000, $00660000, $00660000
	dc.l $00000000, $00000000, $00660060, $00660060, $06600660, $06600600, $66666600, $66666000
	dc.l $00000000, $00000000, $06600060, $06600060, $06600660, $06606600, $06666000, $66660000
	dc.l $00000000, $00000000, $66000060, $66000060, $66060660, $66666600, $66006600, $66006600
	dc.l $00000000, $00000000, $06600060, $06660600, $00666000, $00066000, $00666600, $66006660
tilend:
		even
; ===========================================================================

vint:
	dma Palette, 0, 64*2, CRAM		; dma palette
	 	rte
; ===========================================================================

EntryPoint:
.count =	13
		move	#$2700,sr		; disable ints
		lea	$A00000,a0
		lea	.results(a0),a5
		lea	.z80(pc),a1
		lea	$A11100,a2
		moveq	#0,d0
		move.w	#$100,d1

		move.b	-$10FF(a2),d7		; get hardware version	; 4
		andi.b	#$F,d7			; is this TMSS MD?
		beq.s	.skip			; if not, skip
		move.l	Console.w,$2F00(a2)	; do TMSS

.skip		lea	VDP_Control_Port,a3	; get VDP port to a3
		lea	-4(a3),a4		; get VDP data to a4
		tst.w	(a3)			; reset VDP

		move.w	d1,(a2)			; stop the Z80
		move.w	d1,$100(a2)		; reset	the Z80
		move.w	#.zend-.z80-1,d7	; load driver length to d7

.del		btst	d0,(a2)			; has the Z80 stopped?
		bne.s	.del			; if not, branch

.driver		move.b	(a1)+,(a0)+		; load z80 driver code into RAM
		dbf	d7,.driver		; loop for all bytes
		move.w	d0,$100(a2)		; request reset

		lea	VDPregs(pc),a6		; get register setup
		moveq	#$B-1,d7

.regs		move.l	(a6)+,(a3)		; move 2 register settings per move
		dbf	d7,.regs		; loop until 0
	fillVRAM 0,$10000,0			; fill VRAM with blank

		move.w	d0,(a2)			; start	the Z80
		move.w	d1,$100(a2)		; reset off

		lea	Font_GFX,a6
		move.l	#$46000000,(a3)
		move.w	#(($22*32)/4)-1,d7

.lp		move.l	(a6)+,(a4)
		dbf	d7,.lp

	dma InitialText, $C080, 15*2, VRAM	; write the initial text

		moveq	#.count-1,d7		; set repeat count to d7
.ints		stop	#$2300			; wait for v-int
		dbf	d7,.ints		; waits for the same amount of frames as z80 should do

		bra.s	.wait			; skip over the z80 start

.start		move.w	d0,(a2)			; start	the Z80
.wait		move.w	d1,(a2)			; stop the Z80
.del2		btst	d0,(a2)			; has the Z80 stopped?
		bne.s	.del2			; if not, branch

		tst.b	.count(a5)		; check if counting is finished
		beq.s	.start			; branch if not
		move.l	#$41820003,(a3)		; prepare VRAM address to write to

	rept .count
		move.b	(a5)+,d3
		bsr.s	.writebyte
		move.w	d0,(a4)
	endr

		move.w	d0,(a2)			; start	the Z80
		bra.w	*			; trap cpu
; ===========================================================================

.writebyte	moveq	#2-1,d6			; set up nibbles in num
		move.w	d6,d4			; copy length
.loop2		move.b	d3,d2			; get next nibble
		andi.w	#%1111,d2		; keep the nibble only
		add.b	#$30,d2			; increment 1 (to skip null)
		move.w	d2,-(sp)		; then store the number on plane
		ror.l	#4,d3			; rotate right four times, to get the next nibble.
						; Also returns d3 to original value
		dbf	d6,.loop2		; loop until full number is done

.writeb		move.w	(sp)+,(a4)		; copy number to VRAM
		dbf	d4,.writeb		; write for so many bytes as we need
		rts
; ===========================================================================

.z80	z80prog 0
		jp	.init			; note, these will be replaced later
		dc.b 1				; lol

.x = 4
	rept ($100-4)/2
		dc.b .x, 1			; jump table
.x =		.x+2
	endr

	dcb.b $100, $3D			; $100x		dec a

		ld	(hl),a			; save result into (hl)
		inc	hl			; increment hl

.runit		xor	a			; reset a to 0
		ld	sp,.stack		; reset stack pointer
		ei				; enable ints

		djnz	.delay			; if b != 0, delay moar
		dec	(hl)			; tell 68k we are done
		di				; trap into a loop
.delay		jr	.delay

.init		di				; disable ints
		im	2			; make sure im is 2
		xor	a			; clear a
		ld	i,a			; reset i and r just to be sure
		ld	r,a			; also, this makes sure the v-int jumps to $00XX
		ld	h,a			; reset HL to 0 as well; we need to rewrite instructions
		ld	l,a			;

		inc	a			; prepare a for stuff
		ld	(hl),l			; fix address low value to l
		inc	hl			; increment hl
		ld	(hl),a			; fix address high value to 1
		inc	hl			; increment hl
		ld	(hl),l			; fix address low value to l

		ld	b,.count+1		; load counter value into b
		ld	hl,.results		; load results portion into hl
		jr	.runit			; jump to the initial handler

.results	dcb.b	.count+1,0
.stack =	*+$10				; stack is just whatever
	z80prog
.zend		even
; ===========================================================================

InitialText:	asc "IM 2 ADDRESSES "
Palette:	dcb.w 6, 0
		dc.w $EEE
		dcb.w $40-7, 0
EndOfRom:	END
