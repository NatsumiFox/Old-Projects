fademus_id	equ height
fademus_delay	equ render
; ---------------------------------------------------------------------------

Obj_FadeToLevelMusic:
		bsr.s	GetZoneMusic
		move.b	d0,fademus_id(a0)
; ---------------------------------------------------------------------------

Obj_FadeToMusic:
		st	MusFade_InProgress.w
		move.w	#120,fademus_delay(a0)
		_moveq	$E1,d0
		jsr	PlayMusic.w
		move.l	#.wait,(a0)

.wait		subq.w	#1,fademus_delay(a0)
		bpl.s	locret_8405E
		move.b	fademus_id(a0),d0
		jsr	PlayMusic.w
		sf	MusFade_InProgress.w
		jmp	DeleteObject_This.w
; ---------------------------------------------------------------------------

PlayZoneMusic:
		pea	PlayMusic.w
; ---------------------------------------------------------------------------

GetZoneMusic:
		moveq	#1,d0
		move.b	Super_Flag.w,d1		; get super player flag
		or.b	Super_Tails_Flag.w,d1	; get super tails flag too
		bne.s	locret_8405E		; branch if nonzero

		moveq	#0,d0
		move.b	Current_Mus.w,d0

locret_8405E:
		rts
; ---------------------------------------------------------------------------
