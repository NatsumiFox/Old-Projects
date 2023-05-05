Obj_Bubbler:
		moveq	#0,d0
		move.b	5(a0),d0
		move.w	off_2F946(pc,d0.w),d1
		jmp	off_2F946(pc,d1.w)


; ---------------------------------------------------------------------------

off_2F946:
		dc.w loc_2F952-off_2F946
		dc.w loc_2F9B0-off_2F946
		dc.w loc_2F9CA-off_2F946
		dc.w loc_2FA2C-off_2F946
		dc.w loc_2FA4A-off_2F946
		dc.w loc_2FA50-off_2F946


; ---------------------------------------------------------------------------

loc_2F952:
		addq.b	#2,5(a0)
		move.l	#Map_Bubbler,$C(a0)
		move.w	#$45C,$A(a0)
		move.b	#-$7C,4(a0)
		move.b	#$10,7(a0)
		move.w	#$80,8(a0)
		move.b	$2C(a0),d0
		bpl.s	loc_2F996
		addq.b	#8,5(a0)
		andi.w	#$7F,d0
		move.b	d0,$32(a0)
		move.b	d0,$33(a0)
		move.b	#8,$20(a0)
		bra.w	loc_2FA50

loc_2F996:
		move.b	d0,$20(a0)
		move.w	$10(a0),$30(a0)
		move.w	#-$88,$1A(a0)
		jsr	RandomNumber
		move.b	d0,$26(a0)

loc_2F9B0:
		lea	Ani_Bubbler,a1
		jsr	AnimateSprite
		cmpi.b	#6,$22(a0)
		bne.s	loc_2F9CA
		move.b	#1,$2E(a0)


; ---------------------------------------------------------------------------

loc_2F9CA:
		move.w	Water_Height_Default.w,d0
		cmp.w	$14(a0),d0
		blo.s	loc_2F9E2
		move.b	#6,5(a0)
		addq.b	#4,$20(a0)
		bra.w	loc_2FA2C

loc_2F9E2:
		move.b	$26(a0),d0
		addq.b	#1,$26(a0)
		andi.w	#$7F,d0
		lea	byte_1831E,a1
		move.b	(a1,d0.w),d0
		ext.w	d0
		add.w	$30(a0),d0
		move.w	d0,$10(a0)
		tst.b	$2E(a0)
		beq.s	loc_2FA14
		bsr.w	sub_2FBA8
		cmpi.b	#6,5(a0)
		beq.s	loc_2FA2C


; ---------------------------------------------------------------------------

loc_2FA14:
		jsr	ObjectMove
		tst.b	4(a0)
		bpl.s	loc_2FA26
		jmp	DrawSprite


; ---------------------------------------------------------------------------

loc_2FA26:
		jmp	DeleteObject_This


; ---------------------------------------------------------------------------

loc_2FA2C:
		lea	Ani_Bubbler,a1
		jsr	AnimateSprite
		tst.b	4(a0)
		bpl.s	loc_2FA44
		jmp	DrawSprite


; ---------------------------------------------------------------------------

loc_2FA44:
		jmp	DeleteObject_This


; ---------------------------------------------------------------------------

loc_2FA4A:
		jmp	DeleteObject_This

loc_2FA50:
		tst.w	$36(a0)
		bne.s	loc_2FAB2
		move.w	Water_Height_Default.w,d0
		cmp.w	$14(a0),d0
		bhs.w	loc_2FB5C
		tst.b	4(a0)
		bpl.w	loc_2FB5C
		subq.w	#1,$38(a0)
		bpl.w	loc_2FB50
		move.w	#1,$36(a0)

loc_2FA78:
		jsr	RandomNumber
		move.w	d0,d1
		andi.w	#7,d0
		cmpi.w	#6,d0
		bhs.s	loc_2FA78
		move.b	d0,$34(a0)
		andi.w	#$C,d1
		lea	byte_2FB96,a1
		adda.w	d1,a1
		move.l	a1,$3C(a0)
		subq.b	#1,$32(a0)
		bpl.s	loc_2FAB0
		move.b	$33(a0),$32(a0)
		bset	#7,$36(a0)


; ---------------------------------------------------------------------------

loc_2FAB0:
		bra.s	loc_2FABA

loc_2FAB2:
		subq.w	#1,$38(a0)
		bpl.w	loc_2FB50

loc_2FABA:
		jsr	RandomNumber
		andi.w	#$1F,d0
		move.w	d0,$38(a0)
		jsr	CreateObject
		bne.s	loc_2FB34
		move.l	(a0),(a1)
		move.w	$10(a0),$10(a1)
		jsr	RandomNumber
		andi.w	#$F,d0
		subq.w	#8,d0
		add.w	d0,$10(a1)
		move.w	$14(a0),$14(a1)
		moveq	#0,d0
		move.b	$34(a0),d0
		movea.l	$3C(a0),a2
		move.b	(a2,d0.w),$2C(a1)
		btst	#7,$36(a0)

