
; Format:	UC00RTTT
;		U = Uncollectable
;		C = Collected
;		T = Type display
;		R = Ring
;		    Uncollected versions...
;			0 = Blank
;			1 = Star Bumper
;			2 = Blue | Grey | Blue
;			3 = Blue | Grey | Orange
;			4 = ---Free---
;			5 = Red (Layout default)
;			6 = Red  | Blue
;			7 = Red  | Orange

_	=	$80	; Blank Space
X	=	$45	; Red Sphere
T	=	$81	; Star Sphere
B	=	$02	; Blue Sphere
O	=	$03	; Orange Sphere
R	=	$88	; Rings
Y	=	$84	; Yellow Spring (Just using grey for now...)

	dc.w	Random	; A Dummy map for the "Random" level select display...

	dc.w	Map01
	dc.w	Map02
	dc.w	Map03
	dc.w	Map04
	dc.w	Map05
	dc.w	Map06
	dc.w	Map07
	dc.w	Map08
	dc.w	Map09
	dc.w	Map10

	dc.w	$0000	; end of list

; ===========================================================================
; ---------------------------------------------------------------------------
; Stage FF - Random slot
; ---------------------------------------------------------------------------

	dc.b	"? ? ? ? ?",$FF		; Game
	dc.b	" ? ? ? ? ",$00
	dc.b	" ? ? ? ?",$00		; Level
	dc.b	"???",$00		; Difficulty
	even

Random:	dc.w	$0444,$0AAA		; Stage floor colours
	dc.w	$0000,$0444,$0CCC	; Stage BG colours
	dc.b	$00,$00,$00		; Player 1's starting X, Y and Angle
	dc.b	$00,$00,$00		; Player 2's starting X, Y and Angle

	dc.b	_,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_
	dc.b	_,B,B,B,B,B,B,_, _,X,X,X,X,X,X,_, _,O,O,O,O,O,O,_, _,T,T,T,T,T,T,_
	dc.b	_,B,B,_,_,B,B,_, _,X,X,_,_,X,X,_, _,O,O,_,_,O,O,_, _,T,T,_,_,T,T,_
	dc.b	_,_,_,_,_,B,B,_, _,_,_,_,_,X,X,_, _,_,_,_,_,O,O,_, _,_,_,_,_,T,T,_
	dc.b	_,_,_,B,B,B,B,_, _,_,_,X,X,X,X,_, _,_,_,O,O,O,O,_, _,_,_,T,T,T,T,_
	dc.b	_,_,_,B,B,_,_,_, _,_,_,X,X,_,_,_, _,_,_,O,O,_,_,_, _,_,_,T,T,_,_,_
	dc.b	_,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_
	dc.b	_,_,_,B,B,_,_,_, _,_,_,X,X,_,_,_, _,_,_,O,O,_,_,_, _,_,_,T,T,_,_,_

	dc.b	_,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_
	dc.b	_,X,X,X,X,X,X,_, _,O,O,O,O,O,O,_, _,R,R,R,R,R,R,_, _,O,O,O,O,O,O,_
	dc.b	_,X,X,_,_,X,X,_, _,O,O,_,_,O,O,_, _,R,R,_,_,R,R,_, _,O,O,_,_,O,O,_
	dc.b	_,_,_,_,_,X,X,_, _,_,_,_,_,O,O,_, _,_,_,_,_,R,R,_, _,_,_,_,_,O,O,_
	dc.b	_,_,_,X,X,X,X,_, _,_,_,O,O,O,O,_, _,_,_,R,R,R,R,_, _,_,_,O,O,O,O,_
	dc.b	_,_,_,X,X,_,_,_, _,_,_,O,O,_,_,_, _,_,_,R,R,_,_,_, _,_,_,O,O,_,_,_
	dc.b	_,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_
	dc.b	_,_,_,X,X,_,_,_, _,_,_,O,O,_,_,_, _,_,_,R,R,_,_,_, _,_,_,O,O,_,_,_

	dc.b	_,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_
	dc.b	_,B,B,B,B,B,B,_, _,X,X,X,X,X,X,_, _,O,O,O,O,O,O,_, _,X,X,X,X,X,X,_
	dc.b	_,B,B,_,_,B,B,_, _,X,X,_,_,X,X,_, _,O,O,_,_,O,O,_, _,X,X,_,_,X,X,_
	dc.b	_,_,_,_,_,B,B,_, _,_,_,_,_,X,X,_, _,_,_,_,_,O,O,_, _,_,_,_,_,X,X,_
	dc.b	_,_,_,B,B,B,B,_, _,_,_,X,X,X,X,_, _,_,_,O,O,O,O,_, _,_,_,X,X,X,X,_
	dc.b	_,_,_,B,B,_,_,_, _,_,_,X,X,_,_,_, _,_,_,O,O,_,_,_, _,_,_,X,X,_,_,_
	dc.b	_,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_
	dc.b	_,_,_,B,B,_,_,_, _,_,_,X,X,_,_,_, _,_,_,O,O,_,_,_, _,_,_,X,X,_,_,_

	dc.b	_,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_
	dc.b	_,T,T,T,T,T,T,_, _,B,B,B,B,B,B,_, _,X,X,X,X,X,X,_, _,B,B,B,B,B,B,_
	dc.b	_,T,T,_,_,T,T,_, _,B,B,_,_,B,B,_, _,X,X,_,_,X,X,_, _,B,B,_,_,B,B,_
	dc.b	_,_,_,_,_,T,T,_, _,_,_,_,_,B,B,_, _,_,_,_,_,X,X,_, _,_,_,_,_,B,B,_
	dc.b	_,_,_,T,T,T,T,_, _,_,_,B,B,B,B,_, _,_,_,X,X,X,X,_, _,_,_,B,B,B,B,_
	dc.b	_,_,_,T,T,_,_,_, _,_,_,B,B,_,_,_, _,_,_,X,X,_,_,_, _,_,_,B,B,_,_,_
	dc.b	_,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_, _,_,_,_,_,_,_,_
	dc.b	_,_,_,T,T,_,_,_, _,_,_,B,B,_,_,_, _,_,_,X,X,_,_,_, _,_,_,B,B,_,_,_

; ===========================================================================
; ---------------------------------------------------------------------------
; Stage 01 - 
; ---------------------------------------------------------------------------

	dc.b	"Sonic 3  ",$FF		; Game
	dc.b	"         ",$00
	dc.b	"1       ",$00		; Level
	dc.b	"5  ",$00		; Difficulty
	even

