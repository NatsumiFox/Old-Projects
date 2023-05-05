;sonic2anidata:
	dc.w sonani2_Walk-sonic2anidata		; 0
	dc.w sonani2_Run-sonic2anidata		; 1
	dc.w sonani2_Roll-sonic2anidata		; 2
	dc.w sonani2_Roll2-sonic2anidata	; 3
	dc.w sonani2_Push-sonic2anidata		; 4
	dc.w sonani2_Wait-sonic2anidata		; 5
	dc.w sonani2_Balance-sonic2anidata	; 6
	dc.w sonani2_LookUp-sonic2anidata	; 7
	dc.w sonani2_Duck-sonic2anidata		; 8
	dc.w sonani2_Spindash-sonic2anidata	; 9
	dc.w sonani2_Blink-sonic2anidata	; 10 ; $A
	dc.w sonani2_GetUp-sonic2anidata	; 11 ; $B
	dc.w sonani2_Balance2-sonic2anidata	; 12 ; $C
	dc.w sonani2_Stop-sonic2anidata		; 13 ; $D
	dc.w sonani2_Float-sonic2anidata	; 14 ; $E
	dc.w sonani2_Float2-sonic2anidata	; 15 ; $F
	dc.w sonani2_Spring-sonic2anidata	; 16 ; $10
	dc.w sonani2_Hang-sonic2anidata		; 17 ; $11
	dc.w sonani2_Dash2-sonic2anidata	; 18 ; $12
	dc.w sonani2_Dash3-sonic2anidata	; 19 ; $13
	dc.w sonani2_Hang2-sonic2anidata	; 20 ; $14
	dc.w sonani2_Bubble-sonic2anidata	; 21 ; $15
	dc.w sonani2_DeathBW-sonic2anidata	; 22 ; $16
	dc.w sonani2_Drown-sonic2anidata	; 23 ; $17
	dc.w sonani2_Death-sonic2anidata	; 24 ; $18
	dc.w sonani2_Hurt-sonic2anidata		; 25 ; $19
	dc.w sonani2_Hurt-sonic2anidata		; 26 ; $1A
	dc.w sonani2_Slide-sonic2anidata	; 27 ; $1B
	dc.w sonani2_Blank-sonic2anidata	; 28 ; $1C
	dc.w sonani2_Balance3-sonic2anidata	; 29 ; $1D
	dc.w sonani2_Balance4-sonic2anidata	; 30 ; $1E
	dc.w sonani2_Spindash-sonic2anidata	; 9
;	dc.w Supsonani2_Transform-sonic2anidata	; 31 ; $1F
	dc.w sonani2_Lying-sonic2anidata	; 32 ; $20
	dc.w sonani2_LieDown-sonic2anidata	; 33 ; $21
	dc.w sonani2_roll-sonic2anidata	; 33 ; $21
	
sonani2_Walk:	dc.b $FF, $F,$10,$11,$12,$13,$14, $D, $E,$FF
sonani2_Run:	dc.b $FF,$2D,$2E,$2F,$30,$FF,$FF,$FF,$FF,$FF
sonani2_Roll:	dc.b $FE,$3D,$41,$3E,$41,$3F,$41,$40,$41,$FF
sonani2_Roll2:	dc.b $FE,$3D,$41,$3E,$41,$3F,$41,$40,$41,$FF
sonani2_Push:	dc.b $FD,$48,$49,$4A,$4B,$FF,$FF,$FF,$FF,$FF
sonani2_Wait:
	dc.b   9,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	dc.b   1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  2
	dc.b   3,  3,  3,  3,  3,  4,  4,  4,  5,  5,  5,  4,  4,  4,  5,  5
	dc.b   5,  4,  4,  4,  5,  5,  5,  4,  4,  4,  5,  5,  5,  6,  6,  6
	dc.b   6,  6,  6,  6,  6,  6,  6,  4,  4,  4,  5,  5,  5,  4,  4,  4
	dc.b   5,  5,  5,  4,  4,  4,  5,  5,  5,  4,  4,  4,  5,  5,  5,  6
	dc.b   6,  6,  6,  6,  6,  6,  6,  6,  6,  4,  4,  4,  5,  5,  5,  4
	dc.b   4,  4,  5,  5,  5,  4,  4,  4,  5,  5,  5,  4,  4,  4,  5,  5
	dc.b   5,  6,  6,  6,  6,  6,  6,  6,  6,  6,  6,  4,  4,  4,  5,  5
	dc.b   5,  4,  4,  4,  5,  5,  5,  4,  4,  4,  5,  5,  5,  4,  4,  4
	dc.b   5,  5,  5,  6,  6,  6,  6,  6,  6,  6,  6,  6,  6,  7,  8,  8
	dc.b   8,  9,  9,  9,$FE,  6
sonani2_Balance:	dc.b   9,$CC,$CD,$CE,$CD,$FF
sonani2_LookUp:	dc.b   5, $B, $C,$FE,  1
sonani2_Duck:	dc.b   5,$4C,$4D,$FE,  1
sonani2_Spindash:dc.b   0,$42,$43,$42,$44,$42,$45,$42,$46,$42,$47,$FF
sonani2_Blink:	dc.b   1,  2,$FD,  0
sonani2_GetUp:	dc.b   3, $A,$FD,  0
sonani2_Balance2:dc.b   3,$C8,$C9,$CA,$CB,$FF
sonani2_Stop:	dc.b   5,$D2,$D3,$D4,$D5,$FD,  0 ; halt/skidding animation
sonani2_Float:	dc.b   7,$54,$59,$FF
sonani2_Float2:	dc.b   7,$54,$55,$56,$57,$58,$FF
sonani2_Spring:	dc.b $2F,$5B,$FD,  0
sonani2_Hang:	dc.b   1,$50,$51,$FF
sonani2_Dash2:	dc.b  $F,$43,$43,$43,$FE,  1
sonani2_Dash3:	dc.b  $F,$43,$44,$FE,  1
sonani2_Hang2:	dc.b $13,$6B,$6C,$FF
sonani2_Bubble:	dc.b  $B,$5A,$5A,$11,$12,$FD,  0 ; breathe
sonani2_DeathBW:	dc.b $20,$5E,$FF
sonani2_Drown:	dc.b $20,$5D,$FF
sonani2_Death:	dc.b $20,$5C,$FF
sonani2_Hurt:	dc.b $40,$4E,$FF
sonani2_Slide:	dc.b   9,$4E,$4F,$FF
sonani2_Blank:	dc.b $77,  0,$FD,  0
sonani2_Balance3:dc.b $13,$D0,$D1,$FF
sonani2_Balance4:dc.b   3,$CF,$C8,$C9,$CA,$CB,$FE,  4
sonani2_Lying:	dc.b 1, $F,$10,$11,$12,$13,$14, $D, $E, $2D,$2E,$2F,$30, $FE, 4
sonani2_LieDown:	dc.b   3,  7,$FD,  0
	even