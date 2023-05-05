; ===========================================================================
; ---------------------------------------------------------------------------
; Mega Drive Z80 ROM
; ---------------------------------------------------------------------------
; AS shit
; ---------------------------------------------------------------------------

		cpu z80						; Assemble z80 functions
		listing off					; Turn off listings
		phase	0					; Set offset to $0000

; ===========================================================================
; ---------------------------------------------------------------------------
; Start of ROM
; ---------------------------------------------------------------------------

Start:
		di				; 4		; disable the interrupts
		ld	sp,00FF0h		; 10		; set stack pointer address

		ld	bc,04000h		; 10		; load YM2612 address port
		ld	de,04001h		; 10		; load YM2612 data port

		ld	a,02Bh			; 7		; set DAC switch address
		ld	(bc),a			; 7		; ''
		ld	a,080h			; 7		; enable DAC channel (disable FM 6)
		ld	(de),a			; 7		; ''
		ld	a,02Ah			; 7		; set DAC port address
		ld	(bc),a			; 7		; ''
		ld	a,080h			; 7		; save null byte
		ld	(de),a			; 7		; ''

		ld	c,000h			; 7		; clear bank address
		ld	hl,Tracker		; 10		; load tracker address
		exx				; 4		; load 2nd registers
		ld	bc,01000h		; 10		; set in-buffer address
		ld	de,01000h		; 10		; set out-buffer address

Start_WaitPlay:
		ld	a,(00FF1h)		; 13		; load play flag
		or	a			; 4		; has it been set?
		jr	z,Start_WaitPlay	; 7 N | 12 Y	; if not, branch
		jr	CU_Tracker		; 12		; continue

; ---------------------------------------------------------------------------
; Catch-up mode
; ---------------------------------------------------------------------------

CU_Flush:
		jp	Flush			; 10		; continue to flush mode

CU_Tracker:
		call	ReadTracker		; 17		; read the tracker data

CatchUp_NoZ:
		or	001h			; 7		; set non-zero flag

CatchUp:
	message "JP offset 1 = \{CatchUp}"
		jr	z,CU_Flush		; 7 N | 12 Y	; replace-able jr instruction (For DMA)
		ld	a,(hl)			; 7		; load PCM byte
		or	a			; 4		; is this the end of the sample?
		jr	z,CU_Tracker		; 7 N | 12 Y	; if so, branch
		ld	(bc),a			; 7		; save to in-buffer
		inc	l			; 4		; advance PCM address
		jr	z,CU_Rebank01		; 7 N | 12 Y	; if reached finish, branch
CU_Rebank01Ret:
		inc	c			; 4		; increase in-buffer address
		jr	z,CU_Wrap01		; 7 N | 12 Y	; if reached finish, branch
CU_Wrap01Ret:
		ld	a,c			; 4		; load lower byte
		sub	e			; 4		; check position
		jr	z,CU_CheckFinish	; 7 N | 12 Y	; if matched, branch
CU_NoFinish:
	message "JP offset 2 = \{CU_NoFinish}"
		jr	z,CU_Flush		; 7 N | 12 Y	; replace-able jr instruction (For DMA)
		ld	a,(hl)			; 7		; load PCM byte
		or	a			; 4		; is this the end of the sample?
		jr	z,CU_Tracker		; 7 N | 12 Y	; if so, branch
		ld	(bc),a			; 7		; save to in-buffer
		inc	l			; 4		; advance PCM address
		jr	z,CU_Rebank02		; 7 N | 12 Y	; if reached finish, branch
CU_Rebank02Ret:
		inc	c			; 4		; increase in-buffer address
		jr	z,CU_Wrap02		; 7 N | 12 Y	; if reached finish, branch
CU_Wrap02Ret:
		ld	a,(de)			; 7		; load from out-buffer
		ld	(04001h),a		; 13		; save to YM2612 DAC port
		inc	e			; 4		; increase out-buffer address
		jp	nz,CatchUp		; 10 N & Y	; if not reached finish, branch
		inc	d			; 4		; advance out-buffer address
		ld	a,d			; 4		; copy to a
		and	00Fh			; 7		; wrap
		or	010h			; 7		; ''
		ld	d,a			; 4		; save back
		jp	CatchUp_NoZ		; 10		; return

	; --- Wrapping bc ---

CU_Wrap01:
		inc	b			; 4		; advance in-buffer address
		ld	a,b			; 4		; copy to a
		and	00Fh			; 7		; wrap
		or	010h			; 7		; ''
		ld	b,a			; 4		; save back
		jp	CU_Wrap01Ret		; 10		; return

	; --- Wrapping bc ---

