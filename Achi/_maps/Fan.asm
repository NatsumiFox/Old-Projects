; ---------------------------------------------------------------------------
; Sprite mappings - fans (SLZ)
; ---------------------------------------------------------------------------
Map_Fan:	dc.w @fan1-Map_Fan, @fan2-Map_Fan
		dc.w @fan3-Map_Fan, @fan2-Map_Fan
		dc.w @fan1-Map_Fan
@fan1:		dc.w 2
		dc.b $F0, 9, 0,	0, $FF, $F8
		dc.b 0,	$D, 0, 6, $FF, $F0
@fan2:		dc.w 2
		dc.b $F0, $D, 0, $E, $FF, $F0
		dc.b 0,	$D, 0, $16, $FF, $F0
@fan3:		dc.w 2
		dc.b $F0, $D, 0, $1E, $FF, $F0
		dc.b 0,	9, 0, $26, $FF, $F8
		even
