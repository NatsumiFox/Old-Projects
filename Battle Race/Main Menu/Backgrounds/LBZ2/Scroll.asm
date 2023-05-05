; ===========================================================================
; ---------------------------------------------------------------------------
; Scroll Data - Launch Base Zone 2
; ---------------------------------------------------------------------------

		lea	(EMM_PosY_BG1).l,a3			; load slot 1 Y positions
		tst.b	EMM_SlotID				; check if we are using slot 1
		beq.s	SDLBZ2_Slot1				; if so, branch
		lea	(EMM_PosY_BG2).l,a3			; load slot 2 Y positions

SDLBZ2_Slot1:
		moveq	#$00,d0					; clear d0
		move.b	(EMM_ScrollSpeed+(((($1000-$0800)/$40)*4)+$01)).l,d0	; load scroll position
		addi.b	#$80-$10,d0				; rotate so that the rotation is inline with the pipes
		add.w	d0,d0					; multiply by size of word
		lea	(SineTable).l,a0			; load sinewave table
		move.w	(a0,d0.w),d0				; load position
		asr.w	#$03,d0					; divide to x20 pixels (distance of water when maximum on-screen)
		moveq	#$10,d1					; prepare starting position (middle of plane)
		move.w	d0,d2					; load Y position
		add.w	d1,d2					; add middle position
		move.w	d2,EMM_PosY_FG1-EMM_PosY_BG1(a3)	; write to FG
		asr.w	#$01,d0					; slow down by 2 for BG
		add.w	d1,d0					; add middle position
		move.w	d0,(a3)					; write to BG

SELBZ02_EQU1	=	(((($1000-$0100)/$40)*4)+$00)		; Clouds/Underwater
SELBZ02_EQU2	=	(((($1000-$0180)/$40)*4)+$00)		; Mounts
SELBZ02_EQU3	=	(((($1000-$0200)/$40)*4)+$00)		; grass
SELBZ02_EQU4	=	(((($1000-$0300)/$40)*4)+$00)		; rocks underwater

		lea	(EMM_ScrollSpeed).l,a0			; load scroll speed list
		move.w	(a0),d0					; load FG position
		swap	d0					; send to upper word
		move.w	SELBZ02_EQU1(a0),d0			; load BG position
		jsr	(WriteScroll-($10*2))			; do cloudes
		move.w	SELBZ02_EQU2(a0),d0			; load BG position
		jsr	(WriteScroll-($60*2))			; do the mountains

		move.w	EMM_PosY_FG1-EMM_PosY_BG1(a3),d1	; get distance between FG and BG
		sub.w	(a3),d1					; ''
		lea	(WriteScroll).l,a3			; load scroll writing address into a3
		bmi.s	SDLBZ2_Bottom				; if the distance is positive, water is below the line, so branch

	; --- Above the water line ---

		move.w	SELBZ02_EQU3(a0),d0			; load BG position
		move.w	#-$0010,d2				; prepare grass size
		add.w	d1,d2					; add water distance
		add.w	d2,d2					; convert to size of word
		jsr	(a3,d2.w)				; do grass section

		tst.w	d1					; are there any water scanlines to do?
		beq.s	SDLBZ2_NoWater				; if not, branch

		move.w	d0,d2					; get speed distance
		sub.w	(a0),d2					; ''
		ext.l	d2					; extend to long-word for division
		asl.l	#$04,d2					; create fraction
		divs.w	d1,d2					; get "subtract" amount
		swap	d2					; move quotient to upper word
		clr.w	d2					; ''
		asr.l	#$04,d2					; shift fraction into position
		move.l	(a0),d3					; load FG position
		clr.w	d3					; clear fraction
		move.w	d1,d4					; get number of water scanlines
		subq.w	#$01,d4					; minus 1 for dbf

