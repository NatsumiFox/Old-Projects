; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 1 format
; --------------------------------------------------------------------------------

SME_CeWGk:	
		dc.w SME_CeWGk_A-SME_CeWGk, SME_CeWGk_1F-SME_CeWGk	
		dc.w SME_CeWGk_34-SME_CeWGk, SME_CeWGk_3F-SME_CeWGk	
		dc.w SME_CeWGk_4A-SME_CeWGk	
SME_CeWGk_A:	dc.b 4	
		dc.b $E4, $B, 0, 0, $E8	
		dc.b $E4, $B, 0, $C, 0	
		dc.b 4, $A, 0, $18, $E8	
		dc.b 4, $A, 0, $21, 0	
SME_CeWGk_1F:	dc.b 4	
		dc.b $E4, $B, 0, $2A, $E8	
		dc.b $E4, $B, 0, $36, 0	
		dc.b 4, $A, 0, $42, $E8	
		dc.b 4, $A, 0, $4B, 0	
SME_CeWGk_34:	dc.b 2	
		dc.b $E8, $F, 0, $54, $F0	
		dc.b 8, $D, 0, $64, $F0	
SME_CeWGk_3F:	dc.b 2	
		dc.b $E8, $F, 0, $6C, $F0	
		dc.b 8, $D, 0, $7C, $F0	
SME_CeWGk_4A:	dc.b 0	
		even