; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||
; ---------------------------------------------------------------------------
; KOSINSKI DECOMPRESSION PROCEDURE
; (sometimes called KOZINSKI decompression)
;
; ARGUMENTS:
; a0 = source address
; a1 = destination address
;
; For format explanation see http://info.sonicretro.org/Kosinski_compression
; New faster version by written by vladikcomper, with additional improvements by
; MarkeyJester and Flamewing
; ---------------------------------------------------------------------------
_Kos_UseLUT = 1
_Kos_LoopUnroll = 1
_Kos_ExtremeUnrolling = 0

_Kos_RunBitStream macro
	dbra	d2,@skip\@
	moveq	#7,d2				; Set repeat count to 8.
	move.b	d1,d0				; Use the remaining 8 bits.
	not.w	d3				; Have all 16 bits been used up?
	bne.s	@skip\@				; Branch if not.
	move.b	(a0)+,d0			; Get desc field low-byte.
	move.b	(a0)+,d1			; Get desc field hi-byte.
	if _Kos_UseLUT=1
		move.b	(a4,d0.w),d0		; Invert bit order...
		move.b	(a4,d1.w),d1		; ... for both bytes.
	endif
@skip\@
	endm

_Kos_ReadBit macro
	if _Kos_UseLUT=1
		add.b	d0,d0			; Get a bit from the bitstream.
	else
		lsr.b	#1,d0			; Get a bit from the bitstream.
	endif
	endm
; ===========================================================================

KosDec:
	moveq	#(1<<_Kos_LoopUnroll)-1,d7
	if _Kos_UseLUT=1
		moveq	#0,d0
		moveq	#0,d1
		lea	KosDec_ByteMap(pc),a4	; Load LUT pointer.
	endif
	move.b	(a0)+,d0			; Get desc field low-byte.
	move.b	(a0)+,d1			; Get desc field hi-byte.
	if _Kos_UseLUT=1
		move.b	(a4,d0.w),d0		; Invert bit order...
		move.b	(a4,d1.w),d1		; ... for both bytes.
	endif
	moveq	#7,d2				; Set repeat count to 8.
	moveq	#0,d3				; d3 will be desc field switcher.
	bra.s	@FetchNewCode

; ---------------------------------------------------------------------------
@FetchCodeLoop:
	; Code 1 (Uncompressed byte).
	_Kos_RunBitStream
	move.b	(a0)+,(a1)+

@FetchNewCode:
	_Kos_ReadBit
	bcs.s	@FetchCodeLoop			; If code = 1, branch.

	; Codes 00 and 01.
	moveq	#-1,d5
	lea	(a1),a5
	_Kos_RunBitStream
	if _Kos_ExtremeUnrolling=1
	_Kos_ReadBit
	bcs.w	@Code_01

	; Code 00 (Dictionary ref. short).
	_Kos_RunBitStream
	_Kos_ReadBit
	bcs.s	@Copy45
	_Kos_RunBitStream
	_Kos_ReadBit
	bcs.s	@Copy3
	_Kos_RunBitStream
	move.b	(a0)+,d5				; d5 = displacement.
	adda.w	d5,a5
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	bra.s	@FetchNewCode

; ---------------------------------------------------------------------------
@Copy3	_Kos_RunBitStream
	move.b	(a0)+,d5				; d5 = displacement.
	adda.w	d5,a5
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	bra.w	@FetchNewCode

; ---------------------------------------------------------------------------
@Copy45	_Kos_RunBitStream
	_Kos_ReadBit
	bcs.s	@Copy5
	_Kos_RunBitStream
	move.b	(a0)+,d5				; d5 = displacement.
	adda.w	d5,a5
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	bra.w	@FetchNewCode

; ---------------------------------------------------------------------------
@Copy5	_Kos_RunBitStream
	move.b	(a0)+,d5				; d5 = displacement.
	adda.w	d5,a5
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	bra.w	@FetchNewCode

