	opt op+
	opt l.

PAD_ENABLE_MULTI =	1					; enable multitap (Team Player) and EA 4-way play.
PAD_ENABLE_MOUSE =	1					; enable mouse read support

		rsset $FFFFFF00
	if PAD_ENABLE_MULTI
Pad1Stats			rs.w 0				; stats for pad 1
Pad1AHeld			rs.w 1				; held buttons for controller 1A
Pad1APress			rs.w 1				; pressed buttons for controller 1A
Pad1BHeld			rs.w 1				; held buttons for multitap 1B
Pad1BPress			rs.w 1				; pressed buttons for multitap 1B
Pad1CHeld			rs.w 1				; hel§d buttons for multitap 1C
Pad1CPress			rs.w 1				; pressed buttons for multitap 1C
Pad1DHeld			rs.w 1				; held buttons for multitap 1D
Pad1DPress			rs.w 1				; pressed buttons for multitap 1D

Pad2Stats			rs.w 0				; stats for pad 2
Pad2AHeld			rs.w 1				; held buttons for controller 2
Pad2APress			rs.w 1				; pressed buttons for controller 2
Pad2BHeld			rs.w 1				; held buttons for multitap 2B
Pad2BPress			rs.w 1				; pressed buttons for multitap 2B
Pad2CHeld			rs.w 1				; held buttons for multitap 2C
Pad2CPress			rs.w 1				; pressed buttons for multitap 2C
Pad2DHeld			rs.w 1				; held buttons for multitap 2D
Pad2DPress			rs.w 1				; pressed buttons for multitap 2D

Pad1Mode			rs.b 1				; pad 1 mode (0 = 3-button, 1 = 6-button, 2 = mouse, 3 = empty, $80 = multitap, $EA = EA 4-way play)
Pad2Mode			rs.b 1				; pad 2 mode (0 = 3-button, 1 = 6-button, 2 = mouse, 3 = empty, $80 = multitap, $EA = EA 4-way play)
Pad1Multi			rs.b 1				; pad 1 multitap types (2b per pad, 00 = 3-button, 01 = 6-button, 10 = mouse, 11 = empty)
Pad2Multi			rs.b 1				; pad 2 multitap types (2b per pad, 00 = 3-button, 01 = 6-button, 10 = mouse, 11 = empty)
PadPoll				rs.b 1				; if set, polls controllers instead of doing controller input

	else
Pad1AHeld	rs.w 1		; held buttons for controller 1
Pad1APress	rs.w 1		; pressed buttons for controller 1
Pad2AHeld	rs.w 1		; held buttons for controller 2
Pad2BHeld	rs.w 1		; pressed buttons for controller 2

Pad1Mode	rs.b 1		; pad 1 mode (0 = 3-button, 1 = 6-button, 2 = mouse, 3 = empty)
Pad2Mode	rs.b 1		; pad 2 mode (0 = 3-button, 1 = 6-button, 2 = mouse, 3 = empty)
	endif

PAD_TH =	6		; TH pin bit
PAD_TR =	5		; TR pin bit
PAD_TL =	4		; TL pin bit

; delay pad read by 8 cycles
pad_delay8	macro
	or.l	d0,d0
	endm

; delay pad read by 4 cycles
pad_delay4	macro
	nop
	endm

VDP_Data_Port		equ $C00000
VDP_Control_Port	equ $C00004
VDP_Counter		equ $C00008

fillVRAM macro value,length,loc
	move.w	#$8F01,(a0)
	move.l	#$94009300+((((length)-1)&$FF00)<<8)+(((length)-1)&$FF),(a0)
	move.w	#$9780,(a0)
	move.l	#$40000080+((loc&$3FFF)<<16)+((loc&$C000)>>14),(a0)
	move.w	#(value)<<8,(a6)

.fill	move.w	(a0),d1
	btst	#1,d1
	bne.s	.fill
    endm

; macro to issue DMA's
dma macro	source,dest,length,type
	move.l	#(($9400|((((length)>>1)&$FF00)>>8))<<16)|($9300|(((length)>>1)&$FF)),(a0)
	move.l	#(($9600|((((source)>>1)&$FF00)>>8))<<16)|($9500|(((source)>>1)&$FF)),(a0)
	move.l	#(($9700|(((((source)>>1)&$FF0000)>>16)&$7F))<<16)|((((dest)&$3FFF)|((type&1)<<15)|$4000)),(a0)
	move.w	#$80|(((dest)&$C000)>>14)|((type&2)<<3),(a0)
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
	else
		dc.w \c
	endif
    endm
; ===========================================================================
Maincode	section org(0)
		dc.l 0, EntryPoint, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l HBlank, ErrorTrap, VBlank, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
