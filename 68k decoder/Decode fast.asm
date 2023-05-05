; ===========================================================================
; ---------------------------------------------------------------------------
; 68k decoder program
;
; input:
;   a0 = source instruction address
;   a1 = destination buffer address
;
; output:
;   a0 = next instruction address
;   a1 = next buffer address
;   buffer = text generated with color highlight, and end token
; ---------------------------------------------------------------------------

dcwhite =	$0000
dcblue =	$2000
dcred =		$4000
dcgreen =	$6000
; ---------------------------------------------------------------------------

; attach the colour values to each letter
d68k_str	macro color, str
lc =	0
	rept strlen(\str)						; repeat for each character of supplied string
cc		substr lc+1,lc+1,\str					; get the next letter
cw =		'\cc'							; get its hexadecimal value (derp herp derp)
		dc.w cw|\color						; include it in the ROM
lc =		lc+1							; go to next character
	endr
    endm
; ---------------------------------------------------------------------------

d68k_StoreSrc =	$FFFFFFF0						; stored source address
d68k_StoreDst =	$FFFFFFF4						; stored destination address
d68k_ShowAddr = 1							; set to 1 to enable printing address to output buffer
; ---------------------------------------------------------------------------

Decode68k:
	if d68k_ShowAddr
		move.l	a0,d1						; copy ROM address to d1
		jsr	d68k_PrintAddr(pc)				; print it
		move.w	#dcred|' ',(a1)+				; write a space
	endif

		move.l	a1,d68k_StoreDst.w				; copy destination address to RAM
		move.l	a0,d68k_StoreSrc.w				; copy source address to RAM

		move.w	(a0)+,d0					; load the next byte from source
		move.w	d0,d1						; copy to d1
		and.w	#$F000,d1					; get the highest nibble
		rol.w	#6,d1						; rotate 6 bits, so each nibble gets a long word
		move.l	d68k_HighNibble(pc,d1.w),a2			; load the correct address to a2
		jmp	(a2)						; jump to execute the correct routine
; ===========================================================================
; ---------------------------------------------------------------------------
; jumptable for instruction high nibble
; ---------------------------------------------------------------------------

d68k_HighNibble:
		dc.l d68k_i0xxx, d68k_iMove, d68k_iMove, d68k_iMove
		dc.l d68k_i4xxx, d68k_i5xxx, d68k_iBCC,  d68k_iMoveq
		dc.l d68k_i8xxx, d68k_iSub,  d68k_Data,  d68k_iBxxx
		dc.l d68k_iCxxx, d68k_iAdd,  d68k_iExxx, d68k_Data
; ===========================================================================
; ---------------------------------------------------------------------------
; output an error
;
; input:
;   d0 = instruction word
; ---------------------------------------------------------------------------

d68k_ErrorStr:	d68k_str dcred, 'error '
		dc.w 0

d68k_Error:
		lea	d68k_ErrorStr(pc),a2				; load error initialization string into a2
		bsr.s	d68k_CopyStr					; copy the string over
		subq.w	#2,a1						; we need to insert things before the end here

		bsr.s	d68k_PrintWord					; print d1
		clr.w	(a1)+						; set end token
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; copy string from input to output
; ---------------------------------------------------------------------------

d68k_CopyStr:
		move.w	(a2)+,(a1)+					; copy the next word into buffer
		bne.s	d68k_CopyStr					; loop until we reach the end
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; output a dc.w statement for invalid data
;
; input:
;   d0 = instruction word
; ---------------------------------------------------------------------------

d68k_DCW:	d68k_str dcblue, 'dc.w '
		dc.w 0

d68k_Data:
		move.l	d68k_StoreDst.w,a1				; restore original destination address
		move.l	d68k_StoreSrc.w,a0				; restore original source address

		lea	d68k_DCW(pc),a2					; load dc.w initialization string into a2
		bsr.s	d68k_CopyStr					; copy the string over
		subq.w	#2,a1						; we need to insert things before the end here

		move.w	(a0)+,d1					; copy instruction to d1
		bsr.s	d68k_PrintWord					; print d1
		clr.w	(a1)+						; set end token
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; print a word as characters
;
; input:
;   d1 = data to write
; ---------------------------------------------------------------------------

d68k_PrintWord:
		move.w	#dcred|'$',(a1)+				; write hex symbol
		moveq	#4-1,d3						; prepare loop count to d3

.char
		rol.w	#4,d1						; get first 4 bits into view
		move.w	d1,d2						; copy to d1
		and.w	#$F,d2						; get only a single digit
		add.w	d2,d2						; double offset
		move.w	d68k_DigitTbl(pc,d2.w),(a1)+			; copy into buffer

		dbf	d3,.char					; loop for every character
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; print an address as characters
;
; input:
;   d1 = data to write
; ---------------------------------------------------------------------------

d68k_PrintAddr:
		moveq	#6-1,d3						; prepare loop count to d3
		rol.l	#8,d1						; skip highest 8 bits
		bra.s	d68k_PrintComL
; ===========================================================================
; ---------------------------------------------------------------------------
; print a longword as characters
;
; input:
;   d1 = data to write
; ---------------------------------------------------------------------------

d68k_PrintLong:
		moveq	#8-1,d3						; prepare loop count to d3

d68k_PrintComL:
		move.w	#dcred|'$',(a1)+				; write hex symbol

.char
		rol.l	#4,d1						; get first 4 bits into view
		move.w	d1,d2						; copy to d1
		and.w	#$F,d2						; get only a single digit
		add.w	d2,d2						; double offset
		move.w	d68k_DigitTbl(pc,d2.w),(a1)+			; copy into buffer

		dbf	d3,.char					; loop for every character
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; print a byte as characters
;
; input:
;   d1 = data to write
; ---------------------------------------------------------------------------

d68k_PrintByte:
		move.w	#dcred|'$',(a1)+				; write hex symbol

	rept 2
		rol.b	#4,d1						; get first 4 bits into view
		move.b	d1,d2						; copy to d1
		and.w	#$F,d2						; get only a single digit
		add.w	d2,d2						; double offset
		move.w	d68k_DigitTbl(pc,d2.w),(a1)+			; copy into buffer
	endr
		rts

d68k_DigitTbl:	d68k_str dcred, '0123456789ABCDEF'
; ===========================================================================
; ---------------------------------------------------------------------------
; MOVEQ instruction handler
;
; input:
;   d0 = instruction
; ---------------------------------------------------------------------------

d68k_iMoveq:
		btst	#8,d0						; check if bit8 is set
		bne.w	d68k_Data					; if yes, this is an invalid instruction
		lea	d68k_sMoveq(pc),a2				; load moveq initialization string into a2
		jsr	d68k_CopyStr(pc)				; copy the string over
		subq.w	#2,a1						; we need to insert things before the end here

		move.b	d0,d1						; copy lower byte to d1
		bsr.s	d68k_PrintByte					; print the moveq value
		move.w	#dcwhite|',',(a1)+				; print , into buffer

		move.w	d0,d1						; copy instruction to d1
		rol.w	#16-9,d1					; get as the lowest bits
		bsr.s	d68k_PrintDataReg				; print data register
		clr.w	(a1)+						; set end token
		rts

d68k_sMoveq:	d68k_str dcblue, 'moveq'
		d68k_str dcwhite, ' #'
		dc.w 0
; ===========================================================================
; ---------------------------------------------------------------------------
; print an address register
;
; input:
;   d1 = register number
; ---------------------------------------------------------------------------

d68k_PrintAddrReg:
		move.w	#dcgreen|'a',(a1)+				; write d into buffer
		and.w	#7,d1						; keep in range
		add.w	d1,d1						; double offset
		move.w	d68k_RegTbl(pc,d1.w),(a1)+			; copy number into
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; print a register. If bit4 is set, its a address register. If clear, data
;
; input:
;   d1 = register number
; ---------------------------------------------------------------------------

d68k_PrintRegister:
		bclr	#3,d1						; check if address or data
		bne.s	d68k_PrintAddrReg				; branch if address
; ===========================================================================
; ---------------------------------------------------------------------------
; print a data register
;
; input:
;   d1 = register number
; ---------------------------------------------------------------------------

d68k_PrintDataReg:
		move.w	#dcgreen|'d',(a1)+				; write d into buffer
		and.w	#7,d1						; keep in range
		add.w	d1,d1						; double offset
		move.w	d68k_RegTbl(pc,d1.w),(a1)+			; copy number into
		rts

d68k_RegTbl:	d68k_str dcgreen, '0123456789ABCDEF'
; ===========================================================================
; ---------------------------------------------------------------------------
; MOVE instruction handler
;
; input:
;   d0 = instruction
; ---------------------------------------------------------------------------

d68k_iMove:
		jsr	d68k_PrintMove(pc)				; print MOVE into buffer
		subq.w	#2,a1						; undo space

	; check for movea
		move.w	d0,d7						; copy instruction to d7
		and.w	#$1C0,d7					; get destination mode
		lsr.w	#4,d7						; shift down so its ready to use
		cmp.w	#4,d7						; check if mode 1
		bne.s	.not1						; branch if not
		move.w	#dcblue|'a',(a1)+				; it is movea
; ---------------------------------------------------------------------------

	; handle the instruction size
.not1
		move.w	d0,d1						; copy instruction to d1
		rol.w	#5,d1						; get as the lowest bits (x2)
		and.w	#6,d1						; keep in range
		beq.w	d68k_Data					; if it was 0, then its invalid

		move.w	#dcblue|'.',(a1)+				; print . into buffer
		move.w	d68k_MoveSize-2(pc,d1.w),d6			; load instruction size to d6
		move.w	d6,(a1)+					; copy number into buffer
		move.w	#dcwhite|' ',(a1)+				; write a space

	; deal with the source register
		move.w	d0,d2						; get source register to d2
		move.w	d0,d3						; copy instruction to d3
		lsr.w	#1,d3						; shift down so its ready to use

		move.w	#$FFF,d1					; get valid modes to d3
		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data
		move.w	d6,d1						; load the size into d1
		jsr	d68k_PrintMode(pc)				; print address mode
		move.w	#dcwhite|',',(a1)+				; write a ,