Map01:	dc.w	$008E,$0026		; Stage floor colours
	dc.w	$0E40,$0EA0,$0EEA	; Stage BG colours
	dc.b	$02,$02,$04		; Player 1's starting X, Y and Angle
	dc.b	$03,$1D,$00		; Player 2's starting X, Y and Angle

	dc.b	X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,_,_,_,_,_,_,_,_,_,_,_,_,_,T,T,_,_,_,_,_,_,_,_,_,_,_,_,_,X,X
	dc.b	X,X,_,_,_,_,_,_,_,_,_,_,_,_,_,T,T,_,_,_,_,_,_,_,_,_,_,_,_,_,X,X
	dc.b	X,X,_,_,B,B,B,B,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,B,B,B,O,_,_,X,X
	dc.b	X,X,_,_,B,B,B,O,_,_,B,O,_,_,_,T,T,_,_,_,B,O,_,_,B,B,O,O,_,_,X,X
	dc.b	X,X,_,_,B,B,O,O,_,_,O,B,_,_,_,T,T,_,_,_,O,B,_,_,B,O,O,O,_,_,X,X
	dc.b	X,X,_,_,B,O,O,O,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,O,O,O,O,_,_,X,X
	dc.b	X,X,_,_,_,_,_,_,_,_,_,_,_,_,_,T,T,_,_,_,_,_,_,_,_,_,_,_,_,_,X,X
	dc.b	X,X,_,_,_,_,_,_,_,_,_,_,_,_,_,T,T,_,_,_,_,_,_,_,_,_,_,_,_,_,X,X
	dc.b	X,X,_,_,_,_,_,_,_,_,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,_,_,_,_,_,X,X
	dc.b	X,X,_,_,_,_,_,_,_,_,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,_,_,_,_,_,X,X
	dc.b	X,X,_,_,T,B,T,T,_,_,X,X,X,X,X,X,X,X,X,X,X,X,_,_,T,T,O,T,_,_,X,X
	dc.b	X,X,_,_,T,B,O,T,_,_,X,X,X,X,X,X,X,X,X,X,X,X,_,_,T,B,O,T,_,_,X,X
	dc.b	X,X,_,_,T,T,O,T,_,_,X,X,X,X,X,X,X,X,X,X,X,X,_,_,T,B,T,T,_,_,X,X
	dc.b	X,X,_,_,T,B,O,T,_,_,X,X,X,X,X,X,X,X,X,X,X,X,_,_,T,B,O,T,_,_,X,X
	dc.b	X,X,_,_,T,B,T,T,_,_,X,X,X,X,X,X,X,X,X,X,X,X,_,_,T,T,O,T,_,_,X,X
	dc.b	X,X,_,_,T,B,O,T,_,_,X,X,X,X,X,X,X,X,X,X,X,X,_,_,T,B,O,T,_,_,X,X
	dc.b	X,X,_,_,T,T,O,T,_,_,X,X,X,X,X,X,X,X,X,X,X,X,_,_,T,B,T,T,_,_,X,X
	dc.b	X,X,_,_,T,T,O,T,_,_,X,X,X,X,X,X,X,X,X,X,X,X,_,_,T,B,T,T,_,_,X,X
	dc.b	X,X,_,_,_,_,_,_,_,_,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,_,_,_,_,_,X,X
	dc.b	X,X,_,_,_,_,_,_,_,_,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,_,_,_,_,_,X,X
	dc.b	X,X,_,_,_,_,_,_,_,_,_,_,_,_,_,T,T,_,_,_,_,_,_,_,_,_,_,_,_,_,X,X
	dc.b	X,X,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,X,X
	dc.b	X,X,_,_,B,B,B,O,_,_,_,_,_,_,_,T,T,_,_,_,_,_,_,_,B,B,B,B,_,_,X,X
	dc.b	X,X,_,_,B,B,O,O,_,_,B,O,_,_,_,T,T,_,_,_,B,O,_,_,B,B,B,O,_,_,X,X
	dc.b	X,X,_,_,B,O,O,O,_,_,O,B,_,_,_,T,T,_,_,_,O,B,_,_,B,B,O,O,_,_,X,X
	dc.b	X,X,_,_,O,O,O,O,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,B,O,O,O,_,_,X,X
	dc.b	X,X,_,_,_,_,_,_,_,_,_,_,_,_,_,T,T,_,_,_,_,_,_,_,_,_,_,_,_,_,X,X
	dc.b	X,X,_,_,_,_,_,_,_,_,_,_,_,_,_,T,T,_,_,_,_,_,_,_,_,_,_,_,_,_,X,X
	dc.b	X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X

; ===========================================================================
; ---------------------------------------------------------------------------
; Stage 02 - 
; ---------------------------------------------------------------------------

	dc.b	"Sonic 3  ",$FF		; Game
	dc.b	"         ",$00
	dc.b	"2       ",$00		; Level
	dc.b	"5  ",$00		; Difficulty
	even