Console:	dc.b "SEGA            "
		dc.b "tsumi 17/03/2016"
		dc.b "JOYPAD TEST ROM                                 "
		dc.b "JOYPAD TEST ROM                                 "
		dc.b "HOMEBREW      "
		dc.w 0
		dc.b 'J               '
		dc.l 0
		dc.l EndOfRom-1
		dc.l $FF0000
		dc.l $FFFFFF
		dc.b 'RA', %11100000, %00100000
		dc.l $200000
		dc.l $3FFFFF
		dc.b '                                                    '
		dc.b 'JUE             '
; ===========================================================================
VDPregs:	dc.w $8004, $8174, $8230, $8338
		dc.w $8407, $8570, $8600, $8700
		dc.w $8800, $8900, $8A00, $8B00
		dc.w $8C71, $8D3F, $8E00, $8F02
		dc.w $9001, $9100, $9200, $93FF
		dc.w $94FF, $9500, $9600, $9780
; ===========================================================================
Font_GFX:
	dc.l $00000000, $00000000, $00666600, $06600660, $66606660, $66660660, $66006600, $06666000
	dc.l $00000000, $00000000, $00066600, $00606600, $00006600, $00066000, $00066000, $06666600
	dc.l $00000000, $00000000, $00666000, $06006600, $00006600, $00066000, $00660000, $06666600
	dc.l $00000000, $00000000, $06666600, $00006600, $00066000, $00006600, $06006600, $06666000
	dc.l $00000000, $00000000, $00066600, $00606600, $06006000, $66666660, $00066000, $00666000
	dc.l $00000000, $00000000, $00666600, $00600000, $00666600, $00000660, $06006660, $00666600
	dc.l $00000000, $00000000, $00066600, $00660000, $06666000, $66006600, $66006600, $66666000
	dc.l $00000000, $00000000, $06666600, $06006600, $00066000, $00660000, $06600000, $66600000
	dc.l $00000000, $00000000, $00666600, $06600660, $00666600, $06666000, $66006600, $06666000
	dc.l $00000000, $00000000, $00666600, $06600660, $06600660, $00666600, $00006600, $06666000
	dc.l $00000000, $00060000, $00666600, $06060000, $00666000, $00060600, $06666000, $00060000
	dc.l $00000000, $00000000, $00000000, $00000000, $06666660, $00000000, $00000000, $00000000
	dc.l $00000000, $00000000, $00000000, $06666660, $00000000, $06666660, $00000000, $00000000
	dc.l $00000000, $00006000, $00006600, $06666660, $06666660, $00006600, $00006000, $00000000
	dc.l $00000000, $00006000, $00006600, $06666660, $06666660, $00006600, $00006000, $00000000
	dc.l $00000000, $00000000, $06600660, $06600660, $00606600, $00666000, $06660000, $66600000
	dc.l $00000000, $00000000, $06666660, $00006600, $00066000, $00660000, $06600000, $66666600
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


		hex 00000000
		hex 00000000
		hex 00000000
		hex 00000000
		hex 00000000
		hex 06600000
		hex 06600000
		hex 00000000; dot

		hex 00000000
		hex 00000000
		hex 00000000
		hex 00000000
		hex 00000000
		hex 06600000
		hex 06600000
		hex 66000000; halfdotthingy

		hex 00000000
		hex 00066000
		hex 00066000
		hex 00660000
		hex 00660000
		hex 00000000
		hex 06600000
		hex 06600000; exclamation

		hex 00000000
		hex 00666600
		hex 06600660
		hex 00006600
		hex 00066000
		hex 00000000
		hex 00660000
		hex 00660000; question mark
tilend:
		even
; ===========================================================================
ErrorTrap:
		bra	offset(*)

VBlank:
		jsr	Pad_Read(pc)		; read pads

HBlank:
		rte

EntryPoint:
		move.w  #$100,($A11100).l
		move.w	VDP_Control_Port,d0
		lea	$A11100,a1
		move.b	-$10FF(a1),d0		; get hardware version	; 4
		andi.b	#$F,d0			; is this TMSS MD?
		beq.s	.skip			; if not, skip
		move.l	Console.w,$2F00(a1)	; do TMSS

.skip		lea	VDP_Control_Port,a0
		lea	-4(a0),a6
		lea	(a0),a5
		move.w	#$8154,(a0)
	fillVRAM	0,$10000,0		; fill VRAM with blank

		lea	VDPregs(pc),a1		; get register setup
		moveq	#$B-1,d0

.loop		move.l	(a1)+,(a0)		; move 2 register settings per move
		dbf	d0,.loop		; loop until 0

		move.l	#$C00C0000,(a0)		; CRAM write $A
		move.w	#$EEE,(a6)		; write the palette
		move.l	#$C0000000,(a0)		; CRAM write 0
		move.w	#0,(a6)			; write the palette

		lea	Font_GFX,a1
		move.l	#$46000000,(a0)
		move.w	#(($2D*32)/4)-1,d0

