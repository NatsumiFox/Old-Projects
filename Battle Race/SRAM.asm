; ===========================================================================
; ---------------------------------------------------------------------------
; Initialising SRAM
; ---------------------------------------------------------------------------
SRAM_SEED	=	%0100100100100100
; ---------------------------------------------------------------------------
SRAM_OPTIONS	=	$0000				; byte	; options
SRAM_MUSEUM	=	$01C0				;   3F	; Museum data storage
; ---------------------------------------------------------------------------

SRAM_Reset:
	rts
		movea.l	(SRAMStart).w,a1	; load SRAM start address
		move.l	(SRAMFinish).w,d2	; get size of SRAM
		sub.l	a1,d2			; ''
		addq.w	#$01,a1			; advance to odd address
		lsr.l	#$01,d2			; get actual size
		subq.w	#1+1,d2			; minus for dbf and sum
		move.w	#SRAM_SEED,d3		; prepare seed
		move.b	#$01,($A130F1).l	; switch to SRAM

SR_NextByte:
		rol.w	d3,d3			; rotate (since the value to XOR is 0, no need for XOR nor storing)
		move.b	d3,(a1)			; save SRAM value
		addq.w	#$02,a1			; advance to next address
		dbf	d2,SR_NextByte		; repeat until the entire of SRAM has been processed
		lsr.w	#$08,d3			; get only the sum
		move.b	d3,(a1)			; save sum
		move.b	#$00,($A130F1).l	; switch to ROM

	; save default data here please...

		moveq	#%10100111,d0		; default options
		move.w	#SRAM_OPTIONS,d1	; address to save
				; continue to..	; save byte to address

; ===========================================================================
; ---------------------------------------------------------------------------
; Saving a byte to SRAM
; --- input -----------------------------------------------------------------
; d0.b = Byte to save
; d1.w = Address to save to
; ---------------------------------------------------------------------------

SRAM_Save:
	rts
		movem.l	d1-d4/a1,-(sp)		; store register data
		move.l	(SRAMFinish).w,d2	; load SRAM end address
		move.l	d2,a1			; ''
		sub.l	(SRAMStart).w,d2	; get size
		lsr.l	#$01,d2			; divide size by 2 (peripheral size)
		subq.w	#$01,d2			; minus 1 for dbf
		cmp.w	d1,d2			; is the address out of range?
		bhi.s	SS_Valid		; if not, branch
		movem.l	(sp)+,d1-d4/a1		; store register data
		rts				; return (address out of range)

SS_Valid:
		subq.w	#1+1,d2			; minus 2 (for seed byte, and first byte
		move.b	#$01,($A130F1).l	; switch to SRAM
		move.b	-$01(a1),d3		; load ending seed
		lsl.w	#$08,d3			; ''
		subq.w	#$03,a1			; move into data
		subi.w	#$200-1,d1		; reverse address
		neg.w	d1			; ''
		move.b	(a1),d4			; load seed
		subq.w	#$01,d1			; decrease address
		bcc.s	SS_NextByte		; if this is not the address, branch
		move.b	d4,d3			; reset seed
		addq.w	#$02,a1			; restore address
		bra.s	SS_FoundAddress		; continue to save and encrypt

SS_NextByte:
		move.b	d4,d3			; set seed
		subq.w	#$02,a1			; move back
		move.b	(a1),d4			; load next seed
		ror.w	d4,d3			; rotate
		eor.b	d4,d3			; get value
		subq.w	#$01,d1			; decrease address
		bcc.s	SS_NotAddress		; if this is not the address, branch
		move.b	d4,d3			; reset seed
		addq.w	#$02,a1			; restore address
		bra.s	SS_FoundAddress		; continue to save and encrypt

SS_NotAddress:
		move.b	d3,$02(a1)		; store unencrypted byte (for now)
		dbf	d2,SS_NextByte		; repeat until all data has been processed
		move.b	d4,d3			; set seed
		move.b	#SRAM_SEED&$FF,d4	; get first seed
		ror.w	d4,d3			; rotate
		eor.b	d4,d3			; get value
		move.b	d4,d3			; reset seed
		bra.s	SS_FoundAddress		; continue to save and encrypt

SS_NextAddress:
		move.b	(a1),d0			; load stored byte

