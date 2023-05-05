Obj_DashDust:
		moveq	#0,d0
		move.b	5(a0),d0
		move.w	off_18B4C(pc,d0.w),d1
		jmp	off_18B4C(pc,d1.w)


; ---------------------------------------------------------------------------

off_18B4C:
		dc.w loc_18B54-off_18B4C
		dc.w DashDust_Main-off_18B4C
		dc.w loc_18CB2-off_18B4C
		dc.w loc_18CB6-off_18B4C

loc_18B54:
		addq.b	#2,5(a0)
		move.l	#Map_DashDust,$C(a0)
		ori.b	#4,4(a0)
		move.w	#$80,8(a0)
		move.b	#$10,7(a0)
		move.w	#$7E0,$A(a0)
		move.w	#Object_RAM&$FFFF,$42(a0)
		move.w	#$FC00,$40(a0)
		cmpa.w	#Obj_dust&$FFFF,a0
		beq.s	DashDust_Main
		move.b	#1,$38(a0)
		cmpi.w	#2,Player_Mode.w
		beq.s	DashDust_Main
		move.w	#$7F0,$A(a0)
		move.w	#Obj_player_2&$FFFF,$42(a0)
		move.w	#$FE00,$40(a0)


; ---------------------------------------------------------------------------

DashDust_Main:
		movea.w	$42(a0),a2
		moveq	#0,d0
		move.b	$20(a0),d0
		add.w	d0,d0
		move.w	off_18BBE(pc,d0.w),d1
		jmp	off_18BBE(pc,d1.w)


; ---------------------------------------------------------------------------

off_18BBE:
		dc.w loc_18C94-off_18BBE
		dc.w DashDust_Splash-off_18BBE
		dc.w loc_18C20-off_18BBE
		dc.w loc_18C84-off_18BBE
		dc.w loc_18BEC-off_18BBE


; ---------------------------------------------------------------------------

DashDust_Splash:
		move.w	Water_Height_Default.w,$14(a0)
		tst.b	$21(a0)
		bne.w	loc_18C94
		move.w	$10(a2),$10(a0)
		move.b	#0,$2A(a0)
		andi.w	#$7FFF,$A(a0)
		bra.w	loc_18C94

loc_18BEC:
		tst.b	$21(a0)
		bne.s	loc_18C04
		move.w	$10(a2),$10(a0)
		move.b	#0,$2A(a0)
		andi.w	#$7FFF,$A(a0)

loc_18C04:
		lea	Ani_DashSplashDrown,a1
		jsr	AnimateSprite
		move.l	#ArtUnc_SplashDrown,d6
		bsr.w	SplashDrown_Load_DPLC
		jmp	DrawSprite
; ---------------------------------------------------------------------------

loc_18C20:
		cmpi.b	#$C,$2C(a2)
		blo.w	loc_18CAA
		cmpi.b	#4,5(a2)
		bhs.s	loc_18CAA
		tst.b	$3D(a2)
		beq.s	loc_18CAA
		move.w	$10(a2),$10(a0)
		move.w	$14(a2),$14(a0)
		move.b	$2A(a2),$2A(a0)
		andi.b	#1,$2A(a0)
		moveq	#4,d1
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_18C60
		ori.b	#2,$2A(a0)
		neg.w	d1

loc_18C60:
		tst.b	$38(a0)
		beq.s	loc_18C6A
		sub.w	d1,$14(a0)


; ---------------------------------------------------------------------------

loc_18C6A:
		tst.b	$21(a0)
		bne.s	loc_18C94
		andi.w	#$7FFF,$A(a0)
		tst.w	$A(a2)
		bpl.s	loc_18C94
		ori.w	#$8000,$A(a0)
		bra.s	loc_18C94

loc_18C84:
		cmpi.b	#$C,$2C(a2)
		blo.s	loc_18CAA
		btst	#6,$2A(a0)
		bne.s	loc_18CAA


; ---------------------------------------------------------------------------

loc_18C94:
		lea	Ani_DashSplashDrown,a1
		jsr	AnimateSprite
		bsr.w	DashDust_Load_DPLC
		jmp	DrawSprite


; ---------------------------------------------------------------------------

loc_18CAA:
		move.b	#0,$20(a0)
		rts

loc_18CB2:
		jmp	DeleteObject_This.w
; ---------------------------------------------------------------------------

loc_18CB6:
		movea.w	$42(a0),a2
		moveq	#$10,d1
		cmpi.b	#$D,$20(a2)
		beq.s	loc_18CE4
		cmpi.b	#2,$38(a2)
		bne.s	loc_18CD6
		moveq	#6,d1
		cmpi.b	#3,$2F(a2)
		beq.s	loc_18CE4

loc_18CD6:
		move.b	#2,5(a0)
		move.b	#0,$36(a0)
		rts
; ---------------------------------------------------------------------------

