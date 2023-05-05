; ===========================================================================
; ---------------------------------------------------------------------------
; Swap effect - shatter
; ---------------------------------------------------------------------------
MMWS_MaxSpeed =		$1F000		; actually, just the bits to leave after and
MMWS_MinSpeed =		$6000		; added to anded speed
MMWS_Gravity =		$4000		; added each frame to speed
; ---------------------------------------------------------------------------

MMW_Shatter:
		move.l	#MMWS_Move,EMM_SwapRout		; set next routine
		move.w	#$36,$700(a3)			; save num of frames to do

		move.w	#MMWS_Scans-1,d2		; set repeat counter
		moveq	#0,d3				; start at scanline 0
		move.l	#$20000,d4			; 2 scanlines are grouped together

.assign		jsr	Random_Number			; get random number
		and.l	#MMWS_MaxSpeed,d0		; keep in range
		add.l	#MMWS_MinSpeed,d0		; increase by min speed
		neg.l	d0				; negate speed

		move.l	d3,(a3)+			; save pos
		move.l	d0,(a3)+			; save speed
		add.l	d4,d3				; goto next scan
		dbf	d2,.assign			; loop for all scanlines
		rts
; ---------------------------------------------------------------------------

MMWS_Move:
		bsr.s	MMWS_FastPlaneOther		; clear buffer fast
		subq.w	#1,$700(a3)			; check num of frames
		bmi.s	.endthis			; if 0, branch
	;	lea	(EMM_VScroll).l,a0		; load V-scroll RAM to a0
		add.l	#$01000100,d3			; fix d3 for us =)

		move.w	#MMWS_Scans-1,d6		; set repeat count
		move.l	#MMWS_MaxScan,a2		; set compare value to a2
		move.l	#MMWS_Gravity,d4		; get gravity constant to d4

	; 64 cycles
.scan		move.l	(a3),d0				; get y-pos
		add.l	4(a3),d0			; add speed to y-pos
		move.l	d0,(a3)+			; save y-pos
		add.l	d4,(a3)+			; do gravity

	; now, calculate visibility (either 14, 26 or 58 cycles)
		cmp.l	a2,d0				; check if onscreen
		bhs.s	.novis				; if not, branch

	; 48 cycles for code until the dbf (and not including)
.visible	swap	d0				; get word to d0
		add.w	d0,d0				; double
		add.w	d0,d0				; quadruple
		move.l	d3,(a0,d0.w)			; save data
		move.l	d3,4(a0,d0.w)			; ''

.next		dbf	d6,.scan			; loop for all lines
		rts

.novis		blt.s	.next				; if above, branch
	;	move.w	-2(a3),d0			; get speed
	;	sub.w	d4,d0				; sub gravity
	;	sub.w	d0,-4(a3)			; sub speed from pos
		clr.w	-2(a3)				; clear speed
		bra.s	.next

.endthis	clr.l	EMM_SwapRout			; finish swap routine
		clr.b	EMM_RunEffect			; set effect as NOT running
		rts
