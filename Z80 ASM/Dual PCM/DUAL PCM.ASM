; ===========================================================================
; ---------------------------------------------------------------------------
; DUAL-PCM - by MarkeyJester
; ---------------------------------------------------------------------------
E_PCM_BuffSize	=	00280h	; PCM delay	; keep in multiples of 40
E_CueSize	=	00300h	; FM delay	; Number of bytes for the 68k to cue ahead (keep in multiples of 100)
E_CueStart	=	01000h			; Start of the cue, (ALWAYS keep in multiples of 10)
E_CueFinish	=	02000h			; End of the cue (keep in multiples of 10)
E_MaxPitch	=	00C00h			; maximum pitch (QQ.DD)
; ---------------------------------------------------------------------------
M_Flush		macro
		ld	a,(de)			; 2 07		; load byte from OUT buffer 1
		zadd	a,(hl)			; 2 07		; add byte from OUT buffer 2
		zadd	a,c			; 1 04		; convert to signed
		ld	(ix+001h),a		; 5 19		; save to the YM2612
		inc	e			; 1 04		; advance OUT buffer 1
		inc	l			; 1 04		; advance OUT buffer 2
		endm
; ---------------------------------------------------------------------------

Start:
		di				; 1 04		; disable the interrupts
		jp	InitRout		; 3 10		; jump directly to initialisation routine

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to change window switch instructions correctly
; ---------------------------------------------------------------------------
		align	020h
; --- Example ---------------------------------------------------------------
;		ld	sp,PCM1_Switch		; 2 10		; load PCM switch list address
;		ld	hl,PCM1_BankCur		; 2 10		; load current bank window address
;		ld	b,(PCM1_SwitStack-PCM1_Switch)/2 ; 2 07	; set number of bits to write
;		rst	Switch_PCM		; 3 11		; switch the PCM window address instructions
; ---------------------------------------------------------------------------

Switch_PCM:
		ld	a,(hl)			; 07		; load bank address itself
		rlca				; 04		; send first bit up
		ld	c,a			; 04		; store in c
		inc	(hl)			; 11		; increment for next time
		pop	af			; 10		; reload return address
		ex	af,af			; 04		; store in other af register

SP_NextBit:
		ld	a,c			; 04		; load address
		rrca				; 04		; get next bit
		ld	c,a			; 04		; store address
		zand	000000001b		; 07		; get only register bit (b or c)
		zor	001110000b		; 07		; set instruction bits ("ld (hl),r")
		pop	hl			; 10		; load instruction address
		ld	(hl),a			; 07		; save instruction
		djnz	SP_NextBit		; 13 | 08 = Z	; repeat for all bits
		pop	hl			; 10		; move stack back
		ex	af,af			; 04		; restore return address
		push	af			; 11		; push onto the stack
		ret				; 10		; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Catch-up - PCM 1 list
; ---------------------------------------------------------------------------

		dw	00000h					; the return address created by the z80 (this will be copied to below in "Switch_PCM")
PCM1_Switch:	dw	PCM1_Switch0				;  32KB -  64KB (  8000 -   10000)
		dw	PCM1_Switch1				;  64KB - 128KB ( 10000 -   20000)
		dw	PCM1_Switch2				; 128KB - 256KB ( 20000 -   40000)
		dw	PCM1_Switch3				; 256KB - 512KB ( 40000 -   80000)
		dw	PCM1_Switch4				; 512KB -   1MB ( 80000 -  100000)
		dw	PCM1_Switch5				;   1MB -   2MB (100000 -  200000)
		dw	PCM1_Switch6				;   2MB -   4MB (200000 -  400000)
	;	dw	PCM1_Switch7				;   4MB -   8MB (400000 -  800000)
	;	dw	PCM1_Switch8				;   8MB -  16MB (800000 - 1000000)
PCM1_SwitStack:	dw	00000h					; stack return address (Copied to here by "Switch_PCM" for return)

; ===========================================================================
; ---------------------------------------------------------------------------
; Catch-up - PCM 2 list
; ---------------------------------------------------------------------------

		dw	00000h					; the return address created by the z80 (this will be copied to below in "Switch_PCM")
