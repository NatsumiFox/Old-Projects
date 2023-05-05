; ---------------------------------------------------------------------------
; Debug	list - Star Light
; ---------------------------------------------------------------------------
	dc.w $10
	dc.l Map_sonic+$03000000	; mappings pointer, object type * 10^6
	dc.b 0,	0, 7, $80	; subtype, frame, VRAM setting (2 bytes)
	dc.l Map_obj25+$25000000
	dc.b 0,	0, $27,	$B2
	dc.l Map_obj26+$26000000
	dc.b 0,	0, 6, $80
	dc.l Map_obj59+$59000000
	dc.b 0,	0, $40,	0
	dc.l Map_obj53+$53000000
	dc.b 0,	2, $44,	$E0
	dc.l Map_obj18b+$18000000
	dc.b 0,	0, $40,	0
	dc.l Map_obj5A+$5A000000
	dc.b 0,	0, $40,	0
	dc.l Map_obj5B+$5B000000
	dc.b 0,	0, $40,	0
	dc.l Map_obj5D+$5D000000
	dc.b 0,	0, $43,	$A0
	dc.l Map_obj5E+$5E000000
	dc.b 0,	0, 3, $74
	dc.l Map_obj41+$41000000
	dc.b 0,	0, 5, $23
	dc.l Map_obj14+$13000000
	dc.b 0,	0, 4, $80
	dc.l Map_obj1C+$1C000000
	dc.b 0,	0, $44,	$D8
	dc.l Map_obj5F+$5F000000
	dc.b 0,	0, 4, 0
	dc.l Map_obj60+$60000000
	dc.b 0,	0, $24,	$29
	dc.l Map_obj79+$79000000
	dc.b 1,	0, 7, $A0
	even