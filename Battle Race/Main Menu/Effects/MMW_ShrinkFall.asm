; ===========================================================================
; ---------------------------------------------------------------------------
; Swap effect - Shrink and Fall
; ---------------------------------------------------------------------------
MMWF_SegSize =		$1C		; size of a segment
MMWF_SegNum =		$E0/MMWF_SegSize; num of segments
MMWF_DataSize =		$0A		; size of each struct

; data structure
; 0-3 - y-pos
; 4-5 - routine
;
; routine 0:
; 6-7 - Delay of segment
;
; routine 2:
; 6-7 - progression
;
; routine 4:
; 6-9 - Speed of segment
;
; routine 6:

MMWF_InitDelay =	$06		; increment of initial delay
MMWF_GrowLen =		$08		; how long the growing takes
MMWF_GrowWait =		$03		; how long to wait being fully grown
MMWF_ShrinkLen =	$07		; how long to shrink
MMWF_UpVel =		$22000*4	; upwards velocity after shrinking
MMWF_Gravity =		-$3800*4	; gravity
MMWF_LastScan =		-((MMWF_SegSize/2)*$40000); last scanline displayed
; ---------------------------------------------------------------------------

MMW_ShrinkFall:
		move.l	#MMWS_Proc,EMM_SwapRout		; set next routine
	;	add.w	#MMWF_DataSize*MMWF_SegNum,a3	; load data inversely

		moveq	#MMWF_SegNum-1,d6		; load num of segments
		moveq	#MMWF_InitDelay*(MMWF_SegNum-1),d5; reset delay
		move.l	#MMWF_SegSize*$20000,d4		; y-pos
		move.l	#MMWF_SegSize*$40000,d3		; set segment size

.init		move.l	d4,(a3)+			; set y-pos
		clr.w	(a3)+				; clear routine
		move.w	d5,(a3)+			; set delay
		clr.w	(a3)+				; clear misc

		add.l	d3,d4				; goto next y-pos
		sub.w	#MMWF_InitDelay,d5		; increase delay
		dbf	d6,.init			; do init loop
		rts

MMWS_Proc:
		move.w	(EMM_ScrollSlot).l,d0		; load scroll slot
		addi.w	#$0100,d0			; change to other plane
		move.w	d0,d1				; save to both words
		swap	d0				; ''
		move.w	d1,d0				; ''
		jsr	BP_SetPlane			; set the entire plane to this position
		lea	(a2),a0				; load V-scroll buffer

	;	lea	(EMM_VScroll).l,a0		; load V-scroll RAM to a0
		add.l	#$01000100,d3			; fix d3 for us =)

		move.w	#$FFFC,d5			; set and value
		moveq	#MMWF_SegNum-1,d6		; set repeat count

.loop		move.l	(a3)+,d4			; get y-pos
		move.w	(a3)+,d0			; get routine
		jsr	.rt0(pc,d0.w)			; run routine
		dbf	d6,.loop			; loop for all
		rts

.rt0	; routine 0: Delay
		subq.w	#1,(a3)+			; decrement delay
		bmi.s	.irt2				; if over, branch
.clearbuf	swap	d4				; get meaningful y-pos
		and.w	d5,d4				; clear low bits

		lea	-MMWF_SegSize*2(a0,d4.w),a1	; get plane ptr

	rept MMWF_SegSize
		move.l	d3,(a1)+			; clear entire segmento
	endm
		bra.s	.skip2				; derp about

.irt2		subq.w	#4,a3				; else fix a3

	; init routine 2
		move.w	#.rt2-.rt0,(a3)+		; set new routine

.rt2	; routine 2: Grow and shrink
		addq.w	#1,(a3)				; increase offset
		move.w	(a3)+,d0			; get offset
		cmp.w	#MMWF_GrowLen+MMWF_GrowWait+MMWF_ShrinkLen,d0; check max size
		bhs.w	.irt4				; if is, init rt3

		swap	d4				; get meaningful y-pos
		and.w	d5,d4				; clear low bits
		lea	(a0,d4.w),a1			; get plane ptr
		move.l	a1,a2				; copy for later

		moveq	#0,d1
		move.b	.sizes(pc,d0.w),d1		; get coefficiency
		cmp.b	#MMWF_SegSize,d1		; check if this is 1:1
		beq.w	.clearbuf			; if is, just clear buffer
		blt.s	.shrink				; if lower, shrink instead

		move.l	#MMWF_SegSize*$10000,d0		; prepare segment size
		divu	d1,d0				; d0.w is coefficiency
		move.w	d0,-(sp)			; save coeff for later
		moveq	#0,d1				; clear accumulator

	; do above
		moveq	#MMWF_SegSize/2-1,d4		; set loop count
		moveq	#0,d5				; clear offset

.t2		add.w	d0,d1				; add to accumulator
		bcs.s	.tn2				; if carry not set, branch
		addq.w	#1,d5				; sub 1 from offset

