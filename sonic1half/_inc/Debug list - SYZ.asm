; ---------------------------------------------------------------------------
; Debug	list - Spring Yard
; ---------------------------------------------------------------------------
	dc.w $10
	dc.l Map_sonic+$03000000	; mappings pointer, object type * 10^6
	dc.b 0,	0, 7, $80	; subtype, frame, VRAM setting (2 bytes)
	dc.l Map_obj25+$25000000
	dc.b 0,	0, $27,	$B2
	dc.l Map_obj26+$26000000
	dc.b 0,	0, 6, $80
	dc.l Map_obj36+$36000000
	dc.b 0,	0, 5, $1B
	dc.l Map_obj41+$41000000
	dc.b 0,	0, 5, $23
	dc.l Map_obj43+$43000000
	dc.b 0,	0, 4, $B8
	dc.l Map_obj12+$12000000
	dc.b 0,	0, 0, 0
	dc.l Map_obj47+$47000000
	dc.b 0,	0, 3, $80
	dc.l Map_obj1F+$1F000000
	dc.b 0,	0, 4, 0
	dc.l Map_obj22+$22000000
	dc.b 0,	0, 4, $44
	dc.l Map_obj50+$50000000
	dc.b 0,	0, $24,	$7B
	dc.l Map_obj18a+$18000000
	dc.b 0,	0, $40,	0
	dc.l Map_obj56+$56000000
	dc.b 0,	0, $40,	0
	dc.l Map_obj32+$32000000
	dc.b 0,	0, 5, $13
	dc.l Map_obj78+$78000000
	dc.b 0,	0, $24,	$FF
	dc.l Map_obj79+$79000000
	dc.b 1,	0, 7, $A0
	even