; ---------------------------------------------------------------------------
	else
	moveq	#0,d4					; d4 will contain copy count.
	_Kos_ReadBit
	bcs.s	@Code_01

	; Code 00 (Dictionary ref. short).
	_Kos_RunBitStream
	_Kos_ReadBit
	addx.w	d4,d4
	_Kos_RunBitStream
	_Kos_ReadBit
	addx.w	d4,d4
	_Kos_RunBitStream
	move.b	(a0)+,d5				; d5 = displacement.

@StreamCopy:
	adda.w	d5,a5
	move.b	(a5)+,(a1)+				; Do 1 extra copy (to compensate +1 to copy counter).

@copy	move.b	(a5)+,(a1)+
	dbra	d4,@copy
	bra.w	@FetchNewCode
	endif

; --------------------------------------------------------------------------
@Code_01 moveq	#0,d4				; d4 will contain copy count.
	; Code 01 (Dictionary ref. long / special).
	_Kos_RunBitStream
	move.b	(a0)+,d6			; d6 = %LLLLLLLL.
	move.b	(a0)+,d4			; d4 = %HHHHHCCC.
	move.b	d4,d5				; d5 = %11111111 HHHHHCCC.
	lsl.w	#5,d5				; d5 = %111HHHHH CCC00000.
	move.b	d6,d5				; d5 = %111HHHHH LLLLLLLL.
	if _Kos_LoopUnroll=3
		and.w	d7,d4			; d4 = %00000CCC.
	else
		andi.w	#7,d4
	endif
	bne.s	@StreamCopy			; if CCC=0, branch.

	; special mode (extended counter)
	move.b	(a0)+,d4			; Read cnt
	beq.s	@Quit				; If cnt=0, quit decompression.
	subq.b	#1,d4
	beq.w	@FetchNewCode			; If cnt=1, fetch a new code.

	adda.w	d5,a5
	move.b	(a5)+,(a1)+			; Do 1 extra copy (to compensate +1 to copy counter).
	move.w	d4,d6
	not.w	d6
	and.w	d7,d6
	add.w	d6,d6
	lsr.w	#_Kos_LoopUnroll,d4
	jmp	@largecopy(pc,d6.w)

; ---------------------------------------------------------------------------
@largecopy:
	rept (1<<_Kos_LoopUnroll)
		move.b	(a5)+,(a1)+
	endr
	dbra	d4,@largecopy
	bra.w	@FetchNewCode

; ---------------------------------------------------------------------------
	if _Kos_ExtremeUnrolling=1
@StreamCopy:
	adda.w	d5,a5
	move.b	(a5)+,(a1)+			; Do 1 extra copy (to compensate +1 to copy counter).
	if _Kos_LoopUnroll=3
		eor.w	d7,d4
	else
		eori.w	#7,d4
	endif
	add.w	d4,d4
	jmp	@mediumcopy(pc,d4.w)

; ---------------------------------------------------------------------------
@mediumcopy:
	rept 8
		move.b	(a5)+,(a1)+
	endr
	bra.w	@FetchNewCode
	endif
		move.b	(a5)+,(a1)+

; ---------------------------------------------------------------------------
@Quit	rts					; End of function KosDec.

; ===========================================================================
	if _Kos_UseLUT=1
