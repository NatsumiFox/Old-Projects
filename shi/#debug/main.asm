	include "#debug/string.asm"

; ===========================================================================
VSync:
		stop	#$2500
		rts

; ===========================================================================
DebugVBlank:
		movem.l	d0-d1/a0-a1,-(sp)
		jsr	ControllerInput
		movem.l	(sp)+,d0-d1/a0-a1

DebugHBlank:
		rte
; ===========================================================================
	rsset $FFFF0000
Crash_D0	rs.l 1
Crash_D1	rs.l 1
Crash_D2	rs.l 1
Crash_D3	rs.l 1
Crash_D4	rs.l 1
Crash_D5	rs.l 1
Crash_D6	rs.l 1
Crash_D7	rs.l 1
Crash_A0	rs.l 1
Crash_A1	rs.l 1
Crash_A2	rs.l 1
Crash_A3	rs.l 1
Crash_A4	rs.l 1
Crash_A5	rs.l 1
Crash_A6	rs.l 1
Crash_A7	rs.l 1
Crash_System_Stack	rs.b $100
Crash_System_StackPtr	rs.b 0
Crash_SR	rs.w 1
CrashID		rs.b 1		; the ID of crash which is recorded for later reference.
CrashStckFrm	rs.b 1		; the size of the System_Stack frame for the interrupt
Crash_RAM	rs.w 1		; current RAM offset
Crash_VRAM	rs.w 1		; current VRAM offset
Crash_CRAM	rs.b 1		; current CRAM offset
Crash_VSRAM	rs.b 1		; current VSRAM offset
Crash_SFX	rs.b 1		; sfx number being played
; ===========================================================================
AddressError:	crash  0,14
ErrorExcept:	crash  2, 6
IllegalInstr:	crash  4, 6
ZeroDivide:	crash  6, 6
ChkInstr:	crash  8, 6
TrapvInstr:	crash 10, 6
PrivilegeViol:	crash 12, 6
Trace:		crash 14, 6
Line1010Emu:	crash 16, 6
Line1111Emu:	crash 18, 6
	if debug=1
LevelLagError:	crash 20, 0
	endif
; ===========================================================================
CrashHandler:; initialize the system
		movem.l	d0-a7,Crash_D0			; store registers to RAM
		move	#$2700,sr			; disable ints
		move.l	#DebugVBlank,VInt_Addr.w
		move.l	#DebugHBlank,HInt_Addr.w

		lea	VDP_control_port,a5		; get VDP data port for writing
		move.l	#$C0000000,(a5)			; CRAM write 0
		move.l	#$2222EEEE,-4(a5)		; write transparent and first colour
		move.w	#$6666,-4(a5)			; write secondary font colour

		move.l	#$40000010,(a5)			; VSRAM write
		move.l	#0,-4(a5)			; write null
	dmaFillVRAM 0, $C000, $4000

		lea	DebugRegisters(pc),a0		; get debug registers
		movem.w	(a0)+,d0-d2			; get variables

.doloop		move.b	(a0)+,d1			; add $8000 to value
		move.w	d1,(a5)				; move value to	VDP register
		add.w	d2,d1				; next register
		dbf	d0,.doloop

		moveq	#0,d0
		move.b	CrashStckFrm,d0			; get System_Stack frame size
		add.l	d0,Crash_A7			; sub System_Stack frame size from A7
		lea	Crash_System_StackPtr,a0	; get crash System_Stack RAM

	; ensure System_Stack is null, so we can more cleanly display System_Stack
		moveq	#0,d1				; fill 0
		moveq	#($100/4)-1,d0			; get size of System_Stack
.clr		move.l	d1,-(a0)			; clear long
		dbf	d0,.clr				; loop until clear

	; calculate the amount of used System_Stack
		move.w	#System_Stack,d0		; get System_Stack start address to d0
		sub.w	a7,d0				; sub System_Stack address from d0
		bmi.s	.noSystem_Stack; ERROR:	System_Stack underflow
		lsr.w	#1,d0				; halve the length

	; now we are copying the used System_Stack to separate RAM
		lea	Crash_System_StackPtr,a0	; get crash System_Stack RAM
		lea	System_Stack,a7			; get normal System_Stack RAM
