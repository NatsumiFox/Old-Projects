; ---------------------------------------------------------------------------
; Sprite mappings - Sonic
; ---------------------------------------------------------------------------
Map_Sonic:

ptr_MS_Null:	dc.w MS_Null-Map_Sonic
ptr_MS_Stand:	dc.w MS_Stand-Map_Sonic
ptr_MS_Wait1:	dc.w MS_Wait1-Map_Sonic
ptr_MS_Wait2:	dc.w MS_Wait2-Map_Sonic
ptr_MS_Wait3:	dc.w MS_Wait3-Map_Sonic
ptr_MS_LookUp:	dc.w MS_LookUp-Map_Sonic
ptr_MS_Walk11:	dc.w MS_Walk11-Map_Sonic
ptr_MS_Walk12:	dc.w MS_Walk12-Map_Sonic
ptr_MS_Walk13:	dc.w MS_Walk13-Map_Sonic
ptr_MS_Walk14:	dc.w MS_Walk14-Map_Sonic
ptr_MS_Walk15:	dc.w MS_Walk15-Map_Sonic
ptr_MS_Walk16:	dc.w MS_Walk16-Map_Sonic
ptr_MS_Walk21:	dc.w MS_Walk21-Map_Sonic
ptr_MS_Walk22:	dc.w MS_Walk22-Map_Sonic
ptr_MS_Walk23:	dc.w MS_Walk23-Map_Sonic
ptr_MS_Walk24:	dc.w MS_Walk24-Map_Sonic
ptr_MS_Walk25:	dc.w MS_Walk25-Map_Sonic
ptr_MS_Walk26:	dc.w MS_Walk26-Map_Sonic
ptr_MS_Walk31:	dc.w MS_Walk31-Map_Sonic
ptr_MS_Walk32:	dc.w MS_Walk32-Map_Sonic
ptr_MS_Walk33:	dc.w MS_Walk33-Map_Sonic
ptr_MS_Walk34:	dc.w MS_Walk34-Map_Sonic
ptr_MS_Walk35:	dc.w MS_Walk35-Map_Sonic
ptr_MS_Walk36:	dc.w MS_Walk36-Map_Sonic
ptr_MS_Walk41:	dc.w MS_Walk41-Map_Sonic
ptr_MS_Walk42:	dc.w MS_Walk42-Map_Sonic
ptr_MS_Walk43:	dc.w MS_Walk43-Map_Sonic
ptr_MS_Walk44:	dc.w MS_Walk44-Map_Sonic
ptr_MS_Walk45:	dc.w MS_Walk45-Map_Sonic
ptr_MS_Walk46:	dc.w MS_Walk46-Map_Sonic
ptr_MS_Run11:	dc.w MS_Run11-Map_Sonic
ptr_MS_Run12:	dc.w MS_Run12-Map_Sonic
ptr_MS_Run13:	dc.w MS_Run13-Map_Sonic
ptr_MS_Run14:	dc.w MS_Run14-Map_Sonic
ptr_MS_Run21:	dc.w MS_Run21-Map_Sonic
ptr_MS_Run22:	dc.w MS_Run22-Map_Sonic
ptr_MS_Run23:	dc.w MS_Run23-Map_Sonic
ptr_MS_Run24:	dc.w MS_Run24-Map_Sonic
ptr_MS_Run31:	dc.w MS_Run31-Map_Sonic
ptr_MS_Run32:	dc.w MS_Run32-Map_Sonic
ptr_MS_Run33:	dc.w MS_Run33-Map_Sonic
ptr_MS_Run34:	dc.w MS_Run34-Map_Sonic
ptr_MS_Run41:	dc.w MS_Run41-Map_Sonic
ptr_MS_Run42:	dc.w MS_Run42-Map_Sonic
ptr_MS_Run43:	dc.w MS_Run43-Map_Sonic
ptr_MS_Run44:	dc.w MS_Run44-Map_Sonic
ptr_MS_Roll1:	dc.w MS_Roll1-Map_Sonic
ptr_MS_Roll2:	dc.w MS_Roll2-Map_Sonic
ptr_MS_Roll3:	dc.w MS_Roll3-Map_Sonic
ptr_MS_Roll4:	dc.w MS_Roll4-Map_Sonic
ptr_MS_Roll5:	dc.w MS_Roll5-Map_Sonic
ptr_MS_Warp1:	dc.w MS_Warp1-Map_Sonic
ptr_MS_Warp2:	dc.w MS_Warp2-Map_Sonic
ptr_MS_Warp3:	dc.w MS_Warp3-Map_Sonic
ptr_MS_Warp4:	dc.w MS_Warp4-Map_Sonic
ptr_MS_Stop1:	dc.w MS_Stop1-Map_Sonic
ptr_MS_Stop2:	dc.w MS_Stop2-Map_Sonic
ptr_MS_Duck:	dc.w MS_Duck-Map_Sonic
ptr_MS_Balance1:dc.w MS_Balance1-Map_Sonic
ptr_MS_Balance2:dc.w MS_Balance2-Map_Sonic
ptr_MS_Float1:	dc.w MS_Float1-Map_Sonic
ptr_MS_Float2:	dc.w MS_Float2-Map_Sonic
ptr_MS_Float3:	dc.w MS_Float3-Map_Sonic
ptr_MS_Float4:	dc.w MS_Float4-Map_Sonic
ptr_MS_Spring:	dc.w MS_Spring-Map_Sonic
ptr_MS_Hang1:	dc.w MS_Hang1-Map_Sonic
ptr_MS_Hang2:	dc.w MS_Hang2-Map_Sonic
ptr_MS_Leap1:	dc.w MS_Leap1-Map_Sonic
ptr_MS_Leap2:	dc.w MS_Leap2-Map_Sonic
ptr_MS_Push1:	dc.w MS_Push1-Map_Sonic
ptr_MS_Push2:	dc.w MS_Push2-Map_Sonic
ptr_MS_Push3:	dc.w MS_Push3-Map_Sonic
ptr_MS_Push4:	dc.w MS_Push4-Map_Sonic
ptr_MS_Surf:	dc.w MS_Surf-Map_Sonic
ptr_MS_BubStand:dc.w MS_BubStand-Map_Sonic
ptr_MS_Burnt:	dc.w MS_Burnt-Map_Sonic
ptr_MS_Drown:	dc.w MS_Drown-Map_Sonic
ptr_MS_Death:	dc.w MS_Death-Map_Sonic
ptr_MS_Shrink1:	dc.w MS_Shrink1-Map_Sonic
ptr_MS_Shrink2:	dc.w MS_Shrink2-Map_Sonic
ptr_MS_Shrink3:	dc.w MS_Shrink3-Map_Sonic
ptr_MS_Shrink4:	dc.w MS_Shrink4-Map_Sonic
ptr_MS_Shrink5:	dc.w MS_Shrink5-Map_Sonic
ptr_MS_Float5:	dc.w MS_Float5-Map_Sonic
ptr_MS_Float6:	dc.w MS_Float6-Map_Sonic
ptr_MS_Injury:	dc.w MS_Injury-Map_Sonic
ptr_MS_GetAir:	dc.w MS_GetAir-Map_Sonic
ptr_MS_WaterSlide:dc.w MS_WaterSlide-Map_Sonic