.lp		move.l	(a1)+,(a6)
		dbf	d0,.lp

	dma InitText, $C000, 15*2, VRAM
	dma Port1aText, $C100, 6*2, VRAM
	dma Port1bText, $C280, 6*2, VRAM
	dma Port1cText, $C400, 6*2, VRAM
	dma Port1dText, $C580, 6*2, VRAM
	dma ExtraText, $C700, 6*2, VRAM
	dma Port2aText, $C780, 6*2, VRAM
	dma Port2bText, $C900, 6*2, VRAM
	dma Port2cText, $CA80, 6*2, VRAM
	dma Port2dText, $CC00, 6*2, VRAM
	dma ExtraText, $CD80, 6*2, VRAM

.init
		st	PadPoll.w		; init pads
		move.b	#8,-$40.w		; counter

.run
		lea	Pad1Stats.w,a0		; load pad 1 stats table to a0
		lea	VRAM_Pad1(pc),a1	; load pad 1 VRAM stats to a1
		lea	Pad1Mode.w,a3		; load pad 1 mode to a3
		bsr.s	.dopad			; do pad code

		lea	Pad2Stats.w,a0		; load pad 2 stats table to a0
		lea	VRAM_Pad2(pc),a1	; load pad 2 VRAM stats to a1
		lea	Pad2Mode.w,a3		; load pad 2 mode to a3
		bsr.s	.dopad			; do pad code

		stop	#$2300
		subq.b	#1,-$40.w		; decrease counter
		bge.s	.run			; if >0, loop normally
		bra.s	.init
; ------------------------------------------------------------------------------

.dopad
		move.b	(a3)+,d0		; load control type
		bmi.s	.multitap		; process multitap
		lea	NotapText(pc),a3	; load data to a3
		jsr	WriteNextStdText(pc)	;

		pea	.clearextra(pc)		; clear extra shiz

		tst.b	d0			; check control type
		beq.w	.dopad3			; process pad3
		subq.b	#2,d0			; check 6-button pad and mouse
		bcs.w	.dopad6			; process pad6
		beq.w	.domouse		; process mouse

.emptypad
		addq.w	#4,a0			; skip pad data
		lea	NotapText(pc),a3	; load data to a3
		jsr	WriteNextStdText(pc)	;
		move.l	(a1)+,(a5)		; send VRAM write
		rts
; ------------------------------------------------------------------------------

.clearextra
	rept 6
		lea	NotapText(pc),a3	; load data to a3
		jsr	WriteNextStdText(pc)	;
	endr
		rts
; ------------------------------------------------------------------------------

.multitap
		and.b	#$7F,d0			; check if normal multitap
		beq.w	.teamplayer		; branch if so
		lea	EAText(pc),a3		; load data to a3
		jsr	WriteNextStdText(pc)	;

	rept 4
		lea	PadUnkText(pc),a3	; load data to a3
		jsr	WriteNextStdText(pc)	;
		bsr.s	.write6pad		; write pad
	endr
		rts
; ------------------------------------------------------------------------------

.dopad3
		lea	Pad3Text(pc),a3		; load data to a3
		jsr	WriteNextStdText(pc)	;
		bra.s	.write6pad		; share code with 3-button and 6-button
; ------------------------------------------------------------------------------

.dopad6
		lea	Pad6Text(pc),a3		; load data to a3
		jsr	WriteNextStdText(pc)	;
; ------------------------------------------------------------------------------

.write6pad
		move.l	(a1)+,(a5)		; send VRAM write
		lea	Pad6Buttons(pc),a4	; load button array to a4
		moveq	#12-1,d1		; load button count to d1

		move.w	(a0)+,d0		; load buttons to d0
		lsl.w	#4,d0			; skip empty buttons

.pad6loop
		move.w	(a4)+,d2		; load the character to d2
		add.w	d0,d0			; check the next button
		bcs.s	.pad6yes		; branch if pressed
		clr.w	d2			; clear character

.pad6yes
		move.w	d2,(a6)			; write to VRAM
		dbf	d1,.pad6loop		; loop for all of em
		addq.w	#2,a0			; skip pad data
		rts
; ------------------------------------------------------------------------------

.domouse
		lea	MouseText(pc),a3	; load data to a3
		jsr	WriteNextStdText(pc)	;

		move.l	(a1)+,(a5)		; send VRAM write
		lea	MouseButtons(pc),a4	; load button array to a4
		moveq	#12-1,d1		; load button count to d1

		move.w	(a0)+,d3		; load mouse movement to d0
		move.b	(a0)+,d0		; load buttons to d0
		bmi.s	.mouserror		; branch if error