.copy		move.w	-(a7),-(a0)			; copy next word
		dbf	d0,.copy			; loop until done

	; write error name to screen
.noSystem_Stack	moveq	#0,d6				; length of write
		move.b	CrashID,d6			; get crash ID
		lea	CrashNames(pc),a0		; get crash name strings
		adda.w	(a0,d6.w),a0			; add the offset to name
		moveq	#1,d4				; x-position to write to
		moveq	#0,d5				; y-position to write to
		moveq	#30-1,d6			; length of the string
		jsr	WriteString2			; display error message

	; wirte some information and USP
		lea	ConditionCodeStr(pc),a0		; get CCR field string
		jsr	WriteString3			; display it
		move.l	usp,a0				; get usp
		move.l	a0,d3				; put to d3
		moveq	#0,d2				; no or
		jsr	WriteNumberAddr2		; display

	; start by writing frame for CCR values
		lea	ConditionCodeStr2(pc),a0	; get CCR field string 2
		jsr	WriteString3			; display it

	; write CCR to screen
		move.w	Crash_SR,d3			; get status register
		moveq	#5-1,d0				; get the amount of CCR bits
.doccr		moveq	#$49,d1				; no selection
		btst	d0,d3				; test if condition was set
		beq.s	.not				; branch if not
		moveq	#$48,d1				; has selection
.not		move.w	d1,(a6)				; write map to VDP
		dbf	d0,.doccr			; loop until all is done

	; next write Status Register value. Clears out CCR
		andi.b	#$E0,d3				; clear ccr
		move.w	d3,-(sp)

	; next write PC register info
		lea	pcErrorStr(pc),a0		; get PC string
		jsr	WriteString3			; display

		move.l	Crash_A7,d0			; get old System_Stack ptr
		sub.l	#System_Stack-Crash_System_StackPtr,d0; sub the System_Stack dfference from System_Stack ptr
		movea.l	d0,a0				; get the final System_Stack address to a0
		move.l	-4(a0),d3			; get the PC addredd to d3
		moveq	#0,d2				; no or
		jsr	WriteNumberAddr2		; finally write to display

	; write status register
		lea	srErrorStr(pc),a0		; get SR string
		moveq	#1,d5				; y-position
		moveq	#$16,d4				; x-position
		jsr	WriteString1			; display it
		move.w	(sp)+,d3			; get status register num
		jsr	WriteNumberWord2		; display value

	; write d0-a7
		moveq	#0,d4				; x-position to write to
		moveq	#4,d5				; y-position to write to
		jsr	SetupStringWrite		; set position to write to

		lea	d0ErrorStr(pc),a0		; get the strings
		lea	Crash_D0,a1			; get values
		moveq	#8+8-1,d0			; this is the amount of registers

.regsloop	jsr	WriteString3			; display regsiter string
		move.l	(a1)+,d3			; get register value
		jsr	WriteNumberLong2		; display value
		dbf	d0,.regsloop			; loop for each register

	; next write entire System_Stack after the point it was used
		move.l	Crash_A7,a1			; get System_Stack ptr to a0
		move.l	a1,d1				;
		sub.l	#System_Stack_Start,d1	; sub System_Stack addr
		move.l	#$100,d0			; get System_Stack size
		sub.l	d1,d0				; sub System_Stack size from used size
		beq.s	.stackdone			; Special case: no System_Stack history
		bmi.s	.stackdone			; Special case: System_Stack underflow
		move.w	d0,-(sp)			; store size of System_Stack to System_Stack
		lsr.w	#1,d0				; shift right once
		subq.w	#1,d0				; sub 1 for dbf
		sub.l	#System_Stack-Crash_System_StackPtr,a1; sub the System_Stack dfference from System_Stack ptr

		moveq	#5-1,d1				; set amount of writes per line
		moveq	#0,d2				; no or for numbers
		move.w	#5,-(sp)			; store x-position to System_Stack
		move.w	#13,-(sp)			; store y-position to System_Stack

