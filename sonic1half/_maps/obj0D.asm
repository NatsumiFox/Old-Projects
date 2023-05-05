; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 1 format
; --------------------------------------------------------------------------------

SME_b2ukL:	
		dc.w SME_b2ukL_A-SME_b2ukL, SME_b2ukL_1F-SME_b2ukL	
		dc.w SME_b2ukL_2F-SME_b2ukL, SME_b2ukL_3F-SME_b2ukL	
		dc.w SME_b2ukL_4F-SME_b2ukL	
SME_b2ukL_A:	dc.b 4	
		dc.b $E8, $B, 0, 0, $E6	
		dc.b $E8, $B, 8, 0, $FE	
		dc.b 8, 5, 0, $20, $F6	
		dc.b $18, $C, 0, $24, $EE	
SME_b2ukL_1F:	dc.b 3	
		dc.b $E8, $F, 0, $C, $EE	
		dc.b 8, 5, 0, $20, $F6	
		dc.b $18, $C, 0, $24, $EE	
SME_b2ukL_2F:	dc.b 3	
		dc.b $E8, 3, 0, $1C, $FA	
		dc.b 8, 5, 0, $20, $F6	
		dc.b $18, $C, 0, $24, $EE	
SME_b2ukL_3F:	dc.b 3	
		dc.b $E8, $F, 8, $C, $EE	
		dc.b 8, 5, 8, $20, $F6	
		dc.b $18, $C, 8, $24, $EE	
SME_b2ukL_4F:	dc.b $A	
		dc.b 0, $C, 0, $28, $E6	
		dc.b 0, 4, 0, $2C, 6	
		dc.b $F8, 8, 0, $2E, $E6	
		dc.b $F8, 8, 0, $31, $FE	
		dc.b $F0, $C, 0, $34, $E6	
		dc.b $F0, 4, 0, $38, 6	
		dc.b $E8, $C, 0, $3A, $E6	
		dc.b $E8, 4, 0, $3E, 6	
		dc.b 8, 5, 0, $20, $F6	
		dc.b $18, $C, 0, $24, $EE	
		even