;sonani3:
		dc.w sonani3_Walk-sonic3anidata
		dc.w sonani3_Run-sonic3anidata
		dc.w sonani3_Roll-sonic3anidata
		dc.w sonani3_Roll2-sonic3anidata
		dc.w sonani3_Push-sonic3anidata
		dc.w sonani3_Wait-sonic3anidata
		dc.w sonani3_Balance-sonic3anidata
		dc.w sonani3_LookUp-sonic3anidata
		dc.w sonani3_Duck-sonic3anidata ; 9
		dc.w sonani3_NoUse-sonic3anidata
		dc.w sonani3_EatCake-sonic3anidata
		dc.w sonani3_Hanging?-sonic3anidata
		dc.w sonani3_Balance2-sonic3anidata
		dc.w sonani3_Stop-sonic3anidata
		dc.w sonani3_1Float-sonic3anidata
		dc.w sonani3_Float-sonic3anidata  ; 10
		dc.w sonani3_Spring-sonic3anidata
		dc.w sonani3_SideHang-sonic3anidata
		dc.w sonani3_UpSideDown-sonic3anidata
		dc.w sonani3_MoveFinger-sonic3anidata
		dc.w sonani3_Hanging-sonic3anidata
		dc.w sonani3_Bubble-sonic3anidata
		dc.w sonani3_Death_BW-sonic3anidata
		dc.w sonani3_Drown-sonic3anidata
		dc.w sonani3_Death-sonic3anidata ; 19
		dc.w sonani3_NotListed-sonic3anidata
		dc.w sonani3_LZSlide_Freeze-sonic3anidata
		dc.w sonani3_LZSlide-sonic3anidata
		dc.w sonani3_Empty-sonic3anidata
		dc.w sonani3_LZSlide2-sonic3anidata
		dc.w sonani3_Float2-sonic3anidata ; 1f?
	;	dc.w sonani3-sonic3anidata  ; Was Not Listed
		dc.w sonani3_SpinDash-sonic3anidata
		dc.w sonani3_eatcake-sonic3anidata  ;Speelout
		dc.w sonani3_notlisted2-sonic3anidata
		dc.w sonani3_roll2-sonic3anidata

sonani3_Walk:
		dc.b  $FF,   7,	  8,   1,   2,	 3,   4,   5,	6, $FF

sonani3_Run:
		dc.b  $FF, $21,	$22, $23, $24, $FF

sonani3_Roll2:
		dc.b  $FE, $97, $98, $99, $9A, $FF

sonani3_Roll:
		dc.b  $FE, $96,	$97, $96, $98, $96, $99, $96, $9A, $FF

sonani3_Push:
		dc.b  $FD, $B6,	$B7, $B8, $B9, $FF, $FF, $FF, $FF, $FF

sonani3_Wait:
		dc.b  5, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA
		dc.b  $BA, $BA,	$BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA,	$BA, $BA, $BA, $BA, $BA, $BA
		dc.b  $BA, $BA,	$BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA,	$BA, $BA, $BA, $BA, $BA, $BA
		dc.b  $BA, $BA,	$BA, $BB, $BC, $BC, $BD, $BD, $BE, $BE,	$BD, $BD, $BE, $BE, $BD, $BD
		dc.b  $BE, $BE,	$BD, $BD, $BE, $BE, $BD, $BD, $BE, $BE,	$BD, $BD, $BE, $BE, $BD, $BD
		dc.b  $BE, $BE,	$BD, $BD, $BE, $BE, $AD, $AD, $AD, $AD,	$AD, $AD, $AE, $AE, $AE, $AE
		dc.b  $AE, $AE,	$AF, $AF,	$AF, $FE, $35 ; Frame D9 not listed [deleted]
sonani3_Balance:
		dc.b	7, $A4,	$A5, $A6, $FF

sonani3_LookUp:
		dc.b	5, $C3,	$C4, $FE,   1

sonani3_Duck:
		dc.b	5, $9B,	$9C, $FE,   1

sonani3_SpinDash:
		dc.b	0, $86,	$87, $86, $88, $86, $89, $86, $8A, $86,	$8B, $FF

sonani3_NotListed2:
                dc.b	8, $B0, $B0, $B1, $B2, $B3, $Fe, 3, 0 
sonani3_EatCake:
		dc.b 1, 7, 8,   1,   2, 3,   4,   5,	6, $21,	$22, $23, $24, $FE, 4

sonani3_Hanging?:
		dc.b   $F, $8F,	$FF

sonani3_Balance2:
		dc.b	5, $A1,	$A2, $A3, $FF

sonani3_Stop:
		dc.b	3, $9D,	$9E, $9F, $A0, $FD,   0

sonani3_1Float:
		dc.b	7, $C8,	$FF

sonani3_Float:
		dc.b	7, $C8,	$C9, $CA, $CB, $CC, $CD, $CE, $CF, $FF

sonani3_Spring:
		dc.b  $2F, $8E,	$FD,   0

sonani3_SideHang:
		dc.b	1, $AA,	$AB, $FF

sonani3_UpSideDown:
		dc.b   $F, $43,	$43, $43, $FE,	 1

sonani3_MoveFinger:
		dc.b	7, $B0,	$B2, $B2, $B2, $B2, $B2, $B2, $B1, $B2,	$B3, $B2, $FE,	 4

sonani3_Hanging:
		dc.b  $13, $91,	$FF

sonani3_Bubble:
		dc.b   $B, $AC,	$AC,   3,   4, $FD,   0

sonani3_Death_BW:
		dc.b  $20, $A8,	$FF

sonani3_Drown:
		dc.b  $20, $A9,	$FF

sonani3_Death:
		dc.b  $20, $A7,	$FF

sonani3_NotListed:
		dc.b	9, $D7,	$D8, $FF

sonani3_LZSlide_Freeze:
		dc.b  $40, $8D,	$FF

sonani3_LZSlide:
		dc.b	9, $8C,	$8D, $FF

sonani3_Empty:
		dc.b  $77,   0,	$FF

sonani3_LZSlide2:
		dc.b  $13, $D0,	$D1, $FF

sonani3_Float2:
		dc.b	3, $CF,	$C8, $C9, $CA, $CB, $FE,   4

sonani3_NoUse:
		dc.b	9,   8,	  9, $FF   ; This is Spindash Frame in Sonic 1

	;	dc.b  $FF, $21,	$22, $23, $24, $FF, $FF, $FF, $FF, $FF

sonani3_Hanging3:
		dc.b   $B, $90,	$91, $92, $91, $FF

sonani3_Hanging4:
		dc.b   $B, $90,	$91, $92, $91, $FD,   0,   0      ; FD not listed (If it is valid frame anyways)