KosDec_ByteMap:
	dc.b	$00,$80,$40,$C0,$20,$A0,$60,$E0,$10,$90,$50,$D0,$30,$B0,$70,$F0
	dc.b	$08,$88,$48,$C8,$28,$A8,$68,$E8,$18,$98,$58,$D8,$38,$B8,$78,$F8
	dc.b	$04,$84,$44,$C4,$24,$A4,$64,$E4,$14,$94,$54,$D4,$34,$B4,$74,$F4
	dc.b	$0C,$8C,$4C,$CC,$2C,$AC,$6C,$EC,$1C,$9C,$5C,$DC,$3C,$BC,$7C,$FC
	dc.b	$02,$82,$42,$C2,$22,$A2,$62,$E2,$12,$92,$52,$D2,$32,$B2,$72,$F2
	dc.b	$0A,$8A,$4A,$CA,$2A,$AA,$6A,$EA,$1A,$9A,$5A,$DA,$3A,$BA,$7A,$FA
	dc.b	$06,$86,$46,$C6,$26,$A6,$66,$E6,$16,$96,$56,$D6,$36,$B6,$76,$F6
	dc.b	$0E,$8E,$4E,$CE,$2E,$AE,$6E,$EE,$1E,$9E,$5E,$DE,$3E,$BE,$7E,$FE
	dc.b	$01,$81,$41,$C1,$21,$A1,$61,$E1,$11,$91,$51,$D1,$31,$B1,$71,$F1
	dc.b	$09,$89,$49,$C9,$29,$A9,$69,$E9,$19,$99,$59,$D9,$39,$B9,$79,$F9
	dc.b	$05,$85,$45,$C5,$25,$A5,$65,$E5,$15,$95,$55,$D5,$35,$B5,$75,$F5
	dc.b	$0D,$8D,$4D,$CD,$2D,$AD,$6D,$ED,$1D,$9D,$5D,$DD,$3D,$BD,$7D,$FD
	dc.b	$03,$83,$43,$C3,$23,$A3,$63,$E3,$13,$93,$53,$D3,$33,$B3,$73,$F3
	dc.b	$0B,$8B,$4B,$CB,$2B,$AB,$6B,$EB,$1B,$9B,$5B,$DB,$3B,$BB,$7B,$FB
	dc.b	$07,$87,$47,$C7,$27,$A7,$67,$E7,$17,$97,$57,$D7,$37,$B7,$77,$F7
	dc.b	$0F,$8F,$4F,$CF,$2F,$AF,$6F,$EF,$1F,$9F,$5F,$DF,$3F,$BF,$7F,$FF
	endif
; =========================

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to clear KosM queue
; ---------------------------------------------------------------------------
ClearPLC:
		lea	KosMqueue+6.w,a5	; we really shouldn't clear the first entry
@len =		KosQueue-(KosMqueue+6)		; in order to avoid bugs

	rept @len/4
		clr.l	(a5)+			; clear entries
	endr

	ifne @len&2
		clr.w	(a5)
	endif
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to queue KosM PLC entries
; in
;  d0 - PLC ID
; ---------------------------------------------------------------------------
NewPLC:
		bsr.s	ClearPLC	; clear PLC first

AddPLC:
		lea	ArtLoadCues,a5
		add.w	d0,d0
		move.w	(a5,d0.w),d0
		lea	(a5,d0.w),a5

QueueRawPLC:
		move.w	(a5)+,d6	; get length of PLC
		bmi.s	@end

@entry		move.l	(a5)+,a1
		move.w	(a5)+,d2
		bsr.s	QueueKosM
		dbf	d6,@entry
@end		rts
; ---------------------------------------------------------------------------
; Adds a Kosinski Moduled archive to the module queue
; Inputs:
; a1 = address of the archive
; d2 = destination in VRAM
; ---------------------------------------------------------------------------
QueueKosM:
		lea	KosMqueue.w,a2
		tst.l	(a2)			; is the first slot free?
		beq.s	QueueKosM_Init		; if it is, branch

@slot		addq.w	#6,a2			; otherwise, check next slot
		tst.l	(a2)
		bne.s	@slot

		move.l	a1,(a2)+		; store source address
		move.w	d2,(a2)+		; store destination VRAM address
		rts

; ===========================================================================

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||
; ---------------------------------------------------------------------------
; Initializes processing of the first module on the queue
; ---------------------------------------------------------------------------
QueueKosM_Init:
		move.w	(a1)+,d3		; get uncompressed size
		cmpi.w	#$A000,d3
		bne.s	@gotsize
		move.w	#$8000,d3		; $A000 means $8000 for some reason

