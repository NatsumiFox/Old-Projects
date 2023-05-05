; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 1 format
; --------------------------------------------------------------------------------

SME_80jkH:	
		dc.w SME_80jkH_10-SME_80jkH, SME_80jkH_20-SME_80jkH	
		dc.w SME_80jkH_30-SME_80jkH, SME_80jkH_3B-SME_80jkH	
		dc.w SME_80jkH_4B-SME_80jkH, SME_80jkH_5B-SME_80jkH	
		dc.w SME_80jkH_6B-SME_80jkH, SME_80jkH_6C-SME_80jkH	
SME_80jkH_10:	dc.b 3	
		dc.b $E8, 8, 0, 0, $F0	
		dc.b $F0, 4, 0, 3, $F8	
		dc.b $F8, 0, 0, 5, 0	
SME_80jkH_20:	dc.b 3	
		dc.b $F0, 4, 0, 6, 8	
		dc.b $F8, 8, 0, 8, 0	
		dc.b 0, 4, 0, $B, 0	
SME_80jkH_30:	dc.b 2	
		dc.b 0, 9, 0, $D, 0	
		dc.b $10, $C, 0, $13, $F8	
SME_80jkH_3B:	dc.b 3	
		dc.b $F0, $C, 0, 0, $E8	
		dc.b $F8, 8, 0, $10, $E8	
		dc.b 0, 6, 0, 7, $E8	
SME_80jkH_4B:	dc.b 3	
		dc.b $E8, 4, 0, 0, $F0	
		dc.b $E8, $B, 0, $10, 0	
		dc.b 8, 4, 0, $1B, 8	
SME_80jkH_5B:	dc.b 3	
		dc.b $F0, 4, $18, 0, $E8	
		dc.b $F8, $B, $18, $10, $E8	
		dc.b $10, 4, $18, $D, 0	
SME_80jkH_6B:	dc.b 0	
SME_80jkH_6C:	dc.b 0	
		even