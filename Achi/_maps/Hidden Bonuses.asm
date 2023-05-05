; ---------------------------------------------------------------------------
; Sprite mappings - hidden points at the end of	a level
; ---------------------------------------------------------------------------
Map_Bonus:	dc.w @blank-Map_Bonus, @10000-Map_Bonus
		dc.w @1000-Map_Bonus, @100-Map_Bonus
@blank:		dc.w 0
@10000:		dc.w 1
		dc.b $F4, $E, 0, 0, $FF, $F0
@1000:		dc.w 1
		dc.b $F4, $E, 0, $C, $FF, $F0
@100:		dc.w 1
		dc.b $F4, $E, 0, $18, $FF, $F0
		even
