; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 1 format
; --------------------------------------------------------------------------------

SME_eeGDW:	
		dc.w SME_eeGDW_C-SME_eeGDW, SME_eeGDW_21-SME_eeGDW	
		dc.w SME_eeGDW_36-SME_eeGDW, SME_eeGDW_41-SME_eeGDW	
		dc.w SME_eeGDW_60-SME_eeGDW, SME_eeGDW_B1-SME_eeGDW	
SME_eeGDW_C:	dc.b 4	
		dc.b $F0, 3, 0, 4, $F1	
		dc.b $F0, 3, 0, 4, $F9	
		dc.b $F0, 3, 0, 4, 1	
		dc.b $F0, 3, 0, 4, 9	
SME_eeGDW_21:	dc.b 4	
		dc.b $F0, $C, 0, 0, $F1	
		dc.b $F8, $C, 0, 0, $F1	
		dc.b 0, $C, 0, 0, $F1	
		dc.b 8, $C, 0, 0, $F1	
SME_eeGDW_36:	dc.b 2	
		dc.b $F0, 3, 0, 4, $FF	
		dc.b $F0, 3, 0, 4, 7	
SME_eeGDW_41:	dc.b 6	
		dc.b $F0, 3, 0, 4, $E9	
		dc.b $F0, 3, 0, 4, $F1	
		dc.b $F0, 3, 0, 4, $F9	
		dc.b $F0, 3, 0, 4, 1	
		dc.b $F0, 3, 0, 4, 9	
		dc.b $F0, 3, 0, 4, $11	
SME_eeGDW_60:	dc.b $10	
		dc.b $F0, 3, 0, 4, $10	
		dc.b $F0, 3, 0, 4, 8	
		dc.b $F0, 3, 0, 4, $18	
		dc.b $F0, 3, 0, 4, 0	
		dc.b $F0, 3, 0, 4, $20	
		dc.b $F0, 3, 0, 4, $F8	
		dc.b $F0, 3, 0, 4, $28	
		dc.b $F0, 3, 0, 4, $F0	
		dc.b $F0, 3, 0, 4, $30	
		dc.b $F0, 3, 0, 4, $E8	
		dc.b $F0, 3, 0, 4, $38	
		dc.b $F0, 3, 0, 4, $E0	
		dc.b $F0, 3, 0, 4, $D8	
		dc.b $F0, 3, 0, 4, $D0	
		dc.b $F0, 3, 0, 4, $C8	
		dc.b $F0, 3, 0, 4, $C0	
SME_eeGDW_B1:	dc.b 2	
		dc.b $F8, $C, 0, 0, $E9	
		dc.b 0, $C, 0, 0, $E9	
		even