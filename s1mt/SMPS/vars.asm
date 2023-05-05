
; ---------------------------------------------------------------
; Memory map
; ---------------------------------------------------------------

VDP_Data	equ	$C00000
VDP_Ctrl	equ	$C00004

Joypad		equ	-6
VBlank_Wait	equ	-2

; ---------------------------------------------------------------
; Various definitions
; ---------------------------------------------------------------

PlaneA		equ	$C000
PlaneB		equ	$E000
HSRAM		equ	$FC00
FontBase	equ	('!'-1)*$20

; Joypad buttons
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

Held		equ	0
Press		equ	1