loc_18CE4:
		subq.b	#1,$36(a0)
		bpl.s	DashDust_Load_DPLC
		move.b	#3,$36(a0)
		btst	#6,$2A(a2)
		bne.s	DashDust_Load_DPLC
		jsr	CreateObject.w
		bne.s	DashDust_Load_DPLC
		move.l	(a0),(a1)
		move.w	$10(a2),$10(a1)
		move.w	$14(a2),$14(a1)
		tst.b	$38(a0)
		beq.s	loc_18D14
		subq.w	#4,d1

loc_18D14:
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_18D1C
		neg.w	d1

loc_18D1C:
		add.w	d1,$14(a1)
		move.b	#0,$2A(a1)
		move.b	#3,$20(a1)
		addq.b	#2,5(a1)
		move.l	$C(a0),$C(a1)
		move.b	4(a0),4(a1)
		move.w	#$80,8(a1)
		move.b	#4,7(a1)
		move.w	$A(a0),$A(a1)
		move.w	$42(a0),$42(a1)
		andi.w	#$7FFF,$A(a1)
		tst.w	$A(a2)
		bpl.s	DashDust_Load_DPLC
		ori.w	#$8000,$A(a1)

DashDust_Load_DPLC:
		move.l	#ArtUnc_DashDust,d6
; ---------------------------------------------------------------------------

SplashDrown_Load_DPLC:
		moveq	#0,d0
		move.b	$22(a0),d0
		cmp.b	$34(a0),d0
		beq.s	locret_18DBE
		move.b	d0,$34(a0)
		lea	DPLC_DashSplashDrown,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_18DBE
		move.w	$40(a0),d4

loc_18D96:
		moveq	#0,d1
		move.w	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		add.l	d6,d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	AddQueueDMA
		dbf	d5,loc_18D96

locret_18DBE:
		rts
; ---------------------------------------------------------------------------

Ani_DashSplashDrown:
		dc.w byte_18DCA-Ani_DashSplashDrown
		dc.w byte_18DCD-Ani_DashSplashDrown
		dc.w byte_18DD9-Ani_DashSplashDrown
		dc.w byte_18DE2-Ani_DashSplashDrown
		dc.w byte_18DE8-Ani_DashSplashDrown

byte_18DCA:
		dc.b  $1F,   0,	$FF

byte_18DCD:
		dc.b	3,   1,	  2,   3,   4,	 5,   6,   7,	8,   9,	$FD,   0

byte_18DD9:
		dc.b	1,  $A,	 $B,  $C,  $D,	$E,  $F, $10, $FF

byte_18DE2:
		dc.b	3, $11,	$12, $13, $14, $FC

byte_18DE8:
		dc.b	5, $16,	$17, $18, $19, $1A, $1B, $1C, $1D, $FD,	  0,   0

Map_DashDust:
		dc.w word_18E30-Map_DashDust
		dc.w word_18E32-Map_DashDust
		dc.w word_18E3A-Map_DashDust
		dc.w word_18E42-Map_DashDust
		dc.w word_18E4A-Map_DashDust
		dc.w word_18E52-Map_DashDust
		dc.w word_18E5A-Map_DashDust
		dc.w word_18E62-Map_DashDust
		dc.w word_18E6A-Map_DashDust
		dc.w word_18E72-Map_DashDust
		dc.w word_18E7A-Map_DashDust
		dc.w word_18E82-Map_DashDust
		dc.w word_18E8A-Map_DashDust
		dc.w word_18E92-Map_DashDust
		dc.w word_18E9A-Map_DashDust
		dc.w word_18EA2-Map_DashDust
		dc.w word_18EAA-Map_DashDust
		dc.w word_18EB2-Map_DashDust
		dc.w word_18EBA-Map_DashDust
		dc.w word_18EC2-Map_DashDust
		dc.w word_18ECA-Map_DashDust
		dc.w word_18E30-Map_DashDust
		dc.w word_18ED2-Map_DashDust
		dc.w word_18EDA-Map_DashDust
		dc.w word_18EDA-Map_DashDust
		dc.w word_18EDA-Map_DashDust
		dc.w word_18EDA-Map_DashDust
		dc.w word_18EDA-Map_DashDust
		dc.w word_18EDA-Map_DashDust
		dc.w word_18EDA-Map_DashDust

word_18E30:
		dc.w 0

word_18E32:
		dc.w 1
		dc.b  $F2,   9,	  0,   0, $FF, $F0

word_18E3A:
		dc.w 1
		dc.b  $E2,  $F,	  0,   0, $FF, $F0

word_18E42:
		dc.w 1
		dc.b  $E2,  $F,	  0,   0, $FF, $F0

word_18E4A:
		dc.w 1
		dc.b  $E2,  $F,	  0,   0, $FF, $F0

word_18E52:
		dc.w 1
		dc.b  $E2,  $F,	  0,   0, $FF, $F0

word_18E5A:
		dc.w 1
		dc.b  $EA,  $E,	  0,   0, $FF, $F0

word_18E62:
		dc.w 1
		dc.b  $F2,  $D,	  0,   0, $FF, $F0

word_18E6A:
		dc.w 1
		dc.b  $FA,  $C,	  0,   0, $FF, $F0

word_18E72:
		dc.w 1
		dc.b  $FA,  $C,	  0,   0, $FF, $F0

