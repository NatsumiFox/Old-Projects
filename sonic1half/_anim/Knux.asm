
		dc.w Knux_walk-knuxAnidata
		dc.w Knux_run-knuxAnidata
		dc.w Knux_Roll-knuxAnidata
		dc.w Knux_Roll2-knuxAnidata
		dc.w Knux_Push-knuxAnidata
		dc.w Knux_wait-knuxAnidata
		dc.w Knux_Balance-knuxAnidata
		dc.w Knux_lookUp-knuxAnidata
		dc.w Knux_Duck-knuxAnidata
		
		dc.w Knux_Glide2-knuxAnidata
		dc.w Knux_Glide?-knuxAnidata
		dc.w Knux_AgnleStand-knuxAnidata
		dc.w Knux_Balance2-knuxAnidata
		dc.w Knux_Stop-knuxAnidata
		dc.w Knux_Glide-knuxAnidata
		dc.w Knux_Glide?-knuxAnidata
		dc.w Knux_Spring-knuxAnidata
		dc.w Knux_Glide3-knuxAnidata
		dc.w Knux_upsideDown-knuxAnidata
		dc.w Knux_punch-knuxAnidata     ; 13
		dc.w Knux_Hang-knuxAnidata
		dc.w Knux_?-knuxAnidata
		dc.w Knux_Die_BW-knuxAnidata
		dc.w Knux_Drown-knuxAnidata
		dc.w Knux_Die-knuxAnidata
		dc.w Knux_LZSlide-knuxAnidata
		dc.w Knux_Hurt-knuxAnidata
		dc.w Knux_LZSlide2-knuxAnidata
		dc.w Knux_Empty-knuxAnidata
		dc.w Knux_2FramesFromPushAni-knuxAnidata
		dc.w Knux_Glideland-knuxAnidata
	;	
		dc.w Knux_spindash-knuxAnidata 
		dc.w Knux_WaitforLand-knuxAnidata  ; 20
		dc.w Knux_Ground-knuxAnidata
		dc.w Knux_roll-knuxAnidata
		dc.w Knux_punch2-knuxAnidata
		dc.w Knux_punch3-knuxAnidata
		dc.w Knux_Pressbutton-knuxAnidata

Knux_walk:
		dc.b  $FF,   7,	  8,   1,   2,	 3,   4,   5,	6, $FF

Knux_run:
		dc.b  $FF, $21,	$22, $23, $24, $FF, $FF, $FF, $FF, $FF

Knux_Roll:
		dc.b  $FE, $96, $97, $98, $99, $FF

Knux_Roll2:
		dc.b  $FE, $9A,	$96, $9A, $97, $9A, $98, $9A, $99, $FF

Knux_Push:
		dc.b  $FD, $CE,	$CF, $D0, $D1, $FF, $FF, $FF, $FF, $FF

Knux_wait:
		dc.b 5, $56,	$56, $56, $56, $56, $56, $56, $56, $56,	$56, $56, $56, $56, $56, $56
		dc.b  $56, $56,	$56, $56, $56, $56, $56, $56, $56, $56,	$56, $56, $56, $56, $56, $56
		dc.b  $56, $56,	$56, $56, $56, $56, $56, $56, $56, $56,	$56, $56, $56, $56, $56, $56
		dc.b  $56, $56,	$56, $D2, $D2, $D2, $D3, $D3, $D3, $D2,	$D2, $D2, $D3, $D3, $D3, $D2
		dc.b  $D2, $D2,	$D3, $D3, $D3, $D2, $D2, $D2, $D3, $D3,	$D3, $D2, $D2, $D2, $D3, $D3
		dc.b  $D3, $D2,	$D2, $D2, $D3, $D3, $D3, $D2, $D2, $D2,	$D3, $D3, $D3, $D2, $D2, $D2
		dc.b  $D3, $D3,	$D3, $D2, $D2, $D2, $D3, $D3, $D3, $D4,	$D4, $D4, $D4, $D4, $D7, $D8
		dc.b  $D9, $DA,	$DB, $D8, $D9, $DA, $DB, $D8, $D9, $DA,	$DB, $D8, $D9, $DA, $DB, $D8
		dc.b  $D9, $DA,	$DB, $D8, $D9, $DA, $DB, $D8, $D9, $DA,	$DB, $D8, $D9, $DA, $DB, $DC
		dc.b  221, 220,	221, 222, 222, 216, 215, 255

