; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 1 format
; --------------------------------------------------------------------------------

SME_ByBCX:	
		dc.w SME_ByBCX_4-SME_ByBCX, SME_ByBCX_5-SME_ByBCX	
SME_ByBCX_4:	dc.b 0	
SME_ByBCX_5:	dc.b 7	
		dc.b $E0, $C, 0, 2, $F8	
		dc.b $E0, 0, 0, 6, $18	
		dc.b $E0, 4, 0, 7, $20	
		dc.b $E0, 4, 0, 9, $30	
		dc.b $E0, 4, 0, $B, $40	
		dc.b $E0, $C, 0, $D, $50	
		dc.b $E0, 8, 0, $11, $70	
		even