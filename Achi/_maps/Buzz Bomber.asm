; ---------------------------------------------------------------------------
; Sprite mappings - Buzz Bomber	enemy
; ---------------------------------------------------------------------------
Map_Buzz:	dc.w @Fly1-Map_Buzz, @Fly2-Map_Buzz
		dc.w @Fly3-Map_Buzz, @Fly4-Map_Buzz
		dc.w @Fire1-Map_Buzz, @Fire2-Map_Buzz
@Fly1:		dc.w 6
		dc.b $F4, 9, 0,	0, $FF, $E8	; flying
		dc.b $F4, 9, 0,	$F, $00, 0
		dc.b 4,	8, 0, $15, $FF, $E8
		dc.b 4,	4, 0, $18, $00, 0
		dc.b $F1, 8, 0,	$1A, $FF, $EC
		dc.b $F1, 4, 0,	$1D, $00, 4
@Fly2:		dc.w 6
		dc.b $F4, 9, 0,	0, $FF, $E8
		dc.b $F4, 9, 0,	$F, $00, 0
		dc.b 4,	8, 0, $15, $FF, $E8
		dc.b 4,	4, 0, $18, $00, 0
		dc.b $F4, 8, 0,	$1F, $FF, $EC
		dc.b $F4, 4, 0,	$22, $00, 4
@Fly3:		dc.w 7
		dc.b 4,	0, 0, $30, $00, $C
		dc.b $F4, 9, 0,	0, $FF, $E8
		dc.b $F4, 9, 0,	$F, $00, 0
		dc.b 4,	8, 0, $15, $FF, $E8
		dc.b 4,	4, 0, $18, $00, 0
		dc.b $F1, 8, 0,	$1A, $FF, $EC
		dc.b $F1, 4, 0,	$1D, $00, 4
@Fly4:		dc.w 7
		dc.b 4,	4, 0, $31, $00, $C
		dc.b $F4, 9, 0,	0, $FF, $E8
		dc.b $F4, 9, 0,	$F, $00, 0
		dc.b 4,	8, 0, $15, $FF, $E8
		dc.b 4,	4, 0, $18, $00, 0
		dc.b $F4, 8, 0,	$1F, $FF, $EC
		dc.b $F4, 4, 0,	$22, $00, 4
@Fire1:		dc.w 6
		dc.b $F4, $D, 0, 0, $FF, $EC	; stopping and firing
		dc.b 4,	$C, 0, 8, $FF, $EC
		dc.b 4,	0, 0, $C, $00, $C
		dc.b $C, 4, 0, $D, $FF, $F4
		dc.b $F1, 8, 0,	$1A, $FF, $EC
		dc.b $F1, 4, 0,	$1D, $00, 4
@Fire2:		dc.w 4
		dc.b $F4, $D, 0, 0, $FF, $EC
		dc.b 4,	$C, 0, 8, $FF, $EC
		dc.b 4,	0, 0, $C, $00, $C
		dc.b $C, 4, 0, $D, $FF, $F4
		dc.b $F4, 8, 0,	$1F, $FF, $EC
		dc.b $F4, 4, 0,	$22, $00, 4
		even