word_18E7A:
		dc.w 1
		dc.b	4,  $D,	  0,   0, $FF, $E0

word_18E82:
		dc.w 1
		dc.b	4,  $D,	  0,   0, $FF, $E0

word_18E8A:
		dc.w 1
		dc.b	4,  $D,	  0,   0, $FF, $E0

word_18E92:
		dc.w 1
		dc.b  $FC,  $E,	  0,   0, $FF, $E0

word_18E9A:
		dc.w 1
		dc.b  $FC,  $E,	  0,   0, $FF, $E0

word_18EA2:
		dc.w 1
		dc.b  $FC,  $E,	  0,   0, $FF, $E0

word_18EAA:
		dc.w 1
		dc.b  $FC,  $E,	  0,   0, $FF, $E0

word_18EB2:
		dc.w 1
		dc.b  $F8,   5,	  0,   0, $FF, $F8

word_18EBA:
		dc.w 1
		dc.b  $F8,   5,	  0,   4, $FF, $F8

word_18EC2:
		dc.w 1
		dc.b  $F8,   5,	  0,   8, $FF, $F8

word_18ECA:
		dc.w 1
		dc.b  $F8,   5,	  0,  $C, $FF, $F8

word_18ED2:
		dc.w 1
		dc.b  $E8,  $E,	  0,   0, $FF, $F0

word_18EDA:
		dc.w 1
		dc.b  $E0,  $F,	  0,   0, $FF, $F0

DPLC_DashSplashDrown:
		dc.w word_18F1E-DPLC_DashSplashDrown
		dc.w word_18F20-DPLC_DashSplashDrown
		dc.w word_18F24-DPLC_DashSplashDrown
		dc.w word_18F28-DPLC_DashSplashDrown
		dc.w word_18F2C-DPLC_DashSplashDrown
		dc.w word_18F30-DPLC_DashSplashDrown
		dc.w word_18F34-DPLC_DashSplashDrown
		dc.w word_18F38-DPLC_DashSplashDrown
		dc.w word_18F3C-DPLC_DashSplashDrown
		dc.w word_18F40-DPLC_DashSplashDrown
		dc.w word_18F44-DPLC_DashSplashDrown
		dc.w word_18F48-DPLC_DashSplashDrown
		dc.w word_18F4C-DPLC_DashSplashDrown
		dc.w word_18F50-DPLC_DashSplashDrown
		dc.w word_18F54-DPLC_DashSplashDrown
		dc.w word_18F58-DPLC_DashSplashDrown
		dc.w word_18F5C-DPLC_DashSplashDrown
		dc.w word_18F60-DPLC_DashSplashDrown
		dc.w word_18F60-DPLC_DashSplashDrown
		dc.w word_18F60-DPLC_DashSplashDrown
		dc.w word_18F60-DPLC_DashSplashDrown
		dc.w word_18F62-DPLC_DashSplashDrown
		dc.w word_18F66-DPLC_DashSplashDrown
		dc.w word_18F6A-DPLC_DashSplashDrown
		dc.w word_18F6E-DPLC_DashSplashDrown
		dc.w word_18F72-DPLC_DashSplashDrown
		dc.w word_18F76-DPLC_DashSplashDrown
		dc.w word_18F7A-DPLC_DashSplashDrown
		dc.w word_18F7E-DPLC_DashSplashDrown
		dc.w word_18F82-DPLC_DashSplashDrown

word_18F1E:
		dc.w	0

word_18F20:
		dc.w	1
		dc.w $5000

word_18F24:
		dc.w	1
		dc.w $F006

word_18F28:
		dc.w	1
		dc.w $F016

word_18F2C:
		dc.w	1
		dc.w $F026

word_18F30:
		dc.w	1
		dc.w $F036

word_18F34:
		dc.w	1
		dc.w $B046

word_18F38:
		dc.w	1
		dc.w $7052

word_18F3C:
		dc.w	1
		dc.w $305A

word_18F40:
		dc.w	1
		dc.w $305E

word_18F44:
		dc.w	1
		dc.w $7062

word_18F48:
		dc.w	1
		dc.w $706A

word_18F4C:
		dc.w	1
		dc.w $7072

word_18F50:
		dc.w	1
		dc.w $B07A

word_18F54:
		dc.w	1
		dc.w $B086

word_18F58:
		dc.w	1
		dc.w $B092

word_18F5C:
		dc.w	1
		dc.w $B09E

word_18F60:
		dc.w	0

word_18F62:
		dc.w	1
		dc.w $F0AA

word_18F66:
		dc.w	1
		dc.w $B000

word_18F6A:
		dc.w	1
		dc.w $F00C

word_18F6E:
		dc.w	1
		dc.w $F01C

word_18F72:
		dc.w	1
		dc.w $F02C

word_18F76:
		dc.w	1
		dc.w $F03C

word_18F7A:
		dc.w	1
		dc.w $F04C

word_18F7E:
		dc.w	1
		dc.w $F05C


; ---------------------------------------------------------------------------

word_18F82:
		dc.w	1
		dc.w $F06C


; ---------------------------------------------------------------------------
