; ===========================================================================
; ---------------------------------------------------------------------------
; Test for 68000 optimization
; ---------------------------------------------------------------------------

test1	equ	$FFFF8002
test2	equ	$8000
label:
	add.w	#2,0(a2)
	move.l	#-$20,d0
	move.w	test2,test1
	jmp	test1
	jmp	test2
	bra.w	label