Map02:	dc.w	$0AE0,$0062		; Stage floor colours
	dc.w	$0604,$0A6C,$0EEE	; Stage BG colours
	dc.b	$05,$00,$00		; Player 1's starting X, Y and Angle
	dc.b	$10,$1B,$02		; Player 2's starting X, Y and Angle

	dc.b	X,X,X,X,_,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,X,X,_,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,_,_,_,_,_,_
	dc.b	X,X,X,X,_,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,_,_,_,_,_,_
	dc.b	X,X,X,X,_,_,_,X,X,X,X,T,T,T,T,T,T,T,T,T,X,X,X,_,_,B,B,B,B,B,_,_
	dc.b	X,X,X,T,_,_,_,_,_,_,_,B,B,B,B,_,B,B,B,B,_,_,_,_,_,B,T,T,T,B,_,_
	dc.b	X,X,X,T,_,_,_,_,_,_,_,B,B,B,B,_,B,B,B,B,_,_,_,_,_,B,T,T,T,B,_,_
	dc.b	X,X,X,T,_,_,_,_,_,_,_,B,B,B,B,_,B,B,B,B,_,_,_,_,_,B,T,T,T,B,_,_
	dc.b	X,X,X,X,T,T,T,X,X,X,X,T,T,T,T,T,T,T,T,T,X,X,X,_,_,B,B,B,B,B,_,_
	dc.b	X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,_,_,_,_,_,_
	dc.b	X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,_,_,_,_,_,_
	dc.b	X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,X,X,X
	dc.b	X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,X,X,X
	dc.b	X,X,X,X,X,X,X,X,X,X,X,_,_,_,_,_,_,_,_,_,_,_,X,X,X,T,_,_,_,T,X,X
	dc.b	X,X,X,X,X,X,X,X,X,X,X,_,_,_,_,_,_,_,_,_,_,_,X,X,X,T,_,_,_,T,X,X
	dc.b	X,X,X,X,X,T,T,T,T,X,X,_,_,_,_,_,_,_,_,_,_,_,X,X,X,T,_,_,_,T,T,T
	dc.b	_,_,_,_,_,B,B,B,B,_,_,_,_,_,B,B,B,B,B,_,_,_,X,X,X,T,_,_,_,_,_,_
	dc.b	_,_,_,_,_,B,B,B,B,_,_,_,_,_,B,B,B,B,B,_,_,_,X,X,X,T,_,_,_,_,_,_
	dc.b	_,_,_,_,_,B,B,B,B,_,_,_,_,_,B,B,B,B,B,_,_,_,X,X,X,T,_,_,_,_,_,_
	dc.b	X,X,X,X,X,T,T,T,T,X,X,_,_,_,_,_,_,_,_,_,_,_,X,X,X,T,_,_,_,T,T,T
	dc.b	X,X,X,X,X,X,X,X,X,X,X,_,_,_,_,_,_,_,_,_,_,_,X,X,X,T,_,_,_,T,X,X
	dc.b	X,X,X,X,X,X,X,X,X,X,X,_,_,_,_,_,_,_,_,_,_,_,X,X,X,T,_,_,_,T,X,X
	dc.b	X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,X,X,X,X,X,X,X,T,B,B,B,T,X,X
	dc.b	X,X,X,X,X,X,X,X,X,X,X,X,X,X,T,B,B,B,T,X,X,X,X,X,X,T,B,B,B,T,X,X
	dc.b	X,_,_,_,_,_,_,_,_,_,X,X,X,X,T,B,B,B,T,X,X,X,X,X,X,T,B,B,B,T,X,X
	dc.b	X,_,_,_,_,_,_,_,_,_,X,X,X,X,T,B,B,B,T,X,X,X,X,X,X,T,B,B,B,T,X,X
	dc.b	X,_,_,B,B,B,B,B,_,_,X,X,X,T,T,B,B,B,T,T,X,X,T,T,T,T,_,_,_,T,X,X
	dc.b	X,_,_,B,B,B,B,B,_,_,_,_,_,_,_,_,_,_,_,_,_,_,B,B,B,B,_,_,_,T,X,X
	dc.b	X,_,_,B,B,T,B,B,_,_,_,_,_,_,_,_,_,_,_,_,_,_,B,B,B,B,_,_,_,T,X,X
	dc.b	X,_,_,B,B,B,B,B,_,_,_,_,_,_,_,_,_,_,_,_,_,_,B,B,B,B,_,_,_,T,X,X
	dc.b	X,_,_,B,B,B,B,B,_,_,X,X,X,X,T,T,T,T,T,X,X,X,T,T,T,T,T,T,T,T,X,X
	dc.b	X,_,_,_,_,_,_,_,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	X,_,_,_,_,_,_,_,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X

; ===========================================================================
; ---------------------------------------------------------------------------
; Stage 03 - 
; ---------------------------------------------------------------------------

	dc.b	"Sonic 3  ",$FF		; Game
	dc.b	"         ",$00
	dc.b	"3       ",$00		; Level
	dc.b	"5  ",$00		; Difficulty
	even

Map03:	dc.w	$006E,$0AEE		; Stage floor colours
	dc.w	$0E40,$0EA4,$0AEE	; Stage BG colours
	dc.b	$09,$04,$06		; Player 1's starting X, Y and Angle
	dc.b	$01,$01,$04		; Player 2's starting X, Y and Angle

	dc.b	X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,T,B,T,X,X,X,X
	dc.b	X,_,_,_,_,_,_,X,X,_,_,_,_,_,_,T,T,_,_,_,_,_,_,X,X,_,_,_,_,_,_,X
	dc.b	X,_,_,_,_,_,_,X,X,_,_,_,_,_,_,B,B,_,B,B,B,B,_,X,X,_,_,_,_,_,_,X
	dc.b	X,_,_,B,B,_,_,X,X,_,_,T,T,_,_,T,T,_,B,B,B,B,_,X,X,_,_,T,T,_,_,X
	dc.b	X,_,_,B,B,_,_,X,X,_,_,T,T,_,_,X,X,_,B,B,B,B,_,X,X,_,_,T,T,_,_,X
	dc.b	X,_,_,_,_,_,_,X,X,_,_,_,_,_,_,X,X,_,B,B,B,B,_,X,X,_,_,_,_,_,_,X
	dc.b	X,_,_,_,_,_,_,X,X,_,_,_,_,_,_,X,X,_,_,_,_,_,_,X,X,_,_,_,_,_,_,X
	dc.b	X,T,B,T,X,X,X,X,X,T,B,T,X,X,X,X,X,T,B,T,X,X,X,X,X,X,X,X,T,B,T,X
	dc.b	X,T,B,T,X,X,X,X,X,T,B,T,X,X,X,X,X,T,B,T,X,X,X,X,X,X,X,X,T,B,T,X
	dc.b	X,_,_,_,_,_,_,X,X,_,_,_,_,_,_,X,X,_,_,_,_,_,_,X,X,_,_,_,_,_,_,X
	dc.b	X,_,B,B,B,B,_,X,X,_,_,_,_,_,_,X,X,_,_,_,_,_,_,X,X,_,B,B,B,B,_,X
	dc.b	X,_,B,B,B,B,_,X,X,_,_,T,T,_,_,X,X,_,_,T,T,_,_,X,X,_,B,B,B,B,_,X
	dc.b	X,_,B,B,B,B,_,T,T,_,_,T,T,_,_,X,X,_,_,T,T,_,_,T,T,_,B,B,B,B,_,X
	dc.b	X,_,B,B,B,B,_,B,B,_,_,_,_,_,_,X,X,_,_,_,_,_,_,B,B,_,B,B,B,B,_,X
	dc.b	X,_,_,_,_,_,_,T,T,_,_,_,_,_,_,X,X,_,_,_,_,_,_,T,T,_,_,_,_,_,_,X
	dc.b	X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	X,_,_,_,_,_,_,T,T,_,_,_,_,_,_,X,X,_,_,_,_,_,_,T,T,_,_,_,_,_,_,X
	dc.b	X,_,B,B,B,B,_,B,B,_,_,_,_,_,_,X,X,_,_,_,_,_,_,B,B,_,_,_,_,_,_,X
	dc.b	X,_,B,B,B,B,_,T,T,_,_,T,T,_,_,X,X,_,_,T,T,_,_,T,T,_,_,B,B,_,_,X
	dc.b	X,_,B,B,B,B,_,X,X,_,_,T,T,_,_,T,T,_,_,T,T,_,_,X,X,_,_,B,B,_,_,X
	dc.b	X,_,B,B,B,B,_,X,X,_,_,_,_,_,_,B,B,_,_,_,_,_,_,X,X,_,_,_,_,_,_,X
	dc.b	X,_,_,_,_,_,_,X,X,_,_,_,_,_,_,T,T,_,_,_,_,_,_,X,X,_,_,_,_,_,_,X
	dc.b	X,T,B,T,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,T,B,T,X
	dc.b	X,T,B,T,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,T,B,T,X
	dc.b	X,_,_,_,_,_,_,X,X,_,_,_,_,_,_,T,T,_,_,_,_,_,_,X,X,_,_,_,_,_,_,X
	dc.b	X,_,_,_,_,_,_,X,X,_,_,_,_,_,_,B,B,_,B,B,B,B,_,X,X,_,_,T,_,_,_,X
	dc.b	X,_,_,T,T,_,_,X,X,_,_,T,T,_,_,T,T,_,B,B,B,B,_,X,X,_,_,_,_,T,_,X
	dc.b	X,_,_,T,T,_,_,T,T,_,_,T,T,_,_,X,X,_,B,B,B,B,_,X,X,_,T,_,_,_,_,X
	dc.b	X,_,_,_,_,_,_,B,B,_,_,_,_,_,_,X,X,_,B,B,B,B,_,X,X,_,_,_,T,_,_,X
	dc.b	X,_,_,_,_,_,_,T,T,_,_,_,_,_,_,X,X,_,_,_,_,_,_,X,X,_,_,_,_,_,_,X
	dc.b	X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,T,B,T,X,X,X,X

