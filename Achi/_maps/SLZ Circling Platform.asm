; ---------------------------------------------------------------------------
; Sprite mappings - platforms that move	in circles (SLZ)
; ---------------------------------------------------------------------------
Map_Circ:	dc.w @platform-Map_Circ
@platform:	dc.w 2
		dc.b $F8, 9, 0,	$51, $FF, $E8
		dc.b $F8, 9, 8,	$51, $00, 0
		even
