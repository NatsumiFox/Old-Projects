; ---------------------------------------------------------------------------
; Debug	list - Green Hill
; ---------------------------------------------------------------------------
	dc.w 6			; number of items in list
	dc.l Map_obj25+$25000000	; mappings pointer, object type * 10^6
	dc.b 0,	0, $27,	$B2		; subtype, frame, VRAM setting (2 bytes)
	dc.l Map_obj26+$26000000
	dc.b 2,	4, 6, $80
	dc.l Map_obj26+$26000000
	dc.b 5,	7, 6, $80
	dc.l Map_obj26+$26000000
	dc.b 4,	6, 6, $80
	dc.l Map_obj26+$26000000
	dc.b 8,	10, 6, $80
	dc.l Map_obj26+$26000000
	dc.b 9,	11, 6, $80
	even