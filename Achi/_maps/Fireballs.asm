; ---------------------------------------------------------------------------
; Sprite mappings - fire balls (MZ, SLZ)
; ---------------------------------------------------------------------------
Map_Fire:	dc.w @vertical1-Map_Fire
		dc.w @vertical2-Map_Fire
		dc.w @vertcollide-Map_Fire
		dc.w @horizontal1-Map_Fire
		dc.w @horizontal2-Map_Fire
		dc.w @horicollide-Map_Fire
@vertical1:	dc.w 1
		dc.b $E8, 7, 0,	0, $FF, $F8
@vertical2:	dc.w 1
		dc.b $E8, 7, 0,	8, $FF, $F8
@vertcollide:	dc.w 1
		dc.b $F0, 6, 0,	$10, $FF, $F8
@horizontal1:	dc.w 1
		dc.b $F8, $D, 0, $16, $FF, $E8
@horizontal2:	dc.w 1
		dc.b $F8, $D, 0, $1E, $FF, $E8
@horicollide:	dc.w 1
		dc.b $F8, 9, 0,	$26, $FF, $F0
		even
