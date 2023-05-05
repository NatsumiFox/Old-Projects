; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 1 format
; --------------------------------------------------------------------------------

SME_kbGvK:	
		dc.w SME_kbGvK_14-SME_kbGvK, SME_kbGvK_24-SME_kbGvK	
		dc.w SME_kbGvK_34-SME_kbGvK, SME_kbGvK_44-SME_kbGvK	
		dc.w SME_kbGvK_54-SME_kbGvK, SME_kbGvK_64-SME_kbGvK	
		dc.w SME_kbGvK_74-SME_kbGvK, SME_kbGvK_84-SME_kbGvK	
		dc.w SME_kbGvK_94-SME_kbGvK, SME_kbGvK_9A-SME_kbGvK	
SME_kbGvK_14:	dc.b 3	
		dc.b $E4, 7, 0, 0, $F8
		dc.b 4, 5, 0, 8, $F8
		dc.b $D4, $D, 0, $C, $F0

SME_kbGvK_24:	dc.b 3
		dc.b $E4, 7, 8, 0, $F8
		dc.b 4, 5, 8, 8, $F8
		dc.b $D4, $D, 8, $C, $F0

SME_kbGvK_34:	dc.b 3
		dc.b $E4, 7, 0, 0, $F8
		dc.b 4, 5, 0, 8, $F8
		dc.b $D4, $D, 0, $14, $F0

SME_kbGvK_44:	dc.b 3
		dc.b $E4, 7, 8, 0, $F8
		dc.b 4, 5, 8, 8, $F8
		dc.b $D4, $D, 8, $14, $F0

SME_kbGvK_54:	dc.b 3
		dc.b $E4, 7, 0, 0, $F8
		dc.b 4, 5, 0, 8, $F8
		dc.b $D4, 5, 0, $1C, $F8

SME_kbGvK_64:	dc.b 3
		dc.b $E4, 7, 8, 0, $F8
		dc.b 4, 5, 8, 8, $F8
		dc.b $D4, 5, 8, $1C, $F8

SME_kbGvK_74:	dc.b 3
		dc.b $E4, 7, 0, 0, $F8
		dc.b 4, 5, 0, 8, $F8
		dc.b $D4, 1, 0, $20, $FC

SME_kbGvK_84:	dc.b 3
		dc.b $E4, 7, 8, 0, $F8
		dc.b 4, 5, 8, 8, $F8
		dc.b $D4, 1, 8, $20, $FC

SME_kbGvK_94:	dc.b 1
		dc.b 0, $D, 0, $C, 0

SME_kbGvK_9A:	dc.b 1
		dc.b 0, $D, 0, $14, 0
		even