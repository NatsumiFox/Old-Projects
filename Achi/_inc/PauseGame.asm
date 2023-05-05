; ---------------------------------------------------------------------------
; Subroutine to	pause the game
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


PauseGame:
		tst.b	(v_lives).w	; do you have any lives	left?
		beq.s	Unpause		; if not, branch
		btst	#bitStart,(v_jpadpress1).w ; is Start button pressed?
		beq.s	Pause_DoNothing	; if not, branch

Pause_StopGame:
		st	(f_pause).w	; freeze time
	AMPS_MUSPAUSE ; pause music
		jsr	ListAchi(pc)		; list achi
	AMPS_MUSUNPAUSE

Unpause:
		clr.w	(f_pause).w	; unpause the game

Pause_DoNothing:
		rts

