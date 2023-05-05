; ---------------------------------------------------------------------------
; Sprite mappings - platforms on a conveyor belt (LZ)
; ---------------------------------------------------------------------------
Map_LConv:	dc.w @wheel1-Map_LConv, @wheel2-Map_LConv
		dc.w @wheel3-Map_LConv, @wheel4-Map_LConv
		dc.w @platform-Map_LConv
@wheel1:	dc.w 1
		dc.b $F0, $F, 0, 0, $FF, $F0
@wheel2:	dc.w 1
		dc.b $F0, $F, 0, $10, $FF, $F0
@wheel3:	dc.w 1
		dc.b $F0, $F, 0, $20, $FF, $F0
@wheel4:	dc.w 1
		dc.b $F0, $F, 0, $30, $FF, $F0
@platform:	dc.w 1
		dc.b $F8, $D, 0, $40, $FF, $F0
		even
