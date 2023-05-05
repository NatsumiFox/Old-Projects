
; =============================================================
; Joypad button indexes & values
; For theld and tpress macros
; -------------------------------------------------------------

; $FFFFF602	= SonicControl|Held
; $FFFFF603	= SonicControl|Press
; $FFFFF604	= Joypad|Held
; $FFFFF605	= Joypad|Press  

SonicControl	equ	$FFFFF602
Joypad		equ	$FFFFF604

Held		equ	0
Press		equ	1

iStart		equ 	7
iA		equ 	6
iC		equ 	5
iB		equ 	4
iRight		equ 	3
iLeft		equ 	2
iDown		equ 	1
iUp		equ 	0

Start		equ 	1<<7
A		equ 	1<<6
C		equ 	1<<5
B		equ 	1<<4
Right		equ 	1<<3
Left		equ 	1<<2
Down		equ 	1<<1
Up		equ 	1

; =============================================================
; Macro to check button presses
; Arguments:	1 - buttons to check
;		2 - bitfield to check
; -------------------------------------------------------------
tpress	macro
	move.b	(\2+1),d0
	andi.b	#\1,d0
	endm

; =============================================================
; Macro to check if buttons are held
; Arguments:	1 - buttons to check
;		2 - bitfield to check
; -------------------------------------------------------------
theld	macro
	move.b	\2,d0
	andi.b	#\1,d0
	endm

; =============================================================
; Macro to align data
; Arguments:	1 - align value
; -------------------------------------------------------------
align	macro
	cnop 0,\1
	endm

; =============================================================
; Macro to set VRAM write access
; Arguments:	1 - raw VRAM offset
;		2 - register to write access bitfield in (Optional)
; -------------------------------------------------------------
vram	macro
	if (narg=1)
		move.l	#($40000000+((\1&$3FFF)<<16)+((\1&$C000)>>14)),($C00004).l
	else
		move.l	#($40000000+((\1&$3FFF)<<16)+((\1&$C000)>>14)),\2
	endc
	endm

; =============================================================
; Macro to raise an error in vectors
; Arguments:	1 - error number
;		2 - branch location
;		3 - if exists, adds 2 to stack pointer
; -------------------------------------------------------------
raise	macro
	move.b	#\1,($FFFFFC44).w
	if narg=3
		addq.l	#2,2(sp)
	endc
	bra.s	\2
	endm
	


; =============================================================
stopZ80		macro
 		move.w	#$100,($A11100).l
		nop
		nop
		nop

@wait\@:	btst	#0,($A11100).l
		bne.s	@wait\@
		endm

; =============================================================

startZ80	macro
		move.w	#0,($A11100).l	; start	the Z80
		endm

; =============================================================

waitYM		macro
@wait\@:	move.b	($A04000).l,d2
		btst	#7,d2
		bne.s	@wait\@
		endm