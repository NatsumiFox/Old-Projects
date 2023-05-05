; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 1 format
; --------------------------------------------------------------------------------

SME_cqnrt:	
		dc.w SME_cqnrt_8-SME_cqnrt, SME_cqnrt_13-SME_cqnrt	
		dc.w SME_cqnrt_1E-SME_cqnrt, SME_cqnrt_29-SME_cqnrt	
SME_cqnrt_8:	dc.b 2	
		dc.b $F5, 5, 0, 0, $F0	
		dc.b $F5, 5, 8, 0, 0	
SME_cqnrt_13:	dc.b 2	
		dc.b $F5, 5, 0, 4, $F0	
		dc.b $F5, 5, 8, 4, 0	
SME_cqnrt_1E:	dc.b 2	
		dc.b $F5, 5, $FF, $FC, $F0	
		dc.b $F5, 5, 7, $FC, 0	
SME_cqnrt_29:	dc.b 2	
		dc.b $F5, 5, 0, 4, $F0	
		dc.b $F5, 5, 8, 4, 0	
		even