CU_Wrap02:
		inc	b			; 4		; advance in-buffer address
		ld	a,b			; 4		; copy to a
		and	00Fh			; 7		; wrap
		or	010h			; 7		; ''
		ld	b,a			; 4		; save back
		jp	CU_Wrap02Ret		; 10		; return

	; --- Rebanking sample address ---

CU_Rebank01:
		inc	h			; 4		; advance PCM address
		jp	nz,CU_Rebank01Ret	; 10 N & Y	; if not finish, branch
		exx				; 4		; load 1st registers
		inc	c			; 4		; increase bank address
		ld	a,c			; 4		; copy to a
		ld	de,06000h		; 10		; load bank port address
		ld	(de),a			; 7		; set address
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		xor	a			; 4		; clear a (last bit signifies +8MB)
		ld	(de),a			; 7		; ''
		exx				; 4		; load 2nd registers
		ld	hl,08000h		; 10		; reset hl
		jp	CU_Rebank01Ret		; 10		; return

	; --- Rebanking sample address ---

CU_Rebank02:
		inc	h			; 4		; advance PCM address
		jp	nz,CU_Rebank02Ret	; 10 N & Y	; if not finish, branch
		exx				; 4		; load 1st registers
		inc	c			; 4		; increase bank address
		ld	a,c			; 4		; copy to a
		ld	de,06000h		; 10		; load bank port address
		ld	(de),a			; 7		; set address
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		xor	a			; 4		; clear a (last bit signifies +8MB)
		ld	(de),a			; 7		; ''
		exx				; 4		; load 2nd registers
		ld	hl,08000h		; 10		; reset hl
		jp	CU_Rebank02Ret		; 10		; return

	; --- Checking for full buffer ---

CU_CheckFinish:
		ld	a,b			; 4		; load upper byte
		sub	d			; 4		; check position matches
		jr	nz,CU_NoFinish		; 7 N | 12 Y	; if they don't match, branch
		jp	BU_Continue		; 10		; continue

; ---------------------------------------------------------------------------
; Buffering mode
; ---------------------------------------------------------------------------

BU_Tracker:
		call	ReadTracker		; 17		; read the tracker data

Buffer:
		ld	a,(00FF0h)		; 13		; load DMA flag
		or	a			; 4		; is DMA about to occur?
		jr	nz,Flush		; 7 N | 12 Y	; if so, branch to flushing mode
		ld	a,(hl)			; 7		; load PCM byte
		or	a			; 4		; is this the end of the sample?
		jr	z,BU_Tracker		; 7 N | 12 Y	; if so, branch
		ld	(bc),a			; 7		; save to in-buffer
		inc	l			; 4		; advance PCM address
		jr	z,BU_Rebank		; 7 N | 12 Y	; if reached finish, branch
BU_RebankRet:
		inc	c			; 4		; increase in-buffer address
		jr	z,BU_Wrap		; 7 N | 12 Y	; if reached finish, branch
BU_WrapRet:
	; --- Delay ---
		exx				; 4		; load 1st registers
		rept	00Ch					; Delay
		nop				; 4		; ''
		endm						; ''
		exx				; 4		; load 2nd registers
	; --- --- --- ---

BU_Continue:
		ld	a,(de)			; 7		; load from out-buffer
		ld	(04001h),a		; 13		; save to YM2612 DAC port
		inc	e			; 4		; increase out-buffer address
		jp	nz,Buffer		; 10 N & Y	; if reached finish, branch
		inc	d			; 4		; advance out-buffer address
		ld	a,d			; 4		; copy to a
		and	00Fh			; 7		; wrap
		or	010h			; 7		; ''
		ld	d,a			; 4		; save back
		jp	Buffer			; 10		; return

	; --- Wrapping bc ---

BU_Wrap:
		inc	b			; 4		; advance in-buffer address
		ld	a,b			; 4		; copy to a
		and	00Fh			; 7		; wrap
		or	010h			; 7		; ''
		ld	b,a			; 4		; save back
		jp	BU_WrapRet		; 10		; return

	; --- Rebanking sample address ---

BU_Rebank:
		inc	h			; 4		; advance PCM address
		jp	nz,BU_RebankRet		; 10 N & Y	; if not finish, branch
		exx				; 4		; load 1st registers
		inc	c			; 4		; increase bank address
		ld	a,c			; 4		; copy to a
		ld	de,06000h		; 10		; load bank port address
		ld	(de),a			; 7		; set address
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		xor	a			; 4		; clear a (last bit signifies +8MB)
		ld	(de),a			; 7		; ''
		exx				; 4		; load 2nd registers
		ld	hl,08000h		; 10		; reset hl
		jp	BU_RebankRet		; 10		; continue

; ---------------------------------------------------------------------------
; Flush mode
; ---------------------------------------------------------------------------