PCM2_Switch:	dw	PCM2_Switch0				;  32KB -  64KB (  8000 -   10000)
		dw	PCM2_Switch1				;  64KB - 128KB ( 10000 -   20000)
		dw	PCM2_Switch2				; 128KB - 256KB ( 20000 -   40000)
		dw	PCM2_Switch3				; 256KB - 512KB ( 40000 -   80000)
		dw	PCM2_Switch4				; 512KB -   1MB ( 80000 -  100000)
		dw	PCM2_Switch5				;   1MB -   2MB (100000 -  200000)
		dw	PCM2_Switch6				;   2MB -   4MB (200000 -  400000)
	;	dw	PCM2_Switch7				;   4MB -   8MB (400000 -  800000)
	;	dw	PCM2_Switch8				;   8MB -  16MB (800000 - 1000000)
PCM2_SwitStack:	dw	00000h					; stack return address (Copied to here by "Switch_PCM" for return)

; ===========================================================================
; ---------------------------------------------------------------------------
; Setup/init routine
; ---------------------------------------------------------------------------

InitRout:

	; --- YM2612 DAC Setup ---

			ld	ix,04000h		; 4 14		; prepare YM2612 port address
			ld	(ix+000h),02Bh		; 5 19		; set address to DAC switch
			ld	(ix+001h),010000000b	; 5 19		; enable DAC/disable FM6 playback
			ld	(ix+000h),02Ah		; 5 19		; set address to DAC port

	; --- Setting up PCM 1 switch ---

			ld	bc,(MuteSample)		; 6 20		; load sample address to current address
			ld	(PCM1_SampCur),bc	; 6 20		; (68k to z80)
			ld	a,(MuteSample+002h)	; 4 13		; load bank address to current address
			ld	(PCM1_BankCur),a	; 4 13		; (68k to z80)

			ld	sp,PCM1_Switch		; 2 10		; load PCM switch list address
			ld	hl,PCM1_BankCur		; 2 10		; load current bank window address
			ld	b,(PCM1_SwitStack-PCM1_Switch)/2 ; 2 07	; set number of bits to write
			rst	Switch_PCM		; 3 11		; switch the PCM window address instructions

	; --- Setting up PCM 2 switch ---

			ld	bc,(MuteSample)		; 6 20		; load sample address to current address
			ld	(PCM2_SampCur),bc	; 6 20		; (68k to z80)
			ld	a,(MuteSample+002h)	; 4 13		; load bank address to current address
			ld	(PCM2_BankCur),a	; 4 13		; (68k to z80)

			ld	sp,PCM2_Switch		; 2 10		; load PCM switch list address
			ld	hl,PCM2_BankCur		; 2 10		; load current bank window address
			ld	b,(PCM2_SwitStack-PCM2_Switch)/2 ; 2 07	; set number of bits to write
			rst	Switch_PCM		; 3 11		; switch the PCM window address instructions

	; --- Final register setup ---

			ld	c,080h			; 2 07		; prepare unsigned/signed conversion value
			ld	de,PCM_Buffer+000h	; 2 10		; prepare OUT buffer 1
			ld	hl,PCM_Buffer+020h	; 2 10		; prepare OUT buffer 2
		exx				; 1 04		; switch registers
		ld	de,PCM_Buffer+040h	; 2 10		; prepare IN buffer 1

; ===========================================================================
; ---------------------------------------------------------------------------
; Main "CatchUp" loop
; ---------------------------------------------------------------------------

	; --- PCM Sample 1 ---

CatchUp_Exx:
			exx				; 1 04		; switch registers

CatchUp:
			M_Flush						; flush a byte to the YM2612
			exx				; 1 04		; switch registers

		ld	hl,06000h		; 2 10		; load bank switch register port
		ld	bc,00001h		; 2 10		; prepare bit set/clear values