MS_Null:	dc.w 0
MS_Stand:	dc.w 4			; standing
		dc.b $EC, 8, 0,	0, $FF, $F0
		dc.b $F4, $D, 0, 3, $FF, $F0
		dc.b 4,	8, 0, $B, $FF, $F0
		dc.b $C, 8, 0, $E, $FF, $F8
MS_Wait1:	dc.w 3			; waiting 1
		dc.b $EC, 9, 0,	0, $FF, $F0
		dc.b $FC, 9, 0,	6, $FF, $F0
		dc.b $C, 8, 0, $C, $FF, $F8
MS_Wait2:	dc.w 3			; waiting 2
		dc.b $EC, 9, 0,	0, $FF, $F0
		dc.b $FC, 9, 0,	6, $FF, $F0
		dc.b $C, 8, 0, $C, $FF, $F8
MS_Wait3:	dc.w 3			; waiting 3
		dc.b $EC, 9, 0,	0, $FF, $F0
		dc.b $FC, 9, 0,	6, $FF, $F0
		dc.b $C, 8, 0, $C, $FF, $F8
MS_LookUp:	dc.w 3			; looking up
		dc.b $EC, $A, 0, 0, $FF, $F0
		dc.b 4,	8, 0, 9, $FF, $F0
		dc.b $C, 8, 0, $C, $FF, $F8
MS_Walk11:	dc.w 4			; walking 1-1
		dc.b $EB, $D, 0, 0, $FF, $EC
		dc.b $FB, 9, 0,	8, $FF, $EC
		dc.b $FB, 6, 0,	$E, $00, 4
		dc.b $B, 4, 0, $14, $FF, $EC
MS_Walk12:	dc.w 2			; walking 1-2
		dc.b $EC, $D, 0, 0, $FF, $ED
		dc.b $FC, $E, 0, 8, $FF, $F5
MS_Walk13:	dc.w 2			; walking 1-3
		dc.b $ED, 9, 0,	0, $FF, $F3
		dc.b $FD, $A, 0, 6, $FF, $F3
