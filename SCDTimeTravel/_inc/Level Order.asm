
; Zone IDs
	GHZ:	= $00
	LZ:	= $01
	MZ:	= $02
	SLZ:	= $03
	SYZ:	= $04
	SBZ:	= $05

; Act IDs
	Act1:	= $00
	Act2:	= $01
	Act3:	= $02
	Act4:	= $03
	
; Format:	From which level to which
; Notes:	Never change lines order!

fromGHZ1	dc.b	GHZ,Act2
fromGHZ2	dc.b	GHZ,Act3
fromGHZ3	dc.b	MZ,Act1
fromGHZ4	dc.b	0,0

fromLZ1		dc.b	LZ,Act2
fromLZ2		dc.b	LZ,Act3
fromLZ3		dc.b	SLZ,Act1
fromLZ4		dc.b	SBZ,Act3	; LZ4 is actually SBZ3

fromMZ1		dc.b	MZ,Act2
fromMZ2		dc.b	MZ,Act3
fromMZ3		dc.b	SYZ,Act1
fromMZ4		dc.b	0,0

fromSLZ1	dc.b	SLZ,Act2
fromSLZ2	dc.b	SLZ,Act3
fromSLZ3	dc.b	SBZ,Act1
fromSLZ4	dc.b	0,0

fromSYZ1	dc.b	SYZ,Act2
fromSYZ2	dc.b	SYZ,Act3
fromSYZ3	dc.b	LZ,Act1
fromSYZ4	dc.b	0,0

fromSBZ1	dc.b	SBZ,Act2
fromSBZ2	dc.b	LZ,Act4
fromSBZ3	dc.b	0,0		; SBZ3 is actually FZ
fromSBZ4	dc.b	0,0
