; ---------------------------------------------------------------------------
; Sprite mappings - pushable blocks (MZ, LZ)
; ---------------------------------------------------------------------------
Map_Push:	dc.w @single-Map_Push
		dc.w @four-Map_Push
@single:	dc.w 1
		dc.b $F0, $F, 0, 8, $FF, $F0	; single block
@four:		dc.w 4
		dc.b $F0, $F, 0, 8, $FF, $C0	; row of 4 blocks
		dc.b $F0, $F, 0, 8, $FF, $E0
		dc.b $F0, $F, 0, 8, $00, 0
		dc.b $F0, $F, 0, 8, $00, $20
		even
