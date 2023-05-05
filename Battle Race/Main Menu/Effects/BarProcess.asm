; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to render the bars correctly
; ---------------------------------------------------------------------------
; a3 = Bar RAM
;
; First long-word is the background FG and BG V-scroll positions to render
; behind the bars.
;
; The next word is the number of bars to render (minus 1 for dbf)
;
; The data following reoccurs for the number of bars requested, and is
; as followed:
;
;	00 - 01	= angle (this is read in multiples of 4 from 0000 to 03FC)
;	02 - 05 = scanline position to render at (QQQQ.FFFF)
;	06 - 07 = scanline graphics we're rendering with (0PSS - where P is the slot and SS is the scanline)
;	08 - 0F = --- spare space if needed ---
;
; Please note, if "BarProcess_NoBG" is called instead, then a3 must start
; at the next word "number of bars to render" value, as the first long-word is
; no longer needed.
; ---------------------------------------------------------------------------
BP_Angle	= $00
BP_YPos		= $02
BP_Graphics	= $06
BP_Timer	= $08
BP_YSpeed	= $0C
; ---------------------------------------------------------------------------

BarProcess:
		move.l	(a3)+,d0				; load background positions
		bsr.w	BP_SetPlane				; set the entire plane to this position

	; --- Drawing bars on top ---

BarProcess_NoBG:
		lea	(BP_Angles).l,a1			; load angle data list
		move.w	#EMM_VScroll&$FFFF,d4			; prepare V-scroll position RAM
		move.w	#$00FF<<2,d5				; prepare angle wrap value
		move.w	(a3)+,d6				; set number of bars to render

BP_NextBar_Reset:
		move.l	#EMM_VScroll&$FFFF0000,d0		; prepare V-scroll position RAM (upper word)

BP_NextBar:
		move.w	(a3)+,d0				; load angle
		and.w	d5,d0					; get only the angle
		movea.l	(a1,d0.w),a0				; load correct angle data
		move.w	(a3)+,d0				; load position (quotient)
		add.w	(a0)+,d0				; advance to correct position
		move.w	$02(a3),d1				; load graphics scanline
		lea	$0C(a3),a3				; advance to next bar
		sub.w	d0,d1					; subtract V-scroll position
		add.w	(a0)+,d1				; advance to correct starting graphics scanline
		add.w	d0,d0					; multiply by size of long-word
		add.w	d0,d0					; ''
		add.w	d4,d0					; add V-scroll start address
		move.l	d0,a2					; set address (upper word already had address)
		move.w	d1,d0					; copy to upper word of d1 too...
		swap	d1					; ''
		move.w	d0,d1					; ''
		move.w	(a0)+,d0				; load size of bar
		beq.w	BP_Normal				; if it's full sized, branch
		jmp	BP_Complex(pc,d0.w)			; jump to correct starting scanline draw
		nop						; null for upside down full sized bar

BP_Complex:
	rept	$20-1
		move.l	d1,(a2)+				; write FG and BG positions
		add.l	(a0)+,d1				; change position
	endm
		move.l	d1,(a2)+				; write FG and BG positions
		dbf	d6,BP_NextBar				; repeat for all bars
		rts						; return

BP_Normal:
		move.l	d1,d0					; copy positions to d0, d2 and d3
		move.l	d1,d2					; ''
		move.l	d1,d3					; ''
		lea	$20*4(a2),a2				; advance to the end (movem only does decrements)
	rept	$20/4
		movem.l	d0-d3,-(a2)				; copy positions into the V-scroll RAM buffer
	endm
		dbf	d6,BP_NextBar_Reset			; repeat for all bars
		rts						; return

BP_Angles:	include	"Main Menu\Effects\BarSine.asm"

; ---------------------------------------------------------------------------
; Subroutine to set the whole V-scroll plane to a position quickly
; ---------------------------------------------------------------------------

BP_SetPlane:
		lea	(EMM_VScroll+($E0*4)).l,a2		; load V-scroll RAM
		move.l	d0,d1					; ''
		move.l	d0,d2					; ''
		move.l	d0,d3					; ''
		move.l	d0,d4					; ''
		move.l	d0,d5					; ''
		move.l	d0,d6					; ''
		move.l	d0,a0					; ''
		move.l	d0,a1					; ''
	rept	$E0/9
		movem.l	d0-d6/a0-a1,-(a2)			; write scroll positions
	endm
		movem.l	d0-d6/a0,-(a2)				; write last scroll positions
		rts						; return

; ===========================================================================