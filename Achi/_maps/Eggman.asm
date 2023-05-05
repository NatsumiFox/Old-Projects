; ---------------------------------------------------------------------------
; Sprite mappings - Eggman (boss levels)
; ---------------------------------------------------------------------------
Map_Eggman:	dc.w @ship-Map_Eggman, @facenormal1-Map_Eggman
		dc.w @facenormal2-Map_Eggman, @facelaugh1-Map_Eggman
		dc.w @facelaugh2-Map_Eggman, @facehit-Map_Eggman
		dc.w @facepanic-Map_Eggman, @facedefeat-Map_Eggman
		dc.w @flame1-Map_Eggman, @flame2-Map_Eggman
		dc.w @blank-Map_Eggman, @escapeflame1-Map_Eggman
		dc.w @escapeflame2-Map_Eggman
@ship:		dc.w 6
		dc.b $EC, 1, 0,	$A, $FF, $E4
		dc.b $EC, 5, 0,	$C, $00, $C
		dc.b $FC, $E, $20, $10,	$FF, $E4
		dc.b $FC, $E, $20, $1C, $00,	4
		dc.b $14, $C, $20, $28,	$FF, $EC
		dc.b $14, 0, $20, $2C, $00, $C
@facenormal1:	dc.w 2
		dc.b $E4, 4, 0,	0, $FF, $F4
		dc.b $EC, $D, 0, 2, $FF, $EC
@facenormal2:	dc.w 2
		dc.b $E4, 4, 0,	0, $FF, $F4
		dc.b $EC, $D, 0, $35, $FF, $EC
@facelaugh1:	dc.w 3
		dc.b $E4, 8, 0,	$3D, $FF, $F4
		dc.b $EC, 9, 0,	$40, $FF, $EC
		dc.b $EC, 5, 0,	$46, $00, 4
@facelaugh2:	dc.w 3
		dc.b $E4, 8, 0,	$4A, $FF, $F4
		dc.b $EC, 9, 0,	$4D, $FF, $EC
		dc.b $EC, 5, 0,	$53, $00, 4
@facehit:	dc.w 3
		dc.b $E4, 8, 0,	$57, $FF, $F4
		dc.b $EC, 9, 0,	$5A, $FF, $EC
		dc.b $EC, 5, 0,	$60, $00, 4
@facepanic:	dc.w 3
		dc.b $E4, 4, 0,	$64, $00, 4
		dc.b $E4, 4, 0,	0, $FF, $F4
		dc.b $EC, $D, 0, $35, $FF, $EC
@facedefeat:	dc.w 4
		dc.b $E4, 9, 0,	$66, $FF, $F4
		dc.b $E4, 8, 0,	$57, $FF, $F4
		dc.b $EC, 9, 0,	$5A, $FF, $EC
		dc.b $EC, 5, 0,	$60, $00, 4
@flame1:	dc.w 1
		dc.w $405, $2D, $22
@flame2:	dc.w 1
		dc.w $405, $31, $22
@blank:		dc.w 0
@escapeflame1:	dc.w 2
		dc.w $8, ($D000/32)-$400, $22
		dc.w $8, $1000|(($D000/32)-$400), $22
@escapeflame2:	dc.w 2
		dc.w $F80B, ($D000/32)-$400+3, $22
		dc.w 1, ($D000/32)-$400+$F, $3A
		even