@gotsize	lsr.w	#1,d3
		move.w	d3,d0
		rol.w	#5,d0
		andi.w	#$1F,d0			; get number of complete modules
		move.b	d0,KosMmodNum.w
		andi.w	#KosBufLen-1,d3		; get size of last module in words
		bne.s	@gotleftover		; branch if it's non-zero
		subq.b	#1,KosMmodNum.w		; otherwise decrement the number of modules
		move.w	#KosBufLen,d3		; and take the size of the last module to be $800 words

@gotleftover	move.w	d3,KosMmodSize.w
		move.w	d2,KosMqueue+4.w
		move.l	a1,KosMqueue.w
		addq.b	#1,KosMmodNum.w		; store total number of modules
		rts
; ===========================================================================

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||
; ---------------------------------------------------------------------------
; Processes the first module on the queue
; ---------------------------------------------------------------------------
ProcKosM:
		tst.b	KosMmodNum.w
		beq.s	@exit
		bmi.s	@started
		cmpi.w	#4,KosDecQueCnt.w
		bcc.s	@exit			; branch if the Kosinski decompression queue is full

		movea.l	KosMqueue.w,a1
		lea	KosBuf.w,a2
		bsr.w	QueueKos		; add current module to decompression queue
		ori.b	#$80,KosMmodNum.w	; and set bit to signify decompression in progress
@exit		rts
; ---------------------------------------------------------------------------

@started	tst.w	KosDecQueCnt.w
		bne.s	@exit			; branch if the decompression isn't complete

	; otherwise, DMA the decompressed data to VRAM
		andi.b	#$7F,KosMmodNum.w
		move.w	#KosBufLen,d3
		subq.b	#1,KosMmodNum.w
		bne.s	@skip			; branch if it isn't the last module
		move.w	KosMmodSize.w,d3

@skip		move.w	KosMqueue+4.w,d2
		move.w	d2,d0
		add.w	d3,d0
		add.w	d3,d0
		move.w	d0,KosMqueue+4.w	; set new destination

		move.l	KosMqueue.w,d0
		move.l	KosQueue.w,d1
		sub.l	d1,d0
		andi.l	#$F,d0
		add.l	d0,d1			; round to the nearest $10 boundary
		move.l	d1,KosMqueue.w		; and set new source

		move.l	#KosBuf,d1
		jsr	QueueDMATransfer
		tst.b	KosMmodNum.w
		bne.s	@exit			; return if this wasn't the last module

		lea	KosMqueue.w,a0
		lea	KosMqueue+6.w,a1
@len =		KosQueue-(KosMqueue+6)
	rept @len/4
		move.l	(a1)+,(a0)+		; otherwise, shift all entries up
	endr

	ifne @len&2
		move.w	(a1)+,(a0)+
	endif

		moveq	#0,d0
		move.l	d0,(a0)+		; and mark the last slot as free
		move.w	d0,(a0)+

		move.l	KosMqueue.w,d0
		beq.w	@exit			; return if the queue is now empty
		movea.l	d0,a1
		move.w	KosMqueue+4.w,d2
		bra.w	QueueKosM_Init

; ===========================================================================
; ---------------------------------------------------------------------------
; Adds Kosinski-compressed data to the decompression queue
; Inputs:
; a1 = compressed data address
; a2 = decompression destination in RAM
; ---------------------------------------------------------------------------
QueueKos:
		move.w	KosDecQueCnt.w,d0
		lsl.w	#3,d0
		lea	KosQueue.w,a3

		move.l	a1,(a3,d0.w)		; store source
		move.l	a2,4(a3,d0.w)		; store destination
		addq.w	#1,KosDecQueCnt.w
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Checks if V-int occured in the middle of Kosinski queue processing
; and stores the location from which processing is to resume if it did
; ---------------------------------------------------------------------------
SaveKosVint:
		tst.w	KosDecQueCnt.w
		bpl.s	ProcKosDone		; branch if a decompression wasn't in progress
		move.l	$42(sp),d0		; check address V-int is supposed to rte to

		cmpi.l	#ProcKosMain,d0
		blo.s	ProcKosDone
		cmpi.l	#BackupKos-2,d0
		bhs.s	ProcKosDone

		move.l	d0,KosDecPos.w
		move.l	#BackupKos,$42(sp)	; force V-int to rte here instead if needed

