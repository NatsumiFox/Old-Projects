; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 3 & Knuckles format
; --------------------------------------------------------------------------------

SME_I2cI2:	
		dc.w SME_I2cI2_12-SME_I2cI2, SME_I2cI2_14-SME_I2cI2	
		dc.w SME_I2cI2_1C-SME_I2cI2, SME_I2cI2_24-SME_I2cI2	
		dc.w SME_I2cI2_2C-SME_I2cI2, SME_I2cI2_34-SME_I2cI2	
		dc.w SME_I2cI2_3C-SME_I2cI2, SME_I2cI2_44-SME_I2cI2	
		dc.w SME_I2cI2_4C-SME_I2cI2	
SME_I2cI2_12:	dc.b 0, 0	
SME_I2cI2_14:	dc.b 0, 1	
		dc.b $F8, 0, 0, 0, $FF, $FC	
SME_I2cI2_1C:	dc.b 0, 1	
		dc.b $F8, 0, 0, 1, $FF, $FC	
SME_I2cI2_24:	dc.b 0, 1	
		dc.b $F8, 1, 0, 2, $FF, $FC	
SME_I2cI2_2C:	dc.b 0, 1	
		dc.b $F8, 1, 0, 4, $FF, $FC	
SME_I2cI2_34:	dc.b 0, 1	
		dc.b $F8, 1, 0, 6, $FF, $FC	
SME_I2cI2_3C:	dc.b 0, 1	
		dc.b $F8, 5, 0, 8, $FF, $F8	
SME_I2cI2_44:	dc.b 0, 1	
		dc.b $F8, 5, 0, $C, $FF, $F8	
SME_I2cI2_4C:	dc.b 0, 2	
		dc.b $F0, 7, 0, $10, 0, 0	
		dc.b $F0, 7, 8, $10, $FF, $F1	
		even