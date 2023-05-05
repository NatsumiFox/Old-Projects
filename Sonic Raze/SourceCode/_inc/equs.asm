Snd_Special_FadeOut		equ	$E0
Snd_Special_SEGA		equ	$E1
Snd_Special_StopSng		equ	$E4
RAM_SpriteAddr			equ	$FFFFD000		;(Only used in SegaScreen) Change: $FFFFD000 for s1 or $FFFFB000 for s2

Game_Mode			equ	$FFFFF600		;Delete this variable if you are using the S2 AS disasm
ModeID_Title			equ	$4

;Don't add these variables if you used the 6 button guide
RAM_Control_1_Press 		equ	$FFFFF605
JoyStart			equ	$80