loc_2FB04:
		beq.s	loc_2FB34
		jsr	RandomNumber
		andi.w	#3,d0
		bne.s	loc_2FB20
		bset	#6,$36(a0)
		bne.s	loc_2FB34
		move.b	#2,$2C(a1)

loc_2FB20:
		tst.b	$34(a0)
		bne.s	loc_2FB34
		bset	#6,$36(a0)
		bne.s	loc_2FB34
		move.b	#2,$2C(a1)

loc_2FB34:
		subq.b	#1,$34(a0)
		bpl.s	loc_2FB50
		jsr	RandomNumber
		andi.w	#$7F,d0
		addi.w	#$80,d0
		add.w	d0,$38(a0)
		clr.w	$36(a0)

loc_2FB50:
		lea	Ani_Bubbler,a1
		jsr	AnimateSprite


; ---------------------------------------------------------------------------

loc_2FB5C:
		move.w	$10(a0),d0
		andi.w	#-$80,d0
		sub.w	Camera_X_Rough.w,d0
		cmpi.w	#$280,d0
		bhi.w	loc_2FB7E
		move.w	Water_Height_Default.w,d0
		cmp.w	$14(a0),d0
		blo.w	loc_2FB90
		rts

loc_2FB7E:
		move.w	$48(a0),d0
		beq.s	loc_2FB8A
		movea.w	d0,a2
		bclr	#7,(a2)


; ---------------------------------------------------------------------------

loc_2FB8A:
		jmp	DeleteObject_This


; ---------------------------------------------------------------------------

loc_2FB90:
		jmp	DrawSprite


; ############### S U B	R O U T	I N E #######################################

byte_2FB96:
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b 1
		dc.b 0
		dc.b 0
		dc.b 1
		dc.b 0


; End of function sub_2FBA8

sub_2FBA8:
		lea	Object_RAM.w,a1
		bsr.s	loc_2FBB2
		lea	Obj_player_2.w,a1

loc_2FBB2:
		tst.b	$2E(a1)
		bmi.w	locret_2FC7C
		move.w	$10(a1),d0
		move.w	$10(a0),d1
		subi.w	#$10,d1
		cmp.w	d0,d1
		bhs.w	locret_2FC7C
		addi.w	#$20,d1
		cmp.w	d0,d1
		blo.w	locret_2FC7C
		move.w	$14(a1),d0
		move.w	$14(a0),d1
		cmp.w	d0,d1
		bhs.w	locret_2FC7C
		addi.w	#$10,d1
		cmp.w	d0,d1
		blo.w	locret_2FC7C
		btst	#6,$2B(a1)
		bne.w	locret_2FC7C
		jsr	Player_ResetAirTimer
		moveq	#$38,d0
		jsr	PlaySFX

loc_2FC06:
		clr.w	$18(a1)


; ---------------------------------------------------------------------------

loc_2FC0A:
		clr.w	$1A(a1)
		clr.w	$1C(a1)
		move.b	#$15,$20(a1)
		move.w	#$23,$32(a1)
		move.b	#0,$40(a1)
		bclr	#5,$2A(a1)
		bclr	#4,$2A(a1)
		btst	#2,$2A(a1)
		beq.w	loc_2FC6A
		cmpi.l	#Obj_Sonic,(a1)
		bne.s	loc_2FC5A
		bclr	#2,$2A(a1)
		move.b	#$13,$1E(a1)
		move.b	#9,$1F(a1)
		subq.w	#5,$14(a1)
		bra.s	loc_2FC6A

loc_2FC5A:
		move.b	#$F,$1E(a1)
		move.b	#9,$1F(a1)
		subq.w	#1,$14(a1)

loc_2FC6A:
		cmpi.b	#6,5(a0)
		beq.s	locret_2FC7C
		move.b	#6,5(a0)
		addq.b	#4,$20(a0)


; ---------------------------------------------------------------------------

locret_2FC7C:
		rts

Ani_Bubbler:
		dc.w byte_2FC90-Ani_Bubbler
		dc.w byte_2FC95-Ani_Bubbler
		dc.w byte_2FC9B-Ani_Bubbler
		dc.w byte_2FCA2-Ani_Bubbler
		dc.w byte_2FCA6-Ani_Bubbler
		dc.w byte_2FCA6-Ani_Bubbler
		dc.w byte_2FCA8-Ani_Bubbler
		dc.w byte_2FCA8-Ani_Bubbler
		dc.w byte_2FCAC-Ani_Bubbler

byte_2FC90:
		dc.b   $E,   0,	  1,   2, $FC

byte_2FC95:
		dc.b   $E,   1,	  2,   3,   4, $FC

byte_2FC9B:
		dc.b   $E,   2,	  3,   4,   5,	 6, $FC

byte_2FCA2:
		dc.b	2,   5,	  6, $FC

