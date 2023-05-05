Obj_Animal:
		moveq	#0,d0
		move.b	5(a0),d0
		move.w	off_2C786(pc,d0.w),d1
		jmp	off_2C786(pc,d1.w)

off_2C786:
		dc.w loc_2C8B8-off_2C786
		dc.w loc_2C9E0-off_2C786
		dc.w loc_2CA3C-off_2C786
		dc.w loc_2CA7C-off_2C786
		dc.w loc_2CA3C-off_2C786
		dc.w loc_2CA3C-off_2C786
		dc.w loc_2CA3C-off_2C786
		dc.w loc_2CA7C-off_2C786
		dc.w loc_2CA3C-off_2C786
		dc.w loc_2CA7C-off_2C786
		dc.w loc_2CA3C-off_2C786
		dc.w loc_2CA3C-off_2C786
		dc.w loc_2CA3C-off_2C786
		dc.w loc_2CA3C-off_2C786
		dc.w loc_2CB02-off_2C786
		dc.w loc_2CB24-off_2C786
		dc.w loc_2CB24-off_2C786
		dc.w loc_2CB44-off_2C786
		dc.w loc_2CB80-off_2C786
		dc.w loc_2CBDC-off_2C786
		dc.w loc_2CBFC-off_2C786
		dc.w loc_2CBDC-off_2C786
		dc.w loc_2CBFC-off_2C786
		dc.w loc_2CBDC-off_2C786
		dc.w loc_2CC3C-off_2C786
		dc.w loc_2CB9C-off_2C786

word_2C7EA:
		dc.w $FE00
		dc.w $FC00
		dc.l Map_2CF32
		dc.w $FE00
		dc.w $FD00
		dc.l Map_2CEBA
		dc.w $FE80
		dc.w $FD00
		dc.l Map_2CF32
		dc.w $FEC0
		dc.w $FE80
		dc.l Map_2CF14
		dc.w $FE40
		dc.w $FD00
		dc.l Map_2CEF6
		dc.w $FD00
		dc.w $FC00
		dc.l Map_2CEBA
		dc.w $FD80
		dc.w $FC80
		dc.l Map_2CED8
		dc.w $FD80
		dc.w $FD00
		dc.l Map_2CEBA
		dc.w $FE00
		dc.w $FC80
		dc.l Map_2CED8
		dc.w $FD40
		dc.w $FD00
		dc.l Map_2CED8
		dc.w $FEC0
		dc.w $FE00
		dc.l Map_2CED8
		dc.w $FE00
		dc.w $FD00
		dc.l Map_2CED8

word_2C84A:
		dc.w $FBC0, $FC00
		dc.w $FBC0, $FC00
		dc.w $FBC0, $FC00
		dc.w $FD00, $FC00
		dc.w $FD00, $FC00
		dc.w $FE80, $FD00
		dc.w $FE80, $FD00
		dc.w $FEC0, $FE80
		dc.w $FE40, $FD00
		dc.w $FE00, $FD00
		dc.w $FD80, $FC80

off_2C876:
		dc.l Map_2CEBA
		dc.l Map_2CEBA
		dc.l Map_2CEBA
		dc.l Map_2CF32
		dc.l Map_2CF32
		dc.l Map_2CF32
		dc.l Map_2CF32
		dc.l Map_2CF14
		dc.l Map_2CEF6
		dc.l Map_2CEBA
		dc.l Map_2CED8


; ---------------------------------------------------------------------------

word_2C8A2:
		dc.w $5A5
		dc.w $5A5
		dc.w $5A5
		dc.w $553
		dc.w $553
		dc.w $573
		dc.w $573
		dc.w $585
		dc.w $593
		dc.w $565
		dc.w $5B3


; ---------------------------------------------------------------------------