FL_Continue:
		ld	a,e			; 4		; load lower byte
		sub	c			; 4		; subtract in-buffer?
		jp	nz,Flush		; 10 N & Y	; if they don't match, branch
		ld	a,d			; 4		; load upper byte
		sub	b			; 4		; have we reached end of buffer?
		jr	z,Direct		; 7 N | 12 Y	; if so, branch

Flush:
		ld	a,(00FF0h)		; 13		; load DMA flag
		or	a			; 4		; is DMA no longer to occur?
		jp	z,CatchUp_NoZ		; 10 N & Y	; if so, branch to catch up mode

		ld	a,(de)			; 7		; load from out-buffer
		ld	(04001h),a		; 13		; save to YM2612 DAC port
	; --- Delay ---
		exx				; 4		; load 1st registers
		rept	010h					; Delay
		nop				; 4		; ''
		endm						; ''
		inc	de			; 6		; extra delay (need a 3 delay that nop cannot supply)
		ld	e,000h			; 7		; ''
		exx				; 4		; load 2nd registers
	; --- --- --- ---
		inc	e			; 4		; increase out-buffer address
		jp	nz,FL_Continue		; 10 N & Y	; if reached finish, branch
		inc	d			; 4		; advance out-buffer address
		ld	a,d			; 4		; copy to a
		and	00Fh			; 7		; wrap
		or	010h			; 7		; ''
		ld	d,a			; 4		; save back
		jp	FL_Continue		; 10		; return

; ---------------------------------------------------------------------------
; Direct mode
; ---------------------------------------------------------------------------

DI_Tracker:
		call	ReadTracker		; 17		; read the tracker data

Direct:
		ld	a,(00FF0h)		; 13		; load DMA flag
		or	a			; 4		; is DMA no longer to occur?
		jp	z,CatchUp_NoZ		; 10 N & Y	; if so, branch to catch up mode
		ld	a,(hl)			; 7		; load PCM byte
		or	a			; 4		; is this the end of the sample?
		jr	z,DI_Tracker		; 7 N | 12 Y	; if so, branch
		ld	(04001h),a		; 13		; save to YM2612 DAC port
		inc	l			; 4		; advance PCM address
		jr	z,DI_Rebank		; 7 N | 12 Y	; if reached finish, branch
DI_RebankRet:
	; --- Delay ---
		exx				; 4		; load 1st registers
		rept	011h					; Delay
		nop				; 4		; ''
		endm						; ''
		inc	de			; 6		; extra delay (need a 3 delay that nop can not supply)
		exx				; 4		; load 2nd registers
	; --- --- --- ---
		jp	Direct			; 10		; continue

	; --- Rebanking sample address ---

DI_Rebank:
		inc	h			; 4		; advance PCM address
		jp	nz,DI_RebankRet		; 10 N & Y	; if not finish, branch
		exx				; 4		; load 1st registers
		inc	c			; 4		; increase bank address
		ld	a,c			; 4		; copy to a
		ld	de,06000h		; 10		; load bank port address
		ld	(de),a			; 7		; set address
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		xor	a			; 4		; clear a (last bit signifies +8MB)
		ld	(de),a			; 7		; ''
		exx				; 4		; load 2nd registers
		ld	hl,08000h		; 10		; reset hl
		jp	DI_RebankRet		; 10		; continue

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to read the tracker
; ---------------------------------------------------------------------------

ReadTracker:
		exx				; 4		; load 2nd registers
		jp	RT_Read			; 10		; continue

RT_Loop:
		ld	a,(hl)			; 7		; load lower byte
		inc	hl			; 6		; advance tracker address
		ld	h,(hl)			; 7		; save upper byte
		ld	l,a			; 4		; save lower byte

RT_Read:
		ld	a,(hl)			; 7		; load instruction
		inc	hl			; 6		; advance tracker address
		or	a			; 4		; is this a loop instruction?
		jr	nz,RT_Loop		; 7 N | 12 Y	; if so, branch
		ld	a,(hl)			; 7		; load bank address
		inc	hl			; 6		; advance tracker address
		ld	c,a			; 13		; store bank address
		ld	de,06000h		; 10		; load bank port address
		ld	(de),a			; 7		; set address
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		rrca				; 4		; ''
		ld	(de),a			; 7		; ''
		xor	a			; 4		; clear a (last bit signifies +8MB)
		ld	(de),a			; 7		; ''
		ld	e,(hl)			; 7		; load lower byte
		inc	hl			; 6		; advance tracker address
		ld	d,(hl)			; 7		; save upper byte
		inc	hl			; 6		; advance tracker address
		push	de			; 11		; store sample address
		exx				; 4		; load 1st registers
		pop	hl			; 10		; load sample address
		ret				; 10		; return

; ===========================================================================
; ---------------------------------------------------------------------------
; End of ROM
; ---------------------------------------------------------------------------

Tracker:

; ===========================================================================












