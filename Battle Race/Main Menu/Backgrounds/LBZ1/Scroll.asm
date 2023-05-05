; ===========================================================================
; ---------------------------------------------------------------------------
; Scroll Data - Launch Base 1
; ---------------------------------------------------------------------------

	; Doing equates, because AS doesn't like these prefixed
	; before the "(a0)".  Stupid piece of shit...

SELBZ01_EQU0	=	(((($1000-$1000)/$40)*4)+$02)
SELBZ01_EQU1	=	(((($1000-$0100)/$40)*4)+$02)
SELBZ01_EQU2	=	(((($1000-$0200)/$40)*4)+$02)
SELBZ01_EQU3	=	(((($1000-$0240)/$40)*4)+$00)
SELBZ01_EQU4	=	(((($1000-$0280)/$40)*4)+$02)
SELBZ01_EQU5	=	(((($1000-$02C0)/$40)*4)+$00)

		lea	(EMM_ScrollSpeed).l,a0			; load scroll speed list
		move.l	SELBZ01_EQU0(a0),d0			; load scroll position (fastest)

	; --- Normal FG position ---

		move.w	SELBZ01_EQU1(a0),d0			; load BG position
		jsr	(WriteScroll-($88*2))			; write construction cranes

	; --- Badnik position ---

		move.w	$02(a2),d0				; load timer
		move.w	d0,d3					; store flags
		andi.w	#$FF80,d3				; ''
		andi.w	#$007F,d0				; get timer
		subq.w	#$01,d0					; decrease timer
		bpl.s	SELBZ01_NoNext				; if still counting, branch
		jsr	Random_Number.w				; get a random number
		swap	d0					; get upper word
		andi.w	#$407F,d0				; get new timer and direction flag
		addi.w	#$8000,d3				; change movement flag

SELBZ01_NoNext:
		eor.w	d3,d0					; save flags back
		move.w	d0,$02(a2)				; update timer
		bpl.s	SELBZ01_NoMove				; if the move flag is clear, branch
		add.w	d0,d0					; get direction flag
		bpl.s	SELBZ01_MoveRight			; if moving right, branch
		subq.w	#$01,(a2)				; move left
		andi.b	#$F7,(a2)				; clear flip bit
		bra.s	SELBZ01_NoMove				; continue

SELBZ01_MoveRight:
		addq.w	#$01,(a2)				; move right
		ori.b	#$08,(a2)				; set flip bit

SELBZ01_NoMove:
		move.w	(a2),d0					; load badnik scroll position
		andi.w	#$03FF,d0				; get only the position
		asr.w	#$01,d0					; divide speed by 2
		add.w	SELBZ01_EQU0(a0),d0			; add scroll position
		swap	d0					; send to FG position in d0
		move.w	SELBZ01_EQU1(a0),d0			; load BG position
		jsr	(WriteScroll-($08*2))			; write construction cranes
		move.w	SELBZ01_EQU2(a0),d0			; load next BG position
		jsr	(WriteScroll-($18*2))			; write bushes on bottom
		move.w	SELBZ01_EQU3(a0),d0			; load next BG position
		jsr	(WriteScroll-($08*2))			; write bushes on bottom
		move.w	SELBZ01_EQU4(a0),d0			; load next BG position
		jsr	(WriteScroll-($08*2))			; write bushes on bottom

	; --- Back to normal FG position ---

		move.l	SELBZ01_EQU0(a0),d0			; load scroll position (fastest)
		move.w	SELBZ01_EQU5(a0),d0			; load next BG position
		jmp	(WriteScroll-($48*2))			; write bushes on bottom

; ===========================================================================
