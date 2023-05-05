.map		dc.w .0-.map
		dc.w .e1-.map
		dc.w .1-.map
		dc.w .e2-.map
		dc.w .2-.map
		dc.w .e2f-.map
		dc.w .3-.map
		dc.w .e1f-.map
		dc.w .4-.map
		dc.w .5-.map
		dc.w .6-.map
		dc.w .7-.map
		dc.w .8-.map

.8		dc.w 0
.0		dc.w 1
		dc.b  $F8,   5
		dc.w RingTile, $FFF8
.e1		dc.w 1
		dc.b $F8, 5
		dc.w RingTile+$0A, $FFF8
.1		dc.w 1
		dc.b  $F8,   5
		dc.w RingTile+$04, $FFF8
.e2		dc.w 1
		dc.b $F8, 1
		dc.w RingTile+$0E, $FFFC
.2		dc.w 1
		dc.b  $F8,   1
		dc.w RingTile+$08, $FFFC
.e2f		dc.w 1
		dc.b $F8, 1
		dc.w RingTile+$0E|$0800, $FFFC
.3		dc.w 1
		dc.b  $F8,   5
		dc.w RingTile+$04|$0800, $FFF8
.e1f		dc.w 1
		dc.b $F8, 5
		dc.w RingTile+$0A|$0800, $FFF8
.4		dc.w 1
		dc.b  $F8,   5
		dc.w RingTile+$10, $FFF8
.5		dc.w 1
		dc.b  $F8,   5
		dc.w RingTile+$10|$1800, $FFF8
.6		dc.w 1
		dc.b  $F8,   5
		dc.w RingTile+$10|$0800, $FFF8
.7		dc.w 1
		dc.b  $F8,   5
		dc.w RingTile+$10|$1000, $FFF8
