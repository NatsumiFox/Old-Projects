; ---------------------------------------------------------------------------
; Sprite mappings - vanishing platforms	(SBZ)
; ---------------------------------------------------------------------------
Map_VanP:	dc.w @whole-Map_VanP, @half-Map_VanP
		dc.w @quarter-Map_VanP, @gone-Map_VanP
@whole:		dc.w 1
		dc.b $F8, $F, 0, 0, $FF, $F0
@half:		dc.w 1
		dc.b $F8, 7, 0,	$10, $FF, $F8
@quarter:	dc.w 1
		dc.b $F8, 3, 0,	$18, $FF, $FC
@gone:		dc.w 0
		even