PCM1_Switch0:	ld	(hl),b			; 2 07		; 0000 0000 1  32KB -  64KB (  8000 -   10000)
PCM1_Switch1:	ld	(hl),b			; 2 07		; 0000 0001 0  64KB - 128KB ( 10000 -   20000)
PCM1_Switch2:	ld	(hl),b			; 2 07		; 0000 0010 0 128KB - 256KB ( 20000 -   40000)
PCM1_Switch3:	ld	(hl),b			; 2 07		; 0000 0100 0 256KB - 512KB ( 40000 -   80000)
PCM1_Switch4:	ld	(hl),b			; 2 07		; 0000 1000 0 512KB -   1MB ( 80000 -  100000)
PCM1_Switch5:	ld	(hl),b			; 2 07		; 0001 0000 0   1MB -   2MB (100000 -  200000)
PCM1_Switch6:	ld	(hl),b			; 2 07		; 0010 0000 0   2MB -   4MB (200000 -  400000)
PCM1_Switch7:	ld	(hl),b			; 2 07		; 0100 0000 0   4MB -   8MB (400000 -  800000)
PCM1_Switch8:	ld	(hl),b			; 2 07		; 1000 0000 0   8MB -  16MB (800000 - 1000000)

		ld	sp,PCM1_SampCur		; 2 10		; start of list to load (quicker to mass pop)
		pop	hl			; 3 10		; load PCM 1 sample address
		pop	bc			; 3 10		; load PCM 1 dividend pitch main (and prepare c for "ldi" countdown)
			exx				; 1 04		; switch registers
			M_Flush						; flush a byte to the YM2612
			exx				; 1 04		; switch registers
		pop	af			; 3 10		; load PCM 1 dividend pitch current
		ld	sp,(PCM1_PitchQuo)	; 6 20		; (Might be quicker then "pop iy" and "ld sp,iy")

		rept	006h
		rept	005h
		ldi				; 4 16		; copy from window to buffer, and increment registers
		zadd	a,b			; 1 04		; add dividend
		adc	hl,sp			; 4 15		; add quotient
		endr
			exx				; 1 04		; switch registers
			ex	af,af			; 1 04		; store dividend
			M_Flush						; flush a byte to the YM2612
			ex	af,af			; 1 04		; restore dividend
			exx				; 1 04		; switch registers
		endr
		rept	002h
		ldi				; 4 16		; copy from window to buffer, and increment registers
		zadd	a,b			; 1 04		; add dividend
		adc	hl,sp			; 4 15		; add quotient
		endr

		ld	(PCM1_PitchCur+001h),a	; 4 13		; store PCM 1 dividend pitch
		ld	(PCM1_SampCur),hl	; 5 16		; update PCM 1 sample window address
		ld	a,(hl)			; 2 07		; load PCM byte
		zor	a			; 1 04		; is it an end marker? (00)
		jp	z,PCM1_Mute		; 3 10 always	; if so, branch to mute...
