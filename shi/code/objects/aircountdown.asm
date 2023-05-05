Obj_Air_CountDown:
		moveq	#0,d0
		move.b	5(a0),d0
		move.w	off_18172(pc,d0.w),d1
		jmp	off_18172(pc,d1.w)


; ---------------------------------------------------------------------------

off_18172:
		dc.w loc_18184-off_18172
		dc.w loc_181DC-off_18172
		dc.w loc_181E8-off_18172
		dc.w loc_18254-off_18172
		dc.w loc_1826C-off_18172
		dc.w Player_TestAirTimer-off_18172
		dc.w loc_18272-off_18172
		dc.w loc_182B2-off_18172
		dc.w loc_1826C-off_18172

loc_18184:
		addq.b	#2,5(a0)
		move.l	#Map_Bubbler,$C(a0)
		tst.b	$43(a0)
		beq.s	loc_1819E
		move.l	#Map_Bubbler2,$C(a0)


; ---------------------------------------------------------------------------

loc_1819E:
		move.w	#$45C,$A(a0)
		move.b	#-$7C,4(a0)
		move.b	#$10,7(a0)
		move.w	#$80,8(a0)
		move.b	$2C(a0),d0
		bpl.s	loc_181CC
		addq.b	#8,5(a0)
		andi.w	#$7F,d0
		move.b	d0,$37(a0)
		bra.w	Player_TestAirTimer

loc_181CC:
		move.b	d0,$20(a0)
		move.w	$10(a0),$34(a0)
		move.w	#-$100,$1A(a0)

loc_181DC:
		lea	Ani_Shields,a1
		jsr	AnimateSprite


; ---------------------------------------------------------------------------

loc_181E8:
		move.w	Water_Height_Default.w,d0
		cmp.w	$14(a0),d0
		blo.s	loc_1820E
		move.b	#6,5(a0)
		addq.b	#7,$20(a0)
		cmpi.b	#$D,$20(a0)
		beq.s	loc_18254
		blo.s	loc_18254
		move.b	#$D,$20(a0)
		bra.s	loc_18254

loc_1820E:
		tst.w	Player1_OnWater_Flag.w
		beq.s	loc_18218
		addq.w	#4,$34(a0)


; ---------------------------------------------------------------------------

loc_18218:
		move.b	$26(a0),d0
		addq.b	#1,$26(a0)
		andi.w	#$7F,d0
		lea	byte_1831E,a1
		move.b	(a1,d0.w),d0
		ext.w	d0
		add.w	$34(a0),d0
		move.w	d0,$10(a0)
		bsr.w	sub_182D2
		jsr	ObjectMove
		tst.b	4(a0)
		bpl.s	loc_1824E
		jmp	DrawSprite


; ---------------------------------------------------------------------------

loc_1824E:
		jmp	DeleteObject_This


; ---------------------------------------------------------------------------

loc_18254:
		bsr.s	sub_182D2
		lea	Ani_Shields,a1
		jsr	AnimateSprite
		bsr.w	AirCountdown_Load_Art
		jmp	DrawSprite


; ---------------------------------------------------------------------------

loc_1826C:
		jmp	DeleteObject_This


; ---------------------------------------------------------------------------

loc_18272:
		movea.l	$40(a0),a2
		cmpi.b	#$C,$2C(a2)
		bhi.s	loc_182AC
		subq.w	#1,$3C(a0)
		bne.s	loc_18290
		move.b	#$E,5(a0)
		addq.b	#7,$20(a0)
		bra.s	loc_18254


; ---------------------------------------------------------------------------

loc_18290:
		lea	Ani_Shields,a1
		jsr	AnimateSprite
		bsr.w	AirCountdown_Load_Art
		tst.b	4(a0)
		bpl.s	loc_182AC
		jmp	DrawSprite


; ---------------------------------------------------------------------------

loc_182AC:
		jmp	DeleteObject_This


; ############### S U B	R O U T	I N E #######################################

loc_182B2:
		movea.l	$40(a0),a2
		cmpi.b	#$C,$2C(a2)
		bhi.s	loc_1826C
		bsr.s	sub_182D2
		lea	Ani_Shields,a1
		jsr	AnimateSprite
		jmp	DrawSprite

sub_182D2:
		tst.w	$3C(a0)
		beq.s	locret_1831C
		subq.w	#1,$3C(a0)
		bne.s	locret_1831C
		cmpi.b	#7,$20(a0)
		bhs.s	locret_1831C
		move.w	#$F,$3C(a0)
		clr.w	$1A(a0)
		move.b	#-$80,4(a0)
		move.w	$10(a0),d0
		sub.w	Camera_X.w,d0
		addi.w	#$80,d0
		move.w	d0,$10(a0)
		move.w	$14(a0),d0
		sub.w	Camera_Y.w,d0
		addi.w	#$80,d0
		move.w	d0,$14(a0)
		move.b	#$C,5(a0)


