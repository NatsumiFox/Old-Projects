; ---------------------------------------------------------------------------
; Object 39 - "GAME OVER" and "TIME OVER"
; ---------------------------------------------------------------------------

GameOverCard:
		move.l	#Over_Move,(a0)
		move.w	#$50,obX(a0)	; set x-position
		btst	#0,obFrame(a0)	; is the object	"OVER"?
		beq.s	Over_1stWord	; if not, branch
		move.w	#$1F0,obX(a0)	; set x-position for "OVER"

Over_1stWord:
		move.w	#$F0,obY(a0)
		move.l	#Map_Over,obMap(a0)
		move.w	#$8000|($D940/32),obGfx(a0)
		move.b	#0,obRender(a0)
	display		0, a0

Over_Move:	; Routine 2
		subq.w	#3,HudPos.w	; sub from hud pos
		cmp.w	#-$80,HudPos.w	; check if pos is this
		bgt.s	Over_Next	; if rong, branch

		move.l	#@wait,(a0)
		tst.b	KosMmodNum.w	; are the pattern load cues empty?
		bne.s	@wait		; if not, branch
		moveq	#3,d0
		jsr	AddPLC		; load game over patterns

@wait		tst.b	KosMmodNum.w	; are the pattern load cues empty?
		beq.s	Over_Next	; if yes, branch
		move.l	#@oops,(a0)

@oops		moveq	#$10,d1		; set horizontal speed
		cmpi.w	#$120,obX(a0)	; has item reached its target position?
		beq.s	Over_SetWait	; if yes, branch
		bcs.s	Over_UpdatePos
		neg.w	d1

Over_UpdatePos:
		add.w	d1,obX(a0)	; change item's position

Over_Next:
	NEXT_OBJ
; ===========================================================================

Over_SetWait:
		move.w	#720,obTimeFrame(a0) ; set time delay to 12 seconds
		move.l	#Over_Wait,(a0)
; ===========================================================================

Over_Wait:	; Routine 4
		move.b	(v_jpadpress1).w,d0
		andi.b	#btnABC,d0	; is button A, B or C pressed?
		bne.s	Over_ChgMode	; if yes, branch
		btst	#0,obFrame(a0)
		bne.s	Over_Display

		tst.w	obTimeFrame(a0)	; has time delay reached zero?
		beq.s	Over_ChgMode	; if yes, branch
		subq.w	#1,obTimeFrame(a0) ; subtract 1 from time delay
		bra.s	Over_Display
; ===========================================================================

Over_ChgMode:
		tst.b	(f_timeover).w	; is time over flag set?
		bne.s	Over_ResetLvl	; if yes, branch

		move.b	#id_Sega,(v_gamemode).w ; set mode to 0 (Sega screen)
		clr.b	v_Act.w
		move.b	#3,v_lives.w
		jsr	UpdateSRAM.w
		bra.s	Over_Display
; ===========================================================================

Over_ResetLvl:
		clr.l	(v_lamp_time).w
		st	(f_restart).w ; restart level

Over_Display:
	NEXT_OBJ
