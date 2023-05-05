	opt op+
	opt l.

	include	"error/Debugger.asm"

VDP_Data_Port		equ $C00000
VDP_Control_Port	equ $C00004
VDP_Counter		equ $C00008
pad1 =			$FFFFFFF0
romaddr =		$FFFFFFEC
padbit =		$FFFFFFEB
bittime =		$FFFFFFEA
checkall =		1

fillVRAM macro value,length,loc
	lea	vdp_control_port,a5
	move.w	#$8F01,(a5)
	move.l	#$94000000+((length&$FF00)<<8)+$9300+(length&$FF),(a5)
	move.w	#$9780,(a5)
	move.l	#$40000080+((loc&$3FFF)<<16)+((loc&$C000)>>14),(a5)
	move.w	#value,vdp_data_port-VDP_Control_Port(a5)
    endm

; ===========================================================================
vdpComm		macro ins,addr,type,rwd,end,end2
	if narg=5
		\ins #(((\type&\rwd)&3)<<30)|(((\addr)&$3FFF)<<16)|(((\type&\rwd)&$FC)<<2)|(((\addr)&$C000)>>14), \end

	elseif narg=6
		\ins #(((((\type&\rwd)&3)<<30)|(((\addr)&$3FFF)<<16)|(((\type&\rwd)&$FC)<<2)|(((\addr)&$C000)>>14))\end, \end2

	else
		\ins (((\type&\rwd)&3)<<30)|(((\addr)&$3FFF)<<16)|(((\type&\rwd)&$FC)<<2)|(((\addr)&$C000)>>14)
	endif
    endm

; ===========================================================================
; values for the type argument
VRAM =  %100001
CRAM =  %101011
VSRAM = %100101

; values for the rwd argument
READ =  %001100
WRITE = %000111
DMA =   %100111

; ===========================================================================
; tells the VDP to copy a region of 68k memory to VRAM or CRAM or VSRAM
dma68kToVDP	macro source,dest,length,type
		move.l	#(($9400|((((length)>>1)&$FF00)>>8))<<16)|($9300|(((length)>>1)&$FF)),(a5)
		move.l	#(($9600|((((source)>>1)&$FF00)>>8))<<16)|($9500|(((source)>>1)&$FF)),(a5)
		move.w	#$9700|(((((source)>>1)&$FF0000)>>16)&$7F),(a5)
	vdpComm	move.l,\dest,\type,DMA,(a5)
    endm
; ===========================================================================
Maincode	section org(0)
		dc.l $FFFF1000, EntryPoint, BusError, AddressError
		dc.l IllegalInstr, ZeroDivide, ChkInstr, TrapvInstr
		dc.l PrivilegeViol, Trace, Line1010Emu,	Line1111Emu
		dc.l ErrorExcept, ErrorExcept, ErrorExcept, ErrorExcept
		dc.l ErrorExcept, ErrorExcept, ErrorExcept, ErrorExcept
		dc.l ErrorExcept, ErrorExcept, ErrorExcept, ErrorExcept
		dc.l ErrorExcept, ErrorTrap, ErrorTrap,	ErrorTrap
		dc.l VBlank, ErrorTrap, VBlank, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
ConsoleStr:	dc.b "SEGA            "
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
		dc.b '            '
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
		incbin "font.unc"
tilend:
		even
; ===========================================================================

InitialLoc:
	exg	d0,d0

VBlank:
HBlank:
		rte
; ===========================================================================

EntryPoint:
		move.w  #$100,($A11100).l
		move.w	VDP_Control_Port,d0
		lea	$A11100,a1
		move.b	-$10FF(a1),d0		; get hardware version	; 4
		andi.b	#$F,d0			; is this TMSS MD?
		beq.s	.skip			; if not, skip
		move.l	ConsoleStr.w,$2F00(a1)	; do TMSS

.skip		lea	VDP_Control_Port,a0
		lea	-4(a0),a2

		fillVRAM 0,$10000,0		; fill VRAM with blank