; End of function sub_182D2
; ---------------------------------------------------------------------------

locret_1831C:
		rts


; ############### S U B	R O U T	I N E #######################################

byte_1831E:
		incbin 'levels/common/byte_1831E.bin'

AirCountdown_Load_Art:
		moveq	#0,d1
		move.b	$22(a0),d1
		cmpi.b	#9,d1
		blo.s	locret_18464
		cmpi.b	#$13,d1
		bhs.s	locret_18464
		cmp.b	$32(a0),d1
		beq.s	locret_18464
		move.b	d1,$32(a0)
		subi.w	#9,d1
		move.w	d1,d0
		add.w	d1,d1
		add.w	d0,d1
		lsl.w	#6,d1
		addi.l	#ArtUnc_AirCountDown,d1
		move.w	#-$400,d2
		tst.b	$43(a0)
		beq.s	loc_1845A
		move.w	#-$200,d2

loc_1845A:
		move.w	#$60,d3
		jsr	AddQueueDMA


; End of function AirCountdown_Load_Art
; ---------------------------------------------------------------------------

locret_18464:
		rts

Player_TestAirTimer:
		movea.l	$40(a0),a2
		tst.w	$30(a0)
		bne.w	loc_1857C
		cmpi.b	#6,5(a2)
		bhs.w	locret_18680
		btst	#6,$2B(a2)
		bne.w	locret_18680
		tst.b	Super_Flag.w
		bmi.w	locret_18680
		btst	#6,$2A(a2)
		beq.w	locret_18680
		subq.w	#1,$3C(a0)
		bpl.w	loc_18594
		move.w	#$3B,$3C(a0)
		move.w	#1,$3A(a0)
		jsr	RandomNumber
		andi.w	#1,d0
		move.b	d0,$38(a0)
		moveq	#0,d0
		move.b	$2C(a2),d0
		cmpi.w	#$19,d0
		beq.s	loc_184FC
		cmpi.w	#$14,d0
		beq.s	loc_184FC
		cmpi.w	#$F,d0
		beq.s	loc_184FC
		cmpi.w	#$C,d0
		bhi.s	loc_1850A
		bne.s	loc_184E8
		tst.b	$43(a0)
		bne.s	loc_184E8
		moveq	#$31,d0
		jsr	PlayMusic


; ---------------------------------------------------------------------------

loc_184E8:
		subq.b	#1,$36(a0)
		bpl.s	loc_1850A
		move.b	$37(a0),$36(a0)
		bset	#7,$3A(a0)
		bra.s	loc_1850A

loc_184FC:
		tst.b	$43(a0)
		bne.s	loc_1850A
		moveq	#-$57,d0
		jsr	PlaySFX

loc_1850A:
		subq.b	#1,$2C(a2)
		bhs.w	loc_18592
		move.b	#-$7F,$2E(a2)
		move.w	#$3B,d0
		jsr	PlaySFX
		move.b	#$A,$38(a0)
		move.w	#1,$3A(a0)
		move.w	#$78,$30(a0)
		movea.l	a2,a1
		bsr.w	Player_ResetAirTimer
		move.l	a0,-(sp)
		movea.l	a2,a0
		bsr.w	Player_ResetOnFloor
		move.b	#$17,$20(a0)
		bset	#1,$2A(a0)
		bset	#7,$A(a0)
		move.w	#0,$1A(a0)
		move.w	#0,$18(a0)
		move.w	#0,$1C(a0)
		move.b	#$C,5(a0)
		movea.l	(sp)+,a0
		cmpa.w	#$B000,a2
		bne.s	locret_1857A
		move.b	#1,Deform_Lock.w


; ---------------------------------------------------------------------------

locret_1857A:
		rts


; ---------------------------------------------------------------------------

loc_1857C:
		move.b	#$17,$20(a2)
		subq.w	#1,$30(a0)
		bne.s	loc_18590
		move.b	#6,5(a2)
		rts


; ---------------------------------------------------------------------------

loc_18590:
		bra.s	loc_18594


; ---------------------------------------------------------------------------

loc_18592:
		bra.s	loc_185A4

loc_18594:
		tst.w	$3A(a0)
		beq.w	locret_18680
		subq.w	#1,$3E(a0)
		bpl.w	locret_18680

loc_185A4:
		jsr	RandomNumber
		andi.w	#$F,d0
		addq.w	#8,d0
		move.w	d0,$3E(a0)
		jsr	CreateObject
		bne.w	locret_18680
		move.l	(a0),(a1)
		move.w	$10(a2),$10(a1)
		moveq	#6,d0
		btst	#0,$2A(a2)
		beq.s	loc_185D8
		neg.w	d0
		move.b	#$40,$26(a1)


