; ---------------------------------------------------------------------------
; Sprite mappings - bubbles (LZ)
; ---------------------------------------------------------------------------
Map_Bub:	dc.w @bubble1-Map_Bub, @bubble2-Map_Bub
		dc.w @bubble3-Map_Bub, @bubble4-Map_Bub
		dc.w @bubble5-Map_Bub, @bubble6-Map_Bub
		dc.w @bubblefull-Map_Bub, @burst1-Map_Bub
		dc.w @burst2-Map_Bub, @zero_sm-Map_Bub
		dc.w @five_sm-Map_Bub, @three_sm-Map_Bub
		dc.w @one_sm-Map_Bub, @zero-Map_Bub
		dc.w @five-Map_Bub, @four-Map_Bub
		dc.w @three-Map_Bub, @two-Map_Bub
		dc.w @one-Map_Bub, @bubmaker1-Map_Bub
		dc.w @bubmaker2-Map_Bub, @bubmaker3-Map_Bub
		dc.w @blank-Map_Bub
@bubble1:	dc.w 1
		dc.b $FC, 0, 0,	0, $FF, $FC	; bubbles, increasing in size
@bubble2:	dc.w 1
		dc.b $FC, 0, 0,	1, $FF, $FC
@bubble3:	dc.w 1
		dc.b $FC, 0, 0,	2, $FF, $FC
@bubble4:	dc.w 1
		dc.b $F8, 5, 0,	3, $FF, $F8
@bubble5:	dc.w 1
		dc.b $F8, 5, 0,	7, $FF, $F8
@bubble6:	dc.w 1
		dc.b $F4, $A, 0, $B, $FF, $F4
@bubblefull:	dc.w 1
		dc.b $F0, $F, 0, $14, $FF, $F0
@burst1:	dc.w 4
		dc.b $F0, 5, 0,	$24, $FF, $F0 ; large bubble bursting
		dc.b $F0, 5, 8,	$24, $00, 0
		dc.b 0,	5, $10,	$24, $FF, $F0
		dc.b 0,	5, $18,	$24, $00, 0
@burst2:	dc.w 4
		dc.b $F0, 5, 0,	$28, $FF, $F0
		dc.b $F0, 5, 8,	$28, $00, 0
		dc.b 0,	5, $10,	$28, $FF, $F0
		dc.b 0,	5, $18,	$28, $00, 0
@zero_sm:	dc.w 1
		dc.b $F4, 6, 0,	$2C, $FF, $F8 ; small, partially-formed countdown numbers
@five_sm:	dc.w 1
		dc.b $F4, 6, 0,	$32, $FF, $F8
@three_sm:	dc.w 1
		dc.b $F4, 6, 0,	$38, $FF, $F8
@one_sm:	dc.w 1
		dc.b $F4, 6, 0,	$3E, $FF, $F8
@zero:		dc.w 1
		dc.b $F4, 6, $20, $44, $FF, $F8 ; fully-formed countdown numbers
@five:		dc.w 1
		dc.b $F4, 6, $20, $4A, $FF, $F8
@four:		dc.w 1
		dc.b $F4, 6, $20, $50, $FF, $F8
@three:		dc.w 1
		dc.b $F4, 6, $20, $56, $FF, $F8
@two:		dc.w 1
		dc.b $F4, 6, $20, $5C, $FF, $F8
@one:		dc.w 1
		dc.b $F4, 6, $20, $62, $FF, $F8
@bubmaker1:	dc.w 1
		dc.b $F8, 5, 0,	$68, $FF, $F8
@bubmaker2:	dc.w 1
		dc.b $F8, 5, 0,	$6C, $FF, $F8
@bubmaker3:	dc.w 1
		dc.b $F8, 5, 0,	$70, $FF, $F8
@blank:		dc.w 0
		even