MS_Walk14:	dc.w 4			; walking 1-4
		dc.b $EB, 9, 0,	0, $FF, $F4
		dc.b $FB, 9, 0,	6, $FF, $EC
		dc.b $FB, 6, 0,	$C, $00, 4
		dc.b $B, 4, 0, $12, $FF, $EC
MS_Walk15:	dc.w 2			; walking 1-5
		dc.b $EC, 9, 0,	0, $FF, $F3
		dc.b $FC, $E, 0, 6, $FF, $EB
MS_Walk16:	dc.w 3			; walking 1-6
		dc.b $ED, $D, 0, 0, $FF, $EC
		dc.b $FD, $C, 0, 8, $FF, $F4
		dc.b 5,	9, 0, $C, $FF, $F4
MS_Walk21:	dc.w 5			; walking 2-1
		dc.b $EB, 9, 0,	0, $FF, $EB
		dc.b $EB, 6, 0,	6, $00, 3
		dc.b $FB, 8, 0,	$C, $FF, $EB
		dc.b 3,	9, 0, $F, $FF, $F3
		dc.b $13, 0, 0,	$15, $FF, $FB
MS_Walk22:	dc.w 6			; walking 2-2
		dc.b $EC, 9, 0,	0, $FF, $EC
		dc.b $EC, 1, 0,	6, $00, 4
		dc.b $FC, $C, 0, 8, $FF, $EC
		dc.b 4,	9, 0, $C, $FF, $F4
		dc.b $FC, 5, 0,	$12, $00, $C
		dc.b $F4, 0, 0,	$16, $00, $14
MS_Walk23:	dc.w 4			; walking 2-3
		dc.b $ED, 9, 0,	0, $FF, $ED
		dc.b $ED, 1, 0,	6, $00, 5
		dc.b $FD, $D, 0, 8, $FF, $F5
		dc.b $D, 8, 0, $10, $FF, $FD
MS_Walk24:	dc.w 5			; walking 2-4
		dc.b $EB, 9, 0,	0, $FF, $EB
		dc.b $EB, 5, 0,	6, $00, 3
		dc.b $FB, $D, 0, $A, $FF, $F3
		dc.b $B, 8, 0, $12, $FF, $F3
		dc.b $13, 4, 0,	$15, $FF, $FB
MS_Walk25:	dc.w 4			; walking 2-5
		dc.b $EC, 9, 0,	0, $FF, $EC
		dc.b $EC, 1, 0,	6, $00, 4
		dc.b $FC, $D, 0, 8, $FF, $F4
		dc.b $C, 8, 0, $10, $FF, $FC
MS_Walk26:	dc.w 5			; walking 2-6
		dc.b $ED, 9, 0,	0, $FF, $ED
		dc.b $ED, 1, 0,	6, $00, 5
		dc.b $FD, 0, 0,	8, $FF, $ED
		dc.b $FD, $D, 0, 9, $FF, $F5
		dc.b $D, 8, 0, $11, $FF, $FD
MS_Walk31:	dc.w 4			; walking 3-1
		dc.b $F4, 7, 0,	0, $FF, $EB
		dc.b $EC, 9, 0,	8, $FF, $FB
		dc.b $FC, 4, 0,	$E, $FF, $FB
		dc.b 4,	9, 0, $10, $FF, $FB
MS_Walk32:	dc.w 2			; walking 3-2
		dc.b $F4, 7, 0,	0, $FF, $EC
		dc.b $EC, $B, 0, 8, $FF, $FC
MS_Walk33:	dc.w 2			; walking 3-3
		dc.b $F4, 6, 0,	0, $FF, $ED
		dc.b $F4, $A, 0, 6, $FF, $FD
MS_Walk34:	dc.w 4			; walking 3-4
		dc.b $F4, 6, 0,	0, $FF, $EB
		dc.b $EC, 9, 0,	6, $FF, $FB
		dc.b $FC, 4, 0,	$C, $FF, $FB
		dc.b 4,	9, 0, $E, $FF, $FB
MS_Walk35:	dc.w 2			; walking 3-5
		dc.b $F4, 6, 0,	0, $FF, $EC
		dc.b $F4, $B, 0, 6, $FF, $FC
MS_Walk36:	dc.w 3			; walking 3-6
		dc.b $F4, 7, 0,	0, $FF, $ED
		dc.b $EC, 0, 0,	8, $FF, $FD
		dc.b $F4, $A, 0, 9, $FF, $FD
MS_Walk41:	dc.w 6			; walking 4-1
		dc.b $FD, 6, 0,	0, $FF, $EB
		dc.b $ED, 4, 0,	6, $FF, $F3
		dc.b $F5, 4, 0,	8, $FF, $EB
		dc.b $F5, $A, 0, $A, $FF, $FB
		dc.b $D, 0, 0, $13, $FF, $FB
		dc.b $FD, 0, 0,	$14, $00, $13
