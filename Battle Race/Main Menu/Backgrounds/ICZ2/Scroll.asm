; ===========================================================================
; ---------------------------------------------------------------------------
; Scroll Data - Ice Cap 2
; ---------------------------------------------------------------------------

		lea	(EMM_ScrollSpeed).l,a0			; load scroll speed list
		move.l	(a2),d0					; load snow flake flicker scroll position
		add.l	(a0),d0					; add scroll position (fastest)
		addi.w	#$0100,(a2)				; increase for next frame

	; Doing equates, because AS doesn't like these prefixed
	; before the "(a0)".  Stupid piece of shit...

SEICZ02_EQU1	=	(((($1000-$0100)/$40)*4)+$00)
SEICZ02_EQU2	=	(((($1000-$0200)/$40)*4)+$00)

		move.w	SEICZ02_EQU1(a0),d0			; load BG position
		jsr	(WriteScroll-($5A*2))			; write top ice bergs
		move.w	SEICZ02_EQU2(a0),d0			; load next BG position
		jsr	(WriteScroll-($26*2))			; write bottom ice bergs

	; --- This is "almost" a copy of S3's (just optimised a bit) ---

		lea     (ALZ_AIZ2_BGDeformDelta).l,a3		; load water scroll table values (see "Lockon S3/Screen Events.asm")
		addq.w	#$0001,$02(a2)				; increase timer
		move.w	$02(a2),d1				; load timer
		lsr.w	#$02,d1					; divide timer (slow it down)
		andi.w  #$003E,d1				; wrap within table range
		adda.w  d1,a3					; advance to correct table entry
		moveq   #$08-1,d1				; set number of lines to draw for

SEICZ02_WaterWobble:
		move.l	d0,d2					; copy FG/BG scroll
		add.w	(a3)+,d2				; add water scroll
		move.l	d2,(a1)+				; save to buffer
		dbf	d1,SEICZ02_WaterWobble			; repeat for number of pixels

	; --- This too is "almost" a copy of S3's ---

		move.w	$02(a0),d0				; load scroll position (fastest and in reverse)
		move.w	$02(a2),d1				; load timer
		asr.w   #$01,d1					; divide timer (slow it down)
		add.w   d1,d0					; add to current X position
		swap    d0					; multiply by 10000 (create fraction space)
		clr.w   d0					; ''
		asr.l   #$01,d0					; divide by 2 again
		andi.l  #$007FFFFF,d0				; wrap it
		neg.l	d0
		move.l  d0,d1					; copy to d1
		asr.l   #$06,d1					; divide by 40 (for fraction adding)
		moveq   #$28-2,d2				; set number of lines to perform the water surface scrolling
		lea	$28*4(a1),a1				; go to end of scroll table
		lea	(a1),a3					; store address
		swap	d0					; write first BG position (to move the RAM back correctly)
		move.w	d0,-(a1)				; ''
		swap	d0					; ''
		move.w	(a2),d3					; reload FG flicker snowflake position
		add.w	(a0),d3					; ''

SEICZ02_WaterSurface:
		sub.l   d1,d0					; decrease scroll rate
		move.l  d0,-(a1)				; write BG position
		move.w	d3,$02(a1)				; write FG position
		dbf     d2,SEICZ02_WaterSurface			; repeat for all position
		move.w	d3,-$02(a1)				; write final FG position

	; --- Bottom platform/floor area pretending to be FG ---

		lea	(a3),a1					; copy scroll table address back
		move.l	(a2),d0					; load snow flake flicker scroll position
		add.l	(a0),d0					; add scroll position (fastest)
		move.w	(a0),d0					; set BG to fastest too (as it's displaying FG floor)
		jmp	(WriteScroll-($50*2))			; do bottom FG floor section

; ===========================================================================