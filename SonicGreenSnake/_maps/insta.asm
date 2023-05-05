Map_InstaShield:
	dc.w	word_1A0E0-Map_InstaShield
	dc.w	word_1A0F4-Map_InstaShield
	dc.w	word_1A108-Map_InstaShield
	dc.w	word_1A116-Map_InstaShield
	dc.w	word_1A12A-Map_InstaShield
	dc.w	word_1A13E-Map_InstaShield
	dc.w	word_1A152-Map_InstaShield
	dc.w	word_1A152-Map_InstaShield

word_1A0E0:	dc.b 3
	dc.b $E8, 8, 0, 0, $F0
	dc.b $F0, 4, 0, 3, $F8
	dc.b $F8, 0, 0, 5, 0

word_1A0F4:	dc.b 3
	dc.b $F0, 4, 0, 6, 8
	dc.b $F8, 8, 0, 8, 0
	dc.b 0, 4, 0, $B, 0

word_1A108:	dc.b 2
	dc.b 0, 9, 0, $D, 0
	dc.b $10, $C, 0, $13, $F8

word_1A116:	dc.b 3
	dc.b $F0, $C, 0, 0, $E8
	dc.b $F8, 8, 0, 4, $E8
	dc.b 0, 6, 0, 7, $E8

word_1A12A:	dc.b 3
	dc.b $E8, 4, 0, $D, $F0
	dc.b $E8, $B, 0, $F, 0
	dc.b 8, 4, 0, $1B, 8

word_1A13E:	dc.b 3
	dc.b $F0, 4, $18, $1B, $E8
	dc.b $F8, $B, $18, $F, $E8
	dc.b $10, 4, $18, $D, 0

word_1A152:	dc.b 0

	even
