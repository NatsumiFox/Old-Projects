; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 1 format
; --------------------------------------------------------------------------------

SME_vPhRV:	
		dc.w SME_vPhRV_C-SME_vPhRV, SME_vPhRV_12-SME_vPhRV	
		dc.w SME_vPhRV_18-SME_vPhRV, SME_vPhRV_1E-SME_vPhRV	
		dc.w SME_vPhRV_24-SME_vPhRV, SME_vPhRV_2A-SME_vPhRV	
SME_vPhRV_C:	dc.b 1	
		dc.b $F8, 5, 0, 0, $F8	
SME_vPhRV_12:	dc.b 1	
		dc.b $F8, 5, 0, 4, $F8	
SME_vPhRV_18:	dc.b 1	
		dc.b $F8, 5, 0, 8, $F8	
SME_vPhRV_1E:	dc.b 1	
		dc.b $F4, 2, 0, $C, $FC	
SME_vPhRV_24:	dc.b 1	
		dc.b $F4, 2, 0, $F, $FC	
SME_vPhRV_2A:	dc.b 1	
		dc.b $F4, 2, 0, $12, $FC	
		even