; ---------------------------------------------------------------------------

	; deal with the destination register
		move.w	d0,d2						; get instruction to d2
		rol.w	#16-9,d2					; rotate up so its ready to use
		move.w	d7,d3						; copy mode to d3

		move.w	#$1FF,d1					; get valid modes to d3
		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data
		move.w	d6,d1						; load the size into d1
		jsr	d68k_PrintMode(pc)				; print address mode

		clr.w	(a1)+						; set end token
		rts

d68k_MoveSize:	d68k_str dcblue, 'blw'
; ===========================================================================
; ---------------------------------------------------------------------------
; check if this is a valid mode for this instruction
;
; input:
;   d1 = mask to check
;   d2 = register
;   d3 = mode * 4
; ---------------------------------------------------------------------------

d68k_CheckModes:
		and.w	#7,d2						; keep register in range
		and.w	#7*4,d3						; keep mode in range

		move.w	d3,d4						; copy mode to d4
		lsr.w	#2,d4						; shift down so we get the right bit
		cmp.w	#7,d4						; check if mode 7
		bne.s	.not7						; if not, skip
		add.w	d2,d4						; add register to mode check

.not7
		btst	d4,d1						; check if the mode is actually valid
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; print address mode string
;
; input:
;   d1 = instruction size in ascii
;   d2 = register
;   d3 = mode * 4
; ---------------------------------------------------------------------------

d68k_PrintMode:
		move.l	.table(pc,d3.w),a2				; load the correct address to a2
		jmp	(a2)						; jump to execute the correct routine

.table
		dc.l d68k_ModeDreg,  d68k_ModeAreg,  d68k_ModeAind,  d68k_ModeApind
		dc.l d68k_ModeAmind, d68k_ModeAoind, d68k_ModeANXN,  .reg
; ---------------------------------------------------------------------------

.reg
		add.w	d2,d2						; quadruple register
		add.w	d2,d2						;
		move.l	.table2(pc,d2.w),a2				; load the correct address to a2
		jmp	(a2)						; jump to execute the correct routine

.table2
		dc.l d68k_ModeAddrW, d68k_ModeAddrL, d68k_ModePind, d68k_ModePCXN
		dc.l d68k_ModeImm,  d68k_ModeData,  d68k_ModeData, d68k_ModeData
; ===========================================================================
; ---------------------------------------------------------------------------
; print data register string
; ---------------------------------------------------------------------------

d68k_ModeDreg:
		move.w	d2,d1						; copy data register to d1
		jmp	d68k_PrintDataReg				; print it!
; ===========================================================================
; ---------------------------------------------------------------------------
; print address register string
; ---------------------------------------------------------------------------

d68k_ModeAreg:
		cmp.b	#'b',d1						; check if instruction is a byte instruction
		bne.s	d68k_ModeAregWrite				; if not, branch

d68k_ModeData:
		addq.l	#4,sp						; do not return
		jmp	d68k_Data(pc)					; invalid instruction
; ---------------------------------------------------------------------------

d68k_ModeAregWrite:
		move.w	d2,d1						; copy data register to d1
		jmp	d68k_PrintAddrReg				; print it!
; ===========================================================================
; ---------------------------------------------------------------------------
; print address register and pc-relative indirect string
; ---------------------------------------------------------------------------

d68k_ModeAmind:
		move.w	#dcwhite|'-',(a1)+				; write - into buffer
		bra.s	d68k_ModeAind
; ---------------------------------------------------------------------------

d68k_ModeAoind:
		move.w	d2,a3						; copy register temporarily
		move.w	(a0)+,d1					; read word from source
		jsr	d68k_PrintWord(pc)				; print it
		move.w	a3,d2						; get it back
; ---------------------------------------------------------------------------

d68k_ModeAind:
		move.w	#dcwhite|'(',(a1)+				; write ( into buffer
		bsr.s	d68k_ModeAregWrite				; write the address register into buffer
		move.w	#dcwhite|')',(a1)+				; write ) into buffer
		rts
; ---------------------------------------------------------------------------

d68k_ModeApind:
		bsr.s	d68k_ModeAind					; write indirect data into buffer
		move.w	#dcwhite|'+',(a1)+				; write + into buffer
		rts
; ---------------------------------------------------------------------------

d68k_ModePind:
		move.l	a0,a3						; copy current address to a3
		add.w	(a0)+,a3					; offset with the word
		move.l	a3,d1						; copy result to d1
		jsr	d68k_ResolveAddr(pc)				; print address onto the screen

		move.l	#((dcwhite|'(')<<16)|dcgreen|'p',(a1)+		; write (p into buffer
		move.l	#((dcgreen|'c')<<16)|dcwhite|')',(a1)+		; write pc into buffer
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; print address register indirect and pc-relative with register displacement
; ---------------------------------------------------------------------------

d68k_ModeANXN:
		move.w	d2,a3						; copy register temporarily
		move.w	(a0)+,d1					; read extension word from source
		jsr	d68k_PrintByte(pc)				; print byte displacement
		move.w	a3,d2						; get it back

		move.w	#dcwhite|'(',(a1)+				; write ( into buffer
		move.w	d1,d4						; copy extension to d4
		exg	d2,d1						; swap register with extension word
		jsr	d68k_PrintAddrReg(pc)				; print address register
; ---------------------------------------------------------------------------

d68k_ModeCommXN:
		move.w	d4,d1						; copy extension to d1
		and.w	#$700,d1					; check if any unused bits are set
		bne.s	d68k_ModeData					; if yes, its data nao

		move.w	#dcwhite|',',(a1)+				; write , into buffer
		move.w	d4,d1						; copy extension to d1
		rol.w	#4,d1						; get the register bits to low bits
		jsr	d68k_PrintRegister(pc)				; print the register

		btst	#11,d4						; check if this is a longword
		sne	d1						; if yes, results in 4
		and.w	#4,d1						; if not, results in 0
		move.l	d68k_SizeXN(pc,d1.w),(a1)+			; read size into buffer

		move.w	#dcwhite|')',(a1)+				; write ) into buffer
		rts
; ---------------------------------------------------------------------------

d68k_ModePCXN:
		move.w	(a0)+,d1					; read extension word from source
		move.w	d1,d4						; copy extension to d4
		ext.w	d1						; extend byte offset to word
		subq.w	#2,d1						; account for the word read

		ext.l	d1						; extend it to longword
		add.l	a0,d1						; add current address to d1
		jsr	d68k_ResolveAddr(pc)				; print address onto the screen

		move.w	#dcwhite|'(',(a1)+				; write ( into buffer
		move.l	#((dcgreen|'p')<<16)|dcgreen|'c',(a1)+		; write pc into buffer
		bra.s	d68k_ModeCommXN					; run the rest of the code the same

d68k_SizeXN:	d68k_str dcblue, '.w.l'
; ===========================================================================
; ---------------------------------------------------------------------------
; print direct address word and long
; ---------------------------------------------------------------------------

d68k_PrintSmallSize:
		sne	d6						; if yes, results in 4
		and.w	#4,d6						; if not, results in 0
		move.l	d68k_SizeXN(pc,d6.w),d6				; read size into d6
		move.l	d6,(a1)+					; copy into buffer
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; print direct address word and long
; ---------------------------------------------------------------------------

d68k_ModeAddrW:
		move.w	(a0)+,d1					; load address into d1
		ext.l	d1						; extend to longword
		jsr	d68k_PrintLong(pc)				; print it
		move.l	#((dcblue|'.')<<16)|dcblue|'w',(a1)+		; write .w into buffer
		rts
; ---------------------------------------------------------------------------

d68k_ModeAddrL:
		move.l	(a0)+,d1					; load address into d1
		jsr	d68k_PrintLong(pc)				; print it
		move.l	#((dcblue|'.')<<16)|dcblue|'l',(a1)+		; write .l into buffer
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; print direct address word and long
; ---------------------------------------------------------------------------

d68k_ModeImm:
		move.w	#dcwhite|'#',(a1)+				; write # into buffer
		cmp.b	#'b',d1						; check if this is a byte instruction
		bne.s	.ckword						; if not, check for word
		move.w	(a0)+,d1					; load the value from source
		jmp	d68k_PrintByte(pc)				; print it
; ---------------------------------------------------------------------------

.ckword
		cmp.b	#'w',d1						; check if this is a word instruction
		bne.s	.cklong						; if not, check for long
		move.w	(a0)+,d1					; load the value from source
		jmp	d68k_PrintWord(pc)				; print it
; ---------------------------------------------------------------------------

.cklong
		cmp.b	#'l',d1						; check if this is a long instruction
		bne.s	.uhoh						; if not, we have an oopsidaisy
		move.l	(a0)+,d1					; load the value from source
		jmp	d68k_PrintLong(pc)				; print it
; ---------------------------------------------------------------------------

.uhoh
		addq.l	#4,sp						; do not return
		moveq	#1,d1						; error #1
		jmp	d68k_Error(pc)					; there is an error
; ===========================================================================
; ---------------------------------------------------------------------------
; ADD and SUB instruction handlers
; ---------------------------------------------------------------------------

d68k_iAdd:
		move.l	#((dcblue|'a')<<16)|dcblue|'d',(a1)+		; write ad into buffer
		move.w	#dcblue|'d',(a1)+				; write d into buffer
		bra.s	d68k_AddSub

d68k_iSub:
		move.l	#((dcblue|'s')<<16)|dcblue|'u',(a1)+		; write su into buffer
		move.w	#dcblue|'b',(a1)+				; write b into buffer