.tn2		move.w	d5,d2				; copy offset
		swap	d2				; swap words
		move.w	d5,d2				; do FG too
		add.l	d3,d2				; add lineoff
		move.l	d2,-(a2)			; save to buffer
		dbf	d4,.t2				; loop for all scans

	; do below
		move.w	(sp)+,d0			; get coefficiency back
		moveq	#0,d1				; clear accumulator
		moveq	#MMWF_SegSize/2-1,d4		; set loop count
		moveq	#0,d5				; clear offset

.b2		add.w	d0,d1				; add to accumulator
		bcs.s	.bn2				; if carry not set, branch
		subq.w	#1,d5				; add 1 to offset

.bn2		move.w	d5,d2				; copy offset
		swap	d2				; swap words
		move.w	d5,d2				; do FG too
		add.l	d3,d2				; add lineoff
		move.l	d2,(a1)+			; save to buffer
		dbf	d4,.b2				; loop for all scans

.res2		move.w	#$FFFC,d5			; reset and value
.skip2		addq.w	#2,a3				; skip over last word
		rts

.x := 1
.sizes	rept MMWF_GrowLen
		dc.b MMWF_SegSize + ((MMWF_SegSize / MMWF_GrowLen)*.x)
.x :=		.x+1
	endm

	dc.b [MMWF_GrowWait]MMWF_SegSize*2

.x := 1
	rept MMWF_ShrinkLen
		dc.b (MMWF_SegSize*2) - (((MMWF_SegSize*3/2) / MMWF_ShrinkLen)*.x)
.x :=		.x+1
	endm
		even

.shrink		move.l	#MMWF_SegSize,d0		; prepare segment size
		swap	d1				; *$10000
		divu	d0,d1				; d1.w is coefficiency
		move.w	d1,-(sp)			; save coeff for later
		moveq	#0,d0				; clear accumulator

		moveq	#MMWF_SegSize/2-1,d4		; set loop count
		moveq	#0,d5				; clear offset

.ti2		add.w	d1,d0				; add to accumulator
		bcs.s	.tin2				; if carry not set, branch
		subq.w	#1,d5				; sub 1 from offset
		subq.w	#1,d4				; sub 1 from loop count
		bmi.s	.c2				; if negative, done

.tin2		move.w	d5,d2				; copy offset
		swap	d2				; swap words
		move.w	d5,d2				; do FG too
		add.l	d3,d2				; add lineoff
		move.l	d2,-(a2)			; save to buffer
		dbf	d4,.ti2				; loop for all scans

	; do below
.c2		move.w	(sp)+,d1			; get coefficiency back
		moveq	#0,d0				; clear accumulator
		moveq	#MMWF_SegSize/2-1,d4		; set loop count
		moveq	#0,d5				; clear offset

.bi2		add.w	d1,d0				; add to accumulator
		bcs.s	.bin2				; if carry not set, branch
		addq.w	#1,d5				; add 1 to offset
		subq.w	#1,d4				; sub 1 from loop count
		bmi.s	.res2				; if negative, done

.bin2		move.w	d5,d2				; copy offset
		swap	d2				; swap words
		move.w	d5,d2				; do FG too
		add.l	d3,d2				; add lineoff
		move.l	d2,(a1)+			; save to buffer
		dbf	d4,.bi2				; loop for all scans
		bra.s	.res2

.irt4		subq.w	#4,a3				; fix a3

	; init routine 4
		move.w	#.rt4-.rt0,(a3)+		; set new routine
		move.l	#MMWF_UpVel,(a3)		; set velocity

.rt4		cmp.l	#MMWF_LastScan,d4		; check if below screen
		ble.s	.irt6				; if so, end this

		move.l	(a3),d0				; get velocity to d0
		add.l	d0,-6(a3)			; add to pos
		add.l	#MMWF_Gravity,(a3)+		; add gravity to velocity

		swap	d4				; get meaningful y-pos
		move.w	d4,d1				; copy to d1
		lsr.w	#2,d1				; divide by 4
		and.w	d5,d4				; clear low bits
		lea	-MMWF_SegSize(a0,d4.w),a1	; get plane ptr (1 quarter way there)

		moveq	#MMWF_SegNum-1,d0		; used for negation
		sub.w	d6,d0				; get segment ID
		mulu	#MMWF_SegSize,d0		; multiply by segment size
		sub.w	d0,d1				; sub from d1
		neg.w	d1
		addq.w	#8,d1				; align

		move.w	d1,d0				; copy to d0
		swap	d0				; do BG too
		move.w	d1,d0				; ''

		move.l	#$00010001,d1			; 1 moar pixel
		add.l	d3,d0				; add plane
		moveq	#MMWF_SegSize/2,d2		; loop this many times

.dr4w		move.l	d0,(a1)+			; copy 1 scan
		add.l	d1,d0				; skip 1 line
		dbf	d2,.dr4w			; draar
		rts

.irt6		move.w	#.rt6-.rt0,-2(a3)		; just set new prt
.rt6		cmp.w	#MMWF_SegNum-1,d6		; check if last obj
		bne.s	.re				; if not, then just do nothing
		clr.l	EMM_SwapRout			; finish swap routine
		clr.b	EMM_RunEffect			; set effect as NOT running
.re		addq.w	#4,a3				; skip over last word
		rts
