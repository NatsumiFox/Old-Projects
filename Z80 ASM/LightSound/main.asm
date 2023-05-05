	opt op+
	OPT L.

	include "LANG.ASM"

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

	rept 40-ct
		dc.w 0	; space
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

pad1 =		$FFFF8000

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
Console:	dc.b "SEGA           A"
		dc.b "URORA 2020/10/04"
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
		bra.w	*

VBlank:
		lea	$A10003,a1
		lea	pad1.w,a0		; endpoint ctrl
		moveq	#0,d2
		moveq	#$40,d3			; TH hi

		move.b	d2,(a1)			; set TH low
		or.l	d0,d0			; delay
		move.b	(a1),d4			; Get controller port data (start/A)
		move.b	d3,(a1)			; set TH high
		andi.b	#$30,d4
		lsl.b	#2,d4

		move.b	(a1),d1			; Get controller port data (B/C/Dpad)
		andi.b	#$3F,d1
		or.b	d1,d4			; Fuse together into one controller bit array
		not.b	d4

		move.b	(a0),d1			; Get press button data
		eor.b	d4,d1			; Toggle off buttons that are being held
		move.b	d4,(a0)+		; Put raw controller input (for held buttons) in F604/F606
		and.b	d4,d1
		move.b	d1,(a0)+		; Put pressed controller input in F605/F607


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
		lea	-4(a0),a2

		fillVRAM 0,$10000,0		; fill VRAM with blank

.waitFillDone	move.w	(a5),d1
		btst	#1,d1
		bne.s	.waitFillDone		; wait until fill is done

	; load Z80 driver
		move.w	#$0100,$A11100		; request Z80 stop
		move.w	#$0100,$A11200		; Z80 reset off

		lea	SoundDriver.w,a4	; load sound driver address into a0
		lea	$A00000,a1		; load Z80 RAM address into a1
		move.w	#SoundDriver_Sz-1,d0	; set sound driver size to d0

.ldz80
		btst	#$00,$A11100		; check if Z80 has stopped
		bne.s	.ldz80			; if not, wait more

.loadz80
		move.b	(a4)+,(a1)+		; copy 1 byte at a time.. yay!
		dbf	d0,.loadz80		; load every byte
		move.w	#$0000,$A11200		; request Z80 reset

		lea	VDPregs(pc),a1		; get register setup
		moveq	#$B-1,d0

.loop		move.l	(a1)+,(a0)		; move 2 register settings per move
		dbf	d0,.loop		; loop until 0

		move.l	#$C00C0000,(a5)		; CRAM write $A
		move.w	#$EEE,-4(a5)		; write the palette
		move.l	#$C0000000,(a5)		; CRAM write 0
		move.w	#0,-4(a5)		; write the palette

		lea	Font_GFX,a0
		move.l	#$46000000,(a5)
		move.w	#(($2D*32)/4)-1,d0

.lp		move.l	(a0)+,-4(a5)
		dbf	d0,.lp

	dma InitText, $C000, 13*2, VRAM

		move.w	#$0000,$A11100		; enable Z80
		move.w	#$0100,$A11200		; Z80 reset off

		moveq	#1,d0			; sound id

.main
		stop	#$2300

		tst.b	pad1+1.w		; check if start was pressed
		bpl.s	.nostart		; branch if no
		move.w	#$0100,$A11100		; request Z80 stop

.z80
		btst	#$00,$A11100		; check if Z80 has stopped
		bne.s	.z80			; if not, wait more
		move.b	d0,$A00000+LS_Queue	; send to sound queue
		move.w	#$0000,$A11100		; enable Z80

.nostart
		btst	#2,pad1+1.w		; check up
		sne	d1			; if so, set d1
		add.b	d1,d0			; sub 1 if was set

		btst	#3,pad1+1.w		; check down
		sne	d2			; if so, set d1
		sub.b	d2,d0			; add 1 if was set

		add.b	d2,d1			; add d2 to d1
		beq.s	.main			; if both 0 branch

		move.l	#$40160003,(a5)
		move.b	d0,d3			; copy number to d3
		bsr.s	WriteNumberByte2	; write to VDP
		bra.s	.main


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

.write		move.w	(sp)+,(a2)		; copy number to VRAM
		dbf	d4,.write		; write for so many bytes as we need
		rts


InitText:	asc "PLAY SOUND 01"

SoundDriver:
	z80prog 0						; start a new z80 program
		include "Z80.asm"				; include Z80 sound driver
SoundDriver_Sz:
	z80prog
EndOfRom:
	END
