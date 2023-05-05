; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 3 & Knuckles format
; --------------------------------------------------------------------------------

SME_pSm3e:
		dc.w SME_pSm3e_4-SME_pSm3e, SME_pSm3e_24-SME_pSm3e
SME_pSm3e_4:	dc.w 5
		dc.b $DC, $F, 0, 0, $FF, $F4
		dc.b $EC, 0, 0, $10, 0, $14
		dc.b $FC, $C, 0, $11, $FF, $F4
		dc.b 4, $E, 0, $15, $FF, $EC
		dc.b 4, 1, 0, $21, 0, $C
SME_pSm3e_24:	dc.w 4
		dc.b $E8, $A, 0, $23, $FF, $E8
		dc.b $E8, $A, 0, $23+9, 0, 0
		dc.b 0, $A, 0, $23+$12, $FF, $E8
		dc.b 0, $A, 0, $23+$1B, 0, 0
		even
