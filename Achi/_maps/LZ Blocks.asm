; ---------------------------------------------------------------------------
; Sprite mappings - blocks (LZ)
; ---------------------------------------------------------------------------
Map_LBlock:	dc.w @sinkblock-Map_LBlock, @riseplatform-Map_LBlock
		dc.w @cork-Map_LBlock, @block-Map_LBlock
@sinkblock:	dc.w 1
		dc.b $F0, $F, 0, 0, $FF, $F0	; block, sinks when stood on
@riseplatform:	dc.w 2
		dc.b $F4, $E, 0, $69, $FF, $E0 ; platform, rises when stood on
		dc.b $F4, $E, 0, $75, $00, 0
@cork:		dc.w 1
		dc.b $F0, $F, 1, $1A, $FF, $F0 ; cork, floats on water
@block:		dc.w 1
		dc.b $F0, $F, $FD, $FA,	$FF, $F0 ; block
		even