; ---------------------------------------------------------------------------

d68k_AddSub:
		move.w	d0,d1						; copy instruction to d1
		and.w	#$C0,d1						; check for these specific bits
		cmp.w	#$C0,d1						; check if it is this value
		beq.s	.adda						; in that case, its an adda

		move.w	d0,d1						; copy instruction to d1
		and.w	#$130,d1					; check for these specific bits
		cmp.w	#$100,d1					; check if it is this value
		bne.w	.add						; branch if not
; ---------------------------------------------------------------------------

	; ADDX/SUBX
		move.w	#dcblue|'x',(a1)+				; print x

	; print instruction size
		move.w	d0,d1						; copy instruction to d1
		lsr.w	#5,d1						; get as the lowest bits (x2)
		jsr	d68k_PrintInsSize(pc)				; print the instruction size string
		beq.w	d68k_Data					; if it was invalid, present it as data
		jmp	d68k_SpecialReg1(pc)				; write register info
; ---------------------------------------------------------------------------

.adda
	; ADDA/SUBA
		move.w	#dcblue|'a',(a1)+				; print a

	; check instruction mode
		move.w	d0,d2						; get source register to d2
		move.w	d0,d3						; copy instruction to d3
		lsr.w	#1,d3						; shift down so its ready to use

		move.w	#$FFF,d1					; prepare mode check for instruction
		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data

	; print instruction size
		btst	#8,d0						; check if this is a longword
		jsr	d68k_PrintSmallSize(pc)				; print the size according to check
		move.w	#dcwhite|' ',(a1)+				; write a space

	; print the addressing mode
		move.w	d6,d1						; copy instruction size to d1
		jsr	d68k_PrintMode(pc)				; print address mode
		move.w	#dcwhite|',',(a1)+				; write a ,

	; print the register
		move.w	d0,d1						; copy instruction to d1
		rol.w	#16-9,d1					; rotate register into place
		jsr	d68k_PrintAddrReg(pc)				; print it!

		clr.w	(a1)+						; set end token
		rts
; ---------------------------------------------------------------------------

.add
	; ADD/SUB
		move.l	#$0FFF01FD,d1					; prepare mode check for instruction
; ===========================================================================
; ---------------------------------------------------------------------------
; common type 1 instruction handler
;
; input:
;   d1 = mask to check, low word for DN -> EA, high word for EA -> DN
; ---------------------------------------------------------------------------

d68k_CommonIns1:
		btst	#8,d0						; check which direction the instruction goes
		seq	d7						; if EA -> DN, set d7
		bne.s	.ckmode						; branch if EA -> DN
		swap	d1						; use alternate set to check mode

.ckmode
	; check instruction mode
		move.w	d0,d2						; get source register to d2
		move.w	d0,d3						; copy instruction to d3
		lsr.w	#1,d3						; shift down so its ready to use
		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data

	; print instruction size
		move.w	d0,d1						; copy instruction to d1
		lsr.w	#5,d1						; get as the lowest bits (x2)
		bsr.s	d68k_PrintInsSize				; print the instruction size string
		beq.w	d68k_Data					; if it was invalid, then its data

	; check if DN is the source register
		move.w	#dcwhite|' ',(a1)+				; write a space
		tst.b	d7						; check if DN comes first
		bne.s	.nodn1						; branch if not
		bsr.s	.writereg					; write the register
		move.w	#dcwhite|',',(a1)+				; write a ,

.nodn1
	; print the addressing mode
		move.w	d6,d1						; load the size into d1
		jsr	d68k_PrintMode(pc)				; print address mode

	; check if DN is the destination register
		tst.b	d7						; check if DN comes last
		beq.s	.nodn2						; branch if not
		move.w	#dcwhite|',',(a1)+				; write a ,
		bsr.s	.writereg					; write the register

.nodn2
		clr.w	(a1)+						; set end token
		rts

	; print the register
.writereg
		move.w	d0,d1						; copy instruction to d1
		rol.w	#16-9,d1					; rotate register into place
		jmp	d68k_PrintDataReg(pc)				; print it!
; ===========================================================================
; ---------------------------------------------------------------------------
; print instruction size
;
; input:
;   d1 = size parameter * 2
; ---------------------------------------------------------------------------

d68k_PrintInsSize:
		move.w	#dcblue|'.',(a1)+				; print . into buffer

		and.w	#6,d1						; keep in range
		move.w	d68k_InsSize(pc,d1.w),d6			; load instruction size to d6
		move.w	d6,(a1)+					; copy it to buffer
		rts

d68k_InsSize:	d68k_str dcblue, 'bwl'
		dc.w 0
; ===========================================================================
; ---------------------------------------------------------------------------
; BXXX instruction handler
; ---------------------------------------------------------------------------

d68k_sCmp:	d68k_str dcblue, 'cmp'
		dc.w 0

d68k_iBxxx:
		move.w	d0,d5						; copy instruction to d5
		rol.w	#16-9,d5					; rotate register into place
		move.w	d0,d2						; copy register to d2
		move.w	d0,d3						; copy instruction to d3
		lsr.w	#1,d3						; shift down so its ready to use

		move.w	d0,d1						; copy instruction to d1
		lsr.w	#5,d1						; get as the lowest bits (x2)
		and.w	#6,d1						; get size parameter only
		cmp.w	#6,d1						; check if its this value
		bne.s	.notcmpa					; if not, this isn't CMPA

	; CMPA
		lea	d68k_sCmp(pc),a2				; load cmp initialization string into a2
		jsr	d68k_CopyStr(pc)				; copy the string over
		move.w	#dcblue|'a',-2(a1)				; print a into the last buffer position

	; print instruction size
		btst	#8,d0						; check if this is a longword
		jsr	d68k_PrintSmallSize(pc)				; print the size according to check
		bset	#3,d5						; set the target register as address register
		bra.s	.cmpcom
; ---------------------------------------------------------------------------

.notcmpa
		btst	#8,d0						; check if this is a special instruction mode
		bne.s	.notcmp						; if yes, run different code

	; CMP
		lea	d68k_sCmp(pc),a2				; load cmp initialization string into a2
		jsr	d68k_CopyStr(pc)				; copy the string over
		subq.w	#2,a1						; we need to insert things before the end here

	; print instruction size
		bclr	#3,d5						; set the target register as data register
		bsr.s	d68k_PrintInsSize				; print the instruction size string
		beq.w	d68k_Data					; if it was invalid, then its data
; ---------------------------------------------------------------------------

.cmpcom
		move.w	#dcwhite|' ',(a1)+				; write a space

	; check instruction mode
		move.w	#$FFF,d1					; get valid modes to d1
		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data

	; print the addressing mode
		move.w	d6,d1						; load the size into d1
		jsr	d68k_PrintMode(pc)				; print address mode
		move.w	#dcwhite|',',(a1)+				; write a ,

	; print the target register
		move.w	d5,d1						; get target register to d1
		jsr	d68k_PrintRegister(pc)				; print the register
		clr.w	(a1)+						; set end token
		rts
; ---------------------------------------------------------------------------

.notcmp
		and.w	#7*4,d3						; keep mode in range
		cmp.w	#4,d3						; check for instruction mode 1
		bne.s	.eor						; branch if not

	; CMPM
		lea	d68k_sCmp(pc),a2				; load cmp initialization string into a2
		jsr	d68k_CopyStr(pc)				; copy the string over
		move.w	#dcblue|'m',-2(a1)				; print m into the last buffer position

	; print instruction size
		jsr	d68k_PrintInsSize(pc)				; print the instruction size string
		beq.w	d68k_Data					; if it was invalid, then its data
		move.w	#dcwhite|' ',(a1)+				; write a space

	; print registers
		move.w	d2,d1						; copy source register to d1
		bsr.s	.writereg					; write it down
		move.w	#dcwhite|',',(a1)+				; write a ,

		move.w	d5,d1						; copy destination register to d1
		bsr.s	.writereg					; write it down
		clr.w	(a1)+						; set end token
		rts
; ---------------------------------------------------------------------------

.writereg
		move.w	#dcwhite|'(',(a1)+				; write ( into buffer
		jsr	d68k_PrintAddrReg(pc)				; print address register
		move.l	#((dcwhite|')')<<16)|dcwhite|'+',(a1)+		; write )+ into buffer
		rts
; ---------------------------------------------------------------------------

.eor
	; EOR
		move.l	#((dcblue|'e')<<16)|dcblue|'o',(a1)+		; write eo into buffer
		move.w	#dcblue|'r',(a1)+				; write r into buffer

	; print instruction size
		jsr	d68k_PrintInsSize(pc)				; print the instruction size string
		beq.w	d68k_Data					; if it was invalid, then its data

	; check instruction mode
		move.w	#$1FD,d1					; get valid modes to d1
		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data

	; print source register
		move.w	#dcwhite|' ',(a1)+				; write a space
		move.w	d5,d1						; copy destination register to d1
		jsr	d68k_PrintDataReg(pc)				; print data register

	; print the addressing mode
		move.w	#dcwhite|',',(a1)+				; write a ,
		move.w	d6,d1						; load the size into d1
		jsr	d68k_PrintMode(pc)				; print address mode
		clr.w	(a1)+						; set end token
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; EXXX instruction handler
; ---------------------------------------------------------------------------

d68k_iExxx:
		move.w	d0,d1						; copy instruction to d1
		lsr.w	#5,d1						; get as the lowest bits (x2)
		and.w	#6,d1						; get size parameter only
		cmp.w	#6,d1						; check if its this value
		bne.s	.notea						; if not, this isn't shift EA

	; shift EA
		move.w	d0,d2						; copy instruction to d2
		lsr.w	#8,d2						; rotate into place
		bsr.s	.printins					; print the instruction

		move.w	d0,d2						; copy register to d2
		move.w	d0,d3						; copy instruction to d3
		lsr.w	#1,d3						; shift down so its ready to use

	; check instruction mode
		move.w	#$1FC,d1					; get valid modes to d1
		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data

	; print the instruction mode
		move.w	#dcwhite|' ',(a1)+				; write a space
		moveq	#'w',d1						; load the size into d1
		jsr	d68k_PrintMode(pc)				; print address mode

		clr.w	(a1)+						; set end token
		rts