loc_2C8B8:
		tst.b	$2C(a0)
		beq.w	loc_2C924
		moveq	#0,d0
		move.b	$2C(a0),d0
		add.w	d0,d0
		move.b	d0,5(a0)
		subi.w	#$14,d0
		move.w	word_2C8A2(pc,d0.w),$A(a0)
		add.w	d0,d0
		move.l	off_2C876(pc,d0.w),$C(a0)
		lea	word_2C84A(pc),a1
		move.w	(a1,d0.w),$32(a0)
		move.w	(a1,d0.w),$18(a0)
		move.w	2(a1,d0.w),$34(a0)
		move.w	2(a1,d0.w),$1A(a0)
		move.b	#$C,$1E(a0)
		move.b	#4,4(a0)
		bset	#0,4(a0)
		move.w	#$300,8(a0)
		move.b	#8,7(a0)
		move.b	#7,$24(a0)
		jmp	DrawSprite

loc_2C924:
		addq.b	#2,5(a0)
		jsr	RandomNumber
		move.w	#$580,$A(a0)
		andi.w	#1,d0
		beq.s	loc_2C940
		move.w	#$592,$A(a0)

loc_2C940:
		move.b	#5,d0
		move.b	d0,$30(a0)
		lsl.w	#3,d0
		lea	word_2C7EA(pc),a1
		adda.w	d0,a1
		move.w	(a1)+,$32(a0)
		move.w	(a1)+,$34(a0)
		move.l	(a1)+,$C(a0)
		move.b	#$C,$1E(a0)
		move.b	#4,4(a0)
		bset	#0,4(a0)
		move.w	#$300,8(a0)
		move.b	#8,7(a0)
		move.b	#7,$24(a0)
		move.b	#2,$22(a0)
		move.w	#-$400,$1A(a0)
		tst.b	$38(a0)
		bne.s	loc_2C9CA
		jsr	CreateObject
		bne.s	loc_2C9C4
		move.l	#Obj_EnemyScore,(a1)
		move.w	$10(a0),$10(a1)
		move.w	$14(a0),$14(a1)
		move.w	$3E(a0),d0
		lsr.w	#1,d0
		move.b	d0,$22(a1)


; ---------------------------------------------------------------------------

loc_2C9C4:
		jmp	DrawSprite


; ---------------------------------------------------------------------------

loc_2C9CA:
		move.b	#$1C,5(a0)
		clr.w	$18(a0)
		jmp	DrawSprite


; ---------------------------------------------------------------------------

loc_2C9DA:
		jmp	DeleteObject_This

loc_2C9E0:
		tst.b	4(a0)
		bpl.s	loc_2C9DA
		jsr	ObjectFall
		tst.w	$1A(a0)
		bmi.s	loc_2CA36
		jsr	ObjChkFloorDist
		tst.w	d1
		bpl.s	loc_2CA36
		add.w	d1,$14(a0)
		move.w	$32(a0),$18(a0)
		move.w	$34(a0),$1A(a0)
		move.b	#1,$22(a0)
		move.b	$30(a0),d0
		add.b	d0,d0
		addq.b	#4,d0
		move.b	d0,5(a0)
		tst.b	$38(a0)
		beq.s	loc_2CA36
		btst	#4,VInt_RunCount+3.w
		beq.s	loc_2CA36
		neg.w	$18(a0)
		bchg	#0,4(a0)


; ---------------------------------------------------------------------------

loc_2CA36:
		jmp	DrawSprite

loc_2CA3C:
		jsr	ObjectFall
		move.b	#1,$22(a0)
		tst.w	$1A(a0)
		bmi.s	loc_2CA68
		move.b	#0,$22(a0)
		jsr	ObjChkFloorDist
		tst.w	d1
		bpl.s	loc_2CA68
		add.w	d1,$14(a0)
		move.w	$34(a0),$1A(a0)


; ---------------------------------------------------------------------------

loc_2CA68:
		tst.b	$2C(a0)
		bne.s	loc_2CAE4
		tst.b	4(a0)
		bpl.w	loc_2C9DA
		jmp	DrawSprite

loc_2CA7C:
		jsr	ObjectMove
		addi.w	#$18,$1A(a0)
		tst.w	$1A(a0)
		bmi.s	loc_2CABA
		jsr	ObjChkFloorDist
		tst.w	d1
		bpl.s	loc_2CABA
		add.w	d1,$14(a0)
		move.w	$34(a0),$1A(a0)
		tst.b	$2C(a0)
		beq.s	loc_2CABA
		cmpi.b	#$A,$2C(a0)
		beq.s	loc_2CABA
		neg.w	$18(a0)
		bchg	#0,4(a0)