; ===========================================================================
; ---------------------------------------------------------------------------
; Stage 04 - 
; ---------------------------------------------------------------------------

	dc.b	"Sonic 3  ",$FF		; Game
	dc.b	"         ",$00
	dc.b	"4       ",$00		; Level
	dc.b	"5  ",$00		; Difficulty
	even

Map04:	dc.w	$000C,$0EEE		; Stage floor colours
	dc.w	$0000,$00CE,$0AEE	; Stage BG colours
	dc.b	$12,$15,$02		; Player 1's starting X, Y and Angle
	dc.b	$0D,$06,$06		; Player 2's starting X, Y and Angle

	dc.b	T,T,T,T,T,T,T,T,T,T,T,T,T,X,X,T,T,T,X,X,T,T,T,T,T,T,T,T,T,T,T,T
	dc.b	T,X,X,X,X,X,X,X,X,X,X,X,X,X,X,_,B,_,X,X,X,X,X,X,X,X,X,X,X,X,X,T
	dc.b	T,X,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,T
	dc.b	T,X,X,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,X,X,T
	dc.b	T,X,X,_,_,_,_,_,_,_,_,_,_,_,T,B,T,T,_,_,_,_,_,_,_,_,_,_,_,X,X,T
	dc.b	T,X,X,_,_,T,T,T,T,T,T,_,_,_,T,B,B,B,_,_,_,T,T,T,T,T,T,_,_,X,X,T
	dc.b	T,X,X,_,_,T,B,B,B,B,B,_,_,_,T,T,T,T,_,_,_,B,B,B,B,B,T,_,_,X,X,T
	dc.b	T,X,X,_,_,T,B,B,B,T,T,_,_,_,_,_,_,_,_,_,_,T,T,B,B,B,T,_,_,X,X,T
	dc.b	T,X,X,_,_,T,B,B,B,T,_,_,_,_,_,_,_,_,_,_,_,_,T,B,B,B,T,_,_,X,X,T
	dc.b	T,X,X,_,_,T,T,T,B,T,_,_,X,_,_,T,T,_,_,X,_,_,T,T,T,B,T,_,_,X,X,T
	dc.b	T,X,X,_,_,_,_,T,B,T,_,_,X,_,_,T,T,_,_,X,_,_,_,_,T,B,T,_,_,X,X,T
	dc.b	T,X,X,_,_,_,_,_,_,_,_,_,X,_,_,_,_,_,_,X,_,_,_,_,_,_,_,_,_,X,X,T
	dc.b	T,X,X,_,_,_,_,_,_,_,X,X,X,_,B,B,B,B,_,X,X,X,_,_,_,_,_,_,_,X,X,T
	dc.b	T,X,X,_,_,_,_,_,_,_,_,_,_,_,B,B,B,B,_,_,_,_,_,_,_,_,_,_,_,X,X,T
	dc.b	T,X,X,_,_,_,T,B,T,_,_,_,B,B,B,B,B,B,B,B,_,_,_,T,B,T,_,_,_,X,X,T
	dc.b	T,X,X,_,_,_,T,B,T,_,T,T,B,B,B,T,T,B,B,B,T,T,_,T,B,T,_,_,_,X,X,T
	dc.b	T,X,X,_,_,_,T,B,T,_,T,T,B,B,B,T,T,B,B,B,T,T,_,T,B,T,_,_,_,X,X,T
	dc.b	T,X,X,_,_,_,T,B,T,_,_,_,B,B,B,B,B,B,B,B,_,_,_,T,B,T,_,_,_,X,X,T
	dc.b	T,X,X,_,_,_,_,_,_,_,_,_,_,_,B,B,B,B,_,_,_,_,_,_,_,_,_,_,_,X,X,T
	dc.b	T,X,X,_,_,_,_,_,_,_,X,X,X,_,B,B,B,B,_,X,X,X,_,_,_,_,_,_,_,X,X,T
	dc.b	T,X,X,_,_,_,_,_,_,_,_,_,X,_,_,_,_,_,_,X,_,_,_,_,_,_,_,_,_,X,X,T
	dc.b	T,X,X,_,_,T,B,T,_,_,_,_,X,_,_,T,T,_,_,X,_,_,T,B,T,_,_,_,_,X,X,T
	dc.b	T,X,X,_,_,T,B,T,T,T,_,_,X,_,_,T,T,_,_,X,_,_,T,B,T,T,T,_,_,X,X,T
	dc.b	T,X,X,_,_,T,B,B,B,T,_,_,_,_,_,_,_,_,_,_,_,_,T,B,B,B,T,_,_,X,X,T
	dc.b	T,X,X,_,_,T,B,B,B,T,T,_,_,_,_,_,_,_,_,_,_,T,T,B,B,B,T,_,_,X,X,T
	dc.b	T,X,X,_,_,T,B,B,B,B,B,_,_,_,T,T,T,T,_,_,_,B,B,B,B,B,T,_,_,X,X,T
	dc.b	T,X,X,_,_,T,T,T,T,T,T,_,_,_,B,B,B,T,_,_,_,T,T,T,T,T,T,_,_,X,X,T
	dc.b	T,X,X,_,_,_,_,_,_,_,_,_,_,_,T,T,B,T,_,_,_,_,_,_,_,_,_,_,_,X,X,T
	dc.b	T,X,X,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,X,X,T
	dc.b	T,X,X,X,X,X,X,X,X,X,X,X,X,X,X,_,B,_,X,X,X,X,X,X,X,X,X,X,X,X,X,T
	dc.b	T,X,X,X,X,X,X,X,X,X,X,X,X,X,X,T,T,T,X,X,X,X,X,X,X,X,X,X,X,X,X,T
	dc.b	T,T,T,T,T,T,T,T,T,T,T,T,T,X,X,_,B,_,X,X,T,T,T,T,T,T,T,T,T,T,T,T