.waitFillDone	move.w	(a5),d1
		btst	#1,d1
		bne.s	.waitFillDone		; wait until fill is done

		lea	VDPregs(pc),a1		; get register setup
		moveq	#$B-1,d0

.loop		move.l	(a1)+,(a0)		; move 2 register settings per move
		dbf	d0,.loop		; loop until 0

		move.l	#$C0000000,(a0)		; CRAM write 0
		move.l	#$02220CCC,(a2)		; WHITE
		move.l	#$0AAA0888,(a2)
	rept 12/2
		move.l	d0,(a2)
	endr
		move.l	#$00000ECA,(a2)		; BLUE
		move.l	#$0CA80A86,(a2)
	rept 12/2
		move.l	d0,(a2)
	endr
		move.l	#$0000066E,(a2)		; RED
		move.l	#$044E022E,(a2)
	rept 12/2
		move.l	d0,(a2)
	endr
		move.l	#$000004C2,(a2)		; GREEN
		move.l	#$02A00280,(a2)

		lea	Font_GFX,a1
	vdpComm	move.l,$0000,VRAM,WRITE,(a0)	; write to $0000
		move.w	#(filesize("font.unc")/4)-1,d0

.lp		move.l	(a1)+,(a2)
		dbf	d0,.lp

		if checkall=0
	; this code here actually requests anything being written onscreen
		move.l	#InitialLoc,romaddr.w	; reset romaddr

.redo
		move.l	romaddr.w,a0		; source address
		move.b	#28-1,-5.w		; repeat count
	vdpComm	move.l,$C000,VRAM,WRITE,VDP_Control_Port; write onscreen

.dec
		move.l	0.w,a1			; destination address
		jsr	Decode68k		; decode it

		lea	VDP_Data_Port,a2
		move.l	0.w,a1			; source address

		moveq	#64-2,d0		; set tile count
		moveq	#0,d1			; prepare 0

.write
		move.w	(a1)+,(a2)		; write to VRAM
		dbeq	d0,.write		; loop for max 64 times

		tst.w	d0			; check if all writes are done
		bmi.s	.chk			; if so, do not clear

.clear
		move.w	d1,(a2)			; write to VRAM
		dbf	d0,.clear		; loop for max 64 times

.chk
		subq.b	#1,-5.w			; sub counter
		bpl.s	.dec			; branch if more lines to do

.stop
		stop	#$2300			; wait for v-int
		bsr.s	ReadPad

	; check pad
		moveq	#3,d0			; set bit check to d0

.ck
		btst	d0,pad1.w		; check if held
		dbne	d0, .ck			; loop until bit found

		cmp.b	padbit.w,d0		; check if bit is same
		beq.s	.same			; branch if yes
		move.b	#30,bittime.w		; set timer
		move.b	d0,padbit.w		; save pad bit
		bra.s	.dopad			; do pad

.same
		subq.b	#1,bittime.w		; decrement timer
		bcc.s	.stop			; branch if no underflow
		addq.b	#1,bittime.w		; fix timer

.dopad
		cmp.b	#2,d0			; check left
		bne.s	.nol			; branch if not
		sub.l	#$100,romaddr.w		; move romaddr up
		bra.w	.redo

.nol
		cmp.b	#3,d0			; check right
		bne.s	.nor			; branch if not
		add.l	#$100,romaddr.w		; move romaddr down
		bra.w	.redo

.nor
		cmp.b	#0,d0			; check up
		bne.s	.noup			; branch if not
		subq.l	#2,romaddr.w		; move romaddr up
		bra.w	.redo

.noup
		cmp.b	#1,d0			; check down
		bne.s	.stop			; branch if not

		move.l	romaddr.w,a0		; source address
		move.l	0.w,a1			; destination address
		jsr	Decode68k		; decode it
		move.l	a0,romaddr.w		; save as new ROM addr
		bra.w	.redo
; ===========================================================================

