; ---------------------------------------------------------------------------
; Pallet pointers
; ---------------------------------------------------------------------------
	dc.l pal2_SegaBG		; pallet address
	dc.w $FB00		; RAM address
	dc.w $1F		; (pallet length / 2) - 1
	dc.l pal2_Title
	dc.w $FB00
	dc.w $1F
	dc.l pal2_LevelSel
	dc.w $FB00
	dc.w $1F
	dc.l pal2_Sonic
	dc.w $FB00
	dc.w 7
	dc.l pal2_GHZ
	dc.w $FB20
	dc.w $17
	dc.l pal2_LZ
	dc.w $FB20
	dc.w $17
	dc.l pal2_MZ
	dc.w $FB20
	dc.w $17
	dc.l pal2_SLZ
	dc.w $FB20
	dc.w $17
	dc.l pal2_SYZ
	dc.w $FB20
	dc.w $17
	dc.l pal2_SBZ1
	dc.w $FB20
	dc.w $17
	dc.l pal2_Special
	dc.w $FB00
	dc.w $1F
	dc.l pal2_LZWater
	dc.w $FB00
	dc.w $1F
	dc.l pal2_SBZ3
	dc.w $FB20
	dc.w $17
	dc.l pal2_SBZ3Water
	dc.w $FB00
	dc.w $1F
	dc.l pal2_SBZ2
	dc.w $FB20
	dc.w $17
	dc.l pal2_LZSonWater
	dc.w $FB00
	dc.w 7
	dc.l pal2_SBZ3SonWat
	dc.w $FB00
	dc.w 7
	dc.l pal2_SpeResult
	dc.w $FB00
	dc.w $1F
	dc.l pal2_SpeContinue
	dc.w $FB00
	dc.w $F
	dc.l pal2_Ending
	dc.w $FB00
	dc.w $1F
        dc.l pal2_Tails
	dc.w $FB00
	dc.w 7 
	dc.l pal2_Green_Snake
	dc.w $FB00
	dc.w 7 
        dc.l Menu_Palette              ; pallet address 
        dc.w $FB00                    ; RAM address 
        dc.w $1F                      ;(pallet length / 2) - 1
	dc.l pal2_Info		; 16
	dc.w $FB00
	dc.w $1F       	      