.nextLine	moveq	#0,d4				; x-position
		move.w	(sp),d5				; get y-position from System_Stack
		lea	spWriteStr(pc),a0		; get the line start string.
		jsr	WriteString1			; display it

		move.w	4(sp),d3			; get the offset in the System_Stack
		moveq	#2-1,d6				; 3 digits
		jsr	WriteNumberLoop			; write the offset number
		move.w	#$29,(a6)			; write : (colon)

.nextvalue	move.w	(a1)+,d3			; get next word
		move.w	(sp),d5				; get y-position from System_Stack
		move.w	2(sp),d4			; get x-position from System_Stack
		jsr	WriteNumberWord1		; display value

		add.w	#5,2(sp)			; advance x-position
		sub.w	#2,4(sp)			; sub 2 bytes from System_Stack size left
		subq.w	#1,d0				; sub 1 from items left
		bmi.s	.stackdone			; if negative, stop
		dbf	d1,.nextvalue			; loop until line is done

		add.w	#1,(sp)				; go to next line
		move.w	#5,2(sp)			; reset x-offset
		moveq	#5-1,d1				; set amount of writes per line
		bra.s	.nextLine

.stackdone	addq.w	#6,sp				; clear out our variables from System_Stack

	; next run special code for special errors
		moveq	#0,d0
		move.b	CrashID,d0			; get crash ID to d0
		move.w	CrashCodeTable(pc,d0.w),d0	; get offset value to d0
		jsr	CrashCodeTable(pc,d0.w)		; then jump to appropriate code

	; load font
		lea	DebugFont,a0			; get font
		lea	$FF0000,a1			; get start of RAM
		jsr	KosDec				; decompress the art
		lea	VDP_control_port,a5
	dma68kToVDP	$FF0000, $20, $BC0, VRAM	; DMA font art
		moveq	#0,d0

	; then poll for controllers until Start+A has been pressed, then reset.
.wait		jsr	VSync(pc)			; wait to poll controllers and next frame
		move.b	Ctrl_1_Held.w,d0		; get p1 held buttons
		or.b	Ctrl_2_Held.w,d0		; or p2 held buttons
		bpl.s	.wait				; if start was not pressed, wait more

		btst	#5,d0				; was C pressed?
		bne.w	DebugSelect			; if was, branch
		btst	#6,d0				; was A pressed?
		beq.s	.wait				; if not, branch
		jmp	EntryPoint2			; reset the game
; ===========================================================================
CrashCodeTable:
	dc.w .addresserror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	if debug=1
		dc.w .nullerror-CrashCodeTable
	endif

.nullerror	rts		; nothing here

.addresserror; write instruction register. Instruction register holds the first word of the opcode in MC68000
		move.l	Crash_A7,a1			; get crash System_Stack ptr
		lea	irErrorStr(pc),a0		; get SR string
		moveq	#2,d5				; y-position
		moveq	#$16,d4				; x-position
		jsr	WriteString1			; display it
		move.w	-8(a1),d3			; get instruction register num
		jsr	WriteNumberWord2		; display value

	; next replaces USP with address error was in
		lea	addrErrorStr(pc),a0		; get SR string
		moveq	#1,d5				; y-position
		moveq	#$A,d4				; x-position
		jsr	WriteString1			; display it
		move.l	-12(a1),d3			; get the address
		jsr	WriteNumberAddr2		; display value

	; write bitfield info into screen
		lea	aesErrorStr(pc),a0		; get address error special bitfield string
		moveq	#$D,d4				; x-position
		moveq	#4,d5				; y-position
		jsr	WriteString1			; display it

	; write the bitfield bits
		moveq	#$D,d4				; x-position to write to
		moveq	#5,d5				; y-position to write to
		jsr	SetupStringWrite		; set position to write to

		move.w	-14(a1),d3			; get special bitfield
		moveq	#5-1,d0				; get the amount of bits
.doccr		moveq	#$49,d1				; no selection
		btst	d0,d3				; test if condition was set
		beq.s	.not				; branch if not
		moveq	#$48,d1				; has selection
.not		move.w	d1,(a6)				; write map to VDP
		dbf	d0,.doccr			; loop until all is done
		rts