; ---------------------------------------------------------------------------

.insoffs	dc.b 0, 2-1, 4, 2-1, 12, 3-1, 8, 2-1
.insdata	d68k_str dcblue, 'aslsrorox'
.direction	d68k_str dcblue, 'rl'
; ---------------------------------------------------------------------------

.printins
		moveq	#0,d3
		and.w	#6,d2						; keep in range
		move.b	.insoffs+1(pc,d2.w),d3				; load the correct size
		move.b	.insoffs(pc,d2.w),d2				; load the correct offset
		lea	.insdata(pc,d2.w),a2				; load the array to a2

.copyloop
		move.w	(a2)+,(a1)+					; copy a letter over
		dbf	d3,.copyloop					; loop for all entries

		btst	#8,d0						; check which direction to use
		sne	d3						; if yes, results in 2
		and.w	#2,d3						; if not, results in 0
		move.w	.direction(pc,d3.w),(a1)+			; print direction into buffer
		rts
; ---------------------------------------------------------------------------

.notea
	; shift # or DN
		move.w	d0,d2						; copy instruction to d2
		lsr.w	#2,d2						; rotate into place
		bsr.s	.printins					; print the instruction

	; print instruction size
		jsr	d68k_PrintInsSize(pc)				; print the instruction size string
		beq.w	d68k_Data					; if it was invalid, then its data
		move.w	#dcwhite|' ',(a1)+				; write a space

		move.w	d0,d1						; copy instruction to d1
		rol.w	#16-9,d1					; rotate register into place
		and.w	#7,d1						; keep in range
		move.w	d0,d2						; copy register to d2
; ---------------------------------------------------------------------------

		btst	#5,d0						; check if source is register
		bne.s	.isreg						; branch if yes
		move.w	#dcwhite|'#',(a1)+				; write a #

		tst.w	d1						; special case: check for 0
		bne.s	.not0						; branch if not
		moveq	#8,d1						; set to 8 instead

.not0
		add.w	#dcred|'0',d1					; turn into digit
		move.w	d1,(a1)+					; print it!
		bra.s	.cont
; ---------------------------------------------------------------------------

.isreg
		jsr	d68k_PrintDataReg(pc)				; print data register
; ---------------------------------------------------------------------------

.cont
		move.w	#dcwhite|',',(a1)+				; write a ,
		move.w	d2,d1						; copy destination register to d1
		jsr	d68k_PrintDataReg(pc)				; print data register

		clr.w	(a1)+						; set end token
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; BCC instruction handler
; ---------------------------------------------------------------------------

d68k_iBCC:
		move.w	#dcblue|'b',(a1)+				; write a b
		lea	.bcctbl(pc),a2					; load bcc table to a2
		bsr.s	d68k_PrintCC					; print condition code

		tst.b	d0						; check if this is bcc.w
		beq.s	.word						; branch if so
		move.l	#((dcblue|'.')<<16)|dcblue|'s',(a1)+		; write .s

		move.b	d0,d1						; copy displacement to d1
		ext.w	d1						; extend to word
		bra.s	.common
; ---------------------------------------------------------------------------

.word
		move.l	#((dcblue|'.')<<16)|dcblue|'w',(a1)+		; write .w
		move.w	(a0)+,d1					; load word displacement
		subq.w	#2,d1						; account for the word read
; ---------------------------------------------------------------------------

.common
		move.w	#dcwhite|' ',(a1)+				; write a space
		ext.l	d1						; extend to longword
		add.l	a0,d1						; add ROM address to d1
		jsr	d68k_ResolveAddr(pc)				; print address onto the screen

		clr.w	(a1)+						; set end token
		rts

.bcctbl		d68k_str dcblue, 'rasr'
; ---------------------------------------------------------------------------

d68k_PrintCC:	; warning: stupid code ahead
		move.w	d0,d1						; copy instruction to d1
		and.w	#$0F00,d1					; keep in range
		lsr.w	#6,d1						; shift down

		cmp.w	#8,d1						; check if this is the two first entries
		blt.s	.a2						; read from a2
		move.l	.cctbl-8(pc,d1.w),(a1)+				; print condition code from normal table
		rts

.a2
		move.l	(a2,d1.w),(a1)+					; print condition code from alternate table
		rts

.cctbl		d68k_str dcblue, 'hilscccsneeqvcvsplmigeltgtle'

d68k_PrintCC2:
		bsr.s	d68k_PrintCC					; print the CC
		tst.w	-2(a1)						; check if last was blank
		sne	d1						; set d1 if not

		and.w	#2,d1						; keep in range
		move.w	#dcwhite|' ',-2(a1,d1.w)			; write a space
		add.w	d1,a1						; also advance the pointer
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; 5XXX instruction handler
; ---------------------------------------------------------------------------

d68k_SDBtbl:	dc.w dcblue|'t', 0, dcblue|'f', 0

d68k_i5xxx:
		move.w	d0,d2						; copy register to d2
		move.w	d0,d3						; copy instruction to d3
		lsr.w	#1,d3						; shift down so its ready to use

		move.w	d0,d1						; copy instruction to d1
		lsr.w	#5,d1						; get as the lowest bits (x2)
		and.w	#6,d1						; get size parameter only
		cmp.w	#6,d1						; check if its this value
		bne.s	.addsubq					; if not, this is ADDQ or SUBQ
; ---------------------------------------------------------------------------

		move.w	d0,d1						; copy instruction to d1
		and.w	#$0F00,d1					; keep in range
		lsr.w	#6,d1						; shift down

		and.w	#7*4,d3						; keep mode in range
		cmp.w	#4,d3						; check for instruction mode 1
		bne.s	.scc						; branch if not

	; DBcc
		move.l	#((dcblue|'d')<<16)|dcblue|'b',(a1)+		; write db
		lea	d68k_SDBtbl(pc),a2				; load dbcc table to a2
		bsr.s	d68k_PrintCC2					; print condition code

	; print count register
		move.w	d2,d1						; copy count register to d1
		jsr	d68k_PrintDataReg(pc)				; print data register
		move.w	#dcwhite|',',(a1)+				; write a ,

	; print target address
		move.w	(a0)+,d1					; load word displacement
		subq.w	#2,d1						; account for the word read
		ext.l	d1						; extend to longword
		add.l	a0,d1						; add ROM address to d1
		jsr	d68k_ResolveAddr(pc)				; print address onto the screen

		clr.w	(a1)+						; set end token
		rts
; ---------------------------------------------------------------------------

.scc
	; Scc
		move.w	#dcblue|'s',(a1)+				; write s
		lea	d68k_SDBtbl(pc),a2				; load scc table to a2
		jsr	d68k_PrintCC2(pc)				; print condition code

	; check instruction mode
		move.w	#$1FD,d1					; get valid modes to d1
		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data

	; print the instruction mode
		moveq	#'b',d1						; load the size into d1
		jsr	d68k_PrintMode(pc)				; print address mode
		clr.w	(a1)+						; set end token
		rts
; ---------------------------------------------------------------------------

.sasq		d68k_str dcblue, 'addqsubq'

.addsubq
	; ADDQ and SUBQ

	; check instruction mode
		move.w	#$1FF,d1					; get valid modes to d1
		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data

	; print the instruction
		btst	#8,d0						; check bit 8
		sne	d1						; if set, results in 8
		and.w	#8,d1						; if clear, results in 0
		move.l	.sasq(pc,d1.w),(a1)+				; print instruction into buffer
		move.l	.sasq+4(pc,d1.w),(a1)+				;

	; print instruction size
		move.w	d0,d1						; copy instruction to d1
		lsr.w	#5,d1						; get as the lowest bits (x2)
		jsr	d68k_PrintInsSize(pc)				; print the instruction size string
		beq.w	d68k_Data					; if it was invalid, then its data

	; print the offset
		move.w	d0,d1						; copy instruction to d5
		rol.w	#16-9,d1					; rotate count into place
		and.w	#7,d1						; keep in range
		bne.s	.not0						; branch if count is not 0
		moveq	#8,d1						; special case: 0 -> 9

.not0
		add.w	#dcred|'0',d1					; turn into digit
		move.l	#((dcwhite|' ')<<16)|dcwhite|'#',(a1)+		; write a space and #
		move.w	d1,(a1)+					; print it!

	; print the instruction mode
		move.w	#dcwhite|',',(a1)+				; write a ,
		move.w	d6,d1						; load the size into d1
		jsr	d68k_PrintMode(pc)				; print address mode

		clr.w	(a1)+						; set end token
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; 8XXX and CXXX instruction handlers
; ---------------------------------------------------------------------------

d68k_i8xxx:
		lea	d68k_iDiv(pc),a2				; load DIVX routine to a2
		move.w	#dcblue|'s',d2					; load SBCD to d2
		jsr	d68k_i8Ccheck(pc)				; check for common instructions

	; OR
		move.l	#((dcblue|'o')<<16)|dcblue|'r',(a1)+		; write or
		move.l	#$0FFD01FD,d1					; prepare mode check for instruction
		jmp	d68k_CommonIns1(pc)				; execute common instruction code
; ---------------------------------------------------------------------------


