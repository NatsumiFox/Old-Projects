; ---------------------------------------------------------------------------
; Sprite mappings - water surface (LZ)
; ---------------------------------------------------------------------------
Map_Surf:	dc.w @normal1-Map_Surf, @normal2-Map_Surf
		dc.w @normal3-Map_Surf, @paused1-Map_Surf
		dc.w @paused2-Map_Surf, @paused3-Map_Surf
@normal1:	dc.w 3
		dc.b $FD, $D, 0, 0, $FF, $A0
		dc.b $FD, $D, 0, 0, $FF, $E0
		dc.b $FD, $D, 0, 0, $00, $20
@normal2:	dc.w 3
		dc.b $FD, $D, 0, 8, $FF, $A0
		dc.b $FD, $D, 0, 8, $FF, $E0
		dc.b $FD, $D, 0, 8, $00, $20
@normal3:	dc.w 3
		dc.b $FD, $D, 8, 0, $FF, $A0
		dc.b $FD, $D, 8, 0, $FF, $E0
		dc.b $FD, $D, 8, 0, $00, $20
@paused1:	dc.w 6
		dc.b $FD, $D, 0, 0, $FF, $A0
		dc.b $FD, $D, 0, 0, $FF, $C0
		dc.b $FD, $D, 0, 0, $FF, $E0
		dc.b $FD, $D, 0, 0, $00, 0
		dc.b $FD, $D, 0, 0, $00, $20
		dc.b $FD, $D, 0, 0, $00, $40
@paused2:	dc.w 6
		dc.b $FD, $D, 0, 8, $FF, $A0
		dc.b $FD, $D, 0, 8, $FF, $C0
		dc.b $FD, $D, 0, 8, $FF, $E0
		dc.b $FD, $D, 0, 8, $00, 0
		dc.b $FD, $D, 0, 8, $00, $20
		dc.b $FD, $D, 0, 8, $00, $40
@paused3:	dc.w 6
		dc.b $FD, $D, 8, 0, $FF, $A0
		dc.b $FD, $D, 8, 0, $FF, $C0
		dc.b $FD, $D, 8, 0, $FF, $E0
		dc.b $FD, $D, 8, 0, $00, 0
		dc.b $FD, $D, 8, 0, $00, $20
		dc.b $FD, $D, 8, 0, $00, $40
		even
