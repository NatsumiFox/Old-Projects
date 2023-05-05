; ===========================================================================
; ---------------------------------------------------------------------------
; Mundi Decompression Algoritm
; ---------------------------------------------------------------------------
MundiHuff	=	EMM_Huffman	; $210 bytes for huffman tree/split data
; ---------------------------------------------------------------------------
COUNTBITS	macro
		dbf	d1,+					; decrease bitfield counter
		move.b	(a0)+,d0				; load next 8 bits
		addq.w	#$08,d1					; restore counter to maximum
+
		endm
; ---------------------------------------------------------------------------
; Long huffman loading chain
; ---------------------------------------------------------------------------

	rept	$80
		move.l	d3,(a2)+
	endm
MD_WriteHuff:	rts						; return

; ---------------------------------------------------------------------------
; Unpacking the huffman tree
; ---------------------------------------------------------------------------

MunDec:
		movem.l	d0-d4/a2-a3,-(sp)			; store register data
		lea	(MundiHuff).w,a2			; load huffman tree/buffer
		tst.l	$208(a2)				; is there an address of previously split data?
		beq.s	MD_NoContionue				; if not, branch to do it brand new
		movem.l	$200(a2),d0-d1/a0-a1			; load details about the last decompression
		COUNTBITS
		jmp	MD_Start				; continue decompression

MD_NoContionue:
		clr.w	(a1)					; clear first word (to be used to unpack huffman tree)
		move.b	(a0)+,(a1)				; load bitfield/huffman counter
		move.w	(a1),d0					; ''
		move.b	(a0)+,d0				; ''
		rol.w	#$03,d0					; shift bitfield into place
		move.b	d0,d1					; get huffman counter
		andi.w	#%00000111,d1				; ''
		eor.w	d1,d0					; clear these bits in the bitfield
		move.w	#($FF80<<1)&$FFFF,d2			; prepare huffman distance
		tst.w	d1					; if there is only 1 entry, branch
		beq.s	MD_LastHuff				; ''

MD_LoadHuff:
		addq.w	#$01,(a1)				; increase huffman counters (for skipping bitfield bits quickly)
		asr.w	#$01,d2					; reduce distance by x2

MD_LastHuff:
		move.b	(a0)+,(a1)				; convert huffman byte to a pair of words
		move.l	(a1),d3					; '' (the lower byte doesn't matter since it'll get overwritten later)
		move.w	(a1),d3					; ''
		jsr	MD_WriteHuff(pc,d2.w)			; copy entry to huffman table
		subq.w	#$01,d1					; decrease counter
		bgt.s	MD_LoadHuff				; repeat for all entries in the huffman tree (except last)
		beq.s	MD_LastHuff				; last huffman has same number of bits as the previous...
		lea	(MundiHuff).w,a2			; reload huffman tree/buffer
		moveq	#($08-3)-1,d1				; prepare bitfield counter
		jmp	MD_Start				; continue into loop

; ---------------------------------------------------------------------------
; The decompression itself
; ---------------------------------------------------------------------------

	rept	$100
		move.w	(a3)+,(a1)+				; copy data forwards
	endm
MD_CopyWords:

MD_Start:
		add.w	d0,d0					; get next bit
		bcc.s	MD_LZSS					; if the data is not huffman, branch

	; --- Huffman ---

MD_Huffman:
		COUNTBITS
		moveq	#$00,d2					; clear d2
		move.w	d0,(a1)					; copy bitfield to d2 lower byte
		move.b	(a1),d2					; ''
		add.w	d2,d2					; multiply by size of word
		move.w	(a2,d2.w),d2				; load correct upper byte
		lsl.w	d2,d0					; skip huffman bits
		sub.b	d2,d1					; decrease bitfield counter
		bpl.s	MD_NoCorrectField			; if the field doesn't need reloading, branch
		not.b	d1					; reverse to positive (get number of bits that overflowed)
		moveq	#$00,d3					; load next bitfield
		move.b	(a0)+,d3				; ''
		lsl.w	d1,d3					; shift it into the correct position
		or.w	d3,d0					; fuse with current bitfield
		subq.w	#$07,d1					; reverse counter (so it resembles the correct number of bits)
		neg.w	d1					; ''

MD_NoCorrectField:
		move.b	(a0)+,d2				; load lower byte
		move.w	d2,(a1)+				; save to output
		add.w	d0,d0					; get next bit
		bcs.s	MD_Huffman				; if the data is huffman, branch

	; --- LZSS ---

MD_LZSS:
		COUNTBITS
		add.w	d0,d0					; get next bit
		bcc.s	MD_Inc					; if it's not LZ compressed, branch

MD_LZSS_Run:
		COUNTBITS
		moveq	#-1,d2					; prepare negative
		move.b	(a0)+,d2				; load retrace amount
		add.w	d2,d2					; multiply by size of mword
		lea	(a1,d2.w),a3				; load retrace position
		swap	d2					; prepare negative again
		add.b	(a0)+,d2				; load copy amount and subtract 1 from it
		bcc.s	MD_Finish				; if the copy is 00 (copy 1 word), then branch (this is a finish flag)
		add.w	d2,d2					; multiply by size of move.w instruction
		jmp	MD_CopyWords(pc,d2.w)			; LZ copy data...

MD_Finish:
		lea	$200(a2),a2				; load storage section
		add.w	d0,d0					; get next bit
		bcs.s	MD_Split				; if the data isn't split, branch
		suba.l	a0,a0					; clear source address

MD_Split:
		movem.l	d0-d1/a0-a1,(a2)			; store registers in huffman storage space
		movem.l	(sp)+,d0-d4/a2-a3			; restore register data
		rts						; return

	; --- Increment mode ---

MD_Inc:
		COUNTBITS
		add.w	d0,d0					; get next bit
		bcc.s	MD_Unc					; if it's uncompressed, branch

MD_Inc_Run:
		COUNTBITS
		move.b	(a0)+,d4				; load increment amount
		ext.w	d4					; extend to word increment
		moveq	#$00,d3					; clear d3
		move.b	(a0)+,d3				; load number of times to increment
		addq.w	#$02-1,d3				; set minimum of 2 to be worth the hassle
		move.w	-$02(a1),d2				; load previous word that was written

MD_IncLoop:
		add.w	d4,d2					; increment
		move.w	d2,(a1)+				; save incremented word
		dbf	d3,MD_IncLoop				; repeat for number of words to increment
		add.w	d0,d0					; get next bit
		bcs.w	MD_Huffman				; if the data is huffman, branch
		COUNTBITS
		add.w	d0,d0					; get next bit
		bcs.s	MD_LZSS_Run				; if it's LZ compressed, branch
		COUNTBITS
		add.w	d0,d0					; get next bit
		bcs.s	MD_Inc_Run				; if it's not uncompressed, branch

	; --- Uncompressed ---

MD_Unc:
		COUNTBITS
		move.b	(a0)+,(a1)+				; load uncompressed word
		move.b	(a0)+,(a1)+				; ''
		add.w	d0,d0					; get next bit
		bcs.w	MD_Huffman				; if the data is huffman, branch
		bra.w	MD_LZSS					; otherwise, do LZSS

; ===========================================================================