d68k_iCxxx:
		lea	d68k_iMul(pc),a2				; load MULX routine to a2
		move.w	#dcblue|'a',d2					; load ABCD to d2
		bsr.s	d68k_i8Ccheck					; check for common instructions

	; check for EXG
		move.w	d0,d2						; copy instruction to d2
		and.w	#$38,d2						; get only these bits
		subq.w	#8,d2						; check if it's 8 or less
		bgt.s	.notexg						; branch if not

		cmp.w	#$140,d1					; check if opmode is $140 or $180
		blt.s	.notexg						; branch if not
; ---------------------------------------------------------------------------

	; EXG
		moveq	#$FFFFFFF8,d3					; load mask into d3
		and.w	d0,d3						; and mode to d3
		moveq	#-1,d4						; AN <-> XN

		cmp.b	#$48,d3						; check if $48		; AN <-> AN
		beq.s	.valid						; if yes, this is valid
;		cmp.b	#$80,d3						; check if $80		; AN <-> DN	; NOTE: NOT OFFICIALLY SUPPORTED!!!
;		beq.s	.valid						; if yes, this is valid

		moveq	#0,d4						; DN <-> XN
		cmp.b	#$40,d3						; check if $40		; DN <-> DN
		beq.s	.valid						; if yes, this is valid
		cmp.b	#$88,d3						; check if $88		; DN <-> AN
		bne.w	d68k_Data					; if not, its data

.valid
		move.l	#((dcblue|'e')<<16)|dcblue|'x',(a1)+		; write ex
		move.l	#((dcblue|'g')<<16)|dcwhite|' ',(a1)+		; write a g and space

		move.w	d0,d1						; copy instruction to d1
		rol.w	#16-9,d1					; rotate source register into place
		and.w	#7,d1						; mask only the register
		moveq	#7,d2						; load mask into d2
		and.w	d0,d2						; and destination register to d2

	; determine source register
		and.w	#$08,d4						; get register offset to d4
		add.w	d4,d1						; add to source register
		jsr	d68k_PrintRegister(pc)				; print it
		move.w	#dcwhite|',',(a1)+				; write a ,

	; determine destination register
		btst	#3,d3						; check if XN <-> DN
		sne	d1						; if not, set d1
		and.w	#$08,d1						; get register offset to d1
		add.w	d2,d1						; add destination register register
		jsr	d68k_PrintRegister(pc)				; print it

		clr.w	(a1)+						; set end token
		rts
; ---------------------------------------------------------------------------

.notexg
	; AND
		move.l	#((dcblue|'a')<<16)|dcblue|'n',(a1)+		; write an
		move.w	#dcblue|'d',(a1)+				; write a d
		move.l	#$0FFD01FD,d1					; prepare mode check for instruction
		jmp	d68k_CommonIns1(pc)				; execute common instruction code
; ---------------------------------------------------------------------------

d68k_i8Ccheck:
		move.w	d0,d1						; copy instruction to d1
		and.w	#$1C0,d1					; get opmode
		cmp.w	#$C0,d1						; check if $C0
		bne.s	.notu						; branch if not

		move.w	#dcblue|'u',d1					; prepare XXXU
		addq.l	#4,sp						; no more returning!
		jmp	(a2)						; jump to correct routine
; ---------------------------------------------------------------------------

.notu
		cmp.w	#$1C0,d1					; check if $1C0
		bne.s	.nots						; branch if not

		move.w	#dcblue|'s',d1					; prepare XXXS
		addq.l	#4,sp						; no more returning!
		jmp	(a2)						; jump to correct routine
; ---------------------------------------------------------------------------

.nots
		move.w	d0,d3						; copy instruction to d3
		and.w	#$1F0,d3					; get opmode and size
		cmp.w	#$100,d3					; check if this exact value
		beq.s	.xbcd						; if yes, its XBCD
		rts
; ---------------------------------------------------------------------------

.xbcd
		addq.l	#4,sp						; no more returning!
		move.w	d2,(a1)+					; write a or s

		move.l	#((dcblue|'b')<<16)|dcblue|'c',(a1)+		; write bc
		move.w	#dcblue|'d',(a1)+				; write d
; ===========================================================================
; ---------------------------------------------------------------------------
; Write standard -(AN),-(AN) or DN,DN register pair
; ---------------------------------------------------------------------------

d68k_SpecialReg1:
		move.w	d0,d1						; copy instruction to d1
		move.w	d0,d2						; copy instruction to d2
		rol.w	#16-9,d2					; rotate register into place

		move.w	#dcwhite|' ',(a1)+				; write a space
		btst	#3,d0						; check if this is DN,DN
		bne.s	.anan						; if not, branch
; ---------------------------------------------------------------------------

		jsr	d68k_PrintDataReg(pc)				; print source register
		move.w	#dcwhite|',',(a1)+				; write a ,
		move.w	d2,d1						; copy destination register to d1
		jsr	d68k_PrintDataReg(pc)				; print it

		clr.w	(a1)+						; set end token
		rts
; ---------------------------------------------------------------------------

.anan
		bsr.s	.printan					; write source register
		move.w	d2,d1						; copy destination register to d1
		move.w	#dcwhite|',',(a1)+				; write a ,

		bsr.s	.printan					; write destination register
		clr.w	(a1)+						; set end token
		rts

.printan
		move.l	#((dcwhite|'-')<<16)|dcwhite|'(',(a1)+		; write -( into buffer
		jsr	d68k_PrintAddrReg(pc)				; print address register
		move.w	#dcwhite|')',(a1)+				; write ) into buffer
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; DIVX and MULX instruction handlers
; ---------------------------------------------------------------------------

d68k_iMul:
		move.l	#((dcblue|'m')<<16)|dcblue|'u',(a1)+		; write mu
		move.w	#dcblue|'l',(a1)+				; write l
		move.w	d1,(a1)+					; write sign
		bra.s	d68k_iMulDiv
; ---------------------------------------------------------------------------

d68k_iDiv:
		move.l	#((dcblue|'d')<<16)|dcblue|'i',(a1)+		; write di
		move.w	#dcblue|'v',(a1)+				; write v
		move.w	d1,(a1)+					; write sign
; ---------------------------------------------------------------------------

d68k_iMulDiv:
		move.w	d0,d2						; copy register to d2
		move.w	d0,d3						; copy instruction to d3
		lsr.w	#1,d3						; shift down so its ready to use

	; check instruction mode
		move.w	#$FFD,d1					; get valid modes to d1
		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data

	; print the instruction mode
		move.w	#dcwhite|' ',(a1)+				; write a space
		moveq	#'w',d1						; load the size into d1
		jsr	d68k_PrintMode(pc)				; print address mode

		move.w	#dcwhite|',',(a1)+				; write a ,
		move.w	d0,d1						; copy instruction to d1
		rol.w	#16-9,d1					; rotate register into place
		jsr	d68k_PrintDataReg(pc)				; print it

		clr.w	(a1)+						; set end token
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; 0XXX instruction handler
; ---------------------------------------------------------------------------

d68k_sMovep:	d68k_str dcblue, 'movep'
		dc.w 0

d68k_i0xxx:
		btst	#8,d0						; check if this is a special mode
		beq.w	d68k_i00xx					; if yes, branch
		move.w	d0,d1						; copy instruction to d1
		and.w	#$38,d1						; check for mode
		subq.w	#8,d1						; check if its 8
		bne.s	.bxxx						; if not, branch
; ---------------------------------------------------------------------------

	; MOVEP
		lea	d68k_sMovep(pc),a2				; load movep initialization string into a2
		jsr	d68k_CopyStr(pc)				; copy the string over
		subq.w	#2,a1						; we need to insert things before the end here

	; print instruction size
		btst	#6,d0						; check which size to use
		jsr	d68k_PrintSmallSize(pc)				; print the size string
		move.w	#dcwhite|' ',(a1)+				; write a space

	; check if data register is source
		tst.b	d0						; check if bit7 is set
		bpl.s	.nodn1						; branch if not
		bsr.s	.writereg					; write the register first
		move.w	#dcwhite|',',(a1)+				; write a ,

.nodn1
	; print the d16(AN) part
		move.w	(a0)+,d1					; load the data offset to d1
		jsr	d68k_PrintWord(pc)				; print it

		move.w	#dcwhite|'(',(a1)+				; write ( into buffer
		move.w	d0,d1						; copy register into d1
		jsr	d68k_PrintAddrReg(pc)				; print address register
		move.w	#dcwhite|')',(a1)+				; write ) into buffer

	; check if data register is destination
		tst.b	d0						; check if bit7 is set
		bmi.s	.nodn2						; branch if yes
		move.w	#dcwhite|',',(a1)+				; write a ,
		bsr.s	.writereg					; write the register last

.nodn2
		clr.w	(a1)+						; set end token
		rts
; ---------------------------------------------------------------------------

	; print the register
.writereg
		move.w	d0,d1						; copy instruction to d1
		rol.w	#16-9,d1					; rotate register into place
		jmp	d68k_PrintDataReg(pc)				; print it!
; ---------------------------------------------------------------------------

.bxxx
	; BXXX DN, EA
		bsr.s	d68k_PrintBXXX					; print the instruction
		move.l	#$0FFD01FD,d1					; prepare instruction modes into d1
		tst.w	d5						; check if this is BTST
		bne.s	.notbtst					; branch if not
		swap	d1						; use alternate set for btst

.notbtst
		move.w	d0,d2						; copy register to d2
		move.w	d0,d3						; copy instruction to d3
		lsr.w	#1,d3						; shift down so its ready to use

	; check instruction mode
		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data

	; print source register
		move.w	d0,d1						; copy instruction to d1
		rol.w	#16-9,d1					; rotate register into place
		jsr	d68k_PrintDataReg(pc)				; print it
		move.w	#dcwhite|',',(a1)+				; write a ,

	; print the instruction mode
		moveq	#'b',d1						; size is byte
		jsr	d68k_PrintMode(pc)				; print address mode
		clr.w	(a1)+						; set end token
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Print BXXX instruction string
; ---------------------------------------------------------------------------