MS_Walk42:	dc.w 6			; walking 4-2
		dc.b $FC, 6, 0,	0, $FF, $EC
		dc.b $E4, 8, 0,	6, $FF, $F4
		dc.b $EC, 4, 0,	9, $FF, $FC
		dc.b $F4, 4, 0,	$B, $FF, $EC
		dc.b $F4, $A, 0, $D, $FF, $FC
		dc.b $C, 0, 0, $16, $FF, $FC
MS_Walk43:	dc.w 4			; walking 4-3
		dc.b $FB, 6, 0,	0, $FF, $ED
		dc.b $F3, 4, 0,	6, $FF, $ED
		dc.b $EB, $A, 0, 8, $FF, $FD
		dc.b 3,	4, 0, $11, $FF, $FD
MS_Walk44:	dc.w 5			; walking 4-4
		dc.b $FD, 6, 0,	0, $FF, $EB
		dc.b $ED, 8, 0,	6, $FF, $F3
		dc.b $F5, 4, 0,	9, $FF, $EB
		dc.b $F5, $D, 0, $B, $FF, $FB
		dc.b 5,	8, 0, $13, $FF, $FB
MS_Walk45:	dc.w 4			; walking 4-5
		dc.b $FC, 6, 0,	0, $FF, $EC
		dc.b $F4, 4, 0,	6, $FF, $EC
		dc.b $EC, $A, 0, 8, $FF, $FC
		dc.b 4,	4, 0, $11, $FF, $FC
MS_Walk46:	dc.w 5			; walking 4-6
		dc.b $FB, 6, 0,	0, $FF, $ED
		dc.b $EB, $A, 0, 6, $FF, $FD
		dc.b $F3, 4, 0,	$F, $FF, $ED
		dc.b 3,	4, 0, $11, $FF, $FD
		dc.b $B, 0, 0, $13, $FF, $FD
MS_Run11:	dc.w 2			; running 1-1
		dc.b $EE, 9, 0,	0, $FF, $F4
		dc.b $FE, $E, 0, 6, $FF, $EC
MS_Run12:	dc.w 2			; running 1-2
		dc.b $EE, 9, 0,	0, $FF, $F4
		dc.b $FE, $E, 0, 6, $FF, $EC
MS_Run13:	dc.w 2			; running 1-3
		dc.b $EE, 9, 0,	0, $FF, $F4
		dc.b $FE, $E, 0, 6, $FF, $EC
MS_Run14:	dc.w 2			; running 1-4
		dc.b $EE, 9, 0,	0, $FF, $F4
		dc.b $FE, $E, 0, 6, $FF, $EC
MS_Run21:	dc.w 4			; running 2-1
		dc.b $EE, 9, 0,	0, $FF, $EE
		dc.b $EE, 1, 0,	6, $00, 6
		dc.b $FE, $E, 0, 8, $FF, $F6
		dc.b $FE, 0, 0,	$14, $FF, $EE
MS_Run22:	dc.w 3			; running 2-2
		dc.b $EE, 9, 0,	0, $FF, $EE
		dc.b $EE, 1, 0,	6, $00, 6
		dc.b $FE, $E, 0, 8, $FF, $F6
MS_Run23:	dc.w 4			; running 2-3
		dc.b $EE, 9, 0,	0, $FF, $EE
		dc.b $EE, 1, 0,	6, $00, 6
		dc.b $FE, $E, 0, 8, $FF, $F6
		dc.b $FE, 0, 0,	$14, $FF, $EE
MS_Run24:	dc.w 3			; running 2-4
		dc.b $EE, 9, 0,	0, $FF, $EE
		dc.b $EE, 1, 0,	6, $00, 6
		dc.b $FE, $E, 0, 8, $FF, $F6
MS_Run31:	dc.w 2			; running 3-1
		dc.b $F4, 6, 0,	0, $FF, $EE
		dc.b $F4, $B, 0, 6, $FF, $FE
MS_Run32:	dc.w 2			; running 3-2
		dc.b $F4, 6, 0,	0, $FF, $EE
		dc.b $F4, $B, 0, 6, $FF, $FE
MS_Run33:	dc.w 2			; running 3-3
		dc.b $F4, 6, 0,	0, $FF, $EE
		dc.b $F4, $B, 0, 6, $FF, $FE
MS_Run34:	dc.w 2			; running 3-4
		dc.b $F4, 6, 0,	0, $FF, $EE
		dc.b $F4, $B, 0, 6, $FF, $FE
MS_Run41:	dc.w 4			; running 4-1
		dc.b $FA, 6, 0,	0, $FF, $EE
		dc.b $F2, 4, 0,	6, $FF, $EE
		dc.b $EA, $B, 0, 8, $FF, $FE
		dc.b $A, 0, 0, $14, $FF, $FE
