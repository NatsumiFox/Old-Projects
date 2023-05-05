; ---------------------------------------------------------------------------
; Sprite mappings - energy balls (FZ)
; ---------------------------------------------------------------------------
Map_Plasma:	dc.w @fuzzy1-Map_Plasma, @fuzzy2-Map_Plasma
		dc.w @white1-Map_Plasma, @white2-Map_Plasma
		dc.w @white3-Map_Plasma, @white4-Map_Plasma
		dc.w @fuzzy3-Map_Plasma, @fuzzy4-Map_Plasma
		dc.w @fuzzy5-Map_Plasma, @fuzzy6-Map_Plasma
		dc.w @blank-Map_Plasma
@fuzzy1:	dc.w 2
		dc.b $F0, $D, 0, $7A, $FF, $F0
		dc.b 0,	$D, $18, $7A, $FF, $F0
@fuzzy2:	dc.w 2
		dc.b $F4, 6, 0,	$82, $FF, $F4
		dc.b $F4, 2, $18, $82, $00, 4
@white1:	dc.w 2
		dc.b $F8, 4, 0,	$88, $FF, $F8
		dc.b 0,	4, $10,	$88, $FF, $F8
@white2:	dc.w 2
		dc.b $F8, 4, 0,	$8A, $FF, $F8
		dc.b 0,	4, $10,	$8A, $FF, $F8
@white3:	dc.w 2
		dc.b $F8, 4, 0,	$8C, $FF, $F8
		dc.b 0,	4, $10,	$8C, $FF, $F8
@white4:	dc.w 2
		dc.b $F4, 6, 0,	$8E, $FF, $F4
		dc.b $F4, 2, $18, $8E, $00, 4
@fuzzy3:	dc.w 1
		dc.b $F8, 5, 0,	$94, $FF, $F8
@fuzzy4:	dc.w 1
		dc.b $F8, 5, 0,	$98, $FF, $F8
@fuzzy5:	dc.w 2
		dc.b $F0, $D, 8, $7A, $FF, $F0
		dc.b 0,	$D, $10, $7A, $FF, $F0
@fuzzy6:	dc.w 2
		dc.b $F4, 6, $10, $82, $FF, $F4
		dc.b $F4, 2, 8,	$82, $00, 4
@blank:		dc.w 0
		even