; ---------------------------------------------------------------------------

loc_185D8:
		add.w	d0,$10(a1)
		move.w	$14(a2),$14(a1)
		move.l	$40(a0),$40(a1)
		move.b	#6,$2C(a1)
		tst.w	$30(a0)
		beq.w	loc_1862A
		andi.w	#7,$3E(a0)
		addi.w	#0,$3E(a0)
		move.w	$14(a2),d0
		subi.w	#$C,d0
		move.w	d0,$14(a1)
		jsr	RandomNumber
		move.b	d0,$26(a1)
		move.w	Level_Frame_Timer.w,d0
		andi.b	#3,d0
		bne.s	loc_18676
		move.b	#$E,$2C(a1)
		bra.s	loc_18676

loc_1862A:
		btst	#7,$3A(a0)
		beq.s	loc_18676
		moveq	#0,d2
		move.b	$2C(a2),d2
		cmpi.b	#$C,d2
		bhs.s	loc_18676
		lsr.w	#1,d2
		jsr	RandomNumber
		andi.w	#3,d0
		bne.s	loc_1865E
		bset	#6,$3A(a0)
		bne.s	loc_18676
		move.b	d2,$2C(a1)
		move.w	#$1C,$3C(a1)

loc_1865E:
		tst.b	$38(a0)
		bne.s	loc_18676
		bset	#6,$3A(a0)
		bne.s	loc_18676
		move.b	d2,$2C(a1)
		move.w	#$1C,$3C(a1)

loc_18676:
		subq.b	#1,$38(a0)
		bpl.s	locret_18680
		clr.w	$3A(a0)


; ############### S U B	R O U T	I N E #######################################

locret_18680:
		rts

Player_ResetAirTimer:
		cmpi.b	#$C,$2C(a1)
		bhi.s	loc_186BC
		cmpa.w	#$B000,a1
		bne.s	loc_186BC
		move.b	Current_Mus.w,d0
		btst	#1,$2B(a1)
		beq.s	loc_186A0
		move.w	#$2C,d0

loc_186A0:
		tst.b	Super_Flag.w
		beq.w	loc_186AC
		move.w	#$2C,d0

loc_186AC:
		tst.b	Boss_Active_Flag.w
		beq.s	loc_186B6
		move.w	#$18,d0

loc_186B6:
		jsr	PlayMusic


; End of function Player_ResetAirTimer
; ---------------------------------------------------------------------------

loc_186BC:
		move.b	#$1E,$2C(a1)
		rts

Ani_Shields:
		dc.w byte_186E2-Ani_Shields
		dc.w byte_186EB-Ani_Shields
		dc.w byte_186F4-Ani_Shields
		dc.w byte_186FD-Ani_Shields
		dc.w byte_18706-Ani_Shields
		dc.w byte_1870F-Ani_Shields
		dc.w byte_18718-Ani_Shields
		dc.w byte_1871D-Ani_Shields
		dc.w byte_18725-Ani_Shields
		dc.w byte_1872D-Ani_Shields
		dc.w byte_18735-Ani_Shields
		dc.w byte_1873D-Ani_Shields
		dc.w byte_18745-Ani_Shields
		dc.w byte_1874D-Ani_Shields
		dc.w byte_1874F-Ani_Shields

byte_186E2:
		dc.b	5,   0,	  1,   2,   3,	 4,   9,  $D, $FC

byte_186EB:
		dc.b	5,   0,	  1,   2,   3,	 4,  $C, $12, $FC

byte_186F4:
		dc.b	5,   0,	  1,   2,   3,	 4,  $C, $11, $FC

byte_186FD:
		dc.b	5,   0,	  1,   2,   3,	 4,  $B, $10, $FC

byte_18706:
		dc.b	5,   0,	  1,   2,   3,	 4,  $C,  $F, $FC

byte_1870F:
		dc.b	5,   0,	  1,   2,   3,	 4,  $A,  $E, $FC

byte_18718:
		dc.b   $E,   0,	  1,   2, $FC

byte_1871D:
		dc.b	7, $16,	 $D, $16,  $D, $16,  $D, $FC

byte_18725:
		dc.b	7, $16,	$12, $16, $12, $16, $12, $FC

byte_1872D:
		dc.b	7, $16,	$11, $16, $11, $16, $11, $FC

byte_18735:
		dc.b	7, $16,	$10, $16, $10, $16, $10, $FC

byte_1873D:
		dc.b	7, $16,	 $F, $16,  $F, $16,  $F, $FC

byte_18745:
		dc.b	7, $16,	 $E, $16,  $E, $16,  $E, $FC

byte_1874D:
		dc.b   $E, $FC


; ---------------------------------------------------------------------------

byte_1874F:
		dc.b   $E,   1,	  2,   3,   4, $FC,   0

