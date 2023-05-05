        	dc.w sonani_Walk-SonicAniData
		dc.w SonAni_Run-SonicAniData
		dc.w SonAni_Roll-SonicAniData
		dc.w SonAni_Roll2-SonicAniData
		dc.w SonAni_Push-SonicAniData
		dc.w SonAni_Wait-SonicAniData
		dc.w SonAni_Balance-SonicAniData
		dc.w SonAni_LookUp-SonicAniData
		dc.w SonAni_Duck-SonicAniData ; 9
		dc.w SonAni_SpinDash-SonicAniData
		dc.w SonAni_Speelout-SonicAniData
		dc.w SonAni_Hanging?-SonicAniData
		dc.w SonAni_Balance2-SonicAniData
		dc.w SonAni_Stop-SonicAniData
		dc.w SonAni_1Float-SonicAniData
		dc.w SonAni_Float-SonicAniData  ; 10
		dc.w SonAni_Spring-SonicAniData
		dc.w SonAni_SideHang-SonicAniData
		dc.w SonAni_UpSideDown-SonicAniData
		dc.w SonAni_MoveFinger-SonicAniData
		dc.w SonAni_Hanging-SonicAniData
		dc.w SonAni_Bubble-SonicAniData
		dc.w SonAni_Death_BW-SonicAniData
		dc.w SonAni_Drown-SonicAniData
		dc.w SonAni_Death-SonicAniData ; 19
		dc.w SonAni_NotListed-SonicAniData
		dc.w SonAni_LZSlide_Freeze-SonicAniData
		dc.w SonAni_LZSlide-SonicAniData
		dc.w SonAni_Empty-SonicAniData
		dc.w SonAni_LZSlide2-SonicAniData
		dc.w SonAni_Float2-SonicAniData ; 1f?
		
SonAni_Walk:    dc.b $FF, 7,   8,   1,   2,   3,   4,   5,   6,   $FF
SonAni_Run:     dc.b $FF, $21, $22, $23, $24, $FF, $FF, $FF, $FF, $FF
SonAni_Roll2:   dc.b $Fe, $97, $98, $99, $9A, $FF, $FF, $FF, $FF, $FF
SonAni_Roll:    dc.b $Fe, $96, $97, $96, $98, $96, $99, $96, $9A, $FF
SonAni_Push:    dc.b $FD, $B6, $B7, $B8, $B9, $FF, $FF, $FF, $FF, $FF
SonAni_Wait:    dc.b  5, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA
		dc.b  $BA, $BA,	$BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA,	$BA, $BA, $BA, $BA, $BA, $BA
		dc.b  $BA, $BA,	$BA, $BA, $BA, $BA, $BA, $BA, $BA, $BA,	$BA, $BA, $BA, $BA, $BA, $BA
		dc.b  $BA, $BA,	$BA, $BB, $BC, $BC, $BD, $BD, $BE, $BE,	$BD, $BD, $BE, $BE, $BD, $BD
		dc.b  $BE, $BE,	$BD, $BD, $BE, $BE, $BD, $BD, $BE, $BE,	$BD, $BD, $BE, $BE, $BD, $BD
		dc.b  $BE, $BE,	$BD, $BD, $BE, $BE, $AD, $AD, $AD, $AD,	$AD, $AD, $AE, $AE, $AE, $AE
		dc.b  $AE, $AE,	$AF, $AF, $AF, $FE, $35
SonAni_Balance: dc.b 7, $A4, $A5, $A6, $FF
SonAni_LookUp:  dc.b 5, $C3, $C4, $FE, 1
SonAni_Duck:    dc.b 5, $9B, $9C, $FE, 1
SonAni_SpinDash: dc.b 0, $86, $87, $86, $88, $86, $89, $86, $8A, $86, $8B, $FF
SonAni_NotListed2: dc.b	8, $B0, $B0, $B1, $B2, $B3, $Fe, 3, 0
SonAni_EatCake: dc.b 1, 7, 8, 1, 2, 3, 4, 5, 6, $21, $22, $23, $24, $FE, 4
SonAni_Hanging?: dc.b $F, $8F,	$FF
SonAni_Balance2: dc.b 5, $A1, $A2, $A3, $FF
SonAni_Stop:     dc.b 3, $9D, $9E, $9F, $A0, $FD,   0
SonAni_1Float:   dc.b 7, $C8, $FF
SonAni_Float:    dc.b 7, $C8, $C9, $CA, $CB, $CC, $CD, $CE, $CF, $FF
SonAni_Spring:   dc.b $2F, $8E, $FD, 0
SonAni_SideHang: dc.b 1, $AA, $AB, $FF
SonAni_UpSideDown: dc.b $F, $43, $43, $43, $FE,	 1
SonAni_MoveFinger: dc.b	7, $B0,	$B2, $B2, $B2, $B2, $B2, $B2, $B1, $B2,	$B3, $B2, $FE,	 4
SonAni_Hanging:  dc.b $13, $91, $FF
SonAni_Bubble:   dc.b $B, $AC, $AC, 3, 4, $FD, 0
SonAni_Death_BW: dc.b $20, $A8, $FF
SonAni_Drown:    dc.b $20, $A9, $FF
SonAni_Death:    dc.b $20, $A7, $FF
SonAni_NotListed: dc.b 9, $D7,	$D8, $FF
SonAni_LZSlide_Freeze: dc.b  $40, $8D,	$FF
SonAni_LZSlide:  dc.b 9, $8C,	$8D, $FF
SonAni_Empty:    dc.b $77, 0, $FF
SonAni_LZSlide2: dc.b $13, $D0, $D1, $FF
SonAni_Float2:   dc.b 3, $CF,	$C8, $C9, $CA, $CB, $FE,   4
SonAni_Hanging3: dc.b $B, $90, $91, $92, $91, $FF
SonAni_Hanging4: dc.b $B, $90, $91, $92, $91, $FD,   0,   0      ; FD not listed (If it is valid frame anyways)
SonAni_Speelout: dc.b $FF, 7, 8, 1, 2, 3, 4, 5, 6, $21, $22, $23, $24, $FE, 4
                 even