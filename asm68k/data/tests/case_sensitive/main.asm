; ===========================================================================
; ---------------------------------------------------------------------------
; Test instructions and variables work as case sensitive
; ---------------------------------------------------------------------------

test	equ	1
TEST	EQU	2
	move.w	test,d2
	MOVE.W	TEST,A4

mv	rename	move
	mv.w	(pc),d7

yes	rename	SP
	MOVE.W	yes,(yes)
