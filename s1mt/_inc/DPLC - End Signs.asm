; --------------------------------------------------------------------------------
; Dynamic Pattern Loading Cues - output from SonMapEd - Sonic 1 format; --------------------------------------------------------------------------------

SME_ulvWW:	
		dc.w SME_ulvWW_E-SME_ulvWW, SME_ulvWW_15-SME_ulvWW	
		dc.w SME_ulvWW_1C-SME_ulvWW, SME_ulvWW_21-SME_ulvWW	
		dc.w SME_ulvWW_26-SME_ulvWW, SME_ulvWW_29-SME_ulvWW	
		dc.w SME_ulvWW_26-SME_ulvWW
SME_ulvWW_E:	dc.b 3
		dc.w $B020, $B02C, $1068
SME_ulvWW_15:	dc.b 3
		dc.w $B038, $B044, $1068
SME_ulvWW_1C:	dc.b 3
		dc.w $B050, $B05C, $1068
SME_ulvWW_21:	dc.b 3
		dc.w $B000, $B000, $1068
SME_ulvWW_26:	dc.b 2
		dc.w $F00C, $1068
SME_ulvWW_29:	dc.b 2
		dc.w $301C, $1068
		even