ReadPad:
		lea	$A10003,a1
		lea	pad1.w,a0		; endpoint ctrl
		moveq	#0,d2
		moveq	#$40,d3			; TH hi

		move.b	d2,(a1)			; set TH low
		or.l	d0,d0			; delay
		move.b	(a1),d0			; Get controller port data (start/A)
		move.b	d3,(a1)			; set TH high
		andi.b	#$30,d0
		lsl.b	#2,d0

		move.b	(a1),d1			; Get controller port data (B/C/Dpad)
		andi.b	#$3F,d1
		or.b	d1,d0			; Fuse together into one controller bit array
		not.b	d0

		move.b	(a0),d1			; Get press button data
		eor.b	d0,d1			; Toggle off buttons that are being held
		move.b	d0,(a0)+		; Put raw controller input (for held buttons) in F604/F606
		and.b	d0,d1
		move.b	d1,(a0)+		; Put pressed controller input in F605/F607
		rts

	else
; ---------------------------------------------------------------------------

		move.l	#Test_HEX,a0		; load hex test address to memory
		move.l	#Test_ASM,-6.w		; load text test address to memory
		clr.w	-2.w			; store counter to memory
; ---------------------------------------------------------------------------

.test
;	stop	#$2300
		move.l	0.w,a1			; destination address
		jsr	Decode68k		; decode it

		move.l	a1,a2			; copy string start to a2
		move.w	-2.w,(a3)+		; copy position to stack
		jsr	d68k_PrintWord(pc)	; print d1

		lea	VDP_Data_Port,a1	; load control port to a1
	vdpComm	move.l,$C002,VRAM,WRITE,4(a1)	; write onscreen
		move.l	(a2)+,(a1)		; copy data
		move.l	(a2)+,(a1)		;
		move.w	(a2)+,(a1)		;

	vdpComm	move.l,$C080,VRAM,WRITE,4(a1)	; write onscreen
		move.l	0.w,a2			; buffer address
		moveq	#64-2,d0		; set tile count
		moveq	#0,d1			; prepare 0

.write
		move.w	(a2)+,(a1)		; write to VRAM
		dbeq	d0,.write		; loop for max 64 times

		tst.w	d0			; check if all writes are done
		bmi.s	.c1			; if so, do not clear

.clear
		move.w	d1,(a1)			; write to VRAM
		dbf	d0,.clear		; loop for max 64 times

.c1
		move.l	-6.w,a2			; buffer address
		moveq	#64-2,d0		; set tile count
		moveq	#0,d1			; prepare 0

.write2
		move.b	(a2)+,d2
		move.w	d2,(a1)			; write to VRAM
		dbeq	d0,.write2		; loop for max 64 times

		tst.w	d0			; check if all writes are done
		bmi.s	.c2			; if so, do not clear

.clear2
		move.w	d1,(a1)			; write to VRAM
		dbf	d0,.clear2		; loop for max 64 times
; ---------------------------------------------------------------------------

	; compare
.c2
		move.l	-6.w,a2			; buffer address
		move.l	0.w,a1			; destination address

.cmp
		tst.b	(a2)			; check if buffer end
		beq.s	.end			; branch if so
		addq.l	#1,a1			; skip first byte
		cmpm.b	(a2)+,(a1)+		; check if they are the same
		beq.s	.cmp			; if so, branch

.fail
		bra.w	*			; freeze
; ---------------------------------------------------------------------------

.end
		tst.b	1(a1)			; check if both buffers end
		bne.s	.fail			; branch if fail
		addq.l	#1,a2			; skip end token
		move.l	a2,-6.w			; save buffer address

		addq.w	#1,-2.w			; go to next test
		bcc.w	.test
		bra.w	*			; done
; ---------------------------------------------------------------------------
	endif

	include "decode slow.asm"		; 68k decoder
Test_HEX:	incbin "test.bin"		; binary test data
Test_ASM:	incbin "test.asm"		; text test data

	opt ae+
		include	"error/ErrorHandler.asm"

.len =		Test_HEX-Decode68k		; 68k decoder size
	inform 0,"Decoder is $\$.len bytes!"

EndOfRom:
	END