Knux_Balance:
		dc.b 3, $9F,	$9F, $A0, $A0, $A1, $A1, $A2, $A2, $A3,	$A3, $A4, $A4, $A5, $A5, $A5
		dc.b  $A5, $A5,	$A5, $A5, $A5, $A5, $A5, $A5, $A5, $A5,	$A5, $A5, $A6, $A6, $A6, $A7
		dc.b  $A7, $A7,	$A8, $A8, $A9, $A9, $AA, $AA, $FE,   6

Knux_lookUp:
		dc.b	5, $D5,	$D6, $FE,   1

Knux_Duck:
		dc.b	5, $9B,	$9C, $FE,   1

Knux_spindash:
		dc.b	0, $86,	$87, $86, $88, $86, $89, $86, $8A, $86,	$8B, $FF

Knux_Glide?:
		dc.b 9, $BA,	$C5, $C6, $C6, $C6, $C6, $C6, $C6, $C7,	$C7, $C7, $C7, $C7, $C7, $C7
		dc.b  $C7, $C7,	$C7, $C7, $C7, $FD,   0

Knux_AgnleStand:
		dc.b   $F, $8F,	$FF

Knux_Balance2:
		dc.b 3, $A1,	$A1, $A2, $A2, $A3, $A3, $A4, $A4, $A5,	$A5, $A5, $A5, $A5, $A5, $A5
		dc.b  $A5, $A5,	$A5, $A5, $A5, $A5, $A5, $A5, $A6, $A6,	$A6, $A7, $A7, $A7, $A8, $A8
		dc.b  $A9, $A9,	$AA, $AA, $FE,	 6

Knux_Stop:
		dc.b	3, $9D,	$9E, $9F, $A0, $FD,   0

Knux_Glide:
		dc.b	7, $C0,	$FF

Knux_Glide?2:
		dc.b	5, $C0,	$C1, $C2, $C3, $C4, $C5, $C6, $C7, $C8,	$C9, $FF

Knux_Spring:
		dc.b  $2F, $8E,	$FD,   0

Knux_Glide3:
		dc.b	1, $AE,	$AF, $FF

Knux_upsideDown:
		dc.b   $F, $43,	$43, $43, $FE,	 1

Knux_punch:
		dc.b	5, $B1,	$B2, $B2, $B2, $B3, $B4, $FE,	1

Knux_punch3:
		dc.b  7, $B1, $B2, $B2, $B2, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $FF, $FF, $FF
Knux_Hang:
		dc.b  $13, $91,	$FF

Knux_?:
		dc.b   $B, $B0,	$B0,   3,   4, $FD,   0

Knux_Die_BW:
		dc.b  $20, $AC,	$FF

Knux_Drown:
		dc.b  $20, $AD,	$FF

Knux_die:
		dc.b  $20, $AB,	$FF

Knux_LZSlide:
		dc.b	9, $8C,	$FF

Knux_Hurt:
		dc.b  $40, $8D,	$FF

Knux_LZSlide2:
		dc.b	9, $8C,	$FF

Knux_Empty:
		dc.b  $77,   0,	$FF

Knux_2FramesFromPushAni:
		dc.b  $13, $D0,	$D1, $FF

Knux_Glideland:
		dc.b	3, $CF,	$C8, $C9, $CA, $CB, $FE,   4

Knux_Glide2:
		dc.b  $1F, $C0,	$FF

Knux_WaitforLand:
		dc.b	7, $CA,	$CB, $FE,   1

Knux_Ground:
		dc.b   $F, $CD,	$FD,   0

Knux_duck2:
		dc.b   $F, $9C,	$FD,   0    ; LSD 

Knux_punch2:
		dc.b	7, $B1,	$B3, $B3, $B3, $B3, $B3, $B3, $B2, $B3,	$B4, $B3, $FE,	 4
Knux_Pressbutton:
		 dc.b $11, $56,	$56, $56, $56, $56, $B3, $B4, $Fe, 1,0