SS_FoundAddress:
		move.b	d3,d4			; store seed for rotation
		eor.b	d0,d3			; xor unencrypted byte
		rol.w	d4,d3			; rotate bits
		move.b	d3,(a1)			; store encrypted byte
		addq.w	#$02,a1			; advance to next address
		addq.w	#$01,d2			; increase memory address
		cmpi.w	#$200-2,d2		; is this the end of SRAM?
		blo.s	SS_NextAddress		; if not, branch
		lsr.w	#$08,d3			; get upper byte seed
		move.b	d3,(a1)			; save to SRAM
		move.b	#$00,($A130F1).l	; switch to ROM
		movem.l	(sp)+,d1-d4/a1		; store register data
		rts				; return (Address is out of bounds)

; ===========================================================================
; ---------------------------------------------------------------------------
; Initialising SRAM on first run
; ---------------------------------------------------------------------------
; Since SRAM_Load already does a full encryption check when loading the byte
; a simple call to load a byte from anywhere in SRAM will do, we simply just
; ignore the return byte
; ---------------------------------------------------------------------------

SRAM_Init:
	rts
		move.w	#SRAM_OPTIONS,d1	; set address to load from
		bsr.s	SRAM_Load		; load the byte
		move.b	d0,(OptBits_Menu).w	; load options mode
		rts				; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Loading a byte from SRAM
; --- input -----------------------------------------------------------------
; d1.w = Address to load from
; --- output ----------------------------------------------------------------
; d0.b = Byte loaded
; ---------------------------------------------------------------------------

SRAM_Load:
	rts
		movem.l	d1-d4/a1,-(sp)		; store register data
		move.l	(SRAMFinish).w,d2	; load SRAM end address
		move.l	d2,a1			; ''
		sub.l	(SRAMStart).w,d2	; get size
		lsr.l	#$01,d2			; divide size by 2 (peripheral size)
		move.b	-$01(a1),d3		; load ending seed
		lsl.w	#$08,d3			; ''
		subq.w	#$03,a1			; move into data
		subq.w	#$01,d2			; minus 1 for dbf
		cmp.w	d1,d2			; is the address in range of SRAM?
		bls.s	SL_OutOfRange		; if not, branch
		subq.w	#1+1,d2			; minus 2 (for seed byte, and first byte)
		subi.w	#$200-1,d1		; reverse address
		neg.w	d1			; ''
		move.b	#$01,($A130F1).l	; switch to SRAM
		move.b	(a1),d4			; load seed
		subq.w	#$01,d1			; decrease address
		bcc.s	SL_NextByte		; if this is not the address, branch
		move.b	d4,d0			; copy to return register

SL_NextByte:
		move.b	d4,d3			; set seed
		subq.w	#$02,a1			; move back
		move.b	(a1),d4			; load next seed
		ror.w	d4,d3			; rotate
		eor.b	d4,d3			; get value
		subq.w	#$01,d1			; decrease address
		bcc.s	SL_NotAddress		; if this is not the address, branch
		move.b	d3,d0			; copy to return register

SL_NotAddress:
		dbf	d2,SL_NextByte		; repeat until all data has been processed
		move.b	#$00,($A130F1).l	; switch to ROM
		move.b	d4,d3			; set seed
		move.b	#SRAM_SEED&$FF,d4	; get first seed
		ror.w	d4,d3			; rotate
		eor.b	d4,d3			; get value
		subq.w	#$01,d1			; decrease address
		bcc.s	SL_NotFirst		; if this is not the address, branch
		move.b	d3,d0			; copy to return register

SL_NotFirst:
		move.b	d4,d3			; set seed
		cmp.w	#SRAM_SEED,d3		; does the seed match
		beq.s	SL_Valid		; if so, branch
		bsr.w	SRAM_Reset		; reset entire SRAM
		movem.l	(sp)+,d1-d4/a1		; restore register data
		bra.s	SRAM_Load		; try to reload the byte again...

SL_OutOfRange:
		sf.b	d0			; clear return byte
		andi.b	#%11011,ccr		; clear Z flag (set non-zero)

SL_Valid:
		movem.l	(sp)+,d1-d4/a1		; store register data
		rts				; return

; ===========================================================================