MS_Run42:	dc.w 2			; running 4-2
		dc.b $F2, 7, 0,	0, $FF, $EE
		dc.b $EA, $B, 0, 8, $FF, $FE
MS_Run43:	dc.w 4			; running 4-3
		dc.b $FA, 6, 0,	0, $FF, $EE
		dc.b $F2, 4, 0,	6, $FF, $EE
		dc.b $EA, $B, 0, 8, $FF, $FE
		dc.b $A, 0, 0, $14, $FF, $FE
MS_Run44:	dc.w 2			; running 4-4
		dc.b $F2, 7, 0,	0, $FF, $EE
		dc.b $EA, $B, 0, 8, $FF, $FE
MS_Roll1:	dc.w 1			; rolling 1
		dc.b $F0, $F, 0, 0, $FF, $F0
MS_Roll2:	dc.w 1			; rolling 2
		dc.b $F0, $F, 0, 0, $FF, $F0
MS_Roll3:	dc.w 1			; rolling 3
		dc.b $F0, $F, 0, 0, $FF, $F0
MS_Roll4:	dc.w 1			; rolling 4
		dc.b $F0, $F, 0, 0, $FF, $F0
MS_Roll5:	dc.w 1			; rolling 5
		dc.b $F0, $F, 0, 0, $FF, $F0
MS_Warp1:	dc.w 2			; warped 1 (unused)
		dc.b $F4, $E, 0, 0, $FF, $EC
		dc.b $F4, 2, 0,	$C, $00, $C
MS_Warp2:	dc.w 1			; warped 2 (unused)
		dc.b $F0, $F, 0, 0, $FF, $F0
MS_Warp3:	dc.w 2			; warped 3 (unused)
		dc.b $EC, $B, 0, 0, $FF, $F4
		dc.b $C, 8, 0, $C, $FF, $F4
MS_Warp4:	dc.w 1			; warped 4 (unused)
		dc.b $F0, $F, 0, 0, $FF, $F0
MS_Stop1:	dc.w 2			; stopping 1
		dc.b $ED, 9, 0,	0, $FF, $F0
		dc.b $FD, $E, 0, 6, $FF, $F0
MS_Stop2:	dc.w 4			; stopping 2
		dc.b $ED, 9, 0,	0, $FF, $F0
		dc.b $FD, $D, 0, 6, $FF, $F0
		dc.b $D, 4, 0, $E, $00, 0
		dc.b 5,	0, 0, $10, $FF, $E8
MS_Duck:	dc.w 4			; ducking
		dc.b $F4, 4, 0,	0, $FF, $FC
		dc.b $FC, $D, 0, 2, $FF, $F4
		dc.b $C, 8, 0, $A, $FF, $F4
		dc.b 4,	0, 0, $D, $FF, $EC
MS_Balance1:	dc.w 3			; balancing 1
		dc.b $EC, 8, 8,	0, $FF, $E8
		dc.b $F4, 2, 8,	3, $00, 0
		dc.b $F4, $F, 8, 6, $FF, $E0
MS_Balance2:	dc.w 3			; balancing 2
		dc.b $EC, $E, 8, 0, $FF, $E8
		dc.b 4,	$D, 8, $C, $FF, $E0
		dc.b $C, 0, $18, $14, $00, 0
MS_Float1:	dc.w 3			; spinning 1 (LZ)
		dc.b $F4, $D, 0, 0, $FF, $FC
		dc.b $FC, 5, 0,	8, $FF, $EC
		dc.b 4,	8, 0, $C, $FF, $FC
MS_Float2:	dc.w 2			; spinning 2 (LZ)
		dc.b $F4, $A, 0, 0, $FF, $E8
		dc.b $F4, $A, 8, 0, $00, 0
MS_Float3:	dc.w 3			; spinning 3 (LZ)
		dc.b $F4, $D, 0, 0, $FF, $E4
		dc.b $FC, 0, 0,	8, $00, 4
		dc.b 4,	$C, 0, 9, $FF, $EC
MS_Float4:	dc.w 3			; spinning 4 (LZ)
		dc.b $F4, $D, 0, 0, $FF, $FC
		dc.b $FC, 5, 0,	8, $FF, $EC
		dc.b 4,	8, 0, $C, $FF, $FC
MS_Spring:	dc.w 3			; bouncing on a spring
		dc.b $E8, $B, 0, 0, $FF, $F0
		dc.b 8,	4, 0, $C, $FF, $F8
		dc.b $10, 0, 0,	$E, $FF, $F8
MS_Hang1:	dc.w 4			; hanging 1 (LZ)
		dc.b $F8, $E, 0, 0, $FF, $E8
		dc.b 0,	5, 0, $C, $00, 8
		dc.b $F8, 0, 0,	$10, $00, 8
		dc.b $F0, 0, 0,	$11, $FF, $F8
