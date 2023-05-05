	opt op+

VDP_Data_Port		equ $C00000
VDP_Control_Port	equ $C00004
VDP_Counter		equ $C00008

fillVRAM macro value,length,loc
	lea	vdp_control_port,a5
	move.w	#$8F01,(a5)
	move.l	#$94000000+((length&$FF00)<<8)+$9300+(length&$FF),(a5)
	move.w	#$9780,(a5)
	move.l	#$40000080+((loc&$3FFF)<<16)+((loc&$C000)>>14),(a5)
	move.w	#value,vdp_data_port-VDP_Control_Port(a5)
    endm

; macro to issue DMA's
dma macro	source,dest,length,type
	move.l	#(($9400|((((length)>>1)&$FF00)>>8))<<16)|($9300|(((length)>>1)&$FF)),(a5)
	move.l	#(($9600|((((source)>>1)&$FF00)>>8))<<16)|($9500|(((source)>>1)&$FF)),(a5)
	move.l	#(($9700|(((((source)>>1)&$FF0000)>>16)&$7F))<<16)|((((dest)&$3FFF)|((type&1)<<15)|$4000)),(a5)
	move.w	#$80|(((dest)&$C000)>>14)|((type&2)<<3),(a5)
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
		dc.w \c-7
	endif
    endm
; ===========================================================================
Maincode	section org(0)
		dc.l $E01000, EntryPoint, ErrorTrap, ErrorTrap
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
		dc.b "SEGA MEGA DRIVE SRAM TEST                       "
		dc.b "SEGA MEGA DRIVE SRAM TEST                       "
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
	dc.l $00000000, $00060000, $00666600, $06060000, $00666000, $00060600, $06666000, $00060000
	dc.l $00000000, $00000000, $00000000, $00000000, $06666660, $00000000, $00000000, $00000000
	dc.l $00000000, $00000000, $00000000, $06666660, $00000000, $06666660, $00000000, $00000000
	dc.l $00000000, $00006000, $00006600, $06666660, $06666660, $00006600, $00006000, $00000000
	dc.l $00000000, $00006000, $00006600, $06666660, $06666660, $00006600, $00006000, $00000000
	dc.l $00000000, $00000000, $06600660, $06600660, $00606600, $00666000, $06660000, $66600000
	dc.l $00000000, $00000000, $06666660, $00006600, $00066000, $00660000, $06600000, $66666600
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
		bra.s	offset(*)

HBlank:
		rte

VBlank:
		tst.w	(a4)			; check if this is the first pass
		beq.s	.nowrite		; if so, branch
		move.l	(a4),(a5)		; set VDP mode
		neg.w	d3
		jsr	WriteNumberWord.w	; write long

.nowrite	addq.w	#4,a4			; skip over the long
		moveq	#-1,d3			; clear counter
		move.l	(a4)+,2(sp)		; set new return routine
		rte
; ===========================================================================

WriteNumberWord:
		moveq	#4-1,d6			; set up nibbles in num

WriteNumberLoop:
		move.w	d6,d4			; copy length
.loop2		move.b	d3,d2			; get next nibble
		andi.w	#%1111,d2		; keep the nibble only
		add.b	#$30,d2			; increment 1 (to skip null)
		move.w	d2,-(sp)		; then store the number on plane
		ror.l	#4,d3			; rotate right four times, to get the next nibble.
						; Also returns d3 to original value
		dbf	d6,.loop2		; loop until full number is done

.write		move.w	(sp)+,(a2)		; copy number to VRAM
		dbf	d4,.write		; write for so many bytes as we need
		rts
; ===========================================================================

EntryPoint:
		lea	VDP_Control_Port,a0
		move.w  #$100,($A11100).l
		tst.w	(a0)
		lea	$A11100,a1
		move.b	-$10FF(a1),d0		; get hardware version	; 4
		andi.b	#$F,d0			; is this TMSS MD?
		beq.s	.skip			; if not, skip
		move.l	Console.w,$2F00(a1)	; do TMSS

.skip		lea	-4(a0),a2
		fillVRAM 0,$10000,0		; fill VRAM with blank

.waitFillDone	move.w	(a5),d1
		btst	#1,d1
		bne.s	.waitFillDone		; wait until fill is done

		lea	VDPregs(pc),a1		; get register setup
		moveq	#$B-1,d0

.loop		move.l	(a1)+,(a0)		; move 2 register settings per move
		dbf	d0,.loop		; loop until 0

		lea	-4(a5),a6		; VDP DATA
		move.l	#$C00C0000,(a5)		; CRAM write $A
		move.w	#$EEE,(a6)		; write the palette
		move.l	#$C0000000,(a5)		; CRAM write 0
		move.w	#0,(a6)			; write the palette

		lea	Font_GFX,a0
		move.l	#$46000000,(a5)
		move.w	#(($2D*32)/4)-1,d0

.lp		move.l	(a0)+,(a6)
		dbf	d0,.lp

		; did not match
		lea	TestVals(pc),a0
		moveq	#5-1,d2

.loadtext	move.l	(a0)+,(a5)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		dbf	d2,.loadtext
		lea	WriteOffs(pc),a4

WaitVint:
		stop	#$2300			; wait for VBL
		stop	#$2700
; ===========================================================================

CheckNopLoop:
	rept 6
		nop
	endr
		dbf	d3,CheckNopLoop
		stop	#$2700
; ===========================================================================

CheckRegLoop:
	rept 6
		move.w	d3,d3
	endr
		dbf	d3,CheckNopLoop
		stop	#$2700
; ===========================================================================

CheckRAMLoop:
	rept 3
		move.w	d3,$FFFF8000.w
	endr
		dbf	d3,CheckNopLoop
		stop	#$2700
; ===========================================================================

CheckVRAMLoop:
		move.l	#$4C000000,(a5)
.loopv		move.w	d3,(a6)
		dbf	d3,.loopv
		stop	#$2700
; ===========================================================================

CheckCRAMLoop:
		move.l	#$C0680000,d7
.loopc		move.l	d7,(a5)
		move.w	d3,(a6)
		dbf	d3,.loopc

StopCPU:
		stop	#$2700
; ===========================================================================

TestVals:
	dc.l $40840003
	asc "NOP "
	dc.l $41040003
	asc "REG "
	dc.l $41840003
	asc "RAM "
	dc.l $42040003
	asc "VRAM"
	dc.l $42840003
	asc "CRAM"

WriteOffs:
	dc.l 0
	dc.l WaitVint
	dc.l 0
	dc.l CheckNopLoop
	dc.l $408E0003
	dc.l CheckRegLoop
	dc.l $410E0003
	dc.l CheckRAMLoop
	dc.l $418E0003
	dc.l CheckVRAMLoop
	dc.l $420E0003
	dc.l CheckCRAMLoop
	dc.l $428E0003
	dc.l StopCPU


EndOfRom:
	END
