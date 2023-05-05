; ===========================================================================
; ---------------------------------------------------------------------------
; Scroll Data - Random
; ---------------------------------------------------------------------------

		lea	(EMM_PosY_BG1).l,a3			; load slot 1 Y positions
		tst.b	EMM_SlotID				; check if we are using slot 1
		beq.s	SDRAN_Slot1				; if so, branch
		lea	(EMM_PosY_BG2).l,a3			; load slot 2 Y positions

SDRAN_Slot1:	moveq	#$00,d0					; clear d0
		move.b	(a2),d0					; load angle
		add.w	#$0020,(a2)				; increase angle for next frame
		add.w	d0,d0					; multiply by size of word

		lea	(SineTable+$01).l,a0			; load sinewave table
		move.l	-$01(a0,d0.w),d1			; load sinewave Y position
		clr.w	d1					; clear fraction
		asr.l	#$06,d1					; divide into fraction
		add.l	d1,EMM_PosY_FG1-EMM_PosY_BG1(a3)	; write to FG
		asr.l	#$01,d1					; slow down for BG
		add.l	d1,(a3)					; write to BG

		move.l	+$7F(a0,d0.w),d0			; load sinewave X position
		clr.w	d0					; clear fraction
		asr.l	#$06,d0					; divide into fraction
		move.w	(a1),d1					; load current position
		add.w	d0,$02(a2)				; add fraction
		swap	d0					; then add quotient
		addx.w	d0,d1					; ''
		move.w	d1,d0					; convert to double word
		swap	d0					; ''
		move.w	d1,d0					; ''
		move.l	d0,d1					; keep a copy in d1

		asr.w	#$01,d0					; slow BG down to x2
		jsr	(WriteScroll-($40*2))			; write scroll data
		asr.w	#$02,d0					; slow down BG to x8
		jsr	(WriteScroll-($40*2))			; write scroll data
		move.l	d1,d2					; get FG but slowed down to 3/4th
		asr.l	#$02,d2					; ''
		move.l	d1,d0					; ''
		sub.l	d2,d0					; ''
		move.w	d1,d0					; load BG
		asr.w	#$02,d0					; slow BG down by x4
		jsr	(WriteScroll-($40*2))			; write scroll data
		asr.w	#$01,d0					; slow down BG to x8
		jmp	(WriteScroll-($40*2))			; write scroll data

; ===========================================================================