SDLBZ2_TopWater:
		swap	d3					; get quotient
		move.w	d3,d0					; save BG's scroll position
		move.l	d0,(a1)+				; write scroll positions
		swap	d3					; restore fraction
		add.l	d2,d3					; slow water down
		dbf	d4,SDLBZ2_TopWater			; repeat for all water scanlines

SDLBZ2_NoWater:
		move.w	SELBZ02_EQU1(a0),d0			; load BG position
		jsr	(WriteScroll-($78*2))			; underwater
		move.w	SELBZ02_EQU4(a0),d0			; load BG position
		jsr	(WriteScroll-($08*2))			; do rocks
		bra.w	SDLBZ2_WaterWave			; continue to do water wave

	; --- Below the water line ---

SDLBZ2_Bottom:
		move.w	SELBZ02_EQU3(a0),d0			; load BG position
		jsr	(WriteScroll-($10*2))			; do the grass sectiom

		move.w	d0,d2					; get speed distance
		sub.w	(a0),d2					; ''
		ext.l	d2					; extend to long-word for division
		asl.l	#$04,d2					; create fraction
		divs.w	d1,d2					; get "subtract" amount
		swap	d2					; move quotient to upper word
		clr.w	d2					; ''
		asr.l	#$04,d2					; shift fraction into position
		move.l	SELBZ02_EQU3(a0),d3			; load BG position
		clr.w	d3					; clear fraction
		move.w	d1,d4					; get number of water scanlines
		neg.w	d4					; convert to positive
		subq.w	#$01,d4					; minus 1 for dbf

SDLBZ2_BottomWater:
		swap	d3					; get quotient
		move.w	d3,d0					; save BG's scroll position
		move.l	d0,(a1)+				; write scroll positions
		swap	d3					; restore fraction
		add.l	d2,d3					; speed water up
		dbf	d4,SDLBZ2_BottomWater			; repeat for all water scanlines

		move.w	#-$0078,d2				; prepare size of underwater
		sub.w	d1,d2					; minus water distance
		add.w	d2,d2					; convert to size of word
		move.w	SELBZ02_EQU1(a0),d0			; load BG position
		jsr	(a3,d2.w)				; do the underwater section
		move.w	SELBZ02_EQU4(a0),d0			; load BG position
		jsr	(WriteScroll-($08*2))			; do rocks

SDLBZ2_WaterWave:
		move.b	(a2),d0					; load wave counter
		addq.b	#$01,(a2)				; increase it
		asr.b	#$01,d0					; divide by 2
		andi.w	#$007E,d0				; keep within range of scanline elements in array
		lea	(LBZ_WaterWaveArray).l,a0		; load water wave array
		adda.w	d0,a0					; advance to correct starting point

		neg.w	d1					; convert to negative
		subi.w	#$0080,d1				; add size of water line to d1
		add.w	d1,d1					; multiply by three words (three instructions below)
		move.w	d1,d0					; ''
		add.w	d1,d1					; ''
		add.w	d0,d1					; ''
		lea	(SDLBZ2_AddWave).l,a3			; load end of write list
		subq.w	#$02,a1					; go back to BG scroll slot
		jmp	(a3,d1.w)				; jump to correct scroll writing length
	rept	$80+$10
		move.w	-(a0),d0				; load scroll wave adjustment
		add.w	d0,(a1)					; adjust current scroll position
		subq.w	#$04,a1					; move back to previous scanline
	endm
SDLBZ2_AddWave:
		rts						; return

; ===========================================================================










		lea	($FFFFA9DE).w,a1
		lea	(LBZ_WaterWaveArray).l,a5	; Water wave array
		move.w	(Level_frame_counter).w,d1
		asr.w	#1,d1
		andi.w	#$7E,d1
		adda.w	d1,a5
		lsr.w	#1,d0
		bcc.s	moc_54802

moc_547FE:
		move.w	-(a5),d3
		add.w	d3,-(a1)

moc_54802:
		move.w	-(a5),d3
		add.w	d3,-(a1)
		dbf	d0,moc_547FE

mocret_5480A:
		rts


