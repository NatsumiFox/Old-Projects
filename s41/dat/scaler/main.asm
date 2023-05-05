m	SECTION org(0)
	opt m+
	opt oz+

f macro
	objend
	PUSHS
z	SECTION file("offs.dat")
	endm

o macro name
@a = offset(\name)
	dc.l @a
	endm

n macro
	POPS
	endm

	obj $FFFF8000
width_pixels	= 96/8-1
	rept width_pixels
		clr.l	(a1)+
		lea	28(a1),a1
	endr
		clr.l	(a1)+
		rts

	include "out.asm"