.mousloop
		move.w	(a4)+,d2		; load the character to d2
		add.b	d0,d0			; check the next button
		bcs.s	.mousyes		; branch if pressed
		clr.w	d2			; clear character

.mousyes
		move.w	d2,(a6)			; write to VRAM
		dbf	d1,.mousloop		; loop for all of em

		move.w	#0,(a6)			; write space
		bsr.s	WriteNumberByte2	; write mouse byte
		move.w	#0,(a6)			; write space
		bra.s	WriteNumberByte2	; write mouse byte
; ------------------------------------------------------------------------------

.mouserror
		lea	ErrorText(pc),a3	; load data to a3
		moveq	#8-1,d6			; set text len
		jmp	WriteText(pc)		;
; ------------------------------------------------------------------------------

.teamplayer
		move.b	1(a3),d7		; load control bits
		lea	MultitapText(pc),a3	; load data to a3
		jsr	WriteNextStdText(pc)	;

		bsr.s	.tpcheck		; check next pad
		bsr.s	.tpcheck		; check next pad
		bsr.s	.tpcheck		; check next pad
;		bsr.s	.tpcheck		; check next pad
		nop				;
; ------------------------------------------------------------------------------

.tpcheck
		moveq	#3,d0			; get button mask to d0
		and.b	d7,d0			; AND with actual buttons
		lsr.b	#2,d7			; shift buttons away

		add.w	d0,d0			; quadruple offset
		add.w	d0,d0			;
		jmp	.offs(pc,d0.w)		; jump to handler
; ------------------------------------------------------------------------------

.offs
		bra.w	.dopad3			; 3-button pad
		bra.w	.dopad6			; 6-button pad
		bra.w	.unknown		; unknown device
		bra.w	.emptypad		; no pad attached
; ------------------------------------------------------------------------------

.unknown
		addq.w	#4,a0			; skip pad data
		lea	InvalidText(pc),a3	; load data to a3
		jsr	WriteNextStdText(pc)	;
		move.l	(a1)+,(a5)		; send VRAM write
		rts
; ------------------------------------------------------------------------------

WriteNumberAddr2:
		moveq	#6-1,d6			; set up nibbles in num
		bra.s	WriteNumberLoop		; write the number then!

WriteNumberByte2:
		moveq	#2-1,d6			; set up nibbles in num

WriteNumberLoop:
		move.w	d6,d4			; copy length
.loop2		move.b	d3,d2			; get next nibble
		andi.w	#%1111,d2		; keep the nibble only
		add.b	#$30,d2			; increment 1 (to skip null)
		move.w	d2,-(sp)		; then store the number on plane
		ror.l	#4,d3			; rotate right four times, to get the next nibble.
						; Also returns d3 to original value
		dbf	d6,.loop2		; loop until full number is done

.write		move.w	(sp)+,(a6)		; copy number to VRAM
		dbf	d4,.write		; write for so many bytes as we need
		rts

WriteNextStdText:
		moveq	#8-1,d6			; set text len
		move.l	(a1)+,(a5)		; send VRAM write

WriteText:
		move.w	(a3)+,(a6)		; write a character to VRAM
		dbf	d6,WriteText		; loop for all chars
		rts
; ------------------------------------------------------------------------------

VRAM_Pad1:	dc.l $47200003			; extra
		dc.l $41200003, $41820003	; pad 1a
		dc.l $42A00003, $43020003	; pad 1b
		dc.l $44200003, $44820003	; pad 1c
		dc.l $45A00003, $46020003	; pad 1d

VRAM_Pad2:	dc.l $4DA00003			; extra
		dc.l $47A00003, $48020003	; pad 2a
		dc.l $49200003, $49820003	; pad 2b
		dc.l $4AA00003, $4B020003	; pad 2c
		dc.l $4C200003, $4C820003	; pad 2d
; ------------------------------------------------------------------------------

	include "joy.asm"

MultitapText:	asc "MULTITAP"
EAText:		asc "EA 4WAY "
PadUnkText:	asc "X-BUTTON"
NotapText:	asc "        "
InvalidText:	asc "INVALID "
Pad6Text:	asc "6-BUTTON"
Pad3Text:	asc "3-BUTTON"
MouseText:	asc "MOUSE   "
ErrorText:	asc "ERROR   "

InitText:	asc "JOYPAD TEST ROM"
ExtraText:	asc "EXTRA "
Port1aText:	asc "PORT1A"
Port1bText:	asc "PORT1B"
Port1cText:	asc "PORT1C"
Port1dText:	asc "PORT1D"
Port2aText:	asc "PORT2A"
Port2bText:	asc "PORT2B"
Port2cText:	asc "PORT2C"
Port2dText:	asc "PORT2D"

Pad6Buttons:	asc "MXYZSACBRLDU"
MouseButtons:	asc "OOXXSMRL"

EndOfRom:
	END