; ===========================================================================
; ---------------------------------------------------------------------------
; Stage 05 - 
; ---------------------------------------------------------------------------

	dc.b	"Sonic 3  ",$FF		; Game
	dc.b	"         ",$00
	dc.b	"5       ",$00		; Level
	dc.b	"5  ",$00		; Difficulty
	even

Map05:	dc.w	$0424,$008E		; Stage floor colours
	dc.w	$0200,$0666,$0EEA	; Stage BG colours
	dc.b	$1F,$0F,$00		; Player 1's starting X, Y and Angle
	dc.b	$0F,$01,$00		; Player 2's starting X, Y and Angle

	dc.b	_,X,X,X,X,X,T,T,T,X,X,X,X,X,_,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_
	dc.b	_,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,X,X,X,X,X,T,T,T,X,X,X,X,X,_,_
	dc.b	_,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,T,_,_,_,_,B,B,B,_,_,_,_,X,_,_
	dc.b	_,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,T,_,_,_,_,B,B,B,_,_,_,_,X,_,_
	dc.b	_,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,T,_,_,_,_,B,B,B,_,_,_,_,X,_,_
	dc.b	_,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,X,X,X,X,X,T,T,T,X,X,X,X,X,_,_
	dc.b	_,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_
	dc.b	_,X,X,X,X,X,X,X,X,X,X,X,X,X,T,T,T,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_
	dc.b	_,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_
	dc.b	T,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,T,T
	dc.b	_,_,_,_,_,X,X,X,X,X,X,X,X,X,_,_,_,X,X,X,X,X,X,X,X,X,_,_,_,_,_,_
	dc.b	_,_,_,_,_,X,X,X,X,X,X,X,X,X,T,T,T,X,X,X,X,X,X,X,X,X,_,_,_,_,_,_
	dc.b	B,B,B,_,_,X,X,X,X,X,_,_,_,_,_,_,_,_,_,_,_,X,X,X,X,X,_,_,B,B,B,_
	dc.b	B,B,B,_,_,X,X,X,X,X,_,_,_,_,_,_,_,_,_,_,_,X,X,X,X,X,_,_,B,B,B,_
	dc.b	B,B,B,_,_,X,X,X,X,X,_,_,_,_,T,_,T,_,_,_,_,X,X,X,X,X,_,_,B,B,B,_
	dc.b	_,_,_,_,_,X,X,X,X,X,_,_,_,B,T,_,T,B,_,_,_,X,X,X,X,X,_,_,_,_,_,_
	dc.b	_,_,_,_,_,X,X,X,X,X,_,_,T,T,T,_,T,T,T,_,_,X,X,X,X,X,_,_,_,_,_,_
	dc.b	T,T,_,_,_,X,X,X,X,X,_,_,_,_,_,T,_,_,_,_,_,X,X,X,X,X,_,_,_,T,T,_
	dc.b	T,T,_,_,_,X,X,X,X,X,_,_,T,T,T,_,T,T,T,_,_,X,X,X,X,X,_,_,_,T,T,_
	dc.b	_,_,_,_,_,X,X,X,X,X,_,_,_,B,T,_,T,B,_,_,_,X,X,X,X,X,_,_,_,_,_,_
	dc.b	B,B,B,_,_,X,X,X,X,X,_,_,_,_,T,_,T,_,_,_,_,X,X,X,X,X,_,_,B,B,B,_
	dc.b	B,B,B,_,_,X,X,X,X,X,_,_,_,_,_,_,_,_,_,_,_,X,X,X,X,X,_,_,B,B,B,_
	dc.b	B,B,B,_,_,X,X,X,X,X,_,_,_,_,_,_,_,_,_,_,_,X,X,X,X,X,_,_,B,B,B,_
	dc.b	_,_,_,_,_,X,X,X,X,X,X,X,X,X,T,T,T,X,X,X,X,X,X,X,X,X,_,_,_,_,_,_
	dc.b	_,_,_,_,_,X,X,X,X,X,X,X,X,X,_,_,_,X,X,X,X,X,X,X,X,X,_,_,_,_,_,_
	dc.b	T,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,T,T
	dc.b	_,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_
	dc.b	_,X,X,X,X,X,X,X,X,X,X,X,X,X,T,T,T,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_
	dc.b	_,X,X,X,X,X,T,T,T,X,X,X,X,X,_,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_
	dc.b	_,X,_,_,_,_,B,B,B,_,_,_,_,T,_,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_
	dc.b	_,X,_,_,_,_,B,B,B,_,_,_,_,T,_,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_
	dc.b	_,X,_,_,_,_,B,B,B,_,_,_,_,T,_,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_

; ===========================================================================
; ---------------------------------------------------------------------------
; Stage 06 - 
; ---------------------------------------------------------------------------

	dc.b	"Sonic 3  ",$FF		; Game
	dc.b	"         ",$00
	dc.b	"6       ",$00		; Level
	dc.b	"5  ",$00		; Difficulty
	even

