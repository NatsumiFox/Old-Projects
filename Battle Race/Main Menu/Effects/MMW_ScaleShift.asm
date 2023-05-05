; ===========================================================================
; ---------------------------------------------------------------------------
; Swap Effect - Scaling out, shifting to the next slot, and then scaline in
; ---------------------------------------------------------------------------
MMWSS_ScaleSpeed = $2400
MMWSS_MoveSpeed = $0A
; ---------------------------------------------------------------------------

MMW_ScaleShift:
		move.l	#MMWSS_ScaleOut,(EMM_SwapRout).l	; set next routine
		moveq	#$00,d0					; clear d0
		move.l	d0,(a3)+				; clear scale amount
		move.l	d0,(a3)+				; clear scale start position
		move.w	d0,(a3)+				; clear Y position
		rts						; return

	; --- Scaling out ---

MMWSS_ScaleOut:
		addi.l	#MMWSS_ScaleSpeed,(a3)			; increase scale amount
		move.w	(a3)+,d2				; load scale amount quotient
		cmpi.w	#$0003,d2				; has it scaled out enough?
		blo.s	MMWSO_NoStop				; if not, branch
		move.l	#MMWSS_ScaleMove,(EMM_SwapRout).l	; set next routine

MMWSO_NoStop:
		move.w	(a3)+,d3				; load scale amount fraction
		subi.l	#MMWSS_ScaleSpeed*(224/2),(a3)		; move scale start position up
		move.w	(a3)+,d0				; load start position quotient (quotient/fraction)
		move.w	(a3)+,d1				; ''
		bra.s	MMWSS_WriteLines			; write the scanlines

	; --- Moving to next slot ---

MMWSS_ScaleMove:
		move.w	(a3)+,d2				; load scale amount (quotient/fraction)
		move.w	(a3)+,d3				; ''
		move.w	(a3)+,d0				; load start position quotient (quotient/fraction)
		move.w	(a3)+,d1				; ''
		move.w	(a3),d4					; load Y position
		addi.w	#MMWSS_MoveSpeed,d4			; move it down
		cmpi.w	#$0100,d4				; has it reached 100?
		blo.s	MMWSM_NoStop				; if not, branch
		move.w	#$0100,d4				; force to 100
		move.l	#MMWSS_ScaleIn,(EMM_SwapRout).l		; set next routine

MMWSM_NoStop:
		move.w	d4,(a3)					; update it
		add.w	d4,d0					; add to start position
		bra.s	MMWSS_WriteLines			; write the scanlines

	; --- Scaling in ---

MMWSS_ScaleIn:
		subi.l	#MMWSS_ScaleSpeed,(a3)			; decrease scale amount
		bgt.s	MMWSI_NoStop				; if the scale amount has not reached 0, branch
		moveq	#$00,d0					; clear d0
		move.l	d0,(EMM_SwapRout).l			; finish swap routine
		move.b	d0,(EMM_RunEffect).l			; set effect as NOT running

MMWSI_NoStop:
		move.w	(a3)+,d2				; load scale amount (quotient/fraction)
		move.w	(a3)+,d3				; ''
		addi.l	#MMWSS_ScaleSpeed*(224/2),(a3)		; move scale start position down
		move.w	(a3)+,d0				; load start position quotient (quotient/fraction)
		move.w	(a3)+,d1				; ''
		add.w	(a3)+,d0				; move it down by to next slot

; ---------------------------------------------------------------------------
; writing the actual scanlines
; ---------------------------------------------------------------------------

MMWSS_WriteLines:
		add.w	(EMM_ScrollSlot).l,d0			; add scroll slot we're using
		lea	(EMM_VScroll).l,a0			; load V-scroll RAM
		moveq	#($E0/2)-1,d4				; set number of scanlines to perform on

MMWSS_NextLine:
	rept	2
		move.w	d0,(a0)+				; write positions to FG and BG
		move.w	d0,(a0)+				; ''
		add.w	d3,d1					; add fractions
		addx.w	d2,d0					; add quotients
	endm
		dbf	d4,MMWSS_NextLine			; repeat for all scanlines
		rts						; return

; ===========================================================================