MS_Hang2:	dc.w 4			; hanging 2 (LZ)
		dc.b $F8, $E, 0, 0, $FF, $E8
		dc.b 0,	5, 0, $C, $00, 8
		dc.b $F8, 0, 0,	$10, $00, 8
		dc.b $F0, 0, 0,	$11, $FF, $F8
MS_Leap1:	dc.w 5			; celebration leap 1 (unused)
		dc.b $E8, $A, 0, 0, $FF, $F4
		dc.b $F0, 1, 0,	9, $00, $C
		dc.b 0,	9, 0, $B, $FF, $F4
		dc.b $10, 4, 0,	$11, $FF, $F4
		dc.b 0,	0, 0, $13, $FF, $EC
MS_Leap2:	dc.w 5			; celebration leap 2 (unused)
		dc.b $E8, $A, 0, 0, $FF, $F4
		dc.b $E8, 1, 0,	9, $00, $C
		dc.b 0,	9, 0, $B, $FF, $F4
		dc.b $10, 4, 0,	$11, $FF, $F4
		dc.b 0,	0, 0, $13, $FF, $EC
MS_Push1:	dc.w 2			; pushing 1
		dc.b $ED, $A, 0, 0, $FF, $F3
		dc.b 5,	$D, 0, 9, $FF, $EB
MS_Push2:	dc.w 3			; pushing 2
		dc.b $EC, $A, 0, 0, $FF, $F3
		dc.b 4,	8, 0, 9, $FF, $F3
		dc.b $C, 4, 0, $C, $FF, $F3
MS_Push3:	dc.w 2			; pushing 3
		dc.b $ED, $A, 0, 0, $FF, $F3
		dc.b 5,	$D, 0, 9, $FF, $EB
MS_Push4:	dc.w 3			; pushing 4
		dc.b $EC, $A, 0, 0, $FF, $F3
		dc.b 4,	8, 0, 9, $FF, $F3
		dc.b $C, 4, 0, $C, $FF, $F3
MS_Surf:	dc.w 2			; surfing or sliding (unused)
		dc.b $EC, 9, 0,	0, $FF, $F0
		dc.b $FC, $E, 0, 6, $FF, $F0
MS_BubStand:	dc.w 3			; collecting bubble (unused)
		dc.b $EC, $A, 0, 0, $FF, $F0
		dc.b 4,	5, 0, 9, $FF, $F8
		dc.b $E4, 0, 0,	$D, $FF, $F8
MS_Burnt:	dc.w 3			; grey death
		dc.b $E8, $D, 0, 0, $FF, $EC
		dc.b $E8, 1, 0,	8, $00, $C
		dc.b $F8, $B, 0, $A, $FF, $F4
MS_Drown:	dc.w 5			; drowning
		dc.b $E8, $D, 0, 0, $FF, $EC
		dc.b $E8, 1, 0,	8, $00, $C
		dc.b $F8, 9, 0,	$A, $FF, $F4
		dc.b 8,	$C, 0, $10, $FF, $F4
		dc.b $10, 0, 0,	$14, $FF, $F4
MS_Death:	dc.w 5			; death
		dc.b $E8, $D, 0, 0, $FF, $EC
		dc.b $E8, 1, 0,	8, $00, $C
		dc.b $F8, 9, 0,	$A, $FF, $F4
		dc.b 8,	$C, 0, $10, $FF, $F4
		dc.b $10, 0, 0,	$14, $FF, $F4
MS_Shrink1:	dc.w 2			; shrinking 1 (unused)
		dc.b $EC, 8, 0,	0, $FF, $F0
		dc.b $F4, $F, 0, 3, $FF, $F0
MS_Shrink2:	dc.w 3			; shrinking 2 (unused)
		dc.b $EC, 8, 0,	0, $FF, $F0
		dc.b $F4, $E, 0, 3, $FF, $F0
		dc.b $C, 8, 0, $F, $FF, $F8
MS_Shrink3:	dc.w 1			; shrinking 3 (unused)
		dc.b $F0, $B, 0, 0, $FF, $F4
MS_Shrink4:	dc.w 1			; shrinking 4 (unused)
		dc.b $F4, 6, 0,	0, $FF, $F8
MS_Shrink5:	dc.w 1			; shrinking 5 (unused)
		dc.b $F8, 1, 0,	0, $FF, $FC
MS_Float5:	dc.w 3			; spinning 5 (LZ)
		dc.b $F4, $D, 8, 0, $FF, $E4
		dc.b $FC, 5, 8,	8, $00, 4
		dc.b 4,	8, 8, $C, $FF, $EC
