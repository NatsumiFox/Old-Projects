; ===========================================================================
; ---------------------------------------------------------------------------
; Scroll Data - Angel Island Zone 2
; ---------------------------------------------------------------------------

		move.b	(a2),d0					; FG delay timer
		addq.b	#$01,(a2)				; increase timer
		move.w	d0,d1					; make a copy for BG (they are separately timed)
		andi.w	#$001F*2,d0				; get within 20 frames, and a multiple of 2 (and delay a single frame)
		andi.w	#$007C,d1				; get within 20 frames, and a multiple of 2 (and delay three frames)
		lsr.w	#$01,d1					; ''
		lea	(SEAIZ02_WaveFG).l,a2			; load FG and BG wave data tables
		lea	(SEAIZ02_WaveBG).l,a3			; ''
		adda.w	d0,a2					; advance wave positions correctly
		adda.w	d1,a3					; ''


		move.w	(EMM_ScrollSpeed+$00+$02).w,d0		; load FG scroll position

		; The +$02 is for reversed speed...
		;
		; note some of these have an extra "-2", this is because the scroll position
		; RAM is interlaced such that it's:
		;
		;	+1000
		;	-1000
		;	-0FC0
		;	+0FC0
		;	+0F80
		;	-0F80
		;	etc...
		;
		; The positive/negative switches (this is for optimisation purposes in the
		; routine that creates the positions/speeds).

		swap	d0
		move.w	(EMM_ScrollSpeed+$5C+$02-2).w,d0	; load BG scroll position
		swap	d0
		moveq	#($0020/8)-1,d2				; set size
		bsr.w	SEAIZ02_Write				; write scroll positions

		swap	d0
		move.w	(EMM_ScrollSpeed+$68+$02).w,d0		; load BG scroll position
		swap	d0
		moveq	#($0018/8)-1,d2				; set size
		bsr.w	SEAIZ02_Write				; write scroll positions

		swap	d0
		move.w	(EMM_ScrollSpeed+$74+$02-2).w,d0	; load BG scroll position
		swap	d0
		moveq	#($0018/8)-1,d2				; set size
		bsr.w	SEAIZ02_Write				; write scroll positions

		swap	d0
		move.w	(EMM_ScrollSpeed+$80+$02).w,d0		; load BG scroll position
	;	swap	d0
	;	moveq	#($0068/8)-1,d2				; set size

SEAIZ02_Single:
	rept $68
		move.l	d0,d3					; load positions
		add.w	(a3)+,d3				; add BG wave position
		move.l	d3,(a1)+				; save too scroll table
	endm
	;	dbf	d2,SEAIZ02_Single			; repeat for number of scroll positions

	;	swap	d0
		move.w	(EMM_ScrollSpeed+$80+$02).w,d0		; load BG scroll position
		swap	d0
		moveq	#($0048/8)-1,d2				; set size
;		bsr.s	SEAIZ02_Write				; write scroll positions

;		moveq	#$00,d0					; clear d0

;	rept $20
;		move.l	d0,(a1)+				; write null scroll positions (for black boarder)
;	endm
;		rts						; return

SEAIZ02_Write:
	rept 8
		move.l	d0,d3					; load positions
		add.w	(a2)+,d3				; add FG wave position
		swap	d3					; get BG
		add.w	(a3)+,d3				; add BG wave position
		move.l	d3,(a1)+				; save to scroll table
	endm
		dbf	d2,SEAIZ02_Write			; repeat for number of scroll positions
		rts						; return

SEAIZ02_WaveFG:	rept	($E0/$20)+1
		dc.w	$0000,$0000,$0001,$0001,$0000,$0000,$0000,$0000,$0001,$0000,$0000,$0000,$0000,$0001,$0000,$0000
		dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0001,$0000,$0000,$0001,$0001,$0000,$0000
		endm

SEAIZ02_WaveBG:	rept	($E0/$20)+1
		dc.w	$FFFE,$0001,$0002,$0002,$FFFF,$0002,$0002,$0001,$0002,$FFFF,$FFFE,$FFFE,$FFFE,$0001,$FFFF,$FFFF
		dc.w	$FFFF,$0000,$FFFE,$0000,$0000,$0000,$FFFE,$0000,$FFFE,$0002,$0000,$FFFE,$0002,$0002,$FFFF,$FFFE
		endm

; ===========================================================================