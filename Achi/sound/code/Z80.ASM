; ===========================================================================
; ---------------------------------------------------------------------------
; DUAL-PCM - by MarkeyJester
; ---------------------------------------------------------------------------

x	=	0DDh
y	=	0FDh

ldin		macro	TYPE, DEST, SOURCE
		dc.b	\TYPE				; 04	; load to/from index register
		ld	\DEST,\SOURCE			; ??	; ''
		endm

deci		macro	TYPE, REG
		dc.b	\TYPE				; 04	; decrement register
		dec	\REG				; 04	; ''
		endm

inci		macro	TYPE, REG
		dc.b	\TYPE				; 04	; increment register
		inc	\REG				; 04	; ''
		endm

; ---------------------------------------------------------------------------

M_Read		macro
		ldi					; 16	; copy from window to buffer, and increment register
		zadd	a,b				; 04	; add dividend
		adc	hl,sp				; 15	; add quotient
		endm					; Total: 35

; ---------------------------------------------------------------------------

M_Flush01	macro
		ld	e,(hl)				; 07	; load byte from OUT buffer 1 to volume pointer
		ld	a,(de)				; 07	; copy to a
		zset	001h,h				; 08	; move forwards to OUT buffer 2
		inc	d				; 04	; move forwards to volume pointer 2
		ld	e,(hl)				; 07	; load byte from OUT buffer 2 to volume pointer
		ex	de,hl				; 04	; swap for hl powers
		zadd	a,(hl)				; 07	; add volume 2 to volume 1
		ex	de,hl				; 04	; swap back
		ld	(bc),a				; 07	; save to the YM2612
		inc	l				; 04	; advance OUT buffers
		endm					; Total: 59

; ---------------------------------------------------------------------------

M_Flush02	macro
		ld	e,(hl)				; 07	; load byte from OUT buffer 2 to volume pointer
		ld	a,(de)				; 07	; copy to a
		res	001h,h				; 08	; move back to OUT buffer 1
		dec	d				; 04	; move back to volume pointer 1
		ld	e,(hl)				; 07	; load byte from OUT buffer 1 to volume pointer
		ex	de,hl				; 04	; swap for hl powers
		zadd	a,(hl)				; 07	; add volume 1 to volume 2
		ex	de,hl				; 04	; swap back
		ld	(bc),a				; 07	; save to the YM2612
		inc	l				; 04	; advance OUT buffers
		endm					; Total: 59

; ---------------------------------------------------------------------------

M_Revert01	macro
		res	001h,h				; 08	; move back to OUT buffer 1
		dec	d				; 04	; move back to volume pointer 1
		dec	l				; 04	; move OUT buffers back
		endm

; ---------------------------------------------------------------------------

M_Revert02	macro
		zset	001h,h				; 08	; move forwards to OUT buffer 2
		inc	d				; 04	; move forwards to volume pointer 2
		dec	l				; 04	; move OUT buffers back
		endm

; ===========================================================================
; ---------------------------------------------------------------------------
; Start of Z80 ROM
; ---------------------------------------------------------------------------