Map06:	dc.w	$0C40,$0EEA		; Stage floor colours
	dc.w	$0EC0,$0EE6,$0AEE	; Stage BG colours
	dc.b	$06,$0B,$06		; Player 1's starting X, Y and Angle
	dc.b	$03,$01,$00		; Player 2's starting X, Y and Angle

	dc.b	X,X,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,B,B,X,X,X,X,X,X,X,X,X,X,X,X,X,X,B,B,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,B,B,X,X,X,X,X,X,X,X,X,X,X,X,X,X,B,B,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	_,_,_,_,_,_,_,X,X,X,X,X,X,X,X,_,_,_,_,_,_,_,_,X,X,X,X,X,X,X,X,_
	dc.b	T,T,_,_,T,T,_,X,X,X,X,X,X,X,X,_,T,T,_,_,T,T,_,X,X,X,X,X,X,X,X,_
	dc.b	T,B,B,B,B,T,_,X,X,X,X,X,X,X,X,_,T,B,B,B,B,T,_,X,X,X,X,X,X,X,X,_
	dc.b	_,B,B,B,B,_,_,B,B,_,_,_,_,B,B,_,_,B,B,B,B,_,_,B,B,_,_,_,_,B,B,_
	dc.b	_,B,B,B,B,_,_,B,B,_,_,_,_,B,B,_,_,B,B,B,B,_,_,B,B,_,_,_,_,B,B,_
	dc.b	T,B,B,B,B,T,_,X,X,X,X,X,X,X,X,_,T,B,B,B,B,T,_,X,X,X,X,X,X,X,X,_
	dc.b	T,T,_,_,T,T,_,X,X,X,X,X,X,X,X,_,T,T,_,_,T,T,_,X,X,X,X,X,X,X,X,_
	dc.b	_,_,_,_,_,_,_,X,X,X,X,X,X,X,X,_,_,_,_,_,_,_,_,X,X,X,X,X,X,X,X,_
	dc.b	X,X,B,B,X,X,X,X,X,X,X,X,X,X,X,X,X,X,B,B,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,B,B,X,X,X,X,X,X,X,X,X,X,X,X,X,X,B,B,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,B,B,X,X,X,X,X,X,X,X,X,X,X,X,X,X,B,B,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,B,B,X,X,X,X,X,X,X,X,X,X,X,X,X,X,B,B,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	_,_,_,_,_,_,_,X,X,X,X,X,X,X,X,_,_,_,_,_,_,_,_,X,X,X,X,X,X,X,X,_
	dc.b	T,T,_,_,T,T,_,X,X,X,X,X,X,X,X,_,T,T,_,_,T,T,_,X,X,X,X,X,X,X,X,_
	dc.b	T,B,B,B,B,T,_,X,X,X,X,X,X,X,X,_,T,B,B,B,B,T,_,X,X,X,X,X,X,X,X,_
	dc.b	_,B,B,B,B,_,_,B,B,_,_,_,_,B,B,_,_,B,B,B,B,_,_,B,B,_,_,_,_,B,B,_
	dc.b	_,B,B,B,B,_,_,B,B,_,_,_,_,B,B,_,_,B,B,B,B,_,_,B,B,_,_,_,_,B,B,_
	dc.b	T,B,B,B,B,T,_,X,X,X,X,X,X,X,X,_,T,B,B,B,B,T,_,X,X,X,X,X,X,X,X,_
	dc.b	T,T,_,_,T,T,_,X,X,X,X,X,X,X,X,_,T,T,_,_,T,T,_,X,X,X,X,X,X,X,X,_
	dc.b	_,_,_,_,_,_,_,X,X,X,X,X,X,X,X,_,_,_,_,_,_,_,_,X,X,X,X,X,X,X,X,_
	dc.b	X,X,B,B,X,X,X,X,X,X,X,X,X,X,X,X,X,X,B,B,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,B,B,X,X,X,X,X,X,X,X,X,X,X,X,X,X,B,B,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,X,X,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,_,_,X,X,X,X,X,X,X,X,X,X,X,X,X,X,_,_,X,X,X,X,X,X,X,X,X,X,X,X

; ===========================================================================
; ---------------------------------------------------------------------------
; Stage 07 - 
; ---------------------------------------------------------------------------

	dc.b	"Sonic 3  ",$FF		; Game
	dc.b	"         ",$00
	dc.b	"7       ",$00		; Level
	dc.b	"5  ",$00		; Difficulty
	even