MS_Float6:	dc.w 3			; spinning 6 (LZ)
		dc.b $F4, $D, 8, 0, $FF, $FC
		dc.b $FC, 0, 8,	8, $FF, $F4
		dc.b 4,	$C, 8, 9, $FF, $F4
MS_Injury:	dc.w 3			; injury
		dc.b $F0, $E, 0, 0, $FF, $EC
		dc.b $F8, 1, 0,	$C, $00, $C
		dc.b 8,	$C, 0, $E, $FF, $F4
MS_GetAir:	dc.w 3			; collecting bubble (LZ)
		dc.b $EB, 9, 0,	0, $FF, $F4
		dc.b $FB, $E, 0, 6, $FF, $EC
		dc.b 3,	1, 0, $12, $00, $C
MS_WaterSlide:	dc.w 2			; water	slide (LZ)
		dc.b $F0, $F, 0, 0, $FF, $EC
		dc.b $F8, 2, 0,	$10, $00, $C
		even

fr_Null:	equ (ptr_MS_Null-Map_Sonic)/2		; 0
fr_Stand:	equ (ptr_MS_Stand-Map_Sonic)/2		; 1
fr_Wait1:	equ (ptr_MS_Wait1-Map_Sonic)/2		; 2
fr_Wait2:	equ (ptr_MS_Wait2-Map_Sonic)/2		; 3
fr_Wait3:	equ (ptr_MS_Wait3-Map_Sonic)/2		; 4
fr_LookUp:	equ (ptr_MS_LookUp-Map_Sonic)/2		; 5
fr_Walk11:	equ (ptr_MS_Walk11-Map_Sonic)/2		; 6
fr_Walk12:	equ (ptr_MS_Walk12-Map_Sonic)/2		; 7
fr_Walk13:	equ (ptr_MS_Walk13-Map_Sonic)/2		; 8
fr_Walk14:	equ (ptr_MS_Walk14-Map_Sonic)/2		; 9
fr_Walk15:	equ (ptr_MS_Walk15-Map_Sonic)/2		; $A
fr_Walk16:	equ (ptr_MS_Walk16-Map_Sonic)/2		; $B
fr_Walk21:	equ (ptr_MS_Walk21-Map_Sonic)/2		; $C
fr_Walk22:	equ (ptr_MS_Walk22-Map_Sonic)/2		; $D
fr_Walk23:	equ (ptr_MS_Walk23-Map_Sonic)/2		; $E
fr_Walk24:	equ (ptr_MS_Walk24-Map_Sonic)/2		; $F
fr_Walk25:	equ (ptr_MS_Walk25-Map_Sonic)/2		; $10
fr_Walk26:	equ (ptr_MS_Walk26-Map_Sonic)/2		; $11
fr_Walk31:	equ (ptr_MS_Walk31-Map_Sonic)/2		; $12
fr_Walk32:	equ (ptr_MS_Walk32-Map_Sonic)/2		; $13
fr_Walk33:	equ (ptr_MS_Walk33-Map_Sonic)/2		; $14
fr_Walk34:	equ (ptr_MS_Walk34-Map_Sonic)/2		; $15
fr_Walk35:	equ (ptr_MS_Walk35-Map_Sonic)/2		; $16
fr_Walk36:	equ (ptr_MS_Walk36-Map_Sonic)/2		; $17
fr_Walk41:	equ (ptr_MS_Walk41-Map_Sonic)/2		; $18
fr_Walk42:	equ (ptr_MS_Walk42-Map_Sonic)/2		; $19
fr_Walk43:	equ (ptr_MS_Walk43-Map_Sonic)/2		; $1A
fr_Walk44:	equ (ptr_MS_Walk44-Map_Sonic)/2		; $1B
fr_Walk45:	equ (ptr_MS_Walk45-Map_Sonic)/2		; $1C
fr_Walk46:	equ (ptr_MS_Walk46-Map_Sonic)/2		; $1D
fr_Run11:	equ (ptr_MS_Run11-Map_Sonic)/2		; $1E
fr_Run12:	equ (ptr_MS_Run12-Map_Sonic)/2		; $1F
fr_Run13:	equ (ptr_MS_Run13-Map_Sonic)/2		; $20
fr_Run14:	equ (ptr_MS_Run14-Map_Sonic)/2		; $21
fr_Run21:	equ (ptr_MS_Run21-Map_Sonic)/2		; $22
fr_Run22:	equ (ptr_MS_Run22-Map_Sonic)/2		; $23
fr_Run23:	equ (ptr_MS_Run23-Map_Sonic)/2		; $24
fr_Run24:	equ (ptr_MS_Run24-Map_Sonic)/2		; $25
fr_Run31:	equ (ptr_MS_Run31-Map_Sonic)/2		; $26
fr_Run32:	equ (ptr_MS_Run32-Map_Sonic)/2		; $27
fr_Run33:	equ (ptr_MS_Run33-Map_Sonic)/2		; $28
fr_Run34:	equ (ptr_MS_Run34-Map_Sonic)/2		; $29
fr_Run41:	equ (ptr_MS_Run41-Map_Sonic)/2		; $2A
fr_Run42:	equ (ptr_MS_Run42-Map_Sonic)/2		; $2B
fr_Run43:	equ (ptr_MS_Run43-Map_Sonic)/2		; $2C
fr_Run44:	equ (ptr_MS_Run44-Map_Sonic)/2		; $2D
fr_Roll1:	equ (ptr_MS_Roll1-Map_Sonic)/2		; $2E
fr_Roll2:	equ (ptr_MS_Roll2-Map_Sonic)/2		; $2F
fr_Roll3:	equ (ptr_MS_Roll3-Map_Sonic)/2		; $30
fr_Roll4:	equ (ptr_MS_Roll4-Map_Sonic)/2		; $31
fr_Roll5:	equ (ptr_MS_Roll5-Map_Sonic)/2		; $32
fr_Warp1:	equ (ptr_MS_Warp1-Map_Sonic)/2		; $33
fr_Warp2:	equ (ptr_MS_Warp2-Map_Sonic)/2		; $34
fr_Warp3:	equ (ptr_MS_Warp3-Map_Sonic)/2		; $35
fr_Warp4:	equ (ptr_MS_Warp4-Map_Sonic)/2		; $36
fr_Stop1:	equ (ptr_MS_Stop1-Map_Sonic)/2		; $37
fr_Stop2:	equ (ptr_MS_Stop2-Map_Sonic)/2		; $38
fr_Duck:	equ (ptr_MS_Duck-Map_Sonic)/2		; $39
fr_Balance1:	equ (ptr_MS_Balance1-Map_Sonic)/2	; $3A
fr_Balance2:	equ (ptr_MS_Balance2-Map_Sonic)/2	; $3B
fr_Float1:	equ (ptr_MS_Float1-Map_Sonic)/2		; $3C
fr_Float2:	equ (ptr_MS_Float2-Map_Sonic)/2		; $3D
fr_Float3:	equ (ptr_MS_Float3-Map_Sonic)/2		; $3E
fr_Float4:	equ (ptr_MS_Float4-Map_Sonic)/2		; $3F
fr_Spring:	equ (ptr_MS_Spring-Map_Sonic)/2		; $40
fr_Hang1:	equ (ptr_MS_Hang1-Map_Sonic)/2		; $41
fr_Hang2:	equ (ptr_MS_Hang2-Map_Sonic)/2		; $42
fr_Leap1:	equ (ptr_MS_Leap1-Map_Sonic)/2		; $43
fr_Leap2:	equ (ptr_MS_Leap2-Map_Sonic)/2		; $44
fr_Push1:	equ (ptr_MS_Push1-Map_Sonic)/2		; $45
fr_Push2:	equ (ptr_MS_Push2-Map_Sonic)/2		; $46
fr_Push3:	equ (ptr_MS_Push3-Map_Sonic)/2		; $47
fr_Push4:	equ (ptr_MS_Push4-Map_Sonic)/2		; $48
fr_Surf:	equ (ptr_MS_Surf-Map_Sonic)/2		; $49
fr_BubStand:	equ (ptr_MS_BubStand-Map_Sonic)/2	; $4A
fr_Burnt:	equ (ptr_MS_Burnt-Map_Sonic)/2		; $4B
fr_Drown:	equ (ptr_MS_Drown-Map_Sonic)/2		; $4C
fr_Death:	equ (ptr_MS_Death-Map_Sonic)/2		; $4D
fr_Shrink1:	equ (ptr_MS_Shrink1-Map_Sonic)/2	; $4E
fr_Shrink2:	equ (ptr_MS_Shrink2-Map_Sonic)/2	; $4F
fr_Shrink3:	equ (ptr_MS_Shrink3-Map_Sonic)/2	; $50
fr_Shrink4:	equ (ptr_MS_Shrink4-Map_Sonic)/2	; $51
fr_Shrink5:	equ (ptr_MS_Shrink5-Map_Sonic)/2	; $52
fr_Float5:	equ (ptr_MS_Float5-Map_Sonic)/2		; $53
fr_Float6:	equ (ptr_MS_Float6-Map_Sonic)/2		; $54
fr_Injury:	equ (ptr_MS_Injury-Map_Sonic)/2		; $55
fr_GetAir:	equ (ptr_MS_GetAir-Map_Sonic)/2		; $56
fr_WaterSlide:	equ (ptr_MS_WaterSlide-Map_Sonic)/2	; $57