ProcKosDone:
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Processes the first entry in the Kosinski decompression queue
; ---------------------------------------------------------------------------
ProcKos:
		tst.w	KosDecQueCnt.w
		beq.s	ProcKosDone
		bpl.s	ProcKosMain		; branch if a decompression wasnt interrupted by V-int

RestoreKos:
		movem.w	KosDecRegs.w,d0-d6
		movem.l	KosDecRegs+(2*7).w,a0-a1/a5
		move.l	KosDecPos.w,-(sp)
		move.w	KosDecSR.w,-(sp)
		moveq	#(1<<_Kos_LoopUnroll)-1,d7

		lea	KosDec_ByteMap(pc),a4	; Load LUT pointer.
		rte

; ---------------------------------------------------------------------------

ProcKosMain:
		ori.w	#$8000,KosDecQueCnt.w	; set sign bit to signify decompression in progress
		movea.l	KosQueue.w,a0
		movea.l	KosQueue+4.w,a1

	; what follows is identical to the normal Kosinski decompressor
	moveq	#(1<<_Kos_LoopUnroll)-1,d7
	if _Kos_UseLUT=1
	moveq	#0,d0
	moveq	#0,d1
	lea	KosDec_ByteMap(pc),a4		; Load LUT pointer.
	endif
	move.b	(a0)+,d0				; Get desc field low-byte.
	move.b	(a0)+,d1				; Get desc field hi-byte.
	if _Kos_UseLUT=1
	move.b	(a4,d0.w),d0			; Invert bit order...
	move.b	(a4,d1.w),d1			; ... for both bytes.
	endif
	moveq	#7,d2					; Set repeat count to 8.
	moveq	#0,d3					; d3 will be desc field switcher.
	bra.s	@FetchNewCode

; ---------------------------------------------------------------------------
@FetchCodeLoop:
	; Code 1 (Uncompressed byte).
	_Kos_RunBitStream
	move.b	(a0)+,(a1)+

@FetchNewCode:
	_Kos_ReadBit
	bcs.s	@FetchCodeLoop			; If code = 1, branch.

	; Codes 00 and 01.
	moveq	#-1,d5
	lea	(a1),a5
	_Kos_RunBitStream

	if _Kos_ExtremeUnrolling=1
	_Kos_ReadBit
	bcs.w	@Code_01

	; Code 00 (Dictionary ref. short).
	_Kos_RunBitStream
	_Kos_ReadBit
	bcs.s	@Copy45
	_Kos_RunBitStream
	_Kos_ReadBit
	bcs.s	@Copy3
	_Kos_RunBitStream
	move.b	(a0)+,d5				; d5 = displacement.
	adda.w	d5,a5
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	bra.s	@FetchNewCode

; ---------------------------------------------------------------------------
@Copy3:
	_Kos_RunBitStream
	move.b	(a0)+,d5				; d5 = displacement.
	adda.w	d5,a5
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	bra.w	@FetchNewCode

; ---------------------------------------------------------------------------
@Copy45:
	_Kos_RunBitStream
	_Kos_ReadBit
	bcs.s	@Copy5
	_Kos_RunBitStream
	move.b	(a0)+,d5				; d5 = displacement.
	adda.w	d5,a5
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	bra.w	@FetchNewCode

; ---------------------------------------------------------------------------
@Copy5:
	_Kos_RunBitStream
	move.b	(a0)+,d5				; d5 = displacement.
	adda.w	d5,a5
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	bra.w	@FetchNewCode

