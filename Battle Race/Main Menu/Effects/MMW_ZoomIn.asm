; ===========================================================================
; ---------------------------------------------------------------------------
; Swap Effect - Scaling in, shifting to the next slot, and then scaline out
; ---------------------------------------------------------------------------
MMWZI_ScaleSpeed = $0800
MMWZI_MoveSpeed = $04
; ---------------------------------------------------------------------------

MMW_ZoomIn:
		move.l	#MMWZI_ScaleIn,(EMM_SwapRout).l		; set next routine
		moveq	#$00,d0					; clear d0
		move.l	d0,(a3)+				; clear scale amount
		move.l	d0,(a3)+				; clear scale start position
		move.w	d0,(a3)+				; clear Y position
		rts						; return

	; --- Scaling in ---

MMWZI_ScaleIn:
		subi.l	#MMWZI_ScaleSpeed,(a3)			; increase scale amount
		move.w	(a3)+,d2				; load scale amount quotient
		move.w	(a3)+,d3				; load scale amount fraction
		bne.s	MMWZO_NoStop				; if the scale amount has NOT reached FFFF0000, branch
		move.l	#MMWZI_ScaleMove,(EMM_SwapRout).l	; set next routine

MMWZO_NoStop:
		addi.l	#MMWZI_ScaleSpeed*(224/2),(a3)		; move scale start position up
		move.w	(a3)+,d0				; load start position quotient (quotient/fraction)
		move.w	(a3)+,d1				; ''
		bra.s	MMWSS_WriteLines			; write the scanlines

	; --- Moving to next slot ---

MMWZI_ScaleMove:
		move.w	(a3)+,d2				; load scale amount (quotient/fraction)
		move.w	(a3)+,d3				; ''
		move.w	(a3)+,d0				; load start position quotient (quotient/fraction)
		move.w	(a3)+,d1				; ''
		move.w	(a3),d4					; load Y position
		addi.w	#MMWZI_MoveSpeed,d4			; move it down
		cmpi.w	#$0100,d4				; has it reached 100?
		blo.s	MMWZM_NoStop				; if not, branch
		move.w	#$0100,d4				; force to 100
		move.l	#MMWZI_ScaleOut,(EMM_SwapRout).l	; set next routine

MMWZM_NoStop:
		move.w	d4,(a3)					; update it
		add.w	d4,d0					; add to start position
		bra.w	MMWSS_WriteLines			; write the scanlines

	; --- Scaling out ---

MMWZI_ScaleOut:
		addi.l	#MMWZI_ScaleSpeed,(a3)			; decrease scale amount
		blt.s	MMWZI_NoStop				; if the scale amount has not reached 0, branch
		moveq	#$00,d0					; clear d0
		move.l	d0,(EMM_SwapRout).l			; finish swap routine
		move.b	d0,(EMM_RunEffect).l			; set effect as NOT running

MMWZI_NoStop:
		move.w	(a3)+,d2				; load scale amount (quotient/fraction)
		move.w	(a3)+,d3				; ''
		subi.l	#MMWZI_ScaleSpeed*(224/2),(a3)		; move scale start position down
		move.w	(a3)+,d0				; load start position quotient (quotient/fraction)
		move.w	(a3)+,d1				; ''
		add.w	(a3)+,d0				; move it down by to next slot
		bra.w	MMWSS_WriteLines			; write the scanlines

; ===========================================================================