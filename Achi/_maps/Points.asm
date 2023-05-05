; ---------------------------------------------------------------------------
; Sprite mappings - points that	appear when you	destroy	something
; ---------------------------------------------------------------------------
Map_Poi:	dc.w byte_94BC-Map_Poi, byte_94C2-Map_Poi
		dc.w byte_94C8-Map_Poi, byte_94CE-Map_Poi
		dc.w byte_94D4-Map_Poi, byte_94DA-Map_Poi
		dc.w byte_94E5-Map_Poi
byte_94BC:	dc.w 1
		dc.b $FC, 4, 0,	0, $FF, $F8	; 100 points
byte_94C2:	dc.w 1
		dc.b $FC, 4, 0,	2, $FF, $F8	; 200 points
byte_94C8:	dc.w 1
		dc.b $FC, 4, 0,	4, $FF, $F8	; 500 points
byte_94CE:	dc.w 1
		dc.b $FC, 8, 0,	6, $FF, $F8	; 1000 points
byte_94D4:	dc.w 1
		dc.b $FC, 0, 0,	6, $FF, $FC	; 10 points
byte_94DA:	dc.w 2
		dc.b $FC, 8, 0,	6, $FF, $F4	; 10,000 points
		dc.b $FC, 4, 0,	7, $00, 1
byte_94E5:	dc.w 2
		dc.b $FC, 8, 0,	6, $FF, $F4	; 100,000 points
		dc.b $FC, 4, 0,	7, $00, 6
		even