d68k_PrintBXXX:
		move.w	d0,d5						; copy the instruction to d5
		and.w	#$C0,d5						; keep in range
		lsr.w	#3,d5						; shift into place

		move.l	.ins(pc,d5.w),(a1)+				; write instruction into buffer
		move.l	.ins+4(pc,d5.w),(a1)+				;
		move.w	#dcwhite|' ',(a1)+				; write a space
		rts

.ins		d68k_str dcblue, 'btstbchgbclrbset'
; ===========================================================================
; ---------------------------------------------------------------------------
; BXXX # instruction handler
; ---------------------------------------------------------------------------

d68k_bxxx:
	; BXXX #, EA
		bsr.s	d68k_PrintBXXX					; print the instruction

	; print data value
		move.w	#dcwhite|'#',(a1)+				; write # into buffer
		move.w	(a0)+,d1					; load the data value to d1
		jsr	d68k_PrintWord(pc)				; print it

	; check instruction mode
		move.l	#$07FD01FD,d1					; prepare instruction modes into d1
		tst.w	d5						; check if this is BTST
		bne.s	.notbtst					; branch if not
		swap	d1						; use alternate set for btst

.notbtst
		move.w	d0,d2						; copy register to d2
		move.w	d0,d3						; copy instruction to d3
		lsr.w	#1,d3						; shift down so its ready to use

		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data
		move.w	#dcwhite|',',(a1)+				; write a ,

	; print the instruction mode
		moveq	#'b',d1						; size is byte
		jsr	d68k_PrintMode(pc)				; print address mode
		clr.w	(a1)+						; set end token
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; 00XX instruction handler
; ---------------------------------------------------------------------------

d68k_s00xx:	d68k_str dcblue, 'ori'
		dc.w 0
		d68k_str dcblue, 'andisubiaddi'
		dc.w 0, 0, 0, 0
		d68k_str dcblue, 'eoricmpi'

d68k_i00xx:
		move.w	d0,d1						; copy instruction to d1
		and.w	#$0E00,d1					; get second nibble data
		cmp.w	#$0E00,d1					; check if the last option?
		beq.w	d68k_Data					; if yes, present it as data
		cmp.w	#$0800,d1					; check if this is bxxx
		beq.w	d68k_bxxx					; if yes, deal with it

	; XXXI
		lsr.w	#6,d1						; align properly
		move.l	d68k_s00xx(pc,d1.w),(a1)+			; load instruction into buffer
		move.l	d68k_s00xx+4(pc,d1.w),(a1)+			;

		tst.w	-2(a1)						; check if last character was null (ori)
		seq	d1						; if yes, set d1
		and.w	#2,d1						; 2 character offset
		sub.w	d1,a1						; undo terminator

	; print instruction size
		move.w	d0,d1						; copy instruction to d1
		lsr.w	#5,d1						; get as the lowest bits (x2)
		jsr	d68k_PrintInsSize(pc)				; print the instruction size string
		beq.w	d68k_Data					; if it was invalid, then its data

	; write immediate value
		move.w	#dcwhite|' ',(a1)+				; write a space
		move.w	d6,d1						; copy instruction size to d1
		jsr	d68k_ModeImm(pc)				; write immediate mode
		move.w	#dcwhite|',',(a1)+				; write a ,

	; check if this is sr or ccr instruction
		move.w	d0,d1						; copy instruction to d1
		and.w	#$0600,d1					; and with this special value
		cmp.w	#$0400,d1					; check if this is a special instruction
		bge.s	.notspecial					; branch if not

		move.w	d0,d1						; copy instruction to d1
		and.w	#$3F,d1						; check if special mode
		cmp.w	#$3C,d1						;
		beq.s	d68k_WriteSRCCR					; branch if yes
; ---------------------------------------------------------------------------

.notspecial
	; XXXI #, EA

	; check instruction mode
		move.w	d0,d2						; copy register to d2
		move.w	d0,d3						; copy instruction to d3
		lsr.w	#1,d3						; shift down so its ready to use

		move.w	#$01FD,d1					; prepare instruction modes into d1
		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data

	; print the instruction mode
		move.w	d6,d1						; size is byte
		jsr	d68k_PrintMode(pc)				; print address mode
		clr.w	(a1)+						; set end token
		rts
; ---------------------------------------------------------------------------

	; XXXI #, SR/CCR
d68k_WriteSRCCR:
		cmp.b	#'l',d6						; check if size is longword
		beq.w	d68k_Data					; if yes, its data!
		cmp.b	#'b',d6						; check if its ccr
		beq.s	.ccr						; if yes, branch

		move.w	#dcgreen|'s',(a1)+				; write a s
		bra.s	.srccr

.ccr
		move.l	#((dcgreen|'c')<<16)|dcgreen|'c',(a1)+		; write cc

.srccr
		move.w	#dcgreen|'r',(a1)+				; write a r
		clr.w	(a1)+						; set end token
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; LEA and CHK instruction handlers
; ---------------------------------------------------------------------------

d68k_iLEACHK:
		move.w	d0,d7						; copy instruction to d7
		rol.w	#16-9,d7					; get as the lowest bits
		and.w	#7,d7						; keep in range

		btst	#6,d0						; check if this is CHK
		bne.s	.lea						; if not, branch
; ---------------------------------------------------------------------------

	; CHK
		move.l	#((dcblue|'c')<<16)|dcblue|'h',(a1)+		; write ch
		move.l	#((dcblue|'k')<<16)|dcwhite|' ',(a1)+		; write a k and space
		move.w	#$FFD,d1					; prepare instruction modes into d1
		bra.s	.common
; ---------------------------------------------------------------------------

.lea
	; LEA
		tst.b	d0						; check if this bit is set
		bpl.w	d68k_Data					; if not, its invalid
		move.l	#((dcblue|'l')<<16)|dcblue|'e',(a1)+		; write le
		move.l	#((dcblue|'a')<<16)|dcwhite|' ',(a1)+		; write a l and space

		bset	#3,d7						; make it an address register
		move.w	#$7E4,d1					; prepare instruction modes into d1

.common
	; check instruction mode
		move.w	d0,d2						; copy register to d2
		move.w	d0,d3						; copy instruction to d3
		lsr.w	#1,d3						; shift down so its ready to use

		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data

	; print the instruction mode
		moveq	#'w',d1						; size is word
		jsr	d68k_PrintMode(pc)				; print address mode
		move.w	#dcwhite|',',(a1)+				; write a ,

	; print the destinnation register
		move.w	d7,d1						; copy register to d1
		jsr	d68k_PrintRegister(pc)				; print the register
		clr.w	(a1)+						; set end token
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; 4XXX instruction handler
; ---------------------------------------------------------------------------

d68k_i4xxx:
		btst	#8,d0						; check if LEA or CHK
		bne.w	d68k_iLEACHK					; if yes, run its code

		move.w	d0,d1						; copy instruction to d1
		and.w	#$0E00,d1					; get 3 upper bits of second nibble
		lsr.w	#7,d1						; shift into place

		move.w	d0,d2						; copy instruction to d2
		and.w	#$C0,d2						; check for a specific value
		cmp.w	#$C0,d2						;
		beq.s	.alt						; if so, check alternate table

		move.l	.tbl(pc,d1.w),a2				; load jump address to a2
		jmp	(a2)						; jump to code
; ---------------------------------------------------------------------------

.alt
		move.l	.tbl2(pc,d1.w),a2				; load jump address to a2
		jmp	(a2)						; jump to code
; ---------------------------------------------------------------------------

.tbl		dc.l d68k_iNegx, d68k_iClr,  d68k_iNeg,  d68k_iNot
		dc.l d68k_iNbcd, d68k_iTst,  d68k_iMovem,d68k_i4E4X

.tbl2		dc.l d68k_iMfsr, d68k_iMfccr,d68k_iMtccr,d68k_iMtsr
		dc.l d68k_iNbcd, d68k_iTas,  d68k_iMovem,d68k_JmpJsr
; ===========================================================================
; ---------------------------------------------------------------------------
; print move instruction
; ---------------------------------------------------------------------------

d68k_PrintMove:
		move.l	#((dcblue|'m')<<16)|dcblue|'o',(a1)+		; write mo into buffer
		move.l	#((dcblue|'v')<<16)|dcblue|'e',(a1)+		; write ve into buffer
		move.w	#dcwhite|' ',(a1)+				; write a space
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; MOVE from SR and CCR instruction handlers
; ---------------------------------------------------------------------------

d68k_iMfsr:
		moveq	#'w',d6						; use word for sr
		bra.s	d68k_iMfccrsr
; ---------------------------------------------------------------------------

d68k_iMfccr:
		moveq	#'b',d6						; use word for ccr
; ---------------------------------------------------------------------------

d68k_iMfccrsr:
		bsr.s	d68k_PrintMove					; print MOVE into buffer
		jsr	d68k_WriteSRCCR(pc)				; print SR or CCR into buffer
		move.w	#dcwhite|',',-2(a1)				; write a ,

	; check instruction mode
		move.w	d0,d2						; copy register to d2
		move.w	d0,d3						; copy instruction to d3
		lsr.w	#1,d3						; shift down so its ready to use

		move.w	#$3FD,d1					; get valid modes to d1
		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data

	; print the instruction mode
		move.w	d6,d1						; size is byte
		jsr	d68k_PrintMode(pc)				; print address mode
		clr.w	(a1)+						; set end token
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; MOVE to SR and CCR instruction handlers
; ---------------------------------------------------------------------------

d68k_iMtsr:
		moveq	#'w',d6						; use word for sr
		bra.s	d68k_iMtccrsr
; ---------------------------------------------------------------------------

d68k_iMtccr:
		moveq	#'b',d6						; use word for ccr
; ---------------------------------------------------------------------------

