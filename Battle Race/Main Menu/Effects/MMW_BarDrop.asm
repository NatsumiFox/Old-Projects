; ===========================================================================
; ---------------------------------------------------------------------------
; Swap Effect - Bar sections that drop and flip off screen
; ---------------------------------------------------------------------------
MMWBDD_Delay = $05
MMWBDD_Speed = $00008000
; ---------------------------------------------------------------------------

MMW_BarDrop:
		move.l	#MMWBD_Drop,(EMM_SwapRout).l		; set routine

		lea	$04(a3),a3				; load bar data offset
		move.l	a3,-$04(a3)				; store it for later

		moveq	#$07-1,d6				; set number of bars to render

		move.w	(EMM_ScrollSlot).l,d1			; load current slot being displayed
		move.w	d1,d5					; keep a copy in d5 for later
		addi.w	#$0100,d1				; advance to next slot
		move.w	d1,d2					; place in both words of register
		swap	d1					; ''
		move.w	d2,d1					; ''
		move.l	d1,(a3)+				; save background positions
		move.w	d6,(a3)+				; store number of bars to do

		moveq	#$00,d0					; clear d0
		move.w	#$0020,d1				; prepare distance of bars
		move.w	#MMWBDD_Delay*(($E0/$20)-1),d2		; reset delay time
		moveq	#-$08,d3				; prepare starting Y speed (moving upwards)
		move.w	#$00E0-$20,d4				; prepare starting Y position
		move.b	d4,d5

MMWBD_LoadBars:
		move.w	d0,(a3)+				; clear angle
		move.w	d4,(a3)+				; set position quotient
		move.w	d0,(a3)+				; clear position fraction
		move.w	d5,(a3)+				; set graphics line address
		move.w	d2,(a3)+				; set delay timer
		move.w	d0,(a3)+				; clear spare ram
		move.w	d3,(a3)+				; set Y speed quotient
		move.w	d0,(a3)+				; clear Y speed fraction
		sub.w	d1,d4					; move position up
		sub.w	d1,d5					; move graphics up
		subq.w	#MMWBDD_Delay,d2			; decrease delay time
		dbf	d6,MMWBD_LoadBars			; repeat for all available bars
		rts						; return

	; --- Dropping the bars one by one ---

MMWBD_Drop:
		movea.l	(a3),a0					; load bar RAM
		addq.w	#$04,a0					; skip background long-word
		move.w	(a0)+,d6				; load number of bars to run through
		moveq	#-$01,d5				; reset bar finish counter

MMWBDD_NextBar:
		subq.w	#$01,BP_Timer(a0)			; decrease delay timer
		bcs.s	MMWBDD_NoEnd				; if it has passed from 0000 to FFFF, branch
		bpl.s	MMWBDD_FinishBar			; if the bar's timer hasn't reset to FFFF and below, it hasn't finished
		addq.w	#$01,d5					; increase bar finish count
		bra.s	MMWBDD_FinishBar			; continue for next bar

MMWBDD_NoEnd:
		addi.w	#$0010*4,BP_Angle(a0)			; rotate bar
		clr.w	BP_Timer(a0)				; keep timer at 0
		move.l	BP_YSpeed(a0),d0			; load Y speed
		addi.l	#MMWBDD_Speed,d0			; increase speed downwards
		move.l	d0,BP_YSpeed(a0)			; update speed
		add.l	d0,BP_YPos(a0)				; increase Y position
		move.w	BP_YPos(a0),d0				; load Y position
		addi.w	#$0020,d0				; add top of screen range
		cmpi.w	#$00E0+$20,d0				; has this bar gone off screen?
		bcs.s	MMWBDD_FinishBar			; if not, branch
		blt.s	MMWBDD_NoHold				; if it has, but only above, branch
		subq.w	#$01,BP_Timer(a0)			; change timer to FFFF (so it wraps around again)

MMWBDD_NoHold:
		move.w	#$0040*4,BP_Angle(a0)			; set angle to non-rendering type of angle (to save on CPU time)

MMWBDD_FinishBar:
		lea	$10(a0),a0				; advance to next bar
		dbf	d6,MMWBDD_NextBar			; repeat for all bars
		movea.l	(a3),a3					; load bar RAM
		cmp.w	$04(a3),d5				; have all bars finished?
		blt.s	MMWBDD_NoStop				; if not, branch
		moveq	#$00,d0					; clear d0
		move.l	d0,(EMM_SwapRout).l			; finish swap routine
		move.b	d0,(EMM_RunEffect).l			; set effect as NOT running

MMWBDD_NoStop:
		bra.w	BarProcess				; render the bars

; ==========================================================================
