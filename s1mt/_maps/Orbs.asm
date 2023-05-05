; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 1 format
; --------------------------------------------------------------------------------

SME_IkUd3:	
		dc.w SME_IkUd3_8-SME_IkUd3, SME_IkUd3_E-SME_IkUd3	
		dc.w SME_IkUd3_14-SME_IkUd3, SME_IkUd3_1F-SME_IkUd3	
SME_IkUd3_8:	dc.b 1	
		dc.b $F4, $A, 0, 0, $F4	
SME_IkUd3_E:	dc.b 1	
		dc.b $F4, $A, 0, 9, $F4	
SME_IkUd3_14:	dc.b 2	
		dc.b $F0, $D, 0, $12, $F0	
		dc.b 0, $D, $18, $12, $F0	
SME_IkUd3_1F:	dc.b 2	
		dc.b $F0, $D, 0, $1A, $F0	
		dc.b 0, $D, $18, $1A, $F0	
		even