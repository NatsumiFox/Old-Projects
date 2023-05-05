; ===========================================================================
; ---------------------------------------------------------------------------
; Swap Effect - Vertically replacing the scanlines
; ---------------------------------------------------------------------------
MMW_SlitSize = $04
; ---------------------------------------------------------------------------

MMW_ScanSlits:
		move.l	#MMWSS_ScanFG,(EMM_SwapRout).l		; set routine
		clr.w	(a3)+					; reset top Y position
		move.w	#((($00E0+1)*4)-(MMW_SlitSize*8)),(a3)	; reset bottom Y position
		rts						; return

	; --- Doing the FG first ---

MMWSS_ScanFG:
		move.w	(a3),d1					; load scan position
		cmpi.w	#$00E0*4,d1				; has the scanning finished?
		bge.s	MMWSS_FinishFG				; if not, branch
		addi.w	#MMW_SlitSize*8,(a3)+			; increase for next frame
		lea	(EMM_VScroll).l,a0			; load V-scroll RAM
		move.w	(EMM_ScrollSlot).l,d0			; load current slot being displayed
		addi.w	#$0100,d0				; advance to next slot
		adda.w	d1,a0					; advance to starting scroll position
	rept	MMW_SlitSize
		move.w	d0,(a0)+				; write FG position
		addq.w	#$02+4,a0				; skip over BG position
	endm
		move.w	(a3),d1					; load scan position
		subi.w	#MMW_SlitSize*8,(a3)			; decrease for next frame
		lea	(EMM_VScroll).l,a0			; load V-scroll RAM
		adda.w	d1,a0					; advance to starting scroll position
	rept	MMW_SlitSize
		move.w	d0,(a0)+				; write FG position
		addq.w	#$02+4,a0				; skip over BG position
	endm
		rts						; return

MMWSS_FinishFG:
		move.l	#MMWSS_ScanBG,(EMM_SwapRout).l		; set routine
		move.w	#((($00E0+1)*4)-(MMW_SlitSize*8)),(a3)	; force top Y position
		clr.w	$02(a3)					; force bottom Y position

	; --- Doing the BG last ---

MMWSS_ScanBG:
		move.w	(a3),d1					; load scan position
		bpl.s	MMWSS_NoStop				; if we're not finished, branch
		moveq	#$00,d0					; clear d0
		move.l	d0,(EMM_SwapRout).l			; finish swap routine
		move.b	d0,(EMM_RunEffect).l			; set effect as NOT running

MMWSS_NoStop:
		subi.w	#MMW_SlitSize*8,(a3)+			; decrease for next frame
		lea	(EMM_VScroll).l,a0			; load V-scroll RAM
		move.w	(EMM_ScrollSlot).l,d0			; load current slot being displayed
		addi.w	#$0100,d0				; advance to next slot
		adda.w	d1,a0					; advance to starting scroll position
	rept	MMW_SlitSize
		addq.w	#$02+4,a0				; skip over FG position
		move.w	d0,(a0)+				; write BG position
	endm
		move.w	(a3),d1					; load scan position
		addi.w	#MMW_SlitSize*8,(a3)			; decrease for next frame
		lea	(EMM_VScroll).l,a0			; load V-scroll RAM
		adda.w	d1,a0					; advance to starting scroll position
	rept	MMW_SlitSize
		addq.w	#$02+4,a0				; skip over FG position
		move.w	d0,(a0)+				; write BG position
	endm
		rts						; return

; ===========================================================================