; ===========================================================================
DebugRegisters:
	dc.w $17-1		; amount of registers
	dc.w $8000		; initial register
	dc.w $100		; next register
	dc.b 4,	$74, $30, $3C	; values for VDP registers
	dc.b 7,	$6C, 0,	0
	dc.b 0,	0, $FF,	0
	dc.b 0, $37, 0, 2
	dc.b 0,	0, 0, $FF
	dc.b $FF, 0, 0,	$80
	even
; ===========================================================================

CrashNames:
	dc.w .Addr-CrashNames
	dc.w .ErrExpt-CrashNames
	dc.w .Illegal-CrashNames
	dc.w .zerodiv-CrashNames
	dc.w .Chk-CrashNames
	dc.w .Trapv-CrashNames
	dc.w .Priv-CrashNames
	dc.w .Trace-CrashNames
	dc.w .LineA-CrashNames
	dc.w .LineF-CrashNames
	if debug=1
		dc.w .lag-CrashNames

.lag		asc.w 0, '*||||||||||||LAG|||||||||||||*'; level lag
	endif

.ErrExpt	asc.w 0, '*||||||ERROR|EXECPTION|||||||*'; miscellaneous error.
.Addr		asc.w 0, '*|||||||ADDRESS|ERROR||||||||*'; address error
.illegal	asc.w 0, '*||||ILLEGAL|INSTRUCTION|||||*'; illegal instruction (code runs in data likely)
.zerodiv	asc.w 0, '*|||||||ZERO|DIVISION||||||||*'; zero divide (ex: 1/0)
.chk		asc.w 0, '*|||||||CHK|INSTRUCTION||||||*'; CHK
.trapv		asc.w 0, '*||||||TRAPV|INSTRUCTION|||||*'; TRAPV
.priv		asc.w 0, '*|||||PRIVILEGE|VIOLATION||||*'; Privilege violation (68k trying to use privileged instructions while supervisor mode)
.trace		asc.w 0, '*||||||||||||TRACE|||||||||||*'; Tracing instruction. TODO: handle properly
.lineA		asc.w 0, '*|||||||LINE|A|EMULATOR||||||*'; line A emulator (running instruction that is not implemented in 68000)
.lineF		asc.w 0, '*|||||||LINE|F|EMULATOR||||||*'; line F emulator (running instruction that is not implemented in 68000)
.trapped	asc.w 0, '*||||||||||ERRORTRAP|||||||||*'; ran into ErrorTrap.
; ===========================================================================
ConditionCodeStr:	asc2.w 0, ' BIT XNZVC  USP:$'
irErrorStr:		asc2.w 0, ' IR:$'
srErrorStr:		asc2.w 0, ' SR:$'
addrErrorStr:		asc2.w 0, 'ADDR:$'
ConditionCodeStr2:	asc2.w 0, '          CCR '
aesErrorStr:		asc2.w 0, 'RN012'	; R = Write(0)/Read(1), N = Instruction(0)/Not(1), 0-2 = Function Code(?)
pcErrorStr:		asc2.w 0, '   PC:$'
d0ErrorStr:		asc2.w 0, 'd0:$'
d1ErrorStr:		asc2.w 0, '        d1:$'
d2ErrorStr:		asc2.w 0, 'd2:$'
d3ErrorStr:		asc2.w 0, '        d3:$'
d4ErrorStr:		asc2.w 0, 'd4:$'
d5ErrorStr:		asc2.w 0, '        d5:$'
d6ErrorStr:		asc2.w 0, 'd6:$'
d7ErrorStr:		asc2.w 0, '        d7:$'
a0ErrorStr:		asc2.w 0, 'a0:$'
a1ErrorStr:		asc2.w 0, '        a1:$'
a2ErrorStr:		asc2.w 0, 'a2:$'
a3ErrorStr:		asc2.w 0, '        a3:$'
a4ErrorStr:		asc2.w 0, 'a4:$'
a5ErrorStr:		asc2.w 0, '        a5:$'
a6ErrorStr:		asc2.w 0, 'a6:$'
spErrorStr:		asc2.w 0, '        sp:$'
spWriteStr:		asc2.w 0, '-$'
; ===========================================================================
DebugAsc_SFX:	asc2.w $8000,'SFX:   $33'
DebugAsc_RAM:	asc2.w $8000,'RAM:   $0000:$0000'
DebugAsc_VRAM:	asc2.w $8000,'VRAM:  $0000:$0000'
DebugAsc_CRAM:	asc2.w $8000,'CRAM:  $00:  $0000'
DebugAsc_VSRAM:	asc2.w $8000,'VSRAM: $00:  $0000'
DebugAsc_Arrow:	asc.w  $8000,'>'
DebugAsc_NUL:	asc.w  $8000,' '
; ===========================================================================