Z80_Start:
		di					; 04	; disable interrupts
		xor	a				; 04	; clear refresh register and interrupt index (since I can't use "im  2" on certain emulators).
		ld	r,a				; 08	; ''
		ld	i,a				; 08	; ''
		jp	Z80_Init			; 10	; jump to the rest of the init routine

		align	00Ch

	; The space from "Start" until the maximum pitch amount, is the space
	; where data could potentially be pushed into, thanks to the sp.

	; The sp will likely be from roughly FFF3 - 000C for the quotient of
	; the pitch.  Now, FFF3 - FFFF will be fine, since that points to the
	; 68k window, which will be pointing to 68k ROM, so nothing will happen.
	; But the address from 0000 - 000C points to the beginning of ROM, so
	; this place must be free from use outside of V-blank.

Z80_Stack:

; ===========================================================================
; ---------------------------------------------------------------------------
; PCM 1 Resetting
; ---------------------------------------------------------------------------
		align	010h
; ---------------------------------------------------------------------------

BreakLate:
		deci	y,h				; 08	; set "restore mode"
		ld	sp,Z80_Stack			; 10	; load valid stack address
		push	af				; 11	; store a and flags
		jp	BVB_Check			; 10	; jump to V-blank routine

; ===========================================================================
; ---------------------------------------------------------------------------
; PCM 1 Resetting
; ---------------------------------------------------------------------------
		align	028h
; ---------------------------------------------------------------------------

PCM1_ResetJmp:
		jp	PCM1_Reset			; 10	; jump to actual routine

; ===========================================================================
; ---------------------------------------------------------------------------
; PCM 2 Resetting
; ---------------------------------------------------------------------------
		align	030h
; ---------------------------------------------------------------------------

PCM2_ResetJmp:
		jp	PCM2_Reset			; 10	; jump to actual routine

; ===========================================================================
; ---------------------------------------------------------------------------
; Breaking out for V-blank
; ---------------------------------------------------------------------------
		align	038h
; ---------------------------------------------------------------------------

BreakVBlank:
		push	af				; 11	; store a and flags
		ld	a,(YM_Buffer)			; 13	; load buffer to write to
		cpl					; 04	; change buffer
		ld	(YM_Buffer),a			; 13	; update...

BVB_Check:
		ldin	y,a,l				; 08	; load iyl
		zor	a				; 04	; check read status (FF = Bank | 00 = Non-Read | 01 = Window)
		jp	nz,BreakDMA			; 10	; if the interrupt is happening during bank or window reading, branch

; ---------------------------------------------------------------------------
; Breaking out for V-blank, during non-read
; ---------------------------------------------------------------------------

BreakPrep:
		ld	a,011000111b|BreakLate		; 07	; prepare "rst" instruction
		ld	(Int1_nop),a			; 13	; change instructions
		ld	(Int2_nop),a			; 13	; ''
		ld	(Int1_lda),a			; 13	; ''
		ld	(Int2_lda),a			; 13	; ''
		ld	(Int1_jp),a			; 13	; ''
		ld	(Int2_jp),a			; 13	; ''
		ld	(Int1_ldhl),a			; 13	; ''
		ld	(Int2_ldhl),a			; 13	; ''
		pop	af				; 10	; restore a register and flags
		ei					; 04	; enable interrupts
		reti					; 14	; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Breaking out for V-blank, during read of window or bank register
; ---------------------------------------------------------------------------

BreakDMA:
		jp	m,BreakBank			; 10	; if it's setting up a bank, branch

	; --- Finding out which registers we're dealing with ---

		ld	a,h				; 04	; load "h" to check which set of instructions we're dealing with
		zor	a				; 04	; is the hl pointer negative?
		jp	m,BDMA_ReadSet			; 10	; if so, then it's pointing to the window, and is the read set
			cp	PCM_Buffer1>>008h		; 07	; is the buffer address exchanged with de? (i.e. is hl at volume instead of buffer)
			jp	p,BDMA_NoExchange		; 10	; if not, branch
			ex	de,hl				; 04	; swap de/hl back to normal
			jp	BDMA_NoFixVolume		; 10	; jump to increment "l" and just finish (that's all it needs to do)
BDMA_NoExchange:	rra					; 04	; get buffer we're currently reading from
			xor	l				; 04	; xor with lower bit of address
			zand	001h				; 07	; get only the bit
			jp	nz,BDMA_NoFixFlush		; 10	; the lower bit of address will be in sync with the OUT buffer we're reading, they don't match, we're fine~
			ld	a,d				; 04	; load volume buffer upper address
			xor	l				; 04	; xor with lower bit of address
			zand	001h				; 07	; get only the bit
			jp	z,BDMA_NoFixVolume		; 10	; if the volume buffer is in sync, branch
			xor	d				; 04	; reverse the bit (change the buffer)
			ld	d,a				; 04	; ''
BDMA_NoFixVolume:	inc	l				; 04	; sync the address up
BDMA_NoFixFlush:	exx					; 04	; swap to the "read" set of exx registers
BDMA_ReadSet:

; ---------------------------------------------------------------------------
; Flush remaining data
; ---------------------------------------------------------------------------

BreakBank:
			exx					; 04	; switch registers
			ld	a,l				; 04	; get buffer position
			exx					; 04	; switch registers
		zneg	a				; 08	; reverse position
		zand	00Fh				; 07	; get remaining flushes to do...
		jp	nz,BDMA_NoMax			; 10	; if flushing has started, branch
		ld	a,010h				; 07	; set to maximum

BDMA_NoMax:
		inc	a				; 04	; increase by 1 (when dividing by 2, the bit is set for djnz)
		sra	a				; 08	; shift odd/even bit into carry
		ld	d,a				; 04	; copy to d (won't affect carry)
		jp	nc,BDMA_Flush01			; 10	; if carry was set originally, branch (is not carry only because of "inc a")

BDMA_Flush02:
			exx					; 04	; switch registers
			M_Flush02				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
		ld	b,00Ah				; 07	; delay...
		djnz	*				; 13 08	; '' (106)

BDMA_Flush01:
			exx					; 04	; switch registers
			M_Flush01				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
		ld	b,00Ah				; 07	; delay...
		djnz	*				; 13 08	; '' (106)
		dec	d				; 04	; decrease counter
		jp	nz,BDMA_Flush02			; 10	; if we're not finished, branch

; ---------------------------------------------------------------------------
; Wrapping OUT buffers
; ---------------------------------------------------------------------------

			exx					; 04	; switch registers
			dec	l				; 04	; check l...
			inc	l				; 04	; ''
			jp	nz,BDMA_NoWrap			; 10	; if it's not 0, branch
			inc	h				; 04	; advance OUT buffers
			bit	004h,h				; 08	; have the OUT buffer addresses reached 1000 (end of buffer) yet?
			jp	z,BDMA_NoWrap			; 10	; if not, branch
			ld	hl,PCM_Buffer2			; 10	; reset OUT buffers

BDMA_NoWrap:
			exx					; 04	; switch back

; ---------------------------------------------------------------------------
; Restore interrupt instructions
; ---------------------------------------------------------------------------

		ldin	y,a,h				; 08	; load restore mode
		zor	a				; 04	; has it been set?
		jp	z,BDMA_NoRestore		; 10	; if not, branch
		xor	a				; 04	; prepare "nop" instruction
		ldin	y,h,a				; 08	; clear restore mode
		ld	(Int1_nop),a			; 13	; change instructions
		ld	(Int2_nop),a			; 13	; ''
		ld	a,07Eh				; 07	; prepare "ld  sp" instruction
		ld	(Int1_lda),a			; 13	; change instructions
		ld	(Int2_lda),a			; 13	; ''
		ld	a,0C3h				; 07	; prepare "jp" instruction
		ld	(Int1_jp),a			; 13	; change instructions
		ld	(Int2_jp),a			; 13	; ''
		ld	a,077h				; 07	; prepare "ld  (hl),a" instruction
		ld	(Int1_ldhl),a			; 13	; change instrucitons
		ld	(Int2_ldhl),a			; 13	; ''

BDMA_NoRestore:

; ---------------------------------------------------------------------------
; YM2612 flushing
; ---------------------------------------------------------------------------

		ld	sp,YM_Buffer1			; 16	; load buffer 1 address
		ld	a,(YM_Buffer)			; 13	; load buffer we're writing to
		zor	a				; 04	; are we writing to buffer 1?
		jr	z,YMF_Buff1			; 12 07	; if so, branch
		ld	sp,YM_Buffer2			; 16	; load buffer 2 address

YMF_Buff1:
		ld	h,040h				; 07	; prepare YM2612 address
			exx					; 04	; switch registers back

YM_Flush:
			ldin	x,l,010h/002h			; 11	; set ix low byte to number of bytes to flush

YMF_NextByte:
			M_Flush02				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
		dec	sp				; 06	; move back (to get YM address)
		pop	af				; 10	; get YM address
		zor	a				; 04	; is this the end of the list?
		jp	m,YMF_Finish02			; 10	; if so, branch
		ld	l,a				; 04	; ''
		pop	de				; 10	; load address/data
		ld	(hl),d				; 07	; set address
		inc	l				; 04	; advance to data port
		ld	(hl),e				; 07	; set data
		ld	b,006h				; 07	; delay a little longer...
		djnz	*				; 13 08	; ''
		ld	l,b				; 04	; move address to 4000
		ld	(hl),02Ah			; 10	; reset YM2612 to DAC port address
			exx					; 04	; switch registers
			M_Flush01				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
		dec	sp				; 06	; move back (to get YM address)
		pop	af				; 10	; get YM address
		zor	a				; 04	; is this the end of the list?
		jp	m,YMF_Finish01			; 10	; if so, branch
		ld	l,a				; 04	; ''
		pop	de				; 10	; load address/data
		ld	(hl),d				; 07	; set address
		inc	l				; 04	; advance to data port
		ld	(hl),e				; 07	; set data
		ld	b,006h				; 07	; delay a little longer...
		djnz	*				; 13 08	; ''
		ld	l,b				; 04	; move address to 4000
		ld	(hl),02Ah			; 10	; reset YM2612 to DAC port address
			exx					; 04	; switch registers
			deci	x,l				; 08	; decrease ix low byte counter
			jp	nz,YMF_NextByte			; 10	; if it hasn't finished, branch

	; --- Advance/Wrap OUT buffers ---

			ld	a,l				; 04	; load lower byte
			zor	a				; 04	; has it wrapped to 0?
			jp	nz,YMF_NoAdvance		; 10	; if not, branch
			inc	h				; 04	; advance OUT buffers
			ld	a,h				; 04	; copy to a
			cp	010h				; 07	; has it reached 1000 address (end of buffer)?
			jp	nz,YMF_NoAdvance		; 10	; if not, branch
			ld	hl,PCM_Buffer2			; 10	; reset OUT buffers
			zor	h				; 04	; clear the Z flag (set non-zero)
YMF_NoAdvance:
			jp	YM_Flush			; 10	; loop back...

; ---------------------------------------------------------------------------
; Waiting for 68k...
; ---------------------------------------------------------------------------

PCM_Flush:
			ldin	x,l,010h/002h			; 11	; set ix low byte to number of bytes to flush

PCM_NextByte:
			M_Flush02				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
YMF_Finish02:	ld	b,009h				; 07	; delay a little longer...
		djnz	*				; 13 08	; ''
		ld	a,02Ah
		ld	(04000h),a
			exx					; 04	; switch registers
			M_Flush01				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
YMF_Finish01:	ld	b,008h				; 07	; delay a little longer...
		djnz	*				; 13 08	; ''
		ld	a,02Ah
		ld	(04000h),a
			exx					; 04	; switch registers
			deci	x,l				; 08	; decrease ix low byte counter
			jp	nz,PCM_NextByte			; 10	; if it hasn't finished, branch

	; --- Advance/Wrap OUT buffers ---

			ld	a,l				; 04	; load lower byte
			zor	a				; 04	; has it wrapped to 0?
			jp	nz,PCM_FlushSwitch		; 10	; if not, branch
			inc	h				; 04	; advance OUT buffers
			ld	a,h				; 04	; copy to a
			cp	010h				; 07	; has it reached 1000 address (end of buffer)?
			jp	nz,PCM_FlushSwitch		; 10	; if not, branch
			ld	hl,PCM_Buffer2			; 10	; reset OUT buffers
			zor	h				; 04	; clear the Z flag (set non-zero)
PCM_FlushSwitch:	jp	z,PCM_Flush			; 12 07	; can be chaned to "jr  nz" by the 68k
		exx					; 04	; switch registers down again...

		ld	hl,YM_Buffer1			; 16	; load buffer 1 address
		ld	a,(YM_Buffer)			; 13	; load buffer we're writing to
		zor	a				; 04	; are we writing to buffer 1?
		jr	z,YMF_SetBuff1			; 12 07	; if so, branch
		ld	hl,YM_Buffer2			; 16	; load buffer 2 address

YMF_SetBuff1:
		ld	(hl),0FFh			; 10	; set end marker at beginning of list

		ld	sp,Z80_Stack			; 10	; set valid stack address
		ld	iy,00000h			; 14	; reset interrupt status
Z80_Int1:	ei					; 04	; enabled interrupts
		jp	CU_Flush			; 10	; continue to flush routine

; ===========================================================================
; ---------------------------------------------------------------------------
; TEMPORARY...  ALIGNING FOR BANK SWITCH TABLES
; ---------------------------------------------------------------------------

	;	align	0100h

; ===========================================================================
; ---------------------------------------------------------------------------
; Setup/Init
; ---------------------------------------------------------------------------

Z80_Init:
			ld	sp,Z80_Stack			; 10	; set stack address

	; --- YM2612 DAC Setup ---

			ld	a,02Bh				; 07	; set YM2612 address to DAC switch
			ld	(04000h),a			; 13	; ''
			ld	a,080h				; 07	; turn DAC on/FM6 off
			ld	(04001h),a			; 13	; ''
			ld	a,02Ah				; 07	; set YM2612 address to DAC port
			ld	(04000h),a			; 13	; ''

	; --- Setting up channels to be mute ---

			ld	hl,(MuteSample)			; 16	; load sample address to current address
			ld	a,(MuteSample+002h)		; 13	; load bank address to current address
			ld	(PCM1_SampCur+001h),hl		; 16	; Setting current address
			ld	(PCM2_SampCur+001h),hl		; 16	; ''
			ld	(PCM1_BankCur),a		; 13	; Setting current bank
			ld	(PCM2_BankCur),a		; 13	; ''

			ld	de,PCM1_Sample			; 10	; load request list
			ld	bc,00006h			; 10	; set size to copy
			ld	hl,MuteSample			; 10	; load mute sample address
			ldir					; 21 16	; copy mute sample data over...
			ld	c,006h				; 07	; set size to copy
			ld	hl,MuteSample			; 10	; load mute sample address
			ldir					; 21 16	; copy mute sample data over...
			ld	c,006h				; 07	; set size to copy
			ld	hl,MuteSample			; 10	; load mute sample address
			ldir					; 21 16	; copy mute sample data over...
			ld	c,006h				; 07	; set size to copy
			ld	hl,MuteSample			; 10	; load mute sample address
			ldir					; 21 16	; copy mute sample data over...

	; --- Setting up PCM 1 switch ---

			ld	a,(PCM1_BankCur)		; 13	; load bank ID
			ld	de,PCM1_Switch			; 10	; load PCM switch list to edit
			call	SetBank				; 17	; set bank address

	; --- Setting up PCM 2 switch ---

			ld	a,(PCM2_BankCur)		; 13	; load bank ID
			ld	de,PCM2_Switch			; 10	; load PCM switch list to edit
			call	SetBank				; 17	; set bank address

	; --- Final register setup ---

			ld	bc,04001h			; 10	; prepare YM2612 port address
			ld	d,(PCM_Volume2>>008h)&0FFh	; 07	; prepare volume list address (upper byte only)
			ld	hl,PCM_Buffer2			; 10	; prepare OUT buffer 2

			ld	iy,00000h			; 14	; reset interrupt status
			ei					; 04	; enable VDP interruption

			exx					; 04	; switch registers

	ld	a,011010010b
	ld	(PCM_ChangeVolume),a
	ld	a,0C0h
	ld	(PCM1_Volume+001h),a
	ld	(PCM2_Volume+001h),a

; ===========================================================================
; ---------------------------------------------------------------------------
; The catch up loop
; ---------------------------------------------------------------------------

CatchUp:
			exx					; 04	; switch registers

CatchUp_Exx:
			M_Flush02				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers

Z80_Int2:	ei

; ---------------------------------------------------------------------------
; PCM 1
; ---------------------------------------------------------------------------

PCM1_MuteRet:
		ld	hl,06001h			; 10	; load bank switch register port
		deci	y,l				; 08	; set bank interrupt
Int1_nop:	znop					; 04	; CANNOT CHANGE "ld  (hl),h" since it's altered by Z80 elsewhere
PCM1_Switch:	ld	(hl),h				; 07	; 0000 0000 1  32KB -  64KB (  8000 -   10000)
		ld	(hl),h				; 07	; 0000 0001 0  64KB - 128KB ( 10000 -   20000)
		ld	(hl),h				; 07	; 0000 0010 0 128KB - 256KB ( 20000 -   40000)
		ld	(hl),h				; 07	; 0000 0100 0 256KB - 512KB ( 40000 -   80000)
		ld	(hl),h				; 07	; 0000 1000 0 512KB -   1MB ( 80000 -  100000)
		ld	(hl),h				; 07	; 0001 0000 0   1MB -   2MB (100000 -  200000)
		ld	(hl),h				; 07	; 0010 0000 0   2MB -   4MB (200000 -  400000)
		ld	(hl),h				; 07	; 0100 0000 0   4MB -   8MB (400000 -  800000)
		ld	(hl),h				; 07	; 1000 0000 0   8MB -  16MB (800000 - 1000000)
		inci	y,l				; 08	; set non-read interrupt
			exx					; 04	; switch registers
			M_Flush01				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
PCM1_OverflwCur:ld	bc,00018h			; 10	; prepare amount to get to end of window
		ld	hl,(PCM1_SampCur+001h)		; 16	; load sample current address
		zor	a				; 04	; clear carry
		adc	hl,bc				; 15	; advance address
		jp	p,PCM1_PrepReset		; 10	; if the address has gone outside the window, branch
		inci	y,l				; 08	; set window interrupt
Int1_lda:	ld	a,(hl)				; 07	; load PCM byte at the next ending address
		zor	a				; 04	; is it an end marker? (00)
		jp	z,PCM1_Mute			; 10	; if so, branch to mute...

PCM1_PrepRet:

PCM1_SampCur:	ld	hl,08000h			; 10	; load PCM sample address
PCM1_Buffer:	ld	de,PCM_Buffer1			; 10	; load IN buffer address
PCM1_PitchQuo:	ld	sp,00000h			; 10	; load pitch quotient
PCM1_PitchDiv:	ld	bc,000FFh			; 10	; load pitch dividend (and counter for ldi)
PCM1_PitchCur:	ld	a,000h				; 07	; load current pitch dividend

PCM1_PreInst01:	M_Read
PCM1_PreInst02:	M_Read
PCM1_PreInst03:	M_Read
			exx					; 04	; switch registers
			ex	af,af				; 04	; store dividend
			M_Flush02				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
			ex	af,af				; 04	; restore dividend
PCM1_PreInst04:	M_Read
PCM1_PreInst05:	M_Read
PCM1_PreInst06:	M_Read
PCM1_PreInst07:	M_Read
			exx					; 04	; switch registers
			ex	af,af				; 04	; store dividend
			M_Flush01				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
			ex	af,af				; 04	; restore dividend
PCM1_PreInst08:	M_Read
PCM1_PreInst09:	M_Read
PCM1_PreInst0A:	M_Read
			exx					; 04	; switch registers
			ex	af,af				; 04	; store dividend
			M_Flush02				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
			ex	af,af				; 04	; restore dividend
PCM1_PreInst0B:	M_Read
PCM1_PreInst0C:	M_Read
PCM1_PreInst0D:	M_Read
PCM1_PreInst0E:	M_Read
			exx					; 04	; switch registers
			ex	af,af				; 04	; store dividend
			M_Flush01				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
			ex	af,af				; 04	; restore dividend
PCM1_PreInst0F:	M_Read
PCM1_PreInst10:	M_Read
PCM1_PreInst11:	M_Read
			exx					; 04	; switch registers
			ex	af,af				; 04	; store dividend
			M_Flush02				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
			ex	af,af				; 04	; restore dividend
PCM1_PreInst12:	M_Read
PCM1_PreInst13:	M_Read
PCM1_PreInst14:	M_Read
PCM1_PreInst15:	M_Read
			exx					; 04	; switch registers
			ex	af,af				; 04	; store dividend
			M_Flush01				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
			ex	af,af				; 04	; restore dividend
PCM1_PreInst16:	M_Read
PCM1_PreInst17:	M_Read
PCM1_PreInst18:	M_Read
		ld	sp,Z80_Stack			; 10	; set valid stack
		deci	y,l				; 08	; set non-read interrupt
		ld	(UPD1_Buffer+001h),de		; 20	; update IN buffer address
		ld	(UPD1_SampCur+001h),hl		; 16	; update sample address
		ld	(UPD1_PitchCur+001h),a		; 13	; update pitch fraction

; ---------------------------------------------------------------------------
; PCM 2
; ---------------------------------------------------------------------------

PCM2_MuteRet:
		ld	hl,06001h			; 10	; load bank switch register port
		deci	y,l				; 08	; set bank interrupt
Int2_nop:	znop					; 04	; CANNOT CHANGE "ld  (hl),h" since it's altered by Z80 elsewhere
PCM2_Switch:	ld	(hl),h				; 07	; 0000 0000 1  32KB -  64KB (  8000 -   10000)
		ld	(hl),h				; 07	; 0000 0001 0  64KB - 128KB ( 10000 -   20000)
		ld	(hl),h				; 07	; 0000 0010 0 128KB - 256KB ( 20000 -   40000)
		ld	(hl),h				; 07	; 0000 0100 0 256KB - 512KB ( 40000 -   80000)
		ld	(hl),h				; 07	; 0000 1000 0 512KB -   1MB ( 80000 -  100000)
		ld	(hl),h				; 07	; 0001 0000 0   1MB -   2MB (100000 -  200000)
		ld	(hl),h				; 07	; 0010 0000 0   2MB -   4MB (200000 -  400000)
		ld	(hl),h				; 07	; 0100 0000 0   4MB -   8MB (400000 -  800000)
		ld	(hl),h				; 07	; 1000 0000 0   8MB -  16MB (800000 - 1000000)
		inci	y,l				; 08	; set non-read interrupt
			exx					; 04	; switch registers
			M_Flush02				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
PCM2_OverflwCur:ld	bc,00018h			; 10	; prepare amount to get to end of window
		ld	hl,(PCM2_SampCur+001h)		; 16	; load sample current address
		zor	a				; 04	; clear carry
		adc	hl,bc				; 15	; advance address
		jp	p,PCM2_PrepReset		; 10	; if the address has gone outside the window, branch
		inci	y,l				; 08	; set window interrupt
Int2_lda:	ld	a,(hl)				; 07	; load PCM byte at the next ending address
		zor	a				; 04	; is it an end marker? (00)
		jp	z,PCM2_Mute			; 10	; if so, branch to mute...

PCM2_PrepRet:

PCM2_SampCur:	ld	hl,08000h			; 10	; load PCM sample address
PCM2_Buffer:	ld	de,PCM_Buffer2			; 10	; load IN buffer address
PCM2_PitchQuo:	ld	sp,00000h			; 10	; load pitch quotient
PCM2_PitchDiv:	ld	bc,000FFh			; 10	; load pitch dividend (and counter for ldi)
PCM2_PitchCur:	ld	a,000h				; 07	; load current pitch dividend

PCM2_PreInst01:	M_Read
PCM2_PreInst02:	M_Read
PCM2_PreInst03:	M_Read
			exx					; 04	; switch registers
			ex	af,af				; 04	; store dividend
			M_Flush01				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
			ex	af,af				; 04	; restore dividend
PCM2_PreInst04:	M_Read
PCM2_PreInst05:	M_Read
PCM2_PreInst06:	M_Read
PCM2_PreInst07:	M_Read
			exx					; 04	; switch registers
			ex	af,af				; 04	; store dividend
			M_Flush02				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
			ex	af,af				; 04	; restore dividend
PCM2_PreInst08:	M_Read
PCM2_PreInst09:	M_Read
PCM2_PreInst0A:	M_Read
			exx					; 04	; switch registers
			ex	af,af				; 04	; store dividend
			M_Flush01				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
			ex	af,af				; 04	; restore dividend
PCM2_PreInst0B:	M_Read
PCM2_PreInst0C:	M_Read
PCM2_PreInst0D:	M_Read
PCM2_PreInst0E:	M_Read
			exx					; 04	; switch registers
			ex	af,af				; 04	; store dividend
			M_Flush02				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
			ex	af,af				; 04	; restore dividend
PCM2_PreInst0F:	M_Read
PCM2_PreInst10:	M_Read
PCM2_PreInst11:	M_Read
			exx					; 04	; switch registers
			ex	af,af				; 04	; store dividend
			M_Flush01				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
			ex	af,af				; 04	; restore dividend
PCM2_PreInst12:	M_Read
PCM2_PreInst13:	M_Read
PCM2_PreInst14:	M_Read
PCM2_PreInst15:	M_Read
			exx					; 04	; switch registers
			ex	af,af				; 04	; store dividend
			M_Flush02				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
			ex	af,af				; 04	; restore dividend
PCM2_PreInst16:	M_Read
PCM2_PreInst17:	M_Read
PCM2_PreInst18:	M_Read
		ld	sp,Z80_Stack			; 10	; set valid stack
		deci	y,l				; 08	; set non-read interrupt
		ld	(PCM2_Buffer+001h),de		; 20	; update IN buffer address
		ld	(PCM2_SampCur+001h),hl		; 16	; update sample address
		ld	(PCM2_PitchCur+001h),a		; 13	; update pitch fraction

UPD1_Buffer:	ld	hl,PCM_Buffer1			; 10	; update IN buffer address
		ld	(PCM1_Buffer+001h),hl		; 16	; ''
UPD1_SampCur:	ld	hl,08000h			; 10	; update sample address
		ld	(PCM1_SampCur+001h),hl		; 16	; ''
UPD1_PitchCur:	ld	a,000h				; 07	; update pitch fraction
		ld	(PCM1_PitchCur+001h),a		; 13	; ''

; ---------------------------------------------------------------------------
; Wrapping OUT buffers
; ---------------------------------------------------------------------------

			exx					; 04	; switch registers
			M_Flush01				; 59	; flush a byte to the YM2612
			jp	nz,CU_NoWrap			; 10	; if l is not 0, branch
			inc	h				; 04	; advance OUT buffers
			bit	004h,h				; 08	; have the OUT buffer addresses reached 1000 (end of buffer) yet?
			jp	z,CU_NoWrap			; 10	; if not, branch
			ld	hl,PCM_Buffer2			; 10	; reset OUT buffers

CU_NoWrap:
			exx					; 04	; switch back

; ---------------------------------------------------------------------------
; Wrap IN buffers
; ---------------------------------------------------------------------------

		bit	001h,d				; 08	; have the IN buffer addresses reached the end yet?
		jp	nz,PCM_BuffNoReset		; 10	; if not, branch
		ld	hl,PCM_Buffer1			; 10	; reset IN buffer
		ld	(PCM1_Buffer+001h),hl		; 16	; ''
		ld	de,PCM_Buffer2			; 10	; reset IN buffer
		ld	(PCM2_Buffer+001h),de		; 20	; ''

PCM_BuffNoReset:

; ---------------------------------------------------------------------------
; Rebank...
; ---------------------------------------------------------------------------

		scf					; 04	; set carry flag
PCM1_ChangeBank:jp	c,PCM1_IgnoreBank		; 10	; if the bank list doesn't need changing, branch
		ld	a,011011010b			; 07	; clear request flag
		ld	(PCM1_ChangeBank),a		; 13	; ''
		ld	hl,PCM1_BankCur			; 10	; address of bank ID
		ld	de,PCM1_Switch			; 10	; load PCM switch list to edit
		ld	a,(PCM1_PitchQuo+001h)		; 13	; load pitch quotient
		call	SwitchBank			; 17	; change the bank address
		scf					; 04	; set carry flag

PCM1_IgnoreBank:
PCM2_ChangeBank:jp	c,PCM2_IgnoreBank		; 10	; if the bank list doesn't need changing, branch
		ld	a,011011010b			; 07	; clear request flag
		ld	(PCM2_ChangeBank),a		; 13	; ''
		ld	hl,PCM2_BankCur			; 10	; address of bank ID
		ld	de,PCM2_Switch			; 10	; load PCM switch list to edit
		ld	a,(PCM2_PitchQuo+001h)		; 13	; load pitch quotient
		call	SwitchBank			; 17	; change the bank address
		scf					; 04	; set carry flag

PCM2_IgnoreBank:

; ---------------------------------------------------------------------------
; Pitch control
; ---------------------------------------------------------------------------

PCM_ChangePitch:jp	c,PCM_IgnorePitch		; 10	; if the 68k hasn't requested pitch change, branch
		ld	a,011011010b			; 07	; clear request flag
		ld	(PCM_ChangePitch),a		; 13	; ''
PCM1_RateQuo:	ld	hl,00000h			; 10	; load pitch quotient from 68k to Z80
		ld	(PCM1_PitchQuo+001h),hl		; 16	; ''
PCM2_RateQuo:	ld	hl,00000h			; 10	; load pitch quotient from 68k to Z80
		ld	(PCM2_PitchQuo+001h),hl		; 16	; ''
PCM1_RateDiv:	ld	a,000h				; 07	; load pitch dividend from 68k to Z80
		ld	(PCM1_PitchDiv+002h),a		; 13	; ''
PCM2_RateDiv:	ld	a,000h				; 07	; load pitch dividend from 68k to Z80
		ld	(PCM2_PitchDiv+002h),a		; 13	; ''
PCM1_Overflow:	ld	hl,00018h			; 10	; load amount to get to end of window
		ld	(PCM1_OverflwCur+001h),hl	; 16	; ''
PCM2_Overflow:	ld	hl,00018h			; 10	; load amount to get to end of window
		ld	(PCM2_OverflwCur+001h),hl	; 16	; ''ch dividend from 68k to Z80
		scf					; 04	; set carry flag

PCM_IgnorePitch:

; ---------------------------------------------------------------------------
; Updating Volume
; ---------------------------------------------------------------------------

PCM_ChangeVolume:jp	c,PCM_IgnoreVolume		; 10	; if the 68k hasn't requested volume change, branch
		ld	a,011011010b			; 07	; clear request flag
		ld	(PCM_ChangeVolume),a		; 13	; ''
		push	de				; 10	; store IN buffer
PCM1_Volume:	ld	a,000h				; 07	; load current volume
PCM1_VolumeCur:	cp	000h				; 07	; has it changed?
		jp	z,PCM1_NoVolume			; 10	; if not, branch
		ld	(PCM1_VolumeCur+001h),a		; 13	; update volume
		ld	de,PCM_Volume1			; 10	; load volume table to edit
		ld	hl,PCM1_NoVolume		; 10	; get return address
		ld	(SV_Return+001h),hl		; 16	; set it ready for return
		jp	SwitchVolume			; 10	; run routine
PCM1_NoVolume:

PCM2_Volume:	ld	a,000h				; 07	; load current volume
PCM2_VolumeCur:	cp	000h				; 07	; has it changed?
		jp	z,PCM2_NoVolume			; 10	; if not, branch
		ld	(PCM2_VolumeCur+001h),a		; 13	; update volume
		ld	de,PCM_Volume2			; 10	; load volume table to edit
		ld	hl,PCM2_NoVolume		; 10	; get return address
		ld	(SV_Return+001h),hl		; 16	; set it ready for return
		jp	SwitchVolume			; 10	; run routine
PCM2_NoVolume:
		pop	de				; 11	; restore IN buffer

PCM_IgnoreVolume:

; ---------------------------------------------------------------------------
; Checking for "Flush" mode
; ---------------------------------------------------------------------------

		exx					; 04	; switch registers
			ld	a,h				; 04	; load upper address
			rra					; 04	; get upper bit only into carry
			ld	a,l				; 04	; load lower address
			rra					; 04	; shift address down with carry
		exx					; 04	; switch registers
		srl	d				; 08	; get upper bit only into carry
		rr	e				; 08	; shift address down with carry
		zsub	e				; 04	; get distance between in and out buffers
		jp	c,CU_ValidDist			; 10	; if the OUT buffer hasn't caught up with the IN buffer, branch
		zadd	a,((00200h-00020h)>>001h)&0FFh	; 07	; check distance
		jp	c,CatchUp			; 10	; if the OUT buffer hasn't caught up with the IN buffer, branch
		jp	CU_Flush			; 10	; continue to flush routine

CU_ValidDist:
		zadd	a,(-00020h>>001h)&0FFh		; 07	; check distance
		jp	c,CatchUp			; 10	; if the OUT buffer hasn't caught up with the IN buffer, branch

; ---------------------------------------------------------------------------
; New sample playback
; ---------------------------------------------------------------------------

CU_Flush:
		scf					; 04	; set carry flag
PCM1_NewRET:	jp	nc,PCM1_NewSample		; 10	; can be changed to "jp  c" by the 68k
PCM2_NewRET:	jp	nc,PCM2_NewSample		; 10	; can be changed to "jp  c" by the 68k

; ---------------------------------------------------------------------------
; Main "Flush" loop
; ---------------------------------------------------------------------------

			exx					; 04	; switch registers back
			ldin	x,l,010h/002h			; 11	; set ix low byte to number of bytes to flush

FL_NextByte:
			M_Flush02				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
		ld	b,00Ch
		djnz	*
			exx					; 04	; switch registers
			M_Flush01				; 59	; flush a byte to the YM2612
			exx					; 04	; switch registers
		ld	b,00Bh
		djnz	*
			exx					; 04	; switch registers
			deci	x,l				; 08	; decrease ix low byte counter
			jp	nz,FL_NextByte			; 10	; if it hasn't finished, branch

	; --- Advance/Wrap OUT buffers ---

			ld	a,l				; 04	; load lower byte
			zor	a				; 04	; has it wrapped to 0?
			jp	nz,FL_NoAdvance			; 10	; if not, branch
			inc	h				; 04	; advance OUT buffers
			ld	a,h				; 04	; copy to a
			cp	010h				; 07	; has it reached 1000 address (end of buffer)?
			jp	nz,FL_NoAdvance			; 10	; if not, branch
			ld	hl,PCM_Buffer2			; 10	; reset OUT buffers
			zor	h				; 04	; clear the Z flag (set non-zero)
FL_NoAdvance:		jp	CatchUp_Exx			; 10	; jump back to the catch up loop

; ===========================================================================
; ---------------------------------------------------------------------------
; When PCM sample 1 has reached an end marker & needs to loop back
; ---------------------------------------------------------------------------

PCM1_Mute:
		deci	y,l				; 08	; set non-read interrupt
		ld	a,(PCM1_PitchQuo+001h)		; 13	; load quotient
		inc	a				; 04	; increase by 1 (because FF00 is stopped), is it playing normally?
		jp	p,PCM1_Normal			; 10	; if so, branch
		ld	hl,(PCM1_SampleNext_Rev)	; 16	; load next sample address
		ld	a,(PCM1_BankNext_Rev)		; 13	; load next bank address
		jp	PCM1_Reverse			; 10	; continue

PCM1_Normal:
		ld	hl,(PCM1_SampleNext)		; 16	; load next sample address
		ld	a,(PCM1_BankNext)		; 13	; load next bank address

PCM1_Reverse:
		ld	(PCM1_SampCur+001h),hl		; 16	; set sample address
		ld	(PCM1_BankCur),a		; 13	; set bank address
		ld	de,PCM1_Switch			; 10	; load PCM switch list to edit
		call	SetBank				; 17	; set bank address
		xor	a				; 04	; clear the pitch current position
		ld	(PCM1_PitchCur+001h),a		; 13	; ''
			exx					; 04	; switch registers
			M_Revert01				; 59	; move pointer back
			exx					; 04	; switch registers
		jp	PCM1_MuteRet			; 10	; return

; ===========================================================================
; ---------------------------------------------------------------------------
; When PCM sample 1 address has reached the end of a window, just to play the last bit
; ---------------------------------------------------------------------------

PCM1_PrepReset:
		ld	hl,(PCM1_SampCur+001h)		; 16	; reload sample current position
		ld	bc,(PCM1_PitchDiv+001h)		; 20	; load pitch fraction (sets C to FF too..)
		ld	a,(PCM1_PitchCur+001h)		; 13	; load pitch current
		ld	de,(PCM1_PitchQuo+001h)		; 20	; load pitch quotient
		inc	de				; 06	; increase by 1 (no LDI to increment HL by 1)

PCM1_PrepCount:
		inc	c				; 04	; increase byte read counter
		zadd	a,b				; 04	; add fraction
		adc	hl,de				; 15	; add quotient
		jp	m,PCM1_PrepCount		; 10	; if we're still in the window space, branch
		ld	a,c				; 04	; copy counter to a
		zadd	a,a				; 04	; multiply by 2
		zadd	a,PCM1_PrepTable&0FFh		; 07	; advance to beginning of table
		ld	(PCM1_PrepLoc+001h),a		; 13	; save to table pointer
PCM1_PrepLoc:	ld	hl,(PCM1_PrepTable)		; 10	; load correct LDI instruction to change
		ld	(PCM1_ResInst+001h),hl		; 16	; store instruction address for later
		ld	(PCM1_ResJump+001h),hl		; 16	; ''
		ld	(hl),011000111b|PCM1_ResetJmp	; 10	; change LDI to "rst 28h"
		ld	h,080h				; 07	; set h to negative address (for V-blank)
		inci	y,l				; 08	; set window interrupt
Int1_jp:	jp	PCM1_PrepRet			; 10	; return

; ===========================================================================
; ---------------------------------------------------------------------------
; When PCM sample 1 address has gone outside the window, and needs to reset
; ---------------------------------------------------------------------------

PCM1_Reset:
		inc	sp				; 06	; restore sp back to the pitch it was at
		inc	sp				; 06	; ''
		ld	(PCM1_ResQuo+001h),sp		; 20	; store the stack (before changing it to +1 for the "ldi")
		inc	sp				; 06	; increase by 1 for "ldi" instruction
		zadd	a,b				; 04	; add dividend
		adc	hl,sp				; 15	; add quotient (spill it over out of window)
		zset	007h,h				; 08	; wrap back into window

		ld	(PCM1_ResSamp+001h),hl		; 16	; store registers
		ld	(PCM1_ResDiv+001h),bc		; 20	; ''
		ld	(PCM1_ResBuff+001h),de		; 20	; ''
		ld	(PCM1_ResPitCur+001h),a		; 13	; ''

		ld	sp,Z80_Stack			; 10	; set valid stack

		deci	y,l				; 08	; set non-read interrupt

		ld	a,011010010b			; 07	; set bank change request flag
		ld	(PCM1_ChangeBank),a		; 13	; ''

		ld	hl,PCM1_BankCur			; 10	; address of bank ID
		ld	a,(PCM1_PitchQuo+001h)		; 13	; load pitch quotient
		inc	a				; 04	; increase pitch quotient by 1 (because FF00 is "stopped")
		zadd	a,a				; 04	; shift MSB into carry
		sbc	a,a				; 04	; convert to FF (if it was below FF00), else make it 00
		sbc	a,0FFh				; 07	; convert to FF (if it was below FF00), else make it 01
		zadd	a,(hl)				; 07	; increment/decrement the bank address

		ld	hl,06001h			; 10	; load bank switch register port
		deci	y,l				; 08	; set bank interrupt
Int1_ldhl:	ld	(hl),a				; 07	; 0000 0000 1  32KB -  64KB (  8000 -   10000)
		rrca					; 04
		ld	(hl),a				; 07	; 0000 0001 0  64KB - 128KB ( 10000 -   20000)
		rrca					; 04
		ld	(hl),a				; 07	; 0000 0010 0 128KB - 256KB ( 20000 -   40000)
		rrca					; 04
		ld	(hl),a				; 07	; 0000 0100 0 256KB - 512KB ( 40000 -   80000)
		rrca					; 04
		ld	(hl),a				; 07	; 0000 1000 0 512KB -   1MB ( 80000 -  100000)
		rrca					; 04
		ld	(hl),a				; 07	; 0001 0000 0   1MB -   2MB (100000 -  200000)
		rrca					; 04
		ld	(hl),a				; 07	; 0010 0000 0   2MB -   4MB (200000 -  400000)
		rrca					; 04
		ld	(hl),a				; 07	; 0100 0000 0   4MB -   8MB (400000 -  800000)
		ld	(hl),h	; clear			; 07	; 1000 0000 0   8MB -  16MB (800000 - 1000000)

		inci	y,l				; 08	; set non-read interrupt

PCM1_ResInst:	ld	hl,00000h			; 10	; load instruction address to change back to "LDI"
		ld	(hl),0EDh			; 10	; change to LDI again

PCM1_ResSamp:	ld	hl,00000h			; 10	; restore registers
PCM1_ResBuff:	ld	de,00000h			; 10	; ''
PCM1_ResQuo:	ld	sp,00000h			; 10	; ''
PCM1_ResDiv:	ld	bc,00000h			; 10	; ''
PCM1_ResPitCur:	ld	a,000h				; 07	; ''
		inci	y,l				; 08	; set window interrupt

PCM1_ResJump:	jp	00000h				; 10	; jump back to correct LDI instruction

; ===========================================================================
; ---------------------------------------------------------------------------
; 68K SET - routine to load a new sample 1
; ---------------------------------------------------------------------------

PCM1_NewSample:
		ld	a,(PCM1_PitchQuo+001h)		; 13	; load quotient
		inc	a				; 04	; increase by 1 (because FF00 is stopped), is it playing normally?
		jp	p,PCM1_NewNormal		; 10	; if so, branch
		ld	hl,(PCM1_Sample_Rev)		; 16	; load sample address (reversed)
		ld	a,(PCM1_Bank_Rev)		; 13	; load bank address (reversed)
		jp	PCM1_NewReverse			; 10	; continue to save reversed samples

PCM1_NewNormal:
		ld	hl,(PCM1_Sample)		; 16	; load sample address
		ld	a,(PCM1_Bank)			; 13	; load bank address

PCM1_NewReverse:
		ld	(PCM1_SampCur+001h),hl		; 16	; save as current address (68k to z80)
		ld	(PCM1_BankCur),a		; 13	; save as current bank (68k to z80)
		ld	de,PCM1_Switch			; 10	; load PCM switch list to edit
		call	SetBank				; 17	; set bank address
		xor	a				; 04	; clear the pitch current position
		ld	(PCM1_PitchCur+001h),a		; 13	; ''
		ld	hl,PCM1_NewRET			; 10	; load return address
		ld	(hl),011010010b			; 10	; change instruction back to "JP NC"
		scf					; 04	; set C flag (for "JP NC" instruction)
		jp	(hl)				; 04	; return to address

; ===========================================================================
; ---------------------------------------------------------------------------
; When PCM sample 2 has reached an end marker & needs to loop back
; ---------------------------------------------------------------------------

PCM2_Mute:
		deci	y,l				; 08	; set non-read interrupt
		ld	a,(PCM2_PitchQuo+001h)		; 13	; load quotient
		inc	a				; 04	; increase by 1 (because FF00 is stopped), is it playing normally?
		jp	p,PCM2_Normal			; 10	; if so, branch
		ld	hl,(PCM2_SampleNext_Rev)	; 16	; load next sample address
		ld	a,(PCM2_BankNext_Rev)		; 13	; load next bank address
		jp	PCM2_Reverse			; 10	; continue

PCM2_Normal:
		ld	hl,(PCM2_SampleNext)		; 16	; load next sample address
		ld	a,(PCM2_BankNext)		; 13	; load next bank address

PCM2_Reverse:
		ld	(PCM2_SampCur+001h),hl		; 16	; set sample address
		ld	(PCM2_BankCur),a		; 13	; set bank address
		ld	de,PCM2_Switch			; 10	; load PCM switch list to edit
		call	SetBank				; 17	; set bank address
		xor	a				; 04	; clear the pitch current position
		ld	(PCM2_PitchCur+001h),a		; 13	; ''
			exx					; 04	; switch registers
			M_Revert02				; 59	; move pointer back
			exx					; 04	; switch registers
		jp	PCM2_MuteRet			; 10	; return

; ===========================================================================
; ---------------------------------------------------------------------------
; When PCM sample 2 address has reached the end of a window, just to play the last bit
; ---------------------------------------------------------------------------

PCM2_PrepReset:
		ld	hl,(PCM2_SampCur+001h)		; 16	; reload sample current position
		ld	bc,(PCM2_PitchDiv+001h)		; 20	; load pitch fraction (sets C to FF too..)
		ld	a,(PCM2_PitchCur+001h)		; 13	; load pitch current
		ld	de,(PCM2_PitchQuo+001h)		; 20	; load pitch quotient
		inc	de				; 06	; increase by 1 (no LDI to increment HL by 1)

PCM2_PrepCount:
		inc	c				; 04	; increase byte read counter
		zadd	a,b				; 04	; add fraction
		adc	hl,de				; 15	; add quotient
		jp	m,PCM2_PrepCount		; 10	; if we're still in the window space, branch
		ld	a,c				; 04	; copy counter to a
		zadd	a,a				; 04	; multiply by 2
		zadd	a,PCM2_PrepTable&0FFh		; 07	; advance to beginning of table
		ld	(PCM2_PrepLoc+001h),a		; 13	; save to table pointer
PCM2_PrepLoc:	ld	hl,(PCM2_PrepTable)		; 10	; load correct LDI instruction to change
		ld	(PCM2_ResInst+001h),hl		; 16	; store instruction address for later
		ld	(PCM2_ResJump+001h),hl		; 16	; ''
		ld	(hl),011000111b|PCM2_ResetJmp	; 10	; change LDI to "rst 30h"
		ld	h,080h				; 07	; set h to negative address (for V-blank)
		inci	y,l				; 08	; set window interrupt
Int2_jp:	jp	PCM2_PrepRet			; 10	; return

; ===========================================================================
; ---------------------------------------------------------------------------
; When PCM sample 2 address has gone outside the window, and needs to reset
; ---------------------------------------------------------------------------

PCM2_Reset:
		inc	sp				; 06	; restore sp back to the pitch it was at
		inc	sp				; 06	; ''
		ld	(PCM2_ResQuo+001h),sp		; 20	; store the stack (before changing it to +1 for the "ldi")
		inc	sp				; 06	; increase by 1 for "ldi" instruction
		zadd	a,b				; 04	; add dividend
		adc	hl,sp				; 15	; add quotient (spill it over out of window)
		zset	007h,h				; 08	; wrap back into window

		ld	(PCM2_ResSamp+001h),hl		; 16	; store registers
		ld	(PCM2_ResDiv+001h),bc		; 20	; ''
		ld	(PCM2_ResBuff+001h),de		; 20	; ''
		ld	(PCM2_ResPitCur+001h),a		; 13	; ''

		ld	sp,Z80_Stack			; 10	; set valid stack

		deci	y,l				; 08	; set non-read interrupt

		ld	a,011010010b			; 07	; set bank change request flag
		ld	(PCM2_ChangeBank),a		; 13	; ''

		ld	hl,PCM2_BankCur			; 10	; address of bank ID
		ld	a,(PCM2_PitchQuo+001h)		; 13	; load pitch quotient
		inc	a				; 04	; increase pitch quotient by 1 (because FF00 is "stopped")
		zadd	a,a				; 04	; shift MSB into carry
		sbc	a,a				; 04	; convert to FF (if it was below FF00), else make it 00
		sbc	a,0FFh				; 07	; convert to FF (if it was below FF00), else make it 01
		zadd	a,(hl)				; 07	; increment/decrement the bank address

		ld	hl,06001h			; 10	; load bank switch register port
		deci	y,l				; 08	; set bank interrupt
Int2_ldhl:	ld	(hl),a				; 07	; 0000 0000 1  32KB -  64KB (  8000 -   10000)
		rrca					; 04
		ld	(hl),a				; 07	; 0000 0001 0  64KB - 128KB ( 10000 -   20000)
		rrca					; 04
		ld	(hl),a				; 07	; 0000 0010 0 128KB - 256KB ( 20000 -   40000)
		rrca					; 04
		ld	(hl),a				; 07	; 0000 0100 0 256KB - 512KB ( 40000 -   80000)
		rrca					; 04
		ld	(hl),a				; 07	; 0000 1000 0 512KB -   1MB ( 80000 -  100000)
		rrca					; 04
		ld	(hl),a				; 07	; 0001 0000 0   1MB -   2MB (100000 -  200000)
		rrca					; 04
		ld	(hl),a				; 07	; 0010 0000 0   2MB -   4MB (200000 -  400000)
		rrca					; 04
		ld	(hl),a				; 07	; 0100 0000 0   4MB -   8MB (400000 -  800000)
		ld	(hl),h	; clear			; 07	; 1000 0000 0   8MB -  16MB (800000 - 1000000)

		inci	y,l				; 08	; set non-read interrupt

PCM2_ResInst:	ld	hl,00000h			; 10	; load instruction address to change back to "LDI"
		ld	(hl),0EDh			; 10	; change to LDI again

PCM2_ResSamp:	ld	hl,00000h			; 10	; restore registers
PCM2_ResBuff:	ld	de,00000h			; 10	; ''
PCM2_ResQuo:	ld	sp,00000h			; 10	; ''
PCM2_ResDiv:	ld	bc,00000h			; 10	; ''
PCM2_ResPitCur:	ld	a,000h				; 07	; ''
		inci	y,l				; 08	; set window interrupt

PCM2_ResJump:	jp	00000h				; 10	; jump back to correct LDI instruction

; ===========================================================================
; ---------------------------------------------------------------------------
; 68K SET - routine to load a new sample 2
; ---------------------------------------------------------------------------

PCM2_NewSample:
		ld	a,(PCM2_PitchQuo+001h)		; 13	; load quotient
		inc	a				; 04	; increase by 1 (because FF00 is stopped), is it playing normally?
		jp	p,PCM2_NewNormal		; 10	; if so, branch
		ld	hl,(PCM2_Sample_Rev)		; 16	; load sample address (reversed)
		ld	a,(PCM2_Bank_Rev)		; 13	; load bank address (reversed)
		jp	PCM2_NewReverse			; 10	; continue to save reversed samples

PCM2_NewNormal:
		ld	hl,(PCM2_Sample)		; 16	; load sample address
		ld	a,(PCM2_Bank)			; 13	; load bank address

PCM2_NewReverse:
		ld	(PCM2_SampCur+001h),hl		; 16	; save as current address (68k to z80)
		ld	(PCM2_BankCur),a		; 13	; save as current bank (68k to z80)
		ld	de,PCM2_Switch			; 10	; load PCM switch list to edit
		call	SetBank				; 17	; set bank address
		xor	a				; 04	; clear the pitch current position
		ld	(PCM2_PitchCur+001h),a		; 13	; ''
		ld	hl,PCM2_NewRET			; 10	; load return address
		ld	(hl),011010010b			; 10	; change instruction back to "JP NC"
		scf					; 04	; set C flag (for "JP NC" instruction)
		jp	(hl)				; 04	; return to address

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to change a channel's volume table in "de", with the volume of "a"
; ---------------------------------------------------------------------------

SwitchVolume:
		ld	b,a				; 04	; store volume
		zneg					; 08	; convert volume to 00 - 80 (mute - loud)
		zadd	a,040h				; 07	; ''
		zadd	a,a				; 04	; shift MSB into carry
		ld	(SV_Fraction+001h),a		; 13	; store fraction
		sbc	a,a				; 04	; get only the carry (for quotient)
		zneg					; 08	; ''
		ld	c,a				; 04	; store quotient in c
		ld	hl,00000h			; 10	; reset current fraction/dividend
		ld	a,b				; 04	; reload volume
		ld	b,080h				; 07	; prepare minimum
		zadd	a,b				; 04	; rotate starting volume
SV_Fraction:	ld	b,000h				; 07	; set fraction/dividend
		jp	m,SV_SetNormal			; 10	; if negative, branch for normal volume

	; --- Beginning of table ---

SV_Beginning:
		ex	de,hl				; 04	; swap for hl powers
		ld	(hl),080h			; 10	; save 80 to table
		inc	l				; 04	; advance table
		ex	de,hl				; 04	; restore de...
		zadd	hl,bc 				; 11	; add fraction/dividend
		adc	a,c				; 04	; add carry to quotient
		jp	p,SV_Beginning			; 10	; if the value hasn't reached into negative, branch

	; --- Middle of table ---

SV_Middle:
		ld	(de),a				; 07	; save value to table
		inc	e				; 04	; advance table
		zadd	hl,bc 				; 11	; add fraction/dividend
		adc	a,c				; 04	; add carry to quotient
		jp	m,SV_Middle			; 10	; if the is still in negative, branch

	; --- End of table ---

		ld	a,0FFh				; 07	; force to maximum

SV_Ending:
		ld	(de),a				; 07	; save to table
		inc	e				; 04	; advance table
		jp	nz,SV_Ending			; 10	; repeat until the table is finished (should reach 100)
		jp	SV_Return			; 10	; jump to return address

	; --- Normal volume setup ---

SV_SetNormal:
		ld	(de),a				; 07	; save to table
		zadd	hl,bc 				; 11	; add fraction/dividend
		adc	a,c				; 04	; add carry to quotient
		inc	e				; 04	; advance table
		jp	nz,SV_SetNormal			; 10	; repeat until the table is finished (should reach 100)

SV_Return:	jp	00000h				; 10	; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Switching a channel's bank address
; ---------------------------------------------------------------------------
;		ld	hl,PCM1_BankCur			; 10	; address of bank ID
;		ld	de,PCM1_Switch			; 10	; load PCM switch list to edit
;		ld	a,(PCM1_PitchQuo+001h)		; 13	; load pitch quotient
;		call	SwitchBank			; 17	; change the bank address
; ---------------------------------------------------------------------------
;		ld	a,(PCM1_BankCur)		; 13	; load bank ID
;		ld	de,PCM1_Switch			; 10	; load PCM switch list to edit
;		call	SetBank				; 17	; set bank address
; ---------------------------------------------------------------------------

SwitchBank:
		inc	a				; 04	; increase pitch quotient by 1 (because FF00 is "stopped")
		zadd	a,a				; 04	; shift MSB into carry
		sbc	a,a				; 04	; convert to FF (if it was below FF00), else make it 00
		sbc	a,0FFh				; 07	; convert to FF (if it was below FF00), else make it 01
		zadd	a,(hl)				; 07	; increment/decrement the bank address
		ld	(hl),a				; 07	; update bank address

SetBank:
		ld	l,a				; 04	; load bank
		ld	h,001110100b			; 07	; prepare instruction ("ld  (hl),r")
	rept	008h
		xor	a				; 04	; clear a
		rrc	l				; 08	; shift bit into carry
		adc	a,h				; 04	; set instruction bits (with carry register bit)
		ld	(de),a				; 07	; write instruction
		inc	e	; WARNING (see comment)	; 04	; advance to next instruction (ONLY WORKS IF THE INSTRUCTIONS DON'T CROSS A 100 BYTE BOUNDARY, please align)
	endr
		ret					; 10	; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Specific variable data...
; ---------------------------------------------------------------------------

	; --- Current bank address for PCM channels ---

PCM1_BankCur:	db	000h					; The current bank address of PCM 1
PCM2_BankCur:	db	000h					; The current bank address of PCM 2

	; --- "Mute Sample" pointer into 68k memory ---

MuteSample:	dw	00000h					; sample window address
MuteBank:	db	000h					; sample bank address
MuteSample_Rev:	dw	00000h					; sample window address
MuteBank_Rev:	db	000h					; sample bank address

	; --- YM2612 Pointers ---

YM_Buffer:	db	000h					; 00 = Z80 Buffer 1 | 68k Buffer 2 ... FF = Z80 Buffer 2 | 68k Buffer 1

; ===========================================================================
; ---------------------------------------------------------------------------
; Sample requested by 68k
; ---------------------------------------------------------------------------

	; --- PCM 1 start sample ---

PCM1_Sample:		dw	00000h					; PCM 1 requested sample
PCM1_Bank:		db	000h					; PCM 1 requested bank
PCM1_Sample_Rev:	dw	00000h					; PCM 1 requested sample (reverse position)
PCM1_Bank_Rev:		db	000h					; PCM 1 requested bank (reverse position)

	; --- PCM 1 next sample ---

PCM1_SampleNext:	dw	00000h					; PCM 1 requested sample
PCM1_BankNext:		db	000h					; PCM 1 requested bank
PCM1_SampleNext_Rev:	dw	00000h					; PCM 1 requested sample (reverse position)
PCM1_BankNext_Rev:	db	000h					; PCM 1 requested bank (reverse position)

	; --- PCM 2 start sample ---

PCM2_Sample:		dw	00000h					; PCM 2 requested sample
PCM2_Bank:		db	000h					; PCM 2 requested bank
PCM2_Sample_Rev:	dw	00000h					; PCM 2 requested sample (reverse position)
PCM2_Bank_Rev:		db	000h					; PCM 2 requested bank (reverse position)

	; --- PCM 2 next sample ---

PCM2_SampleNext:	dw	00000h					; PCM 2 requested sample
PCM2_BankNext:		db	000h					; PCM 2 requested bank
PCM2_SampleNext_Rev:	dw	00000h					; PCM 2 requested sample (reverse position)
PCM2_BankNext_Rev:	db	000h					; PCM 2 requested bank (reverse position)

; ===========================================================================
; ---------------------------------------------------------------------------
; Bank interrupt preparation list
; ---------------------------------------------------------------------------

		align	00100h

PCM1_PrepTable:	dw	PCM1_PreInst01
		dw	PCM1_PreInst02
		dw	PCM1_PreInst03
		dw	PCM1_PreInst04
		dw	PCM1_PreInst05
		dw	PCM1_PreInst06
		dw	PCM1_PreInst07
		dw	PCM1_PreInst08
		dw	PCM1_PreInst09
		dw	PCM1_PreInst0A
		dw	PCM1_PreInst0B
		dw	PCM1_PreInst0C
		dw	PCM1_PreInst0D
		dw	PCM1_PreInst0E
		dw	PCM1_PreInst0F
		dw	PCM1_PreInst10
		dw	PCM1_PreInst11
		dw	PCM1_PreInst12
		dw	PCM1_PreInst13
		dw	PCM1_PreInst14
		dw	PCM1_PreInst15
		dw	PCM1_PreInst16
		dw	PCM1_PreInst17
		dw	PCM1_PreInst18

	;	align	00100h

PCM2_PrepTable:	dw	PCM2_PreInst01
		dw	PCM2_PreInst02
		dw	PCM2_PreInst03
		dw	PCM2_PreInst04
		dw	PCM2_PreInst05
		dw	PCM2_PreInst06
		dw	PCM2_PreInst07
		dw	PCM2_PreInst08
		dw	PCM2_PreInst09
		dw	PCM2_PreInst0A
		dw	PCM2_PreInst0B
		dw	PCM2_PreInst0C
		dw	PCM2_PreInst0D
		dw	PCM2_PreInst0E
		dw	PCM2_PreInst0F
		dw	PCM2_PreInst10
		dw	PCM2_PreInst11
		dw	PCM2_PreInst12
		dw	PCM2_PreInst13
		dw	PCM2_PreInst14
		dw	PCM2_PreInst15
		dw	PCM2_PreInst16
		dw	PCM2_PreInst17
		dw	PCM2_PreInst18

; ===========================================================================
; ---------------------------------------------------------------------------
; PCM volume Lists
; ---------------------------------------------------------------------------
		align	00200h
; ---------------------------------------------------------------------------

PCM_Volume1:	db	080h,080h,081h,081h,082h,082h,083h,083h,084h,084h,085h,085h,086h,086h,087h,087h
		db	088h,088h,089h,089h,08Ah,08Ah,08Bh,08Bh,08Ch,08Ch,08Dh,08Dh,08Eh,08Eh,08Fh,08Fh
		db	090h,090h,091h,091h,092h,092h,093h,093h,094h,094h,095h,095h,096h,096h,097h,097h
		db	098h,098h,099h,099h,09Ah,09Ah,09Bh,09Bh,09Ch,09Ch,09Dh,09Dh,09Eh,09Eh,09Fh,09Fh
		db	0A0h,0A0h,0A1h,0A1h,0A2h,0A2h,0A3h,0A3h,0A4h,0A4h,0A5h,0A5h,0A6h,0A6h,0A7h,0A7h
		db	0A8h,0A8h,0A9h,0A9h,0AAh,0AAh,0ABh,0ABh,0ACh,0ACh,0ADh,0ADh,0AEh,0AEh,0AFh,0AFh
		db	0B0h,0B0h,0B1h,0B1h,0B2h,0B2h,0B3h,0B3h,0B4h,0B4h,0B5h,0B5h,0B6h,0B6h,0B7h,0B7h
		db	0B8h,0B8h,0B9h,0B9h,0BAh,0BAh,0BBh,0BBh,0BCh,0BCh,0BDh,0BDh,0BEh,0BEh,0BFh,0BFh
		db	0C0h,0C0h,0C1h,0C1h,0C2h,0C2h,0C3h,0C3h,0C4h,0C4h,0C5h,0C5h,0C6h,0C6h,0C7h,0C7h
		db	0C8h,0C8h,0C9h,0C9h,0CAh,0CAh,0CBh,0CBh,0CCh,0CCh,0CDh,0CDh,0CEh,0CEh,0CFh,0CFh
		db	0D0h,0D0h,0D1h,0D1h,0D2h,0D2h,0D3h,0D3h,0D4h,0D4h,0D5h,0D5h,0D6h,0D6h,0D7h,0D7h
		db	0D8h,0D8h,0D9h,0D9h,0DAh,0DAh,0DBh,0DBh,0DCh,0DCh,0DDh,0DDh,0DEh,0DEh,0DFh,0DFh
		db	0E0h,0E0h,0E1h,0E1h,0E2h,0E2h,0E3h,0E3h,0E4h,0E4h,0E5h,0E5h,0E6h,0E6h,0E7h,0E7h
		db	0E8h,0E8h,0E9h,0E9h,0EAh,0EAh,0EBh,0EBh,0ECh,0ECh,0EDh,0EDh,0EEh,0EEh,0EFh,0EFh
		db	0F0h,0F0h,0F1h,0F1h,0F2h,0F2h,0F3h,0F3h,0F4h,0F4h,0F5h,0F5h,0F6h,0F6h,0F7h,0F7h
		db	0F8h,0F8h,0F9h,0F9h,0FAh,0FAh,0FBh,0FBh,0FCh,0FCh,0FDh,0FDh,0FEh,0FEh,0FFh,0FFh

PCM_Volume2:	db	080h,080h,081h,081h,082h,082h,083h,083h,084h,084h,085h,085h,086h,086h,087h,087h
		db	088h,088h,089h,089h,08Ah,08Ah,08Bh,08Bh,08Ch,08Ch,08Dh,08Dh,08Eh,08Eh,08Fh,08Fh
		db	090h,090h,091h,091h,092h,092h,093h,093h,094h,094h,095h,095h,096h,096h,097h,097h
		db	098h,098h,099h,099h,09Ah,09Ah,09Bh,09Bh,09Ch,09Ch,09Dh,09Dh,09Eh,09Eh,09Fh,09Fh
		db	0A0h,0A0h,0A1h,0A1h,0A2h,0A2h,0A3h,0A3h,0A4h,0A4h,0A5h,0A5h,0A6h,0A6h,0A7h,0A7h
		db	0A8h,0A8h,0A9h,0A9h,0AAh,0AAh,0ABh,0ABh,0ACh,0ACh,0ADh,0ADh,0AEh,0AEh,0AFh,0AFh
		db	0B0h,0B0h,0B1h,0B1h,0B2h,0B2h,0B3h,0B3h,0B4h,0B4h,0B5h,0B5h,0B6h,0B6h,0B7h,0B7h
		db	0B8h,0B8h,0B9h,0B9h,0BAh,0BAh,0BBh,0BBh,0BCh,0BCh,0BDh,0BDh,0BEh,0BEh,0BFh,0BFh
		db	0C0h,0C0h,0C1h,0C1h,0C2h,0C2h,0C3h,0C3h,0C4h,0C4h,0C5h,0C5h,0C6h,0C6h,0C7h,0C7h
		db	0C8h,0C8h,0C9h,0C9h,0CAh,0CAh,0CBh,0CBh,0CCh,0CCh,0CDh,0CDh,0CEh,0CEh,0CFh,0CFh
		db	0D0h,0D0h,0D1h,0D1h,0D2h,0D2h,0D3h,0D3h,0D4h,0D4h,0D5h,0D5h,0D6h,0D6h,0D7h,0D7h
		db	0D8h,0D8h,0D9h,0D9h,0DAh,0DAh,0DBh,0DBh,0DCh,0DCh,0DDh,0DDh,0DEh,0DEh,0DFh,0DFh
		db	0E0h,0E0h,0E1h,0E1h,0E2h,0E2h,0E3h,0E3h,0E4h,0E4h,0E5h,0E5h,0E6h,0E6h,0E7h,0E7h
		db	0E8h,0E8h,0E9h,0E9h,0EAh,0EAh,0EBh,0EBh,0ECh,0ECh,0EDh,0EDh,0EEh,0EEh,0EFh,0EFh
		db	0F0h,0F0h,0F1h,0F1h,0F2h,0F2h,0F3h,0F3h,0F4h,0F4h,0F5h,0F5h,0F6h,0F6h,0F7h,0F7h
		db	0F8h,0F8h,0F9h,0F9h,0FAh,0FAh,0FBh,0FBh,0FCh,0FCh,0FDh,0FDh,0FEh,0FEh,0FFh,0FFh

; ===========================================================================
; ---------------------------------------------------------------------------
; PCM buffer (1000h = end of buffer, keep it in multiples of 100)
; ---------------------------------------------------------------------------

	rsset (01000h-00200h)-00150h
PCM_Buffer1:	rs.b	00150h
	rsset 01000h-00150h
PCM_Buffer2:	rs.b	00150h

; ===========================================================================
; ---------------------------------------------------------------------------
; The YM2612 operator writing list (68k writes here, z80 must flush off)
; ---------------------------------------------------------------------------

YM_Buffer1:	rs.b $800
YM_Buffer2:	rs.b $800

; ===========================================================================




