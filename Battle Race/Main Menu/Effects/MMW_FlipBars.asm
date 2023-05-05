; ===========================================================================
; ---------------------------------------------------------------------------
; Swap Effect - Flipping bars around to reveal other slot
; ---------------------------------------------------------------------------
MMWFB_Delay = $04
MMWFB_Speed = $08
; ---------------------------------------------------------------------------

MMW_FlipBars:
		move.l	#MMWFB_Flip,(EMM_SwapRout).l		; set routine
		lea	$04(a3),a3				; load bar data offset
		move.l	a3,-$04(a3)				; store it for later

		moveq	#$07-1,d6				; set number of bars to render
		move.w	(EMM_ScrollSlot).l,d5			; load current slot being displayed
		move.w	d6,(a3)+				; store number of bars to do

		moveq	#$00,d0					; clear d0
		move.w	#$0020,d1				; prepare distance of bars
		move.w	#MMWFB_Delay*(($E0/$20)-1),d2		; reset delay time
		move.w	#$00E0-$20,d4				; prepare starting Y position
		move.b	d4,d5

MMWFB_LoadBars:
		move.w	d0,(a3)+				; clear angle
		move.w	d4,(a3)+				; set position quotient
		move.w	d0,(a3)+				; clear position fraction
		move.w	d5,(a3)+				; set graphics line address
		move.w	d2,(a3)+				; set delay timer
		move.w	d0,(a3)+				; clear spare ram
		move.l	d0,(a3)+				; clear Y speed
		sub.w	d1,d4					; move position up
		sub.w	d1,d5					; move graphics up
		subq.w	#MMWFB_Delay,d2				; decrease delay time
		dbf	d6,MMWFB_LoadBars			; repeat for all available bars
		rts						; return

	; --- Flipping the bars one by one ---

MMWFB_Flip:
		movea.l	(a3),a0					; load bar RAM
		move.w	(a0)+,d6				; load number of bars to run through
		moveq	#-$01,d5				; reset bar finish counter

MMWFB_NextBar:
		subq.w	#$01,BP_Timer(a0)			; decrease delay timer
		bcs.s	MMWFB_NoEnd				; if it has passed from 0000 to FFFF, branch
		bpl.s	MMWFB_FinishBar				; if the bar's timer hasn't reset to FFFF and below, it hasn't finished
		addq.w	#$01,d5					; increase bar finish count
		bra.s	MMWFB_FinishBar				; continue for next bar

MMWFB_NoEnd:
		clr.w	BP_Timer(a0)				; keep timer at 0
		move.w	BP_Angle(a0),d0				; load angle
		addi.w	#MMWFB_Speed*4,d0			; rotate
		bcc.s	MMWFB_NoFinish				; if it hasn't rotated back to 0, branch
		subq.w	#$01,BP_Timer(a0)			; change timer to FFFF (so it wraps around again)
		bra.s	MMWFB_FinishBar				; skip rotation update

MMWFB_NoFinish:
		cmpi.w	#$0040*4,d0				; has it gone halfway yet?
		blt.s	MMWFB_NoSwap				; if not, branch
		move.w	#-$0040*4,d0				; reset back
		bchg.b	#$00,BP_Graphics(a0)			; swap the slot being displayed

MMWFB_NoSwap:
		move.w	d0,BP_Angle(a0)				; update angle

MMWFB_FinishBar:
		lea	$10(a0),a0				; advance to next bar
		dbf	d6,MMWFB_NextBar			; repeat for all bars
		movea.l	(a3),a3					; load bar RAM
		cmp.w	(a3),d5					; have all bars finished?
		blt.s	MMWFB_NoStop				; if not, branch
		moveq	#$00,d0					; clear d0
		move.l	d0,(EMM_SwapRout).l			; finish swap routine
		move.b	d0,(EMM_RunEffect).l			; set effect as NOT running

MMWFB_NoStop:
		bra.w	BarProcess_NoBG				; render the bars

; ===========================================================================


