DebugSelect:
		lea	VDP_control_port,a5		; get VDP data port for writing
	dmaFillVRAM 0, $C000, $4000
		lea	DebugAsc_SFX(pc),a0
		moveq	#6,d4
		moveq	#3,d5
		jsr	WriteString1(pc)

		lea	DebugAsc_RAM(pc),a0
		moveq	#6,d4
		moveq	#4,d5
		jsr	WriteString1(pc)

		lea	DebugAsc_VRAM(pc),a0
		moveq	#6,d4
		moveq	#5,d5
		jsr	WriteString1(pc)

		lea	DebugAsc_CRAM(pc),a0
		moveq	#6,d4
		moveq	#6,d5
		jsr	WriteString1(pc)

		lea	DebugAsc_VSRAM(pc),a0
		moveq	#6,d4
		moveq	#7,d5
		jsr	WriteString1(pc)
		moveq	#3,d1
		moveq	#0,d0
		move.l	d0,Crash_RAM
		move.l	d0,Crash_CRAM
		move.b	#$33,Crash_SFX

.loop		jsr	VSync(pc)			; wait to poll controllers and next frame
		jsr	VSync(pc)			; wait to poll controllers and next frame
		jsr	VSync(pc)			; wait to poll controllers and next frame
		jsr	VSync(pc)			; wait to poll controllers and next frame
		move.b	Ctrl_1_Press.w,d0		; get p1 held buttons
		or.b	Ctrl_2_Press.w,d0		; or p2 held buttons
		move.b	Ctrl_1_Held.w,d2		; get p1 held buttons
		or.b	Ctrl_2_Held.w,d2		; or p2 held buttons
		bpl.s	.nostart			; branch if enter isnt pressed
		btst	#6,d2				; was A pressed?
		beq.s	.nostart			; if not, branch
		jmp	EntryPoint			; reset the game

.nostart	bsr	.control
		bsr	.drawselector
		bra.s	.loop
; ===========================================================================

.drawselector	moveq	#5-1,d2
.drawselloop	move.w	d2,d5				; set y-cell position
		add.w	#3,d5
		moveq	#5,d4				; x-cell
		moveq	#0,d6				; length
		lea	DebugAsc_NUL(pc),a0		; the arrow
		jsr	WriteString2(pc)		; write the string
		dbf	d2,.drawselloop

		move.w	d1,d5				; set y-cell position
		moveq	#5,d4				; x-cell
		moveq	#0,d6				; length
		lea	DebugAsc_Arrow(pc),a0		; the arrow
		jmp	WriteString2(pc)		; write the string
; ===========================================================================

.control	btst	#1,d2				; check if up is pressed
		beq.s	.chkdown			; if not, branch
		addq.w	#1,d1				; go to next row
		cmp.w	#3+5,d1				; check if we overflowed
		bne.s	.chkdown			; if not, branch
		subq.w	#5,d1				; go back

.chkdown	btst	#0,d2				; check if down is pressed
		beq.s	.chkleft			; if not, branch
		subq.w	#1,d1				; go to last row
		cmp.w	#2,d1				; check if we overflowed
		bne.s	.chkleft			; if not, branch
		addq.w	#5,d1				; go back