loc_2CABA:
		subq.b	#1,$24(a0)
		bpl.s	loc_2CAD0
		move.b	#1,$24(a0)
		addq.b	#1,$22(a0)
		andi.b	#1,$22(a0)


; ---------------------------------------------------------------------------

loc_2CAD0:
		tst.b	$2C(a0)
		bne.s	loc_2CAE4
		tst.b	4(a0)
		bpl.w	loc_2C9DA
		jmp	DrawSprite

loc_2CAE4:
		move.w	$10(a0),d0
		sub.w	Object_RAM+xpos.w,d0
		blo.s	loc_2CAFC
		subi.w	#$180,d0
		bpl.s	loc_2CAFC
		tst.b	4(a0)
		bpl.w	loc_2C9DA


; ---------------------------------------------------------------------------

loc_2CAFC:
		jmp	DrawSprite

loc_2CB02:
		tst.b	4(a0)
		bpl.w	loc_2C9DA
		subq.w	#1,$36(a0)
		bne.w	loc_2CB1E
		move.b	#2,5(a0)
		move.w	#$80,8(a0)


; ---------------------------------------------------------------------------

loc_2CB1E:
		jmp	DrawSprite


; ---------------------------------------------------------------------------

loc_2CB24:
		bsr.w	sub_2CCD2
		bhs.s	loc_2CB40
		move.w	$32(a0),$18(a0)
		move.w	$34(a0),$1A(a0)
		move.b	#$E,5(a0)
		bra.w	loc_2CA7C


; ---------------------------------------------------------------------------

loc_2CB40:
		bra.w	loc_2CAE4

loc_2CB44:
		bsr.w	sub_2CCD2
		bpl.s	loc_2CB7C
		clr.w	$18(a0)
		clr.w	$32(a0)
		jsr	ObjectMove
		addi.w	#$18,$1A(a0)
		bsr.w	sub_2CC92
		bsr.w	sub_2CCBA
		subq.b	#1,$24(a0)
		bpl.s	loc_2CB7C
		move.b	#1,$24(a0)
		addq.b	#1,$22(a0)
		andi.b	#1,$22(a0)


; ---------------------------------------------------------------------------

loc_2CB7C:
		bra.w	loc_2CAE4


; ---------------------------------------------------------------------------

loc_2CB80:
		bsr.w	sub_2CCD2
		bpl.s	loc_2CBD8
		move.w	$32(a0),$18(a0)
		move.w	$34(a0),$1A(a0)
		move.b	#4,5(a0)
		bra.w	loc_2CA3C

loc_2CB9C:
		jsr	ObjectFall
		move.b	#1,$22(a0)
		tst.w	$1A(a0)
		bmi.s	loc_2CBD8
		move.b	#0,$22(a0)
		jsr	ObjChkFloorDist
		tst.w	d1
		bpl.s	loc_2CBD8
		not.b	$2D(a0)
		bne.s	loc_2CBCE
		neg.w	$18(a0)
		bchg	#0,4(a0)

loc_2CBCE:
		add.w	d1,$14(a0)
		move.w	$34(a0),$1A(a0)


; ---------------------------------------------------------------------------

loc_2CBD8:
		bra.w	loc_2CAE4

loc_2CBDC:
		bsr.w	sub_2CCD2
		bpl.s	loc_2CBF8
		clr.w	$18(a0)
		clr.w	$32(a0)
		jsr	ObjectFall
		bsr.w	sub_2CC92
		bsr.w	sub_2CCBA


; ---------------------------------------------------------------------------

loc_2CBF8:
		bra.w	loc_2CAE4

loc_2CBFC:
		bsr.w	sub_2CCD2
		bpl.s	loc_2CC38
		jsr	ObjectFall
		move.b	#1,$22(a0)
		tst.w	$1A(a0)
		bmi.s	loc_2CC38
		move.b	#0,$22(a0)
		jsr	ObjChkFloorDist
		tst.w	d1
		bpl.s	loc_2CC38
		neg.w	$18(a0)
		bchg	#0,4(a0)
		add.w	d1,$14(a0)
		move.w	$34(a0),$1A(a0)


; ---------------------------------------------------------------------------