byte_2FCA6:
		dc.b	4, $FC

byte_2FCA8:
		dc.b	4,   7,	  8, $FC

byte_2FCAC:
		dc.b   $F, $13,	$14, $15, $FF,	 0

Map_Bubbler:
		dc.w word_2FD0E-Map_Bubbler
		dc.w word_2FD16-Map_Bubbler
		dc.w word_2FD1E-Map_Bubbler
		dc.w word_2FD26-Map_Bubbler
		dc.w word_2FD2E-Map_Bubbler
		dc.w word_2FD36-Map_Bubbler
		dc.w word_2FD3E-Map_Bubbler
		dc.w word_2FD46-Map_Bubbler
		dc.w word_2FD60-Map_Bubbler
		dc.w word_2FD7A-Map_Bubbler
		dc.w word_2FD7A-Map_Bubbler
		dc.w word_2FD7A-Map_Bubbler
		dc.w word_2FD7A-Map_Bubbler
		dc.w word_2FD7A-Map_Bubbler
		dc.w word_2FD7A-Map_Bubbler
		dc.w word_2FD7A-Map_Bubbler
		dc.w word_2FD7A-Map_Bubbler
		dc.w word_2FD7A-Map_Bubbler
		dc.w word_2FD7A-Map_Bubbler
		dc.w word_2FD82-Map_Bubbler
		dc.w word_2FD8A-Map_Bubbler
		dc.w word_2FD92-Map_Bubbler
		dc.w word_2FD9A-Map_Bubbler

Map_Bubbler2:
		dc.w word_2FD0E-Map_Bubbler2
		dc.w word_2FD16-Map_Bubbler2
		dc.w word_2FD1E-Map_Bubbler2
		dc.w word_2FD26-Map_Bubbler2
		dc.w word_2FD2E-Map_Bubbler2
		dc.w word_2FD36-Map_Bubbler2
		dc.w word_2FD3E-Map_Bubbler2
		dc.w word_2FD46-Map_Bubbler2
		dc.w word_2FD60-Map_Bubbler2
		dc.w word_2FD9C-Map_Bubbler2
		dc.w word_2FD9C-Map_Bubbler2
		dc.w word_2FD9C-Map_Bubbler2
		dc.w word_2FD9C-Map_Bubbler2
		dc.w word_2FD9C-Map_Bubbler2
		dc.w word_2FD9C-Map_Bubbler2
		dc.w word_2FD9C-Map_Bubbler2
		dc.w word_2FD9C-Map_Bubbler2
		dc.w word_2FD9C-Map_Bubbler2
		dc.w word_2FD9C-Map_Bubbler2
		dc.w word_2FD82-Map_Bubbler2
		dc.w word_2FD8A-Map_Bubbler2
		dc.w word_2FD92-Map_Bubbler2
		dc.w word_2FD9A-Map_Bubbler2

word_2FD0E:
		dc.w 1
		dc.b  $FC,   0,	  0,   0, $FF, $FC

word_2FD16:
		dc.w 1
		dc.b  $FC,   0,	  0,   1, $FF, $FC

word_2FD1E:
		dc.w 1
		dc.b  $FC,   0,	  0,   2, $FF, $FC

word_2FD26:
		dc.w 1
		dc.b  $F8,   5,	  0,   3, $FF, $F8

word_2FD2E:
		dc.w 1
		dc.b  $F8,   5,	  0,   7, $FF, $F8

word_2FD36:
		dc.w 1
		dc.b  $F4,  $A,	  0,  $B, $FF, $F4

word_2FD3E:
		dc.w 1
		dc.b  $F0,  $F,	  0, $14, $FF, $F0

word_2FD46:
		dc.w 4
		dc.b  $F0,   5,	  0, $24, $FF, $F0
		dc.b  $F0,   5,	  8, $24,   0,	 0
		dc.b	0,   5,	$10, $24, $FF, $F0
		dc.b	0,   5,	$18, $24,   0,	 0

word_2FD60:
		dc.w 4
		dc.b  $F0,   5,	  0, $28, $FF, $F0
		dc.b  $F0,   5,	  8, $28,   0,	 0
		dc.b	0,   5,	$10, $28, $FF, $F0
		dc.b	0,   5,	$18, $28,   0,	 0

word_2FD7A:
		dc.w 1
		dc.b  $F4,   6,	  3, $84, $FF, $F8

word_2FD82:
		dc.w 1
		dc.b  $F8,   5,	  0, $2C, $FF, $F8

word_2FD8A:
		dc.w 1
		dc.b  $F8,   5,	  0, $30, $FF, $F8

word_2FD92:
		dc.w 1
		dc.b  $F8,   5,	  0, $34, $FF, $F8

word_2FD9A:
		dc.w 0


; ---------------------------------------------------------------------------

word_2FD9C:
		dc.w 1
		dc.b  $F4,   6,	  3, $94, $FF, $F8
