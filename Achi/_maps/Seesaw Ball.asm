; ---------------------------------------------------------------------------
; Sprite mappings - spiked balls on the	seesaws	(SLZ)
; ---------------------------------------------------------------------------
Map_SSawBall:	dc.w @red-Map_SSawBall
		dc.w @silver-Map_SSawBall
@red:		dc.w 1
		dc.b $F4, $A, 0, 0, $FF, $F4
@silver:	dc.w 1
		dc.b $F4, $A, 0, 9, $FF, $F4
		even