loc_2CC38:
		bra.w	loc_2CAE4

loc_2CC3C:
		bsr.w	sub_2CCD2
		bpl.s	loc_2CC8E
		jsr	ObjectMove
		addi.w	#$18,$1A(a0)
		tst.w	$1A(a0)
		bmi.s	loc_2CC78
		jsr	ObjChkFloorDist
		tst.w	d1
		bpl.s	loc_2CC78
		not.b	$2D(a0)
		bne.s	loc_2CC6E
		neg.w	$18(a0)
		bchg	#0,4(a0)

loc_2CC6E:
		add.w	d1,$14(a0)
		move.w	$34(a0),$1A(a0)

loc_2CC78:
		subq.b	#1,$24(a0)
		bpl.s	loc_2CC8E
		move.b	#1,$24(a0)

loc_2CC84:
		addq.b	#1,$22(a0)
		andi.b	#1,$22(a0)


; ############### S U B	R O U T	I N E #######################################

loc_2CC8E:
		bra.w	loc_2CAE4

sub_2CC92:
		move.b	#1,$22(a0)
		tst.w	$1A(a0)
		bmi.s	locret_2CCB8
		move.b	#0,$22(a0)
		jsr	ObjChkFloorDist
		tst.w	d1
		bpl.s	locret_2CCB8
		add.w	d1,$14(a0)
		move.w	$34(a0),$1A(a0)


; End of function sub_2CC92
; ############### S U B	R O U T	I N E #######################################

locret_2CCB8:
		rts

sub_2CCBA:
		bset	#0,4(a0)
		move.w	$10(a0),d0
		sub.w	Object_RAM+xpos.w,d0
		bhs.s	locret_2CCD0
		bclr	#0,4(a0)


; End of function sub_2CCBA
; ############### S U B	R O U T	I N E #######################################

locret_2CCD0:
		rts


; End of function sub_2CCD2
; ---------------------------------------------------------------------------

sub_2CCD2:
		move.w	Object_RAM+xpos.w,d0
		sub.w	$10(a0),d0
		subi.w	#$B8,d0
		rts

Obj_EnemyScore:
		move.l	#Map_2CF50,$C(a0)
		move.w	#-$7A1C,$A(a0)
		move.b	#4,4(a0)
		move.w	#$80,8(a0)
		move.b	#8,7(a0)
		move.w	#-$300,$1A(a0)
		move.l	#loc_2CD0C,(a0)


; ---------------------------------------------------------------------------

loc_2CD0C:
		tst.w	$1A(a0)
		bpl.w	loc_2C9DA
		jsr	ObjectMove
		addi.w	#$18,$1A(a0)
		jmp	DrawSprite

loc_2CDEA:
		jsr	ObjectFall
		move.b	#1,$22(a0)
		tst.w	$1A(a0)
		bmi.s	loc_2CE26
		move.b	#0,$22(a0)
		move.w	$14(a0),d0
		cmp.w	$3A(a0),d0
		blo.s	loc_2CE26
		move.w	$3A(a0),$14(a0)
		jsr	RandomNumber
		andi.w	#$1FF,d0
		addi.w	#$100,d0
		neg.w	d0
		move.w	d0,$1A(a0)


; ---------------------------------------------------------------------------

loc_2CE26:
		jmp	DrawSprite


; ---------------------------------------------------------------------------

word_2CE66:
		dc.w $C0, $110
		dc.w $A8, $128
		dc.w $C0, $130
		dc.w $D8, $138


; End of function sub_2CE76
; ############### S U B	R O U T	I N E #######################################

sub_2CE76:
		moveq	#0,d0
		move.b	$2C(a0),d0
		add.w	d0,d0
		adda.w	d0,a1
		move.w	(a1)+,$10(a0)
		move.w	(a1)+,$14(a0)
		add.w	d0,d0
		move.w	d0,$2E(a0)
		move.b	#$10,7(a0)
		move.b	#$10,6(a0)
		move.w	#$200,8(a0)
		rts

sub_2CEA2:
		subq.b	#1,$24(a0)
		bpl.s	locret_2CEB8
		move.b	#2,$24(a0)
		addq.b	#1,$22(a0)
		andi.b	#1,$22(a0)