d68k_iMtccrsr:
		bsr.s	d68k_PrintMove					; print MOVE into buffer
		move.w	d0,d2						; copy register to d2
		move.w	d0,d3						; copy instruction to d3
		lsr.w	#1,d3						; shift down so its ready to use

	; check instruction mode
		move.w	#$FFD,d1					; get valid modes to d1
		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data

	; print the instruction mode
		move.w	d6,d1						; size is byte
		jsr	d68k_PrintMode(pc)				; print address mode
		move.w	#dcwhite|',',(a1)+				; write a ,

	; write SR or CCR
		jsr	d68k_WriteSRCCR(pc)				; print SR or CCR into buffer
		clr.w	(a1)+						; set end token
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; JMP and JSR instruction handlers
; ---------------------------------------------------------------------------

d68k_JmpJsr:
		tst.b	d0						; check if bit7 is set
		bpl.w	d68k_Data					; if not, its invalid

		btst	#6,d0						; check if jmp or jsr
		seq	d1						; if jsr, 8
		and.w	#8,d1						; if jmp, 0
		move.l	.jmpjsr(pc,d1.w),(a1)+				; print instruction
		move.l	.jmpjsr+4(pc,d1.w),(a1)+			;

	; check instruction mode
		move.w	d0,d2						; copy register to d2
		move.w	d0,d3						; copy instruction to d3
		lsr.w	#1,d3						; shift down so its ready to use

		move.w	#$7E4,d1					; get valid modes to d1
		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data

	; print the instruction mode
		moveq	#'w',d1						; size is byte
		jsr	d68k_PrintMode(pc)				; print address mode
		clr.w	(a1)+						; set end token
		rts

.jmpjsr		d68k_str dcblue, 'jmp jsr '
; ===========================================================================
; ---------------------------------------------------------------------------
; ILLEGAL instruction handler
; ---------------------------------------------------------------------------

d68k_sIllegal:	d68k_str dcblue, 'illegal'
		dc.w 0

d68k_iIllegal:
		lea	d68k_sIllegal(pc),a2				; load movem initialization string into a2
		jmp	d68k_CopyStr(pc)				; copy the string over
; ===========================================================================
; ---------------------------------------------------------------------------
; TAS instruction handler
; ---------------------------------------------------------------------------

d68k_iTas:
		move.w	d0,d3						; copy instruction to d3
		and.w	#$3F,d3						; check for a specific value
		cmp.w	#$3C,d3						;
		beq.s	d68k_iIllegal					; branch if yes

	; check instruction mode
		lsr.w	#1,d3						; shift down so its ready to use
		move.w	d0,d2						; copy register to d2

		move.w	#$1FD,d1					; get valid modes to d1
		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data

	; print the instruction mode
		move.l	#((dcblue|'t')<<16)|dcblue|'a',(a1)+		; write ta
		move.l	#((dcblue|'s')<<16)|dcwhite|' ',(a1)+		; write a s and space

		moveq	#'b',d1						; size is byte
		jsr	d68k_PrintMode(pc)				; print address mode
		bra.s	d68k_Token					; fuck it needed to save 2 bytes
; ===========================================================================
; ---------------------------------------------------------------------------
; NEGX instruction handler
; ---------------------------------------------------------------------------

d68k_iNegx:
		move.l	#((dcblue|'n')<<16)|dcblue|'e',(a1)+		; write ne
		move.l	#((dcblue|'g')<<16)|dcblue|'x',(a1)+		; write gx
		bra.s	d68k_CommonIns2
; ===========================================================================
; ---------------------------------------------------------------------------
; CLR instruction handler
; ---------------------------------------------------------------------------

d68k_iClr:
		move.l	#((dcblue|'c')<<16)|dcblue|'l',(a1)+		; write cl
		move.w	#dcblue|'r',(a1)+				; write a r
		bra.s	d68k_CommonIns2
; ===========================================================================
; ---------------------------------------------------------------------------
; NEG instruction handler
; ---------------------------------------------------------------------------

d68k_iNeg:
		move.l	#((dcblue|'n')<<16)|dcblue|'e',(a1)+		; write ne
		move.w	#dcblue|'g',(a1)+				; write a g
		bra.s	d68k_CommonIns2
; ===========================================================================
; ---------------------------------------------------------------------------
; NOT instruction handler
; ---------------------------------------------------------------------------

d68k_iNot:
		move.l	#((dcblue|'n')<<16)|dcblue|'o',(a1)+		; write no
		bra.s	d68k_iTst2
; ===========================================================================
; ---------------------------------------------------------------------------
; SWAP instruction handler
; ---------------------------------------------------------------------------

d68k_iSwap:
		move.l	#((dcblue|'s')<<16)|dcblue|'w',(a1)+		; write sw
		move.l	#((dcblue|'a')<<16)|dcblue|'p',(a1)+		; write ap
		move.w	#dcwhite|' ',(a1)+				; write a space

		move.w	d0,d1						; copy register to d1
		jsr	d68k_PrintDataReg(pc)				; print data register

d68k_Token:
		clr.w	(a1)+						; set end token
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; TST instruction handler
; ---------------------------------------------------------------------------

d68k_iTst:
		move.l	#((dcblue|'t')<<16)|dcblue|'s',(a1)+		; write ts

d68k_iTst2:
		move.w	#dcblue|'t',(a1)+				; write a t
; ===========================================================================
; ---------------------------------------------------------------------------
; common type 2 instruction handler
; ---------------------------------------------------------------------------

d68k_CommonIns2:
	; print instruction size
		move.w	d0,d1						; copy instruction to d1
		lsr.w	#5,d1						; get as the lowest bits (x2)
		jsr	d68k_PrintInsSize(pc)				; print the instruction size string
		beq.w	d68k_Data					; if it was invalid, then its data
; ===========================================================================
; ---------------------------------------------------------------------------
; common type 3 instruction handler
;
; input:
;   d6 = instruction size
; ---------------------------------------------------------------------------

d68k_CommonIns3:
	; check instruction mode
		move.w	d0,d2						; copy register to d2
		move.w	d0,d3						; copy instruction to d3
		lsr.w	#1,d3						; shift down so its ready to use

		move.w	#$1FD,d1					; get valid modes to d1
		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data

	; print the instruction mode
		move.w	#dcwhite|' ',(a1)+				; write a space
		move.w	d6,d1						; size is byte
		jsr	d68k_PrintMode(pc)				; print address mode

		clr.w	(a1)+						; set end token
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; PEA instruction handler
; ---------------------------------------------------------------------------

d68k_iPea:
	; check instruction mode
		move.w	d0,d2						; copy register to d2
		move.w	d0,d3						; copy instruction to d3
		lsr.w	#1,d3						; shift down so its ready to use

		move.w	#$7E5,d1					; get valid modes to d1
		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data

		tst.w	d3						; check if data register
		beq.s	d68k_iSwap					; if yes, it's swap
; ---------------------------------------------------------------------------

		move.l	#((dcblue|'p')<<16)|dcblue|'e',(a1)+		; write pe
		move.l	#((dcblue|'a')<<16)|dcwhite|' ',(a1)+		; write a a and space

	; print the instruction mode
		moveq	#'w',d1						; size is byte
		jsr	d68k_PrintMode(pc)				; print address mode
		clr.w	(a1)+						; set end token
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; NBCD instruction handler
; ---------------------------------------------------------------------------

d68k_iNbcd:
		tst.b	d0						; is bit7 set?
		bmi.s	d68k_iExt					; if yes, it's MOVEM or EXT
		btst	#6,d0						; is bit7 set?
		bne.s	d68k_iPea					; if yes, its PEA or SWAP
; ---------------------------------------------------------------------------

		move.l	#((dcblue|'n')<<16)|dcblue|'b',(a1)+		; write nb
		move.l	#((dcblue|'c')<<16)|dcblue|'d',(a1)+		; write cd
		moveq	#'w',d6						; prepare instruction size
		bra.s	d68k_CommonIns3
; ===========================================================================
; ---------------------------------------------------------------------------
; EXT instruction handler
; ---------------------------------------------------------------------------

d68k_iExt:
		move.w	d0,d1						; copy instruction to d1
		and.w	#$38,d1						; get these bits
		bne.s	d68k_iMovemCom					; if not 0, its MOVEM

		move.l	#((dcblue|'e')<<16)|dcblue|'x',(a1)+		; write ex
		move.w	#dcblue|'t',(a1)+				; write a t

	; print instruction size
		btst	#6,d0						; check if this is a longword
		jsr	d68k_PrintSmallSize(pc)				; print the size according to check
		move.w	#dcwhite|' ',(a1)+				; write a space

	; print register
		move.w	d0,d1						; copy register to d1
		jsr	d68k_PrintDataReg(pc)				; print data register
		clr.w	(a1)+						; set end token
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; MOVEM instruction handler
; ---------------------------------------------------------------------------

d68k_iMovem:
d68k_iMovemCom:
		move.w	d0,d1						; copy instruction to d1
		and.w	#$380,d1					; get these bits
		cmp.w	#$80,d1						; check if this value
		bne.w	d68k_Data					; if not, present it as data

		lea	d68k_sMovem(pc),a2				; load movem initialization string into a2
		jsr	d68k_CopyStr(pc)				; copy the string over
		subq.w	#2,a1						; we need to insert things before the end here

	; print instruction size
		btst	#6,d0						; check if this is a longword
		jsr	d68k_PrintSmallSize(pc)				; print the size according to check
		move.w	#dcwhite|' ',(a1)+				; write a space
		move.w	(a0)+,a4					; load register list to a4

	; check if MOVEM arguments come first
		move.l	#$01F407EC,d1					; prepare instruction modes into d1
		btst	#10,d0						; check if movem args are first
		bne.s	.nor1						; branch if not

		swap	d1						; use alternate set
		bsr.s	.dumpreg					; dump registers
		move.w	#dcwhite|',',(a1)+				; write a ,