.chkleft	btst	#2,d2				; check if left is pressed
		beq.w	.chkright			; if not, branch
		movem.w	d0/d2,-(sp)
		moveq	#0,d2
		moveq	#14,d4
		move.w	d1,d5
		move.w	d1,d3
		sub.w	#3,d3
		add.w	d3,d3
		move.w	.leftshit(pc,d3.w),d3
		jsr	.leftshit(pc,d3.w)		; jump to proper code
		movem.w	(sp)+,d0/d2
		rts

; ===========================================================================
.leftshit	dc.w .sfxleft-.leftshit
		dc.w .ramleft-.leftshit
		dc.w .vramleft-.leftshit
		dc.w .cramleft-.leftshit
		dc.w .vsramleft-.leftshit
; ===========================================================================
.sfxleft	subq.b	#2,Crash_SFX
		bra.w	.sfxright

.ramleft	subq.w	#2,Crash_RAM
		bra.w	.ramcommon

.vramleft	subq.w	#2,Crash_VRAM
		bra.w	.vramcommon

.cramleft	subq.b	#2,Crash_CRAM
		bra.w	.cramcommon

.vsramleft	subq.b	#2,Crash_VSRAM
		bra.w	.vsramcommon
; ===========================================================================
.chkright	btst	#3,d2				; check if left is pressed
		beq.w	.chkABC				; if not, branch
		movem.w	d0/d2,-(sp)
		moveq	#0,d2
		moveq	#14,d4
		move.w	d1,d5
		move.w	d1,d3
		sub.w	#3,d3
		add.w	d3,d3
		move.w	.rightshit(pc,d3.w),d3
		jsr	.rightshit(pc,d3.w)		; jump to proper code
		movem.w	(sp)+,d0/d2
		rts

; ===========================================================================
.rightshit	dc.w .sfxright-.rightshit
		dc.w .ramright-.rightshit
		dc.w .vramright-.rightshit
		dc.w .cramright-.rightshit
		dc.w .vsramright-.rightshit
; ===========================================================================
.cramright	addq.b	#2,Crash_CRAM
.cramcommon	lea	Crash_CRAM,a0
	vdpComm	move.l,$0000,CRAM,READ,-(sp)
		bra.s	.xramcommon

.vsramright	addq.b	#2,Crash_VSRAM
.vsramcommon	lea	Crash_VSRAM,a0
	vdpComm	move.l,$0000,VSRAM,READ,-(sp)

.xramcommon	moveq	#0,d3
		move.b	(a0),d3
		jsr	WriteNumberByte1(pc)

		move.b	(a0),d2
		move.l	(sp)+,d3
		bra.s	.xramcom2

.sfxright	addq.b	#1,Crash_SFX
		move.b	Crash_SFX,d3
		jmp	WriteNumberByte1(pc)		; write SFX number

.ramright	addq.w	#2,Crash_RAM

.ramcommon	move.w	Crash_RAM,d3
		jsr	WriteNumberWord1(pc)

		; all this shit is just to get the value in RAM. its fucking shit
		moveq	#-1,d0
		move.w	Crash_RAM,d0
		move.w	d0,a0
		move.w	(a0),d3

		moveq	#0,d2
		moveq	#20,d4
		move.w	d1,d5
		jmp	WriteNumberWord1(pc)

.vramright	addq.w	#2,Crash_VRAM
.vramcommon	move.w	Crash_VRAM,d3
		jsr	WriteNumberWord1(pc)
		move.w	Crash_VRAM,d2
	vdpComm	move.l,$0000,VRAM,READ,d3
.xramcom2	jsr	DebugReadVDP(pc)

		moveq	#0,d2
		moveq	#20,d4
		move.w	d1,d5
		jmp	WriteNumberWord1(pc)
; ===========================================================================

.chkABC		and.b	#$70,d2
		beq.s	.non
		cmp.b	#3,d1
		bne.s	.non
		move.b	Crash_SFX,d0
		jsr	PlaySFX.w
		sf	d0

.non		rts
; ===========================================================================

DebugReadVDP:
		andi.l	#$FFFF,d2
		lsl.l	#2,d2
		lsr.w	#2,d2
		swap	d2
		or.l	d3,d2
		move.l	d2,4(a6)
		move.w	(a6),d3		; read word
		rts