; End of function sub_2CEA2
; ---------------------------------------------------------------------------

locret_2CEB8:
		rts

Map_2CEBA:
		dc.w word_2CEC8-Map_2CEBA
		dc.w word_2CED0-Map_2CEBA
		dc.w word_2CEC0-Map_2CEBA

word_2CEC0:
		dc.w 1
		dc.b  $F4,   6,	  0,   0, $FF, $F8

word_2CEC8:
		dc.w 1
		dc.b  $F8,   5,	  0,   6, $FF, $F8

word_2CED0:
		dc.w 1
		dc.b  $F8,   5,	  0,  $A, $FF, $F8

Map_2CED8:
		dc.w word_2CEE6-Map_2CED8
		dc.w word_2CEEE-Map_2CED8
		dc.w word_2CEDE-Map_2CED8

word_2CEDE:
		dc.w 1
		dc.b  $F4,   6,	  0,   0, $FF, $F8

word_2CEE6:
		dc.w 1
		dc.b  $F8,   9,	  0,   6, $FF, $F4

word_2CEEE:
		dc.w 1
		dc.b  $F8,   9,	  0,  $C, $FF, $F4

Map_2CEF6:
		dc.w word_2CF04-Map_2CEF6
		dc.w word_2CF0C-Map_2CEF6
		dc.w word_2CEFC-Map_2CEF6

word_2CEFC:
		dc.w 1
		dc.b  $F4,   6,	  0,   0, $FF, $F8

word_2CF04:
		dc.w 1
		dc.b  $F8,   9,	  0,   6, $FF, $F4

word_2CF0C:
		dc.w 1
		dc.b  $F8,   9,	  0,  $C, $FF, $F4

Map_2CF14:
		dc.w word_2CF22-Map_2CF14
		dc.w word_2CF2A-Map_2CF14
		dc.w word_2CF1A-Map_2CF14

word_2CF1A:
		dc.w 1
		dc.b  $F8,   6,	  0,   0, $FF, $F8

word_2CF22:
		dc.w 1
		dc.b  $FC,   5,	  0,   6, $FF, $F8

word_2CF2A:
		dc.w 1
		dc.b  $FC,   5,	  0,  $A, $FF, $F8

Map_2CF32:
		dc.w word_2CF40-Map_2CF32
		dc.w word_2CF48-Map_2CF32
		dc.w word_2CF38-Map_2CF32

word_2CF38:
		dc.w 1
		dc.b  $F4,   6,	  0,   0, $FF, $F8

word_2CF40:
		dc.w 1
		dc.b  $F4,   6,	  0,   6, $FF, $F8

word_2CF48:
		dc.w 1
		dc.b  $F4,   6,	  0,  $C, $FF, $F8

Map_2CF50:
		dc.w word_2CF5E-Map_2CF50
		dc.w word_2CF66-Map_2CF50
		dc.w word_2CF6E-Map_2CF50
		dc.w word_2CF76-Map_2CF50
		dc.w word_2CF84-Map_2CF50
		dc.w word_2CF8C-Map_2CF50
		dc.w word_2CF9A-Map_2CF50

word_2CF5E:
		dc.w 1
		dc.b  $FC,   4,	  0,   0, $FF, $FA

word_2CF66:
		dc.w 1
		dc.b  $FC,   4,	  0,   2, $FF, $F8

word_2CF6E:
		dc.w 1
		dc.b  $FC,   4,	  0,   4, $FF, $F8

word_2CF76:
		dc.w 2
		dc.b  $FC,   0,	  0,   0, $FF, $F8
		dc.b  $FC,   4,	  0,   6,   0,	 0

word_2CF84:
		dc.w 1
		dc.b  $FC,   0,	  0,   0, $FF, $FC

word_2CF8C:
		dc.w 2
		dc.b  $FC,   4,	  0,   0, $FF, $F8
		dc.b  $FC,   4,	  0,   6,   0,	 5


; ---------------------------------------------------------------------------

word_2CF9A:
		dc.w 2
		dc.b  $FC,   4,	  0,   4, $FF, $F8
		dc.b  $FC,   4,	  0,   6,   0,	 7


; ---------------------------------------------------------------------------