; ---------------------------------------------------------------------------
	else
	moveq	#0,d4					; d4 will contain copy count.
	_Kos_ReadBit
	bcs.s	@Code_01

	; Code 00 (Dictionary ref. short).
	_Kos_RunBitStream
	_Kos_ReadBit
	addx.w	d4,d4
	_Kos_RunBitStream
	_Kos_ReadBit
	addx.w	d4,d4
	_Kos_RunBitStream
	move.b	(a0)+,d5				; d5 = displacement.

@StreamCopy:
	adda.w	d5,a5
	move.b	(a5)+,(a1)+				; Do 1 extra copy (to compensate +1 to copy counter).

@copy:
	move.b	(a5)+,(a1)+
	dbra	d4,@copy
	bra.w	@FetchNewCode
	endif

; ---------------------------------------------------------------------------
@Code_01:
	moveq	#0,d4					; d4 will contain copy count.
	; Code 01 (Dictionary ref. long / special).
	_Kos_RunBitStream
	move.b	(a0)+,d6				; d6 = %LLLLLLLL.
	move.b	(a0)+,d4				; d4 = %HHHHHCCC.
	move.b	d4,d5					; d5 = %11111111 HHHHHCCC.
	lsl.w	#5,d5					; d5 = %111HHHHH CCC00000.
	move.b	d6,d5					; d5 = %111HHHHH LLLLLLLL.
	if _Kos_LoopUnroll=3
	and.w	d7,d4					; d4 = %00000CCC.
	else
	andi.w	#7,d4
	endif
	bne.s	@StreamCopy				; if CCC=0, branch.

	; special mode (extended counter)
	move.b	(a0)+,d4				; Read cnt
	beq.s	@Quit					; If cnt=0, quit decompression.
	subq.b	#1,d4
	beq.w	@FetchNewCode			; If cnt=1, fetch a new code.

	adda.w	d5,a5
	move.b	(a5)+,(a1)+				; Do 1 extra copy (to compensate +1 to copy counter).
	move.w	d4,d6
	not.w	d6
	and.w	d7,d6
	add.w	d6,d6
	lsr.w	#_Kos_LoopUnroll,d4
	jmp	@largecopy(pc,d6.w)

; ---------------------------------------------------------------------------
@largecopy:
	rept (1<<_Kos_LoopUnroll)
	move.b	(a5)+,(a1)+
	endr
	dbra	d4,@largecopy
	bra.w	@FetchNewCode

; ---------------------------------------------------------------------------
	if _Kos_ExtremeUnrolling=1
@StreamCopy:
	adda.w	d5,a5
	move.b	(a5)+,(a1)+				; Do 1 extra copy (to compensate +1 to copy counter).
	if _Kos_LoopUnroll=3
	eor.w	d7,d4
	else
	eori.w	#7,d4
	endif
	add.w	d4,d4
	jmp	@mediumcopy(pc,d4.w)

; ---------------------------------------------------------------------------
@mediumcopy:
	rept 8
	move.b	(a5)+,(a1)+
	endr
	bra.w	@FetchNewCode
	endif

; ---------------------------------------------------------------------------
@Quit	move.l	a0,KosQueue.w
	move.l	a1,KosQueue+4.w
	andi.w	#$7FFF,KosDecQueCnt.w		; clear decompression in progress bit
	subq.w	#1,KosDecQueCnt.w
	beq.s	@Done				; branch if there aren't any entries remaining in the queue

	lea	KosQueue.w,a0
	lea	KosQueue+8.w,a1			; otherwise, shift all entries up
@len =	KosDecQueCnt-(KosQueue+8)

	rept @len/4
		move.l	(a1)+,(a0)+
	endr
@Done	rts

; ===========================================================================
BackupKos:
	move	sr,KosDecSR.w
	movem.w	d0-d6,KosDecRegs.w
	movem.l	a0-a1/a5,KosDecRegs+(2*7).w
	rts
; ===========================================================================
