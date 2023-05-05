; ===========================================================================
; ---------------------------------------------------------------------------
; Swap Effect - Vertically replacing the scanlines
; ---------------------------------------------------------------------------
MMW_ScanSize = $08
; ---------------------------------------------------------------------------

MMW_ScanVertical:
		move.l	#MMWSV_ScanFG,(EMM_SwapRout).l		; set routine
		clr.w	(a3)					; clear Y position
		rts						; return

	; --- Doing the FG first ---

MMWSV_ScanFG:
		move.w	(a3),d1					; load scan position
		cmpi.w	#$00E0*4,d1				; has the scanning finished?
		bge.s	MMWSV_FinishFG				; if not, branch
		addi.w	#MMW_ScanSize*4,(a3)			; increase for next frame
		lea	(EMM_VScroll).l,a0			; load V-scroll RAM
		move.w	(EMM_ScrollSlot).l,d0			; load current slot being displayed
		addi.w	#$0100,d0				; advance to next slot
		adda.w	d1,a0					; advance to starting scroll position
	rept	MMW_ScanSize
		move.w	d0,(a0)+				; write FG position
		addq.w	#$02,a0					; skip over BG position
	endm
		rts						; return

MMWSV_FinishFG:
		move.l	#MMWSV_ScanBG,(EMM_SwapRout).l		; set routine
		move.w	#($00E0-MMW_ScanSize)*4,(a3)		; force to bottom

	; --- Doing the BG last ---

MMWSV_ScanBG:
		move.w	(a3),d1					; load scan position
		bpl.s	MMWSV_NoStop				; if we're not finished, branch
		moveq	#$00,d0					; clear d0
		move.l	d0,(EMM_SwapRout).l			; finish swap routine
		move.b	d0,(EMM_RunEffect).l			; set effect as NOT running

MMWSV_NoStop:
		subi.w	#MMW_ScanSize*4,(a3)			; decrease for next frame
		lea	(EMM_VScroll).l,a0			; load V-scroll RAM
		move.w	(EMM_ScrollSlot).l,d0			; load current slot being displayed
		addi.w	#$0100,d0				; advance to next slot
		adda.w	d1,a0					; advance to starting scroll position
	rept	MMW_ScanSize
		addq.w	#$02,a0					; skip over FG position
		move.w	d0,(a0)+				; write BG position
	endm
		rts						; return

; ===========================================================================