; ---------------------------------------------------------------------------
; Sprite mappings - SCORE, TIME, RINGS
; ---------------------------------------------------------------------------
		dc.w byte_1C5BC-Map_obj21, byte_1C5F0-Map_obj21
		dc.w byte_1C624-Map_obj21, byte_1C658-Map_obj21
Obj21_EggFrame:
		dc.b $80, $D, $7F, $D6, 0

byte_1C5BC:	dc.b 9
Obj21_SCOR:
		dc.b $80, $D, $80, 0, 0
		dc.b $80, $D, $80, $18,	$20
		dc.b $80, $D, $80, $20,	$40
		dc.b $90, $D, $80, $10,	0
		dc.b $90, $D, $80, $28,	$28
Obj21_RINGyell:
		dc.b $A0, $D, $80, 8, 0
		dc.b $A0, 1, $80, 0, $20
		dc.b $A0, 9, $80, $30, $30
Obj21_LivesData:
		dc.b $40, $D, $81, $A, 0
byte_1C5F0:	dc.b 9
		dc.b $80, $D, $80, 0, 0
		dc.b $80, $D, $80, $18,	$20
		dc.b $80, $D, $80, $20,	$40
		dc.b $90, $D, $80, $10,	0
		dc.b $90, $D, $80, $28,	$28
Obj21_RINGred:
		dc.b $A0, $D, $A0, 8, 0
		dc.b $A0, 1, $A0, 0, $20
		dc.b $A0, 9, $80, $30, $30
		dc.b $40, $D, $81, $A, 0
byte_1C624:	dc.b 9
		dc.b $80, $D, $80, 0, 0
		dc.b $80, $D, $80, $18,	$20
		dc.b $80, $D, $80, $20,	$40
		dc.b $90, $D, $A0, $10,	0
		dc.b $90, $D, $80, $28,	$28
		dc.b $A0, $D, $80, 8, 0
		dc.b $A0, 1, $80, 0, $20
		dc.b $A0, 9, $80, $30, $30
		dc.b $40, $D, $81, $A, 0
byte_1C658:	dc.b 9
		dc.b $80, $D, $80, 0, 0
		dc.b $80, $D, $80, $18,	$20
		dc.b $80, $D, $80, $20,	$40
		dc.b $90, $D, $A0, $10,	0
		dc.b $90, $D, $80, $28,	$28
		dc.b $A0, $D, $A0, 8, 0
		dc.b $A0, 1, $A0, 0, $20
		dc.b $A0, 9, $80, $30, $30
		dc.b $40, $D, $81, $A, 0
		even