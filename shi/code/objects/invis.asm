Obj_Invincibility:
		move.l	#ArtUnc_Invincibility,d1
		move.w	#$F380,d2
		move.w	#$200,d3
		jsr	AddQueueDMA
		moveq	#0,d2
		lea	loc_187D8(pc),a2
		lea	(a0),a1
		moveq	#3,d1

loc_1880E:
		move.l	#Obj_188E8,(a1)
		move.l	#Map_Invincibility,$C(a1)
		move.w	#$79C,$A(a1)
		move.w	#$80,8(a1)
		move.b	#4,4(a1)
		bset	#6,4(a1)
		move.b	#$10,7(a1)
		move.w	#2,$16(a1)
		move.w	$42(a0),$42(a1)
		move.b	d2,$36(a1)
		addq.w	#1,d2
		move.l	(a2)+,$30(a1)
		move.w	(a2)+,$34(a1)
		lea	$4A(a1),a1
		dbf	d1,loc_1880E
		move.l	#loc_18868,(a0)
		move.b	#4,$34(a0)

loc_18868:
		tst.b	Super_Flag.w
		bne.w	DeleteObject_This
		tst.b	Super_Tails_Flag.w
		bne.w	DeleteObject_This
		movea.w	$42(a0),a1
		btst	#1,$2B(a1)
		beq.w	DeleteObject_This
		move.w	$10(a1),d0
		move.w	d0,$10(a0)
		move.w	$14(a1),d1
		move.w	d1,$14(a0)
		lea	$18(a0),a2
		lea	byte_189E0(pc),a3
		moveq	#0,d5


; ---------------------------------------------------------------------------

loc_188A0:
		move.w	$38(a0),d2
		move.b	(a3,d2.w),d5
		bpl.s	loc_188B0
		clr.w	$38(a0)
		bra.s	loc_188A0

loc_188B0:
		addq.w	#1,$38(a0)
		lea	word_189A0(pc),a6
		move.b	$34(a0),d6
		jsr	sub_1898A(pc)
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		move.w	d5,(a2)+
		addi.w	#$20,d6
		jsr	sub_1898A(pc)
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		move.w	d5,(a2)+
		moveq	#$12,d0
		btst	#0,$2A(a1)
		beq.s	loc_188E0
		neg.w	d0


; ---------------------------------------------------------------------------

loc_188E0:
		add.b	d0,$34(a0)
		bra.w	DrawSprite

Obj_188E8:
		tst.b	Super_Flag.w
		bne.w	DeleteObject_This
		tst.b	Super_Tails_Flag.w
		bne.w	DeleteObject_This
		movea.w	$42(a0),a1
		btst	#1,$2B(a1)
		beq.w	DeleteObject_This
		lea	Sonic_Pos_Record_Index.w,a5
		lea	Position_table.w,a6
		move.b	$36(a0),d1
		lsl.b	#2,d1
		move.w	d1,d2
		add.w	d1,d1
		add.w	d2,d1
		move.w	(a5),d0
		sub.b	d1,d0
		lea	(a6,d0.w),a2
		move.w	(a2)+,d0
		move.w	(a2)+,d1
		move.w	d0,$10(a0)
		move.w	d1,$14(a0)
		lea	$18(a0),a2
		movea.l	$30(a0),a3


; ---------------------------------------------------------------------------

loc_18936:
		move.w	$38(a0),d2
		move.b	(a3,d2.w),d5
		bpl.s	loc_18946
		clr.w	$38(a0)
		bra.s	loc_18936

loc_18946:
		swap	d5
		add.b	$35(a0),d2
		move.b	(a3,d2.w),d5
		addq.w	#1,$38(a0)
		lea	word_189A0(pc),a6
		move.b	$34(a0),d6
		jsr	sub_1898A(pc)
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		move.w	d5,(a2)+
		addi.w	#$20,d6
		swap	d5
		jsr	sub_1898A(pc)
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		move.w	d5,(a2)+
		moveq	#2,d0
		btst	#0,$2A(a1)
		beq.s	loc_18982
		neg.w	d0


; ############### S U B	R O U T	I N E #######################################

loc_18982:
		add.b	d0,$34(a0)
		bra.w	DrawSprite


; End of function sub_1898A
; ---------------------------------------------------------------------------

sub_1898A:
		andi.w	#$3E,d6
		move.b	(a6,d6.w),d2
		move.b	1(a6,d6.w),d3
		ext.w	d2
		ext.w	d3
		add.w	d0,d2
		add.w	d1,d3
		rts

word_189A0:
		dc.w   $F00,  $F03,  $E06,  $D08,  $B0B,  $80D,	 $60E,	$30F,	$10, $FC0F, $F90E, $F70D, $F40B, $F208,	$F106, $F003
		dc.w  $F000, $F0FC, $F1F9, $F2F7, $F4F4, $F7F2,	$F9F1, $FCF0, $FFF0,  $3F0,  $6F1,  $8F2,  $BF4,  $DF7,	 $EF9,	$FFC

byte_189E0:
		dc.b	8,   5,	  7,   6,   6,	 7,   5,   8,	6,   7,	  7,   6, $FF

byte_189ED:
		dc.b 8,   7,	  6,   5,   4,	 3,   4,   5,	6,   7,	$FF,   3,   4,	 5,   6,   7
		dc.b 	8,   7,	  6,   5,   4

byte_18A02:
		dc.b 8,   7,	  6,   5,   4,	 3,   2,   3,	4,   5,	  6,   7, $FF,	 2,   3,   4
		dc.b 	5,   6,	  7,   8,   7,	 6,   5,   4,	3

byte_18A1B:
		dc.b 7,   6,	  5,   4,   3,	 2,   1,   2,	3,   4,	  5,   6, $FF,	 1,   2,   3
		dc.b 	4,   5,	  6,   7,   6,	 5,   4,   3,	2
Map_Invincibility:
		dc.w word_18AFC-Map_Invincibility
		dc.w word_18AFE-Map_Invincibility
		dc.w word_18B06-Map_Invincibility
		dc.w word_18B0E-Map_Invincibility
		dc.w word_18B16-Map_Invincibility
		dc.w word_18B1E-Map_Invincibility
		dc.w word_18B26-Map_Invincibility
		dc.w word_18B2E-Map_Invincibility
		dc.w word_18B36-Map_Invincibility

word_18AFC:
		dc.w 0

word_18AFE:
		dc.w 1
		dc.b  $F8,   0,	  0,   0, $FF, $FC

word_18B06:
		dc.w 1
		dc.b  $F8,   0,	  0,   1, $FF, $FC

word_18B0E:
		dc.w 1
		dc.b  $F8,   1,	  0,   2, $FF, $FC

word_18B16:
		dc.w 1
		dc.b  $F8,   1,	  0,   4, $FF, $FC

word_18B1E:
		dc.w 1
		dc.b  $F8,   1,	  0,   6, $FF, $FC

word_18B26:
		dc.w 1
		dc.b  $F8,   5,	  0,   8, $FF, $F8

word_18B2E:
		dc.w 1
		dc.b  $F8,   5,	  0,  $C, $FF, $F8


; ---------------------------------------------------------------------------

word_18B36:
		dc.w 1
		dc.b  $F0,  $F,	  0, $10, $FF, $F0


; --------------------------------------------------------------------------