; ---------------------------------------------------------------------------

.nor1
	; check instruction mode
		move.w	d0,d2						; copy register to d2
		move.w	d0,d3						; copy instruction to d3
		lsr.w	#1,d3						; shift down so its ready to use

		jsr	d68k_CheckModes(pc)				; check if this is a valid mode
		beq.w	d68k_Data					; if not a valid mode, present it as data

	; print the instruction mode
		move.w	d6,d1						; size is byte
		jsr	d68k_PrintMode(pc)				; print address mode
; ---------------------------------------------------------------------------

	; check if MOVEM arguments come last
		btst	#10,d0						; check if movem args are last
		beq.s	.nor2						; branch if not
		move.w	#dcwhite|',',(a1)+				; write a ,
		bsr.s	.dumpreg					; dump registers

.nor2
		clr.w	(a1)+						; set end token
		rts
; ---------------------------------------------------------------------------

.dumpreg
		move.w	a4,d3						; copy register list to d3
		bne.s	.notnull					; branch if 1 or more registers are used
		move.w	#dcred|'0',(a1)+				; write a single red 0
		rts

.notnull
		move.w	d0,d2						; copy instruction to d2
		and.w	#$38,d2						; get the eamode to d2
		cmp.w	#8*4,d2						; check if -(AN)
		bne.s	.normal						; branch if not

	; now here is some WTF for you. For this one specific mode, the bitfield is FUCKING BACKWARDS. You heard me right. Backwards. WTF Motorola!!!
		move.w	d3,d2						; copy register list to d2
		moveq	#0,d3						; clear register list
		moveq	#16-1,d4					; set repeat count to d4

.invert
		lsr.w	#1,d2						; shift the next bit to carry
		addx.w	d3,d3						; add carry and shift d3
		dbf	d4,.invert					; repeat like 16 times wtf
; ---------------------------------------------------------------------------

.normal
		move.w	d1,a3						; store d1 temporarily
		moveq	#0,d2						; set current bit to 0
		moveq	#-1,d1						; set starting bit to null
		moveq	#0,d7						; no registers are written

.loop
		lsr.w	#1,d3						; shift the next bit into carry
		bcc.s	.notset						; if not set, branch
		tst.b	d1						; check if we have found a starting bit
		bpl.s	.next						; if yes, go to next iteration
		move.w	d2,d1						; set as the new starting bit
; ---------------------------------------------------------------------------

.next
		addq.w	#1,d2						; go to next bit
		cmp.w	#17,d2						; check if bit 17
		ble.s	.loop						; if not, go to loop
		move.w	a3,d1						; get d1 back
		rts
; ---------------------------------------------------------------------------

.notset
		tst.b	d1						; check if we have found a starting bit
		bmi.s	.next						; if not, go to next iteration
		move.w	d2,d5						; copy ending bit to d5
		subq.w	#1,d5						; align it correctly

	; print separator
		tas	d7						; check if we have written a register already
		bpl.s	.nowrite					; branch if not
		move.w	#dcwhite|'/',(a1)+				; write a /

	; print out an appropriate version of the bit string
.nowrite
		move.w	d1,a4						; store a4 temporarily
		jsr	d68k_PrintRegister(pc)				; print the starting register
		cmp.w	d5,a4						; check if the distance is 0 registers
		beq.s	.reset						; branch if yes

		move.w	#dcwhite|'-',(a1)+				; write a -
		move.w	d5,d1						; copy ending register to d1
		jsr	d68k_PrintRegister(pc)				; print it

.reset
		moveq	#-1,d1						; set no starting bit
		bra.s	.next						; go to next iteration
; ---------------------------------------------------------------------------


d68k_sMovem:	d68k_str dcblue, 'movem'
		dc.w 0
; ===========================================================================
; ---------------------------------------------------------------------------
; 4E4X instruction handler
; ---------------------------------------------------------------------------

d68k_i4E4X:
		btst	#6,d0						; check if bit6 is set
		beq.w	d68k_JmpJsr					; if not, its jmp

		move.w	d0,d1						; copy instruction to d1
		and.w	#$0038,d1					; get few random bits
		lsr.w	#1,d1						; shift into place
		move.l	.tbl(pc,d1.w),a2				; load jump address to a2
		jmp	(a2)						; jump to code
; ---------------------------------------------------------------------------

.tbl		dc.l d68k_iTrap, d68k_iTrap, d68k_iLink, d68k_iUnlk
		dc.l d68k_iMvUSP,d68k_iMvUSP,d68k_i4E7X, d68k_Data
; ===========================================================================
; ---------------------------------------------------------------------------
; MOVE USP instruction handler
; ---------------------------------------------------------------------------

d68k_iMvUSP:
		jsr	d68k_PrintMove(pc)				; print MOVE into buffer
		move.w	d0,d1						; copy instruction to d1

	; check if data register is source
		btst	#3,d0						; check if bit3 is set
		bne.s	.noan1						; branch if not
		jsr	d68k_PrintAddrReg(pc)				; print address register
		move.w	#dcwhite|',',(a1)+				; write a ,

.noan1
	; print USP
		move.l	#((dcgreen|'u')<<16)|dcgreen|'s',(a1)+		; write us into buffer
		move.w	#dcgreen|'p',(a1)+				; write p into buffer

	; check if data register is destination
		btst	#3,d0						; check if bit3 is set
		beq.s	.noan2						; branch if yes
		move.w	#dcwhite|',',(a1)+				; write a ,
		jsr	d68k_PrintAddrReg(pc)				; print address register

.noan2
		clr.w	(a1)+						; set end token
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; TRAP instruction handler
; ---------------------------------------------------------------------------

d68k_iTrap:	; LEWD OWO
		move.l	#((dcblue|'t')<<16)|dcblue|'r',(a1)+		; write tr into buffer
		move.l	#((dcblue|'a')<<16)|dcblue|'p',(a1)+		; write ap into buffer
		move.l	#((dcwhite|' ')<<16)|dcwhite|'#',(a1)+		; write a space and #

		move.w	d0,d1						; copy instruction to d1
		and.w	#$F,d1						; get the vector
		cmp.w	#9,d1						; check if the number is above 9
		ble.s	.no						; branch if not

		sub.w	#$A,d1						; offset correctly
		move.w	#dcred|'1',(a1)+					; write 1 digit

.no
		add.w	d1,d1						; double offset
		lea	d68k_DigitTbl(pc),a2				; load table to a2
		move.w	(a2,d1.w),(a1)+					; print number

		clr.w	(a1)+						; set end token
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; LINK instruction handler
; ---------------------------------------------------------------------------

d68k_iLink:
		move.l	#((dcblue|'l')<<16)|dcblue|'i',(a1)+		; write li into buffer
		move.l	#((dcblue|'n')<<16)|dcblue|'k',(a1)+		; write nk into buffer
		move.w	#dcwhite|' ',(a1)+				; write a space

		move.w	d0,d1						; copy register to d1
		jsr	d68k_PrintAddrReg(pc)				; print address register
		move.l	#((dcwhite|',')<<16)|dcwhite|'#',(a1)+		; write ,#

		move.w	(a0)+,d1					; load offset word to d1
		jsr	d68k_PrintWord(pc)				; print it
		clr.w	(a1)+						; set end token
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; UNLK instruction handler
; ---------------------------------------------------------------------------

d68k_iUnlk:
		move.l	#((dcblue|'u')<<16)|dcblue|'n',(a1)+		; write un into buffer
		move.l	#((dcblue|'l')<<16)|dcblue|'k',(a1)+		; write lk into buffer
		move.w	#dcwhite|' ',(a1)+				; write a space

		move.w	d0,d1						; copy register to d1
		jsr	d68k_PrintAddrReg(pc)				; print address register
		clr.w	(a1)+						; set end token
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; 4E7X instruction handler
; ---------------------------------------------------------------------------

d68k_i4E7X:
		move.w	d0,d1						; copy instruction to d1
		and.w	#7,d1						; get instruction offset
		move.b	.insoff(pc,d1.w),d1				; load instruction offset to d1
		lea	.ins(pc,d1.w),a2				; load string to a2
		jsr	d68k_CopyStr(pc)				; copy the string over
; ---------------------------------------------------------------------------

		tst.b	d1						; check instruction
		bmi.w	d68k_Data					; if yes, this is an invalid instruction
		bne.s	.end						; branch if not stop

		subq.w	#2,a1						; we need to insert things before the end here
		move.l	#((dcwhite|' ')<<16)|dcwhite|'#',(a1)+		; write a space and #

		move.w	(a0)+,d1					; load value to d1
		jsr	d68k_PrintWord(pc)				; print it
		clr.w	(a1)+						; set end token

.end
		rts
; ---------------------------------------------------------------------------

.insoff		dc.b .reset-.ins, .nop-.ins, 0, .rte-.ins
		dc.b -2, .rts-.ins, .trapv-.ins, .rtr-.ins

.ins		d68k_str dcblue, 'stop'
		dc.w 0
.reset		d68k_str dcblue, 'reset'
		dc.w 0
.trapv		d68k_str dcblue, 'trapv'
		dc.w 0
.nop		d68k_str dcblue, 'nop'
		dc.w 0
.rtr		d68k_str dcblue, 'rtr'
		dc.w 0
.rte		d68k_str dcblue, 'rte'
		dc.w 0
.rts		d68k_str dcblue, 'rts'
		dc.w 0
; ===========================================================================
; ---------------------------------------------------------------------------
; Handler for writing your own addresses into the buffer.
; This could be used to handle reading from a listing file based on
; the provided address
;
; input:
;   d1 = address to write
;   a1 = text buffer address
; ---------------------------------------------------------------------------

d68k_ResolveAddr:
		jmp	d68k_PrintAddr(pc)				; print it
; ---------------------------------------------------------------------------