PCM1_Overflow:	ld	sp,00020h*(E_MaxPitch/100h)	; 2 10	; prepare amount to get to end of window
		adc	hl,sp			; 3 11		; advance address (carry "should" be reset by the "or  a" instruction
		jp	p,PCM1_Reset		; 3 10 always	; if the address has gone outside the window, branch

PCM1_ResetRet:
PCM1_MuteRet:

	; --- PCM Sample 2 ---

			exx				; 1 04		; switch registers
			M_Flush						; flush a byte to the YM2612
			exx				; 1 04		; switch registers

		ld	hl,06000h		; 2 10		; load bank switch register port
		ld	bc,00001h		; 2 10		; prepare bit set/clear values
PCM2_Switch0:	ld	(hl),b			; 2 07		; 0000 0000 1  32KB -  64KB (  8000 -   10000)
PCM2_Switch1:	ld	(hl),b			; 2 07		; 0000 0001 0  64KB - 128KB ( 10000 -   20000)
PCM2_Switch2:	ld	(hl),b			; 2 07		; 0000 0010 0 128KB - 256KB ( 20000 -   40000)
PCM2_Switch3:	ld	(hl),b			; 2 07		; 0000 0100 0 256KB - 512KB ( 40000 -   80000)
PCM2_Switch4:	ld	(hl),b			; 2 07		; 0000 1000 0 512KB -   1MB ( 80000 -  100000)
PCM2_Switch5:	ld	(hl),b			; 2 07		; 0001 0000 0   1MB -   2MB (100000 -  200000)
PCM2_Switch6:	ld	(hl),b			; 2 07		; 0010 0000 0   2MB -   4MB (200000 -  400000)
PCM2_Switch7:	ld	(hl),b			; 2 07		; 0100 0000 0   4MB -   8MB (400000 -  800000)
PCM2_Switch8:	ld	(hl),b			; 2 07		; 1000 0000 0   8MB -  16MB (800000 - 1000000)

		ld	sp,PCM2_SampCur		; 2 10		; start of list to load (quicker to mass pop)
		pop	hl			; 3 10		; load PCM 1 sample address
		pop	bc			; 3 10		; load PCM 1 dividend pitch main (and prepare c for "ldi" countdown)
			exx				; 1 04		; switch registers
			M_Flush						; flush a byte to the YM2612
			exx				; 1 04		; switch registers
		pop	af			; 3 10		; load PCM 1 dividend pitch current
		ld	sp,(PCM2_PitchQuo)	; 6 20		; (Might be quicker then "pop iy" and "ld sp,iy")

		rept	006h
		rept	005h
		ldi				; 4 16		; copy from window to buffer, and increment registers
		zadd	a,b			; 1 04		; add dividend
		adc	hl,sp			; 4 15		; add quotient
		endr
			exx				; 1 04		; switch registers
			ex	af,af			; 1 04		; store dividend
			M_Flush						; flush a byte to the YM2612
			ex	af,af			; 1 04		; restore dividend
			exx				; 1 04		; switch registers
		endr
		rept	002h
		ldi				; 4 16		; copy from window to buffer, and increment registers
		zadd	a,b			; 1 04		; add dividend
		adc	hl,sp			; 4 15		; add quotient
		endr


		ld	(PCM2_PitchCur+001h),a	; 4 13		; store PCM 1 dividend pitch
		ld	(PCM2_SampCur),hl	; 5 16		; update PCM 1 sample window address
		ld	a,(hl)			; 2 07		; load PCM byte
		zor	a			; 1 04		; is it an end marker? (00)
		jp	z,PCM2_Mute		; 3 10 always	; if so, branch to mute...
PCM2_Overflow:	ld	sp,00020h*(E_MaxPitch/100h)	; 2 10	; prepare amount to get to end of window
		adc	hl,sp			; 3 11		; advance address (carry "should" be reset by the "or  a" instruction
		jp	p,PCM2_Reset		; 3 10 always	; if the address has gone outside the window, branch

PCM2_ResetRet:
PCM2_MuteRet:
		ld	a,e			; 1 04		; load IN buffer address
		zor	a			; 1 04		; has it reset to 0?
		jp	z,BUFF_Reset		; 3 10 always	; if so, branch

BUFF_ResetRet:

	; --- Advance/Wrap OUT buffers ---

			exx				; 1 04		; switch registers
		;	M_Flush						; flush a byte to the YM2612
			ld	a,l			; 1 04		; load lower byte
			zor	a			; 1 04		; has it wrapped to 0?
			jp	nz,CU_NoWrapLow		; 3 10 always	; if not, branch
		;	inc	d			; 1 04		; advance OUT buffer 1
			inc	h			; 1 04		; advance OUT buffer 2
			jp	CU_Advance

CU_NoWrapLow:
			zand	01Fh			; 2 07		; get within segment
			jr	nz,CU_NoAdvance		; 3 12 | 2 07	; if it's not reached the end of a segment, branch

CU_Advance:
			ex	de,hl			; 1 04		; set de to where hl is
			ld	sp,00040h		; 2 10		; advance hl 20 ahead of de
			zadd	hl,sp			; 3 11		; ''
			ld	a,h			; 1 04		; load upper byte
			cp	010h			; 2 07		; have we reached the end?
			jp	nz,CU_NoAdvance		; 3 12 | 2 07	; if not, branch
			ld	de,PCM_Buffer		; 2 10		; reset OUT buffer 1
			ld	hl,PCM_Buffer+020h	; 2 10		; reset OUT buffer 2

CU_NoAdvance:
		;	M_Flush						; flush a byte to the YM2612

	; --- Checking for "Flush" mode ---

			ld	a,l			; 1 04		; load lower byte of OUT buffer
			zand	0C0h			; 2 07		; keep in multiples of 40 bytes
			exx				; 1 04		; switch registers
		cp	e			; 1 04		; does the IN buffer match the OUT buffer?
		jp	nz,CatchUp_Exx		; 3 10 always	; if not, branch
		ld	a,d			; 1 04		; load upper byte of IN buffer
			exx				; 1 04		; switch registers
			cp	d			; 1 04		; does the OUT buffer match the IN buffer?
			jp	nz,CatchUp		; 3 10 always	; if not, branch

; ---------------------------------------------------------------------------
; New sample playback
; ---------------------------------------------------------------------------

		exx				; 04		; switch registers
PCM1_NewRET:	jp	nz,PCM1_NewSample	; 10 Always	; can be changed to "jp  z" by the 68k
PCM2_NewRET:	jp	nz,PCM2_NewSample	; 10 Always	; can be changed to "jp  z" by the 68k
		exx				; 04		; switch registers

; ---------------------------------------------------------------------------
; Main "Flush" loop
; ---------------------------------------------------------------------------

Flush:
			ld	sp,(YM_PointZ80)	; 20		; load list pointer
			ld	b,010h			; 07		; set number of bytes to flush

BM_NextByte:
			M_Flush
		exx				; 04		; switch registers
		pop	hl			; 10		; get YM2612 part address
		pop	bc			; 10		; get address/data bytes
		ld	a,h			; 04		; swap h and l around...
		ld	h,l			; 04		; ''
		ld	l,a			; 04		; ''
		ld	(hl),b			; 07		; set YM2612 address
		inc	l			; 04		; advance to YM2612 data port
		ld	(hl),c			; 07		; save YM2612 data
		ld	bc,02600h		; 10		; prepare "null operator write" value
		push	bc			; 11		; overwrite previous request with a null request
		pop	bc			; 10		; advance stack address to the next request
		ld	(ix+000h),02Ah		; 19		; set YM2612 address back to DAC port
		ld	b,005h			; 07		; intentional delay to keep the playback smooth and consistent...
		djnz	*			; 13 | 08 = Z	; ''
		exx				; 04		; switch registers back
			djnz	BM_NextByte		; 13 | 08 = Z	; repeat for number of bytes to flush to YM2612
		exx				; 04		; switch registers

	; --- Z80 Cue Pointer ---

		ld	hl,00000h		; 10		; load Z80 pointer address from sp to hl (this is the quickest way I could find for now...)
		zadd	hl,sp			; 11		; ''
		ld	a,h			; 04		; wrap the Z80's pointer
		zand	00Fh			; 07		; ''
		zor	010h			; 07		; ''
		ld	h,a			; 04		; ''
		ld	(YM_PointZ80),hl	; 16		; update YM cue list address

	; --- 68k Cue Pointer ---

		ld	a,(YM_Point68k+001h)	; 13		; load 68k's pointer
		zsub	h			; 04		; subtract Z80's pointer
		jp	p,Valid			; 10 Always	; if the difference is positive, branch
		zadd	a,E_CueStart>>008h	; 07		; wrap pointer infront of Z80's pointer (for calculating distance only)

Valid:
		cp	E_CueSize>>008h		; 07		; is the 68k pointer too far ahead (i.e. does the Z80 already have a lot to do)?
		jp	p,OutRange		; 10 Always	; if so, branch (do NOT change the pointer)
		ld	a,h			; 04		; advance the Z80's pointer ahead by the buffer/cue size (force the 68k pointer ahead a fixed amount)
		zadd	a,E_CueSize>>008h	; 07		; ''
		zand	00Fh			; 07		; wrap the pointer
		zor	010h			; 07		; ''
		ld	h,a			; 04		; save back to h (together with Z80 pointer's "l" for the 68k new pointer)
		ld	a,0FFh			; 07		; this flag is set just in case the 68k collects the address after the Z80...
		ld	(YM_Access),a		; 13		; ...writes the first byte, but before it writes the second byte
		ld	(YM_Point68k),hl	; 16		; set new 68k pointer
		xor	a			; 04		; let the 68k know that it can read the addres now...
		ld	(YM_Access),a		; 13		; ''

OutRange:
		ld	c,080h			; 07		; restore c to 80 (so that the "ldi" instructions don't mess with the "b" register)
		exx				; 04		; switch registers back

	; --- Advance/Wrap OUT buffers ---

		;	M_Flush						; flush a byte to the YM2612
			ld	a,l			; 1 04		; load lower byte
			zor	a			; 1 04		; has it wrapped to 0?
			jp	nz,FL_NoWrapLow		; 3 10 always	; if not, branch
		;	inc	d			; 1 04		; advance OUT buffer 1
			inc	h			; 1 04		; advance OUT buffer 2
			jp	FL_Advance

FL_NoWrapLow:
			zand	01Fh			; 2 07		; get within segment
			jr	nz,FL_NoAdvance		; 3 12 | 2 07	; if it's not reached the end of a segment, branch

FL_Advance:
			ex	de,hl			; 1 04		; set de to where hl is
			ld	sp,00040h		; 2 10		; advance hl 20 ahead of de
			zadd	hl,sp			; 3 11		; ''
			ld	a,h			; 1 04		; load upper byte
			cp	010h			; 2 07		; have we reached the end?
			jp	nz,FL_NoAdvance		; 3 12 | 2 07	; if not, branch
			ld	de,PCM_Buffer		; 2 10		; reset OUT buffer 1
			ld	hl,PCM_Buffer+020h	; 2 10		; reset OUT buffer 2
		ld	a,001h			; 1 07		; clear the Z flag

FL_NoAdvance:
		;	M_Flush						; flush a byte to the YM2612

FL_FlushSwitch:		jr	z,Flush			; 12 | 07 = NZ	; can be chaned to "jr  nz" by the 68k

			jp	CatchUp

; ===========================================================================
; ---------------------------------------------------------------------------
; When PCM sample 2 has reached an end marker & needs to play a "mute" sample
; ---------------------------------------------------------------------------

PCM2_Mute:
		ld	bc,(PCM2_Sample)	; 20		; load sample address to current address
		ld	(PCM2_SampCur),bc	; 20		; (68k to z80)
		ld	a,(PCM2_Bank)		; 13		; load bank address to current address
		ld	(PCM2_BankCur),a	; 13		; (68k to z80)

		ld	a,(PCM2_Loop)		; 4 13		; load loop flag
		zor	a			; 1 04		; is the loop flag set?
		jr	nz,PCM2_UseLoop		; 12 | 07 = Z	; if so, branch

		ld	bc,(MuteSample)		; 6 20		; load sample address to current address
		ld	(PCM2_SampCur),bc	; 6 20		; (68k to z80)
		ld	a,(MuteSample+002h)	; 4 13		; load bank address to current address
		ld	(PCM2_BankCur),a	; 4 13		; (68k to z80)

PCM2_UseLoop:
		ld	sp,PCM2_List		; 2 10		; load PCM list
		pop	af			; 3 10		; clear af
		push	af			; 3 11		; push stack back
		dec	sp			; 1 06		; skip over pitch quotient (do NOT clear it)
		dec	sp			; 1 06		; ''
		push	af			; 3 11		; clear pitch dividend current

		ld	sp,PCM2_Switch		; 2 10		; load PCM switch list address
		ld	hl,PCM2_BankCur		; 2 10		; load current bank window address
		ld	b,(PCM2_SwitStack-PCM2_Switch)/2 ; 2 07	; set number of bits to write
		rst	Switch_PCM		; 3 11		; switch the PCM window address instructions

		jp	PCM2_MuteRet		; 3 10		; return

; ===========================================================================
; ---------------------------------------------------------------------------
; When the IN buffer needs to reset
; ---------------------------------------------------------------------------

BUFF_Reset:
		ld	a,d			; 1 04		; copy to a
		cp	010h			; 2 07		; has it reached the end of the buffer?
		jp	nz,BUFF_ResetRet	; 3 10 always	; if it hasn't, return
		ld	de,PCM_Buffer		; 3 10		; reset buffer address
		jp	BUFF_ResetRet		; 3 10		; return

; ===========================================================================
; ---------------------------------------------------------------------------
; When PCM sample 2 address has gone outside the window, and needs to reset
; ---------------------------------------------------------------------------

PCM2_Reset:
		ld	sp,PCM2_Switch		; 2 10		; load PCM switch list address
		ld	hl,PCM2_BankCur		; 2 10		; load current bank window address
		ld	b,(PCM2_SwitStack-PCM2_Switch)/2 ; 2 07	; set number of bits to write
		rst	Switch_PCM		; 3 11		; switch the PCM window address instructions

		ld	hl,08000h		; 2 10		; reset sample 2 address to beginning of window
		ld	(PCM2_SampCur),hl	; 5 16		; update sample 2 current position

		jp	PCM2_ResetRet		; 3 10		; return

; ===========================================================================
; ---------------------------------------------------------------------------
; When PCM sample 1 has reached an end marker & needs to play a "mute" sample
; ---------------------------------------------------------------------------

PCM1_Mute:
		ld	bc,(PCM1_Sample)	; 20		; load sample address to current address
		ld	(PCM1_SampCur),bc	; 20		; (68k to z80)
		ld	a,(PCM1_Bank)		; 13		; load bank address to current address
		ld	(PCM1_BankCur),a	; 13		; (68k to z80)

		ld	a,(PCM1_Loop)		; 4 13		; load loop flag
		zor	a			; 1 04		; is the loop flag set?
		jr	nz,PCM1_UseLoop		; 12 | 07 = Z	; if so, branch

		ld	bc,(MuteSample)		; 6 20		; load sample address to current address
		ld	(PCM1_SampCur),bc	; 6 20		; (68k to z80)
		ld	a,(MuteSample+002h)	; 4 13		; load bank address to current address
		ld	(PCM1_BankCur),a	; 4 13		; (68k to z80)

PCM1_UseLoop:
		ld	sp,PCM1_List		; 2 10		; load PCM list
		pop	af			; 3 10		; clear af
		push	af			; 3 11		; push stack back
		dec	sp			; 1 06		; skip over pitch quotient (do NOT clear it)
		dec	sp			; 1 06		; ''
		push	af			; 3 11		; clear pitch dividend current

		ld	sp,PCM1_Switch		; 2 10		; load PCM switch list address
		ld	hl,PCM1_BankCur		; 2 10		; load current bank window address
		ld	b,(PCM1_SwitStack-PCM1_Switch)/2 ; 2 07	; set number of bits to write
		rst	Switch_PCM		; 3 11		; switch the PCM window address instructions

		jp	PCM1_MuteRet		; 3 10		; return

; ===========================================================================
; ---------------------------------------------------------------------------
; When PCM sample 1 address has gone outside the window, and needs to reset
; ---------------------------------------------------------------------------

PCM1_Reset:
		ld	sp,PCM1_Switch		; 2 10		; load PCM switch list address
		ld	hl,PCM1_BankCur		; 2 10		; load current bank window address
		ld	b,(PCM1_SwitStack-PCM1_Switch)/2 ; 2 07	; set number of bits to write
		rst	Switch_PCM		; 3 11		; switch the PCM window address instructions

		ld	hl,08000h		; 2 10		; reset sample 1 address to beginning of window
		ld	(PCM1_SampCur),hl	; 5 16		; update sample 1 current position

		jp	PCM1_ResetRet		; 3 10		; return


; ===========================================================================
; ---------------------------------------------------------------------------
; 68K SET - routine to load a new sample 1
; ---------------------------------------------------------------------------

PCM1_NewSample:
		ld	bc,(PCM1_Sample)	; 20		; load sample address to current address
		ld	(PCM1_SampCur),bc	; 20		; (68k to z80)
		ld	a,(PCM1_Bank)		; 13		; load bank address to current address
		ld	(PCM1_BankCur),a	; 13		; (68k to z80)

		ld	sp,PCM1_List		; 2 10		; load PCM list
		pop	af			; 3 10		; clear af
		push	af			; 3 11		; push stack back
		dec	sp			; 1 06		; skip over pitch quotient (do NOT clear it)
		dec	sp			; 1 06		; ''
		push	af			; 3 11		; clear pitch dividend current

		ld	sp,PCM1_Switch		; 2 10		; load PCM switch list address
		ld	hl,PCM1_BankCur		; 2 10		; load current bank window address
		ld	b,(PCM1_SwitStack-PCM1_Switch)/2 ; 2 07	; set number of bits to write
		rst	Switch_PCM		; 3 11		; switch the PCM window address instructions

		ld	hl,PCM1_NewRET		; 10		; load return address
		ld	(hl),011000010b		; 10		; change instruction back to "JP NZ"
		ld	c,080h			; 07		; restore 80 to c
		xor	a			; 04		; set Z flag (for "jr  nz" instruction)
		jp	(hl)			; 04		; return to address

; ===========================================================================
; ---------------------------------------------------------------------------
; 68K SET - routine to load a new sample 2
; ---------------------------------------------------------------------------

PCM2_NewSample:
		ld	bc,(PCM2_Sample)	; 20		; load sample address to current address
		ld	(PCM2_SampCur),bc	; 20		; (68k to z80)
		ld	a,(PCM2_Bank)		; 13		; load bank address to current address
		ld	(PCM2_BankCur),a	; 13		; (68k to z80)

		ld	sp,PCM2_List		; 2 10		; load PCM list
		pop	af			; 3 10		; clear af
		push	af			; 3 11		; push stack back
		dec	sp			; 1 06		; skip over pitch quotient (do NOT clear it)
		dec	sp			; 1 06		; ''
		push	af			; 3 11		; clear pitch dividend current

		ld	sp,PCM2_Switch		; 2 10		; load PCM switch list address
		ld	hl,PCM2_BankCur		; 2 10		; load current bank window address
		ld	b,(PCM2_SwitStack-PCM2_Switch)/2 ; 2 07	; set number of bits to write
		rst	Switch_PCM		; 3 11		; switch the PCM window address instructions

		ld	hl,PCM2_NewRET		; 10		; load return address
		ld	(hl),011000010b		; 10		; change instruction back to "JP NZ"
		ld	c,080h			; 07		; restore 80 to c
		xor	a			; 04		; set Z flag (for "jr  nz" instruction)
		jp	(hl)			; 04		; return to address

; ===========================================================================
; ---------------------------------------------------------------------------
; Sample information variables
; ---------------------------------------------------------------------------

	; --- Z80 controlled ---

PCM1_BankCur:	db	000h			; PCM 1 current sample bank address
PCM1_SampCur:	dw	08000h			; PCM 1 current sample window address
PCM1_PitchMain:	dw	000FFh			; PCM 1 pitch dividend main (and counter for c register for "ldi" instruction)
PCM1_PitchCur:	dw	00000h			; PCM 1 pitch dividend current
PCM1_PitchQuo:	dw	00000h			; PCM 1 pitch quotient
PCM1_List:	dw	00000h			; blank word to pop before pushing

PCM2_BankCur:	db	000h			; PCM 1 current sample bank address
PCM2_SampCur:	dw	08000h			; PCM 2 current sample window address
PCM2_PitchMain:	dw	000FFh			; PCM 2 pitch dividend main (and counter for c register for "ldi" instruction)
PCM2_PitchCur:	dw	00000h			; PCM 2 pitch dividend current
PCM2_PitchQuo:	dw	00000h			; PCM 2 pitch quotient
PCM2_List:	dw	00000h			; blank word to pop before pushing

	; --- Requested by 68k ---

PCM1_Sample:	dw	00000h			; PCM 1 requested sample
PCM1_Bank:	db	000000000b		; PCM 1 requested bank
PCM1_Loop:	db	000000000b		; PCM 1 loop flag
PCM2_Sample:	dw	00000h			; PCM 2 requested sample
PCM2_Bank:	db	000000000b		; PCM 2 requested bank
PCM2_Loop:	db	000000000b		; PCM 2 loop flag

; ===========================================================================
; ---------------------------------------------------------------------------
; "Mute Sample" pointer into 68k memory
; ---------------------------------------------------------------------------

MuteSample:	dw	00000h			; sample window address
		db	000h			; sample bank address

YM_Access:	db	000h
YM_Point68k:	dw	YM_List+E_CueSize
YM_PointZ80:	dw	YM_List

; ===========================================================================
; ---------------------------------------------------------------------------
; PCM buffer (1000h = end of buffer, keep it in multiples of 100)
; ---------------------------------------------------------------------------

		align	E_CueStart-E_PCM_BuffSize
PCM_Buffer:	rept	E_PCM_BuffSize
		db	000h
		endr

; ===========================================================================
; ---------------------------------------------------------------------------
; The YM2612 operator writing list (68k writes here, z80 must flush off)
; ---------------------------------------------------------------------------

YM_List:	rept	(E_CueFinish-E_CueStart)/004h
		dw	00040h			; Swapped, so the 68k can write the low byte, and immediately increment to the address/data bytes
		dw	02600h
		endr

; ===========================================================================