Map07:	dc.w	$0A26,$00CE		; Stage floor colours
	dc.w	$0E60,$0EA4,$0EEE	; Stage BG colours
	dc.b	$01,$10,$00		; Player 1's starting X, Y and Angle
	dc.b	$10,$14,$04		; Player 2's starting X, Y and Angle

	dc.b	X,X,X,X,X,X,X,X,X,_,_,_,_,_,T,T,T,T,_,_,_,_,_,X,X,X,X,X,X,X,X,X
	dc.b	X,X,X,X,X,X,X,X,X,_,_,_,B,B,X,_,_,X,B,B,_,_,_,X,X,X,X,X,X,X,X,X
	dc.b	X,X,X,X,X,X,X,X,X,_,_,_,B,B,X,_,_,X,B,B,_,_,_,X,X,X,X,X,X,X,X,X
	dc.b	X,X,X,X,X,X,X,X,X,_,_,_,X,X,X,_,_,X,X,X,_,_,_,X,X,X,X,X,X,X,X,X
	dc.b	X,X,X,X,X,X,X,X,X,_,_,_,T,T,T,X,X,T,T,T,_,_,_,X,X,X,X,X,X,X,X,X
	dc.b	X,X,X,X,X,X,X,X,T,T,T,B,T,X,T,R,R,T,X,T,B,T,T,T,X,X,X,X,X,X,X,X
	dc.b	X,X,X,X,X,X,X,X,X,X,T,B,T,X,T,R,R,T,X,T,B,T,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,X,X,X,X,X,X,X,X,T,B,T,X,T,R,R,T,X,T,B,T,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,X,X,X,X,X,X,X,X,T,B,T,X,T,T,T,T,X,T,B,T,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,X,X,X,X,X,X,X,X,T,B,T,X,X,X,X,X,X,T,B,T,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,X,X,X,X,X,X,X,X,T,B,T,X,X,X,X,X,X,T,B,T,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,X,X,X,X,X,X,X,X,T,B,T,X,X,X,X,X,X,T,B,T,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,X,X,X,X,X,X,X,X,T,_,_,_,_,_,_,_,_,_,_,T,X,X,X,X,X,X,X,X,X,X
	dc.b	X,X,X,X,X,X,X,X,X,X,T,_,_,_,X,T,T,X,_,_,_,T,X,X,X,X,X,X,X,X,X,X
	dc.b	X,_,_,_,_,_,_,_,_,_,_,_,_,_,X,T,T,X,_,_,_,_,_,_,_,_,_,_,_,_,_,X
	dc.b	T,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,T
	dc.b	B,_,_,X,X,X,X,X,X,X,X,_,_,_,_,_,_,_,_,_,_,X,X,X,X,X,X,X,X,_,_,B
	dc.b	B,_,_,X,T,T,T,T,T,T,T,X,X,X,_,_,_,_,X,X,X,T,T,T,T,T,T,T,X,_,_,B
	dc.b	T,X,X,X,T,T,T,T,T,T,_,B,B,X,_,_,_,_,X,B,B,_,T,T,T,T,T,T,X,X,X,T
	dc.b	T,T,T,T,T,T,T,T,T,_,_,B,B,X,_,_,_,_,X,B,B,_,_,T,T,T,T,T,T,T,T,T
	dc.b	T,T,T,T,T,T,T,T,_,_,_,_,_,T,X,_,_,X,T,_,_,_,_,_,T,T,T,T,T,T,T,T
	dc.b	T,X,X,X,T,_,_,_,_,X,_,_,T,T,X,_,_,X,T,T,_,_,X,_,_,_,_,T,X,X,X,T
	dc.b	B,_,_,X,T,_,_,_,_,_,_,T,T,T,X,_,_,X,T,T,T,_,_,_,_,_,_,T,X,_,_,B
	dc.b	B,_,_,X,T,_,_,_,_,_,T,X,X,X,X,_,_,X,X,X,X,T,_,_,_,_,_,T,X,_,_,B
	dc.b	T,_,_,B,X,X,X,_,_,_,T,X,_,_,_,_,_,_,_,_,X,T,_,_,_,X,X,X,B,_,_,T
	dc.b	X,_,_,B,B,B,X,_,_,_,T,X,_,_,_,_,_,_,_,_,X,T,_,_,_,X,B,B,B,_,_,X
	dc.b	X,_,_,B,B,B,X,T,T,T,T,X,_,_,X,X,X,X,_,_,X,T,T,T,T,X,B,B,B,_,_,X
	dc.b	X,_,_,B,B,B,B,X,X,X,X,X,_,_,X,X,X,X,_,_,X,X,X,X,X,B,B,B,B,_,_,X
	dc.b	X,_,_,_,_,_,_,_,_,_,_,_,_,_,X,X,X,X,_,_,_,_,_,_,_,_,_,_,_,_,_,X
	dc.b	X,_,_,_,_,_,_,_,_,_,_,_,_,_,X,X,X,X,_,_,_,_,_,_,_,_,_,_,_,_,_,X
	dc.b	X,X,X,X,X,X,X,X,X,_,_,_,_,_,X,X,X,X,_,_,_,_,_,X,X,X,X,X,X,X,X,X
	dc.b	X,X,X,X,X,X,X,X,X,_,_,_,_,_,T,T,T,T,_,_,_,_,_,X,X,X,X,X,X,X,X,X

; ===========================================================================
; ---------------------------------------------------------------------------
; Stage 08 - 
; ---------------------------------------------------------------------------

	dc.b	"Sonic &  ",$FF		; Game
	dc.b	"Knuckles ",$00
	dc.b	"1       ",$00		; Level
	dc.b	"5  ",$00		; Difficulty
	even

Map08:	dc.w	$00E2,$08EC		; Stage floor colours
	dc.w	$0E40,$0EA0,$0EEA	; Stage BG colours
	dc.b	$04,$0F,$04		; Player 1's starting X, Y and Angle
	dc.b	$15,$1F,$00		; Player 2's starting X, Y and Angle

	dc.b	_,_,T,X,X,T,_,_,_,T,X,X,X,T,X,X,X,X,T,_,_,_,_,_,T,X,T,_,_,_,_,_
	dc.b	_,_,_,T,T,_,_,_,_,_,T,X,X,X,X,X,X,T,_,_,_,T,_,_,_,T,_,_,_,_,T,_
	dc.b	_,_,_,_,_,_,_,_,_,_,_,T,X,X,X,X,T,_,_,_,B,B,B,_,_,_,_,_,_,B,B,B
	dc.b	T,_,_,_,_,_,_,_,_,_,_,_,T,X,X,T,Y,_,_,T,B,B,B,T,_,_,_,_,T,B,B,B
	dc.b	_,_,_,_,T,_,_,_,_,_,_,_,_,T,X,X,T,_,_,_,B,B,B,_,_,_,_,_,_,B,B,B
	dc.b	_,_,_,T,X,T,_,_,_,_,_,_,_,Y,T,X,X,T,_,_,_,T,_,_,_,T,_,_,_,_,T,_
	dc.b	_,_,T,X,X,T,_,_,_,_,_,_,_,T,X,X,X,X,T,_,_,_,_,_,T,X,T,_,_,_,_,_
	dc.b	_,T,X,X,T,_,_,_,_,_,_,_,T,X,X,X,X,X,T,_,_,_,_,T,X,X,X,T,_,_,_,_
	dc.b	T,X,X,T,_,_,_,_,_,_,_,T,X,X,X,X,X,T,_,_,_,_,_,_,T,X,X,X,T,_,_,_
	dc.b	X,X,T,_,_,_,_,_,_,_,_,_,T,X,X,X,T,_,_,_,_,_,_,_,_,T,X,X,X,T,_,T
	dc.b	X,T,_,_,_,_,_,T,_,_,_,_,_,T,X,T,_,_,_,_,_,T,_,_,_,_,T,X,X,X,T,X
	dc.b	T,_,_,_,_,_,B,B,B,_,_,_,_,_,T,_,_,_,_,_,T,T,T,_,_,_,_,T,X,X,X,X
	dc.b	Y,_,_,_,_,T,B,B,B,T,_,_,_,_,_,_,_,_,_,T,B,B,B,B,_,_,_,_,T,X,X,T
	dc.b	T,_,_,_,_,_,B,B,B,_,_,_,_,_,_,_,_,_,T,T,B,B,B,B,T,_,_,_,_,T,X,X
	dc.b	X,T,_,_,_,_,_,T,_,_,_,_,_,T,T,_,_,_,_,T,B,B,B,B,T,T,_,_,_,Y,T,X
	dc.b	X,X,T,_,_,_,_,_,_,_,_,_,T,X,X,T,_,_,_,_,B,B,B,B,T,_,_,_,_,T,X,X
	dc.b	X,X,X,T,_,_,_,_,_,_,_,T,X,X,X,X,T,_,_,_,_,T,T,T,_,_,_,_,T,X,X,X
	dc.b	X,X,X,X,T,_,_,_,_,_,T,X,X,X,X,X,X,T,_,_,_,_,T,_,_,_,_,T,X,X,X,T
	dc.b	T,X,X,X,X,T,_,_,_,T,X,X,X,X,X,X,X,X,T,_,_,_,_,_,_,_,T,X,X,X,T,_
	dc.b	_,T,X,X,X,X,T,Y,T,X,X,X,T,X,X,X,X,T,_,_,_,_,_,_,_,T,X,X,X,T,_,_
	dc.b	_,_,T,X,X,X,X,T,X,X,X,T,Y,T,X,X,T,_,_,_,_,_,_,_,T,X,X,X,T,_,_,_
	dc.b	_,_,_,T,X,X,X,X,X,X,T,_,_,_,T,T,_,_,_,_,T,_,_,_,_,T,X,T,_,_,_,_
	dc.b	T,_,_,_,T,X,X,X,X,T,_,_,_,_,_,_,_,_,_,T,T,T,_,_,_,_,T,_,_,_,T,B
	dc.b	B,_,_,_,Y,T,X,X,T,_,_,_,_,_,_,_,_,_,T,B,B,B,B,_,_,_,_,_,_,_,B,R
	dc.b	T,_,_,_,T,X,X,T,_,_,_,T,B,T,_,_,_,T,T,B,B,B,B,T,_,_,_,_,_,_,T,B
	dc.b	_,_,_,T,X,X,T,Y,_,_,_,B,R,B,_,_,_,_,T,B,B,B,B,T,T,_,_,_,_,_,_,_
	dc.b	_,_,T,X,X,X,X,T,_,_,_,T,B,T,_,_,_,_,_,B,B,B,B,T,_,_,_,_,_,_,_,_
	dc.b	_,T,X,X,X,X,X,X,T,_,_,_,_,_,_,_,_,_,_,_,T,T,T,_,_,_,_,_,_,_,_,_
	dc.b	T,X,X,X,X,X,X,X,X,T,_,_,_,_,_,_,_,_,_,_,_,T,_,_,_,_,T,_,_,_,_,_
	dc.b	X,X,X,X,X,X,X,X,X,X,T,_,_,_,_,_,_,_,_,_,_,_,_,_,_,T,X,T,_,_,_,T
	dc.b	T,X,X,X,X,X,X,T,X,X,X,T,_,_,_,T,T,_,_,_,_,_,_,_,T,X,X,X,T,_,_,_
	dc.b	_,T,X,X,X,X,T,Y,T,X,X,X,T,_,T,X,X,T,_,_,_,_,_,T,X,X,X,T,_,_,_,_

