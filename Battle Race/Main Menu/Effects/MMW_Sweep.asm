; ===========================================================================
; ---------------------------------------------------------------------------
; Swap effect - shatter
; ---------------------------------------------------------------------------
MMW2_SpeedBase =	$7800*4		; speed of first segment
MMW2_SpeedInc =		$2400*4		; speed increment for subsequent segments
; ---------------------------------------------------------------------------

MMW_Sweep:
		move.l	#MMW_SweepStart,(EMM_SwapRout).l	; set next routine
		move.w	#-$E0*4,(a3)				; starting Y position
		move.l	#MMW2_SpeedInc,$04(a3)			; incremental speed
		move.l	#MMW2_SpeedBase,$08(a3)			; base speed

MMW_SweepStart:
		move.w	(EMM_ScrollSlot).l,d0			; load scroll slot
		swap	d0					; ''
		move.w	(EMM_ScrollSlot).l,d0			; ''
		addi.l	#$01000100,d0				; set to other plane
		jsr	BP_SetPlane				; set the entire plane to this position
		subi.l	#$01000100,d0				; revert
		move.l	d0,d1					; keep a copy in d1
		movem.l	(a3),d2-d4				; load position and speeds
		add.l	d4,d2					; add base speed
		bpl.s	MMWSS_Finish				; if the first scanline is now out of the screen, branch to finish
		move.l	d2,(a3)+				; update position
		move.l	d3,d4					; keep a copy of the incremental speed
		lsr.l	#$04,d4					; divide by 10
		add.l	d4,(a3)+				; increase speeds by /10
		add.l	d4,(a3)					; ''
		lsl.l	#$03,d3					; multiply incremental speed by x8 (for some reason the original speed isn't enough, probably something being miscalculated, who knows...)
		addi.l	#$00040000,d3				; add the auto-increment
		lea	(EMM_VScroll+($E0*4)).l,a0		; load V-scroll table

MMWSS_NextScan:
		move.l	d2,d4					; load position
		swap	d4					; ''
		andi.w	#$FFFC,d4				; get only every long-word
		movem.l	d0-d1,(a0,d4.w)				; save two scanlines
		add.l	d3,d2					; advance to next scanlines
		bmi.s	MMWSS_NextScan				; if the next one is still on the screen, branch
		rts						; return (no more on screen)

MMWSS_Finish:
		moveq	#$00,d0					; clear d0
		move.l	d0,(EMM_SwapRout).l			; finish swap routine
		move.b	d0,(EMM_RunEffect).l			; set effect as NOT running
		rts						; return

; ===========================================================================