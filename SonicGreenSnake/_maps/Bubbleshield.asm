Map_BubbleShield:
	dc.w	word_19F9C-Map_BubbleShield
	dc.w	word_19FA4-Map_BubbleShield
	dc.w	word_19FB2-Map_BubbleShield
	dc.w	word_19FC0-Map_BubbleShield
	dc.w	word_19FCE-Map_BubbleShield
	dc.w	word_19FDC-Map_BubbleShield
	dc.w	word_19FEA-Map_BubbleShield
	dc.w	word_19FF8-Map_BubbleShield
	dc.w	word_1A006-Map_BubbleShield
	dc.w	word_1A014-Map_BubbleShield
	dc.w	word_1A02E-Map_BubbleShield
	dc.w	word_1A048-Map_BubbleShield
	dc.w	word_1A062-Map_BubbleShield

word_19F9C:	dc.b 1
	dc.b $E8, $C, 0, 0, $F0

word_19FA4:	dc.b 2
	dc.b $E8, 9, 0, 0, $E8
	dc.b $E8, 9, 8, 0, 0

word_19FB2:	dc.b 2
	dc.b $E8, $A, 0, 0, $E8
	dc.b $E8, $A, 8, 0, 0

word_19FC0:	dc.b 2
	dc.b $E8, $A, 0, 0, $E8
	dc.b $E8, $A, 8, 0, 0

word_19FCE:	dc.b 2
	dc.b $F0, $B, 0, 0, $E8
	dc.b $F0, $B, 8, 0, 0

word_19FDC:	dc.b 2
	dc.b 0, $A, $10, 0, $E8
	dc.b 0, $A, $18, 0, 0

word_19FEA:	dc.b 2
	dc.b 0, $A, $10, 0, $E8
	dc.b 0, $A, $18, 0, 0

word_19FF8:	dc.b 2
	dc.b 8, 9, $10, 0, $E8
	dc.b 8, 9, $18, 0, 0

word_1A006:	dc.b 2
	dc.b $10, 4, $10, 0, $F0
	dc.b $10, 4, $18, 0, 0

word_1A014:	dc.b 4
	dc.b $E8, $A, 0, 0, $E8
	dc.b $E8, $A, 0, 9, 0
	dc.b 0, $A, $10, 0, $E8
	dc.b 0, $A, $18, 0, 0

word_1A02E:	dc.b 4
	dc.b $E8, $A, 0, 0, $E8
	dc.b $E8, $A, 0, 9, 0
	dc.b 0, $A, $10, 0, $E8
	dc.b 0, $A, $18, 0, 0

word_1A048:	dc.b 4
	dc.b $EC, $D, 0, 0, $E4
	dc.b $EC, 9, 0, 8, 4
	dc.b $FC, $E, 0, $E, $E4
	dc.b $FC, $A, 8, $E, 4

word_1A062:	dc.b 3
	dc.b $F0, $F, 0, 0, $DC
	dc.b $F0, 3, 0, $10, $FC
	dc.b $F0, $F, 0, $14, 4

	even