; ===========================================================================
; ---------------------------------------------------------------------------
; Stage 09 - 
; ---------------------------------------------------------------------------

	dc.b	"Blue Sph-",$FF		; Game
	dc.b	"Challenge",$00
	dc.b	"12345678",$00		; Level
	dc.b	"5  ",$00		; Difficulty
	even

Map09:	dc.w	$0A2C,$0EC2		; Stage floor colours
	dc.w	$0822,$0E42,$0E82	; Stage BG colours
	dc.b	$0F,$0F,$06		; Player 1's starting X, Y and Angle
	dc.b	$10,$03,$02		; Player 2's starting X, Y and Angle

	dc.b	_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_
	dc.b	_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_,_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_
	dc.b	_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_,_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_
	dc.b	_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_,_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_
	dc.b	_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_,_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_
	dc.b	_,B,B,B,B,_,_,_,_,_,_,B,B,B,B,_,_,B,B,B,B,_,_,_,_,_,_,B,B,B,B,_
	dc.b	_,B,B,B,B,_,R,B,B,R,_,B,B,B,B,_,_,B,B,B,B,_,R,B,B,R,_,B,B,B,B,_
	dc.b	_,B,B,B,B,_,B,T,T,B,_,B,B,B,B,_,_,B,B,B,B,_,B,T,T,B,_,B,B,B,B,_
	dc.b	_,B,B,B,B,_,B,T,T,B,_,B,B,B,B,_,_,B,B,B,B,_,B,T,T,B,_,B,B,B,B,_
	dc.b	_,B,B,B,B,_,R,B,B,R,_,B,B,B,B,_,_,B,B,B,B,_,R,B,B,R,_,B,B,B,B,_
	dc.b	_,B,B,B,B,_,_,_,_,_,_,B,B,B,B,_,_,B,B,B,B,_,_,_,_,_,_,B,B,B,B,_
	dc.b	_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_,_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_
	dc.b	_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_,_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_
	dc.b	_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_,_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_
	dc.b	_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_,_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_
	dc.b	_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_
	dc.b	_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_
	dc.b	_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_,_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_
	dc.b	_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_,_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_
	dc.b	_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_,_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_
	dc.b	_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_,_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_
	dc.b	_,B,B,B,B,_,_,_,_,_,_,B,B,B,B,_,_,B,B,B,B,_,_,_,_,_,_,B,B,B,B,_
	dc.b	_,B,B,B,B,_,R,B,B,R,_,B,B,B,B,_,_,B,B,B,B,_,R,B,B,R,_,B,B,B,B,_
	dc.b	_,B,B,B,B,_,B,T,T,B,_,B,B,B,B,_,_,B,B,B,B,_,B,T,T,B,_,B,B,B,B,_
	dc.b	_,B,B,B,B,_,B,T,T,B,_,B,B,B,B,_,_,B,B,B,B,_,B,T,T,B,_,B,B,B,B,_
	dc.b	_,B,B,B,B,_,R,B,B,R,_,B,B,B,B,_,_,B,B,B,B,_,R,B,B,R,_,B,B,B,B,_
	dc.b	_,B,B,B,B,_,_,_,_,_,_,B,B,B,B,_,_,B,B,B,B,_,_,_,_,_,_,B,B,B,B,_
	dc.b	_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_,_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_
	dc.b	_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_,_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_
	dc.b	_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_,_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_
	dc.b	_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_,_,B,B,B,B,B,B,B,B,B,B,B,B,B,B,_
	dc.b	_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_

; ===========================================================================
; ---------------------------------------------------------------------------
; Stage 10 - 
; ---------------------------------------------------------------------------

	dc.b	"S3&K Bat-",$FF		; Game
	dc.b	"-tle Race",$00
	dc.b	"0       ",$00		; Level
	dc.b	"1  ",$00		; Difficulty
	even

Map10:	dc.w	$0444,$0AAA		; Stage floor colours
	dc.w	$0000,$0444,$0CCC	; Stage BG colours
	dc.b	$00,$00,$00		; Player 1's starting X, Y and Angle
	dc.b	$00,$00,$00		; Player 2's starting X, Y and Angle

	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B
	dc.b	B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B

; ===========================================================================