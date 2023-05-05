; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 1 format
; --------------------------------------------------------------------------------

SME_ySAPB:	
		dc.w SME_ySAPB_E-SME_ySAPB, SME_ySAPB_E-SME_ySAPB
		dc.w SME_ySAPB_E-SME_ySAPB, SME_ySAPB_R-SME_ySAPB
		dc.w SME_ySAPB_3F-SME_ySAPB, SME_ySAPB_45-SME_ySAPB	
		dc.w SME_ySAPB_45R-SME_ySAPB
SME_ySAPB_E:	dc.b 3	
		dc.b $F0, $B, 0, 0, $E8	
		dc.b $F0, $B, 0, $C, 0	
		dc.b $10, 1, 0, $18, $FC
SME_ySAPB_R:	dc.b 3
		dc.b $F0, $B, 0, 0, $E8
		dc.b $F0, $B, 8, $C, 0
		dc.b $10, 1, 0, $18, $FC
SME_ySAPB_3F:	dc.b 2
		dc.b $F0, $F, 0, 0, $F0
		dc.b $10, 1, 0, $18, $FC
SME_ySAPB_45:	dc.b 2
		dc.b $F0, 3, 0, 0, $FC
		dc.b $10, 1, 0, $18, $FC
SME_ySAPB_45R:	dc.b 2
		dc.b $F0, $F, 8, 0, $F0
		dc.b $10, 1, 0, $18, $FC
		even